require "lib.baibailib.playerlib"
require "lib.baibailib.baibailib"
require "lib.baibailib.functions" 

local function rotatePoint(x, y, center, degrees)

    local radians = math.rad(degrees)

    local new_x = (x - center.x) * math.cos(radians) - (y - center.y) * math.sin(radians)
    local new_y = (x - center.x) * math.sin(radians) + (y - center.y) * math.cos(radians)

    return center.x + new_x, center.y + new_y * 1920 / 1080
end

function directx.draw_triangle_from_center_point(center, base, rotDegrees, colour)
    local halfHeight = (base * 0.866) / 2
    local halfBase = base / 2

    local tx, ty = rotatePoint(center.x, center.y - halfBase, center, rotDegrees)
    local lx, ly = rotatePoint(center.x - halfBase, center.y + halfHeight, center, rotDegrees)
    local rx, ry = rotatePoint(center.x + halfBase, center.y + halfHeight, center, rotDegrees)

    directx.draw_triangle(tx, ty --[[top]], lx, ly --[[left]], rx, ry --[[right]], colour)
end

function directx.draw_circle(center, diameter, colour)
    for i = 0, 260 do
        directx.draw_triangle_from_center_point(center, diameter, i, colour)
    end
end

function directx.draw_rect_with_rounded_corner(x, y, width, height, colour)
    directx.draw_circle({ x = x + width, y = y + height / 2 }, (height / 2.35), colour)
    directx.draw_rect(x, y, width, height, colour)
end


colors = {
    green = 184,
    red = 6,
    yellow = 190,
    black = 2,
    white = 1,
    gray = 3,
    pink = 201,
    purple = 49, 
    blue = 9
    }

function player_toggle_loop(root, pid, menu_name, command_names, help_text, callback)
    return menu.toggle_loop(root, menu_name, command_names, help_text, function()
        if not players.exists(pid) then util.stop_thread() end
    callback()
    end)
end

function gen_fren_funcs(name)
	local balls = menu.list(frendlist,name, {"friend "..name}, "", function(); end)
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


local function set_health_refill_limit_and_mult(limit, mult)
    PLAYER._SET_PLAYER_HEALTH_RECHARGE_LIMIT(PLAYER.PLAYER_ID(), limit)
    PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(PLAYER.PLAYER_ID(), mult)
end

local normal_refill_limit = 0.25
local normal_refill_mult = 1.0
local isCustomRefill_Normal
function standhealthon(toggle)
        isCustomRefill_Normal = toggle
        while isCustomRefill_Normal do
            set_health_refill_limit_and_mult(normal_refill_limit, normal_refill_mult)
            util.yield(300)
        end
        if not isCustomRefill_Normal then
            set_health_refill_limit_and_mult(0.25, 1.0)
        end
end

function standhpmode(value)
    normal_refill_limit = value * 0.01
end

function standhpmodetime(value)
    normal_refill_mult = value
end

local cover_refill_limit = 0.25
local cover_refill_mult = 1.0
local isCustomRefill_Cover
function hidehealthon(toggle)
    isCustomRefill_Cover = toggle
    
    while isCustomRefill_Cover do
        if PED.IS_PED_IN_COVER(PLAYER.PLAYER_PED_ID()) then
            set_health_refill_limit_and_mult(cover_refill_limit, cover_refill_mult)
        end
        util.yield(300)
    end

    if not isCustomRefill_Cover then
        set_health_refill_limit_and_mult(0.25, 1.0)
    end
end

function hidehpmode(value)
    cover_refill_limit = value * 0.01
end

function hidehpmodetime(value)
    cover_refill_mult = value
end

new = {}
function new.colour(R, G, B, A)
    return {r = R / 255, g = G / 255, b = B / 255, a = A or 1}
end
function new.hudSettings(X, Y, ALIGNMENT)
    return {xOffset = X, yOffset = Y, scale = 0.5, alignment = ALIGNMENT, textColour = new.colour( 255, 255, 255 )}
end
function new.delay(MS, S, MIN)
    return {ms = MS, s = S, min = MIN}
end

local fireWings = {
    [1] = {pos = {[1] = 120, [2] =  75}},
    [2] = {pos = {[1] = 120, [2] = -75}},
    [3] = {pos = {[1] = 135, [2] =  75}},
    [4] = {pos = {[1] = 135, [2] = -75}},
    [5] = {pos = {[1] = 180, [2] =  75}},
    [6] = {pos = {[1] = 180, [2] = -75}},
    [7] = {pos = {[1] = 195, [2] =  75}},
    [8] = {pos = {[1] = 195, [2] = -75}},
}

fireWingsSettings = {
    scale = 0.3,
    colour = mildOrangeFire,
    on = false
}
local ptfxEgg
function firewing(toggle)
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
end

function firewingscale(value)
    fireWingsSettings.scale = value / 10
end

function firewingcolour(colour)
    fireWingsSettings.colour = colour
end

local mildOrangeFire = new.colour( 255, 127, 80 )

fireBreathSettings = {
    scale = 0.3,
    colour = mildOrangeFire,
    on = false,
    y = { value = 0.12, still = 0.12, walk =  0.22, sprint = 0.32, sneak = 0.35 },
    z = { value = 0.58, still = 0.58, walk =  0.45, sprint = 0.38, sneak = 0.35 },
}

local function transitionValue(value, target, step)
    if value == target then return value end
    return value + step * ( value > target and -1 or 1 )
end

function fireBreathSettings:changePos(movementType)
    self.z.value = transitionValue(self.z.value, self.z[movementType], 0.01)
    self.y.value = transitionValue(self.y.value, self.y[movementType], 0.01)
end

levitationCommand = menu.ref_by_path('Self>Movement>Levitation>Levitation', 38)

function firebreathxxx(toggle)
    fireBreathSettings.on = toggle
    if toggle then
        while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do
            STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
            util.yield()
        end
        GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
        fireBreathSettings.ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE('muz_xs_turret_flamethrower_looping', players.user_ped(), 0, 0.12, 0.58, 30, 0, 0, 0x8b93, fireBreathSettings.scale, false, false, false)
        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireBreathSettings.ptfx, fireBreathSettings.colour.r, fireBreathSettings.colour.g, fireBreathSettings.colour.b)
    else
        GRAPHICS.REMOVE_PARTICLE_FX(fireBreathSettings.ptfx, true)
        fireBreathSettings.ptfx = nil
        STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
    end
    util.create_tick_handler(function()
        local user_ped = players.user_ped()
        if PED.GET_PED_PARACHUTE_STATE(user_ped) == 0 and ENTITY.IS_ENTITY_IN_AIR(user_ped) then
            GRAPHICS.SET_PARTICLE_FX_LOOPED_OFFSETS(fireBreathSettings.ptfx, 0, 0.81, 0, -10, 0, 0)
        elseif menu.get_value(levitationCommand) then
            GRAPHICS.SET_PARTICLE_FX_LOOPED_OFFSETS(fireBreathSettings.ptfx, 0, -0.12, 0.58, 150, 0, 0)
        else
            local movementType = 'still'
            if TASK.IS_PED_SPRINTING(user_ped) then
                movementType = 'sprint'
            elseif TASK.IS_PED_WALKING(user_ped) then
                movementType = 'walk'
            elseif PED.GET_PED_STEALTH_MOVEMENT(user_ped) then
                movementType = 'sneak'
            end

            fireBreathSettings:changePos(movementType)
            GRAPHICS.SET_PARTICLE_FX_LOOPED_OFFSETS(fireBreathSettings.ptfx, 0, fireBreathSettings.y.value, fireBreathSettings.z.value, 30, 0, 0)
        end
        return fireBreathSettings.on
    end)
end

function firebreathscale(value)
    fireBreathSettings.scale = value / 10
    GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(fireBreathSettings.ptfx, fireBreathSettings.scale)
end

function firebreathcolour(colour)
    fireBreathSettings.colour = colour
    GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireBreathSettings.ptfx, fireBreathSettings.colour.r, fireBreathSettings.colour.g, fireBreathSettings.colour.b)
end
--轨迹
function removeFxs(effects)
	for _, effect in ipairs(effects) do
		GRAPHICS.STOP_PARTICLE_FX_LOOPED(effect, 0)
		GRAPHICS.REMOVE_PARTICLE_FX(effect, 0)
	end
end

local function getZoneName(pid)
    return util.get_label_text(ZONE.GET_NAME_OF_ZONE(v3.get(players.get_position(pid))))
end

local wasDead = false
local respawnPos
local respawnRot
function custom_respawn()
    if respawnPos == nil then return end
    local isDead = PLAYER.IS_PLAYER_DEAD(players.user())
    if wasDead and not isDead then
        while PLAYER.IS_PLAYER_DEAD(players.user()) do
            util.yield()
        end
        for i = 0, 30 do
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), respawnPos.x, respawnPos.y, respawnPos.z, false, false, false)
            ENTITY.SET_ENTITY_ROTATION(players.user_ped(), respawnRot.x, respawnRot.y, respawnRot.z, 2, true)
            util.yield()
        end
    end
    wasDead = isDead
end

function save_custom_respawn()
    respawnPos = players.get_position(players.user())
    respawnRot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 2)
    menu.set_menu_name(custom_respawn_toggle, '自定义复活' ..': '.. getZoneName(players.user()))
    local pos = 'X: '.. respawnPos.x ..'\nY: '.. respawnPos.y ..'\nZ: '.. respawnPos.z
    menu.set_help_text(custom_respawn_toggle,  pos)
    menu.set_help_text(custom_respawn_location,  '当前位置' ..':\n'.. pos)
end


function getOffsetFromCam(dist)
    local pos = CAM.GET_FINAL_RENDERED_CAM_COORD()
    local dir = v3.toDir(CAM.GET_FINAL_RENDERED_CAM_ROT(2))
    local offset = {
        x = pos.x + dir.x * dist,
        y = pos.y + dir.y * dist,
        z = pos.z + dir.z * dist
    }
    return offset
end

function pvpdefmode()
    for _, pid in ipairs(players.list(false, true, true)) do
        if PLAYER.IS_PLAYER_FREE_AIMING(pid) then
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, true)
        else 
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
        end
    end
end

maxHealth_cantseeyouinmap = 328
function undead()
    if  ENTITY.GET_ENTITY_MAX_HEALTH(players.user_ped()) ~= 0 then
		ENTITY.SET_ENTITY_MAX_HEALTH(players.user_ped(), 0)
	end
end

function autoaccept()
    local message_hash = HUD.GET_WARNING_SCREEN_MESSAGE_HASH()
    if message_hash == 15890625 or message_hash == -398982408 or message_hash == -587688989 then
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1.0)
        util.yield(200)
    end
end

function autogethost()
    util.yield(2000)
    if players.get_host() ~= players.user() and get_transition_state(players.user()) ~= 0 then
        menu.trigger_command(menu.ref_by_path("Players>"..players.get_name_with_tags(players.get_host())..">Kick>Smart"))
    end
end

local function ClearBit(bits, place)
	return (bits & ~(1 << place))
end

function autogetcar()
    local count = memory.read_int(memory.script_global(1585857))
    for i = 0, count do
        local canFix = (bitTest(memory.script_global(1585857 + 1 + (i * 142) + 103), 1) and bitTest(memory.script_global(1585857 + 1 + (i * 142) + 103), 2))
        if canFix then
            clearBit(memory.script_global(1585857 + 1 + (i * 142) + 103), 1)
            clearBit(memory.script_global(1585857 + 1 + (i * 142) + 103), 3)
            clearBit(memory.script_global(1585857 + 1 + (i * 142) + 103), 16)
            util.toast("你的载具被摧毁,正在为你自动索赔.")
        end
    end
    util.yield(100)
end

function get_entities_in_player_range(pId, radius)
	local peds = get_peds_in_player_range(pId, radius)
	local vehicles = get_vehicles_in_player_range(pId, radius)
	local entities = peds
	for i = 1, #vehicles do table.insert(entities, vehicles[i]) end
	return entities
end

local selectedOpt = 1
options_force  = {"推开", "摧毁"}
function forcefielddd()
    if selectedOpt == 1 then
		local entities = get_entities_in_player_range(players.user(), 10.0)
		local playerPos = players.get_position(players.user())
		for _, entity in ipairs(entities) do
			local entPos = ENTITY.GET_ENTITY_COORDS(entity, false)

			if not (ENTITY.IS_ENTITY_A_PED(entity) and PED.IS_PED_A_PLAYER(entity)) and
			PED.GET_VEHICLE_PED_IS_USING(players.user_ped()) ~= entity and request_control_once(entity) then
				local force = v3.new(entPos)
				force:sub(playerPos)
				force:normalise()
				if ENTITY.IS_ENTITY_A_PED(entity) then PED.SET_PED_TO_RAGDOLL(entity, 1000, 1000, 0, false, false, false) end
				ENTITY.APPLY_FORCE_TO_ENTITY(entity, 3, force.x,force.y,force.z, 0, 0, 0.5, 0, false, false, true, false, false)
			end
		end
	elseif selectedOpt == 2 then
		set_explosion_proof(players.user_ped(), true)
		local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
		FIRE.ADD_EXPLOSION(pos.x,pos.y,pos.z, 29, 5.0, false, true, 0.0, true)
	end
end

function forcefield_set(index)
    selectedOpt = index
end

state = 0
local notif_format = "按 左键 和 右键 来使用原力"
function jedmode()
    if state == 0 then
		notification(notif_format, HudColour.blue, "INPUT_ATTACK", "INPUT_AIM")
		local effect = Effect.new("scr_ie_tw", "scr_impexp_tw_take_zone")
		local colour = {r = 0.5, g = 0.0, b = 0.5, a = 1.0}
		request_fx_asset(effect.asset)
		GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
		GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour.r, colour.g, colour.b)
		GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
			effect.name, players.user_ped(), 0.0, 0.0, -0.9,1.0, 1.0,1, 1.0, false, false, false
		)
		state = 1
	elseif state == 1 then
		PLAYER.DISABLE_PLAYER_FIRING(players.user(), true)
		PAD.DISABLE_CONTROL_ACTION(0, 25, true)
		PAD.DISABLE_CONTROL_ACTION(0, 68, true)
		PAD.DISABLE_CONTROL_ACTION(0, 91, true)
		local entities = get_ped_nearby_vehicles(players.user_ped())

		for _, vehicle in ipairs(entities) do
			if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) and
			PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) == vehicle then
				continue
			end
			if PAD.IS_DISABLED_CONTROL_PRESSED(0, 24) and
			request_control_once(vehicle) then
				ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 0.5, 1.0, 1.0,1, 0, false, false, true, false, false)

			elseif PAD.IS_DISABLED_CONTROL_PRESSED(0, 25) and
			request_control_once(vehicle) then
				ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, -70.0,1.0, 1.0,1, 0, false, false, true, false, false)
			end
		end
	end
end

object = 0
local format0 = "按 ~%s~ ~%s~ ~%s~ ~%s~ 来使用地毯式骑行"
local format1 = "按 ~%s~ 以移动得更快"
function carpetridexx()
    if state == 0 then
		local objHash = util.joaat("p_cs_beachtowel_01_s")
		request_model(objHash)
		STREAMING.REQUEST_ANIM_DICT("rcmcollect_paperleadinout@")
		while not STREAMING.HAS_ANIM_DICT_LOADED("rcmcollect_paperleadinout@") do
			util.yield_once()
		end
		local localPed = players.user_ped()
		local pos = ENTITY.GET_ENTITY_COORDS(localPed, false)
		TASK.CLEAR_PED_TASKS_IMMEDIATELY(localPed)
		object = entities.create_object(objHash, pos)
		ENTITY.ATTACH_ENTITY_TO_ENTITY(
			localPed, object, 0, 0, -0.2, 1.0, 1.0, 1.0,1, false, true, false, false, 0, true, false
		)
		ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(object, false, false)

		TASK.TASK_PLAY_ANIM(localPed, "rcmcollect_paperleadinout@", "meditiate_idle", 8.0, -8.0, -1, 1, 0.0, false, false, false)
        --notification("~m~使~m~用~m~W,~m~S,~m~空格,~m~左Ctrl,~m~左Shift~m~进~m~行~m~飞~m~行",colors.blue)
        notification123:help(format0 .. ".\n" .. format1 .. '.', HudColour.black,
        "INPUT_MOVE_UP_ONLY", "INPUT_MOVE_DOWN_ONLY", "INPUT_VEH_JUMP", "INPUT_DUCK", "INPUT_VEH_MOVE_UP_ONLY")
		state = 1

	elseif state == 1 then
		HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME()
		local objPos = ENTITY.GET_ENTITY_COORDS(object, false)
		local camrot = CAM.GET_GAMEPLAY_CAM_ROT(0)
		ENTITY.SET_ENTITY_ROTATION(object, 0, 0, camrot.z, 0, true)
		local forwardV = ENTITY.GET_ENTITY_FORWARD_VECTOR(players.user_ped())
		forwardV.z = 0.0
		local delta = v3.new(0, 0, 0)
		local speed = 0.2
		if PAD.IS_CONTROL_PRESSED(0, 61) then
			speed = 1.5
		end
		if PAD.IS_CONTROL_PRESSED(0, 32) then
			delta = v3.new(forwardV)
			delta:mul(speed)
		end
		if PAD.IS_CONTROL_PRESSED(0, 130)  then
			delta = v3.new(forwardV)
			delta:mul(-speed)
		end
		if PAD.IS_DISABLED_CONTROL_PRESSED(0, 22) then
			delta.z = speed
		end
		if PAD.IS_CONTROL_PRESSED(0, 36) then
			delta.z = -speed
		end
		local newPos = v3.new(objPos)
		newPos:add(delta)
		ENTITY.SET_ENTITY_COORDS(object, newPos.x,newPos.y,newPos.z, false, false, false, false)
	end
end

function bigpussy()
    if state == 0 then
		local objHash <const> = util.joaat("apa_mp_apa_y1_l1a")
		request_model(objHash)
		STREAMING.REQUEST_ANIM_DICT("rcmcollect_paperleadinout@")
		while not STREAMING.HAS_ANIM_DICT_LOADED("rcmcollect_paperleadinout@") do
			util.yield()
		end
		local localPed = PLAYER.PLAYER_PED_ID()
		local pos = ENTITY.GET_ENTITY_COORDS(localPed)
		TASK.CLEAR_PED_TASKS_IMMEDIATELY(localPed)
		object = entities.create_object(objHash, pos)
		ENTITY.ATTACH_ENTITY_TO_ENTITY(localPed, object, 0, 0, 4, 1.0, 0, 0, 0, false, true, false, false, 0, true)
		ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(object, false, false)	
		state = 1
	elseif state == 1 then
		HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME()
		local objPos = ENTITY.GET_ENTITY_COORDS(object)
		local camrot = CAM.GET_GAMEPLAY_CAM_ROT(0)
		ENTITY.SET_ENTITY_ROTATION(object, camrot.x, camrot.y, camrot.z, 0, true)
		local forwardV = ENTITY.GET_ENTITY_FORWARD_VECTOR(PLAYER.PLAYER_PED_ID())
		forwardV.z = 0.0
		local delta = v3.new(0, 0, 0)
		local speed = 0.2

		local newPos = v3.new(objPos)
		newPos:add(delta)
		ENTITY.SET_ENTITY_COORDS(object, newPos.x, newPos.y, newPos.z, false, false, false, false)
	end
end



------------------------------------
-------------玩家崩溃---------------
------------------------------------

