--[[
**  github.com/BluetoothWiFi            **
**  Version: 1.1.4		**
**  Script repo - https://github.com/BluetoothWiFi/Stand-watermark		**
**  original script repo - github.com/IMXNOOBX/ScriptKid  **
]]

-- Local Vars
local x, y = 0.992, 0.008
local icon
local editions = {
    'Free',
    'Basic',
    'Regular',
    'Ultimate'
}
local icon_table = {}
local icon_names = {}
local gif_table = {}
local gif_names = {}
local gif_temp_names = {}

--Local Functions
local function download_icon(icon_name)
    if not filesystem.exists(filesystem.scripts_dir().."\\GTLuaScript\\watermark\\"..icon_name..".png") then
        util.toast("[FS|WaterMark] Watermark icon not found, downloading...")
        local path_root = filesystem.scripts_dir() .."/GTLuaScript/watermark/"
        async_http.init("raw.githubusercontent.com", "/BluetoothWiFi/Stand-watermark/main/watermark/"..icon_name..".png", function(req)
            if not req then
                util.toast("Failed to download "..icon_name..".png")
                --util.toast("Failed to download watermark/stand_icon.png, please download it manually.\nThe link is copied in your clipboard.")
                --util.copy_to_clipboard("https://github.com/BluetoothWiFi/Stand-watermark/blob/main/watermark/stand_icon.png", true) --need to make an edit this stuff
                return 
            end

            filesystem.mkdir(path_root)
            local file = io.open(path_root..icon_name..".png", "wb")
            file:write(req)
            file:close()
            util.toast("Successfully downloaded "..icon_name..".png from the repository")
            icon = directx.create_texture(filesystem.scripts_dir().."\\GTLuaScript\\watermark\\"..icon_name..".png")
        end)
        async_http.dispatch()
        async_http.dispatch()
    end
