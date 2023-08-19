------------------------------------夜幕LUA------------------------------
require "lib.YeMulib.YeMulib"
Version5 = 6.2
local net = "夜幕LUA暂时无法连接到服务器！"
local aalib = require("aalib")
local PlaySound = aalib.play_sound
local SND_ASYNC<const> = 0x0001
local SND_FILENAME<const> = 0x00020000
store_dir = filesystem.store_dir() .. '\\YMss\\'
sound_selection_dir = store_dir .. '\\sound3.txt'
if not filesystem.is_dir(store_dir) then
    util.toast("夜幕音频没有正确安装！.")
    util.stop_script()
end
fp = io.open(sound_selection_dir, 'r')
local file_selection = fp:read('*a')
fp:close()
local sound_location = store_dir .. '\\' .. file_selection
if not filesystem.exists(sound_location) then
    util.toast("[Startup Sound] " .. file_selection .. " 未找到音源.")
else
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
end
util.keep_running()
util.show_corner_help("~bold~~y~欢迎使用夜幕LUA 此版本号为：~o~" .. Version5 ..  "~g~‹\n ~b~祝你玩的开心！")
if SCRIPT_MANUAL_START then
    AUDIO.PLAY_SOUND(-1, "Virus_Eradicated", "LESTER1A_SOUNDS", 0, 0, 1)
    logo_alpha = 0
    logo_alpha_incr = 0.01
    logo_alpha_thread = util.create_thread(function (thr)
        while true do
            logo_alpha = logo_alpha + logo_alpha_incr
            if logo_alpha > 1 then
                logo_alpha = 1
            elseif logo_alpha < 0 then
                logo_alpha = 0
                util.stop_thread()
            end
            util.yield(0)
        end
    end)
 end
local function rotatePoint(x, y, center, degrees)
    local radians = math.rad(degrees)
    local new_x = (x - center.x) * math.cos(radians) - (y - center.y) * math.sin(radians)
    local new_y = (x - center.x) * math.sin(radians) + (y - center.y) * math.cos(radians)
    return center.x + new_x, center.y + new_y * 1920 / 1080
end
function directx.draw_triangle_from_center_point(center, base, rotDegrees, colour)
    local halfHeight = (base * 0.866) / 2
    local halfBase = base / 2
    local tx, ty = rotatePoint(center.x, center.y - halfBase, center, rotDegrees)
    local lx, ly = rotatePoint(center.x - halfBase, center.y + halfHeight, center, rotDegrees)
    local rx, ry = rotatePoint(center.x + halfBase, center.y + halfHeight, center, rotDegrees)
    directx.draw_triangle(tx, ty --[[top]], lx, ly --[[left]], rx, ry --[[right]], colour)
end
function directx.draw_circle(center, diameter, colour)
    for i = 0, 260 do
        directx.draw_triangle_from_center_point(center, diameter, i, colour)
    end
end
local new = {}
function new.colour(R, G, B, A)
   return {r = R / 255, g = G / 255, b = B / 255, a = A or 1}
end
white = new.colour( 255, 255, 255 )
function directx.draw_rect_with_rounded_corner(x, y, width, height, colour)
    directx.draw_circle({ x = x + width, y = y + height / 2 }, (height / 2.35), colour)
    directx.draw_rect(x, y, width, height, colour)
