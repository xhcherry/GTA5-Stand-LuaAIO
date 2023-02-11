local SCRIPT_VERSION = "0.27b7"

local loading_menu = menu.divider(Constructor_Lua, "Loading...")

local inspect = require "lib.daidailib.constructor.inspect"

local constants = require "lib.daidailib.constructor.constants"

local constructor_lib = require "lib.daidailib.constructor.constructor_lib"

local convertors = require "lib.daidailib.constructor.convertors"

local curated_attachments = require "lib.daidailib.constructor.curated_attachments"

local translations = require "lib.daidailib.constructor.translations"


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

    debug_mode = false,
}
local config = CONSTRUCTOR_CONFIG

local function debug_log(message, additional_details)
    if CONSTRUCTOR_CONFIG.debug_mode then
        if CONSTRUCTOR_CONFIG.debug_mode == 2 and additional_details ~= nil then
            message = message .. "\n" .. inspect(additional_details)
        end
        util.log("[constructor_lib] "..message)
    end
end

---
--- Translations
---

local current_translations = {}
local missing_translations = {}
local LANG_STRING_NOT_FOUND = "/!\\ STRING NOT FOUND /!\\"

function CONSTRUCTOR_TRANSLATE_FUNCTION(text)
    local translated_string = current_translations[text]
    if translated_string ~= nil and translated_string ~= LANG_STRING_NOT_FOUND then
        --debug_log("Found local translation for '"..text.."'")
        return translated_string
    end
    local label_id = lang.find(text, "en")
    if label_id then
        --debug_log("Found global translation for '"..text.."'")
        translated_string = lang.get_string(label_id, lang.get_current())
        if translated_string ~= LANG_STRING_NOT_FOUND then
            return translated_string
        end
    else
        --debug_log("Missing translation: "..text)
        missing_translations[text] = text
    end
    return text
end

-- Shorthand wrapper for translation function
local function t(text)
    return CONSTRUCTOR_TRANSLATE_FUNCTION(text)
end

for lang_id, language_key in pairs(translations.GAME_LANGUAGE_IDS) do
    if translations[lang_id] ~= nil then
        --debug_log("Processing translations language "..lang_id)
        lang.set_translate(lang_id)
        for english_string, translated_string in pairs(translations[lang_id]) do
            local label_id = lang.find(english_string, "en")
            --debug_log("Found label for '"..english_string.."' as label "..label_id)
            if (not label_id) or label_id == 0 then
                label_id = lang.register(english_string)
                --debug_log("Registered '"..english_string.."' as label "..label_id)
            end
            local existing_translation = lang.get_string(label_id, lang_id)
            if (not existing_translation) or existing_translation == english_string or existing_translation == LANG_STRING_NOT_FOUND then
                --debug_log("Adding translation for "..lang_id.." '"..english_string.."' ["..label_id.."] as '"..translated_string.."'  Existing translation: '"..existing_translation.."'")
                if label_id > 0 then
                    local translate_status, translate_response = pcall(lang.translate, label_id, translated_string)
                    if not translate_status then
                        debug_log("Failed to add translation '"..english_string.."' as label "..label_id)
                    end
                else
                    --debug_log("Cannot translate internal label")
                end
                if lang_id == lang.get_current() then
                    current_translations[english_string] = translated_string
                end
            else
                --debug_log("Found translation for "..lang_id.." '"..english_string.."' ["..label_id.."] as '"..existing_translation.."'")
            end
        end
    end
end

local function log_missing_translations()
    util.toast("Missing translations", TOAST_ALL)
    util.log(inspect(missing_translations))
end


local status_natives, natives = pcall(require, "lib.daidailib.natives")


local PROPS_PATH = filesystem.scripts_dir().."lib.daidailib.constructor.objects_complete.txt"

pcall(menu.delete, loading_menu)

local VERSION_STRING = SCRIPT_VERSION.." / "..constructor_lib.LIB_VERSION .. " / " .. convertors.SCRIPT_VERSION

---
--- Data
---

local constructor = {}

local CONSTRUCTS_DIR = filesystem.scripts_dir() .. "/daidaiScript/" .. 'Constructs\\'
filesystem.mkdirs(CONSTRUCTS_DIR)

local JACKZ_BUILD_DIR = filesystem.scripts_dir() .. "/daidaiScript/" .. 'Constructs\\' .. 'Builds\\'

local spawned_constructs = {}
local last_spawned_construct
local menus = {
    children = {}
}
local original_player_skin
local player_construct

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

local function get_player_construct()
    if player_construct == nil then
        save_original_player_skin()
        player_construct = constructor_lib.table_copy(constructor_lib.construct_base)
        player_construct.handle=players.user_ped()
        player_construct.type="PED"
        player_construct.name="Player"
        player_construct.is_player=true
        player_construct.root = player_construct
        player_construct.parent = player_construct
    end
    return player_construct
end

local function restore_original_player_skin()
    debug_log("Restoring original player skin")
    if original_player_skin ~= nil then
        constructor_lib.deserialize_ped_attributes(original_player_skin)
    end
end

---
--- Preview
---

