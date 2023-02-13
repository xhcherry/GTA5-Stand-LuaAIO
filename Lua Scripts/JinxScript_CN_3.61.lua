-- 倒卖狗不得好死,给你妈凑买棺材板的钱呢是吧? -- 
-- Jinx Scirpt中文区翻译: lu_zi / BlackMist 臣服 -- 
util.require_natives("natives-1672190175-uno")
local function player_toggle_loop(root, pid, menu_name, command_names, help_text, callback)
    return menu.toggle_loop(root, menu_name, command_names, help_text, function()
        if not players.exists(pid) then 
            util.stop_thread() 
        end
        callback()
    end)
end

local spawned_objects = {}

local function BitTest(bits, place)
    return (bits & (1 << place)) ~= 0
end

local function IsPlayerUsingOrbitalCannon(player)
    return BitTest(memory.read_int(memory.script_global((2657589 + (player * 466 + 1) + 427))), 0) -- Global_2657589[PLAYER::PLAYER_ID() /*466*/].f_427), 0
end

local function IsPlayerFlyingAnyDrone(player)
   return BitTest(memory.read_int(memory.script_global(1853910 + (player * 862 + 1) + 267 + 365)), 26) -- Global_1853910[PLAYER::PLAYER_ID() /*862*/].f_267.f_365, 26
end

local function IsPlayerUsingGuidedMissile(player)
    return (memory.read_int(memory.script_global(2657589 + 1 + (player * 466) + 321 + 10)) ~= -1 and IsPlayerFlyingAnyDrone(player)) -- Global_2657589[PLAYER::PLAYER_ID() /*466*/].f_321.f_10 
end

local function IsPlayerInRcBandito(player)
    return BitTest(memory.read_int(memory.script_global(1853910 + (player * 834 + 1) + 267 + 348)), 29)  -- Global_1853910[PLAYER::PLAYER_ID() /*834*/].f_267.f_348, 29
end

local function IsPlayerInRcTank(player)
    return BitTest(memory.read_int(memory.script_global(1853910 + (player * 834 + 1) + 267 + 428 + 2)), 16) -- Global_1853910[PLAYER::PLAYER_ID() /*862*/].f_267.f_428.f_2
end

local function GetSpawnState(pid)
    return memory.read_int(memory.script_global(((2657589 + 1) + (pid * 466)) + 232)) -- Global_2657589[PLAYER::PLAYER_ID() /*466*/].f_232
end

local function GetInteriorPlayerIsIn(pid)
    return memory.read_int(memory.script_global(((2657589 + 1) + (pid * 466)) + 245)) -- Global_2657589[bVar0 /*466*/].f_245)
end

local function IsPlayerInKosatka(player)
    return BitTest(memory.read_int(memory.script_global(1853910 + (player * 862 + 1 ) + 267 + 479)), 2) -- Global_1853910[PLAYER::PLAYER_ID() /*862*/].f_267.f_479, 2
end

function StandUser(pid) -- credit to sapphire for this
    if players.exists(pid) and pid ~= players.user() then
        for _, cmd in ipairs(menu.player_root(pid):getChildren()) do
            if cmd:getType() == COMMAND_LIST_CUSTOM_SPECIAL_MEANING and (cmd:refByRelPath("Stand User"):isValid() or cmd:refByRelPath("Stand User (Co-Loading"):isValid()) then
                return true
            end
        end
    end
    return false
end

local stand_notif = "对防护不错的菜单用户不起作用."

local function RequestModel(hash, timeout)
    timeout = timeout or 3
    STREAMING.REQUEST_MODEL(hash)
    local end_time = os.time() + timeout
    repeat
        util.yield()
    until STREAMING.HAS_MODEL_LOADED(hash) or os.time() >= end_time
    return STREAMING.HAS_MODEL_LOADED(hash)
end

local All_business_properties = {
    -- 会所
    "罗伊洛文斯坦大道 1334 号",
    "佩罗海滩 7 号",
    "艾尔金大街 75 号",
    "68 号公路 101 号",
    "佩立托大道 1 号",
    "阿尔冈琴大道 47 号",
    "资本大道 137 号",
    "克林顿大街 2214 号",
    "霍伊克大街 1778 号",
    "东约书亚路 2111 号",
    "佩立托大道 68 号",
    "戈马街 4 号",
    -- 设施
    "塞诺拉大沙漠设施",
    "68 号公路设施",
    "沙滩海岸设施",
    "戈多山设施",
    "佩立托湾设施",
    "桑库多湖设施",
    "桑库多河设施",
    "荣恩风力发电场设施",
    "兰艾水库设施",
    -- 游戏厅
    "像素彼得 - 佩立托湾",
    "奇迹神所 - 葡萄籽",
    "仓库 - 戴维斯",
    "八位元 - 好麦坞",
    "请投币 - 罗克福德山",
    "游戏末日 - 梅萨",
}

local small_warehouses = {
    [1] = "太平洋鱼饵仓储", 
    [2] = "白寡妇车库", 
    [3] = "赛尔托瓦单元", 
    [4] = "便利店车库", 
    [5] = "法拍车库", 
    [9] = "码头 400 号工作仓库", 
}

local medium_warehouses = {
    [7] = "翘臀内衣外景场地", 
    [10] = "GEE 仓库", 
    [11] = "洛圣都海事大厦 3 号楼", 
    [12] = "火车站仓库", 
    [13] = "透心凉辅楼仓库",
    [14] = "废弃的工厂直销店", 
    [15] = "折扣零售商店", 
    [21] = "旧发电站", 
}

local large_warehouses = {
    [6] = "希罗汽油工厂",  
    [8] = "贝尔吉科仓库", 
    [16] = "物流仓库", 
    [17] = "达内尔兄弟仓库", 
    [18] = "家具批发市场", 
    [19] = "柏树仓库", 
    [20] = "西好麦坞外景场地", 
    [22] = "沃克父子仓库"
}

local weapon_stuff = {
    {"烟花", "weapon_firework"}, 
    {"原子能枪", "weapon_raypistol"},
    {"邪恶冥王", "weapon_raycarbine"},
    {"电磁步枪", "weapon_railgun"},
    {"红色激光", "vehicle_weapon_enemy_laser"},
    {"绿色激光", "vehicle_weapon_player_laser"},
    {"天煞机炮", "vehicle_weapon_player_lazer"},
    {"火箭炮", "weapon_rpg"},
    {"制导火箭发射器", "weapon_hominglauncher"},
    {"紧凑型电磁脉冲发射器", "weapon_emplauncher"},
    {"信号弹", "weapon_flaregun"},
    {"霰弹枪", "weapon_bullpupshotgun"},
    {"电击枪", "weapon_stungun"},
    {"催泪瓦斯", "weapon_smokegrenade"},
}

local proofs = {
    bullet = {name="子弹",on=false},
    fire = {name="火烧",on=false},
    explosion = {name="爆炸",on=false},
    collision = {name="撞击",on=false},
    melee = {name="近战",on=false},
    steam = {name="蒸汽",on=false},
    drown = {name="溺水",on=false},
}

local modded_vehicles = {
    "dune2",
    "asea2",
    "sadler2",
    "tractor3",
    "emperor3",
    "mesa2",
    "rancherxl2",
    "stockade3",
    "burrito5",
    "policeold1",
    "policeold2",
    "cutter",
    "jet",
    "tractor",
    "armytrailer2",
    "towtruck",
    "towtruck2",
    "cargoplane",
}

local modded_weapons = {
    "weapon_railgun",
    "weapon_stungun",
    "weapon_digiscanner",
}

local doors = {
    "v_ilev_ml_door1",
    "v_ilev_ta_door",
    "v_ilev_247door",
    "v_ilev_247door_r",
    "v_ilev_lostdoor",
    "v_ilev_bs_door",
    "v_ilev_cs_door01",
    "v_ilev_cs_door01_r",
    "v_ilev_gc_door03",
    "v_ilev_gc_door04",
    "v_ilev_clothmiddoor",
    "v_ilev_clothmiddoor",
    "prop_shop_front_door_l",
    "prop_shop_front_door_r"
}

local interiors = {
    {"安全空间 [挂机室]", {x=-158.71494, y=-982.75885, z=149.13135}},
    {"酷刑室", {x=147.170, y=-2201.804, z=4.688}},
    {"矿道", {x=-595.48505, y=2086.4502, z=131.38136}},
    {"欧米茄车库", {x=2330.2573, y=2572.3005, z=46.679367}},
    {"50 车位车库", {x=520.0, y=-2625.0, z=-50.0}},
    {"服务器机房", {x=2474.0847, y=-332.58887, z=92.9927}},
    {"角色捏脸房间", {x=402.91586, y=-998.5701, z=-99.004074}},
    {"Lifeinvader 大楼", {x=-1082.8595, y=-254.774, z=37.763317}},
    {"竞速结束车库", {x=405.9228, y=-954.1149, z=-99.6627}},
    {"被摧毁的医院", {x=304.03894, y=-590.3037, z=43.291893}},
    {"花园银行体育场", {x=-256.92334, y=-2024.9717, z=30.145584}},
    {"Split Sides 喜剧俱乐部", {x=-430.00974, y=261.3437, z=83.00648}},
    {"录音 A 工作室", {x=-1010.6883, y=-49.127754, z=-99.40313}},
    {"巴哈马酒吧", {x=-1394.8816, y=-599.7526, z=30.319544}},
    {"看门人之家", {x=-110.20285, y=-8.6156025, z=70.51957}},
    {"费蓝德医生之家", {x=-1913.8342, y=-574.5799, z=11.435149}},
    {"杜根房子", {x=1395.2512, y=1141.6833, z=114.63437}},
    {"弗洛伊德公寓", {x=-1156.5099, y=-1519.0894, z=10.632717}},
    {"麦克家", {x=-813.8814, y=179.07889, z=72.15914}},
    {"富兰克林家 (旧)", {x=-14.239959, y=-1439.6913, z=31.101551}},
    {"富兰克林家 (新)", {x=7.3125067, y=537.3615, z=176.02803}},
    {"崔佛家", {x=1974.1617, y=3819.032, z=33.436287}},
    {"莱斯斯家", {x=1273.898, y=-1719.304, z=54.771}},
    {"莱斯特的纺织厂", {x=713.5684, y=-963.64795, z=30.39534}},
    {"莱斯特的纺织厂办事处", {x=707.2138, y=-965.5549, z=30.412853}},
    {"冰毒实验室", {x=1391.773, y=3608.716, z=38.942}},
    {"致幻剂实验室", {x=484.69, y=-2625.36, z=-49.0}},
    {"停尸房实验室", {x=495.0, y=-2560.0, z=-50.0}},
    {"人道实验室", {x=3625.743, y=3743.653, z=28.69009}},
    {"汽车旅馆客房", {x=152.2605, y=-1004.471, z=-99.024}},
    {"警察局", {x=443.4068, y=-983.256, z=30.689589}},
    {"太平洋标准银行金库", {x=263.39627, y=214.39891, z=101.68336}},
    {"布莱恩郡银行", {x=-109.77874, y=6464.8945, z=31.626724}}, -- 感谢 Fluidware 告诉我这个坐标
    {"龙舌兰酒吧", {x=-564.4645, y=275.5777, z=83.074585}},
    {"废料厂车库", {x=485.46396, y=-1315.0614, z=29.2141}},
    {"失落摩托帮", {x=980.8098, y=-101.96038, z=74.84504}},
    {"范吉利克珠宝店", {x=-629.9367, y=-236.41296, z=38.057056}},
    {"机场休息室", {x=-913.8656, y=-2527.106, z=36.331566}},
    {"停尸房", {x=240.94368, y=-1379.0645, z=33.74177}},
    {"联盟保存处", {x=1.298771, y=-700.96967, z=16.131021}},
    {"军事基地瞭望塔", {x=-2357.9187, y=3249.689, z=101.45073}},
    {"事务所内部", {x=-1118.0181, y=-77.93254, z=-98.99977}},
    {"事务所车库", {x=-1071.0494, y=-71.898506, z=-94.59982}},
    {"恐霸内部", {x=-1421.015, y=-3012.587, z=-80.000}},
    {"地堡内部", {x=899.5518,y=-3246.038, z=-98.04907}},
    {"IAA 办公室", {x=128.20, y=-617.39, z=206.04}},
    {"FIB 顶层", {x=135.94359, y=-749.4102, z=258.152}},
    {"FIB 47层", {x=134.5835, y=-766.486, z=234.152}},
    {"FIB 49层", {x=134.635, y=-765.831, z=242.152}},
    {"大公鸡", {x=-31.007448, y=6317.047, z=40.04039}},
    {"脱衣舞俱乐部 DJ 位置", {x=121.398254, y=-1281.0024, z=29.480522}},
}