end
if not SCRIPT_SILENT_START then
    util.create_thread(function()
        local ym_size = 0.017
        local l = 1
        while l < 50 do
            util.yield()
            l += 5 - math.abs(math.floor(l / 10))
        end
        l = 1
        while l < 50 do
            --directx.draw_rect_with_rounded_corner(0.5 - l / 500, 0.8, l / 250, 0.06, darkBlue)
            util.yield()
            l += 5 - math.abs(math.floor(l / 10))
        end
        AUDIO.PLAY_SOUND(-1, "signal_on", "DLC_GR_Ambushed_Sounds", 0, 0, 1)
        for i = 1, 360 do
           -- directx.draw_rect_with_rounded_corner(0.4, 0.8, 0.2, 0.06, darkBlue)
            if i < 160 then
                directx.draw_text(0.47, 0.76 + ((i - 150) / 15000), '正在加载夜幕LUA~~', ALIGN_TOP_CENTRE, 0.65, white, false)
            elseif i > 190 then
            directx.draw_text(0.47, 0.80 + ((i - 150) / 7000), " 已检测到用户".. PLAYER.GET_PLAYER_NAME(players.user()).. "", ALIGN_TOP_CENTRE, 0.65, white, false)
            end
            util.yield()
        end
        l = 50
        while l >= 0 do
           -- directx.draw_rect_with_rounded_corner(0.5 - l / 500, 0.8, l / 250, 0.06, darkBlue)
            util.yield()
            l -= 6 - math.abs(math.floor(l / 10))
        end
        l = 50
        while l >= 0 do
            util.yield()
            l -= 6 - math.abs(math.floor(l / 10))
        end
    end)
end
YMscript_logo = directx.create_texture(filesystem.scripts_dir() .. '/YMS/'..'startpic.png')
if SCRIPT_MANUAL_START then
    AUDIO.PLAY_SOUND(-1, "Virus_Eradicated", "LESTER1A_SOUNDS", 0, 0, 1)
    logo_alpha = 0
    logo_alpha_incr = 0.01
    logo_alpha_thread = util.create_thread(function (thr)
        while true do
            logo_alpha = logo_alpha + logo_alpha_incr
            if logo_alpha > 1 then
                logo_alpha = 1
            elseif logo_alpha < 0 then
                logo_alpha = 0
                util.stop_thread()
            end
            util.yield()
        end
    end)

    logo_thread = util.create_thread(function (thr)
        starttime = os.clock()
        local alpha = 0
        while true do
            directx.draw_texture(YMscript_logo,  0.1, 0.3, 0.3, 0.6, 0.45, 0.5,0, 1, 1, 1, logo_alpha)
            timepassed = os.clock() - starttime
            if timepassed > 2.5 then
                logo_alpha_incr = -0.01
            end
            if logo_alpha == 0 then
                util.stop_thread()
            end
            util.yield()
        end
    end)
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
function xianshijiaoben1(state)
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
    draw_string(string.format("~italic~¦~bold~欢迎使用夜幕-V" .. Version5 ..  ""), 0.38,0.05, 0.57,5)
    util.yield()
    end
