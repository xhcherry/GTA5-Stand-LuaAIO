--------------------------------
-- Basic Functions
--------------------------------

--- @param entity Entity
--- @param coords v3
--- @param heading? float
function TP_ENTITY(entity, coords, heading)
    if heading ~= nil then
        ENTITY.SET_ENTITY_HEADING(entity, heading)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(entity, coords.x, coords.y, coords.z, true, false, false)
end

--- @param entity Entity
--- @return string|nil
function GET_ENTITY_SCRIPT(entity)
    local entity_script = ENTITY.GET_ENTITY_SCRIPT(entity, 0)
    if entity_script == nil then return "" end
    return string.lower(entity_script)
end

--- @param textLabel string
--- @return boolean
function IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(textLabel)
    HUD.BEGIN_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(textLabel)
    return HUD.END_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(0) -- HELP_TEXT_SLOT_STANDARD
end

get_label_text = util.get_label_text

--------------------------------
-- Local Player Functions
--------------------------------

--- @param coords v3
--- @param heading? float
function TELEPORT(coords, heading)
    local ent = entities.get_user_vehicle_as_handle(false)
    if ent == INVALID_GUID then
        ent = players.user_ped()
    end

    TP_ENTITY(ent, coords, heading)
end

--- @param entity Entity
--- @param offsetX? float
--- @param offsetY? float
--- @param offsetZ? float
function TP_ENTITY_TO_ME(entity, offsetX, offsetY, offsetZ)
    offsetX = offsetX or 0.0
    offsetY = offsetY or 0.0
    offsetZ = offsetZ or 0.0
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), offsetX, offsetY, offsetZ)
    TP_ENTITY(entity, coords)
end

--- @param vehicle Vehicle
function TP_VEHICLE_TO_ME(vehicle)
    if not VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, -1, false) then
        local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(driver)
    end

    UNLOCK_VEHICLE(vehicle)

    ENTITY.SET_ENTITY_HEADING(vehicle, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
    TP_ENTITY_TO_ME(vehicle)
    PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -1)
end

--- @param vehicle Vehicle
--- @param isDriverSeat boolean
function TP_INTO_VEHICLE(vehicle, isDriverSeat)
    if isDriverSeat and not VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, -1, false) then
        local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(driver)
    end

    UNLOCK_VEHICLE(vehicle)

    local seat = -1
    if not isDriverSeat then
        seat = -2
    end

    PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, seat)
end

--- @param missionScript string
function TP_MISSION_PICKUPS_TO_ME(missionScript)
    for _, ent in pairs(entities.get_all_pickups_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local entity_script = GET_ENTITY_SCRIPT(ent)
            if entity_script == missionScript then
                if ENTITY.IS_ENTITY_ATTACHED(ent) then
                    ENTITY.DETACH_ENTITY(ent, true, true)
                    ENTITY.SET_ENTITY_VISIBLE(ent, true, false)
                end
                OBJECT.SET_PICKUP_OBJECT_COLLECTABLE_IN_VEHICLE(ent)

                TP_ENTITY_TO_ME(ent)
                OBJECT.ATTACH_PORTABLE_PICKUP_TO_PED(ent, players.user_ped())
            end
        end
    end
end

--- @return boolean
function IS_PLAYER_BOSS_OF_A_GANG()
    return players.get_org_type(players.user()) ~= -1
end

--- @return boolean
function IS_PLAYER_IN_KOSATKA()
    return INTERIOR.GET_INTERIOR_FROM_ENTITY(players.user_ped()) == 281345
end

--- @return boolean
function IS_PLAYER_IN_INTERIOR()
    return INTERIOR.GET_INTERIOR_FROM_ENTITY(players.user_ped()) ~= 0
end

--- @return boolean
function IS_PLAYER_IN_APARTMENT_PLANNING_ROOM()
    if HUD.IS_HELP_MESSAGE_BEING_DISPLAYED() then
        if IS_THIS_HELP_MESSAGE_BEING_DISPLAYED("HEIST_PRE_DONE2") or IS_THIS_HELP_MESSAGE_BEING_DISPLAYED("HEIST_STR_BG2") then
            return true
        end
    end
    return false
end

--------------------------------
-- Vehicle Functions
--------------------------------

--- @param vehicle Vehicle
function UNLOCK_VEHICLE(vehicle)
    VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 1)
    VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, false)
    VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(vehicle, false)
    VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_TEAMS(vehicle, false)
    VEHICLE.SET_DONT_ALLOW_PLAYER_TO_ENTER_VEHICLE_IF_LOCKED_FOR_PLAYER(vehicle, false)

    VEHICLE.SET_VEHICLE_HAS_BEEN_OWNED_BY_PLAYER(vehicle, true)
    VEHICLE.SET_VEHICLE_IS_STOLEN(vehicle, false)
    VEHICLE.SET_VEHICLE_IS_WANTED(vehicle, false)
    VEHICLE.SET_POLICE_FOCUS_WILL_TRACK_VEHICLE(vehicle, false)
    VEHICLE.SET_VEHICLE_INFLUENCES_WANTED_LEVEL(vehicle, false)
    VEHICLE.SET_DISABLE_WANTED_CONES_RESPONSE(vehicle, true)

    VEHICLE.SET_VEHICLE_IS_CONSIDERED_BY_PLAYER(vehicle, true)
    VEHICLE.SET_VEHICLE_EXCLUSIVE_DRIVER(vehicle, 0, 0)
    ENTITY.FREEZE_ENTITY_POSITION(vehicle, false)

    VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, false)
    VEHICLE.SET_HELI_BLADES_FULL_SPEED(vehicle)
