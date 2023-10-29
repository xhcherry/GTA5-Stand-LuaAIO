local PedList = require "lib.daidailib.bodyguards.ped_list"
local daidaiDir = filesystem.scripts_dir() .. "daidaiScript\\"

local ModelList ={
	reference = 0,
	default = nil,
	name = "",
	command = "",
	onClick = nil,
	changeName = false,
	options = {},
	foundOpts = {},
}
ModelList.__index = ModelList

function ModelList.new(parent, name, command, helpText, tbl, onClick, changeName, searchOpt)
	local self = setmetatable({}, ModelList)
	self.name = name
	self.command = command
	self.onClick = onClick
	self.changeName = changeName
	self.foundOpts = {}
	self.options = tbl
	self.reference = menu.list(parent, name, {self.command}, helpText or "")

	for caption, value in pairs_by_keys(self.options) do
		if type(value) == "string" then
			self:addOpt(self.reference, caption, value)

		elseif type(value) == "table" then
			local section = menu.list(self.reference, caption, {}, "")
			self:addSection(section, value)
		end
	end

	return self
end

function ModelList:addOpt(parent, caption, model)
	local command = self.command ~= "" and self.command .. caption or ""

	return menu.action(parent, caption, {command}, "", function(click)
		if self.changeName then
			local newName = string.format("%s: %s", self.name, caption)
			menu.set_menu_name(self.reference, newName)
		end
		if (click & CLICK_FLAG_AUTO) == 0 then menu.focus(self.reference) end
		if self.onClick then self.onClick(caption, model) end
	end)
end

function ModelList:addSection(parent, tbl, outReferences)
	for caption, name in pairs_by_keys(tbl) do
		local reference = self:addOpt(parent, caption, name)
		if outReferences then table.insert(outReferences, reference) end
	end
end

function ModelList.getSectionMatches(section, find, tbl)
	local matches = {}
	find = string.lower(find)

	for caption, model in pairs(tbl) do
		if string.lower(caption):find(find) or
		model:find(find) then matches[section .. " > " .. caption] = model end
	end
	return matches
end


Weapons =
{
	-- Shotguns
	VAULT_WMENUI_2 =
	{
		WT_SG_PMP = "weapon_pumpshotgun",
		WT_SG_PMP2 = "weapon_pumpshotgun_mk2",
		WT_SG_SOF = "weapon_sawnoffshotgun",
		WT_SG_BLP = "weapon_bullpupshotgun",
		WT_SG_ASL = "weapon_assaultshotgun",
		WT_MUSKET = "weapon_musket",
		WT_HVYSHOT = "weapon_heavyshotgun",
		WT_DBSHGN = "weapon_dbshotgun",
		WT_AUTOSHGN = "weapon_autoshotgun",
		WT_CMBSHGN = "weapon_combatshotgun",
	},
	-- Machine guns
	VAULT_WMENUI_3 =
	{
		WT_SMG_MCR = "weapon_microsmg",
		WT_MCHPIST = "weapon_machinepistol",
		WT_MINISMG = "weapon_minismg",
		WT_SMG = "weapon_smg",
		WT_SMG2 = "weapon_smg_mk2",
		WT_SMG_ASL = "weapon_assaultsmg",
		WT_COMBATPDW = "weapon_combatpdw",
		WT_MG = "weapon_mg",
		WT_MG_CBT = "weapon_combatmg",
		WT_MG_CBT2 = "weapon_combatmg_mk2",
		WT_GUSENBERG = "weapon_gusenberg",
		WT_RAYCARBINE = "weapon_raycarbine",
	},
	-- Rifles
	VAULT_WMENUI_4 =
	{
		WT_RIFLE_ASL = "weapon_assaultrifle",
		WT_RIFLE_ASL2 = "weapon_assaultrifle_mk2",
		WT_RIFLE_CBN = "weapon_carbinerifle",
		WT_RIFLE_CBN2 = "weapon_carbinerifle_mk2",
		WT_RIFLE_ADV = "weapon_advancedrifle",
		WT_RIFLE_SCBN = "weapon_specialcarbine",
		WT_SPCARBINE2 = "weapon_specialcarbine_mk2",
		WT_BULLRIFLE = "weapon_bullpuprifle",
		WT_BULLRIFLE2 = "weapon_bullpuprifle_mk2",
		WT_CMPRIFLE = "weapon_compactrifle",
		WT_MLTRYRFL = "weapon_militaryrifle",
		WT_HEAVYRIFLE = "WEAPON_HEAVYRIFLE",
		WT_TACRIFLE = "WEAPON_TACTICALRIFLE",
	},
	-- Sniper rifles
	VAULT_WMENUI_5 =
	{
		WT_SNIP_RIF = "weapon_sniperrifle",
		WT_SNIP_HVY = "weapon_heavysniper",
		WT_SNIP_HVY2 = "weapon_heavysniper_mk2",
		WT_MKRIFLE = "weapon_marksmanrifle",
		WT_MKRIFLE2 = "weapon_marksmanrifle_mk2",
		WT_PRCSRIFLE = "WEAPON_PRECISIONRIFLE",
	},
	-- Heavy weapons
	VAULT_WMENUI_6 =
	{
		WT_GL = "weapon_grenadelauncher",
		WT_RPG = "weapon_rpg",
		WT_MINIGUN = "weapon_minigun",
		WT_FWRKLNCHR = "weapon_firework",
		WT_RAILGUN = "weapon_railgun",
		WT_HOMLNCH = "weapon_hominglauncher",
		WT_CMPGL = "weapon_compactlauncher",
		WT_RAYMINIGUN = "weapon_rayminigun",
	},
	-- Melee weapons
	VAULT_WMENUI_8 =
	{
		WT_UNARMED = "weapon_unarmed",
		WT_KNIFE = "weapon_knife",
		WT_NGTSTK = "weapon_nightstick",
		WT_HAMMER = "weapon_hammer",
		WT_BAT = "weapon_bat",
		WT_CROWBAR = "weapon_crowbar",
		WT_GOLFCLUB = "weapon_golfclub",
		WT_BOTTLE = "weapon_bottle",
		WT_DAGGER = "weapon_dagger",
		WT_SHATCHET = "weapon_stone_hatchet",
		WT_KNUCKLE = "weapon_knuckle",
		WT_MACHETE = "weapon_machete",
		WT_FLASHLIGHT = "weapon_flashlight",
		WT_SWTCHBLDE = "weapon_switchblade",
		WT_BATTLEAXE = "weapon_battleaxe",
		WT_POOLCUE = "weapon_poolcue",
		WT_WRENCH = "weapon_wrench",
		WT_HATCHET = "weapon_hatchet",
	},
	-- Pistols
	VAULT_WMENUI_9 =
	{
		WT_PIST = "weapon_pistol",
		WT_PIST2  = "weapon_pistol_mk2",
		WT_PIST_CBT = "weapon_combatpistol",
		WT_PIST_50 = "weapon_pistol50",
		WT_SNSPISTOL = "weapon_snspistol",
		WT_SNSPISTOL2 = "weapon_snspistol_mk2",
		WT_HEAVYPSTL = "weapon_heavypistol",
		WT_VPISTOL = "weapon_vintagepistol",
		WT_CERPST = "weapon_ceramicpistol",
		WT_MKPISTOL = "weapon_marksmanpistol",
		WT_REVOLVER = "weapon_revolver",
		WT_REVOLVER2 = "weapon_revolver_mk2",
		WT_REV_DA = "weapon_doubleaction",
		WT_REV_NV= "weapon_navyrevolver",
		WT_GDGTPST = "weapon_gadgetpistol",
		WT_STUN = "weapon_stungun",
		WT_FLAREGUN = "weapon_flaregun",
		WT_RAYPISTOL = "weapon_raypistol",
		WT_PIST_AP = "weapon_appistol",
	},
}

