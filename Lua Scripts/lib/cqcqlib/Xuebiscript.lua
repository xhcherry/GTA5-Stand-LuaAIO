require "lib.natives-1660775568"
-- SprunkStop
-- a Lua script the Stand Mod Menu for GTA5
-- Save this file in `Stand/Lua Scripts`
-- by Hexarobo

--local SCRIPT_VERSION = "1.3.2"

--local auto_update_source_url = "https://raw.githubusercontent.com/hexarobi/stand-lua-sprunkstop/main/SprunkStop.lua"
--local status, lib = pcall(require, "auto-updater")
--if not status then
   -- async_http.init("raw.githubusercontent.com", "/hexarobi/stand-lua-auto-updater/main/auto-updater.lua",
       --     function(result, headers, status_code) local error_prefix = "Error downloading auto-updater: "
        --        if status_code ~= 200 then util.toast(error_prefix..status_code) return false end
         --       if not result or result == "" then util.toast(error_prefix.."Found empty file.") return false end
           --     local file = io.open(filesystem.scripts_dir() .. "lib\\auto-updater.lua", "wb")
               -- if file == nil then util.toast(error_prefix.."Could not open file for writing.") return false end
              --  file:write(result) file:close() util.toast("Successfully installed auto-updater lib")
          --  end, function() util.toast("Error downloading auto-updater lib. Update failed to download.") end)
   -- async_http.dispatch() util.yield(3000) require("auto-updater")
--end
--run_auto_update({source_url=auto_update_source_url, script_relpath=SCRIPT_RELPATH})

util.require_natives(1651208000)
local a=native_invoker.begin_call;local d=native_invoker.push_arg_int;local a=native_invoker.begin_call;local b=native_invoker.end_call;local c=native_invoker.push_arg_bool;local d=native_invoker.push_arg_int;local e=native_invoker.push_arg_float;local f=native_invoker.push_arg_string;local g=native_invoker.push_arg_pointer;local h=native_invoker.get_return_value_bool;local i=native_invoker.get_return_value_int;local j=native_invoker.get_return_value_float;local k=native_invoker.get_return_value_string;local l=native_invoker.get_return_value_vector3;
C_VEHICLE={
    ["_SET_VEHICLE_INTERIOR_COLOR"]=function(as,js)a()d(as)d(js)b("F40DD601A65F7F19")end,

}
local config = {
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
    --can_rain_range = {
    --    x_max=3, y_max=3, z_max=4,
    --    x_min=-3, y_min=-3, z_min=2,
    --}
}

local function get_rain_range()
    return {
        x_max=config.max_rain_distance, y_max=config.max_rain_distance, z_max=config.max_rain_height,
        x_min=config.max_rain_distance * -1, y_min=config.max_rain_distance * -1, z_min=config.min_rain_height,
    }
end

local spawned_objects = {}

