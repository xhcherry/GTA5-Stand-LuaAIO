--[[ local self = {}
self.version = 26 ]]

funConfig = {
	controls = {
		vehicleweapons = 86,
		airstrikeaircraft = 86
	},
	general = {
		standnotifications = false,
		showscripthost = false
	},
	ufo = {
		disableboxes = false, 	
		targetplayer = false 
	},
	handlingAutoload = {}
}


-----------------------
-- FILE
--------------------------
--[[ local parseJson = json.parse
json.parse = function (filePath, withoutNull)
	local file <close> = assert(io.open(filePath, "r"), filePath .. " does not exist")
	local content = file:read("a")
	local fileName = string.match(filePath, '^.+\\(.+)')
	if #content == 0 then
		return false,  fileName .. " is empty"
	end
	return pcall(parseJson, content, withoutNull)
end ]]
function fileread(filepath, method, rtype)
    if filesystem.exists(filepath) then
        local file = io.open(filepath, method)
        local data = file:read(rtype)--'*all'从当前位置读取整个文件
        file:close()
        return data
    end
end
--------------------------
-- EFFECT
--------------------------

---@class Effect
Effect = {asset = "", name = "", scale = 1.0}
Effect.__index = Effect

---@param asset string
---@param name string
---@param scale? number
---@return Effect
function Effect.new(asset, name, scale)
	local inst = setmetatable({}, Effect)
	inst.name = name
	inst.asset = asset
	inst.scale = scale
	return inst
end

--------------------------
-- SOUND
--------------------------

---@class Sound
Sound = {Id = -1, name = "", reference = ""}
Sound.__index = Sound

function Sound.new(name, reference)
	local inst = setmetatable({}, Sound)
	inst.name = name
	inst.reference = reference
	return inst
end

function Sound:play()
	if self.Id == -1 then
        self.Id = AUDIO.GET_SOUND_ID()
        AUDIO.PLAY_SOUND_FRONTEND(self.Id, self.name, self.reference, true)
    end
end

function Sound:stop()
	if self.Id ~= -1 then
        AUDIO.STOP_SOUND(self.Id)
        AUDIO.RELEASE_SOUND_ID(self.Id)
        self.Id = -1
    end
end

function Sound:hasFinished()
	return AUDIO.HAS_SOUND_FINISHED(self.Id)
end

function Sound:playFromEntity(entity)
	if self.Id == -1 then
		self.Id = AUDIO.GET_SOUND_ID()
		AUDIO.PLAY_SOUND_FROM_ENTITY(self.Id, self.name, entity, self.reference, true, 0)
	end
end

--------------------------
-- COLOUR
--------------------------

---@class Colour
---@field r number | integer
---@field g number | integer
---@field b number | integer
---@field a number | integer

function new_colour(r, g, b, a)
	return {r = r, g = g, b = b, a = a}
end


---@return Colour
function get_random_colour()
	local colour = {a = 255}
	colour.r = math.random(0,255)
	colour.g = math.random(0,255)
	colour.b = math.random(0,255)
	return colour
end


---@param hudColour HudColour
---@return {r: integer, g: integer, b: integer, a: integer}
function get_hud_colour(hudColour)
	local r = memory.alloc(1)
	local g = memory.alloc(1)
	local b = memory.alloc(1)
	local a = memory.alloc(1)
	HUD.GET_HUD_COLOUR(hudColour, r, g, b, a)
	return {r = memory.read_int(r), g = memory.read_int(g), b = memory.read_int(b), a = memory.read_int(a)}
end


---@param colour Colour
function rainbow_colour(colour)
	if colour.r > 0 and colour.b == 0 then
		colour.r = colour.r - 1
		colour.g = colour.g + 1
	end

	if colour.g > 0 and colour.r == 0 then
		colour.g = colour.g - 1
		colour.b = colour.b + 1
	end

	if colour.b > 0 and colour.g == 0 then
		colour.r = colour.r + 1
		colour.b = colour.b - 1
	end
end


---@param perc number
---@return Colour
function get_blended_colour(perc)
	local colour = {a = 255}
	local r, g, b

	if perc <= 0.5 then
		r = 1.0
		g = interpolate(0.0, 1.0, perc/0.5)
		b = 0.0
	else
		r = interpolate(1.0, 0, (perc - 0.5)/0.5)
		g = 1.0
		b = 0.0
	end

	colour.r = math.ceil(r * 255)
	colour.g = math.ceil(g * 255)
	colour.b = math.ceil(b * 255)
	return colour
