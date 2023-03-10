-- Author: Rostal
-- Last edit date: 2022/8/1
require "lib.YMlib.natives"

--- --- --- Functions --- --- ---


function IS_PED_PLAYER(Ped)
    if PED.GET_PED_TYPE(Ped) >= 4 then
        return false
    else
        return true
    end
end

function TELEPORT(X, Y, Z)
    local Me = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    if PED.GET_VEHICLE_PED_IS_IN(Me, false) == 0 then
        ENTITY.SET_ENTITY_COORDS(Me, X, Y, Z)
    else
        ENTITY.SET_ENTITY_COORDS(PED.GET_VEHICLE_PED_IS_IN(Me, false), X, Y, Z)
    end
end

vect = {
    ['new'] = function(x, y, z)
        return { ['x'] = x, ['y'] = y, ['z'] = z }
    end,
    ['subtract'] = function(a, b)
        return vect.new(a.x - b.x, a.y - b.y, a.z - b.z)
    end,
    ['add'] = function(a, b)
        return vect.new(a.x + b.x, a.y + b.y, a.z + b.z)
    end,
    ['mag'] = function(a)
        return math.sqrt(a.x ^ 2 + a.y ^ 2 + a.z ^ 2)
    end,
    ['norm'] = function(a)
        local mag = vect.mag(a)
        return vect.div(a, mag)
    end,
    ['mult'] = function(a, b)
        return vect.new(a.x * b, a.y * b, a.z * b)
    end,
    ['div'] = function(a, b)
        return vect.new(a.x / b, a.y / b, a.z / b)
    end,
    ['dist'] = function(a, b)
        --returns the distance between two vectors
        return vect.mag(vect.subtract(a, b))
    end
}


--returns a list of nearby vehicles given player Id
function GET_NEARBY_VEHICLES(pid, radius)
    local vehicles = {}
    local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(p)
    local v = PED.GET_VEHICLE_PED_IS_IN(p, false)
    for k, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
        local veh_pos = ENTITY.GET_ENTITY_COORDS(vehicle)
        if vehicle ~= v and vect.dist(pos, veh_pos) <= radius then
            table.insert(vehicles, vehicle)
        end
    end
    return vehicles
end

--returns a list of nearby peds given player Id
function GET_NEARBY_PEDS(pid, radius)
    local peds = {}
    local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(p)
    for k, ped in pairs(entities.get_all_peds_as_handles()) do
        if ped ~= p then
            local ped_pos = ENTITY.GET_ENTITY_COORDS(ped)
            if vect.dist(pos, ped_pos) <= radius then
                table.insert(peds, ped)
            end
        end
    end
    return peds
end

--?????????????????????
local GetEntity_PlayerIsAimingAt = function(p)
    local ent = NULL
    if PLAYER.IS_PLAYER_FREE_AIMING(p) then
        local ptr = memory.alloc_int()
        if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(p, ptr) then
            ent = memory.read_int(ptr)
        end
        memory.free(ptr)
        if ENTITY.IS_ENTITY_A_PED(ent) and PED.IS_PED_IN_ANY_VEHICLE(ent) then
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(ent, false)
            ent = vehicle
        end
    end
    return ent
end
--??????????????????????????????
function addBlipForEntity(entity, blipSprite, colour)
    local blip = HUD.ADD_BLIP_FOR_ENTITY(entity)
    HUD.SET_BLIP_SPRITE(blip, blipSprite)
    HUD.SET_BLIP_COLOUR(blip, colour)
    HUD.SHOW_HEIGHT_ON_BLIP(blip, false)
    HUD.SET_BLIP_ROTATION(blip, GENERIC_SYSTEM.CEIL(ENTITY.GET_ENTITY_HEADING(entity)))
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(entity, false)
    util.create_thread(function()
        while not ENTITY.IS_ENTITY_DEAD(entity) do
            local heading = ENTITY.GET_ENTITY_HEADING(entity)
            HUD.SET_BLIP_ROTATION(blip, GENERIC_SYSTEM.CEIL(heading))
            util.yield()
        end
        util.remove_blip(blip)
    end)
    return blip
end
------ STAT Functions ---
function MP_INDEX()
    return "MP" .. util.get_char_slot() .. "_"
end

function IS_MPPLY(Stat)
    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        return true
    else
        return false
    end
end

function STAT_SET_INT(Stat, Value)
    if IS_MPPLY(Stat) then
        STATS.STAT_SET_INT(util.joaat(Stat), Value, true)
    else
        STATS.STAT_SET_INT(util.joaat(MP_INDEX() .. Stat), Value, true)
    end
end

function STAT_SET_FLOAT(Stat, Value)
    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_SET_FLOAT(util.joaat(Stat), Value, true)
    else
        STATS.STAT_SET_FLOAT(util.joaat(MP_INDEX() .. Stat), Value, true)
    end
end

function STAT_SET_BOOL(Stat, Value)
    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_SET_BOOL(util.joaat(Stat), Value, true)
    else
        STATS.STAT_SET_BOOL(util.joaat(MP_INDEX() .. Stat), Value, true)
    end
end

function STAT_SET_INCREMENT(Stat, Value)
    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_INCREMENT(util.joaat(Stat), Value, true)
    else
        STATS.STAT_INCREMENT(util.joaat(MP_INDEX() .. Stat), Value, true)
    end
end

function STAT_GET_INT(Stat)
    local IntPTR = memory.alloc(4)

    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_GET_INT(util.joaat(Stat), IntPTR, -1)
    else
        STATS.STAT_GET_INT(util.joaat(MP_INDEX() .. Stat), IntPTR, -1)
    end

    return memory.read_int(IntPTR)
end

function STAT_GET_FLOAT(Stat)
    local FloatPTR = memory.alloc(4)

    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_GET_FLOAT(util.joaat(Stat), FloatPTR, -1)
    else
        STATS.STAT_GET_FLOAT(util.joaat(MP_INDEX() .. Stat), FloatPTR, -1)
    end

    return tonumber(string.format("%.3f", memory.read_float(FloatPTR)))
end

function STAT_GET_BOOL(Stat)
    local BoolPTR = memory.alloc(1)

    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_GET_BOOL(util.joaat(Stat), BoolPTR, -1)
    else
        STATS.STAT_GET_BOOL(util.joaat(MP_INDEX() .. Stat), BoolPTR, -1)
    end

    if memory.read_byte(BoolPTR) == 1 then
        return "true"
    else
        return "false"
    end
end

--- GLOBAL Functions ---
function SET_INT_GLOBAL(Global, Value)
    memory.write_int(memory.script_global(Global), Value)
end

function SET_FLOAT_GLOBAL(Global, Value)
    memory.write_float(memory.script_global(Global), Value)
end

-- GET
function GET_INT_GLOBAL(Global)
    return memory.read_int(memory.script_global(Global))
end

function SET_PACKED_INT_GLOBAL(StartGlobal, EndGlobal, Value)
    for i = StartGlobal, EndGlobal do
        SET_INT_GLOBAL(262145 + i, Value)
    end
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

-- GET
function GET_INT_LOCAL(Script, Local)
    if memory.script_local(Script, Local) ~= 0 then
        return memory.read_int(memory.script_local(Script, Local))
    end
end

---
util.keep_running()



-------------------------------
---------- ?????????????????? ----------
-------------------------------



local NEAR_PED_CAM = menu.list(entity_options, "???????????????NPC????????????", {}, "")

menu.divider(NEAR_PED_CAM, "??????")

local HostilePed = false
menu.toggle(NEAR_PED_CAM, "?????????????????????NPC??????", {}, "??????????????????????????????NPC??????" .. "\n" .. "??????????????????NPC??????", function(Toggle)
    HostilePedToggle = Toggle

    if HostilePedToggle then
        HostilePed = true
    else
        HostilePed = false
    end
end)

-----
menu.divider(NEAR_PED_CAM, "NPC??????")

menu.action(NEAR_PED_CAM, "??????NPC??????", {}, "", function()
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        if not IS_PED_PLAYER(ent) then
            if HostilePed then
                if PED.IS_PED_IN_COMBAT(ent, PLAYER.PLAYER_ID()) then
                    WEAPON.REMOVE_ALL_PED_WEAPONS(ent, true)
                end
            else
                WEAPON.REMOVE_ALL_PED_WEAPONS(ent, true)
            end
        end
    end
end)

