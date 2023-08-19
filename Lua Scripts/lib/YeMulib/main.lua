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


----黑名单表
blacklist={"1111",-----测试黑名单,发布时删除
    "jiangling6998",------江陵,盗版lua作者(jiangling lua),呼吁大家抵制盗版,因为正版也不收费
    "SDFRRTG",----恶意玩家
    "xdjzswd",----恶意玩家
    "Angel00512",----STAND魔怔玩家（动不动恶搞其他STAND玩家）
}
function Black_list()
    -----检测到战局有黑名单直接踢
    for pid = 0, 31 do
        Blacklist_player = players.get_name(pid)
            for i = 1, #blacklist do
                if blacklist[i] == Blacklist_player then
                    util.toast("检测到黑名单玩家: "..Blacklist_player.."\n已执行踢出")
                    menu.trigger_commands("kick " .. Blacklist_player)
                end
            end
    end
end
function Black_self()
    -----检测到使用者存在于黑名单直接闪退游戏
    Blacklist_self = players.get_name(players.user())
    for i = 0, #blacklist do
        if blacklist[i] == Blacklist_self then
                os.exit() 
                --此为闪退游戏内容,测试时务必隐藏此句,以免游戏闪退(发布时开启)
        end
    end
end




----手指枪
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
function shouzhiqiang()
    for id, data in pairs(weapon_stuff) do
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
                    local fingerPos = PED.GET_PED_BONE_COORDS(players.user_ped(), 0xff9, 1.0, 0, 0)
                    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(fingerPos.x, fingerPos.y, fingerPos.z, x, y, z, 1, true, projectile, 0, true, false, 500.0, players.user_ped(), 0)
                end
                util.yield(100)
            end
            local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
            MISC.CLEAR_AREA_OF_PROJECTILES(pos.x, pos.y, pos.z, 999999, 0)
        end)
    end
end

----钢铁侠
function getOffsetFromCam(dist)
    local pos = CAM.GET_FINAL_RENDERED_CAM_COORD()
    local dir = v3.toDir(CAM.GET_FINAL_RENDERED_CAM_ROT(2))
    local offset = {
        x = pos.x + dir.x * dist,
        y = pos.y + dir.y * dist,
        z = pos.z + dir.z * dist
    }
    return offset
end

----激光眼
local function request_ptfx_asset_lasereyes(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end
--激光眼
function laser_eyes()
    local weaponHash = util.joaat("weapon_heavysniper_mk2")
    local dictionary = "weap_xs_weapons"
    local ptfx_name = "bullet_tracer_xs_sr"
    local camRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
    if PAD.IS_CONTROL_PRESSED(51, 51) then
        local inst = v3.new()
        v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
        local tmp = v3.toDir(inst)
        v3.set(inst, v3.get(tmp))
        v3.mul(inst, 1000)
        v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
        v3.add(inst, tmp)
        camAim_x, camAim_y, camAim_z = v3.get(inst)
        local ped_model = ENTITY.GET_ENTITY_MODEL(players.user_ped())
        local left_eye_id = 0
        local right_eye_id = 0
        pluto_switch ped_model do 
            case 1885233650:
            case -1667301416:
                left_eye_id = 25260
                right_eye_id = 27474
                break
            case 225514697:
            default:
                left_eye_id = 5956
                right_eye_id = 6468
        end
        local boneCoord_L = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), left_eye_id))
        local boneCoord_R = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), right_eye_id))
        if ped_model == util.joaat("mp_f_freemode_01") then 
            boneCoord_L.z += 0.02
            boneCoord_R.z += 0.02
        end
        camRot.x += -90
        request_ptfx_asset_lasereyes(dictionary)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
    end
end

