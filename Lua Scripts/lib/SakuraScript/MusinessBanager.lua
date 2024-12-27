local ContrabandSpecialItem = {
    { 0,  get_label_text("SRC_CRG_SP_0") }, -- Ornamental Egg
    { 1,  get_label_text("SRC_CRG_SP_1") }, -- Golden Minigun
    { 2,  get_label_text("SRC_CRG_SP_2") }, -- Extra Large Diamond
    { 3,  get_label_text("SRC_CRG_SP_3") }, -- Sasquatch Hide
    { 4,  get_label_text("SRC_CRG_SP_4") }, -- Film Reel
    { 5,  get_label_text("SRC_CRG_SP_5") }, -- Rare Pocket Watch
}

local MCBusinessPropertyInfo = {
    [1]  = {name = "佩立托湾 冰毒实验室",                      coords = {x = 52.903,     y =  6338.585,  z = 31.35  }, type = 3},  -- "MP_BWH_METH_1",
    [2]  = {name = "乞力耶德山 大麻种植场",                  coords = {x = 416.7524,   y =  6520.753,  z = 27.7121}, type = 1},  -- "MP_BWH_WEED_1",
    [3]  = {name = "佩立托湾 可卡因作坊",                coords = {x = 51.7653,    y =  6486.163,  z = 31.428 }, type = 4},  -- "MP_BWH_CRACK_1",
    [4]  = {name = "佩立托湾 假钞工厂",      coords = {x = -413.6606,  y =  6171.938,  z = 31.4782}, type = 2},  -- "MP_BWH_CASH_1",
    [5]  = {name = "佩立托湾 证件伪造办公室",                coords = {x = -163.6828,  y =  6334.845,  z = 31.5808}, type = 0},  -- "MP_BWH_FAKEID_1",
    [6]  = {name = "布罗高地 冰毒实验室",                coords = {x = 1454.671,   y =  -1651.986, z = 67     }, type = 3},  -- "MP_BWH_METH_2",
    [7]  = {name = "好麦坞市区 大麻种植场",              coords = {x = 102.14,     y =  175.26,    z = 104.56 }, type = 1},  -- "MP_BWH_WEED_2",
    [8]  = {name = "摩宁坞 可卡因作坊",               coords = {x = -1462.622,  y =  -381.826,  z = 38.802 }, type = 4},  -- "MP_BWH_CRACK_2",
    [9]  = {name = "威斯普奇运河 假钞工厂", coords = {x = -1171.005,  y =  -1380.922, z = 4.937  }, type = 2},  -- "MP_BWH_CASH_2",
    [10] = {name = "纺织城 证件伪造办公室",              coords = {x = 299.071,    y =  -759.072,  z = 29.333 }, type = 0},  -- "MP_BWH_FAKEID_2",
    [11] = {name = "塞诺拉大沙漠 冰毒实验室",                   coords = {x = 201.8909,   y =  2461.782,  z = 55.6885}, type = 3},  -- "MP_BWH_METH_3",
    [12] = {name = "圣强斯基山脉 大麻种植场",                   coords = {x = 2848.369,   y =  4450.147,  z = 48.5139}, type = 1},  -- "MP_BWH_WEED_3",
    [13] = {name = "阿拉莫海 可卡因作坊",             coords = {x = 387.5332,   y =  3585.042,  z = 33.2922}, type = 4},  -- "MP_BWH_CRACK_3",
    [14] = {name = "塞诺拉大沙漠 假钞工厂",   coords = {x = 636.6344,   y =  2785.126,  z = 42.0111}, type = 2},  -- "MP_BWH_CASH_3",
    [15] = {name = "葡萄籽证件 伪造办公室",                 coords = {x = 1657.066,   y =  4851.732,  z = 41.9882}, type = 0},  -- "MP_BWH_FAKEID_3",
    [16] = {name = "港口区 冰毒实验室",                        coords = {x = 1181.44,    y =  -3113.82,  z = 6.03   }, type = 3},  -- "MP_BWH_METH_4",
    [17] = {name = "天堂岛 大麻种植场",                 coords = {x = 136.973,    y =  -2472.795, z = 5.98   }, type = 1},  -- "MP_BWH_WEED_4",
    [18] = {name = "天堂岛 可卡因作坊",            coords = {x = -253.31,    y =  -2591.15,  z = 5.97   }, type = 4},  -- "MP_BWH_CRACK_4",
    [19] = {name = "柏树公寓 假钞工厂",   coords = {x = 671.451,    y =  -2667.502, z = 6.0812 }, type = 2},  -- "MP_BWH_CASH_4",
    [20] = {name = "天堂岛 证件伪造办公室",            coords = {x = -331.52,    y =  -2778.97,  z = 5.12   }, type = 0},  -- "MP_BWH_FAKEID_4",
    [21] = {name = "塞诺拉大油田 地堡",            coords = {x = 492.8395,   y = 3014.057,   z = 39.9793}, type = 5},  -- "MP_BUNKER_1",
    [22] = {name = "塞诺拉大沙漠 地堡",               coords = {x = 849.603,    y = 3021.697,   z = 40.3076}, type = 5},  -- "MP_BUNKER_2",
    [23] = {name = "68号公路 地堡",                          coords = {x = 39.5967,    y = 2930.506,   z = 54.8034}, type = 5},  -- "MP_BUNKER_3",
    [24] = {name = "农舍 地堡",                         coords = {x = 1572.078,   y = 2226.001,   z = 77.2829}, type = 5},  -- "MP_BUNKER_4",
    [25] = {name = "黄栌路 地堡",                   coords = {x = 2110.019,   y = 3326.12,    z = 44.3526}, type = 5},  -- "MP_BUNKER_5",
    [26] = {name = "汤姆森废车场 地堡",                 coords = {x = 2489.36,    y = 3162.12,    z = 48.0015}, type = 5},  -- "MP_BUNKER_6",
    [27] = {name = "葡萄籽 地堡",                         coords = {x = 1801.273,   y = 4705.483,   z = 38.8253}, type = 5},  -- "MP_BUNKER_7",
    [28] = {name = "佩立托森林 地堡",                     coords = {x = -755.5687,  y = 5943.835,   z = 18.9008}, type = 5},  -- "MP_BUNKER_9",
    [29] = {name = "雷通峡谷 地堡",                      coords = {x = -388.8392,  y = 4340.109,   z = 55.1741}, type = 5},  -- "MP_BUNKER_10",
    [30] = {name = "桑库多 地堡",                      coords = {x = -3031.356,  y = 3334.059,   z = 9.1805 }, type = 5},  -- "MP_BUNKER_11",
    [31] = {name = "丘马什 地堡",                           coords = {x = -3157.599,  y = 1376.695,   z = 15.866 }, type = 5},  -- "MP_BUNKER_12",
}

