-- Undefined
--==============狗白又看你爹脚本是吧
local CONSTANTS<const> = require "undefined.constants"
local Utils<const> = require "undefined.utils"
local Player<const> = require "undefined.player"
local Vehicle<const> = require "undefined.vehicle"

local weapons<const> = util.get_weapons()

local enabled = true

local xValue, yValue, scaleValue, yMultiplier = 85, 20, 100, 2
local displayTime = 2
local color = CONSTANTS.SCRIPT.COLORS.LIST.modder

local aimingPlayers = {}

local function renderAimInfo()
    if #aimingPlayers == 0 then
        return
    end
    for idx, player in aimingPlayers do
        directx.draw_text(xValue, yValue + idx * yMultiplier * 0.02, player.text, 5, scaleValue, color, true)
    end
end

local function showExamples()
    for i = 1, 3 do
        aimingPlayers[#aimingPlayers + 1] = {
            pid = 123,
            text = "玩家 " .. i .. " - 武器 " .. i
        }
        local showTime<const> = Utils.getTime(displayTime * 1000)
        util.create_thread(function()
            while Utils.getTime() <= showTime do
                util.yield(1000)
            end
            table.remove(aimingPlayers, 1)
        end)
    end
end

local function runAimWatcher()
    if not enabled then
        return
    end

    local playerEntity<const> = Player.getPlayerPed()
    local allPlayers<const> = players.list(false)
    for _, pid in allPlayers do
        local isAiming = PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(pid, playerEntity) or PLAYER.IS_PLAYER_TARGETTING_ENTITY(pid, playerEntity)

        if isAiming then
            for _, player in aimingPlayers do
                if player.pid == pid then
                    goto continue
                end
            end

            local textToShow = Player.getPlayerName(pid)

            local weaponHash<const> = memory.alloc_int()
            WEAPON.GET_CURRENT_PED_WEAPON(Player.getPlayerPed(pid), weaponHash, true)
            local readWeaponHash<const> = memory.read_int(weaponHash)
            local weaponName
            for _, wep in weapons do
                if wep.hash == readWeaponHash then
                    weaponName = util.get_label_text(wep.label_key)
                    break
                end
            end

            if not weaponName then
                weaponName = "未知武器"
            end

            textToShow = textToShow .. " - " .. weaponName

            aimingPlayers[#aimingPlayers + 1] = {
                pid = pid,
                text = textToShow
            }
            local showTime<const> = Utils.getTime(displayTime * 1000)
            util.create_thread(function()
                while Utils.getTime() <= showTime do
                    util.yield(1000)
                end
                table.remove(aimingPlayers, 1)
            end)
        end
        ::continue::
    end

    util.yield(500)
end

---@param sessionMenu CommandRef
local function setupAimInfoMenu(sessionMenu)
    local aimInfoMenu<const> = menu.list(sessionMenu, "玩家目标信息", {}, "玩家瞄准信息的设置，以显示谁瞄准你以及他们使用的武器。不适用于车辆武器. ")
    menu.toggle(aimInfoMenu, "显示玩家目标信息", {}, "", function(on)
        enabled = on
    end, enabled)

    local positionSubmenu<const> = menu.list(aimInfoMenu, "位置", {}, "调整文本位置和比例.")
    local xSlider<const> = menu.slider(positionSubmenu, "水平位置", {Utils.getCommandName("playeraimhpos")}, "", 0, 100, xValue, 1, function(val)
        xValue = val / 100
        showExamples()
    end)
    xValue = menu.get_value(xSlider) / 100

    local ySlider<const> = menu.slider(positionSubmenu, "垂直位置", {Utils.getCommandName("playeraimvpos")}, "", 0, 100, yValue, 1, function(val)
        yValue = val / 100
        showExamples()
    end)
    yValue = menu.get_value(ySlider) / 100

    local scaleSlider<const> = menu.slider(positionSubmenu, "大小", {Utils.getCommandName("playeraimscale")}, "", 30, 120, scaleValue, 1, function(val)
        scaleValue = val / 100
        showExamples()
    end)
    scaleValue = menu.get_value(scaleSlider) / 100

    local spaceYSlider<const> = menu.slider(positionSubmenu, "垂直间距", {Utils.getCommandName("playeraimvspace")}, "瞄准玩家之间的垂直间距.", 1, 5,
        yMultiplier, 1, function(val)
            yMultiplier = val
            showExamples()
        end)
    yMultiplier = menu.get_value(spaceYSlider)

    menu.colour(aimInfoMenu, "颜色", {Utils.getCommandName("playeraimcolor")}, "", color, true, function(c)
        color = c
    end)

    local displayTimeSlider<const> = menu.slider(aimInfoMenu, "显示时间", {Utils.getCommandName("playeraimtime")}, "显示目标信息的时间.", 1, 5, displayTime,
        1, function(val)
            displayTime = val
        end)
    displayTime = menu.get_value(displayTimeSlider)

    menu.action(aimInfoMenu, "显示示例", {}, "显示目标信息示例.", showExamples)

    util.create_tick_handler(runAimWatcher)
    util.create_tick_handler(renderAimInfo)
end

return setupAimInfoMenu