local station_name = {
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
local values = {
    [1] = 50,
    [2] = 88,
    [3] = 160,
    [4] = 208,
}

local unreleased_vehicles = {
    "virtue",
    "broadway",
    "panthere",
    "everon2",
    "eudora",
    "boor"
}

local launch_vehicle = {"向上", "向前", "向后", "向下", "翻滚"}
local invites = {"游艇", "办公室", "会所", "办公室车库", "载具改装铺", "公寓"}
local style_names = {"正常", "半冲刺", "反向", "无视红绿灯", "避开交通", "极度避开交通", "有时超车"}
local drivingStyles = {786603, 1074528293, 1076, 2883621, 786468, 6, 262144, 5}
local bones = {12844, 24816, 24817, 24818, 35731, 31086}
local interior_stuff = {0, 233985, 169473, 169729, 169985, 170241, 177665, 177409, 185089, 184833, 184577, 163585, 167425, 167169}

local self = menu.list(menu.my_root(), "自我选项", {}, "")
local recovery = menu.list(menu.my_root(), "恢复选项")
local players_list = menu.list(menu.my_root(), "玩家选项", {}, "")
local lobby = menu.list(menu.my_root(), "战局选项")
local vehicles = menu.list(menu.my_root(), "载具选项", {}, "")
local missions = menu.list(menu.my_root(), "任务选项", {}, "")
local weapons = menu.list(menu.my_root(), "武器选项", {}, "")
local funfeatures = menu.list(menu.my_root(), "娱乐功能", {}, "")
local teleport = menu.list(menu.my_root(), "传送选项", {}, "")
local detections = menu.list(menu.my_root(), "检测选项", {}, "")
local modder_detections = menu.list(detections, "作弊者检测")
local normal_detections = menu.list(detections, "正常检测")
local bailOnAdminJoin = false
local protections = menu.list(menu.my_root(), "保护选项", {}, "")
local misc = menu.list(menu.my_root(), "其他选项", {}, "")

local int_min = -2147483647
local int_max = 2147483647

local spoofing = menu.ref_by_path("Online>Spoofing>Position Spoofing>Position Spoofing")

local menus = {}
local function player_list(pid)
    if NETWORK.NETWORK_IS_SESSION_ACTIVE()then 
        menus[pid] = menu.list(players_list, players.get_name(pid), {}, "", function()
            menu.trigger_commands("jinxscript " .. players.get_name(pid))
        end)
    end
end

local function handle_player_list(pid) -- 感谢 Dangerman 和 Aaron 向我展示如何正确删除玩家
    local ref = menus[pid]
    if not players.exists(pid) then
        if ref then
            menu.delete(ref)
            menus[pid] = nil
        end
    end
end

players.on_join(player_list)
players.on_leave(handle_player_list)

if not SCRIPT_SILENT_START and SOCIALCLUB.SC_ACCOUNT_INFO_GET_NICKNAME() ~= "UNKNOWN" then
    util.toast("坏b< " .. SOCIALCLUB.SC_ACCOUNT_INFO_GET_NICKNAME() .. " >欢迎使用JinxScript!\n" .. "官方Discord: https://discord.gg/hjs5S93kQv \n中文QQ交流群: 296512882") 
end
local function player(pid) 
    if pid ~= players.user() and players.get_rockstar_id(pid) == 0xCB2A48C then
        util.toast(lang.get_string(0xD251C4AA, lang.get_current()):gsub("{(.-)}", {player = players.get_name(pid), reason = "JinxScript Developer"}), TOAST_DEFAULT)
    end

    menu.divider(menu.player_root(pid), "JinxScript")
    local bozo = menu.list(menu.player_root(pid), "Jinx Script", {"JinxScript"}, "\n* 点击打开尊贵的Jinx脚本玩家选项\n* 免费的大爹级原创综合开源脚本\n* 作者: Prisuhm\n")

    local friendly = menu.list(bozo, "友好", {}, "")
    menu.action(friendly, "给TA升级", {}, "给予该玩家 17 万RP经验,可从 1 级提升至 25 级.\n一名玩家只能用一次嗷", function()
        menu.trigger_commands("givecollectibles" .. players.get_name(pid))
    end)

    local player_jinx_army = {}
    local army_player = menu.list(friendly, "宠物猫 Jinx 军队", {}, "整点小猫哄着你玩玩?\n删不掉的时候觉得烦的话换战局\n能少生成就少生成吧")
    menu.click_slider(army_player, "生成宠物猫 Jinx 军队", {}, "", 1, 256, 30, 1, function(val)
        local pos = players.get_position(pid)
        pos.y -= 5
        pos.z += 1
        local jinx = util.joaat("a_c_cat_01")
        RequestModel(jinx)
        for i = 1, val do
            player_jinx_army[i] = entities.create_ped(28, jinx, pos, 0)
            ENTITY.SET_ENTITY_INVINCIBLE(player_jinx_army[i], true)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(player_jinx_army[i], true)
            PED.SET_PED_COMPONENT_VARIATION(player_jinx_army[i], 0, 0, 1, 0)
            TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(player_jinx_army[i], ped, 0, -0.3, 0, 7.0, -1, 10, true)
            util.yield()
        end 
    end)

    menu.action(army_player, "清除 Jinx 宠物猫", {}, "有几只清不掉的时候你就傻了 嘿嘿\n追着你喵喵叫 嘿嘿", function()
        for i, ped in entities.get_all_peds_as_handles() do
            if PED.IS_PED_MODEL(ped, util.joaat("a_c_cat_01")) then
                entities.delete_by_handle(ped)
            end
        end
    end)

    player_toggle_loop(friendly, pid, "给予喇叭加速", {}, "无需解释,字面意思.", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        if PLAYER.IS_PLAYER_PRESSING_HORN(pid) then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        end
    end)

    local jump = menu.list(friendly, "给予车辆跳跃", {}, "让他们的任何车辆拥有跳跃能力.")
    local force = 25.00
    menu.slider_float(jump, "功率", {}, "", 0, 10000, 2500, 100, function(value)
        force = value / 100
    end)
    menu.toggle_loop(jump, "启用", {}, "按喇叭跳跃.", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        if veh ~= 0 and ENTITY.DOES_ENTITY_EXIST(veh) and PLAYER.IS_PLAYER_PRESSING_HORN(pid) then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, force/1.5, force, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
            repeat
                util.yield()
            until not PLAYER.IS_PLAYER_PRESSING_HORN(pid)
        end
    end)

    local tp 
    tp = player_toggle_loop(friendly, pid, "给予传送能力", {}, "让他/她聊天框发送 “传送” \n注意：玩家必须在车里!!!", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local veh = PED.GET_VEHICLE_PED_IS_USING(ped)

        chat.on_message(function(packet_sender, message_sender, text, team_chat)
            if string.contains(text, "传送") and PED.IS_PED_IN_VEHICLE(ped, veh, false) then  
                if players.get_name(message_sender) == players.get_name(pid) then
                    menu.trigger_commands("wptp" .. players.get_name(pid))
                end
            end
        end)
    end)

    local griefing = menu.list(bozo, "坏逼选项", {}, "你是个坏b,你不干净了。")
    local glitch_player_list = menu.list(griefing, "鬼畜玩家", {"glitchdelay"}, "")
    local object_stuff = {
        names = {
            "摩天轮",
            "UFO",
            "风车",
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
            "prop_windmill_01",
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

    local delay = 150
    menu.slider(glitch_player_list, "物体生成延迟", {"spawndelay"}, "注意：如果在stand的用户身上使用，低生成延迟可能会被标记为作弊者事件。", 0, 3000, 150, 10, function(amount)
        delay = amount
    end)

    local glitchplayer
    glitchplayer = player_toggle_loop(glitch_player_list, pid, "鬼畜玩家", {"glitchplayer"}, "被具有实体垃圾邮件保护功能的菜单所阻止.", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)

        if not ENTITY.DOES_ENTITY_EXIST(ped) then
            util.toast(players.get_name(pid) .. " 离得太远了. :/")
            glitchplayer.value = false
        util.stop_thread() end

        local glitch_hash = object_hash
        local mdl = util.joaat("rallytruck")
        RequestModel(glitch_hash)
        RequestModel(mdl)
        local obj = entities.create_object(glitch_hash, pos)
        local veh = entities.create_vehicle(mdl, pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(obj, false)
        ENTITY.SET_ENTITY_VISIBLE(veh, false)
        ENTITY.SET_ENTITY_INVINCIBLE(obj, true)
        ENTITY.SET_ENTITY_COLLISION(obj, true, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 10.0, 10.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        util.yield(delay)
        entities.delete_by_handle(obj)
        entities.delete_by_handle(veh)
    end)

    local glitchveh
    glitchveh = menu.toggle_loop(griefing, "鬼畜载具", {"glitchvehicle"}, "", function() -- credits to soul reaper for base concept
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_model = players.get_vehicle_model(pid)
        local object_hash = util.joaat("prop_ld_ferris_wheel")
        local seat_count = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(veh_model)
        RequestModel(object_hash)

        if not ENTITY.DOES_ENTITY_EXIST(ped) and PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            util.toast(players.get_name(pid) .. "太远或不在车辆中. :/")
            glitchveh.value = false
        util.stop_thread() end

        if not VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(player_veh) then
            util.toast("没有座位了. :/")
            glitchveh.value = false
        util.stop_thread() end

        local glitch_obj = entities.create_object(object_hash, pos)
        local glitched_ped = PED.CREATE_RANDOM_PED(pos)
        local things = {glitched_ped, glitch_obj}
        
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(glitch_obj)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(glitched_ped)

        ENTITY.ATTACH_ENTITY_TO_ENTITY(glitch_obj, glitched_ped, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)

        for i, spawned_objects in things do
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
        if glitched_ped ~= nil then -- added a 2nd stage here because it didnt want to delete sometimes, this solved that lol.
            entities.delete_by_handle(glitched_ped) 
        end
        if glitch_obj ~= nil then 
            entities.delete_by_handle(glitch_obj)
        end
    end)

    local glitchforcefield
    glitchforcefield = player_toggle_loop(griefing, pid, "大范围力场", {"forcefield"}, "被具有实体垃圾邮件保护功能的菜单所阻止.", function()
        local glitch_hash = util.joaat("p_spinning_anus_s")
        RequestModel(glitch_hash)

        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        pos.z += 2.5

        if not ENTITY.DOES_ENTITY_EXIST(ped) then
            util.toast(players.get_name(pid) .. " 离得太远了. :/")
            glitchforcefield.value = false
        util.stop_thread() end

        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            util.toast(players.get_name(pid) .. " 在载具中. :/")
            glitchforcefield.value = false
        util.stop_thread() end

        local obj = entities.create_object(glitch_hash, pos)
        ENTITY.SET_ENTITY_VISIBLE(obj, false)
        ENTITY.SET_ENTITY_COLLISION(obj, true, true)
        util.yield()
        entities.delete_by_handle(obj) 
    end)

    local gravity = menu.list(griefing, "重力玩家", {}, "在所有菜单上都能使用,但可以被检测到,对开启无敌的玩家失效.") -- 你好,2take1 luatards
    local force = 1.00
    menu.slider_float(gravity, "重力倍数", {"force"}, "", 0, 100, 100, 10, function(value)
        force = value / 100
    end)

    local gravitate
    gravitate = player_toggle_loop(gravity, pid, "开启重力", {"gravitate"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped)

        for _, id in interior_stuff do
            if players.is_godmode(pid) and (not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped)) and GetSpawnState(pid) ~= 0 and GetInteriorPlayerIsIn(pid) == id then
                util.toast(players.get_name(pid) .. " 玩家处于无敌模式. :/")
                gravitate.value = false
            util.stop_thread() end
        end

        FIRE.ADD_EXPLOSION(players.get_position(pid), 29, force, false, true, 0.0, true)
    end)

    menu.action(griefing, "劫持车辆", {"hijack"}, "生成一个NPC，把他从车里扔出来并开走他的车.", function() -- add personal vehicle check
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)

        if not PED.IS_PED_IN_VEHICLE(ped, vehicle, false) then
            util.toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
        return end

        local spawned_ped = PED.CREATE_RANDOM_PED(pos.x, pos.y - 10, pos.z)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(spawned_ped)
        entities.set_can_migrate(entities.handle_to_pointer(spawned_ped), false)
        ENTITY.SET_ENTITY_INVINCIBLE(spawned_ped, true)
        ENTITY.SET_ENTITY_VISIBLE(spawned_ped, false)
        ENTITY.FREEZE_ENTITY_POSITION(spawned_ped, true)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(spawned_ped, true)
        PED.CAN_PED_RAGDOLL(spawned_ped, false)
        PED.SET_PED_CONFIG_FLAG(spawned_ped, 26, true)
        TASK.TASK_ENTER_VEHICLE(spawned_ped, vehicle, 1000, -1, 1.0, 2|8|16)
        util.yield(2500)
        TASK.TASK_VEHICLE_DRIVE_WANDER(spawned_ped, vehicle, 9999.0, 6)
        util.yield(2500)
        if not PED.IS_PED_IN_ANY_VEHICLE(spawned_ped, false) then
            entities.delete_by_handle(spawned_ped)
        end
        if PED.IS_PED_IN_VEHICLE(ped, vehicle, false) then
            util.toast("未能劫持玩家的车辆. :/")
        else
            util.toast("他们的车现在成了你的财产 :D")
        end
        TASK.TASK_VEHICLE_DRIVE_WANDER(spawned_ped, vehicle, 9999.0, 6) -- setting task a 2nd time since it seems to solve any issues of the ped not wandering off.
    end)

    local hijack
    hijack = player_toggle_loop(griefing, pid, "自动劫持载具", {"autohijack"}, "会一直劫持他们试图驾驶的任何车辆.", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)

        if PED.IS_PED_IN_VEHICLE(ped, vehicle, false) then
            local spawned_ped = PED.CREATE_RANDOM_PED(pos.x, pos.y - 10, pos.z)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(spawned_ped)
            entities.set_can_migrate(entities.handle_to_pointer(spawned_ped), false)
            ENTITY.SET_ENTITY_INVINCIBLE(spawned_ped, true)
            ENTITY.SET_ENTITY_VISIBLE(spawned_ped, false)
            ENTITY.FREEZE_ENTITY_POSITION(spawned_ped, true)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(spawned_ped, true)
            PED.CAN_PED_RAGDOLL(spawned_ped, false)
            PED.SET_PED_CONFIG_FLAG(spawned_ped, 26, true)
            TASK.TASK_ENTER_VEHICLE(spawned_ped, vehicle, 1000, -1, 1.0, 2|8|16)
            util.yield(2500)
            TASK.TASK_VEHICLE_DRIVE_WANDER(spawned_ped, vehicle, 9999.0, 6) 
            util.yield(2500)
            if not PED.IS_PED_IN_ANY_VEHICLE(spawned_ped, false) then
                entities.delete_by_handle(spawned_ped)
            end
            TASK.TASK_VEHICLE_DRIVE_WANDER(spawned_ped, vehicle, 9999.0, 6)
        end
    end)
 
    menu.action(griefing, "发送至在线介绍", {"intro"}, "让玩家进入GTA在线模式的介绍.", function()
        if StandUser(pid) then util.toast(stand_notif) util.stop_thread() end
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 20, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(griefing, "发送到高尔夫俱乐部", {"golf"}, "派遣玩家去打高尔夫.", function()
        if StandUser(pid) then util.toast(stand_notif) return end
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 116, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(griefing, "恶心人的自由模式", {"brickfreemode"}, "在他们的自由模式下，他们无法看到玩家列表，无法使用他们的互动菜单，也无法看到大多数的突发事件。.", function()
        if StandUser(pid) then util.toast(stand_notif) return end
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 194, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)
    
    menu.action(griefing, "强制1V1", {"1v1"}, "迫使他们进入1V1", function()
        if StandUser(pid) then util.toast(stand_notif) return end
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 197, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(griefing, "破坏室内状态", {}, "可以通过重新加入战局来取消。玩家必须在一个公寓里。适用于大多数菜单.", function()
        if StandUser(pid) then util.toast(stand_notif) return end
        if players.is_in_interior(pid) then
            util.trigger_script_event(1 << pid, {629813291, players.user(), pid, pid, pid, math.random(int_min, int_max), pid})
        else
            util.toast(players.get_name(pid) .. " isn't in an interior. :/")
        end
    end)

    menu.action(griefing, "发射玩家", {"launch"}, "适用于大多数菜单.", function()
        local mdl = util.joaat("boxville3")
        local pos = players.get_position(pid)
        RequestModel(mdl)
                    
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            util.toast(players.get_name(pid) .. " 在载具中. :/")
        return end
        
        if TASK.IS_PED_WALKING(ped) then
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
                pos = players.get_position(pid)
            until pos.z > 10000.0
            util.yield(100)
            if boxville ~= 0 and ENTITY.DOES_ENTITY_EXIST(boxville) then 
                entities.delete_by_handle(boxville)
            end
        else
            util.toast(players.get_name(pid) .. " 必须要走路才行. :/")
        end
    end)

    menu.action(griefing,  "踢出室内", {}, "适用于大多数室内.", function() -- very innovative!
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local glitch_hash = util.joaat("prop_windmill_01")
        local mdl = util.joaat("brickade2")
        RequestModel(glitch_hash)
        RequestModel(mdl)
        for _, id in interior_stuff do
            if GetInteriorPlayerIsIn(pid) == id then
                util.toast(players.get_name(pid) .. " 不在室内. :/")
            return end
        end
        for i = 0, 5 do
            local obj = entities.create_object(glitch_hash, pos)
            local veh = entities.create_vehicle(mdl, pos, 0)
            ENTITY.SET_ENTITY_VISIBLE(obj, false)
            ENTITY.SET_ENTITY_VISIBLE(veh, false)
            ENTITY.SET_ENTITY_INVINCIBLE(veh, true)
            ENTITY.SET_ENTITY_COLLISION(obj, true, true)
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 10.0, 10.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
            util.yield(500)
            entities.delete_by_handle(obj)
            entities.delete_by_handle(veh)
            util.yield(500)     
        end
    end)
    
    local freeze = menu.list(griefing, "冻结", {}, "冻住之后想想办法干他屁眼")
    local hard_freeze
    hard_freeze = player_toggle_loop(freeze, pid, "暴力冻结", {"hardfreeze"}, "将他们和他们的镜头一起冻结，被大多数菜单阻止.", function()
        if StandUser(pid) then
            util.toast(stand_notif)
            hard_freeze.value = false
            util.stop_thread()
        end
        util.trigger_script_event(1 << pid, {330622597, players.user(), 0, 0, 0, 0, 0})
        util.yield(500)
    end)

    local blinking_freeze
    blinking_freeze = player_toggle_loop(freeze, pid, "闪现冻结", {"blinkingfreeze"}, "表现为硬冻结，但偶尔会闪现似的可以走两步。被大多数菜单挡住了.", function()
        if StandUser(pid) then
            util.toast(stand_notif)
            blinking.freeze = false
            util.stop_thread()
        end
        util.trigger_script_event(1 << pid, {-1796714618, players.user(), 0, 1, 0, 0})
        util.yield(500)
    end)

    local clear_ped_tasks
    clear_ped_tasks = player_toggle_loop(freeze, pid, "模型冻结", {}, "基本冻结方法，被大多数菜单所阻止.", function()
        if StandUser(pid) then
            util.toast(stand_notif)
            clear_ped_tasks.value = false
            util.stop_thread()
        end
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    end)
    
    menu.action(freeze, "传送冻结", {"tpfreeze"}, "将冻结玩家大约20秒，然后将他们传送进网球场.", function()
        if StandUser(pid) then util.toast(stand_notif) return end
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510)) -- Global_1894573[PLAYER::PLAYER_ID() /*608*/].f_510
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 195, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    local inf_loading = menu.list(griefing, "无限加载屏幕", {}, "")
    menu.action(inf_loading, "传送邀请", {}, lang.get_localised(-748077967), function()
        if StandUser(pid) then util.toast(stand_notif) return end
        util.trigger_script_event(1 << pid, {891653640, players.user(), 0, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(inf_loading, "公寓邀请", {}, lang.get_localised(-748077967), function()
        if StandUser(pid) then util.toast(stand_notif) return end
        util.trigger_script_event(1 << pid, {-1796714618, players.user(), 0, 1, id})
    end)
        
    menu.action_slider(inf_loading, "资产邀请", {}, "", invites, function(index, name)
        if StandUser(pid) then util.toast(stand_notif) return end
        switch name do
            case "Yacht":
                util.trigger_script_event(1 << pid, {36077543, players.user(), 1})
                util.toast("游艇邀请已发送.")
            break
            case "Office":
                util.trigger_script_event(1 << pid, {36077543, players.user(), 2})
                util.toast("办公室邀请已发送.")
            break
            case "Clubhouse":
                util.trigger_script_event(1 << pid, {36077543, players.user(), 3})
                util.toast("会所邀请已发送.")
            break
            case "Office Garage":
                util.trigger_script_event(1 << pid, {36077543, players.user(), 4})
                util.toast("办公室车库邀请已发送.")
            break
            case "Custom Auto Shop":
                util.trigger_script_event(1 << pid, {36077543, players.user(), 5})
                util.toast("载具改装铺邀请已发送.")
            break
            case "Apartment":
                util.trigger_script_event(1 << pid, {36077543, players.user(), 6})
                util.toast("公寓邀请已发送.")
            break
        end
    end)

    local blackscreen
    blackscreen = player_toggle_loop(griefing, pid, "黑屏", {"blackscreen"}, lang.get_localised(-748077967), function()
        if StandUser(pid) then
            util.toast(stand_notif)
            blackscreen.value = false
            util.stop_thread()
        end
        util.trigger_script_event(1 << pid, {891653640, players.user(), math.random(1, 32), 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        util.yield(1000)
    end)

    local cage = menu.list(griefing, "困住玩家", {}, "")
    menu.action(cage, "电击笼子", {"electriccage"}, "你确定你要当雷电法王杨永信吗?\n做个人吧!", function()
        if StandUser(pid) then util.toast(stand_notif) return end
        local number_of_cages = 6
        local elec_box = util.joaat("prop_elecbox_12")
        local pos = players.get_position(pid)
        pos.z -= 0.5
        RequestModel(elec_box)
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

    menu.action(cage, "集装箱笼子", {"containercage"}, "", function()
        if StandUser(pid) then util.toast(stand_notif) return end
        local container_hash = util.joaat("prop_container_ld_pu")
        local pos = players.get_position(pid)
        RequestModel(container_hash)
        pos.z -= 1
        local container = entities.create_object(container_hash, pos, 0)
        spawned_objects[#spawned_objects + 1] = container
        ENTITY.FREEZE_ENTITY_POSITION(container, true)
    end)

    menu.action(cage, "载具笼子", {"vehiclecage"}, "", function()
        if StandUser(pid) then util.toast(stand_notif) return end
        local container_hash = util.joaat("boxville3")
        local pos = players.get_position(pid)
        RequestModel(container_hash)
        local container = entities.create_vehicle(container_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 2.0, 0.0), ENTITY.GET_ENTITY_HEADING(ped))
        spawned_objects[#spawned_objects + 1] = container
        ENTITY.SET_ENTITY_VISIBLE(container, false)
        ENTITY.FREEZE_ENTITY_POSITION(container, true)
    end)

    menu.action(cage, "删除所有生成的笼子", {"clearcages"}, "", function()
        local entitycount = 0
        for i, object in spawned_objects do
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(object, false, false)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(object)
            entities.delete_by_handle(object)
            spawned_objects[i] = nil
            entitycount += 1
        end
        util.toast("删除了 " .. entitycount .. "个已生成的笼子.")
    end) 

    local radio = menu.list(griefing, "更换广播电台", {}, "")
    local stations = {}
    for station, name in station_name do
        stations[#stations + 1] = station
    end
    menu.list_action(radio, "电台类型", {}, "", stations, function(index, value)
        if StandUser(pid) then util.toast(lang.get_localised(1729001290)) end
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(players.user())
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped)

        if not PED.IS_PED_IN_VEHICLE(ped, vehicle, false) then
        util.toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
        return end
        local radio_name = station_name[value]
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then 

            if not VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
                util.toast("未能改变玩家的无线电台. :/")
            return end

            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
            if not PED.IS_PED_IN_VEHICLE(players.user_ped(), vehicle, false) then
                ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), false)
                menu.trigger_commands("tpveh" .. players.get_name(pid))
                util.yield(250)
                AUDIO.SET_VEH_RADIO_STATION(vehicle, radio_name)
                util.yield(750)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), pos, false, false, false)
            else
                util.yield(250)
                AUDIO.SET_VEH_RADIO_STATION(vehicle, radio_name)
            end
        end
    end)
    

    local control_veh
    control_veh = player_toggle_loop(griefing, pid, "控制玩家载具", {}, "必须在陆地上的载具才能使用该功能.", function(toggle)
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped)
        local class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
        if not players.exists(pid) then util.stop_thread() end

        if not ENTITY.DOES_ENTITY_EXIST(ped) and PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            util.toast(players.get_name(pid) .. " 离得太远了. :/")
            control_veh.value = false
        util.stop_thread() end

        if class == 15 then
            util.toast(players.get_name(pid) .. " 在直升机上. :/")
            control_veh.value = false
        util.stop_thread() end
        
        if class == 16 then
            util.toast(players.get_name(pid) .. " 在飞机上. :/")
            control_veh.value = false
        util.stop_thread() end

        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), true)
            if PAD.IS_CONTROL_PRESSED(0, 34) then
                while not PAD.IS_CONTROL_RELEASED(0, 34) do
                    TASK.TASK_VEHICLE_TEMP_ACTION(ped, PED.GET_VEHICLE_PED_IS_IN(ped), 7, 500)
                    util.yield()
                end
            elseif PAD.IS_CONTROL_PRESSED(0, 35) then
                while not PAD.IS_CONTROL_RELEASED(0, 35) do
                    TASK.TASK_VEHICLE_TEMP_ACTION(ped, PED.GET_VEHICLE_PED_IS_IN(ped), 8, 500)
                    util.yield()
                end
            elseif PAD.IS_CONTROL_PRESSED(0, 32) then
                while not PAD.IS_CONTROL_RELEASED(0, 32) do
                    TASK.TASK_VEHICLE_TEMP_ACTION(ped, PED.GET_VEHICLE_PED_IS_IN(ped), 23, 500)
                    util.yield()
                end
            elseif PAD.IS_CONTROL_PRESSED(0, 33) then
                while not PAD.IS_CONTROL_RELEASED(0, 33) do
                    TASK.TASK_VEHICLE_TEMP_ACTION(ped, PED.GET_VEHICLE_PED_IS_IN(ped), 28, 500)
                    util.yield()
                end
            end
        else
            util.toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
            control_veh.value = false
        end
        util.yield()
    end, function()
        ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
    end)

    local jesus_tgl = false
    local jesus_ped
    menu.toggle(griefing, "悲伤的耶稣", {""}, "召唤耶稣攻击TA.", function(toggled)
        if toggled then
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local pos = players.get_position(pid)
            local jesus = util.joaat("u_m_m_jesus_01")
            RequestModel(jesus)
    
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
            TASK.TASK_COMBAT_PED(jesus_ped, ped, 0, 16)
            
            while toggled do
                if PED.IS_PED_DEAD_OR_DYING(ped) then
                    repeat
                        util.yield()
                    until not PED.IS_PED_DEAD_OR_DYING(ped)
                    local new_pos = players.get_position(pid)
                    new_pos.y += 2
                    new_pos.z += 1 -- 耶稣出于某种原因会被卡住，做这个是为了防止这种情况发生。.
                    util.yield(2500)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(jesus_ped, new_pos, false, false, false)
                    WEAPON.REFILL_AMMO_INSTANTLY(jesus_ped)
                    TASK.TASK_COMBAT_PED(jesus_ped, ped, 0, 16)
                end
                util.yield()
            end
        end
        if jesus_ped ~= nil then
            entities.delete_by_handle(jesus_ped)
        end
    end)

    menu.action(griefing, "杀死室内玩家", {}, "这崽种不在公寓里则没法使用\n你可以尝试用公寓邀请给他拉到一个公寓\n再来试试这个功能", function()
        local pos = players.get_position(pid)

        for _, id in interior_stuff do
            if GetInteriorPlayerIsIn(pid) == id then
                util.toast(players.get_name(pid) .. " 这崽种不在家!. :/")
            return end
            if GetInteriorPlayerIsIn(pid) ~= id then
                util.trigger_script_event(1 << pid, {-1428749433, players.user(), 448051697, math.random(0, 9999)})
                util.yield(100)
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 1000, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
            end
        end
    end)

    player_toggle_loop(griefing, pid, "电死这个杂种", {tase}, "来自雷电法王杨永信的电疗\n拯救网瘾少年的任务就交给你了", function()
        local pos = players.get_position(pid)
        for i = 1, 50 do
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 0, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
        end
        util.yield()
    end)

    local antigodmode = menu.list(bozo, "反制无敌玩家", {}, "")
    local stun = menu.list(antigodmode, "眩晕选项", {}, "经测试，对开启实体防护的无敌玩家起很大作用\n对无敌玩家的恶搞效果很好")
    menu.action(stun, "实名眩晕", {"ownedstun"}, "", function()
        local pos = players.get_position(pid)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 1000, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
    end)

    menu.action(stun, "匿名眩晕", {"anonstun"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 1000, true, util.joaat("weapon_stungun"), false, false, true, 1.0)
    end)
    
    menu.action(antigodmode, "杀死无敌玩家", {"squish"}, "压死它们，直到它们死去。适用于大多数菜单。\n(注意：如果目标正在使用无布娃娃，则不会起作用).", function()
        if StandUser(pid) then util.toast(stand_notif) return end
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local heading =  ENTITY.GET_ENTITY_HEADING(ped)
        local khanjali = util.joaat("khanjali")
        RequestModel(khanjali)
        distance = 2.5
        if TASK.IS_PED_STILL(ped) then
            distance = 0.0
        end

        local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, distance, 2.8), heading)
        local vehicle2 = entities.create_vehicle(khanjali, pos, 0)
        local vehicle3 = entities.create_vehicle(khanjali, pos, 0)
        local vehicle4 = entities.create_vehicle(khanjali, pos, 0)
        local spawned_vehs = {vehicle1, vehicle2, vehicle3, vehicle4}
        for _, vehicle in spawned_vehs do
            local id = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(vehicle)
            NETWORK.SET_NETWORK_ID_CAN_MIGRATE(id, false)
        end
        ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0.0, 0.0, 3.0, 0.0, 0.0, 0.0, -180.0, 0, false, true, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0.0, 3.0, 3.0, 0.0, 0.0, 0.0, -180.0, 0, false, true, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0.0, 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, false, true, false, 0, true)
        ENTITY.SET_ENTITY_VISIBLE(vehicle1, false)
        util.yield(5000)
        for _, vehicle in spawned_vehs do
            entities.delete_by_handle(vehicle)
        end
    end) 
    menu.action(antigodmode, "死亡屏障击杀", {"barrierkill"}, "对大多数菜单有效。(注意：只有在目标没有使用禁用死亡障碍的情况下才会起作用。)", function()
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
    local remove_gm
    remove_gm = player_toggle_loop(antigodmode, pid, "移除玩家无敌", {}, lang.get_localised(-748077967), function()
        if StandUser(pid) then
            util.toast(stand_notif)
            remove_gm.value = false
            util.stop_thread()
        end
        util.trigger_script_event(1 << pid, {-1428749433, players.user(), 448051697, math.random(0, 9999)})
    end)

    local remove_veh_gm
    remove_veh_gm = player_toggle_loop(antigodmode, pid, "移除载具无敌", {}, lang.get_localised(-748077967), function()
        if StandUser(pid) then
            util.toast(stand_notif)
            remove_veh_gm.value = false
            util.stop_thread()
        end
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) and not PED.IS_PED_DEAD_OR_DYING(ped) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
            ENTITY.SET_ENTITY_CAN_BE_DAMAGED(veh, true)
            ENTITY.SET_ENTITY_INVINCIBLE(veh, false)
            ENTITY.SET_ENTITY_PROOFS(veh, false, false, false, false, false, 0, 0, false)
        end
    end)

    local tp_player = menu.list(bozo, "传送玩家到...")
    local clubhouse = menu.list(tp_player, "摩托帮会所", {}, "")
    local facility = menu.list(tp_player, "设施", {}, "")
    local arcade = menu.list(tp_player, "游戏厅", {}, "")
    local warehouse = menu.list(tp_player, "仓库", {}, "")
    local cayoperico = menu.list(tp_player, "佩里科岛", {}, "")
    local interiors = menu.list(tp_player, "室内") -- thx to aaron for sending me the labels and their numbers for most of the interiors <3

    for id, name in All_business_properties do
        if id <= 12 then
            menu.action(clubhouse, name, {}, "", function()
                if StandUser(pid) then util.toast(stand_notif) return end
                util.trigger_script_event(1 << pid, {891653640, players.user(), id, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, math.random(1, 10)})
            end)
        elseif id > 12 and id <= 21 then
            menu.action(facility, name, {}, "", function()
                if StandUser(pid) then util.toast(stand_notif) return end
                util.trigger_script_event(1 << pid, {891653640, players.user(), id, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
            end)
        elseif id > 21 then
            menu.action(arcade, name, {}, "", function() 
                if StandUser(pid) then util.toast(stand_notif) return end
                util.trigger_script_event(1 << pid, {891653640, players.user(), id, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1})
            end)
        end
    end

    local small = menu.list(warehouse, "小型仓库", {}, "")
    local medium = menu.list(warehouse, "中型仓库", {}, "")
    local large = menu.list(warehouse, "大型仓库", {}, "")

    for id, name in small_warehouses do
        menu.action(small, name, {}, "", function()
            if StandUser(pid) then util.toast(stand_notif) return end
            util.trigger_script_event(1 << pid, {-1796714618, players.user(), 0, 1, id})
        end)
    end

    for id, name in medium_warehouses do
        menu.action(medium, name, {}, "", function()
            if StandUser(pid) then util.toast(stand_notif) return end
            util.trigger_script_event(1 << pid, {-1796714618, players.user(), 0, 1, id})
        end)
    end

    for id, name in large_warehouses do
        menu.action(large, name, {}, "", function()
            if StandUser(pid) then util.toast(stand_notif) return end
            util.trigger_script_event(1 << pid, {-1796714618, players.user(), 0, 1, id})
        end)
    end

    menu.action(tp_player, "公寓抢劫事件传送", {}, lang.get_localised(-748077967), function()
        if StandUser(pid) then util.toast(stand_notif) util.stop_thread() end
        util.trigger_script_event(1 << pid, {-702866045, players.user(), pid, -1, 1, 1, 0, 1, 0}) 
    end) 
    
    menu.action(cayoperico, "佩里科岛", {"tpcayo"}, lang.get_localised(-748077967), function()
        if StandUser(pid) then util.toast(stand_notif) util.stop_thread() end
        util.trigger_script_event(1 << pid, {330622597, players.user(), 0, 0, 3, 1})
    end)

    menu.action(cayoperico, "佩里科岛 v2", {"tpcayo2"}, lang.get_localised(-748077967), function()
        if StandUser(pid) then util.toast(stand_notif) util.stop_thread() end
        util.trigger_script_event(1 << pid, {-369672308, players.user(), 1})
    end)

    menu.action(cayoperico, "佩里科岛(无过场动画)", {"tpcayo2"}, lang.get_localised(-748077967), function()
        if StandUser(pid) then util.toast(stand_notif) util.stop_thread() end
        util.trigger_script_event(1 << pid, {330622597, players.user(), 0, 0, 4, 1})
    end)

    menu.action(cayoperico, "离开佩里科岛", {"cayoleave"}, "Blocked by most menus. Player must be at cayo perico to trigger this.", function()
        if StandUser(pid) then util.toast(stand_notif) util.stop_thread() end
        util.trigger_script_event(1 << pid, {330622597, players.user(), 0, 0, 3})
    end)

    menu.action(cayoperico, "从佩里科岛被踢出", {"cayokick"}, lang.get_localised(-748077967), function()
        if StandUser(pid) then util.toast(stand_notif) util.stop_thread() end
        util.trigger_script_event(1 << pid, {330622597, players.user(), 0, 0, 4, 0})
    end)

    local interior_tps = {
        [70] = "地堡", -- 70 到 80 都是地堡
        [81] = "机动作战中心",
        [83] = "机库", -- 83 到 87 都是机库
        [88] = "复仇者",
        [89] = "设施", -- 89 到 97 都是设施
        [102] = "夜总会车库",-- 102 到 111 都是夜总会车库
        [117] = "恐霸",
        [122] = "竞技场工作室",
        [123] = "名钻赌场",
        [124] = "顶层公寓",
        [128] = "游戏厅车库", -- 128 到 133 都是游戏厅车库
        [146] = "夜总会",
        [147] = "虎鲸",
        [149] = "改装铺", -- 149 到 153 都是改装铺
        [155] = "事务所",
    }

    for id, name in interior_tps do
        menu.action(interiors, name, {""}, lang.get_localised(-748077967), function()
            if StandUser(pid) then util.toast(stand_notif) return end
            util.trigger_script_event(1 << pid, {1727896103, players.user(), id, 1, 0, 1, 1130429716, -1001012850, 1106067788, 0, 0, 1, 2123789977, 1, -1})
        end)
    end

    local spectate_root = menu.ref_by_rel_path(menu.player_root(pid), "Spectate")
    local spectate = menu.list(spectate_root, "观看设置")
    if menu.get_edition() > 1 then
        local esp_tgl
        esp_tgl = menu.toggle(spectate, "启用透视", {""}, "", function(toggled)
            local nuts = menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method")
            local legit = menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Legit Method")
            if toggled then
                if nuts.value == false or legit.value == false then
                    util.toast("请打开观看功能. :/")
                    esp_tgl.value = false
                util.stop_thread() end
                menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Low Latency Rendering"))
                menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Name ESP>Name ESP>Low Latency Rendering"))
                menu.trigger_commands("esptags off")
            else
                menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Disabled"))
                menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Name ESP>Name ESP>Disabled"))
            end
        end)
    end

    player_toggle_loop(spectate, pid, "时间周期清理", {}, "当从室内观看其他人时，将自动把时间周期设置为默认值，这样从设施等地方观看他们就不会看起来很糟糕.", function()
        if GRAPHICS.GET_TIMECYCLE_MODIFIER_INDEX() ~= -1 or GetInteriorPlayerIsIn(players.user()) ~= 0 then
            GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
        end
    end)

    local misc = menu.list(bozo, "杂项")
    player_toggle_loop(misc, pid, "显示自瞄线", {"aimlines"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local weapon_ent = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(ped, false)
        local weapon_coords = ENTITY.GET_ENTITY_BONE_POSTION(weapon_ent, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(weapon_ent, "gun_muzzle"))
        local inst = v3.new()
        v3.set(inst, players.get_cam_rot(pid))
        local tmp = v3.toDir(inst)
        v3.set(inst, v3.get(tmp))
        v3.mul(inst, 1000)
        v3.set(tmp, players.get_cam_pos(pid))
        v3.add(inst, tmp)
        GRAPHICS.DRAW_LINE(weapon_coords, inst, 255, 255, 255, 255)
    end)

    local aimbor
    aimbor = player_toggle_loop(misc, pid, "玩家自动扳机", {"triggerbot"}, "瞄准玩家开启自动射击", function()
        if pid == players.user() then 
            util.toast(lang.get_localised(-1974706693)) 
            aimbor.value = false
        util.stop_thread() end
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local wpn = WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped())
        local dmg = SYSTEM.ROUND(WEAPON.GET_WEAPON_DAMAGE(wpn, 0))
        local delay = WEAPON.GET_WEAPON_TIME_BETWEEN_SHOTS(wpn)
        local wpnEnt = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), false)
        local wpnCoords = ENTITY.GET_ENTITY_BONE_POSTION(wpnEnt, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(wpnEnt, "gun_muzzle"))
        if ENTITY.GET_ENTITY_ALPHA(ped) < 255 then return end
        if PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(players.user(), ped) and not PED.IS_PED_RELOADING(players.user_ped()) then
            boneIndex = bones[math.random(#bones)]
            local pos = PED.GET_PED_BONE_COORDS(ped, boneIndex, 0.0, 0.0, 0.0)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(wpnCoords, pos, dmg, true, wpn, players.user_ped(), true, false)
            PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 24, 1.0) -- shooting manually after so it has the effect of you shooting to seem more legit despite there being nothing legit about this
            util.yield(delay * 1000)
        end
    end)
end

players.on_join(player)
players.dispatch_on_join()
menu.toggle_loop(self, "解锁 50 车位车库", {}, "", function()
    if memory.read_byte(memory.script_global(262145 + 32688)) ~= 0 then -- Global_262145.f_32688
        memory.write_byte(memory.script_global(262145 + 32688), 0) 
    return end

    if memory.read_byte(memory.script_global(262145 + 32702)) ~= 1 then -- Global_262145.f_32702
        memory.write_byte(memory.script_global(262145 + 32702), 1)  
    end
end)

menu.toggle_loop(self, "快速重生", {"fastrespawn"}, "", function()
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

local roll_speed = nil
menu.list_select(self, "战斗翻滚速度", {}, "", {"默认", "1.25x", "1.5x", "1.75x", "2x"}, 1, function(index, value)
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
menu.list_select(self, "攀爬速度", {}, "", {"默认", "1.25x", "1.5x", "2x",}, 1, function(index, value)
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

menu.toggle_loop(self, "武装玩家", {"ghostarmedplayers"}, "对手持武器的玩家启用幽灵模式.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if WEAPON.IS_PED_ARMED(ped, 7) or TASK.GET_IS_TASK_ACTIVE(ped, 199) or TASK.GET_IS_TASK_ACTIVE(ped, 128) 
        or IsPlayerUsingGuidedMissile(pid) or IsPlayerInRcTank(pid) or IsPlayerInRcBandito(pid) or IsPlayerFlyingAnyDrone(pid) then
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, true)
        else
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
        end
    end
end, function()
    for _, pid in players.list(false, true, true) do
        NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
    end
end)

local orb = menu.list(self, "反天基炮")
local ghost = menu.list(orb, "幽灵模式")
local ghost_tgl
ghost_tgl = menu.toggle_loop(ghost, "幽灵模式", {"ghostorb"}, "自动对使用天基炮的玩家开启幽灵模式.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local cam_dist = v3.distance(players.get_position(players.user()), players.get_cam_pos(pid))
        if IsPlayerUsingOrbitalCannon(pid) and TASK.GET_IS_TASK_ACTIVE(ped, 135) and cam_dist < 400 and cam_dist > 340 then
            util.toast(players.get_name(pid) .. " 天基炮正在瞄准你")
        end
        if IsPlayerUsingOrbitalCannon(pid) then
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, true)
            repeat
                util.yield()
            until not IsPlayerUsingOrbitalCannon(pid)
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
        end
    end
end, function()
    for _, pid in players.list(false, true, true) do
        NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
    end
end)

local tgl
tgl = menu.toggle_loop(ghost, "被锁定时", {}, "自动将用天基炮瞄准你的玩家变成幽灵模式.", function()
    if menu.get_value(ghost_tgl) then
        tgl.value = false
    return end
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local cam_dist = v3.distance(players.get_position(players.user()), players.get_cam_pos(pid))
        if IsPlayerUsingOrbitalCannon(pid) and TASK.GET_IS_TASK_ACTIVE(ped, 135) and cam_dist < 400 and cam_dist > 340 then
            util.toast(players.get_name(pid) .. " 正在用天基炮瞄准你")
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, true)
        else
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
        end
    end
end, function()
    for _, pid in players.list(false, true, true) do
        NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
    end
end)


local annoy = menu.list(orb, "防御模式", {}, "快速显示你的名字并将其从使用天基炮的玩家的选择列表中删除.")
local orb_delay = 1000
menu.list_select(annoy, "延迟", {}, "对于使用天基炮玩家来说,你的名字会以何种速度闪动.", {"慢速", "中速", "快速"}, 1, function(index, value)
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

local spoof_tgl
spoof_tgl = menu.toggle_loop(orb, "位置欺骗", {"spooforb"}, "如果有人用天基炮瞄准你，会自动欺骗你的位置", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local cam_dist = v3.distance(players.get_position(players.user()), players.get_cam_pos(pid))
        if players.exists(pid) then
            outgoingSyncs = menu.ref_by_rel_path(menu.player_root(pid), "Outgoing Syncs>Block")
            if IsPlayerUsingOrbitalCannon(pid) and TASK.GET_IS_TASK_ACTIVE(ped, 135) and cam_dist < 400 and cam_dist > 340 then
                util.toast(players.get_name(pid) .. " 正在用天基炮瞄准你")
                menu.trigger_commands("spoofedposition 3115.2983, -2431.3594, 2690")
                spoofing.value = true
                util.yield(500)
                repeat
                    outgoingSyncs.value = true
                    spoofing.value = false
                    util.yield()
                until not IsPlayerUsingOrbitalCannon(pid)
                outgoingSyncs.value = false
            end
        end
    end
end, function()
    menu.trigger_commands("spoofpos off")
    outgoingSyncs.value = false
end)

local annoy_tgl
annoy_tgl = menu.toggle_loop(annoy, "启用", {}, "", function()
    if menu.get_value(ghost_tgl) then
        annoy_tgl.value = false
        util.toast("请不要同时启用防御模式和幽灵模式 ;)")
    return end
    
    for _, pid in players.list(false, true, true) do
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
    for _, pid in players.list(false, true, true) do
        NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
    end
end)

menu.toggle_loop(self, "友好的 AI", {""}, "AI 将不会瞄准你.", function()
    PED.SET_PED_RESET_FLAG(players.user_ped(), 124, true)
end)

menu.toggle_loop(self, "自动接受并加入游戏", {}, "将自动接受游戏邀请.", function() -- 感谢 Soul Reaper 告诉我这个 :D
    local message_hash = HUD.GET_WARNING_SCREEN_MESSAGE_HASH()
    if message_hash == 15890625 or message_hash == -587688989 then
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1.0)
        util.yield(50)
    end
end)

local proofsList = menu.list(self, "无懈可击", {}, "你可以理解为无敌！")
local immortalityCmd = menu.ref_by_path("Self>Immortality")
for _,data in proofs do
    menu.toggle(proofsList, data.name, {data.name:lower().."proof"}, "使你在以下情况下无懈可击 "..data.name:lower()..".", function(toggle)
        data.on = toggle
    end)
end
util.create_tick_handler(function()
    local local_player = players.user_ped()
    if not menu.get_value(immortalityCmd) then
        ENTITY.SET_ENTITY_PROOFS(local_player, proofs.bullet.on, proofs.fire.on, proofs.explosion.on, proofs.collision.on, proofs.melee.on, proofs.steam.on, false, proofs.drown.on)
    end
end)

menu.action(lobby, "劫持所有载具", {"hijackall"}, "生成一个劫匪NPC，把他们从车里带出来并开走开.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)

        if ENTITY.DOES_ENTITY_EXIST(ped) and PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            menu.trigger_commands("hijack " .. players.get_name(pid))
        end
    end
end)

menu.divider(recovery, "致幻剂实验室管理")
menu.click_slider(recovery, "产品容量", {"productcapacity"}, "", 0, 1000, 160, 1, function(capacity)
    memory.write_int(memory.script_global(262145 + 18949), capacity) 
end)

menu.toggle(recovery, "免费供应", {"supplycost"}, "", function()
    memory.write_int(memory.script_global(262145 + 21869), 0)
end, function()
    memory.write_int(memory.script_global(262145 + 21869), 60000)
end)

menu.toggle(recovery, "提高生产效率", {"increaseproductionspeed"}, "", function()
    memory.write_int(memory.script_global(262145 + 17396), 100) 
end, function()
    memory.write_int(memory.script_global(262145 + 17396), 135000) 
end)

menu.action(recovery, "重新补给致幻剂", {"resupplyacid"}, "", function()
    local time = NETWORK.GET_CLOUD_TIME_AS_INT() - memory.read_int(memory.script_global(262145 + 18954))
    memory.write_int(memory.script_global(1648637 + 1 + 6), time)
end)

menu.toggle_loop(missions, "跳过达克斯冷却", {}, "移除跳过达克斯工作的冷却时间", function() -- 感谢 Icedoomfist 告诉我这个状态名 <3
    STATS.STAT_SET_INT(util.joaat("MP"..util.get_char_slot().."_XM22JUGGALOWORKCDTIMER"), -1, true)
end)

menu.toggle_loop(missions, "禁用阻止实体轰炸", {}, "将在任务中自动禁用阻止实体轰炸,防止任务卡关.", function()
    local EntitySpam = menu.ref_by_path("Online>Protections>Block Entity Spam>Block Entity Spam")
    if NETWORK.NETWORK_IS_ACTIVITY_SESSION() == true then
        if not menu.get_value(EntitySpam) then return end
        menu.trigger_command(EntitySpam, "off")
    else
        if menu.get_value(EntitySpam) then return end
        menu.trigger_command(EntitySpam, "on")
    end
end)

menu.action(missions, "清理敌人", {}, "", function()
    local counter = 0
    for _, ped in entities.get_all_peds_as_handles() do
        if HUD.GET_BLIP_COLOUR(HUD.GET_BLIP_FROM_ENTITY(ped)) == 1 or TASK.GET_IS_TASK_ACTIVE(ped, 352) then -- shitty way to go about it but hey, it works (most of the time).
            ENTITY.SET_ENTITY_HEALTH(ped, 0)
            counter += 1
            util.yield()
        end
    end
    if counter == 0 then
        util.toast("没有发现敌人. :/")
    else
        util.toast("已清理 ".. tostring(counter) .." 个敌人.")
    end
end)

menu.action(missions, "将拾取物传送到自己", {}, "", function()
    local counter = 0
    local pos = players.get_position(players.user())
    for _, pickup in entities.get_all_pickups_as_handles() do
        ENTITY.SET_ENTITY_COORDS(pickup, pos, false, false, false, false)
        counter += 1
        util.yield()
    end
    if counter == 0 then
        util.toast("没有发现可捡拾物. :/")
    else
        util.toast("已传送 ".. tostring(counter) .." 个拾取物.")
    end
end)

menu.toggle_loop(weapons, "自动扳机", {"triggerbotall"}, "翻译者理解为自动扳机，瞄到人自动开枪应该是", function()
    local wpn = WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped())
    local dmg = SYSTEM.ROUND(WEAPON.GET_WEAPON_DAMAGE(wpn, 0))
    local delay = WEAPON.GET_WEAPON_TIME_BETWEEN_SHOTS(wpn)
    local wpnEnt = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), false)
    local wpnCoords = ENTITY.GET_ENTITY_BONE_POSTION(wpnEnt, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(wpnEnt, "gun_muzzle"))
    for _, pid in players.list(false, true, true) do
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

