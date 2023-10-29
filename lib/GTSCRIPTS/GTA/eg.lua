--menu.list(egun, "视野工具枪", {}, "玩家镜头中心的位置")

main_tick_handler = {
    draw_point_on_screen = false,
}

AllWeapons_NoMelee_ListItem = {
    { "玩家手持武器", {}, "PLAYER_WEAPON" }
}
for k, v in pairs(util.get_weapons()) do
    -- The inner tables contain hash, label_key, category, & category_id
    local t = { "label", {}, "hash" }
    t[1] = util.get_label_text(v.label_key)
    t[3] = tostring(v.hash)

    if v.category_id ~= 0 then
        table.insert(AllWeapons_NoMelee_ListItem, t)
    end
end

All_VehicleWeapons_ListItem = {
    { "载具当前武器", {}, "VEHICLE_WEAPON" }
}
-- 载具武器
VehicleWeapons = {
    -- { model_name, label_key }
    { "VEHICLE_WEAPON_TANK",                 "WT_V_TANK" },
    { "VEHICLE_WEAPON_SPACE_ROCKET",         "WT_V_PLANEMSL" },
    { "VEHICLE_WEAPON_PLANE_ROCKET",         "WT_V_PLANEMSL" },
    { "VEHICLE_WEAPON_PLAYER_LASER",         "WT_V_PLRLSR" },
    { "VEHICLE_WEAPON_PLAYER_BULLET",        "WT_V_PLRBUL" },
    { "VEHICLE_WEAPON_PLAYER_BUZZARD",       "WT_V_PLRBUL" },
    { "VEHICLE_WEAPON_PLAYER_HUNTER",        "WT_V_PLRBUL" },
    { "VEHICLE_WEAPON_PLAYER_LAZER",         "WT_V_LZRCAN" },
    { "VEHICLE_WEAPON_ENEMY_LASER",          "WT_A_ENMYLSR" },
    { "VEHICLE_WEAPON_TURRET_INSURGENT",     "WT_V_TURRET" },
    { "VEHICLE_WEAPON_TURRET_TECHNICAL",     "WT_V_TURRET" },
    { "VEHICLE_WEAPON_NOSE_TURRET_VALKYRIE", "WT_V_PLRBUL" },
    { "VEHICLE_WEAPON_TURRET_VALKYRIE",      "WT_V_TURRET" },
    { "VEHICLE_WEAPON_PLAYER_SAVAGE",        "WT_V_LZRCAN" },
    { "VEHICLE_WEAPON_TURRET_LIMO",          "WT_V_TURRET" },
    { "VEHICLE_WEAPON_TURRET_BOXVILLE",      "WT_V_TURRET" },
    { "VEHICLE_WEAPON_CANNON_BLAZER",        "WT_V_PLRBUL" },
    { "VEHICLE_WEAPON_RUINER_BULLET",        "WT_V_PLRBUL" },
    { "VEHICLE_WEAPON_RUINER_ROCKET",        "WT_V_PLANEMSL" },
}
for k, v in pairs(VehicleWeapons) do
    local t = { "label", {}, "hash" }
    local label = util.get_label_text(v[2]) .. " (" .. string.gsub(v[1], "VEHICLE_WEAPON_", "") .. ")"
    t[1] = label
    t[3] = tostring(util.joaat(v[1]))
    table.insert(All_VehicleWeapons_ListItem, t)
end

