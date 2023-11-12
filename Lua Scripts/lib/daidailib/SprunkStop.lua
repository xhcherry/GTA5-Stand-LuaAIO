sodaconfig = {
    can_lifetime = 5000,
    can_rain_delay = 100,
    max_rain_distance = 3,
    min_rain_height = 2,
    max_rain_height = 4,
    sprunkify_bomb_radius = 500,
    num_happy_blimps = 4,
    blimp_speed = 15,
    blimp_spawn_radius = 500,
    blimp_ttl = 300000,
    blimp_ttl_jitter = 1000,
}

function get_rain_range()
    return {
        x_max=sodaconfig.max_rain_distance, y_max=sodaconfig.max_rain_distance, z_max=sodaconfig.max_rain_height,
        x_min=sodaconfig.max_rain_distance * -1, y_min=sodaconfig.max_rain_distance * -1, z_min=sodaconfig.min_rain_height,
    }
end

spawned_objects = {}
sprunk_vehicles = {
    {
        model="thrax",
        livery=8,
    },
    {
        model="tezeract",
        livery=2,
    },
    {
        model="nero2",
        livery=6
    },
    {
        model="champion",
        livery=9
    },
    {
        model="jugular",
        livery=7
    },
    {
        model="buffalo3",
        livery=-1
    },
    {
        model="gb200",
        livery=9
    },
    {
        model="paragon",
        livery=6
    },
    {
        model="issi7",
        livery=6
    },
    {
        model="imorgon",
        livery=4
    },
    {
        model="zr350",
        livery=6
    },
    {
        model="euros",
        livery=13
    },
    {
        model="brioso",
        livery=1
    },
    {
        model="asbo",
        livery=5
    },
    {
        model="faction3",
        livery=5
    },
    {
        model="buffalo4",
        livery=6
    },
    {
        model="novak",
        livery=6
    },
    {
        model="sanchez",
        livery=-1,
        type="motorcycle",
    },
    {
        model="bf400",
        livery=1,
        type="motorcycle",
    },
    {
        model="bati2",
        livery=3,
        type="motorcycle",
    },
    {
        model="reever",
        livery=9,
        type="motorcycle",
    },
    {
        model="formula",
        livery=1
    },
    {
        model="openwheel1",
        livery=7
    },
    {
        model="veto2",
        livery=0,
        type="gokart",
    },
    {
        model="pony",
        livery=2,
        type="van",
    },
    {
        model="stunt",
        livery=2,
        type="plane",
    },
    {
        model="alphaz1",
        livery=5,
        type="plane",
    },
    {
        model="microlight",
        livery=4,
        type="plane",
    },
    {
        model="havok",
        livery=2,
        type="helicopter",
    },
    {
        model="starling",
        livery=7,
        type="plane",
    },
    {
        model="blimp3",
        livery=4,
        type="blimp",
        is_random_spawn=false
    },
}

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

for _, sprunk_vehicle in pairs(sprunk_vehicles) do
    sprunk_vehicle.model_hash = util.joaat(sprunk_vehicle.model)
end

random_spawn_vehicles = {}
for _, sprunk_vehicle in pairs(sprunk_vehicles) do
    if sprunk_vehicle.is_random_spawn ~= false then
        table.insert(random_spawn_vehicles, sprunk_vehicle)
    end
end

function show_busyspinner(text)
    HUD.BEGIN_TEXT_COMMAND_BUSYSPINNER_ON("STRING")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(text)
    HUD.END_TEXT_COMMAND_BUSYSPINNER_ON(2)
end

-- From Jackz Vehicle Options script
-- Gets the player's vehicle, attempts to request control. Returns 0 if unable to get control
function get_player_vehicle_in_control(pid, opts)
    local my_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()) -- Needed to turn off spectating while getting control
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

    -- Calculate how far away from target
    local pos1 = ENTITY.GET_ENTITY_COORDS(target_ped)
    local pos2 = ENTITY.GET_ENTITY_COORDS(my_ped)
    local dist = SYSTEM.VDIST2(pos1.x, pos1.y, 0, pos2.x, pos2.y, 0)

    local was_spectating = NETWORK.NETWORK_IS_IN_SPECTATOR_MODE() -- Needed to toggle it back on if currently spectating
    -- If they out of range (value may need tweaking), auto spectate.
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(target_ped, true)
    if opts and opts.near_only and vehicle == 0 then
        return 0
    end
    if vehicle == 0 and target_ped ~= my_ped and dist > 340000 and not was_spectating then
        util.toast("Player is too far, auto-spectating for upto 3s.")
        show_busyspinner("Player is too far, auto-spectating for upto 3s.")
        NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, target_ped)
        -- To prevent a hard 3s loop, we keep waiting upto 3s or until vehicle is acquired
        local loop = (opts and opts.loops ~= nil) and opts.loops or 30 -- 3000 / 100
        while vehicle == 0 and loop > 0 do
            util.yield(100)
            vehicle = PED.GET_VEHICLE_PED_IS_IN(target_ped, true)
            loop = loop - 1
        end
        HUD.BUSYSPINNER_OFF()
    end

    if vehicle > 0 then
        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            return vehicle
        end
        -- Loop until we get control
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(vehicle)
        local has_control_ent = false
        local loops = 15
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)

        -- Attempts 15 times, with 8ms per attempt
        while not has_control_ent do
            has_control_ent = NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
            loops = loops - 1
            -- wait for control
            util.yield(15)
            if loops <= 0 then
                break
            end
        end
    end
    if not was_spectating then
        NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, target_ped)
    end
    return vehicle
