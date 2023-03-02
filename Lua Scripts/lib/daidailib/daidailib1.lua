

------绿汽水
spawned_objects = {}
random_spawn_vehicles = {}

for _, sprunk_vehicle in pairs(sprunk_vehicles) do
    if sprunk_vehicle.is_random_spawn ~= false then
        table.insert(random_spawn_vehicles, sprunk_vehicle)
    end
end

function load_hash(hash)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        util.yield()
    end
end
function spawn_object_at_pos(pos, model, ttl)
    local pickup_hash = util.joaat(model)
    load_hash(pickup_hash)
    local pickup_pos = v3.new(pos.x, pos.y, pos.z)
    local pickup = entities.create_object(pickup_hash, pickup_pos)
    ENTITY.SET_ENTITY_COLLISION(pickup, true, true)
    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(
        pickup, 5, 0, 0, 1,
        true, false, true, true
    )
    table.insert(spawned_objects, { handle=pickup, spawn_time=util.current_time_millis(), ttl=ttl})
end
function nearby_position(pos, range)
    if range == nil then
        range = {
            x_max=1, y_max=1, z_max=1,
            x_min=-1, y_min=-1, z_min=0,
        }
    end
    return {
        x=pos.x + math.random(range.x_min, range.x_max),
        y=pos.y + math.random(range.y_min, range.y_max),
        z=pos.z + math.random(range.z_min, range.z_max),
    }
end
function sprunk_can_drop(position, range, model, ttl)
    local spawn_position = position
    if range then
        spawn_position = nearby_position(position, range)
    end
    if model == nil then
        model = "ng_proc_sodacan_01b"
    end
    spawn_object_at_pos(spawn_position, model, ttl)
end
function get_rain_range()
    return {
        x_max=3, y_max=3, z_max=4,
        x_min=3 * -1, y_min=3 * -1, z_min=4,
    }
end
function sprunk_drop_player(pid, range)
    sprunk_can_drop(players.get_position(pid), range)
end
function sprunk_raindrop_player(pid)
    sprunk_drop_player(pid, get_rain_range())
end
function spawn_vehicle_for_player(pid, model_name)
    local model = util.joaat(model_name)
    if not STREAMING.IS_MODEL_VALID(model) or not STREAMING.IS_MODEL_A_VEHICLE(model) then
        -- util.toast("Error: Invalid vehicle name")
        return
    else
        load_hash(model)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, 0.0, 4.0, 0.5)
        local heading = ENTITY.GET_ENTITY_HEADING(target_ped)
        local vehicle = entities.create_vehicle(model, pos, heading)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(model)
        return vehicle
    end
end
function vehicle_set_mod_max_value(vehicle, vehicle_mod)
    local max = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, vehicle_mod) - 1
    VEHICLE.SET_VEHICLE_MOD(vehicle, vehicle_mod, max)
end
function vehicle_mods_set_max_performance(vehicle)
    vehicle_set_mod_max_value(vehicle, 11)
    vehicle_set_mod_max_value(vehicle, 13)
    vehicle_set_mod_max_value(vehicle, 12)
    vehicle_set_mod_max_value(vehicle, 16)
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 18, true)
end
function sprunkify_vehicle(vehicle)
    vehicle_mods_set_max_performance(vehicle)
    local color = {r=0, g=255, b=0}
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, color.r, color.g, color.b)
    VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, 0, 0, 0)
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, color.r, color.g, color.b)
    VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, 0, 0, 0)
    VEHICLE1._SET_VEHICLE_INTERIOR_COLOR(vehicle, 55)
    VEHICLE1._SET_VEHICLE_DASHBOARD_COLOR(vehicle, 55)
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 22, true)
    VEHICLE1._SET_VEHICLE_XENON_LIGHTS_COLOR(vehicle, 4)
    VEHICLE1._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 0, true)
    VEHICLE1._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 1, true)
    VEHICLE1._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 2, true)
    VEHICLE1._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 3, true)
    VEHICLE1._SET_VEHICLE_NEON_LIGHTS_COLOUR(vehicle, color.r, color.g, color.b)
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, 0, 55)
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 20, true)
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, 0, 255, 0)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, true, true)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "SPRUNK")
    local target_livery = -1
    local model_hash = entities.get_model_hash(entities.handle_to_pointer(vehicle))
    for _, sprunk_vehicle in pairs(sprunk_vehicles) do
        if sprunk_vehicle.model_hash == model_hash then
            target_livery = sprunk_vehicle.livery
        end
    end
    VEHICLE.SET_VEHICLE_LIVERY(vehicle, target_livery)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 48, target_livery)
end
function sprunk_drop_vehicle(vehicle, range)
    sprunk_can_drop(ENTITY.GET_ENTITY_COORDS(vehicle), range)
end
function sprunk_raindrop_vehicle(vehicle)
    sprunk_drop_vehicle(vehicle, get_rain_range())
