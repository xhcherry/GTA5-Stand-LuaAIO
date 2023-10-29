ESP_World = menu.list(fb,"透视预览", {""}, "")
--原地起飞
function is_user_driving_vehicle()
    return (PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) and VEHICLE.GET_PED_IN_VEHICLE_SEAT(entities.get_user_vehicle_as_handle(), -1, false) == players.user_ped())
end
--
is_player_pointing = function ()
    return read_global.int(4521801 + 930) == 3 -- didn't change
end

function set_explosion_proof(entity, value)
    local pEntity = entities.handle_to_pointer(entity)
    if pEntity == 0 then return end
    local damageBits = memory.read_uint(pEntity + 0x188)
    damageBits = value and SetBit(damageBits, 11) or ClearBit(damageBits, 11)
    memory.write_uint(pEntity + 0x188, damageBits)
end

function request_control_once(entity)
    if not NETWORK.NETWORK_IS_IN_SESSION() then
        return true
    end
    local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
    return NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
end

function draw_bounding_boxes(entity, showPoly, colour)
    if not ENTITY.DOES_ENTITY_EXIST(entity) then
        return
    end
    colour = colour or {r = 0, g = 255, b = 0, a = 55}
    min = ENTITY.GET_ENTITY_COORDS(players.user_ped(), true)
    max = ENTITY.GET_ENTITY_COORDS(players.user_ped(), true)
    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), min, max)
    min:abs(); max:abs()

    upperLeftRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, -max.y, max.z)
    upperRightRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, -max.y, max.z)
    lowerLeftRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, -max.y, -min.z)
    lowerRightRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, -max.y, -min.z)

    draw_lines(upperLeftRear, upperRightRear, colour)
    draw_lines(lowerLeftRear, lowerRightRear, colour)
    draw_lines(upperLeftRear, lowerLeftRear, colour)
    draw_lines(upperRightRear, lowerRightRear, colour)

    upperLeftFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, min.y, max.z)
    upperRightFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, min.y, max.z)
    lowerLeftFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, min.y, -min.z)
    lowerRightFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, min.y, -min.z)

    draw_lines(upperLeftFront, upperRightFront, colour)
    draw_lines(lowerLeftFront, lowerRightFront, colour)
    draw_lines(upperLeftFront, lowerLeftFront, colour)
    draw_lines(upperRightFront, lowerRightFront, colour)

    draw_lines(upperLeftRear, upperLeftFront, colour)
    draw_lines(upperRightRear, upperRightFront, colour)
    draw_lines(lowerLeftRear, lowerLeftFront, colour)
    draw_lines(lowerRightRear, lowerRightFront, colour)

    if type(showPoly) ~= "boolean" or showPoly then
        draw_rects(lowerLeftRear, upperLeftRear, lowerLeftFront, upperLeftFront, colour)
        draw_rects(upperRightRear, lowerRightRear, upperRightFront, lowerRightFront, colour)

        draw_rects(lowerLeftFront, upperLeftFront, lowerRightFront, upperRightFront, colour)
        draw_rects(upperLeftRear, lowerLeftRear, upperRightRear, lowerRightRear, colour)

        draw_rects(upperRightRear, upperRightFront, upperLeftRear, upperLeftFront, colour)
        draw_rects(lowerRightFront, lowerRightRear, lowerLeftFront, lowerLeftRear, colour)
    end
end

function get_raycast_result(dist, flag)
    local result = {}
    flag = flag or TraceFlag.everything
    local didHit = memory.alloc(1)
    local endCoords = ENTITY.GET_ENTITY_COORDS(players.user_ped(), true)
    local normal = ENTITY.GET_ENTITY_COORDS(players.user_ped(), true)
    local hitEntity = memory.alloc_int()
    local camPos = CAM.GET_FINAL_RENDERED_CAM_COORD()
    local offset = get_offset_from_cam(dist)

    local handle = SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
        camPos.x, camPos.y, camPos.z,
        offset.x, offset.y, offset.z,
        flag,
        players.user_ped(), 7
    )
    SHAPETEST.GET_SHAPE_TEST_RESULT(handle, didHit, endCoords, normal, hitEntity)

    result.didHit = memory.read_byte(didHit) ~= 0
    result.endCoords = endCoords
    result.surfaceNormal = normal
    result.hitEntity = memory.read_int(hitEntity)
    return result
end

local targetEntity = NULL
local lastStop <const> = newTimer()
local explosionProof = false