local modifier = 1.00
menu.slider_float(weapons, "近战伤害修改", {"meleedamage"}, "", 100, 1000, 100, 10, function(value)
    modifier = value / 100
    PLAYER.SET_PLAYER_MELEE_WEAPON_DAMAGE_MODIFIER(players.user(), modifier)
end)

menu.toggle_loop(weapons, "最大自瞄范围", {}, "手柄的辅助瞄准功能开启后,将有无限的范围.", function()
    PLAYER.SET_PLAYER_LOCKON_RANGE_OVERRIDE(players.user(), 99999999.0)
end)

local weapon_thing = menu.list(weapons, "弹药类型", {}, "改变你的枪射出的子弹.")
for id, data in weapon_stuff do
    local name = data[1]
    local weapon_name = data[2]
    local a = false
    menu.toggle(weapon_thing, name, {}, "", function(toggle)
        a = toggle
        while a do
            local weapon = util.joaat(weapon_name)
            projectile = weapon
            while not WEAPON.HAS_WEAPON_ASSET_LOADED(projectile) do
                WEAPON.REQUEST_WEAPON_ASSET(projectile, 31, false)
                util.yield(10)
            end
            local inst = v3.new()
            PLAYER.DISABLE_PLAYER_FIRING(players.user(), true) -- credits for wiri for these 2 lines (It looks much better with shooting disabled)
            if PAD.IS_DISABLED_CONTROL_PRESSED(0, 24) then
                if not WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), memory.addrof(inst)) then
                    v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
                    local tmp = v3.toDir(inst)
                    v3.set(inst, v3.get(tmp))
                    v3.mul(inst, 1000)
                    v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
                    v3.add(inst, tmp)
                end
                local x, y, z = v3.get(inst)
                local wpEnt = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), false)
                local wpCoords = ENTITY.GET_ENTITY_BONE_POSTION(wpEnt, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(wpEnt, "gun_muzzle"))
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(wpCoords.x, wpCoords.y, wpCoords.z, x, y, z, 1, true, weapon, PLAYER.PLAYER_PED_ID(), true, false, 1000.0)
            end
            util.yield()
        end
        local pos = players.get_position(players.user())
        MISC.CLEAR_AREA_OF_PROJECTILES(pos, 999999.0, 0)
    end)
