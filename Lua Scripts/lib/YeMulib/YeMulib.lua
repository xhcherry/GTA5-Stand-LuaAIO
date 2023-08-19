-------------------------------------------------------欢迎使用夜幕Lua-----------------------------------------------------------------
-------------------------------------------------------夜幕Lua的制作仅供学习，不与任何其他Lua作者有矛盾--------------------------------
-------------------------------------------------------夜幕Lua的代码并非所有都是夜幕工作室制作--------------------
--分享使用请标明出处 否则无妈！！！
--未经允许私自改名者更无妈！！！
--要是想当个孤儿就当我没说！！！
--===========================================================================================================================(夜幕Lua纯免费，任何收费的都是无妈仔)
local new = {}
local colors = {
green = 184,
red = 6,
yellow = 190,
black = 2,
white = 1,
gray = 3,
pink = 190,
purple = 49, 
blue = 11
}
function notification(message, color)
	HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(color)
	local picture = "CHAR_SOCIAL_CLUB"
	GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(picture, 0)
	while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(picture) do
		util.yield()
	end
	util.BEGIN_TEXT_COMMAND_THEFEED_POST(message)
	title = "夜幕LUA"
	if color == colors.red or color == colors.red then
        subtitle = "~u~用户" .. players.get_name(players.user()) .. "&#8721;"
	elseif color == colors.black then
        subtitle = "~c~用户" .. players.get_name(players.user()) .. "&#8721;"
	else
        subtitle = "~u~用户" .. players.get_name(players.user()) .. "&#8721;"
	end
	HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(picture, picture, true, 5, title, subtitle)
	HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
	util.log(message)
end

local menuAction = menu.action
local menuToggle = menu.toggle
local menuToggleLoop = menu.toggle_loop
local joaat = util.joaat
local wait = util.yield


local createPed = PED.CREATE_PED
local getEntityCoords = ENTITY.GET_ENTITY_COORDS
local getPlayerPed = PLAYER.GET_PLAYER_PED
local requestModel = STREAMING.REQUEST_MODEL
local hasModelLoaded = STREAMING.HAS_MODEL_LOADED
local noNeedModel = STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED
local setPedCombatAttr = PED.SET_PED_COMBAT_ATTRIBUTES
local giveWeaponToPed = WEAPON.GIVE_WEAPON_TO_PED

WhiteText = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}


--加载配置
local selected_lang_path = filesystem.scripts_dir() .. 'lib/YeMulib/YMConfig/Config.lua'
if filesystem.exists(selected_lang_path) then
    require "lib.YeMulib.YMConfig.Config"
    util.log("[夜幕提示] 配置已加载")
else
    util.toast("未找到夜幕配置文件,请重新安装")
    util.stop_script()
end
------------------------------------------------
--保存配置
function save_config()
    local notification = b_notifications.new()
    notification.notify("[夜幕提示]","配置已保存！")
    local config_txt = 
        "--[夜幕Lua配置]"..
        "\nconfig_active1 = "..menu.get_value(host_s)..         ------------主机序列
        "\nconfig_active1_x = "..menu.get_value(host_sequence_x)..         ------------主机序列x坐标
        "\nconfig_active1_y = "..menu.get_value(host_sequence_y)..         ------------主机序列y坐标
        "\nconfig_active2 = "..menu.get_value(show_time)..             ------------显示时间
        "\nconfig_active2_x = "..menu.get_value(show_time_x)..         ------------时间x坐标
        "\nconfig_active2_y = "..menu.get_value(show_time_y)..         ------------时间y坐标
        "\nconfig_active3 = "..menu.get_value(script_name)..           ------------显示脚本名称
        "\nconfig_active4 = "..menu.get_value(obj_num)..         -----------实体池信息
        "\nconfig_active5 = "..menu.get_value(ridicule)..           -----------攻击嘲讽
        "\nconfig_active6 = "..menu.get_value(kongzhitai1)..         -----------绘制控制台
        "\nconfig_active7 = "..menu.get_value(shisubiao)..         -----------游戏转速表
        "\nconfig_active8 = "..menu.get_value(players_info)..         -----------玩家信息栏
        "\nconfig_active9 = "..menu.get_value(haiba)..         -----------海拔高度计
        "\nconfig_active10 = "..menu.get_value(shudu)..         -----------驾驶速度
        "\nconfig_active11 = "..menu.get_value(naijiu)..        -----------耐久
        "\nconfig_active12 = "..menu.get_value(Watchdogs)        -----------看门狗V2

    local file = io.open(selected_lang_path, 'w')
    file:write(config_txt)
    file:close()
end
----newTimer
function newTimer()
	local self = {start = util.current_time_millis()}
	local function reset()
		self.start = util.current_time_millis()
	end
	local function elapsed()
		return util.current_time_millis() - self.start
	end
	return
	{
		reset = reset,
		elapsed = elapsed
	}
end
timer = newTimer()
Effect = {asset = "", name = "", scale = 1.0}
Effect.__index = Effect
function Effect.new(asset, name, scale)
	local inst = setmetatable({}, Effect)
	inst.name = name
	inst.asset = asset
	inst.scale = scale
	return inst
end
function draw_string(s, x, y, scale, font)
	HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
	HUD.SET_TEXT_FONT(font or 0)
	HUD.SET_TEXT_SCALE(scale, scale)
	HUD.SET_TEXT_DROP_SHADOW()
	HUD.SET_TEXT_WRAP(0.0, 1.0)
	HUD.SET_TEXT_DROPSHADOW(1, 0, 0, 0, 0)
	HUD.SET_TEXT_OUTLINE()
	HUD.SET_TEXT_EDGE(1, 0, 0, 0, 0)
	HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(s)
	HUD.END_TEXT_COMMAND_DISPLAY_TEXT(x, y)
end
function new.colour(R, G, B, A)
    return {r = R / 255, g = G / 255, b = B / 255, a = A or 1}
end
function xuancaipm(on)
    local a_toggle = menu.ref_by_path('World>Aesthetic Light>Aesthetic Light')
    if on then 
        menu.trigger_commands("shader glasses_purple")
        menu.trigger_commands("aestheticcolourred 255")
        menu.trigger_commands("aestheticcolourgreen 0")
        menu.trigger_commands("aestheticcolourblue 255")
        menu.trigger_commands("aestheticrange 10000")
        menu.trigger_commands("aestheticintensity 30")
        menu.trigger_commands("time 0")
        menu.set_value(a_toggle, true)
    else
        menu.set_value(a_toggle, false)
        menu.trigger_commands("shader off")
    end
end

function get_waypoint_v3()
    if HUD.IS_WAYPOINT_ACTIVE() then
        local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
        local waypoint_pos = HUD.GET_BLIP_COORDS(blip)

        local success, Zcoord = util.get_ground_z(waypoint_pos.x, waypoint_pos.y)
        local tries = 0
        while not success or tries <= 100 do
            success, Zcoord = util.get_ground_z(waypoint_pos.x, waypoint_pos.y)
            tries += 1
            util.yield_once()
        end
        if success then
            waypoint_pos.z = Zcoord
        end

        return waypoint_pos
    else
        util.toast("没标点还玩个寄吧？")
    end
end
function request_model(model)
	if STREAMING.IS_MODEL_VALID(model) and not STREAMING.HAS_MODEL_LOADED(model) then
		STREAMING.REQUEST_MODEL(model)
		while not STREAMING.HAS_MODEL_LOADED(model) do
			util.yield()
		end
	end
end
function executeNuke(pos)
    for a = 0, 100, 4 do
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z + a, 8, 10.0, true, false, 1.0, false)
        util.yield(50)
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z , 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
end
function Streament(hash) --Streaming Model
    STREAMING.REQUEST_MODEL(hash)
    while STREAMING.HAS_MODEL_LOADED(hash) ==false do
    util.yield()
    end
end
local function executeNuke(pos)
    for a = 0, nuke_height, 4 do
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z + a, 8, 10, true, false, 1, false)
        util.yield(50)
    end
    FIRE.ADD_EXPLOSION(pos.x +8, pos.y +8, pos.z + nuke_height, 82, 10, true, false, 1, false)
    FIRE.ADD_EXPLOSION(pos.x +8, pos.y -8, pos.z + nuke_height, 82, 10, true, false, 1, false)
    FIRE.ADD_EXPLOSION(pos.x -8, pos.y +8, pos.z + nuke_height, 82, 10, true, false, 1, false)
    FIRE.ADD_EXPLOSION(pos.x -8, pos.y -8, pos.z + nuke_height, 82, 10, true, false, 1, false)
end
function request_control_once(entity)
	if not NETWORK.NETWORK_IS_IN_SESSION() then
		return true
	end
	local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
	NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
	return NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
end
function request_control(entity, timeOut)
	if not ENTITY.DOES_ENTITY_EXIST(entity) then
		return false
	end
	timeOut = timeOut or 500
	local start = newTimer()
	while not request_control_once(entity) and start.elapsed() < timeOut do
		util.yield_once()
	end
	return start.elapsed() < timeOut
end
function RqModel (hash)
    STREAMING.REQUEST_MODEL(hash)
    local count = 0
    util.toast("正在请求模型...")
    while not STREAMING.HAS_MODEL_LOADED(hash) and count < 100 do
        STREAMING.REQUEST_MODEL(hash)
        count = count + 1
        util.yield(10)
    end
    if not STREAMING.HAS_MODEL_LOADED(hash) then
        util.toast("已尝试1秒,无法加载此指定模型!")
    end
end
----崩溃function
function CreateVehicle(Hash, Pos, Heading, Invincible)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_vehicle(Hash, Pos, Heading)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    if Invincible then
        ENTITY.SET_ENTITY_INVINCIBLE(SpawnedVehicle, true)
    end
    return SpawnedVehicle
end
function CreatePed(index, Hash, Pos, Heading)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_ped(index, Hash, Pos, Heading)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    return SpawnedVehicle
end
function CreateObject(Hash, Pos, static)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_object(Hash, Pos)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    if static then
        ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicle, true)
    end
    return SpawnedVehicle
end
function juqishoulai()
    if PAD.IS_CONTROL_PRESSED(1, 323) then
                    while not STREAMING.HAS_ANIM_DICT_LOADED("random@mugging3") do
                        STREAMING.REQUEST_ANIM_DICT("random@mugging3")
                        util.yield(100)
                    end
                    if not ENTITY.IS_ENTITY_PLAYING_ANIM(PLAYER.PLAYER_PED_ID(), "random@mugging3", "handsup_standing_base", 3) then
                        WEAPON.SET_CURRENT_PED_WEAPON(PLAYER.PLAYER_PED_ID(), MISC.GET_HASH_KEY("WEAPON_UNARMED"), true)
                        TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "random@mugging3", "handsup_standing_base", 3, 3, -1, 51, 0, false, false, false)
                        STREAMING.REMOVE_ANIM_DICT("random@mugging3")
                        PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), true)
                    end
                end
                if PAD.IS_CONTROL_RELEASED(1, 323) and ENTITY.IS_ENTITY_PLAYING_ANIM(PLAYER.PLAYER_PED_ID(), "random@mugging3", "handsup_standing_base", 3) then
                    TASK.CLEAR_PED_SECONDARY_TASK(PLAYER.PLAYER_PED_ID())
                    PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), false)
                end
    end

    b_notifications = {}
b_notifications.new = function ()
    local self = {}

    local active_notifs = {}
    self.notif_padding = 0.01
    self.notif_text_size = 0.7
    self.notif_title_size = 0.8
    self.notif_spacing = 0.3
    self.notif_width = 0.2
    self.notif_flash_duration = 3
    self.notif_anim_speed = 3
    self.notif_banner_colour = {r = 9, g = 0, b = 1, a = 9}
    self.notif_flash_colour = {r = 0.5, g = 0.0, b = 0.5, a = 1}
    self.max_notifs = 10
    self.notif_banner_height = 0.002
    self.use_toast = false
    local split = function (input, sep)
        local t={}
        for str in string.gmatch(input, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
    end
    
    local function lerp(a, b, t)
        return a + (b - a) * t
    end
    local cut_string_to_length = function(input, length, fontSize)
        input = split(input, " ")
        local output = {}
        local line = ""
        for i, word in ipairs(input) do
            if directx.get_text_size(line..word, fontSize) >= length then
                if directx.get_text_size(word, fontSize) > length then
                    while directx.get_text_size(word , fontSize) > length do
                        local word_lenght = string.len(word)
                        for x = 1, word_lenght, 1 do
                            if directx.get_text_size(line..string.sub(word ,1, x), fontSize) > length then
                                output[#output+1] = line..string.sub(word, 1, x - 1)
                                line = ""
                                word = string.sub(word, x, word_lenght)
                                break
                            end
                        end
                    end
                else
                    output[#output+1] =  line
                    line = ""
                end
            end
            if i == #input then
                output[#output+1] = line..word
            end
            line = line..word.." "
        end
        return table.concat(output, "\n")
    end

    local draw_notifs = function ()
        local aspect_16_9 = 1.777777777777778
        util.create_tick_handler(function ()
            local total_height = 0
            local delta_time = MISC.GET_FRAME_TIME()
            for i = #active_notifs, 1, -1 do
                local notif = active_notifs[i]
                local notif_body_colour = notif.colour
                if notif.flashtimer > 0 then
                    notif_body_colour = self.notif_flash_colour
                    notif.flashtimer = notif.flashtimer - delta_time
                end
                if notif.current_y_pos == -10 then
                    notif.current_y_pos = total_height
                end
                notif.current_y_pos = lerp(notif.current_y_pos, total_height, 5 * delta_time * self.notif_anim_speed)
                if not notif.marked_for_deletetion then
                    notif.animation_state = lerp(notif.animation_state, 1, 10 * delta_time * self.notif_anim_speed)
                end
                --#region
                    directx.draw_rect(
                        1 - self.notif_width - self.notif_padding * 2,
                        0.1 - self.notif_padding * 2 * aspect_16_9 + notif.current_y_pos,
                        self.notif_width + (self.notif_padding * 2),
                        (notif.text_height + notif.title_height + self.notif_padding * 2 * aspect_16_9) * notif.animation_state,
                        notif_body_colour
                    )
                    directx.draw_rect(
                        1 - self.notif_width - self.notif_padding * 2,
                        0.1 - self.notif_padding * 2 * aspect_16_9 + notif.current_y_pos,
                        self.notif_width + (self.notif_padding * 2),
                        self.notif_banner_height * aspect_16_9 * notif.animation_state,
                        self.notif_banner_colour
                    )
                    directx.draw_text(
                        1 - self.notif_padding - self.notif_width,
                        0.1 - self.notif_padding * aspect_16_9 + notif.current_y_pos,
                        notif.title,
                        ALIGN_TOP_LEFT,
                        self.notif_title_size,
                        {r = 1 * notif.animation_state, g = 1 * notif.animation_state, b = 1 * notif.animation_state, a = 1 * notif.animation_state}
                    )
                    directx.draw_text(
                        1 - self.notif_padding - self.notif_width,
                        0.1 - self.notif_padding * aspect_16_9 + notif.current_y_pos + notif.title_height,
                        notif.text,
                        ALIGN_TOP_LEFT,
                        self.notif_text_size,
                        {r = 1 * notif.animation_state, g = 1 * notif.animation_state, b = 1 * notif.animation_state, a = 1 * notif.animation_state}
                    )
    --#endregion
                total_height = total_height + ((notif.total_height + self.notif_padding * 2 + self.notif_spacing) * notif.animation_state)
                if notif.marked_for_deletetion then
                    notif.animation_state = lerp(notif.animation_state, 0, 10 * delta_time)
                    if notif.animation_state < 0.05 then
                        table.remove(active_notifs, i)
                    end
                elseif notif.duration < 0 then
                    notif.marked_for_deletetion = true
                end
                notif.duration = notif.duration - delta_time
            end
            return #active_notifs > 0
        end)
    end

    self.notify = function (title,text, duration, colour)
        if self.use_toast then
            util.toast(title.."\n"..text)
            return
        end
        title = cut_string_to_length(title, self.notif_width, self.notif_title_size)
        text = cut_string_to_length(text, self.notif_width, self.notif_text_size)
        local x, text_heigth = directx.get_text_size(text, self.notif_text_size)
        local xx, title_height = directx.get_text_size(title, self.notif_title_size)
        local hash = util.joaat(title..text)
        local new_notification = {
            title = title,
            flashtimer = self.notif_flash_duration,
            colour = colour or {r = 0.2, g = 0.1, b = 0.3, a = 1},
            duration = duration or 3,
            current_y_pos = -10,
            marked_for_deletetion = false,
            animation_state = 0,
            text = text,
            hash = hash,
            text_height = text_heigth,
            title_height = title_height,
            total_height = title_height + text_heigth
        }
        for i, notif in ipairs(active_notifs) do
            if notif.hash == hash then
                notif.flashtimer = self.notif_flash_duration * 0.5
                notif.marked_for_deletetion = false
                notif.duration = duration or 3
                return
            end
        end
        active_notifs[#active_notifs+1] = new_notification
        if #active_notifs > self.max_notifs then
            table.remove(active_notifs, 1)
        end
        if #active_notifs == 1 then draw_notifs() end
    end

    return self
end

local mcxh=1

local mcr=255

local mcg=0

local mcb=0
function rainbow_color()
        if mcxh==1 and mcg<256 then

            HUD.SET_TEXT_COLOUR(mcr, mcg, mcb, 255)	

            if mcg == 255 then

                mcxh=2

            else

                mcg=mcg+1

            end

        elseif mcxh==2 and mcr>-1 then

            HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)

            if mcr == 0 then

                mcxh=3

            else

                mcr=mcr-1

            end

        elseif mcxh==3 and mcb<256 then

            HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)

            if mcb == 255 then

                mcxh=4

            else

                mcb=mcb+1

            end

        elseif mcxh==4 and mcg>-1 then

            HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)

            if mcg == 0 then

                mcxh=5

            else

                mcg=mcg-1

            end

        elseif mcxh==5 and mcr<256 then

            HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)

            if mcr == 255 then

                mcxh=6

            else

                mcr=mcr+1

            end

        elseif mcxh==6 and mcb>-1 then

            HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)

            if mcb == 0 then

                mcxh=1

            else

                mcb=mcb-1

            end

        end
end
local zhujixvlie_posx = config_active1_x / 1000
local zhujixvlie_posy = config_active1_y / 1000
function zhujixvlie_x(x_)
    zhujixvlie_posx = x_ / 1000
end
function zhujixvlie_y(y_)
    zhujixvlie_posy = y_ / 1000
end
--fps帧数
function fps()
end
local fps = 0
util.create_thread(function()
    while true do
        fps = math.ceil(1/SYSTEM.TIMESTEP())
        util.yield(500)
    end
end)
function scripthost()
    ------下位主机
    for pid = 0, 31 do
        nexthostxulie = players.get_host_queue_position(pid)
            if #players.list() > 1 then
                if nexthostxulie == 1 then
                    if players.get_name(pid) ~= "UndiscoveredPlayer" then
                        nexthost_name = players.get_name(pid)
                    end
                end
            else
                nexthost_name = "无"
            end
    end

    inviciamountint = 0
    for pid = 0, 31 do
        if players.exists(pid) and pid ~= players.user() then
            local pped = players.user_ped(pid)
            if pped ~= 0 then
                if players.is_marked_as_modder(pid) then
                    inviciamountint = inviciamountint + 1
                end
            end
        end
local ente

                local ent1e = players.user_ped()
                local ent2e = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
                if PED.IS_PED_IN_ANY_VEHICLE(ent1e,true) then
                    ente = ent2e
                else
                    ente = ent1e
                end
                local speede = ENTITY.GET_ENTITY_SPEED(ente)
                local speedcalce = speede * 3.6
            end
        inviciamountintt = inviciamountint
            draw_string(string.format("~bold~~o~帧数: ~b~"..fps), zhujixvlie_posx, zhujixvlie_posy + 0.005, 0.4,1)
            draw_string(string.format("~h~~y~战局玩家: ~h~~g~"..#players.list()), zhujixvlie_posx,zhujixvlie_posy + 0.035, 0.4,1) 
            draw_string(string.format("~h~~p~作弊玩家: ~h~~r~"..inviciamountintt), zhujixvlie_posx,zhujixvlie_posy + 0.07, 0.4,1) 
			if PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**" then
			draw_string(string.format("~h~~f~战局主机: ~h~~w~无"), zhujixvlie_posx,zhujixvlie_posy + 0.105, 0.4,1)
			else
            draw_string(string.format("~h~~f~战局主机: ~h~~w~"..players.get_name(players.get_host())), zhujixvlie_posx,zhujixvlie_posy + 0.105, 0.4,1)
			end
			if PLAYER.GET_PLAYER_NAME(players.get_script_host()) == "**Invalid**" then
			draw_string(string.format("~h~~q~脚本主机: ~h~~w~无"), zhujixvlie_posx,zhujixvlie_posy + 0.14, 0.4,1)
			else
            draw_string(string.format("~h~~q~脚本主机: ~h~~w~"..players.get_name(players.get_script_host())), zhujixvlie_posx,zhujixvlie_posy + 0.14, 0.4,1)
			end
            draw_string(string.format("~bold~~g~下位主机: ~p~"..nexthost_name), zhujixvlie_posx,zhujixvlie_posy + 0.175, 0.4,1) 
						local hostxvlie = players.get_host_queue_position(players.user())
			if hostxvlie == 0 then
			draw_string(string.format("~h~~w~你现在是~f~战局主机"), zhujixvlie_posx,zhujixvlie_posy + 0.21, 0.4,1) 
			else
			draw_string(string.format("~h~~w~你的主机~f~优先度:~h~~w~ "..hostxvlie), zhujixvlie_posx,zhujixvlie_posy + 0.21, 0.4,1) 
			end
			
end

local showtime_posx = config_active2_x / 1000
local showtime_posy = config_active2_y / 1000
function showtime_x(x_)
    showtime_posx = x_ / 1000
end
function showtime_y(y_)
    showtime_posy = y_ / 1000
end
function xianshishijian(state)
    timeos = state
        if timeos then
            while timeos do
                util.yield(0)
                draw_string(string.format(os.date('~bold~~italic~~b~%Y-%m-%d ~b~%H:%M:%S', os.time())), showtime_posx,showtime_posy + 0.05, 0.47,5)
                end
            end 
    end

--恶灵骑士
looped_ptfxs = {}
burning_man_ptfx_asset = "core"
burning_man_ptfx_effect = "fire_wrecked_plane_cockpit"
function elqes()
vehicleelqs = CreateVehicle (1491277511,ENTITY.GET_ENTITY_COORDS(players.user_ped(),false),0,true)
ENTITY.SET_ENTITY_RENDER_SCORCHED(vehicleelqs,true)
VEHICLE.SET_VEHICLE_COLOURS(vehicleelqs,147,147)
VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicleelqs,30,15)
PED.SET_PED_INTO_VEHICLE(players.user_ped(),vehicleelqs,-1)
util.yield(500)
request_ptfx_asset_firemen(burning_man_ptfx_asset)
        for _, boneName in pairs({"wheel_lf", "wheel_lr"}) do
GRAPHICS.USE_PARTICLE_FX_ASSET(burning_man_ptfx_asset)
            local bone_id = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicleelqs, boneName)
            fx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(burning_man_ptfx_effect, vehicleelqs, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, bone_id, 0.9, false, false, false, 0, 0, 0, 0)
            looped_ptfxs[#looped_ptfxs+1] = fx
            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, 100, 100, 100, false)
      end
