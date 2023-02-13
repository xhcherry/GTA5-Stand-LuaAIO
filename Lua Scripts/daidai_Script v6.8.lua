util.keep_running()
util.require_natives(1651208000)
util.require_natives(1627063482)
util.require_natives(1640181023)
util.require_natives(1660775568)
util.require_natives(1663599433)
require "lib.daidailib.daidailib"
require "lib.daidailib.safe.am_players"
require "lib.daidailib.safe.main"
require "lib.daidailib.safe.main1"
require "lib.daidailib.safe.main2"
require "lib.daidailib.ridicule"
require "lib.daidailib.natives1622613546"
require "lib.daidaimain.natives.othernatives"
require "lib.daidailib.adwords"
require "lib.daidailib.location"
require "lib.daidailib.object"
require "lib.daidailib.action"
require "lib.daidailib.flamewings"
require "lib.daidailib.daidailib1"
require "lib.daidailib.cussing"
require "lib.daidailib.DamageNumbers"
require "lib.daidailib.physically_controlled"
require "lib.daidailib.cardirvefly"

local UFO = require "lib.daidailib.ufo"
local GuidedMissile = require "lib.daidailib.guided_missile"
local HomingMissiles = require "lib.daidailib.homing_missiles"

JSkey = require 'lib.daidaimain.natives.JSkeyLib'
local scaleForm = require'lib.daidaimain.natives.ScaleformLib'
local SFasd = scaleForm('instructional_buttons')
slaxdom = require"lib/slaxdom"
slaxml = require"lib/slaxml"

local aalib = require("aalib")
local PlaySound = aalib.play_sound
local SND_ASYNC<const> = 0x0001
local SND_FILENAME<const> = 0x00020000


script_version = "6.8"
util.log("加入daidai lua群聊343798401")
----util.toast("[呆呆 提示] ")
----util.yield(1000)
----menu.divider()
----menu.trigger_commands("")
----menu.set_value(Spawn, true)



self = menu.list(menu.my_root(), "自我选项", {}) 
online = menu.list(menu.my_root(), "战局选项", {}) 
chat_m = menu.list(menu.my_root(), "聊天选项", {}) 
vehicle = menu.list(menu.my_root(), "载具选项", {})
weapons = menu.list(menu.my_root(), "武器选项", {})
funfeatures = menu.list(menu.my_root(), "娱乐选项", {})
module_list = menu.list(menu.my_root(), "模组选项", {""}, "")
Task_robbery = menu.list(menu.my_root(), "任务选项", {},"",function() TT() end)
worldlist = menu.list(menu.my_root(), "世界选项", {})
protection = menu.list(menu.my_root(), "保护选项", {})
cheater_detection = menu.list(menu.my_root(), "作弊者检测", {})
otherlist = menu.list(menu.my_root(), "其他选项", {})

-----测试处





--自我选项
health = menu.list(self, "恢复", {}, "")
    menu.action(health, "补充血量", {}, "", function()
        ENTITY.SET_ENTITY_HEALTH(players.user_ped(), PED.GET_PED_MAX_HEALTH(players.user_ped()), 0)
    end)
    menu.action(health, "补充护甲", {}, "", function()
        if util.is_session_started() then
            PED.SET_PED_ARMOUR(players.user_ped(), 50)
        else
            PED.SET_PED_ARMOUR(players.user_ped(), 100)
        end
    end)
    supplemental_snacks = menu.list(health, "零食编辑", {}, "")
        menu.action(supplemental_snacks, "补满全部零食", {}, "", function()
            STAT_SET_INT("NO_BOUGHT_YUM_SNACKS", 30)
            STAT_SET_INT("NO_BOUGHT_HEALTH_SNACKS", 15)
            STAT_SET_INT("NO_BOUGHT_EPIC_SNACKS", 5)
            STAT_SET_INT("NUMBER_OF_ORANGE_BOUGHT", 10)
            STAT_SET_INT("NUMBER_OF_BOURGE_BOUGHT", 10)
            STAT_SET_INT("NUMBER_OF_CHAMP_BOUGHT", 5)
            STAT_SET_INT("CIGARETTES_BOUGHT", 20)
            STAT_SET_INT("NUMBER_OF_SPRUNK_BOUGHT", 10)
            util.toast("完成！")
        end)
        menu.action(supplemental_snacks, "补满全部护甲", {}, "", function()
            STAT_SET_INT("MP_CHAR_ARMOUR_1_COUNT", 10)
            STAT_SET_INT("MP_CHAR_ARMOUR_2_COUNT", 10)
            STAT_SET_INT("MP_CHAR_ARMOUR_3_COUNT", 10)
            STAT_SET_INT("MP_CHAR_ARMOUR_4_COUNT", 10)
            STAT_SET_INT("MP_CHAR_ARMOUR_5_COUNT", 10)
            util.toast("完成！")
        end)
        menu.action(supplemental_snacks, "补满呼吸器", {}, "", function()
            STAT_SET_INT("BREATHING_APPAR_BOUGHT", 20)
            util.toast("完成！")
        end)
    menu.toggle_loop(health, '自动加血', {}, '一直加血直到您的血被加满.', function()
        cq01()
    end)
    local toLockHealth = defaultHealth * 0.5
    menu.toggle(health, "当血量过低时锁定", {}, "当血量低于设置的数值后,锁定血量(控制在80%以内)", function(toggle)
        islockHealth = toggle
        local localPed = PLAYER.PLAYER_PED_ID()
        local currentHealth
        util.create_tick_handler(function()
            if islockHealth then
                currentHealth = ENTITY.GET_ENTITY_HEALTH(localPed)
                if currentHealth < toLockHealth then
                    ENTITY.SET_ENTITY_HEALTH(localPed, toLockHealth)
                end
            end
        end)
    end)
    lockHealthSlider = menu.slider(health, "低于多少%血量", { "rlockhealth" }, "锁定前到达的最低血量，单位%", 10, 100, 50, 10, function(value)
        local maxHealth = ENTITY.GET_ENTITY_MAX_HEALTH(PLAYER.PLAYER_PED_ID())
        toLockHealth = maxHealth * value / 100
    end)
    menu.toggle_loop(health, "在掩体后时补充生命值", {"healincover"}, "", function()
        healthincover()
        end, function ()
            PLAYER._SET_PLAYER_HEALTH_RECHARGE_LIMIT(players.user(), 0.25)
            PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(players.user(), 1.0)
    end)

menu.toggle_loop(self, "快速重生", {}, "", function()
    local gwobaw = memory.script_global(2672505 + 1685 + 756) -- Global_2672505.f_1685.f_756
    if PED.IS_PED_DEAD_OR_DYING(players.user_ped()) then
        GRAPHICS.ANIMPOSTFX_STOP_ALL()
        memory.write_int(gwobaw, memory.read_int(gwobaw) | 1 << 1)
    end
end,
    function()
    local gwobaw = memory.script_global(2672505 + 1685 + 756)
    memory.write_int(gwobaw, memory.read_int(gwobaw) &~ (1 << 1)) 
end)

action_list = menu.list(self, "人物行为", {}, "")
    menu.toggle_loop(action_list, "快速上下车", {}, "更快地进入/离开车辆.", function()
        if (TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 160) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 167) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 165)) and not TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 195) then
            PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
        end
    end)
    menu.toggle_loop(action_list, "快速翻越", {}, "更快的翻越一些东西\n例如：汽车、障碍物等.", function()
        if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 50) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 51) then
            PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
        end
    end)
    local jump = 0.6
    menu.toggle_loop(self, '超级跳', {}, '按下跳跃的时间越长，继续走得更高（也可用于飞行）', function ()
        if PAD.IS_CONTROL_PRESSED(0, 22) or PAD.IS_CONTROL_JUST_PRESSED(0, 21) then
            PED.SET_PED_CAN_RAGDOLL(players.user_ped(), false)
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(players.user_ped(), 1, 0.0, 0.6, jump, 0, 0, 0, 0, true, true, true, true)
            if ENTITY.IS_ENTITY_IN_AIR(players.user_ped()) then
                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(players.user_ped(), 1, 0.0, 0.6, jump, 0, 0, 0, 0, true, true, true, true)
            end
        end
    end)
    menu.toggle(action_list, "空中游泳", {}, "", function(on)
        if on then
            menu.trigger_commands("swiminair on")
        else
            menu.trigger_commands("swiminair off")
        end
    end)
    menu.toggle_loop(action_list, "太空步", {}, "", function(on)
        if PAD.IS_CONTROL_PRESSED(32, 32)  or PAD.IS_CONTROL_PRESSED(34, 34) or PAD.IS_CONTROL_PRESSED(35, 35) then
            local f = ENTITY.GET_ENTITY_FORWARD_VECTOR(PLAYER.PLAYER_PED_ID())
            f['x'] = -f['x']
            f['y'] = -f['y']
            f['z'] = -f['z']
            ENTITY.SET_ENTITY_VELOCITY(PLAYER.PLAYER_PED_ID(), f['x'], f['y']*3, 0.0)
        end
    end)


    all_action_list = menu.list(self, "动作", {}, "")
    anims_root = menu.list(all_action_list, "预加载动作", {}, "")
        character_action()
    
    action_list_lua = menu.list(all_action_list, "动作选项", {}, "", function(); end)
            action_lua_load = menu.action(action_list_lua, "加载所有动作", {""}, "", function()
                util.toast("正在加载动作,请稍等一下")
                util.yield(2000)
                require "lib.daidailib.actions1"
                menu.delete(action_lua_load)
            end)
            
walkwater = menu.toggle_loop(self, "水上行走", {}, "",  function()
    if menu.get_value(waterdrive) == true then
        menu.set_value(walkwater,false)
    end
        
    if dow_block == 0 or not ENTITY.DOES_ENTITY_EXIST(dow_block) then
        local hash = util.joaat("stt_prop_stunt_bblock_mdm3")
        request_model_load(hash)
        local c = {}
        c.x = 0.0
        c.y = 0.0
        c.z = 0.0
        dow_block = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, c['x'], c['y'], c['z'], true, false, false)
        ENTITY.SET_ENTITY_ALPHA(dow_block, 0)
        ENTITY.SET_ENTITY_VISIBLE(dow_block, false, 0)
    end
    vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 2.0, 0.0)
    local ht = memory.alloc(4)
    if WATER.GET_WATER_HEIGHT(pos['x'], pos['y'], pos['z'], ht) then
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], memory.read_float(ht), false, false, false)
        ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
    end
end)
misclightmenu = menu.list(self, "发光")
    menu.toggle_loop(misclightmenu, "开启", {}, "", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        GRAPHICS.DRAW_LIGHT_WITH_RANGE(pos.x, pos.y, pos.z, rlight, glight, blight, Radiuslight, intenslight)
    end)
    Radiuslight = 1
    menu.slider(misclightmenu, "设置半径" ,{}, "", 1, 5, 1, 1, function(s)
        Radiuslight = s
    end)
    intenslight = 1
    menu.slider(misclightmenu, "设置强度", {}, "", 1, 5, 1, 1, function(s)
        intenslight = s
    end)
    menu.divider(misclightmenu,"颜色")
    rlight = 255
    menu.slider(misclightmenu, "R", {"lightred"}, "", 0, 255, 255, 1, function(s)
        rlight = s 
    end)
    glight = 255
    menu.slider(misclightmenu, "G", {"lightgreen"}, "", 0, 255, 255, 1, function(s)
        glight = s
    end)
    blight = 255
    menu.slider(misclightmenu, "B", {"lightblue"}, "", 0, 255, 255, 1, function(s)
        blight = s
    end)


----火人
local burning_man_ptfx_asset = "core"
local burning_man_ptfx_effect = "fire_wrecked_plane_cockpit"
request_ptfx_asset(burning_man_ptfx_asset)
local trail_bones = {0xffa, 0xfa11, 0x83c, 0x512d, 0x796e, 0xb3fe, 0x3fcf, 0x58b7, 0xbb0}
local looped_ptfxs = {}
local was_burning_man_on = false
Burning_Man = menu.toggle(self, "火人", {""}, "", function(on)
    if not on then 
        for _, p in pairs(looped_ptfxs) do
            GRAPHICS.REMOVE_PARTICLE_FX(p, false)
            GRAPHICS.STOP_PARTICLE_FX_LOOPED(p, false)
        end
    else
        request_ptfx_asset(burning_man_ptfx_asset)
        for _, bone in pairs(trail_bones) do
            GRAPHICS.USE_PARTICLE_FX_ASSET(burning_man_ptfx_asset)
            local bone_id = PED.GET_PED_BONE_INDEX(players.user_ped(), bone)
            fx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(burning_man_ptfx_effect, players.user_ped(), 0.0, 0.0, 0.0, 0.0, 0.0, 90.0, bone_id, 0.5, false, false, false, 0, 0, 0, 0)
            looped_ptfxs[#looped_ptfxs+1] = fx
            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, 100, 100, 100, false)
        end
    end
end)
menu.toggle_loop(self, "光环", {}, "", function()
    personllight()
end)   
menu.toggle(self, "获得牛鲨睾酮", {""}, "", function(on_toggle)
    if on_toggle then
        menu.trigger_commands("bst on")
    else
        menu.trigger_commands("bst off")
    end
    util.yield(5000)
end)
menu.action(self, "移除精神值", {}, "", function ()
    menu.trigger_commands("mentalstate 0")
end)
menu.action(self, "移除悬赏", {}, "", function()
    menu.trigger_commands("removebounty")
end)
menu.toggle(self, "人间蒸发", {}, "",function(state)
    menu.trigger_command(menu.ref_by_path("Self>Appearance>Invisibility>" .. (state and "Enabled" or "Disabled"), 38))
    menu.set_value(menu.ref_by_path("Online>Off The Radar", 38), state)
    announce("Ghostmode " .. (state and "On" or "Off"))
end)
menu.toggle_loop(self, "清洁自己", {}, "保持自身清洁", function()
    PED.CLEAR_PED_BLOOD_DAMAGE(players.user_ped())
    PED.CLEAR_PED_WETNESS(players.user_ped())
    PED.CLEAR_PED_ENV_DIRT(players.user_ped())
end)
menu.action(self, "前空翻", {}, "表演一个前空翻", function()
    local hash = util.joaat("prop_ecola_can")
    local prop = entities.create_object(hash, players.get_position(players.user()))
    ENTITY.FREEZE_ENTITY_POSITION(prop)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(players.user_ped(), prop, 0, 0, 0, 0, 0, 0, 0, true, false, false, false, 0, true)
    local hdg = CAM.GET_GAMEPLAY_CAM_ROT(0).z
    ENTITY.SET_ENTITY_ROTATION(prop, 0, 0, hdg, 1)
    for i=1, -360, -8 do
        ENTITY.SET_ENTITY_ROTATION(prop, i, 0, hdg, 1)
        util.yield()
    end
    ENTITY.DETACH_ENTITY(players.user_ped())
    entities.delete_by_handle(prop)
end)
menu.toggle(self, "雪人",{""}, "",function(on)
    local zhangzi = "prop_gumball_03"
    local sonwman = "prop_prlg_snowpile"
    if on then
        attach_to_player(sonwman, 0, 0.0, 0, 0, 0, 0,0)
        attach_to_player(sonwman, 0, 0.0, 0, -0.5, 0, 0,0)
        attach_to_player(sonwman, 0, 0.0, 0, -1, 0, 0,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, 50,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, 125,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, -50,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, -125,0)
    else
        delete_object(sonwman)
        delete_object(zhangzi)
    end
end)
menu.toggle(self, "666",{}, "",function(on)
    local obj = "prop_mp_num_6"
    if on then     
        attach_to_player(obj, 0, 0, 0, 1.7, 0, 0, 180)
        attach_to_player(obj, 0, 1, 0, 1.7, 0, 0, 180)
        attach_to_player(obj, 0, -1, 0, 1.7, 0, 0, 180)
    else
        delete_object(obj)
    end
end)
guitar_obj = menu.list(self, "吉他")
    menu.toggle(guitar_obj, "吉他1",{}, "",function(on)
        local obj = "prop_acc_guitar_01"
        if on then     
            attach_to_player(obj, 0, 0, -0.15, 0.25, 0, -50,0)
        else
            delete_object(obj)
        end
    end)
    menu.toggle(guitar_obj, "吉他2",{}, "",function(on)
        local obj = "prop_el_guitar_03"
        if on then     
            attach_to_player(obj, 0, 0, -0.15, 0.25, 0, -50,0)
        else
            delete_object(obj)
        end
    end)
    menu.toggle(guitar_obj, "吉他3",{}, "",function(on)
        local obj = "prop_el_guitar_01"
        if on then     
            attach_to_player(obj, 0, 0, -0.15, 0.25, 0, -50,0)
        else
            delete_object(obj)
        end
    end)
    menu.toggle(guitar_obj, "吉他4",{}, "",function(on)
        local obj = "prop_el_guitar_02"
        if on then     
            attach_to_player(obj, 0, 0, -0.15, 0.25, 0, -50,0)
        else
            delete_object(obj)
        end
    end)
menu.toggle(self, "小狗戴恩", {}, "", function(on)
    if on then
        menu.trigger_commands("IGFurry")
    else
        menu.trigger_commands("mpmale")
    end
end)
menu.toggle(self, "圣诞怪兽", {}, "", function(on)
    if on then
        menu.trigger_commands("UMMYuleMonster")
    else
        menu.trigger_commands("mpmale")
    end
end)

menu.toggle(self, "骑牛", {}, "",function(state)
    ride_cow(state)   
end)
menu.toggle_loop(self, "锁定等级", {}, "将你的等级锁定在0", function()
    util.set_local_player_wanted_level(0)
end)
menu.toggle_loop(self, '金钱追踪', {}, '', function ()
    local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local tar1 = ENTITY.GET_ENTITY_COORDS(players.user_ped(), true)
    Streamptfx('scr_exec_ambient_fm')
    if TASK.IS_PED_WALKING(targets) or TASK.IS_PED_RUNNING(targets) or TASK.IS_PED_SPRINTING(targets) then
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD('scr_ped_foot_banknotes', tar1.x, tar1.y, tar1.z - 1, 0, 0, 0, 1.0, true, true, true)
    end
end)
tripped = menu.list(self, '摔倒', {}, '')
    menu.toggle(tripped, '摔倒v1', {}, '', function(toggle)
        tripped1(toggle)
    end)
    menu.toggle_loop(tripped, '摔倒v2', {}, '', function()
        tripped2()
    end)

------轨迹
local bones <const> = {
    0x49D9,	
    0xDEAD,	
    0x3779,	
    0xCC4D	
}
local colour = {r = 1.0, g = 0.0, b = 1.0, a = 1.0}
local timer = newTimer()
trailsOpt = menu.list(self,"轨迹", {}, "")
local effect = Effect.new("scr_rcpaparazzo1", "scr_mich4_firework_sparkle_spawn")
local effects = {}
menu.toggle_loop(trailsOpt,"轨迹", {"trails"}, "", function ()
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
		local offsets = {v3(minimum.x, minimum.y, 0.0), v3(maximum.x, minimum.y, 0.0)}
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
local trailColour = menu.colour(trailsOpt,"颜色", {"trailcolour"}, "",colour, false, function(newColour) colour = newColour end)
menu.rainbow(trailColour)


fire_wings = menu.list(self, '翅膀', {}, '')
    menu.toggle(fire_wings, "金色翅膀", {}, "", function(on_toggle)
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
------------------------------------------------------------------------------------翅膀-------
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
        menu.toggle(fire_wings, '火翅膀v1', {''}, '2t同款翅膀', function (toggle)
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
	end
                        end
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
------------------------------------------------------------------------------------翅膀------

local ptfxEgg
    menu.toggle(fire_wings, 'homer火翅膀', {''}, '', function (toggle)
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
            for i = 1, #bigfireWings do
                while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do
                    STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
                    util.yield()
                end
                GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
                bigfireWings[i].ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY('muz_xs_turret_flamethrower_looping', ptfxEgg, 0, 0, 0.1, bigfireWings[i].pos[1], 0, bigfireWings[i].pos[2], 1, false, false, false)

                util.create_tick_handler(function()
                    local rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 2)
                    ENTITY.ATTACH_ENTITY_TO_ENTITY(ptfxEgg, players.user_ped(), -1, 0, 0, 0, rot.x, rot.y, rot.z, false, false, false, false, 0, false)
                    ENTITY.SET_ENTITY_ROTATION(ptfxEgg, rot.x, rot.y, rot.z, 2, true)
                    for i = 1, #bigfireWings do
                        GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(bigfireWings[i].ptfx, fireWingsSettings.scale)
                        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(bigfireWings[i].ptfx,fireWingsSettings.colour.r, fireWingsSettings.colour.g, fireWingsSettings.colour.b)

                    end
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

firebreath = menu.list(self, '喷火', {}, '')
    menu.toggle(firebreath, '喷火', {'JSfireBreath'}, '', function(toggle)
        firebreathxxx(toggle)
    end)
    menu.slider(firebreath, '喷火比例', {'JSfireBreathScale'}, '', 1, 100, fireBreathSettings.scale * 10, 1, function(value)
        firebreathscale(value)
    end)
    menu.rainbow(menu.colour(firebreath, '喷火颜色', {'JSfireBreathColour'}, '', fireBreathSettings.colour, false, function(colour)
        firebreathcolour(colour)
    end))

_LR = menu.list(fire_wings, '火翅膀v2', {}, 'stand同款翅膀')
    menu.toggle(_LR, '翅膀', {'JSfireWings'}, '火焰翅膀.', function (toggle)
        firewing(toggle)
    end)
    menu.slider(_LR, '翅膀比例', {'JSfireWingsScale'}, '', 1, 100, 3, 1, function(value)
        firewingscale(value)
    end)
    menu.rainbow(menu.colour(_LR, '翅膀颜色', {}, '', fireWingsSettings.colour, false, function(colour)
        firewingcolour(colour)
    end))

menu.action(self, "拉便便", {}, "", function()
    personlshit()
end)

menu.action(self, "打飞机", {}, "", function()
    personlhitplane()
end)

local JS_tbls = {}
JS_tbls.alphaPoints = {0, 87, 159, 207, 255}
menu.slider(self, '幽灵', {'ghost'}, '修改您人物的不透明度.', 0, 100, 100, 25, function(value)
    ENTITY.SET_ENTITY_ALPHA(players.user_ped(), JS_tbls.alphaPoints[value / 25 + 1], false)
end)

TP_movement = menu.list(self, '向前移动', {}, '')
    tpf_units = 1
    menu.action(TP_movement, "移动", {}, "向前移动~个单位", function(on_click)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0, tpf_units, 0)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos['x'], pos['y'], pos['z'], true, false, false)
    end)
    menu.slider(TP_movement, "移动距离", {}, "向前传送的距离", 1, 100, 1, 1, function(s)
        tpf_units = s
    end)

menu.list_action(self, "获取导弹", {}, "选择导弹", opt_pp, function(index, value, click_type)
    dd02(index, value, click_type)
end)

menu.action(self, "吊射炮", {""}, "从某个位置发射一枚火炮", function ()
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
menu.toggle(self, "禁用脚步声", {}, "", function(state)
    AUDIO1.SET_PED_AUDIO_FOOTSTEP_LOUD(players.user_ped(), not state)
end)
maxHealth_cantseeyouinmap = 328
menu.toggle_loop(self, "假死", {}, "地图上不会出现你", function()
    if  ENTITY.GET_ENTITY_MAX_HEALTH(players.user_ped()) ~= 0 then
		ENTITY.SET_ENTITY_MAX_HEALTH(players.user_ped(), 0)
	end
end, function ()
	ENTITY.SET_ENTITY_MAX_HEALTH(players.user_ped(), maxHealth_cantseeyouinmap)
end)

------------------------------------------------战局选项
player_option_list = menu.list(online, "玩家选项", {}, "")
    frendlist = menu.list(player_option_list, "好友列表", {}, "")
        menu.divider(frendlist, "好友:)")
        for i = 0 , get_friend_count() do
            local name = get_frined_name(i)
            if name == "*****" then goto yes end
            gen_fren_funcs(name)
            ::yes::
        end
        player_information = menu.list(player_option_list, "玩家信息", {}, "") 
        load_player_information = menu.action(player_information, "加载玩家信息", {"loadplayerinfo"}, "", function()
            require "lib.daidailib.PlayerMessage"
            menu.delete(load_player_information)
        end)
        menu.trigger_commands("loadplayerinfo")


        
musiclist = menu.list(online, "音乐", {"fl"}, "")
    menu.toggle(musiclist, "播放", {"Playmusic"}, "", function(on)
        music(on)
    end)

    hud_rgb_index = 1
    hud_rgb_colors = {6, 18, 9}
    menu.toggle_loop(musiclist, "蹦迪", {}, "", function()
        HUD.FLASH_MINIMAP_DISPLAY_WITH_COLOR(hud_rgb_colors[hud_rgb_index])
        hud_rgb_index = hud_rgb_index + 1
        if hud_rgb_index == 4 then
            hud_rgb_index = 1
        end
        util.yield(200)
    end)

request_services = menu.list(online, "请求服务", {""}, "")
    weather = menu.list(request_services, "请求天气", {""}, "")
        menu.action(weather, "请求雷雨天气", {}, "", function ()
            menu.trigger_commands("thunderon")
        end)
        menu.action(weather, "关闭雷雨天气", {}, "", function ()
            menu.trigger_commands("thunderoff")
        end)
    menu.action(request_services, "即时纳米无人机", {}, "", function()
        nanodrone()
    end)
    menu.action(request_services, "即时RC匪徒", {}, "", function()
        bandito()
    end)
    menu.action(request_services, "即时遥控RC坦克", {}, "", function ()
        rctank()
    end)
    menu.action(request_services, "请求豪华直升机", {}, "", function()
        Luxury_Helicopter()       
    end)
    menu.action(request_services, "请求空袭", {}, "", function ()
        menu.trigger_commands("airstrike")
    end)
    menu.action(request_services, "请求弹药空投", {}, "", function ()
        menu.trigger_commands("requestammodrop")
    end)
    menu.action(request_services, "请求船只接送", {}, "", function ()
        menu.trigger_commands("boatpickup")
    end)
    menu.action(request_services, "请求直升机接送", {}, "", function ()
        menu.trigger_commands("helipickup")
    end)
    menu.action(request_services, "请求直升机支援", {}, "", function ()
        menu.trigger_commands("helibackup")
    end)

local popularity_loop_command_ref = menu.ref_by_path("Online>Quick Progress>Set Nightclub Popularity", 38)
menu.toggle_loop(online, "夜总会人气", {}, "夜总会保持人气最高",function()
    menu.trigger_command(popularity_loop_command_ref, 100)
    util.toast("[呆呆 提示]\n 夜店人气保持中")
    util.yield(2000)
end)
menu.toggle_loop(online, "自动获取主机", {"autogethost"}, "", function()
    autogethost()
end)
menu.action(online, "获得脚本主机", {}, "获取脚本主机（加载战局会快哦！！）", function()
    menu.trigger_commands("scripthost")
  end)
menu.toggle_loop(online, "自动获取脚本主机", {"scriptshost"}, "更快获取脚本主机", function()
    if players.get_script_host() ~= players.user() and get_transition_state(players.user()) ~= 0 then
        menu.trigger_command(menu.ref_by_path("Players>"..players.get_name_with_tags(players.user())..">Friendly>Give Script Host"))
    end
end)
menu.toggle_loop(online, "自动接受并加入游戏", {}, "将自动接受加入任务", function() -- credits to soulreaper for sending me this :D
    local message_hash = HUD.GET_WARNING_SCREEN_MESSAGE_HASH()
    if message_hash == 15890625 or message_hash == -587688989 then
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1.0)
        util.yield(50)
    end
end)

menu.action(online, "索赔所有车辆", {}, "", function ()
	reclaimVehicles()	
end)
util.on_transition_finished(function ()
	reclaimVehicles()
end)

online_other = menu.list(online, "其他选项", {""}, "")
    unlocks = menu.list(online_other, "解锁选项")
        menu.toggle_loop(unlocks, "50辆载具车库", {}, "", function()
            if memory.read_byte(memory.script_global(262145 + 32688)) ~= 0 then-- thx aero for this global <3
                memory.write_byte(memory.script_global(262145 + 32688), 0) 
            end

            if memory.read_byte(memory.script_global(262145 + 32702)) ~= 1 then
                memory.write_byte(memory.script_global(262145 + 32702), 1)  
            end
        end)

        menu.action(unlocks, "毒品战争内容", {}, "", function()
            for i = 33974, 34112, 1 do
                memory.write_byte(memory.script_global(262145 + i), 1)  
            end
        end)

        menu.action(unlocks, "圣诞和新年礼物", {}, "Change sessions for the gifts to be awarded.", function()
            memory.write_byte(memory.script_global(262145 + 33915), 1)  
            memory.write_byte(memory.script_global(262145 + 33916), 1)  
        end)
    menu.toggle(online_other, "关闭电台", {"closeradio"}, "",function(on)
        if on then
            AUDIO.SET_RADIO_TO_STATION_NAME("OFF")
            menu.trigger_commands("Playmusic off")
        else
        end
    end)
    menu.toggle(online_other, '同步时间', {'xssj'}, '与现实时间同步', function(toggle)
        Real_world_time(toggle)
    end)
    display_time = menu.toggle(online_other, "显示时间", {}, "", function(state)
        daidaishijian(state)
    end)
    menu.set_value(display_time, true)

    host_sequence = menu.toggle_loop(online_other, "主机序列", {}, "", function()
        zhujixvlie1()
    end)
    menu.set_value(host_sequence, true)
    menu.toggle_loop(online_other, "实体池信息", {}, "", function()
        entityinfo()
    end)


    mcxh=1
    mcr=255
    mcg=0
    mcb=0
    script_name = menu.toggle(online_other, "显示脚本名称", {}, "", function(state)
        daidaijiaoben(state)
    end)
    menu.set_value(script_name, true)





local style_names = {"正常", "半冲刺", "反向", "无视红绿灯", "避开交通", "极度避开交通", "有时超车"}
local drivingStyles = {786603, 1074528293, 8388614, 1076, 2883621, 786468, 262144, 786469, 512, 5, 6}
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

local function get_element_text(el)
    local pieces = {}
    for _,n in ipairs(el.kids) do
      if n.type=='element' then pieces[#pieces+1] = get_element_text(n)
      elseif n.type=='text' then pieces[#pieces+1] = n.value
      end
    end
    return table.concat(pieces)
end
local exists1, exists2, exists3 = false, false, false

local chaos, gravity, speed = false, true, 100



-----------------------------------------------聊天上色
chat_message = menu.list(chat_m, "聊天上色", {""}, "")

    util.ensure_package_is_installed("lua/ScaleformLib")
    local chat_scaleform = require("lib.daidailib.ScaleformLib")("multiplayer_chat")
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
----------------------------------------

---------------------------------------------------------翻译----
TRANROOT = menu.list(chat_m, "聊天翻译", {""}, "")
    focusref = {}
    isfocused = false
    selectedcolormenu = 0
    colorselec = 1
    allchatlabel = util.get_label_text("MP_CHAT_ALL")
    teamchatlabel = util.get_label_text("MP_CHAT_TEAM")

    util.ensure_package_is_installed("lua/ScaleformLib")
    local sfchat = require("lib.ScaleformLib")("multiplayer_chat")
    sfchat:draw_fullscreen()

    local Languages = {
        { Name = "Chinese Simplified-简体中文", Key = "zh-CN" },
        { Name = "Chinese Traditional-繁体中文", Key = "zh-TW" },
        { Name = "English-英语", Key = "en" },
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
    function decode(text)
        return string.gsub(text, "%+", " ")
    end
    traduct = false
    menu.toggle(TRANROOT, "打开转换器", {}, "经测试完全可使用\n如发现不可用，多考虑加速器", function(on)
        traduct = on	
    end)
    settingtrad = menu.list(TRANROOT, "翻译设置")
        tradlocamenu = menu.slider_text(settingtrad, "翻译语言的位置", {}, "切换后需单击以进行更改", {"团队聊天未联网", "团队聊天网络化", "全球聊天未联网", "全球聊天网络", "通知"}, function(s)
            Tradloca = s
        end)
        traductself = true
        menu.toggle(settingtrad, "翻译自我", {}, "", function(on)
            traductself = on	
        end, true)
        oldway = true
        menu.toggle(settingtrad, "使用引用玩家方法", {}, players.get_name(players.user()).." [全部]玩家_发送者：他们的消息", function(on)
            oldway = on	
        end, true)
        traductsamelang = false
        menu.toggle(settingtrad, "即使语言与目标语言相同，也要进行翻译", {}, "可能无法正常工作", function(on)
            traductsamelang = on	
        end)
    targetlangmenu = menu.slider_text(TRANROOT, "目标语言", {}, "切换后需单击以进行更改", LangName, function(s)
        targetlang = LangLookupByName[LangKeys[s]]
    end)
    menu.action(TRANROOT, "版本", {""}, "1.0.0", function()
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
        targetlang = LangLookupByName[LangKeys[menu.get_value(targetlangmenu)]]
        util.yield()
        run = run+1
    end
    util.on_stop(function()
        util.show_corner_help("")	
    end)		
-------------------翻译结束----

chatspamtrash = menu.list(chat_m, "刷屏")
    taunt = menu.list(chatspamtrash, "嘲讽")
        menu.action(taunt, "嘲讽v1", {""}, ": u cant crash 2stand1 daidaiScript user XD", function()
            chat.send_message("u cant crash 2stand1 daidaiScript user XD",false,true,true)
        end)
        menu.action(taunt, "嘲讽v2", {""}, ": u cant crash GTA5 Online assistant user XD", function()
            chat.send_message("u cant crash GTA5 Online assistant user XD",false,true,true)
        end)
    clear_screen = menu.list(chatspamtrash, "清屏")
        menu.action(clear_screen, "清屏v1", {""}, "", function()
            chat.send_message("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n---------daidai---------\n已为您自动踢出广告机\n----------OvO----------",false,true,true)
        end)
        menu.action(clear_screen, "清屏v2", {""}, "", function()
            chat.send_message("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n----------OvO----------\n已为您自动踢出广告机\n----------OvO----------",false,true,true)
        end)
    recite = menu.list(chatspamtrash, "背诵古诗")
        menu.action(recite, "黄鹤楼送孟浩然之广陵", {""}, "李白", function()
            chat.send_message("故人西辞黄鹤楼，\n 烟花三月下扬州。\n孤帆远影碧空尽，\n唯见长江天际流。",false,true,true)
        end)
        menu.action(recite, "咏苎萝山", {""}, "李白", function()
            chat.send_message("西施越溪女，出自苎萝山。\n 秀色掩今古，荷花羞玉颜。\n浣纱弄碧水，自与清波闲。\n皓齿信难开，沉吟碧云间。\n勾践徵绝艳，扬蛾入吴关。\n提携馆娃宫，杳渺讵可攀。\n一破夫差国，千秋竟不还。",false,true,true)
        end)
        menu.action(recite, "春晓", {""}, "孟浩然", function()
            chat.send_message("春眠不觉晓，\n 处处闻啼鸟。\n夜来风雨声，\n花落知多少。",false,true,true)
        end)
    custom_taunt = menu.list(chatspamtrash, "自定义")
        menu.action(custom_taunt, "自定义1", {""}, "内容可在cussing中修改", function()
            chat.send_message(custom_taunt_sentence1,false,true,true)
        end)
        menu.action(custom_taunt, "自定义2", {""}, "内容可在cussing中修改", function()
            chat.send_message(custom_taunt_sentence2,false,true,true)
        end)


    menu.action(chat_m, "清除聊天历史", {""}, "", function()
        chat.send_message("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",false,true,true)
    end)

-----------------------------------------------------载具选项

nitrogen_acceleration = menu.list(vehicle, '氮气加速', {}, '')
    
    menu.toggle_loop(nitrogen_acceleration, "氮气加速", {}, "按X使用", function()
        nnitrogen_acceleration()
    end)
    menu.slider(nitrogen_acceleration, "氮气时间", {"nitroduration"}, "", 1, 30, 5, 1, function(val)
        nnitro_duration(val)
    end)
    menu.slider(nitrogen_acceleration, "氮气速度", {"nitropower"}, "", 1, 10000, 2000, 50, function(val)
        nnitro_power(val)
    end)

menu.toggle_loop(vehicle, "车祸模拟", {}, "Ctrl+W键\n再进行转向操作", function()
    car_crash()
end)

dow_block = 0
waterdrive = menu.toggle_loop(vehicle, "水上驾驶", {}, "", function()
    if menu.get_value(walkwater) == true then
        menu.set_value(waterdrive,false)
    end
    if dow_block == 0 or not ENTITY.DOES_ENTITY_EXIST(dow_block) then
        local hash = util.joaat("stt_prop_stunt_bblock_mdm3")
        request_model_load(hash)
        local c = {}
        c.x = 0.0
        c.y = 0.0
        c.z = 0.0
        dow_block = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, c['x'], c['y'], c['z'], true, false, false)
        ENTITY.SET_ENTITY_ALPHA(dow_block, 0)
        ENTITY.SET_ENTITY_VISIBLE(dow_block, false, 0)
    end
    if dow_block ~= 0 and not walkonwater and not walkonair and not driveonwater and not driveonair then
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, 0, 0, 0, false, false, false)
    end
    if player_cur_car ~= 0 then
        local pos = ENTITY.GET_ENTITY_COORDS(player_cur_car, true)
        -- ht isnt actually used here, but im allocating some memory anyways to prevent a possible crash, probably. idk im no computer engineer
        local ht = memory.alloc(4)
        -- this is better than ENTITY.IS_ENTITY_IN_WATER because it can detect if a player is actually above water without them even being "in" it
        if WATER.GET_WATER_HEIGHT(pos['x'], pos['y'], pos['z'], ht) then
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], memory.read_float(ht), false, false, false)
            ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(player_cur_car))
        end
    else
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, 0, 0, 0, false, false, false)
    end
end)

