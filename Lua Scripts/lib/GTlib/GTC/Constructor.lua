-- Constructor
-- by Hexarobi
-- A Lua Script for the Stand mod menu for GTA5
-- Allows for constructing custom vehicles and maps
-- https://github.com/hexarobi/stand-lua-constructor

local SCRIPT_VERSION = "0.35.2r"

---
--- Config
---

CONSTRUCTOR_CONFIG = {
    source_code_branch = "main",
    edit_offset_step = 10,
    edit_rotation_step = 15,
    add_attachment_gun_active = false,
    show_previews = true,
    preview_camera_distance = 3,
    preview_bounding_box_color = {r=255,g=0,b=255,a=255},
    deconstruct_all_spawned_constructs_on_unload = true,
    drive_spawned_vehicles = true,
    wear_spawned_peds = true,
    focus_menu_on_spawned_constructs = true,
    preview_display_delay = 500,
    max_search_results = 100,
    spawn_entity_delay = 0,
    is_final_cleanup = false,
    clean_up_distance = 500,
    num_allowed_spawned_constructs_per_player = 1,
    chat_spawnable_dir = "spawnable",
    debug_mode = false,
    auto_update = true,
    auto_update_check_interval = 86400,
    freecam_speed = 1,
    change_parent_keep_position = true,
}
-- Short local alias
local config = CONSTRUCTOR_CONFIG

local state = {}

---
--- Dependencies
---
local inspect = require "lib.GTlib.GTC.lib.inspect"

local constants = require "lib.GTlib.GTC.lib.constants"

local constructor_lib = require "lib.GTlib.GTC.lib.constructor_lib"

local convertors = require "lib.GTlib.GTC.lib.convertors"

local curated_attachments = require "lib.GTlib.GTC.lib.curated_attachments"

local translations = require "lib.GTlib.GTC.lib.translations"

---
--- Debug Log
---

local function debug_log(message, additional_details)
    if CONSTRUCTOR_CONFIG.debug_mode then
        if CONSTRUCTOR_CONFIG.debug_mode == 2 and additional_details ~= nil then
            message = message .. "\n" .. inspect(additional_details)
        end
        util.log("[Constructor] "..message)
    end
end

---
--- Translations
---

-- Shorthand wrapper for translation function
local function t(text)
    if type(CONSTRUCTOR_TRANSLATE_FUNCTION) == "function" then
        return CONSTRUCTOR_TRANSLATE_FUNCTION(text)
    else
        return text
    end
end

---
--- Data
---

local constructor = {}

local CONSTRUCTS_DIR = filesystem.scripts_dir() .."GTluaScript\\" .. 'Constructs\\'
filesystem.mkdirs(CONSTRUCTS_DIR)

local JACKZ_BUILD_DIR = filesystem.scripts_dir() .. "GTluaScript\\" .. 'Constructs\\' .. 'Builds\\'

local spawned_constructs = {}
local last_spawned_construct
local menus = {
    children = {}
}
local original_player_skin
local player_construct

--local example_construct = {
--    name="My Construct",        -- Name for this attachment
--    handle=5678,                -- Handle for this attachment (Nonserializable)
--    root={},                  -- Pointer to root construct. Root will point to itself. (Nonserializable)
--    parent={},                -- Pointer to parent construct. Root will point to itself. (Nonserializable)
--    position = { x=0, y=0, z=0 },  -- World position coords
--    offset = { x=0, y=0, z=0 },  -- Offset coords from parent
--    rotation = { x=0, y=0, z=0 },-- Rotation from parent
--    children = {
--        -- Other constructs / attachments
--    },
--    options = {
--        is_visible = true,
--        has_collision = true,
--        has_gravity = true,
--        etc...
--    },
--    is_preview = false,
--    Other meta flags used for processing...
--}

local ENTITY_TYPES = {"PED", "VEHICLE", "OBJECT"}

local SIRENS_OFF = 1
local SIRENS_LIGHTS_ONLY = 2
local SIRENS_ALL_ON = 3

---
--- Utilities
---

local function get_player_vehicle_handles()
    local player_vehicle_handles = {}
    for _, pid in pairs(players.list()) do
        local player_ped = PLAYER.GET_PLAYER_PED(pid)
        local veh = PED.GET_VEHICLE_PED_IS_IN(player_ped, false)
        if not ENTITY.IS_ENTITY_A_VEHICLE(veh) then
            veh = PED.GET_VEHICLE_PED_IS_IN(player_ped, true)
        end
        if not ENTITY.IS_ENTITY_A_VEHICLE(veh) then
            veh = 0
        end
        if veh then
            player_vehicle_handles[pid] = veh
        end
    end
    return player_vehicle_handles
end

local function is_entity_occupied(entity, type, player_vehicle_handles)
    local occupied = false
    if type == "VEHICLE" then
        for _, vehicle_handle in pairs(player_vehicle_handles) do
            if entity == vehicle_handle then
                occupied = true
            end
        end
    end
    return occupied
end

local function delete_entities_by_range(my_entities, range, type)
    local player_vehicle_handles = get_player_vehicle_handles()
    local player_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()), 1)
    local count = 0
    for _, entity in ipairs(my_entities) do
        local entity_pos = ENTITY.GET_ENTITY_COORDS(entity, 1)
        local dist = SYSTEM.VDIST(player_pos.x, player_pos.y, player_pos.z, entity_pos.x, entity_pos.y, entity_pos.z)
        if dist <= range then
            if not is_entity_occupied(entity, type, player_vehicle_handles) then
                entities.delete_by_handle(entity)
                count = count + 1
            end
        end
    end
    return count
end

local function clear_references(attachment)
    attachment.root = nil
    attachment.parent = nil
    if attachment.children then
        for _, child_attachment in pairs(attachment.children) do
            clear_references(child_attachment)
        end
    end
end

local function copy_construct_plan(construct_plan)
    local is_root = construct_plan == construct_plan.parent
    clear_references(construct_plan)
    local construct = constructor_lib.table_copy(construct_plan)
    if is_root then
        construct.root = construct
        construct.parent = construct
    end
    --constructor_lib.default_attachment_attributes(construct)
    return construct
end

local function add_attachment_to_construct(attachment)
    debug_log("Adding attachment to construct "..tostring(attachment.name), attachment)
    constructor_lib.serialize_vehicle_attributes(attachment)
    constructor_lib.add_attachment_to_construct(attachment)
    menus.rebuild_attachment_menu(attachment)
    attachment.parent.functions.refresh()
    attachment.functions.focus()
end

local function delete_menu_list(t)
    if type(t) ~= "table" then return end
    for k, h in pairs(t) do
        if h:isValid() then
            menu.delete(h)
        end
        t[k] = nil
    end
end

local function color_menu_input(input_color)
    return { r=input_color.r or 0, g=input_color.g or 0, b=input_color.b or 0, a=1 }
end

local function color_menu_output(output_color)
    return { r=math.floor(output_color.r * 255), g=math.floor(output_color.g * 255), b=math.floor(output_color.b * 255) }
end

---
--- Player Construct
---

local function save_original_player_skin()
    debug_log("Saving original player skin")
    original_player_skin = constructor_lib.table_copy(constructor_lib.construct_base)
    original_player_skin.handle = players.user_ped()
    original_player_skin.name = "Original Player Skin"
    original_player_skin.type = "PED"
    original_player_skin.is_player=true
    original_player_skin.root = original_player_skin
    original_player_skin.parent = original_player_skin
    constructor_lib.serialize_ped_attributes(original_player_skin)
    --debug_log("Saved original player skin "..inspect(original_player_skin))
end

local function restore_original_player_skin()
    debug_log("Restoring original player skin")
    if original_player_skin ~= nil then
        constructor_lib.deserialize_ped_attributes(original_player_skin)
    end
end

local function save_player_construct(construct)
    save_original_player_skin()
    player_construct = construct
end

local function create_player_construct()
    local new_player_construct = constructor_lib.table_copy(constructor_lib.construct_base)
    new_player_construct.handle=players.user_ped()
    new_player_construct.type="PED"
    new_player_construct.name="Player"
    new_player_construct.is_player=true
    new_player_construct.root = new_player_construct
    new_player_construct.parent = new_player_construct
    save_player_construct(new_player_construct)
end

local function remove_player_construct()
    if player_construct == nil then return end
    constructor.delete_construct(player_construct)
    restore_original_player_skin()
    player_construct = nil
end

local function get_player_construct()
    if player_construct == nil then
        create_player_construct()
    end
    return player_construct
end

---
--- Construct Plan Description
---

local function get_type(attachment)
    local child_type = attachment.type
    if child_type == nil then child_type = "OBJECT" end
    return child_type
end

local function count_construct_children(construct_plan, counter)
    if counter == nil then counter = {["OBJECT"]=0, ["PED"]=0, ["VEHICLE"]=0, ["PARTICLE"]=0, ["TOTAL"]=0} end
    for _, child_attachment in pairs(construct_plan.children) do
        local child_type = get_type(child_attachment)
        if counter[child_type] == nil then error("Invalid type "..tostring(child_type)) end
        counter[child_type] = counter[child_type] + 1
        counter["TOTAL"] = counter["TOTAL"] + 1
        count_construct_children(child_attachment, counter)
    end
    return counter
end

local function get_construct_plan_description(construct_plan)
    debug_log("Building construct plan description "..tostring(construct_plan.name), construct_plan)
    local descriptions = {}
    if construct_plan.name ~= nil then table.insert(descriptions, construct_plan.name) end
    table.insert(descriptions, t(get_type(construct_plan)))
    if construct_plan.temp.source_file_type ~= nil then table.insert(descriptions, t(construct_plan.temp.source_file_type)) end
    if construct_plan.author ~= nil then table.insert(descriptions, t("Created By: ")..construct_plan.author) end
    if construct_plan.description ~= nil then table.insert(descriptions, construct_plan.description) end
    local counter = count_construct_children(construct_plan)
    if counter["TOTAL"] > 0 then
        table.insert(descriptions,
                counter["TOTAL"].." "..t("attachments").." ("..counter["PED"].." "..t("peds")..", "..counter["OBJECT"].." "..t("objects")..", "..counter["VEHICLE"].." "..t("vehicles")..")")
    end
    if construct_plan.temp.filepath ~= nil then table.insert(descriptions, construct_plan.temp.filepath) end
    local description_string = ""
    for _, description in pairs(descriptions) do
        description_string = description_string .. description .. "\n"
    end
    return description_string
end

---
--- Preview Camera
---

local minVec = v3.new()
local maxVec = v3.new()

local function rotation_to_direction(rotation)
    local adjusted_rotation =
    {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction =
    {
        x = -math.sin(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)),
        y =  math.cos(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)),
        z =  math.sin(adjusted_rotation.x)
    }
    return direction
end

local function get_offset_from_camera(distance)
    if type(distance) ~= "table" then
        distance = {x=distance, y=distance, z=distance}
    end
    local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(0)
    local cam_pos = CAM.GET_FINAL_RENDERED_CAM_COORD()
    local direction = rotation_to_direction(cam_rot)
    local destination = {
        x = cam_pos.x + (direction.x * distance.x),
        y = cam_pos.y + (direction.y * distance.y),
        z = cam_pos.z + (direction.z * distance.z)
    }
    return destination
end

local function calculate_model_size(model)
    MISC.GET_MODEL_DIMENSIONS(model, minVec, maxVec)
    return (maxVec:getX() - minVec:getX()), (maxVec:getY() - minVec:getY()), (maxVec:getZ() - minVec:getZ())
end

local function calculate_construct_size(construct, child_attachment)
    if construct.dimensions == nil then construct.dimensions = {l=0, w=0, h=0, min_vec={x=0,y=0,z=0}, max_vec={x=0,y=0,z=0}} end
    if child_attachment == nil then child_attachment = construct end
    if child_attachment.offset == nil then child_attachment.offset = {x=0,y=0,z=0} end
    MISC.GET_MODEL_DIMENSIONS(child_attachment.hash, minVec, maxVec)

    --debug_log("Calc size "..inspect(child_attachment))

    construct.dimensions.min_vec.x = math.min(construct.dimensions.min_vec.x, minVec:getX() + child_attachment.offset.x)
    construct.dimensions.min_vec.y = math.min(construct.dimensions.min_vec.y, minVec:getY() + child_attachment.offset.y)
    construct.dimensions.min_vec.z = math.min(construct.dimensions.min_vec.z, minVec:getZ() + child_attachment.offset.z)

    construct.dimensions.max_vec.x = math.max(construct.dimensions.max_vec.x, maxVec:getX() + child_attachment.offset.x)
    construct.dimensions.max_vec.y = math.max(construct.dimensions.max_vec.y, maxVec:getY() + child_attachment.offset.y)
    construct.dimensions.max_vec.z = math.max(construct.dimensions.max_vec.z, maxVec:getZ() + child_attachment.offset.z)

    if child_attachment.children then
        for _, child in pairs(child_attachment.children) do
            calculate_construct_size(construct, child)
        end
    end

    construct.dimensions.l = (construct.dimensions.max_vec.x - construct.dimensions.min_vec.x)
    construct.dimensions.w = (construct.dimensions.max_vec.y - construct.dimensions.min_vec.y)
    construct.dimensions.h = (construct.dimensions.max_vec.z - construct.dimensions.min_vec.z)
end

local function calculate_camera_distance(attachment)
    if attachment.hash == nil then attachment.hash = util.joaat(attachment.model) end
    constructor_lib.load_hash_for_attachment(attachment)
    local l, w, h = calculate_model_size(attachment.hash, minVec, maxVec)
    attachment.camera_distance = math.max(l, w, h) + config.preview_camera_distance
    calculate_construct_size(attachment)
    attachment.camera_distance = math.max(attachment.dimensions.l, attachment.dimensions.w, attachment.dimensions.h) + config.preview_camera_distance
end

---
--- Preview
---

local spawned_previews = {}
local current_preview
local next_preview
local image_preview

local function cleanup_previews_tick()
    --debug_log("Cleanup previews tick. Checking "..#spawned_previews.." spawned previews.")
    constructor_lib.array_remove(spawned_previews, function(t, i)
        local spawned_preview = t[i]
        if spawned_preview ~= current_preview then
            --debug_log("Removing preview "..tostring(spawned_preview.name))
            constructor_lib.remove_attachment(spawned_preview)
            return false
        else
            ENTITY.FREEZE_ENTITY_POSITION(spawned_preview.handle, true)
        end
        return true
    end)
end

local function remove_preview(construct_plan)
    next_preview = nil
    image_preview = nil
    if construct_plan ~= nil  then
        --debug_log("Removing preview "..tostring(construct_plan.name))
        if current_preview == construct_plan then
            current_preview = nil
        end
    else
        current_preview = nil
    end
    --debug_log("Current Preview. current_preview "..inspect(current_preview))
end


local function add_preview(construct_plan, preview_image_path)
    if config.show_previews == false then return end
    remove_preview(construct_plan)
    if construct_plan == nil then return end
    debug_log("Adding preview for "..tostring(construct_plan.name), construct_plan)
    if construct_plan.always_spawn_at_position then
        if filesystem.exists(preview_image_path) then image_preview = directx.create_texture(preview_image_path) end
        return
    end
    next_preview = construct_plan
    util.yield(config.preview_display_delay)
    if next_preview == construct_plan then
        local attachment = copy_construct_plan(construct_plan)
        if construct_plan.type == "PED" then
            constructor_lib.use_player_ped_attributes_as_base(attachment)
        elseif construct_plan.type == "PARTICLE" then
            attachment = {model="ng_proc_cigbuts02a", children={attachment}}
        end
        attachment.root = attachment
        attachment.parent = attachment
        attachment.is_preview = true
        constructor_lib.default_attachment_attributes(attachment)
        calculate_camera_distance(attachment)
        attachment.position = get_offset_from_camera(attachment.camera_distance)
        local spawned_preview = constructor_lib.create_entity_with_children(attachment)
        if not spawned_preview then
            util.toast("There was a problem loading construct preview", TOAST_ALL)
            return
        end
        util.yield_once()
        if next_preview == construct_plan then
            current_preview = spawned_preview
            if construct_plan.load_menu and construct_plan.load_menu:isValid() then
                menu.set_help_text(construct_plan.load_menu, get_construct_plan_description(current_preview))
            end
        end
        table.insert(spawned_previews, spawned_preview)
    end
end

---
--- Tick Handlers
---

local function update_preview_tick()
    if current_preview ~= nil then
        --debug_log("Update preview tick")
        current_preview.position = get_offset_from_camera(current_preview.camera_distance)
        current_preview.rotation.z = current_preview.rotation.z + 2
        constructor_lib.attach_entity(current_preview)
        constructor_lib.update_attachment_position(current_preview)
        constructor_lib.draw_bounding_box(current_preview.handle, config.preview_bounding_box_color)
        constructor_lib.draw_bounding_box_with_dimensions(current_preview.handle, config.preview_bounding_box_color, current_preview.dimensions.min_vec, current_preview.dimensions.max_vec)
        constructor_lib.completely_disable_attachment_collision(current_preview)
        constructor_lib.update_particles_tick(current_preview)
    end
    if image_preview ~= nil then
        directx.draw_texture(image_preview, 0.10, 0.10, 0.5, 0.5, 0.5, 0.5, 0, 1, 1, 1, 1)
    end
    cleanup_previews_tick()
end

local function update_attachment_tick(attachment)
    --debug_log("Updating attachment tick "..attachment.name)
    constructor_lib.update_attachment_tick(attachment)
    for _, child_attachment in pairs(attachment.children) do
        if child_attachment == attachment then error("Invalid child attachment") end
        update_attachment_tick(child_attachment)
    end
end

local function update_constructs_tick()
    for _, spawned_construct in pairs(spawned_constructs) do
        update_attachment_tick(spawned_construct)
    end
end

local function get_aim_info()
    local outptr = memory.alloc(4)
    local success = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), outptr)
    local aim_info = {handle=0}
    if success then
        local handle = memory.read_int(outptr)
        if ENTITY.DOES_ENTITY_EXIST(handle) then
            aim_info.handle = handle
        end
        if ENTITY.GET_ENTITY_TYPE(handle) == 1 then
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(handle, false)
            if vehicle ~= 0 then
                if VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1) then
                    handle = vehicle
                    aim_info.handle = handle
                end
            end
        end
        aim_info.hash = ENTITY.GET_ENTITY_MODEL(handle)
        aim_info.model = util.reverse_joaat(aim_info.hash)
        aim_info.health = ENTITY.GET_ENTITY_HEALTH(handle)
        aim_info.type = ENTITY_TYPES[ENTITY.GET_ENTITY_TYPE(handle)]
    end
    --memory.free(outptr)
    return aim_info