menu.action(NEAR_PED_CAM, "????????????NPC", {}, "", function()
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        if not IS_PED_PLAYER(ent) then
            if HostilePed then
                if PED.IS_PED_IN_COMBAT(ent, PLAYER.PLAYER_ID()) then
                    entities.delete_by_handle(ent)
                end
            else
                entities.delete_by_handle(ent)
            end
        end
    end
end)

menu.action(NEAR_PED_CAM, "????????????NPC", {}, "", function()
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        if not IS_PED_PLAYER(ent) then
            if HostilePed then
                if PED.IS_PED_IN_COMBAT(ent, PLAYER.PLAYER_ID()) then
                    ENTITY.SET_ENTITY_HEALTH(ent, 0.0)
                end
            else
                ENTITY.SET_ENTITY_HEALTH(ent, 0.0)
            end
        end
    end
end)

-----
menu.divider(NEAR_PED_CAM, "???????????????")

menu.action(NEAR_PED_CAM, "???????????????", {}, "????????????????????????????????????", function()
    -- Credit goes to Leif.Erickson
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityModel = ENTITY.GET_ENTITY_MODEL(ent)
        local Cams = {
            -1233322078,
            168901740,
            -1095296451,
            -173206916,
            -1159421424,
            548760764,
            -1340405475,
            1449155105,
            -354221800,
            -1884701657,
            2090203758,
            -1007354661,
            -1842407088,
            289451089,
            3061645218
        }

        for i = 1, #Cams do
            if EntityModel == Cams[i] then
                entities.delete_by_handle(ent)
            end
        end
    end
end)

menu.action(NEAR_PED_CAM, "???????????????", {}, "???????????????????????????", function()
    -- Credit goes to Leif.Erickson
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityModel = ENTITY.GET_ENTITY_MODEL(ent)
        local Cams = {
            -1233322078,
            168901740,
            -1095296451,
            -173206916,
            -1159421424,
            548760764,
            -1340405475,
            1449155105,
            -354221800,
            -1884701657,
            2090203758,
            -1007354661,
            -1842407088,
            289451089,
            3061645218
        }

        for i = 1, #Cams do
            if EntityModel == Cams[i] then
                local pos = ENTITY.GET_ENTITY_COORDS(ent)
                ENTITY.SET_ENTITY_COORDS(ent, pos.x, pos.y, pos.z + 20.0, true, false, false, false)
            end
        end
    end
end)

-- -- ????????????
local NEARBY_VEHICLE = menu.list(entity_options, "??????????????????", {}, "")

local radius_nearby_vehicle = 30
menu.slider(NEARBY_VEHICLE, "????????????", { "radius_nearby_vehicle" }, "", 0, 1000, 30, 10, function(value)
    radius_nearby_vehicle = value
end)

menu.action(NEARBY_VEHICLE, "??????????????????", {}, "", function()
    for k, vehicle in pairs(GET_NEARBY_VEHICLES(players.user(), radius_nearby_vehicle)) do
        VEHICLE.EXPLODE_VEHICLE(vehicle, true, true)
    end
end)

menu.divider(NEARBY_VEHICLE, "????????????")

local launch_vehicle_height = 20
menu.slider(NEARBY_VEHICLE, "????????????", { "launch_vehicle_height" }, "", 0, 1000, 20, 10, function(value)
    launch_vehicle_height = value
end)

local launch_vehicle_freeze = false
menu.toggle(NEARBY_VEHICLE, "????????????", {}, "", function(toggle)
    launch_vehicle_freeze = toggle
end)

menu.action(NEARBY_VEHICLE, "????????????", {}, "", function()
    for k, vehicle in ipairs(GET_NEARBY_VEHICLES(players.user(), radius_nearby_vehicle)) do
        if vehicle ~= entities.get_user_vehicle_as_handle() then
            if launch_vehicle_freeze then
                ENTITY.FREEZE_ENTITY_POSITION(vehicle, true)
            end
            local pos = ENTITY.GET_ENTITY_COORDS(vehicle)
            ENTITY.SET_ENTITY_COORDS(vehicle, pos.x, pos.y, pos.z + launch_vehicle_height, false, false, false, false)
        end
    end
end)

-- -- ??????NPC
local NEARBY_PED = menu.list(entity_options, "????????????NPC", {}, "")

local radius_nearby_ped = 30
menu.slider(NEARBY_PED, "????????????", { "radius_nearby_ped" }, "", 0, 1000, 30, 10, function(value)
    radius_nearby_ped = value
end)

menu.divider(NEARBY_PED, "NPC??????")

local launch_ped_height = 20
menu.slider(NEARBY_PED, "????????????", { "launch_ped_height" }, "", 0, 1000, 20, 10, function(value)
    launch_ped_height = value
end)

local launch_ped_freeze = false
menu.toggle(NEARBY_PED, "??????NPC", {}, "", function(toggle)
    launch_ped_freeze = toggle
end)

menu.action(NEARBY_PED, "????????????", {}, "", function()
    for k, ped in ipairs(GET_NEARBY_PEDS(players.user(), radius_nearby_ped)) do
        if not IS_PED_PLAYER(ped) then
            if launch_ped_freeze then
                ENTITY.FREEZE_ENTITY_POSITION(ped, true)
            end
            local pos = ENTITY.GET_ENTITY_COORDS(ped)
            ENTITY.SET_ENTITY_COORDS(ped, pos.x, pos.y, pos.z + launch_ped_height, false, false, false, false)
        end
    end
end)

---
menu.divider(NEARBY_PED, "NPC????????????")

local see_range = 0.0
menu.slider(NEARBY_PED, "????????????", { "see_range" }, "", 0.0, 20.0, 0.0, 1.0, function(value)
    see_range = value
end)

local hear_range = 0.0
menu.slider(NEARBY_PED, "????????????", { "hear_range" }, "", 0.0, 20.0, 0.0, 1.0, function(value)
    hear_range = value
end)

local peripheral_range = 0.0
menu.slider(NEARBY_PED, "??????????????????", { "peripheral_range" }, "", 0.0, 20.0, 0.0, 1.0, function(value)
    peripheral_range = value
end)

local highly_perceptive = false
menu.toggle(NEARBY_PED, "???????????????", {}, "", function(toggle)
    highly_perceptive = toggle
end)

menu.action(NEARBY_PED, "??????", {}, "?????????????????????", function()
    for k, ped in ipairs(entities.get_all_peds_as_handles()) do
        if not IS_PED_PLAYER(ped) then
            PED.SET_PED_SEEING_RANGE(ped, see_range)
            PED.SET_PED_HEARING_RANGE(ped, hear_range)
            PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(ped, peripheral_range)
            PED.SET_PED_HIGHLY_PERCEPTIVE(ped, highly_perceptive)
        end
    end
end)

-- -- ????????????
local MISSION_ENTITY = menu.list(entity_options, "??????????????????", {}, "")

local MISSION_ENTITY_custom = menu.list(MISSION_ENTITY, "????????? Model Hash", {}, "")

local custom_model_hash
menu.text_input(MISSION_ENTITY_custom, "?????? Model Hash ", { "custom_model_hash" }, "", function(value)
    custom_model_hash = tonumber(value)
end)

local custom_all_entity = entities.get_all_peds_as_handles()
menu.slider_text(MISSION_ENTITY_custom, "????????????", {}, "??????????????????", { "Ped", "Vehicle", "Object", "Pickup" }, function(value)
    if value == 1 then
        custom_all_entity = entities.get_all_peds_as_handles()
        util.toast("Ped")
    elseif value == 2 then
        custom_all_entity = entities.get_all_vehicles_as_handles()
        util.toast("Vehicle")
    elseif value == 3 then
        custom_all_entity = entities.get_all_objects_as_handles()
        util.toast("Object")
    elseif value == 4 then
        custom_all_entity = entities.get_all_pickups_as_handles()
        util.toast("Pickup")
    end
end)

local custom_isMission_entity = true
menu.toggle(MISSION_ENTITY_custom, "IS A MISSION ENTITY", {}, "?????????????????????", function(toggle)
    custom_isMission_entity = toggle
end, true)

menu.divider(MISSION_ENTITY_custom, "????????????")

local custom_entity_tpme_x = 0.0
menu.slider(MISSION_ENTITY_custom, "?????????/????????????", { "custom_entity_tpme_x" }, "", -100.0, 100.0, 0.0, 1.0, function(value)
    custom_entity_tpme_x = value
end)

local custom_entity_tpme_y = 2.0
menu.slider(MISSION_ENTITY_custom, "?????????/????????????", { "custom_entity_tpme_y" }, "", -100.0, 100.0, 2.0, 1.0, function(value)
    custom_entity_tpme_y = value
end)