end
----绿气传染
local currently_dumping = false
function trash_dump_player(pid)
    if currently_dumping then
        -- Only allow one dump at a time to avoid overloading models
        return
    end
    currently_dumping = true
    local NUM_CANS_TO_DROP = 100
    local num_cans_dropped = 0
    repeat
        local can_models = {
            -- "ng_proc_sodacan_01b",
            "ng_proc_sodacan_02b",
            "ng_proc_sodacan_02d",
            "ng_proc_sodacan_03b"
        }
        sprunk_can_drop(
                players.get_position(pid),
                {
                    x_max=1, y_max=1, z_max=4,
                    x_min=-1, y_min=-1, z_min=2,
                },
                can_models[math.random(1, #can_models)],
                15000
        )
        num_cans_dropped = num_cans_dropped + 1
        util.yield(10)
    until num_cans_dropped >= NUM_CANS_TO_DROP
    currently_dumping = false
end
------飞艇
function spawn_sprunk_blimp(pid)
    if not happy_blimps_toggle then
        return
    end

    local vehicle_hash = util.joaat('blimp3')
    local ped_hash = util.joaat("s_m_m_pilot_01")
    load_hash(vehicle_hash)
    load_hash(ped_hash)

    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(
        target_ped,
        math.random(-500, 500),
        math.random(-500, 500),
        math.random(350, 500)
    )

    local aircraft = entities.create_vehicle(vehicle_hash, pos, math.random(0, 360))
    sprunkify_vehicle(aircraft)
    VEHICLE.SET_VEHICLE_ENGINE_ON(aircraft, true, true, false)
    VEHICLE.SET_HELI_BLADES_FULL_SPEED(aircraft)
    VEHICLE.SET_VEHICLE_FORWARD_SPEED(aircraft, VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(aircraft)/4)

    local pilot = entities.create_ped(1, ped_hash, pos, 0.0)
    PED.SET_PED_INTO_VEHICLE(pilot, aircraft, -1)
    PED.SET_PED_KEEP_TASK(pilot, true)
    local blip = HUD.ADD_BLIP_FOR_ENTITY(aircraft)
    HUD.SET_BLIP_SPRITE(blip, 638)
    HUD.SET_BLIP_COLOUR(blip, 69)

    local ttl = 300000 + math.random(-1000, 1000)
    local blimp_object = {
        handle=aircraft,
        type="blimp",
        spawn_time=util.current_time_millis(),
        ttl=ttl,
        respawn_function=spawn_sprunk_blimp,
        pid=pid,
        pilot_handle=pilot,
    }
    table.insert(spawned_objects, blimp_object)

end
function array_remove(t, fnKeep)
    local j, n = 1, #t;

    for i=1,n do
        if (fnKeep(t, i, j)) then
            -- Move i's kept value to j's position, if it's not already there.
            if (i ~= j) then
                t[j] = t[i];
                t[i] = nil;
            end
            j = j + 1; -- Increment position of where we'll place the next kept value.
        else
            t[i] = nil;
        end
    end

    return t;
end
function delete_spawned_object(spawned_object)
    if spawned_object.pilot_handle then
        entities.delete_by_handle(spawned_object.pilot_handle)
    end
    entities.delete_by_handle(spawned_object.handle)
end
function clear_blimps()
    array_remove(spawned_objects, function(t, i, j)
        local spawned_object = t[i]
        if spawned_object.type == "blimp" then
            delete_spawned_object(spawned_object)
            return false
        end
        return true
    end)
end

------绿气传染
function Green_contagion()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local pos = ENTITY.GET_ENTITY_COORDS(ped, 1)
    local range = 100
    local nearby_vehicles = entities.get_all_vehicles_as_handles()
    local count = 0
    for _, vehicle in ipairs(nearby_vehicles) do
        local vehicle_pos = ENTITY.GET_ENTITY_COORDS(vehicle, 1)
        local distance = SYSTEM.VDIST(pos.x, pos.y, pos.z, vehicle_pos.x, vehicle_pos.y, vehicle_pos.z)
        if distance <= range then
            sprunkify_vehicle(vehicle)
            count = count + 1
        end
    end
    util.toast(count.." 载具染色!")
end







--------无效载具崩溃
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
    local pCoords<const> = players.get_position(pid)
    local trafficLights = {}
    util.request_model(-655644382) -- traffic lights
    for i = 1, 20 do
        local object<const> = entities.create_object(-655644382, v3.new(pCoords.x + math.random(-5, 5), pCoords.y + math.random(-5, 5), pCoords.z + math.random(-1, 0)))
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
        entities.delete_by_handle(vehicles[i])
    end
    util.yield(500)
    stopLights = true
    util.yield(500)
    for i = 1, #trafficLights do
        entities.delete_by_handle(trafficLights[i])
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(3253274834)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(-655644382)
end



-----无效降落伞崩溃
function Invalid_parachute()
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
        entities.delete_by_handle(Ruiner2)
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
        entities.delete_by_handle(Ruiner2)
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
        entities.delete_by_handle(Ruiner2)
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
        entities.delete_by_handle(Ruiner2)
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
        entities.delete_by_handle(Ruiner2)
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
        entities.delete_by_handle(Ruiner2)
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
        entities.delete_by_handle(Ruiner2)
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
        entities.delete_by_handle(Ruiner2)
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
        entities.delete_by_handle(stupid_object)
        entities.delete_by_handle(glitch_vehicle)
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
        ENTITY.ATTACH_ENTITY_TO_ENTITY(Object_pizza2,Object_pizza1, 0,  0.0, 0.00, 0.00, 1.0, 1.0,1, true, false, true, false, 0, true)
    util.yield(5000)
    do
        orbital(pid)
        entities.delete_by_handle(Object_pizza1)
        entities.delete_by_handle(Object_pizza2)
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
    entities.delete_by_handle(obj)
    entities.delete_by_handle(veh)
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
            spawn_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.5, 0.0)
        elseif TASK.IS_PED_WALKING(ped) then
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
        entities.delete_by_handle(obj)
        entities.delete_by_handle(veh)
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
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
    ENTITY.SET_ENTITY_VISIBLE(vehicle1, false)
    util.yield(5000)
    for i = 1, #spawned_vehs do
        entities.delete_by_handle(spawned_vehs[i])
    end
end



----大烟花
function big_fireworks()
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    local hash = util.joaat("weapon_firework")
    request_weapon_asset(hash)
    WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)

    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-70, pos.y-90, pos.z, pos.x-70, pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-90, pos.y-90, pos.z, pos.x-90, pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-60, pos.y-90, pos.z, pos.x-60, pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-80, pos.y-90, pos.z, pos.x-80, pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-50, pos.y-90, pos.z, pos.x-50, pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
end
-----小烟花
function Small_fireworks()
    ptfx_asset = "scr_indep_fireworks"
    effect_name = "scr_indep_firework_trailburst"

    GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)---------------------------------------------距离x   y  z方向x, y, z  
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), 0, 70, 0, 179, 0, 0, 1, 0, 0, 0)
    util.yield(250)
    GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), -8, 70, 0, 179, 0, 0, 0.5, 10, 10, 0)
    util.yield(250)
    GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), 4, 70, 0, 179, 0, 0, 1.2, 10, 10, 0)
    util.yield(250)
    GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), -4, 70, 0, 179, 0, 0, 0.7, 10, 10, 0)
    util.yield(250)
    GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), 8, 70, 0, 179, 0, 0, 0.5, 10, 10, 0)
    util.yield(250)
    GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), -2, 70, 0, 179, 0, 0, 1, 10, 10, 0)
    util.yield(250)
    GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), 2, 70, 0, 179, 0, 0, 0.8, 10, 10, 0)
    util.yield(250)
    GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), 6, 70, 0, 179, 0, 0, 1, 10, 10, 0)
    util.yield(250)
end

------愤怒的飞机
numPlanes = 0
lastSpawn = newTimer()
function Angry_plane()
    if numPlanes < 15 and lastSpawn.elapsed() > 300 then
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
            lastSpawn.reset()
        end
    end
end
function clear_Angry_plane()
    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
        entities.delete_by_handle(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false))
        entities.delete_by_handle(vehicle)
        numPlanes = numPlanes - 1
    end
end