WeaponList =
{
	reference = 0,
	---@type string?
	name = "",
	---@type string?
	command = "",
	---@type fun(caption: string, model: string)?
	onClick = nil,
	changeName = false,
	selected = nil,
}
WeaponList.__index = WeaponList

---@param parent integer
---@param name string
---@param command? string
---@param helpText? string
---@param onClick? fun(caption: string, model: string)
---@param changeName boolean
---@return WeaponList
function WeaponList.new(parent, name, command, helpText, onClick, changeName)
	local self = setmetatable({}, WeaponList)
	self.name = name
	self.command = command
	self.changeName = changeName
	self.onClick = onClick
	self.reference = menu.list(parent, name, {self.command}, helpText or "")
	for section, tbl in pairs_by_keys(Weapons) do self:addSection(section, tbl) end
	return self
end

---@param parent integer
---@param label string
---@param model string
function WeaponList:addOpt(parent, label, model)
	local name = util.get_label_text(label)
	local command = self.command ~= "" and self.command .. name or ""
	menu.action(parent, name, {command}, "", function(click)
		if self.changeName then
			local newName = string.format("%s: %s", self.name, name)
			menu.set_menu_name(self.reference, newName)
		end
		self.selected = model
		if click == CLICK_MENU then menu.focus(self.reference) end
		if self.onClick then self.onClick(name, model) end
	end)
end

---@param section string
---@param weapons table<string, string>
function WeaponList:addSection(section, weapons)
	local list = menu.list(self.reference, util.get_label_text(section), {}, "")
	for label, model in pairs_by_keys(weapons) do self:addOpt(list, label, model) end
end

-------------------------------------
-- FILELIST
-------------------------------------

---@class SubOpt
---@field name string
---@field callback fun(filename: string, ext: string, path: string)

---@class FilesList
FilesList =
{
	reference = 0,
	dir = "",
	---@type string
	ext = nil,
	isOpen = false,
	fileOpts = {},
	---@type SubOpt[]
	subOpts = {},
}
FilesList.__index = FilesList

