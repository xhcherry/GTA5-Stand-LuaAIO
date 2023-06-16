local required <const> = {
    "lib/GTSCRIPTS/O.lua",
	"lib/GTP/json.lua",
	"lib/GTP/json/constant.lua",
	"lib/GTP/json/parser.lua",
	"lib/GTP/json/serializer.lua",
}
local Functions = require "lib.GTSCRIPTS.O"
--local PedList <const> = require "lib.GTSCRIPTS.ped_list"

---------------------
-- SPOOFING PROFILE
---------------------
---------------------

function type_match(value, e)
	local t = type(value)
	for w in e:gmatch('[^|]+') do
		if t == w then return true end
	end
	local msg = "expected %s, got %s"
	return nil, msg:format(e:gsub('|', " or "), t)
end

-------------------------------------
-- CREW
-------------------------------------

Crew =
{
	icon = 0,
	tag = "",
	name = "",
	motto = "",
	alt_badge = "Off",
	rank = "",
}
Crew.__index = Crew


function Crew.new(o)
	o = o or {}
	local self = setmetatable(o, Crew)
	return self
end


function Crew.get_player_crew(player)
	local self = setmetatable({}, Crew)
	local networkHandle = memory.alloc(104)
	local clanDesc = memory.alloc(280)
	NETWORK.NETWORK_HANDLE_FROM_PLAYER(player, networkHandle, 13)

	if NETWORK.NETWORK_IS_HANDLE_VALID(networkHandle, 13) and
	NETWORK.NETWORK_CLAN_PLAYER_GET_DESC(clanDesc, 35, networkHandle) then
		self.icon = memory.read_int(clanDesc)
		self.name = memory.read_string(clanDesc + 0x08)
		self.tag = memory.read_string(clanDesc + 0x88)
		self.rank = memory.read_string(clanDesc + 0xB0)
		self.motto = players.clan_get_motto(player)
		self.alt_badge = memory.read_byte(clanDesc + 0xA0) ~= 0 and "On" or "Off"
		--self.rank = memory.read_int(clanDesc + 30 * 8)
	end
	return self
end


local crewInfo =
{
	Name = "名称",
	ID = "ID",
	Tag = "标签",
	AltBadge = "可选徽章",
	Yes = "Yes",
	No = "No",
	Motto = "座右铭",
	None = "无",
}



function Crew:createInfoList(parent, name)
	if self.icon == 0 then
		menu.action(parent, name .. ": " .. crewInfo.None, {}, "", function()end)
		return
	end
	local actions <const> = {{crewInfo.Name, self.name}, {crewInfo.ID, self.icon}, {crewInfo.Tag, self.tag},
	{crewInfo.Motto, self.motto}, {crewInfo.AltBadge, self.alt_badge == "On" and crewInfo.Yes or crewInfo.No}}
	local root = menu.list(parent, name, {}, "")
	for _, tbl in ipairs(actions) do menu.readonly(root, tbl[1], tbl[2]) end
end

Crew.__eq = function (a, b)
	return a.icon == b.icon and a.tag == b.tag and a.name == b.name
end

Crew.__pairs = function(tbl)
	local k <const> = {"icon", "name", "tag", "motto", "alt_badge", "rank"}
	local i = 0
	local iter = function()
		i = i + 1
		if tbl[k[i]] == nil then return nil end
		return k[i], tbl[k[i]]
	end
	return iter, tbl, nil
end

---Returns if a `Crew` (or table with crew information) is valid.
---If it's not, it also returns the error message.
---@param o table|Crew
---@return boolean
---@return string? errmsg
function Crew.isValid(o)
	if not o or not next(o) then return true end
	local types <const> =
	{
		icon = "number",
		tag = "string",
		name = "string",
		motto = "string|nil",
		alt_badge = "string|nil",
		rank = "string|nil"
	}
	for k, t in pairs(types) do
		local ok, errmsg = type_match(rawget(o, k), t)
		if not ok then return false, "field " .. k .. ", " .. errmsg end
	end
	return true
end

-------------------------------------
-- PROFILE
-------------------------------------

ProfileFlag_SpoofName = 1 << 0
ProfileFlag_SpoofRId = 1 << 1
ProfileFlag_SpoofCrew = 1 << 2
ProfileFlag_SpoofIp = 1 << 3



Profile =
{
	name = "**Invalid**",
	rid = 0,
	crew = Crew.new(),
	flags = ProfileFlag_SpoofName | ProfileFlag_SpoofRId,
	---@type string|nil
	ip = nil,
}
Profile.__index = Profile


function Profile.new(o)
	o = o or {}
	local self = setmetatable(o, Profile)
	self.crew = Crew.new(self.crew)
	return self
end


function Profile.get_profile_from_player(player)
	local self = setmetatable({}, Profile)
	self.name = PLAYER.GET_PLAYER_NAME(player)
	self.rid = players.get_rockstar_id(player)
	self.crew = Crew.get_player_crew(player)
	self.ip = get_external_ip(player)
	return self
end


function Profile:enableName()
	local nameSpoofing = menu.ref_by_path("Online>Spoofing>Name Spoofing", 33)
	local spoofName =  menu.ref_by_rel_path(nameSpoofing, "Name Spoofing")
	if menu.get_value(spoofName) ~= 1 then
		menu.trigger_command(spoofName, "on")
	end
	local spoofedName = menu.ref_by_rel_path(nameSpoofing, "Spoofed Name")
	menu.trigger_command(spoofedName, self.name)