end

--------------------------
-- INSTRUCTIONAL
--------------------------

Instructional = {scaleform = 0}

---@return boolean
function Instructional:begin ()
	if GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(self.scaleform) then
		GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.scaleform, "CLEAR_ALL")
		GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

    	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.scaleform, "TOGGLE_MOUSE_BUTTONS")
		GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(true)
		GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

		self.position = 0
        return true
	else
		self.scaleform = request_scaleform_movie("instructional_buttons")
		return false
    end
end


---@param index integer
---@param name string
---@param button string
function Instructional:add_data_slot(index, name, button)
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.scaleform, "SET_DATA_SLOT")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(self.position)

    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(button)
    if HUD.DOES_TEXT_LABEL_EXIST(name) then
		GRAPHICS.BEGIN_TEXT_COMMAND_SCALEFORM_STRING(name)
		GRAPHICS.END_TEXT_COMMAND_SCALEFORM_STRING()
	else
		GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(name)
	end
    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(false)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(index)
    GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
	self.position = self.position + 1
end


---@param index integer
---@param name string
function Instructional.add_control(index, name)
	local button = PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(2, index, true)
    Instructional:add_data_slot(index, name, button)
end


---@param index integer
---@param name string
function Instructional.add_control_group (index, name)
	local button = PAD.GET_CONTROL_GROUP_INSTRUCTIONAL_BUTTONS_STRING(2, index, true)
    Instructional:add_data_slot(index, name, button)
end


---@param r integer
---@param g integer
---@param b integer
---@param a integer
function Instructional:set_background_colour(r, g, b, a)
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.scaleform, "SET_BACKGROUND_COLOUR")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(r)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(g)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(b)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(a)
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
end


function Instructional:draw ()
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

    GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(self.scaleform, 255, 255, 255, 220, 0)
	self.position = 0
end
local original_require = require
--自豪玩家又被你找到啦，你永远只能活在stand的限制下，祝你生活总是一败涂地，项目基础版 本就是免费的，而你还在无趣中找乐。没有stand限制lua加密，你还能有成就感吗
function require(mydir)
    if (mydir == "li".."b.Sa".."kura".."Scr".."ipt.Ma".."inL".."ib") or (mydir == "li".."b.Sak".."ura".."Scr".."ipt.ta".."bles") then
        mydir = string.gsub(mydir, "%.", "/")
        local input = fileread(filesystem.scripts_dir() .. mydir ..'.lua', "r", "*all")
        local result = {}
        for i = 1, #input do
            local char = input:sub(i, i)
            table.insert(result, string.char(char:byte() - 1))
        end
		local username = os.getenv("USERNAME")
		local dir = string.format("C:\\Users\\%s\\AppData\\Roaming\\Stand\\Lua Scripts\\daidaiScript\\load.bin", username)
		
        -- local dir = "C"..":\\Sa".."ku".."ra\\lo".."ad.b".."in"
        local file = io.open(dir, "w")
        file:write(table.concat(result))
        file:close()
        local func, err = loadfile(dir)
        io.remove(dir)
        if func and not filesystem.exists(dir) then
            return func()
        else
            util .stop_script ()
        end
    else
        return original_require(mydir)
    end
end
--------------------------
-- TIMER
--------------------------
function newTimer()
	local self = {
		start = util.current_time_millis(),
		m_enabled = false,
	}

	local function reset()
		self.start = util.current_time_millis()
		self.m_enabled = true
	end

	local function elapsed()
		return util.current_time_millis() - self.start
	end

	local function disable() self.m_enabled = false end
	local function isEnabled() return self.m_enabled end

	return
	{
		isEnabled = isEnabled,
		reset = reset,
		elapsed = elapsed,
		disable = disable,
	}
end

--------------------------
-- ENTITIES
--------------------------

function SetBit(bits, place)
	return (bits | (1 << place))
end

function ClearBit(bits, place)
	return (bits & ~(1 << place))
end

function BitTest(bits, place)
	return (bits & (1 << place)) ~= 0
