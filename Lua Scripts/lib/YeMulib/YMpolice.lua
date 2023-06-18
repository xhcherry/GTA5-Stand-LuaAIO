util.require_natives(1660775568)
logo = directx.create_texture(filesystem.scripts_dir() .. '/resources/YMIMG/'..'Bodycam.png')
local aalib = require("aalib")
local PlaySound = aalib.play_sound
local SND_ASYNC<const> = 0x0001
local SND_FILENAME<const> = 0x00020000
local resource_dir = filesystem.resources_dir()
if not filesystem.exists(resource_dir) then
	util.toast("resource directory not found. notification system will be less of a bruh")
else
	util.register_file(resource_dir .. "/YMIMG/call911.ytd")
end

if not filesystem.exists(resource_dir) then
	util.toast("resource directory not found. notification system will be less of a bruh")
else
	util.register_file(resource_dir .. "/YMIMG/char_blocked.ytd")
end

store_dir = filesystem.store_dir() .. '\\YMpolice\\'
sound_selection_dir = store_dir .. '\\sound.txt'

if not filesystem.is_dir(store_dir) then
    util.toast("夜幕模拟警察音频未正确安装.")
    util.stop_script()
end

fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()

local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[启动声音] " .. file_selection .. " 未找到.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end

colors = {

    green = 184,

    red = 6,

    yellow = 190,

    black = 2,

    white = 1,

    gray = 3,

    pink = 201,

    purple = 49, 

    blue = 11

    }

function notification(message, color)
	HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(color)
	local picture
	if not filesystem.exists(resource_dir) then
		picture = "CHAR_SOCIAL_CLUB"
	else
		picture = "call911"
	end
	GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(picture, 1)
	while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(picture) do
		util.yield()
	end
	util.BEGIN_TEXT_COMMAND_THEFEED_POST(message)
	if color == colors.green or color == colors.red then
		subtitle = "~u~通知事件" --~u~Notification
	elseif color == colors.black then
		subtitle = "~c~调度事件"--~c~Notification
    elseif color == colors.black then
		subtitle = "~c~观察嫌犯"--~c~Notification
	else
		subtitle = "~u~调度事件"--~u~Notification
	end
	HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(picture, "char_call911", true, 4, "调度中心", subtitle)

	HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
	util.log(message)
end

function notification2(message, color)
	HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(color)
	local picture
	if not filesystem.exists(resource_dir) then
		picture = "CHAR_SOCIAL_CLUB"
	else
		picture = "char_blocked"
	end
	GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(picture, 1)
	while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(picture) do
		util.yield()
	end
	util.BEGIN_TEXT_COMMAND_THEFEED_POST(message)
	if color == colors.green or color == colors.red then
		subtitle = "~u~通知事件" --~u~Notification
	elseif color == colors.black then
		subtitle = "~c~通知事件"--~c~Notification
    elseif color == colors.black then
		subtitle = "~c~通知事件"--~c~Notification
	else
		subtitle = "~u~通知事件"--~u~Notification
	end
	HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(picture, "char_blocked", true, 4, "搜身结果", subtitle)

	HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
	util.log(message)
end

function draw_string(s, x, y, scale, font)
	HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
	HUD.SET_TEXT_FONT(font or 0)
	HUD.SET_TEXT_SCALE(scale, scale)
	HUD.SET_TEXT_DROP_SHADOW()
	HUD.SET_TEXT_WRAP(0.0, 1.0)
	HUD.SET_TEXT_DROPSHADOW(1, 0, 0, 0, 0)
	HUD.SET_TEXT_OUTLINE()
	HUD.SET_TEXT_EDGE(1, 0, 0, 0, 0)
	HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(s)
	HUD.END_TEXT_COMMAND_DISPLAY_TEXT(x, y)