-- 爆炸类型
ExplosionType_ListItem = {
    { "嘟嘟嘟" },                -- -1
    { "手榴弹" },                  -- 0
    { "榴弹发射器" },         -- 1
    { "黏弹" },              -- 2
    { "燃烧瓶" },                  -- 3
    { "火箭炮" },                   -- 4
    { "坦克炮弹" },               -- 5
    { "Hi Octane" },                -- 6
    { "车辆爆炸" },                      -- 7
    { "飞机爆炸" },                    -- 8
    { "油站爆炸" },              -- 9
    { "摩托爆炸" },                     -- 10
    { "水柱" },                    -- 11
    { "火柱" },                    -- 12
    { "消防栓" },            -- 13
    { "气体燃烧" },       -- 14
    { "游艇爆炸" },                     -- 15
    { "拖船爆炸" },                     -- 16
    { "卡车爆炸" },                    -- 17
    { "爆炸子弹" },                   -- 18
    { "烟雾发射器" },   -- 19
    { "烟雾弹" },            -- 20
    { "催泪瓦斯" },                   -- 21
    { "信号弹" },                    -- 22
    { "油罐爆炸" },             -- 23
    { "灭火器" },             -- 24
    { "Programmable AR" },          -- 25
    { "火车" },                    -- 26
    { "飞艇(蓝)" },            -- 27
    { "丙烷" },                  -- 28
    { "软皮艇" },                    -- 29
    { "火焰爆炸" },            -- 30
    { "油罐车" },                   -- 31
    { "飞机爆炸" },             -- 32
    { "Vehicle Bullet" },           -- 33
    { "火灾坦克" },                 -- 34
    { "Bird Crap" },                -- 35
    { "电磁枪弹" },                  -- 36
    { "飞艇(红/青)" },       -- 37
    { "烟花" },                 -- 38
    { "雪球" },                 -- 39
    { "感应地雷" },           -- 40
    { "女武神机炮" },          -- 41
    { "飞机解体" },              -- 42
    { "管状炸弹" },                -- 43
    { "Vehicle Mine" },             -- 44
    { "Explosive Ammo" },           -- 45
    { "APC Shell" },                -- 46
    { "Cluster Bomb" },             -- 47
    { "Gas Bomb" },                 -- 48
    { "Incendiary Bomb" },          -- 49
    { "Standard Bomb" },            -- 50
    { "Torpedo" },                  -- 51
    { "Torpedo (Underwater)" },     -- 52
    { "Bombushka Cannon" },         -- 53
    { "Cluster Bomb 2" },           -- 54
    { "Hunter Barrage" },           -- 55
    { "Hunter Cannon" },            -- 56
    { "Rogue Cannon" },             -- 57
    { "Underwater Mine" },          -- 58
    { "Orbital Cannon" },           -- 59
    { "Standard Bomb (Wide)" },     -- 60
    { "Explosive Ammo (Shotgun)" }, -- 61
    { "Oppressor Mk2 Cannon" },     -- 62
    { "Kinetic Mortar" },           -- 63
    { "Kinetic Vehicle Mine" },     -- 64
    { "Emp Vehicle Mine" },         -- 65
    { "Spike Vehicle Mine" },       -- 66
    { "Slick Vehicle Mine" },       -- 67
    { "Tar Vehicle Mine" },         -- 68
    { "Script Drone" },             -- 69
    { "Raygun" },                   -- 70
    { "Buried Mine" },              -- 71
    { "Script Missile" },           -- 72
    { "RC激光炮" },           -- 73
    { "Water Bomb" },               -- 74
    { "Water Bomb 2" },             -- 75
    { "Cnc Spike Mine" },           -- 76
    { "BZ Gas Mk2" },               -- 77
    { "Flash Grenade" },            -- 78
    { "Stun Grenade" },             -- 79
    { "Cnc Kinetic Ram" },          -- 80
    { "Large Missile" },            -- 81
    { "Big Submarine" },            -- 82
    { "原子能" }              -- 83
}

Cam_Gun = {
    select = 1,
}

--- Shoot ---
Cam_Gun.shoot_setting = {
    shoot_method = 1,
    delay = 100,
    weapon_select = 1,
    weapon_hash = "PLAYER_WEAPON",
    vehicle_weapon_hash = "VEHICLE_WEAPON",
    is_owned = false,
    CreateTraceVfx = true,
    AllowRumble = true,
    damage = 1000,
    speed = 1000,
    PerfectAccuracy = false,
    start_from_player = false,
    x = 0.0,
    y = 0.0,
    z = 2.0,
}