end

--------------------------------
-- Business Functions
--------------------------------

--- @return boolean
function IS_IN_SESSION()
    return util.is_session_started() and not util.is_session_transition_active()
end

--- @param iWarehouse integer
--- @return string
function GET_SPECIAL_CARGO_WAREHOUSE_NAME(iWarehouse)
    return util.get_label_text("MP_WHOUSE_" .. iWarehouse - 1)
end

--- @param iSaveSlot integer
--- @return integer
function GET_WAREHOUSE_PROPERTY_ID(iSaveSlot)
    return STAT_GET_INT(ADD_MP_INDEX("PROP_WHOUSE_SLOT" .. iSaveSlot))
end

--- @param eFactoryID integer
--- @return integer
function GET_FACTORY_PROPERTY_ID(eFactoryID)
    return STAT_GET_INT(ADD_MP_INDEX("FACTORYSLOT" .. eFactoryID))
end

--- @param eFactoryID integer
--- @return integer
function GET_FACTORY_SUPPLIES(eFactoryID)
    return STAT_GET_INT(ADD_MP_INDEX("MATTOTALFORFACTORY" .. eFactoryID))
end

--- @param eFactoryID integer
--- @return integer
function GET_FACTORY_PRODUCT(eFactoryID)
    return STAT_GET_INT(ADD_MP_INDEX("PRODTOTALFORFACTORY" .. eFactoryID))
end

--- @return integer
function GET_IMPORT_EXPORT_GARAGE_PROPERTY_ID()
    return STAT_GET_INT(ADD_MP_INDEX("OWNED_IE_WAREHOUSE"))
end

--- @return integer
function GET_HANGAR_PROPERTY_ID()
    return STAT_GET_INT(ADD_MP_INDEX("HANGAR_OWNED"))
end

--- @return integer
function GET_BUNKER_PROPERTY_ID()
    return STAT_GET_INT(ADD_MP_INDEX("FACTORYSLOT5"))
end

--- @return integer
function GET_NIGHTCLUB_PROPERTY_ID()
    return STAT_GET_INT(ADD_MP_INDEX("NIGHTCLUB_OWNED"))
end

--- @return integer
function GET_ARCADE_PROPERTY_ID()
    return STAT_GET_INT(ADD_MP_INDEX("ARCADE_OWNED"))
end

--- @return integer
function GET_AUTO_SHOP_PROPERTY_ID()
    return STAT_GET_INT(ADD_MP_INDEX("AUTO_SHOP_OWNED"))
end

--- @return integer
function GET_AGENCY_PROPERTY_ID()
    return STAT_GET_INT(ADD_MP_INDEX("FIXER_HQ_OWNED"))
end

--- @return integer
function GET_SALVAGE_YARD_PROPERTY_ID()
    return STAT_GET_INT(ADD_MP_INDEX("SALVAGE_YARD_OWNED"))
end

--- @return integer
function GET_FACILITY_PROPERTY_ID()
    return STAT_GET_INT(ADD_MP_INDEX("DBASE_OWNED"))
end

--- @return integer
function GET_BIKER_CLUBHOUSE_PROPERTY_ID()
    return STAT_GET_INT(ADD_MP_INDEX("PROP_CLUBHOUSE"))