end


function Profile:enableRId()
	local rIdSpoofing = menu.ref_by_path("Online>Spoofing>RID Spoofing", 33)
	local spoofRId = menu.ref_by_rel_path(rIdSpoofing, "RID Spoofing")
	if menu.get_value(spoofRId) ~= 2 then
		menu.trigger_command(spoofRId, "2")
	end
	local spoofedRId = menu.ref_by_rel_path(rIdSpoofing, "Spoofed RID")
	menu.trigger_command(spoofedRId, tostring(self.rid))
end


function Profile:enableCrew()
	local crewSpoofing = menu.ref_by_path("Online>Spoofing>Crew Spoofing", 33)
	local crew = menu.ref_by_rel_path(crewSpoofing, "Crew Spoofing")
	if menu.get_value(crew) ~= 1 then
		menu.trigger_command(crew, "on")
	end

	local crewId = menu.ref_by_rel_path(crewSpoofing, "ID")
	menu.trigger_command(crewId, tostring(self.crew.icon))

	local crewTag = menu.ref_by_rel_path(crewSpoofing, "Tag")
	menu.trigger_command(crewTag, self.crew.tag)

	local crewAltBadge = menu.ref_by_rel_path(crewSpoofing, "Alternative Badge")
	local altBadgeValue = (self.crew.alt_badge == "On") and 1 or 0
	if menu.get_value(crewAltBadge) ~= altBadgeValue then
		menu.trigger_command(crewAltBadge, string.lower(self.crew.alt_badge))
	end

	local crewName = menu.ref_by_rel_path(crewSpoofing, "Name")
	menu.trigger_command(crewName, self.crew.name)

	local crewMotto = menu.ref_by_rel_path(crewSpoofing, "Motto")
	menu.trigger_command(crewMotto, self.crew.motto)
end


function Profile:enableIp()
	local ipSpoofing = menu.ref_by_path("Online>Spoofing>IP Address Spoofing", 35)
	local toggleIpSpoofing = menu.ref_by_rel_path(ipSpoofing, "IP Address Spoofing")
	if menu.get_value(toggleIpSpoofing) ~= 1 then
		menu.trigger_command(toggleIpSpoofing, "on")
	end
	local spoofedIp = menu.ref_by_rel_path(ipSpoofing, "Spoofed IP Address")
	menu.trigger_command(spoofedIp, self.ip)
end


---@param flag integer
function Profile:isFlagOn(flag)
	return (self.flags & flag) ~= 0
end


---@param flag integer
---@param value boolean
function Profile:setFlag(flag, value)
	self.flags = value and (self.flags | flag) or (self.flags & ~flag)
end


function Profile:enable()
	if self:isFlagOn(ProfileFlag_SpoofName) then self:enableName() end
	if self:isFlagOn(ProfileFlag_SpoofRId) then self:enableRId() end
	if self:isFlagOn(ProfileFlag_SpoofCrew) then self:enableCrew() end
	if self:isFlagOn(ProfileFlag_SpoofIp) then self:enableIp() end
end



Profile.__eq = function (a, b)
	return a.name == b.name and a.rid == b.rid and
	a.crew == b.crew and a.ip == b.ip
end

Profile.__pairs = function(tbl)
	local k <const> = {"name", "rid", "crew", "ip"}
	local i = 0
	local iter = function()
		i = i + 1
		if tbl[k[i]] == nil then return nil end
		return k[i], tbl[k[i]]
	end
	return iter, tbl, nil
end



function Profile.isValid(obj)
	local types <const> =
	{
		name = "string",
		rid  = "string|number",
		crew = "table|nil",
		ip = "string|nil",
	}
	for k, t in pairs(types) do
		local ok, errmsg = type_match(rawget(obj, k), t)
		if not ok then return false, "field " .. k  .. ", ".. errmsg end
	end

	if type(obj.rid) == "string" and not tonumber(obj.rid) then
		return false, "field rid is not string castable"
	end

	local ok, errmsg = Crew.isValid(obj.crew)
	if not ok then
		return false, errmsg
	end

	return true
end

-------------------------------------
-- PROFILE MANAGER
-------------------------------------
local scriptdir <const> = filesystem.scripts_dir()
local GTDir <const> = scriptdir .. "GTLuaScript\\"

local trans =
{
	ProfileDisabled = "虚假配置文件禁用",
	NotNumber = "RID必须是数字",
	MissingData = "名称和RID是必需的",
	AlreadyExists = "配置文件已存在",
	NotUsingProfile = "您没有使用任何虚假配置文件",
	ProfileSaved = "虚假配置文件已保存",
	Enabled = "配置文件已存在",
	MovedToBin = "配置文件已移动到回收站",
	InvalidProfile = "%s 是无效的配置文件: %s",
	ClickToRestore = "点击恢复",
	Invincible = "无敌的",
	TpToMe = "传送到我",
	Delete = "删除",
	Weapon = "武器",
	Appearance = "外貌",
	Save = "保存",
	BodyguardSaved = "保镖已保存",
	SaveCanceled = "保存已取消",
	Clone = "克隆",
	ReachedMaxNumBodyguards = "你达到了保镖的最大数量",
	Unknown = "未知的",
	InvalidOutfit = "%s 有一套无效的衣服: %s"
}