local WarehousePropertyInfo = {
    [1]  = {name = "太平洋鱼饵仓储",        capacity = 16,      coords = {x = 54.191,    y = -2569.248,  z = 6.0046 }}, -- "MP_WHOUSE_0",
    [2]  = {name = "白寡妇车库",            capacity = 16,      coords = {x = -1083.054, y = -1261.893,  z = 5.534  }}, -- "MP_WHOUSE_1",
    [3]  = {name = "赛尔托瓦单元",          capacity = 16,      coords = {x = 896.3665,  y = -1035.749,  z = 35.1096}}, -- "MP_WHOUSE_2",
    [4]  = {name = "便利店车库",            capacity = 16,      coords = {x = 247.473,   y = -1956.943,  z = 23.1908}}, -- "MP_WHOUSE_3",
    [5]  = {name = "法拍车库",              capacity = 16,      coords = {x = -424.828,  y = 185.825,    z = 80.775 }}, -- "MP_WHOUSE_4",
    [6]  = {name = "希罗汽油工厂",          capacity = 111,     coords = {x = -1042.482, y = -2023.516,  z = 13.1616}}, -- "MP_WHOUSE_5",
    [7]  = {name = "翘臀内衣外景场地",      capacity = 42,      coords = {x = -1268.119, y = -812.2741,  z = 17.1075}}, -- "MP_WHOUSE_6",
    [8]  = {name = "贝尔吉科仓库",          capacity = 111,     coords = {x = -873.65,   y = -2735.948,  z = 13.9438}}, -- "MP_WHOUSE_7",
    [9]  = {name = "码头400号工作仓库",     capacity = 16,      coords = {x = 274.5224,  y = -3015.413,  z = 5.6993 }}, -- "MP_WHOUSE_8",
    [10] = {name = "GEE仓库",              capacity = 42,      coords = {x = 1569.69,   y = -2129.792,  z = 78.3351}}, -- "MP_WHOUSE_9",
    [11] = {name = "洛圣都海事大厦3号楼",   capacity = 42,      coords = {x = -315.551,  y = -2698.654,  z = 7.5495 }}, -- "MP_WHOUSE_10",
    [12] = {name = "火车站仓库",            capacity = 42,      coords = {x = 499.81,    y = -651.982,   z = 24.909 }}, -- "MP_WHOUSE_11",
    [13] = {name = "透心凉辅楼仓库",        capacity = 42,      coords = {x = -528.5296, y = -1784.573,  z = 21.5853}}, -- "MP_WHOUSE_12",
    [14] = {name = "废弃的工厂直销店",      capacity = 42,      coords = {x = -295.8596, y = -1353.238,  z = 31.3138}}, -- "MP_WHOUSE_13",
    [15] = {name = "折扣零售商店",          capacity = 42,      coords = {x = 349.839,   y = 328.889,    z = 104.272}}, -- "MP_WHOUSE_14",
    [16] = {name = "物流仓库",              capacity = 111,     coords = {x = 926.2818,  y = -1560.311,  z = 30.7404}}, -- "MP_WHOUSE_15",
    [17] = {name = "达内尔兄弟仓库",        capacity = 111,     coords = {x = 759.566,   y = -909.466,   z = 25.244 }}, -- "MP_WHOUSE_16",
    [18] = {name = "家具批发市场",          capacity = 111,     coords = {x = 1037.813,  y = -2173.062,  z = 31.5334}}, -- "MP_WHOUSE_17",
    [19] = {name = "柏树仓库",              capacity = 111,     coords = {x = 1019.116,  y = -2511.69,   z = 28.302 }}, -- "MP_WHOUSE_18",
    [20] = {name = "西好麦坞外景场地",      capacity = 111,     coords = {x = -245.3405, y = 203.3286,   z = 83.818 }}, -- "MP_WHOUSE_19",
    [21] = {name = "旧发电站",              capacity = 42,      coords = {x = 539.346,   y = -1945.682,  z = 24.984 }}, -- "MP_WHOUSE_20",
    [22] = {name = "沃克父子仓库",          capacity = 111,     coords = {x = 96.1538,   y = -2216.4,    z = 6.1712 }}, -- "MP_WHOUSE_21",
}

local NightclubPropertyInfo = {
    [1]  = {name = "梅萨 夜总会",           coords = {x = 757.009,   y =  -1332.32,  z = 27.1802 }},
    [2]  = {name = "密申罗 夜总会",       coords = {x = 345.7519,  y =  -978.8848, z = 29.2681 }},
    [3]  = {name = "斯卓贝利 夜总会",        coords = {x = -120.906,  y =  -1260.49,  z = 29.2088 }},
    [4]  = {name = "西好麦坞 夜总会",     coords = {x = 5.53709,   y =  221.35,    z = 107.6566}},
    [5]  = {name = "柏树公寓 夜总会",     coords = {x = 871.47,    y =  -2099.57,  z = 30.3768 }},
    [6]  = {name = "洛圣都国际机场 夜总会",              coords = {x = -676.625,  y =  -2458.15,  z = 13.8444 }},
    [7]  = {name = "天堂岛 夜总会",    coords = {x = 195.534,   y =  -3168.88,  z = 5.7903  }},
    [8]  = {name = "好麦坞市区 夜总会", coords = {x = 373.05,    y =  252.13,    z = 102.9097}},
    [9]  = {name = "佩罗 夜总会",         coords = {x = -1283.38,  y =  -649.916,  z = 26.5198 }},
    [10] = {name = "威斯普奇运河 夜总会",   coords = {x = -1174.85,  y =  -1152.3,   z = 5.56128 }},
}

local HubTypesOrderedWithLabels = {
    [0] = {name = "Cargo",      label = "运输货物"},
    [1] = {name = "Weapons",    label = "体育用品"},
    [2] = {name = "Cocaine",    label = "南美进口货"},
    [3] = {name = "Meth",       label = "药学研究产品"},
    [4] = {name = "Weed",       label = "有机农产品"},
    [5] = {name = "Forgery",    label = "印刷品"},
    [6] = {name = "Cash",       label = "印钞"},
}

local MCBusinessTypesOrderedWithLabels = {
    [0] = {name = "Forgery",    label = "伪造证件"},
    [1] = {name = "Weed",       label = "大麻"},
    [2] = {name = "Cash",       label = "假钞"},
    [3] = {name = "Meth",       label = "冰毒"},
    [4] = {name = "Cocaine",    label = "可卡因"},
    [5] = {name = "Bunker",     label = "地堡"},
}

local MyBusinesses = {
    [0] = {property = 0, type = "None"},
    [1] = {property = 0, type = "None"},
    [2] = {property = 0, type = "None"},
    [3] = {property = 0, type = "None"},
    [4] = {property = 0, type = "None"},
    [5] = {property = 0, type = "None"},

    ["Forgery"] = {slot = 0, property = 0, product = 0, supplies = 0, upgraded = false},
    ["Weed"]    = {slot = 0, property = 0, product = 0, supplies = 0, upgraded = false},
    ["Cash"]    = {slot = 0, property = 0, product = 0, supplies = 0, upgraded = false},
    ["Meth"]    = {slot = 0, property = 0, product = 0, supplies = 0, upgraded = false},
    ["Cocaine"] = {slot = 0, property = 0, product = 0, supplies = 0, upgraded = false},
    ["Bunker"]  = {slot = 0, property = 0, product = 0, supplies = 0, upgraded = false, research = 0},

    ["Hub"] = {
        ["Cargo"]   = 0, -- 0 -- CEO?
        ["Weapons"] = 0, -- 1
        ["Cocaine"] = 0, -- 2
        ["Meth"]    = 0, -- 3
        ["Weed"]    = 0, -- 4
        ["Forgery"] = 0, -- 5
        ["Cash"]    = 0, -- 6
    }
}

local MenuCurrentWarehouses = {
    [0] = {"Name", {}, ""},
    [1] = {"Name", {}, ""},
    [2] = {"Name", {}, ""},
    [3] = {"Name", {}, ""},
    [4] = {"Name", {}, ""},
}

local Selected_Warehouse = 0
local NCSafePos = {x = -1615.6832, y = -3015.7546, z = -75.204994}

