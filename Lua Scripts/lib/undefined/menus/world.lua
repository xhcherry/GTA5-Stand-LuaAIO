-- Undefined
local Utils<const> = require "undefined.utils"
local Vehicle<const> = require "undefined.vehicle"

---@param vehiclesToggle CommandRef
---@param pedsToggle CommandRef
---@param objectsToggle CommandRef
local function clearArea(vehiclesToggle, pedsToggle, objectsToggle)
    local vehiclesEnabled = menu.get_value(vehiclesToggle)
    local pedsEnabled = menu.get_value(pedsToggle)
    local objectsEnabled = menu.get_value(objectsToggle)
    if not vehiclesEnabled and not pedsEnabled and not objectsEnabled then
        Utils.showToast("您没有选择任何要清除的实体.")
    end

    Utils.showToast("正在清除，请稍候...")
    if pedsEnabled then
        local peds = entities.get_all_peds_as_handles()
        for _, ped in peds do
            entities.delete_by_handle(ped)
        end
    end

    if vehiclesEnabled then
        local vehicles = entities.get_all_vehicles_as_handles()
        local currentVehicle = Vehicle.getCurrentVehicle(true, true)
        for _, vehicle in vehicles do
            if currentVehicle ~= vehicle then
                local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false)
                local playerIndex = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(driver)
                if playerIndex == -1 then
                    entities.delete_by_handle(vehicle)
                end
            end
        end
    end

    if objectsEnabled then
        local objects = entities.get_all_objects_as_handles()
        for _, object in objects do
            entities.delete_by_handle(object)
        end
    end

    Utils.showToast("OK.")
end

local function setupWorldMenu()
    local worldMenu = menu.list(Undefined, "世界选项", {}, "世界选项")

    local clearAreaSettings = menu.list(worldMenu, "清除区域设置", {}, "清除区域动作的设置.")
    local removeVehiclesToggle = menu.toggle(clearAreaSettings, "车辆", {}, "清除所有车辆，不包括玩家和您的车辆.", function()

    end, true)
    local removePedsToggle = menu.toggle(clearAreaSettings, "NPC", {}, "清除除玩家外的所有NPC捏.", function()

    end, true)
    local removeObjectsToggle = menu.toggle(clearAreaSettings, "物体", {}, "清除所有物体.", function()

    end, true)
    menu.action(worldMenu, "清除区域", {Utils.getCommandName("cleararea")}, "从您选择的所有实体中清除附近区域.", function()
        clearArea(removeVehiclesToggle, removePedsToggle, removeObjectsToggle)
    end)
end

return setupWorldMenu
