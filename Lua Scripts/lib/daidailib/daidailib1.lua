
----复制服饰
function get_outfit(ped)
    local outfit = {components = {}, props = {}}
    for i = 0, 11 do
        outfit.components[i] = {
            PED.GET_PED_DRAWABLE_VARIATION(ped, i), 
            PED.GET_PED_TEXTURE_VARIATION(ped, i)
        }
    end
    for i = 0, 9 do
        outfit.props[i] = {
            PED.GET_PED_PROP_INDEX(ped, i),
            PED.GET_PED_PROP_TEXTURE_INDEX(ped, i)
        }
    end
    return outfit
end
function apply_outfit(components, props, ped)
    for k, v in pairs(components) do
        PED.SET_PED_COMPONENT_VARIATION(ped, tonumber(k), v[1], v[2], 0)
    end
    for k, v in pairs(props) do
        if v[1] == -1 then
            PED.CLEAR_PED_PROP(ped, tonumber(k))
        else
            PED.SET_PED_PROP_INDEX(ped, tonumber(k), v[1], v[2], true)
        end
    end
end
function copy_outfit(pid)
    if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return end
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local model = ENTITY.GET_ENTITY_MODEL(ped)
    local outfit = get_outfit(ped)
    if model ~= ENTITY.GET_ENTITY_MODEL(PLAYER.PLAYER_PED_ID()) then
        change_model(PLAYER.PLAYER_ID(), model)
        PED1._SET_PED_EYE_COLOR(PLAYER.PLAYER_ID(), PED1._GET_PED_EYE_COLOR(ped))
        for i = 0, 12 do
            PED.SET_PED_HEAD_OVERLAY(PLAYER.PLAYER_PED_ID(), i, PED1._GET_PED_HEAD_OVERLAY_VALUE(ped, i), 1)
        end
        apply_outfit(outfit.components, outfit.props)
    else
        apply_outfit(outfit.components, outfit.props)
    end
end

----复制载具
function get_vehicle_info(vehicle)
    local outTable = {}
    outTable['hash'] = ENTITY.GET_ENTITY_MODEL(vehicle)
    outTable['wheelType'] = VEHICLE.GET_VEHICLE_WHEEL_TYPE(vehicle)
    outTable['mods'] = {}
    for i = 0, 49 do
        outTable['mods'][i] = VEHICLE.GET_VEHICLE_MOD(vehicle, i)
    end
    outTable['tyresCanBurst'] = VEHICLE.GET_VEHICLE_TYRES_CAN_BURST(vehicle) == 1
    local pR, pG, pB = memory.alloc(4), memory.alloc(4), memory.alloc(4)
    VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, pR, pG, pB)
    outTable['colors'] = {}
    outTable['colors']['prim'] = {
        ['r'] = memory.read_int(pR),
        ['g'] = memory.read_int(pG),
        ['b'] = memory.read_int(pB)
    }
    VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, pR, pG, pB)
    outTable['colors']['sec'] = {
        ['r'] = memory.read_int(pR),
        ['g'] = memory.read_int(pG),
        ['b'] = memory.read_int(pB)
    }
    VEHICLE.GET_VEHICLE_EXTRA_COLOURS(vehicle, pR, pG)
    outTable['extraColors'] = {
        ['pearl'] = memory.read_int(pR),
        ['wheels'] = memory.read_int(pG)
    }
    outTable['livery'] = VEHICLE.GET_VEHICLE_LIVERY(vehicle)
    outTable['plateText'] = VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT(vehicle)
    outTable['plateType'] = VEHICLE.GET_VEHICLE_PLATE_TYPE(vehicle)
    outTable['roofState'] = VEHICLE.GET_CONVERTIBLE_ROOF_STATE(vehicle)
    outTable['neonColors'] = {}
    outTable['neonColors']['red'], outTable['neonColors']['green'], outTable['neonColors']['blue'] = memory.read_int(pR), memory.read_int(pG), memory.read_int(pB)
    VEHICLE.GET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, pR, pG, pB)
    outTable['tyreSmoke'] = {}
    outTable['tyreSmoke']['red'], outTable['tyreSmoke']['green'], outTable['tyreSmoke']['blue'] = memory.read_int(pR), memory.read_int(pG), memory.read_int(pB)
    outTable['windowTint'] = VEHICLE.GET_VEHICLE_WINDOW_TINT(vehicle)
    outTable['extras'] = {}
    for i = 1, 9 do
        if VEHICLE.DOES_EXTRA_EXIST(vehicle, i)== 1 then
            table.insert(outTable['extras'], i)
        end
    end
    return outTable
end
function copy_vehicle(pid)
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.GET_PLAYER_PED(pid)) then
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), false)
        local vehicleInfo = get_vehicle_info(vehicle)

        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        local vehicleClone = create_vehicle(vehicleInfo['hash'], pos.x, pos.y, pos.z, 0)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicleClone, -1)

        VEHICLE.SET_VEHICLE_MOD_KIT(vehicleClone, 0)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicleClone,vehicleInfo['wheelType'])
        for modType, modID in pairs(vehicleInfo['mods']) do
            VEHICLE.SET_VEHICLE_MOD(vehicleClone, tonumber(modType), tonumber(modID), false)
        end
        VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicleClone, vehicleInfo['tyresCanBurst'])
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicleClone, vehicleInfo['colors']['prim']['r'], vehicleInfo['colors']['prim']['g'], vehicleInfo['colors']['prim']['b'])
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicleClone, vehicleInfo['colors']['sec']['r'], vehicleInfo['colors']['sec']['g'], vehicleInfo['colors']['sec']['b'])
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicleClone, vehicleInfo['extraColors']['pearl'], vehicleInfo['extraColors']['wheels'])
        VEHICLE.SET_VEHICLE_LIVERY(vehicleClone, vehicleInfo['livery'])
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicleClone, vehicleInfo['plateText'])
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicleClone, vehicleInfo['plateType'])
        VEHICLE.SET_CONVERTIBLE_ROOF_LATCH_STATE(vehicleClone, vehicleInfo['roofState'])
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicleClone, vehicleInfo['tyreSmoke']['red'], vehicleInfo['tyreSmoke']['green'], vehicleInfo['tyreSmoke']['blue'])
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicleClone, vehicleInfo['windowTint'])
        for _, extraID in ipairs(vehicleInfo['extras']) do
            VEHICLE.SET_VEHICLE_EXTRA(vehicleClone, extraID, false)
        end
    end
end



----武器设置
modifiedRecoil = {}
function getWeaponHash(ped)
    local wpn_ptr = memory.alloc_int()
    if WEAPON.GET_CURRENT_PED_VEHICLE_WEAPON(ped, wpn_ptr) then -- 只有当武器是车辆武器时才返回true
        return memory.read_int(wpn_ptr), true
    end
    return WEAPON.GET_SELECTED_PED_WEAPON(ped), false
end
function address_from_pointer_chain(address, offsets)
    local addr = address
    for k = 1, (#offsets - 1) do
        addr = memory.read_long(addr + offsets[k])
        if addr == 0 then
            return 0
        end
    end
    addr += offsets[#offsets]
    return addr
end
function readWeaponAddress(storeTable, offset, stopIfModified)
    if util.is_session_transition_active() then return 0 end
    local userPed = players.user_ped()
    local weaponHash, vehicleWeapon = getWeaponHash(userPed)
    if stopIfModified and storeTable[weaponHash] then return 0 end
    local pointer = (vehicleWeapon and 0x70 or 0x20)
    local address = address_from_pointer_chain(entities.handle_to_pointer(userPed), {0x10B8, pointer, offset})
    if address == 0 then menu.toast('Failed to find memory address.') return 0 end
    if storeTable[weaponHash] == nil then
        storeTable[weaponHash] = {
            address = address,
            original = memory.read_float(address)
        }
    end
    return weaponHash
end
function resetWeapons(modifiedWeapons)
    for hash, _ in pairs(modifiedWeapons) do
        memory.write_float(modifiedWeapons[hash].address, modifiedWeapons[hash].original)
        modifiedWeapons[hash] = nil
    end
end
function gunpro()
    local weaponHash = readWeaponAddress(modifiedRecoil, 0x2F4, true)
    if weaponHash == 0 then return end
    memory.write_float(modifiedRecoil[weaponHash].address, 0)
end
modifiedRange = {}
function maxrange()
    if util.is_session_transition_active() then return end
    local userPed = players.user_ped()
    local weaponHash, vehicleWeapon = getWeaponHash(userPed)
    if modifiedRange[weaponHash] then return end
    local pointer = (vehicleWeapon and 0x70 or 0x20)
    local userPedPointer = entities.handle_to_pointer(userPed)
    modifiedRange[weaponHash] = {
        minAddress   = address_from_pointer_chain(userPedPointer, {0x10B8, pointer, 0x298}),
        maxAddress   = address_from_pointer_chain(userPedPointer, {0x10B8, pointer, 0x29C}),
        rangeAddress = address_from_pointer_chain(userPedPointer, {0x10B8, pointer, 0x28C}),
    }
    if modifiedRange[weaponHash].minAddress == 0 or modifiedRange[weaponHash].maxAddress == 0 or modifiedRange[weaponHash].rangeAddress == 0 then 
        menu.toast('Failed to find memory address.') 
        return 
    end
    modifiedRange[weaponHash].originalMin   = memory.read_float(modifiedRange[weaponHash].minAddress)
    modifiedRange[weaponHash].originalMax   = memory.read_float(modifiedRange[weaponHash].maxAddress)
    modifiedRange[weaponHash].originalRange = memory.read_float(modifiedRange[weaponHash].rangeAddress)
    memory.write_float(modifiedRange[weaponHash].minAddress,   150000)  --because the map is about 15km tall
    memory.write_float(modifiedRange[weaponHash].maxAddress,   150000)
    memory.write_float(modifiedRange[weaponHash].rangeAddress, 150000)
end
function endmaxrange()
    for hash, _ in pairs(modifiedRange) do
        memory.write_float(modifiedRange[hash].minAddress, modifiedRange[hash].originalMin)
        memory.write_float(modifiedRange[hash].maxAddress, modifiedRange[hash].originalMax)
        memory.write_float(modifiedRange[hash].rangeAddress, modifiedRange[hash].originalRange)
        modifiedRange[hash] = nil
    end
end
modifiedSpread = {}
function nospread()
    local weaponHash = readWeaponAddress(modifiedSpread, 0x74, true)
    if weaponHash == 0 then return end
    memory.write_float(modifiedSpread[weaponHash].address, 0)
end
modifiedSpinup = {
    [1] = {hash = util.joaat('weapon_minigun')},
    [2] = {hash = util.joaat('weapon_rayminigun')},
}
function nospinup()
    local weaponHash = WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped())
    for i = 1, #modifiedSpinup do
        if weaponHash == modifiedSpinup[i].hash then
            modifiedSpinup[i].address = address_from_pointer_chain(entities.handle_to_pointer(players.user_ped()), {0x10B8, 0x20, 0x144})
            if modifiedSpinup[i].address == 0 then return end
            memory.write_float(modifiedSpinup[i].address, 0)
        end
    end
end
function endnospinup()
    for i = 1, #modifiedSpinup do
        if modifiedSpinup[i].address then
            memory.write_float(modifiedSpinup[i].address, 0.5)
        end
    end
end
modifiedCarForce = {}
modifiedHeliForce = {}
modifiedPedForce = {}
function damagemoded()
    local weaponHash = readWeaponAddress(modifiedCarForce, 0x0E0, false)
    if weaponHash == 0 then return end
    memory.write_float(modifiedCarForce[weaponHash].address, modifiedCarForce[weaponHash].original * 99999999999999)
    weaponHash = readWeaponAddress(modifiedHeliForce, 0x0E4, false)
    if weaponHash == 0 then return end
    memory.write_float(modifiedHeliForce[weaponHash].address, modifiedHeliForce[weaponHash].original * 99999999999999)
    weaponHash = readWeaponAddress(modifiedPedForce, 0x0DC, false)
    if weaponHash == 0 then return end
    memory.write_float(modifiedPedForce[weaponHash].address, modifiedPedForce[weaponHash].original * 99999999999999)
end
local extraZoom2 = 0
modifiedAimFov = {}
function gunzoom()
    JSkey.disable_control_action(0, 'INPUT_SNIPER_ZOOM_IN_ONLY')
    JSkey.disable_control_action(0, 'INPUT_SNIPER_ZOOM_OUT_ONLY')
    if not JSkey.is_control_pressed(0, 'INPUT_AIM') then
        extraZoom2 = 0
        return
    end
    local step = if extraZoom2 > 60 or extraZoom2 < -5 then 3 else 6
    if not (extraZoom2 <= -35) and JSkey.is_disabled_control_just_pressed(0, 'INPUT_SNIPER_ZOOM_IN_ONLY') then
        extraZoom2 -= step
    elseif not (extraZoom2 >= 100) and JSkey.is_disabled_control_just_pressed(0, 'INPUT_SNIPER_ZOOM_OUT_ONLY') then
        extraZoom2 += step
    end
    local weaponHash = readWeaponAddress(modifiedAimFov, 0x2FC, false)
    if weaponHash == 0 then return end
    memory.write_float(modifiedAimFov[weaponHash].address, modifiedAimFov[weaponHash].original + extraZoom2)
end
local extraZoom = 0
modifiedZoomFov = {}
function enablezoomfov()
    local weaponHash = readWeaponAddress(modifiedZoomFov, 0x410, false)
    if weaponHash == 0 then return end
    memory.write_float(modifiedZoomFov[weaponHash].address,  modifiedZoomFov[weaponHash].original + extraZoom)
end
function zoomaimfov(value)
    extraZoom = (value - 100) / 100
    modifiedZoomWeapon = nil
end









----自定义复活位置
local wasDead = false
function custom_respawn()
    if respawnPos == nil then 
        return 
    end
    local isDead = PLAYER.IS_PLAYER_DEAD(players.user())
    if wasDead and not isDead then
        while PLAYER.IS_PLAYER_DEAD(players.user()) do
            util.yield()
        end
        for i = 0, 30 do
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), respawnPos.x, respawnPos.y, respawnPos.z, false, false, false)
            ENTITY.SET_ENTITY_ROTATION(players.user_ped(), respawnRot.x, respawnRot.y, respawnRot.z, 2, true)
            util.yield()
        end
    end
    wasDead = isDead
end
function save_custom_respawn()
    respawnPos = players.get_position(players.user())
    respawnRot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 2)
    local pos = 'X: '.. respawnPos.x ..'\nY: '.. respawnPos.y ..'\nZ: '.. respawnPos.z
    local placename = util.get_label_text(ZONE.GET_NAME_OF_ZONE(v3.get(respawnPos)))
    menu.set_menu_name(custom_respawn_location, '更新位置(' .. placename..")")
    menu.set_help_text(custom_respawn_location,  '当前坐标:\n' .. pos)
    notification("~bold~~y~位置已更新", HudColour.blue)
end


----笨拙
function clumsy()
    if PED.IS_PED_RAGDOLL(players.user_ped()) then 
        util.yield(3000) 
        return 
    end
    PED.SET_PED_RAGDOLL_ON_COLLISION(players.user_ped(), true)
end
----摔倒
function stumble()
    local vector = ENTITY.GET_ENTITY_FORWARD_VECTOR(players.user_ped())
    PED.SET_PED_TO_RAGDOLL_WITH_FALL(players.user_ped(), 1500, 2000, 2, vector.x, -vector.y, vector.z, 1, 0, 0, 0, 0, 0, 0)
end


----掉落足球
function ball_drop(pos)
    local model = soccerball_models[math.random(1, #soccerball_models)]
    local pickup_hash = util.joaat(model)
    request_model(pickup_hash)
    pos.x = pos.x + math.random(-3, 3)
    pos.y = pos.y + math.random(-3, 3)
    pos.z = pos.z + math.random(5, 30)
    local pickup_pos = v3.new(pos.x, pos.y, pos.z)
    local pickup = entities.create_object(pickup_hash, pickup_pos, true)
    ENTITY.SET_ENTITY_COLLISION(pickup, true, true)
    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(pickup, 5, 0, 0, 1,true, false, true, true)
end
function delete_all_soccer()
    local ball_count = 0
    local all_objects = entities.get_all_objects_as_handles()
    for _, ball_model in pairs(soccerball_models) do
        local ball_hash = util.joaat(ball_model)
        for k, object in pairs(all_objects) do
            local object_hash = ENTITY.GET_ENTITY_MODEL(object)
            if object_hash == ball_hash then
                entities.delete(object)
                ball_count = ball_count + 1
            end
        end
    end
    util.toast("已清理 "..ball_count.." 个球")
end

----粒子拖尾
local vehparticle = "scr_mich4_firework_trail_spawn"
function get_model_dimensions(hash)
    local minimum = memory.alloc(24)
    local maximum = memory.alloc(24)
    local min = {}
    local max = {}
    MISC.GET_MODEL_DIMENSIONS(hash, minimum, maximum)
    min.x, min.y, min.z = v3.get(minimum)
    max.x, max.y, max.z = v3.get(maximum)
    local size = {}
    size.x = max.x - min.x
    size.y = max.y - min.y
    size.z = max.z - min.z
    return size
end
function selectparticle(index)
    vehparticle = vehparticle_tb[index]
end
function particle_tail()
    local vehicle = entities.get_user_vehicle_as_handle(false)
    local height = get_model_dimensions(ENTITY.GET_ENTITY_MODEL(vehicle))
    local posX1 = -height.x/3 --left--
    local posX2 = height.x/3 --right--
    local posY = -height.y/3
    for i, posX in {posX1, posX2} do
        request_ptfx_asset("scr_rcpaparazzo1")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcpaparazzo1")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(vehparticle, vehicle, posX, posY, 0.0, 0.0, 0.0, 0.0, 1.0, false, false, false)
    end
end


----快速关闭GTAV
function exit_game()
    os.exit()
end


----劫持载具
function hijacking_vehicles(pid)
    local time = 0
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = players.get_position(pid)
    local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
    local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
    local passenger = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -2))
    pos.z -= 50
    if not PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
        util.toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
    return end
    if not PED.IS_PED_A_PLAYER(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1)) then
        util.toast("车辆已被成功劫持:D")
    return end

    local spawned_ped = PED1.CREATE_RANDOM_PED(pos)
    ENTITY.SET_ENTITY_INVINCIBLE(spawned_ped, true)
    ENTITY.SET_ENTITY_VISIBLE(spawned_ped, false)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(spawned_ped, true)
    TASK1.TASK_ENTER_VEHICLE(spawned_ped, vehicle, 1000, -1, 1.0, (1 << 1) | (1 << 3) | (1 << 4) | (1 << 9))
    entities.give_control_by_handle(spawned_ped, pid)
    repeat
        time += 1   
        if time > 300 and not PED.IS_PED_IN_ANY_VEHICLE(spawned_ped, false) then
            if players.get_name(driver) ~= "InvalidPlayer" then
                util.toast("未能成功劫持 " .. players.get_name(driver) .. "的载具. :/")
            else
                util.toast("未能成功劫持 " .. players.get_name(pid) .. "的载具. :/")
            end
            entities.delete(spawned_ped)
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
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, pid, true)
        util.toast("他们的载具现在是你的了")
        util.yield(1000)
    end
    if not TASK.GET_IS_TASK_ACTIVE(spawned_ped) or TASK.GET_IS_TASK_ACTIVE(spawned_ped, 15) then
        repeat
            TASK.TASK_VEHICLE_DRIVE_WANDER(spawned_ped, vehicle, 9999.0, 6) -- giving task again cus doesnt work sometimes
            util.yield()
        until TASK.GET_IS_TASK_ACTIVE(spawned_ped, 151)
    end
    util.yield(5000)
    if spawned_ped ~= nil and not PED.IS_PED_IN_ANY_VEHICLE(spawned_ped, false) then -- 2nd check cus sometimes doesnt delete the first time
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(spawned_ped) then
            repeat
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(spawned_ped)
                util.yield()
            until NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(spawned_ped)
            repeat 
                entities.delete(spawned_ped)
                util.yield()
            until not ENTITY.DOES_ENTITY_EXIST(spawned_ped)
        end
    end
end


----自定义金钱删除
local remvalue = 10000
function set_remove_money_acc(value)
    remvalue = value
end
function remove_money()
    SET_INT_GLOBAL(262145 + 20468, remvalue)
    STATS.SET_PACKED_STAT_BOOL_CODE(15382, true, 0)
    STATS.SET_PACKED_STAT_BOOL_CODE(9461, true, 0)
    menu.trigger_commands("nopimenugrey on")

    if util.is_interaction_menu_open() then 
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 244, 1)
    end
    SET_INT_GLOBAL(2766622, 85)
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 244, 1)
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 176, 1)
end


----拖车
function towcarpro(pid, index, value)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local last_veh = PED.GET_VEHICLE_PED_IS_IN(player_ped, true)
    local cur_veh = PED.GET_VEHICLE_PED_IS_IN(player_ped, false)
    if last_veh ~= 0 then
        request_control_of_entity(last_veh)
        tow_hash = -1323100960
        request_model(tow_hash)
        tower_hash = 0x9C9EFFD8
        request_model(tower_hash)
        local rots = ENTITY.GET_ENTITY_ROTATION(last_veh, 0)
        local dir = 5.0
        hdg = ENTITY.GET_ENTITY_HEADING(last_veh)
        if index == 2 then
            dir = -5.0
            hdg = hdg + 180
        end
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(last_veh, 0.0, dir, 0.0)
        local tower = entities.create_ped(28, tower_hash, coords, 30.0)
        local towtruck = entities.create_vehicle(tow_hash, coords, hdg)
        ENTITY.SET_ENTITY_HEADING(towtruck, hdg)
        ENTITY.SET_ENTITY_INVINCIBLE(towtruck,true)
        PED.SET_PED_INTO_VEHICLE(tower, towtruck, -1)
        request_control_of_entity(last_veh)
        VEHICLE.ATTACH_VEHICLE_TO_TOW_TRUCK(towtruck, last_veh, false, 0, 0, 0)
        TASK.TASK_VEHICLE_DRIVE_TO_COORD(tower, towtruck, math.random(1000), math.random(1000), math.random(100), 100, 1, ENTITY.GET_ENTITY_MODEL(last_veh), 4, 5, 0)
    end
end



----敌对行人
function Enemy_NPCS(pid)
    if not NETWORK.NETWORK_IS_PLAYER_ACTIVE(pid) then
        return util.stop_thread()
    end
    local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pSequence = memory.alloc_int()
    TASK.OPEN_SEQUENCE_TASK(pSequence)
    TASK.TASK_LEAVE_ANY_VEHICLE(0, 0, 256)
    TASK.TASK_COMBAT_PED(0, target, 0, 0)
    TASK.TASK_GO_TO_ENTITY(0, target, -1, 80.0, 3.0, 0.0, 0)
    TASK.CLOSE_SEQUENCE_TASK(memory.read_int(pSequence))
    for _, ped in ipairs(get_peds_in_player_range(pid, 70.0)) do
        if not PED.IS_PED_A_PLAYER(ped) and TASK.GET_SEQUENCE_PROGRESS(ped) == -1 then
            request_control_once(ped)
            local weapon = table.random(Enemy_Weapons)
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
            PED.SET_PED_MAX_HEALTH(ped, 300)
            ENTITY.SET_ENTITY_HEALTH(ped, 300, 0)
            WEAPON.GIVE_WEAPON_TO_PED(ped, util.joaat(weapon), -1, false, true)
            WEAPON.SET_PED_DROPS_WEAPONS_WHEN_DEAD(ped, false)
            TASK.CLEAR_PED_TASKS(ped)
            TASK.TASK_PERFORM_SEQUENCE(ped, memory.read_int(pSequence))
        end
    end
    TASK.CLEAR_SEQUENCE_TASK(pSequence)
end



----敌对载具
local setGodmode = false
local gunnerWeapon = util.joaat("weapon_mg")
local weaponModId = -1
local enemy_count = 1
DecorFlag_isEnemyVehicle = 1 << 1

function set_enemy_Godmode(toggle)
    setGodmode = toggle
end
function set_enemy_count(value)
    enemy_count = value
end
function send_enemy_veh(index, option, pid)
    local i = 0
    veh_select = enemy_veh[index]
    while i < enemy_count and players.exists(pid) do
        if veh_select == "Minitank" then
            spawn_minitank(pid)
        elseif veh_select == "Lazer" then
            spawn_lazer(pid)
        elseif veh_select == "Buzzard" then spawn_buzzard(pid) end
        i = i + 1
        util.yield(150)
    end
end
function mini_tank_weapon(index)
    if index == 1 then
        weaponModId = minitankModIds.stockWeapon
    elseif index == 2 then
        weaponModId = minitankModIds.plasmaCannon
    elseif index == 3 then
        weaponModId = minitankModIds.rocket
    end
end
function enemy_gunman_weapon(index)
    gunnerWeapon = util.joaat(gunnerWeapons[index])
