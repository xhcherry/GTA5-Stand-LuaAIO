--GNAB
local __luapack_arg__ = arg
package.preload["src.lib.menus.online.esp"] = function(...)

end
package.loaded["src.lib.menus.online.esp"] = nil
package.preload["src.lib.menus.player.vehicle"] = function(...)
	
end
package.loaded["src.lib.menus.player.vehicle"] = nil
package.preload["src.lib.raycast"] = function(...)	local Raycast = {}
	local function aimLockEntityTicker()
	    if not UND_aimLockEndTime then
	        return
	    end
	    if not UND_aimLockEnabled or not ENTITY.DOES_ENTITY_EXIST(UND_aimLockEntity.entity) or (UND_aimLockTime > 0 and Utils.getTime() >= UND_aimLockEndTime) then
	        UND_aimLockEntity = nil
	        UND_aimLockEndTime = nil
	        return
	    end
	end
	local function resetAimLockTime()
	    if not UND_aimLockEndTime then
	        UND_aimLockEndTime = Utils.getTime(UND_aimLockTime * 1000)
	    end
	end
	function Raycast.getOffsetFromCam(dist)
	    local dir = CAM.GET_GAMEPLAY_CAM_ROT(2):toDir()
	    local pos = CAM.GET_GAMEPLAY_CAM_COORD()
	    dir:mul(dist)
	    local offset = v3.new(pos)
	    offset:add(dir)
	    return pos, offset
	end
	local hitPointer = memory.alloc(1)
	local entityShapePointer = memory.alloc_int()	local function getRaycastData()
	    local dist = 1000
	    local result = {}
	    local coords = v3.new()
	    local normal = v3.new()
	    local camPos, offset = Raycast.getOffsetFromCam(dist)
	    local handle = SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(camPos.x, camPos.y, camPos.z, offset.x, offset.y, offset.z, CONSTANTS.RAYCAST.TraceFlag.all,
	        players.user_ped(), 4)
	    SHAPETEST.GET_SHAPE_TEST_RESULT(handle, hitPointer, coords, normal, entityShapePointer)
	    result.hit = memory.read_ubyte(hitPointer) == 1
	    result.entity = memory.read_uint(entityShapePointer)
	    result.coords = coords
	    return result
	end
	local entityPointer = memory.alloc_int()
	local function getAimData(flag)
	    local allFlag = flag == CONSTANTS.RAYCAST.TraceFlag.all
	    local pedFlag = flag == CONSTANTS.RAYCAST.TraceFlag.peds or flag == CONSTANTS.RAYCAST.TraceFlag.all
	    local vehicleFlag = flag == CONSTANTS.RAYCAST.TraceFlag.vehicles or flag == CONSTANTS.RAYCAST.TraceFlag.all
	    local success = false
	    local result = {}
	    if WEAPON.GET_MAX_RANGE_OF_CURRENT_PED_WEAPON(Player.getPlayerPed()) < 130.0 then
	        return getRaycastData()
	    end
	    local pid = Player.getUserPlayer()
	    PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(pid, entityPointer)
	    if memory.addrof(entityPointer) == 0 then
	        return getRaycastData()
	    end
	    local entity = memory.read_uint(entityPointer)
	    if not PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(pid, entity) then
	        return getRaycastData()
	    end
	    local entityType = ENTITY.GET_ENTITY_TYPE(entity)
	    if entityType == 1 then
	        if PED.IS_PED_IN_ANY_VEHICLE(entity, false) then
	            if pedFlag and not allFlag then
	                return getRaycastData()
	            end
	            entity = PED.GET_VEHICLE_PED_IS_IN(entity)
	            success = true
	        elseif pedFlag then
	            success = true
	        end
	    elseif entityType == 2 and vehicleFlag then
	        success = true
	    end
	    if success and UND_aimModeActive then
	        result.hit = true
	        result.entity = entity
	        result.coords = ENTITY.GET_ENTITY_COORDS(entity)
	        return result
	    end
	    return getRaycastData()
	end
	local gameX, gameY = memory.alloc(1), memory.alloc(1)	local function getHudTarget()
	    local myVeh = Ped.getVehicle(Player.getPlayerPed())
	    for _, pid in players.list(false) do
	        local ped = Player.getPlayerPed(pid)
	        local pPos = Player.getPlayerPosition(pid)
	        local dist = v3.distance(Player.getPlayerPosition(), pPos)
	        if dist <= 300 and dist > 50 and ENTITY.IS_ENTITY_ON_SCREEN(ped) then
	            local vehicle = Ped.getVehicle(ped)
	            if vehicle and vehicle ~= myVeh then
	                local posToUse = pPos
	                if vehicle then
	                    posToUse = ENTITY.GET_ENTITY_COORDS(vehicle)
	                end
	                GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(posToUse.x, posToUse.y, posToUse.z + 1, gameX, gameY)
	                local screenX, screenY = memory.read_float(gameX), memory.read_float(gameY)
	                if screenX > 0.47 and screenX < 0.53 and screenY > 0.47 and screenY < 0.53 then
	                    return true, vehicle or ped, posToUse
	                end
	                return false
	            end
	        end
	    end
	end	function Raycast.getPlayerAimData(flag, isAimTeleport)
	    flag = flag or CONSTANTS.RAYCAST.TraceFlag.all
	    local pedFlag = flag == CONSTANTS.RAYCAST.TraceFlag.peds
	    local vehFlag = flag == CONSTANTS.RAYCAST.TraceFlag.vehicles
	    local objFlag = flag == CONSTANTS.RAYCAST.TraceFlag.objects
	    if not UND_aimModeActive and not UND_aimLockEntity and not isAimTeleport then
	        return nil
	    end
	    local isUserAiming = Player.isUserAiming()
	    if not UND_aimLockEntity and not isUserAiming then
	        return nil
	    end
	    local aimResult = getAimData(CONSTANTS.RAYCAST.TraceFlag.all)
	    local aimingOnLockedEntity = UND_aimLockEntity and UND_aimLockEntity.entity == aimResult.entity
	    if (isUserAiming and isAimTeleport and not aimResult.hit) or (isUserAiming and not UND_aimModeActive and UND_aimLockEntity and not isAimTeleport and not aimingOnLockedEntity) then
	        local hudResult, hudEntity, hudCoords = getHudTarget()
	        if not hudResult then
	            return nil
	        end
	        aimResult.entity = hudEntity
	        aimResult.coords = hudCoords
	    end
	    if UND_aimLockEntity and (not isUserAiming or (isUserAiming and not UND_aimModeActive and aimingOnLockedEntity)) then
	        if pedFlag and not UND_aimLockEntity.isPed then
	            return nil
	        end
	        if vehFlag and not UND_aimLockEntity.isVehicle then
	            return nil
	        end
	        if objFlag and not UND_aimLockEntity.isObject then
	            return nil
	        end
	        if not UND_aimLockEntity.isObject then
	            resetAimLockTime()
	        end
	        return UND_aimLockEntity
	    end	    if isAimTeleport and not UND_aimModeActive then
	        return aimResult
	    end
	    local entCoords = ENTITY.GET_ENTITY_COORDS(aimResult.entity)
	    local isPed = ENTITY.IS_ENTITY_A_PED(aimResult.entity)
	    local isVehicle = not isPed and ENTITY.IS_ENTITY_A_VEHICLE(aimResult.entity) and not VEHICLE.IS_THIS_MODEL_A_TRAIN(ENTITY.GET_ENTITY_MODEL(aimResult.entity))
	    local isObject = not isPed and not isVehicle and ENTITY.IS_ENTITY_AN_OBJECT(aimResult.entity) and v3.distance(Player.getPlayerPosition(), entCoords) < 50
	    if not isVehicle and not isPed and not isObject then
	        local closePed = Ped.getClosestPedToCoords(aimResult.coords)
	        if closePed then
	            entCoords = ENTITY.GET_ENTITY_COORDS(closePed)
	            aimResult.entity = closePed
	            aimResult.hit = true
	            isPed = true
	        else
	            local closeVehicle = Vehicle.getClosestVehicleToCoords(aimResult.coords, true)
	            if closeVehicle then
	                entCoords = ENTITY.GET_ENTITY_COORDS(closeVehicle)
	                aimResult.entity = closeVehicle
	                aimResult.hit = true
	                isVehicle = true
	            else
	                local hudResult, hudEntity, hudCoords = getHudTarget()
	                if hudResult then
	                    aimResult.entity = hudEntity
	                    aimResult.coords = hudCoords
	                    isPed = ENTITY.IS_ENTITY_A_PED(aimResult.entity)
	                    isVehicle = not isPed and ENTITY.IS_ENTITY_A_VEHICLE(aimResult.entity) and not VEHICLE.IS_THIS_MODEL_A_TRAIN(ENTITY.GET_ENTITY_MODEL(aimResult.entity))
	                end
	            end
	        end
	    end
	    if pedFlag and not isPed then
	        return nil
	    end
	    if vehFlag and not isVehicle then
	        return nil
	    end
	    if objFlag and not isObject then
	        return nil
	    end
	    aimResult.isPed = isPed
	    aimResult.isVehicle = isVehicle
	    aimResult.isObject = isObject
	    aimResult.player = nil
	    if isPed then
	        local player = Network.getPlayerFromPed(aimResult.entity)
	        if player ~= -1 then
	            aimResult.player = player
	        end
	    end
	    if isPed or isVehicle or isObject then
	        aimResult.coords = entCoords
	        if not isObject and UND_aimLockEnabled then
	            UND_aimLockEntity = aimResult
	            UND_aimLockEndTime = nil
	        end
	    end
	    if isVehicle then
	        aimResult.vehicle = ENTITY.GET_VEHICLE_INDEX_FROM_ENTITY_INDEX(aimResult.entity)
	        local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(aimResult.vehicle, -1, true)
	        if driver ~= 0 then
	            aimResult.driver = driver
	            local player = Network.getPlayerFromPed(aimResult.driver)
	            if player ~= -1 then
	                aimResult.player = player
	            end
	        end
	    end
	    return aimResult
	end
	util.create_tick_handler(aimLockEntityTicker)
	return Raycast
end
package.loaded["src.lib.raycast"] = nil
package.preload["src.lib.menus.aim.teleport"] = function(...)
	local keepSpeed = true
	local function aimTeleport()
	    local entityToTeleport = Vehicle.getPlayerOrVehicleEntity()
	    if not entityToTeleport or not Player.isUserAiming() then
	        return
	    end
	    local aimResult = Raycast.getPlayerAimData(nil, true)
	    if not aimResult or not aimResult.hit then
	        local tpFwdRef = menu.ref_by_path("Stand>Lua Scripts>Undefined>Teleport>Teleport forward")
	        menu.trigger_command(tpFwdRef)
	        return
	    end
	    local aimCoords = aimResult.coords
	    local curSpeed = ENTITY.GET_ENTITY_SPEED(entityToTeleport)
	    ENTITY.SET_ENTITY_COORDS(entityToTeleport, aimCoords.x, aimCoords.y, aimCoords.z, false, false, false, false)
	    if keepSpeed then
	        VEHICLE.SET_VEHICLE_FORWARD_SPEED(entityToTeleport, curSpeed)
	    end
	end
	local function setupAimTeleport(aimMenu)
	    menu.divider(aimMenu, UND_translations.aim.teleport .. " ")
	    local aimTeleportAction = menu.action(aimMenu, UND_translations.aim.teleport, {}, UND_translations.aim.teleportD, aimTeleport)
	    local keepSpeedToggle = menu.toggle(aimMenu, UND_translations.teleport.keepSpeed, {Utils.getCommandName("aimtpkeepspeed")}, UND_translations.teleport.keepSpeedD,
	        function(on)
	            keepSpeed = on
	        end, keepSpeed)
	    keepSpeed = menu.get_value(keepSpeedToggle)
	    return aimTeleportAction
	end
	return setupAimTeleport
end
package.loaded["src.lib.menus.aim.teleport"] = nil
package.preload["src.lib.menus.online"] = function(...)

end
--
require "lib.GTSCRIPTS.GTW.BANG"
--
package.loaded["src.lib.translations"] = nil
package.preload["src.lib.menus.online.killersList"] = function(...)

end
package.loaded["src.lib.menus.online.killersList"] = nil
package.preload["src.lib.menus.online.playersList"] = function(...)
	
end
package.loaded["src.lib.menus.online.playersList"] = nil
package.preload["src.lib.menus.player.sounds"] = function(...)

end
package.loaded["src.lib.menus.player.sounds"] = nil
package.preload["src.lib.menus.player.malicious"] = function(...)
	
end
package.loaded["src.lib.menus.player.malicious"] = nil
package.preload["src.lib.entity"] = function(...)
	local Entity = {}	function Entity.ram(entity)
	    util.create_thread(function()
	        local coords = ENTITY.GET_ENTITY_COORDS(entity)
	        local rot = ENTITY.GET_ENTITY_ROTATION(entity, 2):toDir()
	        local dir = 1
	        if Utils.rand() == 0 then
	            dir = -1
	        end
	        v3.mul(rot, 30 * dir)
	        v3.add(coords, rot)
	        local vehicle = Vehicle.spawnRandom(coords)
	        if UND_settings.ramType == UND_translations.general.invisible then
	            ENTITY.SET_ENTITY_VISIBLE(vehicle, false)
	        end
	        local curCoords = v3.lookAt(ENTITY.GET_ENTITY_COORDS(vehicle), ENTITY.GET_ENTITY_COORDS(entity))
	        ENTITY.SET_ENTITY_ROTATION(vehicle, curCoords.x, curCoords.y, curCoords.z, 2, true)
	        VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, 300)
	        VEHICLE.SET_DISABLE_MAP_COLLISION(vehicle)
	        util.yield(800)
	        Utils.deleteEntity(vehicle)
	        util.stop_thread()
	    end)
	end
	return Entity
end
package.loaded["src.lib.entity"] = nil
package.preload["src.lib.menus.player"] = function(...)

end
package.loaded["src.lib.menus.player"] = nil
package.preload["src.lib.network"] = function(...)
	local Network = {}
	function Network.getPlayerFromPed(ped)
	    return NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ped)
	end
	function Network.requestControlOnce(entity)
	    if not util.is_session_started() then
	        return true
	    end
	    local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
	    if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) or NETWORK.NETWORK_HAS_CONTROL_OF_NETWORK_ID(netId) then
	        return true
	    end
	    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
	    local gotAccess = NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity) and NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netId)
	    if not gotAccess then
	        gotAccess = NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity) and NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netId)
	    end
	    return gotAccess
	end
	function Network.requestControl(entity, timeout, dontShowError)
	    if not ENTITY.DOES_ENTITY_EXIST(entity) then
	        return false
	    end
	    timeout = timeout or 700
	    local endTime = Utils.getTime(timeout)
	    while not Network.requestControlOnce(entity) and Utils.getTime() < endTime do
	        util.yield_once()
	    end
	    local success = Utils.getTime() < endTime
	    if not success and not dontShowError then
	        Utils.showToast(UND_translations.general.noAccess)
	    end
	    return success
	end
	return Network
end
package.loaded["src.lib.network"] = nil
package.preload["src.lib.menus.teleport"] = function(...)
	local arg = __luapack_arg__
	local wpObjRel = menu.ref_by_path("World>Places>Waypoint On...>Objective")
	local function teleportToWaypoint()
	    local entityToTeleport = Vehicle.getPlayerOrVehicleEntity()
	    if not entityToTeleport then
	        return
	    end
	    local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
	    if blip == 0 then
	        menu.trigger_command(wpObjRel)
	        util.yield()
	        blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
	        if blip == 0 then
	            return
	        end
	    end
	    local pos = Utils.getBlipCoords(blip)
	    ENTITY.SET_ENTITY_COORDS(entityToTeleport, pos.x, pos.y, pos.z, false, false, false)
	end	local function teleportForward(tpForwardDistanceSlider, tpForwardGroundZToggle, keepSpeedToggle)
	    local entityToTeleport = Vehicle.getPlayerOrVehicleEntity()
	    if not entityToTeleport then
	        return
	    end
	    local tpPosition = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entityToTeleport, 0, menu.get_value(tpForwardDistanceSlider) * 0.1, 0)
	    if menu.get_value(tpForwardGroundZToggle) then
	        tpPosition = Utils.getGroundZPosition(tpPosition)
	    end
	    local curSpeed = ENTITY.GET_ENTITY_SPEED(entityToTeleport)
	    ENTITY.SET_ENTITY_COORDS(entityToTeleport, tpPosition.x, tpPosition.y, tpPosition.z, false, false, false)
	    if menu.get_value(keepSpeedToggle) then
	        VEHICLE.SET_VEHICLE_FORWARD_SPEED(entityToTeleport, curSpeed)
	    end
	end
	local function teleportToRandomPlayer(tpInVehToggle)
	    local pid = Utils.getRandomPlayer()
	    if pid == -1 then
	        return
	    end
	    local pCoords = Player.getPlayerPosition(pid)
	    local tries = 0
	    while tries < 5 and (v3.distance(pCoords, Player.getPlayerPosition()) < 30 or Player.isDead(pid) or Player.getInterior(pid) or Player.isLoading(pid)) do
	        pid = Utils.getRandomPlayer()
	        if pid == -1 then
	            return
	        end
	        pCoords = Player.getPlayerPosition(pid)
	        tries = tries + 1
	    end
	    local myPed = Player.getPlayerPed()
	    local targetPed = Player.getPlayerPed(pid)
	    local myVeh = Ped.getVehicle(myPed)
	    local coords = Utils.rotateToEntity(targetPed, pCoords)
	    if myVeh and myVeh > 0 and VEHICLE.GET_PED_IN_VEHICLE_SEAT(myVeh, -1) == myPed and menu.get_value(tpInVehToggle) then
	        ENTITY.SET_ENTITY_COORDS(myVeh, coords.x, coords.y, coords.z, false, false, false)
	        Utils.rotateToEntity(targetPed)
	    else
	        ENTITY.SET_ENTITY_COORDS(myPed, coords.x, coords.y, coords.z, false, false, false)
	        Utils.rotateToEntity(targetPed)
	        local maxTime = Utils.getTime(1500)
	        while not PED.IS_PED_IN_ANY_VEHICLE(targetPed, false) do
	            if Utils.getTime() > maxTime then
	                break
	            end
	            util.yield()
	        end
	        if PED.IS_PED_IN_ANY_VEHICLE(targetPed, false) then
	            local vehicle = PED.GET_VEHICLE_PED_IS_IN(targetPed, false)
	            if VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
	                PED.SET_PED_INTO_VEHICLE(myPed, vehicle, -2)
	            end
	        end
	    end
	end
	local function setupTeleportMenu()
	    local teleportMenu = menu.list(menu.my_root(), UND_translations.teleport.name, {}, "")
	    menu.action(teleportMenu, UND_translations.teleport.tpToWp, {Utils.getCommandName("tpwp")}, UND_translations.teleport.tpToWpD, teleportToWaypoint)
	    menu.divider(teleportMenu, UND_translations.teleport.tpFwd .. " ")
	    local tpForwardDistanceSlider = menu.slider(teleportMenu, UND_translations.teleport.tpFwdDist, {Utils.getCommandName("tpfwddist")}, "", 5, 500, 200, 5,
	        Utils.emptyFunction)
	    local tpForwardGroundZToggle = menu.toggle(teleportMenu, UND_translations.teleport.tpFwdForceGround, {Utils.getCommandName("tpfwdground")},
	        UND_translations.teleport.tpFwdForceGroundD, Utils.emptyFunction, true)
	    local keepSpeedToggle = menu.toggle(teleportMenu, UND_translations.teleport.keepSpeed, {Utils.getCommandName("tpfwdkeepspeed")}, UND_translations.teleport.keepSpeedD,
	        Utils.emptyFunction, true)
	    menu.action(teleportMenu, UND_translations.teleport.tpFwd, {Utils.getCommandName("tpfwd")}, "", function()
	        teleportForward(tpForwardDistanceSlider, tpForwardGroundZToggle, keepSpeedToggle)
	    end)
	    menu.divider(teleportMenu, UND_translations.teleport.tpToRandomPlayer .. " ")
	    local tpInVehToggle = menu.toggle(teleportMenu, UND_translations.teleport.tpInVehicle, {Utils.getCommandName("tpinvehicle")}, "", Utils.emptyFunction, true)
	    menu.action(teleportMenu, UND_translations.teleport.tpToRandomPlayer, {Utils.getCommandName("tprandomplayer")}, "", function()
	        teleportToRandomPlayer(tpInVehToggle)
	    end)
	end
	return setupTeleportMenu