local sprunk_vehicles = {
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

-- From https://stackoverflow.com/questions/12394841/safely-remove-items-from-an-array-table-while-iterating
local function array_remove(t, fnKeep)
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

local random_spawn_vehicles = {}
for _, sprunk_vehicle in pairs(sprunk_vehicles) do
    if sprunk_vehicle.is_random_spawn ~= false then
        table.insert(random_spawn_vehicles, sprunk_vehicle)
    end
end

local function load_hash(hash)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        util.yield()
    end
end

local function show_busyspinner(text)
    HUD.BEGIN_TEXT_COMMAND_BUSYSPINNER_ON("STRING")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(text)
    HUD.END_TEXT_COMMAND_BUSYSPINNER_ON(2)
end

-- From Jackz Vehicle Options script
-- Gets the player's vehicle, attempts to request control. Returns 0 if unable to get control
local function get_player_vehicle_in_control(pid, opts)
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

local function spawn_vehicle_for_player(pid, model_name)
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

local function delete_spawned_object(spawned_object)
    if spawned_object.pilot_handle then
        entities.delete_by_handle(spawned_object.pilot_handle)
    end
    entities.delete_by_handle(spawned_object.handle)
end

local function cleanup_spawned_objects()
    local current_time = util.current_time_millis()
    for i, spawned_object in pairs(spawned_objects) do
        local lifetime = current_time - spawned_object.spawn_time
        local allowed_lifetime = config.can_lifetime
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

local function clear_blimps()
    array_remove(spawned_objects, function(t, i, j)
        local spawned_object = t[i]
        if spawned_object.type == "blimp" then
            delete_spawned_object(spawned_object)
            return false
        end
        return true
    end)
end

local function spawn_object_at_pos(pos, model, ttl)
    local pickup_hash = util.joaat(model)
    load_hash(pickup_hash)
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

local function nearby_position(pos, range)
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

local function sprunk_can_drop(position, range, model, ttl)
    local spawn_position = position
    if range then
        spawn_position = nearby_position(position, range)
    end
    if model == nil then
        model = "ng_proc_sodacan_01b"
    end
    spawn_object_at_pos(spawn_position, model, ttl)
end

local function sprunk_drop_player(pid, range)
    sprunk_can_drop(players.get_position(pid), range)
end

local function sprunk_drop_vehicle(vehicle, range)
    sprunk_can_drop(ENTITY.GET_ENTITY_COORDS(vehicle), range)
end

local function sprunk_raindrop_player(pid)
    sprunk_drop_player(pid, get_rain_range())
end

local function sprunk_raindrop_vehicle(vehicle)
    sprunk_drop_vehicle(vehicle, get_rain_range())
end

local function vehicle_set_mod_max_value(vehicle, vehicle_mod)
    local max = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, vehicle_mod) - 1
    VEHICLE.SET_VEHICLE_MOD(vehicle, vehicle_mod, max)
end

local function vehicle_mods_set_max_performance(vehicle)
    vehicle_set_mod_max_value(vehicle, 11)
    vehicle_set_mod_max_value(vehicle, 13)
    vehicle_set_mod_max_value(vehicle, 12)
    vehicle_set_mod_max_value(vehicle, 16)
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 18, true)
end

local function sprunkify_vehicle(vehicle)

    vehicle_mods_set_max_performance(vehicle)

    -- Set Primary and Secondary colors
    local color = {r=0, g=255, b=0}
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, color.r, color.g, color.b)
    VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, 0, 0, 0)
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, color.r, color.g, color.b)
    VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, 0, 0, 0)

    C_VEHICLE._SET_VEHICLE_INTERIOR_COLOR(vehicle, 55)
    VEHICLE._SET_VEHICLE_DASHBOARD_COLOR(vehicle, 55)

    -- Green Headlights
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 22, true)
    VEHICLE._SET_VEHICLE_XENON_LIGHTS_COLOR(vehicle, 4)

    -- Green Neon Lights
    VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 0, true)
    VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 1, true)
    VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 2, true)
    VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 3, true)
    VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(vehicle, color.r, color.g, color.b)

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
local function trash_dump_player(pid)
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

menu.action(Xuebicar, "汽水罐", {"sprunkdrop"}, "在你附近掉落一罐汽水", function()
    sprunk_can_drop(players.get_position(players.user()))
end)

menu.toggle_loop(Xuebicar, "汽水暴雨", {"sprunkrain"}, "在你附近下起汽水暴雨", function()
    sprunk_raindrop_player(players.user())
    util.yield(config.can_rain_delay)
end)

