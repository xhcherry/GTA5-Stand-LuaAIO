--翻译 by 呆呆
util.require_natives("2944a", "g-uno")
local joaat, toast, yield, draw_debug_text = util.joaat, util.toast, util.yield, util.draw_debug_text
local function player_toggle_loop(root, pid, menu_name, command_names, help_text, callback, callback_off)
    return menu.toggle_loop(root, menu_name, command_names, help_text, function()
        if not players.exists(pid) then 
            util.stop_thread()
        end
        callback()
    end, callback_off)
end

local spawned_objects = {}
local function BitTest(bits, place)
    return (bits & (1 << place)) != 0
end

local function SetBit(addr: number, bit: number)
	memory.write_int(addr, memory.read_int(addr) | 1 << bit)
end

local function ClearBit(addr: number, bit: number)
	memory.write_int(addr, memory.read_int(addr) ~ 1 << bit)
end

local function IS_PLAYER_USING_ORBITAL_CANNON(pid)
    return BitTest(memory.read_int(memory.script_global((2657704 + (pid * 463 + 1) + 424))), 0) -- Global_2657704[PLAYER::PLAYER_ID() /*463*/].f_424
end

local function IS_PLAYER_FLYING_ANY_DRONE(pid)
   return BitTest(memory.read_int(memory.script_global(1853988 + (pid * 867 + 1) + 267 + 366)), 26) -- Global_1853988[PLAYER::PLAYER_ID() /*867*/].f_267.f_366, 26)
end

local function IS_PLAYER_USING_GUIDED_MISSILE(pid)
    return (memory.read_int(memory.script_global(2657704 + 1 + (pid * 463) + 321 + 10)) != -1 and IS_PLAYER_FLYING_ANY_DRONE(pid)) -- Global_2657704[PLAYER::PLAYER_ID() /*463*/].f_321.f_10
end

local function IS_PLAYER_USING_MISSILE_TURRET(pid)
    return BitTest(memory.read_int(memory.script_global(1853988 + 1 + (pid * 867) + 267 + 480)), 25) -- Global_1853988[PLAYER::PLAYER_ID() /*867*/].f_267.f_480), 25)
end

local function IS_PLAYER_IN_RC_BANDITO(pid)
    return BitTest(memory.read_int(memory.script_global(1853988 + (pid * 867 + 1) + 267 + 366)), 29)  -- Global_1853988[PLAYER::PLAYER_ID() /*867*/].f_267.f_366, 29)
end

local function IS_PLAYER_IN_RC_TANK(pid)
    return BitTest(memory.read_int(memory.script_global(1853988 + (pid * 867 + 1) + 267 + 429 + 2)), 16) -- Global_1853988[bParam0 /*867*/].f_267.f_429.f_2
end

local function IS_PLAYER_IN_REMOTE_VEHICLE(pid)
    return IS_PLAYER_FLYING_ANY_DRONE(pid) or IS_PLAYER_USING_GUIDED_MISSILE(pid) or IS_PLAYER_IN_RC_BANDITO(pid) or IS_PLAYER_IN_RC_TANK(pid)
end

local function IS_PLAYER_RIDING_ROLLER_COASTER(pid)
    return BitTest(memory.read_int(memory.script_global(1853988 + 1 + (pid * 867) + 863)), 15) -- Global_1853988[PLAYER::PLAYER_ID() /*867*/].f_863), 15)
end

local function GET_SPAWN_STATE(pid)
    return memory.read_int(memory.script_global(((2657704 + 1) + (pid * 463)) + 232)) -- Global_2657704[PLAYER::PLAYER_ID() /*463*/].f_232
end

local function GET_INTERIOR_FROM_PLAYER(pid)
    return memory.read_int(memory.script_global(((2657704 + 1) + (pid * 463)) + 245)) -- Global_2657704[bVar0 /*463*/].f_245
end

local function IS_PLAYER_IN_INTERIOR(pid)
    local id = {0, 233985, 169473, 169729, 169985, 170241, 177665, 177409, 185089, 184833, 184577, 163585, 167425, 167169, 138241}
    for id as interior do
        if GET_INTERIOR_FROM_PLAYER(pid) != interior then
            return false
        end
    end
    return true
end

local function GET_SEAT_PED_IS_IN(ped) -- thanks rockstar for making me do this cus you guys are too lazy to have a native for it :D
    local vehicle = GET_VEHICLE_PED_IS_USING(ped)
    if vehicle == 0 then
        return nil
    end
    local num_of_seats = GET_VEHICLE_MODEL_NUMBER_OF_SEATS(GET_ENTITY_MODEL(vehicle))
    for i = -1, num_of_seats - 1 do
        local ped_in_seat = GET_PED_IN_VEHICLE_SEAT(vehicle, i)
        if ped_in_seat == ped then
            return i
        end
    end
end

local function IS_PLAYER_MOVING(pid)
    local oldpos = players.get_position(pid)
    yield(100)
    local currentpos = players.get_position(pid)
    if v3.distance(oldpos, currentpos) > 0.1 then
        return true
    end
    return false
end

local function StandUser(pid) -- credit to sapphire for this
    if players.exists(pid) and pid != players.user() then
        for menu.player_root(pid):getChildren() as cmd do
            if cmd:getType() == COMMAND_LIST_CUSTOM_SPECIAL_MEANING and cmd:refByRelPath("Stand User"):isValid() then
                return true
            end
        end
    end
    return false
end

local function IsDetectionPresent(pid, detection)
    if players.exists(pid) then
        for menu.player_root(pid):getChildren() as cmd do
            if cmd:getType() == COMMAND_LIST_CUSTOM_SPECIAL_MEANING and cmd:refByRelPath(detection):isValid() and players.exists(pid) then
                return true
            end
        end
    end
    return false
end

local function LegitPlatePattern(plate)
    if string.match(plate, "%d%d%a%a%a%d%d%d") then
      return true
    else
      return false
    end
end

local function LoadWeaponAsset(weapon_name)
    local projectile = joaat(weapon_name)
    while not HAS_WEAPON_ASSET_LOADED(projectile) do
        REQUEST_WEAPON_ASSET(projectile, 31, false)
        yield()
    end
    return projectile
end

local function RequestAnimation(hash)
    REQUEST_ANIM_DICT(hash)
    while not HAS_ANIM_DICT_LOADED(hash) do
        yield()
    end
end

function GetControlOfEntity(entity)
    local ctr = 0
    while not NETWORK_HAS_CONTROL_OF_ENTITY(entity) do
        if ctr >= 250 then
            ctr = 0
            return
        end
        NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
        yield()
        ctr += 1
    end
end

local function DeletePed(ped)
    local ctrl_ctr = 0
    local del_ctr = 0
    repeat
        if del_ctr > 250 then
            del_ctr = 0
            return
        end
        GetControlOfEntity(ped)
        entities.delete(ped)
        del_ctr += 1
        yield()
    until ped == nil or not DOES_ENTITY_EXIST(ped)
end

local function DOES_VEHICLE_HAVE_IMANI_TECH(vehicle_model)
    switch vehicle_model do
        case joaat("deity"):
        case joaat("granger2"):
        case joaat("buffalo4"):
        case joaat("jubilee"):
        case joaat("patriot3"):
        case joaat("champion"):
        case joaat("greenwood"):
        case joaat("omnisegt"):
        case joaat("virtue"):
        case joaat("r300"):
        case joaat("stingertt"):
        case joaat("buffalo5"):
        case joaat("coureur"):
        case joaat("monstrociti"):
        return true
    end
    return false
end

local function RELEASE_VEH_HANDLE(vehicle)
    if vehicle ~= entities.get_user_vehicle_as_handle() then
        RELEASE_SCRIPT_GUID_FROM_ENTITY(vehicle)
    end
end

local function NullCheck(string)
    if string == "NULL" or string == nil then
        return ""
    else
        return string
    end
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

local weapon_stuff = {
    {"烟花", "weapon_firework"}, 
    {"原子能枪", "weapon_raypistol"},
    {"邪恶冥王", "weapon_raycarbine"},
    {"天基炮", "weapon_railgun"},
    {"红色激光", "vehicle_weapon_enemy_laser"},
    {"绿色激光", "vehicle_weapon_player_laser"},
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
    "rcbandito",
    "phantom3"
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
    "prop_shop_front_door_r",
    "prop_com_ls_door_01",
    "v_ilev_carmod3door",
}

local object_stuff = {
    names = {
        "摩天轮",
        "飞碟",
        "风车",
        "水泥搅拌器",
        "脚手架",
        "大保龄球",
        "大足球",
        "大橙球",
        "特技坡道",

    },
    objects = {
        "prop_ld_ferris_wheel",
        "p_spinning_anus_s",
        "prop_windmill_01",
        "prop_staticmixer_01",
        "prop_towercrane_02a",
        "des_scaffolding_root",
        "stt_prop_stunt_bowling_ball",
        "stt_prop_stunt_soccer_ball",
        "prop_juicestand",
        "stt_prop_stunt_jump_l",
    }
}

local attackers = {
    names = {
        "小丑",
        "墨西哥人",
        "僵尸",
        "特警",
        "犀牛战甲",
        "宇航员",
        "大脚怪",
        "外星人",
        "太空猴",
        "无能狂怒超人",
        "莱特斯",
    },
    mdl = {
        "s_m_y_clown_01",
        "u_m_y_mani",
        "u_m_y_zombie_01",
        "s_m_y_swat_01",
        "u_m_y_juggernaut_01",
        "s_m_m_movspace_01",
        "ig_orleans",
        "s_m_m_movalien_01",
        "u_m_y_pogo_01",
        "u_m_y_imporage",
        "ig_lestercrest"
    }
}

local vehicle_classes = {
    "小轿车",
    "轿车",
    "SUV",
    "轿跑",
    "肌肉",
    "经典",
    "跑车",
    "超跑",
    "摩托",
    "越野",
    "工业",
    "公用",
    "货车",
    "电动",
    "船",
    "直升机",
    "飞机",
    "服务",
    "紧急",
    "军队",
    "商业",
    "火车",
    "开轮"
}

