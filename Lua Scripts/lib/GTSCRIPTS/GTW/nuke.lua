ent_func = {}

function ent_func.get_distance_between(pos1, pos2)
	if math.type(pos1) == "integer" then
		pos1 = ENTITY.GET_ENTITY_COORDS(pos1)
	end
	if math.type(pos2) == "integer" then 
		pos2 = ENTITY.GET_ENTITY_COORDS(pos2)
	end
	return pos1:distance(pos2)
end

function ent_func.get_vehicle_from_ped(ped)
	if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
		return PED.GET_VEHICLE_PED_IS_IN(ped, false)
    else
        return 0
	end
end

function ent_func.get_entity_control(entity)
    --looks if the entity exists--
    if entity > 0 then
        --if you have control and the session is started then return the entity--
        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and util.is_session_started() then
            return entity
        end
        --if we have not yet have control of the entity then get the network id from the entity--
        local network_id = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
        local has_control = false
        --set that we can take control--
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(network_id, true)

        local loops = 15
        --while you not be able to take control loop 15 times with an yield of 15 milis--
        while not has_control do
            --request control--
            has_control = NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
            loops = loops - 1
            util.yield(15)
            if loops <= 0 then
                break
            end
        end
    end
    --return the entity--
    return entity
end

--not used atm just in the code for later--
function ent_func.get_entity_control_onces(entity)
    --looks if the entity exists--
    if entity > 0 then
        --if you have control and the session is started then return the entity--
        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and util.is_session_started() then
            return entity
        end
        --if we have not yet have control of the entity then get the network id from the entity and set that you can take control--
        local network_id = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(network_id, true)
    end
    --return the entity--
    return entity
end

--based on how jacks does it but just got the idea with the spectating and the rest i did myself so no skid just idea--
function ent_func.get_player_vehicle_in_control(pid, options)
    local user_ped = players.user_ped()
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

    --calculate the distance between you and the player your trying to get the vehicle control from--
    local user_pos = ENTITY.GET_ENTITY_COORDS(target_ped)
    local target_pos = ENTITY.GET_ENTITY_COORDS(user_ped)
    local dist = ent_func.get_distance_between(user_pos, target_pos)

    --to see if you are spectating the player your trying to take vehicle controll from--
    local is_spectating = menu.ref_by_command_name("spectate" .. players.get_name(pid):lower()).value

    --getting the vehicle from the ped--
    local vehicle = ent_func.get_vehicle_from_ped(target_ped)
    --if the options and the vehicle is 0 then return 0--
    if options and vehicle == 0 then
        return 0
    end
    --if vehicle is is 0 and the player is not you and the distance is higher then a 100 and you are not spectating then--
    if vehicle == 0 and target_ped ~= user_ped and dist > 1000 and not is_spectating then
        util.toast("Spectating")
        --turn on spectating--
        menu.trigger_commands("spectate" .. players.get_name(pid) .. " on")

        --loop 30 times or stop looping if you have the vehicle of the player--
        local loop = 30
        while vehicle == 0 and loop > 0 do
            util.yield(100)
            vehicle = ent_func.get_vehicle_from_ped(target_ped)
            loop = loop - 1
        end
    end

    --taking control off the vehicle--
    ent_func.get_entity_control(vehicle)

    --if you were not spectating before you turn off spectating
    if not is_spectating then
        menu.trigger_commands("spectate" .. players.get_name(pid) .. " off")
    end

    --return the controlled vehicle--
    return vehicle
end

function ent_func.get_entity_player_is_aiming_at(player)
	if not PLAYER.IS_PLAYER_FREE_AIMING(player) then
		return 0
	end
	local entity = false
    local aimed_entity = memory.alloc_int()
	if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(player, aimed_entity) then
		entity = memory.read_int(aimed_entity)
	end
	if entity ~= false and ENTITY.IS_ENTITY_A_PED(entity) and PED.IS_PED_IN_ANY_VEHICLE(entity, false) then
		entity = PED.GET_VEHICLE_PED_IS_IN(entity, false)
	end
	return entity
