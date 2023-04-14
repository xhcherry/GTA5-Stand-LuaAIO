--[[
--------------------------------
THIS FILE IS PART OF WIRISCRIPT
         Nowiry#2663
--------------------------------
]]

---@diagnostic disable: exp-in-action, unknown-symbol, break-outside, undefined-global

require "lib.GTSCRIPTS.O"

--------------------------
-- BITFIELD
--------------------------

---@class Bitwise
---@field bits integer
local Bitfield = {}
Bitfield.__index = Bitfield

function get_hud_colour(hudColour)
	local r = memory.alloc(1)
	local g = memory.alloc(1)
	local b = memory.alloc(1)
	local a = memory.alloc(1)
	HUD.GET_HUD_COLOUR(hudColour, r, g, b, a)
	return {r = memory.read_int(r), g = memory.read_int(g), b = memory.read_int(b), a = memory.read_int(a)}
end

function Bitfield.new()
	return setmetatable({bits = 0}, Bitfield)
end

---@param place integer
---@return boolean
function Bitfield:IsBitSet(place)
	return self.bits & (1 << place) ~= 0
end

---@param place integer
function Bitfield:SetBit(place)
	self.bits = self.bits | (1 << place)
end

---@param place integer
function Bitfield:ClearBit(place)
	self.bits = self.bits & ~(1 << place)
end

---@param place integer
---@param on boolean
function Bitfield:ToggleBit(place, on)
	if on then self:SetBit(place) else self:ClearBit(place) end
end

function Bitfield:reset()
	self.bits = 0
end

Bitfield.__tostring = function(self)
    local tbl = {}
	local num = self.bits
    for b = 32, 1, -1 do
        tbl[b] = math.fmod(num, 2)
        num = math.floor((num - tbl[b]) / 2)
    end
    return table.concat(tbl)
end

--------------------------

local self = {}
local version = 29
local State <const> =
{
	GettingNearbyEnts = 0,
	SettingTargets = 1,
	Reseted = 2
}
local state = State.Reseted
local targetEnts = {-1, -1, -1, -1, -1, -1}
---Stores nearby targetable entities
---@type integer[]
local nearbyEntities = {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1}
local numTargets = 0
local maxTargets = 6
local lastShot <const> = newTimer()
local rechargeTimer <const> = newTimer()
local entCount = 0
local shotCount = 0
local numShotTargets = 0 -- the number of targets we've shot
local chargeLevel = 100.0
local vehicleWeaponSide = 0
local myVehicle = 0
local weapon <const> = util.joaat("VEHICLE_WEAPON_SPACE_ROCKET")
local lockOnBits <const> = Bitfield.new()
local bits <const> = Bitfield.new()
local whiteList <const> = Bitfield.new()
local trans = {
	DisablingPassive = translate("Misc", "Disabling passive mode")
}
local NULL <const> = 0
---@type Timer[]
local homingTimers <const> = {}
---@type Sound[]
local amberHomingSounds <const> = {}
---@type Sound[]
local redHomingSounds <const> = {}
---@type Timer[]
local lostTargetTimers <const> = {}

for i = 1, 6 do
	homingTimers[i] = newTimer()
	lostTargetTimers[i] = newTimer()
	amberHomingSounds[i] = Sound.new("VULKAN_LOCK_ON_AMBER", NULL)
	redHomingSounds[i] = Sound.new("VULKAN_LOCK_ON_RED", NULL)
end

local Bit_IsTargetShooting <const> = 0
local Bit_IsRecharging <const> = 1
local Bit_IsCamPointingInFront <const> = 2

local Bit_IgnoreFriends <const> = 0
local Bit_IgnoreOrgMembers <const> = 1
local Bit_IgnoreCrewMembers <const> = 2


---@param position v3
---@param scale number
---@param colour Colour
local DrawLockonSprite = function (position, scale, colour)
	if WIRI_GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED("mpsubmarine_periscope") then
		local txdSizeX = scale * 0.042
		local txdSizeY = scale * 0.042 * WIRI.GET_ASPECT_RATIO(false)
		WIRI_GRAPHICS.SET_DRAW_ORIGIN(position.x, position.y, position.z, 0)
		WIRI_GRAPHICS.DRAW_SPRITE(
			"mpsubmarine_periscope", "target_default", 0.0, 0.0, txdSizeX, txdSizeY, 0.0, colour.r, colour.g, colour.b, colour.a, true, 0)
		WIRI_GRAPHICS.CLEAR_DRAW_ORIGIN()
	end
