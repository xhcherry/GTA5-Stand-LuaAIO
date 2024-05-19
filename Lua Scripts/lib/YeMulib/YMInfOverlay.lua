local resx, resy = directx.get_client_size()
local aspectratio <const> = resx/resy

--set position
local guix = 0.41
local guiy = 0.5

--set colours
local colour =
{
    titlebar = {r = 1, g = 0, b = 1, a = 1},
    background = {r = 0, g = 0, b = 0, a = 77/255},
    healthbar = {r = 114/255, g = 204/255, b = 114/255, a = 150/255},
    armourbar = {r = 70/255, g = 136/255, b = 171/255, a = 150/255},
    blip = {r = 1, g = 1, b = 1, a = 1},
    name = {r = 1, g = 1, b = 1, a = 1},
    label = {r = 1, g = 1, b = 1, a = 1},
    info = {r = 1, g = 1, b = 1, a = 1},
    border = {r = 1, g = 0, b = 1, a = 1}
}

--settings element sizing & spacing
local nameh = 0.022
local padding = 0.008
local spacing = 0.003
local textw = 0.16

--settings text sizing & spacing
local namesize = 0.52
local textsize = 0.41
local linespacing = 0.0032

--settings border
local borderwidth = 0

--settings blur
local blurstrength = 4
local blur = {}
for i = 1, 8 do 
    blur[i] = directx.blurrect_new()
end
function blurrect_free()
    for i = 1, 8 do 
        directx.blurrect_free(blur[i])
    end
end

--map textures
local textures = {
    map = directx.create_texture(filesystem.resources_dir() .. "YMIMG/playerinfo/Map.png"),
    blip = directx.create_texture(filesystem.resources_dir() .. "YMIMG/playerinfo/Blip.png")
}



--menu
players_info = menu.toggle_loop(play_info,"开启玩家信息展示",{},"配置[√]\n请于其他选项使用[保存加载显示配置保存配置]",function()
    infoverplaytoggle()
end)
menu.set_value(players_info, config_active8) --配置

local renderwindow = false
infoverlay = menu.list(play_info, "玩家信息设置", {}, '', function()
    renderwindow = true 
end, function()
    renderwindow = false
end)

--set position
menu.divider(infoverlay, '位置')
menu.slider_float(infoverlay, 'X:', {'overlayx'}, '信息覆盖的水平位置.', 0, 1000, 0, 1, function(s)
    guix = s/1000
end)
menu.slider_float(infoverlay, 'Y:', {'overlayy'}, '信息覆盖的垂直位置.', 0, 1000, 0, 1, function(s)
    guiy = s/1000
end)

--appearance divider
menu.divider(infoverlay, '外观')

--set colours
local colours = menu.list(infoverlay, '叠加颜色', {}, '')

menu.divider(colours, '元素')

menu.colour(colours, '标题栏颜色', {'overlaytitlebar'}, '标题栏的颜色.', colour.titlebar, true, function(on_change)
    colour.titlebar = on_change
end)
menu.colour(colours, '背景色', {'overlaybg'}, '背景颜色.', colour.background, true, function(on_change)
    colour.background = on_change
end)
menu.colour(colours, '生命条颜色', {'overlayhealthbar'}, '生命条的颜色.', colour.healthbar, true, function(on_change)
    colour.healthbar = on_change
end)
menu.colour(colours, '护甲条颜色', {'overlayarmourbar'}, '护甲条的颜色.', colour.armourbar, true, function(on_change)
    colour.armourbar = on_change
end)
menu.colour(colours, '光点颜色', {'overlayblip'}, '地图光点的颜色.', colour.blip, true, function(on_change)
    colour.blip = on_change
end)

menu.divider(colours, '文本')
menu.colour(colours, '名称颜色', {'overlayname'}, '玩家名字文字的颜色.', colour.name, true, function(on_change)
    colour.name = on_change
end)
menu.colour(colours, '标签颜色', {'overlaylabel'}, '标签文本的颜色.', colour.label, true, function(on_change)
    colour.label = on_change
end)
menu.colour(colours, '信息颜色', {'overlayinfo'}, '信息文本的颜色.', colour.info, true, function(on_change)
    colour.info = on_change
end)

