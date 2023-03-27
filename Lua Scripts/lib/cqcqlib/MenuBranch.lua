util.require_natives(1651208000)
require "lib.cqcqlib.natives"
require "lib.cqcqlib.cqcqlib"
require "lib.cqcqlib.menu"
require "lib.cqcqlib.natives1622613546"
util.require_natives(1627063482)
util.require_natives(1640181023)
util.require_natives(1660775568)
function Downcar()
    local veh = PED.GET_VEHICLE_PED_IS_IN(GetLocalPed(), false)
    local vv = ENTITY.GET_ENTITY_ROTATION(veh, 2)
    --Pitch: X || Roll: y || Yaw: z
    local vvPitch = v3.getX(vv)
    local vvRoll = v3.getY(vv)
    local vvYaw = v3.getZ(vv)
    ENTITY.SET_ENTITY_ROTATION(veh, 10, 179.5, vvYaw, 2, true)
    --rotation logic (left-right || YAW)
    if PAD.IS_CONTROL_PRESSED(0, 63) then --63 || INPUT_VEH_MOVE_LEFT_ONLY || A
            local yawAfterPress = vvYaw + 3
            if yawAfterPress > 180 then -- check for overflow
                local overFlowNeg = math.abs(vvYaw)*-1 --negative bypass overflow
                local toSetYaw = overFlowNeg + 3
                ENTITY.SET_ENTITY_ROTATION(veh, 10 --[[10]], 179.5, toSetYaw, 2, true)
            else --if not overflow
                ENTITY.SET_ENTITY_ROTATION(veh, 10 --[[10]], 179.5, yawAfterPress, 2, true)
            end
    end
    if PAD.IS_CONTROL_PRESSED(0, 64) then --64 ||INPUT_VEH_MOVE_RIGHT_ONLY || D
            local yawAfterPress = vvYaw - 3
            if yawAfterPress < -180 then -- check for overflow
                local overFlowNeg = math.abs(vvYaw) --positive bypass overflow
                local toSetYaw = overFlowNeg - 3
                ENTITY.SET_ENTITY_ROTATION(veh, 10 --[[10]], 179.5, toSetYaw, 2, true)
            else --if not overflow
                ENTITY.SET_ENTITY_ROTATION(veh, 10 --[[10]], 179.5, yawAfterPress, 2, true)
            end
    end
    if PAD.IS_CONTROL_PRESSED(0, 62) then --62 || INPUT_VEH_MOVE_DOWN_ONLY || LEFT CTRL / NUM5 (NOSE UP)
        local pitchAfterPress = vvPitch + 5
        if pitchAfterPress > 90 then --check for overflow
            --if pitch = 89, we add 3, we will get 88 for pitch. Distance to 90, then sub the rest.
            local pitchToSub = 90 - (3 - math.abs(90 - vvPitch))
            ENTITY.SET_ENTITY_ROTATION(veh, pitchToSub, 179.9, vvYaw)
        else
            --if not overflowed, then we just add.
            ENTITY.SET_ENTITY_ROTATION(veh, pitchAfterPress, 179.9, vvYaw)
        end
    end
    v3.free(vv)
end
function kehanjialishoot()
    local player_veh = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
    if ENTITY.GET_ENTITY_MODEL(player_veh) == util.joaat("khanjali") then
        VEHICLE.SET_VEHICLE_MOD(player_veh, 10, math.random(-1, 0), false)
    else
        util.toast("请先驾驶TM-02 可汗贾利.")
        menu.trigger_command(Firekehanjiali, "off")
    end
end
local careffects = {
	{"scr_rcbarry1", "scr_alien_impact_bul", 1.0, 50},
	{"scr_rcbarry2", "scr_clown_appears", 0.3, 500},
	{"core", "ent_dst_elec_fire_sp", 1.0, 100},
	{"scr_rcbarry1", "scr_alien_disintegrate", 0.1, 400},
	{"scr_rcbarry1", "scr_alien_teleport", 0.1, 400}
}
local careffects_lastEffect = newTimer()


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
function removeFxs(effects)
	for _, effect in ipairs(effects) do
		GRAPHICS.STOP_PARTICLE_FX_LOOPED(effect, 0)
		GRAPHICS.REMOVE_PARTICLE_FX(effect, 0)
	end
end
local careffects_lastEffect = newTimer()
effects = careffects[selectedOpt]

function UnlockVehicleGetIn()
    ::start::
    local localPed = GetLocalPed()
    local veh = PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(localPed)
    if PED.IS_PED_IN_ANY_VEHICLE(localPed, false) then
        local v = PED.GET_VEHICLE_PED_IS_IN(localPed, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(v, 1)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(v, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(v, players.user(), false)
        wait()
    else
        if veh ~= 0 then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) then
                for i = 1, 20 do
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                    wait(100)
                end
            end
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) then
                util.toast("等待2秒,无法控制!")
                goto start
            else
                if SE_Notifications then
                    util.toast("拥有控制权.")
                end
            end
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 1)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(veh, false)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(veh, players.user(), false)
            VEHICLE.SET_VEHICLE_HAS_BEEN_OWNED_BY_PLAYER(veh, false)
        end
    end
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
function set_carvis(index)
    selectedOpt = index
end

function vehchaoxiang()
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
--向前发射
function Xiangqianfashe(pid)
    local player_ped = PLAYER.GET_PLAYER_PED(pid)
    local player_vehicle = get_vehicle_ped_is_in(player_ped, include_last_vehicle_for_player_functions)
    if player_vehicle == 0 then
        util.toast(players.get_name(pid) .. " 不在车中.")
    else
        request_control(player_vehicle)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(player_vehicle, 1, 0.0, 1000.0, 0.0, true, true, true, true)
        announce(players.get_name(pid) .. "'车辆猛冲.")
    end