end


---@param vehicle Vehicle
---@return boolean
local IsAnyPoliceVehicle = function(vehicle)
	local modelHash = ENTITY.GET_ENTITY_MODEL(vehicle)
	switch int_to_uint(modelHash)do
		case 0x79FBB0C5:
		case 0x9F05F101:
		case 0x71FA16EA:
		case 0x8A63C7B9:
		case 0x1517D4D9:
		case 0xFDEFAEC3:
		case 0x1B38E955:
		case 0x95F4C618:
		case 0xA46462F7:
		case 0x9BAA707C:
		case 0x72935408:
		case 0xB822A1AA:
		case 0xE2E7D4AB:
		case 0x9DC66994:
			return true
	end
	return false
end


---@param entity Entity
---@return boolean
local IsEntityInSafeScreenPos = function (entity)
	local pScreenX = memory.alloc(4)
	local pScreenY = memory.alloc(4)
	local pos = ENTITY.GET_ENTITY_COORDS(entity, true)
	if not GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(pos.x, pos.y, pos.z, pScreenX, pScreenY) then
		return false
	end
	local screenX = memory.read_float(pScreenX)
	local screenY = memory.read_float(pScreenY)
	if screenX < 0.1 or screenX > 0.9 or screenY < 0.1 or screenY > 0.9 then
		return false
	end
	return true
end


---@param player Player
---@return integer
local GetPlayerOrgBoss = function (player)
	if player ~= -1 then
		local address = memory.script_global(1894573 + (player * 608 + 1) + 10)
		if address ~= 0 then return memory.read_int(address) end
	end
	return -1
end


---@param player Player
---@param target Player
---@return boolean
local ArePlayersInTheSameOrg = function (player, target)
	local boss = GetPlayerOrgBoss(player)
	return boss ~= -1 and boss == GetPlayerOrgBoss(target)
end


---@param player Player
---@return integer
local GetHandleFromPlayer = function (player)
	local handle = memory.alloc(104)
	NETWORK.NETWORK_HANDLE_FROM_PLAYER(player, handle, 13)
	return handle
end


---@param player Player
---@param target Player
---@return boolean
local ArePlayersInTheSameCrew = function (player, target)
	if NETWORK.NETWORK_CLAN_SERVICE_IS_VALID() then
		local targetHandle = GetHandleFromPlayer(target)
		local handle = GetHandleFromPlayer(player)

		if NETWORK.NETWORK_CLAN_PLAYER_IS_ACTIVE(handle) and NETWORK.NETWORK_CLAN_PLAYER_IS_ACTIVE(targetHandle) then
			local targetClanDesc = memory.alloc(280)
			local clanDesc = memory.alloc(280)

			NETWORK.NETWORK_CLAN_PLAYER_GET_DESC(clanDesc, 35, handle)
			NETWORK.NETWORK_CLAN_PLAYER_GET_DESC(targetClanDesc, 35, targetHandle)
			return memory.read_int(clanDesc + 0x0) == memory.read_int(targetClanDesc + 0x0)
		end
	end
	return false
end


---@param ped Ped
local IsPedAnyTargetablePlayer = function (ped)
	local player = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ped)
	if not is_player_active(player, true, true) then
		return false
	end

	if is_player_in_interior(player) or is_player_passive(player) or
	NETWORK.IS_ENTITY_A_GHOST(ped) then
		return false
	elseif whiteList:IsBitSet(Bit_IgnoreFriends) and is_player_friend(player) then
		return false
	elseif whiteList:IsBitSet(Bit_IgnoreOrgMembers) and
	ArePlayersInTheSameOrg(players.user(), player) then
		return false
	elseif whiteList:IsBitSet(Bit_IgnoreCrewMembers) and
	ArePlayersInTheSameCrew(players.user(), player) then
		return false
	end
	return true
end