function Cam_Gun.Shoot_Pos(pos, state)
    local user_ped = players.user_ped()

    local weaponHash = Cam_Gun.shoot_setting.weapon_hash
    if Cam_Gun.shoot_setting.weapon_select == 2 then
        weaponHash = Cam_Gun.shoot_setting.vehicle_weapon_hash
    end

    if weaponHash == "PLAYER_WEAPON" then
        local pWeapon = memory.alloc_int()
        WEAPON.GET_CURRENT_PED_WEAPON(user_ped, pWeapon, true)
        weaponHash = memory.read_int(pWeapon)
    elseif weaponHash == "VEHICLE_WEAPON" then
        local pWeapon = memory.alloc_int()
        WEAPON.GET_CURRENT_PED_VEHICLE_WEAPON(user_ped, pWeapon)
        weaponHash = memory.read_int(pWeapon)
    end
    if not WEAPON.HAS_WEAPON_ASSET_LOADED(weaponHash) then
        request_weapon_asset(weaponHash)
    end

    local owner = 0
    if Cam_Gun.shoot_setting.is_owned then
        owner = user_ped
    end

    local start_pos = v3.new()
    if Cam_Gun.shoot_setting.start_from_player then
        local player_pos = ENTITY.GET_ENTITY_COORDS(user_ped)
        start_pos.x = player_pos.x + Cam_Gun.shoot_setting.x
        start_pos.y = player_pos.y + Cam_Gun.shoot_setting.y
        start_pos.z = player_pos.z + Cam_Gun.shoot_setting.z
    else
        start_pos.x = pos.x + Cam_Gun.shoot_setting.x
        start_pos.y = pos.y + Cam_Gun.shoot_setting.y
        start_pos.z = pos.z + Cam_Gun.shoot_setting.z
    end

    if state == "draw_line" then
        DRAW_LINE(start_pos, pos)
    elseif state == "shoot" then
        local ignore_entity = user_ped
        if PED.IS_PED_IN_ANY_VEHICLE(user_ped, false) then
            ignore_entity = PED.GET_VEHICLE_PED_IS_IN(user_ped, false)
        end

        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(start_pos.x, start_pos.y, start_pos.z,
            pos.x, pos.y, pos.z,
            Cam_Gun.shoot_setting.damage, Cam_Gun.shoot_setting.PerfectAccuracy, weaponHash, owner,
            Cam_Gun.shoot_setting.CreateTraceVfx, Cam_Gun.shoot_setting.AllowRumble, Cam_Gun.shoot_setting.speed,
            ignore_entity)
    end
end

function Cam_Gun.Shoot()
    local cam_pos
    if Cam_Gun.shoot_setting.shoot_method == 1 then
        local result = get_raycast_result(1500, -1)
        if result.didHit then
            cam_pos = result.endCoords
        end
    elseif Cam_Gun.shoot_setting.shoot_method == 2 then
        cam_pos = get_offset_from_cam(1500)
    end

    if cam_pos ~= nil then
        Cam_Gun.Shoot_Pos(cam_pos, "shoot")
        util.yield(Cam_Gun.shoot_setting.delay)
    end
end

--- Explosion ---
Cam_Gun.explosion_setting = {
    delay = 100,
    explosionType = 2,
    is_owned = false,
    damage = 1000,
    is_audible = true,
    is_invisible = false,
    camera_shake = 0.0,
}