end

--thanks to noshirt.cat for helping me with this--
function ent_func.getClosestVehicle(myPos)
	local closestDist = 999999999999
	local closestVeh = nil
	for _, veh in pairs(entities.get_all_vehicles_as_pointers()) do
	      local vehpos = entities.get_position(veh)
	      local dist = myPos:distance(vehpos)
	      if (dist < closestDist) then
	    	closestDist = dist
	    	closestVeh = veh
	      end
    end
    if closestVeh ~= nil then
        return entities.pointer_to_handle(closestVeh)
    end
end
--changed it a bit but credit to SATTY for this--
function ent_func.getClosestPlayer(myPos)
    local closestDist = 999999999999
    local closest_player = nil
    local myVehicle = ent_func.get_vehicle_from_ped(players.user_ped())
    if myVehicle == 0 then
        myVehicle = 1
    end
    for _, player in players.list(false, true, true) do
		local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player)
		if not ENTITY.IS_ENTITY_DEAD(ped) then
            local playerpos = players.get_position(player)
            local dist = ent_func.get_distance_between(myPos, playerpos)
            local playerVehicle = ent_func.get_vehicle_from_ped(ped)
            if (dist < closestDist) and (playerVehicle ~= myVehicle) and not players.is_in_interior(player) then
                closestDist = dist
                closest_player = player
            end
		end
    end
    if closest_player ~= nil and closest_player ~= players.user() then
        return closest_player
    end
end

--credit to lance for this--
function ent_func.get_offset_from_gameplay_camera(distance)
	local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
	local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
	local direction = v3.toDir(cam_rot)
	local destination = {
	  x = cam_pos.x + direction.x * distance,
	  y = cam_pos.y + direction.y * distance,
	  z = cam_pos.z + direction.z * distance
	}
	return destination
end

--both draw line from x to x not used but just here--
function ent_func.draw_line_from_ped_to_ped(ped)
    local pos_player = PED.GET_PED_BONE_COORDS(ped, 31086, 0.0, 0.0, 0.0)
    local pos_user = PED.GET_PED_BONE_COORDS(players.user_ped(), 31086, 0.0, 0.0, 0.0)
    GRAPHICS.DRAW_LINE(pos_player.x, pos_player.y, pos_player.z, pos_user.x, pos_user.y, pos_user.z, 255, 255, 255, 255)
end

function ent_func.draw_line_from_ped_to_entity(entity)
    local pos_entity = ENTITY.GET_ENTITY_COORDS(entity)
    local pos_user = PED.GET_PED_BONE_COORDS(players.user_ped(), 31086, 0.0, 0.0, 0.0)
    GRAPHICS.DRAW_LINE(pos_entity.x, pos_entity.y, pos_entity.z, pos_user.x, pos_user.y, pos_user.z, 255, 255, 255, 255)
end

function ent_func.request_model(hash)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield(0) end
end