---@param vehicle Vehicle
---@return boolean
local DoesVehicleHavePlayerDriver = function(vehicle)
	if VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, -1, false) then
		return false
	end
	local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false)
	if not ENTITY.DOES_ENTITY_EXIST(driver) or not PED.IS_PED_A_PLAYER(driver) or
	not IsPedAnyTargetablePlayer(driver) then
		return false
	end
	return true
end


---@param player Player
---@return integer
local GetPlayerWantedLevel = function (player)
	local netPlayer = GetNetGamePlayer(player)
	if netPlayer == NULL then
		return 0
	end
	local playerInfo = memory.read_long(netPlayer + 0xA0)
	if playerInfo == NULL then
		return 0
	end
	return memory.read_uint(playerInfo + 0x0888)
end


---@param entity Entity
---@return boolean
local IsEntityTargetable = function(entity)
	if not ENTITY.DOES_ENTITY_EXIST(entity) or ENTITY.IS_ENTITY_DEAD(entity, false) then
		return false
	end
	local distance = get_distance_between_entities(myVehicle, entity)
	if distance > 500.0 or distance < 10.0 then
		return false
	end
	if ENTITY.IS_ENTITY_A_PED(entity) and PED.IS_PED_A_PLAYER(entity) and
	players.user_ped() ~= entity and not PED.IS_PED_IN_ANY_VEHICLE(entity, false) and
	IsPedAnyTargetablePlayer(entity) then
		return true
	elseif ENTITY.IS_ENTITY_A_VEHICLE(entity) and entity ~= myVehicle then
		if DoesVehicleHavePlayerDriver(entity) then
			return true
		elseif GetPlayerWantedLevel(players.user()) > 0 and IsAnyPoliceVehicle(entity) then
			return true
		end
	end
	return false
end


local SetNearbyEntities = function()
	local count = 1
	local entities = entities.get_all_vehicles_as_handles()
	for _, player in ipairs(players.list(false)) do
		entities[#entities+1] = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player)
	end
	for _, entity in ipairs(entities) do
		if count == 20 then break end
		if bits:IsBitSet(Bit_IsCamPointingInFront) and IsEntityTargetable(entity) and
		not table.find(targetEnts, entity) and not table.find(nearbyEntities, entity) and
		IsEntityInSafeScreenPos(entity) then
			nearbyEntities[count] = entity
			count = count + 1
		end
	end
	state = State.SettingTargets
end


---@param entity Entity
---@return boolean
local TargetEntitiesInsert = function (entity)
	for i, target in ipairs(targetEnts) do
        if target == -1 or not ENTITY.DOES_ENTITY_EXIST(target) then
            targetEnts[i] = entity
            numTargets = numTargets + 1
			return true
        end
    end
	return false
end


---@return integer
local GetFartherTargetIndex = function()
	local lastDistance = 0.0
	local index = -1
	local myPos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), true)
	for i = 1, maxTargets do
		local pos = ENTITY.GET_ENTITY_COORDS(targetEnts[i], true)
		local distance = myPos:distance(pos)
		if distance > lastDistance then
			index = i
			lastDistance = distance
		end
	end
	return index
end


---@param entity Entity
---@param amplitude number
---@return boolean
local IsCameraPointingInFrontOfEntity = function(entity, amplitude)
	local camDir = CAM.GET_GAMEPLAY_CAM_ROT(0):toDir()
	local fwdVector = ENTITY.GET_ENTITY_FORWARD_VECTOR(entity)
	camDir.z, fwdVector.z = 0.0, 0.0
	local angle = math.acos(fwdVector:dot(camDir) / (#camDir * #fwdVector))
	return math.deg(angle) < amplitude
end


local SetTargetEntities = function()
	if entCount < 0 or entCount > 19 then
        entCount = 0
    end
	local entity = nearbyEntities[entCount + 1]

	if ENTITY.DOES_ENTITY_EXIST(entity) and not ENTITY.IS_ENTITY_DEAD(entity, false) and
	ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(myVehicle, entity, 287) then
		if numTargets < maxTargets then
			if TargetEntitiesInsert(entity) then
				nearbyEntities[entCount + 1] = -1
				entCount = entCount + 1
			end
		else
			local targetId = GetFartherTargetIndex()
			local target = targetEnts[targetId]

			if targetId >= 1 and target then
				local entityPos = ENTITY.GET_ENTITY_COORDS(entity, true)
				local myPos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), true)
				local targetPos = ENTITY.GET_ENTITY_COORDS(target, true)
				local targetDist = targetPos:distance(myPos)
				local entDist = entityPos:distance(myPos)
				if targetDist > entDist then targetEnts[targetId] = entity end
			end

			nearbyEntities[entCount + 1] = -1
			entCount = entCount + 1
		end
	else
		nearbyEntities[entCount + 1] = -1
		entCount = entCount + 1
	end

	if entCount > 19 then
		state = State.GettingNearbyEnts
		entCount = 0
	end
