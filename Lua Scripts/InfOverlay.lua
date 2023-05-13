-- InfOverlay
-- by lev

if not SCRIPT_SILENT_START then
    util.toast("欢迎使用 InfOverlay(信息显示) 脚本.\n中文翻译: lu_zi") 
end
local SCRIPT_VERSION = "1.1"
--natives
util.require_natives(1640181023)

--client resolution/aspect ratio
local RES_X, RES_Y = 1920, 1080
local ASPECT_RATIO <const> = RES_X/RES_Y

--set position
local gui_x = 0
local gui_y = 0

--set colours
local colour =
{
    title_bar = {r = 1, g = 0, b = 1, a = 1},
    background = {r = 0, g = 0, b = 0, a = 77/255},
    health_bar = {r = 114/255, g = 204/255, b = 114/255, a = 150/255},
    armour_bar = {r = 70/255, g = 136/255, b = 171/255, a = 150/255},
    map = {r = 1, g = 1, b = 1, a = 0.75},
    blip = {r = 1, g = 1, b = 1, a = 1},
    name = {r = 1, g = 1, b = 1, a = 1},
    label = {r = 1, g = 1, b = 1, a = 1},
    info = {r = 1, g = 1, b = 1, a = 1},
    border = {r = 1, g = 0, b = 1, a = 1}
}

--settings element sizing & spacing
local name_h = 24/RES_Y
local padding = 8/RES_Y
local spacing = 3/RES_Y
local gui_w = 290/RES_X
local bar_w_mult = 1.8
local blip_size = 0.0035

--settings text sizing & spacing
local name_size = 0.52
local text_size = 0.41
local line_spacing = 10/RES_Y

--settings border
local border_width = 0

--settings blur
local blur_strength = 4
local blur = {}
for i = 1, 8 do blur[i] = directx.blurrect_new() end

--map textures
local textures =
{
    map = directx.create_texture(filesystem.resources_dir() .. "Map.png"),
    blip = directx.create_texture(filesystem.resources_dir() .. "Blip.png")
}

--render window toggle
local render_window = false
local infoverlay = menu.attach_before(menu.ref_by_path("Players>Settings>Tags"), menu.list(menu.shadow_root(), SCRIPT_NAME.." 设置", {}, "", 
function()
    render_window = true 
end, 
function()
    render_window = false
end))

--settings
menu.action(menu.my_root(), "玩家 > 设置 > "..SCRIPT_NAME.." 设置", {}, "转到设置的快捷方式.", function(on_click)
    menu.trigger_command(infoverlay)
end)

--set position
menu.divider(infoverlay, "位置")
menu.slider(infoverlay, "X:", {"overlayx"}, "信息显示框的横轴位置.", 0, RES_X, 0, 10, function(s)
    gui_x = s/RES_X
end)
menu.slider(infoverlay, "Y:", {"overlayy"}, "信息显示框的纵轴位置.", 0, RES_Y, 0, 10, function(s)
    gui_y = s/RES_Y
end)

--appearance divider
menu.divider(infoverlay, "外观")

--set colours
local colours = menu.list(infoverlay, "颜色", {}, "")

menu.divider(colours, "元素")

menu.colour(colours, "标题栏", {"overlaytitle_bar"}, "更改标题栏颜色.", colour.title_bar, true, function(on_change)
    colour.title_bar = on_change
end)
menu.colour(colours, "背景", {"overlaybg"}, "更改背景颜色.", colour.background, true, function(on_change)
    colour.background = on_change
end)
menu.colour(colours, "血量", {"overlayhealth_bar"}, "更改血条颜色.", colour.health_bar, true, function(on_change)
    colour.health_bar = on_change
end)
menu.colour(colours, "护甲", {"overlayarmour_bar"}, "更改护甲条颜色.", colour.armour_bar, true, function(on_change)
    colour.armour_bar = on_change
end)
menu.colour(colours, "地图", {"overlaymap"}, "更改地图颜色.", colour.map, true, function(on_change)
    colour.map = on_change
end)
menu.colour(colours, "光标", {"overlayblip"}, "更改地图上玩家标志颜色.", colour.blip, true, function(on_change)
    colour.blip = on_change
end)

menu.divider(colours, "文本")
menu.colour(colours, "名称", {"overlayname"}, "更改玩家名称文字颜色.", colour.name, true, function(on_change)
    colour.name = on_change
end)
menu.colour(colours, "标签", {"overlaylabel"}, "更改信息标签颜色.", colour.label, true, function(on_change)
    colour.label = on_change
end)
menu.colour(colours, "信息", {"overlayinfo"}, "更改信息颜色.", colour.info, true, function(on_change)
    colour.info = on_change
end)