-----绘制血量条
drawoptions = {
    {"玩家"},
    {"行人"},
    {"玩家和行人"},
    {"主动瞄准时"},
}
ttselectedOpt = 1
selfaimedPed = 0
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
    while not STREAMING.HAS_ANIM_DICT_LOADED("amb@world_human_musician@guitar@male@idle_a") do 
        STREAMING.REQUEST_ANIM_DICT("amb@world_human_musician@guitar@male@idle_a")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    guitar = OBJECT.CREATE_OBJECT(util.joaat("prop_acc_guitar_01"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "amb@world_human_musician@guitar@male@idle_a", "idle_b", 3, 3, -1, 51, 0, false, false, false) --play anim 
    ENTITY.ATTACH_ENTITY_TO_ENTITY(guitar, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 24818), -0.1,0.31,0.1,0.0,20.0,150.0, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(guitar)
    end
end
-----掌旋球
function Palm_spin_ball(on)
    while not STREAMING.HAS_ANIM_DICT_LOADED("anim@mp_player_intincarfreakoutstd@ps@") do 
        STREAMING.REQUEST_ANIM_DICT("anim@mp_player_intincarfreakoutstd@ps@")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    guitar = OBJECT.CREATE_OBJECT(util.joaat("prop_bowling_ball"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "anim@mp_player_intincarfreakoutstd@ps@", "idle_a_fp", 10, 3, -1, 51, 5, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(guitar, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 24818), 0.30,0.53,0,0.2,70,340, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(guitar)
    end
end
-----求助
function seek_help(on)
    while not STREAMING.HAS_ANIM_DICT_LOADED("amb@world_human_bum_freeway@male@base") do 
        STREAMING.REQUEST_ANIM_DICT("amb@world_human_bum_freeway@male@base")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    beggers = OBJECT.CREATE_OBJECT(util.joaat("prop_beggers_sign_03"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "amb@world_human_bum_freeway@male@base", "base", 3, 3, -1, 51, 0, false, false, false) --play anim 
    ENTITY.ATTACH_ENTITY_TO_ENTITY(beggers, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 58868), 0.19,0.18,0.0,5.0,0.0,40.0, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(beggers)
    end
end
-----献花
function offer_flower(on)
    while not STREAMING.HAS_ANIM_DICT_LOADED("anim@heists@humane_labs@finale@keycards") do 
        STREAMING.REQUEST_ANIM_DICT("anim@heists@humane_labs@finale@keycards")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    rose = OBJECT.CREATE_OBJECT(util.joaat("prop_single_rose"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", 3, 3, -1, 51, 0, false, false, false) --play anim 
    ENTITY.ATTACH_ENTITY_TO_ENTITY(rose, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 18905), 0.13,0.15,0.0,-100.0,0.0,-20.0, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(rose)
    end
end



vehicle_uses = 0
ped_uses = 0
pickup_uses = 0
player_uses = 0
object_uses = 0
robustmode = false
function mod_uses(type, incr)
    if incr < 0 and is_loading then
        --"不增加使用类型的 var " .. type .. " by " .. incr .. "- script is loading"
        return
    end
    --"递增使用 var 类型 " .. type .. " by " .. incr
    if type == "vehicle" then
        if vehicle_uses <= 0 and incr < 0 then
            return
        end
        vehicle_uses = vehicle_uses + incr
    elseif type == "pickup" then
        if pickup_uses <= 0 and incr < 0 then
            return
        end
        pickup_uses = pickup_uses + incr
    elseif type == "ped" then
        if ped_uses <= 0 and incr < 0 then
            return
        end
        ped_uses = ped_uses + incr
    elseif type == "player" then
        if player_uses <= 0 and incr < 0 then
            return
        end
        player_uses = player_uses + incr
    elseif type == "object" then
        if object_uses <= 0 and incr < 0 then
            return
        end
        object_uses = object_uses + incr
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
        util.create_tick_handler(function()
        STREAMING.REQUEST_ANIM_DICT("move_crawl")
        PED.SET_PED_MOVEMENT_CLIPSET(clone, "move_crawl", -1)
        mod_uses("ped", if on then 1 else -1)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(clone, true)
        TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(clone, true)
        return ghost
        end)
        else
            clonepedpos = ENTITY.GET_ENTITY_COORDS(clone, false)
            ENTITY.SET_ENTITY_COORDS(user_ped, clonepedpos.x,clonepedpos.y,clonepedpos.z, false, false)
            entities.delete_by_handle(clone)
            ENTITY.SET_ENTITY_ALPHA(user_ped, 255, false)
            menu.trigger_commands("invisibility off")
        end
end


-----附加国旗
function first_to_upper(str)
    return (str:gsub("^%l", string.upper))
end
country_flags = {"apa_prop_flag_argentina", "apa_prop_flag_australia", "apa_prop_flag_austria", "apa_prop_flag_belgium", "apa_prop_flag_brazil", "apa_prop_flag_canada_yt", "apa_prop_flag_china", "apa_prop_flag_columbia", "apa_prop_flag_croatia", "apa_prop_flag_czechrep", "apa_prop_flag_denmark", "apa_prop_flag_england", "apa_prop_flag_eu_yt", "apa_prop_flag_finland", "apa_prop_flag_france", "apa_prop_flag_german_yt", "apa_prop_flag_hungary", "apa_prop_flag_ireland", "apa_prop_flag_israel", "apa_prop_flag_italy", "apa_prop_flag_jamaica", "apa_prop_flag_japan_yt", "apa_prop_flag_lstein", "apa_prop_flag_malta", "apa_prop_flag_mexico_yt", "apa_prop_flag_netherlands", "apa_prop_flag_newzealand", "apa_prop_flag_nigeria", "apa_prop_flag_norway", "apa_prop_flag_palestine", "apa_prop_flag_poland", "apa_prop_flag_portugal", "apa_prop_flag_puertorico", "apa_prop_flag_russia_yt", "apa_prop_flag_scotland_yt", "apa_prop_flag_script", "apa_prop_flag_slovakia", "apa_prop_flag_slovenia", "apa_prop_flag_southafrica", "apa_prop_flag_southkorea", "apa_prop_flag_spain", "apa_prop_flag_sweden", "apa_prop_flag_switzerland", "apa_prop_flag_turkey", "apa_prop_flag_uk_yt", "apa_prop_flag_us_yt", "apa_prop_flag_wales"}
flags_fmt = {}
for _, flag in pairs(country_flags) do 
    table.insert(flags_fmt, first_to_upper(flag:gsub('apa_prop_flag_', ''):gsub('_yt', '')))
end


-----homer粒子
suijijianqi = function(x)
    local r = math.random(1,5)
    return x[r]
end

------崩溃,踢出,转魂
ent_types = {"没有", "行人", "载具", "实体"}
function get_aim_info()
    local outptr = memory.alloc(4)
    local success = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), outptr)
    local info = {}
    if success then
        local ent = memory.read_int(outptr)
        if not ENTITY.DOES_ENTITY_EXIST(ent) then
            info["ent"] = 0
        else
            info["ent"] = ent
        end
        if ENTITY.GET_ENTITY_TYPE(ent) == 1 then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ent, false)
            if veh ~= 0 then
                if VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1) then
                    ent = veh
                    info['ent'] = ent
                end
            end
        end
        info["hash"] = ENTITY.GET_ENTITY_MODEL(ent)
        info["health"] = ENTITY.GET_ENTITY_HEALTH(ent)
        info["type"] = ent_types[ENTITY.GET_ENTITY_TYPE(ent)+1]
        info["speed"] = math.floor(ENTITY.GET_ENTITY_SPEED(ent))
    else
        info['ent'] = 0
    end
    return info
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
                entities.delete_by_handle(ent)
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
                entities.delete_by_handle(driver)
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


-----聊天上色
function new_chat_obj(player_name, player_color, tag, text, networked)
    local chat = {
        player_name = player_name,
        player_color = player_color,
        tag = tag, 
        text = text,
        networked = networked
    }
    return chat
end

----------颜色--------
hud_colors = {
    me = 224,
    friends = 225,
    strangers = 226,
    modders = 227
}

function replace_hud_color(index, color)
    HUD.REPLACE_HUD_COLOUR_WITH_RGBA(index, color.r * 255, color.g * 255, color.b * 255, color.a * 255)
end

muted_players = {}------玩家表
function player(pid)
end
players.on_leave(function(pid)
    muted_players[pid] = nil 
end)
players.on_join(player)


handle_ptr = memory.alloc(13*8)
function pid_to_handle(pid)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, handle_ptr, 13)
    return handle_ptr
end




-----Black_list
function Black_list()
    -----检测到战局有黑名单直接踢
    for pid = 0, 31 do
        Blacklist_player = players.get_name(pid)
            for i = 1, #blacklist do
                if blacklist[i] == Blacklist_player then
                    util.toast("[呆呆提示] \n检测到黑名单玩家: "..Blacklist_player.."\n已执行踢出")
                    util.log("[呆呆提示] \n检测到黑名单玩家: "..Blacklist_player.."\n已执行踢出")
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
        end
    end
end


-------水上驾驶等
function on_user_change_vehicle(vehicle)
    if vehicle ~= 0 then
    end
end
function request_model_load(hash)
    request_time = os.time()
    if not STREAMING.IS_MODEL_VALID(hash) then
        return
    end
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end
-------水上行走
function walkonwater()
    if menu.get_value(waterdrive) == true then
        menu.set_value(walkwater,false)
    end
    if dow_block == 0 or not ENTITY.DOES_ENTITY_EXIST(dow_block) then
        local hash = util.joaat("stt_prop_stunt_bblock_mdm3")
        request_model_load(hash)
        local c = {}
        c.x = 0.0
        c.y = 0.0
        c.z = 0.0
        dow_block = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, c['x'], c['y'], c['z'], true, false, false)
        ENTITY.SET_ENTITY_ALPHA(dow_block, 0)
        ENTITY.SET_ENTITY_VISIBLE(dow_block, false, 0)
    end
    vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 2.0, 0.0)
    local ht = memory.alloc(4)
    if WATER.GET_WATER_HEIGHT(pos['x'], pos['y'], pos['z'], ht) then
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], memory.read_float(ht), false, false, false)
        ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
    end