---@param parent integer
---@param name string
---@param directory string
---@param ext? string #The extension the file must match to be loaded.
---@return FilesList
function FilesList.new(parent, name, directory, ext)
	local self = setmetatable({}, FilesList)
	self.dir = directory
	self.ext = ext
	self.subOpts, self.fileOpts = {}, {}

	self.reference = menu.list(parent, name, {}, "", function ()
		self.isOpen = true
		self:reload()
	end, function ()
		self.isOpen = false
		self:clear()
	end)
	return self
end


function FilesList:load()
	if not self.dir or not filesystem.exists(self.dir) or
	not filesystem.is_dir(self.dir) then
		return
	end
	for _, path in ipairs(filesystem.list_files(self.dir)) do
		local name, ext = string.match(path, '^.+\\(.+)%.(.+)$')
		if not self.ext or self.ext == ext then self:createOpt(name, ext, path) end
	end
end


---@param filename string
---@param ext string
---@param path string
function FilesList:createOpt(filename, ext, path)
	local list <const> = menu.list(self.reference, filename, {}, "")
	for _, subOpt in ipairs(self.subOpts) do
		menu.action(list, subOpt.name, {subOpt.name .. filename}, "", function () subOpt.callback(filename, ext, path) end)
	end
	self.fileOpts[#self.fileOpts+1] = list
end


---@param filename string #Must include file extension.
---@param content string
function FilesList:add(filename, content)
	assert(self.dir ~= "", "tried to add a file to a null directory")
	if not filesystem.exists(self.dir) then
		filesystem.mkdir(self.dir)
	end

	local name, ext = string.match(filename, '^(.+)%.(.+)$')
	assert(name and ext, "couldn't match file name or extension")
	if filesystem.exists(self.dir .. filename) then
		local count = 2
		repeat
			filename = string.format("%s (%s).%s", name, count, ext)
			count = count + 1
		until not filesystem.exists(self.dir .. filename)
	end

	local file <close> = assert(io.open(self.dir .. filename, "w"))
	file:write(content)
end


function FilesList:clear()
	if #self.fileOpts == 0 then return end
	for i, ref in ipairs(self.fileOpts) do
		menu.delete(ref); self.fileOpts[i] = nil
	end
end


function FilesList:reload()
	self:clear(); self:load()
end


---@param name string
---@param onClick fun(name:string, ext: string, path: string)
function FilesList:addSubOpt(name, onClick)
	table.insert(self.subOpts, {name = name, callback = onClick})
end

function FilesList:isLoaded() return #self.fileOpts > 0 end
-------------------------------------
-- COMPONENT
-------------------------------------

local Component = {reference = 0, drawableId = -1, textureId = 0, componentId = 0}
Component.__index = Component

	function Component.new(parent, name, ped, componentId, onChange)
	local self = setmetatable({}, Component)
	self.reference = menu.list(parent, name , {}, "")
	self.componentId = componentId

	local numDrawables = PED.GET_NUMBER_OF_PED_DRAWABLE_VARIATIONS(ped, componentId)
	self.drawableId = PED.GET_PED_DRAWABLE_VARIATION(ped, componentId)
	local textureSlider

	menu.slider(self.reference, "类型", {}, "", -1, numDrawables - 1, self.drawableId, 1, function (value, prev, click)
		if (click & CLICK_FLAG_AUTO) ~= 0 then return end
		self.drawableId = value
		local numTextures = PED.GET_NUMBER_OF_PED_TEXTURE_VARIATIONS(ped, componentId, value)
		menu.set_max_value(textureSlider, numTextures - 1)
		self.textureId = 0
		menu.set_value(textureSlider, self.textureId)
		onChange(self.drawableId, self.textureId)
	end)

	self.textureId = PED.GET_PED_TEXTURE_VARIATION(ped, componentId)
	local currentNumTextures = PED.GET_NUMBER_OF_PED_TEXTURE_VARIATIONS(ped, componentId, self.drawableId)

	textureSlider =
	menu.slider(self.reference, "纹理", {}, "", 0, currentNumTextures - 1, self.textureId, 1, function (value, prev, click)
		if (click & CLICK_FLAG_AUTO) ~= 0 then return end
		self.textureId = value
		onChange(self.drawableId, self.textureId)
	end)

	return self
end

-------------------------------------
-- PROP
-------------------------------------

---@class Prop
local Prop = {reference = 0, componentId = -1, drawableId = 0, textureId = 0}
Prop.__index = Prop

function Prop.new(parent, name, ped, componentId, onChange)
	local self = setmetatable({}, Prop)
	self.reference = menu.list(parent, name, {}, "")
	self.componentId = componentId

	local numDrawables = PED.GET_NUMBER_OF_PED_PROP_DRAWABLE_VARIATIONS(ped, componentId)
	self.drawableId = PED.GET_PED_PROP_INDEX(ped, componentId)
	local textureSlider

	menu.slider(self.reference, "类型", {}, "", -1, numDrawables - 1, self.drawableId, 1, function (drawableId, prev, click)
		if (click & CLICK_FLAG_AUTO) ~= 0 then return end
		self.drawableId = drawableId
		local numTextures = PED.GET_NUMBER_OF_PED_PROP_TEXTURE_VARIATIONS(ped, componentId, drawableId)
		menu.set_max_value(textureSlider, numTextures - 1)
		self.textureId = 0
		menu.set_value(textureSlider, self.textureId)
		onChange(self.drawableId, self.textureId)
	end)

	self.textureId = PED.GET_NUMBER_OF_PED_PROP_TEXTURE_VARIATIONS(ped, componentId, self.drawableId)
	local currentNumTextures = PED.GET_PED_PROP_TEXTURE_INDEX(ped, componentId)

	textureSlider =
	menu.slider(self.reference, "纹理", {}, "", 0, currentNumTextures - 1, self.textureId, 1, function (value, prev, click)
		if (click & CLICK_FLAG_AUTO) ~= 0 then return end
		self.textureId = value
		onChange(self.drawableId, self.textureId)
	end)

	return self
end
-------------------------------------
-- WARDROBE
-------------------------------------

local Wardrobe = {
	reference = 0,
	components = {},
	props = {}
}
Wardrobe.__index = Wardrobe


local components = {
	[0]  = "头",
	[1]  = "胡须 / 面具",
	[2]  = "头发",
	[3]  = "手套 / 躯干",
	[4]  = "腿",
	[5]  = "双手 / 背部",
	[6]  = "鞋子",
	[7]	 = "牙齿 / 围巾 / 项链 / 手镯",
	[8]  = "附件 / 顶部",
	[9]  = "任务 / 装甲",
	[10] = "贴花",
	[11] = "躯干2",
}

local props <const> =
{
	[0] = "帽子",
	[1] = "眼镜",
	[2] = "耳饰",
	[6] = "手表",
	[7] = "手镯",
}


function Wardrobe.new(parent, menu_name, command_names, help_text, ped)
	local self = setmetatable({}, Wardrobe)
	self.reference = menu.list(parent, menu_name, command_names, help_text, function ()
		self.isOpen = true
	end, function ()
		self.isOpen = false
	end)
	self.components, self.props = {}, {}

	for componentId, name in pairs_by_keys(components, function (a, b) return a < b end) do
		if PED.GET_NUMBER_OF_PED_DRAWABLE_VARIATIONS(ped, componentId) < 1 then
			continue
		end
		self.components[componentId] =
		Component.new(self.reference, name, ped, componentId, function (drawableId, textureId)
			request_control(ped)
			PED.SET_PED_COMPONENT_VARIATION(ped, componentId, drawableId, textureId, 2)
		end)
	end

	for propId, name in pairs_by_keys(props, function (a, b) return a < b end) do
		if PED.GET_NUMBER_OF_PED_PROP_DRAWABLE_VARIATIONS(ped, propId) < 1 then
			continue
		end
		self.props[propId] =
		Prop.new(self.reference, name, ped, propId, function (drawableId, textureId)
			request_control(ped)
			if drawableId == -1 then PED.CLEAR_PED_PROP(ped, propId)
			else PED.SET_PED_PROP_INDEX(ped, propId, drawableId, textureId, true) end
		end)
	end

	return self
end


function Wardrobe:getOutfit()
	assert(self.reference ~= 0, "wardrobe reference does not exist")
	local tbl = {components = {}, props = {}}

	for componentId, component in pairs(self.components) do
		tbl.components[componentId] =
		{drawableId = component.drawableId, textureId = component.textureId}
	end

	for propId, prop in pairs(self.props) do
		tbl.props[propId] =
		{drawableId = prop.drawableId, textureId = prop.textureId}
	end

	return tbl
end
-------------------------------------
-- MEMBER
-------------------------------------

local IsPedAnyAnimal  = function(ped)
	local modelHash = ENTITY.GET_ENTITY_MODEL(ped)
	pluto_switch int_to_uint(modelHash) do
		case 0xC2D06F53:
		case 0xCE5FF074:
		case 0x573201B8:
		case 0xFCFA9E1E:
		case 0x644AC75E:
		case 0xD86B5A95:
		case 0x4E8F95A2:
		case 0x1250D7BA:
		case 0xB11BAB56:
		case 0x431D501C:
		case 0x6D362854:
		case 0xDFB55C81:
		case 0x349F33E1:
		case 0x9563221D:
		case 0x431FC24C:
		case 0xAD7844BB:
		case 0xAAB71F62:
		case 0x56E29962:
		case 0x18012A9F:
		case 0x6AF51FAF:
		case 0x06A20728:
		case 0xD3939DFD:
		case 0x8BBAB455:
		case 0x2FD800B7:
		case 0x8D8AC8B9:
		case 0x3C831724:
		case 0x06C3F072:
		case 0xA148614D:
		case 0x14EC17EA:
		case 0x471BE4B2:
			return true
	end
	return false
end


local IsPedFromAnyArmedForce = function (ped)
	local modelHash = ENTITY.GET_ENTITY_MODEL(ped)
	pluto_switch int_to_uint(modelHash) do
		case 0x15F8700D:
		case 0x625D6958:
		case 0xEDBC7546:
		case 0xB353629E:
		case 0x5E3DA4A4:
		case 0xB6B1EDA8:
		case 0x8D8F1B10:
		case 0xF2DAA2ED:
		case 0x65793043:
		case 0x58D696FE:
		case 0x72C0CAD2:
		case 0xF0259D83:
		case 0xB3F3EE34:
		case 0x7A05FA59:
		case 0x62CC28E2:
		case 0xCA0050E9:
			return true
	end
	return false
end

Member =
{
	handle = 0,
	mgr = 0,
	isMgrOpen = false,
	invincible = 0,
	references =
	{
		invincible = 0,
		teleport = 0,
	},
	weaponHash = 0,
	wardrobe = nil,
}
Member.__index = Member


function Member.new(ped)
	local self = setmetatable({}, Member)
	self.handle = ped
	TASK.CLEAR_PED_TASKS(ped)
	PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
	PED.SET_PED_SEEING_RANGE(ped, 100.0)
	PED.SET_PED_CAN_PLAY_AMBIENT_ANIMS(ped, false)
	PED.SET_PED_CAN_PLAY_AMBIENT_BASE_ANIMS(ped, false)
	PED.SET_PED_CONFIG_FLAG(ped, 208, true)
	PED.SET_COMBAT_FLOAT(ped, 12, 1.0)
	PED.SET_RAGDOLL_BLOCKING_FLAGS(ped, 1)
	PED.SET_RAGDOLL_BLOCKING_FLAGS(ped, 4)
	PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
	PED.SET_PED_COMBAT_ATTRIBUTES(ped, 1, true)
	PED.SET_PED_COMBAT_ATTRIBUTES(ped, 0, false)
	PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
	PED.SET_PED_ALLOW_VEHICLES_OVERRIDE(ped, true)
	PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(ped, false, false)
	--PED.SET_PED_CONFIG_FLAG(ped, 220, true)
	add_ai_blip_for_ped(ped, true, false, 100.0, 2, -1)

	if IsPedFromAnyArmedForce(ped) then
		PED.SET_PED_CONFIG_FLAG(ped, 400, true)
	elseif IsPedAnyAnimal(ped) then
		WEAPON.SET_PED_DROPS_WEAPONS_WHEN_DEAD(ped, false)
		PED.SET_PED_FLEE_ATTRIBUTES(ped, 16384, true)
		PED.SET_PED_COMBAT_ATTRIBUTES(ped, 58, true)
		PED.SET_PED_FLEE_ATTRIBUTES(ped, 1024, true)
	end

	return self
end

function Member:createMember(modelHash)
	local pos = get_random_offset_from_entity(players.user_ped(), 2.0, 3.0)
	pos.z = pos.z - 1.0
	local ped = NULL
	modelHash = modelHash or 0
	if modelHash ~= 0 then
		ped = entities.create_ped(28, modelHash, pos, 0.0)
	else
		local userModelHash = ENTITY.GET_ENTITY_MODEL(players.user_ped())
		ped = entities.create_ped(28, userModelHash, pos, 0)
	end
	NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.PED_TO_NET(ped), true)
	ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ped, false, true)
	NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.PED_TO_NET(ped), players.user(), true)
	ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(ped, true, 1)

	if modelHash == 0 then PED.CLONE_PED_TO_TARGET(players.user_ped(), ped) end
	set_entity_face_entity(ped, players.user_ped(), false)
	return Member.new(ped)
