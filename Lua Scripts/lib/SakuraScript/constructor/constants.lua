-- Constructor Constants

local SCRIPT_VERSION = "0.38"
local constants = {}

constants.landing_gear_states = {
    {1,"Deployed"},
    {2,"Closing"},
    {3,"Opening"},
    {4,"Retracted"},
}

constants.ped_max_hair_tint = 63
constants.ped_max_makeup_tint = 63
constants.ped_head_overlays = {
    {
        overlay_id=0,
        name="Blemishes",
        max_index=23,
    },
    {
        overlay_id=1,
        name="Facial Hair",
        max_index=28,
    },
    {
        overlay_id=2,
        name="Eyebrows",
        max_index=33,
    },
    {
        overlay_id=3,
        name="Ageing",
        max_index=14,
    },
    {
        overlay_id=4,
        name="Makeup",
        max_index=74,
    },
    {
        overlay_id=5,
        name="Blush",
        max_index=6,
    },
    {
        overlay_id=6,
        name="Complexion",
        max_index=11,
    },
    {
        overlay_id=7,
        name="Sun Damage",
        max_index=10,
    },
    {
        overlay_id=8,
        name="Lipstick",
        max_index=9,
    },
    {
        overlay_id=9,
        name="Moles/Freckles",
        max_index=17,
    },
    {
        overlay_id=10,
        name="Chest Hair",
        max_index=16,
    },
    {
        overlay_id=11,
        name="Body Blemishes",
        max_index=11,
    },
    {
        overlay_id=12,
        name="Add Body Blemishes",
        max_index=1,
    },
}


constants.radio_station_map= {
    ["RADIO_11_TALK_02"] = "Blaine County Radio",
    ["RADIO_12_REGGAE"] = "The Blue Ark",
    ["RADIO_13_JAZZ"] = "Worldwide FM",
    ["RADIO_14_DANCE_02"] = "FlyLo FM",
    ["RADIO_15_MOTOWN"] = "The Lowdown 9.11",
    ["RADIO_20_THELAB"] = "The Lab",
    ["RADIO_16_SILVERLAKE"] = "Radio Mirror Park",
    ["RADIO_17_FUNK"] = "Space 103.2",
    ["RADIO_18_90S_ROCK"] = "Vinewood Boulevard Radio",
    ["RADIO_21_DLC_XM17"] = "Blonded Los Santos 97.8 FM",
    ["RADIO_22_DLC_BATTLE_MIX1_RADIO"] = "Los Santos Underground Radio",
    ["RADIO_23_DLC_XM19_RADIO"] = "iFruit Radio",
    ["RADIO_19_USER"] = "Self Radio",
    ["RADIO_01_CLASS_ROCK"] = "Los Santos Rock Radio",
    ["RADIO_02_POP"] = "Non-Stop-Pop FM",
    ["RADIO_03_HIPHOP_NEW"] = "Radio Los Santos",
    ["RADIO_04_PUNK"] = "Channel X",
    ["RADIO_05_TALK_01"] = "West Coast Talk Radio",
    ["RADIO_06_COUNTRY"] = "Rebel Radio",
    ["RADIO_07_DANCE_01"] = "Soulwax FM",
    ["RADIO_08_MEXICAN"] = "East Los FM",
    ["RADIO_09_HIPHOP_OLD"] = "West Coast Classics",
    ["RADIO_36_AUDIOPLAYER"] = "Media Player",
    ["RADIO_35_DLC_HEI4_MLR"] = "The Music Locker",
    ["RADIO_34_DLC_HEI4_KULT"] = "Kult FM",
    ["RADIO_27_DLC_PRHEI4"] = "Still Slipping Los Santos",
}

constants.radio_station_codes = {"OFF"}
constants.radio_station_names = {{1,"Off"}}
for code, station_name in pairs(constants.radio_station_map) do
    table.insert(constants.radio_station_codes, code)
    table.insert(constants.radio_station_names, station_name)
end

constants.rotation_orders = {
    { {1,"ZYX"}, {}, "Rotate around the z-axis, then the y-axis and finally the x-axis.", 0 },
    { {2,"YZX"}, {}, "Rotate around the y-axis, then the z-axis and finally the x-axis.", 1 },
    { {3,"ZXY"}, {}, "Rotate around the z-axis, then the x-axis and finally the y-axis.", 2 },
    { {4,"XZY"}, {}, "Rotate around the x-axis, then the z-axis and finally the y-axis.", 3 },
    { {5,"YXZ"}, {}, "Rotate around the y-axis, then the x-axis and finally the z-axis.", 4 },
    { {6,"XYZ"}, {}, "Rotate around the x-axis, then the y-axis and finally the z-axis.", 5 },
}

constants.ped_props = {
    {index=0, name="Hats"},
    {index=1, name="Glasses"},
    {index=2, name="Earrings"},
    {index=6, name="Watch"},
    {index=7, name="Bracelet"},
}

constants.ped_components = {
    {index=1, name="Mask"},
    {index=2, name="Hair"},
    {index=8, name="Shirt"},
    {index=11, name="Jacket"},
    {index=4, name="Pants"},
    {index=6, name="Shoes"},
    {index=7, name="Necktie"},
    {index=3, name="Gloves"},
    {index=5, name="Parachute / Bag"},
    {index=9, name="Body Armor"},
    {index=10, name="Decals"},
}

constants.tire_position_names = {
    { name="Front Left", index=0 },
    { name="Front Right", index=1 },
    { name="Mid Left", index=2 },
    { name="Mid Right", index=3 },
    { name="Rear Left", index=4 },
    { name="Rear Right", index=5 },
    { name="6 Wheeler Left", index=45 },
    { name="6 Wheeler Right", index=47 },
}

constants.detached_wheel_names = {
    { name="Front Left", index=0 },
    { name="Front Right", index=1 },
    { name="Mid Left", index=4 },
    { name="Mid Right", index=5 },
    { name="Rear Left", index=2 },
    { name="Rear Right", index=3 },
}

constants.door_lock_status = {
    {1,"None"},
    {2,"Unlocked"},
    {3,"Locked"},
    {4,"Lockout Player Only"},
    {5,"Locked Player Inside"},
    {6,"Locked Initially"},
    {7,"Force Shut Doors"},
    {8,"Locked by can be damaged"},
    {9,"Locked but trunk unlocked"},
    {10,"Locked, no passengers"},
    {11,"Cannot enter"},
}

constants.vehicle_paint_types = {
    {1,"Normal"}, {2,"Metallic"}, {3,"Pearl"}, {4,"Matte"}, {5,"Metal"}, {6,"Chrome"}
}

constants.headlight_colors = {
    {1,"Stock"}, {2,"White"}, {3,"Blue"}, {4,"Light Blue"}, {5,"Green"}, {6,"Lime"}, {7,"Yellow"}, {8,"Gold"}, {9,"Orange"}, {10,"Red"}, {11,"Pink"}, {12,"Hot Pink"}, {13,"Purple"}, {14,"Blacklight"}
}

constants.standard_colors = {
    {
        index=0,
        name="MetallicBlack",
        hex="#0d1116",
        rgb={r=13, g=17, b=22},
    },
    {
        index=1,
        name="MetallicGraphiteBlack",
        hex="#1c1d21",
        rgb={r=28, g=29, b=33 },
    },
    {
        index=2,
        name="MetallicBlackSteal",
        hex="#32383d",
        rgb={r=50, g=56, b=61 },
    },
    {
        index=3,
        name="MetallicDarkSilver",
        hex="#454b4f",
        rgb={r=69, g=75, b=79 },
    },
    {
        index=4,
        name="MetallicSilver",
        hex="#999da0",
        rgb={r=153, g=157, b=160 },
    },
    {
        index=5,
        name="MetallicBlueSilver",
        hex="#c2c4c6",
        rgb={r=194, g=196, b=198 },
    },
    {
        index=6,
        name="MetallicSteelGray",
        hex="#979a97",
        rgb={r=151, g=154, b=151 },
    },
    {
        index=7,
        name="MetallicShadowSilver",
        hex="#637380",
        rgb={r=99, g=115, b=128 },
    },
    {
        index=8,
        name="MetallicStoneSilver",
        hex="#63625c",
        rgb={r=99, g=98, b=92 },
    },
    {
        index=9,
        name="MetallicMidnightSilver",
        hex="#3c3f47",
        rgb={r=60, g=63, b=71 },
    },
    {
        index=10,
        name="MetallicGunMetal",
        hex="#444e54",
        rgb={r=68, g=78, b=84 },
    },
    {
        index=11,
        name="MetallicAnthraciteGrey",
        hex="#1d2129",
        rgb={r=29, g=33, b=41 },
    },
    {
        index=12,
        name="MatteBlack",
        hex="#13181f",
        rgb={r=19, g=24, b=31 },
    },
    {
        index=13,
        name="MatteGray",
        hex="#26282a",
        rgb={r=38, g=40, b=42 },
    },
    {
        index=14,
        name="MatteLightGrey",
        hex="#515554",
        rgb={r=81, g=85, b=84 },
    },
    {
        index=15,
        name="UtilBlack",
        hex="#151921",
        rgb={r=21, g=25, b=33 },
    },
    {
        index=16,
        name="UtilBlackPoly",
        hex="#1e2429",
        rgb={r=30, g=36, b=41 },
    },
    {
        index=17,
        name="UtilDarksilver",
        hex="#333a3c",
        rgb={r=51, g=58, b=60 },
    },
    {
        index=18,
        name="UtilSilver",
        hex="#8c9095",
        rgb={r=140, g=144, b=149 },
    },
    {
        index=19,
        name="UtilGunMetal",
        hex="#39434d",
        rgb={r=57, g=67, b=77 },
    },
    {
        index=20,
        name="UtilShadowSilver",
        hex="#506272",
        rgb={r=80, g=98, b=114 },
    },
    {
        index=21,
        name="WornBlack",
        hex="#1e232f",
        rgb={r=30, g=35, b=47 },
    },
    {
        index=22,
        name="WornGraphite",
        hex="#363a3f",
        rgb={r=54, g=58, b=63 },
    },
    {
        index=23,
        name="WornSilverGrey",
        hex="#a0a199",
        rgb={r=160, g=161, b=153 },
    },
    {
        index=24,
        name="WornSilver",
        hex="#d3d3d3",
        rgb={r=211, g=211, b=211 },
    },
    {
        index=25,
        name="WornBlueSilver",
        hex="#b7bfca",
        rgb={r=183, g=191, b=202 },
    },
    {
        index=26,
        name="WornShadowSilver",
        hex="#778794",
        rgb={r=119, g=135, b=148 },
    },
    {
        index=27,
        name="MetallicRed",
        hex="#c00e1a",
        rgb={r=192, g=14, b=26 },
    },
    {
        index=28,
        name="MetallicTorinoRed",
        hex="#da1918",
        rgb={r=218, g=25, b=24 },
    },
    {
        index=29,
        name="MetallicFormulaRed",
        hex="#b6111b",
        rgb={r=182, g=17, b=27 },
    },
    {
        index=30,
        name="MetallicBlazeRed",
        hex="#a51e23",
        rgb={r=165, g=30, b=35 },
    },
    {
        index=31,
        name="MetallicGracefulRed",
        hex="#7b1a22",
        rgb={r=123, g=26, b=34 },
    },
    {
        index=32,
        name="MetallicGarnetRed",
        hex="#8e1b1f",
        rgb={r=142, g=27, b=31 },
    },
    {
        index=33,
        name="MetallicDesertRed",
        hex="#6f1818",
        rgb={r=111, g=24, b=24 },
    },
    {
        index=34,
        name="MetallicCabernetRed",
        hex="#49111d",
        rgb={r=73, g=17, b=29 },
    },
    {
        index=35,
        name="MetallicCandyRed",
        hex="#b60f25",
        rgb={r=182, g=15, b=37 },
    },
    {
        index=36,
        name="MetallicSunriseOrange",
        hex="#d44a17",
        rgb={r=212, g=74, b=23 },
    },
    {
        index=37,
        name="MetallicClassicGold",
        hex="#c2944f",
        rgb={r=194, g=148, b=79 },
    },
    {
        index=38,
        name="MetallicOrange",
        hex="#f78616",
        rgb={r=247, g=134, b=22 },
    },
    {
        index=39,
        name="MatteRed",
        hex="#cf1f21",
        rgb={r=207, g=31, b=33 },
    },
    {
        index=40,
        name="MatteDarkRed",
        hex="#732021",
        rgb={r=115, g=32, b=33 },
    },
    {
        index=41,
        name="MatteOrange",
        hex="#f27d20",
        rgb={r=242, g=125, b=32 },
    },
    {
        index=42,
        name="MatteYellow",
        hex="#ffc91f",
        rgb={r=255, g=201, b=31 },
    },
    {
        index=43,
        name="UtilRed",
        hex="#9c1016",
        rgb={r=156, g=16, b=22 },
    },
    {
        index=44,
        name="UtilBrightRed",
        hex="#de0f18",
        rgb={r=222, g=15, b=24 },
    },
    {
        index=45,
        name="UtilGarnetRed",
        hex="#8f1e17",
        rgb={r=143, g=30, b=23 },
    },
    {
        index=46,
        name="WornRed",
        hex="#a94744",
        rgb={r=169, g=71, b=68 },
    },
    {
        index=47,
        name="WornGoldenRed",
        hex="#b16c51",
        rgb={r=177, g=108, b=81 },
    },
    {
        index=48,
        name="WornDarkRed",
        hex="#371c25",
        rgb={r=55, g=28, b=37 },
    },
    {
        index=49,
        name="MetallicDarkGreen",
        hex="#132428",
        rgb={r=19, g=36, b=40 },
    },
    {
        index=50,
        name="MetallicRacingGreen",
        hex="#122e2b",
        rgb={r=18, g=46, b=43 },
    },
    {
        index=51,
        name="MetallicSeaGreen",
        hex="#12383c",
        rgb={r=18, g=56, b=60 },
    },
    {
        index=52,
        name="MetallicOliveGreen",
        hex="#31423f",
        rgb={r=49, g=66, b=63 },
    },
    {
        index=53,
        name="MetallicGreen",
        hex="#155c2d",
        rgb={r=21, g=92, b=45 },
    },
    {
        index=54,
        name="MetallicGasolineBlueGreen",
        hex="#1b6770",
        rgb={r=27, g=103, b=112 },
    },
    {
        index=55,
        name="MatteLimeGreen",
        hex="#66b81f",
        rgb={r=102, g=184, b=31 },
    },
    {
        index=56,
        name="UtilDarkGreen",
        hex="#22383e",
        rgb={r=34, g=56, b=62 },
    },
    {
        index=57,
        name="UtilGreen",
        hex="#1d5a3f",
        rgb={r=29, g=90, b=63 },
    },
    {
        index=58,
        name="WornDarkGreen",
        hex="#2d423f",
        rgb={r=45, g=66, b=63 },
    },
    {
        index=59,
        name="WornGreen",
        hex="#45594b",
        rgb={r=69, g=89, b=75 },
    },
    {
        index=60,
        name="WornSeaWash",
        hex="#65867f",
        rgb={r=101, g=134, b=127 },
    },
    {
        index=61,
        name="MetallicMidnightBlue",
        hex="#222e46",
        rgb={r=34, g=46, b=70 },
    },
    {
        index=62,
        name="MetallicDarkBlue",
        hex="#233155",
        rgb={r=35, g=49, b=85 },
    },
    {
        index=63,
        name="MetallicSaxonyBlue",
        hex="#304c7e",
        rgb={r=48, g=76, b=126 },
    },
    {
        index=64,
        name="MetallicBlue",
        hex="#47578f",
        rgb={r=71, g=87, b=143 },
    },
    {
        index=65,
        name="MetallicMarinerBlue",
        hex="#637ba7",
        rgb={r=99, g=123, b=167 },
    },
    {
        index=66,
        name="MetallicHarborBlue",
        hex="#394762",
        rgb={r=57, g=71, b=98 },
    },
    {
        index=67,
        name="MetallicDiamondBlue",
        hex="#d6e7f1",
        rgb={r=214, g=231, b=241 },
    },
    {
        index=68,
        name="MetallicSurfBlue",
        hex="#76afbe",
        rgb={r=118, g=175, b=190 },
    },
    {
        index=69,
        name="MetallicNauticalBlue",
        hex="#345e72",
        rgb={r=52, g=94, b=114 },
    },
    {
        index=70,
        name="MetallicBrightBlue",
        hex="#0b9cf1",
        rgb={r=11, g=156, b=241 },
    },
    {
        index=71,
        name="MetallicPurpleBlue",
        hex="#2f2d52",
        rgb={r=47, g=45, b=82 },
    },
    {
        index=72,
        name="MetallicSpinnakerBlue",
        hex="#282c4d",
        rgb={r=40, g=44, b=77 },
    },
    {
        index=73,
        name="MetallicUltraBlue",
        hex="#2354a1",
        rgb={r=35, g=84, b=161 },
    },
    {
        index=74,
        name="MetallicBrightBlue",
        hex="#6ea3c6",
        rgb={r=110, g=163, b=198 },
    },
    {
        index=75,
        name="UtilDarkBlue",
        hex="#112552",
        rgb={r=17, g=37, b=82 },
    },
    {
        index=76,
        name="UtilMidnightBlue",
        hex="#1b203e",
        rgb={r=27, g=32, b=62 },
    },
    {
        index=77,
        name="UtilBlue",
        hex="#275190",
        rgb={r=39, g=81, b=144 },
    },
    {
        index=78,
        name="UtilSeaFoamBlue",
        hex="#608592",
        rgb={r=96, g=133, b=146 },
    },
    {
        index=79,
        name="UtilLightningblue",
        hex="#2446a8",
        rgb={r=36, g=70, b=168 },
    },
    {
        index=80,
        name="UtilMauiBluePoly",
        hex="#4271e1",
        rgb={r=66, g=113, b=225 },
    },
    {
        index=81,
        name="UtilBrightBlue",
        hex="#3b39e0",
        rgb={r=59, g=57, b=224 },
    },
    {
        index=82,
        name="MatteDarkBlue",
        hex="#1f2852",
        rgb={r=31, g=40, b=82 },
    },
    {
        index=83,
        name="MatteBlue",
        hex="#253aa7",
        rgb={r=37, g=58, b=167 },
    },
    {
        index=84,
        name="MatteMidnightBlue",
        hex="#1c3551",
        rgb={r=28, g=53, b=81 },
    },
    {
        index=85,
        name="WornDarkblue",
        hex="#4c5f81",
        rgb={r=76, g=95, b=129 },
    },
    {
        index=86,
        name="WornBlue",
        hex="#58688e",
        rgb={r=88, g=104, b=142 },
    },
    {
        index=87,
        name="WornLightblue",
        hex="#74b5d8",
        rgb={r=116, g=181, b=216 },
    },
    {
        index=88,
        name="MetallicTaxiYellow",
        hex="#ffcf20",
        rgb={r=255, g=207, b=32 },
    },
    {
        index=89,
        name="MetallicRaceYellow",
        hex="#fbe212",
        rgb={r=251, g=226, b=18 },
    },
    {
        index=90,
        name="MetallicBronze",
        hex="#916532",
        rgb={r=145, g=101, b=50 },
    },
    {
        index=91,
        name="MetallicYellowBird",
        hex="#e0e13d",
        rgb={r=224, g=225, b=61 },
    },
    {
        index=92,
        name="MetallicLime",
        hex="#98d223",
        rgb={r=152, g=210, b=35 },
    },
    {
        index=93,
        name="MetallicChampagne",
        hex="#9b8c78",
        rgb={r=155, g=140, b=120 },
    },
    {
        index=94,
        name="MetallicPuebloBeige",
        hex="#503218",
        rgb={r=80, g=50, b=24 },
    },
    {
        index=95,
        name="MetallicDarkIvory",
        hex="#473f2b",
        rgb={r=71, g=63, b=43 },
    },
    {
        index=96,
        name="MetallicChocoBrown",
        hex="#221b19",
        rgb={r=34, g=27, b=25 },
    },
    {
        index=97,
        name="MetallicGoldenBrown",
        hex="#653f23",
        rgb={r=101, g=63, b=35 },
    },
    {
        index=98,
        name="MetallicLightBrown",
        hex="#775c3e",
        rgb={r=119, g=92, b=62 },
    },
    {
        index=99,
        name="MetallicStrawBeige",
        hex="#ac9975",
        rgb={r=172, g=153, b=117 },
    },
    {
        index=100,
        name="MetallicMossBrown",
        hex="#6c6b4b",
        rgb={r=108, g=107, b=75 },
    },
    {
        index=101,
        name="MetallicBistonBrown",
        hex="#402e2b",
        rgb={r=64, g=46, b=43 },
    },
    {
        index=102,
        name="MetallicBeechwood",
        hex="#a4965f",
        rgb={r=164, g=150, b=95 },
    },
    {
        index=103,
        name="MetallicDarkBeechwood",
        hex="#46231a",
        rgb={r=70, g=35, b=26 },
    },
    {
        index=104,
        name="MetallicChocoOrange",
        hex="#752b19",
        rgb={r=117, g=43, b=25 },
    },
    {
        index=105,
        name="MetallicBeachSand",
        hex="#bfae7b",
        rgb={r=191, g=174, b=123 },
    },
    {
        index=106,
        name="MetallicSunBleechedSand",
        hex="#dfd5b2",
        rgb={r=223, g=213, b=178 },
    },
    {
        index=107,
        name="MetallicCream",
        hex="#f7edd5",
        rgb={r=247, g=237, b=213 },
    },
    {
        index=108,
        name="UtilBrown",
        hex="#3a2a1b",
        rgb={r=58, g=42, b=27 },
    },
    {
        index=109,
        name="UtilMediumBrown",
        hex="#785f33",
        rgb={r=120, g=95, b=51 },
    },
    {
        index=110,
        name="UtilLightBrown",
        hex="#b5a079",
        rgb={r=181, g=160, b=121 },
    },
    {
        index=111,
        name="MetallicWhite",
        hex="#fffff6",
        rgb={r=255, g=255, b=246 },
    },
    {
        index=112,
        name="MetallicFrostWhite",
        hex="#eaeaea",
        rgb={r=234, g=234, b=234 },
    },
    {
        index=113,
        name="WornHoneyBeige",
        hex="#b0ab94",
        rgb={r=176, g=171, b=148 },
    },
    {
        index=114,
        name="WornBrown",
        hex="#453831",
        rgb={r=69, g=56, b=49 },
    },
    {
        index=115,
        name="WornDarkBrown",
        hex="#2a282b",
        rgb={r=42, g=40, b=43 },
    },
    {
        index=116,
        name="Wornstrawbeige",
        hex="#726c57",
        rgb={r=114, g=108, b=87 },
    },
    {
        index=117,
        name="BrushedSteel",
        hex="#6a747c",
        rgb={r=106, g=116, b=124 },
    },
    {
        index=118,
        name="BrushedBlacksteel",
        hex="#354158",
        rgb={r=53, g=65, b=88 },
    },
    {
        index=119,
        name="BrushedAluminium",
        hex="#9ba0a8",
        rgb={r=155, g=160, b=168 },
    },
    {
        index=120,
        name="Chrome",
        hex="#5870a1",
        rgb={r=88, g=112, b=161 },
    },
    {
        index=121,
        name="WornOffWhite",
        hex="#eae6de",
        rgb={r=234, g=230, b=222 },
    },
    {
        index=122,
        name="UtilOffWhite",
        hex="#dfddd0",
        rgb={r=223, g=221, b=208 },
    },
    {
        index=123,
        name="WornOrange",
        hex="#f2ad2e",
        rgb={r=242, g=173, b=46 },
    },
    {
        index=124,
        name="WornLightOrange",
        hex="#f9a458",
        rgb={r=249, g=164, b=88 },
    },
    {
        index=125,
        name="MetallicSecuricorGreen",
        hex="#83c566",
        rgb={r=131, g=197, b=102 },
    },
    {
        index=126,
        name="WornTaxiYellow",
        hex="#f1cc40",
        rgb={r=241, g=204, b=64 },
    },
    {
        index=127,
        name="policecarblue",
        hex="#4cc3da",
        rgb={r=76, g=195, b=218 },
    },
    {
        index=128,
        name="MatteGreen",
        hex="#4e6443",
        rgb={r=78, g=100, b=67 },
    },
    {
        index=129,
        name="MatteBrown",
        hex="#bcac8f",
        rgb={r=188, g=172, b=143 },
    },
    {
        index=130,
        name="WornOrange",
        hex="#f8b658",
        rgb={r=248, g=182, b=88 },
    },
    {
        index=131,
        name="MatteWhite",
        hex="#fcf9f1",
        rgb={r=252, g=249, b=241 },
    },
    {
        index=132,
        name="WornWhite",
        hex="#fffffb",
        rgb={r=255, g=255, b=251 },
    },
    {
        index=133,
        name="WornOliveArmyGreen",
        hex="#81844c",
        rgb={r=129, g=132, b=76 },
    },
    {
        index=134,
        name="PureWhite",
        hex="#ffffff",
        rgb={r=255, g=255, b=255 },
    },
    {
        index=135,
        name="HotPink",
        hex="#f21f99",
        rgb={r=242, g=31, b=153 },
    },
    {
        index=136,
        name="Salmonpink",
        hex="#fdd6cd",
        rgb={r=253, g=214, b=205 },
    },
    {
        index=137,
        name="MetallicVermillionPink",
        hex="#df5891",
        rgb={r=223, g=88, b=145 },
    },
    {
        index=138,
        name="Orange",
        hex="#f6ae20",
        rgb={r=246, g=174, b=32 },
    },
    {
        index=139,
        name="Green",
        hex="#b0ee6e",
        rgb={r=176, g=238, b=110 },
    },
    {
        index=140,
        name="Blue",
        hex="#08e9fa",
        rgb={r=8, g=233, b=250 },
    },
    {
        index=141,
        name="MettalicBlackBlue",
        hex="#0a0c17",
        rgb={r=10, g=12, b=23 },
    },
    {
        index=142,
        name="MetallicBlackPurple",
        hex="#0c0d18",
        rgb={r=12, g=13, b=24 },
    },
    {
        index=143,
        name="MetallicBlackRed",
        hex="#0e0d14",
        rgb={r=14, g=13, b=20 },
    },
    {
        index=144,
        name="HunterGreen",
        hex="#9f9e8a",
        rgb={r=159, g=158, b=138 },
    },
    {
        index=145,
        name="MetallicPurple",
        hex="#621276",
        rgb={r=98, g=18, b=118 },
    },
    {
        index=146,
        name="MetaillicVDarkBlue",
        hex="#0b1421",
        rgb={r=11, g=20, b=33 },
    },
    {
        index=147,
        name="ModShopBlack1",
        hex="#11141a",
        rgb={r=17, g=20, b=26 },
    },
    {
        index=148,
        name="MattePurple",
        hex="#6b1f7b",
        rgb={r=107, g=31, b=123 },
    },
    {
        index=149,
        name="MatteDarkPurple",
        hex="#1e1d22",
        rgb={r=30, g=29, b=34 },
    },
    {
        index=150,
        name="MetallicLavaRed",
        hex="#bc1917",
        rgb={r=188, g=25, b=23 },
    },
    {
        index=151,
        name="MatteForestGreen",
        hex="#2d362a",
        rgb={r=45, g=54, b=42 },
    },
    {
        index=152,
        name="MatteOliveDrab",
        hex="#696748",
        rgb={r=105, g=103, b=72 },
    },
    {
        index=153,
        name="MatteDesertBrown",
        hex="#7a6c55",
        rgb={r=122, g=108, b=85 },
    },
    {
        index=154,
        name="MatteDesertTan",
        hex="#c3b492",
        rgb={r=195, g=180, b=146 },
    },
    {
        index=155,
        name="MatteFoilageGreen",
        hex="#5a6352",
        rgb={r=90, g=99, b=82 },
    },
    {
        index=156,
        name="DefaultAlloyColor",
        hex="#81827f",
        rgb={r=129, g=130, b=127 },
    },
    {
        index=157,
        name="EpsilonBlue",
        hex="#afd6e4",
        rgb={r=175, g=214, b=228 },
    },
    {
        index=158,
        name="PureGold",
        hex="#7a6440",
        rgb={r=122, g=100, b=64 },
    },
    {
        index=159,
        name="BrushedGold",
        hex="#7f6a48",
        rgb={r=127, g=106, b=72},
    },
}

