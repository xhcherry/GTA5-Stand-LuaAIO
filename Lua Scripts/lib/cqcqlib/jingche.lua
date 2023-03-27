require "lib.natives-1660775568"
local SCRIPT_VERSION = "2.4"
C_VEHICLE={
    ["_GET_VEHICLE_XENON_LIGHTS_COLOR"]=--[[int]] function(--[[Vehicle (int)]] vehicle)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.end_call("3DFF319A831E0CDB");return native_invoker.get_return_value_int();end,
}

local function show_busyspinner(text)
    HUD.BEGIN_TEXT_COMMAND_BUSYSPINNER_ON("STRING")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(text)
    HUD.END_TEXT_COMMAND_BUSYSPINNER_ON(2)
end
local function get_player_vehicle_in_control(pid, opts)
    local my_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()) -- Needed to turn off spectating while getting control
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

    -- Calculate how far away from target
    local pos1 = ENTITY.GET_ENTITY_COORDS(target_ped)
    local pos2 = ENTITY.GET_ENTITY_COORDS(my_ped)
    local dist = C_SYSTEM.VDIST2(pos1.x, pos1.y, 0, pos2.x, pos2.y, 0)

    local was_spectating = NETWORK.NETWORK_IS_IN_SPECTATOR_MODE() -- Needed to toggle it back on if currently spectating
    -- If they out of range (value may need tweaking), auto spectate.
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(target_ped, true)
    if opts and opts.near_only and vehicle == 0 then
        return 0
    end
    if vehicle == 0 and target_ped ~= my_ped and dist > 340000 and not was_spectating then
        util.toast("玩家距离太远，自动观看最多 3 秒.")
        show_busyspinner("玩家距离太远，自动观看最多 3 秒.")
        NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, target_ped)
        -- To prevent a hard 3s loop, we keep waiting upto 3s or until vehicle is acquired
        local loop = (opts and opts.loops ~= nil) and opts.loops or 30 -- 3000 / 100
        while vehicle == 0 and loop > 0 do
            util.yield(100)
            vehicle = PED.GET_VEHICLE_PED_IS_IN(target_ped, true)
            loop = loop - 1
        end
        HUD.BUSYSPINNER_OFF()
    end

    if vehicle > 0 then
        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            return vehicle
        end
        -- Loop until we get control
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(vehicle)
        local has_control_ent = false
        local loops = 15
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)

        -- Attempts 15 times, with 8ms per attempt
        while not has_control_ent do
            has_control_ent = NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
            loops = loops - 1
            -- wait for control
            util.yield(15)
            if loops <= 0 then
                break
            end
        end
    end
    if not was_spectating then
        NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, target_ped)
    end
    return vehicle
end

local saveData = {
    Horn = nil,
    Headlights_Color = nil,
    Lights = {
        Neon = {
            Color = {
                r = 0,
                g = 0,
                b = 0,
            },
            Left = false,
            Right = false,
            Front = false,
            Back = false
        }
    },
    Livery = {
        Style = nil
    }
}

local function save_headlights(vehicle)
    saveData.Headlights_Color = C_VEHICLE._GET_VEHICLE_XENON_LIGHTS_COLOR(vehicle)
    saveData.Headlights_Type = VEHICLE.IS_TOGGLE_MOD_ON(vehicle, 22)
end

local function set_headlights(vehicle)
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 22, true)
end

local function restore_headlights(vehicle)
    VEHICLE._SET_VEHICLE_XENON_LIGHTS_COLOR(vehicle, saveData.Headlights_Color)
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, saveData.Headlights_Type or false)
end

local function save_neon(vehicle)
    local Color = {
        r = memory.alloc(4),
        g = memory.alloc(4),
        b = memory.alloc(4),
    }
    VEHICLE._GET_VEHICLE_NEON_LIGHTS_COLOUR(vehicle, Color.r, Color.g, Color.b)
    saveData.Lights.Neon = {
        Color = {
            r = memory.read_int(Color.r),
            g = memory.read_int(Color.g),
            b = memory.read_int(Color.b),
        },
        Left = VEHICLE._IS_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 0),
        Right = VEHICLE._IS_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 1),
        Front = VEHICLE._IS_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 2),
        Back = VEHICLE._IS_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 3),
    }
end

local function set_neon(vehicle)
    VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 0, true)
    VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 1, true)
    VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 2, true)
    VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 3, true)
end

local function restore_neon(vehicle)
    VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 0, saveData.Lights.Neon.Left or false)
    VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 1, saveData.Lights.Neon.Right or false)
    VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 2, saveData.Lights.Neon.Front or false)
    VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 3, saveData.Lights.Neon.Back or false)
    VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(vehicle, saveData.Lights.Neon.Color.r, saveData.Lights.Neon.Color.g, saveData.Lights.Neon.Color.b)
end

