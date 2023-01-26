-- Undefined
--==============狗白又看你爹脚本是吧
local Player<const> = require "undefined.player"
local Ped<const> = require "undefined.ped"

---@param trollingSubmenu CommandRef
---@param pid Player
local function setupPlayerTrollingMenu(trollingSubmenu, pid)
    menu.toggle_loop(trollingSubmenu, "玩偶循环", {}, "", function()
        local coords = Player.getPlayerPosition(pid)
        coords.z = coords['z'] - 2.0
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 11, 1, false, true, 0, true)
        util.yield(10)
    end)

    menu.action(trollingSubmenu, "玩偶", {}, "", function()
        local coords = Player.getPlayerPosition(pid)
        coords.z = coords['z'] - 2.0
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 11, 1, false, true, 0, true)
    end)

    menu.toggle_loop(trollingSubmenu, "火柱Pro", {}, "", function()
        local coords = Player.getPlayerPosition(pid)
        coords.z = coords['z'] - 2.0
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 12, 1, true, false, 0, false)
        util.yield(25)
    end)

    menu.toggle_loop(trollingSubmenu, "爆炸循环", {}, "", function()
        Ped.explode(Player.getPlayerPed(pid))
    end)

    menu.toggle_loop(trollingSubmenu, "水柱Pro", {}, "", function()
        local coords = Player.getPlayerPosition(pid)
        coords.z = coords['z'] - 2.0
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 13, 1, true, false, 0, false)
        util.yield(25)
    end)

    menu.toggle_loop(trollingSubmenu, "追踪火焰", {}, "火会一直跟着玩家.", function()
        local coords = Player.getPlayerPosition(pid)
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 38, 0, false, false, 0, false)
        util.yield(65)
    end)
end

return setupPlayerTrollingMenu
