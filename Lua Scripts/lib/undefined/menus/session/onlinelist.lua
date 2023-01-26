-- Undefined
--==============狗白又看你爹脚本是吧
local Utils<const> = require "undefined.utils"
local Player<const> = require "undefined.player"
local CONSTANTS<const> = require "undefined.constants"

local mainColor = CONSTANTS.SCRIPT.COLORS.LIST.main
local interiorColor = CONSTANTS.SCRIPT.COLORS.LIST.interior
local deadColor = CONSTANTS.SCRIPT.COLORS.LIST.dead
local modderColor = CONSTANTS.SCRIPT.COLORS.LIST.modder
local otrColor = CONSTANTS.SCRIPT.COLORS.LIST.otr

local listEnabled = true
-- Player settings
local maxPlayers = 30
local showYourself = false
local showTags = true
local showDistance = true
local showRank = false
local showKD = false
local showWantedLevel = true
local showMoney = true
local sortByValue = CONSTANTS.SCRIPT.PLAYER_SORT_OPTIONS[1]
local reverseSort = false
local hideInteriorValue = false
local interiorLastValue = true
-- List settings
local columnsNumber = 4
local xValue = 36
local yValue = 2
local scaleValue = 50
local xMultiplier = 8
local yMultiplier = 2
local showOrgColor = true

local playersData = {}

---@class PlayerData
---@field interior boolean
---@field money integer
---@field kd float
---@field distance integer
---@field rank integer
---@field name string
---@field hostPos integer
---@field text string
---@field colorToUse Color
--====
---@param p1 Player
---@param p2 Player
---@return boolean
local function sortByDistance(p1, p2)
    if reverseSort then
        return p1.distance > p2.distance
    end
    return p1.distance < p2.distance
end
--====
---@param p1 Player
---@param p2 Player
---@return boolean
local function sortByRank(p1, p2)
    if reverseSort then
        return p1.rank > p2.rank
    end
    return p1.rank < p2.rank
end
--===
---@param p1 Player
---@param p2 Player
---@return boolean
local function sortByMoney(p1, p2)
    if reverseSort then
        return p1.money > p2.money
    end
    return p1.money < p2.money
end
--===
---@param p1 Player
---@param p2 Player
---@return boolean
local function sortByKD(p1, p2)
    if reverseSort then
        return p1.kd > p2.kd
    end
    return p1.kd < p2.kd
end

---@param p1 Player
---@param p2 Player
---@return boolean
local function sortByName(p1, p2)
    if reverseSort then
        return p1.name > p2.name
    end
    return p1.name < p2.name
end

---@param p1 Player
---@param p2 Player
---@return boolean
local function sortByHostPos(p1, p2)
    if reverseSort then
        return p1.hostPos > p2.hostPos
    end
    return p1.hostPos < p2.hostPos
end