end

local was_key_down = false
local function aim_info_tick()
    if not config.add_attachment_gun_active then return end
    --debug_log("Attachment gun tick")
    local info = get_aim_info()
    if info.handle ~= 0 then
        local text = "Shoot (or press J) to add " .. info.type .. " `" .. info.model .. "` to construct " .. config.add_attachment_gun_recipient.name
        directx.draw_text(0.5, 0.3, text, 5, 0.5, {r=1,g=1,b=1,a=1}, true)
        constructor_lib.draw_bounding_box(info.handle, config.preview_bounding_box_color)
        if util.is_key_down(0x4A) or PED.IS_PED_SHOOTING(players.user_ped()) then
            if was_key_down == false then
                util.toast("Attaching "..info.model)
                add_attachment_to_construct({
                    parent=config.add_attachment_gun_recipient,
                    root=config.add_attachment_gun_recipient.root,
                    hash=info.hash,
                    model=info.model,
                })
                config.add_attachment_gun_recipient.root.functions.refresh()
            end
            was_key_down = true
        else
            was_key_down = false
        end
    end
end

local function set_attachment_edit_menu_sensitivity(attachment, offset_step, rotation_step)
    if attachment.menus ~= nil then
        if attachment == attachment.root then
            if attachment.menus.edit_position_x ~= nil then
                menu.set_step_size(attachment.menus.edit_position_x, offset_step)
                menu.set_step_size(attachment.menus.edit_position_y, offset_step)
                menu.set_step_size(attachment.menus.edit_position_z, offset_step)
                menu.set_step_size(attachment.menus.edit_world_rotation_x, rotation_step)
                menu.set_step_size(attachment.menus.edit_world_rotation_y, rotation_step)
                menu.set_step_size(attachment.menus.edit_world_rotation_z, rotation_step)
            end
        else
            if attachment.menus.edit_offset_x ~= nil then
                menu.set_step_size(attachment.menus.edit_offset_x, offset_step)
                menu.set_step_size(attachment.menus.edit_offset_y, offset_step)
                menu.set_step_size(attachment.menus.edit_offset_z, offset_step)
                menu.set_step_size(attachment.menus.edit_rotation_x, rotation_step)
                menu.set_step_size(attachment.menus.edit_rotation_y, rotation_step)
                menu.set_step_size(attachment.menus.edit_rotation_z, rotation_step)
            end
        end
    end
    for _, child_attachment in pairs(attachment.children) do
        if child_attachment == attachment then error("Invalid child attachment") end
        set_attachment_edit_menu_sensitivity(child_attachment, offset_step, rotation_step)
    end
end

local edit_sensitivity_state = "normal"
local function sensitivity_modifier_check_tick()
    if util.is_key_down(0x10) then
        if edit_sensitivity_state ~= "fine" then
            for _, construct in pairs(spawned_constructs) do
                set_attachment_edit_menu_sensitivity(construct, 1, 1)
            end
            edit_sensitivity_state = "fine"
        end
    elseif util.is_key_down(0x11) then
        if edit_sensitivity_state ~= "coarse" then
            for _, construct in pairs(spawned_constructs) do
                set_attachment_edit_menu_sensitivity(construct, config.edit_offset_step * 10, config.edit_rotation_step * 10)
            end
            edit_sensitivity_state = "coarse"
        end
    else
        if edit_sensitivity_state ~= "normal" then
            for _, construct in pairs(spawned_constructs) do
                set_attachment_edit_menu_sensitivity(construct, config.edit_offset_step, config.edit_rotation_step)
            end
            edit_sensitivity_state = "normal"
        end
    end
end

local function draw_editing_bounding_box(attachment)
    if attachment.is_editing and menu.is_open() then
        --debug_log("Drawing bounding box tick "..attachment.name)
        constructor_lib.draw_bounding_box(attachment.handle, config.preview_bounding_box_color)
    end
    for _, child_attachment in pairs(attachment.children) do
        if child_attachment == attachment then error("Invalid child attachment") end
        draw_editing_bounding_box(child_attachment)
    end
end

local function draw_editing_attachment_bounding_box_tick()
    for _, construct in pairs(spawned_constructs) do
        draw_editing_bounding_box(construct)
    end
end

---
--- Gizmo Edit
---

local gizmo_scale = 0.02
local colour = {r = 255, g = 0, b = 255, a = 255}
local current_gizmo_entity = -1
local grabbed_gizmo_index = -1

local function gizmo_edit_mode_tick()
    if not state.gizmo_edit_mode then return end
    GRAPHICS.SET_DEPTHWRITING(true)
    HUD.SET_MOUSE_CURSOR_THIS_FRAME()

    PAD.DISABLE_CONTROL_ACTION(2, 25, true) --aim
    PAD.DISABLE_CONTROL_ACTION(2, 24, true) --attack
    PAD.DISABLE_CONTROL_ACTION(2, 257, true) --attack2
    if PAD.IS_DISABLED_CONTROL_PRESSED(2, 25) then return true end

    PAD.DISABLE_CONTROL_ACTION(2, 1, true) --look lr
    PAD.DISABLE_CONTROL_ACTION(2, 2, true) --look ud

    local mouse_dir = constructor_lib.get_mouse_cursor_dir()

    if current_gizmo_entity ~= -1 then
        local cam_dir = CAM.GET_FINAL_RENDERED_CAM_ROT(2):toDir()
        local gizmos = constructor_lib.get_gizmos(current_gizmo_entity)
        local hovered_gizmo = constructor_lib.get_gizmo_hovered(gizmos, gizmo_scale)

        if hovered_gizmo.index ~= -1 and PAD.IS_DISABLED_CONTROL_JUST_PRESSED(2, 237) then
            grabbed_gizmo_index = hovered_gizmo.index
        elseif PAD.IS_DISABLED_CONTROL_JUST_RELEASED(2, 237) then
            grabbed_gizmo_index = -1
        end

        for i, g in ipairs(gizmos) do
            g.colour = colour
            if i == hovered_gizmo.index or i == grabbed_gizmo_index then
                g.colour = {r = 255, g = 255, b = 255, a = 255}
            end
        end

        if grabbed_gizmo_index ~= -1 then
            gizmos = {gizmos[grabbed_gizmo_index]}
            local grabbed_gizmo = gizmos[1]
            local gizmo_dir = grabbed_gizmo.rot:mul_v3(v3.new(0, 0, 1))
            local point = constructor_lib.closest_point_on_lines(gizmo_dir, mouse_dir, grabbed_gizmo.pos, CAM.GET_FINAL_RENDERED_CAM_COORD())
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(current_gizmo_entity,point.x - grabbed_gizmo.offset.x, point.y - grabbed_gizmo.offset.y, point.z - grabbed_gizmo.offset.z, false, false, false)
        end

        constructor_lib.draw_all_gizmos(gizmos, gizmo_scale)
    end

    if grabbed_gizmo_index == -1 and PAD.IS_DISABLED_CONTROL_JUST_PRESSED(2, 237) then
        ENTITY.FREEZE_ENTITY_POSITION(current_gizmo_entity, false)
        PHYSICS.ACTIVATE_PHYSICS(current_gizmo_entity)
        current_gizmo_entity = constructor_lib.get_ent_clicked_on(mouse_dir)
        ENTITY.FREEZE_ENTITY_POSITION(current_gizmo_entity, true)
    end
    GRAPHICS.SET_DEPTHWRITING(false)
    return true
end

---
--- Free Edit
---

local free_edit_cam
local world_up = v3.new(0, 0, 1)
local function get_cam_vectors()
    local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
    local forward = v3.toDir(cam_rot)
    local right = v3.crossProduct(forward, world_up)
    right:normalise()
    local up = v3.crossProduct(right, forward)
    return forward, right, up
end

local free_edit_mode_tick = function()
    if not config.free_edit_mode then return true end
    local attachment = config.free_edit_attachment
    local forward, right, up = get_cam_vectors()
    --local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(free_edit_cam, 0, -2, -2)
    --attachment.position = {x=pos.x, y=pos.y, z=pos.z}
    --attachment.position = get_offset_from_camera({x=0, y=2, z=2})

    local camera_sensitivity = 2

    local cam_pos = CAM.GET_FINAL_RENDERED_CAM_COORD()
    attachment.position = {
        x = cam_pos.x + (forward.x * camera_sensitivity) + (up.x * camera_sensitivity),
        y = cam_pos.y + (forward.y * camera_sensitivity) + (up.x * camera_sensitivity),
        z = cam_pos.z + (forward.z * camera_sensitivity) + (up.x * camera_sensitivity)
    }

    --debug_log("Setting pos "..attachment.name.." to "..inspect(attachment.position))
    constructor_lib.move_attachment(attachment)

    local sensitivity = 0.3

    if PAD.IS_DISABLED_CONTROL_PRESSED(2, 32) then
        --local offset = get_offset_from_cam_in_world_coords(cam, {x=1,y=0,z=0})
        local cam_pos = CAM.GET_CAM_COORD(free_edit_cam, 2)
        local new_cam_pos = v3(cam_pos.x + (forward.x * sensitivity), cam_pos.y + (forward.y * sensitivity), cam_pos.z + (forward.z * sensitivity))
        CAM.SET_CAM_COORD(free_edit_cam, new_cam_pos.x, new_cam_pos.y, new_cam_pos.z)
    end
    if PAD.IS_DISABLED_CONTROL_PRESSED(2, 33) then
        local cam_pos = CAM.GET_CAM_COORD(free_edit_cam, 2)
        local new_cam_pos = v3(cam_pos.x - (forward.x * sensitivity), cam_pos.y - (forward.y * sensitivity), cam_pos.z - (forward.z * sensitivity))
        CAM.SET_CAM_COORD(free_edit_cam, new_cam_pos.x, new_cam_pos.y, new_cam_pos.z)
    end
    if PAD.IS_DISABLED_CONTROL_PRESSED(2, 35) then
        local cam_pos = CAM.GET_CAM_COORD(free_edit_cam, 2)
        local new_cam_pos = v3(cam_pos.x + (right.x * sensitivity), cam_pos.y + (right.y * sensitivity), cam_pos.z + (right.z * sensitivity))
        CAM.SET_CAM_COORD(free_edit_cam, new_cam_pos.x, new_cam_pos.y, new_cam_pos.z)
    end
    if PAD.IS_DISABLED_CONTROL_PRESSED(2, 34) then
        local cam_pos = CAM.GET_CAM_COORD(free_edit_cam, 2)
        local new_cam_pos = v3(cam_pos.x - (right.x * sensitivity), cam_pos.y - (right.y * sensitivity), cam_pos.z - (right.z * sensitivity))
        CAM.SET_CAM_COORD(free_edit_cam, new_cam_pos.x, new_cam_pos.y, new_cam_pos.z)
    end
    if PAD.IS_DISABLED_CONTROL_PRESSED(2, 22) then
        local cam_pos = CAM.GET_CAM_COORD(free_edit_cam, 2)
        local new_cam_pos = v3(cam_pos.x + (up.x * sensitivity), cam_pos.y + (up.y * sensitivity), cam_pos.z + (up.z * sensitivity))
        CAM.SET_CAM_COORD(free_edit_cam, new_cam_pos.x, new_cam_pos.y, new_cam_pos.z)
    end
    if PAD.IS_DISABLED_CONTROL_PRESSED(2, 36) then
        local cam_pos = CAM.GET_CAM_COORD(free_edit_cam, 2)
        local new_cam_pos = v3(cam_pos.x - (up.x * sensitivity), cam_pos.y - (up.y * sensitivity), cam_pos.z - (up.z * sensitivity))
        CAM.SET_CAM_COORD(free_edit_cam, new_cam_pos.x, new_cam_pos.y, new_cam_pos.z)
    end

    local move_lr, move_ud = PAD.GET_CONTROL_NORMAL(2, 1), PAD.GET_CONTROL_NORMAL(2, 2)
    local cam_rot = CAM.GET_CAM_ROT(free_edit_cam, 2)
    if move_ud ~= 0 then
        cam_rot = v3(cam_rot.x - (move_ud * 5), cam_rot.y, cam_rot.z)
    end
    if move_lr ~= 0 then
        cam_rot = v3(cam_rot.x, cam_rot.y, cam_rot.z - (move_lr * 5))
    end
    CAM.SET_CAM_ROT(free_edit_cam, cam_rot.x, cam_rot.y, cam_rot.z, 2)

    return true
end


local function create_free_edit_cam(attachment)
    --menu.trigger_commands("freecam on")
    constructor_lib.serialize_entity_attributes(attachment)
    local cam_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(attachment.handle, 0, 2, 2)
    free_edit_cam = CAM.CREATE_CAM_WITH_PARAMS(
        "DEFAULT_SCRIPTED_CAMERA",
        cam_pos.x, cam_pos.y, cam_pos.z,
        0.0, 0.0, 0.0, 70.0, false, false
    )
    CAM.POINT_CAM_AT_ENTITY(free_edit_cam, attachment.handle, 0, 0, 0, true)
    CAM.SET_CAM_ACTIVE(free_edit_cam, true)
    CAM.RENDER_SCRIPT_CAMS(true, true, 1000, true, true, 0)
    util.yield(1000)
    CAM.STOP_CAM_POINTING(free_edit_cam)
end

local function destroy_free_edit_cam()
    --menu.trigger_commands("freecam off")
    --CAM.SET_CAM_ACTIVE(free_edit_cam, false)
    CAM.RENDER_SCRIPT_CAMS(false, false, 1000, true, false, 0)
    --util.yield(1000)
    CAM.DESTROY_CAM(free_edit_cam, true)
end

local function free_edit_attachment(attachment)
    ENTITY.FREEZE_ENTITY_POSITION(attachment.root.handle, true)
    if attachment.options.is_attached then
        config.free_edit_parent = attachment.parent
        constructor_lib.separate_attachment(attachment)
    else
        config.free_edit_parent = nil
    end
    config.free_edit_attachment = attachment
    create_free_edit_cam(attachment)
    config.free_edit_mode = true
    constructor_lib.serialize_entity_attributes(attachment)
end

local function clear_free_edit_attachment()
    if config.free_edit_attachment then
        if config.free_edit_parent then
            constructor_lib.join_attachments(config.free_edit_parent, config.free_edit_attachment)
            constructor.refresh_position_menu(config.free_edit_attachment)
        end
        ENTITY.FREEZE_ENTITY_POSITION(config.free_edit_attachment.root.handle, false)
        config.free_edit_attachment = nil
    end
    config.free_edit_mode = false
    destroy_free_edit_cam()
end

---
--- Player Spawn Management

local players_spawned_constructs = {}

local function get_player_spawned_constructs(pid)
    for _, player_spawned_construct in pairs(players_spawned_constructs) do
        if player_spawned_construct.pid == pid then
            return player_spawned_construct
        end
    end
    local new_player_spawned_construct = {pid=pid, constructs={}}
    table.insert(players_spawned_constructs, new_player_spawned_construct)
    return new_player_spawned_construct
end

local function remove_tracked_construct_for_player(pid)
    local player_spawned_constructs = get_player_spawned_constructs(pid)
    if #player_spawned_constructs.constructs >= config.num_allowed_spawned_constructs_per_player then
        constructor.delete_construct(player_spawned_constructs.constructs[1])
        table.remove(player_spawned_constructs.constructs, 1)
    end
end

local function track_construct_spawn_for_player(pid, construct)
    local player_spawned_constructs = get_player_spawned_constructs(pid)
    table.insert(player_spawned_constructs.constructs, construct)
end


---
--- Construct Management
---

local function add_spawned_construct(construct)
    debug_log("Adding spawned construct to list "..tostring(construct.name))
    constructor_lib.default_attachment_attributes(construct)
    table.insert(spawned_constructs, construct)
    if construct.options.spawn_for_player then track_construct_spawn_for_player(construct.options.spawn_for_player, construct) end
    last_spawned_construct = construct
end

local function create_construct_from_vehicle(vehicle_handle)
    debug_log("Creating construct from vehicle handle "..tostring(vehicle_handle))
    for _, construct in pairs(spawned_constructs) do
        if construct.handle == vehicle_handle then
            util.toast("Vehicle is already a construct")
            if menu.is_ref_valid(construct.menus.info) then
                menu.focus(construct.menus.info)
            end
            return
        end
    end
    local construct = copy_construct_plan(constructor_lib.construct_base)
    construct.type = "VEHICLE"
    construct.handle = vehicle_handle
    construct.root = construct
    construct.parent = construct
    construct.hash = ENTITY.GET_ENTITY_MODEL(vehicle_handle)
    construct.model = VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(construct.hash)
    constructor_lib.default_attachment_attributes(construct)
    constructor_lib.serialize_attachment(construct)
    add_spawned_construct(construct)
    return construct