end


function Member:removeMgr()
	if self.mgr == 0 then return end
	menu.delete(self.mgr); self.mgr = 0
end

function Member:delete()
	if ENTITY.DOES_ENTITY_EXIST(self.handle or 0) and request_control(self.handle, 1000) then
		entities.delete_by_handle(self.handle); self.handle = 0
	end
end



function Member:createMgr(parent, name)
	self.mgr = menu.list(parent, name, {}, "", function ()
		self.isMgrOpen = true
	end, function ()
		self.isMgrOpen = false
	end)

	menu.action(self.mgr, "删除", {}, "",  function ()
		self:delete() self:removeMgr()
	end)

	self.references = {}
	if not IsPedAnyAnimal(self.handle) then
		WeaponList.new(self.mgr, "武器", "", "", function (caption, model)
			local hash <const> = util.joaat(model)
			self:giveWeapon(hash); self.weaponHash = hash
		end, true)
	end

	self.references.invincible = menu.toggle(self.mgr, "无敌", {}, "", function (on)
		request_control(self.handle, 1000)
		ENTITY.SET_ENTITY_INVINCIBLE(self.handle, on)
		ENTITY.SET_ENTITY_PROOFS(self.handle, on, on, on, on, on, on, on, on)
	end)

	self.references.teleport = menu.action(self.mgr, "传送到我", {}, "", function ()
		request_control(self.handle, 1000)
		if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
			self:tpToLeader()
		else
			local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
			self:tpToVehicle(vehicle)
		end
	end)

	menu.action(self.mgr, "保存", {}, "", function()
		local ok, errmsg = self:save()
		if not ok then notification(errmsg, HudColour.red) return end
		notification("保镖已保存", HudColour.blue)
	end)

	self.wardrobe = Wardrobe.new(self.mgr, "外貌", {}, "", self.handle)
