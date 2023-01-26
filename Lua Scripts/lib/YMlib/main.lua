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
            pluto_default:
                left_eye_id = 5956
                right_eye_id = 6468
        end
        local boneCoord_L = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), left_eye_id))
        local boneCoord_R = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), right_eye_id))
        if ped_model == util.joaat("mp_f_freemode_01") then 
            boneCoord_L.z += 0.02
            boneCoord_R.z += 0.02
        end
        camRot.x += 90
        request_ptfx_asset_lasereyes(dictionary)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
    end
end