ProfileManager =
{
	reference = 0,
	---@type table<string, Profile>
	profiles = {},
	---@type table<string, integer>
	menuLists = {},
	recycleBin = 0,
	dir = GTDir .. "profiles\\",
	isUsingAnyProfile = false,
	---@type table<string, boolean>
	deletedProfiles = {},
	---@type Profile
	activeProfile = nil
}
ProfileManager.__index = ProfileManager



function ProfileManager.new(parent)
	local self = setmetatable({}, ProfileManager)
	local trans_SpoofingProfiles = "虚假信息"
	self.reference = menu.list(players_root, trans_SpoofingProfiles, {}, "")
	self.menuLists = {}
	self.deletedProfiles = {}
	self.profiles = {}

	local name <const> = "虚假配置文件禁用"
	menu.action(self.reference, name, {"disableprofile"}, "", function()
		if not self:isAnyProfileEnabled() then
			notification(trans.NotUsingProfile, HudColour.red)
		else
			local name <const> = self.activeProfile.name
			self:disableSpoofing()
			notification("虚假配置文件禁用", colors.blue)
		end
	end)

	local name <const> = "添加配置文件"
	local addList = menu.list(self.reference, name, {"addprofile"}, "")
	local profile = {}

	local name <const> = "名称"
	local helpText = "键入配置文件的名称"
	menu.text_input(addList, name, {"profilename"}, helpText, function(name, click)
		if click ~= CLICK_SCRIPTED and name ~= "" then profile.name = name end
	end)

	local name <const> = "RID"
	local helpText = "键入配置文件的RID"
	menu.text_input(addList, name, {"profilerid"}, helpText, function(rid, click)
		if click ~= CLICK_SCRIPTED and rid ~= "" then
			if not tonumber(rid) then return notification(trans.NotNumber, HudColour.red) end
			profile.rid = rid
		end
	end)

	local name <const> = "保存虚假配置文件"
	menu.action(addList, name, {"saveprofile"}, "", function()
		if not profile.name or not profile.rid then
			return notification(trans.MissingData, HudColour.red)
		end
		local valid, errmsg = Profile.isValid(profile)
		if not valid then
			return notification("%s: %s", HudColour.red, trans.InvalidProfile, errmsg)
		end
		local profile = Profile.new(profile)
		if self:includes(profile) then
			return notification(trans.AlreadyExists, HudColour.red)
		end
		self:save(profile, true)
		notification("已保存", colors.pink)
	end)

	self.recycleBin = menu.list(self.reference, "回收站", {}, "")
	menu.divider(self.reference, trans_SpoofingProfiles)
	self:load()
	return self
end



function ProfileManager:includes(profile)
	return table.find(self.profiles, profile) ~= nil
end


function ProfileManager:add(menuName, profile)
	local root = menu.list(self.reference, menuName, {}, "")
	menu.divider(root, menuName)
	self.profiles[menuName] = profile; self.menuLists[menuName] = root

	menu.action(root, "启用虚假配置文件", {}, "", function()
		if self:isAnyProfileEnabled() then self:disableSpoofing() end
		profile:enable()
		self.activeProfile = profile
		notification("启用虚假配置文件", colors.pink)
	end)

	menu.action(root, "打开个人资料", {}, "", function()
		local pHandle = memory.alloc(104)
		NETWORK.NETWORK_HANDLE_FROM_MEMBER_ID(tostring(profile.rid), pHandle, 13)
		NETWORK.NETWORK_SHOW_PROFILE_UI(pHandle)
	end)

	menu.action(root, "删除" , {}, "", function()
		self:remove(menuName, profile)
		notification(trans.MovedToBin,HudColour.blue)
	end)

	menu.toggle(root, "名称", {}, "", function(on)
		profile:setFlag(ProfileFlag_SpoofName, on)
	end, true)

	local name <const> = "RID"
	menu.toggle(root, name .. ": " .. profile.rid, {}, "", function(on)
		profile:setFlag(ProfileFlag_SpoofRId, on)
	end, true)

	if profile.ip then
		local name <const> = "IP"
		menu.toggle(root, name .. ": " .. profile.ip , {}, "", function(on)
			profile:setFlag(ProfileFlag_SpoofIp, on)
		end, false)
	end

	menu.toggle(root, "虚假帮会", {}, "",
		function(toggle) profile:setFlag(ProfileFlag_SpoofCrew, toggle) end, false)
	profile.crew:createInfoList(root, "帮会")
end



function ProfileManager:save(profile, add)
	local fileName = profile.name
	if self.profiles[fileName] then
		local i = 2
		repeat
			fileName = string.format("%s (%d)", profile.name, i)
			i = i + 1
		until not self.profiles[fileName]
	end
	local file <close> = assert(io.open(self.dir .. fileName .. ".json", "w"))
	local content = json.stringify(profile, nil, 4)
	file:write(content)
	if add then self:add(fileName, profile) end
end



function ProfileManager:remove(name, profile)
	menu.delete(self.menuLists[name])
	self.profiles[name] = nil; self.menuLists[name] = nil
	if self.deletedProfiles[ name ] then return end

	local command
	command = menu.action(self.recycleBin, name, {}, trans.ClickToRestore, function()
		self:save(profile, true)
		menu.delete(command)
		self.deletedProfiles[name] = nil
	end)

	local filePath = self.dir .. name .. ".json"
	os.remove(filePath)
	self.deletedProfiles[name] = true
end



function ProfileManager:isAnyProfileEnabled()
	return self.activeProfile ~= nil
end