end
function request_ptfx_asset_firemen(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end

function firewingscale(value)
    fireWingsSettings.scale = value / 10
end

function firewingcolour(colour)
    fireWingsSettings.colour = colour
end
local mildOrangeFire = new.colour( 255, 127, 80 )

fireBreathSettings = {
    scale = 0.3,
    colour = mildOrangeFire,
    on = false,
    y = { value = 0.12, still = 0.12, walk =  0.22, sprint = 0.32, sneak = 0.35 },
    z = { value = 0.58, still = 0.58, walk =  0.45, sprint = 0.38, sneak = 0.35 },
}

local fireWings = {
            [1] = {pos = {[1] = 100, [2] =  50}},
            [2] = {pos = {[1] = 100, [2] = -50}},
            [3] = {pos = {[1] = 115, [2] =  50}},
            [4] = {pos = {[1] = 115, [2] = -50}},
            [5] = {pos = {[1] = 160, [2] =  50}},
            [6] = {pos = {[1] = 160, [2] = -50}},
            [7] = {pos = {[1] = 170, [2] =  50}},
            [8] = {pos = {[1] = 170, [2] = -50}},
			[9] = {pos = {[1] = 110, [2] =  50}},
            [10] = {pos = {[1] = 110, [2] = -50}},
			[11] = {pos = {[1] = 120, [2] =  50}},
            [12] = {pos = {[1] = 120, [2] = -50}},
			[13] = {pos = {[1] = 130, [2] =  50}},
            [14] = {pos = {[1] = 130, [2] = -50}},
			[15] = {pos = {[1] = 190, [2] =  50}},
            [16] = {pos = {[1] = 190, [2] = -50}},
			[17] = {pos = {[1] = 175, [2] =  50}},
            [18] = {pos = {[1] = 175, [2] = -50}},
			[19] = {pos = {[1] = 140, [2] =  50}},
            [20] = {pos = {[1] = 140, [2] = -50}},
			[21] = {pos = {[1] = 150, [2] =  50}},
            [22] = {pos = {[1] = 150, [2] = -50}},
			[23] = {pos = {[1] = 180, [2] =  50}},
            [24] = {pos = {[1] = 180, [2] = -50}},
        }

fireWingsSettings = {
    scale = 0.3,
    colour = mildOrangeFire,
    on = false
}
local ptfxEgg
function firewing(toggle)
    fireWingsSettings.on = toggle
    if fireWingsSettings.on then
        ENTITY.SET_ENTITY_PROOFS(players.user_ped(), false, true, false, false, false, false, 1, false)
        if ptfxEgg == nil then
            local eggHash = 1803116220
            loadModel(eggHash)
            ptfxEgg = entities.create_object(eggHash, ENTITY.GET_ENTITY_COORDS(players.user_ped()))
            ENTITY.SET_ENTITY_COLLISION(ptfxEgg, false, false)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(eggHash)
        end
        for i = 1, #fireWings do
            while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do
                STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
                util.yield()
            end
            GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
            fireWings[i].ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY('muz_xs_turret_flamethrower_looping', ptfxEgg, 0, 0, 0.1, fireWings[i].pos[1], 0, fireWings[i].pos[2], fireWingsSettings.scale, false, false, false)

            util.create_tick_handler(function()
                local rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 2)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(ptfxEgg, players.user_ped(), -1, 0, 0, 0, rot.x, rot.y, rot.z, false, false, false, false, 0, false)
                ENTITY.SET_ENTITY_ROTATION(ptfxEgg, rot.x, rot.y, rot.z, 2, true)
                for i = 1, #fireWings do
                    GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(fireWings[i].ptfx, fireWingsSettings.scale)
                    GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireWings[i].ptfx, fireWingsSettings.colour.r, fireWingsSettings.colour.g, fireWingsSettings.colour.b)
                end

                ENTITY.SET_ENTITY_VISIBLE(ptfxEgg, false)
                return fireWingsSettings.on
            end)
        end
    else
        for i = 1, #fireWings do
            if fireWings[i].ptfx then
                GRAPHICS.REMOVE_PARTICLE_FX(fireWings[i].ptfx, true)
                fireWings[i].ptfx = nil
            end
            if ptfxEgg then
                entities.delete_by_handle(ptfxEgg)
                ptfxEgg = nil
            end
        end
        STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
    end
end
maxHealth_cantseeyouinmap = 328
function undead()
    if  ENTITY.GET_ENTITY_MAX_HEALTH(players.user_ped()) ~= 0 then
		ENTITY.SET_ENTITY_MAX_HEALTH(players.user_ped(), 0)
	end
end
function setBit(bitfield, bitNum)
	return (bitfield | (1 << bitNum))
end
function clearBit(bitfield, bitNum)
	return (bitfield & ~(1 << bitNum))
end
function set_explosion_proof(entity, value)
	local pEntity = entities.handle_to_pointer(entity)
	if pEntity == 0 then return end
	local damageBits = memory.read_uint(pEntity + 0x0188)
	damageBits = value and setBit(damageBits, 11) or clearBit(damageBits, 11)
	memory.write_uint(pEntity + 0x0188, damageBits)
end
function supermanpersonl()
	local pWeapon = memory.alloc_int()
	WEAPON.GET_CURRENT_PED_WEAPON(players.user_ped(), pWeapon, 1)
	local weaponHash = memory.read_int(pWeapon)
	if WEAPON.IS_PED_ARMED(players.user_ped(), 1) or weaponHash == util.joaat("weapon_unarmed") then
		local pImpactCoords = v3.new()
		local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
		if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), pImpactCoords) then
			set_explosion_proof(players.user_ped(), true)
			util.yield_once()
			FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 1.0, 29, 5.0, false, true, 0.3, true)
		elseif not FIRE.IS_EXPLOSION_IN_SPHERE(29, pos.x, pos.y, pos.z, 2.0) then
			set_explosion_proof(players.user_ped(), false)
		end
	end
end
--轨迹
function removeFxs(effects)
	for _, effect in ipairs(effects) do
		GRAPHICS.STOP_PARTICLE_FX_LOOPED(effect, 0)
		GRAPHICS.REMOVE_PARTICLE_FX(effect, 0)
	end
end

local function request_ptfx_asset_firework(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end
local placed_firework_boxes = {}

function placefirework()
    local animlib = 'anim@mp_fireworks'
    local ptfx_asset = "scr_indep_fireworks"
    local anim_name = 'place_firework_3_box'
    local effect_name = "scr_indep_firework_trailburst"
    request_anim_dict(animlib)
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 0.52, 0.0)
    local ped = players.user_ped()
    ENTITY.FREEZE_ENTITY_POSITION(ped, true)
    TASK.TASK_PLAY_ANIM(ped, animlib, anim_name, -1, -8.0, 3000, 0, 0, false, false, false)
    util.yield(1500)
    local firework_box = entities.create_object(util.joaat('ind_prop_firework_03'), pos, true, false, false)
    local firework_box_pos = ENTITY.GET_ENTITY_COORDS(firework_box)
    OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(firework_box)
    ENTITY.FREEZE_ENTITY_POSITION(ped, false)
    util.yield(1000)
    ENTITY.FREEZE_ENTITY_POSITION(firework_box, true)
    placed_firework_boxes[#placed_firework_boxes + 1] = firework_box
end

function fireworkshow()
    if #placed_firework_boxes == 0 then 
         local notification = b_notifications.new()
         notification.notify("八嘎","先放置烟花懂不懂！~")
        return 
    end
    local ptfx_asset = "scr_indep_fireworks"
    local effect_name = "scr_indep_firework_trailburst"
    request_ptfx_asset_firework(ptfx_asset)
      local notification = b_notifications.new()
      notification.notify("八嘎","看好了，烟花来啦！~")
    for i=1, 50 do
        for k,box in pairs(placed_firework_boxes) do 
            GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, box, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 0.0, 0.0, 0.0)
            util.yield(100)
        end
    end
    for k,box in pairs(placed_firework_boxes) do 
        entities.delete_by_handle(box)
        placed_firework_boxes[box] = nil
    end
end
------------------------------------
-----------粒子效果轰炸-------------
------------------------------------
function Streamptfx(lib)
    STREAMING.REQUEST_NAMED_PTFX_ASSET(lib)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(lib) do
        util.yield()
    end
    GRAPHICS.USE_PARTICLE_FX_ASSET(lib)
end
function fingergun()
    for id, data in pairs(weapon_stuff) do
        local name = data[1]
        local weapon_name = data[2]
        local projectile = util.joaat(weapon_name)
        while not WEAPON.HAS_WEAPON_ASSET_LOADED(projectile) do
            WEAPON.REQUEST_WEAPON_ASSET(projectile, 31, false)
            util.yield(10)
        end
        menu.toggle(finger_thing, name, {}, "", function(state)
            toggled = state
            while toggled do
                if memory.read_int(memory.script_global(4521801 + 930)) == 3 then
                    memory.write_int(memory.script_global(4521801 + 935), NETWORK.GET_NETWORK_TIME())
                    local inst = v3.new()
                    v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
                    local tmp = v3.toDir(inst)
                    v3.set(inst, v3.get(tmp))
                    v3.mul(inst, 1000)
                    v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
                    v3.add(inst, tmp)
                    local x, y, z = v3.get(inst)
                    local fingerPos = PED.GET_PED_BONE_COORDS(players.user_ped(), 0xff9, 1.0, 0, 0)
                    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(fingerPos.x, fingerPos.y, fingerPos.z, x, y, z, 1, true, projectile, 0, true, false, 500.0, players.user_ped(), 0)
                end
                util.yield(100)
            end
            local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
            MISC.CLEAR_AREA_OF_PROJECTILES(pos.x, pos.y, pos.z, 999999, 0)
        end)
    end
end
proxyStickySettings = {players = true, npcs = false, radius = 2}
local function autoExplodeStickys(ped)
    local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
    if MISC.IS_PROJECTILE_TYPE_WITHIN_DISTANCE(pos.x, pos.y, pos.z, util.joaat('weapon_stickybomb'), proxyStickySettings.radius, true) then
        WEAPON.EXPLODE_PROJECTILES(players.user_ped(), util.joaat('weapon_stickybomb'))
    end
end
function proxyStickys()
    if proxyStickySettings.players then
        local specificWhitelistGroup = {user = false,  friends = whitelistGroups.friends, strangers = whitelistGroups.strangers}
        local playerList = getNonWhitelistedPlayers(whitelistListTable, specificWhitelistGroup, whitelistedName)
        for _, pid in pairs(playerList) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            autoExplodeStickys(ped)
        end
    end
    if proxyStickySettings.npcs then
        local pedHandles = entities.get_all_peds_as_handles()
        for _, ped in pairs(pedHandles) do
            if not PED.IS_PED_A_PLAYER(ped) then
                autoExplodeStickys(ped)
            end
        end
    end
end
function proxyStickys_players(toggle)
    proxyStickySettings.players = toggle
end
function proxystickys_npc(toggle)
    proxyStickySettings.npcs = toggle
end
function proxysticks_radius(value)
    proxyStickySettings.radius = value
end

--俄罗斯转盘
randomizer = function(x)
    local r = math.random(1,3)
    return x[r]
end

array = {"1","1","2"}

function pid_to_handle(pid)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, memory.alloc(13*8), 13)
    return memory.alloc(13*8)
end

saimbot_mode = "closest"
function get_aimbot_target()
    local dist = 1000000000
    local cur_tar = 0
    for k,v in pairs(entities.get_all_peds_as_handles()) do
        local target_this = true
        local player_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        local ped_pos = ENTITY.GET_ENTITY_COORDS(v, true)
        local this_dist = MISC.GET_DISTANCE_BETWEEN_COORDS(player_pos['x'], player_pos['y'], player_pos['z'], ped_pos['x'], ped_pos['y'], ped_pos['z'], true)
        if PLAYER.PLAYER_PED_ID() ~= v and not ENTITY.IS_ENTITY_DEAD(v) then
            if not satarget_players then
                if PED.IS_PED_A_PLAYER(v) then
                    target_this = false
                end
            end
            if not satarget_npcs then
                if not PED.IS_PED_A_PLAYER(v) then
                    target_this = false
                end
            end
            if not ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(PLAYER.PLAYER_PED_ID(), v, 17) then
                target_this = false
            end
            if satarget_usefov then
                if not PED.IS_PED_FACING_PED(PLAYER.PLAYER_PED_ID(), v, sa_fov) then
                    target_this = false
                end
            end
            if satarget_novehicles then
                if PED.IS_PED_IN_ANY_VEHICLE(v, true) then
                    target_this = false
                end
            end
            if satarget_nogodmode then
                if not ENTITY._GET_ENTITY_CAN_BE_DAMAGED(v) then
                    target_this = false
                end
            end
            if not satarget_targetfriends and satarget_players then
                if PED.IS_PED_A_PLAYER(v) then
                    local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(v)
                    local hdl = pid_to_handle(pid)
                    if NETWORK.NETWORK_IS_FRIEND(hdl) then
                        target_this = false
                    end
                end
            end
            if saimbot_mode == "closest" then
                if this_dist <= dist then
                    if target_this then
                        dist = this_dist
                        cur_tar = v
                    end
                end
            end
        end
    end
    return cur_tar
end
function start_silent_aimbot()
    saimbot_thread = util.create_thread(function (thr)
    while true do
        if not silent_aimbot then
            util.stop_thread()
        end
        local target = get_aimbot_target()
        if target ~= 0 then
            local t_pos = PED.GET_PED_BONE_COORDS(target, 31086, 0.01, 0, 0)
            local t_pos2 = PED.GET_PED_BONE_COORDS(target, 31086, -0.01, 0, 0.00)
            -- debug shit, ignore
            if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
                GRAPHICS.DRAW_MARKER(0, t_pos['x'], t_pos['y'], t_pos['z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 0, 255, 100, false, true, 2, false, 0, 0, false)
                GRAPHICS.DRAW_MARKER(0, t_pos2['x'], t_pos2['y'], t_pos2['z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 0, 255, 100, false, true, 2, false, 0, 0, false)
            end
            GRAPHICS.DRAW_MARKER(0, t_pos['x'], t_pos['y'], t_pos['z']+2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 1, 255, 0, 255, 100, false, true, 2, false, 0, 0, false)
            if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
                local wep = WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID())
                local dmg = WEAPON.GET_WEAPON_DAMAGE(wep, 0)
                if satarget_damageo then
                    dmg = sa_odmg
                end
                local veh = PED.GET_VEHICLE_PED_IS_IN(target, false)
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(t_pos['x'], t_pos['y'], t_pos['z'], t_pos2['x'], t_pos2['y'], t_pos2['z'], dmg, true, wep, PLAYER.PLAYER_PED_ID(), true, false, 10000, veh)
            end
        end
        util.yield()
    end
end)
end

VEH_MISSILE_SPEED = 10000

MISL_AIM = false
missile_settings = {
    radius = 300,
    speed = 100,
    los = true,
    cam = false,
    ptfx = true,
    ptfx_scale = 1,
    air_target = false,
    multitarget = false,
    multiped = false
}
missile_particles = {
    name = "exp_grd_rpg_lod",
    dictionary = "core"
}

--Later: block rockets (spawn walls when detecting they are in range)

ATTACH_CAM_TO_ENTITY_WITH_FIXED_DIRECTION = function (--[[Cam (int)]] cam, --[[Entity (int)]] entity, --[[float]] xRot, --[[float]] yRot, --[[float]] zRot, --[[float]] xOffset, --[[float]] yOffset, --[[float]] zOffset, --[[BOOL (bool)]] isRelative)
    native_invoker.begin_call()
    native_invoker.push_arg_int(cam)
    native_invoker.push_arg_int(entity)
    native_invoker.push_arg_float(xRot); native_invoker.push_arg_float(yRot); native_invoker.push_arg_float(zRot)
    native_invoker.push_arg_float(xOffset); native_invoker.push_arg_float(yOffset); native_invoker.push_arg_float(zOffset)
    native_invoker.push_arg_bool(isRelative)
    native_invoker.end_call("202A5ED9CE01D6E7")
end

--https://github.com/Sainan/gta-v-joaat-hash-db/blob/senpai/out/objects-hex.csv

Rocket_Hashes = {
    {"rpg", util.joaat("w_lr_rpg_rocket")},
    {"homingrpg", util.joaat("w_lr_homing_rocket")},
    {"oppressor2", util.joaat("w_ex_vehiclemissile_3")},
    {"b11barrage", util.joaat("w_smug_airmissile_01b")},
    {"b11regular", util.joaat("w_battle_airmissile_01")},
    {"chernobog", util.joaat("w_ex_vehiclemissile_4")},
    {"akula", util.joaat("w_smug_airmissile_02")},
    {"grenadelauncher", util.joaat("w_lr_40mm")}, --grenade launcher lmfao
    {"compactemplauncher", util.joaat("w_lr_ml_40mm")}, --compact emp launhcer lmao
    {"teargas", util.joaat("w_ex_grenadesmoke")} --tear gas grenade lmfao
}

Chosen_Rocket_Hash = Rocket_Hashes[1][2] --default is the regular RPG
MISSILE_ENTITY_TABLE = {}

MISL_AIR = false

ORB_Sneaky = false

sa_fov = 180

sa_odmg = 100

CAR_S_sneaky = false
CAR_S_BLACKLIST = {}


LegitRapidFire = false
LegitRapidMS = 100

AIM_WHITELIST = {}

Silent_Aimbot = {
    hitboxes = {
        head = {hash = 12844, toggled = false},
        spine = {hash = 24817, toggled = false},
        pelvis = {hash = 11816, toggled = false},
    },

    fov = 2,
    dist = 300,
    dmg = 100,

    los_check = true,
    fov_check = true,

    hash = 177293209, --heavy sniper mk2 hash
    advanced = {
        speed = -1
    }
}
function GetSuitableAimbotTarget(fov, fovcheck, dist, loscheck)
    local ourped = GetLocalPed()
    local distsq = dist * dist
    local ourc = ENTITY.GET_ENTITY_COORDS(ourped)
    local entTable = entities.get_all_peds_as_pointers()
    local inRange = {}
    for _, entity in pairs(entTable) do

        local entpos = entities.get_position(entity)

            if PVP_SYSTEM.VDIST2(ourc.x, ourc.y, ourc.z, entpos.x, entpos.y, entpos.z) <= distsq then --distance check

                local handle = entities.pointer_to_handle(entity)
                if (handle ~= ourped) then
                    if (not PED.IS_PED_DEAD_OR_DYING(handle)) and (INTERIOR.GET_INTERIOR_FROM_ENTITY(handle) == 0) then --dead/interior check

                        if (fovcheck and PED.IS_PED_FACING_PED(ourped, handle, fov)) or (not fovcheck) then --fov check

                            if (PED.IS_PED_A_PLAYER(handle)) and (not AIM_WHITELIST[NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(handle)]) then --whitelist, player check

                                if (loscheck and ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(ourped, handle, 17)) or (not loscheck) then --line-of-sight check
                                    inRange[#inRange+1] = handle
                                end
                            end
                        end
                    end
                end
            end

    end
    local retplayer
    local d = 99999999999
    if #inRange ~= 0 then
        for _, ped in pairs(inRange) do
            local tc = ENTITY.GET_ENTITY_COORDS(ped)
            local vidsti = PVP_SYSTEM.VDIST2(ourc.x, ourc.y, ourc.z, tc.x, tc.y, tc.z)
            if vidsti < d then
                retplayer = ped
                d = vidsti
            end
        end
        return retplayer
    end
    return nil
end
--上帝之指
local is_player_pointing = function ()
	return read_global.int(4521801 + 930) == 3
end

local targetEntity = NULL
local lastStop <const> = newTimer()
local explosionProof = false
function godfinger()
    if is_player_pointing() then
		write_global.int(4521801 + 935, NETWORK.GET_NETWORK_TIME())
		if not ENTITY.DOES_ENTITY_EXIST(targetEntity) then
			local flag = TraceFlag.peds | TraceFlag.vehicles | TraceFlag.pedsSimpleCollision | TraceFlag.objects
			local raycastResult = get_raycast_result(500.0, flag)

			if raycastResult.didHit and ENTITY.DOES_ENTITY_EXIST(raycastResult.hitEntity) then
				targetEntity = raycastResult.hitEntity
			end
		else
			local myPos = players.get_position(players.user())
			local entityPos = ENTITY.GET_ENTITY_COORDS(targetEntity, true)
			local camDir = CAM.GET_GAMEPLAY_CAM_ROT(0):toDir()
			local distance = myPos:distance(entityPos)
			if distance > 30.0 then distance = 30.0
			elseif distance < 10.0 then distance = 10.0 end
			local targetPos = v3.new(camDir)
			targetPos:mul(distance)
			targetPos:add(myPos)
			local direction = v3.new(targetPos)
			direction:sub(entityPos)
			direction:normalise()

			if ENTITY.IS_ENTITY_A_PED(targetEntity) then
				direction:mul(5.0)
				local explosionPos = v3.new(entityPos)
				explosionPos:sub(direction)
				draw_bounding_box(targetEntity, false, {r = 255, g = 255, b = 255, a = 255})
				set_explosion_proof(players.user_ped(), true)
				explosionProof = true
				FIRE.ADD_EXPLOSION(explosionPos.x, explosionPos.y, explosionPos.z, 29, 25.0, false, true, 0.0, true)
			else
				local vel = v3.new(direction)
				local magnitude = entityPos:distance(targetPos)
				vel:mul(magnitude)
				draw_bounding_box(targetEntity, true, {r = 255, g = 255, b = 255, a = 80})
				request_control_once(targetEntity)
				ENTITY.SET_ENTITY_VELOCITY(targetEntity, vel.x, vel.y, vel.z)
			end
		end
	elseif targetEntity ~= NULL then
		lastStop.reset()
		targetEntity = NULL

	elseif explosionProof and lastStop.elapsed() > 500 then
		explosionProof = false
		set_explosion_proof(players.user_ped(), false)
    end
end
local function tpTableToPlayer(tbl, pid)
    if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) then
        local c = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
        for _, v in pairs(tbl) do
            if (not PED.IS_PED_A_PLAYER(v)) then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(v, c.x, c.y, c.z, false, false, false)
            end
        end
    end
end
function TpAllPeds(player)
    local pedHandles = entities.get_all_peds_as_handles()
    tpTableToPlayer(pedHandles, player)
end
function TpAllVehs(player)
    local vehHandles = entities.get_all_vehicles_as_handles()
    tpTableToPlayer(vehHandles, player)
end
function TpAllObjects(player)
    local objHandles = entities.get_all_objects_as_handles()
    tpTableToPlayer(objHandles, player)
end
function stcnm(pid)
    AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "SPAWN", PLAYER.GET_PLAYER_PED(pid), "BARRY_01_SOUNDSET", true, 2)
    AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "External_Explosion", PLAYER.GET_PLAYER_PED(pid), "Methamphetamine_Job_Sounds", true, 1)
end

function phonesoundcnm(pid)
    AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Menu_Accept", PLAYER.GET_PLAYER_PED(pid), "Phone_SoundSet_Default", true, 2)
end
function letcarlagging(pid)
    local ped = PLAYER.GET_PLAYER_PED(pid)
   if PED.IS_PED_IN_ANY_VEHICLE(ped) then
       local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
       local velocity = ENTITY.GET_ENTITY_VELOCITY(veh)
       local oldcoords = ENTITY.GET_ENTITY_COORDS(ped)
       wait(500)
       local nowcoords = ENTITY.GET_ENTITY_COORDS(ped)
       for a = 1, 10 do
           NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
           wait()
       end
       ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
       wait(200)
       for b = 1, 10 do
           NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
           wait()
       end
       ENTITY.SET_ENTITY_VELOCITY(veh, velocity.x, velocity.y, velocity.z)
       for c = 1, 10 do
           NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
           wait()
       end
       ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, nowcoords.x, nowcoords.y, nowcoords.z, false, false, false)
       for d = 1, 10 do
           NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
           wait()
       end
       ENTITY.SET_ENTITY_VELOCITY(veh, velocity.x, velocity.y, velocity.z)
       wait(500)
   else
       local notification = b_notifications.new()
       notification.notify("通知","八嘎，他都不在车内你让我怎么玩！")
   end