end
package.loaded["src.lib.menus.teleport"] = nil
package.preload["src.lib.menus.main"] = function(...)
	local setupAimMenu = require "src.lib.menus.aim"
	local setupSelfMenu = require "src.lib.menus.self"
	local setupSessionMenu = require "src.lib.menus.online"
	local setupTeleportMenu = require "src.lib.menus.teleport"
	local setupVehicleMenu = require "src.lib.menus.vehicle"
	local setupWorldMenu = require "src.lib.menus.world"
	local setupPlayerMenu = require "src.lib.menus.player"
	local setupSettingsMenu = require "src.lib.menus.settings"
	local function startScript()
	    math.randomseed(util.current_time_millis())
	    math.random()
	    math.random()
	    math.random()
	    local rootMenu = menu.my_root()
	    setupAimMenu()
	end
	startScript()
end
package.loaded["src.lib.menus.main"] = nil
package.preload["src.lib.menus.world"] = function(...)

end
package.loaded["src.lib.menus.world"] = nil
package.preload["src.lib.menus.online.playerKicker.forceHost"] = function(...)
	
end
package.loaded["src.lib.menus.online.playerKicker.forceHost"] = nil
package.preload["src.lib.player"] = function(...)
	local Player = {}
	function Player.getWantedLevel(pid)
	    return PLAYER.GET_PLAYER_WANTED_LEVEL(pid)
	end
	function Player.makeWanted(pid, forceLevel)
	    pid = pid or Player.getUserPlayer()
	    local level = forceLevel or (math.tointeger(UND_settings.makeWantedLevel) - 2)
	    if level == -1 then
	        level = Utils.rand(0, 5)
	    end
	    players.set_wanted_level(pid, level)
	end	function Player.placeBounty(pid)
	    pid = pid or Player.getUserPlayer()
	    local pName = Player.getPlayerName(pid, true)
	    local amount = math.tointeger(UND_settings.bountyAmount) - 1
	    if amount == 0 then
	        amount = Utils.rand(1, 10000)
	    else
	        amount = amount * 1000
	    end
	    menu.trigger_commands("bounty" .. pName .. " " .. amount)
	end
	function Player.isPlayerNeverWanted(pid)
	    local menuRef = menu.ref_by_command_name("bail" .. Player.getPlayerName(pid))
	    return players.exists(pid) and menuRef:isValid() and menuRef.value
	end
	function Player.getPlayerName(pid, lowercase, addTags)
	    pid = pid or Player.getUserPlayer()
	    local name
	    if addTags then
	        name = players.get_name_with_tags(pid)
	    else
	        name = players.get_name(pid)
	    end
	    if lowercase then
	        return name:lower()
	    end
	    return name
	end	function Player.isUserAiming()
	    if (UND_aimModeActiveAsAimButton and UND_aimModeActive) or util.is_key_down(0x02) or PAD.IS_CONTROL_PRESSED(25, 25) then
	        return true
	    end
	    return false
	end
	function Player.getPlayerPed(pid)
	    if not pid then
	        return players.user_ped()
	    end
	    return PLAYER.GET_PLAYER_PED(pid)
	end	function Player.getUserPlayer()
	    return players.user()
	end
	function Player.getPlayerPosition(pid)
	    pid = pid or Player.getUserPlayer()
	    return players.get_position(pid)
	end
	function Player.getPlayerRank(pid)
	    pid = pid or Player.getUserPlayer()
	    return players.get_rank(pid)
	end
	function Player.getInterior(pid)
	    pid = pid or Player.getUserPlayer()
	    local pos = Player.getPlayerPosition(pid)
	    local interior = INTERIOR.GET_INTERIOR_FROM_COLLISION(pos.x, pos.y, pos.z)
	    if interior > 0 then
	        for name, val in CONSTANTS.GAME.INTERIOR_IDS do
	            if val == interior then
	                local hasNumber = string.find(name, "%d")
	                if hasNumber then
	                    return name:gsub('%d', '')
	                end
	                return name
	            end
	        end
	    end	    local function checkCoordsFor(name)
	        if name == "kosatka" and checkCoordsFor("kosatkaMissile") then
	            return "kosatkaMissile"
	        end
	        local coords = CONSTANTS.GAME.INTERIOR_COORDS[name]
	        if pos.x >= coords[1] and pos.x <= coords[2] and pos.y >= coords[3] and pos.y <= coords[4] then
	            if not coords[5] or (pos.z >= coords[5] and pos.z <= coords[6]) then
	                local hasNumber = string.find(name, "%d")
	                if hasNumber then
	                    return name:gsub('%d', '')
	                end
	                return name
	            end
	        end
	    end
	    for name in CONSTANTS.GAME.INTERIOR_COORDS do
	        local interiorName = checkCoordsFor(name)
	        if interiorName then
	            return interiorName
	        end
	    end
	    if players.is_in_interior(pid) then
	        return "interior"
	    end
	    return nil
	end
	function Player.isLoading(pid)
	    if not util.is_session_started() then
	        return false
	    end
	    local pPos = Player.getPlayerPosition(pid)
	    if pPos.x == 0 and pPos.y == 0 and pPos.z == 0 then
	        return true
	    end
	    if ENTITY.GET_ENTITY_SPEED(Player.getPlayerPed(pid)) < 1 then
	        if Player.getPlayerRank(pid) == 0 then
	            return true
	        end
	        if Player.getMoney(pid) == 0 and Player.getKD(pid) == 0 then
	            return true
	        end
	    end
	    if NETWORK.IS_PLAYER_IN_CUTSCENE(pid) then
	        return true
	    end
	    return false
	end
	function Player.isModder(pid)
	    pid = pid or Player.getUserPlayer()
	    return players.is_marked_as_modder(pid)
	end
	function Player.isModderOrAdmin(pid)
	    pid = pid or Player.getUserPlayer()
	    return players.is_marked_as_modder_or_admin(pid)
	end
	function Player.isAdmin(pid)
	    pid = pid or Player.getUserPlayer()
	    return players.is_marked_as_admin(pid)
	end
	function Player.isFriend(player)
	    for _, pid in players.list(false, true, false) do
	        if player == pid then
	            return true
	        end
	    end
	    return false
	end
	function Player.isDead(pid)
	    pid = pid or Player.getUserPlayer()
	    return PLAYER.IS_PLAYER_DEAD(pid)
	end
	function Player.isOTR(pid)
	    pid = pid or Player.getUserPlayer()
	    return players.is_otr(pid)
	end	function Player.getMoney(pid, shorten)
	    pid = pid or Player.getUserPlayer()
	    local money = players.get_money(pid)
	    if not shorten then
	        return money
	    end
	    local length = string.len(tostring(money))
	    if length < 4 then
	        return money
	    elseif length < 7 then
	        return string.format("%.2fK", money / 1000)
	    elseif length < 10 then
	        return string.format("%.2fM", money / 1000000)
	    end
	    return string.format("%.2fB", money / 1000000000)
	end
	local r, g, b, a = memory.alloc(1), memory.alloc(1), memory.alloc(1), memory.alloc(1)
	function Player.getOrgColor(pid)
	    pid = pid or Player.getUserPlayer()
	    local orgColorIdx = players.get_org_colour(pid)
	    if orgColorIdx == -1 then
	        return -1
	    end
	    HUD.GET_HUD_COLOUR(orgColorIdx + 192, r, g, b, a)
	    local color = {
	        r = memory.read_ubyte(r) / 255,
	        g = memory.read_ubyte(g) / 255,
	        b = memory.read_ubyte(b) / 255,
	        a = 1
	    }
	    return color
	end
	function Player.getLanguage(pid)
	    pid = pid or Player.getUserPlayer()
	    return CONSTANTS.GAME.LANGUAGES[players.get_language(pid)]
	end
	function Player.getKD(pid)
	    pid = pid or Player.getUserPlayer()
	    return math.floor(players.get_kd(pid) * 100) / 100
	end	function Player.disarm(player)
	    menu.trigger_commands("disarm" .. Player.getPlayerName(player, true))
	end	function Player.kick(player)
	    local pName = Player.getPlayerName(player)
	    menu.trigger_commands("breakup" .. pName:lower())
	end	function Player.crash(player)
	    menu.trigger_commands("crash" .. Player.getPlayerName(player, true))
	end	function Player.heal(player)
	    for i = 1, 3 do
	        players.give_pickup_reward(player, "REWARD_HEALTH")
	        players.give_pickup_reward(player, "REWARD_ARMOUR")
	        util.yield()
	    end
	end
	function Player.freeze(player, enabled)
	    local value = "off"
	    if enabled then
	        value = "on"
	    end
	    menu.trigger_commands("freeze" .. Player.getPlayerName(player, true) .. " " .. value)
	end	function Player.isSpectated(player)
	    local playerName = Player.getPlayerName(player, false, true)
	    local ninjaRef = menu.ref_by_path("Players>" .. playerName .. ">Spectate>Nuts Method")
	    local legitRef = menu.ref_by_path("Players>" .. playerName .. ">Spectate>Legit Method")
	    return menu.get_value(ninjaRef) or menu.get_value(legitRef)
	end
	function Player.tempSpectate(player, stopCondition)
	    if v3.distance(Player.getPlayerPosition(player), Player.getPlayerPosition()) < 200 or Player.isSpectated(player) then
	        return
	    end
	    util.create_thread(function()
	        menu.trigger_commands("spectate" .. Player.getPlayerName(player, true) .. " on")
	        local maxTime = Utils.getTime(1500)
	        if not stopCondition then
	            util.yield(500)
	        end
	        while stopCondition and not stopCondition(player) do
	            if Utils.getTime() > maxTime then
	                break
	            end
	            util.yield()
	        end
	        menu.trigger_commands("spectate" .. Player.getPlayerName(player, true) .. " off")
	        util.stop_thread()
	    end)
	end
	return Player
end
package.loaded["src.lib.player"] = nil
package.preload["src.lib.menus.settings"] = function(...)
	
