--mian
menu.toggle(player_information, "启用", {}, "个人玩家信息显示", function(state)
    UItoggle = state
end)

--folders
txt = menu.list(player_information, "文本颜色", {}, "", function()
	customisation_open = true
end, function()
	customisation_open = false
end)
background = menu.list(player_information, "背景颜色", {}, "", function()
	customisation_open = true
end, function()
	customisation_open = false
end)
border = menu.list(player_information, "边框颜色", {}, "", function()
	customisation_open = true
end, function()
	customisation_open = false
end)
position_folder = menu.list(player_information, "位置", {}, "", function()
	customisation_open = true
end, function()
	customisation_open = false
end)

--locals
local txtr = 0 --default red of text colour
local txtg = 1 --default green of text colour
local txtb = 0 --default blue of text colour
local backgroundr = 255 --default red of background colour
local backgroundg = 255 --default green of background colour
local backgroundb = 255 --default blue of background colour
local borderr = 255 --default red of border colour
local borderg = 1 --default green of border colour
local borderb = 0 --default blue of border colour

--text RGB
menu.slider(txt, "红", {"borderr"}, "", 0, 255, 1, 1, function(txtcr)
	txtr = txtcr
end)
menu.slider(txt, "绿", {"borderg"}, "", 0, 255, 1, 1, function(txtcg)
	txtg = txtcg
end)
menu.slider(txt, "蓝", {"borderb"}, "", 0, 255, 1, 1, function(txtcb)
	txtb = txtcb
end)

--background RGB
menu.slider(background, "红", {"backgroundrr"}, "", 0, 255, 0, 1, function(backgroundcr)
	backgroundr = backgroundcr
end)
menu.slider(background, "绿", {"backgroundg"}, "", 0, 255, 0, 1, function(backgroundcg)
	backgroundg = backgroundcg
end)
menu.slider(background, "蓝", {"backgroundb"}, "", 0, 255, 0, 1, function(backgroundcb)
	backgroundb = backgroundcb
end)

--border RGB
menu.slider(border, "红", {"borderr"}, "", 0, 255, 255, 1, function(bordercr)
	borderr = bordercr
end)
menu.slider(border, "绿", {"borderg"}, "", 0, 255, 0, 1, function(bordercg)
	borderg = bordercg
end)
menu.slider(border, "蓝", {"borderb"}, "", 0, 255, 255, 1, function(bordercb)
	borderb = bordercb
end)

--show the current rgb values
menu.action(player_information, "显示当前颜色值", {}, "", function()
	util.toast("当前颜色值\n文本: "..txtr..", "..txtg..", "..txtb.."\n背景: "..backgroundr..", "..backgroundg..", "..backgroundb.."\n边框: "..borderr..", "..borderg..", "..borderb)
end)

--functions
local function draw_text(text_x, text_y, content, color)
    directx.draw_text(
    text_x,
    text_y,
    content,
    ALIGN_TOP_LEFT,
    0.4,
    color,
    false
    )
end
local function draw_rect(rect_x, rect_y, rect_w, rect_h, color)
    directx.draw_rect(
        rect_x,
        rect_y,
        rect_w,
        rect_h,
        color
        )
end
local function draw_line(line_x_1, line_y_1, line_x_2, line_y_2, color)
    directx.draw_line(
        line_x_1, 
        line_y_1, 
        line_x_2, 
        line_y_2, 
        color
        )
end
local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end
local function text_width_func(text)
    local text_og_width = directx.get_text_size(text, 0.4)
    local text_width = round(text_og_width, 3)
    return text_width