end

menu.toggle_loop(weapons, "快速更换武器", {"fasthands"}, "更快地更换你的武器.", function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 56) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)


menu.toggle_loop(weapons, "锁定玩家", {}, "允许您使用武装载具上的制导导弹发射器锁定玩家.", function()
    for _, pid in players.list(true, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        PLAYER.ADD_PLAYER_TARGETABLE_ENTITY(players.user(), ped)
        ENTITY.SET_ENTITY_IS_TARGET_PRIORITY(ped, false, 400.0)    
    end
end, function()
    for _, pid in players.list(true, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        PLAYER.REMOVE_PLAYER_TARGETABLE_ENTITY(players.user(), ped)
    end
end)

if menu.get_edition() > 1 then
    menu.toggle_loop(weapons, "瞄准时的透视", {"aimesp"}, "", function()
        if PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
            menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Low Latency Rendering"))
        else
            menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Disabled"))
        end
    end, function()
        menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Disabled"))
    end)
end

local veh_jump = menu.list(vehicles, "载具跳跃")
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

local deformation = 1.00
menu.slider_float(vehicles, "载具变形", {"deformation"}, "", 0, 10000, 100, 100, function(value)
    deformation = value / 100
    menu.trigger_commands("vhdeformationmult " .. deformation)
end)

local seat_id = -1
local moved_seat = menu.click_slider(vehicles, "更换载具座位", {}, "", 1, 1, 1, 1, function(seat_id)
    TASK.TASK_WARP_PED_INTO_VEHICLE(players.user_ped(), entities.get_user_vehicle_as_handle(), seat_id - 2)
end)

menu.on_tick_in_viewport(moved_seat, function()
    if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
        moved_seat.max_value = 0
    return end
    
    moved_seat.max_value = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(entities.get_user_vehicle_as_handle()))
end)

menu.toggle_loop(vehicles, "快速热启动", {""}, "", function()
    if not VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(entities.get_user_vehicle_as_handle()) and TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 150) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

menu.toggle_loop(vehicles, "快速上下车", {"fastvehcleenter"}, "更快地进入载具.", function()
    if (TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 160) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 167) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 165)) and not TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 195) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