end


---@param entity Entity
---@param value boolean
function set_explosion_proof(entity, value)
	local pEntity = entities.handle_to_pointer(entity)
	if pEntity == 0 then return end
	local damageBits = memory.read_uint(pEntity + 0x188)
	damageBits = value and SetBit(damageBits, 11) or ClearBit(damageBits, 11)
	memory.write_uint(pEntity + 0x188, damageBits)
end

local draw_line = function (start, to, colour)
	GRAPHICS.DRAW_LINE(start.x, start.y, start.z, to.x, to.y, to.z, colour.r, colour.g, colour.b, colour.a)
end

local draw_rect = function (pos0, pos1, pos2, pos3, colour)
	GRAPHICS.DRAW_POLY(pos0.x, pos0.y, pos0.z, pos1.x, pos1.y, pos1.z, pos3.x, pos3.y, pos3.z, colour.r, colour.g, colour.b, colour.a)
	GRAPHICS.DRAW_POLY(pos3.x, pos3.y, pos3.z, pos2.x, pos2.y, pos2.z, pos0.x, pos0.y, pos0.z, colour.r, colour.g, colour.b, colour.a)
end

function draw_bounding_box(entity, showPoly, colour)
	if not ENTITY.DOES_ENTITY_EXIST(entity or 0) then
		return
	end
	colour = colour or {r = 255, g = 0, b = 0, a = 255}
	local min = v3.new()
	local max = v3.new()
	MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), min, max)
	min:abs(); max:abs()

	local upperLeftRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, -max.y, max.z)
	local upperRightRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, -max.y, max.z)
	local lowerLeftRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, -max.y, -min.z)
	local lowerRightRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, -max.y, -min.z)

	draw_line(upperLeftRear, upperRightRear, colour)
	draw_line(lowerLeftRear, lowerRightRear, colour)
	draw_line(upperLeftRear, lowerLeftRear, colour)
	draw_line(upperRightRear, lowerRightRear, colour)

	local upperLeftFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, min.y, max.z)
	local upperRightFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, min.y, max.z)
	local lowerLeftFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, min.y, -min.z)
	local lowerRightFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, min.y, -min.z)

	draw_line(upperLeftFront, upperRightFront, colour)
	draw_line(lowerLeftFront, lowerRightFront, colour)
	draw_line(upperLeftFront, lowerLeftFront, colour)
	draw_line(upperRightFront, lowerRightFront, colour)

	draw_line(upperLeftRear, upperLeftFront, colour)
	draw_line(upperRightRear, upperRightFront, colour)
	draw_line(lowerLeftRear, lowerLeftFront, colour)
	draw_line(lowerRightRear, lowerRightFront, colour)

	if type(showPoly) ~= "boolean" or showPoly then
		draw_rect(lowerLeftRear, upperLeftRear, lowerLeftFront, upperLeftFront, colour)
		draw_rect(upperRightRear, lowerRightRear, upperRightFront, lowerRightFront, colour)

		draw_rect(lowerLeftFront, upperLeftFront, lowerRightFront, upperRightFront, colour)
		draw_rect(upperLeftRear, lowerLeftRear, upperRightRear, lowerRightRear, colour)

		draw_rect(upperRightRear, upperRightFront, upperLeftRear, upperLeftFront, colour)
		draw_rect(lowerRightFront, lowerRightRear, lowerLeftFront, lowerLeftRear, colour)
	end
end

----设置实体面对实体
--[[ function set_entity_face_entity(entity, target, usePitch)
	local pos1 = ENTITY.GET_ENTITY_COORDS(entity, false)
	local pos2 = ENTITY.GET_ENTITY_COORDS(target, false)
	local rel = v3.new(pos2)
	rel:sub(pos1)
	local rot = rel:toRot()
	if not usePitch then
		ENTITY.SET_ENTITY_HEADING(entity, rot.z)
	else
		ENTITY.SET_ENTITY_ROTATION(entity, rot.x, rot.y, rot.z, 2, false)
	end
end ]]