menu.toggle(vehicle, "烧焦外形", {}, "", function(on)
    if on then
        menu.trigger_commands("scorched on")
    else
        menu.trigger_commands("scorched off")
    end
end)

menu.toggle_loop(vehicle, '贴地/贴墙行驶', {}, '车辆粘在地上/墙上行驶', function ()
    local curcar = entities.get_user_vehicle_as_handle()
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) then
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(curcar, 1, 0, 0, - 0.5, 0, true, true, true, true)
        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(curcar, 40)
    else
        util.yield()
    end
end)

local veh_jump = menu.list(vehicle, "载具跳跃")
local force = 25.00
menu.slider_float(veh_jump, "跳跃倍率", {"jumpiness"}, "", 0, 10000, 2500, 100, function(value)
    force = value / 100
end)
menu.toggle_loop(veh_jump, "启动", {}, "按空格键跳跃.", function()
    local veh = entities.get_user_vehicle_as_handle()
    if veh ~= 0 and ENTITY.DOES_ENTITY_EXIST(veh) and PAD.IS_CONTROL_JUST_RELEASED(0, 102) then
        ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, force/1.5, force, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        repeat
            util.yield()
        until not ENTITY.IS_ENTITY_IN_AIR(veh)
    end
end)

speedometer_car = menu.list(vehicle, "可视化速度表", {}, "")
    local sp_bg_tex = directx.create_texture(filesystem.store_dir().."\\daidai-IMG\\carspeed\\nfs_spc.png") 
    local sp_pin_tex = directx.create_texture(filesystem.store_dir().."\\daidai-IMG\\carspeed\\nfs_pin_spc.png") 

    --Default color background
    local sp_colour = {				
                ["r"] = 0.9,
                ["g"] = 0.9,
                ["b"] = 0.9,
                ["a"] = 1.0
            }
    --Default text color
    local txt_colour = {				
                ["r"] = 1.0,
                ["g"] = 1.0,
                ["b"] = 1.0,
                ["a"] = 1.0
            }
    --default speedometer pos
    local sp_posX = 0.865
    local sp_posY = 0.86

    menu.toggle_loop(speedometer_car,"开启", {}, "",function()	
        local veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
            if veh > 0 then
                local speed = ENTITY.GET_ENTITY_SPEED(veh);
                local kmh = math.floor((speed * 3.6));
                local rotation = 0.0
            
                if kmh <= 240 and rotation <= 0.75 then
                    rotation = kmh/320
                end
            
                directx.draw_texture(		---------------------------- speedometer bg texture
                sp_bg_tex,				-- id
                0.066,				-- sizeX
                0.066,				-- sizeY
                0.5,				-- centerX
                0.5,				-- centerY
                sp_posX,				-- posX 
                sp_posY,		 		-- posY 
                0.0,				-- rotation
                sp_colour			--colour
            )
                directx.draw_texture(		---------------------------- speedometer pin texture
                sp_pin_tex,				-- id
                0.066,				-- sizeX
                0.066,				-- sizeY
                0.5,				-- centerX
                0.5,				-- centerY
                sp_posX,				-- posX  
                sp_posY,		 		-- posY 
                rotation,			-- rotation
                sp_colour 			--colour
            )
                directx.draw_text(	-------------------  small text top
                sp_posX-0.022,				-- x 
                sp_posY+0.068,				-- y 
                kmh .." KMPH",		-- text
                ALIGN_TOP_LEFT,		-- alignment
                0.6,				-- scale
                txt_colour,		-- colour
                false				
            )	
            end
    end)
	menu.divider(speedometer_car, "车速表选项")
		menu.rainbow(menu.colour(speedometer_car, "更改车速表强调色", {"spc"}, "", sp_colour, true, function(colour)
			sp_colour = colour
		end))
		menu.colour(speedometer_car, "更改车速表文本颜色", {"sptxtc"}, "", txt_colour, true, function(colour)
			txt_colour = colour
		end)
		menu.divider(speedometer_car, "车速表位置")
		menu.slider(speedometer_car, "车速表位置X", {"spX"}, "", 1, 1000, 865, 1, function(x)
			sp_posX=x/1000
		end)
		menu.slider(speedometer_car, "车速表位置Y", {"spY"}, "", 1, 1000, 860, 1, function(y)
			sp_posY=y/1000
		end)



ff9car = menu.list(vehicle, "道奇战马", {}, "")
    Spawn = menu.toggle_loop(ff9car, '道奇战马', {}, '按E使用', function ()
        daoqizhanma()
    end)


-----------UFO载具
UFO_vehicles = menu.list(vehicle, "UFO载具", {}, "")
    local objModels <const> = {
        "imp_prop_ship_01a",
        "sum_prop_dufocore_01a"
    }
    menu.action_slider(UFO_vehicles, "UFO", {}, "驾驶UFO,使用牵引光束和大炮", {"外星UFO", "军用UFO"}, function (index)
        local obj = objModels[index]
        UFO.setObjModel(obj)
        if not (GuidedMissile.exists() or UFO.exists()) then UFO.create() end
    end)
    -------------------------------------
    local ufoSettings = menu.list(UFO_vehicles, "设置", {}, "")

    menu.toggle(ufoSettings,"禁用播放器框", {}, "", function(toggle)
        Config.ufo.disableboxes = toggle
    end, Config.ufo.disableboxes)

    local helpText <const> = "使牵引光束忽略带有非玩家驾驶员的车辆"
    menu.toggle(ufoSettings, "仅吸引玩家载具", {}, helpText, function(toggle)
        Config.ufo.targetplayer = toggle
    end, Config.ufo.targetplayer)
-------------------------

menu.toggle(vehicle, "载具时速表", {}, "", function(state)
    vehicle_speedometer(state)
end)
menu.slider(vehicle, "换座位", {""}, "", -1, 2, -1, 1, function(value)
    local ourped = PLAYER.PLAYER_PED_ID()
    if PED.IS_PED_IN_ANY_VEHICLE(ourped, false) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(ourped, false)
        PED.SET_PED_INTO_VEHICLE(ourped, veh, value)
    else
        util.toast("你还没上车呢")
    end
end)
menu.toggle_loop(vehicle, "粘在地上", {""}, "", function()
    local vehicle = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
    local velocity = ENTITY.GET_ENTITY_VELOCITY(vehicle)
    local height = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(vehicle)
    local controls = {32, 33, 34, 35}
    if height < 5.0 then
        if ENTITY.IS_ENTITY_IN_AIR(vehicle) then
            VEHICLE1.SET_VEHICLE_ON_GROUND_PROPERLY(vehicle)
        end
    else
        for _, key in ipairs(controls) do
            if vehicle ~= 0 and PAD.IS_CONTROL_PRESSED(0, key) then
                while not PAD.IS_CONTROL_RELEASED(0, key) and ENTITY.IS_ENTITY_IN_AIR(vehicle) do
                    ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 2, 0, 0, -500 - velocity.z, 0, 0, 0, 0, true, false, true, false, true)
                    util.yield()
                end
            end
        end
    end
end)
menu.toggle_loop(vehicle, '部分载具无限海底挤压深度', {}, '潜水艇，虎鲸...', function ()
    local subs = {'submersible','submersible2','avisa','kosatka', 'toreador'}
    local cursub = ENTITY.GET_ENTITY_MODEL(entities.get_user_vehicle_as_handle())
    for _, s in ipairs(subs) do
        if cursub == util.joaat(s) then
            VEHICLE.SET_SUBMARINE_CRUSH_DEPTHS(entities.get_user_vehicle_as_handle(), false, 2000, 2000, 2000)
        end
    end
end)

carcolor = menu.list(vehicle, '载具变色', {}, '')
    menu.toggle_loop(carcolor, '变色载具', {}, '可使车辆变色', function ()
        zjbs()
    end)
    menu.slider(carcolor, '变色速度', {''}, '改变变色速度', 10, 200, 100, 10, function (c)
        colorspeed(c)
    end)
    menu.toggle_loop(carcolor, '前照灯', {}, '改变前灯', function ()
        qzd()
    end)
    menu.slider(carcolor, '前照灯速度', {''}, '前照灯速度', 10, 200, 100, 10, function (c)
        qzdcolorspeed(c)
    end)


-----最近的载具
local function get_closest_vehicle(entity)
    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
    local vehicles = entities.get_all_vehicles_as_handles()
    local closestdist = 1000000
    local closestveh = 0
    for k, veh in pairs(vehicles) do
        if veh ~= PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false) and ENTITY.GET_ENTITY_HEALTH(veh) ~= 0 then
            local vehcoord = ENTITY.GET_ENTITY_COORDS(veh, true)
            local dist = MISC.GET_DISTANCE_BETWEEN_COORDS(coords['x'], coords['y'], coords['z'], vehcoord['x'], vehcoord['y'], vehcoord['z'], true)
            if dist < closestdist then
                closestdist = dist
                closestveh = veh
            end
        end
    end
    return closestveh
end

tpnearcar_list = menu.list(vehicle, "传送到最近载具", {}, "")
menu.action(tpnearcar_list, "传送一次", {"tpnearcar"}, "", function(on_click)
    local closestveh = get_closest_vehicle(players.user_ped())
    local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(closestveh, -1)
    if VEHICLE.IS_VEHICLE_SEAT_FREE(closestveh, -1) then
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, -1)
    else
        if not PED.IS_PED_A_PLAYER(driver) then
            entities.delete_by_handle(driver)
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, -1)
        elseif VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(closestveh) then
            for i=0, 10 do
                if VEHICLE.IS_VEHICLE_SEAT_FREE(closestveh, i) then
                    PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, i)
                end
            end
        else
            util.toast("[呆呆 提醒] \n传送到最近车辆错误")
        end
    end
end)
menu.toggle_loop(tpnearcar_list, "喇叭传送", {}, "需在有喇叭的载具中才生效", function()
    horn_boost_tp(players.user())
end)

menu.toggle_loop(vehicle, "转向灯", {}, "按A键和D键使用", function()
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

menu.toggle_loop(vehicle, "水下驾驶", {}, "", function ()
    menu.trigger_commands("waterwheels")
end)

car_door = menu.list(vehicle, "车门控制", {}, "")
menu.toggle(car_door, "所有门", {""}, "", function(on_toggle)
    if on_toggle then
        menu.trigger_commands("openvehdoors on")
    else
        menu.trigger_commands("openvehdoors off")
    end
end)
menu.action(vehicle, "强制离开载具", {}, "", function(click_type)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
    TASK.TASK_LEAVE_ANY_VEHICLE(players.user_ped(), 0, 16)
end)
menu.toggle_loop(vehicle, "喇叭加速", {}, "", function()
    remote_horn_boost()
end)
menu.toggle_loop(vehicle, "喇叭跳跳车", {}, "", function() 
    remote_car_jump() 
end)

acceleration_pads = menu.list(vehicle, "加(减)速带", {}, "")
    menu.action(acceleration_pads, "单个加速带", {}, "", function() 
        jiasudian()
    end)
    menu.action(acceleration_pads, "四个加速带", {}, "", function()
        sigejiasudian()
    end) 
    menu.action(acceleration_pads, "单个减速带", {}, "", function()
        jiansudai()
    end)


planehud = menu.list(vehicle, "飞机HUD", {})
--------------------------------------------------------------载具效果------------------------------------
vehicle_effect = menu.list(vehicle, "载具效果", {}, "")
    local effects = {
        {"scr_rcbarry1", "scr_alien_impact_bul", 1.0, 50},
        {"scr_rcbarry2", "scr_clown_appears", 0.3, 500},
        {"core", "ent_dst_elec_fire_sp", 1.0, 100},
        {"scr_rcbarry1", "scr_alien_disintegrate", 0.1, 400},
        {"scr_rcbarry1", "scr_alien_teleport", 0.1, 400}
    }
    local selectedOpt = 1
    local lastEffect <const> = newTimer()
    menu.toggle_loop(vehicle_effect, "开关", {}, "", function ()
        local effect = effects[selectedOpt]
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
        if ENTITY.DOES_ENTITY_EXIST(vehicle) and not ENTITY.IS_ENTITY_DEAD(vehicle, false) and
        VEHICLE.IS_VEHICLE_DRIVEABLE(vehicle, false) and lastEffect.elapsed() > effect[4] then
            request_fx_asset(effect[1])
            for _, boneName in pairs({"wheel_lf", "wheel_lr", "wheel_rf", "wheel_rr"}) do
                local bone = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicle, boneName)
                GRAPHICS.USE_PARTICLE_FX_ASSET(effect[1])
                GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE(
                    effect[2],
                    vehicle,
                    0.0, 0.0, 0.0,
                    0.0, 0.0, 0.0,
                    bone,
                    effect[3],
                    false, false, false
                )
            end
            lastEffect.reset()
        end
    end)
    local options = {
        "外星人冲击",
        "小丑出现",
        "蓝色火花",
        "外星人解体",
        "火热颗粒",
    }
    menu.slider_text(vehicle_effect,"设置载具效果", {}, "点击确认更改", options, function (index)
        selectedOpt = index 
    end)
--------------------------------------------------------------载具效果------------------------------------


local jesus_main = menu.list(vehicle, "自动驾驶", {}, "需设置导航点")
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
        return end
        local function request_model(hash, timeout)
            timeout = timeout or 3
            STREAMING.REQUEST_MODEL(hash)
            local end_time = os.time() + timeout
            repeat
                util.yield()
            until STREAMING.HAS_MODEL_LOADED(hash) or os.time() >= end_time
            return STREAMING.HAS_MODEL_LOADED(hash)
        end
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
            util.toast("需要设置导航点")
                menu.set_value(jesus_toggle, false)
        end
    else
        if jesus_ped ~= nil then 
            entities.delete_by_handle(jesus_ped)
        end
    end
end)
local function request_model(hash, timeout)
    timeout = timeout or 3
    STREAMING.REQUEST_MODEL(hash)
    local end_time = os.time() + timeout
    repeat
        util.yield()
    until STREAMING.HAS_MODEL_LOADED(hash) or os.time() >= end_time
    return STREAMING.HAS_MODEL_LOADED(hash)
end


menu.toggle(vehicle, "特斯拉自动驾驶", {}, "", function(toggled)
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

menu.toggle_loop(vehicle, "强制生成反制系统", {}, "让所有载具都有反制系统", function(on)
    if PAD.IS_CONTROL_PRESSED(46, 46) then
        local target = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), math.random(-5, 5), -30.0, math.random(-5, 5))
        --MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(target['x'], target['y'], target['z'], target['x'], target['y'], target['z'], 300.0, true, -1355376991, players.user_ped(), true, false, 100.0)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(target['x'], target['y'], target['z'], target['x'], target['y'], target['z'], 100.0, true, 1198879012, players.user_ped(), true, false, 100.0)
    end
end)

--------------------------------------------------------载具飞行模式-----------------------------------
renderscorched = false
menu.toggle(vehicle, "载具飞行模式", {"vehfly"}, "自由控制你的载具再天上飞行。", function(on_click)
    is_vehicle_flying = on_click
end)

veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false);
util.create_tick_handler(function() 
    VEHICLE.SET_VEHICLE_GRAVITY(veh, not is_vehicle_flying)
    if is_vehicle_flying then do_vehicle_fly() else ENTITY.SET_ENTITY_COLLISION(veh, true, TRUE); end
    return true
end)
util.on_stop(function() 
    VEHICLE.SET_VEHICLE_GRAVITY(veh, true)
	ENTITY.SET_ENTITY_COLLISION(veh, true, TRUE);
end)
--------------------------------------------------------载具飞行模式-----------------------------------



vf = menu.list(vehicle, "冻结选项", {}, "")
local frozen_vehicles = {}
local function update_frozen_vehicles()
    for _, frozen_vehicle in pairs(frozen_vehicles) do
        if ENTITY.DOES_ENTITY_EXIST(frozen_vehicle.vehicle) then
            ENTITY.FREEZE_ENTITY_POSITION(frozen_vehicle.vehicle, true)
        end
    end
end
local frozen_vehicles_menu_list
local function refresh_frozen_vehicles_menu_list()
    menu.delete(frozen_vehicles_menu_list)
    frozen_vehicles_menu_list = menu.list(vf, "已冻结的载具")
    for index, frozen_vehicle in pairs(frozen_vehicles) do
        menu.action(frozen_vehicles_menu_list, frozen_vehicle.name, {"unfreeze"..index}, "点击解冻载具", function()
            table.remove(frozen_vehicles, index)
            ENTITY.FREEZE_ENTITY_POSITION(frozen_vehicle.vehicle, false)
            refresh_frozen_vehicles_menu_list()
        end)
    end
end
local function add_frozen_vehicle(vehicle)
    for index, frozen_vehicle in pairs(frozen_vehicles) do
        if frozen_vehicle.vehicle == vehicle then
            return
        end
    end
    local model = ENTITY.GET_ENTITY_MODEL(vehicle)
    local name = VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(model)
    table.insert(frozen_vehicles, {
        name=name,
        vehicle=vehicle
    })
    refresh_frozen_vehicles_menu_list()
    update_frozen_vehicles()
end
menu.action(vf, "冻结载具", {"freeze"}, "冻结当前载具", function()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    if vehicle then
        add_frozen_vehicle(vehicle)
    end
end)
frozen_vehicles_menu_list = menu.list(vf, "已冻结的载具")
local tick_counter = 0
util.create_tick_handler(function()
    if tick_counter % 1000 == 0 then
        update_frozen_vehicles()
    end
    tick_counter = tick_counter + 1
    return true
end)

menu.action(vehicle, "摧毁载具", {}, "", function ()
    menu.trigger_commands("destroyvehicle")
end)

------模组选项
Constructor_Lua = menu.list(module_list, "新版模组", {}, "")
    tzdzjb = menu.action(Constructor_Lua, "constructor", {"openconstructor"}, "", function()
        require "lib.daidailib.Constructor"
        menu.delete(tzdzjb)
    end)
XML_module = menu.list(module_list, "XML模组", {}, "")




--------------------任务选项
---functions
        function MP_INDEX()
            return "MP" .. util.get_char_slot() .. "_"
        end
        function IS_MPPLY(Stat)
            local Stats = {
                "MP_PLAYING_TIME",
            }

            for i = 1, #Stats do
                if Stat == Stats[i] then
                    return true
                end
            end

            if string.find(Stat, "MPPLY_") then
                return true
            else
                return false
            end
        end
        function ADD_MP_INDEX(Stat)
            if not IS_MPPLY(Stat) then
                Stat = MP_INDEX() .. Stat
            end
            return Stat
        end

        function STAT_SET_INT(Stat, Value)
            STATS.STAT_SET_INT(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
        end
        function STAT_SET_FLOAT(Stat, Value)
            STATS.STAT_SET_FLOAT(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
        end
        function STAT_SET_BOOL(Stat, Value)
            STATS.STAT_SET_BOOL(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
        end
        function STAT_SET_STRING(Stat, Value)
            STATS.STAT_SET_STRING(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
        end
        function STAT_SET_DATE(Stat, Year, Month, Day, Hour, Min)
            local DatePTR = memory.alloc(7*8) -- Thanks to help memory stuffs, aaronlink127#0127
            memory.write_int(DatePTR, Year)
            memory.write_int(DatePTR+8, Month)
            memory.write_int(DatePTR+16, Day)
            memory.write_int(DatePTR+24, Hour)
            memory.write_int(DatePTR+32, Min)
            memory.write_int(DatePTR+40, 0) -- Second
            memory.write_int(DatePTR+48, 0) -- Millisecond
            STATS.STAT_SET_DATE(util.joaat(ADD_MP_INDEX(Stat)), DatePTR, 7, true)
        end

        function STAT_SET_PACKED_BOOL(Stat, Value)
            STATS._SET_PACKED_STAT_BOOL(Stat, Value, util.get_char_slot())
        end
        function STAT_SET_INCREMENT(Stat, Value)
            STATS.STAT_INCREMENT(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
        end

        function STAT_GET_INT(Stat)
            local IntPTR = memory.alloc_int()
            STATS.STAT_GET_INT(util.joaat(ADD_MP_INDEX(Stat)), IntPTR, -1)
            return memory.read_int(IntPTR)
        end
        function STAT_GET_FLOAT(Stat)
            local FloatPTR = memory.alloc_int()
            STATS.STAT_GET_FLOAT(util.joaat(ADD_MP_INDEX(Stat)), FloatPTR, -1)
            return tonumber(string.format("%.3f", memory.read_float(FloatPTR)))
        end
        function STAT_GET_BOOL(Stat)
            if STAT_GET_INT(Stat) == 0 then
                return "false"
            elseif STAT_GET_INT(Stat) == 1 then
                return "true"
            else
                return "STAT_UNKNOWN"
            end 
        end
        function STAT_GET_STRING(Stat)
            return STATS.STAT_GET_STRING(util.joaat(ADD_MP_INDEX(Stat)), -1)
        end
        function STAT_GET_DATE(Stat, Sort)
            local DatePTR = memory.alloc(7*8)
            STATS.STAT_GET_DATE(util.joaat(ADD_MP_INDEX(Stat)), DatePTR, 7, true)
            local Add = 0
            if Sort == "Year" then
                Add = 0
            elseif Sort == "Month" then
                Add = 8
            elseif Sort == "Day" then
                Add = 16
            elseif Sort == "Hour" then
                Add = 24
            elseif Sort == "Min" then
                Add = 32
            end
            return memory.read_int(DatePTR+Add)
        end

        function SET_INT_GLOBAL(Global, Value)
            memory.write_int(memory.script_global(Global), Value)
        end
        function SET_FLOAT_GLOBAL(Global, Value)
            memory.write_float(memory.script_global(Global), Value)
        end

        function GET_INT_GLOBAL(Global)
            return memory.read_int(memory.script_global(Global))
        end

        function SET_PACKED_INT_GLOBAL(StartGlobal, EndGlobal, Value)
            for i = StartGlobal, EndGlobal do
                SET_INT_GLOBAL(262145 + i, Value)
            end
        end

        function SET_INT_LOCAL(Script, Local, Value)
            if memory.script_local(Script, Local) ~= 0 then
                memory.write_int(memory.script_local(Script, Local), Value)
            end
        end
        function SET_FLOAT_LOCAL(Script, Local, Value)
            if memory.script_local(Script, Local) ~= 0 then
                memory.write_float(memory.script_local(Script, Local), Value)
            end
        end

        function GET_INT_LOCAL(Script, Local)
            if memory.script_local(Script, Local) ~= 0 then
                local Value = memory.read_int(memory.script_local(Script, Local))
                if Value ~= nil then
                    return Value
                end
            end
        end

        function TELEPORT(X, Y, Z)
            PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), X, Y, Z)
        end
        function SET_HEADING(Heading)
            ENTITY.SET_ENTITY_HEADING(players.user_ped(), Heading)
        end

        function IsWorking(IsAddNewLine)
            local State = "" -- If global and local variables have been changed due to the GTAO update then 
            if util.is_session_started() then
                if GET_INT_LOCAL("freemode", 3504) ~= util.joaat("lr_prop_carkey_fob") then -- freemode.c, joaat("lr_prop_carkey_fob")
                    State = "[NOT WORKING]"
                    if IsAddNewLine then
                        State = State .. "\n\n"
                    end
                end
            end
            return State
        end

        function RGB(R, G, B, A) -- Credit goes to LanceScript
            local Color = {}
            Color.r = R
            Color.g = G
            Color.b = B
            Color.a = A
            return Color
        end

        function HelpMsgBeingDisplayed(Label) -- Credit goes to jerry123#4508
            HUD.BEGIN_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(Label) -- Labels List: https://gist.githubusercontent.com/aaronlink127/afc889be7d52146a76bab72ede0512c7/raw
            return HUD.END_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(0)
        end

        function IS_PED_PLAYER(Ped)
            if PED.GET_PED_TYPE(Ped) >= 4 then
                return false
            else
                return true
            end
        end

        function FORCE_CLOUD_SAVE()
            STATS.STAT_SAVE(0, 0, 3, 0) -- Same as menu.trigger_commands("forcecloudsave"), Credit goes to https://github.com/jonaaa20/RecoverySuite
            util.yield(1500)
            util.arspinner_enable()
            util.yield(4500)
            util.arspinner_disable()
        end

        function IA_MENU_OPEN()
            PAD._SET_CONTROL_NORMAL(0, 244, 1)
            util.yield(200)
        end
        function IA_MENU_UP(Num)
            for i = 1, Num do
                PAD._SET_CONTROL_NORMAL(0, 172, 1)
                util.yield(200)
            end
        end
        function IA_MENU_DOWN(Num)
            for i = 1, Num do
                PAD._SET_CONTROL_NORMAL(0, 173, 1)
                util.yield(200)
            end
        end
        function IA_MENU_ENTER(Num)
            for i = 1, Num do
                PAD._SET_CONTROL_NORMAL(0, 176, 1)
                util.yield(200)
            end
        end

    ---
    --- Notification Settings
        local NotiIconSorts = {
            { "HC Logo", "Logo" },
            { "Lester" , "CHAR_LESTER" },
            { "Legend Of Heist", "CHAR_ALL_PLAYERS_CONF" },
            { "Skull Head", "CHAR_LESTER_DEATHWISH" },
            { "Warstock", "CHAR_MILSITE" },
            { "Black R*", "CHAR_MP_FM_CONTACT" },
            { "R* Social Club", "CHAR_SOCIAL_CLUB" },   
        }
        local NotiColorSorts = {
            { "White", 160 },
            { "Black", 140 },
            { "Red", 6 },
            { "Orange", 130 },
            { "Yellow", 180 },
            { "Mint", 200 },
            { "Green", 184 },
            { "Light Blue", 40 },
        }
		

        INT_MIN = -2147483648
        INT_MAX = 2147483647


        util.on_stop(function()

        end)
-----------------------------------------------------------目标点--------------------

------------------------佩里科岛
perrico_island = menu.list(Task_robbery, "佩里科岛", {""}, "")
    menu.action(perrico_island, "呼叫虎鲸", {}, "", function()
        SET_INT_GLOBAL(2793044 + 954, 1)
    end)	
    island_casino_Task_setting = menu.list(perrico_island, "任务设定", {""}, "")
        menu.action(island_casino_Task_setting, "完成所有准备任务", {}, "设置完成后需离开虎鲸重新进入", function()
            STAT_SET_INT("H4_MISSIONS", 65413)
            STAT_SET_INT("H4CNF_APPROACH", -1)
            STAT_SET_INT("H4CNF_BS_ENTR", 63)
            STAT_SET_INT("H4CNF_BS_GEN", 63)
            STAT_SET_INT("H4CNF_WEP_DISRP", 3)
            STAT_SET_INT("H4CNF_ARM_DISRP", 3)
            STAT_SET_INT("H4CNF_HEL_DISRP", 3)
            STAT_SET_INT("H4CNF_TARGET", 5)
            util.toast("[呆呆 提示] \n设置完成，请离开虎鲸重新进入")
        end)
        menu.action(island_casino_Task_setting, "重置面板", {}, "设置完成后需离开虎鲸重新进入", function()
            STAT_SET_INT("H4_MISSIONS", 0)
            STAT_SET_INT("H4_PROGRESS", 0)
            STAT_SET_INT("H4CNF_APPROACH", 0)
            STAT_SET_INT("H4CNF_BS_ENTR", 0)
            STAT_SET_INT("H4CNF_BS_GEN", 0)
            STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 0)
            STAT_SET_INT("H4CNF_TARGET", -1)
            util.toast("[呆呆 提示] \n设置完成，请离开虎鲸重新进入")
        end)
        
    TELEPORT_island = menu.list(perrico_island, "地点传送", {}, "")    
	menu.action(TELEPORT_island, "任务面板(虎鲸)", {}, "先呼叫潜艇", function()
        if STAT_GET_INT("IH_SUB_OWNED") == 0 then
        else
            TELEPORT(1561.2369, 385.8771, -49.689915)
            SET_HEADING(175)
            STAT_SET_INT("H4_PROGRESS", 131055)
        end
	;  end)
    menu.action(TELEPORT_island, "传送到大门(外侧)", {}, "", function()
        TELEPORT(4974.189, -5703.279, 19.898539)
    ;  end)
    menu.action(TELEPORT_island, "传送到大门(内测)", {}, "", function()
        TELEPORT(4993.189, -5720.279, 19.898539)
    ;  end)
    menu.action(TELEPORT_island, "主要目标", {}, "", function()
            TELEPORT(5006.7, -5756.2, 14.8)
            SET_HEADING(145)
    ;  end)
    menu.action(TELEPORT_island, "次要目标", {}, "", function()
        TELEPORT(4999.764160, -5749.863770, 14.840000)
    end)
    menu.action(TELEPORT_island, "机场(逃离)", {}, "", function()
        TELEPORT(4443.189, -4510.279, 4.898539)
    ;  end)
    menu.toggle_loop(TELEPORT_island, "传送到大海", {}, "", function()
        TELEPORT(3235, -4938, 56)
        util.yield(1000)
    ;  end)

    fenhong = menu.list(perrico_island, "分红调整", {""}, "分红界面出现时再修改")
        menu.action(fenhong, "全员100%分红", {""}, "", function()
            SET_INT_GLOBAL(1977693 + 823 + 56 + 1, 100)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 2, 100)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 3, 100)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 4, 100)
        end)
        menu.action(fenhong, "全员135%分红", {""}, "分红界面出现时再修改", function()
            SET_INT_GLOBAL(1977693 + 823 + 56 + 1, 135)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 2, 135)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 3, 135)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 4, 135)
        end)
        menu.action(fenhong, "自保分红", {}, "全员135%，自己60%", function()
            SET_INT_GLOBAL(1977693 + 823 + 56 + 1, 60)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 2, 135)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 3, 135)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 4, 135)
        end)
        island_custom_dividends = menu.list(fenhong, "自定义分红", {}, "")
            menu.toggle_loop(island_custom_dividends, "开启", {}, "", function()
                SET_INT_GLOBAL(1977693 + 823 + 56 + 1, menu.get_value(island_dividends))
                SET_INT_GLOBAL(1977693 + 823 + 56 + 2, menu.get_value(island_dividends))
                SET_INT_GLOBAL(1977693 + 823 + 56 + 3, menu.get_value(island_dividends))
                SET_INT_GLOBAL(1977693 + 823 + 56 + 4, menu.get_value(island_dividends))
            end)
            island_dividends = menu.slider(island_custom_dividends, "分红金额", {"hccphostcut"}, "(%)", 0, 1000, 100, 5, function(); end)



    menu.list_action(perrico_island, "抢劫难度", {}, "", {
        { "正常", {"normal"} },
        { "困难", {"hard"} },
            }, function(Index)
        if Index == 1 then
            STAT_SET_INT("H4_PROGRESS", 126823)
        elseif Index == 2 then
            STAT_SET_INT("H4_PROGRESS", 131055)
        end
    end)
    menu.toggle_loop(perrico_island, "跳过下水道切割", {}, "", function() 
        if IS_HELP_MSG_DISPLAYED("UT_WELD_PROMPT") then -- "~s~Press ~INPUT_CONTEXT~ to cut through the grill."
            PAD._SET_CONTROL_NORMAL(2, 51, 1)
        elseif GET_INT_LOCAL("fm_mission_controller_2020", 26746) == 4 then -- Local from https://www.unknowncheats.me/forum/3389282-post1.html  
            SET_INT_LOCAL("fm_mission_controller_2020", 26746, 6)
        end
    end)
    menu.toggle_loop(perrico_island, "跳过指纹锁", {}, "", function() 
        if GET_INT_LOCAL("fm_mission_controller_2020", 22032) == 4 then -- Locals from https://www.unknowncheats.me/forum/3418914-post13398.html, Values from Heist Control for Nightfall
            SET_INT_LOCAL("fm_mission_controller_2020", 22032, 5)
        end
    end)
    menu.action(perrico_island, "快速切开玻璃", {}, "切割时使用", function()
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 27985 + 3, 100)
        end, function()
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 27985 + 3, 0)
    end)
    menu.toggle_loop(perrico_island, "绕过切割机发热", {}, "切割前开启", function()
        SET_FLOAT_LOCAL("fm_mission_controller_2020", 27985 + 4, 0)
    end)
    menu.action(perrico_island, "杀死队友", {}, "炸死队友，包括自己(无敌可免疫)", function()
        local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
            for _, pid in pairs(playerList) do
                local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                explodePlayer(playerPed, false, expSettings)
            end
    end)

advanced_options_island = menu.list(perrico_island, "高级选项", {""}, "")
    menu.action(advanced_options_island, "一键完成任务", {}, "", function()
        menu.trigger_commands("scripthost")

        SET_INT_LOCAL("fm_mission_controller_2020", 42279 + 1, 51338752)
        SET_INT_LOCAL("fm_mission_controller_2020", 42279 + 1375 + 1, 50)
    end)
    menu.action(advanced_options_island, "一键结束动画", {}, "仅限单人上岛使用", function()
        menu.trigger_commands("skipcutscene")
    end)
        