local function save_paint(vehicle)
    local Primary = {
        Custom = VEHICLE.GET_IS_VEHICLE_PRIMARY_COLOUR_CUSTOM(vehicle),
    }
    local Secondary = {
        Custom = VEHICLE.GET_IS_VEHICLE_SECONDARY_COLOUR_CUSTOM(vehicle),
    }
    local Color = {
        r = memory.alloc(4),
        g = memory.alloc(4),
        b = memory.alloc(4),
    }

    if Primary.Custom then
        VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, Color.r, Color.g, Color.b)
        Primary["Custom Color"] = {
            r = memory.read_int(Color.r),
            b = memory.read_int(Color.g),
            g = memory.read_int(Color.b)
        }
    else
        VEHICLE.GET_VEHICLE_MOD_COLOR_1(vehicle, Color.r, Color.b, Color.g)
        Primary["Paint Type"] = memory.read_int(Color.r)
        Primary["Color"] = memory.read_int(Color.g)
        Primary["Pearlescent Color"] = memory.read_int(Color.b)
    end
    if Secondary.Custom then
        VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, Color.r, Color.g, Color.b)
        Secondary["Custom Color"] = {
            r = memory.read_int(Color.r),
            b = memory.read_int(Color.g),
            g = memory.read_int(Color.b)
        }
    else
        VEHICLE.GET_VEHICLE_MOD_COLOR_2(vehicle, Color.r, Color.b)
        Secondary["Paint Type"] = memory.read_int(Color.r)
        Secondary["Color"] = memory.read_int(Color.g)
    end
    VEHICLE.GET_VEHICLE_COLOR(vehicle, Color.r, Color.g, Color.b)
    local Vehicle = {
        r = memory.read_int(Color.r),
        g = memory.read_int(Color.g),
        b = memory.read_int(Color.b),
    }
    VEHICLE.GET_VEHICLE_EXTRA_COLOURS(vehicle, Color.r, Color.g)
    local ColorExtras = {
        pearlescent = memory.read_int(Color.r),
        wheel = memory.read_int(Color.g),
    }
    VEHICLE.GET_VEHICLE_COLOURS(vehicle, Color.r, Color.g)
    Vehicle["Primary"] = memory.read_int(Color.r)
    Vehicle["Secondary"] = memory.read_int(Color.g)
    memory.free(Color.r)
    memory.free(Color.g)
    memory.free(Color.b)
    saveData.Colors = {
        Primary = Primary,
        Secondary = Secondary,
        ["Color Combo"] = VEHICLE.GET_VEHICLE_COLOUR_COMBINATION(vehicle),
        ["Paint Fade"] = VEHICLE.GET_VEHICLE_ENVEFF_SCALE(vehicle),
        Vehicle = Vehicle,
        Extras = ColorExtras
    }
    saveData.Livery.style = VEHICLE.GET_VEHICLE_MOD(vehicle, 48)
end

local function set_paint(vehicle)
    -- Paint matte black
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, 0, 0, 0)
    VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, 3, 0, 0)
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, 0, 0, 0)
    VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, 3, 0, 0)

    -- Clear livery
    VEHICLE.SET_VEHICLE_MOD(vehicle, 48, -1)
end

local function restore_paint(vehicle)
    VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
    VEHICLE.SET_VEHICLE_COLOUR_COMBINATION(vehicle, saveData.Colors["Color Combo"] or -1)
    if saveData.Colors.Extra then
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, saveData.Colors.Extras.pearlescent, saveData.Colors.Extras.wheel)
    end
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, saveData.Colors.Vehicle.r, saveData.Colors.Vehicle.g, saveData.Colors.Vehicle.b)
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, saveData.Colors.Vehicle.r, saveData.Colors.Vehicle.g, saveData.Colors.Vehicle.b)
    VEHICLE.SET_VEHICLE_COLOURS(vehicle, saveData.Colors.Vehicle.Primary or 0, saveData.Colors.Vehicle.Secondary or 0)
    if saveData.Colors.Primary.Custom and saveData.Colors.Primary["Custom Color"] then
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, saveData.Colors.Primary["Custom Color"].r, saveData.Colors.Primary["Custom Color"].b, saveData.Colors.Primary["Custom Color"].g)
    else
        VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, saveData.Colors.Primary["Paint Type"], saveData.Colors.Primary.Color, saveData.Colors.Primary["Pearlescent Color"])
    end
    if saveData.Colors.Secondary.Custom and saveData.Colors.Secondary["Custom Color"] then
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, saveData.Colors.Secondary["Custom Color"].r,  saveData.Colors.Secondary["Custom Color"].b, saveData.Colors.Secondary["Custom Color"].g)
    else
        VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, saveData.Colors.Secondary["Paint Type"], saveData.Colors.Secondary.Color)
    end
    VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, saveData["Colors"]["Paint Fade"] or 0)

    VEHICLE.SET_VEHICLE_MOD(vehicle, 48, saveData.Livery.style or -1)
end

local function save_horn(vehicle)
    saveData.Horn = VEHICLE.GET_VEHICLE_MOD(vehicle, 14)
    VEHICLE.SET_VEHICLE_SIREN(vehicle, true)
end

local function set_horn(vehicle)
    -- Police Horn
    VEHICLE.SET_VEHICLE_MOD(vehicle, 14, 1)
end

local function restore_horn(vehicle)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 14, saveData.Horn)
    VEHICLE.SET_VEHICLE_SIREN(vehicle, false)
