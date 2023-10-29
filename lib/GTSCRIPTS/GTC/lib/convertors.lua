-- Construct Convertors
-- Transforms various file formats into Construct format

local SCRIPT_VERSION = "0.31"
local convertor = {
    SCRIPT_VERSION = SCRIPT_VERSION
}

---
--- Dependencies
---

local status_inspect, inspect = pcall(require, "lib.GTSCRIPTS.GTC.lib.inspect")
if not status_inspect then error("Could not load inspect lib. This should have been auto-installed.") end

local status_xml2lua, xml2lua = pcall(require, "lib.GTSCRIPTS.GTC.lib.xml2lua")
if not status_xml2lua then error("Could not load xml2lua lib. This should have been auto-installed.") end

local status_iniparser, iniparser = pcall(require, "lib.GTSCRIPTS.GTC.lib.iniparser")
if not status_iniparser then error("Could not load iniparser lib. This should have been auto-installed.") end

local status_constructor_lib, constructor_lib = pcall(require, "lib.GTSCRIPTS.GTC.lib.constructor_lib")
if not status_constructor_lib then error("Could not load constructor_lib. This should have been auto-installed.") end

local status_json, json = pcall(require, "lib.GTSCRIPTS.GTC.lib.json")
if not status_json then error("Could not load json lib. Make sure it is selected under Stand > Lua Scripts > Repository > json") end

---
--- Utils
---

local function debug_log(message, additional_details)
    if CONSTRUCTOR_CONFIG.debug_mode then
        if CONSTRUCTOR_CONFIG.debug_mode == 2 and additional_details ~= nil then
            message = message .. "\n" .. inspect(additional_details)
        end
        util.log(message)
    end
end

local function trim(value)
    if type(value) == "string" then
        value = value:gsub("%s+", "")
    end
    return value
end

local function toboolean(value)
    value = trim(value)
    return not (value == nil or value == false or value == "" or value == "false" or value == "0" or value == 0 or value == {})
end

local function parse_number(value)
    return tonumber(trim(value))
end

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

---
--- Constructor Format
---

local function convert_legacy_construct(construct_plan)
    -- 0.28 Renamed `rotation_axis` to `rotation_order`
    if construct_plan.rotation_axis ~= nil then construct_plan.rotation_order = construct_plan.rotation_axis end
end

convertor.convert_raw_construct_to_construct_plan = function(construct_plan)
    if construct_plan.temp == nil then construct_plan.temp = {} end
    construct_plan.temp.source_file_type = "Construct"
    convert_legacy_construct(construct_plan)
    constructor_lib.use_player_ped_attributes_as_base(construct_plan)
    return construct_plan
end

---
--- Jackz Vehicle Builder
---

local function convert_jackz_savedata_build_vehicle_attribute_mods(jackz_save_data)
    local MOD_NAMES = table.freeze({
        [1] = "Spoilers",
        [2] = "Front Bumper",
        [3] = "Rear Bumper",
        [4] = "Side Skirt",
        [5] = "Exhaust",
        [6] = "Frame",
        [7] = "Grille",
        [8] = "Hood",
        [9] = "Fender",
        [10] = "Right Fender",
        [11] = "Roof",
        [12] = "Engine",
        [13] = "Brakes",
        [14] = "Transmission",
        [15] = "Horns",
        [16] = "Suspension",
        [17] = "Armor",
        [24] = "Wheels Design",
        [25] = "Motorcycle Back Wheel Design",
        [26] = "Plate Holders",
        [28] = "Trim Design",
        [29] = "Ornaments",
        [31] = "Dial Design",
        [34] = "Steering Wheel",
        [35] = "Shifter Leavers",
        [36] = "Plaques",
        [39] = "Hydraulics",
        [49] = "Livery"
    })
    -- Subtract index by 1 to get modType (ty lua)
    local TOGGLEABLE_MOD_NAMES = table.freeze({
        [18] = "UNK17",
        [19] = "Turbo Turning",
        [20] = "UNK19",
        [21] = "Tire Smoke",
        [22] = "UNK21",
        [23] = "Xenon Headlights"
    })
    local mods = {}
    for mod_index = 0, 49 do
        local jackz_key
        if mod_index >= 17 and mod_index <= 22 then
            jackz_key = TOGGLEABLE_MOD_NAMES[mod_index+1]
        else
            jackz_key = MOD_NAMES[mod_index+1]
        end
        mods["_"..mod_index] = jackz_save_data.Mods[jackz_key] or -1
    end
    return mods
end

local function convert_jackz_savedata_build_vehicle_attribute_extras(jackz_save_data)
    local extras = {}
    for key, value in pairs(jackz_save_data.Extras) do
        extras["_"..key] = value
    end
    return extras
end

local function convert_jackz_savedata_to_vehicle_attributes(jackz_save_data, attachment)
    if jackz_save_data == nil then return end
    attachment.vehicle_attributes = {
        paint = {
            dirt_level = jackz_save_data["Dirt Level"],
            interior_color = jackz_save_data["Interior Color"],
            dashboard_color = jackz_save_data["Dashboard Color"],
            fade = jackz_save_data.Colors["Paint Fade"],
            color_combo = jackz_save_data.Colors["Color Combo"],
            primary = {
                is_custom = jackz_save_data.Colors.Primary.Custom,
                vehicle_standard_color = jackz_save_data.Colors.Vehicle.Primary,
                vehicle_custom_color = {
                    r= jackz_save_data.Colors.Vehicle.r,
                    g= jackz_save_data.Colors.Vehicle.g,
                    b= jackz_save_data.Colors.Vehicle.b
                }
            },
            secondary = {
                is_custom = jackz_save_data.Colors.Secondary.Custom,
                vehicle_standard_color = jackz_save_data.Colors.Vehicle.Secondary,
                vehicle_custom_color = {
                    r= jackz_save_data.Colors.Vehicle.r,
                    g= jackz_save_data.Colors.Vehicle.g,
                    b= jackz_save_data.Colors.Vehicle.b
                }
            },
            extra_colors = {
                pearlescent_color = jackz_save_data.Colors.Extras.Pearlescent,
                wheel = jackz_save_data.Colors.Extras.Wheel,
            },
            livery = jackz_save_data.Livery.Style,
        },
        options = {
            engine_running = jackz_save_data["Engine Running"],
            radio_loud = jackz_save_data["RadioLoud"],
            search_light = jackz_save_data.Lights.SearchLightActive,
            siren = jackz_save_data.Lights["SirenActive"],
            license_plate_text = jackz_save_data["License Plate"].Text,
            license_plate_type = jackz_save_data["License Plate"].Type,
            window_tint = jackz_save_data["Window Tint"],
        },
        wheels = {
            tire_smoke_color = {
                r= jackz_save_data["Tire Smoke"].r,
                g= jackz_save_data["Tire Smoke"].g,
                b= jackz_save_data["Tire Smoke"].b
            },
            bulletproof_tires = jackz_save_data["Bulletproof Tires"],
            wheel_type = jackz_save_data["Wheel Type"],
        },
        headlights = {
            headlights_color = jackz_save_data.Lights["Xenon Color"],
        },
        neon = {
            lights = {
                left = jackz_save_data.Lights.Neon.Left,
                right = jackz_save_data.Lights.Neon.Right,
                back = jackz_save_data.Lights.Neon.Back,
                front = jackz_save_data.Lights.Neon.Front,
            },
            color = {
                r= jackz_save_data.Lights.Neon.Color.r,
                g= jackz_save_data.Lights.Neon.Color.g,
                b= jackz_save_data.Lights.Neon.Color.b
            }
        },
        mods = convert_jackz_savedata_build_vehicle_attribute_mods(jackz_save_data),
        extras = convert_jackz_savedata_build_vehicle_attribute_extras(jackz_save_data),
    }

    if jackz_save_data.Colors.Primary["Custom Color"] then
        attachment.vehicle_attributes.paint.primary.custom_color = {
            r=jackz_save_data.Colors.Primary["Custom Color"].r,
            g=jackz_save_data.Colors.Primary["Custom Color"].g,
            b=jackz_save_data.Colors.Primary["Custom Color"].b
        }
    end
    if jackz_save_data.Colors.Secondary["Custom Color"] then
        attachment.vehicle_attributes.paint.secondary.custom_color = {
            r=jackz_save_data.Colors.Secondary["Custom Color"].r,
            g=jackz_save_data.Colors.Secondary["Custom Color"].g,
            b=jackz_save_data.Colors.Secondary["Custom Color"].b
        }
    end

end

local function convert_jackz_particle_to_attachment(jackz_object, attachment)
    if attachment == nil then attachment = {} end
    if attachment.particle_attributes == nil then attachment.particle_attributes = {} end
    if jackz_object.name ~= nil then attachment.name = jackz_object.name end
    if jackz_object.boneIndex ~= nil then attachment.particle_attributes.bone_index = jackz_object.boneIndex end
    if jackz_object.scale ~= nil then attachment.particle_attributes.scale = jackz_object.scale end
    if jackz_object.color ~= nil then attachment.particle_attributes.color = jackz_object.color end
    if jackz_object.offset ~= nil then attachment.offset = jackz_object.offset end
    if jackz_object.rotation ~= nil then attachment.rotation = jackz_object.rotation end
    if jackz_object.particle ~= nil then
        attachment.particle_attributes.asset = jackz_object.particle[1]
        attachment.particle_attributes.effect_name = jackz_object.particle[2]
    end
end

local function convert_jackz_object_to_attachment(jackz_object, jackz_save_data, attachment, type)
    if attachment == nil then attachment = {} end
    if attachment.children == nil then attachment.children = {} end
    if attachment.options == nil then attachment.options = {} end

    if jackz_object.model then attachment.hash = jackz_object.model end
    if jackz_object.name then attachment.name = jackz_object.name end
    if (jackz_object.type or type) then attachment.type = jackz_object.type or type end
    if jackz_object.collision ~= nil then attachment.options.has_collision = jackz_object.collision end
    if jackz_object.visible ~= nil then attachment.options.is_visible = jackz_object.visible end
    if jackz_object.bone_index ~= nil then attachment.options.bone_index = jackz_object.bone_index end
    if jackz_object.offset then
        attachment.rotation = {
            x=jackz_object.rotation.x,
            y=jackz_object.rotation.y,
            z=jackz_object.rotation.z
        }
    end
    if jackz_object.offset then
        attachment.offset = {
            x=jackz_object.offset.x,
            y=jackz_object.offset.y,
            z=jackz_object.offset.z
        }
    end
    if jackz_object.animdata then
        attachment.ped_attributes = {
            animation_dict = jackz_object.animdata[1],
            animation_name = jackz_object.animdata[2]
        }
    end
    convert_jackz_savedata_to_vehicle_attributes(jackz_save_data, attachment)
end

convertor.convert_jackz_to_construct_plan = function(jackz_build_data)

    --debug_log("Parsed Jackz Build Data: "..inspect(jackz_build_data))

    local construct_plan = constructor_lib.table_copy(constructor_lib.construct_base)
    construct_plan.temp.source_file_type = "Jackz Vehicle Builder"
    construct_plan.name = jackz_build_data.name
    construct_plan.author = jackz_build_data.author
    construct_plan.type = "VEHICLE"

    if jackz_build_data.base then
        convert_jackz_object_to_attachment(jackz_build_data.base.data or jackz_build_data.base, jackz_build_data.base.savedata, construct_plan)
    end

    if jackz_build_data.objects then
        for _, child_object in pairs(jackz_build_data.objects) do
            local child_attachment = {type="OBJECT"}
            convert_jackz_object_to_attachment(child_object, nil, child_attachment, "OBJECT")
            table.insert(construct_plan.children, child_attachment)
        end
    end
    if jackz_build_data.vehicles then
        for _, child_object in pairs(jackz_build_data.vehicles) do
            local child_attachment = {type="VEHICLE"}
            convert_jackz_object_to_attachment(child_object, child_object.savedata, child_attachment, "VEHICLE")
            table.insert(construct_plan.children, child_attachment)
        end
    end
    if jackz_build_data.peds then
        for _, child_object in pairs(jackz_build_data.peds) do
            local child_attachment = {type="PED"}
            convert_jackz_object_to_attachment(child_object, nil, child_attachment, "PED")
            table.insert(construct_plan.children, child_attachment)
        end
    end
    if jackz_build_data.particles then
        for _, child_object in pairs(jackz_build_data.particles) do
            local child_attachment = {type="PARTICLE"}
            convert_jackz_particle_to_attachment(child_object, child_attachment)
            table.insert(construct_plan.children, child_attachment)
        end
    end

    if construct_plan.hash == nil and construct_plan.model ~= nil then
        construct_plan.hash = util.joaat(construct_plan.model)
    elseif construct_plan.model == nil and construct_plan.hash ~= nil then
        construct_plan.model = util.reverse_joaat(construct_plan.hash)
    end

    if construct_plan.hash == nil and construct_plan.model == nil then
        util.toast("Failed to load Jackz construct. Missing hash or model.", TOAST_ALL)
        util.log("Attempted construct plan: "..inspect(construct_plan))
        return
    end

    --if constructor_lib.debug then util.log("Loaded Jackz construct plan: "..inspect(construct_plan)) end

    return construct_plan
