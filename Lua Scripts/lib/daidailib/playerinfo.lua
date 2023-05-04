--client resolution/aspect ratio
local res_x, res_y = directx.get_client_size()
local ASPECT_RATIO <const> = res_x/res_y

--set position
gui_x = 0
gui_y = 0

--settings element sizing & spacing
name_h = 0.022
padding = 0.008
spacing = 0.003
gui_w = 0.16

--settings text sizing & spacing
name_size = 0.52
text_size = 0.41
line_spacing = 0.0032

--map textures
local textures = {
    map = directx.create_texture(filesystem.resources_dir() .. "daidai-img/playerinfo/Map.png"),
    blip = directx.create_texture(filesystem.resources_dir() .. "daidai-img/playerinfo/Blip.png")
}

function drawRect(x, y, w, h, colour)
    directx.draw_rect(x, y, w, h, 
    {r = colour.r * colour.a, g = colour.g * colour.a, b = colour.b * colour.a, a = colour.a})
end
--settings border
border_width = 0
function border_widthd(on_change)
    border_width = on_change/1000
end


--set infocolours
infocolour = {
    title_bar = {r = 1, g = 0, b = 1, a = 1},
    background = {r = 0, g = 0, b = 0, a = 77/255},
    health_bar = {r = 114/255, g = 204/255, b = 114/255, a = 150/255},
    armour_bar = {r = 70/255, g = 136/255, b = 171/255, a = 150/255},
    blip = {r = 1, g = 1, b = 1, a = 1},
    name = {r = 1, g = 1, b = 1, a = 1},
    label = {r = 1, g = 1, b = 1, a = 1},
    info = {r = 1, g = 1, b = 1, a = 1},
    border = {r = 1, g = 0, b = 1, a = 1}
}
function title_bar_color(on_change)
    infocolour.title_bar = on_change
end
function drawBorder(x, y, width, height)
    local border_x = border_width/ASPECT_RATIO
    drawRect(x - border_x, y, width + border_x * 2, -border_width, infocolour.border) --top
    drawRect(x, y, -border_x, height, infocolour.border) --left
    drawRect(x + width, y, border_x, height, infocolour.border) --right
    drawRect(x - border_x, y + height, width + border_x * 2, border_width, infocolour.border) --bottom
end
function roundNum(num, decimals)
    local mult = 10^(decimals or 0)
    return math.floor(num * mult + 0.5) / mult
end