end


local IsAnyHomingSoundActive = function()
	for i = 1, 6 do
		local amberSound = amberHomingSounds[i]
		local redSound = redHomingSounds[i]
		if not amberSound:hasFinished() or not redSound:hasFinished() then
			return true
		end
	end
	return false
end


local IsWebBrowserOpen = function ()
	return read_global.int(75693) ~= 0
end

local IsCameraAppOpen = function ()
	return SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat("appcamera")) > 0
end


---@param entity Entity
---@param count integer
local LockonEntity = function (entity, count)
	local redSound = redHomingSounds[count]
	local bitPlace = count - 1
	local lockOnTimer = homingTimers[count]
	local amberSound = amberHomingSounds[count]

	if not ENTITY.DOES_ENTITY_EXIST(entity) or ENTITY.IS_ENTITY_DEAD(entity, false) or
	not IsEntityInSafeScreenPos(entity) or (IsWebBrowserOpen() or IsCameraAppOpen()) then
		amberSound:stop()
		lockOnBits:ClearBit(bitPlace)
		redSound:stop()
		lockOnBits:ClearBit(bitPlace + 6)
		return
	end

	if ENTITY.IS_ENTITY_A_VEHICLE(entity) and VEHICLE.IS_VEHICLE_DRIVEABLE(entity, false) then
		local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(entity, -1, false)
		if ENTITY.DOES_ENTITY_EXIST(driver) and PED.IS_PED_A_PLAYER(driver) and
		is_player_active(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(driver), true, true) then
			VEHICLE.SET_VEHICLE_HOMING_LOCKEDONTO_STATE(entity, 2)
		end
	end

	if not lockOnBits:IsBitSet(bitPlace) then
		if amberSound:hasFinished() and not IsAnyHomingSoundActive() then
            lockOnBits:SetBit(bitPlace)
			amberSound:play()
			lockOnTimer.reset()
		end
	elseif not lockOnBits:IsBitSet(bitPlace + 6) and
	lockOnTimer.elapsed() >= 1000 then
		amberSound:stop()
		if redSound:hasFinished() then
			lockOnBits:SetBit(bitPlace + 6)
			redSound:play()
			lockOnTimer.reset()
		end
	elseif lockOnBits:IsBitSet(bitPlace + 6) and
	lockOnTimer.elapsed() >= 700 then
		if not redSound:hasFinished() then redSound:stop() end
	end

	local hudColour = HudColour.orange
	if lockOnBits:IsBitSet(bitPlace + 6) then
		hudColour = HudColour.red
	end
	local pos = ENTITY.GET_ENTITY_COORDS(entity, true)
	DrawLockonSprite(pos, 1.0, get_hud_colour(hudColour))
end


local GetCrosshairPosition = function ()
	local vehPos = ENTITY.GET_ENTITY_COORDS(myVehicle, true)
	local vehDir = ENTITY.GET_ENTITY_ROTATION(myVehicle, 2):toDir()
	local frontPos = v3.new(vehDir)
	frontPos:mul(100)
	frontPos:add(vehPos)

	local handle =
	SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
		vehPos.x, vehPos.y, vehPos.z,
		frontPos.x, frontPos.y, frontPos.z, 511,
		myVehicle, 7
	)

	local pHit = memory.alloc(1)
	local endCoords = v3.new()
	local normal = v3.new()
	local pHitEntity = memory.alloc_int()
	SHAPETEST.GET_SHAPE_TEST_RESULT(handle, pHit, endCoords, normal, pHitEntity)
	return memory.read_int(pHit) == 1 and endCoords or frontPos
end