end

function get_vehicle_ped_is_in(ped, includeLastVehicle)
    if includeLastVehicle or PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
        return PED.GET_VEHICLE_PED_IS_IN(ped, false)
    end
    return 0
end

function announce(string)
    if announce_actions then
        util.toast(string)
    end
end

function loadModel(hash)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end
end
---@param player Player
---@return Vehicle
function get_vehicle_player_is_in(player)
	local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player)
	if PED.IS_PED_IN_ANY_VEHICLE(targetPed, false) then
		return PED.GET_VEHICLE_PED_IS_IN(targetPed, false)
	end
	return 0
end
menu.divider(vehicle,"载具娱乐列表")
local vehicle_happy = menu.list(vehicle, '载具娱乐', {}, '')

updown_veh = menu.list(vehicle_happy, "车辆翻转", {}, "", function(); end)
menu.action(updown_veh, '左侧翻', {}, '', function()
    local vehicle = get_vehicle_player_is_in(pId)
    if WIRI_ENTITY.DOES_ENTITY_EXIST(vehicle) and WIRI_VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
    request_control(vehicle, 1000) then
        WIRI_ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.71, 5.0, 0.0, 0.0, 1, false, true, true, true, true)
    end
end)
menu.action(updown_veh, '右侧翻', {}, '', function()
    local vehicle = get_vehicle_player_is_in(pId)
    if WIRI_ENTITY.DOES_ENTITY_EXIST(vehicle) and WIRI_VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
    request_control(vehicle, 1000) then
        WIRI_ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.71, -5.0, 0.0, 0.0, 1, false, true, true, true, true)
    end
end)

menu.action(updown_veh, '双左侧翻', {}, '', function()
    local vehicle = get_vehicle_player_is_in(pId)
    if WIRI_ENTITY.DOES_ENTITY_EXIST(vehicle) and WIRI_VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
    request_control(vehicle, 1000) then
        WIRI_ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 21.43, 20.0, 0.0, 0.0, 1, false, true, true, true, true)
    end
end)
menu.action(vehicle_happy, "向前发射", {}, "向前发射", function(on)
    Xiangqianfashe(on)
end)


icluster = menu.list(vehicle_happy, "开启车速表", {}, "", function();end)

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

local player_ped_id
local delta_time
local player_pos
util.create_tick_handler(function ()
    player_ped_id = PLAYER.PLAYER_PED_ID()
    delta_time = MISC.GET_FRAME_TIME()
    player_pos = ENTITY.GET_ENTITY_COORDS(player_ped_id)
    return true
end)

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

local math_funcs = b_math_funcs.new()
local shitty_gps_colour_a = {r = 255,g = 0,b = 255,a = 255}
local shitty_gps_colour_b = {r = 255,g = 255,b = 255,a = 255}
local shitty_gps_run = false
menu.toggle(vehicle_happy, "GPS", {"GPS"}, "", function(value)

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
--[[menu.toggle_loop(vehicle_happy, "载具引导", {""}, "", function ()
	vehchaoxiang()
end)

menu.toggle_loop(vehicle_happy, "载具效果", {}, "", function ()
    cargoodeffect()
end)]]
menu.toggle(vehicle_happy,"恶灵骑士" ,{""}, "", function(on)
    if on then 
        elqes()
        menu.trigger_commands("fireman on")
        menu.trigger_commands("walkfire "..PLAYER.GET_PLAYER_NAME(players.user()).." on")
        menu.trigger_commands("yonghengyuyi on")
    else
        entities.delete_by_handle(vehicleelqs)
        menu.trigger_commands("fireman off")
        menu.trigger_commands("walkfire "..PLAYER.GET_PLAYER_NAME(players.user()).." off")
        menu.trigger_commands("yonghengyuyi off")
    end

end)
menu.toggle_loop(vehicle_happy, "转向灯", {}, "开启载具转向灯", function()
    if(PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false)) then
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
        local left = PAD.IS_CONTROL_PRESSED(34, 34)
        local right = PAD.IS_CONTROL_PRESSED(35, 35)
        local rear = PAD.IS_CONTROL_PRESSED(130, 130)
        if left and not right and not rear then
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 1, true)
        elseif right and not left and not rear then
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 0, true)
        elseif rear and not left and not right then
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 1, true)
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 0, true)
        else
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 0, false)
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 1, false)
        end
    end
end)
--[[local zhedie_veh = menu.list(vehicle_happy, "车辆折叠", {}, "")
menu.click_slider(zhedie_veh,"垂直折叠车辆", {}, "", 1, 10, 3, 1, function(s)
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
end)

menu.click_slider(zhedie_veh, "垂直折叠车辆", {}, "", 1, 10, 3, 1, function(s)
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
end)]]

local chauffeur_root = menu.list(vehicle_happy, "聘用司机", {}, "")

menu.list_action(chauffeur_root, "呼叫司机", {"summonchauffeur"}, "", {"Stretch", "T20", "Kuruma"}, function(index, value, click_type)
    summ_car(index, value)
end)

menu.action(chauffeur_root, "驾车至导航点", {}, "", function(click_type)
    summ_car_topoint()
end)

menu.action(chauffeur_root, "传送到驾驶室", {}, "", function(click_type)
    summ_car_tp()
end)

