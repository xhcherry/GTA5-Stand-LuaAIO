-- Undefined
--==============狗白又看你爹脚本是吧
local Utils<const> = require "lib.undefined.utils"
local Network<const> = require "lib.undefined.network"
local Raycast<const> = require "lib.undefined.raycast"
local Player<const> = require "lib.undefined.player"
local Ped<const> = require "lib.undefined.ped"
local Vehicle<const> = require "lib.undefined.vehicle"
local CONSTANTS<const> = require "lib.undefined.constants"
local _Raycast<const> = CONSTANTS.RAYCAST

local function drive()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if not aimResult then
        return
    end

    if not aimResult.player and aimResult.driver then
        entities.delete_by_handle(aimResult.driver)
    else
        Ped.kickFromVehicle(aimResult.driver)
        local maxTime = Utils.getTime(1000)
        while PED.IS_PED_IN_ANY_VEHICLE(aimResult.driver, false) do
            if Utils.getTime() > maxTime then
                break
            end
            util.yield()
        end
    end

    PED.SET_PED_INTO_VEHICLE(Player.getPlayerPed(), aimResult.vehicle, -1)
    Vehicle.turnOnEngine(aimResult.vehicle)
end

local function enter()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if not aimResult then
        return
    end

    local vehicle<const> = aimResult.vehicle
    if aimResult.driver then
        if VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
            PED.SET_PED_INTO_VEHICLE(Player.getPlayerPed(), vehicle, -2)
            return
        end
        if not aimResult.player and aimResult.driver then
            entities.delete_by_handle(aimResult.driver)
        else
            Utils.showToast("玩家的车上没有免费座位。如果您想劫持这辆车，请改用驾驶功能.")
        end
    end

    PED.SET_PED_INTO_VEHICLE(Player.getPlayerPed(), vehicle, -1)
    Vehicle.turnOnEngine(aimResult.vehicle)
end

local function damage()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.damage(aimResult.vehicle)
    end
end

local function explode()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.explode(aimResult.vehicle)
    end
end

local function burn()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.burn(aimResult.vehicle)
    end
end

local function killEngine()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.killEngine(aimResult.vehicle)
    end
end

local function delete()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.delete(aimResult.vehicle)
    end
end

local function clone()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.clone(aimResult.vehicle)
    end
end

local function repair()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.repairVehicle(aimResult.vehicle)
    end
end

---@param enabled boolean
local function setGod(enabled)
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.toggleVehicleGodMode(aimResult.vehicle, enabled)
    end
end

local function turnOffEngine()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.turnOffEngine(aimResult.entity)
    end
end

local function randomUpgrade()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.randomUpgradeForVehicle(aimResult.vehicle)
    end
end

local function stop()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.stop(aimResult.vehicle)
    end
end

local function spin()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.spin(aimResult.entity)
    end
end

local function launch(direction)
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.launch(aimResult.entity, direction)
    end
end

local function empty()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.empty(aimResult.vehicle)
    end
end

local function flip()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.flip(aimResult.vehicle)
    end
end

local function emp()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.emp(aimResult.vehicle)
    end
end

local function slick()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.slick(aimResult.vehicle)
    end
end

local function bump()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if aimResult then
        Vehicle.bump(aimResult.vehicle)
    end
end

local function openStand()
    local aimResult<const> = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if not aimResult then
        return
    elseif not aimResult.player then
        Utils.showToast("这仅适用于玩家作为驾驶员的车辆.")
        return
    end

    menu.trigger_commands("p" .. Player.getPlayerName(aimResult.player, true))
end

local movedVehicle = 0
local function move()
    if UND_currentlyMovedObject == 1 then -- Object is currently being moved
        return
    end

    if movedVehicle > 0 then
        local aimResult = Raycast.getPlayerAimData()
        if not aimResult then
            return
        elseif not Network.requestControl(movedVehicle) then
            movedVehicle = 0
            return
        end
        local coords = aimResult.coords
        ENTITY.SET_ENTITY_COORDS(movedVehicle, coords.x, coords.y, coords.z, false, false, false)
        movedVehicle = 0
        util.yield()
        UND_currentlyMovedObject = 0
        return
    end

    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if not aimResult then
        return
    end

    movedVehicle = aimResult.entity
    UND_currentlyMovedObject = 2

    util.create_tick_handler(function()
        if movedVehicle == 0 then
            return false
        end

        directx.draw_text(0.5, 0.8, "将车辆移至...", 5, 0.6, {
            r = 1,
            g = 1,
            b = 1,
            a = 1
        }, false)
    end)