local tunables_global = 262145  --1.70
local globals = {
    Hub = {
        MaxSellPrice = 4000000 - 2100000,
        ProSpd = 1000,
        SellCooldownActive = 1956863+28+1, -- appbusinesshub

        Cargo = {
            SellDefaultValue    = 10000,
            ProSpdDefaultValue  = 8400000,
            CapDefaultValue     = 50,
        },

        Weapons = {
            SellDefaultValue    = 5000,
            ProSpdDefaultValue  = 4800000,
            CapDefaultValue     = 100,
        },

        Cocaine = {
            SellDefaultValue    = 27000,
            ProSpdDefaultValue  = 14400000,
            CapDefaultValue     = 10,
        },

        Meth = {
            SellDefaultValue    = 11475,
            ProSpdDefaultValue  = 7200000,
            CapDefaultValue     = 20,
        },

        Weed = {
            SellDefaultValue    = 2025,
            ProSpdDefaultValue  = 2400000,
            CapDefaultValue     = 80,
        },

        Forgery = {
            SellDefaultValue    = 1350,
            ProSpdDefaultValue  = 1800000,
            CapDefaultValue     = 60,
        },

        Cash = {
            SellDefaultValue    = 4725,
            ProSpdDefaultValue  = 3600000,
            CapDefaultValue     = 40,
        },
    },

    MC = {
        MaxSellPrice = 2000000,

        Forgery = {
            Sell1DefaultValue   = 1350,
            Sell2DefaultValue   = 1.5,
            ProSpd1DefaultValue = 300000,
            ProSpd2DefaultValue = 300000,
            Ratio1DefaultValue  = 4,
            Ratio2DefaultValue  = 2,
            CapDefaultValue     = 60,
        },

        Cash = {
            Sell1DefaultValue   = 4725,
            Sell2DefaultValue   = 1.5,
            ProSpd1DefaultValue = 720000,
            ProSpd2DefaultValue = 720000,
            Ratio1DefaultValue  = 10,
            Ratio2DefaultValue  = 5,
            CapDefaultValue     = 40,
        },

        Cocaine = {
            Sell1DefaultValue   = 27000,
            Sell2DefaultValue   = 1.5,
            ProSpd1DefaultValue = 3000000,
            ProSpd2DefaultValue = 3000000,
            Ratio1DefaultValue  = 50,
            Ratio2DefaultValue  = 25,
            CapDefaultValue     = 10,
        },

        Meth = {
            Sell1DefaultValue   = 11475,
            Sell2DefaultValue   = 1.5,
            ProSpd1DefaultValue = 1800000,
            ProSpd2DefaultValue = 1800000,
            Ratio1DefaultValue  = 24,
            Ratio2DefaultValue  = 12,
            CapDefaultValue     = 20,
        },

        Weed = {
            Sell1DefaultValue   = 2025,
            Sell2DefaultValue   = 1.5,
            ProSpd1DefaultValue = 360000,
            ProSpd2DefaultValue = 360000,
            Ratio1DefaultValue  = 4,
            Ratio2DefaultValue  = 2,
            CapDefaultValue     = 80,
        },

        Bunker = {
            Sell1DefaultValue = 5000,
            Sell2DefaultValue = 1.5,
            ProSpd1DefaultValue = 600000,
            ProSpd2DefaultValue = 90000,
            ProSpd3DefaultValue = 90000,
            Ratio1DefaultValue = 10,
            Ratio2DefaultValue = 5,
            CapDefaultValue = 100,
        },
    },

    SafeLimit         = 300000,
    SafeStatus1       = 1663308, -- freemode, bitset below "CLUB_PAY"
    SafeStatus2       = 2707517, -- freemode

    MCSupplyTime    = 1667995+1, -- freemode, Global_1667995[iParam0] != 0; above "BPLJT_LOWW", if (!func_XXXXX(bVar1)), +1 because array

    SpecialCargoMaxSellPriceValue   = 6000000,

    SpecialCargoSellFuncSomething   = 1943366, -- gb_contraband_sell, PED::SET_PED_SHOOT_RATE(iParam0, == 1
    SpecialCargoDeliveryCrates      = 1882599+12, -- freemode, "SRC_CRG_TICKER_1", == 1

    IsUsingComputerScreen = 76498, -- freemode
}

local locals = {
    ----------------
    -- Special Cargo
    ----------------
    --appsecuroserv
    SpecialCargoSecuroString = "appsecuroserv",
    SpecialCargoSecuroArgs = 4592, -- arg count needed to properly start the script, possibly outdated
    SpecialCargoCurrentProperty = 737, -- warehouse property id (non-global-index based))
    SpecialCargoScreenStatus = 560, -- status: 3011 = sold? 1 = error, 3012 = confirm?
    SpecialCargoCratesToSell = 741, -- "MP_WH_SELL", "WH
    SpecialCargoSellFromOption = 742, -- ^^^^^^^ (not current property id, but buttons [1-3])
    SpecialCargoCurrentBitset = 561, -- ^^^^^^^ bit 13 controls if it is warehouse or securoserv
    SpecialCargoStartingPosX = 758, -- struct<3> Local_ -- float  (if distance to this from self is greater than 5f to this local, kill script)
    SpecialCargoStartingPosY = 758+1, -- ^^^^^^^
    SpecialCargoStartingPosZ = 758+2, -- ^^^^^^^

    --gb_contraband_sell
    SpecialCargoSellString = "gb_contraband_sell",
    SpecialCargoSellType = 545+584,
    SpecialCargoSellSubType = 545+7, -- return 5000;
    SpecialCargoSellAmount = 545+57, -- ^ in function below
    SpecialCargoSellStatus = 545+583,

    --gb_contraband_buy
    SpecialCargoBuyString = "gb_contraband_buy",
    SpecialCargoBuyComplete = 603+192,
    SpecialCargoBuyCollected = 603+186,
    SpecialCargoBuyCollected2 = 478,

    --appHackerTruck
    SpecialCargoBuyScreenString = "appHackerTruck",
    SpecialCargoBuyScreenArgs = 4592, -- arg count needed to properly start the script, possibly outdated

    ----------------
    -- NightClub
    ----------------
    NCSafeScriptString = "freemode",
    NCSafeTransactionStatus = 19938+1, -- , 39, 0);
    NCSafeAddMoneyAmount = 19938+2, -- same as above

    NCHubScriptString = "appbusinesshub",
    NCHubSellCooldown = 121, -- a local
    NCHubSellCooldownBit = 27, -- a bitset bit

    ----EZNCMission = ,

    ----------------
    -- MC
    ----------------
    MCSellScriptString = "gb_biker_contraband_sell",
    MCEZMissionStarted = 704+122, -- == 3 && (Local
    MCEZMission = 704+17, -- ^ function below

    MCLaptopString = "appbikerbusiness",
    MCLaptopCurrentProperty = 526, -- (iVar2 > -1 && iVar2 < 7) &&
}

-- Also search for [[update]]

--#region Generated by internal tooling
globals.Hub.Cargo.Sell = tunables_global+23969
globals.Hub.Cargo.ProSpd = tunables_global+23954
globals.Hub.Cargo.Cap = tunables_global+23976
globals.Hub.Weapons.Sell = tunables_global+23963
globals.Hub.Weapons.ProSpd = tunables_global+23948
globals.Hub.Weapons.Cap = tunables_global+23970
globals.Hub.Cocaine.Sell = tunables_global+23964
globals.Hub.Cocaine.ProSpd = tunables_global+23949
globals.Hub.Cocaine.Cap = tunables_global+23971
globals.Hub.Meth.Sell = tunables_global+23965
globals.Hub.Meth.ProSpd = tunables_global+23950
globals.Hub.Meth.Cap = tunables_global+23972
globals.Hub.Weed.Sell = tunables_global+23966
globals.Hub.Weed.ProSpd = tunables_global+23951
globals.Hub.Weed.Cap = tunables_global+23973
globals.Hub.Forgery.Sell = tunables_global+23967
globals.Hub.Forgery.ProSpd = tunables_global+23952
globals.Hub.Forgery.Cap = tunables_global+23974
globals.Hub.Cash.Sell = tunables_global+23968
globals.Hub.Cash.ProSpd = tunables_global+23953
globals.Hub.Cash.Cap = tunables_global+23975
globals.MC.Forgery.Sell1 = tunables_global+17319
globals.MC.Forgery.Sell2 = tunables_global+18875
globals.MC.Forgery.ProSpd1 = tunables_global+17293
globals.MC.Forgery.Ratio1 = tunables_global+17307
globals.MC.Forgery.Ratio2 = tunables_global+17313
globals.MC.Forgery.Cap = tunables_global+18744
globals.MC.Cash.Sell1 = tunables_global+17320
globals.MC.Cash.Sell2 = tunables_global+18875
globals.MC.Cash.ProSpd1 = tunables_global+17294
globals.MC.Cash.Ratio1 = tunables_global+17308
globals.MC.Cash.Ratio2 = tunables_global+17314
globals.MC.Cash.Cap = tunables_global+18752
globals.MC.Cocaine.Sell1 = tunables_global+17321
globals.MC.Cocaine.Sell2 = tunables_global+18875
globals.MC.Cocaine.ProSpd1 = tunables_global+17292
globals.MC.Cocaine.Ratio1 = tunables_global+17309
globals.MC.Cocaine.Ratio2 = tunables_global+17315
globals.MC.Cocaine.Cap = tunables_global+18736
globals.MC.Meth.Sell1 = tunables_global+17322
globals.MC.Meth.Sell2 = tunables_global+18875
globals.MC.Meth.ProSpd1 = tunables_global+17291
globals.MC.Meth.Ratio1 = tunables_global+17310
globals.MC.Meth.Ratio2 = tunables_global+17316
globals.MC.Meth.Cap = tunables_global+18728
globals.MC.Weed.Sell1 = tunables_global+17323
globals.MC.Weed.Sell2 = tunables_global+18875
globals.MC.Weed.ProSpd1 = tunables_global+17290
globals.MC.Weed.Ratio1 = tunables_global+17311
globals.MC.Weed.Ratio2 = tunables_global+17317
globals.MC.Weed.Cap = tunables_global+18720
globals.MC.Bunker.Sell1 = tunables_global+21254
globals.MC.Bunker.Sell2 = tunables_global+21227
globals.MC.Bunker.ProSpd1 = tunables_global+21249
globals.MC.Bunker.ProSpd2 = tunables_global+21250
globals.MC.Bunker.ProSpd3 = tunables_global+21251
globals.MC.Bunker.Ratio1 = tunables_global+21006
globals.MC.Bunker.Ratio2 = tunables_global+21007
globals.MC.Bunker.Cap = tunables_global+21248
globals.SafeCap = tunables_global+23680
globals.SafeRevenue = tunables_global+23657
globals.MCSupplyDelay = tunables_global+18764
globals.BunkSupplyDelay = tunables_global+21274
globals.SpecialCargoBypassBuyCooldown = tunables_global+15499
globals.SpecialCargoBypassSellCooldown = tunables_global+15500
globals.SpecialCargoCrateMaxThreshold = tunables_global+15731
globals.SpecialCargoRewardPerCrate = tunables_global+15752
globals.SpecialCargoCrateMultiplier3 = tunables_global+16593
globals.SpecialCargoCrateMultiplier2 = tunables_global+16594
globals.SpecialCargoCrateMultiplier1 = tunables_global+16595
globals.SpecialCargoBonus = tunables_global+15524
globals.SpecialCargoDeliveryTime = tunables_global+31874
--#endregion Generated by internal tooling