--set element sizing & spacing
local element_dim = menu.list(infoverlay, "元素大小 & 间距", {}, "")

menu.divider(element_dim, "大小 & 间距")

menu.slider(element_dim, "标题栏宽度", {}, "更改标题栏宽度.", 0, math.floor(3 * name_h * RES_Y), math.floor(name_h * RES_Y), 1, function(on_change)
    name_h = on_change/RES_Y
end)
menu.slider(element_dim, "信息框长度", {"overlaywidth"}, "更改信息框长度.", 0, math.floor(3 * gui_w * RES_Y), math.floor(gui_w * RES_Y), 10, function(on_change)
    gui_w = on_change/RES_Y
end)
menu.slider(element_dim, "缩放", {}, "更改信息框缩放程度.", 0, math.floor(3 * padding * RES_Y), math.floor(padding * RES_Y), 1, function(on_change)
    padding = on_change/RES_Y
end)
menu.slider(element_dim, "间距", {}, "更改不同元素间的间距.", 0, math.floor(5 * spacing * RES_Y), math.floor(spacing * RES_Y), 1, function(on_change)
    spacing = on_change/RES_Y
end)
menu.slider_float(element_dim, "玩家状态", {}, "更改血条和护甲条信息的宽度.", 0, math.floor(3 * bar_w_mult * 100), math.floor(bar_w_mult * 100), 10, function(on_change)
    bar_w_mult = on_change/100
end)
menu.slider_float(element_dim, "光标大小", {}, "更改地图上玩家标志的大小.", 0, math.floor(3 * blip_size * 10000), math.floor(blip_size * 10000), 1, function(on_change)
    blip_size = on_change/10000
end)

--set text sizing & spacing
local text_dim = menu.list(infoverlay, "文字大小 & 间距", {}, "")

menu.divider(text_dim, "大小 & 间距")

menu.slider_float(text_dim, "名称", {}, "更改玩家名称文字大小.", 0, 100, math.floor(name_size * 100), 1, function(on_change)
    name_size = on_change/100
end)
menu.slider_float(text_dim, "信息", {}, "更改信息文字大小.", 0, 100, math.floor(text_size * 100), 1, function(on_change)
    text_size = on_change/100
end)
menu.slider(text_dim, "行间距", {}, "更改信息文字之间的间距.", 0, math.floor(3 * line_spacing * RES_Y), math.floor(line_spacing * RES_Y), 1, function(on_change)
    line_spacing = on_change/RES_Y
end)

--set border
local border = menu.list(infoverlay, "边框", {}, "")

menu.divider(border, "设置")

menu.slider(border, "宽度", {}, "更改边框宽度.", 0, math.floor(3 * spacing * RES_Y), 0, 1, function(on_change)
    border_width = on_change/RES_Y
end)
local border_c_slider = menu.colour(border, "颜色", {"overlayborder"}, "更改边框颜色.", colour.border, true, function(on_change)
    colour.border = on_change
end)
border_c_slider:rainbow()

--set blur
menu.slider(infoverlay, "背景不透明度", {}, "更改背景的不透明度.", 0, 255, blur_strength, 1, function(on_change)
    blur_strength = on_change
end)

--restart script
menu.action(infoverlay, "重启脚本", {}, "", function()
    util.restart_script()
end)

--draw functions
local function drawRect(x, y, w, h, colour)
    directx.draw_rect(x, y, w, h, 
    {r = colour.r * colour.a, g = colour.g * colour.a, b = colour.b * colour.a, a = colour.a})
end

local function drawBorder(x, y, width, height)
    local border_x = border_width/ASPECT_RATIO
    drawRect(x - border_x, y, width + border_x * 2, -border_width, colour.border) --top
    drawRect(x, y, -border_x, height, colour.border) --left
    drawRect(x + width, y, border_x, height, colour.border) --right
    drawRect(x - border_x, y + height, width + border_x * 2, border_width, colour.border) --bottom
end

--rounding function
local function roundNum(num, decimals)
    local mult = 10^(decimals or 0)
    return math.floor(num * mult + 0.5) / mult
end