function Cam_Gun.Explosion()
    local result = get_raycast_result(1500, -1)
    local cam_pos = result.endCoords
    if result.didHit and cam_pos ~= nil then
        if Cam_Gun.explosion_setting.is_owned then
            FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), cam_pos.x, cam_pos.y, cam_pos.z,
                Cam_Gun.explosion_setting.explosionType, Cam_Gun.explosion_setting.damage,
                Cam_Gun.explosion_setting.is_audible, Cam_Gun.explosion_setting.is_invisible,
                Cam_Gun.explosion_setting.camera_shake)
        else
            FIRE.ADD_EXPLOSION(cam_pos.x, cam_pos.y, cam_pos.z, Cam_Gun.explosion_setting.explosionType,
                Cam_Gun.explosion_setting.damage, Cam_Gun.explosion_setting.is_audible,
                Cam_Gun.explosion_setting.is_invisible
                , Cam_Gun.explosion_setting.camera_shake, false)
        end
        util.yield(Cam_Gun.explosion_setting.delay)
    end
end

menu.toggle_loop(Weapon_Cam_Gun, "开启[E键]", { "startegun" }, "", function()
    main_tick_handler.draw_point_on_screen = true
    if PAD.IS_CONTROL_PRESSED(0, 51) then
        if Cam_Gun.select == 1 then
            Cam_Gun.Shoot()
        elseif Cam_Gun.select == 2 then
            Cam_Gun.Explosion()
        elseif Cam_Gun.select == 3 then
            Cam_Gun.Fire()
        end
    end
end, function()
    main_tick_handler.draw_point_on_screen = false
end)

menu.list_select(Weapon_Cam_Gun, "选择操作", { "selectguntype" }, "", {
    { "射击", { "shoot" },     "需要手持武器" },
    { "爆炸", { "explosion" }, "不需要手持武器" },
}, 1, function(value)
    Cam_Gun.select = value
end)


menu.divider(Weapon_Cam_Gun, "设置")
----------------
-- 射击设置
----------------
local Cam_Gun_shoot = menu.list(Weapon_Cam_Gun, "射击", {}, "")

menu.toggle_loop(Cam_Gun_shoot, "射线预览", {}, "", function()
    main_tick_handler.draw_point_on_screen = true

    local cam_pos
    if Cam_Gun.shoot_setting.shoot_method == 1 then
        local result = get_raycast_result(1500, -1)
        if result.didHit then
            cam_pos = result.endCoords
        end
    elseif Cam_Gun.shoot_setting.shoot_method == 2 then
        cam_pos = get_offset_from_cam(1500)
    end

    if cam_pos ~= nil then
        Cam_Gun.Shoot_Pos(cam_pos, "draw_line")
    end
end, function()
    main_tick_handler.draw_point_on_screen = false
end)

menu.list_select(Cam_Gun_shoot, "射击方式", {}, "", {
    { "方式1", {}, "射击的坐标更加准确，只能向实体或地面射击" },
    { "方式2", {}, "射击的坐标不是很准确，但可以向空中射击" }
}, 1, function(value)
    Cam_Gun.shoot_setting.shoot_method = value
end)
menu.slider(Cam_Gun_shoot, "循环延迟", { "gunloopdelay" }, "单位: ms", 0, 5000, 0, 10,
    function(value)
        Cam_Gun.shoot_setting.delay = value
    end)

local Cam_Gun_shoot_weapon = menu.list(Cam_Gun_shoot, "选择武器", {}, "无论选择什么，都必须手持武器，除非在武装载具内")
menu.list_select(Cam_Gun_shoot_weapon, "武器类型", {}, "", { { "手持武器" }, { "载具武器" } }, 1,
    function(value)
        Cam_Gun.shoot_setting.weapon_select = value
    end)
menu.list_select(Cam_Gun_shoot_weapon, "手持武器", {}, "", AllWeapons_NoMelee_ListItem, 1, function(value)
    Cam_Gun.shoot_setting.weapon_hash = AllWeapons_NoMelee_ListItem[value][3]
end)
menu.list_select(Cam_Gun_shoot_weapon, "载具武器", {}, "", All_VehicleWeapons_ListItem, 1, function(value)
    Cam_Gun.shoot_setting.vehicle_weapon_hash = All_VehicleWeapons_ListItem[value][3]
end)