local interiors = {
    {"安全空间[挂机房]", {x=-158.71494, y=-982.75885, z=149.13135}},
    {"外星人实验室", {x=-1869.5039, y=3749.7612, z=-99.84549}},
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
    {"莱斯特的办公室", {x=707.2138, y=-965.5549, z=30.412853}},
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
    {"机场休息室", {x=-913.8656, y=-2527.106, z=36.331566}},
    {"停尸房", {x=240.94368, y=-1379.0645, z=33.74177}},
    {"联合储蓄", {x=1.298771, y=-700.96967, z=16.131021}},
    {"桑库多堡垒瞭望塔", {x=-2357.9187, y=3249.689, z=101.45073}},
    {"事务所大楼", {x=-1118.0181, y=-77.93254, z=-98.99977}},
    {"事务所车库", {x=-1071.0494, y=-71.898506, z=-94.59982}},
    {"恐霸内部", {x=-1421.015, y=-3012.587, z=-80.000}},
    {"地堡内部", {x=899.5518,y=-3246.038, z=-98.04907}},
    {"IAA办公室", {x=128.20, y=-617.39, z=206.04}},
    {"FIB顶楼", {x=135.94359, y=-749.4102, z=258.152}},
    {"FIB47楼", {x=134.5835, y=-766.486, z=234.152}},
    {"FIB49楼", {x=134.635, y=-765.831, z=242.152}},
    {"肥鸡机顶", {x=-31.007448, y=6317.047, z=40.04039}},
    {"脱衣舞俱乐部DJ位", {x=121.398254, y=-1281.0024, z=29.480522}},
}
local tp_locations = {
    [4] = "沙滩海岸",
    [7] = "龙舌兰酒吧",
    [8] = "机场一层",
    [9] = "黄色杰克酒吧",
    [10] = "牛肉屋",
    [11] = "汉堡店",
    [13] = "水果市场",
    [25] = "莱斯特仓库",
    [28] = "本尼店",
    [31] = "沙滩海岸船屋",
    [42] = "高速美食餐厅",
    [56] = "佩立托湾",
    [58] = "葡萄籽机场",
    [59] = "佩立托湾武器店",
    [60] = "机场二层",
    [66] = "天文台",
    [68] = "赌场",
    [72] = "赌场屋顶",
    [87] = "玛德拉索",
    [90] = "天堂岛码头",
    [91] = "佩罗码头",
    [97] = "乡村俱乐部",
    [114] = "乞力耶德山"
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
local invites = {"游艇", "办公室", "会所", "办公室车库", "改装铺", "公寓"}
local style_names = {"正常", "催促", "逆向", "无视红绿灯", "避开堵车", "极力避开堵车", "走捷径", "有时超车"}
local stand_notif = "My brother in christ, what are you doing?! This will not work on a fellow stand user."
local drivingStyles = {786603, 1074528293, 1076, 2883621, 786468, 6, 262144, 5}
local bones = {12844, 24816, 24817, 24818, 35731, 31086}
local interior_stuff = {0, 233985, 169473, 169729, 169985, 170241, 177665, 177409, 185089, 184833, 184577, 163585, 167425, 167169, 138241}

local self = menu.list(menu.my_root(), "自我选项")
local audio = menu.list(menu.my_root(), "声音选项")
local online = menu.list(menu.my_root(), "在线选项")
local players_list = menu.list(menu.my_root(), "玩家选项")
local lobby = menu.list(players_list, "所有玩家")
local vehicles = menu.list(menu.my_root(), "载具选项")
local missions = menu.list(menu.my_root(), "任务选项")
local weapons = menu.list(menu.my_root(), "武器选项")
local funfeatures = menu.list(menu.my_root(), "趣味选项")
local teleport = menu.list(menu.my_root(), "传送选项")
local detections = menu.list(menu.my_root(), "检测选项", {}, "可能会掉帧")
local modder_detections = menu.list(detections, "作弊检测")
local normal_detections = menu.list(detections, "正常检测")
local protections = menu.list(menu.my_root(), "保护选项")

speed = menu.get_value(menu.ref_by_path("Self>Movement>Levitation>Movement Speed"))
sprint = menu.get_value(menu.ref_by_path("Self>Movement>Levitation>Sprint Multiplier"))

local menus = {}
local function player_list(pid)
    if NETWORK_IS_SESSION_ACTIVE()then 
        menus[pid] = menu.list(players_list, players.get_name(pid), {}, "", function()
            menu.trigger_commands($"jinxscript {players.get_name(pid)}")
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

local function player(pid) 
    if pid != players.user() and (players.get_name(pid) == "Prizuhm" or players.get_name(pid) == "Iinustechtips") then
        toast(lang.get_string(0xD251C4AA, lang.get_current()):gsub("{(.-)}", {player = players.get_name(pid), reason = "JinxScript Developer"}))
        players.add_detection(pid, "JinxScript Developer", TOAST_ALL, 1)
    end

    if not players.exists(players.user()) then
        return
    end

    menu.divider(menu.player_root(pid), "JinxScript")
    local main = menu.list(menu.player_root(pid), "JinxScript", {"JinxScript"}, "")

    local friendly = main:list("友好", {}, "")
    friendly:action("给予升级", {}, "给予该玩家17万经验 可从1级升至30级", function()
        menu.trigger_commands($"赠送收藏品 {players.get_name(pid)}")
    end)

    local jinx_pet_ply
    friendly:toggle_loop("Jinx宠物", {}, "", function()
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if not jinx_pet_plyr or not DOES_ENTITY_EXIST(jinx_pet_plyr) then
            local jinx = joaat("a_c_cat_01")
            util.request_model(jinx)
            local pos = players.get_position(pid)
            jinx_pet_plyr = entities.create_ped(28, jinx, pos, 0)
            entities.set_can_migrate(jinx_pet_plyr, false)
            SET_PED_COMPONENT_VARIATION(jinx_pet_plyr, 0, 0, 1, 0)
            SET_ENTITY_INVINCIBLE(jinx_pet_plyr, true)
        end
        TASK_FOLLOW_TO_OFFSET_OF_ENTITY(jinx_pet_plyr, ped, 0, -0.3, 0, 7.0, -1, 1.5, true)
    end, function()
        entities.delete(jinx_pet_plyr)
    end)
  
    friendly:toggle_loop("载具火箭", {""}, "给对方载具火箭", function()
        local wpn = joaat("VEHICLE_WEAPON_TANK")
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local offset = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
        local leftStart = offset(vehicle, -1.25, 0.5, 0.35)
        local leftEnd = offset(vehicle, -1.25, 100.0, 0.35)
        local rightStart = offset(vehicle, 1.25, 0.5, 0.35)
        local rightEnd = offset(vehicle, 1.25, 100.0, 0.35)
        if not GET_IS_TASK_ACTIVE(ped, 199) and IS_PLAYER_PRESSING_HORN(pid) then
            SHOOT_SINGLE_BULLET_BETWEEN_COORDS(leftStart, leftEnd, 0, true, wpn, 0, true, false, 5.0)
            SHOOT_SINGLE_BULLET_BETWEEN_COORDS(rightStart, rightEnd, 0, true, wpn, 0, true, false, 5.0)
            repeat
                yield()
            until not IS_PLAYER_PRESSING_HORN(pid)
        end
    end)

    friendly:action("漂移轮胎", {"drifttires"}, "给对方漂移轮胎", function()
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        GetControlOfEntity(vehicle)
        SET_DRIFT_TYRES(vehicle, true)
    end)

    player_toggle_loop(friendly, pid, "自动填充", {""}, "", function()
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        if IS_ROCKET_BOOST_ACTIVE(vehicle) then
            repeat
                yield()
            until not IS_ROCKET_BOOST_ACTIVE(vehicle)
            NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
            SET_ROCKET_BOOST_FILL(vehicle, 100.0)
        end
    end)

    local boost_veh_friendly
    boost_veh_friendly = player_toggle_loop(friendly, pid, "喇叭加速", {"hornboost"}, "", function() -- the only functional method that works everytime, applying force doesnt sync well since it requires entity control
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if not IS_PED_IN_ANY_VEHICLE(ped, false) then
            toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
            boost_veh_friendly.value = false
            return 
        end
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local mdl = joaat("stt_prop_track_speedup")
        util.request_model(mdl)
        if IS_PLAYER_PRESSING_HORN(pid) then
            local boostpad = entities.create_object(mdl, GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 0.0, GET_ENTITY_SPEED(vehicle)/2, -3.0), false, false, false)
            SET_ENTITY_VISIBLE(boostpad, false)
            SET_OBJECT_SPEED_BOOST_AMOUNT(boostpad, 100)
            entities.set_can_migrate(boostpad, false)
            yield(500)
            entities.delete(boostpad)
        end
    end)
    local griefing = main:list("恶搞", {}, "")
    local glitch_player_root = griefing:list("鬼畜玩家")
    local object_hash = joaat("prop_ld_ferris_wheel")
    glitch_player_root:list_select("物体", {"glitchplayerobj"}, "", object_stuff.names, 1, function(index)
        object_hash = joaat(object_stuff.objects[index])
    end)
    local delay = 150
    glitch_player_root:slider("重生延迟", {"spawndelay"}, "可能会被标记为作弊者", 0, 3000, 150, 10, function(amount)
        delay = amount
    end)

    local glitchplayer
    local glitch_ply_notif = true
    glitchplayer = player_toggle_loop(glitch_player_root, pid, "启用", {"glitchplayer"}, "对有实体保护的菜单无效", function()
        if glitch_ply_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                glitch_ply_notif = false
            end
        end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)

        if not DOES_ENTITY_EXIST(ped) then
            toast($"{players.get_name(pid)} 太远 :/")
            glitchvalue = false
        util.stop_thread() end

        local glitch_hash = object_hash
        local mdl = joaat("rallytruck")
        util.request_model(glitch_hash)
        util.request_model(mdl)
        local obj = entities.create_object(glitch_hash, pos)
        local vehicle = entities.create_vehicle(mdl, pos, 0)
        SET_ENTITY_VISIBLE(obj, false)
        SET_ENTITY_VISIBLE(vehicle, false)
        SET_ENTITY_INVINCIBLE(obj, true)
        SET_ENTITY_COLLISION(obj, true, true)
        APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 10.0, 10.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        yield(delay)
        entities.delete(obj)
        entities.delete(vehicle)
    end)

    local glitch_veh_root = griefing:list("鬼畜载具")
    local glitch_hash = joaat("prop_ld_ferris_wheel")
    glitch_veh_root:list_select("物体", {"glitchvehobj"}, "", object_stuff.names, 1, function(index)
        glitch_hash = joaat(object_stuff.objects[index])
    end)
    
    local glitchveh
    local glitch_veh_notif = true
    glitchveh = player_toggle_loop(glitch_veh_root, pid, "启用", {"glitchvehicle"}, "目前不会被其他所有菜单检测到", function() -- credits to soul reaper for base concept
        if glitch_veh_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                glitch_veh_notif = false 
            end
        end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = GET_ENTITY_COORDS(ped, false)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local veh_model = players.get_vehicle_model(pid)
        local seat_count = GET_VEHICLE_MODEL_NUMBER_OF_SEATS(veh_model)
        util.request_model(glitch_hash)
        
        if not DOES_ENTITY_EXIST(ped) then
            toast($"{players.get_name(pid)} 太远 :/")
            glitchveh.value = false
            util.stop_thread() 
        end

        if not IS_PED_IN_ANY_VEHICLE(ped, false) then
            toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
            glitchveh.value = false
            util.stop_thread() 
        end

        if not ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
            toast("无座 :/")
            glitchveh.value = false
            util.stop_thread() 
        end

        glitched_ped = CREATE_RANDOM_PED(pos)
        glitch_obj = entities.create_object(glitch_hash, pos)
        local things = {glitched_ped, glitch_obj}
        entities.set_can_migrate(glitched_ped, false)
        entities.set_can_migrate(glitch_obj, false)
        for things as spawned_objects do
            NETWORK_REQUEST_CONTROL_OF_ENTITY(spawned_objects)
            SET_ENTITY_VISIBLE(spawned_objects, false)
            SET_ENTITY_INVINCIBLE(spawned_objects, true)
        end

        for i = 0, seat_count -1 do
            if ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
                local emptyseat = i
                for l = 1, 25 do
                    SET_PED_INTO_VEHICLE(glitched_ped, vehicle, emptyseat)
                    ATTACH_ENTITY_TO_ENTITY(glitch_obj, glitched_ped, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
                    SET_ENTITY_COLLISION(glitch_obj, true, true)
                    yield()
                end
            end
        end
        if glitched_ped != nil then
            entities.delete(glitched_ped) 
        end
        if glitch_obj != nil then 
            entities.delete(glitch_obj)
        end
    end, function()
        if glitched_ped != nil then
            entities.delete(glitched_ped) 
        end
        if glitch_obj != nil then 
            entities.delete(glitch_obj)
        end
    end)

    local glitchforcefield
    local glitch_ff_notif = true
    glitchforcefield = player_toggle_loop(griefing, pid, "鬼畜立场", {"forcefield"}, "对有实体保护的菜单无效", function()
        if glitch_ff_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                glitch_ff_notif = false
            end
        end
        local glitch_hash = joaat("p_spinning_anus_s")
        util.request_model(glitch_hash)

        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        
        if not DOES_ENTITY_EXIST(ped) then
            toast($"{players.get_name(pid)} 太远 :/")
            glitchforcefield.value = false
        util.stop_thread() end

        if IS_PED_IN_ANY_VEHICLE(ped, false) then
            toast($"{players.get_name(pid)} 在载具里 :/")
            glitchforcefield.value = false
        util.stop_thread() end

        local obj = entities.create_object(glitch_hash, pos)
        SET_ENTITY_VISIBLE(obj, false)
        SET_ENTITY_COLLISION(obj, true, true)
        yield()
        entities.delete(obj) 
    end)

    local time = 0
    local hijack_veh_notif = true
    griefing:action("载具劫持", {"jc"}, "发送NPC劫持对方载具 高延迟玩家可能不起作用", function()
        if pid == players.user() then 
            toast(lang.get_localised(-1974706693))
            return
        end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        local passenger = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -2))
        if vehicle == 0 then
            toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
            return 
        end
        if hijack_veh_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                hijack_veh_notif = false
            end
        end
        pos.z -= 50
        if not IS_PED_A_PLAYER(GET_PED_IN_VEHICLE_SEAT(vehicle, -1)) then
            toast("劫持成功 :D")
            return 
        end
        spawned_ped = CREATE_RANDOM_PED(pos)
        SET_ENTITY_INVINCIBLE(spawned_ped, true)
        --SET_ENTITY_VISIBLE(spawned_ped, false)
        SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(spawned_ped, true)
        TASK_ENTER_VEHICLE(spawned_ped, vehicle, 1000, -1, 1.0, (1 << 1) | (1 << 3) | (1 << 4) | (1 << 9))
        SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, pid, true)
        entities.give_control_by_handle(spawned_ped, pid)
        if GET_SEAT_PED_IS_IN(spawned_ped)!= -1 then
            repeat
                time += 1 
                if GET_IS_TASK_ACTIVE(ped, 2) and GET_SEAT_PED_IS_IN(spawned_ped) == -1 then
                    repeat
                        yield()
                    until not GET_IS_TASK_ACTIVE(ped, 2)
                end
                if time > 300 and GET_SEAT_PED_IS_IN(spawned_ped) != -1 then
                    toast($"劫持失败 {players.get_name(pid)}载具 :/")
                    DeletePed(spawned_ped)
                    time = 0
                    break 
                end
                yield()
            until GET_SEAT_PED_IS_IN(spawned_ped) == -1
        end
        if GET_SEAT_PED_IS_IN(spawned_ped) == -1 then
            TASK_VEHICLE_DRIVE_WANDER(spawned_ped, vehicle, 9999.0, 6) 
            toast("劫持成功 :D")
            if not GET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, pid) then
                SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, pid, true)
            end
        end
        yield(1000)
        if not GET_IS_TASK_ACTIVE(spawned_ped) then
            repeat
                TASK_VEHICLE_DRIVE_WANDER(spawned_ped, vehicle, 9999.0, 786468) -- giving task again cus doesnt work sometimes
                yield()
            until GET_IS_TASK_ACTIVE(spawned_ped, 151)
        end
        yield(5000)
        if spawned_ped != nil and not IS_PED_IN_ANY_VEHICLE(spawned_ped, false) then -- 2nd check cus sometimes doesnt delete the first time
            DeletePed(spawned_ped)
        end
    end)

    local time = 0
    local drag_notif = true
    griefing:action("载具劫持", {"vehiclekick"}, "在对方载具生成一个NPC把玩家挤出", function()
        if pid == players.user() then 
            toast(lang.get_localised(-1974706693))
            return
        end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        local passenger = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -2))
        local seat = GET_SEAT_PED_IS_IN(ped)
        if vehicle == 0 then
            toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
            return 
        end
        if drag_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                drag_notif = false
            end
        end
        pos.z -= 50
        spawned_ped = CREATE_RANDOM_PED(pos)
        entities.set_can_migrate(spawned_ped, false)
        SET_ENTITY_INVINCIBLE(spawned_ped, true)
        --SET_ENTITY_VISIBLE(spawned_ped, false)
        SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(spawned_ped, true)
        SET_PED_CONFIG_FLAG(spawned_ped, 366, true)
        TASK_ENTER_VEHICLE(spawned_ped, vehicle, 1000, seat, 1.0, (1 << 1) | (1 << 3) | (1 << 4) | (1 << 9))
        if GET_SEAT_PED_IS_IN(spawned_ped)!= -1 then
            repeat
                time += 1 
                if GET_IS_TASK_ACTIVE(ped, 2) and GET_SEAT_PED_IS_IN(spawned_ped) == seat then
                    repeat
                        yield()
                    until not GET_IS_TASK_ACTIVE(ped, 2)
                end
                if time > 300 and GET_SEAT_PED_IS_IN(spawned_ped) != seat then
                    toast($"劫持失败 {players.get_name(pid)} 载具 :/")
                    DeletePed(spawned_ped)
                    time = 0
                    break 
                end
                yield()
            until GET_SEAT_PED_IS_IN(spawned_ped) == seat
            DeletePed(spawned_ped)
            time = 0
        end
    end)
    
    local time = 0
    local seat = 0
    local seat_notif = true
    griefing:action("载具劫持", {"seatkick"}, "产生NPC拖出目标然后传送自己控制载具", function()
        if pid == players.user() then 
            toast(lang.get_localised(-1974706693))
            return
        end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        local passenger = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -2))
        local seat = GET_SEAT_PED_IS_IN(ped)
        if vehicle == 0 then
            toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
            return 
        end
        if seat_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                seat_notif = false
            end
        end
        pos.z -= 50
        spawned_ped = CREATE_RANDOM_PED(pos)
        entities.set_can_migrate(spawned_ped, false)
        SET_ENTITY_INVINCIBLE(spawned_ped, true)
        --SET_ENTITY_VISIBLE(spawned_ped, false)
        SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(spawned_ped, true)
        SET_PED_CONFIG_FLAG(spawned_ped, 366, true)
        TASK_ENTER_VEHICLE(spawned_ped, vehicle, 1000, seat, 1.0, (1 << 1) | (1 << 3) | (1 << 4) | (1 << 9))
        if GET_SEAT_PED_IS_IN(spawned_ped)!= -1 then
            repeat
                time += 1 
                if GET_IS_TASK_ACTIVE(ped, 2) and GET_SEAT_PED_IS_IN(spawned_ped) == seat then
                    repeat
                        yield()
                    until not GET_IS_TASK_ACTIVE(ped, 2)
                end
                if time > 300 and GET_SEAT_PED_IS_IN(spawned_ped) != seat then
                    toast($"劫持失败 {players.get_name(pid)} 载具 :/")
                    DeletePed(spawned_ped)
                    time = 0
                    break 
                end
                yield()
            until GET_SEAT_PED_IS_IN(spawned_ped) == seat
            if GET_SEAT_PED_IS_IN(spawned_ped) == seat then
                DeletePed(spawned_ped)
                repeat
                    if seat > 250 then
                        toast("劫持失败 :/")
                        seat = 0
                        break
                    end
                    SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, seat)
                    seat += 1
                until GET_SEAT_PED_IS_IN(players.user_ped()) == seat or GET_VEHICLE_PED_IS_IN(players.user_ped(), false) == vehicle
                toast($"劫持成功 {players.get_name(pid)} 驾驶载具 :D")
                seat = 0
            end
        end
    end)
    

    local takeover_timer = 0
    local takeover_notif = true
    local tp = false
    griefing:action("接管载具", {"takeover"}, "产生NPC抢车 然后接管 网络不好可能无效", function()
        if pid == players.user() then 
            toast(lang.get_localised(-1974706693))
            return
        end
        local otr = menu.ref_by_path("Online>Off The Radar")
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local local_pos = players.get_position(players.user())
        local pos = players.get_position(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local cam_pos = players.get_cam_pos(pid)
        local ped_dist = v3.distance(players.get_position(players.user()), players.get_position(pid))
        if vehicle == 0 then
            toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
            return 
        end
        if takeover_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                takeover_notif = false
            end
        end
        pos.z -= 50
        if ped_dist > 100.0 then
            otr.value = true
            FREEZE_ENTITY_POSITION(players.user_ped(), true)
            SET_ENTITY_VISIBLE(players.user_ped(), false)
            SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), cam_pos, false, false, false)
            tp = true
        end
        spawned_ped = CREATE_RANDOM_PED(pos)
        --SET_ENTITY_VISIBLE(spawned_ped, false)
        SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(spawned_ped, true)
        TASK_ENTER_VEHICLE(spawned_ped, vehicle, 1000, -1, 1.0, (1 << 1) | (1 << 3) | (1 << 4) | (1 << 9))
        entities.give_control_by_handle(spawned_ped, pid)
        if GET_SEAT_PED_IS_IN(spawned_ped) != -1 then
            repeat
                local cam_pos = players.get_cam_pos(pid)
                SET_PED_INTO_VEHICLE(spawned_ped, vehicle, -1)
                if tp then
                    SET_ENTITY_COLLISION(players.user_ped(), false, false)
                    SET_ENTITY_VISIBLE(players.user_ped(), false)
                    SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), cam_pos, false, false, false)
                end
                if GET_IS_TASK_ACTIVE(ped, 2) then
                    takeover_timer = 0
                end
                if takeover_timer > 250 then
                    if DECOR_GET_INT(vehicle, "Player_Vehicle") != 0 then
                        toast("载具有权限 拉出失败 :/")
                    else 
                        toast("无法拖出 :/")
                    end
                    if tp then
                        FREEZE_ENTITY_POSITION(players.user_ped(), false)
                        SET_ENTITY_COLLISION(players.user_ped(), true, true)
                        SET_ENTITY_VISIBLE(players.user_ped(), true)
                        SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), local_pos, false, false, false)
                        tp = false
                    end
                    otr.value = false
                    DeletePed(spawned_ped)
                    takeover_timer = 0
                    return
                end
                takeover_timer +=1 
                yield()
            until GET_SEAT_PED_IS_IN(spawned_ped) == -1
            DeletePed(spawned_ped)
        end
        takeover_timer = 0
        SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -1)
        repeat
            if not IS_PED_IN_ANY_VEHICLE(ped, false) and GET_SEAT_PED_IS_IN(ped) != -1 then
                if takeover_timer > 250 then
                    if DECOR_GET_INT(vehicle, "Player_Vehicle") != 0 then
                        toast("载具有权限 驾驶失败 :/")
                    else 
                        toast("无法驾驶:/")
                    end
                    if tp then
                        SET_ENTITY_COLLISION(players.user_ped(), true, true)
                        FREEZE_ENTITY_POSITION(players.user_ped(), false)
                        SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), local_pos, false, false, false)
                        SET_ENTITY_VISIBLE(players.user_ped(), true)
                        tp = false
                    end
                    otr.value = false
                    DeletePed(spawned_ped)
                    takeover_timer = 0
                    return
                end
                SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -1)
                takeover_timer +=1
            end
            yield()
        until GET_VEHICLE_PED_IS_IN(players.user_ped(), false) == vehicle
        SET_ENTITY_COLLISION(players.user_ped(), true, true)
        FREEZE_ENTITY_POSITION(players.user_ped(), false)
        SET_ENTITY_VISIBLE(players.user_ped(), true)
        otr.value = false
        toast("劫持成功 :D")
        takeover_timer = 0
    end)
    
    local lock_notif = true
    griefing:action("载具上锁", {""}, "", function()
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        if pid == players.user() then 
            toast(lang.get_localised(-1974706693))
            return
        end

        if not IS_PED_IN_ANY_VEHICLE(ped, false) then
            toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
            return 
        end

        if lock_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                lock_notif = false
            end
        end
        GetControlOfEntity(vehicle)
        SET_VEHICLE_DOORS_LOCKED(vehicle, 4)
    end)

    local lockon
    lockon = griefing:toggle_loop("载具声音", {"lockon"}, "仅适用于特定载具 例如武装载具", function()
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_IN(ped, false)
        if not IS_PED_IN_ANY_VEHICLE(ped, false) then
            toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
            lockon.value = false
            return 
        end

        SET_VEHICLE_HOMING_LOCKEDONTO_STATE(vehicle, 1)
    end)
    
    local boost_veh
    local boost_notif = true
    boost_veh = player_toggle_loop(griefing, pid, "载具加速", {"boost"}, "", function()
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if not IS_PED_IN_ANY_VEHICLE(ped, false) then
            toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
            boost_veh.value = false
            return 
        end
        if boost_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                boost_notif = false
            end
        end
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local mdl = joaat("stt_prop_track_speedup")
        util.request_model(mdl)
        if boostpad == nil or not DOES_ENTITY_EXIST(boostpad) then
            boostpad = entities.create_object(mdl, GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 0.0, 5.0, -3.0))
            SET_ENTITY_VISIBLE(boostpad, false)
            SET_OBJECT_SPEED_BOOST_AMOUNT(boostpad, 100)
            entities.set_can_migrate(boostpad, false)
        end
        yield(500)
        SET_ENTITY_COORDS_NO_OFFSET(boostpad, GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 0.0, GET_ENTITY_SPEED(vehicle)/2, -3.0), false, false, false)
        SET_ENTITY_HEADING(boostpad, GET_ENTITY_HEADING(vehicle) - 90)
    end, function()
        if boostpad != nil then
            entities.delete(boostpad)
        end
    end)
    
    local slowdown_veh
    local slow_notif = true
    slowdown_veh = player_toggle_loop(griefing, pid, "载具减速", {"slowdown"}, "", function()
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if not IS_PED_IN_ANY_VEHICLE(ped, false) then
            toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
            slowdown_veh.value = false
            return 
        end
        if slow_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                slow_notif = false
            end
        end
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local mdl = joaat("stt_prop_track_slowdown")
        util.request_model(mdl)
        if brakepad == nil or not DOES_ENTITY_EXIST(brakepad) then
            brakepad = entities.create_object(mdl, GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 0.0, 5.0, -3.0))
            SET_ENTITY_VISIBLE(brakepad, false)
            entities.set_can_migrate(brakepad, false)
        end
        yield(500)
        SET_ENTITY_COORDS_NO_OFFSET(brakepad, GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 0.0, GET_ENTITY_SPEED(vehicle)/2, -3.0), false, false, false)
        SET_ENTITY_HEADING(brakepad, GET_ENTITY_HEADING(vehicle) - 90)
    end, function()
        if brakepad != nil then
            entities.delete(brakepad)
        end
    end)

    local launch_player
    local launch_notif = true
    launch_player = player_toggle_loop(griefing, pid, "发射玩家", {"launch"}, "适用于大多数菜单", function()
        if launch_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                launch_notif = false
            end
        end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local mdl = joaat("mule5")
        local pos = players.get_position(pid)
        util.request_model(mdl)
                    
        mule_veh = entities.create_vehicle(mdl, GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 1.0, -3.0), GET_ENTITY_HEADING(ped))
        entities.set_can_migrate(mule_veh, false)
        SET_ENTITY_VISIBLE(mule_veh, false)
        yield(250)
        APPLY_FORCE_TO_ENTITY(mule_veh, 1, 0.0, 0.0, 1000.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        yield(2500)
        entities.delete(mule_veh)
        repeat
            yield()
        until GET_ENTITY_SPEED(ped) < 30.0
    end, function()
        if mule_veh != 0 and DOES_ENTITY_EXIST(mule_veh) then 
            entities.delete(mule_veh)
        end
    end)
    local vent = {}
    local stumble_notif = true
    player_toggle_loop(griefing, pid, "摔倒玩家", {"stumble"}, "", function()
        if stumble_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                stumble_notif = false
            end
        end
        local mdl = joaat("prop_roofvent_06a")
        local pos = players.get_position(pid)
        pos.z -= 2.4
        util.request_model(mdl)
        local temp_v3 = v3.new(0, 0, 0)
        local middle_vent = entities.create_object(mdl, v3(pos.x, pos.y, pos.z))
        SET_ENTITY_VISIBLE(middle_vent, false)
        for i = 1, 4 do
            local angle = (i / 4) * 360
            temp_v3.z = angle
            local obj_pos = temp_v3:toDir()
            obj_pos:mul(1.25)
            obj_pos:add(pos)
            vent[i] = entities.create_object(mdl, obj_pos)
            SET_ENTITY_VISIBLE(vent[i], false)
        end
        yield(500)
        entities.delete(middle_vent)
        for vent as obj do
            entities.delete(obj)
        end
    end)

    local black_smoke
    local smoke_notif = true
    black_smoke = player_toggle_loop(griefing, pid, "乌烟瘴气", {"smoke"}, "用黑烟填满对方的屏幕", function() 
        if smoke_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                smoke_notif = false
            end
        end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        REQUEST_NAMED_PTFX_ASSET("scr_as_trans")
        USE_PARTICLE_FX_ASSET("scr_as_trans")
        if ptfx == nil or not DOES_PARTICLE_FX_LOOPED_EXIST(ptfx) then
            ptfx = START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY("scr_as_trans_smoke", ped, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, false, false, false, 0, 0, 0, 255)
        end
    end, function()
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        REMOVE_PARTICLE_FX(ptfx)
        REMOVE_NAMED_PTFX_ASSET("scr_as_trans")
    end)
    
    local gravity = griefing:list("玩家引力", {}, "适用于所有菜单 会被检测到 对无敌玩家无效")
    local force = 1.00
    menu.slider_float(gravity, "引力值", {"force"}, "", 0, 100, 100, 10, function(value)
        force = value / 100
    end)
 
    local gravitate
    local gravitate_notif = true
    gravitate = player_toggle_loop(gravity, pid, "启用", {"gravitate"}, "", function()
        if gravitate_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                gravitate_notif = false
            end
        end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_IN(ped)

        if IS_PLAYER_IN_INTERIOR(pid) and players.is_godmode(pid) and (not NETWORK_IS_PLAYER_FADING(pid) and IS_ENTITY_VISIBLE(ped)) and GET_SPAWN_STATE(pid) != 0 then
            toast($"{players.get_name(pid)} 无敌 :/")
            gravitate.value = false
        util.stop_thread() end
        
        ADD_EXPLOSION(players.get_position(pid), 29, force, false, true, 0.0, true)
    end)
    
    local attacker_root = griefing:list("自杀小队")
    local spawn_root = attacker_root:list("生成")
    attacker_root:divider("Meta")
    local attacker_mdl = joaat("s_m_y_clown_01")
    spawn_root:list_select("模型", {"pedmdl"}, "", attackers.names, 1, function(index)
        attacker_mdl = joaat(attackers.mdl[index])
    end)

    local immortality = false
    attacker_root:toggle("无敌", {}, "", function(toggled)
        immortality = toggled
    end)

    local detonate_dist = 5.00
    attacker_root:slider_float("范围", {"detonatedistance"}, "", 0, 1000, 500, 100, function(value)
        detonate_dist = value / 100
    end)

    spawn_root:action("发送", {"bomb"}, "", function()
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local dict = "swimming@scuba"
        local name = "dive_glide"
        RequestAnimation(dict)
        util.request_model(attacker_mdl)
        pos.x += 15
        pos.y += math.random(-25, 25)
        if attacker == nil or not DOES_ENTITY_EXIST(attacker) then
            attacker = entities.create_ped(26, attacker_mdl, pos, 0)
            SET_ENTITY_INVINCIBLE(attacker, immortality)
            SET_PED_CAN_RAGDOLL(attacker, false)
            SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(attacker, true)
            entities.set_can_migrate(attacker, false)
            TASK_PLAY_ANIM(attacker, dict, name, 5.0, 2.5, -1, 1|16|32, 1.0, false, false, false)
            repeat
                TASK_GO_TO_ENTITY(attacker, ped,  -1, 1,  500.0, 0.0, 0)
                local pos = players.get_position(pid)
                local ped_pos = v3.distance(GET_ENTITY_COORDS(attacker), pos)
                yield(100)
            until ped_pos < detonate_dist
            SET_ENTITY_INVINCIBLE(attacker, false)
            ADD_EXPLOSION(GET_ENTITY_COORDS(attacker), 82, 10000.0, true, false, 1.0, false)
            yield(1000)
            entities.delete(attacker)
        elseif DOES_ENTITY_EXIST(attacker) and IS_PLAYER_DEAD(attacker) then
            entities.delete(attacker)
        else
            toast("自杀小队参上 :/")
        end
    end)

    attacker_root:action("删除", {}, "", function()
        if attacker == nil or not DOES_ENTITY_EXIST(attacker) then
            toast("无自杀小队 :/")
            return 
        end
        entities.delete(attacker)
    end)
    
    griefing:toggle_loop("干扰锁定", {}, "将在地图下方产生随机照明弹 使制导导弹朝随机方向发射", function()
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        if IS_PED_SHOOTING(ped) and IS_PED_ARMED(ped, 2) then
            SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x + math.random(-50, 50), pos.y + math.random(-50, 50), pos.z - 2, pos.x, pos.y, pos.z, 0, true, joaat("weapon_flaregun"), players.user_ped(), true, false, 0.0)
        end
    end)
    
    griefing:toggle_loop("反火箭炮", {}, "将使他们的火箭炮掉头并瞄准自己", function()
        local things = {-0.1, 0.1}
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local pos1 = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, things[math.random(#things)], -15.0, -2.0)
        local pos2 = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.0, 0.0)
        if IS_PED_SHOOTING(ped) and IS_PED_ARMED(ped, 2) then
            SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos1, pos2, 0, true, joaat("weapon_flaregun"), players.user_ped(), true, false, 0.0)
            yield(2500)
            CLEAR_AREA_OF_PROJECTILES(pos, 25.0, 0)
        end
    end)
    
    griefing:toggle_loop("黑屏加载", {}, "", function()
        local handle = NETWORK_HASH_FROM_PLAYER_HANDLE(pid)
        util.trigger_script_event(1 << pid, {-1604421397, players.user(), 1, 4, handle, handle, handle, handle, 1, 1})
        yield(10000)
    end)
     
    griefing:toggle_loop("动画循环", {}, "", function()
        local handle = NETWORK_HASH_FROM_PLAYER_HANDLE(pid)
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        util.trigger_script_event(1 << pid, {-1604421397, players.user(), math.random(0, 114), 4, handle, handle, handle, handle, 1, 1})
        repeat
            yield()
        until IS_ENTITY_VISIBLE(ped)
    end)

    griefing:action("发送动画", {"dm"}, "发送到在线模式新手动画", function()
        if StandUser(pid) then toast(stand_notif) util.stop_thread() end
        local int = memory.read_int(memory.script_global(1895156 + 1 + (pid * 609) + 511)) --Global_1895156[PLAYER::PLAYER_ID() /*609*/].f_511;
        util.trigger_script_event(1 << pid, {-366707054, players.user(), 20, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1757622014, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
     end)

    local tp_timer1 = 0
    griefing:action("发送动画", {}, "发送上岛动画", function()
        menu.trigger_commands($"ceojoin {players.get_name(pid)} on") 
        repeat
            if tp_timer1 > 10 then
                return
            end
            tp_timer1 += 1
            yield(1000)
        until players.get_boss(players.user()) != -1
        local pos = players.get_position(players.user())
        local player_pos = players.get_position(pid)
        SET_ENTITY_VISIBLE(players.user_ped(), false)
        yield(100)
        for i   = 0, 10 do
            SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), player_pos, false, false, false)
            util.trigger_script_event(1 << pid, {1669592503, players.user(), 0, 0, 5, 1})
            yield(100)
        end
        SET_ENTITY_VISIBLE(players.user_ped(), true)
        SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), pos, false, false, false)
        menu.trigger_commands($"ceojoin {players.get_name(pid)} off")
    end)
    
    local jobs = griefing:list("发送活动")
    local activities = {
       [192] = "飞镖",
       [193] = "高尔夫",
    }
    
    for id, name in activities do
       jobs:action(name, {}, "强迫活动", function()
           if StandUser(pid) then toast(stand_notif) return end
           local int = memory.read_int(memory.script_global(1895156 + 1 + (pid * 609) + 511))
           util.trigger_script_event(1 << pid, {-366707054, players.user(), id, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
           util.trigger_script_event(1 << pid, {1757622014, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
       end)
    end
    
    griefing:action("强制死斗", {"1v1"}, "迫使对方进入1v1模式", function()
       if StandUser(pid) then toast(stand_notif) return end
       local int = memory.read_int(memory.script_global(1895156 + 1 + (pid * 609) + 511))
       util.trigger_script_event(1 << pid, {-366707054, players.user(), 197, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
       util.trigger_script_event(1 << pid, {1757622014, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    griefing:toggle_loop("载具上锁", {"vehiclelock"}, "", function()
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_TRYING_TO_ENTER(ped)
        if not GET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, pid) then
            SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, pid, true)
        end
    end)

    local disable_accel_notif = true
    griefing:toggle_loop("禁用加速", {}, "", function(toggled)
        if disable_accel_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                disable_accel_notif = false
            end
        end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local top_speed = GET_VEHICLE_MODEL_ESTIMATED_MAX_SPEED(vehicle)
        
        if not IS_PED_IN_ANY_VEHICLE(ped, false) then
            toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
            return 
        end
        GetControlOfEntity(vehicle)
        SET_VEHICLE_MAX_SPEED(vehicle, 0.1)
    end)

    local flip_notif = true
    griefing:action("载具倒置", {"flip"}, "", function()
        if flip_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                flip_notif = false
            end
        end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local rot = GET_ENTITY_ROTATION(vehicle, 2)
        rot.x = 180

        if not IS_PED_IN_ANY_VEHICLE(ped, false) then
            toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
            return 
        end
        GetControlOfEntity(vehicle)
        SET_ENTITY_ROTATION(vehicle, rot, 2, false)
    end)

    local spinbot_notif = true
    player_toggle_loop(griefing, pid, "载具旋转", {"spin"}, "", function()
        if spinbot_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                spinbot_notif = false
            end
        end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local height = GET_ENTITY_HEIGHT_ABOVE_GROUND(vehicle)

        if not IS_PED_IN_ANY_VEHICLE(ped, false) then
            toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
            return 
        end
        GetControlOfEntity(vehicle)
        if height < 5.0 and height > 0.1 then
            SET_VEHICLE_ON_GROUND_PROPERLY(vehicle)
        end
        if vehicle != 0 and not IS_PLAYER_DEAD(ped) then
            APPLY_FORCE_TO_ENTITY(vehicle, 5, 0.0, 0.0, 500.0, 0, 0, 0, 0, true, false, true, false, true)
        end
    end)

    local hospitalize_count = 0
    local hospitalize_notif = true
    griefing:action("击杀对方", {"hospitalize"}, "", function()
        if hospitalize_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290))
                hospitalize_notif = false
            end
        end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        SetBit(memory.script_global(2657704 + 1 + (players.user() * 463) + 424), 0)
        repeat 
            yield()
        until memory.read_int(memory.script_global(2657704 + 1 + (players.user() * 463) + 424), 0)
        menu.trigger_commands($"kill {players.get_name(pid)}")
        if not IS_PLAYER_DEAD(ped) then
            repeat
                hospitalize_count += 1
                if hospitalize_count >= 300 then
                    toast("对方没死 :/")
                    ClearBit(memory.script_global(2657704 + 1 + (players.user() * 463) + 424), 0)
                    hospitalize_count = 0
                    return
                end
                yield()
            until IS_PLAYER_DEAD(ped)
        end
        if IS_PLAYER_DEAD(ped) then
            repeat
                yield()
            until not IS_PLAYER_DEAD(ped)
            ClearBit(memory.script_global(2657704 + 1 + (players.user() * 463) + 424), 0)
            hospitalize_count = 0
        end
    end)

    local attack
    attack = player_toggle_loop(griefing, pid, "武装路人", {}, "让附近的路人攻击对方", function()
        local target = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for players.list_except() as id do
            local ped = GET_PLAYER_PED_SCRIPT_INDEX(id)
            for entities.get_all_peds_as_handles() as npc do
                if npc != ped and npc != players.user_ped() then
                    TASK_COMBAT_PED(npc, target, 67108864, 16)
                    if not IS_PED_ARMED(npc, 7) and not IS_PED_A_PLAYER(npc) then
                        local weapon_type = attack_weapons[math.random(#attack_weapons)]
                        GIVE_WEAPON_TO_PED(npc, weapon_type, 9999, false, true)
                        SET_PED_ACCURACY(npc, 100)
                    end
                    yield()
                end
            end
        end
    end)

    griefing:action("套上水怪", {"lochnessmk2"}, "尼斯湖水怪 Mk2", function()
        local pos = players.get_position(pid)
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_IN(ped, false)
        local veh_class = GET_VEHICLE_CLASS(vehicle)
        if players.get_vehicle_model(pid) != joaat("oppressor2") then
            toast("对方没驾驶mk2 :/")
            return
        end
        local monster = joaat("h4_prop_h4_loch_monster")
        util.request_model(monster)
        obj = entities.create_object(monster, pos)
        SET_ENTITY_COLLISION(obj, false, false)
        ATTACH_ENTITY_TO_ENTITY(obj, vehicle, 0, -0.25, -1.0, 1.0, 0.0, 0.0, -90.0, true, false, false, false, 0, true)
    end)

    griefing:action( "套汉堡包", {"hamburger"}, "麦香堡", function()
        local pos = players.get_position(pid)
        pos.z -= 0.50
        local whopper = joaat("xs_prop_hamburgher_wl")
        util.request_model(whopper)
        local hamburger = entities.create_object(whopper, pos)
        entities.set_can_migrate(hamburger, false)
        yield(60000)
        entities.delete(hamburger)
    end)
    
    griefing:toggle("套汉堡车", {"pattywagon"}, "", function(toggled)
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        pos.z -= 0.50
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local whopper = joaat("xs_prop_hamburgher_wl")
        util.request_model(whopper)
        if toggled then
            if IS_PED_IN_ANY_VEHICLE(ped, false) then
                hamburger = entities.create_object(whopper, pos)
                SET_ENTITY_COLLISION(hamburger, false, true)
                entities.set_can_migrate(hamburger, false)
                ATTACH_ENTITY_TO_ENTITY(hamburger, vehicle, 0, 0, 0, -0.50, 0, 0, 0, false, false, true, false, 0, false, 0)
            end
        else
            if hamburger == nil or not DOES_ENTITY_EXIST(hamburger) then
                toast("汉堡包消失 :/")
                return
            end
            entities.delete(hamburger)
        end
    end)
    
    local radio = griefing:list("更改电台", {}, "")
    local stations = {}
    for station, name in station_name do
        stations[#stations + 1] = station
    end
    local radio_notif = true
    radio:list_action("电台", {}, "", stations, function(index, value)
        if radio_notif then
            if StandUser(pid) then
                toast(lang.get_localised(1729001290)) 
                radio_notif = false
            end
        end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(players.user())
        local vehicle = GET_VEHICLE_PED_IS_IN(ped)

        if not IS_PED_IN_ANY_VEHICLE(ped, false) then
            toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
            return 
        end

        local radio_name = station_name[value]
        if IS_PED_IN_ANY_VEHICLE(ped, false) then 
            if not ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
                toast("无法切换电台 :/")
                return 
            end
            NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
            if not IS_PED_IN_VEHICLE(players.user_ped(), vehicle, false) then
                SET_ENTITY_VISIBLE(players.user_ped(), false)
                menu.trigger_commands($"tpveh {players.get_name(pid)}")
                yield(250)
                SET_VEH_RADIO_STATION(vehicle, radio_name)
                yield(750)
                SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), pos, false, false, false)
            else
                yield(250)
                SET_VEH_RADIO_STATION(vehicle, radio_name)
            end
        end
    end)
    

    local control_veh
    local control_veh_notif = true
    control_veh = player_toggle_loop(griefing, pid, "乱打方向", {}, "只对正常的载具生效", function(toggle)
        if control_veh_notif then
            if StandUser(pid) then 
                toast(lang.get_localised(1729001290)) 
                control_veh_notif = false
            end
        end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local vehicle = GET_VEHICLE_PED_IS_IN(ped)
        local veh_class = GET_VEHICLE_CLASS(vehicle)
        if not players.exists(pid) then util.stop_thread() end

        if not DOES_ENTITY_EXIST(ped) or not IS_PED_IN_ANY_VEHICLE(ped, false) then
            toast($"{players.get_name(pid)} 太远或不在载具里 :/")
            control_veh.value = false
        util.stop_thread() end

        if veh_class == 15 then
            toast($"{players.get_name(pid)} 在直升机上 :/")
            control_veh.value = false
        util.stop_thread() end
        
        if veh_class == 16 then
            toast($"{players.get_name(pid)} 在飞机上 :/")
            control_veh.value = false
        util.stop_thread() end

        if IS_PED_IN_ANY_VEHICLE(ped, false) then
            FREEZE_ENTITY_POSITION(players.user_ped(), true)
            if IS_CONTROL_PRESSED(0, 34) then
                while not IS_CONTROL_RELEASED(0, 34) do
                    TASK_VEHICLE_TEMP_ACTION(ped, GET_VEHICLE_PED_IS_IN(ped), 7, 100)
                    yield()
                end
            elseif IS_CONTROL_PRESSED(0, 35) then
                while not IS_CONTROL_RELEASED(0, 35) do
                    TASK_VEHICLE_TEMP_ACTION(ped, GET_VEHICLE_PED_IS_IN(ped), 8, 100)
                    yield()
                end
            elseif IS_CONTROL_PRESSED(0, 32) then
                while not IS_CONTROL_RELEASED(0, 32) do
                    TASK_VEHICLE_TEMP_ACTION(ped, GET_VEHICLE_PED_IS_IN(ped), 23, 100)
                    yield()
                end
            elseif IS_CONTROL_PRESSED(0, 33) then
                while not IS_CONTROL_RELEASED(0, 33) do
                    TASK_VEHICLE_TEMP_ACTION(ped, GET_VEHICLE_PED_IS_IN(ped), 28, 100)
                    yield()
                end
            end
        else
            toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
            control_veh.value = false
        end
        yield()
    end, function()
        FREEZE_ENTITY_POSITION(players.user_ped(), false)
    end)

    local jesus_tgl = false
    local jesus_ped
    griefing:toggle("耶稣打手", {""}, "", function(toggled)
        if toggled then
            local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local pos = players.get_position(pid)
            local jesus = joaat("u_m_m_jesus_01")
            util.request_model(jesus)
    
            jesus_ped = entities.create_ped(26, jesus, pos, 0)
            SET_ENTITY_INVINCIBLE(jesus_ped, true)
            GIVE_WEAPON_TO_PED(jesus_ped, joaat("WEAPON_RAILGUN"), 9999, true, true)
            SET_PED_HEARING_RANGE(jesus_ped, 9999.0)
            SET_PED_CONFIG_FLAG(jesus_ped, 281, true)
            SET_PED_COMBAT_ATTRIBUTES(jesus_ped, 5, true)
            SET_PED_COMBAT_ATTRIBUTES(jesus_ped, 46, true)
            SET_PED_ACCURACY(jesus_ped, 100.0)
            SET_PED_COMBAT_ABILITY(jesus_ped, 2)
            SET_PED_CAN_RAGDOLL(jesus_ped, false)
            TASK_COMBAT_PED(jesus_ped, ped, 0, 16)
            
            while toggled do
                if IS_PLAYER_DEAD(ped) then
                    repeat
                        yield()
                    until not IS_PLAYER_DEAD(ped)
                    local new_pos = players.get_position(pid)
                    new_pos.y += 2
                    new_pos.z += 1 -- jesus kept sliding for some reason, doing this to prevent that.
                    yield(2500)
                    SET_ENTITY_COORDS_NO_OFFSET(jesus_ped, new_pos, false, false, false)
                    REFILL_AMMO_INSTANTLY(jesus_ped)
                    TASK_COMBAT_PED(jesus_ped, ped, 0, 16)
                end
                yield()
            end
        end
        if jesus_ped != nil then
            entities.delete(jesus_ped)
        end
    end)

    local antigodmode = main:list("反击", {}, "")
    local stun = antigodmode:list("击晕", {}, "对检测到无敌的菜单有效")
    stun:action("署名", {"ownedstun"}, "", function()
        local pos = players.get_position(pid)
        SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 1000, true, joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
    end)

    stun:action("匿名", {"anonstun"}, "", function()
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 1000, true, joaat("weapon_stungun"), false, false, true, 1.0)
    end)
    
    antigodmode:action("压扁", {"yb"}, "挤压对方导致死亡 对方开启不可摔倒可能会无效", function()
        if StandUser(pid) then toast(stand_notif) return end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        local heading =  GET_ENTITY_HEADING(ped)
        local khanjali = joaat("khanjali")
        util.request_model(khanjali)
        distance = 2.5
        if IS_PED_STILL(ped) then
            distance = 0.0
        end

        local vehicle1 = entities.create_vehicle(khanjali, GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, distance, 2.8), heading)
        local vehicle2 = entities.create_vehicle(khanjali, pos, 0)
        local vehicle3 = entities.create_vehicle(khanjali, pos, 0)
        local vehicle4 = entities.create_vehicle(khanjali, pos, 0)
        local spawned_vehs = {vehicle1, vehicle2, vehicle3, vehicle4}
        for spawned_vehs as vehicle do
            entities.set_can_migrate(vehicle, false)
        end
        ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0.0, 0.0, 3.0, 0.0, 0.0, 0.0, -180.0, 0, false, true, false, 0, true)
        ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0.0, 3.0, 3.0, 0.0, 0.0, 0.0, -180.0, 0, false, true, false, 0, true)
        ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0.0, 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, false, true, false, 0, true)
        SET_ENTITY_VISIBLE(vehicle1, false)
        yield(5000)
        for spawned_vehs as vehicle do
            entities.delete(vehicle)
        end
    end) 
    antigodmode:action("地图杀", {"dts"}, "对开启防止地图杀和高延迟的玩家无效", function()
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)                            
        local hash = joaat("prop_windmill_01")
        util.request_model(hash)
        for i = 0, 5 do
            if IS_PED_WALKING(ped) then
                spawn_pos = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.5, 0.0)
            elseif not IS_PED_WALKING(ped) then
                spawn_pos = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 1.3, 0.0)
            else
                spawn_pos = players.get_position(pid)
            end
            local obj = entities.create_object(hash, spawn_pos)
            SET_ENTITY_VISIBLE(obj, false)
            SET_ENTITY_INVINCIBLE(obj, true)
            SET_ENTITY_COLLISION(obj, true, true)
            yield(150)
            entities.delete(obj)
        end
    end)

    local remove_gm
    remove_gm = player_toggle_loop(antigodmode, pid, "移除无敌", {}, lang.get_localised(-748077967), function()
        if StandUser(pid) then
            toast(stand_notif)
            remove_gm.value = false
            util.stop_thread()
        end
        util.trigger_script_event(1 << pid, {800157557, players.user(), 225624744, math.random(0, 9999)})
    end)

    local remove_veh_gm
    remove_veh_gm = player_toggle_loop(antigodmode, pid, "移除载具无敌", {}, lang.get_localised(-748077967), function()
        if StandUser(pid) then
            toast(stand_notif)
            remove_veh_gm.value = false
            util.stop_thread()
        end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_IN(ped, false)
        GetControlOfEntity(vehicle)
        if IS_PED_IN_ANY_VEHICLE(ped, false) and not IS_PLAYER_DEAD(ped) then
            SET_ENTITY_CAN_BE_DAMAGED(vehicle, true)
            SET_ENTITY_INVINCIBLE(vehicle, false)
            SET_ENTITY_PROOFS(vehicle, false, false, false, false, false, 0, 0, false)
        end
    end)

    local tp_player = main:list("传送")
    local interior_tp = tp_player:list("室内传送", {}, lang.get_localised(-748077967))
    local ceo_tp = tp_player:list("CEO传送", {}, lang.get_localised(-748077967))
    local mission_end_tp = tp_player:list("其他传送", {}, lang.get_localised(-748077967))
    for id, name in pairs(tp_locations) do
        mission_end_tp:action(name, {}, "", function()
            local handle = NETWORK_HASH_FROM_PLAYER_HANDLE(pid)
            util.trigger_script_event(1 << pid, {-1604421397, players.user(), id, 4, handle, handle, handle, handle, 1, 1})
        end)
    end
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

    local tp_timer2 = 0
    ceo_tp:action("佩里克岛", {}, "", function()
        menu.trigger_commands($"ceojoin {players.get_name(pid)} on")
        repeat
            if tp_timer2 > 10 then
                return
            end
            tp_timer2 += 1
            yield(1000)
        until players.get_boss(players.user()) != -1
        local pos = players.get_position(players.user())
        local player_pos = players.get_position(pid)
        SET_ENTITY_VISIBLE(players.user_ped(), false)
        yield(100)
        for i   = 0, 10 do
            SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), player_pos, false, false, false)
            util.trigger_script_event(1 << pid, {1669592503, players.user(), 0, 0, 3, 1})
            yield(100)
        end
        SET_ENTITY_VISIBLE(players.user_ped(), true)
        SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), pos, false, false, false)
        menu.trigger_commands($"ceojoin {players.get_name(pid)} off")
    end)

    local tp_timer3 = 0
    ceo_tp:action("佩罗海滩", {}, "", function()
        menu.trigger_commands($"ceojoin {players.get_name(pid)} on") 
        repeat
            if tp_timer3 > 10 then
                return
            end
            tp_timer3 += 1
            yield(1000)
        until players.get_boss(players.user()) != -1
        local pos = players.get_position(players.user())
        local player_pos = players.get_position(pid)
        SET_ENTITY_VISIBLE(players.user_ped(), false)
        yield(100)
        for i   = 0, 10 do
            SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), player_pos, false, false, false)
            util.trigger_script_event(1 << pid, {1669592503, players.user(), 0, 0, 4, 0})
            yield(100)
        end
        SET_ENTITY_VISIBLE(players.user_ped(), true)
        SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), pos, false, false, false)
        menu.trigger_commands($"ceojoin {players.get_name(pid)} off")
    end)

    for id, name in interior_tps do
        interior_tp:action(name, {}, "", function()
            if StandUser(pid) then toast(stand_notif) return end
            util.trigger_script_event(1 << pid, {-1638522928, players.user(), id, 1, 0, 1, 1130429716, -1001012850, 1106067788, 0, 0, 1, 2123789977, 1, -1})
        end)
    end
 
    local misc_player = main:list("其他")
    player_toggle_loop(misc_player, pid, "显示瞄准", {"aimlines"}, "", function()
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local weapon_ent = GET_CURRENT_PED_WEAPON_ENTITY_INDEX(ped, false)
        local weapon_coords = GET_ENTITY_BONE_POSTION(weapon_ent, GET_ENTITY_BONE_INDEX_BY_NAME(weapon_ent, "gun_muzzle"))
        local inst = v3.new()
        v3.set(inst, players.get_cam_rot(pid))
        local tmp = v3.toDir(inst)
        v3.set(inst, v3.get(tmp))
        v3.mul(inst, 1000)
        v3.set(tmp, players.get_cam_pos(pid))
        v3.add(inst, tmp)
        if IS_PLAYER_FREE_AIMING(pid) then
            DRAW_LINE(weapon_coords, inst, 255, 255, 255, 255)
        end
    end)

    local aimbor
    aimbor = player_toggle_loop(misc_player, pid, "间歇自瞄", {"triggerbot"}, "", function()
        if pid == players.user() then 
            toast(lang.get_localised(-1974706693)) 
            aimbor.value = false
        util.stop_thread() end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local wpn = GET_SELECTED_PED_WEAPON(players.user_ped())
        local dmg = ROUND(GET_WEAPON_DAMAGE(wpn, 0))
        local delay = GET_WEAPON_TIME_BETWEEN_SHOTS(wpn)
        local wpnEnt = GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER_PED_ID(), false)
        local wpnCoords = GET_ENTITY_BONE_POSTION(wpnEnt, GET_ENTITY_BONE_INDEX_BY_NAME(wpnEnt, "gun_muzzle"))
        if GET_ENTITY_ALPHA(ped) < 255 then return end
        if IS_PLAYER_FREE_AIMING_AT_ENTITY(players.user(), ped) and not IS_PED_RELOADING(players.user_ped()) then
            boneIndex = bones[math.random(#bones)]
            local pos = GET_PED_BONE_COORDS(ped, boneIndex, 0.0, 0.0, 0.0)
            SHOOT_SINGLE_BULLET_BETWEEN_COORDS(wpnCoords, pos, dmg, true, wpn, players.user_ped(), true, false)
            SET_CONTROL_VALUE_NEXT_FRAME(0, 24, 1.0) -- shooting manually after so it has the effect of you shooting to seem more legit despite there being nothing legit about this
            yield(delay * 1000)
        end
    end)

    player_toggle_loop(misc_player, pid, "载具自瞄", {"vehicleaimbot"}, "载具导弹瞄准玩家", function()
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if not IS_PLAYER_DEAD(ped) and IS_CONTROL_PRESSED(0, 70) then
            SET_VEHICLE_SHOOT_AT_TARGET(players.user_ped(), ped, players.get_position(pid))
        end
    end)

    player_toggle_loop(misc_player, pid, "踢出攻击", {"thinice"}, "自动踢出攻击玩家", function()
        if players.is_marked_as_attacker(pid) then
            menu.trigger_commands($"kick {players.get_name(pid)}")
        end
    end)

    player_toggle_loop(misc_player, pid, "传送驾驶", {"autovehtp"}, "自动传送到玩家载具里", function()
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local veh_model = players.get_vehicle_model(pid)
        local seat_count = GET_VEHICLE_MODEL_NUMBER_OF_SEATS(veh_model)
        if not ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then return end
        if GET_VEHICLE_PED_IS_USING(players.user_ped()) != vehicle then
            for i = 0, seat_count -1 do
                local emptyseat = i
                for l = 1, 25 do
                    SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, emptyseat)
                end
            end
        end
    end)
    --menu.attach_after(menu.ref_by_rel_path(menu.player_root(pid), "Trolling"),
    --menu.link(menu.shadow_root(), griefing))