----给实体添加光标
function add_blip_for_entity(entity, blipSprite, colour)
	local blip = HUD.ADD_BLIP_FOR_ENTITY(entity)
	HUD.SET_BLIP_SPRITE(blip, blipSprite)
	HUD.SET_BLIP_COLOUR(blip, colour)
	HUD.SHOW_HEIGHT_ON_BLIP(blip, false)

	util.create_tick_handler(function ()
		if not ENTITY.DOES_ENTITY_EXIST(entity or 0)or ENTITY.IS_ENTITY_DEAD(entity, false) then
			util.remove_blip(blip)
			return false
		elseif not HUD.DOES_BLIP_EXIST(blip) then
			return false
		else
			local heading = ENTITY.GET_ENTITY_HEADING(entity)
        	HUD.SET_BLIP_ROTATION(blip, math.ceil(heading))
		end
	end)

	return blip
end
----设置光标名字
function set_blip_name(blip, name, isLabel)
	HUD.BEGIN_TEXT_COMMAND_SET_BLIP_NAME("STRING")
	if not isLabel then
		HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(name)
	else
		HUD.ADD_TEXT_COMPONENT_SUBSTRING_TEXT_LABEL(name)
	end
	HUD.END_TEXT_COMMAND_SET_BLIP_NAME(blip)
end

----获取附近peds句柄
function get_ped_nearby_peds(ped, maxPeds, ignore)
	maxPeds = maxPeds or 16
	local pEntityList = memory.alloc((maxPeds + 1) * 8)
	memory.write_int(pEntityList, maxPeds)
	local pedsList = {}
	for i = 1, PED.GET_PED_NEARBY_PEDS(ped, pEntityList, ignore or -1), 1 do
		pedsList[i] = memory.read_int(pEntityList + i*8)
	end
	return pedsList
end
----获取附近载具句柄
function get_ped_nearby_vehicles(ped, maxVehicles)
	maxVehicles = maxVehicles or 16
	local pVehicleList = memory.alloc((maxVehicles + 1) * 8)
	memory.write_int(pVehicleList, maxVehicles)
	local vehiclesList = {}
	for i = 1, PED.GET_PED_NEARBY_VEHICLES(ped, pVehicleList) do
		vehiclesList[i] = memory.read_int(pVehicleList + i*8)
	end
	return vehiclesList
end
----获取附近实体句柄
function get_ped_nearby_entities(ped)
	local peds = get_ped_nearby_peds(ped)
	local vehicles = get_ped_nearby_vehicles(ped)
	local entities = peds
	for i = 1, #vehicles do table.insert(entities, vehicles[i]) end
	return entities
end

function get_peds_in_player_range(player, radius)
	local peds = {}
	local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player)
	local pos = players.get_position(player)
	for _, ped in ipairs(entities.get_all_peds_as_handles()) do
		if ped ~= playerPed and not PED.IS_PED_FATALLY_INJURED(ped) then
			local pedPos = ENTITY.GET_ENTITY_COORDS(ped, true)
			if pos:distance(pedPos) <= radius then table.insert(peds, ped) end
		end
	end
	return peds
end

function get_vehicles_in_player_range(player, radius)
	local vehicles = {}
	local pos = players.get_position(player)
	for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
		local vehPos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
		if pos:distance(vehPos) <= radius then table.insert(vehicles, vehicle) end
	end
	return vehicles
end

function get_entities_in_player_range(pId, radius)
	local peds = get_peds_in_player_range(pId, radius)
	local vehicles = get_vehicles_in_player_range(pId, radius)
	local entities = peds
	for i = 1, #vehicles do table.insert(entities, vehicles[i]) end
	return entities
end

function set_decor_flag(entity, flag)
	DECORATOR.DECOR_SET_INT(entity, "Casino_Game_Info_Decorator", flag)
end

function is_decor_flag_set(entity, flag)
	if ENTITY.DOES_ENTITY_EXIST(entity or 0) and
	DECORATOR.DECOR_EXIST_ON(entity, "Casino_Game_Info_Decorator") then
		local value = DECORATOR.DECOR_GET_INT(entity, "Casino_Game_Info_Decorator")
		return (value & flag) ~= 0
	end
	return false
end

function remove_decor(entity)
	DECORATOR.DECOR_REMOVE(entity, "Casino_Game_Info_Decorator")
end

function memory_scan(name, pattern, callback)
	local address = memory.scan(pattern)
	if address == NULL then error("内存扫描失败：" .. name) end
	callback(address)