end

local attachments = {}
local attached_invis_police_sirens = {}

local config = {
    plate_text = "FIB",
    siren_attachment = {
        name="Police Cruiser",
        model="policeb",
    }
}

-- Good props for cop lights
-- prop_air_lights_02a blue
-- prop_air_lights_02b red
-- h4_prop_battle_lights_floorblue
-- h4_prop_battle_lights_floorred
-- prop_wall_light_10a
-- prop_wall_light_10b
-- prop_wall_light_10c
-- hei_prop_wall_light_10a_cr

local available_attachments = {
    {
        name="灯光",
        objects={
            {
                name = "红色旋转灯",
                model = "hei_prop_wall_light_10a_cr",
                offset = { x = 0, y = 0, z = 1 },
                rotation = { x = 180, y = 0, z = 0 },
                is_light_disabled = true,
                children = {
                    {
                        model = "prop_wall_light_10a",
                        offset = { x = 0, y = 0.01, z = 0 },
                        is_light_disabled = false,
                        bone_index = 1,
                    },
                },
            },
            {
                name = "蓝色旋转灯",
                model = "hei_prop_wall_light_10a_cr",
                offset = { x = 0, y = 0, z = 1 },
                rotation = { x = 180, y = 0, z = 0 },
                is_light_disabled = true,
                children = {
                    {
                        model = "prop_wall_light_10b",
                        offset = { x = 0, y = 0.01, z = 0 },
                        is_light_disabled = false,
                        bone_index = 1,
                    },
                },
            },
            {
                name = "黄色旋转灯",
                model = "hei_prop_wall_light_10a_cr",
                offset = { x = 0, y = 0, z = 1 },
                rotation = { x = 180, y = 0, z = 0 },
                is_light_disabled = true,
                children = {
                    {
                        model = "prop_wall_light_10c",
                        offset = { x = 0, y = 0.01, z = 0 },
                        is_light_disabled = false,
                        bone_index = 1,
                    },
                },
            },

            {
                name = "一对旋转灯",
                model = "hei_prop_wall_light_10a_cr",
                offset = { x = 0.3, y = 0, z = 1 },
                rotation = { x = 180, y = 0, z = 0 },
                is_light_disabled = true,
                children = {
                    {
                        model = "prop_wall_light_10b",
                        offset = { x = 0, y = 0.01, z = 0 },
                        is_light_disabled = false,
                        bone_index = 1,
                    },
                },
                reflection = {
                    model = "hei_prop_wall_light_10a_cr",
                    reflection_axis = { x = true, y = false, z = false },
                    is_light_disabled = true,
                    children = {
                        {
                            model = "prop_wall_light_10a",
                            offset = { x = 0, y = 0.01, z = 0 },
                            rotation = { x = 0, y = 0, z = 180 },
                            is_light_disabled = false,
                            bone_index = 1,
                        },
                    },
                }
            },

            {
                name = "短旋转红灯",
                model = "hei_prop_wall_alarm_on",
                offset = { x = 0, y = 0, z = 1 },
                rotation = { x = -90, y = 0, z = 0 },
            },

            {
                name = "蓝色嵌入式灯",
                model = "h4_prop_battle_lights_floorblue",
                offset = { x = 0, y = 0, z = 0.75 },
            },
            {
                name = "红色嵌入式灯",
                model = "h4_prop_battle_lights_floorred",
                offset = { x = 0, y = 0, z = 0.75 },
            },
            {
                name = "红蓝嵌入式灯",
                model = "h4_prop_battle_lights_floorred",
                offset = { x = 0.3, y = 0, z = 1 },
                reflection = {
                    model = "h4_prop_battle_lights_floorblue",
                    reflection_axis = { x = true, y = false, z = false },
                }
            },
            {
                name = "红蓝嵌入式灯",
                model = "h4_prop_battle_lights_floorblue",
                offset = { x = 0.3, y = 0, z = 1 },
                reflection = {
                    model = "h4_prop_battle_lights_floorred",
                    reflection_axis = { x = true, y = false, z = false },
                }
            },

            -- Flashing is still kinda wonky for networking
            {
                name="闪烁嵌入式灯",
                model="h4_prop_battle_lights_floorred",
                offset={ x=0.3, y=0, z=1 },
                flash_start_on=false,
                reflection={
                    model="h4_prop_battle_lights_floorblue",
                    reflection_axis={ x=true, y=false, z=false },
                    flash_start_on=true,
                }
            },
            {
                name="交替短旋转灯",
                model="h4_prop_battle_lights_floorred",
                offset={ x=0.3, y=0, z=1 },
                flash_start_on=true,
                flash_model="h4_prop_battle_lights_floorblue",
                reflection={
                    model="h4_prop_battle_lights_floorred",
                    reflection_axis={ x=true, y=false, z=false },
                    flash_start_on=false,
                    flash_model="h4_prop_battle_lights_floorblue",
                }
            }
        },
    },
    {
        name="道具",
        objects = {
            {
                name = "防暴盾牌",
                model = "prop_riot_shield",
                offset = { x = 0, y = 0, z = 0 },
                rotation = { x = 180, y = 180, z = 0 },
            },
            {
                name = "防弹盾牌",
                model = "prop_ballistic_shield",
                offset = { x = 0, y = 0, z = 0 },
                rotation = { x = 180, y = 180, z = 0 },
            },
            {
                name = "小机枪",
                model = "prop_minigun_01",
                offset = { x = 0, y = 0, z = 0 },
                rotation = { x = 0, y = 0, z = 90 },
            },
        },
    },
    {
        name="载具",
        objects={
            {
                name = "警用巡逻车",
                type = "vehicle",
                model = "police",
            },
            {
                name = "警车",
                type = "vehicle",
                model = "police2",
            },
            {
                name = "警车2",
                type = "vehicle",
                model = "police3",
            },
            {
                name = "警车3",
                type = "vehicle",
                model = "policet",
            },
            {
                name = "警用摩托车",
                type = "vehicle",
                model = "policeb",
            },
            {
                name = "FIB巡逻车",
                type = "vehicle",
                model = "fbi",
            },
            {
                name = "FIB SUV",
                type = "vehicle",
                model = "fbi2",
            },
            {
                name = "警长巡逻车",
                type = "vehicle",
                model = "sheriff",
            },
            {
                name = "警长SUV",
                type = "vehicle",
                model = "sheriff2",
            },
            {
                name = "警车4",
                type = "vehicle",
                model = "police3",
            },
            {
                name = "雪地警车1",
                type = "vehicle",
                model = "policeold1",
            },
            {
                name = "雪地警车2",
                type = "vehicle",
                model = "policeold2",
            },
            {
                name = "公园巡逻员",
                type = "vehicle",
                model = "pranger",
            },
            {
                name = "防暴车",
                type = "vehicle",
                model = "rior",
            },
            {
                name = "防暴车（RCV）",
                type = "vehicle",
                model = "riot2",
            },
        },
    },
}