--奥特曼崩V1
function aotemanv1(PlayerID)
	local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local SpawnPed_Wade = { }
    for i = 1, 60 do
        SpawnPed_Wade[i] = CreatePed(26, util.joaat("PLAYER_TWO"),TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        util.yield(1)
    end
    util.yield(5000)
    for i = 1, 60 do
        entities.delete_by_handle(SpawnPed_Wade[i])
    end
end

--奥特曼崩V2
function aotemanv2(PlayerID)
local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local SpawnPed_Wade = { }
    for i = 1, 60 do
        SpawnPed_Wade[i] = CreatePed(26, util.joaat("PLAYER_ZERO"),TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        util.yield(1)
    end
    util.yield(5000)
    for i = 1, 60 do
        entities.delete_by_handle(SpawnPed_Wade[i])
    end
end

--奥特曼崩V3
function aotemanv3(PlayerID)
local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local SpawnPed_Wade = { }
    for i = 1, 60 do
        SpawnPed_Wade[i] = CreatePed(26, util.joaat("PLAYER_ONE"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        util.yield(1)
    end
    util.yield(5000)
    for i = 1, 60 do
        entities.delete_by_handle(SpawnPed_Wade[i])
    end
end

---因莎拉崩溃
function inshellcrash(PlayerID)
    local TargetPPos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
    local PED1  = CreatePed(28,-1011537562,TargetPPos,0)
    local PED2  = CreatePed(28,-541762431,TargetPPos,0)
    WEAPON.GIVE_WEAPON_TO_PED(PED1,-1813897027,1,true,true)
    WEAPON.GIVE_WEAPON_TO_PED(PED2,-1813897027,1,true,true)
    util.yield(1000)
    TASK.TASK_THROW_PROJECTILE(PED1,TargetPPos.x,TargetPPos.y,TargetPPos.z,0,0)
    TASK.TASK_THROW_PROJECTILE(PED2,TargetPPos.x,TargetPPos.y,TargetPPos.z,0,0)
    notification("Finished.",colors.red)
end

--for 大自然崩溃v1 v2 泡泡糖崩溃 绿玩保护崩溃
local function BlockSyncs(PlayerID, callback)
    for _, i in ipairs(players.list(false, true, true)) do
        if i ~= PlayerID then
            local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
            menu.trigger_command(outSync, "on")
        end
    end
    util.yield(10)
    callback()
    for _, i in ipairs(players.list(false, true, true)) do
        if i ~= PlayerID then
            local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
            menu.trigger_command(outSync, "off")
        end
    end
end

--大自然崩溃
function naturecrashv1(PlayerID)
    local user = players.user()
    local user_ped = players.user_ped()
    local pos = players.get_position(user)
    BlockSyncs(PlayerID, function()
        util.yield(100)
        menu.trigger_commands("invisibility on")
        for i = 0, 110 do
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user, 0xFBF7D21F)
            PED.SET_PED_COMPONENT_VARIATION(user_ped, 5, i, 0, 0)
            util.yield(50)
            PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        end
        util.yield(250)
        for i = 1, 5 do
            util.spoof_script("freemode", SYSTEM.WAIT)
        end
        ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x, pos.y, pos.z, 0, false, false, 0)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        menu.trigger_commands("invisibility off")
    end)
end

---大自然崩溃 v2
function naturecrashv2(PlayerID)
    local user = players.user()
    local user_ped = players.user_ped()
    local pos = players.get_position(user)
    BlockSyncs(PlayerID, function() 
        util.yield(100)
        PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), 0xFBF7D21F)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
        TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
        util.yield()
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
        util.yield(250)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        util.yield(1000)
        for i = 1, 5 do
            util.spoof_script("freemode", SYSTEM.WAIT)
        end
        ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x, pos.y, pos.z, 0, false, false, 0)
    end)
end
--crash_request_model
function request_model(hash, timeout)
    timeout = timeout or 3
    STREAMING.REQUEST_MODEL(hash)
    local end_time = os.time() + timeout
    repeat
        util.yield()
    until STREAMING.HAS_MODEL_LOADED(hash) or os.time() >= end_time
    return STREAMING.HAS_MODEL_LOADED(hash)
end
--绿玩保护崩溃
function cpscrash(PlayerID)
    local mdl = util.joaat('a_c_poodle')
    BlockSyncs(PlayerID, function()
        if request_model(mdl, 2) then
            local pos = players.get_position(PlayerID)
            util.yield(100)
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            ped1 = entities.create_ped(26, mdl, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(PlayerID), 0, 3, 0), 0) 

           
            local coords = ENTITY.GET_ENTITY_COORDS(ped1, true)
            WEAPON.GIVE_WEAPON_TO_PED(ped1, util.joaat('WEAPON_HOMINGLAUNCHER'), 9999, true, true)
            local obj
            repeat
                obj = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(ped1, 0)
            until obj ~= 0 or util.yield()
            ENTITY.DETACH_ENTITY(obj, true, true) 
            util.yield(1500)
            FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 0, 1.0, false, true, 0.0, false)
            entities.delete_by_handle(ped1)
            util.yield(1000)
        else
            util.toast("Failed to load model. :/")
        end
    end)
end
--莱纳斯崩溃
function lestcrash(PlayerID)
    local int_min = -2147483647
    local int_max = 2147483647
    for i = 1, 150 do
    util.trigger_script_event(1 << PlayerID, {2765370640, PlayerID, 3747643341, math.random(int_min, int_max), math.random(int_min, int_max), 
    math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
    math.random(int_min, int_max), PlayerID, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
end
util.yield()
    for i = 1, 15 do
    util.trigger_script_event(1 << PlayerID, {1348481963, PlayerID, math.random(int_min, int_max)})
    end
menu.trigger_commands("givesh " .. players.get_name(PlayerID))
util.yield(100)
util.trigger_script_event(1 << PlayerID, {495813132, PlayerID, 0, 0, -12988, -99097, 0})
util.trigger_script_event(1 << PlayerID, {495813132, PlayerID, -4640169, 0, 0, 0, -36565476, -53105203})
util.trigger_script_event(1 << PlayerID, {495813132, PlayerID,  0, 1, 23135423, 3, 3, 4, 827870001, 5, 2022580431, 6, -918761645, 7, 1754244778, 8, 827870001, 9, 17})
end

--碎片崩溃
function fragmentcrash(PlayerID)
    BlockSyncs(PlayerID, function()
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        util.yield(1000)
        entities.delete_by_handle(object)
    end)
end
        ---董哥崩溃
        function dongge(PlayerID)
            util.toast("I'll try to convince them to leave :) ")
                PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),0xE5022D03)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
                util.yield(20)
                local p_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),p_pos.x,p_pos.y,p_pos.z,false,true,true)
                WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()), 0xFBAB5776, 1000, false)
                TASK.TASK_PARACHUTE_TO_TARGET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1087,-3012,13.94)
                util.yield(500)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
                util.yield(1000)
                PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID())
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
                end

--美杜莎崩溃
function MDS(PlayerID)
    menu.trigger_commands("anticrashcam on")
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
	local plauuepos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    plauuepos.x = plauuepos.x + 5
    plauuepos.z = plauuepos.z + 5
    local hunter = {}
    for i = 1 ,3 do
        for n = 0,120 do
            hunter[n] = CreateVehicle(1077420264,plauuepos,0)
            util.yield(0)
            ENTITY.FREEZE_ENTITY_POSITION(hunter[n],true)
            util.yield(0)
            VEHICLE.EXPLODE_VEHICLE(hunter[n], true, true)
        end
        util.yield(190)
        for i = 1,#hunter do
            if hunter[i] ~= nil then
                entities.delete_by_handle(hunter[i])
            end
        end
    end
    util.toast("Finished!")
	menu.trigger_commands("anticrashcam off")
    hunter = nil
    plauuepos = nil	
end

---马桶崩溃
function toiletcrash(PlayerID)
    for i = 1, 10 do
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local cord = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        STREAMING.REQUEST_MODEL(-930879665)
        util.yield(10)
        STREAMING.REQUEST_MODEL(3613262246)
        util.yield(10)
        STREAMING.REQUEST_MODEL(452618762)
        util.yield(10)
        while not STREAMING.HAS_MODEL_LOADED(-930879665) do util.yield() end
        while not STREAMING.HAS_MODEL_LOADED(3613262246) do util.yield() end
        while not STREAMING.HAS_MODEL_LOADED(452618762) do util.yield() end
        local a1 = entities.create_object(-930879665, cord)
        util.yield(10)
        local a2 = entities.create_object(3613262246, cord)
        util.yield(10)
        local b1 = entities.create_object(452618762, cord)
        util.yield(10)
        local b2 = entities.create_object(3613262246, cord)
        util.yield(300)
        entities.delete_by_handle(a1)
        entities.delete_by_handle(a2)
        entities.delete_by_handle(b1)
        entities.delete_by_handle(b2)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(452618762)
        util.yield(10)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(3613262246)
        util.yield(10)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(-930879665)
        util.yield(10)
        end
        if SE_Notifications then
            notification("Finished.",colors.red)
        end
    end

    --声音崩溃V1
    function soundcrashv1(PlayerID)
        local time = util.current_time_millis() + 2000
                while time > util.current_time_millis() do
                    local pos=ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
                    for i = 1, 10 do
                        AUDIO.PLAY_SOUND_FROM_COORD(-1,"10s",pos.x,pos.y,pos.z,"MP_MISSION_COUNTDOWN_SOUNDSET",true, 70, false)
                    end
                    util.yield(0)
                end
            end 

        --声音崩溃V2
        function soundcrashv2(PlayerID)
        local time = util.current_time_millis() + 2000
                while time > util.current_time_millis() do
                    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
                    for i = 1, 20 do
                        AUDIO.PLAY_SOUND_FROM_COORD(-1, 'Event_Message_Purple', pos.x, pos.y, pos.z, 'GTAO_FM_Events_Soundset', true, 1000, false)
                        AUDIO.PLAY_SOUND_FROM_COORD(-1, '5s', pos.x, pos.y, pos.z, 'GTAO_FM_Events_Soundset', true, 1000, false)
                    end
                    util.yield()
                end	
            end

            ---无效模型崩溃
            function wxcrash(PlayerID)
                menu.trigger_commands("anticrashcam on")
                    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
                    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
                    local Object_pizza1 = CreateObject(3613262246, TargetPlayerPos)
                    local Object_pizza2 = CreateObject(2155335200, TargetPlayerPos)
                    local Object_pizza3 = CreateObject(3026699584, TargetPlayerPos)
                    local Object_pizza4 = CreateObject(-1348598835, TargetPlayerPos)
                    for i = 0, 100 do 
                        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
                        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
                        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
                        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza3, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
                        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza4, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
                        util.yield(10)
                    end
                    util.yield(2000)
                    entities.delete_by_handle(Object_pizza1)
                    entities.delete_by_handle(Object_pizza2)
                    entities.delete_by_handle(Object_pizza3)
                    entities.delete_by_handle(Object_pizza4)
                    menu.trigger_commands("anticrashcam off")
                    end

                    ---5g崩溃
                    function x999gcrash(PlayerID)
                        local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
                        local pos = ENTITY.GET_ENTITY_COORDS(TPP, true)
                        pos.z = pos.z + 10
                        veh = entities.get_all_vehicles_as_handles()
                        
                      for i = 1, #veh do
                      NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh[i])
                      ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh[i], pos.x,pos.y,pos.z, ENTITY.GET_ENTITY_HEADING(TPP), 10)
                      TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 18, 999)
                      TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 16, 999)
                      end
                  end

                  --大鸡巴崩溃
function suckmydick(PlayerID)
local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
local Object_jb1 = CreateObject(0xD75E01A6, TargetPlayerPos)
local Object_jb2 = CreateObject(0x675D244E, TargetPlayerPos)
local Object_jb3 = CreateObject(0x799B48CA, TargetPlayerPos)
local Object_jb4 = CreateObject(0x68E49D4D, TargetPlayerPos)
local Object_jb5 = CreateObject(0x66F34017, TargetPlayerPos)
local Object_jb6 = CreateObject(0xDE1807BB, TargetPlayerPos)
local Object_jb7 = CreateObject(0xC4C9551E, TargetPlayerPos)
local Object_jb8 = CreateObject(0xCF37BA1F, TargetPlayerPos)
local Object_jb9 = CreateObject(0xB69AD9F8, TargetPlayerPos)
local Object_jb10 = CreateObject(0x5D750529, TargetPlayerPos)
local Object_jb11 = CreateObject(0x1705D85C, TargetPlayerPos)
for i = 0, 1000 do 
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb3, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb4, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb5, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb6, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb7, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb8, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb9, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb10, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb11 ,TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    util.yield(10)
end
util.yield(5500)
entities.delete_by_handle(Object_jb1)
entities.delete_by_handle(Object_jb2)
entities.delete_by_handle(Object_jb3)
entities.delete_by_handle(Object_jb4)
entities.delete_by_handle(Object_jb5)
entities.delete_by_handle(Object_jb6)
entities.delete_by_handle(Object_jb7)
entities.delete_by_handle(Object_jb8)
entities.delete_by_handle(Object_jb9)
entities.delete_by_handle(Object_jb10)
entities.delete_by_handle(Object_jb11)
end