menu.action(chauffeur_root, "自我毁灭", {}, "", function(click_type)
    summ_car_bmob()
end)
menu.toggle_loop(vehicle_happy, "隐藏载具无敌", {}, "小部分菜单可检测", function()
    ENTITY.SET_ENTITY_PROOFS(entities.get_user_vehicle_as_handle(), true, true, true, true, true, 0, 0, true)
    end, function() ENTITY.SET_ENTITY_PROOFS(PED.GET_VEHICLE_PED_IS_IN(player), false, false, false, false, false, 0, 0, false)
end)
menu.action(vehicle_happy, "强行离开载具", {"forceleaveveh"}, "紧急情况下强行离开车辆", function(click_type)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
    TASK.TASK_LEAVE_ANY_VEHICLE(players.user_ped(), 0, 16)
end)
--[[menu.slider_text(vehicle_happy,"设置载具效果", {}, "", carvis, function (index)
    set_carvis(index) 
end)]]
local fastTurnVehicleScale = 3

menu.toggle_loop(vehicle_happy, "载具快速旋转", {}, "用A/D键快速转动载具.", function ()
    FastTurnVehicleWithKeys(fastTurnVehicleScale)
end)
menu.toggle(vehicle_happy, '减少车辆翘头', {''}, '使载具不容易翘头,主要针对于肌肉车', function (tog)
    C_PHYSICS.SET_IN_ARENA_MODE(tog)
end)
menu.action(vehicle_happy, "将载具倒过来", {}, "", function ()
    Downcar()
end)
menu.slider(vehicle_happy, "载具快速旋转速率", {"vehfastturn"}, "设置自定义转弯的比例.", 1, 1000, 30, 5, function(value)
    fastTurnVehicleScale = value / 10
end)
menu.toggle_loop(vehicle_happy, "解锁你将要进入的载具", {"unlockvehget"}, "这将在锁定的玩家载具上起作用.", function ()
    UnlockVehicleGetIn()
end)
Firekehanjiali = menu.toggle_loop(vehicle_happy, "提升TM-02可汗贾利射速", {}, "快速射击", function()
    kehanjialishoot()
end)
local services <const> = menu.list(online, "请求选项", {}, "")


--menu.action(services, "纳米无人机", {}, "", function()
    --namiwurenji()
--end)

--menu.action(services, "请求豪华直升机", {}, "", function()
    --haohuazhishengji()
--end)

menu.action(services, "RC匪徒", {}, "", function()
    RCfeitu()
end)

--menu.action(services, "RC坦克", {}, "", function ()
   -- RCtank()
--end)
local blockareas = menu.list(online, '阻挡区域', {'JSblock'}, '用隐形墙阻挡某些区域,让其他人无法进入. 但如果您在加入战局的时候使用它,它会让你崩溃哈哈.')

    menu.toggle_loop(blockareas, '自定义阻挡', {}, '使您能够通过按"B"来阻挡您面前的区域.', function()
        blocksomewhere()
    end)

    local blocklsc = menu.list(blockareas, '阻挡洛圣都改车王', {'JSblockLSC'}, '阻挡进入洛圣都改车王.')
    local blockcasino = menu.list(blockareas, '阻挡赌场', {'JSblockCasino'}, '阻挡进入赌场.')
    local jsblockcasino = menu.list(blockareas, '阻挡花园银行', {'JSblockCasino'}, '阻挡进入花园银行.')

    local blockAreasActions = {
        --Orbital block
        {root = blockareas, name = '天基炮发射室', coordinates = {{335.95837, 4834.216, -60.99977}}, blocked = false},
        -- Lsc blocks
        {root = blocklsc, name = '伯顿', coordinates = {{-357.66544, -134.26419, 38.23775}}, blocked = false},
        {root = blocklsc, name = 'LSIA', coordinates = {{-1144.0569, -1989.5784, 12.9626}}, blocked = false},
        {root = blocklsc, name = '梅萨', coordinates = {{721.08496, -1088.8752, 22.046721}}, blocked = false},
        {root = blocklsc, name = '布莱恩县', coordinates = {{115.59574, 6621.5693, 31.646144}, {110.460236, 6615.827, 31.660228}}, blocked = false},
        {root = blocklsc, name = '佩立托湾', coordinates = {{115.59574, 6621.5693, 31.646144}, {110.460236, 6615.827, 31.660228}}, blocked = false},
        {root = blocklsc, name = '本尼车坊', coordinates = {{-205.6571, -1309.4313, 31.093222}}, blocked = false},
        -- Casino blocks
        {root = blockcasino, name = '赌场入口', coordinates = {{924.3438, 49.19933, 81.10636}, {922.5348, 45.917263, 81.10635}}, blocked = false},
        {root = blockcasino, name = '赌场车库', coordinates = {{935.29553, -0.5328601, 78.56404}}, blocked = false},
        {root = blockcasino, name = '幸运转盘', coordinates = {{1110.1014, 228.71582, -49.935845}}, blocked = false},
        --Maze bank block
        {root = jsblockcasino, name = '花园银行入口', coordinates = {{-81.18775, -795.82874, 44.227295}}, blocked = false},
        {root = jsblockcasino, name = '花园银行车库', coordinates = {{-77.96956, -780.9376, 38.473335}, {-82.82901, -781.81635, 38.50093}}, blocked = false},
        --Mc block
        {root = blockareas, name = '霍伊会所', coordinates = {{-17.48541, -195.7588, 52.370953}, {-23.452509, -193.01324, 52.36245}}, blocked = false},
        --Arena war garages
        {root = blockareas, name = '竞技场车库', coordinates = {
            {-362.912, -1870.2249, 20.527836}, {-367.41855, -1872.5348, 20.527836},
            {-375.58344, -1874.6719, 20.527828},  {-379.9853, -1876.0894, 20.527828},
            {-386.49762, -1880.2793, 20.527842},  {-390.3558, -1883.0833, 20.527842},
            {-396.9259, -1883.9537, 21.542086}
        }, blocked = false},
    }
        
    
    for i = 1, #blockAreasActions do
        local areaName = blockAreasActions[i].name
        menu.action(blockAreasActions[i].root, '阻挡' ..' '.. areaName, {}, '', function ()
            if not blockAvailable(blockAreasActions[i].blocked, (areaName == '洛圣都国际机场' and areaName or string.capitalize(areaName))) then return end
            setBlockStatus(true)
            blockAreasActions[i].blocked = true
            for j = 1, #blockAreasActions[i].coordinates do
                block(blockAreasActions[i].coordinates[j])
            end
            setBlockStatus(false, areaName)
        end)
    end
    menu.divider(world, "世界控制")
    peds_root = menu.list(world, "NPC指令", {""}, "")