local custom_entity_tpme_z = 0.0
menu.slider(MISSION_ENTITY_custom, "?????????/????????????", { "custom_entity_tpme_z" }, "", -100.0, 100.0, 0.0, 1.0, function(value)
    custom_entity_tpme_z = value
end)

local custom_entity_tpme_head = 0.0
menu.slider(MISSION_ENTITY_custom, "head??????", { "custom_entity_tpme_head" }, "Not use", -360.0, 360.0, 0.0, 10.0, function(value)
    custom_entity_tpme_head = value
end)

menu.action(MISSION_ENTITY_custom, "????????????", {}, "", function()
    local flag = false
    if custom_model_hash then
        for k, ent in pairs(custom_all_entity) do
            local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
            if EntityHash == custom_model_hash then
                flag = true
                if custom_isMission_entity then
                    if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
                        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), custom_entity_tpme_x, custom_entity_tpme_y, custom_entity_tpme_z)
                        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
                    end
                else
                    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), custom_entity_tpme_x, custom_entity_tpme_y, custom_entity_tpme_z)
                    ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
                end
            end
        end

        if not flag then
            util.toast("No this entity !")
        end

    else
        util.toast("Wrong model hash !")
    end
end)

--- ---
local MISSION_ENTITY_cargo = menu.list(MISSION_ENTITY, "CEO??????", {}, "")

menu.action(MISSION_ENTITY_cargo, "??????????????? ????????????", {}, "????????????\nModel Hash: -265116550", function()
    local entity_model_hash = -265116550
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_cargo, "??????????????? ????????????", {}, "???????????????\nModel Hash: 1688540826", function()
    local entity_model_hash = 1688540826
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_cargo, "??????????????? ????????????", {}, "???????????????\n????????????\nModel Hash: -1143129136", function()
    local entity_model_hash = -1143129136
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_cargo, "???????????? ????????????", {}, "Trackify ??????????????????\nModel Hash: -1322183878", function()
    local entity_model_hash = -1322183878
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            if ENTITY.IS_ENTITY_ATTACHED(ent) then
                local attached_ent = ENTITY.GET_ENTITY_ATTACHED_TO(ent)
                local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
                ENTITY.SET_ENTITY_COORDS(attached_ent, coords.x, coords.y, coords.z, true, false, false, false)

                local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
                ENTITY.SET_ENTITY_HEADING(attached_ent, pHead + 90.0)
            end
        end
    end
end)

menu.action(MISSION_ENTITY_cargo, "TP to Special Cargo", { "scargo" }, "Teleport to Special Cargo pickup", function()
    local cPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(478))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(478))
    if cPickup.x == 0 and cPickup.y == 0 and cPickup.z == 0 then
        util.toast("No Cargo Found")
    else
        ENTITY.SET_ENTITY_COORDS(players.user_ped(), cPickup.x, cPickup.y, cPickup.z, false, false, false, false)
    end
end)

menu.action(MISSION_ENTITY_cargo, "TP to Vehicle Cargo", { "vcargo" }, "Teleport to Vehicle Cargo pickup", function()
    local vPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(523))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(523))
    if vPickup.x == 0 and vPickup.y == 0 and vPickup.z == 0 then
        util.toast("No Vehicle Found")
    else
        ENTITY.SET_ENTITY_COORDS(players.user_ped(), vPickup.x, vPickup.y, vPickup.z, false, false, false, false)
    end
end)

--- ---
local MISSION_ENTITY_perico = menu.list(MISSION_ENTITY, "????????????", {}, "")

menu.action(MISSION_ENTITY_perico, "???????????????????????? ????????????", {}, "\nModel Hash: 1981815996", function()
    local entity_model_hash = 1981815996
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)

            local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_HEADING(ent, pHead)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "???????????????????????? ????????????", {}, "\nModel Hash: 1650252819", function()
    local entity_model_hash = 1650252819
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, 1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)

            local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_HEADING(ent, pHead)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "???????????????????????? ????????????", {}, "\nModel Hash: -1141961823", function()
    local entity_model_hash = -1141961823
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "?????????????????????????????? ????????????", {}, "\nModel Hash: -710382954", function()
    local entity_model_hash = -710382954
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "????????????????????? ????????????", {}, "\nModel Hash: -1789904450", function()
    local entity_model_hash = -1789904450
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "??????????????????????????? ????????????", {}, "????????????npc????????????\nModel Hash: 2014313426", function()
    local entity_model_hash = 2014313426
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)
            if ped > 0 then
                -- has npc in truck
                if not IS_PED_PLAYER(ped) then
                    entity.delete_entity(ped)
                end
            end

            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 3.0, 0.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)

            local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_HEADING(ent, pHead + 90.0)
        end
    end
end)

--

menu.divider(MISSION_ENTITY_perico, "")

menu.action(MISSION_ENTITY_perico, "??????????????? ????????????", {}, "\nModel Hash: -1352468814", function()
    local entity_model_hash = -1352468814
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 7.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)

            local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_HEADING(ent, pHead + 180.0)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "???????????????????????? ???????????????", {}, "?????? ????????????\nModel Hash: -1109568186", function()
    local entity_model_hash = -1109568186
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, 0.0, 0.5)
            ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "????????????????????????????????? ????????????", {}, "\nModel Hash: -802406134", function()
    local entity_model_hash = -802406134
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 0.0, 2.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "???????????????????????? ????????????", {}, "????????????\nModel Hash: 1506325614", function()
    local entity_model_hash = 1506325614
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 0.0, 2.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "??????????????? ???????????????", {}, "??????\nModel Hash: 1871441709", function()
    local entity_model_hash = 1871441709
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, 0.0, 0.5)
            ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "??????????????? ???????????????", {}, "\nModel Hash: -1600252419", function()
    local entity_model_hash = -1600252419
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local pos = ENTITY.GET_ENTITY_COORDS(ent)
            FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, EXP_TAG_STICKYBOMB, 3.0, true, false, 0, false)
        end
    end
end)

--- ---
local MISSION_ENTITY_casion = menu.list(MISSION_ENTITY, "????????????", {}, "")

menu.action(MISSION_ENTITY_casion, "??????????????? ????????????", {}, "????????????\nModel Hash: -1094177627", function()
    local entity_model_hash = -1094177627
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, 10.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
            --ENTITY.SET_ENTITY_HEALTH(ent, 0.0)

            local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_HEADING(ent, pHead)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "???????????????(???) ????????????", {}, "?????????????????? ?????????????????????\nModel Hash: 1885839156", function()
    local entity_model_hash = 1885839156
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            if ENTITY.IS_ENTITY_ATTACHED(ent) then
                local attached_ent = ENTITY.GET_ENTITY_ATTACHED_TO(ent)
                local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
                ENTITY.SET_ENTITY_COORDS(attached_ent, coords.x, coords.y, coords.z, true, false, false, false)

                local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
                ENTITY.SET_ENTITY_HEADING(attached_ent, pHead + 90.0)
            end
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "??????????????? ????????????", {}, "???????????? ???????????????\nModel Hash: 798951501", function()
    local entity_model_hash = 798951501
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "???????????????(??????) ????????????", {}, "????????? ????????????\nModel Hash: 1043222410", function()
    --Model Hash: -1628917549 (PICKUP) ???????????????????????????
    local entity_model_hash = 1043222410
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 5.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "??????????????? ????????????", {}, "?????? ?????????\nModel Hash: 931280609", function()
    local entity_model_hash = 931280609
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)

            local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_HEADING(attached_ent, pHead + 90.0)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "????????????????????? ????????????", {}, "FIB?????? ???????????? ??????\n?????? ??????????????? ????????????????????????\nModel Hash: -155327337", function()
    local entity_model_hash = -155327337
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "????????????????????????(??????) ????????????", {}, "???????????? ?????? ??????\nModel Hash: 1456041926", function()
    local entity_model_hash = 1456041926
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "?????????????????????(???) ????????????", {}, "??????????????????????????????\nModel Hash: 1265214509", function()
    local entity_model_hash = 1265214509
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            if ENTITY.IS_ENTITY_ATTACHED(ent) then
                local attached_ent = ENTITY.GET_ENTITY_ATTACHED_TO(ent)
                local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 4.0, -1.0)
                ENTITY.SET_ENTITY_COORDS(attached_ent, coords.x, coords.y, coords.z, true, false, false, false)

                local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
                ENTITY.SET_ENTITY_HEADING(attached_ent, pHead)
            end
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "????????????????????? ????????????", {}, "????????? ??? ???\n????????????????????????\nModel Hash: -1671539132 1747439474 1448677353", function()
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
            if EntityHash == -1671539132 or EntityHash == 1747439474 or EntityHash == 1448677353 then
                local pos = ENTITY.GET_ENTITY_COORDS(ent)
                FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, EXP_TAG_STICKYBOMB, 3.0, true, false, 0, false)
            end
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "??????????????? ???????????????", {}, "?????? ?????????????????????\nModel Hash: -12990308", function()
    local entity_model_hash = -12990308
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, 0.0, 0.5)
            ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "????????????????????????(??????) ???????????????", {}, "?????? ?????? ???????????????\nModel Hash: 771433594", function()
    local entity_model_hash = 771433594
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, 0.0, 0.5)
            ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.divider(MISSION_ENTITY_casion, "????????????")

