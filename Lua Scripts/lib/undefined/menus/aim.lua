-- Undefined
--==============狗白又看你爹脚本是吧
local setupAimTeleport<const> = require "lib.undefined.menus.aim.teleport"
local setupAimBeam<const> = require "lib.undefined.menus.aim.beam"
local setupAimSettings<const> = require "lib.undefined.menus.aim.settings"
local setupPedAimActions<const> = require "lib.undefined.menus.aim.ped"
local setupVehicleAimActions<const> = require "lib.undefined.menus.aim.vehicle"
local setupObjectAimActions<const> = require "lib.undefined.menus.aim.object"

UND_currentlyMovedObject = 0 
UND_aimLockEnabled = true
UND_aimLockTime = 5

local function setupAimMenu()
    local aimMenu = menu.list(Undefined, "目标选项", {},
        "针对实体时可触发的动作捏。为您想要的每个动作设置热键，然后只需瞄准实体并使用热键触发动作。注：使用装备的武器进行瞄准可获得更高的射程.")
    menu.divider(aimMenu, "实施选项")
    local aimPedsSubmenu = menu.list(aimMenu, "NPC", {}, "玩家和NPC的设置.")
    local aimVehicleSubmenu = menu.list(aimMenu, "车辆", {}, "车辆设置.")
    local aimObjectsSubmenu = menu.list(aimMenu, "物体设置", {}, "物体设置.")
    local aimTeleportAction = setupAimTeleport(aimMenu)
    setupAimBeam(aimMenu)
    setupPedAimActions(aimPedsSubmenu)

    setupVehicleAimActions(aimVehicleSubmenu)
    setupObjectAimActions(aimObjectsSubmenu)
    setupAimSettings(aimMenu, aimPedsSubmenu, aimVehicleSubmenu, aimObjectsSubmenu, aimTeleportAction)
end

return setupAimMenu