local all_sex_voicenames = {
    "S_F_Y_HOOKER_01_WHITE_FULL_01",
    "S_F_Y_HOOKER_01_WHITE_FULL_02",
    "S_F_Y_HOOKER_01_WHITE_FULL_03",
    "S_F_Y_HOOKER_02_WHITE_FULL_01",
    "S_F_Y_HOOKER_02_WHITE_FULL_02",
    "S_F_Y_HOOKER_02_WHITE_FULL_03",
    "S_F_Y_HOOKER_03_BLACK_FULL_01",
    "S_F_Y_HOOKER_03_BLACK_FULL_03",
}

local function get_distance_between_entities(entity, target)
	if not ENTITY.DOES_ENTITY_EXIST(entity) or not ENTITY.DOES_ENTITY_EXIST(target) then
		return 0.0
	end
	local pos = ENTITY.GET_ENTITY_COORDS(entity, true)
	return ENTITY.GET_ENTITY_COORDS(target, true):distance(pos)
end

peds_thread = util.create_thread(function (thr)
    while true do
        if ped_uses > 0 then
            
            all_peds = entities.get_all_peds_as_handles()
            for k,ped in pairs(all_peds) do
                
                if not PED.IS_PED_A_PLAYER(ped) then

                    if make_peds_cops then 
                        PED.SET_PED_AS_COP(ped, true)
                    end

                    if ped_no_ragdoll then 
                        PED.SET_PED_CAN_RAGDOLL(ped, false)
                    end

                    if ped_godmode then 
                        ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
                    end

                    if hooker_esp then
                        local mdl = ENTITY.GET_ENTITY_MODEL(ped)
                        if PED.IS_PED_USING_SCENARIO(ped, "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS") or PED.IS_PED_USING_SCENARIO(ped,"WORLD_HUMAN_PROSTITUTE_LOW_CLASS") then 
                            util.draw_ar_beacon(ENTITY.GET_ENTITY_COORDS(ped))
                        end
                    end

                    if ped_no_crits then
                        PED.SET_PED_SUFFERS_CRITICAL_HITS(ped, false)
                    end

                    if ped_highperception then
                        PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
                        PED.SET_PED_HEARING_RANGE(ped, 1000.0)
                        PED.SET_PED_SEEING_RANGE(ped, 1000.0)
                        PED.SET_PED_VISUAL_FIELD_MIN_ANGLE(ped, 1000.0)
                    end

                    if ped_allcops then
                        PED.SET_PED_AS_COP(ped, true)
                    end

                    if ped_theflash then
                        PED.SET_PED_MOVE_RATE_OVERRIDE(ped, 10.0)
                    end

                    if rain_peds then 
                        if not ENTITY.IS_ENTITY_IN_AIR(ped) then 
                            local ped_c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
                            ped_c.x = ped_c.x + math.random(-50, 50)
                            ped_c.y = ped_c.y + math.random(-50, 50)
                            ped_c.z = ped_c.z + math.random(50, 100)
                            ENTITY.SET_ENTITY_COORDS(ped, ped_c.x, ped_c.y, ped_c.z)
                            ENTITY.SET_ENTITY_VELOCITY(ped, 0.0, 0.0, -1.0)
                        end
                    end

                    if ped_hardened then
                        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
                        PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
                        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
                        PED.SET_PED_ACCURACY(ped, 100)
                        PED.SET_PED_COMBAT_ABILITY(ped, 3)
                    end

                    if peds_ignore then
                        if not PED.GET_PED_CONFIG_FLAG(ped, 17, true) then
                            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
                            TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
                        end
                    end
                    if wantthesmoke then 
                        PED.SET_PED_AS_ENEMY(ped, true)
                        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
                        PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
                        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
                        TASK.TASK_COMBAT_PED(ped, players.user_ped(), 0, 16)
                    end

                    if apose_peds then 
                        if PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
                            TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
                        end
                        request_anim_set("move_crawl")
                        PED.SET_PED_MOVEMENT_CLIPSET(ped, "move_crawl", -1)
                    end

                    if roast_voicelines then
                        local roasts = {
                            "GENERIC_INSULT_MED",
                            "GENERIC_INSULT_HIGH"
                        }
                        AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(ped, roasts[math.random(#roasts)], "SPEECH_PARAMS_FORCE_SHOUTED")
                    end
    
                    if sex_voicelines then
                        local voice_name = all_sex_voicenames[math.random(1, #all_sex_voicenames)]
                        local speeches = {
                            "SEX_GENERIC_FEM",
                            "SEX_HJ",
                            "SEX_ORAL_FEM",
                            "SEX_CLIMAX",
                            "SEX_GENERIC"
                        }
                        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(ped, speeches[math.random(#speeches)], voice_name, "SPEECH_PARAMS_FORCE_SHOUTED", 0)
                    end
    
                    if screamall then
                        local screams = {
                            "SCREAM_SCARED",
                            "SCREAM_PANIC_SHORT",
                            "SCREAM_TERROR"

                        }
                        AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(ped, screams[math.random(#screams)], "SPEECH_PARAMS_FORCE_SHOUTED")
                    end

                    if php_bars and get_distance_between_entities(players.user_ped(), ped) < 100.0 and not PED.IS_PED_FATALLY_INJURED(ped) and ENTITY.IS_ENTITY_ON_SCREEN(ped) then
                        local headPos = PED.GET_PED_BONE_COORDS(ped, 0x322C --[[head]], 0.35, 0., 0.)
                        local perc = 0.0

                        if not PED.IS_PED_FATALLY_INJURED(ped) then
                            local maxHealth = PED.GET_PED_MAX_HEALTH(ped)
                            local health = ENTITY.GET_ENTITY_HEALTH(ped)
                            perc = (health - 100.0) / (maxHealth - 100.0)
                            if perc > 1.0 then perc = 1.0  end
                        end
                        
                        local colour = get_health_colour(perc)
                        local scale = v3.new(0.10, 0.0, interpolate(0.0, 0.7, perc))
                        draw_marker(43, headPos, v3(), v3(), scale, false, colour, 0, 0)
                    end

                    if allpeds_gun ~= 0 then
                        WEAPON.GIVE_WEAPON_TO_PED(ped, allpeds_gun, 9999, false, true)
                    end

                    -- ONLINE INTERACTIONS
                    if aped_combat then
                        local tar = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(combat_tar)
                        if not PED.IS_PED_IN_COMBAT(ped, tar) then 
                            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
                            PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
                            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
                            TASK.TASK_COMBAT_PED(ped, combat_tar, 0, 16)
                        end
                    end


                end
            end
        end
        util.yield()
    end
end)

local function get_model_size(hash)
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

-- PEDS
ped_b_root = menu.list(peds_root, "行为", {"pedbehavior"}, "")
ped_attributes_root = menu.list(peds_root, "属性", {"pedattributes"}, "")
ped_voice = menu.list(peds_root, "声音", {"pedaudio"}, "")
ped_spawn = menu.list(peds_root, "生成", {"pedspawn"}, "")

local function request_anim_dict(dict)
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        STREAMING.REQUEST_ANIM_DICT(dict)
        util.yield()
    end
end

local function request_model_load(hash)
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

-- SPAWNING PEDS
num_peds_spawn = 1
local function spawn_ped(hash)
coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 3.0, 0.0)
local peds_spawned = {}
request_model_load(hash)
for i=1, num_peds_spawn do
    ped = entities.create_ped(28, hash, coords, math.random(0, 270))
    peds_spawned[#peds_spawned + 1] = ped
    if spawn_dancing then 
        local d = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity"
        request_anim_dict(d)
        TASK.TASK_PLAY_ANIM(ped, d, "hi_dance_facedj_13_v2_male^5", 1.0, 1.0, -1, 3, 0.5, false, false, false)
        PED.SET_PED_KEEP_TASK(ped, true)
    end
    if is_pet then
        all_pets[#all_pets + 1] = ped
        ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
        TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(ped, players.user_ped(), 0, -1, 0, 7.0, -1, 1, true)
        PED.SET_PED_COMBAT_ABILITY(ped, 3)
        PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
        local blip = HUD.ADD_BLIP_FOR_ENTITY(ped)
        HUD.SET_BLIP_COLOUR(blip, 11)
    end
end
return peds_spawned
end


all_pets = {}
local function spawn_pet(hash)
request_model_load(hash)
local c = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
local pet = entities.create_ped(28, hash, c, 0)
all_pets[#all_pets + 1] = pet
ENTITY.SET_ENTITY_INVINCIBLE(pet, true)
PED.SET_PED_COMPONENT_VARIATION(pet, 0, 0, 2, 0)
TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(pet, players.user_ped(), 0, -1, 0, 7.0, -1, 1, true)
PED.SET_PED_COMBAT_ABILITY(pet, 0)
PED.SET_PED_FLEE_ATTRIBUTES(pet, 0, true)
PED.SET_PED_COMBAT_ATTRIBUTES(pet, 46, false)
local blip = HUD.ADD_BLIP_FOR_ENTITY(pet)
HUD.SET_BLIP_COLOUR(blip, 11)
end

local custom_animal = "a_c_retriever"
menu.text_input(ped_spawn, "自定义行人输入", {"customped"}, "输入要生成的自定义行人。模型英文名,而不是哈希值", function(on_input)
custom_animal = on_input
end, "a_c_retriever")


local animal_hashes = {1302784073, -1011537562, 802685111, util.joaat("a_c_chimp"), -1589092019, 1794449327, -664053099, -1920284487, util.joaat("a_c_retriever"), util.joaat('a_c_cow'), util.joaat("a_c_rabbit_01")}
local animal_options = {"莱斯特", "老鼠", "鱼", "黑猩猩", "黄貂鱼", "母鸡", "鹿", "虎鲸", "狗", "奶牛", "兔子", "自定义"}
menu.list_action(ped_spawn, "生成行人", {"spawnped"}, "", animal_options, function(index, value, click_type)
if value == "自定义" then
    spawn_ped(util.joaat(custom_animal))
else
    spawn_ped(animal_hashes[index])
end
end)

menu.slider(ped_spawn, "生成数量", {"pedspawnct"}, "明智地选择", 1, 10, 1, 1, function(s)
num_peds_spawn = s
end)


is_pet = false
menu.toggle(ped_spawn, "作为宠物生成", {"spawnaspet"}, "将此行人作为宠物生成.", function(on)
is_pet = on
end)

spawn_dancing = false
menu.toggle(ped_spawn, "生成舞蹈中的", {"spawndancing"}, "产生舞蹈中的行人", function(on)
spawn_dancing = on
end)

local good_guns = {0, 453432689, 171789620, 487013001, -1716189206, 1119849093}
allpeds_gun = 0
local gun_options = {"没有", "手枪", "战斗自卫冲锋枪", "霰弹枪", "刀", "加特林"}
menu.list_action(peds_root, "给所有行人枪", {"giveallpeds"}, "", gun_options, function(index, value, click_type)
if index == 1 then
    allpeds_gun = 0
else
    allpeds_gun = good_guns[index]
end
end)

menu.action(peds_root, "传送所有到我", {"tpallpedshere"}, "", function(click_type)
local c = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
all_peds = entities.get_all_peds_as_handles()
for k,ped in pairs(all_peds) do
    if not PED.IS_PED_A_PLAYER(ped) then
        if PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
            TASK.TASK_LEAVE_ANY_VEHICLE(ped, 0, 16)
        end
        ENTITY.SET_ENTITY_COORDS(ped, c.x, c.y, c.z)
    end
end
end)

menu.action(peds_root, "堆叠所有行人", {"stackallpeds"}, "", function(click_type)
local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
all_peds = entities.get_all_peds_as_handles()
local last_ped = 0
local last_ped_ht = 0
notification("请稍候…", colors.blue)
for k,ped in pairs(all_peds) do
    if not PED.IS_PED_A_PLAYER(ped) and not PED.IS_PED_FATALLY_INJURED(ped) then
        request_control_of_entity(ped)
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
        last_ped_ht = get_model_size(ENTITY.GET_ENTITY_MODEL(ped)).z
    end
end
end)





local function task_handler(type)
all_peds = entities.get_all_peds_as_handles()
player_ped = PLAYER.PLAYER_PED_ID()
for k,ped in pairs(all_peds) do
    if not PED.IS_PED_A_PLAYER(ped) then
        pluto_switch type do
            case "Flop":
                TASK.TASK_SKY_DIVE(ped)
                break
            case "Cover":
                TASK.TASK_STAY_IN_COVER(ped)
                break
            case "Writhe":
                TASK.TASK_WRITHE(ped, player_ped, -1, 0)
                break
            case "Vault":
                TASK.TASK_CLIMB(ped, true)
                break
            case "Cower":
                TASK.TASK_COWER(ped, -1)
                break
            case "Clear":
                TASK.CLEAR_PED_TASKS(ped)
                break
        end
    end
end
end

ped_no_ragdoll = false
menu.toggle(ped_attributes_root, "无布娃娃", {"nopedragdoll"}, "", function(on)
ped_no_ragdoll = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_godmode = false
menu.toggle(ped_attributes_root, "无敌", {"pedgodmode"}, "", function(on)
ped_godmode = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_no_crits = false
menu.toggle(ped_attributes_root, "没有暴击", {"nopedcrits"}, "", function(on)
ped_no_crits = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_highperception = false
menu.toggle(ped_attributes_root, "高感知", {"pedhighperception"}, "行人会比平时看到和听到更多。", function(on)
ped_highperception = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_allcops = false
menu.toggle(ped_attributes_root, "让所有行人成为警察", {"pedallcops"}, "", function(on)
ped_allcops = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_theflash = false
menu.toggle(ped_attributes_root, "兔八哥", {"looney_tunes"}, "行人移动速度超快.", function(on)
ped_theflash = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_hardened = false
menu.toggle(ped_attributes_root, "久经沙场的", {"pedhardened"}, "行人不再是懦夫,他们将战斗而不是逃跑。它们也更加精确和有战斗力。", function(on)
ped_hardened = on 
mod_uses("ped", if on then 1 else -1)
end)



local task_dict = {"flop", "cover", "vault"}
local task_options = {"猛然躺下", "掩护", "跳跃", "畏缩", "扭动", "净空",}
menu.list_action(peds_root, "给所有人任务", {"taskped"}, "", task_options, function(index, value, click_type)
task_handler(value)
end)

peds_ignore = false
menu.toggle(ped_b_root, "健忘的行人", {"obliviouspeds"}, "行人不会在乎你做什么。已经对你做出反应的行人不会忘记你做了什么。", function(on)
peds_ignore = on
mod_uses("ped", if on then 1 else -1)
end)

wantthesmoke = false
menu.toggle(ped_b_root, "行人攻击我", {"iwantthesmoke"}, "告诉附近所有的行人你想要来点烟火。可能会弄坏一些东西。", function(on)
wantthesmoke = on
mod_uses("ped", if on then 1 else -1)
end)

make_peds_cops = false
menu.toggle(ped_b_root, "使附近的行人变为警察", {"makecops"}, "他们实际上不是真正的警察,但会举报犯罪。近似", function(on)
make_peds_cops = on
mod_uses("ped", if on then 1 else -1)
end)

menu.toggle(ped_b_root, "底特律", {"detroit"}, "附近的所有NPC都开始互相决斗,并获得了武器。最近的事态发展表明,这个笑话被认为是不敏感的,这很有趣,因为在推特上大喊大叫比试图解决底特律的犯罪问题花费了更多的精力。", function(on)
MISC.SET_RIOT_MODE_ENABLED(on)
end)

apose_peds = false
menu.toggle(ped_b_root, "A-姿势", {"aposepeds"}, "哦！狗屎！", function(on)
apose_peds = on
mod_uses("ped", if on then 1 else -1)
end)

roast_voicelines = false
menu.toggle(ped_voice, "严厉的声线", {"npcroasts"}, "非常不道德。", function(on)
roast_voicelines = on
mod_uses("ped", if on then 1 else -1)
end)

sex_voicelines = false
menu.toggle(ped_voice, "呻吟", {"sexlines"}, "", function(on)
sex_voicelines = on
mod_uses("ped", if on then 1 else -1)
end)

screamall = false
menu.toggle(ped_voice, "尖叫", {"screamall"}, "让附近所有的行人惨叫。令人惊叹的", function(on)
screamall = on
mod_uses("ped", if on then 1 else -1)
end)
menu.divider(vehicle, "载具控制")
vehicles_root = menu.list(vehicle, "载具指令", {"lancescriptvehicles"}, "")



v_phys_root = menu.list(vehicles_root, "载具物理", {"vphysics"}, "控制载具物理")
vc_root = menu.list(v_phys_root, "载具混乱", {"chaos"}, "审判日")
v_traffic_root = menu.list(vehicles_root, "载具交通", {"traffic"}, "控制载具交通")

local function get_closest_vehicle(entity)
    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
    local vehicles = entities.get_all_vehicles_as_handles()
    local closestdist = 1000000
    local closestveh = 0
    for k, veh in pairs(vehicles) do
        if veh ~= PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false) then
            local vehcoord = ENTITY.GET_ENTITY_COORDS(veh, true)
            local dist = MISC.GET_DISTANCE_BETWEEN_COORDS(coords['x'], coords['y'], coords['z'], vehcoord['x'], vehcoord['y'], vehcoord['z'], true)
            if dist < closestdist then
                closestdist = dist
                closestveh = veh
            end
        end
    end
    return closestveh
end

menu.action(vehicles_root, "传送到最近的载具", {"closestvehicle"}, "传送到最近的载具(不包括任何您可能已经在其中的载具)。请注意,附近的“载具”可能只是低模贴图,而不是实际的载具。", function(on_click)
    local closestveh = get_closest_vehicle(players.user_ped())
    local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(closestveh, -1)
    if VEHICLE.IS_VEHICLE_SEAT_FREE(closestveh, -1) then
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, -1)
    else
        if not PED.IS_PED_A_PLAYER(driver) then
            entities.delete_by_handle(driver)
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, -1)
        elseif VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(closestveh) then
            for i=0, 10 do
                if VEHICLE.IS_VEHICLE_SEAT_FREE(closestveh, i) then
                    PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, i)
                end
            end
        else
            notification("附近没有找到可用座位的载具:(", colors.blue)
        end
    end
end)

vehicle_chaos = false
menu.toggle(vc_root, "载具混乱", {"chaos"}, "", function(on)
    vehicle_chaos = on
    mod_uses("vehicle", if on then 1 else -1)
end)

vc_gravity = true
menu.toggle(vc_root, "载具混沌引力", {"chaosgravity"}, "重力开/关", function(on)
    vc_gravity = on
end, true)

vc_speed = 100
menu.slider(vc_root, "载具混沌速度", {"chaosspeed"}, "迫使载具行驶的速度。越高=越混乱。", 30, 300, 100, 10, function(s)
  vc_speed = s
end)

vhp_bars = false
menu.toggle(vehicles_root, "载具血量条", {"vehhpbars"}, "在载具上面绘制血量条。", function(on)
    vhp_bars = on
    mod_uses("vehicle", if on then 1 else -1)
    if php_bars and on then
        notification("警告:您同时打开了NPC血量条!由于引擎限制,某些条形图可能不会出现。", colors.blue)
    end
end)

ascend_vehicles = false
menu.toggle(v_phys_root, "升高附近所有载具", {"ascendvehicles"}, "它应该能使它们整齐地漂浮起来,但它只是让它们在半空中旋转。真他妈的好笑。", function(on)
    ascend_vehicles = on
    mod_uses("vehicle", if on then 1 else -1)
end)

rain_vehicles = false
menu.toggle(v_phys_root, "载具雨", {"rainvehicles"}, "", function(on)
    rain_vehicles = on
    mod_uses("vehicle", if on then 1 else -1)
end)

inferno = false
menu.toggle(v_phys_root, "抖动混乱", {"inferno"}, "过度破坏性的“炸毁所有车辆”选项。将继续炸毁所有车辆,即使它们已经被摧毁。", function(on)
    inferno = on
    mod_uses("vehicle", if on then 1 else -1)
end, false)

blackhole = false
menu.toggle(v_phys_root, "载具黑洞", {"blackhole"}, "一个超级迟缓但有趣的黑洞。", function(on)
    blackhole = on
    mod_uses("vehicle", if on then 1 else -1)
    if on then
        holecoords = players.get_position(players.user())
        notification("黑洞位置被设置为比你的位置高50个单位。打开和关闭此选项以更改位置。", colors.blue)
    end
end)

hole_zoff = 50
menu.slider(v_phys_root, "黑洞Z轴偏移", {"blackholeoffset"}, "在你上方多远的地方放置黑洞。建议将其保持在相当高的水平。", 0, 100, 50, 10, function(s)
    hole_zoff = s
  end)


beep_cars = false
menu.toggle(vehicles_root, "附近所有载具无限鸣笛", {"beepvehicles"}, "使附近所有载具发出无限哔哔。可能无法在线工作。", function(on)
    beep_cars = on
    mod_uses("vehicle", if on then 1 else -1)
end)

yeetsubmarines = false
menu.toggle(vehicles_root, "弹飞潜艇", {"yeetsubs"},  "", function(on)
    yeetsubmarines = on
    mod_uses("vehicle", if on then 1 else -1)
end)

menu.action(vehicles_root, "传送所有载具到我", {"tpallvehshere"}, "", function(click_type)
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    all_vehs = entities.get_all_vehicles_as_handles()
    for k,veh in pairs(all_vehs) do
        if not PED.IS_PED_A_PLAYER(VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, false)) then
            ENTITY.SET_ENTITY_COORDS(veh, c.x, c.y, c.z)
        end
    end
end)


halt_traffic = false
menu.toggle(v_traffic_root, "停止交通", {"halttraffic"}, "阻止附近所有载具移动分毫。", function(on)
    halt_traffic = on
    mod_uses("vehicle", if on then 1 else -1)
end)

reverse_traffic = false
menu.toggle(v_traffic_root, "反向交通", {"reversetraffic"}, "", function(on)
    reverse_traffic = on
    mod_uses("vehicle", if on then 1 else -1)
end)

vehicles_thread = util.create_thread(function (thr)
    while true do
        if vehicle_uses > 0 then
            
            all_vehicles = entities.get_all_vehicles_as_handles()
            for k,veh in pairs(all_vehicles) do
                if l_e_v_on then
                    local size = get_model_size(ENTITY.GET_ENTITY_MODEL(veh))
                    if size.x > l_e_max_x or size.y > l_e_max_y or size.z > l_e_max_y then
                        entities.delete_by_handle(veh)
                    end
                end

                if vhp_bars and get_distance_between_entities(players.user_ped(), veh) < 200.0 and not ENTITY.IS_ENTITY_DEAD(veh, false) and ENTITY.IS_ENTITY_ON_SCREEN(veh) then
                    local modelHash = ENTITY.GET_ENTITY_MODEL(veh)
                    local min, max = v3.new(), v3.new()
                    MISC.GET_MODEL_DIMENSIONS(modelHash, min, max)
                    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(veh, 0.0, 0.0, max.z + 0.3)
                    local perc = 0.0

                    if not ENTITY.IS_ENTITY_DEAD(veh, false) then
                        local maxHealth = ENTITY.GET_ENTITY_MAX_HEALTH(veh)
                        local health = ENTITY.GET_ENTITY_HEALTH(veh)
                        perc = health / maxHealth
                        if perc > 1.0 then perc = 1.0  end
                    end
                    
                    local colour = get_health_colour(perc)
                    local scale = v3.new(0.10, 0.0, interpolate(0.0, 0.7, perc))
                    draw_marker(43, pos, v3(), v3(), scale, false, colour, 0, 0)
                end

                local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1)
                if player_cur_car ~= veh and (not PED.IS_PED_A_PLAYER(driver)) or driver == 0 then
                    
                    if yeetsubmarines then
                        if VEHICLE.IS_VEHICLE_MODEL(veh, util.joaat("kosatka")) and ENTITY.IS_ENTITY_IN_WATER(veh) then
                            request_control_of_entity_once(veh)
                            ENTITY.SET_ENTITY_MAX_SPEED(veh, 10000)
                            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1,  0.0, 0.0, 10000, 0, 0, 0, 0, true, false, true, false, true)
                        end 
                    end

                    if inferno then
                        local coords = ENTITY.GET_ENTITY_COORDS(veh, true)
                        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 7, 100.0, true, false, 1.0)
                    end

                    if beep_cars then
                        if not AUDIO.IS_HORN_ACTIVE(veh) then
                            VEHICLE.START_VEHICLE_HORN(veh, 200, util.joaat("HELDDOWN"), true)
                        end
                    end

                    if blackhole then
                        if bh_target ~= -1 then
                            holecoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(bh_target), true)
                        end
                        vcoords = ENTITY.GET_ENTITY_COORDS(veh, true)
                        speed = 100
                        local x_vec = (holecoords['x']-vcoords['x'])*speed
                        local y_vec = (holecoords['y']-vcoords['y'])*speed
                        local z_vec = ((holecoords['z']+hole_zoff)-vcoords['z'])*speed
                        -- dumpster fire if this goes wrong lol
                        ENTITY.SET_ENTITY_INVINCIBLE(veh, true)
                        --losioVEHICLE.SET_VEHICLE_GRAVITY(veh, false)
                        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, x_vec, y_vec, z_vec, true, false, true, true)
                    end

                    if vehicle_chaos then
                        VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(veh, false, true)
                        VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, vc_speed)
                        VEHICLE.SET_VEHICLE_GRAVITY(veh, vc_gravity)
                    end
                
                    if halt_traffic then
                        VEHICLE.BRING_VEHICLE_TO_HALT(veh, 0.0, -1, true)
                        coords = ENTITY.GET_ENTITY_COORDS(veh, false)
                    end

                    if ascend_vehicles then
                        VEHICLE.SET_VEHICLE_UNDRIVEABLE(veh, true)
                        VEHICLE.SET_VEHICLE_GRAVITY(veh, false)
                        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 4, 5.0, 0.0, 0.0, true, true, true, true)
                    end

                    if rain_vehicles then 
                        if not ENTITY.IS_ENTITY_IN_AIR(veh) then 
                            local ped_c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
                            ped_c.x = ped_c.x + math.random(-50, 50)
                            ped_c.y = ped_c.y + math.random(-50, 50)
                            ped_c.z = ped_c.z + math.random(100, 120)
                            ENTITY.SET_ENTITY_COORDS(veh, ped_c.x, ped_c.y, ped_c.z)
                        end
                    end

                    if reverse_traffic then
                        ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1)
                        TASK.TASK_VEHICLE_TEMP_ACTION(ped, veh, 3, -1)
                    end
                end
            end
        end
        util.yield()
    end
end)

