-- Undefined
-- thanks to WiriScript for some raycasting logic
--==============狗白又看你爹脚本是吧
local CONSTANTS<const> = require "undefined.constants"
local Player<const> = require "undefined.player"
local Ped<const> = require "undefined.ped"
local Vehicle<const> = require "undefined.vehicle"
local Network<const> = require "undefined.network"
local Utils<const> = require "undefined.utils"

local Raycast = {}

---@class RaycastResult
---@field hit boolean
---@field coords v3
---@field entity Entity

---@class AimResult
---@field hit boolean
---@field coords v3
---@field entity Entity
---@field isPed boolean
---@field isVehicle boolean
---@field isObject boolean
---@field vehicle Vehicle | nil
---@field driver Ped | nil
---@field player Player | nil
---@field playerName string | nil

local aimLockEntity
local aimLockEndTime

local function aimLockEntityTicker()
    if not aimLockEndTime then
        return
    end
    if not UND_aimLockEnabled or not ENTITY.DOES_ENTITY_EXIST(aimLockEntity.entity) or (UND_aimLockTime > 0 and Utils.getTime() >= aimLockEndTime) then
        aimLockEntity = nil
        aimLockEndTime = nil
        return
    end
end

local function resetAimLockTime()
    if not aimLockEndTime then
        aimLockEndTime = Utils.getTime(UND_aimLockTime * 1000)
    end
end

---@param dist integer
---@return v3, v3
function Raycast.getOffsetFromCam(dist)
    local rot<const> = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local pos<const> = CAM.GET_GAMEPLAY_CAM_COORD()
    local dir = rot:toDir()
    dir:mul(dist)
    local offset = v3.new(pos)
    offset:add(dir)
    return pos, offset
end

---@return RaycastResult
local function getRaycastData()
    local dist<const> = 1000
    local result = {}
    local hit = memory.alloc(1)
    local coords = v3.new()
    local normal = v3.new()
    local entity = memory.alloc_int()
    local camPos<const>, offset<const> = Raycast.getOffsetFromCam(dist)

    local handle<const> = SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(camPos.x, camPos.y, camPos.z, offset.x, offset.y, offset.z, CONSTANTS.RAYCAST.TraceFlag.all,
        players.user_ped(), 4)
    SHAPETEST.GET_SHAPE_TEST_RESULT(handle, hit, coords, normal, entity)

    result.hit = memory.read_byte(hit) ~= 0
    result.entity = memory.read_int(entity)
    result.coords = coords

    return result
end

---@param flag integer
---@return RaycastResult
local function getAimData(flag)
    local allFlag<const> = flag == CONSTANTS.RAYCAST.TraceFlag.all
    local pedFlag<const> = flag == CONSTANTS.RAYCAST.TraceFlag.peds or flag == CONSTANTS.RAYCAST.TraceFlag.all
    local vehicleFlag<const> = flag == CONSTANTS.RAYCAST.TraceFlag.vehicles or flag == CONSTANTS.RAYCAST.TraceFlag.all
    local success = false
    local result = {}

    if WEAPON.GET_MAX_RANGE_OF_CURRENT_PED_WEAPON(Player.getPlayerPed()) < 130.0 then
        return getRaycastData()
    end

    local entityPointer = memory.alloc_int()
    PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), entityPointer)

    local entity = memory.read_int(entityPointer)

    local entityType = ENTITY.GET_ENTITY_TYPE(entity)
    if entityType == 1 then
        if PED.IS_PED_IN_ANY_VEHICLE(entity, false) then
            if pedFlag and not allFlag then
                return getRaycastData()
            end
            entity = PED.GET_VEHICLE_PED_IS_IN(entity)
            success = true
        elseif pedFlag then
            success = true
        end
    elseif entityType == 2 and vehicleFlag then
        success = true
    end

    if success then
        result.hit = true
        result.entity = entity
        result.coords = ENTITY.GET_ENTITY_COORDS(entity)
        return result
    end

    return getRaycastData()
end

---@param flag? integer
---@param isAimTeleport? boolean
---@return AimResult | nil
function Raycast.getPlayerAimData(flag, isAimTeleport)
    flag = flag or CONSTANTS.RAYCAST.TraceFlag.all
    local pedFlag = flag == CONSTANTS.RAYCAST.TraceFlag.peds
    local vehFlag = flag == CONSTANTS.RAYCAST.TraceFlag.vehicles
    local objFlag = flag == CONSTANTS.RAYCAST.TraceFlag.objects
    if not Player.isUserAiming() then
        if aimLockEntity then
            if pedFlag and not aimLockEntity.isPed then
                return nil
            end
            if vehFlag and not aimLockEntity.isVehicle then
                return nil
            end
            if objFlag and not aimLockEntity.isObject then
                return nil
            end

            if not aimLockEntity.isObject then
                resetAimLockTime()
            end
        end
        return aimLockEntity
    end

    local aimResult = getAimData(CONSTANTS.RAYCAST.TraceFlag.all)

    local isVehicle = ENTITY.IS_ENTITY_A_VEHICLE(aimResult.entity) and not VEHICLE.IS_THIS_MODEL_A_TRAIN(ENTITY.GET_ENTITY_MODEL(aimResult.entity))
    local isPed = ENTITY.IS_ENTITY_A_PED(aimResult.entity)
    local pCoords = Player.getPlayerPosition()
    local entCoords = ENTITY.GET_ENTITY_COORDS(aimResult.entity)
    local isObject = ENTITY.IS_ENTITY_AN_OBJECT(aimResult.entity) and v3.distance(pCoords, entCoords) < 50

    if not isVehicle and not isPed and not isObject then
        local closePed = Ped.getClosestPedToCoords(aimResult.coords)
        if closePed then
            aimResult.entity = closePed
            aimResult.hit = true
            isPed = true
        else
            local closeVehicle = Vehicle.getClosestVehicleToCoords(aimResult.coords, true)
            if closeVehicle then
                aimResult.entity = closeVehicle
                aimResult.hit = true
                isVehicle = true
            end
        end
    end

    if isAimTeleport and not aimResult.hit then
        return nil
    end

    if pedFlag and not isPed then
        return nil
    end
    if vehFlag and not isVehicle then
        return nil
    end
    if objFlag and not isObject then
        return nil
    end

    aimResult.isPed = isPed
    aimResult.isVehicle = isVehicle
    aimResult.isObject = isObject
    aimResult.player = nil

    if isPed then
        local player = Network.getPlayerFromPed(aimResult.entity)
        if player ~= -1 then
            aimResult.player = player
            aimResult.playerName = Player.getPlayerName(player, false, true)
        end
    end

    if isPed or isVehicle or isObject then
        aimResult.coords = entCoords
        if not isObject and UND_aimLockEnabled then
            aimLockEntity = aimResult
            aimLockEndTime = nil
        end
    end

    if isVehicle then
        aimResult.vehicle = ENTITY.GET_VEHICLE_INDEX_FROM_ENTITY_INDEX(aimResult.entity)
        local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(aimResult.vehicle, -1, true)
        if driver ~= 0 then
            aimResult.driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(aimResult.vehicle, -1, true)
            local player = Network.getPlayerFromPed(aimResult.driver)
            if player ~= -1 then
                aimResult.player = player
                aimResult.playerName = Player.getPlayerName(player, false, true)
            end
        end
    end

    return aimResult
end

util.create_tick_handler(aimLockEntityTicker)

return Raycast