------------------赌场选项
casino = menu.list(Task_robbery, "名钻赌场", {""}, "")
    casino_Task_setting = menu.list(casino, "任务设定", {""}, "")
        menu.action(casino_Task_setting, "完成所有准备任务", {}, "目标：钻石\n方式：气势汹汹", function()
            STAT_SET_INT("CAS_HEIST_FLOW", -1)
            STAT_SET_INT("H3_LAST_APPROACH", 0)
            STAT_SET_INT("H3OPT_APPROACH", 3)
            STAT_SET_INT("H3_HARD_APPROACH", 0)
            STAT_SET_INT("H3OPT_TARGET", 3)
            STAT_SET_INT("H3OPT_POI", 1023)
            STAT_SET_INT("H3OPT_ACCESSPOINTS", 2047)
            STAT_SET_INT("H3OPT_CREWWEAP", 4)
            STAT_SET_INT("H3OPT_CREWDRIVER", 3)
            STAT_SET_INT("H3OPT_CREWHACKER", 4)
            STAT_SET_INT("H3OPT_DISRUPTSHIP", 3)
            STAT_SET_INT("H3OPT_BODYARMORLVL", -1)
            STAT_SET_INT("H3OPT_KEYLEVELS", 2)
            STAT_SET_INT("H3OPT_BITSET1", 799)
            STAT_SET_INT("H3OPT_BITSET0", 3670102)
        end)
    menu.action(casino_Task_setting, "重置面板", {}, "", function()
        STAT_SET_INT("H3_LAST_APPROACH", 0)
            STAT_SET_INT("H3OPT_APPROACH", 0)
            STAT_SET_INT("H3_HARD_APPROACH", 0)
            STAT_SET_INT("H3OPT_TARGET", 0)
            STAT_SET_INT("H3OPT_POI", 0)
            STAT_SET_INT("H3OPT_ACCESSPOINTS", 0)
            STAT_SET_INT("H3OPT_BITSET1", 0)
            STAT_SET_INT("H3OPT_CREWWEAP", 0)
            STAT_SET_INT("H3OPT_CREWDRIVER", 0)
            STAT_SET_INT("H3OPT_CREWHACKER", 0)
            STAT_SET_INT("H3OPT_WEAPS", 0)
            STAT_SET_INT("H3OPT_VEHS", 0)        
            STAT_SET_INT("H3OPT_DISRUPTSHIP", 0)
            STAT_SET_INT("H3OPT_BODYARMORLVL", 0)
            STAT_SET_INT("H3OPT_KEYLEVELS", 0)
            STAT_SET_INT("H3OPT_MASKS", 0)
            STAT_SET_INT("H3OPT_BITSET0", 0)
    end)
    TELEPORT_casino = menu.list(casino, "地点传送", {}, "")
        menu.action(TELEPORT_casino, "计划面板(游戏厅)", {}, "先进游戏厅", function()
            TELEPORT(2711.773, -369.458, -54.781)
        end)
        menu.action(TELEPORT_casino, "车库出口(游戏厅)", {}, "先进游戏厅", function()
            TELEPORT(2677.237, -361.494, -55.187)
        end)
        menu.action(TELEPORT_casino, "门口(赌场)", {}, "", function()
            TELEPORT(917.24634, 48.989567, 80.89892)
        end)
        menu.action(TELEPORT_casino, "员工大厅(赌场)", {}, "", function()
            TELEPORT(965.14856, -9.05023, 80.63045)
        end)
        menu.action(TELEPORT_casino, "音乐柜", {}, "", function()
            TELEPORT(997.5346, 84.51491, 80.990555)
        end)
        menu.action(TELEPORT_casino, "废物处理间(赌场)", {}, "", function()
            TELEPORT(2542.052, -214.3084, -58.722965)
        end)
        menu.action(TELEPORT_casino, "员工大门(赌场)", {}, "", function()
            TELEPORT(2547.9192, -273.16754, -58.723003)
        end)
        menu.action(TELEPORT_casino, "双人刷卡点(赌场)", {}, "", function()
            TELEPORT(2465.4746, -279.2276, -70.694145)
        end)
        menu.action(TELEPORT_casino, "金库内部(赌场)", {}, "", function()
            TELEPORT(2515.1252, -238.91661, -70.73713)
        end)
        menu.action(TELEPORT_casino, "库外部(赌场)", {}, "", function()
            TELEPORT(2497.5098, -238.50768, -70.7388)
        end)
        menu.action(TELEPORT_casino,"小金库(赌场)", {}, "", function()
            TELEPORT(2520.8645, -286.30685, -58.723007)
        end)

    fenhong1 = menu.list(casino, "分红调整", {""}, "")
        menu.action(fenhong1, "全员100%分红", {}, "分红界面出现时再修改", function()
            SET_INT_GLOBAL(1970895 + 1497 + 736 + 92+1, 100)
                SET_INT_GLOBAL(1970895 + 1497 + 736 + 92+2, 100)
                SET_INT_GLOBAL(1970895 + 1497 + 736 + 92+3, 100)
                SET_INT_GLOBAL(1970895 + 1497 + 736 + 92+4, 100)
                STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 5)
            ;  end)
        menu.action(fenhong1, "全员135%分红", {}, "分红界面出现时再修改", function()
            SET_INT_GLOBAL(1970895 + 1497 + 736 + 92+1, 135)
                SET_INT_GLOBAL(1970895 + 1497 + 736 + 92+2, 135)
                SET_INT_GLOBAL(1970895 + 1497 + 736 + 92+3, 135)
                SET_INT_GLOBAL(1970895 + 1497 + 736 + 92+4, 135)
                STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 5)
            ;  end)
        menu.action(fenhong1, "自保分红", {}, "全员135%，自己60%", function()
            SET_INT_GLOBAL(1970895 + 1497 + 736 + 92+1, 60)
                SET_INT_GLOBAL(1970895 + 1497 + 736 + 92+2, 135)
                SET_INT_GLOBAL(1970895 + 1497 + 736 + 92+3, 135)
                SET_INT_GLOBAL(1970895 + 1497 + 736 + 92+4, 135)
                STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 5)
            ;  end)
        casino_custom_dividends = menu.list(fenhong1, "自定义分红", {}, "")
            menu.toggle_loop(casino_custom_dividends, "开启", {}, "", function()
                SET_INT_GLOBAL(1977693 + 823 + 56 + 1, menu.get_value(casino_dividends))
                SET_INT_GLOBAL(1977693 + 823 + 56 + 2, menu.get_value(casino_dividends))
                SET_INT_GLOBAL(1977693 + 823 + 56 + 3, menu.get_value(casino_dividends))
                SET_INT_GLOBAL(1977693 + 823 + 56 + 4, menu.get_value(casino_dividends))
            end)
            casino_dividends = menu.slider(casino_custom_dividends, "分红金额", {"hccphostcut"}, "(%)", 0, 1000, 100, 5, function(); end)


    menu.action(casino, "杀死队友", {}, "炸死队友，包括自己(无敌可免疫)", function()
        local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
            for _, pid in pairs(playerList) do
                local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                explodePlayer(playerPed, false, expSettings)
            end
    end)
    advanced_options_casino = menu.list(casino, "高级选项", {""}, "")
        menu.action(advanced_options_casino, "一键完成任务", {}, "只有气势汹汹可以一键完成任务", function()
            menu.trigger_commands("scripthost")
            SET_INT_LOCAL("fm_mission_controller", 19707 + 1741, 151)
            SET_INT_LOCAL("fm_mission_controller", 19707 + 2686, 10000000)
            SET_INT_LOCAL("fm_mission_controller", 27471 + 859, 99999)
            SET_INT_LOCAL("fm_mission_controller", 31585 + 69, 99999)
            SET_INT_LOCAL("fm_mission_controller", 31585 + 97, 79)
        end)

doomsday = menu.list(Task_robbery, "末日豪杰", {""}, "")
    doomsday_Task_setting = menu.list(doomsday, "任务设定", {""}, "")
        menu.action(doomsday_Task_setting, "数据泄露 I", {}, "", function()
            STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 503)
            STAT_SET_INT("GANGOPS_HEIST_STATUS", -229383)
            STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)
        end)
        menu.action(doomsday_Task_setting, "波格丹危机 II", {}, "", function()
            STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 240)
            STAT_SET_INT("GANGOPS_HEIST_STATUS", -229378)
            STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)
        end)
        menu.action(doomsday_Task_setting, "末日降临 III", {}, "", function()
            STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 16368)
            STAT_SET_INT("GANGOPS_HEIST_STATUS", -229380)
            STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)
        end)
        menu.action(doomsday_Task_setting, "重置任务面板", {}, "切换战局生效", function()
            STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 240)
            STAT_SET_INT("GANGOPS_HEIST_STATUS", 0)
            STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)
            util.toast("[呆呆 提示] \n重置完成,切换战局生效")
        end)
    doomsday_Task_tp = menu.list(doomsday, "地点传送", {""}, "")
        menu.action(doomsday_Task_tp, "抢劫屏幕", {}, "", function()
            TELEPORT(350.69284, 4872.308, -60.794243)
            SET_HEADING(-50)
        end)

    doomsday_Task_fenhong = menu.list(doomsday, "分红设置", {""}, "")
        menu.action(doomsday_Task_fenhong, "全员100%分红", {}, "分红界面出现时再修改", function()
            SET_INT_GLOBAL(1966831 + 812 + 50 + 1, 100)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 2, 100)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 3, 100)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 4, 100)
        end)
        menu.action(doomsday_Task_fenhong, "全员135%分红", {}, "分红界面出现时再修改", function()
            SET_INT_GLOBAL(1966831 + 812 + 50 + 1, 135)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 2, 135)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 3, 135)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 4, 135)
        end)
        menu.action(doomsday_Task_fenhong, "自保分红", {}, "分红界面出现时再修改", function()
            SET_INT_GLOBAL(1966831 + 812 + 50 + 1, 60)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 2, 135)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 3, 135)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 4, 135)
        end)
        
        local doomsday_dividends = 25
        doomsday_custom_dividends = menu.list(doomsday_Task_fenhong, "自定义分红", {}, "")
            menu.toggle_loop(doomsday_custom_dividends, "开启", {}, "", function()
                SET_INT_GLOBAL(1977693 + 823 + 56 + 1, menu.get_value(doomsday_dividends))
                SET_INT_GLOBAL(1977693 + 823 + 56 + 2, menu.get_value(doomsday_dividends))
                SET_INT_GLOBAL(1977693 + 823 + 56 + 3, menu.get_value(doomsday_dividends))
                SET_INT_GLOBAL(1977693 + 823 + 56 + 4, menu.get_value(doomsday_dividends))
            end)
            doomsday_dividends = menu.slider(doomsday_custom_dividends, "分红金额", {"hcdoomsdaycut"}, "(%)", 0, 1000, 25, 5, function(); end)
---------------------------------------------------------

    menu.toggle_loop(Task_robbery, "达克斯冷却", {}, "移除达克斯工作的冷却时间", function()
        STATS.STAT_SET_INT(util.joaat("MP"..util.get_char_slot().."_XM22JUGGALOWORKCDTIMER"), -1, true)
    end)

        
--------------------------------赌场刷钱
casino_brush_money = menu.list(Task_robbery, "赌场刷钱", {""}, "")
    casino_destination = menu.list(casino_brush_money, "目标传送", {""}, "")
        menu.action(casino_destination, "传送到赌场门口", {}, "", function()
            TELEPORT(924.5333, 46.603252, 81.10639)
        end)
        menu.action(casino_destination, "传送到老虎机", {}, "", function()
            TELEPORT(1114, 230, -50)
        end)
        menu.action(casino_destination, "传送到筹码兑换台", {}, "", function()
            TELEPORT(1116.0076, 219.90002, -49.435116)
        end)
        menu.action(casino_destination, "传送到轮盘赌场", {}, "", function()
            TELEPORT(1133.4238, 263.72913, -51.03577)
        end)

    menu.toggle(casino_brush_money, "老虎机中奖", {}, "", function(on)
        if on then
            menu.trigger_commands("rigslotmachines jackpot")
            util.show_corner_help("开始你的表演")
            util.toast("[呆呆 提示] \n24小时内总收益别超过$5000000")
        else
            menu.trigger_commands("rigslotmachines off")
        end
    end)
    menu.toggle(casino_brush_money, "轮盘赌场中奖", {}, "请将赌注全下25", function(on)
        if on then
            menu.trigger_commands("rigroulette 25")
            util.show_corner_help("请将赌注全下25")
            util.toast("[呆呆 提示] \n24小时内总收益别超过$5000000")
        else
            menu.trigger_commands("rigroulette off")
        end
    end)

menu.action(Task_robbery, "将拾取物传送到自己", {}, "", function()
    local counter = 0
    local pos = players.get_position(players.user())
    for _, pickup in entities.get_all_pickups_as_handles() do
        ENTITY1.SET_ENTITY_COORDS(pickup, pos, false, false, false, false)
        counter += 1
        util.yield()
    end
    if counter == 0 then
        util.toast("没有发现可捡拾物. :/")
    else
        util.toast("已传送 ".. tostring(counter) .." 个拾取物.")
    end
end)



-----保护选项(防护选项)


menu.divider(protection, "防护类型")

---------------------------------一级防护
protex = menu.list(protection, "防护", {}, "")------第一list
    menu.toggle_loop(protex, "阻止交易错误 ", {}, "阻止一些脚本，利用破坏车辆的方法，让你出现交易错误", function()
        if util.spoof_script("am_destroy_veh", SCRIPT.TERMINATE_THIS_THREAD) then
            util.toast("检测到破坏车辆脚本。阻止了该脚本功能继续进行...")
        end
    end)

    bug_me_not = false
    menu.toggle(protection, "自动踢出广告机", {}, "自动踢出广告机/事件检测玩家", function(on)
        bug_me_not = on
    end)

    is_loading = false
    local racist_dict = {"nigg", "jew"}
    local homophobic_dict = {"fag", "tranny"}
    local stupid_detections_dict = adwords
    chat.on_message(function(packet_sender, message_sender, text, team_chat)
        text = string.lower(text)
        local name = players.get_name(message_sender)

            if bug_me_not then 
                for _,word in pairs(stupid_detections_dict) do 
                    if string.contains(text, word) then
                        menu.trigger_commands("kick " .. name)
                    end
                end
            end
    end)


load_kick_XP = menu.action(protection, "开启自动踢出XP魔怔人", {}, "", function()
    util.toast("[呆呆 提示] \n自动踢出XP魔怔人已准备就绪")
    require "lib.daidailib.autokickXP"
    menu.delete(load_kick_XP)
end)

------------------------------------------------攻击嘲讽-------------------------
    menu.toggle(protex, "攻击嘲讽", {}, "", function(state)
        cf = state
        _U_hack_list={}
        while cf do
            util.yield(0)
            for pid=0,31 do
                if pid~= PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID) then
                    if players.is_marked_as_attacker(pid,1 << 0x03) or players.is_marked_as_attacker(pid,1 << 0x04) or players.is_marked_as_attacker(pid,1 << 0x05) or players.is_marked_as_attacker(pid,1 << 0x0C) or players.is_marked_as_attacker(pid,1 << 0x0D) or players.is_marked_as_attacker(pid,1 << 0x0E) then
                        if not _U_hack_list[pid+1] then
                            chat.send_message(PLAYER.GET_PLAYER_NAME(pid)..chaofeng..author,false,true,true)
                            _U_hack_list[pid+1]=true
                        end
                    else
                        _U_hack_list[pid+1]=false
                    end
                end
            end
        end
    end)
------------------------------------------------攻击嘲讽-------------------------

	menu.action(protex, "强制停止所有声音", {"stopsounds"}, "", function()
		for i=-1,100 do
			AUDIO.STOP_SOUND(i)
			AUDIO.RELEASE_SOUND_ID(i)
		end
	end)

clear_list = menu.list(protex, "清除选项", {}, "")
    menu.action(clear_list, "移除附加物", {""}, "包括模型", function()
        if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
            menu.trigger_commands("mpmale")
        else
            menu.trigger_commands("mpfemale")
        end
    end)
    menu.click_slider(clear_list,"清理实体", {""}, "1 = NPC, 2 = 载具, 3 = 实体, 4 = 拾取物, 5 =所有", 1, 5, 1, 1, function(on_change)
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
                util.toast("NPC清除完成")
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
                util.toast("载具清除完成")
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
                util.toast("实体已清除")
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
                util.toast("拾取物已清除")
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
                util.toast("清理完成")
                return
            end
    end)
    menu.action(clear_list, "普通清除", {"superclean"}, "主要清除ped,载具", function(on_click)
        local ct = 0
        for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
            entities.delete_by_handle(ent)
            ct = ct + 1
        end
        for k,ent in pairs(entities.get_all_peds_as_handles()) do
            if not PED.IS_PED_A_PLAYER(ent) then
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                entities.delete_by_handle(ent)
            end
                ct = ct + 1
            end
    end)

    menu.action(clear_list, "超级清除", {"superclean2"}, "清除所有", function()
        chaojiqingchu()
    end)

pool_limiter = menu.list(protex, "实体池限制", {}, "")
    ped_limit = 175
    menu.slider(pool_limiter, "Ped池限制", {"pedslimit"}, "默认为175", 0, 256, 175, 1, function(amount)
        ped_limit = amount
    end)
    veh_limit = 150
    menu.slider(pool_limiter, "载具池限制", {"vehlimit"}, "默认为150", 0, 300, 150, 1, function(amount)
        veh_limit = amount
    end)
    obj_limit = 500
    menu.slider(pool_limiter, "物体池限制", {"objlimit"}, "默认为500", 0, 2300, 500, 1, function(amount)
        obj_limit = amount
    end)
    menu.toggle_loop(pool_limiter, "启用实体池限制", {}, "", function()
        entity_limit()
    end)

menu.toggle(protex, "防崩视角", {"acc"}, "", function(on_toggle)
	if on_toggle then
		menu.trigger_commands("anticrashcam on")
		menu.trigger_commands("potatomode on")
		else
		menu.trigger_commands("anticrashcam off")
		menu.trigger_commands("potatomode off")
		end
end)
mk2 = menu.list(protex, "mk2拦截", {}, "")
    menu.toggle(mk2, "开启报应", { "mk2KarmaBool" },"自动处理附近mk2用户载具",
        function(on)
            if on then
                oppressorKarma = true
                oppKarma()
            else
                oppressorKarma = false
            end
        end)
    menu.toggle(mk2, "目标朋友", { "mk2TargetFriendsBool" },
    "这也将针对你的朋友.",
    function(on)
        if on then
            oppressorFriendKarma = true
        else
            oppressorFriendKarma = false
        end
    end)
        menu.toggle(mk2, "目标你自己", { "mk2TargetYourselfBool" },
        "这也将针对你自己.",
        function(on)
            if on then
                oppressorYourselfKarma = true
            else
                oppressorYourselfKarma = false
            end
        end)
    local optionsMK2Karma <const> = { { "[删除]" }, { "[击杀]" }, { "[删除+击杀]" }, { "[删除+发短信]" } }
    menu.list_select(mk2, "报应方式", {}, "选择一种方式",
        optionsMK2Karma, 1, function(opt)
        local gm <const> = { "[Remove]", "[Kill]", "[Remove + Kill]", "[Remove + Send SMS]" }
        selectedKarmaMK2 = gm[opt]
    end)
    get_vtable_entry_pointer = function(address, index)
        return memory.read_long(memory.read_long(address) + (8 * index))
    end
    get_sub_handling_types = function(vehicle, type)
        local veh_handling_address = memory.read_long(entities.handle_to_pointer(vehicle) + 0x918)
        local sub_handling_array = memory.read_long(veh_handling_address + 0x0158)
        local sub_handling_count = memory.read_ushort(veh_handling_address + 0x0160)
        local types = {registerd = sub_handling_count, found = 0}
        for i = 0, sub_handling_count - 1, 1 do
            local sub_handling_data = memory.read_long(sub_handling_array + 8 * i)
            if sub_handling_data ~= 0 then
                local GetSubHandlingType_address = get_vtable_entry_pointer(sub_handling_data, 2)
                local result = util.call_foreign_function(GetSubHandlingType_address, sub_handling_data)
                if type and type == result then return sub_handling_data end
                types[#types+1] = {type = result, address = sub_handling_data}
                types.found = types.found + 1
            end
        end
        if type then return nil else return types end
    end

menu.divider(protex, "网络事件")
	menu.toggle(protex, "阻止网络事件", {}, "阻止网络事件传输", function(on_toggle)
		local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
		local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
		if on_toggle then
			menu.trigger_command(BlockNetEvents)
			
		else
			menu.trigger_command(UnblockNetEvents)
			
		end
	end)
	menu.toggle(protex, "阻止传入", {}, "阻止网络事件传入", function(on_toggle)
		local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
		local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
		if on_toggle then
			menu.trigger_command(BlockIncSyncs)
			
		else
			menu.trigger_command(UnblockIncSyncs)
			
		end
	end)
	menu.toggle(protex, "阻止传出", {}, "阻止网络事件传出", function(on_toggle)
		if on_toggle then
			
			menu.trigger_commands("desyncall on")
		else
			
			menu.trigger_commands("desyncall off")
		end
	end)

-------------------------------二级防护
renwu_disable = menu.toggle_loop(protection, "禁用阻止实体轰炸", {"disableBlockentitybombing"}, "将在任务中自动禁用阻止实体轰炸,防止任务卡关.", function()
    local EntitySpam = menu.ref_by_path("Online>Protections>Block Entity Spam>Block Entity Spam")
    if NETWORK.NETWORK_IS_ACTIVITY_SESSION() == true then
        if not menu.get_value(EntitySpam) then return end
        menu.trigger_command(EntitySpam, "off")
    else
        if menu.get_value(EntitySpam) then return end
        menu.trigger_command(EntitySpam, "on")
    end
end)
menu.set_value(renwu_disable,true)


r_admin = menu.list(protection, "R*管理人员加入选项", {}, "")
    menu.toggle(r_admin, "R*管理人员加入提示", {}, "", function(on)
        admin_bail = on
        while admin_bail do
            if util.is_session_started() then
                for _, pid in players.list(false, true, true) do 
                    if players.is_marked_as_admin(pid) then 
                        notify("检测到管理员加入哦！")
                    end    
                end
            end
            util.yield()
        end
    end)
local admin_bail = false
    menu.toggle(r_admin, "R*管理人员加入反应", {"adminbail"}, "当管理员加入时自动加入新战局", function(on)
        admin_bail = on
        while admin_bail do
            if util.is_session_started() then
                for _, pid in players.list(false, true, true) do 
                    if players.is_marked_as_admin(pid) then 
                        notify("检测到管理员！5秒后加入新战局！")
                    util.yield(5000)
                    menu.trigger_commands("go public")
                    end    
                end
            end
            util.yield()
        end
    end)

    local lastMsg = ""
    local lastNotification <const> = newTimer()
    local format = "笼子物体来自 %s"
    menu.toggle_loop(protection, "防笼子", {"interceptlz"}, "请不要在任务中开启", function()
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
local block_spec_syncs
block_spec_syncs = menu.toggle_loop(protection, "阻止观看同步", {}, "阻止所有观看你的人的同步.", function()
    for _, pid in players.list(false, true, true) do
        local ped_dist = v3.distance(players.get_position(players.user()), players.get_position(pid))
        if v3.distance(players.get_position(players.user()), players.get_cam_pos(pid)) < 25.0 and ped_dist > 30.0 or players.get_spectate_target(pid) == players.user() then
            local outgoingSyncs = menu.ref_by_rel_path(menu.player_root(pid), "Outgoing Syncs>Block")
            outgoingSyncs.value = true
            pos = players.get_position(players.user())
            if v3.distance(pos, players.get_cam_pos(pid)) < 25.0 then
                repeat 
                    util.yield()
                until v3.distance(pos, players.get_cam_pos(pid)) > 50.0 
                outgoingSyncs.value = false
            end
        end
    end
end, function()
    for _, pid in players.list(false, true, true) do
        if players.exists(pid) then
            local outgoingSyncs = menu.ref_by_rel_path(menu.player_root(pid), "Outgoing Syncs>Block")
            outgoingSyncs.value = false
        end
    end
end)

anti_mugger = menu.list(protection, "拦截劫匪")
    menu.toggle_loop(anti_mugger, "自我", {}, "防止你被抢劫.", function()
        if NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
            local ped_netId = memory.script_local("am_gang_call", 63 + 10 + (0 * 7 + 1))
            local sender = memory.script_local("am_gang_call", 287)
            local target = memory.script_local("am_gang_call", 288)
            local player = players.user()
            util.spoof_script("am_gang_call", function()
                if (memory.read_int(sender) ~= player and memory.read_int(target) == player 
                and NETWORK.NETWORK_DOES_NETWORK_ID_EXIST(memory.read_int(ped_netId)) 
                and NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(memory.read_int(ped_netId))) then
                    local mugger = NETWORK.NET_TO_PED(memory.read_int(ped_netId))
                    entities.delete_by_handle(mugger)
                    util.toast("已阻止劫匪，呼叫劫匪的玩家是： " .. players.get_name(memory.read_int(sender)))
                end
            end)
        end
    end)
    menu.toggle_loop(anti_mugger, "其他人", {}, "防止他人被抢劫.", function()
        if NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
            local ped_netId = memory.script_local("am_gang_call", 63 + 10 + (0 * 7 + 1))
            local sender = memory.script_local("am_gang_call", 287)
            local target = memory.script_local("am_gang_call", 288)
            local player = players.user()
            util.spoof_script("am_gang_call", function()
                if memory.read_int(target) ~= player and memory.read_int(sender) ~= player
                and NETWORK.NETWORK_DOES_NETWORK_ID_EXIST(memory.read_int(ped_netId)) 
                and NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(memory.read_int(ped_netId)) then
                    local mugger = NETWORK.NET_TO_PED(memory.read_int(ped_netId))
                    entities.delete_by_handle(mugger)
                    util.toast("已阻止劫匪，呼叫劫匪的玩家是： " .. players.get_name(memory.read_int(sender)) .. " 被劫目标是 " .. players.get_name(memory.read_int(target)))
                end
            end)
        end
    end)
    menu.toggle_loop(anti_mugger, "劫匪检测", {"rdetection"}, "给劫匪绘制2D方框", function ()
        show_mugger()
    end)

menu.toggle(protection, "自闭模式", {"panic"}, "没错就是自闭", function(on_toggle)
    chickenmode(on_toggle)
end)
menu.toggle_loop(protection, "拦截粒子效果", {"interceptparticles"}, "", function()
    blockcrasheffect()
end)
menu.toggle_loop(protection, "拦截火焰效果", {"interceptfire"}, "", function()
    blockfireeffect()
end)
menu.toggle_loop(protection, "野兽防护", {}, "防止你被变成野兽，但也会阻止其他人的战局事件.", function()
    if util.spoof_script("am_hunt_the_beast", SCRIPT.TERMINATE_THIS_THREAD) then
        util.toast("检测到《 猎杀野兽 》事件生成。已终止事件...")
    end
end)

aimkarma = menu.list(protection, '瞄准惩罚', {'JSaimKarma'}, '对瞄准您的玩家做一些事情.')
    menu.toggle_loop(aimkarma, '套笼子', {''}, '打你就关起来', function()
        local userPed = players.user_ped()
        if playerIsTargetingEntity(userPed) and karma[userPed] then
            local karmaPid1 = karma[userPed].pid
            menu.trigger_commands("cage".. players.get_name(karmaPid1))
        end
    end)
    menu.toggle_loop(aimkarma, '射击', {'JSbulletAimKarma'}, '射击瞄准您的玩家.', function()
        local userPed = players.user_ped()
        if isAnyPlayerTargetingEntity(userPed) and karma[userPed] then
            local pos = ENTITY.GET_ENTITY_COORDS(karma[userPed].ped)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z + 0.1, 100, true, 100416529, userPed, true, false, 100.0)
            util.yield(getTotalDelay(expLoopDelay))
        end
    end)
    menu.toggle_loop(aimkarma, '爆炸', {'JSexpAimKarma'}, '使用您的自定义爆炸设置爆炸玩家.', function()
        local userPed = players.user_ped()
        if isAnyPlayerTargetingEntity(userPed) and karma[userPed] then
            explodePlayer(karma[userPed].ped, true, expSettings)
        end
    end)
    menu.toggle_loop(aimkarma, '禁用无敌', {'JSgodAimKarma'}, '如果开着无敌的玩家瞄准你,这会通过向前推动他们的游戏画面来禁用他们的无敌模式.', function()
        local userPed = players.user_ped()
        if isAnyPlayerTargetingEntity(userPed) and karma[userPed] and players.is_godmode(karma[userPed].pid) then
            local karmaPid = karma[userPed].pid
            util.trigger_script_event(1 << karmaPid, {-1388926377, karmaPid, -1762807505, math.random(0, 9999)})
        end
    end)
    menu.toggle_loop(aimkarma, '崩溃', {''}, '崩溃试图瞄准你的玩家', function()
        local userPed = players.user_ped()
        if playerIsTargetingEntity(userPed) and karma[userPed] then
            local karmaPid = karma[userPed].pid
    util.trigger_script_event(1 << karmaPid, { -555356783, karmaPid ,85952,99999,52682274855,526822745 })
    util.trigger_script_event(1 << karmaPid, { 526822748, karmaPid ,78552,99999 ,7949161,789454312})
    util.trigger_script_event(1 << karmaPid, { -66669983, karmaPid ,526822748,555555, math.random(80521,2959749521) })
    util.trigger_script_event(1 << karmaPid, { -1733737974, karmaPid ,789522 ,59486,48512151,-9545440,5845131,848153,math.random(1,2959749),189958})
    util.trigger_script_event(1 << karmaPid, { -1529596656, karmaPid ,795221,59486,48512151,-9545440 , math.random(1,2959749) })
    util.trigger_script_event(1 << karmaPid, { -8965204809, karmaPid ,795221,59486,48512151,-9545440 })
        end
    end)
    menu.toggle_loop(aimkarma, '发送到海滩', {''}, '发送试图瞄准你的玩家', function()
        local userPed = players.user_ped()
        if playerIsTargetingEntity(userPed) and karma[userPed] then
            local karmaPid = karma[userPed].pid
            util.trigger_script_event(1 << karmaPid, {330622597 ,1, 0, 0, 4,0,karmaPid, karmaPid})
        end
    end)
      menu.toggle_loop(aimkarma, '全局崩溃', {''}, '崩溃整个战局', function()
            local userPed = players.user_ped()
            if playerIsTargetingEntity(userPed) and karma[userPed] then
                baibaiPlayer(karma[userPed].ped, true, expSettings)
            end
        end)

local proofsList = menu.list(protection, "免疫伤害", {}, "无敌类型自定义选项")
    local immortalityCmd = menu.ref_by_path("Self>Immortality")
    for _,data in pairs(proofs) do
        menu.toggle(proofsList, data.name, {data.name:lower().."proof"}, "让您对"..data.name:lower().."伤害避免", function(toggle)
            data.on = toggle
        end)
    end
    util.create_tick_handler(function()
        local local_player = players.user_ped()
        if not menu.get_value(immortalityCmd) then
            ENTITY.SET_ENTITY_PROOFS(local_player, proofs.bullet.on, proofs.fire.on, proofs.explosion.on, proofs.collision.on, proofs.melee.on, proofs.steam.on, false, proofs.drown.on)
        end
    end)
    

------------------------------------------------------全局选项
local all = menu.list(online, "全局选项", {}) 
        menu.divider(all, "全局娱乐")
    local all_happy = menu.list(all, "娱乐选项", {}) 
        menu.divider(all, "全局恶搞")
    local sn = menu.list(all, "恶搞选项", {}, "")
    local sk = menu.list(all, "崩溃选项", {}, "")
    local kickall_list = menu.list(all, "踢出选项", {}, "")


menu.action(all_happy, '雪球大战', {}, '圣诞快乐', function ()
    local plist = players.list()
    local snowballs = util.joaat('WEAPON_SNOWBALL')
    for i = 1, #plist do
        local plyr = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(plist[i])
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(plyr, snowballs, 20, true)
        WEAPON.SET_PED_AMMO(plyr, snowballs, 20)
        players.send_sms(plist[i], players.user(), '雪球大战!你获得了雪球')
        util.yield()
    end
end)
menu.action(all_happy, '烟花大战', {}, '新年快乐', function ()
    local plist = players.list()
    local fireworks = util.joaat('weapon_firework')
    for i = 1, #plist do
        local plyr = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(plist[i])
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(plyr, fireworks, 20, true)
        WEAPON.SET_PED_AMMO(plyr, fireworks, 20)
        players.send_sms(plist[i], players.user(), '去你妈的美国!你获得了烟花')
        util.yield()
    end
end)
menu.action(all_happy, "给予所有玩家MK-2", {}, "", function ()
    for k,v in pairs(players.list(true, true, true)) do
        give_oppressor(v)
        util.yield()
    end
end)

menu.divider(sn, "全局恶搞")
menu.action(sn, "发送到介绍界面", {}, "将战局中的每个人都送到GTAOnline的介绍动画中去.", function()
    for _, pid in players.list(false, true, true) do
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))  -- Global_1894573[PLAYER::PLAYER_ID() /*608*/].f_510
            util.trigger_script_event(1 << pid, {-95341040, players.user(), 20, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
            util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end
end)
menu.action(sn, "发送到高尔夫俱乐部", {}, "让战局中所有人都去打高尔夫.", function()
    for _, pid in players.list(false, true, true) do
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
            util.trigger_script_event(1 << pid, {-95341040, players.user(), 193, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
            util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end
end)
auto_bounty = menu.list(sn, "悬赏", {}, "")
    local InSession = function() return util.is_session_started() and not util.is_session_transition_active() end
    local bounty_include_self = false
        local session_bounty_amount = 10000
            menu.toggle_loop(auto_bounty,"自动悬赏",{},"循环向每个人提供悬赏",function()
                for _,pid in pairs(players.list(bounty_include_self)) do
                    if InSession() and players.get_bounty(pid) ~= session_bounty_amount and players.get_name(pid) ~= "UndiscoveredPlayer" then
                        menu.trigger_commands("bounty"..players.get_name(pid).." "..session_bounty_amount)
                    end
                    util.yield(150)
                end
                util.yield(5000)
            end)
            auto_bounty:slider("悬赏金额",{"autobountyamount"},"选择自动提供的赏金金额",1,10000,10000,1000,function(amount)
                session_bounty_amount = amount
            end)
            menu.toggle(auto_bounty,"排除自己",{},"悬赏不会提供给你自己",function(on)
                if on then
                    bounty_include_self = false
                else
                    bounty_include_self = true
                end
            end,true)
menu.action(sn, "劫持所有载具", {}, "生成一个劫匪NPC，把他们从车里带出来并开走开.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local ped_dist = v3.distance(players.get_position(players.user()), players.get_position(pid))
        local cam_dist = v3.distance(pos, players.get_cam_pos(players.user()))

        if ped_dist < 1000.0 and cam_dist < 1000.0 and PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            menu.trigger_commands("hijack " .. players.get_name(pid))
        end
    end
end)
menu.toggle_loop(sn,  "赌场陷阱", {}, "", function() 
    local mdl = util.joaat("hei_prop_ss1_mpint_garage2")
    request_model(mdl)
    if trap_obj == nil or trap_obj2 == nil or not ENTITY.DOES_ENTITY_EXIST(trap_obj) or not ENTITY.DOES_ENTITY_EXIST(trap_obj2) then
        trap_obj = entities.create_object(mdl, v3(1089.62, 206.334, -48.473))
        trap_obj2 = entities.create_object(mdl, v3(1090.0166, 213.826, -48.473))
        ENTITY.SET_ENTITY_HEADING(trap_obj2, 31.0)
        local objs = {trap_obj, trap_obj2}
        for _, obj in objs do
            entities.set_can_migrate(entities.handle_to_pointer(obj), false)
            ENTITY.FREEZE_ENTITY_POSITION(obj, true)
            ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(players.user_ped(), obj, false)
        end
    end
    util.yield()
end, function()
    local objs = {trap_obj, trap_obj2}
    for _, obj in objs do
        if obj ~= nil then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(obj)
            entities.delete_by_handle(obj)
        end
    end
end)
penitentiary = menu.list(sn, "监狱")
    menu.action(penitentiary, "监狱", {}, "仿2t监狱", function(on_click)
        local hash = 779277682
        request_model_load(hash)
        local cage1 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, 970, -1020, 40, true, false, false)
        ENTITY.SET_ENTITY_ROTATION(cage1, 0.0, -90.0, 0.0, 1, true)
        local cage2 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, 970, -1020, 40, true, false, false)
        ENTITY.SET_ENTITY_ROTATION(cage2, 0.0, 90.0, 0.0, 1, true)
            menu.trigger_commands("apt24all")
    end)
    menu.action(penitentiary, "传送到监狱外侧", {}, "", function()
        TELEPORT(994,-1013,42)
    end)

menu.action(sn, "匿名杀人", {}, "匿名杀死所有人", function()
    nimingsharen()
end)
menu.action(sn, '爆炸所有人', {}, '爆炸所有玩家.', function()
    local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
    for _, pid in pairs(playerList) do
        local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        explodePlayer(playerPed, false, expSettings)
    end
end)
explodeLoopAll = menu.toggle_loop(sn, '循环爆炸所有人', {}, '不断的爆炸所有玩家.', function()
    local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
    for _, pid in pairs(playerList) do
        local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        explodePlayer(playerPed, true, expSettings)
    end
    util.yield(getTotalDelayabcd(expLoopDelay))
end)
menu.action(sn, "车辆电磁脉冲", {}, "让每个人的车都熄火", function()
    xihuoba()
end)
menu.toggle_loop(sn, '禁飞区', {}, '强迫所有乘坐飞行载具的玩家回到地面.', function()
    local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
    for _, pid in pairs(playerList) do
        local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local playerVehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed, false)
        if ENTITY.IS_ENTITY_IN_AIR(playerVehicle) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(playerVehicle)
            ENTITY.APPLY_FORCE_TO_ENTITY(playerVehicle, 1, 0, 0, -0.8, 0, 0, 0.5, 0, false, false, true)
            if notifications then
                menu.toast('已应用强制返回地面')
            end
        end
    end
end)
menu.action(sn, "发送所有玩家海滩", {}, "", function () 
    for pid = 0, 32 do
        if pid ~= players.user() and players.exists(pid) then
            util.trigger_script_event(1 << pid, {330622597 ,1, 0, 0, 4,0,PLAYER.GET_PLAYER_INDEX(), pid})
        end
    end
end)
menu.action(sn, "发送所有玩家岛屿", {}, "", function () 
    for pid = 0, 31 do
        if pid ~= players.user() and players.exists(pid) then
            util.trigger_script_event(1 << pid, {330622597, 1, 0, 0, 1, 1,PLAYER.GET_PLAYER_INDEX(), pid})
        end
    end
end)
menu.action(sn, "困住所有玩家", {}, "", function () 
    for pid = 0, 31 do
        if pid ~= players.user() and players.exists(pid) then
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
                pos.z = pos.z + 0.95  
                local pos1 = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
                pos1.z = pos1.z - 0.90
                local cage = util.joaat("prop_feeder1_cr")
                STREAMING.REQUEST_MODEL(cage)
                OBJECT.CREATE_OBJECT_NO_OFFSET(cage, pos.x, pos.y ,pos.z , true, true)
                OBJECT.CREATE_OBJECT_NO_OFFSET(cage, pos1.x, pos1.y ,pos1.z , true, true)
        end
    end
end)
----踢出所有
menu.action(kickall_list, "踢出所有玩家", {}, "", function () 
    menu.trigger_commands("kickall on")
end)



---MK-2检测
function get_player_vehicle_in_control(pid, opts)
    local my_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos1 = ENTITY.GET_ENTITY_COORDS(target_ped)
    local pos2 = ENTITY.GET_ENTITY_COORDS(my_ped)
    local dist = SYSTEM.VDIST2(pos1.x, pos1.y, 0, pos2.x, pos2.y, 0)
    local was_spectating = NETWORK.NETWORK_IS_IN_SPECTATOR_MODE()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(target_ped, true)
    if opts and opts.near_only and vehicle == 0 then
        return 0
    end
    if vehicle == 0 and target_ped ~= my_ped and dist > 1500 and not was_spectating then
        show_busyspinner("AUTO_SPECTATE")
        NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, target_ped)
        local loop = (opts and opts.loops ~= nil) and opts.loops or 30
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
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(vehicle)
        local has_control_ent = false
        local loops = 15
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        while not has_control_ent do
            has_control_ent = NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
            loops = loops - 1
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
function control_vehicle(pid, callback, opts)
    local vehicle = get_player_vehicle_in_control(pid, opts)
    if vehicle > 0 then
        callback(vehicle)
    elseif opts == nil or opts.silent ~= true then
        _lang.toast("PLAYER_OUT_OF_RANGE")
    end