end
--摇头丸
function request_control_of_entity_once(ent)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and util.is_session_started() then
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(ent)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
    end
end
function carspin(pid)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    if car ~= 0 then
        request_control_of_entity_once(car)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(car, 4, 0.0, 0.0, 300.0, 0, true, true, false, true, true, true)
    end
end
saimbot_mode = "closest"
function get_aimbot_target()
    local dist = 1000000000
    local cur_tar = 0
    for k,v in pairs(entities.get_all_peds_as_handles()) do
        local target_this = true
        local player_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        local ped_pos = ENTITY.GET_ENTITY_COORDS(v, true)
        local this_dist = MISC.GET_DISTANCE_BETWEEN_COORDS(player_pos['x'], player_pos['y'], player_pos['z'], ped_pos['x'], ped_pos['y'], ped_pos['z'], true)
        if PLAYER.PLAYER_PED_ID() ~= v and not ENTITY.IS_ENTITY_DEAD(v) then
            if not satarget_players then
                if PED.IS_PED_A_PLAYER(v) then
                    target_this = false
                end
            end
            if not satarget_npcs then
                if not PED.IS_PED_A_PLAYER(v) then
                    target_this = false
                end
            end
            if not ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(PLAYER.PLAYER_PED_ID(), v, 17) then
                target_this = false
            end
            if satarget_usefov then
                if not PED.IS_PED_FACING_PED(PLAYER.PLAYER_PED_ID(), v, sa_fov) then
                    target_this = false
                end
            end
            if satarget_novehicles then
                if PED.IS_PED_IN_ANY_VEHICLE(v, true) then
                    target_this = false
                end
            end
            if satarget_nogodmode then
                if not ENTITY._GET_ENTITY_CAN_BE_DAMAGED(v) then
                    target_this = false
                end
            end
            if not satarget_targetfriends and satarget_players then
                if PED.IS_PED_A_PLAYER(v) then
                    local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(v)
                    local hdl = pid_to_handle(pid)
                    if NETWORK.NETWORK_IS_FRIEND(hdl) then
                        target_this = false
                    end
                end
            end
            if saimbot_mode == "closest" then
                if this_dist <= dist then
                    if target_this then
                        dist = this_dist
                        cur_tar = v
                    end
                end
            end
        end
    end
    return cur_tar
end
--息怒崩
function jesus_help_me()
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    local SelfPlayerPed = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), SelfPlayerPos, 0)
    for i = 1, 20 do                   
        ENTITY.SET_ENTITY_INVINCIBLE(SelfPlayerPed, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
        PED.SET_PED_INTO_VEHICLE(SelfPlayerPed, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
        util.yield(200)
        WIRI_VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, util.joaat("prop_beach_parasol_05"))
        WIRI_VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(200)
        entities.delete_by_handle(Ruiner2)
        entities.delete_by_handle(SelfPlayerPed)
    end
end
function changemodel(pid)
give_car_addon(pid, util.joaat("h4_prop_h4_loch_monster"), true, -90.0)
end


zaijumoxing = {"prop_sam_01"}
function jibamodel(pid)
give_car_addon(pid, util.joaat("prop_sam_01"), true, -90.0)
give_car_addon(pid, util.joaat("prop_sam_01"), true, -45.0)
give_car_addon(pid, util.joaat("prop_sam_01"), true, 45.0)
give_car_addon(pid, util.joaat("prop_sam_01"), true, 90.0)
give_car_addon(pid, util.joaat("prop_sam_01"), true, 0.0)
end
obj_pp = {"prop_cs_dildo_01", "prop_ld_bomb_01", "prop_sam_01"}
opt_pp = {"小鸡巴", "大鸡巴", "超级鸡巴", "删除"}

function getbigjb(index, value, click_type)
    pluto_switch index do
        case 1:
            attach_to_player("prop_cs_dildo_01", 57597, -0.1, 0.15, 0, 0, 90, 90)
            break
        case 2:
            attach_to_player("prop_ld_bomb_01", 57597, -0.1, 0.6, 0, 0, 180, 180)
            break
        case 3:
            attach_to_player("prop_sam_01", 57597, -0.1, 1.7, 0, 0, 180, 180)
            break
        case 4:
            for k, model in pairs(obj_pp) do 
                delete_object(model)
            end
            break
        end
    end
function deleplayercar(pid)
    local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local player_veh = PED.GET_VEHICLE_PED_IS_USING(player)
    if not PED.IS_PED_IN_ANY_VEHICLE(player, true) then
        util.toast("玩家不在载具里. :/")
        return
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(player_veh)
    util.yield(500)
    if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(player_veh) then
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(player_veh, false, false)
        entities.delete_by_handle(player_veh)
    else
        util.toast("无法控制此玩家载具. :/")
    end
end

local function fastNet(entity, playerID)
    local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
        for i = 1, 30 do
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
                wait(10)
            else
                goto continue
            end    
        end
    end
    ::continue::
    if SE_Notifications then
        util.toast("有控制权.")
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
    wait(10)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
    wait(10)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
    wait(10)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, playerID, true)
    wait(10)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, true, false)
    wait(10)
    ENTITY._SET_ENTITY_CLEANUP_BY_ENGINE(entity, false)
    wait(10)
    if ENTITY.IS_ENTITY_AN_OBJECT(entity) then
        NETWORK.OBJ_TO_NET(entity)
    end
    wait(10)
    if BA_visible then
        ENTITY.SET_ENTITY_VISIBLE(entity, true, 0)
    else
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
        wait()
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
        wait()
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
    end
end
function qfmq(pid)
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local forwardOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0, 4, 0)
    local pheading = ENTITY.GET_ENTITY_HEADING(ped)
    local hash = 309416120
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do wait() end
    local a1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, true, true)
    ENTITY.SET_ENTITY_HEADING(a1, pheading + 90)
    fastNet(a1, pid)
    local b1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z + 1, true, true, true)
    ENTITY.SET_ENTITY_HEADING(b1, pheading + 90)
    fastNet(b1, pid)
    wait(1000)
    entities.delete_by_handle(a1)
    entities.delete_by_handle(b1)
end
speed = 6
function do_vehicle_fly() 
    veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false);
    cam_pos = CAM.GET_GAMEPLAY_CAM_ROT(0);
    ENTITY.SET_ENTITY_ROTATION(veh, cam_pos.x, cam_pos.y, cam_pos.z, 1, TRUE);
    ENTITY.SET_ENTITY_COLLISION(veh, not no_collision, TRUE);
    
    local locspeed = speed*10
    local locspeed2 = speed
    if PAD.IS_CONTROL_PRESSED(0, 61) then 
        locspeed = locspeed*2
        locspeed2 = locspeed2*2
    end

    
    if PAD.IS_CONTROL_PRESSED(2, 71) then
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, speed, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else 
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, locspeed)
        end
	end
    if PAD.IS_CONTROL_PRESSED(2, 72) then
		local lsp = speed
        if not PAD.IS_CONTROL_PRESSED(0, 61) then 
            lsp = speed * 2
        end
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0 - (lsp), 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else 
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0 - (locspeed));
        end
   end
    if PAD.IS_CONTROL_PRESSED(2, 63) then
        local lsp = (0 - speed)*2
        if not PAD.IS_CONTROL_PRESSED(0, 61) then 
            lsp = 0 - speed
        end
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, (lsp), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else 
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0 - (locspeed), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1);
        end
	end
    if PAD.IS_CONTROL_PRESSED(2, 64) then
        local lsp = speed
        if not PAD.IS_CONTROL_PRESSED(0, 61) then 
            lsp = speed*2
        end
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, lsp, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else 
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, locspeed, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        end
    end
	if not dont_stop and not PAD.IS_CONTROL_PRESSED(2, 71) and not PAD.IS_CONTROL_PRESSED(2, 72) then
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0.0);
    end
end
local careffects = {
	{"scr_rcbarry1", "scr_alien_impact_bul", 1.0, 50},
	{"scr_rcbarry2", "scr_clown_appears", 0.3, 500},
	{"core", "ent_dst_elec_fire_sp", 1.0, 100},
	{"scr_rcbarry1", "scr_alien_disintegrate", 0.1, 400},
	{"scr_rcbarry1", "scr_alien_teleport", 0.1, 400}
}
local careffects_lastEffect = newTimer()

function cargoodeffect()
    local effects = careffects[selectedOpt]
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)

	if ENTITY.DOES_ENTITY_EXIST(vehicle) and not ENTITY.IS_ENTITY_DEAD(vehicle, false) and
	VEHICLE.IS_VEHICLE_DRIVEABLE(vehicle, false) and careffects_lastEffect.elapsed() > effects[4] then
		request_fx_asset(effects[1])
		for _, boneName in pairs({"wheel_lf", "wheel_lr", "wheel_rf", "wheel_rr"}) do
			local bone = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicle, boneName)
			GRAPHICS.USE_PARTICLE_FX_ASSET(effects[1])
			WIRI_GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE(
				effects[2],
				vehicle,
				-0.05, 0.0, 0.0,
				0.0, 0.0, 0.0,
				bone,
				effects[3],
				false, false, false
			)
		end
		careffects_lastEffect.reset()
	end
end

function set_carvis(index)
    selectedOpt = index
end
------------------------------------
-------------玩家笼子---------------
------------------------------------
spawned_objects = {}
--笼子
function ptlz(pid)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(player_ped) 
    if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
        menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." on")
        util.yield(300)
        if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
            notification("Failed to kick player out of the vehicle", colors.red)
            menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
            return
        end
        menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
        pos =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    end
    cage_player(pos)
end
--七度空间
function qdkj(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = 1089807209
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - 1, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + 1, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + 1, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - 1, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .75, true, true, false) -- above
	cages[#cages + 1] = cage_object

	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	rot.y = 90

	ENTITY.FREEZE_ENTITY_POSITION(cage_object, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object2, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object3, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object4, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object5, true)
	util.yield(15)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--钱笼子
function zdlz(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("bkr_prop_moneypack_03a")
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .70, pos.y, pos.z, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .70, pos.y, pos.z, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .70, pos.z, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .70, pos.z, true, true, false) -- right

	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .70, pos.y, pos.z + .25, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .70, pos.y, pos.z + .25, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .70, pos.z + .25, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .70, pos.z + .25, true, true, false) -- right

	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .75, true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	util.yield(15)
	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	rot.y = 90
	ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--垃圾箱
function yylz(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = 684586828
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z, true, true, false)
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + 1, true, true, false)
	cages[#cages + 1] = cage_object
	util.yield(15)
	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	rot.y = 90
	ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--小车车
function cclz(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    local hash = 4022605402
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do		
        util.yield()
    end
    local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
    cages[#cages + 1] = cage_object
    util.yield(15)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--圣诞快乐
function sdkl1(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = 238789712
	STREAMING.REQUEST_MODEL(hash)
	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
	cages[#cages + 1] = cage_object
	util.yield(15)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--圣诞快乐pro
function sdkl2(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("ch_prop_tree_02a")
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .75, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .75, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .75, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .75, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .5, true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	util.yield(15)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--圣诞快乐promax
function sdkl3(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("ch_prop_tree_03a")
	STREAMING.REQUEST_MODEL(hash)
	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .75, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .75, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .75, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .75, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .5, true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	util.yield()
	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
		rot.y = 90
		ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--竞技管
function jjglz()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    STREAMING.REQUEST_MODEL(2081936690)
    while not STREAMING.HAS_MODEL_LOADED(2081936690) do		
        util.yield()
    end
    local cage_object = OBJECT.CREATE_OBJECT(2081936690, pos.x, pos.y, pos.z, true, true, false)
    cages[#cages + 1] = cage_object
    util.yield(15)
    local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
    rot.y = 90
    ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end

--伊丽莎白女王的棺材盒
function gueencage(pid)
    local number_of_cages = 6
    local coffin_hash = util.joaat("prop_coffin_02b")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(coffin_hash)
    local temp_v3 = v3.new(0, 0, 0)
    for i = 1, number_of_cages do
        local angle = (i / number_of_cages) * 360
        temp_v3.z = angle
        local obj_pos = temp_v3:toDir()
        obj_pos:mul(0.8)
        obj_pos:add(pos)
        obj_pos.z += 0.1
       local coffin = entities.create_object(coffin_hash, obj_pos)
       spawned_objects[#spawned_objects + 1] = coffin
       ENTITY.SET_ENTITY_ROTATION(coffin, 90.0, 0.0, angle,  2, 0)
       ENTITY.FREEZE_ENTITY_POSITION(coffin, true)
    end
end
--载具笼子
function vehcagelol(pid)
    local container_hash = util.joaat("boxville3")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(container_hash)
    local container = entities.create_vehicle(container_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 2.0, 0.0), ENTITY.GET_ENTITY_HEADING(ped))
    spawned_objects[#spawned_objects + 1] = container
    ENTITY.SET_ENTITY_VISIBLE(container, false)
    ENTITY.FREEZE_ENTITY_POSITION(container, true)
end
--燃气笼
function gascage(pid)
    local gas_cage_hash = util.joaat("prop_gascage01")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(gas_cage_hash)
    pos.z -= 1
    local gas_cage = entities.create_object(gas_cage_hash, pos, 0)
    pos.z += 1
    local gas_cage2 = entities.create_object(gas_cage_hash, pos, 0)
    spawned_objects[#spawned_objects + 1] = gas_cage
    spawned_objects[#spawned_objects + 1] = gas_cage2
    ENTITY.FREEZE_ENTITY_POSITION(gas_cage, true)
    ENTITY.FREEZE_ENTITY_POSITION(gas_cage2, true)
end
--伤害数字
b_drawing_funcs = {}
b_drawing_funcs.new = function ()
    local self = {}
    self.draw_arrow = function(pos, angle, size, colour_a, colour_b)
        local angle_cos = math.cos(angle)
        local angle_sin = math.sin(angle)
    
        local width = 0.5 * size
        local length = 1 * size
        local height = 0.25 * size
    
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * -width - angle_sin * -length),
            pos.y + (angle_sin * -width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + -height,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + height,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + -height,
            pos.x + (angle_cos * width - angle_sin * -length),
            pos.y + (angle_sin * width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + height,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * width - angle_sin * -length),
            pos.y + (angle_sin * width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * width),
            pos.y + (angle_sin * 0 + angle_cos * width),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + height,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * width),
            pos.y + (angle_sin * 0 + angle_cos * width),
            pos.z + 0,
            pos.x + (angle_cos * width - angle_sin * -length),
            pos.y + (angle_sin * width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + -height,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * -width - angle_sin * -length),
            pos.y + (angle_sin * -width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * width),
            pos.y + (angle_sin * 0 + angle_cos * width),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + -height,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * width),
            pos.y + (angle_sin * 0 + angle_cos * width),
            pos.z + 0,
            pos.x + (angle_cos * -width - angle_sin * -length),
            pos.y + (angle_sin * -width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + height,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
    end
    self.draw_arrow_down = function(pos, angle, size, colour_a, colour_b)
        local angle_cos = math.cos(angle)
        local angle_sin = math.sin(angle)
    
        local width = 0.5 * size
        local length = 1 * size
        local height = 0.25 * size
        
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * 0),
            pos.y + (angle_sin * 0 + angle_cos * 0),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * height),
            pos.y + (angle_sin * 0 + angle_cos * height),
            pos.z + length + height,
            pos.x + (angle_cos * width - angle_sin * 0),
            pos.y + (angle_sin * width + angle_cos * 0),
            pos.z + length,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * -height),
            pos.y + (angle_sin * 0 + angle_cos * -height),
            pos.z + length + height,
            pos.x + (angle_cos * 0 - angle_sin * 0),
            pos.y + (angle_sin * 0 + angle_cos * 0),
            pos.z + 0,
            pos.x + (angle_cos * width - angle_sin * 0),
            pos.y + (angle_sin * width + angle_cos * 0),
            pos.z + length,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * 0),
            pos.y + (angle_sin * 0 + angle_cos * 0),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -height),
            pos.y + (angle_sin * 0 + angle_cos * -height),
            pos.z + length + height,
            pos.x + (angle_cos * -width - angle_sin * 0),
            pos.y + (angle_sin * -width + angle_cos * 0),
            pos.z + length,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * height),
            pos.y + (angle_sin * 0 + angle_cos * height),
            pos.z + length + height,
            pos.x + (angle_cos * 0 - angle_sin * 0),
            pos.y + (angle_sin * 0 + angle_cos * 0),
            pos.z + 0,
            pos.x + (angle_cos * -width - angle_sin * 0),
            pos.y + (angle_sin * -width + angle_cos * 0),
            pos.z + length,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * height),
            pos.y + (angle_sin * 0 + angle_cos * height),
            pos.z + length + height,
            pos.x + (angle_cos * 0 - angle_sin * -height),
            pos.y + (angle_sin * 0 + angle_cos * -height),
            pos.z + length + height,
            pos.x + (angle_cos * width - angle_sin * 0),
            pos.y + (angle_sin * width + angle_cos * 0),
            pos.z + length,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * -height),
            pos.y + (angle_sin * 0 + angle_cos * -height),
            pos.z + length + height,
            pos.x + (angle_cos * 0 - angle_sin * height),
            pos.y + (angle_sin * 0 + angle_cos * height),
            pos.z + length + height,
            pos.x + (angle_cos * -width - angle_sin * 0),
            pos.y + (angle_sin * -width + angle_cos * 0),
            pos.z + length,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
    end
    self.draw_quad = function (pos1_org, pos2_org, size, colour_a, colour_b, dict, texture)
        GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(dict, false)
        if GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(dict) then
            pos1 =  {x = pos1_org.x, y = pos1_org.y, z = pos1_org.z}
            pos2 =  {x = pos2_org.x, y = pos2_org.y, z = pos2_org.z}
            pos2.z = pos2.z - size * 0.5
            pos1.z = pos1.z - size * 0.5
            GRAPHICS.SET_BACKFACECULLING(false)
            GRAPHICS._DRAW_SPRITE_POLY_2(
                pos1.x,     pos1.y,             pos1.z,
                pos2.x,     pos2.y,             pos2.z,
                pos2.x,     pos2.y,             pos2.z + size,
                colour_b.r, colour_b.g, colour_b.b, colour_b.a,
                colour_b.r, colour_b.g, colour_b.b, colour_b.a,
                colour_b.r, colour_b.g, colour_b.b, colour_b.a,
                dict,
                texture,
                0, 1, 0, 
                1, 1, 0,
                0, 0, 0
            )
              GRAPHICS._DRAW_SPRITE_POLY_2(
                pos1.x,     pos1.y,             pos1.z + size,
                pos1.x,     pos1.y,             pos1.z,
                pos2.x,     pos2.y,             pos2.z + size,
                colour_a.r, colour_a.g, colour_a.b, colour_a.a,
                colour_a.r, colour_a.g, colour_a.b, colour_a.a,
                colour_a.r, colour_a.g, colour_a.b, colour_a.a,
                dict,
                texture,
                0, 0, 0,
                1, 1, 0,
                1, 0, 0
            )
        else
            notification("not loaded")
        end 
    end
    self.arc_line = {}
    self.arc_line.new = function ()
        arc = {}
        arc.instability = 0.75
        arc.draw = function (pos1, pos2)
            local dif = {x = pos2.x - pos1.x, y = pos2.y - pos1.y, z = pos2.z - pos1.z}
            local distance_to_cover = math.sqrt(
                (dif.x * dif.x) +
                (dif.y * dif.y) +
                (dif.z * dif.z)
            )
            local nor_dir = {x = dif.x / distance_to_cover, y = dif.y / distance_to_cover,z = dif.z / distance_to_cover}

            for _ = 0, 3, 1 do
                local distance_covered = math.random() * 1.5
                local previous_pos = pos1
                repeat
                    local current_pos = {
                        x = pos1.x + nor_dir.x * distance_covered + (math.random() - 0.5) * arc.instability,
                        y = pos1.y + nor_dir.y * distance_covered + (math.random() - 0.5) * arc.instability,
                        z = pos1.z + nor_dir.z * distance_covered + (math.random() - 0.5) * arc.instability
                    }
                    GRAPHICS.DRAW_LINE(
                        previous_pos.x, previous_pos.y, previous_pos.z,
                        current_pos.x , current_pos.y , current_pos.z,
                        0, 255, 255, 255
                    )
                    previous_pos = current_pos
                    distance_covered = distance_covered + math.random() * 1.5
                until distance_covered > distance_to_cover
                GRAPHICS.DRAW_LINE(
                    previous_pos.x, previous_pos.y, previous_pos.z,
                    pos2.x , pos2.y , pos2.z,
                    0, 255, 255, 255
                )
            end

            arc.instability = arc.instability + (0.15 - arc.instability) *  MISC.GET_FRAME_TIME() * 7
        end
        return arc
    end
    local minimum = memory.alloc()
    local maximum = memory.alloc()
    local upVector_pointer = memory.alloc()
    local rightVector_pointer = memory.alloc()
    local forwardVector_pointer = memory.alloc()
    local position_pointer = memory.alloc()
    self.draw_bounding_box = function (entity, colour)
        ENTITY.GET_ENTITY_MATRIX(entity, rightVector_pointer, forwardVector_pointer, upVector_pointer, position_pointer);
        local forward_vector = memory.read_vector3(forwardVector_pointer)
        local right_vector = memory.read_vector3(rightVector_pointer)
        local up_vector = memory.read_vector3(upVector_pointer)

        MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
        local minimum_vec = memory.read_vector3(minimum)
        local maximum_vec = memory.read_vector3(maximum)
        local dimensions = {x = maximum_vec.y - minimum_vec.y, y = maximum_vec.x - minimum_vec.x, z = maximum_vec.z - minimum_vec.z}

        local top_right =           ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity,       maximum_vec.x, maximum_vec.y, maximum_vec.z)
        local top_right_back =      {x = forward_vector.x * -dimensions.y + top_right.x,        y = forward_vector.y * -dimensions.y + top_right.y,         z = forward_vector.z * -dimensions.y + top_right.z}
        local bottom_right_back =   {x = up_vector.x * -dimensions.z + top_right_back.x,        y = up_vector.y * -dimensions.z + top_right_back.y,         z = up_vector.z * -dimensions.z + top_right_back.z}
        local bottom_left_back =    {x = -right_vector.x * dimensions.x + bottom_right_back.x,  y = -right_vector.y * dimensions.x + bottom_right_back.y,   z = -right_vector.z * dimensions.x + bottom_right_back.z}
        local top_left =            {x = -right_vector.x * dimensions.x + top_right.x,          y = -right_vector.y * dimensions.x + top_right.y,           z = -right_vector.z * dimensions.x + top_right.z}
        local bottom_right =        {x = -up_vector.x * dimensions.z + top_right.x,             y = -up_vector.y * dimensions.z + top_right.y,              z = -up_vector.z * dimensions.z + top_right.z}
        local bottom_left =         {x = forward_vector.x * dimensions.y + bottom_left_back.x,  y = forward_vector.y * dimensions.y + bottom_left_back.y,   z = forward_vector.z * dimensions.y + bottom_left_back.z}
        local top_left_back =       {x = up_vector.x * dimensions.z + bottom_left_back.x,       y = up_vector.y * dimensions.z + bottom_left_back.y,        z = up_vector.z * dimensions.z + bottom_left_back.z}

        GRAPHICS.DRAW_LINE(
            top_right.x, top_right.y, top_right.z,
            top_right_back.x, top_right_back.y, top_right_back.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            top_right.x, top_right.y, top_right.z,
            top_left.x, top_left.y, top_left.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            top_right.x, top_right.y, top_right.z,
            bottom_right.x, bottom_right.y, bottom_right.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_left_back.x, bottom_left_back.y, bottom_left_back.z,
            bottom_right_back.x, bottom_right_back.y, bottom_right_back.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_left_back.x, bottom_left_back.y, bottom_left_back.z,
            bottom_left.x, bottom_left.y, bottom_left.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_left_back.x, bottom_left_back.y, bottom_left_back.z,
            top_left_back.x, top_left_back.y, top_left_back.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            top_left_back.x, top_left_back.y, top_left_back.z,
            top_right_back.x, top_right_back.y, top_right_back.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            top_left_back.x, top_left_back.y, top_left_back.z,
            top_left.x, top_left.y, top_left.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_right_back.x, bottom_right_back.y, bottom_right_back.z,
            top_right_back.x, top_right_back.y, top_right_back.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_left.x, bottom_left.y, bottom_left.z,
            top_left.x, top_left.y, top_left.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_left.x, bottom_left.y, bottom_left.z,
            bottom_right.x, bottom_right.y, bottom_right.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_right_back.x, bottom_right_back.y, bottom_right_back.z,
            bottom_right.x, bottom_right.y, bottom_right.z,
           colour.r, colour.g, colour.b, colour.a
        )
    end
    local numbers = {}
    local x_coord_ptr = memory.alloc(4)
    local y_coord_ptr = memory.alloc(4)
    local draw_numbers = function ()
        util.create_tick_handler(function() 
            local delta_time = MISC.GET_FRAME_TIME()
            for i, number in ipairs(numbers) do
                if GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(number.pos.x, number.pos.y, number.pos.z, x_coord_ptr, y_coord_ptr) then
                    local x = memory.read_float(x_coord_ptr)
                    local y = memory.read_float(y_coord_ptr)
                    local alpha = math.min(1, number.time)
                    directx.draw_text(x, y, number.num, ALIGN_CENTRE, number.size, {r = number.colour.r * alpha,g = number.colour.g * alpha,b = number.colour.b * alpha,a = number.colour.a * alpha}, false)
                    number.pos.z = number.pos.z + 0.2 * delta_time
                end
                number.time = number.time - delta_time
                if number.time < 0 then
                    table.remove(numbers, i)
                end
            end
            return #numbers ~= 0
        end)
    end
    local random_offset = 1
    self.draw_damage_number = function(entity, num, colour, size)
        pos = ENTITY.GET_ENTITY_COORDS(entity)
        random_offset_pos = {x = pos.x + (math.random() * random_offset - random_offset * 0.5),y = pos.y + (math.random() * random_offset - random_offset * 0.5),z = pos.z}
        numbers[#numbers+1] = {
            pos = random_offset_pos,
            colour = colour,
            num = num,
            size = size,
            time = 3
        }
        if #numbers == 1 then
            draw_numbers()
        end
    end
        --all credit to Nowiry#2663 for this one
        self.draw_button_tip = function (buttons, duration, colour)
            function equals(l1, l2)
                if l1 == l2 then return true end
                local type1 = type(l1)
                local type2 = type(l2)
                if type1 ~= type2 then return false end
                if type1 ~= 'table' then return false end
                for k, v in pairs(l1) do
                    if not l2[ k ] or not equals(v, l2[ k ]) then
                        return false
                    end
                end
                return true
            end
            local timer = 0
            util.create_tick_handler(function ()
                local INSTRUCTIONAL = {}
            INSTRUCTIONAL.scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE('instructional_buttons')
            INSTRUCTIONAL.isKeyboard = PAD._IS_USING_KEYBOARD(2)
        
            if not equals(buttons, INSTRUCTIONAL.currentsettup) or INSTRUCTIONAL.isKeyboard ~= PAD._IS_USING_KEYBOARD(2) then
                local colour = colour or {
                    ['r'] = 0,
                    ['g'] = 0,
                    ['b'] = 0
                }
        
                while not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(INSTRUCTIONAL.scaleform) do
                    util.yield()
                end
                
                GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'CLEAR_ALL')
                GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        
                GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'TOGGLE_MOUSE_BUTTONS')
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(true)
                GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        
                for i = 1, #buttons do
                    GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'SET_DATA_SLOT')
                    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(i) --position
                    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(PAD.GET_CONTROL_INSTRUCTIONAL_BUTTON(2, buttons[i][2], true)) --control
                    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(buttons[i][1]) --name
                    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(buttons[i][3] or false) --clickable
                    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(buttons[i][2]) --what control will be pressed when you click the button
                    GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
                end
        
                GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'SET_BACKGROUND_COLOUR')
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(colour.r)
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(colour.g)
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(colour.b)
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(80)
                GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        
                GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'DRAW_INSTRUCTIONAL_BUTTONS')
                GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        
                INSTRUCTIONAL.currentsettup = buttons
                INSTRUCTIONAL.isKeyboard = PAD._IS_USING_KEYBOARD(2)
            end
            GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(INSTRUCTIONAL.scaleform, 255, 255, 255, 255, 0)
            if timer > duration then
                return false
            end
            timer = timer + MISC.GET_FRAME_TIME()
            return true
            end)
        end
        return self
    end

