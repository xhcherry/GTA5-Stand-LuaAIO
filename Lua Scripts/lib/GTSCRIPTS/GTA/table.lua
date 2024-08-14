--
pedbone = {
    {name = "根骨", id = 0x0},
    {name = "骨盆", id = 0x2e28},
    {name = "左大腿", id = 0xe39f},
    {name = "左小腿", id = 0xf9bb},
    {name = "左脚", id = 0x3779},
    {name = "左脚趾0", id = 0x83c},
    {name = "右大腿", id = 0xca72},
    {name = "右小腿", id = 0x9000},
    {name = "右脚", id = 0xcc4d},
    {name = "右脚趾0", id = 0x512d},
    {name = "脊柱根部", id = 0xe0fd},
    {name = "脊柱0", id = 0x5c01},
    {name = "脊柱1", id = 0x60f0},
    {name = "脊柱2", id = 0x60f1},
    {name = "脊柱3", id = 0x60f2},
    {name = "左锁骨", id = 0xfcd9},
    {name = "左上臂", id = 0xb1c5},
    {name = "左前臂", id = 0xeeeb},
    {name = "左手", id = 0x49d9},
    {name = "右锁骨", id = 0x29d2},
    {name = "右上臂", id = 0x9d4d},
    {name = "右前臂", id = 0x6e5c},
    {name = "右手", id = 0xdead},
    {name = "颈部1", id = 0x9995},
    {name = "头部", id = 0x796e},
    {name = "左手指00", id = 0x67f2},
    {name = "左手指01", id = 0xff9},
    {name = "左手指02", id = 0xffa},
    {name = "左手指10", id = 0x67f3},
    {name = "左手指11", id = 0x1049},
    {name = "左手指12", id = 0x104a},
    {name = "左手指20", id = 0x67f4},
    {name = "左手指21", id = 0x1059},
    {name = "左手指22", id = 0x105a},
    {name = "左手指30", id = 0x67f5},
    {name = "左手指31", id = 0x1029},
    {name = "左手指32", id = 0x102a},
    {name = "左手指40", id = 0x67f6},
    {name = "左手指41", id = 0x1039},
    {name = "左手指42", id = 0x103a},
    {name = "右手指00", id = 0xe5f2},
    {name = "右手指01", id = 0xfa10},
    {name = "右手指02", id = 0xfa11},
    {name = "右手指10", id = 0xe5f3},
    {name = "右手指11", id = 0xfa60},
    {name = "右手指12", id = 0xfa61},
    {name = "右手指20", id = 0xe5f4},
    {name = "右手指21", id = 0xfa70},
    {name = "右手指22", id = 0xfa71},
    {name = "右手指30", id = 0xe5f5},
    {name = "右手指31", id = 0xfa40},
    {name = "右手指32", id = 0xfa41},
    {name = "右手指40", id = 0xe5f6},
    {name = "右手指41", id = 0xfa50},
    {name = "右手指42", id = 0xfa51}
}

boneConnections = {
    {1, 2}, {2, 3}, {3, 4}, {4, 5}, {5, 6},
    {2, 7}, {7, 8}, {8, 9}, {9, 10},
    {2, 11}, {11, 12}, {12, 13}, {13, 14}, {14, 15},
    {15, 16}, {16, 17}, {17, 18}, {18, 19},
    {15, 20}, {20, 21}, {21, 22}, {22, 23},
    {15, 24}, {24, 25},
    {19, 26}, {26, 27}, {27, 28}, 
    {19, 29}, {29, 30}, {30, 31}, 
    {19, 32}, {32, 33}, {33, 34}, 
    {19, 35}, {35, 36}, {36, 37}, 
    {19, 38}, {38, 39}, {39, 40}, 
    {23, 41}, {41, 42}, {42, 43}, 
    {23, 44}, {44, 45}, {45, 46}, 
    {23, 47}, {47, 48}, {48, 49}, 
    {23, 50}, {50, 51}, {51, 52}, 
    {23, 53}, {53, 54}, {54, 55}  
}