end
function notify(msg)
    util.toast(msg)
end
function ExplodeThem(pos)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 0, 1.0, false, true, 0.0, false)
end
function is_player_friend(pId)
    local pHandle = memory.alloc(104)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pId, pHandle, 13)
    local isFriend = NETWORK.NETWORK_IS_HANDLE_VALID(pHandle, 13) and NETWORK.NETWORK_IS_FRIEND(pHandle)
    return isFriend
end
function oppKarma()
    while oppressorKarma do
        for i, pid in pairs(players.list(true, true, true)) do
            if not oppressorFriendKarma and is_player_friend(pid) then
                pid = pid+1
            elseif not oppressorYourselfKarma and pid == players.user() then
                pid = pid+1
            end
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            if PED.IS_PED_IN_MODEL(target_ped, 2069146067) then
                if selectedKarmaMK2 == "[Remove]" or selectedKarmaMK2 == nil then
                    control_vehicle(pid, function(vehicle)
                        entities.delete_by_handle(vehicle)
                        util.yield(100)
                    end)
                elseif selectedKarmaMK2 == "[Kill]" then
                    ExplodeThem(ENTITY.GET_ENTITY_COORDS(target_ped))
                elseif selectedKarmaMK2 == "[Remove + Kill]" then
                    control_vehicle(pid, function(vehicle)
                        entities.delete_by_handle(vehicle)
                    end)
                    util.yield(100)
                    ExplodeThem(ENTITY.GET_ENTITY_COORDS(target_ped))
                elseif selectedKarmaMK2 == "[Remove + Send SMS]" then
                    control_vehicle(pid, function(vehicle)
                        entities.delete_by_handle(vehicle)
                    end)
                    players.send_sms(pid,"你就歌姬霸！.")
                end
                notify("检测到马克兔 "..players.get_name(pid).." 报应启用")
            end
            util.yield(10)
        end
        util.yield(2000)
    end
end

------------------------------------------------------------武器选项

menu.toggle(weapons, "核弹枪", {}, "使用RPG发射核弹\n第一发可能故障", function(toggle)
    nuke_running = toggle
        if nuke_running then
                nuclear()
        end
end)

crosshair = menu.list(weapons, "准星", {}, "")
    menu.toggle_loop(crosshair, "瞄准准星 (^)", {''}, '', function()
        HUD.SET_TEXT_SCALE(1.0,0.5)
        HUD.SET_TEXT_FONT(0)
        HUD.SET_TEXT_CENTRE(1)
        HUD.SET_TEXT_OUTLINE(0)
        HUD.SET_TEXT_COLOUR(255, 255, 255, 180)
        util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("^")
        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.486,0)
    end)
    menu.toggle_loop(crosshair, "瞄准准星 (*)", {''}, '', function()
        HUD.SET_TEXT_SCALE(1.0,0.5)
        HUD.SET_TEXT_FONT(0)
        HUD.SET_TEXT_CENTRE(1)
        HUD.SET_TEXT_OUTLINE(0)
        HUD.SET_TEXT_COLOUR(255, 255, 255, 180)
        util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("*")
        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.485,0)
    end)
    menu.toggle_loop(crosshair, "瞄准准星 (+)", {''}, '', function()
        HUD.SET_TEXT_SCALE(1.0,0.5)
        HUD.SET_TEXT_FONT(0)
        HUD.SET_TEXT_CENTRE(1)
        HUD.SET_TEXT_OUTLINE(0)
        HUD.SET_TEXT_COLOUR(255, 255, 255, 180)
        util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("+")
        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.477,0)
    end)
    menu.toggle_loop(crosshair, "瞄准准星 (·)", {''}, '', function()
        HUD.SET_TEXT_SCALE(1.0,0.5)
        HUD.SET_TEXT_FONT(0)
        HUD.SET_TEXT_CENTRE(1)
        HUD.SET_TEXT_OUTLINE(0)
        HUD.SET_TEXT_COLOUR(255, 255, 255, 180)
        util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("·")
        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.49997,0.478,0)
    end)

entity_gun = menu.list(weapons, "实体枪", {}, "")
    menu.toggle_loop(entity_gun, "实体枪", {}, "", function()
        eentity_gun()
    end)
    local entity_hashes = {-422877666, -717142483, util.joaat("prop_paints_can07")}
    local entity_options = {"蔡徐坤", "足球", "水桶"}
    menu.list_action(entity_gun, "选择实体", {}, "", entity_options, function(index, value, click_type)
        shootent = entity_hashes[index]
    end)


menu.toggle_loop(weapons, "自动扳机", {}, "", function()
    local wpn = WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped())
    local dmg = SYSTEM.ROUND(WEAPON.GET_WEAPON_DAMAGE(wpn, 0))
    local delay = WEAPON1.GET_WEAPON_TIME_BETWEEN_SHOTS(wpn)
    local wpnEnt = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), false)
    local wpnCoords = ENTITY1.GET_ENTITY_BONE_POSTION(wpnEnt, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(wpnEnt, "gun_muzzle"))
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        boneIndex = bones[math.random(#bones)]
        local pos = PED.GET_PED_BONE_COORDS(ped, boneIndex, 0.0, 0.0, 0.0)
        if PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(players.user(), ped) and not PED.IS_PED_RELOADING(players.user_ped()) then
            MISC1.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(wpnCoords, pos, dmg, true, wpn, players.user_ped(), true, false)
            PADdaidai.SET_CONTROL_VALUE_NEXT_FRAME(0, 24, 1.0)
            util.yield(delay * 1000)
        end
    end
end)

local modifier = 1.00
menu.slider_float(weapons, "近战伤害修改", {"meleedamage"}, "", 100, 1000, 100, 10, function(value)
    modifier = value / 100
    PLAYER.SET_PLAYER_MELEE_WEAPON_DAMAGE_MODIFIER(players.user(), modifier)
end)

entity_control = menu.list(weapons, "实体控制枪", {}, "控制你所瞄准的实体")
    menu.toggle_loop(entity_control, "开启", {}, "", function()
        entitycontrol()
    end)
    menu.action(entity_control, "清除记录的实体", {}, "", function()
        clearcontrollog()
    end)
    menu.divider(entity_control, "实体列表")

menu.action(weapons, "分离元素", {}, "分离附加到PED的每个附着元素,不区分玩家和NPC", function(on_click)
    detach_all_entities()
end)
menu.toggle_loop(weapons, "无爆炸物", {}, "移除玩家所有爆炸性弹药,甚至是火箭弹", function(on)
        WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(741814745, false)
        WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(-1312131151, false)
        WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(-1568386805, false)
        WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(2138347493, false)
        WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(1672152130, false)
        WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(125959754, false)
        WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(-1813897027, false)
        WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(615608432, false)
        WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(1420407917, false)
        WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(1169823560, false)
end)

tint_thread = util.create_thread(function (thr)
    cur_tint = 0
    while true do
        if cur_tint < 7 then
            cur_tint = cur_tint + 1
        else
            cur_tint = 0
        end
        util.yield(200)
    end
end)
menu.toggle_loop(weapons, "彩虹武器色调", {}, "", function(on)
    plyr = PLAYER.PLAYER_PED_ID()
        local last_tint = WEAPON.GET_PED_WEAPON_TINT_INDEX(PLAYER.PLAYER_PED_ID(), WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()))
        WEAPON.SET_PED_WEAPON_TINT_INDEX(PLAYER.PLAYER_PED_ID(),WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()), cur_tint)
end)

local ent_types = {"没有", "行人", "载具", "实体"}
local function get_aim_info()
    local outptr = memory.alloc(4)
    local success = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), outptr)
    local info = {}
    if success then
        local ent = memory.read_int(outptr)
        if not ENTITY.DOES_ENTITY_EXIST(ent) then
            info["ent"] = 0
        else
            info["ent"] = ent
        end
        if ENTITY.GET_ENTITY_TYPE(ent) == 1 then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ent, false)
            if veh ~= 0 then
                if VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1) then
                    ent = veh
                    info['ent'] = ent
                end
            end
        end
        info["hash"] = ENTITY.GET_ENTITY_MODEL(ent)
        info["health"] = ENTITY.GET_ENTITY_HEALTH(ent)
        info["type"] = ent_types[ENTITY.GET_ENTITY_TYPE(ent)+1]
        info["speed"] = math.floor(ENTITY.GET_ENTITY_SPEED(ent))
    else
        info['ent'] = 0
    end
    return info
end

damage_numbers_list = menu.list(weapons, "伤害数字")
    menu.toggle_loop(damage_numbers_list, "伤害数字", {"damagenumbers"}, "", function()
        damage_numbers()
    end)
    menu.toggle(damage_numbers_list, "包括车辆", {"damagenumbersvehicles"}, "", function (value)
        damage_numbers_target_vehicles = value
    end,true)
    menu.slider(damage_numbers_list, "数字尺寸", {"damagenumberstextsize"}, "", 1, 100, 7, 1, function (value)
        damage_numbers_text_size = value * 0.1
    end)
    
damage_numbers_colours_list = menu.list(damage_numbers_list, "颜色设置")
    menu.rainbow(menu.colour(damage_numbers_colours_list, "射击默认颜色", {"damagenumcolour"}, "默认命中的颜色", damage_numbers_health_colour, true, function (value)
        damage_numbers_health_colour = value
    end))
    menu.rainbow(menu.colour(damage_numbers_colours_list, "射击暴击颜色", {"damagenumcritcolour"}, "暴击颜色", damage_numbers_crit_colour, true, function (value)
        damage_numbers_crit_colour = value
    end))
    menu.rainbow(menu.colour(damage_numbers_colours_list, "射击盔甲颜色", {"damagenumarmourcolour"}, "盔甲颜色", damage_numbers_armour_colour, true, function (value)
        damage_numbers_armour_colour = value
    end))
    menu.rainbow(menu.colour(damage_numbers_colours_list, "射击载具颜色", {"damagenumvehiclecolour"}, "载具颜色", damage_numbers_vehicle_colour, true, function (value)
        damage_numbers_vehicle_colour = value
    end))

menu.toggle_loop(weapons, "踢出枪", {}, "", function()
    local ent = get_aim_info()['ent']
    if PED.IS_PED_SHOOTING(players.user_ped()) then
        if ENTITY.IS_ENTITY_A_PED(ent) then
            if PED.IS_PED_A_PLAYER(ent) then
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
                if players.get_host() == pid then 
                    util.toast("[呆呆 提示] \n您正试图踢出的玩家是主机")
                    return
                end
                menu.trigger_commands("kick" .. players.get_name(pid))
            end
        end
    end
end)
menu.toggle_loop(weapons, "崩溃枪", {}, "", function()
    local ent = get_aim_info()['ent']
    if PED.IS_PED_SHOOTING(players.user_ped()) then
        if ENTITY.IS_ENTITY_A_PED(ent) then
            if PED.IS_PED_A_PLAYER(ent) then
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
                menu.trigger_commands("crash" .. players.get_name(pid))
            end
        end
    end
end)

menu.action(weapons, "发射引导导弹", {"missile"}, "", function()
	if not UFO.exists() then GuidedMissile.create() end
end)

sticky_bomb_explosion = menu.list(weapons, '粘弹自动爆炸', {}, '')
    menu.toggle_loop(sticky_bomb_explosion, '粘弹自动爆炸', {}, '使您的粘弹在玩家或NPC附近时自动引爆.', function()
        proxyStickys()
    end)
    local detonate_players = true
    menu.toggle(sticky_bomb_explosion, '引爆附近的玩家', {}, '', function(toggle)
        detonate_players = toggle
    end,true)
    menu.toggle(sticky_bomb_explosion, '引爆附近的NPC', {}, '', function(toggle)
        detonate_npcs = toggle
    end)
    menu.slider(sticky_bomb_explosion, '触发半径', {}, '', 1, 10, 2, 1, function(value)
        detonate_radius = value
    end)
    menu.action(sticky_bomb_explosion, '移除所有粘性炸弹', {}, '移除所有存在的粘性炸弹', function()
        WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(util.joaat('weapon_stickybomb'))
    end)




weaponback = off
menu.toggle(weapons, "背藏武器", {}, "按Tab键", function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
	weaponback = on
	if weaponback then
		spawnweapon = 0
	end
	curweap = HUDdaidai._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())
	if not (HUDdaidai._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == -1569615261) and weaponback then
		spawnweapon = WEAPON.CREATE_WEAPON_OBJECT(curweap, 1, pos.x, pos.y, pos.z, true, 1, 0)
		attachweapon(spawnweapon)
	end
	while weaponback do
		if (WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(plyped()) == 0) then
			if not (spawnweapon == 0) then
				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, true, false)
			end
		else
			ENTITY.SET_ENTITY_VISIBLE(spawnweapon, false, false)
		end
		if not (HUDdaidai._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == curweap) and not (HUDdaidai._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == -1569615261) then
			if not (spawnweapon == 0) then
				entities.delete_by_handle(spawnweapon)
			end
			curweap = HUDdaidai._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())
			requestweapon(curweap)
			spawnweapon = WEAPON.CREATE_WEAPON_OBJECT(curweap, 1, pos.x, pos.y, pos.z, true, 1, 0)
			if (WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(plyped()) == 0) then
				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, true, false)
			else
				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, false, false)
			end
			attachweapon(spawnweapon)
		end
		util.yield()
	end
	entities.delete_by_handle(spawnweapon)
end)

---------载具枪
local obj_hash = 'vigilante'
local obj = {expl = false}
SEC = ENTITY.SET_ENTITY_COORDS
objgun = menu.list(weapons, '载具枪', {}, '')
OBJgun = menu.toggle_loop(objgun, '开启', {}, '', function ()
    local hash = util.joaat(obj_hash)
    Streament(hash)
    if PLAYER.IS_PLAYER_FREE_AIMING(players.user()) and not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) then
        local rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
        local camcoords = get_offset_from_camera(10)
        if not ENTITY.DOES_ENTITY_EXIST(obj.prev) then
            objams(hash, obj, camcoords)
        else
            SEC(obj.prev, camcoords.x, camcoords.y, camcoords.z, false, true, true, false)
        end
        ENTITY.SET_ENTITY_ROTATION(obj.prev, rot.x, rot.y, rot.z, 0, true)
    elseif ENTITY.DOES_ENTITY_EXIST(obj.prev) and not PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
        entities.delete_by_handle(obj.prev)
    end
    if PED.IS_PED_SHOOTING(players.user_ped()) and not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) then
        local camcoords = get_offset_from_camera(15)
        objshots(hash, obj, camcoords)
        entities.delete_by_handle(obj.prev)
        util.yield(20)
    end
end)
menu.list_select(objgun, '载具类型', {''}, '', Objn, 1, function (sel)
    obj_hash = Objl[sel]
end)
menu.toggle(objgun, '附加爆炸', {}, '击中某物时使射击的物体爆炸', function (on)
    obj.expl =  on
end)
--------------
menu.toggle(weapons, "女武神导弹",  {}, "", function(toggle)
    nvwushen(toggle)
end)
---------无声自瞄
local function pid_to_handle(pid)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, handle_ptr, 13)
    return handle_ptr
end

saimbot_mode = "closest"
local function get_aimbot_target()
    local dist = 1000000000
    local cur_tar = 0
    for k,v in pairs(entities.get_all_peds_as_handles()) do
        local target_this = true
        local player_pos = players.get_position(players.user())
        local ped_pos = ENTITY.GET_ENTITY_COORDS(v, true)
        local this_dist = MISC.GET_DISTANCE_BETWEEN_COORDS(player_pos['x'], player_pos['y'], player_pos['z'], ped_pos['x'], ped_pos['y'], ped_pos['z'], true)
        if players.user_ped() ~= v and not ENTITY.IS_ENTITY_DEAD(v) then
            if not satarget_players then
                if PED.IS_PED_A_PLAYER(v) then
                    target_this = false
                end
            end
            if not satarget_npcs then
                if not PED.IS_PED_A_PLAYER(v) then
                    target_this = false
                end
            end
            if not ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(players.user_ped(), v, 17) then
                target_this = false
            end
            if satarget_usefov then
                if not PED.IS_PED_FACING_PED(players.user_ped(), v, sa_fov) then
                    target_this = false
                end
            end
            if satarget_novehicles then
                if PED.IS_PED_IN_ANY_VEHICLE(v, true) then 
                    target_this = false
                end
            end
            if satarget_nogodmode then
                if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(v) then 
                    target_this = false 
                end
            end
            if not satarget_targetfriends and satarget_players then
                if PED.IS_PED_A_PLAYER(v) then
                    local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(v)
                    local hdl = pid_to_handle(pid)
                    if NETWORK.NETWORK_IS_FRIEND(hdl) then
                        target_this = false 
                    end
                end
            end
            if saimbot_mode == "closest" then
                if this_dist <= dist then
                    if target_this then
                        dist = this_dist
                        cur_tar = v
                    end
                end
            end 
        end
    end
    return cur_tar
end

silent_aimbotroot = menu.list(weapons, "武器自瞄", {}, "也可理解为子弹追踪")
    sa_showtarget = true---显示目标
    satarget_usefov = true---设置视野
    satarget_players = true---自瞄玩家
    menu.toggle_loop(silent_aimbotroot, "开启", {}, "", function(toggle)
        local target = get_aimbot_target()
        if target ~= 0 then
            local t_pos = PED.GET_PED_BONE_COORDS(target, 31086, 0.01, 0, 0)
            local t_pos2 = PED.GET_PED_BONE_COORDS(target, 31086, -0.01, 0, 0.00)
            if sa_showtarget then
                util.draw_ar_beacon(t_pos)
            end
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                local wep = WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped())
                local dmg = WEAPON.GET_WEAPON_DAMAGE(wep, 0)
                if satarget_damageo then
                    dmg = sa_odmg
                end
                local veh = PED.GET_VEHICLE_PED_IS_IN(target, false)
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(t_pos['x'], t_pos['y'], t_pos['z'], t_pos2['x'], t_pos2['y'], t_pos2['z'], dmg, true, wep, players.user_ped(), true, false, 10000, veh)
            end
        end
    end)

    select_target = menu.list(silent_aimbotroot, "选择目标", {}, "默认为玩家")
    set_view = menu.list(silent_aimbotroot, "设置视野", {}, "默认为10")
    exclude = menu.list(silent_aimbotroot, "排除选项", {}, "")
    modify_damage = menu.list(silent_aimbotroot, "修改伤害", {}, "默认100")

    menu.toggle(select_target, "瞄准玩家", {}, "", function(on)
        satarget_players = on
    end, true)
    menu.toggle(select_target, "瞄准NPC", {}, "", function(on)
        satarget_npcs = on
    end)

    menu.toggle(set_view, "设置视野", {}, "选择合适的视野大小", function(on)
        satarget_usefov = on
    end, true)
    sa_fov = 10
    menu.slider(set_view, "视野大小", {}, "推荐视野10", 0, 270, 10, 1, function(s)
        sa_fov = s
    end)
    menu.toggle(exclude, "忽略载具内目标", {}, "", function(on)
        satarget_novehicles = on
    end)
    menu.toggle(exclude,  "忽略无敌玩家", {}, "", function(on)
        satarget_nogodmode = on
    end)
    menu.toggle(select_target, "瞄准朋友", {}, "", function(on)
        satarget_targetfriends = on
    end)
    menu.toggle(modify_damage, "伤害覆盖", {}, "", function(on)
        satarget_damageo = on
    end, true)
    sa_odmg = 100
    menu.slider(modify_damage, "伤害覆盖量", {}, "", 0, 1000, 100, 10, function(s)
        sa_odmg = s
    end)

    menu.toggle(silent_aimbotroot, "显示目标", {}, "标记自瞄对象", function(on)
        sa_showtarget = on
    end, true)
-------------------------


menu.toggle(weapons, "隐形武器", {"invisiblweaponse"}, "换枪后失效", function(on)
    local plyr = players.user_ped()
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(plyr, not on, false, false, false)
end)

menu.toggle(weapons, "偷车枪", {}, "", function(on)
    if on then
            menu.trigger_commands("drivegun on")
    else
        menu.trigger_commands("drivegun off")
    end
end)


----------3D 十字准线框
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
-- texure loading
local function request_texture_dict_load(dict_name)
    request_time = os.time()
    GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(dict_name, true)
    while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(dict_name) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end
-- preload the textures
menu.toggle_loop(silent_aimbotroot, "3D准线框", {}, "", function(on)
    request_texture_dict_load('visualflow')
    local rc = raycast_gameplay_cam(-1, 10000.0)[2]
    local c = players.get_position(players.user())
    local dist = MISC.GET_DISTANCE_BETWEEN_COORDS(rc.x, rc.y, rc.z, c.x, c.y, c.z, false)
    local dir = v3.toDir(CAM.GET_GAMEPLAY_CAM_ROT(0))
    size = {}
    size.x = 0.5+(dist/50)
    size.y = 0.5+(dist/50)
    size.z = 0.5+(dist/50)
    GRAPHICS.DRAW_MARKER(3, rc.x, rc.y, rc.z, 0.0, 0.0, 0.0, 0.0, 90.0, 0.0, size.y, 1.0, size.x, 255, 255, 255, 50, false, true, 2, false, 'visualflow', 'crosshair')
end)
------------
special_weapons = menu.list(weapons, "特殊武器", {}, "")
menu.toggle(special_weapons, "大锤", {}, "", function(on)
    hammer(on)
end)

menu.toggle(special_weapons, "白白大锤", {}, "", function(on)
    baibaihammer(on)
end)
menu.toggle(special_weapons, "棕色小熊", {}, "", function(on)
    daidaihammer(on)
end)
menu.toggle(special_weapons, "粉色独角兽", {}, "", function(on)
    daidaiunicorn(on)
end)
--[[ menu.toggle(special_weapons, "金箍棒", {}, "", function(on)
    goldenrod(on)
end) ]]
menu.toggle(special_weapons, "太刀",{""}, "",function(on)
    knife(on)
end)

weapon_thing = menu.list(weapons, "更改子弹", {}, "")
    zidanleixing()


menu.toggle_loop(weapons, "快速更换武器", {}, "武器更换速度更快.", function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 56) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)
menu.toggle_loop(weapons, '热成像枪', {}, '当您瞄准时按"E"可以启用热成像功能.', function()
    thermalgun()
end)
menu.toggle_loop(weapons, "快速热成像", {}, "更快地在热成像之间进行切换.", function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 92) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)
menu.toggle_loop(weapons, "快速近战", {}, "近战速度更快.", function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 130) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

menu.toggle_loop(weapons, "NPC枪", {""}, "随机射出NPC", function()
    shechuNPC()
end)
menu.toggle_loop(weapons, '喷火器', {}, '将加特林改为喷火枪', function()
    flamegun()
end)
menu.toggle(weapons, "可以射击队友", {}, '使你在游戏中能够射击队友', function(toggle)
    PED.SET_CAN_ATTACK_FRIENDLY(players.user_ped(), toggle, false)
end)

----------------------射击效果
shooting_effects = menu.list(weapons, "射击特效", {}, "")
local ShootEffect =
{
    scale = 0,
	rotation = nil
}
ShootEffect.__index = ShootEffect
setmetatable(ShootEffect, Effect)

function ShootEffect.new(asset, name, scale, rotation)
	tbl = setmetatable({}, ShootEffect)
	tbl.name = name
	tbl.asset = asset
	tbl.scale = scale or 1.0
	tbl.rotation = rotation or v3.new()
	return tbl
end
local selectedOpt = 1
---@type ShootEffect[]
local shootingEffects <const> = {
	ShootEffect.new("scr_rcbarry2", "muz_clown", 0.8, v3.new(90, 0.0, 0.0)),
	ShootEffect.new("scr_rcbarry2", "scr_clown_bul", 0.3, v3.new(180.0, 0.0, 0.0))
}
menu.toggle_loop(shooting_effects, "射击效果", {"shootingfx"}, "", function ()
	local effect = shootingEffects[selectedOpt]
	if not WIRI.HAS_NAMED_PTFX_ASSET_LOADED(effect.asset) then
		WIRI.REQUEST_NAMED_PTFX_ASSET(effect.asset)

	elseif PED.IS_PED_SHOOTING(players.user_ped()) then
		local weapon = WIRI.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped(), false)
		local boneId = WIRI.GET_ENTITY_BONE_INDEX_BY_NAME(weapon, "gun_muzzle")
		WIRI.USE_PARTICLE_FX_ASSET(effect.asset)
		WIRI.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE(
			effect.name,
			weapon,
			0.0, 0.0, 0.0,
			effect.rotation.x, effect.rotation.y, effect.rotation.z,
			boneId,
			effect.scale,
			false, false, false
		)
	end
end)
local options <const> = {
	"小丑喷射",
	"小丑花"
}
menu.slider_text(shooting_effects, "设置射击效果", {}, "切换后点击以进行更改", options, function (index)
	selectedOpt = index
end)


-- 命中效果
-------------------------------------
local HitEffect = {colorCanChange = false}
HitEffect.__index = HitEffect
setmetatable(HitEffect, Effect)

function HitEffect.new(asset, name, colorCanChange)
	local inst = setmetatable({}, HitEffect)
	inst.name = name
	inst.asset = asset
	inst.colorCanChange = colorCanChange or false
	return inst
end

local hitEffects = {
	HitEffect.new("scr_rcbarry2", "scr_exp_clown"),
	HitEffect.new("scr_rcbarry2", "scr_clown_appears"),
	HitEffect.new("scr_rcpaparazzo1", "scr_mich4_firework_trailburst_spawn", true),
	HitEffect.new("scr_indep_fireworks", "scr_indep_firework_starburst", true),
	HitEffect.new("scr_indep_fireworks", "scr_indep_firework_fountain", true),
	HitEffect.new("scr_rcbarry1", "scr_alien_disintegrate"),
	HitEffect.new("scr_rcbarry2", "scr_clown_bul"),
	HitEffect.new("proj_indep_firework", "scr_indep_firework_grd_burst"),
	HitEffect.new("scr_rcbarry2", "muz_clown"),
}
local effectColour = {r = 0.5, g = 0.0, b = 0.5, a = 1.0}
local selectedOpt = 1
hitEffectRoot = menu.list(weapons, "命中效果", {}, "")
    menu.toggle_loop(hitEffectRoot, "开启效果", {}, "", function()
        local effect = hitEffects[selectedOpt]
        if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(effect.asset) then
            return STREAMING.REQUEST_NAMED_PTFX_ASSET(effect.asset)
        end
        local hitCoords = v3.new()
        if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), hitCoords) then
            local raycastResult = get_raycast_result(1000.0)
            local rot = raycastResult.surfaceNormal:toRot()
            GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
            if effect.colorCanChange then
                local colour = effectColour
                GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour.r, colour.g, colour.b)
            end
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                effect.name,
                hitCoords.x, hitCoords.y, hitCoords.z,
                rot.x - 90.0, rot.y, rot.z,
                1.0, 
                false, false, false, false
            )
        end
    end)
    local options = {
        {"小丑爆炸"},
        {"小丑出现"},
        {"开拓者FW"},
        {"星爆FW"},
        {"喷泉FW"},
        {"外星解体"},
        {"小丑花"},
        {"外星冲击波FW"},
        {"小丑木兹"},
    }
    menu.list_select(hitEffectRoot, "设置效果", {}, "", options, 1, function (opt)
        selectedOpt = opt
    end)
    local SetEffectColour = function(colour) effectColour = colour end
    local menuColour =
    menu.colour(hitEffectRoot, "设置颜色", {}, "仅对某些效果有效", effectColour, false, SetEffectColour)
    menu.rainbow(menuColour)
-----------------------------------------------

menu.toggle_loop(weapons, "彩弹枪", {""}, "射击更改载具颜色", function()
	if PED.IS_PED_SHOOTING(players.user_ped()) then
		local entity = get_entity_player_is_aiming_at(players.user())
		if entity ~= NULL and ENTITY.IS_ENTITY_A_VEHICLE(entity) and request_control(entity, 1000) then
			local primary, secundary = get_random_colour(), get_random_colour()
			VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(entity, primary.r, primary.g, primary.b)
			VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(entity, secundary.r, secundary.g, secundary.b)
		end
	end
end)
menu.toggle_loop(weapons, "空袭枪", {"airstrikegun"}, "", function()
    kxq()
end)
magnetic_gun = menu.list(weapons, "磁力枪", {}, "")
    menu.toggle_loop(magnetic_gun, "磁力枪", {}, "具有磁力的枪，可控制车辆去向", function ()
        ciliqiang()
    end)
    menu.slider_text(magnetic_gun, "设置磁力枪", {}, "选择后才生效", {"平滑模式", "混沌模式"}, function(index)
        szclq(index)
    end)
menu.toggle_loop(weapons, "传送枪", {"tpgun"}, "", function()
    csq()
end)
menu.toggle_loop(weapons, '翻滚换弹', {}, '', function()
    fghd()
end)

---------------------------------------------------------娱乐选项

menu.toggle(funfeatures, "火拳",{""}, "",function(on)
    Fire_Fist(on) 
end)
menu.toggle(funfeatures, "雷电拳",{""}, "",function(on)
    Raiden_Fist(on)
end)


spawn_truck = menu.list(funfeatures, "拉车")
    spawn_truck_car = menu.list(spawn_truck, "生成拉车")
    menu.action(spawn_truck_car, "废土", {}, "生成一个废土人进行拖曳", function()
        menu.trigger_commands("wastelander")
    end)
    menu.action(spawn_truck_car, "猛击卡车", {}, "生成一辆猛击卡车进行牵引", function()
        menu.trigger_commands("slamtruck")
    end)
    menu.toggle(spawn_truck, "附加", {}, "任何近距离车辆都将连接到您当前的车辆上", function(on)
        if on then
            attach_nearest_vehicle()
        else
            detach_attached_vehicle() 
        end
    end)


Hell_Undead = menu.list(funfeatures, "地狱亡灵", {}, "")
    menu.toggle(Hell_Undead, "地狱亡灵", {}, "", function(on)
        if on then
            menu.trigger_commands("grace on")
            menu.set_value(Burning_Man, true)
            menu.set_value(runspeed, true)
            menu.set_value(superjump, true)
            menu.trigger_commands("trails on")
            menu.trigger_commands("trailcolourrainbow 1")
        else
            menu.trigger_commands("grace off")
            menu.set_value(Burning_Man, false)
            menu.set_value(runspeed, false)
            menu.set_value(superjump, false)
            menu.trigger_commands("trails off")
            menu.trigger_commands("trailcolourrainbow 0")
        end
    end)

    menu.divider(Hell_Undead,"设置")
    runspeed = menu.toggle(Hell_Undead, "奔跑速度", {}, "", function(on)
        if on then
            menu.trigger_commands("walkspeed 1.5")
            menu.trigger_commands("gracefullanding on")
            menu.trigger_commands("superrun 1.2")
        else
            menu.trigger_commands("walkspeed 1")
            menu.trigger_commands("gracefullanding off")
            menu.trigger_commands("superrun 0")
            homer = off
        end
    end)
    superjump = menu.toggle_loop(Hell_Undead, "亡灵跳跃", {}, "", function()
            if PAD.IS_CONTROL_PRESSED(1, 22) then
                ENTITY.APPLY_FORCE_TO_ENTITY(players.user_ped(), 1, 0.0, 0.0, 1.5, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
            end
    end)



menu.toggle(funfeatures, "GPS导航", {}, "", function(value)
    GPS_navigation(value)
end)

headlamp = menu.list(funfeatures, "头灯", {}, "仅本地可见")
    menu.toggle_loop(headlamp, "开启", {"headlamp"}, "", function()
        local head_pos = PED.GET_PED_BONE_COORDS(players.user_ped(), 31086, 0.0, 0.0, 0.0)
        local cam_rot = players.get_cam_rot(players.user())
        GRAPHICSdaidai.DRAW_SPOT_LIGHT(head_pos, cam_rot:toDir(), math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255), distance * 1.5, brightness, 0.0, radius, distance)
    end)
    distance = 25.0
    menu.slider_float(headlamp, "距离", {"distance"}, "光照距离.", 100, 10000, 1500, 100, function(value)
        distance = value / 100
    end)
    brightness = 10.0
    menu.slider_float(headlamp, "亮度", {"brightness"}, "光亮强度.", 100, 10000, 1000, 100, function(value)
        brightness = value / 100
    end)
    radius = 15.0
    menu.slider_float(headlamp, "半径", {"radius"}, "光束半径.", 100, 5000, 2000, 100, function(value)
        radius = value / 100
    end)
    color = {r = 1, g = 235/255, b = 190/255, a = 0}
    menu.colour(headlamp, "颜色", {"colour"}, "", color, true, function(value)
        color = value 
    end)


local pop_multiplier_id
local disable_traffic = true
local disable_peds = true
menu.toggle(funfeatures, "移除交通", {}, "对其它玩家生效", function(on)
    if on then
        local ped_sphere, traffic_sphere
        if disable_peds then ped_sphere = 0.0 else ped_sphere = 1.0 end
        if disable_traffic then traffic_sphere = 0.0 else traffic_sphere = 1.0 end
        pop_multiplier_id = MISC.ADD_POP_MULTIPLIER_SPHERE(1.1, 1.1, 1.1, 15000.0, ped_sphere, traffic_sphere, false, true)
        MISC.CLEAR_AREA(1.1, 1.1, 1.1, 19999.9, true, false, false, true)
    else
        MISC.REMOVE_POP_MULTIPLIER_SPHERE(pop_multiplier_id, false);
    end
end)

appearance = menu.list(funfeatures, "伪装")
    disguise_state = state
    menu.toggle(appearance, "开始伪装", {}, "", function(state)
        disguise_state = state
            if disguise_state then
                invisibility_select = menu.ref_by_path("Self>Appearance>Invisibility")
                object_hash = util.joaat(disguise_objects[disguise_object])
                player_pos = players.get_position(players.user())
                request_model(object_hash)
                object = entities.create_object(object_hash, player_pos)
                menu.set_value(invisibility_select, 2)
                ENTITY.SET_ENTITY_COLLISION(object, false, false)
                    while disguise_state and players.exists(players.user()) do
                        player_pos = players.get_position(players.user())
                        player_rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 5)
                        ENTITY.SET_ENTITY_COORDS(object, player_pos.x, player_pos.y, player_pos.z - 1, false, false, false, false)
                        ENTITY.SET_ENTITY_ROTATION(object, 0, 0, player_rot.z, false, false, false, false)
                        util.yield()
                    end
                entities.delete_by_handle(object)
                menu.set_value(invisibility_select, 0)
            end
    end)
    disguise_object_slider = menu.slider_text(appearance, "伪装选择", {}, "更换后需重新打开伪装", disguise_names, function()
        end)
    util.create_tick_handler(function()
        if not players.exists(players.user()) then
            return false
        end
    disguise_object = menu.get_value(disguise_object_slider)
    end)
-------------------

menu.toggle(funfeatures,"恶灵骑士" ,{""}, "", function(on)
    if on then 
        elqss()
    else
        entities.delete_by_handle(vehicleelqs)
    end
end)
menu.toggle(funfeatures, "飞天扫帚", {""}, "", function(on)
    flying_broom(on)
end)

fire_work_setting = menu.list(funfeatures, "烟花", {}, "")
    menu.action(fire_work_setting,"安放烟花",{},"",function()
        anfangyanhua()
    end)	
    menu.action(fire_work_setting,"烟花发射",{},"",function(f)
        yanhuafashe(f)
    end)
acrobatics = menu.list(funfeatures, "车辆跳跃", {}, "")
    menu.action(acrobatics, "豚跳", {}, "", function()
        local vehicle = get_vehicle_player_is_in(players.user())
        if ENTITY.DOES_ENTITY_EXIST(vehicle) and VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
        request_control(vehicle, 1000) then
            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
        end
    end)
    menu.action(acrobatics, "左侧空翻", {}, "", function()
        local vehicle = get_vehicle_player_is_in(players.user())
        if ENTITY.DOES_ENTITY_EXIST(vehicle) and VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
        request_control(vehicle, 1000) then
            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.71, 5.0, 0.0, 0.0, 1, false, true, true, true, true)
        end
    end)
    menu.action(acrobatics, "双左侧空翻", {}, "", function()
        local vehicle = get_vehicle_player_is_in(players.user())
        if ENTITY.DOES_ENTITY_EXIST(vehicle) and VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
        request_control(vehicle, 1000) then
            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 21.43, 20.0, 0.0, 0.0, 1, false, true, true, true, true)
        end
    end)
    menu.action(acrobatics, "右侧空翻", {}, "", function()
        local vehicle = get_vehicle_player_is_in(players.user())
        if ENTITY.DOES_ENTITY_EXIST(vehicle) and VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
        request_control(vehicle, 1000) then
            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.71, -5.0, 0.0, 0.0, 1, false, true, true, true, true)
        end
    end)