menu.action(MISSION_ENTITY_casion, "?????????????????? ????????????", {}, "???????????????\nModel Hash: 1657647215", function()
    -- -1285013058 ????????????????????????????????????pickup???
    local entity_model_hash = 1657647215
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, 0.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "???????????????????????? ????????????", {}, "\nModel Hash: 1953119208", function()
    local entity_model_hash = 1953119208
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.divider(MISSION_ENTITY_casion, "????????????")

menu.action(MISSION_ENTITY_casion, "??????????????????????????? ????????????", {}, "\nModel Hash: 1425667258", function()
    local entity_model_hash = 1425667258
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "???????????????????????? ????????????", {}, "????????????\nModel Hash: 415149220", function()
    local entity_model_hash = 415149220
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "???????????????????????? ????????????", {}, "?????????\nModel Hash: -1713985235", function()
    local entity_model_hash = -1713985235
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.divider(MISSION_ENTITY_casion, "????????????")

menu.action(MISSION_ENTITY_casion, "????????????????????? ????????????", {}, "\nModel Hash: -2043162923", function()
    local entity_model_hash = -2043162923
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "????????????????????? ????????????", {}, "??????????????? ????????????\nModel Hash: -681938663", function()
    local entity_model_hash = -681938663
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "???????????????????????? ????????????", {}, "?????? ??????\nModel Hash: 1715697304", function()
    local entity_model_hash = 1715697304
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, 0.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.divider(MISSION_ENTITY_casion, "")

menu.action(MISSION_ENTITY_casion, "??????????????????????????? ????????????", {}, "\nModel Hash: 1736112330", function()
    local entity_model_hash = 1736112330
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -0.5)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "???????????????????????????????????????", {}, "????????????????????????????????????\nModel Hash: 412463629, 1171655821, 1401432049", function()
    -- ????????? ??????list
    vault_trolley = {}
    local num = 0
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
            if EntityHash == 412463629 then
                num = num + 1
                table.insert(vault_trolley, ent)
            elseif EntityHash == 1171655821 then
                num = num + 1
                table.insert(vault_trolley, ent)
            elseif EntityHash == 1401432049 then
                num = num + 1
                table.insert(vault_trolley, ent)
            end
        end
    end
    util.toast("Number: " .. num)
    menu.set_max_value(menu_Vault_Trolley_TP, num)
end)

menu_Vault_Trolley_TP = menu.click_slider(MISSION_ENTITY_casion, "??????????????????????????? ????????????", {}, "", 0, 0, 0, 1, function(value)
    if value > 0 then
        local ent = vault_trolley[value]
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -0.5)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)

            local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_HEADING(ent, pHead + 180.0)
        else
            util.toast("???????????????")
        end
    end
end)

-------- All Type Mission Entities --------
menu.divider(MISSION_ENTITY, "??????????????????")

--- all entity type functions ---
function mission_entity_all(menu_parent, ent)
    menu.action(menu_parent, "???????????????????????????", {}, "", function()
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            util.toast("????????????")
        else
            util.toast("????????????????????????")
        end
    end)

    menu.toggle(menu_parent, "????????????", {}, "", function(toggle)
        ENTITY.FREEZE_ENTITY_POSITION(ent, toggle)
    end)

    menu.toggle_loop(menu_parent, "??????????????????", {}, "", function(toggle)
        local modelHash = ENTITY.GET_ENTITY_MODEL(ent)
        local entity_info = "Hash: " .. modelHash .. "\nHealth: " .. ENTITY.GET_ENTITY_HEALTH(ent)

        local pos = ENTITY.GET_ENTITY_COORDS(ent)
        entity_info = entity_info .. "\nX : " .. pos.x .. "\nY : " .. pos.y .. "\nZ : " .. pos.z

        local my_pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        entity_info = entity_info .. "\n??????: " .. vect.dist(my_pos, pos)

        directx.draw_text(0.5, 0.0, entity_info, ALIGN_TOP_LEFT, 0.7, 1, 0.8, 0, 1, true)
    end)

    menu.toggle(menu_parent, "?????????????????? (Entity)", {}, "", function(toggle)
        if toggle then
            local blip = HUD.GET_BLIP_FROM_ENTITY(ent)
            if blip > 0 then
                HUD.SET_BLIP_DISPLAY(blip, 2)
            else
                blip = HUD.ADD_BLIP_FOR_ENTITY(ent)
                HUD.SET_BLIP_COLOUR(blip, 27)
                --
                if ENTITY.IS_ENTITY_A_PED(ent) then
                    if PED.IS_PED_IN_COMBAT(ent, players.user_ped()) then
                        HUD.SET_BLIP_COLOUR(blip, 1)
                    end
                end
                --
                if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
                    local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)
                    if ped then
                        if PED.IS_PED_IN_COMBAT(ped, players.user_ped()) then
                            HUD.SET_BLIP_COLOUR(blip, 1)
                        end
                    end
                end
            end
        else
            local blip = HUD.GET_BLIP_FROM_ENTITY(ent)
            if blip > 0 then
                HUD.SET_BLIP_DISPLAY(blip, 0)
            end
        end
    end)

    --menu.action(menu_parent, "?????????????????? (Pickup)", {}, "", function()
    --    HUD.ADD_BLIP_FOR_PICKUP(ent)
    --end)
    --- ---
    menu.divider(menu_parent, "??????")
    menu.click_slider(menu_parent, "??????????????????", {}, "", -10, 10, 2, 1, function(value)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, value, 0.0)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.action(menu_parent, "???????????????", {}, "", function()
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, 0.0, 0.0)
        ENTITY.SET_ENTITY_COORDS(players.user_ped(), coords.x, coords.y, coords.z, true, false, false, false)
    end)
    --- ---
    menu.divider(menu_parent, "??????")
    menu.click_slider(menu_parent, "???/?????????", {}, "", -100, 100, 0, 1, function(value)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, value, 0.0)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.click_slider(menu_parent, "???/?????????", {}, "", -100, 100, 0, 1, function(value)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, value, 0.0, 0.0)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.click_slider(menu_parent, "???/?????????", {}, "", -100, 100, 0, 1, function(value)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, 0.0, value)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.click_slider(menu_parent, "??????", {}, "", -360, 360, 0, 10, function(value)
        local head = ENTITY.GET_ENTITY_HEADING(ent)
        ENTITY.SET_ENTITY_HEADING(ent, head + value)
    end)
end

----- NPC -----
local MISSION_ENTITY_all_npc = menu.list(MISSION_ENTITY, "????????????NPC", {}, "")
menu.action(MISSION_ENTITY_all_npc, "????????????NPC??????", {}, "", function()
    local mission_entity_num = 0
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        if not IS_PED_PLAYER(ent) and ent ~= PLAYER.PLAYER_PED_ID() then
            if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
                mission_entity_num = mission_entity_num + 1
            end
        end
    end
    util.toast("Number :" .. mission_entity_num)
end)

menu.click_slider(MISSION_ENTITY_all_npc, "????????????????????????", {}, "", -10, 10, 2, 1, function(value)
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        if not IS_PED_PLAYER(ent) and ent ~= PLAYER.PLAYER_PED_ID() then
            if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
                local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, value, 1.0)
                ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
                util.yield(1500) -- wait 1.5s
            end
        end
    end
end)

-- ??????????????????
mission_ent_npc_list = {}
-- ?????????????????????menu.list
mission_ent_npc_menu_list = {}

function Clear_mission_npc_list()
    for k, v in pairs(mission_ent_npc_menu_list) do
        if v ~= nil then
            menu.delete(v)
        end
    end
    -- ??????????????????
    mission_ent_npc_list = {}
    -- ?????????????????????menu.list
    mission_ent_npc_menu_list = {}
end