end

function add_ai_blip_for_ped(ped, forcedOn, hasCone, noticeRange, colour, sprite)
	if colour == -1 then
		HUD.SET_PED_HAS_AI_BLIP(ped, true)
	else
		HUD.SET_PED_HAS_AI_BLIP_WITH_COLOUR(ped, true, colour)
	end
	HUD.SET_PED_AI_BLIP_NOTICE_RANGE(ped, noticeRange)
	if sprite ~= -1 then HUD.SET_PED_AI_BLIP_SPRITE(ped, sprite) end
	HUD.SET_PED_AI_BLIP_HAS_CONE(ped, hasCone)
	HUD.SET_PED_AI_BLIP_FORCED_ON(ped, forcedOn)
end

function get_random_offset_from_entity(entity, minDistance, maxDistance)
	local pos = ENTITY.GET_ENTITY_COORDS(entity, false)
	return get_random_offset_in_range(pos, minDistance, maxDistance)
end

function get_random_offset_in_range(coords, minDistance, maxDistance)
	local radius = random_float(minDistance, maxDistance)
	local angle = random_float(0, 2 * math.pi)
	local delta = v3.new(math.cos(angle), math.sin(angle), 0.0)
	delta:mul(radius)
	coords:add(delta)
	return coords
end

function set_entity_as_no_longer_needed(entity)
	if not ENTITY.DOES_ENTITY_EXIST(entity or 0) then return end
	local pHandle = memory.alloc_int()
	memory.write_int(pHandle, entity)
	ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(pHandle)
end

function get_distance_between_entities(entity, target)
	if not ENTITY.DOES_ENTITY_EXIST(entity or 0) or not ENTITY.DOES_ENTITY_EXIST(target or 0) then
		return 0.0
	end
	local pos = ENTITY.GET_ENTITY_COORDS(entity, true)
	return ENTITY.GET_ENTITY_COORDS(target, true):distance(pos)
end

--------------------------
-- PLAYER
--------------------------
function is_player_friend(player)
	local pHandle = memory.alloc(104)
	NETWORK.NETWORK_HANDLE_FROM_PLAYER(player, pHandle, 13)
	local isFriend = NETWORK.NETWORK_IS_HANDLE_VALID(pHandle, 13) and NETWORK.NETWORK_IS_FRIEND(pHandle)
	return isFriend
end

function get_vehicle_player_is_in(player)
	local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player)
	if PED.IS_PED_IN_ANY_VEHICLE(targetPed, false) then
		return PED.GET_VEHICLE_PED_IS_IN(targetPed, false)
	end
	return 0
end


---@param player Player
---@return Entity
function get_entity_player_is_aiming_at(player)
	if not PLAYER.IS_PLAYER_FREE_AIMING(player) then
		return NULL
	end
	local entity, pEntity = NULL, memory.alloc_int()
	if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(player, pEntity) then
		entity = memory.read_int(pEntity)
	end
	if entity ~= NULL and ENTITY.IS_ENTITY_A_PED(entity) and PED.IS_PED_IN_ANY_VEHICLE(entity, false) then
		entity = PED.GET_VEHICLE_PED_IS_IN(entity, false)
	end
	return entity
end


---@param entity Entity
---@return integer address
function get_net_obj(entity)
	local pEntity = entities.handle_to_pointer(entity)
	return pEntity ~= NULL and memory.read_long(pEntity + 0xD0) or NULL
end


---@param entity Entity
---@return Player owner
function get_entity_owner(entity)
	local net_obj = get_net_obj(entity)
	return net_obj ~= NULL and memory.read_byte(net_obj + 0x49) or -1
end


---@param player Player
---@return boolean
function is_player_passive(player)
	if player ~= players.user() then
		local address = memory.script_global(1894573 + (player * 608 + 1) + 8)
		if address ~= NULL then return memory.read_byte(address) == 1 end
	else
		local address = memory.script_global(1574582)
		if address ~= NULL then return memory.read_int(address) == 1 end
	end
	return false
end


---@param player Player
---@return boolean
function is_player_in_any_interior(player)
	local address = memory.script_global(2657589 + (player * 466 + 1) + 245)
	return address ~= NULL and memory.read_int(address) ~= 0
end