menu.toggle_loop(vehicles, "在下车时关闭无敌模式", {""}, "", function()
    if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(entities.get_user_vehicle_as_handle()) then
        if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
            ENTITY.SET_ENTITY_CAN_BE_DAMAGED(PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true), true)
        end
    end
end)

menu.toggle_loop(vehicles, "绕过防锁定", {}, "绕过锁定限制.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            VEHICLE.SET_VEHICLE_ALLOW_HOMING_MISSLE_LOCKON_SYNCED(veh, true)
        end
    end
end)

menu.toggle_loop(vehicles, "粘在地上", {""}, "", function()
    local vehicle = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
    local velocity = ENTITY.GET_ENTITY_VELOCITY(vehicle)
    local height = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(vehicle)
    local controls = {32, 33, 34, 35}
    if height < 5.0 then
        if ENTITY.IS_ENTITY_IN_AIR(vehicle) then
            VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(vehicle)
        end
    else
        for _, key in controls do
            if vehicle ~= 0 and PAD.IS_CONTROL_PRESSED(0, key) then
                while not PAD.IS_CONTROL_RELEASED(0, key) and ENTITY.IS_ENTITY_IN_AIR(vehicle) do
                    ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 2, 0.0, 0.0, -500 - velocity.z, 0, 0, 0, 0, true, false, true, false, true)
                    util.yield()
                end
            end
        end
    end