menu.toggle(Cam_Gun_shoot, "署名射击", {}, "以玩家名义", function(toggle)
    Cam_Gun.shoot_setting.is_owned = toggle
end)
menu.slider(Cam_Gun_shoot, "伤害指数", { "damageforshoot" }, "", 0, 10000, 1000, 100,
    function(value)
        Cam_Gun.shoot_setting.damage = value
    end)
menu.slider(Cam_Gun_shoot, "射击速度", { "speedforshoot" }, "", 0, 10000, 1000, 100,
    function(value)
        Cam_Gun.shoot_setting.speed = value
    end)
menu.toggle(Cam_Gun_shoot, "创建轨迹", {}, "", function(toggle)
    Cam_Gun.shoot_setting.CreateTraceVfx = toggle
end, true)
menu.toggle(Cam_Gun_shoot, "允许子弹声音", {}, "", function(toggle)
    Cam_Gun.shoot_setting.AllowRumble = toggle
end, true)
menu.toggle(Cam_Gun_shoot, "完美的准确性", {}, "", function(toggle)
    Cam_Gun.shoot_setting.PerfectAccuracy = toggle
end)
menu.divider(Cam_Gun_shoot, "起始射击位置偏移")
menu.toggle(Cam_Gun_shoot, "从玩家位置起始射击", {}, "如果关闭，则起始位置为目标位置+偏移\n如果开启，建议偏移Z>1.0"
    ,
    function(toggle)
        Cam_Gun.shoot_setting.start_from_player = toggle
    end)
menu.slider_float(Cam_Gun_shoot, "X", { "xforshoot" }, "", -10000, 10000, 0, 10,
    function(value)
        value = value * 0.01
        Cam_Gun.shoot_setting.x = value
    end)
menu.slider_float(Cam_Gun_shoot, "Y", { "yforshoot" }, "", -10000, 10000, 0, 10,
    function(value)
        value = value * 0.01
        Cam_Gun.shoot_setting.y = value
    end)
menu.slider_float(Cam_Gun_shoot, "Z", { "zforshoot" }, "", -10000, 10000, 200, 10,
    function(value)
        value = value * 0.01
        Cam_Gun.shoot_setting.z = value
    end)

----------------
-- 爆炸设置
----------------
local Cam_Gun_explosion = menu.list(Weapon_Cam_Gun, "爆炸", {}, "")

menu.slider(Cam_Gun_explosion, "循环延迟", { "gunexpdelay" }, "单位: ms", 0, 5000, 0, 10,
    function(value)
        Cam_Gun.explosion_setting.delay = value
    end)
menu.list_select(Cam_Gun_explosion, "爆炸类型", {}, "", ExplosionType_ListItem, 4, function(index)
    Cam_Gun.explosion_setting.explosionType = index - 2
end)
menu.toggle(Cam_Gun_explosion, "署名爆炸", {}, "以玩家名义", function(toggle)
    Cam_Gun.explosion_setting.is_owned = toggle
end)
menu.slider(Cam_Gun_explosion, "伤害指数", { "gunexpdamage" }, "", 0, 10000, 1000, 100,
    function(value)
        Cam_Gun.explosion_setting.damage = value
    end)
menu.toggle(Cam_Gun_explosion, "可听见", {}, "", function(toggle)
    Cam_Gun.explosion_setting.is_audible = toggle
end, true)
menu.toggle(Cam_Gun_explosion, "不可见", {}, "", function(toggle)
    Cam_Gun.explosion_setting.is_invisible = toggle
end)
menu.slider_float(Cam_Gun_explosion, "镜头晃动", { "gunexpshake" }, "", 0, 1000, 0, 10,
function(value)
    value = value * 0.01
    Cam_Gun.explosion_setting.camera_shake = value
end)