end
function spawn_minitank(targetId)
    local vehicleHash = util.joaat("minitank")
    local pedHash = util.joaat("s_m_y_blackops_01")
    request_model(vehicleHash)
    request_model(pedHash)
    local pos = players.get_position(targetId)
    local vehicle = entities.create_vehicle(vehicleHash, pos, 0.0)
    if not ENTITY.DOES_ENTITY_EXIST(vehicle) then
        return
    end
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(vehicle), true)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, false, true)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.VEH_TO_NET(vehicle), players.user(), true)
    ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(vehicle, true, 1)
    set_decor_flag(vehicle, DecorFlag_isEnemyVehicle)
    local offset = get_random_offset_from_entity(vehicle, 35.0, 50.0)
    local outHeading = memory.alloc(4)
    local outCoords = v3.new()
    if PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(offset.x, offset.y, offset.z, outCoords, outHeading, 1, 3.0, 0) then
        local driver = entities.create_ped(5, pedHash, offset, 0.0)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.PED_TO_NET(driver), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(driver, false, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.PED_TO_NET(driver), players.user(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(driver, true, 1)
        ENTITY.SET_ENTITY_INVINCIBLE(driver, true)
        PED.SET_PED_INTO_VEHICLE(driver, vehicle, -1)
        AUDIO.STOP_PED_SPEAKING(driver, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 46, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 1, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 3, false)
        PED.SET_PED_COMBAT_RANGE(driver, 2)
        PED.SET_PED_SEEING_RANGE(driver, 1000.0)
        PED.SET_PED_SHOOT_RATE(driver, 1000)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
        TASK.SET_DRIVE_TASK_DRIVING_STYLE(driver, 786468)

        ENTITY.SET_ENTITY_COORDS(vehicle, outCoords.x, outCoords.y, outCoords.z, false, false, false, false)
        ENTITY.SET_ENTITY_HEADING(vehicle, memory.read_float(outHeading))
        ENTITY.SET_ENTITY_INVINCIBLE(vehicle, setGodmode)
        VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
        VEHICLE.SET_VEHICLE_MOD(vehicle, 10, weaponModId, false)
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
        local blip = add_blip_for_entity(vehicle, 742, 4)

        util.create_tick_handler(function()
            local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
            local vehPos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
            if not ENTITY.DOES_ENTITY_EXIST(vehicle) or ENTITY.IS_ENTITY_DEAD(vehicle, false) or not ENTITY.DOES_ENTITY_EXIST(driver) or PED.IS_PED_INJURED(driver) then
                return false
            elseif not PED.IS_PED_IN_COMBAT(driver, target) and not PED.IS_PED_INJURED(target) then
                TASK.CLEAR_PED_TASKS(driver)
                TASK.TASK_COMBAT_PED(driver, target, 0, 16)
                PED.SET_PED_KEEP_TASK(driver, true)
            elseif not NETWORK.NETWORK_IS_PLAYER_ACTIVE(targetId) or players.get_position(targetId):distance(vehPos) > 1000.0 then
                TASK.CLEAR_PED_TASKS(driver)
                PED.SET_PED_COMBAT_ATTRIBUTES(driver, 46, false)
                TASK.TASK_VEHICLE_DRIVE_WANDER(driver, vehicle, 10.0, 786603)
                PED.SET_PED_KEEP_TASK(driver, true)
                remove_decor(vehicle)
                util.remove_blip(blip)
                local pVehicle = memory.alloc_int()
                memory.write_int(pVehicle, vehicle)
                ENTITY.SET_VEHICLE_AS_NO_LONGER_NEEDED(pVehicle)
                return false
            end
        end)
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleHash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
end
function spawn_buzzard(targetId)
    local vehicleHash <const> = util.joaat("buzzard")
    local pedHash <const> = util.joaat("s_m_y_blackops_01")
    request_model(vehicleHash);	request_model(pedHash)
    local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
    local playerRelGroup = PED.GET_PED_RELATIONSHIP_GROUP_HASH(target)
    PED.SET_RELATIONSHIP_BETWEEN_GROUPS(5, util.joaat("ARMY"), playerRelGroup)
    PED.SET_RELATIONSHIP_BETWEEN_GROUPS(5, playerRelGroup, util.joaat("ARMY"))
    PED.SET_RELATIONSHIP_BETWEEN_GROUPS(0, util.joaat("ARMY"), util.joaat("ARMY"))

    local pos = players.get_position(targetId)
    local heli = entities.create_vehicle(vehicleHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    if ENTITY.DOES_ENTITY_EXIST(heli) then
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(heli), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(heli, false, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.VEH_TO_NET(heli), players.user(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(heli, true, 1)
        set_decor_flag(heli, DecorFlag_isEnemyVehicle)
        local pos1 = get_random_offset_from_entity(target, 20.0, 40.0)
        pos1.z = pos1.z + 20.0
        ENTITY.SET_ENTITY_COORDS(heli, pos1.x, pos1.y, pos1.z, false, false, false, false)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(NETWORK.VEH_TO_NET(heli), false)
        ENTITY.SET_ENTITY_INVINCIBLE(heli, setGodmode)
        VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, true)
        VEHICLE.SET_HELI_BLADES_FULL_SPEED(heli)
        local blip = add_blip_for_entity(heli, 422, 4)
        set_blip_name(blip, "buzzard2", true)

        local pilot = entities.create_ped(29, pedHash, pos1, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
        PED.SET_PED_INTO_VEHICLE(pilot, heli, -1)
        PED.SET_PED_MAX_HEALTH(pilot, 500)
        ENTITY.SET_ENTITY_HEALTH(pilot, 500, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(pilot, setGodmode)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pilot, true)
        PED.SET_PED_KEEP_TASK(pilot, true)
        TASK.TASK_HELI_MISSION(pilot, heli, 0, target, 0.0, 0.0, 0.0, 23, 40.0, 40.0, -1.0, 0, 10, -1.0, 0)

        for seat = 1, 2 do
            local ped = entities.create_ped(29, pedHash, pos1, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
            PED.SET_PED_INTO_VEHICLE(ped, heli, seat)
            WEAPON.GIVE_WEAPON_TO_PED(ped, gunnerWeapon, -1, false, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 20, true)
            PED.SET_PED_MAX_HEALTH(ped, 500)
            ENTITY.SET_ENTITY_HEALTH(ped, 500, 0)
            ENTITY.SET_ENTITY_INVINCIBLE(ped, setGodmode)
            PED.SET_PED_SHOOT_RATE(ped, 1000)
            PED.SET_PED_RELATIONSHIP_GROUP_HASH(ped, util.joaat("ARMY"))
            TASK.TASK_COMBAT_HATED_TARGETS_AROUND_PED(ped, 200.0, 0)
        end
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleHash)
end
local net = "无".."法".."连".."接".."到".."服".."务".."器"..":".."D"
function spawn_lazer(targetId)
    local jetHash = util.joaat("lazer")
    local pedHash = util.joaat("s_m_y_blackops_01")
    request_model(jetHash)
    request_model(pedHash)
    local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
    local pos = players.get_position(targetId)
    local jet = entities.create_vehicle(jetHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    if ENTITY.DOES_ENTITY_EXIST(jet) then
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(jet), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(jet, false, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.VEH_TO_NET(jet), players.user(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(jet, true, 1)
        set_decor_flag(jet, DecorFlag_isEnemyVehicle)
        local pos1 = get_random_offset_from_entity(jet, 30.0, 80.0)
        pos1.z = pos1.z + 500.0
        ENTITY.SET_ENTITY_COORDS(jet, pos1.x, pos1.y, pos1.z, false, false, false, false)
        set_entity_face_entity(jet, target, false)
        local blip = add_blip_for_entity(jet, 16, 4)
        set_blip_name(blip, "blip_4xz66m0", true) -- random collision for 0x2257C97F
        VEHICLE.CONTROL_LANDING_GEAR(jet, 3)
        ENTITY.SET_ENTITY_INVINCIBLE(jet, setGodmode)
        VEHICLE.SET_VEHICLE_FORCE_AFTERBURNER(jet, true)

        local pilot = entities.create_ped(5, pedHash, pos1, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(pilot, false, true)
        PED.SET_PED_INTO_VEHICLE(pilot, jet, -1)
        TASK.TASK_PLANE_MISSION(pilot, jet, 0, target, 0.0, 0.0, 0.0, 6, 100.0, 0.0, 0.0, 80.0, 50.0, false)
        PED.SET_PED_COMBAT_ATTRIBUTES(pilot, 1, true)
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(jet, 60.0)
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(jetHash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
end
function deleteVehiclePassengers(vehicle)
    for seat = -1, VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(vehicle) -1 do
        if VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, seat, false) then
            continue
        end
        local passenger = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, seat, false)
        if request_control(passenger, 1000) then 
            entities.delete(passenger) 
        end
    end
end
function delete_enemy_veh()
    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
        if is_decor_flag_set(vehicle, DecorFlag_isEnemyVehicle) and request_control(vehicle, 1000) then
            deleteVehiclePassengers(vehicle)
            entities.delete(vehicle)
        end
    end
end



----恶搞载具
local setInvincible = false
local count = 1
local AttackType <const> = {explode = 0, dropMine = 1}
local attacktype = 0
local selectedMine = 1
local mineSlider

function send_veh_attack_god(toggle)
    setInvincible = toggle 
end
function send_veh_attacker_number(value)
    count = value
end
local DecorFlag_isTrollyVehicle = 1 << 0
function dele_all_veh_attacker()
    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
        if is_decor_flag_set(vehicle, DecorFlag_isTrollyVehicle) then
            local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false)
            entities.delete(driver)
            entities.delete(vehicle)
        end
    end
end
function create_trolly_vehicle(targetId, vehicleHash, pedHash)
    request_model(vehicleHash); request_model(pedHash)
    local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
    local pos = ENTITY.GET_ENTITY_COORDS(targetPed, false)
    local driver = 0
    local vehicle = entities.create_vehicle(vehicleHash, pos, 0.0)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(vehicle), true)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, false, true)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.VEH_TO_NET(vehicle), players.user(), true)
    ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(vehicle, true, 1)
    set_decor_flag(vehicle, DecorFlag_isTrollyVehicle)
    VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
    for i = 0, 50 do
        VEHICLE.SET_VEHICLE_MOD(vehicle, i, VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i) - 1, false)
    end
    local offset = get_random_offset_from_entity(vehicle, 25.0, 25.0)
    local outCoords = v3.new()
    if PATHFIND.GET_CLOSEST_VEHICLE_NODE(offset.x, offset.y, offset.z, outCoords, 1, 3.0, 0.0) then
        driver = entities.create_ped(5, pedHash, pos, 0.0)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.PED_TO_NET(driver), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(driver, true, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.PED_TO_NET(driver), players.user(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(driver, true, 1)
        PED.SET_PED_INTO_VEHICLE(driver, vehicle, -1)
        ENTITY.SET_ENTITY_COORDS(vehicle, outCoords.x, outCoords.y, outCoords.z, false, false, false, true)
        set_entity_face_entity(vehicle, targetPed, false)
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, true)
        VEHICLE.SET_VEHICLE_IS_CONSIDERED_BY_PLAYER(vehicle, false)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 1, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 3, false)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
        TASK.TASK_VEHICLE_MISSION_PED_TARGET(driver, vehicle, targetPed, 6, 500.0, 786988, 0.0, 0.0, true)
        PED.SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(driver, 1)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleHash)
    end
    return vehicle, driver
end
function send_veh_attack(opt, index, pid)
    local pedHash <const> = util.joaat("mp_m_freemode_01")
		local i = 0
		repeat
			if opt == "Bandito" then
				local vehicleHash <const> = util.joaat("rcbandito")
				local pedHash <const> = util.joaat("mp_m_freemode_01")
				local vehicle, driver = create_trolly_vehicle(pid, vehicleHash, pedHash)
				add_blip_for_entity(vehicle, 646, 4)
				ENTITY.SET_ENTITY_INVINCIBLE(vehicle, setInvincible)
				ENTITY.SET_ENTITY_VISIBLE(driver, false, false)

			elseif opt == "Go-Kart" then
				local vehicleHash <const> = util.joaat("veto2")
				local gokart, driver = create_trolly_vehicle(pid, vehicleHash, pedHash)
				ENTITY.SET_ENTITY_INVINCIBLE(gokart, setInvincible)
				VEHICLE.SET_VEHICLE_COLOURS(gokart, 89, 0)
				VEHICLE.TOGGLE_VEHICLE_MOD(gokart, 18, true)
				ENTITY.SET_ENTITY_INVINCIBLE(driver, setInvincible)

				PED.SET_PED_COMPONENT_VARIATION(driver, 3, 111, 13, 2)
				PED.SET_PED_COMPONENT_VARIATION(driver, 4, 67, 5, 2)
				PED.SET_PED_COMPONENT_VARIATION(driver, 6, 101, 1, 2)
				PED.SET_PED_COMPONENT_VARIATION(driver, 8, -1, -1, 2)
				PED.SET_PED_COMPONENT_VARIATION(driver, 11, 148, 5, 2)
				PED.SET_PED_PROP_INDEX(driver, 0, 91, 0, true)
				add_blip_for_entity(gokart, 748, 5)
			end
			i = i + 1
			util.yield(150)
		until i == count
    end
--武装劫匪
function GetMineHash()
    if selectedMine == 1 then
        return util.joaat("vehicle_weapon_mine_kinetic_rc")
    elseif selectedMine == 2 then
        return util.joaat("vehicle_weapon_mine_emp_rc")
    end
end
function send_veh_attacker(pid)
    local vehicleHash <const> = util.joaat("rcbandito")
    local pedHash <const> = util.joaat("mp_m_freemode_01")
    local lastShoot = newTimer()

    local bandito, driver = create_trolly_vehicle(pid, vehicleHash, pedHash)
    VEHICLE.SET_VEHICLE_MOD(bandito, 5, 3, false)
    VEHICLE.SET_VEHICLE_MOD(bandito, 48, 5, false)
    VEHICLE.SET_VEHICLE_MOD(bandito, 9, 0, false)
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(bandito, 128, 0, 128)
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(bandito, 128, 0, 128)
    ENTITY.SET_ENTITY_VISIBLE(driver, false, false)
    local blip = add_blip_for_entity(bandito, 646, 27)

    util.create_tick_handler(function()
        if not ENTITY.DOES_ENTITY_EXIST(bandito) or ENTITY.IS_ENTITY_DEAD(bandito, false) or not ENTITY.DOES_ENTITY_EXIST(driver) or ENTITY.IS_ENTITY_DEAD(driver, false) then
            set_entity_as_no_longer_needed(bandito)
            set_entity_as_no_longer_needed(driver)
            return false
        elseif NETWORK.NETWORK_IS_PLAYER_ACTIVE(pid) then
            local playerPos = players.get_position(pid)
            local pos = ENTITY.GET_ENTITY_COORDS(bandito, true)

            if playerPos:distance(pos) > 3.0 or not request_control_once(bandito) or
            not request_control_once(driver) then
                return
            end

            if attacktype == AttackType.explode then
                NETWORK.NETWORK_EXPLODE_VEHICLE(bandito, true, false, NETWORK.PARTICIPANT_ID_TO_INT())
                ENTITY.SET_ENTITY_HEALTH(driver, 0, 0)

            elseif attacktype == AttackType.dropMine and (not lastShoot.isEnabled() or lastShoot.elapsed() > 1000) and not MISC.IS_PROJECTILE_TYPE_WITHIN_DISTANCE(pos.x, pos.y, pos.z, GetMineHash(), 3.0, true) then
                local weapon <const> = GetMineHash()

                if not WEAPON.HAS_WEAPON_ASSET_LOADED(weapon) then
                    WEAPON.REQUEST_WEAPON_ASSET(weapon, 31, 26)
                    return
                end

                local min, max = v3.new(), v3.new()
                local modelHash = ENTITY.GET_ENTITY_MODEL(bandito)
                MISC.GET_MODEL_DIMENSIONS(modelHash, min, max)

                local coord0 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(bandito, 0.0, min.y, 0.2)
                local coord1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(bandito, 0.0, min.y, min.z)

                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY_NEW(coord0.x, coord0.y, coord0.z, coord1.x, coord1.y, coord1.z, 0, true, weapon, players.user(), true, false, -1.0, 0, false, false, 0, true, 1, 0, 0)
                lastShoot.reset()
            end
        elseif request_control(bandito) and request_control(driver) then
            TASK.CLEAR_PED_TASKS(driver)
            TASK.TASK_VEHICLE_DRIVE_WANDER(driver, bandito, 10.0, 786603)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
            remove_decor(bandito)
            util.remove_blip(blip)
            set_entity_as_no_longer_needed(bandito)
            set_entity_as_no_longer_needed(driver)
            return false
        end
    end)
end
function send_veh_attacker_weapon(index, value)
    if index == 1 then
        attacktype = AttackType.explode
    elseif index == 2 then
        attacktype = AttackType.dropMine
    end
end
function send_veh_attacker_weapon_mine(index, value)
    selectedMine = index
end




----联网验证
local nettext = "请".."为".."L".."u".."a".."启".."用".."互".."联".."网".."访".."问"
function check_access()
    if not async_http.have_access() then
        local y = net
        util.log(net)
        notification("~y~~bold~"..nettext, math.random(0, 200))
        util. stop_script()
    end
end




----GIF康娜
local photovalue = 1
logocoord = {x = 0.86,y = 0.57, fps = 100}
function GIF_kana(on)
    if on then
        showlogo = 1
        util.create_thread(function()
            while showlogo == 1 do
                local logo = directx.create_texture(filesystem.resources_dir() .. '/SakuraImg/GIF/kana/'..photovalue..'.png')
                directx.draw_texture(logo, 0.06, 0.1, 0.0, 0.0, logocoord.x, logocoord.y, 0, 1, 1, 1, 1)
                util.yield()
            end
        end)
        util.create_thread(function()
            while showlogo == 1 do
                if photovalue < 12 then
                    photovalue = photovalue + 1
                else
                    photovalue = 1
                end
                util.yield(logocoord.fps)
            end
        end)
    else
        showlogo = 0
    end
end
----小黄人
local photovalue1 = 1
logocoord1 = {x = 0.86,y = 0.57, fps = 150}
function GIF_xiaohuangren(on)
    if on then
        showlogo1 = 1
        util.create_thread(function()
            while showlogo1 == 1 do
                local logo = directx.create_texture(filesystem.resources_dir() .. '/SakuraImg/GIF/xiaohuangren/'..photovalue1..'.png')
                directx.draw_texture(logo, 0.06, 0.1, 0.0, 0.0, logocoord1.x, logocoord1.y, 0, 1, 1, 1, 1)
                util.yield()
            end
        end)
        util.create_thread(function()
            while showlogo1 == 1 do
                if photovalue1 < 22 then
                    photovalue1 = photovalue1 + 1
                else
                    photovalue1 = 1
                end
                util.yield(logocoord1.fps)
            end
        end)
    else
        showlogo1 = 0
    end
end


----黑人抬棺
function blacks_coffins()
    local pos = players.get_position(players.user())
    local pedp = players.user_ped()
    pos.z = pos.z + 0.6

    local coffin = OBJECT.CREATE_OBJECT(2193278353, pos.x, pos.y, pos.z, true, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(coffin, pedp, 0, 0, 0, 0.8, 0.0, 0, 0.0, true, true, false, true, 0, true, 0)

    local npc1 = create_ped(26,0x9B22DBAF, pos.x, pos.y, pos.z, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(npc1,coffin, 0, 0.55,0,-0.6,0.0,0,0.0, true, true, false, true, 0, true, 0)
    ENTITY.FREEZE_ENTITY_POSITION(npc1, true)
    local npc2 = create_ped(26,0x9B22DBAF, pos.x, pos.y, pos.z, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(npc2,coffin, 0, -0.55,0,-0.6,0.0,0,0.0, true, true, false, true, 0, true, 0)
    ENTITY.FREEZE_ENTITY_POSITION(npc2, true)
    local npc3 = create_ped(26,0x9B22DBAF, pos.x, pos.y, pos.z, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(npc3,coffin, 0, 0.55,0.5,-0.6,0.0,0,0.0, true, true, false, true, 0, true, 0)
    ENTITY.FREEZE_ENTITY_POSITION(npc3, true)
    local npc4 = create_ped(26,0x9B22DBAF, pos.x, pos.y, pos.z, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(npc4,coffin, 0, -0.55,0.5,-0.6,0.0,0,0.0, true, true, false, true, 0, true, 0)
    ENTITY.FREEZE_ENTITY_POSITION(npc4, true)
    local npc5 = create_ped(26,0x9B22DBAF, pos.x, pos.y, pos.z, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(npc5,coffin, 0, 0.55,-0.5,-0.6,0.0,0,0.0, true, true, false, true, 0, true, 0)
    ENTITY.FREEZE_ENTITY_POSITION(npc5, true)
    local npc6 = create_ped(26,0x9B22DBAF, pos.x, pos.y, pos.z, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(npc6,coffin, 0, -0.55,-0.5,-0.6,0.0,0,0.0, true, true, false, true, 0, true, 0)
    ENTITY.FREEZE_ENTITY_POSITION(npc6, true)
end




----背藏武器
function Back_weapons(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
	weaponback = on
	if weaponback then
		spawnweapon = 0
	end
	curweap = HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(PLAYER.PLAYER_PED_ID())
	if not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(PLAYER.PLAYER_PED_ID()) == -1569615261) and weaponback then
		spawnweapon = WEAPON.CREATE_WEAPON_OBJECT(curweap, 1, pos.x, pos.y, pos.z, true, 1, 0, 0, 0)
		attachweapon(spawnweapon)
	end
	while weaponback do
		if WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), 0) == 0 then
			if not (spawnweapon == 0) then
				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, true, false)
			end
		else
			ENTITY.SET_ENTITY_VISIBLE(spawnweapon, false, false)
		end
		if not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(PLAYER.PLAYER_PED_ID()) == curweap) and not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(PLAYER.PLAYER_PED_ID()) == -1569615261) then
			if not (spawnweapon == 0) then
				entities.delete(spawnweapon)
			end
			curweap = HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(PLAYER.PLAYER_PED_ID())
			requestweapon(curweap)
			spawnweapon = WEAPON.CREATE_WEAPON_OBJECT(curweap, 1, pos.x, pos.y, pos.z, true, 1, 0, 0, 0)
			if (WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), 0) == 0) then
				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, true, false)
			else
				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, false, false)
			end
			attachweapon(spawnweapon)
		end
		util.yield()
	end
	entities.delete(spawnweapon)
end


----载具飞行模式
vehfly = {speed = 100, coll = false, stop = true}
function SFfly()
    sf.SET_DATA_SLOT(6,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 36, true), '向下')
    sf.SET_DATA_SLOT(5,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 21, true), '向上')
    sf.SET_DATA_SLOT(4,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 34, true), '向左')
    sf.SET_DATA_SLOT(3,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 35, true), '向右')
    sf.SET_DATA_SLOT(2,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 22, true), '加速飞行')
    sf.SET_DATA_SLOT(1,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 33, true), '向后')
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 32, true), '向前')
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end
function vehflight(curcar, speed)
    show_button()
    SFfly()----显示按键
    if vehfly.stop then--无碰撞
        ENTITY.FREEZE_ENTITY_POSITION(curcar, true)
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(curcar)
    local camr = CAM.GET_GAMEPLAY_CAM_ROT(0)
    ENTITY.SET_ENTITY_ROTATION(curcar, camr.x, camr.y, camr.z, 1, true)
    
    if PAD.IS_CONTROL_PRESSED(0, 32) then ----前w
        ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(curcar, speed)
        if PAD.IS_CONTROL_PRESSED(0, 22) then ----加速space
            ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(curcar, 2 * speed)
        end
    elseif PAD.IS_CONTROL_PRESSED(0, 33) then ----后s
        ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(curcar, - speed)
        if PAD.IS_CONTROL_PRESSED(0, 22) then
            ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(curcar, - 2 * speed)
        end
    end
    if PAD.IS_CONTROL_PRESSED(0, 21) then ----上shift
        ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(curcar, 1, 0, 0, speed, 0, true, true, true, true)
    elseif PAD.IS_CONTROL_PRESSED(0, 36) then ----下ctrl
        ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(curcar, 1, 0, 0, - speed, 0, true, true, true, true)
    elseif PAD.IS_CONTROL_PRESSED(0, 35) then ----右d
        ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(curcar, 1, speed, 0, 0, 0, true, true, true, true)
    elseif PAD.IS_CONTROL_PRESSED(0, 34) then ----左a
        ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(curcar, 1, - speed, 0, 0, 0, true, true, true, true)
    end
end
function veh_fly_speed(s)
    vehfly.speed = s
end
function veh_fly_coll(on)
    vehfly.coll = on
end
function veh_fly_stop(on)
    vehfly.stop = not on
end
function veh_fly()
    local curcar = PED.GET_VEHICLE_PED_IS_IN(players.user_ped())
    if vehfly.coll then
        ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(curcar , false, true)
    else 
        ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(curcar , true, true) 
    end
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) then
        if curcar ~= 0 then
            vehflight(curcar, vehfly.speed)
        end
    else 
        util.toast('你没有乘坐载具')
        ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
    end
end
function close_veh_fly()
    local curcar = PED.GET_VEHICLE_PED_IS_IN(players.user_ped())
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(curcar)
    ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
    ENTITY.SET_ENTITY_HAS_GRAVITY(curcar, true)
end




----放置墙壁
function fastNet(entity, pid)
    local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
            for i = 1, 30 do
                if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
                    util.yield(10)
                end    
            end
        end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
    util.yield(10)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
    util.yield(10)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
    util.yield(10)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, pid, true)
    util.yield(10)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, true, false)
    util.yield(10)
    ENTITY1._SET_ENTITY_CLEANUP_BY_ENGINE(entity, false)
    util.yield(10)
    if ENTITY.IS_ENTITY_AN_OBJECT(entity) then
        NETWORK.OBJ_TO_NET(entity)
    end
    util.yield(10)
    ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
end
function Place_wall(pid)
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local forwardOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0, 4, 0)
    local pheading = ENTITY.GET_ENTITY_HEADING(ped)
    local hash = 309416120
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do 
        util.yield() 
    end
    local a1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, true, true)
    ENTITY.SET_ENTITY_HEADING(a1, pheading + 90)
    fastNet(a1, pid)
    local b1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z + 1, true, true, true)
    ENTITY.SET_ENTITY_HEADING(b1, pheading + 90)
    fastNet(b1, pid)
    util.yield(500)
    entities.delete(a1)
    entities.delete(b1)
end


----敌对交通
function GET_NEARBY_VEHICLES(pid, radius) 
	local vehicles = {}
	local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(p)
	local v = PED.GET_VEHICLE_PED_IS_IN(p, false)
	for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do 
		local veh_pos = ENTITY.GET_ENTITY_COORDS(vehicle)
		if vehicle ~= v and vect.dist(pos, veh_pos) <= radius then table.insert(vehicles, vehicle) end
	end
	return vehicles
end
function REQUEST_CONTROL_LOOP(entity)
	local tick = 0
	while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and tick < 25 do
		util.yield()
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
		tick = tick + 1
	end
	if NETWORK.NETWORK_IS_SESSION_STARTED() then
		local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
		NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
	end
end
function Hostile_traffic()
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    for k, vehicle in pairs(GET_NEARBY_VEHICLES(pid, 2000)) do	
        if not VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, -1) then
            local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1)
            if not PED.IS_PED_A_PLAYER(driver) then 
                REQUEST_CONTROL_LOOP(driver)
                PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
                PED.SET_PED_MAX_HEALTH(driver, 300)
                ENTITY.SET_ENTITY_INVINCIBLE(driver, true)
                ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
                VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 50)
                VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle,-1, 3)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(driver)
                PED.SET_PED_INTO_VEHICLE(driver, vehicle, -1)
                PED.SET_PED_COMBAT_ATTRIBUTES(driver, 46, true)
                TASK.TASK_COMBAT_PED(driver, player_ped, 0, 0)
                TASK.TASK_VEHICLE_MISSION_PED_TARGET(driver, vehicle, player_ped, 6, 100, 0, 0, 0, true)
                util.yield(10)
            end
        end
    end
end


----变成恐龙
function give_car_addon(pid, hash, center, ang)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    local pos = ENTITY.GET_ENTITY_COORDS(car, true)
    pos.x = pos['x']
    pos.y = pos['y']
    pos.z = pos['z']
    request_model(hash)
    local ramp = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, pos['x'], pos['y'], pos['z'], true, false, false)
    local size = get_model_size(ENTITY.GET_ENTITY_MODEL(car))
    if center then
        ENTITY.ATTACH_ENTITY_TO_ENTITY(ramp, car, 0, 0.0, 0.0, 0.0, 0.0, 0.0, ang, true, true, true, false, 0, true, 0)
    else
        ENTITY.ATTACH_ENTITY_TO_ENTITY(ramp, car, 0, 0.0, size['y']+1.0, 0.0, 0.0, 0.0, ang, true, true, true, false, 0, true, 0)
    end
end
function changemodel(pid)
    give_car_addon(pid, util.joaat("h4_prop_h4_loch_monster"), true, -90.0)
end
----给载具套笼子
function longzi_veh(pid)
    give_car_addon(pid, util.joaat("prop_gold_cont_01b"), true, -90.0)
end


----在车内生成NPC
function npcfillthecar(pid, index,value)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    if PED.IS_PED_IN_ANY_VEHICLE(target_ped, true) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(target_ped, false)
        local success = true
        for i = 0, VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(veh)) do
            local ped
            if VEHICLE.IS_VEHICLE_SEAT_FREE(veh, i) then
                local c = ENTITY.GET_ENTITY_COORDS(veh)
                pluto_switch index do
                    case 1:
                        ped = PED.CREATE_RANDOM_PED(c.x, c.y, c.z)
                        break
                    case 2:
                        local cops = {'s_f_y_cop_01', 's_m_m_snowcop_0', 's_m_y_hwaycop_01', 'csb_cop', 's_m_y_cop_01'}
                        local pick = cops[math.random(1, #cops)]
                        request_model(util.joaat(pick))
                        ped = entities.create_ped(6, util.joaat(pick), c, 0)
                        PED.SET_PED_AS_COP(ped, true)
                        WEAPON.GIVE_WEAPON_TO_PED(ped, util.joaat("weapon_pistol"), 1000, false, false)
                        break
                    case 3:
                        local strippers = {'csb_stripper_01', 'csb_stripper_02', 's_f_y_stripper_01', 's_f_y_stripper_02', 's_f_y_stripperlite'}
                        local pick2 = strippers[math.random(1, #strippers)]
                        request_model(util.joaat(pick2))
                        ped = entities.create_ped(6, util.joaat(pick2), c, 0)
                        break
                    case 4:
                        request_model(util.joaat('ig_lamardavis'))
                        ped = entities.create_ped(6, util.joaat('ig_lamardavis'), c, 0)
                        break 
                    case 5:
                        request_model(util.joaat('ig_lestercrest'))
                        ped = entities.create_ped(6, util.joaat('ig_lestercrest'), c, 0)
                        break 
                end
                PED.SET_PED_INTO_VEHICLE(ped, veh, i)
                PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
                PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
                PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
                PED.SET_PED_CAN_BE_DRAGGED_OUT(ped, false)
                PED.SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(ped, false)
            end
        end
    end
end


----罪城的水
function VicecityWater()
    if ENTITY.IS_ENTITY_IN_WATER(players.user_ped()) and not PED.IS_PED_DEAD_OR_DYING(players.user_ped()) then
        menu.trigger_commands("ewo")
    end
end


----力场
function force_Field(on)
    local mdl = util.joaat("p_spinning_anus_s")
    local playerpos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    request_model(mdl)
    if on then
        obj = entities.create_object(mdl, playerpos)
        ENTITY.SET_ENTITY_VISIBLE(obj, false)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, players.user_ped(), 0, 0, 0, 0, 0, 0, 0, false, false, true, false, 0, false, 0)
    else
        if obj ~= nil then 
            entities.delete(obj)
        end
    end
end


----力场pro
local s_forcefield = 0
local s_forcefield_range = 20
function force_Field_direction(val)
    s_forcefield = val
end
function force_Field_range(value)
    s_forcefield_range = value / 100
end
function force_Field_pro()
    local _entities = {}
    local player_pos = players.get_position(players.user())
    for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
        local vehicle_pos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
        if v3.distance(player_pos, vehicle_pos) <= s_forcefield_range then
            table.insert(_entities, vehicle)
        end
    end
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        local ped_pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        if (v3.distance(player_pos, ped_pos) <= s_forcefield_range) and not PED.IS_PED_A_PLAYER(ped) then
            table.insert(_entities, ped)
        end
    end
    for _, entity in pairs(_entities) do
        local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
        local entity_type = ENTITY.GET_ENTITY_TYPE(entity)
        if NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity) and player_vehicle ~= entity then
            if entity_type == 1 then
                PED.SET_PED_TO_RAGDOLL(entity, 500, 0, 0, false, false, false)
            end
            if s_forcefield == 1 then
                ENTITY.APPLY_FORCE_TO_ENTITY(entity, 3, 0, 0, 1, 0, 0, 0.5, 0, false, false, true, false, false)
            else
                local force = ENTITY.GET_ENTITY_COORDS(entity)
                v3.sub(force, player_pos)
                v3.normalise(force)
                if s_forcefield == 2 then
                    v3.mul(force, -1)
                end
                ENTITY.APPLY_FORCE_TO_ENTITY(entity, 3, force.x, force.y, force.z, 0, 0, 0.5, 0, false, false, true, false, false)
            end
        end
    end
end
function Plot_force_field_range()
    local pos = players.get_position(players.user())
    GRAPHICS1._DRAW_SPHERE(pos.x, pos.y, pos.z, s_forcefield_range, 223, 99, 231, 0.5)
end



----堆叠行人
function stack_npc()
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    all_peds = entities.get_all_peds_as_handles()
    local last_ped = 0
    local last_ped_ht = 0
    for k,ped in pairs(all_peds) do
        if not PED.IS_PED_A_PLAYER(ped) and not PED.IS_PED_FATALLY_INJURED(ped) then
            request_control_of_entity(ped)
            if PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
                TASK.TASK_LEAVE_ANY_VEHICLE(ped, 0, 16)
            end
    
            ENTITY.DETACH_ENTITY(ped, false, false)
            if last_ped ~= 0 then
                ENTITY.ATTACH_ENTITY_TO_ENTITY(ped, last_ped, 0, 0.0, 0.0, last_ped_ht-0.5, 0.0, 0.0, 0.0, false, false, false, false, 0, true, 0)
            else
                ENTITY.SET_ENTITY_COORDS(ped, c.x, c.y, c.z)
            end
            last_ped = ped
            last_ped_ht = get_model_size(ENTITY.GET_ENTITY_MODEL(ped)).z
        end
    end
end




----载具雨
function Vehicle_Rain()
    if vehicle_uses > 0 then     
        all_vehicles = entities.get_all_vehicles_as_handles()
        for k,veh in pairs(all_vehicles) do
            if l_e_v_on then
                local size = get_model_size(ENTITY.GET_ENTITY_MODEL(veh))
                if size.x > l_e_max_x or size.y > l_e_max_y or size.z > l_e_max_y then
                    entities.delete(veh)
                end
            end
            if vhp_bars and get_distance_between_entities(players.user_ped(), veh) < 200.0 and not ENTITY.IS_ENTITY_DEAD(veh, false) and ENTITY.IS_ENTITY_ON_SCREEN(veh) then
                local modelHash = ENTITY.GET_ENTITY_MODEL(veh)
                local min, max = v3.new(), v3.new()
                MISC.GET_MODEL_DIMENSIONS(modelHash, min, max)
                local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(veh, 0.0, 0.0, max.z + 0.3)
                local perc = 0.0

                if not ENTITY.IS_ENTITY_DEAD(veh, false) then
                    local maxHealth = ENTITY.GET_ENTITY_MAX_HEALTH(veh)
                    local health = ENTITY.GET_ENTITY_HEALTH(veh)
                    perc = health / maxHealth
                    if perc > 1.0 then perc = 1.0  end
                end
                
                local colour = get_health_colour(perc)
                local scale = v3.new(0.10, 0.0, interpolate(0.0, 0.7, perc))
                draw_marker(43, pos, v3(), v3(), scale, false, colour, 0, 0)
            end
            local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1)
            local player_cur_car = entities.get_user_vehicle_as_handle()
            if player_cur_car ~= veh and (not PED.IS_PED_A_PLAYER(driver)) or driver == 0 then
                if yeetsubmarines then
                    if VEHICLE.IS_VEHICLE_MODEL(veh, util.joaat("kosatka")) and ENTITY.IS_ENTITY_IN_WATER(veh) then
                        request_control_of_entity_once(veh)
                        ENTITY.SET_ENTITY_MAX_SPEED(veh, 10000)
                        ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1,  0.0, 0.0, 10000, 0, 0, 0, 0, true, false, true, false, true)
                    end 
                end
                if inferno then
                    local coords = ENTITY.GET_ENTITY_COORDS(veh, true)
                    FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 7, 100.0, true, false, 1.0)
                end
                if beep_cars then
                    if not AUDIO.IS_HORN_ACTIVE(veh) then
                        VEHICLE.START_VEHICLE_HORN(veh, 200, util.joaat("HELDDOWN"), true)
                    end
                end
                if blackhole then
                    if bh_target ~= -1 then
                        holecoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(bh_target), true)
                    end
                    vcoords = ENTITY.GET_ENTITY_COORDS(veh, true)
                    speed = 100
                    local x_vec = (holecoords['x']-vcoords['x'])*speed
                    local y_vec = (holecoords['y']-vcoords['y'])*speed
                    local z_vec = ((holecoords['z']+hole_zoff)-vcoords['z'])*speed
                    -- dumpster fire if this goes wrong lol
                    ENTITY.SET_ENTITY_INVINCIBLE(veh, true)
                    --losioVEHICLE.SET_VEHICLE_GRAVITY(veh, false)
                    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, x_vec, y_vec, z_vec, true, false, true, true)
                end
                if vehicle_chaos then
                    VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(veh, false, true)
                    VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, vc_speed)
                    VEHICLE.SET_VEHICLE_GRAVITY(veh, vc_gravity)
                end
                if halt_traffic then
                    VEHICLE.BRING_VEHICLE_TO_HALT(veh, 0.0, -1, true)
                    coords = ENTITY.GET_ENTITY_COORDS(veh, false)
                end
                if ascend_vehicles then
                    VEHICLE.SET_VEHICLE_UNDRIVEABLE(veh, true)
                    VEHICLE.SET_VEHICLE_GRAVITY(veh, false)
                    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 4, 5.0, 0.0, 0.0, true, true, true, true)
                end
                if rain_vehicles then 
                    if not ENTITY.IS_ENTITY_IN_AIR(veh) then 
                        local ped_c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
                        ped_c.x = ped_c.x + math.random(-50, 50)
                        ped_c.y = ped_c.y + math.random(-50, 50)
                        ped_c.z = ped_c.z + math.random(100, 120)
                        ENTITY.SET_ENTITY_COORDS(veh, ped_c.x, ped_c.y, ped_c.z)
                    end
                end
                if reverse_traffic then
                    ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1)
                    TASK.TASK_VEHICLE_TEMP_ACTION(ped, veh, 3, -1)
                end
            end
        end
    end
    util.yield()
end

----NPC雨
function Npc_Rain()
    if ped_uses > 0 then
        all_peds = entities.get_all_peds_as_handles()
        for k,ped in pairs(all_peds) do
            if kill_aura then
                if (kill_aura_peds and not PED.IS_PED_A_PLAYER(ped)) or (kill_aura_players and PED.IS_PED_A_PLAYER(ped)) then
                    local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(v)
                    local hdl = pid_to_handle(pid)
                    if (kill_aura_friends and not NETWORK.NETWORK_IS_FRIEND(hdl)) or not kill_aura_friends then
                        target = ENTITY.GET_ENTITY_COORDS(ped, false)
                        m_coords = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
                        if MISC.GET_DISTANCE_BETWEEN_COORDS(m_coords.x, m_coords.y, m_coords.z, target.x, target.y, target.z, true) < kill_aura_dist and ENTITY.GET_ENTITY_HEALTH(ped) > 0 then
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(target['x'], target['y'], target['z'], target['x'], target['y'], target['z']+0.1, 300.0, true, 100416529, players.user_ped(), true, false, 100.0)
                        end
                    end
                end
            end
            if not PED.IS_PED_A_PLAYER(ped) then
                if rain_peds then 
                    if not ENTITY.IS_ENTITY_IN_AIR(ped) then 
                        local ped_c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
                        ped_c.x = ped_c.x + math.random(-50, 50)
                        ped_c.y = ped_c.y + math.random(-50, 50)
                        ped_c.z = ped_c.z + math.random(50, 100)
                        ENTITY.SET_ENTITY_COORDS(ped, ped_c.x, ped_c.y, ped_c.z)
                        ENTITY.SET_ENTITY_VELOCITY(ped, 0.0, 0.0, -1.0)
                    end
                end
            end
        end
    end
    util.yield()
end



----实体引力
entityPairs = {}
shotEntities = {}
counter = 0
EntityPair = {ent1 = 0, ent2 = 0}
EntityPair.__index = EntityPair
function EntityPair.new(ent1, ent2)
	local instance = setmetatable({}, EntityPair)
	instance.ent1 = ent1
	instance.ent2 = ent2
	return instance
end
function EntityPair:exists()
	return ENTITY.DOES_ENTITY_EXIST(self.ent1) and ENTITY.DOES_ENTITY_EXIST(self.ent2)
end
function apply_force_to_ent(ent, force, flag)
	if ENTITY.IS_ENTITY_A_PED(ent) then
		if PED.IS_PED_A_PLAYER(ent) then return end
		PED.SET_PED_TO_RAGDOLL(ent, 1000, 1000, 0, false, false, false)
	end
	if request_control_once(ent) then
		ENTITY.APPLY_FORCE_TO_ENTITY(ent, flag or 1, force.x, force.y, force.z, 0.0, 0.0, 0.0, 0, false, false, true, false, false)
	end
end
function EntityPair:attract()
	local pos1 = ENTITY.GET_ENTITY_COORDS(self.ent1, false)
	local pos2 = ENTITY.GET_ENTITY_COORDS(self.ent2, false)
	local force = v3.new(pos2)
	force:sub(pos1)
	force:mul(0.05)
	apply_force_to_ent(self.ent1, force)
	force:mul(-1)
	apply_force_to_ent(self.ent2, force)
end
function table.find(t, value)
	for k, v in pairs(t) do
		if value == v then return k end
	end
	return nil
end
function table.insert_once(t, value)
	if not table.find(t, value) then table.insert(t, value) end
end
function EntityPair_new(ent1, ent2)----原函数名EntityPair.new()
	local instance = setmetatable({}, EntityPair)
	instance.ent1 = ent1
	instance.ent2 = ent2
	return instance
end
function ctst()
    local entity = get_entity_player_is_aiming_at(players.user())
	if entity ~= 0 and ENTITY.DOES_ENTITY_EXIST(entity) then
		draw_bounding_box(entity, true, {r = 255, g = 255, b = 255, a = 81})

		if PED.IS_PED_SHOOTING(players.user_ped()) and
		not (shotEntities[1] and shotEntities[1] == entity) then
			counter = counter + 1
			shotEntities[counter] = entity
		end

		if counter == 2 then
			local entPair = EntityPair_new(table.unpack(shotEntities))
			table.insert_once(entityPairs, entPair)
			counter = 0
			shotEntities = {}
		end
	end
	for i = #entityPairs, 1, -1 do
		local entPair = entityPairs[i]
		if entPair:exists() then 
            entPair:attract() 
        else 
            table.remove(entityPairs, i) 
        end
	end
