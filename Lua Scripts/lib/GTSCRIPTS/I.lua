--NovaMeter by Nova_Plays my discord is Nova_Plays#9126
--this script is pretty bad coded well for me its more ez like that and i didnt want to get into the blur draw shit so yeah feel free to change what u dont like to the code ur own
--but if u do it ask me if you can post it as a script please :d
--the background and topborder are made with gimp bc i dont have photoshop well they look okay so yeah
--if you have any ideas for this script it has an auto updater so feel free to dm me on discord and share ur idea if its good then ill try to add it :d
--the functions are made by me even tho when i looked at glance they seem to be a bit the same but well yeah some things are skidded tho bc it was not worth to need to look for new things on how to do it. 
--hope u like this
util.keep_running()

if not SCRIPT_SILENT_START then
    util.toast("已加载信息栏内容") 
end

-----------------
--GETTING FILES--
-----------------
resources_dir = filesystem.scripts_dir() .. '\\GTLuaScript\\'.. '\\GTINFO\\'
local topborder = directx.create_texture(resources_dir .. "topborder.png")
local mainback = directx.create_texture(resources_dir .. "mainbackground.png")
local mapborder = directx.create_texture(resources_dir .. "topbordermap.png")
local mapback = directx.create_texture(resources_dir .. "mapbackground.png")
local map = directx.create_texture(resources_dir .. "GTA_Map.png")
local blip = directx.create_texture(resources_dir .. "Blip.png")
local Playerblip = directx.create_texture(resources_dir .. "Playerblip.png")

