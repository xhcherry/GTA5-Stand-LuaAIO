---@param ped Ped
---@return boolean
Blip_Color_Red = {
    1,  -- BLIP_COLOUR_RED
    49, -- BLIP_COLOUR_FRIENDLY
    59, -- BLIP_COLOUR_HUDCOLOUR_RED
    75,
    79,
}
Globals = {
    IsUsingComputerScreen = 75693,
    -- appHackerTruck
    SpecialCargoBuyScreenString = "appHackerTruck",
    SpecialCargoBuyScreenArgs = 4592, -- arg count needed to properly start the script, possibly outdated

    CEO_Ability = {
        -- global, default_value
        Cost = {
            { 12847, 1000 },  -- Drop Ammo
            { 12848, 1500 },  -- Drop Armor
            { 12849, 1000 },  -- Drop Bull Shark
            { 12850, 12000 }, -- Ghost Organization
            { 12851, 15000 }, -- Bribe Authorities
            { 15890, 5000 },  -- Request Luxury Helicopter
        },
        Cooldown = {
            { 12834, 30000 },  -- Drop Ammo
            { 12835, 30000 },  -- Drop Armor
            { 12836, 30000 },  -- Drop Bull Shark
            { 12837, 600000 }, -- Ghost Organization
            { 12838, 600000 }, -- Bribe Authorities
        },
    },
    
    CEO_Vehicle_Request_Cost = {
        -- global, default_value
        { 12842, 20000 }, { 12843, 5000 }, { 12844, 5000 }, { 12845, 5000 }, { 12846, 25000 },
        { 15959, 5000 }, { 15960, 5000 }, { 15961, 5000 },
        { 15968, 10000 }, { 15969, 7000 }, { 15970, 9000 }, { 15971, 5000 }, { 15972, 5000 }, { 15973, 5000 },
        { 19302, 5000 }, { 19304, 10000 },
    },

    RC_Bandito = 2793046 + 6874,     -- freemode.c, (..., joaat("rcbandito"), 1)
    RC_Tank = 2793046 + 6875,        -- freemode.c, (..., joaat("minitank"), 1)
    Ballistic_Armor = 2793046 + 896, -- freemode.c, (!NETWORK::NETWORK_IS_SCRIPT_ACTIVE("AM_AMMO_DROP", PLAYER::PLAYER_ID(), true, 0))
   
    -- 无视犯罪
    NCOPS = {
        type = 2793046 + 4654,
        flag = 2793046 + 4655,
        time = 2793046 + 4657,
    },
    GB_GHOST_ORG_DURATION = 262145 + 13149,
    GB_BRIBE_AUTHORITIES_DURATION = 262145 + 13150,
    FIXER_SECURITY_CONTRACT_REFRESH_TIME = 262145 + 31700,
    GB_CALL_VEHICLE_COOLDOWN = 262145 + 12832,
}

Globals.RemoveCooldown = {}

function isInTable(tbl, value)
    for k, v in pairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

function Globals.RemoveCooldown.SpecialCargo(toggle)
    if toggle then
        SET_INT_GLOBAL(262145 + 15553, 0) -- EXEC_BUY_COOLDOWN
        SET_INT_GLOBAL(262145 + 15554, 0) -- EXEC_SELL_COOLDOWN
    else
        SET_INT_GLOBAL(262145 + 15553, 300000)
        SET_INT_GLOBAL(262145 + 15554, 1800000)
    end
end

function Globals.RemoveCooldown.VehicleCargo(toggle)
    if toggle then
        SET_INT_GLOBAL(262145 + 19314, 0) -- IMPEXP_STEAL_COOLDOWN
        SET_INT_GLOBAL(262145 + 19682, 0) -- 1 Vehicle, 1001423248
        SET_INT_GLOBAL(262145 + 19683, 0) -- 2 Vehicles, 240134765
        SET_INT_GLOBAL(262145 + 19684, 0) -- 3 Vehicles, 1915379148
        SET_INT_GLOBAL(262145 + 19685, 0) -- 4 Vehicles, -824005590
    else
        SET_INT_GLOBAL(262145 + 19314, 180000)
        SET_INT_GLOBAL(262145 + 19682, 1200000)
        SET_INT_GLOBAL(262145 + 19683, 1680000)
        SET_INT_GLOBAL(262145 + 19684, 2340000)
        SET_INT_GLOBAL(262145 + 19685, 2880000)
    end
end

function Globals.RemoveCooldown.AirFreightCargo(toggle)
    if toggle then
        SET_INT_GLOBAL(262145 + 22751, 0) -- Tobacco, Counterfeit Goods, SMUG_STEAL_EASY_COOLDOWN_TIMER
        SET_INT_GLOBAL(262145 + 22752, 0) -- Animal Materials, Art, Jewelry, SMUG_STEAL_MED_COOLDOWN_TIMER
        SET_INT_GLOBAL(262145 + 22753, 0) -- Narcotics, Chemicals, Medical Supplies, SMUG_STEAL_HARD_COOLDOWN_TIMER
        SET_INT_GLOBAL(262145 + 22754, 0) -- Additional Time per Player, 1722502526
        SET_INT_GLOBAL(262145 + 22755, 0) -- Sale, -1091356151
    else
        SET_INT_GLOBAL(262145 + 22751, 120000)
        SET_INT_GLOBAL(262145 + 22752, 180000)
        SET_INT_GLOBAL(262145 + 22753, 240000)
        SET_INT_GLOBAL(262145 + 22754, 60000)
        SET_INT_GLOBAL(262145 + 22755, 2000)
    end
end

function Globals.RemoveCooldown.PayphoneHitAndContract(toggle)
    if toggle then
        SET_INT_GLOBAL(262145 + 31701, 0) -- FIXER_SECURITY_CONTRACT_COOLDOWN_TIME
        SET_INT_GLOBAL(262145 + 31765, 0) -- -2036534141
        SET_INT_GLOBAL(262145 + 31781, 0) -- 1872071131
    else
        SET_INT_GLOBAL(262145 + 31701, 300000)
        SET_INT_GLOBAL(262145 + 31765, 500)
        SET_INT_GLOBAL(262145 + 31781, 1200000)
    end
end

Locals = {
    -- fm_mission_controller_2020
    MC_TLIVES_2020 = 48647 + 868 + 1,
    -- fm_mission_controller
    MC_TLIVES = 26133 + 1325 + 1,
}

---@param vehicle Vehicle
---@return boolean
function IS_PLAYER_VEHICLE(vehicle)
    if ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
        if vehicle == entities.get_user_vehicle_as_handle() or vehicle == entities.get_user_personal_vehicle_as_handle() then
            return true
        elseif not VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, -1, false) then
            local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1)
            if ped ~= 0 then
                if IS_PED_PLAYER(ped) then
                    return true
                end
            end
        end
    end
    return false
end

function is_friendly_ped(ped)
    if ENTITY.DOES_ENTITY_EXIST(ped) and ENTITY.IS_ENTITY_A_PED(ped) then
        local rel = PED.GET_RELATIONSHIP_BETWEEN_PEDS(ent, players.user_ped())
        if rel == 0 or rel == 1 then -- Respect or Like
            return true
        end
    end
    return false
end

function is_hostile_ped(ped)
    if ENTITY.DOES_ENTITY_EXIST(ped) and ENTITY.IS_ENTITY_A_PED(ped) then
        if PED.IS_PED_IN_COMBAT(ped, players.user_ped()) then
            return true
        end

        local rel = PED.GET_RELATIONSHIP_BETWEEN_PEDS(ped, players.user_ped())
        if rel == 4 or rel == 5 then -- Wanted or Hate
            return true
        end
    end
    return false
end

function IS_SCRIPT_RUNNING(str)
    return SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat(str)) > 0
end

function START_SCRIPT(str, arg_count)
    if not SCRIPT.DOES_SCRIPT_EXIST(str) then
        return false
    end
    if IS_SCRIPT_RUNNING(str) then
        return true
    end
    SCRIPT.REQUEST_SCRIPT(str)
    while not SCRIPT.HAS_SCRIPT_LOADED(str) do
        util.yield()
    end
    SYSTEM.START_NEW_SCRIPT(str, arg_count or 0)
    SCRIPT.SET_SCRIPT_AS_NO_LONGER_NEEDED(str)
    return true
end

function add_owned_explosion(owner, coords, explosionType, optionalParams)
    explosionType = explosionType or 2
    local Params = optionalParams or {}
    Params.damageScale = Params.damageScale or 1.0
    if Params.isAudible == nil then Params.isAudible = true end
    Params.cameraShake = Params.cameraShake or 0.0

    FIRE.ADD_OWNED_EXPLOSION(owner, coords.x, coords.y, coords.z,
        explosionType,
        Params.damageScale, Params.isAudible, Params.isInvisible, Params.cameraShake)
end

function IS_HOSTILE_ENTITY(entity)
    if ENTITY.DOES_ENTITY_EXIST(entity) then
        if ENTITY.IS_ENTITY_A_PED(entity) then
            if is_hostile_ped(entity) then
                return true
            end
        end

        if ENTITY.IS_ENTITY_A_VEHICLE(entity) then
            local driver = GET_PED_IN_VEHICLE_SEAT(entity, -1)
            if is_hostile_ped(entity) then
                return true
            end
        end

        local blip = HUD.GET_BLIP_FROM_ENTITY(entity)
        if HUD.DOES_BLIP_EXIST(blip) then
            local blip_color = HUD.GET_BLIP_COLOUR(blip)
            if isInTable(Blip_Color_Red, blip_color) then
                return true
            end
        end
    end
    return false
end

function GET_PED_IN_VEHICLE_SEAT(vehicle, seat)
    if not VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, seat, false) then
        return VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, seat)
    end
    return 0
end

---@param ped Ped
---@return Vehicle
function GET_VEHICLE_PED_IS_IN(ped)
    if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
        return PED.GET_VEHICLE_PED_IS_IN(ped, false)
    end
    return 0
end

function TP_TO_ENTITY(ent, offsetX, offsetY, offsetZ)
    if offsetX == nil then offsetX = 0.0 end
    if offsetY == nil then offsetY = 0.0 end
    if offsetZ == nil then offsetZ = 0.0 end
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, offsetX, offsetY, offsetZ)
    TELEPORT(coords.x, coords.y, coords.z)
end

function TP_INTO_VEHICLE(vehicle, door, driver)
    if ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
        --unlock doors
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 1)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, players.user(), false)
        --driver
        local ped = GET_PED_IN_VEHICLE_SEAT(vehicle, -1)
        if ped then
            if driver == "tp" then
                local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 0.0, 5.0, 3.0)
                SET_ENTITY_COORDS(ped, coords)
            elseif driver == "delete" then
                entities.delete_by_handle(ped)
            end
        end
        --tp into
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, false)
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -1)
        --door
        if door == "delete" then
            VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 0, true)
        elseif door == "open" then
            VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, 0, false, false)
        end
    end
end

function SET_ENTITY_COORDS(entity, coords)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(entity, coords.x, coords.y, coords.z, true, false, false)
end

function TP_VEHICLE_TO_ME(vehicle, door, driver)
    if ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
        SET_ENTITY_HEAD_TO_ENTITY(vehicle, players.user_ped())
        TP_TO_ME(vehicle, 0.0, 0.0, 0.0)
        TP_INTO_VEHICLE(vehicle, door, driver)
    end
end

function SET_ENTITY_HEAD_TO_ENTITY(set_ent, to_ent, angle)
    if angle == nil then angle = 0.0 end
    local Head = ENTITY.GET_ENTITY_HEADING(to_ent)
    ENTITY.SET_ENTITY_HEADING(set_ent, Head + angle)
end

function TP_TO_ME(ent, offsetX, offsetY, offsetZ)
    if offsetX == nil then offsetX = 0.0 end
    if offsetY == nil then offsetY = 0.0 end
    if offsetZ == nil then offsetZ = 0.0 end
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), offsetX, offsetY, offsetZ)
    SET_ENTITY_COORDS(ent, coords)
end

function TP_VEHICLE_TO_ME(vehicle, door, driver)
    if ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
        SET_ENTITY_HEAD_TO_ENTITY(vehicle, players.user_ped())
        TP_TO_ME(vehicle, 0.0, 0.0, 0.0)
        TP_INTO_VEHICLE(vehicle, door, driver)
    end
end

---@param start_pos v3
---@param end_pos v3
---@param colour? Colour
function DRAW_LINE(start_pos, end_pos, colour)
    colour = colour or { r = 255, g = 0, b = 255, a = 255 }
    GRAPHICS.DRAW_LINE(start_pos.x, start_pos.y, start_pos.z, end_pos.x, end_pos.y, end_pos.z, colour.r, colour.g,
        colour.b, colour.a)
end

---@param Type string
---@param isMission boolean
---@param ... Hash
---@return table<int, entity>
function get_entities_by_hash(Type, isMission, ...)
    local all_entity = get_all_entities(Type)

    local entity_list = {}
    local args = { ... } -- Hash list

    for k, ent in pairs(all_entity) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        for _, Hash in pairs(args) do
            if EntityHash == Hash then
                if isMission then
                    if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
                        table.insert(entity_list, ent)
                    end
                else
                    table.insert(entity_list, ent)
                end
            end
        end
    end

    return entity_list
end

---@param Type string
---@return table<int, entity>
function get_all_entities(Type)
    local all_entity = {}
    Type = string.lower(Type)
    if Type == "ped" then
        all_entity = entities.get_all_peds_as_handles()
    elseif Type == "vehicle" then
        all_entity = entities.get_all_vehicles_as_handles()
    elseif Type == "object" then
        all_entity = entities.get_all_objects_as_handles()
    elseif Type == "pickup" then
        all_entity = entities.get_all_pickups_as_handles()
    end
    return all_entity
end

---@param entity Entity
---@param owner Ped
function fall_entity_explosion(entity, owner)
    ENTITY.FREEZE_ENTITY_POSITION(entity, false)
    ENTITY.SET_ENTITY_MAX_SPEED(entity, 99999.0)

    if ENTITY.IS_ENTITY_A_PED(entity) then
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(entity)
        PED.SET_PED_TO_RAGDOLL(entity, 500, 500, 0, false, false, false)
    end
    ENTITY.APPLY_FORCE_TO_ENTITY(entity, 1, 0.0, 0.0, 30.0, math.random(-2, 2), math.random(-2, 2), 0.0, 0, false,
        false
        , true, false, false)
    util.yield(1000)
    ENTITY.APPLY_FORCE_TO_ENTITY(entity, 1, 0.0, 0.0, -100.0, 0.0, 0.0, 0.0, 0, false, false, true, false, false)
    util.yield(300)

    local coords = ENTITY.GET_ENTITY_COORDS(entity)
    if owner then
        FIRE.ADD_OWNED_EXPLOSION(owner, coords.x, coords.y, coords.z, 4, 1.0, true, false, 0.0)
    else
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 4, 1.0, true, false, 0.0, false)
    end
end

function add_explosion(coords, explosionType, optionalParams)
    explosionType = explosionType or 2
    local Params = optionalParams or {}
    Params.damageScale = Params.damageScale or 1.0
    if Params.isAudible == nil then Params.isAudible = true end
    Params.cameraShake = Params.cameraShake or 0.0

    FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z,
        explosionType,
        Params.damageScale, Params.isAudible, Params.isInvisible, Params.cameraShake, Params.noDamage)
end