---------黑洞
black_hole = menu.list(funfeatures, "黑洞", {}, "")
local yourself
local yourselfCoord = {x=0,y=0,z=0}
local visualHelp = false
local visualHelpEnt
local entityToSpawn = util.joaat("prop_mk_sphere")
local blackHole = false
local blackHoleType = "black"
local blackHoleVehicle
local blackHolePos = {x = 0, y = 0, z = 0}
local vehiclePos = {x = 0, y = 0, z = 0}
local tableBlackHole = {"拉", "推",}
local pushStrength = 1
local pushToX = 1
local pushToY = 1
local pushToZ = 1

local blackHoleMenu = menu.toggle(black_hole, "开启黑洞", {}, "", function(a)
    blackHole = a
end)
local visualHelpMenu = menu.toggle(black_hole, "视觉帮助", {}, "查看我的黑洞在哪", function(a)
    visualHelp = a
end)
black_hole_position = menu.list(black_hole, "调整黑洞位置", {}, "")

local pushStrengthMenu = menu.slider(black_hole, "设置黑洞强度", {}, "设置拉或推的力度(如果力度设置为100，距离太近会使你在地图中走样)我建议力度在5到10之间", 1, 100, 1, 1, function(a)
    pushStrength = a
end)

local blackHoleTypeMenu = menu.list_select(black_hole, "黑洞类型 ", {}, "选择黑洞的作用", tableBlackHole, 1, function(a)
    a -= 1
    if a == 0 then
        blackHoleType = "Black"
    elseif a == 1 then
        blackHoleType = "White"
    end
end)
menu.action(black_hole, "删除废弃黑洞", {}, "", function() 
    menu.trigger_commands("superclean2")
end)

local blackHolePosX = menu.slider(black_hole_position, "黑洞位置 X", {"coordBlackHoleX"}, "设置黑洞在地图X轴上的坐标", -100000, 100000, 0, 1, function(a)
    blackHolePos.x = a
end)
local blackHolePosY = menu.slider(black_hole_position, "黑洞位置 Y", {"coordBlackHoleY"}, "设置黑洞在地图Y轴上的坐标", -100000, 100000, 0, 1, function(a)
    blackHolePos.y = a
end)
local blackHolePosZ = menu.slider(black_hole_position, "黑洞位置 Z", {"coordBlackHoleZ"}, "设置黑洞在地图Z轴上的坐标", -100000, 100000, 0, 1, function(a)
    blackHolePos.z = a
end)
menu.action(black_hole_position, "在玩家处设定黑洞的位置", {}, "在你的人物当前位置设置黑洞的位置", function()
    blackHolePos.x = yourselfCoord.x
    blackHolePos.y = yourselfCoord.y
    blackHolePos.z = yourselfCoord.z
    blackHolePosX.value = math.floor(blackHolePos.x)
    blackHolePosY.value = math.floor(blackHolePos.y)
    blackHolePosZ.value = math.floor(blackHolePos.z)
end)

util.create_tick_handler(function()
    if ENTITY.DOES_ENTITY_EXIST(visualHelpEnt) then
        if visualHelp == true then
            ENTITY.SET_ENTITY_COORDS(visualHelpEnt, blackHolePos.x, blackHolePos.y, blackHolePos.z, false, false, false, false)
        elseif visualHelp == false then
            ENTITY.SET_ENTITY_COORDS(visualHelpEnt, 0, 0, 0, false, false, false, false)
        end
    else
        visualHelpEnt = entities.create_object(entityToSpawn, blackHolePos)
        ENTITY.FREEZE_ENTITY_POSITION(visualHelpEnt, true)
        ENTITY.SET_ENTITY_COLLISION(visualHelpEnt, true, false)
    end
    util.yield(100)
end)
util.create_tick_handler(function()
    yourself = PLAYER.GET_PLAYER_PED(players.user())
    yourselfCoord = ENTITY.GET_ENTITY_COORDS(yourself)
    if blackHole == true then
        blackHoleVehicle = entities.get_all_vehicles_as_handles()
        for index, value in ipairs(blackHoleVehicle) do
            vehiclePos = ENTITY.GET_ENTITY_COORDS(value)
            if ENTITY.DOES_ENTITY_EXIST(value) == true then
                if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(value) == false then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(value)
                end
                if blackHoleType == "black" then
                    if blackHolePos.x > vehiclePos.x then
                        pushToX = pushStrength
                    elseif blackHolePos.x < vehiclePos.x then
                        pushToX = -pushStrength
                    end
                    if blackHolePos.y > vehiclePos.y then
                        pushToY = pushStrength
                    elseif blackHolePos.y < vehiclePos.y then
                        pushToY = -pushStrength
                    end
                    if blackHolePos.z > vehiclePos.z then
                        pushToZ = pushStrength
                    elseif blackHolePos.z < vehiclePos.z then
                        pushToZ = -pushStrength
                    end
                    ENTITY.APPLY_FORCE_TO_ENTITY(value, 1, pushToX, pushToY, pushToZ, 0, 0, 0, 0, false, true, true, false)
                elseif blackHoleType == "white" then
                    if blackHolePos.x > vehiclePos.x then
                        pushToX = -pushStrength
                    elseif blackHolePos.x < vehiclePos.x then
                        pushToX = pushStrength
                    end
                    if blackHolePos.y > vehiclePos.y then
                        pushToY = -pushStrength
                    elseif blackHolePos.y < vehiclePos.y then
                        pushToY = pushStrength
                    end
                    if blackHolePos.z > vehiclePos.z then
                        pushToZ = -pushStrength
                    elseif blackHolePos.z < vehiclePos.z then
                        pushToZ = pushStrength
                    end
                    ENTITY.APPLY_FORCE_TO_ENTITY(value, 1, pushToX, pushToY, pushToZ, 0, 0, 0, 0, false, true, true, false)
                end
            end
        end
    end
end)
----------------
menu.toggle_loop(funfeatures, "神指", {"godfinger"}, "按B使用", function()
    godfinger()
end)

menu.toggle_loop(funfeatures, "烟花生成", {}, "夜空中的飞机就像流星", function()
    coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        coords['x'] = coords['x'] + math.random(-100, 100)
        coords['y'] = coords['y'] + math.random(-100, 100)
        coords['z'] = coords['z'] + math.random(30, 100)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 38, 100.0, true, false, 0.0)
    util.yield(100)
end)

--------NPC雨
vehicle_uses = 0
ped_uses = 0
pickup_uses = 0
player_uses = 0
object_uses = 0
robustmode = false
local function mod_uses(type, incr)
    if incr < 0 and is_loading then
        ls_log("Not incrementing use var of type " .. type .. " by " .. incr .. "- script is loading")
        return
    end
    ls_log("Incrementing use var of type " .. type .. " by " .. incr)
    if type == "vehicle" then
        if vehicle_uses <= 0 and incr < 0 then
            return
        end
        vehicle_uses = vehicle_uses + incr
    elseif type == "pickup" then
        if pickup_uses <= 0 and incr < 0 then
            return
        end
        pickup_uses = pickup_uses + incr
    elseif type == "ped" then
        if ped_uses <= 0 and incr < 0 then
            return
        end
        ped_uses = ped_uses + incr
    elseif type == "player" then
        if player_uses <= 0 and incr < 0 then
            return
        end
        player_uses = player_uses + incr
    elseif type == "object" then
        if object_uses <= 0 and incr < 0 then
            return
        end
        object_uses = object_uses + incr
    end
end  
rain_peds = false
menu.toggle(funfeatures, "NPC雨", {}, "...", function(on)
    rain_peds = on
    mod_uses("ped", if on then 1 else -1)
end)
peds_thread = util.create_thread(function (thr)
    while true do
        if ped_uses > 0 then
            ls_log("Ped pool is being updated")
            all_peds = entities.get_all_peds_as_handles()
            for k,ped in pairs(all_peds) do
                if kill_aura then
                    if (kill_aura_peds and not PED.IS_PED_A_PLAYER(ped)) or (kill_aura_players and PED.IS_PED_A_PLAYER(ped)) then
                        local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(v)
                        local hdl = pid_to_handle(pid)
                        if (kill_aura_friends and not NETWORK.NETWORK_IS_FRIEND(hdl)) or not kill_aura_friends then
                            target = ENTITY.GET_ENTITY_COORDS(ped, false)
                            m_coords = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
                            if MISC.GET_DISTANCE_BETWEEN_COORDS(m_coords.x, m_coords.y, m_coords.z, target.x, target.y, target.z, true) < kill_aura_dist and ENTITY.GET_ENTITY_HEALTH(ped) > 0 then
                                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(target['x'], target['y'], target['z'], target['x'], target['y'], target['z']+0.1, 300.0, true, 100416529, players.user_ped(), true, false, 100.0)
                            end
                        end
                    end
                end
                
                if not PED.IS_PED_A_PLAYER(ped) then
                    if rain_peds then 
                        if not ENTITY.IS_ENTITY_IN_AIR(ped) then 
                            local ped_c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
                            ped_c.x = ped_c.x + math.random(-50, 50)
                            ped_c.y = ped_c.y + math.random(-50, 50)
                            ped_c.z = ped_c.z + math.random(50, 100)
                            ENTITY.SET_ENTITY_COORDS(ped, ped_c.x, ped_c.y, ped_c.z)
                            ENTITY.SET_ENTITY_VELOCITY(ped, 0.0, 0.0, -1.0)
                        end
                    end
                end
            end
        end
        util.yield()
    end
end)
-------

menu.toggle(funfeatures, "陨落的飞机", {},"", function(on)
    angry_planes = on
    start_angryplanes_thread()
end)

menu.action(funfeatures,"生成多米诺骨牌", {}, "", function()
    local hash = util.joaat("prop_boogieboard_01")
    request_model_load(hash)
    local last_ent = players.user_ped()
    for i=2, 25 do 
        local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(last_ent, 0, -i, 0)
        local d = entities.create_object(hash, c)
        ENTITY.SET_ENTITY_HEADING(d, ENTITY.GET_ENTITY_HEADING(last_ent))
        OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(d)
    end
end)

menu.toggle_loop(funfeatures, "一拳超人", {""}, "", function()
    supermanpersonl()
end)

menu.toggle_loop(funfeatures, "原力", {}, "通过鼠标左键或右键来控制", function()
    local other = menu
	if state == 0 then
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


Targeted_bombing = menu.toggle_loop(funfeatures, "定点轰炸", {"pointbombing"}, "标点指定轰炸", function ()
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

menu.toggle_loop(funfeatures, "地毯飞行", {"carpetride"}, "", function()
    carpetridexx()
        end,function()
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        ENTITY.DETACH_ENTITY(players.user_ped(), true, false)
        ENTITY.SET_ENTITY_VISIBLE(object, false, false)
        entities.delete_by_handle(object)
        state = 0
end)

menu.toggle(funfeatures, "忍者跑",{""}, "忍者跑步动作",function(on)--===heezy
    renzhepao(on)
end)
menu.toggle(funfeatures, "举起手来",{""}, "长按x",function(state)
    handsup = state
    while handsup do
        juqishoulai()
        util.yield()
    end
end)

menu.action(funfeatures, "自定义假R*警告", {"banner"}, "汉字可通过cv", function(on_click) 
    menu.show_command_box("banner ") 
end, 
    function(text)
    custom_alert(text)
end)

local explosion_circle_angle = 0
    menu.toggle_loop(funfeatures, "爆炸圈", {}, "在周围生成爆炸圈", function ()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        explosion_circle(ped, explosion_circle_angle, 25)
        explosion_circle_angle += 0.15
        util.yield(50)
    end)

----钢铁侠
local startViewMode
local scope_scaleform
local gaveHelmet = false
menu.toggle_loop(funfeatures, '钢铁侠', {}, '', function()
    menu.trigger_commands("levitate on")
    if not PED.IS_PED_WEARING_HELMET(players.user_ped()) then
        PED.GIVE_PED_HELMET(players.user_ped(), true, 4096, -1)
        gaveHelmet = true
    end
    local context = CAMdaidai._GET_CAM_ACTIVE_VIEW_MODE_CONTEXT()
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
    if not PADdaidai._IS_USING_KEYBOARD(0) then
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
    HUDdaidai._HUD_WEAPON_WHEEL_IGNORE_CONTROL_INPUT(false)
    local pScaleform = memory.alloc_int()
    memory.write_int(pScaleform, scope_scaleform)
    GRAPHICS.SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED(pScaleform)
    menu.trigger_commands("levitate off")
    util.yield()
    CAM.SET_CAM_VIEW_MODE_FOR_CONTEXT(CAMdaidai._GET_CAM_ACTIVE_VIEW_MODE_CONTEXT(), startViewMode)
    startViewMode = nil
end)
-------------------
----------------------------------------------------UFO--------------------------------------
local num = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
    "32",
    "33",
    "34",
    "35"
}
local ufo = util.joaat("sum_prop_dufocore_01a")
local dufo = util.joaat("imp_prop_ship_01a")
menu.toggle_loop(funfeatures, "UFO勇闯洛城", {}, "在你的周围随机生成UFO", function(toggle)
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local r = num[math.random(#num)]
    c.x = math.random(0.0,1.0) >= 0.5 and c.x + r + 5 or c.x - r - 5 --set x coords
    c.y = math.random(0.0,1.0) >= 0.5 and c.y + r + 5 or c.y - r - 5 --set y coords
    c.z = c.z + r + 8 --set z coords
    STREAMING.REQUEST_MODEL(ufo)
    while not STREAMING.HAS_MODEL_LOADED(ufo) do
        STREAMING.REQUEST_MODEL(ufo)
        util.yield()
    end
    util.yield(2500)
    local spawnedufo = entities.create_object(ufo, c) --spawn ufo
    util.yield(500)
    local ufoc = ENTITY.GET_ENTITY_COORDS(spawnedufo) --get ufo pos
    local success, floorcoords
    repeat
        success, floorcoords = util.get_ground_z(ufoc.x, ufoc.y) --get floor pos
        util.yield()
    until success
    FIRE.ADD_EXPLOSION(ufoc.x, ufoc.y, floorcoords, exp, 100.0, true, false, 1.0, false) --explode at floor
    util.yield(1500)
    entities.delete_by_handle(spawnedufo) --delete ufo

    if not STREAMING.HAS_MODEL_LOADED(ufo) then
        util.toast("无法加载模型")
    end
end)
----------------------------------------------------UFO--------------------------------------

menu.toggle(funfeatures, "洛城暴乱", {}, "开启后，周围的npc会进入无差别攻击模式！", function(toggle)
    MISC.SET_RIOT_MODE_ENABLED(toggle)
end)

jinx_cats = menu.list(funfeatures, "宠物猫", {}, "")
    local jinx_pet
    jinx_toggle = menu.toggle_loop(jinx_cats, "宠物猫", {}, "招一只可爱的小猫咪\n跟着你喵喵叫！", function()
        if not jinx_pet or not ENTITY.DOES_ENTITY_EXIST(jinx_pet) then
            local jinx = util.joaat("a_c_cat_01")
            request_model(jinx)
            local pos = players.get_position(players.user())
            jinx_pet = entities.create_ped(28, jinx, pos, 0)
            PED.SET_PED_COMPONENT_VARIATION(jinx_pet, 0, 0, 1, 0)
            ENTITY.SET_ENTITY_INVINCIBLE(jinx_pet, true)
        end
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(jinx_pet)
        TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(jinx_pet, players.user_ped(), 0, -0.3, 0, 7.0, -1, 1.5, true)
        util.yield(2500)
    end, function()
        entities.delete_by_handle(jinx_pet)
        jinx_pet = nil
    end)

    menu.action(jinx_cats, "找到猫猫", {}, "将猫猫传送到你身边", function()
            local player = players.user_ped()
            local pos = ENTITY.GET_ENTITY_COORDS(player, false)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(jinx_pet, pos.x, pos.y, pos.z, false, false, false)
        end)


    local jinx_army = {}
    local army = menu.list(jinx_cats, "宠物猫猫军队", {}, "哈哈哈，一群小猫猫")
    menu.click_slider(army, "生成数量", {}, "选吧，多生成点，最多256只", 1, 256, 30, 1, function(val)
        local ped = players.user_ped()
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        pos.y = pos.y - 5
        pos.z = pos.z + 1
        local jinx = util.joaat("a_c_cat_01")
        request_model(jinx)
        for i = 1, val do
            jinx_army[i] = entities.create_ped(28, jinx, pos, 0)
            ENTITY.SET_ENTITY_INVINCIBLE(jinx_army[i], true)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(jinx_army[i], true)
            PED.SET_PED_COMPONENT_VARIATION(jinx_army[i], 0, 0, 1, 0)
            TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(jinx_army[i], ped, 0, -0.3, 0, 7.0, -1, 10, true)
            util.yield()
        end 
    end)

    menu.action(army, "清除宠物猫", {}, "", function()
        for i, ped in ipairs(entities.get_all_peds_as_handles()) do
            if PED.IS_PED_MODEL(ped, util.joaat("a_c_cat_01")) then
                entities.delete_by_handle(ped)
            end
        end
    end)


menu.toggle_loop(funfeatures, "激光眼", {"lasereyes"}, "按住E键", function(on)
    laser_eyes()
end)

local hash = util.joaat("VEHICLE_WEAPON_PLAYER_LAZER")
local showNotification = true
local lastShot = newTimer()
local sound = Sound.new("Fire_Loop", "DLC_IE_VV_Gun_Player_Sounds")

local DisableControlActions = function()
    PAD.DISABLE_CONTROL_ACTION(0, 106, true)
    PAD.DISABLE_CONTROL_ACTION(0, 122, true)
    PAD.DISABLE_CONTROL_ACTION(0, 135, true)
    PAD.DISABLE_CONTROL_ACTION(0, 140, true)
    PAD.DISABLE_CONTROL_ACTION(0, 141, true)
    PAD.DISABLE_CONTROL_ACTION(0, 142, true)
    PAD.DISABLE_CONTROL_ACTION(0, 263, true)
    PAD.DISABLE_CONTROL_ACTION(0, 264, true)
end
menu.toggle_loop(funfeatures, "镭射眼", {}, "按住E键", function()
        
    HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME()
    DisableControlActions()
    if not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) then
        WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 26)
    end

    if not PAD.IS_DISABLED_CONTROL_PRESSED(51, 51) then
        if not sound:hasFinished() then
            sound:stop()
        end
    elseif lastShot.elapsed() > 100 then
        local pos = PED.GET_PED_BONE_COORDS(players.user_ped(), 0x322C, 0.0, 0.0, 0.0)
        local offset = get_offset_from_cam(80)
        if  sound:hasFinished() then
            sound:playFromEntity(players.user_ped())
            AUDIO.SET_VARIABLE_ON_SOUND(sound.Id, "fireRate", 10.0)
        end
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
            pos.x, pos.y, pos.z,
            offset.x, offset.y, offset.z,
            200,
            true,
            hash, players.user_ped(), true, true, -1.0
        )
        lastShot.reset()
    end
end, function()
    if not sound:hasFinished() then
        sound:stop()
    end
end)

finger_thing = menu.list(funfeatures, "手指枪", {}, "按B键")
shouzhiqiang()

local obj
menu.toggle(funfeatures, "力场", {}, "", function(toggled)
    local mdl = util.joaat("p_spinning_anus_s")
    local playerpos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    request_model(mdl)
    if toggled then
        obj = entities.create_object(mdl, playerpos)
        ENTITY.SET_ENTITY_VISIBLE(obj, false)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, players.user_ped(), 0, 0, 0, 0, 0, 0, 0, false, false, true, false, 0, false, 0)
    else
        if obj ~= nil then 
            entities.delete_by_handle(obj)
        end
    end
end)


-----------------------------------------
airplane_collapsed = menu.list(sk, "飞机模型崩溃", {}, "慎用")
    menu.toggle_loop(airplane_collapsed, "开始", {}, "耗时很久", function()
        airplane_collapsed1()
    end)
    players.dispatch_on_join()
    menu.action(airplane_collapsed, "防崩镜头关闭", {}, "", function()
        menu.trigger_commands("anticrashcamera off")
    end)

menu.action(sk, "大春逗崩溃", {}, "", function()
    big_chungus()
end)

menu.action(sk, "崩溃主机", {}, "使用前请确认自己是否为主机", function(PlayerID)
    hostcrash(PlayerID)
end)

    menu.action(sk, "人物伞崩V1", {}, "", function()
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
menu.action(sk,"人物伞崩V2", {}, "", function()
    for n = 0 , 5 do
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
        for i = 0 , 20 do
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
        bush_hash = 720581693
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
menu.action(sk,"人物伞崩V3",{},"",function()
    for n = 0 , 5 do
        PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        object_hash =192829538
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
        bush_hash = 	192829538
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
menu.action(sk,"人物伞崩V4",{},"",function()
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
end)

menu.action(sk,"CARGO崩溃",{},"崩溃所有玩家",function()
    CARGO()
    end)

menu.action(sk, "大自然全局崩溃", {}, "", function()
    nature()
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
menu.action(sk, "懂哥崩溃", {"By MMT"}, "", function()
    util.toast("I'll try to convince them to leave :) ")
    PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),0xE5022D03)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
    util.yield(20)
    local p_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),p_pos.x,p_pos.y,p_pos.z,false,true,true)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()), 0xFBAB5776, 1000, false)
    TASK.TASK_PARACHUTE_TO_TARGET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1087,-3012,13.94)
    util.yield(500)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
    util.yield(1000)
    PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID())
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
 end)
 menu.action(sk, "数学崩溃", {}, "", function()
    math1()
    notification("滚吧！！" ,colors.green)
end)
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
local function rotatePoint(x, y, center, degrees)
    local radians = math.rad(degrees)
    local new_x = (x - center.x) * math.cos(radians) - (y - center.y) * math.sin(radians)
    local new_y = (x - center.x) * math.sin(radians) + (y - center.y) * math.cos(radians)
    return center.x + new_x, center.y + new_y * 1920 / 1080
end
 menu.action(sk, "全局顶崩", {}, "", function()
    unknown()
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
 function unknown()
    local spped = PLAYER.PLAYER_PED_ID()
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
    SelfPlayerPos.x = SelfPlayerPos.x + 10
    TTPos.x = TTPos.x + 10
    local carc = CreateObject(util.joaat("apa_prop_flag_china"), TTPos, ENTITY.GET_ENTITY_HEADING(spped), true)
    local carcPos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
    local pedc = CreatePed(26, util.joaat("A_C_HEN"), TTPos, 0)
    local pedcPos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
    local ropec = PHYSICS.ADD_ROPE(TTPos.x, TTPos.y, TTPos.z, 0, 0, 0, 1, 1, 0.00300000000000000000000000000000000000000000000001, 1, 1, true, true, true, 1.0, true, 0)
    PHYSICS.ATTACH_ENTITIES_TO_ROPE(ropec,carc,pedc,carcPos.x, carcPos.y, carcPos.z ,pedcPos.x, pedcPos.y, pedcPos.z,2, false, false, 0, 0, "Center","Center")
    util.yield(3500)
    PHYSICS.DELETE_CHILD_ROPE(ropec)
    entities.delete_by_handle(pedc)
end

 menu.action(sk, "5G崩溃", {""}, "", function()
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
menu.action(sk,"冷战崩溃",{},"崩崩崩",function()
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
 menu.action(sk,"声音崩溃战局", {}, "", function()
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

---------------------------------------------------玩家选项--------------------------------------
players.on_join(function(pid)
    menu.divider(menu.player_root(pid), "daidai_Script")
    local Player_list = menu.list(menu.player_root(pid), "daidai脚本", {"daidai"}, F)

    menu.toggle(Player_list, "观看玩家", {}, "", function(toggle)
        menu.trigger_commands("spectate".. players.get_name(pid), toggle)
    end)
    menu.action(Player_list, "宣布玩家", {}, "公屏宣布他的rid", function()
        chat.send_message(PLAYER.GET_PLAYER_NAME(pid).."的rid为: "..players.get_rockstar_id(pid),false,true,true)
    end)
    menu.toggle_loop(Player_list, "自动传送到玩家", {}, "当与玩家的距离大于3时自动传送到玩家", function()
        local playerpos = players.get_position(pid)
        local mypos = players.get_position(players.user())
        local distance = math.ceil(MISC.GET_DISTANCE_BETWEEN_COORDS(playerpos.x, playerpos.y, playerpos.z, mypos.x, mypos.y, mypos.z))
        util.toast(distance)
        if distance > 3 then
            TELEPORT(playerpos.x, playerpos.y, playerpos.z)
        end
    end)

    local friendly = menu.list(Player_list, "友好选项", {}, "")
    local trolling = menu.list(Player_list, "恶搞选项", {}, "")
    local kickplayer = menu.list(Player_list, "踢出玩家", {}, "")
    local crashplayer = menu.list(Player_list, "崩溃玩家", {}, "")
    local cussinglayer = menu.list(Player_list, "猛怼玩家", {}, "使劲骂他")

--Check for modder
    menu.action(Player_list, "玩家自检", {}, "检测是否为作弊玩家", function() 
        is_player_modder(pid) 
    end)

------友好选项
menu.action(friendly,"升级车辆", {}, "", function()
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vehicle = PED.GET_VEHICLE_PED_IS_USING(player_ped)
    request_control_of_entity(vehicle)
    upgrade_vehicle(vehicle)
end)
menu.toggle_loop(friendly, "给予爆炸子弹", {""}, "", function ()
    local pped = PLAYER.GET_PLAYER_PED(pid)
    local impactCoord = v3.new()
    local shot = WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(pped, impactCoord)
    if shot then
        local explo = {x = v3.getX(impactCoord), y = v3.getY(impactCoord), z = v3.getZ(impactCoord)}
        local explo = GetTableFromV3Instance(impactCoord)
        SE_add_owned_explosion(pped, explo.x, explo.y, explo.z, 2, 10, true,false, 0)
    end
    v3.free(impactCoord)
end)


dropRP = menu.list(friendly, "天降RP值", {}, "")
    rpdropDelay = 1500
    menu.slider(dropRP, "RP天降延迟", {}, "RP天降延迟", 100, 10000, 1500, 100, function(rpDelay)
        rpDropDelay = rpDelay
    end)
    menu.toggle_loop(dropRP, "天降RP", {}, "RP天降，但延迟可调", function()
        local coords = players.get_position(pid)
        coords.z = coords.z + 1.5
        local figure = MISC.GET_HASH_KEY("vw_prop_vw_colle_prbubble")
        STREAMING.REQUEST_MODEL(figure)
        if STREAMING.HAS_MODEL_LOADED(figure) == false then  
            STREAMING.REQUEST_MODEL(figure)
        end
        OBJECT.CREATE_AMBIENT_PICKUP(-1009939663, coords.x, coords.y, coords.z, 0, 1, figure, false, true)
        util.yield(rpDropDelay)
    end)
dropCard = menu.list(friendly, "天降收集牌", {}, "")
    cardDropDelay = 1500
    menu.slider(dropCard, "收集牌延迟", {}, "延迟收集牌", 100, 10000, 1500, 100, function(cardDelay)
        cardDropDelay = cardDelay
    end)
    menu.toggle_loop(dropCard, "天降收集牌", {}, "玩家每次只能拾取54张牌，请注意，这还没有测试过禁令，但应该是安全的", function()
        local coords = players.get_position(pid)
        coords.z = coords.z + 1.5
        local card = MISC.GET_HASH_KEY("vw_prop_vw_lux_card_01a")
        STREAMING.REQUEST_MODEL(card)
        if STREAMING.HAS_MODEL_LOADED(card) == false then  
            STREAMING.REQUEST_MODEL(card)
        end
        OBJECT.CREATE_AMBIENT_PICKUP(-1009939663, coords.x, coords.y, coords.z, 0, 1, card, false, true)
        util.yield(cardDropDelay)
    end)

-----------------------------------------------------------------恶搞选项
kill_godmode = menu.list(trolling, "击杀玩家", {}, "")
lz = menu.list(trolling, "套笼子", {}, "")
npc_trolling = menu.list(trolling, "NPC恶搞", {}, "")
weapon_trolling = menu.list(trolling, "武器恶搞", {}, "")
vehicle_car = menu.list(trolling, "载具恶搞", {}, "")
tp_player_trolling = menu.list(trolling, "发送玩家", {}, "")
entspam_root = menu.list(trolling, "生成实体垃圾", {}, "")

menu.toggle_loop(trolling, "电击玩家", {}, "", function()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = players.get_position(pid)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 1000, true, util.joaat("weapon_stungun"), false, false, true, 1.0)
end)
send_sms = menu.list(trolling, "发送短信", {}, "")
    local mmessage = "您已被永久禁止进入Grand Theft Auto 在线模式"
    menu.text_input(send_sms, "自定义短信", {"customizemmessage"}, "", function(value)
        mmessage = value
    end,mmessage)
    local ffont_size = 11
    menu.slider(send_sms, "字体尺寸", {"fonttextsize"}, "", 1, 20, 11, 1, function (value)
        ffont_size = value
    end)
    menu.action(send_sms,  "发送", {}, "", function()
        menu.trigger_commands("smstext" .. PLAYER.GET_PLAYER_NAME(pid).. " " .. "<font size='"..ffont_size.. "'>~w~"..mmessage)
        menu.trigger_commands("smssend" .. PLAYER.GET_PLAYER_NAME(pid))
    end)

menu.click_slider(trolling, "虚假抢钱", {}, "", 0, 2147483647, 0, 1000, function(amount)
    util.trigger_script_event(1 << pid, {548471420, players.user(), 532932991, amount, 0, 0, 0, 0, 0, 0, pid, players.user(), 0, 0})
    util.trigger_script_event(1 << players.user(), {548471420, players.user(), 532932991, amount, 0, 0, 0, 0, 0, 0, pid, players.user(), 0, 0})
end)
bountyplayer = menu.list(trolling, "给予悬赏", {}, "")
    local bounty_amount = 10000
    menu.action(bountyplayer,"悬赏",{""},"",function()
        local name = PLAYER.GET_PLAYER_NAME(pid)
        menu.trigger_commands("bounty"..name.." "..bounty_amount)
    end)
    bountyplayer:slider("悬赏金额",{"Bountyamountplayer"},"",1,10000,10000,1000,function(amount)
        bounty_amount = amount
    end)
menu.action(trolling,  "踢出室内", {}, "强制将玩家踢出室内.", function()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
    local glitch_hash = util.joaat("p_spinning_anus_s")
    local poopy_butt = util.joaat("brickade2")
    request_model(glitch_hash)
    request_model(poopy_butt)
    for i = 1, 5 do
        local stupid_object = entities.create_object(glitch_hash, pos)
        local glitch_vehicle = entities.create_vehicle(poopy_butt, pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(stupid_object, false)
        ENTITY.SET_ENTITY_VISIBLE(glitch_vehicle, false)
        ENTITY.SET_ENTITY_INVINCIBLE(glitch_vehicle, true)
        ENTITY.SET_ENTITY_COLLISION(stupid_object, true, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(glitch_vehicle, 1, 0.0, 10, 10, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        util.yield(500)
        entities.delete_by_handle(stupid_object)
        entities.delete_by_handle(glitch_vehicle)
        util.yield(500)     
    end
end)
--------武器恶搞
	menu.toggle_loop(weapon_trolling, "重型狙击枪", {}, "", function()
		local hash <const> = util.joaat("weapon_heavysniper")
		local camPos = CAM.GET_GAMEPLAY_CAM_COORD()
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)
		request_weapon_asset(hash)
		WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(camPos.x, camPos.y, camPos.z, pos.x, pos.y, pos.z, 200, false, hash, players.user_ped(), true, false, -1.0)
	end)
	menu.toggle_loop(weapon_trolling, "烟花", {"Fireworksdownward"}, "", function()
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)
		local hash <const> = util.joaat("weapon_firework")
		request_weapon_asset(hash)
		WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 3.0, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
	end)
	menu.toggle_loop(weapon_trolling, "原子波", {}, "", function()
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)
		local hash <const> = util.joaat("weapon_raypistol")
		request_weapon_asset(hash)
		WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 3.0, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
	end)
	menu.toggle_loop(weapon_trolling, "燃烧弹", {}, "", function()
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)
		local hash <const> = util.joaat("weapon_molotov")
		request_weapon_asset(hash)
		WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
	end)
	menu.toggle_loop(weapon_trolling, "电磁脉冲发射器", {}, "", function()
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)
		local hash <const> = util.joaat("weapon_emplauncher")
		request_weapon_asset(hash)
		WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
	end)

menu.toggle(trolling, "烟花发射玩家", {}, "", function(on)
    if on then
        menu.trigger_commands("Bouncetheplayerfly"..PLAYER.GET_PLAYER_NAME(pid))
        util.yield(2000)
        menu.trigger_commands("Fireworksdownward"..PLAYER.GET_PLAYER_NAME(pid))
    else
        menu.trigger_commands("Bouncetheplayerfly"..PLAYER.GET_PLAYER_NAME(pid))
        menu.trigger_commands("Fireworksdownward"..PLAYER.GET_PLAYER_NAME(pid)) 
    end
end)
fire_work_show = menu.list(trolling, "烟火秀", {}, "")
    local firw = {speed = 1000}
    menu.toggle_loop(fire_work_show, '头顶烟火', {}, '开始一场烟火秀', function ()
        local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
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
        menu.toggle_loop(fire_work_show, '脚下烟火', {}, '', function ()
            local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
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
menu.toggle_loop(trolling, '假钱雨', {}, '', function ()
    local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
    Streamptfx('core')
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD( 'ent_brk_banknotes', tar1.x, tar1.y, tar1.z + 1, 0, 0, 0, 3.0, true, true, true)
    if not players.exists(pid) then
        util.stop_thread()
    end
end)

-----------------笼子
menu.action(lz, "树木笼子", {}, "", function()
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    spam_entity_on_player(target_ped, -37176073)
end)
menu.action(lz, "关门放狗", {}, "", function(on_click)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(ped, true)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    local hash = 779277682
    request_model_load(hash)
    local cage1 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage1, 0.0, -90.0, 0.0, 1, true)
    local cage2 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage2, 0.0, 90.0, 0.0, 1, true)
    util.yield(100)
    for i = 1, 20 do
        send_attacker(-1788665315, pid, false)
        util.yield(1)
    end
end)
menu.action(lz, "恐怖之牢", {}, "听说半夜能吓死人", function(on_click)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(ped, true)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    local hash = 779277682
    request_model_load(hash)
    local cage1 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage1, 0.0, -90.0, 0.0, 1, true)
    local cage2 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage2, 0.0, 90.0, 0.0, 1, true)
    util.yield(100)
    for i = 1, 20 do
        send_attacker(util.joaat("CS_BradCadaver"), pid, false)
        util.yield(1)
    end
end)
menu.action(lz, "普通笼子", {""}, "", function ()
    ptlz(pid)
end)
menu.action(lz, "小的竞技管", {"captivity"}, "", function(on_click)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(ped, true)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    local hash = 779277682
    request_model_load(hash)
    local cage1 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage1, 0.0, -90.0, 0.0, 1, true)
    local cage2 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage2, 0.0, 90.0, 0.0, 1, true)
end)
menu.action(lz, "竖向货机笼子", {}, "", function(click_type)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.0, 5.0)
    --local hash = util.joaat("prop_ld_crate_01")
    local hash = util.joaat('titan')
    request_model_load(hash)
    local cage = entities.create_vehicle(hash, coords, 0)
    ENTITY.SET_ENTITY_ROTATION(cage, 90, 0, 0, 0)
    --ENTITY.FREEZE_ENTITY_POSITION(cage, true)
    ENTITY.SET_ENTITY_INVINCIBLE(cage, true)
    ENTITY.FREEZE_ENTITY_POSITION(cage, true)
end)
menu.action(lz, "横行货机笼子", {}, "", function(click_type)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.0, 0.0)
    local hash = util.joaat("cargoplane")
    request_model_load(hash)
    local cargo = entities.create_vehicle(hash, coords, ENTITY.GET_ENTITY_HEADING(ped))
    ENTITY.FREEZE_ENTITY_POSITION(cargo, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(cargo, coords.x, coords.y, coords.z-0.1, true, false, false)
    ENTITY.SET_ENTITY_INVINCIBLE(cargo, true)
    for i=1, 5 do
        VEHICLE.SET_VEHICLE_DOOR_LATCHED(cargo, i, true, true, true)
    end
end)
menu.action(lz, "随机笼子", {}, "", function ()
    menu.trigger_commands("cage".. players.get_name(pid))
end)
menu.toggle_loop(lz, "全自动随机笼子", {}, "每个一秒套一次", function ()
    menu.trigger_commands("cage".. players.get_name(pid))
    util.yield(1000)
end)
menu.action(lz, "七度空间", {""}, "", function ()
    qdkj(pid)
end)
menu.action(lz, "钱笼子", {""}, "", function ()
    zdlz(pid)
end)
menu.action(lz, "垃圾箱", {""}, "", function ()
    yylz(pid)
end)
menu.action(lz, "小车车", {""}, "", function ()
    cclz(pid)
end)
menu.action(lz, "圣诞树", {""}, "", function ()
    sdkl1(pid)
end)
menu.action(lz, "圣诞快乐pro", {""}, "", function ()
    sdkl2(pid)
end)
menu.action(lz, "圣诞快乐promax", {""}, "", function ()
    sdkl3(pid)
end)
menu.action(lz, "竞技管", {""}, "", function ()
    jjglz(pid)
end, nil, nil, COMMANDPERM_AGGRESSIVE)