end)

menu.toggle_loop(vehicles, "自转", {"spinbot"}, "让载具转起来.", function()
    local vehicle = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
    local velocity = ENTITY.GET_ENTITY_VELOCITY(vehicle)
    local height = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(vehicle)
    if height < 5.0 and height > 0.1 then
        VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(vehicle)
    end
    if vehicle ~= 0 and not PED.IS_PED_DEAD_OR_DYING(players.user_ped()) and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
        ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 5, 0.0, 0.0, 150.0, 0, 0, 0, 0, true, false, true, false, true)
    end
end)

menu.action(funfeatures, "飞天扫帚", {""}, "注意:您将对其他玩家不可见.", function()
    local pos = players.get_position(players.user())
    local broomstick = util.joaat("prop_tool_broom")
    local oppressor = util.joaat("oppressor2")
    RequestModel(broomstick)
    RequestModel(oppressor)
    obj = entities.create_object(broomstick, pos)
    veh = entities.create_vehicle(oppressor, pos, 0)
    ENTITY.SET_ENTITY_VISIBLE(veh, false, false)
    PED.SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, 0, 0, 0.3, -80.0, 0, 0, true, false, false, false, 0, true) -- thanks to chaos mod for doing the annoying rotation work for me :P
end)

local headlamp = menu.list(funfeatures, "头灯", {}, "别人看不到的本地娱乐功能.")
local distance = 25.0
menu.slider_float(headlamp, "距离", {"distance"}, "光照距离.", 100, 10000, 1500, 100, function(value)
    distance = value / 100
end)

local brightness = 10.0
menu.slider_float(headlamp, "亮度", {"brightness"}, "光亮强度.", 100, 10000, 1000, 100, function(value)
    brightness = value / 100
end)

local radius = 15.0
menu.slider_float(headlamp, "半径", {"radius"}, "光束半径.", 100, 5000, 2000, 100, function(value)
    radius = value / 100
end)

local color = {r = 1, g = 235/255, b = 190/255, a = 0}
menu.colour(headlamp, "颜色", {"colour"}, "", color, true, function(value)
    color = value 
end)

menu.toggle_loop(headlamp, "开启", {"headlamp"}, "", function()
    local head_pos = PED.GET_PED_BONE_COORDS(players.user_ped(), 31086, 0.0, 0.0, 0.0)
    local cam_rot = players.get_cam_rot(players.user())
    GRAPHICS.DRAW_SPOT_LIGHT(head_pos, cam_rot:toDir(), math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255), distance * 1.5, brightness, 0.0, radius, distance)
end)

menu.toggle(funfeatures, "停电", {"poweroutage"}, "", function(toggled)
    GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(toggled)
end)

menu.toggle(funfeatures, "停电 2", {"blackout"}, "", function(toggled)
    menu.trigger_commands("time 1")
    GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(toggled)
    if toggled then
        GRAPHICS.SET_TIMECYCLE_MODIFIER("dlc_island_vault")
    else
        GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
    end
end)

local obj
menu.toggle(funfeatures, "力场", {}, "在你的脚上附着一个UFO,破坏路上的任何东西.", function(toggled)
    local mdl = util.joaat("p_spinning_anus_s")
    local pos = players.get_position(players.user())
    RequestModel(mdl)
    if toggled then
        obj = entities.create_object(mdl, pos)
        ENTITY.SET_ENTITY_VISIBLE(obj, false)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, players.user_ped(), 0, 0, 0, 0, 0, 0, 0, false, false, true, false, 0, false, 0)
    else
        if obj ~= nil then 
            entities.delete_by_handle(obj)
        end
    end
end)

local jesus_main = menu.list(funfeatures, "自动驾驶", {}, "使用前请先设置一个导航点.")
local style = 786603
menu.slider_text(jesus_main, "驾驶风格", {}, "点击以切换风格.", style_names, function(index, value)
    style = value
end)

local speed = 20.00
menu.slider_float(jesus_main, "驾驶速度", {""}, "调整自动驾驶的速度", 0, 10000, 2000, 100, function(value)
    speed = value / 100
end)

local toggled = false
local jesus_toggle
jesus_toggle = menu.toggle(jesus_main, "启用", {}, "", function(toggle)
    toggled = toggle
    local pos = players.get_position(players.user())
    local vehicle = entities.get_user_vehicle_as_handle()
    jesus = util.joaat("u_m_m_jesus_01")
    RequestModel(jesus)

    if toggled then
        if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then 
			util.toast(lang.get_localised(-474174214))
            menu.set_value(jesus_toggle, false)
        util.stop_thread() end
        
        jesus_ped = entities.create_ped(26, jesus, pos, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(jesus_ped, true)
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -2)
        PED.SET_PED_INTO_VEHICLE(jesus_ped, vehicle, -1)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(jesus_ped, true)
        PED.SET_PED_KEEP_TASK(jesus_ped, true)

        if HUD.IS_WAYPOINT_ACTIVE() then
            local waypoint = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
            TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(jesus_ped, vehicle, waypoint, speed, style, 0.0)
        else
            TASK.TASK_VEHICLE_DRIVE_WANDER(jesus_ped, vehicle, 20.0, 786603)
            util.toast("请先设置一个导航点. :)")
        end
        util.yield()
    else
        if jesus_ped ~= nil then 
            entities.delete_by_handle(jesus_ped)
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -1)
        end
    end
    
    while toggled do
        local height = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(vehicle)
        local upright_value = ENTITY.GET_ENTITY_UPRIGHT_VALUE(vehicle)
        if height < 5.0 and upright_value < 0.0 then
            VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(vehicle)
        end
        util.yield()
    end
end)

