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

local function setBit(addr: number, bit: number)
	memory.write_int(addr, memory.read_int(addr) | 1 << bit)
end
local function clearBit(addr: number, bit: number)
	memory.write_int(addr, memory.read_int(addr) ~ 1 << bit)
end

local function StandUser(pid) -- credit to sapphire for this
    if players.exists(pid) and pid ~= players.user() then
        for menu.player_root(pid):getChildren() as cmd do
            if cmd:getType() == COMMAND_LIST_CUSTOM_SPECIAL_MEANING and (cmd:refByRelPath("Stand User"):isValid() or cmd:refByRelPath("Stand User (Co-Loading"):isValid()) then
                return true
            end
        end
    end
    return false
end

local function GetOffsetFromPlayerCamera(player, distance)
    local pos = players.get_cam_pos(player)
    local direction = players.get_cam_rot(player):toDir()
    direction:mul(distance)
    pos:add(direction)
    return pos
end

local stand_notif = "My brother in christ, what are you doing?! This will not work on a fellow stand user."

local function RequestModel(hash, timeout)
    timeout = timeout or 3
    STREAMING.REQUEST_MODEL(hash)
    local end_time = os.time() + timeout
    repeat
        util.yield()
    until STREAMING.HAS_MODEL_LOADED(hash) or os.time() >= end_time
    return STREAMING.HAS_MODEL_LOADED(hash)
end

local function setEntityAsNoLongerNeeded(entity: int)
    local m = memory.alloc_int()
    m:writeInt(entity)
    ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(m)
end

local attack_weapons = {
    584646201,
    961495388,
    317205821,
    324215364,
    911657153,
    1119849093,
    1834241177,
    2138347493,
    1672152130,
    -608341376,
    -86904375,
    -1075685676,
    -1466123874,
    -1355376991,
    -1312131151,
    -581044007,
    -538741184,
    -102973651,
}

local All_business_properties = {
    -- Clubhouses
    "罗伊洛文斯坦大道1334号",
    "佩罗海滩7号",
    "艾尔金大街75号",
    "68号公路101号",
    "佩立托湾1号",
    "阿尔冈琴大道47号",
    "资本大道137号",
    "柯林顿大街2214号",
    "霍伊克大街1778号",
    "东乔舒亚路2111号",
    "佩立托湾68号",
    "戈马街4号",
    -- Facilities
    "塞诺拉大沙漠",
    "68号公路",
    "沙滩海岸",
    "戈多山",
    "佩立托湾",
    "桑库多湖",
    "桑库多河",
    "荣恩风力发电场",
    "兰艾水库",
    -- Arcades
    "像素彼得-佩立托湾",
    "奇迹神所-葡萄籽",
    "仓库-戴维斯",
    "八位-好麦坞",
    "请投币-罗克福德山",
    "游戏末日-梅萨",
}

local small_warehouses = {
    [1] = "太平洋鱼饵仓储", 
    [2] = "白寡妇车库", 
    [3] = "赛尔托瓦单元", 
    [4] = "便利店车库", 
    [5] = "法拍车库", 
    [9] = "码头400号工作仓库", 
}

local medium_warehouses = {
    [7] = "翘臀内衣外景场地", 
    [10] = "GEE仓库", 
    [11] = "洛圣都海事大厦3号楼", 
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
    {"轨道炮", "weapon_railgun"},
    {"红色雷射", "vehicle_weapon_enemy_laser"},
    {"绿色雷射", "vehicle_weapon_player_laser"},
    {"天煞机炮", "vehicle_weapon_player_lazer"},
    {"火箭炮", "weapon_rpg"},
    {"制导火箭炮", "weapon_hominglauncher"},
    {"脉冲发射器", "weapon_emplauncher"},
    {"信号枪", "weapon_flaregun"},
    {"霰弹枪", "weapon_bullpupshotgun"},
    {"电击枪", "weapon_stungun"},
    {"烟雾枪", "weapon_smokegrenade"},
}

local proofs = {
    bullet = {name="子弹",on=false},
    fire = {name="着火",on=false},
    explosion = {name="爆炸",on=false},
    collision = {name="碰撞",on=false},
    melee = {name="近战",on=false},
    steam = {name="蒸汽",on=false},
    drown = {name="溺水",on=false},
}

local modded_weapons = {
    "weapon_railgun",
    "weapon_stungun",
    "weapon_digiscanner",
}