local LockonTargets = function()
    if numTargets == 0 and not (IsWebBrowserOpen() or IsCameraAppOpen()) then
		local pos = GetCrosshairPosition()
		local colour = get_hud_colour(HudColour.white)
		colour.a = 160
        DrawLockonSprite(pos, 1.0, colour)
    end
    for i, target in ipairs(targetEnts) do LockonEntity(target, i) end
end


local UpdateTargetEntities = function ()
	local count = 0
	for i = 1, 6 do
		if ENTITY.DOES_ENTITY_EXIST(targetEnts[i]) then
			local timer = lostTargetTimers[i]
			local entity = targetEnts[i]

			if i > maxTargets then
				targetEnts[i] = -1
				numTargets = numTargets - 1
				timer.disable()

			elseif not IsEntityInSafeScreenPos(entity) or not IsEntityTargetable(entity) or
			not bits:IsBitSet(Bit_IsCamPointingInFront) then
				targetEnts[i] = -1
			  	numTargets = numTargets - 1
			  	timer.disable()

			elseif not ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(myVehicle, entity, 287) then
				if not timer.isEnabled() then
					timer.reset()
				elseif timer.elapsed() > 1000 then
					targetEnts[i] = -1
					numTargets = numTargets - 1
					timer.disable()
				end

			else timer.disable() end
		end

		if ENTITY.DOES_ENTITY_EXIST(targetEnts[i]) then
			count = count + 1
		end
	end

	if count ~= numTargets then
		numTargets = count
	end
end


---@param vehicle Vehicle
---@param damage integer
---@param weaponHash Hash
---@param ownerPed Ped
---@param isAudible boolean
---@param isVisible boolean
---@param speed number
---@param target Ped
---@param position integer #right: 0, left: 1
local ShootFromVehicle = function (vehicle, damage, weaponHash, ownerPed, isAudible, isVisible, speed, target, position)
	local pos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
	local min, max = v3.new(), v3.new()
	MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), min, max)
	local direction = ENTITY.GET_ENTITY_ROTATION(vehicle, 2):toDir()
	local a

	if position == 0 then
		local offset = v3.new(min.x + 0.3, max.y - 0.15, 0.3)
		a = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, offset.x, offset.y, offset.z)
	elseif position == 1 then
		local offset = v3.new(max.x - 0.3, max.y - 0.15, 0.3)
		a = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, offset.x, offset.y, offset.z)
	else
		error("got unexpected position")
	end

	local b = v3.new(direction)
	b:mul(5.0); b:add(a)
	MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY_NEW(
		a.x, a.y, a.z,
		b.x, b.y, b.z,
		damage,
		true,
		weaponHash,
		ownerPed,
		isAudible,
		not isVisible,
		speed,
		vehicle,
		false, false, target, false, 0, 0, 0
	)
	AUDIO.PLAY_SOUND_FROM_COORD(-1, "Fire", pos.x, pos.y, pos.z, "DLC_BTL_Terrobyte_Turret_Sounds", true, 200, true)
end


local ShootMissiles = function()
	local controlId = 68
	if PED.IS_PED_IN_FLYING_VEHICLE(players.user_ped()) then
		controlId = 114
	end
	local target = 0

	if (PAD.IS_DISABLED_CONTROL_PRESSED(2, controlId) or bits:IsBitSet(Bit_IsTargetShooting)) and
	not bits:IsBitSet(Bit_IsRecharging) and lastShot.elapsed() > 300 then
		if shotCount < 0 or shotCount > 5 then
			shotCount = 0
		end

		vehicleWeaponSide = vehicleWeaponSide == 0 and 1 or 0
		local ownerPed = players.user_ped()

		if numTargets > 0 then
			if ENTITY.DOES_ENTITY_EXIST(targetEnts[numShotTargets + 1]) and
			not ENTITY.IS_ENTITY_DEAD(targetEnts[numShotTargets + 1], false) then
				target = targetEnts[numShotTargets + 1]
				bits:SetBit(Bit_IsTargetShooting)
				ShootFromVehicle(myVehicle, 200, weapon, ownerPed, true, true, 1000.0, target, vehicleWeaponSide)
				shotCount = shotCount + 1
				numShotTargets = numShotTargets + 1
				lastShot.reset()
			end

			if numTargets == numShotTargets then
				bits:SetBit(Bit_IsRecharging)
				bits:ClearBit(Bit_IsTargetShooting)
				numShotTargets = 0
                shotCount = 0
				chargeLevel = 0
				rechargeTimer.reset()
			end

		else
			ShootFromVehicle(myVehicle, 200, weapon, ownerPed, true, true, 1000.0, 0, vehicleWeaponSide)
			shotCount = shotCount + 1
			lastShot.reset()
			if shotCount == 6 then
				bits:SetBit(Bit_IsRecharging)
				chargeLevel = 0
				shotCount = 0
				rechargeTimer.reset()
			end
		end
	end