end

----------水上驾驶
dow_block = 0
function driveonwater()
    if menu.get_value(walkwater) == true then
        menu.set_value(waterdrive,false)
    end
    if dow_block == 0 or not ENTITY.DOES_ENTITY_EXIST(dow_block) then
        local hash = util.joaat("stt_prop_stunt_bblock_mdm3")
        request_model_load(hash)
        local c = {}
        c.x = 0.0
        c.y = 0.0
        c.z = 0.0
        dow_block = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, c['x'], c['y'], c['z'], true, false, false)
        ENTITY.SET_ENTITY_ALPHA(dow_block, 0)
        ENTITY.SET_ENTITY_VISIBLE(dow_block, false, 0)
    end
    if dow_block ~= 0 and not walkonwater and not walkonair and not driveonwater and not driveonair then
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, 0, 0, 0, false, false, false)
    end
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




-----实体枪2
local impactCords = v3.new()
local blocks = {}
function xxxminecraftgun()
    if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), impactCords) then
        local hash = util.joaat('prop_mb_sandblock_01')
        loadModel(hash)
        blocks[#blocks + 1] = entities.create_object(hash, impactCords)
    end
end


-----在线玩家
local menus = {}
function player_list(pid)
    if NETWORK.NETWORK_IS_SESSION_ACTIVE()then 
        online_playerlist = menu.list(players_list, players.get_name(pid), {}, "", function()
        end)
    end
    if online_playerlist then
        menu.divider(online_playerlist,"玩家信息")
        menu.readonly(online_playerlist, "复制玩家昵称: ", players.get_name(pid))
        menu.readonly(online_playerlist, "复制玩家rid: ", players.get_rockstar_id(pid))
        menu.readonly(online_playerlist, "复制玩家金钱数量: ", players.get_money(pid))
        menu.readonly(online_playerlist, "复制玩家kd: ", players.get_kd(pid))
        menu.action(online_playerlist,"加入黑名单",{},"供临时使用,不会保存到文件",function()
                table.insert(blacklist, players.get_name(pid))
        end)
    else
        menu.divider(players_list,"不可用")
    end
end
function handle_player_list(pid)
    ref = online_playerlist
    if not players.exists(pid) then
        if ref then
            menu.delete(ref)
            online_playerlist = nil
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
                            entities.delete_by_handle(veh)
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
    entities.delete_by_handle(spawnedufo) --delete ufo

    if not STREAMING.HAS_MODEL_LOADED(ufo) then
        util.toast("无法加载模型")
    end
end


-----预加载动作
function character_action()
    menu.action(anims_root, "停止所有动画", {"sexstopanims"}, "", function(on_click)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
    end)
    
    menu.divider(anims_root,"动作列表")

    special_actions = menu.list(anims_root, "特殊动画", {}, "")
        menu.action(special_actions, "握手", {}, "", function(on_click)
            play_anim("mp_ped_interaction","handshake_guy_a", -1)
        end)   
        menu.action(special_actions, "酒吧前台", {}, "", function(on_click)
            play_anim("anim@amb@clubhouse@bar@drink@idle_a","idle_a_bartender", -1)
        end)
        menu.action(special_actions, "酒吧前台", {}, "", function(on_click)
            play_anim("anim@amb@clubhouse@bar@drink@idle_a","idle_a_bartender", -1)
        end)
        menu.action(special_actions, "酒吧前台", {}, "", function(on_click)
            play_anim("anim@amb@clubhouse@bar@drink@idle_a","idle_a_bartender", -1)
        end)
        menu.action(special_actions, "整理", {}, "", function(on_click)
            play_anim("missmic4","michael_tux_fidget", -1)
        end)
        menu.action(special_actions, "握手3", {}, "", function(on_click)
            play_anim("mp_ped_interaction","handshake_guy_a", -1)
        end)
        menu.action(special_actions, "握手4", {}, "", function(on_click)
            play_anim("mp_ped_interaction","handshake_guy_a", -1)
        end)
        menu.action(special_actions, "握手5", {}, "", function(on_click)
            play_anim("mp_ped_interaction","handshake_guy_a", -1)
        end)

    anims_nroot = menu.list(anims_root, "自我动作", {}, "")
        menu.action(anims_nroot, "打管子", {}, "", function(on_click)
            play_anim("switch@trevor@jerking_off", "trev_jerking_off_loop", -1)
        end)
        menu.action(anims_nroot, "后入", {}, "", function(on_click)
            play_anim("rcmpaparazzo_2", "shag_loop_a", -1)
        end)
        menu.action(anims_nroot, "被后入", {}, "", function(on_click)
            play_anim("rcmpaparazzo_2", "shag_loop_poppy", -1)
        end)
        menu.action(anims_nroot, "摁头口", {}, "", function(on_click)
            play_anim("mini@prostitutes@sexlow_veh", "low_car_bj_loop_player", -1)
        end)
        menu.action(anims_nroot, "跪着口", {}, "", function(on_click)
            play_anim("mini@prostitutes@sexlow_veh", "low_car_bj_loop_female", -1)
        end)
        menu.action(anims_nroot, "摸头口", {}, "", function(on_click)
            play_anim("mini@prostitutes@sexlow_veh", "low_car_sex_loop_player", -1)
        end)
        menu.action(anims_nroot, "坐着抽插", {}, "", function(on_click)
            play_anim("mini@prostitutes@sexlow_veh", "low_car_sex_loop_female", -1)
        end)
    dances_root = menu.list(anims_root, "膝上舞蹈", {}, "")
        menu.action(dances_root, "拉普丹斯1", {}, "", function(on_click)
            play_anim("mini@strip_club@private_dance@part1", "priv_dance_p1", -1)
        end)
        menu.action(dances_root, "拉普丹斯2", {}, "", function(on_click)
            play_anim("mini@strip_club@private_dance@part2", "priv_dance_p2", -1)
        end)
        menu.action(dances_root, "拉普丹斯3", {}, "", function(on_click)
            play_anim("mini@strip_club@private_dance@part3", "priv_dance_p3", -1)
        end)
    gangguanwu = menu.list(anims_root, "钢管舞", {}, "")
        menu.action(gangguanwu, "钢管舞1", {}, "", function(on_click)
            play_anim("mini@strip_club@pole_dance@pole_a_2_stage", "pole_a_2_stage", -1)
        end)
        menu.action(gangguanwu, "钢管舞2", {}, "", function(on_click)
            play_anim("mini@strip_club@pole_dance@pole_b_2_stage", "pole_b_2_stage", -1)
        end)
        menu.action(gangguanwu, "钢管舞3", {}, "", function(on_click)
            play_anim("mini@strip_club@pole_dance@pole_c_2_prvd_a", "pole_c_2_prvd_a", -1)
        end)
        menu.action(gangguanwu, "钢管舞4", {}, "", function(on_click)
            play_anim("mini@strip_club@pole_dance@pole_c_2_prvd_b", "pole_c_2_prvd_b", -1)
        end)
        menu.action(gangguanwu, "钢管舞5", {}, "", function(on_click)
            play_anim("mini@strip_club@pole_dance@pole_c_2_prvd_c", "pole_c_2_prvd_c", -1)
        end)
        menu.action(gangguanwu, "钢管舞6", {}, "", function(on_click)
            play_anim("mini@strip_club@pole_dance@pole_c_2_stage", "pole_c_2_stage", -1)
        end)
        menu.action(gangguanwu, "钢管舞7", {}, "", function(on_click)
            play_anim("mini@strip_club@pole_dance@pole_dance1", "pd_dance_01", -1)
        end)
        menu.action(gangguanwu, "钢管舞8", {}, "", function(on_click)
            play_anim("mini@strip_club@pole_dance@pole_dance2", "pd_dance_02", -1)
        end)
        menu.action(gangguanwu, "钢管舞9", {}, "", function(on_click)
            play_anim("mini@strip_club@pole_dance@pole_dance3", "pd_dance_03", -1)
        end)
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

------------------------------------------------------------------------------------序列
function draw_string(s, x, y, scale, font)
	HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
	HUD.SET_TEXT_FONT(font or 0)
	HUD.SET_TEXT_SCALE(scale, scale)
	HUD.SET_TEXT_DROP_SHADOW()
	HUD.SET_TEXT_WRAP(0.0, 1.0)
	HUD.SET_TEXT_DROPSHADOW(1, 0, 0, 0, 0)
	HUD.SET_TEXT_OUTLINE()
	HUD.SET_TEXT_EDGE(1, 0, 0, 0, 0)
	HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(s)
	HUD.END_TEXT_COMMAND_DISPLAY_TEXT(x, y)
end
---fps帧数
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


function zhujixvlie()
    for pid = 0, 31 do
        nexthostxulie = players.get_host_queue_position(pid)
        if #players.list() > 1 then
            if nexthostxulie == 1 then
                nexthost_name = players.get_name(pid)
            end
        else
            nexthost_name = "不可用"
        end
    end

    inviciamountint = 0
        for pid = 0, 31 do
            if players.exists(pid) and pid ~= players.user() then
                local pped = players.user_ped(pid)
                if pped ~= 0 then
                    if players.is_marked_as_modder(pid) then --is_marked_as_modder
                        inviciamountint = inviciamountint + 1
                    end
                end
            end
    local ente
            local ent1e = players.user_ped()
            local ent2e = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
                if PED.IS_PED_IN_ANY_VEHICLE(ent1e,true) then
                    ente = ent2e
                else
                    ente = ent1e
                end
            local speede = ENTITY.GET_ENTITY_SPEED(ente)
            local speedcalce = speede * 3.6
            myspeed1e = math.ceil(speedcalce)
        end
    inviciamountintt = inviciamountint


    if fpstoggle == 1 then
        draw_string(string.format("~bold~~o~FPS: ~b~"..fps), 0.175,0.720, 0.3,1)
    end

	draw_string(string.format("~bold~~p~"..myspeed1e.." ~g~KM/H"), 0.175,0.750, 0.3,1)-----速度
	draw_string(string.format("~bold~~y~"..os.date("%X")), 0.175,0.780, 0.3,1)    -----------------时间
	---draw_string(string.format("~bold~FPS: ~b~"..fps), 0.175,0.800, 0.3,1)
	draw_string(string.format("~bold~战局人数: ~g~"..#players.list()), 0.175,0.810, 0.3,1) 
	draw_string(string.format("~bold~作弊人数: ~r~"..inviciamountintt), 0.175,0.840, 0.3,1)

    if PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**" then
        draw_string(string.format("~bold~战局主机: ~y~不可用", ALIGN_TOP_LEFT), 0.175,0.870, 0.3,1)
    else
        draw_string(string.format("~bold~战局主机: ~y~"..players.get_name(players.get_host())), 0.175,0.870, 0.3,1)
    end

    if PLAYER.GET_PLAYER_NAME(players.get_script_host()) == "**Invalid**" then
        draw_string(string.format("~bold~脚本主机: ~b~不可用", ALIGN_TOP_LEFT), 0.175,0.900, 0.3,1) 
    else
        draw_string(string.format("~bold~脚本主机: ~b~"..players.get_name(players.get_script_host())), 0.175,0.900, 0.3,1)
    end

    draw_string(string.format("~bold~~g~下一位主机: ~p~"..nexthost_name), 0.175,0.930, 0.3,1) 

    local hostxvlie = players.get_host_queue_position(players.user())
        if hostxvlie == 0 then
            draw_string(string.format("~bold~~o~你现在是战局主机"), 0.175,0.960, 0.3,1) 
        else
            draw_string(string.format("~bold~~q~你的主机优先度:~q~ "..hostxvlie), 0.175,0.960, 0.3,1) 
        end


    if PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**" then
        menu.trigger_commands("clearnotifications")
    end

end

----~italic~ 斜体
----~bold~ 加粗
----~?~ color

------------------------------------------------------------------------------------序列

--------------实体池信息
function entityinfo()
draw_string(string.format("~h~~f~实体池Info~"..memory.read_int(pedInterface ).."/"..memory.read_int(pedInterface)), 0,0, 0.32,1)
            draw_string(string.format("~h~PED: ~g~"..memory.read_int(pedInterface + 0x0110).."/"..memory.read_int(pedInterface + 0x0108)), 0,0.03, 0.3,1)
            draw_string(string.format("~h~载具: ~y~"..memory.read_int(vehInterface + 0x0190).."/"..memory.read_int(vehInterface + 0x0188)), 0,0.06, 0.3,1)
            draw_string(string.format("~h~实体: ~r~"..memory.read_int(objectInterface + 0x0168).."/"..memory.read_int(objectInterface + 0x0160)), 0,0.09, 0.3,1)
            draw_string(string.format("~h~拾取物: ~q~ "..memory.read_int(pickupInterface + 0x0110).."/"..memory.read_int(pickupInterface + 0x0108)), 0,0.12, 0.3,1)
end


---------------------------------------------------------------------------------------脚本昵称
mcxh=1
mcr=255
mcg=0
mcb=0
function daidaijiaoben(state)
    sname = state
    while sname do
        if mcxh==1 and mcg<256 then
            HUD.SET_TEXT_COLOUR(mcr, mcg, mcb, 255)	
            if mcg == 255 then
                mcxh=2
            else
                mcg=mcg+1
            end
        elseif mcxh==2 and mcr>-1 then
            HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)
            if mcr == 0 then
                mcxh=3
            else
                mcr=mcr-1
            end
        elseif mcxh==3 and mcb<256 then
            HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)
            if mcb == 255 then
                mcxh=4
            else
                mcb=mcb+1
            end
        elseif mcxh==4 and mcg>-1 then
            HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)
            if mcg == 0 then
                mcxh=5
            else
                mcg=mcg-1
            end
        elseif mcxh==5 and mcr<256 then
            HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)
            if mcr == 255 then
                mcxh=6
            else
                mcr=mcr+1
            end
        elseif mcxh==6 and mcb>-1 then
            HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)
            if mcb == 0 then
                mcxh=1
            else
                mcb=mcb-1
            end
        end
    draw_string(string.format("~italic~¦~bold~呆呆 Lua Script v7.0"), 0.38,0.1, 0.6,5)
    util.yield()
    end