---@param vehicle Vehicle
function unlock_vehicle_doors(vehicle)
    if ENTITY.DOES_ENTITY_EXIST(vehicle) and ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 1)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(vehicle, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_TEAMS(vehicle, false)
        VEHICLE.SET_DONT_ALLOW_PLAYER_TO_ENTER_VEHICLE_IF_LOCKED_FOR_PLAYER(vehicle, false)
    end
end

function GET_NEARBY_OBJECTS(pid, radius)
    local objs = {}
    local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local p_pos = ENTITY.GET_ENTITY_COORDS(p)
    for k, obj in pairs(entities.get_all_objects_as_handles()) do
        local obj_pos = ENTITY.GET_ENTITY_COORDS(obj)
        if radius <= 0 then
            table.insert(objs, obj)
        elseif v3.distance(p_pos, obj_pos) <= radius then
            table.insert(objs, obj)
        end
    end
    return objs
end

-- 常用武器
Weapon_Common = {
    ListItem = {
        { "小刀" },
        { "穿甲手枪" },
        { "电击枪" },
        { "微型冲锋枪" },
        { "特质卡宾步枪" },
        { "突击霰弹枪" },
        { "火神机枪" },
        { "火箭筒" },
        { "电磁步枪" },
    },
    ModelList = {
        "WEAPON_KNIFE",
        "WEAPON_APPISTOL",
        "WEAPON_STUNGUN",
        "WEAPON_MICROSMG",
        "WEAPON_SPECIALCARBINE",
        "WEAPON_ASSAULTSHOTGUN",
        "WEAPON_MINIGUN",
        "WEAPON_RPG",
        "WEAPON_RAILGUN",
    }
}

---------------------------
--------- 附近载具 ---------
---------------------------

local control_nearby_vehicle = {
    is_tick_handler = false,
    setting = {
        radius = 30.0,
        time_delay = 1000,
        exclude_mission = true,
        exclude_dead = true,
    },
    toggles = {
        --Trolling
        remove_godmode = false,
        explosion = false,
        emp = false,
        broken_door = false,
        open_door = false,
        kill_engine = false,
        burst_tyre = false,
        full_dirt = false,
        remove_window = false,
        leave_vehicle = false,
        forward_speed = false,
        max_speed = false,
        alpha = false,
        --Friendly
        godmode = false,
        fix_vehicle = false,
        fix_engine = false,
        fix_tyre = false,
        clean_dirt = false,
    },
    data = {
        forward_speed = 30,
        max_speed = 0,
        alpha = 0,
        force_field = 1.0,
        launch_height = 30.0,
    },
}

function control_nearby_vehicle.toggle_switch(toggle_func)
    toggle_func()
    if not control_nearby_vehicle.is_tick_handler then
        control_nearby_vehicle.control_vehicles()
    end
end

function control_nearby_vehicle.get_vehicles()
    local vehicles = {}
    local player_pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local radius = control_nearby_vehicle.setting.radius

    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        local vehicle = 0
        local ent_pos = ENTITY.GET_ENTITY_COORDS(ent)
        if radius <= 0 then
            vehicle = ent
        elseif v3.distance(player_pos, ent_pos) <= radius then
            vehicle = ent
        end

        if vehicle ~= 0 then
            if IS_PLAYER_VEHICLE(vehicle) then
                --排除玩家载具
            elseif control_nearby_vehicle.setting.exclude_mission and ENTITY.IS_ENTITY_A_MISSION_ENTITY(vehicle) then
                --排除任务载具
            elseif control_nearby_vehicle.setting.exclude_dead and ENTITY.IS_ENTITY_DEAD(vehicle) then
                --排除已死亡实体
            else
                table.insert(vehicles, vehicle)
            end
        end
    end
    return vehicles
end

function control_nearby_vehicle.control_vehicles()
util.create_tick_handler(function()
local is_all_false = true
for _, i in pairs(control_nearby_vehicle.toggles) do
if i then
    is_all_false = false
end
end
if is_all_false then
control_nearby_vehicle.is_tick_handler = false
util.log("[RScript] Control Nearby Vehicles: Stop Tick Handler")
return false
end
--------
control_nearby_vehicle.is_tick_handler = true
for k, vehicle in pairs(control_nearby_vehicle.get_vehicles()) do
--请求控制
RequestControl(vehicle)
--移除无敌
if control_nearby_vehicle.toggles.remove_godmode then
    ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
    ENTITY.SET_ENTITY_PROOFS(vehicle, false, false, false, false, false, false, false, false)
end
--爆炸
if control_nearby_vehicle.toggles.explosion then
    local pos = ENTITY.GET_ENTITY_COORDS(vehicle)
    add_explosion(pos)
end
--电磁脉冲
if control_nearby_vehicle.toggles.emp then
    local pos = ENTITY.GET_ENTITY_COORDS(vehicle)
    add_explosion(pos, 65, { noDamage = true })
end
--拆下车门
if control_nearby_vehicle.toggles.broken_door then
    for i = 0, 3 do
        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, i, false)
    end
end
--打开车门
if control_nearby_vehicle.toggles.open_door then
    for i = 0, 3 do
        VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, i, false, false)
    end
end
--破坏引擎
if control_nearby_vehicle.toggles.kill_engine then
    VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, -4000)
end
--爆胎
if control_nearby_vehicle.toggles.burst_tyre then
    for i = 0, 5 do
        if not VEHICLE.IS_VEHICLE_TYRE_BURST(vehicle, i, true) then
            VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, i, true, 1000.0)
        end
    end
end
--布满灰尘
if control_nearby_vehicle.toggles.full_dirt then
    VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, 15.0)
end
--删除车窗
if control_nearby_vehicle.toggles.remove_window then
    for i = 0, 7 do
        VEHICLE.REMOVE_VEHICLE_WINDOW(vehicle, i)
    end
end
--跳出载具
if control_nearby_vehicle.toggles.leave_vehicle then
    local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1)
    if ped and not TASK.GET_IS_TASK_ACTIVE(ped, 176) then
        TASK.TASK_LEAVE_VEHICLE(ped, vehicle, 4160)
    end
end
--向前加速
if control_nearby_vehicle.toggles.forward_speed then
    VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, control_nearby_vehicle.data.forward_speed)
end
--实体最大速度
if control_nearby_vehicle.toggles.max_speed then
    ENTITY.SET_ENTITY_MAX_SPEED(vehicle, control_nearby_vehicle.data.max_speed)
end
--透明度
if control_nearby_vehicle.toggles.alpha then
    ENTITY.SET_ENTITY_ALPHA(vehicle, control_nearby_vehicle.data.alpha, false)
end


------
--给予无敌
if control_nearby_vehicle.toggles.godmode then
    ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
end
--修复载具
if control_nearby_vehicle.toggles.fix_vehicle then
    VEHICLE.SET_VEHICLE_FIXED(vehicle)
end
--修复引擎
if control_nearby_vehicle.toggles.fix_engine then
    VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, 1000)
end
--修复轮胎
if control_nearby_vehicle.toggles.fix_tyre then
    for i = 0, 3 do
        VEHICLE.SET_VEHICLE_TYRE_FIXED(vehicle, i)
    end
end
--清理载具
if control_nearby_vehicle.toggles.clean_dirt then
    VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, 0.0)
end
end


util.yield(control_nearby_vehicle.setting.time_delay)
end)
end

--------------
-- Menu
--------------

---@param coords v3
---@param radius float
---@param colour? Colour
function DRAW_MARKER_SPHERE(coords, radius, colour)
    colour = colour or { r = 200, g = 50, b = 200, a = 0.5 }
    WIRI_GRAPHICS.DRAW_MARKER_SPHERE(coords.x, coords.y, coords.z, radius, colour.r, colour.g, colour.b, colour.a)
end

local Nearby_Vehicle_options = menu.list(carfly, "战局载具控制面板", {}, "")

menu.slider_float(Nearby_Vehicle_options, "范围半径", { "radius_nearby_vehicle" }, "若半径是0,则为全部范围",
    0, 100000, 3000, 1000,
    function(value)
        control_nearby_vehicle.setting.radius = value * 0.01
    end)
menu.toggle_loop(Nearby_Vehicle_options, "绘制范围", {}, "", function()
    local coords = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    DRAW_MARKER_SPHERE(coords, control_nearby_vehicle.setting.radius)
end)

local Nearby_Vehicle_Setting = menu.list(Nearby_Vehicle_options, "设置", {}, "")
menu.slider(Nearby_Vehicle_Setting, "时间间隔", { "delay_nearby_vehicle" }, "单位: ms", 0, 5000, 1000, 100,
    function(value)
        control_nearby_vehicle.setting.time_delay = value
    end)
menu.toggle(Nearby_Vehicle_Setting, "排除任务载具", {}, "", function(toggle)
    control_nearby_vehicle.setting.exclude_mission = toggle
end, true)
menu.toggle(Nearby_Vehicle_Setting, "排除已死亡实体", {}, "", function(toggle)
    control_nearby_vehicle.setting.exclude_dead = toggle
end, true)


----------------------
--  附近载具 恶搞选项
----------------------
local Nearby_Vehicle_Trolling_options = menu.list(Nearby_Vehicle_options, "恶搞选项", {}, "")
--------------------
-- Loop
--------------------
menu.toggle(Nearby_Vehicle_Trolling_options, "移除无敌", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.remove_godmode = toggle
    end)
end)
menu.toggle(Nearby_Vehicle_Trolling_options, "爆炸", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.explosion = toggle
    end)
end)
menu.toggle(Nearby_Vehicle_Trolling_options, "电磁脉冲", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.emp = toggle
    end)
end)
menu.toggle(Nearby_Vehicle_Trolling_options, "打开车门", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.open_door = toggle
    end)
end)
menu.toggle(Nearby_Vehicle_Trolling_options, "拆下车门", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.broken_door = toggle
    end)
end)
menu.toggle(Nearby_Vehicle_Trolling_options, "破坏引擎", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.kill_engine = toggle
    end)
end)
menu.toggle(Nearby_Vehicle_Trolling_options, "爆胎", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.burst_tyre = toggle
    end)
end)
menu.toggle(Nearby_Vehicle_Trolling_options, "布满灰尘", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.full_dirt = toggle
    end)
end)
menu.toggle(Nearby_Vehicle_Trolling_options, "删除车窗", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.remove_window = toggle
    end)
end)
menu.toggle(Nearby_Vehicle_Trolling_options, "司机跳出载具", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.leave_vehicle = toggle
    end)
end)
menu.slider(Nearby_Vehicle_Trolling_options, "设置向前加的速度", { "nearby_veh_forward_speed" }, "",
    0, 1000, 30, 10, function(value)
        control_nearby_vehicle.data.forward_speed = value
    end)
menu.toggle(Nearby_Vehicle_Trolling_options, "向前加速", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.forward_speed = toggle
    end)
end)
menu.slider(Nearby_Vehicle_Trolling_options, "实体最大的速度", { "nearby_veh_max_speed" }, "",
    0, 1000, 0, 10, function(value)
        control_nearby_vehicle.data.max_speed = value
    end)
menu.toggle(Nearby_Vehicle_Trolling_options, "设置实体最大速度", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.max_speed = toggle
    end)
end)
menu.slider(Nearby_Vehicle_Trolling_options, "透明度", { "nearby_veh_alpha" },
    "Ranging from 0 to 255 but chnages occur after every 20 percent (after every 51).", 0, 255, 0, 5,
    function(value)
        control_nearby_vehicle.data.alpha = value
    end)
menu.toggle(Nearby_Vehicle_Trolling_options, "设置透明度", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.alpha = toggle
    end)
end)
--------------------
-- No Delay Loop
--------------------
menu.slider_float(Nearby_Vehicle_Trolling_options, "力场强度", { "nearby_veh_forcefield" }, "",
    100, 10000, 100, 100, function(value)
        control_nearby_vehicle.data.force_field = value * 0.01
    end)
menu.toggle_loop(Nearby_Vehicle_Trolling_options, "力场 (推开)", {}, "", function()
    for k, vehicle in pairs(control_nearby_vehicle.get_vehicles()) do
        local force = ENTITY.GET_ENTITY_COORDS(vehicle)
        v3.sub(force, ENTITY.GET_ENTITY_COORDS(players.user_ped()))
        v3.normalise(force)
        v3.mul(force, control_nearby_vehicle.data.force_field)
        ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 3, force.x, force.y, force.z, 0, 0, 0.5, 0, false, false, true,
            false, false)
    end
end)
--------------------
-- Once
--------------------
menu.action(Nearby_Vehicle_Trolling_options, "颠倒", {}, "", function()
    for k, vehicle in pairs(control_nearby_vehicle.get_vehicles()) do
        ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 5.0, 5.0, 0.0, 0.0, 0, false, true, true, true, true)
    end
end)
menu.action(Nearby_Vehicle_Trolling_options, "随机喷漆", {}, "", function()
    for k, vehicle in pairs(control_nearby_vehicle.get_vehicles()) do
        local primary, secundary = get_random_colour(), get_random_colour()
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, primary.r, primary.g, primary.b)
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, secundary.r, secundary.g, secundary.b)
    end
end)
menu.slider(Nearby_Vehicle_Trolling_options, "上天高度", { "nearby_veh_launch" }, "",
    0, 1000, 30, 10, function(value)
        control_nearby_vehicle.data.launch_height = value
    end)
menu.action(Nearby_Vehicle_Trolling_options, "发射上天", {}, "", function()
    for k, vehicle in pairs(control_nearby_vehicle.get_vehicles()) do
        ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, control_nearby_vehicle.data.launch_height, 0.0, 0.0, 0.0, 0,
            false, false, true, false, false)
    end
end)
menu.action(Nearby_Vehicle_Trolling_options, "坠落爆炸", {}, "", function()
    for k, vehicle in pairs(control_nearby_vehicle.get_vehicles()) do
        util.create_thread(function()
            fall_entity_explosion(vehicle)
        end)
    end
end)


----------------------
-- 附近载具 友好选项
----------------------
local Nearby_Vehicle_Friendly_options = menu.list(Nearby_Vehicle_options, "友好选项", {}, "")
menu.toggle(Nearby_Vehicle_Friendly_options, "给予无敌", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.godmode = toggle
    end)
end)
menu.toggle(Nearby_Vehicle_Friendly_options, "修复载具", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.fix_vehicle = toggle
    end)
end)
menu.toggle(Nearby_Vehicle_Friendly_options, "修复引擎", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.fix_engine = toggle
    end)
end)
menu.toggle(Nearby_Vehicle_Friendly_options, "修复轮胎", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.fix_tyre = toggle
    end)
end)
menu.toggle(Nearby_Vehicle_Friendly_options, "清理载具", {}, "", function(toggle)
    control_nearby_vehicle.toggle_switch(function()
        control_nearby_vehicle.toggles.clean_dirt = toggle
    end)
end)


----- 全部范围 -----
menu.divider(Nearby_Vehicle_options, "全部范围")
menu.action(Nearby_Vehicle_options, "解锁车门", { "unlock_veh_door" }, "", function()
    for k, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
        unlock_vehicle_doors(vehicle)
        VEHICLE.SET_VEHICLE_IS_CONSIDERED_BY_PLAYER(vehicle, true)
        VEHICLE.SET_VEHICLE_UNDRIVEABLE(vehicle, false)
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, false)

        VEHICLE.SET_VEHICLE_IS_WANTED(vehicle, false)
        VEHICLE.SET_VEHICLE_INFLUENCES_WANTED_LEVEL(vehicle, false)
        VEHICLE.SET_VEHICLE_HAS_BEEN_OWNED_BY_PLAYER(vehicle, true)
        VEHICLE.SET_VEHICLE_IS_STOLEN(vehicle, false)
    end
end)
menu.action(Nearby_Vehicle_options, "打开左右车门和引擎", { "open_veh_door" }, "", function()
    for k, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, false)
        VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, 0, false, false)
        VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, 1, false, false)
    end
end)
menu.action(Nearby_Vehicle_options, "拆下左右车门和打开引擎", { "broken_veh_door" }, "", function()
    for k, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, false)
        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 0, false)
        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 1, false)
    end
end)


--------------------------
---- 管理附近NPC ---------
--------------------------
Vector = {
    ['new'] = function(x, y, z)
        return { ['x'] = x, ['y'] = y, ['z'] = z }
    end,
    --return a - b
    ['subtract'] = function(a, b)
        return Vector.new(a.x - b.x, a.y - b.y, a.z - b.z)
    end,
    --return a + b
    ['add'] = function(a, b)
        return Vector.new(a.x + b.x, a.y + b.y, a.z + b.z)
    end,
    ['mag'] = function(a)
        return math.sqrt(a.x ^ 2 + a.y ^ 2 + a.z ^ 2)
    end,
    ['norm'] = function(a)
        local mag = Vector.mag(a)
        return Vector.div(a, mag)
    end,
    --return a * b
    ['mult'] = function(a, b)
        return Vector.new(a.x * b, a.y * b, a.z * b)
    end,
    --return a / b
    ['div'] = function(a, b)
        return Vector.new(a.x / b, a.y / b, a.z / b)
    end,
    --return the distance between two vectors
    ['dist'] = function(a, b)
        return Vector.mag(Vector.subtract(a, b))
    end
}

local control_nearby_ped = {
    is_tick_handler = false,
    setting = {
        radius = 30.0,
        time_delay = 1000,
        exclude_ped_in_vehicle = true,
        exclude_mission = true,
        exclude_dead = true,
    },
    toggles = {
        --Trolling
        force_forward = false,
        drop_weapon = false,
        ignore_events = false,
        explode_head = false,
        ragdoll = false,
        --Friendly
        drop_money = false,
        give_weapon = false,
    },
    data = {
        forward_degree = 30,
        drop_money_amount = 100,
        weapon_hash = 4130548542,
        launch_height = 30.0,
        force_field = {
            strength = 1.0,
            direction = 1,
            ragdoll = true,
        },
    },
}

function control_nearby_ped.toggle_switch(toggle_func)
    toggle_func()
    if not control_nearby_ped.is_tick_handler then
        control_nearby_ped.control_peds()
    end
end

function control_nearby_ped.get_peds()
    local peds = {}
    local player_pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local radius = control_nearby_ped.setting.radius

    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        local ped = 0
        local ent_pos = ENTITY.GET_ENTITY_COORDS(ent)
        if radius <= 0 then
            ped = ent
        elseif v3.distance(player_pos, ent_pos) <= radius then
            ped = ent
        end

        if ped ~= 0 then
            if IS_PED_PLAYER(ped) then
                --排除玩家
            elseif control_nearby_ped.setting.exclude_ped_in_vehicle and PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
                --排除载具内NPC
            elseif control_nearby_ped.setting.exclude_mission and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped) then
                --排除任务NPC
            elseif control_nearby_ped.setting.exclude_dead and ENTITY.IS_ENTITY_DEAD(ped) then
                --排除已死亡实体
            else
                table.insert(peds, ped)
            end
        end
    end
    return peds