end


local StopHomingSounds = function()
	for i = 1, 6 do
		if not redHomingSounds[i]:hasFinished() then
			redHomingSounds[i]:stop()
		end
		if not amberHomingSounds[i]:hasFinished() then
			amberHomingSounds[i]:stop()
		end
	end
end


local LockonManager = function ()
	if bits:IsBitSet(Bit_IsRecharging) then
		if rechargeTimer.elapsed() < 3000 then
			chargeLevel = 100 * rechargeTimer.elapsed() / 3000
			StopHomingSounds()
			lockOnBits:reset()
			return
		else
			bits:ClearBit(Bit_IsRecharging)
			chargeLevel = 100.0
			shotCount = 0
			numShotTargets = 0
		end
	end

	if not bits:IsBitSet(Bit_IsTargetShooting) and not bits:IsBitSet(Bit_IsRecharging) and
	not (IsWebBrowserOpen() or IsCameraAppOpen()) then
		if state == State.GettingNearbyEnts then
			SetNearbyEntities()
		elseif state == State.SettingTargets then
			SetTargetEntities()
		end
		UpdateTargetEntities()
	end
	LockonTargets()
end


Print = {}

---@param font integer
---@param scale v3
---@param centred boolean
---@param rightJustified boolean
---@param outline boolean
---@param colour? Colour
---@param wrap? v3
Print.setupdraw = function(font, scale, centred, rightJustified, outline, colour, wrap)
    HUD.SET_TEXT_FONT(font)
    HUD.SET_TEXT_SCALE(scale.x, scale.y)
    colour = colour or {r = 255, g = 255, b = 255, a = 255}
    HUD.SET_TEXT_COLOUR(colour.r, colour.g, colour.b, colour.a)
    wrap = wrap or {x = 0.0, y = 1.0}
    HUD.SET_TEXT_WRAP(wrap.x, wrap.y)
    HUD.SET_TEXT_RIGHT_JUSTIFY(rightJustified)
    HUD.SET_TEXT_CENTRE(centred)
    HUD.SET_TEXT_DROPSHADOW(0, 0, 0, 0, 0)
    HUD.SET_TEXT_EDGE(0, 0, 0, 0, 0)
    if outline then HUD.SET_TEXT_OUTLINE() end
end


---@param text string
---@param x number
---@param y number
Print.drawstring = function (text, x, y)
    HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT(text)
	GRAPHICS.BEGIN_TEXT_COMMAND_SCALEFORM_STRING(text)
	GRAPHICS.END_TEXT_COMMAND_SCALEFORM_STRING()
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(x, y, 0)
end


local DrawChargingMeter = function ()
	if not is_phone_open() then
		local maxWidth <const> = 0.119
		local posY <const> = 0.63

		local colour = {r = 0, g = 153, b = 51, a = 255}
		if chargeLevel < 100 then
			colour = {r = 153, g = 0, b = 0, a = 255}
		end
		local width = interpolate(0.0, maxWidth, chargeLevel / 100)
		local height <const> = 0.035
		local rectPosX = 0.85 + width/2
		GRAPHICS.DRAW_RECT(rectPosX, posY, width, height, colour.r, colour.g, colour.b, colour.a, true)

		local textColour = get_hud_colour(HudColour.white)
		Print.setupdraw(4, {x = 0.55, y = 0.55}, true, false, false, textColour)
		local textPosX = 0.85 + maxWidth/2
		local text = (chargeLevel == 100) and "DRONE_READY" or "DRONE_CHARGING"
		Print.drawstring(text, textPosX, posY - 0.019)

		--Caption
		local captionHeight <const> = 0.06
		GRAPHICS.DRAW_RECT(0.85 + maxWidth/2, posY - captionHeight + 0.005, maxWidth, captionHeight, 156, 156, 156, 80, true)
		Print.setupdraw(4, {x = 0.65, y = 0.65}, true, false, false, textColour)
		Print.drawstring("DRONE_MISSILE", textPosX + 0.001, posY - captionHeight - 0.015)
	end
