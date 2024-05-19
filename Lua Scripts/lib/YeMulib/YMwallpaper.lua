local YMpaper1 = directx.create_texture(filesystem.resources_dir() .. "YMIMG/YMwallpaper/" .. 'YMpaper1.png')
local YMpaper2 = directx.create_texture(filesystem.resources_dir() .. "YMIMG/YMwallpaper/" .. 'YMpaper2.png')
local YMpaper3 = directx.create_texture(filesystem.resources_dir() .. "YMIMG/YMwallpaper/" .. 'YMpaper3.png')
local YMpaper4 = directx.create_texture(filesystem.resources_dir() .. "YMIMG/YMwallpaper/" .. 'YMpaper4.png')
local YMpaper5 = directx.create_texture(filesystem.resources_dir() .. "YMIMG/YMwallpaper/" .. 'YMpaper5.png')
local YMpaper6 = directx.create_texture(filesystem.resources_dir() .. "YMIMG/YMwallpaper/" .. 'YMpaper6.png')
local YMpaper7 = directx.create_texture(filesystem.resources_dir() .. "YMIMG/YMwallpaper/" .. 'YMpaper7.png')
local header = YMpaper1
local x, y = directx.get_client_size()
menu.toggle_loop(wallpaper, "开启", {}, "", function()
    directx.draw_texture(header, size, size, 0.5, 0.5, x_pos, y_pos, 0, white)
end)
menu.slider(wallpaper, "壁纸", { "header_picture" }, "", 1, 7, 1, 1, function(s)
    if s == 1 then
        header = YMpaper1
    elseif s == 2 then
        header = YMpaper2
    elseif s == 3 then
        header = YMpaper3
    elseif s == 4 then
        header = YMpaper4
    elseif s == 5 then
        header = YMpaper5
    elseif s == 6 then
        header = YMpaper6
    elseif s == 7 then
        header = YMpaper7
    end
end)
x_pos = 0.95
menu.slider(wallpaper, "X 位置", { "header_x" }, "", 0, x, x/2, 10, function(s)
    x_pos = s/x
end)
y_pos = 0.80
menu.slider(wallpaper, "Y 位置", { "header_y" }, "", 0, y, y/2, 10, function(s)
    y_pos = s/y
end)
size = 0.06
menu.slider_float(wallpaper, "大小", { "header_size" }, "", 0, 200, 10, 1, function(s)
    size = s/800
end)
local white = {
    r = 1.0,
    g = 1.0,
    b = 1.0,
    a = 1.0
}
-----可莉
local photovalue1 = 1
logocoord1 = {x = 0.70,y = 0.05, fps = 150}
function GIF_keli(on)
    if on then
        showlogo1 = 1
        util.create_thread(function()
            while showlogo1 == 1 do
                local logo = directx.create_texture(filesystem.resources_dir() .. '/YMIMG/YMGIF/keli/'..photovalue1..'.png')
                directx.draw_texture(logo, 0.06, 0.1, 0.0, 0.0, logocoord1.x, logocoord1.y, 0, 1, 1, 1, 1)
                util.yield()
            end
        end)
        util.create_thread(function()
            while showlogo1 == 1 do
                if photovalue1 < 8 then
                    photovalue1 = photovalue1 + 1
                else
                    photovalue1 = 1
                end
                util.yield(logocoord1.fps)
            end
        end)
    else
        showlogo1 = 0
    end
end
function GIF_keli2(on)
    if on then
        showlogo1 = 1
        util.create_thread(function()
            while showlogo1 == 1 do
                local logo = directx.create_texture(filesystem.resources_dir() .. '/YMIMG/YMGIF/keli2/'..photovalue1..'.png')
                directx.draw_texture(logo, 0.06, 0.1, 0.0, 0.0, logocoord1.x, logocoord1.y, 0, 1, 1, 1, 1)
                util.yield()
            end
        end)
        util.create_thread(function()
            while showlogo1 == 1 do
                if photovalue1 < 8 then
                    photovalue1 = photovalue1 + 1
                else
                    photovalue1 = 1
                end
                util.yield(logocoord1.fps)
            end
        end)
    else
        showlogo1 = 0
    end
end
--------------dongdong
logocoord2 = {x = 0.39,y = 0.35, fps = 150}
function GIF_dongdong(on)
    if on then
        showlogo1 = 1
        util.create_thread(function()
            while showlogo1 == 1 do
                local logo = directx.create_texture(filesystem.resources_dir() .. '/YMIMG/YMGIF/dongdong/'..photovalue1..'.png')
                directx.draw_texture(logo, 0.06, 0.1, 0.0, 0.0, logocoord2.x, logocoord2.y, 0, 1, 1, 1, 1)
                util.yield()
            end
        end)
        util.create_thread(function()
            while showlogo1 == 1 do
                if photovalue1 < 8 then
                    photovalue1 = photovalue1 + 1
                else
                    photovalue1 = 1
                end
                util.yield(logocoord2.fps)
            end
        end)
    else
        showlogo1 = 0
    end
end