end
local YMencouragement={
    "欢迎使用夜幕LUA",
    "又遇到你了，真好！",
    "梦里能达到的地方，总有一天，脚步也能达到。",
    "你喜欢什么不重要，重要的是，你是否有能力去喜欢。喜欢的东西都很贵，要去努力，才有能力拥有。",
    "向每个人学习，但不要模仿任何人。",
    "伟大的成就，来自为远大的目标所花费的巨大心思和付诸的最大努力。",
    "花的生命虽然短暂，但它毕竟拥抱过春天。",
    "一生这么短，一定要回归现实生活，将余生留给最爱的人。",
    "有时候，明明心如刀割，却要灿烂的微笑，明明很脆弱，却表现的如此坚强，眼泪在眼里打转，却告诉每个人我很好。",
    "生活坏到一定程度就会好起来的，因为它无法更坏。",
    "懒可以毁掉一个人，勤可以激发一个人；对生活不失希望，微笑面对困境与磨难，心怀梦想，即使遥远，加油。",
    "世界上那些最容易的事情中，拖延时间最不费力。",
    "孤独不是给别人机会来可怜你，而是给你机会发现更强大的自己。",
    "生活，有悲伤，有惊喜，有成功，有失败。让你痛哭流涕，有时也会喜极而泣。",
    "人生如白驹过隙死不足恨但夙心往志，不闻于末世矣。",
    "人生本来一场空，有无之间的更替便是人生，得失之后的心态决定苦乐。缘来不拒，境去不留，看淡得失。",
    "无论怎样，我都相信路的尽头会有清澈的微光，黑暗过后一定是最美的黎明。",
    "有时候，上天没有给你想要的。不是因为你不配，而是你值得拥有更好的。",
    "每一个不曾起舞的日子，都是对生命的辜负。",
    "没有事情是小到不值得了解的，也没有什么事情会大到无法去尝试；你的一生我只借一程，这一程便是余生。",
    "越努力越幸运，不要给年轻找太多借口，现在你能做的，除了努力，别无其他。",
    "不要在该奋斗的年纪选择安逸，只有度过了一段连自己都被感动了的日子，才会变成那个最好的自己。",
    "无论多少岁，什么身份，都配得上五彩缤纷的生活。记得永远保有对生活热情、对生命负责的心态。",
    "不要让不好的事情毁了你这一天，乐观一点，开心一点，生命如此短暂，别浪费时间在不值一提的事情上。",
    "无论你碰到多么大的困难，都没有比放弃自己更困难！",
    "宁愿独处也不要和融不进去的人待在一起，不要刻意的去维持关系让自己越来越虚伪，宁可孤独，也不违心。",
    "一个急于赶路的人，无心欣赏身边美景的；心若累了，让它休息，灵魂的修复是人生永不干枯的希望。",
    "心宽阔了，才能明白没有一个人是孤岛，才能欣赏到对岸的风景，才能懂得如何接纳他人。",
    "无人理睬时，坚定执着。万人羡慕时，心如止水。",
    "书本里的故事，总有你学到的人生，所以要多阅读；为了自己想过的生活，勇于放弃一些东西，是值得的。",
    "人不怕卑微，就怕失去希望，期待明天，期待阳光，人就会从卑微中站起来，带着封存梦想去拥抱蓝天。",
    "诚信总会给你带来成功，但可能是下一站。",
    "希望，哪怕是不现实的幻想，也是需要的，有益的，美好的，对于青年尤其是这样。",
    "那些受过的苦，流过的泪，都将照亮我们的路。",
    "门庭若市却孜然一身，车水马龙却素昧平生。",
    "上苍不会给你快乐、也不会给你痛苦，它只会给你真实的生活。有人忍受不了生活的平淡而死去，却不知道生命本身就是奇迹！",
    "成功不是得到多少东西，而是看你把身上多余的东西扔掉多少。",
    "自强不息，进学不已",
}
random_notify = math.random(1,#YMencouragement)
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
     notification("你好，尊贵的夜幕用户!\n&#8721;已连接！\n""[" .. YMencouragement[random_notify] .. "]", colors.black)
    util.on_stop(function()
     notification("下次遇见会更好!", colors.gray)
    end)
function YMdet()
    if not async_http.have_access() then
        local y = net
        notification("~bold~请为夜幕LUA启用互联网访问&#8721;", math.random(0, 50))
        util. stop_script()
    end
    --util.toast(net)
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
function HIDE(scaleform)
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "HIDE")
	GRAPHICS.BEGIN_TEXT_COMMAND_SCALEFORM_STRING("STRING")
	HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("presents")
	GRAPHICS.END_TEXT_COMMAND_SCALEFORM_STRING()
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.16)
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
end
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

YMplanid = {{playerrid = "Hilovewould"}}
YMth = {{playerid = "muyusd"},{playerid = "Dust-wine"},{playerid = "Maple_1999"},{playerid = "Xzzz_polar"},{playerid = "Hf19172798591"},{playerid = "dabaixiong0415"},{playerid = "sshiwga"},{playerid = "jasmine7294"},{playerid = "XiProNB"},{playerid = "hujkilsr"},{playerid = "Lyccchi"},{playerid = "dandanshinimenba"},{playerid = "Bronya_15644"},{playerid = "Royston7294"},{playerid = "liangzihui0522"},{playerid = "xx-bai"},{playerid = "--KZboy-SSR--"},{playerid = "RESERVEDBOSS"},{playerid = "Moldoveanuu07"},{playerid = "tiantian_qwq"},{playerid = "PowerByAndroid"},{playerid = "HeezyLua"},{playerid = "smithnsksmsmzk"},{playerid = "JiYanaa"},{playerid = "daxingxingrule"},{playerid = "sfasafafasfa"}}
YMblacklist = {{playerrrid = "Angel00512"}}