end

players.on_join(player)
players.dispatch_on_join()

self:toggle_loop("射击修理", {"repairgun"}, "修理你射击的载具", function()
    local target_hptr = memory.alloc_int()
    if GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), target_hptr) then
        local target_entity = memory.read_int(target_hptr)
        if GET_ENTITY_HEALTH(target_entity) == 0 and IS_ENTITY_A_VEHICLE(target_entity) then
            SET_VEHICLE_FIXED(target_entity)
        end
    end
end)

self:toggle("禁用雷达", {"ld"}, "", function(toggled)
    DISPLAY_RADAR(not toggled)
end)

self:toggle_loop("死亡摔倒", {"nodeathragdoll"}, "死亡时禁用不可摔倒功能 让你看着不奇怪", function()
    if not GET_PED_CONFIG_FLAG(players.user_ped(), 227, true) then
        SET_PED_CONFIG_FLAG(players.user_ped(), 227, true)
    end
end, function()
    SET_PED_CONFIG_FLAG(players.user_ped(), 227, false)
end)

self:action("差事传送", {"cs"}, "", function()
    if not IS_WAYPOINT_ACTIVE() then
        toast("无路径点 :/")
        return
    end
    local waypoint = GET_BLIP_INFO_ID_COORD(GET_FIRST_BLIP_INFO_ID(GET_WAYPOINT_BLIP_ENUM_ID()))
    local vehicle = GET_VEHICLE_PED_IS_USING(players.user_ped())
    local ground = false
    repeat
        ground, waypoint.z = util.get_ground_z(waypoint.x, waypoint.y)
        yield()
    until ground
    menu.trigger_commands("invisibility on")
    if vehicle != 0 then
        SET_ENTITY_VISIBLE(vehicle, false)
    end
    SWITCH_TO_MULTI_FIRSTPART(players.user_ped(), 8, 1)
    BEGIN_TEXT_COMMAND_BUSYSPINNER_ON("PM_WAIT")
    END_TEXT_COMMAND_BUSYSPINNER_ON(4)
    repeat
        yield()
    until IS_SWITCH_TO_MULTI_FIRSTPART_FINISHED()
    if vehicle == 0 then
        SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), waypoint, false, false, false)
    else
        SET_ENTITY_VISIBLE(vehicle, false)
        SET_ENTITY_COORDS_NO_OFFSET(vehicle, waypoint, false, false, false)
    end
    SWITCH_TO_MULTI_SECONDPART(players.user_ped())
    ALLOW_PLAYER_SWITCH_OUTRO() 
    repeat
        yield()
    until not IS_PLAYER_SWITCH_IN_PROGRESS()
    if vehicle == 0 then
        NETWORK_FADE_IN_ENTITY(players.user_ped(), true, true)
    else
        NETWORK_FADE_IN_ENTITY(vehicle, true, true)
        NETWORK_FADE_IN_ENTITY(players.user_ped(), true, true)
        SET_ENTITY_VISIBLE(vehicle, true)
    end
    menu.trigger_commands("invisibility off")
    BUSYSPINNER_OFF()