----------NPC恶搞
menu.action(npc_trolling, "派遣劫匪", {}, "", function()
    sendmugger_npc(pid)
end)

menu.action(npc_trolling, "苦力怕小丑(MC里的爬行者)", {}, "", function()
    creep(pid)
end, nil, nil, COMMANDPERM_RUDE)


attackers_root = menu.list(npc_trolling, "攻击者", {}, "")
    menu.action(attackers_root, "狗子攻击者", {}, "arf uwu", function(on_click)
        send_attacker(-1788665315, pid, false)
    end)
    menu.action(attackers_root, "山狮攻击者", {}, "rawr", function(on_click)
        send_attacker(307287994, pid, false)
    end)
    menu.action(attackers_root, "布拉德攻击者", {}, "恐怖的\n没有下体", function(on_click)
        send_attacker(util.joaat("CS_BradCadaver"), pid, false)
    end)
    menu.action(attackers_root, "悲伤的耶稣", {}, "产生一个不可战胜的耶稣和一个轨道枪，将不断攻击玩家，即使他们死后。如果他们太远，传送到他们。这有时会非常容易出错，但通常是由于网络", function(on_click)
        dispatch_griefer_jesus(pid)
    end)
    menu.action(attackers_root, "天煞战斗机", {}, "", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, 1.0, 0.0, 500.0)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z']
        local hash = util.joaat("lazer")
        request_model_load(hash)
        request_model_load(-163714847)
        for i=1, num_attackers do
            coords.x = coords.x + i*2
            coords.y = coords.y + i*2
            local jet = entities.create_vehicle(hash, coords, 0.0)
            VEHICLE.CONTROL_LANDING_GEAR(jet, 3)
            VEHICLE.SET_HELI_BLADES_FULL_SPEED(jet)
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(jet, VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(jet))
            if godmodeatk then
                ENTITY.SET_ENTITY_INVINCIBLE(jet, true)
            end
            local pilot = entities.create_ped(28, -163714847, coords, 30.0)
            PED.SET_PED_COMBAT_ATTRIBUTES(pilot, 5, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(pilot, 46, true)
            PED.SET_PED_INTO_VEHICLE(pilot, jet, -1)
            TASK.TASK_PLANE_MISSION(pilot, jet, 0, target_ped, 0, 0, 0, 6, 0.0, 0, 0.0, 50.0, 40.0)
            TASK.TASK_COMBAT_PED(pilot, target_ped, 0, 16)
            PED.SET_PED_ACCURACY(pilot, 100.0)
            PED.SET_PED_COMBAT_ABILITY(pilot, 2)
        end
    end)
    menu.action(attackers_root, "A10轰炸机", {}, "", function(on_click)
        send_aircraft_attacker(1692272545, -163714847, pid)
    end)
    menu.action(attackers_root, "派货机", {}, "", function(on_click)
        send_aircraft_attacker(util.joaat("cargoplane"), -163714847, pid)
    end)

--------------------------------生成实体垃圾
bullet_rain = false
bullet_rain_target = -1
num_of_spam = 30
entity_grav = true
menu.action(entspam_root, "肿瘤", {}, "", function()
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    spam_entity_on_player(target_ped, 148511758)
end)
menu.action(entspam_root, "肿瘤2", {}, "", function()
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    spam_entity_on_player(target_ped, -26957549)
end)
menu.action(entspam_root, "肿瘤3", {}, "", function()
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    spam_entity_on_player(target_ped, 1467574459)
end)
menu.action(entspam_root, "树木", {}, "", function()
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    spam_entity_on_player(target_ped, -37176073)
end)
menu.action(entspam_root, "交通锥", {}, "生成交通锥", function(on_click)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    spam_entity_on_player(target_ped, 3760607069)
end)
menu.action(entspam_root, "假鸡巴", {}, "给爷冲", function(on_click)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    spam_entity_on_player(target_ped, 3872089630)
end)
menu.action(entspam_root, "热狗", {}, "", function(on_click)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    spam_entity_on_player(target_ped, 2565741261)
end)
menu.action(entspam_root, "热狗摊", {}, "", function(on_click)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    spam_entity_on_player(target_ped, 2713464726)
end)
menu.action(entspam_root, "摩天轮", {}, "", function(on_click)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    spam_entity_on_player(target_ped, 3291218330)
end)
menu.action(entspam_root, "过山车", {}, "欢乐时光", function(on_click)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    spam_entity_on_player(target_ped, 3413442113)
end)
menu.action(entspam_root, "空中雷达", {}, "让他们旋转", function(on_click)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    spam_entity_on_player(target_ped, 2306058344)
end)


pteleportEntities = menu.list(trolling, "发送垃圾", {}, "给他生成一推垃圾玩意")
    menu.action(pteleportEntities, "NPC", {""}, "", function ()
        TpAllPeds(pid)
    end)
    menu.action(pteleportEntities, "载具", {""}, "", function ()
        TpAllVehs(pid)
    end)
    menu.action(pteleportEntities, "实体", {""}, "", function ()
        TpAllObjects(pid)
    end)
    menu.action(pteleportEntities, "拾取物", {""}, "", function ()
        TpAllPickups(pid)
    end)

menu.action(trolling, "送进监狱", {}, "将此玩家传送到博林布鲁克监狱", function()
    local my_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    local my_ped = PLAYER.GET_PLAYER_PED(players.user())
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(my_ped, 1628.5234, 2570.5613, 45.56485, true, false, false, false)
    menu.trigger_commands("givesh " .. players.get_name(pid))
    menu.trigger_commands("summon " .. players.get_name(pid))
    menu.trigger_commands("invisibility on")
    menu.trigger_commands("otr")
    util.yield(5000)
    menu.trigger_commands("invisibility off")
    menu.trigger_commands("otr")
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(my_ped, my_pos.x, my_pos.y, my_pos.z)
end)

menu.action(trolling, "喷射", {"peeloop"}, "", function(state)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local bone_index = PED.GET_PED_BONE_INDEX(player_ped, 0x2e28)
    request_ptfx_asset_peeloop("core_snow")
    GRAPHICS.USE_PARTICLE_FX_ASSET("core_snow")
    ptfx_id = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(
        "cs_mich1_spade_dirt_throw", player_ped, 0, 0, 0, -90, 0, 0, bone_index, 2, false, false, false
    ) 
end)


local glitchForcefield = false
local glitchforcefield_toggle
    glitchforcefield_toggle = menu.toggle(trolling, "范围删除", {}, "将玩家附近的模型删除", function(toggled)
        glitchForcefield = toggled
        local glitch_hash = util.joaat("p_spinning_anus_s")
        request_model(glitch_hash)

        while glitchForcefield do
            local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local playerpos = ENTITY.GET_ENTITY_COORDS(player, false) 
            if PED.IS_PED_IN_ANY_VEHICLE(player, true) then
                    deleplayercar(pid)
                end
            local stupid_object = entities.create_object(glitch_hash, playerpos)
            ENTITY.SET_ENTITY_VISIBLE(stupid_object, false)
            ENTITY.SET_ENTITY_INVINCIBLE(stupid_object, true)
            ENTITY.SET_ENTITY_COLLISION(stupid_object, true, true)
            util.yield()
            entities.delete_by_handle(stupid_object)
            util.yield()    
        end
    end)

player_toggle_loop(trolling,pid, "弹飞玩家", {"Bouncetheplayerfly"}, "也适用于载具", function() 
    local poopy_butt = util.joaat("adder")
    local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(player)
    pos.z -= 10
    request_model(poopy_butt)
    local vehicle = entities.create_vehicle(poopy_butt, pos, 0)
    ENTITY.SET_ENTITY_VISIBLE(vehicle, false)
    util.yield(250)
    if vehicle ~= 0 then
        ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 100, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        util.yield(250)
        entities.delete_by_handle(vehicle)
    end
end)

----------------------击杀玩家
local function RequestModel(hash, timeout)
    timeout = timeout or 3
    STREAMING.REQUEST_MODEL(hash)
    local end_time = os.time() + timeout
    repeat
        util.yield()
    until STREAMING.HAS_MODEL_LOADED(hash) or os.time() >= end_time
    return STREAMING.HAS_MODEL_LOADED(hash)
end
menu.action(kill_godmode, "死亡屏障击杀", {}, "对大多数菜单有效。(注意：只有在目标没有使用禁用死亡障碍的情况下才会起作用。)", function()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = players.get_position(pid)                            
    local hash = util.joaat("prop_windmill_01")
    local mdl = util.joaat("rallytruck")
    RequestModel(hash)
    RequestModel(mdl)
    for i = 0, 5 do
        if TASK.IS_PED_WALKING(ped) then
            spawn_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.5, 0.0)
        elseif TASK.IS_PED_WALKING(ped) then
            spawn_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 1.3, 0.0)
        else
            spawn_pos = players.get_position(pid)
        end
        local obj = entities.create_object(hash, spawn_pos)
        local veh = entities.create_vehicle(mdl, spawn_pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(obj, false)
        ENTITY.SET_ENTITY_VISIBLE(veh, false)
        ENTITY.SET_ENTITY_INVINCIBLE(obj, true)
        ENTITY.SET_ENTITY_COLLISION(obj, true, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 10, 10, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        util.yield(150)
        entities.delete_by_handle(obj)
        entities.delete_by_handle(veh)
    end
end)
player_toggle_loop(kill_godmode, pid, "移除玩家无敌", {}, "被大多数菜单拦截", function()
    util.trigger_script_event(1 << pid, {0xAD36AA57, pid, 0x96EDB12F, math.random(0, 0x270F)})
end)
menu.action(kill_godmode, "杀死无敌玩家v1", {""}, "普通击杀", function()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 99999, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
end)
menu.slider_text(kill_godmode, "杀死无敌玩家v2", {}, "强制击杀", {"Khanjali", "APC"}, function(index, veh)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    local vehicle = util.joaat(veh)
    request_model(vehicle)

    switch veh do
        case "Khanjali":
        height = 2.8
        offset = 0
        break
        case "APC":
        height = 3.4
        offset = -1.5
        break
end
    if TASK.IS_PED_STILL(ped) then
        distance = 0
    elseif not TASK.IS_PED_STILL(ped) then
        distance = 3
end
    local vehicle1 = entities.create_vehicle(vehicle, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, offset, distance, height), ENTITY.GET_ENTITY_HEADING(ped))
    local vehicle2 = entities.create_vehicle(vehicle, pos, 0)
    local vehicle3 = entities.create_vehicle(vehicle, pos, 0)
    local vehicle4 = entities.create_vehicle(vehicle, pos, 0)
    local spawned_vehs = {vehicle4, vehicle3, vehicle2, vehicle1}
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
    ENTITY.SET_ENTITY_VISIBLE(vehicle1, false)
    util.yield(5000)
    for i = 1, #spawned_vehs do
        entities.delete_by_handle(spawned_vehs[i])
    end
end)   
player_toggle_loop(kill_godmode, pid, "炸死无敌玩家", {}, "被大多数菜单拦截", function()
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local pos = ENTITY.GET_ENTITY_COORDS(ped)
            if not PED.IS_PED_DEAD_OR_DYING(ped) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) then
                util.trigger_script_event(1 << pid, {0xAD36AA57, pid, 0x96EDB12F, math.random(0, 0x270F)})
                FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), pos.x, pos.y, pos.z, 2, 50, true, false, 0.0)
            end
        end)

player_toggle_loop(kill_godmode, pid, "移除无敌玩家武器", {}, "", function()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(players.user(), ped) and players.is_godmode(pid) then
            util.trigger_script_event(1 << pid, {0xAD36AA57, pid, 0x96EDB12F, math.random(0, 0x270F)})
    end
end)

set_models = menu.list(trolling, "套模型", {}, "")
    local obj
    menu.toggle(set_models, "UFO", {}, "首次隐形\n玩家死亡之后可看见模型", function(toggled)
        local mdl = util.joaat("p_spinning_anus_s")
        local playerpos = ENTITY.GET_ENTITY_COORDS((pid), false)
        request_model(mdl)
        if toggled then
            obj = entities.create_object(mdl, playerpos)
            ENTITY.SET_ENTITY_VISIBLE(obj, false)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, players.user_ped(), 0, 0, 0, 0, 0, 0, 0, false, false, true, false, 0, false, 0)
        else
            if obj ~= nil then 
                entities.delete_by_handle(obj)
            end
        end
    end)

--------------------------玩家载具恶搞
acrobatics = menu.list(vehicle_car, "车辆跳跃", {}, "")
    menu.action(acrobatics, "豚跳", {"ollie"}, "", function()
        local vehicle = get_vehicle_player_is_in(pId)
        if ENTITY.DOES_ENTITY_EXIST(vehicle) and VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
        request_control(vehicle, 1000) then
            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
        end
    end)
    menu.action(acrobatics, "左侧空翻", {"kickflip"}, "", function()
        local vehicle = get_vehicle_player_is_in(pId)
        if ENTITY.DOES_ENTITY_EXIST(vehicle) and VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
        request_control(vehicle, 1000) then
            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.71, 5.0, 0.0, 0.0, 1, false, true, true, true, true)
        end
    end)
    menu.action(acrobatics, "双左侧空翻", {}, "", function()
        local vehicle = get_vehicle_player_is_in(pId)
        if ENTITY.DOES_ENTITY_EXIST(vehicle) and VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
        request_control(vehicle, 1000) then
            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 21.43, 20.0, 0.0, 0.0, 1, false, true, true, true, true)
        end
    end)
    menu.action(acrobatics, "右侧空翻", {}, "", function()
        local vehicle = get_vehicle_player_is_in(pId)
        if ENTITY.DOES_ENTITY_EXIST(vehicle) and VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
        request_control(vehicle, 1000) then
            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.71, -5.0, 0.0, 0.0, 1, false, true, true, true, true)
        end
    end)
menu.action(vehicle_car, "发送崔佛", {}, "派崔佛去撞他们或碾压他们", function(on_click)
    send_Angry_Trevor(on_click)
end)

set_license_plates = menu.list(vehicle_car, "设置车牌", {}, "")
    menu.action(set_license_plates, "将车牌设置为daidai", {}, "", function(on_click)
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
        if car ~= 0 then
            request_control_of_entity(car)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(car, "daidai")
        end
    end)
    menu.action(set_license_plates, "将车牌设置为i am SB", {}, "", function(on_click)
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
        if car ~= 0 then
            request_control_of_entity(car)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(car, "i am SB")
        end
    end)

menu.toggle(vehicle_car, "手刹", {}, "", function(on)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    if car ~= 0 then
        request_control_of_entity(car)
        VEHICLE.SET_VEHICLE_HANDBRAKE(car, on)
    end
end)
menu.toggle_loop(vehicle_car, "随机制动", {}, "", function(on)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    if car ~= 0 then
        request_control_of_entity(car)
        VEHICLE.SET_VEHICLE_HANDBRAKE(car, true)
        util.yield(1000)
        request_control_of_entity(car)
        VEHICLE.SET_VEHICLE_HANDBRAKE(car, false)
        util.yield(math.random(3000, 15000))
    end
end)
menu.toggle(vehicle_car, "冻结", {}, "", function(on)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    if car ~= 0 then
        request_control_of_entity(car)
        speed = if on then 0.0 else 1000.0
        ENTITY.SET_ENTITY_MAX_SPEED(car, speed)
    end
end)

player_toggle_loop(vehicle_car, pid, "移除载具无敌", {"removevgm"}, "", function()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    if PED.IS_PED_IN_ANY_VEHICLE(ped, false) and not PED.IS_PED_DEAD_OR_DYING(ped) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
        ENTITY.SET_ENTITY_CAN_BE_DAMAGED(veh, true)
        ENTITY.SET_ENTITY_INVINCIBLE(veh, false)
        ENTITY.SET_ENTITY_PROOFS(veh, false, false, false, false, false, 0, 0, false)
    end
end)

menu.action(trolling, "外星人爆炸", {""}, "", function() 
    local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local c = ENTITY.GET_ENTITY_COORDS(p)
    STREAMING.REQUEST_MODEL(ufo)
    while not STREAMING.HAS_MODEL_LOADED(ufo) do
        STREAMING.REQUEST_MODEL(ufo)
        util.yield()
    end
    menu.trigger_commands("freeze".. players.get_name(pid).. " on")
    c.z = c.z + 10
    local spawnedufo = entities.create_object(ufo, c) --creates ufo
    util.yield(2000)
    c = ENTITY.GET_ENTITY_COORDS(p)
    FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 3.0, false)
    util.yield(1000)
    entities.delete_by_handle(spawnedufo)
    menu.trigger_commands("freeze".. players.get_name(pid).. " off")
end)

kick_car = menu.list(vehicle_car, "踢出载具", {}, "")
    menu.action(kick_car, "踢出载具v1", {}, "踢出当前载具所有人\n且当前载具不能再上", function(toggled)
        kickcar(pid)
    end)
    menu.action(kick_car, "踢出载具v2", {}, "从载具里踢出玩家", function()
        menu.trigger_commands("vehkick".. players.get_name(pid))
    end)

menu.action(vehicle_car, "删除载具", {}, "删除此玩家正在驾驶的载具", function()
    deleplayercar(pid)
end)

menu.toggle_loop(vehicle_car, "禁用载具", {}, "", function(toggle)
    local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local veh = PED.GET_VEHICLE_PED_IS_IN(p, false)
    if (PED.IS_PED_IN_ANY_VEHICLE(p)) then
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(p)
    else
        local veh2 = PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(p)
        entities.delete_by_handle(veh2)
    end
end)

--------------------------------------------------------隔离

menu.toggle_loop(vehicle_car, "喇叭加速", {}, "当他们按喇叭时,推动汽车前进.", function() 
    remote_horn_boost(pid) 
end)
menu.toggle_loop(vehicle_car, "喇叭跳跳车", {}, "按E时,会使车辆跳起来", function() 
    remote_car_jump(pid) 
end)
menu.action(vehicle_car, "修复载具", {}, "给他们修车.", function() 
    repair_player_vehicle(pid) 
end)
menu.action(vehicle_car, "爆胎", {}, "", function ()
    menu.trigger_commands("poptires".. players.get_name(pid))
end)
menu.action(vehicle_car, "移除车门", {}, "", function ()
    menu.trigger_commands("removedoors".. players.get_name(pid))
end)
menu.action(vehicle_car, "摧毁螺旋桨", {}, "使螺旋桨失效", function ()
    menu.trigger_commands("destroyprop".. players.get_name(pid))
end)
menu.action(vehicle_car, "引擎控制", {}, "如果他们的发动机打开，它就会关闭，反之亦然.", function() 
    toggle_player_vehicle_engine(pid) 
end)
menu.action(vehicle_car, "摧毁引擎", {}, "让他们的引擎起火.", function() 
    break_player_vehicle_engine(pid) 
end)
menu.action(vehicle_car, "向前推进", {}, "大力推动车辆前进.", function() 
    boost_player_vehicle_forward(pid) 
end)
menu.action(vehicle_car, "弹飞载具", {}, "", function() 
    launch_up_player_vehicle(pid) 
end)
menu.action(vehicle_car, "停止车辆", {}, "", function() 
    stop_player_vehicle(pid) 
end) 
menu.action(vehicle_car, "倒置车辆", {}, "", function() 
    flip_player_vehicle(pid) 
end)
menu.action(vehicle_car, "车辆翻转180度", {}, "", function()
    turn_player_vehicle(pid)
end)

local explosion_circle_angle = 0
menu.toggle_loop(trolling, "爆炸圈", {}, "在他周围生成爆炸圈", function ()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    explosion_circle(ped, explosion_circle_angle, 25)
    explosion_circle_angle += 0.15
    util.yield(50)
end)

menu.action(trolling, "爆炸", {}, "", function ()
    menu.trigger_commands("explode".. players.get_name(pid))
end)
menu.toggle_loop(trolling, '循环爆炸', {''}, '', function()
    menu.trigger_commands("explode".. players.get_name(pid))
end)
menu.toggle_loop(trolling, "无损伤爆炸", {"tossplayers"}, "", function()
    local playerCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), true)
    SE_add_explosion(playerCoords['x'], playerCoords['y'], playerCoords['z'], 1, 1, SEisExploAudible, SEisExploInvis, 0, true)
end)
menu.toggle_loop(trolling, "原子弹轰炸", {"atomicbomb"}, "", function(on_click)
    do
    orbital(pid)
    end
end)         
menu.toggle_loop(trolling,"火箭雨", {'rockets'}, '', function()
    rain_rockets(pid, false)
    util.yield(500)
end)
local options <const> = {"Lazer", "Mammatus",  "Cuban800"}
	menu.action_slider(trolling, "神风敢死队", {}, "", options, function (index, plane)
		local hash <const> = util.joaat(plane)
		request_model(hash)
		local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pId)
		local pos = get_random_offset_from_entity(targetPed, 20.0, 20.0)
		pos.z = pos.z + 30.0
		local plane = entities.create_vehicle(hash, pos, 0.0)
		set_entity_face_entity(plane, targetPed, true)
		VEHICLE.SET_VEHICLE_FORWARD_SPEED(plane, 150.0)
		VEHICLE.CONTROL_LANDING_GEAR(plane, 3)
	end)

local options <const> = {"叛乱", "幻影楔形",  "蝰蛇"}
	menu.action_slider(trolling, "撞击玩家", {}, "", options, function (index)
		local vehicles <const> = {"insurgent2", "phantom2", "adder"}
		local vehicleName = vehicles[index]
		local vehicleHash <const> = util.joaat(vehicleName)
		request_model(vehicleHash)
		local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pId)
		local coord = get_random_offset_from_entity(targetPed, 12.0, 12.0)
		local vehicle = entities.create_vehicle(vehicleHash, coord, 0.0)
		set_entity_face_entity(vehicle, targetPed, false)
		VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 2)
		VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, 100.0)
	end)

menu.toggle(trolling, "粒子轰炸", {}, "", function ()
    menu.trigger_commands("particlespam".. players.get_name(pid), toggle)
end)

menu.action(trolling, "强制进入自由模式任务", {}, "强制玩家进入自由模式任务", function()
    menu.trigger_commands("mission".. players.get_name(pid))
end)

local mir = {weap = 'WEAPON_SNOWBALL', speed = 1000}
local mirloop =  menu.toggle_loop(trolling, '雪球攻击', {''}, '', function ()
local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
local weap = util.joaat(mir.weap)
    Delcar(targets)
    WEAPON.REQUEST_WEAPON_ASSET(weap)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z, tar1.x , tar1.y, tar1.z - 2.0, 200, 0, weap, 0, true, false, mir.speed)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + 1.0, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, mir.speed)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y + 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, mir.speed)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x + 1.0, tar1.y , tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, mir.speed)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x + 1.0, tar1.y + 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, mir.speed)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x - 1.0, tar1.y, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, mir.speed)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y - 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, mir.speed)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x - 1.0, tar1.y - 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, mir.speed)
end)

menu.action(vehicle_car, "传送到地下", {}, "", function()
    local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local c = ENTITY.GET_ENTITY_COORDS(p)
    local veh = PED.GET_VEHICLE_PED_IS_IN(p, false)
    c.z = c.z - 100
    if PED.IS_PED_IN_ANY_VEHICLE(p, false) then
        local success, floorcoords
        repeat
            success, floorcoords = util.get_ground_z(c.x, c.y)
            util.yield()
        until success
        RequestControl(veh)
        floorcoords = floorcoords - 50
        ENTITY.SET_ENTITY_COORDS(veh, c.x, c.y, floorcoords, false, false, false, false) --tp undermap
    else
        util.toast("他不在车里哦")
    end
end)

menu.action(vehicle_car, "加速带", {}, "在他们面前产生车辆加速带", function() 
    local coords = players.get_position(pid)
        coords.z = coords.z - 0.3
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local heading = ENTITY.GET_ENTITY_HEADING(player)
        local heading = heading + 80
        local boostpad = entities.create_object(3287988974, coords)
        ENTITY.SET_ENTITY_HEADING(boostpad, heading)
end)
menu.action(vehicle_car, "减速带", {}, "在他们面前产生车辆减速带", function() 
    local coords = players.get_position(pid)
        coords.z = coords.z - 0.4
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local heading = ENTITY.GET_ENTITY_HEADING(player)
        local heading = heading + 80
        local boostpad = entities.create_object(-227275508, coords)
        ENTITY.SET_ENTITY_HEADING(boostpad, heading)
end)


vehicle_impact = menu.list(trolling, "砸死他", {}, "")
    menu.action(vehicle_impact, "小丑车", {"crush3"}, "让他们看看他们是小丑", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z'] + 20.0
        request_model(util.joaat("speedo2"))
        local truck = entities.create_vehicle(util.joaat("speedo2"), coords, 0.0)
        local vel = ENTITY.GET_ENTITY_VELOCITY(vel)
        ENTITY.SET_ENTITY_VELOCITY(truck, vel['x'], vel['y'], -200.0)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(truck, 3)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(truck, true)
        wait(700)
        entities.delete_by_handle(truck)
    end)
    menu.action(vehicle_impact, "隐形车", {"crush4"}, "", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z'] + 20.0
        request_model(1917016601)
        local truck = entities.create_vehicle(1917016601, coords, 0.0)
        local vel = ENTITY.GET_ENTITY_VELOCITY(vel)
        ENTITY.SET_ENTITY_VELOCITY(truck, vel['x'], vel['y'], -200.0)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(truck, 3)
        ENTITY.SET_ENTITY_VISIBLE(truck, false, 0)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(truck, true)
        wait(2000)
        entities.delete_by_handle(truck)
    end)
    menu.action(vehicle_impact, "直接压倒", {"crush5"}, "", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z'] + 20.0
        request_model(util.joaat("faggio2"))
        local truck = entities.create_vehicle(util.joaat("faggio2"), coords, 0.0)
        local vel = ENTITY.GET_ENTITY_VELOCITY(vel)
        ENTITY.SET_ENTITY_VELOCITY(truck, vel['x'], vel['y'], -200.0)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(truck, 3)
        ENTITY.SET_ENTITY_VISIBLE(truck, false, 0)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(truck, true)
        wait(2000)
        entities.delete_by_handle(truck)
    end)
    menu.action(vehicle_impact, "大卡车", {""}, "", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
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
        wait(700)
        entities.delete_by_handle(truck)
    end)
    menu.action(vehicle_impact, "小绵羊", {"crush2"}, "", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z'] + 20.0
        request_model(util.joaat("faggio2"))
        local truck = entities.create_vehicle(util.joaat("faggio2"), coords, 0.0)
        local vel = ENTITY.GET_ENTITY_VELOCITY(vel)
        ENTITY.SET_ENTITY_VELOCITY(truck, vel['x'], vel['y'], -200.0)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(truck, 3)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(truck, true)
        wait(700)
        entities.delete_by_handle(truck)
    end)

local player_veh_teleport = menu.list(vehicle_car, "传送载具", {}, "")
    menu.action(player_veh_teleport, "传送载具到我", {"tpvtome"}, "传送玩家最后一个载具\n或当前乘坐的载具", function(on_click)
        tpcartome(pid)
    end)
    menu.action(player_veh_teleport, "传送载具到导航点", {"tpvtoway"}, "传送玩家最后一个载具\n或当前乘坐的载具", function(on_click)
        tocartopoint(pid)
    end)
    menu.action(player_veh_teleport, "传送载具到花园银行停机坪", {"tpvtomaze"}, "传送玩家最后一个载具\n或当前乘坐的载具", function(on_click)
        tptomaze(pid)
    end)
    menu.action(player_veh_teleport, "传送载具到深海底", {"tpvunderwater"}, "传送玩家最后一个载具\n或当前乘坐的载具", function(on_click)
        tptounderwater(pid)
    end)
    menu.action(player_veh_teleport, "传送载具到高空", {""}, "传送玩家最后一个载具\n或当前乘坐的载具", function()
        tptohighair(pid)
    end)
    menu.action(player_veh_teleport, "传送载具到洛圣都改车王", {"tpvlsc"}, "传送玩家最后一个载具\n或当前乘坐的载具", function(on_click)
        tolsc(pid)
    end)
    menu.action(player_veh_teleport, "传送载具到监狱SCP-173单元", {"tpvscp"}, "传送玩家最后一个载具\n或当前乘坐的载具", function(on_click)
        tpscp(pid)
    end)
    menu.action(player_veh_teleport, "传送载具到大牢房中", {"tpvcell"}, "传送玩家最后一个载具\n或当前乘坐的载具", function(on_click)
        tocell(pid)
    end)

menu.toggle(vehicle_car, "随机升级", {"upgradevehicle"}, "玩家必须有乘坐过的载具", function(state)
    abcd = state
while abcd do
    randomupdatcar(pid)
util.yield(500)
    end
end)

menu.action(vehicle_car, "电磁脉冲炸弹", {"empvehicle"}, "", function(on)
    caremp(pid)
end)
menu.toggle_loop(vehicle_car, "快乐的小陀螺", {"beybladev"}, "", function(on)
    carspin(pid)
end)

---------------------------------------鬼畜载具
local glitchVeh = false
local glitchVehCmd
    glitchVehCmd = menu.toggle(vehicle_car, "鬼畜载具", {"glitchvehicle"}, "", function(toggle) -- credits to soul reaper for base concept
        glitchVeh = toggle
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_model = players.get_vehicle_model(pid)
        local ped_hash = util.joaat("a_m_m_acult_01")
        local object_hash = util.joaat("prop_ld_ferris_wheel")
        request_model(ped_hash)
        request_model(object_hash)
        
        while glitchVeh do
            if not players.exists(pid) then 
                util.toast("玩家不存在. :/")
                menu.set_value(glitchVehCmd, false);
            util.stop_thread() end

            if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) > 1000.0 
            and v3.distance(pos, players.get_cam_pos(players.user())) > 1000.0 then
                util.toast("玩家太远了. :/")
                menu.set_value(glitchVehCmd, false);
            break end

            if not PED.IS_PED_IN_VEHICLE(ped, player_veh, false) then 
                util.toast("他不在车里哦! ")
                menu.set_value(glitchVehCmd, false);
            break end

            if not VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(player_veh) then
                util.toast("车上没空位了")
                menu.set_value(glitchVehCmd, false);
            break end

            local seat_count = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(veh_model)
            local glitch_obj = entities.create_object(object_hash, pos)
            local glitched_ped = entities.create_ped(26, ped_hash, pos, 0)
            local things = {glitched_ped, glitch_obj}
			
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(glitch_obj)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(glitched_ped)
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
            if glitched_ped ~= nil then
                entities.delete_by_handle(glitched_ped) 
            end
            if glitch_obj ~= nil then 
                entities.delete_by_handle(glitch_obj)
            end
        end
    end)

freeze_player = menu.list(trolling, "冻结", {}, "")
    player_toggle_loop(freeze_player, pid, "暴力冻结", {}, "", function()
        util.trigger_script_event(1 << pid, {330622597, players.user(), 0, 0, 0, 0, 0})
        util.yield(500)
    end)
    player_toggle_loop(freeze_player, pid, "仓库冻结", {}, "", function()
        util.trigger_script_event(1 << pid, {-1796714618, players.user(), 0, 1, 0, 0})
        util.yield(500)
    end)
    player_toggle_loop(freeze_player, pid, "模型冻结", {}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    end)
    menu.action(freeze_player, "传送冻结", {}, "将冻结玩家大约20秒，然后将他们传送进网球场.", function()
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510)) -- Global_1894573[PLAYER::PLAYER_ID() /*608*/].f_510
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 195, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

local inf_loading = menu.list(trolling, "无限加载屏幕", {}, "")
    menu.action(inf_loading, "传送邀请", {}, "", function()
        util.trigger_script_event(1 << pid, {891653640, players.user(), 0, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)
    menu.action(inf_loading, "公寓邀请", {}, "", function()
        util.trigger_script_event(1 << pid, {-702866045, pid, 0, 1, id})
    end)

menu.toggle_loop(trolling, "将玩家推向前方", {}, "", function()
    local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
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

menu.action(trolling, "小行星攻击", {}, "用小行星来攻击他", function() 
    local coords = players.get_position(pid)
        coords.z = coords['z'] + 15.0
    local asteroid = entities.create_object(3751297495, coords)
        ENTITY.SET_ENTITY_DYNAMIC(asteroid, true)
end)

menu.toggle_loop(trolling, "向Ta发送垃圾邮件", {}, "", function()
    util.yield(250)
    menu.trigger_commands("commendfriendly".. PLAYER.GET_PLAYER_NAME(pid))
end)

-------------------发送玩家
menu.action(tp_player_trolling, "发送到GTA5介绍界面", {}, "", function()
    local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
    util.trigger_script_event(1 << pid, {-95341040, players.user(), 20, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
    util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
end)
menu.action(tp_player_trolling, "发送到高尔夫俱乐部", {}, "派遣玩家去打高尔夫.", function()
    local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
    util.trigger_script_event(1 << pid, {-95341040, players.user(), 193, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
    util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
end)
menu.action(tp_player_trolling, "发送到自由模式", {}, "", function()
    local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
    util.trigger_script_event(1 << pid, {-95341040, players.user(), 194, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
    util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
end)
menu.action(tp_player_trolling, "强制1V1", {}, "", function()
    local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
    util.trigger_script_event(1 << pid, {-95341040, players.user(), 197, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
    util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
end)
menu.action(tp_player_trolling, "破坏室内状态", {}, "可以通过重新加入战局来取消。玩家必须在一个公寓里", function()
    if players.is_in_interior(pid) then
        util.trigger_script_event(1 << pid, {629813291, players.user(), pid, pid, pid, math.random(int_min, int_max), pid})
    else
        util.toast(players.get_name(pid) .. " 不在室内. :/")
    end
end)
menu.action(tp_player_trolling, "公寓邀请", {}, "", function()
    util.trigger_script_event(1 << pid, {-702866045, players.user(), pid, -1, 1, 1, 0, 1, 0}) 
end)
menu.action(tp_player_trolling, "任务邀请", {}, "", function()
    util.trigger_script_event(1 << pid, {36077543, players.user(), pid, 1, 7}) 
end)
menu.action(tp_player_trolling, "传送到佩里科岛", {"tpcayo"}, "", function()
    util.trigger_script_event(1 << pid, {330622597, pid, 0, 0, 3, 1})
end)
menu.action(tp_player_trolling, "传送到海滩", {"cayokick"}, "", function()
    util.trigger_script_event(1 << pid, {330622597, pid, 0, 0, 0x4, 0})
end)

menu.action(npc_trolling, "撒尿", {}, "随地大小便应该遭到谴责", function()
    peeloop_player()
end)
menu.action(npc_trolling, "猫猫炸弹", {}, "", function(click_type)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
    hash = util.joaat("a_c_cat_01")
    request_model_load(hash)
    for i=1, 30 do
        local cat = entities.create_ped(28, hash, coords, math.random(0, 270))
        local rand_x = math.random(-10, 10)*5
        local rand_y = math.random(-10, 10)*5
        local rand_z = math.random(-10, 10)*5
        ENTITY.SET_ENTITY_INVINCIBLE(cat, true)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(cat, 1, rand_x, rand_y, rand_z, true, false, true, true)
        AUDIO.PLAY_PAIN(cat, 7, 0)
    end
end)
menu.action(npc_trolling, "墨西哥乐队", {}, "", function(click_type)
    dispatch_mariachi(pid)
end)
menu.action(npc_trolling, "克隆玩家", {}, "", function(click_type)
    local new_clone = PED.CLONE_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true, false, true)
end)

local custom_hooker_options = {"克隆玩家", "莱斯特", "特蕾西", "贝克女士", "裸女"}
    menu.list_action(npc_trolling, "发送妓女", {}, "", custom_hooker_options, function(index, value, click_type)
        local hooker
        local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), -5.0, 0.0, 0.0)
        pluto_switch index do
            case 1:
                hooker = PED.CLONE_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true, false, true)
                break
            case 2:
                request_model_load(util.joaat('cs_lestercrest'))
                hooker = entities.create_ped(28, util.joaat('cs_lestercrest'), c, math.random(270))
                break
            case 3:
                request_model_load(util.joaat('cs_tracydisanto'))
                hooker = entities.create_ped(28, util.joaat('cs_tracydisanto'), c, math.random(270))
                break
            case 4:
                request_model_load(util.joaat('csb_agatha'))
                hooker = entities.create_ped(28, util.joaat('csb_agatha'), c, math.random(270))
                break
            case 5:
                request_model_load(util.joaat('a_f_y_topless_01'))
                hooker = entities.create_ped(28, util.joaat('a_f_y_topless_01'), c, math.random(270))
                PED.SET_PED_COMPONENT_VARIATION(hooker, 8, 1, 1, 1)
                break 
            end
        local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), -5.0, 0.0, 0.0)
            ENTITY.SET_ENTITY_COORDS(hooker, c.x, c.y, c.z)
            TASK.TASK_START_SCENARIO_IN_PLACE(hooker, "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", 0, false)
    end)

menu.action(trolling, "切碎", {}, "", function(click_type)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
    coords.z = coords['z']+2.5
    local hash = util.joaat("buzzard")
    request_model_load(hash)
    local heli = entities.create_vehicle(hash, coords, ENTITY.GET_ENTITY_HEADING(target_ped))
    VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, false)
    VEHICLE.SET_HELI_BLADES_FULL_SPEED(heli)
    ENTITY.SET_ENTITY_INVINCIBLE(heli, true)
    ENTITY.FREEZE_ENTITY_POSITION(heli, true)
    ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(heli, true, true)
    ENTITY.SET_ENTITY_ROTATION(heli, 180, 0.0, ENTITY.GET_ENTITY_HEADING(target_ped), 0)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(heli, coords.x, coords.y, coords.z, true, false, false)
    VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, true)
end)

menu.toggle_loop(trolling, "玩偶循环", {}, "目标会保持", function()
    local coords = players.get_position(pid)
    coords.z = coords['z'] - 2.0
    FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 11, 1, false, true, 0, true)
    util.yield(10)
end)
menu.toggle_loop(trolling, "烟雾掉帧", {""}, "", function()
    if players.exists(pid) then
        fumes(pid)
    end
end)

make_entity = menu.list(trolling, "生成实体", {}, "")
    menu.action(make_entity, "生成竞技场", {}, "", function(click_type)
        local coords = players.get_position(pid)
        local hash = util.joaat("xs_terrain_set_dystopian_06")
        request_model_load(hash)
        local dust = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z']-4, true, false, false)
        ENTITY.FREEZE_ENTITY_POSITION(dust, true)
    end)
    menu.action(make_entity, "生成黄土高坡", {}, "", function(click_type)
        local coords = players.get_position(pid)
        local hash = util.joaat("xs_terrain_dyst_ground_07")
        request_model_load(hash)
        local dust = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z']-36, true, false, false)
        local hash2 = util.joaat("apa_prop_flag_brazil")
        request_model_load(hash2)
        local flag = OBJECT.CREATE_OBJECT_NO_OFFSET(hash2, coords['x'], coords['y'], coords['z'], true, false, false)
        ENTITY.FREEZE_ENTITY_POSITION(dust, true)
    end)
    local obj_options = {"斜坡", "路障", "风车","卫星"}
    menu.list_action(make_entity, "生成小实体", {},"", obj_options, function (index, value, click_type)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        pluto_switch index do 
            case 1:
                local hash = 2282807134
                request_model_load(hash)
                local ramp = spawn_object_in_front_of_ped(target_ped, hash, 90, 50.0, -1, true)
                local c = ENTITY.GET_ENTITY_COORDS(ramp, true)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ramp, c['x'], c['y'], c['z']-0.2, false, false, false)
                break
            case 2: 
                local hash = 3729169359
                local obj = spawn_object_in_front_of_ped(target_ped, hash, 0, 5.0, -0.5, false)
                ENTITY.FREEZE_ENTITY_POSITION(obj, true)
                break
            case 3: 
                local hash = 1952396163
                local obj = spawn_object_in_front_of_ped(target_ped, hash, 0, 5.0, -30, false)
                ENTITY.FREEZE_ENTITY_POSITION(obj, true)
                break
            case 4: 
                local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local hash = 2306058344
                local obj = spawn_object_in_front_of_ped(target_ped, hash, 0, 0.0, -5.0, false)
                ENTITY.FREEZE_ENTITY_POSITION(obj, true)
                break
        end
    end)
    
menu.toggle_loop(trolling, "将附近载具吸到他身上",{"magnet"}, "", function()
    local p_c = players.get_position(pid)
    for _, v in pairs(entities.get_all_vehicles_as_handles()) do 
        if not PED.IS_PED_A_PLAYER(VEHICLE.GET_PED_IN_VEHICLE_SEAT(v, -1, false)) then 
            local v_c = ENTITY.GET_ENTITY_COORDS(v)
            local c = {}
            c.x = (p_c.x - v_c.x)*2
            c.y = (p_c.y - v_c.y )*2
            c.z = (p_c.z - v_c.z)*2
            ENTITY.APPLY_FORCE_TO_ENTITY(v, 1, c.x, c.y, c.z, 0, 0, 0, 0, false, false, true, false, false)
        end
    end
end)  

firepillar = menu.list(trolling, "火柱", {}, "")
    menu.toggle_loop(firepillar, "循环喷火v1", {"flameloop"}, "火焰攻击！！！", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 12, 100.0, true, false, 0.0)
    end)
    menu.toggle_loop(firepillar, "循环喷火v2", {}, "火焰攻击！！！", function()
        local coords = players.get_position(pid)
        coords.z = coords['z'] - 2.0
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 12, 1, true, false, 0, false)
        util.yield(25)
    end)
