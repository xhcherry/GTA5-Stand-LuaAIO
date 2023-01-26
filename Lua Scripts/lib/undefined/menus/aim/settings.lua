-- Undefined
--==============狗白又看你爹脚本是吧
local CONSTANTS<const> = require "undefined.constants"
local Utils<const> = require "undefined.utils"
local Raycast<const> = require "lib.undefined.raycast"
local Player<const> = require "lib.undefined.player"

local pedAimTextToRender = ""
local vehicleAimTextToRender = ""
local objectAimTextToRender = ""
local aimTeleportHotkeyAssigned = false

local hotkeysColor = CONSTANTS.SCRIPT.COLORS.AIM.hotkeys
local lineColor = CONSTANTS.SCRIPT.COLORS.AIM.line
local highlightColor = CONSTANTS.SCRIPT.COLORS.AIM.highlight
local typeColor = {}
typeColor.r = hotkeysColor.r / 0.2
typeColor.g = hotkeysColor.g / 0.2
typeColor.b = hotkeysColor.b / 0.2
typeColor.a = hotkeysColor.a

local xValue, yValue, scaleValue = 50, 90, 60

local hotkeysEnabled, lineEnabled, highlightEnabled, beaconEnabled = true, true, true, true

local function setAimHotkeys()
    local hotkeysFileName<const> = filesystem.stand_dir() .. '\\' .. 'Hotkeys.txt'
    local hotkeysFile<const> = util.read_colons_and_tabs_file(hotkeysFileName)

    pedAimTextToRender = ""
    vehicleAimTextToRender = ""
    objectAimTextToRender = ""
    aimTeleportHotkeyAssigned = false

    local assignedPedHotkeysCount = 0
    local assignedPedHotkeys = false
    local assignedVehicleHotkeysCount = 0
    local assignedVehicleHotkeys = false
    local assignedObjectHotkeysCount = 0
    local maxHotkeysPerLine = 7

    for key, hotkey in hotkeysFile do
        if menu.is_ref_valid(menu.ref_by_path(key)) and string.find(key, CONSTANTS.SCRIPT.NAME) and string.find(key, "实施目标") then
            if string.find(key, "车辆") then
                local menuAction<const> = menu.get_menu_name(menu.ref_by_path(key))
                local hotkeyAction = menuAction .. ": " .. hotkey
                assignedVehicleHotkeysCount = assignedVehicleHotkeysCount + 1
                assignedVehicleHotkeys = true
                if assignedVehicleHotkeysCount > maxHotkeysPerLine then
                    hotkeyAction = hotkeyAction .. "\n"
                    assignedVehicleHotkeysCount = 0
                end
                vehicleAimTextToRender = vehicleAimTextToRender .. "  " .. hotkeyAction
            elseif string.find(key, "NPC") then
                local menuAction<const> = menu.get_menu_name(menu.ref_by_path(key))
                local hotkeyAction = menuAction .. ": " .. hotkey
                assignedPedHotkeysCount = assignedPedHotkeysCount + 1
                assignedPedHotkeys = true
                if assignedPedHotkeysCount > maxHotkeysPerLine then
                    hotkeyAction = hotkeyAction .. "\n"
                    assignedPedHotkeysCount = 0
                end
                pedAimTextToRender = pedAimTextToRender .. "  " .. hotkeyAction
            elseif string.find(key, "物体") then
                local menuAction<const> = menu.get_menu_name(menu.ref_by_path(key))
                local hotkeyAction = menuAction .. ": " .. hotkey
                assignedObjectHotkeysCount = assignedObjectHotkeysCount + 1
                if assignedObjectHotkeysCount > maxHotkeysPerLine then
                    hotkeyAction = hotkeyAction .. "\n"
                    assignedObjectHotkeysCount = 0
                end
                objectAimTextToRender = objectAimTextToRender .. "  " .. hotkeyAction
            end
        end

        if string.find(key, CONSTANTS.SCRIPT.NAME) and string.find(key, "目标传送") then
            aimTeleportHotkeyAssigned = true
        end
    end

    if not assignedPedHotkeys then
        pedAimTextToRender = "没有为目标动作指定热键"
    end

    if not assignedVehicleHotkeys then
        vehicleAimTextToRender = "没有为车辆瞄准动作指定热键"
    end
end

local function onAim()
    if not beaconEnabled and not highlightEnabled and not hotkeysEnabled and not lineEnabled then
        return
    end

    local aimResult<const> = Raycast.getPlayerAimData(nil, true)
    if not aimResult then
        return
    end

    local isTargetable<const> = aimResult.isVehicle or aimResult.isPed or aimResult.isObject

    if aimTeleportHotkeyAssigned and beaconEnabled and not isTargetable then
        util.draw_ar_beacon(aimResult.coords)
    elseif (highlightEnabled or lineEnabled or hotkeysEnabled) and isTargetable then
        if highlightEnabled then
            Utils.drawBox(aimResult.entity, highlightColor)
        end

        if lineEnabled then
            local pCoords<const> = Player.getPlayerPosition()
            local entCoords<const> = ENTITY.GET_ENTITY_COORDS(aimResult.entity)
            GRAPHICS.DRAW_LINE(pCoords.x, pCoords.y, pCoords.z, entCoords.x, entCoords.y, entCoords.z, lineColor.r, lineColor.g, lineColor.b, lineColor.a)
        end

        if hotkeysEnabled then
            local textToRender = ""
            local typeToRender = ""
            if aimResult.isVehicle then
                textToRender = vehicleAimTextToRender
                typeToRender = "Vehicle"
                if aimResult.player then
                    typeToRender = typeToRender .. " (" .. aimResult.playerName .. ")"
                end
            elseif aimResult.isPed then
                textToRender = pedAimTextToRender
                typeToRender = "Ped"
                if aimResult.player then
                    typeToRender = typeToRender .. " (" .. aimResult.playerName .. ")"
                end
            else
                textToRender = objectAimTextToRender
            end

            directx.draw_text(xValue, yValue - 0.09 * scaleValue, typeToRender, 5, scaleValue, typeColor, false)
            directx.draw_text(xValue, yValue, textToRender, 5, scaleValue, hotkeysColor, false)
        end
    end