--set element sizing & spacing
local elementdim = menu.list(infoverlay, '元素大小和间距', {}, '')

menu.divider(elementdim, '元素大小和间距')

menu.slider(elementdim, '标题栏高度', {}, '标题栏的高度.', 0, 100, 22, 1, function(on_change)
    nameh = on_change/1000
end)
menu.slider(elementdim, '叠加宽度', {}, '文本窗口的宽度减去填充.', 0, 50, 16, 1, function(on_change)
    textw = on_change/100
end)
menu.slider(elementdim, '填充', {}, '在信息文本周围填充.', 0, 30, 8, 1, function(on_change)
    padding = on_change/1000
end)
menu.slider(elementdim, '间距', {}, '不同元素的间距.', 0, 20, 3, 1, function(on_change)
    spacing = on_change/1000
end)

--set text sizing & spacing
local textdim = menu.list(infoverlay, '文本大小和间距', {}, '')

menu.divider(textdim, '文本大小和间距')

menu.slider_float(textdim, '名称', {}, '玩家名称文本的大小.', 0, 100, 52, 1, function(on_change)
    namesize = on_change/100
end)
menu.slider_float(textdim, '信息文本', {}, '信息文本的大小.', 0, 100, 41, 1, function(on_change)
    textsize = on_change/100
end)
menu.slider(textdim, '行间距', {}, '信息文本行之间的间距.', 0, 100, 32, 1, function(on_change)
    linespacing = on_change/10000
end)

--set border
local border = menu.list(infoverlay, '边框', {}, '')

menu.divider(border, '边框设置')

menu.slider(border, '宽度', {}, '元素周围呈现的边框宽度.', 0, 20, 0, 1, function(on_change)
    borderwidth = on_change/1000
end)
local colourborder = menu.colour(border, '颜色', {'overlayborder'}, '渲染边框的颜色.', colour.border, true, function(on_change)
    colour.border = on_change
end)
menu.rainbow(colourborder)

--set blur
menu.slider(infoverlay, '背景模糊', {}, '应用于背景的模糊量.', 0, 10, 4, 1, function(on_change)
    blurstrength = on_change
end)

--draw functions
local function draw_rect(rect_x, rect_y, rect_w, rect_h, colour)
    directx.draw_rect(rect_x, rect_y, rect_w, rect_h, 
    {r = colour.r * colour.a, g = colour.g * colour.a, b = colour.b * colour.a, a = colour.a})
end

local function draw_border(x, y, w, h)
    local borderx = borderwidth/aspectratio
    draw_rect(x - borderx, y, w + borderx * 2, -borderwidth, colour.border) --top
    draw_rect(x, y, -borderx, h, colour.border) --left
    draw_rect(x + w, y, borderx, h, colour.border) --right
    draw_rect(x - borderx, y + h, w + borderx * 2, borderwidth, colour.border) --bottom
end

--rounding function
local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

