-- Undefined
--==============狗白又看你爹脚本是吧
local Player = require "undefined.player"
local Ped = require "undefined.ped"
local Network = require "undefined.network"
local Utils = require "undefined.utils"

local Vehicle = {}

---@param vehicle Vehicle
---@param text string
function Vehicle.setVehiclePlate(vehicle, text)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, text)
end

---@param vehicle Vehicle
function Vehicle.repairVehicle(vehicle)
    if not Network.requestControl(vehicle) then
        return
    end
    VEHICLE.SET_VEHICLE_FIXED(vehicle)
    VEHICLE.SET_VEHICLE_DEFORMATION_FIXED(vehicle)
    VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, 1000)
end

---@param vehicle Vehicle
---@param on boolean
function Vehicle.toggleVehicleGodMode(vehicle, on)
    if not Network.requestControl(vehicle) then
        return
    end

    if on then
        VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, 0.0)
        VEHICLE.SET_VEHICLE_BODY_HEALTH(vehicle, 1000.0)
        VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, 1000.0)
        VEHICLE.SET_VEHICLE_FIXED(vehicle)
        VEHICLE.SET_VEHICLE_DEFORMATION_FIXED(vehicle)
        VEHICLE.SET_VEHICLE_PETROL_TANK_HEALTH(vehicle, 1000.0)
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, 0.0)
        for i = 0, 10 do
            VEHICLE.SET_VEHICLE_TYRE_FIXED(vehicle, i)
        end
    end
    ENTITY.SET_ENTITY_CAN_BE_DAMAGED(vehicle, on)
    ENTITY.SET_ENTITY_INVINCIBLE(vehicle, on)
    ENTITY.SET_ENTITY_PROOFS(vehicle, on, on, on, on, on, on, true, on)
    VEHICLE.SET_DISABLE_VEHICLE_PETROL_TANK_DAMAGE(vehicle, on)
    VEHICLE.SET_DISABLE_VEHICLE_PETROL_TANK_FIRES(vehicle, on)
    VEHICLE.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(vehicle, not on)
    VEHICLE.SET_VEHICLE_CAN_BREAK(vehicle, not on)
    VEHICLE.SET_VEHICLE_ENGINE_CAN_DEGRADE(vehicle, not on)
    VEHICLE.SET_VEHICLE_EXPLODES_ON_HIGH_EXPLOSION_DAMAGE(vehicle, not on)
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, not on)
    VEHICLE.SET_VEHICLE_WHEELS_CAN_BREAK(vehicle, not on)
end

---@param vehicle Vehicle
function Vehicle.cleanVehicle(vehicle)
    GRAPHICS.REMOVE_DECALS_FROM_VEHICLE(vehicle)
    VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, 0.0)
end

---@param vehicle Vehicle
---@param cloneVehicle Vehicle
function Vehicle.copyVehicleData(vehicle, cloneVehicle)
    VEHICLE.SET_VEHICLE_MOD_KIT(cloneVehicle, 0)

    for x = 0, 49 do
        local modValue = VEHICLE.GET_VEHICLE_MOD(vehicle, x)
        VEHICLE.SET_VEHICLE_MOD(cloneVehicle, x, modValue)
    end

    local windowTint = VEHICLE.GET_VEHICLE_WINDOW_TINT(vehicle)
    VEHICLE.SET_VEHICLE_WINDOW_TINT(cloneVehicle, windowTint)

    local colorCombination = VEHICLE.GET_VEHICLE_COLOUR_COMBINATION(vehicle)
    VEHICLE.SET_VEHICLE_COLOUR_COMBINATION(cloneVehicle, colorCombination)

    local plateType = VEHICLE.GET_VEHICLE_PLATE_TYPE(vehicle)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(cloneVehicle, plateType)

    local plateText = VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT(vehicle)
    Vehicle.setVehiclePlate(cloneVehicle, plateText)
end

---@return integer
local function getRandomColor()
    local colorRanges = {{0, 30}, {31, 60}, {61, 90}, {91, 120}, {121, 150}, {151, 161}}
    local colorRange = colorRanges[math.floor(Utils.rand(1000, 6000) / 1000)]
    local color = Utils.rand(colorRange[1], colorRange[2])
    return color
