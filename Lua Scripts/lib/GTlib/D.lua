function Newkanmen()
kanmengoumzx=GTTG(watch_dog, '', {""}, '', function (on)
if on then
GTluaScript.trigger_commands("lasersights on")
else
GTluaScript.trigger_commands("lasersights off")
end
end)
local ent_a = memory.alloc_int()
kmgyuan = GTLP(watch_dog, '', {""}, '', function (kai)
    PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), ent_a)
    if memory.read_int(ent_a) ~= 0 then 
        local ent = memory.read_int(ent_a)
        if ENTITY.GET_ENTITY_TYPE(ent) == 1 and PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(players.user(), ent) then
            if PED.GET_PED_CONFIG_FLAG(players.user_ped(), 78, true) then  
                local boxSize = v3.new(0.8, 0.8, 1.7) 
                local boxColor = {r = 0, g = 200, b = 255, a = 150}
                
                local pedCoords = ENTITY.GET_ENTITY_COORDS(ent)
                
                local minBounds = v3.new(pedCoords.x - boxSize.x / 2, pedCoords.y - boxSize.y / 2, pedCoords.z - boxSize.z / 1.7)
                local maxBounds = v3.new(pedCoords.x + boxSize.x / 2, pedCoords.y + boxSize.y / 2, pedCoords.z + boxSize.z / 1.7)
                
                GRAPHICS.DRAW_BOX(minBounds.x, minBounds.y, minBounds.z, maxBounds.x, maxBounds.y, maxBounds.z, boxColor.r, boxColor.g, boxColor.b, boxColor.a)
            end
        end
    end
end)
kanmengouzaiju=watch_dog:toggle("", {},"", function(gzj)
kmgzj = gzj
while kmgzj do
    wait(0)
    PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), ent_a)
    if memory.read_int(ent_a) ~= 0 then 
        local ent = memory.read_int(ent_a)
        if ENTITY.GET_ENTITY_TYPE(ent) == 1 and PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(players.user(), ent) then
            if PED.GET_PED_CONFIG_FLAG(players.user_ped(), 78, true) then  
                local boxSize = v3.new(0.8, 0.8, 1.7) 
                local boxColor = {r = 0, g = 200, b = 255, a = 150}
                
                local pedCoords = ENTITY.GET_ENTITY_COORDS(ent)
                 GRAPHICS.DRAW_MARKER(2, pedCoords.x, pedCoords.y, pedCoords.z+1.5, 0, 0, 0, 0, 180, 0, 1, 1, 1, 0, 255, 255, 255, false, true, 2, true, 0, 0, false)
                 end
             end
        end
    end