menu.action(Xuebicar, "绿车车", {}, "好绿的汽水", function(click_type, pid)
    local sprunk_vehicle = random_spawn_vehicles[math.random(1, #random_spawn_vehicles)]
    local vehicle = spawn_vehicle_for_player(pid, sprunk_vehicle.model)
    if vehicle then
        sprunkify_vehicle(vehicle)
        for i = 1,10,1 do
            sprunk_raindrop_vehicle(vehicle)
        end
    end
end, nil, nil, COMMANDPERM_FRIENDLY)

menu.action(Xuebicar, "绿车[先进载具]", {"sprunkify"}, "你的绿车!", function(click_type, pid)
    local vehicle = get_player_vehicle_in_control(pid)
    if vehicle then
        sprunkify_vehicle(vehicle)
    end
end, nil, nil, COMMANDPERM_FRIENDLY)

menu.action(Xuebicar, "倾倒垃圾罐", {"ecola"}, "离离原上草!", function(click_type)
    local pid = players.user()
    trash_dump_player(pid)
end, nil, nil, COMMANDPERM_FRIENDLY)

menu.action(Xuebicar, "绿气传染", {}, "把你的绿色传染给附近载具!", function(click_type)
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
end)

local happy_blimps_toggle = false

local function blimp_control_loop(pid)
    if not happy_blimps_toggle then
        return
    end

    for i, spawned_object in pairs(spawned_objects) do
        if spawned_object.type == "blimp" then

            --if math.random(1, 10) == 1 then
            --    util.toast("new direction "..i)
            --    local target_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(
            --            PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid),
            --            math.random(-config.blimp_spawn_radius, config.blimp_spawn_radius),
            --            math.random(-config.blimp_spawn_radius, config.blimp_spawn_radius),
            --            1000
            --    )
            --    TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(
            --            spawned_object.pilot_handle, spawned_object.handle,
            --            target_pos.x, target_pos.y, target_pos.z, 100.0, 786603, 0.0
            --    )
            --end
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(spawned_object.handle, config.blimp_speed)

        end
    end

end

local function spawn_sprunk_blimp(pid)
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
        math.random(-config.blimp_spawn_radius, config.blimp_spawn_radius),
        math.random(-config.blimp_spawn_radius, config.blimp_spawn_radius),
        math.random(350, 500)
    )

    --if pos.z > 100 then
    --    pos.z = 100
    --end

    local aircraft = entities.create_vehicle(vehicle_hash, pos, math.random(0, 360))
    sprunkify_vehicle(aircraft)
    VEHICLE.SET_VEHICLE_ENGINE_ON(aircraft, true, true, false)
    VEHICLE.SET_HELI_BLADES_FULL_SPEED(aircraft)
    VEHICLE.SET_VEHICLE_FORWARD_SPEED(aircraft, VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(aircraft)/4)

    local pilot = entities.create_ped(1, ped_hash, pos, 0.0)
    PED.SET_PED_INTO_VEHICLE(pilot, aircraft, -1)
    PED.SET_PED_KEEP_TASK(pilot, true)

    --for i = 1,1,10 do
    --    util.toast("new direction")
    --    local target_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(
    --            target_ped,
    --            math.random(-config.blimp_spawn_radius, config.blimp_spawn_radius),
    --            math.random(-config.blimp_spawn_radius, config.blimp_spawn_radius),
    --            1000
    --    )
    --    TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(pilot, aircraft, target_pos.x, target_pos.y, target_pos.z, 100.0, 786603, 0.0)
    --    util.yield(1)
    --end

    local blip = HUD.ADD_BLIP_FOR_ENTITY(aircraft)
    HUD.SET_BLIP_SPRITE(blip, 638)
    HUD.SET_BLIP_COLOUR(blip, 69)

    local ttl = config.blimp_ttl + math.random(-config.blimp_ttl_jitter, config.blimp_ttl_jitter)
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

menu.toggle(Xuebicar, "幸福的飞艇", {}, "快抬头看看!", function(on)
    happy_blimps_toggle = on
    if on then
        for i = 1, config.num_happy_blimps, 1 do
            spawn_sprunk_blimp(players.user())
        end
    else
        clear_blimps()
    end
end)

menu.toggle_loop(Xuebicar, "循环购买", {}, "站在汽水贩卖机前循环开始购买你的绿汽水吧！哎~咋买的是红色的！'", function()
    PAD._SET_CONTROL_NORMAL(0, 51, 1)
    util.yield(math.random(9000, 11000))
end)