--导弹车崩溃V1
function daodanchev1(PlayerID)
    menu.trigger_commands("anticrashcam on")
            local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
            SpawnedVehicleList = { };
            for i = 1, 80 do
                local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
                SpawnedVehicleList[i] = CreateVehicle(util.joaat("chernobog"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
                ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicleList[i], true)
                ENTITY.SET_ENTITY_VISIBLE(SpawnedVehicleList[i], false, 0)
                util.yield(50)
            end
            util.yield(5000)
            for i = 1, 80 do
                entities.delete_by_handle(SpawnedVehicleList[i])
            end
            menu.trigger_commands("anticrashcam off")
            end

    --导弹车崩溃V2
    function daodanchev2(PlayerID)
    menu.trigger_commands("anticrashcam on")
            local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
            TargetPlayerPos.y = TargetPlayerPos.y + 1050
            SpawnedVehicleList1 = { };
            for i = 1, 60 do
                local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
                SpawnedVehicleList1[i] = CreateVehicle(util.joaat("chernobog"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
                ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicleList1[i], true)
                ENTITY.SET_ENTITY_VISIBLE(SpawnedVehicleList1[i], false, 0)
                util.yield(50)
            end
            util.yield(2000)
            for i = 1, 60 do
                entities.delete_by_handle(SpawnedVehicleList1[i])
            end
    
            util.yield(1000)
            SpawnedVehicleList2 = { };
            for i = 1, 50 do
                local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
                SpawnedVehicleList2[i] = CreateVehicle(util.joaat("chernobog"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
                ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicleList2[i], true)
                ENTITY.SET_ENTITY_VISIBLE(SpawnedVehicleList2[i], false, 0)
                util.yield(50)
            end
            util.yield(2000)
            for i = 1, 50 do
                entities.delete_by_handle(SpawnedVehicleList2[i])
            end
            menu.trigger_commands("anticrashcam off")
        end

        --无效外观V1
        function BadOutfitCrashV1(PlayerID)
            menu.trigger_commands("anticrashcam on")
            local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
            local SelfPlayerPed = PLAYER.PLAYER_PED_ID();
            local Spawned_Mike = CreatePed(26, util.joaat("player_zero"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
            for i = 0, 500 do
                PED.SET_PED_COMPONENT_VARIATION(Spawned_Mike, 0, 0, math.random(0, 10), 0)
                ENTITY.SET_ENTITY_COORDS(Spawned_Mike, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, true, false, false, true);
                util.yield(10)
            end
            entities.delete_by_handle(Spawned_Mike)
            menu.trigger_commands("anticrashcam off")
        end

        --无效外观V2
function BadOutfitCrashV2(PlayerID)
    local getEntityCoords = ENTITY.GET_ENTITY_COORDS
    local getPlayerPed = PLAYER.GET_PLAYER_PED
    local hashes = {1492612435, 3517794615, 3889340782, 3253274834}
    local vehicles = {}
    for i = 1, 4 do
        util.create_thread(function()
            RqModel(hashes[i])
            local pcoords = getEntityCoords(getPlayerPed(PlayerID))
            local veh =  VEHICLE.CREATE_VEHICLE(hashes[i], pcoords.x, pcoords.y, pcoords.z, math.random(0, 360), true, true, false)
            for a = 1, 20 do NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh) end
            VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
            for j = 0, 49 do
                local mod = VEHICLE.GET_NUM_VEHICLE_MODS(veh, j) - 1
                VEHICLE.SET_VEHICLE_MOD(veh, j, mod, true)
                VEHICLE.TOGGLE_VEHICLE_MOD(veh, mod, true)
            end
            for j = 0, 20 do
                if VEHICLE.DOES_EXTRA_EXIST(veh, j) then VEHICLE.SET_VEHICLE_EXTRA(veh, j, true) end
            end
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(veh, false)
            VEHICLE.SET_VEHICLE_WINDOW_TINT(veh, 1)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(veh, 1)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(veh, " ")
            for ai = 1, 50 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                pcoords = getEntityCoords(getPlayerPed(PlayerID))
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, pcoords.x, pcoords.y, pcoords.z, false, false, false)
                util.yield()
            end
            vehicles[#vehicles+1] = veh
        end)
    end
    wait(2000)
    for _, v in pairs(vehicles) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(v)
        entities.delete_by_handle(v)
    end
end

---单崩黄昏
function dhcrash(PlayerID)
    for pedp_crash = 2 , 6 do
    pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    pos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    dune = CreateVehicle(410882957,pos,ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dune, true)
    dune1 = CreateVehicle(2971866336,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dune1, true)
    barracks = CreateVehicle(3602674979,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(barracks, true)
    barracks1 = CreateVehicle(444583674,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(barracks1, true)
    dunecar = CreateVehicle(2971866336,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dunecar, true)
    dunecar1 = CreateVehicle(3602674979,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dunecar1, true)
    dunecar2 = CreateVehicle(444583674,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(dunecar2, true)
    barracks3 = CreateVehicle(4244420235,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(barracks3, true)
    barracks31 = CreateVehicle(3602674979,pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(barracks31, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks3, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks31, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks1, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dune, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dune1, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dunecar1, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dunecar2, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(dunecar, pedp, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    util.yield(5000)
    for i = 0, 100  do
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dunecar, pos.x, pos.y, pos.z, false, true, true)
            util.yield(10)
        end
        util.yield(2000)
        entities.delete_by_handle(dune)
        entities.delete_by_handle(dune1)
        entities.delete_by_handle(barracks)
        entities.delete_by_handle(barracks1)
        entities.delete_by_handle(dunecar)
        entities.delete_by_handle(dunecar1)
        entities.delete_by_handle(dunecar2)
        entities.delete_by_handle(barracks3)
        entities.delete_by_handle(barracks31)
    end
end
function OXcrashgg(PlayerID)
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
        notification("未能移除玩家,正在使用cs_fabien模型",colors.red)
        local PED2 = CreatePed(26,util.joaat("cs_fabien"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED2, false, 0)
        util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED2,-270015777,80,true,true)
        util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        util.yield(5000)
    
        entities.delete_by_handle(PED2)
        end
    if players.exists(PlayerID) then
        notification("未能移除玩家,正在使用cs_manuel模型",colors.red)
        local PED3 = CreatePed(26,util.joaat("cs_manuel"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED3, false, 0)
        util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED3,-270015777,80,true,true)
        util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        util.yield(5000)
    
        entities.delete_by_handle(PED3)
        end
    if players.exists(PlayerID) then
        notification("未能移除玩家,正在使用cs_taostranslator模型",colors.red)
        local PED4 = CreatePed(26,util.joaat("cs_taostranslator"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED4, false, 0)
        util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED4,-270015777,80,true,true)
        util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        util.yield(5000)
    
        entities.delete_by_handle(PED4)
        end
    if players.exists(PlayerID) then
        notification("未能移除玩家,正在使用cs_taostranslator2模型",colors.red)
        local PED5 = CreatePed(26,util.joaat("cs_taostranslator2"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED5, false, 0)
        util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED5,-270015777,80,true,true)
        util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        util.yield(5000)
    
        entities.delete_by_handle(PED5)
        end
    if players.exists(PlayerID) then
        notification("未能移除玩家,正在使用cs_tenniscoach模型",colors.red)
        local PED6 = CreatePed(26,util.joaat("cs_tenniscoach"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED6, false, 0)
        util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED6,-270015777,80,true,true)
        util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        util.yield(5000)
    
            entities.delete_by_handle(PED6)
        end
    if players.exists(PlayerID) then
        notification("未能移除玩家,正在使用cs_wade模型",colors.red)
        local PED7 = CreatePed(26,util.joaat("cs_wade"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED7, false, 0)
        util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED7,-270015777,80,true,true)
        util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        util.yield(5000)
    
        entities.delete_by_handle(PED7)
        end
    if not players.exists(PlayerID) then
        notification("成功移除玩家",colors.red)
    end
end

function OXcrashggv2(PlayerID)
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    
    local PED1 = CreatePed(26,util.joaat("cs_beverly"),TargetPlayerPos, 0)
    ENTITY.SET_ENTITY_VISIBLE(PED1, false, 0)
    util.yield(100)
    WEAPON.GIVE_WEAPON_TO_PED(PED1,-270015777,80,true,true)
    util.yield(1000)
    FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
        
    util.yield(1000)
    
    entities.delete_by_handle(PED1)
        
    if players.exists(PlayerID) then
        local PED2 = CreatePed(26,util.joaat("cs_fabien"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED2, false, 0)
        util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED2,-270015777,80,true,true)
        util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        util.yield(1000)
    
        entities.delete_by_handle(PED2)
        end
    if players.exists(PlayerID) then
        local PED3 = CreatePed(26,util.joaat("cs_manuel"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED3, false, 0)
        util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED3,-270015777,80,true,true)
        util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        util.yield(1000)
    
        entities.delete_by_handle(PED3)
        end
    if players.exists(PlayerID) then
        local PED4 = CreatePed(26,util.joaat("cs_taostranslator"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED4, false, 0)
        util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED4,-270015777,80,true,true)
        util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        util.yield(1000)
    
        entities.delete_by_handle(PED4)
        end
    if players.exists(PlayerID) then
        local PED5 = CreatePed(26,util.joaat("cs_taostranslator2"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED5, false, 0)
        util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED5,-270015777,80,true,true)
        util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        util.yield(1000)
    
        entities.delete_by_handle(PED5)
        end
    if players.exists(PlayerID) then
        local PED6 = CreatePed(26,util.joaat("cs_tenniscoach"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED6, false, 0)
        util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED6,-270015777,80,true,true)
        util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        util.yield(1000)
    
            entities.delete_by_handle(PED6)
        end
    if players.exists(PlayerID) then
        local PED7 = CreatePed(26,util.joaat("cs_wade"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED7, false, 0)
        util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED7,-270015777,80,true,true)
        util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
        util.yield(1000)
    
        entities.delete_by_handle(PED7)
        end
    if not players.exists(PlayerID) then
        notification("成功移除玩家",colors.blue)
    end
end

--改进露娜崩溃
function lunacrash(PlayerID)
    fishmm = state
    local TargetPPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPPos = ENTITY.GET_ENTITY_COORDS(TargetPPed)
    ENTITY.SET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1992.8982, -780.7021, -0.37660158, false, false, false, false)
    menu.trigger_commands("levitatepassivemax 0")
    menu.trigger_commands("levitateassistup 0")
    menu.trigger_commands("levitateassistdown 0")
    menu.trigger_commands("noguns")
    menu.trigger_commands("invisibility on")
    util.yield(1000)
    menu.trigger_commands("acfish")
    util.yield(100)
    menu.trigger_commands(" on")
    util.yield(100)
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1813897027,15,true,true)
    util.yield(100)
    ENTITY.SET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),TargetPPos.x,TargetPPos.y,TargetPPos.z, false, false, false, false)
    util.yield(100)
util.yield(9000)
if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
    menu.trigger_commands("mpmale")
else
    menu.trigger_commands("mpfemale")
end
menu.trigger_commands("levitatepassivemax 0.6")
menu.trigger_commands("levitateassistup 0.6")
menu.trigger_commands("levitateassistdown 0.6")
menu.trigger_commands("levitate off")
menu.trigger_commands("noguns")
menu.trigger_commands("invisibility off")
notification("搞定",colors.red)
while fishmm do
    util.yield()
    PAD._SET_CONTROL_NORMAL(0, 25, 1)
end
end
---拖车崩
function tuocheb(PlayerID)
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    SpawnedDune1 = CreateVehicle(util.joaat("dune"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(SpawnedDune1, true)
    SpawnedDune2 = CreateVehicle(util.joaat("dune"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(SpawnedDune2, true)
    SpawnedBarracks1 = CreateVehicle(util.joaat("barracks"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(SpawnedBarracks1, true)
    SpawnedBarracks2 = CreateVehicle(util.joaat("barracks"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(SpawnedBarracks2, true)
    SpawnedTowtruck = CreateVehicle(util.joaat("towtruck2"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(SpawnedTowtruck, true)
    SpawnedBarracks31 = CreateVehicle(util.joaat("barracks3"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(SpawnedBarracks31, true)
    SpawnedBarracks32 = CreateVehicle(util.joaat("barracks3"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
    ENTITY.FREEZE_ENTITY_POSITION(SpawnedBarracks32, true)

    ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedBarracks31, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedBarracks32, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedBarracks1, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedBarracks2, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedDune1, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedDune2, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
    for i = 0, 100 do 
        TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SpawnedTowtruck, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
        util.yield(10)
    end
    util.yield(2000)
    entities.delete_by_handle(SpawnedTowtruck)
    entities.delete_by_handle(SpawnedDune1)
    entities.delete_by_handle(SpawnedDune2)
    entities.delete_by_handle(SpawnedBarracks31)
    entities.delete_by_handle(SpawnedBarracks32)
    entities.delete_by_handle(SpawnedBarracks1)
    entities.delete_by_handle(SpawnedBarracks2)
end

---鬼崩
function guibeng(PlayerID)
    menu.trigger_commands("anticrashcam on")
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local SelfPlayerPed = PLAYER.PLAYER_PED_ID()
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    local Spawned_tr3 = CreateVehicle(util.joaat("tr3"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(Spawned_tr3, SelfPlayerPed, 0, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
    ENTITY.SET_ENTITY_VISIBLE(Spawned_tr3, false, 0)
    local Spawned_chernobog = CreateVehicle(util.joaat("chernobog"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(Spawned_chernobog, SelfPlayerPed, 0, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
    ENTITY.SET_ENTITY_VISIBLE(Spawned_chernobog, false, 0)
    local Spawned_avenger = CreateVehicle(util.joaat("avenger"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(Spawned_avenger, SelfPlayerPed, 0, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
    ENTITY.SET_ENTITY_VISIBLE(Spawned_avenger, false, 0)
    for i = 0, 100 do
        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        ENTITY.SET_ENTITY_COORDS(SelfPlayerPed, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, true, false, false)
        util.yield(10 * math.random())
        ENTITY.SET_ENTITY_COORDS(SelfPlayerPed, SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z, true, false, false)
        util.yield(10 * math.random())
    end
    menu.trigger_commands("anticrashcam off")
end
---猎杀者
function huntercrash(PlayerID)
    menu.trigger_commands("anticrashcam on")
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local SpawnedVehicleList = { };
    for i = 1, 60 do
        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        SpawnedVehicleList[i] = CreateVehicle(util.joaat("hunter"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
        ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicleList[i], true)
        ENTITY.SET_ENTITY_VISIBLE(SpawnedVehicleList[i], false, 0)
        util.yield(50)
    end
    util.yield(5000)
    for i = 1, 60 do
        entities.delete_by_handle(SpawnedVehicleList[i])
    end
    menu.trigger_commands("anticrashcam off")
end
---AIO
function aaaio(PlayerID)
    if players.exists(PlayerID) then
        menu.trigger_commands("OXCrash " .. players.get_name(PlayerID))end
        util.yield(500)
    if players.exists(PlayerID) then
                menu.trigger_commands("wade " .. players.get_name(PlayerID))
                end
                util.yield(5000)
                menu.trigger_commands("anticrashcam on")
                if players.exists(PlayerID) then
                menu.trigger_commands("dongge " .. players.get_name(PlayerID))
                end
                util.yield(1520)
                menu.trigger_commands("anticrashcam on")
                if players.exists(PlayerID) then
                menu.trigger_commands("slaughter " .. players.get_name(PlayerID))
                end
                util.yield(1000)
                menu.trigger_commands("anticrashcam on")
                if players.exists(PlayerID) then
                menu.trigger_commands("wenyi " .. players.get_name(PlayerID))
                end
                util.yield(390)
                menu.trigger_commands("anticrashcam on")
                if players.exists(PlayerID) then
                menu.trigger_commands("tuoche " .. players.get_name(PlayerID))
                end
                util.yield(2010)
                menu.trigger_commands("anticrashcam on")
                if players.exists(PlayerID) then
                menu.trigger_commands("nicecrash" .. players.get_name(PlayerID).." 1")
                end
                util.yield(2010)
                menu.trigger_commands("anticrashcam on")
                if players.exists(PlayerID) then
                menu.trigger_commands("nicecrash" .. players.get_name(PlayerID).." 2")
                end
                util.yield(2010)
                menu.trigger_commands("anticrashcam on")
                if players.exists(PlayerID) then
                menu.trigger_commands("nicecrash" .. players.get_name(PlayerID).." 3")
                end
                util.yield(2010)
                menu.trigger_commands("anticrashcam on")
                if players.exists(PlayerID) then
                menu.trigger_commands("soundcrash" .. players.get_name(PlayerID).." 1")
                end
                util.yield(250)
                menu.trigger_commands("anticrashcam on")
                if players.exists(PlayerID) then
                menu.trigger_commands("soundcrash" .. players.get_name(PlayerID).." 2")
                end
                util.yield(250)
                menu.trigger_commands("anticrashcam on")
                if players.exists(PlayerID) then
                menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
                end
                util.yield(500)
                menu.trigger_commands("anticrashcam on")
                if players.exists(PlayerID) then
                menu.trigger_commands("nature " .. players.get_name(PlayerID))
                end
                util.yield(2500)
                if players.exists(PlayerID) then
                menu.trigger_commands("hiroshima " .. players.get_name(PlayerID))
                end
                util.yield(2500)
                if players.exists(PlayerID) then
                menu.trigger_commands("dick " .. players.get_name(PlayerID))
                end
                util.yield(5510)
                menu.trigger_commands("anticrashcam on")
                if players.exists(PlayerID) then
                menu.trigger_commands("ngcrash " .. players.get_name(PlayerID))
                end
                util.yield(5000)
                menu.trigger_commands("anticrashcam off")
                util.yield()
                if players.exists(PlayerID) then
                    util.toast("崩不掉")
              else
                    util.toast("成功移除此玩家")
                end
                util.toast("ojbk")
    end
    --脚本事件崩溃
    function scriptcrash(PlayerID)
        util.trigger_script_event(1 << PlayerID, { -555356783, PlayerID ,85952,99999,52682274855,526822745 })
        util.trigger_script_event(1 << PlayerID, { 526822748, PlayerID ,78552,99999 ,7949161,789454312})
        util.trigger_script_event(1 << PlayerID, { -66669983, PlayerID ,526822748,555555, math.random(80521,2959749521) })
        util.trigger_script_event(1 << PlayerID, { -1733737974, PlayerID ,789522 ,59486,48512151,-9545440,5845131,848153,math.random(1,2959749),189958})
        util.trigger_script_event(1 << PlayerID, { -1529596656, PlayerID ,795221,59486,48512151,-9545440 , math.random(1,2959749) })
        util.trigger_script_event(1 << PlayerID, { -8965204809, PlayerID ,795221,59486,48512151,-9545440 })
    end
    ---韦德崩
    function wadecrash(PlayerID)
        menu.trigger_commands("anticrashcam on")
            local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
            local SpawnPed_Wade = { }
            for i = 1, 60 do
                SpawnPed_Wade[i] = CreatePed(26, util.joaat("ig_wade"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
                util.yield(1)
            end
            util.yield(5000)
            for i = 1, 60 do
                entities.delete_by_handle(SpawnPed_Wade[i])
            end
            menu.trigger_commands("anticrashcam off")
        end
        ---主机崩
        function hostcrash(PlayerID)
            local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
            menu.trigger_commands("tpmazehelipad")
            ENTITY.SET_ENTITY_COORDS(self_ped, -6170, 10837, 40, true, false, false)
            util.yield(1000)
            menu.trigger_commands("tpmazehelipad")
        end
        --传送到玩家
        function tpplayer(PlayerID)
            local TTPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local spped = PLAYER.PLAYER_PED_ID()
                local ye = ENTITY.GET_ENTITY_COORDS(TTPed, true)
                ENTITY.SET_ENTITY_COORDS(spped, ye.x, ye.y, ye.z, true, false, false)
                util.yield(10 * math.random())
        end

------------------------------------
-------------玩家踢出---------------
------------------------------------
--阻止加入踢
function blockjoinkick(PlayerID)
    menu.trigger_commands("historyblock " .. players.get_name(PlayerID))
    menu.trigger_commands("breakup" .. players.get_name(PlayerID))
end
--智能踢
function autokickv1(PlayerID)
        util.trigger_script_event(1 << PlayerID, {0xB9BA4D30, PlayerID, 0x4, -1, 1, 1, 1})
        util.trigger_script_event(1 << PlayerID, {0x6A16C7F, PlayerID, memory.script_global(0x2908D3 + 1 + (PlayerID * 0x1C5) + 0x13E + 0x7)})
        util.trigger_script_event(1 << PlayerID, {0x63D4BFB1, players.user(), memory.read_int(memory.script_global(0x1CE15F + 1 + (PlayerID * 0x257) + 0x1FE))})
        menu.trigger_commands("breakup" .. players.get_name(PlayerID))
end
--智能踢
function autokickv2(PlayerID)
    util.trigger_script_event(1 << PlayerID, {0xB9BA4D30, PlayerID, 0x4, -1, 1, 1, 1})
    util.trigger_script_event(1 << PlayerID, {0x6A16C7F, PlayerID, memory.script_global(0x2908D3 + 1 + (PlayerID * 0x1C5) + 0x13E + 0x7)})
    util.trigger_script_event(1 << PlayerID, {0x63D4BFB1, players.user(), memory.read_int(memory.script_global(0x1CE15F + 1 + (PlayerID * 0x257) + 0x1FE))})
end
--静默踢
function silencekick(PlayerID)
    util.trigger_script_event(1 << PlayerID, {421832664, PlayerID, 0, memory.read_int(memory.script_global(1951261 + 829))})
end
--美国国家航空航天局踢
function nasakick(PlayerID)
    util.trigger_script_event(1 << PlayerID, {111242367, PlayerID, -210634234})
end
--自然死亡踢
function freemodekick(PlayerID)
    util.trigger_script_event(1 << PlayerID, {111242367, PlayerID, memory.script_global(2689235 + 1 + (PlayerID * 453) + 318 + 7)})
end
--网络保释踢
function networkkick(PlayerID)
    util.trigger_script_event(1 << PlayerID, {1674887089, players.user(), memory.read_int(memory.script_global(1892703 + 1 + (PlayerID * 599) + 510))})
end
--无效掉落踢
function invalidcollectiblekick(PlayerID)
    util.trigger_script_event(1 << PlayerID, {0xB9BA4D30, PlayerID, 0x4, -1, 1, 1, 1})
end

------------------------------------
-------------玩家笼子---------------
------------------------------------
--笼子
function ptlz(pid)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(player_ped) 
    if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
        menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." on")
        util.yield(300)
        if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
            notification("Failed to kick player out of the vehicle", colors.red)
            menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
            return
        end
        menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
        pos =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    end
    cage_player(pos)
end
--七度空间
function qdkj(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = 1089807209
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - 1, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + 1, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + 1, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - 1, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .75, true, true, false) -- above
	cages[#cages + 1] = cage_object

	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	rot.y = 90

	ENTITY.FREEZE_ENTITY_POSITION(cage_object, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object2, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object3, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object4, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object5, true)
	util.yield(15)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--钱笼子
function zdlz(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("bkr_prop_moneypack_03a")
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .70, pos.y, pos.z, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .70, pos.y, pos.z, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .70, pos.z, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .70, pos.z, true, true, false) -- right

	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .70, pos.y, pos.z + .25, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .70, pos.y, pos.z + .25, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .70, pos.z + .25, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .70, pos.z + .25, true, true, false) -- right

	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .75, true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	util.yield(15)
	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	rot.y = 90
	ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--垃圾箱
function yylz(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = 684586828
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z, true, true, false)
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + 1, true, true, false)
	cages[#cages + 1] = cage_object
	util.yield(15)
	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	rot.y = 90
	ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--小车车
function cclz(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    local hash = 4022605402
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do		
        util.yield()
    end
    local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
    cages[#cages + 1] = cage_object
    util.yield(15)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--圣诞快乐
function sdkl1(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = 238789712
	STREAMING.REQUEST_MODEL(hash)
	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
	cages[#cages + 1] = cage_object
	util.yield(15)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--圣诞快乐pro
function sdkl2(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("ch_prop_tree_02a")
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .75, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .75, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .75, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .75, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .5, true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	util.yield(15)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--圣诞快乐promax
function sdkl3(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("ch_prop_tree_03a")
	STREAMING.REQUEST_MODEL(hash)
	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .75, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .75, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .75, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .75, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .5, true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	util.yield()
	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
		rot.y = 90
		ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--电击笼
function powercage(pid)
    local number_of_cages = 6
    local elec_box = util.joaat("prop_elecbox_12")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    pos.z -= 0.5
    request_model(elec_box)
    local temp_v3 = v3.new(0, 0, 0)
    for i = 1, number_of_cages do
        local angle = (i / number_of_cages) * 360
        temp_v3.z = angle
        local obj_pos = temp_v3:toDir()
        obj_pos:mul(2.5)
        obj_pos:add(pos)
        for offs_z = 1, 5 do
            local electric_cage = entities.create_object(elec_box, obj_pos)
            spawned_objects[#spawned_objects + 1] = electric_cage
            ENTITY.SET_ENTITY_ROTATION(electric_cage, 90.0, 0.0, angle, 2, 0)
            obj_pos.z += 0.75
            ENTITY.FREEZE_ENTITY_POSITION(electric_cage, true)
        end
    end
end
--竞技管
function jjglz()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    STREAMING.REQUEST_MODEL(2081936690)
    while not STREAMING.HAS_MODEL_LOADED(2081936690) do		
        util.yield()
    end
    local cage_object = OBJECT.CREATE_OBJECT(2081936690, pos.x, pos.y, pos.z, true, true, false)
    cages[#cages + 1] = cage_object
    util.yield(15)
    local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
    rot.y = 90
    ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end

--伊丽莎白女王的棺材盒
function gueencage(pid)
    local number_of_cages = 6
    local coffin_hash = util.joaat("prop_coffin_02b")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(coffin_hash)
    local temp_v3 = v3.new(0, 0, 0)
    for i = 1, number_of_cages do
        local angle = (i / number_of_cages) * 360
        temp_v3.z = angle
        local obj_pos = temp_v3:toDir()
        obj_pos:mul(0.8)
        obj_pos:add(pos)
        obj_pos.z += 0.1
       local coffin = entities.create_object(coffin_hash, obj_pos)
       spawned_objects[#spawned_objects + 1] = coffin
       ENTITY.SET_ENTITY_ROTATION(coffin, 90.0, 0.0, angle,  2, 0)
       ENTITY.FREEZE_ENTITY_POSITION(coffin, true)
    end
end
--运输集装箱
function chestcage(pid)
    local container_hash = util.joaat("prop_container_ld_pu")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(container_hash)
    pos.z -= 1
    local container = entities.create_object(container_hash, pos, 0)
    spawned_objects[#spawned_objects + 1] = container
    ENTITY.FREEZE_ENTITY_POSITION(container, true)
end
--载具笼子
function vehcagelol(pid)
    local container_hash = util.joaat("boxville3")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(container_hash)
    local container = entities.create_vehicle(container_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 2.0, 0.0), ENTITY.GET_ENTITY_HEADING(ped))
    spawned_objects[#spawned_objects + 1] = container
    ENTITY.SET_ENTITY_VISIBLE(container, false)
    ENTITY.FREEZE_ENTITY_POSITION(container, true)
end
--燃气笼
function gascage(pid)
    local gas_cage_hash = util.joaat("prop_gascage01")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(gas_cage_hash)
    pos.z -= 1
    local gas_cage = entities.create_object(gas_cage_hash, pos, 0)
    pos.z += 1
    local gas_cage2 = entities.create_object(gas_cage_hash, pos, 0)
    spawned_objects[#spawned_objects + 1] = gas_cage
    spawned_objects[#spawned_objects + 1] = gas_cage2
    ENTITY.FREEZE_ENTITY_POSITION(gas_cage, true)
    ENTITY.FREEZE_ENTITY_POSITION(gas_cage2, true)
end
------------------------------------
-------------声音恶搞---------------
------------------------------------	
function laughsound(pid)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local voice = "A_F_M_EASTSA_01_LATINO_FULL_01"
    local speech = "FEMALE_DISTANT_LAUGH"
    local z_off = 0
    if PED.IS_PED_IN_ANY_VEHICLE(target_ped, false) then 
        z_off = get_model_size(ENTITY.GET_ENTITY_MODEL(PED.GET_VEHICLE_PED_IS_IN(target_ped, false))).z
    end
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, 0.0, -1.0, 0.0 + z_off)
    request_model_load(util.joaat("s_f_m_shop_high"))
    local voice_ped = entities.create_ped(28, util.joaat("s_f_m_shop_high"), coords, 0)
    ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(voice_ped, true, false)
    ENTITY.SET_ENTITY_VISIBLE(voice_ped, false, 0)
    ENTITY.FREEZE_ENTITY_POSITION(voice_ped, true)
    ENTITY.SET_ENTITY_INVINCIBLE(voice_ped, true)
    AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(voice_ped, speech, voice, "SPEECH_PARAMS_FORCE", 0)
    util.yield(1500)
    entities.delete_by_handle(voice_ped)
end

function stcnm(pid)
    AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "SPAWN", PLAYER.GET_PLAYER_PED(pid), "BARRY_01_SOUNDSET", true, 2)
    AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "External_Explosion", PLAYER.GET_PLAYER_PED(pid), "Methamphetamine_Job_Sounds", true, 1)
end

function phonesoundcnm(pid)
    AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Menu_Accept", PLAYER.GET_PLAYER_PED(pid), "Phone_SoundSet_Default", true, 2)
end

function textspoof(pid)
    if index == 1 then
        for i=1, #sexts do
            send_player_label_sms(sexts[i], pid)
        end
    else
        for i=1, 100 do
            send_player_label_sms(all_labels[math.random(1, #all_labels)], pid)
            util.yield()
        end
    end
    util.toast("提交的文本")
end
------------------------------------
-------------作弊者检测-------------
------------------------------------
local interior_stuff = {0, 233985, 169473, 169729, 169985, 170241, 177665, 177409, 185089, 184833, 184577, 163585, 167425, 167169}

function get_transition_state(pid)
    return memory.read_int(memory.script_global(((2689235 + 1) + (pid * 453)) + 230))
end
function get_interior_player_is_in(pid)
    return memory.read_int(memory.script_global(((2689235 + 1) + (pid * 453)) + 243)) 
end

local unreleased_vehicles = {
    "Rhinehart",
    "Sentinel4",
    "Weevil2",
}

local modded_vehicles = {
    "dune2",
    "tractor",
    "dilettante2",
    "asea2",
    "cutter",
    "mesa2",
    "jet",
    "skylift",
    "policeold1",
    "policeold2",
    "armytrailer2",
    "towtruck",
    "towtruck2",
    "cargoplane",
}

local modded_weapons = {
    "weapon_railgun",
    "weapon_stungun",
    "weapon_digiscanner",
}
--玩家无敌检测
function god_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(player, false)
        for i, interior in ipairs(interior_stuff) do
            if (players.is_godmode(pid) or not ENTITY._GET_ENTITY_CAN_BE_DAMAGED(player)) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(player) and get_transition_state(pid) ~= 0 and get_interior_player_is_in(pid) == interior then
                util.draw_debug_text(players.get_name(pid) .. " 是无敌玩家,很有可能是作弊者")
                break
            end
        end
    end  
end
--车辆无敌检测
function cargod_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(player, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(player)
        if PED.IS_PED_IN_ANY_VEHICLE(player, false) then
            for i, interior in ipairs(interior_stuff) do
                if not ENTITY._GET_ENTITY_CAN_BE_DAMAGED(player_veh) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(player) and get_transition_state(pid) ~= 0 and get_interior_player_is_in(pid) == interior then
                    util.draw_debug_text(players.get_name(pid) .. " 载具处于无敌模式")
                    break
                end
            end
        end
    end 
end
--未发布载具检测
function unreleased_car_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(pid)
        for i, name in ipairs(unreleased_vehicles) do
            if modelHash == util.joaat(name) then
                util.draw_debug_text(players.get_name(pid) .. "正在驾驶未发布的车辆")
            end
        end
    end
end
--无法获得武器检测
function cantgetweapon_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for i, hash in ipairs(modded_weapons) do
            local weapon_hash = util.joaat(hash)
            if WEAPON.HAS_PED_GOT_WEAPON(ped, weapon_hash, false) and WEAPON.IS_PED_ARMED(ped, 7) then
                util.draw_debug_text(players.get_name(pid) .. "正在使用无法获得武器")
                break
            end
        end
    end
end
--无法获得载具检测
function cantgetvar_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(pid)
        for i, name in ipairs(modded_vehicles) do
            if modelHash == util.joaat(name) then
                util.draw_debug_text(players.get_name(pid) .. " 正在驾驶无法获得的载具,很有可能是作弊者")
                break
            end
        end
    end
end
--室内使用武器检测
function usingweapon_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if players.is_in_interior(pid) and WEAPON.IS_PED_ARMED(player, 7) then
            util.draw_debug_text(players.get_name(pid) .. " 正在室内使用武器,极大可能是作弊者")
            break
        end
    end
end
--超级驾驶检测
function supercar_detection()
for _, pid in ipairs(players.list(false, true, true)) do
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
    local veh_speed = (ENTITY.GET_ENTITY_SPEED(vehicle)* 2.236936)
    local class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
    if class ~= 15 and class ~= 16 and veh_speed >= 180 and VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1) and players.get_vehicle_model(pid) ~= util.joaat("oppressor") then -- not checking opressor mk1 cus its stinky
        util.toast(players.get_name(pid) .. " 正在使用超级驾驶")
            break
        end
    end
end
--超级跑检测
function superrun_detection()
    for _, pid in ipairs(players.list(true, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local ped_speed = (ENTITY.GET_ENTITY_SPEED(ped)* 2.236936)
        if not util.is_session_transition_active() and get_interior_player_is_in(pid) == 0 and get_transition_state(pid) ~= 0 
        and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_IN_ANY_VEHICLE(ped, false)
        and not TASK.IS_PED_STILL(ped) and not PED.IS_PED_JUMPING(ped) and not ENTITY.IS_ENTITY_IN_AIR(ped) and not PED.IS_PED_CLIMBING(ped) and not PED.IS_PED_VAULTING(ped)
        and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) <= 300.0 and ped_speed > 25 then -- fastest run speed is about 18ish mph but using 25 to give it some headroom to prevent false positives
            util.toast(players.get_name(pid) .. " 是超级跑")
            break
        end
    end
end
--观看检测
function lookingyou_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        for i, interior in ipairs(interior_stuff) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            if not util.is_session_transition_active() and get_transition_state(pid) ~= 0 and get_interior_player_is_in(pid) == interior
            and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped) then
                if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_cam_pos(pid)) < 15.0 and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) > 20.0 then
                    util.toast(players.get_name(pid) .. " 正在观看你")
                    break
                end
            end
        end
    end
end
--传送检测
function tp_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped) then
            local oldpos = players.get_position(pid)
            util.yield(1000)
            local currentpos = players.get_position(pid)
            for i, interior in ipairs(interior_stuff) do
                if v3.distance(oldpos, currentpos) > 500 and oldpos.x ~= currentpos.x and oldpos.y ~= currentpos.y and oldpos.z ~= currentpos.z 
                and get_transition_state(pid) ~= 0 and get_interior_player_is_in(pid) == interior and PLAYER.IS_PLAYER_PLAYING(pid) and players.exists(pid) then
                    util.toast(players.get_name(pid) .. " 刚刚进行了传送")
                end
            end
        end
    end
end
------------------------------------
-----------线上模式服务-------------
------------------------------------
function bitTest(addr, offset)
    return (memory.read_int(addr) & (1 << offset)) ~= 0
end

local function CanSpawnNanoDrone()
	return BitTest(read_global.int(1958711), 23)
end

local function CanUseDrone()
	if not is_player_active(players.user(), true, true) then
		return false
	end
	if util.is_session_transition_active() then
		return false
	end
	if players.is_in_interior(players.user()) then
		return false
	end
	if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
		return false
	end
	if PED.IS_PED_IN_ANY_TRAIN(players.user_ped()) or
	PLAYER.IS_PLAYER_RIDING_TRAIN(players.user()) then
		return false
	end
	if PED.IS_PED_FALLING(players.user_ped()) then
		return false
	end
	if ENTITY.GET_ENTITY_SUBMERGED_LEVEL(players.user_ped()) > 0.3 then
		return false
	end
	if ENTITY.IS_ENTITY_IN_AIR(players.user_ped()) then
		return false
	end
	if PED.IS_PED_ON_VEHICLE(players.user_ped()) then
		return false
	end
	return true
end
--即时纳米无人机
function nanodrone()
    local p_bits = memory.script_global(1958711)
	local bits = memory.read_int(p_bits)
	if CanUseDrone() and not BitTest(bits, 24) then
		TASK.CLEAR_PED_TASKS(players.user_ped())
		memory.write_int(p_bits, SetBit(bits, 24))
		if not CanSpawnNanoDrone() then memory.write_int(p_bits, SetBit(bits, 23)) end
	end
end
--请求豪华直升机
function luxuryhelicopter()
    if NETWORK.NETWORK_IS_SESSION_ACTIVE() and
	not NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_heli_taxi", -1, true, 0) then
		write_global.int(2815059 + 876, 1)
		write_global.int(2815059 + 883, 1)
	end
end
--即时RC匪徒
function bandito()
    write_global.int(2815059 + 6751, 1)
	if not DoesPlayerOwnBandito(players.user()) then
		local address = memory.script_global(1853348 + (players.user() * 834 + 1) + 267 + 284)
		memory.write_int(address, SetBit(memory.read_int(address), 4))
	end
end
--即时遥控RC坦克
function rctank()
    write_global.int(2815059 + 6752, 1)
	if not DoesPlayerOwnMinitank(players.user()) then
		local address = memory.script_global(1853348 + (players.user() * 834 + 1) + 267 + 408 + 2)
		memory.write_int(address, SetBit(memory.read_int(address), 15))
	end
end
------------------------------------
-----------线上模式传送-------------
------------------------------------
local SEC = ENTITY.SET_ENTITY_COORDS
local set = {alert = true}

function tpaven()
    SEC(players.user_ped(), 514.31335, 4750.5264, -68.99592, false, false, false, false)
end

function tpkosatka()
    local kos = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(760))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(760))
    if kos.x ==0 and kos.y ==0 and kos.z ==0 then
        if set.alert then
            util.toast('未找到虎鲸') 
        end
    else    SEC(players.user_ped(), 1561.1543, 385.98312, -49.68535, false, false, false, false)
    end
end

function tpmoc()
    SEC(players.user_ped(), 1103.3782, -3011.6018, -38.999435, false, false, false, false)
end

function tpterro()
    local ter = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(632))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(632))
    if ter.x ==0 and ter.y ==0 and ter.z ==0 then
        if set.alert then
            util.toast('未找到恐霸')
        end
    else    SEC(players.user_ped(), -1421.2347, -3012.9988, -79.04994, false, false, false, false)
    end
end

function tpscargo()
    local cPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(478))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(478))
        if cPickup.x == 0 and cPickup.y == 0 and cPickup.z == 0 then
            if set.alert then
                util.toast('未找到特殊货物')  
            end
        else
            SEC(players.user_ped(), cPickup.x, cPickup.y, cPickup.z, false, false, false, false)
        end
    end

function tpvcargo()
    local vPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(523))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(523))
        if vPickup.x == 0 and vPickup.y == 0 and vPickup.z == 0 then
            if set.alert then
                util.toast('未找到载具货物')
            end
        else
            SEC(players.user_ped(), vPickup.x, vPickup.y, vPickup.z, false, false, false, false)
        end
    end

function tpdesk()
    local pcD = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(521))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(521))
        if pcD.x == 0 and pcD.y == 0 and pcD.z == 0 then
            if set.alert then
                util.toast('未找到电脑')  
            end
        else
                SEC(players.user_ped(), pcD.x- 1.0, pcD.y + 1.0 , pcD.z, false, false, false, false)
        end
    end

function tpmcproduct()
    local pPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(501))
    local hPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(64))
    local bPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(427))
    local plPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(423))
                    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(501))
                    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(64))
                    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(427))
                    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(423))
        if pPickup.x == 0 and pPickup.y == 0 and pPickup.z == 0 then

        elseif pPickup.x ~= 0 and pPickup.y ~= 0 and pPickup.z ~= 0 then
            SEC(players.user_ped(), pPickup.x - 1.5, pPickup.y , pPickup.z, false, false, false, false)
            if set.alert then
                util.toast('传送到摩托帮货物')   
            end
            
        end
        if hPickup.x == 0 and hPickup.y == 0 and hPickup.z == 0 then

        elseif hPickup.x ~= 0 and hPickup.y ~= 0 and hPickup.z ~= 0 then
            SEC(players.user_ped(), hPickup.x- 1.5, hPickup.y, hPickup.z, false, false, false, false)
            if set.alert then
                util.toast('传送到直升机')
            end
        end
        if bPickup.x == 0 and bPickup.y == 0 and bPickup.z == 0 then

        elseif bPickup.x ~= 0 and bPickup.y ~= 0 and bPickup.z ~= 0 then
            SEC(players.user_ped(), bPickup.x, bPickup.y, bPickup.z + 1.0 , false, false, false, false)
            if set.alert then
                util.toast('传送到船')
            end
        end
        if plPickup.x == 0 and plPickup.y == 0 and plPickup.z == 0 then

        elseif plPickup.x ~= 0 and plPickup.y ~= 0 and plPickup.z ~= 0 then
            SEC(players.user_ped(), plPickup.x, plPickup.y + 1.5, plPickup.z - 1, false, false, false, false)
            if set.alert then
                util.toast('传送到飞机')
            end
        else                 
        if set.alert then
            util.toast('未找到摩托帮货物')
        end
    end
end

function tpBSupplies()       
    local sPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(556))
    local dPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(561))
    local fPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(477))
    local plPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(423))
                    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(556))
                    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(561))
                    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(477))
                    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(423))
        if sPickup.x == 0 and sPickup.y == 0 and sPickup.z == 0 then
        elseif sPickup.x ~= 0 and sPickup.y ~= 0 and sPickup.z ~= 0 then
            SEC(players.user_ped(), sPickup.x, sPickup.y + 2.0, sPickup.z - 1.0, false, false, false, false)
            if set.alert then
                util.toast('传送到补给品')
            end
        end
        if dPickup.x == 0 and dPickup.y == 0 and dPickup.z == 0 then
        elseif dPickup.x ~= 0 and dPickup.y ~= 0 and dPickup.z ~= 0 then
            SEC(players.user_ped(), dPickup.x, dPickup.y, dPickup.z, false, false, false, false)
            if set.alert then
                util.toast('传送到沙丘FAV')
            end
        end
        if fPickup.x == 0 and fPickup.y == 0 and fPickup.z == 0 then
        elseif fPickup.x ~= 0 and fPickup.y ~= 0 and fPickup.z ~= 0 then
            SEC(players.user_ped(), fPickup.x, fPickup.y, fPickup.z + 1.0 , false, false, false, false)
            if set.alert then
                util.toast('传送到平板拖车')
            end
        else
             if set.alert then
                util.toast('未找到地堡补给品')
             end
        end
    end

function tppayphone()
    local payPhon = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(817))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(817))
    if payPhon.x == 0 and payPhon.y == 0 and payPhon.z == 0 then
        if set.alert then
            util.toast('未找到公共电话亭')
        end
        else
            SEC(players.user_ped(), payPhon.x, payPhon.y, payPhon.z + 1, false, false, false, false)
    end
end

function tpeed()
    if HUD.DOES_BLIP_EXIST(HUD._GET_CLOSEST_BLIP_OF_TYPE(780)) then
        local eDock = HUD.GET_BLIP_COORDS(HUD._GET_CLOSEST_BLIP_OF_TYPE(780))
        if  eDock.x == 0 and eDock.y == 0 and eDock.z == 0
        then
         if set.alert then
         util.toast('未找到出口码头')
         end
         elseif eDock.x ~= 0 and eDock.y ~= 0 and eDock.z ~= 0 then
             PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), 1169.5736, -2971.932, 5.9021106)
         end
     end
end
------------------------------------
-----------线上模式宣布-------------
------------------------------------
function get_best_mug_target()
    local most = 0
    local mostp = 0
    for k,p in pairs(players.list(true, true, true)) do
        cur_wallet = players.get_wallet(p)
        if cur_wallet > most then
            most = cur_wallet
            mostp = p
        end
    end
    if cur_wallet == nil then
        util.toast("你孤单一人。找不到最佳抢劫目标。")
        return
    end
    if most ~= 0 then
        return PLAYER.GET_PLAYER_NAME(mostp) .. " 钱包里的钱最多($" .. most .. ")。 也许去抢劫他们。"
    else
        util.toast("找不到最佳抢劫目标。")
        return nil
    end
end

function get_poorest_player()
    local least = 10000000000000000
    local leastp = 0
    for k,p in pairs(players.list(true, true, true)) do
        cur_assets = players.get_wallet(p) + players.get_bank(p)
        if cur_assets < least then
            least = cur_assets
            leastp = p
        end
    end
    if cur_assets == nil then
        util.toast("你孤单一人。找不到最穷的玩家。")
        return
    end
    if least ~= 10000000000000000 then
        return PLAYER.GET_PLAYER_NAME(leastp) .. " 是本战局中最穷的玩家!(有$" .. players.get_wallet(leastp) .. " 在他们的钱包里$" .. players.get_bank(leastp) .. " 在银行里!)"
    else
        util.toast("找不到最穷的玩家。")
        return nil
    end
end

function get_richest_player()
    local most = 0
    local mostp = 0
    for k,p in pairs(players.list(false, true, true)) do
        cur_assets = players.get_wallet(p) + players.get_bank(p)
        if cur_assets > most then
            most = cur_assets
            mostp = p
        end
    end
    if cur_assets == nil then
        util.toast("你孤单一人。找不到最富的玩家。")
        return
    end
    if most ~= 0 then
        return PLAYER.GET_PLAYER_NAME(mostp) .. " 是本战局中最富的玩家!(有$" .. players.get_wallet(mostp) .. " 在他们的钱包里$" .. players.get_bank(mostp) .. " 在银行里!)"
    else
        util.toast("找不到最富的玩家。")
        return nil
    end
end

function get_lapdances_amount(pid) 
    return memory.read_int(memory.script_global(1853348 + 1 + (pid * 834) + 205 + 55))
end
function get_prostitutes_solicited(pid)
    return memory.read_int(memory.script_global(1853348 + 1 + (pid * 834) + 205 + 54))
end

function get_horniest_player()
    local highest_horniness = 0
    local horniest = 0
    local most_lapdances = 0
    local most_prostitutes = 0
    for k,p in pairs(players.list(true, true, true)) do
        lapdances = get_lapdances_amount(p)
        prostitutes = get_prostitutes_solicited(p)
        horniness = lapdances + prostitutes
        if horniness > highest_horniness then
            highest_horniness = horniness
            horniest = p
            most_lapdances = lapdances
            most_prostitutes = prostitutes
        end
    end
    if horniness == nil then
        util.toast("你孤单一人。找不到最性奋的玩家。")
        return
    end
    if highest_horniness ~= 0 then
        return PLAYER.GET_PLAYER_NAME(horniest) .. " 是战局中最性奋的玩家!他们的角色招来了 " .. most_prostitutes .. " 妓女,并为 " .. most_lapdances .. " 次脱衣舞付钱!"
    else
        util.toast("找不到最性奋的玩家。")
        return nil
    end
end

end_racism = false
end_homophobia = false
function toxicshit(packet_sender, message_sender, text, team_chat)
    text = string.lower(text)
    local name = players.get_name(message_sender)

    if end_racism and (string.contains(text, "nigg") or string.contains(text, "jew")) then 
        menu.trigger_commands("kick " .. name)
        util.toast(name .. " 说了脏话，自动踢了出去")
    end

    if end_homophobia and (string.contains(text, "fag") or string.contains(text, "tranny")) then 
        menu.trigger_commands("kick " .. name)
        util.toast(name .. " 是同性恋，自动踢了出去")
    end
end
------------------------------------
--------线上模式聊天预设-------------
------------------------------------
local function fake_chat_with_percentage_and_target(action)
    chat.send_message(action .. " ${name}. [||||            ] (25%)", false, true, true)
    util.yield(math.random(500, 3000))
    chat.send_message(action .. " ${name}. [||||||||        ] (50%)", false, true, true)
    util.yield(math.random(500, 3000))
    chat.send_message(action .. " ${name}. [||||||||||||    ] (75%)", false, true, true)
    util.yield(math.random(500, 3000))
    chat.send_message(action .. " ${name}. [||||||||||||||| ] (89%)", false, true, true)
    util.yield(math.random(3000, 5000))
end

local function get_random_joke()
    local joke = 'WIP'
    local in_progress = true
    async_http.init('icanhazdadjoke.com', '', function(data)
        joke = data
    end, function()
        joke = 'FAIL'
    end)
    async_http.add_header('Accept', 'text/plain')
    async_http.dispatch()
    while joke == "WIP" do 
        util.yield()
    end
    return joke
end

chat_presets = {
    ["掉钱袋是没用的"] = "我可以给你钱,但你花在上面的时间得到的钱是没有用的。你最好买一份自己的菜单,然后使用其中的恢复选项。",
    ["Paragon天下第一!"] = "Paragon天下第一!",
    ["BaiBaiScript天下第一!"] = "BaiBaiScript天下第一!",
    ["L + Ratio..."] = "L + ratio + u fell off + ur british + who asked + no u + deez nutz + radio + don't care + caught in 4k + cope + seethe + gg + grow the fuck up + silver elite + ligma + taco bell dorito crunch + think outside the bun bitch",
    ["您购买了2take1 "] = "前途无限"
}

function showrealip()
    chat.send_message("${name}: ${ip} | ${geoip.city}, ${geoip.region}, ${geoip.country}", false, true, true)
end

function chatcrash()
    fake_chat_with_percentage_and_target("崩溃")
    chat.send_message("崩溃失败" .. " ${name}. " .. "原因：用你妈免费stand", false, true, true)
end

function ramdomjokelol()
    local joke = get_random_joke()
    if joke ~= "FAIL" then
        chat.send_message(joke, false, true, true)
    end
end

function fakechathacking()
    fake_chat_with_percentage_and_target("黑入")
    chat.send_message("黑入失败" .. " ${name}. " .. "原因：用你妈免费stand", false, true, true)
end

function loopchatjoke()
    if util.is_session_started() then
        local joke = get_random_joke()
        if joke ~= "FAIL" then
            chat.send_message(joke, false, true, true)
        end
        util.yield(5000)
    end
end
------------------------------------
--------线上随机虚假器-------------
------------------------------------
local alphabet = "abcdefghijklmnopqrstuvwxyzABCEDFGHIJKLMNOPQRSTUVWXYZ0123456789"

local function random_string(length)
    local res = {}
    for i=1, length do 
        res[i] = alphabet[math.random(#alphabet)]
    end
    return table.concat(res)
end

local function random_ip_address()
    local ip = {}
    for i=1, 4 do 
            ip[i] = tostring(math.random(1, 255)) 
    end
    return table.concat(ip, '.')
end

local random_name_spoof = false
function ramdomfakename(on)
    random_name_spoof = on
    if on then 
        menu.trigger_commands("spoofedname " .. random_string(16))
    end
end

local random_ip_spoof = false
function ramdomfakeip(on)
    random_ip_spoof = on
    if on then 
        menu.trigger_commands("spoofedip " .. random_ip_address())
    end
end

local random_rank_spoof = false
function ramdomfakelvl(on)
    random_rank_spoof = on
    if on then 
        menu.trigger_commands("spoofedrank " .. math.random(10000))
    end
end

function spamtextname(on)
    menu.trigger_commands("spamtext " .. random_string(254))
    util.yield(100)
end

util.on_transition_finished(function()
    if random_name_spoof then
        menu.trigger_commands("spoofedname " .. random_string(16))
    end
    if random_ip_spoof then
        menu.trigger_commands("spoofedip " .. random_ip_address())
    end
    if random_rank_spoof then
        menu.trigger_commands("spoofedrank " .. math.random(10000))
    end
end)
------------------------------------
---------线上假钱-------------------
------------------------------------
local new = {}
function new.delay(MS, S, MIN)
    return {ms = MS, s = S, min = MIN}
end
function new.hudSettings(X, Y, ALIGNMENT)
    return {xOffset = X, yOffset = Y, scale = 0.5, alignment = ALIGNMENT, textColour = new.colour( 255, 255, 255 )}
end
cashFakeMoney = 0
bankFakeMoney = 0
fakeMoneyLoopDelay = new.delay(250, 0, 0)
fakeMoneyTransactionPending = true

function generateDelaySettings(root, name, delayTable)
    menu.slider(root, '毫秒', {'JS'..name..'DelayMs'}, '延迟是毫秒、秒和最小值的总和.', 1, 999, delayTable.ms, 1, function(value)
        delayTable.ms = value
    end)
    menu.slider(root, '秒', {'JS'..name..'DelaySec'}, '延迟是毫秒、秒和最小值的总和.', 0, 59, delayTable.s, 1, function(value)
        delayTable.s = value
    end)
    menu.slider(root, '分钟', {'JS'..name..'DelayMin'}, '延迟是毫秒、秒和最小值的总和.', 0, 60, delayTable.min, 1, function(value)
        delayTable.min = value
    end)
end


local function startBusySpinner(message)
    HUD.BEGIN_TEXT_COMMAND_BUSYSPINNER_ON("STRING")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(message)
    HUD.END_TEXT_COMMAND_BUSYSPINNER_ON(5)
end

local function transactionPending()
    if not fakeMoneyTransactionPending then return end
    startBusySpinner('交易处理中')
    util.yield(math.random(1, 1000))
    HUD.BUSYSPINNER_OFF()
end

function addfakemoney()
    HUD._SET_PLAYER_CASH_CHANGE(cashFakeMoney, bankFakeMoney)
    transactionPending()
end

function loopaddfakemoney()
    HUD._SET_PLAYER_CASH_CHANGE(cashFakeMoney, bankFakeMoney)
    transactionPending()
    util.yield(getTotalDelay(fakeMoneyLoopDelay))
end

------------------------------------
---------保险箱监视器----------------
------------------------------------
local Int_PTR = memory.alloc_int()

local function getMPX()
    return 'MP'.. util.get_char_slot() ..'_'
end

local function STAT_GET_INT(Stat)
    STATS.STAT_GET_INT(util.joaat(getMPX() .. Stat), Int_PTR, -1)
    return memory.read_int(Int_PTR)
end

local function getNightclubDailyEarnings()
    local popularity = math.floor(STAT_GET_INT('CLUB_POPULARITY') / 10)
    if popularity == 100 then return 50000
    elseif popularity >= 90 then return 45000
    elseif popularity >= 80 then return 24000
    elseif popularity >= 70 then return 22000
    elseif popularity >= 60 then return 20000
    elseif popularity >= 50 then return 9500
    elseif popularity >= 40 then return 8500
    elseif popularity >= 30 then return 2500
    elseif popularity >= 20 then return 2000
    elseif popularity >= 10 then return 1600
    else return 1500
    end
end

local function getAgencyDailyEarnings(securityContracts)
    if securityContracts >= 200 then return 20000 end
    return math.floor(securityContracts / 5) * 500
end

JS_tbls = {}
do
    JS_tbls.alphaPoints = {0, 87, 159, 207, 255}
end

JS_tbls.safeManagerToggles = {
    {
        name = '夜总会保险箱',
        command = 'SMclub',
        description = '监视夜总会保险箱的现金,这不会影响收入.',
        toggle = true,
        displayText = function()
            return '夜总会现金' ..': '.. STAT_GET_INT('CLUB_SAFE_CASH_VALUE')  / 1000  ..'k / 210k'
        end
    },
    {
        name = '夜总会人气',
        command = 'SMclubPopularity',
        description = '',
        toggle = false,
        displayText = function()
            return '夜总会人气' ..': '.. math.floor(STAT_GET_INT('CLUB_POPULARITY') / 10)  ..'%'
        end
    },
    {
        name = '夜总会每日收入',
        command = 'SMnightclubEarnings',
        description = '夜总会每日收入.\n每日最高收入为1万.',
        toggle = false,
        displayText = function()
            return '夜总会每日收入' ..': '.. getNightclubDailyEarnings() / 1000  ..'k / day'
        end
    },
    {
        name = '游戏厅保险箱',
        command = 'SMarcade',
        description = '监视游戏厅保险箱的现金,这不会影响收入.\n如果您拥有所有街机游戏,则每日最高收入为5000.',
        toggle = true,
        displayText = function()
            return '游戏厅现金' ..': '.. STAT_GET_INT('ARCADE_SAFE_CASH_VALUE') / 1000  ..'k / 100k'
        end
    },
    {
        name = '事务所保险箱',
        command = 'SMagency',
        description = '监视事务所保险箱的现金,这不会影响收入.\n每日最高收入为2万.',
        toggle = true,
        displayText = function()
            return '事务所现金' ..': '.. STAT_GET_INT("FIXER_SAFE_CASH_VALUE") / 1000  ..'k / 250k'
        end
    },
    {
        name = '安保合约',
        command = 'SMsecurity',
        description = '显示您已完成的事务所安保合约的任务数量.',
        toggle = false,
        displayText = function()
            return '安保合约' ..': '.. STAT_GET_INT('FIXER_COUNT')
        end
    },
    {
        name = '事务所每日收入',
        command = 'SMagencyEarnings',
        description = '事务所每日收入.\n如果您已完成200份合约,则每日最高收入为2万',
        toggle = false,
        displayText = function()
            return '事务所每日收入' ..': '.. getAgencyDailyEarnings(STAT_GET_INT('FIXER_COUNT')) / 1000 ..'k / day'
        end
    },
}

function generateHudSettings(root, prefix, settingsTable)
    menu.slider(root, 'X 位置', {prefix..'XPos'}, '', -200, 0, settingsTable.xOffset, 1, function(value)
        settingsTable.xOffset = value
    end)
    menu.slider(root, 'Y 位置', {prefix..'YPos'}, '', -5, 195, settingsTable.yOffset, 1, function(value)
        settingsTable.yOffset = value
    end)
    menu.slider(root, '比例', {prefix..'scale'}, '文字大小', 200, 1500, 500, 1, function(value)
        settingsTable.scale = value / 1000
    end)
    menu.slider(root, '文本对齐', {prefix..'alignment'}, '1居中,2居左,3居右.', 1, 3, settingsTable.alignment, 1, function(value)
        settingsTable.alignment = value
    end)
    menu.colour(root, '文本颜色', {prefix..'colour'}, '设置文本覆盖的颜色.', settingsTable.textColour, true, function(colour)
        settingsTable.textColour = colour
    end)
end

function generateToggles(table, root, reversed)
    for i = 1, #table do
        if not reversed then
            menu.toggle(root, table[i].name, {table[i].command}, table[i].description, function(toggle)
                table[i].toggle = toggle
            end, table[i].toggle)
        else
            menu.toggle(root, table[i].name, {table[i].command}, table[i].description, function(toggle)
                table[i].toggle = not toggle
            end, not table[i].toggle)
        end
    end
end
------------------------------------
---------赌场-----------------------
------------------------------------
local function STAT_GET_INT_MPPLY(Stat)
    STATS.STAT_GET_INT(util.joaat(Stat), Int_PTR, -1)
    return memory.read_int(Int_PTR)
end

local last_LW_seconds = 0
function casinolucky()
    if STAT_GET_INT_MPPLY('mpply_lucky_wheel_usage') < util.current_unix_time_seconds() then util.toast('幸运转盘目前可用') return end
    local secondsLeft = STAT_GET_INT_MPPLY('mpply_lucky_wheel_usage') - util.current_unix_time_seconds()
    local hours = math.floor(secondsLeft / 3600)
    local minutes = math.floor((secondsLeft / 60) % 60)
    local seconds = secondsLeft % 60
    if last_LW_seconds != seconds then
        util.toast((hours < 10 and ('0'.. hours) or hours) ..':'.. (minutes < 10 and ('0'.. minutes) or minutes) ..':'.. (seconds < 10 and ('0'.. seconds) or seconds))
        last_LW_seconds = seconds
    end
end

function casinolp()
    local chips = STAT_GET_INT_MPPLY('mpply_casino_chips_won_gd')
    if chips > 0 then
        util.toast('您赢了' ..' '.. chips ..' '.. '筹码')
    elseif chips < 0 then
        util.toast('您输了' ..' '.. chips * -1 ..' '.. '筹码')
    else
        util.toast('您还没有赢或输任何筹码.')
    end
end
------------------------------------
-----------时间挑战赛---------------
------------------------------------
local function ttTimeToString(time)
    local min = math.floor(time / 60000)
    local sec = (time % 60000) / 1000
    return (min == 0 and '' or min ..'min ') .. sec ..'s'
end

local function tpToBlip(blip)
local pos = HUD.GET_BLIP_COORDS(blip)
local tpEntity = (PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) and my_cur_car or players.user_ped())
ENTITY.SET_ENTITY_COORDS(tpEntity, pos.x, pos.y, pos.z, false, false, false, false)
end

function besttime()
    util.toast('个人最佳记录' ..': '.. ttTimeToString((STAT_GET_INT_MPPLY('mpply_timetrialbesttime'))))
    util.yield(100)
end

function tptotime()
    local ttBlip = HUD._GET_CLOSEST_BLIP_OF_TYPE(430)
    if not HUD.DOES_BLIP_EXIST(ttBlip) then
        util.toast('Couldn\'t find time trial.')
        return
    end
    tpToBlip(ttBlip)
end

function bestrctime()
    util.toast('个人最佳记录' ..': '.. ttTimeToString(STAT_GET_INT_MPPLY('mpply_rcttbesttime')))
    util.yield(100)
end

function tptorctime()
    local ttBlip = HUD._GET_CLOSEST_BLIP_OF_TYPE(673)
    if not HUD.DOES_BLIP_EXIST(ttBlip) then
        util.toast('未能找到RC匪徒时间挑战赛')
        return
    end
    tpToBlip(ttBlip)
end
------------------------------------
-----------阻挡区域-----------------
------------------------------------   


local notifications = true
local blockInProgress = false
function blockAvailable(areaBlocked, areaName)
    if blockInProgress then util.toast('一个阻挡已经在运行') return false end
    if areaBlocked then util.toast(areaName ..' '.. '已被阻挡') return false end
    return true
end

function setBlockStatus(on, areaName)
    if on then
        blockInProgress = true
        startBusySpinner('阻挡中')
        return
    end
    HUD.BUSYSPINNER_OFF()
    if notifications then util.toast('已成功阻挡' ..' '.. areaName ..'.') end
    blockInProgress = false
end

function blocksomewhere()
    local dir = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0, 5.0, 0)
    GRAPHICS._DRAW_SPHERE(dir.x, dir.y, dir.z, 0.3, 52, 144, 233, 0.5)
    if JSkey.is_key_down('VK_B') then
        if blockInProgress then util.toast('一个阻挡已经在运行') return end
        setBlockStatus(true)
        block({dir.x, dir.y, dir.z - 0.6})
        setBlockStatus(false, '区域')
    end
end

------------------------------------
-----------防护选项-----------------
------------------------------------  
function blockstealer()
    if NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
        local ped_netId = memory.script_local("am_gang_call", 63 + 10 + (0 * 7 + 1))
        local sender = memory.script_local("am_gang_call", 287)
        local target = memory.script_local("am_gang_call", 288)
        local player = players.user()

        util.spoof_script("am_gang_call", function()
            if (memory.read_int(sender) ~= player and memory.read_int(target) == player 
            and NETWORK.NETWORK_DOES_NETWORK_ID_EXIST(memory.read_int(ped_netId)) 
            and NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(memory.read_int(ped_netId))) then
                local mugger = NETWORK.NET_TO_PED(memory.read_int(ped_netId))
                entities.delete_by_handle(mugger)
                util.toast("拦截劫匪来自 " .. players.get_name(memory.read_int(sender)))
            end
        end)
    end
end

function blockstealerother()
    if NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
        local ped_netId = memory.script_local("am_gang_call", 63 + 10 + (0 * 7 + 1))
        local sender = memory.script_local("am_gang_call", 287)
        local target = memory.script_local("am_gang_call", 288)
        local player = players.user()

        util.spoof_script("am_gang_call", function()
            if memory.read_int(target) ~= player and memory.read_int(sender) ~= player
            and NETWORK.NETWORK_DOES_NETWORK_ID_EXIST(memory.read_int(ped_netId)) 
            and NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(memory.read_int(ped_netId)) then
                local mugger = NETWORK.NET_TO_PED(memory.read_int(ped_netId))
                entities.delete_by_handle(mugger)
                util.toast("拦截劫匪发送来自 " .. players.get_name(memory.read_int(sender)) .. " to " .. players.get_name(memory.read_int(target)))
            end
        end)
    end
end

function toxicchatlol(state)
    cf = state
    _U_hack_list={}
    while cf do
        util.yield(0)
        for pid=0,31 do
            if pid~= PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID) then
                if players.is_marked_as_attacker(pid,1 << 0x03) or players.is_marked_as_attacker(pid,1 << 0x04) or players.is_marked_as_attacker(pid,1 << 0x05) or players.is_marked_as_attacker(pid,1 << 0x0C) or players.is_marked_as_attacker(pid,1 << 0x0D) or players.is_marked_as_attacker(pid,1 << 0x0E) then
                    if not _U_hack_list[pid+1] then
                        chat.send_message(PLAYER.GET_PLAYER_NAME(pid)..chaofeng,false,true,true)
                        _U_hack_list[pid+1]=true
                    end
                else
                    _U_hack_list[pid+1]=false
                end
            end
        end
    end
end

function removeaddos()
    if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
        menu.trigger_commands("mpmale")
    else
        menu.trigger_commands("mpfemale")
    end
end

function stopallsoundevent()
    for i=-1,100 do
        AUDIO.STOP_SOUND(i)
        AUDIO.RELEASE_SOUND_ID(i)
    end
end

function removeanything()
    local cleanse_entitycount = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) then
            entities.delete_by_handle(ped)
            cleanse_entitycount += 1
        end
    end
    util.toast("已清除" .. cleanse_entitycount .. "个NPC")
    cleanse_entitycount = 0
    for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do
        entities.delete_by_handle(veh)
        cleanse_entitycount += 1
        util.yield()
    end
    util.toast("已清除".. cleanse_entitycount .."个载具")
    cleanse_entitycount = 0
    for _, object in pairs(entities.get_all_objects_as_handles()) do
        entities.delete_by_handle(object)
        cleanse_entitycount += 1
    end
    util.toast("已清除" .. cleanse_entitycount .. "物体")
    cleanse_entitycount = 0
    for _, pickup in pairs(entities.get_all_pickups_as_handles()) do
        entities.delete_by_handle(pickup)
        cleanse_entitycount += 1
    end
    util.toast("已清除" .. cleanse_entitycount .. "可拾取物体")
    local temp = memory.alloc(4)
    for i = 0, 100 do
        memory.write_int(temp, i)
        PHYSICS.DELETE_ROPE(temp)
    end
    util.toast("已清除所有绳索")
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    MISC.CLEAR_AREA_OF_PROJECTILES(pos.x, pos.y, pos.z, 400, 0)
    util.toast("已清除所有投掷物")
end

function loopclearworld()
    MISC.CLEAR_AREA(0,0,0 , 1000000, true, true, true, true)
end

function clearall(index, name)
    util.toast("正在清除"..name:lower().."...")
    local counter = 0
    local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    pluto_switch index do
        case 1:
            for _, ped in ipairs(entities.get_all_peds_as_handles()) do
                if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) and (not NETWORK.NETWORK_IS_ACTIVITY_SESSION() or NETWORK.NETWORK_IS_ACTIVITY_SESSION() and not ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped)) then
                    entities.delete_by_handle(ped)
                    counter += 1
                    util.yield_once()
                end
            end
            break
        case 2:
            for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
                if vehicle ~= PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) and DECORATOR.DECOR_GET_INT(vehicle, "Player_Vehicle") == 0 and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
                    entities.delete_by_handle(vehicle)
                    counter += 1
                end
                util.yield(25)
            end
            break
        case 3:
            for _, object in ipairs(entities.get_all_objects_as_handles()) do
                entities.delete_by_handle(object)
                counter += 1
                util.yield_once()
            end
            break
        case 4:
            for _, pickup in ipairs(entities.get_all_pickups_as_handles()) do
                entities.delete_by_handle(pickup)
                counter += 1
                util.yield_once()
            end
            break
        case 5:
            local temp = memory.alloc(4)
            for i = 0, 101 do
                memory.write_int(temp, i)
                if PHYSICS.DOES_ROPE_EXIST(temp) then
                    PHYSICS.DELETE_ROPE(temp)
                    counter += 1
                end
                util.yield_once()
            end
            break
        case 6:
            local coords = players.get_position(players.user())
            MISC.CLEAR_AREA_OF_PROJECTILES(coords.x, coords.y, coords.z, 1000, 0)
            counter = "所有"
            break
        case 4:
            for i = 0, 99 do
                AUDIO.STOP_SOUND(i)
                util.yield_once()
            end
        break
    end
    util.toast("已清除"..tostring(counter).."个"..name:lower()..".")
end

local ped_limit = 175
function petlimit(amount)
    ped_limit = amount
end

local veh_limit = 200
function vehlimit(amount)
    veh_limit = amount
end

local obj_limit = 750
function objlimit(amount)
    obj_limit = amount
end

local projectile_limit = 25
function projectilelimit(amount)
    projectile_limit = amount
end

function pool_limit()
    local ped_count = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        util.yield()
        if ped ~= players.user_ped() then
            ped_count += 1
        end
        if ped_count >= ped_limit then
            for _, ped in pairs(entities.get_all_peds_as_handles()) do
                util.yield()
                entities.delete_by_handle(ped)
            end
            util.toast("[Stand 提示] 人物池达到上限,正在清理...")
        end
    end
    local veh__count = 0
    for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do
        util.yield()
        veh__count += 1
        if veh__count >= veh_limit then
            for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do
                entities.delete_by_handle(veh)
            end
            util.toast("[Stand 提示] 载具池达到上限,正在清理...")
        end
    end
    local obj_count = 0
    for _, obj in pairs(entities.get_all_objects_as_handles()) do
        util.yield()
        obj_count += 1
        if obj_count >= obj_limit then
            for _, obj in pairs(entities.get_all_objects_as_handles()) do
                util.yield()
                entities.delete_by_handle(obj)
            end
            util.toast("[Stand 提示] 物体池达到上限,正在清理...")
        end
    end
end

function antibadveh()
    local unwanted_vehicles = {"cargoplane", "tug", "jet", "skylift", "towtruck", "towtruck2", "dump"}
        for _, vehicle in ipairs(entities.get_all_vehicles_as_pointers()) do
            for i, name in ipairs(unwanted_vehicles) do
                if entities.get_model_hash(vehicle) == 1043221410 then
                    entities.delete_by_pointer(vehicle)
                    util.toast("阻止不好载具同步")
                end
            end
        end
    end

function blockcrasheffect()
    local coords = ENTITY.GET_ENTITY_COORDS(players.user_ped() , false);
    GRAPHICS.REMOVE_PARTICLE_FX_IN_RANGE(coords.x, coords.y, coords.z, 400)
    GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
end

function blockfireeffect()
    local coords = ENTITY.GET_ENTITY_COORDS(players.user_ped() , false);
    FIRE.STOP_FIRE_IN_RANGE(coords.x, coords.y, coords.z, 100)
    FIRE.STOP_ENTITY_FIRE(players.user_ped())
end

function antianimal()
    if util.spoof_script("am_hunt_the_beast", SCRIPT.TERMINATE_THIS_THREAD) then
        util.toast("检测到《猎杀野兽》事件.已终止此事件...")
    end
end

local cageModels <const> =
{
    "prop_gold_cont_01",
    "prop_gold_cont_01b",
    "prop_feeder1_cr",
    "prop_rub_cage01a",
    "stt_prop_stunt_tube_s",
    "stt_prop_stunt_tube_end",
    "prop_jetski_ramp_01",
    "stt_prop_stunt_tube_xs",
    "prop_fnclink_03e",
    "prop_container_05a",
    "prop_jetski_ramp_01",
    "prop_cs_dumpster_01a",
    "p_v_43_safe_s",
    "bkr_prop_moneypack_03a",
    "prop_elecbox_12"
}

local lastMsg = ""
local lastNotification <const> = newTimer()
local format = "笼子物体来自 %s"

function anticage()
	local myPos = players.get_position(players.user())
	for _, model in ipairs(cageModels) do
		local modelHash <const> =  util.joaat(model)
		local obj = OBJECT.GET_CLOSEST_OBJECT_OF_TYPE(myPos.x,myPos.y,myPos.z, 8.0, modelHash, false, false, false)
		if obj == 0 or not ENTITY.DOES_ENTITY_EXIST(obj) or
		not ENTITY.IS_ENTITY_AT_ENTITY(players.user_ped(), obj, 5.0, 5.0, 5.0, false, true, 0) then
			continue
		end
		local ownerId = get_entity_owner(obj)
		local msg = string.format(format, get_condensed_player_name(ownerId))
		if ownerId ~= players.user() and is_player_active(ownerId, false, false) and
		(lastMsg ~= msg or lastNotification.elapsed() >= 15000) then
			notification(msg, HudColour.blueLight)
			lastMsg = msg
			lastNotification.reset()
		end
		request_control(obj, 1500)
		entities.delete_by_handle(obj)
	end
end

function blocknetwork(on_toggle)
    local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
    local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
    if on_toggle then
        menu.trigger_command(BlockNetEvents)
        notification("已阻止所有网络传输", colors.green)
    else
        menu.trigger_command(UnblockNetEvents)
        notification("关闭阻止网络传输", colors.red)
    end
end

function blockincoming(on_toggle)
    local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
    local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
    if on_toggle then
        menu.trigger_command(BlockIncSyncs)
        notification("开启阻止网络事件传入", colors.green)
    else
        menu.trigger_command(UnblockIncSyncs)
        notification("关闭阻止网络事件传入", colors.red)
    end
end

function blockout(on_toggle)
    if on_toggle then
        notification("开启阻止网络事件传出", colors.green)
        menu.trigger_commands("desyncall on")
    else
        notification("关闭阻止网络事件传出", colors.red)
        menu.trigger_commands("desyncall off")
    end
end

function anticrashmode(on_toggle)
    if on_toggle then
        notification("开启防崩视角", colors.green)
        menu.trigger_commands("anticrashcam on")
        menu.trigger_commands("potatomode on")
    else
        notification("关闭防崩视角", colors.red)
        menu.trigger_commands("anticrashcam off")
        menu.trigger_commands("potatomode off")
    end
end

function chickenmode(on_toggle)
    local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
    local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
    local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
    local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
    if on_toggle then
        notification("开启自闭模式", colors.green)
        menu.trigger_commands("desyncall on")
        menu.trigger_command(BlockIncSyncs)
        menu.trigger_command(BlockNetEvents)
        menu.trigger_commands("anticrashcamera on")
    else
        notification("关闭自闭模式", colors.red)
        menu.trigger_commands("desyncall off")
        menu.trigger_command(UnblockIncSyncs)
        menu.trigger_command(UnblockNetEvents)
        menu.trigger_commands("anticrashcamera off")
    end
end


function bufffff(on)
    menu.trigger_commands("autocage" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("violentfreeze" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("warehousefreeze" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("modelfreeze" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("flameloop" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("waterloop" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("randomloop" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("tossplayers" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("entityStorm" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("atomicbomb" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("rockets" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("stungunloop" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("atomicgunloop" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("pushplayerforward" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("halloween" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("Collection" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("animal" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("dick" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("5gcrash" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("nature" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("scriptevent" .. PLAYER.GET_PLAYER_NAME(pid)) 
    menu.trigger_commands("nicecrash" .. PLAYER.GET_PLAYER_NAME(pid).." 3")
    util.yield(1000)
    menu.trigger_commands("wenyi" .. PLAYER.GET_PLAYER_NAME(pid))
    menu.trigger_commands("tuoche" .. PLAYER.GET_PLAYER_NAME(pid))
    util.yield(1000)
    menu.trigger_commands("badoutfit" .. PLAYER.GET_PLAYER_NAME(pid))
end

------------------------------------
-----------载具恶搞-----------------
------------------------------------  

function log(content)
    if verbose then
        util.log("[BaiBaiScript] " .. content)
    end
end

local function get_ground_z(coords)
    local start_time = os.time()
    while true do
        if os.time() - start_time >= 5 then
            log("未能在5秒内到达地面Z轴高度")
            return nil
        end
        local success, est = util.get_ground_z(coords['x'], coords['y'], coords['z']+2000)
        if success then
            log("成功获得地面 ： " .. est)
            return est
        end
        util.yield()
    end
end

function get_waypoint_coords()
    local coords = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
    if coords['x'] == 0 and coords['y'] == 0 and coords['z'] == 0 then
        return nil
    else
        local estimate = get_ground_z(coords)
        if estimate then
            coords['z'] = estimate
        end
        return coords
    end
end

local function request_control_of_entity(ent)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and util.is_session_started() then
        log("Requesting entity control of " .. ent)
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(ent)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        local st_time = os.time()
        while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) do
            if os.time() - st_time >= 5 then
                log("未能在5秒内请求实体控制(实体 " .. ent .. ")")
                break
            end
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
            util.yield()
        end
    end
end

local function tp_player_car_to_coords(pid, coord)
    local name = PLAYER.GET_PLAYER_NAME(pid)
    if robustmode then
        menu.trigger_commands("spectate" .. name .. " on")
        util.yield(1000)
    end
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    if car ~= 0 then
        request_control_of_entity(car)
        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(car) then
            for i=1, 3 do
                util.toast("成功")
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(car, coord['x'], coord['y'], coord['z'], false, false, false)
            end
        end
    end
end

function tp_all_player_cars_to_coords(coord)
    for k,pid in pairs(players.list(false, true, true)) do
        tp_player_car_to_coords(pid, coord)
    end
end

function tpcartome(pid)
    tp_player_car_to_coords(pid, ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true))
end

function tocartopoint(pid)
    local c = get_waypoint_coords()
    if c ~= nil then
        tp_player_car_to_coords(pid, c)
    end
end

function tptomaze(pid)
    local c = {}
    c.x = -75.261375
    c.y = -818.674
    c.z = 326.17517
    tp_player_car_to_coords(pid, c)
end

function tptounderwater(pid)
    local c = {}
    c.x = 4497.2207
    c.y = 8028.3086
    c.z = -32.635174
    tp_player_car_to_coords(pid, c)
end

function tptohighair(pid)
    local c = {}
    c.x = -75
    c.y = -818
    c.z = 2400
    tp_player_car_to_coords(pid, c)
end

function tolsc(pid)
    local c = {}
    c.x = -353.84512
    c.y = -135.59108
    c.z = 39.009624
    tp_player_car_to_coords(pid, c)
end

function tpscp(pid)
    local c = {}
    c.x = 1642.8401
    c.y = 2570.7695
    c.z = 45.564854
    tp_player_car_to_coords(pid, c)
end

function tocell(pid)
    local c = {}
    c.x = 1737.1896
    c.y = 2634.897
    c.z = 45.56497
    tp_player_car_to_coords(pid, c)
end

vehaset = {invis_aveh = false, vehasel = util.joaat('speedo2') , vehra = 1000}
function vehpushandhit(pid)
    local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
    local pname = PLAYER.GET_PLAYER_NAME(pid)
    local UV = ENTITY.GET_ENTITY_UPRIGHT_VALUE(targets)
    Delcar(targets)
    Streament(vehaset.vehasel)
    if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        SmashCar(vehaset.vehasel, tar1, vehaset.invis_aveh, vehaset.vehra)
        if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
            if set.alert then
                util.toast(pname..  '被粉碎了')
            end
        elseif ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        RamCar(vehaset.vehasel, tar1.x + 15, tar1.y, tar1.z, vehaset.invis_aveh, targets, vehaset.vehra)
            if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
                if set.alert then
                    util.toast(pname.. ' 被碾过了')
                end
        elseif ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        RamCar(vehaset.vehasel, tar1.x - 15, tar1.y, tar1.z, vehaset.invis_aveh, targets, vehaset.vehra)
            if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
                if set.alert then
                    util.toast(pname.. ' 被碾过了')
                end
        elseif ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        RamCar(vehaset.vehasel, tar1.x, tar1.y + 15, tar1.z, vehaset.invis_aveh, targets, vehaset.vehra)
            if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
                if set.alert then
                    util.toast(pname.. ' 被碾过了')
                end
        elseif ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        RamCar(vehaset.vehasel, tar1.x, tar1.y - 15, tar1.z, vehaset.invis_aveh, targets, vehaset.vehra)
            if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
                if set.alert then
                    util.toast(pname.. ' 被碾过了')
                end
        elseif ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        RamCar(vehaset.vehasel, tar1.x - 15, tar1.y - 15, tar1.z, vehaset.invis_aveh, targets, vehaset.vehra)
            if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
                if set.alert then
                    util.toast(pname.. ' 被碾过了')
                end
        elseif ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        RamCar(vehaset.vehasel, tar1.x + 15, tar1.y + 15, tar1.z, vehaset.invis_aveh, targets, vehaset.vehra)
            if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
                if set.alert then
                    util.toast(pname.. ' 被碾过了')
                end
        elseif ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        RamCar(vehaset.vehasel, tar1.x + 15, tar1.y - 15, tar1.z, vehaset.invis_aveh, targets, vehaset.vehra)
            if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
                if set.alert then
                    util.toast(pname.. ' 被碾过了')
                end
        elseif ENTITY.IS_ENTITY_UPRIGHT(targets, UV) then
        RamCar(vehaset.vehasel, tar1.x - 15, tar1.y + 15, tar1.z, vehaset.invis_aveh, targets, vehaset.vehra)
            if ENTITY.IS_ENTITY_UPRIGHT(targets, UV) ==false then
                if set.alert then
                    util.toast(pname.. ' 被碾过了')
                end


        else
            if set.alert then
                util.toast('无法攻击 ' ..pname)
            end

        end
        end
        end
        end
        end
        end
        end
        end
        end
    end
    if not players.exists(pid) then
        if set.alert then
            util.toast('你让他们怒不可遏')
        end
        util.stop_thread()
    end
end

function vehhitcantsee(on)
    vehaset.invis_aveh = on
end

function deleplayercar(pid)
    local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local player_veh = PED.GET_VEHICLE_PED_IS_USING(player)
    if not PED.IS_PED_IN_ANY_VEHICLE(player, true) then
        util.toast("玩家不在载具里. :/")
        return
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(player_veh)
    util.yield(500)
    if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(player_veh) then
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(player_veh, false, false)
        entities.delete_by_handle(player_veh)
    else
        util.toast("无法控制此玩家载具. :/")
    end
end


function give_car_addon(pid, hash, center, ang)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    local pos = ENTITY.GET_ENTITY_COORDS(car, true)
    pos.x = pos['x']
    pos.y = pos['y']
    pos.z = pos['z']
    request_model_load(hash)
    local ramp = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, pos['x'], pos['y'], pos['z'], true, false, false)
    local size = get_model_size(ENTITY.GET_ENTITY_MODEL(car))
    if center then
        ENTITY.ATTACH_ENTITY_TO_ENTITY(ramp, car, 0, 0.0, 0.0, 0.0, 0.0, 0.0, ang, true, true, true, false, 0, true)
    else
        ENTITY.ATTACH_ENTITY_TO_ENTITY(ramp, car, 0, 0.0, size['y']+1.0, 0.0, 0.0, 0.0, ang, true, true, true, false, 0, true)
    end
end

function get_model_size(hash)
    local minptr = memory.alloc(24)
    local maxptr = memory.alloc(24)
    MISC.GET_MODEL_DIMENSIONS(hash, minptr, maxptr)
    min = memory.read_vector3(minptr)
    max = memory.read_vector3(maxptr)
    local size = {}
    size['x'] = max['x'] - min['x']
    size['y'] = max['y'] - min['y']
    size['z'] = max['z'] - min['z']
    size['max'] = math.max(size['x'], size['y'], size['z'])

    memory.free(minptr)
    memory.free(maxptr)

    return size
end

function changemodel(pid)
give_car_addon(pid, util.joaat("h4_prop_h4_loch_monster"), true, -90.0)
end

function tpcartomv1(pid, coord)
    local name = PLAYER.GET_PLAYER_NAME(pid)
    if robustmode then
        menu.trigger_commands("spectate" .. name .. " on")
        util.yield(1000)
    end
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    if car ~= 0 then
        request_control_of_entity(car)
        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(car) then
            for i=1, 3 do
                util.toast("OK")
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(car, coord['x'], coord['y'], coord['z'], false, false, false)
            end
        end
    end
end

function tpcartomv2(coord)
    for k,pid in pairs(players.list(false, true, true)) do
        tpcartomv1(pid, coord)
    end
end













function kick_from_veh(pid)
    log("Kicking " .. pid .. " from vehicle.")
    menu.trigger_commands("vehkick" .. PLAYER.GET_PLAYER_NAME(pid))
end

function npc_jack(target, nearest)
    npc_jackthr = util.create_thread(function(thr)
        local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
        local last_veh = PED.GET_VEHICLE_PED_IS_IN(player_ped, true)
        kick_from_veh(target)
        local st = os.time()
        while not VEHICLE.IS_VEHICLE_SEAT_FREE(last_veh, -1) do
            if os.time() - st >= 10 then
                util.toast("未能在10秒内释放汽车座椅")
                util.stop_thread()
            end
            util.yield()
        end
        local hash = 0x9C9EFFD8
        request_model_load(hash)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_ped, -2.0, 0.0, 0.0)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z']
        local ped = entities.create_ped(28, hash, coords, 30.0)
        ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
        PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
        PED.SET_PED_INTO_VEHICLE(ped, last_veh, -1)
        VEHICLE.SET_VEHICLE_ENGINE_ON(last_veh, true, true, false)
        TASK.TASK_VEHICLE_DRIVE_TO_COORD(ped, last_veh, math.random(1000), math.random(1000), math.random(100), 100, 1, ENTITY.GET_ENTITY_MODEL(last_veh), 786996, 5, 0)
        util.toast("Vehicle jack complete!")
        util.stop_thread()
    end)
end

function is_ped_player(ped)
    if PED.GET_PED_TYPE(ped) >= 4 then
        return false
    else
        return true
    end
end

local vehicle_uses = 0
local ped_uses = 0
local pickup_uses = 0
local player_uses = 0
local object_uses = 0
local robustmode = false

function mod_uses(type, incr)
    -- this func is a patch. every time the script loads, all the toggles load and set their state. in some cases this makes the _uses optimization negative and breaks things. this prevents that.
    if incr < 0 and is_loading then
        -- ignore if script is still loading
        ls_log("Not incrementing use var of type " .. type .. " by " .. incr .. "- script is loading")
        return
    end
    ls_log("Incrementing use var of type " .. type .. " by " .. incr)
    if type == "vehicle" then
        if vehicle_uses <= 0 and incr < 0 then
            return
        end
        vehicle_uses = vehicle_uses + incr
    elseif type == "pickup" then
        if pickup_uses <= 0 and incr < 0 then
            return
        end
        pickup_uses = pickup_uses + incr
    elseif type == "ped" then
        if ped_uses <= 0 and incr < 0 then
            return
        end
        ped_uses = ped_uses + incr
    elseif type == "player" then
        if player_uses <= 0 and incr < 0 then
            return
        end
        player_uses = player_uses + incr
    elseif type == "object" then
        if object_uses <= 0 and incr < 0 then
            return
        end
        object_uses = object_uses + incr
    end
end

local givegun = false
num_attackers = 1
function send_attacker(hash, pid, givegun)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    request_model_load(hash)
    for i=1, num_attackers do
        local attacker = entities.create_ped(28, hash, coords, math.random(0, 270))
        if godmodeatk then
            ENTITY.SET_ENTITY_INVINCIBLE(attacker, true)
        end
        TASK.TASK_COMBAT_PED(attacker, target_ped, 0, 16)
        PED.SET_PED_ACCURACY(attacker, 100.0)
        PED.SET_PED_COMBAT_ABILITY(attacker, 2)
        PED.SET_PED_AS_ENEMY(attacker, true)
        PED.SET_PED_FLEE_ATTRIBUTES(attacker, 0, false)
        PED.SET_PED_COMBAT_ATTRIBUTES(attacker, 46, true)
        if givegun then
            WEAPON.GIVE_WEAPON_TO_PED(attacker, atkgun, 0, false, true)
        end
    end
end

function dispatch_griefer_jesus(target)
    log("Dispatched griefer jesus.")
    griefer_jesus = util.create_thread(function(thr)
        util.toast("Griefer jesus sent!")
        request_model_load(-835930287)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
        coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z']
        local jesus = entities.create_ped(1, -835930287, coords, 90.0)
        ENTITY.SET_ENTITY_INVINCIBLE(jesus, true)
        PED.SET_PED_HEARING_RANGE(jesus, 9999)
	    PED.SET_PED_CONFIG_FLAG(jesus, 281, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(jesus, 5, true)
	    PED.SET_PED_COMBAT_ATTRIBUTES(jesus, 46, true)
        PED.SET_PED_CAN_RAGDOLL(jesus, false)
        WEAPON.GIVE_WEAPON_TO_PED(jesus, util.joaat("WEAPON_RAILGUN"), 9999, true, true)
        TASK.TASK_GO_TO_ENTITY(jesus, target_ped, -1, -1, 100.0, 0.0, 0)
    	TASK.TASK_COMBAT_PED(jesus, target_ped, 0, 16)
        PED.SET_PED_ACCURACY(jesus, 100.0)
        PED.SET_PED_COMBAT_ABILITY(jesus, 2)
        while true do
            local player_coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
            local jesus_coords = ENTITY.GET_ENTITY_COORDS(jesus, false)
            local dist =  MISC.GET_DISTANCE_BETWEEN_COORDS(player_coords['x'], player_coords['y'], player_coords['z'], jesus_coords['x'], jesus_coords['y'], jesus_coords['z'], false)
            if dist > 100 then
                local behind = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, -3.0, 0.0, 0.0)
                ENTITY.SET_ENTITY_COORDS(jesus, behind['x'], behind['y'], behind['z'], false, false, false, false)
            end
            if not ENTITY.DOES_ENTITY_EXIST(jesus) then
                util.toast("Jesus apparently stopped existing. Stopping Jesus thread.")
                util.stop_thread()
            end
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
            if not players.exists(target) then
                util.toast("The player target has been lost. The griefer Jesus thread is stopping.")
                util.stop_thread()
            else
                TASK.TASK_COMBAT_PED(jesus, target_ped, 0, 16)
            end
            util.yield()
        end
    end)
end

function send_aircraft_attacker(vhash, phash, pid)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, 1.0, 0.0, 500.0)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    request_model_load(vhash)
    request_model_load(phash)
    for i=1, num_attackers do
        coords.x = coords.x + i*2
        coords.y = coords.y + i*2
        local aircraft = entities.create_vehicle(vhash, coords, 0.0)
        VEHICLE.CONTROL_LANDING_GEAR(aircraft, 3)
        VEHICLE.SET_HELI_BLADES_FULL_SPEED(aircraft)
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(aircraft, VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(aircraft))
        if godmodeatk then
            ENTITY.SET_ENTITY_INVINCIBLE(aircraft, true)
        end
        for i= -1, VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(vhash) - 2 do
            local ped = entities.create_ped(28, phash, coords, 30.0)
            if i == -1 then
                TASK.TASK_PLANE_MISSION(ped, aircraft, 0, target_ped, 0, 0, 0, 6, 0.0, 0, 0.0, 50.0, 40.0)
            end
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
            PED.SET_PED_INTO_VEHICLE(ped, aircraft, i)
            TASK.TASK_COMBAT_PED(ped, target_ped, 0, 16)
            PED.SET_PED_ACCURACY(ped, 100.0)
            PED.SET_PED_COMBAT_ABILITY(ped, 2)
        end
    end
end

function max_out_car(veh)
    for i=0, 49 do
        num = VEHICLE.GET_NUM_VEHICLE_MODS(veh, i)
        VEHICLE.SET_VEHICLE_MOD(veh, i, num -1, true)
    end
end

function send_groundv_attacker(vhash, phash, pid, givegun)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    request_model_load(vhash)
    local bike_hash = -159126838
    request_model_load(phash)
    for i=1, num_attackers do
        local spawn_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_ped, num_attackers-i, -10.0, 0.0)
        spawn_pos.x = spawn_pos['x']
        spawn_pos.y = spawn_pos['y']
        spawn_pos.z = spawn_pos['z']
        local bike = entities.create_vehicle(vhash, spawn_pos, ENTITY.GET_ENTITY_HEADING(player_ped))
        for i=-1, VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(vhash) - 2 do
            local rider = entities.create_ped(1, phash, spawn_pos, 0.0)
            if i == -1 then
                TASK.TASK_VEHICLE_CHASE(rider, target_ped)
            end
            max_out_car(atkbike)
            PED.SET_PED_INTO_VEHICLE(rider, bike, i)
            WEAPON.GIVE_WEAPON_TO_PED(rider, atkgun, 1000, false, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(rider, 5, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(rider, 46, true)
            TASK.TASK_COMBAT_PED(rider, player_ped, 0, 16)
            if godmodeatk then
                ENTITY.SET_ENTITY_INVINCIBLE(bike, true)
                ENTITY.SET_ENTITY_INVINCIBLE(rider, true)
            end
            if givegun then
                WEAPON.GIVE_WEAPON_TO_PED(rider, atkgun, 0, false, true)
            end
        end
    end
end

good_guns = {453432689, 171789620, 487013001, -1716189206, 1119849093}





local function readWeaponAddress(storeTable, offset, stopIfModified)
    if util.is_session_transition_active() then return 0 end
    local userPed = players.user_ped()
    local weaponHash, vehicleWeapon = getWeaponHash(userPed)

    if stopIfModified and storeTable[weaponHash] then return 0 end

    local pointer = (vehicleWeapon and 0x70 or 0x20)
    local address = address_from_pointer_chain(entities.handle_to_pointer(userPed), {0x10D8, pointer, offset})
    if address == 0 then menu.toast('Failed to find memory address.') return 0 end

    if storeTable[weaponHash] == nil then
        storeTable[weaponHash] = {
            address = address,
            original = memory.read_float(address)
        }
    end
    return weaponHash
end

function resetWeapons(modifiedWeapons)
    for hash, _ in pairs(modifiedWeapons) do
        memory.write_float(modifiedWeapons[hash].address, modifiedWeapons[hash].original)
        modifiedWeapons[hash] = nil
    end
end

--武器设置


modifiedRecoil = {}
function gunpro()
    local weaponHash = readWeaponAddress(modifiedRecoil, 0x2F4, true)
    if weaponHash == 0 then return end
    memory.write_float(modifiedRecoil[weaponHash].address, 0)
end

modifiedRange = {}
function maxrange()
    if util.is_session_transition_active() then return end
    local userPed = players.user_ped()
    local weaponHash, vehicleWeapon = getWeaponHash(userPed)
    if modifiedRange[weaponHash] then return end
    local pointer = (vehicleWeapon and 0x70 or 0x20)
    local userPedPointer = entities.handle_to_pointer(userPed)
    modifiedRange[weaponHash] = {
        minAddress   = address_from_pointer_chain(userPedPointer, {0x10D8, pointer, 0x298}),
        maxAddress   = address_from_pointer_chain(userPedPointer, {0x10D8, pointer, 0x29C}),
        rangeAddress = address_from_pointer_chain(userPedPointer, {0x10D8, pointer, 0x28C}),
    }

    if modifiedRange[weaponHash].minAddress == 0 or modifiedRange[weaponHash].maxAddress == 0 or modifiedRange[weaponHash].rangeAddress == 0 then menu.toast('Failed to find memory address.') return end

    modifiedRange[weaponHash].originalMin   = memory.read_float(modifiedRange[weaponHash].minAddress)
    modifiedRange[weaponHash].originalMax   = memory.read_float(modifiedRange[weaponHash].maxAddress)
    modifiedRange[weaponHash].originalRange = memory.read_float(modifiedRange[weaponHash].rangeAddress)

    memory.write_float(modifiedRange[weaponHash].minAddress,   150000)  --because the map is about 15km tall
    memory.write_float(modifiedRange[weaponHash].maxAddress,   150000)
    memory.write_float(modifiedRange[weaponHash].rangeAddress, 150000)
end

modifiedSpread = {}
function nospread()
    local weaponHash = readWeaponAddress(modifiedSpread, 0x74, true)
    if weaponHash == 0 then return end
    memory.write_float(modifiedSpread[weaponHash].address, 0)
end

modifiedSpinup = {
    [1] = {hash = util.joaat('weapon_minigun')},
    [2] = {hash = util.joaat('weapon_rayminigun')},
}

function nospinup()
    local weaponHash = WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped())
    for i = 1, #modifiedSpinup do
        if weaponHash == modifiedSpinup[i].hash then
            modifiedSpinup[i].address = address_from_pointer_chain(entities.handle_to_pointer(players.user_ped()), {0x10D8, 0x20, 0x144})
            if modifiedSpinup[i].address == 0 then return end
            memory.write_float(modifiedSpinup[i].address, 0)
        end
    end
end

modifiedCarForce = {}
modifiedHeliForce = {}
modifiedPedForce = {}
function damagemoded()
    local weaponHash = readWeaponAddress(modifiedCarForce, 0x0E0, false)
    if weaponHash == 0 then return end
    memory.write_float(modifiedCarForce[weaponHash].address, modifiedCarForce[weaponHash].original * 99999999999999)

    weaponHash = readWeaponAddress(modifiedHeliForce, 0x0E4, false)
    if weaponHash == 0 then return end
    memory.write_float(modifiedHeliForce[weaponHash].address, modifiedHeliForce[weaponHash].original * 99999999999999)

    weaponHash = readWeaponAddress(modifiedPedForce, 0x0DC, false)
    if weaponHash == 0 then return end
    memory.write_float(modifiedPedForce[weaponHash].address, modifiedPedForce[weaponHash].original * 99999999999999)
end

extraZoom2 = 0
modifiedAimFov = {}
function gunzoom()
    JSkey.disable_control_action(0, 'INPUT_SNIPER_ZOOM_IN_ONLY')
        JSkey.disable_control_action(0, 'INPUT_SNIPER_ZOOM_OUT_ONLY')

        if not JSkey.is_control_pressed(0, 'INPUT_AIM') then
            extraZoom2 = 0
            return
        end

        local step = if extraZoom2 > 60 or extraZoom2 < -5 then 3 else 6

        if not (extraZoom2 <= -35) and JSkey.is_disabled_control_just_pressed(0, 'INPUT_SNIPER_ZOOM_IN_ONLY') then
            extraZoom2 -= step
        elseif not (extraZoom2 >= 100) and JSkey.is_disabled_control_just_pressed(0, 'INPUT_SNIPER_ZOOM_OUT_ONLY') then
            extraZoom2 += step
        end

        local weaponHash = readWeaponAddress(modifiedAimFov, 0x2FC, false)
        if weaponHash == 0 then return end
        memory.write_float(modifiedAimFov[weaponHash].address, modifiedAimFov[weaponHash].original + extraZoom2)
    end

extraZoom = 0
modifiedZoomFov = {}
function enablezoomfov()
    local weaponHash = readWeaponAddress(modifiedZoomFov, 0x410, false)
    if weaponHash == 0 then return end
    memory.write_float(modifiedZoomFov[weaponHash].address,  modifiedZoomFov[weaponHash].original + extraZoom)
end

function zoomaimfov(value)
    extraZoom = (value - 100) / 100
    modifiedZoomWeapon = nil
end


function entity_control_all(menu_parent, ent)
    menu.action(menu_parent, "检测该实体是否存在", {}, "", function()
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            util.toast("实体存在")
        else
            util.toast("该实体已经不存在，请删除此条实体记录！")
        end
    end)
    menu.action(menu_parent, "删除此条实体记录", {}, "", function()
        menu.delete(menu_parent)
        clearTableValue(control_ent_menu_list, menu_parent)
        clearTableValue(control_ent_list, ent)
    end)
    --- ---
    menu.divider(menu_parent, "Entity")

    menu.toggle(menu_parent, "无敌", {}, "", function(toggle)
        ENTITY.SET_ENTITY_INVINCIBLE(ent, toggle)
        ENTITY.SET_ENTITY_PROOFS(ent, toggle, toggle, toggle, toggle, toggle, toggle, toggle, toggle)
    end)
    menu.toggle(menu_parent, "冻结", {}, "", function(toggle)
        ENTITY.FREEZE_ENTITY_POSITION(ent, toggle)
    end)
    --- ---
    menu.divider(menu_parent, "血量")
    menu.action(menu_parent, "获取当前血量", {}, "", function()
        util.toast("当前血量: " .. ENTITY.GET_ENTITY_HEALTH(ent))
    end)
    local control_ent_health = 1000
    menu.slider(menu_parent, "血量", { "control_ent_health" }, "", 0, 30000, 1000, 100, function(value)
        control_ent_health = value
    end)
    menu.action(menu_parent, "设置血量", {}, "", function()
        ENTITY.SET_ENTITY_HEALTH(ent, control_ent_health)
    end)
    --- ---
    menu.divider(menu_parent, "移动")
    menu.click_slider(menu_parent, "前/后移动", {}, "", -100, 100, 0, 1, function(value)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, value, 0.0)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.click_slider(menu_parent, "左/右移动", {}, "", -100, 100, 0, 1, function(value)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, value, 0.0, 0.0)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.click_slider(menu_parent, "上/下移动", {}, "", -100, 100, 0, 1, function(value)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, 0.0, value)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.click_slider(menu_parent, "朝向", {}, "", -360, 360, 0, 10, function(value)
        local head = ENTITY.GET_ENTITY_HEADING(ent)
        ENTITY.SET_ENTITY_HEADING(ent, head + value)
    end)
    --- ---
    menu.divider(menu_parent, "传送")
    menu.click_slider(menu_parent, "传送到我面前", {}, "", -10, 10, 2, 1, function(value)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, value, 0.0)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.toggle_loop(menu_parent, "锁定传送在我头上", {}, "", function()
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 0.0, 2.0)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.action(menu_parent, "离我的距离", {}, "", function()
        local my_pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        local ent_pos = ENTITY.GET_ENTITY_COORDS(ent)
        util.toast(vect.dist(my_pos, ent_pos))
    end)

    menu.click_slider(menu_parent, "最大速度", { "control_ent_max_speed" }, "", 0.0, 1000.0, 30.0, 10.0, function(value)
        ENTITY.SET_ENTITY_MAX_SPEED(ent, value)
    end)

end

--- PED entity type functions ---
function entity_control_ped(menu_parent, ped)
    menu.divider(menu_parent, "Ped")

    menu.action(menu_parent, "传送到我的载具", {}, "", function()
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
        if vehicle then
            if VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
                PED.SET_PED_INTO_VEHICLE(ped, vehicle, -2)
            end
        end
    end)

    menu.action(menu_parent, "移除全部武器", {}, "", function()
        WEAPON.REMOVE_ALL_PED_WEAPONS(ped)
    end)

  
    menu.action_slider(menu_parent, "给予武器", {}, "", weapon_list, function(value)
        local weaponHash = util.joaat(weapon_list_model[value])
        WEAPON.GIVE_WEAPON_TO_PED(ped, weaponHash, -1, false, true)
        WEAPON.SET_CURRENT_PED_WEAPON(ped, weaponHash, false)
    end)

    menu.action(menu_parent, "一键无敌强化NPC", {}, "适用于友方NPC", function()
        ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
        ENTITY.SET_ENTITY_PROOFS(ped, true, true, true, true, true, true, true, true)
        PED.SET_PED_CAN_RAGDOLL(ped, false)

        PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
        PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(ped, 500.0)
        PED.SET_PED_SEEING_RANGE(ped, 500.0)
        PED.SET_PED_HEARING_RANGE(ped, 500.0)

        WEAPON.SET_PED_INFINITE_AMMO_CLIP(ped, true)
        PED.SET_PED_SHOOT_RATE(ped, 1000.0)
        PED.SET_PED_ACCURACY(ped, 100.0)
        PED.SET_PED_CAN_BE_SHOT_IN_VEHICLE(ped, true)

        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true) --AlwaysFight
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 12, true) --BlindFireWhenInCover
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 27, true) --PerfectAccuracy
        PED.SET_PED_COMBAT_MOVEMENT(ped, 2)
        PED.SET_PED_COMBAT_ABILITY(ped, 2)
        PED.SET_PED_COMBAT_RANGE(ped, 2)
        PED.SET_PED_TARGET_LOSS_RESPONSE(ped, 1)
        PED.SET_COMBAT_FLOAT(ped, 10, 500.0)
        util.toast("Done")
    end)

end

--- VEHICLE entity type functions ---
function entity_control_vehicle(menu_parent, vehicle)
    menu.divider(menu_parent, "Vehicle")

    menu.action(menu_parent, "踢出载具内NPC", {}, "", function()
        local seats = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(vehicle)
        for k = -1, seats do
            local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, k)
            if ped > 0 then
                PED.SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(ped, KNOCKOFFVEHICLE_EASY)
                PED.KNOCK_PED_OFF_VEHICLE(ped)
            end
        end
    end)

    menu.action(menu_parent, "拆下车门", {}, "", function()
        for i = 0, 3 do
            VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, i, false)
        end
    end)

    menu.toggle(menu_parent, "车门开关", {}, "", function(toggle)
        if toggle then
            for i = 0, 3 do
                VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, i, false, false)
            end
        else
            VEHICLE.SET_VEHICLE_DOORS_SHUT(vehicle, false)
        end
    end)

    menu.toggle(menu_parent, "车门锁", {}, "", function(toggle)
        if toggle then
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 2)
        else
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 1)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, players.user(), false)
        end
    end)

    menu.click_slider(menu_parent, "向前的速度", { "control_veh_forward_speed" }, "", 0.0, 1000.0, 30.0, 10.0, function(value)
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, value)
    end)

    menu.action(menu_parent, "修复载具", {}, "", function()
        VEHICLE.SET_VEHICLE_FIXED(vehicle)
        VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, 1000.0)
    end)
end



local function get_offset_from_gameplay_camera(distance)
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = v3.toDir(cam_rot)
    local destination = v3(direction)
    destination:mul(distance)
    destination:add(cam_pos)

    return destination
end

local function raycast_gameplay_cam(distance)
    local result = {}
    local didHit = memory.alloc(1)
    local endCoords = v3()
    local surfaceNormal = v3()
    local hitEntity = memory.alloc_int()

    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = v3.toDir(cam_rot)

    local destination = v3(direction)
    destination:mul(distance)
    destination:add(cam_pos)

    local handle = SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(cam_pos.x, cam_pos.y, cam_pos.z, destination.x, destination.y, destination.z, -1, players.user_ped(), 4)
    SHAPETEST.GET_SHAPE_TEST_RESULT(handle, didHit, memory.addrof(endCoords), memory.addrof(surfaceNormal), hitEntity)

    result.didHit = memory.read_byte(didHit) ~= 0
    result.endCoords = endCoords
    result.surfaceNormal = surfaceNormal
    result.hitEntity = memory.read_int(hitEntity)
    return result
end

local function direction(offset)
    local c1 = get_offset_from_gameplay_camera(offset or 5)
    local res = raycast_gameplay_cam(1000)
    local c2

    if res.didHit then
        c2 = res.endCoords
    else
        c2 = get_offset_from_gameplay_camera(1000)
    end
    c2:sub(c1)
    c2:mul(1000)

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

local launcherThrowable = util.joaat('weapon_grenade')
local throwables_launcher
function throwablebullet(toggle)
    throwables_launcher = toggle
    util.create_tick_handler(function()
        if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) == -1568386805 then --if holding grenade launcher
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if not remove_projectiles then
                    remove_projectiles = true
                    disableProjectileLoop(-1568386805)
                end
                util.create_thread(function()
                    local currentWeapon = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped(), false)
                    local pos1 = ENTITY._GET_ENTITY_BONE_POSITION_2(currentWeapon, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(currentWeapon, 'gun_muzzle'))
                    local pos2 = get_offset_from_gameplay_camera(30)
                    if not WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), launcherThrowable, false) then
                        WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), launcherThrowable, 9999, false, false)
                    end
                    util.yield()
                    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z, 200, true, launcherThrowable, players.user_ped(), true, false, 2000.0)
                end)
            else
                remove_projectiles = false
            end
        else
            remove_projectiles = false
        end
        return throwables_launcher
    end)
end

--this function is from wiriScripts functions
    local function pairsByKeys(t, f)
        local a = {}
        for n in pairs(t) do table.insert(a, n) end
        table.sort(a, f)
        local i = 0
        local iter = function()
            i += 1
            if a[i] == nil then return nil
            else return a[i], t[a[i]]
            end
        end
        return iter
    end

function getLabelTableFromKeys(keyTable)
    local labelTable = {}
    for k, v in pairsByKeys(keyTable) do
        table.insert(labelTable, {k})
    end
    return labelTable
end

function bulletset(text)
    launcherThrowable = throwablesTable[text]
end


function menu.mutually_exclusive_toggle(root, name, commands, help, exclusive_toggles, func)
    local this_toggle
    this_toggle = menu.toggle(root, name, commands, help, function(toggle)
        if toggle then
            for _, ref in pairs(exclusive_toggles) do
                if ref != this_toggle and menu.get_value(ref) then
                    menu.set_value(ref, false)
                end
            end
        end
        func(toggle)
    end)
    return this_toggle
end

local function executeNuke(pos)
    for a = 0, nuke_height, 4 do
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z + a, 8, 10, true, false, 1, false)
        util.yield(50)
    end
    FIRE.ADD_EXPLOSION(pos.x +8, pos.y +8, pos.z + nuke_height, 82, 10, true, false, 1, false)
    FIRE.ADD_EXPLOSION(pos.x +8, pos.y -8, pos.z + nuke_height, 82, 10, true, false, 1, false)
    FIRE.ADD_EXPLOSION(pos.x -8, pos.y +8, pos.z + nuke_height, 82, 10, true, false, 1, false)
    FIRE.ADD_EXPLOSION(pos.x -8, pos.y -8, pos.z + nuke_height, 82, 10, true, false, 1, false)
end

mutually_exclusive_weapons  = {}
local nuke_gun_option
function nukegunmode(toggle)
    uke_gun_option = toggle
    util.create_tick_handler(function()
        if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) == -1312131151 then --if holding homing launcher
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if not remove_projectiles then
                    remove_projectiles = true
                    disableProjectileLoop(-1312131151)
                end
                util.create_thread(function()
                    local hash = util.joaat('w_arena_airmissile_01a')
                    loadModel(hash)

                    local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
                    local dir, pos = direction()

                    local bomb = entities.create_object(hash, pos)
                    ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
                    ENTITY.SET_ENTITY_ROTATION(bomb, cam_rot.x, cam_rot.y, cam_rot.z, 1, true)

                    while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do
                        util.yield()
                    end
                    local nukePos = ENTITY.GET_ENTITY_COORDS(bomb, true)
                    entities.delete_by_handle(bomb)
                    executeNuke(nukePos)
                end)
            else
                remove_projectiles = false
            end
        else
            remove_projectiles = false
        end
        return nuke_gun_option
    end)