menu.action(MISSION_ENTITY_all_npc, "??????????????????NPC??????", {}, "", function()
    Clear_mission_npc_list()
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        if not IS_PED_PLAYER(ent) and ent ~= PLAYER.PLAYER_PED_ID() then
            if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
                table.insert(mission_ent_npc_list, ent)
                local modelHash = ENTITY.GET_ENTITY_MODEL(ent)
                local entity_info = "Hash: " .. modelHash
                if PED.IS_PED_IN_COMBAT(ent, PLAYER.PLAYER_ID()) then
                    entity_info = entity_info .. " (??????)"
                end
                local text = "index: " .. k
                ---
                menu_mission_entity_npc = menu.list(MISSION_ENTITY_all_npc, entity_info, {}, text)
                mission_entity_all(menu_mission_entity_npc, ent)
                table.insert(mission_ent_npc_menu_list, menu_mission_entity_npc)
            end
        end
    end
end)

menu.action(MISSION_ENTITY_all_npc, "????????????", {}, "", function()
    Clear_mission_npc_list()
end)

menu.divider(MISSION_ENTITY_all_npc, "??????NPC??????")

----- VEHICLE -----
local MISSION_ENTITY_all_vehicle = menu.list(MISSION_ENTITY, "??????????????????", {}, "")
menu.action(MISSION_ENTITY_all_vehicle, "????????????????????????", {}, "", function()
    local mission_entity_num = 0
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            mission_entity_num = mission_entity_num + 1
        end
    end
    util.toast("Number :" .. mission_entity_num)
end)

menu.click_slider(MISSION_ENTITY_all_vehicle, "????????????????????????", {}, "", -10, 10, 2, 1, function(value)
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        if not IS_PED_PLAYER(ent) and ent ~= PLAYER.PLAYER_PED_ID() then
            if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
                local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, value, 0.0)
                ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
                util.yield(1500) -- wait 1.5s
            end
        end
    end
end)

-- ??????????????????
mission_ent_vehicle_list = {}
-- ?????????????????????menu.list
mission_ent_vehicle_menu_list = {}

function Clear_mission_vehicle_list()
    for k, v in pairs(mission_ent_vehicle_menu_list) do
        if v ~= nil then
            menu.delete(v)
        end
    end
    -- ??????????????????
    mission_ent_vehicle_list = {}
    -- ?????????????????????menu.list
    mission_ent_vehicle_menu_list = {}
end

menu.action(MISSION_ENTITY_all_vehicle, "??????????????????????????????", {}, "", function()
    Clear_mission_vehicle_list()
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            table.insert(mission_ent_vehicle_list, ent)
            local modelHash = ENTITY.GET_ENTITY_MODEL(ent)
            local entity_info = "Hash: " .. modelHash
            local text = "index: " .. k
            ---
            menu_mission_entity_vehicle = menu.list(MISSION_ENTITY_all_vehicle, entity_info, {}, text)
            mission_entity_all(menu_mission_entity_vehicle, ent)
            table.insert(mission_ent_vehicle_menu_list, menu_mission_entity_vehicle)
        end
    end
end)

menu.action(MISSION_ENTITY_all_vehicle, "????????????", {}, "", function()
    Clear_mission_vehicle_list()
end)

menu.divider(MISSION_ENTITY_all_vehicle, "??????????????????")

----- OBJECT -----
local MISSION_ENTITY_all_object = menu.list(MISSION_ENTITY, "??????????????????", {}, "")
menu.action(MISSION_ENTITY_all_object, "????????????????????????", {}, "", function()
    local mission_entity_num = 0
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            mission_entity_num = mission_entity_num + 1
        end
    end
    util.toast("Number :" .. mission_entity_num)
end)

menu.click_slider(MISSION_ENTITY_all_object, "????????????????????????", {}, "", -10, 10, 2, 1, function(value)
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, value, 0.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
            util.yield(1500) -- wait 1.5s
        end
    end
end)

-- ??????????????????
mission_ent_object_list = {}
-- ?????????????????????menu.list
mission_ent_object_menu_list = {}

function Clear_mission_object_list()
    for k, v in pairs(mission_ent_object_menu_list) do
        if v ~= nil then
            menu.delete(v)
        end
    end
    -- ??????????????????
    mission_ent_object_list = {}
    -- ?????????????????????menu.list
    mission_ent_object_menu_list = {}
end

menu.action(MISSION_ENTITY_all_object, "??????????????????????????????", {}, "", function()
    Clear_mission_object_list()
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            table.insert(mission_ent_object_list, ent)
            local modelHash = ENTITY.GET_ENTITY_MODEL(ent)
            local entity_info = "Hash: " .. modelHash
            local text = "index: " .. k
            ---
            menu_mission_entity_object = menu.list(MISSION_ENTITY_all_object, entity_info, {}, text)
            mission_entity_all(menu_mission_entity_object, ent)
            table.insert(mission_ent_object_menu_list, menu_mission_entity_object)
        end
    end
end)

menu.action(MISSION_ENTITY_all_object, "????????????", {}, "", function()
    Clear_mission_object_list()
end)

menu.divider(MISSION_ENTITY_all_object, "??????????????????")

----- PICKUP -----
local MISSION_ENTITY_all_pickup = menu.list(MISSION_ENTITY, "?????????????????????", {}, "")
menu.action(MISSION_ENTITY_all_pickup, "???????????????????????????", {}, "", function()
    local mission_entity_num = 0
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            mission_entity_num = mission_entity_num + 1
        end
    end
    util.toast("Number :" .. mission_entity_num)
end)

menu.click_slider(MISSION_ENTITY_all_pickup, "????????????????????????", {}, "", -10, 10, 2, 1, function(value)
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, value, 0.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
            util.yield(1500) -- wait 1.5s
        end
    end
end)

-- ??????????????????
mission_ent_pickup_list = {}
-- ?????????????????????menu.list
mission_ent_pickup_menu_list = {}

function Clear_mission_pickup_list()
    for k, v in pairs(mission_ent_pickup_menu_list) do
        if v ~= nil then
            menu.delete(v)
        end
    end
    -- ??????????????????
    mission_ent_pickup_list = {}
    -- ?????????????????????menu.list
    mission_ent_pickup_menu_list = {}
end

menu.action(MISSION_ENTITY_all_pickup, "?????????????????????????????????", {}, "", function()
    Clear_mission_pickup_list()
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            table.insert(mission_ent_pickup_list, ent)
            local modelHash = ENTITY.GET_ENTITY_MODEL(ent)
            local entity_info = "Hash: " .. modelHash
            local text = "index: " .. k
            ---
            menu_mission_entity_pickup = menu.list(MISSION_ENTITY_all_pickup, entity_info, {}, text)
            mission_entity_all(menu_mission_entity_pickup, ent)
            table.insert(mission_ent_pickup_menu_list, menu_mission_entity_pickup)
        end
    end
end)

menu.action(MISSION_ENTITY_all_pickup, "????????????", {}, "", function()
    Clear_mission_pickup_list()
end)

menu.divider(MISSION_ENTITY_all_pickup, "?????????????????????")

---

menu.divider(entity_options, "")