end
-- Policify
-- by Hexarobi
-- Enable Policify option to modify current vehicle, disable option to remove modifications
-- Modifies horn, paint, ne[on, and headlights. Flashes headlights and neon between red and blue.
util.show_corner_help("恭喜你成为LAPD警局的一员:\n~g~我们的职责就是保护市民的安全！\n~r~你个大帅逼Rookie祝你好运\n~o~调度已激活有事敬请联系调度中心\n~r~脚本版本：共用版")
util.keep_running()
notification("洛杉矶警察局：\n欢迎回来\n警员：~g~"..PLAYER.GET_PLAYER_NAME(players.user()),colors.black)
notification("LAPD：\n你的警号：\nYour police UM：\n~r~"..players.get_rockstar_id(players.user()),colors.black)
notification("~r~检测到为公开Bodycam脚本,可能部分功能不可用",colors.green)

local SCRIPT_VERSION = "1.0"

local function show_busyspinner(text)
    HUD.BEGIN_TEXT_COMMAND_BUSYSPINNER_ON("STRING")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(text)
    HUD.END_TEXT_COMMAND_BUSYSPINNER_ON(2)
end

-- From Jackz Vehicle Options script
-- Gets the player's vehicle, attempts to request control. Returns 0 if unable to get control
local function get_player_vehicle_in_control(pid, opts)
    local my_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()) -- Needed to turn off spectating while getting control
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

    -- Calculate how far away from target
    local pos1 = ENTITY.GET_ENTITY_COORDS(target_ped)
    local pos2 = ENTITY.GET_ENTITY_COORDS(my_ped)
    local dist = SYSTEM.VDIST2(pos1.x, pos1.y, 0, pos2.x, pos2.y, 0)

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
    saveData.Headlights_Color = VEHICLE._GET_VEHICLE_XENON_LIGHTS_COLOR(vehicle)
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
    plate_text = "LAPD",
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


local policified_vehicle
local policify_tick_counter
local flash_delay = 30
local override_paint = false
local override_headlights = true
local override_neon = true
local override_plate = false
local override_horn = false
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

local toggle = menu.list(police, "载具选项")

menu.toggle_loop(toggle, "共用版有些功能不可用", {"alwayson"}, "", function()
end)

menu.toggle_loop(toggle, "引擎始终开启", {"alwayson"}, "", function()
	if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
		local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
		VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
		VEHICLE.SET_VEHICLE_LIGHTS(vehicle, 0)
		VEHICLE._SET_VEHICLE_LIGHTS_MODE(vehicle, 2)
	end
end)

menu.toggle(toggle, "时速表", {"speedmeteor"}, "", function(state)
    speedm = state  
    while speedm do
        local ent
            local ent1 = players.user_ped()
            local ent2 = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
            if PED.IS_PED_IN_ANY_VEHICLE(ent1,true) then
                ent = ent2
            else
                ent = ent1
            end
            local speed = ENTITY.GET_ENTITY_SPEED(ent)
            local speedcalc = speed * 3.41
            myspeed1 = math.ceil(speedcalc)
        util.yield()
        draw_string(string.format("GPS:~y~"..myspeed1 .. " ~w~KM/H"), 0.03,0.87, 0.6,5)
        end
end,speedm)