end
local function register_icons()
    filesystem.mkdir(filesystem.scripts_dir() .."/GTLuaScript/watermark/Animated")
    icon_names[#icon_names + 1] = "Custom GIF"
    for i, filename in ipairs(filesystem.list_files(filesystem.scripts_dir().."/GTLuaScript/watermark")) do
        filename = filename:gsub(filesystem.scripts_dir().."/GTLuaScript/watermark\\", "")
        if filename ~= "Animated" then
            icon_names[#icon_names + 1] = filename
        end
    end
    for i, filename in ipairs(filesystem.list_files(filesystem.scripts_dir().."\\GTLuaScript\\watermark\\Animated")) do
        filename = filename:gsub(filesystem.scripts_dir().."\\GTLuaScript\\watermark\\Animated\\", "")
        gif_names[#gif_names + 1] = filename

        filename = filename:gsub(".gif", "")
        gif_temp_names[tonumber(filename) + 1] = filename..".gif"
    end
    table.sort(icon_names)
    --table.sort(gif_names)
    for i_, filename in ipairs(icon_names) do
        if filename ~= "Custom GIF" then
            icon_table[#icon_table + 1] = directx.create_texture(filesystem.scripts_dir().."\\GTLuaScript\\watermark\\"..filename)
        end
    end    
    for i, filename in ipairs(gif_temp_names) do
        gif_table[#gif_table + 1] = directx.create_texture(filesystem.scripts_dir().."\\GTLuaScript\\watermark\\Animated\\"..filename)
    end
end

-- Settings
local Settings <const> = {}
Settings.show_icon = true
Settings.show_name = true
Settings.show_time = true
Settings.show_players = true
Settings.show_tps = true
Settings.show_firstl = 1
Settings.add_x = 0.0055
Settings.add_y = 0.0
Settings.bg_color = {r = 0.8, g = 0.35, b = 0.8, a = 0.8}
Settings.tx_color = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
Settings.tps = 0
Settings.time_format = 2
Settings.tps_label = 1
Settings.icon_sel = 2
Settings.fps = 60

--tick handler for gif loading
local icon_frame = 1
util.create_tick_handler(function()
    if icon_frame < #gif_table then
        icon_frame = icon_frame + 1
    else
        icon_frame = 1
    end
    util.yield(1000/Settings.fps)
end)

--tps counter (very dodgy but works lol)
local tps = 0
util.create_tick_handler(function()
    tps = tps + 1
end)
util.create_tick_handler(function()
    util.yield(1000)
    Settings.tps = tps
    tps = 0
end)

-- Icons
download_icon("stand_icon")
download_icon("stand_icon2")
download_icon("stand_icon3")
download_icon("stand_icon4")
register_icons()
--table.sort(gif_table)
--table.sort(gif_names)

-- Settings
pos_settings = menu.list(WaterMark, "位置", {}, "", function ()
end)
menu.slider(pos_settings, "X 位置", {"watermark-x"}, "", -100000, 100000, x * 10000, 1, function(xvar1)
    x = xvar1 / 10000
end)
menu.slider(pos_settings, "Y 位置", {"watermark-y"}, "", -100000, 100000, y * 10000, 1, function(yvar1)
    y = yvar1 / 10000
end)
menu.slider(pos_settings, "背景大小 X", {"watermark-addx"}, "", -100000, 100000, Settings.add_x * 10000, 1, function(xvar2)
    Settings.add_x = xvar2 / 10000
end)
menu.slider(pos_settings, "背景大小 Y", {"watermark-addy"}, "", -100000, 100000, Settings.add_y * 10000, 1, function(yvar2)
    Settings.add_y = yvar2 / 10000
end)

-- Colour
local color_settings = menu.list(WaterMark, "颜色", {}, "", function() end)
local rgb_background = menu.colour(color_settings, "背景颜色", {"watermark-bg_color"}, "Select background color", Settings.bg_color, true, function(col)
    Settings.bg_color = col
end)
menu.rainbow(rgb_background)
local rgb_text = menu.colour(color_settings, "文字颜色", {"watermark-tx_color"}, "Select text color", Settings.tx_color, true, function(col)
    Settings.tx_color = col
end)
menu.rainbow(rgb_text)

-- Misc Options
menu.divider(WaterMark, "内容")
menu.toggle(WaterMark, "图标显示", {}, "", function(val)
	Settings.show_icon = val
end, Settings.show_icon)
chooseicon = menu.list_select(WaterMark, "选择图标", {}, "", icon_names, Settings.icon_sel, function (val)
    Settings.icon_sel = val
--menu.delete(chooseicon)
end)
menu.slider(WaterMark, "GIF动图FPS数值", {"watermarkfps"}, "", 1, 1000, 60, 1, function(s)
	Settings.fps = s
end)
menu.list_select(WaterMark, "选择名称", {}, "", {"GRANDTOURINGVIP", "Stand", "版本", "标题名称", "FemboyEdition", "^_-", "OwO"}, Settings.show_firstl, function (val)
    Settings.show_firstl = val
end)
menu.toggle(WaterMark, "名称显示", {}, "", function(val)
	Settings.show_name = val
end, Settings.show_name)
menu.toggle(WaterMark, "玩家数量", {}, "", function(val)
	Settings.show_players = val
end, Settings.show_players)
menu.toggle(WaterMark, "FPS显示", {}, "", function(val)
	Settings.show_tps = val
end, Settings.show_tps)
menu.list_select(WaterMark, "FPS设置", {}, "", {"TPS", "FPS"}, Settings.tps_label, function (val)
    Settings.tps_label = val
end)
menu.toggle(WaterMark, "显示时间", {}, "", function(val)
	Settings.show_time = val
end, Settings.show_time)
menu.list_select(WaterMark, "时间设置", {}, "", {"12小时", "24小时"}, Settings.time_format, function (val)
    Settings.time_format = val
end)

-- Main Toggle
menu.divider(WaterMark, "")
menu.toggle_loop(WaterMark, "启用显示", {"watermark"}, "", function()
    if menu.is_in_screenshot_mode() then return end

    local function get_root_name()
        local root_name = menu.get_state(menu.ref_by_path("Stand>Settings>Appearance>Address Bar>Root Name"))
        root_name = root_name:gsub("{}", "")
        root_name = root_name:gsub("Hidden", "")
        return root_name
    end
    local label_table = {
        "GRANDTOURINGVIP ",               --1
        "Stand",                          --2
        editions[menu.get_edition() + 1], --3
        get_root_name(),                  --4
        "FemboyEdition",                  --5
        "^_-",                            --6
        "OwO",                            --7
    }

    local wm_text = label_table[Settings.show_firstl]
    if Settings.show_name then
        if Settings.show_firstl == 1 then 
            wm_text = wm_text..players.get_name(players.user())
        else
            wm_text = wm_text.." | "..players.get_name(players.user())
        end
    end
    if Settings.show_players and NETWORK.NETWORK_IS_SESSION_STARTED() then
        wm_text = wm_text.." | ".."玩家: "..#players.list()
    end
    if Settings.show_tps and Settings.tps_label == 1 then
        wm_text = wm_text.." | ".."TPS: "..Settings.tps
    elseif Settings.show_tps and Settings.tps_label == 2 then
        wm_text = wm_text.." | ".."FPS: "..Settings.tps
    end
    if Settings.show_time and Settings.time_format == 1 then
        wm_text = wm_text..os.date(" | %I"):gsub("0", "")..os.date(":%M:%S")
    elseif Settings.show_time and Settings.time_format == 2 then
        wm_text = wm_text..os.date(" | %H"):gsub("0", "")..os.date(":%M:%S")
    end
    local tx_size = directx.get_text_size(wm_text, 0.5)

    if Settings.show_icon then
        directx.draw_rect(
            x + Settings.add_x * 0.5,
            y,
            -(tx_size + 0.0105 + Settings.add_x),  -- add watermark size
            0.025 + Settings.add_y,
            Settings.bg_color
        )
    else
        directx.draw_rect(
            x + Settings.add_x * 0.5,
            y,
            -(tx_size + 0.005),  -- add watermark size
            0.025 + Settings.add_y,
            Settings.bg_color
        )
    end

    if Settings.show_icon then
        if filesystem.exists(filesystem.scripts_dir().."\\GTLuaScript\\watermark\\"..icon_names[Settings.icon_sel]) and icon_table[Settings.icon_sel] ~= nil and icon_names[Settings.icon_sel] ~= "Custom GIF" then
            directx.draw_texture(icon_table[Settings.icon_sel], 
                0.0055,
                0.0055,
                0.5,
                0.5,
                x - tx_size - 0.0055,
                y + 0.013,
                0,
                {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
            )
        elseif filesystem.exists(filesystem.scripts_dir().."\\GTLuaScript\\watermark\\Animated\\"..gif_names[icon_frame]) and gif_table[icon_frame] ~= nil and icon_names[Settings.icon_sel] == "Custom GIF" then
            directx.draw_texture(gif_table[icon_frame], 
                0.0055,
                0.0055,
                0.5,
                0.5,
                x - tx_size - 0.0055,
                y + 0.013,
                0,
                {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
            )
        end
    end
    directx.draw_text(
        x,
        y + 0.004,
        wm_text,
        ALIGN_TOP_RIGHT,
        0.5,
        Settings.tx_color,
        false
    )
end)

util.keep_running()