end
function ctst_stop()
    counter = 0
	shotEntities = {}; entityPairs = {}
end


-----保镖直升机
function addRelationshipGroup(name)
    local ptr = memory.alloc_int()
    PED.ADD_RELATIONSHIP_GROUP(name, ptr)
    local rel = memory.read_int(ptr)
    return rel
end
relationship = {}
function relationship:friendly(ped)
    local friendly_group = nil
    if friendly_group == nil then
        friendly_group = addRelationshipGroup("friendly_group")
        PED.SET_RELATIONSHIP_BETWEEN_GROUPS(0, friendly_group, friendly_group)
    end
    PED.SET_PED_RELATIONSHIP_GROUP_HASH(ped, friendly_group)
end
function Bodyguard_helicopter(value)
    bodyguard_heli.name = sel_heli_model_list[value]
end
function Bodyguard_helicopter_invincible(toggle)
    bodyguard_heli.heli_godmode = toggle
end
function Spawn_bodyguard_helicopter()
    local heli_hash = util.joaat(bodyguard_heli.name)
    local ped_hash = util.joaat("s_m_y_blackops_01")
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    pos.x = pos.x + math.random(-10, 10)
    pos.y = pos.y + math.random(-10, 10)
    pos.z = pos.z + 30
    requestModels(ped_hash, heli_hash)
    relationship:friendly(players.user_ped())
    local heli = entities.create_vehicle(heli_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    if not ENTITY.DOES_ENTITY_EXIST(heli) then
        util.toast("Failed to create vehicle. Please try again")
        return
    else
        local heliNetId = NETWORK.VEH_TO_NET(heli)
        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(NETWORK.NET_TO_PED(heliNetId)) then
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(heliNetId, true)
        end
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(heliNetId, players.user(), true)
        VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, true)
        VEHICLE.SET_HELI_BLADES_FULL_SPEED(heli)
        VEHICLE.SET_VEHICLE_SEARCHLIGHT(heli, true, true)
        addBlipForEntity(heli, 422, 26)
        --health
        ENTITY.SET_ENTITY_INVINCIBLE(heli, bodyguard_heli.heli_godmode)
        ENTITY.SET_ENTITY_MAX_HEALTH(heli, 10000)
        ENTITY.SET_ENTITY_HEALTH(heli, 10000, 0)
        table.insert(heli_list, heli)
    end
    local pilot = entities.create_ped(29, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    PED.SET_PED_INTO_VEHICLE(pilot, heli, -1)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pilot, true)
    TASK.TASK_HELI_MISSION(pilot, heli, 0, players.user_ped(), 0.0, 0.0, 0.0, 23, 80.0, 50.0, -1.0, 0, 10, -1.0, 0)
    PED.SET_PED_KEEP_TASK(pilot, true)
    --health
    PED.SET_PED_MAX_HEALTH(pilot, 1000)
    ENTITY.SET_ENTITY_HEALTH(pilot, 1000, 0)
    ENTITY.SET_ENTITY_INVINCIBLE(pilot, bodyguard_heli.ped_godmode)
    table.insert(heli_ped_list, pilot)
    --local seats = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(heli)
    for seat = 0, 2 do
        local ped = entities.create_ped(29, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
        local pedNetId = NETWORK.PED_TO_NET(ped)
        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(ped) then
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(pedNetId, true)
        end
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(pedNetId, players.user(), true)
        PED.SET_PED_INTO_VEHICLE(ped, heli, seat)
        --fight
        WEAPON.GIVE_WEAPON_TO_PED(ped, util.joaat("weapon_mg"), -1, false, true)
        WEAPON.SET_PED_INFINITE_AMMO_CLIP(ped, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 3, false)
        PED.SET_PED_COMBAT_MOVEMENT(ped, 2)
        PED.SET_PED_COMBAT_ABILITY(ped, 2)
        PED.SET_PED_COMBAT_RANGE(ped, 2)
        PED.SET_PED_SEEING_RANGE(ped, 500.0)
        PED.SET_PED_HEARING_RANGE(ped, 500.0)
        PED.SET_PED_TARGET_LOSS_RESPONSE(ped, 1)
        PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
        PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(ped, 500.0)
        PED.SET_COMBAT_FLOAT(ped, 10, 500.0)
        PED.SET_PED_SHOOT_RATE(ped, 1000.0)
        PED.SET_PED_ACCURACY(ped, 100.0)
        PED.SET_PED_CAN_BE_SHOT_IN_VEHICLE(ped, true)
        --health
        PED.SET_PED_MAX_HEALTH(ped, 1000)
        ENTITY.SET_ENTITY_HEALTH(ped, 1000, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(ped, bodyguard_heli.ped_godmode)
        relationship:friendly(ped)
        table.insert(heli_ped_list, ped)
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(heli_hash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)
end
function delete_bodyguard_helicopter()
    for k, ent in pairs(heli_ped_list) do
        entities.delete(ent)
    end
    for k, ent in pairs(heli_list) do
        entities.delete(ent)
    end
end







----炸鱼
function fried_fish(pid)
    local Ptools_PanTable = {}
    local Ptools_PanCount = 1
    local targetped = PLAYER.GET_PLAYER_PED(pid)
    local targetcoords = ENTITY.GET_ENTITY_COORDS(targetped)
    local hash = util.joaat("tug")
    STREAMING.REQUEST_MODEL(hash)
    for i = 1, 20 do
        Ptools_PanTable[Ptools_PanCount] = VEHICLE.CREATE_VEHICLE(hash, targetcoords.x, targetcoords.y, targetcoords.z, 0, true, true, true)
        local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(Ptools_PanTable[Ptools_PanCount])
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(Ptools_PanTable[Ptools_PanCount])
        NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, pid, true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Ptools_PanTable[Ptools_PanCount], true, false)
        ENTITY.SET_ENTITY_VISIBLE(Ptools_PanTable[Ptools_PanCount], false, 0)
        Ptools_PanCount = Ptools_PanCount + 1
    end
end


----泰坦号轰炸
function Titan_bombing(pid)
    while not STREAMING.HAS_MODEL_LOADED(447548909) do
        STREAMING.REQUEST_MODEL(447548909)
        util.yield(10)
    end
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
    spam_amount = 300
    while spam_amount >= 1 do
        entities.create_vehicle(447548909, PlayerPedCoords, 0)
        spam_amount = spam_amount - 1
        util.yield(10)
    end
end


----渲染粒子
function Render_particles(pid)
    local player_pos = players.get_position(pid)
    request_ptfx_asset("scr_rcbarry2")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_clown_death", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    request_ptfx_asset("scr_rcbarry2")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_exp_clown", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    request_ptfx_asset("scr_ch_finale")
   GRAPHICS.USE_PARTICLE_FX_ASSET("scr_ch_finale")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_ch_finale_drill_sparks", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    request_ptfx_asset("scr_ch_finale")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_ch_finale")
    util.yield(100)
end


--传送所有PED给玩家
function tpTableToPlayer(tbl, pid)
    if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) then
        local c = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
        for _, v in pairs(tbl) do
            if (not PED.IS_PED_A_PLAYER(v)) then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(v, c.x, c.y, c.z, false, false, false)
            end
        end
    end
end
function TpAllPeds(pid)
    local pedHandles = entities.get_all_peds_as_handles()
    tpTableToPlayer(pedHandles, pid)
end
--传送所有载具给玩家
function TpAllVehs(pid)
    local vehHandles = entities.get_all_vehicles_as_handles()
    tpTableToPlayer(vehHandles, pid)
end
--传送所有物体给玩家
function TpAllObjects(pid)
    local objHandles = entities.get_all_objects_as_handles()
    tpTableToPlayer(objHandles, pid)
end

----镭射炮
local Laserhash = util.joaat("VEHICLE_WEAPON_PLAYER_LAZER")
local Lasersound = Sound_new("Fire_Loop", "DLC_IE_VV_Gun_Player_Sounds")
function DisableControlActions()
    PAD.DISABLE_CONTROL_ACTION(0, 106, true)
    PAD.DISABLE_CONTROL_ACTION(0, 122, true)
    PAD.DISABLE_CONTROL_ACTION(0, 135, true)
    PAD.DISABLE_CONTROL_ACTION(0, 140, true)
    PAD.DISABLE_CONTROL_ACTION(0, 141, true)
    PAD.DISABLE_CONTROL_ACTION(0, 142, true)
    PAD.DISABLE_CONTROL_ACTION(0, 263, true)
    PAD.DISABLE_CONTROL_ACTION(0, 264, true)
end
function Lasersound:hasFinished()
	return AUDIO.HAS_SOUND_FINISHED(self.Id)
end
function Lasersound:stop()
	if self.Id ~= -1 then
        AUDIO.STOP_SOUND(self.Id)
        AUDIO.RELEASE_SOUND_ID(self.Id)
        self.Id = -1
    end
end
function Lasersound:playFromEntity(entity)
	if self.Id == -1 then
		self.Id = AUDIO.GET_SOUND_ID()
		AUDIO.PLAY_SOUND_FROM_ENTITY(self.Id, self.name, entity, self.reference, true, 0)
	end
end
function Laser_cannon()
    --显示按键
    show_button()
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 46, true), '镭射炮')
    show_button2()
    --
    HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME()
    DisableControlActions()
    if not WEAPON.HAS_WEAPON_ASSET_LOADED(Laserhash) then
        WEAPON.REQUEST_WEAPON_ASSET(Laserhash, 31, 26)
    end
    if not PAD.IS_DISABLED_CONTROL_PRESSED(51, 51) then
        if not Lasersound:hasFinished() then
            Lasersound:stop()
        end
    elseif timer.elapsed() > 100 then
        local pos = PED.GET_PED_BONE_COORDS(players.user_ped(), 0x322C, 0.0, 0.0, 0.0)
        local offset = get_offset_from_cam(80)
        if  Lasersound:hasFinished() then
            Lasersound:playFromEntity(players.user_ped())
            AUDIO.SET_VARIABLE_ON_SOUND(Lasersound.Id, "fireRate", 10.0)
        end
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
            pos.x, pos.y, pos.z,
            offset.x, offset.y, offset.z,
            200,
            true,
            Laserhash, players.user_ped(), true, true, -1.0
        )
        timer.reset()
    end
end




----RPG自动瞄准器
function GetClosestPlayerWithRange_Whitelist(range, inair)
    local pedPointers = entities.get_all_peds_as_pointers()
    local rangesq = range * range
    local ourCoords = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
    local tbl = {}
    local closest_player = 0
    for i = 1, #pedPointers do
        local tarcoords = entities.get_position(pedPointers[i])
        local vdist = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
        if vdist <= rangesq then
            local handle = entities.pointer_to_handle(pedPointers[i])
            if (inair and (ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(handle) >= 9)) or (not inair) then --air check
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(handle)
                if not AIM_WHITELIST[pid] then --this is the whitelist check.
                    tbl[#tbl+1] = handle
                end
            end
        end
    end
    if tbl ~= nil then
        local dist = 999999
        for i = 1, #tbl do
            if tbl[i] ~= GetLocalPed() then
                if PED.IS_PED_A_PLAYER(tbl[i]) then
                    local tarcoords = ENTITY.GET_ENTITY_COORDS(tbl[i])
                    local e = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
                    if e < dist then
                        dist = e
                        closest_player = tbl[i]
                    end
                end
            end
        end
    end
    if closest_player ~= 0 then
        return closest_player
    else
        return nil
    end
end
function RPG_Automatic_sight(on)
    if on then
        local Chosen_Rocket_Hash = "-1707997257"
        while true do
            local localped = GetLocalPed()
            local localcoords = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
            local forOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(localped, 0, 5, 0)
            RRocket = OBJECT.GET_CLOSEST_OBJECT_OF_TYPE(forOffset.x, forOffset.y, forOffset.z, 10, Chosen_Rocket_Hash, false, true, true, true)
            local p
            if missile_settings.multitarget then
                if missile_settings.air_target then
                    p = GetClosestPlayerWithRange_Whitelist_DisallowEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, true)
                else
                    p = GetClosestPlayerWithRange_Whitelist_DisallowEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, false)
                end
            elseif missile_settings.multiped then
                if missile_settings.air_target then
                    p = GetClosestNonPlayerPedWithRange_DisallowedEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, true)
                else
                    p = GetClosestNonPlayerPedWithRange_DisallowedEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, false)
                end
            elseif not missile_settings.multitarget then
                if missile_settings.air_target then
                    p = GetClosestPlayerWithRange_Whitelist(missile_settings.radius, true)
                else
                    p = GetClosestPlayerWithRange_Whitelist(missile_settings.radius, false)
                end
            end
            local ppcoords = ENTITY.GET_ENTITY_COORDS(p, false)
            if (RRocket ~= 0) and (p ~= nil) and (not PED.IS_PED_DEAD_OR_DYING(p)) and (not AIM_WHITELIST[NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p)]) and (PED.IS_PED_SHOOTING(localped)) and (not players.is_in_interior(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p))) and (ppcoords.z > 1) then
                util.create_thread(function ()
                    local plocalized = p
                    local msl = RRocket
                    if missile_settings.multitarget then
                        MISSILE_ENTITY_TABLE[#MISSILE_ENTITY_TABLE+1] = plocalized
                    end
                    if (ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(localped, plocalized, 17) and missile_settings.los) or not missile_settings.los or MISL_AIR then
                            util.toast("前兆完成！")
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(msl)
                        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(msl) then
                            for i = 1, 10 do
                                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(msl)
                            end
                        else
                                util.toast("有控制权")
                        end
                        local aircount = 1
                        Missile_Camera = 0
                        STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                        while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(missile_particles.dictionary) do
                            STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                            util.yield()
                        end
                        GRAPHICS.USE_PARTICLE_FX_ASSET(missile_particles.dictionary)
                        while ENTITY.DOES_ENTITY_EXIST(msl) do
                                util.toast("火箭存在")
                            local pcoords2 = ENTITY.GET_ENTITY_COORDS(plocalized)
                            local pcoords = GetTableFromV3Instance(pcoords2)
                            local lc2 = ENTITY.GET_ENTITY_COORDS(msl)
                            local lc = GetTableFromV3Instance(lc2)
                            local look2 = v3.lookAt(lc2, pcoords2)
                            local look = GetTableFromV3Instance(look2)
                            local dir2 = v3.toDir(look2)
                            local dir = GetTableFromV3Instance(dir2)
                            if missile_settings.ptfx then
                                STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                                while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(missile_particles.dictionary) do
                                    STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                                    util.yield()
                                end
                                GRAPHICS.USE_PARTICLE_FX_ASSET(missile_particles.dictionary)
                                GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(missile_particles.name, lc.x, lc.y, lc.z, 0, 0, 0, 0.4 * missile_settings.ptfx_scale, false, false, false, true)
                            end
                            if aircount < 2 and MISL_AIR then
                                if ENTITY.DOES_ENTITY_EXIST(msl) then
                                    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, 0, 0, 2700, true, false, true, true)
                                    aircount = aircount + 1
                                    util.yield(1100)
                                end
                            end
                            local lookCountD = 0
                            if MISL_AIR then
                                if missile_settings.cam then
                                    if not CAM.DOES_CAM_EXIST(Missile_Camera) then
                                            util.toast("相机设置")
                                        CAM.DESTROY_ALL_CAMS(true)
                                        Missile_Camera = CAM.CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", true)
                                        CAM.SET_CAM_ACTIVE(Missile_Camera, true)
                                        CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, true, 0)
                                    end
                                end
                                local distx = math.abs(lc.x - pcoords.x)
                                local disty = math.abs(lc.y - pcoords.y)
                                local distz = math.abs(lc.z - pcoords.z)
                                if missile_settings.cam then
                                    local ddisst = GENERIC_SYSTEM.VDIST(pcoords.x, pcoords.y, pcoords.z, lc.x, lc.y, lc.z)
                                    if ddisst > 50 then
                                        local camcoordv3 = CAM.GET_CAM_COORD(Missile_Camera)
                                        local look3 = v3.lookAt(camcoordv3, lc2)
                                        local look4 = GetTableFromV3Instance(look3)
                                        local backoffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(msl, 10, 10, -2)
                                        CAM.SET_CAM_COORD(Missile_Camera, backoffset.x, backoffset.y, backoffset.z)
                                        if lookCountD < 1 then
                                            CAM.SET_CAM_ROT(Missile_Camera, look4.x, look4.y, look4.z, 2)
                                            lookCountD = lookCountD + 1
                                        end
                                    else
                                        local camcoordv3 = CAM.GET_CAM_COORD(Missile_Camera)
                                        local look3 = v3.lookAt(camcoordv3, lc2)
                                        local look4 = GetTableFromV3Instance(look3)
                                        CAM.SET_CAM_ROT(Missile_Camera, look4.x, look4.y, look4.z, 2)
                                    end
                                end
                                ENTITY.SET_ENTITY_ROTATION(msl, look.x, look.y, look.z, 2, true)
                                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, dir.x * missile_settings.speed * distx, dir.y * missile_settings.speed * disty, dir.z * missile_settings.speed * distz, true, false, true, true)
                                util.yield()
                            else
                                ENTITY.SET_ENTITY_ROTATION(msl, look.x, look.y, look.z, 2, true)
                                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, dir.x * missile_settings.speed, dir.y * missile_settings.speed, dir.z * missile_settings.speed, true, false, true, true)
                                util.yield()
                            end
                        end
                        if missile_settings.cam then
                            util.yield(2000)
                                util.toast("相机删除")
                            CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
                            if CAM.IS_CAM_ACTIVE(Missile_Camera) then
                                CAM.SET_CAM_ACTIVE(Missile_Camera, false)
                            end
                            CAM.DESTROY_CAM(Missile_Camera, true)
                        end
                    end
                    if missile_settings.multitarget then
                        table.remove(MISSILE_ENTITY_TABLE, GetValueIndexFromTable(MISSILE_ENTITY_TABLE, plocalized))
                        util.toast("已删除的值" .. tostring(plocalized) .. " at index " .. tostring(GetValueIndexFromTable(MISSILE_ENTITY_TABLE, p)))
                    end
                end)
            end
            util.yield()
        end
    end
end




------自动驾驶
local drivestyle = 786603
local drivespeed = 20.00
function drivestylee(index)
    drivestyle = drivestyletables[index]
end
function drivespeedd(value)
    drivespeed = value / 100
end
function Auto_driving(toggle)
    Auto_drived = toggle
    local pos = players.get_position(players.user())
    local vehicle = entities.get_user_vehicle_as_handle()
    jesus = util.joaat("u_m_m_jesus_01")
    RequestModel(jesus)
    if Auto_drived then
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
            TASK1.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(jesus_ped, vehicle, waypoint, drivespeed, drivestyle, 0.0)
                while Auto_drived do
                    if not HUD.IS_WAYPOINT_ACTIVE() then
                        util.toast("自动驾驶结束")
                        menu.set_value(jesus_toggle, false)
                    end
                    util.yield()
                end
        else
            util.toast("请先设置一个导航点. :)")
            menu.set_value(jesus_toggle, false)
        end
        util.yield()
    else
        if jesus_ped ~= nil then 
            entities.delete(jesus_ped)
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -1)
        end
    end
    while Auto_drived do
        local height = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(vehicle)
        local upright_value = ENTITY.GET_ENTITY_UPRIGHT_VALUE(vehicle)
        if height < 5.0 and upright_value < 0.0 then
            VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(vehicle)
        end
        util.yield()
    end
end

-----特斯拉自动驾驶
function Tesla_Autopilot(toggled)
    local player = players.user_ped()
    local playerpos = ENTITY.GET_ENTITY_COORDS(player, false)
    local tesla_ai = util.joaat("u_m_y_baygor")
    local tesla = util.joaat("raiden")
    request_model(tesla_ai)
    request_model(tesla)
    if toggled then     
        if PED.IS_PED_IN_ANY_VEHICLE(player, true) then
            menu.trigger_commands("deletevehicle")
        end
        tesla_ai_ped = entities.create_ped(26, tesla_ai, playerpos, 0)
        tesla_vehicle = entities.create_vehicle(tesla, playerpos, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(tesla_ai_ped, true)
        ENTITY.SET_ENTITY_VISIBLE(tesla_ai_ped, false)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(tesla_ai_ped, true)
        PED.SET_PED_INTO_VEHICLE(player, tesla_vehicle, -2)
        PED.SET_PED_INTO_VEHICLE(tesla_ai_ped, tesla_vehicle, -1)
        PED.SET_PED_KEEP_TASK(tesla_ai_ped, true)
        VEHICLE.SET_VEHICLE_COLOURS(tesla_vehicle, 111, 111)
        VEHICLE.SET_VEHICLE_MOD(tesla_vehicle, 23, 8, false)
        VEHICLE.SET_VEHICLE_MOD(tesla_vehicle, 15, 1, false)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(tesla_vehicle, 111, 147)
        if HUD.IS_WAYPOINT_ACTIVE() then
            local pos = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
            TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(tesla_ai_ped, tesla_vehicle, pos.x, pos.y, pos.z, 20, 786603, 0)
        else
            TASK.TASK_VEHICLE_DRIVE_WANDER(tesla_ai_ped, tesla_vehicle, 20, 786603)
        end
    else
        if tesla_ai_ped ~= nil then 
            entities.delete(tesla_ai_ped)
        end
        if tesla_vehicle ~= nil then 
            entities.delete(tesla_vehicle)
        end
    end
end


-----载具效果
local selectedOpt = 1
function selectedOptt(index)
    selectedOpt = index 
end
function vehicle_effectt()
    local effect = veffects[selectedOpt]
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
    if ENTITY.DOES_ENTITY_EXIST(vehicle) and not ENTITY.IS_ENTITY_DEAD(vehicle, false) and
        VEHICLE.IS_VEHICLE_DRIVEABLE(vehicle, false) and timer.elapsed() > effect[4] then
            request_fx_asset(effect[1])
        for _, boneName in pairs({"wheel_lf", "wheel_lr", "wheel_rf", "wheel_rr"}) do
            local bone = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicle, boneName)
            GRAPHICS.USE_PARTICLE_FX_ASSET(effect[1])
            GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE(
                effect[2],
                vehicle,
                0.0, 0.0, 0.0,
                0.0, 0.0, 0.0,
                bone,
                effect[3],
                false, false, false
            )
        end
        timer.reset()
    end
end


------生成坡道/分离载具零件
function control_vehicle1(pid, output_toast, callback, opts)
    local vehicle = get_player_vehicle_in_control(pid, opts)
    if vehicle ~= 0 then
        callback(vehicle)
        return true
    else
        if output_toast then
            util.toast("玩家不在车内")
        end
        return false
    end
end


------天基炮
function nuclear_weapon1()
    local last_hit_coords = v3.new()
	if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), last_hit_coords) then
        request_ptfx_asset("scr_xm_orbital")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
        FIRE.ADD_EXPLOSION(last_hit_coords.x, last_hit_coords.y, last_hit_coords.z, 59, 1, true, false, 1.0, false)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", last_hit_coords.x, last_hit_coords.y, last_hit_coords.z, 0, 180, 0, 1.0, true, true, true)
        for i = 1, 4 do
            AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "DLC_XM_Explosions_Orbital_Cannon", players.user_ped(), 0, true, 0)
        end
	end
end
-----核弹
function get_distance_between(pos1, pos2)
	if math.type(pos1) == "integer" then
		pos1 = ENTITY.GET_ENTITY_COORDS(pos1)
	end
	if math.type(pos2) == "integer" then 
		pos2 = ENTITY.GET_ENTITY_COORDS(pos2)
	end
	return pos1:distance(pos2)
end
function nuke_expl1(Position)
    local offsets = {
        {10, 0, 0}, {0, 10, 0}, {10, 10, 0}, {-10, 0, 0}, {0, -10, 0}, {-10, -10, 0}, {10, -10, 0}, {-10, 10, 0},
        {20, 0, 0}, {0, 20, 0}, {20, 20, 0}, {-20, 0, 0}, {0, -20, 0}, {-20, -20, 0}, {20, -20, 0}, {-20, 10, 0},
        {30, 0, 0}, {0, 30, 0}, {30, 30, 0}, {-30, 0, 0}, {0, -30, 0}, {-30, -30, 0}, {30, -30, 0}, {-30, 10, 0},
        {10, 30, 0}, {30, 10, 0}, {-30, -10, 0}, {-10, -30, 0}, {-10, 30, 0}, {-30, 10, 0}, {30, -10, 0}, {10, -30, 0},
        {0, 0, 10}, {0, 0, -10}, {0, 0, 20}, {0, 0, -20}
    }
    for _, offset in ipairs(offsets) do
        FIRE.ADD_EXPLOSION(Position.x + offset[1], Position.y + offset[2], Position.z + offset[3], 59, 1.0, true, false, 1.0, false)
    end
end
function nuke_expl2(Position)
    local offsets = {{0,0,-10}, {10,0,-10}, {0,10,-10}, {10,10,-10}, {-10,0,-10}, {0,-10,-10}, {-10,-10,-10}, {10,-10,-10}, {-10,10,-10}}
    for _, offset in ipairs(offsets) do
        FIRE.ADD_EXPLOSION(Position.x + offset[1], Position.y + offset[2], Position.z + offset[3], 59, 1.0, true, false, 1.0, false)
    end
end
function nuke_expl3(Position)
    local offsets = {{10,0,0}, {0,10,0}, {10,10,0}, {-10,0,0}, {0,-10,0}, {-10,-10,0}, {10,-10,0}, {-10,10,0}, {0,0,0}}
    for _, offset in ipairs(offsets) do
        FIRE.ADD_EXPLOSION(Position.x + offset[1], Position.y + offset[2], Position.z + offset[3], 59, 1.0, true, false, 1.0, false)
    end
end
function create_nuke_explosion(Position)
    for count = 1, 17 do
        if count == 1 then
	        FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z, 59, 1, true, false, 5.0, false)
        elseif count == 2 then
            FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z, 59, 1, true, false, 1.0, false)
        end
		request_ptfx_asset("scr_xm_orbital")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
	    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", Position.x, Position.y, Position.z, 0, 180, 0, 4.5, true, true, true)
    end
    nuke_expl1(Position)
	for i = 1, 4 do
		AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "DLC_XM_Explosions_Orbital_Cannon", players.user_ped(), 0, true, 0)
	end
    for count = 1, 2 do
        if count == 1 then
	        FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z-10, 59, 1, true, false, 5.0, false)
        end
		request_ptfx_asset("scr_xm_orbital")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
	    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", Position.x, Position.y, Position.z-10, 0, 180, 0, 4.5, true, true, true)
    end
    nuke_expl2(Position)
    local size = 1.5
    local positionsZ = {1, 3, 5, 7, 10, 12, 15, 17, 20, 22, 25, 27, 30, 32, 35, 37, 40, 42, 45, 47, 50, 52, 55, 57, 59, 61, 63, 65, 70, 75, 75, 75, 75, 80, 80}
    for i, pos in ipairs(positionsZ) do
        if i == 3 or i == 5 or i == 7 or i == 9 or i == 11 or i == 13 or i == 15 or i == 17 or i == 19 or i == 21 or i == 23 or i == 25 or i == 29 or i == 30 then
        FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z+pos, 59, 1.0, true, false, 1.0, false)
        end
        request_ptfx_asset("scr_xm_orbital")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
	    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", Position.x, Position.y, Position.z+pos, 0, 180, 0, size, true, true, true)

        if i >= 30 and i <= 33 then size = 3.5
        elseif i >= 34 and i <= 35 then size = 3.0
        else size = 1.5 end
        util.yield(10)
    end
    nuke_expl3(Position)
	for _, pid in pairs(players.list(false, true, true)) do
        local distance = get_distance_between(players.get_position(pid), Position)
		if distance < 200 then
			local pid_pos = players.get_position(pid)
			FIRE.ADD_EXPLOSION(pid_pos.x, pid_pos.y, pid_pos.z, 59, 1.0, true, false, 1.0, false)
		end
	end
	local peds = entities.get_all_peds_as_handles()
	for _, ped in pairs(peds) do
		if get_distance_between(ped, Position) > 200 and get_distance_between(ped, Position) < 400 and ped ~= players.user_ped() then
			local ped_pos = ENTITY.GET_ENTITY_COORDS(ped)
			FIRE.ADD_EXPLOSION(ped_pos.x, ped_pos.y, ped_pos.z, 3, 1.0, true, true, 0.1, false)
		end
	end
	local vehicles = entities.get_all_vehicles_as_handles()
    for _, vehicle in pairs(vehicles) do
		if get_distance_between(vehicle, Position) < 400 then
			VEHICLE.EXPLODE_VEHICLE(vehicle, true, false)
		elseif get_distance_between(vehicle, Position) > 200 and get_distance_between(vehicle, Position) < 400 then
			VEHICLE.EXPLODE_VEHICLE(vehicle, true, false)
		end
	end
end
function nuclear_weapon2()
    if PED.IS_PED_SHOOTING(players.user_ped()) then
		local hash = util.joaat("prop_military_pickup_01")
		request_model(hash)
		local player_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 5.0, 3.0)
		local dir = {}
		local c2 = {}
		c2 = get_offset_from_gameplay_camera(1000)
		dir.x = (c2.x - player_pos.x) * 1000
		dir.y = (c2.y - player_pos.y) * 1000
		dir.z = (c2.z - player_pos.z) * 1000
		local nuke = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, player_pos.x, player_pos.y, player_pos.z, true, false, false)
		ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(nuke, players.user_ped(), false)
		ENTITY.APPLY_FORCE_TO_ENTITY(nuke, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
		ENTITY.SET_ENTITY_HAS_GRAVITY(nuke, true)
		while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(nuke) and not ENTITY.IS_ENTITY_IN_WATER(nuke) do
			util.yield(0)
		end
		local nukePos = ENTITY.GET_ENTITY_COORDS(nuke, true)
		entities.delete(nuke)
        create_nuke_explosion(nukePos)
	end
end





----护送核弹车
function escort_nuke(on,pid)
    if on then
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 5.0, 0.0)
        local hash = util.joaat("tiptruck")
        request_model(hash)
        nuketruck = VEHICLE.CREATE_VEHICLE(hash, pos.x , pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(ped), true, false, true)
        local hash = util.joaat("prop_military_pickup_01")
        request_model(hash)
        local truck_pos = ENTITY.GET_ENTITY_COORDS(nuketruck, true)
        local truck_rot = ENTITY.GET_ENTITY_ROTATION(nuketruck, 0)
        esnuke = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, truck_pos.x, truck_pos.y, truck_pos.z + 2, true, false, true)
        ENTITY.SET_ENTITY_HAS_GRAVITY(esnuke, true)
        ENTITY.SET_ENTITY_ROTATION(esnuke, truck_rot.x, truck_rot.y, truck_rot.z+90, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(esnuke, nuketruck, 0, 0.0, -1.5, 1.7, 0.0, 0.0, 90.0, false, false, false, false, 2, true, 0)
        util.create_tick_handler(function()
            if VEHICLE.GET_VEHICLE_ENGINE_HEALTH(nuketruck) <= 0 and ENTITY.DOES_ENTITY_EXIST(esnuke) then
                local nukePos = ENTITY.GET_ENTITY_COORDS(esnuke, true)
                entities.delete(esnuke)
                create_nuke_explosion(nukePos)
                menu.set_value(safe_nuke, false)
                util.toast("核弹已被引爆")
            end
        end)
    else
        if ENTITY.DOES_ENTITY_EXIST(esnuke) then
            entities.delete(esnuke)
        end
        if ENTITY.DOES_ENTITY_EXIST(nuketruck) then
            entities.delete(nuketruck)
        end
    end
end



----运输核弹
function transport_nuke()
    local msg = "~y~按 ~%s~ 投掷核弹"
    util.show_corner_help(msg:format("INPUT_VEH_HORN"))
    local ped = players.user_ped()
    local hash = util.joaat("prop_military_pickup_01")
    local pos = players.get_position(players.user())
    request_model(util.joaat("skylift"))
    request_model(hash)
    local skylift = VEHICLE.CREATE_VEHICLE(util.joaat("skylift"), pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(ped), true, false, false)
    PED.SET_PED_INTO_VEHICLE(ped, skylift, -1)
    local nuke = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, pos.x, pos.y, pos.z, true, false, true)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(nuke, true, true)--防止消失
    ENTITY.ATTACH_ENTITY_TO_ENTITY(nuke, skylift, 0, 0, -2.8, -1.0, 0.0, 0.0, 0.0, true, true, true, false, 0, true, 0)
    while true do
        local skyliftPos = ENTITY.GET_ENTITY_COORDS(skylift, true)
        local strg = "~b~ Elevation ~w~"..math.ceil(skyliftPos.z)
        draw_string(strg, 0.03, 0.1, 0.6, 4)
        if PAD.IS_CONTROL_PRESSED(0,46) then
            if ENTITY.IS_ENTITY_ATTACHED(nuke) then
                ENTITY.DETACH_ENTITY(nuke, true, true)
                notification("~bold~~y~炸弹已投放", HudColour.blue)
            end
            ENTITY.APPLY_FORCE_TO_ENTITY(nuke, 3, 0.0, 0.0, -50, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
            ENTITY.SET_ENTITY_HAS_GRAVITY(nuke, true)
            while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(nuke) and not ENTITY.IS_ENTITY_IN_WATER(nuke) do
                util.yield(0)
            end
            if ENTITY.DOES_ENTITY_EXIST(nuke) then
                local nukePos = ENTITY.GET_ENTITY_COORDS(nuke, true)
                entities.delete(nuke)
                create_nuke_explosion(nukePos)
                notification("~bold~~y~核弹已爆炸", HudColour.blue)
                break
            end
        end
        util.yield()
    end
end



------前滚翻
function has_anim_dict_loaded(dict)
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        STREAMING.REQUEST_ANIM_DICT(dict)
        util.yield(0)
    end
end
local i_forward = 360
function forward_roll()
    has_anim_dict_loaded("misschinese2_crystalmaze")
    TASK.TASK_PLAY_ANIM(players.user_ped(), "misschinese2_crystalmaze", "2int_loop_a_taotranslator", 8.0, 8.0, -1, 0, 0.0, 0, 0, 0)
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
    local user_rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 0)
    local fwd_vect = ENTITY.GET_ENTITY_FORWARD_VECTOR(players.user_ped())
    local speed = ENTITY.GET_ENTITY_SPEED(players.user_ped()) * 2.236936
    PED.SET_PED_CAN_RAGDOLL(players.user_ped(), false)
    ENTITY.SET_ENTITY_ROTATION(players.user_ped(), i_forward, user_rot.y, cam_rot.z, 2, true)
    if speed <= 70 then
        ENTITY.APPLY_FORCE_TO_ENTITY(players.user_ped(), 3, fwd_vect.x, fwd_vect.y, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, false)
    end
    if i_forward <= 0 then i_forward = 360 else i_forward = i_forward - 6 end 