end)

local interior_noclip = self:list("悬浮速度")
local noclip_speed = 1.00
interior_noclip:slider_float("速度值", {"noclipspeed"}, "", 10, 10000, 100, 10, function(value)
    noclip_speed = value / 100
end)

local levitate_multiplier = 1.00
interior_noclip:slider_float("悬浮值", {"noclipspeed"}, "", 10, 10000, 100, 10, function(value)
    levitate_multiplier = value / 100
end)

local noclip_thing
noclip_thing = interior_noclip:toggle_loop("启用", {"interiornoclip"}, "", function()
    local speed_val = menu.ref_by_path("Self>Movement>Levitation>Movement Speed")
    local sprint_val = menu.ref_by_path("Self>Movement>Levitation>Sprint Multiplier")
    if GET_INTERIOR_FROM_PLAYER(players.user()) != 0 then
        menu.trigger_commands($"levitatespeed {noclip_speed}")
        menu.trigger_commands($"levitatesprintmultiplier {levitate_multiplier}")
    else
        if speed_val != speed then
            menu.trigger_commands($"levitatespeed {speed / 100}")
        end
        if sprint_val != sprint then
            menu.trigger_commands($"levitatesprintmultiplier {sprint / 100}")
        end
    end
end, function()
    menu.trigger_commands($"levitatespeed {speed / 100}")
    menu.trigger_commands($"levitatesprintmultiplier {sprint / 100}")
end)


self:toggle("牛鲨睾酮", {"bst2"}, "没有画效和音效", function(toggled)
    SET_PLAYER_WEAPON_DAMAGE_MODIFIER(players.user(), toggled ? 1.44 : 0.72)
    SET_PLAYER_MELEE_WEAPON_DAMAGE_MODIFIER(players.user(), toggled ? 2.0 : 1.0)
    SET_PLAYER_MELEE_WEAPON_DEFENSE_MODIFIER(players.user(), toggled ? 0.5 : 1.0)
end)

self:toggle_loop("快速重生", {"fastrespawn"}, "", function()
    local gwobaw = memory.script_global(2672524 + 1685 + 756) -- Global_2672524.f_1685.f_756
    if IS_PED_DEAD_OR_DYING(players.user_ped()) then
        ANIMPOSTFX_STOP_ALL()
        memory.write_int(gwobaw, memory.read_int(gwobaw) | 1 << 1)
    end
end,
    function()
    local gwobaw = memory.script_global(2672524 + 1685 + 756)
    memory.write_int(gwobaw, memory.read_int(gwobaw) &~ (1 << 1)) 
end)

