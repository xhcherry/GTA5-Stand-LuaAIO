-- Undefined
--==============狗白又看你爹脚本是吧
local Vehicle<const> = require "undefined.vehicle"

---@param vehicleSubmenu CommandRef
---@param pid Player
local function setupPlayerVehicleMenu(vehicleSubmenu, pid)
    local function doActionWithPlayerVehicle(actionCallback, args)
        local vehicle = Vehicle.getPlayerVehicle(pid)
        if vehicle == 0 then
            return
        end
        actionCallback(vehicle, args)
    end

    local function damage()
        doActionWithPlayerVehicle(Vehicle.damage)
    end

    local function explode()
        doActionWithPlayerVehicle(Vehicle.explode)
    end

    local function burn()
        doActionWithPlayerVehicle(Vehicle.burn)
    end

    local function killEngine()
        doActionWithPlayerVehicle(Vehicle.killEngine)
    end

    local function delete()
        doActionWithPlayerVehicle(Vehicle.delete)
    end

    local function clone()
        doActionWithPlayerVehicle(Vehicle.clone)
    end

    local function repair()
        doActionWithPlayerVehicle(Vehicle.repairVehicle)
    end

    local function emp()
        doActionWithPlayerVehicle(Vehicle.emp)
    end

    local function flip()
        doActionWithPlayerVehicle(Vehicle.flip)
    end

    ---@param enabled boolean
    local function setGod(enabled)
        doActionWithPlayerVehicle(function(veh)
            Vehicle.toggleVehicleGodMode(veh, enabled)
        end)
    end

    local function turnOffEngine()
        doActionWithPlayerVehicle(Vehicle.turnOffEngine)
    end

    local function randomUpgrade()
        doActionWithPlayerVehicle(Vehicle.randomUpgradeForVehicle)
    end

    local function stop()
        doActionWithPlayerVehicle(Vehicle.stop)
    end

    local function spin()
        doActionWithPlayerVehicle(Vehicle.spin)
    end

    local function launch(direction)
        doActionWithPlayerVehicle(function(veh)
            Vehicle.launch(veh, direction)
        end)
    end

    local function empty()
        doActionWithPlayerVehicle(Vehicle.empty)
    end

    local function tpToMe()
        doActionWithPlayerVehicle(Vehicle.tpToPlayer)
    end

    local function tpToVehicle()
        doActionWithPlayerVehicle(Vehicle.tpToVehicle)
    end

    local function slick()
        doActionWithPlayerVehicle(Vehicle.slick)
    end

    local function bump()
        doActionWithPlayerVehicle(Vehicle.bump)
    end

    ---@param lockDoors boolean
    local function sink(lockDoors)
        doActionWithPlayerVehicle(Vehicle.sink, lockDoors)
    end

    menu.action(vehicleSubmenu, "摧毁", {}, "摧毁车辆.", damage)
    menu.action(vehicleSubmenu, "爆炸", {}, "爆炸车辆.", explode)
    menu.action(vehicleSubmenu, "火烧", {}, "点燃车辆.", burn)
    menu.action(vehicleSubmenu, "摧毁引擎", {}, "摧毁引擎.", killEngine)
    menu.action(vehicleSubmenu, "关闭引擎", {}, "关闭引擎.", turnOffEngine)
    menu.action(vehicleSubmenu, "修理", {}, "修理车辆.", repair)
    menu.action(vehicleSubmenu, "删除", {}, "删除车辆.", delete)
    menu.action(vehicleSubmenu, "复制", {}, "复制此车.", clone)
    menu.action(vehicleSubmenu, "设置无敌", {}, "给这车设置无敌.", function()
        setGod(true)
    end)
    menu.action(vehicleSubmenu, "取消无敌", {}, "取消此车无敌.", function()
        setGod(false)
    end)
    menu.action(vehicleSubmenu, "随机升级", {}, "对车辆进行随机升级.", randomUpgrade)
    menu.action(vehicleSubmenu, "停止", {}, "停止车辆.", stop)
    menu.action(vehicleSubmenu, "快速旋转", {}, "旋转车辆.", spin)
    menu.action(vehicleSubmenu, "发射车辆", {}, "将车辆弹起", function()
        launch("up")
    end)
    menu.action(vehicleSubmenu, "强迫车辆下降", {}, "迫使车辆下降.", function()
        launch("down")
    end)
    menu.action(vehicleSubmenu, "向前发射", {}, "向前发动车辆向前发动车辆.", function()
        launch("forward")
    end)
    menu.action(vehicleSubmenu, "向后发射", {}, "向后发射", function()
        launch("back")
    end)
    menu.action(vehicleSubmenu, "清空所有乘客", {}, "清空车辆中的所有乘客.", empty)
    menu.action(vehicleSubmenu, "倒置", {}, "将车辆倒置.", flip)
    menu.action(vehicleSubmenu, "电磁脉冲", {}, "关闭车辆发动机几秒钟.", emp)
    menu.action(vehicleSubmenu, "传送到我", {}, "传送到我.", tpToMe)
    menu.action(vehicleSubmenu, "传送到他", {}, "传送到他车辆.", tpToVehicle)
    menu.action(vehicleSubmenu, "打滑", {}, "使他车辆打滑.", slick)
    menu.action(vehicleSubmenu, "颠簸", {}, "车辆下方的动力冲击，使其稍微颠簸", bump)
    menu.action_slider(vehicleSubmenu, "下沉车辆", {}, "将车辆沉入海洋深处.", {"车门已锁定", "车门打开"}, function(idx)
        sink(idx == 1)
    end)
end

return setupPlayerVehicleMenu