--POLICE_REPORTS = {
--    "DLC_GR_Div_Scanner",
--    "LAMAR_1_POLICE_LOST",
--    "SCRIPTED_SCANNER_REPORT_AH_3B_01",
--    "SCRIPTED_SCANNER_REPORT_AH_MUGGING_01",
--    "SCRIPTED_SCANNER_REPORT_AH_PREP_01",
--    "SCRIPTED_SCANNER_REPORT_AH_PREP_02",
--    "SCRIPTED_SCANNER_REPORT_ARMENIAN_1_01",
--    "SCRIPTED_SCANNER_REPORT_ARMENIAN_1_02",
--    "SCRIPTED_SCANNER_REPORT_ASS_BUS_01",
--    "SCRIPTED_SCANNER_REPORT_ASS_MULTI_01",
--    "SCRIPTED_SCANNER_REPORT_BARRY_3A_01",
--    "SCRIPTED_SCANNER_REPORT_BS_2A_01",
--    "SCRIPTED_SCANNER_REPORT_BS_2B_01",
--    "SCRIPTED_SCANNER_REPORT_BS_2B_02",
--    "SCRIPTED_SCANNER_REPORT_BS_2B_03",
--    "SCRIPTED_SCANNER_REPORT_BS_2B_04",
--    "SCRIPTED_SCANNER_REPORT_BS_PREP_A_01",
--    "SCRIPTED_SCANNER_REPORT_BS_PREP_B_01",
--    "SCRIPTED_SCANNER_REPORT_CAR_STEAL_2_01",
--    "SCRIPTED_SCANNER_REPORT_CAR_STEAL_4_01",
--    "SCRIPTED_SCANNER_REPORT_DH_PREP_1_01",
--    "SCRIPTED_SCANNER_REPORT_FIB_1_01",
--    "SCRIPTED_SCANNER_REPORT_FIN_C2_01",
--    "SCRIPTED_SCANNER_REPORT_Franklin_2_01",
--    "SCRIPTED_SCANNER_REPORT_FRANLIN_0_KIDNAP",
--    "SCRIPTED_SCANNER_REPORT_GETAWAY_01",
--    "SCRIPTED_SCANNER_REPORT_JOSH_3_01",
--    "SCRIPTED_SCANNER_REPORT_JOSH_4_01",
--    "SCRIPTED_SCANNER_REPORT_JSH_2A_01",
--    "SCRIPTED_SCANNER_REPORT_JSH_2A_02",
--    "SCRIPTED_SCANNER_REPORT_JSH_2A_03",
--    "SCRIPTED_SCANNER_REPORT_JSH_2A_04",
--    "SCRIPTED_SCANNER_REPORT_JSH_2A_05",
--    "SCRIPTED_SCANNER_REPORT_JSH_PREP_1A_01",
--    "SCRIPTED_SCANNER_REPORT_JSH_PREP_1B_01",
--    "SCRIPTED_SCANNER_REPORT_JSH_PREP_2A_01",
--    "SCRIPTED_SCANNER_REPORT_JSH_PREP_2A_02",
--    "SCRIPTED_SCANNER_REPORT_LAMAR_1_01",
--    "SCRIPTED_SCANNER_REPORT_MIC_AMANDA_01",
--    "SCRIPTED_SCANNER_REPORT_NIGEL_1A_01",
--    "SCRIPTED_SCANNER_REPORT_NIGEL_1D_01",
--    "SCRIPTED_SCANNER_REPORT_PS_2A_01",
--    "SCRIPTED_SCANNER_REPORT_PS_2A_02",
--    "SCRIPTED_SCANNER_REPORT_PS_2A_03",
--    "SCRIPTED_SCANNER_REPORT_SEC_TRUCK_01",
--    "SCRIPTED_SCANNER_REPORT_SEC_TRUCK_02",
--    "SCRIPTED_SCANNER_REPORT_SEC_TRUCK_03",
--    "SCRIPTED_SCANNER_REPORT_SIMEON_01",
--    "SCRIPTED_SCANNER_REPORT_Sol_3_01",
--    "SCRIPTED_SCANNER_REPORT_Sol_3_02"
--}
--
--chat_commands.add{
--    command="report",
--    help="Play a random police report",
--    func=function(pid, commands)
--        AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_SEC_TRUCK_02", 1)
--        AUDIO.START_AUDIO_SCENE("SCRIPTED_SCANNER_REPORT_SEC_TRUCK_02")
--    end
--}

--menu.action(menu.my_root(), "Police Report", {}, "Play police report", function()
--    --AUDIO.SET_AUDIO_FLAG("AllowPoliceScannerWhenPlayerHasNoControl", 0)
--    --AUDIO.SET_AUDIO_FLAG("OnlyAllowScriptTriggerPoliceScanner", 0)
--    --AUDIO.SET_AUDIO_FLAG("PoliceScannerDisabled", 1)
--    AUDIO.SET_AUDIO_FLAG("IsDirectorModeActive", 1)
--    AUDIO.PLAY_POLICE_REPORT("LAMAR_1_POLICE_LOST", 0)
--
--end)


local script_meta_menu = menu.list(police, "Bodycam")
menu.action(script_meta_menu, "开始录制", {}, "开始录制", function()
    util.toast("~y~AXON BODY:\n~g~录制开始\n~y~Bodycam:~g~on")
    local sound_locationo = store_dir .. "\\1.wav"
    PlaySound(sound_locationo, SND_FILENAME | SND_ASYNC)
end)

