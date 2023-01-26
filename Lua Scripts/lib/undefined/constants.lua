-- Undefined
--==============狗白又看你爹脚本是吧
--=====狗白别来偷你爹脚本--偷了就是我儿！！！
return {
    SCRIPT = {
        NAME = "Undefined",
        COMMAND_PREFIX = "und",
        VERSION = "1.7.0",
        PLAYER_SORT_OPTIONS = {"Distance", "Rank", "Money", "KD", "Name", "Host position"},
        COLORS = {
            LIST = {
                main = {
                    r = 1,
                    g = 1,
                    b = 1,
                    a = 1
                },
                dead = {
                    r = 0,
                    g = 0,
                    b = 0,
                    a = 1
                },
                interior = {
                    r = 1,
                    g = 1,
                    b = 1,
                    a = 0.5
                },
                modder = {
                    r = 1,
                    g = 0,
                    b = 0,
                    a = 1
                },
                otr = {
                    r = 1,
                    g = 1,
                    b = 0,
                    a = 1
                }
            },
            AIM = {
                hotkeys = {
                    r = 0,
                    g = 1,
                    b = 0,
                    a = 1
                },
                line = {
                    r = 0,
                    g = 1,
                    b = 0,
                    a = 0.6
                },
                highlight = {
                    r = 0,
                    g = 1,
                    b = 0,
                    a = 1
                }
            }
        }
    },
    GAME = {
        WANTED_LEVELS = {
            [0] = "0",
            [1] = "1",
            [2] = "2",
            [3] = "3",
            [4] = "4",
            [5] = "5"
        },
        BULLET_TYPES = {{
            "电磁脉冲",
            hash = "WEAPON_RAYPISTOL"
        }, {
            "烟花",
            hash = "WEAPON_FIREWORK"
        }, {
            "大炮",
            hash = "WEAPON_RPG"
        }, {
            "榴弹",
            hash = "WEAPON_GRENADELAUNCHER"
        }, {
            "烟雾弹",
            hash = "WEAPON_GRENADELAUNCHER_SMOKE"
        }, {
            "激光枪",
            hash = "WEAPON_RAYCARBINE"
        }, {
            "燃烧瓶",
            hash = "WEAPON_MOLOTOV"
        }, {
            "网球",
            hash = "WEAPON_BALL"
        }, {
            "雪球",
            hash = "WEAPON_SNOWBALL"
        }, {
            "信号弹",
            hash = "WEAPON_FLAREGUN"
        }}
    },
    RAYCAST = {
        TraceFlag = {
            all = 4294967295,
            vehicles = 2,
            peds = 8,
            objects = 16
        }
    }
};
--===