local current_preview
local next_preview
local image_preview
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
    local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(0)
    local cam_pos = CAM.GET_FINAL_RENDERED_CAM_COORD()
    local direction = rotation_to_direction(cam_rot)
    local destination =
    {
        x = cam_pos.x + direction.x * distance,
        y = cam_pos.y + direction.y * distance,
        z = cam_pos.z + direction.z * distance
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

local function remove_preview(construct_plan)
    next_preview = nil
    image_preview = nil
    if construct_plan == nil then construct_plan = current_preview end
    if construct_plan ~= nil then
        debug_log("Removing preview "..tostring(construct_plan.name))
        constructor_lib.remove_attachment(construct_plan)
        current_preview = nil
    end
end

local function calculate_camera_distance(attachment)
    if attachment.hash == nil then attachment.hash = util.joaat(attachment.model) end
    constructor_lib.load_hash_for_attachment(attachment)
    local l, w, h = calculate_model_size(attachment.hash, minVec, maxVec)
    attachment.camera_distance = math.max(l, w, h) + config.preview_camera_distance
    calculate_construct_size(attachment)
    attachment.camera_distance = math.max(attachment.dimensions.l, attachment.dimensions.w, attachment.dimensions.h) + config.preview_camera_distance
end

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
    if construct_plan.name ~= nil then table.insert(descriptions, "文件名: "..construct_plan.name) end
    table.insert(descriptions, t("类型: "..get_type(construct_plan)))
    
    if construct_plan.author ~= nil then table.insert(descriptions, t("作者: ")..construct_plan.author) end
    if construct_plan.description ~= nil then table.insert(descriptions, "1: "..construct_plan.description) end
    local counter = count_construct_children(construct_plan)
    if counter["TOTAL"] > 0 then
        table.insert(descriptions,
                "元素："..counter["TOTAL"].." "..t("attachments").." ("..counter["PED"].." "..t("peds")..", "..counter["OBJECT"].." "..t("objects")..", "..counter["VEHICLE"].." "..t("vehicles")..")")
    end
    local description_string = ""
    for _, description in pairs(descriptions) do
        description_string = description_string .. description .. "\n"
    end
    return description_string
end

local function use_player_as_base(attachment)
    if attachment.type ~= "PED" then return attachment end
    if attachment.hash == nil and attachment.model == nil then
        local player_preview = {handle=players.user_ped(), type="PED"}
        constructor_lib.serialize_ped_attributes(player_preview)
        player_preview.handle = nil
        return constructor_lib.table_merge(player_preview, attachment)
    end
    return attachment
end

local function add_preview(construct_plan, preview_image_path)
    if config.show_previews == false then return end
    remove_preview()
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
            attachment = use_player_as_base(attachment)
        elseif construct_plan.type == "PARTICLE" then
            attachment = {model="ng_proc_cigbuts02a", children={attachment}}
        end
        attachment.root = attachment
        attachment.parent = attachment
        attachment.is_preview = true
        constructor_lib.default_attachment_attributes(attachment)
        calculate_camera_distance(attachment)
        attachment.position = get_offset_from_camera(attachment.camera_distance)
        current_preview = constructor_lib.create_entity_with_children(attachment)
        if construct_plan.load_menu then
            pcall(menu.set_help_text, construct_plan.load_menu, get_construct_plan_description(current_preview))
        end
        if next_preview ~= construct_plan then
            remove_preview(current_preview)
        end
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
end

local function update_attachment_tick(attachment)
    --debug_log("Updating attachment tick "..attachment.name)
    constructor_lib.update_attachment_tick(attachment)
    for _, child_attachment in pairs(attachment.children) do
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
        set_attachment_edit_menu_sensitivity(child_attachment, offset_step, rotation_step)
    end
end

local is_fine_tune_sensitivity_active = false
local function sensitivity_modifier_check_tick()
    if util.is_key_down(0x10) then
        if is_fine_tune_sensitivity_active == false then
            for _, construct in pairs(spawned_constructs) do
                set_attachment_edit_menu_sensitivity(construct, 1, 1)
            end
            is_fine_tune_sensitivity_active = true
        end
    else
        if is_fine_tune_sensitivity_active == true then
            for _, construct in pairs(spawned_constructs) do
                set_attachment_edit_menu_sensitivity(construct, config.edit_offset_step, config.edit_rotation_step)
            end
            is_fine_tune_sensitivity_active = false
        end
    end
end

local function draw_editing_bounding_box(attachment)
    if attachment.is_editing and menu.is_open() then
        --debug_log("Drawing bounding box tick "..attachment.name)
        constructor_lib.draw_bounding_box(attachment.handle, config.preview_bounding_box_color)
    end
    for _, child_attachment in pairs(attachment.children) do
        draw_editing_bounding_box(child_attachment)
    end
end

local function draw_editing_attachment_bounding_box_tick()
    for _, construct in pairs(spawned_constructs) do
        draw_editing_bounding_box(construct)
    end
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
            menu.focus(construct.menus.name)
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
    add_spawned_construct(construct)
    return construct
end

local function save_vehicle(construct)
    debug_log("Saving construct "..tostring(construct.name), construct)
    if construct.author == nil then construct.author = players.get_name(players.user()) end
    if construct.created == nil then construct.created = os.date("!%Y-%m-%dT%H:%M:%SZ") end
    if construct.version == nil then construct.version = "Constructor "..VERSION_STRING end
    local filepath = CONSTRUCTS_DIR .. construct.name .. ".json"
    local serialized_construct = constructor_lib.serialize_attachment(construct)
    --debug_log("Serialized construct "..inspect(serialized_construct))
    local content = soup.json.encode(serialized_construct)
    if content == "" or (not constructor_lib.string_starts(content, "{")) then
        util.toast("Cannot save vehicle: Error serializing.", TOAST_ALL)
        return
    end
    local file = io.open(filepath, "wb")
    if not file then error("Cannot write to file " .. filepath, TOAST_ALL) end
    file:write(content)
    file:close()
    util.toast("Saved ".. construct.name)
    util.log("Saved ".. construct.name .. " to " ..filepath)
    menus.rebuild_load_construct_menu()
end

---
--- Construct Spawners
---

constructor.delete_construct =  function(construct)
    debug_log("Deleting construct "..tostring(construct.name), construct)
    if construct.is_player then
        constructor_lib.remove_attachment_from_parent(construct)
        restore_original_player_skin()
    else
        constructor_lib.remove_attachment_from_parent(construct)
        --constructor_lib.delete_attachment(construct)
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
    if construct_plan.type == "PED" and config.wear_spawned_peds then construct.is_player = true end
    if construct.is_player then
        construct.handle = players.user_ped()
        if player_construct ~= nil then
            -- Delete current player construct
            constructor.delete_construct(player_construct)
            restore_original_player_skin()
            player_construct = nil
        end
        get_player_construct()
        player_construct = construct
        use_player_as_base(construct)
    else
        set_spawned_construct_position(construct)
    end
    if construct.options.spawn_for_player then remove_tracked_construct_for_player(construct.options.spawn_for_player) end
    construct.root = construct
    construct.parent = construct
    constructor_lib.reattach_attachment_with_children(construct)
    if not construct.handle then error("Failed to spawn construct from plan "..tostring(construct.name)) end
    add_spawned_construct(construct)
    menus.refresh_loaded_constructs()
    menus.rebuild_attachment_menu(construct)
    construct.functions.refresh()
    if construct.root.menu_auto_focus ~= false and config.focus_menu_on_spawned_constructs ~= false then
        construct.functions.focus()
    end
    if construct.type == "VEHICLE" and config.drive_spawned_vehicles and construct.options.spawn_for_player == nil then
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), construct.handle, -1)
    end
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
    local file = io.open(filepath, "r")
    if file then
        local status, data = pcall(function() return file:read("*a") end)
        if not status then
            util.toast("Invalid construct file. "..filepath, TOAST_ALL)
            return
        end
        file:close()
        return data
    else
        error("Could not read file '" .. filepath .. "'", TOAST_ALL)
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
    if construct_plan.name then construct_plan.name = construct_plan_file.filename end
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