end

local function write_file(filepath, content)
    local file = io.open(filepath, "wb")
    if not file then error("Cannot write to file " .. filepath, TOAST_ALL) end
    file:write(content)
    file:close()
end

local function write_json_file(filepath, object)
    local encode_status, content = pcall(soup.json.encode, object)
    if not encode_status then
        util.toast("Error encoding object: "..content)
        debug_log("Error encoding object: "..content.." object: "..inspect(object))
    end
    if content == "" or (not string.startswith(content, "{")) then
        util.toast("Cannot save object as JSON: Error serializing.", TOAST_ALL)
        return
    end
    write_file(filepath, content)
end

local function set_save_defaults(construct)
    if construct.author == nil then construct.author = players.get_name(players.user()) end
    if construct.created == nil then construct.created = os.date("!%Y-%m-%dT%H:%M:%SZ") end
    if construct.version == nil then construct.version = "Constructor "..VERSION_STRING end
end

local function save_vehicle(construct)
    debug_log("Saving construct "..tostring(construct.name), construct)
    set_save_defaults(construct)
    local filepath = CONSTRUCTS_DIR .. construct.name .. ".json"
    local serialized_construct = constructor_lib.serialize_attachment(construct)
    --debug_log("Serialized construct "..inspect(serialized_construct))
    write_json_file(filepath, serialized_construct)
    util.toast("Saved ".. construct.name)
    util.log("Saved ".. construct.name .. " to " ..filepath)
    menus.rebuild_load_construct_menu()
end

---
--- Construct Spawners
---

constructor.delete_construct =  function(construct)
    debug_log("Deleting construct "..tostring(construct.name), construct)
    constructor_lib.remove_attachment_from_parent(construct)
    if construct.is_player then
        restore_original_player_skin()
        if player_construct ~= nil then
            restore_original_player_skin()
            player_construct = nil
        end
    end
    constructor_lib.array_remove(spawned_constructs, function(t, i)
        local spawned_construct = t[i]
        return spawned_construct ~= construct
    end)
    menus.refresh_loaded_constructs()
end

local function set_spawned_construct_position(construct)
    calculate_camera_distance(construct)
    if not construct.always_spawn_at_position then
        if construct.options.spawn_for_player then
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(construct.options.spawn_for_player)
            local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, 0, construct.camera_distance - config.preview_camera_distance, 0)
            construct.position = { x=pos.x, y=pos.y, z=pos.z }
            construct.world_rotation = { x=0, y=0, z=ENTITY.GET_ENTITY_HEADING(target_ped) }
        else
            construct.position = get_offset_from_camera(construct.camera_distance)
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
            construct.heading = ENTITY.GET_ENTITY_HEADING(target_ped)
        end
    end
end

local function spawn_construct_from_plan(construct_plan)
    debug_log("Spawning construct from plan "..tostring(construct_plan.name), construct_plan)
    local construct = copy_construct_plan(construct_plan)
    constructor_lib.default_attachment_attributes(construct)
    if construct_plan.type == "PED" and config.wear_spawned_peds then construct.is_player = true end
    if construct.is_player then
        remove_player_construct()
        save_player_construct(construct)
        constructor_lib.use_player_ped_attributes_as_base(construct)
    else
        set_spawned_construct_position(construct)
    end
    if construct.options.spawn_for_player then remove_tracked_construct_for_player(construct.options.spawn_for_player) end
    construct.root = construct
    construct.parent = construct
    constructor_lib.reattach_attachment_with_children(construct)
    if not construct.handle then error("Failed to spawn construct from plan "..tostring(construct.name)) end
    add_spawned_construct(construct)
    constructor_lib.clear_all_internal_collisions(construct)
    if not construct.options.is_frozen then
        ENTITY.FREEZE_ENTITY_POSITION(construct.handle, false)  --Unfreeze after spawning
    end
    constructor_lib.deserialize_vehicle_attributes(construct)   -- Re-deserialize to make sure invis wheels are applied
    OBJECT.PLACE_OBJECT_ON_GROUND_OR_OBJECT_PROPERLY(construct.handle)
    menus.refresh_loaded_constructs()
    menus.rebuild_attachment_menu(construct)
    construct.functions.refresh()
    if construct.root.menu_auto_focus ~= false and config.focus_menu_on_spawned_constructs ~= false then
        construct.functions.focus()
    end
    if construct.type == "VEHICLE" and config.drive_spawned_vehicles and construct.options.spawn_for_player == nil then
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), construct.handle, -1)
    end
    --constructor_lib.set_attachment_visibility(construct)
    return construct
end

local function build_construct_from_plan(construct_plan)
    debug_log("Building construct from plan name="..tostring(construct_plan.name).." model="..tostring(construct_plan.model).." "..debug.traceback(), construct_plan)
    if construct_plan == construct_plan.parent then
        spawn_construct_from_plan(construct_plan)
    else
        add_attachment_to_construct(construct_plan)
    end
end

local function add_attachment_from_vehicle_handle(parent_attachment, vehicle_handle)
    debug_log("Adding attachment from vehicle handle "..tostring(vehicle_handle))
    local attachment = {}
    attachment.type = "VEHICLE"
    attachment.handle = vehicle_handle
    attachment.root = parent_attachment.root
    attachment.parent = parent_attachment
    attachment.hash = ENTITY.GET_ENTITY_MODEL(vehicle_handle)
    attachment.model = VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(attachment.hash)
    table.insert(parent_attachment.children, attachment)
    constructor_lib.default_attachment_attributes(attachment)
    constructor_lib.serialize_attachment_attributes(attachment)
    menus.rebuild_attachment_menu(attachment)
    attachment.root.functions.refresh()
    attachment.functions.focus()
    return attachment
end

local function cleanup_constructs_handler()
    if config.deconstruct_all_spawned_constructs_on_unload then
        config.is_final_cleanup = true
        for _, construct in pairs(spawned_constructs) do
            constructor.delete_construct(construct)
        end
    end
end

local function rebuild_attachment(attachment)
    debug_log("Rebuilding "..tostring(attachment.name))
    attachment.root.menu_auto_focus = false
    local construct_plan = constructor_lib.clone_attachment(attachment)
    constructor.delete_construct(attachment)
    construct_plan.root.menu_auto_focus = true
    build_construct_from_plan(construct_plan)
end

---
--- Siren Controls
---

local function activate_attachment_lights(attachment)
    if attachment.options.is_light_disabled then
        ENTITY.SET_ENTITY_LIGHTS(attachment.handle, true)
    else
        VEHICLE.SET_VEHICLE_SIREN(attachment.handle, true)
        VEHICLE.SET_VEHICLE_HAS_MUTED_SIRENS(attachment.handle, true)
        ENTITY.SET_ENTITY_LIGHTS(attachment.handle, false)
        AUDIO.TRIGGER_SIREN_AUDIO(attachment.handle, true)
        AUDIO.SET_SIREN_BYPASS_MP_DRIVER_CHECK(attachment.handle, true)
    end
    for _, child_attachment in pairs(attachment.children) do
        activate_attachment_lights(child_attachment)
    end
end

local function deactivate_attachment_lights(attachment)
    ENTITY.SET_ENTITY_LIGHTS(attachment.handle, true)
    AUDIO.SET_SIREN_BYPASS_MP_DRIVER_CHECK(attachment.handle, false)
    VEHICLE.SET_VEHICLE_SIREN(attachment.handle, false)
    for _, child_attachment in pairs(attachment.children) do
        deactivate_attachment_lights(child_attachment)
    end
end

local function activate_attachment_sirens(attachment)
    if attachment.type == "VEHICLE" and attachment.options.has_siren then
        VEHICLE.SET_VEHICLE_HAS_MUTED_SIRENS(attachment.handle, false)
        VEHICLE.SET_VEHICLE_SIREN(attachment.handle, true)
        AUDIO.TRIGGER_SIREN_AUDIO(attachment.handle, true)
        AUDIO.SET_SIREN_BYPASS_MP_DRIVER_CHECK(attachment.handle, true)
    end
    for _, child_attachment in pairs(attachment.children) do
        activate_attachment_sirens(child_attachment)
    end
end

local function activate_vehicle_sirens(parent_attachment)
    -- Vehicle sirens are networked silent without a ped, but adding a ped makes them audible to others
    for _, attachment in pairs(parent_attachment.children) do
        if attachment.type == "VEHICLE" and attachment.options.has_siren then
            local child_attachment = constructor_lib.create_entity({
                root=parent_attachment,
                parent=attachment,
                name=parent_attachment.name .. " Driver",
                model="s_m_m_pilot_01",
                type="PED",
                options={is_visible=false, has_collision=false, is_temporary=true},
                ped_attributes={is_seated=true, is_silent=true},
            })
            table.insert(attachment.children, child_attachment)
        end
    end
    activate_attachment_sirens(parent_attachment)
end

local function refresh_vehicle_sirens(attachment)
    if attachment.options.has_siren and attachment ~= attachment.parent then
        rebuild_attachment(attachment)
    else
        for _, child_attachment in attachment.children do
            refresh_vehicle_sirens(child_attachment)
        end
    end
end

local function deactivate_vehicle_sirens(attachment)
    -- Once a vehicle has a ped in it with sirens on they cant be turned back off, so despawn and respawn fresh vehicle
    refresh_vehicle_sirens(attachment)
end

local function refresh_siren_status(attachment)
    attachment.root.menu_auto_focus = false
    if attachment.options.siren_status == SIRENS_OFF then
        deactivate_attachment_lights(attachment)
        deactivate_vehicle_sirens(attachment)
    elseif attachment.options.siren_status == SIRENS_LIGHTS_ONLY then
        deactivate_vehicle_sirens(attachment)
        activate_attachment_lights(attachment)
    elseif attachment.options.siren_status == SIRENS_ALL_ON then
        activate_attachment_lights(attachment)
        activate_vehicle_sirens(attachment)
    end
    attachment.root.menu_auto_focus = true
end

---
--- File Loaders
---

local function read_file(filepath)
    local file, err = io.open(filepath, "r")
    if file then
        local status, data = pcall(function() return file:read("*a") end)
        if not status then
            util.toast("Invalid construct file. "..filepath, TOAST_ALL)
            return
        end
        file:close()
        return data
    else
        error("Could not read file '" .. filepath .. "': " .. err, TOAST_ALL)
    end
end

local function load_construct_plan_from_xml_file(construct_plan_file)
    local data = read_file(construct_plan_file.filepath)
    if not data then return end
    local construct_plan = convertors.convert_xml_to_construct_plan(data)
    if not construct_plan then
        util.toast("Failed to load XML file: ".. construct_plan_file.filepath, TOAST_ALL)
        return
    end
    return construct_plan
end

local function load_construct_plan_from_ini_file(construct_plan_file)
    local construct_plan = convertors.convert_ini_to_construct_plan(construct_plan_file)
    if not construct_plan then
        util.toast("Failed to load INI file: "..construct_plan_file.filepath, TOAST_ALL)
        return
    end
    return construct_plan
end

local function load_construct_plan_from_json_file(construct_plan_file)
    local construct_plan = convertors.convert_json_to_construct_plan(construct_plan_file)
    if not construct_plan then
        util.toast("Failed to load JSON file: "..construct_plan_file.filepath, TOAST_ALL)
        return
    end
    return construct_plan
end

local function is_file_type_supported(file_extension)
    return (file_extension == "json" or file_extension == "xml" or file_extension == "ini")
end

local function load_construct_plan_file(construct_plan_file)
    debug_log("Loading construct plan file from "..tostring(construct_plan_file.filepath), construct_plan_file)
    local construct_plan
    if construct_plan_file.ext == "json" then
        construct_plan = load_construct_plan_from_json_file(construct_plan_file)
    elseif construct_plan_file.ext == "xml" then
        construct_plan = load_construct_plan_from_xml_file(construct_plan_file)
        construct_plan.name = construct_plan_file.filename
    elseif construct_plan_file.ext == "ini" then
        construct_plan = load_construct_plan_from_ini_file(construct_plan_file)
    end
    if not construct_plan then return end
    if construct_plan.name == nil then construct_plan.name = construct_plan_file.filename or "Unknown" end
    if not construct_plan or (construct_plan.hash == nil and construct_plan.model == nil and not construct_plan.is_player) then
        util.toast(t("Failed to load construct from file ")..construct_plan_file.filepath, TOAST_ALL)
        debug_log("Failed to load construct \nPlan:"..inspect(construct_plan_file).."\nLoaded construct plan "..inspect(construct_plan))
        return
    end
    if construct_plan_file.load_menu ~= nil then construct_plan.load_menu = construct_plan_file.load_menu end
    construct_plan.temp.filepath = construct_plan_file.filepath
    debug_log("Loaded construct plan "..tostring(construct_plan.name), construct_plan)
    return construct_plan
end

local function load_construct_plans_files_from_dir(directory)
    local construct_plan_files = {}
    for _, filepath in ipairs(filesystem.list_files(directory)) do
        if filesystem.is_dir(filepath) then
            local _, dirname = string.match(filepath, "(.-)([^\\/]-%.?)$")
            local dir_file = {
                is_directory=true,
                filepath=filepath,
                filename=dirname,
                name=dirname,
            }
            table.insert(construct_plan_files, dir_file)
        else
            local _, filename, ext = string.match(filepath, "(.-)([^\\/]-%.?)[.]([^%.\\/]*)$")
            if is_file_type_supported(ext) then
                local construct_plan_file = {
                    is_directory=false,
                    filepath=filepath,
                    filename=filename,
                    name=filename,
                    ext=ext,
                    preview_image_path = directory .. "/" .. filename .. ".png",
                }
                table.insert(construct_plan_files, construct_plan_file)
            end
        end
    end
    return construct_plan_files
end

local function load_all_construct_plan_files_from_dir(directory)
    if not filesystem.exists(directory) then return {} end
    local construct_plan_files = load_construct_plans_files_from_dir(directory)
    for _, filepath in ipairs(filesystem.list_files(directory)) do
        if filesystem.is_dir(filepath) then
            for _, construct_plan_file in pairs(load_all_construct_plan_files_from_dir(filepath)) do
                table.insert(construct_plan_files, construct_plan_file)
            end
        end
    end
    return construct_plan_files
end

local function search_constructs(directory, query, results)
    if results == nil then results = {} end
    if #results > config.max_search_results then return results end
    for _, filepath in ipairs(filesystem.list_files(directory)) do
        if filesystem.is_dir(filepath) then
            search_constructs(filepath, query, results)
        else
            if string.match(filepath:lower(), query:lower()) then
                local _, filename, ext = string.match(filepath, "(.-)([^\\/]-%.?)[.]([^%.\\/]*)$")
                if is_file_type_supported(ext) then
                    local construct_plan_file = {
                        is_directory=false,
                        filepath=filepath,
                        filename=filename,
                        name=filename,
                        ext=ext,
                        preview_image_path = directory .. "/" .. filename .. ".png",
                    }
                    table.insert(results, construct_plan_file)
                end
            end
        end
    end
    return results
end

---
--- Ped Animation
---

local function animate_peds(attachment)
    debug_log("Animating peds "..tostring(attachment.name), attachment)
    if attachment.type == "PED" and attachment.ped_attributes ~= nil then
        if attachment.ped_attributes.animation_dict then
            debug_log("Rebuilding ped "..attachment.name)
            local construct_plan = constructor_lib.clone_attachment(attachment)
            constructor.delete_construct(attachment)
            construct_plan.root.menu_auto_focus = false
            build_construct_from_plan(construct_plan)
            construct_plan.root.menu_auto_focus = true
        end
    end
    for _, child_attachment in pairs(attachment.children) do
        animate_peds(child_attachment)
    end
end

local function ped_animation_tick()
    for _, spawned_construct in pairs(spawned_constructs) do
        animate_peds(spawned_construct)
    end
end

---
--- Dynamic Menus
---

local function build_curated_constructs_menu(root_menu, curated_item)
    if curated_item.is_folder then
        local child_menu = menu.list(root_menu, curated_item.name)
        for _, child_item in pairs(curated_item.items) do
            build_curated_constructs_menu(child_menu, child_item)
        end
    else
        curated_item.load_menu = menu.action(root_menu, curated_item.name or "Unknown", {}, "", function()
            local construct_plan = copy_construct_plan(curated_item)
            construct_plan.root = construct_plan
            construct_plan.parent = construct_plan
            build_construct_from_plan(construct_plan)
        end)
        menu.on_focus(curated_item.load_menu, function(direction) if direction ~= 0 then add_preview(curated_item) end end)
        menu.on_blur(curated_item.load_menu, function(direction) if direction ~= 0 then remove_preview() end end)
    end
end

local function build_curated_attachments_menu(attachment, root_menu, curated_item)
    if curated_item.is_folder then
        if curated_item.load_menu ~= nil then return end
        curated_item.load_menu = menu.list(root_menu, curated_item.name, {}, "", function()
            for _, child_item in pairs(curated_item.items) do
                build_curated_attachments_menu(attachment, curated_item.load_menu, child_item)
            end
        end)
    else
        if curated_item.load_menu == nil then
            curated_item.load_menu = menu.action(root_menu, curated_item.name or "Unknown", {}, "", function()
                debug_log("Adding curated item "..curated_item.name.." at offset "..inspect(curated_item.offset))
                local child_attachment = copy_construct_plan(curated_item)
                constructor_lib.default_attachment_attributes(child_attachment)
                child_attachment.root = attachment.root
                child_attachment.parent = attachment
                build_construct_from_plan(child_attachment)
                debug_log("Built curated item "..child_attachment.name.." at offset "..inspect(child_attachment.offset))

            end)
            menu.on_focus(curated_item.load_menu, function(direction) if direction ~= 0 then add_preview(curated_item) end end)
            menu.on_blur(curated_item.load_menu, function(direction) if direction ~= 0 then remove_preview() end end)
        end
    end