end


local DisableControlActions = function ()
	PAD.DISABLE_CONTROL_ACTION(2, 25, true)
	PAD.DISABLE_CONTROL_ACTION(2, 91, true)
	PAD.DISABLE_CONTROL_ACTION(2, 99, true)
	PAD.DISABLE_CONTROL_ACTION(2, 115, true)
	PAD.DISABLE_CONTROL_ACTION(2, 262, true)
	PAD.DISABLE_CONTROL_ACTION(2, 68, true)
	PAD.DISABLE_CONTROL_ACTION(2, 69, true)
	PAD.DISABLE_CONTROL_ACTION(2, 70, true)
	PAD.DISABLE_CONTROL_ACTION(2, 114, true)
	PAD.DISABLE_CONTROL_ACTION(2, 331, true)
end


self.reset = function()
	set_streamed_texture_dict_as_no_longer_needed("mpsubmarine_periscope")
	lockOnBits:reset()
	bits:reset()
	targetEnts = {-1, -1, -1, -1, -1, -1}
	entCount = 0
	numTargets = 0
	shotCount = 0
	numShotTargets = 0
	chargeLevel = 100.0
	myVehicle = 0
	StopHomingSounds()
	nearbyEntities = {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1}
	for i = 1, 6 do lostTargetTimers[i].disable() end
	state = State.Reseted
end


---@param ignore boolean
self.SetIgnoreFriends = function(ignore)
	whiteList:ToggleBit(Bit_IgnoreFriends, ignore)
end

---@param ignore boolean
self.SetIgnoreOrgMembers = function (ignore)
	whiteList:ToggleBit(Bit_IgnoreOrgMembers, ignore)
end

---@param ignore boolean
self.SetIgnoreCrewMembers = function (ignore)
	whiteList:ToggleBit(Bit_IgnoreCrewMembers, ignore)
end

---@param value integer
self.SetMaxTargets = function (value)
	maxTargets = value
end

self.getVersion = function ()
	return version
end


self.mainLoop = function ()
	if is_player_active(players.user(), true, true) and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
		local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
		if ENTITY.DOES_ENTITY_EXIST(vehicle) and not ENTITY.IS_ENTITY_DEAD(vehicle, false) and
		VEHICLE.IS_VEHICLE_DRIVEABLE(vehicle, false) and
		VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false) == players.user_ped() then

			if not is_player_passive(players.user()) then
				if state == State.Reseted then
					request_streamed_texture_dict("mpsubmarine_periscope")
					--This prevents not being able to shoot
					WEAPON.GIVE_DELAYED_WEAPON_TO_PED(players.user_ped(), weapon, -1, false)
					state = State.GettingNearbyEnts
				end
				myVehicle = vehicle
				if IsCameraPointingInFrontOfEntity(vehicle, 40.0) then
					bits:SetBit(Bit_IsCamPointingInFront)
				else
					bits:ClearBit(Bit_IsCamPointingInFront)
				end

				LockonManager()
				if not (IsWebBrowserOpen() or IsCameraAppOpen()) then
					ShootMissiles()
					DrawChargingMeter()
				end
				DisableControlActions()

			elseif not is_player_in_any_rc_vehicle(players.user()) then
				if state ~= State.Reseted then
					self.reset()
				end
				local timerStart = memory.script_global(2793044 + 4463)
				local timerState = memory.script_global(2793044 + 4463 + 1)
				if timerStart ~= NULL and timerState ~= NULL and
				memory.read_int(timerState) == 0 then
					notification:normal(trans.DisablingPassive)
					memory.write_int(timerStart, NETWORK.GET_NETWORK_TIME())
					memory.write_int(timerState, 1)
				end
			end
		elseif state ~= State.Reseted then
			self.reset()
		end
	elseif state ~= State.Reseted then
		self.reset()
	end
end

return self