end

function control_nearby_ped.control_peds()
    util.create_tick_handler(function()
        local is_all_false = true
        for _, i in pairs(control_nearby_ped.toggles) do
            if i then
                is_all_false = false
            end
        end
        if is_all_false then
            control_nearby_ped.is_tick_handler = false
            util.log("[RScript] Control Nearby Peds: Stop Tick Handler")
            return false
        end
        --------
        control_nearby_ped.is_tick_handler = true
        for k, ped in pairs(control_nearby_ped.get_peds()) do
            --请求控制
            RequestControl(ped)
            --向前推进
            if control_nearby_ped.toggles.force_forward then
                ENTITY.SET_ENTITY_MAX_SPEED(ped, 99999)
                local vector = WIRI_ENTITY.GET_ENTITY_FORWARD_VECTOR(ped)
                local force = Vector.mult(vector, control_nearby_ped.data.forward_degree)
                ENTITY.APPLY_FORCE_TO_ENTITY(ped, 1, force.x, force.y, force.z, 0.0, 0.0, 0.0, 1, false, true,
                    true, true, true)
            end
            --丢弃武器
            if control_nearby_ped.toggles.drop_weapon then
                WEAPON.SET_PED_DROPS_WEAPONS_WHEN_DEAD(ped)
                WEAPON.SET_PED_DROPS_WEAPON(ped)
                WEAPON.SET_PED_AMMO_TO_DROP(ped, 9999)
            end
            --忽略其它临时事件
            if control_nearby_ped.toggles.ignore_events then
                PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
                TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
            end
            --爆头
            if control_nearby_ped.toggles.explode_head then
                posped = ENTITY.GET_ENTITY_COORDS(ped)
                FIRE.ADD_EXPLOSION(posped.x, posped.y, posped.z, 0, 1, true, false, 1, false)
            end
            --摔倒
            if control_nearby_ped.toggles.ragdoll then
                PED.SET_PED_TO_RAGDOLL(ped, 500, 500, 0, false, false, false)
            end

            ------
            --修改掉落现金
            if control_nearby_ped.toggles.drop_money then
                PED.SET_PED_MONEY(ped, control_nearby_ped.data.drop_money_amount)
                PED.SET_AMBIENT_PEDS_DROP_MONEY(true)
            end
            --给予武器
            if control_nearby_ped.toggles.give_weapon then
                WEAPON.GIVE_WEAPON_TO_PED(ped, control_nearby_ped.data.weapon_hash, -1, false, true)
                WEAPON.SET_CURRENT_PED_WEAPON(ped, control_nearby_ped.data.weapon_hash, false)
            end
        end


        util.yield(control_nearby_ped.setting.time_delay)
    end)
end

local Nearby_Ped_options = menu.list(lobbyFeats, "NPC控制面板", {}, "")

menu.slider_float(Nearby_Ped_options, "生效范围", { "radius_nearby_ped" }, "若半径是0,则为全部范围",
    0, 100000, 3000, 1000, function(value)
        control_nearby_ped.setting.radius = value * 0.01
    end)
menu.toggle_loop(Nearby_Ped_options, "预览范围", {}, "", function()
    local coords = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    DRAW_MARKER_SPHERE(coords, control_nearby_ped.setting.radius)
end)

local Nearby_Ped_Setting = menu.list(Nearby_Ped_options, "功能设置", {}, "")
menu.slider(Nearby_Ped_Setting, "时间间隔", { "delay_nearby_ped" }, "单位: ms",
    0, 5000, 1000, 100, function(value)
        control_nearby_ped.setting.time_delay = value
    end)
menu.toggle(Nearby_Ped_Setting, "排除载具内NPC", {}, "", function(toggle)
    control_nearby_ped.setting.exclude_ped_in_vehicle = toggle
end, true)
menu.toggle(Nearby_Ped_Setting, "排除任务NPC", {}, "", function(toggle)
    control_nearby_ped.setting.exclude_mission = toggle
end, true)
menu.toggle(Nearby_Ped_Setting, "排除已死亡实体", {}, "", function(toggle)
    control_nearby_ped.setting.exclude_dead = toggle
end, true)


----------------------
--  附近NPC 恶搞选项
----------------------
local Nearby_Ped_Trolling_options = menu.list(Nearby_Ped_options, "恶搞选项", {}, "")
--------------------
-- Loop
--------------------
menu.slider(Nearby_Ped_Trolling_options, "设置向前推进程度", { "ped_forward_degree" }, "",
    0, 1000, 30, 10, function(value)
        control_nearby_ped.data.forward_speed = value
    end)
menu.toggle(Nearby_Ped_Trolling_options, "向前推进", {}, "", function(toggle)
    control_nearby_ped.toggle_switch(function()
        control_nearby_ped.toggles.force_forward = toggle
    end)
end)
menu.toggle(Nearby_Ped_Trolling_options, "丢弃武器", {}, "", function(toggle)
    control_nearby_ped.toggle_switch(function()
        control_nearby_ped.toggles.drop_weapon = toggle
    end)
end)
menu.toggle(Nearby_Ped_Trolling_options, "忽略临时事件", {}, "", function(toggle)
    control_nearby_ped.toggle_switch(function()
        control_nearby_ped.toggles.ignore_events = toggle
    end)
end)
menu.toggle(Nearby_Ped_Trolling_options, "爆头", {}, "", function(toggle)
    control_nearby_ped.toggle_switch(function()
        control_nearby_ped.toggles.explode_head = toggle
    end)
end)
menu.toggle(Nearby_Ped_Trolling_options, "摔倒", {}, "", function(toggle)
    control_nearby_ped.toggle_switch(function()
        control_nearby_ped.toggles.ragdoll = toggle
    end)
end)
--------------------
-- Once
--------------------
menu.slider(Nearby_Ped_Trolling_options, "上天高度", { "nearby_ped_launch" }, "",
    0, 1000, 30, 10, function(value)
        control_nearby_ped.data.launch_height = value
    end)
menu.action(Nearby_Ped_Trolling_options, "发射上天", {}, "", function()
    for k, ped in pairs(control_nearby_ped.get_peds()) do
        ENTITY.APPLY_FORCE_TO_ENTITY(ped, 1, 0.0, 0.0, control_nearby_ped.data.launch_height, 0.0, 0.0, 0.0, 0, false
        , false, true, false, false)
    end
end)
menu.action(Nearby_Ped_Trolling_options, "坠落爆炸", {}, "", function()
    for k, ped in pairs(control_nearby_ped.get_peds()) do
        util.create_thread(function()
            fall_entity_explosion(ped)
        end)
    end
end)
--------------------
-- No Delay Loop
--------------------
menu.divider(Nearby_Ped_Trolling_options, "力场")
menu.slider_float(Nearby_Ped_Trolling_options, "强度", { "nearby_ped_forcefield_strength" }, "", 100, 10000, 100, 100
, function(value)
    control_nearby_ped.data.force_field.strength = value * 0.01
end)
menu.slider_text(Nearby_Ped_Trolling_options, "方向", {}, "", { "推开", "拉进" }, function(value)
    control_nearby_ped.data.force_field.direction = value
end)
menu.toggle(Nearby_Ped_Trolling_options, "摔倒", {}, "", function(toggle)
    control_nearby_ped.data.force_field.ragdoll = toggle
end, true)
menu.toggle_loop(Nearby_Ped_Trolling_options, "开启", {}, "", function()
    for k, ped in pairs(control_nearby_ped.get_peds()) do
        local force = ENTITY.GET_ENTITY_COORDS(ped)
        v3.sub(force, ENTITY.GET_ENTITY_COORDS(players.user_ped()))
        v3.normalise(force)
        v3.mul(force, control_nearby_ped.data.force_field.strength)

        if control_nearby_ped.data.force_field.direction == 2 then
            v3.mul(force, -1)
        end
        if control_nearby_ped.data.force_field.ragdoll then
            PED.SET_PED_TO_RAGDOLL(ped, 500, 500, 0, false, false, false)
        end
        ENTITY.APPLY_FORCE_TO_ENTITY(ped, 3, force.x, force.y, force.z, 0, 0, 0.5, 0, false, false, true,
            false, false)
    end
end)


----------------------
--  附近NPC 友好选项
----------------------
local Nearby_Ped_Friendly_options = menu.list(Nearby_Ped_options, "友好选项", {}, "")
menu.slider(Nearby_Ped_Friendly_options, "掉落现金数量", { "ped_drop_money_amonut" }, "", 0, 2000, 100, 100,
    function(value)
        control_nearby_ped.data.drop_money_amount = value
    end)
menu.toggle(Nearby_Ped_Friendly_options, "修改掉落现金", {}, "", function(toggle)
    control_nearby_ped.toggle_switch(function()
        control_nearby_ped.toggles.drop_money = toggle
    end)
end)
menu.list_select(Nearby_Ped_Friendly_options, "设置武器", {}, "", Weapon_Common.ListItem, 1, function(value)
    control_nearby_ped.data.weapon_hash = util.joaat(Weapon_Common.ModelList[value])
end)
menu.toggle(Nearby_Ped_Friendly_options, "给予武器", {}, "", function(toggle)
    control_nearby_ped.toggle_switch(function()
        control_nearby_ped.toggles.give_weapon = toggle
    end)
end)


----- 全部范围 -----
menu.divider(Nearby_Ped_options, "全部范围")

----------------------
--  附近NPC 作战能力
----------------------
local Nearby_Ped_Combat_options = menu.list(Nearby_Ped_options, "作战能力", {}, "")


----- 作战能力 -----
local nearby_ped_combat = {
    health = 100,
    armour = 0,
    see_range = 0.0,
    hear_range = 0.0,
    id_range = 0.0,
    peripheral_range = 0.0,
    peripheral_angle = 0.0,
    highly_perceptive = false,
    accuracy = 0,
    shoot_rate = 0,
    combat_ability = 0,
    combat_range = 0,
    combat_movement = 0,
    target_loss_response = 0,
    remove_defensive_area = true,
    stop_drop_fire = true,
    disable_injured_behaviour = true,
    dies_when_injured = false,
}

local Nearby_Ped_Combat_setting = menu.list(Nearby_Ped_Combat_options, "作战能力设置", {}, "")
menu.slider(Nearby_Ped_Combat_setting, "生命", { "combat_health" }, "生命值低于100就会死", 0, 10000, 100, 50,
    function(value)
        nearby_ped_combat.health = value
    end)
menu.slider(Nearby_Ped_Combat_setting, "护甲", { "combat_armour" }, "", 0, 100, 0, 10, function(value)
    nearby_ped_combat.armour = value
end)
menu.slider(Nearby_Ped_Combat_setting, "视力范围", { "combat_see_range" }, "", 0.0, 500.0, 0.0, 1.0,
    function(value)
        nearby_ped_combat.see_range = value
    end)
menu.slider(Nearby_Ped_Combat_setting, "听力范围", { "combat_hear_range" }, "", 0.0, 500.0, 0.0, 1.0,
    function(value)
        nearby_ped_combat.hear_range = value
    end)
menu.slider(Nearby_Ped_Combat_setting, "识别范围", { "combat_id_range" }, "", 0.0, 500.0, 0.0, 1.0,
    function(value)
        nearby_ped_combat.id_range = value
    end)
menu.slider(Nearby_Ped_Combat_setting, "锥形视野范围", { "combat_peripheral_range" }, "", 0.0, 500.0, 0.0, 1.0,
    function(value)
        nearby_ped_combat.peripheral_range = value
    end)
menu.slider(Nearby_Ped_Combat_setting, "侦查视野角度", { "combat_peripheral_angle" }, "", -90.0, 90.0, 0.0, 1.0,
    function(value)
        nearby_ped_combat.peripheral_angle = value
    end)
menu.toggle(Nearby_Ped_Combat_setting, "高度警觉性", {}, "", function(toggle)
    nearby_ped_combat.highly_perceptive = toggle
end)
menu.slider(Nearby_Ped_Combat_setting, "精准度", { "combat_accuracy" }, "", 0, 100, 0, 5, function(value)
    nearby_ped_combat.accuracy = value
end)
menu.slider(Nearby_Ped_Combat_setting, "射击频率", { "combat_shoot_rate" }, "", 0, 1000, 0, 10, function(value)
    nearby_ped_combat.shoot_rate = value
end)
menu.list_select(Nearby_Ped_Combat_setting, "作战技能", {}, "", {
    { "弱" }, { "普通" }, { "专业" }
}, 1, function(value)
    nearby_ped_combat.combat_ability = value - 1
end)
menu.list_select(Nearby_Ped_Combat_setting, "作战范围", {}, "", {
    { "近" }, { "中等" }, { "远" }, { "非常远" }
}, 1, function(value)
    nearby_ped_combat.combat_range = value - 1
end)
menu.list_select(Nearby_Ped_Combat_setting, "作战走位", {}, "", {
    { "站立" }, { "防卫" }, { "会前进" }, { "会后退" }
}, 1, function(value)
    nearby_ped_combat.combat_movement = value - 1
end)
menu.list_select(Nearby_Ped_Combat_setting, "失去目标时反应", {}, "", {
    { "退出战斗" }, { "从不失去目标" }, { "寻找目标" }
}, 1, function(value)
    nearby_ped_combat.target_loss_response = value - 1
end)
menu.toggle(Nearby_Ped_Combat_setting, "移除防卫区域", {}, "Ped will no longer get angry when you stay near him.",
    function(toggle)
        nearby_ped_combat.remove_defensive_area = toggle
    end, true)
menu.toggle(Nearby_Ped_Combat_setting, "武器掉落时不会走火", {}, "", function(toggle)
    nearby_ped_combat.stop_drop_fire = toggle
end, true)
menu.toggle(Nearby_Ped_Combat_setting, "禁止受伤时在地面打滚", {}, "", function(toggle)
    nearby_ped_combat.disable_injured_behaviour = toggle
end, true)
menu.toggle(Nearby_Ped_Combat_setting, "一受伤就死亡", {}, "", function(toggle)
    nearby_ped_combat.dies_when_injured = toggle
end)


----- 作战属性 -----
local Nearby_Ped_Combat_Attributes = menu.list(Nearby_Ped_Combat_options, "作战属性设置", {}, "")

local nearby_ped_combat_attr = {
    toggles = {},
    menus = {}
}

local ped_combat_attr_list = {
    -- { id, name, help_text }
    { 0, "具有躲避功能",
        "他们可以躲避子弹" },
    { 1, "使用载具",
        "允许NPC使用载具" },
    { 2, "允许驾驶",
        "NPC允许执行驾驶且攻击" },
    { 4, "可以使用动态决策",
        "NPC可以根据到目的地的距离、最近的子弹事件等来决定是否攻击" },
    { 5, "保持攻击模式",
        "NPC将持续保持攻击状态，除非他们死亡" },
    { 11, "寻找掩护",
        "NPC将有能力寻找掩体" },
    { 12, "隐蔽火力",
        "NPC只会在拥有掩体的情况下进行攻击" },
    { 13, "气势汹汹",
        "对你抱有仇恨的态度" },
    { 21, "徒步追击目标",
        "如果两人都步行，而目标正在逃跑，NPC将能够追逐目标" },
    { 24, "使用近距离射击速率",
        "允许NPC使用基于邻近度的射速（在较近距离处增加射速）" },
    { 27, "完美的准确性",
        "他们射击将百分百命中" },
    { 41, "可以入侵车辆",
        "若目标在车里，当他们射击时，距离足够可将目标从车里拽出来" },
    { 42, "侧翼进攻",
        "他们可以从不同方向位移攻击" },
    { 46, "赤手空拳",
        "允许NPC没有武器时仍然具有攻击目标的主动性" },
    { 52, "使用车辆攻击",
        "允许NPC撞击目标，仅使用于驾驶位的NPC" },
    { 53, "使用车辆武器攻击(武装车辆)",
        "若车辆具有自带武器，则允许驾驶位的NPC优先使用车辆的武器攻击目标" },
    { 54, "始终装备最佳武器",
        "他们的武器为上等" },
    { 86, "允许飞机攻击",
        "允许NPC在飞机中攻击玩家，利用飞机的武器系统" },
}

menu.toggle(Nearby_Ped_Combat_Attributes, "全部开/关", {}, "", function(toggle)
    for i, the_menu in pairs(nearby_ped_combat_attr.menus) do
        menu.set_value(the_menu, toggle)
    end
end)

for _, data in pairs(ped_combat_attr_list) do
    local id = data[1]
    local name = data[2]
    local help_text = data[3]

    nearby_ped_combat_attr.toggles[id] = false

    nearby_ped_combat_attr.menus[id] = menu.toggle(Nearby_Ped_Combat_Attributes, name, {}, help_text,
        function(toggle)
            nearby_ped_combat_attr.toggles[id] = toggle
        end)