end

--- @return boolean
function DOES_PLAYER_OWN_ACID_LAB()
    return STAT_GET_INT(ADD_MP_INDEX("XM22_LAB_OWNED")) == util.joaat("brickade2") -- -1576586413
end

--- @return boolean
function DOES_PLAYER_OWN_KOSATKA()
    return STAT_GET_INT(ADD_MP_INDEX("IH_SUB_OWNED")) == util.joaat("kosatka") -- 1336872304
end

--------------------------------
-- Heist Functions
--------------------------------

--- @return boolean
function IS_PLAYER_GANG_OPS_HEIST_ACTIVE()
    local iStatInt = STAT_GET_INT(ADD_MP_INDEX("GANGOPS_HEIST_STATUS"))
    -- GANG_OPS_BD_HEIST_STATUS_BITSET_IAA_STRAND_ACTIVE            0
    -- GANG_OPS_BD_HEIST_STATUS_BITSET_SUBMARINE_STRAND_ACTIVE      1
    -- GANG_OPS_BD_HEIST_STATUS_BITSET_MISSILE_SILO_STRAND_ACTIVE   2
    if BIT_TEST(iStatInt, 0) or BIT_TEST(iStatInt, 1) or BIT_TEST(iStatInt, 2) then
        return true
    end
    return false
end

--- @return boolean
function IS_PLAYER_CASINO_HEIST_ACTIVE()
    local iStatInt = STAT_GET_INT(ADD_MP_INDEX("CAS_HEIST_FLOW"))
    -- ciCASINO_HEIST_FLOW_STAT_BITSET__HEIST_ACTIVE    0
    if BIT_TEST(iStatInt, 0) then
        return true
    end
    return false
end

--- @return boolean
function IS_PLAYER_ISLAND_HEIST_ACTIVE()
    local iStatInt = STAT_GET_INT(ADD_MP_INDEX("H4_PROGRESS"))
    -- ciHEIST_ISLAND_PROGRESS_BITSET__ACTIVE   0
    if BIT_TEST(iStatInt, 0) then
        return true
    end
    return false
end

--------------------------------
-- Script Functions
--------------------------------

--- @param script string
--- @return boolean
function IS_SCRIPT_RUNNING(script)
    return SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat(script)) > 0
end

--- @param script string
--- @param arg_count integer
--- @return boolean
function START_SCRIPT(script, arg_count)
    if not SCRIPT.DOES_SCRIPT_EXIST(script) then
        return false
    end
    if IS_SCRIPT_RUNNING(script) then
        return true
    end
    SCRIPT.REQUEST_SCRIPT(script)
    while not SCRIPT.HAS_SCRIPT_LOADED(script) do
        util.yield()
    end
    SYSTEM.START_NEW_SCRIPT(script, arg_count or 0)
    SCRIPT.SET_SCRIPT_AS_NO_LONGER_NEEDED(script)
    return true
end

--- @return boolean
function IS_MISSION_CONTROLLER_SCRIPT_RUNNING()
    return IS_SCRIPT_RUNNING("fm_mission_controller") or IS_SCRIPT_RUNNING("fm_mission_controller_2020")
end

--- @return string|nil
function GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    local script = "fm_mission_controller"
    if IS_SCRIPT_RUNNING(script) then
        return script
    end

    script = "fm_mission_controller_2020"
    if IS_SCRIPT_RUNNING(script) then
        return script
    end

    return nil
end

--- @param func function
--- @param script_host boolean
function FMMC_SCRIPT(func, script_host)
    local script = GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    if script == nil then
        return
    end

    if script_host and NETWORK.NETWORK_GET_HOST_OF_SCRIPT(script, 0, 0) ~= players.user() then
        if not util.request_script_host(script) then
            util.toast("请求成为任务脚本主机失败，请重试")
            return
        end
    end

    func(script)
end

--------------------------------
-- Global Functions
--------------------------------

--- @param global integer
--- @param value integer
function GLOBAL_SET_INT(global, value)
    memory.write_int(memory.script_global(global), value)
end

--- @param global integer
--- @param value float
function GLOBAL_SET_FLOAT(global, value)
    memory.write_float(memory.script_global(global), value)
end

--- @param global integer
--- @param value string
function GLOBAL_SET_STRING(global, value)
    memory.write_string(memory.script_global(global), value)
end