constants.bone_index_names = {
    {
        name="Ped",
        bone_names={
            "SKEL_ROOT",
            "SKEL_Pelvis",
            "SKEL_L_Thigh",
            "SKEL_L_Calf",
            "SKEL_L_Foot",
            "SKEL_L_Toe0",
            "IK_L_Foot",
            "PH_L_Foot",
            "MH_L_Knee",
            "SKEL_R_Thigh",
            "SKEL_R_Calf",
            "SKEL_R_Foot",
            "SKEL_R_Toe0",
            "IK_R_Foot",
            "PH_R_Foot",
            "MH_R_Knee",
            "RB_L_ThighRoll",
            "RB_R_ThighRoll",
            "SKEL_Spine_Root",
            "SKEL_Spine0",
            "SKEL_Spine1",
            "SKEL_Spine2",
            "SKEL_Spine3",
            "SKEL_L_Clavicle",
            "SKEL_L_UpperArm",
            "SKEL_L_Forearm",
            "SKEL_L_Hand",
            "SKEL_L_Finger00",
            "SKEL_L_Finger01",
            "SKEL_L_Finger02",
            "SKEL_L_Finger10",
            "SKEL_L_Finger11",
            "SKEL_L_Finger12",
            "SKEL_L_Finger20",
            "SKEL_L_Finger21",
            "SKEL_L_Finger22",
            "SKEL_L_Finger30",
            "SKEL_L_Finger31",
            "SKEL_L_Finger32",
            "SKEL_L_Finger40",
            "SKEL_L_Finger41",
            "SKEL_L_Finger42",
            "PH_L_Hand",
            "IK_L_Hand",
            "RB_L_ForeArmRoll",
            "RB_L_ArmRoll",
            "MH_L_Elbow",
            "SKEL_R_Clavicle",
            "SKEL_R_UpperArm",
            "SKEL_R_Forearm",
            "SKEL_R_Hand",
            "SKEL_R_Finger00",
            "SKEL_R_Finger01",
            "SKEL_R_Finger02",
            "SKEL_R_Finger10",
            "SKEL_R_Finger11",
            "SKEL_R_Finger12",
            "SKEL_R_Finger20",
            "SKEL_R_Finger21",
            "SKEL_R_Finger22",
            "SKEL_R_Finger30",
            "SKEL_R_Finger31",
            "SKEL_R_Finger32",
            "SKEL_R_Finger40",
            "SKEL_R_Finger41",
            "SKEL_R_Finger42",
            "PH_R_Hand",
            "IK_R_Hand",
            "RB_R_ForeArmRoll",
            "RB_R_ArmRoll",
            "MH_R_Elbow",
            "SKEL_Neck_1",
            "SKEL_Head",
            "IK_Head",
            "FACIAL_facialRoot",
            "FB_L_Brow_Out_000",
            "FB_L_Lid_Upper_000",
            "FB_L_Eye_000",
            "FB_L_CheekBone_000",
            "FB_L_Lip_Corner_000",
            "FB_R_Lid_Upper_000",
            "FB_R_Eye_000",
            "FB_R_CheekBone_000",
            "FB_R_Brow_Out_000",
            "FB_R_Lip_Corner_000",
            "FB_Brow_Centre_000",
            "FB_UpperLipRoot_000",
            "FB_UpperLip_000",
            "FB_L_Lip_Top_000",
            "FB_R_Lip_Top_000",
            "FB_Jaw_000",
            "FB_LowerLipRoot_000",
            "FB_LowerLip_000",
            "FB_L_Lip_Bot_000",
            "FB_R_Lip_Bot_000",
            "FB_Tongue_000",
            "RB_Neck_1",
            "IK_Root",
        }
    },
    {
        name="Vehicle",
        bone_names={
            "chassis",
            "chassis_lowlod",
            "chassis_dummy",
            "seat_dside_f",
            "seat_dside_r",
            "seat_dside_r1",
            "seat_dside_r2",
            "seat_dside_r3",
            "seat_dside_r4",
            "seat_dside_r5",
            "seat_dside_r6",
            "seat_dside_r7",
            "seat_pside_f",
            "seat_pside_r",
            "seat_pside_r1",
            "seat_pside_r2",
            "seat_pside_r3",
            "seat_pside_r4",
            "seat_pside_r5",
            "seat_pside_r6",
            "seat_pside_r7",
            "window_lf1",
            "window_lf2",
            "window_lf3",
            "window_rf1",
            "window_rf2",
            "window_rf3",
            "window_lr1",
            "window_lr2",
            "window_lr3",
            "window_rr1",
            "window_rr2",
            "window_rr3",
            "door_dside_f",
            "door_dside_r",
            "door_pside_f",
            "door_pside_r",
            "handle_dside_f",
            "handle_dside_r",
            "handle_pside_f",
            "handle_pside_r",
            "wheel_lf",
            "wheel_rf",
            "wheel_lm1",
            "wheel_rm1",
            "wheel_lm2",
            "wheel_rm2",
            "wheel_lm3",
            "wheel_rm3",
            "wheel_lr",
            "wheel_rr",
            "suspension_lf",
            "suspension_rf",
            "suspension_lm",
            "suspension_rm",
            "suspension_lr",
            "suspension_rr",
            "spring_rf",
            "spring_lf",
            "spring_rr",
            "spring_lr",
            "transmission_f",
            "transmission_m",
            "transmission_r",
            "hub_lf",
            "hub_rf",
            "hub_lm1",
            "hub_rm1",
            "hub_lm2",
            "hub_rm2",
            "hub_lm3",
            "hub_rm3",
            "hub_lr",
            "hub_rr",
            "windscreen",
            "windscreen_r",
            "window_lf",
            "window_rf",
            "window_lr",
            "window_rr",
            "window_lm",
            "window_rm",
            "bodyshell",
            "bumper_f",
            "bumper_r",
            "wing_rf",
            "wing_lf",
            "bonnet",
            "boot",
            "exhaust",
            "exhaust_2",
            "exhaust_3",
            "exhaust_4",
            "exhaust_5",
            "exhaust_6",
            "exhaust_7",
            "exhaust_8",
            "exhaust_9",
            "exhaust_10",
            "exhaust_11",
            "exhaust_12",
            "exhaust_13",
            "exhaust_14",
            "exhaust_15",
            "exhaust_16",
            "engine",
            "overheat",
            "overheat_2",
            "petrolcap",
            "petroltank",
            "petroltank_l",
            "petroltank_r",
            "steering",
            "hbgrip_l",
            "hbgrip_r",
            "headlight_l",
            "headlight_r",
            "taillight_l",
            "taillight_r",
            "indicator_lf",
            "indicator_rf",
            "indicator_lr",
            "indicator_rr",
            "brakelight_l",
            "brakelight_r",
            "brakelight_m",
            "reversinglight_l",
            "reversinglight_r",
            "extralight_1",
            "extralight_2",
            "extralight_3",
            "extralight_4",
            "numberplate",
            "interiorlight",
            "siren1",
            "siren2",
            "siren3",
            "siren4",
            "siren5",
            "siren6",
            "siren7",
            "siren8",
            "siren9",
            "siren10",
            "siren11",
            "siren12",
            "siren13",
            "siren14",
            "siren15",
            "siren16",
            "siren17",
            "siren18",
            "siren19",
            "siren20",
            "siren_glass1",
            "siren_glass2",
            "siren_glass3",
            "siren_glass4",
            "siren_glass5",
            "siren_glass6",
            "siren_glass7",
            "siren_glass8",
            "siren_glass9",
            "siren_glass10",
            "siren_glass11",
            "siren_glass12",
            "siren_glass13",
            "siren_glass14",
            "siren_glass15",
            "siren_glass16",
            "siren_glass17",
            "siren_glass18",
            "siren_glass19",
            "siren_glass20",
            "spoiler",
            "struts",
            "misc_a",
            "misc_b",
            "misc_c",
            "misc_d",
            "misc_e",
            "misc_f",
            "misc_g",
            "misc_h",
            "misc_i",
            "misc_j",
            "misc_k",
            "misc_l",
            "misc_m",
            "misc_n",
            "misc_o",
            "misc_p",
            "misc_q",
            "misc_r",
            "misc_s",
            "misc_t",
            "misc_u",
            "misc_v",
            "misc_w",
            "misc_x",
            "misc_y",
            "misc_z",
            "misc_1",
            "misc_2",
            "weapon_1a",
            "weapon_1b",
            "weapon_1c",
            "weapon_1d",
            "weapon_1a_rot",
            "weapon_1b_rot",
            "weapon_1c_rot",
            "weapon_1d_rot",
            "weapon_2a",
            "weapon_2b",
            "weapon_2c",
            "weapon_2d",
            "weapon_2a_rot",
            "weapon_2b_rot",
            "weapon_2c_rot",
            "weapon_2d_rot",
            "weapon_3a",
            "weapon_3b",
            "weapon_3c",
            "weapon_3d",
            "weapon_3a_rot",
            "weapon_3b_rot",
            "weapon_3c_rot",
            "weapon_3d_rot",
            "weapon_4a",
            "weapon_4b",
            "weapon_4c",
            "weapon_4d",
            "weapon_4a_rot",
            "weapon_4b_rot",
            "weapon_4c_rot",
            "weapon_4d_rot",
            "turret_1base",
            "turret_1barrel",
            "turret_2base",
            "turret_2barrel",
            "turret_3base",
            "turret_3barrel",
            "ammobelt",
            "searchlight_base",
            "searchlight_light",
            "attach_female",
            "roof",
            "roof2",
            "soft_1",
            "soft_2",
            "soft_3",
            "soft_4",
            "soft_5",
            "soft_6",
            "soft_7",
            "soft_8",
            "soft_9",
            "soft_10",
            "soft_11",
            "soft_12",
            "soft_13",
            "forks",
            "mast",
            "carriage",
            "fork_l",
            "fork_r",
            "forks_attach",
            "frame_1",
            "frame_2",
            "frame_3",
            "frame_pickup_1",
            "frame_pickup_2",
            "frame_pickup_3",
            "frame_pickup_4",
            "freight_cont",
            "freight_bogey",
            "freightgrain_slidedoor",
            "door_hatch_r",
            "door_hatch_l",
            "tow_arm",
            "tow_mount_a",
            "tow_mount_b",
            "tipper",
            "combine_reel",
            "combine_auger",
            "slipstream_l",
            "slipstream_r",
            "arm_1",
            "arm_2",
            "arm_3",
            "arm_4",
            "scoop",
            "boom",
            "stick",
            "bucket",
            "shovel_2",
            "shovel_3",
            "Lookat_UpprPiston_head",
            "Lookat_LowrPiston_boom",
            "Boom_Driver",
            "cutter_driver",
            "vehicle_blocker",
            "extra_1",
            "extra_2",
            "extra_3",
            "extra_4",
            "extra_5",
            "extra_6",
            "extra_7",
            "extra_8",
            "extra_9",
            "extra_ten",
            "extra_11",
            "extra_12",
            "break_extra_1",
            "break_extra_2",
            "break_extra_3",
            "break_extra_4",
            "break_extra_5",
            "break_extra_6",
            "break_extra_7",
            "break_extra_8",
            "break_extra_9",
            "break_extra_10",
            "mod_col_1",
            "mod_col_2",
            "mod_col_3",
            "mod_col_4",
            "mod_col_5",
            "handlebars",
            "forks_u",
            "forks_l",
            "wheel_f",
            "swingarm",
            "wheel_r",
            "crank",
            "pedal_r",
            "pedal_l",
            "static_prop",
            "moving_prop",
            "static_prop2",
            "moving_prop2",
            "rudder",
            "rudder2",
            "wheel_rf1_dummy",
            "wheel_rf2_dummy",
            "wheel_rf3_dummy",
            "wheel_rb1_dummy",
            "wheel_rb2_dummy",
            "wheel_rb3_dummy",
            "wheel_lf1_dummy",
            "wheel_lf2_dummy",
            "wheel_lf3_dummy",
            "wheel_lb1_dummy",
            "wheel_lb2_dummy",
            "wheel_lb3_dummy",
            "bogie_front",
            "bogie_rear",
            "rotor_main",
            "rotor_rear",
            "rotor_main_2",
            "rotor_rear_2",
            "elevators",
            "tail",
            "outriggers_l",
            "outriggers_r",
            "rope_attach_a",
            "rope_attach_b",
            "prop_1",
            "prop_2",
            "elevator_l",
            "elevator_r",
            "rudder_l",
            "rudder_r",
            "prop_3",
            "prop_4",
            "prop_5",
            "prop_6",
            "prop_7",
            "prop_8",
            "rudder_2",
            "aileron_l",
            "aileron_r",
            "airbrake_l",
            "airbrake_r",
            "wing_l",
            "wing_r",
            "wing_lr",
            "wing_rr",
            "engine_l",
            "engine_r",
            "nozzles_f",
            "nozzles_r",
            "afterburner",
            "wingtip_1",
            "wingtip_2",
            "gear_door_fl",
            "gear_door_fr",
            "gear_door_rl1",
            "gear_door_rr1",
            "gear_door_rl2",
            "gear_door_rr2",
            "gear_door_rml",
            "gear_door_rmr",
            "gear_f",
            "gear_rl",
            "gear_lm1",
            "gear_rr",
            "gear_rm1",
            "gear_rm",
            "prop_left",
            "prop_right",
            "legs",
            "attach_male",
            "draft_animal_attach_lr",
            "draft_animal_attach_rr",
            "draft_animal_attach_lm",
            "draft_animal_attach_rm",
            "draft_animal_attach_lf",
            "draft_animal_attach_rf",
            "wheelcover_l",
            "wheelcover_r",
            "barracks",
            "pontoon_l",
            "pontoon_r",
            "no_ped_col_step_l",
            "no_ped_col_strut_1_l",
            "no_ped_col_strut_2_l",
            "no_ped_col_step_r",
            "no_ped_col_strut_1_r",
            "no_ped_col_strut_2_r",
            "light_cover",
            "emissives",
            "neon_l",
            "neon_r",
            "neon_f",
            "neon_b",
            "dashglow",
            "doorlight_lf",
            "doorlight_rf",
            "doorlight_lr",
            "doorlight_rr",
            "unknown_id",
            "dials",
            "engineblock",
            "bobble_head",
            "bobble_base",
            "bobble_hand",
            "chassis_Control"
        }
    },
    {
        name = "Weapon",
        bone_names = {
            "gun_root",
            "gun_gripr",
            "gun_gripl",
            "gun_muzzle",
            "gun_vfx_eject",
            "gun_magazine",
            "gun_ammo",
            "gun_vfx_projtrail",
            "gun_barrels",
            "WAPClip",
            "WAPClip_2",
            "WAPScop",
            "WAPScop_2",
            "WAPGrip",
            "WAPGrip_2",
            "WAPSupp",
            "WAPSupp_2",
            "WAPFlsh",
            "WAPFlsh_2",
            "WAPStck",
            "WAPSeWp",
            "WAPLasr",
            "WAPLasr_2",
            "WAPFlshLasr",
            "WAPFlshLasr_2",
            "NM_Butt_Marker",
            "Gun_GripR",
            "Gun_Nuzzle",
            "gun_drum",
        },
    },
}