b_colour = {}
b_colour.new = function ()
    local self = {}
    self.new = function (r, g, b, a)
        return {
            r = r,
            g = g,
            b = b,
            a = a
        }
    end
    self.white =    {r = 255,g = 255,b = 255,a = 255}

    self.black =    {r = 0,g = 0,b = 0,a = 255}

    self.magenta =  {r = 255,g = 0,b = 255,a = 255}

    self.red =      {r = 255,g = 0,b = 0,a = 255}

    self.green =    {r = 0,g = 255,b = 0,a = 255}

    self.blue =     {r = 0,g = 0,b = 255,a = 255}

    self.to_rage = function (colour)
        return {
            r = math.floor(colour.r * 255),
            g = math.floor(colour.g * 255),
            b = math.floor(colour.b * 255),
            a = math.floor(colour.a * 255)
        }
    end
    self.to_stand = function (colour)
        return {
            r = colour.r / 255,
            g = colour.g / 255,
            b = colour.b / 255,
            a = colour.a / 255
        }
    end
    return self
end

colour = b_colour.new()
drawing_funcs = b_drawing_funcs.new()
damage_numbers_target_ptr = memory.alloc(4)
damage_numbers_tracked_entities = {}
damage_numbers_health_colour = colour.to_stand(colour.new(20, 180, 50, 255))
damage_numbers_armour_colour = colour.to_stand(colour.new(50, 50, 200, 255))
damage_numbers_crit_colour = colour.to_stand(colour.new(200, 200, 10, 255))
damage_numbers_vehicle_colour = colour.to_stand(colour.new(200, 100, 20, 255))
damage_numbers_bone_ptr = memory.alloc(4)
damage_numbers_text_size = 0.700000
damage_numbers_target_vehicles = damage_numbers_text_size
function damage_numbers()
   if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), damage_numbers_target_ptr) then
        local target = memory.read_int(damage_numbers_target_ptr)
        if ENTITY.IS_ENTITY_A_PED(target) then
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(target, false)
            if vehicle ~= 0 and damage_numbers_target_vehicles then
                if damage_numbers_tracked_entities[vehicle] == nil then
                    damage_numbers_tracked_entities[vehicle] = {
                        health = math.max(0, ENTITY.GET_ENTITY_HEALTH(vehicle)),
                        timer = 1
                    }
                else
                    damage_numbers_tracked_entities[vehicle].timer = 1
                end
            end
                if damage_numbers_tracked_entities[target] == nil then
                    damage_numbers_tracked_entities[target] = {
                        health = math.max(0, ENTITY.GET_ENTITY_HEALTH(target) - 100),
                        armour = PED.GET_PED_ARMOUR(target),
                        timer = 1
                    }
                else
                    damage_numbers_tracked_entities[target].timer = 1
                end
        elseif ENTITY.IS_ENTITY_A_VEHICLE(target) and damage_numbers_target_vehicles then
            if damage_numbers_tracked_entities[target] == nil then
                damage_numbers_tracked_entities[target] = {
                    health = math.max(0, ENTITY.GET_ENTITY_HEALTH(target)),
                    timer = 1
                }
            else
                damage_numbers_tracked_entities[target].timer = 1
            end
        end
   end
   for entity, data in pairs(damage_numbers_tracked_entities) do
        if  ENTITY.IS_ENTITY_A_PED(entity) then
            local current_health = math.max(0, ENTITY.GET_ENTITY_HEALTH(entity) - 100)
            local current_armour = PED.GET_PED_ARMOUR(entity)
            if ENTITY.HAS_ENTITY_BEEN_DAMAGED_BY_ENTITY(entity, PLAYER.PLAYER_PED_ID(), 1) then
                if current_health < data.health then
                    data.timer = 1
                    PED.GET_PED_LAST_DAMAGE_BONE(entity, damage_numbers_bone_ptr)
                    if memory.read_int(damage_numbers_bone_ptr) == 31086 then
                        drawing_funcs.draw_damage_number(entity, data.health - current_health, damage_numbers_crit_colour, damage_numbers_text_size)
                    else
                        drawing_funcs.draw_damage_number(entity, data.health - current_health, damage_numbers_health_colour, damage_numbers_text_size)
                    end
                end
                if current_armour < data.armour then
                    data.timer = 1
                    drawing_funcs.draw_damage_number(entity, data.armour - current_armour, damage_numbers_armour_colour, damage_numbers_text_size)
                end
            end
            data.timer = data.timer - MISC.GET_FRAME_TIME()
            if data.timer < 0 then
                damage_numbers_tracked_entities[entity] = nil
            end
            data.health = current_health
            data.armour = current_armour
        else
            local current_health = math.max(0, ENTITY.GET_ENTITY_HEALTH(entity))
            if ENTITY.HAS_ENTITY_BEEN_DAMAGED_BY_ENTITY(entity, PLAYER.PLAYER_PED_ID(), 1) then
                if current_health < data.health then
                    data.timer = 1
                    drawing_funcs.draw_damage_number(entity, data.health - current_health, damage_numbers_vehicle_colour, damage_numbers_text_size)
                end
            end
            data.timer = data.timer - MISC.GET_FRAME_TIME()
            if data.timer < 0 then
                damage_numbers_tracked_entities[entity] = nil
            end
            data.health = current_health
        end
    end
end
--抛掷NPC/载具
function get_closest_veh(coords)
    local closest = nil
    local closest_dist = 1000000
    local this_dist = 0
    for _, veh in pairs(entities.get_all_vehicles_as_handles()) do 
        this_dist = v3.distance(coords, ENTITY.GET_ENTITY_COORDS(veh))
        if this_dist < closest_dist  and ENTITY.GET_ENTITY_HEALTH(veh) > 0 then
            closest = veh
            closest_dist = this_dist
        end
    end
    if closest ~= nil then 
        return {closest, closest_dist}
    else
        return nil 
    end
end
function request_anim_dict(dict)
    request_time = os.time()
    if not STREAMING.DOES_ANIM_DICT_EXIST(dict) then
        return
    end
    STREAMING.REQUEST_ANIM_DICT(dict)
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end
function get_model_size(hash)
    local minptr = memory.alloc(24)
    local maxptr = memory.alloc(24)
    MISC.GET_MODEL_DIMENSIONS(hash, minptr, maxptr)
    min = memory.read_vector3(minptr)
    max = memory.read_vector3(maxptr)
    local size = {}
    size['x'] = max['x'] - min['x']
    size['y'] = max['y'] - min['y']
    size['z'] = max['z'] - min['z']
    size['max'] = math.max(size['x'], size['y'], size['z'])

    memory.free(minptr)
    memory.free(maxptr)

    return size
end
function get_closest_ped_new(coords)
    local closest = nil
    local closest_dist = 1000000
    local this_dist = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do 
        this_dist = v3.distance(coords, ENTITY.GET_ENTITY_COORDS(ped))
        if this_dist < closest_dist and not PED.IS_PED_A_PLAYER(ped) and not PED.IS_PED_FATALLY_INJURED(ped)  and not PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
            closest = ped
            closest_dist = this_dist
        end
    end
    if closest ~= nil then 
        return {closest, closest_dist}
    else
        return nil 
    end
end
    local entity_held = 0
    local are_hands_up = false
    local ped_held = 0
function throwvehs()
    if PAD.IS_CONTROL_JUST_RELEASED(38, 38) and not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true)  then
        if entity_held == 0 then
            if not are_hands_up then 
                local closest = get_closest_veh(ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                local veh = closest[1]
                if veh ~= nil then 
                    local dist = closest[2]
                    if dist <= 5 then 
                        request_anim_dict("missminuteman_1ig_2")
                        TASK.TASK_PLAY_ANIM(players.user_ped(), "missminuteman_1ig_2", "handsup_enter", 8.0, 0.0, -1, 50, 0, false, false, false)
                        util.yield(500)
                        are_hands_up = true
                        ENTITY.SET_ENTITY_ALPHA(veh, 100)
                        ENTITY.SET_ENTITY_HEADING(veh, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
                        ENTITY.SET_ENTITY_INVINCIBLE(veh, true)
                        request_control_of_entity_once(veh)
                        ENTITY.ATTACH_ENTITY_TO_ENTITY(veh, players.user_ped(), 0, 0, 0, get_model_size(ENTITY.GET_ENTITY_MODEL(veh)).z / 2, 180, 180, -180, true, false, true, false, 0, true)
                        entity_held = veh
                    end 
                end
            else
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                are_hands_up = false
            end
        else
            if ENTITY.IS_ENTITY_A_VEHICLE(entity_held) then
                ENTITY.DETACH_ENTITY(entity_held)
                VEHICLE.SET_VEHICLE_FORWARD_SPEED(entity_held, 100.0)
                VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(entity_held, true, true)
                ENTITY.SET_ENTITY_ALPHA(entity_held, 255)
                ENTITY.SET_ENTITY_INVINCIBLE(veh, false)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), true)
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(entity_held, players.user_ped(), false)
                request_anim_dict("melee@unarmed@streamed_core")
                TASK.TASK_PLAY_ANIM(players.user_ped(), "melee@unarmed@streamed_core", "heavy_punch_a", 8.0, 8.0, -1, 0, 0.3, false, false, false)
                util.yield(500)
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
                entity_held = 0
                are_hands_up = false
            end
            -- toss
        end
    end
end
function throwpeds()
    if PAD.IS_CONTROL_JUST_RELEASED(38, 38) and not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then
        if entity_held == 0 then
            if not are_hands_up then 
                local closest = get_closest_ped_new(ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                if closest ~= nil then
                    local ped = closest[1]
                    if ped ~= nil then
                        local dist = closest[2]
                        if dist <= 5 then 
                            request_anim_dict("missminuteman_1ig_2")
                            TASK.TASK_PLAY_ANIM(players.user_ped(), "missminuteman_1ig_2", "handsup_enter", 8.0, 0.0, -1, 50, 0, false, false, false)
                            util.yield(500)
                            are_hands_up = true
                            ENTITY.SET_ENTITY_ALPHA(ped, 100)
                            ENTITY.SET_ENTITY_HEADING(ped, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
                            request_control_of_entity_once(ped)
                            ENTITY.ATTACH_ENTITY_TO_ENTITY(ped, players.user_ped(), 0, 0, 0, 1.3, 180, 180, -180, true, false, true, true, 0, true)
                            entity_held = ped
                        end 
                    end
                end
            else
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                are_hands_up = false
            end
        else
            if ENTITY.IS_ENTITY_A_PED(entity_held) then
                ENTITY.DETACH_ENTITY(entity_held)
                ENTITY.SET_ENTITY_ALPHA(entity_held, 255)
                PED.SET_PED_TO_RAGDOLL(entity_held, 10, 10, 0, false, false, false)
                --ENTITY.SET_ENTITY_VELOCITY(entity_held, 0, 100, 0)
                ENTITY.SET_ENTITY_MAX_SPEED(entity_held, 100.0)
                ENTITY.APPLY_FORCE_TO_ENTITY(entity_held, 1, 0, 100, 0, 0, 0, 0, 0, true, false, true, false, false)
                AUDIO.PLAY_PAIN(entity_held, 7, 0, 0)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), true)
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(entity_held, players.user_ped(), false)
                request_anim_dict("melee@unarmed@streamed_core")
                TASK.TASK_PLAY_ANIM(players.user_ped(), "melee@unarmed@streamed_core", "heavy_punch_a", 8.0, 8.0, -1, 0, 0.3, false, false, false)
                util.yield(500)
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
                entity_held = 0
                are_hands_up = false
            end
            -- toss
        end
    end
end
--恢复模型
function restore_model()
    if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
        menu.trigger_commands("mpmale")
        menu.trigger_commands("walkstyle normal")
    else
        menu.trigger_commands("mpfemale")
        menu.trigger_commands("walkstyle normal")
    end
end
function diaoshepao(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end
function kickcar(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
        player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        DECORATOR.DECOR_REGISTER("Player_Vehicle", 3)
        DECORATOR.DECOR_SET_INT(player_veh,"Player_Vehicle", 0)
    else
        util.toast("八嘎，玩家不在车内，踢不了")
    end
end
function request_weapon_asset(hash)
	WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 0)
	while not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) do util.yield_once() end
end
------------------------------------
-------------夜幕-移除玩家---------------
---------------------------------------
--阻止传出同步的信息
function BlockSyncs(pid, callback)
	for _, i in ipairs(players.list(false, true, true)) do
		if i ~= pid then
			local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
			menu.trigger_command(outSync, "on")
		end
	end
	wait(10)
	callback()
	for _, i in ipairs(players.list(false, true, true)) do
		if i ~= pid then
			local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
			menu.trigger_command(outSync, "off")
		end
	end
end
------招蜂引蝶
function zhaofengyindie_crash(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    local PED1  = CreatePed(28,-1011537562,pos,0)
    local PED2  = CreatePed(28,-541762431,pos,0)
    WEAPON.GIVE_WEAPON_TO_PED(PED1,-1813897027,1,true,true)
    WEAPON.GIVE_WEAPON_TO_PED(PED2,-1813897027,1,true,true)
    util.yield(1000)
    TASK.TASK_THROW_PROJECTILE(PED1,pos.x,pos.y,pos.z,0,0)
    TASK.TASK_THROW_PROJECTILE(PED2,pos.x,pos.y,pos.z,0,0)
end
-----放浪不羁
function fanglangbuju_crashes(pid)
    local cord = players.get_position(pid)
    local a1 = entities.create_object(-930879665, cord)
    local a2 = entities.create_object(3613262246, cord)
    local b1 = entities.create_object(452618762, cord)
    local b2 = entities.create_object(3613262246, cord)
    for i = 1, 10 do
        util.request_model(-930879665)
        util.yield(10)
        util.request_model(3613262246)
        util.yield(10)
        util.request_model(452618762)
        util.yield(300)
        entities.delete_by_handle(a1)
        entities.delete_by_handle(a2)
        entities.delete_by_handle(b1)
        entities.delete_by_handle(b2)
        util.request_model(452618762)
        util.yield(10)
        util.request_model(3613262246)
        util.yield(10)
        util.request_model(-930879665)
        util.yield(10)
    end
end
function IPHONE12(PlayerID)
    for i = 1, 10 do
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local cord = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        STREAMING.REQUEST_MODEL(1663218586)
        wait(10)
        STREAMING.REQUEST_MODEL(-891462355)
        wait(10)
        STREAMING.REQUEST_MODEL(-891462355)
        wait(10)
        STREAMING.REQUEST_MODEL(1663218586)
        wait(10)
        while not STREAMING.HAS_MODEL_LOADED(1663218586) do wait() end
        while not STREAMING.HAS_MODEL_LOADED(-891462355) do wait() end
        while not STREAMING.HAS_MODEL_LOADED(-891462355) do wait() end
        while not STREAMING.HAS_MODEL_LOADED(1663218586) do wait() end
        local a1 = entities.create_object(1663218586, cord)
        wait(10)
        local a2 = entities.create_object(-891462355, cord)
        wait(10)
        local b1 = entities.create_object(1663218586, cord)
        wait(10)
        local b2 = entities.create_object(1663218586, cord)
        wait(10)
        local b3 = entities.create_object(-891462355, cord)
        wait(300)
        entities.delete_by_handle(a1)
        entities.delete_by_handle(a2)
        entities.delete_by_handle(b1)
        entities.delete_by_handle(b2)
        entities.delete_by_handle(b3)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(1663218586)
        wait(10)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(-891462355)
        wait(10)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(-891462355)
        wait(10)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(1663218586)
        wait(10)
        end
    end




-----------IPHONE15
function qingtianzhu(PlayerID)
local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
local pos = players.get_position(PlayerID)
local mdl = util.joaat("mp_m_freemode_01")
local veh_mdl = util.joaat("taxi")
local veh_mdl2 = util.joaat("metrotrain")
local veh = entities.create_vehicle(veh_mdl, pos, 0)
local jesus = entities.create_ped(2, mdl, pos, 0)
local veh = entities.create_vehicle(veh_mdl2, pos, 0)
local hashes = {1890640474, 868868440, 868868440, 0x7B8B434B, 868868440, 0xD46F473712, 868868440, 0x7B8B434B, 1890640474, 868868440, 0x33C9E158, 868868440, 868868440, 0x33C9E158, 1890640474, 1890640474}
    local vehicles = {}
        util.request_model(veh_mdl)
        util.request_model(veh_mdl2)
        util.request_model(mdl)
    for i = 1, 10 do
        for i = 1, 10 do
            PED.SET_PED_INTO_VEHICLE(jesus, veh, -1)
            wait(100)
            TASK.TASK_VEHICLE_HELI_PROTECT(jesus, veh, ped, 10.0, 0, 10, 0, 0)
            wait(250)
        util.create_thread(function()
            RqModel(hashes[i])
            local pcoords = getEntityCoords(getPlayerPed(PlayerID))
            local veh =  VEHICLE.CREATE_VEHICLE(hashes[i], pcoords.x, pcoords.y, pcoords.z, math.random(0, 360), true, true, false)
            for a = 1, 20 do NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh) end
            VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
            for j = 0, 49 do
                local mod = VEHICLE.GET_NUM_VEHICLE_MODS(veh, j) - 1
                VEHICLE.SET_VEHICLE_MOD(veh, j, mod, true)
                VEHICLE.TOGGLE_VEHICLE_MOD(veh, mod, true)
            end
            for j = 0, 20 do
                if VEHICLE.DOES_EXTRA_EXIST(veh, j) then VEHICLE.SET_VEHICLE_EXTRA(veh, j, true) end
            end
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(veh, false)
            VEHICLE.SET_VEHICLE_WINDOW_TINT(veh, 1)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(veh, 1)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(veh, " ")
            for ai = 1, 50 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                pcoords = getEntityCoords(getPlayerPed(PlayerID))
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, pcoords.x, pcoords.y, pcoords.z, false, false, false)
                util.yield()
            end
            vehicles[#vehicles+1] = veh
        end)
    end
    wait(2500)
    menu.trigger_commands("explode" ..  players.get_name(PlayerID))
    entities.delete_by_handle(jesus)
    entities.delete_by_handle(veh)
    for _, v in pairs(vehicles) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(v)
    end
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(mdl)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_mdl)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_mdl2)
    end