end

local function get_waypoint_v3()
    if HUD.IS_WAYPOINT_ACTIVE() then
        local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
        local waypoint_pos = HUD.GET_BLIP_COORDS(blip)

        local success, Zcoord = util.get_ground_z(waypoint_pos.x, waypoint_pos.y)
        local tries = 0
        while not success or tries <= 100 do
            success, Zcoord = util.get_ground_z(waypoint_pos.x, waypoint_pos.y)
            tries += 1
            util.yield()
        end
        if success then
            waypoint_pos.z = Zcoord
        end

        return waypoint_pos
    else
        util.toast('没有设置标记点')
    end
end

function nukepoint()
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
            util.yield()
        end
        entities.delete_by_handle(bomb)
        executeNuke(waypointPos)
    end
end

nuke_height = 40
function nukeheight(value)
    nuke_height = value
end

local disable_firing = false
local function disableFiringLoop()
    util.create_tick_handler(function()
        PLAYER.DISABLE_PLAYER_FIRING(players.user_ped(), true)
        return disable_firing
    end)
end

local exp_animal = 'a_c_killerwhale'
local explosive_animal_gun
function expaniamlgun(toggle)
    explosive_animal_gun = toggle
    while explosive_animal_gun do
        local weaponHash = WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped())
        local weaponType = WEAPON.GET_WEAPON_DAMAGE_TYPE(weaponHash)
        if weaponType == 3 or (weaponType == 5 and WEAPON.GET_WEAPONTYPE_GROUP(weaponHash) != 1548507267) then --weapons that shoot bullets or explosions and isn't in the throwables category (grenades, proximity mines etc...)
            disable_firing = true
            disableFiringLoop()
            if JSkey.is_disabled_control_pressed(2, 'INPUT_ATTACK') and PLAYER.IS_PLAYER_FREE_AIMING(players.user_ped()) then
                util.create_thread(function()
                    local hash = util.joaat(exp_animal)
                    loadModel(hash)

                    local dir, c1 = direction()
                    local animal = entities.create_ped(28, hash, c1, 0)
                    local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)

                    ENTITY.APPLY_FORCE_TO_ENTITY(animal, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
                    ENTITY.SET_ENTITY_ROTATION(animal, cam_rot.x, cam_rot.y, cam_rot.z, 1, true)

                    while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(animal) do
                        util.yield()
                    end
                    local animalPos = ENTITY.GET_ENTITY_COORDS(animal, true)
                    entities.delete_by_handle(animal)
                    FIRE.ADD_EXPLOSION(animalPos.x, animalPos.y,animalPos.z, 1, 10, true, false, 1, false)
                end)
            end
        else
            disable_firing = false
        end
        util.yield(200)
    end
    disable_firing = false