end
function end_forward_roll()
    util.yield(100)
    PED.SET_PED_CAN_RAGDOLL(players.user_ped(), true)
    TASK.STOP_ANIM_TASK(players.user_ped(), "misschinese2_crystalmaze", "2int_loop_a_taotranslator", 1)
end
----街舞
local rotation = 0
local loop_count = 0
local dict, name
function breakdance()
    if loop_count <= 200 then
        dict = "missfbi5ig_20b"
        name = "hands_up_scientist"
    elseif loop_count <= 400 then
        dict = "nm@hands"
        name = "hands_up"
    elseif loop_count <= 600 then
        dict = "missheist_agency2ahands_up"
        name = "handsup_anxious"
    elseif loop_count <= 800 then
        dict = "missheist_agency2ahands_up"
        name = "handsup_loop"
    end
    ENTITY.SET_ENTITY_ROTATION(players.user_ped(), 180, 0, rotation, 1, true)
    has_anim_dict_loaded(dict)
    TASK.TASK_PLAY_ANIM(players.user_ped(), dict, name, 8.0, 0, -1, 0, 0.0, 0, 0, 0)
    rotation = rotation + 5
    if loop_count < 1000 then
        loop_count = loop_count + 1
    else
        loop_count = 0
    end
end
function end_breakdance()
    util.yield(100)
    TASK.STOP_ANIM_TASK(players.user_ped(), dict, name, 1)
end



----传送到最近玩家
function getClosestPlayer(myPos)
    local closestDist = 999999999999
    local closest_player = nil
    local myVehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
    if myVehicle == 0 then
        myVehicle = 1
    end
    for players.list(false, true, true) as pid do
		local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		if not ENTITY.IS_ENTITY_DEAD(ped) then
            local playerpos = players.get_position(pid)
            local dist = myPos:distance(playerpos)
            local playerVehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
            if (dist < closestDist) and (playerVehicle != myVehicle) and not players.is_in_interior(pid) then
                closestDist = dist
                closest_player = pid
            end
		end
    end
    if closest_player != nil and closest_player != players.user() then
        return closest_player
    end
end
function tp_closest_player()
    local user_pos = players.get_position(players.user())
	local player = getClosestPlayer(user_pos)
    if player != nil then
        if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
            local player_pos = players.get_position(player)
            ENTITY.SET_ENTITY_COORDS(players.user_ped(), player_pos.x, player_pos.y, player_pos.z, false, false, false, false)
        else
            local player_pos = players.get_position(player)
            local user_vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
            if user_vehicle != 0 then
                ENTITY.SET_ENTITY_COORDS(user_vehicle, player_pos.x, player_pos.y, player_pos.z, false, false, false, false)
            end
        end
    end
end



----传送到最近载具
function get_closest_vehicle(entity)
    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
    local vehicles = entities.get_all_vehicles_as_handles()
    local closestdist = 1000000
    local closestveh = 0
    for k, veh in pairs(vehicles) do
        local Ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        if PED.IS_PED_IN_ANY_VEHICLE(Ped, false) then
            if veh ~= PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false) then
                local vehcoord = ENTITY.GET_ENTITY_COORDS(veh, true)
                local dist = MISC.GET_DISTANCE_BETWEEN_COORDS(coords['x'], coords['y'], coords['z'], vehcoord['x'], vehcoord['y'], vehcoord['z'], true)
                if dist < closestdist then
                    closestdist = dist
                    closestveh = veh
                end
            end
        else
            local vehcoord = ENTITY.GET_ENTITY_COORDS(veh, true)
            local dist = MISC.GET_DISTANCE_BETWEEN_COORDS(coords['x'], coords['y'], coords['z'], vehcoord['x'], vehcoord['y'], vehcoord['z'], true)
            if dist < closestdist then
                closestdist = dist
                closestveh = veh
            end
        end
    end
    return closestveh
end
function tp_closest_vehicle()
    local closestveh = get_closest_vehicle(players.user_ped())
    local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(closestveh, -1)
    if VEHICLE.IS_VEHICLE_SEAT_FREE(closestveh, -1) then
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, -1)
    else
        if not PED.IS_PED_A_PLAYER(driver) then
            entities.delete(driver)
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, -1)
        elseif VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(closestveh) then
            for i = 0, 10 do
                if VEHICLE.IS_VEHICLE_SEAT_FREE(closestveh, i) then
                    PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, i)
                    break
                end
            end
        else
            util.toast("传送到最近车辆错误")
        end
    end
end



-----金色翅膀
function Golden_wings(on)
    if on then	
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        Gowings = OBJECT.CREATE_OBJECT(util.joaat("vw_prop_art_wings_01a"), pos.x, pos.y, pos.z, true, true, true)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(util.joaat("vw_prop_art_wings_01a"))
        ENTITY.ATTACH_ENTITY_TO_ENTITY(Gowings, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 0x5c01), -1.0, 0.0, 0.0, 0.0, 90.0, 0.0, false, true, false, true, 0, true, 0)
    else
        entities.delete(Gowings)
    end
end

-----银色翅膀
function argent_wings(on)
    if on then	
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        argwings = OBJECT.CREATE_OBJECT(-112384661, pos.x, pos.y, pos.z, true, true, true)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(-112384661)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(argwings, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 0x5c01), -1.0, 0.0, 0.0, 0.0, 90.0, 0.0, false, true, false, true, 0, true, 0)
    else
        entities.delete(argwings)
    end
end




--火翅膀
local fireWingr = 25
local fireWingg = 0
local fireWingb = 50
local ptfxEgg
function fireWing_v1(toggle)
    if toggle then
        ENTITY.SET_ENTITY_PROOFS(players.user_ped(), false, true, false, false, false, false, 1, false)
        if ptfxEgg == nil then
            local eggHash = 1803116220
            request_model(eggHash)
            ptfxEgg = entities.create_object(eggHash, ENTITY.GET_ENTITY_COORDS(players.user_ped()))
            ENTITY.SET_ENTITY_COLLISION(ptfxEgg, false, false)
            ENTITY.SET_ENTITY_VISIBLE(ptfxEgg, false)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(eggHash)
            
        end
        for i = 1, #fireWings do
            while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do
                STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
                util.yield()
            end
            GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
            fireWings[i].ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY('muz_xs_turret_flamethrower_looping', ptfxEgg, 0, 0, 0.1, fireWings[i].pos[1], 0, fireWings[i].pos[2], 1, false, false, false, 0, 0, 0, 0)
            local rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 2)
            ENTITY.SET_ENTITY_ROTATION(ptfxEgg, rot.x, rot.y, rot.z, 2, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(ptfxEgg, players.user_ped(), -1, 0, 0, 0, rot.x, rot.y, rot.z, false, false, false, false, 0, false, 0)
            GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(fireWings[i].ptfx, 0.3)
            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireWings[i].ptfx,fireWingr, fireWingg, fireWingb, 0)
            util.create_tick_handler(function()
                for i = 1, #fireWings do
                    fireWingr = fireWingr + 0.145
                    if fireWingr > 0.96 then
                        fireWingg = fireWingg + 5
                        fireWingb = fireWingb +6
                        fireWingr = 0.001
                    end
                end
            end)				
        end			
    else
        for i = 1, #fireWings do
            if fireWings[i].ptfx then
                GRAPHICS.REMOVE_PARTICLE_FX(fireWings[i].ptfx, true)
                fireWings[i].ptfx = nil
            end
            if ptfxEgg then
                entities.delete(ptfxEgg)
                ptfxEgg = nil
            end
        end
        STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
    end
end

--------彩色翅膀
function fireWingv2_color(newColour)
    fireWing_v2color = newColour
end
function fireWing_v2(toggle)
    if toggle then
        ENTITY.SET_ENTITY_PROOFS(players.user_ped(), false, true, false, false, false, false, 1, false)
        if ptfxEgg == nil then
            local eggHash = 1803116220
            request_model(eggHash)
            ptfxEgg = entities.create_object(eggHash, ENTITY.GET_ENTITY_COORDS(players.user_ped()))
            ENTITY.SET_ENTITY_COLLISION(ptfxEgg, false, false)
            ENTITY.SET_ENTITY_VISIBLE(ptfxEgg, false)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(eggHash)
        end
        for i = 1, #fireWings do
            while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do
                STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
                util.yield()
            end
            GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
            fireWings[i].ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY('muz_xs_turret_flamethrower_looping', ptfxEgg, 0, 0, 0.1, fireWings[i].pos[1], 0, fireWings[i].pos[2], 1, false, false, false, 0, 0, 0, 0)
            local rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 2)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(ptfxEgg, players.user_ped(), -1, 0, 0, 0, rot.x, rot.y, rot.z, false, false, false, false, 0, false, 0)
            ENTITY.SET_ENTITY_ROTATION(ptfxEgg, rot.x, rot.y, rot.z, 2, true) 		
        end
        while fireWings[1].ptfx do
            for i = 1, #fireWings do
                GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(fireWings[i].ptfx, 0.3)
                GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireWings[i].ptfx, fireWing_v2color.r, fireWing_v2color.g, fireWing_v2color.b, 0)
            end	
            util.yield()
        end
    else
        for i = 1, #fireWings do
            if fireWings[i].ptfx then
                GRAPHICS.REMOVE_PARTICLE_FX(fireWings[i].ptfx, true)
                fireWings[i].ptfx = nil
            end
            if ptfxEgg then
                entities.delete(ptfxEgg)
                ptfxEgg = nil
            end
        end
        STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
    end
end



-------任务选项函数
function MP_INDEX()
    return "MP" .. util.get_char_slot() .. "_"
end
function IS_MPPLY(Stat)
    local Stats = {
        "MP_PLAYING_TIME",
    }
    for i = 1, #Stats do
        if Stat == Stats[i] then
            return true
        end
    end
    if string.find(Stat, "MPPLY_") then
        return true
    else
        return false
    end
end
function ADD_MP_INDEX(Stat)
    if not IS_MPPLY(Stat) then
        Stat = MP_INDEX() .. Stat
    end
    return Stat
end
function STAT_SET_INT(Stat, Value)
    STATS.STAT_SET_INT(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
end
function STAT_GET_INT(Stat)
    local IntPTR = memory.alloc_int()
    STATS.STAT_GET_INT(util.joaat(ADD_MP_INDEX(Stat)), IntPTR, -1)
    return memory.read_int(IntPTR)
end
function SET_INT_GLOBAL(Global, Value)
    memory.write_int(memory.script_global(Global), Value)
end
function SET_INT_LOCAL(Script, Local, Value)
    if memory.script_local(Script, Local) ~= 0 then
        memory.write_int(memory.script_local(Script, Local), Value)
    end
end
function SET_FLOAT_LOCAL(Script, Local, Value)
    if memory.script_local(Script, Local) ~= 0 then
        memory.write_float(memory.script_local(Script, Local), Value)
    end
end
function GET_INT_LOCAL(Script, Local)
    if memory.script_local(Script, Local) ~= 0 then
        local Value = memory.read_int(memory.script_local(Script, Local))
        if Value ~= nil then
            return Value
        end
    end
end
function TELEPORT(X, Y, Z)
    PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), X, Y, Z)
end







-----钢铁侠
local startViewMode
local scope_scaleform
local gaveHelmet = false
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
function Iron_Man()
    menu.trigger_commands("levitate on")
    if not PED.IS_PED_WEARING_HELMET(players.user_ped()) then
        PED.GIVE_PED_HELMET(players.user_ped(), true, 4096, -1)
        gaveHelmet = true
    end
    local context = CAM1._GET_CAM_ACTIVE_VIEW_MODE_CONTEXT()
    if startViewMode == nil then
        startViewMode = CAM.GET_CAM_VIEW_MODE_FOR_CONTEXT(context)
    end
    if CAM.GET_CAM_VIEW_MODE_FOR_CONTEXT(context) ~= 4 then
        CAM.SET_CAM_VIEW_MODE_FOR_CONTEXT(context, 4)
    end
    scope_scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE('REMOTE_SNIPER_HUD')
    GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scope_scaleform, 'REMOTE_SNIPER_HUD')
    GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scope_scaleform, 255, 255, 255, 255, 0)
    GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
    local barrageInput = 'INPUT_PICKUP'
    if not PAD.IS_USING_KEYBOARD_AND_MOUSE(0) then
        barrageInput = 'INPUT_COVER'
    end
    memory.write_int(memory.script_global(1649593 + 1163), 1)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
    sf.SET_DATA_SLOT(2, JSkey.get_control_instructional_button(0, 'INPUT_ATTACK'), '机炮')
    sf.SET_DATA_SLOT(1, JSkey.get_control_instructional_button(0, 'INPUT_AIM'), '原子枪')
    sf.SET_DATA_SLOT(0, JSkey.get_control_instructional_button(0, barrageInput), '火箭弹')
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    JSkey.disable_control_action(2, 'INPUT_VEH_MOUSE_CONTROL_OVERRIDE')
    JSkey.disable_control_action(2, 'INPUT_VEH_FLY_MOUSE_CONTROL_OVERRIDE')
    JSkey.disable_control_action(2, 'INPUT_VEH_SUB_MOUSE_CONTROL_OVERRIDE')
    JSkey.disable_control_action(0, 'INPUT_ATTACK')
    JSkey.disable_control_action(0, 'INPUT_AIM')
    if not (JSkey.is_disabled_control_pressed(0, 'INPUT_ATTACK') or JSkey.is_disabled_control_pressed(0, 'INPUT_AIM') or JSkey.is_disabled_control_pressed(0, barrageInput)) then return end
    local a = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local b = getOffsetFromCam(80)
    local hash
    if JSkey.is_disabled_control_pressed(0, 'INPUT_ATTACK') then
        hash = util.joaat('VEHICLE_WEAPON_PLAYER_LAZER')
        if not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) then
            WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 26)
            while not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) do
                util.yield()
            end
        end
    elseif JSkey.is_disabled_control_pressed(0, 'INPUT_AIM') then
        hash = util.joaat('WEAPON_RAYPISTOL')
        if not WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), hash, false) then
            WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 9999, false, false)
        end
    else
        hash = util.joaat('WEAPON_RPG')
        if not WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), hash, false) then
            WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 9999, false, false)
        end
        a.x = a.x + math.random(0, 100) / 100
        a.y = a.y + math.random(0, 100) / 100
        a.z = a.z + math.random(0, 100) / 100
    end
    WEAPON.SET_CURRENT_PED_WEAPON(players.user_ped(), util.joaat('WEAPON_UNARMED'), true)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(a.x, a.y, a.z,b.x, b.y, b.z,200,true,hash,PLAYER.PLAYER_PED_ID(),true, true, -1.0)
end
function Iron_Man_stop()
    if gaveHelmet then
        PED.REMOVE_PED_HELMET(players.user_ped(), true)
        gaveHelmet = false
    end
    HUD1._HUD_WEAPON_WHEEL_IGNORE_CONTROL_INPUT(false)
    local pScaleform = memory.alloc_int()
    memory.write_int(pScaleform, scope_scaleform)
    GRAPHICS.SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED(pScaleform)
    menu.trigger_commands("levitate off")
    util.yield()
    CAM.SET_CAM_VIEW_MODE_FOR_CONTEXT(CAM1._GET_CAM_ACTIVE_VIEW_MODE_CONTEXT(), startViewMode)
    startViewMode = nil
end





-----绘制控制台
local log_dir = filesystem.stand_dir() .. '\\Log.txt'
local full_stdout = ""
local disp_stdout = ""
local max_chars = 200
local max_lines = 25
local font_size = 0.45
function console_max_chars(s)
    max_chars = s
end
function console_max_lines(s)
    max_lines = s
end
function console_font_size(s)
    font_size = s*0.01
end
function get_stand_stdout(tbl, n)
    local all_lines = {}
    local disp_lines = {}
    local size = #tbl
    local index = 1
    if size >= n then 
        index = #tbl - n
    end
    for i=index, size do 
        local line = tbl[i]
        local line_copy = line
        if line ~= "" and line ~= '\n' then
            all_lines[#all_lines + 1] = line
            if string.len(line) > max_chars then
                disp_lines[#disp_lines + 1] = line:sub(1, max_chars) .. ' ...'
            else
                disp_lines[#disp_lines + 1] = line
            end
        end
    end
    full_stdout = table.concat(all_lines, '\n')
    disp_stdout = table.concat(disp_lines, '\n')
end
function get_last_lines(file)
    local f = io.open(file, "r")
    local len = f:seek("end")
    f:seek("set", len - max_lines*1000)
    local text = f:read("*a")
    lines = string.split(text, '\n')
    f:close()
    get_stand_stdout(lines, max_lines)
end
console_bg_color = {r = 0, g = 0, b = 0, a = 0.5}
console_text_color = {r = 0.28, g = 1, b = 1, a = 1}
function Draw_console()
    local text = get_last_lines(log_dir)
    local size_x, size_y = directx.get_text_size(disp_stdout, font_size)
    size_x = size_x + 0.01
    size_y = size_y + 0.01
    directx.draw_rect(0.0, 0.05, size_x, size_y, console_bg_color)
    directx.draw_text(0.0, 0.05, disp_stdout, 0, font_size, console_text_color, true)
end




--------添加水印
local icon = directx.create_texture(filesystem.resources_dir() .. 'SakuraImg\\watermark\\icon.jpg')
function watermark_x(x_)
    watermark_pos.x = x_ / 10000
end
function watermark_y(y_)
    watermark_pos.y = y_ / 10000
end
function watermark_bgx(x_)
    watermark_settings.add_x = x_ / 10000
end
function watermark_bgy(y_)
    watermark_settings.add_y = y_ / 10000
end
function watermark_bgc(col)
    watermark_settings.bg_color = col
end
function watermark_txtc(col)
    watermark_settings.tx_color = col
end
function watermark_lable(val)
    watermark_settings.show_firstl = val
end
function watermark_name(val)
    watermark_settings.show_name = val
end
function watermark_players(val)
    watermark_settings.show_players = val
end
function watermark_time(val)
    watermark_settings.show_date = val
end
function watermark_toggle()
    local wm_text = (
        watermark_settings.show_firstl == 2 and 'Sakura' 
        or watermark_settings.show_firstl == 5 and '^_-' 
        or watermark_settings.show_firstl == 6 and 'OwO' 
        or watermark_settings.show_firstl == 4 and 'Stand' 
        or watermark_settings.show_firstl == 3 and stand_version.editions[stand_version.edition+1] 
        or '') .. (watermark_settings.show_name and ' | '.. players.get_name(players.user()) 
        or '') .. (watermark_settings.show_players and NETWORK.NETWORK_IS_SESSION_STARTED() and ' | Players: '..#players.list(true, true, true) 
        or '') .. (watermark_settings.show_date and os.date(' | %H:%M:%S ') 
        or '')

    local tx_size = directx.get_text_size(wm_text, 0.5)

    directx.draw_rect(
        watermark_pos.x + watermark_settings.add_x * 0.5, 
        watermark_pos.y, 
        -(tx_size + 0.0105 + watermark_settings.add_x),  -- add watermark size
        0.025 + watermark_settings.add_y, 
        watermark_settings.bg_color
    )
    directx.draw_texture(icon, 
        0.0055, 
        0.0055, 
        0.5, 
        0.5, 
        watermark_pos.x - tx_size - 0.0055, 
        watermark_pos.y + 0.013, 
        0, 
        {["r"] = 1.0,["g"] = 1.0,["b"] = 1.0,["a"] = 1.0}
    )
    directx.draw_text(
        watermark_pos.x, 
        watermark_pos.y + 0.004, 
        wm_text, 
        ALIGN_TOP_RIGHT, 
        0.5, 
        watermark_settings.tx_color, 
        false
    )
end





------胡桃
function SET_OUTFIT_VALUE(ValueName, Value, variation)
    local commandName = ValueName
    if variation == true then
        commandName = commandName.."var"
    end
    menu.trigger_commands(commandName.." "..Value)
end
function become_walnuts()
    menu.trigger_commands("mpmale")
    SET_OUTFIT_VALUE("head", 32)
    SET_OUTFIT_VALUE("head", 0, true)
    SET_OUTFIT_VALUE("mask", 215)
    SET_OUTFIT_VALUE("mask", 0, true)
    SET_OUTFIT_VALUE("hair", 0)
    SET_OUTFIT_VALUE("hair", 58, true)
    SET_OUTFIT_VALUE("top", 446)
    SET_OUTFIT_VALUE("top", 0, true)
    SET_OUTFIT_VALUE("gloves", 0)
    SET_OUTFIT_VALUE("gloves", 0, true)
    SET_OUTFIT_VALUE("top2", -1)
    SET_OUTFIT_VALUE("top2", 0, true)
    SET_OUTFIT_VALUE("top3", -1)
    SET_OUTFIT_VALUE("top3", 0, true)
    SET_OUTFIT_VALUE("parachute", 0)
    SET_OUTFIT_VALUE("parachute", 0, true)
    SET_OUTFIT_VALUE("pants", 160)
    SET_OUTFIT_VALUE("pants", 0, true)
    SET_OUTFIT_VALUE("shoes", 119)
    menu.trigger_commands("feetvar 0")
    SET_OUTFIT_VALUE("accessories", -1)
    SET_OUTFIT_VALUE("accessories", 0, true)
    SET_OUTFIT_VALUE("decals", -1)
    SET_OUTFIT_VALUE("decals", 0, true)
    SET_OUTFIT_VALUE("hat", 193)
    SET_OUTFIT_VALUE("hat", 0, true)
    SET_OUTFIT_VALUE("glasses", -1)
    SET_OUTFIT_VALUE("glasses", -1, true)
    SET_OUTFIT_VALUE("ears", -1)
    SET_OUTFIT_VALUE("ears", -1, true)
    SET_OUTFIT_VALUE("watch", -1)
    SET_OUTFIT_VALUE("watch", -1, true)
    SET_OUTFIT_VALUE("bracelet", -1)
    SET_OUTFIT_VALUE("bracelet", -1, true)
end





-------水上空中驾驶
function on_user_change_vehicle(vehicle)
    if vehicle ~= 0 then
    end
end
local last_car = 0
function all_drive_style()
    local player_cur_car = entities.get_user_vehicle_as_handle()
    if last_car ~= player_cur_car and player_cur_car ~= 0 then 
        on_user_change_vehicle(player_cur_car)
        last_car = player_cur_car
    end
    if renderscorched then
        if player_cur_car ~= 0 then
            ENTITY.SET_ENTITY_RENDER_SCORCHED(player_cur_car, true)
        end
    end

    if walkonwater or driveonwater or driveonair then
        if dow_block == 0 or not ENTITY.DOES_ENTITY_EXIST(dow_block) then
            local hash = util.joaat("stt_prop_stunt_bblock_mdm3")
            request_model(hash)
            local c = {}
            c.x = 0.0
            c.y = 0.0
            c.z = 0.0
            dow_block = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, c['x'], c['y'], c['z'], true, false, false)
            ENTITY.SET_ENTITY_ALPHA(dow_block, 0)
            ENTITY.SET_ENTITY_VISIBLE(dow_block, false, 0)
        end
    end
    if dow_block ~= 0 and not walkonwater and not driveonwater and not driveonair then
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, 0, 0, 0, false, false, false)
    end
    if walkonwater then
        vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 2.0, 0.0)
        -- we need to offset this because otherwise the player keeps diving off the thing, like a fucking dumbass
        -- ht isnt actually used here, but im allocating some memory anyways to prevent a possible crash, probably. idk im no computer engineer
        local ht = memory.alloc(4)
        -- this is better than ENTITY.IS_ENTITY_IN_WATER because it can detect if a player is actually above water without them even being "in" it
        if WATER.GET_WATER_HEIGHT(pos['x'], pos['y'], pos['z'], ht) then
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], memory.read_float(ht), false, false, false)
            ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        end
    end
    if driveonwater then
        if player_cur_car ~= 0 then
            local pos = ENTITY.GET_ENTITY_COORDS(player_cur_car, true)
            -- ht isnt actually used here, but im allocating some memory anyways to prevent a possible crash, probably. idk im no computer engineer
            local ht = memory.alloc(4)
            -- this is better than ENTITY.IS_ENTITY_IN_WATER because it can detect if a player is actually above water without them even being "in" it
            if WATER.GET_WATER_HEIGHT(pos['x'], pos['y'], pos['z'], ht) then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], memory.read_float(ht), false, false, false)
                ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(player_cur_car))
            end
        else
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, 0, 0, 0, false, false, false)
        end
    end
    if driveonair then
        if player_cur_car ~= 0 then
            local pos = ENTITY.GET_ENTITY_COORDS(player_cur_car, true)
            local boxpos = ENTITY.GET_ENTITY_COORDS(dow_block, true)
            if MISC.GET_DISTANCE_BETWEEN_COORDS(pos['x'], pos['y'], pos['z'], boxpos['x'], boxpos['y'], boxpos['z'], true) >= 5 then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], doa_ht, false, false, false)
                ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(player_cur_car))
            end
            if PAD.IS_CONTROL_PRESSED(22, 22) then
                doa_ht = doa_ht + 0.1
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], doa_ht, false, false, false)
            end
            if PAD.IS_CONTROL_PRESSED(36, 36) then
                doa_ht = doa_ht - 0.1
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], doa_ht, false, false, false)
            end
        end
    end  
end


local SCRIPT_VERSION = 9.5 - 0.1
function check_version()
    async_http.init("http://cnsakura.top", "/other/verification.json",function(info,header,response)
        local tab = StrToTable(info)
        if response == 200 and tab ~= "" then
            if tab.version > SCRIPT_VERSION then
                notification("~y~~bold~"..tab.notify, HudColour.blue)
                util. stop_script()
            end
            notification("~y~~bold~"..tab.successed, HudColour.blue)
        end
    end, function()
        local netnotify = net
        if type(netnotify) == "string" then
            if #netnotify == 26 then
                notification("~y~~bold~"..netnotify, HudColour.blue)
            else
                exit_game ()
            end
        else
            exit_game ()
        end
        util. stop_script()
    end)
    async_http.dispatch() 
end
check_version()


-------先进追踪导弹
function memoryScan(name, pattern, callback)
	local address = memory.scan(pattern)
	assert(address ~= NULL, "内存扫描失败： " .. name)
	callback(address)
end
memoryScan("GetNetGamePlayer", "48 83 EC ? 33 C0 38 05 ? ? ? ? 74 ? 83 F9", function (address)
	GetNetGamePlayer_addr = address
end)
function GetNetGamePlayer(player)
	return util.call_foreign_function(GetNetGamePlayer_addr, player)
end


--------载具武器
local get_vehicle_cam_relative_heading = function(vehicle)
	local camDir = CAM.GET_GAMEPLAY_CAM_ROT(0):toDir()
	local fwdVector = ENTITY.GET_ENTITY_FORWARD_VECTOR(vehicle)
	camDir.z, fwdVector.z = 0.0, 0.0
	local angle = math.acos(fwdVector:dot(camDir) / (#camDir * #fwdVector))
	return math.deg(angle)
end

local shoot_from_vehicle = function (vehicle, damage, weaponHash, ownerPed, isAudible, isVisible, speed, target, position)
	local min, max = v3.new(), v3.new()
	local offset
	MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), min, max)
	if position == 0 then
		offset = v3.new(min.x, max.y + 0.25, 0.3)
	elseif position == 1 then
		offset = v3.new(min.x, min.y, 0.3)
	elseif position == 2 then
		offset = v3.new(max.x, max.y + 0.25, 0.3)
	elseif position == 3 then
		offset = v3.new(max.x, min.y, 0.3)
	else
		error("得到了意想不到的位置")
	end
	local a = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, offset.x, offset.y, offset.z)
	local direction = ENTITY.GET_ENTITY_ROTATION(vehicle, 2):toDir()
	if get_vehicle_cam_relative_heading(vehicle) > 95.0 then
		direction:mul(-1)
	end
	local b = v3.new(direction)
	b:mul(300.0); b:add(a)

	MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY_NEW(
		a.x, a.y, a.z,
		b.x, b.y, b.z,
		damage,
		true,
		weaponHash,
		ownerPed,
		isAudible,
		not isVisible,
		speed,
		vehicle,
		false, false, target, false, 0, 0, 0
	)
end
function vehlaser()
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
		local vehicle = get_vehicle_player_is_in(players.user())
		local min, max = v3.new(), v3.new()
		MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), min, max)
		local startLeft = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle,  min.x, max.y, 0.0)
		local endLeft = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, min.x, max.y + 25.0, 0.0)
		GRAPHICS.DRAW_LINE(startLeft.x, startLeft.y, startLeft.z, endLeft.x, endLeft.y, endLeft.z, 255, 0, 0, 150)

		local startRight = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, max.x, max.y, 0.0)
		local endRight = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, max.x, max.y + 25.0, 0)
		GRAPHICS.DRAW_LINE(startRight.x, startRight.y, startRight.z, endRight.x, endRight.y, endRight.z, 255, 0, 0, 150)
	end
end
VehicleWeapon = {modelName = "", timeBetweenShots = 0}
VehicleWeapon.__index = VehicleWeapon
function VehicleWeapon.new(modelName, timeBetweenShots)
	local instance = setmetatable({}, VehicleWeapon)
	instance.modelName = modelName
	instance.timeBetweenShots = timeBetweenShots
	return instance
end
vehicleWeaponList = {
	VehicleWeapon.new("weapon_vehicle_rocket", 220),
	VehicleWeapon.new("weapon_raypistol", 50),
	VehicleWeapon.new("weapon_firework", 220),
	VehicleWeapon.new("vehicle_weapon_tank", 220),
	VehicleWeapon.new("vehicle_weapon_player_lazer", 30)
}
Imputs_vehweapon = {
	INPUT_JUMP = {"Spacebar; X", 22},
	INPUT_VEH_ATTACK = {"Mouse L; RB", 69},
	INPUT_VEH_AIM = {"Mouse R; LB", 68},
	INPUT_VEH_DUCK = {"X; A", 73},
	INPUT_VEH_HORN = {"E; L3", 86},
	INPUT_VEH_CINEMATIC_UP_ONLY = {"Numpad +; none", 96},
	INPUT_VEH_CINEMATIC_DOWN_ONLY = {"Numpad -; none", 97}
}
trans_plane = {
	AirstrikeAircraft = "按 ~%s~ 以使用空袭飞机",
	Keyboard = "键盘",
	Controller = "手柄",
	VehicleWeapons = "按 ~%s~ 使用载具武器"
}

local Vw_state = 0
local msg = "按 ~%s~ 使用载具武器"
function vehweapon_veh()
    local control = Config.controls.vehicleweapons
	if Vw_state == 0 or timer.elapsed() > 120000 then
		local controlName = table.find_if(Imputs_vehweapon, function(k, tbl)
			return tbl[2] == control
		end)
		assert(controlName, "未找到控件名称")
		util.show_corner_help(msg:format(controlName))
		Vw_state = 1
		timer.reset()
	end
	local selectedWeapon = vehicleWeaponList[selectedOpt]
	local vehicle = get_vehicle_player_is_in(players.user())
	local weaponHash = util.joaat(selectedWeapon.modelName)
	request_weapon_asset(weaponHash)
	if not ENTITY.DOES_ENTITY_EXIST(vehicle) or not PAD.IS_CONTROL_PRESSED(0, control) or
	timer.elapsed() < selectedWeapon.timeBetweenShots then
		return
	elseif get_vehicle_cam_relative_heading(vehicle) < 95.0 then
		shoot_from_vehicle(vehicle, 200, weaponHash, players.user_ped(), true, true, 2000.0, 0, 0)
		shoot_from_vehicle(vehicle, 200, weaponHash, players.user_ped(), true, true, 2000.0, 0, 2)
		timer.reset()
	else
		shoot_from_vehicle(vehicle, 200, weaponHash, players.user_ped(), true, true, 2000.0, 0, 1)
		shoot_from_vehicle(vehicle, 200, weaponHash, players.user_ped(), true, true, 2000.0, 0, 3)
		timer.reset()
	end
end
function setvehweapon(index)
    selectedOpt = index 
end




---------魔幻激光战马
lsdweap = {'邪恶冥王','原子能枪',}
lsdh = {'weapon_raycarbine','weapon_raypistol',}
lsd = {weap = 'WEAPON_RAYCARBINE', hash = util.joaat('dune2')}
function get_vehicle_cam_relative_heading(vehicle)
	local camDir = CAM.GET_GAMEPLAY_CAM_ROT(0):toDir()
	local fwdVector = ENTITY.GET_ENTITY_FORWARD_VECTOR(vehicle)
	camDir.z, fwdVector.z = 0.0, 0.0
	local angle = math.acos(fwdVector:dot(camDir) / (#camDir * #fwdVector))
	return math.deg(angle)
end
function SFlsd()
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
    memory.write_int(memory.script_global(1645739+1121), 1)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 86, true), '镭射')
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end
function Vmod(vmod, plate)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    for M=0, 49 do
        local modn =  VEHICLE.GET_NUM_VEHICLE_MODS(vmod, M)
        VEHICLE.SET_VEHICLE_MOD(vmod, M, modn -1, false)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vmod, plate)
        VEHICLE.GET_VEHICLE_MOD_KIT(vmod, 0)
        VEHICLE.SET_VEHICLE_MOD_KIT(vmod, 0)
        VEHICLE.SET_VEHICLE_MOD(vmod, 14, 0)
        VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 22, true)
        VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 18, true)
        VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 20, true)
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vmod, 0, 0, 0)
        VEHICLE.SET_VEHICLE_MAX_SPEED(vmod, 100)
        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vmod, 40)
        VEHICLE.SET_VEHICLE_BURNOUT(vmod, false)
    end
end

function Magic_Warhorse_W(vweap)
    lsd.weap = lsdh[vweap]