kmgzj = false
end)
menu.set_visible(kanmengoumzx, false)
menu.set_visible(kmgyuan, false)
menu.set_visible(kanmengouzaiju, false)
kanmengou=GTTG(watch_dog, '看门狗[人物]', {''}, '', function(gou)
km = gou
    pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    while km do
        wait()
           if PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
              local controls_entity_aimed_at = ent_func.get_entity_player_is_aiming_at(players.user())
                  if ENTITY.IS_ENTITY_A_PED(controls_entity_aimed_at) and not PED.IS_PED_A_PLAYER(controls_entity_aimed_at) and not PED.IS_PED_IN_ANY_VEHICLE(controls_entity_aimed_at) then--NPC
                  menu.set_value(kanmengoumzx, true)
                  menu.set_value(kmgyuan, true)
                  HUD.SET_TEXT_SCALE(1.0,0.4) HUD.SET_TEXT_FONT(0)
                  HUD.SET_TEXT_CENTRE(1) HUD.SET_TEXT_OUTLINE(0)
                  HUD.SET_TEXT_COLOUR(60, 220, 255, 255)
                  util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("NPC :")
                  HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.8298,0)
                  HUD.SET_TEXT_SCALE(1.0,0.4) HUD.SET_TEXT_FONT(0)
                  HUD.SET_TEXT_CENTRE(1) HUD.SET_TEXT_OUTLINE(0)
                  HUD.SET_TEXT_COLOUR(60, 220, 255, 255)
                  util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("X - 删除  H - 传送到我 C - 传送到ta G - 爆炸  B - 复制哈希  K - 摔倒  E - 杀死  I - 旋转  J - 缩小  L - 冻结 R - 克隆")
                  HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.8798,0)
                  if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 323) then -- X 删除
                  entities.delete_by_handle(controls_entity_aimed_at)
                  elseif PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 304) then -- H 传送到我
                  ENTITY.SET_ENTITY_COORDS_NO_OFFSET(controls_entity_aimed_at, pos.x, pos.y, pos.z, false, false, false)
                  elseif PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 324) then -- C 传送到ta
				  requestControlLoop(controls_entity_aimed_at)
			 	  posnameobjectfunc = ENTITY.GET_ENTITY_COORDS(controls_entity_aimed_at)
				  ENTITY.SET_ENTITY_COORDS_NO_OFFSET(plyped(), posnameobjectfunc.x, posnameobjectfunc.y, posnameobjectfunc.z+2, false, false, false)
                  elseif util.is_key_down(0x47) then -- G 爆炸
                  FIRE.ADD_EXPLOSION(ENTITY.GET_ENTITY_COORDS(controls_entity_aimed_at).x,
                  ENTITY.GET_ENTITY_COORDS(controls_entity_aimed_at).y,
                  ENTITY.GET_ENTITY_COORDS(controls_entity_aimed_at).z-0.5, 0,1, true, false,0, true)
                  elseif PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 29) then -- B 复制哈希
                  util.copy_to_clipboard(util.joaat(controls_entity_aimed_at))
                  newnotify("~h~GRANDTOURINGVIP", "~r~&#8721;‹GT‹&#8721;", "~h~~b~已经复制"..util.joaat(controls_entity_aimed_at), "CHAR_CHOP", 6)
                  elseif PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 311) then -- K 摔倒
                  PED.SET_PED_TO_RAGDOLL(controls_entity_aimed_at, 2000, 2000, 0, true, true, true)
                  elseif util.is_key_down(0x45) then -- E 杀死
                  ENTITY.SET_ENTITY_HEALTH(controls_entity_aimed_at,0)
                  PED.SET_PED_MAX_HEALTH(controls_entity_aimed_at, 0)
                  elseif util.is_key_down(0x4A) then -- J 缩小
                  PED.SET_PED_CONFIG_FLAG(controls_entity_aimed_at, 223, true)
                  elseif util.is_key_down(0x4C) then -- L 冻结
                  ENTITY.FREEZE_ENTITY_POSITION(controls_entity_aimed_at, true)
                  elseif util.is_key_down(0x52) then -- R 克隆
                  PED.CLONE_PED(controls_entity_aimed_at, true, true, true)
                  elseif util.is_key_down(0x49) then -- I 旋转
                  util.create_thread(function()
                  while km do
                  wait()
                  ENTITY.APPLY_FORCE_TO_ENTITY(controls_entity_aimed_at, 5, 200.0000001, 8207.0, 89207.8207, 10.0, 10.0, 100.0, 10000.0, false, true)
                  end
                  end)
               end
           end
        end
    end
    km = false
    menu.set_value(kanmengoumzx, false)
    menu.set_value(kmgyuan, false)