end

local function tpToMe()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if not aimResult then
        return
    end

    Vehicle.tpToPlayer(aimResult.entity)
end

local function tpToVehicle()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
    if not aimResult then
        return
    end

    Vehicle.tpToVehicle(aimResult.entity)
end

---@param aimVehicleSubmenu CommandRef
local function setupVehicleAimActions(aimVehicleSubmenu)
    menu.action(aimVehicleSubmenu, "驾驶", {}, "强制您驾驶目标车辆.", drive)
    menu.action(aimVehicleSubmenu, "进入", {}, "如果车里没有人，则以乘客或驾驶员身份进入目标车辆.", enter)
    menu.action(aimVehicleSubmenu, "摧毁", {}, "摧毁目标车辆.", damage)
    menu.action(aimVehicleSubmenu, "爆炸", {}, "爆炸目标车辆.", explode)
    menu.action(aimVehicleSubmenu, "火烧", {}, "点燃目标车辆.", burn)
    menu.action(aimVehicleSubmenu, "关闭引擎", {}, "关闭目标车辆的引擎.", killEngine)
    menu.action(aimVehicleSubmenu, "删除", {}, "删除目标车辆.", delete)
    menu.action(aimVehicleSubmenu, "复制", {}, "复制目标车辆.", clone)
    menu.action(aimVehicleSubmenu, "修理", {}, "修理目标车辆.", repair)
    menu.action(aimVehicleSubmenu, "给予无敌", {}, "在目标车辆上设置无敌.", function()
        setGod(true)
    end)
    menu.action(aimVehicleSubmenu, "取消无敌", {}, "取消无敌.", function()
        setGod(false)
    end)
    menu.action(aimVehicleSubmenu, "发动机关闭", {}, "关闭目标车辆的发动机.", turnOffEngine)
    menu.action(aimVehicleSubmenu, "升级", {}, "对目标车辆进行随机升级.", randomUpgrade)
    menu.action(aimVehicleSubmenu, "停止", {}, "停止目标车辆.", stop)
    menu.action(aimVehicleSubmenu, "快速旋转", {}, "旋转目标车辆.", spin)
    menu.action(aimVehicleSubmenu, "向上发射", {}, "将目标车辆弹起.", function()
        launch("up")
    end)
    menu.action(aimVehicleSubmenu, "强制向下", {}, "迫使目标车辆下降.", function()
        launch("down")
    end)
    menu.action(aimVehicleSubmenu, "向前发射", {}, "向前发射.", function()
        launch("forward")
    end)
    menu.action(aimVehicleSubmenu, "向后发射", {}, "将目标车辆发射回来.", function()
        launch("back")
    end)
    menu.action(aimVehicleSubmenu, "踢出所有人", {}, "清空所有乘员的目标车辆.", empty)
    menu.action(aimVehicleSubmenu, "在Stand中打开", {}, "使用Stand部分功能", openStand)
    menu.action(aimVehicleSubmenu, "翻转", {}, "翻转目标车辆.", flip)
    menu.action(aimVehicleSubmenu, "电磁脉冲", {}, "使用电磁脉冲攻击车辆.", emp)
    menu.action(aimVehicleSubmenu, "移动", {},
    "瞄准要移动的车辆并按下热键。然后瞄准你想要将车辆放在的位置，然后再次按下热键.", move)
    menu.action(aimVehicleSubmenu, "它传送我", {}, "向您传送目标车辆.", tpToMe)
    menu.action(aimVehicleSubmenu, "传送到它", {}, "将自己传送到目标车辆.", tpToVehicle)
    menu.action(aimVehicleSubmenu, "打滑", {}, "使车辆打滑.", slick)
    menu.action(aimVehicleSubmenu, "颠簸", {}, "目标车辆下方的动力冲击，使其稍微颠簸.", bump)
end

return setupVehicleAimActions