attachments_table = {
    ---------------------PISTOLS--------------------------------------
    ["0xFED0FD71"] = "Default Clip", --Default Clip
    ["0xED265A1C"] = "Extended Clip", --Extended Clip
    ["0x359B7AAE"] = "Flashlight", --Flashlight
    ["0x65EA7EBB"] = "Suppressor", --Suppressor
    ["0xD7391086"] = "Yusuf Amir Luxury Finish", --Yusuf Amir Luxury Finish
    ["0x721B079"] = "Default Clip", --Default Clip
    ["0xD67B4F2D"] = "Extended Clip", --Extended Clip
    ["0xC304849A"] = "Suppressor", --Suppressor
    ["0xC6654D72"] = "Yusuf Amir Luxury Finish", --Yusuf Amir Luxury Finish
    ["0x31C4B22A"] = "Default Clip", --Default Clip
    ["0x249A17D5"] = "Extended Clip", --Extended Clip
    ["0x9B76C72C"] = "Gilded Gun Metal Finish", --Gilded Gun Metal Finish
    ["0x2297BE19"] = "Default Clip", --Default Clip
    ["0xD9D3AC92"] = "Extended Clip", --Extended Clip
    ["0xA73D4664"] = "Suppressor", --Suppressor
    ["0x77B8AB2F"] = "Platinum Pearl Deluxe Finish", --Platinum Pearl Deluxe Finish
    ["0x16EE3040"] = "VIP Variant", --VIP Variant
    ["0x9493B80D"] = "Bodyguard Variant", --Bodyguard Variant
    ["0xE9867CE3"] = "Default Clip", --Default Clip
    ["0xF8802ED9"] = "Default Clip", --Default Clip
    ["0x7B0033B3"] = "Extended Clip", --Extended Clip
    ["0x8033ECAF"] = "Etched Wood Grip Finish", --Etched Wood Grip Finish
    ["0xD4A969A"] = "Default Clip", --Default Clip
    ["0x64F9C62B"] = "Extended Clip", --Extended Clip
    ["0x7A6A7B7B"] = "Etched Wood Grip Finish", --Etched Wood Grip Finish
    ["0xBA23D8BE"] = "Default Rounds", --Default Rounds
    ["0xC6D8E476"] = "Tracer Rounds", --Tracer Rounds
    ["0xEFBF25"] = "Incendiary Rounds", --Incendiary Rounds
    ["0x10F42E8F"] = "Hollow Point Rounds", --Hollow Point Rounds
    ["0xDC8BA3F"] = "Full Metal Jacket Rounds", --Full Metal Jacket Rounds
    ["0x420FD713"] = "Holographic Sight", --Holographic Sight
    ["0x49B2945"] = "Small Scope", --Small Scope
    ["0x27077CCB"] = "Compensator", --Compensator
    ["0xC03FED9F"] = "Digital Camo", --Digital Camo
    ["0xB5DE24"] = "Brushstroke Camo", --Brushstroke Camo
    ["0xA7FF1B8"] = "Woodland Camo", --Woodland Camo
    ["0xF2E24289"] = "Skull", --Skull
    ["0x11317F27"] = "Sessanta Nove", --Sessanta Nove
    ["0x17C30C42"] = "Perseus", --Perseus
    ["0x257927AE"] = "Leopard", --Leopard
    ["0x37304B1C"] = "Zebra", --Zebra
    ["0x48DAEE71"] = "Geometric", --Geometric
    ["0x20ED9B5B"] = "Boom!", --Boom!
    ["0xD951E867"] = "Patriotic", --Patriotic
    ["0x1466CE6"] = "Default Clip", --Default Clip
    ["0xCE8C0772"] = "Extended Clip", --Extended Clip
    ["0x902DA26E"] = "Tracer Rounds", --Tracer Rounds
    ["0xE6AD5F79"] = "Incendiary Rounds", --Incendiary Rounds
    ["0x8D107402"] = "Hollow Point Rounds", --Hollow Point Rounds
    ["0xC111EB26"] = "Full Metal Jacket Rounds", --Full Metal Jacket Rounds
    ["0x4A4965F3"] = "Flashlight", --Flashlight
    ["0x47DE9258"] = "Mounted Scope", --Mounted Scope
    ["0xAA8283BF"] = "Compensator", --Compensator
    ["0xF7BEEDD"] = "Digital Camo", --Digital Camo
    ["0x8A612EF6"] = "Brushstroke Camo", --Brushstroke Camo
    ["0x76FA8829"] = "Woodland Camo", --Woodland Camo
    ["0xA93C6CAC"] = "Skull", --Skull
    ["0x9C905354"] = "Sessanta Nove", --Sessanta Nove
    ["0x4DFA3621"] = "Perseus", --Perseus
    ["0x42E91FFF"] = "Leopard", --Leopard
    ["0x54A8437D"] = "Zebra", --Zebra
    ["0x68C2746"] = "Geometric", --Geometric
    ["0x2366E467"] = "Boom!", --Boom!
    ["0x441882E6"] = "Boom!", --Boom!
    ["0xE7EE68EA"] = "Digital Camo", --Digital Camo
    ["0x29366D21"] = "Brushstroke Camo", --Brushstroke Camo
    ["0x3ADE514B"] = "Woodland Camo", --Woodland Camo
    ["0xE64513E9"] = "Skull", --Skull
    ["0xCD7AEB9A"] = "Sessanta Nove", --Sessanta Nove
    ["0xFA7B27A6"] = "Perseus", --Perseus
    ["0xE285CA9A"] = "Leopard", --Leopard
    ["0x2B904B19"] = "Zebra", --Zebra
    ["0x22C24F9C"] = "Geometric", --Geometric
    ["0x8D0D5ECD"] = "Boom!", --Boom!
    ["0x1F07150A"] = "Patriotic", --Patriotic
    ["0x94F42D62"] = "Default Clip", --Default Clip
    ["0x5ED6C128"] = "Extended Clip", --Extended Clip
    ["0x25CAAEAF"] = "Tracer Rounds", --Tracer Rounds
    ["0x2BBD7A3A"] = "Incendiary Rounds", --Incendiary Rounds
    ["0x85FEA109"] = "Hollow Point Rounds", --Hollow Point Rounds
    ["0x4F37DF2A"] = "Full Metal Jacket Rounds", --Full Metal Jacket Rounds
    ["0x8ED4BB70"] = "Mounted Scope", --Mounted Scope
    ["0x43FD595B"] = "Flashlight", --Flashlight
    ["0x21E34793"] = "Compensator", --Compensator
    ["0x5C6C749C"] = "Digital Camo", --Digital Camo
    ["0x15F7A390"] = "Brushstroke Camo", --Brushstroke Camo
    ["0x968E24DB"] = "Woodland Camo", --Woodland Camo
    ["0x17BFA99"] = "Skull", --Skull
    ["0xF2685C72"] = "Sessanta Nove", --Sessanta Nove
    ["0xDD2231E6"] = "0xDD2231E6", --Perseus
    ["0xBB43EE76"] = "Leopard", --Leopard
    ["0x4D901310"] = "Zebra", --Zebra
    ["0x5F31B653"] = "Geometric", --Geometric
    ["0x697E19A0"] = "Boom!", --Boom!
    ["0x930CB951"] = "Patriotic", --Patriotic
    ["0xB4FC92B0"] = "Digital Camo", --Digital Camo
    ["0x1A1F1260"] = "Digital Camo", --Digital Camo
    ["0xE4E00B70"] = "Digital Camo",
    ["0x2C298B2B"] = "Digital Camo",
    ["0xDFB79725"] = "Digital Camo",
    ["0x6BD7228C"] = "Digital Camo",
    ["0x9DDBCF8C"] = "Digital Camo",
    ["0xB319A52C"] = "Digital Camo",
    ["0xC6836E12"] = "Digital Camo",
    ["0x43B1B173"] = "Digital Camo",
    ["0x4ABDA3FA"] = "Patriotic", --Patriotic
    ["0x45A3B6BB"] = "Default Clip", --Default Clip
    ["0x33BA12E8"] = "Extended Clip", --Extended Clip
    ["0xD7DBF707"] = "Festive tint", --Festive tint
    ["0x54D41361"] = "Default Clip", --Default Clip
    ["0x81786CA9"] = "Extended Clip", --Extended Clip
    ["0x9307D6FA"] = "Suppressor", --Suppressor
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
----娱乐粒子效果
funptfxlist = {
    "糖块",
    "金属碎片",
    "火焰",
    "赌场筹码",
    "香烟",
    "橙子雨",
    "火花",
    "泡沐雨",
    "硬币",
    "电线杆故障",
    "电器箱故障",
    "充气羽毛",
    "飘叶",
    "枫叶",
    "爆竹",
    "小丑喷射",
    "小丑花",
    "星空",
    "摇曳烟花",
    "光遇"
}
funptfx = {
    {"core","ent_dst_gen_gobstop","5"},
    {"core","ent_brk_metal_frag","5"},
    {"core","ent_sht_flame","5"},
    {"core","ent_dst_casino_chips","5"},
    {"core","ent_dst_cig_packets","5"},
    {"core","ent_col_tree_oranges","5"},
    {"core","ent_brk_sparking_wires","5"},
    {"core","water_boat_exit","5"},
    {"core","ent_brk_coins","5"},
    {"core","ent_sht_telegraph_pole","5"},
    {"core","ent_sht_electrical_box","5"},
    {"core","ent_dst_inflate_ring","2"},
    {"core","ent_sht_bush_foliage","5"},
    {"core","ent_col_bush_leaves","5"},
    {"scr_sm_counter","scr_sm_counter_chaff","1"},
    {"scr_rcbarry2", "muz_clown","1.5"},
    {"scr_rcbarry2", "scr_clown_bul","1.5"},
    {"scr_rcpaparazzo1","scr_mich4_firework_burst_spawn","1"},
    {"scr_indep_fireworks","scr_indep_firework_trail_spawn","1"},
    {"scr_ie_tw", "scr_impexp_tw_take_zone","1"}
}
----粒子拖尾
vehparticle_name = {"烟花拖尾1","烟花拖尾2"}
vehparticle_tb = {"scr_mich4_firework_trail_spawn","scr_mich4_firework_sparkle_spawn"}
style_names = {"正常", "半冲刺", "反向", "无视红绿灯", "避开交通", "极度避开交通", "有时超车"}
wasd = {
    [1]  = { keys = {44, 52, 85, 138, 141, 152, 205, 264},                                               pressed = false, key = 'Q',     show = true },
    [2]  = { keys = {32, 71, 77, 87, 129, 136, 150, 232},                                                pressed = false, key = 'W',     show = true },
    [3]  = { keys = {38, 46, 51, 54, 86, 103, 119, 153, 184, 206, 350, 351, 355, 356},                   pressed = false, key = 'E',     show = true },
    [4]  = { keys = {45, 80, 140, 250, 263, 310},                                                        pressed = false, key = 'R',     show = true },
    [5]  = { keys = {34 ,63, 89, 133, 147, 234, 338},                                                    pressed = false, key = 'A',     show = true },
    [6]  = { keys = {8, 31, 33, 72, 78, 88, 130, 139, 149, 151, 196, 219, 233, 268, 269, 302},           pressed = false, key = 'S',     show = true },
    [7]  = { keys = {9, 30, 35, 59, 64, 90, 134, 146, 148, 195, 218, 235, 266, 267, 278, 279, 339, 342}, pressed = false, key = 'D',     show = true },
    [8]  = { keys = {23, 49, 75, 145, 185, 251},                                                         pressed = false, key = 'F',     show = true },
    [9]  = { keys = {21, 61, 131, 155, 209, 254, 340, 352},                                              pressed = false, key = 'Shift', show = true },
    [10] = { keys = {36, 60, 62, 132, 224, 280, 281, 326, 341, 343},                                     pressed = false, key = 'Ctrl',  show = true },
    [11] = { keys = {18, 22, 55, 76, 102, 143, 179, 203, 216, 255, 298, 321, 328, 353},                  pressed = false, key = 'Space', show = true },
}
proofs = {
    bullet = {name="子弹",on=false},
    fire = {name="火烧",on=false},
    explosion = {name="爆炸",on=false},
    collision = {name="撞击",on=false},
    melee = {name="近战",on=false},
    steam = {name="蒸汽",on=false},
    drown = {name="遇水浸死",on=false},
}
read_global = {
	byte = function(global)
		local address = memory.script_global(global)
		return memory.read_byte(address)
	end,
	int = function(global)
		local address = memory.script_global(global)
		return memory.read_int(address)
	end,
	float = function(global)
		local address = memory.script_global(global)
		return memory.read_float(address)
	end,
	string = function(global)
		local address = memory.script_global(global)
		return memory.read_string(address)
	end
}
HudColour =
{
	pureWhite = 0,
	white = 1,
	black = 2,
	grey = 3,
	greyLight = 4,
	greyDrak = 5,
	red = 6,
	redLight = 7,
	redDark = 8,
	blue = 9,
	blueLight = 10,
	blueDark = 11,
	yellow = 12,
	yellowLight = 13,
	yellowDark = 14,
	orange = 15,
	orangeLight = 16,
	orangeDark = 17,
	green = 18,
	greenLight = 19,
	greenDark = 20,
	purple = 21,
	purpleLight = 22,
	purpleDark = 23,
	radarHealth = 25,
	radarArmour = 26,
	friendly = 118,
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
whitelistGroups = {user = true, friends = true, strangers  = true}
expSettings = {camShake = 0, invisible = false, audible = true, noDamage = false, owned = false, blamed = false, blamedPlayer = false, expType = 0}

function acknowledgement()

    menu.divider(script_meta_menu, "快速加群")
    menu.action(script_meta_menu, "快进来！", {}, "欢迎加入GTA夜幕用户群！", function()
    util.toast("快进来,劝你耗子尾汁！~")
    end)
    menu.hyperlink(script_meta_menu, "加入新夜幕官方用户群", "https://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=VzopCmy2xBEAkYmSU8ya4xQbllzQFQHv&authKey=NHDDDI56aESkD3ZS9E2W51WBf7MyvDkVkd5J5bGODrKpEL%2B0khMEESePgDemnlSV&noverify=0&group_code=859074951")
    menu.readonly(script_meta_menu, "夜幕官方网站", "暂无官网")

    menu.divider(script_meta_menu, "夜幕主要负责")
    menu.readonly(script_meta_menu, "技术支持", "夜幕工作室")
    menu.readonly(script_meta_menu, "夜幕主制作策划：", "Ping")
    menu.divider(script_meta_menu, "夜幕制作支持")
    menu.readonly(script_meta_menu, "夜幕策划管理：", "思庸")
    menu.readonly(script_meta_menu, "夜幕副制作策划：", "呆呆")
    menu.divider(script_meta_menu, "夜幕赞助人员")
zanzhu = menu.list(script_meta_menu,"夜幕赞助人员", {},"Thanks")
    menu.readonly(zanzhu, "Thanks", "白山茶") 
    menu.readonly(zanzhu, "Thanks", "江书晚") 
    menu.readonly(zanzhu, "Thanks", "到洛阳去爬山") 
    menu.readonly(zanzhu, "Thanks", "大白熊") 
    menu.readonly(zanzhu, "Thanks", "空城~旧梦") 
    menu.readonly(zanzhu, "Thanks", "农夫三拳") 
    menu.readonly(zanzhu, "Thanks", "Xzzz") 
    menu.readonly(zanzhu, "Thanks", "今天嗨了吗？") 
    menu.readonly(zanzhu, "Thanks", "graies") 
    menu.readonly(zanzhu, "Thanks", "彭于晏") 
    menu.readonly(zanzhu, "Thanks", "东北散打王") 
    menu.readonly(zanzhu, "Thanks", "L.T团队") 
    menu.readonly(zanzhu, "Thanks", "恶") 
    menu.readonly(zanzhu, "Thanks", "陌然科技") 
    menu.readonly(zanzhu, "Thanks", "媚") 
    menu.readonly(zanzhu, "Thanks", "小久") 
    menu.readonly(zanzhu, "Thanks", "诗雅") 
    menu.readonly(zanzhu, "Thanks", "小板鸭") 
    menu.readonly(zanzhu, "Thanks", "kui920") 
    menu.readonly(zanzhu, "Thanks", "钱多多同志") 
    menu.readonly(zanzhu, "Thanks", "白远") 
    menu.readonly(zanzhu, "Thanks", "--KZboy-SSR--") 
    menu.readonly(zanzhu, "Thanks", "蜻蜓队长") 
    menu.readonly(zanzhu, "Thanks", "未知名人士") 
    menu.readonly(zanzhu, "Thanks", "小安") 
    menu.readonly(zanzhu, "Thanks", "911每天都很想静静")
    menu.readonly(zanzhu, "Thanks", "Boze")  
    menu.readonly(zanzhu, "Thanks", "飞猪")  
    menu.readonly(zanzhu, "Thanks", "JiYanaa")  
    menu.readonly(zanzhu, "Thanks", "哦豁")  
    menu.readonly(zanzhu, "Thanks", "以马内利")  
    menu.readonly(zanzhu, "Thanks", "卢本伟")  
    menu.readonly(zanzhu, "Thanks", "sfasafafasfa")  

end