end
























-----------------移除玩家功能结尾---------------------
function sendscriptevent_three()
    for pid = 0, 31 do
        if pid ~= players.user() and players.exists(pid) then
            util.trigger_script_event(1 << pid, {434937615, pid, 0, 1, id})
        end
    end
end
local function transitionValue(value, target, step)
    if value == target then return value end
    return value + step * ( value > target and -1 or 1 )
end

function fireBreathSettings:changePos(movementType)
    self.z.value = transitionValue(self.z.value, self.z[movementType], 0.01)
    self.y.value = transitionValue(self.y.value, self.y[movementType], 0.01)
end

levitationCommand = menu.ref_by_path('Self>Movement>Levitation>Levitation', 38)

function firebreathxxx(toggle)
    fireBreathSettings.on = toggle
    if toggle then
        while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do
            STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
            util.yield()
        end
        GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
        fireBreathSettings.ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE('muz_xs_turret_flamethrower_looping', players.user_ped(), 0, 0.12, 0.58, 30, 0, 0, 0x8b93, fireBreathSettings.scale, false, false, false)
        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireBreathSettings.ptfx, fireBreathSettings.colour.r, fireBreathSettings.colour.g, fireBreathSettings.colour.b)
    else
        GRAPHICS.REMOVE_PARTICLE_FX(fireBreathSettings.ptfx, true)
        fireBreathSettings.ptfx = nil
        STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
    end
    util.create_tick_handler(function()
        local user_ped = players.user_ped()
        if PED.GET_PED_PARACHUTE_STATE(user_ped) == 0 and ENTITY.IS_ENTITY_IN_AIR(user_ped) then
            GRAPHICS.SET_PARTICLE_FX_LOOPED_OFFSETS(fireBreathSettings.ptfx, 0, 0.81, 0, -10, 0, 0)
        elseif menu.get_value(levitationCommand) then
            GRAPHICS.SET_PARTICLE_FX_LOOPED_OFFSETS(fireBreathSettings.ptfx, 0, -0.12, 0.58, 150, 0, 0)
        else
            local movementType = 'still'
            if TASK.IS_PED_SPRINTING(user_ped) then
                movementType = 'sprint'
            elseif TASK.IS_PED_WALKING(user_ped) then
                movementType = 'walk'
            elseif PED.GET_PED_STEALTH_MOVEMENT(user_ped) then
                movementType = 'sneak'
            end

            fireBreathSettings:changePos(movementType)
            GRAPHICS.SET_PARTICLE_FX_LOOPED_OFFSETS(fireBreathSettings.ptfx, 0, fireBreathSettings.y.value, fireBreathSettings.z.value, 30, 0, 0)
        end
        return fireBreathSettings.on
    end)
end
function firebreathcolour(colour)
    fireBreathSettings.colour = colour
    GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireBreathSettings.ptfx, fireBreathSettings.colour.r, fireBreathSettings.colour.g, fireBreathSettings.colour.b)
end
function Specon(pid)
    menu.trigger_commands("spectate".. players.get_name(pid).. ' on')
    util.yield(3000)
end
function Specoff(pid)
    menu.trigger_commands("spectate".. players.get_name(pid).. ' off')
end
whitelistListTable = {}
function getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
        playerList = players.list(whitelistGroups.user, whitelistGroups.friends, whitelistGroups.strangers)
        notWhitelisted = {}
        for i = 1, #playerList do
            if not whitelistListTable[playerList[i]] and not (players.get_name(playerList[i]) == whitelistedName) then
                notWhitelisted[#notWhitelisted + 1] = playerList[i]
            end
        end
        return notWhitelisted
end
karma = {}
function playerIsTargetingEntity(playerPed)
    local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
    for k, playerPid in pairs(playerList) do
        if PLAYER.IS_PLAYER_TARGETTING_ENTITY(playerPid, playerPed) or PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(playerPid, playerPed) then
            karma[playerPed] = {
                pid = playerPid,
                ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerPid)
            }
            return true
        end
    end
    karma[playerPed] = nil
    return false
end
function sendscriptcrash()
    local userPed = players.user_ped()
    if playerIsTargetingEntity(userPed) and karma[userPed] then
        local karmaPid = karma[userPed].pid
util.trigger_script_event(1 << karmaPid, { -555356783, karmaPid ,85952,99999,52682274855,526822745 })
util.trigger_script_event(1 << karmaPid, { 526822748, karmaPid ,78552,99999 ,7949161,789454312})
util.trigger_script_event(1 << karmaPid, { -66669983, karmaPid ,526822748,555555, math.random(80521,2959749521) })
util.trigger_script_event(1 << karmaPid, { -1733737974, karmaPid ,789522 ,59486,48512151,-9545440,5845131,848153,math.random(1,2959749),189958})
util.trigger_script_event(1 << karmaPid, { -1529596656, karmaPid ,795221,59486,48512151,-9545440 , math.random(1,2959749) })
util.trigger_script_event(1 << karmaPid, { -8965204809, karmaPid ,795221,59486,48512151,-9545440 })
    end
end
function sendgobreach()
    local userPed = players.user_ped()
    if playerIsTargetingEntity(userPed) and karma[userPed] then
        local karmaPid = karma[userPed].pid
        util.trigger_script_event(1 << karmaPid, {-93722397 ,1, 0, 0, 4,0,karmaPid, karmaPid})
    end
end
function sendallplayercrash()
    local userPed = players.user_ped()
    if playerIsTargetingEntity(userPed) and karma[userPed] then
        GTPlayer(karma[userPed].ped, true, expSettings)
    end
end
function isAnyPlayerTargetingEntity(playerPed)
    local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
    for k, playerPid in pairs(playerList) do
        if PLAYER.IS_PLAYER_TARGETTING_ENTITY(playerPid, playerPed) or PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(playerPid, playerPed) then
            karma[playerPed] = {
                pid = playerPid,
                ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerPid)
            }
            return true
        end
    end
    karma[playerPed] = nil
    return false
end
function bulletaimkarma()
    local userPed = players.user_ped()
    if isAnyPlayerTargetingEntity(userPed) and karma[userPed] then
        local pos = ENTITY.GET_ENTITY_COORDS(karma[userPed].ped)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z + 0.1, 100, true, 100416529, userPed, true, false, 100.0)
        util.yield(getTotalDelay(expLoopDelay))
    end
end
function expaimkarma()
    local userPed = players.user_ped()
    if isAnyPlayerTargetingEntity(userPed) and karma[userPed] then
        explodePlayer(karma[userPed].ped, true, expSettings)
    end
end
function godaimkarma()
    local userPed = players.user_ped()
    if isAnyPlayerTargetingEntity(userPed) and karma[userPed] and players.is_godmode(karma[userPed].pid) then
        local karmaPid = karma[userPed].pid
        util.trigger_script_event(1 << karmaPid, {-1388926377, karmaPid, -1762807505, math.random(0, 9999)})
    end
end
local rgb = {cus = 100}
function RGBNeonKit(pedm)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    for i = 0, 3 do
        WIRI_VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, i, true)
    end
end
function rainbow_car()
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) ~= 0 then
        local vmod = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
        RGBNeonKit(players.user_ped())
        local red = (math.random(0, 255))
        local green = (math.random(0, 255))
        local blue = (math.random(0, 255))
        WIRI_VEHICLE.SET_VEHICLE_NEON_COLOUR(vmod, red, green, blue)
        WIRI_VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vmod, red, green, blue)
        WIRI_VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vmod, red, green, blue)
        util.yield(rgb.cus)
       end
    end

function set_speed_rainbowcar(c)
    rgb.cus = c
end
local srgb = {cus = 100}
function rainbow_car_light()
    local color = {
        {64, 1}, --blue
        {73, 2}, --eblue  
        {51, 3}, --mgreen
        {92, 4}, --lgreen
        {89, 5}, --yellow
        {88, 6}, --gshower
        {38, 7}, --orange
        {39 , 8}, --red
        {137, 9}, --ponypink
        {135, 10}, --hotpink
        {145, 11}, --purple
        {142, 12} --blacklight
      }
     if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ~= 0 then
      local vmod = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
      RGBNeonKit(players.user_ped())
      local rcolor = math.random(1, 12)
      WIRI_VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 22, true)
      WIRI_VEHICLE.SET_VEHICLE_NEON_INDEX_COLOUR(vmod, color[rcolor][1])
      WIRI_VEHICLE.SET_VEHICLE_COLOURS(vmod, color[rcolor][1], color[rcolor][1])
      WIRI_VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vmod, 0, color[rcolor][1])
      WIRI_VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(vmod, color[rcolor][1])
      WIRI_VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vmod, color[rcolor][2])
      util.yield(srgb.cus)
    end
end
function set_speed_light(c)
    srgb.cus = c
end
function EaseOutCubic(x)
    return 1 - ((1-x) ^ 3)
end
function EaseInCubic(x)
    return x * x * x
end
function EaseInOutCubic(x) --Thank you QUICKNET for re-writing this function!
    if(x < 0.5) then
        return 4 * x * x * x;
    else
        return 1 - ((-2 * x + 2) ^ 3) / 2
    end
end
function Get_Waypoint_Pos2()
        if HUD.IS_WAYPOINT_ACTIVE() then
            local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
            local waypoint_pos = HUD.GET_BLIP_COORDS(blip)
            return waypoint_pos
        else
            util.toast("标点啊吊毛")
        end
end
    CCAM = 0
STP_SPEED_MODIFIER = 0.02
STP_COORD_HEIGHT = 300

FRAME_STP = false

--preload
DR_TXT_SCALE = 0.5

--preload
EP_drawveh = true
EP_drawped = true
EP_drawobj = true
EP_drawpick = true
----
EPS_vehx = 0.0
EPS_vehy = 0.03
--
EPS_pedx = 0.0
EPS_pedy = 0.05
--
EPS_objx = 0.0
EPS_objy = 0.07
--
EPS_pickx = 0.0
EPS_picky = 0.09
--
FRAME_STP = false
    function SmoothTeleportToCord(v3coords, teleportFrame)
        local wppos = v3coords
        local localped = getPlayerPed(players.user())
        if wppos ~= nil then
            if not CAM.DOES_CAM_EXIST(CCAM) then
                CAM.DESTROY_ALL_CAMS(true)
                CCAM = CAM.CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", true)
                CAM.SET_CAM_ACTIVE(CCAM, true)
                CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, true, 0)
            end
            --
            if teleportFrame then
                util.create_tick_handler(function ()
                    if CAM.DOES_CAM_EXIST(CCAM) then
                        local tickCamCoord = CAM.GET_CAM_COORD(CCAM)
                        if not PED.IS_PED_IN_ANY_VEHICLE(localped, true) then 
                            ENTITY.SET_ENTITY_COORDS(localped, tickCamCoord.x, tickCamCoord.y, tickCamCoord.z, false, false, false, false) 
                        else
                            local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
                            ENTITY.SET_ENTITY_COORDS(veh, tickCamCoord.x, tickCamCoord.y, tickCamCoord.z, false, false, false, false)
                        end
                    else
                        return false
                    end
                end)
            end
            --
            local pc = getEntityCoords(getPlayerPed(players.user()))
            --
            for i = 0, 1, STP_SPEED_MODIFIER do 
                CAM.SET_CAM_COORD(CCAM, pc.x, pc.y, pc.z + EaseOutCubic(i) * STP_COORD_HEIGHT)
                directx.draw_text(0.5, 0.5, tostring(EaseOutCubic(i) * STP_COORD_HEIGHT), 1, 0.6, WhiteText, false)
                local look = util.v3_look_at(CAM.GET_CAM_COORD(CCAM), pc)
                CAM.SET_CAM_ROT(CCAM, look.x, look.y, look.z, 2)
                wait()
            end
    
            local currentZ = CAM.GET_CAM_COORD(CCAM).z
            local coordDiffx = wppos.x - pc.x
            local coordDiffxy = wppos.y - pc.y
            for i = 0, 1, STP_SPEED_MODIFIER / 2 do 
                CAM.SET_CAM_COORD(CCAM, pc.x + (EaseInOutCubic(i) * coordDiffx), pc.y + (EaseInOutCubic(i) * coordDiffxy), currentZ)
                wait()
            end
           
            local success, ground_z
            repeat
                STREAMING.REQUEST_COLLISION_AT_COORD(wppos.x, wppos.y, wppos.z)
                success, ground_z = util.get_ground_z(wppos.x, wppos.y)
                util.yield()
            until success
            if not PED.IS_PED_IN_ANY_VEHICLE(localped, true) then
                ENTITY.SET_ENTITY_COORDS(localped, wppos.x, wppos.y, ground_z, false, false, false, false) 
            else
                local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
                local v3Out = memory.alloc()
                local headOut = memory.alloc()
                PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(wppos.x, wppos.y, ground_z, v3Out, headOut, 1, 3.0, 0)
                local head = memory.read_float(headOut)
                memory.free(headOut)
                memory.free(v3Out)
                ENTITY.SET_ENTITY_COORDS(veh, wppos.x, wppos.y, ground_z, false, false, false, false)
                ENTITY.SET_ENTITY_HEADING(veh, head)
            end
            wait()
            local pc2 = getEntityCoords(getPlayerPed(players.user()))
            local coordDiffz = CAM.GET_CAM_COORD(CCAM).z - ground_z -2
            local camcoordz = CAM.GET_CAM_COORD(CCAM).z
          
            for i = 0, 1, STP_SPEED_MODIFIER / 2 do
                local pc23 = getEntityCoords(getPlayerPed(players.user()))
                CAM.SET_CAM_COORD(CCAM, pc23.x, pc23.y, camcoordz - (EaseOutCubic(i) * coordDiffz))
                wait()
            end
    
            wait()
    
            CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
            if CAM.IS_CAM_ACTIVE(CCAM) then
                CAM.SET_CAM_ACTIVE(CCAM, false)
            end
            CAM.DESTROY_CAM(CCAM, true)
        else
            util.toast("没标点！")
        end
    end
    function elqs()
        vehicleelqs = CreateVehicle (1491277511,ENTITY.GET_ENTITY_COORDS(players.user_ped(),false),0,true)
        ENTITY.SET_ENTITY_RENDER_SCORCHED(vehicleelqs,true)
        VEHICLE.SET_VEHICLE_COLOURS(vehicleelqs,147,147)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicleelqs,30,15)
        PED.SET_PED_INTO_VEHICLE(players.user_ped(),vehicleelqs,-1)
        util.yield(500)
        request_ptfx_asset(burning_man_ptfx_asset)
                for _, boneName in pairs({"wheel_lf", "wheel_lr"}) do
        GRAPHICS.USE_PARTICLE_FX_ASSET(burning_man_ptfx_asset)
                    local bone_id = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicleelqs, boneName)
                    fx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(burning_man_ptfx_effect, vehicleelqs, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, bone_id, 0.9, false, false, false, 0, 0, 0, 0)
                    looped_ptfxs[#looped_ptfxs+1] = fx
                    GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, 100, 100, 100, false)
              end
        end
function zcndxz(state)
    nt = state
    warehouse_scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE("WAREHOUSE")
    while nt do
        GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(warehouse_scaleform, "SHOW_OVERLAY")
        GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(warehouse_scaleform, 200, 200, 200, 200, 0)
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("喜不喜欢夜幕Lua？")
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("请选择以下选项之一")
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("灰常喜欢！")
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("炒鸡喜欢！")
        GRAPHICS.END_SCALEFORM_MOVIE_METHOD(warehouse_scaleform)
        util.yield()
     end
end
------------喷射
function request_ptfx_asset_peeloop(asset)
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)

    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        util.yield()
    end
end
function announce(string)
    if announce_actions then
        util.toast(string)
    end
end
function get_vehicle_ped_is_in(ped, includeLastVehicle)
    if includeLastVehicle or PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
        return PED.GET_VEHICLE_PED_IS_IN(ped, false)
    end
    return 0
end
function repair_player_vehicle(pid)
        local player_ped = PLAYER.GET_PLAYER_PED(pid)
        local player_vehicle = get_vehicle_ped_is_in(player_ped, include_last_vehicle_for_player_functions)
        if player_vehicle == 0 then
            util.toast("夜幕提醒:玩家不在车里.")
        else
            if request_control(player_vehicle) then
                VEHICLE.SET_VEHICLE_FIXED(player_vehicle)
                announce("夜幕提醒:已修复!")
            else
                util.toast("夜幕提醒:无法控制车辆.")
            end
        end
end
--喇叭加速
function remote_horn_boost(pid)
        local player_ped = PLAYER.GET_PLAYER_PED(pid)
        local player_vehicle = get_vehicle_ped_is_in(player_ped, false)
        if AUDIO.IS_HORN_ACTIVE(player_vehicle) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(player_vehicle)
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(player_vehicle, 1, 0.0, 1.0, 0.0, true, true, true, true) -- alternatively, VEHICLE.SET_VEHICLE_FORWARD_SPEED(...) -- not tested
        end
end


--3D射线
function request_texture_dict_load(dict_name)
    request_time = os.time()
    GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(dict_name, true)
    while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(dict_name) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end
----升级载具
function upgrade_vehicle(vehicle)
    for i = 0, 49 do
        local num = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i)
        VEHICLE.SET_VEHICLE_MOD(vehicle, i, num - 1, true)
    end
end
function request_control_of_entity(ent, time)
    if ent and ent ~= 0 then
        local end_time = os.clock() + (time or 3)
        while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and os.clock() < end_time do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
            util.yield()
        end
        return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent)
    end
    return false
end
replayInterface = memory.read_long(memory.rip(memory.scan("48 8D 0D ? ? ? ? 48 8B D7 E8 ? ? ? ? 48 8D 0D ? ? ? ? 8A D8 E8 ? ? ? ? 84 DB 75 13 48 8D 0D") + 3))
pedInterface = memory.read_long(replayInterface + 0x0018)
vehInterface = memory.read_long(replayInterface + 0x0010)
objectInterface = memory.read_long(replayInterface + 0x0028)
function shitixianshi(state)
            draw_string(string.format("~h~~p~夜幕~"..memory.read_int(pedInterface ).."/"..memory.read_int(pedInterface)), 0,0, 0.4,1)
            draw_string(string.format("~h~~w~PED ~m~  : ~b~"..memory.read_int(pedInterface + 0x0110).."/"..memory.read_int(pedInterface + 0x0108)), 0,0.03, 0.35,1)
            draw_string(string.format("~h~~w~载具 ~m~  : ~b~"..memory.read_int(vehInterface + 0x0190).."/"..memory.read_int(vehInterface + 0x0188)), 0,0.06, 0.35,1)
            draw_string(string.format("~h~~w_battle_airmissile_01~实体 ~m~  : ~b~"..memory.read_int(objectInterface + 0x0168).."/"..memory.read_int(objectInterface + 0x0160)), 0,0.09, 0.35,1)
			end		
local explosion_circle_angle = 0
function explosion_circle(ped, angle, radius)
    local ped_coords = ENTITY.GET_ENTITY_COORDS(ped)

    local offset_x = ped_coords.x
    local offset_y = ped_coords.y

    local x = offset_x + radius * math.cos(angle)
    local y = offset_y + radius * math.sin(angle)

    FIRE.ADD_EXPLOSION(x, y, ped_coords.z, 4, 1, true, false, 0)
end
--爆炸圈
function baozhanquan()
for k,v in pairs(players.list(true, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v)
            explosion_circle(ped, explosion_circle_angle, 25)
        end

        explosion_circle_angle += 0.15
        util.yield(50)
    end

local selectedOpt = 1
options_force  = {"摧毁"}
function forcefielddd()
    if selectedOpt == 1 then
		set_explosion_proof(players.user_ped(), true)
		local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
		FIRE.ADD_EXPLOSION(pos.x,pos.y,pos.z, 29, 5.0, false, true, 0.0, true)
	end
end
function forcefield_set(index)
    selectedOpt = index
end
function request_ptfx_asset(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end
--骑牛
local function request_model(hash, timeout)
    local end_time = os.time() + (timeout or 5)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) and end_time >= os.time() do
        util.yield()
    end
    return STREAMING.HAS_MODEL_LOADED(hash)
end
local function set_ped_apathy(ped, value)
    PED.SET_PED_CONFIG_FLAG(ped, 208, value)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, value)
    ENTITY.SET_ENTITY_INVINCIBLE(ped, value)
end
function ride_cow(state)
local player_heading = ENTITY.GET_ENTITY_HEADING(players.user_ped())
        local player_coords = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        if state then
            request_model(util.joaat("TRACTOR")) -- util.joaat("TRACTOR") == 1641462412 (tractor hash)
            vehicle_for_cow_rider = VEHICLE.CREATE_VEHICLE(util.joaat("TRACTOR"), player_coords.x, player_coords.y, player_coords.z, player_heading, true, true, false)
            request_model(util.joaat("A_C_Cow")) -- util.joaat("A_C_Cow") == 4244282910 (cow hash)
            ENTITY.SET_ENTITY_VISIBLE(vehicle_for_cow_rider, false, 0)
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle_for_cow_rider, -1)
            cow_for_cow_rider = PED.CREATE_PED(29, 4244282910, player_coords.x, player_coords.y, player_coords.z, player_heading, true, true)
            local bone = PED.GET_PED_BONE_INDEX(cow_for_cow_rider, 0x796e)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(cow_for_cow_rider, vehicle_for_cow_rider, bone, 0, -1, 0.5, 0, 0, 0, true, false, false, false, 1, false, false)
            ENTITY.SET_ENTITY_INVINCIBLE(vehicle_for_cow_rider, true)
            set_ped_apathy(cow_for_cow_rider, true)
            if not menu.get_value(menu.ref_by_path("Self>Glued To Seats")) then
                menu.trigger_command(menu.ref_by_path("Self>Glued To Seats", 38), "on")
                altered_seatbelt_state = true
            end
        else
            if altered_seatbelt_state then
                menu.trigger_command(menu.ref_by_path("Self>Glued To Seats", 38), "off")
            end
            entities.delete_by_handle(vehicle_for_cow_rider)
            entities.delete_by_handle(cow_for_cow_rider)
        end
end
----飞天扫把
function flying_broom(on)
    if on then 
            for _, boneId in ipairs(firebones) do
            request_ptfx_asset("scr_reconstructionaccident")
            GRAPHICS.USE_PARTICLE_FX_ASSET("scr_reconstructionaccident")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_sparking_generator", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)            end
        local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
        local broomstick = util.joaat("prop_tool_broom")
        local oppressor = util.joaat("oppressor2")
        request_model(broomstick)
        request_model(oppressor)
        obj = entities.create_object(broomstick, pos)
        veh = entities.create_vehicle(oppressor, pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(veh, false, false)
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, 0, 0, 0.3, -80.0, 0, 0, true, false, false, false, 0, true) -- thanks to chaos mod for doing the annoying rotation work for me :P
    else
        entities.delete_by_handle(obj)
        entities.delete_by_handle(veh)
        GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
    end
