-- Undefined
--==============狗白又看你爹脚本是吧
local Utils<const> = require "undefined.utils"
local Player<const> = require "undefined.player"

local function setupSelfMenu()
    local selfMenu<const> = menu.list(Undefined, "自我选项", {}, "有关你自己的选项.")

    menu.action(selfMenu, "获得随机玩家装备", {}, "从战局中随机一个玩家那里复制装备.", function()
        local randPlayer<const> = Utils.getRandomPlayer()
        menu.trigger_commands("copyoutfit" .. Player.getPlayerName(randPlayer, true))
    end)


    if UND_privateMode then
        local setupPrivateMenu<const> = require "lib.undefined.menus.self.private"
        setupPrivateMenu(selfMenu)
    end
end

return setupSelfMenu