menu.toggle_loop(fb, "手指黑洞", {"gtfinger"}, "开启后按B等待即可", function()
    if is_player_pointing() then
        write_global.int(4521801 + 935, NETWORK.GET_NETWORK_TIME()) -- to avoid the animation to stop
        if not ENTITY.DOES_ENTITY_EXIST(targetEntity) then
            local flag = TraceFlag.peds | TraceFlag.vehicles | TraceFlag.pedsSimpleCollision | TraceFlag.objects
            local raycastResult = get_raycast_result(500.0, flag)
            if raycastResult.didHit and ENTITY.DOES_ENTITY_EXIST(raycastResult.hitEntity) then
                targetEntity = raycastResult.hitEntity
            end
        else
                local dont_stop = false
                for k, veh in pairs(entities.get_all_vehicles_as_handles()) do
                    local PedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, false)
                    local locspeed2 = speed
                    local holecoords = players.get_position(players.user())
                if not PED.IS_PED_A_PLAYER(PedInSeat) then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                    ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(bh_target), true)
                    vcoords = ENTITY.GET_ENTITY_COORDS(veh, true)
                    speed = 100
                    local x_vec = (holecoords['x']-vcoords['x'])*speed
                    local y_vec = (holecoords['y']-vcoords['y'])*speed
                    local z_vec = ((holecoords['z']+hole_zoff)-vcoords['z'])*speed
                    hole_zoff = 100
                    ENTITY.SET_ENTITY_INVINCIBLE(veh, true)
                    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, x_vec, y_vec, z_vec, true, false, true, true)
                if not dont_stop and not PAD.IS_CONTROL_PRESSED(2, 71) and not PAD.IS_CONTROL_PRESSED(2, 72) then
                    VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0.0);
                    draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
                    end
                end
            end
            local myPos = players.get_position(players.user())
            local entityPos = ENTITY.GET_ENTITY_COORDS(targetEntity, true)
            local camDir = CAM.GET_GAMEPLAY_CAM_ROT(0):toDir()
            local distance = myPos:distance(entityPos)
            if distance > 30.0 then distance = 30.0
            elseif distance < 10.0 then distance = 10.0 end
            local targetPos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), camDir, true)
            targetPos:mul(distance)
            targetPos:add(myPos)
            local direction = ENTITY.GET_ENTITY_COORDS(players.user_ped(), targetPos, true)
            direction:sub(entityPos)
            direction:normalise()
            if ENTITY.IS_ENTITY_A_PED(targetEntity) then
                direction:mul(1.0)
                local explosionPos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), entityPos, true)
                explosionPos:sub(direction)
                draw_bounding_box(targetEntity, false, {r = 80, g = 0, b = 255, a = 255})
                set_explosion_proof(players.user_ped(), true)
                explosionProof = true
                FIRE.ADD_EXPLOSION(explosionPos.x, explosionPos.y, explosionPos.z, 29, 25.0, false, true, 0.0, true)
                
            else
                local vel = ENTITY.GET_ENTITY_COORDS(players.user_ped(), direction, true)
                local magnitude = entityPos:distance(targetPos)
                vel:mul(magnitude)
                draw_bounding_box(targetEntity, true, {r = 80, g = 0, b = 255, a = 80})
                request_control_once(targetEntity)
                ENTITY.SET_ENTITY_VELOCITY(targetEntity, vel.x, vel.y, vel.z)
            end
        end
    elseif targetEntity ~= NULL then
        lastStop.reset()
        targetEntity = NULL

    elseif explosionProof and lastStop.elapsed() > 500 then
        -- No need to worry about disabling any proof if Stand's godmode is on, because
        -- it'll turn them back on anyways
        explosionProof = false
        set_explosion_proof(players.user_ped(), false)
    end
end)