----- ??????????????? -----
local isLog_entity_info = false
menu.toggle_loop(entity_options, "???????????????", {}, "?????????????????????????????????", function()
    local ent = GetEntity_PlayerIsAimingAt(players.user())
    if ent ~= NULL and ENTITY.DOES_ENTITY_EXIST(ent) then
        local entity_info = ""
        local modelHash = ENTITY.GET_ENTITY_MODEL(ent)
        entity_info = entity_info .. "Model Hash: " .. modelHash

        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            entity_info = entity_info .. "\nIS A MISSION ENTITY"
        end

        local entity_types = { "No entity", "Ped", "Vehicle", "Object" }
        local entity_type = ENTITY.GET_ENTITY_TYPE(ent)
        entity_info = entity_info .. "\nEntity Type: " .. entity_types[entity_type + 1]

        local entity_pop_types = {
            "POPTYPE_UNKNOWN",
            "POPTYPE_RANDOM_PERMANENT",
            "POPTYPE_RANDOM_PARKED",
            "POPTYPE_RANDOM_PATROL",
            "POPTYPE_RANDOM_SCENARIO",
            "POPTYPE_RANDOM_AMBIENT",
            "POPTYPE_PERMANENT",
            "POPTYPE_MISSION",
            "POPTYPE_REPLAY",
            "POPTYPE_CACHE",
            "POPTYPE_TOOL" }
        local entity_pop_type = ENTITY.GET_ENTITY_POPULATION_TYPE(ent)
        entity_info = entity_info .. "\nEntity Population Type: " .. entity_pop_types[entity_pop_type + 1]

        entity_info = entity_info .. "\nEntity Health: " .. ENTITY.GET_ENTITY_HEALTH(ent)

        -- object
        if entity_type == 3 then
            if OBJECT.IS_OBJECT_A_PICKUP(ent) then
                entity_info = entity_info .. "\n\nIS A PICKUP"
            end
            if OBJECT.IS_OBJECT_A_PORTABLE_PICKUP(ent) then
                entity_info = entity_info .. "\nIS A PORTABLE PICKUP"
            end
        end

        if ENTITY.IS_ENTITY_ATTACHED(ent) then
            entity_info = entity_info .. "\n\nIS ENTITY ATTACHED"

            local attached_entity = ENTITY.GET_ENTITY_ATTACHED_TO(ent)
            entity_info = entity_info .. "\nAttached Entity Model Hash :" .. ENTITY.GET_ENTITY_MODEL(attached_entity)
        end

        entity_info = entity_info .. "\n\nEntity Heading: " .. ENTITY.GET_ENTITY_HEADING(ent)
        local pos = ENTITY.GET_ENTITY_COORDS(ent)
        entity_info = entity_info .. "\nX : " .. pos.x .. "\nY : " .. pos.y .. "\nZ : " .. pos.z

        directx.draw_text(0.5, 0.0, entity_info, ALIGN_TOP_LEFT, 0.7, 1, 0.8, 0, 1, true)
        --util.toast(entity_info)
        -- ???????????????
        if isLog_entity_info then
            util.log(entity_info)
        end
    end
end)

menu.toggle(entity_options, "???????????????", {}, "", function(toggle)
    isLog_entity_info = toggle
end)

local function interpolate(y0, y1, perc)
	perc = perc > 1.0 and 1.0 or perc
	return (1 - perc) * y0 + perc * y1
end

local function get_health_colour(perc)
	local result = {a = 255}
	local r, g, b
	if perc <= 0.5 then
		r = 1.0
		g = interpolate(0.0, 1.0, perc/0.5)
		b = 0.0
	else
		r = interpolate(1.0, 0, (perc - 0.5)/0.5)
		g = 1.0
		b = 0.0
	end
	result.r = math.ceil(r * 255)
	result.g = math.ceil(g * 255)
	result.b = math.ceil(b * 255)
	return result
end

local function draw_marker(type, pos, dir, rot, scale, rotate, colour, txdDict, txdName)
    txdDict = txdDict or 0
    txdName = txdName or 0
    colour = colour or {r = 255, g = 255, b = 255, a = 255}
    GRAPHICS.DRAW_MARKER(type, pos.x, pos.y, pos.z, dir.x, dir.y, dir.z, rot.x, rot.y, rot.z, scale.x, scale.y, scale.z, colour.r, colour.g, colour.b, colour.a, false, true, 2, rotate, txdDict, txdName, false)
end

local function request_anim_set(set)
    while not STREAMING.HAS_ANIM_SET_LOADED(set) do
        STREAMING.REQUEST_ANIM_SET(set)
        util.yield()
    end
end


peds_root = menu.list(entity_options, "????????????", {"GTpeds"}, "")

local all_sex_voicenames = {
    "S_F_Y_HOOKER_01_WHITE_FULL_01",
    "S_F_Y_HOOKER_01_WHITE_FULL_02",
    "S_F_Y_HOOKER_01_WHITE_FULL_03",
    "S_F_Y_HOOKER_02_WHITE_FULL_01",
    "S_F_Y_HOOKER_02_WHITE_FULL_02",
    "S_F_Y_HOOKER_02_WHITE_FULL_03",
    "S_F_Y_HOOKER_03_BLACK_FULL_01",
    "S_F_Y_HOOKER_03_BLACK_FULL_03",
}

local function get_distance_between_entities(entity, target)
	if not ENTITY.DOES_ENTITY_EXIST(entity) or not ENTITY.DOES_ENTITY_EXIST(target) then
		return 0.0
	end
	local pos = ENTITY.GET_ENTITY_COORDS(entity, true)
	return ENTITY.GET_ENTITY_COORDS(target, true):distance(pos)
end