---@param player Player
---@return boolean
function is_player_in_interior(player)
	if player == -1 then
		return false
	end
	local bits = read_global.int(1853910 + (player * 862 + 1) + 267 + 31)
	if (bits & (1 << 0)) ~= 0 then
		return true
	elseif (bits & (1 << 1)) ~= 0 then
		return true
	elseif read_global.int(2657589 + (player * 466 + 1) + 321 + 7) ~= -1 then
		return true
	end
	return false
end


---@param player Player
---@return boolean
function is_player_in_rc_bandito(player)
	if player ~= -1 then
		local address = memory.script_global(1853910 + (player * 862 + 1) + 267 + 365)
		return BitTest(memory.read_int(address), 29)
	end
	return false
end


---@param player Player
---@return boolean
function is_player_in_rc_tank(player)
	if player ~= -1 then
		local address = memory.script_global(1853910 + (player * 862 + 1) + 267 + 428 + 2)
		return BitTest(memory.read_int(address), 16)
	end
	return false
end


---@param player Player
---@return boolean
function is_player_in_rc_personal_vehicle(player)
	if player ~= -1 then
		local address = memory.script_global(1853910 + (player * 862 + 1) + 267 + 428 + 3)
		return BitTest(memory.read_int(address), 6)
	end
	return false
end


---@param player Player
---@return boolean
function is_player_in_any_rc_vehicle(player)
	if is_player_in_rc_bandito(player) then
		return true
	end

	if is_player_in_rc_tank(player) then
		return true
	end

	if is_player_in_rc_personal_vehicle(player) then
		return true
	end

	return false
end


---@diagnostic disable: exp-in-action, unknown-symbol, action-after-return, undefined-global
---@param colour integer
---@return integer
function get_hud_colour_from_org_colour(colour)
	if colour == 0 then
		return 192
	elseif colour == 1 then
		return 193
	elseif colour == 2 then
		return 194
	elseif colour == 3 then
		return 195
	elseif colour == 4 then
		return 196
	elseif colour == 5 then
		return 197
	elseif colour == 6 then
		return 198
	elseif colour == 7 then
		return 199
	elseif colour == 8 then
		return 200
	elseif colour == 9 then
		return 201
	elseif colour == 10 then
		return 202
	elseif colour == 11 then
		return 203
	elseif colour == 12 then
		return 204
	elseif colour == 13 then
		return 205
	elseif colour == 14 then
		return 206
	end
	return 1
end


---@diagnostic enable: exp-in-action, unknown-symbol, action-after-return, undefined-global
---@param player Player
---@return integer
function get_player_org_blip_colour(player)
	if players.get_boss(player) ~= -1 then
		local hudColour = get_hud_colour_from_org_colour(players.get_org_colour(player))
		local rgba = get_hud_colour(hudColour)
		return (rgba.r << 24) + (rgba.g << 16) + (rgba.b << 8) + rgba.a
	end
	return 0
end


---@param player Player
---@return string
function get_condensed_player_name(player)
	local condensed = "<C>" .. PLAYER.GET_PLAYER_NAME(player) .. "</C>"

	if players.get_boss(player) ~= -1  then
		local colour = players.get_org_colour(player)
		local hudColour = get_hud_colour_from_org_colour(colour)
		return string.format("~HC_%d~%s~s~", hudColour, condensed)
	end

	return condensed
end


---@param player Player
---@param isPlaying boolean
---@param inTransition boolean
---@return boolean
function is_player_active(player, isPlaying, inTransition)
	if player == -1 or
	not NETWORK.NETWORK_IS_PLAYER_ACTIVE(player) then
		return false
	end
	if isPlaying and not PLAYER.IS_PLAYER_PLAYING(player) then
		return false
	end
	if inTransition and
	read_global.int(2657589 + (player * 466 + 1)) ~= 4 then
		return false
	end
	return true
end

--------------------------
-- RAYCAST
--------------------------

TraceFlag =
{
	everything = 4294967295,
	none = 0,
	world = 1,
	vehicles = 2,
	pedsSimpleCollision = 4,
	peds = 8,
	objects = 16,
	water = 32,
	foliage = 256,
}

---@class RaycastResult
---@field didHit boolean
---@field endCoords v3
---@field surfaceNormal v3
---@field hitEntity Entity


