
-----攻击嘲讽作者
author = "\n--------¦daidai"
-----作者
F = "Author-呆呆"

------音乐
function music(on)
	if on then
        		menu.trigger_commands("ipod on")
        		AUDIO.SET_RADIO_TO_STATION_NAME("RADIO_19_USER")
----AUDIO.SET_RADIO_TO_STATION_NAME(AUDIO.GET_RADIO_STATION_NAME("16"))
        		menu.trigger_commands("closeradio off")
util.yield(500)
		menu.trigger_commands("lockradio on")
    	else
        		menu.trigger_commands("ipod off")
        		AUDIO.SET_RADIO_TO_STATION_NAME("OFF")
		menu.trigger_commands("lockradio off")
    	end
end

----爆炸圈
local explosion_circle_angle = 0
function explosion_circle(ped, angle, radius)
    local ped_coords = ENTITY.GET_ENTITY_COORDS(ped)

    local offset_x = ped_coords.x
    local offset_y = ped_coords.y

    local x = offset_x + radius * math.cos(angle)
    local y = offset_y + radius * math.sin(angle)

    FIRE.ADD_EXPLOSION(x, y, ped_coords.z, 4, 1, true, false, 0)
end

------------------------------------------------------------------------------------序列
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
---fps帧数
local fps = 0
util.create_thread(function()
    while true do
        fps = math.ceil(1/SYSTEM.TIMESTEP())
        util.yield(500)
    end
end)

local replayInterface = memory.read_long(memory.rip(memory.scan("48 8D 0D ? ? ? ? 48 8B D7 E8 ? ? ? ? 48 8D 0D ? ? ? ? 8A D8 E8 ? ? ? ? 84 DB 75 13 48 8D 0D") + 3))
local pedInterface = memory.read_long(replayInterface + 0x0018)
local vehInterface = memory.read_long(replayInterface + 0x0010)
local objectInterface = memory.read_long(replayInterface + 0x0028)
local pickupInterface = memory.read_long(replayInterface + 0x0020)

function zhujixvlie1()
inviciamountint = 0
            for pid = 0, 31 do
                if players.exists(pid) and pid ~= players.user() then
                    local pped = players.user_ped(pid)
                    if pped ~= 0 then
                        if players.is_marked_as_modder(pid) then --is_marked_as_modder
                            inviciamountint = inviciamountint + 1
                        end
                    end
                end
local ente
                    local ent1e = players.user_ped()
                    local ent2e = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
                    if PED.IS_PED_IN_ANY_VEHICLE(ent1e,true) then
                        ente = ent2e
                    else
                        ente = ent1e
                    end
                    local speede = ENTITY.GET_ENTITY_SPEED(ente)
                    local speedcalce = speede * 3.6
                    myspeed1e = math.ceil(speedcalce)
            end
                inviciamountintt = inviciamountint

	draw_string(string.format("~bold~~p~"..myspeed1e.." ~g~KM/H"), 0.175,0.770, 0.3,1)-----速度
	draw_string(string.format("~bold~~y~"..os.date("%X")), 0.175,0.800, 0.3,1)    -----------------时间
	---draw_string(string.format("~bold~FPS: ~b~"..fps), 0.175,0.800, 0.3,1)
	draw_string(string.format("~bold~战局人数: ~g~"..#players.list()), 0.175,0.830, 0.3,1) 
	draw_string(string.format("~bold~作弊人数: ~r~"..inviciamountintt), 0.175,0.860, 0.3,1)

    if PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**" then
        draw_string(string.format("~bold~战局主机: ~y~没有人", ALIGN_TOP_LEFT), 0.175,0.890, 0.3,1)
        else
            draw_string(string.format("~bold~战局主机: ~y~"..players.get_name(players.get_host())), 0.175,0.890, 0.3,1)
        end
    if PLAYER.GET_PLAYER_NAME(players.get_script_host()) == "**Invalid**" then
            draw_string(string.format("~bold~脚本主机: ~b~没有人", ALIGN_TOP_LEFT), 0.175,0.920, 0.3,1) 
        else
            draw_string(string.format("~bold~脚本主机: ~b~"..players.get_name(players.get_script_host())), 0.175,0.920, 0.3,1)
        end

        local hostxvlie = players.get_host_queue_position(players.user())
            if hostxvlie == 0 then
        draw_string(string.format("~bold~~o~你现在是战局主机"), 0.175,0.950, 0.3,1) 
            else
        draw_string(string.format("~bold~~q~你的主机优先度:~q~ "..hostxvlie), 0.175,0.950, 0.3,1) 
        end


        ------下位主机
        ------
end

----~italic~ 斜体
----~bold~ 加粗
----~?~ color

------------------------------------------------------------------------------------序列

--------------实体池信息
function entityinfo()
draw_string(string.format("~h~~f~实体池Info~"..memory.read_int(pedInterface ).."/"..memory.read_int(pedInterface)), 0,0, 0.32,1)
            draw_string(string.format("~h~PED: ~g~"..memory.read_int(pedInterface + 0x0110).."/"..memory.read_int(pedInterface + 0x0108)), 0,0.03, 0.3,1)
            draw_string(string.format("~h~载具: ~y~"..memory.read_int(vehInterface + 0x0190).."/"..memory.read_int(vehInterface + 0x0188)), 0,0.06, 0.3,1)
            draw_string(string.format("~h~实体: ~r~"..memory.read_int(objectInterface + 0x0168).."/"..memory.read_int(objectInterface + 0x0160)), 0,0.09, 0.3,1)
            draw_string(string.format("~h~拾取物: ~q~ "..memory.read_int(pickupInterface + 0x0110).."/"..memory.read_int(pickupInterface + 0x0108)), 0,0.12, 0.3,1)
end


---------------------------------------------------------------------------------------脚本昵称
function daidaijiaoben(state)
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
    draw_string(string.format("~italic~¦~bold~呆呆 Lua Script v6.7"), 0.38,0.1, 0.6,5)
    util.yield()
    end
end
---------------------------------------------------------------------------------------脚本昵称