dont_stop = false
menu.toggle_loop(fb,"吹走所有载具", {"huhuveh"}, "开启后按B对准车辆", function()
if is_player_pointing() then
    write_global.int(4521801 + 935, NETWORK.GET_NETWORK_TIME()) -- to avoid the animation to stop
    if not ENTITY.DOES_ENTITY_EXIST(targetEntity) then
        local flag = TraceFlag.peds | TraceFlag.vehicles | TraceFlag.pedsSimpleCollision | TraceFlag.objects
        local raycastResult = get_raycast_result(500.0, flag)
        if raycastResult.didHit and ENTITY.DOES_ENTITY_EXIST(raycastResult.hitEntity) then
            targetEntity = raycastResult.hitEntity
        end
    else
for k, veh in pairs(entities.get_all_vehicles_as_handles()) do
    local PedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, false)
    if not PED.IS_PED_A_PLAYER(PedInSeat) then
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
        cam_pos = CAM.GET_GAMEPLAY_CAM_ROT(0)
        ENTITY.SET_ENTITY_ROTATION(veh, cam_pos.x, cam_pos.y, cam_pos.z, 1, true);
        local locspeed = speed*10
        local locspeed2 = speed
    if not dont_stop and not PAD.IS_CONTROL_PRESSED(2, 71) and not PAD.IS_CONTROL_PRESSED(2, 72) then
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0.0);
        draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
    end
    if PAD.IS_CONTROL_PRESSED(0, 61) then
        locspeed = locspeed*2
        locspeed2 = locspeed2*2
        draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
    end
    if PAD.IS_CONTROL_PRESSED(2, 71) then
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, speed, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
            draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
        else 
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, locspeed)
            draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
        end
    end
    if PAD.IS_CONTROL_PRESSED(2, 72) then
        local lsp = speed
        draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
        if not PAD.IS_CONTROL_PRESSED(0, 61) then 
            lsp = speed * 2
            draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
        end
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0 - (lsp), 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
            draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
        else 
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0 - (locspeed));
            draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
        end
   end
    if PAD.IS_CONTROL_PRESSED(2, 63) then
        local lsp = (0 - speed)*2
        draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
        if not PAD.IS_CONTROL_PRESSED(0, 61) then 
            lsp = 0 - speed
            draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
        end
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, (lsp), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
            draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
        else 
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0 - (locspeed), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1);
            draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
        end
    end
    if PAD.IS_CONTROL_PRESSED(2, 64) then
        local lsp = speed
        draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
        if not PAD.IS_CONTROL_PRESSED(0, 61) then 
            lsp = speed*2
            draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
        end
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, lsp, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
            draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
        else 
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, locspeed, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
            draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
        end
    end
    if not dont_stop and not PAD.IS_CONTROL_PRESSED(2, 71) and not PAD.IS_CONTROL_PRESSED(2, 72) then
        draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0.0);
            end
        end
    end
end
end
end)

function Draw_Box_Peds()
    if not ENTITY.DOES_ENTITY_EXIST(targetEntity) then
        local flag = TraceFlag.peds | TraceFlag.vehicles | TraceFlag.pedsSimpleCollision | TraceFlag.objects
        local raycastResult = get_raycast_result(500.0, flag)
        if raycastResult.didHit and ENTITY.DOES_ENTITY_EXIST(raycastResult.hitEntity) then
            targetEntity = raycastResult.hitEntity
        end
    else
        for k, veh in pairs(entities.get_all_peds_as_handles()) do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(bh_target), true)
            draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
            end
            local myPos = players.get_position(players.user())
            local entityPos = ENTITY.GET_ENTITY_COORDS(targetEntity, true)
            local camDir = CAM.GET_GAMEPLAY_CAM_ROT(0):toDir()
            local distance = myPos:distance(entityPos)
            if distance > 30.0 then distance = 30.0
            elseif distance < 10.0 then distance = 10.0 end
            local targetPos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), camDir, true)
            targetPos:mul(distance)
            targetPos:add(myPos)
            local direction = ENTITY.GET_ENTITY_COORDS(players.user_ped(), targetPos, true)
            direction:sub(entityPos)
            direction:normalise()
        if ENTITY.IS_ENTITY_A_PED(targetEntity) then
            direction:mul(1.0)
            local explosionPos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), entityPos, true)
            explosionPos:sub(direction)
            draw_bounding_box(targetEntity, false, {r = 80, g = 0, b = 255, a = 255})
        end
    end
end

function Draw_Box_Pickups()
    if not ENTITY.DOES_ENTITY_EXIST(targetEntity) then
        local flag = TraceFlag.peds | TraceFlag.vehicles | TraceFlag.pedsSimpleCollision | TraceFlag.objects
        local raycastResult = get_raycast_result(500.0, flag)
        if raycastResult.didHit and ENTITY.DOES_ENTITY_EXIST(raycastResult.hitEntity) then
            targetEntity = raycastResult.hitEntity
        end
    else
        for k, veh in pairs(entities.get_all_pickups_as_handles()) do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(bh_target), true)
            draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
            end
            local myPos = players.get_position(players.user())
            local entityPos = ENTITY.GET_ENTITY_COORDS(targetEntity, true)
            local camDir = CAM.GET_GAMEPLAY_CAM_ROT(0):toDir()
            local distance = myPos:distance(entityPos)
            if distance > 30.0 then distance = 30.0
            elseif distance < 10.0 then distance = 10.0 end
            local targetPos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), camDir, true)
            targetPos:mul(distance)
            targetPos:add(myPos)
            local direction = ENTITY.GET_ENTITY_COORDS(players.user_ped(), targetPos, true)
            direction:sub(entityPos)
            direction:normalise()
        if ENTITY.IS_ENTITY_A_PED(targetEntity) then
            direction:mul(1.0)
            local explosionPos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), entityPos, true)
            explosionPos:sub(direction)
            draw_bounding_box(targetEntity, false, {r = 80, g = 0, b = 255, a = 255})
        end
    end
