-- Undefined
--==============狗白又看你爹脚本是吧
local CONSTANTS<const> = require "lib.undefined.constants"
local Utils<const> = require "lib.undefined.utils"
local Player<const> = require "lib.undefined.player"
local Raycast<const> = require "lib.undefined.raycast"

local aimBeamWeapon = CONSTANTS.GAME.BULLET_TYPES[1]
local aimBeamDelay = 200

local function aimBeam()
    local weaponHash = Utils.requestWeaponAsset(aimBeamWeapon.hash)
    local playerCoords = Player.getPlayerPosition()
    local _, shootCoords = Raycast.getOffsetFromCam(1000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(playerCoords.x, playerCoords.y, playerCoords.z + 1, shootCoords.x, shootCoords.y, shootCoords.z, 200, false, weaponHash,
        Player.getPlayerPed(), true, false, 1000)
    util.yield(aimBeamDelay)
end

---@param aimMenu CommandRef
local function setupAimBeam(aimMenu)
    menu.divider(aimMenu, "瞄准的线条")
    local aimBeamToggleLoop = menu.toggle_loop(aimMenu, "开启使用", {},
        "使用带有“保持”选项的热键来使用它.", aimBeam)
    menu.set_value(aimBeamToggleLoop, false)

    menu.list_select(aimMenu, "功能类型", {Utils.getCommandName("beamtype")}, "", CONSTANTS.GAME.BULLET_TYPES, 1, function(idx)
        aimBeamWeapon = CONSTANTS.GAME.BULLET_TYPES[idx]
    end)

    menu.slider(aimMenu, "延迟", {Utils.getCommandName("beamdelay")}, "射击瞄准线条之间的延迟", 50, 500, aimBeamDelay, 50, function(val)
        aimBeamDelay = val
    end)

end

return setupAimBeam
