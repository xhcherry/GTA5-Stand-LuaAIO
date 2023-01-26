-- Undefined
--==============狗白又看你爹脚本是吧
local Utils<const> = require "undefined.utils"
local Player<const> = require "undefined.player"
local Ped<const> = require "undefined.ped"
local Vehicle<const> = require "undefined.vehicle"

---@param maliciousSubmenu CommandRef
---@param pid Player
local function setupPlayerMaliciousMenu(maliciousSubmenu, pid)
    menu.action(maliciousSubmenu, "从前从前超级崩", {Utils.getCommandName("carcrash")}, "这也会使玩家在目标附近崩溃!", function()
        local pCoords<const> = Player.getPlayerPosition(pid)
        local trafficLights = {}

        util.request_model(-655644382) -- traffic lights
        local tCoords = v3.new(pCoords)
        for i = 1, 20 do
            tCoords.x = tCoords.x + Utils.rand(-5, 5)
            tCoords.y = tCoords.y + Utils.rand(-5, 5)
            tCoords.z = tCoords.z + Utils.rand(-1, 0)
            local object = entities.create_object(-655644382, tCoords)
            ENTITY.SET_ENTITY_ROTATION(object, 0, 0, Utils.rand(0, 360), 1, true)
            trafficLights[#trafficLights + 1] = object
        end

        local stopLights = false

        util.create_tick_handler(function()
            if stopLights then
                return false
            end
            ENTITY.SET_ENTITY_TRAFFICLIGHT_OVERRIDE(trafficLights[Utils.rand(1, #trafficLights)], Utils.rand(0, 3))
        end)

        util.request_model(3253274834) -- buffalo
        local vehicles = {}
        local crashVehicle = entities.create_vehicle(3253274834, pCoords, 0)
        vehicles[#vehicles + 1] = crashVehicle
        VEHICLE.SET_VEHICLE_MOD_KIT(crashVehicle, 0)
        Vehicle.setVehiclePlate(crashVehicle, "ICRASHU")
        VEHICLE.SET_VEHICLE_MOD(crashVehicle, 34, 3)
        for i = 1, 10 do
            local cloneVehicle = Vehicle.clone(crashVehicle)
            vehicles[#vehicles + 1] = cloneVehicle
        end

        util.yield(3000)
        for i = 1, #vehicles do
            Vehicle.delete(vehicles[i])
        end

        util.yield(5000)
        stopLights = true
        util.yield(500)
        for i = 1, #trafficLights do
            entities.delete_by_handle(trafficLights[i])
        end
    end)

    menu.action(maliciousSubmenu, "杀死被动玩家", {}, "在被动模式下立即杀死玩家，也适用于正常模式.", function()
        local ped = Player.getPlayerPed(pid)
        local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
        local weaponHash = Utils.requestWeaponAsset("WEAPON_HEAVYSNIPER_MK2")
        local randPed = entities.create_ped(0, ENTITY.GET_ENTITY_MODEL(ped), pedCoords, 0)
        ENTITY.SET_ENTITY_VISIBLE(randPed, false)
        Player.freeze(pid, true)
        for i = 1, 50 do
            local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pedCoords.x, pedCoords.y, pedCoords.z + 1, pedCoords.x, pedCoords.y, pedCoords.z, 1000, false, weaponHash, randPed, false, true,
                1000)
            util.yield()
        end
        util.yield(1000)
        entities.delete_by_handle(randPed)
        Player.freeze(pid, false)
    end)

    menu.action(maliciousSubmenu, "杀死室内玩家", {}, "在室内杀死玩家，可能并不总是有效.", function()
        local ped = Player.getPlayerPed(pid)
        local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
        local weaponHash = Utils.requestWeaponAsset("weapon_stungun")
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pedCoords.x, pedCoords.y, pedCoords.z + 1, pedCoords.x, pedCoords.y, pedCoords.z, 1000, false, weaponHash, Player.getPlayerPed(),
            false, true, 1000)
    end)
end

return setupPlayerMaliciousMenu