menu.action(script_meta_menu, "开机", {}, "开机", function()
    local sound_locationo = store_dir .. "\\2.wav"
    PlaySound(sound_locationo, SND_FILENAME | SND_ASYNC)
end)

local chuansong = menu.list(police, "传送选项", {}, "传送功能选项")
local interiors = {
    {"警察局", {x=443.4068, y=-983.256, z=30.689589}},
    {"警察局更衣室", {x=457.30203, y=-988.34576, z=30.68959}},
    {"角色捏脸房间", {x=402.91586, y=-998.5701, z=-99.004074}},
    {"IAA 办公室", {x=128.20, y=-617.39, z=206.04}},
    {"FIB 顶层", {x=135.94359, y=-749.4102, z=258.152}},
    {"FIB 47层", {x=134.5835, y=-766.486, z=234.152}},
    {"FIB 49层", {x=134.635, y=-765.831, z=242.152}},
    {"安全空间 [挂机室]", {x=-158.71494, y=-982.75885, z=149.13135}},
    {"Lifeinvader大楼", {x=-1082.8595, y=-254.774, z=37.763317}},
    {"麦克家", {x=-813.8814, y=179.07889, z=72.15914}},
    {"富兰克林家（旧）", {x=-14.239959, y=-1439.6913, z=31.101551}},
    {"富兰克林家（新）", {x=7.3125067, y=537.3615, z=176.02803}},
    {"崔佛家", {x=1974.1617, y=3819.032, z=33.436287}},
    {"莱斯斯家", {x=1273.898, y=-1719.304, z=54.771}},
    {"甲基安非他明实验室", {x=1391.773, y=3608.716, z=38.942}},
    {"人道实验室", {x=3625.743, y=3743.653, z=28.69009}},
    {"太平洋标准银行金库", {x=263.39627, y=214.39891, z=101.68336}},
    {"布莱恩郡银行", {x=-109.77874, y=6464.8945, z=31.626724}}, -- credit to fluidware for telling me about this one
    {"机场休息室", {x=-913.8656, y=-2527.106, z=36.331566}},
    {"停尸房", {x=240.94368, y=-1379.0645, z=33.74177}},
    {"军事基地瞭望塔", {x=-2357.9187, y=3249.689, z=101.45073}},
}
for index, data in pairs(interiors) do
    local location_name = data[1]
    local location_coords = data[2]
    menu.action(chuansong, location_name, {}, "", function()
        menu.trigger_commands("doors on")
        menu.trigger_commands("nodeathbarriers on")
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), location_coords.x, location_coords.y, location_coords.z, false, false, false)
    end)
end




local script_meta_menu = menu.list(police, "报告事件")

menu.action(script_meta_menu, "进行搜身", {""}, "", function()
    util.toast("~g~共用版暂不可用,且报告功能只有一项可用")
end)

randomizer = function(x)
    local r = math.random(1,3)
    return x[r]
end
    soundradom = {"1","2","3"}



menu.action(script_meta_menu, "CODE-3", {}, "CODE-3", function(toggle)
    util.show_corner_help("~r~支援~w~单位正在~g~路上")
    notification("警员需要帮助附近巡逻单位请响应\n~y~CODE-3\n~w~请附近的巡逻单位到达该名警员的位置",colors.black)
    local incident_id = memory.alloc(8)
    MISC.CREATE_INCIDENT_WITH_ENTITY(7, PLAYER.PLAYER_PED_ID(), 3, 3, incident_id)
    if randomizer(soundradom) == "1" then
        local sound_locationf = store_dir .. "\\6.wav"
            PlaySound(sound_locationf, SND_FILENAME | SND_ASYNC)
        else
            sound_locationf = store_dir .. "\\211.wav"
            PlaySound(sound_locationf, SND_FILENAME | SND_ASYNC)
        end
    end,true)


RUAN = menu.list(police, "喊话功能", {}, "", function(); end)
menu.divider(RUAN, "公屏信息")
menu.action(RUAN, "喊话不可用", {}, "", function()
    util.toast("~r~检测到脚本为共用版，为保护LAPD群名声\n共用版将不能使用喊话功能\n请谅解\n若想拥有内部版可想管理员申请")
end)
    