end
package.loaded["src.lib.menus.settings"] = nil
package.preload["src.lib.menus.aim.settings"] = function(...)
	local pedAimTextToRender = ""
	local vehicleAimTextToRender = ""
	local objectAimTextToRender = ""
	local aimTeleportHotkeyAssigned = false
	local hotkeysColor = CONSTANTS.SCRIPT.COLORS.AIM.hotkeys
	local lineColor = CONSTANTS.SCRIPT.COLORS.AIM.line
	local highlightColor = CONSTANTS.SCRIPT.COLORS.AIM.highlight
	local markColor = CONSTANTS.SCRIPT.COLORS.AIM.mark
	local typeColor = {}
	typeColor.r = hotkeysColor.r / 0.2
	typeColor.g = hotkeysColor.g / 0.2
	typeColor.b = hotkeysColor.b / 0.2
	typeColor.a = hotkeysColor.a
	local xValue, yValue, scaleValue = 50, 90, 60
	local nameEnabled, hotkeysEnabled, lineEnabled, highlightEnabled, beaconEnabled, showHealth = true, true, true, true, true, true
	local pedMarkAction = CONSTANTS.SCRIPT.MARK_ACTIONS.peds[1]
	local vehMarkAction = CONSTANTS.SCRIPT.MARK_ACTIONS.vehicles[1]
	local keepMarked = false
	local function setAimHotkeys()
	    local hotkeysFileName = filesystem.stand_dir() .. '\\' .. 'Hotkeys.txt'
	    local hotkeysFile = util.read_colons_and_tabs_file(hotkeysFileName)
	    pedAimTextToRender = ""
	    vehicleAimTextToRender = ""
	    objectAimTextToRender = ""
	    aimTeleportHotkeyAssigned = false
	    local assignedPedHotkeysCount = 0
	    local assignedPedHotkeys = false
	    local assignedVehicleHotkeysCount = 0
	    local assignedVehicleHotkeys = false
	    local assignedObjectHotkeysCount = 0
	    local maxHotkeysPerLine = 8
	    --[[for key, hotkey in hotkeysFile do
	        if menu.ref_by_path(key):isValid() and key:contains(SCRIPT_NAME) and key:contains(UND_translations.aim.name) then
	            if key:contains(UND_translations.vehicle.name) then
	                local menuAction = menu.get_menu_name(menu.ref_by_path(key))
	                local hotkeyAction = menuAction .. ": " .. hotkey
	                assignedVehicleHotkeysCount = assignedVehicleHotkeysCount + 1
	                assignedVehicleHotkeys = true
	                if assignedVehicleHotkeysCount > maxHotkeysPerLine then
	                    hotkeyAction = hotkeyAction .. "\n"
	                    assignedVehicleHotkeysCount = 0
	                end
	                vehicleAimTextToRender = vehicleAimTextToRender .. "  " .. hotkeyAction
	            elseif key:contains(UND_translations.aim.peds) then
	                local menuAction = menu.get_menu_name(menu.ref_by_path(key))
	                local hotkeyAction = menuAction .. ": " .. hotkey
	                assignedPedHotkeysCount = assignedPedHotkeysCount + 1
	                assignedPedHotkeys = true
	                if assignedPedHotkeysCount > maxHotkeysPerLine then
	                    hotkeyAction = hotkeyAction .. "\n"
	                    assignedPedHotkeysCount = 0
	                end
	                pedAimTextToRender = pedAimTextToRender .. "  " .. hotkeyAction
	            elseif key:contains(UND_translations.aim.objects) then
	                local menuAction = menu.get_menu_name(menu.ref_by_path(key))
	                local hotkeyAction = menuAction .. ": " .. hotkey
	                assignedObjectHotkeysCount = assignedObjectHotkeysCount + 1
	                if assignedObjectHotkeysCount > maxHotkeysPerLine then
	                    hotkeyAction = hotkeyAction .. "\n"
	                    assignedObjectHotkeysCount = 0
	                end
	                objectAimTextToRender = objectAimTextToRender .. "  " .. hotkeyAction
	            end
	        end
	        if key:contains(SCRIPT_NAME) and key:contains(UND_translations.aim.teleport) then
	            aimTeleportHotkeyAssigned = true
	        end
	    end
	    if not assignedPedHotkeys then
	        pedAimTextToRender = UND_translations.aim.noAssignedHotkeysPeds
	    end
	    if not assignedVehicleHotkeys then
	        vehicleAimTextToRender = UND_translations.aim.noAssignedHotkeysVehs
	    end]]
	end
	local function onAim()
	    if not beaconEnabled and not aimTeleportHotkeyAssigned and not highlightEnabled and not hotkeysEnabled and not lineEnabled then
	        return
	    end
	    local aimResult = Raycast.getPlayerAimData(nil, true)
	    if not aimResult then
	        return
	    end
	    local isTargetable = aimResult.isVehicle or aimResult.isPed or aimResult.isObject
	    if aimTeleportHotkeyAssigned and beaconEnabled and not isTargetable and v3.distance(aimResult.coords, Player.getPlayerPosition()) > 15 then
	        util.draw_ar_beacon(aimResult.coords)
	    end
	    if (highlightEnabled or lineEnabled or hotkeysEnabled) and isTargetable then
	        if highlightEnabled then
	            Utils.drawBox(aimResult.entity, highlightColor)
	        end
	        if lineEnabled then
	            local pCoords = Player.getPlayerPosition()
	            local entCoords = ENTITY.GET_ENTITY_COORDS(aimResult.entity)
	            GRAPHICS.DRAW_LINE(pCoords.x, pCoords.y, pCoords.z, entCoords.x, entCoords.y, entCoords.z, lineColor.r, lineColor.g, lineColor.b, lineColor.a)
	        end
	        if hotkeysEnabled or nameEnabled then
	            local textToRender = ""
	            local typeToRender = ""
	            if aimResult.isVehicle then
	                if hotkeysEnabled then
	                    textToRender = vehicleAimTextToRender
	                end
	                if nameEnabled then
	                    typeToRender = UND_translations.vehicle.name
	                    local vehName = Vehicle.getName(ENTITY.GET_ENTITY_MODEL(aimResult.entity))
	                    if vehName ~= "" then
	                        typeToRender = typeToRender .. " - " .. vehName
	                    end
	                    if aimResult.player then
	                        typeToRender = typeToRender .. " (" .. Player.getPlayerName(aimResult.player, false, true) .. ")"
	                    end
	                end
	            elseif aimResult.isPed then
	                if hotkeysEnabled then
	                    textToRender = pedAimTextToRender
	                end
	                if nameEnabled then
	                    typeToRender = UND_translations.aim.ped
	                    if aimResult.player then
	                        typeToRender = typeToRender .. " (" .. Player.getPlayerName(aimResult.player, false, true) .. ")"
	                    end
	                end
	                if showHealth then
	                    local hpData = Ped.getHealth(aimResult.entity)
	                    typeToRender = typeToRender .. " [H: " .. hpData.health .. "/" .. hpData.maxHealth .. " "
	                    typeToRender = typeToRender .. "A: " .. hpData.armor .. "/50]"
	                end
	            elseif hotkeysEnabled then
	                textToRender = objectAimTextToRender
	            end
	            if nameEnabled or showHealth then
	                local offset = 0
	                if hotkeysEnabled then
	                    local multiplier = 0.1
	                    if textToRender:len() > 500 then
	                        multiplier = 0.12
	                    end
	                    offset = multiplier * scaleValue
	                end
	                directx.draw_text(xValue, yValue - offset, typeToRender, 5, scaleValue, typeColor, false)
	            end
	            if hotkeysEnabled then
	                directx.draw_text(xValue, yValue, textToRender, 5, scaleValue, hotkeysColor, false)
	            end
	        end
	    end
	end
	local function markTargets()
	    if #UND_markedTargets > 0 then
	        for idx, entity in UND_markedTargets do
	            if ENTITY.DOES_ENTITY_EXIST(entity) and not ENTITY.IS_ENTITY_DEAD(entity) then
	                Utils.drawBox(entity, markColor)
	            end
	        end
	    end
	end
	local function unmarkAll()
	    for i = 1, #UND_markedTargets do
	        table.remove(UND_markedTargets, 1)
	    end
	end
	local function triggerMarkAction()
	    if #UND_markedTargets > 0 then
	        for _, entity in UND_markedTargets do
	            if ENTITY.DOES_ENTITY_EXIST(entity) and not ENTITY.IS_ENTITY_DEAD(entity) then
	                if ENTITY.IS_ENTITY_A_PED(entity) then
	                    if pedMarkAction == "shoot" then
	                        Ped.shoot(entity)
	                    elseif pedMarkAction == "explode" then
	                        Ped.explode(entity)
	                    elseif pedMarkAction == "atomize" then
	                        Ped.atomize(entity)
	                    elseif pedMarkAction == "fireworks" then
	                        Ped.fireworks(entity)
	                    elseif pedMarkAction == "burn" then
	                        Ped.burn(entity)
	                    end
	                else
	                    if vehMarkAction == "explode" then
	                        Vehicle.explode(entity)
	                    elseif vehMarkAction == "damage" then
	                        Vehicle.damage(entity)
	                    elseif vehMarkAction == "emp" then
	                        Vehicle.emp(entity)
	                    elseif vehMarkAction == "atomize" then
	                        Vehicle.atomize(entity)
	                    elseif vehMarkAction == "fireworks" then
	                        Vehicle.fireworks(entity)
	                    elseif vehMarkAction == "burn" then
	                        Vehicle.burn(entity)
	                    elseif vehMarkAction == "randForce" then
	                        Vehicle.randomLaunch(entity)
	                    end
	                end
	            end
	        end
	        if not keepMarked then
	            unmarkAll()
	        end
	    end
	end	local function setupAimSettings(aimMenu, aimPedsSubmenu, aimVehicleSubmenu, aimObjectsSubmenu, aimTeleportAction)
	    if UND_privateMode then
	        UND_aimLockTime = 0
	    end
	    menu.divider(aimMenu, UND_translations.aim.aimLock)
	    local aimLockToggle = menu.toggle(aimMenu, UND_translations.aim.aimLockLastTarget, {Utils.getCommandName("aimlock")}, UND_translations.aim.aimLockLastTargetD,
	        function(on)
	            UND_aimLockEnabled = on
	        end, UND_aimLockEnabled)
	    UND_aimLockEnabled = menu.get_value(aimLockToggle)
	    local aimLockTimeSlider = menu.slider(aimMenu, UND_translations.aim.lockTime, {Utils.getCommandName("aimlocktime")}, UND_translations.aim.lockTimeD, 0, 30,
	        UND_aimLockTime, 1, function(val)
	            UND_aimLockTime = val
	        end)
	    UND_aimLockTime = menu.get_value(aimLockTimeSlider)
	    menu.action(aimMenu, UND_translations.aim.selectCurrentVehicle, {Utils.getCommandName("selectcurrentvehicle")}, UND_translations.aim.selectCurrentVehicleD, function()
	        local vehicle = Vehicle.getCurrentVehicle(true, true)
	        if vehicle == 0 then
	            Utils.showToast(UND_translations.vehicle.notInVehicle)
	            return
	        end
	        local player = Network.getPlayerFromPed(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
	        if player == -1 then
	            player = nil
	        end
	        UND_aimLockEndTime = Utils.getTime(UND_aimLockTime * 1000)
	        UND_aimLockEntity = {
	            entity = vehicle,
	            vehicle = vehicle,
	            isVehicle = true,
	            player = player
	        }
	    end)
	    local removeLockRel = menu.action(aimMenu, UND_translations.aim.removeAimLock, {Utils.getCommandName("removeaimlock")}, UND_translations.aim.removeAimLockD, function()
	        UND_aimLockEnabled = false
	        util.yield(1000)
	        UND_aimLockEnabled = true
	    end)
	    menu.divider(aimMenu, UND_translations.aim.markSettings)
	    menu.colour(aimMenu, UND_translations.aim.markColor, {Utils.getCommandName("markcolor")}, "", markColor, true, function(c)
	        markColor = Utils.convertColorToGame(c)
	    end)
	    markColor = Utils.convertColorToGame(markColor)
	    local pedMarkValues = {}
	    for idx, v in CONSTANTS.SCRIPT.MARK_ACTIONS.peds do
	        pedMarkValues[idx] = UND_translations.aim.markActions[v]
	    end
	    local pedMarkSelect = menu.list_select(aimMenu, UND_translations.aim.markedActionPed, {Utils.getCommandName("pedmarkaction")}, "", pedMarkValues, 1, function(idx)
	        pedMarkAction = CONSTANTS.SCRIPT.MARK_ACTIONS.peds[idx]
	    end)
	    pedMarkAction = CONSTANTS.SCRIPT.MARK_ACTIONS.peds[menu.get_value(pedMarkSelect)]
	    local vehMarkValues = {}
	    for idx, v in CONSTANTS.SCRIPT.MARK_ACTIONS.vehicles do
	        vehMarkValues[idx] = UND_translations.aim.markActions[v]
	    end
	    local vehMarkSelect = menu.list_select(aimMenu, UND_translations.aim.markedActionVeh, {Utils.getCommandName("vehmarkaction")}, "", vehMarkValues, 1, function(idx)
	        vehMarkAction = CONSTANTS.SCRIPT.MARK_ACTIONS.vehicles[idx]
	    end)
	    vehMarkAction = CONSTANTS.SCRIPT.MARK_ACTIONS.vehicles[menu.get_value(vehMarkSelect)]
	    local keepMarkedToggle = menu.toggle(aimMenu, UND_translations.aim.keepMark, {Utils.getCommandName("keepmarked")}, "", function(on)
	        keepMarked = on
	    end, keepMarked)
	    keepMarked = menu.get_value(keepMarkedToggle)
	    menu.action(aimMenu, UND_translations.aim.unmarkAll, {Utils.getCommandName("unmark")}, "", unmarkAll)
	    menu.action(aimMenu, UND_translations.aim.triggerMarkAction, {Utils.getCommandName("triggermark")}, "", triggerMarkAction)
	    menu.divider(aimMenu, UND_translations.general.settings)
	    local hotkeysPositionSubmenu = menu.list(aimMenu, UND_translations.aim.hotkeysPos, {}, "")
	    local xSlider = menu.slider(hotkeysPositionSubmenu, UND_translations.general.hPos, {Utils.getCommandName("hotkeyshpos")}, "", 0, 100, xValue, 1, function(val)
	        xValue = val / 100
	    end)
	    xValue = menu.get_value(xSlider) / 100
	    local ySlider = menu.slider(hotkeysPositionSubmenu, UND_translations.general.vPos, {Utils.getCommandName("hotkeysvpos")}, "", 0, 100, yValue, 1, function(val)
	        yValue = val / 100
	    end)
	    yValue = menu.get_value(ySlider) / 100
	    local scaleSlider = menu.slider(hotkeysPositionSubmenu, UND_translations.general.scale, {Utils.getCommandName("hotkeysscale")}, "", 1, 200, scaleValue, 1, function(val)
	        scaleValue = val / 100
	    end)
	    scaleValue = menu.get_value(scaleSlider) / 100
	    menu.colour(aimMenu, UND_translations.aim.hotkeysColor, {Utils.getCommandName("hotkeyscolor")}, "", hotkeysColor, true, function(c)
	        hotkeysColor = c
	        typeColor.r = hotkeysColor.r / 0.2
	        typeColor.g = hotkeysColor.g / 0.2
	        typeColor.b = hotkeysColor.b / 0.2
	        typeColor.a = hotkeysColor.a
	    end)
	    local hotkeysToggle = menu.toggle(aimMenu, UND_translations.aim.showHotkeys, {Utils.getCommandName("aimhotkeys")}, "", function(on)
	        hotkeysEnabled = on
	        setAimHotkeys()
	    end, true)
	    hotkeysEnabled = menu.get_value(hotkeysToggle)
	    local nameToggle = menu.toggle(aimMenu, UND_translations.aim.showName, {Utils.getCommandName("aimname")}, UND_translations.aim.showNameD, function(on)
	        nameEnabled = on
	    end, true)
	    nameEnabled = menu.get_value(nameToggle)
	    local hpToggle = menu.toggle(aimMenu, UND_translations.online.showHealth, {Utils.getCommandName("aimhealth")}, "", function(on)
	        showHealth = on
	    end, showHealth)
	    showHealth = menu.get_value(hpToggle)
	    menu.colour(aimMenu, UND_translations.aim.lineColor, {Utils.getCommandName("linecolor")}, "", lineColor, true, function(c)
	        lineColor = Utils.convertColorToGame(c)
	    end)
	    lineColor = Utils.convertColorToGame(lineColor)
	    local showLineToggle = menu.toggle(aimMenu, UND_translations.aim.showLine, {}, "", function(on)
	        lineEnabled = on
	    end, lineEnabled)
	    lineEnabled = menu.get_value(showLineToggle)
	    menu.colour(aimMenu, UND_translations.aim.hgColor, {Utils.getCommandName("highlightcolor")}, "", highlightColor, true, function(c)
	        highlightColor = Utils.convertColorToGame(c)
	    end)
	    highlightColor = Utils.convertColorToGame(highlightColor)
	    local highlightToggle = menu.toggle(aimMenu, UND_translations.aim.hgTarget, {}, "", function(on)
	        highlightEnabled = on
	    end, highlightEnabled)
	    highlightEnabled = menu.get_value(highlightToggle)
	    local tpBeaconToggle = menu.toggle(aimMenu, UND_translations.aim.showBeacon, {Utils.getCommandName("aimtpbeacon")}, "", function(on)
	        beaconEnabled = on
	    end, beaconEnabled)
	    beaconEnabled = menu.get_value(tpBeaconToggle)
	    local enableAimActionsToggle = menu.toggle(aimMenu, UND_translations.aim.enableAimActions, {Utils.getCommandName("enableaimactions")},
	        UND_translations.aim.enableAimActionsD, function(on)
	            UND_aimModeActive = on
	            if on and UND_aimLockEntity and not Player.isUserAiming() then
	                menu.trigger_command(removeLockRel)
	            end
	        end)
	    UND_aimModeActive = menu.get_value(enableAimActionsToggle)
	    local mainAimKeyToggle = menu.toggle(aimMenu, UND_translations.aim.enableAimHotkey, {Utils.getCommandName("enableaimhotkey")}, UND_translations.aim.enableAimHotkeyD,
	        function(on)
	            UND_aimModeActiveAsAimButton = on
	        end, UND_aimModeActiveAsAimButton)
	    UND_aimModeActiveAsAimButton = menu.get_value(mainAimKeyToggle)
	    setAimHotkeys()
	    menu.on_blur(aimPedsSubmenu, setAimHotkeys)
	    menu.on_blur(aimVehicleSubmenu, setAimHotkeys)
	    menu.on_blur(aimObjectsSubmenu, setAimHotkeys)
	    menu.on_blur(aimTeleportAction, setAimHotkeys)
	    util.create_tick_handler(onAim)
	    util.create_tick_handler(markTargets)
	end
	return setupAimSettings
end
package.loaded["src.lib.menus.aim.settings"] = nil
package.preload["src.lib.menus.player.trolling"] = function(...)
	
end
package.loaded["src.lib.menus.player.trolling"] = nil
package.preload["src.lib.menus.online.aimInfo"] = function(...)
	local enabled = true
	local xValue, yValue, scaleValue, yMultiplier = 85, 20, 100, 2
	local displayTime = 2
	local color = CONSTANTS.SCRIPT.COLORS.LIST.modder
	local aimingPlayers = {}
	local function renderAimInfo()
	    if #aimingPlayers == 0 then
	        return
	    end
	    for idx, player in aimingPlayers do
	        directx.draw_text(xValue, yValue + idx * yMultiplier * 0.02, player.text, 5, scaleValue, color, true)
	    end
	end
	local function showExamples()
	    for i = 1, 3 do
	        aimingPlayers[#aimingPlayers + 1] = {
	            pid = 123,
	            text = UND_translations.player.player .. i .. " - " .. UND_translations.general.weapon .. i
	        }
	        local showTime = Utils.getTime(displayTime * 1000)
	        util.create_thread(function()
	            while Utils.getTime() <= showTime do
	                util.yield(1000)
	            end
	            table.remove(aimingPlayers, 1)
	            util.stop_thread()
	        end)
	    end
	end
	local function runAimWatcher()
	    if not enabled then
	        return
	    end
	    local myPed = Player.getPlayerPed()
	    for _, pid in players.list(false) do
	        if not PLAYER.IS_PLAYER_FREE_AIMING(pid) and not PLAYER.IS_PLAYER_TARGETTING_ANYTHING(pid) then
	            goto continue
	        end
	        local isAiming = PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(pid, myPed) or PLAYER.IS_PLAYER_TARGETTING_ENTITY(pid, myPed)
	        if isAiming then
	            for _, player in aimingPlayers do
	                if player.pid == pid then
	                    goto continue
	                end
	            end
	            local textToShow = Player.getPlayerName(pid)
	            local weaponName = Ped.getWeapon(Player.getPlayerPed(pid))
	            if not weaponName then
	                weaponName = UND_translations.general.unknownWeapon
	            end
	            textToShow = textToShow .. " - " .. weaponName
	            aimingPlayers[#aimingPlayers + 1] = {
	                pid = pid,
	                text = textToShow
	            }
	            local showTime = Utils.getTime(displayTime * 1000)
	            util.create_thread(function()
	                while Utils.getTime() <= showTime do
	                    util.yield(1000)
	                end
	                table.remove(aimingPlayers, 1)
	                util.stop_thread()
	            end)
	        end
	        ::continue::
	    end
	    util.yield(700)
	end	local function setupAimInfoMenu(sessionMenu)
	    local aimInfoMenu = menu.list(sessionMenu, UND_translations.online.aimInfo, {}, UND_translations.online.aimInfoD)
	    local enabledToggle = menu.toggle(aimInfoMenu, UND_translations.online.showAimInfo, {Utils.getCommandName("playeraim")}, "", function(on)
	        enabled = on
	    end, enabled)
	    enabled = menu.get_value(enabledToggle)
	    local positionSubmenu = menu.list(aimInfoMenu, UND_translations.general.position, {}, UND_translations.general.positionD)
	    local xSlider = menu.slider(positionSubmenu, UND_translations.general.hPos, {Utils.getCommandName("playeraimhpos")}, "", 0, 100, xValue, 1, function(val)
	        xValue = val / 100
	        showExamples()
	    end)
	    xValue = menu.get_value(xSlider) / 100
	    local ySlider = menu.slider(positionSubmenu, UND_translations.general.vPos, {Utils.getCommandName("playeraimvpos")}, "", 0, 100, yValue, 1, function(val)
	        yValue = val / 100
	        showExamples()
	    end)
	    yValue = menu.get_value(ySlider) / 100
	    local scaleSlider = menu.slider(positionSubmenu, UND_translations.general.scale, {Utils.getCommandName("playeraimscale")}, "", 1, 200, scaleValue, 1, function(val)
	        scaleValue = val / 100
	        showExamples()
	    end)
	    scaleValue = menu.get_value(scaleSlider) / 100
	    local spaceYSlider = menu.slider(positionSubmenu, UND_translations.general.vSpace, {Utils.getCommandName("playeraimvspace")}, "", 1, 30, yMultiplier, 1, function(val)
	        yMultiplier = val
	        showExamples()
	    end)
	    yMultiplier = menu.get_value(spaceYSlider)
	    menu.colour(aimInfoMenu, UND_translations.general.color, {Utils.getCommandName("playeraimcolor")}, "", color, true, function(c)
	        color = c
	    end)
	    local displayTimeSlider = menu.slider(aimInfoMenu, UND_translations.online.displayTime, {Utils.getCommandName("playeraimtime")}, UND_translations.online.displayTimeD, 1,
	        5, displayTime, 1, function(val)
	            displayTime = val
	        end)
	    displayTime = menu.get_value(displayTimeSlider)
	    menu.action(aimInfoMenu, UND_translations.online.aimInfoExample, {}, UND_translations.online.aimInfoExampleD, showExamples)
	    util.create_tick_handler(runAimWatcher)
	    util.create_tick_handler(renderAimInfo)
	end
	return setupAimInfoMenu
end
package.loaded["src.lib.menus.online.aimInfo"] = nil
package.preload["src.lib.menus.online.playerKicker"] = function(...)
	
end
package.loaded["src.lib.menus.online.playerKicker"] = nil
package.preload["src.lib.constants"] = function(...)
	return {
	    SCRIPT = {
	        COMMAND_PREFIX = "gt",
	        VERSION = "gt",
	        PLAYER_SORT_OPTIONS = {"Distance", "Rank", "Money", "KD", "Name", "Host position", "Language"},
	        COLORS = {
	            LIST = {
	                main = {
	                    r = 1,
	                    g = 1,
	                    b = 1,
	                    a = 1
	                },
	                dead = {
	                    r = 0,
	                    g = 0,
	                    b = 0,
	                    a = 1
	                },
	                interior = {
	                    r = 1,
	                    g = 1,
	                    b = 1,
	                    a = 0.5
	                },
	                modder = {
	                    r = 1,
	                    g = 0,
	                    b = 0,
	                    a = 1
	                },
	                otr = {
	                    r = 1,
	                    g = 1,
	                    b = 0,
	                    a = 1
	                },
	                admin = {
	                    r = 1,
	                    g = 0,
	                    b = 0,
	                    a = 1
	                },
	                modderAdmin = {
	                    r = 1,
	                    g = 0,
	                    b = 0,
	                    a = 1
	                },
	                god = {
	                    r = 1,
	                    g = 0,
	                    b = 0.91,
	                    a = 1
	                },
	                self = {
	                    r = 0,
	                    g = 1,
	                    b = 1,
	                    a = 1
	                },
	                attacker = {
	                    r = 0.78,
	                    g = 0.31,
	                    b = 0,
	                    a = 1
	                },
	                host = {
	                    r = 0,
	                    g = 0.66,
	                    b = 1,
	                    a = 1
	                },
	                scriptHost = {
	                    r = 1,
	                    g = 1,
	                    b = 1,
	                    a = 1
	                },
	                friend = {
	                    r = 0,
	                    g = 1,
	                    b = 0,
	                    a = 1
	                },
	                bg = {
	                    r = 0,
	                    g = 0,
	                    b = 0,
	                    a = 0.5
	                }
	            },
	            AIM = {
	                hotkeys = {
	                    r = 0,
	                    g = 1,
	                    b = 0,
	                    a = 1
	                },
	                line = {
	                    r = 0,
	                    g = 1,
	                    b = 0,
	                    a = 0.6
	                },
	                highlight = {
	                    r = 0,
	                    g = 1,
	                    b = 0,
	                    a = 1
	                },
	                mark = {
	                    r = 1,
	                    g = 0,
	                    b = 0,
	                    a = 1
	                }
	            },
	            ESP = {
	                r = 0,
	                g = 1,
	                b = 0,
	                a = 1
	            }
	        },
	        MARK_ACTIONS = {
	            peds = {"shoot", "explode", "burn", "atomize", "fireworks"},
	            vehicles = {"explode", "burn", "damage", "emp", "atomize", "fireworks", "randForce"}
	        }
	    },
	    GAME = {
	        BULLET_TYPES = {{
	            "Up-n-Atomizer",
	            hash = "WEAPON_RAYPISTOL"
	        }, {
	            "Firework",
	            hash = "WEAPON_FIREWORK"
	        }, {
	            "RPG",
	            hash = "WEAPON_RPG"
	        }, {
	            "Grenade",
	            hash = "WEAPON_GRENADELAUNCHER"
	        }, {
	            "Smoke",
	            hash = "WEAPON_GRENADELAUNCHER_SMOKE"
	        }, {
	            "Unholy Hellbringer",
	            hash = "WEAPON_RAYCARBINE"
	        }, {
	            "Molotov",
	            hash = "WEAPON_MOLOTOV"
	        }, {
	            "Tennis Ball",
	            hash = "WEAPON_BALL"
	        }, {
	            "Snowball",
	            hash = "WEAPON_SNOWBALL"
	        }, {
	            "Flare",
	            hash = "WEAPON_FLAREGUN"
	        }},
	        LANGUAGES = {
	            [0] = "EN",
	            [1] = "FR",
	            [2] = "DE",
	            [3] = "IT",
	            [4] = "ES",
	            [5] = "BR",
	            [6] = "PL",
	            [7] = "RU",
	            [8] = "KR",
	            [9] = "CN",
	            [10] = "JP",
	            [11] = "MX",
	            [12] = "CN"
	        },
	        INTERIOR_IDS = {
	            pentGarage = 275457,
	            casino = 275201,
	            casinoGarage = 274945,
	            beeker = 179457,
	            lsCarMeet = 285697,
	            lsCarMeet2 = 286209,
	            benny = 196609,
	            barber = 165377,
	            barber2 = 198657,
	            barber3 = 171009,
	            barber4 = 199937,
	            barber5 = 140545,
	            barber6 = 180225,
	            barber7 = 155905,
	            vehWarehouse = 290817,
	            ammuNation = 248065,
	            ammuNation2 = 153857,
	            ammuNation3 = 168193,
	            ammuNation4 = 200961,
	            ammuNation5 = 164609,
	            ammuNation6 = 137729,
	            ammuNation7 = 140289,
	            ammuNation8 = 180481,
	            ammuNation9 = 178689,
	            ammuNation10 = 176385,
	            ammuNation11 = 175617,
	            lsc = 234753,
	            lsc2 = 164353,
	            lsc3 = 201729,
	            lsc4 = 153601,
	            twoCarGarage = 149249,
	            sixCarGarage = 148737,
	            tenCarGarage = 146433,
	            fiftyCarGarage = 290561,
	            eclipseTowers = 230657,
	            lombank = 255745,
	            lombank2 = 255489,
	            lombank3 = 256001,
	            lombank4 = 241921,
	            lombank5 = 256257,
	            arcadius = 253441,
	            arcadius2 = 237313,
	            arcadius3 = 253697,
	            arcadius4 = 253953,
	            arcadius5 = 254209,
	            mazeTower = 239617,
	            mazeTower2 = 254465,
	            mazeTower3 = 254721,
	            mazeTower4 = 254977,
	            mazeTower5 = 255233,
	            mazeBuilding = 244225,
	            mazeBuilding2 = 256513,
	            mazeBuilding3 = 256769,
	            mazeBuilding4 = 257025,
	            mazeBuilding5 = 257281,
	            apart = 206081,
	            apart2 = 206337,
	            apart3 = 206593,
	            apart4 = 149761,
	            apart5 = 148225,
	            delPerro = 145409,
	            delPerro2 = 145921,
	            delPerro3 = 145665,
	            fourWay = 147201,
	            fourWay2 = 141313,
	            fourWay3 = 147969,
	            docForgery = 246785,
	            methLab = 247041,
	            weedFarm = 247297,
	            counterfeitCash = 247809,
	            cocaineLockup = 247553,
	            yacht = 213249,
	            yacht2 = 212737,
	            yacht3 = 212225,
	            hangar = 260353,
	            strip = 197121,
	            tattoo = 199425,
	            tattoo2 = 140033,
	            tattoo3 = 180737,
	            tattoo4 = 180737,
	            tattoo5 = 251137,
	            tattoo6 = 176897,
	            alta = 141825,
	            alta2 = 141569,	            richards = 142849,
	            richards2 = 143361,
	            richards3 = 146177,
	            weazel = 143617,
	            weazel2 = 143105,
	            weazel3 = 142593,
	            clothes = 165633,
	            clothes2 = 235265,
	            clothes3 = 166145,
	            clothes4 = 140801,
	            clothes5 = 176129,
	            clothes6 = 169217,
	            clothes7 = 201473,
	            clothes8 = 171265,
	            clothes9 = 137217,
	            clothes10 = 198145,
	            clothes11 = 183553,
	            clothes12 = 175361,
	            clothes13 = 179713,
	            clothes14 = 202497
	        },
	        INTERIOR_COORDS = {	            kosatkaMissile = {1558.553, 1558.653, 387.213, 388.713, -200, 0},
	            kosatka = {1553, 1568, 361, 452, -200, 0},
	            pentGarage = {1248, 1315, 2218, 264, -200, 0},
	            musicLocker = {1537, 1583, 233, 263, -200, 0},
	            casino = {1082, 1168, 191, 286, -200, 0},
	            casinoGarage = {1333, 1413, 178, 259, -200, 0},
	            eclipseTowers = {-824, -738, 295, 363, 107, 230},
	            autoShop = {-1369, -1318.5, 134.5, 170.5, -200, 0},
	            subMission = {511, 517, 4816, 4906, -200, 0},
	            facility = {310, 511, 4755, 4885, -200, 0},
	            avenger = {504, 535, 4744, 4756, -200, 0},
	            beeker = {98, 115, 6613, 6631, 0, 35},
	            penthouse = {932, 994, -3, 84, 0, 120},
	            arcade = {2673, 2744, -403, -348, -200, 0},
	            docForgery = {1155, 1175, -3201, -3188, -200, 0},
	            mcClub = {1093, 1128, -3180, -3137, -200, 0},
	            counterfeitCash = {1113, 1141, -3200, -3191, -200, 0},
	            vehWarehouse = {926.5, 1014.5, -3039.5, -2985, -200, 0},
	            vehWarehouse2 = {553, 576.51, -456.60, -402.20, -200, 0},
	            methLab = {995, 1019, -3204, -3191, -200, 0},
	            cocaineLockup = {1084, 1104, -3201, -3185, -200, 0},
	            weedFarm = {1029, 1068, -3210, -3178, -200, 0},
	            moc = {1097, 1109, -3014, -2990, -200, 0},
	            twoCarGarage = {168, 180, -1009, -999, -200, -90},
	            sixCarGarage = {189, 208, -1008, -993, -200, -90},
	            tenCarGarage = {216, 242, -1010, -961, -200, 0},
	            fiftyCarGarage = {510, 533, -2640, -2599, -200, 0},
	            bunker = {822, 955, -3253, -3061, -200, 0},
	            fib = {74, 193, -797, -699, 40, 262},
	            agency = {345, 407, -98, -32, 70, 122},
	            agency2 = {-1047, -987, -795, -708, 26, 76},
	            agency3 = {-1042, -992, -447, -404, 42, 77},
	            agency4 = {-610, -568, -727, -704, 37, 129},
	            agencyGarage = {-1084, -1058, -93, -60, -200, 40},
	            lsc = {1172, 1189, 2635, 2644, 0, 43},
	            lsc2 = {723, 738, -1094, -1064, 0, 30},
	            lsc3 = {-355, -319, -147, -121, 0, 44},
	            lsc4 = {-1170, -1139, -2026, -2007, 0, 18},
	            mazeTower = {-118, -29, -868, -773, 0, 320},
	            hangar = {-1308, -1225, -3073, -2956, -200, 0},
	            nightclub = {-1648, -1564, -3022, -2983, -200, 0},
	            nightclubBasement = {-1526, -1480, -3048, -2960, -200, 0},
	            mazeBuilding = {-1421, -1328, -511, -440, 0, 84},
	            terrorbyte = {-1426, -1416, -3019, -3006, -200, 0},
	            benny = {-228.2, -195.2, -1334.2, -1314.1, 0, 39},
	            lombank = {-1595, -1549, -592, -550, 0, 114},
	            arcadius = {-200, -118, -650, -560, 34, 176},
	            apart = {323, 347, 420, 445, 0, 152},
	            apart2 = {323, 381, 400, 445, 0, 150},
	            apart3 = {112, 127, 540, 572, 0, 188},
	            apart4 = {254, 267, -1005, -994, -200, 0},
	            apart5 = {337, 353, -1004, -992, -200, 0},
	            ammuNation = {807, 828, -2165, -2148, 0, 35},
	            ammuNation2 = {838, 847, -1036, -1024, 0, 33},
	            ammuNation3 = {-667, -658, -945, -931, 0, 25},
	            ammuNation4 = {1688, 1702, 3751.5, 3764, 0, 39},
	            ammuNation5 = {-1315, -1302, -398, -387, 0, 38},
	            ammuNation6 = {3, 25, -1116, -1095, 0, 38},
	            ammuNation7 = {243, 256, -54, -43, 0, 74},
	            ammuNation8 = {-336, -322, 6075, 6088, 0, 34},
	            ammuNation9 = {2565, 2573, 290, 304, 0, 114},
	            ammuNation10 = {-3176, -3163, 1081, 1091, 0, 25},
	            ammuNation11 = {-1123, -1110, 2690, 2702, 0, 22},
	            delPerro = {-1483, -1434, -573, -509, 40, 84},
	            fourWay = {-52, -2, -607, -569, 40, 106},
	            lsCarMeet = {-2224, -2140, 1071, 1161, -200, 0},
	            lsCarMeet2 = {-2224, -1835, 970, 1250, 24, 30},
	            strip = {92, 138, -1307, -1277, 28, 32},
	            barber = {-825.1, -807, -191.3, -179, 37, 40},
	            barber2 = {132.5, 142, -1714.1, -1703, 29, 35},
	            barber3 = {-1289, -1277, -1120, -1115, 6, 10},
	            barber4 = {1928, 1937, 3725, 3736, 32, 36},
	            barber5 = {-37, -29, -157, -146, 57, 66},
	            barber6 = {-284.2, -274, 6223, 6233, 31, 37},
	            barber7 = {1206, 1217, -477, -469, 66, 78},
	            tattoo = {1860, 1867, 3744, 3752, 32, 36},
	            tattoo2 = {319, 327, 178, 187, 103, 127},
	            tattoo3 = {-297, -289, 6196, 6203, 31, 34},
	            tattoo4 = {-1158, -1148, -1430, -1422, 4, 11},
	            tattoo5 = {1319, 1329, -1657, -1649, 52, 57},
	            tattoo6 = {-3176, -3167, 1072, 1080, 20, 25},
	            alta = {-291, -252, -971, -937, 70, 100},
	            tinsel = {-630, -571, 36, 72, 50, 115},
	            richards = {-937, -893, -392, -359, 75, 116},
	            weazel = {-923, -875, -469, -420, 85, 128},
	            clothes = {-721, -699, -165, -145, 37, 40},
	            clothes2 = {-172, -154, -315, -293, 39, 43},
	            clothes3 = {-1462, -1443, -247, -225, 49, 52},
	            clothes4 = {116, 133, -235, -206, 54, 57},
	            clothes5 = {-3181, -3161, 1033, 1061, 20, 23},
	            clothes6 = {-1207, -1180, -784, -763, 17, 20},
	            clothes7 = {612, 624, 2747, 2776, 41, 45},
	            clothes8 = {-832, -814, -1084, -1066, 11, 15},
	            clothes9 = {418, 432, -813, -798, 29, 35},
	            clothes10 = {69, 83, -1401, -1386, 29, 34},
	            clothes11 = {1686, 1700, 4716, 4831, 41, 45},
	            clothes12 = {-1111, -1093, 2700, 2718, 18, 22},
	            clothes13 = {-4, 14, 6505, 6523, 31, 36},
	            clothes14 = {1188, 1203, 2703, 2716, 38, 41},
	            masks = {-1340.5, -1334, -1284, -1274, 4, 5},
	            cayoPerico = {3500, 5950, -6300, -3990},
	            ussLex = {2990, 3130, -4830, -4510},
	            arena = {147, 233, 5155, 5218}
	        }
	    },
	    RAYCAST = {
	        TraceFlag = {
	            all = 4294967295,
	            vehicles = 2,
	            peds = 8,
	            objects = 16
	        }
	    }
	};
end
package.loaded["src.lib.constants"] = nil
package.preload["src.lib.menus.player.friendly"] = function(...)
	
end
package.loaded["src.lib.menus.player.friendly"] = nil
package.preload["src.lib.menus.aim"] = function(...)
	local setupAimTeleport = require "src.lib.menus.aim.teleport"
	local setupAimBeam = require "src.lib.menus.aim.beam"
	local setupAimSettings = require "src.lib.menus.aim.settings"
	local setupPedAimActions = require "src.lib.menus.aim.ped"
	local setupVehicleAimActions = require "src.lib.menus.aim.vehicle"
	local setupObjectAimActions = require "src.lib.menus.aim.object"
	local function setupAimMenu()
	    local aimMenu = menu.list(weapon_options, UND_translations.aim.name, {}, UND_translations.aim.nameD)
	    menu.divider(aimMenu, UND_translations.aim.name)
	    local aimPedsSubmenu = menu.list(aimMenu, UND_translations.aim.peds, {}, "")
	    local aimVehicleSubmenu = menu.list(aimMenu, UND_translations.vehicle.name, {}, "")
	    local aimObjectsSubmenu = menu.list(aimMenu, UND_translations.aim.objects, {}, "")
	    local aimTeleportAction = setupAimTeleport(aimMenu)
	    setupAimBeam(aimMenu)
	    setupPedAimActions(aimPedsSubmenu)
	    setupVehicleAimActions(aimVehicleSubmenu)
	    setupObjectAimActions(aimObjectsSubmenu)
	    setupAimSettings(aimMenu, aimPedsSubmenu, aimVehicleSubmenu, aimObjectsSubmenu, aimTeleportAction)
	end
	return setupAimMenu
end
package.loaded["src.lib.menus.aim"] = nil
package.preload["src.lib.menus.aim.ped"] = function(...)
	local _Raycast = CONSTANTS.RAYCAST
	local function delete()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    elseif aimResult.player then
	        Utils.showToast(UND_translations.general.onlyPlayers)
	        return
	    end
	    Utils.deleteEntity(aimResult.entity)
	end
	local function burn()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if aimResult then
	        Ped.burn(aimResult.entity)
	    end
	end
	local function ram()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if aimResult then
	        Entity.ram(aimResult.entity)
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
	local function randomExplode()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if aimResult then
	        Ped.explode(aimResult.entity, true)
	    end
	end
	local function waterJet()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if aimResult then
	        Ped.waterJet(aimResult.entity)
	    end
	end
	local function flameJet()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if aimResult then
	        Ped.flameJet(aimResult.entity)
	    end
	end
	local function removeWanted()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    elseif not aimResult.player then
	        Utils.showToast(UND_translations.general.onlyPlayers)
	        return
	    end
	    Player.makeWanted(aimResult.player, 0)
	end
	local function clone()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if aimResult then
	        Ped.clone(aimResult.entity)
	    end
	end	local function freeze(enabled)
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
	    end
	    Ped.cage(aimResult.entity, UND_settings.cageType)
	end
	local function airstrike()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    end
	    Ped.airstrike(aimResult.entity)
	end
	local function heal()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    elseif aimResult.player then
	        Player.heal(aimResult.player)
	        return
	    elseif not ENTITY.IS_ENTITY_DEAD(aimResult.entity) then
	        Utils.showToast(UND_translations.aim.reviveOnlyDead)
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
	local function makeWanted()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    elseif not aimResult.player then
	        Utils.showToast(UND_translations.general.onlyPlayers)
	        return
	    end
	    Player.makeWanted(aimResult.player)
	end
	local function placeBounty()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    elseif not aimResult.player then
	        Utils.showToast(UND_translations.general.onlyPlayers)
	        return
	    end
	    Player.placeBounty(aimResult.player)
	end
	local function shoot()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    end
	    Ped.shoot(aimResult.entity)
	end
	local function atomize()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    end
	    Ped.atomize(aimResult.entity)
	end
	local function firework()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    end
	    Ped.fireworks(aimResult.entity)
	end
	local function kick()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    elseif not aimResult.player then
	        Utils.showToast(UND_translations.general.onlyPlayers)
	        return
	    end
	    Player.kick(aimResult.player)
	end
	local function toggleInvisible()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    elseif aimResult.player then
	        Utils.showToast(UND_translations.general.onlyPeds)
	        return
	    end
	    Ped.toggleInvisible(aimResult.entity)
	end
	local function openStand()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    elseif not aimResult.player then
	        Utils.showToast(UND_translations.general.onlyPlayers)
	        return
	    end
	    menu.trigger_commands("p" .. Player.getPlayerName(aimResult.player, true))
	end
	local function crash()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    elseif not aimResult.player then
	        Utils.showToast(UND_translations.general.onlyPlayers)
	        return
	    end
	    Player.crash(aimResult.player)
	end
	local function copyOutfit()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    elseif not aimResult.player then
	        Utils.showToast(UND_translations.general.onlyPlayers)
	        return
	    end
	    menu.trigger_commands("copyoutfit" .. Player.getPlayerName(aimResult.player, true))
	end	local function toggleGod(enabled)
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    elseif aimResult.player then
	        local val = "off"
	        if not enabled then
	            val = "on"
	        end
	        menu.trigger_commands("confuse" .. Player.getPlayerName(aimResult.player, true) .. " " .. val)
	    else
	        Ped.toggleGod(aimResult.entity, enabled)
	    end
	end
	local function tpToPed()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    end
	    local entityToTeleport = Vehicle.getPlayerOrVehicleEntity()
	    if not entityToTeleport then
	        return
	    end
	    local coords = Utils.rotateToEntity(aimResult.entity)
	    ENTITY.SET_ENTITY_COORDS(entityToTeleport, coords.x, coords.y, coords.z, false, false, false, false)
	end
	local function tpToMe()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    elseif aimResult.player then
	        Utils.showToast(UND_translations.general.onlyPeds)
	        return
	    end
	    local coords = Player.getPlayerPosition()
	    ENTITY.SET_ENTITY_COORDS(aimResult.entity, coords.x, coords.y, coords.z, false, false, false, false)
	end
	local function toggleMark()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    end
	    local idx = Utils.getTableIdx(UND_markedTargets, aimResult.entity)
	    if idx then
	        table.remove(UND_markedTargets, idx)
	    else
	        table.insert(UND_markedTargets, aimResult.entity)
	    end
	end
	local function selectVehicle()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.peds)
	    if not aimResult then
	        return
	    end
	    util.yield()
	    local vehicle = Ped.getVehicle(aimResult.entity)
	    if not vehicle then
	        Utils.showToast(UND_translations.aim.noVehicle)
	        return
	    end
	    local player = Network.getPlayerFromPed(aimResult.entity)
	    if player == -1 then
	        player = nil
	    end
	    UND_aimLockEndTime = Utils.getTime(UND_aimLockTime * 1000)
	    UND_aimLockEntity = {
	        entity = vehicle,
	        vehicle = vehicle,
	        isVehicle = true,
	        player = player
	    }
	end	local function setupPedAimActions(aimPedsSubmenu)
	    menu.action(aimPedsSubmenu, UND_translations.general.delete, {}, "", delete)
	    menu.action(aimPedsSubmenu, UND_translations.general.burn, {}, "", burn)
	    menu.action(aimPedsSubmenu, UND_translations.general.ram, {}, "", ram)
	    menu.action(aimPedsSubmenu, UND_translations.general.ragdoll, {}, "", ragdoll)
	    menu.action(aimPedsSubmenu, UND_translations.general.explode, {}, "", explode)
	    menu.action(aimPedsSubmenu, UND_translations.general.randomExplosion, {}, "", randomExplode)
	    menu.action(aimPedsSubmenu, UND_translations.general.airstrike, {}, "", airstrike)
	    menu.action(aimPedsSubmenu, UND_translations.player.waterJet, {}, "", waterJet)
	    menu.action(aimPedsSubmenu, UND_translations.player.flameJet, {}, "", flameJet)
	    menu.action(aimPedsSubmenu, UND_translations.general.clone, {}, "", clone)
	    menu.action(aimPedsSubmenu, UND_translations.general.cage, {}, "", cage)
	    menu.action(aimPedsSubmenu, UND_translations.aim.disarm, {}, "", disarm)
	    menu.action(aimPedsSubmenu, UND_translations.general.freeze, {}, "", function()
	        freeze(true)
	    end)
	    menu.action(aimPedsSubmenu, UND_translations.general.unfreeze, {}, "", function()
	        freeze(false)
	    end)
	    menu.action(aimPedsSubmenu, UND_translations.general.kick, {}, "", kick)
	    menu.action(aimPedsSubmenu, UND_translations.general.openInStand, {}, "", openStand)
	    menu.action(aimPedsSubmenu, UND_translations.aim.heal, {}, UND_translations.aim.healD, heal)
	    menu.action(aimPedsSubmenu, UND_translations.general.tpToMe, {}, "", tpToMe)
	    menu.action(aimPedsSubmenu, UND_translations.general.tpToIt, {}, "", tpToPed)
	    menu.action(aimPedsSubmenu, UND_translations.general.shoot, {}, "", shoot)
	    menu.action(aimPedsSubmenu, UND_translations.general.crash, {}, "", crash)
	    menu.action(aimPedsSubmenu, UND_translations.general.setGod, {}, UND_translations.general.setGodD, function()
	        toggleGod(true)
	    end)
	    menu.action(aimPedsSubmenu, UND_translations.general.removeGod, {}, UND_translations.general.removeGodD, function()
	        toggleGod(false)
	    end)
	    menu.action(aimPedsSubmenu, UND_translations.general.toggleInv, {}, "", toggleInvisible)
	    menu.action(aimPedsSubmenu, UND_translations.general.toggleMark, {}, UND_translations.general.toggleMarkD, toggleMark)
	    menu.action(aimPedsSubmenu, UND_translations.general.atomize, {}, "", atomize)
	    menu.action(aimPedsSubmenu, UND_translations.general.fireworks, {}, "", firework)
	    menu.action(aimPedsSubmenu, UND_translations.general.copyOutfit, {}, "", copyOutfit)
	    menu.action(aimPedsSubmenu, UND_translations.player.makeWanted, {}, "", makeWanted)
	    menu.action(aimPedsSubmenu, UND_translations.general.removeWanted, {}, "", removeWanted)
	    menu.action(aimPedsSubmenu, UND_translations.player.placeBounty, {}, "", placeBounty)
	    menu.action(aimPedsSubmenu, UND_translations.aim.selectVehicle, {}, UND_translations.aim.selectVehicleD, selectVehicle)
	end
	return setupPedAimActions