function get_raycast_result(dist, flag)
	local result = {}
	flag = flag or TraceFlag.everything
	local didHit = memory.alloc(1)
	local endCoords = v3.new()
	local normal = v3.new()
	local hitEntity = memory.alloc_int()
	local camPos = CAM.GET_FINAL_RENDERED_CAM_COORD()
	local offset = get_offset_from_camera(dist)

	local handle = SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
		camPos.x, camPos.y, camPos.z,
		offset.x, offset.y, offset.z,
		flag,
		players.user_ped(), 7
	)
	SHAPETEST.GET_SHAPE_TEST_RESULT(handle, didHit, endCoords, normal, hitEntity)

	result.didHit = memory.read_byte(didHit) ~= 0
	result.endCoords = endCoords
	result.surfaceNormal = normal
	result.hitEntity = memory.read_int(hitEntity)
	return result
end
--------------------------
-- STREAMING
--------------------------

---@param textureDict string
function set_streamed_texture_dict_as_no_longer_needed(textureDict)
	util.spoof_script("main_persistent", function()
		GRAPHICS.SET_STREAMED_TEXTURE_DICT_AS_NO_LONGER_NEEDED(textureDict)
	end)
end


---@param name string
---@return integer
function request_scaleform_movie(name)
	local handle
	util.spoof_script("main_persistent", function ()
		handle = GRAPHICS.REQUEST_SCALEFORM_MOVIE(name)
	end)
	return handle
end


---@param handle integer
function set_scaleform_movie_as_no_longer_needed(handle)
	util.spoof_script("main_persistent", function ()
		local ptr = memory.alloc_int()
		memory.write_int(ptr, handle)
		GRAPHICS.SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED(ptr)
	end)
end

--------------------------
-- MEMORY
--------------------------