end

    function GetLocalPed()
        return PLAYER.PLAYER_PED_ID()
    end

    G_GeneratedList = false

    function AddEntityToList(listName, handle, generatedCheck)
        if ((not G_GeneratedList) and generatedCheck) or (not generatedCheck) then
            G_GeneratedList = true
            local lis = menu.list(menu.my_root(), listName .. " handle " .. handle, {}, "")
            menu.action(lis, "删除", {}, "", function()
                entities.delete_by_handle(handle)
                menu.delete(lis)
                G_GeneratedList = false
            end)
            menu.action(lis, "传送到实体", {}, "", function()
                local pos = ENTITY.GET_ENTITY_COORDS(handle)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(GetLocalPed(), pos.x, pos.y, pos.z + 1, false, false, false)
            end)
            menu.action(lis, "驾驶实体", {}, "", function()
                PED.SET_PED_INTO_VEHICLE(GetLocalPed(), handle, -1)
            end)
            menu.action(lis, "传送到我", {}, "", function()
                local pos = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(handle, pos.x, pos.y, pos.z + 1, false, false, false)
            end)
        end
    end
local ped_flags = {}
function firepersonl(on)
    ped_flags[430] = on
    if on then
        menu.trigger_commands("godmode off")
        FIRE.START_ENTITY_FIRE(PLAYER.PLAYER_PED_ID())
        ENTITY.SET_ENTITY_PROOFS(players.user_ped(), false, true, false, false, false, false, 0, false)
        menu.trigger_commands("demigodmode on")
    else
        FIRE.STOP_ENTITY_FIRE(PLAYER.PLAYER_PED_ID())
        ENTITY.SET_ENTITY_PROOFS(players.user_ped(), false, false, false, false, false, false, 0, false)
        menu.trigger_commands("godmode on")
    end
end
--骚扰
function zaoyin()		
    --{"Bed", "WastedSounds"}
        local pos = v3()
        local Audio_POS = {v3(-73.31681060791,-820.26013183594,326.17517089844),v3(2784.536,5994.213,354.275),v3(-983.292,-2636.995,89.524),v3(1747.518,4814.711,41.666),v3(1625.209,-76.936,166.651),v3(751.179,1245.13,353.832),v3(-1644.193,-1114.271,13.029),v3(462.795,5602.036,781.400),v3(-125.284,6204.561,40.164),v3(2099.765,1766.219,102.698)}
    
        for i = 1, #Audio_POS do
    
            AUDIO.PLAY_SOUND_FROM_COORD(-1, "Bed", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "WastedSounds", true, 999999999, true)
            pos.z = 2000.00
        
            AUDIO.PLAY_SOUND_FROM_COORD(-1, "Bed", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "WastedSounds", true, 999999999, true)
            pos.z = -2000.00
        
            AUDIO.PLAY_SOUND_FROM_COORD(-1, "Bed", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "WastedSounds", true, 999999999, true)
    
            for pid = 0, 31 do
                local pos =	NETWORK._NETWORK_GET_PLAYER_COORDS(pid)
                AUDIO.PLAY_SOUND_FROM_COORD(-1, "Bed", pos.x, pos.y, pos.z, "WastedSounds", true, 999999999, true)
        end
    end		
end
--将所有人传送到海洋
VehTeleportLoadIterations = 20
function TeleportEveryonesVehicleToOcean()
    local oldcoords = getEntityCoords(GetLocalPed())
    for i = 0, 31 do
        if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) then
            local ped = getPlayerPed(i)
            local pedCoords = getEntityCoords(ped)
            for c = 0, VehTeleportLoadIterations do --teleports us to them so we load their veh
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(GetLocalPed(), pedCoords.x, pedCoords.y, pedCoords.z + 10, false, false, false)
                wait(100)
            end
            if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
                local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
                for a = 0, 10 do
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, 4500, -4400, 4, false, false, false)
                    wait(100)
                end
                for b = 0, 10 do
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, 4500, -4400, 4, false, false, false)
                end
            end
        end
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(GetLocalPed(), oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
end
--将所有人传送到花园银行楼顶
function TeleportEveryonesVehicleToMazeBank()
    local oldcoords = getEntityCoords(GetLocalPed())
    for i = 0, 31 do
        if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) then
            local pped = getPlayerPed(i)
            local pedCoords = getEntityCoords(pped)
            for c = 0, VehTeleportLoadIterations do --teleports us to them so we load their veh
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(GetLocalPed(), pedCoords.x, pedCoords.y, pedCoords.z + 10, false, false, false)
                wait(100)
            end
            if PED.IS_PED_IN_ANY_VEHICLE(pped, false) then
                local veh = PED.GET_VEHICLE_PED_IS_IN(pped, false)
                for a = 0, 10 do
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, -76, -819, 327, false, false, false)
                    wait(100)
                end
                for b = 0, 10 do
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, -76, -819, 327, false, false, false)
                end
            end
        end
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(GetLocalPed(), oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
end
local ebigbigbig = false
function dachui6(on)
    if on then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02a"), pos.x, pos.y, pos.z, true, true, false)
        tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_mp_num_6"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
        util.yield(1000)
        ebigbigbig = on
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete_by_handle(dachui)
        entities.delete_by_handle(tongzi)
        ebigbigbig = off
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
    end
end
local bbigbigbig = false
function dachui3(on)
    if on then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02a"), pos.x, pos.y, pos.z, true, true, false)
        tongzi = OBJECT.CREATE_OBJECT(util.joaat("gr_prop_gr_doorpart"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
        util.yield(1000)
        bbigbigbig = on
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete_by_handle(dachui)
        entities.delete_by_handle(tongzi)
        bbigbigbig = off
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
    end
end
local dbigbigbig = false
function dachui5(on)
    if on then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02a"), pos.x, pos.y, pos.z, true, true, false)
        tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_sc1_06_gate_l"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
        util.yield(1000)
        dbigbigbig = on
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete_by_handle(dachui)
        entities.delete_by_handle(tongzi)
        dbigbigbig = off
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
    end
end
local vbigbigbig = false
function dachui16(on)
    if on then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02a"), pos.x, pos.y, pos.z, true, true, false)
        tongzi = OBJECT.CREATE_OBJECT(util.joaat("stt_prop_stunt_bowling_ball"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
        util.yield(1000)
        vbigbigbig = on
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete_by_handle(dachui)
        entities.delete_by_handle(tongzi)
        vbigbigbig = off
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
    end
end
local mbigbigbig = false
function dachui18(on)
    if on then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02a"), pos.x, pos.y, pos.z, true, true, false)
        tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_juicestand"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, 0.5, -35.0, 100.0,0, true, true, false, false, 0, true)
        util.yield(1000)
        mbigbigbig = on
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete_by_handle(dachui)
        entities.delete_by_handle(tongzi)
        mbigbigbig = off
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
    end
end
local nbigbigbig = false
function dachui17(on)
    if on then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02a"), pos.x, pos.y, pos.z, true, true, false)
        tongzi = OBJECT.CREATE_OBJECT(util.joaat("stt_prop_stunt_soccer_ball"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, 0.5, -35.0, 100.0,0, true, true, false, false, 0, true)
        util.yield(1000)
        nbigbigbig = on
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete_by_handle(dachui)
        entities.delete_by_handle(tongzi)
        nbigbigbig = off
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
    end
end
------崩溃,踢出,转魂
ent_types = {"没有", "行人", "载具", "实体"}
function get_aim_info()
    local outptr = memory.alloc(4)
    local success = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), outptr)
    local info = {}
    if success then
        local ent = memory.read_int(outptr)
        if not ENTITY.DOES_ENTITY_EXIST(ent) then
            info["ent"] = 0
        else
            info["ent"] = ent
        end
        if ENTITY.GET_ENTITY_TYPE(ent) == 1 then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ent, false)
            if veh ~= 0 then
                if VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1) then
                    ent = veh
                    info['ent'] = ent
                end
            end
        end
        info["hash"] = ENTITY.GET_ENTITY_MODEL(ent)
        info["health"] = ENTITY.GET_ENTITY_HEALTH(ent)
        info["type"] = ent_types[ENTITY.GET_ENTITY_TYPE(ent)+1]
        info["speed"] = math.floor(ENTITY.GET_ENTITY_SPEED(ent))
    else
        info['ent'] = 0
    end
    return info
end
---灵魂转移
function Soul_Gun()
    local ent = get_aim_info()['ent']
    if PED.IS_PED_SHOOTING(players.user_ped()) then
        if ENTITY.IS_ENTITY_A_PED(ent) then
            pos = ENTITY.GET_ENTITY_COORDS(ent, false)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), pos.x, pos.y, pos.z, false, false, false)
            if PED.IS_PED_A_PLAYER(ent) then
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
                menu.trigger_commands("copyoutfit " .. players.get_name(pid))
            else
            local soul = ENTITY.GET_ENTITY_MODEL(ent)
            STREAMING.REQUEST_MODEL(soul)
            while(not STREAMING.HAS_MODEL_LOADED(soul))
            do
            util.yield(10)
                end
            PLAYER.SET_PLAYER_MODEL(players.user(),soul)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(soul)
            if not PED.IS_PED_A_PLAYER(ent) then
                entities.delete_by_handle(ent)
            end
            util.yield(10)
            menu.trigger_commands("allguns")
        end
    end
        if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
            local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)
        if VEHICLE.GET_VEHICLE_NUMBER_OF_PASSENGERS(ent,true,false) >= 1 then
            local soulveh = ENTITY.GET_ENTITY_MODEL(driver)
            if not PED.IS_PED_A_PLAYER(driver) then
                entities.delete_by_handle(driver)
                end
                STREAMING.REQUEST_MODEL(soulveh)
                while(not STREAMING.HAS_MODEL_LOADED(soulveh))
                do
                util.yield(10)
                    end
            PLAYER.SET_PLAYER_MODEL(players.user(),soulveh)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(soulveh)
            util.yield(10)
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), ent, -1)
            menu.trigger_commands("allguns")
            end
        end
    end
end
--------命中效果
local HitEffect = {colorCanChange = false}
HitEffect.__index = HitEffect
setmetatable(HitEffect, Effect)
function HitEffect.new(asset, name, colorCanChange)
	local inst = setmetatable({}, HitEffect)
	inst.name = name
	inst.asset = asset
	inst.colorCanChange = colorCanChange or false
	return inst
end
hitEffects = {
	HitEffect.new("scr_rcbarry2", "scr_exp_clown"),
	HitEffect.new("scr_rcbarry2", "scr_clown_appears"),
	HitEffect.new("scr_rcpaparazzo1", "scr_mich4_firework_trailburst_spawn", true),
	HitEffect.new("scr_indep_fireworks", "scr_indep_firework_starburst", true),
	HitEffect.new("scr_indep_fireworks", "scr_indep_firework_fountain", true),
	HitEffect.new("scr_rcbarry1", "scr_alien_disintegrate"),
	HitEffect.new("scr_rcbarry2", "scr_clown_bul"),
	HitEffect.new("proj_indep_firework", "scr_indep_firework_grd_burst"),
	HitEffect.new("scr_rcbarry2", "muz_clown"),
}
--载具快速定制转弯
function FastTurnVehicleWithKeys(scale)
    local veh = PED.GET_VEHICLE_PED_IS_IN(GetLocalPed(), false)
    local vv = ENTITY.GET_ENTITY_ROTATION(veh, 2)
    local velocity = ENTITY.GET_ENTITY_SPEED_VECTOR(veh, true).y
    --Pitch: X || Roll: y || Yaw: z
    local vvPitch = v3.getX(vv)
    local vvRoll = v3.getY(vv)
    local vvYaw = v3.getZ(vv)
    if PAD.IS_CONTROL_PRESSED(0, 63) then --63 || INPUT_VEH_MOVE_LEFT_ONLY || A
        --OLD LOGIC || if velocity > 0 then --if velocity is greater than 0, we do usual turning logic.
        if PAD.IS_CONTROL_PRESSED(0, 71) or velocity > -0.1 then
            local yawAfterPress = vvYaw + scale
            if yawAfterPress > 180 then -- check for overflow
                local overFlowNeg = math.abs(vvYaw)*-1 --negative bypass overflow
                local toSetYaw = overFlowNeg + scale
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, toSetYaw, 2, true)
            else --if not overflow
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, yawAfterPress, 2, true)
            end
        elseif PAD.IS_CONTROL_PRESSED(0, 72) or velocity < -0.1 then --if not, then we do opposite turning logic.
            local yawAfterPress = vvYaw - scale
            if yawAfterPress < -180 then -- check for overflow
                local overFlowNeg = math.abs(vvYaw) --positive bypass overflow
                local toSetYaw = overFlowNeg - scale
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, toSetYaw, 2, true)
            else --if not overflow
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, yawAfterPress, 2, true)
            end
        end
    end
    if PAD.IS_CONTROL_PRESSED(0, 64) then --64 ||INPUT_VEH_MOVE_RIGHT_ONLY || D
        --OLD LOGIC || if velocity > 0 then --if velocity is greater than 0, we do usual turning logic.
        if PAD.IS_CONTROL_PRESSED(0, 71) or velocity > -0.1 then
        local yawAfterPress = vvYaw - scale
        if yawAfterPress < -180 then -- check for overflow
            local overFlowNeg = math.abs(vvYaw) --positive bypass overflow
            local toSetYaw = overFlowNeg - scale
            ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, toSetYaw, 2, true)
        else --if not overflow
            ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, yawAfterPress, 2, true)
        end
        elseif PAD.IS_CONTROL_PRESSED(0, 72) or velocity < -0.1 then --if not, then we do opposite turning logic.

            local yawAfterPress = vvYaw + scale
            if yawAfterPress > 180 then -- check for overflow
                local overFlowNeg = math.abs(vvYaw)*-1 --negative bypass overflow
                local toSetYaw = overFlowNeg + scale
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, toSetYaw, 2, true)
            else --if not overflow
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, yawAfterPress, 2, true)
            end
        end

    end
    v3.free(vv)
end
local YMencouragement1={
    "夜幕LUA为你保驾护航",
}
random_notify1 = math.random(1,#YMencouragement1)
function YM_label_setting(YMlabel, text)
    log("Setting up YMlabel present for label " .. YMlabel .. " with text " .. text)
    menu.trigger_commands("addlabel " .. YMlabel)
    local prep = "edit" .. string.gsub(YMlabel, "_", "") .. " " .. text
    menu.trigger_commands(prep)
    end
    function YMlabel()
    YM_label_setting("HUD_JOINING", "欢迎尊贵的夜幕用户加入GTA在线模式")
    YM_label_setting("HUD_MAINTIT", "夜幕LUA")
    YM_label_setting("LOADING_SPLAYER_L", "夜幕LUA为你加载故事模式")
    YM_label_setting("PM_QUIT_MP", "夜幕LUA带你离开GTA在线模式")
    YM_label_setting("PM_INF_LEAT", "夜幕LUA")
    YM_label_setting("PM_INF_LEAB", "跟随夜幕一同前往GTA故事模式，您的所有游戏进度都将保存在R星的服务器中")
    YM_label_setting("UI_FLOW_OP_CL_M", "关于夜幕团队")
    YM_label_setting("UI_FLOW_OP_CL", "关于 夜幕团队 ")
    YM_label_setting("RESPAWN_W_MP", "" .. YMencouragement1[random_notify1] .. "")
    YM_label_setting("FE_THDR_GTAO", "夜幕LUA在线模式")
    YM_label_setting("PM_INF_EXIT", "下次遇见会更好！")
    YM_label_setting("CELL_29", "鸭梨手机")
    YM_label_setting("EXIT_SURE_2", "你确定要退出侠盗猎车手V吗？任何未保存的进度都将丢失，夜幕LUA期待你的下次使用！")
    YM_label_setting("UI_FLOW_OP_CL_d", "夜幕秉承 稳定 可靠 配合 简单 简洁的团队理念\n\n主要策划:Ping 副策划:呆呆\n致谢人员：" .. players.get_name(players.user()) .. "感谢你的使用""\n夜幕官方群聊:859074951\n感谢使用夜幕！")
end
function has_anim_dict_loaded(dict)
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        STREAMING.REQUEST_ANIM_DICT(dict)
        util.yield(0)
    end
end
local i_forward = 360
function forward_roll()
    has_anim_dict_loaded("misschinese2_crystalmaze")
    TASK.TASK_PLAY_ANIM(players.user_ped(), "misschinese2_crystalmaze", "2int_loop_a_taotranslator", 8.0, 8.0, -1, 0, 0.0, 0, 0, 0)
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
    local user_rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 0)
    local fwd_vect = ENTITY.GET_ENTITY_FORWARD_VECTOR(players.user_ped())
    local speed = ENTITY.GET_ENTITY_SPEED(players.user_ped()) * 2.236936
    PED.SET_PED_CAN_RAGDOLL(players.user_ped(), false)
    ENTITY.SET_ENTITY_ROTATION(players.user_ped(), i_forward, user_rot.y, cam_rot.z, 2, true)
    if speed <= 70 then
        ENTITY.APPLY_FORCE_TO_ENTITY(players.user_ped(), 3, fwd_vect.x, fwd_vect.y, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, false)
    end
    if i_forward <= 0 then i_forward = 360 else i_forward = i_forward - 6 end 
end
function end_forward_roll()
    util.yield(100)
    PED.SET_PED_CAN_RAGDOLL(players.user_ped(), true)
    TASK.STOP_ANIM_TASK(players.user_ped(), "misschinese2_crystalmaze", "2int_loop_a_taotranslator", 1)
end
local rotation = 0
local loop_count = 0
local dict, name
function breakdance()
    if loop_count <= 200 then
        dict = "missfbi5ig_20b"
        name = "hands_up_scientist"
    elseif loop_count <= 400 then
        dict = "nm@hands"
        name = "hands_up"
    elseif loop_count <= 600 then
        dict = "missheist_agency2ahands_up"
        name = "handsup_anxious"
    elseif loop_count <= 800 then
        dict = "missheist_agency2ahands_up"
        name = "handsup_loop"
    end
    ENTITY.SET_ENTITY_ROTATION(players.user_ped(), 180, 0, rotation, 1, true)
    has_anim_dict_loaded(dict)
    TASK.TASK_PLAY_ANIM(players.user_ped(), dict, name, 8.0, 0, -1, 0, 0.0, 0, 0, 0)
    rotation = rotation + 5
    if loop_count < 1000 then
        loop_count = loop_count + 1
    else
        loop_count = 0
    end
end
function end_breakdance()
    util.yield(100)
    TASK.STOP_ANIM_TASK(players.user_ped(), dict, name, 1)
end
----世界重力
World_gravity_option = {
    {"正常世界",    {"default"}, ""},
    {"低引力",      {"low"},     ""},
    {"非常低",  {"verylow"}, ""},
    {"无引力",  {"none"},    ""},
}
    function request_control_of_table_once(tbl)
        for index, entity in ipairs(tbl) do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
        end
    end
    function World_gravity(option_index)
        gravity_current_index = option_index
        if option_index ~= 1 then
            while gravity_current_index == option_index do
                request_control_of_table_once(entities.get_all_vehicles_as_handles())
                request_control_of_table_once(entities.get_all_objects_as_handles())
                request_control_of_table_once(entities.get_all_peds_as_handles())
                request_control_of_table_once(entities.get_all_pickups_as_handles())
                MISC.SET_GRAVITY_LEVEL(option_index - 1)
                util.yield()
            end
        else
            MISC.SET_GRAVITY_LEVEL(option_index - 1)
        end
    end
--------匿名杀死所有人
function kill_player(pid)
    local entity = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
    FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'] + 2, 7, 1000, false, true, 0)
end
function nimingsharen()
for k,v in pairs(players.list(false, true, true)) do
    kill_player(v)
    util.yield()
end
end
function unlimitedbullet(toggle)
    isInfiniteAmmo = toggle

    while isInfiniteAmmo do
        WEAPON.SET_PED_INFINITE_AMMO_CLIP(PLAYER.PLAYER_PED_ID(), true)
        wait()
    end

    if not isInfiniteAmmo then
        WEAPON.SET_PED_INFINITE_AMMO_CLIP(PLAYER.PLAYER_PED_ID(), false)
    end
end
function lockthebullet()
    local curWeaponMem = memory.alloc()
    local junk = WEAPON.GET_CURRENT_PED_WEAPON(PLAYER.PLAYER_PED_ID(), curWeaponMem, 1)
    local curWeapon = memory.read_int(curWeaponMem)
    memory.free(curWeaponMem)

    local curAmmoMem = memory.alloc()
    junk = WEAPON.GET_MAX_AMMO(PLAYER.PLAYER_PED_ID(), curWeapon, curAmmoMem)
    local curAmmoMax = memory.read_int(curAmmoMem)
    memory.free(curAmmoMem)

    if curAmmoMax then
        WEAPON.SET_PED_AMMO(PLAYER.PLAYER_PED_ID(), curWeapon, curAmmoMax)
    end
end
function YMplan3(YM)
    start1time = os.time()
    local startX = 0
    devhf = YM
    while devhf do
        wait()
        
        GRAPHICS.DRAW_RECT(.99, 0.24, 1, 0.015, 240, 230, 250, 180)

        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.085, 0.10)
        HUD.SET_TEXT_SCALE(0.80, 0.75)
        HUD.SET_TEXT_FONT(5)
        HUD.SET_TEXT_CENTRE(1)
        HUD.SET_TEXT_OUTLINE(0)
        HUD.SET_TEXT_COLOUR(255, 255, 255, 255)
        util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("~h~&#8721;夜幕主策划人员 " .. playerrid .. " 目前在你的战局&#8721;")
        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(startX + 0.75, 0.18)
        
        if os.time() - start1time >= 6 then
        devhf = false
        end
        end
        --devhf = false
    end
function YMplan4(YM2)
    start1time1 = os.time()
    local startX = 0
    zanzhu = YM2
    while zanzhu do
        wait()
        
        GRAPHICS.DRAW_RECT(.99, 0.24, 1, 0.015, 255, 215, 50, 255)

        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.085, 0.10)
        HUD.SET_TEXT_SCALE(0.80, 0.75)
        HUD.SET_TEXT_FONT(5)
        HUD.SET_TEXT_CENTRE(1)
        HUD.SET_TEXT_OUTLINE(0)
        HUD.SET_TEXT_COLOUR(255, 255, 255, 255)
        util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("~h~~y~&#8721;夜幕VIP人员 " .. playerid .. " 目前在你的战局&#8721;")
        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(startX + 0.75, 0.18)
        
        if os.time() - start1time1 >= 5 then
        zanzhu = false
        end
        end
        --zanzhu = false
end
-------------------自崩
function exit_game()
    local pedhash = -67533719
    STREAMING.REQUEST_MODEL(pedhash)
    local tesla_ped = entities.create_ped(32, pedhash, players.get_position(players.user()), 0)
    ENTITY.DELETE_ENTITY(entities.handle_to_pointer(tesla_ped))
end
function YMblack(YM3)
    start1time2 = os.time()
    local startX = 0
    heiming = YM3
    while heiming do     
     util.toast("SB玩什么GTA?")
     wait(3000)
     exit_game()
        end
    end
----叛逆车辆
function car_crash(state)
    veh = entities.get_user_vehicle_as_handle()
    if state then
        VEHICLE._SET_VEHICLE_CONTROLS_INVERTED(veh, true)
    else
        VEHICLE._SET_VEHICLE_CONTROLS_INVERTED(veh, false)
    end
end
----加速垫
function jiasudian()
    local coords = players.get_position(players.user())
        coords.z = coords.z - 0.3
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local heading = ENTITY.GET_ENTITY_HEADING(player)
        local heading = heading + 80
        local boostpad = entities.create_object(3287988974, coords)
        ENTITY.SET_ENTITY_HEADING(boostpad, heading)