end

function spawn_vehicle_for_player(pid, model_name)
    local model = util.joaat(model_name)
    if not STREAMING.IS_MODEL_VALID(model) or not STREAMING.IS_MODEL_A_VEHICLE(model) then
        return
    else
        request_model(model)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, 0.0, 4.0, 0.5)
        local heading = ENTITY.GET_ENTITY_HEADING(target_ped)
        local vehicle = entities.create_vehicle(model, pos, heading)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(model)
        return vehicle
    end
end

function delete_spawned_object(spawned_object)
    if spawned_object.pilot_handle then
        entities.delete_by_handle(spawned_object.pilot_handle)
    end
    entities.delete_by_handle(spawned_object.handle)
end

function cleanup_spawned_objects()
    local current_time = util.current_time_millis()
    for i, spawned_object in pairs(spawned_objects) do
        local lifetime = current_time - spawned_object.spawn_time
        local allowed_lifetime = sodaconfig.can_lifetime
        if spawned_object.ttl ~= nil then
            allowed_lifetime = spawned_object.ttl
        end
        if lifetime > allowed_lifetime then
            delete_spawned_object(spawned_object)
            table.remove(spawned_objects, i)
            if spawned_object.respawn_function then
                spawned_object.respawn_function(spawned_object.pid)
            end
        end
    end
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

function spawn_object_at_pos(pos, model, ttl)
    local pickup_hash = util.joaat(model)
    request_model(pickup_hash)
    local pickup_pos = v3.new(pos.x, pos.y, pos.z)
    local pickup = entities.create_object(pickup_hash, pickup_pos)
    ENTITY.SET_ENTITY_COLLISION(pickup, true, true)
    --ENTITY.SET_ENTITY_HAS_GRAVITY(pickup, true)
    --OBJECT.SET_OBJECT_PHYSICS_PARAMS(pickup, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0)
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

function sprunk_drop_player(pid, range)
    sprunk_can_drop(players.get_position(pid), range)
end

function sprunk_drop_vehicle(vehicle, range)
    sprunk_can_drop(ENTITY.GET_ENTITY_COORDS(vehicle), range)
end

function sprunk_raindrop_player(pid)
    sprunk_drop_player(pid, get_rain_range())
end

function sprunk_raindrop_vehicle(vehicle)
    sprunk_drop_vehicle(vehicle, get_rain_range())
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

    -- Set Primary and Secondary colors
    local color = {r=0, g=255, b=0}
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, color.r, color.g, color.b)
    VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, 0, 0, 0)
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, color.r, color.g, color.b)
    VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, 0, 0, 0)

    VEHICLE1._SET_VEHICLE_INTERIOR_COLOR(vehicle, 55)
    VEHICLE1._SET_VEHICLE_DASHBOARD_COLOR(vehicle, 55)

    -- Green Headlights
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 22, true)
    VEHICLE1._SET_VEHICLE_XENON_LIGHTS_COLOR(vehicle, 4)

    -- Green Neon Lights
    VEHICLE1._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 0, true)
    VEHICLE1._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 1, true)
    VEHICLE1._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 2, true)
    VEHICLE1._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 3, true)
    VEHICLE1._SET_VEHICLE_NEON_LIGHTS_COLOUR(vehicle, color.r, color.g, color.b)

    -- Set Wheel Color
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, 0, 55)

    -- Set Tire Smoke Color
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 20, true)
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, 0, 255, 0)

    -- Set License Plate
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, true, true)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "SPRUNK")

    -- Set Livery only if its a Sprunk livery
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



--主菜单
menu.action(green_soda, "汽水罐", {}, "在你附近掉落一罐汽水", function()
    sprunk_can_drop(players.get_position(players.user()))
end)

menu.toggle_loop(green_soda, "汽水暴雨", {}, "在你附近下起汽水暴雨", function()
    sprunk_raindrop_player(players.user())
    util.yield(sodaconfig.can_rain_delay)
end)