----------
--TABLES--
----------
--colors--
local colors = {
        topbar = {["r"] = 50/255, ["g"] = 50/255, ["b"] = 50/255, ["a"] = 1.0}, --grayish
        background = {["r"] = 5/255, ["g"] = 5/255, ["b"] = 5/255, ["a"] = 1.0}, --blackish
        subhead = {["r"] = 1, ["g"] = 1, ["b"] = 1, ["a"] = 1.0}, --white
        label = {["r"] = 1, ["g"] = 1, ["b"] = 1, ["a"] = 1.0}, --white
        highlight = {["r"] = 160/255, ["g"] = 160/255, ["b"] = 160/255, ["a"] = 1.0}, -- also grayish
        yes_color = {["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1.0}, --green
        no_color = {["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1.0}, --red
        orange = {["r"] = 1, ["g"] = 138/255, ["b"] = 31/255, ["a"] = 1.0},
        map = {r = 1, g = 1, b = 1, a = 0.75}, --white
        blip = {["r"] = 1, ["g"] = 1, ["b"] = 1, ["a"] = 1.0}, --white
        health_bar = {r = 57/255, g = 102/255, b = 57/255, a = 150/255},
        armour_bar = {r = 35/255, g = 68/255, b = 85.5/255, a = 150/255},
        health_bar_text = {r = 99/255, g = 175/255, b = 99/255, a = 1.0},
        armor_bar_text = {r = 62/255, g = 118/255, b = 147/255, a = 1.0}
}

--languages--
local languages = {
    [0] = "英语",
    [1] = "法语",
    [2] = "德语",
    [3] = "意大利语",
    [4] = "西班牙语",
    [5] = "葡萄牙语(巴西)",
    [6] = "波兰语",
    [7] = "俄语",
    [8] = "韩语",
    [9] = "繁体中文",
    [10] = "日语",
    [11] = "西班牙语(墨西哥)",
    [12] = "简体中文"
    }
-----------
--OPTIONS--
-----------

--show map--
local map_show = true
local show_map = menu.toggle(player_info, "显示地图", {}, "", function(on)
    map_show = on
end, true)

show_map_show = false
menu.on_focus(show_map, function()
    show_map_show = true
end)

menu.on_blur(show_map, function()
    show_map_show = false
end)

--lists--
local color_list = menu.list(player_info, "颜色")

color_show_list = false
menu.on_focus(color_list, function()
    color_show_list = true
end)

menu.on_blur(color_list, function()
    color_show_list = false
end)

local value_color_list = menu.list(player_info, "数值颜色")

value_show_list = false
menu.on_focus(value_color_list, function()
    value_show_list = true
end)

menu.on_blur(value_color_list, function()
    value_show_list = false
end)

--CHANGE COLORS--
--topbar--
local color_change_topbar = menu.colour(color_list, "标题栏", {}, "", colors.topbar, true, function(color)
    colors.topbar = color
end)

color_show_topbar = false
menu.on_focus(color_change_topbar, function()
    color_show_topbar = true
end)

menu.on_blur(color_change_topbar, function()
    color_show_topbar = false
end)

--background--
local color_change_back = menu.colour(color_list, "背景", {}, "", colors.background, true, function(color)
    colors.background = color
end)

color_show_back = false
menu.on_focus(color_change_back, function()
    color_show_back = true
end)

menu.on_blur(color_change_back, function()
    color_show_back = false
end)

--subhead--
local color_change_sub = menu.colour(color_list, "副标题", {}, "名称, 玩家信息, 角色信息.", colors.subhead, true, function(color)
    colors.subhead = color
end)

color_show_sub = false
menu.on_focus(color_change_sub, function()
    color_show_sub = true
end)

menu.on_blur(color_change_sub, function()
    color_show_sub = false
end)

--label--
local color_change_label = menu.colour(color_list, "标签", {}, "", colors.label, true, function(color)
    colors.label = color
end)

color_show_label = false
menu.on_focus(color_change_label, function()
    color_show_label = true
end)

menu.on_blur(color_change_label, function()
    color_show_label = false
end)

--highlight--
local color_change_high = menu.colour(color_list, "突出文本", {}, "", colors.highlight, true, function(color)
    colors.highlight = color
end)

color_show_high = false
menu.on_focus(color_change_high, function()
    color_show_high = true
end)

menu.on_blur(color_change_high, function()
    color_show_high = false
end)

--map--
local color_change_map = menu.colour(color_list, "地图", {}, "", colors.map, true, function(color)
    colors.map = color
end)

color_show_map = false
menu.on_focus(color_change_map, function()
    color_show_map = true
end)

menu.on_blur(color_change_map, function()
    color_show_map = false
end)

--blip--
local color_change_blip = menu.colour(color_list, "光标", {}, "", colors.blip, true, function(color)
    colors.blip = color
end)

color_show_blip = false
menu.on_focus(color_change_blip, function()
    color_show_blip = true
end)

menu.on_blur(color_change_blip, function()
    color_show_blip = false
end)
--CHANGE VALUE COLORS ON/OFF--
--bool--
local bool_change = false
local bool_change_color = menu.toggle(value_color_list, "禁用布尔值颜色", {}, "选择红色/绿色值是否变成灰色", function(on)
    bool_change = on
end)

change_bool_show = false
menu.on_focus(bool_change_color, function()
    change_bool_show = true
end)

menu.on_blur(bool_change_color, function()
    change_bool_show = false
end)

--money--
local money_change = false
local money_change_color = menu.toggle(value_color_list, "禁用钱数颜色", {}, "选择红色/绿色数值是否变成灰色", function(on)
    money_change = on
end)

change_money_show = false
menu.on_focus(money_change_color, function()
    change_money_show = true
end)

menu.on_blur(money_change_color, function()
    change_money_show = false
end)

--position-- this is messy asf but ig its the only way by how i coded the script
local defposX, defposY = 0.215, 0.125
local backgroundposX, backgroundposY = defposX-0.09, defposY+0.195
local topbarposX, topbarposY = defposX-0.09, defposY+0.1955
local mapborderposX, mapborderposY = defposX+0.10106, defposY+0.1955
local mapbackgroundposX, mapbackgroundposY = defposX+0.10106, defposY+0.195
local nameposX, nameposY = defposX-0.092, defposY-0.028
local PLAYERposX, PLAYERposY = defposX-0.025, defposY-0.010
local PLAYERS_textposX, PLAYERS_textposY = defposX-0.050, defposY+0.010
local CHARACTERposX, CHARACTERposY = defposX-0.165, defposY-0.010
local CHARACTER_textposX, CHARACTER_textposY = defposX-0.195, defposY+0.010
local GENERALposX, GENERALposY = defposX-0.092, defposY+0.208
local GENERAL_textposX, GENERAL_textposY = defposX-0.195, defposY+0.220
local tagsposX, tagsposY = defposX-0.195, defposY+0.375
local mapposX, mapposY = defposX+0.096159587, defposY+0.16583594
local blipposX, blipposY = defposX+0.0079167, defposY-0.02740741
local health_barX, barY = defposX+0.025, defposY+0.385
local armor_barX = defposX+0.1
local health_bartxtX, bar_txtY = defposX+0.06, defposY+0.377
local armor_bartxtX = defposX+0.135

--x--
local posXslider = menu.slider(player_info, "X 位置", {}, "默认为 215", 1, 1000, defposX*1000, 1, function(x)
    backgroundposX = x/1000 - 0.09
    topbarposX = x/1000 - 0.09
    mapborderposX = x/1000 + 0.10106
    mapbackgroundposX = x/1000 + 0.10106
    nameposX = x/1000 - 0.092
    PLAYERposX = x/1000 - 0.025
    PLAYERS_textposX = x/1000 - 0.050
    CHARACTERposX = x/1000 - 0.165
    CHARACTER_textposX = x/1000 - 0.195
    GENERALposX = x/1000 - 0.092
    GENERAL_textposX = x/1000 - 0.195
    tagsposX = x/1000 - 0.195
    mapposX = x/1000 + 0.096159587
    blipposX = x/1000 + 0.0079167
    health_barX = x/1000 + 0.025
    armor_barX = x/1000 + 0.1
    health_bartxtX = x/1000 + 0.06
    armor_bartxtX = x/1000 + 0.135
end)

posXslider_show = false
menu.on_focus(posXslider, function()
    posXslider_show = true
end)

menu.on_blur(posXslider, function()
    posXslider_show = false
end)

--y--
local posYslider = menu.slider(player_info, "Y 位置", {}, "默认为 125", 1, 1000, defposY*1000, 1, function(y)
    backgroundposY = y/1000 + 0.195
    topbarposY = y/1000 + 0.1955
    mapborderposY = y/1000 + 0.1955
    mapbackgroundposY = y/1000 + 0.195
    nameposY = y/1000 - 0.028
    PLAYERposY = y/1000 - 0.010
    PLAYERS_textposY = y/1000 + 0.010
    CHARACTERposY = y/1000 - 0.010
    CHARACTER_textposY = y/1000 + 0.010
    GENERALposY = y/1000 + 0.208
    GENERAL_textposY = y/1000 + 0.220
    tagsposY = y/1000 + 0.375
    mapposY = y/1000 + 0.16583594
    blipposY = y/1000 - 0.02740741
    barY = y/1000 + 0.385
    bar_txtY = y/1000 + 0.377
end)

posYslider_show = false
menu.on_focus(posYslider, function()
    posYslider_show = true
end)

menu.on_blur(posYslider, function()
    posYslider_show = false
end)

local blipsize = 0.0035
local blipsizeslider = menu.slider(player_info, "光标大小", {}, "默认为 35", 1, 100, blipsize*10000, 1, function(size)
    blipsize = size/10000
end)

blipsizeslider_show = false
menu.on_focus(blipsizeslider, function()
    blipsizeslider_show = true
end)

menu.on_blur(blipsizeslider, function()
    blipsizeslider_show = false
end)

local selfblip = true
local yourblip = menu.toggle(player_info, "在地图上显示自己", {}, "", function(on)
    selfblip = on
end, true)

yourblip_show = false
menu.on_focus(yourblip, function()
    yourblip_show = true
end)

menu.on_blur(yourblip, function()
    yourblip_show = false
end)

--change measurement--
local mesh = 1
local change_unit = menu.list_select(player_info, "速度单位", {}, "更改速度信息为选择的单位", {"英里/时", "公里/时"}, 1, function(index)
    mesh = index 
end)

change_unit_show = false
menu.on_focus(change_unit, function()
    change_unit_show = true
end)

menu.on_blur(change_unit, function()
    change_unit_show = false
end)

local info_list = menu.list(player_info, "信息")

menu.action(info_list, "感谢 thingy 提供地图", {}, "", function()
end)

-------------
--FUNCTIONS--
-------------
--shamelessly stolen from lance that stole it from keks--
function dec_to_ipv4(ip)
	return string.format(
		"%i.%i.%i.%i", 
		ip >> 24 & 0xFF, 
		ip >> 16 & 0xFF, 
		ip >> 8  & 0xFF, 
		ip 		 & 0xFF
	)
end

--weapon function--
all_weapons = {}
temp_weapons = util.get_weapons()
-- create a table with just weapon hashes, labels
for a,b in pairs(temp_weapons) do
    all_weapons[#all_weapons + 1] = {hash = b['hash'], label_key = b['label_key']}
end
function get_weapon_name_from_hash(hash) 
    for k,v in pairs(all_weapons) do 
        if v.hash == hash then 
            return util.get_label_text(v.label_key)
        end
    end
    return '徒手'
end

function bool(bool)
    if bool then
        return "是"
    else
        return "否"
    end
end

function check(info)
    if info == nil or info == "NULL" or info == 0 or info == " " then
        return "无"
    else
        return info
    end
end

function queuecheck(info)
    if info == nil or info == "NULL" or info == " " then
        return 0
    else
        return "#" .. info
    end
end

function org(org_type)
    if org_type == -1 then
        return "无"
    elseif org_type == 0 then
        return "保镖事务所"
    else
        return "摩托帮"
    end
end

function distance(mypos, playerpos)
    local distance = math.floor(MISC.GET_DISTANCE_BETWEEN_COORDS(playerpos.x, playerpos.y, playerpos.z, mypos.x, mypos.y, mypos.z))
        if distance == nil or distance == "NULL" or distance == 0 or distance == " " then
            return "自己"
        else
            return distance .. "m"
        end
end

function round(num, dp)
    local mult = 10^(dp or 0)
    return math.floor(num * mult + 0.5) / mult
end

--dont ask please--
function formatMoney(money)
    if money >= 1000 and money < 999950 then
        return round(money / 1000, 1) .. "K"
    elseif money >= 999950 and money < 999999950 then
        return round(money / 1000000, 1) .. "M"
    elseif money >= 999999950 then
        return round(money / 1000000000, 1) .. "B"
    else return money
    end
end

function draw_info_text(text, infotext, posX, posY, distance, size1, size2, bool, extracolor) --with the help of chatgpt i made it a little bit better
    local draw_text = directx.draw_text(posX, posY, text, ALIGN_TOP_LEFT, size1, colors.label, true)

    local first_text_width, first_text_height = directx.get_text_size(text, size1)
    
    local posX2, alignment
    local posY2 = posY + (first_text_height/1.9)
    if bool then
        posX2 = posX - (-distance/1000)
        alignment = ALIGN_CENTRE_RIGHT
    else
        posX2 = posX + first_text_width + (distance/1000)
        alignment = ALIGN_CENTRE_LEFT
    end
    
    local draw_infotext = directx.draw_text(posX2, posY2, infotext, alignment, size2, extracolor or colors.highlight, true)
    
    return draw_text, draw_infotext
end

function get_prostitutes_solicited(pid)
    return memory.read_int(memory.script_global(1853910 + 1 + (pid * 862) + 205 + 54))
end

function green_or_red(yes_no)
    if bool_change then
        return colors.highlight
    else
        if yes_no == "是" then
            return colors.yes_color
        else
            return colors.no_color
        end
    end
end

function money_color(money)
    if money_change then
        return colors.highlight
    else
        if money >= 0 and money < 10000 then
            return colors.no_color
        elseif money >= 10000 and money < 100000 then
            return colors.orange
        elseif money >= 100000 and money < 10000000000 then
            return colors.yes_color
        end
    end
end


--DRAWING/GETTING INFO--
------------------------
util.create_tick_handler(function()
    if not util.is_session_transition_active() then
        local focusedplayer = players.get_focused()
        if focusedplayer[1] ~= nil and menu.is_open() or (color_show_list or value_show_list or color_show_topbar or color_show_back or color_show_sub or color_show_label or color_show_high or color_show_map or color_show_blip or change_bool_show or change_money_show or change_unit_show or posXslider_show or posYslider_show or blipsizeslider_show or show_map_show or yourblip_show) then

            if (color_show_list or value_show_list or color_show_topbar or color_show_back or color_show_sub or color_show_label or color_show_high or color_show_map or color_show_blip or change_bool_show or change_money_show or change_unit_show or posXslider_show or posYslider_show or blipsizeslider_show or show_map_show or yourblip_show) then
                focusedplayer = players.user()
            else
                focusedplayer = focusedplayer[1]
            end

                local focusedped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(focusedplayer)
                local mypos, playerpos = players.get_position(players.user()), players.get_position(focusedplayer)
                local weapon_hash = WEAPON.GET_SELECTED_PED_WEAPON(focusedped)

                local speed = ENTITY.GET_ENTITY_SPEED(focusedped) --this hole speed thing is taken from my speedometer script
                local mph = speed * 2.236936
		        local kph = speed * 3.6
		        local value = " 英里/时"

		    if mesh == 1 then 
			    measured_speed = mph 
			else
			    measured_speed = kph
			    value = " 公里/时"
			end

                local name = players.get_name(focusedplayer)
                local RID = players.get_rockstar_id(focusedplayer)
                local IP = dec_to_ipv4(players.get_connect_ip(focusedplayer))
                local rank = check(players.get_rank(focusedplayer))
                local totalmoney = formatMoney(players.get_money(focusedplayer))
                local walletmoney = formatMoney(players.get_wallet(focusedplayer))
                local bankmoney = formatMoney(players.get_bank(focusedplayer))
                local kd = round(players.get_kd(focusedplayer), 2)
                local lang = languages[players.get_language(focusedplayer)]
                local controller = bool(players.is_using_controller(focusedplayer))
                local tags =  check(players.get_tags_string(focusedplayer))
                local godmode = bool(players.is_godmode(focusedplayer))
                local mod_or_ad = bool(players.is_marked_as_modder_or_admin(focusedplayer))
                local atk_you = bool(players.is_marked_as_attacker(focusedplayer))
                local otr = bool(players.is_otr(focusedplayer)) 
                local host_queue = queuecheck(players.get_host_queue_position(focusedplayer))
                local org_type = org(players.get_org_type(focusedplayer))
                local distance = distance(mypos, playerpos)
                local vehicle_name = check(util.get_label_text(players.get_vehicle_model(focusedplayer)))
                local cal_speed = math.ceil(measured_speed)
                local wanted_lvl, max_wanted_lvl = PLAYER.GET_PLAYER_WANTED_LEVEL(focusedplayer), PLAYER.GET_MAX_WANTED_LEVEL(focusedplayer)
                local health, maxhealth = ENTITY.GET_ENTITY_HEALTH(focusedped), ENTITY.GET_ENTITY_MAX_HEALTH(focusedped)
                local armor, maxarmor = PED.GET_PED_ARMOUR(focusedped), PLAYER.GET_PLAYER_MAX_ARMOUR(focusedplayer)
                local weapon =  get_weapon_name_from_hash(weapon_hash)
                local host = bool(focusedplayer == players.get_host())
                local script_host = bool(focusedplayer == players.get_script_host())
                local hookers = formatMoney(get_prostitutes_solicited(focusedplayer))
                     
            --topbar--
		    directx.draw_texture(topborder, 0.12, 0.12, 0.5, 0.5, topbarposX, topbarposY, 0.0, colors.topbar)
            --background--
            directx.draw_texture(mainback, 0.12, 0.12, 0.5, 0.5, backgroundposX, backgroundposY, 0.0, colors.background)
        -------
        --MAP--
        -------
        if map_show then
            --mapborder--
            directx.draw_texture(mapborder, 0.12, 0.12, 0.5, 0.5, mapborderposX, mapborderposY, 0.0, colors.topbar)
            --mapbackground--
            directx.draw_texture(mapback, 0.12, 0.12, 0.5, 0.5, mapbackgroundposX, mapbackgroundposY, 0.0, colors.background)

            --im not happy about this code tbh to many fucked up numbers for me and i just copied this shit from InfOverlay from lev maybe if u read this i havnt changed it since its been added but if u dont then its better :D
            --map--
            local mapsizeX, mapsizeY = 0.14416506, 0.3864867
            directx.draw_texture(map, mapsizeX/2, mapsizeY, 0.5, 0.5, mapposX, mapposY, 0.0, colors.map)

            --blip--
            local blip_posX = blipposX + 0.0161603566 + ((playerpos.x + 3745)/8316) * mapsizeX
            local blip_posY = blipposY + (1 - (playerpos.y + 4427)/12689) * mapsizeY
            local heading = ENTITY.GET_ENTITY_HEADING(focusedped)
            --playerblip--
            local playerblip_posX = blipposX + 0.0161603566 + ((mypos.x + 3745)/8316) * mapsizeX
            local playerblip_posY = blipposY + (1 - (mypos.y + 4427)/12689) * mapsizeY
            if blip_posX <= mapposX+0.07948270113 and blip_posX >= mapposX-0.072813007 and blip_posY >= mapposY-0.20722706 and blip_posY <= mapposY+0.21976627 then
                    directx.draw_texture(blip, blipsize, blipsize, 0.5, 0.5, blip_posX, blip_posY, (360 - heading)/360, colors.blip)
                if selfblip then
                    if distance ~= "自己" then
                        directx.draw_texture(Playerblip, blipsize, blipsize, 0.5, 0.5, playerblip_posX, playerblip_posY, 0, colors.blip)
                    end
                end
            end
            --healthbar--
            directx.draw_rect(health_barX, barY, 0.07, 0.015, colors.health_bar)
            local second_health_bar_color = {r = colors.health_bar.r, g = colors.health_bar.g, b = colors.health_bar.b, a = colors.health_bar.a/2}
            directx.draw_rect(health_barX, barY, (health / maxhealth) * (0.31 - 0.24), 0.015, second_health_bar_color) --i fr got the formula from chatgpt xD
            directx.draw_text(health_bartxtX, bar_txtY, health .. "/" .. maxhealth, ALIGN_CENTRE, 0.42, colors.health_bar_text, true)
            --armorbar--
            local second_armor_bar_color = {r = colors.armour_bar.r, g = colors.armour_bar.g, b = colors.armour_bar.b, a = colors.armour_bar.a/2}
            directx.draw_rect(armor_barX, barY, 0.07, 0.015, colors.armour_bar)
            directx.draw_rect(armor_barX, barY, (armor / maxarmor) * (0.385 - 0.315), 0.015, second_armor_bar_color)
            directx.draw_text(armor_bartxtX, bar_txtY, armor .. "/" .. maxarmor, ALIGN_CENTRE, 0.42, colors.armor_bar_text, true)
        end
            --name--
            directx.draw_text(nameposX, nameposY, name, ALIGN_CENTRE, 0.45, colors.subhead, true)

            local size1 = 0.45
            local size2 = 0.44
            --PLAYER--
            directx.draw_text(PLAYERposX, PLAYERposY, "玩家信息", ALIGN_CENTRE, 0.5, colors.subhead, true)
            --RID--
            draw_info_text("RID:", RID, PLAYERS_textposX, PLAYERS_textposY, 2, size1, size2, false)
            --IP--
            draw_info_text("IP:", IP, PLAYERS_textposX, PLAYERS_textposY + 0.02, 2, size1, size2, false)
            --rank--
            draw_info_text("等级:", rank, PLAYERS_textposX, PLAYERS_textposY + 0.04, 2, size1, size2, false)
            --kd--
            draw_info_text("K/D:", kd, PLAYERS_textposX, PLAYERS_textposY + 0.06, 2, size1, size2, false)
            --lang--
            draw_info_text("语言:", lang, PLAYERS_textposX, PLAYERS_textposY + 0.08, 2, size1, size2, false)
            --controller--
            draw_info_text("手柄:", controller, PLAYERS_textposX, PLAYERS_textposY + 0.1, 2, size1, size2, false, green_or_red(controller))
            --host--
            draw_info_text("主机:", host, PLAYERS_textposX, PLAYERS_textposY + 0.12, 2, size1, size2, false, green_or_red(host))
            --script host--
            draw_info_text("脚本主机:", script_host, PLAYERS_textposX, PLAYERS_textposY + 0.14, 2, size1, size2, false, green_or_red(script_host))
            --host queue--
            draw_info_text("主机令牌:", host_queue, PLAYERS_textposX, PLAYERS_textposY + 0.16, 2, size1, size2, false)

            --CHARACTER--
            directx.draw_text(CHARACTERposX, CHARACTERposY, "角色信息", ALIGN_CENTRE, 0.5, colors.subhead, true)
            --org--
            draw_info_text("组织:", org_type, CHARACTER_textposX, CHARACTER_textposY, 2, size1, size2, false)
            --distance--
            draw_info_text("距离:", distance, CHARACTER_textposX, CHARACTER_textposY + 0.02, 2, size1, size2, false)
            --speed--
            draw_info_text("速度:", cal_speed .. value, CHARACTER_textposX, CHARACTER_textposY + 0.04, 2, size1, size2, false)
            --health--
            draw_info_text("血量:", health .. "/" .. maxhealth, CHARACTER_textposX, CHARACTER_textposY + 0.06, 2, size1, size2, false)
            --armor--
            draw_info_text("护甲:", armor .. "/" .. maxarmor, CHARACTER_textposX, CHARACTER_textposY + 0.08, 2, size1, size2, false)
            --gm--
            draw_info_text("无敌:", godmode, CHARACTER_textposX, CHARACTER_textposY + 0.1, 2, size1, size2, false, green_or_red(godmode))
            --otr--
            draw_info_text("雷达匿踪:", otr, CHARACTER_textposX, CHARACTER_textposY + 0.12, 2, size1, size2, false, green_or_red(otr))
            --vehicle--
            draw_info_text("载具:", vehicle_name, CHARACTER_textposX, CHARACTER_textposY + 0.14, 2, size1, size2, false)
            --weapon--
            draw_info_text("武器:", weapon, CHARACTER_textposX, CHARACTER_textposY + 0.16, 2, size1, size2, false)

            --GENERAL--
            directx.draw_text(GENERALposX, GENERALposY, "基本信息", ALIGN_CENTRE, 0.5, colors.subhead, true)
            --wanted lvl--
            draw_info_text("通缉:", wanted_lvl .. "/" .. "5星", GENERAL_textposX, GENERAL_textposY, 205, size1, size2, true)
            --atk you--
            draw_info_text("攻击你:", atk_you, GENERAL_textposX, GENERAL_textposY + 0.02, 205, size1, size2, true, green_or_red(atk_you))
            --mod or admin--
            draw_info_text("作弊者/管理员:", mod_or_ad, GENERAL_textposX, GENERAL_textposY + 0.04, 205, size1, size2, true, green_or_red(mod_or_ad))
            --total money--
            draw_info_text("总钱数:", "$" .. totalmoney, GENERAL_textposX, GENERAL_textposY + 0.06, 205, size1, size2, true, money_color(players.get_money(focusedplayer)))
            --walled money--
            draw_info_text("现金:", "$" .. walletmoney, GENERAL_textposX, GENERAL_textposY + 0.08, 205, size1, size2, true, money_color(players.get_wallet(focusedplayer)))
            --bank money--
            draw_info_text("银行:", "$" .. bankmoney, GENERAL_textposX, GENERAL_textposY + 0.1, 205, size1, size2, true, money_color(players.get_bank(focusedplayer)))
            --hookers--
            draw_info_text("拥有妓女:", hookers, GENERAL_textposX, GENERAL_textposY + 0.12, 205, size1, size2, true)
            --tags--
            draw_info_text("标签:", tags, tagsposX, tagsposY, 205, size1, size2, true)
        end
    end
end)