---
--- Prop Search
---

local function search_props(query)
    local results = {}
    for prop in io.lines(PROPS_PATH) do
        local i, j = prop:find(query)
        if i then
            table.insert(results, { prop = prop, distance = j - i })
        end
    end
    table.sort(results, function(a, b) return a.distance > b.distance end)
    return results
end

local function clear_menu_list(t)
    for k, h in pairs(t) do
        if h:isValid() then
            menu.delete(h)
        end
        t[k] = nil
    end
end

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
        local child_menu = menu.list(root_menu, curated_item.name)
        for _, child_item in pairs(curated_item.items) do
            build_curated_attachments_menu(attachment, child_menu, child_item)
        end
    else
        curated_item.load_menu = menu.action(root_menu, curated_item.name or "Unknown", {}, "", function()
            local child_attachment = copy_construct_plan(curated_item)
            child_attachment.root = attachment.root
            child_attachment.parent = attachment
            build_construct_from_plan(child_attachment)
        end)
        menu.on_focus(curated_item.load_menu, function(direction) if direction ~= 0 then add_preview(curated_item) end end)
        menu.on_blur(curated_item.load_menu, function(direction) if direction ~= 0 then remove_preview() end end)
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
        clear_menu_list(attachment.temp.debug_menus)
    end
    build_attachment_debug_menu(attachment)
end

local function rebuild_reattach_to_menu(attachment, current, path, depth)
    debug_log(
            "Rebuilding reattach to menu "..tostring(attachment.name),
            {attachment=attachment, current=current, path=path, depth=depth}
    )
    if current == nil then current = attachment.root end
    if path == nil then path = {} end
    if depth == nil then depth = 0 end
    depth = depth + 1
    if depth > 100 then error(t("Max depth reached while reattaching")) return end
    table.insert(path, current.name)
    if attachment ~= current then   -- cant reattach to yourself or your children
        menu.action(attachment.menus.option_parent_attachment, table.concat(path, " > "), {}, "", function()
            debug_log("Reattaching "..attachment.name.." to "..current.name)
            local previous_parent = attachment.parent
            constructor_lib.detach_attachment(attachment)
            attachment.parent = current
            attachment.root = current.root
            constructor_lib.attach_entity(attachment)
            table.insert(current.children, attachment)
            rebuild_attachment(attachment.root)
        end)
        for _, child_attachment in pairs(current.children) do
            rebuild_reattach_to_menu(attachment, child_attachment, constructor_lib.table_copy(path), depth)
        end
    end
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

local function install_curated_constructs()
    local to_path = filesystem.scripts_dir().."/Constructs Installer.lua"
    local write_file = io.open(to_path, "wb")
    if write_file == nil then util.toast("Error writing to "..to_path..".") end
    write_file:write(constants.CONSTRUCTS_INSTALLER_SCRIPT)
    write_file:close()
    util.yield(100)
    menu.focus(menu.ref_by_path("Stand>Lua Scripts"))
    util.yield(100)
    menu.focus(menu.ref_by_path("Stand>Lua Scripts>Repository"))
    util.yield(100)
    menu.trigger_commands("luaconstructsinstaller")
end

---
--- Position Menu
---