local function load_hash(hash)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        util.yield()
    end
end

local function attach_entity_to_entity(args)
    if args.offset == nil or args.rotation == nil then
        util.toast("错误：未设置位置或旋转")
        util.log("[attach_entity_to_entity] 错误：未设置位置或旋转. " .. debug.traceback())
        return
    end
    if args.parent == args.handle then
        ENTITY.SET_ENTITY_ROTATION(args.handle, args.rotation.x or 0, args.rotation.y or 0, args.rotation.z or 0)
    else
        ENTITY.ATTACH_ENTITY_TO_ENTITY(
            args.handle, args.parent or args.root, args.bone_index or 0,
            args.offset.x or 0, args.offset.y or 0, args.offset.z or 0,
            args.rotation.x or 0, args.rotation.y or 0, args.rotation.z or 0,
            false, true, false, false, 2, true
        )
    end
end

local function attach(args)
    local hash = util.joaat(args.model)
    if not STREAMING.IS_MODEL_VALID(hash) or (args.type ~= "vehicle" and STREAMING.IS_MODEL_A_VEHICLE(hash)) then
        util.toast("附加错误：模型无效")
        return
    end
    load_hash(hash)

    if args.offset == nil then
        args.offset = {x=0, y=0, z=0}
    end
    if args.rotation == nil then
        args.rotation = {x=0, y=0, z=0}
    end

    ENTITY.FREEZE_ENTITY_POSITION(args.root, true)
    if args.type == "vehicle" then
        local heading = ENTITY.GET_ENTITY_HEADING(args.root)
        args.handle = entities.create_vehicle(hash, args.offset, heading)
    else
        local pos = ENTITY.GET_ENTITY_COORDS(args.root)
        args.handle = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, pos.x, pos.y, pos.z, true, true, false)
        --args.handle = entities.create_object(hash, ENTITY.GET_ENTITY_COORDS(args.root))
    end

    if args.is_visible ~= nil then
        ENTITY.SET_ENTITY_VISIBLE(args.handle, args.is_visible, 0)
    end
    if args.flash_start_on ~= nil then
        ENTITY.SET_ENTITY_VISIBLE(args.handle, args.flash_start_on, 0)
    end

    ENTITY.SET_ENTITY_INVINCIBLE(args.handle, false)
    ENTITY.SET_ENTITY_HAS_GRAVITY(args.handle, false)

    attach_entity_to_entity(args)

    ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(args.root, args.handle)
    for _, attachment in pairs(attachments) do
        ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(args.handle, attachment.handle)
    end
    table.insert(attachments, args)

    ENTITY.FREEZE_ENTITY_POSITION(args.root, false)

    return args
end

local function get_reflection_with_offsets(attachment)
    --- This function isn't quite right, it breaks with certain root rotations, but close enough for now
    local reflection = attachment.reflection
    reflection.parent = attachment.handle
    reflection.offset = {x=0, y=0, z=0}
    reflection.rotation = {x=0, y=0, z=0}
    if reflection.reflection_axis.x then
        reflection.offset.x = attachment.offset.x * -2
    end
    if reflection.reflection_axis.y then
        reflection.offset.y = attachment.offset.y * -2
    end
    if reflection.reflection_axis.z then
        reflection.offset.z = attachment.offset.z * -2
    end
    return reflection