num = {
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

FM = {
    fm_mission_controller = {
        team_lives = 26154 + 1325 + 1,
    },

    fm_mission_controller_2020 = {
        team_lives = 55004 + 868 + 1,
    },

    -- 名钻赌场
    gb_casino_heist = {
        phone_hack_progress = 2330,
        camera_hack_position = 4280 + 1654,
        target_package_number = 4280 + 1724,
    },

    -- Security Contract
    fm_content_security_contract = {
        mission_time = 254 + 1550,
        mission_type = 7095 + 1339 + 1,
        realize_assets_destination = 117 + 34,
    },

    -- Vehicle Cargo Import & Export
    gb_vehicle_export = {
        vehicle_net_id = 834 + 29 + 1,
        mission_start_time = 834 + 457,
    },

    -- 佩里克岛
    fm_content_island_heist = {
        mission_start_time = 13262 + 1460,
    },

    -- Air Freight
    gb_smuggler = {
        mission_start_time = 1932 + 768,
    },
    fm_content_smuggler_resupply = {
        mission_start_time = 6006 + 1319,
    },
}

specialTypeList = {
    { 0, "无", { "none" }, "No Special Ammo" },
    { 1, "穿甲子弹", { "ap" }, "Armor Piercing Ammo" },
    { 2, "爆炸子弹", { "explosive" }, "Explosive Ammo" },
    { 3, "全金属外壳子弹", { "fmj" }, "Full Metal Jacket Ammo" },
    { 4, "中空子弹", { "hp" }, "Hollow Point Ammo" },
    { 5, "燃烧子弹", { "fire" }, "Incendiary Ammo" },
    { 6, "曳光子弹", { "tracer" }, "Tracer Ammo" }
}

NPCItem = {
    PedType = {
        { 1, "排除友好", {}, "" },
        { 2, "敌对NPC", {}, "" },
        { 3, "全部NPC", {}, "" }
    },
}

NPCWeak = {
    ped_select = 1,
    time_delay = 2000,
    toggle = {
        health = false,
        weapon_damage = true,
        vehicle_weapon = false,
    },
}

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

ladder_objects = {}
pause = 0
do1 = 16
re = 17
mi = 18
fa = 19
sol = 20
la = 21
ti = 22
do2 = 23

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

dicdd = {"ANIM_GROUP_MOVE_BALLISTIC", "ANIM_GROUP_MOVE_LEMAR_ALLEY", "clipset@move@trash_fast_turn",
         "FEMALE_FAST_RUNNER", "missfbi4prepp1_garbageman", "move_characters@franklin@fire",
         "move_characters@Jimmy@slow@", "move_characters@michael@fire", "move_f@flee@a", "move_f@scared",
         "move_f@sexy@a", "move_heist_lester", "move_injured_generic", "move_lester_CaneUp", "move_m@bag",
         "MOVE_M@BAIL_BOND_NOT_TAZERED", "MOVE_M@BAIL_BOND_TAZERED", "move_m@brave", "move_m@casual@d",
         "move_m@drunk@moderatedrunk", "MOVE_M@DRUNK@MODERATEDRUNK", "MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP",
         "MOVE_M@DRUNK@SLIGHTLYDRUNK", "MOVE_M@DRUNK@VERYDRUNK", "move_m@fire", "move_m@gangster@var_e",
         "move_m@gangster@var_f", "move_m@gangster@var_i", "move_m@JOG@", "MOVE_M@PRISON_GAURD", "MOVE_P_M_ONE",
         "MOVE_P_M_ONE_BRIEFCASE", "move_p_m_zero_janitor", "move_p_m_zero_slow", "move_ped_bucket",
         "move_ped_crouched", "move_ped_mop", "MOVE_M@FEMME@", "MOVE_F@FEMME@", "MOVE_M@GANGSTER@NG",
         "MOVE_F@GANGSTER@NG", "MOVE_M@POSH@", "MOVE_F@POSH@", "MOVE_M@TOUGH_GUY@", "MOVE_F@TOUGH_GUY@"}

songs = {{
    name = "一闪一闪亮晶晶",
    bpm = 90,
    notes = {pause, do1, do1, sol, sol, la, la, {
        pitch = sol,
        length = half
    }, pause, fa, fa, mi, mi, re, re, {
        pitch = do1,
        length = half
    }, pause, sol, sol, fa, fa, mi, mi, {
        pitch = re,
        length = half
    }, pause, sol, sol, fa, fa, mi, mi, {
        pitch = re,
        length = half
    }, pause, do1, do1, sol, sol, la, la, {
        pitch = sol,
        length = half
    }, pause, fa, fa, mi, mi, re, re, {
        pitch = do1,
        length = half
    }, pause}
}, {
    name = "在月光下",
    bpm = 60,
    notes = {fa, fa, fa, sol, {
        pitch = la,
        length = half
    }, {
        pitch = sol,
        length = half
    }, fa, la, sol, sol, {
        pitch = fa,
        length = whole
    }, fa, fa, fa, sol, {
        pitch = la,
        length = half
    }, {
        pitch = sol,
        length = half
    }, fa, la, sol, sol, {
        pitch = fa,
        length = whole
    }}
}, {
    name = "热热的十字面包",
    bpm = 60,
    notes = {{
        pitch = mi,
        length = half
    }, {
        pitch = re,
        length = half
    }, {
        pitch = do1,
        length = half
    }, {
        pitch = pause,
        length = half
    }, {
        pitch = mi,
        length = half
    }, {
        pitch = re,
        length = half
    }, {
        pitch = do1,
        length = half
    }, {
        pitch = pause,
        length = half
    }, do1, do1, do1, do1, re, re, re, re, {
        pitch = mi,
        length = half
    }, {
        pitch = re,
        length = half
    }, {
        pitch = do1,
        length = half
    }, {
        pitch = pause,
        length = half
    }}
}}

snowmens = {{-955.5352, -782.4186, 15.925326}, {-819.9067, 165.35524, 71.26295}, {-247.92003, -1561.2175, 32.22973},
            {901.3996, -288.05026, 65.643715}, {1275.6772, -642.3789, 68.208786}, {1993.1008, 3829.6396, 32.167336},
            {-375.47916, 6230.158, 31.490055}, {-1414.4647, 5094.9272, 60.674263}, {-1946.0231, 594.93756, 119.79223},
            {-1100.889, -1401.0138, 5.215467}, {-780.418, 877.2859, 203.18001}, {-455.12027, 1130.5625, 325.89175},
            {221.46722, -107.01075, 69.763985}, {1560.3787, 6447.053, 23.9866}, {3301.7886, 5149.8853, 18.34274},
            {1703.0568, 4671.928, 43.15301}, {224.9161, 3107.3345, 42.18394}, {2360.0037, 2522.7166, 46.66731},
            {1510.8555, 1725.0353, 109.89355}, {-48.96374, 1964.4028, 189.87181}, {-1516.2083, 2140.2168, 56.11924},
            {-2826.2356, 1424.6211, 100.706116}, {-2957.531, 723.6389, 28.792404}, {1341.4302, -1583.5093, 54.135414},
            {178.00232, -895.9712, 30.69326}}
config = {
    debug_mode = false,
    test_mode = false,
    delay_between_button_press = 500,
    delay_sitting_at_slot_machine = 5000,
    delay_between_spins = 3000,
    delay_after_entering_casino = 4000,
    default_spin_delay_time = 1000,
    max_daily_winnings = 45000000,
    millis_in_day = 86400000
}
state = {}
menus = {}
commands = {
    rigslotmachines = menu.ref_by_path("Online>Quick Progress>Casino>Slot Machines Outcome")
}

slot_machine_positions = {{
    seated = {
        x = 1102.2573,
        y = 232.43211,
        z = -50.0909
    },
    standing = {
        x = 1102.6787,
        y = 232.73073,
        z = -49.84076,
        h = 90
    }
}, {
    seated = {
        x = 1112.4808,
        y = 234.83745,
        z = -50.0909
    },
    standing = {
        x = 1112.0146,
        y = 235.13573,
        z = -49.84075,
        h = -90
    }
}, {
    seated = {
        x = 1110.1028,
        y = 235.05864,
        z = -50.0909
    },
    standing = {
        x = 1110.5834,
        y = 235.30466,
        z = -49.840767,
        h = 90
    }
}, {
    seated = {
        x = 1111.9581,
        y = 237.83565,
        z = -50.0909
    },
    standing = {
        x = 1112.1866,
        y = 237.27339,
        z = -49.840763,
        h = 0
    }
}, {
    seated = {
        x = 1113.66,
        y = 238.81334,
        z = -50.0909
    },
    standing = {
        x = 1113.8134,
        y = 238.09317,
        z = -49.840786,
        h = 0
    }
}, {
    seated = {
        x = 1139.4238,
        y = 250.89787,
        z = -51.2909
    },
    standing = {
        x = 1139.8647,
        y = 250.2418,
        z = -51.035732,
        h = 70
    }
}, {
    seated = {
        x = 1130.6184,
        y = 251.2604,
        z = -51.2909
    },
    standing = {
        x = 1130.7328,
        y = 251.68321,
        z = -51.035774,
        h = 180
    }
}, {
    seated = {
        x = 1137.2375,
        y = 253.092,
        z = -51.2909
    },
    standing = {
        x = 1137.3026,
        y = 253.69514,
        z = -51.03577,
        h = 180
    }
}, {
    seated = {
        x = 1103.4133,
        y = 230.6071,
        z = -50.0909
    },
    standing = {
        x = 1102.95,
        y = 230.27,
        z = -49.84,
        h = -90
    }
}, {
    seated = {
        x = 1118.7598,
        y = 230.03072,
        z = -50.0909
    },
    standing = {
        x = 1119.2648,
        y = 230.20291,
        z = -49.840748,
        h = 100
    }
}}

selectedobject = 1268884662
all_objects = {-1268884662, -1268884662, 4121513285, 1085274000, 1729911864, 2166988379, 3702106121, 1398809829,
               1043035044, 3639322914, 464329140, 4046278932, 3785611910, 388197031, 2977746558, 659187150, 420170064,
               2436749075, 1193854962, 476379176, 630616933, 3945660640, 1565925668, 175309727, 3196461136, 3251728163,
               176008245, 2112015640, 993120320, 865627822, 266130508, 3762892718, 3854180205, 2804199464, 523317885,
               1327834842, 1321190118, 29828513, -1026778664, 310817095, 4130089803, 148511758, 3087007557, 2969831089,
               3533371316, 2024855755, 2450168807, 297107423, 2017086435, 3553022755, 4046278932, 3639322914,
               3231494328, 3271283456, 386059801, 202070568, 1971657777, 2005313754, 3859048180, 866394777, 740404217,
               2409855828, 286298615, 795984016, 2374537677, 3161612443, 1165195353, 2450522579, 4260070095, 974883178,
               3965551402, 3854180205, 3696781377, 4124467285, 2684801972, 3449848423, 118627012, 1565925668,
               1924419321, 2201918560, 3762892718, 266130508, 1193854962, 630616933, 476379176, 2436749075, 2154892897,
               1369811908, 2420804668, 1948561556, 356462018, 462203053, 3552768664, 2057223314, 3290378943, 168901740,
               303280717, 725259233, 2064599526, 4204303756, 3185604174, 1046958884, 81317377, 2539784170, 795367207,
               2684668286, 827574655, 617299305, 3999634798}

attachments_table = {
    ---------------------PISTOLS--------------------------------------
    ["0xFED0FD71"] = "Default Clip", -- Default Clip
    ["0xED265A1C"] = "Extended Clip", -- Extended Clip
    ["0x359B7AAE"] = "Flashlight", -- Flashlight
    ["0x65EA7EBB"] = "Suppressor", -- Suppressor
    ["0xD7391086"] = "Yusuf Amir Luxury Finish", -- Yusuf Amir Luxury Finish
    ["0x721B079"] = "Default Clip", -- Default Clip
    ["0xD67B4F2D"] = "Extended Clip", -- Extended Clip
    ["0xC304849A"] = "Suppressor", -- Suppressor
    ["0xC6654D72"] = "Yusuf Amir Luxury Finish", -- Yusuf Amir Luxury Finish
    ["0x31C4B22A"] = "Default Clip", -- Default Clip
    ["0x249A17D5"] = "Extended Clip", -- Extended Clip
    ["0x9B76C72C"] = "Gilded Gun Metal Finish", -- Gilded Gun Metal Finish
    ["0x2297BE19"] = "Default Clip", -- Default Clip
    ["0xD9D3AC92"] = "Extended Clip", -- Extended Clip
    ["0xA73D4664"] = "Suppressor", -- Suppressor
    ["0x77B8AB2F"] = "Platinum Pearl Deluxe Finish", -- Platinum Pearl Deluxe Finish
    ["0x16EE3040"] = "VIP Variant", -- VIP Variant
    ["0x9493B80D"] = "Bodyguard Variant", -- Bodyguard Variant
    ["0xE9867CE3"] = "Default Clip", -- Default Clip
    ["0xF8802ED9"] = "Default Clip", -- Default Clip
    ["0x7B0033B3"] = "Extended Clip", -- Extended Clip
    ["0x8033ECAF"] = "Etched Wood Grip Finish", -- Etched Wood Grip Finish
    ["0xD4A969A"] = "Default Clip", -- Default Clip
    ["0x64F9C62B"] = "Extended Clip", -- Extended Clip
    ["0x7A6A7B7B"] = "Etched Wood Grip Finish", -- Etched Wood Grip Finish
    ["0xBA23D8BE"] = "Default Rounds", -- Default Rounds
    ["0xC6D8E476"] = "Tracer Rounds", -- Tracer Rounds
    ["0xEFBF25"] = "Incendiary Rounds", -- Incendiary Rounds
    ["0x10F42E8F"] = "Hollow Point Rounds", -- Hollow Point Rounds
    ["0xDC8BA3F"] = "Full Metal Jacket Rounds", -- Full Metal Jacket Rounds
    ["0x420FD713"] = "Holographic Sight", -- Holographic Sight
    ["0x49B2945"] = "Small Scope", -- Small Scope
    ["0x27077CCB"] = "Compensator", -- Compensator
    ["0xC03FED9F"] = "Digital Camo", -- Digital Camo
    ["0xB5DE24"] = "Brushstroke Camo", -- Brushstroke Camo
    ["0xA7FF1B8"] = "Woodland Camo", -- Woodland Camo
    ["0xF2E24289"] = "Skull", -- Skull
    ["0x11317F27"] = "Sessanta Nove", -- Sessanta Nove
    ["0x17C30C42"] = "Perseus", -- Perseus
    ["0x257927AE"] = "Leopard", -- Leopard
    ["0x37304B1C"] = "Zebra", -- Zebra
    ["0x48DAEE71"] = "Geometric", -- Geometric
    ["0x20ED9B5B"] = "Boom!", -- Boom!
    ["0xD951E867"] = "Patriotic", -- Patriotic
    ["0x1466CE6"] = "Default Clip", -- Default Clip
    ["0xCE8C0772"] = "Extended Clip", -- Extended Clip
    ["0x902DA26E"] = "Tracer Rounds", -- Tracer Rounds
    ["0xE6AD5F79"] = "Incendiary Rounds", -- Incendiary Rounds
    ["0x8D107402"] = "Hollow Point Rounds", -- Hollow Point Rounds
    ["0xC111EB26"] = "Full Metal Jacket Rounds", -- Full Metal Jacket Rounds
    ["0x4A4965F3"] = "Flashlight", -- Flashlight
    ["0x47DE9258"] = "Mounted Scope", -- Mounted Scope
    ["0xAA8283BF"] = "Compensator", -- Compensator
    ["0xF7BEEDD"] = "Digital Camo", -- Digital Camo
    ["0x8A612EF6"] = "Brushstroke Camo", -- Brushstroke Camo
    ["0x76FA8829"] = "Woodland Camo", -- Woodland Camo
    ["0xA93C6CAC"] = "Skull", -- Skull
    ["0x9C905354"] = "Sessanta Nove", -- Sessanta Nove
    ["0x4DFA3621"] = "Perseus", -- Perseus
    ["0x42E91FFF"] = "Leopard", -- Leopard
    ["0x54A8437D"] = "Zebra", -- Zebra
    ["0x68C2746"] = "Geometric", -- Geometric
    ["0x2366E467"] = "Boom!", -- Boom!
    ["0x441882E6"] = "Boom!", -- Boom!
    ["0xE7EE68EA"] = "Digital Camo", -- Digital Camo
    ["0x29366D21"] = "Brushstroke Camo", -- Brushstroke Camo
    ["0x3ADE514B"] = "Woodland Camo", -- Woodland Camo
    ["0xE64513E9"] = "Skull", -- Skull
    ["0xCD7AEB9A"] = "Sessanta Nove", -- Sessanta Nove
    ["0xFA7B27A6"] = "Perseus", -- Perseus
    ["0xE285CA9A"] = "Leopard", -- Leopard
    ["0x2B904B19"] = "Zebra", -- Zebra
    ["0x22C24F9C"] = "Geometric", -- Geometric
    ["0x8D0D5ECD"] = "Boom!", -- Boom!
    ["0x1F07150A"] = "Patriotic", -- Patriotic
    ["0x94F42D62"] = "Default Clip", -- Default Clip
    ["0x5ED6C128"] = "Extended Clip", -- Extended Clip
    ["0x25CAAEAF"] = "Tracer Rounds", -- Tracer Rounds
    ["0x2BBD7A3A"] = "Incendiary Rounds", -- Incendiary Rounds
    ["0x85FEA109"] = "Hollow Point Rounds", -- Hollow Point Rounds
    ["0x4F37DF2A"] = "Full Metal Jacket Rounds", -- Full Metal Jacket Rounds
    ["0x8ED4BB70"] = "Mounted Scope", -- Mounted Scope
    ["0x43FD595B"] = "Flashlight", -- Flashlight
    ["0x21E34793"] = "Compensator", -- Compensator
    ["0x5C6C749C"] = "Digital Camo", -- Digital Camo
    ["0x15F7A390"] = "Brushstroke Camo", -- Brushstroke Camo
    ["0x968E24DB"] = "Woodland Camo", -- Woodland Camo
    ["0x17BFA99"] = "Skull", -- Skull
    ["0xF2685C72"] = "Sessanta Nove", -- Sessanta Nove
    ["0xDD2231E6"] = "0xDD2231E6", -- Perseus
    ["0xBB43EE76"] = "Leopard", -- Leopard
    ["0x4D901310"] = "Zebra", -- Zebra
    ["0x5F31B653"] = "Geometric", -- Geometric
    ["0x697E19A0"] = "Boom!", -- Boom!
    ["0x930CB951"] = "Patriotic", -- Patriotic
    ["0xB4FC92B0"] = "Digital Camo", -- Digital Camo
    ["0x1A1F1260"] = "Digital Camo", -- Digital Camo
    ["0xE4E00B70"] = "Digital Camo",
    ["0x2C298B2B"] = "Digital Camo",
    ["0xDFB79725"] = "Digital Camo",
    ["0x6BD7228C"] = "Digital Camo",
    ["0x9DDBCF8C"] = "Digital Camo",
    ["0xB319A52C"] = "Digital Camo",
    ["0xC6836E12"] = "Digital Camo",
    ["0x43B1B173"] = "Digital Camo",
    ["0x4ABDA3FA"] = "Patriotic", -- Patriotic
    ["0x45A3B6BB"] = "Default Clip", -- Default Clip
    ["0x33BA12E8"] = "Extended Clip", -- Extended Clip
    ["0xD7DBF707"] = "Festive tint", -- Festive tint
    ["0x54D41361"] = "Default Clip", -- Default Clip
    ["0x81786CA9"] = "Extended Clip", -- Extended Clip
    ["0x9307D6FA"] = "Suppressor", -- Suppressor
    ----------------SUBMACHINE-GUNS------------------------
    ["0xCB48AEF0"] = "Default Clip",
    ["0x10E6BA2B"] = "Extended Clip",
    ["0x359B7AAE"] = "Flashlight",
    ["0x9D2FBF29"] = "Scope",
    ["0x487AAE09"] = "Yusuf Amir Luxury Finish",
    ["0x26574997"] = "Default Clip",
    ["0x350966FB"] = "Extended Clip",
    ["0x79C77076"] = "Drum Magazine",
    ["0x7BC4CDDC"] = "Flashlight",
    ["0x3CC6BA57"] = "Scope",
    ["0x27872C90"] = "Yusuf Amir Luxury Finish",
    ["0x8D1307B0"] = "Default Clip",
    ["0xBB46E417"] = "Extended Clip",
    ["0x278C78AF"] = "Yusuf Amir Luxury Finish",
    ["0x84C8B2D3"] = "Default Clip",
    ["0x937ED0B7"] = "Extended Clip",
    ["0x4C24806E"] = "Default Clip",
    ["0xB9835B2E"] = "Extended Clip",
    ["0x7FEA36EC"] = "Tracer Rounds",
    ["0xD99222E5"] = "Incendiary Rounds",
    ["0x3A1BD6FA"] = "Hollow Point Rounds",
    ["0xB5A715F"] = "Full Metal Jacket Rounds",
    ["0x9FDB5652"] = "Holographic Sight",
    ["0xE502AB6B"] = "Small Scope",
    ["0x3DECC7DA"] = "Medium Scope",
    ["0xB99402D4"] = "Flat Muzzle Brake",
    ["0xC867A07B"] = "Tactical Muzzle Brake",
    ["0xDE11CBCF"] = "Fat-End Muzzle Brake",
    ["0xEC9068CC"] = "Precision Muzzle Brake",
    ["0x2E7957A"] = "Heavy Duty Muzzle Brake",
    ["0x347EF8AC"] = "Slanted Muzzle Brake",
    ["0x4DB62ABE"] = "Split-End Muzzle Brake",
    ["0xD9103EE1"] = "Default Barrel",
    ["0xA564D78B"] = "Heavy Barrel",
    ["0xC4979067"] = "Digital Camo",
    ["0x3815A945"] = "Brushstroke Camo",
    ["0x4B4B4FB0"] = "Woodland Camo",
    ["0xEC729200"] = "Skull",
    ["0x48F64B22"] = "Sessanta Nove",
    ["0x35992468"] = "Perseus",
    ["0x24B782A5"] = "Leopard",
    ["0xA2E67F01"] = "Zebra",
    ["0x2218FD68"] = "Geometric",
    ["0x45C5C3C5"] = "Boom!",
    ["0x399D558F"] = "Patriotic",
    ["0x476E85FF"] = "Default Clip",
    ["0xB92C6979"] = "Extended Clip",
    ["0xA9E9CAF4"] = "Drum Magazine",
    ["0x4317F19E"] = "Default Clip",
    ["0x334A5203"] = "Extended Clip",
    ["0x6EB8C8DB"] = "Drum Magazine",
    ["0xC164F53"] = "Grip",
    ["0xAA2C45B4"] = "Scope",
    ------------Shotguns-------------
    ["0xE608B35E"] = "Suppressor",
    ["0xA2D79DDB"] = "Yusuf Amir Luxury Finish",
    ["0x85A64DF9"] = "Gilded Gun Metal Finish",
    ["0x94E81BC7"] = "Default Clip",
    ["0x86BD7F72"] = "Extended Clip",
    ["0x837445AA"] = "Suppressor",
    ["0xCD940141"] = "Default Shells",
    ["0x9F8A1BF5"] = "Dragon's Breath Shells",
    ["0x4E65B425"] = "Steel Buckshot Shells",
    ["0xE9582927"] = "Flechette Shells",
    ["0x3BE4465D"] = "Explosive Slugs",
    ["0x3F3C8181"] = "Medium Scope",
    ["0xAC42DF71"] = "Suppressor",
    ["0x5F7DCE4D"] = "Squared Muzzle Brake	",
    ["0xE3BD9E44"] = "Digital Camo",
    ["0x17148F9B"] = "Brushstroke Camo",
    ["0x24D22B16"] = "Woodland Camo",
    ["0xF2BEC6F0"] = "Skull",
    ["0x85627D"] = "Sessanta Nove",
    ["0xDC2919C5"] = "Perseus",
    ["0xE184247B"] = "Leopard",
    ["0xD8EF9356"] = "Zebra",
    ["0xEF29BFCA"] = "Geometric",
    ["0x67AEB165"] = "Boom!",
    ["0x46411A1D"] = "Patriotic",
    ["0x324F2D5F"] = "Default Clip",
    ["0x971CF6FD"] = "Extended Clip",
    ["0x88C7DA53"] = "Drum Magazine",
    ---------Rifles-------------------------------
    ["0xBE5EEA16"] = "Default Clip",
    ["0xB1214F9B"] = "Extended Clip",
    ["0xDBF0A53D"] = "Drum Magazine",
    ["0x4EAD7533"] = "Yusuf Amir Luxury Finish",
    ["0x9FBE33EC"] = "Default Clip",
    ["0x91109691"] = "Extended Clip",
    ["0xBA62E935"] = "Box Magazine",
    ["0xA0D89C42"] = "Scope",
    ["0xD89B9658"] = "Yusuf Amir Luxury Finish",
    ["0xFA8FA10F"] = "Default Clip",
    ["0x8EC1C979"] = "Extended Clip",
    ["0x377CD377"] = "Gilded Gun Metal Finish",
    ["0xC6C7E581"] = "Default Clip",
    ["0x7C8BD10E"] = "Extended Clip",
    ["0x6B59AEAA"] = "Drum Magazine",
    ["0x730154F2"] = "Etched Gun Metal Finish",
    ["0xC5A12F80"] = "Default Clip",
    ["0xB3688B0F"] = "Extended Clip",
    ["0xA857BC78"] = "Gilded Gun Metal Finish",
    ["0x18929DA"] = "Default Clip",
    ["0xEFB00628"] = "Extended Clip",
    ["0x822060A9"] = "Tracer Rounds",
    ["0xA99CF95A"] = "Incendiary Rounds",
    ["0xFAA7F5ED"] = "Armor Piercing Rounds",
    ["0x43621710"] = "Full Metal Jacket Rounds",
    ["0xC7ADD105"] = "Small Scope",
    ["0x659AC11B"] = "Default Barrel",
    ["0x3BF26DC7"] = "Heavy Barrel",
    ["0x9D65907A"] = "Grip",
    ["0xAE4055B7"] = "Digital Camo",
    ["0xB905ED6B"] = "Brushstroke Camo",
    ["0xA6C448E8"] = "Woodland Camo",
    ["0x9486246C"] = "Skull",
    ["0x8A390FD2"] = "Sessanta Nove",
    ["0x2337FC5"] = "Perseus",
    ["0xEFFFDB5E"] = "Leopard",
    ["0xDDBDB6DA"] = "Zebra",
    ["0xCB631225"] = "Geometric",
    ["0xA87D541E"] = "Boom!",
    ["0xC5E9AE52"] = "Patriotic",
    ["0x16C69281"] = "Default Clip",
    ["0xDE1FA12C"] = "Extended Clip",
    ["0x8765C68A"] = "Tracer Rounds",
    ["0xDE011286"] = "Incendiary Rounds",
    ["0x51351635"] = "Armor Piercing Rounds",
    ["0x503DEA90"] = "Full Metal Jacket Rounds",
    ["0xC66B6542"] = "Large Scope",
    ["0xE73653A9"] = "Default Barrel",
    ["0xF97F783B"] = "Heavy Barrel",
    ["0xD40BB53B"] = "Digital Camo",
    ["0x431B238B"] = "Brushstroke Camo",
    ["0x34CF86F4"] = "Woodland Camo",
    ["0xB4C306DD"] = "Skull",
    ["0xEE677A25"] = "Sessanta Nove",
    ["0xDF90DC78"] = "Perseus",
    ["0xA4C31EE"] = "Leopard",
    ["0x89CFB0F7"] = "Zebra",
    ["0x7B82145C"] = "Geometric",
    ["0x899CAF75"] = "Boom!",
    ["0x5218C819"] = "Patriotic",
    ["0x8610343F"] = "Default Clip",
    ["0xD12ACA6F"] = "Extended Clip",
    ["0xEF2C78C1"] = "Tracer Rounds",
    ["0xFB70D853"] = "Incendiary Rounds",
    ["0xA7DD1E58"] = "Armor Piercing Rounds",
    ["0x63E0A098"] = "Full Metal Jacket Rounds",
    ["0x43A49D26"] = "Default Barrel",
    ["0x5646C26A"] = "Heavy Barrel",
    ["0x911B24AF"] = "Digital Camo",
    ["0x37E5444B"] = "Brushstroke Camo",
    ["0x538B7B97"] = "Woodland Camo",
    ["0x25789F72"] = "Skull",
    ["0xC5495F2D"] = "Sessanta Nove",
    ["0xCF8B73B1"] = "Perseus",
    ["0xA9BB2811"] = "Leopard",
    ["0xFC674D54"] = "Zebra",
    ["0x7C7FCD9B"] = "Geometric",
    ["0xA5C38392"] = "Boom!",
    ["0xB9B15DB0"] = "Patriotic",
    ["0x4C7A391E"] = "Default Clip",
    ["0x5DD5DBD5"] = "Extended Clip",
    ["0x1757F566"] = "Tracer Rounds",
    ["0x3D25C2A7"] = "Incendiary Rounds",
    ["0x255D5D57"] = "Armor Piercing Rounds",
    ["0x44032F11"] = "Full Metal Jacket Rounds",
    ["0x833637FF"] = "Default Barrel",
    ["0x8B3C480B"] = "Heavy Barrel",
    ["0x4BDD6F16"] = "Digital Camo",
    ["0x406A7908"] = "Brushstroke Camo",
    ["0x2F3856A4"] = "Woodland Camo",
    ["0xE50C424D"] = "Skull",
    ["0xD37D1F2F"] = "Sessanta Nove	",
    ["0x86268483"] = "Perseus",
    ["0xF420E076"] = "Leopard",
    ["0xAAE14DF8"] = "Zebra",
    ["0x9893A95D"] = "Geometric",
    ["0x6B13CD3E"] = "Boom!",
    ["0xDA55CD3F"] = "Patriotic",
    ["0x513F0A63"] = "Default Clip",
    ["0x59FF9BF8"] = "Extended Clip",
    ["0xC607740E"] = "Drum Magazine",
    ["0x2D46D83B"] = "Default Clip",
    ["0x684ACE42"] = "Extended Clip",
    ["0x6B82F395"] = "Iron Sights",
    -------------Machine-Guns-----------
    ["0xF434EF84"] = "Default Clip",
    ["0x82158B47"] = "Extended Clip",
    ["0x3C00AFED"] = "Scope",
    ["0xD6DABABE"] = "Yusuf Amir Luxury Finish",
    ["0xE1FFB34A"] = "Default Clip",
    ["0xD6C59CD6"] = "Extended Clip",
    ["0x92FECCDD"] = "Etched Gun Metal Finish",
    ["0x492B257C"] = "Default Clip",
    ["0x17DF42E9"] = "Extended Clip",
    ["0xF6649745"] = "Tracer Rounds",
    ["0xC326BDBA"] = "Incendiary Rounds",
    ["0x29882423"] = "Armor Piercing Rounds",
    ["0x57EF1CC8"] = "Full Metal Jacket Rounds",
    ["0xC34EF234"] = "Default Barrel",
    ["0xB5E2575B"] = "Heavy Barrel",
    ["0x4A768CB5"] = "Digital Camo",
    ["0xCCE06BBD"] = "Brushstroke Camo",
    ["0xBE94CF26"] = "Woodland Camo",
    ["0x7609BE11"] = "Skull",
    ["0x48AF6351"] = "Sessanta Nove",
    ["0x9186750A"] = "Perseus",
    ["0x84555AA8"] = "Leopard",
    ["0x1B4C088B"] = "Zebra",
    ["0xE046DFC"] = "Geometric",
    ["0x28B536E"] = "Boom!",
    ["0xD703C94D"] = "Patriotic",
    ["0x1CE5A6A5"] = "Default Clip",
    ["0xEAC8C270"] = "Extended Clip",
    --------------Sniper---------------
    ["0x9BC64089"] = "Default Clip",
    ["0xD2443DDC"] = "Scope",
    ["0xBC54DA77"] = "Advanced Scope",
    ["0x4032B5E7"] = "Etched Wood Grip Finish",
    ["0x476F52F4"] = "Default Clip",
    ["0x94E12DCE"] = "Default Clip",
    ["0xE6CFD1AA"] = "Extended Clip",
    ["0xD77A22D2"] = "Tracer Rounds",
    ["0x6DD7A86E"] = "Incendiary Rounds",
    ["0xF46FD079"] = "Armor Piercing Rounds",
    ["0xE14A9ED3"] = "Full Metal Jacket Rounds",
    ["0x5B1C713C"] = "Zoom Scope",
    ["0x381B5D89"] = "Default Barrel",
    ["0x68373DDC"] = "Heavy Barrel",
    ["0x9094FBA0"] = "Digital Camo",
    ["0x7320F4B2"] = "Brushstroke Camo",
    ["0x60CF500F"] = "Woodland Camo",
    ["0xFE668B3F"] = "Skull",
    ["0xF3757559"] = "Sessanta Nove",
    ["0x193B40E8"] = "Perseus",
    ["0x107D2F6C"] = "Leopard",
    ["0xC4E91841"] = "Zebra",
    ["0x9BB1C5D3"] = "Geometric",
    ["0x3B61040B"] = "Boom!",
    ["0xB7A316DA"] = "Boom!",
    ["0xFA1E1A28"] = "Default Clip",
    ["0x2CD8FF9D"] = "Extended Clip",
    ["0xEC0F617"] = "Incendiary Rounds",
    ["0xF835D6D4"] = "Armor Piercing Rounds",
    ["0x3BE948F6"] = "Full Metal Jacket Rounds",
    ["0x89EBDAA7"] = "Explosive Rounds",
    ["0x82C10383"] = "Zoom Scope",
    ["0xB68010B0"] = "Night Vision Scope",
    ["0x2E43DA41"] = "Thermal Scope",
    ["0x5F7DCE4D"] = "Squared Muzzle Brake",
    ["0x6927E1A1"] = "Bell-End Muzzle Brake",
    ["0x909630B7"] = "Default Barrel",
    ["0x108AB09E"] = "Heavy Barrel",
    ["0xF8337D02"] = "Digital Camo",
    ["0xC5BEDD65"] = "Brushstroke Camo",
    ["0xE9712475"] = "Woodland Camo",
    ["0x13AA78E7"] = "Skull",
    ["0x26591E50"] = "Sessanta Nove",
    ["0x302731EC"] = "Perseus",
    ["0xAC722A78"] = "Leopard",
    ["0xBEA4CEDD"] = "Zebra",
    ["0xCD776C82"] = "Geometric",
    ["0xABC5ACC7"] = "Boom!",
    ["0x6C32D2EB"] = "Patriotic",
    ["0xD83B4141"] = "Default Clip",
    ["0xCCFD2AC5"] = "Extended Clip",
    ["0x1C221B1A"] = "Scope",
    ["0x161E9241"] = "Yusuf Amir Luxury Finish",
    --------Heavy-Weapons---------
    ["0x11AE5C97"] = "Default Clip"
}

object_names = {"Click Next Object >", "Bricks", "w_ex_pipebomb", "Pizza's", "prop_boombox_01",
                "xm3_prop_xm3_boombox_01a", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14",
                "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "Dandy's",
                "Keypad's", "Brittle Bush", "Saplin", "Fragment", "Gas", "Ball", "Flagpole", "Combat MG", "Mag1",
                "Barrel", "40mm", "Corp Rope", "prop_amb_ciggy_01", "prop_table_03_chr", "prop_parasol_03",
                "prop_traffic_01d", "prop_streetlight_01", "v_serv_bs_gelx3", "prop_table_03", "v_serv_bs_foam1",
                "v_ret_ta_paproll2", "v_serv_bs_razor", "prop_tv_05", "v_ret_gc_box2", "prop_rub_stool",
                "prop_speaker_05", "v_serv_bs_shvbrush", "v_serv_bs_shampoo", "v_ret_ta_spray", "v_serv_bs_cond",
                "v_serv_bs_clutter", "v_ilev_bs_door", "prop_ld_purse_01", "prop_amb_phone", "prop_bin_10b",
                "prop_amb_40oz_02", "p_amb_coffeecup_01", "prop_coffee_mac_02", "prop_fire_exting_2a",
                "prop_wall_light_06a", "prop_xmas_ext", "xm_prop_x17_osphatch_col", "reh_prop_reh_sign_jk_01a",
                "reh_prop_reh_bag_para_01a", "tr_prop_tr_meet_coll_01", "vw_prop_vw_garage_coll_01a",
                "prop_forsale_dyn_01", "xm_prop_base_cabinet_door_01", "xm_prop_x17dlc_rep_sign_01a",
                "gr_prop_gr_bunkeddoor_col", "v_ret_ta_firstaid", "prop_aircon_m_01", "prop_wall_light_02a",
                "v_ret_gc_calc", "prop_micro_04", "prop_gumball_02", "prop_watercooler", "prop_radio_01",
                "prop_game_clock_01", "prop_cctv_cam_06a", "prop_till_01", "prop_chair_02", "prop_chair_04a",
                "xs_prop_arena_flipper_large_01a", "xs_prop_arena_flipper_small_01a", "xs_prop_arena_flipper_xl_01a",
                "xs_prop_arena_flipper_large_01a_sf", "xs_prop_arena_flipper_small_01a_sf",
                "xs_prop_arena_flipper_xl_01a_sf", "xs_prop_arena_flipper_large_01a_wl",
                "xs_prop_arena_flipper_small_01a_wl", "xs_prop_arena_flipper_xl_01a_wl", "xs_prop_trophy_flipper_01a"}

-- 手机按键
SoundAnnoy = {{"All", "SHORT_PLAYER_SWITCH_SOUND_SET"}, {"TENNIS_POINT_WON", "HUD_AWARDS"},
              {"Air_Defenses_Disabled", "DLC_sum20_Business_Battle_AC_Sounds"},
              {"Air_Defences_Activated", "DLC_sum20_Business_Battle_AC_Sounds"}, {"TIME_LAPSE_MASTER", "0"},
              {"Fire", "DLC_BTL_Terrobyte_Turret_Sounds"}, {"TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
              {"Timer_10s", "DLC_HALLOWEEN_FVJ_Sounds"}, {"TIMER_STOP", "HUD_MINI_GAME_SOUNDSET"},
              {"5s_To_Event_Start_Countdown", "GTAO_FM_Events_Soundset"}, {"10s", "MP_MISSION_COUNTDOWN_SOUNDSET"},
              {"5s", "MP_MISSION_COUNTDOWN_SOUNDSET"}, {"5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
              {"5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET"}, {"3_2_1_NON_RACE", "HUD_MINI_GAME_SOUNDSET"},
              {"3_2_1", "HUD_MINI_GAME_SOUNDSET"}, {"Arming_Countdown", "GTAO_Speed_Convoy_Soundset"},
              {"Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset"}, {"Boss_Blipped", "GTAO_Magnate_Hunt_Boss_SoundSet"},
              {"Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset"},
              {"1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET"},
              {"Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet"}, {"ARM_WRESTLING_WHOOSH_MASTER", "0"},
              {"ASSASSINATIONS_HOTEL_TIMER_COUNTDOWN", "ASSASSINATION_MULTI"},
              {"ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"BASE_JUMP_PASSED", "HUD_AWARDS"},
              {"Bed", "WastedSounds"}, {"Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
              {"Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS"}, {"Blade_Appear", "APT_BvS_Soundset"},
              {"BOATS_PLANES_HELIS_BOOM", "MP_LOBBY_SOUNDS"}, {"Breaker_01", "DLC_HALLOWEEN_FVJ_Sounds"},
              {"Breaker_02", "DLC_HALLOWEEN_FVJ_Sounds"}, {"Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS"},
              {"CABLE_SNAPS", "CONSTRUCTION_ACCIDENT_1_SOUNDS"}, {"CAM_PAN_DARTS", "HUD_MINI_GAME_SOUNDSET"},
              {"Camera_Shoot", "Phone_Soundset_Franklin"}, {"CANCEL", "HUD_FREEMODE_SOUNDSET"},
              {"CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS"}, {"CHALLENGE_UNLOCKED", "HUD_AWARDS"},
              {"CHECKPOINT_AHEAD", "HUD_MINI_GAME_SOUNDSET"}, {"CHECKPOINT_BEHIND", "HUD_MINI_GAME_SOUNDSET"},
              {"Checkpoint_Hit", "GTAO_FM_Events_Soundset"}, {"CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET"},
              {"CHECKPOINT_NORMAL", "HUD_MINI_GAME_SOUNDSET"}, {"CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET"},
              {"Checkpoint_Teammate", "GTAO_Shepherd_Sounds"},
              {"CHECKPOINT_UNDER_THE_BRIDGE", "HUD_MINI_GAME_SOUNDSET"}, {"Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
              {"CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE"}, {"Click_Fail", "WEB_NAVIGATION_SOUNDS_PHONE"},
              {"Click_Special", "WEB_NAVIGATION_SOUNDS_PHONE"}, {"CLOSED", "MP_PROPERTIES_ELEVATOR_DOORS"},
              {"CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET"}, {"CONTINUE", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
              {"Continue_Appears", "DLC_HEIST_PLANNING_BOARD_SOUNDS"}, {"Crash", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
              {"Criminal_Damage_High_Value", "GTAO_FM_Events_Soundset"},
              {"Criminal_Damage_Kill_Player", "GTAO_FM_Events_Soundset"},
              {"Criminal_Damage_Low_Value", "GTAO_FM_Events_Soundset"}, {"Cycle_Item", "DLC_Dmod_Prop_Editor_Sounds"},
              {"DELETE", "HUD_DEATHMATCH_SOUNDSET"}, {"Delete_Placed_Prop", "DLC_Dmod_Prop_Editor_Sounds"},
              {"Deliver_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"}, {"DiggerRevOneShot", "BulldozerDefault"},
              {"Door_Open", "DOCKS_HEIST_FINALE_2B_SOUNDS"}, {"Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET"},
              {"Dropped", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"}, {"EDIT", "HUD_DEATHMATCH_SOUNDSET"},
              {"Start_Squelch", "CB_RADIO_SFX"}, {"End_Squelch", "CB_RADIO_SFX"},
              {"Enemy_Capture_Start", "GTAO_Magnate_Yacht_Attack_Soundset"},
              {"Enemy_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"},
              {"Enemy_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"}, {"Enter_1st", "GTAO_FM_Events_Soundset"},
              {"Enter_Area", "DLC_Lowrider_Relay_Race_Sounds"},
              {"Enter_Capture_Zone", "DLC_Apartments_Drop_Zone_Sounds"}, {"ERROR", "HUD_AMMO_SHOP_SOUNDSET"},
              {"Event_Message_Purple", "GTAO_FM_Events_Soundset"}, {"Event_Start_Text", "GTAO_FM_Events_Soundset"},
              {"EXIT", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"Exit_Capture_Zone", "DLC_Apartments_Drop_Zone_Sounds"},
              {"Failure", "DLC_HEIST_HACKING_SNAKE_SOUNDS"}, {"Falling_Crates", "EXILE_1"},
              {"Faster_Bar_Full", "RESPAWN_ONLINE_SOUNDSET"}, {"Faster_Click", "RESPAWN_ONLINE_SOUNDSET"},
              {"FestiveGift", "Feed_Message_Sounds"}, {"FIRST_PLACE", "HUD_MINI_GAME_SOUNDSET"},
              {"FLIGHT_SCHOOL_LESSON_PASSED", "HUD_AWARDS"}, {"FLYING_STREAM_END_INSTANT", "FAMILY_5_SOUNDS"},
              {"FocusIn", "HintCamSounds"}, {"FocusOut", "HintCamSounds"},
              {"Friend_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"},
              {"Friend_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"}, {"GO", "HUD_MINI_GAME_SOUNDSET"},
              {"Goal", "DLC_HEIST_HACKING_SNAKE_SOUNDS"}, {"GOLF_BIRDIE", "HUD_AWARDS"}, {"GOLF_EAGLE", "HUD_AWARDS"},
              {"GOLF_HUD_HOLE_IN_ONE_MASTER", "0"}, {"GOLF_HUD_SCORECARD_MASTER", "0"},
              {"GOLF_NEW_RECORD", "HUD_AWARDS"}, {"Goon_Paid_Small", "GTAO_Boss_Goons_FM_Soundset"},
              {"Grab_Parachute", "BASEJUMPS_SOUNDS"}, {"Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"},
              {"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"}, {"HACKING_CLICK", "0"},
              {"HACKING_CLICK_BAD", "0"}, {"HACKING_CLICK_GOOD", "0"}, {"HACKING_MOVE_CURSOR", "0"},
              {"Hang_Up", "Phone_SoundSet_Michael"}, {"HIGHLIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
              {"Highlight_Accept", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
              {"Highlight_Cancel", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
              {"Highlight_Error", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
              {"Highlight_Move", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
              {"HIGHLIGHT_NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"Hit", "RESPAWN_ONLINE_SOUNDSET"},
              {"Hit_1", "LONG_PLAYER_SWITCH_SOUNDS"}, {"Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET"},
              {"Hit_Out", "PLAYER_SWITCH_CUSTOM_SOUNDSET"}, {"HORDE_COOL_DOWN_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
              {"HUD_FREEMODE_CANCEL_MASTER", "0"}, {"Kill_List_Counter", "GTAO_FM_Events_Soundset"},
              {"LEADERBOARD", "HUD_MINI_GAME_SOUNDSET"}, {"Lights_On", "GTAO_MUGSHOT_ROOM_SOUNDS"},
              {"LIMIT", "DLC_APT_YACHT_DOOR_SOUNDS"}, {"Load_Scene", "DLC_Dmod_Prop_Editor_Sounds"},
              {"LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
              {"LOCAL_PLYR_CASH_COUNTER_INCREASE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
              {"LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET"}, {"Lose_1st", "GTAO_FM_Events_Soundset"},
              {"LOSER", "HUD_AWARDS"}, {"Map_Roll_Down", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
              {"Map_Roll_Up", "DLC_HEIST_PLANNING_BOARD_SOUNDS"}, {"MARKER_ERASE", "HEIST_BULLETIN_BOARD_SOUNDSET"},
              {"MARTIN1_DISTANT_TRAIN_HORNS_MASTER", "0"}, {"MEDAL_BRONZE", "HUD_AWARDS"}, {"MEDAL_GOLD", "HUD_AWARDS"},
              {"MEDAL_SILVER", "HUD_AWARDS"}, {"MEDAL_UP", "HUD_MINI_GAME_SOUNDSET"},
              {"Menu_Accept", "Phone_SoundSet_Default"}, {"Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
              {"MP_5_SECOND_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"MP_AWARD", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
              {"MP_Flash", "WastedSounds"}, {"MP_IDLE_KICK", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
              {"MP_IDLE_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"MP_Impact", "WastedSounds"},
              {"MP_RANK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"MP_WAVE_COMPLETE", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
              {"NAV", "HUD_AMMO_SHOP_SOUNDSET"}, {"Nav_Arrow_Ahead", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
              {"Nav_Arrow_Behind", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
              {"Nav_Arrow_Left", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
              {"Nav_Arrow_Right", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"}, {"NAV_LEFT_RIGHT", "HUD_FREEMODE_SOUNDSET"},
              {"NAV_UP_DOWN", "HUD_FREEMODE_SOUNDSET"}, {"Near_Miss_Counter_Reset", "GTAO_FM_Events_Soundset"},
              {"NO", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"Object_Dropped_Remote", "GTAO_FM_Events_Soundset"},
              {"Off_High", "MP_RADIO_SFX"}, {"OK", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"ON", "NOIR_FILTER_SOUNDS"},
              {"On_Call_Player_Join", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"}, {"OOB_Cancel", "GTAO_FM_Events_Soundset"},
              {"OOB_Start", "GTAO_FM_Events_Soundset"}, {"OPEN_WINDOW", "LESTER1A_SOUNDS"},
              {"OPENED", "MP_PROPERTIES_ELEVATOR_DOORS"}, {"OTHER_TEXT", "HUD_AWARDS"},
              {"Out_Of_Area", "DLC_Lowrider_Relay_Race_Sounds"},
              {"Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
              {"Paper_Shuffle", "DLC_HEIST_PLANNING_BOARD_SOUNDS"}, {"Parcel_Vehicle_Lost", "GTAO_FM_Events_Soundset"},
              {"Payment_Non_Player", "DLC_HEISTS_GENERIC_SOUNDS"}, {"Payment_Player", "DLC_HEISTS_GENERIC_SOUNDS"},
              {"Pen_Tick", "DLC_HEIST_PLANNING_BOARD_SOUNDS"}, {"PERSON_SCROLL", "HEIST_BULLETIN_BOARD_SOUNDSET"},
              {"PERSON_SELECT", "HEIST_BULLETIN_BOARD_SOUNDSET"}, {"Phone_Generic_Key_02", "HUD_MINIGAME_SOUNDSET"},
              {"PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"Pin_Bad", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"},
              {"PIN_BUTTON", "ATM_SOUNDS"}, {"Pin_Centred", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"},
              {"Pin_Good", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"}, {"PIPES_LAND", "CONSTRUCTION_ACCIDENT_1_SOUNDS"},
              {"Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds"}, {"Place_Prop_Success", "DLC_Dmod_Prop_Editor_Sounds"},
              {"Player_Collect", "DLC_PILOT_MP_HUD_SOUNDS"}, {"Player_Enter_Line", "GTAO_FM_Cross_The_Line_Soundset"},
              {"Player_Exit_Line", "GTAO_FM_Cross_The_Line_Soundset"}, {"Power_Down", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
              {"Pre_Screen_Stinger", "DLC_HEISTS_FAILED_SCREEN_SOUNDS"}, {"PS2A_MONEY_LOST", "PALETO_SCORE_2A_BANK_SS"},
              {"PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET"}, {"Put_Away", "Phone_SoundSet_Michael"},
              {"QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"QUIT_WHOOSH", "HUD_MINI_GAME_SOUNDSET"},
              {"RACE_PLACED", "HUD_AWARDS"}, {"RAMP_DOWN", "TRUCK_RAMP_DOWN"}, {"RAMP_UP", "TRUCK_RAMP_DOWN"},
              {"RANK_UP", "HUD_AWARDS"}, {"REMOTE_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
              {"REMOTE_PLYR_CASH_COUNTER_INCREASE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
              {"Reset_Prop_Position", "DLC_Dmod_Prop_Editor_Sounds"}, {"RESTART", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
              {"RETRY", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"ROBBERY_MONEY_TOTAL", "HUD_FRONTEND_CUSTOM_SOUNDSET"},
              {"ROPE_CUT", "ROPE_CUT_SOUNDSET"}, -- {"ROUND_ENDING_STINGER_CUSTOM", "CELEBRATION_SOUNDSET"},
{"Save_Scene", "DLC_Dmod_Prop_Editor_Sounds"}, {"SCOPE_UI_MASTER", "0"}, {"ScreenFlash", "WastedSounds"},
              {"SCREEN_SWIPE", "CELEBRATION_SWIPE"}, {"SELECT", "HUD_FREEMODE_SOUNDSET"},
              {"Select_Placed_Prop", "DLC_Dmod_Prop_Editor_Sounds"}, {"Shard_Disappear", "GTAO_FM_Events_Soundset"},
              {"SHOOTING_RANGE_ROUND_OVER", "HUD_AWARDS"}, {"Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET"},
              {"Short_Transition_Out", "PLAYER_SWITCH_CUSTOM_SOUNDSET"}, {"SKIP", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
              {"Start", "DLC_HEIST_HACKING_SNAKE_SOUNDS"}, {"STUN_COLLECT", "MINUTE_MAN_01_SOUNDSET"},
              {"Success", "DLC_HEIST_HACKING_SNAKE_SOUNDS"}, {"Swap_Sides", "DLC_HALLOWEEN_FVJ_Sounds"},
              {"SWING_SHUT", "GTAO_APT_DOOR_DOWNSTAIRS_GLASS_SOUNDS"}, {"Tattooing_Oneshot", "TATTOOIST_SOUNDS"},
              {"Tattooing_Oneshot_Remove", "TATTOOIST_SOUNDS"},
              {"Team_Capture_Start", "GTAO_Magnate_Yacht_Attack_Soundset"}, {"TENNIS_MATCH_POINT", "HUD_AWARDS"},
              {"TENNIS_POINT_WON", "HUD_AWARDS"}, {"TextHit", "WastedSounds"},
              {"TOGGLE_ON", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"Turn", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
              {"UNDER_THE_BRIDGE", "HUD_AWARDS"}, {"WAYPOINT_SET", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
              {"WEAPON_ATTACHMENT_EQUIP", "HUD_AMMO_SHOP_SOUNDSET"},
              {"WEAPON_ATTACHMENT_UNEQUIP", "HUD_AMMO_SHOP_SOUNDSET"}, {"WEAPON_PURCHASE", "HUD_AMMO_SHOP_SOUNDSET"},
              {"WEAPON_SELECT_ARMOR", "HUD_AMMO_SHOP_SOUNDSET"}, {"Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS"},
              {"Whoosh_1s_R_to_L", "MP_LOBBY_SOUNDS"}, {"WIN", "HUD_AWARDS"},
              {"Zone_Enemy_Capture", "DLC_Apartments_Drop_Zone_Sounds"},
              {"Zone_Neutral", "DLC_Apartments_Drop_Zone_Sounds"},
              {"Zone_Team_Capture", "DLC_Apartments_Drop_Zone_Sounds"}, {"Zoom_In", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
              {"Zoom_Left", "DLC_HEIST_PLANNING_BOARD_SOUNDS"}, {"Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
              {"Zoom_Right", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
              {"Checkpoint_Finish_Winner", "DLC_Tuner_Car_Meet_Test_Area_Events_Sounds"},
              {"Checkpoint", "DLC_Tuner_Car_Meet_Test_Area_Events_Sounds"}}

All_business_properties = { -- Clubhouses
"1334 Roy Lowenstein Blvd", "7 Del Perro Beach", "75 Elgin Avenue", "101 Route 68", "1 Paleto Blvd",
"47 Algonquin Blvd", "137 Capital Blvd", "2214 Clinton Avenue", "1778 Hawick Avenue", "2111 East Joshua Road",
"68 Paleto Blvd", "4 Goma Street", -- Facilities
"Grand Senora Desert", "Route 68", "Sandy Shores", "Mount Gordo", "Paleto Bay", "Lago Zancudo", "Zancudo River",
"Ron Alternates Wind Farm", "Land Act Reservoir", -- Arcades
"Pixel Pete's - Paleto Bay", "Wonderama - Grapeseed", "Warehouse - Davis", "Eight-Bit - Vinewood",
"Insert Coin - Rockford Hills", "Videogeddon - La Mesa"}

small_warehouses = {
    [1] = "Pacific Bait Storage",
    [2] = "White Widow Garage",
    [3] = "Celltowa Unit",
    [4] = "Convenience Store Lockup",
    [5] = "Foreclosed Garage",
    [9] = "Pier 400 Utility Building"
}

medium_warehouses = {
    [7] = "Derriere Lingerie Backlot",
    [10] = "GEE Warehouse",
    [11] = "LS Marine Building 3",
    [12] = "Railyard Warehouse",
    [13] = "Fridgit Annexe",
    [14] = "Disused Factory Outlet",
    [15] = "Discount Retail Unit",
    [21] = "Old Power Station"
}

large_warehouses = {
    [6] = "Xero Gas Factory",
    [8] = "Bilgeco Warehouse",
    [16] = "Logistics Depot",
    [17] = "Darnell Bros Warehouse",
    [18] = "Wholesale Furniture",
    [19] = "Cypress Warehouses",
    [20] = "West Vinewood Backlot",
    [22] = "Walker & Sons Warehouse"
}

proofs = {
    bullet = {
        name = "Bullets",
        on = false
    },
    fire = {
        name = "Fire",
        on = false
    },
    explosion = {
        name = "Explosions",
        on = false
    },
    collision = {
        name = "Collision",
        on = false
    },
    melee = {
        name = "Melee",
        on = false
    },
    steam = {
        name = "Steam",
        on = false
    },
    drown = {
        name = "Drowning",
        on = false
    }
}

modded_weapons = {"weapon_railgun", "weapon_stungun", "weapon_digiscanner"}

things = {"brickade2", "hauler", "hauler2", "manchez3", "terbyte", "minitank"}

doors = {"v_ilev_ml_door1", "v_ilev_ta_door", "v_ilev_247door", "v_ilev_247door_r", "v_ilev_lostdoor", "v_ilev_bs_door",
         "v_ilev_cs_door01", "v_ilev_cs_door01_r", "v_ilev_gc_door03", "v_ilev_gc_door04", "v_ilev_clothmiddoor",
         "v_ilev_clothmiddoor", "prop_shop_front_door_l", "prop_shop_front_door_r"}

object_stuff = {
    names = {"Hamburger", "UFO", "Ferris Wheel", "Windmill", "Cement Mixer", "Scaffolding", "Garage Door",
             "Big Bowling Ball", "Big Soccer Ball", "Big Orange Ball", "Stunt Ramp"},
    objects = {"xs_prop_hamburgher_wl", "p_spinning_anus_s", "prop_ld_ferris_wheel", "prop_windmill_01",
               "prop_staticmixer_01", "prop_towercrane_02a", "des_scaffolding_root", "prop_sm1_11_garaged",
               "stt_prop_stunt_bowling_ball", "stt_prop_stunt_soccer_ball", "prop_juicestand", "stt_prop_stunt_jump_l"}
}

values = {
    [1] = 50,
    [2] = 88,
    [3] = 160,
    [4] = 208
}

unreleased_vehicles = {"virtue", "broadway", "everon2", "eudora", "boor"}

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
    ["放松依旧洛圣都"] = "RADIO_27_DLC_PRHEI4"
}

disguise_object = 0
disguise_objects = {
    [0] = "prop_bush_med_03",
    [1] = "prop_tree_lficus_06",
    [2] = "prop_palm_fan_03_b",
    [3] = "prop_streetlight_01",
    [4] = "prop_recyclebin_04_b",
    [5] = "prop_recyclebin_05_a",
    [6] = "prop_riding_crop_01",
    [7] = "prop_cs_katana_01",
    [8] = "prop_kino_light_02",
    [9] = "apa_prop_flag_china",
    [10] = "prop_gr_bmd_b",
    [11] = "w_smug_bomb_01",
    [12] = "xs_prop_arena_pit_fire_01a"
}
disguise_names = {
    [0] = "灌木丛",
    [1] = "树",
    [2] = "棕榈树",
    [3] = "路灯",
    [4] = "垃圾桶",
    [5] = "回收站",
    [6] = "马鞭",
    [7] = "武士刀",
    [8] = "灯架",
    [9] = "国旗",
    [10] = "锅盖",
    [11] = "原子弹",
    [12] = "大烧烤"
}

Til = {T('NONE'), T('BLACK'), T('DARKSMOKE'), T('LIGHTSMOKE'), T('STOCK'), T('LIMO'), T('GREEN')}

Mainc = {T('Metallic Black'), T('Metallic Graphite Black'), T('Metallic Black Steal'), T('Metallic Dark Silver'),
         T('Metallic Silver'), T('Metallic Blue Silver'), T('Metallic Steel Gray'), T('Metallic Shadow Silver'),
         T('Metallic Stone Silver'), T('Metallic Midnight Silver'), T('Metallic Gun Metal'),
         T('Metallic Anthracite Grey'), T('Matte Black'), T('Matte Gray'), T('Matte Light Grey'), T('Util Black'),
         T('Util Black Poly'), T('Util Dark silver'), T('Util Silver'), T('Util Gun Metal'), T('Util Shadow Silver'),
         T('Worn Black'), T('Worn Graphite'), T('Worn Silver Grey'), T('Worn Silver'), T('Worn Blue Silver'),
         T('Worn Shadow Silver'), T('Metallic Red'), T('Metallic Torino Red'), T('Metallic Formula Red'),
         T('Metallic Blaze Red'), T('Metallic Graceful Red'), T('Metallic Garnet Red'), T('Metallic Desert Red'),
         T('Metallic Cabernet Red'), T('Metallic Candy Red'), T('Metallic Sunrise Orange'), T('Metallic Classic Gold'),
         T('Metallic Orange'), T('Matte Red'), T('Matte Dark Red'), T('Matte Orange'), T('Matte Yellow'), T('Util Red'),
         T('Util Bright Red'), T('Util Garnet Red'), T('Worn Red'), T('Worn Golden Red'), T('Worn Dark Red'),
         T('Metallic Dark Green'), T('Metallic Racing Green'), T('Metallic Sea Green'), T('Metallic Olive Green'),
         T('Metallic Green'), T('Metallic Gasoline Blue Green'), T('Matte Lime Green'), T('Util Dark Green'),
         T('Util Green'), T('Worn Dark Green'), T('Worn Green'), T('Worn Sea Wash'), T('Metallic Midnight Blue'),
         T('Metallic Dark Blue'), T('Metallic Saxony Blue'), T('Metallic Blue'), T('Metallic Mariner Blue'),
         T('Metallic Harbor Blue'), T('Metallic Diamond Blue'), T('Metallic Surf Blue'), T('Metallic Nautical Blue'),
         T('Metallic Bright Blue'), T('Metallic Purple Blue'), T('Metallic Spinnaker Blue'), T('Metallic Ultra Blue'),
         T('Metallic Bright Blue'), T('Util Dark Blue'), T('Util Midnight Blue'), T('Util Blue'),
         T('Util Sea Foam Blue'), T('Util Lightning blue'), T('Util Maui Blue Poly'), T('Util Bright Blue'),
         T('Matte Dark Blue'), T('Matte Blue'), T('Matte Midnight Blue'), T('Worn Dark blue'), T('Worn Blue'),
         T('Worn Light blue'), T('Metallic Taxi Yellow'), T('Metallic Race Yellow'), T('Metallic Bronze'),
         T('Metallic Yellow Bird'), T('Metallic Lime'), T('Metallic Champagne'), T('Metallic Pueblo Beige'),
         T('Metallic Dark Ivory'), T('Metallic Choco Brown'), T('Metallic Golden Brown'), T('Metallic Light Brown'),
         T('Metallic Straw Beige'), T('Metallic Moss Brown'), T('Metallic Biston Brown'), T('Metallic Beechwood'),
         T('Metallic Dark Beechwood'), T('Metallic Choco Orange'), T('Metallic Beach Sand'),
         T('Metallic Sun Bleeched Sand'), T('Metallic Cream'), T('Util Brown'), T('Util Medium Brown'),
         T('Util Light Brown'), T('Metallic White'), T('Metallic Frost White'), T('Worn Honey Beige'), T('Worn Brown'),
         T('Worn Dark Brown'), T('Worn straw beige'), T('Brushed Steel'), T('Brushed Black steel'),
         T('Brushed Aluminium'), T('Chrome'), T('Worn Off White'), T('Util Off White'), T('Worn Orange'),
         T('Worn Light Orange'), T('Metallic Securicor Green'), T('Worn Taxi Yellow'), T('police car blue'),
         T('Matte Green'), T('Matte Brown'), T('Worn Orange'), T('Matte White'), T('Worn White'),
         T('Worn Olive Army Green'), T('Pure White'), T('Hot Pink'), T('Salmon pink'), T('Metallic Vermillion Pink'),
         T('Orange'), T('Green'), T('Blue'), T('Mettalic Black Blue'), T('Metallic Black Purple'),
         T('Metallic Black Red'), T('Hunter Green'), T('Metallic Purple'), T('Metaillic V Dark Blue'),
         T('MODSHOP BLACK1'), T('Matte Purple'), T('Matte Dark Purple'), T('Metallic Lava Red'),
         T('Matte Forest Green'), T('Matte Olive Drab'), T('Matte Desert Brown'), T('Matte Desert Tan'),
         T('Matte Foilage Green'), T('DEFAULT ALLOY COLOR'), T('Epsilon Blue'), T('Pure Gold'), T('Brushed Gold')}

Bbw = {T('Chrome OG Hunnets'), T('Gold OG Hunnets'), T('Chrome Wires'), T('Gold Wires'), T('Chrome Spoked Out'),
       T('Gold Spoked Out'), T('Chrome Knock-Offs'), T('Gold Knock-Offs'), T('Chrome Bigger Worm'),
       T('Gold Bigger Worm'), T('Chrome Vintage Wire'), T('Gold Vintage Wire'), T('Chrome Classic Wire'),
       T('Gold Classic Wire'), T('GroundRide'), T('Chrome Smoothie'), T('Gold Smoothie'), T('Chrome Classic Rod'),
       T('Gold Classic Rod'), T('Chrome Dollar'), T('Gold Dollar'), T('Chrome Mighty Star'), T('Gold Mighty Star'),
       T('Chrome Decadent Dish'), T('Gold Decadent Dish'), T('Gold Razor Style'), T('Chrome Celtic Knot'),
       T('Gold Celtic Knot'), T('Chrome Warrior Dish'), T('Gold Warrior Dish'), T('Gold Big Dog Spokes'),
       T('Chrome OG Hunnets Thin White'), T('Gold OG Hunnets Thin White'), T('Chrome Wires Thin White'),
       T('Gold Wires Thin White'), T('Chrome Spoked Out Thin White'), T('Gold Spoked Out Thin White'),
       T('Chrome Knock-Offs Thin White'), T('Gold Knock-Offs Thin White'), T('Chrome Bigger Worm Thin White'),
       T('Gold Bigger Worm Thin White'), T('Chrome Vintage Wire Thin White'), T('Gold Vintage Wire Thin White'),
       T('Chrome Classic Wire Thin White'), T('Gold Classic Wire Thin White'), T('GroundRide Thin White'),
       T('Chrome Smoothie Thin White'), T('Gold Smoothie Thin White'), T('Chrome Classic Rod Thin White'),
       T('Gold Classic Rod Thin White'), T('Chrome Dollar Thin White'), T('Gold Dollar Thin White'),
       T('Chrome Mighty Star Thin White'), T('Gold Mighty Star Thin White'), T('Chrome Decadent Dish Thin White'),
       T('Gold Decadent Dish Thin White'), T('Gold Razor Style Thin White'), T('Chrome Celtic Knot Thin White'),
       T('Gold Celtic Knot Thin White'), T('Chrome Warrior Dish Thin White'), T('Gold Warrior Dish Thin White'),
       T('Gold Big Dog Spokes Thin White'), T('Chrome OG Hunnets Medium White'), T('Gold OG Hunnets Medium White'),
       T('Chrome Wires Medium White'), T('Gold Wires Medium White'), T('Chrome Spoked Out Medium White'),
       T('Gold Spoked Out Medium White'), T('Chrome Knock-Offs Medium White'), T('Gold Knock-Offs Medium White'),
       T('Chrome Bigger Worm Medium White'), T('Gold Bigger Worm Medium White'), T('Chrome Vintage Wire Medium White'),
       T('Gold Vintage Wire Medium White'), T('Chrome Classic Wire Medium White'), T('Gold Classic Wire Medium White'),
       T('GroundRide Medium White'), T('Chrome Smoothie Medium White'), T('Gold Smoothie Medium White'),
       T('Chrome Classic Rod Medium White'), T('Gold Classic Rod Medium White'), T('Chrome Dollar Medium White'),
       T('Gold Dollar Medium White'), T('Chrome Mighty Star Medium White'), T('Gold Mighty Star Medium White'),
       T('Chrome Decadent Dish Medium White'), T('Gold Decadent Dish Medium White'), T('Gold Razor Style Medium White'),
       T('Chrome Celtic Knot Medium White'), T('Gold Celtic Knot Medium White'), T('Chrome Warrior Dish Medium White'),
       T('Gold Warrior Dish Medium White'), T('Gold Big Dog Spokes Medium White'), T('Chrome OG Hunnets Thick White'),
       T('Gold OG Hunnets Thick White'), T('Chrome Wires Thick White'), T('Gold Wires Thick White'),
       T('Chrome Spoked Out Thick White'), T('Gold Spoked Out Thick White'), T('Chrome Knock-Offs Thick White'),
       T('Gold Knock-Offs Thick White'), T('Chrome Bigger Worm Thick White'), T('Gold Bigger Worm Thick White'),
       T('Chrome Vintage Wire Thick White'), T('Gold Vintage Wire Thick White'), T('Chrome Classic Wire Thick White'),
       T('Gold Classic Wire Thick White'), T('GroundRide Thick White'), T('Chrome Smoothie Thick White'),
       T('Gold Smoothie Thick White'), T('Chrome Classic Rod Thick White'), T('Gold Classic Rod Thick White'),
       T('Chrome Dollar Thick White'), T('Gold Dollar Thick White'), T('Chrome Mighty Star Thick White'),
       T('Gold Mighty Star Thick White'), T('Chrome Decadent Dish Thick White'), T('Gold Decadent Dish Thick White'),
       T('Gold Razor Style Thick White'), T('Chrome Celtic Knot Thick White'), T('Gold Celtic Knot Thick White'),
       T('Chrome Warrior Dish Thick White'), T('Gold Warrior Dish Thick White'), T('Gold Big Dog Spokes Thick White'),
       T('Chrome OG Hunnets Red Line'), T('Gold OG Hunnets Red Line'), T('Chrome Wires Red Line'),
       T('Gold Wires Red Line'), T('Chrome Spoked Out Red Line'), T('Gold Spoked Out Red Line'),
       T('Chrome Knock-Offs Red Line'), T('Gold Knock-Offs Red Line'), T('Chrome Bigger Worm Red Line'),
       T('Gold Bigger Worm Red Line'), T('Chrome Vintage Wire Red Line'), T('Gold Vintage Wire Red Line'),
       T('Chrome Classic Wire Red Line'), T('Gold Classic Wire Red Line'), T('GroundRide Red Line'),
       T('Chrome Smoothie Red Line'), T('Gold Smoothie Red Line'), T('Chrome Classic Rod Red Line'),
       T('Gold Classic Rod Red Line'), T('Chrome Dollar Red Line'), T('Gold Dollar Red Line'),
       T('Chrome Mighty Star Red Line'), T('Gold Mighty Star Red Line'), T('Chrome Decadent Dish Red Line'),
       T('Gold Decadent Dish Red Line'), T('Gold Razor Style Red Line'), T('Chrome Celtic Knot Red Line'),
       T('Gold Celtic Knot Red Line'), T('Chrome Warrior Dish Red Line'), T('Gold Warrior Dish Red Line'),
       T('Gold Big Dog Spokes Red Line'), T('Chrome OG Hunnets Blue Line'), T('Gold OG Hunnets Blue Line'),
       T('Chrome Wires Blue Line'), T('Gold Wires Blue Line'), T('Chrome Spoked Out Blue Line'),
       T('Gold Spoked Out Blue Line'), T('Chrome Knock-Offs Blue Line'), T('Gold Knock-Offs Blue Line'),
       T('Chrome Bigger Worm Blue Line'), T('Gold Bigger Worm Blue Line'), T('Chrome Vintage Wire Blue Line'),
       T('Gold Vintage Wire Blue Line'), T('Chrome Classic Wire Blue Line'), T('Gold Classic Wire Blue Line'),
       T('GroundRide Blue Line'), T('Chrome Smoothie Blue Line'), T('Gold Smoothie Blue Line'),
       T('Chrome Classic Rod Blue Line'), T('Gold Classic Rod Blue Line'), T('Chrome Dollar Blue Line'),
       T('Gold Dollar Blue Line'), T('Chrome Mighty Star Blue Line'), T('Gold Mighty Star Blue Line'),
       T('Chrome Decadent Dish Blue Line'), T('Gold Decadent Dish Blue Line'), T('Gold Razor Style Blue Line'),
       T('Chrome Celtic Knot Blue Line'), T('Gold Celtic Knot Blue Line'), T('Chrome Warrior Dish Blue Line'),
       T('Gold Warrior Dish Blue Line'), T('Gold Big Dog Spokes Blue Line')}
Bow = {T('OG Hunnets'), T('OG Hunnets (Chrome Lip)'), T('Knock-Offs'), T('Knock-Offs (Chrome Lip)'), T('Spoked Out'),
       T('Spoked Out (Chrome Lip)'), T('Vintage Wire'), T('Vintage Wire (Chrome Lip)'), T('Smoothie'),
       T('Smoothie (Chrome Lip)'), T('Smoothie (Solid Color)'), T('Rod Me Up'), T('Rod Me Up (Chrome Lip)'),
       T('Rod Me Up (Solid Color)'), T('Clean'), T('Lotta Chrome'), T('Spindles'), T('Viking'), T('Triple Spoke'),
       T('Pharohe'), T('Tiger Style'), T('Three Wheelin'), T('Big Bar'), T('Biohazard'), T('Waves'), T('Lick Lick'),
       T('Spiralizer'), T('Hypnotics'), T('Psycho-Delic'), T('Half Cut'), T('Super Electric'),
       T('OG Hunnets Thin White'), T('OG Hunnets (Chrome Lip) Thin White'), T('Knock-Offs Thin White'),
       T('Knock-Offs (Chrome Lip) Thin White'), T('Spoked Out Thin White'), T('Spoked Out (Chrome Lip) Thin White'),
       T('Vintage Wire Thin White'), T('Vintage Wire (Chrome Lip) Thin White'), T('Smoothie Thin White'),
       T('Smoothie (Chrome Lip) Thin White'), T('Smoothie (Solid Color) Thin White'), T('Rod Me Up Thin White'),
       T('Rod Me Up (Chrome Lip) Thin White'), T('Rod Me Up (Solid Color) Thin White'), T('Clean Thin White'),
       T('Lotta Chrome Thin White'), T('Spindles Thin White'), T('Viking Thin White'), T('Triple Spoke Thin White'),
       T('Pharohe Thin White'), T('Tiger Style Thin White'), T('Three Wheelin Thin White'), T('Big Bar Thin White'),
       T('Biohazard Thin White'), T('Waves Thin White'), T('Lick Lick Thin White'), T('Spiralizer Thin White'),
       T('Hypnotics Thin White'), T('Psycho-Delic Thin White'), T('Half Cut Thin White'),
       T('Super Electric Thin White'), T('OG Hunnets Medium White'), T('OG Hunnets (Chrome Lip) Medium White'),
       T('Knock-Offs Medium White'), T('Knock-Offs (Chrome Lip) Medium White'), T('Spoked Out Medium White'),
       T('Spoked Out (Chrome Lip) Medium White'), T('Vintage Wire Medium White'),
       T('Vintage Wire (Chrome Lip) Medium White'), T('Smoothie Medium White'), T('Smoothie (Chrome Lip) Medium White'),
       T('Smoothie (Solid Color) Medium White'), T('Rod Me Up Medium White'), T('Rod Me Up (Chrome Lip) Medium White'),
       T('Rod Me Up (Solid Color) Medium White'), T('Clean Medium White'), T('Lotta Chrome Medium White'),
       T('Spindles Medium White'), T('Viking Medium White'), T('Triple Spoke Medium White'), T('Pharohe Medium White'),
       T('Tiger Style Medium White'), T('Three Wheelin Medium White'), T('Big Bar Medium White'),
       T('Biohazard Medium White'), T('Waves Medium White'), T('Lick Lick Medium White'), T('Spiralizer Medium White'),
       T('Hypnotics Medium White'), T('Psycho-Delic Medium White'), T('Half Cut Medium White'),
       T('Super Electric Medium White'), T('OG Hunnets Thick White'), T('OG Hunnets (Chrome Lip) Thick White'),
       T('Knock-Offs Thick White'), T('Knock-Offs (Chrome Lip) Thick White'), T('Spoked Out Thick White'),
       T('Spoked Out (Chrome Lip) Thick White'), T('Vintage Wire Thick White'),
       T('Vintage Wire (Chrome Lip) Thick White'), T('Smoothie Thick White'), T('Smoothie (Chrome Lip) Thick White'),
       T('Smoothie (Solid Color) Thick White'), T('Rod Me Up Thick White'), T('Rod Me Up (Chrome Lip) Thick White'),
       T('Rod Me Up (Solid Color) Thick White'), T('Clean Thick White'), T('Lotta Chrome Thick White'),
       T('Spindles Thick White'), T('Viking Thick White'), T('Triple Spoke Thick White'), T('Pharohe Thick White'),
       T('Tiger Style Thick White'), T('Three Wheelin Thick White'), T('Big Bar Thick White'),
       T('Biohazard Thick White'), T('Waves Thick White'), T('Lick Lick Thick White'), T('Spiralizer Thick White'),
       T('Hypnotics Thick White'), T('Psycho-Delic Thick White'), T('Half Cut Thick White'),
       T('Super Electric Thick White'), T('OG Hunnets Red Line'), T('OG Hunnets (Chrome Lip) Red Line'),
       T('Knock-Offs Red Line'), T('Knock-Offs (Chrome Lip) Red Line'), T('Spoked Out Red Line'),
       T('Spoked Out (Chrome Lip) Red Line'), T('Vintage Wire Red Line'), T('Vintage Wire (Chrome Lip) Red Line'),
       T('Smoothie Red Line'), T('Smoothie (Chrome Lip) Red Line'), T('Smoothie (Solid Color) Red Line'),
       T('Rod Me Up Red Line'), T('Rod Me Up (Chrome Lip) Red Line'), T('Rod Me Up (Solid Color) Red Line'),
       T('Clean Red Line'), T('Lotta Chrome Red Line'), T('Spindles Red Line'), T('Viking Red Line'),
       T('Triple Spoke Red Line'), T('Pharohe Red Line'), T('Tiger Style Red Line'), T('Three Wheelin Red Line'),
       T('Big Bar Red Line'), T('Biohazard Red Line'), T('Waves Red Line'), T('Lick Lick Red Line'),
       T('Spiralizer Red Line'), T('Hypnotics Red Line'), T('Psycho-Delic Red Line'), T('Half Cut Red Line'),
       T('Super Electric Red Line'), T('OG Hunnets Blue Line'), T('OG Hunnets (Chrome Lip) Blue Line'),
       T('Knock-Offs Blue Line'), T('Knock-Offs (Chrome Lip) Blue Line'), T('Spoked Out Blue Line'),
       T('Spoked Out (Chrome Lip) Blue Line'), T('Vintage Wire Blue Line'), T('Vintage Wire (Chrome Lip) Blue Line'),
       T('Smoothie Blue Line'), T('Smoothie (Chrome Lip) Blue Line'), T('Smoothie (Solid Color) Blue Line'),
       T('Rod Me Up Blue Line'), T('Rod Me Up (Chrome Lip) Blue Line'), T('Rod Me Up (Solid Color) Blue Line'),
       T('Clean Blue Line'), T('Lotta Chrome Blue Line'), T('Spindles Blue Line'), T('Viking Blue Line'),
       T('Triple Spoke Blue Line'), T('Pharohe Blue Line'), T('Tiger Style Blue Line'), T('Three Wheelin Blue Line'),
       T('Big Bar Blue Line'), T('Biohazard Blue Line'), T('Waves Blue Line'), T('Lick Lick Blue Line'),
       T('Spiralizer Blue Line'), T('Hypnotics Blue Line'), T('Psycho-Delic Blue Line'), T('Half Cut Blue Line'),
       T('Super Electric Blue Line')}
Bw = {T('Speedway'), T('Street Special'), T('Racer'), T('Track Star'), T('Overlord'), T('Trident'), T('Triple Threat'),
      T('Stilleto'), T('Wires'), T('Bobber'), T('Solidus'), T('Ice Shield'), T('Loops'), T('Chrome Speedway'),
      T('Chrome Street Special'), T('Chrome Racer'), T('Chrome Track Star'), T('Chrome Overlord'), T('Chrome Trident'),
      T('Chrome Triple Threat'), T('Chrome Stilleto'), T('Chrome Wires'), T('Chrome Bobber'), T('Chrome Solidus'),
      T('Chrome Ice Shield'), T('Chrome Loops'), T('Romper Racing'), T('Warp Drive'), T('Snowflake'), T('Holy Spoke'),
      T('Old Skool Triple'), T('Futura'), T('Quarter Mile King'), T('Cartwheel'), T('Double Five'), T('Shuriken'),
      T('Simple Six'), T('Celtic'), T('Razer'), T('Twisted'), T('Morning Star'), T('Jagged Spokes'), T('Eidolon'),
      T('Enigma'), T('Big Spokes'), T('Webs'), T('Hotplate'), T('Bobsta'), T('Grouch')}
Hew = {T('Shadow'), T('Hyper'), T('Blade'), T('Diamond'), T('Supa Gee'), T('Chromatic Z '), T('Mercie Ch.Lip'),
       T('Obey RS'), T('GT Chrome'), T('Cheetah R'), T('Solar'), T('Split Ten'), T('Dash VIP'), T('LozSpeed Ten'),
       T('Carbon Inferno'), T('Carbon Shadow'), T('Carbonic Z'), T('Carbon Solar'), T('Cheetah Carbon R'),
       T('Carbon S Racer'), T('Chrome Shadow'), T('Chrome Hyper'), T('Chrome Blade'), T('Chrome Diamond'),
       T('Chrome Supa Gee'), T('Chrome Chromatic Z '), T('Chrome Mercie Ch.Lip'), T('Chrome Obey RS'),
       T('Chrome GT Chrome'), T('Chrome Cheetah R'), T('Chrome Solar'), T('Chrome Split Ten'), T('Chrome Dash VIP'),
       T('Chrome LozSpeed Ten'), T('Chrome Carbon Inferno'), T('Chrome Carbon Shadow'), T('Chrome Carbonic Z'),
       T('Chrome Carbon Solar'), T('Chrome Cheetah Carbon R'), T('Chrome Carbon S Racer')}

Lw = {T('Flares'), T('Wired'), T('Triple Golds'), T('Big Worm'), T('Seven Fives'), T('Split Six'), T('Fresh Mesh'),
      T('Lead Sled'), T('Turbine'), T('Super Fin'), T('Classic Rod'), T('Dollar'), T('Dukes'), T('Low Five'),
      T('Gooch'), T('Chrome Flare'), T('Chrome Wired'), T('Chrome Triple Golds'), T('Chrome Big Worm'),
      T('Chrome Seven Fives'), T('Chrome Split Six'), T('Chrome Fresh Mesh'), T('Chrome Lead Sled'),
      T('Chrome Turbine'), T('Chrome Super Fin'), T('Chrome Classic Rod'), T('Chrome Dollar'), T('Chrome Dukes'),
      T('Chrome Low Five'), T('Chrome Gooch')}

Mw = {T('Classic Five'), T('Dukes'), T('Muscle Freak'), T('Kracka'), T('Azreal'), T('Mecha'), T('Black Top'),
      T('Drag SPL'), T('Revolver'), T('Classic Rod '), T('Fairlie'), T('Spooner'), T('Five Star'), T('Old School'),
      T('El Jefe'), T('Dodman'), T('Six Gun'), T('Mercenary'), T('Chrome Classic Five'), T('Chrome Dukes'),
      T('Chrome Muscle Freak'), T('Chrome Kracka'), T('Chrome Azreal'), T('Chrome Mecha'), T('Chrome Black Top'),
      T('Chrome Drag SPL'), T('Chrome Revolver'), T('Chrome Classic Rod '), T('Chrome Fairlie'), T('Chrome Spooner'),
      T('Chrome Five Star'), T('Chrome Old School'), T('Chrome El Jefe'), T('Chrome Dodman'), T('Chrome Six Gun'),
      T('Chrome Mercenary')}

Orw = {T('Raider'), T('Mudslinger'), T('Nevis'), T('Cairngorm'), T('Amazon'), T('Challenger'), T('Dune Basher'),
       T('Five Star'), T('Rock Crawler'), T('Mill Spec Steelie'), T('Chrome Raider'), T('Chrome Mudslinger'),
       T('Chrome Nevis'), T('Chrome Cairngorm'), T('Chrome Amazon'), T('Chrome Challenger'), T('Chrome Dune Basher'),
       T('Chrome Five Star'), T('Chrome Rock Crawler'), T('Chrome Mill Spec Steelie'), T('Retro Steelie'),
       T('Heavy Duty Steelie'), T('Concave Steelie'), T('Police Issue Steelie'), T('Lightweight Steelie'), T('Dukes'),
       T('Avalanche'), T('Mountain Man'), T('Rigde Climber'), T('Concave 5'), T('Flat Six'), T('All Terrain Monster'),
       T('Drag SPL'), T('Concave Rally Master'), T('Rugged Snowflake')}

Rw = {T('Classic 5'), T('Classic 5 (Striped)'), T('Retro Star'), T('Retro Star (Striped)'), T('Triplex'),
      T('Triplex (Striped)'), T('70s Spec'), T('70s Spec (Striped)'), T('Super 5R'), T('Super 5R (Striped)'),
      T('Speedster'), T('Speedster (Striped)'), T('GP-90'), T('GP-90 (Striped)'), T('Superspoke'),
      T('Superspoke (Striped)'), T('Gridline'), T('Gridline (Striped)'), T('Snowflake'), T('Snowflake (Striped)')}

Spw = {T('Inferno'), T('Deep Five'), T('Lozspeed Mk.V'), T('Diamond Cut'), T('Chrono'), T('Feroci RR'), T('FiftyNine'),
       T('Mercie'), T('Synthetic Z'), T('Organic Type 0'), T('Endo v.1'), T('GT One'), T('Duper 7'), T('Uzer'),
       T('GroundRide'), T('S Racer'), T('Venum'), T('Cosmo'), T('Dash VIP'), T('Ice Kid'), T('Ruff Weld'),
       T('Wangan Master'), T('Super Five'), T('Endo v.2'), T('Split Six'), T('Chrome Inferno'), T('Chrome Deep Five'),
       T('Chrome Lozspeed Mk.V'), T('Chrome Diamond Cut'), T('Chrome Chrono'), T('Chrome Feroci RR'),
       T('Chrome FiftyNine'), T('Chrome Mercie'), T('Chrome Synthetic Z'), T('Chrome Organic Type 0'),
       T('Chrome Endo v.1'), T('Chrome GT One'), T('Chrome Duper 7'), T('Chrome Uzer'), T('Chrome GroundRide'),
       T('Chrome S Racer'), T('Chrome Venum'), T('Chrome Cosmo'), T('Chrome Dash VIP'), T('Chrome Ice Kid'),
       T('Chrome Ruff Weld'), T('Chrome Wangan Master'), T('Chrome Super Five'), T('Chrome Endo v.2'),
       T('Chrome Split Six')}

Stw = {T('Retro Steelie'), T('Poverty Spec Steelie'), T('Concave Steelie'), T('Nebula'), T('Hotring Steelie'),
       T('Cup Champion'), T('Stanced EG Custom'), T('Kracka Custom'), T('Dukes Custom'), T('Endo v.3 Custom'),
       T('V8 Killer'), T('Fujiwara Custom'), T('Cosmo MKII'), T('Aero Star'), T('Hype Five'), T('Ruff Weld Mega Deep '),
       T('Mercie Concave'), T('Sugoi Concave'), T('Synthetic Z Concave'), T('Endo v.4 Dished'), T('Hyperfresh'),
       T('Truffade Concave'), T('Organic Type II'), T('Big Mamba'), T('Deep Flake'), T('Cosmo MKIII'),
       T('Concave Racer'), T('Deep Flake Reverse'), T('Wild Wagon'), T('Concave Mega Mesh')}

Suw = {T('VIP'), T('Benefactor'), T('Cosmo'), T('Bippu'), T('Royal Six '), T('Fagorme'), T('Deluxe'), T('Iced Out'),
       T('Cognoscenti'), T('LozSpeed Ten'), T('Supernova'), T('Obey RS'), T('LozSpeed Baller'), T('Extravaganzo'),
       T('Split Six'), T('Empowered'), T('Sunrise'), T('Dash VIP'), T('Cutter'), T('Chrome VIP'),
       T('Chrome Benefactor'), T('Chrome Cosmo'), T('Chrome Bippu'), T('Chrome Royal Six '), T('Chrome Fagorme'),
       T('Chrome Deluxe'), T('Chrome Iced Out'), T('Chrome Cognoscenti'), T('Chrome LozSpeed Ten'),
       T('Chrome Supernova'), T('Chrome Obey RS'), T('Chrome LozSpeed Baller'), T('Chrome Extravaganzo'),
       T('Chrome Split Six'), T('Chrome Empowered'), T('Chrome Sunrise'), T('Chrome Dash VIP'), T('Chrome Cutter')}

Trw = {T('Rally Throwback'), T('Gravel Trap'), T('Stove Top'), T('Stove Top Mesh'), T('Retro 3 Piece'),
       T('Rally Monoblock'), T('Forged 5'), T('Split Star'), T('Speed Boy'), T('90s Running'), T('Tropos'), T('Exos'),
       T('High Five'), T('Super Luxe'), T('Pure Business'), T('Pepper Pot'), T('Blacktop Blender'), T('Throwback'),
       T('Expressway'), T('Hidden Six'), T('Dinka SPL'), T('Retro Turbofan'), T('Conical Turbofan'), T('Ice Storm'),
       T('Super Turbine'), T('Modern Mesh'), T('Forged Star'), T('Snowflake'), T('Giga Mesh'), T('Mesh Meister')}

Tuw = {T('Cosmo'), T('Super Mesh'), T('Outsider'), T('Rollas'), T('Driftmeister'), T('Slicer'), T('El Quatro'),
       T('Dubbed'), T('Five Star'), T('Slideways'), T('Apex'), T('Stanced EG'), T('Countersteer'), T('Endo v.1'),
       T('Endo v.2 Dish'), T('Gruppe Z'), T('Choku-Dori'), T('Chicane'), T('Saisoku'), T('Dished Eight'), T('Fujiwara'),
       T('Zokusha'), T('Battle VIII'), T('Rally Master'), T('Chrome Cosmo'), T('Chrome Super Mesh'),
       T('Chrome Outsider'), T('Chrome Rollas'), T('Chrome Driftmeister'), T('Chrome Slicer'), T('Chrome El Quatro'),
       T('Chrome Dubbed'), T('Chrome Five Star'), T('Chrome Slideways'), T('Chrome Apex'), T('Chrome Stanced EG'),
       T('Chrome Countersteer'), T('Chrome Endo v.1'), T('Chrome Endo v.2 Dish'), T('Chrome Gruppe Z'),
       T('Chrome Choku-Dori'), T('Chrome Chicane'), T('Chrome Saisoku'), T('Chrome Dished Eight'), T('Chrome Fujiwara'),
       T('Chrome Zokusha'), T('Chrome Battle VIII'), T('Chrome Rally Master')}

Lighc = {T('White'), T('Blue'), T('Electric Blue'), T('Mint Green'), T('Lime Green'), T('Yellow'), T('Golden Shower'),
         T('Orange'), T('Red'), T('Pony Pink'), T('Hot Pink'), T('Purple'), T('Blacklight')}

Vehtogs = {{19, T("Turbo")}, {21, T("Tire Smoke")}, {23, T("Xenon Headlights")}}

Vehopts = {{1, T("Spoilers")}, {2, T("Front Bumper / Countermeasures")}, {3, T("Rear Bumper")}, {4, T("Side Skirt")},
           {5, T("Exhaust")}, {6, T("Frame")}, {7, T("Grille")}, {8, T("Hood")}, {9, T("Fender")},
           {10, T("Right Fender")}, {11, T("Roof / Weapons")}, {12, T("Engine")}, {13, T("Brakes")},
           {14, T("Transmission")}, {15, T("Horns")}, {16, T("Suspension")}, {17, T("Armour")}, {24, T("Front Wheels")},
           {25, T("Motorcycle Back Wheel Design")}, {26, T("Plate Holders")}, {28, T("Trim Design")},
           {29, T("Ornaments")}, {31, T("Dial Design")}, {34, T("Steering Wheel")}, {35, T("Shifter Leavers")},
           {36, T("Plaques")}, {39, T("Hydraulics")}, {49, T("Livery")}}
           
Vehicle_Radio_Stations = {"RADIO_11_TALK_02", -- Blaine County Radio
"RADIO_12_REGGAE", -- The Blue Ark
"RADIO_13_JAZZ", -- Worldwide FM
"RADIO_14_DANCE_02", -- FlyLo FM
"RADIO_15_MOTOWN", -- The Lowdown 9.11
"RADIO_20_THELAB", -- The Lab
"RADIO_16_SILVERLAKE", -- Radio Mirror Park
"RADIO_17_FUNK", -- Space 103.2
"RADIO_18_90S_ROCK", -- Vinewood Boulevard Radio
"RADIO_21_DLC_XM17", -- Blonded Los Santos 97.8 FM
"RADIO_22_DLC_BATTLE_MIX1_RADIO", -- Los Santos Underground Radio
"RADIO_23_DLC_XM19_RADIO", -- iFruit Radio
"RADIO_19_USER", -- Self Radio
"RADIO_01_CLASS_ROCK", -- Los Santos Rock Radio
"RADIO_02_POP", -- Non-Stop-Pop FM
"RADIO_03_HIPHOP_NEW", -- Radio Los Santos
"RADIO_04_PUNK", -- Channel X
"RADIO_05_TALK_01", -- West Coast Talk Radio
"RADIO_06_COUNTRY", -- Rebel Radio
"RADIO_07_DANCE_01", -- Soulwax FM
"RADIO_08_MEXICAN", -- East Los FM
"RADIO_09_HIPHOP_OLD", -- West Coast Classics
"RADIO_36_AUDIOPLAYER", -- Media Player
"RADIO_35_DLC_HEI4_MLR", -- The Music Locker
"RADIO_34_DLC_HEI4_KULT", -- Kult FM
"RADIO_27_DLC_PRHEI4" -- Still Slipping Los Santos
}
Leyen = {T('Railgun'), T('Tactical Rifle'), T('Heavy Sniper MK2'), T('Combat MG MK2'), T('Special Carbine MK2'),
         T('Rockets'), T('原子能'), T('手榴弹'), T('烟雾弹'), T('霰弹枪'), T('雪球'), T('烟花')}
Leyel = {'weapon_railgun', 'WEAPON_TACTICALRIFLE', 'WEAPON_HEAVYSNIPER_MK2', 'WEAPON_COMBATMG_MK2',
         'WEAPON_SPECIALCARBINE_MK2', 'WEAPON_RPG', 'weapon_raypistol', 'weapon_grenadelauncher',
         'weapon_grenadelauncher_smoke', 'weapon_combatshotgun', 'weapon_snowball', 'weapon_firework'}
Spw = {T('Inferno'), T('Deep Five'), T('Lozspeed Mk.V'), T('Diamond Cut'), T('Chrono'), T('Feroci RR'), T('FiftyNine'),
       T('Mercie'), T('Synthetic Z'), T('Organic Type 0'), T('Endo v.1'), T('GT One'), T('Duper 7'), T('Uzer'),
       T('GroundRide'), T('S Racer'), T('Venum'), T('Cosmo'), T('Dash VIP'), T('Ice Kid'), T('Ruff Weld'),
       T('Wangan Master'), T('Super Five'), T('Endo v.2'), T('Split Six'), T('Chrome Inferno'), T('Chrome Deep Five'),
       T('Chrome Lozspeed Mk.V'), T('Chrome Diamond Cut'), T('Chrome Chrono'), T('Chrome Feroci RR'),
       T('Chrome FiftyNine'), T('Chrome Mercie'), T('Chrome Synthetic Z'), T('Chrome Organic Type 0'),
       T('Chrome Endo v.1'), T('Chrome GT One'), T('Chrome Duper 7'), T('Chrome Uzer'), T('Chrome GroundRide'),
       T('Chrome S Racer'), T('Chrome Venum'), T('Chrome Cosmo'), T('Chrome Dash VIP'), T('Chrome Ice Kid'),
       T('Chrome Ruff Weld'), T('Chrome Wangan Master'), T('Chrome Super Five'), T('Chrome Endo v.2'),
       T('Chrome Split Six')}

OBJECT_AT = {6286, 57597, 24818, 24817, 24816, 23553, 11816, 40269, 51826, 57005, 28252, 52301, 10706, 36864, 11816,
             39317, 45509, 58271, 18905, 61163, 14201, 64729, 63931, 65068, 31086, 12844}

VEH_MISSILE_SPEED = 10000

MISL_AIM = false
missile_settings = {
    radius = 300,
    speed = 100,
    los = true,
    cam = false,
    ptfx = true,
    ptfx_scale = 1,
    air_target = false,
    multitarget = false,
    multiped = false
}
missile_particles = {
    name = "exp_grd_rpg_lod",
    dictionary = "core"
}

Rocket_Hashes = {{"rpg", util.joaat("w_lr_rpg_rocket")}, {"homingrpg", util.joaat("w_lr_homing_rocket")},
                 {"oppressor2", util.joaat("w_ex_vehiclemissile_3")},
                 {"b11barrage", util.joaat("w_smug_airmissile_01b")},
                 {"b11regular", util.joaat("w_battle_airmissile_01")},
                 {"chernobog", util.joaat("w_ex_vehiclemissile_4")}, {"akula", util.joaat("w_smug_airmissile_02")},
                 {"grenadelauncher", util.joaat("w_lr_40mm")}, -- grenade launcher lmfao
{"compactemplauncher", util.joaat("w_lr_ml_40mm")}, -- compact emp launhcer lmao
{"teargas", util.joaat("w_ex_grenadesmoke")} -- tear gas grenade lmfao
}

Chosen_Rocket_Hash = Rocket_Hashes[1][2]
MISSILE_ENTITY_TABLE = {}

MISL_AIR = false

ORB_Sneaky = false

sa_fov = 180

sa_odmg = 100

CAR_S_sneaky = false
CAR_S_BLACKLIST = {}

LegitRapidFire = false
LegitRapidMS = 100