--weapon function (from lance)
all_weapons = {}
local temp_weapons = util.get_weapons()
for a,b in pairs(temp_weapons) do
    all_weapons[#all_weapons + 1] = {hash = b['hash'], label_key = b['label_key']}
end
local function weapon_from_hash(hash) 
    for k, v in pairs(all_weapons) do 
        if v.hash == hash then 
            return util.get_label_text(v.label_key)
        end
    end
    return '徒手'
end

--boolean function
local function boolean(bool)
    if bool then return '是' else return '不' end
end

--check function
local function check(info)
    if info == '' or info == 0 or info == nil or info == 'NULL' then return '无' else return info end 
end

--format money
local function format_money(money_value)
    local order = math.ceil(string.len(tostring(money_value))/3 - 1)
    if order == 0 then return money_value end
    return round(money_value/(1000^order), 1)..({'K', 'M', 'B'})[order]
end

----main function
function infoverplaytoggle()
    if NETWORK.NETWORK_IS_SESSION_STARTED() then
        local focused = players.get_focused()
        if ((focused[1] ~= nil and focused[2] == nil) or renderwindow) and menu.is_open() then

            --general info grabbing locals
            local PlayerID = focused[1]
            if renderwindow then PlayerID = players.user() end
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local mypos, playerpos = players.get_position(players.user()), players.get_position(PlayerID)
            
            --general element drawing locals
            local playerlisty = guiy + nameh + spacing
            local guiw = textw + padding/aspectratio * 4
            local xspacing = spacing/aspectratio

            -------------
            -- CONTENT --
            -------------

            local heading = ENTITY.GET_ENTITY_HEADING(ped)

            local regions = 
            {
                {
                    width = guiw/2,
                    content =
                    {
                        {'等级', players.get_rank(PlayerID)},
                        {'K/D', round(players.get_kd(PlayerID), 2)},
                        {'钱包', '$'..format_money(players.get_wallet(PlayerID))},
                        {'银行', '$'..format_money(players.get_bank(PlayerID))}
                    }
                },
                {
                    width = guiw/2,
                    content =
                    {
                        {'语言', ({'英语','法语','德语','意大利语','西班牙语','巴西语','波兰语','俄语','韩语','繁体中文','日语','墨西哥语','简体中文'})[players.get_language(PlayerID) + 1]},
                        {'控制器', boolean(players.is_using_controller(PlayerID))},
                        {'主机队列', '#'..players.get_host_queue_position(PlayerID)},
                    }
                },
                {
                    width = guiw + xspacing,
                    content =
                    {
                        {'角色模型', util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(ped))},
                        {'地区', util.get_label_text(ZONE.GET_NAME_OF_ZONE(playerpos.x, playerpos.y, playerpos.z))},
                        {'武器', weapon_from_hash(WEAPON.GET_SELECTED_PED_WEAPON(ped))},
                        {'载具', check(util.get_label_text(players.get_vehicle_model(PlayerID)))}
                    }
                },
                {
                    width = guiw/2,
                    content =
                    {
                        {'距离', math.floor(MISC.GET_DISTANCE_BETWEEN_COORDS(playerpos.x, playerpos.y, playerpos.z, mypos.x, mypos.y, mypos.z))..' m'},
                        {'速度', math.floor(ENTITY.GET_ENTITY_SPEED(ped) * 3.6)..' km/h'},
                        {'朝向', ({'北','西','南','东','北'})[math.ceil((heading + 45)/90)]..', '..math.ceil(heading)..'°'}
                    }
                },
                {
                    width = guiw/2,
                    content =
                    {
                        {'组织', ({'无','CEO','摩托帮'})[players.get_org_type(PlayerID) + 2]},
                        {'通缉', PLAYER.GET_PLAYER_WANTED_LEVEL(PlayerID)..'/5'},
                        {'过场动画', boolean(NETWORK.IS_PLAYER_IN_CUTSCENE(PlayerID))}
                    }
                },
                {
                    width = guiw + xspacing,
                    content =
                    {
                        {'标签', check(players.get_tags_string(PlayerID))}
                    }
                }
            }

            ---------------------
            -- DRAWING CONTENT --
            ---------------------

            local _, textheight = directx.get_text_size('abcdefg', textsize)
            local xoffset = 0
            local yoffset = 0
            
            for k, region in ipairs(regions) do
                local blurinstance = 1
                local count = 0
                for _ in region.content do count = count + 1 end
                local dictheight = count * (textheight + linespacing) - linespacing + padding * 2

                draw_border(guix + xoffset, playerlisty + yoffset, region.width, dictheight)
                directx.blurrect_draw(blur[blurinstance], guix + xoffset, playerlisty + yoffset, region.width, dictheight, blurstrength)
                draw_rect(guix + xoffset, playerlisty + yoffset, region.width, dictheight, colour.background)

                local linecount = 0
                for _, v in ipairs(region.content) do
                    directx.draw_text(
                    guix + xoffset + padding/aspectratio - 0.001, 
                    playerlisty + yoffset + padding + linecount * (textheight + linespacing), 
                    v[1]..': ',
                    ALIGN_TOP_LEFT, 
                    textsize, 
                    colour.label
                    )
                    directx.draw_text(
                    guix + xoffset + region.width - padding/aspectratio - 0.001, 
                    playerlisty + yoffset + padding + linecount * (textheight + linespacing), 
                    v[2], 
                    ALIGN_TOP_RIGHT, 
                    textsize, 
                    colour.info
                    )
                    linecount += 1
                end

                xoffset += region.width + xspacing
                if xoffset >= guiw then
                    yoffset += dictheight + spacing
                    xoffset = 0
                end
                blurinstance += 1
            end

            --[[
                REST LOCALS 
            --]]

            local guih = yoffset - spacing
            local mapx = guix + guiw + xspacing * 2
            local mapwidth = guih/(898/590)/aspectratio + 0.001
            local totalmapwidth = (mapwidth + padding/aspectratio * 3) * (1 + 1/22)

            --[[ NAME BAR ]]

            draw_border(guix, guiy, guiw + xspacing, nameh)

            directx.blurrect_draw(blur[6], guix, guiy, guiw, nameh, blurstrength)

            draw_rect(guix, guiy, guiw + xspacing, nameh, colour.titlebar)

            directx.draw_text(guix + guiw/2, guiy + nameh/2, players.get_name(PlayerID), ALIGN_CENTRE, namesize, colour.name)

            ---------------
            -- EMPTY BAR --
            ---------------

            draw_border(mapx, guiy, totalmapwidth, nameh)


            directx.blurrect_draw(blur[7], mapx, guiy, totalmapwidth, nameh, blurstrength)

            draw_rect(mapx, guiy, totalmapwidth, nameh, colour.titlebar)

            directx.draw_text(mapx, guiy + nameh/2, "夜幕LUA", ALIGN_CENTRE, namesize, colour.name)

            ---------
            -- MAP --
            ---------

            --border, blur, background
            draw_border(mapx, playerlisty, totalmapwidth, guih)

            directx.blurrect_draw(blur[8], mapx, playerlisty, totalmapwidth, guih, blurstrength)

            draw_rect(mapx, playerlisty, totalmapwidth, guih, colour.background)

            --map
            directx.draw_texture(textures.map, mapwidth/2, 0, 0, 0, mapx + padding/aspectratio * 2 + totalmapwidth/22, playerlisty, 0, 1, 1, 1, 0.75)

            --blip
            directx.draw_texture(textures.blip, 0.004, 0, 0.5, 0.5, mapx + padding/aspectratio * 2 + totalmapwidth/22 + ((playerpos.x + 4000)/8500) * mapwidth, playerlisty + (1 - (playerpos.y + 4000)/12000) * guih, (360 - heading)/360, colour.blip)

            -------------------------
            -- HEALTH & ARMOUR BAR --
            -------------------------

            --armour bar
            local armourperc = PED.GET_PED_ARMOUR(ped)/PLAYER.GET_PLAYER_MAX_ARMOUR(PlayerID)
            local armourbarsecondary = {r = colour.armourbar.r/2, g = colour.armourbar.g/2, b = colour.armourbar.b/2, a = colour.armourbar.a}

            draw_rect(mapx + padding/aspectratio, playerlisty + guih/2 - padding/2, totalmapwidth/22, -((guih - padding * 3)/2 * armourperc), colour.armourbar) --foreground
            draw_rect(mapx + padding/aspectratio, playerlisty + padding, totalmapwidth/22, (guih - padding * 3)/2 * (1 - armourperc), armourbarsecondary) --background

            --health bar
            local minhealth = ENTITY.GET_ENTITY_HEALTH(ped) - 100
            if minhealth < 0 then minhealth = 0 end

            local healthperc = minhealth/(ENTITY.GET_ENTITY_MAX_HEALTH(ped) - 100)
            local healthbarsecondary = {r = colour.healthbar.r/2, g = colour.healthbar.g/2, b = colour.healthbar.b/2, a = colour.healthbar.a}

            draw_rect(mapx + padding/aspectratio, playerlisty + guih - padding, totalmapwidth/22, -((guih - padding * 3)/2 * healthperc), colour.healthbar) --foreground
            draw_rect(mapx + padding/aspectratio, playerlisty + guih/2 + padding/2, totalmapwidth/22, (guih - padding * 3)/2 * (1 - healthperc), healthbarsecondary) --background
        end
    end
end