function ProfileManager:disableSpoofing()
	if not self.activeProfile then return end
	local spoofing = menu.ref_by_path("Online>Spoofing", 33)
	if self.activeProfile:isFlagOn(ProfileFlag_SpoofName) then
		local spoofName = menu.ref_by_rel_path(spoofing, "Name Spoofing>Name Spoofing")
		if menu.get_value(spoofName) ~= 0 then menu.trigger_command(spoofName, "off") end
	end

	if self.activeProfile:isFlagOn(ProfileFlag_SpoofRId) then
		local spoofRId = menu.ref_by_rel_path(spoofing, "RID Spoofing>RID Spoofing")
		if menu.get_value(spoofRId) ~= 0 then menu.trigger_command(spoofRId, "off") end
	end

	if self.activeProfile:isFlagOn(ProfileFlag_SpoofCrew) then
		local spoofCrew = menu.ref_by_rel_path(spoofing, "Crew Spoofing>Crew Spoofing")
		if menu.get_value(spoofCrew) ~= 0 then menu.trigger_command(spoofCrew, "off") end
	end

	if self.activeProfile:isFlagOn(ProfileFlag_SpoofIp) then
		local ipSpoofing = menu.ref_by_rel_path(spoofing, "IP Address Spoofing>IP Address Spoofing")
		if menu.get_value(ipSpoofing) ~= 0 then menu.trigger_command(ipSpoofing, "off") end
	end
	self.activeProfile = nil
end


function ProfileManager:load()
	local count = 0
	for _, path in ipairs(filesystem.list_files(self.dir)) do
		local filename, ext = string.match(path, '^.+\\(.+)%.(.+)$')
		if ext ~= "json" then
			os.remove(path)
			goto LABEL_CONTINUE
		end

		local ok, result = json.parse(path, false)
		if not ok then
			notification(result, HudColour.red)
			goto LABEL_CONTINUE
		end

		local valid, errmsg = Profile.isValid(result)
		if not valid then
			notification(trans.InvalidProfile, HudColour.red, filename, errmsg)
			goto LABEL_CONTINUE
		end

		local profile = Profile.new(result)
		self:add(filename, profile)
		count = count + 1

	::LABEL_CONTINUE::
	end
	util.log("已加载虚假配置文件: %d", count)
end


util.log("虚假配置文件已初始化")



function memoryScan(name, pattern, callback)
	local address = memory.scan(pattern)
	assert(address ~= NULL, "内存扫描失败： " .. name)
	callback(address)
	util.log("成功找到内存 %s", name)
end


memoryScan("GetNetGamePlayer", "48 83 EC ? 33 C0 38 05 ? ? ? ? 74 ? 83 F9", function (address)
	GetNetGamePlayer_addr = address
end)

function GetNetGamePlayer(player)
	return util.call_foreign_function(GetNetGamePlayer_addr, player)
end

---@param addr integer
---@return string
function read_net_address(addr)
	local fields = {}
	for i = 3, 0, -1 do table.insert(fields, memory.read_ubyte(addr + i)) end
	return table.concat(fields, ".")
end

function get_external_ip(player)
	local netPlayer = GetNetGamePlayer(player)
	if netPlayer == NULL then
		return nil
	end
	local CPlayerInfo = memory.read_long(netPlayer + 0xA0)
	if CPlayerInfo == NULL then
		return nil
	end
	local netPlayerData = CPlayerInfo + 0x20
	local netAddress = read_net_address(netPlayerData + 0x4C)
	return netAddress
end
local profilesList <const> = ProfileManager.new(menu.my_root())

function playerspooffile(PlayerID)
    local profile = Profile.get_profile_from_player(PlayerID)
    if profilesList:includes(profile) then
        return notification("配置文件已存在", HudColour.pink)
    end
    profilesList:save(profile, true)
    notification("配置文件已存在", colors.pink)
end

-----------------------------------
 -- LABELS
 -----------------------------------	
 
 local customLabels <const> =
 {
	 EnterFileName = "输入文件名",
	 InvalidChar = "无效字符输入，请重试",
	 EnterValue = "输入值",
	 ValueMustBeNumber = "该值必须是数字，请重试",
	 Search = "输入要搜索的类型"
 }
 
 for key, text in pairs(customLabels) do
	 customLabels[key] = util.register_label(text)
 end
 
 -----------------------------------
 -- PEDS LIST
 -----------------------------------
 