self:toggle_loop("快速翻滚", {"fastroll"}, "", function()
    STAT_SET_INT(joaat($"mp{util.get_char_slot()}_shooting_ability"), 200, true)
end)

self:toggle_loop("友好路人", {"friendlyai"}, "路人不会针对你", function()
    SET_PED_RESET_FLAG(players.user_ped(), 124, true)
end)

self:toggle_loop("自动接受", {"autoaccept"}, "自动接受加入", function() -- credits to soulreaper for sending me this :D
    local message_hash = GET_WARNING_SCREEN_MESSAGE_HASH()
    local paused = IS_PAUSE_MENU_ACTIVE()
    if message_hash == 15890625 or message_hash == -587688989 and not paused then
        SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1.0)
        yield(50)
    end
end)

audio:toggle("禁用脚步", {"deadsilence"}, "禁用脚步声", function(toggled)
    SET_PED_FOOTSTEPS_EVENTS_ENABLED(players.user_ped(), not toggled)
end)

audio:toggle_loop("禁用提示", {"disablefreemodemusic"}, "禁用由任务或帮派攻击等引起的音效", function()
    if AUDIO_IS_MUSIC_PLAYING() and not NETWORK_IS_ACTIVITY_SESSION() then
        TRIGGER_MUSIC_EVENT("GLOBAL_KILL_MUSIC")
    end
end)

audio:toggle_loop("禁用背景", {"disableambientsounds"}, "禁用背景噪音 例如警报器 远处的喇叭声 手提钻 鸟类 蟋蟀等", function()
    if GET_SPAWN_STATE(players.user()) == 0 then
        STOP_AUDIO_SCENE("CHARACTER_CHANGE_IN_SKY_SCENE")
    return end
    if not IS_AUDIO_SCENE_ACTIVE("CHARACTER_CHANGE_IN_SKY_SCENE") then
        START_AUDIO_SCENE("CHARACTER_CHANGE_IN_SKY_SCENE")
    end
end, function()
    STOP_AUDIO_SCENE("CHARACTER_CHANGE_IN_SKY_SCENE")
end)

audio:toggle("禁用警报", {"disablesirens"}, "", function(toggled)
    DISTANT_COP_CAR_SIRENS(not toggled)
end)

audio:toggle_loop("禁用载具", {"disablevehicleaudio"}, "静音自己之外的所有载具声音 这可能会稍微降低FPS", function()
    for entities.get_all_vehicles_as_handles() as vehicle do
        if vehicle != entities.get_user_vehicle_as_handle() then
            FORCE_USE_AUDIO_GAME_OBJECT(vehicle, "")
        end
        RELEASE_VEH_HANDLE(vehicle)
    end
end)

audio:toggle_loop("禁用对话", {"disablepedspeech"}, "无对话声音", function()
    for entities.get_all_peds_as_handles() as ped do
        if IS_ANY_SPEECH_PLAYING(ped) then
            STOP_CURRENT_PLAYING_SPEECH(ped)
        end
    end
end)

online:toggle("阻止自瞄", {}, "阻止对方使用自瞄锁定你", function(toggled)
    SET_PED_CAN_BE_TARGETTED(players.user_ped(), not toggled)
end)

local reversedMessages = {}
local reverse_msg = false
chat.on_message(function(packet_sender, message_sender, text, team_chat)
    if not reversedMessages[text] and reverse_msg then -- prevent message spam
        chat.send_message(string.reverse(text), false, true, true)
        reversedMessages[text] = {timestamp = os.time()}
    end
end)

online:toggle("复述聊天", {}, "", function(toggled)
    reverse_msg = toggled
end)

local messageTimeout = 5
util.create_tick_handler(function()
    for msg, messageData in reversedMessages do
        if os.time() - messageData.timestamp > messageTimeout then
            reversedMessages[msg] = nil
        end
    end
end)


online:toggle_loop("显示天基", {}, "", function()
    for players.list_except() as pid do
        if IS_PLAYER_USING_ORBITAL_CANNON(pid) then
            local cam = players.get_cam_pos(pid)
            local rot, dir =  v3(), v3()
            local ground = false
            repeat
                ground, cam.z = util.get_ground_z(cam.x, cam.y) 
                if ground then
                    break
                else
                    yield()
                end
            until false
            local cam_dist = v3.distance(cam, players.get_cam_pos(pid))
            DRAW_MARKER(28, cam, rot, dir, 1.0, 1.0, cam_dist, 255, 0, 255, 105, false, false)
        end
    end
end)

online:toggle("幽灵战局", {"ghostsession"}, "在你的战局中创建一个战局 互相不同步 某些Stand功能可能无法使用", function(toggled)
    if toggled then
        NETWORK_START_SOLO_TUTORIAL_SESSION()
    else
        NETWORK_END_TUTORIAL_SESSION()
    end
end)

online:toggle_loop("反击悬赏", {"autoclaimbounties"}, "自动领取自己的赏金", function()
    local bounty = players.get_bounty(players.user())
    if bounty != nil then
        repeat
            menu.trigger_commands("removebounty")
            yield(1000)
            bounty = players.get_bounty(players.user())
        until bounty == nil
        toast("已领取自己的赏金 :D")
    end
end)


local block_orb
block_orb = online:toggle_loop( "封闭室门", {"blockorb"}, "生成物体阻挡对方进入天基炮室", function() -- credit to lance, just cleaned it up a bit.
    local mdl = joaat("h4_prop_h4_garage_door_01a")
    util.request_model(mdl)
    if orb_obj == nil or not DOES_ENTITY_EXIST(orb_obj) then
        orb_obj = entities.create_object(mdl, v3(335.9, 4833.9, -59.0))
        entities.set_can_migrate(orb_obj, false)
        SET_ENTITY_HEADING(orb_obj, 125.0)
        FREEZE_ENTITY_POSITION(orb_obj, true)
        --SET_ENTITY_NO_COLLISION_ENTITY(orb_obj, players.user_ped(), false)
        SET_ENTITY_NO_COLLISION_ENTITY(players.user_ped(), orb_obj, false) -- have to do this both way for collision to be properly avoided between player ped and the object
    end
    yield(50)
end, function()
    if orb_obj != nil then
        entities.delete(orb_obj)
    end
end)

local orb = online:list("反天基炮")
local ghost = orb:list("幽灵")
local ghost_tgl
ghost_tgl = ghost:toggle_loop("总是", {"ghostorb"}, "自动幽灵化使用天基炮的玩家", function()
    for players.list_except() as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local cam_dist = v3.distance(players.get_position(players.user()), players.get_cam_pos(pid))
        if IS_PLAYER_USING_ORBITAL_CANNON(pid) and GET_IS_TASK_ACTIVE(ped, 135) and cam_dist < 400 and cam_dist > 340 then
            toast($"{players.get_name(pid)} 用天基炮瞄准你")
        end
        if IS_PLAYER_USING_ORBITAL_CANNON(pid) then
            SET_REMOTE_PLAYER_AS_GHOST(pid, true)
            repeat
                yield()
            until not IS_PLAYER_USING_ORBITAL_CANNON(pid)
            SET_REMOTE_PLAYER_AS_GHOST(pid, false)
        end
    end
end, function()
    for players.list_except(true) as pid do
        SET_REMOTE_PLAYER_AS_GHOST(pid, false)
    end
end)

local tgl
tgl = ghost:toggle_loop("被瞄准时", {}, "自动幽灵使用天基炮瞄准你的玩家", function()
    if ghost_tgl.value then
        tgl.value = false
        return 
     end
    for players.list_except() as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local cam_dist = v3.distance(players.get_position(players.user()), players.get_cam_pos(pid))
        if IS_PLAYER_USING_ORBITAL_CANNON(pid) and cam_dist < 400 and cam_dist > 340 then
            toast($"{players.get_name(pid)} 天基炮正瞄准你")
            SET_REMOTE_PLAYER_AS_GHOST(pid, true)
        else
            SET_REMOTE_PLAYER_AS_GHOST(pid, false)
        end
    end
end, function()
    for players.list_except(true) as pid do
        SET_REMOTE_PLAYER_AS_GHOST(pid, false)
    end
end)


local annoy = orb:list("干扰", {}, "目标玩家列表中快速显示和删除你的名字")
local orb_delay = 1000
annoy:list_select("延迟", {}, "天基炮使用者看你名字的闪烁速度", {"慢速", "中速", "快速"}, 1, function(index, value)
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
annoy_tgl = annoy:toggle_loop("启用", {}, "", function()
    if ghost_tgl.value then
        annoy_tgl.value = false
        toast("不要同时启用干扰和幽灵 ;)")
        return 
        end
    
    for players.list_except(true) as pid do
       if IS_PLAYER_USING_ORBITAL_CANNON(pid) then
            SET_REMOTE_PLAYER_AS_GHOST(pid, true)
            yield(orb_delay)
            SET_REMOTE_PLAYER_AS_GHOST(pid, false)
            yield(orb_delay)
        else
            SET_REMOTE_PLAYER_AS_GHOST(pid, false)
        end
    end
end, function()
    for players.list_except(true) as pid do
        SET_REMOTE_PLAYER_AS_GHOST(pid, false)
    end
end)

online:toggle_loop("幽灵武装", {"ghostarmedplayers"}, "拥有某种武器的幽灵玩家", function()
    for players.list_except(true) as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if IS_PED_ARMED(ped, 7) or GET_IS_TASK_ACTIVE(ped, 199) or GET_IS_TASK_ACTIVE(ped, 128) 
        or IS_PLAYER_USING_GUIDED_MISSILE(pid) or IS_PLAYER_IN_RC_TANK(pid) or IS_PLAYER_IN_RC_BANDITO(pid) or IS_PLAYER_FLYING_ANY_DRONE(pid) or IS_PLAYER_USING_MISSILE_TURRET(pid) then
            SET_REMOTE_PLAYER_AS_GHOST(pid, true)
        else
            SET_REMOTE_PLAYER_AS_GHOST(pid, false)
        end
    end
end, function()
    for players.list_except(true) as pid do
        SET_REMOTE_PLAYER_AS_GHOST(pid, false)
    end
end)

local honk
honk = online:toggle_loop("载具警报", {"hornycars"}, "附件载具发出警报声", function()
    for entities.get_all_vehicles_as_handles() as vehicle do
        if vehicle != GET_VEHICLE_PED_IS_IN(players.user_ped(), false) and DECOR_GET_INT(vehicle, "Player_Vehicle") == 0 and NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            if not IS_VEHICLE_ALARM_ACTIVATED(vehicle) then
                SET_VEHICLE_ALARM(vehicle, true)
                START_VEHICLE_ALARM(vehicle)
                yield()
            end
        end
        RELEASE_VEH_HANDLE(vehicle)
    end
end, function()
    for entities.get_all_vehicles_as_handles() as vehicle do
        if IS_VEHICLE_ALARM_ACTIVATED(vehicle) then
            SET_VEHICLE_ALARM(vehicle, false)
        end
        RELEASE_VEH_HANDLE(vehicle)
    end
end)

local lock_counter = 0
online:toggle_loop("载具权限", {"accesslockedvehicles"}, "设置为载具使用权没有任何人", function()
    for players.list_except() as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        if GET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, players.user()) and GET_IS_TASK_ACTIVE(players.user_ped(), 160) then
            repeat
                if lock_counter > 250 and not IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) and not GET_IS_TASK_ACTIVE(players.user_ped(), 2) then
                    lock_counter = 0
                    return
                end
                SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, players.user(), false)
                SET_DONT_ALLOW_PLAYER_TO_ENTER_VEHICLE_IF_LOCKED_FOR_PLAYER(pid, false)
                lock_counter += 1
                yield()
            until GET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, players.user())
            lock_counter = 0
        end
    end
end)

online:toggle_loop("阻止劫持", {}, "防止 NPC 载具拖拽", function()
    if not IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then return end
    for entities.get_all_peds_as_handles() as ped do
        SET_PED_CONFIG_FLAG(ped, 342, true)
    end
end)

lobby:action("劫持所有", {"hijackall"}, "劫持全部载具", function()
    for players.list_except(true) as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        if DOES_ENTITY_EXIST(ped) and IS_PED_IN_ANY_VEHICLE(ped, false) then
            menu.trigger_commands($"hijack {players.get_name(pid)}")
        end
    end
end)

lobby:toggle_loop("锁定所有", {"lockall"}, "锁定所有载具", function()
    for players.list_except(true) as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_TRYING_TO_ENTER(ped)
        if not GET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, pid) then
            SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, pid, true)
        end
    end
end)


lobby:toggle_loop("干扰导弹", {"annoy"}, "", function()
    for _, pid in players.list_except() do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        if GET_IS_TASK_ACTIVE(ped, 199) then
            SET_VEHICLE_HOMING_LOCKEDONTO_STATE(vehicle, 1)
        end
    end
end)

lobby:action("套汉堡包", {"hamburgerall"}, "汉堡王", function()
    for players.list_except(true) as pid do
        menu.trigger_commands($"hamburger {players.get_name(pid)}")
    end
end)

lobby:action("套汉堡车", {"pattywagonall"}, "把每个人的载具套上一个汉堡", function()
    for players.list_except(true) as pid do
        menu.trigger_commands($"pattywagon {players.get_name(pid)}")
    end
end)

local lochness_ctr = 0
lobby:action("套上水怪", {"lochnessall"}, "将对方玩家的mk2变成尼斯湖水怪", function()
    for players.list_except(true) as pid do
        if players.get_vehicle_model(pid) == joaat("oppressor2") then
            menu.trigger_commands($"lochnessmk2 {players.get_name(pid)}")
            lochness_ctr += 1
        end
    end
    if lochness_ctr == 0 then
        toast("没有发现mk2 :(")
    end
    lochness_ctr = 0
end)

local horny = lobby:list("击杀招妓")
local horny_counter = 0
horny:toggle_loop("惩治", {}, "杀死试图招妓的好色玩家", function()
    for players.list_except() as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        if memory.read_int(memory.script_global(2657704 + 1 + (pid * 463) + 428)) == 1 then -- Global_2657704[PLAYER::PLAYER_ID() /*463*/].f_428
            repeat
                if horny_counter > 250 then
                    horny_counter = 0
                    return
                end
                menu.trigger_commands($"kill {players.get_name(pid)}")
                yield()
                horny_counter += 1
            until IS_PLAYER_DEAD(ped)
            toast($"击杀 {players.get_name(pid)} 因为太饥渴了")
            horny_counter = 0
        end
    end
end)

horny:toggle_loop("羞辱", {}, "在聊天中取笑对方来羞辱试图招妓的好色玩家", function()
    for players.list_except() as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        if memory.read_int(memory.script_global(2657704 + 1 + (pid * 463) + 428)) == 1 then
            chat.send_message($"{players.get_name(pid)} is horny and about to have sex with a prostitute. Lets make fun of this virgin! HAHA, loser!", false, true, true)
            repeat
                yield()
            until memory.read_int(memory.script_global(2657704 + 1 + (pid * 463) + 428)) == 0
        end
    end
end)

missions:toggle_loop("跳过达克斯冷却", {}, "", function() -- thx icedoomfist for the stat name <3
    STAT_SET_INT(joaat($"mp{util.get_char_slot()}_xm22juggaloworkcdtimer"), -1, true)
end)

missions:action("击杀所有NPC", {}, "", function()
    local counter = 0
    for entities.get_all_peds_as_handles() as ped do
        if GET_BLIP_COLOUR(GET_BLIP_FROM_ENTITY(ped)) == 1 or GET_IS_TASK_ACTIVE(ped, 352) then -- shitty way to go about it but hey, it works (most of the time).
            SET_ENTITY_HEALTH(ped, 0)
            counter += 1
            yield()
        end
    end
    if counter == 0 then
        toast("无NPC :/")
    else
        toast($"击杀 {tostring(counter)} NPC")
    end
end)

missions:action("传送拾取物", {}, "", function()
    local counter = 0
    local pos = players.get_position(players.user())
    for entities.get_all_pickups_as_handles() as pickup do
        SET_ENTITY_COORDS(pickup, pos, false, false, false, false)
        counter += 1
        yield()
    end
    if counter == 0 then
        toast("无拾取物 :/")
    else
        toast($"传送 {tostring(counter)} 拾取物")
    end
end)

weapons:toggle_loop("一枪双发", {"doubletap"}, "打一枪射出两发子弹", function()
    if IS_PED_SHOOTING(players.user_ped()) then
        FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped()) -- very op epic amazing method
    end
end)