--weapon function
all_weapons = {}
local temp_weapons = util.get_weapons()
for a, b in pairs(temp_weapons) do
    all_weapons[#all_weapons + 1] = {hash = b["hash"], label_key = b["label_key"]}
end
function hashToWeapon(hash) 
    for k, v in pairs(all_weapons) do 
        if v.hash == hash then 
            return util.get_label_text(v.label_key)
        end
    end
    return "徒手"
end
--boolean function
function boolText(bool)
    if bool then return "Yes" else return "No" end
end
--check function
function checkValue(pInfo)
    if pInfo == "" or pInfo == 0 or pInfo == nil or pInfo == "NULL" then return "无" else return pInfo end 
end
--format money
function formatMoney(money)
    local order = math.ceil(string.len(tostring(money))/3 - 1)
    if order == 0 then return money end
    return roundNum(money/(1000^order), 1)..({"K", "M", "B"})[order]
end

----main function
function infoverplaytoggle()
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
        local heading = ENTITY.GET_ENTITY_HEADING(ped)
        local regions = 
        {
            {
                width = total_w/2,
                content =
                {
                    {"等级", players.get_rank(pid)},
                    {"K/D", roundNum(players.get_kd(pid), 2)},
                    {"钱包", "$"..formatMoney(players.get_wallet(pid))},
                    {"银行", "$"..formatMoney(players.get_bank(pid))}
                }
            },
            {
                width = total_w/2,
                content =
                {
                    {"语言", ({"英语","法语","德语","意大利语","西班牙语","巴西语","波兰语","俄语","韩语","繁体中文","日语","墨西哥语","简体中文"})[players.get_language(pid) + 1]},
                    {"控制器", boolText(players.is_using_controller(pid))},
                    {"延迟", math.floor(NETWORK1._NETWORK_GET_AVERAGE_LATENCY_FOR_PLAYER(pid) + 0.5).." ms"},
                    {"主机序列", "#"..players.get_host_queue_position(pid)},
                }
            },
            {
                width = total_w + spacing_x,
                content =
                {
                    {"模型", util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(ped))},
                    {"地区", util.get_label_text(ZONE.GET_NAME_OF_ZONE(player_pos.x, player_pos.y, player_pos.z))},
                    {"武器", hashToWeapon(WEAPON.GET_SELECTED_PED_WEAPON(ped))},
                    {"车辆", checkValue(util.get_label_text(players.get_vehicle_model(pid)))}
                }
            },
            {
                width = total_w/2,
                content =
                {
                    {"距离", math.floor(MISC.GET_DISTANCE_BETWEEN_COORDS(player_pos.x, player_pos.y, player_pos.z, my_pos.x, my_pos.y, my_pos.z)).." m"},
                    {"速度", math.floor(ENTITY.GET_ENTITY_SPEED(ped) * 3.6).." km/h"},
                    {"朝向", ({"北","西","南","东","北"})[math.ceil((heading + 45)/90)]..", "..math.ceil(heading).."°"}
                }
            },
            {
                width = total_w/2,
                content =
                {
                    {"组织", ({"无","CEO","摩托帮"})[players.get_org_type(pid) + 2]},
                    {"通缉", PLAYER.GET_PLAYER_WANTED_LEVEL(pid).."/5"},
                    {"过场动画", boolText(NETWORK.IS_PLAYER_IN_CUTSCENE(pid))}
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

        local font_w, font_h = directx.get_text_size("abcdefg", text_size)
        local offset_x = 0
        local offset_y = 0
        for k, region in ipairs(regions) do
            local count = 0
            for _ in region.content do count = count + 1 end
            local dict_h = count * (font_h + line_spacing) - line_spacing + padding * 2
            drawBorder(gui_x + offset_x, player_list_y + offset_y, region.width, dict_h)
            drawRect(gui_x + offset_x, player_list_y + offset_y, region.width, dict_h, infocolour.background)
            local line_count = 0
            for _, v in ipairs(region.content) do
                directx.draw_text(
                gui_x + offset_x + padding_x - 0.001, 
                player_list_y + offset_y + padding + line_count * (font_h + line_spacing), 
                v[1]..": ",
                ALIGN_TOP_LEFT, 
                text_size, 
                infocolour.label
                )
                directx.draw_text(
                gui_x + offset_x + region.width - padding_x - 0.001, 
                player_list_y + offset_y + padding + line_count * (font_h + line_spacing), 
                v[2], 
                ALIGN_TOP_RIGHT, 
                text_size, 
                infocolour.info
                )
                line_count += 1
            end
            offset_x += region.width + spacing_x
            if offset_x >= total_w then
                offset_y += dict_h + spacing
                offset_x = 0
            end
        end

        local gui_h = offset_y - spacing
        local bar_w = gui_h/50
        local map_x = gui_x + total_w + spacing_x * 2
        local map_w = gui_h/(898/590)/ASPECT_RATIO + 0.001
        local map_w_total = map_w + padding_x * 3 + bar_w

        drawBorder(gui_x, gui_y, total_w + spacing_x, name_h)
        drawRect(gui_x, gui_y, total_w + spacing_x, name_h, infocolour.title_bar)
        directx.draw_text(gui_x + total_w/2, gui_y + name_h/2, players.get_name(pid), ALIGN_CENTRE, name_size, infocolour.name)
        drawBorder(map_x, gui_y, map_w_total, name_h)
        drawRect(map_x, gui_y, map_w_total, name_h, infocolour.title_bar)
        drawBorder(map_x, player_list_y, map_w_total, gui_h)
        drawRect(map_x, player_list_y, map_w_total, gui_h, infocolour.background)
        directx.draw_texture(textures.map, map_w/2, 0, 0, 0, map_x + padding_x * 2 + bar_w, player_list_y, 0, 1, 1, 1, 0.75)
        directx.draw_texture(textures.blip, 0.004, 0, 0.5, 0.5, map_x + padding_x * 2 + bar_w + ((player_pos.x + 4000)/8500) * map_w, player_list_y + (1 - (player_pos.y + 4000)/12000) * gui_h, (360 - heading)/360, infocolour.blip)

        local armour_perc = PED.GET_PED_ARMOUR(ped)/PLAYER.GET_PLAYER_MAX_ARMOUR(pid)
        local armour_bar_bg = {r = infocolour.armour_bar.r/2, g = infocolour.armour_bar.g/2, b = infocolour.armour_bar.b/2, a = infocolour.armour_bar.a}
        drawRect(map_x + padding_x, player_list_y + gui_h/2 - padding/2, bar_w, -((gui_h - padding * 3)/2 * armour_perc), infocolour.armour_bar) --foreground
        drawRect(map_x + padding_x, player_list_y + padding, bar_w, (gui_h - padding * 3)/2 * (1 - armour_perc), armour_bar_bg) --background

        local health_min = ENTITY.GET_ENTITY_HEALTH(ped) - 100
        if health_min < 0 then health_min = 0 end

        local health_perc = health_min/(ENTITY.GET_ENTITY_MAX_HEALTH(ped) - 100)
        local health_bar_bg = {r = infocolour.health_bar.r/2, g = infocolour.health_bar.g/2, b = infocolour.health_bar.b/2, a = infocolour.health_bar.a}

        drawRect(map_x + padding_x, player_list_y + gui_h - padding, bar_w, -((gui_h - padding * 3)/2 * health_perc), infocolour.health_bar) --foreground
        drawRect(map_x + padding_x, player_list_y + gui_h/2 + padding/2, bar_w, (gui_h - padding * 3)/2 * (1 - health_perc), health_bar_bg) --background
    end
end