end

local function build_attachment_debug_menu(attachment, item, parent_menu)
    if item == nil then item = attachment end
    if parent_menu == nil then parent_menu = attachment.menus.debug end
    if attachment.temp.debug_menus == nil then attachment.temp.debug_menus = {} end
    for key, value in pairs(item) do
        local field_type = type(value)
        local field_value = tostring(value)
        if field_type == "table" and (key == "parent" or key == "root" or key == "debug_menus") then
            field_value = tostring(value.handle)
            field_type = "number"
        end
        local new_menu
        if field_type == "table" then
            new_menu = menu.list(parent_menu, key)
            build_attachment_debug_menu(attachment, value, new_menu)
        else
            new_menu = menu.readonly(parent_menu, key, field_value)
        end
        table.insert(attachment.temp.debug_menus, new_menu)
    end
end

local function rebuild_attachment_debug_menu(attachment)
    if attachment.temp.debug_menus then
        delete_menu_list(attachment.temp.debug_menus)
    end
    build_attachment_debug_menu(attachment)
end

local function build_change_parent_menu_item(attachment, current, path, depth)
    depth = depth + 1
    if depth > 100 then error(t("Max depth reached while reattaching")) return end
    table.insert(path, current.name)
    if attachment ~= current then   -- cant reattach to yourself or your children
        local new_parent_item = menu.action(attachment.menus.option_parent_attachment, table.concat(path, " > "), {}, "", function()
            debug_log("Reattaching "..attachment.name.." to "..current.name)
            local previous_parent = attachment.parent
            constructor_lib.serialize_entity_attributes(attachment)
            constructor_lib.separate_attachment(attachment)
            attachment.parent = current
            attachment.root = current.root
            if config.change_parent_keep_position then
                local offset = ENTITY.GET_OFFSET_FROM_ENTITY_GIVEN_WORLD_COORDS(current.handle, attachment.position.x, attachment.position.y, attachment.position.z)
                attachment.offset = {x=offset.x, y=offset.y, z=offset.z}
            end
            constructor_lib.attach_entity(attachment)
            table.insert(current.children, attachment)
            rebuild_attachment(attachment.root)
        end)
        menu.on_focus(new_parent_item, function(direction) if direction ~= 0 then current.is_editing = true end end)
        menu.on_blur(new_parent_item, function(direction) if direction ~= 0 then current.is_editing = false end end)
        for _, child_attachment in pairs(current.children) do
            build_change_parent_menu_item(attachment, child_attachment, constructor_lib.table_copy(path), depth)
        end
    end
end

local function build_change_parent_menu(attachment, current, path, depth)
    if attachment.menus.option_change_parent_keep_position ~= nil then return end
    debug_log("Rebuilding reattach to menu "..tostring(attachment.name))
    attachment.menus.option_change_parent_keep_position = menu.toggle(attachment.menus.option_parent_attachment, t("Keep Position"), {}, t("If enabled, the attachment will keep it's position when changing parent (tho rotations may be effected) otherwise it will keep its offset from parent."), function(on)
        config.change_parent_keep_position = on
    end, config.change_parent_keep_position)
    menu.divider(attachment.menus.option_parent_attachment, t("New Parent"))
    build_change_parent_menu_item(attachment, attachment.root, {}, 0)
end

local function search(search_params)
    if search_params.page_size == nil then search_params.page_size = 30 end
    if search_params.page_number == nil then search_params.page_number = 0 end
    if search_params.menus == nil then search_params.menus = {} end
    if search_params.results == nil then search_params.results = {} end
    local results = search_params.query_function(search_params)
    for i = (search_params.page_size*search_params.page_number)+1, search_params.page_size*(search_params.page_number+1) do
        if results[i] then
            local search_result_menu = search_params.action_function(search_params, results[i])
            table.insert(search_params.results, search_result_menu)
        end
    end
    if search_params.menus.search_add_more ~= nil then menu.delete(search_params.menus.search_add_more) end
    search_params.menus.search_add_more = menu.action(search_params.menus.root, t("Load More"), {}, "", function()
        local more_search_params = constructor_lib.table_copy(search_params)
        more_search_params.page_number = more_search_params.page_number + 1
        search(more_search_params)
    end)
    table.insert(search_params.results, search_params.menus.search_add_more)
end

---
--- Curated Constructs Installer
---
--预留
--local CURATED_CONSTRUCTS_DIR = CONSTRUCTS_DIR..'/Curated'
--filesystem.mkdirs(CURATED_CONSTRUCTS_DIR)
---
--- Item Browser
---

-- TODO: In progress

--constructor.search_items = function(folder, query)
--
--end

constructor.browse_items = function(root_menu, folder, context)
    --menu.action(root_menu, t("Search"), {}, "", function()  end)
    --if context.additional_page_menus ~= nil then
    --    context.additional_page_menus(context, root_menu)
    --end
    --menu.divider(root_menu, t("Browse"))
    for _, item in pairs(folder.items) do
        if item.is_folder == true then
            local menu_list = menu.list(root_menu, item.name)
            constructor.browse_items(menu_list, item, context)
        else
            if context.action_function ~= nil then
                menu.action(root_menu, item.name, {}, item.description or "", function()
                    context.action_function(item)
                end)
            end
        end
    end
end


---
--- Info Attachment Menu
---

constructor.add_attachment_info_menu = function(attachment)

    attachment.menus.info = menu.list(attachment.menus.main, t("Info"), {}, t("Information about the construct"), function()
        if attachment.menus.name ~= nil then return end

        attachment.menus.name = menu.text_input(attachment.menus.info, t("Name"), { "constructorsetattachmentname"..attachment.id}, t("Set name of the attachment"), function(value)
            attachment.name = value
            attachment.functions.refresh()
        end, attachment.name)

        if attachment == attachment.parent then

            attachment.menus.info_author = menu.text_input(attachment.menus.info, t("Author"), { "constructorsetattachmentauthor"..attachment.id}, t("Set name of the player that created this construct"), function(value)
                attachment.author = value
                attachment.functions.refresh()
            end, attachment.author or "")

            attachment.menus.info_description = menu.text_input(attachment.menus.info, t("Description"), { "constructorsetattachmentdescription"..attachment.id}, t("Set text to describe this construct"), function(value)
                attachment.description = value
                attachment.functions.refresh()
            end, attachment.description or "")

        end

        attachment.menus.debug = menu.list(attachment.menus.info, t("Debug Info"), {}, "", function()
            rebuild_attachment_debug_menu(attachment)
        end)
        --rebuild_attachment_debug_menu(attachment)

    end)
end

---
--- Position Menu
---

constructor.refresh_position_menu = function(attachment)
    if attachment == nil or attachment.menus == nil or attachment.menus.edit_offset_x == nil then return end
    attachment.menus.edit_offset_x.value = math.floor(attachment.offset.x * 100)
    attachment.menus.edit_offset_y.value = math.floor(attachment.offset.y * -100)
    attachment.menus.edit_offset_z.value = math.floor(attachment.offset.z * -100)
end

local EDIT_MENU_HELP = "Hold SHIFT to fine tune, or hold CONTROL to move ten steps at once."

constructor.add_attachment_position_menu = function(attachment)
    attachment.menus.position = menu.list(attachment.menus.main, t("Position"), {}, t("Position and Rotation options"), function()
        if attachment.options.is_attached or attachment.type == "PARTICLE" then

            if attachment.menus.edit_offset_x ~= nil then return end
            menu.divider(attachment.menus.position, t("Offset"))
            attachment.menus.edit_offset_x = menu.slider_float(attachment.menus.position, t("X: Left / Right"), { "constructoroffset"..attachment.id.."x"}, t(EDIT_MENU_HELP), -1000000, 1000000, math.floor(attachment.offset.x * 100), config.edit_offset_step, function(value)
                attachment.offset.x = value / 100
                constructor_lib.move_attachment(attachment)
            end)
            attachment.menus.edit_offset_y = menu.slider_float(attachment.menus.position, t("Y: Forward / Back"), {"constructoroffset"..attachment.id.."y"}, t(EDIT_MENU_HELP), -1000000, 1000000, math.floor(attachment.offset.y * -100), config.edit_offset_step, function(value)
                attachment.offset.y = value / -100
                constructor_lib.move_attachment(attachment)
            end)
            attachment.menus.edit_offset_z = menu.slider_float(attachment.menus.position, t("Z: Up / Down"), {"constructoroffset"..attachment.id.."z"}, t(EDIT_MENU_HELP), -1000000, 1000000, math.floor(attachment.offset.z * -100), config.edit_offset_step, function(value)
                attachment.offset.z = value / -100
                constructor_lib.move_attachment(attachment)
            end)

            menu.divider(attachment.menus.position, t("Rotation"))
            attachment.menus.edit_rotation_x = menu.slider(attachment.menus.position, t("X: Pitch"), {"constructorrotate"..attachment.id.."x"}, t(EDIT_MENU_HELP), -180, 180, math.floor(attachment.rotation.x), config.edit_rotation_step, function(value)
                attachment.rotation.x = value
                constructor_lib.move_attachment(attachment)
            end)
            attachment.menus.edit_rotation_y = menu.slider(attachment.menus.position, t("Y: Roll"), {"constructorrotate"..attachment.id.."y"}, t(EDIT_MENU_HELP), -180, 180, math.floor(attachment.rotation.y), config.edit_rotation_step, function(value)
                attachment.rotation.y = value
                constructor_lib.move_attachment(attachment)
            end)
            attachment.menus.edit_rotation_z = menu.slider(attachment.menus.position, t("Z: Yaw"), {"constructorrotate"..attachment.id.."z"}, t(EDIT_MENU_HELP), -180, 180, math.floor(attachment.rotation.z), config.edit_rotation_step, function(value)
                attachment.rotation.z = value
                constructor_lib.move_attachment(attachment)
            end)

        else

            if attachment.menus.edit_position_x ~= nil then return end
            menu.divider(attachment.menus.position, t("World Position"))
            attachment.menus.edit_position_x = menu.slider_float(attachment.menus.position, t("X: Left / Right"), { "constructorposition"..attachment.id.."x"}, t(EDIT_MENU_HELP), -1000000, 1000000, math.floor(attachment.position.x * 100), config.edit_offset_step, function(value)
                attachment.position.x = value / 100
                constructor_lib.move_attachment(attachment)
            end)
            attachment.menus.edit_position_y = menu.slider_float(attachment.menus.position, t("Y: Forward / Back"), {"constructorposition"..attachment.id.."y"}, t(EDIT_MENU_HELP), -1000000, 1000000, math.floor(attachment.position.y * -100), config.edit_offset_step, function(value)
                attachment.position.y = value / -100
                constructor_lib.move_attachment(attachment)
            end)
            attachment.menus.edit_position_z = menu.slider_float(attachment.menus.position, t("Z: Up / Down"), {"constructorposition"..attachment.id.."z"}, t(EDIT_MENU_HELP), -1000000, 1000000, math.floor(attachment.position.z * -100), config.edit_offset_step, function(value)
                attachment.position.z = value / -100
                constructor_lib.move_attachment(attachment)
            end)

            menu.divider(attachment.menus.position, t("World Rotation"))
            attachment.menus.edit_world_rotation_x = menu.slider(attachment.menus.position, t("X: Pitch"), {"constructorworldrotate"..attachment.id.."x"}, t(EDIT_MENU_HELP), -180, 180, math.floor(attachment.world_rotation.x), config.edit_rotation_step, function(value)
                attachment.world_rotation.x = value
                constructor_lib.move_attachment(attachment)
            end)
            attachment.menus.edit_world_rotation_y = menu.slider(attachment.menus.position, t("Y: Roll"), {"constructorworldrotate"..attachment.id.."y"}, t(EDIT_MENU_HELP), -180, 180, math.floor(attachment.world_rotation.y), config.edit_rotation_step, function(value)
                attachment.world_rotation.y = value
                constructor_lib.move_attachment(attachment)
            end)
            attachment.menus.edit_world_rotation_z = menu.slider(attachment.menus.position, t("Z: Yaw"), {"constructorworldrotate"..attachment.id.."z"}, t(EDIT_MENU_HELP), -180, 180, math.floor(attachment.world_rotation.z), config.edit_rotation_step, function(value)
                attachment.world_rotation.z = value
                constructor_lib.move_attachment(attachment)
            end)

        end

        menu.divider(attachment.menus.position, t("Options"))

        attachment.menus.gizmo_edit_mode = menu.toggle(attachment.menus.position, "Gizmo Edit", {}, "Position this object using clickable arrow handles", function(on)
            if (on) then
                attachment.temp.is_gizmo_editing = true
                current_gizmo_entity = attachment.handle
                state.gizmo_edit_mode = true
            else
                attachment.temp.is_gizmo_editing = false
                state.gizmo_edit_mode = false
            end
        end)
        menu.on_blur(attachment.menus.gizmo_edit_mode, function()
            if attachment.temp.is_gizmo_editing then
                menu.set_value(attachment.menus.gizmo_edit_mode, false)
            end
        end)

        attachment.menus.free_edit_mode = menu.toggle(attachment.menus.position, "Free Edit", {}, "Position this object using controller or mouse", function(on)
            if (on) then
                free_edit_attachment(attachment)
            else
                clear_free_edit_attachment()
            end
        end, config.free_edit_mode)
        menu.on_blur(attachment.menus.free_edit_mode, function()
            if config.free_edit_mode then
                clear_free_edit_attachment()
                menu.set_value(attachment.menus.free_edit_mode, false)
            end
        end)

        if constructor_lib.is_attachment_root(attachment) or attachment.options.is_attached == false then
            attachment.menus.option_position_frozen = menu.toggle(attachment.menus.position, t("Freeze Position"), {}, t("Will the construct be frozen in place, or allowed to move freely"), function(on)
                attachment.options.is_frozen = on
                constructor_lib.serialize_entity_attributes(attachment)
                constructor_lib.attach_entity(attachment)
            end, attachment.options.is_frozen)
        end

        menus.refresh_attachment_menu_is_editing(attachment)
    end)
end

---
--- Options Menu
---

constructor.add_attachment_options_menu = function(attachment)
    attachment.menus.options = menu.list(attachment.menus.main, t("Options"), {}, t("Configuration options for this entity"), function()

        if constructor_lib.is_attachment_entity(attachment) then
            if attachment.menus.option_visible ~= nil then return end
            attachment.menus.option_visible = menu.toggle(attachment.menus.options, t("Visible"), {}, t("Will the attachment be visible, or invisible"), function(on)
                attachment.options.is_visible = on
                constructor_lib.set_attachment_visibility(attachment)
            end, attachment.options.is_visible)
            attachment.menus.option_collision = menu.toggle(attachment.menus.options, t("Collision"), {}, t("Will the attachment collide with things, or pass through them"), function(on)
                attachment.options.has_collision = on
                constructor_lib.attach_entity(attachment)
            end, attachment.options.has_collision)
            attachment.menus.option_invincible = menu.toggle(attachment.menus.options, t("Invincible"), {}, t("Will the attachment be impervious to damage, or be damageable. AKA Godmode."), function(on)
                attachment.options.is_invincible = on
                constructor_lib.attach_entity(attachment)
            end, attachment.options.is_invincible)
            if constructor_lib.is_attachment_root(attachment) then
                attachment.menus.option_frozen = menu.toggle(attachment.menus.options, t("Freeze Position"), {}, t("Will the construct be frozen in place, or allowed to move freely"), function(on)
                    attachment.options.is_frozen = on
                    constructor_lib.serialize_entity_attributes(attachment)
                    constructor_lib.attach_entity(attachment)
                end, attachment.options.is_frozen)
            end
        end

        if attachment.type == "PARTICLE" then
            if attachment.menus.option_particle_asset ~= nil then return end

            attachment.menus.option_particle_asset = menu.text_input(attachment.menus.options, t("Particle Asset"), { "constructorsetparticleasset"..attachment.id}, t("Set the name of the particle asset"), function(value)
                attachment.particle_attributes.asset = value
                constructor_lib.update_particle(attachment)
            end, attachment.particle_attributes.asset or "")
            attachment.menus.option_particle_effect_name = menu.text_input(attachment.menus.options, t("Particle Effect"), { "constructorsetparticleeffect"..attachment.id}, t("Set the name of the particle effect"), function(value)
                attachment.particle_attributes.effect_name = value
                constructor_lib.update_particle(attachment)
            end, attachment.particle_attributes.effect_name or "")

            attachment.menus.option_paritcle_edit_scale = menu.slider(attachment.menus.options, t("Scale"), {"constructorpfxscale"..attachment.id}, t("Particle effect size"), 0, 10000, math.floor(attachment.particle_attributes.scale * 100), config.edit_offset_step, function(value)
                attachment.particle_attributes.scale = value / 100
                constructor_lib.update_particle(attachment)
            end)
            attachment.menus.option_particle_bone_index = menu.slider(attachment.menus.options, t("Bone Index"), {"constructorpfxbone"..attachment.id}, t("Which bone of the parent should this entity be attached to"), -1, attachment.parent.num_bones or 200, attachment.particle_attributes.bone_index or -1, 1, function(value)
                attachment.particle_attributes.bone_index = value
                constructor_lib.update_particle(attachment)
            end)
            attachment.menus.option_particle_loop_timer = menu.slider(attachment.menus.options, t("Loop Timer"), {"constructorpfxlooptimer"..attachment.id}, t("How often should the effect repeat. If this is 0 then it should try to loop forever."), 0, 60000, attachment.particle_attributes.loop_timer or 0, 1, function(value)
                attachment.particle_attributes.loop_timer = value
                constructor_lib.update_particle(attachment)
            end)
            attachment.menus.option_particle_color = menu.colour(attachment.menus.options, t("Particle Color"), {}, "Local only :(", attachment.particle_attributes.color, true, function(color)
                attachment.particle_attributes.color = color
                constructor_lib.update_particle(attachment)
            end)
        end

        if attachment.type == "VEHICLE" then
            constructor.add_attachment_vehicle_menu(attachment)
        end

        if attachment.type == "PED" then
            constructor.add_attachment_ped_menu(attachment)
        end

        if constructor_lib.is_attachment_entity(attachment) then
            if not constructor_lib.is_attachment_root(attachment) then
                constructor.add_child_attachment_menu(attachment)
            end
            constructor.add_attachment_entity_options(attachment)
        end

        menus.refresh_attachment_menu_is_editing(attachment)
    end)