attackerList = {
	 ["Prisoner (Muscular)"] = "s_m_y_prismuscl_01",
	 ["Mime Artist"] = "s_m_y_mime",
	 ["Movie Astronaut"] = "s_m_m_movspace_01",
	 ["SWAT"] = "s_m_y_swat_01",
	 ["Ballas Ganster"] = "g_m_y_ballaorig_01",
	 ["Marine"]= "csb_ramp_marine",
	 ["Cop Female"] = "s_f_y_cop_01",
	 ["Cop Male"] = "s_m_y_cop_01",
	 ["Jesus"] = "u_m_m_jesus_01",
	 ["Zombie"] = "u_m_y_zombie_01",
	 ["Avon Juggernaut"] = "u_m_y_juggernaut_01",
	 ["Clown"] = "s_m_y_clown_01",
	 ["Hooker"] = "s_f_y_hooker_02",
	 ["Altruist"] = "a_m_y_acult_01",
	 ["Fireman Male"] = "s_m_y_fireman_01",
	 ["Bigfoot"] = "ig_orleans",
	 ["Mariachi"] = "u_m_y_mani",
	 ["Priest"] = "ig_priest",
	 ["Transvestite Male"] = "a_m_m_tranvest_01",
	 ["General Fat Male"] = "a_m_m_genfat_01",
	 ["Grandma"] = "a_f_o_genstreet_01",
	 ["Bouncer"] = "s_m_m_bouncer_01",
	 ["High Security"] = "s_m_m_highsec_02",
	 ["Maid"] = "s_f_m_maid_01",
	 ["Juggalo Female"] = "a_f_y_juggalo_01",
	 ["Beach Female"] = "a_f_m_beach_01",
	 ["Beverly Hills Female"] = "a_f_m_bevhills_01",
	 ["Hipster"] = "ig_ramp_hipster",
	 ["Hipster Female"] = "a_f_y_hipster_01",
	 ["FIB Agent"] = "mp_m_fibsec_01",
	 ["Female Baywatch"] = "s_f_y_baywatch_01",
	 ["Franklyn"] = "player_one",
	 ["Trevor"] = "player_two",
	 ["Michael"] = "player_zero",
	 ["Pogo the Monkey"] = "u_m_y_pogo_01",
	 ["Space Ranger"] = "u_m_y_rsranger_01",
	 ["Stone Man"] = "s_m_m_strperf_01",
	 ["Street Art Male"] = "u_m_m_streetart_01",
	 ["Impotent Rage"] = "u_m_y_imporage",
	 ["Mechanic"] = "s_m_y_xmech_02",
 }
 
 ---@class ModelList
 ModelList =
 {
	 reference = 0,
	 default = nil,
	 name = "",
	 command = "",
	 ---@type fun(caption: string, model: string)?
	 onClick = nil,
	 changeName = false,
	 ---@type table
	 options = {},
	 foundOpts = {},
 }
 ModelList.__index = ModelList
 
 ---@param parent integer
 ---@param name string
 ---@param command string
 ---@param helpText string
 ---@param tbl table
 ---@param onClick? fun(caption: string, model: string)
 ---@param changeName boolean #If the list's name will change to show the selected model.
 ---@param searchOpt boolean
 ---@return ModelList
 function ModelList.new(parent, name, command, helpText, tbl, onClick, changeName, searchOpt)
	 local self = setmetatable({}, ModelList)
	 self.name = name
	 self.command = command
	 self.onClick = onClick
	 self.changeName = changeName
	 self.foundOpts = {}
	 self.options = tbl
	 self.reference = menu.list(parent, name, {self.command}, helpText or "")
 
	 if searchOpt then
		 self:createSearchList(self.reference, "搜索")
	 end
 
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
 
 
 ---@param parent integer
 ---@param caption string
 ---@param model string
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
 
 
 ---@param parent integer
 ---@param tbl table<string, string>
 ---@param outReferences integer[]?
 function ModelList:addSection(parent, tbl, outReferences)
	 for caption, name in pairs_by_keys(tbl) do
		 local reference = self:addOpt(parent, caption, name)
		 if outReferences then table.insert(outReferences, reference) end
	 end
 end
 
 
 ---@param parent integer
 ---@param menu_name string
 function ModelList:createSearchList(parent, menu_name)
	 local reference = menu.list(parent, menu_name, {}, "")
 
	 menu.action(reference, menu_name, {}, "", function (click)
		 if (CLICK_FLAG_AUTO & click) ~= 0 then
			 return
		 end
 
		 for _, reference in ipairs(self.foundOpts) do
			 menu.delete(reference)
			 self.foundOpts = {}
		 end
 
		 local text = get_input_from_screen_keyboard(customLabels.Search, 20, "")
		 if text == "" then
			 return
		 else
			 text = string.lower(text)
		 end
 
		 for caption, value in pairs(self.options) do
			 if type(value) == "string" then
				 if string.lower(caption):find(text) or value:find(text) then
					 local opt = self:addOpt(reference, caption, value)
					 table.insert(self.foundOpts, opt)
				 end
 
			 elseif type(value) == "table" then
				 local tbl = value
				 local matches = self.getSectionMatches(caption, text, tbl)
				 self:addSection(reference, matches, self.foundOpts)
			 end
		 end
	 end)
 end
 
 
 ---@param section string
 ---@param find string
 ---@param tbl table<string, string>
 ---@return table
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
 
 ---@class WeaponList
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
 
 Wardrobe = {
	 reference = 0,
	 components = {},
	 props = {}
 }
 Wardrobe.__index = Wardrobe
 
 
 local components <const> = {
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
	 if ENTITY.DOES_ENTITY_EXIST(self.handle) and request_control(self.handle, 1000) then
		 entities.delete_by_handle(self.handle); self.handle = 0
	 end
 end
 

 
 function Member:createMgr(parent, name)
	 self.mgr = menu.list(parent, name, {}, "", function ()
		 self.isMgrOpen = true
	 end, function ()
		 self.isMgrOpen = false
	 end)
 
	 self.references = {}
	 if not IsPedAnyAnimal(self.handle) then
		 WeaponList.new(self.mgr, trans.Weapon, "", "", function (caption, model)
			 local hash <const> = util.joaat(model)
			 self:giveWeapon(hash); self.weaponHash = hash
		 end, true)
	 end
 
	 self.references.invincible = menu.toggle(self.mgr, trans.Invincible, {}, "", function (on)
		 request_control(self.handle, 1000)
		 ENTITY.SET_ENTITY_INVINCIBLE(self.handle, on)
		 ENTITY.SET_ENTITY_PROOFS(self.handle, on, on, on, on, on, on, on, on)
	 end)
 
	 self.references.teleport = menu.action(self.mgr, trans.TpToMe, {}, "", function ()
		 request_control(self.handle, 1000)
		 if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
			 self:tpToLeader()
		 else
			 local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
			 self:tpToVehicle(vehicle)
		 end
	 end)
 
	 menu.action(self.mgr, trans.Save, {}, "", function()
		 local ok, errmsg = self:save()
		 if not ok then notification(errmsg, HudColour.red) return end
		 notification(trans.BodyguardSaved, colors.blue)
	 end)
 
	 self.wardrobe = Wardrobe.new(self.mgr, trans.Appearance, {}, "", self.handle)
 
	 menu.action(self.mgr, trans.Delete, {}, "",  function ()
		 self:delete() self:removeMgr()
	 end)
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
	 local label = customLabels.EnterFileName
	 while true do
		 input = get_input_from_screen_keyboard(label, 31, "")
		 if input == "" then
			 return false, trans.SaveCanceled
		 end
 
		 if not input:find '[^%w_%.%-]' then break end
		 label = customLabels.InvalidChar
		 util.yield(250)
	 end
	 local path = GTDir .. "bodyguards\\" .. input .. ".json"
	 local file, errmsg = io.open(path, "w")
	 if not file then
		 return false, errmsg
	 end
	 file:write(json.stringify(self:getInfo(), nil, 0, false))
	 file:close()
	 return true
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
 local Formation <const> =
 {
	 freedomToMove = 0,
	 circleAroundLeader = 1,
	 line = 3,
	 arrow = 4,
 }
 
 Group =
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
		 if ENTITY.DOES_ENTITY_EXIST(ped) and
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
		 if ENTITY.DOES_ENTITY_EXIST(ped) and
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
 
		 if not ENTITY.DOES_ENTITY_EXIST(ped) or PED.IS_PED_INJURED(ped) then
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
		 if ENTITY.DOES_ENTITY_EXIST(ped) and
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

relationship = {}
function relationship:friendly(ped)
    if not PED._DOES_RELATIONSHIP_GROUP_EXIST(self.friendly_group) then
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

----- 保镖马东锡 -----
local bodyguard_veh_options = menu.list(self.ref, "马东锡的护法", {}, "100%原创功能,感受拥有保镖的乐趣")

local veh_list = {}
local veh_ped_list = {}

local bodyguard_veh = {
    name = "stretch",
    veh_godmode = false,
    ped_godmode = true
}

local sel_veh_name_list = { "加长礼车", "FBI巡逻车", "奔驰迈巴赫", "限量版大G", "RR幻影", "宾利", "RR魅影" }
local sel_veh_model_list = { "stretch", "fbi2", "cognoscenti2", "dubsta2", "superd", "deity", "windsor2" }
menu.slider_text(bodyguard_veh_options, "生成的载具类型", {}, "您需要单击以更改", sel_veh_name_list, function(value)
    bodyguard_veh.name = sel_veh_model_list[value]
end)

menu.toggle(bodyguard_veh_options, "载具是否无敌", {}, "", function(toggle)
    bodyguard_veh.veh_godmode = toggle
end)

menu.action(bodyguard_veh_options, "立即召唤马东锡!!!", {}, "若保镖没有跟随您,那么请您重新生成\n\n<建议>: 禁用交通\n\n这是由于Stand的API: [TASK_VEHICLE_FOLLOW]十分乐色:)", function()
    local veh_hash = util.joaat(bodyguard_veh.name)
    local ped_hash = util.joaat("s_m_y_blackops_01")
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    pos.x = pos.x + math.random(-8, 8)
    pos.y = pos.y + math.random(-8, 8)
    pos.z = pos.z + 0

	requestModels(ped_hash, veh_hash)
    relationship:friendly(players.user_ped())
    veh = entities.create_vehicle(veh_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)

	if not ENTITY.DOES_ENTITY_EXIST(veh) then
        util.toast("创建车辆失败,可能因为触发了Stand实体控制器")
        return
		else
		vehNetId = NETWORK.VEH_TO_NET(veh)
        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(NETWORK.NET_TO_PED(vehNetId)) then
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(vehNetId, true)
        end
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(vehNetId, players.user(), true)
        VEHICLE.SET_VEHICLE_ENGINE_ON(veh, true, true, true)
		VEHICLE.SET_VEHICLE_SEARCHLIGHT(veh, true, true)
        addBlipForEntity(veh, 1, 27)
		--血量
		WIRI_ENTITY.SET_ENTITY_INVINCIBLE(veh, bodyguard_veh.veh_godmode)
		WIRI_ENTITY.SET_ENTITY_MAX_HEALTH(veh, 10000)
		WIRI_ENTITY.SET_ENTITY_HEALTH(veh, 10000)

		table.insert(veh_list, veh)
		end

		pilot = entities.create_ped(29, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
		PED.SET_PED_INTO_VEHICLE(pilot, veh, -1)
		PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pilot, true)
		--跟随
		TASK.TASK_VEHICLE_FOLLOW(pilot, veh, players.user_ped(), 80, 1, 10, 10)
		PED.SET_PED_KEEP_TASK(pilot, true)
		--血量
		PED.SET_PED_MAX_HEALTH(pilot, 1000)
		ENTITY.SET_ENTITY_HEALTH(pilot, 1000)
		ENTITY.SET_ENTITY_INVINCIBLE(pilot, bodyguard_veh.ped_godmode)

		relationship:friendly(ped)
		relationship:friendly(pilot)

		table.insert(veh_ped_list, veh)
    
		--local seats = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(heli)
		for seat = 0, 2 do
		ped = entities.create_ped(29, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
		pedNetId = NETWORK.PED_TO_NET(ped)
		if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(ped) then
		NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(pedNetId, true)
		end
		NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(pedNetId, players.user(), true)
		PED.SET_PED_INTO_VEHICLE(ped, veh, seat)
		--战斗
		WEAPON.GIVE_WEAPON_TO_PED(ped, util.joaat("weapon_mg"), -1, false, true)
        WEAPON.SET_PED_INFINITE_AMMO_CLIP(ped, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 3, false)
        PED.SET_PED_COMBAT_MOVEMENT(ped, 2)
        PED.SET_PED_COMBAT_ABILITY(ped, 2)
        PED.SET_PED_COMBAT_RANGE(ped, 2)
        PED.SET_PED_SEEING_RANGE(ped, 500.0)
        PED.SET_PED_HEARING_RANGE(ped, 500.0)
        PED.SET_PED_TARGET_LOSS_RESPONSE(ped, 1)
        PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
        PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(ped, 500.0)
        PED.SET_COMBAT_FLOAT(ped, 10, 500.0)
        PED.SET_PED_SHOOT_RATE(ped, 1000.0)
        PED.SET_PED_ACCURACY(ped, 100.0)
        PED.SET_PED_CAN_BE_SHOT_IN_VEHICLE(ped, true)
        --血量
        PED.SET_PED_MAX_HEALTH(ped, 1000)
        ENTITY.SET_ENTITY_HEALTH(ped, 1000)
        ENTITY.SET_ENTITY_INVINCIBLE(ped, bodyguard_veh.ped_godmode)

		PED.SET_PED_KEEP_TASK(ped, true)

		relationship:friendly(pilot)
        relationship:friendly(ped)

        table.insert(veh_ped_list, ped)
    end

    --STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_hash)
    --STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)
end)