end



----- 作战能力 开关 -----
local Nearby_Ped_Combat_toggles = menu.list(Nearby_Ped_Combat_options, "属性与能力开关", {}, "取消勾选代表不对这一项进行修改")

nearby_ped_combat.settings = {
    health = true,
    see_range = true,
    peripheral_range = true,
    peripheral_angle = true,
    combat_movement = true,
    target_loss_response = true,
}

menu.toggle(Nearby_Ped_Combat_toggles, "生命", {}, "", function(toggle)
    nearby_ped_combat.settings.health = toggle
end, true)
menu.toggle(Nearby_Ped_Combat_toggles, "视力范围", {}, "", function(toggle)
    nearby_ped_combat.settings.see_range = toggle
end, true)
menu.toggle(Nearby_Ped_Combat_toggles, "锥形视野范围", {}, "", function(toggle)
    nearby_ped_combat.settings.peripheral_range = toggle
end, true)
menu.toggle(Nearby_Ped_Combat_toggles, "侦查视野角度", {}, "", function(toggle)
    nearby_ped_combat.settings.peripheral_angle = toggle
end, true)
menu.toggle(Nearby_Ped_Combat_toggles, "作战走位", {}, "", function(toggle)
    nearby_ped_combat.settings.combat_movement = toggle
end, true)
menu.toggle(Nearby_Ped_Combat_toggles, "失去目标时反应", {}, "", function(toggle)
    nearby_ped_combat.settings.target_loss_response = toggle
end, true)


local Nearby_Ped_Combat_toggles_Attr = menu.list(Nearby_Ped_Combat_toggles, "作战属性", {}, "")

nearby_ped_combat_attr.setting = {
    toggles = {},
    menus = {},
}

menu.toggle(Nearby_Ped_Combat_toggles_Attr, "全部开/关", {}, "", function(toggle)
    for i, the_menu in pairs(nearby_ped_combat_attr.setting.menus) do
        menu.set_value(the_menu, toggle)
    end
end, true)

for _, data in pairs(ped_combat_attr_list) do
    local id = data[1]
    local name = data[2]

    nearby_ped_combat_attr.setting.toggles[id] = true

    nearby_ped_combat_attr.setting.menus[id] = menu.toggle(Nearby_Ped_Combat_toggles_Attr, name, {}, "",
        function(toggle)
            nearby_ped_combat_attr.setting.toggles[id] = toggle
        end, true)
end



---------
menu.divider(Nearby_Ped_Combat_options, "默认设置为弱化NPC")

local neayby_ped_combat_all_setting = {
    only_combat = true,
    request_control = false
}
menu.toggle(Nearby_Ped_Combat_options, "只作用于敌对NPC", {}, "", function(toggle)
    neayby_ped_combat_all_setting.only_combat = toggle
end, true)
menu.toggle(Nearby_Ped_Combat_options, "请求控制", {}, "如果有其它玩家", function(toggle)
    neayby_ped_combat_all_setting.request_control = toggle
end)

local function NearbyPed_Combat(is_once)
    local mission, nonmission = 0, 0

    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if IS_PED_PLAYER(ped) then
        elseif PED.IS_PED_DEAD_OR_DYING(ped) or ENTITY.IS_ENTITY_DEAD(ped) then
        elseif neayby_ped_combat_all_setting.only_combat and not PED.IS_PED_IN_COMBAT(ped, players.user_ped()) then
        else
            if neayby_ped_combat_all_setting.request_control then
                RequestControl(ped)
            end

            if nearby_ped_combat.settings.health then
                ENTITY.SET_ENTITY_HEALTH(ped, nearby_ped_combat.health)
            end

            PED.SET_PED_ARMOUR(ped, nearby_ped_combat.armour)

            if nearby_ped_combat.settings.see_range then
                PED.SET_PED_SEEING_RANGE(ped, nearby_ped_combat.see_range)
            end

            PED.SET_PED_HEARING_RANGE(ped, nearby_ped_combat.hear_range)
            PED.SET_PED_ID_RANGE(ped, nearby_ped_combat.id_range)

            if nearby_ped_combat.settings.peripheral_range then
                PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(ped, nearby_ped_combat.peripheral_range)
            end

            PED.SET_PED_HIGHLY_PERCEPTIVE(ped, nearby_ped_combat.highly_perceptive)

            if nearby_ped_combat.settings.peripheral_angle then
                PED.SET_PED_VISUAL_FIELD_MIN_ANGLE(ped, nearby_ped_combat.peripheral_angle)
                PED.SET_PED_VISUAL_FIELD_MAX_ANGLE(ped, nearby_ped_combat.peripheral_angle)
                PED.SET_PED_VISUAL_FIELD_MIN_ELEVATION_ANGLE(ped, nearby_ped_combat.peripheral_angle)
                PED.SET_PED_VISUAL_FIELD_MAX_ELEVATION_ANGLE(ped, nearby_ped_combat.peripheral_angle)
                PED.SET_PED_VISUAL_FIELD_CENTER_ANGLE(ped, nearby_ped_combat.peripheral_angle)
            end

            PED.SET_PED_ACCURACY(ped, nearby_ped_combat.accuracy)
            PED.SET_PED_SHOOT_RATE(ped, nearby_ped_combat.shoot_rate)
            PED.SET_PED_COMBAT_ABILITY(ped, nearby_ped_combat.combat_ability)
            PED.SET_PED_COMBAT_RANGE(ped, nearby_ped_combat.combat_range)

            if nearby_ped_combat.settings.combat_movement then
                PED.SET_PED_COMBAT_MOVEMENT(ped, nearby_ped_combat.combat_movement)
            end

            if nearby_ped_combat.settings.target_loss_response then
                PED.SET_PED_TARGET_LOSS_RESPONSE(ped, nearby_ped_combat.target_loss_response)
            end

            PED.SET_PED_DIES_WHEN_INJURED(ped, nearby_ped_combat.dies_when_injured)

            if nearby_ped_combat.remove_defensive_area then
                PED.REMOVE_PED_DEFENSIVE_AREA(ped, false)
            end

            if nearby_ped_combat.stop_drop_fire then
                PED.STOP_PED_WEAPON_FIRING_WHEN_DROPPED(ped)
            end

            if nearby_ped_combat.disable_injured_behaviour then
                WIRI_PED.DISABLE_PED_INJURED_ON_GROUND_BEHAVIOUR(ped)
            end

            for id, is_enable in pairs(nearby_ped_combat_attr.setting.toggles) do
                if is_enable then
                    local toggle = nearby_ped_combat_attr.toggles[id]
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, id, is)
                end
            end

            ----------
            if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped) then
                mission = mission + 1
            else
                nonmission = nonmission + 1
            end
        end
    end

    if is_once then
        util.toast("完成！\n任务NPC数量: " .. mission .. "\n非任务NPC数量: " .. nonmission)
    end
end

menu.action(Nearby_Ped_Combat_options, "设定 (仅一次)", {}, "", function()
    NearbyPed_Combat(true)
end)
menu.toggle_loop(Nearby_Ped_Combat_options, "设定 (保持开启)", {}, "", function()
    NearbyPed_Combat()
end)





----------------------------
-- 附近NPC 取消NPC执行的任务
----------------------------
local Nearby_Ped_ClearTask_options = menu.list(Nearby_Ped_options, "NPC状态", {}, "乱用会导致任务无法进行")

local nearby_ped_cleartask = {
    exclude_mission = false,
    only_combat = true,
    clear_task = false,
    ignore_events = true
}

menu.toggle(Nearby_Ped_ClearTask_options, "排除任务实体", {}, "", function(toggle)
    nearby_ped_cleartask.exclude_mission = toggle
end)
menu.toggle(Nearby_Ped_ClearTask_options, "只用于敌对NPC", {}, "", function(toggle)
    nearby_ped_cleartask.only_combat = toggle
end, true)
menu.toggle(Nearby_Ped_ClearTask_options, "取消执行的状态", {}, "", function(toggle)
    nearby_ped_cleartask.clear_task = toggle
end)
menu.toggle(Nearby_Ped_ClearTask_options, "忽略临时事件", {}, "开枪射击之类的事件",
    function(toggle)
        nearby_ped_cleartask.ignore_events = toggle
    end, true)

local function NearbyPed_ClearTask()
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if IS_PED_PLAYER(ped) then
        elseif PED.IS_PED_DEAD_OR_DYING(ped) or ENTITY.IS_ENTITY_DEAD(ped) then
        elseif nearby_ped_cleartask.exclude_mission and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped) then
        elseif nearby_ped_cleartask.only_combat and not PED.IS_PED_IN_COMBAT(ped, players.user_ped()) then
        else
            if nearby_ped_cleartask.clear_task then
                clear_ped_all_tasks(ped)
            end
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, nearby_ped_cleartask.ignore_events)
            TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, nearby_ped_cleartask.ignore_events)
        end
    end
end

menu.action(Nearby_Ped_ClearTask_options, "立刻清除NPC的状态", {}, "", function()
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if IS_PED_PLAYER(ped) then
        elseif PED.IS_PED_DEAD_OR_DYING(ped) or ENTITY.IS_ENTITY_DEAD(ped) then
        elseif nearby_ped_cleartask.exclude_mission and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped) then
        elseif nearby_ped_cleartask.only_combat and not PED.IS_PED_IN_COMBAT(ped, players.user_ped()) then
        else
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
        end
    end
    util.toast("完成！")
end)
menu.action(Nearby_Ped_ClearTask_options, "设定 (仅一次)", {}, "", function()
    NearbyPed_ClearTask()
end)
menu.toggle_loop(Nearby_Ped_ClearTask_options, "设定 (保持开启)", {}, "", function()
    NearbyPed_ClearTask()
end)




---------------------------
---------- 任务实体 ---------
---------------------------

--local Mission_Entity = menu.list(adminworld, "管理任务实体", {}, "")

menu.action(adminworld, "传送到 电脑", { "tp_desk" }, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(521)
    if not HUD.DOES_BLIP_EXIST(blip) then
        util.toast("No PC Found")
    else
        local coords = HUD.GET_BLIP_COORDS(blip)
        TELEPORT(coords.x - 1.0, coords.y + 1.0, coords.z)
    end
end)

-------- 办公室拉货 --------
local Special_Cargo = menu.list(adminworld, "CEO拉货", {}, "")

local Special_Cargo_Cooldown = menu.list(Special_Cargo, "移除冷却时间", {}, "切换战局后会失效，需要重新操作")
menu.divider(Special_Cargo_Cooldown, "购买和出售")
menu.toggle(Special_Cargo_Cooldown, "特种货物", { "coolspecial" }, "", function(toggle)
    Globals.RemoveCooldown.SpecialCargo(toggle)
end)
menu.toggle(Special_Cargo_Cooldown, "载具货物", { "coolveh" }, "", function(toggle)
    Globals.RemoveCooldown.VehicleCargo(toggle)
end)

menu.action(Special_Cargo, "传送到 特种货物", { "tp_cargo" }, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(478)
    if not HUD.DOES_BLIP_EXIST(blip) then
        util.toast("No Cargo Found")
    else
        local coords = HUD.GET_BLIP_COORDS(blip)
        TELEPORT(coords.x, coords.y, coords.z + 1.0)
    end
end)
menu.action(Special_Cargo, "特种货物 传送到我", { "tp_me_cargo" }, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(478)
    if not HUD.DOES_BLIP_EXIST(blip) then
        util.toast("No Cargo Found")
    else
        local ent = HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(blip)
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            SET_ENTITY_HEAD_TO_ENTITY(ent, players.user_ped())
            TP_TO_ME(ent, 0.0, 2.0, -0.5)

            if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
                TP_INTO_VEHICLE(ent, "delete", "delete")
            end
        else
            util.toast("No Entity, Can't Teleport To Me")
        end
    end
end)
menu.action(Special_Cargo, "散货板条箱 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("pickup", true, -265116550, 1688540826, -1143129136) --货物
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, -0.5)
        end
    else
        util.toast("Not Found")
    end
end)
menu.action(Special_Cargo, "要追踪的车 传送到我", {}, "Trackify追踪车", function()
    local entity_list = get_entities_by_hash("object", true, -1322183878, -2022916910) --车里的货物
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            if ENTITY.IS_ENTITY_ATTACHED(ent) then
                local attached_ent = ENTITY.GET_ENTITY_ATTACHED_TO(ent)
                if ENTITY.IS_ENTITY_A_VEHICLE(attached_ent) then
                    TP_VEHICLE_TO_ME(attached_ent, "delete", "delete")
                end
            end
        end
    else
        util.toast("Not Found")
    end
end)

--Model Hash: -1235210928(object) 卢佩 水下 要炸的货箱
menu.action(Special_Cargo, "卢佩：水下货箱 获取", {}, "先获取到才能传送", function()
    --货箱里面 要拾取的包裹
    local water_cargo_hash_list = { 388143302, -36934887, 319657375, 924741338, -1249748547 }
    --拾取包裹 实体list
    water_cargo_ent = {}
    local num = 0
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
            if isInTable(water_cargo_hash_list, EntityHash) then
                num = num + 1
                table.insert(water_cargo_ent, ent)
            end
        end
    end
    --util.toast("Number: " .. num)
    menu.set_max_value(menu_Water_Cargo_TP, num)
end)
menu_Water_Cargo_TP = menu.click_slider(Special_Cargo, "卢佩：水下货箱 传送到那里", {}, "",
    0, 0, 0, 1, function(value)
        if value > 0 then
            local ent = water_cargo_ent[value]
            if ENTITY.DOES_ENTITY_EXIST(ent) then
                if ENTITY.IS_ENTITY_ATTACHED(ent) then
                    local attached_ent = ENTITY.GET_ENTITY_ATTACHED_TO(ent)
                    TP_TO_ENTITY(attached_ent, 0.0, -2.5, 0.0)
                    SET_ENTITY_HEAD_TO_ENTITY(players.user_ped(), attached_ent)
                end
            else
                util.toast("实体不存在")
            end
        end
    end)

menu.action(Special_Cargo, "传送到 仓库助理", {}, "让他去拉货", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(480)
    if not HUD.DOES_BLIP_EXIST(blip) then
        util.toast("Not Found")
    else
        local coords = HUD.GET_BLIP_COORDS(blip)
        TELEPORT(coords.x - 1.0, coords.y, coords.z)
    end
end)

menu.divider(Special_Cargo, "载具货物")
menu.action(Special_Cargo, "传送到 载具货物", { "tp_vehcargo" }, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(523)
    if not HUD.DOES_BLIP_EXIST(blip) then
        util.toast("No Vehicle Cargo Found")
    else
        local coords = HUD.GET_BLIP_COORDS(blip)
        TELEPORT(coords.x, coords.y, coords.z + 1.0)
    end
end)
menu.action(Special_Cargo, "载具货物 传送到我", { "tpme_vehcargo" }, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(523)
    if not HUD.DOES_BLIP_EXIST(blip) then
        util.toast("No Vehicle Cargo Found")
    else
        local ent = HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(blip)
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            SET_ENTITY_HEAD_TO_ENTITY(ent, players.user_ped())
            TP_TO_ME(ent, 0.0, 1.0, -0.5)

            if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
                TP_INTO_VEHICLE(ent, "", "delete")
            end
        else
            util.toast("No Entity, Can't Teleport To Me")
        end
    end
end)
local Vehicle_Cargo_ListAction
Vehicle_Cargo_ListAction = menu.list_action(Special_Cargo, "任务载具列表", {}, "点击目标载具即可传送到我",
    { [-1] = { "刷新列表" } }, function(value)
        if value == -1 then
            local list_item = { [-1] = { "刷新列表" } }
            for k, veh in pairs(entities.get_all_vehicles_as_handles()) do
                if ENTITY.IS_ENTITY_A_MISSION_ENTITY(veh) then
                    local model_hash = ENTITY.GET_ENTITY_MODEL(veh)
                    local display_name = util.get_label_text(VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(model_hash))

                    list_item[veh] = display_name
                end
            end
            menu.set_list_action_options(Vehicle_Cargo_ListAction, list_item)
        else
            if ENTITY.DOES_ENTITY_EXIST(value) then
                TP_VEHICLE_TO_ME(value, "", "delete")
            end
        end
    end)



-------- 地堡拉货 --------
local Bunker = menu.list(adminworld, "地堡拉货", {}, "")

