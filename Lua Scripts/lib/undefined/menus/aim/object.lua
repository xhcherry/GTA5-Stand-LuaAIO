-- Undefined
--==============狗白又看你爹脚本是吧
local Utils<const> = require "lib.undefined.utils"
local Raycast<const> = require "lib.undefined.raycast"
local CONSTANTS<const> = require "lib.undefined.constants"
local _Raycast<const> = CONSTANTS.RAYCAST

local function delete()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.objects)
    if not aimResult then
        return
    end

    entities.delete_by_handle(aimResult.entity)
end

local function clone()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.objects)
    if not aimResult then
        return
    end

    local hash = ENTITY.GET_ENTITY_MODEL(aimResult.entity)
    aimResult.coords.y = aimResult.coords.y + 2
    entities.create_object(hash, aimResult.coords)
end

local function rotate()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.objects)
    if not aimResult then
        return
    end

    local currentRotation = ENTITY.GET_ENTITY_ROTATION(aimResult.entity, 2)
    ENTITY.SET_ENTITY_ROTATION(aimResult.entity, currentRotation.x, currentRotation.y, currentRotation.z + 40, 2, true)
end

local movedObject = 0
local function move()
    if UND_currentlyMovedObject == 2 then -- Vehicle is currently being moved
        return
    end

    if movedObject > 0 then
        local aimResult = Raycast.getPlayerAimData()
        if not aimResult then
            return
        end
        local coords = aimResult.coords
        ENTITY.SET_ENTITY_COORDS(movedObject, coords.x, coords.y, coords.z, false, false, false)
        movedObject = 0
        util.yield()
        UND_currentlyMovedObject = 0
        return
    end

    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.objects)
    if not aimResult then
        return
    end

    movedObject = aimResult.entity
    UND_currentlyMovedObject = 1
    util.create_tick_handler(function()
        if movedObject == 0 then
            return false
        end

        directx.draw_text(0.5, 0.8, "将目标移动到...", 5, 0.6, {
            r = 1,
            g = 1,
            b = 1,
            a = 1
        }, false)
    end)
end

local function freeze()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.objects)
    if not aimResult then
        return
    end

    ENTITY.FREEZE_ENTITY_POSITION(aimResult.entity, true)
end

local function unfreeze()
    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.objects)
    if not aimResult then
        return
    end

    ENTITY.FREEZE_ENTITY_POSITION(aimResult.entity, false)
end

---@param aimObjectsSubmenu CommandRef
local function setupObjectAimActions(aimObjectsSubmenu)
    menu.action(aimObjectsSubmenu, "删除", {}, "删除目标.", delete)
    menu.action(aimObjectsSubmenu, "克隆", {}, "克隆目标.", clone)
    menu.action(aimObjectsSubmenu, "旋转", {}, "旋转目标.", rotate)
    menu.action(aimObjectsSubmenu, "移动", {},
        "瞄准要移动的对象并按热键。然后瞄准要放置对象的位置，然后再次按下热键。如果你离原始物体太远，物体就会丢失.",
        move)
    menu.action(aimObjectsSubmenu, "冻结", {}, "冻结目标.", freeze)
    menu.action(aimObjectsSubmenu, "取消冻结", {}, "取消冻结.", unfreeze)
end

return setupObjectAimActions