local function add_attachment_position_menu(attachment)
    attachment.menus.position = menu.list(attachment.menus.main, t("Position"))
    if attachment ~= attachment.root then

        menu.divider(attachment.menus.position, t("Offset"))
        attachment.menus.edit_offset_x = menu.slider_float(attachment.menus.position, t("X: Left / Right"), { "constructoroffset"..attachment.id.."x"}, t("Hold SHIFT to fine tune"), -500000, 500000, math.floor(attachment.offset.x * 100), config.edit_offset_step, function(value)
            attachment.offset.x = value / 100
            constructor_lib.move_attachment(attachment)
        end)
        attachment.menus.edit_offset_y = menu.slider_float(attachment.menus.position, t("Y: Forward / Back"), {"constructoroffset"..attachment.id.."y"}, t("Hold SHIFT to fine tune"), -500000, 500000, math.floor(attachment.offset.y * -100), config.edit_offset_step, function(value)
            attachment.offset.y = value / -100
            constructor_lib.move_attachment(attachment)
        end)
        attachment.menus.edit_offset_z = menu.slider_float(attachment.menus.position, t("Z: Up / Down"), {"constructoroffset"..attachment.id.."z"}, t("Hold SHIFT to fine tune"), -500000, 500000, math.floor(attachment.offset.z * -100), config.edit_offset_step, function(value)
            attachment.offset.z = value / -100
            constructor_lib.move_attachment(attachment)
        end)

        menu.divider(attachment.menus.position, t("Rotation"))
        attachment.menus.edit_rotation_x = menu.slider(attachment.menus.position, t("X: Pitch"), {"constructorrotate"..attachment.id.."x"}, t("Hold SHIFT to fine tune"), -179, 180, math.floor(attachment.rotation.x), config.edit_rotation_step, function(value)
            attachment.rotation.x = value
            constructor_lib.move_attachment(attachment)
        end)
        attachment.menus.edit_rotation_y = menu.slider(attachment.menus.position, t("Y: Roll"), {"constructorrotate"..attachment.id.."y"}, t("Hold SHIFT to fine tune"), -179, 180, math.floor(attachment.rotation.y), config.edit_rotation_step, function(value)
            attachment.rotation.y = value
            constructor_lib.move_attachment(attachment)
        end)
        attachment.menus.edit_rotation_z = menu.slider(attachment.menus.position, t("Z: Yaw"), {"constructorrotate"..attachment.id.."z"}, t("Hold SHIFT to fine tune"), -179, 180, math.floor(attachment.rotation.z), config.edit_rotation_step, function(value)
            attachment.rotation.z = value
            constructor_lib.move_attachment(attachment)
        end)

    else

        menu.divider(attachment.menus.position, t("World Position"))
        attachment.menus.edit_position_x = menu.slider_float(attachment.menus.position, t("X: Left / Right"), { "constructorposition"..attachment.id.."x"}, t("Hold SHIFT to fine tune"), -500000, 500000, math.floor(attachment.position.x * 100), config.edit_offset_step, function(value)
            attachment.position.x = value / 100
            constructor_lib.move_attachment(attachment)
        end)
        attachment.menus.edit_position_y = menu.slider_float(attachment.menus.position, t("Y: Forward / Back"), {"constructorposition"..attachment.id.."y"}, t("Hold SHIFT to fine tune"), -500000, 500000, math.floor(attachment.position.y * -100), config.edit_offset_step, function(value)
            attachment.position.y = value / -100
            constructor_lib.move_attachment(attachment)
        end)
        attachment.menus.edit_position_z = menu.slider_float(attachment.menus.position, t("Z: Up / Down"), {"constructorposition"..attachment.id.."z"}, t("Hold SHIFT to fine tune"), -500000, 500000, math.floor(attachment.position.z * -100), config.edit_offset_step, function(value)
            attachment.position.z = value / -100
            constructor_lib.move_attachment(attachment)
        end)

        menu.divider(attachment.menus.position, t("World Rotation"))
        attachment.menus.edit_world_rotation_x = menu.slider(attachment.menus.position, t("X: Pitch"), {"constructorworldrotate"..attachment.id.."x"}, t("Hold SHIFT to fine tune"), -179, 180, math.floor(attachment.world_rotation.x), config.edit_rotation_step, function(value)
            attachment.world_rotation.x = value
            constructor_lib.move_attachment(attachment)
        end)
        attachment.menus.edit_world_rotation_y = menu.slider(attachment.menus.position, t("Y: Roll"), {"constructorworldrotate"..attachment.id.."y"}, t("Hold SHIFT to fine tune"), -179, 180, math.floor(attachment.world_rotation.y), config.edit_rotation_step, function(value)
            attachment.world_rotation.y = value
            constructor_lib.move_attachment(attachment)
        end)
        attachment.menus.edit_world_rotation_z = menu.slider(attachment.menus.position, t("Z: Yaw"), {"constructorworldrotate"..attachment.id.."z"}, t("Hold SHIFT to fine tune"), -179, 180, math.floor(attachment.world_rotation.z), config.edit_rotation_step, function(value)
            attachment.world_rotation.z = value
            constructor_lib.move_attachment(attachment)
        end)

        menu.divider(attachment.menus.position, t("Options"))
        attachment.menus.option_position_frozen = menu.toggle(attachment.menus.position, t("Freeze Position"), {}, t("Will the construct be frozen in place, or allowed to move freely"), function(on)
            attachment.options.is_frozen = on
            constructor_lib.attach_entity(attachment)
        end, attachment.options.is_frozen)

    end
end

---
--- Options Menu
---