---@param playersData PlayerData
---@param inInterior boolean
---@return PlayerData
local function filterByInterior(playersData, inInterior)
    local newPlayerData = {}
    for _, playerData in playersData do
        if (inInterior and playerData.interior) or (not inInterior and not playerData.interior) then
            newPlayerData[#newPlayerData + 1] = playerData
        end
    end
    return newPlayerData
end

local function getPlayersData()
    if not listEnabled then
        return false
    end

    local playerCoords<const> = Player.getPlayerPosition()
    local playersList<const> = {table.unpack(players.list(showYourself), 1, maxPlayers)}
    playersData = {}
    for i = 1, #playersList do
        local pid<const> = playersList[i]
        local coords<const> = Player.getPlayerPosition(pid)
        local dist<const> = math.floor(v3.distance(playerCoords, coords))
        local playerData = {
            distance = dist,
            rank = Player.getPlayerRank(pid),
            money = Player.getMoney(pid),
            kd = math.floor(players.get_kd(pid) * 100) / 100,
            interior = Player.isInInterior(pid),
            name = Player.getPlayerName(pid),
            hostPos = players.get_host_queue_position(pid)
        }

        local colorToUse = mainColor
        local orgColor = Player.getOrgColor(pid)

        if showOrgColor and orgColor ~= -1 then
            colorToUse = orgColor
        elseif Player.isModder(pid) then
            colorToUse = modderColor
        elseif playerData.interior then
            colorToUse = interiorColor
        elseif Player.isDead(pid) then
            colorToUse = deadColor
        elseif Player.isOTR(pid) then
            colorToUse = otrColor
        end

        playerData.colorToUse = colorToUse

        local playerInfoText = {}

        if showWantedLevel then
            local wanted = Player.getPlayerWantedLevel(pid)
            if wanted > 0 then
                playerInfoText[#playerInfoText + 1] = wanted .. "*"
            end
        end

        if showMoney then
            local moneyShorten = Player.getMoney(pid, true)
            playerInfoText[#playerInfoText + 1] = "$" .. moneyShorten
        end

        if showRank then
            playerInfoText[#playerInfoText + 1] = "(" .. playerData.rank .. ")"
        end

        if showKD then
            playerInfoText[#playerInfoText + 1] = "KD" .. playerData.kd
        end

        if showTags then
            local tags = players.get_tags_string(pid)
            if string.len(tags) > 0 then
                playerInfoText[#playerInfoText + 1] = "[" .. tags .. "]"
            end
        end

        if showDistance then
            playerInfoText[#playerInfoText + 1] = dist
        end

        playerInfoText[#playerInfoText + 1] = playerData.name

        playerData.text = table.concat(playerInfoText, " ")
        playersData[i] = playerData
    end

    if hideInteriorValue then
        playersData = filterByInterior(playersData, false)
    end

    if sortByValue == "距离" then -- distance
        table.sort(playersData, sortByDistance)
    elseif sortByValue == "金钱" then
        table.sort(playersData, sortByMoney)
    elseif sortByValue == "KD" then
        table.sort(playersData, sortByKD)
    elseif sortByValue == "主机位置" then
        table.sort(playersData, sortByHostPos)
    elseif sortByValue == "名字" then
        table.sort(playersData, sortByName)
    else -- rank
        table.sort(playersData, sortByRank)
    end

    if not hideInteriorValue and interiorLastValue then
        local notInteriorPlayers<const> = filterByInterior(playersData, false)
        local interiorPlayers<const> = filterByInterior(playersData, true)
        local result<const> = {table.unpack(notInteriorPlayers)}
        table.move(interiorPlayers, 1, #interiorPlayers, #result + 1, result)
        playersData = result
    end

    util.yield(1000)
end

local function renderList()
    if not listEnabled then
        return false
    end

    local maxPlayersInColumn<const> = math.ceil(#playersData / columnsNumber)
    local curX = xValue
    local curY = yValue
    for idx, player in playersData do
        curY = curY + 0.01 * yMultiplier

        directx.draw_text_client(curX, curY, player.text, 5, scaleValue, player.colorToUse)

        if idx % maxPlayersInColumn == 0 then
            curX = curX + 0.02 * xMultiplier
            curY = yValue
        end
    end
end

local function showOnlineList()
    util.create_tick_handler(getPlayersData)
    util.create_tick_handler(renderList)
end

---@param sessionMenu CommandRef
local function setupOnlineListMenu(sessionMenu)
    local function showList()
        if listEnabled then
            showOnlineList()
        end
    end

    local onlineList<const> = menu.list(sessionMenu, "在线列表", {}, "在线玩家列表显示设置.")
    local listEnabledToggle<const> = menu.toggle(onlineList, "启用在线列表", {Utils.getCommandName("onlinelist")}, "", function(on)
        listEnabled = on
        showList()
    end, listEnabled)
    listEnabled = menu.get_value(listEnabledToggle)

    menu.divider(onlineList, "玩家选项")
    local showYourselfToggle<const> = menu.toggle(onlineList, "列入自己", {}, "将自己列入名单.", function(on)
        showYourself = on
    end, showYourself)
    showYourself = menu.get_value(showYourselfToggle)

    local tagsToggle<const> = menu.toggle(onlineList, "显示标记", {}, "在方括号中显示Stand中的标记.", function(on)
        showTags = on
    end, showTags)
    showTags = menu.get_value(tagsToggle)

    local distToggle<const> = menu.toggle(onlineList, "显示距离", {}, "显示与您的距离.", function(on)
        showDistance = on
    end, showDistance)
    showDistance = menu.get_value(distToggle)

    local rankToggle<const> = menu.toggle(onlineList, "显示排名", {}, "在圆括号中显示排名.", function(on)
        showRank = on
    end, showRank)
    showRank = menu.get_value(rankToggle)

    local kdToggle<const> = menu.toggle(onlineList, "显示 KD", {}, "显示K/D比率.", function(on)
        showKD = on
    end, showKD)
    showKD = menu.get_value(kdToggle)

    local wantedLevelToggle<const> = menu.toggle(onlineList, "显示所需级别", {}, "在*字符左侧显示所需级别。仅当需要玩家时才会显示.",
        function(on)
            showWantedLevel = on
        end, showWantedLevel)
    showWantedLevel = menu.get_value(wantedLevelToggle)

    local moneyToggle<const> = menu.toggle(onlineList, "显示马内", {}, "显示总金额.", function(on)
        showMoney = on
    end, showMoney)
    showMoney = menu.get_value(moneyToggle)

    local maxPlayersSlider<const> = menu.slider(onlineList, "最大玩家数", {Utils.getCommandName("onlinelistmaxplayers")}, "仅列出选定的玩家数量.", 1, 30,
        maxPlayers, 1, function(val)
            maxPlayers = val
        end)
    maxPlayers = menu.get_value(maxPlayersSlider)

    local sortBySlider<const> = menu.list_select(onlineList, "排序依据", {}, "选择排序类型.", CONSTANTS.SCRIPT.PLAYER_SORT_OPTIONS, 1, function(_, name)
        sortByValue = name
    end)
    sortByValue = menu.get_state(sortBySlider)

    local reverseSortToggle<const> = menu.toggle(onlineList, "反向排序顺序", {}, "", function(on)
        reverseSort = on
    end, reverseSort)
    reverseSort = menu.get_value(reverseSortToggle)

    local hideInteriorToggle<const> = menu.toggle(onlineList, "将玩家隐藏在室内", {}, "室内玩家不会出现在名单上.", function(on)
        hideInteriorValue = on
    end, hideInteriorValue)
    hideInteriorValue = menu.get_value(hideInteriorToggle)

    local interiorLastToggle<const> = menu.toggle(onlineList, "室内玩家最后", {}, "室内玩家将显示在列表末尾.", function(on)
        interiorLastValue = on
    end, interiorLastValue)
    interiorLastValue = menu.get_value(interiorLastToggle)

    menu.divider(onlineList, "列表选项")
    local columnsSlider<const> = menu.slider(onlineList, "要显示的列数", {Utils.getCommandName("onlinelistcolnum")}, "要显示的列数.", 1, 6, columnsNumber, 1,
        function(val)
            columnsNumber = val
        end)
    columnsNumber = menu.get_value(columnsSlider)

    local spaceXSlider<const> = menu.slider(onlineList, "列水平间距", {Utils.getCommandName("onlinelisthcspace")}, "列之间的水平间距.", 1, 10,
        xMultiplier, 1, function(val)
            xMultiplier = val
        end)
    xMultiplier = menu.get_value(spaceXSlider)

    local spaceYSlider<const> = menu.slider(onlineList, "列垂直间距", {Utils.getCommandName("onlinelistvcspace")}, "列垂直间距.", 1, 5,
        yMultiplier, 1, function(val)
            yMultiplier = val
        end)
    yMultiplier = menu.get_value(spaceYSlider)

    local xSlider<const> = menu.slider(onlineList, "水平位置", {Utils.getCommandName("onlinelisthpos")}, "水平位置.", 0, 100, xValue, 1,
        function(val)
            xValue = val / 100
        end)
    xValue = menu.get_value(xSlider) / 100

    local ySlider = menu.slider(onlineList, "垂直位置", {Utils.getCommandName("onlinelistvpos")}, "垂直位置.", 0, 100, yValue, 1, function(val)
        yValue = val / 100
    end)
    yValue = menu.get_value(ySlider) / 100

    local scaleSlider<const> = menu.slider(onlineList, "规模", {Utils.getCommandName("onlinelistscale")}, "列出文本比例.", 30, 80, scaleValue, 1, function(val)
        scaleValue = val / 100
    end)
    scaleValue = menu.get_value(scaleSlider) / 100

    local colorsMenu<const> = menu.list(onlineList, "颜色", {}, "列表的颜色设置.")
    menu.colour(colorsMenu, "主要颜色", {Utils.getCommandName("onlinelistcolor")}, "列表的主颜色.", mainColor, true, function(c)
        mainColor = c
    end)
    menu.colour(colorsMenu, "室内玩家颜色", {Utils.getCommandName("onlinelistinteriorcolor")}, "室内玩家颜色.", interiorColor, true, function(c)
        interiorColor = c
    end)
    menu.colour(colorsMenu, "死亡玩家的颜色", {Utils.getCommandName("onlinelistdeadcolor")}, "死亡玩家的颜色.", deadColor, true, function(c)
        deadColor = c
    end)
    menu.colour(colorsMenu, "作弊玩家颜色", {Utils.getCommandName("onlinelistmoddercolor")}, "作弊玩家的颜色.", modderColor, true, function(c)
        modderColor = c
    end)
    menu.colour(colorsMenu, "非雷达玩家颜色", {Utils.getCommandName("onlinelistotrcolor")}, "非雷达玩家的颜色.", otrColor, true, function(c)
        otrColor = c
    end)
    local orgToggle<const> = menu.toggle(colorsMenu, "显示组织颜色", {},
        "如果玩家在组织中，他将在列表中显示其组织颜色。这将覆盖此类玩家的上述颜色.", function(on)
            showOrgColor = on
        end, showOrgColor)
    showOrgColor = menu.get_value(orgToggle)

    showList()
end

return setupOnlineListMenu