end

---@param vehicle Vehicle
function Vehicle.randomUpgradeForVehicle(vehicle)
    if not Network.requestControl(vehicle) then
        return
    end

    VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
    for x = 0, 49 do
        local max = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, x)
        VEHICLE.SET_VEHICLE_MOD(vehicle, x, Utils.rand(0, max))
    end
    VEHICLE.SET_VEHICLE_MOD(vehicle, 15, Utils.rand(0, 51))
    VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, Utils.rand(0, 5))

    local pearlscent = false
    if Utils.rand() == 1 then
        pearlscent = true
    end

    VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, Utils.rand(0, 6), getRandomColor(), pearlscent)
    VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, Utils.rand(0, 6), getRandomColor())
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, Utils.rand(0, 255), Utils.rand(0, 255), Utils.rand(0, 255))
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, Utils.rand(0, 5))
    VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vehicle, Utils.rand(0, 12))
    for x = 17, 22 do
        VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, x, true)
    end

    Vehicle.cleanVehicle(vehicle)
end

---@param dontShowError? boolean
---@param noRequest? boolean
---@return Vehicle, boolean
function Vehicle.getCurrentVehicle(dontShowError, noRequest)
    local function notInVehicle()
        if not dontShowError then
            Utils.showToast("您不在车辆中.")
        end
    end

    if not PED.IS_PED_IN_ANY_VEHICLE(Player.getPlayerPed(), false) then
        notInVehicle()
        return 0
    end

    local playerVehicle = entities.get_user_vehicle_as_handle()
    if playerVehicle == 0 then
        notInVehicle()
        return 0
    end

    local vehiclePointer = entities.get_user_vehicle_as_pointer()
    local vehicleOwnerId = entities.get_owner(vehiclePointer)

    if vehicleOwnerId == Player.getUserPlayer() or noRequest or Network.requestControl(playerVehicle, nil, dontShowError) then
        return playerVehicle
    end
    return 0, true
end

---@param player Player
---@return Vehicle
function Vehicle.getPlayerVehicle(player)
    local function notInVehicle()
        Utils.showToast(Player.getPlayerName(player) .. " 不在车辆中.")
    end

    local playerPed = Player.getPlayerPed(player)

    if not PED.IS_PED_IN_ANY_VEHICLE(playerPed, false) then
        notInVehicle()
        return 0
    end

    local playerVehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed, false)
    if playerVehicle == 0 then
        notInVehicle()
        return 0
    end

    local vehicleDriver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(playerVehicle, -1, false)

    if vehicleDriver == Player.getUserPlayer() or Network.requestControl(playerVehicle) then
        return playerVehicle
    end
    return 0
end

---@param noRequest? boolean
---@return Vehicle | nil | Ped
function Vehicle.getPlayerOrVehicleEntity(noRequest)
    local vehicle, noAccess = Vehicle.getCurrentVehicle(true, noRequest)
    if vehicle ~= 0 then
        return vehicle
    end

    if noAccess and not noRequest then
        Utils.showToast("无法访问车辆.")
        return nil
    end

    return Player.getPlayerPed()
end

---@class VehicleData
---@field vehicle Vehicle
---@field driver Ped
---@field player Player

---@param entity Entity
---@return VehicleData
function Vehicle.getTargetVehicleData(entity)
    local vehicle = ENTITY.GET_VEHICLE_INDEX_FROM_ENTITY_INDEX(entity)
    local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, true)
    local player = Network.getPlayerFromPed(driver)
    local result = {}
    result.vehicle = vehicle
    result.driver = driver
    result.player = player
    return result
end

