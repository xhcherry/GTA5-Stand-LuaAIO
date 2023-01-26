-- Undefined
--==============狗白又看你爹脚本是吧
local setupOnlineListMenu<const> = require "lib.undefined.menus.session.onlinelist"
local setupAimInfoMenu<const> = require "lib.undefined.menus.session.aiminfo"

local function setupSessionMenu()
    local sessionMenu = menu.list(Undefined, "全局选项", {}, "全局选项功能")
    setupOnlineListMenu(sessionMenu)
    setupAimInfoMenu(sessionMenu)
end

return setupSessionMenu