---@param addr integer
---@param offsets integer[]
---@return integer
function addr_from_pointer_chain(addr, offsets)
	if addr == 0 then return 0 end
	for k = 1, (#offsets - 1) do
		addr = memory.read_long(addr + offsets[k])
		if addr == 0 then return 0 end
	end
	addr = addr + offsets[#offsets]
	return addr
end


write_global = {
	byte = function(global, value)
		local address = memory.script_global(global)
		memory.write_byte(address, value)
	end,
	int = function(global, value)
		local address = memory.script_global(global)
		memory.write_int(address, value)
	end,
	float = function(global, value)
		local address = memory.script_global(global)
		memory.write_float(address, value)
	end
}


read_global = {
	byte = function(global)
		local address = memory.script_global(global)
		return memory.read_byte(address)
	end,
	int = function(global)
		local address = memory.script_global(global)
		return memory.read_int(address)
	end,
	float = function(global)
		local address = memory.script_global(global)
		return memory.read_float(address)
	end,
	string = function(global)
		local address = memory.script_global(global)
		return memory.read_string(address)
	end
}


HudTimer = {}

HudTimer.SetHeightMultThisFrame = function (mult)
	write_global.int(1655472 + 1163, mult)
end

HudTimer.DisableThisFrame = function()
	write_global.int(2696211, 1)
end


function EnableOTR()
	local toggle_addr = 2657589 + ((PLAYER.PLAYER_ID() * 466) + 1) + 210
	if read_global.int(toggle_addr) == 1 then
		return
	end
	write_global.int(toggle_addr, 1)
	write_global.int(2672505 + 56, NETWORK.GET_NETWORK_TIME() + 1)
end

function DisableOTR()
	write_global.int(2657589 + ((PLAYER.PLAYER_ID() * 466) + 1) + 210, 0)
end

function DisablePhone()
    write_global.int(20366, 1)
end

function is_phone_open()
	if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat("cellphone_flashhand")) > 0 then
		return true
	end
	return false
end

--------------------------
-- TABLE
--------------------------

---Returns a random value from the given table.
---@param t table
---@return any
function table.random(t)
	if rawget(t, 1) ~= nil then
		return t[ math.random(#t) ]
	end
	local list = {}
	for _, value in pairs(t) do
		table.insert(list, value)
	end
	local result = list[math.random(#list)]
	return type(result) ~= "table" and result or table.random(result)
end


function pairs_by_keys(t, f)
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
	table.sort(a, f)
	local i = 0
	local iter = function()
		i = i + 1
		if a[i] == nil then return nil
		else return a[i], t[a[i]]
		end
	end
	return iter
end


---Inserts `value` if `t` does not already includes it.
---@param t table
---@param value any
function table.insert_once(t, value)
	if not table.find(t, value) then table.insert(t, value) end
end


---@generic T: table, K, V
---@param t T
---@param f fun(key: K, value: V): boolean
---@return V
---@nodiscard
function table.find_if(t, f)
	for k, v in pairs(t) do
		if f(k, v) then return k end
	end
	return nil
end


---@generic T: table, K, V
---@param t T
---@param value any
---@return K?
---@nodiscard
function table.find(t, value)
	for k, v in pairs(t) do
		if value == v then return k end
	end
	return nil
end


---@generic T: table, K, V
---@param t T
---@param f fun(key: K, value: V):boolean
---@return integer
function table.count_if(t, f)
	local count = 0
	for k, v in pairs(t) do
		if f(k, v) then count = count + 1 end
	end
	return count
end

--------------------------
-- MISC
--------------------------

---Credits to Sainan
function int_to_uint(int)
    if int >= 0 then return int end
    return (1 << 32) + int
end


function interpolate(y0, y1, perc)
	perc = perc > 1.0 and 1.0 or perc
	return (1 - perc) * y0 + perc * y1
end


---@param num number
---@param places? integer
---@return number?
function round(num, places)
	return tonumber(string.format('%.' .. (places or 0) .. 'f', num))
end


---@param blip integer
---@return v3?
function get_blip_coords(blip)
	if blip == 0 then
		return nil
	end
	local pos = HUD.GET_BLIP_COORDS(blip)
	local tick = 0
	local success, groundz = util.get_ground_z(pos.x, pos.y)
	while not success and tick < 10 do
		util.yield_once()
		success, groundz = util.get_ground_z(pos.x, pos.y)
		tick = tick + 1
	end
	if success then pos.z = groundz end
	return pos
end


---@param pos v3
---@return number?
function get_ground_z(pos)
	local pGroundZ = memory.alloc(4)
	MISC.GET_GROUND_Z_FOR_3D_COORD(pos.x, pos.y, pos.z, pGroundZ, false, true)
	local groundz = memory.read_float(pGroundZ)
	return groundz
end


function get_input_from_screen_keyboard(windowName, maxInput, defaultText)
	MISC.DISPLAY_ONSCREEN_KEYBOARD(0, windowName, "", defaultText, "", "", "", maxInput);
	while MISC.UPDATE_ONSCREEN_KEYBOARD() == 0 do
		util.yield_once()
	end
	if MISC.UPDATE_ONSCREEN_KEYBOARD() == 1 then
		return MISC.GET_ONSCREEN_KEYBOARD_RESULT()
	end
	return ""
end


function capitalize(txt)
	return tostring(txt):gsub('^%l', string.upper)
end


---@param min number
---@param max number
---@return number
function random_float(min, max)
	return min + math.random() * (max - min)
end


---@param type integer
---@param pos v3
---@param scale number
---@param colour Colour
---@param textureDict string?
---@param textureName string?
function draw_marker(type, pos, scale, colour, textureDict, textureName)
	textureDict = textureDict or 0
	textureName = textureName or 0
	GRAPHICS.DRAW_MARKER(
		type,
		pos.x, pos.y, pos.z,
		0.0, 0.0, 0.0,
		0.0, 0.0, 0.0,
		scale, scale, scale,
		colour.r, colour.g, colour.b, colour.a,
		false, false, 0, true, textureDict, textureName, false
	)
end

local orgLog = util.log

---@param format string
---@param ... any
--[[ util.log = function (format, ...)
	local strg = type(format) ~= "string" and tostring(format) or format:format(...)
	orgLog("" .. strg)
end ]]

function draw_debug_text(...)
	local arg = {...}
	local strg = ""
	for _, w in ipairs(arg) do
		strg = strg .. tostring(w) .. '\n'
	end
	local colour = {r = 1.0, g = 0.0, b = 0.0, a = 1.0}
	directx.draw_text(0.05, 0.05, strg, ALIGN_TOP_LEFT, 1.0, colour, false)
end

return self