end

function setanimal(text)
    exp_animal = animalsTable[text]
end

local impactCords = v3.new()
local blocks = {}
function xxxminecraftgun()
    if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), impactCords) then
        local hash = util.joaat('prop_mb_sandblock_01')
        loadModel(hash)
        blocks[#blocks + 1] = entities.create_object(hash, impactCords)
    end
end

function deleminecraftlastblock()
    if blocks[#blocks] != nil then
        entities.delete_by_handle(blocks[#blocks])
        blocks[#blocks] = nil
    end
end

function deleallblock()
    for i = 1, #blocks do
        entities.delete_by_handle(blocks[i])
        blocks[i] = nil
    end
end

local flameThrower = {
    colour = mildOrangeFire
}

function flamegun()
    if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) != 1119849093 or not JSkey.is_control_pressed(2, 'INPUT_AIM') then
        if not flameThrower.ptfx then return end

        GRAPHICS.REMOVE_PARTICLE_FX(flameThrower.ptfx, true)
        STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
        flameThrower.ptfx = nil
        return
    end

    PLAYER.DISABLE_PLAYER_FIRING(players.user_ped(), true)

    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do
        STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
        util.yield()
    end
    GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
    if flameThrower.ptfx == nil then
        flameThrower.ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE('muz_xs_turret_flamethrower_looping', WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped()), 0.8, 0, 0, 0, 0, 270, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped()), 'Gun_Nuzzle'), 0.5, false, false, false)
        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(flameThrower.ptfx, flameThrower.colour.r, flameThrower.colour.g, flameThrower.colour.b)
    end
end

function get_offset_from_cam(dist)
	local rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
	local pos = CAM.GET_FINAL_RENDERED_CAM_COORD()
	local dir = rot:toDir()
	dir:mul(dist)
	local offset = v3.new(pos)
	offset:add(dir)
	return offset
end

function get_vehicles_in_player_range(player, radius)
	local vehicles = {}
	local pos = players.get_position(player)
	for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
		local vehPos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
		if pos:distance(vehPos) <= radius then table.insert(vehicles, vehicle) end
	end
	return vehicles
end

function magnetgun()
    if not PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then return end
	local numVehicles = 0
	local offset = get_offset_from_cam(30.0)
	local vehicles <const> = get_vehicles_in_player_range(players.user(), 70.0)

	for _, vehicle in ipairs(vehicles) do
		if PED.GET_VEHICLE_PED_IS_USING(players.user_ped()) ~= vehicle and
		numVehicles < 20 and request_control_once(vehicle) then
			numVehicles = numVehicles + 1
			local vehiclePos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
			local vect = v3.new(offset)
			vect:sub(vehiclePos)
			if selectedOpt == 1 then
				ENTITY.SET_ENTITY_VELOCITY(vehicle, vect.x,vect.y,vect.z)

			elseif selectedOpt == 2 then
				vect:mul(0.5)
				ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, vect.x,vect.y,vect.z, 0.0, 0.0, 0.5, 0, false, false, true, false, false)
			end
		end
	end