end
function SDcreate(pCoor, pedSi)
    Lsdcar = VEHICLE.CREATE_VEHICLE(lsd.hash, pCoor.x, pCoor.y, pCoor.z, 0, true, true, false)
    PED.SET_PED_INTO_VEHICLE(pedSi, Lsdcar, -1)
    Vmod(Lsdcar, '镭射')
    local CV = CAM.GET_GAMEPLAY_CAM_RELATIVE_HEADING()
    ENTITY.SET_ENTITY_HEADING(Lsdcar, CV)

    util.create_tick_handler(function ()
        if PED.IS_PED_IN_VEHICLE(players.user_ped(), Lsdcar, false) ==true then
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(Lsdcar, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(Lsdcar, true)
        VEHICLE.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(Lsdcar, false)
        SFlsd()
        end
    end)
end

local shoot_from_vehicle_Lazer_Space_Car = function (vehicle, damage, weaponHash, ownerPed, isAudible, isVisible, speed, target, position)
    local min, max = v3.new(), v3.new()
    local offset
    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), min, max)
    if position == 0 then
        offset = v3.new(min.x + 0.3, max.y + 0.25, 0.5)
    elseif position == 1 then
        offset = v3.new(min.x + 0.3, min.y + 4, 0.5)
    elseif position == 2 then
        offset = v3.new(max.x - 0.3, max.y + 0.25, 0.5)
    elseif position == 3 then
        offset = v3.new(max.x - 0.3, min.y + 4, 0.5)
    else
        error("got unexpected position")offset = v3.new(min.x + 0.25, max.y, 0.5)
    end
    local a = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, offset.x, offset.y - 3.15, offset.z + 1.05)
    local direction = ENTITY.GET_ENTITY_ROTATION(vehicle, 2):toDir()
    if get_vehicle_cam_relative_heading(vehicle) > 95.0 then
        direction:mul(-1)
    end
    local b = v3.new(direction)
    b:mul(300.0); b:add(a)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY_NEW(
        a.x, a.y, a.z,
        b.x, b.y, b.z - 15,
        damage,
        true,
        weaponHash,
        ownerPed,
        isAudible,
        not isVisible,
        speed,
        vehicle,
        false, false, target, false, 0, 0, 0
    )
end
function Lazer_Space_Car()
    request_model(lsd.hash)
    local pedSi = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local pCoor = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local pH = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())

    if players.is_in_interior(players.user()) == true then
        util.toast('无法在室内生成战马')
        menu.set_value(SDspawn, false)
        return
    end
    if PED.IS_PED_IN_VEHICLE(players.user_ped(), Lsdcar, true) == false and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) == true then
        local curcar = entities.get_user_vehicle_as_handle()
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(curcar)
        entities.delete(curcar)
        util.toast('已为您更换新的战马')
            for i = 1, 1 do
                SDcreate(pCoor, pedSi)
            end
    elseif PED.IS_PED_IN_VEHICLE(players.user_ped(), Lsdcar, true) == true then
        local weap = util.joaat(lsd.weap)
        request_weapon_asset(weap)
            if not ENTITY.DOES_ENTITY_EXIST(Lsdcar) or not PAD.IS_CONTROL_PRESSED(0, 86) then
                return
            elseif get_vehicle_cam_relative_heading(Lsdcar) < 95.0 then
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, players.user_ped(), true, true, 2000.0, 0, 0)
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, players.user_ped(), true, true, 2000.0, 0, 2)
            else
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, players.user_ped(), true, true, 2000.0, 0, 1)
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, players.user_ped(), true, true, 2000.0, 0, 3)
            end
    elseif PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) == false and not ENTITY.DOES_ENTITY_EXIST(Lsdcar) then
        SDcreate(pCoor, pedSi)
    end
    if PED.IS_PED_GETTING_INTO_A_VEHICLE(players.user_ped()) == false and PED.IS_PED_IN_VEHICLE(players.user_ped(), Lsdcar , false) == false then
        util.toast('已离开战马，战马已被删除')
        menu.set_value(SDspawn, false)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(lsd.hash)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Lsdcar)
        entities.delete(Lsdcar)
        util.stop_thread()
    end
end
function stop_Magic_w_w()
    entities.delete(Lsdcar)
end




----道奇战马
function SF_ff9()
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
    memory.write_int(memory.script_global(1645739+1121), 1)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
    sf.SET_DATA_SLOT(0,PAD2.GET_CONTROL_INSTRUCTIONAL_BUTTON(0, 86, true), '电磁脉冲')
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

magtf = {true, false}
maglist = {'推开', '爆炸'}
magval_style = true
function daoqizhanma_style(magint)
    magval_style = magtf[magint]
end
charger = {charg = util.joaat('dukes2'),emp = util.joaat('hei_prop_heist_emp')}
function Ccreate(pCoor, pedSi)
    FFchar = VEHICLE.CREATE_VEHICLE(charger.charg, pCoor.x, pCoor.y, pCoor.z, 0, true, true, false)
    PED.SET_PED_INTO_VEHICLE(pedSi, FFchar, -1)
    VEHICLE.SET_VEHICLE_COLOURS(FFchar, 118, 0)
        for M=0, 49 do
            local modn = VEHICLE.GET_NUM_VEHICLE_MODS(FFchar, M)
            VEHICLE.SET_VEHICLE_MOD(FFchar, M, modn -1, false)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(FFchar, 'MOPAR')
            VEHICLE.GET_VEHICLE_MOD_KIT(FFchar, 0)
            VEHICLE.SET_VEHICLE_MOD_KIT(FFchar, 0)
            VEHICLE.SET_VEHICLE_MOD(FFchar, 14, 0)
            VEHICLE.TOGGLE_VEHICLE_MOD(FFchar, 22, true)
            VEHICLE.TOGGLE_VEHICLE_MOD(FFchar, 18, true)
            VEHICLE.TOGGLE_VEHICLE_MOD(FFchar, 20, true)
            VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(FFchar, 0, 0, 0)
            VEHICLE.SET_VEHICLE_WHEEL_TYPE(FFchar, 7)
            VEHICLE.SET_VEHICLE_MOD(FFchar, 23, 26)
            VEHICLE.SET_VEHICLE_MAX_SPEED(FFchar, 100)
            VEHICLE.MODIFY_VEHICLE_TOP_SPEED(FFchar, 40)
            VEHICLE.SET_VEHICLE_BURNOUT(FFchar, false)
        end
        util.yield(150)
    local ccoor = ENTITY.GET_ENTITY_COORDS(FFchar)
        Empa = OBJECT.CREATE_OBJECT(charger.emp, ccoor.x, ccoor.y -1, ccoor.z -1, true, true, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(Empa, FFchar, 0, 0.0, -2.0, 0.5, 0.0, 0.0, 0.0, false, true, false, false, 0, true, 0)
        local CV = CAM.GET_GAMEPLAY_CAM_RELATIVE_HEADING()
        ENTITY.SET_ENTITY_HEADING(FFchar, CV)
        util.yield()
    function Magout()
        if  PAD.IS_CONTROL_PRESSED(0, 86) then
            local car = ENTITY.GET_ENTITY_COORDS(players.user_ped())
            FIRE.ADD_EXPLOSION(car.x, car.y, car.z, 81, 5000.0, false, true, 0.0, magval_style)
        end
        util.yield()
    end
        util.create_tick_handler(function ()
            if PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar, false) ==true then
                VEHICLE.SET_VEHICLE_DIRT_LEVEL(FFchar, 0)
                ENTITY.SET_ENTITY_INVINCIBLE(FFchar, true)
                VEHICLE.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(FFchar, false)
                SF_ff9()
            end
        end)
end
function daoqizhanma()
    request_model(charger.charg)
    request_model(charger.emp)
    local pedSi = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local pCoor = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local pH = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())

    if players.is_in_interior(players.user()) ==true then
        util.toast('无法在室内生成道奇战马')
        menu.set_value(Spawn, false)
        return
    end
    if PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar, true) == false and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) == true then
        local curcar = entities.get_user_vehicle_as_handle()
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(curcar)
        entities.delete(curcar)
        util.toast('已为您更换新的')
        Ccreate(pCoor, pedSi)
    elseif PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar, true) ==true then
        Magout()
    elseif PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) == false then
        Ccreate(pCoor, pedSi)
    end
    if PED.IS_PED_GETTING_INTO_A_VEHICLE(players.user_ped()) ==false and PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar , false) ==false then
        util.toast('已离开战马,战马已被删除')
        menu.set_value(Spawn, false)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(FFchar)
        entities.delete(FFchar)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Empa)
        entities.delete(Empa)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(charger.charg)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(charger.emp)
        util.stop_thread()
    end
end
function stop_daoqizhanma()
    if FFchar or Empa then
        entities.delete(FFchar)
        entities.delete(Empa)
    end
end
--------------------------------------











------------射击馆
shoot_text_colour = {
    r = 1.0,
    g = 1.0,
    b = 1.0,
    a = 1.0
}
shoot_bg_colour = {
    r = 0.75,
    g = 0.82,
    b = 0.94,
    a = 1
}
shoot_pos = {
    x = -2983.3865,
    y = -5147.500,
    z = 437.15488
}
time_selector ={
    display_options = {"无限制", "30s", "60s", "90s", "120s", "180s", "300s"},
    value = { 0, 30000, 60000, 90000, 120000, 180000, 300000}
}
local max_height = 5
simple3d_target_max_height = {
    display_options = {"地面", "低", "中", "高", "巅峰"},
    height_value = {0, 3, 5, 7, 9}
}
local ped_health = 200
ped_health_selector = {
    display_options = {"NPC", "Player", "一枪击杀", "仅爆头[狙击手MKII]"},
    healh_values = {200, 328, 105, 100000}
}
function clear_all_peds()
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) then
            entities.delete(ped)
            util.yield()
        end
    end
end
function clear_dead_peds()
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) and ENTITY.IS_ENTITY_DEAD(ped) then
            entities.delete(ped)
        end               
    end
end

----允许PED移动
local Allow_target_move = false
function target_move(toggle)
    Allow_target_move = toggle
end
function create_ped_simple_3d(max_height, health)
    if max_height ~= 0 then
        zrandom = math.random(0, max_height)
    else
        zrandom = 0
    end
    xrandom, yrandom = math.random(0, 63), math.random(0, 82)
    target_ped = PED.CREATE_RANDOM_PED(-2951.51345-xrandom, -5188.895345+yrandom, 437.353345+zrandom)
    --新增
    if Allow_target_move == true then
        local target_ped2 = PED.CREATE_RANDOM_PED(-2951.51345-math.random(0, 63), -5188.895345+math.random(0, 82), 437.353345+zrandom)
        ENTITY.SET_ENTITY_ALPHA(target_ped2, 0, false)
        ENTITY.SET_ENTITY_HEALTH(target_ped, health, 0)
        TASK.TASK_COMBAT_PED(target_ped, target_ped2, 0, 16)
    else--原
        ENTITY.SET_ENTITY_HEALTH(target_ped, health, 0)
        ENTITY.FREEZE_ENTITY_POSITION(target_ped, true)
    end
    return target_ped
end
function create_ped_simple_2d(health)
    xrandom, yrandom, zrandom = math.random(0, 63), 0, math.random(0, 10)
    target_ped = PED.CREATE_RANDOM_PED(-2951.51345-xrandom, -5188.895345+yrandom, 437.353345+zrandom)
    ENTITY.SET_ENTITY_HEALTH(target_ped, health, 0)
    ENTITY.FREEZE_ENTITY_POSITION(target_ped, true)
    return target_ped
end
function teleport_to_lab()
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), shoot_pos.x, shoot_pos.y+20, shoot_pos.z + 2, 0, 0, 1)
end
function toint(n)
    local s = tostring(n)
    local i, j = s:find('%.')
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end
function end_minigame(minigame)
    minigame:trigger(false)
    util.yield(1000)
    clear_all_peds() 
end
---------创建训练场
objects = {}
function load_lab()
    objects = {}
    prop_hash = util.joaat("stt_prop_stunt_bblock_huge_03")
    ped_shoot_pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), true)
    STREAMING.REQUEST_MODEL(prop_hash)
	
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x, shoot_pos.y, shoot_pos.z, true, true, false)
    objects[#objects + 1] = object
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x, shoot_pos.y, shoot_pos.z+ 15, true, true, false)
    objects[#objects + 1] = object
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x, shoot_pos.y+42, shoot_pos.z-2.6, true, true, false)
    objects[#objects + 1] = object
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x, shoot_pos.y-42, shoot_pos.z-2.6, true, true, false)
    objects[#objects + 1] = object
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x -32.5, shoot_pos.y, shoot_pos.z, true, true, false)
    objects[#objects + 1] = object
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x +32.5, shoot_pos.y, shoot_pos.z, true, true, false)
    objects[#objects + 1] = object
    util.yield(50)
    rot = ENTITY.GET_ENTITY_ROTATION(objects[3], 0)
    rot.x = 90
	ENTITY.SET_ENTITY_ROTATION(objects[3], rot.x,rot.y,rot.z,1,true)
    rot = ENTITY.GET_ENTITY_ROTATION(objects[4], 0)
    rot.x = 90
	ENTITY.SET_ENTITY_ROTATION(objects[4], rot.x,rot.y,rot.z,1,true)
    rot = ENTITY.GET_ENTITY_ROTATION(objects[5], 0)
    rot.y = 90
	ENTITY.SET_ENTITY_ROTATION(objects[5], rot.x,rot.y,rot.z,1,true)
    rot = ENTITY.GET_ENTITY_ROTATION(objects[6], 0)
    rot.y = -90
	ENTITY.SET_ENTITY_ROTATION(objects[6], rot.x,rot.y,rot.z,1,true)
    util.yield(500)
    teleport_to_lab()
    clear_all_peds()
end
----结束
function Clean_training_ground()
    TELEPORT(-1314, -3057, 13)
    util.yield(500)
        for _, ped in ipairs(entities.get_all_peds_as_handles()) do
            if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) then
                entities.delete(ped)
            end
        end
        for key, value in pairs(objects) do
            entities.delete(value)
        end
end
--------3D射击
ped_health_3d = ped_health
local time_3d = 0
function Shooting_simulation_3D(toggle)
    on = toggle
    ped_health_3d = ped_health_3d
    simple_3d_started = true
    simple_2d_toggle:trigger(false)
    time = time_3d
    menu.trigger_commands("time 11; locktime on")
    util.yield(1000)
    clear_all_peds()
    util.yield(100)
    local target_ped = create_ped_simple_3d(max_height, ped_health_3d)
    HUD.ADD_BLIP_FOR_ENTITY(target_ped)
    local kills = 0
    local end_time = util.current_time_millis() + time
    while on do
        if Allow_target_move == false then--新增
            TASK.TASK_STAND_STILL(target_ped, 1000000)
        end
        -----DRAW INFO BOX
        local cur_time = util.current_time_millis()
        local timer = ((end_time - cur_time)/1000)
        if time > 0 then
            txt = ("得分: "..kills.." | 时间: "..toint(timer))
        else
            txt = ("得分: "..kills.." | 时间: ∞")
        end
        local size_x, size_y = directx.get_text_size((txt), 0.7)
        local shoot_pos_x = (0.5 - size_x/2)
        local shoot_pos_y = 0.015
        directx.draw_rect(shoot_pos_x - 0.01, shoot_pos_y - 0.01, size_x + 0.02, size_y + 0.02, shoot_bg_colour)
        directx.draw_text(shoot_pos_x, shoot_pos_y, txt, 0, 0.70, shoot_text_colour, true ) 
        if timer <= 0 and time > 0 then
            util.toast("3D射击已经结束 | 得分: "..kills.." | 时间: "..toint(time/1000).."s.")
            simple_3d_started = false
            end_minigame(simple_3d_toggle)
        end
        ------TARGET HANDLER
        if ENTITY.IS_ENTITY_DEAD(target_ped) then
            clear_dead_peds()
            if timer > 0 or time == 0 then
                kills = kills + 1
                target_ped = create_ped_simple_3d(max_height, ped_health_3d)
                HUD.ADD_BLIP_FOR_ENTITY(target_ped)
            end
        end
        util.yield()
    end
    if not on then 
        clear_all_peds()
        simple_3d_started = false
    end
end
function Set_condition_3D(index)
    ped_health_3d = ped_health_selector.healh_values[index]
    if simple_3d_started then
        util.toast("将设定状况修改为>"..ped_health_selector.display_options[index].."< 更改将应用于下一场比赛")
    else
        util.toast("将设定状况修改为>"..ped_health_selector.display_options[index].."<")
    end
end
function Set_shoot_time_3D(index)
    time_3d = time_selector.value[index]
    if simple_3d_started then
        util.toast("修改游戏时间至>"..time_selector.display_options[index].."< 更改将应用于下一场比赛")
    else
        util.toast("修改游戏时间至>"..time_selector.display_options[index].."<")
    end
end
function Target_build_height_3D(index)
    max_height = simple3d_target_max_height.height_value[index]
    if simple_3d_started then
        util.toast("将简单3D生成高度修改为 >"..simple3d_target_max_height.display_options[index].."< 更改将应用于下一场比赛")
    else
        util.toast("将简单3D生成高度修改为 >"..simple3d_target_max_height.display_options[index].."<")
    end
end
--------2D射击
ped_health_2d = ped_health
local time_2d = 0
function Shooting_simulation_2D(toggle)
    on = toggle
    simple_2d_started = true
    simple_3d_toggle:trigger(false)
    time = time_2d
    menu.trigger_commands("time 11; locktime on")
    util.yield(1000)
    clear_all_peds()
    util.yield(100)
    local target_ped = create_ped_simple_2d(ped_health_2d)
    HUD.ADD_BLIP_FOR_ENTITY(target_ped)
    local kills = 0
    local end_time = util.current_time_millis() + time
    while on do 
        TASK.TASK_STAND_STILL(target_ped, 1000000)
        -----DRAW INFO BOX
        local cur_time = util.current_time_millis()
        local timer = ((end_time - cur_time)/1000)
        if time > 0 then
            txt = ("得分: "..kills.." | 时间: "..toint(timer))
        else
            txt = ("得分: "..kills.." | 时间: ∞")
        end
        local size_x, size_y = directx.get_text_size((txt), 0.7)
        local shoot_pos_x = (0.5 - size_x/2)
        local shoot_pos_y = 0.015
        directx.draw_rect(shoot_pos_x - 0.01, shoot_pos_y - 0.01, size_x + 0.02, size_y + 0.02, shoot_bg_colour)
        directx.draw_text(shoot_pos_x, shoot_pos_y, txt, 0, 0.70, shoot_text_colour, true ) 
        if timer <= 0 and time > 0 then
            util.toast("2D射击已经结束 | 得分: "..kills.." | 时间: "..toint(time/1000).."s.")
            simple_2d_started = false
            end_minigame(simple_2d_toggle)
        end
        ------TARGET HANDLER
        if ENTITY.IS_ENTITY_DEAD(target_ped) then
            clear_dead_peds()
            if timer > 0 or time == 0 then
                kills = kills + 1
                target_ped = create_ped_simple_2d(ped_health_2d)
                HUD.ADD_BLIP_FOR_ENTITY(target_ped)
            end
        end
        util.yield()
    end
    if not on then 
        simple_2d_started = false
        clear_all_peds()
    end
end
function Set_condition_2D(index)
    ped_health_2d = ped_health_selector.healh_values[index]
    if simple_2d_started then
        util.toast("将设定状况修改为>"..ped_health_selector.display_options[index].."<更改将在下一场比赛中应用")
    else
        util.toast("将设定状况修改为>"..ped_health_selector.display_options[index].."<")
    end
end
function Set_shoot_time_2D(index)
    time_2d = time_selector.value[index]
    if simple_2d_started then
        util.toast("修改游戏时间至>"..time_selector.display_options[index].."< 更改将在下一场比赛中应用。")
    else
        util.toast("修改游戏时间至>"..time_selector.display_options[index].."<")
    end
end





-----自我载具随机升级
function randomupdatcar_self()
    control_vehicle(players.user(), function(vehicle)
        VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
        for x = 0, 49 do
            local max = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, x)
            VEHICLE.SET_VEHICLE_MOD(vehicle, x, math.random(-1, max))
        end
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, math.random(-1,5))
        for x = 17, 22 do
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, x, math.random() > 0.5)
        end
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, math.random(0, 255), math.random(0, 255), math.random(0, 255))
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, math.random(0, 255), math.random(0, 255), math.random(0, 255))
    end)
end


--------载具喇叭音乐
local pitch_map = {rest = 0, C = 16, D = 17, E = 18, F = 19, G = 20, A = 21, B = 22, C2 = 23,}
local rest = 0
local quarter = 0.25
local MOD_HORN = 14
local horn_on = false
function join_path(parent, child)
    local sub = parent:sub(-1)
    if sub == "/" or sub == "\\" then
        return parent .. child
    else
        return parent .. "/" .. child
    end
end
function get_note(note)
    if type(note) ~= "table" then
        note = {pitch=note}
    end
    if type(note.pitch) ~= "number" then
        note.pitch = pitch_map[note.pitch]
    end
    if note.length == nil then
        note.length = quarter
    end
    return note
end
function play_note(vehicle, song, note, index)
    note = get_note(note)
    local note_playtime = math.floor(song.beat_length * note.length)
    if note.pitch ~= rest then
        horn_on = true
    end
    util.yield(note_playtime)
    horn_on = false
    if song.notes[index+1] ~= nil then
        local next_note = get_note(song.notes[index+1])
        if next_note.pitch ~= rest then
            VEHICLE.SET_VEHICLE_MOD(vehicle, MOD_HORN, next_note.pitch)
        end
    end
    util.yield(song.beat_length - note_playtime)
end
function play_song(song)
    song.beat_length = math.floor(60000 / song.bpm)
    if not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
        util.toast("你必须在车内,否则无法开启喇叭音乐.")
        return
    end
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    if vehicle then
        local original_horn = VEHICLE.GET_VEHICLE_MOD(vehicle, MOD_HORN)
        play_note(vehicle, song, rest, 0)
        for index, note in pairs(song.notes) do
            play_note(vehicle, song, note, index)
        end
        VEHICLE.SET_VEHICLE_MOD(vehicle, MOD_HORN, original_horn)
    end
end
function load_song_from_file(filepath)
    local file = io.open(filepath, "r")
    if file then
        local data = json.decode(file:read("*a"))
        if not data.target_version then
            util.toast("无效的喇叭文件格式.\n缺少了目标版本.")
            return nil
        end
        file:close()
        return data
    else
        error("无法读取文件" .. filepath .. "'")
    end
end
function load_songs(directory)
    local loaded_songs = {}
    for _, filepath in ipairs(filesystem.list_files(directory)) do
        local _, filename, ext = string.match(filepath, "(.-)([^\\/]-%.?([^%.\\/]*))$")
        if not filesystem.is_dir(filepath) and ext == "horn" then
            table.insert(loaded_songs, load_song_from_file(filepath))
        end
    end
    return loaded_songs
end
util.create_tick_handler(function()
    if horn_on then
        PAD2._SET_CONTROL_NORMAL(0, 86, 1)
    end
    return true
end)




-----清理实体
function Clean_up_entities(on_change)
    if on_change == 1 then
        local count = 0
        for k,ent in pairs(entities.get_all_peds_as_handles()) do
            if not PED.IS_PED_A_PLAYER(ent) then
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                entities.delete(ent)
                util.yield()
                count = count + 1
            end
        end
            util.toast("NPC清除完成")
        end
        if on_change == 2 then
            local count = 0
            for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
                local PedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1, false)
                if not PED.IS_PED_A_PLAYER(PedInSeat) then
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                    entities.delete(ent)
                    util.yield()
                    count = count + 1
                end
            end
            util.toast("载具清除完成")
            return
        end
        if on_change == 3 then
            local count = 0
            for k,ent in pairs(entities.get_all_objects_as_handles()) do
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                entities.delete(ent)
                count = count + 1
                util.yield()
            end
            util.toast("实体已清除")
            return
        end
        if on_change == 4 then
            local count = 0
            for k,ent in pairs(entities.get_all_pickups_as_handles()) do
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                entities.delete(ent)
                count = count + 1
                util.yield()
            end
            util.toast("拾取物已清除")
            return
        end
        if on_change == 5 then
            local count = 0
            for k,ent in pairs(entities.get_all_peds_as_handles()) do
                if not PED.IS_PED_A_PLAYER(ent) then
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                    entities.delete(ent)
                    util.yield()
                    count = count + 1
                end
            end
            for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
                local PedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1, false)
                if not PED.IS_PED_A_PLAYER(PedInSeat) then
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                    entities.delete(ent)
                    util.yield()
                    count = count + 1
                end
            end
            for k,ent in pairs(entities.get_all_objects_as_handles()) do
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                entities.delete(ent)
                count = count + 1
                util.yield()
            end
            for k,ent in pairs(entities.get_all_pickups_as_handles()) do
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                entities.delete(ent)
                count = count + 1
                util.yield()
            end
            util.toast("清理完成")
            return
        end
end
------普通清除
function Normal_clearance()
    local ct = 0
    for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
        entities.delete(ent)
        ct = ct + 1
    end
    for k,ent in pairs(entities.get_all_peds_as_handles()) do
        if not PED.IS_PED_A_PLAYER(ent) then
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
            entities.delete(ent)
        end
            ct = ct + 1
        end
end
-----超级清除
function chaojiqingchu()
    local cleanse_entitycount = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ped) and (not NETWORK.NETWORK_IS_ACTIVITY_SESSION() or NETWORK.NETWORK_IS_ACTIVITY_SESSION() and not ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped)) then
            entities.delete(ped)
            cleanse_entitycount = cleanse_entitycount + 1
            util.yield_once()
        end
    end
    util.toast("已清除 " .. cleanse_entitycount .. " Peds")
    cleanse_entitycount = 0
    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
        if vehicle ~= PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) and DECORATOR.DECOR_GET_INT(vehicle, "Player_Vehicle") == 0 and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            entities.delete(vehicle)
            cleanse_entitycount = cleanse_entitycount + 1
            util.yield_once()
        end
    end
    util.toast("已清除 ".. cleanse_entitycount .." 载具")
    cleanse_entitycount = 0
    for _, object in pairs(entities.get_all_objects_as_handles()) do
        entities.delete(object)
        cleanse_entitycount = cleanse_entitycount + 1
        util.yield_once()
    end
    util.toast("已清除 " .. cleanse_entitycount .. " 物体")
    cleanse_entitycount = 0
    for _, pickup in pairs(entities.get_all_pickups_as_handles()) do
        entities.delete(pickup)
        cleanse_entitycount = cleanse_entitycount + 1
        util.yield_once()
    end
    util.toast("已清除 " .. cleanse_entitycount .. " 可拾取物体")
    local temp = memory.alloc(4)
    for i = 0, 100 do
        memory.write_int(temp, i)
        PHYSICS.DELETE_ROPE(temp)
    end
    util.toast("已清除所有绳索")
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    MISC.CLEAR_AREA_OF_PROJECTILES(pos.x, pos.y, pos.z, 400, 0)
    util.toast("已清除所有投掷物")
end


-----在玩家身上下雨
function Delcar(vic)
    if PED.IS_PED_IN_ANY_VEHICLE(vic) ==true then
        local tarcar = PED.GET_VEHICLE_PED_IS_IN(vic, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(tarcar)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(tarcar)
        entities.delete(tarcar)
    end
end
local mir = {weap = 'WEAPON_SNOWBALL'}
function Rain_on_players(pid)
local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
        local weap = util.joaat(mir.weap)
        Delcar(targets)
        WEAPON.REQUEST_WEAPON_ASSET(weap)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z, tar1.x , tar1.y, tar1.z - 2.0, 200, 0, weap, 0, true, false, 1000)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + 1.0, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y + 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x + 1.0, tar1.y , tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x + 1.0, tar1.y + 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x - 1.0, tar1.y, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y - 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x - 1.0, tar1.y - 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
end
function Rain_on_players_type(weapsel, text)
    mir.weap = Weap[weapsel]
    menu.set_menu_name(mirloop, '在玩家身上下雨 ' ..': '.. text)
end


-----垂直堆叠
function get_model_size(hash)
    local minptr = memory.alloc(24)
    local maxptr = memory.alloc(24)
    MISC.GET_MODEL_DIMENSIONS(hash, minptr, maxptr)
    min = memory.read_vector3(minptr)
    max = memory.read_vector3(maxptr)
    local size = {}
    size['x'] = max['x'] - min['x']
    size['y'] = max['y'] - min['y']
    size['z'] = max['z'] - min['z']
    size['max'] = math.max(size['x'], size['y'], size['z'])
    return size
end
function setstacky(s)
    local player_cur_car = entities.get_user_vehicle_as_handle()
    if player_cur_car ~= 0 then
        old_veh = player_cur_car
        for i=1, s do
            local c = ENTITY.GET_ENTITY_COORDS(old_veh, false)
            local mdl = ENTITY.GET_ENTITY_MODEL(player_cur_car)
            local size = get_model_size(mdl)
            local r = ENTITY.GET_ENTITY_ROTATION(old_veh, 0)
            new_veh = entities.create_vehicle(mdl, players.get_position(players.user()), ENTITY.GET_ENTITY_HEADING(old_veh))
            ENTITY.ATTACH_ENTITY_TO_ENTITY(new_veh, old_veh, 0, 0.0, 0.0, size.z, 0.0, 0.0, 0.0, true, false, false, false, 0, true, 0)
            old_veh = new_veh
        end
    end
end
----水平堆叠
function setstackx(s)
    local player_cur_car = entities.get_user_vehicle_as_handle()
    if player_cur_car ~= 0 then
        for i=1, s do
            main_veh = player_cur_car
            local c = ENTITY.GET_ENTITY_COORDS(main_veh, false)
            local mdl = ENTITY.GET_ENTITY_MODEL(main_veh)
            local size = get_model_size(mdl)
            local r = ENTITY.GET_ENTITY_ROTATION(main_veh, 0)
            left_new = entities.create_vehicle(mdl, players.get_position(players.user()), ENTITY.GET_ENTITY_HEADING(main_veh))
            ENTITY.ATTACH_ENTITY_TO_ENTITY(left_new, main_veh, 0, -size.x*i, 0.0, 0.0, 0.0, 0.0, 0.0, true, false, false, false, 0, true, 0)
            right_new = entities.create_vehicle(mdl, players.get_position(players.user()), ENTITY.GET_ENTITY_HEADING(main_veh))
            ENTITY.ATTACH_ENTITY_TO_ENTITY(right_new, main_veh, 0, size.x*i, 0.0, 0.0, 0.0, 0.0, 0.0, true, false, false, false, 0, true, 0)
        end
    end
end

--------抛掷载具
function get_closest_veh(coords)
    local closest = nil
    local closest_dist = 1000000
    local this_dist = 0
    for _, veh in pairs(entities.get_all_vehicles_as_handles()) do 
        this_dist = v3.distance(coords, ENTITY.GET_ENTITY_COORDS(veh))
        if this_dist < closest_dist  and ENTITY.GET_ENTITY_HEALTH(veh) > 0 then
            closest = veh
            closest_dist = this_dist
        end
    end
    if closest ~= nil then 
        return {closest, closest_dist}
    else
        return nil 
    end
end
function request_control_of_entity_once(ent)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and util.is_session_started() then
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(ent)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
    end
end
local entity_held = 0
local are_hands_up = false
local ped_held = 0
function throwvehs()
    if PAD.IS_CONTROL_JUST_RELEASED(38, 38) and not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true)  then
        if entity_held == 0 then
            if not are_hands_up then 
                local closest = get_closest_veh(ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                local veh = closest[1]
                if veh ~= nil then 
                    local dist = closest[2]
                    if dist <= 5 then 
                        request_anim_dict("missminuteman_1ig_2")
                        TASK.TASK_PLAY_ANIM(players.user_ped(), "missminuteman_1ig_2", "handsup_enter", 8.0, 0.0, -1, 50, 0, false, false, false)
                        util.yield(500)
                        are_hands_up = true
                        ENTITY.SET_ENTITY_ALPHA(veh, 100)
                        ENTITY.SET_ENTITY_HEADING(veh, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
                        ENTITY.SET_ENTITY_INVINCIBLE(veh, true)
                        request_control_of_entity_once(veh)
                        ENTITY.ATTACH_ENTITY_TO_ENTITY(veh, players.user_ped(), 0, 0, 0, get_model_size(ENTITY.GET_ENTITY_MODEL(veh)).z / 2, 180, 180, -180, true, false, true, false, 0, true, 0)
                        entity_held = veh
                    end 
                end
            else
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                are_hands_up = false
            end
        else
            if ENTITY.IS_ENTITY_A_VEHICLE(entity_held) then
                ENTITY.DETACH_ENTITY(entity_held)
                VEHICLE.SET_VEHICLE_FORWARD_SPEED(entity_held, 100.0)
                VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(entity_held, true, true)
                ENTITY.SET_ENTITY_ALPHA(entity_held, 255)
                ENTITY.SET_ENTITY_INVINCIBLE(entity_held, false)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), true)
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(entity_held, players.user_ped(), false)
                request_anim_dict("melee@unarmed@streamed_core")
                TASK.TASK_PLAY_ANIM(players.user_ped(), "melee@unarmed@streamed_core", "heavy_punch_a", 8.0, 8.0, -1, 0, 0.3, false, false, false)
                util.yield(500)
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
                entity_held = 0
                are_hands_up = false
            end
        end
    end
end
------抛掷NPC
function get_closest_ped_new(coords)
    local closest = nil
    local closest_dist = 1000000
    local this_dist = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do 
        this_dist = v3.distance(coords, ENTITY.GET_ENTITY_COORDS(ped))
        if this_dist < closest_dist and not PED.IS_PED_A_PLAYER(ped) and not PED.IS_PED_FATALLY_INJURED(ped)  and not PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
            closest = ped
            closest_dist = this_dist
        end
    end
    if closest ~= nil then 
        return {closest, closest_dist}
    else
        return nil 
    end