end

function Draw_Box_Objects()
    if not ENTITY.DOES_ENTITY_EXIST(targetEntity) then
        local flag = TraceFlag.peds | TraceFlag.vehicles | TraceFlag.pedsSimpleCollision | TraceFlag.objects
        local raycastResult = get_raycast_result(500.0, flag)
        if raycastResult.didHit and ENTITY.DOES_ENTITY_EXIST(raycastResult.hitEntity) then
            targetEntity = raycastResult.hitEntity
        end
    else
        for k, veh in pairs(entities.get_all_objects_as_handles()) do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(bh_target), true)
            draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
            end
            local myPos = players.get_position(players.user())
            local entityPos = ENTITY.GET_ENTITY_COORDS(targetEntity, true)
            local camDir = CAM.GET_GAMEPLAY_CAM_ROT(0):toDir()
            local distance = myPos:distance(entityPos)
            if distance > 30.0 then distance = 30.0
            elseif distance < 10.0 then distance = 10.0 end
            local targetPos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), camDir, true)
            targetPos:mul(distance)
            targetPos:add(myPos)
            local direction = ENTITY.GET_ENTITY_COORDS(players.user_ped(), targetPos, true)
            direction:sub(entityPos)
            direction:normalise()
        if ENTITY.IS_ENTITY_A_PED(targetEntity) then
            direction:mul(1.0)
            local explosionPos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), entityPos, true)
            explosionPos:sub(direction)
            draw_bounding_box(targetEntity, false, {r = 80, g = 0, b = 255, a = 255})
        end
    end
end

function Draw_Box_Vehicles()
    if not ENTITY.DOES_ENTITY_EXIST(targetEntity) then
        local flag = TraceFlag.peds | TraceFlag.vehicles | TraceFlag.pedsSimpleCollision | TraceFlag.objects
        local raycastResult = get_raycast_result(500.0, flag)
        if raycastResult.didHit and ENTITY.DOES_ENTITY_EXIST(raycastResult.hitEntity) then
            targetEntity = raycastResult.hitEntity
        end
    else
        for k, veh in pairs(entities.get_all_vehicles_as_handles()) do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(bh_target), true)
            draw_bounding_box(veh, true, {r = 80, g = 0, b = 255, a = 80})
            end
            local myPos = players.get_position(players.user())
            local entityPos = ENTITY.GET_ENTITY_COORDS(targetEntity, true)
            local camDir = CAM.GET_GAMEPLAY_CAM_ROT(0):toDir()
            local distance = myPos:distance(entityPos)
            if distance > 30.0 then distance = 30.0
            elseif distance < 10.0 then distance = 10.0 end
            local targetPos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), camDir, true)
            targetPos:mul(distance)
            targetPos:add(myPos)
            local direction = ENTITY.GET_ENTITY_COORDS(players.user_ped(), targetPos, true)
            direction:sub(entityPos)
            direction:normalise()
        if ENTITY.IS_ENTITY_A_PED(targetEntity) then
            direction:mul(1.0)
            local explosionPos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), entityPos, true)
            explosionPos:sub(direction)
            draw_bounding_box(targetEntity, false, {r = 80, g = 0, b = 255, a = 255})
        end
    end
end

menu.toggle_loop(ESP_World,"预览NPC", {""}, "",function()
    Draw_Box_Peds()
end)

menu.toggle_loop(ESP_World,"预览掉落物", {""}, "",function()
    Draw_Box_Pickups()
end)

menu.toggle_loop(ESP_World,"预览物体", {""}, "",function()
    Draw_Box_Objects()
end)

menu.toggle_loop(ESP_World,"预览载具", {""}, "",function()
    Draw_Box_Vehicles()
end)