end

function setmagnetgun(index)
    selectedOpt = index
end

local HitEffect = {colorCanChange = false}
HitEffect.__index = HitEffect
setmetatable(HitEffect, Effect)

function HitEffect.new(asset, name, colorCanChange)
	local inst = setmetatable({}, HitEffect)
	inst.name = name
	inst.asset = asset
	inst.colorCanChange = colorCanChange or false
	return inst
end

local hitEffects <const> = {
	HitEffect.new("scr_rcbarry2", "scr_exp_clown"),
	HitEffect.new("scr_rcbarry2", "scr_clown_appears"),
	HitEffect.new("scr_rcpaparazzo1", "scr_mich4_firework_trailburst_spawn", true),
	HitEffect.new("scr_indep_fireworks", "scr_indep_firework_starburst", true),
	HitEffect.new("scr_indep_fireworks", "scr_indep_firework_fountain", true),
	HitEffect.new("scr_rcbarry1", "scr_alien_disintegrate"),
	HitEffect.new("scr_rcbarry2", "scr_clown_bul"),
	HitEffect.new("proj_indep_firework", "scr_indep_firework_grd_burst"),
	HitEffect.new("scr_rcbarry2", "muz_clown"),
}
hiteffectchinese = {
	{"小丑爆炸"},
	{"小丑出现"},
	{"开拓者FW"},
	{"星爆FW"},
	{"喷泉FW"},
	{"外星解体"},
	{"小丑花"},
	{"地面冲击波FW"},
	{"小丑木兹"},
}