end
--from lance, ty
all_weapons = {}
temp_weapons = util.get_weapons()
for a,b in pairs(temp_weapons) do
    all_weapons[#all_weapons + 1] = {hash = b['hash'], label_key = b['label_key']}
end
function get_weapon_name_from_hash(hash) 
    for k,v in pairs(all_weapons) do 
        if v.hash == hash then 
            return util.get_label_text(v.label_key)
        end
    end
    return '空拳'
end
local function dec_to_ipv4(ip)
	return string.format(
		"%i.%i.%i.%i", 
		ip >> 24 & 0xFF, 
		ip >> 16 & 0xFF, 
		ip >> 8  & 0xFF, 
		ip 		 & 0xFF
	)
end
local function bool_to_yes_no(bool)
    if bool then 
        return "是"
    else
        return "不是"
    end
end
local function format_int(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
    int = int:reverse():gsub("(%d%d%d)", "%1,")
    return minus .. int:reverse():gsub("^,", "") .. fraction
end
--function from jay, ty
local function isFriend(PlayerId)
    return table.contains(players.list(false,true,false), PlayerId)
end
--these few functions are from nowiry, ty
read_global = {
	byte = function(global)
		local address = memory.script_global(global)
		return address ~= NULL and memory.read_byte(address) or nil
	end,
	int = function(global)
		local address = memory.script_global(global)
		return address ~= NULL and memory.read_int(address) or nil
	end,
	float = function(global)
		local address = memory.script_global(global)
		return address ~= NULL and memory.read_float(address) or nil
	end,
	string = function(global)
		local address = memory.script_global(global)
		return address ~= NULL and memory.read_string(address) or nil
	end
}
local function BitTest(bits, place)
	return (bits & (1 << place)) ~= 0
end
local function IsPlayerUsingOrbitalCannon(player)
    if player ~= -1 then
        local bits = read_global.int(2689235 + (player * 453 + 1) + 416)
        return BitTest(bits, 0)
    end
    return false
end
local function IsPlayerFlyingAnyDrone(player)
	local address = memory.script_global(1853348 + (player * 834 + 1) + 267 + 348)
	return BitTest(memory.read_int(address), 26)
end
local function IsPlayerInRcBandito(player)
    if player ~= -1 then
        local address = memory.script_global(1853348 + (player * 834 + 1) + 267 + 348)
        return BitTest(memory.read_int(address), 29)
    end
    return false
end
local function IsPlayerInRcTank(player)
    if player ~= -1 then
        local address = memory.script_global(1853348 + (player * 834 + 1) + 267 + 408 + 2)
        return BitTest(memory.read_int(address), 16)
    end
    return false
end
local function IsPlayerInRcPersonalVehicle(player)
    if player ~= -1 then
        local address = memory.script_global(1853348 + (player * 834 + 1) + 267 + 408 + 3)
        return BitTest(memory.read_int(address), 6)
    end
    return false
end

--locals
local overlay_x = 0.01
local overlay_y = 0.01

--ty lance for languages :)
local languages = {
    [0] = "英语",
    [1] = "法语",
    [2] = "德语",
    [3] = "意大利语",
    [4] = "西班牙语",
    [5] = "巴西语",
    [6] = "波兰语",
    [7] = "俄语",
    [8] = "韩语",
    [9] = "中文(繁)",
    [10] = "日语",
    [11] = "墨西哥语",
    [12] = "中文(简)"
}

--set location
menu.slider_float(position_folder, "位置 X", {"playerinfox"}, "", -1000, 1000, 0, 1, function(s)
    overlay_x = s * 0.001
end)
menu.slider_float(position_folder, "位置 Y", {"playerinfoy"}, "", -1000, 1000, 0, 1, function(s)
    overlay_y = s * 0.001
end)


local function draw_window(customisation)
    if not util.is_session_transition_active() and NETWORK.NETWORK_IS_SESSION_STARTED() then
        if customisation == 0 then
            focused_tbl = players.get_focused()
            focused = focused_tbl[1]
        elseif customisation == 1 then
            focused = players.user()
        end
        if focused ~= nil and menu.is_open() then 
            --settings colours
            local txtcolor = {r = txtr, g = txtg, b = txtb, a = 1.0}
            local backgroundcolor = {r = backgroundr, g = backgroundg, b = backgroundb, a = 1.0}
            local bordercolor = {r = borderr, g = borderg, b = borderb, a = 1.0}

            --grabbing information on player
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(focused)
            local mypos = players.get_position(players.user())
            local mypid = players.user()
            local playerpos = players.get_position(focused)
            local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
            local script_host = players.get_script_host()
            local host = players.get_host()
            local text_width = 0
            local name = players.get_name(focused)
            local pid = focused
            local h = bool_to_yes_no(focused == host)
            local sh = bool_to_yes_no(focused == script_host)
            local rank = players.get_rank(focused)
            local rid1 = players.get_rockstar_id(focused)
            local rid2 = players.get_rockstar_id_2(focused)
            local rid = if rid1 == rid2 then rid1 else rid1.."/"..rid2
            local modder = bool_to_yes_no(players.is_marked_as_modder(focused))
            local godmode = bool_to_yes_no(players.is_godmode(focused))
            local friend = bool_to_yes_no(isFriend(focused))
            local language = languages[players.get_language(focused)]
            local health = tostring(ENTITY.GET_ENTITY_HEALTH(ped)).."/"..tostring(ENTITY.GET_ENTITY_MAX_HEALTH(ped))
            local armor = tostring(PED.GET_PED_ARMOUR(ped)).."/"..tostring(PLAYER.GET_PLAYER_MAX_ARMOUR(focused))
            local wanted = PLAYER.GET_PLAYER_WANTED_LEVEL(focused)
            local vehicle = players.get_vehicle_model(focused)
            if vehicle == 0 then 
                vehicle_name = "N/A"
                in_vehicle = "不是"
            else
                vehicle_name = util.get_label_text(VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(vehicle))
                in_vehicle = "是"
            end
            local vehicle = vehicle_name
            local interior = bool_to_yes_no(players.is_in_interior(focused))
            local distance = math.ceil(MISC.GET_DISTANCE_BETWEEN_COORDS(playerpos.x, playerpos.y, playerpos.z, mypos.x, mypos.y, mypos.z))
            local position = "X: "..math.floor(playerpos.x).." |  Y: "..math.floor(playerpos.y).." |  Z: "..math.floor(playerpos.z)
            local token = players.get_host_token(focused)
            local ip = dec_to_ipv4(players.get_connect_ip(focused))
            local wallet = "$"..format_int(players.get_wallet(focused))
            local bank = "$"..format_int(players.get_bank(focused))
            local total = "$"..format_int(players.get_money(focused))
            local weapon_hash = WEAPON.GET_SELECTED_PED_WEAPON(ped)
            local weapon = get_weapon_name_from_hash(weapon_hash)
            local tags = players.get_tags_string(focused)
            if tags == "" then
                tags = "N/A"
            end
            if focused == host and focused == mypid then
                ping = "自己/主机"
            elseif focused == host then
                ping = "主机"
            elseif focused == mypid then
                ping = "自己"
            else
                latency = NETWORKdaidai.NETWORK_GET_AVERAGE_LATENCY(focused)
                ping = math.floor(latency+0.5).."ms"
            end
            if NETWORK.NETWORK_IS_PLAYER_ACTIVE(pid) then
                state = "已连接战局"
            else
                state = "正在连接战局"
            end
            local aiming = bool_to_yes_no(PLAYER.IS_PLAYER_FREE_AIMING(focused))
            local orbital = bool_to_yes_no(IsPlayerUsingOrbitalCannon(focused))
            local rc_drone = bool_to_yes_no(IsPlayerFlyingAnyDrone(focused))
            local rc_bandito = bool_to_yes_no(IsPlayerInRcBandito(focused))
            local rc_tank = bool_to_yes_no(IsPlayerInRcTank(focused))
            local rc_personal = bool_to_yes_no(IsPlayerInRcPersonalVehicle(focused))
            local attacker = bool_to_yes_no(players.is_marked_as_attacker(focused))
            local kd = round(players.get_kd(focused), 2)

            --setting dimensions of the main gui
            local guix = overlay_x
            local guiy = overlay_y
            local guiw = 0.15
            local guih = -0.02
            for i = 1, 22 do
                guih = guih + 0.02
            end

            --setting coords of overlay
            local playerlistx, playerlisty = guix + 0.002, guiy + 0.002 --setting info list coords

            --drawing gui
            border = draw_rect(guix - 0.0012, guiy - 0.022, guiw + 0.0024, guih + 0.024, bordercolor)
            titles = draw_rect(guix, guiy - 0.02, guiw, 0.02, backgroundcolor)
            background = draw_rect(guix, guiy, guiw, guih, backgroundcolor)
            divider1 = draw_line(playerlistx + guiw/2 - 0.002, playerlisty, playerlistx + guiw/2 - 0.002, playerlisty + 0.02*7, bordercolor)
            divider2 = draw_line(playerlistx + guiw/2 - 0.002, playerlisty + guih - 0.02*7, playerlistx + guiw/2 - 0.002, playerlisty + guih, bordercolor)

            --name
            local yoffset = 0.02
            local text_width = text_width_func(name)
            draw_text(playerlistx + guiw/2 - text_width/2, playerlisty - yoffset, name, txtcolor)

            --pid
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(pid)
            draw_text(playerlistx, playerlisty - yoffset, "PID: ", txtcolor)
            draw_text(playerlistx + guiw/2 - text_width - 0.005, playerlisty - yoffset, pid, txtcolor)

            --rid
            local text_width = text_width_func(rid)
            draw_text(playerlistx + guiw/2, playerlisty - yoffset, "RID: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, rid, txtcolor)

            --rank
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(rank)
            draw_text(playerlistx, playerlisty - yoffset, "等级: ", txtcolor)
            draw_text(playerlistx + guiw/2 - text_width - 0.005, playerlisty - yoffset, rank, txtcolor)

            --wanted level
            local text_width = text_width_func(wanted)
            draw_text(playerlistx + guiw/2, playerlisty - yoffset, "通缉等级: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, wanted, txtcolor)

            --ip
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(ip)
            draw_text(playerlistx, playerlisty - yoffset, "IP: ", txtcolor)
            draw_text(playerlistx + guiw/2 - text_width - 0.005, playerlisty - yoffset, ip, txtcolor)

            --ping
            local text_width = text_width_func(ping)
            draw_text(playerlistx + guiw/2, playerlisty - yoffset, "延迟: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, ping, txtcolor)

            --language
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(language)
            draw_text(playerlistx, playerlisty - yoffset, "语言: ", txtcolor)
            draw_text(playerlistx + guiw/2 - text_width - 0.005, playerlisty - yoffset, language, txtcolor)

            --distance
            local text_width = text_width_func(distance)
            draw_text(playerlistx + guiw/2, playerlisty - yoffset, "距离: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, distance, txtcolor)

            --health
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(health)
            draw_text(playerlistx, playerlisty - yoffset, "血量: ", txtcolor)
            draw_text(playerlistx + guiw/2 - text_width - 0.005, playerlisty - yoffset, health, txtcolor)

            --armor
            local text_width = text_width_func(armor)
            draw_text(playerlistx + guiw/2, playerlisty - yoffset, "护甲: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, armor, txtcolor)

            --wallet
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(wallet)
            draw_text(playerlistx, playerlisty - yoffset, "现金: ", txtcolor)
            draw_text(playerlistx + guiw/2 - text_width - 0.005, playerlisty - yoffset, wallet, txtcolor)

            --bank
            local text_width = text_width_func(bank)
            draw_text(playerlistx + guiw/2, playerlisty - yoffset, "银行: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, bank, txtcolor)

            --kd
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(kd)
            draw_text(playerlistx, playerlisty - yoffset, "KD: ", txtcolor)
            draw_text(playerlistx + guiw/2 - text_width - 0.005, playerlisty - yoffset, kd, txtcolor)

            --total money
            local text_width = text_width_func(total)
            draw_text(playerlistx + guiw/2, playerlisty - yoffset, "总额: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, total, txtcolor)

            --vehicle
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(vehicle)
            draw_text(playerlistx, playerlisty - yoffset, "载具: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, vehicle, txtcolor)

            -- --player tags
            -- local yoffset = yoffset + -0.02
            -- local text_width = text_width_func(tags)
            -- draw_text(playerlistx, playerlisty - yoffset, "Tags: ", txtcolor)
            -- draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, tags, txtcolor)
            
            --connection state
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(state)
            draw_text(playerlistx, playerlisty - yoffset, "连接状态: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, state, txtcolor)

            --host token
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(token)
            draw_text(playerlistx, playerlisty - yoffset, "主机令牌: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, token, txtcolor)

            --position
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(position)
            draw_text(playerlistx, playerlisty - yoffset, "位置: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, position, txtcolor)

            --current weapon
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(weapon)
            draw_text(playerlistx, playerlisty - yoffset, "当前武器: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, weapon, txtcolor)
            
            --checks
            local yoffset = yoffset + -0.04
            local text_width = text_width_func("检查")
            draw_text(playerlistx + guiw/2 - text_width/2, playerlisty - yoffset, "检查", txtcolor)

            --host
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(h)
            draw_text(playerlistx, playerlisty - yoffset, "是主机: ", txtcolor)
            draw_text(playerlistx + guiw/2 - text_width - 0.005, playerlisty - yoffset, h, txtcolor)

            --interior
            local text_width = text_width_func(interior)
            draw_text(playerlistx + guiw/2, playerlisty - yoffset, "在室内: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, interior, txtcolor)

            --script host
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(sh)
            draw_text(playerlistx, playerlisty - yoffset, "是脚本主机: ", txtcolor)
            draw_text(playerlistx + guiw/2 - text_width - 0.005, playerlisty - yoffset, sh, txtcolor)

            --in orbital
            local text_width = text_width_func(orbital)
            draw_text(playerlistx + guiw/2, playerlisty - yoffset, "在轨道炮房: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, orbital, txtcolor)

            --attacker
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(attacker)
            draw_text(playerlistx, playerlisty - yoffset, "是攻击者: ", txtcolor)
            draw_text(playerlistx + guiw/2 - text_width - 0.005, playerlisty - yoffset, attacker, txtcolor)

            --in vehicle
            local text_width = text_width_func(in_vehicle)
            draw_text(playerlistx + guiw/2, playerlisty - yoffset, "在车内: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, in_vehicle, txtcolor)

            --friend
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(friend)
            draw_text(playerlistx, playerlisty - yoffset, "是朋友: ", txtcolor)
            draw_text(playerlistx + guiw/2 - text_width - 0.005, playerlisty - yoffset, friend, txtcolor)

            --rc drone
            local text_width = text_width_func(rc_drone)
            draw_text(playerlistx + guiw/2, playerlisty - yoffset, "在RC无人机: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, rc_drone, txtcolor)

            --godmode
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(godmode)
            draw_text(playerlistx, playerlisty - yoffset, "是无敌: ", txtcolor)
            draw_text(playerlistx + guiw/2 - text_width - 0.005, playerlisty - yoffset, godmode, txtcolor)

            --rc bandito
            local text_width = text_width_func(rc_bandito)
            draw_text(playerlistx + guiw/2, playerlisty - yoffset, "在RC匪徒: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, rc_bandito, txtcolor)

            --modder
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(modder)
            draw_text(playerlistx, playerlisty - yoffset, "是作弊者: ", txtcolor)
            draw_text(playerlistx + guiw/2 - text_width - 0.005, playerlisty - yoffset, modder, txtcolor)

            --rc tank
            local text_width = text_width_func(rc_tank)
            draw_text(playerlistx + guiw/2, playerlisty - yoffset, "是RC坦克: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, rc_tank, txtcolor)

            --aiming
            local yoffset = yoffset + -0.02
            local text_width = text_width_func(aiming)
            draw_text(playerlistx, playerlisty - yoffset, "在瞄准: ", txtcolor)
            draw_text(playerlistx + guiw/2 - text_width - 0.005, playerlisty - yoffset, aiming, txtcolor)

            --rc personal
            local text_width = text_width_func(rc_personal)
            draw_text(playerlistx + guiw/2, playerlisty - yoffset, "在RC个人载具: ", txtcolor)
            draw_text(playerlistx + guiw - text_width - 0.005, playerlisty - yoffset, rc_personal, txtcolor)

            util.remove_handler(player_vehicle) --stop possible crash from too many handles
        end
    end
end

util.create_tick_handler(function()
    while UItoggle do
        draw_window(0)
        util.yield()
    end
end)
util.create_tick_handler(function()
    while customisation_open do
        draw_window(1)
        util.yield()
    end
end)

util.keep_running() 