menu.action(bodyguard_veh_options, "保镖下车", {}, "让一位保镖从车里下来", function ()
	for seat = 0, 32 do
		TASK.TASK_LEAVE_VEHICLE(ped, veh, seat)
	end
end)

menu.action(bodyguard_veh_options, "移除所有护法", {}, "#删除所有保镖与保镖载具\n#这项功能同样可以删除迷路的护法", function()
    for k, ent in pairs(veh_ped_list) do
        entities.delete_by_handle(ent)
    end
    for k, ent in pairs(veh_list) do
        entities.delete_by_handle(ent)
    end
	for k, ent in pairs(veh_ped_list) do
    entities.delete_by_handle(pilot)
	end
end)

menu.action(bodyguard_veh_options, "超级清除", {}, "", function ()
	menu.trigger_commands("superc")
end)

----- 保镖直升机 -----
local bodyguard_heli_options = menu.list(self.ref, "保镖直升机", {}, "")

local heli_list = {} --生成的直升机
local heli_ped_list = {} --直升机内的保镖

local bodyguard_heli = {
    name = "buzzard",
    heli_godmode = false,
    ped_godmode = false
}

local sel_heli_name_list = { "秃鹰", "女武神", "猎杀者", "野蛮人" }
local sel_heli_model_list = { "buzzard", "valkyrie", "hunter", "savage" }
menu.slider_text(bodyguard_heli_options, "直升机类型", {}, "", sel_heli_name_list, function(value)
    bodyguard_heli.name = sel_heli_model_list[value]
end)