end
package.loaded["src.lib.menus.aim.ped"] = nil
package.preload["src.lib.vehicle"] = function(...)
	local allVehicles = util.get_vehicles()
	local Vehicle = {}
	function Vehicle.setVehiclePlate(vehicle, text)
	    if text and text:len() > 0 then
	        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, text)
	    end
	end	function Vehicle.repairVehicle(vehicle)
	    if not Network.requestControl(vehicle) then
	        return
	    end
	    VEHICLE.SET_VEHICLE_FIXED(vehicle)
	    VEHICLE.SET_VEHICLE_DEFORMATION_FIXED(vehicle)
	    VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, 1000)
	end
	function Vehicle.toggleVehicleGodMode(vehicle, on)
	    if not Network.requestControl(vehicle) then
	        return
	    end
	    if on then
	        VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, 0.0)
	        VEHICLE.SET_VEHICLE_BODY_HEALTH(vehicle, 1000.0)
	        VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, 1000.0)
	        VEHICLE.SET_VEHICLE_FIXED(vehicle)
	        VEHICLE.SET_VEHICLE_DEFORMATION_FIXED(vehicle)
	        VEHICLE.SET_VEHICLE_PETROL_TANK_HEALTH(vehicle, 1000.0)
	        VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, 0.0)
	        for i = 0, 10 do
	            VEHICLE.SET_VEHICLE_TYRE_FIXED(vehicle, i)
	        end
	    end
	    ENTITY.SET_ENTITY_CAN_BE_DAMAGED(vehicle, on)
	    ENTITY.SET_ENTITY_INVINCIBLE(vehicle, on)
	    ENTITY.SET_ENTITY_PROOFS(vehicle, on, on, on, on, on, on, true, on)
	    VEHICLE.SET_DISABLE_VEHICLE_PETROL_TANK_DAMAGE(vehicle, on)
	    VEHICLE.SET_DISABLE_VEHICLE_PETROL_TANK_FIRES(vehicle, on)
	    VEHICLE.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(vehicle, not on)
	    VEHICLE.SET_VEHICLE_CAN_BREAK(vehicle, not on)
	    VEHICLE.SET_VEHICLE_ENGINE_CAN_DEGRADE(vehicle, not on)
	    VEHICLE.SET_VEHICLE_EXPLODES_ON_HIGH_EXPLOSION_DAMAGE(vehicle, not on)
	    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, not on)
	    VEHICLE.SET_VEHICLE_WHEELS_CAN_BREAK(vehicle, not on)
	end	function Vehicle.cleanVehicle(vehicle)
	    GRAPHICS.REMOVE_DECALS_FROM_VEHICLE(vehicle)
	    VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, 0.0)
	end	local function getRandomColor()
	    local color = {
	        a = 255
	    }
	    color.r = Utils.rand(0, 255)
	    color.g = Utils.rand(0, 255)
	    color.b = Utils.rand(0, 255)
	    return color
	end	function Vehicle.randomUpgradeForVehicle(vehicle)
	    if not Network.requestControl(vehicle) then
	        return
	    end
	    local performanceMods = {11, 12, 13, 15, 16}
	    local bodyPartsMods = {0, 1, 2, 3, 4, 5, 7, 8, 9, 25, 27}
	    VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
	    for x = 0, 49 do
	        if table.contains(bodyPartsMods, x) and util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(vehicle)) == "entity3" then
	            goto continue
	        end
	        if (x == 14 and not UND_settings.randomUpgrades.horn) or (x == 48 and not UND_settings.randomUpgrades.livery) or
	            ((x == 23 or x == 24) and not UND_settings.randomUpgrades.wheels) or
	            (table.contains(performanceMods, x) and (not UND_settings.randomUpgrades.performance or UND_settings.randomUpgrades.maxPerformance)) or
	            (table.contains(bodyPartsMods, x) and not UND_settings.randomUpgrades.bodyParts) or (x == 10 and not UND_settings.randomUpgrades.weaponRoof) or
	            (x == 6 and not UND_settings.randomUpgrades.grilleCounter) then
	            if table.contains(performanceMods, x) and UND_settings.randomUpgrades.maxPerformance then
	                local max = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, x) - 1
	                VEHICLE.SET_VEHICLE_MOD(vehicle, x, max)
	            end
	            goto continue
	        end
	        local max = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, x) - 1
	        local modVal = Utils.rand(-1, max)
	        if x == 34 and modVal == 3 then
	            modVal = 2
	        end
	        VEHICLE.SET_VEHICLE_MOD(vehicle, x, modVal)
	        ::continue::
	    end
	    if UND_settings.randomUpgrades.windowTint then
	        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, Utils.rand(0, 5))
	    end
	    local primColor, secColor, primFinishType, secFinishType = getRandomColor(), getRandomColor(), Utils.rand(0, 6), Utils.rand(0, 6)
	    if UND_settings.randomUpgrades.paint then
	        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, primColor.r, primColor.g, primColor.b)
	        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, secColor.r, secColor.g, secColor.b)
	        if UND_settings.randomUpgrades.finishType then
	            VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, primFinishType, primColor, 0)
	            VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, secFinishType, secColor)
	        end
	    end
	    if UND_settings.randomUpgrades.tyreSmoke then
	        local smokeColor = getRandomColor()
	        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, smokeColor.r, smokeColor.g, smokeColor.b)
	    end
	    if UND_settings.randomUpgrades.plateType then
	        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, Utils.rand(0, 5))
	    end
	    if UND_settings.randomUpgrades.lights then
	        VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vehicle, Utils.rand(0, 12))
	    end
	    if UND_settings.randomUpgrades.neons then
	        VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, Utils.rand(0, 255), Utils.rand(0, 255), Utils.rand(0, 255))
	        local enabled = Utils.rand() == 1
	        for i = 0, 3 do
	            VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, i, enabled)
	        end
	    end
	    for x = 17, 22 do
	        if x == 18 and (UND_settings.randomUpgrades.maxPerformance or UND_settings.randomUpgrades.performance) then
	            local value = true
	            if not UND_settings.randomUpgrades.maxPerformance then
	                value = Utils.rand() == 1
	            end
	            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, x, value)
	        else
	            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, x, true)
	        end
	    end
	    Vehicle.cleanVehicle(vehicle)
	end	function Vehicle.getCurrentVehicle(dontShowError, noRequest)
	    local playerVehicle = Ped.getVehicle(Player.getPlayerPed())
	    if not playerVehicle then
	        if not dontShowError then
	            Utils.showToast(UND_translations.vehicle.notInVehicle)
	        end
	        return 0
	    end
	    if noRequest or Network.requestControl(playerVehicle, nil, dontShowError) then
	        return playerVehicle
	    end
	    return 0, true
	end	function Vehicle.getPlayerVehicle(player, dontShowError)
	    local function notInVehicle()
	        if not dontShowError then
	            Utils.showToast(Player.getPlayerName(player) .. " " .. UND_translations.vehicle.playerNotInVehicle)
	        end
	    end
	    local playerPed = Player.getPlayerPed(player)
	    if not PED.IS_PED_IN_ANY_VEHICLE(playerPed, false) then
	        notInVehicle()
	        return 0
	    end
	    local playerVehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed, false)
	    if playerVehicle == 0 then
	        notInVehicle()
	        return 0
	    end
	    local vehicleDriver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(playerVehicle, -1, false)
	    if vehicleDriver == Player.getUserPlayer() or Network.requestControl(playerVehicle, nil, dontShowError) then
	        return playerVehicle
	    end
	    return 0
	end
	function Vehicle.getPlayerOrVehicleEntity(noRequest)
	    local vehicle, noAccess = Vehicle.getCurrentVehicle(true, noRequest)
	    if vehicle ~= 0 then
	        return vehicle
	    end
	    if noAccess and not noRequest then
	        Utils.showToast(UND_translations.vehicle.noAccess)
	        return nil
	    end
	    return Player.getPlayerPed()
	end
	function Vehicle.getTargetVehicleData(entity)
	    local vehicle = ENTITY.GET_VEHICLE_INDEX_FROM_ENTITY_INDEX(entity)
	    local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, true)
	    local player = Network.getPlayerFromPed(driver)
	    local result = {}
	    result.vehicle = vehicle
	    result.driver = driver
	    result.player = player
	    return result
	end	function Vehicle.getClosestVehicleTo(entity, includePlayerVehicles)
	    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
	    local maxDistance = 10000
	    local closestVehicle
	    local curVehicle = Ped.getVehicle(Player.getPlayerPed())
	    for _, vehicle in entities.get_all_vehicles_as_handles() do
	        local modelHash = ENTITY.GET_ENTITY_MODEL(vehicle)
	        if vehicle ~= curVehicle and not ENTITY.IS_ENTITY_DEAD(vehicle) and ENTITY.IS_ENTITY_VISIBLE(vehicle) and VEHICLE.IS_VEHICLE_DRIVEABLE(vehicle, true) and
	            not VEHICLE.IS_THIS_MODEL_A_TRAIN(modelHash) and not util.is_this_model_a_trailer(modelHash) and ENTITY.GET_ENTITY_ALPHA(vehicle) == 255 and
	            Network.requestControlOnce(vehicle) then
	            local vehicleData = Vehicle.getTargetVehicleData(vehicle)
	            if includePlayerVehicles or vehicleData.player == -1 then
	                local vehicleCoords = ENTITY.GET_ENTITY_COORDS(vehicle, true)
	                local distance = v3.distance(coords, vehicleCoords)
	                if distance < maxDistance then
	                    maxDistance = distance
	                    closestVehicle = vehicle
	                end
	            end
	        end
	    end
	    return closestVehicle
	end	function Vehicle.getClosestVehicleToCoords(coords, includePlayerVehicles)
	    local maxDistance = 6
	    local closestVehicle
	    local curVehicle = PED.IS_PED_IN_ANY_VEHICLE(Player.getPlayerPed(), false) and entities.get_user_vehicle_as_pointer()
	    for _, vehicle in entities.get_all_vehicles_as_pointers() do
	        local modelHash = entities.get_model_hash(vehicle)
	        if vehicle ~= curVehicle and not VEHICLE.IS_THIS_MODEL_A_TRAIN(modelHash) then
	            if includePlayerVehicles or entities.get_owner(vehicle) == 0 then
	                local vehicleCoords = entities.get_position(vehicle)
	                local distance = v3.distance(coords, vehicleCoords)
	                if distance < maxDistance then
	                    maxDistance = distance
	                    closestVehicle = vehicle
	                end
	            end
	        end
	    end
	    if closestVehicle then
	        return entities.pointer_to_handle(closestVehicle)
	    end
	    return nil
	end
	function Vehicle.launch(entity, direction)
	    if not Network.requestControl(entity) then
	        return
	    end
	    if direction == "down" then
	        ENTITY.SET_ENTITY_VELOCITY(entity, 0, 0, -1000)
	    elseif direction == "up" then
	        ENTITY.SET_ENTITY_VELOCITY(entity, 0, 0, 1000)
	    elseif direction == "forward" then
	        VEHICLE.SET_VEHICLE_FORWARD_SPEED(entity, 200.0)
	    else
	        VEHICLE.SET_VEHICLE_FORWARD_SPEED(entity, -200.0)
	    end
	end	function Vehicle.randomLaunch(entity)
	    if not Network.requestControl(entity) then
	        return
	    end
	    local randX = Utils.rand(-200, 200)
	    local randY = Utils.rand(-200, 200)
	    local randZ = Utils.rand(-200, 200)
	    ENTITY.APPLY_FORCE_TO_ENTITY(entity, 1, randX, randY, randZ, randX, randY, randZ, 0, 0, 0, 0, 0, 0)
	end	function Vehicle.empty(vehicle)
	    local maxPassengers = VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(vehicle)
	    for i = -1, maxPassengers do
	        if UND_settings.emptyFrom ~= UND_translations.general.all then
	            if (i == -1 and UND_settings.emptyFrom ~= UND_translations.general.driver) or (i > -1 and UND_settings.emptyFrom ~= UND_translations.general.passengers) then
	                goto continue
	            end
	        end
	        if not VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, i, false) then
	            local pedToKick = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, i, false)
	            Ped.kickFromVehicle(pedToKick)
	        end
	        ::continue::
	    end
	end	function Vehicle.spin(entity)
	    if not Network.requestControl(entity) then
	        return
	    end
	    util.create_thread(function()
	        ENTITY.SET_ENTITY_ANGULAR_VELOCITY(entity, 0, 0, 6000)
	        util.yield(300)
	        ENTITY.SET_ENTITY_ANGULAR_VELOCITY(entity, 0, 0, 3000)
	        util.stop_thread()
	    end)
	end
	function Vehicle.flip(entity, horizontal)
	    if not Network.requestControl(entity) then
	        return
	    end
	    local curRotation = ENTITY.GET_ENTITY_ROTATION(entity, 2)
	    if horizontal then
	        local speed = ENTITY.GET_ENTITY_SPEED(entity)
	        ENTITY.SET_ENTITY_ROTATION(entity, curRotation.x + 180, curRotation.y + 180, curRotation.z, 2, true)
	        VEHICLE.SET_VEHICLE_FORWARD_SPEED(entity, speed)
	    else
	        ENTITY.SET_ENTITY_ROTATION(entity, curRotation.x, curRotation.y + 180, curRotation.z, 2, true)
	    end
	end	function Vehicle.rotate(entity)
	    if not Network.requestControl(entity) then
	        return
	    end
	    local currentRotation = ENTITY.GET_ENTITY_ROTATION(entity, 2)
	    ENTITY.SET_ENTITY_ROTATION(entity, currentRotation.x, currentRotation.y, currentRotation.z + 40, 2, true)
	end	function Vehicle.stop(vehicle)
	    if not Network.requestControl(vehicle) then
	        return
	    end
	    VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, 0)
	end	function Vehicle.putOnWheels(vehicle)
	    if not Network.requestControl(vehicle) then
	        return
	    end
	    VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(vehicle, 5.0)
	end	function Vehicle.turnOffEngine(vehicle)
	    if not Network.requestControl(vehicle) then
	        return
	    end
	    VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, false, true, true)
	    VEHICLE.BRING_VEHICLE_TO_HALT(vehicle, 15.0, 0)
	    VEHICLE.SET_HELI_BLADES_SPEED(vehicle, 0.0)
	    if VEHICLE.IS_THIS_MODEL_A_PLANE(ENTITY.GET_ENTITY_MODEL(vehicle)) then
	        util.create_thread(function()
	            util.yield(Utils.rand(1000, 3000))
	            VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, false, false)
	            util.stop_thread()
	        end)
	    end
	end
	local colorR, colorG, colorB = memory.alloc(1), memory.alloc(1), memory.alloc(1)
	function Vehicle.copyVehicleData(vehicle, cloneVehicle)
	    VEHICLE.SET_VEHICLE_MOD_KIT(cloneVehicle, 0)
	    for i = 17, 22 do
	        VEHICLE.TOGGLE_VEHICLE_MOD(cloneVehicle, i, VEHICLE.IS_TOGGLE_MOD_ON(vehicle, i))
	    end
	    for i = 0, 49 do
	        local modValue = VEHICLE.GET_VEHICLE_MOD(vehicle, i)
	        VEHICLE.SET_VEHICLE_MOD(cloneVehicle, i, modValue)
	    end
	    if VEHICLE.GET_IS_VEHICLE_PRIMARY_COLOUR_CUSTOM(vehicle) then
	        VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, colorR, colorG, colorB)
	        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
	    else
	        VEHICLE.GET_VEHICLE_MOD_COLOR_1(vehicle, colorR, colorG, colorB)
	        VEHICLE.SET_VEHICLE_MOD_COLOR_1(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
	    end
	    if VEHICLE.GET_IS_VEHICLE_SECONDARY_COLOUR_CUSTOM(vehicle) then
	        VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, colorR, colorG, colorB)
	        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
	    else
	        VEHICLE.GET_VEHICLE_MOD_COLOR_2(vehicle, colorR, colorG)
	        VEHICLE.SET_VEHICLE_MOD_COLOR_2(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG))
	    end
	    VEHICLE.GET_VEHICLE_COLOURS(vehicle, colorR, colorG)
	    VEHICLE.SET_VEHICLE_COLOURS(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG))
	    VEHICLE.GET_VEHICLE_EXTRA_COLOURS(vehicle, colorR, colorG)
	    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG))
	    VEHICLE.GET_VEHICLE_EXTRA_COLOUR_5(vehicle, colorR)
	    VEHICLE.GET_VEHICLE_EXTRA_COLOUR_6(vehicle, colorG)
	    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(cloneVehicle, memory.read_ubyte(colorR))
	    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(cloneVehicle, memory.read_ubyte(colorG))
	    VEHICLE.GET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, colorR, colorG, colorB)
	    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
	    VEHICLE.GET_VEHICLE_NEON_COLOUR(vehicle, colorR, colorG, colorB)
	    VEHICLE.SET_VEHICLE_NEON_COLOUR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
	    for i = 0, 3 do
	        VEHICLE.SET_VEHICLE_NEON_ENABLED(cloneVehicle, i, VEHICLE.GET_VEHICLE_NEON_ENABLED(vehicle, i))
	    end
	    local windowTint = VEHICLE.GET_VEHICLE_WINDOW_TINT(vehicle)
	    VEHICLE.SET_VEHICLE_WINDOW_TINT(cloneVehicle, windowTint)
	    local lightsColor = VEHICLE.GET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vehicle)
	    VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(cloneVehicle, lightsColor)
	    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(cloneVehicle, VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle))
	    Vehicle.setVehiclePlate(cloneVehicle, VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT(vehicle))
	    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(cloneVehicle, VEHICLE.GET_VEHICLE_TYRES_CAN_BURST(vehicle))
	    VEHICLE.SET_VEHICLE_DIRT_LEVEL(cloneVehicle, VEHICLE.GET_VEHICLE_DIRT_LEVEL(vehicle))
	    for i = 1, 14 do
	        VEHICLE.SET_VEHICLE_EXTRA(cloneVehicle, i, not VEHICLE.IS_VEHICLE_EXTRA_TURNED_ON(vehicle, i))
	    end
	    local roofState = VEHICLE.GET_CONVERTIBLE_ROOF_STATE(vehicle)
	    if roofState == 1 or roofState == 2 then
	        VEHICLE.LOWER_CONVERTIBLE_ROOF(cloneVehicle, true)
	    end
	    VEHICLE.SET_VEHICLE_ENGINE_ON(cloneVehicle, VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(vehicle), true, true)
	end
	function Vehicle.clone(vehicle)
	    local vehicleHeading = ENTITY.GET_ENTITY_HEADING(vehicle)
	    local vehicleHash = ENTITY.GET_ENTITY_MODEL(vehicle)
	    local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
	    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle)
	    local rot = ENTITY.GET_ENTITY_ROTATION(vehicle, 2):toDir()
	    v3.mul(rot, -Utils.getDimensions(vehicle).x - 2)
	    v3.add(coords, rot)
	    local cloneVehicle = entities.create_vehicle(vehicleHash, coords, vehicleHeading)
	    Vehicle.copyVehicleData(vehicle, cloneVehicle)
	    return cloneVehicle
	end	function Vehicle.killEngine(vehicle)
	    if not Network.requestControl(vehicle) then
	        return
	    end
	    VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, -4000)
	end	function Vehicle.burn(vehicle)
	    if not Network.requestControl(vehicle) then
	        return
	    end
	    VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, -1)
	end
	function Vehicle.sink(vehicle, lockDoors)
	    if not Network.requestControl(vehicle) then
	        return
	    end
	    if lockDoors then
	        Vehicle.lockDoors(vehicle, true)
	    end
	    ENTITY.SET_ENTITY_COORDS(vehicle, -9725, -7276, -100, false, false, false, false)
	end	function Vehicle.tpToSky(vehicle)
	    if not Network.requestControl(vehicle) then
	        return
	    end
	    local randX = Utils.rand(-2000, 2000)
	    local randY = Utils.rand(-2000, 2000)
	    ENTITY.SET_ENTITY_COORDS(vehicle, randX, randY, 2600, false, false, false, false)
	end
	function Vehicle.explode(vehicle, random)
	    Vehicle.killEngine(vehicle)
	    local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
	    local vel = ENTITY.GET_ENTITY_VELOCITY(vehicle)
	    local speed = ENTITY.GET_ENTITY_SPEED(vehicle)
	    local divider = 20
	    if speed > 70 then
	        divider = 50
	    end
	    local expType = 28
	    if random then
	        expType = Utils.rand(0, 84)
	    end
	    if UND_settings.explodeType == UND_translations.general.owned then
	        FIRE.ADD_OWNED_EXPLOSION(Player.getPlayerPed(), coords.x + vel.x / divider, coords.y + vel.y / divider, coords.z + vel.z / divider, expType, 100, true, false, 0.5)
	    else
	        FIRE.ADD_EXPLOSION(coords.x + vel.x / divider, coords.y + vel.y / divider, coords.z + vel.z / divider, expType, 100, true, false, 0.5)
	    end
	end	function Vehicle.airstrike(vehicle)
	    local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
	    local vel = ENTITY.GET_ENTITY_VELOCITY(vehicle)
	    local weaponHash = Utils.requestWeaponAsset("VEHICLE_WEAPON_PLANE_ROCKET")
	    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(coords.x + Utils.rand(-5, 5), coords.y + Utils.rand(-5, 5), coords.z + 50, coords.x + vel.x, coords.y + vel.y, coords.z + vel.z, 0,
	        false, weaponHash, 0, true, false, 2000)
	    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(weaponHash)
	end	function Vehicle.glitch(vehicle)
	    if not Network.requestControl(vehicle) then
	        return
	    end
	    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle)
	    local glitchHash = -994492850
	    util.request_model(glitchHash)
	    util.create_thread(function()
	        for i = 1, 100 do
	            local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
	            local glitchObj = entities.create_object(glitchHash, coords)
	            ENTITY.SET_ENTITY_VISIBLE(glitchObj, false)
	            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0)
	            util.yield(10)
	            Utils.deleteEntity(glitchObj)
	        end
	        util.stop_thread()
	    end)
	    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(glitchHash)
	end	function Vehicle.slick(vehicle)
	    local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
	    local vel = ENTITY.GET_ENTITY_VELOCITY(vehicle)
	    FIRE.ADD_EXPLOSION(coords.x + vel.x / 2, coords.y + vel.y / 2, coords.z + vel.z / 2, 67, 100, true, false, 0)
	end	function Vehicle.bump(vehicle)
	    local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
	    local vel = ENTITY.GET_ENTITY_VELOCITY(vehicle)
	    FIRE.ADD_EXPLOSION(coords.x + vel.x / 8, coords.y + vel.y / 8, coords.z + vel.z / 8, 64, 1, true, true, 0)
	end	function Vehicle.emp(vehicle)
	    local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
	    local vel = ENTITY.GET_ENTITY_VELOCITY(vehicle)
	    FIRE.ADD_EXPLOSION(coords.x + vel.x / 10, coords.y + vel.y / 10, coords.z + vel.z / 10, 83, 1, true, false, 0)
	end	function Vehicle.damage(vehicle)
	    if not Network.requestControl(vehicle) then
	        return
	    end
	    if UND_settings.damageSettings.smokeEngine then
	        VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, 300)
	    end
	    if UND_settings.damageSettings.tyres then
	        VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, true)
	        for i = 0, 7 do
	            if not UND_settings.damageSettings.popOnce or VEHICLE.GET_TYRE_HEALTH(vehicle, i) > 0 then
	                VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, i, true, 1000)
	            end
	        end
	    end
	    if UND_settings.damageSettings.windows then
	        for i = 0, 7 do
	            VEHICLE.SMASH_VEHICLE_WINDOW(vehicle, i)
	        end
	    end
	    if UND_settings.damageSettings.doors then
	        local doorsNum = VEHICLE.GET_NUMBER_OF_VEHICLE_DOORS(vehicle)
	        for i = 0, doorsNum do
	            VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, i, false)
	        end
	    end
	end	function Vehicle.turnOnEngine(vehicle)
	    if not Network.requestControl(vehicle, nil, true) then
	        return
	    end
	    VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, false)
	    VEHICLE.SET_HELI_BLADES_FULL_SPEED(vehicle)
	end
	function Vehicle.tpToPlayer(vehicle, pid)
	    if not Network.requestControl(vehicle) then
	        return
	    end
	    pid = pid or Player.getUserPlayer()
	    local pCoords = Player.getPlayerPosition(pid)
	    local rot = ENTITY.GET_ENTITY_ROTATION(Player.getPlayerPed(pid), 2):toDir()
	    local extraOffset = 0
	    if Ped.getVehicle(Player.getPlayerPed(pid)) then
	        extraOffset = Utils.getDimensions(Ped.getVehicle(Player.getPlayerPed(pid))).x
	    end
	    v3.mul(rot, Utils.getDimensions(vehicle).x + extraOffset + 2)
	    v3.add(pCoords, rot)
	    ENTITY.SET_ENTITY_COORDS(vehicle, pCoords.x, pCoords.y, pCoords.z, false, false, false)
	end
	function Vehicle.freeze(vehicle, enabled)
	    if not Network.requestControl(vehicle) then
	        return
	    end
	    ENTITY.FREEZE_ENTITY_POSITION(vehicle, enabled)
	end	function Vehicle.hornBoost(vehicle)
	    if AUDIO.IS_HORN_ACTIVE(vehicle) then
	        local speed = ENTITY.GET_ENTITY_SPEED(vehicle)
	        VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, speed + UND_settings.hornBoostSpeed / 2)
	        util.yield(300)
	    end
	end	function Vehicle.hornJump(vehicle)
	    if AUDIO.IS_HORN_ACTIVE(vehicle) then
	        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(vehicle, 1, 0.0, 0.0, UND_settings.hornJumpForce, true, true, true, true)
	        util.yield(500)
	    end
	end	function Vehicle.hornExplosions(vehicle)
	    if AUDIO.IS_HORN_ACTIVE(vehicle) then
	        util.create_thread(function()
	            local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
	            local shootCoords = v3.new(coords)
	            for i = 1, 3 do
	                local rot = ENTITY.GET_ENTITY_ROTATION(vehicle, 2):toDir()
	                local vel = ENTITY.GET_ENTITY_VELOCITY(vehicle)
	                v3.mul(rot, 25 + math.abs(vel.x))
	                v3.add(shootCoords, rot)
	                FIRE.ADD_OWNED_EXPLOSION(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1), shootCoords.x + Utils.rand(-2, 2), shootCoords.y + Utils.rand(-2, 2), shootCoords.z, 10, 100,
	                    true, false, 0.1)
	                util.yield()
	            end
	            util.yield(300)
	            util.stop_thread()
	        end)
	    end
	end
	function Vehicle.lockDoors(vehicle, enabled)
	    if not Network.requestControl(vehicle) then
	        return
	    end
	    local val = 4
	    if not enabled then
	        val = 0
	    end
	    VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, val)
	end	function Vehicle.tpToVehicle(vehicle)
	    local entityToTeleport = Vehicle.getPlayerOrVehicleEntity()
	    if not entityToTeleport then
	        return
	    end
	    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle)
	    local coords = Utils.rotateToEntity(vehicle)
	    ENTITY.SET_ENTITY_COORDS(entityToTeleport, coords.x, coords.y, coords.z + 1, false, false, false, false)
	end
	function Vehicle.toggleInvisible(vehicle, enabled)
	    if not Network.requestControl(vehicle) then
	        return
	    end
	    if enabled ~= nil then
	        ENTITY.SET_ENTITY_VISIBLE(vehicle, not enabled, 0)
	    else
	        local isVisible = ENTITY.IS_ENTITY_VISIBLE(vehicle)
	        ENTITY.SET_ENTITY_VISIBLE(vehicle, not isVisible, 0)
	    end
	end	function Vehicle.atomize(vehicle)
	    local vehCoords = ENTITY.GET_ENTITY_COORDS(vehicle)
	    local weaponHash = Utils.requestWeaponAsset("WEAPON_RAYPISTOL")
	    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(vehCoords.x, vehCoords.y, vehCoords.z + 1, vehCoords.x, vehCoords.y, vehCoords.z, 1000, false, weaponHash, 0, true, false, 1000)
	    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(weaponHash)
	end	function Vehicle.fireworks(vehicle)
	    local vehCoords = ENTITY.GET_ENTITY_COORDS(vehicle)
	    local weaponHash = Utils.requestWeaponAsset("WEAPON_FIREWORK")
	    local zOffset = Utils.getDimensions(vehicle).z
	    if zOffset <= 2 then
	        zOffset = zOffset + 3
	    end
	    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(vehCoords.x, vehCoords.y, vehCoords.z + zOffset, vehCoords.x + Utils.rand(-5, 5), vehCoords.y + Utils.rand(-5, 5), vehCoords.z + 10, 0,
	        false, weaponHash, 0, true, false, 1000)
	    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(weaponHash)
	end	function Vehicle.drive(vehicle)
	    local vehicleData = Vehicle.getTargetVehicleData(vehicle)
	    if vehicleData.driver ~= 0 then
	        Ped.kickFromVehicle(vehicleData.driver)
	        if vehicleData.player == -1 then
	            Utils.deleteEntity(vehicleData.driver)
	        end
	        local maxTime = Utils.getTime(2000)
	        while ENTITY.DOES_ENTITY_EXIST(vehicleData.driver) and PED.IS_PED_IN_ANY_VEHICLE(vehicleData.driver, false) do
	            if Utils.getTime() > maxTime then
	                break
	            end
	            util.yield()
	        end
	    end
	    PED.SET_PED_INTO_VEHICLE(Player.getPlayerPed(), vehicle, -1)
	    if not VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(vehicle) then
	        Vehicle.turnOnEngine(vehicle)
	    end
	end	function Vehicle.enter(vehicle)
	    local vehicleData = Vehicle.getTargetVehicleData(vehicle)
	    if not VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
	        Utils.showToast(UND_translations.vehicle.noFreeSeats)
	        return
	    end
	    local seatIdx = -1
	    if vehicleData.driver ~= 0 then
	        seatIdx = -2
	    end
	    PED.SET_PED_INTO_VEHICLE(Player.getPlayerPed(), vehicle, seatIdx)
	    if not VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(vehicle) then
	        Vehicle.turnOnEngine(vehicle)
	    end
	end
	function Vehicle.spawnRandom(coords)
	    local randIdx = Utils.rand(1, #allVehicles)
	    local hash = util.joaat(allVehicles[randIdx].name)
	    util.request_model(hash)
	    local vehicle = entities.create_vehicle(hash, coords, 0)
	    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
	    return vehicle
	end
	function Vehicle.getName(hash)
	    if not UND_settings.showVehModelName and util.get_label_text(hash) ~= "NULL" then
	        return util.get_label_text(hash)
	    end
	    return util.reverse_joaat(hash)
	end	function Vehicle.npcHijack(vehicle)
	    util.create_thread(function()
	        local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
	        local rot = ENTITY.GET_ENTITY_ROTATION(vehicle, 2)
	        local rotDir = rot:toDir()
	        v3.mul(rotDir, -5)
	        v3.add(coords, rotDir)
	        Vehicle.lockDoors(vehicle, false)
	        local hash = util.joaat("u_m_y_babyd")
	        util.request_model(hash)
	        local ped = entities.create_ped(0, hash, coords, 0)
	        Ped.toggleGod(ped, true)
	        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
	        TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
	        util.yield()
	        Vehicle.emp(vehicle)
	        Vehicle.stop(vehicle)
	        Vehicle.lockDoors(vehicle, false)
	        TASK.TASK_VEHICLE_DRIVE_WANDER(ped, vehicle, 200.0, 1074528293)
	        local maxTime = Utils.getTime(15000)
	        util.create_tick_handler(function()
	            if VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1) ~= ped then
	                Vehicle.turnOffEngine(vehicle)
	                TASK.TASK_VEHICLE_DRIVE_WANDER(ped, vehicle, 200.0, 1074528293)
	                util.yield(500)
	            else
	                VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true)
	                Vehicle.lockDoors(vehicle, true)
	                util.yield(800)
	                VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, 15)
	                TASK.TASK_VEHICLE_DRIVE_WANDER(ped, vehicle, 200.0, 1074528293)
	                return false
	            end
	            if Utils.getTime() >= maxTime then
	                if VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1) ~= ped then
	                    Utils.deleteEntity(ped)
	                end
	                return false
	            end
	        end)
	        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(weaponHash)
	        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
	        util.stop_thread()
	    end)
	end
	return Vehicle