player_menu_actions = function(pid)
    menu.divider(menu.player_root(pid), "SprunkStop")

    menu.action(menu.player_root(pid), "绿~汽水！", {"sprunk"}, "生成随机一辆绿载具和少数的汽水罐", function()
        local sprunk_vehicle = random_spawn_vehicles[math.random(1, #random_spawn_vehicles)]
        local vehicle = spawn_vehicle_for_player(pid, sprunk_vehicle.model)
        if vehicle then
            sprunkify_vehicle(vehicle)
            for i = 1,10,1 do
                sprunk_raindrop_vehicle(vehicle)
            end
        end
    end)

    menu.action(menu.player_root(pid), "喷上绿漆", {"sprunkify"}, "把他的载具染成绿色!", function()
        local vehicle = get_player_vehicle_in_control(pid)
        if vehicle then
            sprunkify_vehicle(vehicle)
        end
    end)

    menu.action(menu.player_root(pid), "汽水罐", {"sprunkdrop"}, "在玩家附近掉落一罐汽水", function()
        sprunk_raindrop_player(pid)
    end)

    menu.toggle_loop(menu.player_root(pid), "汽水暴雨", {"sprunkrain"}, "在玩家附近下起汽水暴雨", function()
        sprunk_raindrop_player(pid)
        util.yield(config.can_rain_delay)
    end)

    menu.action(menu.player_root(pid), "倾倒垃圾罐", {"ecola"}, "", function()
        trash_dump_player(pid)
    end)

end
players.on_join(player_menu_actions)
players.dispatch_on_join()


local options_menu = menu.list(Xuebicar, "选项")

menu.slider(options_menu, "暴雨延迟", {}, "每一罐汽水的延迟", 30, 500, config.can_rain_delay, 10, function (value)
    config.can_rain_delay = value
end)

menu.slider(options_menu, "罐子寿命", {}, "掉落的罐子在消失之前应该存在多长时间", 500, 15000, config.can_lifetime, 250, function (value)
    config.can_lifetime = value
end)

menu.slider(options_menu, "雨水距离", {}, "罐子离玩家的最大距离", 1, 20, config.max_rain_distance, 1, function (value)
    config.max_rain_distance = value
end)
menu.slider(options_menu, "雨水最大高度", {}, "罐子能从玩家头上落下的最大高度", -10, 10, config.max_rain_distance, 1, function (value)
    config.max_rain_height = value
end)
menu.slider(options_menu, "雨水最小高度", {}, "罐子能从玩家头上落下的最小高度", -10, 10, config.min_rain_height, 1, function (value)
    config.min_rain_height = value
end)

menu.slider(options_menu, "传染范围", {}, "你的绿气传染的最大距离是多少", 50, 10000, config.sprunkify_bomb_radius, 50, function (value)
    config.sprunkify_bomb_radius = value
end)

menu.slider(options_menu, "飞艇数量", {}, "生成幸福飞艇的数量", 1, 10, config.num_happy_blimps, 1, function (value)
    config.num_happy_blimps = value
end)
menu.slider(options_menu, "飞艇速度", {}, "每个幸福飞艇的速度", 1, 60, config.blimp_speed, 1, function (value)
    config.blimp_speed = value
end)
menu.slider(options_menu, "飞艇寿命", {}, "每个幸福飞艇的寿命，以分钟计时", 1, 10, config.blimp_ttl / 60000, 1, function (value)
    config.blimp_ttl = value * 60000
end)
menu.slider(options_menu, "飞艇生成半径", {}, "幸福飞艇生成的半径", 100, 2000, config.blimp_spawn_radius, 100, function (value)
    config.blimp_spawn_radius = value
end)

---
--- Script Meta
---

--local script_meta_menu = menu.list(Xuebicar, "脚本信息")

--menu.divider(script_meta_menu, SCRIPT_NAME:gsub(".lua", ""))
----menu.readonly(script_meta_menu, "版本", SCRIPT_VERSION)
--menu.hyperlink(script_meta_menu, "资源", "https://github.com/hexarobi/stand-lua-sprunkstop", "在Github上查看源文件")--


util.create_tick_handler(function()
    blimp_control_loop(players.user())
    util.yield(100)
end)

util.create_tick_handler(function()
    if spawned_objects then
        cleanup_spawned_objects()
    end
    return true
end)