---@param entity Entity
---@param includePlayerVehicles boolean
---@return Vehicle, Ped
function Vehicle.getClosestVehicleTo(entity, includePlayerVehicles)
    local coords<const> = ENTITY.GET_ENTITY_COORDS(entity, true)
    local vehicles<const> = entities.get_all_vehicles_as_handles()
    local maxDistance = 10000
    local closestVehicle
    local driver = -1

    local curVehicle = PED.IS_PED_IN_ANY_VEHICLE(Player.getPlayerPed(), false) and PED.GET_VEHICLE_PED_IS_IN(Player.getPlayerPed(), false)

    for _, vehicle in vehicles do
        local modelHash<const> = ENTITY.GET_ENTITY_MODEL(vehicle)
        if vehicle ~= curVehicle and not ENTITY.IS_ENTITY_DEAD(vehicle) and ENTITY.IS_ENTITY_VISIBLE(vehicle) and VEHICLE.IS_VEHICLE_DRIVEABLE(vehicle, true) and
            not VEHICLE.IS_THIS_MODEL_A_TRAIN(modelHash) and not util.is_this_model_a_trailer(modelHash) and Network.requestControlOnce(vehicle) then
            local vehicleData<const> = Vehicle.getTargetVehicleData(vehicle)

            if vehicleData.player == -1 or includePlayerVehicles then
                local vehicleCoords<const> = ENTITY.GET_ENTITY_COORDS(vehicle, true)
                local distance<const> = v3.distance(coords, vehicleCoords)
                if distance < maxDistance then
                    maxDistance = distance
                    closestVehicle = vehicle
                    driver = vehicleData.driver
                end
            end
        end
    end
    return closestVehicle, driver
end

---@param coords v3
---@param includePlayerVehicles boolean
---@return Vehicle, Ped
function Vehicle.getClosestVehicleToCoords(coords, includePlayerVehicles)
    local vehicles<const> = entities.get_all_vehicles_as_handles()
    local maxDistance = 5
    local closestVehicle
    local driver = -1

    local curVehicle = PED.IS_PED_IN_ANY_VEHICLE(Player.getPlayerPed(), false) and PED.GET_VEHICLE_PED_IS_IN(Player.getPlayerPed(), false)

    for _, vehicle in vehicles do
        local modelHash<const> = ENTITY.GET_ENTITY_MODEL(vehicle)
        if vehicle ~= curVehicle and not VEHICLE.IS_THIS_MODEL_A_TRAIN(modelHash) then
            local vehicleData<const> = Vehicle.getTargetVehicleData(vehicle)

            if vehicleData.player == -1 or includePlayerVehicles then
                local vehicleCoords<const> = ENTITY.GET_ENTITY_COORDS(vehicle, true)
                local distance<const> = v3.distance(coords, vehicleCoords)
                if distance < maxDistance then
                    maxDistance = distance
                    closestVehicle = vehicle
                    driver = vehicleData.driver
                end
            end
        end
    end
    return closestVehicle, driver
end

---@param entity Entity
---@param direction string
function Vehicle.launch(entity, direction)
    if not Network.requestControl(entity) then
        return
    end

    if direction == "down" then
        ENTITY.SET_ENTITY_VELOCITY(entity, 0, 0, -1000)
    elseif direction == "up" then
        ENTITY.SET_ENTITY_VELOCITY(entity, 0, 0, 1000)
    elseif direction == "forward" then
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(entity, 200.0)
    else
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(entity, -200.0)
    end
end

---@param vehicle Vehicle
function Vehicle.empty(vehicle)
    local maxPassengers = VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(vehicle)
    for i = -1, maxPassengers do
        if not VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, i, false) then
            local pedToKick = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, i, false)
            Ped.kickFromVehicle(pedToKick)
        end
    end
end

---@param entity Entity
function Vehicle.spin(entity)
    if not Network.requestControl(entity) then
        return
    end

    ENTITY.SET_ENTITY_ANGULAR_VELOCITY(entity, 0, 0, 6000)
    util.yield(300)
    ENTITY.SET_ENTITY_ANGULAR_VELOCITY(entity, 0, 0, 3000)
end

---@param entity Entity
function Vehicle.flip(entity)
    if not Network.requestControl(entity) then
        return
    end

    local curRotation = ENTITY.GET_ENTITY_ROTATION(entity, 2)
    ENTITY.SET_ENTITY_ROTATION(entity, curRotation.x, curRotation.y + 180, curRotation.z, 2, true)