--weapon function (from lance)
local all_weapons = {}
local temp_weapons = util.get_weapons()
for a, b in pairs(temp_weapons) do
    all_weapons[#all_weapons + 1] = {hash = b["hash"], label_key = b["label_key"]}
end
local function hashToWeapon(hash) 
    for k, v in pairs(all_weapons) do 
        if v.hash == hash then 
            return util.get_label_text(v.label_key)
        end
    end
    return "徒手"
end

--boolean function
local function boolText(bool)
    if bool then return "是" else return "否" end
end

--check function
local function checkValue(pInfo)
    if pInfo == "" or pInfo == 0 or pInfo == nil or pInfo == "NULL" then return "无" else return pInfo end 
end

--format money
local function formatMoney(money)
    local order = math.ceil(string.len(tostring(money))/3 - 1)
    if order == 0 then return money end
    return roundNum(money/(1000^order), 1)..({"K", "M", "B"})[order]
end

while true do
    if true then
        local focused = players.get_focused()
        if ((focused[1] ~= nil and focused[2] == nil) or render_window) and menu.is_open() then

            --general info grabbing locals
            local pid = focused[1]
            if render_window then pid = players.user() end
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local my_pos, player_pos = players.get_position(players.user()), players.get_position(pid)
            
            --general element drawing locals
            local spacing_x = spacing/ASPECT_RATIO
            local padding_x = padding/ASPECT_RATIO
            local player_list_y = gui_y + name_h + spacing
            local total_w = gui_w + padding_x * 4

            -------------
            -- CONTENT --
            -------------

            local heading = ENTITY.GET_ENTITY_HEADING(ped)

            local regions = 
            {
                {
                    width = total_w/2,
                    content =
                    {
                        {"等级", players.get_rank(pid)},
                        {"K/D", roundNum(players.get_kd(pid), 2)},
                        {"现金", "$"..formatMoney(players.get_wallet(pid))},
                        {"存款", "$"..formatMoney(players.get_bank(pid))}
                    }
                },
                {
                    width = total_w/2,
                    content =
                    {
                        {"语言", ({"英语","法语","德语","意大利语","Spanish","葡萄牙语(巴西)","波兰语","俄语","韩语","繁体中文","日语","西班牙语(墨西哥)","简体中文"})[players.get_language(pid) + 1]},
                        {"手柄", boolText(players.is_using_controller(pid))},
                        {"延迟", math.floor(NETWORK._NETWORK_GET_AVERAGE_LATENCY_FOR_PLAYER(pid) + 0.5).." ms"},
                        {"主机令牌", "#"..players.get_host_queue_position(pid)},
                    }
                },
                {
                    width = total_w + spacing_x,
                    content =
                    {
                        {"模型", util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(ped))},
                        {"地区", util.get_label_text(ZONE.GET_NAME_OF_ZONE(player_pos.x, player_pos.y, player_pos.z))},
                        {"武器", hashToWeapon(WEAPON.GET_SELECTED_PED_WEAPON(ped))},
                        {"载具", checkValue(util.get_label_text(players.get_vehicle_model(pid)))}
                    }
                },
                {
                    width = total_w/2,
                    content =
                    {
                        {"距离", math.floor(MISC.GET_DISTANCE_BETWEEN_COORDS(player_pos.x, player_pos.y, player_pos.z, my_pos.x, my_pos.y, my_pos.z)).." m"},
                        {"速度", math.floor(ENTITY.GET_ENTITY_SPEED(ped) * 3.6).." km/h"},
                        {"方向", ({"北","西","南","东","北"})[math.ceil((heading + 45)/90)]..", "..math.ceil(heading).."度"}
                    }
                },
                {
                    width = total_w/2,
                    content =
                    {
                        {"组织", ({"无","保镖事务所","摩托帮"})[players.get_org_type(pid) + 2]},
                        {"通缉", PLAYER.GET_PLAYER_WANTED_LEVEL(pid).."/5星"},
                        {"过场动画中", boolText(NETWORK.IS_PLAYER_IN_CUTSCENE(pid))}
                    }
                },
                {
                    width = total_w + spacing_x,
                    content =
                    {
                        {"标签", checkValue(players.get_tags_string(pid))}
                    }
                }
            }

            ---------------------
            -- DRAWING CONTENT --
            ---------------------

            local font_w, font_h = directx.get_text_size("ABCDEFG", text_size/ASPECT_RATIO)
            local offset_x = 0
            local offset_y = 0
            
            for k, region in ipairs(regions) do
                local blur_instance = 1
                local count = 0
                for _ in region.content do count = count + 1 end
                local dict_h = count * (font_h + line_spacing) + padding * 2

                drawBorder(gui_x + offset_x, player_list_y + offset_y, region.width, dict_h)
                directx.blurrect_draw(blur[blur_instance], gui_x + offset_x, player_list_y + offset_y, region.width, dict_h, blur_strength)
                drawRect(gui_x + offset_x, player_list_y + offset_y, region.width, dict_h, colour.background)

                local line_count = 0.5
                for _, v in ipairs(region.content) do
                    directx.draw_text(
                    gui_x + offset_x + padding_x - 0.001, 
                    player_list_y + offset_y + padding + line_count * (font_h + line_spacing), 
                    v[1]..": ",
                    ALIGN_CENTRE_LEFT, 
                    text_size, 
                    colour.label
                    )
                    directx.draw_text(
                    gui_x + offset_x + region.width - padding_x - 0.001, 
                    player_list_y + offset_y + padding + line_count * (font_h + line_spacing), 
                    v[2], 
                    ALIGN_CENTRE_RIGHT, 
                    text_size, 
                    colour.info
                    )
                    line_count += 1
                end

                offset_x += region.width + spacing_x
                if offset_x >= total_w then
                    offset_y += dict_h + spacing
                    offset_x = 0
                end
                blur_instance += 1
            end

            --[[
                REST LOCALS 
            --]]

            local MAP_RATIO = 902/594
            local gui_h = offset_y - spacing
            local map_x = gui_x + total_w + spacing_x * 2
            local map_w = gui_h/MAP_RATIO/ASPECT_RATIO + 0.001
            local bar_w = gui_h/50/ASPECT_RATIO * bar_w_mult
            local map_w_total = map_w + padding_x * 3 + bar_w

            --[[ NAME BAR ]]

            drawBorder(gui_x, gui_y, total_w + spacing_x, name_h)

            directx.blurrect_draw(blur[6], gui_x, gui_y, total_w, name_h, blur_strength)

            drawRect(gui_x, gui_y, total_w + spacing_x, name_h, colour.title_bar)

            directx.draw_text(gui_x + total_w/2, gui_y + name_h/2, players.get_name(pid), ALIGN_CENTRE, name_size, colour.name)

            ---------------
            -- EMPTY BAR --
            ---------------

            drawBorder(map_x, gui_y, map_w_total, name_h)

            directx.blurrect_draw(blur[7], map_x, gui_y, map_w_total, name_h, blur_strength)

            drawRect(map_x, gui_y, map_w_total, name_h, colour.title_bar)

            ---------
            -- MAP --
            ---------

            --border, blur, background
            drawBorder(map_x, player_list_y, map_w_total, gui_h)

            directx.blurrect_draw(blur[8], map_x, player_list_y, map_w_total, gui_h, blur_strength)

            drawRect(map_x, player_list_y, map_w_total, gui_h, colour.background)

            --map
            directx.draw_texture(textures.map, map_w/2, gui_h, 0.5, 0.5, map_x + padding_x * 2 + bar_w + map_w/2 , player_list_y + gui_h/2, 0, colour.map)

            --blip
            local blip_dx = ((player_pos.x + 3745)/8316) * map_w
            local blip_dy = (1 - (player_pos.y + 4427)/12689) * gui_h
            directx.draw_texture(textures.blip, blip_size, blip_size, 0.5, 0.5, map_x + padding_x * 2 + bar_w + blip_dx, player_list_y + blip_dy, (360 - heading)/360, colour.blip)

            -------------------------
            -- HEALTH & ARMOUR BAR --
            -------------------------

            --armour bar
            local armour_perc = PED.GET_PED_ARMOUR(ped)/PLAYER.GET_PLAYER_MAX_ARMOUR(pid)
            local armour_bar_bg = {r = colour.armour_bar.r/2, g = colour.armour_bar.g/2, b = colour.armour_bar.b/2, a = colour.armour_bar.a}

            drawRect(map_x + padding_x, player_list_y + gui_h/2 - padding/2, bar_w, -((gui_h - padding * 3)/2 * armour_perc), colour.armour_bar) --foreground
            drawRect(map_x + padding_x, player_list_y + padding, bar_w, (gui_h - padding * 3)/2 * (1 - armour_perc), armour_bar_bg) --background

            --health bar
            local health_min = ENTITY.GET_ENTITY_HEALTH(ped) - 100
            if health_min < 0 then health_min = 0 end

            local health_perc = health_min/(ENTITY.GET_ENTITY_MAX_HEALTH(ped) - 100)
            local health_bar_bg = {r = colour.health_bar.r/2, g = colour.health_bar.g/2, b = colour.health_bar.b/2, a = colour.health_bar.a}

            drawRect(map_x + padding_x, player_list_y + gui_h - padding, bar_w, -((gui_h - padding * 3)/2 * health_perc), colour.health_bar) --foreground
            drawRect(map_x + padding_x, player_list_y + gui_h/2 + padding/2, bar_w, (gui_h - padding * 3)/2 * (1 - health_perc), health_bar_bg) --background
        end
    end
    util.yield()
end