local function add_attachment_options_menu(attachment)

    attachment.menus.options = menu.list(attachment.menus.main, t("Options"))

    if constructor_lib.is_attachment_entity(attachment) then
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
        attachment.menus.option_gravity = menu.toggle(attachment.menus.options, t("Gravity"), {}, t("Will the attachment be effected by gravity, or be weightless"), function(on)
            attachment.options.has_gravity = on
            constructor_lib.attach_entity(attachment)
        end, attachment.options.has_gravity)
        attachment.menus.option_frozen = menu.toggle(attachment.menus.options, t("Freeze Position"), {}, t("Will the construct be frozen in place, or allowed to move freely"), function(on)
            attachment.options.is_frozen = on
            constructor_lib.attach_entity(attachment)
        end, attachment.options.is_frozen)
    end

    if attachment.type == "PARTICLE" then
        attachment.menus.option_paritcle_edit_scale = menu.slider(attachment.menus.options, t("Scale"), {"constructorscale"..attachment.id}, t("Particle effect size"), 0, 10000, math.floor(attachment.particle_attributes.scale * 100), config.edit_offset_step, function(value)
            attachment.particle_attributes.scale = value / 100
            constructor_lib.update_particle(attachment)
        end)
        attachment.menus.option_particle_bone_index = menu.slider(attachment.menus.options, t("Bone Index"), {}, t("Which bone of the parent should this entity be attached to"), -1, attachment.parent.num_bones or 200, attachment.particle_attributes.bone_index or -1, 1, function(value)
            attachment.particle_attributes.bone_index = value
            constructor_lib.update_particle(attachment)
        end)
        attachment.menus.option_particle_loop_timer = menu.slider(attachment.menus.options, t("Loop Timer"), {}, t("How often should the effect repeat. If this is 0 then it should try to loop forever."), 0, 60000, attachment.particle_attributes.loop_timer or 0, 1, function(value)
            attachment.particle_attributes.loop_timer = value
            constructor_lib.update_particle(attachment)
        end)
        attachment.menus.option_particle_color = menu.colour(attachment.menus.options, "Particle Color", {}, "", attachment.particle_attributes.color, true, function(color)
            attachment.particle_attributes.color = color
            constructor_lib.update_particle(attachment)
        end)
    end

end

---
--- Vehicle Options Menu
---