end

---
--- Vehicle Options Menu
---

local vehicle_mod_menus = {
    { name="Performance", type="separator" },
    { name="Engine", index=11 },
    { name="Brakes", index=12 },
    { name="Transmission", index=13 },
    { name="Turbo", index=18 },
    { name="Armor", index=16 },

    { name="Wheels", type="separator" },
    { name="Wheel Type", type="custom", func=function(attachment)
        menu.slider(attachment.menus.vehicle_options_ls_customs, "Wheel Type", {}, "", -1, 13, attachment.vehicle_attributes.wheels.wheel_type or -1, 1, function(value)
            attachment.vehicle_attributes.wheels.wheel_type = value
            constructor_lib.deserialize_vehicle_attributes(attachment)
        end)
    end },
    { name="Wheels", index=23 },
    { name="Rear Wheel", index=24 },

    { name="Mods", type="separator" },
    { name="Spoiler", index=0 },
    { name="Front Bumper", index=1 },
    { name="Rear Bumper", index=2 },
    { name="Side Skirts", index=3 },
    { name="Exhaust", index=4 },
    { name="Chassis / Roll Cage", index=5 },
    { name="Grille", index=6 },
    { name="Hood", index=7 },
    { name="Rearview Mirror / Fender", index=8 },
    { name="Right Fender", index=9 },
    { name="Roof", index=10 },
    { name="Horn", index=14 },
    { name="Suspension", index=15 },
    --{ name="UNK17", index=17 },
    --{ name="UNK19", index=19 },
    { name="Tire Smoke", index=20 },
    --{ name="UNK21", index=21 },
    { name="Xenon Headlights", index=22 },

    --{ name="Benny's", type="separator" },
    -- Benny's
    { name="Plate Holder", index=25 },
    { name="Vanity Plates", index=26 },
    { name="Trim", index=27 },
    { name="Ornaments", index=28 },
    { name="Dashboard", index=29 },
    { name="Dial", index=30 },
    { name="Door Speaker", index=31 },
    { name="Seats", index=32 },
    { name="Steering Wheel", index=33 },
    { name="Shifter", index=34 },
    { name="Plaques", index=35 },
    { name="Speakers", index=36 },
    { name="Trunk", index=37 },
    { name="Hydrulics", index=38 },
    { name="Engine Block", index=39 },
    { name="Air Filter", index=40 },
    { name="Struts", index=41 },
    { name="Arch Cover", index=42 },
    { name="Canards / Antennas", index=43 },
    { name="Trim", index=44 },
    { name="Tank", index=45 },
    { name="Windows", index=46 },
    { name="UNK47", index=47 },
    { name="Livery", index=48 },
}

constructor.add_attachment_vehicle_menu = function(attachment)
    if attachment.type ~= "VEHICLE" then return end
    if attachment.vehicle_attributes == nil then attachment.vehicle_attributes = {} end
    if attachment.menus.vehicle_options ~= nil then return end
    attachment.menus.vehicle_options = menu.list(attachment.menus.options, t("Vehicle Options"), {}, t("Additional options available for all vehicle entities"))

    attachment.menus.vehicle_options_ls_customs = menu.list(attachment.menus.vehicle_options, t("LS Customs"), {}, "Vehicle modifications normally available in Los Santos Customs")
    for _, vehicle_mod in pairs(vehicle_mod_menus) do
        if vehicle_mod.type == "separator" then
            menu.divider(attachment.menus.vehicle_options_ls_customs, vehicle_mod.name)
        elseif vehicle_mod.type == "custom" and type(vehicle_mod.func) == "function" then
            vehicle_mod.func(attachment)
        else
            if vehicle_mod.index >= 17 and vehicle_mod.index <= 22 then
                menu.toggle(attachment.menus.vehicle_options_ls_customs, vehicle_mod.name, {}, "", function(value)
                    attachment.vehicle_attributes.mods["_"..vehicle_mod.index] = value
                    constructor_lib.deserialize_vehicle_mods(attachment)
                end, attachment.vehicle_attributes.mods["_"..vehicle_mod.index])
            else
                local max = VEHICLE.GET_NUM_VEHICLE_MODS(attachment.handle, vehicle_mod.index) - 1
                if max > 0 then
                    menu.slider(attachment.menus.vehicle_options_ls_customs, vehicle_mod.name, {}, "", -1, max, attachment.vehicle_attributes.mods["_"..vehicle_mod.index] or -1, 1, function(value)
                        attachment.vehicle_attributes.mods["_"..vehicle_mod.index] = value
                        constructor_lib.deserialize_vehicle_mods(attachment)
                    end)
                end
            end
        end
    end

    attachment.menus.vehicle_options_extras = menu.list(attachment.menus.vehicle_options, t("Extras"), {}, t("Some vehicles include parts that can fall off and be removed when damaged"), function()
        if attachment.temp.extra_menus == nil then attachment.temp.extra_menus = {} end
        delete_menu_list(attachment.temp.extra_menus)
        for extra_index = 0, 60 do
            if VEHICLE.DOES_EXTRA_EXIST(attachment.handle, extra_index) then
                local extra_menu = menu.toggle(attachment.menus.vehicle_options_extras, t("Extra").." #"..extra_index, {}, "", function(toggle)
                    attachment.vehicle_attributes.extras["_"..extra_index] = toggle
                    constructor_lib.deserialize_vehicle_extras(attachment)
                end, attachment.vehicle_attributes.extras["_"..extra_index])
                table.insert(attachment.temp.extra_menus, extra_menu)
            end
        end
    end)

    attachment.menus.vehicle_options_paint = menu.list(attachment.menus.vehicle_options, t("Paint"), {}, t("Set vehicle paint colors"))

    attachment.menus.vehicle_options_primary = menu.list(attachment.menus.vehicle_options_paint, t("Primary"), {}, t("Primary vehicle paint color"))
    attachment.menus.vehicle_options_primary_standard_colors = menu.list(attachment.menus.vehicle_options_primary, t("Standard Color"), {}, t("Select from a list of standard paint colors"))
    for _, standard_color in pairs(constants.standard_colors) do
        menu.action(attachment.menus.vehicle_options_primary_standard_colors, standard_color.name, {}, "", function()
            attachment.vehicle_attributes.paint.primary.is_custom = false
            attachment.vehicle_attributes.paint.primary.vehicle_standard_color = standard_color.index
            constructor_lib.deserialize_vehicle_paint(attachment)
        end)
    end
    attachment.menus.vehicle_options_primary_custom_color = menu.colour(attachment.menus.vehicle_options_primary, t("Custom Color"), {}, t("Mix up a custom paint color"), color_menu_input(attachment.vehicle_attributes.paint.primary.custom_color), false, function(color)
        attachment.vehicle_attributes.paint.primary.is_custom = true
        attachment.vehicle_attributes.paint.primary.custom_color = color_menu_output(color)
        constructor_lib.deserialize_vehicle_paint(attachment)
    end)
    --menu.divider(attachment.menus.vehicle_options_primary_custom_color, "Hex")
    attachment.menus.vehicle_options_primary_paint_type = menu.list_select(attachment.menus.vehicle_options_primary, t("Paint Type"), {}, t("Type of paint finish"), constants.vehicle_paint_types, 1, function(value)
        attachment.vehicle_attributes.paint.primary.paint_type = value - 1
        constructor_lib.deserialize_vehicle_paint(attachment)
    end)

    attachment.menus.vehicle_options_secondary = menu.list(attachment.menus.vehicle_options_paint, t("Secondary"), {}, t("Secondary vehicle paint color"))
    attachment.menus.vehicle_options_secondary_standard_colors = menu.list(attachment.menus.vehicle_options_secondary, t("Standard Color"), {}, t("Select from a list of standard paint colors"))
    for _, standard_color in pairs(constants.standard_colors) do
        menu.action(attachment.menus.vehicle_options_secondary_standard_colors, standard_color.name, {}, "", function()
            attachment.vehicle_attributes.paint.secondary.is_custom = false
            attachment.vehicle_attributes.paint.secondary.vehicle_standard_color = standard_color.index
            constructor_lib.deserialize_vehicle_paint(attachment)
        end)
    end
    attachment.menus.vehicle_options_secondary_custom_color = menu.colour(attachment.menus.vehicle_options_secondary, t("Custom Color"), {}, t("Mix up a custom paint color"), color_menu_input(attachment.vehicle_attributes.paint.secondary.custom_color), false, function(color)
        attachment.vehicle_attributes.paint.secondary.is_custom = true
        attachment.vehicle_attributes.paint.secondary.custom_color = color_menu_output(color)
        constructor_lib.deserialize_vehicle_paint(attachment)
    end)
    --menu.divider(attachment.menus.vehicle_options_secondary_custom_color, "Hex")
    attachment.menus.vehicle_options_secondary_paint_type = menu.list_select(attachment.menus.vehicle_options_secondary, t("Paint Type"), {}, t("Type of paint finish"), constants.vehicle_paint_types, 1, function(value)
        attachment.vehicle_attributes.paint.secondary.paint_type = value - 1
        constructor_lib.deserialize_vehicle_paint(attachment)
    end)

    attachment.menus.vehicle_options_pearl = menu.list(attachment.menus.vehicle_options_paint, t("Pearlescent"), {}, t("Select from a list of pearlescent paint colors"))
    for _, standard_color in pairs(constants.standard_colors) do
        menu.action(attachment.menus.vehicle_options_pearl, standard_color.name, {}, "", function()
            attachment.vehicle_attributes.paint.extra_colors.pearlescent = standard_color.index
            constructor_lib.deserialize_vehicle_paint(attachment)
        end)
    end

    attachment.menus.vehicle_options_wheels = menu.list(attachment.menus.vehicle_options_paint, t("Wheels"), {}, t("Select from a list of wheel paint colors"))
    for _, standard_color in pairs(constants.standard_colors) do
        menu.action(attachment.menus.vehicle_options_wheels, standard_color.name, {}, "", function()
            attachment.vehicle_attributes.paint.extra_colors.wheel = standard_color.index
            constructor_lib.deserialize_vehicle_paint(attachment)
        end)
    end

    attachment.menus.vehicle_options_tire_smoke = menu.colour(attachment.menus.vehicle_options_paint, t("Tire Smoke"), {}, t("Mix up a custom tire smoke color"), color_menu_input(attachment.vehicle_attributes.wheels.tire_smoke_color), false, function(color)
        attachment.vehicle_attributes.wheels.tire_smoke_color = color_menu_output(color)
        attachment.vehicle_attributes.mods["_20"] = true    -- Turn on tire smoke mod
        constructor_lib.deserialize_vehicle_mods(attachment)
        constructor_lib.deserialize_vehicle_wheels(attachment)
    end)

    menu.list_select(attachment.menus.vehicle_options_paint, t("Headlights"), {}, t("Select from a list of headlight colors"), constants.headlight_colors, attachment.vehicle_attributes.headlights.headlight_color + 2, function(index)
        attachment.vehicle_attributes.headlights.headlights_color = index - 2
        attachment.vehicle_attributes.headlights.headlights_type = true
        constructor_lib.deserialize_vehicle_mods(attachment)
        constructor_lib.deserialize_vehicle_headlights(attachment)
    end)

    attachment.menus.vehicle_options_neon = menu.colour(attachment.menus.vehicle_options_paint, t("Neon Lights"), {}, t("Set up a custom neon light color"), color_menu_input(attachment.vehicle_attributes.neon.color), false, function(color)
        attachment.vehicle_attributes.neon.color = color_menu_output(color)
        if attachment.vehicle_attributes.neon.lights == nil then
            attachment.vehicle_attributes.neon.lights = { left = true, right = true, front = true, back = true }
        end
        constructor_lib.deserialize_vehicle_neon(attachment)
    end)

    menu.toggle_loop(attachment.menus.vehicle_options, t("Engine Always On"), {}, t("If enabled, vehicle will stay running even when unoccupied"), function()
        attachment.options.engine_running = true
        VEHICLE.SET_VEHICLE_ENGINE_ON(attachment.handle, true, true, true)
    end, function() attachment.options.engine_running = false end)
    menu.toggle(attachment.menus.vehicle_options, t("Radio Loud"), {}, t("If enabled, vehicle radio will play loud enough to be heard outside the vehicle."), function(toggle)
        attachment.options.radio_loud = toggle
        constructor_lib.attach_entity(attachment)
    end, attachment.options.radio_loud)

    menu.slider(attachment.menus.vehicle_options, t("Steering Bias"), {"constructorsteeringbias"..attachment.id}, t("Set wheel position. Must be driving to set, but will stay when you exit until someone else drives."), -1, 1, math.floor(attachment.vehicle_attributes.wheels.steering_bias or 0), 1, function(value)
        attachment.vehicle_attributes.wheels.steering_bias = value
        constructor_lib.deserialize_vehicle_wheels(attachment)
    end)

    menu.list_select(attachment.menus.vehicle_options, t("Sirens"), {}, "", { t("Off"), t("Lights Only"), t("Sirens and Lights") }, 1, function(value)
        local previous_siren_status = attachment.options.siren_status
        attachment.options.siren_status = value
        refresh_siren_status(attachment, previous_siren_status)
    end)
    menu.toggle(attachment.menus.vehicle_options, t("Siren Control"), {}, t("If enabled, and this vehicle has a siren, then siren controls will effect this vehicle. Has no effect on vehicles without a siren."), function(value)
        attachment.options.has_siren = value
    end, attachment.options.has_siren)
    menu.text_input(attachment.menus.vehicle_options, t("Engine Sound"), {"constructorenginesound"..attachment.id}, t("Set vehicle engine sound from another vehicle name."), function(value)
        attachment.vehicle_attributes.engine_sound = value
        constructor_lib.deserialize_vehicle_options(attachment)
    end, attachment.vehicle_attributes.engine_sound or "")

    menu.toggle(attachment.menus.vehicle_options, t("Invisible Wheels"), {}, t("If enabled, the vehicle wheels will be invisible"), function(value)
        attachment.vehicle_attributes.wheels.invisible_wheels = value
        constructor_lib.deserialize_vehicle_wheels(attachment)
    end, attachment.vehicle_attributes.wheels.invisible_wheels)

    menu.toggle(attachment.menus.vehicle_options, t("Drift Tires"), {}, t("If enabled, the vehicle tires will have low grip"), function(value)
        attachment.vehicle_attributes.wheels.drift_tires = value
        constructor_lib.deserialize_vehicle_wheels(attachment)
    end, attachment.vehicle_attributes.wheels.drift_tires)

    menu.list_select(attachment.menus.vehicle_options, t("Door Lock Status"), {}, t("Vehicle door locks"), constants.door_lock_status, attachment.vehicle_attributes.doors.lock_status or 1, function(value)
        attachment.vehicle_attributes.doors.lock_status = value
        constructor_lib.deserialize_vehicle_doors(attachment)
    end)

    menu.slider_float(attachment.menus.vehicle_options, t("Paint Fade"), {"constructorfadelevel"..attachment.id}, t("How dirty is the vehicle"), 0, 100, math.floor(attachment.vehicle_attributes.paint.fade * 100), 1, function(value)
        attachment.vehicle_attributes.paint.fade = value / 100
        constructor_lib.deserialize_vehicle_paint(attachment)
    end)

    menu.slider(attachment.menus.vehicle_options, t("Dirt Level"), {"constructordirtlevel"..attachment.id}, t("How dirty is the vehicle"), 0, 15, math.floor(attachment.vehicle_attributes.paint.dirt_level), 1, function(value)
        attachment.vehicle_attributes.paint.dirt_level = value
        constructor_lib.deserialize_vehicle_paint(attachment)
    end)

    menu.toggle(attachment.menus.vehicle_options, t("Bullet Proof Tires"), {}, "", function(value)
        attachment.vehicle_attributes.wheels.bulletproof_tires = value
        constructor_lib.deserialize_vehicle_wheels(attachment)
    end, attachment.vehicle_attributes.wheels.bulletproof_tires)

    attachment.menus.tires_burst = menu.list(attachment.menus.vehicle_options, t("Burst Tires"), {}, t("Are tires burst"))
    if attachment.vehicle_attributes.wheels.tires_burst == nil then attachment.vehicle_attributes.wheels.tires_burst = {} end
    for _, tire_position in pairs(constants.tire_position_names) do
        menu.toggle(attachment.menus.tires_burst, tire_position.name, {}, "", function(value)
            if value then attachment.vehicle_attributes.wheels.bulletproof_tires = false end
            attachment.vehicle_attributes.wheels.tires_burst["_"..tire_position.index] = value
            constructor_lib.deserialize_vehicle_wheels(attachment)
        end, attachment.vehicle_attributes.wheels.tires_burst["_"..tire_position.index])
    end

    attachment.menus.broken_doors = menu.list(attachment.menus.vehicle_options, t("Broken Doors"), {}, t("Remove doors and trunks"))
    attachment.menus.option_doors_broken_frontleft = menu.action(attachment.menus.broken_doors, t("Break Door: Front Left"), {}, t("Remove door."), function()
        attachment.vehicle_attributes.doors.broken.frontleft = true
        constructor_lib.deserialize_vehicle_doors(attachment)
    end)
    attachment.menus.option_doors_broken_backleft = menu.action(attachment.menus.broken_doors, t("Break Door: Back Left"), {}, t("Remove door."), function()
        attachment.vehicle_attributes.doors.broken.backleft = true
        constructor_lib.deserialize_vehicle_doors(attachment)
    end)
    attachment.menus.option_doors_broken_frontright = menu.action(attachment.menus.broken_doors, t("Break Door: Front Right"), {}, t("Remove door."), function()
        attachment.vehicle_attributes.doors.broken.frontright = true
        constructor_lib.deserialize_vehicle_doors(attachment)
    end)
    attachment.menus.option_doors_broken_backright = menu.action(attachment.menus.broken_doors, t("Break Door: Back Right"), {}, t("Remove door."), function()
        attachment.vehicle_attributes.doors.broken.backright = true
        constructor_lib.deserialize_vehicle_doors(attachment)
    end)
    attachment.menus.option_doors_broken_hood = menu.action(attachment.menus.broken_doors, t("Break Door: Hood"), {}, t("Remove door."), function()
        attachment.vehicle_attributes.doors.broken.hood = true
        constructor_lib.deserialize_vehicle_doors(attachment)
    end)
    attachment.menus.option_doors_broken_trunk = menu.action(attachment.menus.broken_doors, t("Break Door: Trunk"), {}, t("Remove door."), function()
        attachment.vehicle_attributes.doors.broken.trunk = true
        constructor_lib.deserialize_vehicle_doors(attachment)
    end)
    attachment.menus.option_doors_broken_trunk2 = menu.action(attachment.menus.broken_doors, t("Break Door: Trunk2"), {}, t("Remove door."), function()
        attachment.vehicle_attributes.doors.broken.trunk2 = true
        constructor_lib.deserialize_vehicle_doors(attachment)
    end)

    attachment.menus.windows = menu.list(attachment.menus.vehicle_options, t("Windows Rolled Down"), {}, t("Roll up and down windows"))
    for window_index = 1, 8 do
        local window_name = constructor_lib.WINDOW_INDEX_NAMES[window_index]
        menu.toggle(attachment.menus.windows, t("Window Rolled Down: ")..window_name, {}, t("Roll down the window."), function(on)
            attachment.vehicle_attributes.windows.rolled_down[window_name] = on
            constructor_lib.deserialize_vehicle_windows(attachment)
        end, attachment.vehicle_attributes.windows.rolled_down[window_name])
    end

    attachment.menus.windows = menu.list(attachment.menus.vehicle_options, t("Windows Broken"), {}, t("Roll up and down windows"))
    for window_index = 1, 8 do
        local window_name = constructor_lib.WINDOW_INDEX_NAMES[window_index]
        menu.toggle(attachment.menus.windows, t("Window Broken: ")..window_name, {}, t("Break the window."), function(on)
            attachment.vehicle_attributes.windows.rolled_down[window_name] = on
            constructor_lib.deserialize_vehicle_windows(attachment)
        end, attachment.vehicle_attributes.windows.rolled_down[window_name])
    end