local TotalEarnedTypes = {
    --type   = {prefix = label, amount = 0}
    -- Do not use GetLabelText in here, these are prefixes and will be converted later
    safeloop = {prefix = "\n[保险箱刷钱] {1}", amount = 0},   
    specialcargo = {prefix = "\n[特种货物] {1}", amount = 0},
}

local I32_MAX = 2147483647

-----------------------------------
-- String Functions
-----------------------------------
--#region String Functions

local function ReplacePlaceholder(str, rep, num)
    local b, e = str:find("{"..num.."}")
    if b and e then
        return (str:sub(0, b-1) .. rep .. str:sub(e+1, -1))
    else
        util.log(string.format("Expected {%i} Placeholder in: %s", num, str))
        return str
    end
end

---@param label string
---@param ... string|integer
---@return string
local function GetLabelText(label, ...)
    local args = {...}
    local str = lang.get_localised(label)
    for i = 1, #args do
        str = ReplacePlaceholder(str, lang.get_localised(args[i]), i)
    end
    return str
end
local function GetLabelTextLiteral(label, ...)
    local args = {...}
    local str = lang.get_localised(label)
    for i = 1, #args do
        str = ReplacePlaceholder(str, args[i], i)
    end
    return str
end

-----------------------------------
-- Basic Functions
-----------------------------------
--#region Basic Functions

local function SetBits(int, ...)
    local bits = {...}
    for ind, bit in ipairs(bits) do
        int = int | (1 << bit)
    end
    return int
end

local function ClearBits(int, ...)
    local bits = {...}
    for ind, bit in ipairs(bits) do
        int = int & ~(1 << bit)
    end
    return int
end

local function IsBitSet(int, offset)
    return ((int >> offset) & 1) == 1
end

local prefix = "MP" .. util.get_char_slot() .. "_"
local stat_ptr = memory.alloc(4)
local function GetStatInt(stat)
    if STATS.STAT_GET_INT(util.joaat(stat), stat_ptr, -1) then
        return memory.read_int(stat_ptr)
    else
        --util.log("Failed to get stat " .. stat)
    end
    return nil
end

local function SetStatInt(stat, value)
    if STATS.STAT_SET_INT(util.joaat(stat), value, true) then
        return true
    else
        --util.log("Failed to set stat "..stat.." to "..value)
    end
    return false
end

local function GetGlobalInt(address)
    return memory.read_int(memory.script_global(address))
end

local function SetGlobalInt(address, value)
    memory.write_int(memory.script_global(address), value)
end

local function SetGlobalFloat(address, value)
    memory.write_float(memory.script_global(address), value)
end

local function SetGlobalBits(address, ...)
    local value = GetGlobalInt(address)
    if value then
        return SetGlobalInt(address, SetBits(value, ...))
    end
end

local function GetLocalFloat(script_str, script_local)
    local addr = memory.script_local(script_str, script_local)
    return addr ~= 0 and memory.read_float(addr) or nil
end

local function GetLocalString(script_str, script_local)
    local addr = memory.script_local(script_str, script_local)
    return addr ~= 0 and memory.read_string(addr) or nil
end

local function ClearGlobalBits(address, ...)
    local value = GetGlobalInt(address)
    if value then
        return SetGlobalInt(address, ClearBits(value, ...))
    end
end

local function SetLocalInt(script_str, script_local, value)
    local addr = memory.script_local(script_str, script_local)
    if addr ~= 0 then
        memory.write_int(addr, value)
    end
    return addr ~= 0
end

local function GetLocalInt(script_str, script_local)
    local addr = memory.script_local(script_str, script_local)
    return addr ~= 0 and memory.read_int(addr) or nil
end

local function SetLocalInt(script_str, script_local, value)
    local addr = memory.script_local(script_str, script_local)
    if addr ~= 0 then
        memory.write_int(addr, value)
    end
    return addr ~= 0
end

local function SetLocalFloat(script_str, script_local, value)
    local addr = memory.script_local(script_str, script_local)
    if addr ~= 0 then
        memory.write_float(addr, value)
    end
    return addr ~= 0
end

local function SetLocalBits(script_str, script_local, ...)
    local value = GetLocalInt(script_str, script_local)
    if value then
        return SetLocalInt(script_str, script_local, SetBits(value, ...))
    end
end

local function IsScriptRunning(str)
    return SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat(str)) > 0
end

local function StartScript(str, arg_count)
    if not SCRIPT.DOES_SCRIPT_EXIST(str) then
        return false
    end
    if IsScriptRunning(str) then
        return true
    end
    SCRIPT.REQUEST_SCRIPT(str)
    while not SCRIPT.HAS_SCRIPT_LOADED (str) do
        util.yield()
    end
    SYSTEM.START_NEW_SCRIPT(str, arg_count or 0)
    SCRIPT.SET_SCRIPT_AS_NO_LONGER_NEEDED(str)
    return true
end

local function IsInSession()
    return util.is_session_started() and not util.is_session_transition_active()
end

local function SetEntityCoords(entity, coords)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(entity, coords.x, coords.y, coords.z, false, false, false)
end

local function TeleportTo(coords)
    local ent = entities.get_user_vehicle_as_handle(false)
    if ent == INVALID_GUID then ent = players.user_ped() end
    SetEntityCoords(ent, coords)
end

