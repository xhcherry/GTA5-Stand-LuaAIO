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
util.show_corner_help("~g~欢迎使用夜幕Lua 此版本号为：~b~4.8~g~‹\n ~o~希望夜幕lua带给你快乐！")
YM_logo = directx.create_texture(filesystem.resources_dir() ..'YM.png')
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
function directx.draw_rect_with_rounded_corner(x, y, width, height, colour)
    directx.draw_circle({ x = x + width, y = y + height / 2 }, (height / 2.35), colour)
    directx.draw_rect(x, y, width, height, colour)
end
if not SCRIPT_SILENT_START then
    util.create_thread(function()
        local ym_size = 0.017
        local l = 1
        while l < 50 do
            directx.draw_texture(YM_logo, ym_size, ym_size, 0.8, 0.8, 0.8, (1 - l / 250) + 0.03, 0, {r = 1, g = 1, b = 1, a = l / 50})
            util.yield()
            l += 5 - math.abs(math.floor(l / 10))
        end
        l = 1
        while l < 50 do
            --directx.draw_rect_with_rounded_corner(0.5 - l / 500, 0.8, l / 250, 0.06, darkBlue)
            directx.draw_texture(YM_logo, ym_size, ym_size, 0.8, 0.8, 0.8 - l / 500, 0.80, 0, white)
            util.yield()
            l += 5 - math.abs(math.floor(l / 10))
        end
        AUDIO.PLAY_SOUND(-1, "signal_on", "DLC_GR_Ambushed_Sounds", 0, 0, 1)
        for i = 1, 360 do
           -- directx.draw_rect_with_rounded_corner(0.4, 0.8, 0.2, 0.06, darkBlue)
            directx.draw_texture(YM_logo, ym_size, ym_size, 0.5, 0.5, 0.4, 0.80, i / 360, white)
            if i < 160 then
                directx.draw_text(0.5, 0.81 + ((i - 150) / 25000), '正在加载夜幕Lua~~', ALIGN_TOP_CENTRE, 0.6, white, false)
            elseif i > 190 then
            directx.draw_text(0.5, 0.83 + ((i - 150) / 2500), " 已检测到用户".. PLAYER.GET_PLAYER_NAME(players.user()).. "", ALIGN_TOP_CENTRE, 0.65, white, false)
            end
            util.yield()
        end
        l = 50
        while l >= 0 do
           -- directx.draw_rect_with_rounded_corner(0.5 - l / 500, 0.8, l / 250, 0.06, darkBlue)
            directx.draw_texture(YM_logo, ym_size, ym_size, 0.5, 0.5, 0.5 - l / 500, 0.80, 0, white)
            util.yield()
            l -= 6 - math.abs(math.floor(l / 10))
        end
        l = 50
        while l >= 0 do
            directx.draw_texture(YM_logo, ym_size, ym_size, 0.5, 0.5, 0.5, (1 - l / 250) + 0.03, 0, {r = 1, g = 1, b = 1, a = l / 80})
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
    draw_string(string.format("~italic~¦~bold~欢迎使用夜幕-V4.8"), 0.35,0.08, 0.6,5)
    util.yield()
    end
end