end

---
--- PhantomX CraftLab Convertor
---

local function find_root_entity(data)
    for _, craftlab_item in pairs(data.craftlab) do
        if craftlab_item.entity.attach_data == nil then
            return craftlab_item
        end
    end
end

local function set_table_value_by_path(current_table, path, value)
    local path_parts = path:split(".")
    for i = 1, (#path_parts - 1) do
        if type(current_table) ~= "table" then
            util.toast("Non-table in map path "..path, TOAST_ALL)
            return
        end
        if current_table[path_parts[i]] == nil then
            current_table[path_parts[i]] = {}
        end
        current_table = current_table[path_parts[i]]
    end
    if type(current_table) == "table" then
        current_table[path_parts[#path_parts]] = value
    else
        util.toast("Invalid map path "..path, TOAST_ALL)
    end
end

local function map_fields(field_map, attachment, entity)
    for craftlab_key, constructor_key in pairs(field_map) do
        if type(constructor_key) == "table" then
            map_fields(constructor_key, attachment, entity[craftlab_key])
        else
            local craftlab_value = entity[craftlab_key]
            if craftlab_value ~= nil then
                set_table_value_by_path(attachment, constructor_key, craftlab_value)
            end
        end
    end
end

local function map_craftlab_vehicle(attachment, entity)
    if entity.vehicle_data == nil then return end
    if attachment.vehicle_attributes == nil then attachment.vehicle_attributes = {} end

    local craftlab_constructor_field_map = {
        -- brake lights
        dashboard_color="paint.dashboard_color",
        dirt_level="paint.dirt_level",
        doors={
            is_broken_0="doors.broken.frontleft",
            is_broken_1="doors.broken.frontright",
            is_broken_2="doors.broken.backleft",
            is_broken_3="doors.broken.backright",
            is_broken_4="doors.broken.hood",
            is_broken_5="doors.broken.trunk",
            is_broken_6="doors.broken.trunk2",
        },
        enveff_scale="paint.fade",
        -- extras TODO
        headlight_color="headlights_color",
        headlight_multiplier="headlights.multiplier",
        -- heli
        -- indicator_lights
        interior_color="paint.interior_color",
        is_custom_primary_color="paint.primary.is_custom",
        is_custom_secondary_color="paint.secondary.is_custom",
        is_engine_running="options.engine_running",
        -- is_locked
        is_windscreen_detached="options.is_windscreen_detached",
        -- light_state
        livery="paint.livery",
        -- mod_slot TODO
        neon={
            is_enabled_0="neon.lights.left",
            is_enabled_1="neon.lights.right",
            is_enabled_2="neon.lights.front",
            is_enabled_3="neon.lights.back",
        },
        number_plate_text="options.license_plate_text",
        number_plate_text_index="options.license_plate_type",
        pearl_color="paint.primary.pearlescent_color",
        primary_color="paint.primary.vehicle_standard_color",
        rgb_colors={
            custom_primary_colour_b="paint.primary.custom_color.b",
            custom_primary_colour_g="paint.primary.custom_color.g",
            custom_primary_colour_r="paint.primary.custom_color.r",
            custom_secondary_colour_b="paint.secondary.custom_color.b",
            custom_secondary_colour_g="paint.secondary.custom_color.g",
            custom_secondary_colour_r="paint.secondary.custom_color.r",
            neon_lights_colour_b="vehicle_attributes.neon.color.b",
            neon_lights_colour_g="vehicle_attributes.neon.color.g",
            neon_lights_colour_r="vehicle_attributes.neon.color.r",
            tyre_smoke_colour_b="wheels.tire_smoke_color.b",
            tyre_smoke_colour_g="wheels.tire_smoke_color.g",
            tyre_smoke_colour_r="wheels.tire_smoke_color.r"
        },
        --roof_state="",
        scorched_render="options.is_scorched", -- not in vehicle attribs
        secondary_color="paint.secondary.vehicle_standard_color",
        --siren_light="",
        --tyres={
        --    is_burst_left_front="vehicle_attributes.wheels.tires_burst[]",
        --    is_burst_left_mid= false,
        --    is_burst_left_mid6= false,
        --    is_burst_left_rear= false,
        --    is_burst_right_front= false,
        --    is_burst_right_mid= false,
        --    is_burst_right_mid6= false,
        --    is_burst_right_rear= false
        --}
        tyres_can_burst="wheels.bulletproof_tires",
        wheel_color="paint.extra_colors.wheel",
        wheel_type="wheels.wheel_type",
        window_tint="options.window_tint",
        windows={
            is_deleted_left_front="windows.broken.frontleft",
            is_deleted_left_rear="windows.broken.rearleft",
            is_deleted_right_front="windows.broken.frontright",
            is_deleted_right_rear="windows.broken.rearright"
        },
    }

    map_fields(craftlab_constructor_field_map, attachment.vehicle_attributes, entity.vehicle_data)

    if attachment.vehicle_attributes.mods == nil then attachment.vehicle_attributes.mods = {} end
    for index = 0, 49 do
        local value
        if index >= 17 and index <= 22 then
            value = entity.vehicle_data.mod_slot["mod_toggle_"..index]
        else
            value = entity.vehicle_data.mod_slot["mod_index_"..index]
        end
        attachment.vehicle_attributes.mods["_"..index] = value
        -- Mod Variation
    end

    if attachment.vehicle_attributes.extras == nil then attachment.vehicle_attributes.extras = {} end
    for index = 0, 60 do
        attachment.vehicle_attributes.extras["_"..index] = entity.vehicle_data.extras["exist_"..index]
    end

end


local function map_craftlab_entity(attachment, entity)
    if entity.model ~= nil then attachment.hash = entity.model end
    if attachment.model == nil and attachment.hash ~= nil then
        attachment.model = util.reverse_joaat(attachment.hash)
    end
    constructor_lib.default_attachment_attributes(attachment)

    if entity.string_name ~= nil then attachment.name = entity.string_name end
    if entity.type ~= nil then
        if entity.type == 5 then
            attachment.type = "OBJECT"
        elseif entity.type == 3 then
            attachment.type = "VEHICLE"
        end
    end

    if entity.visible ~= nil then attachment.options.is_visible = entity.visible end
    if entity.alpha_level ~= nil then attachment.options.alpha = entity.alpha_level end
    if entity.collision ~= nil then attachment.options.has_collision = entity.collision end
    if entity.dynamic ~= nil then attachment.options.is_dynamic = entity.dynamic end
    if entity.freeze ~= nil then attachment.options.is_frozen = entity.freeze end
    if entity.gravity ~= nil then attachment.options.has_gravity = entity.gravity end
    if entity.invincible ~= nil then attachment.options.invincible = entity.invincible end

    if entity.is_attached ~= nil then attachment.options.is_attached = entity.is_attached end
    if entity.unique_number ~= nil then attachment.initial_handle = entity.unique_number end

    if entity.object_data ~= nil then
        if entity.object_data.Lights ~= nil then attachment.options.is_light_on = entity.object_data.Lights end
    end

    if entity.attach_data ~= nil then
        if entity.attach_data.attached_to_number ~= nil then attachment.parents_initial_handle = entity.attach_data.attached_to_number end
        if entity.attach_data.attached_to_bone ~= nil then attachment.options.bone_index = entity.attach_data.attached_to_bone end

        if entity.attach_data.x ~= nil then attachment.offset.x = entity.attach_data.x end
        if entity.attach_data.y ~= nil then attachment.offset.y = entity.attach_data.y end
        if entity.attach_data.z ~= nil then attachment.offset.z = entity.attach_data.z end

        if entity.attach_data.pitch ~= nil then attachment.rotation.x = entity.attach_data.pitch end
        if entity.attach_data.roll ~= nil then attachment.rotation.y = entity.attach_data.roll end
        if entity.attach_data.yaw ~= nil then attachment.rotation.z = entity.attach_data.yaw end
    end

    if entity.placement ~= nil then
        if entity.placement.pos_x ~= nil then attachment.position.x = entity.placement.pos_x end
        if entity.placement.pos_y ~= nil then attachment.position.y = entity.placement.pos_y end
        if entity.placement.pos_z ~= nil then attachment.position.z = entity.placement.pos_z end

        if entity.placement.rot_pitch ~= nil then attachment.world_rotation.x = entity.placement.rot_pitch end
        if entity.placement.rot_roll ~= nil then attachment.world_rotation.y = entity.placement.rot_roll end
        if entity.placement.rot_yaw ~= nil then attachment.world_rotation.z = entity.placement.rot_yaw end
    end

    if entity.vehicle_data ~= nil then
        map_craftlab_vehicle(attachment, entity)
    end

end

convertor.convert_craftlab_to_construct_plan = function(data)

    local construct_plan = constructor_lib.table_copy(constructor_lib.construct_base)
    construct_plan.temp.source_file_type = "PhantomX CraftLab"

    debug_log("Parsed CraftLab: "..inspect(data))

    local root_entity = find_root_entity(data)
    if not root_entity then
        util.toast("Could not find root entity", TOAST_ALL)
        return
    end
    map_craftlab_entity(construct_plan, root_entity.entity)

    for _, entity in pairs(data.craftlab) do
        if entity ~= root_entity then
            local attachment = {}
            map_craftlab_entity(attachment, entity.entity)
            table.insert(construct_plan.children, attachment)
        end
    end

    convertor.rearrange_by_initial_attachment(construct_plan)

    debug_log("Loaded CraftLab construct plan: "..inspect(construct_plan))

    return construct_plan
end

---
--- JSON to Construct Plan Convertor
---

convertor.convert_json_to_construct_plan = function(construct_plan_file)
    local raw_data = read_file(construct_plan_file.filepath)
    if not raw_data or raw_data == "" then return end
    local construct_plan = json.decode(raw_data)
    if construct_plan.version and string.find(construct_plan.version, "Jackz") then
        construct_plan = convertor.convert_jackz_to_construct_plan(construct_plan)
    elseif construct_plan.craftlab then
        construct_plan = convertor.convert_craftlab_to_construct_plan(construct_plan)
    else
        construct_plan = convertor.convert_raw_construct_to_construct_plan(construct_plan)
    end
    return construct_plan
end

---
--- XML to Construct Plan Convertor
---

local function strsplit(str, sep)
    sep = sep or "%s";
    local tbl = {};
    local i = 1;
    for str_part in string.gmatch(str, "([^"..sep.."]+)") do
        tbl[i] = str_part;
        i = i + 1;
    end
    return tbl;
end

local function find_attachment_by_initial_handle(attachment, initial_handle)
    if attachment.initial_handle == initial_handle then return attachment end
    for _, child_attachment in pairs(attachment.children) do
        local new_parent = find_attachment_by_initial_handle(child_attachment, initial_handle)
        if new_parent then return new_parent end
    end
end

convertor.rearrange_by_initial_attachment = function(attachment, parent_attachment, root_attachment)
    if parent_attachment == nil then root_attachment = attachment end
    if parent_attachment ~= nil and attachment.parents_initial_handle and (attachment.parents_initial_handle ~= parent_attachment.initial_handle) then
        local new_parent = find_attachment_by_initial_handle(root_attachment, attachment.parents_initial_handle)
        if new_parent then
            constructor_lib.array_remove(parent_attachment.children, function(t, i)
                local child_attachment = t[i]
                return child_attachment ~= attachment
            end)
            table.insert(new_parent.children, attachment)
        else
            util.toast("Could not rearrange attachment "..attachment.name.." to "..attachment.parents_initial_handle, TOAST_ALL)
        end
    end
    for _, child_attachment in pairs(attachment.children) do
        convertor.rearrange_by_initial_attachment(child_attachment, attachment, root_attachment)
    end
end

local function value_splitter(value)
    local split_value = strsplit(value, ",")
    return {tonumber(split_value[1]), tonumber(split_value[2])}
end

local function map_vehicle_attributes(attachment, placement)
    if not placement.VehicleProperties then return end

    if attachment.vehicle_attributes == nil then attachment.vehicle_attributes = {} end

    if attachment.vehicle_attributes.headlights == nil then attachment.vehicle_attributes.headlights = {} end
    attachment.vehicle_attributes.headlights.multiplier = tonumber(placement.VehicleProperties.HeadlightIntensity)
    attachment.vehicle_attributes.headlights.headlights_color = tonumber(placement.VehicleProperties.Colours.LrXenonHeadlights)

    if attachment.vehicle_attributes.wheels == nil then attachment.vehicle_attributes.wheels = {} end
    attachment.vehicle_attributes.wheels.wheel_type = tonumber(placement.VehicleProperties.WheelType)
    attachment.vehicle_attributes.wheels.bulletproof_tires = toboolean(placement.VehicleProperties.BulletProofTyres)
    attachment.vehicle_attributes.wheels.invisible_wheels = toboolean(placement.VehicleProperties.WheelsInvisible)
    if attachment.vehicle_attributes.wheels.tire_smoke_color == nil then attachment.vehicle_attributes.wheels.tire_smoke_color = {} end
    attachment.vehicle_attributes.wheels.tire_smoke_color.r = tonumber(placement.VehicleProperties.Colours.tyreSmoke_R)
    attachment.vehicle_attributes.wheels.tire_smoke_color.g = tonumber(placement.VehicleProperties.Colours.tyreSmoke_G)
    attachment.vehicle_attributes.wheels.tire_smoke_color.b = tonumber(placement.VehicleProperties.Colours.tyreSmoke_B)

    if attachment.vehicle_attributes.paint == nil then attachment.vehicle_attributes.paint = {} end
    attachment.vehicle_attributes.paint.dirt_level = tonumber(placement.VehicleProperties.DirtLevel)
    attachment.vehicle_attributes.paint.fade = tonumber(placement.VehicleProperties.PaintFade)
    attachment.vehicle_attributes.paint.livery = tonumber(placement.VehicleProperties.Livery)
    if attachment.vehicle_attributes.paint.primary == nil then attachment.vehicle_attributes.paint.primary = {} end
    attachment.vehicle_attributes.paint.primary.vehicle_standard_color = tonumber(placement.VehicleProperties.Colours.Primary)
    attachment.vehicle_attributes.paint.primary.is_custom = toboolean(placement.VehicleProperties.Colours.IsPrimaryColourCustom)
    attachment.vehicle_attributes.paint.primary.paint_type = tonumber(placement.VehicleProperties.Colours.Mod1_a)
    attachment.vehicle_attributes.paint.primary.color = tonumber(placement.VehicleProperties.Colours.Mod1_b)
    attachment.vehicle_attributes.paint.primary.pearlescent_color = tonumber(placement.VehicleProperties.Colours.Mod1_c)
    if attachment.vehicle_attributes.paint.primary.custom_color == nil then attachment.vehicle_attributes.paint.primary.custom_color = {} end
    attachment.vehicle_attributes.paint.primary.custom_color.r = tonumber(placement.VehicleProperties.Colours.Cust1_R)
    attachment.vehicle_attributes.paint.primary.custom_color.g = tonumber(placement.VehicleProperties.Colours.Cust1_G)
    attachment.vehicle_attributes.paint.primary.custom_color.b = tonumber(placement.VehicleProperties.Colours.Cust1_B)
    if attachment.vehicle_attributes.paint.secondary == nil then attachment.vehicle_attributes.paint.secondary = {} end
    attachment.vehicle_attributes.paint.secondary.vehicle_standard_color = tonumber(placement.VehicleProperties.Colours.Secondary)
    attachment.vehicle_attributes.paint.secondary.is_custom = toboolean(placement.VehicleProperties.Colours.IsSecondaryColourCustom)
    attachment.vehicle_attributes.paint.secondary.paint_type = tonumber(placement.VehicleProperties.Colours.Mod2_a)
    attachment.vehicle_attributes.paint.secondary.color = tonumber(placement.VehicleProperties.Colours.Mod2_b)
    if attachment.vehicle_attributes.paint.secondary.custom_color == nil then attachment.vehicle_attributes.paint.secondary.custom_color = {} end
    attachment.vehicle_attributes.paint.secondary.custom_color.r = tonumber(placement.VehicleProperties.Colours.Cust2_R)
    attachment.vehicle_attributes.paint.secondary.custom_color.g = tonumber(placement.VehicleProperties.Colours.Cust2_G)
    attachment.vehicle_attributes.paint.secondary.custom_color.b = tonumber(placement.VehicleProperties.Colours.Cust2_B)
    if attachment.vehicle_attributes.paint.extra_colors == nil then attachment.vehicle_attributes.paint.extra_colors = {} end
    attachment.vehicle_attributes.paint.extra_colors.pearlescent = tonumber(placement.VehicleProperties.Colours.Pearl)
    attachment.vehicle_attributes.paint.extra_colors.wheel = tonumber(placement.VehicleProperties.Colours.Rim)
    attachment.vehicle_attributes.paint.interior_color = tonumber(placement.VehicleProperties.Colours.LrInterior)
    attachment.vehicle_attributes.paint.dashboard_color = tonumber(placement.VehicleProperties.Colours.LrDashboard)

    if attachment.vehicle_attributes.neon == nil then attachment.vehicle_attributes.neon = {} end
    if attachment.vehicle_attributes.neon.color == nil then attachment.vehicle_attributes.neon.color = {} end
    if attachment.vehicle_attributes.neon.lights == nil then attachment.vehicle_attributes.neon.lights = {} end
    if placement.VehicleProperties.Neons then
        attachment.vehicle_attributes.neon.lights.left = toboolean(placement.VehicleProperties.Neons.Left)
        attachment.vehicle_attributes.neon.lights.right = toboolean(placement.VehicleProperties.Neons.Right)
        attachment.vehicle_attributes.neon.lights.front = toboolean(placement.VehicleProperties.Neons.Front)
        attachment.vehicle_attributes.neon.lights.back = toboolean(placement.VehicleProperties.Neons.Back)
        attachment.vehicle_attributes.neon.color.r = tonumber(placement.VehicleProperties.Neons.R)
        attachment.vehicle_attributes.neon.color.g = tonumber(placement.VehicleProperties.Neons.G)
        attachment.vehicle_attributes.neon.color.b = tonumber(placement.VehicleProperties.Neons.B)
    end

    if attachment.vehicle_attributes.doors == nil then attachment.vehicle_attributes.doors = {} end
    if attachment.vehicle_attributes.doors.open == nil then attachment.vehicle_attributes.doors.open = {} end
    if placement.VehicleProperties.DoorsOpen then
        attachment.vehicle_attributes.doors.open.backleft = toboolean(placement.VehicleProperties.DoorsOpen.BackLeftDoor)
        attachment.vehicle_attributes.doors.open.backright = toboolean(placement.VehicleProperties.DoorsOpen.BackRightDoor)
        attachment.vehicle_attributes.doors.open.frontleft = toboolean(placement.VehicleProperties.DoorsOpen.FrontLeftDoor)
        attachment.vehicle_attributes.doors.open.frontright = toboolean(placement.VehicleProperties.DoorsOpen.FrontRightDoor)
        attachment.vehicle_attributes.doors.open.hood = toboolean(placement.VehicleProperties.DoorsOpen.Hood)
        attachment.vehicle_attributes.doors.open.trunk = toboolean(placement.VehicleProperties.DoorsOpen.Trunk)
        attachment.vehicle_attributes.doors.open.trunk2 = toboolean(placement.VehicleProperties.DoorsOpen.Trunk2)
    end
    if attachment.vehicle_attributes.doors.broken == nil then attachment.vehicle_attributes.doors.broken = {} end
    if placement.VehicleProperties.DoorsBroken then
        attachment.vehicle_attributes.doors.broken.backleft = toboolean(placement.VehicleProperties.DoorsBroken.BackLeftDoor)
        attachment.vehicle_attributes.doors.broken.backright = toboolean(placement.VehicleProperties.DoorsBroken.BackRightDoor)
        attachment.vehicle_attributes.doors.broken.frontleft = toboolean(placement.VehicleProperties.DoorsBroken.FrontLeftDoor)
        attachment.vehicle_attributes.doors.broken.frontright = toboolean(placement.VehicleProperties.DoorsBroken.FrontRightDoor)
        attachment.vehicle_attributes.doors.broken.hood = toboolean(placement.VehicleProperties.DoorsBroken.Hood)
        attachment.vehicle_attributes.doors.broken.trunk = toboolean(placement.VehicleProperties.DoorsBroken.Trunk)
        attachment.vehicle_attributes.doors.broken.trunk2 = toboolean(placement.VehicleProperties.DoorsBroken.Trunk2)
    end

    if attachment.vehicle_attributes.options == nil then attachment.vehicle_attributes.options = {} end
    attachment.vehicle_attributes.options.siren = toboolean(placement.VehicleProperties.SirenActive)
    attachment.vehicle_attributes.options.window_tint = tonumber(placement.VehicleProperties.WindowTint)
    attachment.vehicle_attributes.options.engine_running = toboolean(placement.VehicleProperties.EngineOn)
    attachment.vehicle_attributes.options.radio_loud = toboolean(placement.VehicleProperties.IsRadioLoud)
    attachment.vehicle_attributes.options.license_plate_type = tonumber(placement.VehicleProperties.NumberPlateIndex)
    if placement.VehicleProperties.NumberPlateText ~= nil then
        attachment.vehicle_attributes.options.license_plate_text = tostring(placement.VehicleProperties.NumberPlateText)
    end

    if attachment.vehicle_attributes.mods == nil then attachment.vehicle_attributes.mods = {} end
    for index = 0, 49 do
        local formatter = function(value) if type(value) == "table" then return tonumber(value[1]) end end
        if index >= 17 and index <= 22 then formatter = toboolean end
        attachment.vehicle_attributes.mods["_"..index] = formatter(placement.VehicleProperties.Mods["_"..index])
    end

    if attachment.vehicle_attributes.extras == nil then attachment.vehicle_attributes.extras = {} end
    for index = 0, 14 do
        attachment.vehicle_attributes.extras["_"..index] = toboolean(placement.VehicleProperties.ModExtras["_"..index])
    end
end

local function map_ped_placement(attachment, placement)
    if not placement.PedProperties then return end

    if attachment.ped_attributes == nil then attachment.ped_attributes = {} end
    if placement.PedProperties.CanRagDoll ~= nil then attachment.ped_attributes.can_rag_doll = toboolean(placement.PedProperties.CanRagDoll) end
    if placement.PedProperties.Armour ~= nil then attachment.ped_attributes.armour = tonumber(placement.PedProperties.Armour) end
    if placement.PedProperties.CurrentWeapon ~= nil then attachment.ped_attributes.current_weapon = tonumber(placement.PedProperties.CurrentWeapon) end
    if placement.PedProperties.AnimDict ~= nil then attachment.ped_attributes.animation_dict = tostring(placement.PedProperties.AnimDict) end
    if placement.PedProperties.AnimName ~= nil then attachment.ped_attributes.animation_name = tostring(placement.PedProperties.AnimName) end

    if attachment.ped_attributes.props == nil then attachment.ped_attributes.props = {} end
    if placement.PedProperties.PedProps ~= nil then
        for index = 0, 9 do
            local values = value_splitter(placement.PedProperties.PedProps["_"..index])
            attachment.ped_attributes.props["_"..index] = {
                drawable_variation=values[1],
                texture_variation=values[2],
            }
        end
    end
    if attachment.ped_attributes.components == nil then attachment.ped_attributes.components = {} end
    if placement.PedProperties.PedComps ~= nil then
        for index = 0, 11 do
            local values = value_splitter(placement.PedProperties.PedComps["_"..index])
            attachment.ped_attributes.components["_"..index] = {
                drawable_variation=values[1],
                texture_variation=values[2],
            }
        end
    end

end

local function map_placement_options(attachment, placement)
    if attachment.options == nil then attachment.options = {} end
    if placement.FrozenPos ~= nil then attachment.options.is_frozen = toboolean(placement.FrozenPos) end
    if placement.OpacityLevel ~= nil then attachment.options.alpha = tonumber(placement.OpacityLevel) end
    if placement.LodDistance ~= nil then attachment.options.lod_distance = tonumber(placement.LodDistance) end
    if placement.IsVisible ~= nil then attachment.options.is_visible = toboolean(placement.IsVisible) end
    if placement.Dynamic ~= nil then attachment.options.is_dynamic = toboolean(placement.Dynamic) end
    if placement.Health ~= nil then attachment.options.health = tonumber(placement.Health) end
    if placement.MaxHealth ~= nil then attachment.options.max_health = tonumber(placement.MaxHealth) end
    if placement.HasGravity ~= nil then attachment.options.has_gravity = toboolean(placement.HasGravity) end
    if placement.IsOnFire ~= nil then attachment.options.is_on_fire = toboolean(placement.IsOnFire) end
    if placement.IsInvincible ~= nil then attachment.options.is_invincible = toboolean(placement.IsInvincible) end
    if placement.IsBulletProof ~= nil then attachment.options.is_bullet_proof = toboolean(placement.IsBulletProof) end
    if placement.IsFireProof ~= nil then attachment.options.is_fire_proof = toboolean(placement.IsFireProof) end
    if placement.IsExplosionProof ~= nil then attachment.options.is_explosion_proof = toboolean(placement.IsExplosionProof) end
    if placement.IsMeleeProof ~= nil then attachment.options.is_melee_proof = toboolean(placement.IsMeleeProof) end
    --IsOnlyDamagedByPlayer = placement.IsOnlyDamagedByPlayer
    if placement.IsCollisionProof ~= nil then attachment.options.has_collision = not toboolean(placement.IsCollisionProof) end
end

local function map_placement_position(attachment, placement)
    if attachment.position == nil then attachment.position = {x=0, y=0, z=0} end
    if attachment.world_rotation == nil then attachment.world_rotation = {x=0, y=0, z=0} end
    if attachment.offset == nil then attachment.offset = {x=0, y=0, z=0} end
    if attachment.rotation == nil then attachment.rotation = {x=0, y=0, z=0} end
    if placement.PositionRotation ~= nil then
        attachment.position = {
            x = tonumber(placement.PositionRotation.X),
            y = tonumber(placement.PositionRotation.Y),
            z = tonumber(placement.PositionRotation.Z)
        }
        attachment.world_rotation = {
            x = tonumber(placement.PositionRotation.Pitch),
            y = tonumber(placement.PositionRotation.Roll),
            z = tonumber(placement.PositionRotation.Yaw)
        }
    end
    if placement.Attachment ~= nil and placement.Attachment.X ~= nil then
        attachment.offset = {
            x = tonumber(placement.Attachment.X),
            y = tonumber(placement.Attachment.Y),
            z = tonumber(placement.Attachment.Z)
        }
        attachment.rotation = {
            x = tonumber(placement.Attachment.Pitch),
            y = tonumber(placement.Attachment.Roll),
            z = tonumber(placement.Attachment.Yaw)
        }
        if placement.Attachment.BoneIndex ~= nil then attachment.options.bone_index = tonumber(placement.Attachment.BoneIndex) end
        if placement.Attachment.AttachedTo ~= nil then attachment.parents_initial_handle = tonumber(placement.Attachment.AttachedTo) end
    end
    if placement.Attachment ~= nil and placement.Attachment._attr ~= nil then
        attachment.options.is_attached = toboolean(placement.Attachment._attr.isAttached)
    end
end

local function map_placement(attachment, placement)
    --util.log("Processing "..inspect(placement))
    if attachment == nil then attachment = {} end

    attachment.hash = tonumber(placement.ModelHash)
    attachment.name = placement.HashName
    if attachment.model == nil and attachment.hash ~= nil then
        attachment.model = util.reverse_joaat(attachment.hash)
    end
    if placement.Type then attachment.type = constructor_lib.ENTITY_TYPES[tonumber(placement.Type)] end
    attachment.initial_handle = tonumber(placement.InitialHandle)
    -- dynamic?
    if attachment.children == nil then attachment.children = {} end

    map_placement_options(attachment, placement)
    map_placement_position(attachment, placement)
    map_vehicle_attributes(attachment, placement)
    map_ped_placement(attachment, placement)
end

convertor.convert_xml_to_construct_plan = function(xmldata)
    local construct_plan = constructor_lib.table_copy(constructor_lib.construct_base)
    construct_plan.temp.source_file_type = "Menyoo XML"

    xmldata = xmldata:gsub("<?xml 版本=\"1.0\"", "<?xml version=\"1.0\"")
    local vehicle_handler = xml2lua.TreeHandler:new()
    local parser = xml2lua.parser(vehicle_handler)
    parser:parse(xmldata)

    --debug_log("Parsed XML: "..inspect(vehicle_handler.root))

    if vehicle_handler.root.Vehicle ~= nil then
        construct_plan.type = "VEHICLE"
        local root = vehicle_handler.root.Vehicle
        if root[1] == nil then root = {root} end
        map_placement(construct_plan, root[1])
        local attachments = root[1].SpoonerAttachments.Attachment
        if attachments then
            if attachments[1] == nil then attachments = {attachments} end
            for _, placement in pairs(attachments) do
                local attachment = {}
                map_placement(attachment, placement)
                table.insert(construct_plan.children, attachment)
            end
        end
    elseif vehicle_handler.root.SpoonerPlacements ~= nil then
        local placements = vehicle_handler.root.SpoonerPlacements.Placement
        if placements[1] == nil then placements = {placements} end -- Single prop maps need to be forced into a list
        for _, placement in pairs(placements) do
            if construct_plan.model == nil then
                map_placement(construct_plan, placement)
                if construct_plan.type == "OBJECT" then
                    construct_plan.always_spawn_at_position = true
                end
            else
                local attachment = {}
                map_placement(attachment, placement)
                if construct_plan.always_spawn_at_position == true then attachment.options.is_attached = false end
                table.insert(construct_plan.children, attachment)
            end
        end
    elseif vehicle_handler.root.OutfitPedData then
        construct_plan.type = "PED"
        construct_plan.is_player = true
        local root = vehicle_handler.root.OutfitPedData
        if root[1] == nil then root = {root} end
        map_placement(construct_plan, root[1])
        local attachments = root[1].SpoonerAttachments.Attachment
        if attachments then
            if attachments[1] == nil then attachments = {attachments} end
            for _, placement in pairs(attachments) do
                local attachment = {}
                map_placement(attachment, placement)
                table.insert(construct_plan.children, attachment)
            end
        end
    end

    convertor.rearrange_by_initial_attachment(construct_plan)

    --debug_log("Loaded XML construct plan: "..inspect(construct_plan))

    if construct_plan.hash == nil and construct_plan.model == nil then
        util.toast("Failed to load XML construct. Missing hash or model.", TOAST_ALL)
        util.log("Attempted construct plan: "..inspect(construct_plan))
        return
    end

    return construct_plan
end

---
--- INI Convertor
---

local MAX_NUM_ATTACHMENTS = 300

---
--- INI Mapper Flavor #1
---

local function map_ini_vehicle_flavor_1(attachment, data)
    constructor_lib.default_vehicle_attributes(attachment)
    if data["Model"] ~= nil then attachment.hash = data["Model"] end
    if attachment.model == nil and attachment.hash ~= nil then
        attachment.model = util.reverse_joaat(attachment.hash)
    end
    if attachment.name == nil then attachment.name = attachment.model end
    if data["BulletproofTires"] ~= nil then attachment.vehicle_attributes.wheels.bulletproof_tires = toboolean(data["BulletproofTires"]) end
    if data["CustomPrimaryColor"] ~= nil then attachment.vehicle_attributes.paint.primary.is_custom = toboolean(data["CustomPrimaryColor"]) end
    if data["CustomSecondaryColor"] ~= nil then attachment.vehicle_attributes.paint.secondary.is_custom = toboolean(data["CustomSecondaryColor"]) end

    if data["Dirt"] ~= nil then attachment.vehicle_attributes.paint.dirt_level = tonumber(data["Dirt"]) end

    if data["Neon1"] ~= nil then attachment.vehicle_attributes.neon.lights.left = toboolean(data["Neon1"]) end
    if data["Neon2"] ~= nil then attachment.vehicle_attributes.neon.lights.right = toboolean(data["Neon2"]) end
    if data["Neon3"] ~= nil then attachment.vehicle_attributes.neon.lights.front = toboolean(data["Neon3"]) end
    if data["Neon4"] ~= nil then attachment.vehicle_attributes.neon.lights.back = toboolean(data["Neon4"]) end

    if data["NeonB"] ~= nil then attachment.vehicle_attributes.neon.color.b = tonumber(data["NeonB"]) end
    if data["NeonG"] ~= nil then attachment.vehicle_attributes.neon.color.g = tonumber(data["NeonG"]) end
    if data["NeonR"] ~= nil then attachment.vehicle_attributes.neon.color.r = tonumber(data["NeonR"]) end

    if data["Pearl"] ~= nil then attachment.vehicle_attributes.paint.extra_colors.pearlescent = tonumber(data["Pearl"]) end
    if data["Primary"] ~= nil then attachment.vehicle_attributes.paint.primary.color = tonumber(data["Primary"]) end
    if data["Secondary"] ~= nil then attachment.vehicle_attributes.paint.secondary.color = tonumber(data["Secondary"]) end
    if data["PaintFade"] ~= nil then attachment.vehicle_attributes.paint.fade = tonumber(data["PaintFade"]) end

    if data["PrimaryRed"] ~= nil then attachment.vehicle_attributes.paint.primary.custom_color.r = tonumber(data["PrimaryRed"]) end
    if data["PrimaryGreen"] ~= nil then attachment.vehicle_attributes.paint.primary.custom_color.g = tonumber(data["PrimaryGreen"]) end
    if data["PrimaryBlue"] ~= nil then attachment.vehicle_attributes.paint.primary.custom_color.b = tonumber(data["PrimaryBlue"]) end

    if data["SecondaryRed"] ~= nil then attachment.vehicle_attributes.paint.secondary.custom_color.r = tonumber(data["SecondaryRed"]) end
    if data["SecondaryGreen"] ~= nil then attachment.vehicle_attributes.paint.secondary.custom_color.g = tonumber(data["SecondaryGreen"]) end
    if data["SecondaryBlue"] ~= nil then attachment.vehicle_attributes.paint.secondary.custom_color.b = tonumber(data["SecondaryBlue"]) end

    if data["WheelColor"] ~= nil then attachment.vehicle_attributes.paint.extra_colors.wheel = tonumber(data["WheelColor"]) end
    if data["Wheels"] ~= nil then attachment.vehicle_attributes.wheels.wheel_type = tonumber(data["Wheels"]) end
    if data["Tint"] ~= nil then attachment.vehicle_attributes.options.window_tint = tonumber(data["Tint"]) end

    if data["SmokeB"] ~= nil then attachment.vehicle_attributes.wheels.tire_smoke_color.b = tonumber(data["SmokeB"]) end
    if data["SmokeG"] ~= nil then attachment.vehicle_attributes.wheels.tire_smoke_color.g = tonumber(data["SmokeG"]) end
    if data["SmokeR"] ~= nil then attachment.vehicle_attributes.wheels.tire_smoke_color.r = tonumber(data["SmokeR"]) end

    if data["Plate"] ~= nil then attachment.vehicle_attributes.options.license_plate_type = tonumber(data["Plate"]) end
    if data["PlateText"] ~= nil then attachment.vehicle_attributes.options.license_plate_text = data["PlateText"] end

    for index = 0, 49 do
        local field = data[tostring(index)]
        if (index >= 17 and index <= 22) and field == nil and data["TOGGLE_"..index] ~= nil then
            field = data["TOGGLE_"..index]
        end
        if field ~= nil then
            if (index >= 17 and index <= 22) then
                attachment.vehicle_attributes.mods["_"..index] = toboolean(field)
            else
                attachment.vehicle_attributes.mods["_"..index] = tonumber(field)
            end
        end
    end

    for index = 0, 14 do
        local field = data["extra"..index]
        if field == nil and data["Extra_"..index] ~= nil then
            field = data["Extra_"..index]
        end
        if field ~= nil then
            attachment.vehicle_attributes.extras["_"..index] = toboolean(field)
        end
    end
end

local function map_ini_attachment_flavor_1(attachment, data)
    if data["Model"] ~= nil then attachment.hash = data["Model"] end
    if data["model"] ~= nil then attachment.hash = data["model"] end
    if attachment.model == nil and attachment.hash ~= nil then
        attachment.model = util.reverse_joaat(attachment.hash)
    end
    constructor_lib.default_attachment_attributes(attachment)

    if data["X"] ~= nil then attachment.offset.x = tonumber(data["X"]) end
    if data["x"] ~= nil then attachment.offset.x = tonumber(data["x"]) end
    if data["Y"] ~= nil then attachment.offset.y = tonumber(data["Y"]) end
    if data["y"] ~= nil then attachment.offset.x = tonumber(data["y"]) end
    if data["Z"] ~= nil then attachment.offset.z = tonumber(data["Z"]) end
    if data["z"] ~= nil then attachment.offset.x = tonumber(data["z"]) end

    if data["RotX"] ~= nil then attachment.rotation.x = tonumber(data["RotX"]) end
    if data["RotY"] ~= nil then attachment.rotation.y = tonumber(data["RotY"]) end
    if data["RotZ"] ~= nil then attachment.rotation.z = tonumber(data["RotZ"]) end

    if data["Collision"] ~= nil then attachment.options.has_collision = toboolean(data["Collision"]) end
    if data["Bone"] ~= nil then attachment.options.bone_index = toboolean(data["Bone"]) end
    if data["Froozen"] ~= nil then attachment.options.is_frozen = toboolean(data["Froozen"]) end
    if data["Lit"] ~= nil then attachment.options.is_on_fire = toboolean(data["Lit"]) end
end

local function map_ini_data_flavor_1(construct_plan, data)
    if data.Vehicle ~= nil then
        construct_plan.type = "VEHICLE"
        map_ini_vehicle_flavor_1(construct_plan, data.Vehicle)
        --if data["Vehicle Mods"] ~= nil then
        --    map_ini_vehicle_mods_flavor_1(construct_plan, data["Vehicle Mods"])
        --end
        --if data["Vehicle Toggles"] ~= nil then
        --    map_ini_vehicle_mod_toggles_flavor_1(construct_plan, data["Vehicle Toggles"])
        --end
        --if data["Vehicle Extras"] ~= nil then
        --    map_ini_vehicle_extras_flavor_1(construct_plan, data["Vehicle Extras"])
        --end
        for attachment_index = 0, MAX_NUM_ATTACHMENTS do
            local attached_object = data[tostring(attachment_index)]
            if attached_object ~= nil and (attached_object.Model or attached_object.model) then
                local attachment = {}
                map_ini_attachment_flavor_1(attachment, attached_object)
                table.insert(construct_plan.children, attachment)
            end
        end
    end
end


---
--- INI Mapper Flavor #2
---

local function map_ini_vehicle_flavor_2(attachment, data)
    constructor_lib.default_vehicle_attributes(attachment)
    if data["model"] ~= nil then attachment.hash = data["model"] end
    if attachment.model == nil and attachment.hash ~= nil then
        attachment.model = util.reverse_joaat(attachment.hash)
    end
    if attachment.name == nil then attachment.name = attachment.model end
    if data["bulletproof tyres"] ~= nil then attachment.vehicle_attributes.wheels.bulletproof_tires = toboolean(data["bulletproof tyres"]) end
    if data["custom primary colour"] ~= nil then attachment.vehicle_attributes.paint.primary.is_custom = toboolean(data["custom primary colour"]) end
    if data["custom secondary colour"] ~= nil then attachment.vehicle_attributes.paint.secondary.is_custom = toboolean(data["custom secondary colour"]) end

    if data["dirt level"] ~= nil then attachment.vehicle_attributes.paint.dirt_level = tonumber(data["dirt level"]) end

    if data["neon 0"] ~= nil then attachment.vehicle_attributes.neon.lights.left = toboolean(data["neon 0"]) end
    if data["neon 1"] ~= nil then attachment.vehicle_attributes.neon.lights.right = toboolean(data["neon 1"]) end
    if data["neon 2"] ~= nil then attachment.vehicle_attributes.neon.lights.front = toboolean(data["neon 2"]) end
    if data["neon 3"] ~= nil then attachment.vehicle_attributes.neon.lights.back = toboolean(data["neon 3"]) end

    if data["neon blue"] ~= nil then attachment.vehicle_attributes.neon.color.b = tonumber(data["neon blue"]) end
    if data["neon green"] ~= nil then attachment.vehicle_attributes.neon.color.g = tonumber(data["neon green"]) end
    if data["neon red"] ~= nil then attachment.vehicle_attributes.neon.color.r = tonumber(data["neon red"]) end

    if data["pearlescent colour"] ~= nil then attachment.vehicle_attributes.paint.extra_colors.pearlescent = tonumber(data["pearlescent colour"]) end
    if data["primary paint"] ~= nil then attachment.vehicle_attributes.paint.primary.color = tonumber(data["primary paint"]) end
    if data["secondary paint"] ~= nil then attachment.vehicle_attributes.paint.secondary.color = tonumber(data["secondary paint"]) end

    if data["primary red"] ~= nil then attachment.vehicle_attributes.paint.primary.custom_color.r = tonumber(data["primary red"]) end
    if data["primary green"] ~= nil then attachment.vehicle_attributes.paint.primary.custom_color.g = tonumber(data["primary green"]) end
    if data["primary blue"] ~= nil then attachment.vehicle_attributes.paint.primary.custom_color.b = tonumber(data["primary blue"]) end

    if data["secondary red"] ~= nil then attachment.vehicle_attributes.paint.secondary.custom_color.r = tonumber(data["secondary red"]) end
    if data["secondary green"] ~= nil then attachment.vehicle_attributes.paint.secondary.custom_color.g = tonumber(data["secondary green"]) end
    if data["secondary blue"] ~= nil then attachment.vehicle_attributes.paint.secondary.custom_color.b = tonumber(data["secondary blue"]) end

    if data["custom tyres"] ~= nil then attachment.vehicle_attributes.wheels.wheel_type = tonumber(data["custom tyres"]) end

    if data["wheel colour"] ~= nil then attachment.vehicle_attributes.paint.extra_colors.wheel = tonumber(data["wheel colour"]) end
    if data["wheel type"] ~= nil then attachment.vehicle_attributes.wheels.wheel_type = tonumber(data["wheel type"]) end
    if data["window tint"] ~= nil then attachment.vehicle_attributes.options.window_tint = tonumber(data["window tint"]) end

    if data["tyre smoke blue"] ~= nil then attachment.vehicle_attributes.wheels.tire_smoke_color.b = tonumber(data["tyre smoke blue"]) end
    if data["tyre smoke green"] ~= nil then attachment.vehicle_attributes.wheels.tire_smoke_color.g = tonumber(data["tyre smoke green"]) end
    if data["tyre smoke red"] ~= nil then attachment.vehicle_attributes.wheels.tire_smoke_color.r = tonumber(data["tyre smoke red"]) end

    if data["plate index"] ~= nil then attachment.vehicle_attributes.options.license_plate_type = tonumber(data["plate index"]) end
    if data["plate text"] ~= nil then attachment.vehicle_attributes.options.license_plate_text = data["plate text"] end

    for index = 0, 49 do
        local field
        if (index >= 17 and index <= 22) then
            field = data["toggle "..index]
            if field ~= nil then
                attachment.vehicle_attributes.mods["_"..index] = toboolean(field)
            end
        else
            field = data["mods "..index]
            if field ~= nil then
                attachment.vehicle_attributes.mods["_"..index] = tonumber(field)
            end
        end
    end

    for index = 0, 14 do
        local field = data["extra "..index]
        if field ~= nil then
            attachment.vehicle_attributes.extras["_"..index] = toboolean(field)
        end
    end
end

local function map_ini_vehicle_mods_flavor_2(attachment, data)
    for index = 0, 49 do
        if not (index >= 17 and index <= 22) then
            attachment.vehicle_attributes.mods["_"..index] = tonumber(data[index])
        end
    end
end

local function map_ini_vehicle_mod_toggles_flavor_2(attachment, data)
    for index = 17, 22 do
        attachment.vehicle_attributes.mods["_"..index] = toboolean(data[index])
    end
end

local function map_ini_vehicle_extras_flavor_2(attachment, data)
    for index = 0, 14 do
        if data[index] ~= nil then
            attachment.vehicle_attributes.extras["_"..index] = toboolean(data[index])
        end
    end
end

local function map_ini_attachment_flavor_2(attachment, data)
    if data["model"] ~= nil then attachment.hash = data["model"] end
    if attachment.model == nil and attachment.hash ~= nil then
        attachment.model = util.reverse_joaat(attachment.hash)
    end
    constructor_lib.default_attachment_attributes(attachment)

    if data["x"] ~= nil then attachment.offset.x = parse_number(data["x"]) end
    if data["y"] ~= nil then attachment.offset.y = parse_number(data["y"]) end
    if data["z"] ~= nil then attachment.offset.z = parse_number(data["z"]) end

    if data["RotX"] ~= nil then attachment.rotation.x = parse_number(data["RotX"]) end
    if data["RotY"] ~= nil then attachment.rotation.y = parse_number(data["RotY"]) end
    if data["RotZ"] ~= nil then attachment.rotation.z = parse_number(data["RotZ"]) end

    if data["collision"] ~= nil then attachment.options.has_collision = toboolean(data["collision"]) end
end

local function map_ini_data_flavor_2(construct_plan, data)
    if data.Vehicle ~= nil then
        construct_plan.type = "VEHICLE"
        map_ini_vehicle_flavor_2(construct_plan, data.Vehicle)
        if data["Vehicle Mods"] ~= nil then
            map_ini_vehicle_mods_flavor_2(construct_plan, data["Vehicle Mods"])
        end
        if data["Vehicle Toggles"] ~= nil then
            map_ini_vehicle_mod_toggles_flavor_2(construct_plan, data["Vehicle Toggles"])
        end
        if data["Vehicle Extras"] ~= nil then
            map_ini_vehicle_extras_flavor_2(construct_plan, data["Vehicle Extras"])
        end
        for attachment_index = 0, MAX_NUM_ATTACHMENTS do
            local attached_object = data[tostring(attachment_index)]
            if attached_object ~= nil and attached_object.model then
                local attachment = {}
                map_ini_attachment_flavor_2(attachment, attached_object)
                table.insert(construct_plan.children, attachment)
            end
        end
    end
end

---
--- INI Mapper Flavor #3
---

local function map_ini_vehicle_flavor_3(attachment, data)
    if data["Model"] ~= nil then attachment.hash = data["Model"] end
    if attachment.model == nil and attachment.hash ~= nil then
        attachment.model = util.reverse_joaat(attachment.hash)
    end
    constructor_lib.default_vehicle_attributes(attachment)
    if data["PaintFade"] ~= nil then attachment.vehicle_attributes.paint.fade = tonumber(data["PaintFade"]) end
    if data["DashColor"] ~= nil then attachment.vehicle_attributes.paint.dashboard_color = tonumber(data["DashColor"]) end
    if data["BulletProof"] ~= nil then attachment.vehicle_attributes.wheels.bulletproof_tires = toboolean(data["BulletProof"]) end
    if data["NeonEnabled"] ~= nil and toboolean(data["NeonEnabled"]) == true then
        attachment.vehicle_attributes.neon.lights.left = true
        attachment.vehicle_attributes.neon.lights.right = true
        attachment.vehicle_attributes.neon.lights.front = true
        attachment.vehicle_attributes.neon.lights.back = true
    end
    if data["NeonR"] ~= nil then attachment.vehicle_attributes.neon.color.r = tonumber(data["NeonR"]) end
    if data["NeonG"] ~= nil then attachment.vehicle_attributes.neon.color.g = tonumber(data["NeonG"]) end
    if data["NeonB"] ~= nil then attachment.vehicle_attributes.neon.color.b = tonumber(data["NeonB"]) end
    if data["SmokeR"] ~= nil then attachment.vehicle_attributes.wheels.tire_smoke_color.r = tonumber(data["SmokeR"]) end
    if data["SmokeG"] ~= nil then attachment.vehicle_attributes.wheels.tire_smoke_color.g = tonumber(data["SmokeG"]) end
    if data["SmokeB"] ~= nil then attachment.vehicle_attributes.wheels.tire_smoke_color.b = tonumber(data["SmokeB"]) end
    if data["WindowTint"] ~= nil then attachment.vehicle_attributes.options.window_tint = tonumber(data["WindowTint"]) end
    if data["PrimaryPaintT"] ~= nil then attachment.vehicle_attributes.paint.primary.is_custom = toboolean(data["PrimaryPaintT"]) end
    if data["PrimaryPaint"] ~= nil then attachment.vehicle_attributes.paint.primary.color = tonumber(data["PrimaryPaint"]) end
    if data["SecondaryPaintT"] ~= nil then attachment.vehicle_attributes.paint.secondary.is_custom = toboolean(data["SecondaryPaintT"]) end
    if data["SecondaryPaint"] ~= nil then attachment.vehicle_attributes.paint.secondary.color = tonumber(data["SecondaryPaint"]) end
    if data["Pearlescent"] ~= nil then attachment.vehicle_attributes.paint.extra_colors.pearlescent = tonumber(data["Pearlescent"]) end
    if data["PrimaryR"] ~= nil then attachment.vehicle_attributes.paint.primary.custom_color.r = tonumber(data["PrimaryR"]) end
    if data["PrimaryG"] ~= nil then attachment.vehicle_attributes.paint.primary.custom_color.g = tonumber(data["PrimaryG"]) end
    if data["PrimaryB"] ~= nil then attachment.vehicle_attributes.paint.primary.custom_color.b = tonumber(data["PrimaryB"]) end
    if data["SecondaryR"] ~= nil then attachment.vehicle_attributes.paint.secondary.custom_color.r = tonumber(data["SecondaryR"]) end
    if data["SecondaryG"] ~= nil then attachment.vehicle_attributes.paint.secondary.custom_color.g = tonumber(data["SecondaryG"]) end
    if data["SecondaryB"] ~= nil then attachment.vehicle_attributes.paint.secondary.custom_color.b = tonumber(data["SecondaryB"]) end
    if data["WheelsColor"] ~= nil then attachment.vehicle_attributes.paint.extra_colors.wheel = tonumber(data["WheelsColor"]) end
    if data["WheelsType"] ~= nil then attachment.vehicle_attributes.wheels.wheel_type = tonumber(data["WheelsType"]) end
    if data["PlateIndex"] ~= nil then attachment.vehicle_attributes.options.license_plate_type = tonumber(data["PlateIndex"]) end
    if data["PlateText"] ~= nil then attachment.vehicle_attributes.options.license_plate_text = data["PlateText"] end
end

local function map_ini_vehicle_mods_flavor_3(attachment, data)
    for index = 0, 49 do
        if not (index >= 17 and index <= 22) then
            attachment.vehicle_attributes.mods["_"..index] = tonumber(data[index])
        end
    end
end

local function map_ini_vehicle_toggles_flavor_3(attachment, data)
    for index = 17, 22 do
        attachment.vehicle_attributes.mods["_"..index] = toboolean(data["TOGGLE_"..index])
    end
end

local function map_ini_attachment_flavor_3(attachment, data)
    if data["Model"] ~= nil then attachment.hash = data["Model"] end
    if attachment.model == nil and attachment.hash ~= nil then
        attachment.model = util.reverse_joaat(attachment.hash)
    end
    constructor_lib.default_attachment_attributes(attachment)

    if data["X"] ~= nil then attachment.offset.x = tonumber(data["X"]) end
    if data["Y"] ~= nil then attachment.offset.y = tonumber(data["Y"]) end
    if data["Z"] ~= nil then attachment.offset.z = tonumber(data["Z"]) end

    if data["RotX"] ~= nil then attachment.rotation.x = tonumber(data["RotX"]) end
    if data["RotY"] ~= nil then attachment.rotation.y = tonumber(data["RotY"]) end
    if data["RotZ"] ~= nil then attachment.rotation.z = tonumber(data["RotZ"]) end
end

local function map_ini_data_flavor_3(construct_plan, data)
    if data.Vehicle ~= nil then
        construct_plan.type = "VEHICLE"
        map_ini_vehicle_flavor_3(construct_plan, data.Vehicle)
        map_ini_vehicle_mods_flavor_3(construct_plan, data.Vehicle)
        map_ini_vehicle_toggles_flavor_3(construct_plan, data.Vehicle)
        for attachment_index = 0, MAX_NUM_ATTACHMENTS do
            local attached_object = data[tostring(attachment_index)]
            if attached_object ~= nil and attached_object.Model ~= 0 then
                local attachment = {}
                attachment.type = "OBJECT"
                map_ini_attachment_flavor_3(attachment, attached_object)
                table.insert(construct_plan.children, attachment)
            end
        end
    end
end

---
--- INI Mapper Flavor #4
---

local function clean_ini_number(value)
    if value == nil then return value end
    if type(value) == "string" then
        value = value:gsub("%s+", "") -- trim spaces
        value = value:gsub(",", ".") -- replace commas with decimals
        value = tonumber(value)
    end
    return value
end

local function map_ini_attachment_flavor_4(attachment, data)
    if data["Hash"] ~= nil then attachment.hash = data["Hash"] end
    if attachment.model == nil and attachment.hash ~= nil then
        attachment.model = util.reverse_joaat(attachment.hash)
    end
    constructor_lib.default_attachment_attributes(attachment)
    if data["Name"] ~= nil then attachment.name = data["Name"] end

    if data["PosX"] ~= nil then attachment.position.x = clean_ini_number(data["PosX"]) end
    if data["PosY"] ~= nil then attachment.position.y = clean_ini_number(data["PosY"]) end
    if data["PosZ"] ~= nil then attachment.position.z = clean_ini_number(data["PosZ"]) end

    if data["RotX"] ~= nil then attachment.world_rotation.x = clean_ini_number(data["RotX"]) end
    if data["RotY"] ~= nil then attachment.world_rotation.y = clean_ini_number(data["RotY"]) end
    if data["RotZ"] ~= nil then attachment.world_rotation.z = clean_ini_number(data["RotZ"]) end

    -- Ini flavor 4 uses rotation axis 0
    attachment.rotation_order = 0

    if data["OffsetX"] ~= nil then attachment.offset.x = clean_ini_number(data["OffsetX"]) end
    if data["OffsetY"] ~= nil then attachment.offset.y = clean_ini_number(data["OffsetY"]) end
    if data["OffsetZ"] ~= nil then attachment.offset.z = clean_ini_number(data["OffsetZ"]) end

    if data["Pitch"] ~= nil then attachment.rotation.x = clean_ini_number(data["Pitch"]) end
    if data["Roll"] ~= nil then attachment.rotation.y = clean_ini_number(data["Roll"]) end
    if data["Yaw"] ~= nil then attachment.rotation.z = clean_ini_number(data["Yaw"]) end

    if data["Collision"] ~= nil then attachment.options.has_collision = toboolean(data["Collision"]) end
    if data["Visible"] ~= nil then attachment.options.is_visible = toboolean(data["Visible"]) end
    if data["Gravity"] ~= nil then attachment.options.has_gravity = toboolean(data["Gravity"]) end
    if data["Invincible"] ~= nil then attachment.options.is_invincible = toboolean(data["Invincible"]) end
    if data["Freeze"] ~= nil then attachment.options.is_frozen = toboolean(data["Freeze"]) end
    if data["Lights"] ~= nil then attachment.options.lights = toboolean(data["Lights"]) end
    if data["Dynamic"] ~= nil then attachment.options.is_dynamic = toboolean(data["Dynamic"]) end
    if data["Health"] ~= nil then attachment.options.health = tonumber(data["Health"]) end
    if data["Alpha"] ~= nil then attachment.options.alpha = tonumber(data["Alpha"]) end
    if data["Bone"] ~= nil then attachment.options.bone_index = tonumber(data["Bone"]) end
    if data["IsAttached"] ~= nil then attachment.options.is_attached = tonumber(data["IsAttached"]) end
    if data["SelfNumeration"] ~= nil then attachment.initial_handle = tonumber(data["SelfNumeration"]) end
    if data["AttachNumeration"] ~= nil then attachment.parents_initial_handle = tonumber(data["AttachNumeration"]) end
end

local function map_ini_vehicle_flavor_4(attachment, data, index)
    constructor_lib.default_vehicle_attributes(attachment)
    local vehicle_main = data["Vehicle"..index]

    if vehicle_main["Dirt"] ~= nil then attachment.vehicle_attributes.paint.dirt_level = clean_ini_number(vehicle_main["Dirt"]) end
    if vehicle_main["IsEngineOn"] ~= nil then attachment.vehicle_attributes.options.engine_running = toboolean(vehicle_main["IsEngineOn"]) end
    if vehicle_main["HeadlightMultiplier"] ~= nil then attachment.vehicle_attributes.headlights.multiplier = clean_ini_number(vehicle_main["HeadlightMultiplier"]) end
    if vehicle_main["LightsState"] ~= nil then attachment.vehicle_attributes.options.lights_state = tonumber(vehicle_main["LightsState"]) end
    if vehicle_main["InteriorLight"] ~= nil then attachment.vehicle_attributes.options.interior_light = tonumber(vehicle_main["InteriorLight "]) end
    if vehicle_main["ScorchedRender"] ~= nil then attachment.vehicle_attributes.options.is_scorched = toboolean(vehicle_main["ScorchedRender"]) end
    if vehicle_main["Siren"] ~= nil then attachment.vehicle_attributes.options.siren = toboolean(vehicle_main["Siren"]) end
    if vehicle_main["WindscreenDetached"] ~= nil then attachment.vehicle_attributes.options.is_windscreen_detached = toboolean(vehicle_main["WindscreenDetached"]) end

    if vehicle_main["Doorbroken0"] ~= nil then attachment.vehicle_attributes.doors.broken.frontleft = toboolean(vehicle_main["Doorbroken0"]) end
    if vehicle_main["Doorbroken1"] ~= nil then attachment.vehicle_attributes.doors.broken.frontright = toboolean(vehicle_main["Doorbroken1"]) end
    if vehicle_main["Doorbroken2"] ~= nil then attachment.vehicle_attributes.doors.broken.backleft = toboolean(vehicle_main["Doorbroken2"]) end
    if vehicle_main["Doorbroken3"] ~= nil then attachment.vehicle_attributes.doors.broken.backright = toboolean(vehicle_main["Doorbroken3"]) end
    if vehicle_main["Doorbroken4"] ~= nil then attachment.vehicle_attributes.doors.broken.hood = toboolean(vehicle_main["Doorbroken4"]) end
    if vehicle_main["Doorbroken5"] ~= nil then attachment.vehicle_attributes.doors.broken.trunk = toboolean(vehicle_main["Doorbroken5"]) end
    if vehicle_main["Doorbroken6"] ~= nil then attachment.vehicle_attributes.doors.broken.trunk2 = toboolean(vehicle_main["Doorbroken6"]) end

    if vehicle_main["TyreBurstLF"] ~= nil then attachment.vehicle_attributes.wheels.tires_burst["_0"] = toboolean(vehicle_main["TyreBurstLF"]) end
    if vehicle_main["TyreBurstRF"] ~= nil then attachment.vehicle_attributes.wheels.tires_burst["_1"] = toboolean(vehicle_main["TyreBurstRF"]) end
    if vehicle_main["TyreBurstLM"] ~= nil then attachment.vehicle_attributes.wheels.tires_burst["_2"] = toboolean(vehicle_main["TyreBurstLM"]) end
    if vehicle_main["TyreBurstRM"] ~= nil then attachment.vehicle_attributes.wheels.tires_burst["_3"] = toboolean(vehicle_main["TyreBurstRM"]) end
    if vehicle_main["TyreBurstLR"] ~= nil then attachment.vehicle_attributes.wheels.tires_burst["_4"] = toboolean(vehicle_main["TyreBurstLR"]) end
    if vehicle_main["TyreBurstRR"] ~= nil then attachment.vehicle_attributes.wheels.tires_burst["_5"] = toboolean(vehicle_main["TyreBurstRR"]) end
    if vehicle_main["TyreBurst6ML"] ~= nil then attachment.vehicle_attributes.wheels.tires_burst["_45"] = toboolean(vehicle_main["TyreBurst6ML"]) end
    if vehicle_main["TyreBurst6MR"] ~= nil then attachment.vehicle_attributes.wheels.tires_burst["_47"] = toboolean(vehicle_main["TyreBurst6MR"]) end

    if data["Vehicle"..index.."TireSmoke"] ~= nil then
        if data["Vehicle"..index.."TireSmoke"].R ~= nil then attachment.vehicle_attributes.wheels.tire_smoke_color.r = tonumber(data["Vehicle"..index.."TireSmoke"].R) end
        if data["Vehicle"..index.."TireSmoke"].G ~= nil then attachment.vehicle_attributes.wheels.tire_smoke_color.g = tonumber(data["Vehicle"..index.."TireSmoke"].G) end
        if data["Vehicle"..index.."TireSmoke"].B ~= nil then attachment.vehicle_attributes.wheels.tire_smoke_color.b = tonumber(data["Vehicle"..index.."TireSmoke"].B) end
    end
    if data["Vehicle"..index.."Neon"] ~= nil then
        if data["Vehicle"..index.."Neon"].Enabled1 ~= nil then attachment.vehicle_attributes.neon.lights.left = toboolean(data["Vehicle"..index.."Neon"].Enabled1) end
        if data["Vehicle"..index.."Neon"].Enabled2 ~= nil then attachment.vehicle_attributes.neon.lights.right = toboolean(data["Vehicle"..index.."Neon"].Enabled2) end
        if data["Vehicle"..index.."Neon"].Enabled3 ~= nil then attachment.vehicle_attributes.neon.lights.front = toboolean(data["Vehicle"..index.."Neon"].Enabled3) end
        if data["Vehicle"..index.."Neon"].Enabled4 ~= nil then attachment.vehicle_attributes.neon.lights.back = toboolean(data["Vehicle"..index.."Neon"].Enabled4) end
    end
    if data["Vehicle"..index.."PaintFade"] ~= nil then
        if data["Vehicle"..index.."PaintFade"].PaintFade ~= nil then attachment.vehicle_attributes.paint.fade = tonumber(data["Vehicle"..index.."PaintFade"].PaintFade) end
    end
    if data["Vehicle"..index.."NeonColor"] ~= nil then
        if data["Vehicle"..index.."NeonColor"].R ~= nil then attachment.vehicle_attributes.neon.color.r = tonumber(data["Vehicle"..index.."NeonColor"].R) end
        if data["Vehicle"..index.."NeonColor"].G ~= nil then attachment.vehicle_attributes.neon.color.g = tonumber(data["Vehicle"..index.."NeonColor"].G) end
        if data["Vehicle"..index.."NeonColor"].B ~= nil then attachment.vehicle_attributes.neon.color.b = tonumber(data["Vehicle"..index.."NeonColor"].B) end
    end
    if data["Vehicle"..index.."VehicleColors"] ~= nil then
        if data["Vehicle"..index.."VehicleColors"].Primary ~= nil then attachment.vehicle_attributes.paint.primary.color = tonumber(data["Vehicle"..index.."VehicleColors"].Primary) end
        if data["Vehicle"..index.."VehicleColors"].Secondary ~= nil then attachment.vehicle_attributes.paint.secondary.color = tonumber(data["Vehicle"..index.."VehicleColors"].Secondary) end
    end
    if data["Vehicle"..index.."ExtraColors"] ~= nil then
        if data["Vehicle"..index.."ExtraColors"].Pearl ~= nil then attachment.vehicle_attributes.paint.extra_colors.pearlescent = tonumber(data["Vehicle"..index.."ExtraColors"].Pearl) end
        if data["Vehicle"..index.."ExtraColors"].Wheel ~= nil then attachment.vehicle_attributes.paint.extra_colors.wheel = tonumber(data["Vehicle"..index.."ExtraColors"].Wheel) end
    end
    if data["Vehicle"..index.."IsCustomPrimary"] ~= nil then
        attachment.vehicle_attributes.paint.primary.is_custom = toboolean(data["Vehicle"..index.."IsCustomPrimary"])
    end
    if data["Vehicle"..index.."CustomPrimaryColor"] ~= nil then
        if data["Vehicle"..index.."CustomPrimaryColor"].R ~= nil then attachment.vehicle_attributes.paint.primary.custom_color.r = tonumber(data["Vehicle"..index.."CustomPrimaryColor"].R) end
        if data["Vehicle"..index.."CustomPrimaryColor"].G ~= nil then attachment.vehicle_attributes.paint.primary.custom_color.g = tonumber(data["Vehicle"..index.."CustomPrimaryColor"].G) end
        if data["Vehicle"..index.."CustomPrimaryColor"].B ~= nil then attachment.vehicle_attributes.paint.primary.custom_color.b = tonumber(data["Vehicle"..index.."CustomPrimaryColor"].B) end
    end
    if data["Vehicle"..index.."IsCustomSecondary"] ~= nil then
        attachment.vehicle_attributes.paint.secondary.is_custom = toboolean(data["Vehicle"..index.."IsCustomSecondary"])
    end
    if data["Vehicle"..index.."CustomSecondaryColor"] ~= nil then
        if data["Vehicle"..index.."CustomSecondaryColor"].R ~= nil then attachment.vehicle_attributes.paint.secondary.custom_color.r = tonumber(data["Vehicle"..index.."CustomSecondaryColor"].R) end
        if data["Vehicle"..index.."CustomSecondaryColor"].G ~= nil then attachment.vehicle_attributes.paint.secondary.custom_color.g = tonumber(data["Vehicle"..index.."CustomSecondaryColor"].G) end
        if data["Vehicle"..index.."CustomSecondaryColor"].B ~= nil then attachment.vehicle_attributes.paint.secondary.custom_color.b = tonumber(data["Vehicle"..index.."CustomSecondaryColor"].B) end
    end
    if data["Vehicle"..index.."WheelType"] ~= nil then
        if data["Vehicle"..index.."WheelType"].Index ~= nil then attachment.vehicle_attributes.wheels.wheel_type = tonumber(data["Vehicle"..index.."WheelType"].Index) end
    end
    if data["Vehicle"..index.."NumberPlate"] ~= nil then
        if data["Vehicle"..index.."NumberPlate"].Text ~= nil then attachment.vehicle_attributes.options.license_plate_text = data["Vehicle"..index.."NumberPlate"].Text end
        if data["Vehicle"..index.."NumberPlate"].Index ~= nil then attachment.vehicle_attributes.options.license_plate_type = tonumber(data["Vehicle"..index.."NumberPlate"].Index) end
    end
    if data["Vehicle"..index.."WindowTint"] ~= nil then
        if data["Vehicle"..index.."WindowTint"].Index ~= nil then attachment.vehicle_attributes.options.window_tint = tonumber(data["Vehicle"..index.."WindowTint"].Index) end
    end
end

local function map_ini_vehicle_mods_flavor_4(attachment, data)
    for index = 0, 49 do
        if not (index >= 17 and index <= 22) then
            attachment.vehicle_attributes.mods["_"..index] = tonumber(data["M"..index])
        end
    end
end

local function map_ini_vehicle_toggles_flavor_4(attachment, data)
    for index = 0, 49 do
        if (index >= 17 and index <= 22) then
            attachment.vehicle_attributes.mods["_"..index] = tonumber(data["T"..index])
        end
    end
end

local function map_ini_vehicle_extras_flavor_4(attachment, data)
    for index = 0, 14 do
        if data["E"..index] ~= nil then
            attachment.vehicle_attributes.extras["_"..index] = toboolean(data["E"..index])
        end
    end
end


local function map_ini_data_flavor_4(construct_plan, data)
    if data.Vehicle0 ~= nil then
        construct_plan.type = "VEHICLE"
        map_ini_attachment_flavor_4(construct_plan, data.Vehicle0)
        map_ini_vehicle_flavor_4(construct_plan, data, 0)
        if data.Vehicle0Mods ~= nil then
            map_ini_vehicle_mods_flavor_4(construct_plan, data.Vehicle0Mods)
        end
        if data.Vehicle0Toggles ~= nil then
            map_ini_vehicle_toggles_flavor_4(construct_plan, data.Vehicle0Toggles)
        end
        if data.Vehicle0Extras ~= nil then
            map_ini_vehicle_extras_flavor_4(construct_plan, data.Vehicle0Extras)
        end
        for vehicle_index = 1, tonumber(data.AllVehicles.Count) - 1 do
            local attached_vehicle = data["Vehicle"..vehicle_index]
            if attached_vehicle ~= nil then
                local attachment = {}
                attachment.type = "VEHICLE"
                map_ini_attachment_flavor_4(attachment, attached_vehicle)
                map_ini_vehicle_flavor_4(attachment, data, vehicle_index)
                if data["Vehicle"..vehicle_index.."Mods"] ~= nil then
                    map_ini_vehicle_mods_flavor_4(attachment, data["Vehicle"..vehicle_index.."Mods"])
                end
                if data["Vehicle"..vehicle_index.."Toggles"] ~= nil then
                    map_ini_vehicle_toggles_flavor_4(attachment, data["Vehicle"..vehicle_index.."Toggles"])
                end
                if data["Vehicle"..vehicle_index.."Extras"] ~= nil then
                    map_ini_vehicle_extras_flavor_4(attachment, data["Vehicle"..vehicle_index.."Extras"])
                end
                table.insert(construct_plan.children, attachment)
            end
        end
        for object_index = 0, tonumber(data.AllObjects.Count) - 1 do
            local attached_object = data["Object".. object_index]
            if attached_object ~= nil and attached_object.Hash ~= 0 then
                debug_log("Processing object "..object_index)
                local attachment = {}
                attachment.type = "OBJECT"
                map_ini_attachment_flavor_4(attachment, attached_object)
                table.insert(construct_plan.children, attachment)
            end
        end
    elseif data.Object0 ~= nil and constructor_lib.trim(data.Object0.AttachedToWhat) == "Self" then
        construct_plan.type = "PED"
        construct_plan.is_player = true
        for object_index = 0, tonumber(data.AllObjects.Count) - 1 do
            local attached_object = data["Object".. object_index]
            if attached_object ~= nil and attached_object.Hash ~= 0 then
                local attachment = {}
                attachment.type = "OBJECT"
                map_ini_attachment_flavor_4(attachment, attached_object)
                table.insert(construct_plan.children, attachment)
            end
        end
    end
end

---
--- INI Mapper Flavor #6
---

local function map_ini_vehicle_flavor_6(attachment, data)
    constructor_lib.default_vehicle_attributes(attachment)
    if data["model"] ~= nil then attachment.hash = data["model"] end
    if attachment.model == nil and attachment.hash ~= nil then
        attachment.model = util.reverse_joaat(attachment.hash)
    end
    if attachment.name == nil then attachment.name = attachment.model end
    if data["bulletproof tyres"] ~= nil then attachment.vehicle_attributes.wheels.bulletproof_tires = toboolean(data["bulletproof tyres"]) end
    if data["custom primary colour"] ~= nil then attachment.vehicle_attributes.paint.primary.is_custom = toboolean(data["custom primary colour"]) end
    if data["custom secondary colour"] ~= nil then attachment.vehicle_attributes.paint.secondary.is_custom = toboolean(data["custom secondary colour"]) end

    if data["dirt level"] ~= nil then attachment.vehicle_attributes.paint.dirt_level = tonumber(data["dirt level"]) end

    if data["neon 0"] ~= nil then attachment.vehicle_attributes.neon.lights.left = toboolean(data["neon 0"]) end
    if data["neon 1"] ~= nil then attachment.vehicle_attributes.neon.lights.right = toboolean(data["neon 1"]) end
    if data["neon 2"] ~= nil then attachment.vehicle_attributes.neon.lights.front = toboolean(data["neon 2"]) end
    if data["neon 3"] ~= nil then attachment.vehicle_attributes.neon.lights.back = toboolean(data["neon 3"]) end

    if data["neon blue"] ~= nil then attachment.vehicle_attributes.neon.color.b = tonumber(data["neon blue"]) end
    if data["neon green"] ~= nil then attachment.vehicle_attributes.neon.color.g = tonumber(data["neon green"]) end
    if data["neon red"] ~= nil then attachment.vehicle_attributes.neon.color.r = tonumber(data["neon red"]) end

    if data["pearlescent colour"] ~= nil then attachment.vehicle_attributes.paint.extra_colors.pearlescent = tonumber(data["pearlescent colour"]) end
    if data["primary paint"] ~= nil then attachment.vehicle_attributes.paint.primary.color = tonumber(data["primary paint"]) end
    if data["secondary paint"] ~= nil then attachment.vehicle_attributes.paint.secondary.color = tonumber(data["secondary paint"]) end

    if data["primary red"] ~= nil then attachment.vehicle_attributes.paint.primary.custom_color.r = tonumber(data["primary red"]) end
    if data["primary green"] ~= nil then attachment.vehicle_attributes.paint.primary.custom_color.g = tonumber(data["primary green"]) end
    if data["primary blue"] ~= nil then attachment.vehicle_attributes.paint.primary.custom_color.b = tonumber(data["primary blue"]) end

    if data["secondary red"] ~= nil then attachment.vehicle_attributes.paint.secondary.custom_color.r = tonumber(data["secondary red"]) end
    if data["secondary green"] ~= nil then attachment.vehicle_attributes.paint.secondary.custom_color.g = tonumber(data["secondary green"]) end
    if data["secondary blue"] ~= nil then attachment.vehicle_attributes.paint.secondary.custom_color.b = tonumber(data["secondary blue"]) end

    if data["custom tyres"] ~= nil then attachment.vehicle_attributes.wheels.wheel_type = tonumber(data["custom tyres"]) end

    if data["wheel colour"] ~= nil then attachment.vehicle_attributes.paint.extra_colors.wheel = tonumber(data["wheel colour"]) end
    if data["wheel type"] ~= nil then attachment.vehicle_attributes.wheels.wheel_type = tonumber(data["wheel type"]) end
    if data["window tint"] ~= nil then attachment.vehicle_attributes.options.window_tint = tonumber(data["window tint"]) end

    if data["tyre smoke blue"] ~= nil then attachment.vehicle_attributes.wheels.tire_smoke_color.b = tonumber(data["tyre smoke blue"]) end
    if data["tyre smoke green"] ~= nil then attachment.vehicle_attributes.wheels.tire_smoke_color.g = tonumber(data["tyre smoke green"]) end
    if data["tyre smoke red"] ~= nil then attachment.vehicle_attributes.wheels.tire_smoke_color.r = tonumber(data["tyre smoke red"]) end

    if data["plate index"] ~= nil then attachment.vehicle_attributes.options.license_plate_type = tonumber(data["plate index"]) end
    if data["plate text"] ~= nil then attachment.vehicle_attributes.options.license_plate_text = data["plate text"] end

    for index = 0, 49 do
        local field
        if (index >= 17 and index <= 22) then
            field = data["toggle "..index]
            if field ~= nil then
                attachment.vehicle_attributes.mods["_"..index] = toboolean(field)
            end
        else
            field = data["mods "..index]
            if field ~= nil then
                attachment.vehicle_attributes.mods["_"..index] = tonumber(field)
            end
        end
    end

    for index = 0, 14 do
        local field = data["extra "..index]
        if field ~= nil then
            attachment.vehicle_attributes.extras["_"..index] = toboolean(field)
        end
    end
end

local function map_ini_vehicle_mods_flavor_6(attachment, data)
    for index = 0, 49 do
        if not (index >= 17 and index <= 22) then
            attachment.vehicle_attributes.mods["_"..index] = tonumber(data[tostring(index)])
        end
    end
end

local function map_ini_vehicle_mod_toggles_flavor_6(attachment, data)
    for index = 17, 22 do
        attachment.vehicle_attributes.mods["_"..index] = toboolean(data[tostring(index)])
    end
end

local function map_ini_vehicle_extras_flavor_6(attachment, data)
    for index = 0, 14 do
        if data[index] ~= nil then
            attachment.vehicle_attributes.extras["_"..index] = toboolean(data[tostring(index)])
        end
    end
end

local function map_ini_attachment_flavor_6(attachment, data)
    if data["model"] ~= nil then attachment.hash = data["model"] end
    if attachment.model == nil and attachment.hash ~= nil then
        attachment.model = util.reverse_joaat(attachment.hash)
    end
    constructor_lib.default_attachment_attributes(attachment)

    if data["x offset"] ~= nil then attachment.offset.x = tonumber(data["x offset"]) end
    if data["y offset"] ~= nil then attachment.offset.y = tonumber(data["y offset"]) end
    if data["z offset"] ~= nil then attachment.offset.z = tonumber(data["z offset"]) end

    if data["pitch"] ~= nil then attachment.rotation.x = tonumber(data["pitch"]) end
    if data["roll"] ~= nil then attachment.rotation.y = tonumber(data["roll"]) end
    if data["yaw"] ~= nil then attachment.rotation.z = tonumber(data["yaw"]) end

    if data["collision"] ~= nil then attachment.options.has_collision = toboolean(data["collision"]) end
end

local function map_ini_data_flavor_6(construct_plan, data)
    if data.Vehicle ~= nil then
        construct_plan.type = "VEHICLE"
        map_ini_vehicle_flavor_6(construct_plan, data.Vehicle)
        if data["Vehicle Mods"] ~= nil then
            map_ini_vehicle_mods_flavor_6(construct_plan, data["Vehicle Mods"])
        end
        if data["Vehicle Toggles"] ~= nil then
            map_ini_vehicle_mod_toggles_flavor_6(construct_plan, data["Vehicle Toggles"])
        end
        if data["Vehicle Extras"] ~= nil then
            map_ini_vehicle_extras_flavor_6(construct_plan, data["Vehicle Extras"])
        end
        for attachment_index = 1, MAX_NUM_ATTACHMENTS do
            local attached_object = data["Attached Object "..attachment_index]
            if attached_object ~= nil and attached_object.model then
                local attachment = {}
                map_ini_attachment_flavor_6(attachment, attached_object)
                table.insert(construct_plan.children, attachment)
            end
        end
        for attachment_index = 1, MAX_NUM_ATTACHMENTS do
            local attached_vehicle = data["Attached Vehicle "..attachment_index]
            if attached_vehicle ~= nil and attached_vehicle.model then
                local attachment = {}
                map_ini_attachment_flavor_6(attachment, attached_vehicle)
                map_ini_vehicle_flavor_6(attachment, attached_vehicle)
                table.insert(construct_plan.children, attachment)
            end
        end
    end
end

---
--- INI Mapper Flavor #7
---

local function map_ini_vehicle_flavor_7(attachment, data)
    constructor_lib.default_vehicle_attributes(attachment)
    if data["hash"] ~= nil then attachment.hash = data["hash"] end
    if attachment.model == nil and attachment.hash ~= nil then
        attachment.model = util.reverse_joaat(attachment.hash)
    end
    if attachment.name == nil then attachment.name = attachment.model end

    if data.primaryIndex ~= nil then attachment.vehicle_attributes.paint.primary.vehicle_standard_color = tonumber(data.primaryIndex) end
    if data.isPrimaryColorCostum ~= nil then attachment.vehicle_attributes.paint.primary.is_custom = toboolean(data.isPrimaryColorCostum) end
    if data.primary_r ~= nil then attachment.vehicle_attributes.paint.primary.custom_color.r = tonumber(data.primary_r) end
    if data.primary_g ~= nil then  attachment.vehicle_attributes.paint.primary.custom_color.g = tonumber(data.primary_g) end
    if data.primary_b ~= nil then  attachment.vehicle_attributes.paint.primary.custom_color.b = tonumber(data.primary_b) end
    if data.secondaryIndex ~= nil then attachment.vehicle_attributes.paint.secondary.vehicle_standard_color = tonumber(data.secondaryIndex) end
    if data.isSecondaryColorCostum ~= nil then attachment.vehicle_attributes.paint.secondary.is_custom = toboolean(data.isSecondaryColorCostum) end
    if data.secondary_r ~= nil then attachment.vehicle_attributes.paint.secondary.custom_color.r = tonumber(data.secondary_r) end
    if data.secondary_g ~= nil then  attachment.vehicle_attributes.paint.secondary.custom_color.g = tonumber(data.secondary_g) end
    if data.secondary_b ~= nil then  attachment.vehicle_attributes.paint.secondary.custom_color.b = tonumber(data.secondary_b) end
    if data.pearl ~= nil then attachment.vehicle_attributes.paint.extra_colors.pearlescent = tonumber(data.pearl) end
    if data.wheel ~= nil then attachment.vehicle_attributes.paint.extra_colors.wheel = tonumber(data.wheel) end
    if data.wheelType ~= nil then attachment.vehicle_attributes.wheels.wheel_type = tonumber(data.wheelType) end
    if data.neonLeft ~= nil then attachment.vehicle_attributes.neon.lights.left = tonumber(data.neonLeft) end
    if data.neonRight ~= nil then attachment.vehicle_attributes.neon.lights.right = tonumber(data.neonRight) end
    if data.neonFront ~= nil then attachment.vehicle_attributes.neon.lights.front = tonumber(data.neonFront) end
    if data.neonBack ~= nil then attachment.vehicle_attributes.neon.lights.back = tonumber(data.neonBack) end
    if data.neon_r ~= nil then attachment.vehicle_attributes.neon.color.r = tonumber(data.neon_r) end
    if data.neon_g ~= nil then attachment.vehicle_attributes.neon.color.g = tonumber(data.neon_g) end
    if data.neon_b ~= nil then attachment.vehicle_attributes.neon.color.b = tonumber(data.neon_b) end
    if data.windowTint ~= nil then attachment.vehicle_attributes.options.window_tint = tonumber(data.windowTint) end
    if data.headlightColor ~= nil then attachment.vehicle_attributes.headlights.headlights_color = tonumber(data.headlightColor) end
    if data.hasTireSmoke ~= nil then 
        attachment.vehicle_attributes.wheels.tire_smoke_color.r = tonumber(data.tyressmoke_r)
        attachment.vehicle_attributes.wheels.tire_smoke_color.g = tonumber(data.tyressmoke_g)
        attachment.vehicle_attributes.wheels.tire_smoke_color.b = tonumber(data.tyressmoke_b)
    end
    if data.plateIndex ~= nil then attachment.vehicle_attributes.options.license_plate_type = tonumber(data.plateIndex) end
    if data.plate ~= nil then attachment.vehicle_attributes.options.license_plate_text = data.plate end
    if data.bulletproof ~= nil then attachment.vehicle_attributes.wheels.bulletproof_tires = tonumber(data.bulletproof) end
    if data.hasDriftTires ~= nil then attachment.vehicle_attributes.wheels.drift_tires = toboolean(data.hasDriftTires) end

    --Unmapped:[
    -- data.xenon
    -- data.wheel_r data.wheel_g data.wheel_b
    -- data.model_r data.model_g data.model_b
    -- data.seat_r data.seat_g data.seat_b
    -- data.bypass
    -- data.spawnInVehicle
end

local function map_ini_vehicle_mods_flavor_7(attachment, data)
    for index = 0, 49 do
        if not (index >= 17 and index <= 22) then
            attachment.vehicle_attributes.mods["_"..index] = tonumber(data[tostring("mod"..index)])
        end
    end
end

local function map_ini_vehicle_mod_toggles_flavor_7(attachment, data)
    for index = 17, 22 do
        attachment.vehicle_attributes.mods["_"..index] = toboolean(data[tostring("mod"..index)])
    end
end

local function map_ini_vehicle_extras_flavor_7(attachment, data)
    for index = 0, 14 do
        if data[index] ~= nil then
            attachment.vehicle_attributes.extras["_"..index] = toboolean(data["extra"..index])
        end
    end
end

local function map_ini_data_flavor_7(construct_plan, data)
    if data.VEHICLE ~= nil then
        construct_plan.type = "VEHICLE"
        map_ini_vehicle_flavor_7(construct_plan, data.VEHICLE)
        if data.MODS ~= nil then
            map_ini_vehicle_mods_flavor_7(construct_plan, data.MODS)
            map_ini_vehicle_mod_toggles_flavor_7(construct_plan, data.MODS)
        end
        if data.EXTRAS ~= nil then
            map_ini_vehicle_extras_flavor_7(construct_plan, data.EXTRAS)
        end
    end
end

---
--- INI Mapper Flavor #8
---

local function map_ini_attachment_flavor_8(attachment, data)
    if data["Model"] ~= nil then attachment.hash = data["Model"] end
    if attachment.model == nil and attachment.hash ~= nil then
        attachment.model = util.reverse_joaat(attachment.hash)
    end
    if attachment.name == nil then attachment.name = attachment.model end
    constructor_lib.default_attachment_attributes(attachment)
    attachment.type = "OBJECT"
    attachment.options.is_attached = false
    attachment.always_spawn_at_position = true

    --if data["offx"] ~= nil then attachment.offset.x = tonumber(data["offx"]) end
    --if data["offy"] ~= nil then attachment.offset.y = tonumber(data["offy"]) end
    --if data["offz"] ~= nil then attachment.offset.z = tonumber(data["offz"]) end

    if data["x"] ~= nil then attachment.position.x = tonumber(data["x"]) end
    if data["y"] ~= nil then attachment.position.y = tonumber(data["y"]) end
    if data["z"] ~= nil then attachment.position.z = tonumber(data["z"]) end

    if data["qx"] ~= nil then
        attachment.quaternion = {
            x = tonumber(data["qx"]),
            y = tonumber(data["qy"]),
            z = tonumber(data["qz"]),
            w = tonumber(data["qw"]),
        }
    end

    if data["Dynamic"] ~= nil then attachment.options.is_dynamic = toboolean(data["Dynamic"]) end

    -- Unused
    -- h (height?)
    -- offz (offset z?)

end

local function map_ini_data_flavor_8(construct_plan, data)
    map_ini_attachment_flavor_8(construct_plan, data["1"])
    if data.Player ~= nil then
        -- TODO: Handle teleport coords
    end
    for attachment_index = 2, MAX_NUM_ATTACHMENTS do
        local attached_object = data[tostring(attachment_index)]
        if attached_object ~= nil and attached_object.Model then
            local attachment = {}
            map_ini_attachment_flavor_8(attachment, attached_object)
            table.insert(construct_plan.children, attachment)
        end
    end
end

---
--- INI Flavor Finder
---

-- Copied from LanceSpooner. Thank you lance!
-- determine type of ini file
-- type 1 has no spaces in it (i.e Airship.xml).
-- type 2 does and has  lowercase shit (420 Hydra.ini). it's also extremely stupid
-- type 3 is extremely similar to type 1, but has values like PrimaryPaintT (BayWatch Blazer.xml)
-- type 4 has an "AllObjects", "AllPeds", "AllVehicles" section in the ini (4tire_bike.ini)
-- type 5 has AllObjects and AllVehicles (Boat-fsx.ini) (seems like theres an iniparser glitch in this one)
-- type 6 is like type 2, but some keys are different, namely the numbers for attachments are called "Attached Object x" (Tankamid.ini)
-- type 7 is 2Take1's format
-- type 8 has quaternions
local function get_ini_flavor(data)
    if data.Vehicle ~= nil and data.Vehicle.Model ~= nil and data.Vehicle.PrimaryPaintT == nil and (data.AllVehicles == nil or data.AllVehicles.Count == nil) then
        return 1
    elseif data.Vehicle ~= nil and data.Vehicle.model ~= nil and data['Attached Object 1'] == nil and (data['0'] ~= nil or data['1'] ~= nil) then
        return 2
    elseif data.Vehicle ~= nil and data.Vehicle.model == nil and data.Vehicle.PrimaryPaintT ~= nil then
        return 3
    elseif data.AllObjects ~= nil and data.AllObjects.Count ~= nil and data.AllVehicles.Count ~= nil and data.AllPeds.Count ~= nil then
        return 4
        -- no 5?
    elseif data.Vehicle ~= nil and data.Vehicle.model ~= nil and data['Attached Object 1'] ~= nil and data['Attached Object 1'].model ~= nil then
        return 6
    elseif data.VEHICLE ~= nil and data.VEHICLE.hash ~= nil and data.VEHICLE.isPrimaryColorCostum ~= nil then
        return 7
    elseif data.Player ~= nil and data["1"] ~= nil and data["1"].qx ~= nil then
        return 8
    end
end

local function map_ini_data(construct_plan, data)
    if construct_plan.temp.ini_flavor == 1 then
        return map_ini_data_flavor_1(construct_plan, data)
    elseif construct_plan.temp.ini_flavor == 2 then
        return map_ini_data_flavor_2(construct_plan, data)
    elseif construct_plan.temp.ini_flavor == 3 then
        return map_ini_data_flavor_3(construct_plan, data)
    elseif construct_plan.temp.ini_flavor == 4 then
        return map_ini_data_flavor_4(construct_plan, data)
        --elseif construct_plan.temp.ini_flavor == 5 then
        --    return map_ini_data_flavor_5(construct_plan, data)
    elseif construct_plan.temp.ini_flavor == 6 then
        return map_ini_data_flavor_6(construct_plan, data)
    elseif construct_plan.temp.ini_flavor == 7 then
        return map_ini_data_flavor_7(construct_plan, data)
    elseif construct_plan.temp.ini_flavor == 8 then
        return map_ini_data_flavor_8(construct_plan, data)
    end
end

---
--- Root INI Parser
---

convertor.convert_ini_to_construct_plan = function(construct_plan_file)
    local construct_plan = constructor_lib.table_copy(constructor_lib.construct_base)

    local status_ini_parse, data = pcall(iniparser.parse, construct_plan_file.filepath, "")
    if not status_ini_parse then
        util.toast("Error parsing INI file. "..construct_plan_file.filepath.." "..data)
        return
    end

    setmetatable(data, nil)

    --debug_log("Parsed INI: "..inspect(data))

    construct_plan.temp.ini_flavor = get_ini_flavor(data)
    if not construct_plan.temp.ini_flavor then
        util.toast("Unsupported INI Flavor. If you think this file should be supported, please post it in the #broken-constructs channel on discord.", TOAST_ALL)
        return
    end
    construct_plan.temp.source_file_type = "INI Flavor "..construct_plan.temp.ini_flavor
    map_ini_data(construct_plan, data)
    convertor.rearrange_by_initial_attachment(construct_plan)

    --debug_log("Loaded INI construct plan: "..inspect(construct_plan))

    if construct_plan.hash == nil and construct_plan.model == nil and construct_plan.is_player ~= true then
        util.toast("Failed to load INI construct. Missing hash or model.", TOAST_ALL)
        util.log("Attempted construct plan: "..inspect(construct_plan))
        return
    end

    return construct_plan
end

---
--- Return
---

return convertor