end

local function move_attachment(attachment)
    if attachment.reflection then
        local reflection = get_reflection_with_offsets(attachment)
        attach_entity_to_entity(reflection)
    end
    attach_entity_to_entity(attachment)
end

local function detach(attachment)
    if attachment.spawned_children then
        for _, child in pairs(attachment.spawned_children) do
            detach(child)
        end
    end
    for i, attachment2 in pairs(attachments) do
        if attachment2.handle == attachment.handle then
            table.remove(attachments, i)
        end
    end
    entities.delete_by_handle(attachment.handle)
end

function table.table_copy(obj)
    if type(obj) ~= 'table' then return obj end
    local res = setmetatable({}, getmetatable(obj))
    for k, v in pairs(obj) do res[table.table_copy(k)] = table.table_copy(v) end
    return res
end

function table.is_equal( a, b )
    return table.concat(a) == table.concat(b)
end

local attachment_counter
local attachment_name
local function attach_available_attachment_to_vehicle(root_vehicle, available_attachment)
    attachment_counter = attachment_counter + 1
    local attachment_args = table.table_copy(available_attachment)
    attachment_args.root = root_vehicle
    if attachment_name == nil then
        attachment_name = available_attachment.name
    end
    if attachment_counter == 1 then
        attachment_args.name = attachment_name .. " (Base)"
    else
        attachment_args.name = attachment_name .. " (Child #" .. attachment_counter-1 .. ")"
    end
    local attachment = attach(attachment_args)
    attachment_args.spawned_children = {}
    if available_attachment.children then
        for _, child in pairs(available_attachment.children) do
            child.parent = attachment.handle
            local spawned = attach_available_attachment_to_vehicle(root_vehicle, child)
            table.insert(attachment_args.spawned_children, spawned)
        end
    end
    if attachment.flash_model then
        local flash_version = {
            model=attachment.flash_model,
            flash_start_on=(not attachment.flash_start_on),
            parent=attachment.handle
        }
        local spawned = attach_available_attachment_to_vehicle(root_vehicle, flash_version)
        table.insert(attachment_args.spawned_children, spawned)
    end
    if attachment_args.reflection then
        local reflection = get_reflection_with_offsets(attachment_args)
        local spawned = attach_available_attachment_to_vehicle(root_vehicle, reflection)
        table.insert(attachment_args.spawned_children, spawned)
    end
    return attachment
end

local function attach_invis_police_sirens(vehicle)
    local attachment = attach{
        root=vehicle,
        parent=vehicle,
        name=config.siren_attachment.name,
        attachments=attachments,
        model=config.siren_attachment.model,
        type="vehicle",
        is_visible=false
    }
    table.insert(attached_invis_police_sirens, attachment.handle)

    local ped_hash = util.joaat("s_m_m_pilot_01")
    load_hash(ped_hash)
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(attachment.handle, 0, 0, 0)
    local pilot = entities.create_ped(1, ped_hash, pos, 0.0)
    PED.SET_PED_INTO_VEHICLE(pilot, attachment.handle, -1)
    ENTITY.SET_ENTITY_VISIBLE(pilot, false, 0)
    table.insert(attached_invis_police_sirens, pilot)
end

local function remove_invis_police_sirens(vehicle)
    for _, handle in pairs(attached_invis_police_sirens) do
        entities.delete_by_handle(handle)
    end
    attached_invis_police_sirens = {}
end

local function refresh_invis_police_sirens(vehicle)
    remove_invis_police_sirens(vehicle)
    attach_invis_police_sirens(vehicle)
end

local function remove_all_attachments(vehicle)
    for _, attachment in pairs(attachments) do
        if attachment.spawned_children then
            for _, child in pairs(attachment.spawned_children) do
                entities.delete_by_handle(child.handle)
            end
        end
        entities.delete_by_handle(attachment.handle)
    end
    attachments = {}
end

local function activate_lights(vehicle)
    VEHICLE.SET_VEHICLE_SIREN(vehicle, true)
    VEHICLE.SET_VEHICLE_HAS_MUTED_SIRENS(vehicle, true)
    ENTITY.SET_ENTITY_LIGHTS(vehicle, false)
    AUDIO._TRIGGER_SIREN(vehicle, true)
    AUDIO._SET_SIREN_KEEP_ON(vehicle, true)
    for _, attachment in pairs(attachments) do
        if not attachment.is_light_disabled then
            VEHICLE.SET_VEHICLE_SIREN(attachment.handle, true)
            ENTITY.SET_ENTITY_LIGHTS(attachment.handle, false)
            AUDIO._TRIGGER_SIREN(attachment.handle, true)
            AUDIO._SET_SIREN_KEEP_ON(attachment.handle, true)
        end
    end
end

local function deactivate_lights(vehicle)
    ENTITY.SET_ENTITY_LIGHTS(vehicle, true)
    AUDIO._SET_SIREN_KEEP_ON(vehicle, false)
    VEHICLE.SET_VEHICLE_SIREN(vehicle, false)
    for _, attachment in pairs(attachments) do
        ENTITY.SET_ENTITY_LIGHTS(attachment.handle, true)
        VEHICLE.SET_VEHICLE_SIREN(attachment.handle, false)
    end