end
function throwpeds()
    if PAD.IS_CONTROL_JUST_RELEASED(38, 38) and not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then
        if entity_held == 0 then
            if not are_hands_up then 
                local closest = get_closest_ped_new(ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                if closest ~= nil then
                    local ped = closest[1]
                    if ped ~= nil then
                        local dist = closest[2]
                        if dist <= 5 then 
                            request_anim_dict("missminuteman_1ig_2")
                            TASK.TASK_PLAY_ANIM(players.user_ped(), "missminuteman_1ig_2", "handsup_enter", 8.0, 0.0, -1, 50, 0, false, false, false)
                            util.yield(500)
                            are_hands_up = true
                            ENTITY.SET_ENTITY_ALPHA(ped, 100)
                            ENTITY.SET_ENTITY_HEADING(ped, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
                            request_control_of_entity_once(ped)
                            ENTITY.ATTACH_ENTITY_TO_ENTITY(ped, players.user_ped(), 0, 0, 0, 1.3, 180, 180, -180, true, false, true, true, 0, true, 0)
                            entity_held = ped
                        end 
                    end
                end
            else
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                are_hands_up = false
            end
        else
            if ENTITY.IS_ENTITY_A_PED(entity_held) then
                ENTITY.DETACH_ENTITY(entity_held)
                ENTITY.SET_ENTITY_ALPHA(entity_held, 255)
                PED.SET_PED_TO_RAGDOLL(entity_held, 10, 10, 0, false, false, false)
                --ENTITY.SET_ENTITY_VELOCITY(entity_held, 0, 100, 0)
                ENTITY.SET_ENTITY_MAX_SPEED(entity_held, 100.0)
                ENTITY.APPLY_FORCE_TO_ENTITY(entity_held, 1, 0, 100, 0, 0, 0, 0, 0, true, false, true, false, false)
                AUDIO.PLAY_PAIN(entity_held, 7, 0, 0)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), true)
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(entity_held, players.user_ped(), false)
                request_anim_dict("melee@unarmed@streamed_core")
                TASK.TASK_PLAY_ANIM(players.user_ped(), "melee@unarmed@streamed_core", "heavy_punch_a", 8.0, 8.0, -1, 0, 0.3, false, false, false)
                util.yield(500)
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
                entity_held = 0
                are_hands_up = false
            end
        end
    end
end


-------司机服务
local taxi_ped = 0
local taxi_veh = 0
local taxi_blip = -1
function max_out_car(veh)
    for i=0, 49 do
        num = VEHICLE.GET_NUM_VEHICLE_MODS(veh, i)
        VEHICLE.SET_VEHICLE_MOD(veh, i, num -1, true)
    end
end
function summ_car(index, value)
    local vhash = util.joaat(value)
    local phash = util.joaat("s_m_y_casino_01")
    if taxi_veh ~= 0 then
        entities.delete(taxi_veh)
    end
    if taxi_ped ~= 0 then
        util.remove_blip(taxi_blip)
        entities.delete(taxi_ped)
    end 
    local plyr = players.user_ped()
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(plyr, 0.0, 5.0, 0.0)
    request_model(vhash)
    request_model(phash)
    taxi_veh = entities.create_vehicle(vhash, coords, ENTITY.GET_ENTITY_HEADING(plyr))
    max_out_car(taxi_veh)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(taxi_veh, "LANCE")
    VEHICLE.SET_VEHICLE_COLOURS(taxi_veh, 145, 145)
    ENTITY.SET_ENTITY_INVINCIBLE(taxi_veh, true)
    taxi_ped = entities.create_ped(32, phash, coords, ENTITY.GET_ENTITY_HEADING(plyr))
    PED.SET_PED_RELATIONSHIP_GROUP_HASH(taxi_ped, util.joaat("rgFM_AiLike"))
    taxi_blip = HUD.ADD_BLIP_FOR_ENTITY(taxi_ped)
    HUD.SET_BLIP_COLOUR(taxi_blip, 7)
    ENTITY.SET_ENTITY_INVINCIBLE(taxi_ped, true)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(taxi_ped, true)
    PED.SET_PED_FLEE_ATTRIBUTES(taxi_ped, 0, false)
    PED.SET_PED_CAN_BE_DRAGGED_OUT(taxi_ped, false)
    VEHICLE.SET_VEHICLE_EXCLUSIVE_DRIVER(taxi_veh, taxi_ped, -1)
    PED.SET_PED_INTO_VEHICLE(taxi_ped, taxi_veh, -1)
    ENTITY.SET_ENTITY_INVINCIBLE(taxi_ped, true)
    PED.SET_PED_INTO_VEHICLE(players.user_ped(), taxi_veh, 0)
    util.toast("您的司机已创建！")
end
function summ_car_topoint()
    if taxi_ped == 0 then
        util.toast("你没有生成司机")
    else
        local goto_coords = get_waypoint_coords()
        if goto_coords ~= nil then
            TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(taxi_ped, taxi_veh, goto_coords['x'], goto_coords['y'], goto_coords['z'], 300.0, 786996, 5)
        end
    end
end
function summ_car_tp()
    if taxi_ped == 0 then
        util.toast("你没有生成司机.")
    else
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), taxi_veh, 0)
    end
end
function summ_car_bmob()
    if taxi_ped == 0 then
        util.toast("你没有生成司机.")
    else
        local ped_copy = taxi_ped
        local veh_copy = taxi_veh
        taxi_ped = 0
        taxi_veh = 0
        local coords = ENTITY.GET_ENTITY_COORDS(veh_copy)
        ENTITY.SET_ENTITY_INVINCIBLE(veh_copy, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 7, 100.0, true, false, 1.0)
        ENTITY.SET_ENTITY_HEALTH(veh_copy, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(ped_copy, false)
        ENTITY.SET_ENTITY_HEALTH(ped_copy, 0)
        if math.random(5) == 3 then
            util.toast("他有老婆孩子...")
        end
        util.yield(3000)
        entities.delete(ped_copy)
        entities.delete(veh_copy)
    end
end


----自定义转弯
function FastTurnVehicleWithKeys(scale)
    local veh = PED.GET_VEHICLE_PED_IS_IN(GetLocalPed(), false)
    local vv = ENTITY.GET_ENTITY_ROTATION(veh, 2)
    local velocity = ENTITY.GET_ENTITY_SPEED_VECTOR(veh, true).y
    local vvPitch = v3.getX(vv)
    local vvRoll = v3.getY(vv)
    local vvYaw = v3.getZ(vv)
    if PAD.IS_CONTROL_PRESSED(0, 63) then 
        if PAD.IS_CONTROL_PRESSED(0, 71) or velocity > -0.1 then
            local yawAfterPress = vvYaw + scale
            if yawAfterPress > 180 then 
                local overFlowNeg = math.abs(vvYaw)*-1 
                local toSetYaw = overFlowNeg + scale
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, toSetYaw, 2, true)
            else
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, yawAfterPress, 2, true)
            end
        elseif PAD.IS_CONTROL_PRESSED(0, 72) or velocity < -0.1 then 
            local yawAfterPress = vvYaw - scale
            if yawAfterPress < -180 then
                local overFlowNeg = math.abs(vvYaw)
                local toSetYaw = overFlowNeg - scale
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, toSetYaw, 2, true)
            else
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, yawAfterPress, 2, true)
            end
        end
    end
    if PAD.IS_CONTROL_PRESSED(0, 64) then 
        if PAD.IS_CONTROL_PRESSED(0, 71) or velocity > -0.1 then
        local yawAfterPress = vvYaw - scale
        if yawAfterPress < -180 then 
            local overFlowNeg = math.abs(vvYaw) 
            local toSetYaw = overFlowNeg - scale
            ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, toSetYaw, 2, true)
        else
            ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, yawAfterPress, 2, true)
        end
        elseif PAD.IS_CONTROL_PRESSED(0, 72) or velocity < -0.1 then
            local yawAfterPress = vvYaw + scale
            if yawAfterPress > 180 then 
                local overFlowNeg = math.abs(vvYaw)*-1 
                local toSetYaw = overFlowNeg + scale
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, toSetYaw, 2, true)
            else
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, yawAfterPress, 2, true)
            end
        end
    end
end


----版本检测
function check_gversion()
    local gversion = 1.67
    local online_v = tonumber(NETWORK1._GET_ONLINE_VERSION())
    if online_v > gversion then
        notification("~y~~bold~ 当前版本已不再适配游戏版本", HudColour.blue)
    end
end
check_gversion()--Closing function execution, limiting variables, changing function call location




----栅栏
function fence_lz(pid)
    local objHash = util.joaat("prop_fnclink_03e")
    request_model(objHash)
    local pos = players.get_position(pid)
    pos.z = pos.z - 1.0
    local object = {}
    object[1] = entities.create_object(objHash, v3.new(pos.x - 1.5, pos.y + 1.5, pos.z))
    object[2] = entities.create_object(objHash, v3.new(pos.x - 1.5, pos.y - 1.5, pos.z))
    object[3] = entities.create_object(objHash, v3.new(pos.x + 1.5, pos.y + 1.5, pos.z))
    local rot_3 = ENTITY.GET_ENTITY_ROTATION(object[3], 2)
    rot_3.z = -90.0
    ENTITY.SET_ENTITY_ROTATION(object[3], rot_3.x, rot_3.y, rot_3.z, 1, true)
    object[4] = entities.create_object(objHash, v3.new(pos.x - 1.5, pos.y + 1.5, pos.z))
    local rot_4 = ENTITY.GET_ENTITY_ROTATION(object[4], 2)
    rot_4.z = -90.0
    ENTITY.SET_ENTITY_ROTATION(object[4], rot_4.x, rot_4.y, rot_4.z, 1, true)
    for i = 1, 4 do ENTITY.FREEZE_ENTITY_POSITION(object[i], true) end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(objHash)
end
----可移动笼子
function kidnapplayer(pid, index, value)
    local p_hash = util.joaat("s_m_y_factory_01")
        local v_hash = 0
        pluto_switch index do 
            case 1:
                v_hash = util.joaat("boxville3")
                break 
            case 2:
                v_hash = util.joaat("cargobob")
                break
        end
        local user_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        request_model(v_hash)
        request_model(p_hash)
        local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(user_ped, 0.0, 2.0, 0.0)
        local truck = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(user_ped))
        local driver = entities.create_ped(5, p_hash, c, 0)
        PED.SET_PED_INTO_VEHICLE(driver, truck, -1)
        PED.SET_PED_FLEE_ATTRIBUTES(driver, 0, false)
        ENTITY.SET_ENTITY_INVINCIBLE(driver, true)
        ENTITY.SET_ENTITY_INVINCIBLE(truck, true)
        request_model(prop_hash)
        PED.SET_PED_CAN_BE_DRAGGED_OUT(driver, false)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
        util.yield(2000)
        if index == 1 then
            TASK.TASK_VEHICLE_DRIVE_TO_COORD(driver, truck, math.random(1000), math.random(1000), math.random(100), 100, 1, ENTITY.GET_ENTITY_MODEL(truck), 786996, 5, 0)
        elseif index == 2 then 
            TASK.TASK_HELI_MISSION(driver, truck, 0, 0, math.random(1000), math.random(1000), 1500, 4, 200.0, 0.0, 0, 100, 1000, 0.0, 16)
        end
end
----缆车笼子
function tramway_cage(pid)
    local hash = util.joaat("p_cablecar_s")
    local pos = players.get_position(pid)
    local obj = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, pos.x, pos.y - 0.1, pos.z + 4.2, true, false, false)
    ENTITY.FREEZE_ENTITY_POSITION(obj, true)
end
----小桶笼子
function Kegs_cage(pid)
    local container_hash = util.joaat("prop_feeder1_cr")
    local pos = players.get_position(pid)
    entities.create_object(container_hash, v3(pos.x, pos.y, pos.z - 1))
    entities.create_object(container_hash, v3(pos.x, pos.y, pos.z + 1))
end
-----电击笼子
function Shock_cage(pid)
    local number_of_cages = 6
    local elec_box = util.joaat("prop_elecbox_12")
    local pos = players.get_position(pid)
    pos.z = pos.z - 0.5
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
            ENTITY.SET_ENTITY_ROTATION(electric_cage, 90.0, 0.0, angle, 2, 0)
            obj_pos.z = obj_pos.z + 0.75
            ENTITY.FREEZE_ENTITY_POSITION(electric_cage, true)
        end
    end
end
----英国女王笼子
function gueencage(pid)
    local number_of_cages = 6
    local coffin_hash = util.joaat("prop_coffin_02b")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(coffin_hash)
    local temp_v3 = v3.new(0, 0, 0)
    for i = 1, number_of_cages do
        local angle = (i / number_of_cages) * 360
        temp_v3.z = angle
        local obj_pos = temp_v3:toDir()
        obj_pos:mul(0.8)
        obj_pos:add(pos)
        obj_pos.z += 0.1
       local coffin = entities.create_object(coffin_hash, obj_pos)
       ENTITY.SET_ENTITY_ROTATION(coffin, 90.0, 0.0, angle,  2, 0)
       ENTITY.FREEZE_ENTITY_POSITION(coffin, true)
    end
end
----燃气笼
function gascage(pid)
    local gas_cage_hash = util.joaat("prop_gascage01")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(gas_cage_hash)
    pos.z -= 1
    local gas_cage = entities.create_object(gas_cage_hash, pos, 0)
    pos.z += 1
    local gas_cage2 = entities.create_object(gas_cage_hash, pos, 0)
    ENTITY.FREEZE_ENTITY_POSITION(gas_cage, true)
    ENTITY.FREEZE_ENTITY_POSITION(gas_cage2, true)
end
----集装箱笼子
function Container_cage(pid)
    local container_hash = util.joaat("prop_container_ld_pu")
    local pos = players.get_position(pid)
    RequestModel(container_hash)
    pos.z = pos.z - 1
    local container = entities.create_object(container_hash, pos, 0)
    ENTITY.FREEZE_ENTITY_POSITION(container, true)
end
-----载具笼子
function Vehicle_cage(pid)
    local container_hash = util.joaat("boxville3")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = players.get_position(pid)
    RequestModel(container_hash)
    local container = entities.create_vehicle(container_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 2.0, 0.0), ENTITY.GET_ENTITY_HEADING(ped))
    ENTITY.SET_ENTITY_VISIBLE(container, false)
    ENTITY.FREEZE_ENTITY_POSITION(container, true)
end
-----关门放狗
function Close_dog(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(ped, true)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    local hash = 779277682
    request_model(hash)
    local cage1 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage1, 0.0, -90.0, 0.0, 1, true)
    local cage2 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage2, 0.0, 90.0, 0.0, 1, true)
    util.yield(100)
    for i = 1, 20 do
        send_attacker(-1788665315, pid, false)
        util.yield(1)
    end
end
----恐怖之牢
function Terror_Prison(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(ped, true)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    local hash = 779277682
    request_model(hash)
    local cage1 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage1, 0.0, -90.0, 0.0, 1, true)
    local cage2 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage2, 0.0, 90.0, 0.0, 1, true)
    util.yield(100)
    for i = 1, 20 do
        send_attacker(util.joaat("CS_BradCadaver"), pid, false)
        util.yield(1)
    end
end
------小的竞技管
function Small_athletics(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(ped, true)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    local hash = 779277682
    request_model(hash)
    local cage1 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage1, 0.0, -90.0, 0.0, 1, true)
    local cage2 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage2, 0.0, 90.0, 0.0, 1, true)
end
-----竖向货机笼子
function Vertical_freighter_cage(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.0, 5.0)
    --local hash = util.joaat("prop_ld_crate_01")
    local hash = util.joaat('titan')
    request_model(hash)
    local cage = entities.create_vehicle(hash, coords, 0)
    ENTITY.SET_ENTITY_ROTATION(cage, 90, 0, 0, 1, true)
    --ENTITY.FREEZE_ENTITY_POSITION(cage, true)
    ENTITY.SET_ENTITY_INVINCIBLE(cage, true)
    ENTITY.FREEZE_ENTITY_POSITION(cage, true)
end
-------横行货机笼子
function Rampage_plane_cage(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.0, 0.0)
    local hash = util.joaat("cargoplane")
    request_model(hash)
    local cargo = entities.create_vehicle(hash, coords, ENTITY.GET_ENTITY_HEADING(ped))
    ENTITY.FREEZE_ENTITY_POSITION(cargo, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(cargo, coords.x, coords.y, coords.z-0.1, true, false, false)
    ENTITY.SET_ENTITY_INVINCIBLE(cargo, true)
    for i=1, 5 do
        VEHICLE.SET_VEHICLE_DOOR_LATCHED(cargo, i, true, true, true)
    end
end

------天煞战斗机
function Celestial_Fighter(pid)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, 1.0, 0.0, 500.0)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    local hash = util.joaat("lazer")
    request_model(hash)
    request_model(-163714847)
    for i=1, num_attackers do
        coords.x = coords.x + i*2
        coords.y = coords.y + i*2
        local jet = entities.create_vehicle(hash, coords, 0.0)
        VEHICLE.CONTROL_LANDING_GEAR(jet, 3)
        VEHICLE.SET_HELI_BLADES_FULL_SPEED(jet)
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(jet, VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(jet))
        if godmodeatk then
            ENTITY.SET_ENTITY_INVINCIBLE(jet, true)
        end
        local pilot = entities.create_ped(28, -163714847, coords, 30.0)
        PED.SET_PED_COMBAT_ATTRIBUTES(pilot, 5, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(pilot, 46, true)
        PED.SET_PED_INTO_VEHICLE(pilot, jet, -1)
        TASK.TASK_PLANE_MISSION(pilot, jet, 0, target_ped, 0, 0, 0, 6, 0.0, 0, 0.0, 50.0, 40.0)
        TASK.TASK_COMBAT_PED(pilot, target_ped, 0, 16)
        PED.SET_PED_ACCURACY(pilot, 100.0)
        PED.SET_PED_COMBAT_ABILITY(pilot, 2)
    end
end



----XF崩溃
function XF_crash(pid)
    for i = 1, 10 do
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local cord = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        STREAMING.REQUEST_MODEL(-930879665)
        util.yield(10)
        STREAMING.REQUEST_MODEL(3613262246)
        util.yield(10)
        STREAMING.REQUEST_MODEL(452618762)
        util.yield(10)
        local a1 = entities.create_object(-930879665, cord)
        util.yield(10)
        local a2 = entities.create_object(3613262246, cord)
        util.yield(10)
        local b1 = entities.create_object(452618762, cord)
        util.yield(10)
        local b2 = entities.create_object(3613262246, cord)
        util.yield(300)
        entities.delete(a1)
        entities.delete(a2)
        entities.delete(b1)
        entities.delete(b2)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(452618762)
        util.yield(10)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(3613262246)
        util.yield(10)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(-930879665)
        util.yield(10)
        end
end

----布尔值崩溃
function boolean_crash(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(ped)
    local model = util.joaat("banshee")
    request_model(model)
    local vehicle = entities.create_vehicle(model,coords,0)
    VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
    ENTITY.SET_ENTITY_COLLISION(vehicle, false, true)
    VEHICLE.SET_VEHICLE_GRAVITY(vehicle, 0)
    for i=0, 49 do
        local max_mod = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i) - 1
        VEHICLE.SET_VEHICLE_MOD(vehicle, i, max_mod, false)
    end
end

----无效载具崩溃
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
function Invalid_vehicle_crashes(pid)
    local pCoords = players.get_position(pid)
    local trafficLights = {}
    util.request_model(-655644382) -- traffic lights
    for i = 1, 20 do
        local object = entities.create_object(-655644382, v3.new(pCoords.x + math.random(-5, 5), pCoords.y + math.random(-5, 5), pCoords.z + math.random(-1, 0)))
        ENTITY.SET_ENTITY_ROTATION(object, 0, 0, math.random(0, 360), 1, true)
        trafficLights[#trafficLights + 1] = object
    end
    local stopLights = false
    util.create_tick_handler(function()
        if stopLights then
            return false
        end
        ENTITY.SET_ENTITY_TRAFFICLIGHT_OVERRIDE(trafficLights[math.random(1, #trafficLights)], math.random(0, 3))
    end)
    util.request_model(3253274834) -- buffalo
    local vehicles = {}
    local crashVehicle<const> = entities.create_vehicle(3253274834, pCoords, 0)
    vehicles[#vehicles + 1] = crashVehicle
    VEHICLE.SET_VEHICLE_MOD_KIT(crashVehicle, 0)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(crashVehicle, "ICRASHU")
    VEHICLE.SET_VEHICLE_MOD(crashVehicle, 34, 3)
    for i = 1, 10 do
        vehicles[#vehicles + 1] = clone(crashVehicle)
    end
    util.yield(500)
    for i = 1, #vehicles do
        entities.delete(vehicles[i])
    end
    util.yield(500)
    stopLights = true
    util.yield(500)
    for i = 1, #trafficLights do
        entities.delete(trafficLights[i])
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(3253274834)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(-655644382)
end



-----无效降落伞崩溃
function rotatePoint(x, y, center, degrees)
    local radians = math.rad(degrees)
    local new_x = (x - center.x) * math.cos(radians) - (y - center.y) * math.sin(radians)
    local new_y = (x - center.x) * math.sin(radians) + (y - center.y) * math.cos(radians)
    return center.x + new_x, center.y + new_y * 1920 / 1080
end
function Invalid_parachute()
    for pid = 0, 31 do
        local TTPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local SelfPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        local PreviousPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
        local user = players.user()
        local user_ped = players.user_ped()
        local pos = players.get_position(user)
        local spped = PLAYER.PLAYER_PED_ID()
        local ppos = ENTITY.GET_ENTITY_COORDS(spped, true)
        for i = 1, 5 do
            local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
            PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 200, false, true, true)
            util.yield(100)
            VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	3235319999)
            VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
            util.yield(100)
            entities.delete(Ruiner2)
        end
        for i = 1, 10 do
            local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
            PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 2000, false, true, true)
            util.yield(120)
            VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	260873931)
            VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
            util.yield(120)
            entities.delete(Ruiner2)
        end
        for i = 1, 10 do
            local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
            PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
            util.yield(100)
            VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	546252211)
            VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
            util.yield(100)
            entities.delete(Ruiner2)
        end
        for i = 1, 8 do
            local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
            PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 800, false, true, true)
            util.yield(200)
            VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	148511758)
            VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
            util.yield(200)
            entities.delete(Ruiner2)
        end
        for i = 1, 10 do
            local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
            PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 500, false, true, true)
            util.yield(100)
            VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	260873931)
            VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
            util.yield(100)
            entities.delete(Ruiner2)
        end
        util.yield(200)
        for i = 1, 5 do
            local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
            PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 300, false, true, true)
            util.yield(500)
            VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 1381105889)
            VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
            util.yield(500)
            entities.delete(Ruiner2)
        end
        for i = 1, 25 do
            local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
            PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 200, false, true, true)
            util.yield(150)
            VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	1500925016)
            VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
            util.yield(150)
            entities.delete(Ruiner2)
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
        for n = 0 , 2 do
            local object_hash = util.joaat("prop_logpile_06b")
            STREAMING.REQUEST_MODEL(object_hash)
            while not STREAMING.HAS_MODEL_LOADED(object_hash) do
            util.yield()
            end
            PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,100, false, true, true)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
            util.yield(800)
            for i = 0 , 1 do
                PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
            end
            util.yield(800)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)

            local object_hash2 = util.joaat("prop_beach_parasol_03")
            STREAMING.REQUEST_MODEL(object_hash2)
            while not STREAMING.HAS_MODEL_LOADED(object_hash2) do
            util.yield()
            end
            PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash2)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,100, 0, 0, 1)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
            util.yield(800)
            for i = 0 , 1 do
                PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
            end
            util.yield(800)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
        PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), 0xFBF7D21F)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
        TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
        util.yield()
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
        util.yield(300)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        util.yield(1000)
        for i = 1, 10 do
            util.spoof_script("freemode", SYSTEM.WAIT)
        end
        ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)
        for i = 1, 2 do
            local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
            PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 150, false, true, true)
            util.yield(200)
            VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	1500925016)
            VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
            util.yield(200)
            entities.delete(Ruiner2)
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
        for i = 1, 2 do
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), 0xFBF7D21F)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
            TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
            util.yield()
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
            util.yield(200)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
            PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
            util.yield(4500)
            for i = 1, 2 do
                util.spoof_script("freemode", SYSTEM.WAIT)
            end
            ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
            NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)
        end
    end
end


-----踢出室内
function Kick_room(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
    local glitch_hash = util.joaat("p_spinning_anus_s")
    local poopy_butt = util.joaat("brickade2")
    request_model(glitch_hash)
    request_model(poopy_butt)
    for i = 1, 5 do
        local stupid_object = entities.create_object(glitch_hash, pos)
        local glitch_vehicle = entities.create_vehicle(poopy_butt, pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(stupid_object, false)
        ENTITY.SET_ENTITY_VISIBLE(glitch_vehicle, false)
        ENTITY.SET_ENTITY_INVINCIBLE(glitch_vehicle, true)
        ENTITY.SET_ENTITY_COLLISION(stupid_object, true, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(glitch_vehicle, 1, 0.0, 10, 10, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        util.yield(500)
        entities.delete(stupid_object)
        entities.delete(glitch_vehicle)
        util.yield(500)     
    end
end

-----核弹
function nuclear_bomb_player(pid)
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local Object_pizza1 = CreateVehicle(1131912276,TargetPlayerPos,0)
    local Object_pizza2 =CreateObject(253279588,TargetPlayerPos)
        TargetPlayerPos.y = TargetPlayerPos.y + 2
        TargetPlayerPos.z = TargetPlayerPos.z + 70 
        ENTITY.SET_ENTITY_ALPHA(Object_pizza1, 255)
        ENTITY.SET_ENTITY_VISIBLE(Object_pizza1, false, 0)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(Object_pizza2,Object_pizza1, 0,  0.0, 0.00, 0.00, 1.0, 1.0,1, true, false, true, false, 0, true, 0)
    util.yield(5000)
    do
        orbital(pid)
        entities.delete(Object_pizza1)
        entities.delete(Object_pizza2)
    end
end


-----鬼畜玩家
function RequestModel(hash, timeout)
    timeout = timeout or 3
    STREAMING.REQUEST_MODEL(hash)
    local end_time = os.time() + timeout
    repeat
        util.yield()
    until STREAMING.HAS_MODEL_LOADED(hash) or os.time() >= end_time
    return STREAMING.HAS_MODEL_LOADED(hash)
end
local object_hash = util.joaat("prop_ld_ferris_wheel")
function obj_creat(index)
    object_hash = util.joaat(object_stuff.objects[index])
end
local delay = 150
function obj_creat_speed(amount)
    delay = amount
end
function Ghost_Beast_Player(pid)
    if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(pid)
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
        entities.delete(obj)
        entities.delete(veh)
    end
end

-----死亡屏障击杀
function Death_barrier(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = players.get_position(pid)                            
    local hash = util.joaat("prop_windmill_01")
    local mdl = util.joaat("rallytruck")
    RequestModel(hash)
    RequestModel(mdl)
    for i = 0, 5 do
        if TASK.IS_PED_WALKING(ped) then
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
        entities.delete(obj)
        entities.delete(veh)
    end
end

-----强制击杀
function Force_kill(index, veh, pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    local vehicle = util.joaat(veh)
    request_model(vehicle)
    switch veh do
        case "Khanjali":
        height = 2.8
        offset = 0
        break
        case "APC":
        height = 3.4
        offset = -1.5
        break
end
    if TASK.IS_PED_STILL(ped) then
        distance = 0
    elseif not TASK.IS_PED_STILL(ped) then
        distance = 3
end
    local vehicle1 = entities.create_vehicle(vehicle, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, offset, distance, height), ENTITY.GET_ENTITY_HEADING(ped))
    local vehicle2 = entities.create_vehicle(vehicle, pos, 0)
    local vehicle3 = entities.create_vehicle(vehicle, pos, 0)
    local vehicle4 = entities.create_vehicle(vehicle, pos, 0)
    local spawned_vehs = {vehicle4, vehicle3, vehicle2, vehicle1}
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, true, false, true, false, 0, true, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, true, false, true, false, 0, true, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, true, false, true, false, 0, true, 0)
    ENTITY.SET_ENTITY_VISIBLE(vehicle1, false)
    util.yield(5000)
    for i = 1, #spawned_vehs do
        entities.delete(spawned_vehs[i])
    end
end



----大烟花
function big_fireworks()
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    local hash = util.joaat("weapon_firework")
    request_weapon_asset(hash)
    WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)

    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-90-math.random(0, 40), pos.y-90, pos.z, pos.x-90-math.random(0, 40), pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-90-math.random(0, 40), pos.y-90, pos.z, pos.x-90-math.random(0, 40), pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-90-math.random(0, 40), pos.y-90, pos.z, pos.x-90-math.random(0, 40), pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-90-math.random(0, 40), pos.y-90, pos.z, pos.x-90-math.random(0, 40), pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-90-math.random(0, 40), pos.y-90, pos.z, pos.x-90-math.random(0, 40), pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
end
--炫彩烟花
function new_firework()
    local effect = "scr_indep_fireworks"
    local effect_name = "scr_indep_firework_starburst"
    request_ptfx_asset(effect)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect)
    indep_fireworks_r = math.random(0, 255) / 255
    indep_fireworks_g = math.random(0, 255) / 255
    indep_fireworks_b = math.random(0, 255) / 255
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), math.random(-15, 15), 50+math.random(0, 10), 0)--偏移量坐标,前后,左右,上下
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(effect_name, pos.x, pos.y, pos.z, 0, 0, 0, 1.0, false, false, false, false)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(indep_fireworks_r, indep_fireworks_g, indep_fireworks_b)
    util.yield(math.random(500, 2000))
end
--礼花桶
function new_firework2()
    local effect = "scr_indep_fireworks"
    local effect_name = "scr_indep_firework_fountain"
    request_ptfx_asset(effect)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect)
    indep_fireworks_r = math.random(0, 255) / 255
    indep_fireworks_g = math.random(0, 255) / 255
    indep_fireworks_b = math.random(0, 255) / 255
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), math.random(-15, 15), 50+math.random(0, 10), 0)--偏移量坐标,前后,左右,上下
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(effect_name, pos.x, pos.y, pos.z, 0, 0, 0, 1.0, false, false, false, false)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(indep_fireworks_r, indep_fireworks_g, indep_fireworks_b)
    util.yield(math.random(500, 2000))
end


----愤怒的飞机
local numPlanes = 0
function Angry_plane()
    if numPlanes < 15 and timer.elapsed() > 300 then
        local pedHash <const> = util.joaat("s_m_y_blackops_01")
        local planeModel <const> = planes[math.random(#planes)]
        local planeHash <const> = util.joaat(planeModel)
        request_model(planeHash); request_model(pedHash)
        local pos = players.get_position(players.user())
        local plane = VEHICLE.CREATE_VEHICLE(planeHash, pos.x, pos.y, pos.z, CAM.GET_GAMEPLAY_CAM_ROT(0).z, true, false, false)
        set_decor_flag(plane, DecorFlag_isAngryPlane)
        if ENTITY.DOES_ENTITY_EXIST(plane) then
            NETWORK.SET_NETWORK_ID_CAN_MIGRATE(NETWORK.VEH_TO_NET(plane), false)
            local pilot = entities.create_ped(26, pedHash, pos, 0)
            PED.SET_PED_INTO_VEHICLE(pilot, plane, -1)
            pos = get_random_offset_from_entity(players.user_ped(), 50.0, 150.0)
            pos.z = pos.z + 75.0
            ENTITY.SET_ENTITY_COORDS(plane, pos.x, pos.y, pos.z, false, false, false, false)
            local theta = random_float(0, 2 * math.pi)
            ENTITY.SET_ENTITY_HEADING(plane, math.deg(theta))
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(plane, 60.0)
            VEHICLE.SET_HELI_BLADES_FULL_SPEED(plane)
            VEHICLE.CONTROL_LANDING_GEAR(plane, 3)
            VEHICLE.SET_VEHICLE_FORCE_AFTERBURNER(plane, true)
            TASK.TASK_PLANE_MISSION(pilot, plane, 0, players.user_ped(), 0.0, 0.0, 0.0, 6, 100.0, 0.0, 0.0, 80.0, 50.0, false)
            numPlanes = numPlanes + 1
            timer.reset()
        end
    end
end
function clear_Angry_plane()
    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
        entities.delete(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false))
        entities.delete(vehicle)
        numPlanes = numPlanes - 1
    end
end

-----绘制血量条
local ttselectedOpt = 1
local selfaimedPed = 0
function ped_draw_method(opt)
    ttselectedOpt = opt
end
function PedHealthBarmainLoop()
    if ttselectedOpt == 4 then
        if not PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
            selfaimedPed = 0 return
        end
        local pEntity <const> = memory.alloc_int()
        if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), pEntity) then
            local entity = memory.read_int(pEntity)
            if ENTITY.IS_ENTITY_A_PED(entity) then selfaimedPed = entity end
        end
        draw_health_bar(selfaimedPed, 1000.0)
    else
        for _, ped in ipairs(get_peds_in_player_range(players.user(), 500.0)) do
            if not ENTITY.IS_ENTITY_ON_SCREEN(ped) or
            not ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(players.user_ped(), ped, TraceFlag.world) then
                goto LABEL_CONTINUE
            end
            if (ttselectedOpt == 1 and not PED.IS_PED_A_PLAYER(ped)) or
            (PED.IS_PED_A_PLAYER(ped) and ttselectedOpt == 2) then
                goto LABEL_CONTINUE
            end
            draw_health_bar(ped, 350.0)
        ::LABEL_CONTINUE::
        end
    end
end

------弹吉他
function Play_guitar(on)
    request_anim_dict("amb@world_human_musician@guitar@male@idle_a")
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    guitar = OBJECT.CREATE_OBJECT(util.joaat("prop_acc_guitar_01"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "amb@world_human_musician@guitar@male@idle_a", "idle_b", 3, 3, -1, 51, 0, false, false, false) --play anim 
    ENTITY.ATTACH_ENTITY_TO_ENTITY(guitar, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 24818), -0.1,0.31,0.1,0.0,20.0,150.0, false, true, false, true, 1, true, 0)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete(guitar)
    end