menu.action(Bunker, "传送到 原材料", { "tp_bsupplies" }, "", function()
    local blip1 = HUD.GET_NEXT_BLIP_INFO_ID(556)
    local blip2 = HUD.GET_NEXT_BLIP_INFO_ID(561)
    local blip3 = HUD.GET_NEXT_BLIP_INFO_ID(477)

    if HUD.DOES_BLIP_EXIST(blip1) then
        local coords = HUD.GET_BLIP_COORDS(blip1)
        TELEPORT(coords.x, coords.y + 2.0, coords.z + 1.0)
    elseif HUD.DOES_BLIP_EXIST(blip2) then
        local coords = HUD.GET_BLIP_COORDS(blip2)
        TELEPORT(coords.x, coords.y, coords.z + 1.0)
    elseif HUD.DOES_BLIP_EXIST(blip3) then
        local coords = HUD.GET_BLIP_COORDS(blip3)
        TELEPORT(coords.x, coords.y, coords.z + 1.0)
    else
        util.toast("No Bunker Supplies Found")
    end
end)
menu.action(Bunker, "原材料 传送到我", { "tp_me_bsupplies" }, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(556)
    if not HUD.DOES_BLIP_EXIST(blip) then
        local entity_list = get_entities_by_hash("pickup", true, -955159266)
        if next(entity_list) ~= nil then
            for k, ent in pairs(entity_list) do
                TP_TO_ME(ent, 0.0, 2.0, 0.0)
            end
        else
            util.toast("No Bunker Supplies Found")
        end
    else
        local ent = HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(blip)
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            SET_ENTITY_HEAD_TO_ENTITY(ent, players.user_ped())
            TP_TO_ME(ent, 0.0, 2.0, 0.0)
            --vehicle
            if HUD.GET_BLIP_INFO_ID_TYPE(blip) == 1 then
                TP_INTO_VEHICLE(ent, "delete", "delete")
            end
        else
            util.toast("No Entity, Can't Teleport To Me")
        end
    end
end)
menu.action(Bunker, "消灭对手行动单位：箱子 全部爆炸", {}, "", function()
    local entity_list = get_entities_by_hash("object", true, -986153641)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            local pos = ENTITY.GET_ENTITY_COORDS(ent)
            add_owned_explosion(players.user_ped(), pos)
        end
    else
        util.toast("Not Found")
    end
end)
menu.action(Bunker, "消灭对手行动单位：载具 全部爆炸", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, 788747387, -1050465301, -1860900134)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            local pos = ENTITY.GET_ENTITY_COORDS(ent)
            add_owned_explosion(players.user_ped(), pos)
        end
    else
        util.toast("Not Found")
    end
end)
menu.action(Bunker, "摧毁卡车 全部爆炸", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, 904750859)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            local pos = ENTITY.GET_ENTITY_COORDS(ent)
            add_owned_explosion(players.user_ped(), pos)
        end
    else
        util.toast("Not Found")
    end
end)
menu.action(Bunker, "骇入飞机 传送到我", {}, "传送到头上并冻结", function()
    local entity_list = get_entities_by_hash("vehicle", true, -32878452)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            ENTITY.FREEZE_ENTITY_POSITION(ent, true)
            TP_TO_ME(ent, 0.0, 0.0, 10.0)
        end
    else
        util.toast("Not Found")
    end
end)
menu.action(Bunker, "长鳍追飞机：掉落货物 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("object", true, 91541528)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, 1.0)
        end
    else
        util.toast("Not Found")
    end
end)
menu.action(Bunker, "长鳍追飞机：炸掉长鳍", {},
    "不再等飞机慢慢地投放货物", function()
        local entity_list = get_entities_by_hash("vehicle", true, 1861786828) --长鳍
        if next(entity_list) ~= nil then
            for k, ent in pairs(entity_list) do
                ENTITY.SET_ENTITY_INVINCIBLE(ent, false)
                local pos = ENTITY.GET_ENTITY_COORDS(ent)
                add_owned_explosion(players.user_ped(), pos)
            end
        else
            util.toast("Not Found")
        end
    end)



-------- 佩里科岛抢劫 --------
local Cayo_Perico = menu.list(adminworld, "佩里科岛抢劫", {}, "")

menu.action(Cayo_Perico, "传送到虎鲸 任务面板", { "tp_in_kosatka" },
    "需要提前叫出虎鲸", function()
        local blip = HUD.GET_NEXT_BLIP_INFO_ID(760)
        if not HUD.DOES_BLIP_EXIST(blip) then
            util.toast("未在地图上找到虎鲸")
        else
            TELEPORT(1561.2369, 385.8771, -49.689915, 175.0001)
        end
    end)
menu.action(Cayo_Perico, "传送到虎鲸 外面甲板", { "tp_out_kosatka" },
    "需要提前叫出虎鲸", function()
        local blip = HUD.GET_NEXT_BLIP_INFO_ID(760)
        if not HUD.DOES_BLIP_EXIST(blip) then
            util.toast("未在地图上找到虎鲸")
        else
            local pos = HUD.GET_BLIP_COORDS(blip)
            local heading = HUD.GET_BLIP_ROTATION(blip)
            TELEPORT(pos.x - 5.25, pos.y + 30.84, pos.z + 3, heading + 180)
        end
    end)

menu.divider(Cayo_Perico, "侦查")
menu.action(Cayo_Perico, "传送进 美杜莎", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, 1077420264)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            VEHICLE.SET_VEHICLE_ENGINE_ON(ent, true, true, false)
            ENTITY.SET_ENTITY_INVINCIBLE(ent, true)
            PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), ent, -1)
        end
    end
end)
menu.action(Cayo_Perico, "传送到 信号塔", {}, "", function()
    local entity_list = get_entities_by_hash("object", true, 1981815996)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ENTITY(ent, 0.0, -0.5, 0.5)
            SET_ENTITY_HEAD_TO_ENTITY(players.user_ped(), ent)
        end
    end
end)

menu.divider(Cayo_Perico, "前置")
menu.action(Cayo_Perico, "长崎 传送到我并坐进尖锥魅影", {},
    "生成并坐进尖锥魅影 传送长崎到后面", function()
        local entity_list = get_entities_by_hash("vehicle", true, -1352468814)
        if next(entity_list) ~= nil then
            local modelHash = util.joaat("phantom2")
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 2.0, 0.0)
            local veh = Create_Network_Vehicle(modelHash, coords.x, coords.y, coords.z, PLAYER_HEADING())

            TP_INTO_VEHICLE(veh)

            for k, ent in pairs(entity_list) do
                TP_TO_ME(ent, 0.0, -10.0, 0.0)
                SET_ENTITY_HEAD_TO_ENTITY(ent, players.user_ped())
            end
        end
    end)
menu.action(Cayo_Perico, "传送到 保险箱密码", {}, "赌场别墅内的保安队长", function()
    local entity_list = get_entities_by_hash("ped", true, -1109568186)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ENTITY(ent, 0.0, 0.0, 0.5)
        end
    end
end)
menu.action(Cayo_Perico, "等离子切割枪包裹 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("pickup", true, -802406134)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent)
        end
    end
end)
menu.action(Cayo_Perico, "指纹复制器 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("pickup", true, 1506325614)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent)
        end
    end
end)
menu.action(Cayo_Perico, "传送到 割据", {}, "", function()
    local entity_list = get_entities_by_hash("pickup", true, 1871441709)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ENTITY(ent, 0.0, 1.5, 0.0)
            SET_ENTITY_HEAD_TO_ENTITY(players.user_ped(), ent, -180)
        end
    end
end)
menu.action(Cayo_Perico, "武器 炸掉女武神", {}, "不再等他慢慢的飞", function()
    local entity_list = get_entities_by_hash("vehicle", true, -1600252419)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            local pos = ENTITY.GET_ENTITY_COORDS(ent)
            add_owned_explosion(players.user_ped(), pos)
        end
    end
end)
menu.action(Cayo_Perico, "武器 阻挡女武神刷新点", {}, "避免出现跟踪女武神的任务", function()
    local hash = util.joaat("kosatka")
    local data = {
        { coords = v3(526.8517456, -3188.888183, 38.08681106), heading = 0.1857338994 },
        { coords = v3(494.942657, -3189.610351, 35.71050643),  heading = 0.90858072 },
        { coords = v3(557.7895507, -3190.794433, 35.77930831), heading = 359.572265625 },
    }

    request_model(hash)
    for k, v in pairs(data) do
        local ent = entities.create_vehicle(hash, v.coords, v.heading)
        VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(ent, 5.0)
        ENTITY.FREEZE_ENTITY_POSITION(ent, true)
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
    util.toast("完成")
end)

--- 终章 ---
local Cayo_Perico_Final = menu.list(Cayo_Perico, "终章", {}, "")

menu.divider(Cayo_Perico_Final, "豪宅外")
menu.action(Cayo_Perico_Final, "信号塔 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("object", false, 1981815996)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            RequestControl(ent)
            TP_TO_ME(ent, 0.0, 2.0, -1.0)
            SET_ENTITY_HEAD_TO_ENTITY(ent, players.user_ped())
        end
    end
end)
menu.action(Cayo_Perico_Final, "发电站 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("object", false, 1650252819)
    if next(entity_list) ~= nil then
        local x = 0.0
        for k, ent in pairs(entity_list) do
            RequestControl(ent)
            TP_TO_ME(ent, x, 2.0, 0.5)
            SET_ENTITY_HEAD_TO_ENTITY(ent, players.user_ped())
            x = x + 1.5
        end
    end
end)
menu.action(Cayo_Perico_Final, "保安服 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("object", false, -1141961823)
    if next(entity_list) ~= nil then
        local x = 0.0
        for k, ent in pairs(entity_list) do
            RequestControl(ent)
            TP_TO_ME(ent, x, 2.0, -0.5)
            x = x + 1.0
        end
    end
end)
menu.action(Cayo_Perico_Final, "螺旋切割器 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("pickup", false, -710382954)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            RequestControl(ent)
            TP_TO_ME(ent, 0.0, 2.0, -0.5)
        end
    end
end)
menu.action(Cayo_Perico_Final, "抓钩 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("pickup", false, -1789904450)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            RequestControl(ent)
            TP_TO_ME(ent, 0.0, 2.0, -0.5)
        end
    end
end)
menu.action(Cayo_Perico_Final, "运货卡车 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, 2014313426)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            RequestControl(ent)
            TP_VEHICLE_TO_ME(ent, "", "delete")
        end
    end
end)

menu.divider(Cayo_Perico_Final, "豪宅内")

local perico_gold_vault_menu
local perico_gold_vault_ent = {} --黄金 实体list
menu.action(Cayo_Perico_Final, "获取豪宅内黄金数量", {}, "先获取黄金数量才能传送", function()
    perico_gold_vault_ent = {}
    local num = 0
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local Hash = ENTITY.GET_ENTITY_MODEL(ent)
            if Hash == -180074230 then
                num = num + 1
                table.insert(perico_gold_vault_ent, ent)
            end
        end
    end
    util.toast("黄金数量: " .. num)
    menu.set_max_value(perico_gold_vault_menu, num)
end)
perico_gold_vault_menu = menu.click_slider(Cayo_Perico_Final, "传送到 黄金", {}, "",
    0, 0, 0, 1, function(value)
        if value > 0 then
            local ent = perico_gold_vault_ent[value]
            if ENTITY.DOES_ENTITY_EXIST(ent) then
                TP_TO_ENTITY(ent, 0.0, -1.0, 0.0)
                SET_ENTITY_HEAD_TO_ENTITY(players.user_ped(), ent)
            else
                util.toast("实体不存在")
            end
        end
    end)
menu.action(Cayo_Perico_Final, "干掉主要目标玻璃柜、保险箱", {}, "会在豪宅外生成主要目标包裹",
    function()
        local entity_list = get_entities_by_hash("object", false, -1714533217, 1098122770) --玻璃柜、保险箱
        if next(entity_list) ~= nil then
            for k, ent in pairs(entity_list) do
                RequestControl(ent)
                ENTITY.SET_ENTITY_HEALTH(ent, 0)
            end
        end
    end)
menu.action(Cayo_Perico_Final, "主要目标掉落包裹 传送到我", {}, "携带主要目标者死亡后掉落的包裹",
    function()
        --包裹 Model Hash: -1851147549 (pickup)
        local blip = HUD.GET_NEXT_BLIP_INFO_ID(765)
        if not HUD.DOES_BLIP_EXIST(blip) then
            util.toast("Not Found")
        else
            local ent = HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(blip)
            if ENTITY.DOES_ENTITY_EXIST(ent) then
                RequestControl(ent)
                TP_TO_ME(ent)
            end
        end
    end)
menu.action(Cayo_Perico_Final, "办公室保险箱 传送到我", {}, "保险箱门和里面的现金", function()
    local entity_list = get_entities_by_hash("object", false, 485111592) --保险箱
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            RequestControl(ent)
            TP_TO_ME(ent, -0.5, 1.0, 0.0)
            SET_ENTITY_HEAD_TO_ENTITY(ent, players.user_ped(), 180.0)
        end
    end

    entity_list = get_entities_by_hash("pickup", false, -2143192170) --现金
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            RequestControl(ent)
            TP_TO_ME(ent, 0.0, 1.0, 0.0)
        end
    end
end)



-------- 赌场抢劫 --------
local Diamond_Casino = menu.list(adminworld, "赌场抢劫", {}, "")

menu.divider(Diamond_Casino, "侦查")
menu.action(Diamond_Casino, "保安 传送到我", {}, "会传送到空中然后摔死", function()
    local entity_list = get_entities_by_hash("ped", true, -1094177627)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, 10.0)
            SET_ENTITY_HEAD_TO_ENTITY(ent, players.user_ped())
        end
    end
end)

local casion_invest = {
    num = 5,
    pos = {
        { 1131.7562, 278.7316,  -51.0408 },
        { 1146.7454, 243.3848,  -51.0408 },
        { 1138.2075, 239.8881,  -50.4408 },
        { 1105.9666, 259.99405, -51.0409 },
        { 1120.3631, 226.5128,  -50.0407 },
    },
}
menu.click_slider(Diamond_Casino, "赌场 传送到骇入位置", {}, "进入赌场后再传送",
    1, casion_invest.num, 1, 1, function(value)
        local pos = casion_invest.pos[value]
        TELEPORT(pos[1], pos[2], pos[3])
    end)


menu.divider(Diamond_Casino, "前置")

--- 相同前置 ---
local Diamond_Casino_Preps = menu.list(Diamond_Casino, "相同前置", {}, "")

menu.action(Diamond_Casino_Preps, "武器 传送到我", {}, "失落摩托帮", function()
    local entity_list = get_entities_by_hash("pickup", true, 798951501)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, -0.5)
        end
    end
end)
menu.action(Diamond_Casino_Preps, "武器：车 传送到我", {}, "国安局面包车", function()
    local entity_list = get_entities_by_hash("object", true, 1885839156)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            if ENTITY.IS_ENTITY_ATTACHED(ent) then
                local attached_ent = ENTITY.GET_ENTITY_ATTACHED_TO(ent)
                TP_VEHICLE_TO_ME(attached_ent, "delete", "delete")
            end
        end
    end
end)
menu.action(Diamond_Casino_Preps, "武器：传送进 飞机", {}, "走私犯 水上飞机", function()
    --Model Hash: -1628917549 (pickup) 炸毁飞机掉落的货物
    local entity_list = get_entities_by_hash("vehicle", true, 1043222410)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_INTO_VEHICLE(ent, "delete", "delete")
            ENTITY.SET_ENTITY_INVINCIBLE(ent, true)
        end
    end
end)
menu.action(Diamond_Casino_Preps, "载具：天威 传送到我", {}, "天威 经典版", function()
    local entity_list = get_entities_by_hash("vehicle", true, 931280609)
    if next(entity_list) ~= nil then
        local x = 0
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, x, 2.0, 0.0)
            SET_ENTITY_HEAD_TO_ENTITY(ent, players.user_ped())
            x = x + 2
        end
        TP_INTO_VEHICLE(entity_list[1], "", "delete")
    end
end)
menu.action(Diamond_Casino_Preps, "骇入设备 传送到我", {}, "先踩完黄点再传送", function()
    local entity_list = get_entities_by_hash("pickup", true, -155327337)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, -0.5)
        end
    end
end)
menu.action(Diamond_Casino_Preps, "金库门禁卡：狱警 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("ped", true, 1456041926)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, -0.5)
        end
    end
end)
menu.action(Diamond_Casino_Preps, "金库门禁卡：保安 传送到我", {}, "两个保安会传送到空中然后摔死，需要再补一枪",
    function()
        local entity_list = get_entities_by_hash("ped", true, -1575488699, -1425378987)
        if next(entity_list) ~= nil then
            local x = 0.0
            for k, ent in pairs(entity_list) do
                TP_TO_ME(ent, x, 2.0, 10.0)
                x = x + 3.0
            end
        end
    end)