end

---@param vehicle Vehicle
function Vehicle.stop(vehicle)
    if not Network.requestControl(vehicle) then
        return
    end

    VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, 0)
end

---@param vehicle Vehicle
function Vehicle.putOnWheels(vehicle)
    if not Network.requestControl(vehicle) then
        return
    end

    VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(vehicle, 5.0)
end

---@param vehicle Vehicle
function Vehicle.turnOffEngine(vehicle)
    if not Network.requestControl(vehicle) then
        return
    end

    VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, false, true, false)
    VEHICLE.BRING_VEHICLE_TO_HALT(vehicle, 3.0, 1)
end

---@param vehicle Vehicle
---@return Vehicle
function Vehicle.clone(vehicle)
    local vehicleHeading = ENTITY.GET_ENTITY_HEADING(vehicle)
    local vehicleHash = ENTITY.GET_ENTITY_MODEL(vehicle)
    local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
    coords.y = coords.y + 3
    local cloneVehicle = entities.create_vehicle(vehicleHash, coords, vehicleHeading)
    Vehicle.copyVehicleData(vehicle, cloneVehicle)
    return cloneVehicle
end

---@param vehicle Vehicle
function Vehicle.delete(vehicle)
    entities.delete_by_handle(vehicle)
end

---@param vehicle Vehicle
function Vehicle.killEngine(vehicle)
    if not Network.requestControl(vehicle) then
        return
    end

    VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, -4000)
end

---@param vehicle Vehicle
function Vehicle.burn(vehicle)
    if not Network.requestControl(vehicle) then
        return
    end

    VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, -1)
end

---@param vehicle Vehicle
---@param lockDoors boolean
function Vehicle.sink(vehicle, lockDoors)
    if not Network.requestControl(vehicle) then
        return
    end

    if lockDoors then
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 4)
    end
    ENTITY.SET_ENTITY_COORDS(vehicle, -9725, -7276, -100, false, false, false, false)
end

---@param vehicle Vehicle
function Vehicle.explode(vehicle)
    Vehicle.killEngine(vehicle)
    local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
    FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z + 1.0, 4, 100, true, false, 0.5)
end

---@param vehicle Vehicle
function Vehicle.slick(vehicle)
    local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
    FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z + 1.0, 67, 100, true, false, 0)
end

---@param vehicle Vehicle
function Vehicle.bump(vehicle)
    local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
    FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z + 1.0, 64, 1, true, true, 0)
end

---@param vehicle Vehicle
function Vehicle.emp(vehicle)
    local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
    FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z + 1.0, 83, 1, true, false, 0)
end

---@param vehicle Vehicle
function Vehicle.damage(vehicle)
    if not Network.requestControl(vehicle) then
        return
    end

    VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, 300)
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, true)

    for i = 0, 7 do
        VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, i, true, 1000)
    end

    for i = 0, 7 do
        VEHICLE.SMASH_VEHICLE_WINDOW(vehicle, i)
    end
end

---@param vehicle Vehicle
function Vehicle.turnOnEngine(vehicle)
    if not Network.requestControl(vehicle) then
        return
    end

    VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, false)
end

---@param vehicle Vehicle
---@param pid? Player
function Vehicle.tpToPlayer(vehicle, pid)
    if not Network.requestControl(vehicle) then
        return
    end

    pid = pid or Player.getUserPlayer()
    local pCoords = Player.getPlayerPosition(pid)
    ENTITY.SET_ENTITY_COORDS(vehicle, pCoords.x, pCoords.y + 5, pCoords.z, false, false, false)
end

---@param vehicle Vehicle
function Vehicle.tpToVehicle(vehicle)
    local entCoords = ENTITY.GET_ENTITY_COORDS(vehicle)
    local entityToTeleport = Vehicle.getPlayerOrVehicleEntity()
    if not entityToTeleport then
        return
    end

    ENTITY.SET_ENTITY_COORDS(entityToTeleport, entCoords.x, entCoords.y, entCoords.z + 5, false, false, false, false)
end

return Vehicle