end
function Xjiasudian()
    local coords = players.get_position(players.user())
        coords.z = coords.z - 0.3
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local heading = ENTITY.GET_ENTITY_HEADING(player)
        local heading = heading + 80
        local boostpad = entities.create_object(3287988974, coords)
        local boostpad1 = entities.create_object(3287988974, coords)
        ENTITY.SET_ENTITY_HEADING(boostpad, boostpad1, heading)
end
function sigejiasudian()
    local coords = players.get_position(players.user())
        coords.z = coords.z - 0.3
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local heading = ENTITY.GET_ENTITY_HEADING(player)
        local boostpad = entities.create_object(-388593496, coords)
        ENTITY.SET_ENTITY_HEADING(boostpad, heading)
end
function jiansudai()
    local coords = players.get_position(players.user())
        coords.z = coords.z - 0.4
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local heading = ENTITY.GET_ENTITY_HEADING(player)
        local heading = heading + 80
        local boostpad = entities.create_object(-227275508, coords)
        ENTITY.SET_ENTITY_HEADING(boostpad, heading)
end
function Xjiansudai()
    local coords = players.get_position(players.user())
        coords.z = coords.z - 0.4
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local heading = ENTITY.GET_ENTITY_HEADING(player)
        local heading = heading + 80
        local boostpad = entities.create_object(-227275508, coords)
        local boostpad1 = entities.create_object(-227275508, coords)
        ENTITY.SET_ENTITY_HEADING(boostpad, boostpad1, heading)
end
function direction()
    local c1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
    local res = raycast_gameplay_cam(-1, 1000)
    local c2
    if res[1] ~= 0 then
        c2 = res[2]
    else
        c2 = get_offset_from_gameplay_camera(1000)
    end
    c2.x = (c2.x - c1.x) * 1000
    c2.y = (c2.y - c1.y) * 1000
    c2.z = (c2.z - c1.z) * 1000
    return c2, c1
end
function raycast_gameplay_cam(flag, distance)
    local ptr1, ptr2, ptr3, ptr4 = memory.alloc(), memory.alloc(), memory.alloc(), memory.alloc()
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = toDirection(CAM.GET_GAMEPLAY_CAM_ROT(0))
    local destination =
    {
        x = cam_pos.x + direction.x * distance,
        y = cam_pos.y + direction.y * distance,
        z = cam_pos.z + direction.z * distance
    }
    SHAPETEST.GET_SHAPE_TEST_RESULT(
        SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
            cam_pos.x,
            cam_pos.y,
            cam_pos.z,
            destination.x,
            destination.y,
            destination.z,
            flag,
            -1,
            1
        ), ptr1, ptr2, ptr3, ptr4)
    local p1 = memory.read_int(ptr1)
    local p2 = memory.read_vector3(ptr2)
    local p3 = memory.read_vector3(ptr3)
    local p4 = memory.read_int(ptr4)
    return {p1, p2, p3, p4}
end
function disableProjectileLoop(projectile)
    WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(projectile, false)
end
mutually_exclusive_weapons  = {}
function nukegunmode()
        if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) == -1312131151 then --if holding homing launcher
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                disableProjectileLoop(-1312131151)                
                util.create_thread(function()
                    local hash = util.joaat('w_arena_airmissile_01a')
                    loadModel(hash)

                    local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
                    local dir, pos = direction()

                    local bomb = entities.create_object(hash, pos)
                    ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
                    ENTITY.SET_ENTITY_ROTATION(bomb, cam_rot.x, cam_rot.y, cam_rot.z, 1, true)

                    while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do
                        util.yield()
                    end
                    local nukePos = ENTITY.GET_ENTITY_COORDS(bomb, true)
                    entities.delete_by_handle(bomb)
                    executeNuke(nukePos)
                end)
            end
        end
end
-------核弹枪
function toDirection(rotation) 
	local adjusted_rotation = { 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = {
		x = - math.sin(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)), 
		y =   math.cos(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)), 
		z =   math.sin(adjusted_rotation.x)
	}
	return direction
end
----抓钩枪
function grappling_gun()
    if PED.IS_PED_SHOOTING(players.user_ped()) and PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) then
        local raycast_coord = raycast_gameplay_cam(-1, 10000.0)
        if raycast_coord[1] == 1 then
            local lastdist = nil
            TASK.TASK_SKY_DIVE(players.user_ped())
            while true do
                if PAD.IS_CONTROL_JUST_PRESSED(45, 45) then 
                    break
                end
                if raycast_coord[4] ~= 0 and ENTITY.GET_ENTITY_TYPE(raycast_coord[4]) >= 1 and ENTITY.GET_ENTITY_TYPE(raycast_coord[4]) < 3 then
                    ggc1 = ENTITY.GET_ENTITY_COORDS(raycast_coord[4], true)
                else
                    ggc1 = raycast_coord[2]
                end
                local c2 = players.get_position(players.user())
                local dist = MISC.GET_DISTANCE_BETWEEN_COORDS(ggc1['x'], ggc1['y'], ggc1['z'], c2['x'], c2['y'], c2['z'], true)
                -- safety
                if not lastdist or dist < lastdist then 
                    lastdist = dist
                else
                    break
                end
                if ENTITY.IS_ENTITY_DEAD(players.user_ped()) then
                    break
                end
                if dist >= 10 then
                    local dir = {}
                    dir['x'] = (ggc1['x'] - c2['x']) * dist
                    dir['y'] = (ggc1['y'] - c2['y']) * dist
                    dir['z'] = (ggc1['z'] - c2['z']) * dist
                    ENTITY.SET_ENTITY_VELOCITY(players.user_ped(), dir['x'], dir['y'], dir['z'])
                end
                util.yield()
            end
        end
    end
end
----创建PED(鲨鱼枪,黑人抬棺,)
function Cped(type, hash, pos, dir)
    request_model(hash, 300)
    local ped = entities.create_ped(type, hash, pos, dir, true, false)
    STREAMING.REQUEST_MODEL(hash)
    return ped
end
----鲨鱼枪
function Shark_gun()
    local pos = v3.new()
	if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), pos) then
        local NPC = Cped(26, 0x06C3F072, pos , 0)
        ENTITY.FREEZE_ENTITY_POSITION(NPC, true)
        ENTITY.SET_ENTITY_ROTATION(NPC, 90, 0, 0, true)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 4, 100, true, false, 1, false)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 13, 1, true, false, 0, false)
    end
end
function EntityPair_new(ent1, ent2)----原函数名EntityPair.new()
	local instance = setmetatable({}, EntityPair)
	instance.ent1 = ent1
	instance.ent2 = ent2
	return instance
end
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
entityPairs = {}
function ctst()
    local entity = get_entity_player_is_aiming_at(players.user())
	if entity ~= 0 and ENTITY.DOES_ENTITY_EXIST(entity) then
		draw_bounding_box(entity, true, {r = 255, g = 255, b = 255, a = 81})

		if PED.IS_PED_SHOOTING(players.user_ped()) and
		not (shotEntities[1] and shotEntities[1] == entity) then
			counter = counter + 1
			shotEntities[counter] = entity
		end

		if counter == 2 then
			local entPair = EntityPair_new(table.unpack(shotEntities))
			table.insert_once(entityPairs, entPair)
			counter = 0
			shotEntities = {}
		end
	end
	for i = #entityPairs, 1, -1 do
		local entPair = entityPairs[i]
		if entPair:exists() then 
            entPair:attract() 
        else 
            table.remove(entityPairs, i) 
        end
	end
end
function ctst_stop()
    counter = 0
	shotEntities = {}; entityPairs = {}
end
----坐如磐石
function sitrock(on)
    if on then 
        local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
        local rock = util.joaat("prop_rock_3_b")
        local oppressor = util.joaat("oppressor2")
        request_model(rock)
        request_model(oppressor)
        obj = entities.create_object(rock, pos)
        veh = entities.create_vehicle(oppressor, pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(veh, false, false)
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, veh, 45, 0, 0, -0.7, 80, 0, 0, true, false, false, false, 50, true) -- thanks to chaos mod for doing the annoying rotation work for me :P
    else
        entities.delete_by_handle(obj)
        entities.delete_by_handle(veh)
        GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
    end
end
----使用效果
function use_fx_asset(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
		STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
		util.yield(0)
	end
    GRAPHICS.USE_PARTICLE_FX_ASSET(asset)
end
----娱乐粒子效果
local selptfx = {a= "core",b= "ent_dst_gen_gobstop",c ="5"}
function ptfx_fun()
    local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
    use_fx_asset(selptfx.a)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(selptfx.b, tar1.x, tar1.y, tar1.z, 0, 0, 0, selptfx.c, true, true, false)
    util.yield(200)
end
function sel_ptfx_fun(value)
    local ptfx = funptfx[value]
    selptfx.c = ptfx[3]--size
    selptfx.b = ptfx[2]--eff
    selptfx.a = ptfx[1]--ptfx
end
----死亡日志
local Death_Log = filesystem.store_dir() .. 'YMLog\\YM DeathLog\\Death_Log.txt'
local DeathlogDir = filesystem.store_dir() .. 'YMLog\\YM DeathLog'
function add_deathlog(time, name, weapon)
    local file, errmsg = io.open(Death_Log, "a+")
    if not file then
        return false, errmsg
    end
    file:write(json.stringify(time..' '..name..' 类型: '..weapon, nil, 0, false)..'\n')
    file:close()
    return input, true
end
function death_log()
    if PED.IS_PED_DEAD_OR_DYING(players.user_ped()) then
        killer = PED.GET_PED_SOURCE_OF_DEATH(players.user_ped())
        if killer == players.user_ped() then return end
        if STREAMING.IS_MODEL_A_PED(ENTITY.GET_ENTITY_MODEL(killer)) then
            local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(killer)
            local pname = PLAYER.GET_PLAYER_NAME(pid)
            local ts = os.time()
            local time = os.date('%Y-%m-%d %H:%M:%S', ts)
            if pname != nil then
                add_deathlog("时间：["..time.."]", "玩家: "..pname, '武器')
            end
            util.toast('被'..pname..'使用武器击杀')
            util.yield(12000)
        elseif STREAMING.IS_MODEL_A_VEHICLE(ENTITY.GET_ENTITY_MODEL(killer)) then
            local vehowner = entities.get_owner(entities.handle_to_pointer(killer))
            local pname = PLAYER.GET_PLAYER_NAME(vehowner)
            local ts = os.time()
            local time = os.date('%Y-%m-%d %H:%M:%S', ts)
            if pname != nil then
                add_deathlog("["..time.."]", "玩家: "..pname, '载具')
            end
            util.toast('被'..pname..'使用载具击杀')
            util.yield(12000)
        end
    end
end
function open_dea_log()
    util.open_folder(DeathlogDir)
end
function clear_dea_log()
    io.remove(Death_Log)
      local notification = b_notifications.new()
      notification.notify("夜幕死亡日志","清除完成！")
end
-----死亡屏障击杀
function Death_barrier(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = players.get_position(pid)                            
    local hash = util.joaat("prop_windmill_01")
    local mdl = util.joaat("rallytruck")
    RequestModel(hash)
    RequestModel(mdl)
    for i = 0, 5 do
        if TASK.IS_PED_WALKING(ped) then
            spawn_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 1.3, 0.0)
        else
            spawn_pos = players.get_position(pid)
        end
        local obj = entities.create_object(hash, spawn_pos)
        local veh = entities.create_vehicle(mdl, spawn_pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(obj, false)
        ENTITY.SET_ENTITY_VISIBLE(veh, false)
        ENTITY.SET_ENTITY_INVINCIBLE(obj, true)
        ENTITY.SET_ENTITY_COLLISION(obj, true, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 10, 10, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        util.yield(150)
        entities.delete_by_handle(obj)
        entities.delete_by_handle(veh)
    end
end
----仓鼠球
function Hamster_Ball(pid)
    local hash = 1768956181
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0, 0, -1)

    local OBJ = entities.create_object(hash, pos)
    local OBJ1 = entities.create_object(hash, pos)
    local OBJ2 = entities.create_object(hash, pos)
    local OBJ3 = entities.create_object(hash, pos)
    local OBJ4 = entities.create_object(hash, pos)
    local OBJ5 = entities.create_object(hash, pos)
    local OBJ6 = entities.create_object(hash, pos)
    local OBJ7 = entities.create_object(hash, pos)
    local OBJ8 = entities.create_object(hash, pos)
    local OBJ9 = entities.create_object(hash, pos)
    local OBJ10 = entities.create_object(hash, pos)
    local OBJ11 = entities.create_object(hash, pos)
    local OBJ12 = entities.create_object(hash, pos)
    local OBJ13 = entities.create_object(hash, pos)
    local OBJ14 = entities.create_object(hash, pos)
    local OBJ15 = entities.create_object(hash, pos)
    local OBJ16 = entities.create_object(hash, pos)
    local OBJ17 = entities.create_object(hash, pos)

    ENTITY.SET_ENTITY_ROTATION(OBJ, 0, 0, 0)
    ENTITY.SET_ENTITY_ROTATION(OBJ1, 0, 0, 10)
    ENTITY.SET_ENTITY_ROTATION(OBJ2, 0, 0, 20)
    ENTITY.SET_ENTITY_ROTATION(OBJ3, 0, 0, 30)
    ENTITY.SET_ENTITY_ROTATION(OBJ4, 0, 0, 40)
    ENTITY.SET_ENTITY_ROTATION(OBJ5, 0, 0, 50)
    ENTITY.SET_ENTITY_ROTATION(OBJ6, 0, 0, 60)
    ENTITY.SET_ENTITY_ROTATION(OBJ7, 0, 0, 70)
    ENTITY.SET_ENTITY_ROTATION(OBJ8, 0, 0, 80)
    ENTITY.SET_ENTITY_ROTATION(OBJ9, 0, 0, 90)
    ENTITY.SET_ENTITY_ROTATION(OBJ10, 0, 0, 100)
    ENTITY.SET_ENTITY_ROTATION(OBJ11, 0, 0, 110)
    ENTITY.SET_ENTITY_ROTATION(OBJ12, 0, 0, 120)
    ENTITY.SET_ENTITY_ROTATION(OBJ13, 0, 0, 130)
    ENTITY.SET_ENTITY_ROTATION(OBJ14, 0, 0, 140)
    ENTITY.SET_ENTITY_ROTATION(OBJ15, 0, 0, 150)
    ENTITY.SET_ENTITY_ROTATION(OBJ16, 0, 0, 160)
    ENTITY.SET_ENTITY_ROTATION(OBJ17, 0, 0, 170)
end
function meowbmob(pid)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    hash = util.joaat("A_C_chop")
    request_model_load(hash)
    for i=1, 30 do
        local Chopdog = entities.create_ped(28, hash, coords, math.random(0, 270))
        local rand_x = math.random(-10, 10)*8
        local rand_y = math.random(-10, 10)*8
        local rand_z = math.random(-10, 10)*8
        ENTITY.SET_ENTITY_INVINCIBLE(Chopdog, true)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(Chopdog, 1, rand_x, rand_y, rand_z, true, false, true, true)
        AUDIO.PLAY_PAIN(Chopdog, 7, 0)
    end
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
function random_float(min, max)
	return min + math.random() * (max - min)
end
function set_entity_face_entity(entity, target, usePitch)
    local pos1 = ENTITY.GET_ENTITY_COORDS(entity, false)
    local pos2 = ENTITY.GET_ENTITY_COORDS(target, false)
    local rel = v3.new(pos2)
    rel:sub(pos1)
    local rot = rel:toRot()
    if not usePitch then
        ENTITY.SET_ENTITY_HEADING(entity, rot.z)
    else
        ENTITY.SET_ENTITY_ROTATION(entity, rot.x, rot.y, rot.z, 2, 0)
    end
end
function creep(pid)
    local hash <const> = util.joaat("s_m_y_clown_01")
		local explosion <const> = Effect.new("scr_rcbarry2", "scr_exp_clown")
		local appears <const> = Effect.new("scr_rcbarry2",  "scr_clown_appears")
		request_model(hash)
		local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local pos = ENTITY.GET_ENTITY_COORDS(player, false)
		local coord = get_random_offset_from_entity(player, 5.0, 8.0)
		coord.z = coord.z - 1.0
		local ped = entities.create_ped(0, hash, coord, 0.0)

		request_fx_asset(appears.asset)
		GRAPHICS.USE_PARTICLE_FX_ASSET(appears.asset)
		WIRI_GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
			appears.name,
			ped,
			0.0, 0.0, -1.0,
			0.0, 0.0, 0.0,
			0.5, false, false, false
		)
		set_entity_face_entity(ped, player, false)
		PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
		TASK.TASK_GO_TO_COORD_ANY_MEANS(ped, pos.x, pos.y, pos.z, 5.0, 0, false, 0, 0.0)
		local dest = pos
		PED.SET_PED_KEEP_TASK(ped, true)
		AUDIO.STOP_PED_SPEAKING(ped, true)
		util.create_tick_handler(function()
			local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
			local targetPos = players.get_position(pid)
			if not ENTITY.DOES_ENTITY_EXIST(ped) or PED.IS_PED_FATALLY_INJURED(ped) then
				return false
			elseif pos:distance(targetPos) > 150 and
			request_control(ped) then
				entities.delete_by_handle(ped)
				return false
			elseif pos:distance(targetPos) < 3.0 and request_control(ped) then
				request_fx_asset(explosion.asset)
				GRAPHICS.USE_PARTICLE_FX_ASSET(explosion.asset)
				WIRI_GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
					explosion.name,
					pos.x, pos.y, pos.z,
					0.0, 0.0, 0.0,
					1.0,
					false, false, false, false
				)
				FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 0, 1.0, true, true, 1.0, false)
				ENTITY.SET_ENTITY_VISIBLE(ped, false, false)
				entities.delete_by_handle(ped)
				return false
			elseif targetPos:distance(dest) > 3.0 and request_control_once(ped) then
				dest = targetPos
				TASK.TASK_GO_TO_COORD_ANY_MEANS(ped, targetPos.x, targetPos.y, targetPos.z, 5.0, 0, false, 0, 0.0)
			end
		end)
    end
--intToIp
function intToIp(num)
    ip = ""
    local int16 = string.format("%x", num)
    for i = 1, #int16 do
      if 0 == math.fmod(i, 2) then
        if ip ~= "" then
          ip = ip .. "." .. var_int
        else
          ip = var_int
        end
      else
        var_int = tostring(tonumber(string.sub(int16, i, i + 1), 16))
      end
    end
    return ip
end
-------------势不可挡
function horn_bomb()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(players.user()), false)
    if AUDIO.IS_HORN_ACTIVE(vehicle) then
        local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
        local shootCoords = v3.new(coords)
        for i = 1, 3 do
            local rot = ENTITY.GET_ENTITY_ROTATION(vehicle, 2):toDir()
            local vel = ENTITY.GET_ENTITY_VELOCITY(vehicle)
            v3.mul(rot, 25 + math.abs(vel.x))
            v3.add(shootCoords, rot)
            FIRE.ADD_OWNED_EXPLOSION(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1), shootCoords.x + math.random(-2, 2), shootCoords.y + math.random(-2, 2), shootCoords.z, 10, 100,true, false, 0.1)
            util.yield()
        end
    end
end
function selectparticle(index)
    vehparticle = vehparticle_tb[index]
end
function particle_tail()
    local vehicle = entities.get_user_vehicle_as_handle(false)
    local height = get_model_dimensions(ENTITY.GET_ENTITY_MODEL(vehicle))
    local posX1 = -height.x/3 --left--
    local posX2 = height.x/3 --right--
    local posY = -height.y/3
    for i, posX in {posX1, posX2} do
        request_ptfx_asset("scr_rcpaparazzo1")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcpaparazzo1")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(vehparticle, vehicle, posX, posY, 0.0, 0.0, 0.0, 0.0, 1.0, false, false, false)
    end
end
----极限跳跃
function extreme_jump(index)
    if index == 1 then
        SpawnHeight = 250
    elseif index == 2 then
        SpawnHeight = 500
    elseif index == 3 then
        SpawnHeight = 1000
    elseif index == 4 then
        SpawnHeight = 1500
    end

    local pedm = players.user_ped()
    local PlaneHash = 368211810
    local CarHash = 1483171323
    request_model(PlaneHash)
    request_model(CarHash)
    local heading = ENTITY.GET_ENTITY_HEADING(pedm)
    local PlaneSpawnLoc = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(pedm, 0, 0, SpawnHeight)
    local CarSpawnLoc = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(pedm, 0, 0, SpawnHeight + 4) --104
    
    local Plane = entities.create_vehicle(PlaneHash, PlaneSpawnLoc, heading)
    ENTITY.SET_ENTITY_INVINCIBLE(Plane, true)
    if PED.IS_PED_IN_ANY_VEHICLE(pedm, true) then
        Car = entities.get_user_vehicle_as_handle()
        ENTITY.SET_ENTITY_HEADING(Car, heading + 180)
        ENTITY.SET_ENTITY_VELOCITY(Car, 0, 100, 0)
    else 
        Car = entities.create_vehicle(CarHash, CarSpawnLoc, 0)
        ENTITY.SET_ENTITY_HEADING(Car, heading + 180)
        PED.SET_PED_INTO_VEHICLE(pedm, Car, -1)
    end
    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(Plane, 1, 0, 100, 0, true, true, true, true)
    ENTITY.SET_ENTITY_COORDS(Car, CarSpawnLoc.x, CarSpawnLoc.y, CarSpawnLoc.z, false, false, false, false)
    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(Car, 1, 0, -100, 0, true, true, true, true)

    local Timer = 370
    util.create_tick_handler(function()
        Timer = Timer - 1
        util.draw_centred_text("[夜幕提示]开仓倒计时 : " .. Timer)
        if Timer < 0 then
            VEHICLE.SET_VEHICLE_DOOR_OPEN(Plane, 2, false, false)
            return false
        end
    end)
end
------小丑炸弹车
function bomb_car()
    local hash = util.joaat("speedo2")
    request_model(hash)
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0, 0, 0)
    local heading = ENTITY.GET_ENTITY_HEADING(players.user_ped())
    local spawnedCar = entities.create_vehicle(hash, pos, heading)
    PED.SET_PED_INTO_VEHICLE(players.user_ped(), spawnedCar, -1) 
       notification( "[夜幕提示]按下鼠标右键引爆载具", colors.black)
    util.create_tick_handler(function()
        VEHICLE.START_VEHICLE_HORN(spawnedCar, 300, 1330140418, false)
        util.yield(500)
    end)
    while spawnedCar do
        ENTITY.SET_ENTITY_INVINCIBLE(spawnedCar, false)
        if PAD.IS_CONTROL_PRESSED(0, 68) then
            local Bomboffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(spawnedCar, 0, 0, 0)
            FIRE.ADD_EXPLOSION(Bomboffset.x, Bomboffset.y, Bomboffset.z, 59, 1, true, false, 1.0, false)
            util.yield(1000)
            entities.delete_by_handle(spawnedCar)
            break
        end
        util.yield()
    end
end                       
function YeMuprotections4()
    if NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
        local ped_netId = memory.script_local("am_gang_call", 63 + 10 + (0 * 7 + 1))
        local sender = memory.script_local("am_gang_call", 287)
        local target = memory.script_local("am_gang_call", 288)
        local ped = players.user()

        util.spoof_script("am_gang_call", function()
            if (memory.read_int(sender) ~= player and memory.read_int(target) == player and NETWORK.NETWORK_DOES_NETWORK_ID_EXIST(memory.read_int(ped_netId)) and NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(memory.read_int(ped_netId))) then
                local mugger = NETWORK.NET_TO_PED(memory.read_int(ped_netId))
                entities.delete_by_handle(mugger)
                util.toast("阻止劫匪来自 " .. players.get_name(memory.read_int(sender)))
            end
        end)
    end