end

local function activate_vehicle_sirens(vehicle)
    --AUDIO.SET_SIREN_WITH_NO_DRIVER(vehicle, true)
    VEHICLE.SET_VEHICLE_HAS_MUTED_SIRENS(vehicle, false)
    VEHICLE.SET_VEHICLE_SIREN(vehicle, true)
    AUDIO._TRIGGER_SIREN(vehicle, true)
    AUDIO._SET_SIREN_KEEP_ON(vehicle, true)
end

local function deactivate_vehicle_sirens(vehicle)
    --AUDIO._SET_SIREN_KEEP_ON(vehicle, false)
    VEHICLE.SET_VEHICLE_HAS_MUTED_SIRENS(vehicle, true)
    --VEHICLE.SET_VEHICLE_SIREN(vehicle, false)
end

local function activate_sirens(vehicle)
    activate_vehicle_sirens(vehicle)
    for _, attachment in pairs(attachments) do
        if ENTITY.IS_ENTITY_A_VEHICLE(attachment.handle) then
            activate_vehicle_sirens(attachment.handle)
        end
    end
end

local function deactivate_sirens(vehicle)
    deactivate_vehicle_sirens(vehicle)
    for _, attachment in pairs(attachments) do
        if ENTITY.IS_ENTITY_A_VEHICLE(attachment.handle) then
            deactivate_vehicle_sirens(attachment.handle)
        end
    end
end

local function save_plate(vehicle)
    saveData["License Plate"] = {
        Text = VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT(vehicle),
        Type = VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle)
    }
end

local function set_plate(vehicle)
    -- Set Exempt plate
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, true, true)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, 4)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, config.plate_text)
end

local function restore_plate(vehicle)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, true, true)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, saveData["License Plate"].Text)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, saveData["License Plate"].Type)
end

local policified_vehicle
local policify_tick_counter
local flash_delay = 50
local override_paint = true
local override_headlights = true
local override_neon = true
local override_plate = true
local override_horn = true
local attach_invis_police_siren = true
local is_active_sirens = false
local is_active_lights = false
local siren_setting = 1

local function refresh_siren_light_status(vehicle)
    if is_active_lights then
        activate_lights(vehicle)
    else
        deactivate_lights(vehicle)
    end
    if is_active_sirens then
        activate_sirens(vehicle)
    else
        deactivate_sirens(vehicle)
    end
end

local function refresh_plate_text(vehicle)
    if override_plate then
        set_plate(vehicle)
    else
        restore_plate(vehicle)
    end
end

local function add_overrides_to_vehicle(vehicle)
    if override_headlights then
        save_headlights(vehicle)
        set_headlights(vehicle)
    end

    if override_neon then
        save_neon(vehicle)
        set_neon(vehicle)
    end

    if override_horn then
        save_horn(vehicle)
        set_horn(vehicle)
    end

    if override_paint then
        save_paint(vehicle)
        set_paint(vehicle)
    end

    if override_plate then
        save_plate(vehicle)
        set_plate(vehicle)
    end

    if attach_invis_police_siren then
        attach_invis_police_sirens(vehicle)
    end

    --AUDIO.USE_SIREN_AS_HORN(vehicle, true)
end

local function remove_overrides_from_vehicle(vehicle)
    if override_headlights then
        restore_headlights(vehicle)
    end
    if override_neon then
        restore_neon(vehicle)
    end
    if override_horn then
        restore_horn(vehicle)
    end
    if override_paint then
        restore_paint(vehicle)
    end
    if override_plate then
        restore_plate(vehicle)
    end
    if attach_invis_police_siren then
        remove_invis_police_sirens(vehicle)
    end
    remove_all_attachments(vehicle)
end

local function policify_tick_ying()
    if is_active_lights then
        if override_headlights then
            VEHICLE._SET_VEHICLE_XENON_LIGHTS_COLOR(policified_vehicle, 8)
        end
        if override_neon then
            VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(policified_vehicle, 0, 0, 255)
        end
    end
    for _, attachment in pairs(attachments) do
        if attachment.flash_start_on ~= nil then
            ENTITY.SET_ENTITY_VISIBLE(attachment.handle, (not attachment.flash_start_on), 0)
        end
    end
end

local function policify_tick_yang()
    if is_active_lights then
        if override_headlights then
            VEHICLE._SET_VEHICLE_XENON_LIGHTS_COLOR(policified_vehicle, 1)
        end
        if override_neon then
            VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(policified_vehicle, 255, 0, 0)
        end
    end
    for _, attachment in pairs(attachments) do
        if attachment.flash_start_on ~= nil then
            ENTITY.SET_ENTITY_VISIBLE(attachment.handle, attachment.flash_start_on, 0)
        end
    end
end

local policify_ticker = function()
    if policified_vehicle == nil then
        util.toast("无效的警用车辆")
    end
    if policify_tick_counter % flash_delay == 0 then
        if policify_tick_counter % (flash_delay * 2) == 0 then
            policify_tick_ying()
        else
            policify_tick_yang()
        end
    end
    policify_tick_counter = policify_tick_counter + 1