peds_thread = util.create_thread(function (thr)
    while true do
        if ped_uses > 0 then
            
            all_peds = entities.get_all_peds_as_handles()
            for k,ped in pairs(all_peds) do
                
                if not PED.IS_PED_A_PLAYER(ped) then

                    if make_peds_cops then 
                        PED.SET_PED_AS_COP(ped, true)
                    end

                    if ped_no_ragdoll then 
                        PED.SET_PED_CAN_RAGDOLL(ped, false)
                    end

                    if ped_godmode then 
                        ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
                    end

                    if hooker_esp then
                        local mdl = ENTITY.GET_ENTITY_MODEL(ped)
                        if PED.IS_PED_USING_SCENARIO(ped, "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS") or PED.IS_PED_USING_SCENARIO(ped,"WORLD_HUMAN_PROSTITUTE_LOW_CLASS") then 
                            util.draw_ar_beacon(ENTITY.GET_ENTITY_COORDS(ped))
                        end
                    end

                    if ped_no_crits then
                        PED.SET_PED_SUFFERS_CRITICAL_HITS(ped, false)
                    end

                    if ped_highperception then
                        PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
                        PED.SET_PED_HEARING_RANGE(ped, 1000.0)
                        PED.SET_PED_SEEING_RANGE(ped, 1000.0)
                        PED.SET_PED_VISUAL_FIELD_MIN_ANGLE(ped, 1000.0)
                    end

                    if ped_allcops then
                        PED.SET_PED_AS_COP(ped, true)
                    end

                    if ped_theflash then
                        PED.SET_PED_MOVE_RATE_OVERRIDE(ped, 10.0)
                    end

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

                    if ped_hardened then
                        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
                        PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
                        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
                        PED.SET_PED_ACCURACY(ped, 100)
                        PED.SET_PED_COMBAT_ABILITY(ped, 3)
                    end

                    if peds_ignore then
                        if not PED.GET_PED_CONFIG_FLAG(ped, 17, true) then
                            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
                            TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
                        end
                    end
                    if wantthesmoke then 
                        PED.SET_PED_AS_ENEMY(ped, true)
                        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
                        PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
                        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
                        TASK.TASK_COMBAT_PED(ped, players.user_ped(), 0, 16)
                    end

                    if apose_peds then 
                        if PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
                            TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
                        end
                        request_anim_set("move_crawl")
                        PED.SET_PED_MOVEMENT_CLIPSET(ped, "move_crawl", -1)
                    end

                    if roast_voicelines then
                        local roasts = {
                            "GENERIC_INSULT_MED",
                            "GENERIC_INSULT_HIGH"
                        }
                        AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(ped, roasts[math.random(#roasts)], "SPEECH_PARAMS_FORCE_SHOUTED")
                    end
    
                    if sex_voicelines then
                        local voice_name = all_sex_voicenames[math.random(1, #all_sex_voicenames)]
                        local speeches = {
                            "SEX_GENERIC_FEM",
                            "SEX_HJ",
                            "SEX_ORAL_FEM",
                            "SEX_CLIMAX",
                            "SEX_GENERIC"
                        }
                        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(ped, speeches[math.random(#speeches)], voice_name, "SPEECH_PARAMS_FORCE_SHOUTED", 0)
                    end
    
                    if screamall then
                        local screams = {
                            "SCREAM_SCARED",
                            "SCREAM_PANIC_SHORT",
                            "SCREAM_TERROR"

                        }
                        AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(ped, screams[math.random(#screams)], "SPEECH_PARAMS_FORCE_SHOUTED")
                    end

                    if php_bars and get_distance_between_entities(players.user_ped(), ped) < 100.0 and not PED.IS_PED_FATALLY_INJURED(ped) and ENTITY.IS_ENTITY_ON_SCREEN(ped) then
                        local headPos = PED.GET_PED_BONE_COORDS(ped, 0x322C --[[head]], 0.35, 0., 0.)
                        local perc = 0.0

                        if not PED.IS_PED_FATALLY_INJURED(ped) then
                            local maxHealth = PED.GET_PED_MAX_HEALTH(ped)
                            local health = ENTITY.GET_ENTITY_HEALTH(ped)
                            perc = (health - 100.0) / (maxHealth - 100.0)
                            if perc > 1.0 then perc = 1.0  end
                        end
                        
                        local colour = get_health_colour(perc)
                        local scale = v3.new(0.10, 0.0, interpolate(0.0, 0.7, perc))
                        draw_marker(43, headPos, v3(), v3(), scale, false, colour, 0, 0)
                    end

                    if allpeds_gun ~= 0 then
                        WEAPON.GIVE_WEAPON_TO_PED(ped, allpeds_gun, 9999, false, true)
                    end

                    -- ONLINE INTERACTIONS
                    if aped_combat then
                        local tar = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(combat_tar)
                        if not PED.IS_PED_IN_COMBAT(ped, tar) then 
                            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
                            PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
                            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
                            TASK.TASK_COMBAT_PED(ped, combat_tar, 0, 16)
                        end
                    end


                end
            end
        end
        util.yield()
    end
end)

local function get_model_size(hash)
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

    memory.free(minptr)
    memory.free(maxptr)

    return size
end

-- PEDS
ped_b_root = menu.list(peds_root, "??????", {"pedbehavior"}, "")
ped_attributes_root = menu.list(peds_root, "??????", {"pedattributes"}, "")
ped_voice = menu.list(peds_root, "??????", {"pedaudio"}, "")
ped_spawn = menu.list(peds_root, "??????", {"pedspawn"}, "")

local function request_anim_dict(dict)
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        STREAMING.REQUEST_ANIM_DICT(dict)
        util.yield()
    end
end

local function request_model_load(hash)
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

-- SPAWNING PEDS
num_peds_spawn = 1
local function spawn_ped(hash)
coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 3.0, 0.0)
local peds_spawned = {}
request_model_load(hash)
for i=1, num_peds_spawn do
    ped = entities.create_ped(28, hash, coords, math.random(0, 270))
    peds_spawned[#peds_spawned + 1] = ped
    if spawn_dancing then 
        local d = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity"
        request_anim_dict(d)
        TASK.TASK_PLAY_ANIM(ped, d, "hi_dance_facedj_13_v2_male^5", 1.0, 1.0, -1, 3, 0.5, false, false, false)
        PED.SET_PED_KEEP_TASK(ped, true)
    end
    if is_pet then
        all_pets[#all_pets + 1] = ped
        ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
        TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(ped, players.user_ped(), 0, -1, 0, 7.0, -1, 1, true)
        PED.SET_PED_COMBAT_ABILITY(ped, 3)
        PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
        local blip = HUD.ADD_BLIP_FOR_ENTITY(ped)
        HUD.SET_BLIP_COLOUR(blip, 11)
    end
end
return peds_spawned
end


all_pets = {}
local function spawn_pet(hash)
request_model_load(hash)
local c = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
local pet = entities.create_ped(28, hash, c, 0)
all_pets[#all_pets + 1] = pet
ENTITY.SET_ENTITY_INVINCIBLE(pet, true)
PED.SET_PED_COMPONENT_VARIATION(pet, 0, 0, 2, 0)
TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(pet, players.user_ped(), 0, -1, 0, 7.0, -1, 1, true)
PED.SET_PED_COMBAT_ABILITY(pet, 0)
PED.SET_PED_FLEE_ATTRIBUTES(pet, 0, true)
PED.SET_PED_COMBAT_ATTRIBUTES(pet, 46, false)
local blip = HUD.ADD_BLIP_FOR_ENTITY(pet)
HUD.SET_BLIP_COLOUR(blip, 11)
end

local custom_animal = "a_c_retriever"
menu.text_input(ped_spawn, "?????????????????????", {"customped"}, "???????????????????????????????????????????????????,??????????????????", function(on_input)
custom_animal = on_input
end, "a_c_retriever")


local animal_hashes = {1302784073, -1011537562, 802685111, util.joaat("a_c_chimp"), -1589092019, 1794449327, -664053099, -1920284487, util.joaat("a_c_retriever"), util.joaat('a_c_cow'), util.joaat("a_c_rabbit_01")}
local animal_options = {"?????????", "??????", "???", "?????????", "?????????", "??????", "???", "??????", "???", "??????", "??????", "?????????"}
menu.list_action(ped_spawn, "????????????", {"spawnped"}, "", animal_options, function(index, value, click_type)
if value == "?????????" then
    spawn_ped(util.joaat(custom_animal))
else
    spawn_ped(animal_hashes[index])
end
end)

menu.slider(ped_spawn, "????????????", {"pedspawnct"}, "???????????????", 1, 10, 1, 1, function(s)
num_peds_spawn = s
end)


is_pet = false
menu.toggle(ped_spawn, "??????????????????", {"spawnaspet"}, "??????????????????????????????.", function(on)
is_pet = on
end)

spawn_dancing = false
menu.toggle(ped_spawn, "??????????????????", {"spawndancing"}, "????????????????????????", function(on)
spawn_dancing = on
end)

local good_guns = {0, 453432689, 171789620, 487013001, -1716189206, 1119849093}
allpeds_gun = 0
local gun_options = {"??????", "??????", "?????????????????????", "?????????", "???", "?????????"}
menu.list_action(peds_root, "??????????????????", {"giveallpeds"}, "", gun_options, function(index, value, click_type)
if index == 1 then
    allpeds_gun = 0
else
    allpeds_gun = good_guns[index]
end
end)

menu.action(peds_root, "??????????????????", {"tpallpedshere"}, "", function(click_type)
local c = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
all_peds = entities.get_all_peds_as_handles()
for k,ped in pairs(all_peds) do
    if not PED.IS_PED_A_PLAYER(ped) then
        if PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
            TASK.TASK_LEAVE_ANY_VEHICLE(ped, 0, 16)
        end
        ENTITY.SET_ENTITY_COORDS(ped, c.x, c.y, c.z)
    end
end
end)

menu.action(peds_root, "??????????????????", {"stackallpeds"}, "", function(click_type)
local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
all_peds = entities.get_all_peds_as_handles()
local last_ped = 0
local last_ped_ht = 0
notification("????????????", colors.blue)
for k,ped in pairs(all_peds) do
    if not PED.IS_PED_A_PLAYER(ped) and not PED.IS_PED_FATALLY_INJURED(ped) then
        request_control_of_entity(ped)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
            TASK.TASK_LEAVE_ANY_VEHICLE(ped, 0, 16)
        end

        ENTITY.DETACH_ENTITY(ped, false, false)
        if last_ped ~= 0 then
            ENTITY.ATTACH_ENTITY_TO_ENTITY(ped, last_ped, 0, 0.0, 0.0, last_ped_ht-0.5, 0.0, 0.0, 0.0, false, false, false, false, 0, false)
        else
            ENTITY.SET_ENTITY_COORDS(ped, c.x, c.y, c.z)
        end
        last_ped = ped
        last_ped_ht = get_model_size(ENTITY.GET_ENTITY_MODEL(ped)).z
    end
end
end)


rain_peds = false
menu.toggle(peds_root, "?????????", {"rainpeds"}, "...", function(on)
rain_peds = on
mod_uses("ped", if on then 1 else -1)
end)

hooker_esp = false
menu.toggle(peds_root, "????????????", {"hookeresp"}, "...", function(on)
hooker_esp = on
mod_uses("ped", if on then 1 else -1)
end)



local function task_handler(type)
all_peds = entities.get_all_peds_as_handles()
player_ped = PLAYER.PLAYER_PED_ID()
for k,ped in pairs(all_peds) do
    if not PED.IS_PED_A_PLAYER(ped) then
        pluto_switch type do
            case "Flop":
                TASK.TASK_SKY_DIVE(ped)
                break
            case "Cover":
                TASK.TASK_STAY_IN_COVER(ped)
                break
            case "Writhe":
                TASK.TASK_WRITHE(ped, player_ped, -1, 0)
                break
            case "Vault":
                TASK.TASK_CLIMB(ped, true)
                break
            case "Cower":
                TASK.TASK_COWER(ped, -1)
                break
            case "Clear":
                TASK.CLEAR_PED_TASKS(ped)
                break
        end
    end
end
end

ped_no_ragdoll = false
menu.toggle(ped_attributes_root, "????????????", {"nopedragdoll"}, "", function(on)
ped_no_ragdoll = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_godmode = false
menu.toggle(ped_attributes_root, "??????", {"pedgodmode"}, "", function(on)
ped_godmode = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_no_crits = false
menu.toggle(ped_attributes_root, "????????????", {"nopedcrits"}, "", function(on)
ped_no_crits = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_highperception = false
menu.toggle(ped_attributes_root, "?????????", {"pedhighperception"}, "??????????????????????????????????????????", function(on)
ped_highperception = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_allcops = false
menu.toggle(ped_attributes_root, "???????????????????????????", {"pedallcops"}, "", function(on)
ped_allcops = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_theflash = false
menu.toggle(ped_attributes_root, "?????????", {"looney_tunes"}, "????????????????????????.", function(on)
ped_theflash = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_hardened = false
menu.toggle(ped_attributes_root, "???????????????", {"pedhardened"}, "?????????????????????,????????????????????????????????????????????????????????????????????????", function(on)
ped_hardened = on 
mod_uses("ped", if on then 1 else -1)
end)



local task_dict = {"flop", "cover", "vault"}
local task_options = {"????????????", "??????", "??????", "??????", "??????", "??????",}
menu.list_action(peds_root, "??????????????????", {"taskped"}, "", task_options, function(index, value, click_type)
task_handler(value)
end)

php_bars = false
menu.toggle(peds_root, "HP???", {"pedhpbars"}, "???NPC?????????????????????", function(on)
php_bars = on
mod_uses("ped", if on then 1 else -1)
if vhp_bars and on then
    notification("??????:????????????????????????HP??????????????????????????????,??????HP???????????????????????????", colors.blue)
end
end)

peds_ignore = false
menu.toggle(ped_b_root, "???????????????", {"obliviouspeds"}, "????????????????????????????????????????????????????????????????????????????????????????????????", function(on)
peds_ignore = on
mod_uses("ped", if on then 1 else -1)
end)

wantthesmoke = false
menu.toggle(ped_b_root, "???????????????", {"iwantthesmoke"}, "?????????????????????????????????????????????????????????????????????????????????", function(on)
wantthesmoke = on
mod_uses("ped", if on then 1 else -1)
end)

make_peds_cops = false
menu.toggle(ped_b_root, "??????????????????????????????", {"makecops"}, "????????????????????????????????????,???????????????????????????", function(on)
make_peds_cops = on
mod_uses("ped", if on then 1 else -1)
end)

menu.toggle(ped_b_root, "?????????", {"detroit"}, "???????????????NPC?????????????????????,????????????????????????????????????????????????,????????????????????????????????????,????????????,????????????????????????????????????????????????????????????????????????????????????????????????", function(on)
MISC.SET_RIOT_MODE_ENABLED(on)
end)

apose_peds = false
menu.toggle(ped_b_root, "A-??????", {"aposepeds"}, "???????????????", function(on)
apose_peds = on
mod_uses("ped", if on then 1 else -1)
end)

roast_voicelines = false
menu.toggle(ped_voice, "???????????????", {"npcroasts"}, "??????????????????", function(on)
roast_voicelines = on
mod_uses("ped", if on then 1 else -1)
end)

sex_voicelines = false
menu.toggle(ped_voice, "???????????????", {"sexlines"}, "oH FuCK YeAh", function(on)
sex_voicelines = on
mod_uses("ped", if on then 1 else -1)
end)

screamall = false
menu.toggle(ped_voice, "??????", {"screamall"}, "????????????????????????????????????????????????", function(on)
screamall = on
mod_uses("ped", if on then 1 else -1)
end)

vehicles_root = menu.list(entity_options, "????????????", {"lancescriptvehicles"}, "")

-- VEHICLES

v_phys_root = menu.list(vehicles_root, "????????????", {"vphysics"}, "??????????????????")
vc_root = menu.list(v_phys_root, "????????????", {"chaos"}, "?????????")
v_traffic_root = menu.list(vehicles_root, "????????????", {"traffic"}, "??????????????????")

local function get_closest_vehicle(entity)
    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
    local vehicles = entities.get_all_vehicles_as_handles()
    local closestdist = 1000000
    local closestveh = 0
    for k, veh in pairs(vehicles) do
        if veh ~= PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false) then
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

menu.action(vehicles_root, "????????????????????????", {"closestvehicle"}, "????????????????????????(????????????????????????????????????????????????)????????????,?????????????????????????????????????????????,???????????????????????????", function(on_click)
    local closestveh = get_closest_vehicle(players.user_ped())
    local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(closestveh, -1)
    if VEHICLE.IS_VEHICLE_SEAT_FREE(closestveh, -1) then
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, -1)
    else
        if not PED.IS_PED_A_PLAYER(driver) then
            entities.delete_by_handle(driver)
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, -1)
        elseif VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(closestveh) then
            for i=0, 10 do
                if VEHICLE.IS_VEHICLE_SEAT_FREE(closestveh, i) then
                    PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, i)
                end
            end
        else
            notification("???????????????????????????????????????:(", colors.blue)
        end
    end
end)

vehicle_chaos = false
menu.toggle(vc_root, "????????????", {"chaos"}, "", function(on)
    vehicle_chaos = on
    mod_uses("vehicle", if on then 1 else -1)
end)

vc_gravity = true
menu.toggle(vc_root, "??????????????????", {"chaosgravity"}, "?????????/???", function(on)
    vc_gravity = on
end, true)

vc_speed = 100
menu.slider(vc_root, "??????????????????", {"chaosspeed"}, "????????????????????????????????????=????????????", 30, 300, 100, 10, function(s)
  vc_speed = s
end)

vhp_bars = false
menu.toggle(vehicles_root, "???????????????", {"vehhpbars"}, "?????????????????????????????????", function(on)
    vhp_bars = on
    mod_uses("vehicle", if on then 1 else -1)
    if php_bars and on then
        notification("??????:??????????????????NPC?????????!??????????????????,????????????????????????????????????", colors.blue)
    end
end)

ascend_vehicles = false
menu.toggle(v_phys_root, "????????????????????????", {"ascendvehicles"}, "??????????????????????????????????????????,???????????????????????????????????????????????????????????????", function(on)
    ascend_vehicles = on
    mod_uses("vehicle", if on then 1 else -1)
end)

rain_vehicles = false
menu.toggle(v_phys_root, "?????????", {"rainvehicles"}, "", function(on)
    rain_vehicles = on
    mod_uses("vehicle", if on then 1 else -1)
end)

inferno = false
menu.toggle(v_phys_root, "?????????", {"inferno"}, "??????????????????????????????????????????????????????????????????????????????,???????????????????????????,???????????????????????????????????????", function(on)
    inferno = on
    mod_uses("vehicle", if on then 1 else -1)
end, false)

blackhole = false
menu.toggle(v_phys_root, "????????????", {"blackhole"}, "???????????????????????????????????????", function(on)
    blackhole = on
    mod_uses("vehicle", if on then 1 else -1)
    if on then
        holecoords = players.get_position(players.user())
        notification("??????????????????????????????????????????50??????????????????????????????????????????????????????", colors.blue)
    end
end)

hole_zoff = 50
menu.slider(v_phys_root, "??????Z?????????", {"blackholeoffset"}, "????????????????????????????????????????????????????????????????????????????????????", 0, 100, 50, 10, function(s)
    hole_zoff = s
  end)


beep_cars = false
menu.toggle(vehicles_root, "??????????????????????????????", {"beepvehicles"}, "?????????????????????????????????????????????????????????????????????", function(on)
    beep_cars = on
    mod_uses("vehicle", if on then 1 else -1)
end)

yeetsubmarines = false
menu.toggle(vehicles_root, "????????????", {"yeetsubs"},  "", function(on)
    yeetsubmarines = on
    mod_uses("vehicle", if on then 1 else -1)
end)

menu.action(vehicles_root, "????????????????????????", {"tpallvehshere"}, "", function(click_type)
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    all_vehs = entities.get_all_vehicles_as_handles()
    for k,veh in pairs(all_vehs) do
        if not PED.IS_PED_A_PLAYER(VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, false)) then
            ENTITY.SET_ENTITY_COORDS(veh, c.x, c.y, c.z)
        end
    end
end)


halt_traffic = false
menu.toggle(v_traffic_root, "????????????", {"halttraffic"}, "???????????????????????????????????????", function(on)
    halt_traffic = on
    mod_uses("vehicle", if on then 1 else -1)
end)

reverse_traffic = false
menu.toggle(v_traffic_root, "????????????", {"reversetraffic"}, "", function(on)
    reverse_traffic = on
    mod_uses("vehicle", if on then 1 else -1)
end)

vehicles_thread = util.create_thread(function (thr)
    while true do
        if vehicle_uses > 0 then
            
            all_vehicles = entities.get_all_vehicles_as_handles()
            for k,veh in pairs(all_vehicles) do
                if l_e_v_on then
                    local size = get_model_size(ENTITY.GET_ENTITY_MODEL(veh))
                    if size.x > l_e_max_x or size.y > l_e_max_y or size.z > l_e_max_y then
                        entities.delete_by_handle(veh)
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
end)