menu.toggle(bodyguard_heli_options, "直升机无敌", {}, "", function(toggle)
    bodyguard_heli.heli_godmode = toggle
end)

menu.action(bodyguard_heli_options, "生成保镖直升机", {}, "", function()
    local heli_hash = util.joaat(bodyguard_heli.name)
    local ped_hash = util.joaat("s_m_y_blackops_01")
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    pos.x = pos.x + math.random(-10, 10)
    pos.y = pos.y + math.random(-10, 10)
    pos.z = pos.z + 30

    requestModels(ped_hash, heli_hash)
    relationship:friendly(players.user_ped())
    local heli = entities.create_vehicle(heli_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)

    if not ENTITY.DOES_ENTITY_EXIST(heli) then
        util.toast("创建载具失败,可能因为触发了Stand实体控制器")
        return
    else
        local heliNetId = NETWORK.VEH_TO_NET(heli)
        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(NETWORK.NET_TO_PED(heliNetId)) then
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(heliNetId, true)
        end
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(heliNetId, players.user(), true)
        VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, true)
        VEHICLE.SET_HELI_BLADES_FULL_SPEED(heli)
        VEHICLE.SET_VEHICLE_SEARCHLIGHT(heli, true, true)
        addBlipForEntity(heli, 422, 26)
        --health
        WIRI_ENTITY.SET_ENTITY_INVINCIBLE(heli, bodyguard_heli.heli_godmode)
        WIRI_ENTITY.SET_ENTITY_MAX_HEALTH(heli, 10000)
        WIRI_ENTITY.SET_ENTITY_HEALTH(heli, 10000)

        table.insert(heli_list, heli)
    end

    local pilot = entities.create_ped(29, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    PED.SET_PED_INTO_VEHICLE(pilot, heli, -1)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pilot, true)
    TASK.TASK_HELI_MISSION(pilot, heli, 0, players.user_ped(), 0.0, 0.0, 0.0, 23, 80.0, 50.0, -1.0, 0, 10, -1.0, 0)
    PED.SET_PED_KEEP_TASK(pilot, true)
    --health
    PED.SET_PED_MAX_HEALTH(pilot, 1000)
    ENTITY.SET_ENTITY_HEALTH(pilot, 1000)
    ENTITY.SET_ENTITY_INVINCIBLE(pilot, bodyguard_heli.ped_godmode)

    table.insert(heli_ped_list, pilot)

    --local seats = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(heli)
    for seat = 0, 2 do
        local ped = entities.create_ped(29, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
        local pedNetId = NETWORK.PED_TO_NET(ped)
        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(ped) then
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(pedNetId, true)
        end
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(pedNetId, players.user(), true)
        PED.SET_PED_INTO_VEHICLE(ped, heli, seat)
        --fight
        WEAPON.GIVE_WEAPON_TO_PED(ped, util.joaat("weapon_mg"), -1, false, true)
        WEAPON.SET_PED_INFINITE_AMMO_CLIP(ped, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 3, false)
        PED.SET_PED_COMBAT_MOVEMENT(ped, 2)
        PED.SET_PED_COMBAT_ABILITY(ped, 2)
        PED.SET_PED_COMBAT_RANGE(ped, 2)
        PED.SET_PED_SEEING_RANGE(ped, 500.0)
        PED.SET_PED_HEARING_RANGE(ped, 500.0)
        PED.SET_PED_TARGET_LOSS_RESPONSE(ped, 1)
        PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
        PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(ped, 500.0)
        PED.SET_COMBAT_FLOAT(ped, 10, 500.0)
        PED.SET_PED_SHOOT_RATE(ped, 1000.0)
        PED.SET_PED_ACCURACY(ped, 100.0)
        PED.SET_PED_CAN_BE_SHOT_IN_VEHICLE(ped, true)
        --health
        PED.SET_PED_MAX_HEALTH(ped, 1000)
        ENTITY.SET_ENTITY_HEALTH(ped, 1000)
        ENTITY.SET_ENTITY_INVINCIBLE(ped, bodyguard_heli.ped_godmode)

        relationship:friendly(ped)

        table.insert(heli_ped_list, ped)
    end

    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(heli_hash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)
end)