end
---------------------------------------------------------------------------------------脚本昵称

function daidaiunicorn(on)
    if on then
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                menu.trigger_commands("invisiblweaponse on")
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
                dachui = OBJECT.CREATE_OBJECT(util.joaat("ba_prop_battle_cameradrone"), pos.x, pos.y, pos.z, true, true, false)
                tongzi = OBJECT.CREATE_OBJECT(util.joaat("ba_prop_battle_hobby_horse"), pos.x, pos.y, pos.z, true, true, false)
                menu.trigger_commands("damagemultiplier 1000")
                menu.trigger_commands("rangemultiplier 1.5")
                ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, 0.6, 0, 184,180, true, true, false, false, 0, true)
                util.yield(1000)
                bigbarrelqq = on
            else
            menu.trigger_commands("damagemultiplier 1")
            menu.trigger_commands("rangemultiplier 1")
            entities.delete_by_handle(dachui)
            entities.delete_by_handle(tongzi)
            bigbarrelqq = off
            WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
            menu.trigger_commands("invisiblweaponse off")
        end
    end


----呆呆大锤
function daidaihammer(on)
    if on then
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
                dachui = OBJECT.CREATE_OBJECT(util.joaat("ba_prop_battle_cameradrone"), pos.x, pos.y, pos.z, true, true, false)
                tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_mr_raspberry_01"), pos.x, pos.y, pos.z, true, true, false)
                menu.trigger_commands("damagemultiplier 1000")
                menu.trigger_commands("rangemultiplier 1.5")
                ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, 0.15, 0, 180,180, true, true, false, false, 0, true)
                util.yield(1000)
                bigbarrelqq = on
            else
            menu.trigger_commands("damagemultiplier 1")
            menu.trigger_commands("rangemultiplier 1")
            entities.delete_by_handle(dachui)
            entities.delete_by_handle(tongzi)
            bigbarrelqq = off
            WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
        end
    end