weapons:toggle_loop("间歇自瞄", {"triggerbotall"}, "使你对战时不被别人怀疑是自瞄", function()
    local wpn = GET_SELECTED_PED_WEAPON(players.user_ped())
    local dmg = ROUND(GET_WEAPON_DAMAGE(wpn, 0))
    local delay = GET_WEAPON_TIME_BETWEEN_SHOTS(wpn)
    local wpnEnt = GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER_PED_ID(), false)
    local wpnCoords = GET_ENTITY_BONE_POSTION(wpnEnt, GET_ENTITY_BONE_INDEX_BY_NAME(wpnEnt, "gun_muzzle"))
    for players.list_except(true) as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if GET_ENTITY_ALPHA(ped) < 255 then return end
        boneIndex = bones[math.random(#bones)]
        local pos = GET_PED_BONE_COORDS(ped, boneIndex, 0.0, 0.0, 0.0)
        if IS_PLAYER_FREE_AIMING_AT_ENTITY(players.user(), ped) and not IS_PED_RELOADING(players.user_ped()) then
            SHOOT_SINGLE_BULLET_BETWEEN_COORDS(wpnCoords, pos, dmg, true, wpn, players.user_ped(), true, false)
            SET_CONTROL_VALUE_NEXT_FRAME(0, 24, 1.0) -- shooting manually after so it has the effect of you shooting to seem more legit despite there being nothing legit about this
            yield(delay * 1000)
        end
    end
end)

weapons:toggle_loop("绕过锁定", {}, "绕过伊玛尼科技升级", function()
    for players.list_except() as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_IN(ped)
        if not IS_PED_IN_ANY_VEHICLE(ped) then 
            continue 
        end
        if memory.read_byte(entities.handle_to_pointer(vehicle) + 0xA9E) == 0 then
            memory.write_byte((entities.handle_to_pointer(vehicle) + 0xA9E), 1) 
        end
    end
end)

local modifier = 1.00
weapons:slider_float("伤害修改", {"meleedamage"}, "", 100, 1000, 100, 10, function(value)
    modifier = value / 100
    SET_PLAYER_MELEE_WEAPON_DAMAGE_MODIFIER(players.user(), modifier)
end)

weapons:toggle_loop("锁定范围", {}, "导弹锁定范围和自动瞄准设置为最大", function()
    SET_PLAYER_LOCKON_RANGE_OVERRIDE(players.user(), 99999999.0)
end)

weapons:toggle_loop("射程扩展", {}, "将武器射程扩展到 250 米", function()
    if GET_MAX_RANGE_OF_CURRENT_PED_WEAPON(players.user_ped()) < 250.0 then
        SET_PED_RESET_FLAG(players.user_ped(), 95, true)
    else
        SET_PED_RESET_FLAG(players.user_ped(), 95, false)
    end
end)

local weapon_thing = weapons:list("更改子弹", {}, "")
for id, data in weapon_stuff do
    local name = data[1]
    local weapon_name = data[2]
    local toggled = false
    weapon_thing:toggle(name, {}, "", function(toggle)
        toggled = toggle
        while toggled do
            local weapon = LoadWeaponAsset(weapon_name)
            local wpn = GET_SELECTED_PED_WEAPON(players.user_ped())
            local delay = GET_WEAPON_TIME_BETWEEN_SHOTS(wpn)
            local inst = v3.new()
            if IS_DISABLED_CONTROL_PRESSED(0, 24) then
                if not GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER_PED_ID(), memory.addrof(inst)) then
                    v3.set(inst,GET_FINAL_RENDERED_CAM_ROT(2))
                    local tmp = v3.toDir(inst)
                    v3.set(inst, v3.get(tmp))
                    v3.mul(inst, 1000)
                    v3.set(tmp, GET_FINAL_RENDERED_CAM_COORD())
                    v3.add(inst, tmp)
                end
                local x, y, z = v3.get(inst)
                local wpEnt = GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER_PED_ID(), false)
                local wpCoords = GET_ENTITY_BONE_POSTION(wpEnt, GET_ENTITY_BONE_INDEX_BY_NAME(wpEnt, "gun_muzzle"))
                SHOOT_SINGLE_BULLET_BETWEEN_COORDS(wpCoords, x, y, z, 1, true, weapon, PLAYER_PED_ID(), true, false, 1000.0)
                yield(delay * 1000)
            end
            yield()
        end
        local pos = players.get_position(players.user())
        CLEAR_AREA_OF_PROJECTILES(pos, 999999.0, 0)
    end)
end
weapons:toggle_loop("快速切枪", {"fasthands"}, "", function()
    if GET_IS_TASK_ACTIVE(players.user_ped(), 56) then
        FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

weapons:toggle_loop("锁定玩家", {}, "允许使用制导发射器锁定玩家", function()
    for players.list_except() as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        ADD_PLAYER_TARGETABLE_ENTITY(players.user(), ped)
        SET_ENTITY_IS_TARGET_PRIORITY(ped, false, 400.0)    
    end
end, function()
    for players.list_except() as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        REMOVE_PLAYER_TARGETABLE_ENTITY(players.user(), ped)
    end
end)

if menu.get_edition() > 1 then
    weapons:toggle_loop("瞄准透视", {"ts"}, "", function()
        if IS_PLAYER_FREE_AIMING(players.user()) then
            menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Low Latency Rendering"))
        else
            menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Disabled"))
        end
    end, function()
        menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Disabled"))
    end)
end

vehicles:toggle_loop("载具延迟", {"antilag"}, "仅在载具静止时有效 不与其他玩家联网", function()
    local veh = entities.handle_to_pointer(entities.get_user_vehicle_as_handle())
    if veh == 0 then return end
    local gear = entities.get_current_gear(veh)
    local rpm = entities.get_rpm(veh)
    if util.is_key_down(0x20) and util.is_key_down(0x57) then
        entities.set_rpm(veh, 0.9)
        yield(math.random(100, 200))
        entities.set_rpm(veh, 0.0)
    end
end)

local engine_sound = vehicles:list("载具声音", {}, "注意 某些发动机声音可能会影响你的载具加速 发动机或排气等载具升级也会影响声音")
local vehicle_class = {}
local ignore_duplicates = {} 
for util.get_vehicles() as vehicle do
    local name = util.get_label_text(vehicle.name)
    local hash = joaat(vehicle.name)
    local class = GET_VEHICLE_CLASS_FROM_NAME(hash)

    if ignore_class or name == "NULL" or ignore_duplicates[name] or (not IS_THIS_MODEL_A_CAR(hash) and not IS_THIS_MODEL_A_BIKE(hash) and not IS_THIS_MODEL_A_QUADBIKE(hash)) then 
        continue 
    end
    if not vehicle_class[class] then
        vehicle_class[class] = engine_sound:list(util.get_label_text($"VEH_CLASS_{class}"))
    end
    ignore_duplicates[name] = true
    engine_sound.action(vehicle_class[class], name, {$"engine {name}"}, "", function()
        yield(100)
        SET_RADIO_TO_STATION_NAME("OFF") -- the radio kept changing for some reason so this should fix that
        FORCE_USE_AUDIO_GAME_OBJECT(entities.get_user_vehicle_as_handle(), vehicle.name)
        yield(100)
        SET_RADIO_TO_STATION_NAME("OFF") -- sometimes it doesn't turn off
    end)
end

local radio = true
vehicles:toggle_loop("载具电台", {""}, "关闭进入载具时的电台", function()
    if not IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then radio = true return end
    if GET_PLAYER_RADIO_STATION_NAME() != "OFF" and radio then
        yield(100)
        SET_RADIO_TO_STATION_NAME("OFF")
        radio = false
    end
end)

local wheelie = vehicles:list("载具翘起")
local wheelie_val = 0.3
wheelie:slider_float("数值", {"wheeliepower"}, "", 10, 100, 30, 5, function(value)
    wheelie_val = value / 100
end)

wheelie:toggle_loop("启用", {}, "按 Ctrl 和 W 进行翘前轮", function()
    local veh = entities.get_user_vehicle_as_handle()
    if not veh then return end
    local CAutomobile = entities.handle_to_pointer(veh)
    local CHandlingData = memory.read_long(CAutomobile + 0x0918)
    if IS_THIS_MODEL_A_BIKE(players.get_vehicle_model(players.user())) then return end
    if util.is_key_down(0x57) and util.is_key_down(0x11) then 
       memory.write_float(CHandlingData + 0x00EC, -wheelie_val)
    else
       memory.write_float(CHandlingData + 0x00EC, 0.5)
    end
end)

local clumsiness = vehicles:list("载具翻滚")
local clumsy_val = 0.3
clumsiness:slider_float("翻滚值", {"clumsinessvalue"}, "", 10, 100, 30, 5, function(value)
    clumsy_val = value / 100
end)

clumsiness:toggle_loop("启用", {"vehicleclumsiness"}, "使载具轻松翻滚", function()
    local vehicle = entities.get_user_vehicle_as_handle()
    if vehicle == 0 then return end
    local CAutomobile = entities.handle_to_pointer(vehicle)
    local CHandlingData = memory.read_long(CAutomobile + 0x0918)
    local veh_speed = (GET_ENTITY_SPEED(vehicle)* 2.236936)
    if util.is_key_down(0x41) or util.is_key_down(0x44) then
        memory.write_float(CHandlingData + 0x00EC, -clumsy_val)
    else
        memory.write_float(CHandlingData + 0x00EC, 0.5)
    end
end, function()
    local vehicle = entities.get_user_vehicle_as_handle()
    if vehicle == 0 then return end
    local CAutomobile = entities.handle_to_pointer(vehicle)
    local CHandlingData = memory.read_long(CAutomobile + 0x0918)
    memory.write_float(CHandlingData + 0x00EC, 0.5)
end)

vehicles:toggle_loop("载具火箭", {""}, "", function()
    local wpn = joaat("VEHICLE_WEAPON_TANK")
    local vehicle = GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
    local offset = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    local leftStart = offset(vehicle, -1.25, 0.5, 0.35)
    local leftEnd = offset(vehicle, -1.25, 100.0, 0.35)
    local rightStart = offset(vehicle, 1.25, 0.5, 0.35)
    local rightEnd = offset(vehicle, 1.25, 100.0, 0.35)
    if IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) and not GET_IS_TASK_ACTIVE(players.user_ped(), 199) and IS_CONTROL_JUST_RELEASED(0, 69) and not IS_CONTROL_PRESSED(0, 68) then
        SHOOT_SINGLE_BULLET_BETWEEN_COORDS(leftStart, leftEnd, 0, true, wpn, players.user_ped(), true, false, 5.0)
        SHOOT_SINGLE_BULLET_BETWEEN_COORDS(rightStart, rightEnd, 0, true, wpn, players.user_ped(), true, false, 5.0)
    end
end)

vehicles:toggle_loop("载具车门", {}, "当上车权限设置为无人时 模仿灭世2000的车门把手电击锁", function() -- thx rockstar for the code :)
    for players.list_except() as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = entities.get_user_vehicle_as_handle()
        if GET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, pid) then
            if HAS_ANIM_EVENT_FIRED(ped, -1526509349) then
                SHOOT_SINGLE_BULLET_BETWEEN_COORDS(GET_PED_BONE_COORDS(ped, 11816), GET_PED_BONE_COORDS(ped, 39317), 1, true, joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
                yield(1000)
            end
        end
    end
end)

local veh_jump = vehicles:list("载具跳跃")
local force = 25.00
veh_jump:slider_float("跳跃值", {"jumpiness"}, "", 0, 10000, 2500, 100, function(value)
    force = value / 100
end)
veh_jump:toggle_loop("启用", {"vehiclejump"}, "按空格键跳跃", function()
    local vehicle = entities.get_user_vehicle_as_handle()
    if veh != 0 and DOES_ENTITY_EXIST(vehicle) and IS_CONTROL_JUST_RELEASED(0, 102) then
        APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, force/1.5, force, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        repeat
            yield()
        until not IS_ENTITY_IN_AIR(vehicle)
    end
end)

local deformation = 1.00
vehicles:slider_float("载具变形", {"deformation"}, "", 0, 10000, 100, 100, function(value)
    deformation = value / 100
    menu.trigger_commands($"vhdeformationmult {deformation}")
end)

local seat_id = -1
local moved_seat = vehicles:click_slider("载具座位", {}, "", 1, 1, 1, 1, function(seat_id)
    TASK_WARP_PED_INTO_VEHICLE(players.user_ped(), entities.get_user_vehicle_as_handle(), seat_id - 2)
end)

menu.on_tick_in_viewport(vehicles, function()
    if not IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
        moved_seat.max_value = 0
        return 
        end
    
    moved_seat.max_value = GET_VEHICLE_MODEL_NUMBER_OF_SEATS(GET_ENTITY_MODEL(entities.get_user_vehicle_as_handle()))
end)

vehicles:toggle_loop("载具加速", {""}, "", function()
    if not GET_IS_VEHICLE_ENGINE_RUNNING(entities.get_user_vehicle_as_handle()) and GET_IS_TASK_ACTIVE(players.user_ped(), 150) then
        FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

vehicles:toggle_loop("载具进出", {"fastvehicleenter"}, "加快进出载具速度", function()
    if (GET_IS_TASK_ACTIVE(players.user_ped(), 160) or GET_IS_TASK_ACTIVE(players.user_ped(), 167) or GET_IS_TASK_ACTIVE(players.user_ped(), 165)) and not GET_IS_TASK_ACTIVE(players.user_ped(), 195) then
        FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

vehicles:toggle_loop("载具解除", {""}, "下车时自动解除载具无敌", function()
    if not GET_ENTITY_CAN_BE_DAMAGED(entities.get_user_vehicle_as_handle()) then
        if not IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
            SET_ENTITY_CAN_BE_DAMAGED(GET_VEHICLE_PED_IS_IN(players.user_ped(), true), true)
        end
    end
end)

vehicles:toggle_loop("载具自瞄", {"zm"}, "载具导弹瞄准玩家", function()
    for players.list_except(true) as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local ped_dist = v3.distance(players.get_position(players.user()), players.get_position(pid))
        if not IS_PLAYER_DEAD(ped) and IS_CONTROL_PRESSED(0, 70) and ped_dist < 300.0 and not players.is_in_interior(pid) then
            SET_VEHICLE_SHOOT_AT_TARGET(players.user_ped(), ped, players.get_position(pid))
        end
    end
end)

vehicles:toggle_loop("载具贴地", {""}, "", function()
    local vehicle = GET_VEHICLE_PED_IS_USING(players.user_ped())
    local velocity = GET_ENTITY_VELOCITY(vehicle)
    local height = GET_ENTITY_HEIGHT_ABOVE_GROUND(vehicle)
    local controls = {32, 33, 34, 35}
    if height < 5.0 then
        if IS_ENTITY_IN_AIR(vehicle) then
            SET_VEHICLE_ON_GROUND_PROPERLY(vehicle, 0.0)
        end
    else
        for controls as key do
            if vehicle != 0 and IS_CONTROL_PRESSED(0, key) then
                while not IS_CONTROL_RELEASED(0, key) and IS_ENTITY_IN_AIR(vehicle) do
                    APPLY_FORCE_TO_ENTITY(vehicle, 2, 0.0, 0.0, -500 - velocity.z, 0, 0, 0, 0, true, false, true, false, true) -- setting vehilce on ground while its in air causes problems so we'll just do this
                    yield()
                end
            end
        end
    end
end)

vehicles:toggle_loop("载具旋转", {"spinbot"}, "", function()
    local vehicle = GET_VEHICLE_PED_IS_USING(players.user_ped())
    local velocity = GET_ENTITY_VELOCITY(vehicle)
    local height = GET_ENTITY_HEIGHT_ABOVE_GROUND(vehicle)
    if height < 5.0 and height > 0.1 then
        SET_VEHICLE_ON_GROUND_PROPERLY(vehicle)
    end
    if vehicle != 0 and not IS_PLAYER_DEAD(players.user_ped()) and NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
        APPLY_FORCE_TO_ENTITY(vehicle, 5, 0.0, 0.0, 150.0, 0, 0, 0, 0, true, false, true, false, true)
    end
end)

funfeatures:toggle_loop("忍者", {"naruto"}, "", function()
    local dict = "swimming@scuba"
    local name = "dive_glide"
    RequestAnimation(dict)
    if IS_PED_SPRINTING(players.user_ped()) and not IS_ENTITY_PLAYING_ANIM(players.user_ped(), dict, name, 3) and not GET_IS_TASK_ACTIVE(players.user_ped(), 56) and not GET_IS_TASK_ACTIVE(players.user_ped(), 290) then
        TASK_PLAY_ANIM(players.user_ped(), dict, name, 5.0, 2.5, -1, 1|16|32, 1.0, false, false, false)
    elseif IS_ENTITY_PLAYING_ANIM(players.user_ped(), dict, name, 3) and (IS_PED_WALKING(players.user_ped()) or IS_PED_STILL(players.user_ped()) or IS_PED_JUMPING(players.user_ped()))
    or GET_IS_TASK_ACTIVE(players.user_ped(), 56) or IS_PLAYER_FREE_AIMING(players.user()) or IS_PED_RELOADING(players.user_ped()) then
        repeat
            if not IS_ENTITY_PLAYING_ANIM(players.user_ped(), dict, name, 3) then -- had to add this dumb check again because it was getting stuck on other animations
                return
            end
            CLEAR_PED_TASKS(players.user_ped())
            yield()
        until not IS_ENTITY_PLAYING_ANIM(players.user_ped(), dict, name, 3)
    end
end, function()
    CLEAR_PED_TASKS(players.user_ped())
end)

funfeatures:action("扫帚", {}, "其他玩家不可见", function()
    local reveal_invis = menu.ref_by_path("Online>Reveal Invisible Players")
    if reveal_invis.value then
        toast("请先禁用显示不可见玩家功能")
        return 
        end
    local pos = players.get_position(players.user())
    local broomstick = joaat("prop_tool_broom")
    local oppressor = joaat("oppressor2")
    util.request_model(broomstick)
    util.request_model(oppressor)
    obj = entities.create_object(broomstick, pos)
    veh = entities.create_vehicle(oppressor, pos, 0)
    SET_ENTITY_VISIBLE(veh, false)
    SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
    ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, 0, 0, 0.3, -80.0, 0, 0, true, false, false, false, 0, true) -- thanks to chaos mod for doing the annoying rotation work for me :P
end)

funfeatures:action("水怪", {}, "", function()
    local pos = players.get_position(players.user())
    local monster = joaat("h4_prop_h4_loch_monster")
    local oppressor = joaat("oppressor2")
    util.request_model(monster)
    util.request_model(oppressor)
    obj = entities.create_object(monster, pos)
    veh = entities.create_vehicle(oppressor, pos, 0)
    SET_ENTITY_COLLISION(obj, false, false)
    SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
    ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, -0.25, -1.0, 1.0, 0.0, 0.0, -90.0, true, false, false, false, 0, true)
end)


local headlamp = funfeatures:list("头灯", {}, "本地显示")
local distance = 25.0
headlamp:slider_float("光距", {"distance"}, "", 100, 10000, 1500, 100, function(value)
    distance = value / 100
end)

local brightness = 10.0
headlamp:slider_float("亮度", {"brightness"}, "", 100, 10000, 1000, 100, function(value)
    brightness = value / 100
end)

local light_radius = 15.0
headlamp:slider_float("范围", {"radius"}, "", 100, 5000, 2000, 100, function(value)
    light_radius = value / 100
end)

local color = {r = 1, g = 235/255, b = 190/255, a = 0}
headlamp:colour("颜色", {"colour"}, "", color, true, function(value)
    color = value 
end)

headlamp:toggle_loop("打开", {"headlamp"}, "", function()
    local head_pos = GET_PED_BONE_COORDS(players.user_ped(), 31086, 0.0, 1.0, 0.0)
    local cam_rot = players.get_cam_rot(players.user())
    if not IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then
        DRAW_SHADOWED_SPOT_LIGHT(head_pos, cam_rot:toDir(), math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255), distance * 1.5, brightness, 0.0, light_radius, distance, 0)
    end
end)

funfeatures:toggle("停电", {"poweroutage"}, "", function(toggled)
    SET_ARTIFICIAL_LIGHTS_STATE(toggled)
end)

funfeatures:toggle("断电", {"blackout"}, "", function(toggled)
    menu.trigger_commands("time 1")
    SET_ARTIFICIAL_LIGHTS_STATE(toggled)
    if toggled then
        SET_TIMECYCLE_MODIFIER("dlc_island_vault")
    else
        SET_TIMECYCLE_MODIFIER("DEFAULT")
    end
end)