end
package.loaded["src.lib.vehicle"] = nil
package.preload["src.lib.menus.world.clearArea"] = function(...)
	
end
package.loaded["src.lib.menus.world.clearArea"] = nil
package.preload["src.lib.menus.self"] = function(...)
	
end
package.loaded["src.lib.menus.self"] = nil
package.preload["src.lib.menus.vehicle"] = function(...)
	
end
package.loaded["src.lib.menus.vehicle"] = nil
package.preload["src.lib.menus.world.manipulateArea"] = function(...)
	
end
package.loaded["src.lib.menus.world.manipulateArea"] = nil
package.preload["src.lib.updater"] = function(...)
end
package.loaded["src.lib.updater"] = nil
package.preload["src.lib.menus.aim.object"] = function(...)
	local _Raycast = CONSTANTS.RAYCAST
	local function delete()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.objects)
	    if not aimResult then
	        return
	    end
	    Utils.deleteEntity(aimResult.entity)
	end
	local function clone()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.objects)
	    if not aimResult then
	        return
	    end
	    local entity = aimResult.entity
	    local hash = ENTITY.GET_ENTITY_MODEL(entity)
	    local coords = aimResult.coords
	    local rotation = ENTITY.GET_ENTITY_ROTATION(entity, 2)
	    local rot = rotation:toDir()
	    v3.mul(rot, -Utils.getDimensions(entity).x)
	    v3.add(coords, rot)
	    local clonedObject = entities.create_object(hash, coords)
	    ENTITY.SET_ENTITY_ROTATION(clonedObject, rotation.x, rotation.y, rotation.z, 2, true)
	    if UND_privateMode then
	        Utils.logToFile(hash)
	    end
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
	    if UND_currentlyMovedObject == 2 then
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
	        directx.draw_text(0.5, 0.8, UND_translations.aim.moveTo, 5, 0.6, {
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
	local function toggleInvisible()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.objects)
	    if not aimResult then
	        return
	    end
	    local isVisible = ENTITY.IS_ENTITY_VISIBLE(aimResult.entity)
	    ENTITY.SET_ENTITY_VISIBLE(aimResult.entity, not isVisible, 0)
	end	local function setupObjectAimActions(aimObjectsSubmenu)
	    menu.action(aimObjectsSubmenu, UND_translations.general.delete, {}, "", delete)
	    menu.action(aimObjectsSubmenu, UND_translations.general.clone, {}, "", clone)
	    menu.action(aimObjectsSubmenu, UND_translations.general.rotate, {}, "", rotate)
	    menu.action(aimObjectsSubmenu, UND_translations.aim.move, {}, UND_translations.aim.moveObjD, move)
	    menu.action(aimObjectsSubmenu, UND_translations.general.freeze, {}, "", freeze)
	    menu.action(aimObjectsSubmenu, UND_translations.general.unfreeze, {}, "", unfreeze)
	    menu.action(aimObjectsSubmenu, UND_translations.general.toggleInv, {}, "", toggleInvisible)
	end
	return setupObjectAimActions
end
package.loaded["src.lib.menus.aim.object"] = nil
package.preload["src.lib.ped"] = function(...)
	local Ped = {}
	local invRef = menu.ref_by_path("Self>Appearance>Invisibility")	function Ped.kickFromVehicle(ped)
	    TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
	    TASK.TASK_LEAVE_ANY_VEHICLE(ped, 0, 16)
	end	function Ped.ragdoll(ped)
	    local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
	    FIRE.ADD_EXPLOSION(pedCoords.x, pedCoords.y, pedCoords.z - 1, 70, 0.1, false, true, 0.0, true)
	end	function Ped.burn(ped)
	    FIRE.START_ENTITY_FIRE(ped)
	    local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
	    FIRE.ADD_EXPLOSION(pedCoords.x, pedCoords.y, pedCoords.z - 1, 12, 3.0, true, true, 1.0, false)
	    util.yield(5000)
	    FIRE.STOP_ENTITY_FIRE(ped)
	end	function Ped.explode(ped, random, ownedAs)
	    local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
	    local expType = 1
	    if random then
	        expType = Utils.rand(0, 84)
	    end
	    if UND_settings.explodeType == UND_translations.general.owned then
	        FIRE.ADD_OWNED_EXPLOSION(ownedAs or Player.getPlayerPed(), pedCoords.x, pedCoords.y, pedCoords.z, expType, 100, true, false, 0.0)
	    else
	        FIRE.ADD_EXPLOSION(pedCoords.x, pedCoords.y, pedCoords.z, expType, 100, true, false, 0.0, false)
	    end
	end
	function Ped.clone(ped)
	    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ped)
	    local newPed = PED.CLONE_PED(ped, true, false, true)
	    if UND_settings.clonedPedTask == UND_translations.general.walk then
	        TASK.TASK_WANDER_STANDARD(newPed, 10.0, 10)
	    elseif UND_settings.clonedPedTask == UND_translations.general.attack then
	        TASK.TASK_COMBAT_PED(newPed, ped, 0, 16)
	    elseif UND_settings.clonedPedTask == UND_translations.general.flee then
	        TASK.TASK_REACT_AND_FLEE_PED(newPed, ped)
	    end
	    return newPed
	end
	function Ped.getHealth(ped)
	    local hp = ENTITY.GET_ENTITY_HEALTH(ped)
	    local maxHp = PED.GET_PED_MAX_HEALTH(ped)
	    local armor = PED.GET_PED_ARMOUR(ped)
	    local total = hp
	    if maxHp == 0 then
	        total = 0
	    elseif armor > 0 then
	        total = math.floor((total + armor) / (maxHp + 50) * 100)
	    else
	        total = math.floor(total / maxHp * 100)
	    end
	    return {
	        health = hp,
	        armor = armor,
	        maxHealth = maxHp,
	        total = total .. "%"
	    }
	end	function Ped.disarm(ped)
	    WEAPON.REMOVE_ALL_PED_WEAPONS(ped, false)
	end
	function Ped.freeze(ped, enabled)
	    ENTITY.FREEZE_ENTITY_POSITION(ped, enabled)
	end	function Ped.revive(ped)
	    local newPed = Ped.clone(ped)
	    Utils.deleteEntity(ped)
	    ENTITY.SET_ENTITY_HEALTH(newPed, 100)
	    TASK.TASK_WANDER_STANDARD(newPed, 10.0, 10)
	end
	function Ped.toggleGod(ped, enabled)
	    ENTITY.SET_ENTITY_INVINCIBLE(ped, enabled)
	    ENTITY.SET_ENTITY_PROOFS(ped, enabled, enabled, enabled, enabled, enabled, enabled, 1, enabled)
	end
	function Ped.shoot(ped, forceAnonymous)
	    util.create_thread(function()
	        local curInvValue = invRef.value
	        local weaponHash = Utils.requestWeaponAsset("WEAPON_HEAVYSNIPER")
	        local killerPed
	        if forceAnonymous or UND_settings.shootType ~= UND_translations.general.owned then
	            if PED.IS_PED_A_PLAYER(ped) then
	                local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
	                killerPed = entities.create_ped(0, ENTITY.GET_ENTITY_MODEL(ped), pedCoords, 0)	                ENTITY.SET_ENTITY_VISIBLE(killerPed, false)
	                util.yield(150)
	            else
	                killerPed = 0
	            end
	        else
	            killerPed = Player.getPlayerPed()
	            if curInvValue > 0 then
	                invRef.value = 0
	                util.yield(350)
	            end
	        end
	        for i = 1, 8 do
	            local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
	            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pedCoords.x, pedCoords.y, pedCoords.z + 1, pedCoords.x, pedCoords.y, pedCoords.z, 1000, false, weaponHash, killerPed, true,
	                false, 1000)
	            util.yield()
	        end
	        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(weaponHash)
	        if UND_settings.shootType ~= UND_translations.general.owned then
	            Utils.deleteEntity(killerPed)
	        end
	        invRef.value = curInvValue
	        util.stop_thread()
	    end)
	end
	function Ped.getClosestPedToCoords(coords)
	    local maxDistance = 3
	    local closestPed
	    local myPed = Player.getPlayerPed()
	    for _, ped in entities.get_all_peds_as_handles() do
	        if ped ~= myPed and not PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
	            local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
	            local distance = v3.distance(coords, pedCoords)
	            if distance < maxDistance then
	                maxDistance = distance
	                closestPed = ped
	            end
	        end
	    end
	    return closestPed
	end	function Ped.toggleInvisible(ped)
	    local isVisible = ENTITY.IS_ENTITY_VISIBLE(ped)
	    ENTITY.SET_ENTITY_VISIBLE(ped, not isVisible, 0)
	end	function Ped.atomize(ped)
	    local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
	    local weaponHash = Utils.requestWeaponAsset("WEAPON_RAYPISTOL")
	    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pedCoords.x, pedCoords.y, pedCoords.z + 1, pedCoords.x, pedCoords.y, pedCoords.z, 1000, false, weaponHash, 0, true, false, 1000)
	    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(weaponHash)
	end	function Ped.fireworks(ped)
	    local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
	    local weaponHash = Utils.requestWeaponAsset("WEAPON_FIREWORK")
	    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pedCoords.x, pedCoords.y, pedCoords.z + 3, pedCoords.x + Utils.rand(-5, 5), pedCoords.y + Utils.rand(-5, 5), pedCoords.z + 10, 0, false,
	        weaponHash, 0, true, false, 1000)
	    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(weaponHash)
	end	function Ped.airstrike(ped)
	    local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
	    local weaponHash = Utils.requestWeaponAsset("VEHICLE_WEAPON_PLANE_ROCKET")
	    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pedCoords.x + Utils.rand(-5, 5), pedCoords.y + Utils.rand(-5, 5), pedCoords.z + 50, pedCoords.x, pedCoords.y, pedCoords.z, 0, false,
	        weaponHash, 0, true, false, 2000)
	    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(weaponHash)
	end	function Ped.waterJet(ped)
	    local coords = ENTITY.GET_ENTITY_COORDS(ped)
	    FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z - 2.0, 13, 1, true, false, 0, false)
	end	function Ped.flameJet(ped)
	    local coords = ENTITY.GET_ENTITY_COORDS(ped)
	    FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z - 2.0, 12, 1, true, false, 0, false)
	end
	function Ped.getVehicle(ped)
	    return PED.IS_PED_SITTING_IN_ANY_VEHICLE(ped) and PED.GET_VEHICLE_PED_IS_IN(ped, false)
	end
	local weapons = util.get_weapons()
	local weaponHash = memory.alloc_int()
	function Ped.getWeapon(ped)
	    WEAPON.GET_CURRENT_PED_WEAPON(ped, weaponHash, true)
	    local readWeaponHash = memory.read_int(weaponHash)
	    local weaponName
	    for _, wep in weapons do
	        if wep.hash == readWeaponHash then
	            weaponName = util.get_label_text(wep.label_key)
	            break
	        end
	    end
	    return weaponName
	end	function Ped.cage(ped, type, cageObjects, invisible)
	    cageObjects = cageObjects or {}
	    local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
	    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ped)
	    if type == UND_translations.general.small then
	        local objHash = util.joaat("prop_gold_cont_01")
	        util.request_model(objHash)
	        local obj = entities.create_object(objHash, pedCoords)
	        ENTITY.SET_ENTITY_VISIBLE(obj, not invisible)
	        ENTITY.FREEZE_ENTITY_POSITION(obj, true)
	        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(objHash)
	        cageObjects[#cageObjects + 1] = obj
	        return
	    end
	    if type == UND_translations.general.fence then
	        local objHash = util.joaat("prop_fnclink_03e")
	        util.request_model(objHash)
	        pedCoords.z = pedCoords.z - 1.0
	        local object = {}
	        object[1] = entities.create_object(objHash, v3.new(pedCoords.x - 1.5, pedCoords.y + 1.5, pedCoords.z))
	        object[2] = entities.create_object(objHash, v3.new(pedCoords.x - 1.5, pedCoords.y - 1.5, pedCoords.z))
	        object[3] = entities.create_object(objHash, v3.new(pedCoords.x + 1.5, pedCoords.y + 1.5, pedCoords.z))
	        local rot_3 = ENTITY.GET_ENTITY_ROTATION(object[3], 2)
	        rot_3.z = -90.0
	        ENTITY.SET_ENTITY_ROTATION(object[3], rot_3.x, rot_3.y, rot_3.z, 1, true)
	        object[4] = entities.create_object(objHash, v3.new(pedCoords.x - 1.5, pedCoords.y + 1.5, pedCoords.z))
	        local rot_4 = ENTITY.GET_ENTITY_ROTATION(object[4], 2)
	        rot_4.z = -90.0
	        ENTITY.SET_ENTITY_ROTATION(object[4], rot_4.x, rot_4.y, rot_4.z, 1, true)
	        for i = 1, 4 do
	            ENTITY.FREEZE_ENTITY_POSITION(object[i], true)
	            ENTITY.SET_ENTITY_VISIBLE(object[i], not invisible)
	            cageObjects[#cageObjects + 1] = object[i]
	        end
	        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(objHash)
	        return
	    end
	    if type == UND_translations.general.hell then
	        local objHash = util.joaat("hei_prop_station_gate")
	        util.request_model(objHash)
	        pedCoords.z = pedCoords.z - 1.0
	        local object = {}
	        object[1] = entities.create_object(objHash, v3.new(pedCoords.x + 2.75, pedCoords.y + 2.75, pedCoords.z))
	        object[2] = entities.create_object(objHash, v3.new(pedCoords.x + 2.75, pedCoords.y + 2.75, pedCoords.z + 2))
	        object[3] = entities.create_object(objHash, v3.new(pedCoords.x + 2.75, pedCoords.y - 2.75, pedCoords.z))
	        object[4] = entities.create_object(objHash, v3.new(pedCoords.x + 2.75, pedCoords.y - 2.75, pedCoords.z + 2))
	        object[5] = entities.create_object(objHash, v3.new(pedCoords.x + 2.75, pedCoords.y - 2.75, pedCoords.z))
	        object[6] = entities.create_object(objHash, v3.new(pedCoords.x + 2.75, pedCoords.y - 2.75, pedCoords.z + 2))
	        local rot5 = ENTITY.GET_ENTITY_ROTATION(object[5], 2)
	        rot5.z = -90.0
	        ENTITY.SET_ENTITY_ROTATION(object[5], rot5.x, rot5.y, rot5.z, 2, true)
	        ENTITY.SET_ENTITY_ROTATION(object[6], rot5.x, rot5.y, rot5.z, 2, true)
	        object[7] = entities.create_object(objHash, v3.new(pedCoords.x - 2.75, pedCoords.y - 2.75, pedCoords.z))
	        object[8] = entities.create_object(objHash, v3.new(pedCoords.x - 2.75, pedCoords.y - 2.75, pedCoords.z + 2))
	        local rot7 = ENTITY.GET_ENTITY_ROTATION(object[7], 2)
	        rot7.z = -90.0
	        ENTITY.SET_ENTITY_ROTATION(object[7], rot7.x, rot7.y, rot7.z, 2, true)
	        ENTITY.SET_ENTITY_ROTATION(object[8], rot7.x, rot7.y, rot7.z, 2, true)
	        object[9] = entities.create_object(objHash, v3.new(pedCoords.x, pedCoords.y + 2.75, pedCoords.z + 5))
	        local rot9 = ENTITY.GET_ENTITY_ROTATION(object[9], 2)
	        rot9.x = 90
	        rot9.y = 90
	        ENTITY.SET_ENTITY_ROTATION(object[9], rot9.x, rot9.y, rot9.z, 2, true)
	        object[10] = entities.create_object(objHash, v3.new(pedCoords.x, pedCoords.y + 2.75, pedCoords.z + 5))
	        local rot10 = ENTITY.GET_ENTITY_ROTATION(object[9], 2)
	        rot10.x = -90
	        rot10.y = -90
	        ENTITY.SET_ENTITY_ROTATION(object[10], rot10.x, rot10.y, rot10.z, 2, true)
	        object[11] = entities.create_object(objHash, v3.new(pedCoords.x, pedCoords.y + 2.75, pedCoords.z))
	        ENTITY.SET_ENTITY_ROTATION(object[11], rot9.x, rot9.y, rot9.z, 2, true)
	        object[12] = entities.create_object(objHash, v3.new(pedCoords.x, pedCoords.y + 2.75, pedCoords.z))
	        ENTITY.SET_ENTITY_ROTATION(object[12], rot10.x, rot10.y, rot10.z, 2, true)
	        for i = 1, 12 do
	            ENTITY.FREEZE_ENTITY_POSITION(object[i], true)
	            ENTITY.SET_ENTITY_VISIBLE(object[i], not invisible)
	            cageObjects[#cageObjects + 1] = object[i]
	        end
	        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(objHash)
	        return
	    end
	    if type == UND_translations.general.animal then
	        local objHash = -759902142
	        util.request_model(objHash)
	        pedCoords.z = pedCoords.z - 1.0
	        local object = {}
	        object[1] = entities.create_object(objHash, v3.new(pedCoords.x - 1.5, pedCoords.y + 1.5, pedCoords.z))
	        object[2] = entities.create_object(objHash, v3.new(pedCoords.x - 4.3, pedCoords.y + 1.5, pedCoords.z))
	        object[3] = entities.create_object(objHash, v3.new(pedCoords.x - 1.5, pedCoords.y - 4.3, pedCoords.z))
	        object[4] = entities.create_object(objHash, v3.new(pedCoords.x - 4.3, pedCoords.y - 4.3, pedCoords.z))
	        object[5] = entities.create_object(objHash, v3.new(pedCoords.x + 1.4, pedCoords.y + 1.5, pedCoords.z))
	        object[6] = entities.create_object(objHash, v3.new(pedCoords.x + 1.4, pedCoords.y - 1.4, pedCoords.z))
	        local rot_5 = ENTITY.GET_ENTITY_ROTATION(object[5], 2)
	        rot_5.z = -90.0
	        ENTITY.SET_ENTITY_ROTATION(object[5], rot_5.x, rot_5.y, rot_5.z, 1, true)
	        ENTITY.SET_ENTITY_ROTATION(object[6], rot_5.x, rot_5.y, rot_5.z, 1, true)
	        object[7] = entities.create_object(objHash, v3.new(pedCoords.x - 4.2, pedCoords.y + 1.5, pedCoords.z))
	        object[8] = entities.create_object(objHash, v3.new(pedCoords.x - 4.2, pedCoords.y - 1.4, pedCoords.z))
	        local rot_7 = ENTITY.GET_ENTITY_ROTATION(object[7], 2)
	        rot_7.z = -90.0
	        ENTITY.SET_ENTITY_ROTATION(object[7], rot_7.x, rot_7.y, rot_7.z, 1, true)
	        ENTITY.SET_ENTITY_ROTATION(object[8], rot_7.x, rot_7.y, rot_7.z, 1, true)
	        for i = 1, 8 do
	            ENTITY.FREEZE_ENTITY_POSITION(object[i], true)
	            ENTITY.SET_ENTITY_VISIBLE(object[i], not invisible)
	            cageObjects[#cageObjects + 1] = object[i]
	        end
	        local animalHash = util.joaat("A_C_Panther")
	        util.request_model(animalHash)
	        for i = 1, 4 do
	            local animal = entities.create_ped(0, animalHash, pedCoords, 0)
	            cageObjects[#cageObjects + 1] = animal
	            ENTITY.SET_ENTITY_INVINCIBLE(animal, true)
	            TASK.TASK_COMBAT_PED(animal, ped, 0, 16)
	        end
	        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(objHash)
	        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(animalHash)
	        return
	    end
	    if type == UND_translations.general.electric then
	        local objHash = util.joaat("prop_elecbox_12")
	        util.request_model(objHash)
	        pedCoords.z = pedCoords.z - 1.0
	        local tempV3 = v3.new(0, 0, 0)
	        for i = 1, 6 do
	            local angle = i / 6 * 360
	            tempV3.z = angle
	            local objPos = tempV3:toDir()
	            objPos:mul(2.5)
	            objPos:add(pedCoords)
	            for j = 1, 5 do
	                local cageObj = entities.create_object(objHash, objPos)
	                ENTITY.SET_ENTITY_ROTATION(cageObj, 90.0, 0.0, angle, 2, 0)
	                objPos.z = objPos.z + 0.75
	                ENTITY.FREEZE_ENTITY_POSITION(cageObj, true)
	                ENTITY.SET_ENTITY_VISIBLE(cageObj, not invisible)
	                cageObjects[#cageObjects + 1] = cageObj
	            end
	        end
	        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(objHash)
	        return
	    end
	end
	return Ped
end
package.loaded["src.lib.ped"] = nil
package.preload["src.lib.menus.online.allPlayers"] = function(...)
	local includeMyPed = false
	local function randomBlameKills()
	    if not util.is_session_started() then
	        Utils.showToast(UND_translations.general.onlyOnline)
	        return
	    end
	    for _, pid in players.list(includeMyPed) do
	        if not Player.isDead(pid) then
	            local killerPid = playersList[Utils.rand(1, #playersList)]
	            local tries = 0
	            while killerPid == pid and tries < 3 do
	                tries = tries + 1
	                killerPid = playersList[Utils.rand(1, #playersList)]
	            end
	            Ped.explode(Player.getPlayerPed(killerPid), Player.getPlayerPed(pid))
	        end
	    end
	end
	local function waterJet()
	    if not util.is_session_started() then
	        return
	    end
	    for _, pid in players.list(includeMyPed) do
	        if not Player.isDead(pid) then
	            Ped.waterJet(Player.getPlayerPed(pid))
	        end
	    end
	    util.yield(100)
	end
	local function flameJet()
	    if not util.is_session_started() then
	        return
	    end
	    for _, pid in players.list(includeMyPed) do
	        if not Player.isDead(pid) then
	            Ped.flameJet(Player.getPlayerPed(pid))
	        end
	    end
	    util.yield(100)
	end
	local function explode()
	    if not util.is_session_started() then
	        return
	    end
	    for _, pid in players.list(includeMyPed) do
	        if not Player.isDead(pid) then
	            Ped.explode(Player.getPlayerPed(pid))
	        end
	    end
	    util.yield(100)
	end
	local function randomExplode()
	    if not util.is_session_started() then
	        return
	    end
	    for _, pid in players.list(includeMyPed) do
	        if not Player.isDead(pid) then
	            Ped.explode(Player.getPlayerPed(pid), true)
	        end
	    end
	    util.yield(100)
	end
	local function spawnRandom()
	    if not util.is_session_started() then
	        Utils.showToast(UND_translations.general.onlyOnline)
	        return
	    end
	    for _, pid in players.list(includeMyPed) do
	        if not Player.getInterior(pid) then
	            local coords = Player.getPlayerPosition(pid)
	            local rot = ENTITY.GET_ENTITY_ROTATION(Player.getPlayerPed(pid), 2):toDir()
	            v3.mul(rot, 8)
	            v3.add(coords, rot)
	            Vehicle.spawnRandom(coords)
	        end
	    end
	end
	local function makeWanted()
	    if not util.is_session_started() then
	        Utils.showToast(UND_translations.general.onlyOnline)
	        return
	    end
	    for _, pid in players.list(includeMyPed) do
	        Player.makeWanted(pid)
	        util.yield(100)
	    end
	end
	local function makeWantedLoop()
	    if not util.is_session_started() then
	        return
	    end
	    for _, pid in players.list(includeMyPed) do
	        if Player.getWantedLevel(pid) == 0 then
	            Player.makeWanted(pid)
	            util.yield(100)
	        end
	    end
	end
	local function placeBounty()
	    if not util.is_session_started() then
	        Utils.showToast(UND_translations.general.onlyOnline)
	        return
	    end
	    for _, pid in players.list(includeMyPed) do
	        Player.placeBounty(pid)
	        util.yield(100)
	    end
	end
	local function bountyLoop()
	    if not util.is_session_started() then
	        return
	    end
	    for _, pid in players.list(includeMyPed) do
	        if not players.get_bounty(pid) then
	            Player.placeBounty(pid)
	            util.yield(100)
	        end
	    end
	    util.yield(5000)
	end	local function setupAllPlayersMenu(sessionMenu)
	    local allPlayersMenu = menu.list(sessionMenu, UND_translations.online.allPlayers, {}, "")
	    local includeMyPedToggle = menu.toggle(allPlayersMenu, UND_translations.general.includeMyPed, {Utils.getCommandName("allincludemyped")}, "", function(on)
	        includeMyPed = on
	    end, includeMyPed)
	    includeMyPed = menu.get_value(includeMyPedToggle)
	    menu.divider(allPlayersMenu, UND_translations.player.friendly)
	    menu.action(allPlayersMenu, UND_translations.vehicle.spawnRandom, {Utils.getCommandName("allspawnrandomvehicle")}, "", spawnRandom)
	    menu.divider(allPlayersMenu, UND_translations.player.trolling)
	    menu.action(allPlayersMenu, UND_translations.player.makeWanted, {Utils.getCommandName("allmakewanted")}, "", makeWanted)
	    menu.toggle_loop(allPlayersMenu, UND_translations.player.makeWantedLoop, {Utils.getCommandName("allwantedloop")}, "", makeWantedLoop)
	    menu.action(allPlayersMenu, UND_translations.player.placeBounty, {Utils.getCommandName("allplacebounty")}, "", placeBounty)
	    menu.toggle_loop(allPlayersMenu, UND_translations.player.bountyLoop, {Utils.getCommandName("allbountyloop")}, UND_translations.player.bountyLoopD, bountyLoop)
	    menu.divider(allPlayersMenu, UND_translations.player.malicious)
	    menu.action(allPlayersMenu, UND_translations.online.randomBlameKills, {Utils.getCommandName("allrandomblamekills")}, "", randomBlameKills)
	    menu.toggle_loop(allPlayersMenu, UND_translations.player.waterJet, {Utils.getCommandName("allwaterjet")}, "", waterJet)
	    menu.toggle_loop(allPlayersMenu, UND_translations.player.flameJet, {Utils.getCommandName("allflamejet")}, "", flameJet)
	    menu.toggle_loop(allPlayersMenu, UND_translations.general.explode, {Utils.getCommandName("allexplode")}, "", explode)
	    menu.toggle_loop(allPlayersMenu, UND_translations.general.randomExplosion, {Utils.getCommandName("allrandomexplode")}, "", randomExplode)
	end
	return setupAllPlayersMenu
end
package.loaded["src.lib.menus.online.allPlayers"] = nil
package.preload["src.lib.utils"] = function(...)
	local Utils = {}	function Utils.rand(min, max)
	    min = min or 0
	    max = max or 1
	    return math.random(min, max)
	end
	function Utils.showToast(message, dontAddScriptName)
	    local msg = tostring(message)
	    if not dontAddScriptName then
	        msg = "[" .. SCRIPT_NAME .. "] " .. msg
	    end
	    util.toast(tostring(msg))
	end
	function Utils.getCommandName(commandName)
	    commandName = commandName or ""
	    return CONSTANTS.SCRIPT.COMMAND_PREFIX .. commandName
	end	function Utils.logToFile(message)
	    local msg = tostring(message)
	    util.log(SCRIPT_NAME .. ": " .. msg, 8)
	end	function Utils.getTime(addTimeInMs)
	    local addTimeInMs = addTimeInMs or 0
	    return os.millis() + addTimeInMs
	end
	function Utils.getGroundZPosition(position)
	    local tick = 0
	    local success, groundZ = util.get_ground_z(position.x, position.y)
	    while not success and tick < 10 do
	        util.yield_once()
	        success, groundZ = util.get_ground_z(position.x, position.y)
	        tick = tick + 1
	    end
	    if success then
	        position.z = groundZ
	    end
	    return position
	end
	function Utils.getBlipCoords(blip)
	    local pos = HUD.GET_BLIP_COORDS(blip)
	    pos = Utils.getGroundZPosition(pos)
	    return pos
	end
	function Utils.emptyFunction()
	end
	function Utils.requestWeaponAsset(hash)
	    local weaponHash = util.joaat(hash)
	    WEAPON.REQUEST_WEAPON_ASSET(weaponHash, 31, 0)
	    while not WEAPON.HAS_WEAPON_ASSET_LOADED(weaponHash) do
	        util.yield_once()
	    end
	    return weaponHash
	end
	function Utils.convertColorToGame(color)
	    return {
	        r = math.floor(color.r * 255),
	        g = math.floor(color.g * 255),
	        b = math.floor(color.b * 255),
	        a = math.floor(color.a * 255)
	    }
	end	local minimum = memory.alloc()
	local maximum = memory.alloc()
	function Utils.getDimensions(entity)
	    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
	    local minimum_vec = v3.new(minimum)
	    local maximum_vec = v3.new(maximum)
	    local dimensions = {
	        x = maximum_vec.y - minimum_vec.y,
	        y = maximum_vec.x - minimum_vec.x,
	        z = maximum_vec.z - minimum_vec.z
	    }
	    return dimensions
	end
	local upVector_pointer = memory.alloc()
	local rightVector_pointer = memory.alloc()
	local forwardVector_pointer = memory.alloc()
	local position_pointer = memory.alloc()
	function Utils.drawBox(entity, color)
	    ENTITY.GET_ENTITY_MATRIX(entity, rightVector_pointer, forwardVector_pointer, upVector_pointer, position_pointer);
	    local forward_vector = v3.new(forwardVector_pointer)
	    local right_vector = v3.new(rightVector_pointer)
	    local up_vector = v3.new(upVector_pointer)
	    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
	    local minimum_vec = v3.new(minimum)
	    local maximum_vec = v3.new(maximum)
	    local dimensions = {
	        x = maximum_vec.y - minimum_vec.y,
	        y = maximum_vec.x - minimum_vec.x,
	        z = maximum_vec.z - minimum_vec.z
	    }
	    local top_right = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, maximum_vec.x, maximum_vec.y, maximum_vec.z)
	    local top_right_back = {
	        x = forward_vector.x * -dimensions.y + top_right.x,
	        y = forward_vector.y * -dimensions.y + top_right.y,
	        z = forward_vector.z * -dimensions.y + top_right.z
	    }
	    local bottom_right_back = {
	        x = up_vector.x * -dimensions.z + top_right_back.x,
	        y = up_vector.y * -dimensions.z + top_right_back.y,
	        z = up_vector.z * -dimensions.z + top_right_back.z
	    }
	    local bottom_left_back = {
	        x = -right_vector.x * dimensions.x + bottom_right_back.x,
	        y = -right_vector.y * dimensions.x + bottom_right_back.y,
	        z = -right_vector.z * dimensions.x + bottom_right_back.z
	    }
	    local top_left = {
	        x = -right_vector.x * dimensions.x + top_right.x,
	        y = -right_vector.y * dimensions.x + top_right.y,
	        z = -right_vector.z * dimensions.x + top_right.z
	    }
	    local bottom_right = {
	        x = -up_vector.x * dimensions.z + top_right.x,
	        y = -up_vector.y * dimensions.z + top_right.y,
	        z = -up_vector.z * dimensions.z + top_right.z
	    }
	    local bottom_left = {
	        x = forward_vector.x * dimensions.y + bottom_left_back.x,
	        y = forward_vector.y * dimensions.y + bottom_left_back.y,
	        z = forward_vector.z * dimensions.y + bottom_left_back.z
	    }
	    local top_left_back = {
	        x = up_vector.x * dimensions.z + bottom_left_back.x,
	        y = up_vector.y * dimensions.z + bottom_left_back.y,
	        z = up_vector.z * dimensions.z + bottom_left_back.z
	    }
	    GRAPHICS.DRAW_LINE(top_right.x, top_right.y, top_right.z, top_right_back.x, top_right_back.y, top_right_back.z, color.r, color.g, color.b, color.a)
	    GRAPHICS.DRAW_LINE(top_right.x, top_right.y, top_right.z, top_left.x, top_left.y, top_left.z, color.r, color.g, color.b, color.a)
	    GRAPHICS.DRAW_LINE(top_right.x, top_right.y, top_right.z, bottom_right.x, bottom_right.y, bottom_right.z, color.r, color.g, color.b, color.a)
	    GRAPHICS.DRAW_LINE(bottom_left_back.x, bottom_left_back.y, bottom_left_back.z, bottom_right_back.x, bottom_right_back.y, bottom_right_back.z, color.r, color.g, color.b, color.a)
	    GRAPHICS.DRAW_LINE(bottom_left_back.x, bottom_left_back.y, bottom_left_back.z, bottom_left.x, bottom_left.y, bottom_left.z, color.r, color.g, color.b, color.a)
	    GRAPHICS.DRAW_LINE(bottom_left_back.x, bottom_left_back.y, bottom_left_back.z, top_left_back.x, top_left_back.y, top_left_back.z, color.r, color.g, color.b, color.a)
	    GRAPHICS.DRAW_LINE(top_left_back.x, top_left_back.y, top_left_back.z, top_right_back.x, top_right_back.y, top_right_back.z, color.r, color.g, color.b, color.a)
	    GRAPHICS.DRAW_LINE(top_left_back.x, top_left_back.y, top_left_back.z, top_left.x, top_left.y, top_left.z, color.r, color.g, color.b, color.a)
	    GRAPHICS.DRAW_LINE(bottom_right_back.x, bottom_right_back.y, bottom_right_back.z, top_right_back.x, top_right_back.y, top_right_back.z, color.r, color.g, color.b, color.a)
	    GRAPHICS.DRAW_LINE(bottom_left.x, bottom_left.y, bottom_left.z, top_left.x, top_left.y, top_left.z, color.r, color.g, color.b, color.a)
	    GRAPHICS.DRAW_LINE(bottom_left.x, bottom_left.y, bottom_left.z, bottom_right.x, bottom_right.y, bottom_right.z, color.r, color.g, color.b, color.a)
	    GRAPHICS.DRAW_LINE(bottom_right_back.x, bottom_right_back.y, bottom_right_back.z, bottom_right.x, bottom_right.y, bottom_right.z, color.r, color.g, color.b, color.a)
	end	function Utils.getRandomPlayer()
	    if not util.is_session_started() then
	        Utils.showToast(UND_translations.general.onlyOnline)
	        return -1
	    end
	    local allPlayers = players.list(false)
	    if #allPlayers == 0 then
	        Utils.showToast(UND_translations.general.noPlayer)
	        return -1
	    end
	    local randPid = allPlayers[Utils.rand(1, #allPlayers)]
	    return randPid
	end	function Utils.rotateToEntity(entity, coords)
	    local newCoords = coords or ENTITY.GET_ENTITY_COORDS(entity)
	    local rot = ENTITY.GET_ENTITY_ROTATION(entity, 2)
	    local myPed = Player.getPlayerPed()
	    local myVeh = Ped.getVehicle(myPed)
	    local rotDir = rot:toDir()
	    local multiplier = 8
	    if not myVeh then
	        multiplier = 2
	    end
	    v3.mul(rotDir, -multiplier)
	    v3.add(newCoords, rotDir)
	    WIRI_CAM.FORCE_CAMERA_RELATIVE_HEADING_AND_PITCH(0, 0, 0)
	    ENTITY.SET_ENTITY_ROTATION(myVeh or myPed, rot.x, rot.y, rot.z, 2, true)
	    return newCoords
	end	function Utils.getTableIdx(tbl, value)
	    if #tbl > 0 then
	        for i = 1, #tbl do
	            if tbl[i] == value then
	                return i
	            end
	        end
	    end
	    return nil
	end	function Utils.deleteEntity(entity)
	    entities.delete_by_handle(entity)
	end
	function Utils.getSpeed(entity, onlyValue)
	    local speed = ENTITY.GET_ENTITY_SPEED(entity)
	    local localSpeed
	    if UND_settings.units == UND_translations.general.kmh then
	        localSpeed = math.floor(speed * 3.6)
	    else
	        localSpeed = math.floor(speed * 2.236936)
	    end
	    if onlyValue then
	        return localSpeed
	    end
	    return localSpeed .. " " .. UND_settings.units
	end	function Utils.isTableEmpty(table)
	    local count = 0
	    for x in table do
	        count = count + 1
	    end
	    return count == 0
	end	function Utils.requestPtfxAsset(asset)
	    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
	    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
	        util.yield()
	    end
	end
	return Utils
end
package.loaded["src.lib.utils"] = nil
package.preload["__luapack_entry__"] = function(...)
	util.keep_running()	UND_translations = require "src.lib.translations"
	CONSTANTS = require "src.lib.constants"
	UND_settings = {
	    randomUpgrades = {
	        performance = true,
	        bodyParts = true,
	        paint = true,
	        finishType = true,
	        livery = true,
	        lights = true,
	        tyreSmoke = true,
	        windowTint = true,
	        horn = true,
	        plateType = true,
	        wheels = true,
	        neons = false,
	        weaponRoof = true,
	        grilleCounter = true,
	        maxPerformance = false
	    },
	    damageSettings = {
	        windows = true,
	        doors = true,
	        tyres = true,
	        popOnce = false,
	        smokeEngine = true
	    },
	    units = "km/h",
	    hornBoostSpeed = 10,
	    hornJumpForce = 10,
	    flySpeed = 100,
	    makeWantedLevel = 5,
	    bountyAmount = 10000,
	    clonedPedTask = UND_translations.general.walk,
	    cageType = UND_translations.general.fence,
	    shootType = UND_translations.general.owned,
	    explodeType = UND_translations.general.anonymous,
	    showVehModelName = true,
	    emptyFrom = UND_translations.general.all,
	    ramType = UND_translations.general.visible
	}
	UND_gameMenuOpen = false	UND_instantRespawnEnabled = false	UND_followEnabledFor = -1
	UND_flyVehicleEnabledFor = -1	UND_aimModeActive = true
	UND_aimModeActiveAsAimButton = false
	UND_currentlyMovedObject = 0
	UND_aimLockEnabled = true
	UND_aimLockTime = 5
	UND_markedTargets = {}
	UND_aimLockEntity = nil
	UND_aimLockEndTime = nil
	if filesystem.exists(filesystem.scripts_dir() .. "lib/undefined/menus/self/private.lua") then
	    UND_privateMode = true
	end	Utils = require "src.lib.utils"
	Network = require "src.lib.network"
	Raycast = require "src.lib.raycast"
	Player = require "src.lib.player"
	Ped = require "src.lib.ped"
	Vehicle = require "src.lib.vehicle"
	Entity = require "src.lib.entity"	require "src.lib.updater"
	require "src.lib.menus.main"
end
package.loaded["__luapack_entry__"] = nil
package.preload["src.lib.menus.aim.vehicle"] = function(...)
	local _Raycast = CONSTANTS.RAYCAST
	local function drive()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if not aimResult then
	        return
	    end
	    Vehicle.drive(aimResult.vehicle)
	end
	local function enter()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if not aimResult then
	        return
	    end
	    Vehicle.enter(aimResult.vehicle)
	end
	local function damage()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.damage(aimResult.vehicle)
	    end
	end
	local function explode()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.explode(aimResult.vehicle)
	    end
	end
	local function randomExplode()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.explode(aimResult.vehicle, true)
	    end
	end
	local function airstrike()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.airstrike(aimResult.vehicle)
	    end
	end
	local function glitch()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.glitch(aimResult.vehicle)
	    end
	end
	local function burn()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.burn(aimResult.vehicle)
	    end
	end
	local function killEngine()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.killEngine(aimResult.vehicle)
	    end
	end
	local function delete()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Utils.deleteEntity(aimResult.vehicle)
	    end
	end
	local function clone()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.clone(aimResult.vehicle)
	    end
	end
	local function repair()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.repairVehicle(aimResult.vehicle)
	    end
	end	local function setGod(enabled)
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.toggleVehicleGodMode(aimResult.vehicle, enabled)
	    end
	end
	local function turnOffEngine()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.turnOffEngine(aimResult.entity)
	    end
	end
	local function randomUpgrade()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.randomUpgradeForVehicle(aimResult.vehicle)
	    end
	end
	local function stop()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.stop(aimResult.vehicle)
	    end
	end
	local function spin()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.spin(aimResult.entity)
	    end
	end
	local function launch(direction)
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.launch(aimResult.entity, direction)
	    end
	end
	local function empty()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.empty(aimResult.vehicle)
	    end
	end	local function flip(horizontal)
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.flip(aimResult.vehicle, horizontal)
	    end
	end
	local function emp()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.emp(aimResult.vehicle)
	    end
	end
	local function slick()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.slick(aimResult.vehicle)
	    end
	end
	local function bump()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.bump(aimResult.vehicle)
	    end
	end
	local function randomLaunch()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.randomLaunch(aimResult.vehicle)
	    end
	end
	local function toggleInvisible()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Vehicle.toggleInvisible(aimResult.vehicle)
	    end
	end
	local function openStand()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if not aimResult then
	        return
	    elseif not aimResult.player then
	        Utils.showToast(UND_translations.general.onlyPlayers)
	        return
	    end
	    menu.trigger_commands("p" .. Player.getPlayerName(aimResult.player, true))
	end
	local movedVehicle = 0
	local function move()
	    if UND_currentlyMovedObject == 1 then
	        return
	    end
	    if movedVehicle > 0 then
	        local aimResult = Raycast.getPlayerAimData()
	        if not aimResult then
	            return
	        elseif not Network.requestControl(movedVehicle) then
	            movedVehicle = 0
	            return
	        end
	        local coords = aimResult.coords
	        ENTITY.SET_ENTITY_COORDS(movedVehicle, coords.x, coords.y, coords.z, false, false, false)
	        movedVehicle = 0
	        util.yield()
	        UND_currentlyMovedObject = 0
	        return
	    end
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if not aimResult then
	        return
	    end
	    movedVehicle = aimResult.entity
	    UND_currentlyMovedObject = 2
	    util.create_tick_handler(function()
	        if movedVehicle == 0 then
	            return false
	        end
	        directx.draw_text(0.5, 0.8, UND_translations.aim.moveTo, 5, 0.6, {
	            r = 1,
	            g = 1,
	            b = 1,
	            a = 1
	        }, false)
	    end)
	end
	local function tpToMe()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if not aimResult then
	        return
	    end
	    Vehicle.tpToPlayer(aimResult.entity)
	end
	local function tpToVehicle()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if not aimResult then
	        return
	    end
	    Vehicle.tpToVehicle(aimResult.entity)
	end
	local function freeze()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if not aimResult then
	        return
	    end
	    Vehicle.freeze(aimResult.vehicle, true)
	end
	local function rotate()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if not aimResult then
	        return
	    end
	    Vehicle.rotate(aimResult.vehicle)
	end
	local function unfreeze()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if not aimResult then
	        return
	    end
	    Vehicle.freeze(aimResult.vehicle, false)
	end
	local function atomize()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if not aimResult then
	        return
	    end
	    Vehicle.atomize(aimResult.entity)
	end
	local function firework()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if not aimResult then
	        return
	    end
	    Vehicle.fireworks(aimResult.entity)
	end
	local function npcHijack()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if not aimResult then
	        return
	    end
	    Vehicle.npcHijack(aimResult.entity)
	end
	local function ram()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if aimResult then
	        Entity.ram(aimResult.entity)
	    end
	end
	local function toggleMark()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if not aimResult then
	        return
	    end
	    local idx = Utils.getTableIdx(UND_markedTargets, aimResult.entity)
	    if idx then
	        table.remove(UND_markedTargets, idx)
	    else
	        table.insert(UND_markedTargets, aimResult.entity)
	    end
	end
	local function selectDriver()
	    local aimResult = Raycast.getPlayerAimData(_Raycast.TraceFlag.vehicles)
	    if not aimResult then
	        return
	    end
	    local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(aimResult.entity, -1)
	    if driver == 0 then
	        Utils.showToast(UND_translations.aim.noDriver)
	        return
	    end
	    local player = Network.getPlayerFromPed(driver)
	    if player == -1 then
	        player = nil
	    end
	    UND_aimLockEndTime = Utils.getTime(UND_aimLockTime * 1000)
	    UND_aimLockEntity = {
	        entity = driver,
	        isPed = true,
	        player = player
	    }
	end	local function setupVehicleAimActions(aimVehicleSubmenu)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.drive, {}, "", drive)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.enter, {}, UND_translations.vehicle.enterD, enter)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.damage, {}, "", damage)
	    menu.action(aimVehicleSubmenu, UND_translations.general.explode, {}, "", explode)
	    menu.action(aimVehicleSubmenu, UND_translations.general.randomExplosion, {}, "", randomExplode)
	    menu.action(aimVehicleSubmenu, UND_translations.general.airstrike, {}, "", airstrike)
	    menu.action(aimVehicleSubmenu, UND_translations.general.burn, {}, "", burn)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.killEngine, {}, "", killEngine)
	    menu.action(aimVehicleSubmenu, UND_translations.general.delete, {}, "", delete)
	    menu.action(aimVehicleSubmenu, UND_translations.general.clone, {}, "", clone)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.repair, {}, "", repair)
	    menu.action(aimVehicleSubmenu, UND_translations.general.setGod, {}, "", function()
	        setGod(true)
	    end)
	    menu.action(aimVehicleSubmenu, UND_translations.general.removeGod, {}, "", function()
	        setGod(false)
	    end)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.engineOff, {}, "", turnOffEngine)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.upgrade, {}, UND_translations.vehicle.upgradeD, randomUpgrade)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.stop, {}, "", stop)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.spin, {}, "", spin)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.launchUp, {}, "", function()
	        launch("up")
	    end)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.launchDown, {}, "", function()
	        launch("down")
	    end)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.launchForward, {}, "", function()
	        launch("forward")
	    end)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.launchBack, {}, "", function()
	        launch("back")
	    end)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.empty, {}, UND_translations.vehicle.emptyD, empty)
	    menu.action(aimVehicleSubmenu, UND_translations.general.openInStand, {}, "", openStand)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.vFlip, {}, "", function()
	        flip(false)
	    end)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.hFlip, {}, "", function()
	        flip(true)
	    end)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.EMP, {}, "", emp)
	    menu.action(aimVehicleSubmenu, UND_translations.aim.move, {}, UND_translations.aim.moveVehD, move)
	    menu.action(aimVehicleSubmenu, UND_translations.general.tpToMe, {}, "", tpToMe)
	    menu.action(aimVehicleSubmenu, UND_translations.general.tpToIt, {}, "", tpToVehicle)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.slick, {}, UND_translations.vehicle.slickD, slick)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.bump, {}, "", bump)
	    menu.action(aimVehicleSubmenu, UND_translations.general.ram, {}, "", ram)
	    menu.action(aimVehicleSubmenu, UND_translations.general.freeze, {}, "", freeze)
	    menu.action(aimVehicleSubmenu, UND_translations.general.unfreeze, {}, "", unfreeze)
	    menu.action(aimVehicleSubmenu, UND_translations.general.rotate, {}, "", rotate)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.randomForce, {}, UND_translations.vehicle.randomForceD, randomLaunch)
	    menu.action(aimVehicleSubmenu, UND_translations.vehicle.glitch, {}, "", glitch)
	    menu.action(aimVehicleSubmenu, UND_translations.general.toggleInv, {}, "", toggleInvisible)
	    menu.action(aimVehicleSubmenu, UND_translations.general.toggleMark, {}, UND_translations.general.toggleMarkD, toggleMark)
	    menu.action(aimVehicleSubmenu, UND_translations.general.atomize, {}, "", atomize)
	    menu.action(aimVehicleSubmenu, UND_translations.general.fireworks, {}, "", firework)
	    menu.action(aimVehicleSubmenu, UND_translations.general.npcHijack, {}, "", npcHijack)
	    menu.action(aimVehicleSubmenu, UND_translations.aim.selectDriver, {}, UND_translations.aim.selectDriverD, selectDriver)
	end
	return setupVehicleAimActions