end


---@param value boolean
function Member:setInvincible(value)
	assert(self.references.invincible ~= 0, "bodyguard manager not found")
	menu.set_value(self.references.invincible, value)
end

---@param weaponHash Hash
function Member:giveWeapon(weaponHash)
	WEAPON.REMOVE_ALL_PED_WEAPONS(self.handle, true)
	WEAPON.GIVE_WEAPON_TO_PED(self.handle, weaponHash, 9999, true, true)
	WEAPON.SET_CURRENT_PED_WEAPON(self.handle, weaponHash, false)
end

---@param vehicle Vehicle
function Member:tpToVehicle(vehicle)
	if not VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(vehicle) or
	(PED.IS_PED_IN_ANY_VEHICLE(self.handle, false) and PED.GET_VEHICLE_PED_IS_IN(self.handle, false) == vehicle) then
		return
	end
	local seat
	for i = -1, VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(vehicle) -1 do
		if VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, i, false) then seat = i break end
	end
	PED.SET_PED_INTO_VEHICLE(self.handle, vehicle, seat)
end

function Member:tpToLeader()
	local pos = get_random_offset_from_entity(players.user_ped(), 2.0, 3.0)
	pos.z = pos.z - 1.0
	ENTITY.SET_ENTITY_COORDS(self.handle, pos.x,pos.y,pos.z, false, false, false, false)
	set_entity_face_entity(self.handle, players.user_ped(), false)