local lapd_pc = menu.list(police, "警用电脑(不可用)")


local options_menu = menu.list(police, "选项")
local wanted = menu.list(options_menu,"通缉显示名单不可用")
local dra = menu.list(options_menu, "文字")
local tdra = menu.list(options_menu, "时间")
local pdra = menu.list(options_menu, "图片")


menu.toggle_loop(wanted, "通缉名单不可用", {""}, "", function()
    end)

local dsize = 0.5

local dxx = 0.732

local dyy = 0.094

local dinput = "姓"

menu.text_input(dra, "姓", {"input"}, "", function(value)

    dinput = value

end, dinput)


menu.slider(dra, 'X', {'dx'}, '',1 , 10000, dxx * 10000, 20, function(value)

	dxx = value / 10000

end)

menu.slider(dra, 'Y', {'dy'}, '',1 , 10000, dyy * 10000, 20, function(value)

	dyy = value / 10000

end)

menu.slider(dra, '大小', {'ds'}, '',1 , 1000, 50, 1, function(value)

	dsize = value / 100

end)

menu.toggle_loop(dra, "显示文字", {""}, "", function()
    draw_string(string.format("AXON 共用版本 "..dinput.." 暂无警号"), dxx ,dyy, dsize,5)
end)

local tsize = 0.5

local txx = 0.734

local tyy = 0.0599


menu.slider(tdra, 'X', {'dx'}, '',1 , 10000, txx * 10000, 20, function(value)

	txx = value / 10000

end)

menu.slider(tdra, 'Y', {'dy'}, '',1 , 10000, tyy * 10000, 20, function(value)

	tyy = value / 10000

end)

menu.slider(tdra, '大小', {'ds'}, '',1 , 1000, 50, 1, function(value)

	tsize = value / 100

end)

menu.toggle_loop(tdra, "显示时间", {"time"}, "", function()
    draw_string(string.format(os.date('%Y-%m-%d   T%H:%M:%SZ', os.time())), txx,tyy, tsize,5)
end)

local psize = 0.03

local pxx = 0.9240

local pyy = 0.048



menu.slider(pdra, 'X', {'px'}, '',1 , 10000, pxx * 10000, 20, function(value)

	pxx = value / 10000

end)

menu.slider(pdra, 'Y', {'py'}, '',1 , 10000, pyy * 10000, 20, function(value)

	pyy = value / 10000

end)

menu.slider(pdra, '大小', {'ps'}, '',1 , 1000, 3, 1, function(value)

	psize = value / 100

end)

menu.toggle_loop(pdra, "显示图片", {""}, "", function()
    directx.draw_texture(logo, psize, 0.1, 0.0, 0.0, pxx, pyy, 0, 1, 1, 1, 1)
end)


local script_meta_menu = menu.list(police, "Lua信息")    

menu.action(script_meta_menu, "版本3.5", {}, "版本3.5", function()

end)

menu.action(script_meta_menu, "作者：Ruanmeng", {}, "作者：Ruanmeng", function()
end)

menu.action(script_meta_menu, "源码提供：Homer", {}, "", function()
end)
util.on_stop(function()
    util.show_corner_help("~r~已下班\n~g~祝你在自由时间内过的愉快\n~y~你的岗位将由其他人替岗\n~o~期待着你下次更好的保护战局")
    notification("我们有一名警员已下班他/她需要休息\n我们现在需要一人替岗\n~g~CODE-7\n标识警员：~g~"..PLAYER.GET_PLAYER_NAME(players.user()),colors.black)
    notification("状态：~y~下班\n~g~"..PLAYER.GET_PLAYER_NAME(players.user()),colors.green)
    if randomizer(soundradom) == "1" then
        local sound_locationf = store_dir .. "\\10-4-1.wav"
            PlaySound(sound_locationf, SND_FILENAME | SND_ASYNC)
        else
            sound_locationf = store_dir .. "\\10-4.wav"
            PlaySound(sound_locationf, SND_FILENAME | SND_ASYNC)
        end
    end,true)

playerActionsSetup = function (pid)
    menu.click_slider(menu.player_root(pid), "给予通缉(不可用)", {""}, "",1, 5, 5, 1, function(val)      
end,true)
end

