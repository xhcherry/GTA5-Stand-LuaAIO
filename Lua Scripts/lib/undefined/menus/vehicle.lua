-- Undefined
local Utils<const> = require "undefined.utils"
local Vehicle<const> = require "undefined.vehicle"
local Player<const> = require "undefined.player"
local CONSTANTS<const> = require "undefined.constants"

local function driveNearestNPCVehicle()
    local playerPed = Player.getPlayerPed()
    local closestVehicle, driver = Vehicle.getClosestVehicleTo(playerPed, false)
    if not closestVehicle then
        Utils.showToast("附近没有发现载具,请生成一辆载具.")
        util.request_model(418536135)
        closestVehicle = entities.create_vehicle(418536135, Player.getPlayerPosition(), 0)
        util.yield(500)
    end

    if driver ~= -1 then
        entities.delete_by_handle(driver)
    end

    TASK.CLEAR_PED_TASKS_IMMEDIATELY(playerPed)
    PED.SET_PED_INTO_VEHICLE(playerPed, closestVehicle, -1)
    Vehicle.turnOnEngine(closestVehicle)
end

local function randomUpgrades()
    local playerVehicle = Vehicle.getCurrentVehicle()
    if playerVehicle == 0 then
        return
    end
    Vehicle.randomUpgradeForVehicle(playerVehicle)
end

local function clean()
    local playerVehicle = Vehicle.getCurrentVehicle()
    if playerVehicle == 0 then
        return
    end

    Vehicle.cleanVehicle(playerVehicle)
end

---@param speedUpBySlider CommandRef
local function speedUp(speedUpBySlider)
    local playerVehicle = Vehicle.getCurrentVehicle()
    if playerVehicle == 0 then
        return
    end

    local currentSpeed = ENTITY.GET_ENTITY_SPEED(playerVehicle)
    VEHICLE.SET_VEHICLE_FORWARD_SPEED(playerVehicle, currentSpeed + menu.get_value(speedUpBySlider) / 50)
end

local function stopVehicle()
    local playerVehicle = Vehicle.getCurrentVehicle()
    if playerVehicle == 0 then
        return
    end

    Vehicle.stop(playerVehicle)
end

---@param plateTextInput CommandRef
local function setLicensePlate(plateTextInput)
    local playerVehicle = Vehicle.getCurrentVehicle(true, true)
    if playerVehicle == 0 then
        return
    end
    Vehicle.setVehiclePlate(playerVehicle, menu.get_value(plateTextInput))
end

local function setupVehicleMenu()
    local vehicleMenu = menu.list(Undefined, "载具选项", {}, "有关载具的选项")

    if UND_privateMode then
        local setupPrivateMenu<const> = require "lib.undefined.menus.vehicle.private"
        setupPrivateMenu(vehicleMenu)
    end

    menu.action(vehicleMenu, "驾驶最近的NPC载具", {Utils.getCommandName("drivenearest")}, "传送你到最近的车辆，并自动启动引擎.",
        driveNearestNPCVehicle)

    menu.divider(vehicleMenu, "通用")
    menu.action(vehicleMenu, "随机升级", {Utils.getCommandName("randupgrade")}, "为您的车辆获取随机升级.", randomUpgrades)
    menu.action(vehicleMenu, "清洁", {Utils.getCommandName("clean")}, "清除汽车上的灰尘.", clean)

    menu.divider(vehicleMenu, "移动")
    local speedUpBySlider = menu.slider(vehicleMenu, "加速值", {Utils.getCommandName("speedupby")}, "用于加速的值.", 10, 100, 30, 10, Utils.emptyFunction)
    local speedUpToggle = menu.toggle_loop(vehicleMenu, "加速", {}, "按照上面选择的值加速车辆前进。使用快捷键来使用它.",
        function()
            speedUp(speedUpBySlider)
        end)
    menu.set_value(speedUpToggle, false)

    menu.action(vehicleMenu, "停止", {}, "立即停车.", stopVehicle)

    menu.divider(vehicleMenu, "车牌")
    local plateTextInput = menu.text_input(vehicleMenu, "自定义车牌文本", {Utils.getCommandName("platetext")},
        "当下面的选项被切换时，车牌将被更改为该文本.", Utils.emptyFunction, "UNDFD")
    menu.toggle_loop(vehicleMenu, "启用自定义车牌", {Utils.getCommandName("plateenable")},
        "在您乘坐的每辆车上，您的车牌将被更改为您在上面输入的文本.", function()
            setLicensePlate(plateTextInput)
        end)
end

return setupVehicleMenu