local function LoadArea(coords)
    local has_ground, ground_z = util.get_ground_z(coords.x, coords.y, coords.z)
    if not has_ground then
        local rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
        local cam = CAM.CREATE_CAM_WITH_PARAMS("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z+2, rot.x, rot.y, rot.z, CAM.GET_FINAL_RENDERED_CAM_FOV(), true, 2)
        CAM.SET_CAM_ACTIVE(cam, true)
        CAM.RENDER_SCRIPT_CAMS(true, false, 0, false, false, 0)
        local count = 0
        local max = 500
        while not has_ground and count < max do
            has_ground, ground_z = util.get_ground_z(coords.x, coords.y, coords.z+count)
            count = count + 1
            util.yield()
        end
        CAM.RENDER_SCRIPT_CAMS(false, false, 0, false, false, 0)
        CAM.SET_CAM_ACTIVE(cam, false)
        CAM.DESTROY_CAM(cam, false)
        return max > count
    end
    return true
end

--------------------------------
-- Global Functions
-----------------------------------
--#region Global Functions

-- [[update]]
local function GetOrgOffset()  --1.70
    -- GPBD_FM_3 freemode.c
    return (1887549 + 1 + (players.user() * 611) + 10)
end

local function IsInOrg()
    return GetGlobalInt(GetOrgOffset()) ~= -1
end

local function RegisterAsCEO()
    if IsInSession() and not IsInOrg() then
        SetGlobalInt(GetOrgOffset(), players.user()) -- Set self as boss
        SetGlobalInt(GetOrgOffset() + 430, 0) -- Set type to CEO
    end
end

-- Business / Other Online Work Stuff [[update]]  1.70
local function GetOnlineWorkOffset()
    -- GLOBAL_PLAYER_STAT
    return (1845221 + 1 + (players.user() * 889) + 268)
end

local function GetNightClubHubOffset()
    return (GetOnlineWorkOffset() + 316)  --1.70
end

local function GetNightClubOffset()
    return (GetOnlineWorkOffset() + 360) -- CLUB_OWNER_X  --1.70
end

local function GetWarehouseOffset()
    return (GetOnlineWorkOffset() + 122) + 1  --1.70
end

local function GetMCBusinessOffset()
    return (GetOnlineWorkOffset() + 199) + 1 --1.70
end

-- Nightclub
local function GetHubValueOffsetFromSlot(slot) 
    return (GetNightClubHubOffset() + 8 + 1) + slot
end

local function GetHubValueFromSlot(slot)
    return GetGlobalInt(GetHubValueOffsetFromSlot(slot))
end

local function GetSafeCashValueFromStat()
    return GetStatInt(prefix .. "CLUB_SAFE_CASH_VALUE")
end

local function GetNightClubPropertyID()
    return GetGlobalInt(GetNightClubOffset())
end

-- MC Businesses
local function GetMCBusinessDataOffset(slot)
    return GetMCBusinessOffset() + (slot * 13)
end

local function GetMCBusinessProductionSpeed2(slot)
    return GetMCBusinessDataOffset(slot) + 9
end

local function GetBusinessSuppliesFromStat(slot)
    return GetStatInt(prefix .. "MATTOTALFORFACTORY" .. slot)
end

local function GetBusinessProductFromStat(slot)
    return GetStatInt(prefix .. "PRODTOTALFORFACTORY" .. slot)
end

local function GetBunkerResearchFromStat()
    return GetStatInt(prefix .. "RESEARCHTOTALFORFACTORY5")
end

-- Special Cargo
local function GetSpecialCargoCrateAmountOffset(slot)
    return GetWarehouseOffset() + (slot * 3) + 1
end

local function GetSpecialCargoCrateAmount(warehouse)
    return GetGlobalInt(GetSpecialCargoCrateAmountOffset(warehouse))
end
--#endregion Global Functions

local function PopulateMyBusinessesTable()
    if util.is_session_started() then
        for slot = 0, 4 do
            local property      = GetStatInt(prefix .. "factoryslot" .. slot) -- returns a property ID number
            local property_info = MCBusinessPropertyInfo[property]
            local type_number   = property_info and property_info.type or -1
            local type_string   = property_info and MCBusinessTypesOrderedWithLabels[type_number].name or "None"
            

            MyBusinesses[slot]         = {property = property, type = type_number}
            MyBusinesses[type_string]  = {
                slot = slot,                        property = property,
                product = GetBusinessProductFromStat(slot), supplies = GetBusinessSuppliesFromStat(slot),
            }
        end

        do -- Bunker
            local slot_and_type = 5
            local property      = GetStatInt(prefix .. "factoryslot" .. slot_and_type) -- returns a property ID number
            local type_string   = MCBusinessTypesOrderedWithLabels[slot_and_type].name
            

            MyBusinesses[slot_and_type]    = {property = property, type = slot_and_type}
            MyBusinesses[type_string]       = {property = property, slot = 5,
                product = GetBusinessProductFromStat(slot_and_type), supplies = GetBusinessSuppliesFromStat(slot_and_type),
                research = GetBunkerResearchFromStat()
            }
        end

        for index, data in pairs(HubTypesOrderedWithLabels) do
            --MyBusinesses.Hub[data.name] = GetHubProductOfType(index) -- this reads the stat, Set Product manipluates the global only. Set Max Sell Price with this wont work.
            MyBusinesses.Hub[data.name] = GetHubValueFromSlot(index) -- however, this one will work since its reading the global.
        end
    end
end

-- returns true if already alone, false if it it had to bealone
local function CheckIfAlone()
    if #players.list() > 1 then
        util.toast(lang.get_localised(MenuLabels.BEALONE_TOAST))
        menu.trigger_commands("bealone")
        util.yield(1000)
        return false
    end
    return true
end

-- [[update]]
local function GetPlayerPropertyOffset()  --1.70
    -- GlobalplayerBD
    return (2657991 + 1 + (players.user() * 467) + 324 + 8) --Global_2657971[player /*465*/].f_322.f_8  Hash - 0x3424FFB1
end

local function GetPlayerPropertyID()
    return GetGlobalInt(GetPlayerPropertyOffset())
end

local function SetPlayerPropertyID(id)
    return SetGlobalInt(GetPlayerPropertyOffset(), id)
end

local function GetWarehousePropertyFromSlot(slot)
    return GetGlobalInt(GetWarehouseOffset() + (slot * 3))
end

local function SetSpecialCargoValues(state)
    local MaxSellPrice = globals.SpecialCargoMaxSellPriceValue
    if state then
        

        util.create_thread(function()
            local warehouse = GetLocalInt(locals.SpecialCargoSecuroString, locals.SpecialCargoCurrentProperty)
            if warehouse ~= nil then
                if warehouse ~= 0 and warehouse ~= GetWarehousePropertyFromSlot(Selected_Warehouse) then
                    util.toast("您不在您当前选择的仓库里!")
                end
            end
        end)

        local crate_amount = GetSpecialCargoCrateAmount(Selected_Warehouse)

        if crate_amount > 0 then
            SetGlobalInt(globals.SpecialCargoCrateMaxThreshold, 0)
            SetGlobalInt(globals.SpecialCargoRewardPerCrate, MaxSellPrice)
            local rounded = math.floor(100 / crate_amount)
            local ceiled  = math.ceil(100 / crate_amount)
            if (crate_amount <= 6) or (crate_amount >= 100) then
                SetGlobalInt(globals.SpecialCargoCrateMultiplier3, ceiled)
                SetGlobalInt(globals.SpecialCargoCrateMultiplier2, ceiled)
                SetGlobalInt(globals.SpecialCargoCrateMultiplier1, ceiled)
            else
                SetGlobalInt(globals.SpecialCargoCrateMultiplier3, rounded)
                SetGlobalInt(globals.SpecialCargoCrateMultiplier2, rounded)
                SetGlobalInt(globals.SpecialCargoCrateMultiplier1, rounded)
            end
        end
    else
        SetGlobalInt(globals.SpecialCargoCrateMaxThreshold, 111) -- 111
        SetGlobalInt(globals.SpecialCargoRewardPerCrate,    20000) -- 20000
        SetGlobalInt(globals.SpecialCargoCrateMultiplier3,  100) -- 100
        SetGlobalInt(globals.SpecialCargoCrateMultiplier2,  50) -- 50
        SetGlobalInt(globals.SpecialCargoCrateMultiplier1,  20) -- 20
    end
end

local function GetSpecialCargoCrateAmountFromStat(slot)
    return GetStatInt(prefix .. "contotalforwhouse" .. slot) or 0
end

-- Nightclub
local function GetSafeCashValueGlobal()
    return GetGlobalInt(GetNightClubOffset() + 5)
end

local function IsPlayerInNightclub()
    return (GetPlayerPropertyID() > 101) and (GetPlayerPropertyID() < 112)
end

local function TriggerNCSafeAddMoneyTransaction(amount, bypass_rollover_protection)
    if not IsInSession() then
        return
    end
    local aaa = GetLocalInt(locals.NCSafeScriptString, locals.NCSafeAddMoneyAmount)
    if not aaa then
        return
    end
    local SafeValue = GetSafeCashValueGlobal()
    local safemax = 300000

    if not bypass_rollover_protection then
        if (SafeValue > safemax) then
            amount = I32_MAX - SafeValue + 2
        elseif (SafeValue + amount) > safemax then
            util.toast("The amount given would put you over the maximum limit! Cancelling addition.", TOAST_ALL) --! Needs a label, but this should never be seen by the user anyways
            return
        elseif (SafeValue == -2147483648) then
            amount = 2147483647
        elseif (SafeValue < 0) then
            amount = math.abs(SafeValue)
        end
    end

    SetLocalInt(locals.NCSafeScriptString, locals.NCSafeAddMoneyAmount, amount)
    SetGlobalInt(globals.SafeStatus1, ClearBits(GetGlobalInt(globals.SafeStatus1), 1))
    SetLocalInt(locals.NCSafeScriptString, locals.NCSafeTransactionStatus, 2)
    SetGlobalInt(globals.SafeStatus2, 2)
    util.yield(3000)
end



local function FixNCHubCapacities()
    SetGlobalBits((GetNightClubHubOffset() + 4), 0, 1, 2, 3, 4) -- This will correct your nightclub capacity values if for some reason rockstar decided to fuck you over, although its only a temp fix. thanks r*
end

local function SetNightclubPayTimeLeft(time)
    return SetStatInt(prefix .. "CLUB_PAY_TIME_LEFT", time or -1)
end

-- MC Business
local function ResupplyBusinessSlot(slot)
    SetGlobalInt(globals.MCSupplyTime + slot, 1)
end

local function TeleportToMCProperty(property_id)
    if property_id ~= 0 and IsInSession() then
        local coords = MCBusinessPropertyInfo[property_id].coords
        if LoadArea(coords) then
            TeleportTo(coords)
        end
    end
end

local function OpenWarehouseScreen()
    if IsInSession() then
        if not IsScriptRunning(locals.SpecialCargoSecuroString) then
            if StartScript(locals.SpecialCargoSecuroString, locals.SpecialCargoSecuroArgs) then
                if GetLocalInt(locals.SpecialCargoSecuroString, 0) then
                    SetPlayerPropertyID(GetWarehousePropertyFromSlot(Selected_Warehouse)-1) --set global current property to warehouse one
                    SetLocalBits(locals.SpecialCargoSecuroString, locals.SpecialCargoCurrentBitset, 13)
                    SetLocalInt(locals.SpecialCargoSecuroString, locals.SpecialCargoCurrentProperty, GetWarehousePropertyFromSlot(Selected_Warehouse)) --set this local to current selected warehouse property id (non-global-index based)
                    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
                    SetLocalFloat(locals.SpecialCargoSecuroString, locals.SpecialCargoStartingPosX, pos.x) -- set this local to current location every tick (if self is greater than 5f to this local, kill script)
                    SetLocalFloat(locals.SpecialCargoSecuroString, locals.SpecialCargoStartingPosY, pos.y)
                    SetLocalFloat(locals.SpecialCargoSecuroString, locals.SpecialCargoStartingPosZ, pos.z)
                    util.yield()
                    return true
                end
            end
        else
            --return true
        end
    end
end

local function OpenTerrorbyteScreen()
    if IsInSession() then
        SetGlobalInt(globals.IsUsingComputerScreen, 1)
        StartScript(locals.SpecialCargoBuyScreenString, locals.SpecialCargoBuyScreenArgs)
    end
end


local function StartSellMission()
    if IsInSession() then
        if GetLocalInt(locals.SpecialCargoSecuroString, 0) then
            SetLocalInt(locals.SpecialCargoSecuroString, locals.SpecialCargoCratesToSell, 1)
            SetLocalInt(locals.SpecialCargoSecuroString, locals.SpecialCargoSellFromOption, 1)
            SetLocalInt(locals.SpecialCargoSecuroString, locals.SpecialCargoScreenStatus, 3012)
            return true
        end
    end
end

local function sell_func_423()  -- sell_func_423
    local val = GetLocalInt(locals.SpecialCargoSellString, locals.SpecialCargoSellSubType)
    if val then
        if val == 8 or val == 11 or val == 7 then
            local val2 = GetGlobalInt(globals.SpecialCargoSellFuncSomething)
            if val2 <= 4 then
                return 3
            elseif val2 <= 9 then
                return 6
            else
                return 10
            end
        elseif val == 1 or val == 2 or val == 10 then
            return 5
        end
    end
    return 1
end

local function get_sell_mission_goal() -- sell_func_422
    local val = GetLocalInt(locals.SpecialCargoSellString, locals.SpecialCargoSellType)
    if val then
        local ret = sell_func_423()
        if val == 0 or val == 2 or val == 3 or val == 4 then
            return ret
        elseif val == 1 or val == 5 then
            return ret * 2
        elseif val == 6 or val == 7 then
            return ret * 3
        end
    end
    return -1
end

local function AutoCompleteSellMission()
    if GetLocalInt(locals.SpecialCargoSellString, 1) then -- just checking local_1 to see if script is running
        -- Enforce easiest mission / enforce no enemies mission (aka the one that doesn't auotcomplete)
        SetLocalInt(locals.SpecialCargoSellString, locals.SpecialCargoSellType, 0)
        SetLocalInt(locals.SpecialCargoSellString, locals.SpecialCargoSellSubType, 2) -- 3
        if GetLocalInt(locals.SpecialCargoSellString, locals.SpecialCargoSellStatus) ~= -1 then
            -- Okay, value is no longer -1, script is ready, so set it to the max needed to complete
            SetLocalInt(locals.SpecialCargoSellString, locals.SpecialCargoSellAmount, get_sell_mission_goal())
            return true
        end
    end
end

local function AddToTotalEarned(amount, type)
    type.amount = type.amount + amount
    local str = type and GetLabelTextLiteral(type.prefix, GetLabelTextLiteral("总收入: {1}", type.amount)) or GetLabelTextLiteral("总收入: {1}", type.amount)
    util.toast(str)
end

local function SetPlayerInOrgWork(work_id)
    if IsInSession() then
        SetGlobalInt(GetOrgOffset() + 33, work_id)
        SetGlobalInt(GetOrgOffset() + 35, work_id)
    end
end

----------------------------------
-- Start of menu options
----------------------------------

----------------------------------
-- Special Cargo Shit
----------------------------------
--#region Special Cargo Shit
local SCMan = menu.list(Musiness_Banager, "特种货物", {}, "注意: 出售价格的上限是 $600万")

    local WarehouseSelector = menu.list_select(SCMan, "选择仓库", {}, "选择要显示和修改的仓库,因为您最多可以拥有5个仓库.", MenuCurrentWarehouses, 0, function(value)
        Selected_Warehouse = value
    end)

    menu.action(SCMan, "传送到仓库", {}, "", function()
        local tbl = WarehousePropertyInfo[GetWarehousePropertyFromSlot(Selected_Warehouse)]
        if tbl ~= nil then
            local pos = tbl.coords
            TeleportTo(pos)
        end
    end)

    menu.toggle_loop(SCMan, "显示器", {}, "", function()
        if IsInSession() then
            local crate_amount = GetSpecialCargoCrateAmountFromStat(Selected_Warehouse)
            local warehouse_property_info = WarehousePropertyInfo[GetWarehousePropertyFromSlot(Selected_Warehouse)]
            local capacity = warehouse_property_info and warehouse_property_info.capacity or "unk"
            util.draw_debug_text(GetLabelTextLiteral("特种货物仓库 {1}: {2}/{3}", Selected_Warehouse+1, crate_amount, capacity))
        end
    end)

    local Special_Cargo_Staff_Source = menu.list(SCMan, "员工进货", {}, "")  --1.70
        local SpecialCargoVarsNum, SpecialCargoVarsType = 1, 0
        menu.action(Special_Cargo_Staff_Source, "员工立即进货", {}, "需要在仓库外面", function()
            GLOBAL_SET_BOOL(1882747 + 4 + 1 + Selected_Warehouse, true)  --货物仓库
            SET_INT_GLOBAL(1882747 + 12, SpecialCargoVarsNum)  --货物数量
            SET_INT_GLOBAL(1882747 + 13, SpecialCargoVarsType)  --货物物品
            SET_INT_GLOBAL(1882747 + 14, 1)
        end)
        menu.slider(Special_Cargo_Staff_Source, "货物数量", { "SpecialCargoStaffNum" }, "", 1, 111, 1, 1, function(value)
            SpecialCargoVarsNum = value
        end)
        menu.list_select(Special_Cargo_Staff_Source, "货物物品", {},"同时获得一箱特殊物品", ContrabandSpecialItem, 0, function(value)
            SpecialCargoVarsType = value
        end)

    menu.toggle_loop(SCMan, "最大销售价格", {}, "将您的特种货物板条箱的出售价格更改为$600万.\n保持启用以确保对未来出售的正确计算", function()
        if IsInSession() then
            CheckIfAlone()
            SetSpecialCargoValues(true)
        end
    end, function()
        SetSpecialCargoValues(false)
    end)

    menu.toggle_loop(SCMan, "绕过购买任务冷却", {}, "让您无需等待冷却即可购买另一个新的任务", function()
        SetGlobalInt(globals.SpecialCargoBypassBuyCooldown, 0)
    end, function()
        SetGlobalInt(globals.SpecialCargoBypassBuyCooldown, 300000)
    end)

    menu.toggle_loop(SCMan, "绕过出售任务冷却", {}, "让您无需等待冷却即可出售另一个新的任务", function()
        SetGlobalInt(globals.SpecialCargoBypassSellCooldown, 0)
    end, function()
        SetGlobalInt(globals.SpecialCargoBypassSellCooldown, 1800000)
    end)

    menu.toggle_loop(SCMan, "自动完成购买任务", {}, "", function()
        if GetLocalInt(locals.SpecialCargoBuyString, 1) then -- just checking local_1 to see if script is running
            if GetLocalInt(locals.SpecialCargoBuyString, locals.SpecialCargoBuyComplete) ~= 1 then
                SetLocalInt(locals.SpecialCargoBuyString, locals.SpecialCargoBuyCollected, SetBits(GetLocalInt(locals.SpecialCargoBuyString, locals.SpecialCargoBuyCollected), 23, 24, 25)) -- set crate slots
                SetLocalInt(locals.SpecialCargoBuyString, locals.SpecialCargoBuyCollected2, SetBits(GetLocalInt(locals.SpecialCargoBuyString, locals.SpecialCargoBuyCollected2), 0, 1, 2, 4, 5, 6)) -- set crate slots
                SetLocalInt(locals.SpecialCargoBuyString, locals.SpecialCargoBuyComplete, 1) -- mark mission complete
            end
        end
    end)

    menu.toggle_loop(SCMan, "自动完成出售任务", {}, "", function()
        if IsInSession() then
            if AutoCompleteSellMission() then
                AddToTotalEarned(globals.SpecialCargoMaxSellPriceValue, TotalEarnedTypes.specialcargo)
                util.yield(1000)
                SetPlayerInOrgWork(-1)
            end
        end
    end)

    menu.action(SCMan, "打开恐霸屏幕", {}, "", function()
        if IsInSession() then
            if not IsInOrg() then
                RegisterAsCEO()
            end
            OpenTerrorbyteScreen()
        end
    end)

    menu.action(SCMan, "打开仓库屏幕", {}, "", function()
        if IsInSession() then
            if not IsInOrg() then
                RegisterAsCEO()
            end
            OpenWarehouseScreen()
            while IsScriptRunning(locals.SpecialCargoSecuroString) do
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
                SetLocalFloat(locals.SpecialCargoSecuroString, locals.SpecialCargoStartingPosX, pos.x)
                SetLocalFloat(locals.SpecialCargoSecuroString, locals.SpecialCargoStartingPosY, pos.y)
                SetLocalFloat(locals.SpecialCargoSecuroString, locals.SpecialCargoStartingPosZ, pos.z)
                util.yield()
            end
        end
    end)

    menu.action(SCMan, "出售一个特种货物板条箱", {}, "自动出售一个特种货物板条箱", function()
        if IsInSession() then
            SetPlayerPropertyID(-1) -- I mean, the script will end up kicking you out of your interior to begin the sell mission anyways

            if not IsInOrg() then
                RegisterAsCEO()
                util.yield()
            end

            local crates_amount_offset = (GetWarehouseOffset() + (Selected_Warehouse * 3) + 1)
            local stat_amount = GetSpecialCargoCrateAmountFromStat(Selected_Warehouse) or 0
            SetGlobalInt(crates_amount_offset, stat_amount or 0)

            if OpenWarehouseScreen() or IsScriptRunning(locals.SpecialCargoSecuroString) then
                util.yield()
                if GetSpecialCargoCrateAmountFromStat(Selected_Warehouse) > 0 then
                    StartSellMission()
                    SetPlayerPropertyID(-1)
                else
                    util.toast("您的仓库里已经没有板条箱了!")
                end
            end
        end
    end)

    menu.toggle_loop(SCMan, "最大板条箱获取量", {}, "设置您的员工将交付的板条箱数量", function()
        if IsInSession() then
            local crate_amount = GetSpecialCargoCrateAmountFromStat(Selected_Warehouse)
            local warehouse_property_info = WarehousePropertyInfo[GetWarehousePropertyFromSlot(Selected_Warehouse)]
            if warehouse_property_info then
                local capacity = warehouse_property_info.capacity
                SetGlobalInt(globals.SpecialCargoDeliveryCrates, capacity - 1)
            end
        end
    end)
    
    menu.toggle_loop(SCMan, "尽量缩短交货时间", {}, "将员工交付之前经过的时间数值设置为零", function()
        if IsInSession() then
            SetGlobalInt(globals.SpecialCargoDeliveryTime, 0)
        end
    end)

----------------------------------
-- Nightclub Shit
----------------------------------
--#region Nightclub Shit
local NCMan = menu.list(Musiness_Banager, "夜总会", {}, "注意: 出售价格的上限是 $400万.\n不要试图出售全部货物")

    menu.toggle_loop(NCMan, "显示器", {}, "", function()
        if IsInSession() then
            local safeval = GetSafeCashValueFromStat()
            util.draw_debug_text(GetLabelTextLiteral("夜总会保险箱 $: {1}", safeval))
        end
    end)

    menu.action(NCMan, "传送到夜总会", {}, "", function()
        if IsInSession() then
            local property = GetNightClubPropertyID()
            if property ~= 0 and IsInSession() then
                local coords = NightclubPropertyInfo[property].coords
                if LoadArea(coords) then
                    TeleportTo(coords)
                end
            end
        end
    end)


    -- Generate Nightclub options
    for index = 0, #HubTypesOrderedWithLabels do
        local name = HubTypesOrderedWithLabels[index].name
        local label = HubTypesOrderedWithLabels[index].label
        local list = menu.list(NCMan, label)

        menu.toggle_loop(list, "显示器", {}, "", function()
            if IsInSession() then
                local value = GetGlobalInt(globals.Hub[name].Cap)
                util.draw_debug_text(GetLabelTextLiteral("夜总会仓库 {1}: {2}/{3}", lang.get_localised(label), MyBusinesses.Hub[name], value))
            end
        end)

        menu.toggle_loop(list, "最大销售价格", {}, "以尽可能高的价格出售您的货物", function()
            if IsInSession() then
                if MyBusinesses.Hub[name] ~= 0 then
                    CheckIfAlone()
                    SetGlobalInt(globals.Hub[name].Sell, globals.Hub.MaxSellPrice // MyBusinesses.Hub[name])
                end
            end
        end, function()
            SetGlobalInt(globals.Hub[name].Sell, globals.Hub[name].SellDefaultValue)
        end)

        local toggle_active
        menu.toggle(list, "最大生产速度", {}, "将在一个产品完成生产后生效", function(toggle)
            toggle_active = toggle
            if toggle then
                --! Missing Global Here (one that goes into effect immediately)
                util.toast("已最大化生产速度. 将在生产出一个产品后生效")
            end
            while toggle_active do
                if IsInSession() then
                    SetGlobalInt(globals.Hub[name].ProSpd, globals.Hub.ProSpd)
                end
                util.yield()
            end
        end)

        menu.click_slider(list, "最大容量", {}, "影响您库存可持有的最大容量", 1, 999, GetGlobalInt(globals.Hub[name].Cap), 5, function(value)
            if IsInSession() then
                SetGlobalInt(globals.Hub[name].Cap, value)
                util.toast("已修改最大容量")
            end
        end)
    end


    local NCSafe = menu.list(NCMan, "夜总会保险箱")

        menu.action(NCSafe, "传送到夜总会保险柜", {}, "", function()
            if IsInSession() then
                if IsPlayerInNightclub() then
                    TeleportTo(NCSafePos)
                else
                    util.toast("您不在您的夜总会!")
                    menu.trigger_commands("tpnightclub")
                end
            end
        end)

        menu.action(NCSafe, "满夜总会人气", {}, "将您的夜总会人气设置为 100%.", function()
            if IsInSession() then
                menu.trigger_commands("clubpopularity 100")
                util.toast("已最大化夜总会的人气")
            end
        end)

        menu.action(NCSafe, "修改保险箱金额", {}, "使每日收入立即生效.", function()
            if IsInSession() then
                if SetNightclubPayTimeLeft(-1) then
                    util.toast("每日收入已触发")
                end
            end
        end)

        menu.click_slider(NCSafe, "最大容量", {"setcapncsafe"}, "影响您库存可持有的最大容量", 1, 300000, 210000, 10000, function(value)
            if IsInSession() then
                local address = memory.script_global(globals.SafeCap)
                memory.write_int(address, value)
                util.toast("已修改最大容量")
            end
        end)

        menu.action(NCSafe, "重置保险箱数值", {}, "如果您的夜总会保险箱高于$30万或低于$0,那该功能应该可以解决此问题.", function()
            local GetSafeValue = GetSafeCashValueFromStat
            if not (IsInSession() and (GetSafeValue() > 300000 or GetSafeValue() < 0)) then
                util.toast("您的夜总会保险箱似乎没问题")
                return
            end
            while IsInSession() and (GetSafeValue() > 300000 or GetSafeValue() < 0) do
                if IsPlayerInNightclub() then
                    TeleportTo({x = -1620.5, y = -3014.9, z = -75.2})
                end
                local before = GetSafeValue()
                TriggerNCSafeAddMoneyTransaction(300000, false)
                local after = GetSafeValue()
                if before == after then
                    util.toast("您的交易似乎卡住了. 请切换战局或重新启动游戏")
                    return
                elseif (after <= 300000 and after >= 0) then
                    util.toast("您的夜总会保险箱现在应该已被重置")
                    return
                end
                util.yield()
            end
        end)

--#endregion Nightclub Shit

----------------------------------
-- MC Club Shit
----------------------------------
--#region MC Club Shit
local MCMan = menu.list(Musiness_Banager, "摩托帮产业", {}, "注意: 出售价格的上限是 $250万")

    menu.toggle_loop(MCMan, "执行最简单的任务", {}, "这将确保您始终获得最快和最简单的出售任务. 虽然,如果您太快,您可能不会得到报酬?", function()
        local value = GetLocalInt(locals.MCSellScriptString, locals.MCEZMission)
        if value and value ~= 0 then
            SetLocalInt(locals.MCSellScriptString, locals.MCEZMission, 0)
        end
    end)

    -- Generate MC Business options
    for index = 0, 4 do
        local name = MCBusinessTypesOrderedWithLabels[index].name
        local label = MCBusinessTypesOrderedWithLabels[index].label
        

        local list = menu.list(MCMan, label)

        menu.toggle_loop(list, "显示器", {}, "", function()
            if IsInSession() then
                local capacity = GetGlobalInt(globals.MC[name].Cap)
                util.draw_debug_text(GetLabelTextLiteral("摩托帮 {1}: {2}% | {3}/{4}", lang.get_localised(label), MyBusinesses[name].supplies, MyBusinesses[name].product, capacity))
            end
        end)

        menu.toggle_loop(list, "补满原材料", {}, "", function()
            if IsInSession() then
                if MyBusinesses[name].property ~= 0 then
                    if MyBusinesses[name].supplies < 50 then
                        ResupplyBusinessSlot(MyBusinesses[name].slot)
                        util.yield(5000)
                    end
                end
            end
        end)

        menu.toggle_loop(list, "最大销售价格", {}, "以尽可能高的价格出售您的货物", function()
            if IsInSession() then
                if MyBusinesses[name].property ~= 0 then
                    CheckIfAlone()
                    if MyBusinesses[name].product > 0 then
                        SetGlobalInt(globals.MC[name].Sell1, globals.MC.MaxSellPrice // MyBusinesses[name].product)
                        SetGlobalFloat(globals.MC[name].Sell2, 1)
                    end
                end
            end
        end, function()
            SetGlobalInt(globals.MC[name].Sell1, globals.MC[name].Sell1DefaultValue)
            SetGlobalFloat(globals.MC[name].Sell2, globals.MC[name].Sell2DefaultValue)
        end)

        local var
        menu.toggle(list, "最大生产速度", {}, "立即生产", function(toggle)
            var = toggle
            if var then
                SetGlobalInt(GetMCBusinessProductionSpeed2(MyBusinesses[name].slot), 0)
                util.toast("已最大化生产速度")
            end
            while var do
                SetGlobalInt(globals.MC[name].ProSpd1, 500)
                util.yield()
            end
            SetGlobalInt(globals.MC[name].ProSpd1, globals.MC[name].ProSpd1DefaultValue)
        end)

        menu.click_slider(list, "原材料->产品比例", {}, "设置生产一种产品所需的原材料数量. 较低的值意味着更高的效率.", 1, 4, 1, 1, function(value)
            if IsInSession() then
                SetGlobalInt(globals.MC[name].Ratio1, value)
                SetGlobalInt(globals.MC[name].Ratio2, value)
                util.toast("比例已修改")
            end
        end)

        menu.click_slider(list, "最大容量", {}, "影响您库存可持有的最大容量.", 1, 999, globals.MC[name].CapDefaultValue, 1, function(value)
            if IsInSession() then
                SetGlobalInt(globals.MC[name].Cap, value)
                util.toast("已修改最大容量")
            end
        end)

        menu.action(list, "传送到产业", {}, "", function()
            if IsInSession() then
                TeleportToMCProperty(MyBusinesses[name].property)
            end
        end)
    end


--------------------------
-- Bunker Shit
--------------------------
--#region Bunker Shit
local BunkMan = menu.list(Musiness_Banager, "地堡", {}, "")
    menu.toggle_loop(BunkMan, "显示器", {}, "", function()
        if NETWORK.NETWORK_IS_SESSION_STARTED() then
            local capacity = GetGlobalInt(globals.MC.Bunker.Cap)
            util.draw_debug_text(GetLabelTextLiteral("地堡: {1}% | {2}/{3}", MyBusinesses.Bunker.supplies, MyBusinesses.Bunker.product, capacity))
        end
    end)

    menu.toggle_loop(BunkMan, "补满原材料", {}, "", function()
        if NETWORK.NETWORK_IS_SESSION_STARTED() then
            if MyBusinesses.Bunker.supplies <= 10 then
                ResupplyBusinessSlot(MyBusinesses.Bunker.slot)
                util.toast("已为你补满原材料")
            end
        end
    end)

    menu.toggle_loop(BunkMan, "最大销售价格", {}, "以尽可能高的价格出售您的货物", function()
        if NETWORK.NETWORK_IS_SESSION_STARTED() then
            if MyBusinesses.Bunker.product ~= 0 then
                CheckIfAlone()
                SetGlobalInt(globals.MC.Bunker.Sell1, 2500000 // MyBusinesses.Bunker.product)
                SetGlobalFloat(globals.MC.Bunker.Sell2, 1)
            end
        end
    end, function()
        SetGlobalInt(globals.MC.Bunker.Sell1, globals.MC.Bunker.Sell1DefaultValue)
        SetGlobalFloat(globals.MC.Bunker.Sell2, globals.MC.Bunker.Sell2DefaultValue)
    end)

    local BunkProSpdVar
    menu.toggle(BunkMan, "最大生产速度", {}, "立即生效", function(peepeepoopoo)
        BunkProSpdVar = peepeepoopoo
        if BunkProSpdVar then
            SetGlobalInt(GetMCBusinessProductionSpeed2(MyBusinesses.Bunker.slot), 0)
            util.toast("已最大化生产速度")
        else
            SetGlobalInt(globals.MC.Bunker.ProSpd1, 600000)
            SetGlobalInt(globals.MC.Bunker.ProSpd2, 90000)
            SetGlobalInt(globals.MC.Bunker.ProSpd3, 90000)
        end
        while BunkProSpdVar do
            if NETWORK.NETWORK_IS_SESSION_STARTED() then
                SetGlobalInt(globals.MC.Bunker.ProSpd1, 1000) -- base
                SetGlobalInt(globals.MC.Bunker.ProSpd2, 1000) -- equipment
                SetGlobalInt(globals.MC.Bunker.ProSpd3, 1000) -- staff upg
            end
            util.yield()
        end
    end)

    menu.click_slider(BunkMan, "原材料->产品比例", {}, "设置生产一种产品所需的原材料数量. 较低的值意味着更高的效率", 1, 10, 10, 1, function(value)
        if NETWORK.NETWORK_IS_SESSION_STARTED() then
            SetGlobalInt(globals.MC.Bunker.Ratio1, value) -- no upgrade
            SetGlobalInt(globals.MC.Bunker.Ratio2, value) -- with upgrade
            util.toast("比例已修改")
        end
    end)

    menu.click_slider(BunkMan, "最大容量", {}, "影响您库存可持有的最大容量", 1, 999, 100, 1, function(value)
        if NETWORK.NETWORK_IS_SESSION_STARTED() then
            SetGlobalInt(globals.MC.Bunker.Cap, value)
            util.toast("已修改最大容量")
        end
    end)

    menu.action(BunkMan, "传送到地堡", {}, "", function()
        TeleportToMCProperty(MyBusinesses.Bunker.property)
    end)
--#endregion Bunker Shit

--获取仓库
util.create_tick_handler(function()
    prefix = "MP" .. util.get_char_slot() .. "_" -- update our prefix live incase the user switches characters while script is running
    if IsInSession() then
        PopulateMyBusinessesTable()
        for slot = 0, 4 do
            local property_id = GetWarehousePropertyFromSlot(slot)
            if property_id ~= 0 then
                local property_name = WarehousePropertyInfo[property_id].name
                MenuCurrentWarehouses[slot] = {property_name, {"warehouse"..property_name}, "", property_id}
            else
                MenuCurrentWarehouses[slot] = {"未购买仓库", {"warehouse".."invalid"}, "您在此槽位中没有仓库!"}
            end
        end
        menu.set_list_action_options(WarehouseSelector, MenuCurrentWarehouses)
        FixNCHubCapacities()
    end
    return true
end)