funfeatures:toggle_loop("力场", {}, "套个飞碟模型", function(toggled)
    local mdl = joaat("p_spinning_anus_s")
    local pos = players.get_position(players.user())
    util.request_model(mdl)
    if obj == nil or not DOES_ENTITY_EXIST(obj) and not IS_PED_IN_ANY_VEHICLE(players.user_ped()) then
        obj = entities.create_object(mdl, pos)
        SET_ENTITY_VISIBLE(obj, false)
        ATTACH_ENTITY_TO_ENTITY(obj, players.user_ped(), 0, 0, 0, 0, 0, 0, 0, false, false, true, false, 0, false, 0)
    end
    if IS_PED_IN_ANY_VEHICLE(players.user_ped()) and obj != nil then
        entities.delete(obj)
    end
end, function()
    if obj != nil then
        entities.delete(obj)
    end
end)

local jesus_main = funfeatures:list("自动驾驶", {}, "耶稣代驾 ")
local style = 786603
jesus_main:list_action("驾驶风格", {}, "点击选择一种风格", style_names, function(index, value)
    switch value do
        case "正常": 
            style = 786603
            break
        case "催促": 
            style = 1074528293
            break
        case "逆向": 
            style = 1076
            break
        case "无视信号灯": 
            style = 2883621
            break
        case "避开堵车": 
            style = 786468
            break
        case "极度避开堵车": 
            style = 6
            break     
        case "走捷径":
            style = 262144
            break
        case "有时超车": 
            style = 5
        break  
    end      
end)

local speed = 20.00
jesus_main:slider_float("速度值", {""}, "", 0, 10000, 2000, 100, function(value)
    speed = value / 100
end)

local jesus_toggled = false
local jesus_toggle
jesus_toggle = jesus_main:toggle("启用", {}, "", function(toggle)
    jesus_toggled = toggle
    local pos = players.get_position(players.user())
    local vehicle = entities.get_user_vehicle_as_handle()
    jesus = joaat("u_m_m_jesus_01")
    util.request_model(jesus)

    if jesus_toggled then
        if not IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then 
			toast(lang.get_localised(-474174214))
            menu.set_value(jesus_toggle, false)
        util.stop_thread() end
        
        jesus_ped = entities.create_ped(26, jesus, pos, 0)
        SET_ENTITY_INVINCIBLE(jesus_ped, true)
        SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -2)
        SET_PED_INTO_VEHICLE(jesus_ped, vehicle, -1)
        SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(jesus_ped, true)
        SET_PED_KEEP_TASK(jesus_ped, true)

        if IS_WAYPOINT_ACTIVE() then
            local waypoint = GET_BLIP_COORDS(GET_FIRST_BLIP_INFO_ID(8))
            TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(jesus_ped, vehicle, waypoint, speed, style, 0.0)
        else
            TASK_VEHICLE_DRIVE_WANDER(jesus_ped, vehicle, 20.0, 786603)
            toast("无路径点 耶稣会开车带你兜风 :)")
        end
        yield()
    else
        if jesus_ped != nil then 
            entities.delete(jesus_ped)
            SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -1)
        end
    end
    
    while jesus_toggled do
        local height = GET_ENTITY_HEIGHT_ABOVE_GROUND(vehicle)
        local upright_value = GET_ENTITY_UPRIGHT_VALUE(vehicle)
        if height < 5.0 and upright_value < 0.0 then
            SET_VEHICLE_ON_GROUND_PROPERLY(vehicle)
        end
        yield()
    end
end)

funfeatures:toggle("特斯拉", {}, "伊隆马斯克", function(toggled)
    local pos = players.get_position(players.user())
    local tesla_ai = joaat("u_m_y_baygor")
    local tesla = joaat("raiden")
    util.request_model(tesla_ai)
    util.request_model(tesla)
    if toggled then     
        if IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
            menu.trigger_commands("deletevehicle")
        end

        tesla_ai_ped = entities.create_ped(26, tesla_ai, pos, 0)
        tesla_vehicle = entities.create_vehicle(tesla, pos, 0)

        SET_ENTITY_INVINCIBLE(tesla_ai_ped, true) 
        SET_ENTITY_VISIBLE(tesla_ai_ped, false)
        SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(tesla_ai_ped, true)
        SET_PED_INTO_VEHICLE(players.user_ped(), tesla_vehicle, -2)
        SET_PED_INTO_VEHICLE(tesla_ai_ped, tesla_vehicle, -1)
        SET_PED_CONFIG_FLAG(tesla_ai_ped, 26, true)
        SET_PED_KEEP_TASK(tesla_ai_ped, true)

        SET_VEHICLE_COLOURS(tesla_vehicle, 111, 111)
        SET_VEHICLE_MOD(tesla_vehicle, 23, 8, false)
        SET_VEHICLE_MOD(tesla_vehicle, 15, 1, false)
        SET_VEHICLE_EXTRA_COLOURS(tesla_vehicle, 111, 147)
        menu.trigger_commands("performance")

        if IS_WAYPOINT_ACTIVE() then
            local waypoint = GET_BLIP_COORDS(GET_FIRST_BLIP_INFO_ID(8))
            TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(tesla_ai_ped, tesla_vehicle, waypoint,9999.0, 786468, 0)
        else
            TASK_VEHICLE_DRIVE_WANDER(tesla_ai_ped, tesla_vehicle, 20.0, 786603)
        end
        yield()
    else
        if tesla_ai_ped != nil then 
            entities.delete(tesla_ai_ped)
        end
        if tesla_vehicle != nil then 
            entities.delete(tesla_vehicle)
        end
    end
end)

for index, data in interiors do
    local location_name = data[1]
    local location_coords = data[2]
    teleport:action(location_name, {}, "", function()
        menu.trigger_commands("doors on")
        menu.trigger_commands("nodeathbarriers on")
        SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), location_coords.x, location_coords.y, location_coords.z, false, false, false)
    end)
end

local finger_thing = funfeatures:list("手指枪", {}, "按B射击 无伤害")
for id, data in weapon_stuff do
    local name = data[1]
    local weapon_name = data[2]
    local toggled = false
    finger_thing:toggle(name, {}, "", function(state)
        toggled = state
        while toggled do
            local projectile = LoadWeaponAsset(weapon_name)
            if memory.read_int(memory.script_global(4521801 + 930)) == 3 then
                memory.write_int(memory.script_global(4521801 + 935), GET_NETWORK_TIME())
                local inst = v3.new()
                v3.set(inst,GET_FINAL_RENDERED_CAM_ROT(2))
                local tmp = v3.toDir(inst)
                v3.set(inst, v3.get(tmp))
                v3.mul(inst, 1000)
                v3.set(tmp, GET_FINAL_RENDERED_CAM_COORD())
                v3.add(inst, tmp)
                local x, y, z = v3.get(inst)
                local fingerPos = GET_PED_BONE_COORDS(players.user_ped(), 4089, 1.0, 0.0, 0.0)
                SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(fingerPos, x, y, z, 1, true, projectile, 0, true, false, 500.0, players.user_ped(), 0)
            end
            yield(100)
        end
        local pos = players.get_position(players.user())
        CLEAR_AREA_OF_PROJECTILES(pos, 999999.0, 0)
    end)
end

local jinx_pet
jinx_toggle = funfeatures:toggle_loop("宠物猫", {}, "Jinx", function()
    if not jinx_pet or not DOES_ENTITY_EXIST(jinx_pet) then
        local jinx = joaat("a_c_cat_01")
        util.request_model(jinx)
        local pos = players.get_position(players.user())
        jinx_pet = entities.create_ped(28, jinx, pos, 0)
        entities.set_can_migrate(jinx_pet, false)
        SET_PED_COMPONENT_VARIATION(jinx_pet, 0, 0, 1, 0)
        SET_ENTITY_INVINCIBLE(jinx_pet, true)
    end
    NETWORK_REQUEST_CONTROL_OF_ENTITY(jinx_pet)
    TASK_FOLLOW_TO_OFFSET_OF_ENTITY(jinx_pet, players.user_ped(), 0, -0.3, 0, 7.0, -1, 1.5, true)
end, function()
    entities.delete(jinx_pet)
end)

funfeatures:action("寻找它", {}, "", function()
    local pos = players.get_position(players.user())
    if jinx_pet != nil then 
        SET_ENTITY_COORDS_NO_OFFSET(jinx_pet, pos, false, false, false)
    else
        toast("Jinx没有找到 :(")
    end
end)

local godmode_ctr = 0
local time_since_last_move = 0
local god_detection
god_detection = modder_detections:toggle_loop("检测无敌", {}, "", function()
    local reveal_invis = menu.ref_by_path("Online>Reveal Invisible Players")
    if reveal_invis.value then
        util.toast("[JinxScript 检测无敌] 请先禁用显示不可见玩家 :)")
        god_detection.value = false
    return end
    for players.list_except(true) as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
        if not players.is_godmode(pid) then continue end
        if not players.is_in_interior(pid) and not NETWORK_IS_PLAYER_FADING(pid) and IS_ENTITY_VISIBLE(ped) and GET_SPAWN_STATE(pid) == 99 and not IS_PLAYER_IN_INTERIOR(pid) and not IS_PLAYER_RIDING_ROLLER_COASTER(pid) then
            util.draw_debug_text($"{players.get_name(pid)} 无敌")
        end

        if players.is_godmode(pid) and not players.is_in_interior(pid) and IS_ENTITY_VISIBLE(ped) and GET_SPAWN_STATE(pid) != 0 and not IS_PLAYER_IN_INTERIOR(pid) and not IsDetectionPresent(pid, "无敌") and pos.z > 0.0 then
            local spectate = menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method")
            if not IS_PLAYER_MOVING(pid) and time_since_last_move >= 5 then
                time_since_last_move = 0
                godmode_ctr = 0     
            end
            if NETWORK_IS_PLAYER_FADING(pid) then
                godmode_ctr = 0
            end
            if godmode_ctr >= 10 then
                util.yield(2500) -- to prevent marking people as godmode whos freemode has died
                if players.exists(pid) then
                    players.add_detection(pid, "无敌", TOAST_ALL, 100)
                    godmode_ctr = 0
                    break
                end
            end
            util.yield(1000)
            godmode_ctr +=1
            if not IS_PLAYER_MOVING(pid) then
                time_since_last_move +=1
            else
                time_since_last_move = 0
            end
        end
    end 
end)

modder_detections:toggle_loop("检测载具", {}, "检测载具无敌", function()
    if NETWORK_IS_ACTIVITY_SESSION() then return end
    for players.list_except(true) as pid do
        if not IS_PED_IN_ANY_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(pid)) then continue end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        if not IS_PLAYER_IN_INTERIOR(pid) and not GET_ENTITY_CAN_BE_DAMAGED(vehicle) and not NETWORK_IS_PLAYER_FADING(pid) and IS_ENTITY_VISIBLE(ped) 
        and GET_SPAWN_STATE(pid) != 0 and pid == driver then
            draw_debug_text($"{players.get_name(driver)} 载具无敌")
            break
        end
    end 
end)

modder_detections:toggle_loop("检测传送", {}, "检测对方是否传送到你身上", function()
    if NETWORK_IS_ACTIVITY_SESSION() then return end
    for players.list_except(true) as pid do
        util.create_thread(function()
            local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local veh = GET_VEHICLE_PED_IS_IN(ped) == entities.get_user_vehicle_as_handle()
            local old_pos = players.get_position(pid)
            yield(100)
            local cur_pos = players.get_position(pid)
            local my_pos = players.get_position(players.user())
            local distance_between_tp = v3.distance(old_pos, cur_pos)
            if not IS_PLAYER_IN_INTERIOR(pid) and not veh then
                if distance_between_tp > 20.0 and v3.distance(cur_pos, my_pos) < 10.0 then
                    if not IsDetectionPresent(pid, "传送") then
                        players.add_detection(pid, "传送", TOAST_ALL, 100)
                        return
                    end
                end
            end
        end)
    end
    yield(100)
end)

modder_detections:toggle_loop("检测加速", {}, "", function()
    if NETWORK_IS_ACTIVITY_SESSION() then return end
    for players.list_except(true) as pid do
        if not IS_PED_IN_ANY_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(pid)) then continue end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local veh_speed = (GET_ENTITY_SPEED(vehicle)* 2.236936)
        local veh_class = GET_VEHICLE_CLASS(vehicle)
        local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        local veh_ptr = entities.handle_to_pointer(vehicle)
        local owner = entities.get_owner(veh_ptr)
        local est_speed = GET_VEHICLE_ESTIMATED_MAX_SPEED(vehicle)
        local est_model_speed = GET_VEHICLE_MODEL_ESTIMATED_MAX_SPEED(players.get_vehicle_model(pid))
        local veh_class = GET_VEHICLE_CLASS(vehicle)
        if est_model_speed > 1.0 and vehicle != 0 then
            if est_speed > est_model_speed then
                return
            end
        end
        if veh_class != 15 and veh_class != 16 and veh_speed >= 200 and (players.get_vehicle_model(pid) != joaat("oppressor") and players.get_vehicle_model(pid) != joaat("oppressor2")) and pid == driver then
            if owner != pid then 
                repeat
                    yield() -- cooldown incase they are launched by a modder
                until veh_speed < 200
                return
            end
            if not IsDetectionPresent(driver, "加速") then
                players.add_detection(driver, "加速", TOAST_ALL, 100)
                break
            end
        end
    end
    yield(250)
end)

modder_detections:toggle_loop("检测加入", {}, "检测快速加入", function()
    if NETWORK_IS_ACTIVITY_SESSION() then return end
    for players.list_except(true) as pid do
        if util.is_session_transition_active() then return end
        local old_sh = players.get_script_host()
        yield(100)
        local new_sh = players.get_script_host()
        if old_sh != new_sh then
            if GET_SPAWN_STATE(pid) == 0 and players.get_script_host() == pid then
                if not IsDetectionPresent(pid, "快速加入") then
                    players.add_detection(pid, "快速加入", TOAST_ALL, 100)
                    toast($"{players.get_name(pid)} 快速加入 :/")
                    break
                end
            end
        end
    end
    yield(250)
end)

modder_detections:toggle_loop("检测天基", {}, "", function()
    for players.list_except(true) as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if IS_PLAYER_USING_ORBITAL_CANNON(pid) and not GET_IS_TASK_ACTIVE(ped, 135) and GET_SPAWN_STATE(pid) != 0 and not IS_PLAYER_DEAD(pid) and not IsDetectionPresent(pid, "作弊天基炮") then
            players.add_detection(pid, "作弊天基炮", TOAST_ALL, 100)
            break
        end
    end
end)

modder_detections:toggle_loop("检测生成", {}, "检测是否有人使用驾驶生成的载具", function() -- this isnt the same as mikes, calm down, retards. I had this before him.
    if NETWORK_IS_ACTIVITY_SESSION() then return end
    for players.list_except(true) as pid do
        if not IS_PED_IN_ANY_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(pid)) then continue end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local hash = players.get_vehicle_model(pid)
        local plate_text = GET_VEHICLE_NUMBER_PLATE_TEXT(vehicle)
        local bitset = DECOR_GET_INT(vehicle, "MPBitset")
        local plyveh = DECOR_GET_INT(vehicle, "Player_Vehicle")
        local pegasusveh = DECOR_GET_BOOL(vehicle, "CreatedByPegasus")
        for veh_things as veh do -- because getting the decor int for them didnt want to work
            if hash == joaat(veh) and DECOR_GET_INT(vehicle, "MPBitset") == 8 then
                return 
            end
        end
        if players.get_vehicle_model(pid) != 0 and not GET_IS_TASK_ACTIVE(ped, 160) and GET_SPAWN_STATE(players.user()) != 0 then
            local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
            if players.get_name(driver) != "InvalidPlayer" and not pegasusveh and pid == driver then 
                if bitset == 1024 then
                    draw_debug_text($"{players.get_name(driver)} 可能是 2Take1 用户")
                    break
                elseif bitset == 8 or plate_text == "46EEK572" then -- thx to mike for telling me about this plate text
                    draw_debug_text($"{players.get_name(driver)} 生成载具 [模型：{util.reverse_joaat(players.get_vehicle_model(pid))}]")
                    break
                end
            end
        end
    end
end)

modder_detections:toggle_loop("检测车牌", {}, "", function()
    if NETWORK_IS_ACTIVITY_SESSION() then return end
    for players.list_except(true) as pid do
        if not IS_PED_IN_ANY_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(pid)) then continue end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_USING(ped)
        local plate_text = GET_VEHICLE_NUMBER_PLATE_TEXT(vehicle)
        local bitset = DECOR_GET_INT(vehicle, "MPBitset")
        local pegasusveh = DECOR_GET_BOOL(vehicle, "CreatedByPegasus")
        local plyveh = DECOR_GET_INT(vehicle, "Player_Vehicle")
        local bitset_things = {8, 3072, 10240, 11264, 1048576, 16777216}
        for bitset_things as bitsets do
            if bitset == bitsets then
                return
            end
        end
        local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        if plate_text != nil and players.get_name(driver) != "InvalidPlayer" and not LegitPlatePattern(plate_text) and plyveh == 0 and not pegasusveh and pid == driver then
            draw_debug_text($"{players.get_name(driver)} 改装车牌 [{plate_text}]")
        end
    end
end)

local lockon = 0
modder_detections:toggle_loop("检测锁定", {}, "检测使用防锁定的玩家", function()
    if NETWORK_IS_ACTIVITY_SESSION() then return end
    local block_blaming = menu.ref_by_path("Online>Protections>Block Blaming")
    for players.list_except(true) as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_IN(ped)
        local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        local bitset = DECOR_GET_INT(vehicle, "MPBitset")
        local bitset_things = {3072, 10240, 11264, 11272, 33792} -- the game sets some vehicles not targetable that are parts of fm activities
        for bitset_things as bitsets do
            if bitset == bitsets then
                return
            end
        end
        if not IS_PED_IN_ANY_VEHICLE(ped) or (not DOES_VEHICLE_HAVE_IMANI_TECH(vehicle) and GET_VEHICLE_MOD(vehicle, 44) == 1) then 
            continue 
        end
        if memory.read_byte(entities.handle_to_pointer(vehicle) + 0xA9E) == 0 and not IsDetectionPresent(pid, "反锁定") and pid == driver then
            yield(1000) -- so using chaff doesnt calse a false pos 
            lockon +=1 
            if lockon >= 5 then
                players.add_detection(pid, "反锁定", TOAST_ALL, 75)
                lockon = 0
                break
            end
        else
            lockon = 0
        end
    end
    yield(250)
end)