--- @param global integer
--- @param value boolean
function GLOBAL_SET_BOOL(global, value)
    memory.write_int(memory.script_global(global), value and 1 or 0)
end

--- @param global integer
--- @return integer
function GLOBAL_GET_INT(global)
    return memory.read_int(memory.script_global(global))
end

--- @param global integer
--- @return float
function GLOBAL_GET_FLOAT(global)
    return memory.read_float(memory.script_global(global))
end

--- @param global integer
---@return string
function GLOBAL_GET_STRING(global)
    return memory.read_string(memory.script_global(global))
end

--- @param global integer
--- @return boolean
function GLOBAL_GET_BOOL(global)
    return memory.read_int(memory.script_global(global)) == 1
end

--- @param global integer
--- @param bit integer
function GLOBAL_SET_BIT(global, bit)
    local addr = memory.script_global(global)
    memory.write_int(addr, SET_BIT(memory.read_int(addr), bit))
end

--- @param global integer
--- @param bit integer
function GLOBAL_CLEAR_BIT(global, bit)
    local addr = memory.script_global(global)
    memory.write_int(addr, CLEAR_BIT(memory.read_int(addr), bit))
end

--- @param global integer
--- @param bit integer
--- @return boolean
function GLOBAL_BIT_TEST(global, bit)
    local addr = memory.script_global(global)
    return BIT_TEST(memory.read_int(addr), bit)
end

--- @param global integer
--- @param ... bits
function GLOBAL_SET_BITS(global, ...)
    local addr = memory.script_global(global)
    memory.write_int(addr, SET_BITS(memory.read_int(addr), ...))
end

--------------------------------
-- Local Functions
--------------------------------

--- @param script string
--- @param script_local integer
--- @param value integer
function LOCAL_SET_INT(script, script_local, value)
    if memory.script_local(script, script_local) ~= 0 then
        memory.write_int(memory.script_local(script, script_local), value)
    end
end

--- @param script string
--- @param script_local integer
--- @param value float
function LOCAL_SET_FLOAT(script, script_local, value)
    if memory.script_local(script, script_local) ~= 0 then
        memory.write_float(memory.script_local(script, script_local), value)
    end
end

--- @param script string
--- @param script_local integer
--- @return integer
function LOCAL_GET_INT(script, script_local)
    if memory.script_local(script, script_local) ~= 0 then
        return memory.read_int(memory.script_local(script, script_local))
    end
end

--- @param script string
--- @param script_local integer
--- @return float
function LOCAL_GET_FLOAT(script, script_local)
    if memory.script_local(script, script_local) ~= 0 then
        return memory.read_float(memory.script_local(script, script_local))
    end
end

--- @param script string
--- @param script_local integer
--- @return boolean
function LOCAL_GET_BOOL(script, script_local)
    if memory.script_local(script, script_local) ~= 0 then
        return memory.read_int(memory.script_local(script, script_local)) == 1
    end
end

--- @param script string
--- @param script_local integer
--- @param bit integer
function LOCAL_SET_BIT(script, script_local, bit)
    local addr = memory.script_local(script, script_local)
    if addr ~= 0 then
        memory.write_int(addr, SET_BIT(memory.read_int(addr), bit))
    end
end

--- @param script string
--- @param script_local integer
--- @param bit integer
function LOCAL_CLEAR_BIT(script, script_local, bit)
    local addr = memory.script_local(script, script_local)
    if addr ~= 0 then
        memory.write_int(addr, CLEAR_BIT(memory.read_int(addr), bit))
    end
end

--- @param script string
--- @param script_local integer
--- @param bit integer
--- @return boolean
function LOCAL_BIT_TEST(script, script_local, bit)
    local addr = memory.script_local(script, script_local)
    if addr ~= 0 then
        return BIT_TEST(memory.read_int(addr), bit)
    end
end

--- @param script string
--- @param script_local integer
--- @param ... bits
function LOCAL_SET_BITS(script, script_local, ...)
    local addr = memory.script_local(script, script_local)
    if addr ~= 0 then
        memory.write_int(addr, SET_BITS(memory.read_int(addr), ...))
    end
end

--- @param script string
--- @param script_local integer
--- @param ... bits
function LOCAL_CLEAR_BITS(script, script_local, ...)
    local addr = memory.script_local(script, script_local)
    if addr ~= 0 then
        memory.write_int(addr, CLEAR_BITS(memory.read_int(addr), ...))
    end
end