--baibai大锤
function baibaihammer(on)
if on then
            WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
            dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_glass_stack_03"), pos.x, pos.y, pos.z, true, true, false)--prop_gate_farm_post
            tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_pile_03"), pos.x, pos.y, pos.z, true, true, false)--h4_prop_h4_barrel_01a
            menu.trigger_commands("damagemultiplier 1000")
            menu.trigger_commands("rangemultiplier 1.5")
            ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
            util.yield(1000)
            bigbarrelqq = on
        else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete_by_handle(dachui)
        entities.delete_by_handle(tongzi)
        bigbarrelqq = off
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
    end
end
----GT大锤
function gthammer(on)
    if on then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_04"), pos.x, pos.y, pos.z, true, true, false)
        tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_03d"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
        util.yield(1000)
        bigbigbig = on
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete_by_handle(dachui)
        entities.delete_by_handle(tongzi)
        bigbigbig = off
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
    end
end

--太刀
function knife(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_cs_katana_01"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.07, 0, 0, -100, 0.0, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end

---小挂件
main_icon = filesystem.store_dir() .. "daidai-IMG\\"
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

----锤子
function hammer(on)
    if on then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02a"), pos.x, pos.y, pos.z, true, true, false)
        tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_02a"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
        util.yield(1000)
        bigbigbig = on
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete_by_handle(dachui)
        entities.delete_by_handle(tongzi)
        bigbigbig = off
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
     end
end

-------喷火器
local flameThrower = {
    colour = mildOrangeFire
}
function flamegun()
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
        flameThrower.ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE('muz_xs_turret_flamethrower_looping', WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped()), 0.8, 0, 0, 0, 0, 270, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped()), 'Gun_Nuzzle'), 0.5, false, false, false)
        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(flameThrower.ptfx, flameThrower.colour.r, flameThrower.colour.g, flameThrower.colour.b)
    end
end

------鸣谢
function acknowledgement()
	menu.divider(acknowledgement_list,"lua作者")
		menu.action(acknowledgement_list,"heezy", {}, "",function()	
		end)
		menu.action(acknowledgement_list,"夜幕", {}, "",function()	
		end)
	menu.divider(acknowledgement_list ,"特别鸣谢")
		menu.action(acknowledgement_list,"你", {}, "当然，我们还鸣谢使用的你",function()	
		end)

end

--火焰翅膀设置-----homer
local new = {}
function new.colour(R, G, B, A)
    return {r = R / 255, g = G / 255, b = B / 255, a = A or 1}
end
mildOrangeFire = new.colour( 255, 127, 80 )
fireWings = {
    [1] = {pos = {[1] = 120, [2] =  75}},
    [2] = {pos = {[1] = 120, [2] = -75}},
    [3] = {pos = {[1] = 135, [2] =  75}},
    [4] = {pos = {[1] = 135, [2] = -75}},
    [5] = {pos = {[1] = 180, [2] =  75}},
    [6] = {pos = {[1] = 180, [2] = -75}},
    [7] = {pos = {[1] = 195, [2] =  75}},
    [8] = {pos = {[1] = 195, [2] = -75}},
}
fireWingsSettings = {
    scale = 0.3,
    colour = mildOrangeFire,
    on = false
}
        bigfireWings = {
            [1] = {pos = {[1] = 120, [2] =  75}},
            [2] = {pos = {[1] = 120, [2] = -75}},
            [3] = {pos = {[1] = 135, [2] =  75}},
            [4] = {pos = {[1] = 135, [2] = -75}},
            [5] = {pos = {[1] = 180, [2] =  75}},
            [6] = {pos = {[1] = 180, [2] = -75}},
            [7] = {pos = {[1] = 190, [2] =  75}},
            [8] = {pos = {[1] = 190, [2] = -75}},
			[9] = {pos = {[1] = 130, [2] =  75}},
            [10] = {pos = {[1] = 130, [2] = -75}},
			[11] = {pos = {[1] = 140, [2] =  75}},
            [12] = {pos = {[1] = 140, [2] = -75}},
			[13] = {pos = {[1] = 150, [2] =  75}},
            [14] = {pos = {[1] = 150, [2] = -75}},
			[15] = {pos = {[1] = 210, [2] =  75}},
            [16] = {pos = {[1] = 210, [2] = -75}},
			[17] = {pos = {[1] = 195, [2] =  75}},
            [18] = {pos = {[1] = 195, [2] = -75}},
			[19] = {pos = {[1] = 160, [2] =  75}},
            [20] = {pos = {[1] = 160, [2] = -75}},
			[21] = {pos = {[1] = 170, [2] =  75}},
            [22] = {pos = {[1] = 170, [2] = -75}},
			[23] = {pos = {[1] = 200, [2] =  75}},
            [24] = {pos = {[1] = 200, [2] = -75}},
        }
function loadModel(hash)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end
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

----------核弹枪
function toDirection(rotation) 
	local adjusted_rotation = { 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = {
		x = - math.sin(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)), 
		y =   math.cos(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)), 
		z =   math.sin(adjusted_rotation.x)
	}
	return direction
end
function raycast_gameplay_cam(flag, distance)
    local ptr1, ptr2, ptr3, ptr4 = memory.alloc(), memory.alloc(), memory.alloc(), memory.alloc()
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = toDirection(CAM.GET_GAMEPLAY_CAM_ROT(0))
    local destination =
    {
        x = cam_pos.x + direction.x * distance,
        y = cam_pos.y + direction.y * distance,
        z = cam_pos.z + direction.z * distance
    }
    SHAPETEST.GET_SHAPE_TEST_RESULT(
        SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
            cam_pos.x,
            cam_pos.y,
            cam_pos.z,
            destination.x,
            destination.y,
            destination.z,
            flag,
            -1,
            1
        ), ptr1, ptr2, ptr3, ptr4)
    local p1 = memory.read_int(ptr1)
    local p2 = memory.read_vector3(ptr2)
    local p3 = memory.read_vector3(ptr3)
    local p4 = memory.read_int(ptr4)
    return {p1, p2, p3, p4}