end

function Member:tp()
	assert(self.references.teleport ~= 0, "bodyguard manager not found")
	menu.trigger_command(self.references.teleport, "")
end

function Member:getInfo()
	local pWeaponHash = memory.alloc_int()
	WEAPON.GET_CURRENT_PED_WEAPON(self.handle, pWeaponHash, true)
	local tbl = {
		WeaponHash = memory.read_int(pWeaponHash),
		Outfit = self.wardrobe:getOutfit(),
		ModelHash = ENTITY.GET_ENTITY_MODEL(self.handle)
	}
	return tbl
end

function Member:save()
	local input = ""
	local label = util.register_label("输入文件名")
	while true do
		input = get_input_from_screen_keyboard(label, 31, "")
		if input == "" then
			return false, "保存已取消"
		end

		if not input:find '[^%w_%.%-]' then break end
		label = util.register_label("无效字符")
		util.yield(250)
	end
	local path = daidaiDir .. "bodyguards\\" .. input .. ".json"
	local file, errmsg = io.open(path, "w")
	if not file then
		return false, errmsg
	end
	file:write(json.stringify(self:getInfo(), nil, 0, false))
	file:close()
	return true
end

function type_match(value, e)
local t = type(value)
for w in e:gmatch('[^|]+') do
	if t == w then return true end
end
local msg = "expected %s, got %s"
return nil, msg:format(e:gsub('|', " or "), t)
end
function Member:setOutfit(obj)
	local types =
	{
		components = "table",
		props = "table"
	}
	for k, v in pairs(types) do
		local ok, errmsg = type_match(obj[k], v)
		if not ok then return false, "field " .. k .. ' ' .. errmsg end
	end

	for componentId, tbl in pairs(obj.components) do
		if math.tointeger(componentId) and type(tbl.drawableId) == "number" and
		type(tbl.textureId) == "number" and request_control(self.handle) then
			PED.SET_PED_COMPONENT_VARIATION(self.handle, math.tointeger(componentId), tbl.drawableId, tbl.textureId, 2)
		end
	end

	for propId, tbl in pairs(obj.props) do
		if math.tointeger(propId) and type(tbl.drawableId) == "number" and
		type(tbl.textureId) == "number" and request_control(self.handle) then
			PED.SET_PED_PROP_INDEX(self.handle, math.tointeger(propId), tbl.drawableId, tbl.textureId, true)
		end
	end
	return true
end

-------------------------------------
-- GROUP
-------------------------------------
local Formation =
{
	freedomToMove = 0,
	circleAroundLeader = 1,
	line = 3,
	arrow = 4,
}

local Group =
{
	ID = 0,
	members = {},
	numMembers = 0,
	formation = Formation.freedomToMove,
	defaults =
	{
		invincible = false,
		weaponHash = util.joaat("weapon_heavypistol"),
	},
	rg = util.joaat("rgFM_HateEveryOne"),
}
Group.__index = Group

function Group.new()
	local self = setmetatable({}, Group)
	for num = 0, 6, 1 do
		local ped = PED.GET_PED_AS_GROUP_MEMBER(self.getID(), num)
		if ENTITY.DOES_ENTITY_EXIST(ped or 0) and
		request_control(ped, 1000) then self:pushMember(Member.new(ped)) end
	end
	return self