end

---
--- Ped Options Menu
---

local function create_ped_weapon_menu(attachment, root_menu, items)
    for _, item in pairs(items) do
        if item.is_folder == true then
            local weapons_menu = menu.list(root_menu, item.name)
            create_ped_weapon_menu(attachment, weapons_menu, item.items)
        else
            menu.action(root_menu, item.name, {}, "", function()
                attachment.ped_attributes.weapon.hash = nil
                attachment.ped_attributes.weapon.model = item.model
                if item.component ~= nil then
                    attachment.ped_attributes.weapon.component_model = item.component
                end
                constructor_lib.deserialize_ped_attributes(attachment)
            end)
        end
    end
end

local function create_ped_component_menu(attachment, root_menu, index, name)
    local component = attachment.ped_attributes.components["_".. index]
    attachment.menus["ped_components_drawable_"..index] = menu.slider(root_menu, name, {}, "", 0, component.num_drawable_variations or -1, component.drawable_variation or -1, 1, function(value)
        component.drawable_variation = value
        constructor_lib.deserialize_ped_attributes(attachment)
        menu.set_max_value(attachment.menus["ped_components_drawable_"..index], component.num_drawable_variations)
        component.texture_variation = 0
        menu.set_value(attachment.menus["ped_components_texture_"..index], component.texture_variation)
        menu.set_max_value(attachment.menus["ped_components_texture_"..index], component.num_texture_variations)
    end)
    attachment.menus["ped_components_texture_".. index] = menu.slider(root_menu, name.." "..t("Variation"), {}, "", 0, component.num_texture_variations or -1, component.texture_variation or -1, 1, function(value)
        component.texture_variation = value
        constructor_lib.deserialize_ped_attributes(attachment)
    end)
end

local function create_ped_prop_menu(attachment, root_menu, index, name)
    local prop = attachment.ped_attributes.props["_".. index]
    attachment.menus["ped_props_drawable_".. index] = menu.slider(root_menu, name, {}, "", -1, prop.num_drawable_variations or -1, prop.drawable_variation or -1, 1, function(value)
        prop.drawable_variation = value
        constructor_lib.deserialize_ped_attributes(attachment)
        menu.set_max_value(attachment.menus["ped_props_drawable_".. index], prop.num_drawable_variations)
        prop.texture_variation = 0
        menu.set_value(attachment.menus["ped_props_texture_".. index], prop.texture_variation)
        menu.set_max_value(attachment.menus["ped_props_texture_".. index], prop.num_texture_variations)
    end)
    attachment.menus["ped_props_texture_".. index] = menu.slider(root_menu, name.." "..t("Variation"), {}, "", 0, prop.num_texture_variations or -1, prop.texture_variation or -1, 1, function(value)
        prop.texture_variation = value
        constructor_lib.deserialize_ped_attributes(attachment)
    end)
end

local function refresh_current_animation(attachment)
    local current_animation_name = "None"
    local current_refresh_timer = 0
    if attachment.ped_attributes.animation ~= nil then
        current_animation_name = attachment.ped_attributes.animation.name or attachment.ped_attributes.animation.clip
                or attachment.ped_attributes.animation.scenario or "Unknown"
        current_refresh_timer = attachment.ped_attributes.animation.refresh_timer or 0
    end
    attachment.menus.current_animation.value = current_animation_name
    attachment.menus.ped_edit_animation_refresh_timer.value = current_refresh_timer
end

local function set_current_animation(attachment, animation)
    attachment.ped_attributes.animation = animation
    constructor_lib.animate_peds(attachment)
    refresh_current_animation(attachment)
end

local function cancel_current_animation(attachment)
    constructor_lib.cancel_animation(attachment)
    attachment.ped_attributes.animation = nil
    refresh_current_animation(attachment)
end

constructor.add_attachment_ped_menu = function(attachment)
    if attachment.type ~= "PED" then return end
    if attachment.menus.ped_options ~= nil then return end
    attachment.menus.ped_options = menu.list(attachment.menus.options, t("Ped Options"), {}, t("Additional options available for Ped entities."))

    local ped_seats = { t("Unseated"), t("Any free seat"), t("Driver"), t("Passenger"), t("Backseat Driver Side"), t("Backseat Passenger Side") }
    attachment.menus.option_ped_seat_select = menu.list_select(attachment.menus.ped_options, t("Seat"), {}, t("If attached to a vehicle, which seat should this ped occupy."), ped_seats, 1, function(value)
        attachment.ped_attributes.seat = value - 4
        constructor_lib.deserialize_ped_attributes(attachment)
    end)
    attachment.menus.option_ped_can_rag_doll = menu.toggle(attachment.menus.ped_options, t("Can Rag Doll"), {}, t("If enabled, the ped can go limp."), function(value)
        attachment.ped_attributes.can_rag_doll = value
        constructor_lib.deserialize_ped_attributes(attachment)
    end, attachment.ped_attributes.can_rag_doll)
    attachment.menus.option_ped_armor = menu.slider(attachment.menus.ped_options, t("Armor"), {}, t("How much armor does the ped have."), 0, 100, attachment.ped_attributes.armor, 1, function(value)
        attachment.ped_attributes.armor = value
        constructor_lib.deserialize_ped_attributes(attachment)
    end)
    attachment.menus.option_ped_ignore_events = menu.toggle(attachment.menus.ped_options, t("Ignore Events"), {}, t("If enabled, the ped will ignore events going on that might otherwise cause the ped to flee or cower."), function(value)
        attachment.ped_attributes.ignore_events = value
        constructor_lib.deserialize_ped_attributes(attachment)
    end, attachment.ped_attributes.ignore_events)
    attachment.menus.option_on_fire = menu.toggle(attachment.menus.ped_options, t("On Fire"), {}, t("Will the ped be burning on fire, or not"), function(on)
        attachment.options.is_on_fire = on
        constructor_lib.deserialize_ped_attributes(attachment)
    end, attachment.options.is_on_fire)

    attachment.menus.option_give_ped_weapon = menu.list(attachment.menus.ped_options, t("Give Weapon"), {}, t("Give the ped a weapon."))
    create_ped_weapon_menu(attachment, attachment.menus.option_give_ped_weapon, constants.ped_weapons)

    attachment.menus.ped_options_clothes = menu.list(attachment.menus.ped_options, t("Clothes"))
    for _, ped_component in pairs(constants.ped_components) do
        create_ped_component_menu(attachment, attachment.menus.ped_options_clothes, ped_component.index, ped_component.name)
    end

    attachment.menus.ped_options_props = menu.list(attachment.menus.ped_options, t("Props"))
    for _, ped_prop in pairs(constants.ped_props) do
        create_ped_prop_menu(attachment, attachment.menus.ped_options_props, ped_prop.index, ped_prop.name)
    end

    attachment.menus.ped_options_animation = menu.list(attachment.menus.ped_options, t("Animation"), {}, t("Configure animation options"), function()
        refresh_current_animation(attachment)
    end)
    attachment.menus.current_animation = menu.readonly(attachment.menus.ped_options_animation, t("Current"), t("The current animation set for this ped"))

    attachment.menus.ped_animation_options = menu.list(attachment.menus.ped_options_animation, t("Options"), {}, t("Options to modify the current animation"), function()
        if attachment.temp.ped_animation_option_menus == nil then attachment.temp.ped_animation_option_menus = {} end
        delete_menu_list(attachment.temp.ped_animation_option_menus)
        if attachment.ped_attributes.animation ~= nil then
            attachment.temp.ped_animation_option_menus.controllable = menu.toggle(attachment.menus.ped_animation_options, t("Controllable"), {}, t("If enabled, you can control your ped while using this animation, at the cost of some animation fidelity"), function(toggle)
                attachment.ped_attributes.animation.controllable = toggle
                constructor_lib.animate_peds(attachment)
            end, attachment.ped_attributes.animation.controllable)
            attachment.temp.ped_animation_option_menus.loop = menu.toggle(attachment.menus.ped_animation_options, t("Loop"), {}, t("If enabled, and the animation supports native looping, then it will loop"), function(toggle)
                attachment.ped_attributes.animation.loop = toggle
                constructor_lib.animate_peds(attachment)
            end, attachment.ped_attributes.animation.loop)
        end
    end)

    local refresh_timer = 0
    if attachment.ped_attributes.animation ~= nil and attachment.ped_attributes.animation.refresh_timer then refresh_timer = attachment.ped_attributes.animation.refresh_timer end
    attachment.menus.ped_edit_animation_refresh_timer = menu.slider(attachment.menus.ped_options_animation, t("Refresh Timer"), {}, t("How often should the animation be totally reset. 0 means never."), 0, 60000, refresh_timer, 1000, function(value)
        if attachment.ped_attributes.animation == nil then return end
        attachment.ped_attributes.animation.refresh_timer = value
        constructor_lib.animate_peds(attachment)
    end)

    attachment.menus.ped_cancel_animation = menu.action(attachment.menus.ped_options_animation, t("Cancel"), {}, t("Immediately stops the current animation"), function()
        cancel_current_animation(attachment)
    end)

    attachment.menus.ped_options_animation_list = menu.list(attachment.menus.ped_options_animation, t("Browse Animations"), {}, t("Select from a curated set of animations"))
    constructor.browse_items(attachment.menus.ped_options_animation_list, constants.animations, {
        action_function=function(item)
            set_current_animation(attachment, item)
        end
    })

    attachment.menus.animation_set_by_name = menu.list(attachment.menus.ped_options_animation, t("Set by Name"), {}, t("Set a specific animation dictionary+clip or scenario"))
    attachment.menus.ped_animation_set_dict_and_clip = menu.text_input(attachment.menus.animation_set_by_name, t("Dictionary and Clip"), {"constructoranimationdictionaryclip"..attachment.id}, t("Set the animation dictionary and clip (separated by a space)."), function(animation_name)
        local animation_values = string.split(animation_name, " ")
        if #animation_values > 1 then
            set_current_animation(attachment, {
                name = animation_values[2],
                dictionary = animation_values[1],
                clip = animation_values[2],
            })
        end
    end)
    menu.hyperlink(attachment.menus.animation_set_by_name, t("Dictionary and Clip List"), "https://gtahash.ru/animations/")
    attachment.menus.ped_options_animation_scenario = menu.text_input(attachment.menus.animation_set_by_name, t("Scenario"), {"constructoranimationscenario"..attachment.id}, t("Set the animation scenario."), function(animation_scenario)
        set_current_animation(attachment, {
            name = animation_scenario,
            scenario = animation_scenario,
        })
    end)
    menu.hyperlink(attachment.menus.animation_set_by_name, t("Scenario List"), "https://gtaforums.com/topic/796181-list-of-scenarios-for-peds/")

end

---
--- Attachment Options Menu
---

constructor.add_child_attachment_menu = function(attachment)
    if attachment == attachment.parent then return end

    attachment.menus.attachment_options = menu.list(attachment.menus.options, t("Attachment Options"), {}, t("Additional options available for all entities attached to a parent object."), function()

        if attachment.menus.option_attached ~= nil then return end
        attachment.menus.option_attached = menu.toggle(attachment.menus.attachment_options, t("Attached"), {}, t("Is this child physically attached to the parent, or does it move freely on its own."), function(on)
            attachment.options.is_attached = on
            constructor_lib.attach_entity(attachment)
        end, attachment.options.is_attached)
        attachment.menus.option_parent_attachment = menu.list(attachment.menus.attachment_options, t("Change Parent"), {}, t("Select a new parent for this child. Construct will be rebuilt to accommodate changes."), function()
            build_change_parent_menu(attachment)
        end)
        attachment.menus.option_edit_rotation_order = menu.list_select(attachment.menus.attachment_options, t("Rotation Order"), {"constructorrotationorder"..attachment.id}, t("Set the order that rotations should be applied."), constants.rotation_orders, attachment.rotation_order + 1, function(index)
            attachment.rotation_order = constants.rotation_orders[index][4]
            constructor_lib.move_attachment(attachment)
        end)

        attachment.menus.option_bone_index = menu.slider(attachment.menus.attachment_options, t("Bone Index"), {}, t("Which bone of the parent should this entity be attached to"), -1, attachment.parent.num_bones or 200, attachment.options.bone_index or -1, 1, function(value)
            attachment.options.bone_index = value
            constructor_lib.attach_entity(attachment)
        end)

        attachment.menus.option_bone_index_picker = menu.list(attachment.menus.attachment_options, t("Bone Index Picker"), {}, t("Some common bones can be selected by name"))
        for _, bone_index_category in pairs(constants.bone_index_names) do
            local category_menu = menu.list(attachment.menus.option_bone_index_picker, bone_index_category.name)
            for _, bone_name in pairs(bone_index_category.bone_names) do
                menu.action(category_menu, bone_name, {}, "", function()
                    attachment.options.bone_index = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(attachment.parent.handle, bone_name)
                    constructor_lib.attach_entity(attachment)
                    menu.set_value(attachment.menus.option_bone_index, attachment.options.bone_index)
                    menu.focus(attachment.menus.option_bone_index)
                end)
            end
        end

        attachment.menus.option_soft_pinning = menu.toggle(attachment.menus.attachment_options, t("Soft Pinning"), {}, t("Will the attachment detach when repaired"), function(on)
            attachment.options.use_soft_pinning = on
            constructor_lib.attach_entity(attachment)
        end, attachment.options.use_soft_pinning)
        attachment.menus.detach = menu.action(attachment.menus.attachment_options, t("Separate"), {}, t("Detach attachment from construct to create a new construct"), function()
            local original_parent = attachment.parent
            constructor_lib.separate_attachment(attachment)
            table.insert(spawned_constructs, attachment)
            attachment.menus = nil
            menus.rebuild_attachment_menu(attachment)
            original_parent.functions.refresh()
            attachment.functions.refresh()
            attachment.functions.focus()
            menus.refresh_loaded_constructs()
        end)

        menus.refresh_attachment_menu_is_editing(attachment)
    end)
end

---
--- Entity Options Menu
---