menu.toggle_loop(fb,"抽搐附近载具", {""}, "", function()
    Draw_Box_Vehicles()
    for k, veh in pairs(entities.get_all_vehicles_as_handles()) do
        local PedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, true)
        if not PED.IS_PED_A_PLAYER(PedInSeat) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            local velocity = ENTITY.GET_ENTITY_VELOCITY(veh)
            local height = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(veh)
            if veh ~= 0 and not PED.IS_PED_DEAD_OR_DYING(PedInSeat, veh) and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(PedInSeat, veh) then
                ENTITY.APPLY_FORCE_TO_ENTITY(veh, 5, 0, 0, 150.0, 0, 0, 0, 0, true, false, true, false, true)
                cam_pos = CAM.GET_GAMEPLAY_CAM_ROT(0)
                cam_pos.x = cam_pos.x + math.random(-20,20)
                cam_pos.y = cam_pos.y + math.random(-20,20)
                cam_pos.z = cam_pos.z + math.random(-20,20)
                ENTITY.SET_ENTITY_ROTATION(veh, cam_pos.x, cam_pos.y, cam_pos.z, 1, true);
            end
        end
    end
end)

menu.toggle_loop(fb,"360附近载具", {""}, "", function()
    Draw_Box_Vehicles()
    for k, veh in pairs(entities.get_all_vehicles_as_handles()) do
        local PedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, true)
        if not PED.IS_PED_A_PLAYER(PedInSeat) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            local velocity = ENTITY.GET_ENTITY_VELOCITY(veh)
            local height = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(veh)
            if veh ~= 0 and not PED.IS_PED_DEAD_OR_DYING(PedInSeat, veh) and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(PedInSeat, veh) then
                ENTITY.APPLY_FORCE_TO_ENTITY(veh, 5, 0, 0, 150.0, 0, 0, 0, 0, true, false, true, false, true)
            end
        end
    end
end)

local dont_stop = false
menu.toggle_loop(fb,"控制所有载具", {""}, "", function()
    Draw_Box_Vehicles()
    for k, veh in pairs(entities.get_all_vehicles_as_handles()) do
        local PedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, false)
        if not PED.IS_PED_A_PLAYER(PedInSeat) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            cam_pos = CAM.GET_GAMEPLAY_CAM_ROT(0)
            ENTITY.SET_ENTITY_ROTATION(veh, cam_pos.x, cam_pos.y, cam_pos.z, 1, true);
            local locspeed = speed*10
            local locspeed2 = speed
            if PAD.IS_CONTROL_PRESSED(0, 61) then
                locspeed = locspeed*2
                locspeed2 = locspeed2*2
            end
            if PAD.IS_CONTROL_PRESSED(2, 71) then
                if dont_stop then
                    ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, speed, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                else 
                    VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, locspeed)
                end
            end
            if PAD.IS_CONTROL_PRESSED(2, 72) then
                local lsp = speed
                if not PAD.IS_CONTROL_PRESSED(0, 61) then 
                    lsp = speed * 2
                end
                if dont_stop then
                    ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0 - (lsp), 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                else 
                    VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0 - (locspeed));
                end
           end
            if PAD.IS_CONTROL_PRESSED(2, 63) then
                local lsp = (0 - speed)*2
                if not PAD.IS_CONTROL_PRESSED(0, 61) then 
                    lsp = 0 - speed
                end
                if dont_stop then
                    ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, (lsp), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                else 
                    ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0 - (locspeed), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1);
                end
            end
            if PAD.IS_CONTROL_PRESSED(2, 64) then
                local lsp = speed
                if not PAD.IS_CONTROL_PRESSED(0, 61) then 
                    lsp = speed*2
                end
                if dont_stop then
                    ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, lsp, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                else 
                    ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, locspeed, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                end
            end
            if not dont_stop and not PAD.IS_CONTROL_PRESSED(2, 71) and not PAD.IS_CONTROL_PRESSED(2, 72) then
                VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0.0);
            end
        end
    end
end)

function player_index(pid)
    local player_index = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    return player_index
end

player_coords = function(pid)
    local player_coords = ENTITY.GET_ENTITY_COORDS(player_index(pid), true)
    return player_coords
end

function Destruct()
    local coords = player_coords(pid)
    coords.x = coords.x
    coords.y = coords.y + -30
    coords.z = coords.z
    vehicles = entities.get_all_vehicles_as_handles()
for i, ent in pairs(vehicles) do
    if not is_ped_player(VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)) then
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(object1, coords.x, coords.y, coords.z, false, false, true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, true, true)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(ent), true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.VEH_TO_NET(ent), players.user(), true)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(ent, 1, 0.0, 10000.0, 0.0, 0.0, 0.0, 0.0, false, true, true, false, true)
        ENTITY.SET_ENTITY_ROTATION(ent, math.random(0, 360), math.random(0, 360), math.random(0, 360), 0, true)
        ENTITY.SET_ENTITY_VELOCITY(ent, math.random(-10, 10), math.random(-10, 10), math.random(30, 50))
        end
    end
end

menu.toggle_loop(fb,"苍蝇附近载具", {""}, "", function()
    Destruct()
end)