menu.action(Diamond_Casino_Preps, "巡逻路线：车 传送到我", {}, "在车后备箱里", function()
    local entity_list = get_entities_by_hash("object", true, 1265214509)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            if ENTITY.IS_ENTITY_ATTACHED(ent) then
                local attached_ent = ENTITY.GET_ENTITY_ATTACHED_TO(ent)
                TP_TO_ME(attached_ent, 0.0, 4.0, -0.5)
                SET_ENTITY_HEAD_TO_ENTITY(attached_ent, players.user_ped())
            end
        end
    end
end)
menu.action(Diamond_Casino_Preps, "杜根货物 全部爆炸", {}, "一次性炸不完，多炸几次", function()
    local entity_list = get_entities_by_hash("vehicle", true, -1671539132, 1747439474, 1448677353)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            local pos = ENTITY.GET_ENTITY_COORDS(ent)
            add_owned_explosion(players.user_ped(), pos)
        end
    end
end)
menu.textslider(Diamond_Casino_Preps, "传送到 电钻", {}, "", { "1", "2", "车" }, function(value)
    local entity_list = get_entities_by_hash("pickup", true, -12990308)
    if next(entity_list) ~= nil then
        if value == 1 then
            TP_TO_ENTITY(entity_list[1], 0.0, 0.0, 0.5)
        elseif value == 2 then
            TP_TO_ENTITY(entity_list[2], 0.0, 0.0, 0.5)
        elseif value == 3 then
            local ent = entity_list[1]
            if ENTITY.IS_ENTITY_ATTACHED(ent) then
                local attached_ent = ENTITY.GET_ENTITY_ATTACHED_TO(ent)
                if ENTITY.IS_ENTITY_A_VEHICLE(attached_ent) then
                    TP_INTO_VEHICLE(attached_ent, "delete", "delete")
                end
            end
        end
    end
end)
menu.action(Diamond_Casino_Preps, "二级保安证：传送到 尸体", {}, "医院里的泊车员尸体", function()
    local entity_list = get_entities_by_hash("object", true, 771433594)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ENTITY(ent, -1.0, 0.0, 0.0)
            SET_ENTITY_HEAD_TO_ENTITY(players.user_ped(), ent, -80.0)
        end
    end
end)
menu.action(Diamond_Casino_Preps, "二级保安证：保安证 传送到我", {}, "找到那个NPC后才能传送",
    function()
        local entity_list = get_entities_by_hash("pickup", true, -2018799718)
        if next(entity_list) ~= nil then
            for k, ent in pairs(entity_list) do
                TP_TO_ME(ent)
            end
        end
    end)


--- 隐迹潜踪 ---
local Diamond_Casino_Silent = menu.list(Diamond_Casino, "隐迹潜踪", {}, "")

menu.action(Diamond_Casino_Silent, "无人机零件 传送到我", {},
    "会先炸掉无人机，再传送掉落的零件", function()
        --Model Hash: 1657647215 纳米无人机 (object)
        --Model Hash: -1285013058 无人机炸毁后掉落的零件（pickup）
        local entity_list = get_entities_by_hash("object", true, 1657647215)
        if next(entity_list) ~= nil then
            for k, ent in pairs(entity_list) do
                local pos = ENTITY.GET_ENTITY_COORDS(ent)
                add_owned_explosion(players.user_ped(), pos)
            end
        end
        util.yield(1500)
        entity_list = get_entities_by_hash("pickup", true, -1285013058)
        if next(entity_list) ~= nil then
            for k, ent in pairs(entity_list) do
                TP_TO_ME(ent, 0.0, 2.0, -0.5)
            end
        end
    end)
menu.action(Diamond_Casino_Silent, "金库激光器 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("pickup", true, 1953119208)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, -0.5)
        end
    end
end)
menu.action(Diamond_Casino_Silent, "电磁脉冲：运兵直升机 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, 1621617168)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 0.0, 30.0)
            TP_INTO_VEHICLE(ent)
            ENTITY.SET_ENTITY_INVINCIBLE(ent, true)
            VEHICLE.SET_HELI_BLADES_FULL_SPEED(ent)
        end
    end
end)
menu.action(Diamond_Casino_Silent, "电磁脉冲 传送到直升机挂钩位置", {}, "运兵直升机提前放下吊钩",
    function()
        local entity_list = get_entities_by_hash("object", true, -1541347408)
        if next(entity_list) ~= nil then
            local veh = GET_VEHICLE_PED_IS_IN(players.user_ped())
            if veh ~= 0 and VEHICLE.DOES_CARGOBOB_HAVE_PICK_UP_ROPE(veh) then
                local pos = VEHICLE.GET_ATTACHED_PICK_UP_HOOK_POSITION(veh)
                for k, ent in pairs(entity_list) do
                    pos.z = pos.z + 1.0
                    SET_ENTITY_COORDS(ent, pos)
                end
            end
        end
    end)
menu.action(Diamond_Casino_Silent, "潜行套装 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("pickup", true, -1496506919)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, -0.5)
        end
    end
end)


--- 兵不厌诈 ---
local Diamond_Casino_BigCon = menu.list(Diamond_Casino, "兵不厌诈", {}, "")

menu.action(Diamond_Casino_BigCon, "古倍科技套装 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("pickup", true, 1425667258)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, -0.5)
        end
    end
end)
menu.action(Diamond_Casino_BigCon, "金库钻孔机 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("pickup", true, 415149220)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, -0.5)
        end
    end
end)
menu.action(Diamond_Casino_BigCon, "国安局套装 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("pickup", true, -1713985235)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, -0.5)
        end
    end
end)


--- 气势汹汹 ---
local Diamond_Casino_Aggressive = menu.list(Diamond_Casino, "气势汹汹", {}, "")

menu.action(Diamond_Casino_Aggressive, "热能炸药 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("pickup", true, -2043162923)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, -0.5)
        end
    end
end)
menu.action(Diamond_Casino_Aggressive, "金库炸药 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("pickup", true, -681938663)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, -0.5)
        end
    end
end)
menu.action(Diamond_Casino_Aggressive, "加固防弹衣 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("pickup", true, 1715697304)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, 0.0)
        end
    end
end)
menu.action(Diamond_Casino_Aggressive, "加固防弹衣：潜水套装 传送到我", {}, "人道实验室", function()
    local entity_list = get_entities_by_hash("object", true, 788248216)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, -0.5)
        end
    end
end)


--- 终章 ---
local Diamond_Casino_Final = menu.list(Diamond_Casino, "终章", {}, "")

menu.divider(Diamond_Casino_Final, "赌场内")
menu.action(Diamond_Casino_Final, "传送到 小金库", {}, "", function()
    TELEPORT(2520.8645, -286.30685, -58.723007)
end)

local casino_vault_trolley_menu
local casino_vault_trolley_ent = {} --推车 实体list
menu.action(Diamond_Casino_Final, "获取金库内推车数量", {}, "先获取推车数量才能传送", function()
    casino_vault_trolley_ent = {}
    local num = 0
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local Hash = ENTITY.GET_ENTITY_MODEL(ent)
            if Hash == 412463629 or Hash == 1171655821 or Hash == 1401432049 then
                num = num + 1
                table.insert(casino_vault_trolley_ent, ent)
            end
        end
    end
    util.toast("推车数量: " .. num)
    menu.set_max_value(casino_vault_trolley_menu, num)
end)
casino_vault_trolley_menu = menu.click_slider(Diamond_Casino_Final, "金库内传送到 推车", {}, "",
    0, 0, 0, 1, function(value)
        if value > 0 then
            local ent = casino_vault_trolley_ent[value]
            if ENTITY.DOES_ENTITY_EXIST(ent) then
                TP_TO_ENTITY(ent, 0.0, 0.0, 0.5)
            else
                util.toast("实体不存在")
            end
        end
    end)




-------- 合约 别惹德瑞 --------
local Contract_Dre = menu.list(adminworld, "别惹德瑞", {}, "")

menu.divider(Contract_Dre, "夜生活泄密")
menu.action(Contract_Dre, "夜总会：传送到 录像带", {}, "", function()
    TELEPORT(-1617.9883, -3013.7363, -75.20509, 203.7907)
end)
menu.action(Contract_Dre, "船坞：传送到 船里", {}, "绿色的船", function()
    local entity_list = get_entities_by_hash("vehicle", true, 908897389)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_INTO_VEHICLE(ent)
        end
    end
end)
menu.action(Contract_Dre, "船坞：传送到 证据", {}, "德瑞照片", function()
    local entity_list = get_entities_by_hash("object", true, -1702870637)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ENTITY(ent, 0.0, 0.0, 0.5)
        end
    end
end)
menu.action(Contract_Dre, "夜生活泄密：传送到 抢夺电脑", {}, "", function()
    TELEPORT(944.01764, 7.9015555, 116.1642)
    ENTITY.SET_ENTITY_HEADING(players.user_ped(), 279.8804)
end)

menu.divider(Contract_Dre, "上流社会泄密")
menu.action(Contract_Dre, "乡村俱乐部：炸掉礼车", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, -420911112)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            local pos = ENTITY.GET_ENTITY_COORDS(ent)
            add_owned_explosion(players.user_ped(), pos)
        end
    end
end)
menu.action(Contract_Dre, "乡村俱乐部：门禁 传送到我", {}, "车内NPC", function()
    local entity_list = get_entities_by_hash("ped", true, -912318012)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, 0.0)
        end
    end
end)
menu.action(Contract_Dre, "宾客名单：律师 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("ped", true, 600300561)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, 0.0)
        end
    end
end)
menu.action(Contract_Dre, "上流社会泄密：炸掉直升机", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, 1075432268)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            local pos = ENTITY.GET_ENTITY_COORDS(ent)
            add_owned_explosion(players.user_ped(), pos)
        end
    end
end)
menu.action(Contract_Dre, "上流社会泄密：坐进直升机", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, 1075432268)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), ent, -2)
        end
    end
end)
menu.action(Contract_Dre, "上流社会泄密：干掉飞行员", {}, "快速进入直升机坠落动画",
    function()
        local entity_list = get_entities_by_hash("ped", true, -413447396)
        if next(entity_list) ~= nil then
            for k, ent in pairs(entity_list) do
                entities.delete_by_handle(ent)
            end
        end
    end)

menu.divider(Contract_Dre, "南中心区泄密")
menu.action(Contract_Dre, "强化弗农", {}, "", function()
    local entity_list = get_entities_by_hash("ped", true, -843935326)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            local weaponHash = util.joaat("WEAPON_SPECIALCARBINE")
            WEAPON.GIVE_WEAPON_TO_PED(ent, weaponHash, -1, false, true)
            WEAPON.SET_CURRENT_PED_WEAPON(ent, weaponHash, false)
            increase_ped_combat_ability(ent, true, false)
            increase_ped_combat_attributes(ent)
            util.toast("完成！")
        end
    end
end)
menu.action(Contract_Dre, "南中心区泄密：底盘车 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, -1013450936)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, 0.0)
            SET_ENTITY_HEAD_TO_ENTITY(ent, players.user_ped())
            TP_INTO_VEHICLE(ent, "", "tp")
            ENTITY.SET_ENTITY_HEALTH(ent, 10000)
        end
    end
end)



------- 富兰克林电话任务 -------
local Franklin_Payphone = menu.list(adminworld, "富兰克林电话任务", {}, "")

local Franklin_Payphone_Cooldown = menu.list(Franklin_Payphone, "移除冷却时间", {}, "切换战局后会失效，需要重新操作")
menu.toggle(Franklin_Payphone_Cooldown, "电话暗杀和安保合约", { "agccool" }, "确保在任务开始前启用"
, function(toggle)
    Globals.RemoveCooldown.PayphoneHitAndContract(toggle)
end)
menu.click_slider(Franklin_Payphone_Cooldown, "安保合约刷新时间", { "agcreftime" }, "单位: s\n事务所电脑安保合约刷新时间"
, 0, 3600, 5, 1, function(value)
    SET_INT_GLOBAL(Globals.FIXER_SECURITY_CONTRACT_REFRESH_TIME, value * 1000)
end)

menu.action(Franklin_Payphone, "传送到 电话亭", { "tppayphone" },
    "Teleport to Payphone (must have called Franklin already)", function()
        local blip = HUD.GET_NEXT_BLIP_INFO_ID(817)
        if not HUD.DOES_BLIP_EXIST(blip) then
            util.toast("No Vehicle Found")
        else
            local coords = HUD.GET_BLIP_COORDS(blip)
            TELEPORT(coords.x, coords.y, coords.z + 1.0)
        end
    end)

----- 电话暗杀 -----
local Payphone_Hit = menu.list(Franklin_Payphone, "电话暗杀", {}, "")

menu.divider(Payphone_Hit, "死宅散户")
menu.action(Payphone_Hit, "目标NPC 传送到我", {}, "", function()
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped) then
            local blip = HUD.GET_BLIP_FROM_ENTITY(ped)
            if HUD.DOES_BLIP_EXIST(blip) and HUD.GET_BLIP_SPRITE(blip) == 432 then
                TP_TO_ME(ped, 0.0, 2.0, 0.0)
                WEAPON.REMOVE_ALL_PED_WEAPONS(ped)
                ENTITY.SET_ENTITY_MAX_SPEED(ped, 0.0)

                util.yield(200)
            end
        end
    end
end)

menu.divider(Payphone_Hit, "流行歌星")
menu.action(Payphone_Hit, "目标载具 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, 2038480341)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 5.0, 0.0)
            SET_ENTITY_HEAD_TO_ENTITY(ent, players.user_ped(), 180.0)
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(ent, 0.0)
            for i = 0, 5, 1 do
                VEHICLE.SET_VEHICLE_TYRE_BURST(ent, i, true, 1000.0)
            end
        end
    end
end)
menu.action(Payphone_Hit, "维戈斯帮改装车 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, -1013450936)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_VEHICLE_TO_ME(ent)
        end
    end
end)
menu.action(Payphone_Hit, "卡车车头 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, 569305213, -2137348917)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_VEHICLE_TO_ME(ent)
        end
    end
end)
menu.action(Payphone_Hit, "警车 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, 1912215274)
    if next(entity_list) ~= nil then
        local x = 0.0
        for k, ent in pairs(entity_list) do
            SET_ENTITY_HEAD_TO_ENTITY(ent, players.user_ped())
            TP_TO_ME(ent, x, 1.0, 0.0)
            TP_INTO_VEHICLE(ent)
            x = x + 3.0
        end
    end
end)

menu.divider(Payphone_Hit, "科技企业家")
menu.action(Payphone_Hit, "出租车 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, -956048545)
    if next(entity_list) ~= nil then
        local x = 0.0
        for k, ent in pairs(entity_list) do
            SET_ENTITY_HEAD_TO_ENTITY(ent, players.user_ped())
            TP_TO_ME(ent, x, 1.0, 0.0)
            TP_INTO_VEHICLE(ent)
            x = x + 3.0
        end
    end
end)
menu.action(Payphone_Hit, "目标NPC 传送到我", {}, "按E叫他上车", function()
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped) then
            local blip = HUD.GET_BLIP_FROM_ENTITY(ped)
            if HUD.DOES_BLIP_EXIST(blip) and HUD.GET_BLIP_SPRITE(blip) == 432 then
                TP_TO_ME(ped, 2.0, 0.0, 0.0)
            end
        end
    end
end)

menu.divider(Payphone_Hit, "法官")
menu.action(Payphone_Hit, "传送到 高尔夫球场", {}, "领取高尔夫装备", function()
    TELEPORT(-1368.963, 56.357, 54.101, 278.422)
end)
menu.action(Payphone_Hit, "目标NPC 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("ped", true, 2111372120)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, 0.0)
            ENTITY.SET_ENTITY_MAX_SPEED(ent, 0.0)
        end
    end
end)

menu.divider(Payphone_Hit, "共同创办人")
menu.action(Payphone_Hit, "目标载具 最大速度为0", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, -2033222435)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            ENTITY.SET_ENTITY_MAX_SPEED(ent, 0.0)
            util.toast("完成！")
        end
    end
end)

menu.divider(Payphone_Hit, "工地总裁")
menu.action(Payphone_Hit, "传送到 装备", {}, "", function()
    local entity_list = get_entities_by_hash("object", true, -86518587)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ENTITY(ent, 0.0, -1.0, 1.0)
            SET_ENTITY_HEAD_TO_ENTITY(players.user_ped(), ent)
        end
    end
end)
menu.action(Payphone_Hit, "目标NPC 传送到集装箱附近", {}, "", function()
    local target_ped_list = get_entities_by_hash("ped", true, -973145378)
    if next(target_ped_list) ~= nil then
        for k, ent in pairs(target_ped_list) do
            local entity_list = get_entities_by_hash("object", true, 874602658)
            if next(entity_list) ~= nil then
                local target_object = entity_list[1]
                TP_ENTITY_TO_ENTITY(ent, target_object, 0.0, 0.0, -3.0)
                ENTITY.SET_ENTITY_MAX_SPEED(ent, 0.0)
            end
        end
    end
end)
menu.action(Payphone_Hit, "目标NPC 传送到油罐附近", {}, "", function()
    local target_ped_list = get_entities_by_hash("ped", true, -973145378)
    if next(target_ped_list) ~= nil then
        for k, ent in pairs(target_ped_list) do
            local entity_list = get_entities_by_hash("object", true, -46303329)
            if next(entity_list) ~= nil then
                local target_object = entity_list[1]
                TP_ENTITY_TO_ENTITY(ent, target_object, 2.0, 0.0, 1.0)
                ENTITY.SET_ENTITY_MAX_SPEED(ent, 0.0)
            end
        end
    end
end)
menu.action(Payphone_Hit, "目标NPC 传送到推土机附近", {}, "", function()
    local target_ped_list = get_entities_by_hash("ped", true, -973145378)
    if next(target_ped_list) ~= nil then
        for k, ent in pairs(target_ped_list) do
            local entity_list = get_entities_by_hash("vehicle", true, 1886712733)
            if next(entity_list) ~= nil then
                local target_object = 0
                for _, obj in pairs(entity_list) do
                    local ped = GET_PED_IN_VEHICLE_SEAT(obj, -1)
                    if ped and not IS_PED_PLAYER(ped) then
                        target_object = obj
                    end
                end
                if ENTITY.DOES_ENTITY_EXIST(target_object) then
                    TP_ENTITY_TO_ENTITY(ent, target_object, 0.0, 6.0, 1.0)
                    ENTITY.SET_ENTITY_MAX_SPEED(ent, 0.0)
                end
            end
        end
    end
end)



