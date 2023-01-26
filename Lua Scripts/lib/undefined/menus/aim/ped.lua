-- Undefined
--==============狗白又看你爹脚本是吧
local Utils<const> = require "lib.undefined.utils"
local Raycast<const> = require "lib.undefined.raycast"
local Player<const> = require "lib.undefined.player"
local Vehicle<const> = require "lib.undefined.vehicle"
local Ped<const> = require "lib.undefined.ped"
local CONSTANTS<const> = require "lib.undefined.constants"
local _Raycast<const> = CONSTANTS.RAYCAST

local function delete()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
    if not aimResult then
        return
    elseif aimResult.player then
        Utils.showToast("无法删除玩家.")
        return
    end

    entities.delete_by_handle(aimResult.entity)
end

local function burn()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
    if aimResult then
        if aimResult.player then
            Player.burn(aimResult.entity)
        else
            Ped.burn(aimResult.entity)
        end
    end
end

local function ragdoll()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
    if aimResult then
        Ped.ragdoll(aimResult.entity)
    end
end

local function explode()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
    if aimResult then
        Ped.explode(aimResult.entity)
    end
end

local function clone()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
    if aimResult then
        Ped.clone(aimResult.entity)
    end
end

---@param enabled boolean
local function freeze(enabled)
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
    if aimResult then
        if aimResult.player then
            Player.freeze(aimResult.player, enabled)
        else
            Ped.freeze(aimResult.entity, enabled)
        end
    end
end

local function cage()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
    if not aimResult then
        return
    elseif not aimResult.player then
        Utils.showToast("只对玩家有效.")
        return
    end

    Player.cage(aimResult.player, aimResult.entity)
end

local function heal()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
    if not aimResult then
        return
    elseif aimResult.player then
        Player.heal(aimResult.player)
        return
    elseif not ENTITY.IS_ENTITY_DEAD(aimResult.entity) then
        Utils.showToast("这个NPC还没死，你复活个毛.")
        return
    end

    Ped.revive(aimResult.entity)
end

local function disarm()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
    if not aimResult then
        return
    end

    if aimResult.player then
        Player.disarm(aimResult.player)
    else
        Ped.disarm(aimResult.entity)
    end
end

local function shoot()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
    if not aimResult then
        return
    end

    Ped.shoot(aimResult.entity)
end

local function kick()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
    if not aimResult then
        return
    elseif not aimResult.player then
        Utils.showToast("踢出只对玩家有效.")
        return
    end

    Player.kick(aimResult.player)
end

local function openStand()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
    if not aimResult then
        return
    elseif not aimResult.player then
        Utils.showToast("这只对玩家有效")
        return
    end

    menu.trigger_commands("p" .. Player.getPlayerName(aimResult.player, true))
end

local function crash()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
    if not aimResult then
        return
    elseif not aimResult.player then
        Utils.showToast("这只对玩家有效.")
        return
    end

    menu.trigger_commands("崩溃" .. Player.getPlayerName(aimResult.player, true))
end

local function tpToPed()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
    if not aimResult then
        return
    end

    local entCoords = ENTITY.GET_ENTITY_COORDS(aimResult.entity)
    local entityToTeleport = Vehicle.getPlayerOrVehicleEntity()
    if not entityToTeleport then
        return
    end

    ENTITY.SET_ENTITY_COORDS(entityToTeleport, entCoords.x, entCoords.y, entCoords.z, false, false, false, false)
end

---@param aimPedsSubmenu CommandRef
local function setupPedAimActions(aimPedsSubmenu)
    menu.action(aimPedsSubmenu, "删除", {}, "删除NPC。不适用于玩家", delete)
    menu.action(aimPedsSubmenu, "火烧", {}, "把瞄准的人火烧。对于NPC，您必须靠近他们才能使其发挥作用.", burn)
    menu.action(aimPedsSubmenu, "玩偶", {}, "", ragdoll)
    menu.action(aimPedsSubmenu, "爆炸", {}, "爆炸目标.", explode)
    menu.action(aimPedsSubmenu, "克隆", {}, "克隆目标.", clone)
    menu.action(aimPedsSubmenu, "笼子", {}, "关他笼子.", cage)
    menu.action(aimPedsSubmenu, "移除装备", {}, "移除他身上的装备.", disarm)
    menu.action(aimPedsSubmenu, "冻结", {}, "冻结他.", function()
        freeze(true)
    end)
    menu.action(aimPedsSubmenu, "取消冻结", {}, "取消冻结.", function()
        freeze(false)
    end)
    menu.action(aimPedsSubmenu, "踢出", {}, "从战局中踢出玩家.", kick)
    menu.action(aimPedsSubmenu, "在Stand中打开", {}, "使用Stand部分功能捏.", openStand)
    menu.action(aimPedsSubmenu, "复活", {}, "复活并为目标玩家提供护甲或复活一名已死亡的玩家.", heal)
    menu.action(aimPedsSubmenu, "传送到npc", {}, "将自己传送到目标位置.", tpToPed)
    menu.action(aimPedsSubmenu, "射击", {}, "用重型狙击子弹射击瞄准目标。你会以凶手的身份出现.", shoot)
    menu.action(aimPedsSubmenu, "崩溃", {}, "使用Stand对目标的优雅崩溃.", crash)
end

return setupPedAimActions