effectColour = {r = 0.5, g = 0.0, b = 0.5, a = 1.0}

function shootingeffect()
    local effect = hitEffects[selectedOpt]
	if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(effect.asset) then
		return STREAMING.REQUEST_NAMED_PTFX_ASSET(effect.asset)
	end

	local hitCoords = v3.new()
	if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), memory.addrof(hitCoords)) then
		local raycastResult = get_raycast_result(1000.0)
		local rot = raycastResult.surfaceNormal:toRot()
		GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)

		if effect.colorCanChange then
			local colour = effectColour
			GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour.r, colour.g, colour.b)
		end
		GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
			effect.name, hitCoords.x,hitCoords.y,hitCoords.z, rot.x - 90.0, rot.y, rot.z, 1.0, false, false, false, false)
	end
end

function sethiteffect(opt)
    selectedOpt = opt
end

function friendshipgun(toggle)
    PED.SET_CAN_ATTACK_FRIENDLY(players.user_ped(), toggle, false)
end

function get_entity_player_is_aiming_at(player)
	if not PLAYER.IS_PLAYER_FREE_AIMING(player) then
		return NULL
	end
	local entity, pEntity = NULL, memory.alloc_int()
	if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(player, pEntity) then
		entity = memory.read_int(pEntity)
	end
	if entity ~= NULL and ENTITY.IS_ENTITY_A_PED(entity) and PED.IS_PED_IN_ANY_VEHICLE(entity, false) then
		entity = PED.GET_VEHICLE_PED_IS_IN(entity, false)
	end
	return entity