--- @param script string
--- @param script_local integer
--- @param ... bits
--- @return boolean
function LOCAL_BITS_TEST(script, script_local, ...)
    local addr = memory.script_local(script, script_local)
    if addr ~= 0 then
        return BITS_TEST(memory.read_int(addr), ...)
    end
end

--------------------------------
-- Bit Functions
--------------------------------

--- @param value integer
--- @param position integer
--- @return integer
function SET_BIT(value, position)
    return (value | (1 << position))
end

--- @param value integer
--- @param position integer
--- @return integer
function CLEAR_BIT(value, position)
    return (value & ~(1 << position))
end

--- @param value integer
--- @param position integer
--- @return integer
function BIT_TEST(value, position)
    return (value & (1 << position)) ~= 0
end

--- @param value integer
--- @param ... positions
--- @return integer
function SET_BITS(value, ...)
    local positions = { ... }
    for _, position in ipairs(positions) do
        value = value | (1 << position)
    end
    return value
end

--- @param value integer
--- @param ... positions
--- @return integer
function CLEAR_BITS(value, ...)
    local positions = { ... }
    for _, position in ipairs(positions) do
        value = value & ~(1 << position)
    end
    return value
end

--- @param value integer
--- @param ... positions
--- @return boolean
function BITS_TEST(value, ...)
    local positions = { ... }
    for _, position in ipairs(positions) do
        if (value & (1 << position)) == 0 then
            return false
        end
    end
    return true
end

--------------------------------
-- Stat Functions
--------------------------------

--- @param stat string
---@return string
function ADD_MP_INDEX(stat)
    return "MP" .. util.get_char_slot() .. "_" .. stat
end

--- @param stat string
--- @param value integer
function STAT_SET_INT(stat, value)
    STATS.STAT_SET_INT(util.joaat(stat), value, true)
end

--- @param stat string
--- @param value boolean
function STAT_SET_BOOL(stat, value)
    STATS.STAT_SET_BOOL(util.joaat(stat), value, true)
end

--- @param stat string
--- @param value string
function STAT_SET_STRING(stat, value)
    STATS.STAT_SET_STRING(util.joaat(stat), value, true)
end

--- @param stat string
---@return integer
function STAT_GET_INT(stat)
    local ptr = memory.alloc_int()
    STATS.STAT_GET_INT(util.joaat(stat), ptr, -1)
    return memory.read_int(ptr)
end

--- @param stat string
---@return string
function STAT_GET_STRING(stat)
    return STATS.STAT_GET_STRING(util.joaat(stat), -1)
end

--------------------------------
-- Packed Stat Functions
--------------------------------

--- @param statIndex integer
--- @return integer
function GET_PACKED_STAT_INT_CODE(statIndex)
    return STATS.GET_PACKED_STAT_INT_CODE(statIndex, util.get_char_slot())
end

--- @param statIndex integer
--- @return boolean
function GET_PACKED_STAT_BOOL_CODE(statIndex)
    return STATS.GET_PACKED_STAT_BOOL_CODE(statIndex, util.get_char_slot())
end

--- @param statIndex integer
--- @param value integer
function SET_PACKED_STAT_INT_CODE(statIndex, value)
    STATS.SET_PACKED_STAT_INT_CODE(statIndex, value, util.get_char_slot())
end

--- @param statIndex integer
--- @param value boolean
function SET_PACKED_STAT_BOOL_CODE(statIndex, value)
    STATS.SET_PACKED_STAT_BOOL_CODE(statIndex, value, util.get_char_slot())
end

--------------------------------
-- Util Functions
--------------------------------

rs = {}

--- Your `on_change` function will be called with value, prev_value and click_type.
--- @param parent CommandRef
--- @param menu_name string
--- @param command_names table<any, string>
--- @param help_text Label
--- @param min_value int
--- @param max_value int
--- @param default_value int
--- @param step_size int
--- @param on_change function
--- @return CommandRef|CommandUniqPtr
function rs.menu_slider(parent, menu_name, command_names, help_text,
                        min_value, max_value, default_value, step_size, on_change)
    local command = menu.slider(parent, menu_name, command_names, help_text,
        min_value, max_value, default_value, step_size, on_change)

    menu.add_value_replacement(command, -1, Labels.Default)

    return command
end

--- @param menu_list table<int, CommandRef>
function rs.delete_menu_list(menu_list)
    for _, command in pairs(menu_list) do
        menu.delete(command)
    end
end