end
function YeMuprotections5()
    if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
        menu.trigger_commands("mpmale")
    else
        menu.trigger_commands("mpfemale")
    end
end
function YeMuprotections6()
    local cleanse_entitycount = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ped) and (not NETWORK.NETWORK_IS_ACTIVITY_SESSION() or NETWORK.NETWORK_IS_ACTIVITY_SESSION() and not ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped)) then
            entities.delete_by_handle(ped)
            cleanse_entitycount += 1
            util.yield_once()
        end
    end
    util.toast("已清除 " .. cleanse_entitycount .. " Peds")
    cleanse_entitycount = 0
    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
        if vehicle ~= PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) and DECORATOR.DECOR_GET_INT(vehicle, "Player_Vehicle") == 0 and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            entities.delete_by_handle(vehicle)
            cleanse_entitycount += 1
            util.yield_once()
        end
    end
    util.toast("已清除 ".. cleanse_entitycount .." 载具")
    cleanse_entitycount = 0
    for _, object in pairs(entities.get_all_objects_as_handles()) do
        entities.delete_by_handle(object)
        cleanse_entitycount += 1
        util.yield_once()
    end
    util.toast("已清除 " .. cleanse_entitycount .. " 物体")
    cleanse_entitycount = 0
    for _, pickup in pairs(entities.get_all_pickups_as_handles()) do
        entities.delete_by_handle(pickup)
        cleanse_entitycount += 1
        util.yield_once()
    end
    util.toast("已清除 " .. cleanse_entitycount .. " 可拾取物体")
    local temp = memory.alloc(4)
    for i = 0, 100 do
        memory.write_int(temp, i)
        PHYSICS.DELETE_ROPE(temp)
    end
    util.toast("已清除所有绳索")
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    MISC.CLEAR_AREA_OF_PROJECTILES(pos.x, pos.y, pos.z, 400, 0)
    util.toast("已清除所有投掷物")
end
function YeMuprotections8()
    local unwanted_vehicles = {"cargoplane", "tug", "jet", "skylift", "towtruck", "towtruck2", "dump"}
        for _, vehicle in ipairs(entities.get_all_vehicles_as_pointers()) do
            for i, name in ipairs(unwanted_vehicles) do
                if entities.get_model_hash(vehicle) == 1043221410 then
                    entities.delete_by_pointer(vehicle)
                    util.toast("阻止不好载具同步")
                end
            end
        end
    end
function YeMuprotections9()
    local coords = ENTITY.GET_ENTITY_COORDS(players.user_ped() , false);
    GRAPHICS.REMOVE_PARTICLE_FX_IN_RANGE(coords.x, coords.y, coords.z, 400)
    GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
end
function YeMuprotections24()
    local coords = ENTITY.GET_ENTITY_COORDS(players.user_ped() , false);
    FIRE.STOP_FIRE_IN_RANGE(coords.x, coords.y, coords.z, 100)
    FIRE.STOP_ENTITY_FIRE(players.user_ped())
end
function YeMuprotections49(index, name)
    util.toast("[夜幕提示]正在清除"..name:lower().."...")
    local counter = 0
    local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    pluto_switch index do
        case 1:
            for _, ped in ipairs(entities.get_all_peds_as_handles()) do
                if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) and (not NETWORK.NETWORK_IS_ACTIVITY_SESSION() or NETWORK.NETWORK_IS_ACTIVITY_SESSION() and not ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped)) then
                    entities.delete_by_handle(ped)
                    counter += 1
                    util.yield_once()
                end
            end
            break
        case 2:
            for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
                if vehicle ~= PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) and DECORATOR.DECOR_GET_INT(vehicle, "Player_Vehicle") == 0 and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
                    entities.delete_by_handle(vehicle)
                    counter += 1
                end
                util.yield(25)
            end
            break
        case 3:
            for _, object in ipairs(entities.get_all_objects_as_handles()) do
                entities.delete_by_handle(object)
                counter += 1
                util.yield_once()
            end
            break
        case 4:
            for _, pickup in ipairs(entities.get_all_pickups_as_handles()) do
                entities.delete_by_handle(pickup)
                counter += 1
                util.yield_once()
            end
            break
        case 5:
            local temp = memory.alloc(4)
            for i = 0, 101 do
                memory.write_int(temp, i)
                if PHYSICS.DOES_ROPE_EXIST(temp) then
                    PHYSICS.DELETE_ROPE(temp)
                    counter += 1
                end
                util.yield_once()
            end
            break
        case 6:
            local coords = players.get_position(players.user())
            MISC.CLEAR_AREA_OF_PROJECTILES(coords.x, coords.y, coords.z, 1000, 0)
            counter = "所有"
            break
        case 4:
            for i = 0, 99 do
                AUDIO.STOP_SOUND(i)
                util.yield_once()
            end
        break
    end
    util.toast("[夜幕提示]已清除"..tostring(counter).."个"..name:lower()..".")
end
----字符串转变为 table表
local status, json = pcall(require, "json")
function StrToTable(str)
    if str == nil or type(str) ~= "string" then
        return
    end
    return json.decode(str)
end
----无碰撞
local noclip_speed = 1
function no_clip_speed(value)
    noclip_speed = value
end
function no_clip(on)
    no_clipd = on
    if no_clipd then
        while no_clipd do
            if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) then
                local veh = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
                if veh ~= 0 then
                    ENTITY.FREEZE_ENTITY_POSITION(veh, true)
                    ENTITY.SET_ENTITY_COLLISION(veh, false, false)
        
                    local rot = CAM.GET_GAMEPLAY_CAM_ROT(5)
                    ENTITY.SET_ENTITY_ROTATION(veh, rot.x, rot.y, rot.z, 5, true)
        
                    if util.is_key_down(0x57) then -- W
                        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(veh, 0, 1 * noclip_speed, 0)
                        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, pos.x, pos.y, pos.z, false, false, false)
                    elseif util.is_key_down(0x53) then -- S
                        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(veh, 0, -1 * noclip_speed, 0)
                        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, pos.x, pos.y, pos.z, false, false, false)
                    end
                    if util.is_key_down(0x41) then -- A
                        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(veh, -1 * noclip_speed, 0, 0)
                        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, pos.x, pos.y, pos.z, false, false, false)
                    elseif util.is_key_down(0x44) then -- D
                        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(veh, 1 * noclip_speed, 0, 0)
                        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, pos.x, pos.y, pos.z, false, false, false)
                    end
                    -- left shift
                    if util.is_key_down(0x10) then
                        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(veh, 0, 0, 1 * noclip_speed)
                        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, pos.x, pos.y, pos.z, false, false, false)
                    end
                    -- left control
                    if util.is_key_down(0x11) then
                        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(veh, 0, 0, -1 * noclip_speed)
                        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, pos.x, pos.y, pos.z, false, false, false)
                    end
                end
            else
                local ped = players.user_ped()
                ENTITY.FREEZE_ENTITY_POSITION(ped, true)
                ENTITY.SET_ENTITY_COLLISION(ped, false, false)
        
                local rot = CAM.GET_GAMEPLAY_CAM_ROT(5)
                ENTITY.SET_ENTITY_ROTATION(ped, rot.x, rot.y, rot.z, 5, true)
        
                if util.is_key_down(0x57) then -- W
                    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0, 1 * noclip_speed, 0)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ped, pos.x, pos.y, pos.z, false, false, false)
                elseif util.is_key_down(0x53) then -- S
                    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0, -1 * noclip_speed, 0)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ped, pos.x, pos.y, pos.z, false, false, false)
                end
                if util.is_key_down(0x41) then -- A
                    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, -1 * noclip_speed, 0, 0)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ped, pos.x, pos.y, pos.z, false, false, false)
                elseif util.is_key_down(0x44) then -- D
                    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 1 * noclip_speed, 0, 0)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ped, pos.x, pos.y, pos.z, false, false, false)
                end
                -- left shift
                if util.is_key_down(0x10) then
                    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0, 0, 1 * noclip_speed)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ped, pos.x, pos.y, pos.z, false, false, false)
                end
                -- left control
                if util.is_key_down(0x11) then
                    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0, 0, -1 * noclip_speed)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ped, pos.x, pos.y, pos.z, false, false, false)
                end
            end
            util.yield()
        end
    else
        if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
            if veh ~= 0 then
                ENTITY.FREEZE_ENTITY_POSITION(veh, false)
                ENTITY.SET_ENTITY_COLLISION(veh, true, true)
            end
        else
            local ped = players.user_ped()
            ENTITY.FREEZE_ENTITY_POSITION(ped, false)
            ENTITY.SET_ENTITY_COLLISION(ped, true, true)
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
        end
    end
end
------丝滑移动---------daidai
function Silky_movement(on)
    movement_toggle = on
    if on then
        while movement_toggle do
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
            local head = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())

            if not ENTITY.DOES_ENTITY_EXIST(movement_dow) then--防止人物掉落的动作
                local hash = -1272257643
                request_model(hash)
                movement_dow = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, 0, 0, 0, true, false, false)
                ENTITY.SET_ENTITY_ALPHA(movement_dow, 0)
                ENTITY.SET_ENTITY_VISIBLE(movement_dow, false, 0)
            end
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(movement_dow, pos.x, pos.y, pos.z-1.08, false, false, false)


            local rot = CAM.GET_GAMEPLAY_CAM_ROT(5)--控制视野
            ENTITY.SET_ENTITY_ROTATION(PLAYER.PLAYER_PED_ID(), 0, 0, rot.z, 5, true)


            ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), true)

            if PAD.IS_CONTROL_PRESSED(0,32) then--前进
                local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 1, 0)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, true, false, false)
                ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
            elseif PAD.IS_CONTROL_PRESSED(0,33) then--后退
                local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, -1, 0)
                            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, true, false, false)
                ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
            end
            if PAD.IS_CONTROL_PRESSED(0,34) then--左
                local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), -1, 0, 0)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, true, false, false)
            elseif PAD.IS_CONTROL_PRESSED(0,35) then--右
                local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 1, 0, 0)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, true, false, false)
            end
            if PAD.IS_CONTROL_PRESSED(0,21) then--上
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos['x'], pos['y'], pos['z']+1, true, false, false)
                ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
            elseif PAD.IS_CONTROL_PRESSED(0,36) then--下
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos['x'], pos['y'], pos['z']-1, true, false, false)
                ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
            end
            util.yield()
        end
    else
        ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
        entities.delete_by_handle(movement_dow)
    end
end
function SE_add_explosion(x, y, z, exptype, dmgscale, isheard, isinvis, camshake, nodmg)
    FIRE.ADD_EXPLOSION(x, y, z, exptype, dmgscale, isheard, isinvis, camshake, nodmg)
end
------飞机护航-----daidai
function escort()
    local heading = ENTITY.GET_ENTITY_HEADING(players.user_ped())
    local hashJet = util.joaat("Lazer")
    local hashTarget = 1082797888 --:1082797888
    request_model(hashJet)
    request_model(hashTarget)

--CREATE_PED_INSIDE_VEHICLE
    local ped = players.user_ped()
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0, 0, 200)

    local aJetpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, -50, -50, 200) --200
    local bJetpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 50, -50, 200)
    local cJetpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, -50, -100, 200)
    local dJetpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 50, -100, 200)
    local aJetAimpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, -20, 0, 0)
    local bJetAimpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 20, 0, 0)
    local cJetAimpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, -40, -40, 0) --200
    local dJetAimpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 40, -40, 0) --200

    if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) then
        PlayerJet = entities.create_vehicle(hashJet, pos, heading)
        
        aTarget = entities.create_object(hashTarget, aJetAimpos)--obj
        bTarget = entities.create_object(hashTarget, bJetAimpos)
        cTarget = entities.create_object(hashTarget, cJetAimpos)
        dTarget = entities.create_object(hashTarget, dJetAimpos)
        ENTITY.SET_ENTITY_COLLISION(aTarget, false, false)
        ENTITY.SET_ENTITY_VISIBLE(aTarget, false, false)
        ENTITY.SET_ENTITY_COLLISION(bTarget, false, false)
        ENTITY.SET_ENTITY_VISIBLE(bTarget, false, false)
        ENTITY.SET_ENTITY_COLLISION(cTarget, false, false)
        ENTITY.SET_ENTITY_VISIBLE(cTarget, false, false)
        ENTITY.SET_ENTITY_COLLISION(dTarget, false, false)
        ENTITY.SET_ENTITY_VISIBLE(dTarget, false, false)

        PED.SET_PED_INTO_VEHICLE(ped, PlayerJet, -1)
        VEHICLE.CONTROL_LANDING_GEAR(PlayerJet, 3)--控制起落架
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(PlayerJet, 1, 0, 100, 0, true, true, true, true)

        JetA = entities.create_vehicle(hashJet, aJetpos, heading)--飞机
        JetB = entities.create_vehicle(hashJet, bJetpos, heading)
        JetC = entities.create_vehicle(hashJet, cJetpos, heading)
        JetD = entities.create_vehicle(hashJet, dJetpos, heading)

        PilotA = PED.CREATE_RANDOM_PED_AS_DRIVER(JetA, 1)--创建驾驶飞机
        VEHICLE.SET_VEHICLE_ENGINE_ON(JetA, true, true, 0)
        
        PilotB = PED.CREATE_RANDOM_PED_AS_DRIVER(JetB, 1)
        VEHICLE.SET_VEHICLE_ENGINE_ON(JetB, true, true, 0)
        
        PilotC = PED.CREATE_RANDOM_PED_AS_DRIVER(JetC, 1)
        VEHICLE.SET_VEHICLE_ENGINE_ON(JetC, true, true, 0)
        
        PilotD = PED.CREATE_RANDOM_PED_AS_DRIVER(JetD, 1)
        VEHICLE.SET_VEHICLE_ENGINE_ON(JetD, true, true, 0)

        ENTITY.SET_ENTITY_INVINCIBLE(PlayerJet, true)
        ENTITY.SET_ENTITY_INVINCIBLE(JetA, true)
        ENTITY.SET_ENTITY_INVINCIBLE(JetB, true)
        ENTITY.SET_ENTITY_INVINCIBLE(JetC, true)
        ENTITY.SET_ENTITY_INVINCIBLE(JetD, true)
    end

    set_entity_face_entity(JetA, aTarget, true)
    set_entity_face_entity(JetB, bTarget, true)
    set_entity_face_entity(JetC, cTarget, true)
    set_entity_face_entity(JetD, dTarget, true)

    local aJetRealLoc = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(JetA, 0, 0, 0)
    local bJetRealLoc = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(JetB, 0, 0, 0)
    local cJetRealLoc = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(JetC, 0, 0, 0)
    local dJetRealLoc = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(JetD, 0, 0, 0)

    local aDistance = MISC.GET_DISTANCE_BETWEEN_COORDS(aJetRealLoc['x'], aJetRealLoc['y'], aJetRealLoc['z'], aJetAimpos['x'], aJetAimpos['y'], aJetAimpos['z'], true)
    local bDistance = MISC.GET_DISTANCE_BETWEEN_COORDS(bJetRealLoc['x'], bJetRealLoc['y'], bJetRealLoc['z'], bJetAimpos['x'], bJetAimpos['y'], bJetAimpos['z'], true)
    local cDistance = MISC.GET_DISTANCE_BETWEEN_COORDS(cJetRealLoc['x'], cJetRealLoc['y'], cJetRealLoc['z'], cJetAimpos['x'], cJetAimpos['y'], cJetAimpos['z'], true)
    local dDistance = MISC.GET_DISTANCE_BETWEEN_COORDS(dJetRealLoc['x'], dJetRealLoc['y'], dJetRealLoc['z'], dJetAimpos['x'], dJetAimpos['y'], dJetAimpos['z'], true)
    if aDistance < 40 then
        aJetSpeed = -0.8
    else
        aJetSpeed = 0.5
    end
    if bDistance < 40 then
        bJetSpeed = -0.8
    else
        bJetSpeed = 0.5
    end
    if cDistance < 40 then
        cJetSpeed = -0.8
    else
        cJetSpeed = 0.5
    end
    if dDistance < 40 then
        dJetSpeed = -0.8
    else
        dJetSpeed = 0.5
    end

    if not PED.IS_PED_ON_FOOT(ped) then
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(JetA, 1, 0, aJetSpeed, 0, true, true, true, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(aTarget, aJetAimpos.x, aJetAimpos.y, aJetAimpos.z, false, false, false)

        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(JetB, 1, 0, bJetSpeed, 0, true, true, true, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(bTarget, bJetAimpos.x, bJetAimpos.y, bJetAimpos.z, false, false, false)

        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(JetC, 1, 0, cJetSpeed, 0, true, true, true, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(cTarget, cJetAimpos.x, cJetAimpos.y, cJetAimpos.z, false, false, false)

        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(JetD, 1, 0, dJetSpeed, 0, true, true, true, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dTarget, dJetAimpos.x, dJetAimpos.y, dJetAimpos.z, false, false, false)
    end
end
function attach_to_player(hash, bone, x, y, z, xrot, yrot, zrot)           --attach object to player ped
    local user_ped = PLAYER.PLAYER_PED_ID()
    hash = util.joaat(hash)

    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do		
        util.yield()
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)

    local object = OBJECT.CREATE_OBJECT(hash, 0.0,0.0,0, true, true, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(object, user_ped, PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), bone), x, y, z, xrot, yrot, zrot, false, false, false, false, 2, true) 
end
function delete_object(model)
    local hash = util.joaat(model)
    for k, object in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.GET_ENTITY_MODEL(object) == hash then
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(object, false, false) 
            entities.delete_by_handle(object)
        end
    end
end
cages = {} 
function cage_player(pos)
	local object_hash = util.joaat("prop_gold_cont_01b")
	pos.z = pos.z-0.9
	
	STREAMING.REQUEST_MODEL(object_hash)
	while not STREAMING.HAS_MODEL_LOADED(object_hash) do
		util.yield()
	end
	local object1 = OBJECT.CREATE_OBJECT(object_hash, pos.x, pos.y, pos.z, true, true, true)
	cages[#cages + 1] = object1																			

	local object2 = OBJECT.CREATE_OBJECT(object_hash, pos.x, pos.y, pos.z, true, true, true)
	cages[#cages + 1] = object2
	

	ENTITY.FREEZE_ENTITY_POSITION(object1, true)
	ENTITY.FREEZE_ENTITY_POSITION(object2, true)
	local rot  = ENTITY.GET_ENTITY_ROTATION(object2)
	rot.x = -180
	rot.y = -180
	ENTITY.SET_ENTITY_ROTATION(object2, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(object_hash)
end
function Change_player_model(hash)
    local model_hash = hash
    STREAMING.REQUEST_MODEL(model_hash)
    while(not STREAMING.HAS_MODEL_LOADED(model_hash))
    do
		wait(0)
    end
    PLAYER.SET_PLAYER_MODEL(model_hash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(model_hash)
end
function request_model_load(hash)
    request_time = os.time()
    if not STREAMING.IS_MODEL_VALID(hash) then
        return
    end
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end
function start_meteor_shower()
    meteor_thr = util.create_thread(function(thr)
        while true do
            if not meteors then
                util.stop_thread()
            end
            local rand_1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), math.random(-500, 500), math.random(-500, 500), 300.0)
            local rand_2 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), math.random(-500, 500), math.random(-500, 500), 0.0)
            local diff = {}
            local speed = 200
            diff.x = (rand_2['x'] - rand_1['x'])*speed
            diff.y = (rand_2['y'] - rand_1['y'])*speed
            diff.z = (rand_2['z'] - rand_1['z'])*speed
            local h = 3751297495
            request_model_load(h)
            rand_1.x = rand_1['x']
            rand_1.y = rand_1['y']
            rand_1.z = rand_1['z']
            local meteor = OBJECT.CREATE_OBJECT_NO_OFFSET(h, rand_1['x'], rand_1['y'], rand_1['z'], true, false, false)
            ENTITY.SET_ENTITY_HAS_GRAVITY(meteor, true)
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(meteor, 4, diff.x, diff.y, diff.z, true, false, true, true)
            ENTITY.APPLY_FORCE_TO_ENTITY(meteor, 2, diff.x, diff.y, diff.z, 0, 0, 0, 0, true, false, true, false, true)
            OBJECT.SET_OBJECT_PHYSICS_PARAMS(meteor, 100000, 5, 1, 0, 0, .5, 0, 0, 0, 0, 0)
            util.yield(100)
        end
    end)
end
function ufffo()
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local r = num[math.random(#num)]
    c.x = math.random(0.0,1.0) >= 0.5 and c.x + r + 5 or c.x - r - 5 --set x coords
    c.y = math.random(0.0,1.0) >= 0.5 and c.y + r + 5 or c.y - r - 5 --set y coords
    c.z = c.z + r + 8 --set z coords
    STREAMING.REQUEST_MODEL(ufo)
    while not STREAMING.HAS_MODEL_LOADED(ufo) do
        STREAMING.REQUEST_MODEL(ufo)
        util.yield()
    end
    util.yield(2500)
    local spawnedufo = entities.create_object(ufo, c) --spawn ufo
    util.yield(500)
    local ufoc = ENTITY.GET_ENTITY_COORDS(spawnedufo) --get ufo pos
    local success, floorcoords
    repeat
        success, floorcoords = util.get_ground_z(ufoc.x, ufoc.y) --get floor pos
        util.yield()
    until success
    FIRE.ADD_EXPLOSION(ufoc.x, ufoc.y, floorcoords, exp, 100.0, true, false, 1.0, false) --explode at floor
    util.yield(1500)
    entities.delete_by_handle(spawnedufo) --delete ufo
    if not STREAMING.HAS_MODEL_LOADED(ufo) then
        util.toast("[夜幕提示]无法加载此模型")
    end
end
function explosion(pos, expSettings)
        if expSettings.currentFx then
            if expSettings.currentFx.exp then
                FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, expSettings.currentFx.exp, 10, expSettings.audible, true, 0, expSettings.noDamage)
                FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 1, 10, false, true, expSettings.camShake, expSettings.noDamage)
            else
                FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 1, 10, false, true, expSettings.camShake, expSettings.noDamage)
            end
            if not expSettings.invisible then
                addFx(pos, expSettings.currentFx, expSettings.colour)
            end
        else
            FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, expSettings.expType, 10, expSettings.audible, expSettings.invisible, expSettings.camShake, expSettings.noDamage)
        end
end
function explodePlayer(ped, loop, expSettings)
         pos = ENTITY.GET_ENTITY_COORDS(ped)
        --if any blame is enabled this decides who should be blamed
         blamedPlayer = PLAYER.PLAYER_PED_ID()
        if expSettings.blamedPlayer and expSettings.blamed then
            blamedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(expSettings.blamedPlayer)
        elseif expSettings.blamed then
             playerList = players.list(true, true, true)
            blamedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerList[math.random(1, #playerList)])
        end
        if not loop and PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
            for i = 0, 50, 1 do --50 explosions to account for most armored vehicles
                if expSettings.owned or expSettings.blamed then
                    ownedExplosion(blamedPlayer, pos, expSettings)
                else
                    explosion(pos, expSettings)
                end
                util.yield(10)
            end
        elseif expSettings.owned or expSettings.blamed then
            ownedExplosion(blamedPlayer, pos, expSettings)
        else
            explosion(pos, expSettings)
        end
        util.yield(10)
end