waterpillar = menu.list(trolling, "水柱", {}, "")
    menu.toggle_loop(waterpillar, "循环喷水1", {}, "水柱攻击！！！", function()
        local coords = players.get_position(pid)
        coords.z = coords['z'] - 2.0
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 13, 1, true, false, 0, false)
        util.yield(25)
    end)
    menu.toggle_loop(waterpillar, "循环喷水2", {"waterloop"}, "水柱攻击！！！", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 13, 100.0, true, false, 0.0)
    end)

menu.toggle_loop(trolling, "追踪", {}, "地下有痕迹", function()
    local coords = players.get_position(pid)
    coords.z = coords['z'] + 1.5
    FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 35, 0, false, false, 0, false)
    util.yield(65)
end)
menu.toggle_loop(trolling, "让他走路带火", {}, "跑起来吧！！!", function()
    local coords = players.get_position(pid)
    FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 38, 0, false, false, 0, false)
    util.yield(65)
end)
menu.toggle_loop(trolling, "在他头上浇水", {}, "", function()
    local coords = players.get_position(pid)
    coords.z = coords['z'] + 1
    util.yield(65)
    FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 79, 0, false, false, 0, false)
end)
menu.action(trolling, "发射玩家", {"launch"}, "适用于大多数菜单.", function()
    local mdl = util.joaat("boxville3")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(mdl)
                
    if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
        util.toast(players.get_name(pid) .. " 在载具中. :/")
    return end
    
    boxville = entities.create_vehicle(mdl, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 2.0, 0.0), ENTITY.GET_ENTITY_HEADING(ped))
    ENTITY.SET_ENTITY_VISIBLE(boxville, false)
    util.yield(250)
    repeat
        if v3.distance(players.get_position(pid), ENTITY.GET_ENTITY_COORDS(boxville)) < 10.0 then
            if boxville ~= 0 and ENTITY.DOES_ENTITY_EXIST(boxville)then
                ENTITY.APPLY_FORCE_TO_ENTITY(boxville, 1, 0.0, 0.0, 25.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
            end
            util.yield()
        else
            entities.delete_by_handle(boxville)
        end
        util.yield()
        pos = ENTITY.GET_ENTITY_COORDS(ped)
    until pos.z > 10000.0
    util.yield(100)
    if boxville ~= 0 and ENTITY.DOES_ENTITY_EXIST(boxville) then 
        entities.delete_by_handle(boxville)
    end
end)
local sounds = menu.list(trolling, "声音恶搞", {}, "")
    menu.toggle_loop(sounds, "让他听到循环爆炸死亡声音", {}, "吵死了", function()
        local coords = players.get_position(pid)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "BED", coords.x, coords.y, coords.z, "WASTEDSOUNDS", true, 5, false)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "Crash", coords.x, coords.y, coords.z, "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, 5, false)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "BASE_JUMP_PASSED", coords.x, coords.y, coords.z, "HUD_AWARDS", true, 5, false)
        util.yield(20)
    end)
    menu.toggle_loop(sounds, "循环死亡的声音", {}, "", function()
        local coords = players.get_position(pid)
        AUDIO.PLAY_SOUND_FROM_COORD(1, "BED", coords.x, coords.y, coords.z, "WASTEDSOUNDS", true, 5, false)
        util.yield(5800)
    end)
    menu.toggle_loop(sounds, "循环游艇声音", {}, "", function()
        local coords = players.get_position(pid)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "Horn", coords.x, coords.y, coords.z, "DLC_Apt_Yacht_Ambient_Soundset", true, 5, false)
        util.yield(3000)
    end)
    menu.toggle_loop(sounds, "嗡嗡声", {}, "", function()
        local coords = players.get_position(pid)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "Crash", coords.x, coords.y, coords.z, "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, 5, false)
        util.yield(1700)
    end)
    menu.toggle_loop(sounds, "任务成功声音", {}, "", function()
        local coords = players.get_position(pid)
        AUDIO.PLAY_SOUND_FROM_COORD(1, "BASE_JUMP_PASSED", coords.x, coords.y, coords.z, "HUD_AWARDS", true, 5, false)
        util.yield(1250)
    end)

---------------------------踢出玩家

    if menu.get_edition() >= 2 then 
        menu.action(kickplayer, "智能踢", {"adaptivekick"}, "", function()
            util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0x4, -1, 1, 1, 1})
            util.trigger_script_event(1 << pid, {0x6A16C7F, pid, memory.script_global(0x2908D3 + 1 + (pid * 0x1C5) + 0x13E + 0x7)})
            util.trigger_script_event(1 << pid, {0x63D4BFB1, players.user(), memory.read_int(memory.script_global(0x1CE15F + 1 + (pid * 0x257) + 0x1FE))})
            menu.trigger_commands("breakup" .. players.get_name(pid))
        end)
    else
        menu.action(kickplayer, "智能踢", {"adaptivekick"}, "", function()
            util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0x4, -1, 1, 1, 1})
            util.trigger_script_event(1 << pid, {0x6A16C7F, pid, memory.script_global(0x2908D3 + 1 + (pid * 0x1C5) + 0x13E + 0x7)})
            util.trigger_script_event(1 << pid, {0x63D4BFB1, players.user(), memory.read_int(memory.script_global(0x1CE15F + 1 + (pid * 0x257) + 0x1FE))})
        end)
    end

    if menu.get_edition() >= 2 then 
        menu.action(kickplayer, "阻止加入踢", {"blast"}, "将该玩家踢出后加入到stand阻止加入的列表中.", function()
            menu.trigger_commands("historyblock " .. players.get_name(pid))
            menu.trigger_commands("breakup" .. players.get_name(pid))
        end)
    end

-----崩溃选项
menu.action(crashplayer, "XP终结者", {}, "", function()
    xp_over(pid)--------来自南瓜
end)
menu.action(crashplayer, "改进AIO崩", {}, "远离!!!远离!!!远离!!!远离!!!", function()
    aaaio(pid)
end)
menu.action(crashplayer, "OX崩v1", {"OXCrash"}, "远离!!!远离!!!远离!!!远离!!!远离!!!远离!!!", function()
    OXcrashgg(pid)
end)
menu.action(crashplayer, "可爱崩", {}, "", function(on_input)
    local crash_tbl = {"SWYHWTGYSWTYSUWSLSWTDSEDWSRTDWSOWSW45ERTSDWERTSVWUSWS5RTDFSWRTDFTSRYE","6825615WSHKWJLW8YGSWY8778SGWSESBGVSSTWSFGWYHSTEWHSHWG98171S7HWRUWSHJH","GHWSTFWFKWSFRWDFSRFSRTDFSGICFWSTFYWRTFYSSFSWSYWSRTYFSTWSYWSKWSFCWDFCSW",}
    local crash_tbl_2 = {{17, 32, 48, 69},{14, 30, 37, 46, 47, 63},{9, 27, 28, 60}}
        if pid == players.user() then
            util.toast("笨笨" .. players.get_name(players.user()) .. "\n你不能崩溃你自己哦")
            return 
        end
        if pid == players.get_host() then 
            util.toast("笨笨" .. players.get_name(players.user()) .. "\n你不能崩溃主机哦")
                    return
        end
            util.toast("[呆呆 提示]\n正在崩溃中")
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
            local crash_compiled_func = load(crash_str .. '\"' .. cur_crash_meth .. players.get_name(pid) .. '\")')
            pcall(crash_compiled_func)
end)
menu.action(crashplayer, "大自然崩溃", {"nature"}, "", function()
    naturecrashv1(PlayerID)
end)
menu.action(crashplayer, "人工智能崩", {}, "", function()
    local player_position = players.get_position(pid)
    local joaat_hash = util.joaat("prop_fragtest_cnst_04")
    util.request_model(joaat_hash)
    local object_handle = entities.create_object(joaat_hash, player_position)
    OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object_handle, 3, false)
    util.yield(1000)
    entities.delete_by_handle(object_handle)
end)

menu.action(crashplayer, "崩溃v1", {}, "", function()
    guibeng(PlayerID)
end)
menu.action(crashplayer, "崩溃v2", {"grief"}, "多按几次也许有不一样的效果.", function()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = players.get_position(pid)
    local mdl = util.joaat("u_m_m_jesus_01")
    local veh_mdl = util.joaat("oppressor")
    util.request_model(veh_mdl)
    util.request_model(mdl)
        for i = 1, 10 do
            if not players.exists(pid) then
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
    menu.action(crashplayer, "崩溃v3", {"Memoir"}, "", function()
        Memoir(PlayerID)
    end)




------------------------------------------------------------------快捷怼人-
    menu.divider(cussinglayer, "快捷怼人")
    menu.action(cussinglayer, "怼人1", {""}, "公屏上骂他", function()
        chat.send_message(PLAYER.GET_PLAYER_NAME(pid)..cussing1,false,true,true)
    end)
    require("lib/daidailib/cussing")
    menu.action(cussinglayer, "怼人2", {""}, "公屏上骂他", function()
        chat.send_message(cussing2..PLAYER.GET_PLAYER_NAME(pid)..cussing2_1,false,true,true)
    end)
    require("lib/daidailib/cussing")
    menu.action(cussinglayer, "怼人3", {""}, "公屏上骂他", function()
        chat.send_message(cussing3 ..PLAYER.GET_PLAYER_NAME(pid),false,true,true)
    end)
    require("lib/daidailib/cussing")
    menu.action(cussinglayer, "怼人4", {""}, "公屏上骂他", function()
        chat.send_message(cussing4 ..PLAYER.GET_PLAYER_NAME(pid)..cussing4_1,false,true,true)
    end)
    require("lib/daidailib/cussing")
    menu.action(cussinglayer, "怼人5", {""}, "公屏上骂他", function()
        chat.send_message(cussing5,false,true,true)
    end)
    require("lib/daidailib/cussing")
    menu.action(cussinglayer, "怼人6", {""}, "公屏上骂他", function()
        chat.send_message(PLAYER.GET_PLAYER_NAME(pid)..cussing6,false,true,true)
    end)
    require("lib/daidailib/cussing")
    menu.action(cussinglayer, "怼人7", {""}, "公屏上骂他", function()
        chat.send_message(cussing7,false,true,true)
    end)
    require("lib/daidailib/cussing")
    menu.action(cussinglayer, "怼人8", {""}, "公屏上骂他", function()
        chat.send_message(cussing8,false,true,true)
    end)
    require("lib/daidailib/cussing")
    menu.action(cussinglayer, "怼人9", {""}, "公屏上骂他", function()
        chat.send_message(cussing9,false,true,true)
    end)
    require("lib/daidailib/cussing")
    menu.action(cussinglayer, "怼人10", {""}, "公屏上骂他", function()
        chat.send_message(cussing10,false,true,true)
    end)
end)


----------------------世界选项
Plot_health = menu.list(worldlist, "绘制血量条", {})
    local options = {
        {"玩家"},
        {"行人"},
        {"玩家和行人"},
        {"主动瞄准时"},
    }
    local ttselectedOpt = 1
    local selfaimedPed = 0
    menu.toggle_loop(Plot_health, "开启", {}, "", function ()
        PedHealthBarmainLoop()
    end)
    menu.list_select(Plot_health, "绘制方式", {}, "", options, 1, function (opt)
        ttselectedOpt = opt
    end)
    function PedHealthBarmainLoop()
        if ttselectedOpt == 4 then
            if not PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
                selfaimedPed = 0 return
            end
            local pEntity <const> = memory.alloc_int()
            if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), pEntity) then
                local entity = memory.read_int(pEntity)
                if ENTITY.IS_ENTITY_A_PED(entity) then selfaimedPed = entity end
            end
            draw_health_bar(selfaimedPed, 1000.0)
        else
            for _, ped in ipairs(get_peds_in_player_range(players.user(), 500.0)) do
                if not ENTITY.IS_ENTITY_ON_SCREEN(ped) or
                not ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(players.user_ped(), ped, TraceFlag.world) then
                    goto LABEL_CONTINUE
                end
                if (ttselectedOpt == 1 and not PED.IS_PED_A_PLAYER(ped)) or
                (PED.IS_PED_A_PLAYER(ped) and ttselectedOpt == 2) then
                    goto LABEL_CONTINUE
                end
                draw_health_bar(ped, 350.0)
            ::LABEL_CONTINUE::
            end
        end
    end
----------------------------------

local numPlanes = 0
local lastSpawn = newTimer()
menu.toggle_loop(worldlist, "愤怒的飞机", {}, "", function ()
    if numPlanes < 15 and lastSpawn.elapsed() > 300 then
        local pedHash <const> = util.joaat("s_m_y_blackops_01")
        local planeModel <const> = planes[math.random(#planes)]
        local planeHash <const> = util.joaat(planeModel)
        request_model(planeHash); request_model(pedHash)
        local pos = players.get_position(players.user())
        local plane = VEHICLE.CREATE_VEHICLE(planeHash, pos.x, pos.y, pos.z, CAM.GET_GAMEPLAY_CAM_ROT(0).z, true, false, false)
        set_decor_flag(plane, DecorFlag_isAngryPlane)
        if ENTITY.DOES_ENTITY_EXIST(plane) then
            NETWORK.SET_NETWORK_ID_CAN_MIGRATE(NETWORK.VEH_TO_NET(plane), false)
            local pilot = entities.create_ped(26, pedHash, pos, 0)
            PED.SET_PED_INTO_VEHICLE(pilot, plane, -1)
            pos = get_random_offset_from_entity(players.user_ped(), 50.0, 150.0)
            pos.z = pos.z + 75.0
            ENTITY.SET_ENTITY_COORDS(plane, pos.x, pos.y, pos.z, false, false, false, false)
            local theta = random_float(0, 2 * math.pi)
            ENTITY.SET_ENTITY_HEADING(plane, math.deg(theta))
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(plane, 60.0)
            VEHICLE.SET_HELI_BLADES_FULL_SPEED(plane)
            VEHICLE.CONTROL_LANDING_GEAR(plane, 3)
            VEHICLE.SET_VEHICLE_FORCE_AFTERBURNER(plane, true)
            TASK.TASK_PLANE_MISSION(pilot, plane, 0, players.user_ped(), 0.0, 0.0, 0.0, 6, 100.0, 0.0, 0.0, 80.0, 50.0, false)
            numPlanes = numPlanes + 1
            lastSpawn.reset()
        end
    end
end, function ()
    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
            entities.delete_by_handle(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false))
            entities.delete_by_handle(vehicle)
            numPlanes = numPlanes - 1
    end
end)


ped_cash = menu.list(worldlist, "NPC金钱掉落", {})
    PED.SET_AMBIENT_PEDS_DROP_MONEY(true)
        local pedmoney = 520
        menu.slider(ped_cash, '修改金额', {'pcfixed'}, 'NPC现金掉落数量', 1, 2000, 520, 1, function(val)
            pedmoney = val
        end)
        menu.toggle_loop(ped_cash, '启用', {}, '修改击杀NPC后可拾取的金钱数量', function() 
            local peds = entities.get_all_peds_as_handles()
                    for _index, ped in pairs(peds) do
                                PED.SET_PED_MONEY(ped, pedmoney)
                    end
        end)


New_Year_fireworks = menu.list(worldlist, "新年烟花", {})
        menu.toggle_loop(New_Year_fireworks, "大烟花", {""}, "固定位置\n不随人物正面变化而变化", function ()
            local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
            local hash = util.joaat("weapon_firework")
            request_weapon_asset(hash)
            WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)

            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-70, pos.y-90, pos.z, pos.x-70, pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
            util.yield(500)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-90, pos.y-90, pos.z, pos.x-90, pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
            util.yield(500)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-60, pos.y-90, pos.z, pos.x-60, pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
            util.yield(500)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-80, pos.y-90, pos.z, pos.x-80, pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
            util.yield(500)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-50, pos.y-90, pos.z, pos.x-50, pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
            util.yield(500)
        end)
    menu.toggle_loop(New_Year_fireworks, "小烟花", {}, "固定正面位置\n随人物正面变化而变化", function ()
        local ptfx_asset = "scr_indep_fireworks"
        local effect_name = "scr_indep_firework_trailburst"

        GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)---------------------------------------------距离x   y  z方向x, y, z  
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), 0, 70, 0, 179, 0, 0, 1, 0, 0, 0)
        util.yield(250)
        GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), -8, 70, 0, 179, 0, 0, 0.5, 10, 10, 0)
        util.yield(250)
        GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), 4, 70, 0, 179, 0, 0, 1.2, 10, 10, 0)
        util.yield(250)
        GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), -4, 70, 0, 179, 0, 0, 0.7, 10, 10, 0)
        util.yield(250)
        GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), 8, 70, 0, 179, 0, 0, 0.5, 10, 10, 0)
        util.yield(250)
        GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), -2, 70, 0, 179, 0, 0, 1, 10, 10, 0)
        util.yield(250)
        GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), 2, 70, 0, 179, 0, 0, 0.8, 10, 10, 0)
        util.yield(250)
        GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), 6, 70, 0, 179, 0, 0, 1, 10, 10, 0)
        util.yield(250)
    end)
menu.toggle(worldlist, "圣诞树", {""}, "面向目标按B可以移动目标位置", function(on)
    if on then
        menu.trigger_commands("godfinger on")
        local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
        local broomstick = util.joaat("prop_xmas_ext")
        request_model(broomstick)
        obj = entities.create_object(broomstick, pos)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, 0, 0, 0.3, -80.0, 0, 0, true, false, false, false, 0, true)
    else
        entities.delete_by_handle(obj)
        menu.trigger_commands("godfinger off")
    end
end)
menu.toggle(worldlist, "小圣诞树", {""}, "面向目标按B可以移动目标位置", function(on)
    if on then
        menu.trigger_commands("godfinger on")
        local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
        local broomstick = util.joaat("prop_xmas_tree_int")
        request_model(broomstick)
        --pos['x']
        obj = entities.create_object(broomstick, pos)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, 0, 0, 0.3, -80.0, 0, 0, true, false, false, false, 0, true)
    else
        entities.delete_by_handle(obj)
        menu.trigger_commands("godfinger off")
    end
end)

local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 0.0, 2.0)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)



weatherlist = menu.list(worldlist,"天气",{},"")
    menu.toggle(weatherlist,"天气晴朗",{},"仅本地更改",function(on)
        if on then
            menu.trigger_commands("weather clear")
        else
            menu.trigger_commands("weather normal")
        end
    end)
    menu.toggle(weatherlist,"雪天",{},"仅本地更改",function(on)
        if on then
            menu.trigger_commands("weather xmas")
        else
            menu.trigger_commands("weather normal")
        end
    end)
menu.toggle(worldlist, "土豆模式", {"fpsnsboost"}, "提高FPS", function(on_toggle)
	if on_toggle then
		menu.trigger_commands("weather" .. " extrasunny")---设置天气
		menu.trigger_commands("clouds" .. " clear01")---设置云
        menu.trigger_commands("potatomode ")---开启土豆
        menu.trigger_commands("nosky ")---移除天空
        menu.trigger_commands("noidlecam ")---禁用挂机镜头
	else
		menu.trigger_commands("weather" .. " normal")
		menu.trigger_commands("clouds" .. " normal")
        menu.trigger_commands("potatomode ")
        menu.trigger_commands("nosky ")
        menu.trigger_commands("noidlecam ")
	end
end)

local lastJump = newTimer()
menu.toggle_loop(worldlist, "世界跳跳车", {}, "", function()
    if lastJump.elapsed() > 1500 then
        for _, vehicle in ipairs(get_vehicles_in_player_range(players.user(), 150)) do
            request_control_once(vehicle)
            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 6.5, 0.0, 0.0, 0.0, 0, false, false, true, false, false)
        end
        lastJump.reset()
    end
end)

menu.toggle_loop(worldlist, "载具暴乱", {}, "使附近的汽车进入哥布林-妖精模式",function()
    for i, veh in ipairs(entities.get_all_vehicles_as_handles()) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, 0.0, 10.0, 0.0, true, true, true, true)
    end
end)

menu.toggle_loop(worldlist,"轰炸区", {}, "", function()
    local hash = util.joaat("imp_prop_bomb_ball")
    request_model_load(hash)
    if active_bowling_balls <= 15 then 
        local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), math.random(-200, 200), math.random(-200, 200), math.random(100, 300))
        local ball = entities.create_object(hash, c)
        ENTITY.FREEZE_ENTITY_POSITION(ball, false)
        ENTITY.SET_ENTITY_DYNAMIC(ball, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(ball, 1, math.random(-300, 300), math.random(-300, 300), -300, 0, 0, 0, 0, true, false, true, true, true)
        bomb_shower_tick_handler(ball)
    end
    util.yield(500)
end)

clear_radius = 1000
function clear_area(radius)
    target_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    MISC.CLEAR_AREA(target_pos['x'], target_pos['y'], target_pos['z'], radius, true, false, false, false)
end
function get_closest_train()
    local vehicles = entities.get_all_vehicles_as_handles()
    for k, veh in pairs(vehicles) do
        if ENTITY.GET_ENTITY_MODEL(veh) == 1030400667 then
            request_control_of_entity(veh)
            return veh
        end
    end
    util.toast("找不到最近的火车")
    return 0
end
train_list = menu.list(worldlist, "列车选项", {}, "")
    local models = {
        util.joaat("metrotrain"), util.joaat("freight"), util.joaat("freightcar"), util.joaat("freightcont1"), util.joaat("freightcont2"), util.joaat("freightgrain"), util.joaat("tankercar")
    }
    local variations = {
        "Variation 1", "Variation 2", "Variation 3", "Variation 4", "Variation 5", "Variation 6", "Variation 7", "Variation 8", "Variation 9", "Variation 10", "Variation 11", "Variation 12", "Variation 13", "Variation 14", "Variation 15", "Variation 16", "Variation 17", "Variation 18", "Variation 19", "Variation 20", "Variation 21", "Variation 22"
    }
    local last_train = 0
    local last_train_menu = 0
    for _, model in ipairs(models) do
        STREAMING.REQUEST_MODEL(model)
        while not STREAMING.HAS_MODEL_LOADED(model) do
            util.yield()
        end
    end
    local function spawn_train(variation, pos) 
        local train = VEHICLE.CREATE_MISSION_TRAIN(variation, pos.x, pos.y, pos.z, 0)
        last_train = train
        local posTrain = ENTITY.GET_ENTITY_COORDS(last_train)
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(veh)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netid)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, false)
        util.toast(string.format("Train spawned at (%.1f, %.1f, %.1f) variant %d", posTrain.x, posTrain.y, posTrain.z, variation))
        last_train_menu = submenu
        return train
    end
    train_build = menu.list(train_list, "火车生成", {}, "")
        menu.click_slider(train_build, "火车生产数量", {}, "产生具有有一定变化的火车", 1, 23, 1, 1, function(variation, prev)
            local ped = PLAYER.GET_PLAYER_PED(players.user())
            local pos = ENTITY.GET_ENTITY_COORDS(ped, 1)
            spawn_train(variation - 1, pos)
        end)
        menu.action(train_build, "生成地铁列车", {}, "制造地铁列车", function()
            local ped = PLAYER.GET_PLAYER_PED(players.user())
            local pos = ENTITY.GET_ENTITY_COORDS(ped, 1)
            spawn_train(21, pos)
        end)
    menu.action(train_list, "驾驶附近的火车", {}, "", function(on_click)
        train = get_closest_train()
        if train ~= 0 then
            entities.delete(VEHICLE.GET_PED_IN_VEHICLE_SEAT(train, -1))
            PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), train, -1)
            AUDIO.SET_VEHICLE_RADIO_ENABLED(train, true)
        end
    end)
    menu.click_slider(train_list,"设置列车速度", {}, "", -300, 300, 10, 10, function(s)
        local train_hdl = 0
        local was_any_train_affected = false
        for _, veh in pairs(entities.get_all_vehicles_as_pointers()) do 
            if entities.get_model_hash(veh) == util.joaat("freight") then
                train_hdl = entities.pointer_to_handle(veh)
                request_control_of_entity(train_hdl)
                VEHICLE.SET_TRAIN_SPEED(train_hdl, s)
                VEHICLE.SET_TRAIN_CRUISE_SPEED(train_hdl, s)
                was_any_train_affected = true
            end
        end
        if not was_any_train_affected then
        end
    end)
    menu.action(train_list, "下车", {}, "", function(click_type)
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
            TASK.TASK_LEAVE_ANY_VEHICLE(players.user_ped(), 0, 16)
    end)
    train_position = menu.list(train_list, "列车站点传送", {}, "")
    menu.action(train_position, "大洋公路站点", {}, "", function()
        TELEPORT(-86, 6198, 31)
    end)
    menu.action(train_position, "维斯普奇大道站点", {}, "", function()
        TELEPORT(674, -1048, 22)
    end)

hudminimapmenu = menu.list(worldlist, "小地图")
    mapzoom = 1
    menu.slider(hudminimapmenu, "小地图缩放", {"minimapzoom"}, "", 0, 100, 0, 1, function(s)
        HUD.SET_RADAR_ZOOM_PRECISE(s)
    end)

    mapangle = 0
    menu.slider(hudminimapmenu,"小地图角度", {"minimapanglme"}, "", 0, 360, 0, 1, function(s)
        mapangle = s
    end)

    mapanglet = off
    menu.toggle(hudminimapmenu,"锁定地图角度", {"lockminimapangle"}, "", function(on)
        mapanglet = on
        while mapanglet do
            HUD.LOCK_MINIMAP_ANGLE(mapangle)
            util.yield()
        end
        HUD.UNLOCK_MINIMAP_ANGLE()
    end)
    menu.toggle(hudminimapmenu,"显示声呐", {"sonaronmap"}, "", function(on)
        HUDdaidai._SET_MINIMAP_SONAR_ENABLED(on)
    end)
    
    centermap = off
    menu.toggle(hudminimapmenu, "以你为中心的地图", {"centermap"}, "", function(on)
        centermap = on
        while centermap do 
            HUD.DONT_TILT_MINIMAP_THIS_FRAME()
            util.yield()
        end
    end)

menu.toggle(worldlist, "哲学的美", {}, "", function(on)
    local a_toggle = menu.ref_by_path('World>Aesthetic Light>Aesthetic Light')
    if on then 
        menu.trigger_commands("shader glasses_purple")-----屏幕效果
        menu.trigger_commands("aestheticcolourred 255")
        menu.trigger_commands("aestheticcolourgreen 0")
        menu.trigger_commands("aestheticcolourblue 255")
        menu.trigger_commands("aestheticrange 10000")
        menu.trigger_commands("aestheticintensity 30")----强度30
        menu.trigger_commands("time 0")
        menu.set_value(a_toggle, true)
    else
        menu.set_value(a_toggle, false)
        menu.trigger_commands("shader off")
    end
end)
menu.action(worldlist, "时间流逝", {""}, "",function()
    menu.trigger_commands("timesmoothing on")
        menu.trigger_commands("time 0")
        util.yield(1000)
        menu.trigger_commands("time 12")
end)


all_npc = menu.list(worldlist, "NPC", {})
    menu.toggle_loop(all_npc, "友好的NPC", {""}, "NPC不会攻击你.", function()
        PED.SET_PED_RESET_FLAG(players.user_ped(), 124, true)
    end)
    menu.toggle_loop(all_npc, "自动杀死敌人", {}, "", function()
        local counter = 0
        for _, ped in ipairs(entities.get_all_peds_as_handles()) do
            if HUD.GET_BLIP_COLOUR(HUD.GET_BLIP_FROM_ENTITY(ped)) == 1 or TASK.GET_IS_TASK_ACTIVE(ped, 352) then -- shitty way to go about it but hey, it works (most of the time).
                ENTITY.SET_ENTITY_HEALTH(ped, 0)
                counter += 1
                util.yield()
            end
        end
        util.yield()
    end)
    pedToggleLoops = {
        {name = '摔倒NPC', command = 'ragdollPeds', description = '让附近的所有NPC都摔倒.', action = function(ped)
            if PED.IS_PED_A_PLAYER(ped) then return end
            PED.SET_PED_TO_RAGDOLL(ped, 2000, 2000, 0, true, true, true)
        end},
        {name = '死亡接触', command = 'deathTouch', description = '杀死所有碰到您的NPC', action = function(ped)
            if PED.IS_PED_A_PLAYER(ped) or PED.IS_PED_IN_ANY_VEHICLE(ped, true) or not ENTITY.IS_ENTITY_TOUCHING_ENTITY(ped, players.user_ped()) then return end
            ENTITY.SET_ENTITY_HEALTH(ped, 0, 0)
        end},
        {name = '寒冷NPC', command = 'coldPeds', description = '移除附近NPC的热特征', action = function(ped)
            if PED.IS_PED_A_PLAYER(ped) then return end
            PED.SET_PED_HEATSCALE_OVERRIDE(ped, 0)
        end},
        {name = 'NPC喇叭加速', command = 'npcHornBoost', description = '当NPC按喇叭的时候加速它们的载具.', action = function(ped)
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
            if PED.IS_PED_A_PLAYER(ped) or not PED.IS_PED_IN_ANY_VEHICLE(ped, true) or not AUDIO.IS_HORN_ACTIVE(vehicle) then return end
            AUDIO.SET_AGGRESSIVE_HORNS(true) --Makes pedestrians sound their horn longer, faster and more agressive when they use their horn.
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, ENTITY.GET_ENTITY_SPEED(vehicle) + 1.2)
        end, onStop = function()
            AUDIO.SET_AGGRESSIVE_HORNS(false)
        end},
        {name = 'NPC警笛加速', command = 'npcSirenBoost', description = '当NPC响起警车的警笛的时候加速它们的载具.', action = function(ped)
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
            if PED.IS_PED_A_PLAYER(ped) or not PED.IS_PED_IN_ANY_VEHICLE(ped, true) or not VEHICLE.IS_VEHICLE_SIREN_ON(vehicle) then return end
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, ENTITY.GET_ENTITY_SPEED(vehicle) + 1.2)
        end}
    }
    for i = 1, #pedToggleLoops do
        menu.toggle_loop(all_npc, pedToggleLoops[i].name, {pedToggleLoops[i].command}, pedToggleLoops[i].description, function()
            local pedHandles = entities.get_all_peds_as_handles()
            for j = 1, #pedHandles do
                pedToggleLoops[i].action(pedHandles[j])
            end
            util.yield(10)
        end, function()
            if pedToggleLoops[i].onStop then pedToggleLoops[i].onStop() end
        end)
    end


menu.toggle_loop(worldlist, "闪电生成", {""}, "", function()
    MISC.FORCE_LIGHTNING_FLASH()
end)
menu.toggle(worldlist, "停电", {"poweroutage"}, "", function(toggled)
    GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(toggled)
end)
menu.toggle(worldlist, "世界末日", {"blackout"}, "", function(toggled)
    menu.trigger_commands("time 1")
    GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(toggled)
    if toggled then
        GRAPHICS.SET_TIMECYCLE_MODIFIER("dlc_island_vault")
    else
        GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
    end
end)


visuallist = menu.list(worldlist, "视觉效果", {})
menu.click_slider(visuallist, "醉酒模式", {}, "", 0, 5, 1, 1, function(val)
    if val > 0 then
        CAM.SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", val)
        GRAPHICS.SET_TIMECYCLE_MODIFIER("Drunk")
    else
        GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
        CAM.SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 0)
    end
end)
local visual_stuff = {
    {"提升亮度", "AmbientPush"},
    {"提升饱和度", "rply_saturation"},
    {"提升曝光度", "LostTimeFlash"},
    {"雾之夜", "casino_main_floor_heist"},
    {"更好的夜晚", "dlc_island_vault"},
    {"正常雾天", "Forest"},
    {"大雾天", "nervousRON_fog"},
    {"黄昏天", "MP_Arena_theme_evening"},
    {"暖色调", "mp_bkr_int01_garage"},
    {"死气沉沉", "MP_deathfail_night"},
    {"石化", "stoned"},
    {"水下", "underwater"},
}
local visual_fidelity = menu.list(visuallist, "视觉增强", {}, "")
for id, data in pairs(visual_stuff) do
    local visual_name = data[1]
    local visual_thing = data[2]
    local visual = false
    local visual_toggle
    visual_toggle = menu.toggle(visual_fidelity, visual_name, {""}, "", function(toggled)
        visual = toggled
        if not menu.get_value(visual_toggle) then
            GRAPHICS.ANIMPOSTFX_STOP_ALL()
        return end

        while visual do
            GRAPHICS.SET_TIMECYCLE_MODIFIER(visual_thing)
            menu.trigger_commands("shader off")
            util.yield(250)
        end
        GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
    end)