menu.action(green_soda, "绿汽水", {}, "生成一辆绿车", function(click_type, pid)
    local sprunk_vehicle = random_spawn_vehicles[math.random(1, #random_spawn_vehicles)]
    local vehicle = spawn_vehicle_for_player(pid, sprunk_vehicle.model)
    if vehicle then
        sprunkify_vehicle(vehicle)
        for i = 1,10,1 do
            sprunk_raindrop_vehicle(vehicle)
        end
    end
end)

menu.action(green_soda, "染成绿车", {}, "把你的载具染成绿色", function(click_type, pid)
    local vehicle = get_player_vehicle_in_control(pid)
    if vehicle then
        sprunkify_vehicle(vehicle)
    end
end)

menu.action(green_soda, "倾倒垃圾罐", {"ecola"}, "一大堆垃圾罐!", function(click_type)
    local pid = players.user()
    trash_dump_player(pid)
end)

menu.action(green_soda, "绿气传染", {}, "把你的绿色传染给附近载具!", function(click_type)
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
    util.toast(count.." 载具已染色!")
end)

local happy_blimps_toggle = false
function blimp_control_loop(pid)
    if not happy_blimps_toggle then
        return
    end
    for i, spawned_object in pairs(spawned_objects) do
        if spawned_object.type == "blimp" then
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(spawned_object.handle, sodaconfig.blimp_speed)
        end
    end
end

function spawn_sprunk_blimp(pid)
    if not happy_blimps_toggle then
        return
    end

    local vehicle_hash = util.joaat('blimp3')
    local ped_hash = util.joaat("s_m_m_pilot_01")
    request_model(vehicle_hash)
    request_model(ped_hash)

    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(
        target_ped,
        math.random(-sodaconfig.blimp_spawn_radius, sodaconfig.blimp_spawn_radius),
        math.random(-sodaconfig.blimp_spawn_radius, sodaconfig.blimp_spawn_radius),
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

    local ttl = sodaconfig.blimp_ttl + math.random(-sodaconfig.blimp_ttl_jitter, sodaconfig.blimp_ttl_jitter)
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

menu.toggle(green_soda, "幸福的飞艇", {}, "快抬头看看!", function(on)
    happy_blimps_toggle = on
    if on then
        for i = 1, sodaconfig.num_happy_blimps, 1 do
            spawn_sprunk_blimp(players.user())
        end
        while happy_blimps_toggle do
            blimp_control_loop(players.user())
            util.yield(100)
        end
    else
        clear_blimps()
    end
end)

menu.toggle_loop(green_soda, "循环购买", {}, "站在汽水贩卖机前循环开始购买你的绿汽水吧！哎~咋买的是红色的！'", function()
    PAD2._SET_CONTROL_NORMAL(0, 51, 1)
    util.yield(math.random(9000, 11000))
end)

local options_menu = menu.list(green_soda, "选项")
    menu.slider(options_menu, "暴雨延迟", {}, "每一罐汽水的延迟", 30, 500, sodaconfig.can_rain_delay, 10, function (value)
        sodaconfig.can_rain_delay = value
    end)
    menu.slider(options_menu, "罐子寿命", {}, "掉落的罐子在消失之前应该存在多长时间", 500, 15000, sodaconfig.can_lifetime, 250, function (value)
        sodaconfig.can_lifetime = value
    end)
    menu.slider(options_menu, "雨水距离", {}, "罐子离玩家的最大距离", 1, 20, sodaconfig.max_rain_distance, 1, function (value)
        sodaconfig.max_rain_distance = value
    end)
    menu.slider(options_menu, "雨水最大高度", {}, "罐子能从玩家头上落下的最大高度", -10, 10, sodaconfig.max_rain_distance, 1, function (value)
        sodaconfig.max_rain_height = value
    end)
    menu.slider(options_menu, "雨水最小高度", {}, "罐子能从玩家头上落下的最小高度", -10, 10, sodaconfig.min_rain_height, 1, function (value)
        sodaconfig.min_rain_height = value
    end)
    menu.slider(options_menu, "传染范围", {}, "你的绿气传染的最大距离是多少", 50, 10000, sodaconfig.sprunkify_bomb_radius, 50, function (value)
        sodaconfig.sprunkify_bomb_radius = value
    end)
    menu.slider(options_menu, "飞艇数量", {}, "生成幸福飞艇的数量", 1, 10, sodaconfig.num_happy_blimps, 1, function (value)
        sodaconfig.num_happy_blimps = value
    end)
    menu.slider(options_menu, "飞艇速度", {}, "每个幸福飞艇的速度", 1, 60, sodaconfig.blimp_speed, 1, function (value)
        sodaconfig.blimp_speed = value
    end)
    menu.slider(options_menu, "飞艇寿命", {}, "每个幸福飞艇的寿命，以分钟计时", 1, 10, sodaconfig.blimp_ttl / 60000, 1, function (value)
        sodaconfig.blimp_ttl = value * 60000
    end)
    menu.slider(options_menu, "飞艇生成半径", {}, "幸福飞艇生成的半径", 100, 2000, sodaconfig.blimp_spawn_radius, 100, function (value)
        sodaconfig.blimp_spawn_radius = value
    end)