end)
kanmengouchel=GTTG(watch_dog, '看门狗[车辆]', {''}, '', function(cgou)
cheliang = cgou
    pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    while cheliang do
        wait()
           if PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
              local controls_entity_aimed_at = ent_func.get_entity_player_is_aiming_at(players.user())
                  if ENTITY.IS_ENTITY_A_VEHICLE(controls_entity_aimed_at) and not PED.IS_PED_A_PLAYER(controls_entity_aimed_at) and not ENTITY.IS_ENTITY_A_PED(controls_entity_aimed_at) then--载具
                  menu.set_value(kanmengouzaiju, true)
                  HUD.SET_TEXT_SCALE(1.0,0.4) HUD.SET_TEXT_FONT(0)
                  HUD.SET_TEXT_CENTRE(1) HUD.SET_TEXT_OUTLINE(0)
                  HUD.SET_TEXT_COLOUR(255, 255, 0, 255)
                  util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("载具 :")
                  HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.8298,0)
                  HUD.SET_TEXT_SCALE(1.0,0.4) HUD.SET_TEXT_FONT(0)
                  HUD.SET_TEXT_CENTRE(1) HUD.SET_TEXT_OUTLINE(0)
                  HUD.SET_TEXT_COLOUR(255, 255, 0, 255)
                  util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("X - 删除  H - 传送到我  G - 爆炸  B - 复制哈希 I - 旋转 L - 冻结 E - 往前发射  C - 往后发射 K - 翻转 R - 进入 Z - 卸载")
                  HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.8798,0)
                  if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 323) then -- X 删除
                  entities.delete_by_handle(controls_entity_aimed_at)
                  elseif PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 304) then -- H 传送到我
                  ENTITY.SET_ENTITY_COORDS_NO_OFFSET(controls_entity_aimed_at, pos.x, pos.y, pos.z, false, false, false)
                  elseif util.is_key_down(0x47) then -- G 爆炸
                  FIRE.ADD_EXPLOSION(ENTITY.GET_ENTITY_COORDS(controls_entity_aimed_at).x,
                  ENTITY.GET_ENTITY_COORDS(controls_entity_aimed_at).y,
                  ENTITY.GET_ENTITY_COORDS(controls_entity_aimed_at).z-0.5, 0,1, true, false,0, true)
                  elseif PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 29) then -- B 复制哈希
                  util.copy_to_clipboard(util.joaat(controls_entity_aimed_at))
                  newnotify("~h~GRANDTOURINGVIP", "~r~&#8721;‹GT‹&#8721;", "~h~~b~已经复制"..util.joaat(controls_entity_aimed_at), "CHAR_CHOP", 6)
                  elseif util.is_key_down(0x4C) then -- L 冻结
                  ENTITY.FREEZE_ENTITY_POSITION(controls_entity_aimed_at, true)
                  elseif PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 311) then -- K 翻转
                  ENTITY.SET_ENTITY_ROTATION(controls_entity_aimed_at, 0, 180, 0, 1, true)
                  elseif util.is_key_down(0x45) then -- E 往前发射
                  local Speed = ENTITY.GET_ENTITY_SPEED(controls_entity_aimed_at)
                  ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(controls_entity_aimed_at, 1, 0, 2, (Speed / 10) + 5, 0, true, true, true)
                  VEHICLE.SET_VEHICLE_FORWARD_SPEED(controls_entity_aimed_at, 100000)
                  elseif PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 324) then -- C 往后发射
                  local Speed = ENTITY.GET_ENTITY_SPEED(controls_entity_aimed_at)
                  ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(controls_entity_aimed_at, 1, 0, 2, (Speed / 10) + 5, 0, true, true, true)
                  VEHICLE.SET_VEHICLE_FORWARD_SPEED(controls_entity_aimed_at, -100000)
                  elseif util.is_key_down(0x49) then -- I 旋转
                  util.create_thread(function()
                  while cheliang do
                  wait()
                  ENTITY.APPLY_FORCE_TO_ENTITY(controls_entity_aimed_at, 5, 200.0000001, 8207.0, 89207.8207, 10.0, 10.0, 100.0, 10000.0, false, true)
                  end
                  end)
                  elseif util.is_key_down(0x52) then -- R 进入
	              if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
	           	  local veh =  controls_entity_aimed_at
		          local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, true)
		          if PED.IS_PED_A_PLAYER(ped) then
		          else
		          entities.delete_by_handle(ped)
			      PED.SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
		          end
	              end
                  elseif util.is_key_down(0x5A) then -- Z 卸载
                  requestControlLoop(controls_entity_aimed_at)
                  local doors = VEHICLE.GET_NUMBER_OF_VEHICLE_DOORS(controls_entity_aimed_at)
                  VEHICLE.POP_OUT_VEHICLE_WINDSCREEN(controls_entity_aimed_at)
                  for i= 0, doors do
                  VEHICLE.SET_VEHICLE_DOOR_BROKEN(controls_entity_aimed_at, i, false)
                  entities.detach_wheel(controls_entity_aimed_at, 0)
                  entities.detach_wheel(controls_entity_aimed_at, 1)
                  entities.detach_wheel(controls_entity_aimed_at, 2)
                  entities.detach_wheel(controls_entity_aimed_at, 3)
                  end
               end
           end
        end
    end
    cheliang = false
    menu.set_value(kanmengouzaiju, false)
end)