end

function magnetents()
    local entity = get_entity_player_is_aiming_at(players.user())
	if entity ~= 0 and ENTITY.DOES_ENTITY_EXIST(entity) then
		draw_bounding_box(entity, true, {r = 255, g = 255, b = 255, a = 81})

		if PED.IS_PED_SHOOTING(players.user_ped()) and
		not (shotEntities[1] and shotEntities[1] == entity) then
			counter = counter + 1
			shotEntities[counter] = entity
		end

		if counter == 2 then
			local entPair = EntityPair.new(table.unpack(shotEntities))
			table.insert_once(entityPairs, entPair)
			counter = 0
			shotEntities = {}
		end
	end

	for i = #entityPairs, 1, -1 do
		local entPair = entityPairs[i]
		if entPair:exists() then entPair:attract() else table.remove(entityPairs, i) end
	end
end
--扳机机器人
triggerbot_delay = 100
local ent_alloc = memory.alloc_int()
function trigger(on)
    PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), ent_alloc)
    if memory.read_int(ent_alloc) ~= 0 then 
        local ent = memory.read_int(ent_alloc)
        if ENTITY.GET_ENTITY_TYPE(ent) == 1 and PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(players.user(), ent) then
            if PED.GET_PED_CONFIG_FLAG(players.user_ped(), 78, true) then  
                PAD._SET_CONTROL_NORMAL(2, 24, 1.0)
                util.yield(triggerbot_delay)
                PAD._SET_CONTROL_NORMAL(2, 24, 0.0)
            end
        end
    end
end