----- 安保合约 -----
local Security_Contract = menu.list(Franklin_Payphone, "安保合约", {}, "")

menu.divider(Security_Contract, "回收贵重物品")
menu.action(Security_Contract, "传送到 保险箱", {}, "", function()
    local entity_list = get_entities_by_hash("object", true, -798293264)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ENTITY(ent, 0.0, -0.5, 0.0)
            SET_ENTITY_HEAD_TO_ENTITY(players.user_ped(), ent)
        end
    end
end)
menu.action(Security_Contract, "传送到 保险箱密码", {}, "", function()
    local entity_list = get_entities_by_hash("object", true, 367638847)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ENTITY(ent, 0.0, 0.0, 0.5)
        end
    end
end)

menu.divider(Security_Contract, "救援行动")
menu.action(Security_Contract, "传送到 客户", {}, "", function()
    local entity_list = get_entities_by_hash("ped", true, -2076336881, -1589423867, 826475330, 2093736314, -1109568186)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            ENTITY.SET_ENTITY_INVINCIBLE(ent, true)
            ENTITY.SET_ENTITY_PROOFS(ent, true, true, true, true, true, true, true, true)

            TP_TO_ENTITY(ent, 0.0, 0.5, 0.0)
        end
    end
end)

menu.divider(Security_Contract, "载具回收")
menu.action(Security_Contract, "机库：传送到 载具位置", {}, "", function()
    TELEPORT(-1267.28808, -3017.8591, -47.2282, 9.00279)
end)
menu.action(Security_Contract, "机库：传送到 门锁位置", {}, "", function()
    TELEPORT(-1249.1301, -2979.6404, -48.49219, 269.879)
end)
menu.action(Security_Contract, "人道实验室：传送进 厢形车", {}, "人道实验室 失窃动物",
    function()
        local entity_list = get_entities_by_hash("object", true, 485150676)
        if next(entity_list) ~= nil then
            for k, ent in pairs(entity_list) do
                if ENTITY.IS_ENTITY_ATTACHED(ent) then
                    local attached_ent = ENTITY.GET_ENTITY_ATTACHED_TO(ent)
                    if ENTITY.IS_ENTITY_A_VEHICLE(attached_ent) then
                        TP_INTO_VEHICLE(attached_ent, "delete")
                    end
                end
            end
        end
    end)

menu.divider(Security_Contract, "变现资产")
local Security_Contract_RealizeAssets = {
    -- { { Coords }, Heading }
    car_destination = {
        -- 亚美尼亚帮
        { { -1105.5, -2011.2987, 12.7356 },    120.9303 },
        { { 1713.7562, -1561.0374, 112.1963 }, 72.7691 },
        { { -323.1641, -1410.3094, 30.3902 },  356.4996 },
        -- 梅利威瑟
        { { 850.0665, -2288.5673, 30.1085 },   173.7060 },
        { { 2854.8935, 1515.2998, 24.3381 },   165.2636 },
    },
    bike_destination = {
        -- 失落摩托帮
        { { 1125.8688, -458.5883, 65.8389 }, 349.5725 },
        { { 823.8280, -124.1025, 79.7727 },  59.5104 },
        { { 499.6284, -575.4199, 24.2311 },  27.1227 },
        -- 狗仔队
        { { -668.4118, -892.4926, 24.0101 }, 90.7521 },
        { { 573.7885, 119.1105, 97.5525 },   295.3565 },
        { { -90.2728, 210.1023, 95.1710 },   268.919 },
    },
    heli_destination = {
        { { -143.5477, -593.6083, 212.4510 }, 315.3837 },
        { { -913.9626, -377.3649, 138.5876 }, 85.2279 },
    },
}
menu.action(Security_Contract, "传送进 目标载具并加速", {}, "", function()
    for k, ped in pairs(entities.get_all_peds_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped) then
            local blip = HUD.GET_BLIP_FROM_ENTITY(ped)
            if HUD.DOES_BLIP_EXIST(blip) then
                local sprite = HUD.GET_BLIP_SPRITE(blip) -- 255 Car, 64 Heli, 348 Bike
                if sprite == 225 or sprite == 64 or sprite == 348 then
                    local veh = PED.GET_VEHICLE_PED_IS_IN(ped)
                    if veh ~= 0 then
                        if VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(veh) then
                            PED.SET_PED_INTO_VEHICLE(players.user_ped(), veh, -2)

                            VEHICLE.MODIFY_VEHICLE_TOP_SPEED(veh, 500.0)
                            PED.SET_DRIVER_ABILITY(ped, 1.0)
                            PED.SET_DRIVER_AGGRESSIVENESS(ped, 1.0)
                            TASK.SET_DRIVE_TASK_DRIVING_STYLE(ped, 262144)
                        else
                            util.toast("目标载具没有空闲座位")
                        end
                    end
                end
            end
        end
    end
end)
menu.action(Security_Contract, "传送到 目标载具并加速", {}, "传送到目标载具头上并提高驾驶员驾驶技能"
, function()
    for k, ped in pairs(entities.get_all_peds_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped) then
            local blip = HUD.GET_BLIP_FROM_ENTITY(ped)
            if HUD.DOES_BLIP_EXIST(blip) then
                local sprite = HUD.GET_BLIP_SPRITE(blip) -- 255 Car, 64 Heli, 348 Bike
                if sprite == 225 or sprite == 64 or sprite == 348 then
                    local veh = PED.GET_VEHICLE_PED_IS_IN(ped)
                    if veh ~= 0 then
                        TP_TO_ENTITY(veh, 0.0, 0.0, 2.0)
                        PLAYER_HEADING(ENTITY.GET_ENTITY_HEADING(veh))

                        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(veh, 500.0)
                        PED.SET_DRIVER_ABILITY(ped, 1.0)
                        PED.SET_DRIVER_AGGRESSIVENESS(ped, 1.0)
                        TASK.SET_DRIVE_TASK_DRIVING_STYLE(ped, 262144)
                    end
                end
            end
        end
    end
end)
menu.list_action(Security_Contract, "目标汽车 传送到目的地", {}, "", {
    { "亚美尼亚帮 地点1" }, { "亚美尼亚帮 地点2" }, { "亚美尼亚帮 地点3" },
    { "梅利威瑟 地点1" }, { "梅利威瑟 地点2" },
}, function(value)
    local data = Security_Contract_RealizeAssets.car_destination[value]
    local coords = v3(data[1][1], data[1][2], data[1][3])
    local heading = data[2]

    for k, ped in pairs(entities.get_all_peds_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped) then
            local blip = HUD.GET_BLIP_FROM_ENTITY(ped)
            if HUD.DOES_BLIP_EXIST(blip) then
                local sprite = HUD.GET_BLIP_SPRITE(blip) -- 255 Car
                if sprite == 225 then
                    local veh = PED.GET_VEHICLE_PED_IS_IN(ped)
                    if veh ~= 0 then
                        SET_ENTITY_COORDS(veh, coords)
                        ENTITY.SET_ENTITY_HEADING(veh, heading)

                        if not PED.IS_PED_IN_VEHICLE(players.user_ped(), veh, false) then
                            TP_TO_ENTITY(veh, 0.0, 0.0, 2.0)
                            PLAYER_HEADING(ENTITY.GET_ENTITY_HEADING(veh))
                        end
                    end
                end
            end
        end
    end
end)
menu.list_action(Security_Contract, "目标摩托车 传送到目的地", {}, "", {
    { "失落摩托帮 地点1" }, { "失落摩托帮 地点2" }, { "失落摩托帮 地点3" },
    { "狗仔队 地点1" }, { "狗仔队 地点2" }, { "狗仔队 地点3" },
}, function(value)
    local data = Security_Contract_RealizeAssets.bike_destination[value]
    local coords = v3(data[1][1], data[1][2], data[1][3])
    local heading = data[2]

    for k, ped in pairs(entities.get_all_peds_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped) then
            local blip = HUD.GET_BLIP_FROM_ENTITY(ped)
            if HUD.DOES_BLIP_EXIST(blip) then
                local sprite = HUD.GET_BLIP_SPRITE(blip) -- 348 Bike
                if sprite == 348 then
                    local veh = PED.GET_VEHICLE_PED_IS_IN(ped)
                    if veh ~= 0 then
                        SET_ENTITY_COORDS(veh, coords)
                        ENTITY.SET_ENTITY_HEADING(veh, heading)

                        if not PED.IS_PED_IN_VEHICLE(players.user_ped(), veh, false) then
                            TP_TO_ENTITY(veh, 0.0, 0.0, 2.0)
                            PLAYER_HEADING(ENTITY.GET_ENTITY_HEADING(veh))
                        end
                    end
                end
            end
        end
    end
end)
menu.list_action(Security_Contract, "目标直升机 传送到目的地", {}, "", {
    { "地点1" }, { "地点2" }
}, function(value)
    local data = Security_Contract_RealizeAssets.heli_destination[value]
    local coords = v3(data[1][1], data[1][2], data[1][3])
    local heading = data[2]

    for k, ped in pairs(entities.get_all_peds_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped) then
            local blip = HUD.GET_BLIP_FROM_ENTITY(ped)
            if HUD.DOES_BLIP_EXIST(blip) then
                local sprite = HUD.GET_BLIP_SPRITE(blip) -- 64 Heli
                if sprite == 64 then
                    local veh = PED.GET_VEHICLE_PED_IS_IN(ped)
                    if veh ~= 0 then
                        SET_ENTITY_COORDS(veh, coords)
                        ENTITY.SET_ENTITY_HEADING(veh, heading)

                        if not PED.IS_PED_IN_VEHICLE(players.user_ped(), veh, false) then
                            TP_TO_ENTITY(veh, 0.0, 0.0, 2.0)
                            PLAYER_HEADING(ENTITY.GET_ENTITY_HEADING(veh))
                        end
                    end
                end
            end
        end
    end
end)

menu.divider(Security_Contract, "资产保护")
menu.action(Security_Contract, "资产 无敌", {}, "", function()
    local entity_list = get_entities_by_hash("object", true, -1597216682, 1329706303, 1503555850, -534405572)
    if next(entity_list) ~= nil then
        local i = 0
        for k, ent in pairs(entity_list) do
            ENTITY.SET_ENTITY_INVINCIBLE(ent, true)
            ENTITY.SET_ENTITY_PROOFS(ent, true, true, true, true, true, true, true, true)
            i = i + 1
        end
        util.toast("完成！\nNumber: " .. i)
    end
end)
menu.action(Security_Contract, "保安 无敌强化", {}, "", function()
    local entity_list = get_entities_by_hash("ped", true, -1575488699, -634611634)
    if next(entity_list) ~= nil then
        local i = 0
        for k, ent in pairs(entity_list) do
            local weaponHash = util.joaat("WEAPON_SPECIALCARBINE")
            WEAPON.GIVE_WEAPON_TO_PED(ent, weaponHash, -1, false, true)
            WEAPON.SET_CURRENT_PED_WEAPON(ent, weaponHash, false)
            increase_ped_combat_ability(ent, true, false)
            increase_ped_combat_attributes(ent)
            i = i + 1
        end
        util.toast("完成！\nNumber: " .. i)
    end
end)
menu.action(Security_Contract, "毁掉资产 任务失败", {}, "不再等待漫长的10分钟",
    function()
        local entity_list = get_entities_by_hash("object", true, -1597216682, 1329706303, 1503555850, -534405572)
        if next(entity_list) ~= nil then
            local i = 0
            for k, ent in pairs(entity_list) do
                ENTITY.SET_ENTITY_HEALTH(ent, 0)
                i = i + 1
            end
            util.toast("完成！\nNumber: " .. i)
        end
    end)



------- 摩托帮合约 -------
local MC_Business = menu.list(adminworld, "摩托帮合约", {}, "")

menu.action(MC_Business, "传送到 货物", { "tp_mc_product" }, "", function()
    local blip1 = HUD.GET_NEXT_BLIP_INFO_ID(501)
    local blip2 = HUD.GET_NEXT_BLIP_INFO_ID(64)
    local blip3 = HUD.GET_NEXT_BLIP_INFO_ID(427)
    local blip4 = HUD.GET_NEXT_BLIP_INFO_ID(423)

    if HUD.DOES_BLIP_EXIST(blip1) then
        local coords = HUD.GET_BLIP_COORDS(blip1)
        TELEPORT(coords.x, coords.y - 1.5, coords.z) --MC Product
    elseif HUD.DOES_BLIP_EXIST(blip2) then
        local coords = HUD.GET_BLIP_COORDS(blip2)
        TELEPORT(coords.x, coords.y - 1.5, coords.z) --Heli
    elseif HUD.DOES_BLIP_EXIST(blip3) then
        local coords = HUD.GET_BLIP_COORDS(blip3)
        TELEPORT(coords.x, coords.y, coords.z + 1.0) --Boat
    elseif HUD.DOES_BLIP_EXIST(blip4) then
        local coords = HUD.GET_BLIP_COORDS(blip4)
        TELEPORT(coords.x, coords.y + 1.5, coords.z - 1.0) --Plane
    else
        util.toast("No MC Product Found")
    end
end)
menu.action(MC_Business, "屋顶作战：传送到 割据", {}, "", function()
    local entity_list = get_entities_by_hash("object", true, 339736694)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ENTITY(ent, 0.0, -0.8, 0.0)
            SET_ENTITY_HEAD_TO_ENTITY(players.user_ped(), ent)
        end
    end
end)
menu.action(MC_Business, "屋顶作战：传送到 暴君钥匙", {}, "", function()
    local entity_list = get_entities_by_hash("object", true, 2105669131)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ENTITY(ent, 0.0, -0.8, 0.0)
            SET_ENTITY_HEAD_TO_ENTITY(players.user_ped(), ent)
        end
    end
end)
menu.action(MC_Business, "屋顶作战：传送到 货箱", {}, "有暴君的货箱", function()
    local entity_list = get_entities_by_hash("vehicle", true, 884483972)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            if ENTITY.IS_ENTITY_ATTACHED(ent) then
                local attached_ent = ENTITY.GET_ENTITY_ATTACHED_TO(ent)

                TP_TO_ENTITY(attached_ent, 0.0, -2.5, 0.0)
                SET_ENTITY_HEAD_TO_ENTITY(players.user_ped(), attached_ent)

                VEHICLE.SET_VEHICLE_ENGINE_ON(ent, true, true, false)
            end
        end
    end
end)
menu.action(MC_Business, "直捣黄龙：传送到 保险箱", {}, "", function()
    local entity_list = get_entities_by_hash("object", true, 1089807209)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ENTITY(ent, 0.0, -1.0, 0.0)
            SET_ENTITY_HEAD_TO_ENTITY(players.user_ped(), ent)
        end
    end
end)



------- 改装铺合约 -------
local LS_Robbery = menu.list(adminworld, "改装铺合约", {}, "")

menu.divider(LS_Robbery, "联合储蓄")
menu.action(LS_Robbery, "电梯钥匙：传送到 腐败商人", {}, "", function()
    local entity_list = get_entities_by_hash("ped", true, 2093736314)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ENTITY(ent, 0.0, 0.0, 0.5)
        end
    end
end)
menu.action(LS_Robbery, "金库密码：提示 目标载具", {}, "将载具传送到明显位置", function()
    local entity_list = get_entities_by_hash("ped", true, -1868718465)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            local veh = PED.GET_VEHICLE_PED_IS_IN(ent, false)
            SET_ENTITY_COORDS(veh, v3(52.6033, -614.41308, 31.0284))
            ENTITY.SET_ENTITY_HEADING(veh, 247.0814)

            request_ptfx_asset("scr_rcbarry2")
            start_ptfx_on_entity("scr_exp_clown", ent)
        end
    end
end)

menu.divider(LS_Robbery, "大钞交易")
menu.action(LS_Robbery, "追踪设备：传送到 机动作战中心", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, 1502869817)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            if not ENTITY.IS_ENTITY_ATTACHED(ent) then
                TP_TO_ENTITY(ent, 5.0, 0.0, -1.0)
                SET_ENTITY_HEAD_TO_ENTITY(players.user_ped(), ent, 100)
            end
        end
    end