end
function direction()
    local c1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
    local res = raycast_gameplay_cam(-1, 1000)
    local c2
    if res[1] != 0 then
        c2 = res[2]
    else
        c2 = get_offset_from_gameplay_camera(1000)
    end
    c2.x = (c2.x - c1.x) * 1000
    c2.y = (c2.y - c1.y) * 1000
    c2.z = (c2.z - c1.z) * 1000
    return c2, c1
end
local remove_projectiles = false
local function disableProjectileLoop(projectile)
    util.create_thread(function()
        util.create_tick_handler(function()
            WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(projectile, false)
            return remove_projectiles
        end)
    end)
end
function nuclear()
    if animals_running then menu.trigger_command(exp_animal_toggle, 'off') end
    util.create_tick_handler(function()
        if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) == -1312131151 then
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if not remove_projectiles then
                    remove_projectiles = true
                    disableProjectileLoop(-1312131151)
                end
                util.create_thread(function()
                    local hash = util.joaat('w_arena_airmissile_01a')
                    STREAMING.REQUEST_MODEL(hash)
                    local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
                    local dir, pos = direction()
                    local bomb = entities.create_object(hash, pos)
                    ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
                    ENTITY.SET_ENTITY_ROTATION(bomb, cam_rot.x, cam_rot.y, cam_rot.z, 1, true)
                    while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do util.yield() end
                    local nukePos = ENTITY.GET_ENTITY_COORDS(bomb, true)
                    entities.delete(bomb)
                    executeNuke(nukePos)
                end)
            else
                remove_projectiles = false
            end
        else
            remove_projectiles = false
        end
        return nuke_running
    end)
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
                entities.delete_by_handle(ped)
            end
            util.toast("Ped池达到上限,正在清理...")
        end
    end
    local veh__count = 0
    for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do
        veh__count += 1
        if veh__count >= veh_limit then
            for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do 
                entities.delete_by_handle(veh)   
            end    
            util.toast("载具池达到上限,正在清理...")    
        end    
    end   
    local obj_count = 0    
    for _, obj in pairs(entities.get_all_objects_as_handles()) do    
        obj_count += 1   
        if obj_count >= obj_limit then 
            for _, obj in pairs(entities.get_all_objects_as_handles()) do
                entities.delete_by_handle(obj)
            end
            util.toast("物体池达到上限,正在清理...")
        end
    end 
end


----实体枪
function raycast_gameplay_cam(flag, distance)
    local ptr1, ptr2, ptr3, ptr4 = memory.alloc(), memory.alloc(), memory.alloc(), memory.alloc()
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = v3.toDir(cam_rot)
    local destination = 
    { 
        x = cam_pos.x + direction.x * distance, 
        y = cam_pos.y + direction.y * distance, 
        z = cam_pos.z + direction.z * distance 
    }
    SHAPETEST.GET_SHAPE_TEST_RESULT(
        SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
            cam_pos.x, 
            cam_pos.y, 
            cam_pos.z, 
            destination.x, 
            destination.y, 
            destination.z, 
            flag, 
            players.user_ped(), 
            1
        ), ptr1, ptr2, ptr3, ptr4)
    local p1 = memory.read_int(ptr1)
    local p2 = memory.read_vector3(ptr2)
    local p3 = memory.read_vector3(ptr3)
    local p4 = memory.read_int(ptr4)
    return {p1, p2, p3, p4}
end
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
        request_model_load(hash)
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
-------------

----车祸模拟
function car_crash()
    veh = entities.get_user_vehicle_as_handle()
    if veh == 0 then return end
    CAutomobile = entities.handle_to_pointer(veh)
    CHandlingData = memory.read_long(CAutomobile + 0x0918)
    if util.is_key_down(0x57) and util.is_key_down(0x11) then 
       memory.write_float(CHandlingData + 0x00EC, -0.25)
    else
       memory.write_float(CHandlingData + 0x00EC, 0.5)
    end
end

--氮气加速
local nitro_duration = 5000
local nitro_power = 2000
function nnitrogen_acceleration()
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) and player_cur_car ~= 0 then
        if PAD.IS_CONTROL_JUST_PRESSED(357, 357) then 
            request_ptfx_asset('veh_xs_vehicle_mods')
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

function request_ptfx_asset(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
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
local state = {}
local menus = {}
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
        false, true, attachment.collision, false, 2, true
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
function detach_attached_vehicle()
    if state.attached_vehicle ~= nil then
        util.toast("已分离 "..state.attached_vehicle.name)
        ENTITY.DETACH_ENTITY(state.attached_vehicle.handle, true, true)
        state.attached_vehicle = nil
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
                state.attached_vehicle = attachment
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

--------------GPS导航//////////mainlua
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

local aalib = require("aalib")
local PlaySound = aalib.play_sound
local SND_ASYNC<const> = 0x0001
local SND_FILENAME<const> = 0x00020000
function GPS_navigation(value)
    ----音频
    if value then
        util.toast("[可莉 温馨提示] \n驾驶不规范, 亲人两行泪")

        store_dir = filesystem.store_dir() .. '\\daidai-audio\\GPS\\'
        sound_selection_dir = store_dir .. '\\welcomekeli.txt'

        fp = io.open(sound_selection_dir, 'r')
        local file_selection = fp:read('*a')
        fp:close()

        local sound_location = store_dir .. '\\' .. file_selection
        PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
    end

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
    else
        memory.free(p_distToNxJunction)
        memory.free(p_direction)
        memory.free(p_5)
        memory.free(p_screenX)
        memory.free(p_screenY)
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
    if not STREAMING.HAS_MODEL_LOADED(hash) then
        load_model(hash)
    end
    local oppressor = entities.create_vehicle(hash, c, ENTITY.GET_ENTITY_HEADING(ped))
    ENTITY.SET_ENTITY_INVINCIBLE(oppressor)
    upgrade_vehicle(oppressor)
end

-----车窗
function GetControl(vic, spec, pid)
    if not players.exists(pid) then
        util.stop_thread()
    end
    if pid == players.user() then
        return
    end    
    local tick = 0
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vic)
    while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vic) do
        local nid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(vic)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(nid, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vic)
        util.yield()
        tick =  tick + 1
        if tick > 20 then
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vic) then
                if set.alert then
                    AClang.toast('Could not gain control')
                end
                if not spec then
                    Specoff(pid)
                end
                util.stop_thread()
            end
        
        end
    end
    return NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vic)
end


---------任务警告提示音
function TT()----------------------------------------------------------
    riskwarning()
            util.toast("[呆呆 提示] \n此选项中的功能为高风险，请谨慎使用")
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
-------------------------