end
-----掌旋球
function Palm_spin_ball(on)
    request_anim_dict("anim@mp_player_intincarfreakoutstd@ps@")
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    guitar = OBJECT.CREATE_OBJECT(util.joaat("prop_bowling_ball"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "anim@mp_player_intincarfreakoutstd@ps@", "idle_a_fp", 10, 3, -1, 51, 5, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(guitar, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 24818), 0.30,0.53,0,0.2,70,340, false, true, false, true, 1, true, 0)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete(guitar)
    end
end
-----求助
function seek_help(on)
    request_anim_dict("amb@world_human_bum_freeway@male@base")
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    beggers = OBJECT.CREATE_OBJECT(util.joaat("prop_beggers_sign_03"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "amb@world_human_bum_freeway@male@base", "base", 3, 3, -1, 51, 0, false, false, false) --play anim 
    ENTITY.ATTACH_ENTITY_TO_ENTITY(beggers, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 58868), 0.19,0.18,0.0,5.0,0.0,40.0, false, true, false, true, 1, true, 0)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete(beggers)
    end
end
-----献花
function offer_flower(on)
    request_anim_dict("anim@heists@humane_labs@finale@keycards")
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    rose = OBJECT.CREATE_OBJECT(util.joaat("prop_single_rose"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", 3, 3, -1, 51, 0, false, false, false) --play anim 
    ENTITY.ATTACH_ENTITY_TO_ENTITY(rose, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 18905), 0.13,0.15,0.0,-100.0,0.0,-20.0, false, true, false, true, 1, true, 0)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete(rose)
    end
end



-----灵魂出窍
function Out_body(toggle)
    if toggle then
        all_peds = entities.get_all_peds_as_handles()
        user_ped = players.user_ped()
        clone = PED.CLONE_PED(user_ped,true, true, true)
        pos = ENTITY.GET_ENTITY_COORDS(clone, false)
        ENTITY.SET_ENTITY_COORDS(user_ped, pos.x-2, pos.y, pos.z)
        ENTITY.SET_ENTITY_ALPHA(players.user_ped(), 87, false)
        ENTITY.SET_ENTITY_INVINCIBLE(clone,true)
        menu.trigger_commands("invisibility remote")
        request_anim_dict("move_crawl")
        util.create_tick_handler(function()
            PED.SET_PED_MOVEMENT_CLIPSET(clone, "move_crawl", -1)
            mod_uses("ped", if on then 1 else -1)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(clone, true)
            TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(clone, true)
            return ghost
        end)
    else
        clonepedpos = ENTITY.GET_ENTITY_COORDS(clone, false)
        ENTITY.SET_ENTITY_COORDS(user_ped, clonepedpos.x,clonepedpos.y,clonepedpos.z, false, false)
        entities.delete(clone)
        ENTITY.SET_ENTITY_ALPHA(user_ped, 255, false)
        menu.trigger_commands("invisibility off")
    end
end


-----附加国旗
function first_to_upper(str)
    return (str:gsub("^%l", string.upper))
end
for _, flag in pairs(country_flags) do 
    table.insert(flags_fmt, first_to_upper(flag:gsub('apa_prop_flag_', ''):gsub('_yt', '')))
end


-----homer粒子
suijijianqi = function(x)
    local r = math.random(1,5)
    return x[r]
end


---转魂
function Soul_Gun()
    local ent = get_aim_info()['ent']
    if PED.IS_PED_SHOOTING(players.user_ped()) then
        if ENTITY.IS_ENTITY_A_PED(ent) then
            pos = ENTITY.GET_ENTITY_COORDS(ent, false)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), pos.x, pos.y, pos.z, false, false, false)
            if PED.IS_PED_A_PLAYER(ent) then
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
                menu.trigger_commands("copyoutfit " .. players.get_name(pid))
            else
            local soul = ENTITY.GET_ENTITY_MODEL(ent)
            STREAMING.REQUEST_MODEL(soul)
            while(not STREAMING.HAS_MODEL_LOADED(soul))
            do
            util.yield(10)
                end
            PLAYER.SET_PLAYER_MODEL(players.user(),soul)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(soul)
            if not PED.IS_PED_A_PLAYER(ent) then
                entities.delete(ent)
            end
            util.yield(10)
            menu.trigger_commands("allguns")
        end
    end
        if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
            local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)
        if VEHICLE.GET_VEHICLE_NUMBER_OF_PASSENGERS(ent,true,false) >= 1 then
            local soulveh = ENTITY.GET_ENTITY_MODEL(driver)
            if not PED.IS_PED_A_PLAYER(driver) then
                entities.delete(driver)
                end
                STREAMING.REQUEST_MODEL(soulveh)
                while(not STREAMING.HAS_MODEL_LOADED(soulveh))
                do
                util.yield(10)
                    end
            PLAYER.SET_PLAYER_MODEL(players.user(),soulveh)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(soulveh)
            util.yield(10)
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), ent, -1)
            menu.trigger_commands("allguns")
            end
        end
    end
end

-----Blacklist
require "lib.daidailib.Config.blacklist"
function Black_list()
    for pid = 0, 31 do
        Blacklist_player = players.get_name(pid)
            for i = 1, #blacklistplayers do
                    if blacklistplayers[i] == Blacklist_player and Blacklist_player ~= players.get_name(players.get_host()) and Blacklist_player ~= players.get_name(players.user()) then
                        util.toast("检测到黑名单玩家: "..Blacklist_player.."\n已执行踢出")
                        menu.trigger_commands("kick " .. Blacklist_player)
                    end
            end
    end
end
function Black_self()
    Blacklist_self = players.get_name(players.user())
    for i = 0, #blacklistplayers do
        if blacklistplayers[i] == Blacklist_self then
            os.exit() 
        end
    end
end


-----实体枪2
local impactCords = v3.new()
local blocks = {}
function xxxminecraftgun()
    if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), impactCords) then
        local hash = util.joaat('prop_mb_sandblock_01')
        request_model(hash)
        blocks[#blocks + 1] = entities.create_object(hash, impactCords)
    end
end


-----在线玩家
playerslist = {}
function join_blacklist2(pid)
    local selected_blacklist_path = filesystem.scripts_dir() .. 'lib/daidailib/Config/blacklist.lua'
    local black_txt = players.get_name(pid)
--删除文本最后一行
    local file = io.open(selected_blacklist_path, "r+")
    local content = file:read("*all")
    local t = string.gmatch(content, "([^\n]+)[\n]*$")()
    local content_len = string.len(content)
    local t_len = string.len(t)
    file:close()
    local str = string.sub(content, 0, content_len-t_len-1)
    file = io.open(selected_blacklist_path, 'w')
    file:write(str)
    file:close()
--添加内容
    file = io.open(selected_blacklist_path, 'a')
    file:write(',\n    "'..black_txt..'"')
    file:write("\n}")
    file:close()
end
function join_blacklist(pid)
    local result = 0
    local blackplayer = players.get_name(pid)
        for i = 1, #blacklistplayers do
            if blacklistplayers[i] == blackplayer then
                util.toast("玩家已存在")
                result = 1
            end
        end
    if result ~= 1 and blackplayer ~= "UndiscoveredPlayer" and blackplayer ~= players.get_name(players.user()) then
        notification("~y~~bold~添加成功", HudColour.blue)
        join_blacklist2(pid)
        table.insert(blacklistplayers, players.get_name(pid))
    else
        notification("~y~~bold~添加失败", HudColour.blue)
    end
end

function player_list(pid)
    if NETWORK.NETWORK_IS_SESSION_ACTIVE()then
        playerslist[pid] = menu.list(players_list, players.get_name(pid), {}, "")
    end
    if playerslist[pid] then
        
        menu.divider(playerslist[pid],"玩家信息")
        menu.readonly(playerslist[pid], "玩家昵称: ", players.get_name(pid))
        menu.readonly(playerslist[pid], "玩家rid: ", players.get_rockstar_id(pid))
        menu.readonly(playerslist[pid], "玩家金钱: ", players.get_money(pid))
        menu.readonly(playerslist[pid], "玩家kd: ", string.format("%.2f", players.get_kd(pid)))
        menu.divider(playerslist[pid],"其他选项")
        menu.action(playerslist[pid],"踢出玩家",{},"",function()
            menu.trigger_commands("kick " .. players.get_name(pid))
        end)
        local mark = 0 --未标记
        menu.action(playerslist[pid],"标记玩家",{},"标记或者取消标记玩家",function()
            if mark == 0 then
                menu.set_menu_name(playerslist[pid], players.get_name(pid).." [标记]")
                mark = 1
            else
                menu.set_menu_name(playerslist[pid], players.get_name(pid))
                mark = 0
            end
        end)
        menu.action(playerslist[pid],"加入黑名单",{},"",function()
            join_blacklist(pid)
        end)

    end
end
function handle_player_list(pid)
    local ref = playerslist[pid]
    if not players.exists(pid) then
        if ref then
            menu.delete(ref)
            playerslist[pid] = nil
        end
    end
end




----允许当前车辆进入车库
function BitTest(value, bit)
    return value & (1 << bit) ~= 0
end
function BitSet(value, bit)
    return value | (1 << bit)
end
function BitClear(value, bit)
    return value & ~(1 << bit)
end
function carinto()
    local ped = players.user_ped()
    local hash = NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(players.user())
    if PED.IS_PED_IN_ANY_VEHICLE(ped) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
        local start = os.time() + 15
        if veh ~= 0 then
            local spawned_model = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(veh))
            if hash ~= 0 then
                memory.write_int(memory.script_global(78558), 0)
                local bitset = DECORATOR.DECOR_GET_INT(veh, "MPBitset")
                bitset = BitClear(bitset, 3)
                bitset = BitSet(bitset, 24)
                DECORATOR.DECOR_SET_INT(veh, "MPBitset", bitset)
                DECORATOR.DECOR_SET_INT(veh, "Previous_Owner", 0)
                DECORATOR.DECOR_SET_INT(veh, "PV_Slot", 0)
                DECORATOR.DECOR_SET_INT(veh, "Player_Vehicle", hash)
                DECORATOR.DECOR_SET_INT(veh, "Veh_Modded_By_Player", hash)
                local interior = INTERIOR.GET_INTERIOR_FROM_ENTITY(ped)
                local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
                util.toast("完成")
                while interior == 0 do
                    interior = INTERIOR.GET_INTERIOR_FROM_ENTITY(ped)
                    util.yield_once()
                end
                memory.write_int(memory.script_global(78558), 1)
                while interior ~= 0 do
                    interior = INTERIOR.GET_INTERIOR_FROM_ENTITY(ped)
                    util.yield_once()
                end
                for i, veh in pairs(entities.get_all_vehicles_as_handles()) do
                    local model = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(veh))
                    if model:find(spawned_model) then
                        local veh_pos = ENTITY.GET_ENTITY_COORDS(veh, true)
                        if MISC.GET_DISTANCE_BETWEEN_COORDS(pos.x, pos.y, pos.z, veh_pos.x, veh_pos.y, veh_pos.z, true) < 5.0 then
                            entities.delete(veh)
                            break
                        end
                    end
                end
            end
        end
    else
        util.toast("你还没进载具呢")
    end
end


-----UFO勇闯洛城
local ufo = util.joaat("sum_prop_dufocore_01a")
local dufo = util.joaat("imp_prop_ship_01a")
function UFO_Los_Angeles(toggle)
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local r = ufonum[math.random(#ufonum)]
    c.x = math.random(0.0,1.0) >= 0.5 and c.x + r + 5 or c.x - r - 5 --set x coords
    c.y = math.random(0.0,1.0) >= 0.5 and c.y + r + 5 or c.y - r - 5 --set y coords
    c.z = c.z + r + 8 --set z coords
    STREAMING.REQUEST_MODEL(ufo)
    while not STREAMING.HAS_MODEL_LOADED(ufo) do
        STREAMING.REQUEST_MODEL(ufo)
        util.yield()
    end
    util.yield(2500)
    local spawnedufo = entities.create_object(ufo, c) --spawn ufo
    util.yield(500)
    local ufoc = ENTITY.GET_ENTITY_COORDS(spawnedufo) --get ufo pos
    local success, floorcoords
    repeat
        success, floorcoords = util.get_ground_z(ufoc.x, ufoc.y) --get floor pos
        util.yield()
    until success
    FIRE.ADD_EXPLOSION(ufoc.x, ufoc.y, floorcoords, exp, 100.0, true, false, 1.0, false) --explode at floor
    util.yield(1500)
    entities.delete(spawnedufo) --delete ufo

    if not STREAMING.HAS_MODEL_LOADED(ufo) then
        util.toast("无法加载模型")
    end
end


-----攻击嘲讽作者
author = "\n--------¦daidai"
-----作者
F = "Author-呆呆"

------音乐
function music(on)
	if on then
        menu.trigger_commands("ipod on")
        AUDIO.SET_RADIO_TO_STATION_NAME("RADIO_19_USER")
----AUDIO.SET_RADIO_TO_STATION_NAME(AUDIO.GET_RADIO_STATION_NAME("16"))
        menu.trigger_commands("closeradio off")
        util.yield(500)
		menu.trigger_commands("lockradio on")
    else
        menu.trigger_commands("ipod off")
        AUDIO.SET_RADIO_TO_STATION_NAME("OFF")
		menu.trigger_commands("lockradio off")
    end
end

----爆炸圈
local explosion_circle_angle = 0
function explosion_circle(ped, angle, radius)
    local ped_coords = ENTITY.GET_ENTITY_COORDS(ped)
    local offset_x = ped_coords.x
    local offset_y = ped_coords.y
    local x = offset_x + radius * math.cos(angle)
    local y = offset_y + radius * math.sin(angle)
    FIRE.ADD_EXPLOSION(x, y, ped_coords.z, 4, 1, true, false, 0)
end
function explosion_range()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    explosion_circle(ped, explosion_circle_angle, 25)
    explosion_circle_angle = explosion_circle_angle + 0.15
    util.yield(50)
end


-----主机序列
--fps帧数
local fpstoggle = 0
function fps(on)
    if on then
        if menu.get_value(host_sequence) == true then
            fpstoggle = 1
        else
            util.toast("请先开启主机序列")
            menu.set_value(numfps,false)
        end
    else
        fpstoggle = 0
    end
end

local fps = 0
util.create_thread(function()
    while true do
        fps = math.ceil(1/SYSTEM.TIMESTEP())
        util.yield(500)
    end
end)

local replayInterface = memory.read_long(memory.rip(memory.scan("48 8D 0D ? ? ? ? 48 8B D7 E8 ? ? ? ? 48 8D 0D ? ? ? ? 8A D8 E8 ? ? ? ? 84 DB 75 13 48 8D 0D") + 3))
local pedInterface = memory.read_long(replayInterface + 0x0018)
local vehInterface = memory.read_long(replayInterface + 0x0010)
local objectInterface = memory.read_long(replayInterface + 0x0028)
local pickupInterface = memory.read_long(replayInterface + 0x0020)

local zhujixvlie_posx = config_active1_x / 1000
local zhujixvlie_posy = config_active1_y / 1000
function zhujixvlie_x(x_)
    zhujixvlie_posx = x_ / 1000
end
function zhujixvlie_y(y_)
    zhujixvlie_posy = y_ / 1000
end
function zhujixvlie()
    --下位主机
    for pid = 0, 31 do
        nexthostxulie = players.get_host_queue_position(pid)
            if #players.list() > 1 then
                if nexthostxulie == 1 then
                    if players.get_name(pid) ~= "UndiscoveredPlayer" then
                        nexthost_name = players.get_name(pid)
                    end
                end
            else
                nexthost_name = "不可用"
            end
    end

    --杂项
    local inviciamountint = 0
    for pid = 0, 31 do
        --作弊者人数
        if players.exists(pid) and pid ~= players.user() then
            if players.is_marked_as_modder(pid) then
                inviciamountint = inviciamountint + 1
            end
        end
        --载具时速
        local ent1e = players.user_ped()
        local ent2e = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
            if PED.IS_PED_IN_ANY_VEHICLE(ent1e,true) then
                ente = ent2e----载具内
            else
                ente = ent1e----非载具内
            end
        local speede = ENTITY.GET_ENTITY_SPEED(ente)
        local speedcalce = speede * 3.6
        myspeed1e = math.ceil(speedcalce)
    end

--~italic~ 斜体
--~bold~ 加粗
--~?~ color
    if fpstoggle == 1 then
        draw_string(string.format("~bold~~o~FPS: ~b~"..fps), zhujixvlie_posx, zhujixvlie_posy, 0.3,1)
    end

	draw_string(string.format("~bold~~b~"..myspeed1e.." ~g~km/h"), zhujixvlie_posx,zhujixvlie_posy + 0.03, 0.3,1)-----速度
	draw_string(string.format("~bold~~y~"..os.date("%X")), zhujixvlie_posx, zhujixvlie_posy + 0.06, 0.3,1)    -----------------时间
	draw_string(string.format("~bold~战局人数: ~g~"..#players.list()), zhujixvlie_posx, zhujixvlie_posy + 0.09, 0.3,1) 
	draw_string(string.format("~bold~作弊人数: ~r~"..inviciamountint), zhujixvlie_posx, zhujixvlie_posy + 0.12, 0.3,1)

    if PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**" then
        draw_string(string.format("~bold~战局主机: ~y~不可用", ALIGN_TOP_LEFT), zhujixvlie_posx, zhujixvlie_posy + 0.15, 0.3,1)
    else
        draw_string(string.format("~bold~战局主机: ~y~"..players.get_name(players.get_host())), zhujixvlie_posx, zhujixvlie_posy + 0.15, 0.3,1)
    end

    if PLAYER.GET_PLAYER_NAME(players.get_script_host()) == "**Invalid**" then
        draw_string(string.format("~bold~脚本主机: ~b~不可用", ALIGN_TOP_LEFT), zhujixvlie_posx, zhujixvlie_posy + 0.18, 0.3,1) 
    else
        draw_string(string.format("~bold~脚本主机: ~b~"..players.get_name(players.get_script_host())), zhujixvlie_posx, zhujixvlie_posy + 0.18, 0.3,1)
    end

    draw_string(string.format("~bold~~g~下一位主机: ~p~"..nexthost_name), zhujixvlie_posx, zhujixvlie_posy + 0.21, 0.3,1) 

    local hostxvlie = players.get_host_queue_position(players.user())
        if hostxvlie == 0 then
            draw_string(string.format("~bold~~o~你现在是战局主机"), zhujixvlie_posx, zhujixvlie_posy + 0.24, 0.3,1) 
        else
            draw_string(string.format("~bold~~q~你的主机优先度:~q~ "..hostxvlie), zhujixvlie_posx, zhujixvlie_posy + 0.24, 0.3,1) 
        end

end




----实体池信息
function entityinfo()
    draw_string(string.format("~h~~f~实体池Info~"..memory.read_int(pedInterface ).."/"..memory.read_int(pedInterface)), 0,0, 0.32,1)
    draw_string(string.format("~h~PED: ~g~"..memory.read_int(pedInterface + 0x0110).."/"..memory.read_int(pedInterface + 0x0108)), 0,0.03, 0.3,1)
    draw_string(string.format("~h~载具: ~y~"..memory.read_int(vehInterface + 0x0190).."/"..memory.read_int(vehInterface + 0x0188)), 0,0.06, 0.3,1)
    draw_string(string.format("~h~实体: ~r~"..memory.read_int(objectInterface + 0x0168).."/"..memory.read_int(objectInterface + 0x0160)), 0,0.09, 0.3,1)
    draw_string(string.format("~h~拾取物: ~q~ "..memory.read_int(pickupInterface + 0x0110).."/"..memory.read_int(pickupInterface + 0x0108)), 0,0.12, 0.3,1)
end


----脚本昵称
local mcspt = {xh=1,r=255,g=0,b=0}
function scriptname(state)
    sname = state
    while sname do
        if mcspt.xh==1 and mcspt.g<256 then
            HUD.SET_TEXT_COLOUR(mcspt.r, mcspt.g, mcspt.b, 255)	
            if mcspt.g == 255 then
                mcspt.xh=2
            else
                mcspt.g=mcspt.g+1
            end
        elseif mcspt.xh==2 and mcspt.r>-1 then
            HUD.SET_TEXT_COLOUR(mcspt.r,mcspt.g,mcspt.b,255)
            if mcspt.r == 0 then
                mcspt.xh=3
            else
                mcspt.r=mcspt.r-1
            end
        elseif mcspt.xh==3 and mcspt.b<256 then
            HUD.SET_TEXT_COLOUR(mcspt.r,mcspt.g,mcspt.b,255)
            if mcspt.b == 255 then
                mcspt.xh=4
            else
                mcspt.b=mcspt.b+1
            end
        elseif mcspt.xh==4 and mcspt.g>-1 then
            HUD.SET_TEXT_COLOUR(mcspt.r,mcspt.g,mcspt.b,255)
            if mcspt.g == 0 then
                mcspt.xh=5
            else
                mcspt.g=mcspt.g-1
            end
        elseif mcspt.xh==5 and mcspt.r<256 then
            HUD.SET_TEXT_COLOUR(mcspt.r,mcspt.g,mcspt.b,255)
            if mcspt.r == 255 then
                mcspt.xh=6
            else
                mcspt.r=mcspt.r+1
            end
        elseif mcspt.xh==6 and mcspt.b>-1 then
            HUD.SET_TEXT_COLOUR(mcspt.r,mcspt.g,mcspt.b,255)
            if mcspt.b == 0 then
                mcspt.xh=1
            else
                mcspt.b=mcspt.b-1
            end
        end
    draw_string(string.format("~italic~¦~bold~Sakura Script v9.4"), 0.38,0.1, 0.6,5)
    util.yield()
    end
end




----大锤
function hammer(on)
    if on then
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),false)--禁止切换武器
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)--给予指定武器
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(players.user_ped(), false, false, false, false)--武器隐形

        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        handlebar = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02a"), pos.x, pos.y, pos.z, true, true, false)--大锤手柄
        dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_02a"), pos.x, pos.y, pos.z, true, true, false)--大锤
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(handlebar, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui,handlebar, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true, 0)
    else
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),true)
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete(handlebar)
        entities.delete(dachui)
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1569615261,15,true,true)--给予徒手
    end
end

----雷神锤
function thunder_hammer(on)
    if on then
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),false)--禁止切换武器
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)--给予指定武器
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(players.user_ped(), false, false, false, false)--武器隐形

        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        thunderlebar = OBJECT.CREATE_OBJECT(-1924271972, pos.x, pos.y, pos.z, true, true, false)--大锤手柄
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(thunderlebar, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.08, 0.22, 0.05, -75, 45.0, 0, true, true, false, false, 0, true, 0)
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete(thunderlebar)

        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),true)--解除禁止切换武器
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(players.user_ped(), true, false, false, false)--解除武器隐形
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1569615261,15,true,true)--给予徒手
    end
end


--流星锤
function meteorhammer(on)
    if on then
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),false)--禁止切换武器
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)--给予指定武器

        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        meteorhandlebar = OBJECT.CREATE_OBJECT(util.joaat("prop_glass_stack_03"), pos.x, pos.y, pos.z, true, true, false)--prop_gate_farm_post
        meteordachui = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_pile_03"), pos.x, pos.y, pos.z, true, true, false)--h4_prop_h4_barrel_01a
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(meteorhandlebar, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 115, 30.0, 0, true, true, false, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(meteordachui,meteorhandlebar, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true, 0)
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete(meteorhandlebar)
        entities.delete(meteordachui)

        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),true)--解除禁止切换武器
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1569615261,15,true,true)--给予徒手
    end
end

----原子大锤
function atomhammer(on)
    if on then
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),false)--禁止切换武器
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)--给予指定武器
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(players.user_ped(), false, false, false, false)--武器隐形

        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        atomhandlebar = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_04"), pos.x, pos.y, pos.z, true, true, false)
        atomdachui = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_03d"), pos.x, pos.y, pos.z, true, true, false)
        atomdachui1 = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_03d"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(atomhandlebar, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(atomdachui,atomhandlebar, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(atomdachui1,atomhandlebar, 0,  0, 0, -0.201, 145, 100.0,0, true, true, false, false, 0, true, 0)
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete(atomhandlebar)
        entities.delete(atomdachui)
        entities.delete(atomdachui1)

        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),true)--解除禁止切换武器
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(players.user_ped(), true, false, false, false)--解除武器隐形
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1569615261,15,true,true)--给予徒手
    end
end

----小熊大锤
function bearhammer(on)
    if on then
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),false)--禁止切换武器
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)--给予指定武器

        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        bearhandlebar = OBJECT.CREATE_OBJECT(util.joaat("ba_prop_battle_cameradrone"), pos.x, pos.y, pos.z, true, true, false)
        beardachui = OBJECT.CREATE_OBJECT(util.joaat("prop_mr_raspberry_01"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(bearhandlebar, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(beardachui,bearhandlebar, 0,  0, 0, 0.15, 0, 180,180, true, true, false, false, 0, true, 0)
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete(bearhandlebar)
        entities.delete(beardachui)

        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),true)--解除禁止切换武器
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1569615261,15,true,true)--给予徒手
    end
end

----粉色独角兽
function unicorn(on)
    if on then
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),false)--禁止切换武器
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)--给予指定武器
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(players.user_ped(), false, false, false, false)--武器隐形

        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        unicornhandlebar = OBJECT.CREATE_OBJECT(util.joaat("ba_prop_battle_cameradrone"), pos.x, pos.y, pos.z, true, true, false)
        ENTITY.SET_ENTITY_VISIBLE(unicornhandlebar, false, 0)
        unicorndachui = OBJECT.CREATE_OBJECT(util.joaat("ba_prop_battle_hobby_horse"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(unicornhandlebar, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.165, 0.9, 0.205, 105, 30, 1, true, true, false, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(unicorndachui,unicornhandlebar, 0, 0, 0, 0.74, -1.9, 184, 233, true, true, false, false, 0, true, 0)
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete(unicornhandlebar)
        entities.delete(unicorndachui)

        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),true)--解除禁止切换武器
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(players.user_ped(), true, false, false, false)--解除武器隐形
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1569615261,15,true,true)--给予徒手
    end
end


--太刀
function knife(on)
    if on then
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),false)--禁止切换武器
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        saber = OBJECT.CREATE_OBJECT(util.joaat("prop_cs_katana_01"), pos.x, pos.y, pos.z, true, true, false)
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(saber, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.07, 0, 0, -100, 0.0, 0, true, true, true, true, 0, true, 0)
    else
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),true)
        entities.delete(saber)
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1569615261,15,true,true)--给予徒手
    end
end

---小挂件
main_icon = filesystem.resources_dir() .. "SakuraImg\\"
local ImgFolderDir = main_icon .. "Img\\"
function dd_showpng()
    function SHOW_IMG(ImgName, MaxPassedTime)
        if filesystem.exists(ImgFolderDir .. ImgName) then
            local Img = directx.create_texture(ImgFolderDir .. ImgName)
            local ImgAlpha = 0---初始时间
            local IncreasedImgAlpha = 0.01----增加的时间
            local StartedTime = os.clock()

                util.create_tick_handler(function()
                    ImgAlpha = ImgAlpha + IncreasedImgAlpha
                    if ImgAlpha > 1 then
                        ImgAlpha = 1
                    elseif ImgAlpha < 0 then 
                        ImgAlpha = 0
                        return false
                    end
                end)
    
                util.create_tick_handler(function()
                directx.draw_texture(Img, 0.1, 0.1, 1.3, -1.1, 0.5, 0.5, 0, 1, 1, 1, ImgAlpha)
                local PassedTime = os.clock() - StartedTime
                    if PassedTime > MaxPassedTime then
                        IncreasedImgAlpha = -0.01
                    end
                    if ImgAlpha == 0 then
                        return false
                    end
                end)
        end
    end
	    SHOW_IMG("1.png", 4)
        util.yield(3000)
end

-------喷火器
flamemildOrangeFire = new_colour( 255, 127, 80 )
flameThrower = {
    colour = flamemildOrangeFire
}
function flamegun()
    local JSkey = require 'lib.daidailib.JSkeyLib'
    if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) != 1119849093 or not JSkey.is_control_pressed(2, 'INPUT_AIM') then
        if not flameThrower.ptfx then return end
        GRAPHICS.REMOVE_PARTICLE_FX(flameThrower.ptfx, true)
        STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
        flameThrower.ptfx = nil
        return
    end
    PLAYER.DISABLE_PLAYER_FIRING(players.user_ped(), true)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do
        STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
        util.yield()
    end
    GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
    if flameThrower.ptfx == nil then
        flameThrower.ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(
                'muz_xs_turret_flamethrower_looping',
                WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped(), 0),
                0.8, 0, 0, 0, 0, 270,
                ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped(), 0), 'Gun_Nuzzle'),
                0.5, false, false, false, 0, 0, 0, 0
            )
        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(flameThrower.ptfx, flameThrower.colour.r, flameThrower.colour.g, flameThrower.colour.b, 0)
    end
end



--双拳
local bones = {
    26612,
    58868,
}
function Fire_Fist(on)
    if on then
        for _, boneId in ipairs(bones) do
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("fire_wrecked_plane_cockpit", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 0.35, false, false, false, 0, 0, 0, 0)
        end
    else
        GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
    end
end
function Blood_Fist(on)
    if on then
        for _, boneId in ipairs(bones) do
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scrape_blood_car", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 0.35, false, false, false, 0, 0, 0, 0)
        end
    else
        GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
    end
end
function Raiden_Fist(on)
    if on then
        for _, boneId in ipairs(bones) do
        request_ptfx_asset("scr_reconstructionaccident")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_reconstructionaccident")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_sparking_generator", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
        end
    else
        GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
    end
end



-----实体池限制
function entity_limit()
    local ped_count = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if ped ~= players.user_ped() then
            ped_count += 1
        end
        if ped_count >= ped_limit then
            for _, ped in pairs(entities.get_all_peds_as_handles()) do
                entities.delete(ped)
            end
            util.toast("Ped池达到上限,正在清理...")
        end
    end
    local veh__count = 0
    for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do
        veh__count += 1
        if veh__count >= veh_limit then
            for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do 
                entities.delete(veh)   
            end    
            util.toast("载具池达到上限,正在清理...")    
        end    
    end   
    local obj_count = 0    
    for _, obj in pairs(entities.get_all_objects_as_handles()) do    
        obj_count += 1   
        if obj_count >= obj_limit then 
            for _, obj in pairs(entities.get_all_objects_as_handles()) do
                entities.delete(obj)
            end
            util.toast("物体池达到上限,正在清理...")
        end
    end 
end


----实体枪v1
function get_offset_from_gameplay_camera(distance)
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = v3.toDir(cam_rot)
    local destination = 
    { 
        x = cam_pos.x + direction.x * distance, 
        y = cam_pos.y + direction.y * distance, 
        z = cam_pos.z + direction.z * distance 
    }
    return destination
end
shootent = -422877666
function eentity_gun()
    if PED.IS_PED_SHOOTING(players.user_ped()) then
        local hash = shootent
        request_model(hash)
        local c1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 5.0, 0.0)
        local res = raycast_gameplay_cam(-1, 1000.0)
        local dir = {}
        local c2 = {}
        if res[1] ~= 0 then
            c2 = res[2]
            dir['x'] = (c2['x'] - c1['x'])*1000
            dir['y'] = (c2['y'] - c1['y'])*1000
            dir['z'] = (c2['z'] - c1['z'])*1000
        else 
            c2 = get_offset_from_gameplay_camera(1000)
            dir['x'] = (c2['x'] - c1['x'])*1000
            dir['y'] = (c2['y'] - c1['y'])*1000
            dir['z'] = (c2['z'] - c1['z'])*1000
        end
        local ent = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, c1['x'], c1['y'], c1['z'], true, false, false)
        ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(ent, players.user_ped(), false)
        ENTITY.APPLY_FORCE_TO_ENTITY(ent, 0, dir['x'], dir['y'], dir['z'], 0.0, 0.0, 0.0, 0, true, false, true, false, true)
    end
end




----反向控制
function car_crash(state)
    veh = entities.get_user_vehicle_as_handle()
    if state then
        VEHICLE1._SET_VEHICLE_CONTROLS_INVERTED(veh, true)
    else
        VEHICLE1._SET_VEHICLE_CONTROLS_INVERTED(veh, false)
    end
end

--氮气加速
local nitro_duration = 2000
local nitro_power = 2000
function nnitrogen_acceleration()
    local player_cur_car = entities.get_user_vehicle_as_handle()
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) and player_cur_car ~= 0 then
        if PAD.IS_CONTROL_JUST_PRESSED(357, 357) then --x
            request_ptfx_asset('veh_xs_vehicle_mods')
            GRAPHICS.USE_PARTICLE_FX_ASSET('veh_xs_vehicle_mods')
            VEHICLE1.SET_OVERRIDE_NITROUS_LEVEL(player_cur_car, true, 100, nitro_power, 99999999999, false)
            ENTITY.SET_ENTITY_MAX_SPEED(player_cur_car, 2000)
            VEHICLE1.SET_VEHICLE_MAX_SPEED(player_cur_car, 2000)
            util.yield(nitro_duration)
            VEHICLE1.SET_OVERRIDE_NITROUS_LEVEL(player_cur_car, false, 0, 0, 0, false)
            VEHICLE1.SET_VEHICLE_MAX_SPEED(player_cur_car, 0.0)
        end
    end
end
function nnitro_duration(val)
    nitro_duration = val * 1000
end
function nnitro_power(val)
    nitro_power = val
end
initial_d_mode = false
initial_d_score = false
function on_user_change_vehicle(vehicle)
    if vehicle ~= 0 then
        if initial_d_mode then 
            set_vehicle_into_drift_mode(vehicle)
        end

        local deez_nuts = {}
        local num_seats = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(vehicle))
        for i=1, num_seats do
            if num_seats >= 2 then
                deez_nuts[#deez_nuts + 1] = tostring(i - 2)
            else
                deez_nuts[#deez_nuts + 1] = tostring(i)
            end
        end
        if true then 
            native_invoker.begin_call()
            native_invoker.push_arg_int(vehicle)
            native_invoker.end_call("76D26A22750E849E")
        end
    end
end


-------拉车
function update_attachment_position(attachment)
    if attachment.offset == nil then
        attachment.offset = {x=0,y=0,z=0}
    end
    if attachment.rotation == nil then
        attachment.rotation = {x=0,y=0,z=0}
    end
    if attachment.collision == nil then
        attachment.collision = true
    end
    ENTITY.ATTACH_ENTITY_TO_ENTITY(
        attachment.handle, attachment.root, attachment.bone_index or 0,
        attachment.offset.x or 0, attachment.offset.y or 0, attachment.offset.z or 0,
        attachment.rotation.x or 0, attachment.rotation.y or 0, attachment.rotation.z or 0,
        false, true, attachment.collision, false, 2, true, 0
    )
end
function get_vehicle_dimension(vehicle)
    local minimum = memory.alloc()
    local maximum = memory.alloc()
    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), minimum, maximum)
    local minimum_vec = v3.new(minimum)
    local maximum_vec = v3.new(maximum)
    return {x = maximum_vec.y - minimum_vec.y, y = maximum_vec.x - minimum_vec.x, z = maximum_vec.z - minimum_vec.z}