constructor.add_attachment_entity_options = function(attachment)

    attachment.menus.more_options = menu.list(attachment.menus.options, t("Entity Options"), {}, t("Additional options available for all entities."), function()

        if attachment.menus.option_has_special_physics ~= nil then return end

        attachment.menus.option_has_special_physics = menu.toggle(attachment.menus.more_options, t("Special Physics"), {}, t("Allow for special physics overrides"), function(on)
            attachment.options.has_special_physics = on
            constructor_lib.attach_entity(attachment)
        end, attachment.options.has_special_physics)

        attachment.menus.option_has_gravity = menu.toggle(attachment.menus.more_options, t("Gravity"), {}, t("Will the attachment be effected by gravity, or be weightless"), function(on)
            attachment.options.has_gravity = on
            constructor_lib.attach_entity(attachment)
        end, attachment.options.has_gravity)

        attachment.menus.option_lod_distance = menu.slider(attachment.menus.more_options, t("LoD Distance"), {"constructorsetloddistance"..attachment.id}, t("Level of Detail draw distance"), 1, 9999999, attachment.options.lod_distance, 100, function(value)
            attachment.options.lod_distance = value
            constructor_lib.attach_entity(attachment)
        end)

        attachment.menus.option_gravity = menu.slider(attachment.menus.more_options, t("Gravity"), {"constructorsetgravity"..attachment.id}, t(""), 0, 100, attachment.options.gravity, 1, function(value)
            attachment.options.gravity = value
            constructor_lib.deserialize_entity_attributes(attachment)
        end)

        attachment.menus.option_alpha = menu.slider(attachment.menus.more_options, t("Alpha"), {}, t("The amount of transparency the object has. Local only!"), 0, 255, attachment.options.alpha, 51, function(value)
            attachment.options.alpha = value
            constructor_lib.attach_entity(attachment)
        end)

        attachment.menus.option_object_tint = menu.slider(attachment.menus.more_options, t("Object Tint"), {}, t("The color of the object"), 0, 15, attachment.options.object_tint or 0, 1, function(value)
            attachment.options.object_tint = value
            constructor_lib.deserialize_entity_attributes(attachment)
        end)

        attachment.menus.option_mission_entity = menu.toggle(attachment.menus.more_options, t("Mission Entity"), {}, t("If attachment is treated as a mission entity."), function(on)
            attachment.options.is_mission_entity = on
            constructor_lib.attach_entity(attachment)
        end, attachment.options.is_mission_entity)

        attachment.menus.spawn_at_position = menu.toggle(attachment.menus.more_options, t("Always Spawn at Position"), {}, t("Will this construct always spawn at the same world position it's in now (for stationary maps) or in front of the player (for props or small structures)"), function(on)
            attachment.always_spawn_at_position = on
        end, attachment.always_spawn_at_position)

        -- Blip
        if attachment == attachment.parent then
            menu.divider(attachment.menus.more_options, t("Blip"))
            attachment.menus.option_blip_sprite = menu.slider(attachment.menus.more_options, t("Blip Sprite"), {"constructorsetblipsprite"..attachment.id}, t("Icon to show on mini map for this construct"), 1, 826, attachment.blip_sprite, 1, function(value)
                attachment.blip_sprite = value
                constructor_lib.refresh_blip(attachment)
            end)
            attachment.menus.option_blip_color = menu.slider(attachment.menus.more_options, t("Blip Color"), {"constructorsetblipcolor"..attachment.id}, t("Mini map icon color"), 1, 85, attachment.blip_color, 1, function(value)
                attachment.blip_color = value
                constructor_lib.refresh_blip(attachment)
            end)
            menu.hyperlink(attachment.menus.more_options, t("Blip Reference"), "https://docs.fivem.net/docs/game-references/blips/", t("Reference website for blip details"))
        end

        -- Lights
        menu.divider(attachment.menus.more_options, t("Lights"))
        attachment.menus.option_is_light_on = menu.toggle(attachment.menus.more_options, t("Light On"), {}, t("If attachment is a light, it will be on and lit (many lights only work during night time)."), function(on)
            attachment.options.is_light_on = on
            constructor_lib.attach_entity(attachment)
        end, attachment.options.is_light_on)
        attachment.menus.option_light_disabled = menu.toggle(attachment.menus.more_options, t("Light Disabled"), {}, t("If attachment is a light, it will be ALWAYS off, regardless of others settings."), function(on)
            attachment.options.is_light_disabled = on
            constructor_lib.attach_entity(attachment)
        end, attachment.options.is_light_disabled)

        -- Proofs
        menu.divider(attachment.menus.more_options, t("Proofs"))
        attachment.menus.option_is_bullet_proof = menu.toggle(attachment.menus.more_options, t("Bullet Proof"), {}, t("If attachment is impervious to damage from bullets."), function(on)
            attachment.options.is_bullet_proof = on
            constructor_lib.attach_entity(attachment)
        end, attachment.options.is_bullet_proof)
        attachment.menus.option_is_fire_proof = menu.toggle(attachment.menus.more_options, t("Fire Proof"), {}, t("If attachment is impervious to damage from fire."), function(on)
            attachment.options.is_fire_proof = on
            constructor_lib.attach_entity(attachment)
        end, attachment.options.is_fire_proof)
        attachment.menus.option_is_explosion_proof = menu.toggle(attachment.menus.more_options, t("Explosion Proof"), {}, t("If attachment is impervious to damage from explosions."), function(on)
            attachment.options.is_explosion_proof = on
            constructor_lib.attach_entity(attachment)
        end, attachment.options.is_explosion_proof)
        attachment.menus.option_is_melee_proof = menu.toggle(attachment.menus.more_options, t("Melee Proof"), {}, t("If attachment is impervious to damage from melee attacks."), function(on)
            attachment.options.is_melee_proof = on
            constructor_lib.attach_entity(attachment)
        end, attachment.options.is_melee_proof)

        menus.refresh_attachment_menu_is_editing(attachment)
    end)
end

---
--- Add Attachment Menu
---

constructor.add_attachment_add_attachment_options = function(attachment)

    --menu.divider(attachment.menus.main, t("Attachments"))
    --attachment.menus.attachments = menu.list(attachment.menus.main, t("Attachments"))
    attachment.menus.add_attachment = menu.list(attachment.menus.main, t("Add Attachment"), {}, t("Options for attaching other entities to this construct"), function()

        if attachment.menus.curated_attachments ~= nil then return end
        --预留attachment.menus.curated_attachments = menu.list(attachment.menus.add_attachment, t("Curated"), {}, t("Browse a curated collection of attachments"))
        for _, curated_item in pairs(constructor_lib.table_copy(curated_attachments)) do
            build_curated_attachments_menu(attachment, attachment.menus.curated_attachments, curated_item)
        end

        attachment.menus.search_add_prop = menu.list(attachment.menus.add_attachment, t("Search"), {}, t("Search for a prop by name"), function()
            menu.show_command_box("constructorsearchprop"..attachment.id.." ")
        end)
        menu.text_input(attachment.menus.search_add_prop, t("Search"), {"constructorsearchprop"..attachment.id}, "", function (query)
            delete_menu_list(attachment.temp.prop_search_results)
            attachment.temp.prop_search_results = {}
            search({
                query=query,
                results=attachment.temp.prop_search_results,
                menus={
                    root=attachment.menus.search_add_prop,
                },
                query_function=function(search_params)
                    debug_log("Searching for attachment to "..attachment.name.." query: "..inspect(search_params))
                    local results = {}
                    for prop in io.lines(PROPS_PATH) do
                        local i, j = prop:find(search_params.query)
                        if i then
                            table.insert(results, { prop = prop, distance = j - i })
                        end
                    end
                    table.sort(results, function(a, b) return a.distance > b.distance end)
                    return results
                end,
                action_function=function(search_params, item)
                    local model = item.prop
                    local search_result_menu = menu.action(search_params.menus.root, model, {}, "", function()
                        local construct_plan = {
                            root = attachment.root,
                            parent = attachment,
                            name = item.prop,
                            model = item.prop,
                        }
                        build_construct_from_plan(construct_plan)
                    end)
                    menu.on_focus(search_result_menu, function(direction) if direction ~= 0 then add_preview({ model=model}) end end)
                    menu.on_blur(search_result_menu, function(direction) if direction ~= 0 then remove_preview() end end)
                    return search_result_menu
                end,
            })
        end)

        attachment.menus.exact_name = menu.list(attachment.menus.add_attachment, t("Add by Name"), {}, t("Add an object, vehicle, or ped by exact name."))
        menu.text_input(attachment.menus.exact_name, t("Object by Name"), {"constructorattachobject"..attachment.id},
                t("Add an in-game object by exact name. To search for objects try https://gta-objects.xyz/"), function (value)
                    build_construct_from_plan({
                        root = attachment.root, parent = attachment, name = value, model = value,
                    })
                end)
        menu.text_input(attachment.menus.exact_name, t("Object by Hash"), {"constructorattachobjecthash"..attachment.id},
                t("Add an in-game object by exact name. To search for objects try https://gta-objects.xyz/"), function (value)
                    build_construct_from_plan({
                        root = attachment.root, parent = attachment, name = value, hash = value,
                    })
                end)
        menu.text_input(attachment.menus.exact_name, t("Vehicle by Name"), {"constructorattachvehicle"..attachment.id},
                t("Add a vehicle by exact name."), function (value)
                    build_construct_from_plan({
                        root = attachment.root, parent = attachment, name = value, model = value, type = "VEHICLE",
                    })
                end)
        menu.text_input(attachment.menus.exact_name, t("Ped by Name"), {"constructorattachped"..attachment.id},
                t("Add a vehicle by exact name."), function (value)
                    build_construct_from_plan({
                        root = attachment.root, parent = attachment, name = value, model = value, type = "PED",
                    })
                end)
        menu.hyperlink(attachment.menus.exact_name, t("Open gta-objects.xyz"), "https://gta-objects.xyz/", t("Website for browsing and searching for props"))

        menu.action(attachment.menus.add_attachment, t("Add Current Vehicle"), {}, t("Attach your current vehicle to the construct"), function(on)
            local vehicle = entities.get_user_vehicle_as_handle()
            if vehicle == 0 then
                util.toast(t("Error: You must be (or recently been) in a vehicle to create a construct from it"))
                return
            end
            add_attachment_from_vehicle_handle(attachment, vehicle)
        end)

        menu.toggle(attachment.menus.add_attachment, t("Add Attachment Gun"), {}, t("Anything you shoot with this enabled will be added to the current construct"), function(on)
            config.add_attachment_gun_active = on
            config.add_attachment_gun_recipient = attachment
        end, config.add_attachment_gun_active)

        attachment.menus.add_construct = menu.list(attachment.menus.add_attachment, t("Other Construct"), {}, t("Attach another construct to the current construct"), function()
            local load_constructs_root_menu_file = {menu=attachment.menus.add_construct, name=t("Loaded Constructs Menu"), menus={}}
            local action_function = function(construct_plan_file)
                local construct_plan = load_construct_plan_file(construct_plan_file)
                if construct_plan then
                    construct_plan.root = attachment.root
                    construct_plan.parent = attachment
                    construct_plan.options.is_attached = true
                    build_construct_from_plan(construct_plan)
                end
            end
            constructor.add_directory_to_load_constructs(CONSTRUCTS_DIR, load_constructs_root_menu_file, action_function)
        end)

    end)
end

---
--- Edit Attachments Menu
---

constructor.add_attachment_edit_attachments_options = function(attachment)
    attachment.menus.edit_attachments = menu.list(attachment.menus.main, t("Edit Attachments").." ("..#attachment.children..")", {}, t("Modify other entities attached to this entity"), function()
        for _, child_attachment in pairs(attachment.children) do
            menus.rebuild_attachment_menu(child_attachment)
        end
    end)
end

---
--- Clone Attachment Menu
---

constructor.add_attachment_clone_attachments_options = function(attachment)
    attachment.menus.clone_options = menu.list(attachment.menus.main, t("Clone"), {}, t("Make a copy of this attachment"), function()
        if attachment.menus.clone_in_place ~= nil then return end
        attachment.menus.clone_in_place = menu.action(attachment.menus.clone_options, t("Clone (In Place)"), {}, t("Make a new copy of this entity, at the same location as the original"), function()
            local new_attachment = constructor_lib.clone_attachment(attachment)
            build_construct_from_plan(new_attachment)
        end)
        attachment.menus.clone_reflection_x = menu.action(attachment.menus.clone_options, t("Clone Reflection: X:Left/Right"), {}, t("Make a new copy of this entity, but at the mirror location about the X-axis"), function()
            local new_attachment = constructor_lib.clone_attachment(attachment)
            new_attachment.offset = {x=-attachment.offset.x, y=attachment.offset.y, z=attachment.offset.z}
            build_construct_from_plan(new_attachment)
        end)
        attachment.menus.clone_reflection_y = menu.action(attachment.menus.clone_options, t("Clone Reflection: Y:Front/Back"), {}, t("Make a new copy of this entity, but at the mirror location about the Y-axis"), function()
            local new_attachment = constructor_lib.clone_attachment(attachment)
            new_attachment.offset = {x=attachment.offset.x, y=-attachment.offset.y, z=attachment.offset.z}
            build_construct_from_plan(new_attachment)
        end)
        attachment.menus.clone_reflection_z = menu.action(attachment.menus.clone_options, t("Clone Reflection: Z:Up/Down"), {}, t("Make a new copy of this entity, but at the mirror location about the Z-axis"), function()
            local new_attachment = constructor_lib.clone_attachment(attachment)
            new_attachment.offset = {x=attachment.offset.x, y=attachment.offset.y, z=-attachment.offset.z}
            build_construct_from_plan(new_attachment)
        end)
        menus.refresh_attachment_menu_is_editing(attachment)
    end)
end

constructor.add_attachment_teleport_options = function(attachment)
    attachment.menus.teleport = menu.list(attachment.menus.main, t("Teleport"), {}, t("Move your player to the construct, or vice versa."), function()
        if attachment.menus.teleport_to_construct ~= nil then return end
        if attachment.type == "VEHICLE" then
            attachment.menus.enter_drivers_seat = menu.action(attachment.menus.teleport, t("Teleport Into Vehicle"), {}, t("Move your player into the vehicle driver seat"), function()
                PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), attachment.handle, -1)
            end)
        end
        attachment.menus.teleport_to_construct = menu.action(attachment.menus.teleport, t("Teleport Me to Construct"), {}, t("Move your player nearby the construct, but not inside of it."), function()
            local pos = ENTITY.GET_ENTITY_COORDS(attachment.handle)
            local vehicle = entities.get_user_vehicle_as_handle()
            if vehicle and PED.IS_PED_SITTING_IN_VEHICLE(players.user_ped(), vehicle) then
                ENTITY.SET_ENTITY_COORDS(vehicle, pos.x, pos.y, pos.z)
                VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(vehicle, 5)
            else
                ENTITY.SET_ENTITY_COORDS(players.user_ped(), pos.x, pos.y, pos.z)
            end
        end)
        attachment.menus.teleport_construct_to_me = menu.action(attachment.menus.teleport, t("Teleport Construct to Me"), {}, t("Move the construct to be nearby your player"), function()
            local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 2.0, 0.0)
            attachment.position = { x=pos.x, y=pos.y, z=pos.z }
            constructor_lib.update_attachment_position(attachment)
            constructor_lib.place_on_ground(attachment)
        end)
        menus.refresh_attachment_menu_is_editing(attachment)
    end)
end

---
--- Rebuild Attachment Menu
---

constructor.add_attachment_rebuild_attachment_option = function(attachment)
    attachment.menus.reconstruct_vehicle = menu.action(attachment.menus.main, t("Rebuild"), {}, t("Delete construct (if it still exists), then recreate a new one from scratch."), function()
        rebuild_attachment(attachment)
    end)
end

---
--- Save Attachment Menu
---

constructor.add_attachment_save_attachment_option = function(attachment)
    attachment.menus.save = menu.text_input(attachment.menus.main, t("Save As"), { "constructorsaveas"..attachment.id}, t("Save construct to disk"), function(value)
        attachment.name = value
        save_vehicle(attachment)
        attachment.functions.refresh()
    end, attachment.name)
end

---
--- Delete Attachment Menu
---

constructor.add_attachment_delete_attachment_option = function(attachment)
    attachment.menus.delete = menu.action(attachment.menus.main, t("Delete"), {}, t("Delete construct and all attachments. Cannot be reconstructed unless saved."), function()
        if #attachment.children > 0 then
            debug_log("Show warning "..attachment.name)
            menu.show_warning(attachment.menus.main, CLICK_COMMAND, t("Are you sure you want to delete this construct? ")..#attachment.children..t(" children will also be deleted."), function()
                constructor.delete_construct(attachment)
            end)
        else
            constructor.delete_construct(attachment)
        end
    end)
end

menus.refresh_attachment_menu_is_editing = function(attachment)
    for _, menu_handle in pairs(attachment.menus) do
        menu.on_focus(menu_handle, function(direction) if direction ~= 0 then attachment.is_editing = true end end)
        menu.on_blur(menu_handle, function(direction) if direction ~= 0 then attachment.is_editing = false end end)
    end
end