end 
local drugged_effects = {
    "药品 1",
    "药品 2",
    "药品 3",
    "药品 4",
    "药品 5",
    "药品 6",
    "药品 7",
    "药品 8",
}
local drug_mode = menu.list(visuallist, "药物过滤器", {}, "")
for id, data in pairs(drugged_effects) do
    menu.toggle(drug_mode, data, {}, "", function(toggled)
        if toggled then
            GRAPHICS.SET_TIMECYCLE_MODIFIER(data)
            menu.trigger_commands("shader off")
        else
            GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
        end
    end)
end
local effect_stuff = {
    {"吸毒驾车", "DrugsDrivingIn"}, 
    {"吸毒的崔佛", "DrugsTrevorClownsFight"},
    {"吸毒的麦克", "DrugsMichaelAliensFight"},
    {"小查视角(红绿色盲)", "ChopVision"},
    {"默片", "DeathFailOut"},
    {"黑白", "HeistCelebPassBW"},
    {"横冲直撞", "Rampage"},
    {"我的眼镜在哪里？", "MenuMGSelectionIn"},
    {"梦境", "DMT_flight_intro"},
}
local visions = menu.list(visuallist, "屏幕效果", {}, "")
for id, data in pairs(effect_stuff) do
    local effect_name = data[1]
    local effect_thing = data[2]
    local effect = false
    local effect_toggle
    effect_toggle = menu.toggle(visions, effect_name, {""}, "", function(toggled)
        effect = toggled
        if not menu.get_value(effect_toggle) then
            GRAPHICS.ANIMPOSTFX_STOP_ALL()
        return end

        while effect do
            GRAPHICS.ANIMPOSTFX_PLAY(effect_thing, 5, true)
            util.yield(1000)
        end
    end)
end 

tp_world = menu.list(worldlist, "传送选项", {})

    pump_list = menu.list(tp_world, "场景", {}, "故事模式场景区域")
        for index, data in pairs(interiors) do
            local location_name = data[1]
            local location_coords = data[2]
            menu.action(pump_list, location_name, {}, "", function()
                menu.trigger_commands("doors on")
                menu.trigger_commands("nodeathbarriers on")
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), location_coords.x, location_coords.y, location_coords.z, false, false, false)
            end)
        end
    pump_list = menu.list(tp_world, "南瓜", {}, "万圣节南瓜头")
        for idx, coords in pumps_from_gtaweb_eu do
            pump_list:action("南瓜头 " .. idx, {}, "传送到南瓜", function()
                util.teleport_2d(coords[1], coords[2])
            end)
        end
    snow_loca = menu.list(tp_world, "雪人", {}, "")
        for idx, coords in snowmens do
            snow_loca:action("雪人 " .. idx, {}, "传送到圣诞节", function()
                util.teleport_2d(coords[1], coords[2])
            end)
        end
    snow_loca = menu.list(tp_world, "武器厢型车购买", {}, "")
        for idx, coords in weaponvan do
            snow_loca:action("厢型车 " .. idx, {}, "传送到厢型车", function()
                util.teleport_2d(coords[1], coords[2])
            end)
        end
    figures_loca = menu.list(tp_world, "手办", {}, "")
        for idx, coords in figures do
            figures_loca:action("手办 " .. idx, {}, "传送到手办", function()
                util.teleport_2d(coords[1], coords[2])
            end)
        end
    jammers_loca = menu.list(tp_world, "信号干扰器", {}, "")
        for idx, coords in jammers do
            jammers_loca:action("信号干扰器 " .. idx, {}, "传送到信号干扰器", function()
                util.teleport_2d(coords[1], coords[2])
            end)
        end
    movie_props = menu.list(tp_world, "电影道具", {}, "")
    for idx, coords in movie_prop1 do
        movie_props:action("电影道具 " .. idx, {}, "传送到电影道具", function()
            util.teleport_2d(coords[1], coords[2])
        end)
    end
    workshop_products = menu.list(tp_world, "拉玛有机作坊产品", {}, "")
    for idx, coords in ld_product do
        workshop_products:action("产品 " .. idx, {}, "传送到产品", function()
            util.teleport_2d(coords[1], coords[2])
        end)
    end
    tp_card = menu.list(tp_world, "纸牌", {}, "")
    for idx, coords in cards1 do
        tp_card:action("纸牌 " .. idx, {}, "传送到纸牌", function()
            util.teleport_2d(coords[1], coords[2])
        end)
    end

----------作弊者检测
menu.toggle(cheater_detection, "一键开启", {}, "", function(on)
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
    end
end)
menu.divider(cheater_detection,"检测列表")
pin1 = menu.toggle_loop(cheater_detection, "玩家无敌检测", {"pin1"}, "检测是否在使用无敌.", function()
    god_detection()
end)
pin2 = menu.toggle_loop(cheater_detection, "载具无敌检测", {"pin2"}, "检测载具是否在使用无敌.", function()
    car_god_detection()
end)
pin3 = menu.toggle_loop(cheater_detection, "未发布载具检测", {"pin3"}, "检测是否有人在驾使尚未发布的车辆.", function()
    unreleased_car_detection()
end)
pin4 = menu.toggle_loop(cheater_detection, "无法获得武器检测", {"pin4"}, "检测是否有人使用无法在线获得的武器.", function()
    cantgetweapon_detection()
end)
pin5 = menu.toggle_loop(cheater_detection, "无法获得载具检测", {"pin5"}, "检测是否有人正在使用无法在线获得的车辆.", function()
    cantgetvar_detection()
end)
pin6 = menu.toggle_loop(cheater_detection, "室内使用武器检测", {"pin6"}, "检测玩家是否在室内使用武器.", function()
    usingweapon_detection()
end)
pin7 = menu.toggle_loop(cheater_detection, "超级驾驶检测", {"pin7"}, "检测是否有在修改载具车速.", function()
    supercar_detection()
end)
pin8 = menu.toggle_loop(cheater_detection, "超级跑检测", {"pin8"}, "检测玩家是否在使用超级跑（奔跑速度不合常理）", function()
    superrun_detection()
end)
pin9 = menu.toggle_loop(cheater_detection, "观看检测", {"pin9"}, "检测是否有人在观看你.", function()
    lookingyou_detection()
end)
pin10 = menu.toggle_loop(cheater_detection, "传送检测", {"pin10"}, "检测玩家是否使用了传送", function()
    tp_detection()
end)
pin11 = menu.toggle_loop(cheater_detection, "改装武器检测", {"pin11"}, "检测玩家是否使用了改装武器", function()
    modified_weapon_detection()
end)
pin12 = menu.toggle_loop(cheater_detection, "改装载具检测", {"pin12"}, "检测玩家是否使用了改装载具", function()
    modified_vehicles_detection()
end)

------其他选项
menu.toggle_loop(otherlist, '小挂件', {}, '', function()
    dd_showpng()  
end)
----------------------------------
local keyrun = false
local wasdww = menu.list(otherlist, '按键显示', {''}, '')
menu.toggle(wasdww, '打开', {'wasd'}, '', function(on) 
	keyrun = on
end, false)
menu.slider(wasdww, 'X轴', {''}, '',1 , 10000, overlay_x * 10000, 20, function(value)
	overlay_x = value / 10000
end)
menu.slider(wasdww, 'Y轴', {''}, '',1 , 10000, overlay_y * 10000, 20, function(value)
	overlay_y = value / 10000
end)
menu.slider(wasdww, '大小', {''}, '',1 , 10000, 300, 20, function(value)
	size = value / 10000
    boxMargin = size / 7
end)
util.create_tick_handler(function()
    if keyrun then
    key_display()
    end
end)
----------------------------------
local kongzhitai = menu.list(otherlist, "控制台选项", {""}, "")
local log_dir = filesystem.stand_dir() .. '\\Log.txt'
local full_stdout = ""
local disp_stdout = ""
local max_chars = 200
local max_lines = 25
local font_size = 0.45
local timestamp_toggle = true
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
menu.toggle(kongzhitai, "绘制控制台", {"ndrawconsole12"}, "", function(on)
    draw_toggle = on
end)
menu.slider(kongzhitai, "最大显示字数", {}, "", 1, 1000, 200, 1, function(s)
    max_chars = s
end)
menu.slider(kongzhitai, "最大显示行数", {}, "", 1, 60, 25, 1, function(s)
    max_lines = s
end)
menu.slider_float(kongzhitai, "字体大小", {}, "", 1, 1000, 45, 1, function(s)
    font_size = s*0.01
end)
menu.toggle(kongzhitai, "显示时间", {}, "", function(on)
    timestamp_toggle = on
end, true)
local text_color = {r = 1, g = 1, b = 1, a = 1}
menu.colour(kongzhitai, "字体颜色", {"nconsoletextcolor"}, "", 1, 1, 1, 1, true, function(on_change)
    text_color = on_change
end)
menu.trigger_commands("nconsoletextcolorred 70")
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

local logo = directx.create_texture(filesystem.store_dir() .. '/daidai-IMG/Img/' .. 'banner.png')
menu.toggle_loop(otherlist, "显示帮会图标", {}, "欢迎加入帮会\n帮会名: Tokniko", function()
    logo_alpha = 1
    directx.draw_texture(logo, 0.06, 0.1, 0.0, 0.0, 0.86, 0.57, 0, 1, 1, 1, logo_alpha)
end)

acknowledgement_list = menu.list(otherlist, "鸣谢", {}, "")
    acknowledgement()
menu.action(otherlist, "快速重启GTAV", {""}, "不会退出游戏哦", function(on_click)
    NETWORKdaidai._SHUTDOWN_AND_LOAD_MOST_RECENT_SAVE()
end)
menu.action(otherlist, "重启GTAV", {""}, "重启游戏", function(on_click)
    MISC1._RESTART_GAME()
end)
menu.action(otherlist, "快速关闭GTAV", {""}, "正如你所见,秒关GTA5", function()
    os.exit()
end)

menu.hyperlink(otherlist, "daidai lua群", "https://qm.qq.com/cgi-bin/qm/qr?k=RGZGWK_kEeWk3-pgyRcd6CbDQsnlbjyt", "欢迎加入我们的大家庭")
menu.hyperlink(otherlist, "daidai 官网", "https://duckerhome.netlify.app/", "")

rgb_gui = menu.list(otherlist, "rgb", {}, "",function()util.toast("[呆呆 提示] \n使用后需重启游戏才能恢复哦")end)
    local rgbguir = 254
    local rgbguig = 2
    local rgbguib = 255
    menu.toggle_loop(rgb_gui, "RGB界面", {}, "", function()
        for i=0,215 do
            HUD.REPLACE_HUD_COLOUR_WITH_RGBA(i, rgbguir, rgbguig, rgbguib, 255)
        end
    end)
    menu.divider(rgb_gui,"更改颜色")
    menu.slider(rgb_gui, 'r', {'setrgbguir'}, '', 0, 255, 254, 1, function (c)
        rgbguir = c
    end)
    menu.slider(rgb_gui, 'g', {'setrgbguig'}, '', 0, 255, 2, 1, function (c)
        rgbguig = c
    end)
    menu.slider(rgb_gui, 'b', {'setrgbguib'}, '', 0, 255, 255, 1, function (c)
        rgbguib = c
    end)

menu.action(otherlist, "获取自己位置坐标", {}, "", function()
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    x = pos['x'] // 1
    y = pos['y'] // 1
    z = pos['z'] // 1
    chat.send_message("x: "..x.." y: "..y.." z: "..z, true, true, false)
end)
menu.action(otherlist, "版本", {""}, script_version, function(on_click)
end)


--------------------------------------飞机HUD
    local player_vehicle 
    local mst_warn
    local lastwpn
    local mode 
    local wpn
    local altitude = 0
    local missile_nearby 

    local aalib = require("aalib")
    local PlaySound = aalib.play_sound
    local SND_ASYNC<const> = 0x0001
    local SND_FILENAME<const> = 0x00020000

    local store_dir = filesystem.scripts_dir() .. '\\daidaiScript\\' .. '\\flightredux\\'
    sound_selection_dirterrain = store_dir .. '\\terrain.txt'
    sound_selection_dirmissile = store_dir .. '\\missile.txt'

    fp = io.open(sound_selection_dirterrain, 'r')
    local file_selection = fp:read('*a')
    fp:close()

    fp = io.open(sound_selection_dirmissile, 'r')
    local file_selectionmissile = fp:read('*a')
    fp:close()

    local sound_location = store_dir .. '\\' .. file_selection

    local sound_locationmissile = store_dir .. '\\' .. file_selectionmissile


    hhud_dir = filesystem.scripts_dir() .. '\\daidaiScript\\' .. '\\flightredux\\'

    if not filesystem.scripts_dir(hhud_dir_dir) then
        util.toast("警告:资源目录丢失")
    end

    menu.toggle(planehud, "警报", {}, "", function(on)
        gpws = on
    end)

    trajectory_icon = directx.create_texture(hhud_dir .. 'trajectory.png')
    altimeter_outline = directx.create_texture(hhud_dir .. 'altimeter.png') 
    boresight = directx.create_texture(hhud_dir .. 'boresight.png') 
    line = directx.create_texture(hhud_dir .. 'line.png')
    circle = directx.create_texture(hhud_dir .. 'circle.png')
    contact = directx.create_texture(hhud_dir.. 'contact.png')


    hud_green = {
        r = 0, 
        g = 100,
        b = 0,
        a = 100
    }
    hud_red = {
        r = 255, 
        g = 0,
        b = 0,
        a = 100
    }
    hud_yellow = {
        r = 255, 
        g = 187,
        b = 0,
        a = 100
    }

    hud_offset = {0, 0}

    function world_to_screen_coords(x, y, z)
        sc_x = memory.alloc(8)
        sc_y = memory.alloc(8)
        GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(x, y, z, sc_x, sc_y)
        local ret = {
            x = memory.read_float(sc_x),
            y = memory.read_float(sc_y)
        }
        return ret
    end

    function get_entity_trajectory(entity)
        local c = ENTITY.GET_ENTITY_COORDS(entity)
        local v = ENTITY.GET_ENTITY_VELOCITY(entity)
        local trajectory = {
            x = c.x + v.x,
            y = c.y + v.y, 
            z = c.z + v.z
        }
        return trajectory
    end

    -- thanks jerry
    function get_weapon_hash(ped)
        local weaponHash = WEAPON.GET_SELECTED_PED_WEAPON(ped)
        local vehWeaponHash = nil
        local wpn_ptr = memory.alloc_int()
        local vehicleWeapon = false
        if WEAPON.GET_CURRENT_PED_VEHICLE_WEAPON(ped, wpn_ptr) then -- only returns true if the weapon is a vehicle weapon
            vehWeaponHash = memory.read_int(wpn_ptr)
            vehicleWeapon = true
        end
        return (vehWeaponHash and vehWeaponHash or weaponHash), vehicleWeapon
    end

    function get_lockon_tgt(vehicle)
        local alloc = memory.alloc_int()
        VEHICLE.GET_VEHICLE_LOCK_ON_TARGET(vehicle, alloc) 
        return memory.read_int(alloc)
    end

    function get_model_size(hash)
        local minptr = memory.alloc(24)
        local maxptr = memory.alloc(24)
        MISC.GET_MODEL_DIMENSIONS(hash, minptr, maxptr)
        min = memory.read_vector3(minptr)
        max = memory.read_vector3(maxptr)
        local size = {}
        size['x'] = max['x'] - min['x']
        size['y'] = max['y'] - min['y']
        size['z'] = max['z'] - min['z']
        size['max'] = math.max(size['x'], size['y'], size['z'])
        return size
    end

    local sink_rate = 0.0
    last_z = 0.0
    util.create_thread(function()
        while true do
            if player_vehicle ~= 0 then
                local c = ENTITY.GET_ENTITY_COORDS(player_vehicle)
                sink_rate = c.z - last_z 
                last_z = c.z
            end
            util.yield(300)
        end
    end)

    local play_sound_this_frame = false
    util.create_thread(function()
        while true do
            play_sound_this_frame = not play_sound_this_frame
            util.yield(2550)
        end
    end
    )
    -- blinking thread
    local blink_this_frame = false
    util.create_thread(function()
        while true do
            blink_this_frame = not blink_this_frame
            util.yield(500)
        end
    end
    )

    -- faster blinking thread
    local f_blink_this_frame = false
    util.create_thread(function()
        while true do
            f_blink_this_frame = not f_blink_this_frame
            util.yield(100)
        end
    end
    )

    function is_entity_a_projectile(hash)
        local all_projectile_hashes = {
            util.joaat("w_ex_vehiclemissile_1"),
            util.joaat("w_ex_vehiclemissile_2"),
            util.joaat("w_ex_vehiclemissile_3"),
            util.joaat("w_ex_vehiclemissile_4"),
            util.joaat("w_ex_vehiclem,tar"),
            util.joaat("w_lr_rpg_rocket"),
            util.joaat("w_lr_homing_rocket"),
            util.joaat("w_lr_firew,k_rocket"),
            util.joaat("xm_prop_x17_silo_rocket_01")
        }
        return table.contains(all_projectile_hashes, hash)
    end

    -- CREDIT TO NOWIRY
    local function get_entity_owner(entity)
        local pEntity = entities.handle_to_pointer(entity)
        local addr = memory.read_long(pEntity + 0xD0)
        return (addr ~= 0) and memory.read_byte(addr + 0x49) or -1
    end

    -- projectile radar
    menu.toggle(planehud , "导弹雷达", {}, "", function(state)
        UItoggle = state
        local projectile_blips = {}
        while UItoggle do
            for k,b in pairs(projectile_blips) do
                if HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(b) == 0 then 
                    util.remove_blip(b) 
                    projectile_blips[k] = nil
                end
            end
            all_objects = entities.get_all_objects_as_handles()
            missile_nearby = false
            for k,obj in pairs(all_objects) do
                if is_entity_a_projectile(ENTITY.GET_ENTITY_MODEL(obj)) then
                    local c1 = ENTITY.GET_ENTITY_COORDS(obj)
                    local c2 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_vehicle, 0.0, -300.0, 0.0)
                    if (MISC.GET_DISTANCE_BETWEEN_COORDS(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, true) < 300 and get_entity_owner(obj) ~= players.user()) then 
                        missile_nearby = true
                    end
                    if HUD.GET_BLIP_FROM_ENTITY(obj) == 0 then
                        local proj_blip = HUD.ADD_BLIP_FOR_ENTITY(obj)
                        HUD.SET_BLIP_SPRITE(proj_blip, 443)
                        HUD.SET_BLIP_COLOUR(proj_blip, 75)
                        projectile_blips[#projectile_blips + 1] = proj_blip 
                    end
                end
            end
            util.yield()
        end
    end)
    -- mark contacts thread
    util.create_thread(function()
        while true do 
            if player_vehicle ~= 0 and PED.IS_PED_IN_ANY_PLANE(players.user_ped()) or PED.IS_PED_IN_ANY_HELI(players.user_ped()) then
                all_vehicles = entities.get_all_vehicles_as_handles()
                for k,veh in pairs(all_vehicles) do
                    local mdl = ENTITY.GET_ENTITY_MODEL(veh)
                    if veh ~= player_vehicle and ENTITY.GET_ENTITY_HEALTH(veh) > 0 and ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(player_vehicle, veh, 17) then
                        local c = ENTITY.GET_ENTITY_COORDS(veh)
                        local draw_pos = world_to_screen_coords(c.x, c.y, c.z)
                        directx.draw_texture(contact, 0.005, 0.005, 0.5, 0.5, draw_pos.x, draw_pos.y, 0, hud_red)
                    end
                end
            end
            util.yield()
        end
    end)

    menu.toggle(planehud , "飞机HUD显示", {}, "", function(state)
        UItoggle = state
    while UItoggle do 
        mst_warn = ""
        player_vehicle = entities.get_user_vehicle_as_handle()
        if player_vehicle ~= 0 then
            altitude = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(player_vehicle)
            -- if first person
            if PED.IS_PED_IN_ANY_PLANE(players.user_ped()) or PED.IS_PED_IN_ANY_HELI(players.user_ped()) then
                local size = get_model_size(ENTITY.GET_ENTITY_MODEL(player_vehicle))
                local vehicle_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_vehicle, 0.0, 10.0, (size.z / 2)-1.2)
                --local hud_pos = {x = 0.5, y = 0.5}
                local hud_pos = world_to_screen_coords(vehicle_pos.x, vehicle_pos.y, vehicle_pos.z)
                local trajectory = get_entity_trajectory(player_vehicle)
                local _2d_trajectory = world_to_screen_coords(trajectory.x, trajectory.y, trajectory.z)
                HUD.HIDE_HUD_COMPONENT_THIS_FRAME(14)
                -- trajectory
                directx.draw_texture(trajectory_icon, 0.02, 0.02, 0.0, 0.0, _2d_trajectory.x, _2d_trajectory.y, 0, hud_green)
                -- boresight
                directx.draw_texture(boresight, 0.005, 0.005, 0.0, 0.0, hud_pos.x, hud_pos.y, 0, hud_green)
                -- altimeter
                directx.draw_texture(altimeter_outline, 0.020, 0.020, 0.0, 0.0, 0.7, 0.4, 0, hud_green)
                directx.draw_text(0.71, 0.42, "ALT " .. tostring(math.ceil(altitude)), 4, 1.2, hud_green, false)
                -- gear 
                if VEHICLE.GET_LANDING_GEAR_STATE(player_vehicle) == 0 then
                    directx.draw_text(0.50, 0.40, "GEAR", 5, 0.7, hud_green, false)
                end
                -- airspeed
                local knts = (ENTITY.GET_ENTITY_SPEED(player_vehicle) * 2.236936)*0.868976
                -- directional
                local ang = ENTITY.GET_ENTITY_ROTATION(player_vehicle, 0)
                directx.draw_text(0.71, 0.46, "PITCH " .. tostring(math.ceil(ang.x)), 4, 0.7, hud_green, false)
                directx.draw_text(0.71, 0.48, "ROLL " .. tostring(math.ceil(ang.Y)), 4, 0.7, hud_green, false)
                directx.draw_text(0.50, 0.80, "HDG " .. tostring(math.ceil(ang.y)), 5, 0.7, hud_green, false)
                -- mach
                directx.draw_text(0.250, 0.62, "MACH " .. tostring(math.ceil(knts * 0.00149984)), 4, 0.8, hud_green, false)
                directx.draw_texture(altimeter_outline, 0.020, 0.020, 0.0, 0.0, 0.3, 0.44, 0.5, hud_green)
                directx.draw_text(0.195, 0.42, tostring(math.ceil(knts)) .. " KMH", 4, 1.2, hud_green, false)
                wpn = get_weapon_hash(players.user_ped())
                if PAD.IS_CONTROL_JUST_RELEASED(37, 37) or mode == nil then
                    if wpn == -821520672 then 
                        if lastwpn == -821520672 then
                            pluto_switch wpn do 
                                case -821520672: 
                                    mode = 'GUN'
                                    break 
                                pluto_default: 
                                    mode = "NAV"
                            end
                        else
                            mode = "RKT (NH)"
                        end
                    else
                        mode = "RKT"
                    end
                    lastwpn = wpn
                end
                if mode == "RKT" then 
                    directx.draw_texture(circle, 0.1, 0.1, 0.5, 0.5, hud_pos.x, hud_pos.y, 0, hud_green)
                    lockon_state = VEHICLE.GET_VEHICLE_HOMING_LOCKON_STATE(player_vehicle)
                    -- i dont wanna usw switch here rly 
                    local t_s_sc
                    if lockon_state ~= 0 then 
                        local tgt = get_lockon_tgt(player_vehicle)
                        local t_c = ENTITY.GET_ENTITY_COORDS(tgt)
                        t_c_sc = world_to_screen_coords(t_c.x, t_c.y, t_c.z)
                    end
                    if lockon_state == 1 then 
                        if f_blink_this_frame then 
                            directx.draw_texture(circle, 0.01, 0.01, 0.5, 0.5, t_c_sc.x, t_c_sc.y, 0, hud_yellow)
                        end
                        directx.draw_text(0.61, 0.71, "LOCKING", 4, 0.8, hud_green, false)
                    elseif lockon_state == 2 then
                        if blink_this_frame then
                            directx.draw_text(0.61, 0.71, "LOCKED", 4, 0.8, hud_red, false)
                        end
                        directx.draw_texture(circle, 0.01, 0.01, 0.5, 0.5, t_c_sc.x, t_c_sc.y, 0, hud_red)
                        directx.draw_line(t_c_sc.x, t_c_sc.y, 0.5, 0.5, hud_red, hud_red)
                    end
                end
                directx.draw_text(0.195, 0.72, tostring(math.ceil((VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(player_vehicle)* 2.236936)*0.868976)) .. "\n" .. mode, 4, 0.8, hud_green, false)
                -- horizon line
                directx.draw_texture(line, 0.01, 0.001, 0.5, 0.0, 0.5, 0.5, (-ENTITY.GET_ENTITY_ROTATION(player_vehicle, 0).y)/360, hud_green)
                -- warnings
                if missile_nearby then 
                    mst_warn = "MISSILE"
                elseif VEHICLE.GET_VEHICLE_ENGINE_HEALTH(player_vehicle) < 800 then
                    mst_warn = "FIRE"
                elseif ENTITY.GET_ENTITY_HEALTH(player_vehicle)/ENTITY.GET_ENTITY_MAX_HEALTH(player_vehicle) < 0.5 then
                    mst_warn = "MASTER WARN"
                elseif altitude < 50 and VEHICLE.GET_LANDING_GEAR_STATE(player_vehicle) ~= 0 and gpws then
                    mst_warn = "TERRAIN"
                elseif sink_rate < -15 and gpws then
                    mst_warn = "SINK RATE"
                end

                pluto_switch mst_warn do
                    case "FIRE": 
                        if blink_this_frame then
                            directx.draw_text(0.5, 0.9, "FIRE", 5, 3, hud_red, false)
                        end
                        if play_sound_this_frame then
                            AUDIO.PLAY_SOUND_FRONTEND(-1, "Put_Away", "Phone_SoundSet_Michael", true)
                        end
                        break
                    case "MASTER WARN":
                        directx.draw_text(0.5, 0.9, "MASTER WARN", 5, 3, hud_red, false)
                        if play_sound_this_frame then 
                            AUDIO.PLAY_SOUND_FRONTEND(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true)
                        end
                        break
                    case "BOGEY LOCK-ON":
                        if f_blink_this_frame then 
                            directx.draw_text(0.5, 0.9, "BOGEY LOCK-ON", 5, 3, hud_red, false)
                        end
                        break
                    case "TERRAIN":
                        if f_blink_this_frame then 
                            directx.draw_text(0.5, 0.9, "TERRAIN PULL UP", 5, 3, hud_red, false)

                        end
                        if play_sound_this_frame then 
                            PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
                        end
                        break
                    case "SINK RATE":
                        directx.draw_text(0.5, 0.9, "SINK RATE", 5, 3, hud_yellow, false)
                        if play_sound_this_frame then 
                            AUDIO.PLAY_SOUND_FRONTEND(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", true)
                        end
                        break
                    case "MISSILE": 
                        directx.draw_text(0.5, 0.9, "MISSILE", 5, 3, hud_red, false)
                        if play_sound_this_frame then 
                            PlaySound(sound_locationmissile, SND_FILENAME | SND_ASYNC)
                        end
                end
            end 
        end
        util.yield()
    end
    end)
--------------------------------------模组---------------
function ls_log(content)
    if ls_debug then
        util.toast(content)
        util.log("[LANCESCRIPT RELOADED] " .. content)
    end
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

function request_model_load(hash)
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

function request_ptfx_load(hash)
    request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(hash)
    while not STREAMING.HAS_PTFX_ASSET_LOADED(hash) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end

function file_exists(path)
    local file = io.open(path, "rb")
    if file then file:close() end
    return file ~= nil
end

function hasValue( tbl, str )
    local f = false
    for i = 1, #tbl do
        if type( tbl[i] ) == "table" then
            f = hasValue( tbl[i], str )
            if f then break end
        elseif tbl[i] == str then
            return true
        end
    end
    return f
end

function split_str(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function to_boolean(text)
    if text == 'true' or text == "1" then
        return true
    end
    return false
end

function get_element_text(el)
    local pieces = {}
    for _,n in ipairs(el.kids) do
      if n.type=='element' then pieces[#pieces+1] = get_element_text(n)
      elseif n.type=='text' then pieces[#pieces+1] = n.value
      end
    end
    return table.concat(pieces)
end


vehicles_dir = filesystem.scripts_dir() .. '\\daidaiScript\\'.. '\\menyoo vehicles\\'
if not filesystem.is_dir(vehicles_dir) then
    filesystem.mkdir(vehicles_dir)
end

maps_dir = filesystem.scripts_dir() .. '\\daidaiScript\\'.. '\\menyoo maps\\'
if not filesystem.is_dir(maps_dir) then
    filesystem.mkdir(maps_dir)
end

menyoovmain_root = menu.list(XML_module, "载具", {}, "目录中的所有载具！")
menyoom_root = menu.list(XML_module, "地图", {}, "目录中的所有地图")
menyoovloaded_root = menu.list(XML_module, "当前加载的载具", {}, "已加载的载具")
menyoomloaded_root = menu.list(XML_module, "当前加载的地图", {}, "已加载的地图")
async_http.init("pastebin.com", "/raw/nrMdhHwE", function(result)
end)
async_http.dispatch()

function parse_xml(path)
    if not file_exists(path) then
        util.toast("文件不存在哦")
        return
    end
    local xml = io.open(path):read('*all')
    local dom = slaxdom:dom(xml, {stripWhitespace=true})
    return dom
end
function pid_to_handle(pid)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, handle_ptr, 13)
    return handle_ptr
end
function setup_menyoo_vehicles_list(mainroot, player, allplayers, dotp)
    for i, path in ipairs(filesystem.list_files(vehicles_dir)) do
        root = mainroot
        local ours = false
        if player == players.user() then
            ours = true 
        end
        if filesystem.is_dir(path) then
            root = menu.list(root, path:gsub(vehicles_dir, ''), {}, "")
            for i,path in ipairs(filesystem.list_files(path)) do
                menu.action(root, path:gsub(vehicles_dir, ''), {}, "生成这个menyoo载具", function(on_click)
                    ls_log("Click type was " .. on_click)
                    menyoo_load_vehicle(path, player, dotp, ours)
                end)
            end
        else
            if string.match(path:gsub(vehicles_dir, ''), '.xml') then
                menu.action(root, path:gsub(vehicles_dir, ''), {}, "生成这个menyoo载具", function(on_click)
                    ls_log("Click type was " .. on_click)
                    menyoo_load_vehicle(path, player, dotp, ours)
                end)
            end
        end
    end
end
function setup_menyoo_maps_list()
    for i, path in ipairs(filesystem.list_files(maps_dir)) do
        if filesystem.is_dir(path) then
            root = menu.list(menyoom_root, path:gsub(maps_dir, ''), {}, "")
            for i,path in ipairs(filesystem.list_files(path)) do
                menu.action(root, path:gsub(maps_dir, ''), {}, "生成这个menyoo地图", function(on_click)
                    menyoo_load_map(path)
                end)
            end
        else
            if string.match(path:gsub(maps_dir, ''), '.xml') then
                menu.action(menyoom_root, path:gsub(maps_dir, ''), {}, "生成这个menyoo地图", function(on_click)
                    menyoo_load_map(path)
                end)
            end
        end
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
function nil_handler(val, default)
    if val == nil then
        val = default
    end
    return val
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
    ls_log("Preprocessing vehicle " .. vehicle)
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
        VEHICLE1._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, comp[k], to_boolean(v))
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
    VEHICLE1._SET_VEHICLE_INTERIOR_COLOR(vehicle, colors['LrInterior'])
    VEHICLE1._SET_VEHICLE_DASHBOARD_COLOR(vehicle, colors['LrDashboard'])
    local livery = tonumber(data['Livery'])
    if livery == -1 then
        livery = 0
    end
    VEHICLE.SET_VEHICLE_LIVERY(vehicle, livery)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, data['NumberPlateText'])
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, tonumber(data['NumberPlateTextIndex']))
    VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, tonumber(data['WindowTint']))
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, to_boolean(data['BulletProofTyres']))
    VEHICLE. SET_VEHICLE_DIRT_LEVEL(vehicle, tonumber(data['DirtLevel']))
    VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, tonumber(data['PaintFade']))
    VEHICLE.SET_CONVERTIBLE_ROOF_LATCH_STATE(vehicle, tonumber(data['RoofState']))
    VEHICLE.SET_VEHICLE_SIREN(vehicle, to_boolean(data['SirenActive']))
    VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, to_boolean(data['EngineOn']), true, false)
    AUDIO.SET_VEHICLE_RADIO_LOUD(vehicle, to_boolean(data['IsRadioLoud']))
    VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, tonumber(data['LockStatus']))
    if data['EngineHealth'] ~= nil then
        VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, tonumber(data['EngineHealth']))
    end
    ls_log("Preprocessing complete for vehicle " .. vehicle)
end
function menyoo_build_properties_table(kids)
    ls_log("Building a menyoo properties table...")
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
function menyoo_load_map(path)
    local all_entities = {}
    util.toast("您的地图正在加载。这可能需要一些时间。")
    ls_log("Loading a map from " .. path)
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
                ls_log(d.name)
                if d.name == 'PositionRotation' then
                    for e, f in pairs(d.kids) do
                        data[f.name] = get_element_text(f)
                    end
                elseif d.name == 'VehicleProperties' then
                    ls_log("vprope")
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
                ls_log("done")
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
                util.toast("发现了一些无效模型。确保您没有使用需要mod的XML。")
            end
        end
    end
mm_maproot = menu.list(menyoomloaded_root, path:gsub(maps_dir, "") .. ' [' .. mmblip .. ']', {"lancescriptmenyooloadedmaps" .. mmblip}, "已加载的地图")
menu.action(mm_maproot, "传送到地图", {"menyoomteleportto" .. mmblip}, "传送到此地图。", function(on_click)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), mmpos.x, mmpos.y, mmpos.z, false, false, false)
end)
menu.action(mm_maproot, "删除地图", {"menyoomdelete" .. mmblip}, "", function(on_click)
    for k,v in pairs(all_entities) do
        entities.delete(v)
    end
    menu.delete(mm_maproot)
        HUD.SET_BLIP_ALPHA(mmblip, 0)
end)
    util.toast("地图加载完成。在你的地图上找一个洋红色的L。")
end
function menyoo_load_vehicle(path, ped, doteleport, ours)
    ls_log("Loading vehicle for ped " .. ped)
    local all_entities = {}
    if ours then
        ls_log("This is ours")
        mvped = PLAYER.PLAYER_PED_ID()
    else
        ls_log("This is theirs")
        mvped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(ped)
    end
    ls_log("Loading a vehicle from " .. path)
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
    menyoo_preprocess_entity(vehicle, data)
    menyoo_preprocess_car(vehicle, vproperties)
    local attachments = data['SpoonerAttachments']
    all_attachments = {}
    if attachments ~= nil then
        for a,b in pairs(attachments.kids) do
            local vproperties = {}
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
                entity = obj
                menyoo_preprocess_entity(obj, att_data)
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
    ls_log("Vehicle has been loaded.")
    local this_blip = HUD.ADD_BLIP_FOR_ENTITY(vehicle)
    HUD.SET_BLIP_SPRITE(this_blip, 77)
    HUD.SET_BLIP_COLOUR(this_blip, 47)
    local this_veh_root = menu.list(menyoovloaded_root, vehicle .. " [" .. VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(vehicle)) .. "]", {"lancescriptmenyoov" .. vehicle}, "")
    menu.action(this_veh_root, "删除", {"deletemenyoov" .. vehicle}, "删除此车辆", function(on_click)
        for k,v in pairs(all_entities) do
            entities.delete(v)
        end
        menu.delete(this_veh_root)
        HUD.SET_BLIP_ALPHA(this_blip, 0)
    end)
    menu.action(this_veh_root, "传送到载具里", {"teleportemenyoov" .. vehicle}, "", function(on_click)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, -1)
    end)
    return vehicle
end
setup_menyoo_vehicles_list(menyoovmain_root, players.user(), false, true)
setup_menyoo_maps_list()


----自启列表
menu.trigger_commands("openconstructor")----加载constructor模组

require "lib.daidailib.command"
players.dispatch_on_join()
util.keep_running()


--ufo
util.on_stop(function()

        if UFO.exists() then
            UFO.destroy()
        end
    
        if GuidedMissile.exists() then
            GuidedMissile.destroy()
        end
end)
local last_car = 0
while true do
    GuidedMissile.mainLoop()
    UFO.mainLoop()
----------
    if menu.get_value(waterdrive) == false then
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, 0, 0, 0, false, false, false)
    end

    player_cur_car = entities.get_user_vehicle_as_handle()
    if last_car ~= player_cur_car and player_cur_car ~= 0 then 
        on_user_change_vehicle(player_cur_car)
        last_car = player_cur_car
    end

    if renderscorched then
        if player_cur_car ~= 0 then
            ENTITY.SET_ENTITY_RENDER_SCORCHED(player_cur_car, true)
        end
    end
-------------
    util.yield()
end
