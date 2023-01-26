local Utils<const> = require "undefined.utils"
local Player<const> = require "undefined.player"
--==============狗白又看你爹脚本是吧
-- Undefined
local Ped = {}

---@param ped Ped
function Ped.kickFromVehicle(ped)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    TASK.TASK_LEAVE_ANY_VEHICLE(ped, 0, 16)
end

---@param ped Ped
function Ped.ragdoll(ped)
    local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
    FIRE.ADD_EXPLOSION(pedCoords.x, pedCoords.y, pedCoords.z, 70, 0.1, false, true, 0.0)
end

---@param ped Ped
---@param isPlayer? boolean
function Ped.burn(ped)
    FIRE.START_ENTITY_FIRE(ped)
    util.yield(5000)
    FIRE.STOP_ENTITY_FIRE(ped)
end

---@param ped Ped
function Ped.explode(ped)
    local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
    FIRE.ADD_EXPLOSION(pedCoords.x, pedCoords.y, pedCoords.z, 1, 1, true, false, 0.0, false)
end

---@param ped Ped
---@return ped Ped
function Ped.clone(ped)
    return PED.CLONE_PED(ped, true, false, true)
end

---@param ped Ped
function Ped.disarm(ped)
    WEAPON.REMOVE_ALL_PED_WEAPONS(ped, false)
end

---@param ped Ped
---@param enabled boolean
function Ped.freeze(ped, enabled)
    ENTITY.FREEZE_ENTITY_POSITION(ped, enabled)
end

---@param ped Ped
function Ped.revive(ped)
    local newPed = Ped.clone(ped)
    entities.delete_by_handle(ped)
    ENTITY.SET_ENTITY_HEALTH(newPed, 100)
end

---@param ped Ped
function Ped.toggleGod(ped, enable)
    ENTITY.SET_ENTITY_INVINCIBLE(ped)
end

---@param ped Ped
function Ped.shoot(ped)
    local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
    local weaponHash = Utils.requestWeaponAsset("WEAPON_HEAVYSNIPER")
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pedCoords.x, pedCoords.y, pedCoords.z + 5, pedCoords.x, pedCoords.y, pedCoords.z, 1000, false, weaponHash, Player.getPlayerPed(), true,
        false, 1000)
end

---@param coords v3
---@return Ped
function Ped.getClosestPedToCoords(coords)
    local peds = entities.get_all_peds_as_handles()
    local maxDistance = 2
    local closestPed

    for _, ped in peds do
        if ped ~= Player.getPlayerPed() and not PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            local pedCoords = ENTITY.GET_ENTITY_COORDS(ped, true)
            local distance = v3.distance(coords, pedCoords)
            if distance < maxDistance then
                maxDistance = distance
                closestPed = ped
            end

        end
    end
    return closestPed
end

return Ped