kanmengouwanj=GTTG(watch_dog, '看门狗[玩家]', {''}, '', function(wgou)
wanjia = wgou
    pos = ENTITY.GET_ENTITY_COORDS(controls_entity_aimed_at)
    while wanjia do
        wait()
           if PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
              local controls_entity_aimed_at = ent_func.get_entity_player_is_aiming_at(players.user())
                  if PED.IS_PED_A_PLAYER(controls_entity_aimed_at) then--玩家
                  menu.set_value(kanmengoumzx, true)
                  menu.set_value(kmgyuan, true)
                  HUD.SET_TEXT_SCALE(1.0,0.4) HUD.SET_TEXT_FONT(0)
                  HUD.SET_TEXT_CENTRE(1) HUD.SET_TEXT_OUTLINE(0)
                  HUD.SET_TEXT_COLOUR(0, 255, 0, 255)
                  util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("玩家 :")
                  HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.8298,0)
                  HUD.SET_TEXT_SCALE(1.0,0.4) HUD.SET_TEXT_FONT(0)
                  HUD.SET_TEXT_CENTRE(1) HUD.SET_TEXT_OUTLINE(0)
                  HUD.SET_TEXT_COLOUR(0, 255, 0, 255)
                  util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("X - 爆炸  B - 崩溃  K - 踢出  E - 射击  L - 冻结 R - 克隆 C - 传送到ta")
                  HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.8798,0)
                  if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 323) then -- X 爆炸
                  FIRE.ADD_EXPLOSION(ENTITY.GET_ENTITY_COORDS(controls_entity_aimed_at).x,
                  ENTITY.GET_ENTITY_COORDS(controls_entity_aimed_at).y,
                  ENTITY.GET_ENTITY_COORDS(controls_entity_aimed_at).z-0.5, 0,1, true, false,0, true)
                  elseif PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 29) then -- B 崩溃
                  local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(controls_entity_aimed_at)
                  if players.get_host() == pid then 
                      return
                  end
                  menu.trigger_commands("crash" .. players.get_name(pid))
                  elseif PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 311) then -- K 踢出
                  local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(controls_entity_aimed_at)
                  if players.get_host() == pid then 
                      newnotify("~h~GRANDTOURINGVIP", "~r~&#8721;‹GT‹&#8721;","~r~您正试图踢出的玩家是主机", "CHAR_CHOP", 140)
                      return
                  end
                  menu.trigger_commands("kick" .. players.get_name(pid))
                  elseif util.is_key_down(0x45) then -- E 射击
                  MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 2, ENTITY.GET_ENTITY_COORDS(controls_entity_aimed_at).x, ENTITY.GET_ENTITY_COORDS(controls_entity_aimed_at).y, ENTITY.GET_ENTITY_COORDS(controls_entity_aimed_at).z, 0, true, util.joaat('vehicle_weapon_player_lazer'), players.user_ped(), true, true, 0)
                  elseif util.is_key_down(0x4C) then -- L 冻结
                  ENTITY.FREEZE_ENTITY_POSITION(controls_entity_aimed_at, true)
                  elseif util.is_key_down(0x52) then -- R 克隆
                  PED.CLONE_PED(controls_entity_aimed_at, true, true, true)
                  elseif PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 324) then -- C 传送到ta
				  requestControlLoop(controls_entity_aimed_at)
			 	  posnameobjectfunc = ENTITY.GET_ENTITY_COORDS(controls_entity_aimed_at)
				  ENTITY.SET_ENTITY_COORDS_NO_OFFSET(plyped(), posnameobjectfunc.x, posnameobjectfunc.y, posnameobjectfunc.z+2, false, false, false)
               end
           end
        end
    end
    wanjia = false
    menu.set_value(kanmengoumzx, false)
    menu.set_value(kmgyuan, false)
end)


menu.set_visible(kanmengou, false)
menu.set_visible(kanmengouchel, false)
menu.set_visible(kanmengouwanj, false)

kanmengounew=GTTG(watch_dog, '看门狗[New]', {''}, '', function(kaiqi)
kanmen = kaiqi
    pos = ENTITY.GET_ENTITY_COORDS(controls_entity_aimed_at)
    while kanmen do
        wait()
        menu.set_value(kanmengou, true)
        menu.set_value(kanmengouchel, true)
        menu.set_value(kanmengouwanj, true)
    end
    kanmen = false
    menu.set_value(kanmengou, false)
    menu.set_value(kanmengouchel, false)
    menu.set_value(kanmengouwanj, false)
end)
end

Newkanmen()