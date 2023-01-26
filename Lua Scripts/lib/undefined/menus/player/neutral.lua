-- Undefined
--==============狗白又看你爹脚本是吧
local Utils<const> = require "undefined.utils"
local Player<const> = require "undefined.player"
local Ped<const> = require "undefined.ped"
local CONSTANTS<const> = require "undefined.constants"

---@param neutralSubmenu CommandRef
---@param pid Player
local function setupPlayerNeutralMenu(neutralSubmenu, pid)
    local playerName<const> = Player.getPlayerName(pid)
    local playerPed<const> = Player.getPlayerPed(pid)

    ---@param choice integer
    local function setWantedLevel(choice)
        if Player.isPlayerNeverWanted(pid) then
            Utils.showToast("启用“从不需要”选项时无法更改需要的级别.")
            return
        end

        if Player.isModder(pid) then
            Utils.showToast("无法更改修改器的所需级别.")
            return
        end

        local currentWantedLevel = Player.getPlayerWantedLevel(pid)
        local function valueChanged()
            return choice ~= menu.get_value(menu.ref_by_rel_path(neutralSubmenu, "设置所需级别"))
        end

        ---@param clear? boolean
        local function resetWantedLevel(clear)
            menu.trigger_commands("bail" .. Player.getPlayerName(pid, true))
            if clear then
                Utils.showToast(playerName .. "的通缉级别已清除")
            end
            while Player.getPlayerWantedLevel(pid) > 0 do
                if not players.exists(pid) then
                    break
                end
                util.yield(1000)
            end
            menu.trigger_commands("bail" .. Player.getPlayerName(pid, true))
        end

        if currentWantedLevel ~= choice and choice == 0 then
            resetWantedLevel(true)
        elseif currentWantedLevel ~= choice then
            local maxTime<const> = Utils.getTime(10000)
            local maxTime5Stars<const> = Utils.getTime(30000)
            Utils.showToast("我在上面！给我点时间.")
            if currentWantedLevel > choice then
                resetWantedLevel()
            end
            
            util.create_tick_handler(function()
                if not players.exists(pid) then
                    Utils.showToast(playerName .. " 找不到.")
                    return false
                elseif Player.isDead(pid) then
                    Utils.showToast(playerName .. " 已经死了，等他活着再试试.")
                    return false
                elseif valueChanged() then
                    Utils.showToast("数值已更改，正在跳过所需的级别更改.")
                    return false
                elseif Player.isPlayerNeverWanted(pid) then
                    Utils.showToast(playerName .. " 从不需要，跳过更改.")
                    return false
                elseif (choice == 5 and Utils.getTime() >= maxTime5Stars) or (choice < 5 and Utils.getTime() >= maxTime) then
                    Utils.showToast("更改所需级别超时 " .. playerName .. ". 再试一次.")
                    return false
                end

                PLAYER.REPORT_CRIME(pid, 14, PLAYER.GET_WANTED_LEVEL_THRESHOLD(choice))

                if Player.getPlayerWantedLevel(pid) == choice then
                    Utils.showToast(playerName .. "的通缉级别已更改为: " .. choice)
                    return false
                else
                    util.yield(500)
                end
            end)
        else
            Utils.showToast(playerName .. " 已经具有此所需级别.")
        end
    end

    ---@param enabled boolean
    local function toggleNeverWanted(enabled)
        local commandRef<const> = menu.ref_by_command_name("bail" .. Player.getPlayerName(pid, true))
        if enabled then
            menu.set_value(commandRef, true)
        else
            menu.set_value(commandRef, false)
        end
    end

    local function clone()
        Ped.clone(Player.getPlayerPed(pid))
    end

    local function follow()
        if UND_followEnabledFor ~= pid then
            menu.trigger_commands(Utils.getCommandName("follow") .. Player.getPlayerName(UND_followEnabledFor, true) .. " off")
        end
        if pid == Player.getUserPlayer() then
            menu.trigger_commands(Utils.getCommandName("follow") .. Player.getPlayerName(pid, true) .. " off")
            Utils.showToast("你不能自己用这个.")
            return
        end
        UND_followEnabledFor = pid
        local pCoords = ENTITY.GET_ENTITY_COORDS(playerPed)
        ENTITY.SET_ENTITY_COORDS(Player.getPlayerPed(), pCoords.x, pCoords.y, pCoords.z - 1, false, false, false, false)
        util.yield(800)
    end

    menu.action_slider(neutralSubmenu, "设置所需级别", {Utils.getCommandName("wantedlvl")},
        "将玩家的通缉级别设置为选定的星星数。警告：这可能会让你落后，直到选定的级别设置为玩家.", CONSTANTS.GAME.WANTED_LEVELS,
        setWantedLevel)
    menu.toggle(neutralSubmenu, "取消通缉", {Utils.getCommandName("neverwanted")}, "警方永远不会追捕这名玩家.", toggleNeverWanted)
    menu.action(neutralSubmenu, "克隆", {}, "克隆玩家.", clone)
    menu.toggle_loop(neutralSubmenu, "追踪", {Utils.getCommandName("follow")}, "不断传送此玩家.", follow)
end

return setupPlayerNeutralMenu