menu.toggle(funfeatures, "特斯拉自动驾驶", {}, "嘎嘎出事故\n整死你!!!!", function(toggled)
    local pos = players.get_position(players.user())
    local tesla_ai = util.joaat("u_m_y_baygor")
    local tesla = util.joaat("raiden")
    RequestModel(tesla_ai)
    RequestModel(tesla)
    if toggled then     
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            menu.trigger_commands("deletevehicle")
        end

        tesla_ai_ped = entities.create_ped(26, tesla_ai, pos, 0)
        tesla_vehicle = entities.create_vehicle(tesla, pos, 0)

        ENTITY.SET_ENTITY_INVINCIBLE(tesla_ai_ped, true) 
        ENTITY.SET_ENTITY_VISIBLE(tesla_ai_ped, false)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(tesla_ai_ped, true)
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), tesla_vehicle, -2)
        PED.SET_PED_INTO_VEHICLE(tesla_ai_ped, tesla_vehicle, -1)
        PED.SET_PED_CONFIG_FLAG(tesla_ai_ped, 26, true)
        PED.SET_PED_KEEP_TASK(tesla_ai_ped, true)

        VEHICLE.SET_VEHICLE_COLOURS(tesla_vehicle, 111, 111)
        VEHICLE.SET_VEHICLE_MOD(tesla_vehicle, 23, 8, false)
        VEHICLE.SET_VEHICLE_MOD(tesla_vehicle, 15, 1, false)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(tesla_vehicle, 111, 147)
        menu.trigger_commands("performance")

        if HUD.IS_WAYPOINT_ACTIVE() then
            local waypoint = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
            TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(tesla_ai_ped, tesla_vehicle, waypoint, 20.0, 786603, 0)
        else
            TASK.TASK_VEHICLE_DRIVE_WANDER(tesla_ai_ped, tesla_vehicle, 20.0, 786603)
        end
        util.yield()
    else
        if tesla_ai_ped ~= nil then 
            entities.delete_by_handle(tesla_ai_ped)
        end
        if tesla_vehicle ~= nil then 
            entities.delete_by_handle(tesla_vehicle)
        end
    end
end)

for index, data in interiors do
    local location_name = data[1]
    local location_coords = data[2]
    menu.action(teleport, location_name, {}, "", function()
        menu.trigger_commands("doors on")
        menu.trigger_commands("nodeathbarriers on")
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), location_coords.x, location_coords.y, location_coords.z, false, false, false)
    end)
end

local finger_thing = menu.list(funfeatures, "手指枪 [B键]", {}, "向你所指的方向发射子弹.")
for id, data in weapon_stuff do
    local name = data[1]
    local weapon_name = data[2]
    local projectile = util.joaat(weapon_name)
    while not WEAPON.HAS_WEAPON_ASSET_LOADED(projectile) do
        WEAPON.REQUEST_WEAPON_ASSET(projectile, 31, false)
        util.yield(10)
    end
    menu.toggle(finger_thing, name, {}, "", function(state)
        toggled = state
        while toggled do
            if memory.read_int(memory.script_global(4521801 + 930)) == 3 then
                memory.write_int(memory.script_global(4521801 + 935), NETWORK.GET_NETWORK_TIME())
                local inst = v3.new()
                v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
                local tmp = v3.toDir(inst)
                v3.set(inst, v3.get(tmp))
                v3.mul(inst, 1000)
                v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
                v3.add(inst, tmp)
                local x, y, z = v3.get(inst)
                local fingerPos = PED.GET_PED_BONE_COORDS(players.user_ped(), 4089, 1.0, 0, 0)
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(fingerPos, x, y, z, 1, true, projectile, 0, true, false, 500.0, players.user_ped(), 0)
            end
            util.yield(100)
        end
        local pos = players.get_position(players.user())
        MISC.CLEAR_AREA_OF_PROJECTILES(pos, 999999.0, 0)
    end)
end

local jinx_pet
jinx_toggle = menu.toggle_loop(funfeatures, "宠物猫 Jinx", {}, "招一只可爱的小猫咪\n跟着你喵喵叫\n好可爱我好喜欢!", function()
    if not jinx_pet or not ENTITY.DOES_ENTITY_EXIST(jinx_pet) then
        local jinx = util.joaat("a_c_cat_01")
        RequestModel(jinx)
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
local army = menu.list(funfeatures, "宠物猫 Jinx 军队", {}, "哈哈哈,招一堆傻猫\n叫的你头疼,甩都甩不掉")
menu.click_slider(army, "生成数量", {}, "选吧,多生成点,最多256只", 1, 256, 30, 1, function(val)
    local pos = players.get_position(players.user())
    pos.y = pos.y - 5
    pos.z = pos.z + 1
    local jinx = util.joaat("a_c_cat_01")
    RequestModel(jinx)
     for i = 1, val do
        jinx_army[i] = entities.create_ped(28, jinx, pos, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(jinx_army[i], true)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(jinx_army[i], true)
        PED.SET_PED_COMPONENT_VARIATION(jinx_army[i], 0, 0, 1, 0)
        TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(jinx_army[i], ped, 0, -0.3, 0, 7.0, -1, 10, true)
        util.yield()
     end 
end)

menu.action(army, "清除宠物猫 Jinx", {}, "把这烦人的傻猫都给他们清了", function()
    for i, ped in entities.get_all_peds_as_handles() do
        if PED.IS_PED_MODEL(ped, util.joaat("a_c_cat_01")) then
            entities.delete_by_handle(ped)
        end
    end
end)

menu.action(funfeatures, "找到 Jinx", {}, "\n将Jinx猫传送到你身边\n老叫傻猫来干嘛?\n", function()
    local pos = players.get_position(players.user())
    if jinx_pet ~= nil then 
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(jinx_pet, pos, false, false, false)
    else
        util.toast("找不到你那只傻猫了. :/")
    end
end)


menu.toggle_loop(modder_detections, "无敌模式", {}, "检测战局玩家是否在使用无敌.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for _, id in interior_stuff do
            if players.is_godmode(pid) and not players.is_in_interior(pid) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and GetSpawnState(pid) == 99 and GetInteriorPlayerIsIn(pid) == id then
                util.draw_debug_text(players.get_name(pid) .. " 是无敌模式")
                break
            end
        end
    end 
end)

menu.toggle_loop(modder_detections, "载具无敌模式", {}, "检测玩家载具是否在使用无敌.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            for _, id in interior_stuff do
                if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(vehicle) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) 
                and GetSpawnState(pid) == 99 and GetInteriorPlayerIsIn(pid) == id and pid == driver then
                    util.draw_debug_text(players.get_name(driver) ..  " 是无敌模式的载具")
                    break
                end
            end
        end
    end 
end)

menu.toggle_loop(modder_detections, "未发布的载具", {}, "检测是否有玩家在驾驶尚未发布的载具.", function()
    for _, pid in players.list(false, true, true) do
        local modelHash = players.get_vehicle_model(pid)
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        for i, name in unreleased_vehicles do
            if modelHash == util.joaat(name) and PED.IS_PED_IN_ANY_VEHICLE(ped, false) and pid == driver then
                util.draw_debug_text(players.get_name(driver) .. " 正在驾驶未发布载具 " .. "(" .. name .. ")")
            end
        end
    end
end)

menu.toggle_loop(modder_detections, "作弊武器", {}, "检测是否有玩家使用无法获得的武器.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for i, hash in modded_weapons do
            local weapon_hash = util.joaat(hash)
            if WEAPON.HAS_PED_GOT_WEAPON(ped, weapon_hash, false) and (WEAPON.IS_PED_ARMED(ped, 7) or TASK.GET_IS_TASK_ACTIVE(ped, 8) or TASK.GET_IS_TASK_ACTIVE(ped, 9)) then
                util.draw_debug_text(players.get_name(pid) .. " 正在使用作弊武器 " .. "(" .. hash .. ")")
                break
            end
        end
    end
end)

menu.toggle_loop(modder_detections, "作弊载具", {}, "检测是否有玩家正在使用无法获得的载具.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local modelHash = players.get_vehicle_model(pid)
        local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        for i, name in modded_vehicles do
            if modelHash == util.joaat(name) and pid == driver then
                util.draw_debug_text(players.get_name(driver) .. " 正在驾驶作弊载具 " .. "(" .. name .. ")")
                break
            end
        end
    end
end)

menu.toggle_loop(modder_detections, "自由镜头检测", {}, "检测是否有玩家使用自由镜头(又称无碰撞)", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local ped_ptr = entities.handle_to_pointer(ped)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local oldpos = players.get_position(pid)
        util.yield()
        local currentpos = players.get_position(pid)
        local vel = ENTITY.GET_ENTITY_VELOCITY(ped)
        if not util.is_session_transition_active() and players.exists(pid)
        and GetInteriorPlayerIsIn(pid) == 0 and GetSpawnState(pid) ~= 0
        and not PED.IS_PED_IN_ANY_VEHICLE(ped, false) -- too many false positives occured when players where driving. so fuck them. lol.
        and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped)
        and not PED.IS_PED_CLIMBING(ped) and not PED.IS_PED_VAULTING(ped) and not PED.IS_PED_USING_SCENARIO(ped)
        and not TASK.GET_IS_TASK_ACTIVE(ped, 160) and not TASK.GET_IS_TASK_ACTIVE(ped, 2)
        and v3.distance(players.get_position(players.user()), players.get_position(pid)) <= 395.0 -- 400 was causing false positives
        and ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(ped) > 5.0 and not ENTITY.IS_ENTITY_IN_AIR(ped) and entities.player_info_get_game_state(ped_ptr) == 0
        and oldpos.x ~= currentpos.x and oldpos.y ~= currentpos.y and oldpos.z ~= currentpos.z 
        and vel.x == 0.0 and vel.y == 0.0 and vel.z == 0.0 then
            util.toast(players.get_name(pid) .. " 是无碰撞")
            break
        end
    end
end)

menu.toggle_loop(modder_detections, "超级驾驶检测", {}, "检测是否有玩家在修改载具速度", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_speed = (ENTITY.GET_ENTITY_SPEED(vehicle)* 2.236936)
        local class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
        local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        if class ~= 15 and class ~= 16 and veh_speed >= 200 and (players.get_vehicle_model(pid) ~= util.joaat("oppressor") and players.get_vehicle_model(pid) ~= util.joaat("oppressor2")) and pid == driver then
            util.toast(players.get_name(driver) .. " 正在使用超级驾驶")
            break
        end
    end
end)

menu.toggle_loop(modder_detections, "观看检测", {}, "检测是否有玩家在观看你.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if not PED.IS_PED_DEAD_OR_DYING(ped) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) then
            if v3.distance(players.get_position(players.user()), players.get_cam_pos(pid)) < 20.0 and v3.distance(players.get_position(players.user()), players.get_position(pid)) > 50.0 then
                util.toast(players.get_name(pid) .. " 正在观看你")
                break
            end
        end
    end
end)

menu.toggle_loop(modder_detections, "雷霆加入检测", {}, "检测是否有玩家使用了雷霆加入.", function()
    for _, pid in players.list(false, true, true) do
        if GetSpawnState(players.user()) == 0 then return end
        local old_sh = players.get_script_host()
        util.yield(100)
        local new_sh = players.get_script_host()
        if old_sh ~= new_sh then
            if GetSpawnState(pid) == 0 and players.get_script_host() == pid then
                util.toast(players.get_name(pid) .. " 触发了雷霆加入检测，现在被归类为作弊者")
                break
            end
        end
    end
end)

menu.toggle_loop(modder_detections, "修改后的天基炮", {}, "检测是否有人在使用修改过的天基炮.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if IsPlayerUsingOrbitalCannon(pid) and not TASK.GET_IS_TASK_ACTIVE(ped, 135) and GetSpawnState(pid) ~= 0 then
            util.toast(players.get_name(pid) .. " 正在使用修改过的天基炮")
            break
        end
    end
end)

menu.toggle_loop(modder_detections, "生成载具", {}, "检测是否有人在驾驶生成的车辆.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        if players.get_name(pid) ~= "InvalidPlayer" and players.get_vehicle_model(pid) ~= 0 then
            if DECORATOR.DECOR_GET_INT(vehicle, "MPBitset") == 8 or DECORATOR.DECOR_GET_INT(vehicle, "MPBitset") == 1024 and PED.IS_PED_IN_ANY_VEHICLE(ped, false) and GetSpawnState(players.user()) ~= 0 then 
                util.draw_debug_text(players.get_name(driver) .. " 正在驾驶生成载具 " .. "(模型: " .. util.reverse_joaat(players.get_vehicle_model(pid)) .. ")")
                break
            end
        end
    end 
end)

menu.toggle_loop(normal_detections, "传送检测", {}, "检测一个玩家传送了多远。(注意：他们传送并不意味着他们是用作弊软件，也可能是任务导致)", function()
    for _, pid in players.list(false, true, true) do
        local old_pos = players.get_position(pid)
        util.yield(50)
        local cur_pos = players.get_position(pid)
        local distance_between_tp = v3.distance(old_pos, cur_pos)
        for _, id in interior_stuff do
            if GetInteriorPlayerIsIn(pid) == id and GetSpawnState(pid) ~= 0  and players.exists(pid) then
                util.yield(100)
                if distance_between_tp > 300.0 then
                    util.toast(players.get_name(pid) .. " 传送到 " .. SYSTEM.ROUND(distance_between_tp) .. " 米")
                    break
                end
            end
        end
    end
end)