end

---@return integer
function Group.getID()
	return PLAYER.GET_PLAYER_GROUP(players.user())
end

---@return integer
function Group:getSize()
	local unkPtr, sizePtr = memory.alloc(1), memory.alloc(1)
	PED.GET_GROUP_SIZE(self.getID(), unkPtr, sizePtr)
	return memory.read_int(sizePtr)
end

---@param member Member
function Group:pushMember(member)
	if not PED.IS_PED_IN_GROUP(member.handle) then
		PED.SET_PED_AS_GROUP_MEMBER(member.handle, self.getID())
		PED.SET_PED_NEVER_LEAVES_GROUP(member.handle, true)
	end
	PED.SET_PED_RELATIONSHIP_GROUP_HASH(member.handle, self.rg)
	PED.SET_GROUP_SEPARATION_RANGE(self.getID(), 9999.0)
	PED.SET_GROUP_FORMATION_SPACING(self.getID(), 1.0, 0.9, 3.0)
	PED.SET_GROUP_FORMATION(self.getID(), self.formation)
	table.insert(self.members, member)
	self.numMembers = self.numMembers + 1
end

---@param rgHash Hash
function Group:setRelationshipGrp(rgHash)
	for num = 0, 6, 1 do
		local ped = PED.GET_PED_AS_GROUP_MEMBER(self.getID(), num)
		if ENTITY.DOES_ENTITY_EXIST(ped or 0) and
		request_control(ped, 1000) then PED.SET_PED_RELATIONSHIP_GROUP_HASH(ped, rgHash) end
	end
	self.rg = rgHash
end


function Group:onTick()
	if self.numMembers == 0 then
		return
	end

	for i = self.numMembers, 1, -1 do
		local member = self.members[i]
		local ped = member.handle

		if not ENTITY.DOES_ENTITY_EXIST(ped or 0) or PED.IS_PED_INJURED(ped) then
			self.numMembers = self.numMembers - 1
			member:removeMgr()
			table.remove(self.members, i)
			set_entity_as_no_longer_needed(ped)
			goto LABEL_CONTINUE
		end

		if not PED.IS_PED_IN_GROUP(ped) then
			PED.SET_PED_AS_GROUP_MEMBER(ped, self.getID())
			PED.SET_PED_NEVER_LEAVES_GROUP(ped, true)
		end

		if member.isMgrOpen and menu.is_open() then
			draw_bounding_box(ped, true, {r = 255, g = 255, b = 255, a = 80})
		end
	::LABEL_CONTINUE::
	end
end


function Group:setFormation(formation)
	self.formation = formation
	PED.SET_GROUP_FORMATION(self.getID(), formation)
end

function Group:deleteMembers()
	for num = 0, 6, 1 do
		local ped = PED.GET_PED_AS_GROUP_MEMBER(self.getID(), num)
		if ENTITY.DOES_ENTITY_EXIST(ped or 0) and
		request_control(ped, 1000) then entities.delete_by_handle(ped) end
	end
end

---@param value boolean
function Group:setInvincible(value)
	for _, member in ipairs(self.members) do member:setInvincible(value) end
	self.defaults.invincible = value
end

function Group:teleport()
	for _, member in ipairs(self.members) do member:tp() end
end
-------------------------------------
-- BODYGUARDS MENU
-------------------------------------
BodyguardMenu =
{
	ref = 0,
	divider = 0,
	isOpen = false,
	---@type Group
	group = {},
}
BodyguardMenu.__index = BodyguardMenu
--- Relationship Functions ---
local function addRelationshipGroup(name)
local ptr = memory.alloc_int()
PED.ADD_RELATIONSHIP_GROUP(name, ptr)
local rel = memory.read_int(ptr)
memory.free(ptr)
return rel
end

local relationship = {}
function relationship:friendly(ped)
if not PED.DOES_RELATIONSHIP_GROUP_EXIST(self.friendly_group) then
	self.friendly_group = addRelationshipGroup("friendly_group")
	PED.SET_RELATIONSHIP_BETWEEN_GROUPS(0, self.friendly_group, self.friendly_group)
end
PED.SET_PED_RELATIONSHIP_GROUP_HASH(ped, self.friendly_group)
end



function BodyguardMenu.new(parent, name, command_names)
local self = setmetatable({}, BodyguardMenu)
self.ref = menu.list(parent, name, command_names or {}, "", function()
	self.isOpen = true
end, function()
	self.isOpen = false
end)
self.group = Group.new()

ModelList.new(self.ref, "生成", "", "", PedList, function (caption, model)
	if self.group:getSize() >= 7 then
		return notification("你达到了保镖的最大数量", HudColour.red)
	end
	local modelHash = util.joaat(model)
	request_model(modelHash)
	local member = Member:createMember(modelHash)
	self.group:pushMember(member)
	local weaponHash = self.group.defaults.weaponHash
	if IsPedAnyAnimal(member.handle) then
		weaponHash = util.joaat("weapon_animal")
	end
	member:giveWeapon(weaponHash)
	member:createMgr(self.ref, caption)
	if self.group.defaults.invincible then member:setInvincible(true) end
end, false, true)