end

local function policify_vehicle(vehicle)
    policified_vehicle = vehicle
    add_overrides_to_vehicle(vehicle)
    refresh_siren_light_status(vehicle)

    policify_tick_counter = 0
    util.create_tick_handler(function()
        if policify_tick_counter ~= nil then
            policify_ticker()
        else
            return false
        end
    end)
end

local function depolicify_vehicle()
    policify_tick_counter = nil
    remove_overrides_from_vehicle(policified_vehicle)
end

local function policify_current_vehicle()
    local vehicle = get_player_vehicle_in_control(players.user())
    if vehicle then
        policify_vehicle(vehicle)
    else
        util.toast("错误：无法加载当前车辆")
    end
end

local edit_attachments_menu

local function rebuild_edit_attachments_menu()
    local new_attachment_menus = {}
    for _, attachment in pairs(attachments) do
        if not attachment.is_added_to_edit_menu then
            local edit_menu = menu.list(edit_attachments_menu, attachment.name or "unknow")
            menu.divider(edit_menu, "位置")
            local focus = menu.slider_float(edit_menu, "X: 左 / 右", {}, "", -500000, 500000, math.floor(attachment.offset.x * 100), 1, function(value)
                attachment.offset.x = value / 100
                move_attachment(attachment)
            end)
            menu.slider_float(edit_menu, "Y: 前 / 后", {}, "", -500000, 500000, math.floor(attachment.offset.y * -100), 1, function(value)
                attachment.offset.y = value / -100
                move_attachment(attachment)
            end)
            menu.slider_float(edit_menu, "Z: 上 / 下", {}, "", -500000, 500000, math.floor(attachment.offset.z * -100), 1, function(value)
                attachment.offset.z = value / -100
                move_attachment(attachment)
            end)
            menu.divider(edit_menu, "旋转")
            menu.slider(edit_menu, "X: 向前", {}, "", -175, 180, math.floor(attachment.rotation.x), 5, function(value)
                attachment.rotation.x = value
                move_attachment(attachment)
            end)
            menu.slider(edit_menu, "Y: 左右", {}, "", -175, 180, math.floor(attachment.rotation.y), 5, function(value)
                attachment.rotation.y = value
                move_attachment(attachment)
            end)
            menu.slider(edit_menu, "Z: 旋转", {}, "", -175, 180, math.floor(attachment.rotation.z), 5, function(value)
                attachment.rotation.z = value
                move_attachment(attachment)
            end)
            menu.divider(edit_menu, "选项")
            --menu.toggle(edit_menu, "Visible", {}, "", function(on)
            --    attachment.is_visible = on
            --    attach_entity_to_entity(attachment)
            --end, attachment.is_visible)
            menu.action(edit_menu, "删除", {}, "", function()
                detach(attachment)
                menu.delete(edit_menu)
                rebuild_edit_attachments_menu()
            end)
            attachment.is_added_to_edit_menu = true
            table.insert(new_attachment_menus, focus)
        end
    end
    return new_attachment_menus[1]
end

---
--- Menu Options
---

menu.toggle(jingche, "警用车辆", {"policify"}, "把当前载具设置成警用车辆", function(on)
    if on then
        policify_current_vehicle()
        rebuild_edit_attachments_menu()
    else
        depolicify_vehicle()
    end
end)

menu.action(jingche, "警笛警告", {"blip"}, "快速的警笛声", function()
    for _, attachment in pairs(attachments) do
        if attachment.type == "vehicle" then
            AUDIO.BLIP_SIREN(attachment.handle)
            return
        end
    end
end)



menu.list_select(jingche, "警笛与灯光", {}, "", {"关", "灯光", "警笛与灯光"}, 1, function(key)
    if key == 1 then
        is_active_lights = false
        is_active_sirens = false
    elseif key == 2 then
        is_active_lights = true
        is_active_sirens = false
    elseif key == 3 then
        is_active_lights = true
        is_active_sirens = true
    end
    if is_active_lights then
        save_headlights(policified_vehicle)
        save_neon(policified_vehicle)
    else
        restore_headlights(policified_vehicle)
        restore_neon(policified_vehicle)
    end
    refresh_siren_light_status(policified_vehicle)
end)

menu.action(jingche, "呼叫支援", {}, "呼叫附近单位支援", function(toggle)
    local incident_id = memory.alloc(8)
    MISC.CREATE_INCIDENT_WITH_ENTITY(7, PLAYER.PLAYER_PED_ID(), 3, 3, incident_id)
    AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_PS_2A_01", 0)
end, true)

local attach_additional_lights_menu = menu.list(jingche, "附加附件")
edit_attachments_menu = menu.list(jingche, "编辑附件")

for _, category in pairs(available_attachments) do
    local category_menu = menu.list(attach_additional_lights_menu, category.name)
    for _, available_attachment in pairs(category.objects) do
        menu.action(category_menu, available_attachment.name, {}, "", function()
            attachment_counter = 0
            attachment_name = nil
            attach_available_attachment_to_vehicle(policified_vehicle, available_attachment, attachments)
            refresh_siren_light_status()
            menu.focus(rebuild_edit_attachments_menu())
        end)
    end