local ignored_vehs = {}
local speed_ctr = 0
modder_detections:toggle_loop("检测车速", {}, "检测修改了发动机功率或最高速度", function()
    if NETWORK_IS_ACTIVITY_SESSION() then return end
    for players.list_except(true) as pid do
        if not IS_PED_IN_ANY_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(pid)) then continue end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = GET_VEHICLE_PED_IS_IN(ped)
        local veh_model = players.get_vehicle_model(pid)
        local veh_brand = NullCheck(util.get_label_text(GET_MAKE_NAME_FROM_VEHICLE_MODEL(veh_model)))
        local veh_mdl = util.get_label_text(GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(veh_model))
        local veh_class = GET_VEHICLE_CLASS(vehicle)
        local est_speed = GET_VEHICLE_ESTIMATED_MAX_SPEED(vehicle)
        local est_model_speed = GET_VEHICLE_MODEL_ESTIMATED_MAX_SPEED(players.get_vehicle_model(pid))
        local mdl_accel = GET_VEHICLE_MODEL_ACCELERATION(players.get_vehicle_model(pid))
        local veh_accel = GET_VEHICLE_ACCELERATION(vehicle)
        local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        local veh_ptr = entities.handle_to_pointer(vehicle)
        local owner = entities.get_owner(veh_ptr)
        local ignored = ignored_vehs[vehicle]
        local class = vehicle_classes[veh_class + 1]
        if not ignored and owner != pid and driver == pid and est_speed > (est_model_speed + 6) then
            ignored_vehs[vehicle] = true
            break
        end
        if ignored and est_speed < (est_model_speed + 6) then
            ignored_vehs[vehicle] = false
            return
        end

        local veh_name = veh_mdl
        if veh_brand ~= "" then
            veh_name = $"{veh_brand} {veh_name}"
        end
        if not IsDetectionPresent(pid, "修改车速") then
            if est_model_speed > 1.0 and not ignored and est_speed > (est_model_speed + 6) and veh_accel > (mdl_accel * 1.3) and pid == driver then
                repeat
                    speed_ctr += 1
                    yield(100)
                until speed_ctr >= 15 -- for some reason the game doesnt properly calculate speed for a while. this delay seems to be good
                toast($"[检测速度] \n作弊者:{players.get_name(driver)} \n模型: {veh_name} \nClass: {class} \n原本速度: {ROUND(est_model_speed * 2.236936)} MPH \n作弊速度: {ROUND((est_speed * 2.236936) * 1.2)} MPH")
                players.add_detection(pid, "Modified Vehicle Speed", TOAST_ALL, 75)
                speed_ctr = 0
                break
            end
        end
    end
    yield(250)
end)

modder_detections:toggle_loop("检测构造", {}, "检测使用构造和修改的json载具", function()
    for players.list_except(true) as pid do
        util.create_thread(function()
            if not IS_PED_IN_ANY_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(pid)) then return end
            local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local veh = GET_VEHICLE_PED_IS_IN(ped, false)
            local veh_model = players.get_vehicle_model(pid)
            local name = GET_DISPLAY_NAME_FROM_VEHICLE_MODEL
            local brand = GET_MAKE_NAME_FROM_VEHICLE_MODEL
            local mdls = {veh_mdl, veh_ent_mdl}
            local ignore_classes = {10, 11, 19, 20, 21}
            for entities.get_all_vehicles_as_handles() as ent do
                local ent_model = entities.get_model_hash(ent)
                local ents = {veh, ent}
                local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(veh, -1))
                for ents as v do
                    if IS_VEHICLE_ATTACHED_TO_TRAILER(v) or IS_VEHICLE_ATTACHED_TO_CARGOBOB(v) then return end
                    for ignore_classes as class do
                        if GET_VEHICLE_CLASS(v) == class then return end
                    end
                end
                if IS_ENTITY_ATTACHED_TO_ENTITY(ent, veh) then
                    local veh_mdl = util.get_label_text(name(veh_model))
                    local ent_mdl = util.get_label_text(name(ent_model))
                    local veh_brand = NullCheck(util.get_label_text(brand(veh_model)))
                    local ent_brand = NullCheck(util.get_label_text(brand(ent_model)))
                    
                    local veh_name = veh_mdl
                    if veh_brand ~= "" then
                        veh_name = $"{veh_brand} {veh_name}"
                    end

                    local ent_name = ent_mdl
                    if ent_brand ~= "" then
                        ent_name = $"{ent_brand} {ent_name}"
                    end

                    if veh_name == "NULL" or ent_name == "NULL" or veh_name == ent_name then return end
                    if not IsDetectionPresent(driver, $"构造载具 ({veh_name} / {ent_name})") then
                        players.add_detection(driver, $"构造载具 ({veh_name} / {ent_name})", TOAST_ALL, 50)
                        break
                    end
                end
                RELEASE_VEH_HANDLE(ent)
            end
        end)
        yield(100)
    end
end)

modder_detections:toggle_loop("检测改装", {}, "检测在修车店外改装自己或他人载具", function()
    for players.list_except(true) as pid do
        util.create_thread(function()
            if not IS_PED_IN_ANY_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(pid)) then return end
            local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local veh = GET_VEHICLE_PED_IS_IN(ped)
            local veh_ptr = entities.handle_to_pointer(veh)
            local pos = players.get_position(pid)
            local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(veh, -1))
            if not IS_PED_IN_ANY_VEHICLE(ped, false) then return end
            local prev_vehicle_mods = {}
            local current_vehicle_mods = {}
            for i = 0, 49 do
                prev_vehicle_mods[i] = GET_VEHICLE_MOD(veh, i)
            end
            yield(100)
            for i = 0, 49 do
                current_vehicle_mods[i] = GET_VEHICLE_MOD(veh, i)
            end
            for i = 0, 49 do
                if prev_vehicle_mods[i] ~= current_vehicle_mods[i] and not IS_PLAYER_IN_INTERIOR(pid) and IS_ENTITY_VISIBLE(veh) and pos.z > 0.0 then
                    if entities.get_owner(veh_ptr) == pid then
                        if not IsDetectionPresent(pid, "改装载具") then
                            players.add_detection(pid, "改装载具", TOAST_ALL, 100)
                            break
                        end
                    else
                        if not IsDetectionPresent(entities.get_owner(veh_ptr), "改装载具") then
                            players.add_detection(entities.get_owner(veh_ptr), "改装载具", TOAST_ALL, 100)
                        end
                    end
                end
            end
        end)
    end
    yield(50)
end)

modder_detections:toggle_loop("检测脚本", {}, "脚本主机", function()
    local data = memory.alloc(56 * 8)
    local SCRIPT_EVENT_QUEUE_AI = 0
    local SCRIPT_EVENT_QUEUE_ERRORS = 2
    local EVENT_NETWORK_HOST_MIGRATION = 180
    for queue = SCRIPT_EVENT_QUEUE_AI, SCRIPT_EVENT_QUEUE_ERRORS do
        for index = 0, GET_NUMBER_OF_EVENTS(queue) - 1 do
            local event = GET_EVENT_AT_INDEX(queue, index)
            if event == EVENT_NETWORK_HOST_MIGRATION then
                if not GET_EVENT_DATA(queue, index, data, 2) then
                    break
                end
                if memory.read_int(data) == GET_ID_OF_THIS_THREAD() then
                    local modded_sh = memory.read_int(data + 8)
                    yield(500)
                    local new_sh = players.get_script_host()
                    if new_sh != modded_sh and modded_sh != players.user() then
                        if not IsDetectionPresent(modded_sh, "作弊脚本主机") then
                            players.add_detection(modded_sh, "作弊脚本主机", TOAST_ALL, 100)
                        end
                    end
                end
            end
        end
    end
end)

normal_detections:toggle_loop("检测观看", {}, "", function()
    for players.list_except() as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local cam_dist = v3.distance(players.get_position(players.user()), players.get_cam_pos(pid))
        local ped_dist = v3.distance(players.get_position(players.user()), players.get_position(pid))
        if cam_dist < 20.0 and not IS_PLAYER_DEAD(ped) and not NETWORK_IS_PLAYER_FADING(pid) and pid != players.user() or players.get_spectate_target(pid) == players.user() then
            yield(1000)
            if ped_dist > 35.0 and not IS_PLAYER_IN_INTERIOR(pid) and players.get_name(pid) != "UndiscoveredPlayer" then
                toast($"{players.get_name(pid)} 在看你")
                break
            end
        end
    end
    yield(250)
end)

normal_detections:toggle_loop("检测天基", {}, "", function()
    for players.list_except(true) as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if IS_PLAYER_USING_ORBITAL_CANNON(pid) and GET_IS_TASK_ACTIVE(ped, 135) then
            draw_debug_text($"{players.get_name(pid)} 天基炮")
        end
    end
end)

normal_detections:toggle_loop("检测语音", {}, "检测谁在游戏聊天中说话", function()
    for players.list_except(true) as pid do
        if NETWORK_IS_PLAYER_TALKING(pid) then
             draw_debug_text($"{players.get_name(pid)} 在说话")
        end
    end 
end)

protections:toggle_loop("阻止野兽", {}, "防止你变成野兽 但也会为其他人阻止该事件", function()
    if GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("am_hunt_the_Beast")) > 0 then
        local host = NETWORK_GET_HOST_OF_SCRIPT("am_hunt_the_Beast", -1, 0)
        local beast = memory.read_int(memory.script_local("am_hunt_the_Beast", 3469)) -- credit to ayim for telling me to check the beast id with user id
        if beast != -1 and beast == players.user() then
            if util.spoof_script("am_hunt_the_Beast", TERMINATE_THIS_THREAD) then
                toast($"阻止猎杀野兽脚本 来自 {players.get_name(host)}")
            end
        end
    end
end)

local anticage = protections:list("阻止笼子", {}, "")
local alpha = 88
anticage:slider("透明度", {"transparency"}, "笼子透明度", 1, #values, 2, 1, function(amount)
    alpha = values[amount]
end)

local radius = 10.00
anticage:slider_float("封锁半径", {"radius"}, "检测笼子的半径", 100, 2500, 1000, 100, function(value)
    radius = value/100
end)

local cleanup = false
anticage:toggle("自动删除", {"cleanup"}, "自动删除任何笼子", function(toggled)
    cleanup = toggled
end)

anticage:toggle_loop("启用反笼", {"anticage"}, "", function()
    local user = players.user_ped()
    local vehicle = GET_VEHICLE_PED_IS_USING(user)
    local my_ents = {user, veh}
    for entities.get_all_objects_as_pointers() as obj_ptr do
        local net_obj = memory.read_long(obj_ptr + 0xd0)
        if net_obj == 0 or memory.read_byte(net_obj + 0x49) == players.user() then
            continue
        end
        local obj_handle = entities.pointer_to_handle(obj_ptr)
        local owner = entities.get_owner(obj_ptr)
        local id = NETWORK_GET_NETWORK_ID_FROM_ENTITY(obj_handle)
        SET_GAMEPLAY_CAM_IGNORE_ENTITY_COLLISION_THIS_UPDATE(obj_handle)
        for my_ents as data do
            if v3.distance(players.get_position(players.user()), GET_ENTITY_COORDS(obj_handle)) <= radius then
                for doors as door do
                    if entities.get_model_hash(obj_ptr) != joaat(door) then
                        continue
                    end
                end
                if data != 0 and alpha >= 1 then
                    SET_ENTITY_NO_COLLISION_ENTITY(obj_handle, data, false)  
                    SET_ENTITY_NO_COLLISION_ENTITY(data, obj_handle, false)
                    SET_ENTITY_ALPHA(obj_handle, alpha, false)
                end
                if data != 0 and cleanup then
                    entities.set_can_migrate(obj_ptr, true)
                    SET_ENTITY_ALPHA(obj_handle, 0, false)
                    entities.delete(obj_handle)
                end
                if data != 0 and IS_ENTITY_TOUCHING_ENTITY(data, obj_handle) then
                    toast($"阻止笼子 来自 {players.get_name(owner)}")
                end
            end
        end
        RELEASE_SCRIPT_GUID_FROM_ENTITY(obj_handle)
    end
end)

local anti_mugger = protections:list("阻止劫匪")
anti_mugger:toggle_loop("自己", {}, "防止你被打劫", function() -- thx nowiry for improving my method :D
    if NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
        local ped_netId = memory.script_local("am_gang_call", 62 + 10 + (0 * 7 + 1))
        local sender = memory.script_local("am_gang_call", 286)
        local target = memory.script_local("am_gang_call", 287)

        util.spoof_script("am_gang_call", function()
            if (memory.read_int(sender) != players.user() and memory.read_int(target) == players.user() 
            and NETWORK_DOES_NETWORK_ID_EXIST(memory.read_int(ped_netId)) 
            and NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(memory.read_int(ped_netId))) then
                local mugger = NET_TO_PED(memory.read_int(ped_netId))
                entities.delete(mugger)
                toast($"阻止打劫 来自 {players.get_name(memory.read_int(sender))}")
            end
        end)
    end
end)

anti_mugger:toggle_loop("其他人", {}, "防止别人被抢劫", function()
    if NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
        local ped_netId = memory.script_local("am_gang_call", 63 + 10 + (0 * 7 + 1))
        local sender = memory.script_local("am_gang_call", 287)
        local target = memory.script_local("am_gang_call", 288)
        
        util.spoof_script("am_gang_call", function()
            if memory.read_int(target) != players.user() and memory.read_int(sender) != players.user()
            and NETWORK_DOES_NETWORK_ID_EXIST(memory.read_int(ped_netId)) 
            and NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(memory.read_int(ped_netId)) then
                local mugger = NET_TO_PED(memory.read_int(ped_netId))
                entities.delete(mugger)
                toast($"阻止打劫 来自 {players.get_name(memory.read_int(sender))} 到 {players.get_name(memory.read_int(target))}")
            end
        end)
    end
end)

local block_spec_syncs
block_spec_syncs = protections:toggle_loop("阻止同步", {"blockspectatorsyncs"}, "阻止观看者的所有传出同步", function()
    for players.list_except() as pid do
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local cam_dist = v3.distance(players.get_position(players.user()), players.get_cam_pos(pid))
        local ped_dist = v3.distance(players.get_position(players.user()), players.get_position(pid))
        if cam_dist < 20.0 then
            yield(1000)
            if ped_dist > 35.0 then
                local outgoingSyncs = menu.ref_by_rel_path(menu.player_root(pid), "Outgoing Syncs>Block")
                outgoingSyncs.value = true
                local pos = players.get_position(players.user())
                if v3.distance(pos, players.get_cam_pos(pid)) < 20.0 then
                    repeat 
                        yield()
                    until v3.distance(pos, players.get_cam_pos(pid)) > 200.0 
                    outgoingSyncs.value = false
                    if players.get_name(pid) != "UndiscoveredPlayer" then
                        toast($"{players.get_name(pid)} 已停止观看你")
                    end
                end
            end
        end
    end
end, function()
    for players.list_except(true) as pid do
        if players.exists(pid) then
            local outgoingSyncs = menu.ref_by_rel_path(menu.player_root(pid), "Outgoing Syncs>Block")
            outgoingSyncs.value = false
        end
    end
end)

protections:toggle_loop("阻止劫持", {}, "阻止试图劫持你载具", function()
    local vehicle = entities.get_user_vehicle_as_handle()
    if not IS_PED_IN_VEHICLE(players.user_ped(), vehicle, false) then return end
    for entities.get_all_peds_as_handles() as ped do
        local owner = entities.get_owner(ped)
        if not IS_PED_A_PLAYER(ped) and GET_IS_TASK_ACTIVE(ped, 160) and GET_VEHICLE_PED_IS_TRYING_TO_ENTER(ped) == vehicle and owner != players.user() then
            toast($"阻止劫持 来自{players.get_name(owner)}")
            if not IsDetectionPresent(owner, "载具劫持") then
                players.add_detection(owner, "载具劫持", TOAST_ALL, 100)
                break
            end
            entities.delete(ped)
            repeat
                SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -1)
                yield()
            until GET_SEAT_PED_IS_IN(players.user_ped()) == -1
        end
    end
end)

protections:list_action("清除所有", {}, "", {"NPC", "载具", "物体", "道具", "投掷物", "声音"}, function(index, name)
    toast($"清除中 {name:lower()}...")
    local counter = 0
    switch index do
        case 1:
            for entities.get_all_peds_as_handles() as ped do
                if ped != players.user_ped() and not IS_PED_A_PLAYER(ped) then
                    entities.delete(ped)
                    counter += 1
                    yield()
                end
            end
            break
        case 2:
            for entities.get_all_vehicles_as_handles() as vehicle do
                if vehicle != GET_VEHICLE_PED_IS_IN(players.user_ped(), false) and DECOR_GET_INT(vehicle, "Player_Vehicle") == 0 and NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
                    entities.delete(vehicle)
                    counter += 1
                end
                yield()
            end
            break
        case 3:
            for entities.get_all_objects_as_handles() as object do
                entities.delete(object)
                counter += 1
                yield()
            end
            break
        case 4:
            for entities.get_all_pickups_as_handles() as pickup do
                entities.delete(pickup)
                counter += 1
                yield()
            end
            break
        case 5:
            local coords = players.get_position(players.user())
            CLEAR_AREA_OF_PROJECTILES(coords.x, coords.y, coords.z, 1000.0, 0)
            counter = "所有"
            break
        case 6:
            for i = 0, 99 do
                STOP_SOUND(i)
                yield()
            end
        break
    end
    toast($"已清除 {tostring(counter)} {name:lower()}.")
end)

protections:action("清除区域", {"cleanse"}, "", function()
    local cleanse_entitycount = 0
    for entities.get_all_peds_as_handles() as ped do
        if ped != players.user_ped() and not IS_PED_A_PLAYER(ped) then
            entities.delete(ped)
            cleanse_entitycount += 1
            yield()
        end
    end
    toast($"已清除 {cleanse_entitycount} 行人")
    cleanse_entitycount = 0
    for entities.get_all_vehicles_as_handles() as vehicle do
        if vehicle != GET_VEHICLE_PED_IS_IN(players.user_ped(), false) and DECOR_GET_INT(vehicle, "Player_Vehicle") == 0 and NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            entities.delete(vehicle)
            cleanse_entitycount += 1
            yield()
        end
    end
    toast($"已清除 {cleanse_entitycount} 载具")
    cleanse_entitycount = 0
    for entities.get_all_objects_as_handles() as object do
        entities.delete(object)
        cleanse_entitycount += 1
        yield()
    end
    toast($"已清除 {cleanse_entitycount} 物体")
    cleanse_entitycount = 0
    for entities.get_all_pickups_as_handles() as pickup do
        entities.delete(pickup)
        cleanse_entitycount += 1
        yield()
    end
    toast($"已清除 {cleanse_entitycount} 拾取物")
    local pos = players.get_position(players.user())
    CLEAR_AREA_OF_PROJECTILES(pos, 400.0, 0)
    toast("清除所有投掷物")
end)

menu.apply_command_states()
util.keep_running() 