menu.toggle_loop(normal_detections, "天基炮", {}, "检测是否有人在使用天基炮.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if IsPlayerUsingOrbitalCannon(pid) and TASK.GET_IS_TASK_ACTIVE(ped, 135) then
            util.draw_debug_text(players.get_name(pid) .. " 是在轨道炮处")
        end
    end
end)

menu.toggle_loop(normal_detections, "狗屎无敌模式检测", {}, "检测是否有人通过触发某种突发事件来获得无敌模式.\n这是一个哪怕绿玩也可以卡出来的垃圾无敌", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local height = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(ped)
        for _, id in interior_stuff do
            if players.is_in_interior(pid) and players.is_godmode(pid) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and GetSpawnState(pid) == 99 and GetInteriorPlayerIsIn(pid) == id and height >= 0.0 then
                util.draw_debug_text(players.get_name(pid) .. " 是狗屎无敌模式")
                break
            end
        end
    end 
end)

menu.toggle_loop(protections, "野兽防护", {}, "防止你被变成野兽,但也会阻止其他人的战局事件.", function()
    if util.spoof_script("am_hunt_the_beast", SCRIPT.TERMINATE_THIS_THREAD) then
        util.toast("检测到《 猎杀野兽 》事件生成。已终止事件...")
    end
end)

local anticage = menu.list(protections, "防止笼子", {}, "")
local alpha = 88
menu.slider(anticage, "透明度", {"transparency"}, "调整笼子的透明度.", 1, #values, 2, 1, function(amount)
    alpha = values[amount]
end)

local radius = 10.00
menu.slider_float(anticage,  "阻止半径", {"radius"}, "选择检测笼子，阻止的范围。.", 100, 2500, 1000, 100, function(value)
    radius = value/100
end)

local cleanup = false
menu.toggle(anticage, "自动清理", {"cleanup"}, "自动删除任何生成的笼子.", function(toggled)
    cleanup = toggled
end)

menu.toggle_loop(anticage, "启用防止笼子", {"anticage"}, "", function()
    local user = players.user_ped()
    local veh = PED.GET_VEHICLE_PED_IS_USING(user)
    local my_ents = {user, veh}
    for i, obj_ptr in entities.get_all_objects_as_pointers() do
        local net_obj = memory.read_long(obj_ptr + 0xd0)
        if net_obj == 0 or memory.read_byte(net_obj + 0x49) == players.user() then
            continue
        end
        local obj_handle = entities.pointer_to_handle(obj_ptr)
        local owner = entities.get_owner(obj_ptr)
        local id = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(obj_handle)
        CAM.SET_GAMEPLAY_CAM_IGNORE_ENTITY_COLLISION_THIS_UPDATE(obj_handle)
        for _, door in doors do
            if entities.get_model_hash(obj_ptr) ~= util.joaat(door) then
                continue
            end
        end
        for i, data in my_ents do
            if v3.distance(players.get_position(players.user()), ENTITY.GET_ENTITY_COORDS(obj_handle)) <= radius then
                if data ~= 0 and alpha >= 1 then
                    ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(obj_handle, data, false)  
                    ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(data, obj_handle, false)
                    ENTITY.SET_ENTITY_ALPHA(obj_handle, alpha, false)
                end
                if data ~= 0 and cleanup then
                    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(id, true)
                    ENTITY.SET_ENTITY_ALPHA(obj_handle, 0, false)
                    entities.delete_by_handle(obj_handle)
                end
                if data ~= 0 and ENTITY.IS_ENTITY_TOUCHING_ENTITY(data, obj_handle) then
                    util.toast("已阻止笼子，来自 " .. players.get_name(owner))
                end
            end
        end
        SHAPETEST.RELEASE_SCRIPT_GUID_FROM_ENTITY(obj_handle)
    end
end)

local anti_mugger = menu.list(protections, "拦截劫匪")
menu.toggle_loop(anti_mugger, "自己", {}, "防止你被抢劫.", function() -- thx nowiry for improving my method :D
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

menu.toggle_loop(protections, "阻止交易错误脚本", {}, "阻止其他人利用销毁车辆方式的脚本，让你出现交易错误。", function()
    if util.spoof_script("am_destroy_veh", SCRIPT.TERMINATE_THIS_THREAD) then
        util.toast("Destroy Vehicle script detected. Terminating script...")
    end
end)

local block_orb
block_orb = menu.toggle_loop(protections,  "阻止天基炮", {"blockorb"}, "生成一个阻挡天基炮房的道具", function() -- credit to lance, just cleaned it up a bit.
    local mdl = util.joaat("h4_prop_h4_garage_door_01a")
    RequestModel(mdl)
    if orb_obj == nil or not ENTITY.DOES_ENTITY_EXIST(orb_obj) then
        orb_obj = entities.create_object(mdl, v3(335.9, 4833.9, -59.0))
        local obj_id = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(orb_obj)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(obj_id, false)
        ENTITY.SET_ENTITY_HEADING(orb_obj, 125.0)
        ENTITY.FREEZE_ENTITY_POSITION(orb_obj, true)
        ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(players.user_ped(), orb_obj, false)
    end
    util.yield(50)
end, function()
    if orb_obj ~= nil then
        entities.delete_by_handle(orb_obj)
    end
end)

local block_spec_syncs
block_spec_syncs = menu.toggle_loop(protections, "阻止观看同步", {}, "阻止所有观看你的人的同步.", function()
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

local spoof = menu.list(protections, "欺骗观看同步")
local x = 0.00
menu.slider_float(spoof, "X (横向)", {"spoofedx"}, "", 0, 1000000, 0, 1, function(x_pos)
    x = x_pos
end)

local y = 0.00
menu.slider_float(spoof, "Y (纵向)", {"spoofedy"}, "", 0, 1000000, 0, 1, function(y_pos)
    y = y_pos
end)

local z = 0.00
menu.slider_float(spoof, "Z (高度)", {"spoofedz"}, "", 0, 1000000, 0, 1, function(z_pos)
    z = z_pos
end)

local spoof_spec_syncs
spoof_spec_syncs = menu.toggle_loop(spoof, "开启欺骗观看", {"spoofspectatorsyncs"}, "创建一个位置，用于欺骗观看你的作弊者，这样观看你的人就会看到你在别的地方。(注意：其他人也会在你欺骗的位置看到你)", function()
    if block_spec_syncs.value == true then
        util.toast("请不要同时启用欺骗同步和阻止观看同步. ;)") 
        block_spec_syncs.value = false
        util.stop_thread()
    end
    menu.trigger_commands("spoofedposition " .. x .. "," .. y .. "," .. z)
    for _, pid in players.list(false, true, true) do
        local ped_dist = v3.distance(players.get_position(players.user()), players.get_position(pid))
        if v3.distance(players.get_position(players.user()), players.get_cam_pos(pid)) < 25.0 and ped_dist > 30.0 or players.get_spectate_target(pid) == players.user() then
            outgoingSyncs = menu.ref_by_rel_path(menu.player_root(pid), "Outgoing Syncs>Block")
            spoofing.value = true
            util.yield(500)
            repeat
                outgoingSyncs.value = true
                spoofing.value = false
                util.yield()
            until v3.distance(v3(x, y, z), players.get_cam_pos(pid)) > 50.0
            outgoingSyncs.value = false
        end
        
    end
end, function()
    spoofing.value = false
end)

menu.list_action(protections, "全部清理!", {}, "\n可清理周边一切\n其他玩家的个人载具除外.\n适用于掉帧卡顿时按一下\n小概率出现自崩\n", {"NPC", "载具", "物体", "可拾取物体", "绳索", "投掷物", "声音"}, function(index, name)
    util.toast("正在清理 "..name:lower().."...")
    local counter = 0
    switch index do
        case 1:
            for _, ped in entities.get_all_peds_as_handles() do
                if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) then
                    entities.delete_by_handle(ped)
                    counter += 1
                    util.yield()
                end
            end
            break
        case 2:
            for _, vehicle in entities.get_all_vehicles_as_handles() do
                if vehicle ~= PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) and DECORATOR.DECOR_GET_INT(vehicle, "Player_Vehicle") == 0 and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
                    entities.delete_by_handle(vehicle)
                    counter += 1
                end
                util.yield()
            end
            break
        case 3:
            for _, object in entities.get_all_objects_as_handles() do
                entities.delete_by_handle(object)
                counter += 1
                util.yield()
            end
            break
        case 4:
            for _, pickup in entities.get_all_pickups_as_handles() do
                entities.delete_by_handle(pickup)
                counter += 1
                util.yield()
            end
            break
        case 5:
            local coords = players.get_position(players.user())
            MISC.CLEAR_AREA_OF_PROJECTILES(coords.x, coords.y, coords.z, 1000.0, 0)
            counter = "所有"
            break
        case 6:
            for i = 0, 99 do
                AUDIO.STOP_SOUND(i)
                util.yield()
            end
        break
    end
    util.toast("已清除 "..tostring(counter).." "..name:lower()..".")
end)

menu.action(protections, "清除区域", {"cleanse"}, "", function()
    local cleanse_entitycount = 0
    for _, ped in entities.get_all_peds_as_handles() do
        if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) then
            entities.delete_by_handle(ped)
            cleanse_entitycount += 1
            util.yield()
        end
    end
    util.toast("已清除 " .. cleanse_entitycount .. " Peds")
    cleanse_entitycount = 0
    for _, vehicle in entities.get_all_vehicles_as_handles() do
        if vehicle ~= PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) and DECORATOR.DECOR_GET_INT(vehicle, "Player_Vehicle") == 0 and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            entities.delete_by_handle(vehicle)
            cleanse_entitycount += 1
            util.yield()
        end
    end
    util.toast("已清除 ".. cleanse_entitycount .." 载具")
    cleanse_entitycount = 0
    for _, object in entities.get_all_objects_as_handles() do
        entities.delete_by_handle(object)
        cleanse_entitycount += 1
        util.yield()
    end
    util.toast("已清除 " .. cleanse_entitycount .. " 物体")
    cleanse_entitycount = 0
    for _, pickup in entities.get_all_pickups_as_handles() do
        entities.delete_by_handle(pickup)
        cleanse_entitycount += 1
        util.yield()
    end
    util.toast("已清除 " .. cleanse_entitycount .. " 可拾取物体")
    local pos = players.get_position(players.user())
    MISC.CLEAR_AREA_OF_PROJECTILES(pos, 400.0, 0)
    util.toast("清除了所有投掷物")
end)

menu.hyperlink(misc, "Jinx 脚本中文交流群", "https://jq.qq.com/?_wv=1027&k=Mh1p1Aty")
menu.hyperlink(menu.my_root(), "加入官方 Discord", "https://discord.gg/hjs5S93kQv")
local credits = menu.list(misc, "鸣谢", {}, "")
local jinx = menu.list(credits, "Jinx", {}, "")
menu.hyperlink(jinx, "Tiktok", "https://www.tiktok.com/@bigfootjinx")
menu.hyperlink(jinx, "Twitter", "https://twitter.com/bigfootjinx")
menu.hyperlink(jinx, "Instagram", "https://www.instagram.com/bigfootjinx")
menu.hyperlink(jinx, "Youtube", "https://www.youtube.com/channel/UC-nkxad5MRDuyz7xstc-wHQ?sub_confirmation=1")
menu.action(credits, "ICYPhoenix", {}, "如果他没有将我的名字改为 OP Jinx Lua,我将永远不会想过制作这个脚本", function()
end)
menu.action(credits, "Sapphire", {}, "当我第一次启动 Lua 以及开始学习 Stand API 和 natives 时,他处理了我所有的困难而且帮助了很多人.", function()
end)
menu.action(credits, "aaronlink127", {}, "帮助处理数学问题,还帮助处理自动更新程序和其他一些功能.", function()
end)
menu.action(credits, "Ren", {}, "提出合理建议.", function()
end)
menu.action(credits, "well in that case", {}, "用于制作 Pluto 并让我的部分代码运行起来更好更流畅.", function()
end)
menu.action(credits, "jerry123", {}, "告诉我代码可以改进的地方.", function()
end)
menu.action(credits, "Scriptcat", {}, "从我制作这个脚本开始就陪着我,告诉我一些有用的 Lua 技巧,并教导我学习 Stand API 和 natives.", function()
end)
menu.action(credits, "ERR_NET_ARRAY", {}, "帮助编辑.", function()
end)
menu.action(credits, "d6b.", {}, "给我赠送 Discord Nitro.  ", function()
end)

local translator = menu.list(credits, "翻译人员", {}, "translator")
menu.action(translator, "lu_zi / 鹿子", {}, "中文区翻译.", function()
end)
menu.action(translator, "BLackMist / 臣服", {}, "中文区翻译.", function()
end)

util.keep_running()