menu.action(self.ref, "克隆我自己", {}, "", function ()
	if self.group:getSize() >= 7 then
		return notification("你达到了保镖的最大数量", HudColour.red)
	end
	local member = Member:createMember()
	self.group:pushMember(member)
	local weaponHash = self.group.defaults.weaponHash
	if IsPedAnyAnimal(member.handle) then
		weaponHash = util.joaat("weapon_animal")
	end
	member:giveWeapon(weaponHash)
	member:createMgr(self.ref, "克隆")
	if self.group.defaults.invincible then member:setInvincible(true) end
end)

local saved = FilesList.new(self.ref, "已保存的", daidaiDir .. "bodyguards", "json")

saved:addSubOpt("生成", function(name, ext, path)
	if self.group:getSize() >= 7 then
		return notification("你达到了保镖的最大数量", HudColour.red)
	end
	local ok, result = json.parse(path)
	if not ok then return notification(result, HudColour.red) end

	local modelHash <const> = result.ModelHash
	request_model(modelHash)
	local member = Member:createMember(modelHash)
	self.group:pushMember(member)

	local weaponHash = result.WeaponHash
	if IsPedAnyAnimal(member.handle) and
	weaponHash ~= util.joaat("weapon_animal") then
		weaponHash = util.joaat("weapon_animal")
	end

	local ok, errmsg = member:setOutfit(result.Outfit)
	if not ok then
	notification("%s 有一套无效的衣服: %s", HudColour.red, name, errmsg)
	end

	member:giveWeapon(weaponHash)
	member:createMgr(self.ref, name)
	if self.group.defaults.invincible then member:setInvincible(true) end
end)

saved:addSubOpt("删除文件", function (name, ext, path)
	os.remove(path)
	notification("已删除", HudColour.red)
	saved:reload()
end)

self:createCommands(self.ref)
self.divider = menu.divider(self.ref, "已生成的保镖")
for _, member in ipairs(self.group.members) do
	if member.mgr == 0 then member:createMgr(self.ref, "未知") end
end
return self
end


---@param parent integer
function BodyguardMenu:createCommands(parent)
	local list = menu.list(parent, "小组", {}, "")
	local formations <const> =
	{
		"自由", "围绕",
		"线列", "在你后面"
	}
	menu.textslider_stateful(list, "小组编队", {}, "", formations, function (index)
		local formation
		if index == 1 then
			formation = Formation.freedomToMove
		elseif index == 2 then
			formation = Formation.circleAroundLeader
		elseif index == 3 then
			formation = Formation.line
		elseif index == 4 then
			formation = Formation.arrow
		else
			error("got unexpected option")
		end
		self.group:setFormation(formation)
	end)

	local relGroups ={
		{"喜欢玩家", {"like"}},
		{"不喜欢玩家，喜欢帮派", {"dislike"}},
		{"讨厌玩家，喜欢帮派", {"hate"}},
		{"喜欢玩家，讨厌玩家所讨厌的", {"hatehaters"}},
		{"讨厌玩家，喜欢警察", {"dislikeplyrlikecops"}},
		{"不喜欢玩家，喜欢警察", {"hateplyrlikecops"}},
		{"讨厌所有人", {"hateall"}},
	}
	local menuName = "关联小组"
	local helpText = "仅线上"
	menu.list_select(list, menuName, {}, helpText, relGroups, 7, function(opt)
		local rg
		if opt == 1 then
			rg = util.joaat("rgFM_AiLike")
		elseif opt == 2 then
			rg = util.joaat("rgFM_AiDislike")
		elseif opt == 3 then
			rg = util.joaat("rgFM_AiHate")
		elseif opt == 4 then
			rg = util.joaat("rgFM_AiLike_HateAiHate")
		elseif opt == 5 then
			rg = util.joaat("rgFM_AiDislikePlyrLikeCops")
		elseif opt == 6 then
			rg = util.joaat("rgFM_AiHatePlyrLikeCops")
		elseif opt == 7 then
			rg = util.joaat("rgFM_HateEveryOne")
		end
		self.group:setRelationshipGrp(rg)
	end)

	menu.action(list, "删除成员", {}, "", function()
		self.group:deleteMembers()
	end)
	menu.action(list, "传送成员到我", {}, "", function()
		self.group:teleport()
	end)
	menu.toggle(list, "无敌的", {}, "", function(on)
		self.group:setInvincible(on)
	end)
	WeaponList.new(list, "默认武器", "", "", function(caption, model)
		self.group.defaults.weaponHash = util.joaat(model)
	end, true)
end


function BodyguardMenu:onTick()
	if self.group.numMembers ~= 0 then
		if self.isOpen and
		not menu.get_visible(self.divider) then
			menu.set_visible(self.divider, true)
		end
		self.group:onTick()
	elseif self.isOpen and menu.get_visible(self.divider) then
		menu.set_visible(self.divider, false)
	end
end