end
package.loaded["src.lib.menus.aim.vehicle"] = nil
package.preload["src.lib.menus.aim.beam"] = function(...)
	local aimBeamWeapon = CONSTANTS.GAME.BULLET_TYPES[1]
	local aimBeamDelay = 200
	local function aimBeam()
	    local weaponHash = Utils.requestWeaponAsset(aimBeamWeapon.hash)
	    local playerCoords = Player.getPlayerPosition()
	    local _, shootCoords = Raycast.getOffsetFromCam(1000)
	    local zOffset = 1
	    local myPed = Player.getPlayerPed()
	    local vehicle = Ped.getVehicle(myPed)
	    local entityToIgnore = myPed
	    if vehicle then
	        zOffset = Utils.getDimensions(vehicle).z
	        entityToIgnore = vehicle
	        if ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(vehicle) > 10 and shootCoords.z < playerCoords.z + zOffset then
	            zOffset = zOffset * -1
	        end
	    end
	    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(playerCoords.x, playerCoords.y, playerCoords.z + zOffset, shootCoords.x, shootCoords.y, shootCoords.z, 200, false,
	        weaponHash, 0, true, false, 2000, entityToIgnore)
	    util.yield(aimBeamDelay)
	    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(weaponHash)
	end	local function setupAimBeam(aimMenu)
	    menu.divider(aimMenu, UND_translations.aim.aimBeam)
	    local aimBeamToggleLoop = menu.toggle_loop(aimMenu, UND_translations.aim.useBeam, {}, UND_translations.aim.useBeamD, aimBeam)
	    menu.set_value(aimBeamToggleLoop, false)
	    local aimBeamSelect = menu.list_select(aimMenu, UND_translations.general.bulletType, {Utils.getCommandName("beamtype")}, "", CONSTANTS.GAME.BULLET_TYPES, 1,
	        function(idx)
	            aimBeamWeapon = CONSTANTS.GAME.BULLET_TYPES[idx]
	        end)
	    aimBeamWeapon = CONSTANTS.GAME.BULLET_TYPES[menu.get_value(aimBeamSelect)]
	    local delaySlider = menu.slider(aimMenu, UND_translations.general.delay, {Utils.getCommandName("beamdelay")}, "", 50, 500, aimBeamDelay, 50, function(val)
	        aimBeamDelay = val
	    end)
	    aimBeamDelay = menu.get_value(delaySlider)
	end
	return setupAimBeam
end
package.loaded["src.lib.menus.aim.beam"] = nil
do
	local _result = package.preload["__luapack_entry__"](...)
	return _result
end
--GNAB