end

local options_menu = menu.list(jingche, "选项")

menu.slider(options_menu, "灯光延迟", {"policifydelay"}, "设置过低的值可能无法将颜色与其他玩家联网!", 20, 150, 50, 10, function (value)
    flash_delay = value
end)

menu.toggle(options_menu, "车漆覆盖", {}, "如果启用，将覆盖车辆油漆为哑光黑色", function(toggle)
    if toggle then
        override_paint = true
        if policify_tick_counter ~= nil then
            save_paint(policified_vehicle)
            set_paint(policified_vehicle)
        end
    else
        override_paint = false
        if policify_tick_counter ~= nil then
            restore_paint(policified_vehicle)
        end
    end
end, true)

menu.toggle(options_menu, "覆盖车灯", {}, "如果启用，将覆盖车辆前灯闪烁蓝色和红色", function(toggle)
    if toggle then
        override_headlights = true
        if policify_tick_counter ~= nil then
            save_headlights(policified_vehicle)
            set_headlights(policified_vehicle)
        end
    else
        override_headlights = false
        if policify_tick_counter ~= nil then
            restore_headlights(policified_vehicle)
        end
    end
end, true)

menu.toggle(options_menu, "覆盖霓虹灯", {}, "如果启用，将覆盖车辆霓虹灯闪烁红色和蓝色", function(toggle)
    if toggle then
        override_neon = true
        if policify_tick_counter ~= nil then
            save_neon(policified_vehicle)
            set_neon(policified_vehicle)
        end
    else
        override_neon = false
        if policify_tick_counter ~= nil then
            restore_neon(policified_vehicle)
        end
    end
end, true)

menu.toggle(options_menu, "覆盖喇叭", {}, "如果启用，将覆盖车辆喇叭到警笛", function(toggle)
    if toggle then
        override_horn = true
        if policify_tick_counter ~= nil then
            save_horn(policified_vehicle)
            set_horn(policified_vehicle)
        end
    else
        override_horn = false
        if policify_tick_counter ~= nil then
            restore_horn(policified_vehicle)
        end
    end
end, true)

menu.toggle(options_menu, "覆盖车牌", {}, "如果启用，将使用FIB车牌牌照覆盖车辆牌照", function(toggle)
    override_plate = toggle
    if policify_tick_counter ~= nil then
        if override_plate then
            save_plate(policified_vehicle)
        end
        refresh_plate_text(policified_vehicle)
    end
end, true)

menu.text_input(options_menu, "设置车牌", {"setpoliceplatetext"}, "设置车牌文本", function(value)
    config.plate_text = value
    refresh_plate_text(policified_vehicle)
end, config.plate_text)

menu.toggle(options_menu, "启用警笛声", {}, "如果启用，将生成一辆隐形警车来发出警笛声.", function(toggle)
    attach_invis_police_siren = toggle
    if policify_tick_counter ~= nil then
        if attach_invis_police_siren then
            attach_invis_police_sirens(policified_vehicle)
            refresh_siren_light_status(policified_vehicle)
            rebuild_edit_attachments_menu()
        else
            remove_invis_police_sirens(policified_vehicle)
        end
    end
end, true)

local siren_types = {
    {
        "警用巡航车",
        {},
        "缓慢的哀嚎",
        "police",
    },
    {
        "警用摩托车",
        {},
        "快速的鸣叫声",
        "policeb",
    },
    {
        "救护车",
        {},
        "略有不同的哀嚎",
        "ambulance",
    },
}

menu.list_select(options_menu, "警笛类型", {}, "不同的警笛类型有稍微不同的声音", siren_types, 1, function(index, name)
    local siren_type = siren_types[index]
    config.siren_attachment = {
        name=siren_type[1],
        model=siren_type[4]
    }
    if policified_vehicle ~= nil then
        refresh_invis_police_sirens(policified_vehicle)
        refresh_siren_light_status(policified_vehicle)
    end
end)

local script_meta_menu = menu.list(jingche, "脚本支持")

menu.divider(script_meta_menu, "Policify")
menu.readonly(script_meta_menu, "版本", SCRIPT_VERSION)

local auto_update_host = "raw.githubusercontent.com"
local auto_update_path = "/hexarobi/stand-lua-policify/main/Policify.lua"
menu.action(script_meta_menu, "自动更新", {}, "自动更新到最新版本", function()
    async_http.init(auto_update_host, auto_update_path, function(result)
        local file = io.open(filesystem.scripts_dir()  .. SCRIPT_RELPATH, "w")
        if file == nil then
            util.toast("打开脚本文件写入时出错")
        end
        file:write(result:gsub("\r", "") .. "\n") -- have to strip out \r for some reason, or it makes two lines. ty windows
        file:close()
        util.toast("脚本版本已刷新。重新启动以应用更新.")
    end, function()
        util.toast("脚本更新下载失败.")
    end)
    async_http.dispatch()
end)

util.create_tick_handler(function()
    return true
end)
