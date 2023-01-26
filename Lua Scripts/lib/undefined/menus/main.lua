-- Undefined
--==============狗白又看你爹脚本是吧
local CONSTANTS<const> = require "undefined.constants"
local setupAimMenu<const> = require "lib.undefined.menus.aim"
local setupSelfMenu<const> = require "lib.undefined.menus.self"
local setupSessionMenu<const> = require "lib.undefined.menus.session"
local setupTeleportMenu<const> = require "lib.undefined.menus.teleport"
local setupVehicleMenu<const> = require "lib.undefined.menus.vehicle"
local setupWorldMenu<const> = require "lib.undefined.menus.world"
local setupPlayerMenu<const> = require "lib.undefined.menus.player"

local function startScript()
    util.require_natives(1663599433)
    local rootMenu = Undefined
    menu.divider(rootMenu, "CqCqscript2.0" .. "是" .. "最牛逼的")
    menu.hyperlink(rootMenu, "加入脚本中文交流", "https://jq.qq.com/?_wv=1027&k=YneNsXUT")
    menu.action(rootMenu, "玩家列表", {}, "跳转玩家列表.", function()
        menu.trigger_command(menu.ref_by_path('Players', 37))--=====狗白别来偷你爹脚本--偷了就是我儿！！！
    end)
    menu.divider(rootMenu, "*-==CqCqscript2.0==-*")

    setupPlayerMenu()
    setupSelfMenu()
    setupAimMenu()
    setupSessionMenu()
    setupTeleportMenu()
    setupVehicleMenu()
    setupWorldMenu()
end

return startScript