menu.action(bodyguard_heli_options, "删除所有保镖直升机", {}, "", function()
    for k, ent in pairs(heli_ped_list) do
        entities.delete_by_handle(ent)
    end
    for k, ent in pairs(heli_list) do
        entities.delete_by_handle(ent)
    end
end)
---
	 ModelList.new(self.ref, "生成", "spawnbg", "", PedList, function (caption, model)
		 if self.group:getSize() >= 7 then
			 return notification(trans.ReachedMaxNumBodyguards, HudColour.red)
		 end
		 local modelHash <const> = util.joaat(model)
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
 
	 menu.action(self.ref, "克隆我自己", {"clonebg"}, "", function ()
		 if self.group:getSize() >= 7 then
			 return notification(trans.ReachedMaxNumBodyguards, HudColour.red)
		 end
		 local member = Member:createMember()
		 self.group:pushMember(member)
		 local weaponHash = self.group.defaults.weaponHash
		 if IsPedAnyAnimal(member.handle) then
			 weaponHash = util.joaat("weapon_animal")
		 end
		 member:giveWeapon(weaponHash)
		 member:createMgr(self.ref, trans.Clone)
		 if self.group.defaults.invincible then member:setInvincible(true) end
	 end)
 
	 local saved = FilesList.new(self.ref, "已保存的", GTDir .. "bodyguards", "json")
 
	 saved:addSubOpt("生成", function(name, ext, path)
		 if self.group:getSize() >= 7 then
			 return notification(trans.ReachedMaxNumBodyguards, HudColour.red)
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
			 notification(trans.InvalidOutfit, HudColour.red, name, errmsg)
		 end
 
		 member:giveWeapon(weaponHash)
		 member:createMgr(self.ref, name)
		 if self.group.defaults.invincible then member:setInvincible(true) end
	 end)
 
	 saved:addSubOpt("删除文件", function (name, ext, path)
		 local ok, errmsg = os.remove(path)
		 if not ok then return notification(errmsg, HudColour.red) end
		 saved:reload()
	 end)
 
	 self:createCommands(self.ref)
	 self.divider = menu.divider(self.ref, "已生成的保镖")
	 for _, member in ipairs(self.group.members) do
		 if member.mgr == 0 then member:createMgr(self.ref, trans.Unknown) end
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
	 menu.slider_text(list, "小组编队", {"groupformation"}, "", formations, function (index)
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
 
	 local relGroups <const> =
	 {
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
	 menu.list_select(list, menuName, {"rg"}, helpText, relGroups, 7, function(opt)
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
 
	 menu.action(list, "删除成员", {"cleargroup"}, "", function()
		 self.group:deleteMembers()
	 end)
	 menu.action(list, "传送成员到我", {"tpmembers"}, "", function()
		 self.group:teleport()
	 end)
	 menu.toggle(list, "无敌的", {"groupgodmode"}, "", function(on)
		 self.group:setInvincible(on)
	 end)
	 WeaponList.new(list, "默认武器", "groupgun", "", function(caption, model)
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




util.on_stop(function()
	if  profilesList:isAnyProfileEnabled() then
		profilesList:disableSpoofing()
		util.log("Active spoofing profile disabled due to script stop")
	end
end)