menus.rebuild_attachment_menu = function(attachment)
    if constructor_lib.is_attachment_entity(attachment) and (not attachment.handle) then error("Attachment missing handle "..tostring(attachment.name)) end
    if attachment.menus ~= nil then return end
    debug_log("Rebuilding attachment menu "..tostring(attachment.name), attachment)
    attachment.menus = {}

    local parent_menu
    if attachment == attachment.parent then
        parent_menu = menus.loaded_constructs
    else
        parent_menu = attachment.parent.menus.edit_attachments
    end

    attachment.menus.main = menu.list(parent_menu, attachment.name, {}, "", function()

        for _, child_attachment in pairs(attachment.children) do
            menus.rebuild_attachment_menu(child_attachment)
            util.yield_once()
        end
    end)

    constructor.add_attachment_info_menu(attachment)
    constructor.add_attachment_position_menu(attachment)
    constructor.add_attachment_options_menu(attachment)

    if constructor_lib.is_attachment_entity(attachment) then
        constructor.add_attachment_add_attachment_options(attachment)
        constructor.add_attachment_edit_attachments_options(attachment)
        constructor.add_attachment_clone_attachments_options(attachment)
        constructor.add_attachment_teleport_options(attachment)
    end

    constructor.add_attachment_rebuild_attachment_option(attachment)
    constructor.add_attachment_save_attachment_option(attachment)
    constructor.add_attachment_delete_attachment_option(attachment)

    menus.refresh_attachment_menu_is_editing(attachment)

    if attachment.functions == nil then attachment.functions = {} end
    attachment.functions.refresh = function(updated_attachment)
        debug_log("Refreshing attachment menu "..tostring(attachment.name))
        if attachment.menus.main:isValid() then
            menu.set_menu_name(attachment.menus.main, attachment.name)
        end
        if attachment.menus.edit_attachments and attachment.menus.edit_attachments:isValid() then
            menu.set_menu_name(attachment.menus.edit_attachments, t("Edit Attachments").." ("..#attachment.children..")")
        end
        menus.rebuild_attachment_menu(attachment)
        menus.refresh_loaded_constructs()
        if updated_attachment ~= nil and updated_attachment.functions ~= nil then
            updated_attachment.functions.focus()
        end
    end
    attachment.functions.focus = function()
        if config.focus_menu_on_spawned_constructs and attachment.root.menu_auto_focus ~= false and attachment.menus.info ~= nil then
            if attachment.menus.info:isValid() then
                debug_log("Focusing on attachment menu "..tostring(attachment.name))
                menu.focus(attachment.menus.info)
            else
                debug_log("Invalid info menu. Cannot focus "..attachment.name)
            end
        end
    end

end

---
--- Create New Construct Menu
---

menus.create_new_construct = menu.list(Constructor_Lua_Load, t("Create New Construct"), {}, t("Create a new construct from a base vehicle, object, or ped. Then extend it with attachments. Finally save your creation and share it with others."))

--local function convert_vehicles_json_to_table()
--    local file = io.open(filesystem.scripts_dir().."/lib/vehicles.json")
--    local status, vehicles
--    if file then
--        local vehicles_file_data = file:read("*a")
--        file:close()
--        --debug_log("Vehicles data "..inspect(vehicles_file_data))
--        status, vehicles = pcall(soup.json.decode, vehicles_file_data)
--    end
--    --debug_log("Vehicles  "..inspect(vehicles))
--end

menus.create_from_vehicle_list = menu.list(menus.create_new_construct, t("From Vehicle List"), {}, t("Create a new construct from a list of vehicles"), function()
    for _, curated_section in pairs(curated_attachments) do
        if curated_section.name == "Vehicles" then
            for _, curated_item in pairs(curated_section.items) do
                build_curated_constructs_menu(menus.create_from_vehicle_list, curated_item)
            end
        end
    end
end)

menu.text_input(menus.create_new_construct, t("From Vehicle Name"), { "constructcreatefromvehiclename"}, t("Create a new construct from an exact vehicle name"), function(value, click_type)
    if click_type ~= 1 then return end
    local construct_plan = {
        model = value,
        type="VEHICLE",
    }
    construct_plan.root = construct_plan
    construct_plan.parent = construct_plan
    build_construct_from_plan(construct_plan)
end)

---
--- Load Construct Menu
---

local function add_load_construct_plan_file_menu(root_menu, construct_plan_file)
    construct_plan_file.load_menu = menu.action(root_menu, construct_plan_file.name, {}, "", function()
        remove_preview()
        local construct_plan = load_construct_plan_file(construct_plan_file)
        if construct_plan then
            construct_plan.root = construct_plan
            construct_plan.parent = construct_plan
            build_construct_from_plan(construct_plan)
        end
    end)
    menu.on_focus(construct_plan_file.load_menu, function(direction) if direction ~= 0 then add_preview(load_construct_plan_file(construct_plan_file), construct_plan_file.preview_image_path) end end)
    menu.on_blur(construct_plan_file.load_menu, function(direction) if direction ~= 0 then remove_preview() end end)
end

local load_constructs_root_menu_file
menus.load_construct = menu.list(Constructor_Lua_Load, t("Load Construct"), {"constructorloadconstruct"}, t("Load a previously saved or shared construct into the world"), function()
    menus.rebuild_load_construct_menu()
    if #load_constructs_root_menu_file.menus == 0 then
        util.toast("No constructs found!", TOAST_ALL)
        menu.show_warning(Constructor_Lua_Load, CLICK_COMMAND, t(
                "No constructs found! Would you like to download a curated collection of constructs? "
                        .."This includes popular vehicles, maps and skins to get started with Constructor. "
                        .."Installer requires special permissions for direct access to system for unzipping."), function()
            install_curated_constructs()
            menus.rebuild_load_construct_menu()
        end)
    end
end)
load_constructs_root_menu_file = {menu=menus.load_construct, name=t("Loaded Constructs Menu"), menus={}}

menus.search_constructs = menu.list(menus.load_construct, t("Search"), {}, t("Search all your construct files"), function()
    menu.show_command_box("constructorsearch ")
end)
local previous_search_results = {}
menus.load_construct_search = menu.text_input(menus.search_constructs, t("Search"), {"constructorsearch"}, t("Edit your search query"), function(query)
    for _, previous_search_result in pairs(previous_search_results) do
        if previous_search_result.load_menu and previous_search_result.load_menu:isValid() then
            menu.delete(previous_search_result.load_menu)
        end
    end
    previous_search_results = {}
    local results = search_constructs(CONSTRUCTS_DIR, query)
    if #results == 0 then
        local divider = {}
        divider.load_menu = menu.divider(menus.search_constructs, t("No results found"))
        table.insert(previous_search_results, divider)
    else
        for _, result in pairs(results) do
            add_load_construct_plan_file_menu(menus.search_constructs, result)
            table.insert(previous_search_results, result)
        end
    end
end)

menus.load_construct_options = menu.list(menus.load_construct, t("Options"))
menu.action(menus.load_construct_options, t("Open Constructs Folder"), {}, t("Open constructs folder. Share your creations or add new creations here."), function()
    util.open_folder(CONSTRUCTS_DIR)
end)
-- menu.hyperlink(menus.load_construct_options, t("Open Curated Constructs Collection"), "https://github.com/hexarobi/stand-curated-constructs", t("Open curated constructs collection website for manual installation."))

menu.toggle(menus.load_construct_options, t("Drive Spawned Vehicles"), {}, t("When spawning vehicles, automatically place you into the drivers seat."), function(on)
    config.drive_spawned_vehicles = on
end, config.drive_spawned_vehicles)
menu.toggle(menus.load_construct_options, t("Wear Spawned Peds"), {}, t("When spawning peds, replace your player skin with the ped."), function(on)
    config.wear_spawned_peds = on
end, config.wear_spawned_peds)
menu.toggle(menus.load_construct_options, t("Focus Menu on Spawned Constructs"), {}, t("When spawning a construct, focus Stands menu on the newly spawned construct. Otherwise, stay in the Load Constructs menu."), function(on)
    config.focus_menu_on_spawned_constructs = on
end, config.focus_menu_on_spawned_constructs)

menu.divider(menus.load_construct, t("Browse"))

constructor.add_directory_to_load_constructs = function(path, parent_construct_plan_file, action_function)
    if path == nil then path = CONSTRUCTS_DIR end
    if parent_construct_plan_file == nil then parent_construct_plan_file = load_constructs_root_menu_file end
    if parent_construct_plan_file.menus == nil then parent_construct_plan_file.menus = {} end
    for _, construct_plan_menu in pairs(parent_construct_plan_file.menus) do
        if construct_plan_menu and construct_plan_menu:isValid() then
            menu.delete(construct_plan_menu)
        end
    end

    if action_function == nil then
        action_function = function(construct_plan_file)
            local construct_plan = load_construct_plan_file(construct_plan_file)
            if construct_plan then
                construct_plan.root = construct_plan
                construct_plan.parent = construct_plan
                build_construct_from_plan(construct_plan)
            end
        end
    end

    if path == CONSTRUCTS_DIR and filesystem.exists(JACKZ_BUILD_DIR) then
        local jackz_builds = {}
        jackz_builds.menu = menu.list(load_constructs_root_menu_file.menu, "Jackz Builds", {}, "Builds from Jackz Vehicle Builder", function()
            constructor.add_directory_to_load_constructs(JACKZ_BUILD_DIR, jackz_builds, action_function)
        end)
        table.insert(load_constructs_root_menu_file.menus, jackz_builds.menu)
    end

    local construct_plan_files = load_construct_plans_files_from_dir(path)
    for _, construct_plan_file in pairs(construct_plan_files) do
        if construct_plan_file.is_directory then
            construct_plan_file.menu = menu.list(parent_construct_plan_file.menu, construct_plan_file.name or "unknown", {}, "", function()
                constructor.add_directory_to_load_constructs(path.."/"..construct_plan_file.filename, construct_plan_file, action_function)
            end)
            table.insert(parent_construct_plan_file.menus, construct_plan_file.menu)
        end
    end
    for _, construct_plan_file in pairs(construct_plan_files) do
        if not construct_plan_file.is_directory then
            if is_file_type_supported(construct_plan_file.ext) then
                construct_plan_file.load_menu = menu.action(parent_construct_plan_file.menu, construct_plan_file.name, {}, "", function()
                    remove_preview()
                    action_function(construct_plan_file)
                    --local construct_plan = load_construct_plan_file(construct_plan_file)
                    --if construct_plan then
                    --    construct_plan.root = construct_plan
                    --    construct_plan.parent = construct_plan
                    --    build_construct_from_plan(construct_plan)
                    --end
                end)
                menu.on_focus(construct_plan_file.load_menu, function(direction) if direction ~= 0 then add_preview(load_construct_plan_file(construct_plan_file), construct_plan_file.preview_image_path) end end)
                menu.on_blur(construct_plan_file.load_menu, function(direction) if direction ~= 0 then remove_preview() end end)
                table.insert(parent_construct_plan_file.menus, construct_plan_file.load_menu)
            end
        end
    end
end

menus.rebuild_load_construct_menu = function()
    constructor.add_directory_to_load_constructs(CONSTRUCTS_DIR, load_constructs_root_menu_file)
end

---
--- Player Menu
---

--[[local player_menu_actions = function(pid)
    menus.constructor_player_menu = menu.divider(menu.player_root(pid), t("Constructor"))

    menus.spawn_commands = menu.list(menu.player_root(pid), t("Chat Spawn Commands"))
    local construct_plan_files = load_all_construct_plan_files_from_dir(CONSTRUCTS_DIR..config.chat_spawnable_dir)
    for _, construct_plan_file in pairs(construct_plan_files) do
        if not construct_plan_file.is_directory and is_file_type_supported(construct_plan_file.ext) then
            menu.action(menus.spawn_commands, construct_plan_file.name, {construct_plan_file.name}, "", function()
                local construct_plan = load_construct_plan_file(construct_plan_file)
                if construct_plan then
                    construct_plan.root = construct_plan
                    construct_plan.parent = construct_plan
                    construct_plan.name = construct_plan.name .. " [".. PLAYER.GET_PLAYER_NAME(pid) .."]"
                    construct_plan.options.spawn_for_player = pid
                    construct_plan.menu_auto_focus = false
                    build_construct_from_plan(construct_plan)
                end
            end, nil, nil, COMMANDPERM_SPAWN)
        end
    end

end

players.on_join(player_menu_actions)
players.dispatch_on_join()--]]

---
--- Loaded Constructs Menu
---

menus.loaded_constructs = menu.list(Constructor_Lua_Load, t("Loaded Constructs").." ("..#spawned_constructs..")", {}, t("View and edit already loaded constructs"))
menus.refresh_loaded_constructs = function()
    menu.set_menu_name(menus.loaded_constructs, t("Loaded Constructs").." ("..#spawned_constructs..")")
end

---
--- Global Options Menu
---

menus.settings_menu = menu.list(Constructor_Lua_Load, t("Settings"), {}, t("Set global configuration options."))

menus.editing_settings = menu.list(menus.settings_menu, t("Editing"), {}, t("Set configuration options relating to editing constructs."))
menu.slider(menus.editing_settings, t("Edit Offset Step"), {}, t("The amount of change each time you edit an attachment offset (hold SHIFT for fine tuning)"), 1, 50, config.edit_offset_step, 1, function(value)
    config.edit_offset_step = value
end)
menu.slider(menus.editing_settings, t("Edit Rotation Step"), {}, t("The amount of change each time you edit an attachment rotation (hold SHIFT for fine tuning)"), 1, 30, config.edit_rotation_step, 1, function(value)
    config.edit_rotation_step = value
end)
menu.toggle(menus.editing_settings, t("Gizmo Edit Mode"), {}, t("Enabled mouse-based edit mode. Click any world object to enable edit handles."), function(toggle)
    state.gizmo_edit_mode = toggle
end, state.gizmo_edit_mode)

menus.preview_settings = menu.list(menus.settings_menu, t("Previews"), {}, t("Set configuration options relating to previewing constructs."))
menu.toggle(menus.preview_settings, t("Show Previews"), {}, t("Show previews when adding attachments"), function(on)
    config.show_previews = on
end, config.show_previews)
menu.slider(menus.preview_settings, t("Preview Display Delay"), {"constructorpreviewdisplaydelay"}, t("After browsing to a construct or attachment, wait this long before showing the preview."), 100, 1000, config.preview_display_delay, 50, function(value)
    config.preview_display_delay = value
end)

menus.spawn_settings = menu.list(menus.settings_menu, t("Spawn"), {}, t("Set configuration options relating to spawning constructs."))
menu.toggle(menus.spawn_settings, t("Focus Menu on Spawned Constructs"), {}, t("When spawning a construct, focus Stands menu on the newly spawned construct. Otherwise, stay in the Load Constructs menu."), function(on)
    config.focus_menu_on_spawned_constructs = on
end, config.focus_menu_on_spawned_constructs)
menu.slider(menus.spawn_settings, t("Spawn Entity Delay"), {"constructorspawnentitydelay"}, t("Pause after spawning any object. Useful for preventing issues when spawning large constructs with many objects."), 0, 500, config.spawn_entity_delay, 1, function(value)
    config.spawn_entity_delay = value
end)
menu.text_input(menus.spawn_settings, t("Chat Spawnable Dir"), {"constructorspawnabledir"}, t("Set a Constructs sub-folder to be spawnable by name. Only available for users with permission to use Spawn Commands. See Online>Chat>Commands"), function(value)
    config.chat_spawnable_dir = value
end, config.chat_spawnable_dir)
menu.slider(menus.spawn_settings, t("Constructs Allowed Per Player"), {"constructorspawnsallowedperplayer"}, t("The number of constructs any one player can spawn at a time. When a player tried to spawn additional constructs past this limit, the oldest spawned construct will be deleted."), 1, 5, config.num_allowed_spawned_constructs_per_player, 1, function(value)
    config.num_allowed_spawned_constructs_per_player = value
end)
menu.toggle(menus.spawn_settings, t("Delete All on Unload"), {}, t("Deconstruct all spawned constructs when unloading Constructor"), function(on)
    config.deconstruct_all_spawned_constructs_on_unload = on
end, config.deconstruct_all_spawned_constructs_on_unload)

menus.debug_settings = menu.list(menus.settings_menu, t("Debug"), {}, t("Set configuration options relating to debugging the menu."))
menu.toggle(menus.debug_settings, t("Debug Mode"), {}, t("Log additional details about Constructors actions."), function(toggle)
    config.debug_mode = toggle
end, config.debug_mode)
menu.action(menus.debug_settings, t("Log Missing Translations"), {}, t("Log any newly found missing translations"), function()
    translations.log_missing_translations()
end)

menu.divider(menus.settings_menu, t("Clean Up"))
menu.slider(menus.settings_menu, t("Clean Up Distance"), {"constructorcleanupdistance"}, t("How far away the cleanup command will reach to delete entities."), 0, 10000, config.clean_up_distance, 100, function(value)
    config.clean_up_distance = value
end)
menu.action(menus.settings_menu, t("Clean Up"), {"cleanup"}, t("Remove nearby vehicles, objects and peds. Useful to delete any leftover construction debris."), function()
    local vehicles = delete_entities_by_range(entities.get_all_vehicles_as_handles(),config.clean_up_distance, "VEHICLE")
    local objects = delete_entities_by_range(entities.get_all_objects_as_handles(),config.clean_up_distance, "OBJECT")
    local peds = delete_entities_by_range(entities.get_all_peds_as_handles(),config.clean_up_distance, "PED")
    local player_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()), 1)
    GRAPHICS.REMOVE_PARTICLE_FX_IN_RANGE(player_pos.x, player_pos.y, player_pos.z, config.clean_up_distance)
    util.toast(t("Removed").." "..objects.." "..t("objects")..", "..vehicles.." "..t("vehicles")..t(", and ")..peds.." "..t("peds"), TOAST_ALL)
end)

util.create_tick_handler(aim_info_tick)
util.create_tick_handler(update_preview_tick)
util.create_tick_handler(sensitivity_modifier_check_tick)
util.create_tick_handler(update_constructs_tick)
util.create_tick_handler(draw_editing_attachment_bounding_box_tick)
util.create_tick_handler(free_edit_mode_tick)
util.create_tick_handler(gizmo_edit_mode_tick)

util.on_stop(cleanup_constructs_handler)