end)
menu.action(LS_Robbery, "病毒软件：黑客 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("ped", true, -2039163396)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 2.0, 10.0)
        end
    end
end)
menu.action(LS_Robbery, "病毒软件：传送到 软件", {}, "", function()
    local entity_list = get_entities_by_hash("pickup", true, 1112175411)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ENTITY(ent, 0.0, 0.0, 0.5)
        end
    end
end)

menu.divider(LS_Robbery, "银行合约")
menu.slider_text(LS_Robbery, "信号干扰器：传送到", {}, "", {
    "A", "B", "C", "D", "E", "F"
}, function(value)
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(534 + value)
    if HUD.DOES_BLIP_EXIST(blip) then
        local coords = HUD.GET_BLIP_COORDS(blip)
        local heading = HUD.GET_BLIP_ROTATION(blip)
        TELEPORT2(coords, heading)
    end
end)

menu.divider(LS_Robbery, "电控单元差事")
menu.action(LS_Robbery, "火车货运清单：传送到 清单", {}, "", function()
    local entity_list = get_entities_by_hash("object", true, -1398142754)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ENTITY(ent, 0.0, 0.0, 0.5)
        end
    end
end)
menu.action(LS_Robbery, "火车货运清单：传送到 切割锯", {}, "", function()
    local entity_list = get_entities_by_hash("pickup", true, 339736694)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ENTITY(ent, 0.0, 0.0, 0.5)
        end
    end
end)

-- menu.divider(LS_Robbery, "监狱合约") -- 卧底 入口

menu.divider(LS_Robbery, "IAA 交易")
menu.action(LS_Robbery, "入口：传送到 图纸", {}, "", function()
    local entity_list = get_entities_by_hash("object", true, 429364207)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ENTITY(ent, 0.0, 0.0, 0.5)
        end
    end
end)

menu.divider(LS_Robbery, "失落摩托帮合约")
menu.action(LS_Robbery, "实验室地点：包裹 传送到我", {}, "", function()
    local entity_list = get_entities_by_hash("pickup", true, -957953964)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 0.0, 0.0)
        end
    end
end)

menu.divider(LS_Robbery, "数据合约")
menu.action(LS_Robbery, "藏身处地点：传送进 直升机", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, 1044954915)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), ent, -2)
        end
    end
end)
menu.action(LS_Robbery, "藏身处地点：传送进 巴拉杰", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, -212993243)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_VEHICLE_TO_ME(ent, "delete", "delete")
        end
    end
end)
menu.action(LS_Robbery, "防御：武器 传送到我", {}, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(784)
    if HUD.DOES_BLIP_EXIST(blip) then
        local ent = HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(blip)
        if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
            TP_VEHICLE_TO_ME(ent, "delete", "delete")
        end
    end
end)




------- 机库拉货 -------
local Air_Freight = menu.list(adminworld, "机库拉货", {}, "")

local Air_Freight_Cooldown = menu.list(Air_Freight, "移除冷却时间", {}, "切换战局后会失效，需要重新操作")
menu.toggle(Air_Freight_Cooldown, "空运货物", { "coolair" }, "", function(toggle)
    Globals.RemoveCooldown.AirFreightCargo(toggle)
end)

menu.action(Air_Freight, "传送到 货物", { "tp_air_product" }, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(568)
    if not HUD.DOES_BLIP_EXIST(blip) then
        util.toast("No Air Product Found")
    else
        local coords = HUD.GET_BLIP_COORDS(blip)
        TELEPORT(coords.x, coords.y, coords.z + 1.0)
    end
end)
menu.action(Air_Freight, "货物 传送到我", { "tp_me_air_product" }, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(568)
    if not HUD.DOES_BLIP_EXIST(blip) then
        local entity_list = get_entities_by_hash("pickup", true, -1270906188)
        if next(entity_list) ~= nil then
            for k, ent in pairs(entity_list) do
                TP_TO_ME(ent, 0.0, 2.0, -0.5)
            end
        else
            util.toast("No Air Product Found")
        end
    else
        local ent = HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(blip)
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            TP_TO_ME(ent, 0.0, 2.0, -0.5)
        else
            util.toast("No Entity, Can't Teleport To Me")
        end
    end
end)
menu.action(Air_Freight, "货物(载具) 传送到我", {}, "", function()
    local product = 0
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(568)
    if not HUD.DOES_BLIP_EXIST(blip) then
        local entity_list = get_entities_by_hash("pickup", true, -1270906188)
        if next(entity_list) ~= nil then
            product = entity_list[1]
        else
            util.toast("No Air Product Found")
        end
    else
        product = HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(blip)
    end

    if ENTITY.DOES_ENTITY_EXIST(product) then
        local product_pos = ENTITY.GET_ENTITY_COORDS(product)
        local target_ent = get_closest_vehicle(product_pos, true, 10.0)
        if ENTITY.DOES_ENTITY_EXIST(target_ent) then
            TP_VEHICLE_TO_ME(target_ent, "delete", "delete")
        else
            util.toast("Not Found")
        end
    end
end)

menu.action(Air_Freight, "毁掉 泰坦号", {}, "", function()
    local entity_list = get_entities_by_hash("vehicle", true, 1981688531)
    if next(entity_list) ~= nil then
        for k, ent in pairs(entity_list) do
            TP_TO_ME(ent, 0.0, 10.0, 20.0)
            util.yield(2000)
            entities.delete(ent)
        end
    end
end)

menu.action(Air_Freight, "爆炸 所有敌对载具", { "veh_hostile_explode" }, "", function()
    for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
        if IS_HOSTILE_ENTITY(vehicle) then
            local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
            add_owned_explosion(players.user_ped(), coords, 4, { isAudible = false })
        end
    end
end)
menu.action(Air_Freight, "爆炸 所有敌对NPC", { "ped_hostile_explode" }, "", function()
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if IS_HOSTILE_ENTITY(ped) then
            local coords = ENTITY.GET_ENTITY_COORDS(ped)
            add_owned_explosion(players.user_ped(), coords, 4, { isAudible = false })
        end
    end
end)
menu.action(Air_Freight, "爆炸 所有敌对物体", { "obj_hostile_explode" }, "", function()
    for _, object in pairs(entities.get_all_objects_as_handles()) do
        if IS_HOSTILE_ENTITY(object) then
            local coords = ENTITY.GET_ENTITY_COORDS(object)
            add_owned_explosion(players.user_ped(), coords, 4, { isAudible = false })
        end
    end
end)



------- 其它 -------
local Mission_Entity_other = menu.list(adminworld, "其它", {}, "")

menu.action(Mission_Entity_other, "打开 恐霸屏幕", { "open_terrorbyte" }, "", function()
    if util.is_session_started() and not util.is_session_transition_active() then
        SET_INT_GLOBAL(Globals.IsUsingComputerScreen, 1)
        START_SCRIPT(Globals.SpecialCargoBuyScreenString, Globals.SpecialCargoBuyScreenArgs)
    end
end)
menu.action(Mission_Entity_other, "传送到 夜总会VIP客户", { "tp_radar_vip" }, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(480)
    if HUD.DOES_BLIP_EXIST(blip) then
        local coords = HUD.GET_BLIP_COORDS(blip)
        TELEPORT(coords.x, coords.y, coords.z + 0.8)
    end
end)
menu.action(Mission_Entity_other, "传送到 地图蓝点", { "tp_radar_blue" }, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(143)
    if HUD.DOES_BLIP_EXIST(blip) then
        local coords = HUD.GET_BLIP_COORDS(blip)
        TELEPORT(coords.x, coords.y, coords.z + 0.8)
    end
end)
menu.action(Mission_Entity_other, "出口载具 传送到我", {}, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(143)
    if HUD.DOES_BLIP_EXIST(blip) then
        local ent = HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(blip)
        if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
            TP_VEHICLE_TO_ME(ent)
        end
    end
end)
menu.action(Mission_Entity_other, "传送到 载具出口码头", {}, "", function()
    TELEPORT(1171.784, -2974.434, 6.502)
end)
menu.action(Mission_Entity_other, "传送到 出租车乘客", { "tp_taxi_passenger" }, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(280)
    if HUD.DOES_BLIP_EXIST(blip) then
        local ped = HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(blip)
        if ENTITY.IS_ENTITY_A_PED(ped) then
            TP_TO_ENTITY(ped, 0.0, 3.0, 0.0)
            SET_ENTITY_HEAD_TO_ENTITY(players.user_ped(), ped, 90)
        end
    end
end)
menu.action(Mission_Entity_other, "传送到 杰拉德包裹", { "tp_drug_pack" }, "进入范围内才能传送",
    function()
        local entity_list = get_entities_by_hash("object", true, 138777325, -1620734287, 765087784)
        if next(entity_list) ~= nil then
            for k, ent in pairs(entity_list) do
                TP_TO_ENTITY(ent, 0.0, 0.0, 0.5)
            end
        end
    end)
menu.action(Mission_Entity_other, "通知 藏匿屋密码", { "stash_house_code" }, "", function()
    local code_list = {
        -- hash, code
        { -73329357,   "01-23-45" }, -- xm3_prop_xm3_code_01_23_45
        { 1433270535,  "02-12-87" },
        { 944906360,   "05-02-91" },
        { -1248906748, "24-10-81" },
        { 1626709912,  "28-03-98" },
        { 921471402,   "28-11-97" },
        { -646417257,  "44-23-37" },
        { -158146725,  "72-68-83" },
        { 1083248297,  "73-27-38" },
        { 2104921722,  "77-79-73" },
    }
    for k, obj in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(obj) then
            local hash = ENTITY.GET_ENTITY_MODEL(obj)
            for _, data in pairs(code_list) do
                if hash == data[1] then
                    THEFEED_POST.TEXT("藏匿屋密码: " .. data[2])
                end
            end
        end
    end
end)

------------------
-- 玩家死亡反应
------------------
local Self_Death_Reaction = menu.list(funfeatures, "玩家死亡反应", {}, "针对击杀者或死亡地点的反应")

local self_death_reaction = {
    flag = false,
    killer = {
        exclude_player = true,
        explosion = 0,
        rpg = 0,
        fall_explosion = 0,
        dead = false,
        freeze = false,
        fire = false,
        blip = false,
        blip_list = {},
    },
    position = {
        explosion = 0,
        blip = false,
        blip_list = {},
    },
}
menu.toggle_loop(Self_Death_Reaction, "启用", {}, "", function()
    local player_ped = players.user_ped()

    if PLAYER.IS_PLAYER_DEAD(players.user()) then
        if not self_death_reaction.flag then
            --- 击杀者 ---
            local ent = PED.GET_PED_SOURCE_OF_DEATH(player_ped)
            if IS_AN_ENTITY(ent) and ent ~= player_ped then
                --排除玩家
                if self_death_reaction.killer.exclude_player and IS_PED_PLAYER(ent) then
                else
                    local pos = ENTITY.GET_ENTITY_COORDS(ent)

                    --爆炸
                    if self_death_reaction.killer.explosion then
                        util.create_thread(function()
                            for i = 1, self_death_reaction.killer.explosion, 1 do
                                local coords = ENTITY.GET_ENTITY_COORDS(ent)
                                add_owned_explosion(player_ped, coords, 4)
                                util.yield(300)
                            end
                        end)
                    end

                    --坠落爆炸
                    if self_death_reaction.killer.fall_explosion > 0 then
                        util.create_thread(function()
                            ENTITY.FREEZE_ENTITY_POSITION(ent, false)
                            ENTITY.SET_ENTITY_MAX_SPEED(ent, 99999.0)
                            if ENTITY.IS_ENTITY_A_PED(ent) then
                                TASK.CLEAR_PED_TASKS_IMMEDIATELY(ent)
                            end
                            for i = 1, self_death_reaction.killer.fall_explosion, 1 do
                                if ENTITY.IS_ENTITY_A_PED(ent) then
                                    PED.SET_PED_TO_RAGDOLL(ent, 500, 500, 0, false, false, false)
                                end
                                ENTITY.APPLY_FORCE_TO_ENTITY(ent, 1, 0.0, 0.0, 30.0, math.random(-2, 2),
                                    math.random(-2, 2), 0.0, 0, false,
                                    false, true, false, false)
                                util.yield(1000)
                                ENTITY.APPLY_FORCE_TO_ENTITY(ent, 1, 0.0, 0.0, -100.0, 0.0, 0.0, 0.0, 0, false
                                , false, true, false, false)
                                util.yield(300)
                            end
                            local coords = ENTITY.GET_ENTITY_COORDS(ent)
                            FIRE.ADD_OWNED_EXPLOSION(player_ped, coords.x, coords.y, coords.z, 4, 1.0, true,
                                false, 0.0)
                        end)
                    end

                    --RPG轰炸
                    if self_death_reaction.killer.rpg > 0 then
                        util.create_thread(function()
                            local weaponHash = util.joaat("WEAPON_RPG")
                            for i = 1, self_death_reaction.killer.rpg, 1 do
                                local coords = ENTITY.GET_ENTITY_COORDS(ent)
                                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(coords.x, coords.y, coords.z + 5.0, coords.x,
                                    coords.y, coords.z,
                                    1000,
                                    false, weaponHash, player_ped, true, false, 1000)
                                util.yield(300)
                            end
                        end)
                    end

                    --死亡
                    if self_death_reaction.killer.dead then
                        ENTITY.SET_ENTITY_HEALTH(ent, 0)
                    end

                    --冻结
                    if self_death_reaction.killer.freeze then
                        ENTITY.FREEZE_ENTITY_POSITION(ent, true)
                    end

                    --燃烧
                    if self_death_reaction.killer.fire then
                        FIRE.START_ENTITY_FIRE(ent)
                    end

                    --标记点
                    if self_death_reaction.killer.blip then
                        local blip = add_blip_for_entity(ent, 303, 1)
                        table.insert(self_death_reaction.killer.blip_list, blip)
                    end
                end
            end


            --- 死亡位置 ---
            local dead_pos = ENTITY.GET_ENTITY_COORDS(player_ped)

            if self_death_reaction.position.explosion > 0 then
                util.create_thread(function()
                    for i = 1, self_death_reaction.position.explosion, 1 do
                        add_owned_explosion(player_ped, dead_pos, 4)
                        util.yield(300)
                    end
                end)
            end

            if self_death_reaction.position.blip then
                local blip = HUD.ADD_BLIP_FOR_COORD(dead_pos.x, dead_pos.y, dead_pos.z)
                HUD.SET_BLIP_SPRITE(blip, 274)
                HUD.SET_BLIP_COLOUR(blip, 0)
                table.insert(self_death_reaction.position.blip_list, blip)
            end


            self_death_reaction.flag = true
        end
    else
        self_death_reaction.flag = false
    end
end)

menu.divider(Self_Death_Reaction, "击杀者")
menu.toggle(Self_Death_Reaction, "排除玩家", {}, "", function(toggle)
    self_death_reaction.killer.exclude_player = toggle
end, false)
menu.slider(Self_Death_Reaction, "爆炸", { "death_reaction_killer_explosion" }, "爆炸次数", 0, 10, 0, 1,
    function(value)
        self_death_reaction.killer.explosion = value
    end)
menu.slider(Self_Death_Reaction, "坠落爆炸", { "death_reaction_killer_fall_explosion" }, "坠落次数", 0, 10, 0, 1
, function(value)
    self_death_reaction.killer.fall_explosion = value
end)
menu.slider(Self_Death_Reaction, "RPG轰炸", { "death_reaction_killer_rpg" }, "轰炸次数", 0, 10, 0, 1,
    function(value)
        self_death_reaction.killer.rpg = value
    end)
menu.toggle(Self_Death_Reaction, "死亡", {}, "", function(toggle)
    self_death_reaction.killer.dead = toggle
end)
menu.toggle(Self_Death_Reaction, "冻结", {}, "", function(toggle)
    self_death_reaction.killer.freeze = toggle
end)
menu.toggle(Self_Death_Reaction, "燃烧", {}, "", function(toggle)
    self_death_reaction.killer.fire = toggle
end)
menu.toggle(Self_Death_Reaction, "标记点", {}, "", function(toggle)
    self_death_reaction.killer.blip = toggle
end)
menu.action(Self_Death_Reaction, "清空标记点", {}, "", function()
    for k, v in pairs(self_death_reaction.killer.blip_list) do
        if HUD.DOES_BLIP_EXIST(v) then
            util.remove_blip(v)
        end
    end
    self_death_reaction.killer.blip_list = {}
end)

menu.divider(Self_Death_Reaction, "死亡位置")
menu.slider(Self_Death_Reaction, "爆炸", { "death_reaction_position_explosion" }, "爆炸次数", 0, 10, 0, 1,
    function(value)
        self_death_reaction.position.explosion = value
    end)
menu.toggle(Self_Death_Reaction, "标记点", {}, "", function(toggle)
    self_death_reaction.position.blip = toggle
end)
menu.action(Self_Death_Reaction, "清空标记点", {}, "", function()
    for k, v in pairs(self_death_reaction.position.blip_list) do
        if HUD.DOES_BLIP_EXIST(v) then
            util.remove_blip(v)
        end
    end
    self_death_reaction.position.blip_list = {}
end)