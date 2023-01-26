-- Undefined
--==============狗白又看你爹脚本是吧
local Utils<const> = require "undefined.utils"
local Vehicle<const> = require "undefined.vehicle"
local Player<const> = require "undefined.player"

local wpObjRel<const> = menu.ref_by_path("世界>地点>标记点打开...>看门狗")

local function teleportToWaypoint()
    local entityToTeleport = Vehicle.getPlayerOrVehicleEntity()
    if not entityToTeleport then
        return
    end

    local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
    if blip == 0 then
        menu.trigger_command(wpObjRel)
        blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
        if blip == 0 then
            return
        end
    end

    local pos = Utils.getBlipCoords(blip)
    ENTITY.SET_ENTITY_COORDS(entityToTeleport, pos.x, pos.y, pos.z, false, false, false)
end

---@param tpForwardDistanceSlider CommandRef
---@param tpForwardGroundZToggle CommandRef
---@param keepSpeedToggle CommandRef
local function teleportForward(tpForwardDistanceSlider, tpForwardGroundZToggle, keepSpeedToggle)
    local entityToTeleport = Vehicle.getPlayerOrVehicleEntity()
    if not entityToTeleport then
        return
    end

    local tpPosition = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entityToTeleport, 0, menu.get_value(tpForwardDistanceSlider) * 0.1, 0)
    if menu.get_value(tpForwardGroundZToggle) then
        tpPosition = Utils.getGroundZPosition(tpPosition)
    end
    local curSpeed<const> = ENTITY.GET_ENTITY_SPEED(entityToTeleport)
    ENTITY.SET_ENTITY_COORDS(entityToTeleport, tpPosition.x, tpPosition.y, tpPosition.z, false, false, false)
    if menu.get_value(keepSpeedToggle) then
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(entityToTeleport, curSpeed)
    end
end

local function teleportToRandomPlayer()
    if not util.is_session_started() then
        Utils.showToast("这只在在线模式有效.")
        return
    end

    local entityToTeleport = Vehicle.getPlayerOrVehicleEntity()
    if not entityToTeleport then
        return
    end

    local coords = Player.getPlayerPosition(Utils.getRandomPlayer())
    ENTITY.SET_ENTITY_COORDS(entityToTeleport, coords.x, coords.y, coords.z, false, false, false)
end

local function setupTeleportMenu()
    local teleportMenu = menu.list(Undefined, "传送选项", {}, "有关传送的选项")
    menu.action(teleportMenu, "传送到标记点/目标", {}, "传送你的标记点或任务目标.", teleportToWaypoint)
    local tpForwardDistanceSlider = menu.slider(teleportMenu, "向前传送距离", {Utils.getCommandName("tpfwddist")}, "向前传送操作的距离", 5, 500,
        200, 5, Utils.emptyFunction)
    local tpForwardGroundZToggle = menu.toggle(teleportMenu, "向前传送到地面", {Utils.getCommandName("tpfwdground")},
        "当切换时，你应该被传送到地面位置。当你经常在地图下或室内传送时很有用.", Utils.emptyFunction, true)
    local keepSpeedToggle = menu.toggle(teleportMenu, "保持速度", {Utils.getCommandName("tpfwdkeepspeed")}, "传送后保持速度，而不是被停止.",
        Utils.emptyFunction, true)
    menu.action(teleportMenu, "向前传送", {Utils.getCommandName("tpfwd")}, "使你向前传送", function()
        teleportForward(tpForwardDistanceSlider, tpForwardGroundZToggle, keepSpeedToggle)
    end)
    menu.action(teleportMenu, "传送到随机玩家", {Utils.getCommandName("tprandomplayer")}, "将你传送到战局中的随机一个玩家.", teleportToRandomPlayer)
end

return setupTeleportMenu