local function add_attachment_vehicle_menu(attachment)
    if attachment.type ~= "VEHICLE" then return end
    if attachment.vehicle_attributes == nil then attachment.vehicle_attributes = {} end
    attachment.menus.vehicle_options = menu.list(attachment.menus.options, t("Vehicle Options"), {}, t("Additional options available for all vehicle entities"))
    menu.toggle_loop(attachment.menus.vehicle_options, t("Engine Always On"), {}, t("If enabled, vehicle will stay running even when unoccupied"), function()
        attachment.options.engine_running = true
        VEHICLE.SET_VEHICLE_ENGINE_ON(attachment.handle, true, true, true)
    end, function() attachment.options.engine_running = false end)
    menu.toggle(attachment.menus.vehicle_options, t("Radio Loud"), {}, t("If enabled, vehicle radio will play loud enough to be heard outside the vehicle."), function(toggle)
        attachment.options.radio_loud = toggle
        constructor_lib.attach_entity(attachment)
    end, attachment.options.radio_loud)

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

    menu.slider(attachment.menus.vehicle_options, t("Dirt Level"), {"constructordirtlevel"..attachment.id.."z"}, t("How dirty is the vehicle"), 0, 15, math.floor(attachment.vehicle_attributes.paint.dirt_level), 1, function(value)
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

local function add_attachment_ped_menu(attachment)
    if attachment.type ~= "PED" then return end
    attachment.menus.ped_options = menu.list(attachment.menus.options, t("Ped Options"), {}, t("Additional options available for Ped entities."))
    attachment.menus.option_ped_can_rag_doll = menu.toggle(attachment.menus.ped_options, t("Can Rag Doll"), {}, t("If enabled, the ped can go limp."), function(value)
        attachment.ped_attributes.can_rag_doll = value
        constructor_lib.deserialize_ped_attributes(attachment)
    end, attachment.ped_attributes.can_rag_doll)
    attachment.menus.option_ped_armor = menu.slider(attachment.menus.ped_options, t("Armor"), {}, t("How much armor does the ped have."), 0, attachment.ped_attributes.armor, 100, 1, function(value)
        attachment.ped_attributes.armor = value
        constructor_lib.deserialize_ped_attributes(attachment)
    end)
    attachment.menus.option_on_fire = menu.toggle(attachment.menus.ped_options, t("On Fire"), {}, t("Will the ped be burning on fire, or not"), function(on)
        attachment.options.is_on_fire = on
        constructor_lib.deserialize_ped_attributes(attachment)
    end, attachment.options.is_on_fire)

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

    attachment.menus.option_give_ped_weapon = menu.list(attachment.menus.ped_options, t("Give Weapon"), {}, t("Give the ped a weapon."))
    create_ped_weapon_menu(attachment, attachment.menus.option_give_ped_weapon, constants.ped_weapons)

    local function create_ped_component_menu(attachment, root_menu, index, name)
        local component = attachment.ped_attributes.components["_".. index]
        attachment.menus["ped_components_drawable_"..index] = menu.slider(root_menu, name, {}, "", 0, component.num_drawable_variations, component.drawable_variation, 1, function(value)
            component.drawable_variation = value
            constructor_lib.deserialize_ped_attributes(attachment)
            menu.set_max_value(attachment.menus["ped_components_drawable_"..index], component.num_drawable_variations)
            component.texture_variation = 0
            menu.set_value(attachment.menus["ped_components_texture_"..index], component.texture_variation)
            menu.set_max_value(attachment.menus["ped_components_texture_"..index], component.num_texture_variations)
        end)
        attachment.menus["ped_components_texture_".. index] = menu.slider(root_menu, name.." "..t("Variation"), {}, "", 0, component.num_texture_variations, component.texture_variation, 1, function(value)
            component.texture_variation = value
            constructor_lib.deserialize_ped_attributes(attachment)
        end)
    end

    local function create_ped_prop_menu(attachment, root_menu, index, name)
        local prop = attachment.ped_attributes.props["_".. index]
        attachment.menus["ped_props_drawable_".. index] = menu.slider(root_menu, name, {}, "", -1, prop.num_drawable_variations, prop.drawable_variation, 1, function(value)
            prop.drawable_variation = value
            constructor_lib.deserialize_ped_attributes(attachment)
            menu.set_max_value(attachment.menus["ped_props_drawable_".. index], prop.num_drawable_variations)
            prop.texture_variation = 0
            menu.set_value(attachment.menus["ped_props_texture_".. index], prop.texture_variation)
            menu.set_max_value(attachment.menus["ped_props_texture_".. index], prop.num_texture_variations)
        end)
        attachment.menus["ped_props_texture_".. index] = menu.slider(root_menu, name.." "..t("Variation"), {}, "", 0, prop.num_texture_variations, prop.texture_variation, 1, function(value)
            prop.texture_variation = value
            constructor_lib.deserialize_ped_attributes(attachment)
        end)
    end

    attachment.menus.ped_options_clothes = menu.list(attachment.menus.ped_options, t("Clothes"))
    for _, ped_component in pairs(constants.ped_components) do
        create_ped_component_menu(attachment, attachment.menus.ped_options_clothes, ped_component.index, ped_component.name)
    end

    attachment.menus.ped_options_props = menu.list(attachment.menus.ped_options, t("Props"))
    for _, ped_prop in pairs(constants.ped_props) do
        create_ped_prop_menu(attachment, attachment.menus.ped_options_props, ped_prop.index, ped_prop.name)
    end
end

---
--- Attachment Options Menu
---

local function add_child_attachment_menu(attachment)
    if attachment == attachment.parent then return end

    attachment.menus.attachment_options = menu.list(attachment.menus.options, t("Attachment Options"), {}, t("Additional options available for all entities attached to a parent object."))

    attachment.menus.option_attached = menu.toggle(attachment.menus.attachment_options, t("Attached"), {}, t("Is this child physically attached to the parent, or does it move freely on its own."), function(on)
        attachment.options.is_attached = on
        constructor_lib.attach_entity(attachment)
    end, attachment.options.is_attached)
    attachment.menus.option_parent_attachment = menu.list(attachment.menus.attachment_options, t("Change Parent"), {}, t("Select a new parent for this child. Construct will be rebuilt to accommodate changes."), function()
        rebuild_reattach_to_menu(attachment)
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
        constructor_lib.detach_attachment(attachment)
        table.insert(spawned_constructs, attachment)
        attachment.menus = nil
        menus.rebuild_attachment_menu(attachment)
        original_parent.functions.refresh()
        attachment.functions.refresh()
        attachment.functions.focus()
        menus.refresh_loaded_constructs()
    end)

end

---
--- Entity Options Menu
---

local function add_attachment_entity_options(attachment)

    attachment.menus.more_options = menu.list(attachment.menus.options, t("Entity Options"), {}, t("Additional options available for all entities."))
    attachment.menus.option_lod_distance = menu.slider(attachment.menus.more_options, t("LoD Distance"), {"constructorsetloddistance"..attachment.id}, t("Level of Detail draw distance"), 1, 9999999, attachment.options.lod_distance, 100, function(value)
        attachment.options.lod_distance = value
        constructor_lib.attach_entity(attachment)
    end)

    attachment.menus.option_alpha = menu.slider(attachment.menus.more_options, t("Alpha"), {}, t("The amount of transparency the object has. Local only!"), 0, 255, attachment.options.alpha, 51, function(value)
        attachment.options.alpha = value
        constructor_lib.attach_entity(attachment)
    end)

    attachment.menus.option_mission_entity = menu.toggle(attachment.menus.more_options, t("Mission Entity"), {}, t("If attachment is treated as a mission entity."), function(on)
        attachment.options.is_mission_entity = on
        constructor_lib.attach_entity(attachment)
    end, attachment.options.is_mission_entity)

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

end

---
--- Add Attachment Menu
---

local function add_attachment_add_attachment_options(attachment)

    --menu.divider(attachment.menus.main, t("Attachments"))
    --attachment.menus.attachments = menu.list(attachment.menus.main, t("Attachments"))
    attachment.menus.add_attachment = menu.list(attachment.menus.main, t("Add Attachment"), {}, t("Options for attaching other entities to this construct"))

    attachment.menus.curated_attachments = menu.list(attachment.menus.add_attachment, t("Curated"), {}, t("Browse a curated collection of attachments"))
    for _, curated_item in pairs(curated_attachments) do
        build_curated_attachments_menu(attachment, attachment.menus.curated_attachments, curated_item)
    end



    attachment.menus.exact_name = menu.list(attachment.menus.add_attachment, t("Add by Name"), {}, t("Add an object, vehicle, or ped by exact name."))
    menu.text_input(attachment.menus.exact_name, t("Object by Name"), {"constructorattachobject"..attachment.id},
            t("Add an in-game object by exact name. To search for objects try https://gta-objects.xyz/"), function (value)
                build_construct_from_plan({
                    root = attachment.root, parent = attachment, name = value, model = value,
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

    menu.toggle(attachment.menus.add_attachment, t("Add Attachment Gun"), {}, t("Anything you shoot with this enabled will be added to the current construct"), function(on)
        config.add_attachment_gun_active = on
        config.add_attachment_gun_recipient = attachment
    end, config.add_attachment_gun_active)

    --attachment.menus.add_construct = menu.list(attachment.menus.add_attachment, t("Construct"), {}, t("Attach another construct to the current construct"))

end

---
--- Edit Attachments Menu
---

local function add_attachment_edit_attachments_options(attachment)

    attachment.menus.edit_attachments = menu.list(attachment.menus.main, t("Edit Attachments").." ("..#attachment.children..")", {}, "", function()
        menus.rebuild_attachment_menu(attachment)
    end)


end

local function add_attachment_teleport_options(attachment)

    attachment.menus.teleport = menu.list(attachment.menus.main, t("Teleport"))
    if attachment.type == "VEHICLE" then
        attachment.menus.enter_drivers_seat = menu.action(attachment.menus.teleport, t("Teleport Into Vehicle"), {}, "", function()
            PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), attachment.handle, -1)
        end)
    end
    attachment.menus.enter_drivers_seat = menu.action(attachment.menus.teleport, t("Teleport Me to Construct"), {}, "", function()
        local pos = ENTITY.GET_ENTITY_COORDS(attachment.handle)
        local vehicle = entities.get_user_vehicle_as_handle()
        if vehicle and PED.IS_PED_SITTING_IN_VEHICLE(players.user_ped(), vehicle) then
            ENTITY.SET_ENTITY_COORDS(vehicle, pos.x, pos.y, pos.z)
            VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(vehicle, 5)
        else
            ENTITY.SET_ENTITY_COORDS(players.user_ped(), pos.x, pos.y, pos.z)
        end
    end)
    attachment.menus.enter_drivers_seat = menu.action(attachment.menus.teleport, t("Teleport Construct to Me"), {}, "", function()
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 2.0, -2.5)
        local heading = ENTITY.GET_ENTITY_HEADING(players.user_ped())
        ENTITY.SET_ENTITY_COORDS(attachment.handle, pos.x, pos.y, pos.z)
        ENTITY.SET_ENTITY_ROTATION(attachment.handle, 0, 0, heading)
        VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(attachment.handle, 5)
    end)

end

local function add_attachment_info_menu(attachment)

menu.action(attachment.menus.main, "删除", {}, "",function()
            constructor.delete_construct(attachment)
end)
    attachment.menus.info = menu.list(attachment.menus.main, "信息")

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
    rebuild_attachment_debug_menu(attachment)

end

menus.rebuild_attachment_menu = function(attachment)
    if constructor_lib.is_attachment_entity(attachment) and (not attachment.handle) then error("Attachment missing handle") end
    if attachment.menus ~= nil then return end
    debug_log("Rebuilding attachment menu "..tostring(attachment.name), attachment)
    attachment.menus = {}

    local parent_menu
    if attachment == attachment.parent then
        parent_menu = menus.loaded_constructs
    else
        parent_menu = attachment.parent.menus.edit_attachments
    end
    attachment.menus.main = menu.list(parent_menu, attachment.name)

    add_attachment_info_menu(attachment)

    add_attachment_position_menu(attachment)

    add_attachment_options_menu(attachment)

    if attachment.type == "VEHICLE" then
        add_attachment_vehicle_menu(attachment)
    end

    if attachment.type == "PED" then
        add_attachment_ped_menu(attachment)
    end

    if constructor_lib.is_attachment_entity(attachment) then
        if attachment ~= attachment.parent then add_child_attachment_menu(attachment) end
        add_attachment_entity_options(attachment)
        add_attachment_add_attachment_options(attachment)
        add_attachment_edit_attachments_options(attachment)
        add_attachment_teleport_options(attachment)
    end

    for _, menu_handle in pairs(attachment.menus) do
        menu.on_focus(menu_handle, function(direction) if direction ~= 0 then attachment.is_editing = true end end)
        menu.on_blur(menu_handle, function(direction) if direction ~= 0 then attachment.is_editing = false end end)
    end

    if attachment.functions == nil then attachment.functions = {} end
    attachment.functions.refresh = function(updated_attachment)
        debug_log("Refreshing attachment menu "..tostring(attachment.name))
        menu.set_menu_name(attachment.menus.main, attachment.name)
        menu.set_menu_name(attachment.menus.edit_attachments, t("Edit Attachments").." ("..#attachment.children..")")
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

    for _, child_attachment in pairs(attachment.children) do
        menus.rebuild_attachment_menu(child_attachment)
        util.yield_once()
    end
end



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
menus.load_construct = menu.list(Constructor_Lua, t("Load Construct"), {"constructorloadconstruct"}, t("Load a previously saved or shared construct into the world"), function()
    menus.rebuild_load_construct_menu()
    if #load_constructs_root_menu_file.menus == 0 then
        util.toast("没有找到模组!", TOAST_ALL)
    end
end)
load_constructs_root_menu_file = {menu=menus.load_construct, name=t("Loaded Constructs Menu"), menus={}}


local CONSTRUCTS_DIR = filesystem.scripts_dir() .. 'daidaiScript\\Constructs\\'
menu.hyperlink(menus.load_construct, t("Open Constructs Folder"), "file:///"..CONSTRUCTS_DIR, "打开构造文件夹。在此处分享您的创作或添加新创作")
menus.load_construct_options = menu.list(menus.load_construct, t("设置选项"))

menu.toggle(menus.load_construct_options, t("Drive Spawned Vehicles"), {}, t("When spawning vehicles, automatically place you into the drivers seat."), function(on)
    config.drive_spawned_vehicles = on
end, config.drive_spawned_vehicles)
menu.toggle(menus.load_construct_options, t("Wear Spawned Peds"), {}, t("When spawning peds, replace your player skin with the ped."), function(on)
    config.wear_spawned_peds = on
end, config.wear_spawned_peds)


menu.divider(menus.load_construct, t("Browse"))

local function add_directory_to_load_constructs(path, parent_construct_plan_file)
    if path == nil then path = CONSTRUCTS_DIR end
    if parent_construct_plan_file == nil then parent_construct_plan_file = load_constructs_root_menu_file end
    if parent_construct_plan_file.menus == nil then parent_construct_plan_file.menus = {} end
    for _, construct_plan_menu in pairs(parent_construct_plan_file.menus) do
        pcall(menu.delete, construct_plan_menu)
    end

    

    local construct_plan_files = load_construct_plans_files_from_dir(path)
    for _, construct_plan_file in pairs(construct_plan_files) do
        if construct_plan_file.is_directory then
            construct_plan_file.menu = menu.list(parent_construct_plan_file.menu, construct_plan_file.name or "unknown", {}, "", function()
                add_directory_to_load_constructs(path.."/"..construct_plan_file.filename, construct_plan_file)
            end)
            table.insert(parent_construct_plan_file.menus, construct_plan_file.menu)
        end
    end
    for _, construct_plan_file in pairs(construct_plan_files) do
        if not construct_plan_file.is_directory then
            if is_file_type_supported(construct_plan_file.ext) then
                construct_plan_file.load_menu = menu.action(parent_construct_plan_file.menu, construct_plan_file.name, {}, "", function()
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
                table.insert(parent_construct_plan_file.menus, construct_plan_file.load_menu)
            end
        end
    end
end

menus.rebuild_load_construct_menu = function()
    add_directory_to_load_constructs(CONSTRUCTS_DIR, load_constructs_root_menu_file)
end

---
--- Player Menu
---




---
--- Loaded Constructs Menu
---

menus.loaded_constructs = menu.list(Constructor_Lua, t("Loaded Constructs").." ("..#spawned_constructs..")", {}, t("View and edit already loaded constructs"))
menus.refresh_loaded_constructs = function()
    menu.set_menu_name(menus.loaded_constructs, t("Loaded Constructs").." ("..#spawned_constructs..")")
end

---
--- Global Options Menu
---

local options_menu = menu.list(Constructor_Lua, t("Settings"), {}, t("Set global configuration options."))

menu.slider(options_menu, t("Edit Offset Step"), {}, t("The amount of change each time you edit an attachment offset (hold SHIFT for fine tuning)"), 1, 50, config.edit_offset_step, 1, function(value)
    config.edit_offset_step = value
end)
menu.slider(options_menu, t("Edit Rotation Step"), {}, t("The amount of change each time you edit an attachment rotation (hold SHIFT for fine tuning)"), 1, 30, config.edit_rotation_step, 1, function(value)
    config.edit_rotation_step = value
end)

menu.toggle(options_menu, t("Show Previews"), {}, t("Show previews when adding attachments"), function(on)
    config.show_previews = on
end, config.show_previews)
menu.slider(options_menu, t("Preview Display Delay"), {"constructorpreviewdisplaydelay"}, t("After browsing to a construct or attachment, wait this long before showing the preview."), 100, 1000, config.preview_display_delay, 50, function(value)
    config.preview_display_delay = value
end)
menu.toggle(options_menu, t("Delete All on Unload"), {}, t("Deconstruct all spawned constructs when unloading Constructor"), function(on)
    config.deconstruct_all_spawned_constructs_on_unload = on
end, config.deconstruct_all_spawned_constructs_on_unload)

----自动关闭
menu.toggle(options_menu, t("Focus Menu on Spawned Constructs"), {"toolsapk"}, t("When spawning a construct, focus Stands menu on the newly spawned construct. Otherwise, stay in the Load Constructs menu."), function(on)
    config.focus_menu_on_spawned_constructs = on
end, config.focus_menu_on_spawned_constructs)

menu.slider(options_menu, t("Spawn Entity Delay"), {"constructorspawnentitydelay"}, t("Pause after spawning any object. Useful for preventing issues when spawning large constructs with many objects."), 0, 500, config.spawn_entity_delay, 1, function(value)
    config.spawn_entity_delay = value
end)


menu.slider(options_menu, t("Constructs Allowed Per Players"), {"constructorspawnsallowedperplayer"}, t("The number of constructs any one player can spawn at a time. When a player tried to spawn additional constructs past this limit, the oldest spawned construct will be deleted."), 1, 5, config.num_allowed_spawned_constructs_per_player, 1, function(value)
    config.num_allowed_spawned_constructs_per_player = value
end)

menu.toggle(options_menu, t("Debug Mode"), {}, t("Log additional details about Constructors actions."), function(toggle)
    config.debug_mode = toggle
end, config.debug_mode)
if config.debug_mode then
    menu.action(options_menu, t("Log Missing Translations"), {}, t("Log any newly found missing translations"), function()
        log_missing_translations()
    end)
end

menu.slider(options_menu, t("Clean Up Distance"), {"constructorcleanupdistance"}, t("How far away the cleanup command will reach to delete entities."), 0, 10000, config.clean_up_distance, 100, function(value)
    config.clean_up_distance = value
end)
menu.action(options_menu, t("Clean Up"), {"cleanup"}, t("Remove nearby vehicles, objects and peds. Useful to delete any leftover construction debris."), function()
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



menu.trigger_commands("toolsapk off")

util.on_stop(cleanup_constructs_handler)

