-- Undefined
--==============狗白又看你爹脚本是吧
local Utils<const> = require "lib.undefined.utils"
local Raycast<const> = require "lib.undefined.raycast"
local Vehicle<const> = require "lib.undefined.vehicle"

local function aimTeleport()
    local aimResult = Raycast.getPlayerAimData(nil, true)
    local entityToTeleport = Vehicle.getPlayerOrVehicleEntity()
    if not entityToTeleport then
        return
    end

    if not aimResult or not aimResult.hit then
        local tpFwdRef<const> = menu.ref_by_path("Stand>Lua Scripts>Undefined>Teleport>Teleport forward")
        menu.trigger_command(tpFwdRef)
        return
    end

    local aimCoords = aimResult.coords
    ENTITY.SET_ENTITY_COORDS(entityToTeleport, aimCoords.x, aimCoords.y, aimCoords.z, false, false, false, false)
end

---@param aimMenu CommandRef
---@return CommandRef
local function setupAimTeleport(aimMenu)
    local aimTeleportAction = menu.action(aimMenu, "目标传送", {}, "将你的目标传送到...", aimTeleport)
    return aimTeleportAction
end

return setupAimTeleport