local veh_things = {
    "brickade2",
    "hauler",
    "hauler2",
    "manchez3",
    "terbyte",
    "minitank",
    "rcbandito"
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

local object_stuff = {
    names = {
        "汉堡",
        "飞碟",
        "摩天轮",
        "风车",
        "水泥搅拌器",
        "脚手架",
        "车库门",
        "大保龄球",
        "大足球",
        "大橙球",
        "特技坡道",

    },
    objects = {
        "xs_prop_hamburgher_wl",
        "p_spinning_anus_s",
        "prop_ld_ferris_wheel",
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

local interiors = {
    {"安全空间[挂机房]", {x=-158.71494, y=-982.75885, z=149.13135}},
    {"酷刑室", {x=147.170, y=-2201.804, z=4.688}},
    {"采矿隧道", {x=-595.48505, y=2086.4502, z=131.38136}},
    {"欧米茄车库", {x=2330.2573, y=2572.3005, z=46.679367}},
    {"50载具车库", {x=520.0, y=-2625.0, z=-50.0}},
    {"服务器群", {x=2474.0847, y=-332.58887, z=92.9927}},
    {"角色创建", {x=402.91586, y=-998.5701, z=-99.004074}},
    {"生命侵略者大楼", {x=-1082.8595, y=-254.774, z=37.763317}},
    {"竞速结束动画的车库", {x=405.9228, y=-954.1149, z=-99.6627}},
    {"被摧毁的医院", {x=304.03894, y=-590.3037, z=43.291893}},
    {"竞技场内部", {x=-256.92334, y=-2024.9717, z=30.145584}},
    {"喜剧俱乐部", {x=-430.00974, y=261.3437, z=83.00648}},
    {"录音A工作室", {x=-1010.6883, y=-49.127754, z=-99.40313}},
    {"不夜城", {x=-1394.8816, y=-599.7526, z=30.319544}},
    {"赌场看门人的房子", {x=-110.20285, y=-8.6156025, z=70.51957}},
    {"心理医生的房子", {x=-1913.8342, y=-574.5799, z=11.435149}},
    {"杜根的房子", {x=1395.2512, y=1141.6833, z=114.63437}},
    {"弗洛伊德的公寓", {x=-1156.5099, y=-1519.0894, z=10.632717}},
    {"麦克的房子", {x=-813.8814, y=179.07889, z=72.15914}},
    {"小富的房子(旧)", {x=-14.239959, y=-1439.6913, z=31.101551}},
    {"小富的房子(新)", {x=7.3125067, y=537.3615, z=176.02803}},
    {"老崔的房车", {x=1974.1617, y=3819.032, z=33.436287}},
    {"莱斯特的房子", {x=1273.898, y=-1719.304, z=54.771}},
    {"莱斯特的纺织厂", {x=713.5684, y=-963.64795, z=30.39534}},
    {"莱斯特的事务室", {x=707.2138, y=-965.5549, z=30.412853}},
    {"冰毒实验室", {x=1391.773, y=3608.716, z=38.942}},
    {"致幻剂实验室", {x=484.69, y=-2625.36, z=-49.0}},
    {"停尸房实验室", {x=495.0, y=-2560.0, z=-50.0}},
    {"人道实验室", {x=3625.743, y=3743.653, z=28.69009}},
    {"汽车旅馆", {x=152.2605, y=-1004.471, z=-99.024}},
    {"警察局", {x=443.4068, y=-983.256, z=30.689589}},
    {"银行金库", {x=263.39627, y=214.39891, z=101.68336}},
    {"布莱恩县银行", {x=-109.77874, y=6464.8945, z=31.626724}}, -- credit to fluidware for telling me about this one
    {"龙舌兰酒吧", {x=-564.4645, y=275.5777, z=83.074585}},
    {"废弃修理厂", {x=485.46396, y=-1315.0614, z=29.2141}},
    {"失落摩托帮", {x=980.8098, y=-101.96038, z=74.84504}},
    {"万杰利科珠宝店", {x=-629.9367, y=-236.41296, z=38.057056}},
    {"航空站休息室", {x=-913.8656, y=-2527.106, z=36.331566}},
    {"停尸房", {x=240.94368, y=-1379.0645, z=33.74177}},
    {"联合储蓄", {x=1.298771, y=-700.96967, z=16.131021}},
    {"桑库多堡垒瞭望塔", {x=-2357.9187, y=3249.689, z=101.45073}},
    {"事务所大楼", {x=-1118.0181, y=-77.93254, z=-98.99977}},
    {"事务所车库", {x=-1071.0494, y=-71.898506, z=-94.59982}},
    {"恐霸内部", {x=-1421.015, y=-3012.587, z=-80.000}},
    {"地堡内部", {x=899.5518,y=-3246.038, z=-98.04907}},
    {"IAA事务室", {x=128.20, y=-617.39, z=206.04}},
    {"FIB顶楼", {x=135.94359, y=-749.4102, z=258.152}},
    {"FIB47楼", {x=134.5835, y=-766.486, z=234.152}},
    {"FIB49楼", {x=134.635, y=-765.831, z=242.152}},
    {"肥鸡机顶", {x=-31.007448, y=6317.047, z=40.04039}},
    {"脱衣舞俱乐部DJ位", {x=121.398254, y=-1281.0024, z=29.480522}},
}

local station_name = {
    ["Blaine County Radio"] = "RADIO_11_TALK_02", 
    ["The Blue Ark"] = "RADIO_12_REGGAE",
    ["Worldwide FM"] = "RADIO_13_JAZZ",
    ["FlyLo FM"] = "RADIO_14_DANCE_02",
    ["The Lowdown 9.11"] = "RADIO_15_MOTOWN",
    ["The Lab"] = "RADIO_20_THELAB",
    ["Radio Mirror Park"] = "RADIO_16_SILVERLAKE",
    ["Space 103.2"] = "RADIO_17_FUNK",
    ["Vinewood Boulevard Radio"] = "RADIO_18_90S_ROCK",
    ["Blonded Los Santos 97.8 FM"] = "RADIO_21_DLC_XM17",
    ["Los Santos Underground Radio"] = "RADIO_22_DLC_BATTLE_MIX1_RADIO",
    ["iFruit Radio"] = "RADIO_23_DLC_XM19_RADIO",
    ["Motomami Lost Santos"] = "RADIO_19_USER",
    ["Los Santos Rock Radio"] = "RADIO_01_CLASS_ROCK",
    ["Non-Stop-Pop FM"] = "RADIO_02_POP",
    ["Radio Los Santos"] = "RADIO_03_HIPHOP_NEW",
    ["Channel X"] = "RADIO_04_PUNK",
    ["West Coast Talk Radio"] = "RADIO_05_TALK_01",
    ["Rebel Radio"] = "RADIO_06_COUNTRY", 
    ["Soulwax FM"] = "RADIO_07_DANCE_01",
    ["East Los FM"] = "RADIO_08_MEXICAN",
    ["West Coast Classics"] = "RADIO_09_HIPHOP_OLD",
    ["Media Player"] = "RADIO_36_AUDIOPLAYER",
    ["The Music Locker"] = "RADIO_35_DLC_HEI4_MLR",
    ["Kult FM"] = "RADIO_34_DLC_HEI4_KULT",
    ["Still Slipping Los Santos"] = "RADIO_27_DLC_PRHEI4",
}
local values = {
    [1] = 50,
    [2] = 88,
    [3] = 160,
    [4] = 208,
}

local launch_vehicle = {"向上", "向前", "向后", "向下", "弹射"}
local invites = {"游艇", "事务室", "会所", "事务室车库", "改装铺", "公寓"}
local style_names = {"正常", "半冲刺", "逆向", "忽视红绿灯", "避开交通", "极力避开交通", "抄最近的道", "有时超车"}
local drivingStyles = {786603, 1074528293, 1076, 2883621, 786468, 6, 262144, 5}
local bones = {12844, 24816, 24817, 24818, 35731, 31086}
local interior_stuff = {0, 233985, 169473, 169729, 169985, 170241, 177665, 177409, 185089, 184833, 184577, 163585, 167425, 167169}

local self = menu.list(menu.my_root(), "自己")
local players_list = menu.list(menu.my_root(), "玩家")
local lobby = menu.list(menu.my_root(), "战局")
local vehicles = menu.list(menu.my_root(), "载具")
local missions = menu.list(menu.my_root(), "任务")
local weapons = menu.list(menu.my_root(), "武器")
local funfeatures = menu.list(menu.my_root(), "趣味")
local teleport = menu.list(menu.my_root(), "传送")
local detections = menu.list(menu.my_root(), "检测", {}, "注意 启用所有检测可能导致帧数略有下降")
local modder_detections = menu.list(detections, "作弊检测", {}, "注意 使用显示不可见玩家可能会导致错误的结果")
local normal_detections = menu.list(detections, "正常检测")
local bailOnAdminJoin = false
local protections = menu.list(menu.my_root(), "保护")

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

local function handle_player_list(pid) -- thanks to dangerman and aaron for showing me how to delete players properly
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

if not SCRIPT_SILENT_START then
    util.toast("Hello, " .. players.get_name(players.user()) .. "! \nWelcome To JinxScript!\n" .. "Official Discord: https://discord.gg/hjs5S93kQv")
end

local function player(pid) 
    if pid ~= players.user() and players.get_rockstar_id(pid) == 0xCB2A48C then
        util.toast(lang.get_string(0xD251C4AA, lang.get_current()):gsub("{(.-)}", {player = players.get_name(pid), reason = "JinxScript Developer"}), TOAST_DEFAULT)
    end

    menu.divider(menu.player_root(pid), "JinxScript")
    local bozo = menu.list(menu.player_root(pid), "JinxScript", {"JinxScript"}, "")

    local friendly = menu.list(bozo, "友好", {}, "")
    menu.action(friendly, "给予升级", {}, "给予该玩家17万经验 可从1级升至25级", function()
        menu.trigger_commands("givecollectibles" .. players.get_name(pid))
    end)

    local player_jinx_army = {}
    local army_player = menu.list(friendly, "Jinx军队", {}, "")
    menu.click_slider(army_player, "生成Jinx军队", {}, "", 1, 256, 30, 1, function(val)
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
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

    menu.action(army_player, "清除Jinxs", {}, "", function()
        for entities.get_all_peds_as_handles() as ped do
            if PED.IS_PED_MODEL(ped, util.joaat("a_c_cat_01")) then
                entities.delete_by_handle(ped)
            end
        end
    end)

    local tp 
    tp = player_toggle_loop(friendly, pid, "给予传送能力", {}, "聊天命令是!waypoint 玩家必须在载具内", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local veh = PED.GET_VEHICLE_PED_IS_USING(ped)

        chat.on_message(function(packet_sender, message_sender, text, team_chat)
            if string.contains(text, "!waypoint") and PED.IS_PED_IN_VEHICLE(ped, veh, false) then  
                if players.get_name(message_sender) == players.get_name(pid) and PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
                    menu.trigger_commands("wptp" .. players.get_name(pid))
                else
                    util.toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
                end
            end
        end)
    end)

    local req_count = 0
    menu.action(friendly, "漂移轮胎", {"drifttires"}, "添加漂移轮胎", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        repeat
            if req_count >= 250 then
                util.toast("无法控制玩家载具 :/")
            return end
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
            util.yield()
            req_count += 1
        until NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle)
        VEHICLE.SET_DRIFT_TYRES(vehicle, true)
        req_count = 0
    end)

    local griefing = menu.list(bozo, "恶搞", {}, "")
    local glitch_player_root = menu.list(griefing, "鬼畜玩家")

    local object_hash = util.joaat("xs_prop_hamburgher_wl")
    menu.list_select(glitch_player_root, "物体", {"glitchplayer"}, "用于鬼畜玩家的物体", object_stuff.names, 1, function(index)
        object_hash = util.joaat(object_stuff.objects[index])
    end)

    local delay = 150
    menu.slider(glitch_player_root, "生成延迟", {"spawndelay"}, "注意 如果在Stand的用户身上使用 可能会被标记为作弊者事件", 0, 3000, 150, 10, function(amount)
        delay = amount
    end)

    local glitchplayer
    glitchplayer = player_toggle_loop(glitch_player_root, pid, "鬼畜玩家", {"glitchplayer"}, "对开启实体保护的玩家无效", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)

        if not ENTITY.DOES_ENTITY_EXIST(ped) then
            util.toast(players.get_name(pid) .. " 离得太远 :/")
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

    local glitch_veh_root = menu.list(griefing, "鬼畜载具")
    local obj_hash2 = util.joaat("p_spinning_anus_s")
    menu.list_select(glitch_veh_root, "物体", {"glitchplayer"}, "用于鬼畜玩家的物体", object_stuff.names, 1, function(index)
        obj_hash2 = util.joaat(object_stuff.objects[index])
    end)

    local glitchveh
    glitchveh = menu.toggle_loop(glitch_veh_root, "鬼畜载具", {"glitchvehicle"}, "", function() -- credits to soul reaper for base concept
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_model = players.get_vehicle_model(pid)
        local seat_count = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(veh_model)
        local object_hash = obj_hash2
        RequestModel(object_hash)

        if not ENTITY.DOES_ENTITY_EXIST(ped) and PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            util.toast(players.get_name(pid) .. "太远或不在载具中 :/")
            glitchveh.value = false
        util.stop_thread() end

        if not VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(player_veh) then
            util.toast("冇有座位 :/")
            glitchveh.value = false
        util.stop_thread() end

        local glitch_obj = entities.create_object(object_hash, pos)
        local glitched_ped = PED.CREATE_RANDOM_PED(pos)
        local things = {glitched_ped, glitch_obj}
        
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(glitch_obj)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(glitched_ped)

        ENTITY.ATTACH_ENTITY_TO_ENTITY(glitch_obj, glitched_ped, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)

        for things as spawned_objects do
            ENTITY.SET_ENTITY_VISIBLE(spawned_objects, false)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(spawned_objects)
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
    glitchforcefield = player_toggle_loop(griefing, pid, "鬼畜立场", {"forcefield"}, "对开启实体保护的玩家无效", function()
        local glitch_hash = util.joaat("p_spinning_anus_s")
        RequestModel(glitch_hash)

        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        
        if not ENTITY.DOES_ENTITY_EXIST(ped) then
            util.toast(players.get_name(pid) .. " 太远 :/")
            glitchforcefield.value = false
        util.stop_thread() end

        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            util.toast(players.get_name(pid) .. " 在载具中 :/")
            glitchforcefield.value = false
        util.stop_thread() end

        local obj = entities.create_object(glitch_hash, pos)
        ENTITY.SET_ENTITY_VISIBLE(obj, false)
        ENTITY.SET_ENTITY_COLLISION(obj, true, true)
        util.yield()
        entities.delete_by_handle(obj) 
    end)

    player_toggle_loop(griefing, pid, "摔倒载具", {}, "", function()
        FIRE.ADD_EXPLOSION(players.get_position(pid), 66, 10.0, false, true, 0.0, true)
    end)

    local gravity = menu.list(griefing, "玩家引力", {}, "应用于所有菜单 但是会被检测到 而且对开启无敌的玩家无效")
    local force = 1.00
    menu.slider_float(gravity, "引力量", {"force"}, "", 0, 100, 100, 10, function(value)
        force = value / 100
    end)

    local gravitate
    gravitate = player_toggle_loop(gravity, pid, "启用", {"gravitate"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped)

        for interior_stuff as id do
            if players.is_godmode(pid) and (not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped)) and GetSpawnState(pid) ~= 0 and GetInteriorPlayerIsIn(pid) == id then
                util.toast(players.get_name(pid) .. " 无敌模式 :/")
                gravitate.value = false
            util.stop_thread() end
        end

        FIRE.ADD_EXPLOSION(players.get_position(pid), 29, force, false, true, 0.0, true)
    end)

    menu.toggle_loop(griefing, "混乱火箭弹", {}, "将在地图下方产生随机信号弹 使火箭朝随机方向发射", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        if PED.IS_PED_SHOOTING(ped) and WEAPON.IS_PED_ARMED(ped, 2) then
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x + math.random(-50, 50), pos.y + math.random(-50, 50), pos.z - 2, pos.x, pos.y, pos.z, 0, true, util.joaat("weapon_flaregun"), players.user_ped(), true, false, 0.0)
        end
    end)
    
    menu.toggle_loop(griefing, "自杀火箭弹", {}, "将使他们的火箭掉头 瞄准自己", function()
        local things = {-0.1, 0.1}
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local pos1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, things[math.random(#things)], -15.0, -2.0)
        local pos2 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.0, 0.0)
        if PED.IS_PED_SHOOTING(ped) and WEAPON.IS_PED_ARMED(ped, 2) then
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos1, pos2, 0, true, util.joaat("weapon_flaregun"), players.user_ped(), true, false, 0.0)
            util.yield(2500)
            MISC.CLEAR_AREA_OF_PROJECTILES(pos, 25.0, 0)
        end
    end)

    menu.toggle_loop(griefing, "锁载具门", {"vehiclelock"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(ped)
        if not VEHICLE.GET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, pid) then
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, pid, true)
        end
    end)

    local count_thing = 0
    menu.toggle_loop(griefing, "禁用载具加速", {}, "限速250以下", function(toggled)
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local top_speed = VEHICLE.GET_VEHICLE_MODEL_ESTIMATED_MAX_SPEED(vehicle)
        
        if not PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            util.toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
        return end

        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            repeat
                if count_thing >= 250 then
                    util.toast("无法控制玩家载具 :/")
                return end
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
                util.yield()
                count_thing += 1
            until NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle)
            VEHICLE.SET_VEHICLE_MAX_SPEED(vehicle, 0.1)
            count_thing = 0
        end
    end)

    local time = 0
    menu.action(griefing, "劫持载具", {"hijack"}, "生成NPC把他从载具里带出去然后开走载具 在高延迟的玩家身上也可能不起作用", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))

        if not PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            util.toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
        return end

        local spawned_ped = PED.CREATE_RANDOM_PED(pos.x, pos.y, pos.z - 50)
        ENTITY.SET_ENTITY_INVINCIBLE(spawned_ped, true)
        ENTITY.SET_ENTITY_VISIBLE(spawned_ped, false)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(spawned_ped, true)
        TASK.TASK_ENTER_VEHICLE(spawned_ped, vehicle, 1000, -1, 1.0, 2|8|16)
        VEHICLE.GET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, pid)
        repeat
            time += 1   
            if time > 300 and not PED.IS_PED_IN_ANY_VEHICLE(spawned_ped, false) then
                util.toast("劫持失败 " .. players.get_name(driver) .. "载具 :/")
                entities.delete_by_handle(spawned_ped)
                time = 0
                break 
            end
            util.yield()
        until TASK.GET_IS_TASK_ACTIVE(ped, 2)
        if TASK.GET_IS_TASK_ACTIVE(ped, 2) then
            repeat
                util.yield()
            until not TASK.GET_IS_TASK_ACTIVE(ped, 2) or PED.IS_PED_IN_ANY_VEHICLE(spawned_ped, false)
            TASK.TASK_VEHICLE_DRIVE_WANDER(spawned_ped, vehicle, 9999.0, 6) 
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 2) -- sometimes it doesnt lock
            util.toast("载具现在是你的 :D")
            util.yield(1000)
        end
        if not TASK.GET_IS_TASK_ACTIVE(spawned_ped) then
            repeat
            TASK.TASK_VEHICLE_DRIVE_WANDER(spawned_ped, vehicle, 9999.0, 6) -- giving task again cus doesnt work sometimes
            util.yield()
            until TASK.GET_IS_TASK_ACTIVE(spawned_ped)
            util.yield(5000)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(spawned_ped)
            repeat
                util.yield()
            until
            NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(spawned_ped)
            entities.set_can_migrate(entities.handle_to_pointer(spawned_ped), false)
        end
        if spawned_ped ~= nil and not PED.IS_PED_IN_ANY_VEHICLE(spawned_ped, false) then -- 2nd check cus sometimes doesnt delete the first time
            entities.delete_by_handle(spawned_ped)
        end
    end)

    local hijack
    local fail_count = 0
    hijack = player_toggle_loop(griefing, pid, "自动劫持载具", {"autohijack"}, "会一直劫持他们试图驾驶的任何载具", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)

        if PED.IS_PED_IN_VEHICLE(ped, vehicle, false) then
            local spawned_ped = PED.CREATE_RANDOM_PED(pos.x, pos.y - 10, pos.z)
            ENTITY.SET_ENTITY_INVINCIBLE(spawned_ped, true)
            ENTITY.SET_ENTITY_VISIBLE(spawned_ped, false)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(spawned_ped, true)
            TASK.TASK_ENTER_VEHICLE(spawned_ped, vehicle, 1000, -1, 1.0, 2|8|16)
            util.yield(1000)
            if TASK.GET_IS_TASK_ACTIVE(ped, 2) then
                repeat
                    util.yield()
                until not TASK.GET_IS_TASK_ACTIVE(ped, 2)
            end
            if fail_count >= 5 then
                util.toast("劫持玩家失败的次数太多 禁用功能...")
                fail_count = 0
                hijack.value = false
            end
            if PED.IS_PED_IN_ANY_VEHICLE(spawned_ped, false) then
                util.yield(1500)
                TASK.TASK_VEHICLE_DRIVE_WANDER(spawned_ped, vehicle, 9999.0, 6)
                VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 2)
                VEHICLE.GET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, pid)
                util.yield(5000)
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(spawned_ped)
                repeat
                    util.yield()
                until
                NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(spawned_ped)
                entities.set_can_migrate(entities.handle_to_pointer(spawned_ped), false)
                fail_count = 0
            else
                fail_count += 1
                entities.delete_by_handle(spawned_ped)
            end
            util.yield(500)
        end
    end, function()
        fail_count = 0
    end)

    local req_count = 0
    menu.action(griefing, "翻转载具", {"flip"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local rot = ENTITY.GET_ENTITY_ROTATION(vehicle, 2)
        rot.x = 180

        if not PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            util.toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
        return end
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            repeat
                if req_count >= 250 then
                    util.toast("无法控制玩家载具 :/")
                return end
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
                util.yield()
                req_count += 1
            until NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle)
        end
        ENTITY.SET_ENTITY_ROTATION(vehicle, rot, 2, false)
    end)


    player_toggle_loop(griefing, pid, "旋转载具", {"spin"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local height = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(vehicle)

        if not PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            util.toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
        return end
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            repeat
                if req_count >= 250 then
                    util.toast("无法控制玩家载具 :/")
                return end
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
                util.yield()
                req_count += 1
            until NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle)
        end

        if height < 5.0 and height > 0.1 then
            VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(vehicle)
        end
        if vehicle ~= 0 and not PED.IS_PED_DEAD_OR_DYING(ped) then
            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 5, 0.0, 0.0, 150.0, 0, 0, 0, 0, true, false, true, false, true)
        end
    end)

    player_toggle_loop(griefing, pid, "粘性轮胎", {"stickytires"}, "", function()
        FIRE.ADD_EXPLOSION(players.get_position(pid), 68, 10.0, false, true, 0.0, true)
        util.yield(1000)
    end)

    local hospitalize_count = 0
    menu.action(griefing, "住院", {"hospitalize"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        setBit(memory.script_global(2657589 + 1 + (players.user() * 466) + 427), 0)
        repeat 
            util.yield()
        until memory.read_int(memory.script_global(2657589 + 1 + (players.user() * 466) + 427), 0)
        menu.trigger_commands("kill" .. players.get_name(pid))
        if not PED.IS_PED_DEAD_OR_DYING(ped) then
            repeat
                hospitalize_count += 1
                if hospitalize_count >= 300 then
                    util.toast("无法让玩家住院 :/")
                    clearBit(memory.script_global(2657589 + 1 + (players.user() * 466) + 427), 0)
                    hospitalize_count = 0
                    return
                end
                util.yield()
            until PED.IS_PED_DEAD_OR_DYING(ped)
        end
        if PED.IS_PED_DEAD_OR_DYING(ped) then
            repeat
                util.yield()
            until not PED.IS_PED_DEAD_OR_DYING(ped)
            clearBit(memory.script_global(2657589 + 1 + (players.user() * 466) + 427), 0)
            hospitalize_count = 0
        end
    end)
 
    local attack
    attack = player_toggle_loop(griefing, pid, "愤怒NPC", {}, "让附近的NPC揍玩家", function()
        local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for players.list(true, true, true) as id do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(id)
            for entities.get_all_peds_as_handles() as npc do
                if npc ~= ped and npc ~= players.user_ped() then
                    TASK.TASK_COMBAT_PED(npc, target, 67108864, 16)
                    if not WEAPON.IS_PED_ARMED(npc, 7) and not PED.IS_PED_A_PLAYER(npc) then
                        local weapon_type = attack_weapons[math.random(#attack_weapons)]
                        WEAPON.GIVE_WEAPON_TO_PED(npc, weapon_type, 9999, false, true)
                        PED.SET_PED_ACCURACY(npc, 100)
                    end
                    util.yield()
                end
            end
        end
    end)

    menu.action(griefing,  "汉堡包", {"hamburger"}, "Whopper, Whopper, Whopper, Whopper!", function()
        local pos = players.get_position(pid)
        pos.z -= 0.50
        local whopper = util.joaat("xs_prop_hamburgher_wl")
        RequestModel(whopper)
        local hamburger = entities.create_object(whopper, pos)
        entities.set_can_migrate(entities.handle_to_pointer(hamburger), false)
        util.yield(60000)
        entities.delete_by_handle(hamburger)
    end)
    
    menu.action(griefing,  "汉堡车", {"pattywagon"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        pos.z -= 0.50
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local whopper = util.joaat("xs_prop_hamburgher_wl")
        RequestModel(whopper)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            local hamburger = entities.create_object(whopper, pos)
            ENTITY.SET_ENTITY_COLLISION(hamburger, false, true)
            entities.set_can_migrate(entities.handle_to_pointer(hamburger), false)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(hamburger, vehicle, 0, 0, 0, -0.50, 0, 0, 0, false, false, true, false, 0, false, 0)
        end
    end)

    menu.action(griefing, "发送在线新手动画", {"intro"}, "将玩家发送到在线模式的新手介绍", function()
        if StandUser(pid) then util.toast(stand_notif) util.stop_thread() end
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 20, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    local games = menu.list(griefing, "街机游戏")
    local arcade_games = {
        [210] = "竞赛与追逐",
        [211] = "枪手",
        [212] = "巫师废墟",
        [216] = "去吧太空猴",
    }

    for id, name in arcade_games do
        menu.action(games, name, {}, "强制玩家玩一个街机游戏", function()
            if StandUser(pid) then util.toast(stand_notif) return end
            local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
            util.trigger_script_event(1 << pid, {-95341040, players.user(), id, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
            util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        end)
    end

    local jobs = menu.list(griefing, "强制到活动")
    local activities = {
        [192] = "发送到飞镖",
        [193] = "发送到高尔夫",
    }

    for id, name in activities do
        menu.action(jobs, name, {}, "强制活动", function()
            if StandUser(pid) then util.toast(stand_notif) return end
            local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
            util.trigger_script_event(1 << pid, {-95341040, players.user(), id, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
            util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        end)
    end

    menu.action(griefing, "强制1v1", {"1v1"}, "强制他们进入1V1的状态", function()
        if StandUser(pid) then util.toast(stand_notif) return end
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 197, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(griefing, "黑屏加载", {}, "可以通过重新加入来撤销 玩家必须在一个公寓里 适用于大多数菜单", function()
        if StandUser(pid) then util.toast(stand_notif) return end
        if players.is_in_interior(pid) then
            util.trigger_script_event(1 << pid, {629813291, players.user(), pid, pid, pid, math.random(int_min, int_max), pid})
        else
            util.toast(players.get_name(pid) .. " 不是在室内 :/")
        end
    end)

    menu.action(griefing, "发射玩家", {"launch"}, "适用于大多数菜单", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local mdl = util.joaat("boxville3")
        local pos = players.get_position(pid)
        RequestModel(mdl)
                    
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            util.toast(players.get_name(pid) .. " 在载具里 :/")
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
            until pos.z > 2600.0
            util.yield(100)
            if boxville ~= 0 and ENTITY.DOES_ENTITY_EXIST(boxville) then 
                entities.delete_by_handle(boxville)
            end
        else
            util.toast(players.get_name(pid) .. " 玩家必须移动时才启作用 :/")
        end
    end)

    menu.action(griefing,  "强制玩家离开室内", {}, "适用于大多数室内", function() -- very innovative!
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local glitch_hash = util.joaat("prop_windmill_01")
        local mdl = util.joaat("brickade2")
        RequestModel(glitch_hash)
        RequestModel(mdl)
        for interior_stuff as id do
            if GetInteriorPlayerIsIn(pid) == id then
                util.toast(players.get_name(pid) .. " 不在室内 :/")
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
    
    local freeze = menu.list(griefing, "冻结玩家", {}, "")
    local hard_freeze
    hard_freeze = player_toggle_loop(freeze, pid, "镜头冻结", {"hardfreeze"}, "将他们和他们的相机一起冻结 被大多数菜单屏蔽", function()
        if StandUser(pid) then
            util.toast(stand_notif)
            hard_freeze.value = false
            util.stop_thread()
        end
        util.trigger_script_event(1 << pid, {330622597, players.user(), 0, 0, 0, 0, 0})
        util.yield(500)
    end)

    local blinking_freeze
    blinking_freeze = player_toggle_loop(freeze, pid, "闪屏冻结", {"blinkingfreeze"}, "类似镜头冻结但是有时候会闪一下屏 已被多数菜单屏蔽", function()
        if StandUser(pid) then
            util.toast(stand_notif)
            blinking.freeze = false
            util.stop_thread()
        end
        util.trigger_script_event(1 << pid, {-1796714618, players.user(), 0, 1, 0, 0})
        util.yield(500)
    end)

    local clear_ped_tasks
    clear_ped_tasks = player_toggle_loop(freeze, pid, "清除人物动作", {}, "基本冻结 已被多数菜单屏蔽", function()
        if StandUser(pid) then
            util.toast(stand_notif)
            clear_ped_tasks.value = false
            util.stop_thread()
        end
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    end)
    
    menu.action(freeze, "冻结瞬移", {"tpfreeze"}, "将冻结玩家~20秒 然后将他们传送到网球", function()
        if StandUser(pid) then util.toast(stand_notif) return end
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510)) -- Global_1894573[PLAYER::PLAYER_ID() /*608*/].f_510
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 195, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    local inf_loading = menu.list(griefing, "无限加载荧幕", {}, "")
    menu.action(inf_loading, "摩托帮传送", {}, lang.get_localised(-748077967), function()
        if StandUser(pid) then util.toast(stand_notif) return end
        util.trigger_script_event(1 << pid, {891653640, players.user(), 0, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(inf_loading, "公寓传送", {}, lang.get_localised(-748077967), function()
        if StandUser(pid) then util.toast(stand_notif) return end
        util.trigger_script_event(1 << pid, {-1796714618, players.user(), 0, 1, id})
    end)
        
    menu.list_action(inf_loading, "电话邀请", {}, "", invites, function(index, name)
        if StandUser(pid) then util.toast(stand_notif) return end
        switch name do
            case "游艇":
                util.trigger_script_event(1 << pid, {36077543, players.user(), 1})
                util.toast("游艇邀请发送")
            break
            case "事务室":
                util.trigger_script_event(1 << pid, {36077543, players.user(), 2})
                util.toast("事务室邀请发送")
            break
            case "会所":
                util.trigger_script_event(1 << pid, {36077543, players.user(), 3})
                util.toast("会所邀请发送")
            break
            case "事务室车库":
                util.trigger_script_event(1 << pid, {36077543, players.user(), 4})
                util.toast("事务室车库邀请发送")
            break
            case "改装铺":
                util.trigger_script_event(1 << pid, {36077543, players.user(), 5})
                util.toast("改装铺邀请发送")
            break
            case "公寓":
                util.trigger_script_event(1 << pid, {36077543, players.user(), 6})
                util.toast("公寓邀请发送")
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

    local cage = menu.list(griefing, "套笼子", {}, "")
    menu.action(cage, "电笼子", {"electriccage"}, "", function()
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

    menu.action(cage, "航运集装箱", {"containercage"}, "", function()
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
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        RequestModel(container_hash)
        local container = entities.create_vehicle(container_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 2.0, 0.0), ENTITY.GET_ENTITY_HEADING(ped))
        spawned_objects[#spawned_objects + 1] = container
        ENTITY.SET_ENTITY_VISIBLE(container, false)
        ENTITY.FREEZE_ENTITY_POSITION(container, true)
    end)

    menu.action(cage, "删除生成的笼子", {"clearcages"}, "", function()
        local entitycount = 0
        for spawned_objects as object do
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(object, false, false)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(object)
            entities.delete_by_handle(object)
            spawned_objects[i] = nil
            entitycount += 1
        end
        util.toast("已清除 " .. entitycount .. " 生成的笼子物体")
    end) 

    local radio = menu.list(griefing, "更换广播电台", {}, "")
    local stations = {}
    for station, name in station_name do
        stations[#stations + 1] = station
    end
    menu.list_action(radio, "电台", {}, "", stations, function(index, value)
        if StandUser(pid) then util.toast(lang.get_localised(1729001290)) end
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(players.user())
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped)

        if not PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            util.toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
        return end

        local radio_name = station_name[value]
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then 

            if not VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
                util.toast("更换电台失败 :/")
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
    control_veh = player_toggle_loop(griefing, pid, "乱打载具方向盘", {}, "只对陆地上行驶的载具生效", function(toggle)
        if StandUser(pid) then util.toast(lang.get_localised(1729001290)) end
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped)
        local veh_class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
        if not players.exists(pid) then util.stop_thread() end

        if not ENTITY.DOES_ENTITY_EXIST(ped) and PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            util.toast(players.get_name(pid) .. "太远或不在载具中 :/")
            control_veh.value = false
        util.stop_thread() end

        if veh_class == 15 then
            util.toast(players.get_name(pid) .. " 在直升机上 :/")
            control_veh.value = false
        util.stop_thread() end
        
        if veh_class == 16 then
            util.toast(players.get_name(pid) .. " 在飞机上 :/")
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
    menu.toggle(griefing, "悲伤耶稣", {""}, "", function(toggled)
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
                    new_pos.z += 1 -- jesus kept sliding for some reason, doing this to prevent that.
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

    menu.action(griefing, "杀死室内玩家", {"interiorkill"}, "适用于大多数室内", function()
        local pos = players.get_position(pid)

        for interior_stuff as id do
            if GetInteriorPlayerIsIn(pid) == id then
                util.toast(players.get_name(pid) .. " 不在室内 :/")
            return end
            if GetInteriorPlayerIsIn(pid) ~= id then
                util.trigger_script_event(1 << pid, {-1428749433, players.user(), 448051697, math.random(0, 9999)})
                util.yield(100)
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 1000, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
            end
        end
    end)

    player_toggle_loop(griefing, pid, "电击枪循环", {"tase"}, "", function()
        local pos = players.get_position(pid)
        for i = 1, 50 do
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 0, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
        end
        util.yield()
    end)

    local antigodmode = menu.list(bozo, "反击无敌", {}, "")
    local stun = menu.list(antigodmode, "击晕", {}, "仅适用于开了无敌却冇有开防止摔倒的玩家")
    menu.action(stun, "署名", {"ownedstun"}, "", function()
        local pos = players.get_position(pid)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 1000, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
    end)

    menu.action(stun, "匿名", {"anonstun"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 1000, true, util.joaat("weapon_stungun"), false, false, true, 1.0)
    end)
    
    menu.action(antigodmode, "击杀无敌", {"squish"}, "仅适用于开了无敌却冇有开防止摔倒的玩家", function()
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
        for spawned_vehs as vehicle do
            entities.set_can_migrate(entities.handle_to_pointer(vehicle), false)
        end
        ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0.0, 0.0, 3.0, 0.0, 0.0, 0.0, -180.0, 0, false, true, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0.0, 3.0, 3.0, 0.0, 0.0, 0.0, -180.0, 0, false, true, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0.0, 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, false, true, false, 0, true)
        ENTITY.SET_ENTITY_VISIBLE(vehicle1, false)
        util.yield(5000)
        for spawned_vehs as vehicle do
            entities.delete_by_handle(vehicle)
        end
    end) 
    menu.action(antigodmode, "地图杀", {"barrierkill"}, "对大多数菜单有效 当目标开启移除部分地图杀或延迟高的玩家可能不起作用", function()
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

    local tp_player = menu.list(bozo, "传送玩家")
    local clubhouse = menu.list(tp_player, "会所")
    local facility = menu.list(tp_player, "设施")
    local arcade = menu.list(tp_player, "设施")
    local warehouse = menu.list(tp_player, "仓库")
    local cayoperico = menu.list(tp_player, "佩里科岛")
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

    local small = menu.list(warehouse, "小型仓库")
    local medium = menu.list(warehouse, "中型仓库")
    local large = menu.list(warehouse, "大型仓库")

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

    menu.action(cayoperico, "佩里科岛", {"tpcayo"}, lang.get_localised(-748077967), function()
        if StandUser(pid) then util.toast(stand_notif) util.stop_thread() end
        util.trigger_script_event(1 << pid, {330622597, players.user(), 0, 0, 3, 1})
    end)

    menu.action(cayoperico, "佩里科岛V2", {"tpcayo2"}, lang.get_localised(-748077967), function()
        if StandUser(pid) then util.toast(stand_notif) util.stop_thread() end
        util.trigger_script_event(1 << pid, {-369672308, players.user(), 1})
    end)

    menu.action(cayoperico, "佩里科岛(冇有过场动画)", {"tpcayo2"}, lang.get_localised(-748077967), function()
        if StandUser(pid) then util.toast(stand_notif) util.stop_thread() end
        util.trigger_script_event(1 << pid, {330622597, players.user(), 0, 0, 4, 1})
    end)

    menu.action(cayoperico, "离开佩里科岛", {"cayoleave"}, "被大多数菜单所阻挡 玩家必须在佩里科岛才能触发这个", function()
        if StandUser(pid) then util.toast(stand_notif) util.stop_thread() end
        util.trigger_script_event(1 << pid, {330622597, players.user(), 0, 0, 3})
    end)

    menu.action(cayoperico, "踢出佩里科岛(传送到海滩)", {"cayokick"}, lang.get_localised(-748077967), function()
        if StandUser(pid) then util.toast(stand_notif) util.stop_thread() end
        util.trigger_script_event(1 << pid, {330622597, players.user(), 0, 0, 4, 0})
    end)

    local interior_tps = {
        [70] = "地堡", -- 70 thru 80 are bunkers
        [81] = "机动作战中心",
        [83] = "机库", -- 83 thru 87 are hangars
        [88] = "复仇者",
        [89] = "设施", -- 89 thru 97 are facilities
        [102] = "夜总会车库",-- 102 thru 111 are garages
        [117] = "恐霸",
        [122] = "竞技场工作室",
        [123] = "赌场",
        [124] = "顶层公寓",
        [128] = "游戏厅车库", -- 128 thru 133 are garages
        [146] = "夜总会",
        [147] = "虎鲸",
        [149] = "改装铺", -- 149 thru 153 are auto shops
        [155] = "事务所",
    }
  
    for id, name in interior_tps do
        menu.action(interiors, name, {""}, lang.get_localised(-748077967), function()
            if StandUser(pid) then util.toast(stand_notif) return end
            util.trigger_script_event(1 << pid, {1727896103, players.user(), id, 1, 0, 1, 1130429716, -1001012850, 1106067788, 0, 0, 1, 2123789977, 1, -1})
        end)
    end

    local spectate_root = menu.ref_by_rel_path(menu.player_root(pid), "Spectate")
    local spectate = menu.list(spectate_root, "Spectate Settings")
    if menu.get_edition() > 1 then
        local esp_tgl
        esp_tgl = menu.toggle(spectate, "启用透视", {""}, "", function(toggled)
            if toggled then
                menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Low Latency Rendering"))
                menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Name ESP>Name ESP>Low Latency Rendering"))
                menu.trigger_commands("esptags off")
            else
                menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Disabled"))
                menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Name ESP>Name ESP>Disabled"))
            end
        end)
    end

    player_toggle_loop(spectate, pid, "清除时间周期修改器", {}, "当从室内观察人们时 将自动把时间周期修改器设定为默认值 这样从设施等地方观察人们就不会看起来很糟糕", function()
        if GRAPHICS.GET_TIMECYCLE_MODIFIER_INDEX() ~= -1 or GetInteriorPlayerIsIn(players.user()) ~= 0 then
            GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
        end
    end)

    local misc = menu.list(bozo, "杂项")
    player_toggle_loop(misc, pid, "显示瞄准线", {"aimlines"}, "", function()
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
    aimbor = player_toggle_loop(misc, pid, "自动扳机", {"triggerbot"}, "", function()
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

    player_toggle_loop(misc, pid, "载具武器自瞄", {"vehicleaimbot"}, "允许你使用你的载具上的飞弹来瞄准玩家", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if not PED.IS_PED_DEAD_OR_DYING(ped) and PAD.IS_CONTROL_PRESSED(0, 70) then
            VEHICLE.SET_VEHICLE_SHOOT_AT_TARGET(players.user_ped(), ped, players.get_position(pid))
        end
    end)

    player_toggle_loop(misc, pid, "自动踢攻击者", {"thinice"}, "自动踢攻击过你的玩家", function()
        if players.is_marked_as_attacker(pid) then
            menu.trigger_commands("kick" .. players.get_name(pid))
        end
    end)
end

players.on_join(player)
players.dispatch_on_join()

block_blaming = menu.ref_by_path("Online>Protections>Block Blaming")
menu.toggle_loop(self, "反瞄准", {"blockaiming"}, "防止玩家向你开枪", function()
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if WEAPON.IS_PED_ARMED(ped, 7) or TASK.GET_IS_TASK_ACTIVE(ped, 199) or TASK.GET_IS_TASK_ACTIVE(ped, 128) then
            block_blaming.value = true
        else
            block_blaming.value = false
        end
    end
end, function()
    block_blaming.value = false
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

menu.toggle_loop(self, "快速翻滚", {"fastroll"}, "", function()
    STATS.STAT_SET_INT(util.joaat("MP"..util.get_char_slot().."_SHOOTING_ABILITY"), 200, true)
end)

--[[local strafe_speed = menu.list(self, "Custom Strafe Speed", {}, "")
local speed = 1.00
menu.slider_float(strafe_speed, "Strafe Speed", {"strafespeed"}, "", 0, 500, 100, 10, function(value)
    speed = value / 100
end)

local strafe
strafe = menu.toggle_loop(strafe_speed, "Enable", {"faststrafe"}, "", function()
    if PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
        PED.SET_PED_MOVE_RATE_OVERRIDE(players.user_ped(), speed)
    else
        PED.SET_PED_MOVE_RATE_OVERRIDE(players.user_ped(), 1.0)
    end
end)]]


menu.toggle_loop(self, "隐武者", {"ghostarmedplayers"}, "有武器的幽灵玩家", function()
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if WEAPON.IS_PED_ARMED(ped, 7) or TASK.GET_IS_TASK_ACTIVE(ped, 199) or TASK.GET_IS_TASK_ACTIVE(ped, 128) 
        or IsPlayerUsingGuidedMissile(pid) or IsPlayerInRcTank(pid) or IsPlayerInRcBandito(pid) or IsPlayerFlyingAnyDrone(pid) then
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, true)
        else
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
        end
    end
end, function()
    for players.list(false, true, true) as pid do
        NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
    end
end)

local orb = menu.list(self, "反轨道炮")
local ghost = menu.list(orb, "幽灵")
local ghost_tgl
ghost_tgl = menu.toggle_loop(ghost, "始终", {"ghostorb"}, "自动对使用轨道炮的玩家进行幽灵化处理", function()
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local cam_dist = v3.distance(players.get_position(players.user()), players.get_cam_pos(pid))
        if IsPlayerUsingOrbitalCannon(pid) and TASK.GET_IS_TASK_ACTIVE(ped, 135) and cam_dist < 400 and cam_dist > 340 then
            util.toast(players.get_name(pid) .. " 正在用轨道炮瞄准你")
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
    for players.list(false, true, true) as pid do
        NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
    end
end)

local tgl
tgl = menu.toggle_loop(ghost, "被瞄准时", {}, "自动幽灵使用轨道炮瞄准你的玩家", function()
    if menu.get_value(ghost_tgl) then
        tgl.value = false
    return end
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local cam_dist = v3.distance(players.get_position(players.user()), players.get_cam_pos(pid))
        if IsPlayerUsingOrbitalCannon(pid) and TASK.GET_IS_TASK_ACTIVE(ped, 135) and cam_dist < 400 and cam_dist > 340 then
            util.toast(players.get_name(pid) .. " 正在用轨道炮瞄准你")
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, true)
        else
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
        end
    end
end, function()
    for players.list(false, true, true) as pid do
        NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
    end
end)


local annoy = menu.list(orb, "干扰", {}, "目标玩家列表中快速显示和删除您的名字")
local orb_delay = 1000
menu.list_select(annoy, "延迟", {}, "轨道炮使用者看你名字的闪烁速度", {"慢速", "中速", "快速"}, 1, function(index, value)
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
        annoy_tgl.value = false
        util.toast("不要同时启用干扰和幽灵 ;)")
    return end
    
    for players.list(false, true, true) as pid do
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
    for players.list(false, true, true) as pid do
        NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
    end
end)

menu.toggle_loop(self, "友好AI", {""}, "AI不会针对你", function()
    PED.SET_PED_RESET_FLAG(players.user_ped(), 124, true)
end)

menu.toggle_loop(self, "自动加入游戏", {}, "自动接受加入", function() -- credits to soulreaper for sending me this :D
    local message_hash = HUD.GET_WARNING_SCREEN_MESSAGE_HASH()
    if message_hash == 15890625 or message_hash == -587688989 then
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1.0)
        util.yield(50)
    end
end)

menu.action(lobby, "劫持所有载具", {"hijackall"}, "生成一个NPC 把他们从车里踢出来并开走", function()
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)

        if ENTITY.DOES_ENTITY_EXIST(ped) and PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            menu.trigger_commands("hijack " .. players.get_name(pid))
        end
    end
end)

menu.toggle_loop(lobby, "锁定所有载具", {"lockall"}, "", function()
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(ped)
        if not VEHICLE.GET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, pid) then
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, pid, true)
        end
    end
end)

local block_orb
block_orb = menu.toggle_loop(lobby,  "禁止进入轨道炮室", {"blockorb"}, "生成一个物体 挡住轨道炮的门", function() -- credit to lance, just cleaned it up a bit.
    local mdl = util.joaat("h4_prop_h4_garage_door_01a")
    RequestModel(mdl)
    if orb_obj == nil or not ENTITY.DOES_ENTITY_EXIST(orb_obj) then
        orb_obj = entities.create_object(mdl, v3(335.9, 4833.9, -59.0))
        entities.set_can_migrate(entities.handle_to_pointer(orb_obj), false)
        ENTITY.SET_ENTITY_HEADING(orb_obj, 125.0)
        ENTITY.FREEZE_ENTITY_POSITION(orb_obj, true)
        ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(orb_obj, players.user_ped(), false)
        ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(players.user_ped(), orb_obj, false) -- have to do this both way for collision to be properly avoided between player ped and the object
    end
    util.yield(50)
end, function()
    if orb_obj ~= nil then
        entities.delete_by_handle(orb_obj)
    end
end)

menu.toggle_loop(lobby, "干扰武装载具玩家", {"annoy"}, "", function()
    for _, pid in players.list(false, false, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
        if TASK.GET_IS_TASK_ACTIVE(ped, 199) then
            VEHICLE.SET_VEHICLE_HOMING_LOCKEDONTO_STATE(veh, 1)
        end
    end
end)

menu.action(lobby,  "汉堡包", {"hamburgerall"}, "Whopper, Whopper, Whopper, Whopper!", function()
    for players.list(false, true, true) as pid do
        menu.trigger_commands("hamburger" .. players.get_name(pid))
    end
end)

menu.action(lobby,  "汉堡车", {"pattywagonall"}, "把每个人的载具套上一个汉堡", function()
    for players.list(false, true, true) as pid do
        menu.trigger_commands("pattywagon" .. players.get_name(pid))
    end
end)

menu.toggle_loop(missions, "跳过达克斯工作冷却", {}, "", function() -- thx icedoomfist for the stat name <3
    STATS.STAT_SET_INT(util.joaat("MP"..util.get_char_slot().."_XM22JUGGALOWORKCDTIMER"), -1, true)
end)

menu.toggle_loop(missions, "禁用阻止实体轰炸", {}, "在任务时将自动启用阻止实体轰炸", function()
    local EntitySpam = menu.ref_by_path("Online>Protections>Block Entity Spam>Block Entity Spam")
    if NETWORK.NETWORK_IS_ACTIVITY_SESSION() == true then
        if not menu.get_value(EntitySpam) then return end
        menu.trigger_command(EntitySpam, "off")
    else
        if menu.get_value(EntitySpam) then return end
        menu.trigger_command(EntitySpam, "on")
    end
end)

menu.action(missions, "击杀所有NPC", {}, "", function()
    local counter = 0
    for entities.get_all_peds_as_handles() as ped do
        if HUD.GET_BLIP_COLOUR(HUD.GET_BLIP_FROM_ENTITY(ped)) == 1 or TASK.GET_IS_TASK_ACTIVE(ped, 352) then -- shitty way to go about it but hey, it works (most of the time).
            ENTITY.SET_ENTITY_HEALTH(ped, 0)
            counter += 1
            util.yield()
        end
    end
    if counter == 0 then
        util.toast("未找到NPC :/")
    else
        util.toast("击杀 ".. tostring(counter) .." NPC")
    end
end)

menu.action(missions, "传送拾取物到我", {}, "", function()
    local counter = 0
    local pos = players.get_position(players.user())
    for entities.get_all_pickups_as_handles() as pickup do
        ENTITY.SET_ENTITY_COORDS(pickup, pos, false, false, false, false)
        counter += 1
        util.yield()
    end
    if counter == 0 then
        util.toast("未找到拾取物 :/")
    else
        util.toast("传送 ".. tostring(counter) .." 拾取物")
    end
end)

menu.toggle_loop(weapons, "自动扳机", {"triggerbotall"}, "", function()
    local wpn = WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped())
    local dmg = SYSTEM.ROUND(WEAPON.GET_WEAPON_DAMAGE(wpn, 0))
    local delay = WEAPON.GET_WEAPON_TIME_BETWEEN_SHOTS(wpn)
    local wpnEnt = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), false)
    local wpnCoords = ENTITY.GET_ENTITY_BONE_POSTION(wpnEnt, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(wpnEnt, "gun_muzzle"))
    for players.list(false, true, true) as pid do
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

menu.toggle_loop(weapons, "射击时禁用反瞄准", {}, "", function()
    if PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
        block_blaming.value = false
    else
        block_blaming.value = true
    end
end)

local modifier = 1.00
menu.slider_float(weapons, "近战伤害修改", {"meleedamage"}, "", 100, 1000, 100, 10, function(value)
    modifier = value / 100
    PLAYER.SET_PLAYER_MELEE_WEAPON_DAMAGE_MODIFIER(players.user(), modifier)
end)

menu.toggle_loop(weapons, "最大飞弹锁定范围", {}, "飞弹锁定范围和自动瞄准设定为最大", function()
    PLAYER.SET_PLAYER_LOCKON_RANGE_OVERRIDE(players.user(), 99999999.0)
end)

local weapon_thing = menu.list(weapons, "更改子弹类型", {}, "改变你的枪射出的子弹")
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

menu.toggle_loop(weapons, "快手", {"fasthands"}, "更快地切换你的武器", function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 56) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)


menu.toggle_loop(weapons, "锁定玩家", {}, "允许您使用制导发射器锁定玩家", function()
    for players.list(true, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        PLAYER.ADD_PLAYER_TARGETABLE_ENTITY(players.user(), ped)
        ENTITY.SET_ENTITY_IS_TARGET_PRIORITY(ped, false, 400.0)    
    end
end, function()
    for players.list(true, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        PLAYER.REMOVE_PLAYER_TARGETABLE_ENTITY(players.user(), ped)
    end
end)

if menu.get_edition() > 1 then
    menu.toggle_loop(weapons, "瞄准玩家透视", {"aimesp"}, "", function()
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
menu.slider_float(veh_jump, "力量", {"jumpiness"}, "", 0, 10000, 2500, 100, function(value)
    force = value / 100
end)
menu.toggle_loop(veh_jump, "启用", {"vehiclejump"}, "按空格键跳跃", function()
    local veh = entities.get_user_vehicle_as_handle()
    if veh ~= 0 and ENTITY.DOES_ENTITY_EXIST(veh) and PAD.IS_CONTROL_JUST_RELEASED(0, 102) then
        ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, force/1.5, force, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        repeat
            util.yield()
        until not ENTITY.IS_ENTITY_IN_AIR(veh)
    end
end)

local deformation = 1.00
menu.slider_float(vehicles, "碰撞变形", {"deformation"}, "", 0, 10000, 100, 100, function(value)
    deformation = value / 100
    menu.trigger_commands("vhdeformationmult " .. deformation)
end)

local seat_id = -1
local moved_seat = menu.click_slider(vehicles, "移动座位", {}, "", 1, 1, 1, 1, function(seat_id)
    TASK.TASK_WARP_PED_INTO_VEHICLE(players.user_ped(), entities.get_user_vehicle_as_handle(), seat_id - 2)
end)

menu.on_tick_in_viewport(moved_seat, function()
    if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
        moved_seat.max_value = 0
    return end
    
    moved_seat.max_value = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(entities.get_user_vehicle_as_handle()))
end)

menu.toggle_loop(vehicles, "快速引擎", {""}, "", function()
    if not VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(entities.get_user_vehicle_as_handle()) and TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 150) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

menu.toggle_loop(vehicles, "快速进入载具", {"fastvehcleenter"}, "更快地进入载具", function()
    if (TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 160) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 167) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 165)) and not TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 195) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

menu.toggle_loop(vehicles, "离开时禁用无敌", {""}, "", function()
    if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(entities.get_user_vehicle_as_handle()) then
        if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
            ENTITY.SET_ENTITY_CAN_BE_DAMAGED(PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true), true)
        end
    end
end)

menu.toggle_loop(vehicles, "绕过防死锁", {}, "", function()
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            VEHICLE.SET_VEHICLE_ALLOW_HOMING_MISSLE_LOCKON_SYNCED(veh, true)
        end
    end
end)

menu.toggle_loop(vehicles, "载具武器自瞄", {"vehicleaimbotall"}, "允许你使用你的载具上的火箭弹瞄准玩家", function()
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local ped_dist = v3.distance(players.get_position(players.user()), players.get_position(pid))
        if not PED.IS_PED_DEAD_OR_DYING(ped) and PAD.IS_CONTROL_PRESSED(0, 70) and ped_dist < 300.0 then
            VEHICLE.SET_VEHICLE_SHOOT_AT_TARGET(players.user_ped(), ped, players.get_position(pid))
        end
    end
end)

menu.toggle_loop(vehicles, "贴地", {""}, "", function()
    local vehicle = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
    local velocity = ENTITY.GET_ENTITY_VELOCITY(vehicle)
    local height = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(vehicle)
    local controls = {32, 33, 34, 35}
    if height < 5.0 then
        if ENTITY.IS_ENTITY_IN_AIR(vehicle) then
            VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(vehicle)
        end
    else
        for controls as key do
            if vehicle ~= 0 and PAD.IS_CONTROL_PRESSED(0, key) then
                while not PAD.IS_CONTROL_RELEASED(0, key) and ENTITY.IS_ENTITY_IN_AIR(vehicle) do
                    ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 2, 0.0, 0.0, -500 - velocity.z, 0, 0, 0, 0, true, false, true, false, true)
                    util.yield()
                end
            end
        end
    end
end)

menu.toggle_loop(vehicles, "自旋", {"spinbot"}, "", function()
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

menu.action(funfeatures, "扫帚Mk2", {""}, "对于其他玩家来说 你将是不可见的 ", function()
    local reveal_invis = menu.ref_by_path("Online>Reveal Invisible Players")
    if reveal_invis.value == true then
        util.toast("禁用 显示不可见玩家功能")
    return end
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

local headlamp = menu.list(funfeatures, "头灯", {}, "其他玩家不可见")
local distance = 25.0
menu.slider_float(headlamp, "距离", {"distance"}, "灯光将照亮的距离", 100, 10000, 1500, 100, function(value)
    distance = value / 100
end)

local brightness = 10.0
menu.slider_float(headlamp, "亮度", {"brightness"}, "灯光的亮度", 100, 10000, 1000, 100, function(value)
    brightness = value / 100
end)

local light_radius = 15.0
menu.slider_float(headlamp, "半径", {"radius"}, "值越高 光束越宽", 100, 5000, 2000, 100, function(value)
    light_radius = value / 100
end)

local color = {r = 1, g = 235/255, b = 190/255, a = 0}
menu.colour(headlamp, "颜色", {"colour"}, "", color, true, function(value)
    color = value 
end)

menu.toggle_loop(headlamp, "打开", {"headlamp"}, "", function()
    local head_pos = PED.GET_PED_BONE_COORDS(players.user_ped(), 31086, 0.0, 0.0, 0.0)
    local cam_rot = players.get_cam_rot(players.user())
    GRAPHICS.DRAW_SPOT_LIGHT(head_pos, cam_rot:toDir(), math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255), distance * 1.5, brightness, 0.0, light_radius, distance)
end)

menu.toggle(funfeatures, "停电", {"poweroutage"}, "", function(toggled)
    GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(toggled)
end)

menu.toggle(funfeatures, "断电", {"blackout"}, "", function(toggled)
    menu.trigger_commands("time 1")
    GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(toggled)
    if toggled then
        GRAPHICS.SET_TIMECYCLE_MODIFIER("dlc_island_vault")
    else
        GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
    end
end)

local obj
menu.toggle(funfeatures, "飞碟立场", {}, "在你的人物上附着一个飞碟摧毁你路上的任何东西", function(toggled)
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

local jesus_main = menu.list(funfeatures, "耶稣驾驶", {}, "耶稣 请抓住这个方向盘 ")
local style = 786603
menu.list_action(jesus_main, "驾驶风格", {}, "点选选择一种风格", style_names, function(index, value)
    switch value do
        case "普通": 
            style = 786603
            break
        case "半仓促": 
            style = 1074528293
            break
        case "撤销": 
            style = 1076
            break
        case "忽略信号灯": 
            style = 2883621
            break
        case "避免交通": 
            style = 786468
            break
        case "极度避免交通": 
            style = 6
            break     
        case "走快捷方式":
            style = 262144
            break
        case "有时超车": 
            style = 5
        break  
    end
end)

local speed = 20.00
menu.slider_float(jesus_main, "行驶速度", {""}, "", 0, 10000, 2000, 100, function(value)
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
            util.toast("未找到路径点 耶稣会开车带你兜风 :)")
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

menu.toggle(funfeatures, "特斯拉自动驾驶", {}, "伊隆马斯克", function(toggled)
    local pos = players.get_position(players.user())
    local tesla_ai = util.joaat("u_m_y_baygor")
    local tesla = util.joaat("raiden")
    RequestModel(tesla_ai)
    RequestModel(tesla)
    if toggled then     
        if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
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

local finger_thing = menu.list(funfeatures, "手指枪", {}, "按B键从你的手指射出子弹 不会对玩家造成伤害")
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
                local fingerPos = PED.GET_PED_BONE_COORDS(players.user_ped(), 4089, 0.1, 0.0, -0.1)
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(fingerPos, x, y, z, 1, true, projectile, 0, true, false, 500.0, players.user_ped(), 0)
            end
            util.yield(100)
        end
        local pos = players.get_position(players.user())
        MISC.CLEAR_AREA_OF_PROJECTILES(pos, 999999.0, 0)
    end)
end

local jinx_pet
jinx_toggle = menu.toggle_loop(funfeatures, "个人宠物Jinx", {}, "", function()
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
local army = menu.list(funfeatures, "Jinx军队", {}, "")
menu.click_slider(army, "生成Jinx军队", {}, "", 1, 256, 30, 1, function(val)
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

menu.action(army, "清除Jinxs", {}, "", function()
    for  entities.get_all_peds_as_handles() as ped do
        if PED.IS_PED_MODEL(ped, util.joaat("a_c_cat_01")) then
            entities.delete_by_handle(ped)
        end
    end
end)

menu.action(funfeatures, "寻找宠物Jinx", {}, "", function()
    local pos = players.get_position(players.user())
    if jinx_pet ~= nil then 
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(jinx_pet, pos, false, false, false)
    else
        util.toast("冇有找到Jinx :(")
    end
end)

menu.toggle_loop(modder_detections, "无敌检测", {}, "检测是否有人在使用无敌", function()
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for interior_stuff as id do
            if players.is_godmode(pid) and not players.is_in_interior(pid) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and GetSpawnState(pid) == 99 and GetInteriorPlayerIsIn(pid) == id then
                util.draw_debug_text(players.get_name(pid) .. " 处于无敌")
                break
            end
        end
    end 
end)

menu.toggle_loop(modder_detections, "载具无敌", {}, "检测是否有人在使用载具无敌", function()
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
            for interior_stuff as id do
                if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(vehicle) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) 
                and GetSpawnState(pid) == 99 and GetInteriorPlayerIsIn(pid) == id and pid == driver then
                    util.draw_debug_text(players.get_name(driver) ..  " 处于载具无敌模式")
                    break
                end
            end
        end
    end 
end)

menu.toggle_loop(modder_detections, "改装武器", {}, "检测是否有人使用无法在线获取的武器", function()
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for i, hash in modded_weapons do
            local weapon_hash = util.joaat(hash)
            if WEAPON.HAS_PED_GOT_WEAPON(ped, weapon_hash, false) and (WEAPON.IS_PED_ARMED(ped, 7) or TASK.GET_IS_TASK_ACTIVE(ped, 8) or TASK.GET_IS_TASK_ACTIVE(ped, 9)) then
                util.draw_debug_text(players.get_name(pid) .. " 是否使用改装过的武器 " .. "(" .. hash .. ")")
                break
            end
        end
    end
end)

menu.toggle_loop(modder_detections, "悬浮检测", {}, "检测玩家是否在使用悬浮", function()
    for players.list(false, true, true) as pid do
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
            util.toast(players.get_name(pid) .. " 正在使用悬浮")
            break
        end
    end
end)

menu.toggle_loop(modder_detections, "车速修改", {}, "检测是否有人在使用超级驱动器或修改过的载具速度", function()
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_speed = (ENTITY.GET_ENTITY_SPEED(vehicle)* 2.236936)
        local veh_class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
        if veh_class ~= 15 and veh_class ~= 16 and veh_speed >= 200 and (players.get_vehicle_model(pid) ~= util.joaat("oppressor") and players.get_vehicle_model(pid) ~= util.joaat("oppressor2")) and pid == driver then
            local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
            util.toast(players.get_name(driver) .. " 正在使用载具加速")
            break
        end
    end
end)

menu.toggle_loop(modder_detections, "快速加入", {}, "检测是否有人正在使用快速加入", function()
    for players.list(false, true, true) as pid do
        if GetSpawnState(players.user()) == 0 then return end
        local old_sh = players.get_script_host()
        util.yield(100)
        local new_sh = players.get_script_host()
        if old_sh ~= new_sh then
            if GetSpawnState(pid) == 0 and players.get_script_host() == pid then
                util.toast(players.get_name(pid) .. " 检测到快速加入 现在被归类为作弊者")
                break
            end
        end
    end
end)

menu.toggle_loop(modder_detections, "检测观看", {}, "检测是否有人在观察你", function()
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local cam_dist = v3.distance(players.get_position(players.user()), players.get_cam_pos(pid))
        local ped_dist = v3.distance(players.get_position(players.user()), players.get_position(pid))
        for interior_stuff as id do
            if cam_dist < 20.0 and ped_dist > 75.0 and not PED.IS_PED_DEAD_OR_DYING(ped) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and GetInteriorPlayerIsIn(pid) == id then
                util.toast(players.get_name(pid) .. " is watching you (modded)")
                break
            end
        end
    end
end)

menu.toggle_loop(modder_detections, "作弊轨道炮", {}, "检测是否有人在使用作弊轨道炮", function()
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if IsPlayerUsingOrbitalCannon(pid) and not TASK.GET_IS_TASK_ACTIVE(ped, 135) and GetSpawnState(pid) ~= 0 then
            util.toast(players.get_name(pid) .. " 正在使用作弊轨道炮")
            break
        end
    end
end)

menu.toggle_loop(modder_detections, "未PO载具", {}, "检测是否有人在驾驶未PO的载具", function()
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local hash = players.get_vehicle_model(pid)
        for veh_things as veh do -- because getting the decor int for them didnt want to work
            if hash == util.joaat(veh) and DECORATOR.DECOR_GET_INT(vehicle, "MPBitset") == 8 then
            return end
        end
        local spawned_vals = {8, 1024}
        if table.contains(spawned_vals, DECORATOR.DECOR_GET_INT(vehicle, "MPBitset")) and players.get_vehicle_model(pid) ~= 0 and not TASK.GET_IS_TASK_ACTIVE(ped, 160) and GetSpawnState(players.user()) ~= 0 then
            local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
            util.draw_debug_text(players.get_name(driver) .. " 正在使用刷出的载具 " .. "(" .. util.reverse_joaat(players.get_vehicle_model(pid)) .. ")")
            break
        end
    end
end)

menu.toggle_loop(normal_detections, "传送", {}, "检测一个玩家传送了多远 但并不一定是作弊者", function()
    for players.list(false, true, true) as pid do
        local old_pos = players.get_position(pid)
        util.yield(50)
        local cur_pos = players.get_position(pid)
        local distance_between_tp = v3.distance(old_pos, cur_pos)
        for interior_stuff as id do
            if GetInteriorPlayerIsIn(pid) == id and GetSpawnState(pid) ~= 0  and players.exists(pid) then
                util.yield(100)
                if distance_between_tp > 300.0 then
                    util.toast(players.get_name(pid) .. " 被传送 " .. SYSTEM.ROUND(distance_between_tp) .. " 米")
                    break
                end
            end
        end
    end
end)

menu.toggle_loop(normal_detections, "检测观看", {}, "检测是否有人在观察你", function()
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local cam_dist = v3.distance(players.get_position(players.user()), players.get_cam_pos(pid))
        local ped_dist = v3.distance(players.get_position(players.user()), players.get_position(pid))
        if cam_dist < 20.0 and ped_dist > 75.0 and not PED.IS_PED_DEAD_OR_DYING(ped) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and players.is_in_interior(pid) then
            util.toast(players.get_name(pid) .. " 在看你")
            break
        end
    end
end)

menu.toggle_loop(normal_detections, "轨道炮", {}, "检测是否有人在使用轨道炮", function()
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if IsPlayerUsingOrbitalCannon(pid) and TASK.GET_IS_TASK_ACTIVE(ped, 135) then
            util.draw_debug_text(players.get_name(pid) .. " 正在使用轨道炮")
        end
    end
end)

menu.toggle_loop(normal_detections, "检测语音聊天", {}, "", function()
    for players.list(true, true, true) as pid do
        if NETWORK.NETWORK_IS_PLAYER_TALKING(pid) then
            util.draw_debug_text(players.get_name(pid) .. " 在说话")
        end
    end 
end)


local kick_count = 0
local ignore = {}
menu.toggle_loop(protections, "投票踢", {}, "按Y踢出 按N忽略", function()
    for players.list(false, true, true) as pid do
        local ignored = ignore[pid]
        if players.is_marked_as_modder(pid) and not StandUser(pid) and not ignored then
            repeat
                util.toast(players.get_name(pid) .. " 是作弊者 按 Y 踢出或按 N 忽略")
                util.yield()
            until PAD.IS_CONTROL_JUST_PRESSED(0, 246) or PAD.IS_CONTROL_JUST_PRESSED(0, 249)
            if PAD.IS_CONTROL_JUST_PRESSED(0, 246) then
                menu.trigger_commands("kick" .. players.get_name(pid))
                local player_name = players.get_name(pid)
                repeat
                    if kick_count >= 300 then
                        util.toast("无法踢玩家 可能被主机阻止 :/")
                        kick_count = 0
                        return
                    end
                    util.yield()
                    kick_count += 1
                until not players.exists(pid)
                util.toast(player_name .. " 已踢出 :D")
            elseif PAD.IS_CONTROL_JUST_PRESSED(0, 249) then
                ignore[pid] = true
                util.toast(players.get_name(pid) .. " 已忽略")
                return
            end
        end
    end
end)

menu.toggle_loop(protections, "阻止变成野兽", {}, "防止你被变成野兽同时停止战局野兽活动", function()
    if util.spoof_script("am_hunt_the_beast", SCRIPT.TERMINATE_THIS_THREAD) then
        util.toast("检测到猎杀野兽脚本  正在终止脚本...")
    end
end)

local anticage = menu.list(protections, "反笼子", {}, "")
local alpha = 88
menu.slider(anticage, "透明度", {"transparency"}, "笼子透明度", 1, #values, 2, 1, function(amount)
    alpha = values[amount]
end)

local radius = 10.00
menu.slider_float(anticage,  "封锁半径", {"radius"}, "反笼子将检测笼子的半径", 100, 2500, 1000, 100, function(value)
    radius = value/100
end)

local cleanup = false
menu.toggle(anticage, "自动删除", {"cleanup"}, "自动删除任何被催生的笼子", function(toggled)
    cleanup = toggled
end)

menu.toggle_loop(anticage, "启用反笼子", {"anticage"}, "", function()
    local user = players.user_ped()
    local veh = PED.GET_VEHICLE_PED_IS_USING(user)
    local my_ents = {user, veh}
    for entities.get_all_objects_as_pointers() as obj_ptr do
        local net_obj = memory.read_long(obj_ptr + 0xd0)
        if net_obj == 0 or memory.read_byte(net_obj + 0x49) == players.user() then
            continue
        end
        local obj_handle = entities.pointer_to_handle(obj_ptr)
        local owner = entities.get_owner(obj_ptr)
        local id = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(obj_handle)
        CAM.SET_GAMEPLAY_CAM_IGNORE_ENTITY_COLLISION_THIS_UPDATE(obj_handle)
        for doors as door do
            if entities.get_model_hash(obj_ptr) ~= util.joaat(door) then
                continue
            end
        end
        for my_ents as data do
            if v3.distance(players.get_position(players.user()), ENTITY.GET_ENTITY_COORDS(obj_handle)) <= radius then
                if data ~= 0 and alpha >= 1 then
                    ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(obj_handle, data, false)  
                    ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(data, obj_handle, false)
                    ENTITY.SET_ENTITY_ALPHA(obj_handle, alpha, false)
                end
                if data ~= 0 and cleanup then
                    entities.set_can_migrate(obj_ptr, true)
                    ENTITY.SET_ENTITY_ALPHA(obj_handle, 0, false)
                    entities.delete_by_handle(obj_handle)
                end
                if data ~= 0 and ENTITY.IS_ENTITY_TOUCHING_ENTITY(data, obj_handle) then
                    util.toast("笼子来自 " .. players.get_name(owner))
                end
            end
        end
        SHAPETEST.RELEASE_SCRIPT_GUID_FROM_ENTITY(obj_handle)
    end
end)

local anti_mugger = menu.list(protections, "阻止劫匪")
menu.toggle_loop(anti_mugger, "自己", {}, "防止你被打劫", function() -- thx nowiry for improving my method :D
    if NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
        local ped_netId = memory.script_local("am_gang_call", 63 + 10 + (0 * 7 + 1))
        local sender = memory.script_local("am_gang_call", 287)
        local target = memory.script_local("am_gang_call", 288)

        util.spoof_script("am_gang_call", function()
            if (memory.read_int(sender) ~= players.user() and memory.read_int(target) == players.user() 
            and NETWORK.NETWORK_DOES_NETWORK_ID_EXIST(memory.read_int(ped_netId)) 
            and NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(memory.read_int(ped_netId))) then
                local mugger = NETWORK.NET_TO_PED(memory.read_int(ped_netId))
                entities.delete_by_handle(mugger)
                util.toast("阻止劫匪 " .. players.get_name(memory.read_int(sender)))
            end
        end)
    end
end)

menu.toggle_loop(anti_mugger, "其他人", {}, "防止别人被抢劫", function()
    if NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
        local ped_netId = memory.script_local("am_gang_call", 63 + 10 + (0 * 7 + 1))
        local sender = memory.script_local("am_gang_call", 287)
        local target = memory.script_local("am_gang_call", 288)
        
        util.spoof_script("am_gang_call", function()
            if memory.read_int(target) ~= players.user() and memory.read_int(sender) ~= players.user()
            and NETWORK.NETWORK_DOES_NETWORK_ID_EXIST(memory.read_int(ped_netId)) 
            and NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(memory.read_int(ped_netId)) then
                local mugger = NETWORK.NET_TO_PED(memory.read_int(ped_netId))
                entities.delete_by_handle(mugger)
                util.toast("阻止劫匪发送 " .. players.get_name(memory.read_int(sender)) .. " 到 " .. players.get_name(memory.read_int(target)))

            end
        end)
    end
end)

local kick_time = 0
menu.toggle_loop(protections, "自动踢无敌", {"kickgod"}, "", function()
    for players.list(false, false, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local old_pos = players.get_position(pid)
        util.yield(100)
        local cur_pos = players.get_position(pid)
        for interior_stuff as id do
            if players.is_godmode(pid) and not players.is_in_interior(pid) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and GetSpawnState(pid) == 99 and GetInteriorPlayerIsIn(pid) == id and old_pos ~= cur_pos then
                kick_time += 1
                util.yield(5000)
                if kick_time >= 3 then
                    menu.trigger_commands("kick" .. players.get_name(pid))
                    repeat
                        util.yield()
                    until pid ~= nil
                    util.toast("已踢出 " .. players.get_name(pid) .. " 无敌 :D")
                    kick_time = 0
                end
            end
        end
    end 
end, function()
end)

--[[
    local kick_time = 0
local reveal_invis = menu.ref_by_path("Online>Reveal Invisible Players")
reveal = false
menu.toggle_loop(protections, "Auto Kick Godmoders", {"kickgod"}, "", function()
    if reveal_invis.value == true then
        reveal_invis.value = false
        reveal = true
        for players.list(false, true, true) as pid do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            for interior_stuff as id do
                if reveal_invis.value == false and players.is_godmode(pid) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and GetSpawnState(pid) == 99 and GetInteriorPlayerIsIn(pid) == id and not TASK.IS_PED_STILL(ped) then
                    kick_time += 1
                    util.yield(1000)
                    if kick_time >= 5 then
                        menu.trigger_commands("kick" .. players.get_name(pid))
                        repeat
                            util.yield()
                        until pid ~= nil
                        util.toast("Successfully removed " .. players.get_name(pid) .. " for godmode. :D")
                        kick_time = 0
                    end
                end
            end
        end 
    end
end, function()
    if reveal == true then
        reveal_invis.value = true
    end
end)
]]
menu.toggle_loop(protections, "阻止交易错误", {}, "阻止销毁载具脚本被恶意使用 让你出现交易错误", function()
    if util.spoof_script("am_destroy_veh", SCRIPT.TERMINATE_THIS_THREAD) then
        util.toast("检测到销毁载具脚本 终止脚本...")
    end
end)

local block_spec_syncs
block_spec_syncs = menu.toggle_loop(protections, "阻止观看同步", {}, "阻止所有观看者的传出同步", function()
    for players.list(false, true, true) as pid do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local cam_dist = v3.distance(players.get_position(players.user()), players.get_cam_pos(pid))
        local ped_dist = v3.distance(players.get_position(players.user()), players.get_position(pid))
        if cam_dist < 25.0 and ped_dist > 75.0 and not PED.IS_PED_DEAD_OR_DYING(ped) then
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
    for players.list(false, true, true) as pid do
        if players.exists(pid) then
            local outgoingSyncs = menu.ref_by_rel_path(menu.player_root(pid), "Outgoing Syncs>Block")
            outgoingSyncs.value = false
        end
    end
end)

menu.list_action(protections, "清除所有", {}, "", {"NPC", "载具", "物体", "道具", "投掷物", "声音"}, function(index, name)
    util.toast("清除中 "..name:lower().."...")
    local counter = 0
    switch index do
        case 1:
            for entities.get_all_peds_as_handles() as ped do
                if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) then
                    entities.delete_by_handle(ped)
                    counter += 1
                    util.yield()
                end
            end
            break
        case 2:
            for entities.get_all_vehicles_as_handles() as vehicle do
                if vehicle ~= PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) and DECORATOR.DECOR_GET_INT(vehicle, "Player_Vehicle") == 0 and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
                    entities.delete_by_handle(vehicle)
                    counter += 1
                end
                util.yield()
            end
            break
        case 3:
            for entities.get_all_objects_as_handles() as object do
                entities.delete_by_handle(object)
                counter += 1
                util.yield()
            end
            break
        case 4:
            for entities.get_all_pickups_as_handles() as pickup do
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
    for entities.get_all_peds_as_handles() as ped do
        if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) then
            entities.delete_by_handle(ped)
            cleanse_entitycount += 1
            util.yield()
        end
    end
    util.toast("已清除 " .. cleanse_entitycount .. " NPC")
    cleanse_entitycount = 0
    for entities.get_all_vehicles_as_handles() as vehicle do
        if vehicle ~= PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) and DECORATOR.DECOR_GET_INT(vehicle, "Player_Vehicle") == 0 and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            entities.delete_by_handle(vehicle)
            cleanse_entitycount += 1
            util.yield()
        end
    end
    util.toast("已清除 ".. cleanse_entitycount .." 载具")
    cleanse_entitycount = 0
    for entities.get_all_objects_as_handles() as object do
        entities.delete_by_handle(object)
        cleanse_entitycount += 1
        util.yield()
    end
    util.toast("已清除 " .. cleanse_entitycount .. " 物体")
    cleanse_entitycount = 0
    for entities.get_all_pickups_as_handles() as pickup do
        entities.delete_by_handle(pickup)
        cleanse_entitycount += 1
        util.yield()
    end
    util.toast("已清除 " .. cleanse_entitycount .. " 道具")
    local pos = players.get_position(players.user())
    MISC.CLEAR_AREA_OF_PROJECTILES(pos, 400.0, 0)
    util.toast("清除所有投掷物")
end)

util.keep_running()