constants.ped_weapons = {
    {
        name="Pistol",
        is_folder = true,
        items ={
            {
                name="Pistol",
                model="weapon_pistol",
                type="WEAPON",
            },
            {
                name="Pistol (Luxury)",
                model="weapon_pistol",
                component="COMPONENT_PISTOL_VARMOD_LUXE",
                type="WEAPON",
            },
            {
                name="Combat Pistol",
                model="COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER",
                type="WEAPON",
            },
            {
                name="AP Pistol",
                model="COMPONENT_APPISTOL_VARMOD_LUXE",
                type="WEAPON",
            },
            {
                name="Pistol .50",
                model="COMPONENT_PISTOL50_VARMOD_LUXE",
                type="WEAPON",
            },
            {
                name="SNS Pistol",
                model="COMPONENT_SNSPISTOL_VARMOD_LOWRIDER",
                type="WEAPON",
            },
            {
                name="Heavy Pistol",
                model="COMPONENT_HEAVYPISTOL_VARMOD_LUXE",
                type="WEAPON",
            },
            {
                name="SNS Pistol Mk II",
                model="WEAPON_SNSPISTOL_MK2",
                type="WEAPON",
            },
            {
                name="Up-n-Atomizer",
                model="COMPONENT_RAYPISTOL_VARMOD_XMAS18",
                type="WEAPON",
            },
            {
                name="Heavy Revolver Mk II",
                model="WEAPON_REVOLVER_MK2",
                type="WEAPON",
            },
            {
                name="Vintage Pistol",
                model="WEAPON_VINTAGEPISTOL",
                type="WEAPON",
            },
            {
                name="Double-Action Revolver",
                model="WEAPON_DOUBLEACTION",
                type="WEAPON",
            },
            {
                name="Ceramic Pistol",
                model="WEAPON_CERAMICPISTOL",
                type="WEAPON",
            },
            {
                name="Perico Pistol",
                model="WEAPON_GADGETPISTOL",
                type="WEAPON",
            },
            {
                name="Flare Gun",
                model="WEAPON_FLAREGUN",
                type="WEAPON",
            },
            {
                name="Navy Revolver",
                model="WEAPON_NAVYREVOLVER",
                type="WEAPON",
            },
            {
                name="Marksman Pistol",
                model="WEAPON_MARKSMANPISTOL",
                type="WEAPON",
            },
            {
                name="Heavy Revolver",
                model="COMPONENT_REVOLVER_VARMOD_BOSS",
                type="WEAPON",
            },
            {
                name="Pistol Mk II",
                model="WEAPON_PISTOL_MK2",
                type="WEAPON",
            }
        }
    },
    {
        name="Sub Machine Gun",
        is_folder = true,
        items = {
            {
                name="Micro SMG",
                model="COMPONENT_MICROSMG_VARMOD_LUXE",
                type="WEAPON",
            },
            {
                name="SMG",
                model="COMPONENT_SMG_VARMOD_LUXE",
                type="WEAPON",
            },
            {
                name="Assault SMG",
                model="COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER",
                type="WEAPON",
            },
            {
                name="Combat PDW",
                model="WEAPON_COMBATPDW",
                type="WEAPON",
            },
            {
                name="Machine Pistol",
                model="WEAPON_MACHINEPISTOL",
                type="WEAPON",
            },
            {
                name="Mini SMG",
                model="WEAPON_MINISMG",
                type="WEAPON",
            },
            {
                name="SMG Mk II",
                model="WEAPON_SMG_MK2",
                type="WEAPON",
            },
        }
    },
    {
        name="Machine Gun (MG)",
        is_folder = true,
        items ={
            {
                name="MG",
                model="COMPONENT_MG_VARMOD_LOWRIDER",
                type="WEAPON",
            },
            {
                name="Combat MG",
                model="WEAPON_COMBATMG",
                type="WEAPON",
            },
            {
                name="Unholy Hellbringer",
                model="WEAPON_RAYCARBINE",
                type="WEAPON",
            },
            {
                name="Gusenberg Sweeper",
                model="WEAPON_GUSENBERG",
                type="WEAPON",
            },
            {
                name="Combat MG Mk II",
                model="WEAPON_COMBATMG_MK2",
                type="WEAPON",
            },
        }
    },
    {
        name="Rifles",
        is_folder = true,
        items ={
            {
                name="Assault Rifle",
                model="COMPONENT_ASSAULTRIFLE_VARMOD_LUXE",
                type="WEAPON",
            },
            {
                name="Carbine Rifle",
                model="COMPONENT_CARBINERIFLE_VARMOD_LUXE",
                type="WEAPON",
            },
            {
                name="Advanced Rifle",
                model="WEAPON_ADVANCEDRIFLE",
                type="WEAPON",
            },
            {
                name="Bullpup Rifle",
                model="COMPONENT_BULLPUPRIFLE_VARMOD_LOW",
                type="WEAPON",
            },
            {
                name="Special Carbine",
                model="COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER",
                type="WEAPON",
            },
            {
                name="Special Carbine Mk II",
                model="WEAPON_SPECIALCARBINE_MK2",
                type="WEAPON",
            },
            {
                name="Bullpup Rifle Mk II",
                model="WEAPON_BULLPUPRIFLE_MK2",
                type="WEAPON",
            },
            {
                name="Military Rifle",
                model="WEAPON_MILITARYRIFLE",
                type="WEAPON",
            },
            {
                name="Compact Rifle",
                model="WEAPON_COMPACTRIFLE",
                type="WEAPON",
            },
            {
                name="Carbine Rifle Mk II",
                model="WEAPON_CARBINERIFLE_MK2",
                type="WEAPON",
            },
            {
                name="Assault Rifle Mk II",
                model="WEAPON_ASSAULTRIFLE_MK2",
                type="WEAPON",
            },
            {
                name="Service Carbine",
                model="WEAPON_TACTICALRIFLE",
                type="WEAPON",
            },
            {
                name="Heavy Rifle",
                model="WEAPON_HEAVYRIFLE",
                type="WEAPON",
            },
        }
    },
    {
        name="Sniper",
        is_folder = true,
        items ={
            {
                name="Sniper Rifle",
                model="WEAPON_SNIPERRIFLE",
                type="WEAPON",
            },
            {
                name="Heavy Sniper",
                model="WEAPON_HEAVYSNIPER",
                type="WEAPON",
            },
            {
                name="Marksman Rifle Mk II",
                model="WEAPON_MARKSMANRIFLE_MK2",
                type="WEAPON",
            },
            {
                name="Musket",
                model="WEAPON_MUSKET",
                type="WEAPON",
            },
            {
                name="Marksman Rifle",
                model="WEAPON_MARKSMANRIFLE",
                type="WEAPON",
            },
            {
                name="Heavy Sniper Mk II",
                model="WEAPON_HEAVYSNIPER_MK2",
                type="WEAPON",
            },
            {
                name="Precision Rifle",
                model="WEAPON_PRECISIONRIFLE",
                type="WEAPON",
            },
        }
    },
    {
        name="Melee",
        is_folder = true,
        items ={
            {
                name="Knife",
                model="WEAPON_KNIFE",
                type="WEAPON",
            },
            {
                name="Nightstick",
                model="WEAPON_NIGHTSTICK",
                type="WEAPON",
            },
            {
                name="Hammer",
                model="WEAPON_HAMMER",
                type="WEAPON",
            },
            {
                name="Baseball Bat",
                model="WEAPON_BAT",
                type="WEAPON",
            },
            {
                name="Golf Club",
                model="WEAPON_GOLFCLUB",
                type="WEAPON",
            },
            {
                name="Crowbar",
                model="WEAPON_CROWBAR",
                type="WEAPON",
            },
            {
                name="Bottle",
                model="WEAPON_BOTTLE",
                type="WEAPON",
            },
            {
                name="Antique Cavalry Dagger",
                model="WEAPON_DAGGER",
                type="WEAPON",
            },
            {
                name="Hatchet",
                model="WEAPON_HATCHET",
                type="WEAPON",
            },
            {
                name="Machete",
                model="WEAPON_MACHETE",
                type="WEAPON",
            },
            {
                name="Flashlight",
                model="WEAPON_FLASHLIGHT",
                type="WEAPON",
            },
            {
                name="Switchblade",
                model="COMPONENT_SWITCHBLADE_VARMOD_VAR1",
                type="WEAPON",
            },
            {
                name=" Battle Axe",
                model="WEAPON_BATTLEAXE",
                type="WEAPON",
            },
            {
                name="Pipe Wrench",
                model="WEAPON_WRENCH",
                type="WEAPON",
            },
            {
                name="Pool Cue ",
                model="WEAPON_POOLCUE",
                type="WEAPON",
            },
            {
                name="Stone Hatchet",
                model="WEAPON_STONE_HATCHET",
                type="WEAPON",
            },
        }
    },
    {
        name="Shotguns",
        is_folder = true,
        items ={
            {
                name="Pump Shotgun",
                model="WEAPON_PUMPSHOTGUN",
                type="WEAPON",
            },
            {
                name="Sawed-Off Shotgun",
                model="COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE",
                type="WEAPON",
            },
            {
                name="Assault Shotgun",
                model="WEAPON_ASSAULTSHOTGUN",
                type="WEAPON",
            },
            {
                name="Bullpup Shotgun",
                model="WEAPON_BULLPUPSHOTGUN",
                type="WEAPON",
            },
            {
                name="Pump Shotgun Mk II",
                model="WEAPON_PUMPSHOTGUN_MK2",
                type="WEAPON",
            },
            {
                name="Heavy Shotgun",
                model="WEAPON_HEAVYSHOTGUN",
                type="WEAPON",
            },
            {
                name="Combat Shotgun",
                model="WEAPON_COMBATSHOTGUN",
                type="WEAPON",
            },
            {
                name="Double Barrel Shotgun",
                model="WEAPON_DBSHOTGUN",
                type="WEAPON",
            },
            {
                name="Sweeper Shotgun",
                model="WEAPON_AUTOSHOTGUN",
                type="WEAPON",
            },
        }
    },
    {
        name="Heavy",
        is_folder = true,
        items ={
            {
                name="Grenade Launcher",
                model="WEAPON_GRENADELAUNCHER",
                type="WEAPON",
            },
            {
                name="Tear Gas Launcher",
                model="WEAPON_GRENADELAUNCHER_SMOKE",
                type="WEAPON",
            },
            {
                name="RPG",
                model="WEAPON_RPG",
                type="WEAPON",
            },
            {
                name="Minigun",
                model="WEAPON_MINIGUN",
                type="WEAPON",
            },
            {
                name="Widowmaker",
                model="WEAPON_RAYMINIGUN",
                type="WEAPON",
            },
            {
                name="Homing Launcher",
                model="WEAPON_HOMINGLAUNCHER",
                type="WEAPON",
            },
            {
                name="Firework Launcher",
                model="WEAPON_FIREWORK",
                type="WEAPON",
            },
            {
                name="Railgun",
                model="WEAPON_RAILGUN",
                type="WEAPON",
            },
            {
                name="Compact Grenade Launcher",
                model="WEAPON_COMPACTLAUNCHER",
                type="WEAPON",
            },
            {
                name="Compact EMP Launcher",
                model="WEAPON_EMPLAUNCHER",
                type="WEAPON",
            },
        }
    },
    {
        name="Throwables",
        is_folder = true,
        items ={
            {
                name="Grenade",
                model="WEAPON_GRENADE",
                type="WEAPON",
            },
            {
                name="Sticky Bomb",
                model="WEAPON_STICKYBOMB",
                type="WEAPON",
            },
            {
                name="Tear Gas",
                model="WEAPON_SMOKEGRENADE",
                type="WEAPON",
            },
            {
                name="Molotov",
                model="WEAPON_MOLOTOV",
                type="WEAPON",
            },
            {
                name="Baseball",
                model="WEAPON_BALL",
                type="WEAPON",
            },
            {
                name="Flare",
                model="WEAPON_FLARE",
                type="WEAPON",
            },
            {
                name="Snowball",
                model="WEAPON_SNOWBALL",
                type="WEAPON",
            },
            {
                name="Proximity Mine",
                model="WEAPON_PROXMINE",
                type="WEAPON",
            },
            {
                name="Pipe Bomb",
                model="WEAPON_PIPEBOMB",
                type="WEAPON",
            },
        }
    }
}