end

---@param aimMenu CommandRef
---@param aimPedsSubmenu CommandRef
---@param aimVehicleSubmenu CommandRef
---@param aimObjectsSubmenu CommandRef
---@param aimTeleportAction CommandRef
local function setupAimSettings(aimMenu, aimPedsSubmenu, aimVehicleSubmenu, aimObjectsSubmenu, aimTeleportAction)
    menu.divider(aimMenu, "目标锁定")
    local aimLockToggle = menu.toggle(aimMenu, "锁定最后一个目标", {Utils.getCommandName("aimlock")},
        "启用后，您最后一次瞄准的车辆或ped将在设定的时间内进行交互捏。当你停止瞄准时，互动是可能的。当目标快速移动或距离较远时，这很有用，这样你就不必一直瞄准他。使用主动瞄准锁定瞄准不同的车辆/ped将切换瞄准锁定目标.",
        function(on)
            UND_aimLockEnabled = on
        end, UND_aimLockEnabled)
    UND_aimLockEnabled = menu.get_value(aimLockToggle)

    local aimLockTimeSlider<const> = menu.slider(aimMenu, "锁定时间", {Utils.getCommandName("aimlocktime")}, "0将锁定最后一个目标的目标，直到它被游戏丢失或删除。您还可以使用下面的操作从目标中移除锁.", 0, 30, UND_aimLockTime, 1, function(val)
        UND_aimLockTime = val
    end)
    UND_aimLockTime = menu.get_value(aimLockTimeSlider)

    menu.action(aimMenu, "解除锁定", {Utils.getCommandName("removeaimlock")}, "停止你对它的锁定.", function()
        UND_aimLockEnabled = false
        util.yield(1000)
        UND_aimLockEnabled = true
    end)

    menu.divider(aimMenu, "设置")
    local hotkeysPositionSubmenu = menu.list(aimMenu, "热键选项", {}, "调整热键文本位置和比例.")
    local xSlider<const> = menu.slider(hotkeysPositionSubmenu, "水平位置", {Utils.getCommandName("hotkeyshpos")}, "", 0, 100, xValue, 1, function(val)
        xValue = val / 100
    end)
    xValue = menu.get_value(xSlider) / 100

    local ySlider = menu.slider(hotkeysPositionSubmenu, "垂直位置", {Utils.getCommandName("hotkeysvpos")}, "", 0, 100, yValue, 1, function(val)
        yValue = val / 100
    end)
    yValue = menu.get_value(ySlider) / 100

    local scaleSlider<const> = menu.slider(hotkeysPositionSubmenu, "缩放比例", {Utils.getCommandName("hotkeysscale")}, "", 30, 100, scaleValue, 1, function(val)
        scaleValue = val / 100
    end)
    scaleValue = menu.get_value(scaleSlider) / 100

    menu.colour(aimMenu, "热键颜色", {Utils.getCommandName("hotkeyscolor")}, "用于显示热键的颜色.", hotkeysColor, true, function(c)
        hotkeysColor = c
        typeColor.r = hotkeysColor.r / 0.2
        typeColor.g = hotkeysColor.g / 0.2
        typeColor.b = hotkeysColor.b / 0.2
        typeColor.a = hotkeysColor.a
    end)
    local hotkeysToggle = menu.toggle(aimMenu, "显示热键", {}, "瞄准实体时显示指定的热键.", function(on)
        hotkeysEnabled = on
        setAimHotkeys()
    end, true)
    hotkeysEnabled = menu.get_value(hotkeysToggle)

    menu.colour(aimMenu, "线条颜色", {Utils.getCommandName("linecolor")}, "用于线条到目标的颜色.", lineColor, true, function(c)
        lineColor = Utils.convertColorToGame(c)
    end)
    lineColor = Utils.convertColorToGame(lineColor)
    local showLineToggle = menu.toggle(aimMenu, "显示目标行", {}, "显示指向目标实体的行.", function(on)
        lineEnabled = on
    end, lineEnabled)
    lineEnabled = menu.get_value(showLineToggle)

    menu.colour(aimMenu, "突出显示颜色", {Utils.getCommandName("highlightcolor")}, "用于突出显示目标的颜色.", highlightColor, true, function(c)
        highlightColor = Utils.convertColorToGame(c)
    end)
    highlightColor = Utils.convertColorToGame(highlightColor)
    local highlightToggle = menu.toggle(aimMenu, "突出显示目标", {}, "目标实体将用方框突出显示.", function(on)
        highlightEnabled = on
    end, highlightEnabled)
    highlightEnabled = menu.get_value(highlightToggle)

    local tpBeaconToggle = menu.toggle(aimMenu, "显示目标传送的AR信标", {Utils.getCommandName("aimtpbeacon")},
        "当你为目标传送指定热键时，在你将被传送到的地方显示AR信标.", function(on)
            beaconEnabled = on
        end, beaconEnabled)
    beaconEnabled = menu.get_value(tpBeaconToggle)

    setAimHotkeys()
    menu.on_blur(aimPedsSubmenu, setAimHotkeys)
    menu.on_blur(aimVehicleSubmenu, setAimHotkeys)
    menu.on_blur(aimObjectsSubmenu, setAimHotkeys)
    menu.on_blur(aimTeleportAction, setAimHotkeys)

    util.create_tick_handler(onAim)
end

return setupAimSettings