------飞机模型崩溃
local planes = {'microlight', 'cuban800', 'tula', 'alphaz1', 'velum2', 'nimbus', 'seabreeze'} -- 'buzzard', 'savage', 'seasparrow', 'frogger2', 'bulldozer', 'flatbed', 'proptrailer', 'tr4'
    local coords = {
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
            util.toast("尝试了1秒，无法加载此指定模型!")
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
                entities.delete_by_handle(handle)
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

            ENTITY.ATTACH_ENTITY_TO_ENTITY_PHYSICALLY(veha1, jet, 0, 0, 0, 0, 5 + (2 * i), 0, 0, 0, 0, 0, 0, 1000, true,
                true, true, true, 2)
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
	for k, v in menu.get_children(menu.ref_by_path("Vehicle>Personal Vehicles")) do
			for k1, v1 in v.command_names do
				if (v1 ~= "findpv")
				then
					menu.trigger_commands(v1.."request")
				end
			end
		end
end


----道奇战马
markedPlayers = {}
otrBlipColour = 58
chatSpamSettings = {
    enabled = false,
    ignoreTeam = true,
    identicalMessages = 5,
}
function executeNuke(pos)
    for a = 0, 100, 4 do
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z + a, 8, 10.0, true, false, 1.0, false)
        util.yield(50)
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z , 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
end
function Streament(hash) --Streaming Model
    STREAMING.REQUEST_MODEL(hash)
    while STREAMING.HAS_MODEL_LOADED(hash) ==false do
    util.yield()
    end
end
local function SF_ff9()
    local scaleform = require('lib.ScaleformLib')
    local sf = scaleform('instructional_buttons')
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
    memory.write_int(memory.script_global(1645739+1121), 1)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
    sf.SET_DATA_SLOT(0,PADdaidai.GET_CONTROL_INSTRUCTIONAL_BUTTON(0, 86, true), '爆炸 或 推开按')
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end
local set = {alert = true}
local charger = {charg = util.joaat('dukes2'), emp = util.joaat('hei_prop_heist_emp')}
local function Ccreate(pCoor, pedSi)
    if ENTITY.DOES_ENTITY_EXIST(charger.charg) ==false then
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
        if  ENTITY.DOES_ENTITY_EXIST(charger.emp) ==false
        then Empa = OBJECT.CREATE_OBJECT(charger.emp, ccoor.x, ccoor.y -1, ccoor.z -1, true, true, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(Empa, FFchar, 0, 0.0, -2.0, 0.5, 0.0, 0.0, 0.0, false, true, false, false, 0, true)
            local CV = CAM.GET_GAMEPLAY_CAM_RELATIVE_HEADING()
            ENTITY.SET_ENTITY_HEADING(FFchar, CV)
            util.yield()
        end
    local magtf = {true, false}
    local maglist = {'推开', '爆炸'}
    local magval = {mag_v = true}
    function Magout()
        if  PAD.IS_CONTROL_PRESSED(0, 86) then
        local car = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        FIRE.ADD_EXPLOSION(car.x, car.y, car.z, 81, 5000.0, false, true, 0.0, magval.mag_v)
        end
    util.yield()
end
    Mag_int = menu.list_action(ff9car, '电磁脉冲样式', {}, '更改样式为推开或炸毁', maglist, function(magint)
        magval.mag_v = magtf[magint]
        end)
      util.create_tick_handler(function ()
            if PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar, false) ==true then
            VEHICLE.SET_VEHICLE_DIRT_LEVEL(FFchar, 0)
            ENTITY.SET_ENTITY_INVINCIBLE(FFchar, true)
            VEHICLE.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(FFchar, false)
            SF_ff9()
            end
        end)
        else
    end
end
function MP_INDEX()
    return "MP" .. util.get_char_slot() .. "_"
end
function daoqizhanma()
    Streament(charger.charg)
    Streament(charger.emp)
    local pedSi = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local pCoor = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local pH = ENTITY.GET_ENTITY_HEADING(pCoor)
        if players.is_in_interior(players.user()) ==true then
            if set.alert then
                util.toast('不要在室内生成道奇战马')
            end
            menu.set_value(Spawn, false)
            return
        end
    if PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar, true) ==false and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ==true then
        local curcar = entities.get_user_vehicle_as_handle()
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(curcar)
        entities.delete_by_handle(curcar)
        if set.alert then
            util.toast('已为您更换新的')
        end
        Ccreate(pCoor, pedSi)
        elseif PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar, true) ==true then
            Magout()
        elseif PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ==false then
                Ccreate(pCoor, pedSi)
                 if set.alert then
                    util.toast('道奇战马已生成')
                 end
        end
    if PED.IS_PED_GETTING_INTO_A_VEHICLE(players.user_ped()) ==false and PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar , false) ==false
            then
                if set.alert then
                    util.toast('已离开道奇战马,道奇战马已被删除')
                end
              menu.set_value(Spawn, false)
              ENTITY.SET_ENTITY_AS_MISSION_ENTITY(FFchar)
              entities.delete_by_handle(FFchar)
              ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Empa)
              entities.delete_by_handle(Empa)
              menu.delete(Mag_int)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(charger.charg)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(charger.emp)
              util.stop_thread()
            end
end
--------------------------------------

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
        ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, 0, 0, 0.3, -80.0, 0, 0, true, false, false, false, 0, true) -- thanks to chaos mod for doing the annoying rotation work for me :P
    else
        entities.delete_by_handle(obj)
        entities.delete_by_handle(veh)
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
        GRAPHICSdaidai._SEETHROUGH_SET_MAX_THICKNESS(1)
    elseif PAD.IS_CONTROL_JUST_PRESSED(38,38) then
        if menu.get_value(thermal_command) or not aiming then
            menu.trigger_command(thermal_command,"off")
            GRAPHICSdaidai._SEETHROUGH_SET_MAX_THICKNESS(1)
        else
            menu.trigger_command(thermal_command,"on")
            GRAPHICSdaidai._SEETHROUGH_SET_MAX_THICKNESS(50)
        end
    end
end


--恶灵骑士
function request_ptfx_asset_firemen(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end

looped_ptfxs = {}
burning_man_ptfx_asset = "core"
burning_man_ptfx_effect = "fire_wrecked_plane_cockpit"
function elqss()
vehicleelqs = CreateVehicle (1491277511,ENTITY.GET_ENTITY_COORDS(players.user_ped(),false),0,true)
ENTITY.SET_ENTITY_RENDER_SCORCHED(vehicleelqs,true)
VEHICLE.SET_VEHICLE_COLOURS(vehicleelqs,147,147)
VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicleelqs,30,15)
PED.SET_PED_INTO_VEHICLE(players.user_ped(),vehicleelqs,-1)
util.yield(500)
request_ptfx_asset_firemen(burning_man_ptfx_asset)
        for _, boneName in pairs({"wheel_lf", "wheel_lr"}) do
GRAPHICS.USE_PARTICLE_FX_ASSET(burning_man_ptfx_asset)
            local bone_id = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicleelqs, boneName)
            fx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(burning_man_ptfx_effect, vehicleelqs, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, bone_id, 0.9, false, false, false, 0, 0, 0, 0)
            looped_ptfxs[#looped_ptfxs+1] = fx
            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, 100, 100, 100, false)
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

----拦截劫匪
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
    while not STREAMING.HAS_ANIM_DICT_LOADED(agroup) do 
        STREAMING.REQUEST_ANIM_DICT(agroup)
        util.yield()
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), agroup, anim, 8.0, 8.0, 3000, 0, 0, true, true, true) --play anim
    util.yield(1000)
    local shit = entities.create_object(mshit, c) --spawn shit
    util.yield(60000)
    entities.delete_by_handle(shit) --delete shit
end
--打飞机
function personlhitplane() 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    c.z = c.z - 1
    while not STREAMING.HAS_ANIM_DICT_LOADED(agroup2) do
        STREAMING.REQUEST_ANIM_DICT(agroup2)
        util.yield()
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), agroup2, anim2, 8.0, 8.0, 5000, 1, 0, true, true, true) --play anim
    util.yield(4500)
    local cum = entities.create_object(cum, c) --spawn cum
    util.yield(60000)
    entities.delete_by_handle(cum) --delete cum
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