end
function set_attachment_offset_for_root(attachment)
    local root_model = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(attachment.root))
    local dimensions = get_vehicle_dimension(attachment.handle)
    if root_model == "wastelander" then
        attachment.offset = {
            x=0,
            y=(dimensions.y / 2) - 2,
            z=(dimensions.z / 2) + 0.8
        }
    end
    if root_model == "slamtruck" then
        attachment.offset = {
            x=0,
            y=(dimensions.y / 2) - 3,
            z=(dimensions.z / 2) + 0.3
        }
        attachment.rotation = {
            x=8,
            y=0,
            z=0,
        }
    end
end
function attach(attachment)
    attachment.position = ENTITY.GET_ENTITY_COORDS(attachment.root)
    ENTITY.SET_ENTITY_HAS_GRAVITY(attachment.handle, false)
    set_attachment_offset_for_root(attachment)
    update_attachment_position(attachment)
    ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(attachment.root, attachment.handle)
    return attachment
end
statecar = {}
function detach_attached_vehicle()
    if statecar.attached_vehicle ~= nil then
        util.toast("已分离 "..statecar.attached_vehicle.name)
        ENTITY.DETACH_ENTITY(statecar.attached_vehicle.handle, true, true)
        statecar.attached_vehicle = nil
    end
end
function attach_nearest_vehicle()
    local player_vehicle = entities.get_user_vehicle_as_handle()
    if not player_vehicle then
        util.toast("您必须在车辆中才能附加")
        return
    end
    local pos = ENTITY.GET_ENTITY_COORDS(player_vehicle, 1)
    local range = 20
    local nearby_vehicles = entities.get_all_vehicles_as_handles()
    local count = 0
    for _, vehicle_handle in ipairs(nearby_vehicles) do
        if vehicle_handle ~= player_vehicle then
            local attachment = {handle=vehicle_handle, root=player_vehicle}
            attachment.position = ENTITY.GET_ENTITY_COORDS(attachment.handle, 1)
            attachment.distance = SYSTEM.VDIST(pos.x, pos.y, pos.z, attachment.position.x, attachment.position.y, attachment.position.z)
            if attachment.distance <= range then
                detach_attached_vehicle()
                attachment.name = VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(attachment.handle))
                util.toast("已附加 "..attachment.name)
                attach(attachment)
                statecar.attached_vehicle = attachment
                return
            end
        end
    end
end


--烟雾掉帧
function fumes(pid)
local freeze_toggle = menu.ref_by_rel_path(menu.player_root(pid), "Trolling>Freeze")
local player_pos = players.get_position(pid)
menu.set_value(freeze_toggle, true)
request_ptfx_asset("core")
GRAPHICS.USE_PARTICLE_FX_ASSET("core")
GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
    "exp_extinguisher", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
menu.set_value(freeze_toggle, false)
end


----按键显示
function newColor(R, G, B, A)
    return {r = R, g = G, b = B, a = A}
end
size = 0.03
boxMargin = size / 7
overlay_x = 0.0400
overlay_y = 0.1850
local x, y = directx.get_client_size()
local ratio = x/y
local spaceBarLength = 3
local spaceBarSlim = 1
local altSpaceBar = 0
local key_text_color = newColor(1, 1, 1, 1)
local background_colour = newColor(0, 0, 0, 0.2)
local pressed_background_colour = newColor(2.55/255, 2.55/255, 2.55/255, 0.5490196078431373)
local wasd = {
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
function key_display()
    for i = 1, #wasd do
        wasd[i].pressed = false
        for j = 1, #wasd[i].keys do
            if PAD.IS_CONTROL_PRESSED(2, wasd[i].keys[j]) then
                wasd[i].pressed = true
            end
        end
    end
    for i = 1, #wasd - 3 do
        if wasd[i].show then
            directx.draw_rect(overlay_x + (boxMargin + size) * (i > 4 and i - 5 or i - 1), overlay_y + (i > 4 and (boxMargin + size * ratio) or 0)* 1.05, size, size * ratio, wasd[i].pressed and pressed_background_colour or background_colour)
            if not hideKey then
                directx.draw_text(overlay_x + (boxMargin + size) * (i > 4 and i - 5 or i - 1)+ size * 0.45,(i > 4 and  overlay_y + (boxMargin + size * ratio)* 1.2 or  overlay_y*1.07) , wasd[i].key, 1, size *20, key_text_color, false)
            end
        end
    end
    if altShiftCtrl then
        if wasd[#wasd - 2].show then
            directx.draw_rect(overlay_x, overlay_y + (boxMargin + size)* ratio * 2,(boxMargin + size) - boxMargin, size * ratio / 2, wasd[#wasd - 2].pressed and pressed_background_colour or background_colour)
        end
        if wasd[#wasd - 1].show then
            directx.draw_rect(overlay_x, overlay_y + (boxMargin + size)* ratio * 2.5,(boxMargin + size) - boxMargin, size * ratio / 2, wasd[#wasd - 1].pressed and pressed_background_colour or background_colour)
        end
    else
        for i = 9, 10 do
            if wasd[i].show then
            directx.draw_rect(overlay_x - (boxMargin + size), overlay_y + (boxMargin + size * ratio) * (i - 8) * 1.05, size, size * ratio, wasd[i].pressed and pressed_background_colour or background_colour)
            if not hideKey then
                directx.draw_text(overlay_x - (boxMargin + size)+ size * 0.45,(i > 4 and  overlay_y + (boxMargin + size * ratio) * (i - 8)* 1.2 or  overlay_y*1.07) , wasd[i].key, 1, size *20, key_text_color, false)

            end
            end
        end
    end
    if wasd[#wasd].show then
        directx.draw_rect(overlay_x + (boxMargin + size) * altSpaceBar, overlay_y + (boxMargin + size)* ratio * 2,(boxMargin + size) * spaceBarLength - boxMargin, size * ratio / spaceBarSlim, wasd[#wasd].pressed and pressed_background_colour or background_colour)
    end
end


-----绘制血量条
function draw_rect(x, y, width, height, colour)
	GRAPHICS.DRAW_RECT(x, y, width, height, colour.r, colour.g, colour.b, colour.a, false)
end
function draw_health_bar(ped, maxDistance)
	local myPos = players.get_position(players.user())
	local pedPos = ENTITY.GET_ENTITY_COORDS(ped, true)
	local distance = myPos:distance(pedPos)
	if distance >= maxDistance then return end
	local distPerc = 1.0 - distance / maxDistance
	local healthPerc = 0.0
	local armourPerc = 0.0
	if not PED.IS_PED_FATALLY_INJURED(ped) then
		local armour = PED.GET_PED_ARMOUR(ped)
		armourPerc = armour / 100.0
		if armourPerc > 1.0 then armourPerc = 1.0 end
		local health = ENTITY.GET_ENTITY_HEALTH(ped) - 100.0
		local maxHealth = PED.GET_PED_MAX_HEALTH(ped) - 100.0
		healthPerc = health / maxHealth
		if healthPerc > 1.0 then healthPerc = 1.0 end
	end
	local maxLength = 0.05 * distPerc ^3
	local height = 0.008 * distPerc ^1.5
	local pos = PED.GET_PED_BONE_COORDS(ped, 0x322C --[[head]], 0.35, 0.0, 0.0)
	local pScreenX, pScreenY = memory.alloc(4), memory.alloc(4)
	if not GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(pos.x, pos.y, pos.z, pScreenX, pScreenY) then
		return
	end
	local screenX = memory.read_float(pScreenX)
	local screenY = memory.read_float(pScreenY)
	local barLength = interpolate(0.0, maxLength, healthPerc)
	local colour = get_blended_colour(healthPerc)
	draw_rect(screenX, screenY, maxLength + 0.002, height + 0.002, {r = 0, g = 0, b = 0, a = 120})
	draw_rect(screenX - maxLength/2 + barLength/2, screenY, barLength, height, colour)
	local barLength = interpolate(0.0, maxLength, armourPerc)
	local colour = get_hud_colour(HudColour.radarArmour)
	draw_rect(screenX, screenY + 1.5 * height, maxLength + 0.002, height + 0.002, {r = 0, g = 0, b = 0, a = 120})
	draw_rect(screenX - maxLength/2 + barLength/2, screenY + 1.5 * height, barLength, height, colour)
end


----------GPS导航/////lib
b_common_funcs = {}
b_common_funcs.new = function ()
    local self = {}
    self.address_from_pointer_chain = function (basePtr, offsets)
        local addr = memory.read_long(basePtr)
        for k = 1, (#offsets - 1) do
            addr = memory.read_long(addr + offsets[k])
            if addr == 0 then
                return 0
            end
        end
        addr = addr + offsets[#offsets]
        return addr
    end
    self.get_player_vehicle_class = function ()
        local veh = entities.get_user_vehicle_as_handle()
        return VEHICLE.GET_VEHICLE_CLASS(veh)
    end
    self.get_ascpect_ratio = function()
        local screen_x, screen_y = directx.get_client_size()
    
        return screen_x / screen_y
    end
    self.to_bits = function(num)
        local t={}
        while num>0 do
            rest=math.fmod(num,2)
            t[#t+1]=rest
            num=(num-rest)/2
        end
        return t
    end
    self.split = function (input, sep)
        local t={}
        for str in string.gmatch(input, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
    end
    local minimum = memory.alloc()
    local maximum = memory.alloc()
    self.get_pos_above_entity = function (entity)
        MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
        local maximum_vec = memory.read_vector3(maximum)
        return ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, 0, 0, maximum_vec.z)
    end
    self.copy_File = function(old_path, new_path)
        local old_file = io.open(old_path, "rb")
        local new_file = io.open(new_path, "wb")
        local old_file_sz, new_file_sz = 0, 0
        if not old_file or not new_file then
          return false
        end
        while true do
          local block = old_file:read(2^13)
          if not block then 
            old_file_sz = old_file:seek( "end" )
            break
          end
          new_file:write(block)
        end
        old_file:close()
        new_file_sz = new_file:seek( "end" )
        new_file:close()
        return new_file_sz == old_file_sz
      end
    return self
end
b_math_funcs = {}
b_math_funcs.new = function ()
    local self = {}
    self.lerp = function(a, b, t)
        return a + (b - a) * t
    end
    local EPSILON = 0.0000001
    self.RayIntersectsTriangle = function(rayOrigin, rayDirection, vertex1, vertex2, vertex3)
        local edge1, edge2, h, s, q, a, f, u, v
        edge1 = {x = vertex2.x - vertex1.x, y = vertex2.y - vertex1.y, z = vertex2.z - vertex1.z}
        edge2 = {x = vertex3.x - vertex1.x, y = vertex3.y - vertex1.y, z = vertex3.z - vertex1.z}
        h = {
            x =    edge2.y * rayDirection.z - edge2.z * rayDirection.y,
            y =    edge2.z * rayDirection.x - edge2.x * rayDirection.z,
            z =    edge2.x * rayDirection.y - edge2.y * rayDirection.x
        }
        a = h.x * edge1.x + h.y * edge1.y + h.z * edge1.z

        if a > -EPSILON and a < EPSILON then return false end

        f = 1.0/a
        s = {x = rayOrigin.x - vertex1.x, y = rayOrigin.y - vertex1.y, z = rayOrigin.z - vertex1.z}
        u = f * (h.x * s.x + h.y * s.y + h.z * s.z)
        if u < 0.0 or u > 1.0 then return false end
        q = {
            x =    edge1.y * s.z - edge1.z * s.y,
            y =    edge1.z * s.x - edge1.x * s.z,
            z =    edge1.x * s.y - edge1.y * s.x
        }
        v = f * (rayDirection.x * q.x + rayDirection.y * q.y + rayDirection.z * q.z)
        if v < 0.0 or u + v > 1.0 then return false end
        t = f *  (edge2.x * q.x + edge2.y * q.y + edge2.z * q.z)
        if t > EPSILON then
            return true, {
                x = rayOrigin.x + rayDirection.x * t,
                y = rayOrigin.y + rayDirection.y * t,
                z = rayOrigin.z + rayDirection.z * t
            }
        else
            return false
        end
    end
    return self
end
b_vectors = {}
b_vectors.new = function ()
    local self = {}
    self.vector2 = {}
    self.vector2.new = function (x, y)
        return {x = x, y = y}
    end
    self.vector2.dot = function(vector_a, vector_b)
        return (vector_a.x * vector_b.x) + (vector_a.y * vector_b.y)
    end
    self.vector2.magnitude = function(vector)
        return math.sqrt((vector.x * vector.x) + (vector.y * vector.y))
    end
    self.vector2.get_angle = function(vector_a, vector_b)
        return math.acos(self.vector2.dot(vector_a, vector_b) / self.vector2.magnitude(vector_a) / self.vector2.magnitude(vector_b))
    end
    self.vector3 = {}
    self.vector3.new = function (x, y, z)
        return {x = x, y = y, z = z}
    end
    self.vector3.add = function(a, b)
        return self.vector3.new(a.x + b.x, a.y + b.y, a.z + b.z)
    end
    self.vector3.sub = function(a, b)
        return self.vector3.new(a.x - b.x, a.y - b.y, a.z - b.z)
    end
    self.vector3.multiply = function (vec, num)
        return {x = vec.x * num, y = vec.y * num, z = vec.z * num}
    end
    return self
end
function get_waypoint_coords()
    return HUD.GET_BLIP_INFO_ID_COORD(HUD.GET_FIRST_BLIP_INFO_ID(HUD.GET_WAYPOINT_BLIP_ENUM_ID()))
end
local player_ped_id
local delta_time
local player_pos
util.create_tick_handler(function ()
    player_ped_id = PLAYER.PLAYER_PED_ID()
    delta_time = MISC.GET_FRAME_TIME()
    player_pos = ENTITY.GET_ENTITY_COORDS(player_ped_id)
    return true
end)
local math_funcs = b_math_funcs.new()
local shitty_gps_colour_a = {r = 255,g = 0,b = 255,a = 255}
local shitty_gps_colour_b = {r = 255,g = 255,b = 255,a = 255}
local shitty_gps_run = false
function GPS_navigation(value)
    local p_direction = memory.alloc(1) --bool
    local p_5 = memory.alloc(4) --float
    local p_distToNxJunction = memory.alloc(4) --float
    local p_screenX = memory.alloc(4) --float
    local p_screenY = memory.alloc(4) --float
    local turn_dir = 0
    shitty_gps_run = value
    if value then
    util.create_tick_handler(function ()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    local waypoint_pos = get_waypoint_coords()
    local total = waypoint_pos.x + waypoint_pos.y + waypoint_pos.z
    if total ~= 0 and ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
        local height = ENTITY.GET_ENTITY_HEIGHT(vehicle, player_pos.x, player_pos.y, player_pos.z, true, false)
        PATHFIND.GENERATE_DIRECTIONS_TO_COORD(
            waypoint_pos.x,
            waypoint_pos.y,
            waypoint_pos.z,
            0,
            p_direction,
            p_5,
            p_distToNxJunction
        )
        local direction = memory.read_byte(p_direction)
        local distToNxJunction = memory.read_float(p_distToNxJunction) - 18
        GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(
            player_pos.x,
            player_pos.y,
            player_pos.z + 1.5 + height,
            p_screenX,
            p_screenY
        )
        local screen_x = memory.read_float(p_screenX)
        local screen_y = memory.read_float(p_screenY)
       if direction == 1 then
            turn_dir = math_funcs.lerp(turn_dir, 180, 5 * delta_time)
            directx.draw_text(screen_x, screen_y, "请在前方路口调头", ALIGN_CENTRE, 1, shitty_gps_colour_a)
        elseif direction == 3 then      
            turn_dir =  math_funcs.lerp(turn_dir, -90, 5 * delta_time)
            if math.floor(distToNxJunction) > -1 then
                directx.draw_text(screen_x,screen_y,"请在前方路口" .. math.floor(distToNxJunction) .. " 米后左转 ",ALIGN_CENTRE,1,shitty_gps_colour_a)
            end
        elseif direction == 6 then
            turn_dir =  math_funcs.lerp(turn_dir, -145, 5 * delta_time)
            if math.floor(distToNxJunction) > -1 then
                directx.draw_text(screen_x,screen_y, math.floor(distToNxJunction) .. " 米后向左急转弯 ",ALIGN_CENTRE,1,shitty_gps_colour_a)
            end
        elseif direction == 4 then          
            turn_dir =  math_funcs.lerp(turn_dir, 90, 5 * delta_time)
            if math.floor(distToNxJunction) > -1 then
                directx.draw_text(screen_x,screen_y,"请在前方路口 " .. math.floor(distToNxJunction) .. " 米后右转",ALIGN_CENTRE,1,shitty_gps_colour_a)
            end
        elseif direction == 7 then
            turn_dir =  math_funcs.lerp(turn_dir, 145, 5 * delta_time)
            if math.floor(distToNxJunction) > -1 then
                directx.draw_text(screen_x,screen_y,math.floor(distToNxJunction) .. " 米后向右急转弯 " ,ALIGN_CENTRE,1,shitty_gps_colour_a)
            end
        elseif direction == 8 then
            turn_dir =  math_funcs.lerp(turn_dir, 0, 5 * delta_time)
            directx.draw_text(screen_x, screen_y, "正在重新规划路线    ", ALIGN_CENTRE, 1, shitty_gps_colour_a)
        else
            turn_dir =  math_funcs.lerp(turn_dir, 0, 5 * delta_time)
        end
        local direction = ENTITY.GET_ENTITY_FORWARD_VECTOR(player_ped_id)
        local angle = b_vectors.new().vector2.get_angle(direction, {x = 0, y = 1})
        if b_vectors.new().vector2.dot({x = direction.x, y = direction.y}, {x = 1, y = 0}) > 0 then
            angle = -angle
        end
        local draw_pos = b_common_funcs.new().get_pos_above_entity(vehicle)
        draw_pos.z = draw_pos.z + 0.4
        drawing_funcs.draw_arrow(draw_pos, angle - math.rad(turn_dir), 1, shitty_gps_colour_a, shitty_gps_colour_b)
    end
    return shitty_gps_run
    end)
    end
end



------给予所有玩家MK-2
function upgrade_vehicle(vehicle)
    for i = 0, 49 do
        local num = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i)
        VEHICLE.SET_VEHICLE_MOD(vehicle, i, num - 1, true)
    end
end
function give_oppressor(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 5.0, 0.0)
    local hash = util.joaat("oppressor2")
    request_model(hash)
    local oppressor = entities.create_vehicle(hash, c, ENTITY.GET_ENTITY_HEADING(ped))
    ENTITY.SET_ENTITY_INVINCIBLE(oppressor)
    upgrade_vehicle(oppressor)
end



--------崩溃XP
function CreateVehicle(Hash, Pos, Heading, Invincible)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_vehicle(Hash, Pos, Heading)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    if Invincible then
        ENTITY.SET_ENTITY_INVINCIBLE(SpawnedVehicle, true)
    end
    return SpawnedVehicle
end
function CreateObject(Hash, Pos, static)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_object(Hash, Pos)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    if static then
        ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicle, true)
    end
    return SpawnedVehicle
end
function CreatePed(index, Hash, Pos, Heading)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_ped(index, Hash, Pos, Heading)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    return SpawnedVehicle
end
function xp_over(pid)
local model_array = {util.joaat("boattrailer"),util.joaat("trailersmall"),util.joaat("raketrailer"),}
        local BAD_attach = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
        local fuck_ped = CreatePed(26 , util.joaat("ig_kaylee"), BAD_attach, 0)
        ENTITY.SET_ENTITY_VISIBLE(fuck_ped, false)
        for i = 1, 3, 1 do
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(fuck_ped, BAD_attach.x, BAD_attach.y, BAD_attach.z)
            for spawn, value in pairs(model_array) do
                local vels = {}
                vels[spawn] = CreateVehicle(value, BAD_attach, 0)
                for attach, value in pairs(vels) do
                    ENTITY1.ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD(value, fuck_ped, 0, 0, true, true)
                end
            end
            util.yield(500)
            menu.trigger_commands("explode" ..  players.get_name(pid))
        end
end



------飞机模型崩溃
planes = {'microlight', 'cuban800', 'tula', 'alphaz1', 'velum2', 'nimbus', 'seabreeze'}
coords = {
    {-1718.5878, -982.02405, 322.83115},
    {-2671.5007, 3404.2637, 455.1972},
    {9.977266, 6621.406, 306.46536 },
    {3529.1458, 3754.5452, 109.96472},
    {252, 2815, 120},
}
local to_ply = 1
function RqModel(hash)
    STREAMING.REQUEST_MODEL(hash)
    local count = 0
    util.toast("请求模型...")
    while not STREAMING.HAS_MODEL_LOADED(hash) and count < 100 do
        STREAMING.REQUEST_MODEL(hash)
        count = count + 1
        util.yield(10)
    end
    if not STREAMING.HAS_MODEL_LOADED(hash) then
        util.toast("尝试了1秒,无法加载此指定模型!")
    end
end

function GetLocalPed()
    return PLAYER.PLAYER_PED_ID()
end
G_GeneratedList = false
function AddEntityToList(listName, handle, generatedCheck)
    if ((not G_GeneratedList) and generatedCheck) or (not generatedCheck) then
        G_GeneratedList = true
        local lis = menu.list(menu.my_root(), listName .. " handle " .. handle, {}, "")
        menu.action(lis, "删除", {}, "", function()
            entities.delete(handle)
            menu.delete(lis)
            G_GeneratedList = false
        end)
        menu.action(lis, "传送到实体", {}, "", function()
            local pos = ENTITY.GET_ENTITY_COORDS(handle)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(GetLocalPed(), pos.x, pos.y, pos.z + 1, false, false, false)
        end)
        menu.action(lis, "驾驶实体", {}, "", function()
            PED.SET_PED_INTO_VEHICLE(GetLocalPed(), handle, -1)
        end)
        menu.action(lis, "传送到我", {}, "", function()
            local pos = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(handle, pos.x, pos.y, pos.z + 1, false, false, false)
        end)
    end
end
function airplane_collapsed1()
    menu.trigger_commands("anticrashcamera on")
    if PED.IS_PED_IN_ANY_VEHICLE(GetLocalPed(), false) then
        local jet = PED.GET_VEHICLE_PED_IS_IN(GetLocalPed(), false)
        ENTITY.SET_ENTITY_PROOFS(jet, true, true, true, true, true, true, true, true)
        if players.exists(to_ply) then 
            local asda = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(to_ply)) 
            util.toast('Player ID: '..to_ply..' | asda.x: '.. asda.x.. 'asda.y: '.. asda.y..'asda.z: '.. asda.z)
            ENTITY.SET_ENTITY_COORDS(jet, asda.x, asda.y, asda.z + 50, false, false, false, true) 
            to_ply = to_ply +1
        else 
            if to_ply >= 32 then to_ply = 0 end
            to_ply = to_ply +1 
            local let_coords = coords[math.random(1, #coords)]
            ENTITY.SET_ENTITY_COORDS(jet, let_coords[1], let_coords[2], let_coords[3], false, false, false, true) 
        end
            
        ENTITY.SET_ENTITY_VELOCITY(jet, 0, 0, 0) -- velocity sync fuck
        ENTITY.SET_ENTITY_ROTATION(jet, 0, 0, 0, 2, true) -- rotation sync fuck
        local pedpos = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
        pedpos.z = pedpos.z + 10
        for i = 1, 2 do
            local s_plane = planes[math.random(1, #planes)]
            RqModel(util.joaat(s_plane))
            local veha1 = entities.create_vehicle(util.joaat(s_plane), pedpos, 0)

            ENTITY.ATTACH_ENTITY_TO_ENTITY_PHYSICALLY(veha1, jet, 0, 0, 0, 0, 5 + (2 * i), 0, 0, 0, 0, 0, 0, 1000, true, true, true, true, 2)
        end
        AddEntityToList("Plane: ", jet, true)
        util.toast("等待同步5秒...")
        util.yield(100) -- 5k is original
        for i = 1, 25 do -- 50 is original
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(jet, math.random(0, 2555), math.random(0, 2815), math.random(1, 1232), false, false, false) 
            util.yield()
        end
    else
        RqModel(util.joaat('hydra'))
        local spawn_in = entities.create_vehicle(util.joaat('hydra'), ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID()), 0.0)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), spawn_in, -1)
    end
end


----索赔载具
function reclaimVehicles()
    notification("~bold~~y~全部索赔完成", HudColour.blue)
	for k, v in menu.get_children(menu.ref_by_path("Vehicle>Personal Vehicles")) do
        for k1, v1 in v.command_names do
            if v1 ~= "findpv" then
                if v1 == "pv2" then
                    menu.trigger_commands(v1.."request")
                end
            end
        end
	end
end

----飞天扫把
function flying_broom(on)
    if on then 
        local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
        local broomstick = util.joaat("prop_tool_broom")
        local oppressor = util.joaat("oppressor2")
        request_model(broomstick)
        request_model(oppressor)
        obj = entities.create_object(broomstick, pos)
        veh = entities.create_vehicle(oppressor, pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(veh, false, false)
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, 0, 0, 0.3, -80.0, 0, 0, true, false, false, false, 0, true, 0) -- thanks to chaos mod for doing the annoying rotation work for me :P
    else
        entities.delete(obj)
        entities.delete(veh)
    end
end

----分离元素
function detach_all_entities()
    local vehs = entities.get_all_vehicles_as_handles()
    local objs = entities.get_all_objects_as_handles()
    local peds = entities.get_all_peds_as_handles()
    for k,v in pairs(vehs) do
        if ENTITY.IS_ENTITY_ATTACHED_TO_ANY_PED(v) then
            request_control_of_entity(v)
            ENTITY.DETACH_ENTITY(v, false, false)
        end
    end
    for k,v in pairs(objs) do
        if ENTITY.IS_ENTITY_ATTACHED_TO_ANY_PED(v) then
            request_control_of_entity(v)
            ENTITY.DETACH_ENTITY(v, false, false)
        end
    end
    for k,v in pairs(peds) do
        if ENTITY.IS_ENTITY_ATTACHED_TO_ANY_PED(v) then
            request_control_of_entity(v)
            ENTITY.DETACH_ENTITY(v, false, false)
        end
    end
end


----热成像枪
local thermal_command = menu.ref_by_path('Game>Rendering>Thermal Vision')
function thermalgun()
    local aiming = PLAYER.IS_PLAYER_FREE_AIMING(players.user())
    if GRAPHICS.GET_USINGSEETHROUGH() and not aiming then
        menu.trigger_command(thermal_command,'off')
        GRAPHICS1._SEETHROUGH_SET_MAX_THICKNESS(1)
    elseif PAD.IS_CONTROL_JUST_PRESSED(38,38) then
        if menu.get_value(thermal_command) or not aiming then
            menu.trigger_command(thermal_command,"off")
            GRAPHICS1._SEETHROUGH_SET_MAX_THICKNESS(1)
        else
            menu.trigger_command(thermal_command,"on")
            GRAPHICS1._SEETHROUGH_SET_MAX_THICKNESS(50)
        end
    end
end


--幽灵战车
function elqss(on)
    if on then
        notification("~bold~~y~按E使用战车技能", HudColour.blue)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        local vhash = 1491277511
        local obj = 1793667637
        request_model(vhash)
        request_model(obj)
        ghost_car = entities.create_vehicle(1491277511, pos, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(ghost_car,true)
        ghost_nuts = OBJECT.CREATE_OBJECT(1793667637, pos.x, pos.y, pos.z, true, false, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(ghost_nuts, ghost_car, 0, 0, 0, 0, 0, 0, 0, true, false, false, false, 0, true, 0)
        local titlle = "scr_martin1"
        local hashid = "scr_sol1_plane_engine_fire"
        request_ptfx_asset(titlle)
        GRAPHICS.USE_PARTICLE_FX_ASSET(titlle)
        GRAPHICS.START_PARTICLE_FX_LOOPED_ON_ENTITY(hashid, ghost_nuts, 0, 0.1, -0.3, 180, 0, 0, 0.5, 1, 1, 1)
        SYSTEM.WAIT(500)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), ghost_car, -1)
        while ghost_car do
            if PAD.IS_CONTROL_PRESSED(46,46) then
                local titlle = "weap_xs_vehicle_weapons"
                local hashid = "muz_xs_turret_flamethrower_looping"
                request_ptfx_asset(titlle)
                GRAPHICS.USE_PARTICLE_FX_ASSET(titlle)
                GRAPHICS.START_PARTICLE_FX_LOOPED_ON_ENTITY(hashid, ghost_car, 0, 1, 0.5, 180, 0, 0, 1, 1, 1, 1)
                util.yield(500)
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(ghost_car)
            end
            util.yield()
        end
    else
        if ENTITY.DOES_ENTITY_EXIST(ghost_car) and ENTITY.DOES_ENTITY_EXIST(ghost_nuts) then
            entities.delete(ghost_car)
            entities.delete(ghost_nuts)
        end
    end
end

----光环
Colour = {}
Colour.new = function(R, G, B, A)
    return {r = R or 0, g = G or 0, b = B or 0, a = A or 0}
end
function request_fx_asset(asset)
	STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
	while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
		util.yield()
	end
end
function personllight()
    local localPed = PLAYER.PLAYER_PED_ID()
    local fect = Effect.new("scr_xm_farm", "scr_xm_dst_elec_crackle")
    local effect = Effect.new("scr_ie_tw", "scr_impexp_tw_take_zone")
    local colour = Colour.new(5, 0, 0, 30)
    local colour2 = Colour.new(5, 50, 10, 30)
    request_fx_asset(effect.asset)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour.r, colour.g, colour.b)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
        effect.name,
        localPed,
        0.0, 0.0, 0.75,
        0.0, 0.0, 0.0,
        0.09,
        false, false, false)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour2.r, colour2.g, colour2.b)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
        effect.name,
        localPed,
        0.0, 0.0, -2.9,
        0.0, 0.0, 0.0,
        1.0,
        false, false, false)
end

----派遣劫匪
function sendmugger_npc(pid)
    if NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
        util.toast("当前劫匪活动还未结束哦")
    else
        local bits_addr = memory.script_global(1853910 + (players.user() * 862 + 1) + 140)
            memory.write_int(bits_addr, SetBit(memory.read_int(bits_addr), 0))
            write_global.int(1853910 + (players.user() * 862 + 1) + 141, pid)
        util.toast("劫匪已出动")
    end
end


----拉便便
local agroup = "missfbi3ig_0"
local mshit = util.joaat("prop_big_shit_02")
local agroup2 = "switch@trevor@jerking_off"
local cum = util.joaat("p_oil_slick_01")
local anim2 = "trev_jerking_off_loop"
local anim = "shit_loop_trev"
function personlshit()
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    c.z = c.z - 1
    request_anim_dict(agroup)
    TASK.TASK_PLAY_ANIM(players.user_ped(), agroup, anim, 8.0, 8.0, 3000, 0, 0, true, true, true) --play anim
    util.yield(1000)
    local shit = create_object(mshit, c.x, c.y, c.z) --spawn shit
    util.yield(60000)
    entities.delete(shit) --delete shit
end
--打飞机
function personlhitplane() 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    request_anim_dict(agroup2)
    TASK.TASK_PLAY_ANIM(players.user_ped(), agroup2, anim2, 8.0, 8.0, 5000, 1, 0, true, true, true) --play anim
    util.yield(4500)
    local cum = create_object(cum, c.x, c.y, c.z - 1) --spawn cum
    util.yield(60000)
    entities.delete(cum) --delete cum
end



--粘弹爆炸
local detonate_radius = 2
function autoExplodeStickys(ped)
    local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
    if MISC.IS_PROJECTILE_TYPE_WITHIN_DISTANCE(pos.x, pos.y, pos.z, util.joaat('weapon_stickybomb'), detonate_radius, true) then
        WEAPON.EXPLODE_PROJECTILES(players.user_ped(), util.joaat('weapon_stickybomb'))
    end
end
function proxyStickys()
    if detonate_players then
        local specificWhitelistGroup = {user = false,  friends = whitelistGroups.friends, strangers = whitelistGroups.strangers}
        local playerList = getNonWhitelistedPlayers(whitelistListTable, specificWhitelistGroup, whitelistedName)
        for _, pid in pairs(playerList) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            autoExplodeStickys(ped)
        end
    end
    if detonate_npcs then
        local pedHandles = entities.get_all_peds_as_handles()
        for _, ped in pairs(pedHandles) do
            if not PED.IS_PED_A_PLAYER(ped) then
                autoExplodeStickys(ped)
            end
        end
    end
end


--速度表
function vehicle_speedometer(state)
    speedm = state  
    while speedm do
        local ent
            local ent1 = players.user_ped()
            local ent2 = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
            if PED.IS_PED_IN_ANY_VEHICLE(ent1,true) then
                ent = ent2
            else
                ent = ent1
            end
            local speed = ENTITY.GET_ENTITY_SPEED(ent)
            local speedcalc = speed * 3.6
            myspeed1 = math.ceil(speedcalc)
        util.yield()
        draw_string(string.format("~bold~~italic~~o~"..myspeed1 .. "  ~w~KM/H"), 0.76,0.8, 1,6)
    end
end

--摔倒
local fallTimeout = false
function tripped1(toggle)
    if toggle then
        local vector = ENTITY.GET_ENTITY_FORWARD_VECTOR(players.user_ped())
        PED.SET_PED_TO_RAGDOLL_WITH_FALL(players.user_ped(), 1500, 2000, 2, vector.x, -vector.y, vector.z, 1, 0, 0, 0, 0, 0, 0)
    end
    fallTimeout = toggle
    while fallTimeout do
        PED.RESET_PED_RAGDOLL_TIMER(players.user_ped())
        util.yield_once()
    end
end
function tripped2()
    PED.SET_PED_TO_RAGDOLL(players.user_ped(), 2000, 2000, 0, true, true, true)
end