constants.animation_flags = {
    ANIM_FLAG_NORMAL = 0,
    ANIM_FLAG_REPEAT = 1,
    ANIM_FLAG_STOP_LAST_FRAME = 2,
    ANIM_FLAG_UPPERBODY = 16,
    ANIM_FLAG_ENABLE_PLAYER_CONTROL = 32,
    ANIM_FLAG_CANCELABLE = 120
}

constants.animations = {
    is_folder = true,
    items = { {
                  is_folder = true,
                  items = { {
                                clip = "bind_pose_180",
                                dictionary = "mp_sleep",
                                loop = true,
                                name = "A-Pose"
                            }, {
                                clip = "michael_tux_fidget",
                                controllable = true,
                                dictionary = "missmic4",
                                emote_duration = 4000,
                                name = "Adjust"
                            }, {
                                clip = "air_guitar",
                                dictionary = "anim@mp_player_intcelebrationfemale@air_guitar",
                                name = "Air Guitar"
                            }, {
                                clip = "ledge_loop",
                                controllable = true,
                                dictionary = "missfbi1",
                                loop = true,
                                name = "Air Plane"
                            }, {
                                clip = "air_synth",
                                dictionary = "anim@mp_player_intcelebrationfemale@air_synth",
                                name = "Air Synth"
                            }, {
                                clip = "actor_berating_loop",
                                controllable = true,
                                dictionary = "misscarsteal4@actor",
                                loop = true,
                                name = "Argue"
                            }, {
                                clip = "argue_a",
                                controllable = true,
                                dictionary = "oddjobs@assassinate@vice@hooker",
                                loop = true,
                                name = "Argue 2"
                            }, {
                                clip = "brotheradrianhasshown_2",
                                controllable = true,
                                dictionary = "special_ped@jane@monologue_5@monologue_5c",
                                emote_duration = 3000,
                                name = "BOI"
                            }, {
                                clip = "wakeup",
                                dictionary = "random@peyote@dog",
                                name = "Bark"
                            }, {
                                clip = "idle_a_bartender",
                                controllable = true,
                                dictionary = "anim@amb@clubhouse@bar@drink@idle_a",
                                loop = true,
                                name = "Bartender"
                            }, {
                                clip = "beast_transform",
                                controllable = true,
                                dictionary = "anim@mp_fm_event@intro",
                                emote_duration = 5000,
                                name = "Beast"
                            }, {
                                clip = "wakeup",
                                dictionary = "random@peyote@bird",
                                name = "Bird"
                            }, {
                                clip = "blow_kiss",
                                dictionary = "anim@mp_player_intcelebrationfemale@blow_kiss",
                                name = "Blow Kiss"
                            }, {
                                clip = "exit",
                                controllable = true,
                                dictionary = "anim@mp_player_intselfieblow_kiss",
                                emote_duration = 2000,
                                name = "Blow Kiss 2"
                            }, {
                                clip = "regal_c_1st",
                                controllable = true,
                                dictionary = "anim@arena@celeb@podium@no_prop@",
                                loop = true,
                                name = "Bow"
                            }, {
                                clip = "regal_a_1st",
                                controllable = true,
                                dictionary = "anim@arena@celeb@podium@no_prop@",
                                loop = true,
                                name = "Bow 2"
                            }, {
                                clip = "bring_it_on",
                                controllable = true,
                                dictionary = "misscommon@response",
                                emote_duration = 3000,
                                name = "Bring It On"
                            }, {
                                clip = "cpr_pumpchest",
                                dictionary = "mini@cpr@char_a@cpr_str",
                                loop = true,
                                name = "CPR"
                            }, {
                                clip = "cpr_pumpchest",
                                controllable = true,
                                dictionary = "mini@cpr@char_a@cpr_str",
                                loop = true,
                                name = "CPR 2"
                            }, {
                                clip = "celebrate",
                                dictionary = "rcmfanatic1celebrate",
                                loop = true,
                                name = "Celebrate"
                            }, {
                                clip = "wakeup",
                                controllable = true,
                                dictionary = "random@peyote@chicken",
                                loop = true,
                                name = "Chicken"
                            }, {
                                clip = "trev_scares_tramp_idle_tramp",
                                dictionary = "switch@trevor@scares_tramp",
                                loop = true,
                                name = "Chill"
                            }, {
                                clip = "base",
                                controllable = true,
                                dictionary = "amb@world_human_cheering@male_a",
                                loop = true,
                                name = "Clap"
                            }, {
                                clip = "angry_clap_a_player_a",
                                dictionary = "anim@arena@celeb@flat@solo@no_props@",
                                loop = true,
                                name = "Clap Angry"
                            }, {
                                clip = "trev_annoys_sunbathers_loop_girl",
                                dictionary = "switch@trevor@annoys_sunbathers",
                                loop = true,
                                name = "Cloudgaze"
                            }, {
                                clip = "trev_annoys_sunbathers_loop_guy",
                                dictionary = "switch@trevor@annoys_sunbathers",
                                loop = true,
                                name = "Cloudgaze 2"
                            }, {
                                clip = "clown_idle_0",
                                dictionary = "rcm_barry2",
                                loop = true,
                                name = "Clown"
                            }, {
                                clip = "clown_idle_1",
                                dictionary = "rcm_barry2",
                                loop = true,
                                name = "Clown 2"
                            }, {
                                clip = "clown_idle_2",
                                dictionary = "rcm_barry2",
                                loop = true,
                                name = "Clown 3"
                            }, {
                                clip = "clown_idle_3",
                                controllable = true,
                                dictionary = "rcm_barry2",
                                loop = true,
                                name = "Clown 4"
                            }, {
                                clip = "clown_idle_6",
                                dictionary = "rcm_barry2",
                                loop = true,
                                name = "Clown 5"
                            }, {
                                clip = "want_some_of_this",
                                controllable = true,
                                dictionary = "mini@triathlon",
                                emote_duration = 2000,
                                name = "Come at me bro"
                            }, {
                                clip = "rcmme_amanda1_stand_loop_cop",
                                dictionary = "anim@amb@nightclub@peds@",
                                loop = true,
                                name = "Cop 2"
                            }, {
                                clip = "idle_b",
                                dictionary = "amb@code_human_police_investigate@idle_a",
                                loop = true,
                                name = "Cop 3"
                            }, {
                                clip = "idle_cough",
                                controllable = true,
                                dictionary = "timetable@gardener@smoking_joint",
                                loop = true,
                                name = "Cough"
                            }, {
                                clip = "grid_girl_race_start",
                                controllable = true,
                                dictionary = "random@street_race",
                                loop = true,
                                name = "Countdown"
                            }, {
                                clip = "front_loop",
                                dictionary = "move_injured_ground",
                                loop = true,
                                name = "Crawl"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "amb@world_human_hang_out_street@female_arms_crossed@idle_a",
                                loop = true,
                                name = "Crossarms"
                            }, {
                                clip = "idle_b",
                                controllable = true,
                                dictionary = "amb@world_human_hang_out_street@male_c@idle_a",
                                name = "Crossarms 2"
                            }, {
                                clip = "single_team_loop_boss",
                                controllable = true,
                                dictionary = "anim@heists@heist_corona@single_team",
                                loop = true,
                                name = "Crossarms 3"
                            }, {
                                clip = "_car_b_lookout",
                                controllable = true,
                                dictionary = "random@street_race",
                                loop = true,
                                name = "Crossarms 4"
                            }, {
                                clip = "rcmme_amanda1_stand_loop_cop",
                                controllable = true,
                                dictionary = "anim@amb@nightclub@peds@",
                                loop = true,
                                name = "Crossarms 5"
                            }, {
                                clip = "_idle",
                                controllable = true,
                                dictionary = "random@shop_gunstore",
                                loop = true,
                                name = "Crossarms 6"
                            }, {
                                clip = "base_m2",
                                controllable = true,
                                dictionary = "rcmnigel1a_band_groupies",
                                loop = true,
                                name = "Crossarms Side"
                            }, {
                                clip = "sarcastic_left",
                                dictionary = "anim@mp_player_intcelebrationpaired@f_f_sarcastic",
                                name = "Curtsy"
                            }, {
                                clip = "dixn_dance_cntr_open_dix",
                                controllable = true,
                                dictionary = "anim@amb@nightclub@djs@dixon@",
                                loop = true,
                                name = "DJ"
                            }, {
                                clip = "gesture_damn",
                                controllable = true,
                                dictionary = "gestures@m@standing@casual",
                                emote_duration = 1000,
                                name = "Damn"
                            }, {
                                clip = "shoplift_mid",
                                controllable = true,
                                dictionary = "anim@am_hold_up@male",
                                emote_duration = 1000,
                                name = "Damn 2"
                            }, {
                                clip = "loop",
                                controllable = true,
                                dictionary = "mp_player_inteat@pnq",
                                emote_duration = 2500,
                                name = "Drink"
                            }, {
                                clip = "mp_player_int_eat_burger",
                                controllable = true,
                                dictionary = "mp_player_inteat@burger",
                                emote_duration = 3000,
                                name = "Eat"
                            }, {
                                clip = "agitated_idle_a",
                                controllable = true,
                                dictionary = "random@car_thief@agitated@idle_a",
                                emote_duration = 8000,
                                name = "Facepalm"
                            }, {
                                clip = "face_palm",
                                controllable = true,
                                dictionary = "anim@mp_player_intcelebrationfemale@face_palm",
                                emote_duration = 8000,
                                name = "Facepalm 2"
                            }, {
                                clip = "tasered_2",
                                controllable = true,
                                dictionary = "missminuteman_1ig_2",
                                emote_duration = 8000,
                                name = "Facepalm 3"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "anim@mp_player_intupperface_palm",
                                loop = true,
                                name = "Facepalm 4"
                            }, {
                                clip = "sleep_loop",
                                controllable = true,
                                dictionary = "mp_sleep",
                                loop = true,
                                name = "Fall Asleep"
                            }, {
                                clip = "drunk_fall_over",
                                dictionary = "random@drunk_driver_1",
                                name = "Fall Over"
                            }, {
                                clip = "pistol",
                                dictionary = "mp_suicide",
                                name = "Fall Over 2"
                            }, {
                                clip = "pill",
                                dictionary = "mp_suicide",
                                name = "Fall Over 3"
                            }, {
                                clip = "knockout_plyr",
                                dictionary = "friends@frf@ig_2",
                                name = "Fall Over 4"
                            }, {
                                clip = "victim_fail",
                                dictionary = "anim@gangops@hostage@",
                                name = "Fall Over 5"
                            }, {
                                clip = "intro_male_unarmed_c",
                                dictionary = "anim@deathmatch_intros@unarmed",
                                name = "Fight Me"
                            }, {
                                clip = "intro_male_unarmed_e",
                                dictionary = "anim@deathmatch_intros@unarmed",
                                name = "Fight Me 2"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "anim@mp_player_intselfiethe_bird",
                                loop = true,
                                name = "Finger"
                            }, {
                                clip = "idle_a_fp",
                                controllable = true,
                                dictionary = "anim@mp_player_intupperfinger",
                                loop = true,
                                name = "Finger 2"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "anim@mp_player_intupperfind_the_fish",
                                loop = true,
                                name = "Fish Dance"
                            }, {
                                clip = "flip_a_player_a",
                                dictionary = "anim@arena@celeb@flat@solo@no_props@",
                                name = "Flip"
                            }, {
                                clip = "cap_a_player_a",
                                dictionary = "anim@arena@celeb@flat@solo@no_props@",
                                name = "Flip 2"
                            }, {
                                clip = "flip_off_a_1st",
                                controllable = true,
                                dictionary = "anim@arena@celeb@podium@no_prop@",
                                name = "Flip Off"
                            }, {
                                clip = "flip_off_c_1st",
                                controllable = true,
                                dictionary = "anim@arena@celeb@podium@no_prop@",
                                name = "Flip Off 2"
                            }, {
                                clip = "stand_phone_phoneputdown_idle_nowork",
                                controllable = true,
                                dictionary = "anim@amb@business@bgen@bgen_no_work@",
                                loop = true,
                                name = "Fold Arms"
                            }, {
                                clip = "rcmme_amanda1_stand_loop_cop",
                                controllable = true,
                                dictionary = "anim@amb@nightclub@peds@",
                                loop = true,
                                name = "Fold Arms 2"
                            }, {
                                clip = "mp_player_int_gang_sign_a",
                                controllable = true,
                                dictionary = "mp_player_int_uppergang_sign_a",
                                loop = true,
                                name = "Gang Sign"
                            }, {
                                clip = "mp_player_int_gang_sign_b",
                                controllable = true,
                                dictionary = "mp_player_int_uppergang_sign_b",
                                loop = true,
                                name = "Gang Sign 2"
                            }, {
                                clip = "swing_a_mark",
                                dictionary = "rcmnigel1d",
                                name = "Golf Swing"
                            }, {
                                clip = "handsup_base",
                                controllable = true,
                                dictionary = "missminuteman_1ig_2",
                                loop = true,
                                name = "Hands Up"
                            }, {
                                clip = "handshake_guy_a",
                                controllable = true,
                                dictionary = "mp_ped_interaction",
                                emote_duration = 3000,
                                name = "Handshake"
                            }, {
                                clip = "handshake_guy_b",
                                controllable = true,
                                dictionary = "mp_ped_interaction",
                                emote_duration = 3000,
                                name = "Handshake 2"
                            }, {
                                clip = "plyr_takedown_front_headbutt",
                                dictionary = "melee@unarmed@streamed_variations",
                                name = "Headbutt"
                            }, {
                                clip = "idle",
                                controllable = true,
                                dictionary = "move_m@hiking",
                                loop = true,
                                name = "Hiking"
                            }, {
                                clip = "kisses_guy_a",
                                dictionary = "mp_ped_interaction",
                                name = "Hug"
                            }, {
                                clip = "kisses_guy_b",
                                dictionary = "mp_ped_interaction",
                                name = "Hug 2"
                            }, {
                                clip = "hugs_guy_a",
                                dictionary = "mp_ped_interaction",
                                name = "Hug 3"
                            }, {
                                clip = "idle",
                                dictionary = "anim@heists@heist_corona@team_idles@male_a",
                                loop = true,
                                name = "Idle"
                            }, {
                                clip = "idle",
                                controllable = true,
                                dictionary = "mp_move@prostitute@m@french",
                                loop = true,
                                name = "Idle 10"
                            }, {
                                clip = "idle_a",
                                dictionary = "random@countrysiderobbery",
                                loop = true,
                                name = "Idle 11"
                            }, {
                                clip = "idle",
                                dictionary = "anim@heists@heist_corona@team_idles@female_a",
                                loop = true,
                                name = "Idle 2"
                            }, {
                                clip = "ped_b_celebrate_loop",
                                dictionary = "anim@heists@humane_labs@finale@strip_club",
                                loop = true,
                                name = "Idle 3"
                            }, {
                                clip = "celebration_idle_f_a",
                                dictionary = "anim@mp_celebration@idles@female",
                                loop = true,
                                name = "Idle 4"
                            }, {
                                clip = "idle_a",
                                dictionary = "anim@mp_corona_idles@female_b@idle_a",
                                loop = true,
                                name = "Idle 5"
                            }, {
                                clip = "idle_a",
                                dictionary = "anim@mp_corona_idles@male_c@idle_a",
                                loop = true,
                                name = "Idle 6"
                            }, {
                                clip = "idle_a",
                                dictionary = "anim@mp_corona_idles@male_d@idle_a",
                                loop = true,
                                name = "Idle 7"
                            }, {
                                clip = "idle_b",
                                dictionary = "amb@world_human_hang_out_street@male_b@idle_a",
                                name = "Idle 8"
                            }, {
                                clip = "base_idle",
                                dictionary = "friends@fra@ig_1",
                                loop = true,
                                name = "Idle 9"
                            }, {
                                clip = "drunk_driver_stand_loop_dd1",
                                dictionary = "random@drunk_driver_1",
                                loop = true,
                                name = "Idle Drunk"
                            }, {
                                clip = "drunk_driver_stand_loop_dd2",
                                dictionary = "random@drunk_driver_1",
                                loop = true,
                                name = "Idle Drunk 2"
                            }, {
                                clip = "standing_idle_loop_drunk",
                                dictionary = "missarmenian2",
                                loop = true,
                                name = "Idle Drunk 3"
                            }, {
                                clip = "idle_e",
                                dictionary = "random@train_tracks",
                                name = "Inspect"
                            }, {
                                clip = "jazz_hands",
                                controllable = true,
                                dictionary = "anim@mp_player_intcelebrationfemale@jazz_hands",
                                emote_duration = 6000,
                                name = "Jazzhands"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "amb@world_human_jog_standing@male@idle_a",
                                loop = true,
                                name = "Jog 2"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "amb@world_human_jog_standing@female@idle_a",
                                loop = true,
                                name = "Jog 3"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "amb@world_human_power_walker@female@idle_a",
                                loop = true,
                                name = "Jog 4"
                            }, {
                                clip = "walk",
                                controllable = true,
                                dictionary = "move_m@joy@a",
                                loop = true,
                                name = "Jog 5"
                            }, {
                                clip = "jimmy_getknocked",
                                dictionary = "timetable@reunited@ig_2",
                                loop = true,
                                name = "Jumping Jacks"
                            }, {
                                clip = "fob_click",
                                controllable = true,
                                dictionary = "anim@mp_player_intmenu@key_fob@",
                                emote_duration = 1000,
                                loop = false,
                                name = "Key Fob"
                            }, {
                                clip = "idle",
                                dictionary = "rcmextreme3",
                                loop = true,
                                name = "Kneel 2"
                            }, {
                                clip = "idle_a",
                                dictionary = "amb@world_human_bum_wash@male@low@idle_a",
                                loop = true,
                                name = "Kneel 3"
                            }, {
                                clip = "knockdoor_idle",
                                controllable = true,
                                dictionary = "timetable@jimmy@doorknock@",
                                loop = true,
                                name = "Knock"
                            }, {
                                clip = "lift_fibagent_loop",
                                dictionary = "missheistfbi3b_ig7",
                                loop = true,
                                name = "Knock 2"
                            }, {
                                clip = "knuckle_crunch",
                                controllable = true,
                                dictionary = "anim@mp_player_intcelebrationfemale@knuckle_crunch",
                                loop = true,
                                name = "Knuckle Crunch"
                            }, {
                                clip = "laugh_a_player_b",
                                dictionary = "anim@arena@celeb@flat@paired@no_props@",
                                loop = true,
                                name = "LOL"
                            }, {
                                clip = "giggle_a_player_b",
                                dictionary = "anim@arena@celeb@flat@solo@no_props@",
                                loop = true,
                                name = "LOL 2"
                            }, {
                                clip = "lap_dance_girl",
                                dictionary = "mp_safehouse",
                                name = "Lapdance"
                            }, {
                                clip = "priv_dance_idle",
                                dictionary = "mini@strip_club@private_dance@idle",
                                loop = true,
                                name = "Lapdance 2"
                            }, {
                                clip = "priv_dance_p2",
                                dictionary = "mini@strip_club@private_dance@part2",
                                loop = true,
                                name = "Lapdance 3"
                            }, {
                                clip = "priv_dance_p3",
                                dictionary = "mini@strip_club@private_dance@part3",
                                loop = true,
                                name = "Lapdance 4"
                            }, {
                                clip = "idle_a",
                                dictionary = "amb@world_human_leaning@female@wall@back@hand_up@idle_a",
                                loop = true,
                                name = "Lean 2"
                            }, {
                                clip = "idle_a",
                                dictionary = "amb@world_human_leaning@female@wall@back@holding_elbow@idle_a",
                                loop = true,
                                name = "Lean 3"
                            }, {
                                clip = "idle_a",
                                dictionary = "amb@world_human_leaning@male@wall@back@foot_up@idle_a",
                                loop = true,
                                name = "Lean 4"
                            }, {
                                clip = "idle_b",
                                dictionary = "amb@world_human_leaning@male@wall@back@hands_together@idle_b",
                                loop = true,
                                name = "Lean 5"
                            }, {
                                clip = "idle_c",
                                dictionary = "amb@prop_human_bum_shopping_cart@male@idle_a",
                                loop = true,
                                name = "Lean Bar 2"
                            }, {
                                clip = "clubvip_base_laz",
                                dictionary = "anim@amb@nightclub@lazlow@ig1_vip@",
                                loop = true,
                                name = "Lean Bar 3"
                            }, {
                                clip = "ped_b_loop_a",
                                dictionary = "anim@heists@prison_heist",
                                loop = true,
                                name = "Lean Bar 4"
                            }, {
                                clip = "_car_a_flirt_girl",
                                dictionary = "random@street_race",
                                loop = true,
                                name = "Lean Flirt"
                            }, {
                                clip = "idle_a_player_one",
                                controllable = true,
                                dictionary = "anim@mp_ferris_wheel",
                                loop = true,
                                name = "Lean High"
                            }, {
                                clip = "idle_a_player_two",
                                controllable = true,
                                dictionary = "anim@mp_ferris_wheel",
                                loop = true,
                                name = "Lean High 2"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "timetable@mime@01_gc",
                                loop = true,
                                name = "Leanside"
                            }, {
                                clip = "packer_idle_1_trevor",
                                controllable = true,
                                dictionary = "misscarstealfinale",
                                loop = true,
                                name = "Leanside 2"
                            }, {
                                clip = "waitloop_lamar",
                                controllable = true,
                                dictionary = "misscarstealfinalecar_5_ig_1",
                                loop = true,
                                name = "Leanside 3"
                            }, {
                                clip = "waitloop_lamar",
                                controllable = false,
                                dictionary = "misscarstealfinalecar_5_ig_1",
                                loop = true,
                                name = "Leanside 4"
                            }, {
                                clip = "josh_2_intp1_base",
                                controllable = false,
                                dictionary = "rcmjosh2",
                                loop = true,
                                name = "Leanside 5"
                            }, {
                                clip = "ledge_loop",
                                dictionary = "missfbi1",
                                loop = true,
                                name = "Ledge"
                            }, {
                                clip = "idle_f",
                                controllable = true,
                                dictionary = "random@hitch_lift",
                                loop = true,
                                name = "Lift"
                            }, {
                                clip = "gesture_me_hard",
                                controllable = true,
                                dictionary = "gestures@f@standing@casual",
                                emote_duration = 1000,
                                name = "Me"
                            }, {
                                clip = "fixing_a_ped",
                                controllable = true,
                                dictionary = "mini@repair",
                                loop = true,
                                name = "Mechanic"
                            }, {
                                clip = "idle_a",
                                dictionary = "amb@world_human_vehicle_mechanic@male@base",
                                loop = true,
                                name = "Mechanic 2"
                            }, {
                                clip = "machinic_loop_mechandplayer",
                                dictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                                loop = true,
                                name = "Mechanic 3"
                            }, {
                                clip = "machinic_loop_mechandplayer",
                                controllable = true,
                                dictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                                loop = true,
                                name = "Mechanic 4"
                            }, {
                                clip = "base",
                                dictionary = "amb@medic@standing@tendtodead@base",
                                loop = true,
                                name = "Medic 2"
                            }, {
                                clip = "meditiate_idle",
                                dictionary = "rcmcollect_paperleadinout@",
                                loop = true,
                                name = "Meditiate"
                            }, {
                                clip = "ep_3_rcm_marnie_meditating",
                                dictionary = "rcmepsilonism3",
                                loop = true,
                                name = "Meditiate 2"
                            }, {
                                clip = "base_loop",
                                dictionary = "rcmepsilonism3",
                                loop = true,
                                name = "Meditiate 3"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "anim@mp_player_intincarrockstd@ps@",
                                loop = true,
                                name = "Metal"
                            }, {
                                clip = "mind_control_b_loop",
                                dictionary = "rcmbarry",
                                loop = true,
                                name = "Mind Control"
                            }, {
                                clip = "bar_1_attack_idle_aln",
                                dictionary = "rcmbarry",
                                loop = true,
                                name = "Mind Control 2"
                            }, {
                                clip = "ig_4_base",
                                controllable = true,
                                dictionary = "timetable@amanda@ig_4",
                                loop = true,
                                name = "Namaste"
                            }, {
                                clip = "idle_c",
                                controllable = true,
                                dictionary = "amb@world_human_bum_standing@twitchy@idle_a",
                                loop = true,
                                name = "Nervous"
                            }, {
                                clip = "nervous_idle",
                                controllable = true,
                                dictionary = "mp_missheist_countrybank@nervous",
                                loop = true,
                                name = "Nervous 2"
                            }, {
                                clip = "nervous_loop",
                                controllable = true,
                                dictionary = "rcmme_tracey1",
                                loop = true,
                                name = "Nervous 3"
                            }, {
                                clip = "fail",
                                controllable = true,
                                dictionary = "anim@heists@ornate_bank@chat_manager",
                                loop = true,
                                name = "No"
                            }, {
                                clip = "mp_player_int_nod_no",
                                controllable = true,
                                dictionary = "mp_player_int_upper_nod",
                                loop = true,
                                name = "No 2"
                            }, {
                                clip = "gesture_no_way",
                                controllable = true,
                                dictionary = "gestures@m@standing@casual",
                                emote_duration = 1500,
                                name = "No Way"
                            }, {
                                clip = "nose_pick",
                                controllable = true,
                                dictionary = "anim@mp_player_intcelebrationfemale@nose_pick",
                                loop = true,
                                name = "Nose Pick"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "anim@mp_player_intselfiedock",
                                loop = true,
                                name = "OK"
                            }, {
                                clip = "out_of_breath",
                                controllable = true,
                                dictionary = "re@construction",
                                loop = true,
                                name = "Out of Breath"
                            }, {
                                clip = "drunk_loop",
                                dictionary = "missarmenian2",
                                loop = true,
                                name = "Passout"
                            }, {
                                clip = "corpse_search_exit_ped",
                                dictionary = "missarmenian2",
                                loop = true,
                                name = "Passout 2"
                            }, {
                                clip = "body_search",
                                dictionary = "anim@gangops@morgue@table@",
                                loop = true,
                                name = "Passout 3"
                            }, {
                                clip = "cpr_pumpchest_idle",
                                dictionary = "mini@cpr@char_b@cpr_def",
                                loop = true,
                                name = "Passout 4"
                            }, {
                                clip = "flee_backward_loop_shopkeeper",
                                dictionary = "random@mugging4",
                                loop = true,
                                name = "Passout 5"
                            }, {
                                clip = "mp_player_int_peace_sign",
                                controllable = true,
                                dictionary = "mp_player_int_upperpeace_sign",
                                loop = true,
                                name = "Peace"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "anim@mp_player_intupperpeace",
                                loop = true,
                                name = "Peace 2"
                            }, {
                                clip = "left_peek_a",
                                dictionary = "random@paparazzi@peek",
                                loop = true,
                                name = "Peek"
                            }, {
                                clip = "petting_franklin",
                                dictionary = "creatures@rottweiler@tricks@",
                                loop = true,
                                name = "Petting"
                            }, {
                                clip = "pickup_low",
                                dictionary = "random@domestic",
                                name = "Pickup"
                            }, {
                                clip = "gesture_point",
                                controllable = true,
                                dictionary = "gestures@f@standing@casual",
                                loop = true,
                                name = "Point"
                            }, {
                                clip = "gesture_hand_down",
                                controllable = true,
                                dictionary = "gestures@f@standing@casual",
                                emote_duration = 1000,
                                name = "Point Down"
                            }, {
                                clip = "indicate_right",
                                controllable = true,
                                dictionary = "mp_gun_shop_tut",
                                loop = true,
                                name = "Point Right"
                            }, {
                                clip = "prone_dave",
                                dictionary = "missfbi3_sniping",
                                loop = true,
                                name = "Prone"
                            }, {
                                clip = "struggle_loop_b_thief",
                                controllable = true,
                                dictionary = "random@mugging4",
                                loop = true,
                                name = "Pull"
                            }, {
                                clip = "pull_over_right",
                                controllable = true,
                                dictionary = "misscarsteal3pullover",
                                emote_duration = 1300,
                                name = "Pullover"
                            }, {
                                clip = "loop_punching",
                                controllable = true,
                                dictionary = "rcmextreme2",
                                loop = true,
                                name = "Punching"
                            }, {
                                clip = "pushcar_offcliff_f",
                                dictionary = "missfinale_c2ig_11",
                                loop = true,
                                name = "Push"
                            }, {
                                clip = "pushcar_offcliff_m",
                                dictionary = "missfinale_c2ig_11",
                                loop = true,
                                name = "Push 2"
                            }, {
                                clip = "idle_d",
                                dictionary = "amb@world_human_push_ups@male@idle_a",
                                loop = true,
                                name = "Pushup"
                            }, {
                                clip = "wakeup",
                                dictionary = "random@peyote@rabbit",
                                name = "Rabbit"
                            }, {
                                clip = "generic_radio_chatter",
                                controllable = true,
                                dictionary = "random@arrests",
                                loop = true,
                                name = "Radio"
                            }, {
                                clip = "idle",
                                controllable = true,
                                dictionary = "move_m@intimidation@cop@unarmed",
                                loop = true,
                                name = "Reaching"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "anim@mp_player_intincarsalutestd@ds@",
                                loop = true,
                                name = "Salute"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "anim@mp_player_intincarsalutestd@ps@",
                                loop = true,
                                name = "Salute 2"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "anim@mp_player_intuppersalute",
                                loop = true,
                                name = "Salute 3"
                            }, {
                                clip = "f_distressed_loop",
                                controllable = true,
                                dictionary = "random@domestic",
                                loop = true,
                                name = "Scared"
                            }, {
                                clip = "knees_loop_girl",
                                controllable = true,
                                dictionary = "random@homelandsecurity",
                                loop = true,
                                name = "Scared 2"
                            }, {
                                clip = "screw_you",
                                controllable = true,
                                dictionary = "misscommon@response",
                                loop = true,
                                name = "Screw You"
                            }, {
                                clip = "shakeoff_1",
                                controllable = true,
                                dictionary = "move_m@_idles@shake_off",
                                emote_duration = 3500,
                                name = "Shake Off"
                            }, {
                                clip = "idle_a",
                                dictionary = "random@dealgonewrong",
                                loop = true,
                                name = "Shot"
                            }, {
                                clip = "gesture_shrug_hard",
                                controllable = true,
                                dictionary = "gestures@f@standing@casual",
                                emote_duration = 1000,
                                name = "Shrug"
                            }, {
                                clip = "gesture_shrug_hard",
                                controllable = true,
                                dictionary = "gestures@m@standing@casual",
                                emote_duration = 1000,
                                name = "Shrug 2"
                            }, {
                                clip = "sit_phone_phoneputdown_idle_nowork",
                                dictionary = "anim@amb@business@bgen@bgen_no_work@",
                                loop = true,
                                name = "Sit"
                            }, {
                                clip = "barry_3_sit_loop",
                                dictionary = "rcm_barry3",
                                loop = true,
                                name = "Sit 2"
                            }, {
                                clip = "idle_a",
                                dictionary = "amb@world_human_picnic@male@idle_a",
                                loop = true,
                                name = "Sit 3"
                            }, {
                                clip = "idle_a",
                                dictionary = "amb@world_human_picnic@female@idle_a",
                                loop = true,
                                name = "Sit 4"
                            }, {
                                clip = "owner_idle",
                                dictionary = "anim@heists@fleeca_bank@ig_7_jetski_owner",
                                loop = true,
                                name = "Sit 5"
                            }, {
                                clip = "idle_a_jimmy",
                                dictionary = "timetable@jimmy@mics3_ig_15@",
                                loop = true,
                                name = "Sit 6"
                            }, {
                                clip = "lowalone_base_laz",
                                dictionary = "anim@amb@nightclub@lazlow@lo_alone@",
                                loop = true,
                                name = "Sit 7"
                            }, {
                                clip = "mics3_15_base_jimmy",
                                dictionary = "timetable@jimmy@mics3_ig_15@",
                                loop = true,
                                name = "Sit 8"
                            }, {
                                clip = "idle_a",
                                dictionary = "amb@world_human_stupor@male@idle_a",
                                loop = true,
                                name = "Sit 9"
                            }, {
                                clip = "ig_5_p3_base",
                                dictionary = "timetable@ron@ig_5_p3",
                                loop = true,
                                name = "Sit Chair 2"
                            }, {
                                clip = "base_amanda",
                                dictionary = "timetable@reunited@ig_10",
                                loop = true,
                                name = "Sit Chair 3"
                            }, {
                                clip = "base",
                                dictionary = "timetable@ron@ig_3_couch",
                                loop = true,
                                name = "Sit Chair 4"
                            }, {
                                clip = "mics3_15_base_tracy",
                                dictionary = "timetable@jimmy@mics3_ig_15@",
                                loop = true,
                                name = "Sit Chair 5"
                            }, {
                                clip = "base",
                                dictionary = "timetable@maid@couch@",
                                loop = true,
                                name = "Sit Chair 6"
                            }, {
                                clip = "ig_2_alt1_base",
                                dictionary = "timetable@ron@ron_ig_2_alt1",
                                loop = true,
                                name = "Sit Chair Side"
                            }, {
                                clip = "base",
                                dictionary = "timetable@amanda@drunk@base",
                                loop = true,
                                name = "Sit Drunk"
                            }, {
                                clip = "ig_14_base_tracy",
                                dictionary = "timetable@tracy@ig_14@",
                                loop = true,
                                name = "Sit Lean"
                            }, {
                                clip = "sit_phone_phoneputdown_sleeping-noworkfemale",
                                dictionary = "anim@amb@business@bgen@bgen_no_work@",
                                loop = true,
                                name = "Sit Sad"
                            }, {
                                clip = "hit_loop_ped_b",
                                dictionary = "anim@heists@ornate_bank@hostages@hit",
                                loop = true,
                                name = "Sit Scared"
                            }, {
                                clip = "flinch_loop",
                                dictionary = "anim@heists@ornate_bank@hostages@ped_c@",
                                loop = true,
                                name = "Sit Scared 2"
                            }, {
                                clip = "flinch_loop",
                                dictionary = "anim@heists@ornate_bank@hostages@ped_e@",
                                loop = true,
                                name = "Sit Scared 3"
                            }, {
                                clip = "idle_a",
                                dictionary = "amb@world_human_sit_ups@male@idle_a",
                                loop = true,
                                name = "Sit Up"
                            }, {
                                clip = "plyr_takedown_front_slap",
                                controllable = true,
                                dictionary = "melee@unarmed@streamed_variations",
                                emote_duration = 2000,
                                loop = true,
                                name = "Slap"
                            }, {
                                clip = "idle_c",
                                dictionary = "timetable@tracy@sleep@",
                                loop = true,
                                name = "Sleep"
                            }, {
                                clip = "slide_a_player_a",
                                dictionary = "anim@arena@celeb@flat@solo@no_props@",
                                name = "Slide"
                            }, {
                                clip = "slide_b_player_a",
                                dictionary = "anim@arena@celeb@flat@solo@no_props@",
                                name = "Slide 2"
                            }, {
                                clip = "slide_c_player_a",
                                dictionary = "anim@arena@celeb@flat@solo@no_props@",
                                name = "Slide 3"
                            }, {
                                clip = "slow_clap",
                                controllable = true,
                                dictionary = "anim@mp_player_intcelebrationfemale@slow_clap",
                                loop = true,
                                name = "Slow Clap"
                            }, {
                                clip = "slow_clap",
                                controllable = true,
                                dictionary = "anim@mp_player_intcelebrationmale@slow_clap",
                                loop = true,
                                name = "Slow Clap 2"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "anim@mp_player_intupperslow_clap",
                                loop = true,
                                name = "Slow Clap 3"
                            }, {
                                clip = "slugger_a_player_a",
                                dictionary = "anim@arena@celeb@flat@solo@no_props@",
                                name = "Slugger"
                            }, {
                                clip = "fidget_sniff_fingers",
                                controllable = true,
                                dictionary = "move_p_m_two_idles@generic",
                                loop = true,
                                name = "Smell"
                            }, {
                                clip = "ex03_train_roof_idle",
                                dictionary = "missexile3",
                                loop = true,
                                name = "Spider-Man"
                            }, {
                                clip = "cs_lamardavis_dual-1",
                                controllable = true,
                                dictionary = "fra_0_int-1",
                                loop = true,
                                name = "Statue 2"
                            }, {
                                clip = "csb_englishdave_dual-0",
                                dictionary = "club_intro2-0",
                                loop = true,
                                name = "Statue 3"
                            }, {
                                clip = "biker_02_stickup_loop",
                                controllable = true,
                                dictionary = "random@countryside_gang_fight",
                                loop = true,
                                name = "Stick Up"
                            }, {
                                clip = "idle_e",
                                dictionary = "mini@triathlon",
                                loop = true,
                                name = "Stretch"
                            }, {
                                clip = "idle_f",
                                dictionary = "mini@triathlon",
                                loop = true,
                                name = "Stretch 2"
                            }, {
                                clip = "idle_d",
                                dictionary = "mini@triathlon",
                                loop = true,
                                name = "Stretch 3"
                            }, {
                                clip = "idle_e",
                                dictionary = "rcmfanatic1maryann_stretchidle_b",
                                loop = true,
                                name = "Stretch 4"
                            }, {
                                clip = "stumble",
                                dictionary = "misscarsteal4@actor",
                                loop = true,
                                name = "Stumble"
                            }, {
                                clip = "damage",
                                dictionary = "stungun@standing",
                                loop = true,
                                name = "Stunned"
                            }, {
                                clip = "base",
                                dictionary = "amb@world_human_sunbathe@male@back@base",
                                loop = true,
                                name = "Sunbathe"
                            }, {
                                clip = "base",
                                dictionary = "amb@world_human_sunbathe@female@back@base",
                                loop = true,
                                name = "Sunbathe 2"
                            }, {
                                clip = "base",
                                dictionary = "rcmbarry",
                                loop = true,
                                name = "Superhero"
                            }, {
                                clip = "base",
                                controllable = true,
                                dictionary = "rcmbarry",
                                loop = true,
                                name = "Superhero 2"
                            }, {
                                clip = "idle_a",
                                dictionary = "random@arrests@busted",
                                loop = true,
                                name = "Surrender"
                            }, {
                                clip = "a2_pose",
                                controllable = true,
                                dictionary = "missfam5_yoga",
                                loop = true,
                                name = "T-Pose"
                            }, {
                                clip = "a2_pose",
                                controllable = true,
                                dictionary = "missfam5_yoga",
                                name = "T-Pose (Once)"
                            }, {
                                clip = "rehearsal_base_idle_director",
                                controllable = true,
                                dictionary = "misscarsteal4@aliens",
                                loop = true,
                                name = "Think"
                            }, {
                                clip = "jh_int_outro_loop_a",
                                controllable = true,
                                dictionary = "missheist_jewelleadinout",
                                loop = true,
                                name = "Think 2"
                            }, {
                                clip = "base",
                                controllable = true,
                                dictionary = "timetable@tracy@ig_8@base",
                                loop = true,
                                name = "Think 3"
                            }, {
                                clip = "b_think",
                                controllable = true,
                                dictionary = "mp_cp_welcome_tutthink",
                                emote_duration = 2000,
                                name = "Think 5"
                            }, {
                                clip = "b_atm_mugging",
                                controllable = true,
                                dictionary = "random@atmrobberygen",
                                loop = true,
                                name = "Threaten"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "anim@mp_player_intupperthumbs_up",
                                loop = true,
                                name = "Thumbs Up"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "anim@mp_player_intselfiethumbs_up",
                                loop = true,
                                name = "Thumbs Up 2"
                            }, {
                                clip = "enter",
                                controllable = true,
                                dictionary = "anim@mp_player_intincarthumbs_uplow@ds@",
                                emote_duration = 3000,
                                name = "Thumbs Up 3"
                            }, {
                                clip = "try_trousers_neutral_a",
                                dictionary = "mp_clothing@female@trousers",
                                loop = true,
                                name = "Try Clothes"
                            }, {
                                clip = "try_shirt_positive_a",
                                dictionary = "mp_clothing@female@shirt",
                                loop = true,
                                name = "Try Clothes 2"
                            }, {
                                clip = "try_shoes_positive_a",
                                dictionary = "mp_clothing@female@shoes",
                                loop = true,
                                name = "Try Clothes 3"
                            }, {
                                clip = "001443_01_trvs_28_idle_stripper",
                                dictionary = "switch@trevor@mocks_lapdance",
                                loop = true,
                                name = "Twerk"
                            }, {
                                clip = "cop_b_idle",
                                controllable = true,
                                dictionary = "anim@heists@prison_heiststation@cop_reactions",
                                loop = true,
                                name = "Type"
                            }, {
                                clip = "loop",
                                controllable = true,
                                dictionary = "anim@heists@prison_heistig1_p1_guard_checks_bus",
                                loop = true,
                                name = "Type 2"
                            }, {
                                clip = "hack_loop",
                                controllable = true,
                                dictionary = "mp_prison_break",
                                loop = true,
                                name = "Type 3"
                            }, {
                                clip = "loop",
                                dictionary = "mp_fbi_heist",
                                loop = true,
                                name = "Type 4"
                            }, {
                                clip = "a_uncuff",
                                controllable = true,
                                dictionary = "mp_arresting",
                                loop = true,
                                name = "Uncuff"
                            }, {
                                clip = "_idle_a",
                                controllable = true,
                                dictionary = "random@shop_tattoo",
                                loop = true,
                                name = "Wait"
                            }, {
                                clip = "ig_3_base_tracy",
                                controllable = true,
                                dictionary = "timetable@amanda@ig_3",
                                loop = true,
                                name = "Wait 10"
                            }, {
                                clip = "keeper_base",
                                controllable = true,
                                dictionary = "misshair_shop@hair_dressers",
                                loop = true,
                                name = "Wait 11"
                            }, {
                                clip = "idle",
                                controllable = true,
                                dictionary = "rcmjosh1",
                                loop = true,
                                name = "Wait 12"
                            }, {
                                clip = "base",
                                controllable = true,
                                dictionary = "rcmnigel1a",
                                loop = true,
                                name = "Wait 13"
                            }, {
                                clip = "wait_for_van_c",
                                controllable = true,
                                dictionary = "missbigscore2aig_3",
                                loop = true,
                                name = "Wait 2"
                            }, {
                                clip = "idle_a",
                                dictionary = "amb@world_human_hang_out_street@female_hold_arm@idle_a",
                                loop = true,
                                name = "Wait 3"
                            }, {
                                clip = "idle_a",
                                dictionary = "amb@world_human_hang_out_street@Female_arm_side@idle_a",
                                loop = true,
                                name = "Wait 4"
                            }, {
                                clip = "idle_storeclerk",
                                controllable = true,
                                dictionary = "missclothing",
                                loop = true,
                                name = "Wait 5"
                            }, {
                                clip = "ig_2_base_amanda",
                                controllable = true,
                                dictionary = "timetable@amanda@ig_2",
                                loop = true,
                                name = "Wait 6"
                            }, {
                                clip = "base",
                                controllable = true,
                                dictionary = "rcmnigel1cnmt_1c",
                                loop = true,
                                name = "Wait 7"
                            }, {
                                clip = "idle",
                                controllable = true,
                                dictionary = "rcmjosh1",
                                loop = true,
                                name = "Wait 8"
                            }, {
                                clip = "josh_2_intp1_base",
                                controllable = true,
                                dictionary = "rcmjosh2",
                                loop = true,
                                name = "Wait 9"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "amb@world_human_stand_fire@male@idle_a",
                                loop = true,
                                name = "Warmth"
                            }, {
                                clip = "wave_a",
                                controllable = true,
                                dictionary = "friends@frj@ig_1",
                                loop = true,
                                name = "Wave"
                            }, {
                                clip = "wave",
                                controllable = true,
                                dictionary = "anim@mp_player_intcelebrationfemale@wave",
                                loop = true,
                                name = "Wave 2"
                            }, {
                                clip = "over_here_idle_a",
                                controllable = true,
                                dictionary = "friends@fra@ig_1",
                                loop = true,
                                name = "Wave 3"
                            }, {
                                clip = "001445_01_gangintimidation_1_female_idle_b",
                                controllable = true,
                                dictionary = "random@mugging5",
                                emote_duration = 3000,
                                name = "Wave 4"
                            }, {
                                clip = "wave_b",
                                controllable = true,
                                dictionary = "friends@frj@ig_1",
                                loop = true,
                                name = "Wave 5"
                            }, {
                                clip = "wave_c",
                                controllable = true,
                                dictionary = "friends@frj@ig_1",
                                loop = true,
                                name = "Wave 6"
                            }, {
                                clip = "wave_d",
                                controllable = true,
                                dictionary = "friends@frj@ig_1",
                                loop = true,
                                name = "Wave 7"
                            }, {
                                clip = "wave_e",
                                controllable = true,
                                dictionary = "friends@frj@ig_1",
                                loop = true,
                                name = "Wave 8"
                            }, {
                                clip = "gesture_hello",
                                controllable = true,
                                dictionary = "gestures@m@standing@casual",
                                loop = true,
                                name = "Wave 9"
                            }, {
                                clip = "hail_taxi",
                                controllable = true,
                                dictionary = "taxi_hail",
                                emote_duration = 1300,
                                name = "Whistle"
                            }, {
                                clip = "hailing_whistle_waive_a",
                                controllable = true,
                                dictionary = "rcmnigel1c",
                                emote_duration = 2000,
                                name = "Whistle 2"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "anim@mp_player_intupperair_shagging",
                                emote_duration = 1000,
                                loop = true,
                                name = "Yeah"
                            } },
                  name = "Actions"
              }, {
                  is_folder = true,
                  items = { {
                                clip = "hi_dance_facedj_17_v2_male^5",
                                dictionary = "anim@amb@nightclub@dancers@podium_dancers@",
                                loop = true,
                                name = "Dance"
                            }, {
                                clip = "high_center_down",
                                dictionary = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@",
                                loop = true,
                                name = "Dance 2"
                            }, {
                                clip = "high_center",
                                dictionary = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@",
                                loop = true,
                                name = "Dance 3"
                            }, {
                                clip = "high_center_up",
                                dictionary = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@",
                                loop = true,
                                name = "Dance 4"
                            }, {
                                clip = "med_center",
                                dictionary = "anim@amb@casino@mini@dance@dance_solo@female@var_a@",
                                loop = true,
                                name = "Dance 5"
                            }, {
                                clip = "dance_loop_tao",
                                dictionary = "misschinese2_crystalmazemcs1_cs",
                                loop = true,
                                name = "Dance 6"
                            }, {
                                clip = "dance_loop_tao",
                                dictionary = "misschinese2_crystalmazemcs1_ig",
                                loop = true,
                                name = "Dance 7"
                            }, {
                                clip = "dance_m_default",
                                dictionary = "missfbi3_sniping",
                                loop = true,
                                name = "Dance 8"
                            }, {
                                clip = "med_center_up",
                                dictionary = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@",
                                loop = true,
                                name = "Dance 9"
                            }, {
                                clip = "mi_dance_facedj_17_v1_female^1",
                                dictionary = "anim@amb@nightclub@dancers@solomun_entourage@",
                                loop = true,
                                name = "Dance F"
                            }, {
                                clip = "high_center",
                                dictionary = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@",
                                loop = true,
                                name = "Dance F2"
                            }, {
                                clip = "high_center_up",
                                dictionary = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@",
                                loop = true,
                                name = "Dance F3"
                            }, {
                                clip = "hi_dance_facedj_09_v2_female^1",
                                dictionary = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity",
                                loop = true,
                                name = "Dance F4"
                            }, {
                                clip = "hi_dance_facedj_09_v2_female^3",
                                dictionary = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity",
                                loop = true,
                                name = "Dance F5"
                            }, {
                                clip = "high_center_up",
                                dictionary = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@",
                                loop = true,
                                name = "Dance F6"
                            }, {
                                clip = "ambclub_13_mi_hi_sexualgriding_laz",
                                controllable = true,
                                dictionary = "anim@amb@nightclub@lazlow@hi_railing@",
                                loop = true,
                                name = "Dance Glowsticks",
                                props = { {
                                              bone = 28422,
                                              placement = { 0.07, 0.14, 0.0, -80.0, 20.0 },
                                              prop = "ba_prop_battle_glowstick_01"
                                          }, {
                                              bone = 60309,
                                              placement = { 0.07, 0.09, 0.0, -120.0, -20.0 },
                                              prop = "ba_prop_battle_glowstick_01"
                                          } }
                            }, {
                                clip = "ambclub_12_mi_hi_bootyshake_laz",
                                dictionary = "anim@amb@nightclub@lazlow@hi_railing@",
                                loop = true,
                                name = "Dance Glowsticks 2",
                                props = { {
                                              bone = 28422,
                                              placement = { 0.07, 0.14, 0.0, -80.0, 20.0 },
                                              prop = "ba_prop_battle_glowstick_01"
                                          }, {
                                              bone = 60309,
                                              placement = { 0.07, 0.09, 0.0, -120.0, -20.0 },
                                              prop = "ba_prop_battle_glowstick_01"
                                          } }
                            }, {
                                clip = "ambclub_09_mi_hi_bellydancer_laz",
                                dictionary = "anim@amb@nightclub@lazlow@hi_railing@",
                                name = "Dance Glowsticks 3",
                                props = { {
                                              bone = 28422,
                                              placement = { 0.07, 0.14, 0.0, -80.0, 20.0 },
                                              prop = "ba_prop_battle_glowstick_01"
                                          }, {
                                              bone = 60309,
                                              placement = { 0.07, 0.09, 0.0, -120.0, -20.0 },
                                              prop = "ba_prop_battle_glowstick_01"
                                          },
                                          loop = true
                                }
                            }, {
                                clip = "low_center",
                                dictionary = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@",
                                loop = true,
                                name = "Dance Shy"
                            }, {
                                clip = "low_center_down",
                                dictionary = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@",
                                loop = true,
                                name = "Dance Shy 2"
                            }, {
                                clip = "mnt_dnc_buttwag",
                                dictionary = "special_ped@mountain_dancer@monologue_3@monologue_3a",
                                loop = true,
                                name = "Dance Silly"
                            }, {
                                clip = "fidget_short_dance",
                                dictionary = "move_clown@p_m_zero_idles@",
                                loop = true,
                                name = "Dance Silly 2"
                            }, {
                                clip = "fidget_short_dance",
                                dictionary = "move_clown@p_m_two_idles@",
                                loop = true,
                                name = "Dance Silly 3"
                            }, {
                                clip = "danceidle_hi_11_buttwiggle_b_laz",
                                dictionary = "anim@amb@nightclub@lazlow@hi_podium@",
                                loop = true,
                                name = "Dance Silly 4"
                            }, {
                                clip = "idle_a",
                                dictionary = "timetable@tracy@ig_5@idle_a",
                                loop = true,
                                name = "Dance Silly 5"
                            }, {
                                clip = "idle_d",
                                dictionary = "timetable@tracy@ig_8@idle_b",
                                loop = true,
                                name = "Dance Silly 6"
                            }, {
                                clip = "high_center",
                                dictionary = "anim@amb@casino@mini@dance@dance_solo@female@var_b@",
                                loop = true,
                                name = "Dance Silly 7"
                            }, {
                                clip = "the_woogie",
                                dictionary = "anim@mp_player_intcelebrationfemale@the_woogie",
                                loop = true,
                                name = "Dance Silly 8"
                            }, {
                                clip = "dance_loop_tyler",
                                dictionary = "rcmnigel1bnmt_1b",
                                loop = true,
                                name = "Dance Silly 9"
                            }, {
                                clip = "low_center",
                                dictionary = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@",
                                loop = true,
                                name = "Dance Slow"
                            }, {
                                clip = "low_center",
                                dictionary = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@",
                                loop = true,
                                name = "Dance Slow 2"
                            }, {
                                clip = "low_center_down",
                                dictionary = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@",
                                loop = true,
                                name = "Dance Slow 3"
                            }, {
                                clip = "low_center",
                                dictionary = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@",
                                loop = true,
                                name = "Dance Slow 4"
                            }, {
                                clip = "high_center",
                                controllable = true,
                                dictionary = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@",
                                loop = true,
                                name = "Dance Upper"
                            }, {
                                clip = "high_center_up",
                                controllable = true,
                                dictionary = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@",
                                loop = true,
                                name = "Dance Upper 2"
                            } },
                  name = "Dances"
              }, {
                  is_folder = true,
                  items = { {
                                clip = "handshake_guy_a",
                                controllable = true,
                                dictionary = "mp_ped_interaction",
                                emote_duration = 3000,
                                name = "Handshake",
                                sync_offset_front = 0.9,
                                target_animation = "handshake2"
                            }, {
                                clip = "handshake_guy_b",
                                controllable = true,
                                dictionary = "mp_ped_interaction",
                                emote_duration = 3000,
                                name = "Handshake 2",
                                target_animation = "handshake"
                            }, {
                                clip = "kisses_guy_a",
                                controllable = false,
                                dictionary = "mp_ped_interaction",
                                emote_duration = 5000,
                                name = "Hug",
                                sync_offset_front = 1.05,
                                target_animation = "hug2"
                            }, {
                                clip = "kisses_guy_b",
                                controllable = false,
                                dictionary = "mp_ped_interaction",
                                emote_duration = 5000,
                                name = "Hug 2",
                                sync_offset_front = 1.13,
                                target_animation = "hug"
                            } },
                  name = "Interaction"
              }, {
                  is_folder = true,
                  items = { {
                                clip = "try_tie_positive_a",
                                controllable = true,
                                dictionary = "clothingtie",
                                emote_duration = 5000,
                                name = "Adjust Tie"
                            }, {
                                clip = "shadow_boxing",
                                controllable = true,
                                dictionary = "anim@mp_player_intcelebrationmale@shadow_boxing",
                                emote_duration = 4000,
                                name = "Boxing"
                            }, {
                                clip = "shadow_boxing",
                                controllable = true,
                                dictionary = "anim@mp_player_intcelebrationfemale@shadow_boxing",
                                emote_duration = 4000,
                                name = "Boxing 2"
                            }, {
                                clip = "mind_blown",
                                controllable = true,
                                dictionary = "anim@mp_player_intcelebrationmale@mind_blown",
                                emote_duration = 4000,
                                name = "Mind Blown"
                            }, {
                                clip = "mind_blown",
                                controllable = true,
                                dictionary = "anim@mp_player_intcelebrationfemale@mind_blown",
                                emote_duration = 4000,
                                name = "Mind Blown 2"
                            }, {
                                clip = "stinker",
                                controllable = true,
                                dictionary = "anim@mp_player_intcelebrationfemale@stinker",
                                loop = true,
                                name = "Stink"
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "anim@amb@casino@hangout@ped_male@stand@02b@idles",
                                loop = true,
                                name = "Think 4"
                            } },
                  name = "Misc"
              }, {
                  is_folder = true,
                  items = { {
                                clip = "idle",
                                controllable = true,
                                dictionary = "move_p_m_zero_rucksack",
                                loop = true,
                                name = "Backpack",
                                props = { {
                                              bone = 24818,
                                              placement = { 0.07, -0.11, -0.05, 0.0, 90.0, 175.0 },
                                              prop = "p_michael_backpack_s"
                                          } }
                            }, {
                                clip = "idle_c",
                                controllable = true,
                                dictionary = "amb@world_human_drinking@coffee@male@idle_a",
                                loop = true,
                                name = "Beer",
                                props = { {
                                              bone = 28422,
                                              placement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
                                              prop = "prop_amb_beer_bottle"
                                          } }
                            }, {
                                clip = "base",
                                controllable = true,
                                dictionary = "amb@world_human_bum_freeway@male@base",
                                loop = true,
                                name = "Beg",
                                props = { {
                                              bone = 58868,
                                              placement = { 0.19, 0.18, 0.0, 5.0, 0.0, 40.0 },
                                              prop = "prop_beggers_sign_03"
                                          } }
                            }, {
                                clip = "bong_stage3",
                                dictionary = "anim@safehouse@bong",
                                name = "Bong",
                                props = { {
                                              bone = 18905,
                                              placement = { 0.1, -0.25, 0.0, 95.0, 190.0, 180.0 },
                                              prop = "hei_heist_sh_bong_01"
                                          } }
                            }, {
                                clip = "cellphone_text_read_base",
                                controllable = true,
                                dictionary = "cellphone@",
                                loop = true,
                                name = "Book",
                                props = { {
                                              bone = 6286,
                                              placement = { 0.15, 0.03, -0.065, 0.0, 180.0, 90.0 },
                                              prop = "prop_novel_01"
                                          } }
                            }, {
                                clip = "mp_m_waremech_01_dual-0",
                                controllable = true,
                                dictionary = "impexp_int-0",
                                loop = true,
                                name = "Bouquet",
                                props = { {
                                              bone = 24817,
                                              placement = { -0.29, 0.4, -0.02, -90.0, -90.0, 0.0 },
                                              prop = "prop_snow_flower_02"
                                          } }
                            }, {
                                clip = "idle",
                                controllable = true,
                                dictionary = "anim@heists@box_carry@",
                                loop = true,
                                name = "Box",
                                props = { {
                                              bone = 60309,
                                              placement = { 0.025, 0.08, 0.255, -145.0, 290.0, 0.0 },
                                              prop = "hei_prop_heist_box"
                                          } }
                            }, {
                                clip = "static",
                                controllable = true,
                                dictionary = "missheistdocksprep1hold_cellphone",
                                loop = true,
                                name = "Brief 3",
                                props = { {
                                              bone = 57005,
                                              placement = { 0.1, 0.0, 0.0, 0.0, 280.0, 53.0 },
                                              prop = "prop_ld_case_01"
                                          } }
                            }, {
                                clip = "mp_player_int_eat_burger",
                                controllable = true,
                                dictionary = "mp_player_inteat@burger",
                                name = "Burger",
                                props = { {
                                              bone = 18905,
                                              placement = { 0.13, 0.05, 0.02, -50.0, 16.0, 60.0 },
                                              prop = "prop_cs_burger_01"
                                          } }
                            }, {
                                clip = "ped_a_enter_loop",
                                controllable = true,
                                dictionary = "anim@heists@humane_labs@finale@keycards",
                                loop = true,
                                name = "Champagne",
                                props = { {
                                              bone = 18905,
                                              placement = { 0.1, -0.03, 0.03, -100.0, 0.0, -10.0 },
                                              prop = "prop_drink_champ"
                                          } }
                            }, {
                                clip = "enter",
                                controllable = true,
                                dictionary = "amb@world_human_smoking@male@male_a@enter",
                                emote_duration = 2600,
                                name = "Cig",
                                props = { {
                                              bone = 47419,
                                              placement = { 0.015, -0.009, 0.003, 55.0, 0.0, 110.0 },
                                              prop = "prop_amb_ciggy_01"
                                          } }
                            }, {
                                clip = "enter",
                                controllable = true,
                                dictionary = "amb@world_human_smoking@male@male_a@enter",
                                emote_duration = 2600,
                                name = "Cigar",
                                props = { {
                                              bone = 47419,
                                              placement = { 0.01, 0.0, 0.0, 50.0, 0.0, -80.0 },
                                              prop = "prop_cigar_02"
                                          } }
                            }, {
                                clip = "enter",
                                controllable = true,
                                dictionary = "amb@world_human_smoking@male@male_a@enter",
                                emote_duration = 2600,
                                name = "Cigar 2",
                                props = { {
                                              bone = 47419,
                                              placement = { 0.01, 0.0, 0.0, 50.0, 0.0, -80.0 },
                                              prop = "prop_cigar_01"
                                          } }
                            }, {
                                clip = "base",
                                controllable = true,
                                dictionary = "timetable@floyd@clean_kitchen@base",
                                loop = true,
                                name = "Clean",
                                props = { {
                                              bone = 28422,
                                              placement = { 0.0, 0.0, -0.01, 90.0, 0.0, 0.0 },
                                              prop = "prop_sponge_01"
                                          } }
                            }, {
                                clip = "base",
                                controllable = true,
                                dictionary = "amb@world_human_maid_clean@",
                                loop = true,
                                name = "Clean 2",
                                props = { {
                                              bone = 28422,
                                              placement = { 0.0, 0.0, -0.01, 90.0, 0.0, 0.0 },
                                              prop = "prop_sponge_01"
                                          } }
                            }, {
                                clip = "base",
                                controllable = true,
                                dictionary = "missfam4",
                                loop = true,
                                name = "Clipboard",
                                props = { {
                                              bone = 36029,
                                              placement = { 0.16, 0.08, 0.1, -130.0, -50.0, 0.0 },
                                              prop = "p_amb_clipboard_01"
                                          } }
                            }, {
                                clip = "idle_c",
                                controllable = true,
                                dictionary = "amb@world_human_drinking@coffee@male@idle_a",
                                loop = true,
                                name = "Coffee",
                                props = { {
                                              bone = 28422,
                                              placement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
                                              prop = "p_amb_coffeecup_01"
                                          } }
                            }, {
                                clip = "idle_c",
                                controllable = true,
                                dictionary = "amb@world_human_drinking@coffee@male@idle_a",
                                loop = true,
                                name = "Cup",
                                props = { {
                                              bone = 28422,
                                              placement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
                                              prop = "prop_plastic_cup_02"
                                          } }
                            }, {
                                clip = "mp_player_int_eat_burger",
                                controllable = true,
                                dictionary = "mp_player_inteat@burger",
                                name = "Donut",
                                props = { {
                                              bone = 18905,
                                              placement = { 0.13, 0.05, 0.02, -50.0, 16.0, 60.0 },
                                              prop = "prop_amb_donut"
                                          } }
                            }, {
                                clip = "mp_player_int_eat_burger",
                                controllable = true,
                                dictionary = "mp_player_inteat@burger",
                                name = "Ego Bar",
                                props = { {
                                              bone = 60309,
                                              placement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
                                              prop = "prop_choc_ego"
                                          } }
                            }, {
                                clip = "ped_a_enter_loop",
                                controllable = true,
                                dictionary = "anim@heists@humane_labs@finale@keycards",
                                loop = true,
                                name = "Flute",
                                props = { {
                                              bone = 18905,
                                              placement = { 0.1, -0.03, 0.03, -100.0, 0.0, -10.0 },
                                              prop = "prop_champ_flute"
                                          } }
                            }, {
                                clip = "idle_b",
                                controllable = true,
                                dictionary = "amb@world_human_musician@guitar@male@idle_a",
                                loop = true,
                                name = "Guitar",
                                props = { {
                                              bone = 24818,
                                              placement = { -0.1, 0.31, 0.1, 0.0, 20.0, 150.0 },
                                              prop = "prop_acc_guitar_01"
                                          } }
                            }, {
                                clip = "001370_02_trvs_8_guitar_beatdown_idle_busker",
                                controllable = true,
                                dictionary = "switch@trevor@guitar_beatdown",
                                loop = true,
                                name = "Guitar 2",
                                props = { {
                                              bone = 24818,
                                              placement = { -0.05, 0.31, 0.1, 0.0, 20.0, 150.0 },
                                              prop = "prop_acc_guitar_01"
                                          } }
                            }, {
                                clip = "idle_b",
                                controllable = true,
                                dictionary = "amb@world_human_musician@guitar@male@idle_a",
                                loop = true,
                                name = "Guitar Electric",
                                props = { {
                                              bone = 24818,
                                              placement = { -0.1, 0.31, 0.1, 0.0, 20.0, 150.0 },
                                              prop = "prop_el_guitar_01"
                                          } }
                            }, {
                                clip = "idle_b",
                                controllable = true,
                                dictionary = "amb@world_human_musician@guitar@male@idle_a",
                                loop = true,
                                name = "Guitar Electric 2",
                                props = { {
                                              bone = 24818,
                                              placement = { -0.1, 0.31, 0.1, 0.0, 20.0, 150.0 },
                                              prop = "prop_el_guitar_03"
                                          } }
                            }, {
                                clip = "enter",
                                controllable = true,
                                dictionary = "amb@world_human_smoking@male@male_a@enter",
                                emote_duration = 2600,
                                name = "Joint",
                                props = { {
                                              bone = 47419,
                                              placement = { 0.015, -0.009, 0.003, 55.0, 0.0, 110.0 },
                                              prop = "p_cs_joint_02"
                                          } }
                            }, {
                                clip = "base",
                                controllable = true,
                                dictionary = "amb@world_human_tourist_map@male@base",
                                loop = true,
                                name = "Map",
                                props = { {
                                              bone = 28422,
                                              placement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
                                              prop = "prop_tourist_map_01"
                                          } }
                            }, {
                                clip = "loop",
                                controllable = true,
                                dictionary = "mp_character_creation@customise@male_a",
                                loop = true,
                                name = "Mugshot",
                                props = { {
                                              bone = 58868,
                                              placement = { 0.12, 0.24, 0.0, 5.0, 0.0, 70.0 },
                                              prop = "prop_police_id_board"
                                          } }
                            }, {
                                clip = "base",
                                controllable = true,
                                dictionary = "missheistdockssetup1clipboard@base",
                                loop = true,
                                name = "Notepad",
                                props = { {
                                              bone = 18905,
                                              placement = { 0.1, 0.02, 0.05, 10.0, 0.0, 0.0 },
                                              prop = "prop_notepad_01"
                                          }, {
                                              bone = 58866,
                                              placement = { 0.11, -0.02, 0.001, -120.0, 0.0, 0.0 },
                                              prop = "prop_pencil_01"
                                          } }
                            }, {
                                clip = "cellphone_text_read_base",
                                controllable = true,
                                dictionary = "cellphone@",
                                loop = true,
                                name = "Phone",
                                props = { {
                                              bone = 28422,
                                              placement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
                                              prop = "prop_npc_phone_02"
                                          } }
                            }, {
                                clip = "cellphone_call_listen_base",
                                controllable = true,
                                dictionary = "cellphone@",
                                loop = true,
                                name = "Phone Call",
                                props = { {
                                              bone = 28422,
                                              placement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
                                              prop = "prop_npc_phone_02"
                                          } }
                            }, {
                                clip = "ped_a_enter_loop",
                                controllable = true,
                                dictionary = "anim@heists@humane_labs@finale@keycards",
                                loop = true,
                                name = "Rose",
                                props = { {
                                              bone = 18905,
                                              placement = { 0.13, 0.15, 0.0, -100.0, 0.0, -20.0 },
                                              prop = "prop_single_rose"
                                          } }
                            }, {
                                clip = "mp_player_int_eat_burger",
                                controllable = true,
                                dictionary = "mp_player_inteat@burger",
                                name = "Sandwich",
                                props = { {
                                              bone = 18905,
                                              placement = { 0.13, 0.05, 0.02, -50.0, 16.0, 60.0 },
                                              prop = "prop_sandwich_01"
                                          } }
                            }, {
                                clip = "idle_c",
                                controllable = true,
                                dictionary = "amb@world_human_aa_smoke@male@idle_a",
                                loop = true,
                                name = "Smoke 2",
                                props = { {
                                              bone = 28422,
                                              placement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
                                              prop = "prop_cs_ciggy_01"
                                          } }
                            }, {
                                clip = "idle_b",
                                controllable = true,
                                dictionary = "amb@world_human_aa_smoke@male@idle_a",
                                loop = true,
                                name = "Smoke 3",
                                props = { {
                                              bone = 28422,
                                              placement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
                                              prop = "prop_cs_ciggy_01"
                                          } }
                            }, {
                                clip = "idle_b",
                                controllable = true,
                                dictionary = "amb@world_human_smoking@female@idle_a",
                                loop = true,
                                name = "Smoke 4",
                                props = { {
                                              bone = 28422,
                                              placement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
                                              prop = "prop_cs_ciggy_01"
                                          } }
                            }, {
                                clip = "idle_c",
                                controllable = true,
                                dictionary = "amb@world_human_drinking@coffee@male@idle_a",
                                loop = true,
                                name = "Soda",
                                props = { {
                                              bone = 28422,
                                              placement = { 0.0, 0.0, 0.0, 0.0, 0.0, 130.0 },
                                              prop = "prop_ecola_can"
                                          } }
                            }, {
                                clip = "static",
                                controllable = true,
                                dictionary = "missheistdocksprep1hold_cellphone",
                                loop = true,
                                name = "Suitcase",
                                props = { {
                                              bone = 57005,
                                              placement = { 0.39, 0.0, 0.0, 0.0, 266.0, 60.0 },
                                              prop = "prop_ld_suitcase_01"
                                          } }
                            }, {
                                clip = "static",
                                controllable = true,
                                dictionary = "missheistdocksprep1hold_cellphone",
                                loop = true,
                                name = "Suitcase 2",
                                props = { {
                                              bone = 57005,
                                              placement = { 0.1, 0.0, 0.0, 0.0, 280.0, 53.0 },
                                              prop = "prop_security_case_01"
                                          } }
                            }, {
                                clip = "base",
                                controllable = true,
                                dictionary = "amb@world_human_tourist_map@male@base",
                                loop = true,
                                name = "Tablet",
                                props = { {
                                              bone = 28422,
                                              placement = { 0.0, -0.03, 0.0, 20.0, -90.0, 0.0 },
                                              prop = "prop_cs_tablet"
                                          } }
                            }, {
                                clip = "idle_a",
                                controllable = true,
                                dictionary = "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a",
                                loop = true,
                                name = "Tablet 2",
                                props = { {
                                              bone = 28422,
                                              placement = { -0.05, 0.0, 0.0, 0.0, 0.0, 0.0 },
                                              prop = "prop_cs_tablet"
                                          } }
                            }, {
                                clip = "mp_m_waremech_01_dual-0",
                                controllable = true,
                                dictionary = "impexp_int-0",
                                loop = true,
                                name = "Teddy",
                                props = { {
                                              bone = 24817,
                                              delete_on_end = true,
                                              placement = { -0.2, 0.46, -0.016, -180.0, -90.0, 0.0 },
                                              prop = "v_ilev_mr_rasberryclean"
                                          } }
                            }, {
                                clip = "idle_c",
                                controllable = true,
                                dictionary = "amb@world_human_drinking@coffee@male@idle_a",
                                loop = true,
                                name = "Whiskey",
                                props = { {
                                              bone = 28422,
                                              delete_on_end = true,
                                              placement = { 0.01, -0.01, -0.06, 0.0, 0.0, 0.0 },
                                              prop = "prop_drink_whisky"
                                          } }
                            }, {
                                clip = "ped_a_enter_loop",
                                controllable = true,
                                dictionary = "anim@heists@humane_labs@finale@keycards",
                                loop = true,
                                name = "Wine",
                                props = { {
                                              bone = 18905,
                                              delete_on_end = true,
                                              placement = { 0.1, -0.03, 0.03, -100.0, 0.0, -10.0 },
                                              prop = "prop_drink_redwine"
                                          } }
                            } },
                  name = "Props"
              }, {
                  is_folder = true,
                  items = { {
                                is_folder = true,
                                items = { {
                                              name = "Bird in Tree",
                                              scenario = "PROP_BIRD_IN_TREE"
                                          }, {
                                              name = "Bird on pole",
                                              scenario = "PROP_BIRD_TELEGRAPH_POLE"
                                          }, {
                                              name = "Boar Grazing",
                                              scenario = "WORLD_BOAR_GRAZING"
                                          }, {
                                              name = "Cat Sleeping (Ground)",
                                              scenario = "WORLD_CAT_SLEEPING_GROUND"
                                          }, {
                                              name = "Cat Sleeping (Ledge)",
                                              scenario = "WORLD_CAT_SLEEPING_LEDGE"
                                          }, {
                                              name = "Chicken Hawk Feeding",
                                              scenario = "WORLD_CHICKENHAWK_FEEDING"
                                          }, {
                                              name = "Chicken Hawk Standing",
                                              scenario = "WORLD_CHICKENHAWK_STANDING"
                                          }, {
                                              name = "Cormorant Standing",
                                              scenario = "WORLD_CORMORANT_STANDING"
                                          }, {
                                              name = "Cow Grazing",
                                              scenario = "WORLD_COW_GRAZING"
                                          }, {
                                              name = "Coyote Howl",
                                              scenario = "WORLD_COYOTE_HOWL"
                                          }, {
                                              name = "Coyote Rest",
                                              scenario = "WORLD_COYOTE_REST"
                                          }, {
                                              name = "Coyte Wander",
                                              scenario = "WORLD_COYOTE_WANDER"
                                          }, {
                                              name = "Crow Feeding",
                                              scenario = "WORLD_CROW_FEEDING"
                                          }, {
                                              name = "Crow Standing",
                                              scenario = "WORLD_CROW_STANDING"
                                          }, {
                                              name = "Deer Grazing",
                                              scenario = "WORLD_DEER_GRAZING"
                                          }, {
                                              name = "Dog Barking (Retriever)",
                                              scenario = "WORLD_DOG_BARKING_RETRIEVER"
                                          }, {
                                              name = "Dog Barking (Rottweiler)",
                                              scenario = "WORLD_DOG_BARKING_ROTTWEILER"
                                          }, {
                                              name = "Dog Barking (Shepherd)",
                                              scenario = "WORLD_DOG_BARKING_SHEPHERD"
                                          }, {
                                              name = "Dog Barking (Small)",
                                              scenario = "WORLD_DOG_BARKING_SMALL"
                                          }, {
                                              name = "Dog Sitting (Retriever)",
                                              scenario = "WORLD_DOG_SITTING_RETRIEVER"
                                          }, {
                                              name = "Dog Sitting (Rottweiler)",
                                              scenario = "WORLD_DOG_SITTING_ROTTWEILER"
                                          }, {
                                              name = "Dog Sitting (Shepherd)",
                                              scenario = "WORLD_DOG_SITTING_SHEPHERD"
                                          }, {
                                              name = "Dog Sitting (Small)",
                                              scenario = "WORLD_DOG_SITTING_SMALL"
                                          }, {
                                              name = "Fish Idle",
                                              scenario = "WORLD_FISH_IDLE"
                                          }, {
                                              name = "Gull Feeding",
                                              scenario = "WORLD_GULL_FEEDING"
                                          }, {
                                              name = "Gull Standing",
                                              scenario = "WORLD_GULL_STANDING"
                                          }, {
                                              name = "Hen Pecking",
                                              scenario = "WORLD_HEN_PECKING"
                                          }, {
                                              name = "Hen Standing",
                                              scenario = "WORLD_HEN_STANDING"
                                          }, {
                                              name = "Mountain Lion Rest",
                                              scenario = "WORLD_MOUNTAIN_LION_REST"
                                          }, {
                                              name = "Mountain Lion Wander",
                                              scenario = "WORLD_MOUNTAIN_LION_WANDER"
                                          }, {
                                              name = "Pig Grazing",
                                              scenario = "WORLD_PIG_GRAZING"
                                          }, {
                                              name = "Pigeon Feeding",
                                              scenario = "WORLD_PIGEON_FEEDING"
                                          }, {
                                              name = "Pigeon Standing",
                                              scenario = "WORLD_PIGEON_STANDING"
                                          }, {
                                              name = "Rabbit Eating",
                                              scenario = "WORLD_RABBIT_EATING"
                                          }, {
                                              name = "Rats Eating",
                                              scenario = "WORLD_RATS_EATING"
                                          }, {
                                              name = "Shark Swimming",
                                              scenario = "WORLD_SHARK_SWIM"
                                          } },
                                name = "ANIMALS"
                            }, {
                                is_folder = true,
                                items = { {
                                              name = "AA Coffee",
                                              scenario = "WORLD_HUMAN_AA_COFFEE"
                                          }, {
                                              name = "AA Smoking",
                                              scenario = "WORLD_HUMAN_AA_SMOKE"
                                          }, {
                                              name = "Binoculars",
                                              scenario = "WORLD_HUMAN_BINOCULARS"
                                          }, {
                                              name = "Bum Freeway",
                                              scenario = "WORLD_HUMAN_BUM_FREEWAY"
                                          }, {
                                              name = "Bum Slumped",
                                              scenario = "WORLD_HUMAN_BUM_SLUMPED"
                                          }, {
                                              name = "Bum Standing",
                                              scenario = "WORLD_HUMAN_BUM_STANDING"
                                          }, {
                                              name = "Bum Wash",
                                              scenario = "WORLD_HUMAN_BUM_WASH"
                                          }, {
                                              name = "Campfire",
                                              scenario = "WORLD_HUMAN_STAND_FIRE"
                                          }, {
                                              name = "Car Park Attendant",
                                              scenario = "WORLD_HUMAN_CAR_PARK_ATTENDANT"
                                          }, {
                                              name = "Cheering",
                                              scenario = "WORLD_HUMAN_CHEERING"
                                          }, {
                                              name = "Cleaning",
                                              scenario = "WORLD_HUMAN_MAID_CLEAN"
                                          }, {
                                              name = "Clipboard",
                                              scenario = "WORLD_HUMAN_CLIPBOARD"
                                          }, {
                                              name = "Cop Idle",
                                              scenario = "WORLD_HUMAN_COP_IDLES"
                                          }, {
                                              name = "Drill",
                                              scenario = "WORLD_HUMAN_CONST_DRILL"
                                          }, {
                                              name = "Drinking",
                                              scenario = "WORLD_HUMAN_DRINKING"
                                          }, {
                                              name = "Drug Dealer",
                                              scenario = "WORLD_HUMAN_DRUG_DEALER"
                                          }, {
                                              name = "Drug Dealer Hard",
                                              scenario = "WORLD_HUMAN_DRUG_DEALER_HARD"
                                          }, {
                                              name = "Eat on Wall",
                                              scenario = "WORLD_HUMAN_SEAT_WALL_EATING"
                                          }, {
                                              name = "Fishing",
                                              scenario = "WORLD_HUMAN_STAND_FISHING"
                                          }, {
                                              name = "Gardener",
                                              scenario = "WORLD_HUMAN_GARDENER_PLANT"
                                          }, {
                                              name = "Golfing",
                                              scenario = "WORLD_HUMAN_GOLF_PLAYER"
                                          }, {
                                              name = "Guard Patrol",
                                              scenario = "WORLD_HUMAN_GUARD_PATROL"
                                          }, {
                                              name = "Guard Stand",
                                              scenario = "WORLD_HUMAN_GUARD_STAND"
                                          }, {
                                              name = "Guard Stand (Army)",
                                              scenario = "WORLD_HUMAN_GUARD_STAND_ARMY"
                                          }, {
                                              name = "Hammering",
                                              scenario = "WORLD_HUMAN_HAMMERING"
                                          }, {
                                              name = "Hanging Out",
                                              scenario = "WORLD_HUMAN_HANG_OUT_STREET"
                                          }, {
                                              name = "Hiker Standing",
                                              scenario = "WORLD_HUMAN_HIKER_STANDING"
                                          }, {
                                              name = "Human Statue",
                                              scenario = "WORLD_HUMAN_HUMAN_STATUE"
                                          }, {
                                              name = "Impatient",
                                              scenario = "WORLD_HUMAN_STAND_IMPATIENT"
                                          }, {
                                              name = "Impatient Upright",
                                              scenario = "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT"
                                          }, {
                                              name = "Janitor",
                                              scenario = "WORLD_HUMAN_JANITOR"
                                          }, {
                                              name = "Jog in place",
                                              scenario = "WORLD_HUMAN_JOG_STANDING"
                                          }, {
                                              name = "Leaf Blower",
                                              scenario = "WORLD_HUMAN_GARDENER_LEAF_BLOWER"
                                          }, {
                                              name = "Leaning",
                                              scenario = "WORLD_HUMAN_LEANING"
                                          }, {
                                              name = "Ledge Eating",
                                              scenario = "WORLD_HUMAN_SEAT_LEDGE_EATING"
                                          }, {
                                              name = "Ledge Sit",
                                              scenario = "WORLD_HUMAN_SEAT_LEDGE"
                                          }, {
                                              name = "Mechanic",
                                              scenario = "WORLD_HUMAN_VEHICLE_MECHANIC"
                                          }, {
                                              name = "Muscle Flex",
                                              scenario = "WORLD_HUMAN_MUSCLE_FLEX"
                                          }, {
                                              name = "Musician",
                                              scenario = "WORLD_HUMAN_MUSICIAN"
                                          }, {
                                              name = "Paparazzi",
                                              scenario = "WORLD_HUMAN_PAPARAZZI"
                                          }, {
                                              name = "Partying",
                                              scenario = "WORLD_HUMAN_PARTYING"
                                          }, {
                                              name = "Phone",
                                              scenario = "WORLD_HUMAN_STAND_MOBILE"
                                          }, {
                                              name = "Phone Filming",
                                              scenario = "WORLD_HUMAN_MOBILE_FILM_SHOCKING"
                                          }, {
                                              name = "Phone Upright",
                                              scenario = "WORLD_HUMAN_STAND_MOBILE_UPRIGHT"
                                          }, {
                                              name = "Picnic",
                                              scenario = "WORLD_HUMAN_PICNIC"
                                          }, {
                                              name = "Prositute (High Class)",
                                              scenario = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS"
                                          }, {
                                              name = "Prostitute (Low Class)",
                                              scenario = "WORLD_HUMAN_PROSTITUTE_LOW_CLASS"
                                          }, {
                                              name = "Push Ups",
                                              scenario = "WORLD_HUMAN_PUSH_UPS"
                                          }, {
                                              name = "Shine Torch",
                                              scenario = "WORLD_HUMAN_SECURITY_SHINE_TORCH"
                                          }, {
                                              name = "Sit on Steps",
                                              scenario = "WORLD_HUMAN_SEAT_STEPS"
                                          }, {
                                              name = "Sit on Wall",
                                              scenario = "WORLD_HUMAN_SEAT_WALL"
                                          }, {
                                              name = "Situps",
                                              scenario = "WORLD_HUMAN_SIT_UPS"
                                          }, {
                                              name = "Smoking",
                                              scenario = "WORLD_HUMAN_SMOKING"
                                          }, {
                                              name = "Smoking Pot",
                                              scenario = "WORLD_HUMAN_SMOKING_POT"
                                          }, {
                                              name = "Stupor",
                                              scenario = "WORLD_HUMAN_STUPOR"
                                          }, {
                                              name = "Sunbathe",
                                              scenario = "WORLD_HUMAN_SUNBATHE"
                                          }, {
                                              name = "Sunbathe Back",
                                              scenario = "WORLD_HUMAN_SUNBATHE_BACK"
                                          }, {
                                              name = "Superhero",
                                              scenario = "WORLD_HUMAN_SUPERHERO"
                                          }, {
                                              name = "Swimming",
                                              scenario = "WORLD_HUMAN_SWIMMING"
                                          }, {
                                              name = "Tablet on Wall",
                                              scenario = "WORLD_HUMAN_SEAT_WALL_TABLET"
                                          }, {
                                              name = "Tennis Player",
                                              scenario = "WORLD_HUMAN_TENNIS_PLAYER"
                                          }, {
                                              name = "Tourist Map",
                                              scenario = "WORLD_HUMAN_TOURIST_MAP"
                                          }, {
                                              name = "Tourist Phone",
                                              scenario = "WORLD_HUMAN_TOURIST_MOBILE"
                                          }, {
                                              name = "Watch Stand",
                                              scenario = "WORLD_HUMAN_STRIP_WATCH_STAND"
                                          }, {
                                              name = "Weights",
                                              scenario = "WORLD_HUMAN_MUSCLE_FREE_WEIGHTS"
                                          }, {
                                              name = "Welding",
                                              scenario = "WORLD_HUMAN_WELDING"
                                          }, {
                                              name = "Window Browsing",
                                              scenario = "WORLD_HUMAN_WINDOW_SHOP_BROWSE"
                                          }, {
                                              name = "Yoga",
                                              scenario = "WORLD_HUMAN_YOGA"
                                          } },
                                name = "HUMAN"
                            }, {
                                is_folder = true,
                                items = { {
                                              name = "ATM",
                                              scenario = "PROP_HUMAN_ATM"
                                          }, {
                                              name = "BBQ",
                                              scenario = "PROP_HUMAN_BBQ"
                                          }, {
                                              name = "BUM Shopping Cart",
                                              scenario = "PROP_HUMAN_BUM_SHOPPING_CART"
                                          }, {
                                              name = "Bench Press",
                                              scenario = "PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS"
                                          }, {
                                              name = "Bench Press (Prison)",
                                              scenario = "PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS_PRISON"
                                          }, {
                                              name = "Bum Bin",
                                              scenario = "PROP_HUMAN_BUM_BIN"
                                          }, {
                                              name = "Bus Stop Wait",
                                              scenario = "PROP_HUMAN_SEAT_BUS_STOP_WAIT"
                                          }, {
                                              name = "Cower",
                                              scenario = "CODE_HUMAN_COWER"
                                          }, {
                                              name = "Cower (Standing)",
                                              scenario = "CODE_HUMAN_STAND_COWER"
                                          }, {
                                              name = "Cross road wait",
                                              scenario = "CODE_HUMAN_CROSS_ROAD_WAIT"
                                          }, {
                                              name = "Ear to Text",
                                              scenario = "EAR_TO_TEXT"
                                          }, {
                                              name = "Ear to Text (Fat)",
                                              scenario = "EAR_TO_TEXT_FAT"
                                          }, {
                                              name = "Impatient",
                                              scenario = "PROP_HUMAN_STAND_IMPATIENT"
                                          }, {
                                              name = "Medic Kneel",
                                              scenario = "CODE_HUMAN_MEDIC_KNEEL"
                                          }, {
                                              name = "Medic Tend",
                                              scenario = "CODE_HUMAN_MEDIC_TEND_TO_DEAD"
                                          }, {
                                              name = "Medic Time of Death",
                                              scenario = "CODE_HUMAN_MEDIC_TIME_OF_DEATH"
                                          }, {
                                              name = "Movie Bulb",
                                              scenario = "PROP_HUMAN_MOVIE_BULB"
                                          }, {
                                              name = "Movie Studio Light",
                                              scenario = "PROP_HUMAN_MOVIE_STUDIO_LIGHT"
                                          }, {
                                              name = "Muscle Chinups",
                                              scenario = "PROP_HUMAN_MUSCLE_CHIN_UPS"
                                          }, {
                                              name = "Muscle Chinups (Army)",
                                              scenario = "PROP_HUMAN_MUSCLE_CHIN_UPS_ARMY"
                                          }, {
                                              name = "Muscle Chinups (Prison)",
                                              scenario = "PROP_HUMAN_MUSCLE_CHIN_UPS_PRISON"
                                          }, {
                                              name = "Park Car",
                                              scenario = "CODE_HUMAN_PARK_CAR"
                                          }, {
                                              name = "Parking Meter",
                                              scenario = "PROP_HUMAN_PARKING_METER"
                                          }, {
                                              name = "Police Crowd Control",
                                              scenario = "CODE_HUMAN_POLICE_CROWD_CONTROL"
                                          }, {
                                              name = "Police Investigate",
                                              scenario = "CODE_HUMAN_POLICE_INVESTIGATE"
                                          }, {
                                              name = "Sit & Drink (Bench)",
                                              scenario = "PROP_HUMAN_SEAT_BENCH_DRINK"
                                          }, {
                                              name = "Sit & Drink (Chair)",
                                              scenario = "PROP_HUMAN_SEAT_CHAIR_DRINK"
                                          }, {
                                              name = "Sit & Drink (Deckchair)",
                                              scenario = "PROP_HUMAN_SEAT_DECKCHAIR_DRINK"
                                          }, {
                                              name = "Sit & Drink Beer (Bench)",
                                              scenario = "PROP_HUMAN_SEAT_BENCH_DRINK_BEER"
                                          }, {
                                              name = "Sit & Drink Beer (Chair)",
                                              scenario = "PROP_HUMAN_SEAT_CHAIR_DRINK_BEER"
                                          }, {
                                              name = "Sit & Eat (Bench)",
                                              scenario = "PROP_HUMAN_SEAT_BENCH_FOOD"
                                          }, {
                                              name = "Sit & Eat (Chair)",
                                              scenario = "PROP_HUMAN_SEAT_CHAIR_FOOD"
                                          }, {
                                              name = "Sit (Armchair)",
                                              scenario = "PROP_HUMAN_SEAT_ARMCHAIR"
                                          }, {
                                              name = "Sit (Bar)",
                                              scenario = "PROP_HUMAN_SEAT_BAR"
                                          }, {
                                              name = "Sit (Bench)",
                                              scenario = "PROP_HUMAN_SEAT_BENCH"
                                          }, {
                                              name = "Sit (Chair)",
                                              scenario = "PROP_HUMAN_SEAT_CHAIR"
                                          }, {
                                              name = "Sit (Computer)",
                                              scenario = "PROP_HUMAN_SEAT_COMPUTER"
                                          }, {
                                              name = "Sit (Deckchair)",
                                              scenario = "PROP_HUMAN_SEAT_DECKCHAIR"
                                          }, {
                                              name = "Sit (Sewing)",
                                              scenario = "PROP_HUMAN_SEAT_SEWING"
                                          }, {
                                              name = "Sit (Stripclub)",
                                              scenario = "PROP_HUMAN_SEAT_STRIP_WATCH"
                                          }, {
                                              name = "Sit (Sunlounger)",
                                              scenario = "PROP_HUMAN_SEAT_SUNLOUNGER"
                                          }, {
                                              name = "Sit MP Player",
                                              scenario = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER"
                                          }, {
                                              name = "Sit Upright (Chair)",
                                              scenario = "PROP_HUMAN_SEAT_CHAIR_UPRIGHT"
                                          } },
                                name = "HUMAN2"
                            } },
                  name = "Scenarios"
              } }
}

return constants