function ent_func.use_fx_asset(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
		STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
		util.yield(0)
	end
    GRAPHICS.USE_PARTICLE_FX_ASSET(asset)
end

function ent_func.has_anim_dict_loaded(dict)
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        STREAMING.REQUEST_ANIM_DICT(dict)
        util.yield(0)
    end
end

--nuke explosion function please dont say anything i know this is a mess but its better the the original function from "my" meteor script bc i took the time to make it a bit smaller--
local function nuke_expl1(Position)
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

local function nuke_expl2(Position)
    local offsets = {{0,0,-10}, {10,0,-10}, {0,10,-10}, {10,10,-10}, {-10,0,-10}, {0,-10,-10}, {-10,-10,-10}, {10,-10,-10}, {-10,10,-10}}
    for _, offset in ipairs(offsets) do
        FIRE.ADD_EXPLOSION(Position.x + offset[1], Position.y + offset[2], Position.z + offset[3], 59, 1.0, true, false, 1.0, false)
    end
end

local function nuke_expl3(Position)
    local offsets = {{10,0,0}, {0,10,0}, {10,10,0}, {-10,0,0}, {0,-10,0}, {-10,-10,0}, {10,-10,0}, {-10,10,0}, {0,0,0}}
    for _, offset in ipairs(offsets) do
        FIRE.ADD_EXPLOSION(Position.x + offset[1], Position.y + offset[2], Position.z + offset[3], 59, 1.0, true, false, 1.0, false)
    end
end

function ent_func.create_nuke_explosion(Position)
    for count = 1, 17 do
        if count == 1 then
	        FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z, 59, 1, true, false, 5.0, false)
        elseif count == 2 then
            FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z, 59, 1, true, false, 1.0, false)
        end
		ent_func.use_fx_asset("scr_xm_orbital")
	    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", Position.x, Position.y, Position.z, 0, 180, 0, 4.5, true, true, true)
    end

    nuke_expl1(Position)

	for i = 1, 4 do
		AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "DLC_XM_Explosions_Orbital_Cannon", players.user_ped(), 0, true, false)
	end

    for count = 1, 2 do
        if count == 1 then
	        FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z-10, 59, 1, true, false, 5.0, false)
        end
		ent_func.use_fx_asset("scr_xm_orbital")
	    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", Position.x, Position.y, Position.z-10, 0, 180, 0, 4.5, true, true, true)
    end

    nuke_expl2(Position)

    local size = 1.5
    local positionsZ = {1, 3, 5, 7, 10, 12, 15, 17, 20, 22, 25, 27, 30, 32, 35, 37, 40, 42, 45, 47, 50, 52, 55, 57, 59, 61, 63, 65, 70, 75, 75, 75, 75, 80, 80}
    for i, pos in ipairs(positionsZ) do
        if i == 3 or i == 5 or i == 7 or i == 9 or i == 11 or i == 13 or i == 15 or i == 17 or i == 19 or i == 21 or i == 23 or i == 25 or i == 29 or i == 30 then
        FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z+pos, 59, 1.0, true, false, 1.0, false)
        end
        ent_func.use_fx_asset("scr_xm_orbital")
	    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", Position.x, Position.y, Position.z+pos, 0, 180, 0, size, true, true, true)

        if i >= 30 and i <= 33 then size = 3.5
        elseif i >= 34 and i <= 35 then size = 3.0
        else size = 1.5 end
        util.yield(10)
    end

    nuke_expl3(Position)

	for _, pid in pairs(players.list(false, true, true)) do
        local distance = ent_func.get_distance_between(players.get_position(pid), Position)
		if distance < 200 then
			local pid_pos = players.get_position(pid)
			FIRE.ADD_EXPLOSION(pid_pos.x, pid_pos.y, pid_pos.z, 59, 1.0, true, false, 1.0, false)
		end
	end

	local peds = entities.get_all_peds_as_handles()
	for _, ped in pairs(peds) do
		if ent_func.get_distance_between(ped, Position) > 200 and ent_func.get_distance_between(ped, Position) < 400 and ped ~= players.user_ped() then
			local ped_pos = ENTITY.GET_ENTITY_COORDS(ped)
			FIRE.ADD_EXPLOSION(ped_pos.x, ped_pos.y, ped_pos.z, 3, 1.0, true, true, 0.1, false)
		end
	end
    
	local vehicles = entities.get_all_vehicles_as_handles()
    for _, vehicle in pairs(vehicles) do
		if ent_func.get_distance_between(vehicle, Position) < 400 then
			VEHICLE.EXPLODE_VEHICLE(vehicle, true, false)
		elseif ent_func.get_distance_between(vehicle, Position) > 200 and ent_func.get_distance_between(vehicle, Position) < 400 then
			VEHICLE.EXPLODE_VEHICLE(vehicle, true, false)
		end
	end
end

return ent_func