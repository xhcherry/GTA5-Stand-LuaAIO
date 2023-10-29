local player_vehicle 
local mst_warn
local lastwpn
local mode 
local wpn
local altitude = 0
local missile_nearby 


local aalib = require("aalib")
local PlaySound = aalib.play_sound
local SND_ASYNC<const> = 0x0001
local SND_FILENAME<const> = 0x00020000

local store_dir = filesystem.scripts_dir() .. '\\GTLuaScript\\' .. '\\flightredux\\'
sound_selection_dirterrain = store_dir .. '\\terrain.txt'
sound_selection_dirmissile = store_dir .. '\\missile.txt'

fp = io.open(sound_selection_dirterrain, 'r')
local file_selection = fp:read('*a')
fp:close()

fp = io.open(sound_selection_dirmissile, 'r')
local file_selectionmissile = fp:read('*a')
fp:close()

local sound_location = store_dir .. '\\' .. file_selection

local sound_locationmissile = store_dir .. '\\' .. file_selectionmissile


hhud_dir = filesystem.scripts_dir() .. '\\GTLuaScript\\' .. '\\flightredux\\'

if not filesystem.scripts_dir(hhud_dir_dir) then
    util.toast("警告:资源目录丢失")
end

gpws = true
menu.toggle(aircrafthud, "警报", {"gpws"}, "", function(on)
    gpws = on
end, true)



trajectory_icon = directx.create_texture(hhud_dir .. 'trajectory.png')
altimeter_outline = directx.create_texture(hhud_dir .. 'altimeter.png') 
boresight = directx.create_texture(hhud_dir .. 'boresight.png') 
line = directx.create_texture(hhud_dir .. 'line.png')
circle = directx.create_texture(hhud_dir .. 'circle.png')
contact = directx.create_texture(hhud_dir.. 'contact.png')


hud_green = {
    r = 0, 
    g = 100,
    b = 0,
    a = 100
}
hud_red = {
    r = 255, 
    g = 0,
    b = 0,
    a = 100
}
hud_yellow = {
    r = 255, 
    g = 187,
    b = 0,
    a = 100
}

hud_offset = {0, 0}

function world_to_screen_coords(x, y, z)
    sc_x = memory.alloc(8)
    sc_y = memory.alloc(8)
    GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(x, y, z, sc_x, sc_y)
    local ret = {
        x = memory.read_float(sc_x),
        y = memory.read_float(sc_y)
    }
    return ret
end

function get_entity_trajectory(entity)
    local c = ENTITY.GET_ENTITY_COORDS(entity)
    local v = ENTITY.GET_ENTITY_VELOCITY(entity)
    local trajectory = {
        x = c.x + v.x,
        y = c.y + v.y, 
        z = c.z + v.z
    }
    return trajectory
end

-- thanks jerry
function get_weapon_hash(ped)
    local weaponHash = WEAPON.GET_SELECTED_PED_WEAPON(ped)
    local vehWeaponHash = nil
    local wpn_ptr = memory.alloc_int()
    local vehicleWeapon = false
    if WEAPON.GET_CURRENT_PED_VEHICLE_WEAPON(ped, wpn_ptr) then -- only returns true if the weapon is a vehicle weapon
        vehWeaponHash = memory.read_int(wpn_ptr)
        vehicleWeapon = true
    end
    return (vehWeaponHash and vehWeaponHash or weaponHash), vehicleWeapon
end

function get_lockon_tgt(vehicle)
    local alloc = memory.alloc_int()
    VEHICLE.GET_VEHICLE_LOCK_ON_TARGET(vehicle, alloc) 
    return memory.read_int(alloc)
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
    return size
end

local sink_rate = 0.0
last_z = 0.0
util.create_thread(function()
    while true do
        if player_vehicle ~= 0 then
            local c = ENTITY.GET_ENTITY_COORDS(player_vehicle)
            sink_rate = c.z - last_z 
            last_z = c.z
        end
        util.yield(300)
    end
end)

local play_sound_this_frame = false
util.create_thread(function()
    while true do
        play_sound_this_frame = not play_sound_this_frame
        util.yield(2550)
    end
end
)
-- blinking thread
local blink_this_frame = false
util.create_thread(function()
    while true do
        blink_this_frame = not blink_this_frame
        util.yield(500)
    end
end
)

-- faster blinking thread
local f_blink_this_frame = false
util.create_thread(function()
    while true do
        f_blink_this_frame = not f_blink_this_frame
        util.yield(100)
    end
end
)

function is_entity_a_projectile(hash)
    local all_projectile_hashes = {
        util.joaat("w_ex_vehiclemissile_1"),
        util.joaat("w_ex_vehiclemissile_2"),
        util.joaat("w_ex_vehiclemissile_3"),
        util.joaat("w_ex_vehiclemissile_4"),
        util.joaat("w_ex_vehiclem,tar"),
        util.joaat("w_lr_rpg_rocket"),
        util.joaat("w_lr_homing_rocket"),
        util.joaat("w_lr_firew,k_rocket"),
        util.joaat("xm_prop_x17_silo_rocket_01")
    }
    return table.contains(all_projectile_hashes, hash)
end

-- CREDIT TO NOWIRY
local function get_entity_owner(entity)
	local pEntity = entities.handle_to_pointer(entity)
	local addr = memory.read_long(pEntity + 0xD0)
	return (addr ~= 0) and memory.read_byte(addr + 0x49) or -1
end

-- projectile radar
util.create_thread(function (thr)
    local projectile_blips = {}
    while true do
        for k,b in pairs(projectile_blips) do
            if HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(b) == 0 then 
                util.remove_blip(b) 
                projectile_blips[k] = nil
            end
        end
        all_objects = entities.get_all_objects_as_handles()
        missile_nearby = false
        for k,obj in pairs(all_objects) do
            if is_entity_a_projectile(ENTITY.GET_ENTITY_MODEL(obj)) then
                local c1 = ENTITY.GET_ENTITY_COORDS(obj)
                local c2 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_vehicle, 0.0, -300.0, 0.0)
                if (MISC.GET_DISTANCE_BETWEEN_COORDS(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, true) < 300 and get_entity_owner(obj) ~= players.user()) then 
                    missile_nearby = true
                end
                if HUD.GET_BLIP_FROM_ENTITY(obj) == 0 then
                    local proj_blip = HUD.ADD_BLIP_FOR_ENTITY(obj)
                    HUD.SET_BLIP_SPRITE(proj_blip, 443)
                    HUD.SET_BLIP_COLOUR(proj_blip, 75)
                    projectile_blips[#projectile_blips + 1] = proj_blip 
                end
            end
        end
        util.yield()
    end
end)


-- mark contacts thread
util.create_thread(function()
    while true do 
        if player_vehicle ~= 0 and PED.IS_PED_IN_ANY_PLANE(players.user_ped()) or PED.IS_PED_IN_ANY_HELI(players.user_ped()) then
            all_vehicles = entities.get_all_vehicles_as_handles()
            for k,veh in pairs(all_vehicles) do
                local mdl = ENTITY.GET_ENTITY_MODEL(veh)
                if veh ~= player_vehicle and ENTITY.GET_ENTITY_HEALTH(veh) > 0 and ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(player_vehicle, veh, 17) then
                    local c = ENTITY.GET_ENTITY_COORDS(veh)
                    local draw_pos = world_to_screen_coords(c.x, c.y, c.z)
                    directx.draw_texture(contact, 0.005, 0.005, 0.5, 0.5, draw_pos.x, draw_pos.y, 0, hud_red)
                end
            end
        end
        util.yield()
    end
end)

menu.toggle(aircrafthud , "飞机HUD显示", {"aircrafthuddisplay"}, "", function(state)
    UItoggle = state
while UItoggle do 
    mst_warn = ""
    player_vehicle = entities.get_user_vehicle_as_handle()
    if player_vehicle ~= 0 then
        altitude = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(player_vehicle)
        -- if first person
        if PED.IS_PED_IN_ANY_PLANE(players.user_ped()) or PED.IS_PED_IN_ANY_HELI(players.user_ped()) then
            local size = get_model_size(ENTITY.GET_ENTITY_MODEL(player_vehicle))
            local vehicle_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_vehicle, 0.0, 10.0, (size.z / 2)-1.2)
            --local hud_pos = {x = 0.5, y = 0.5}
            local hud_pos = world_to_screen_coords(vehicle_pos.x, vehicle_pos.y, vehicle_pos.z)
            local trajectory = get_entity_trajectory(player_vehicle)
            local _2d_trajectory = world_to_screen_coords(trajectory.x, trajectory.y, trajectory.z)
            HUD.HIDE_HUD_COMPONENT_THIS_FRAME(14)
            -- trajectory
            directx.draw_texture(trajectory_icon, 0.02, 0.02, 0.0, 0.0, _2d_trajectory.x, _2d_trajectory.y, 0, hud_green)
            -- boresight
            directx.draw_texture(boresight, 0.005, 0.005, 0.0, 0.0, hud_pos.x, hud_pos.y, 0, hud_green)
            -- altimeter
            directx.draw_texture(altimeter_outline, 0.020, 0.020, 0.0, 0.0, 0.7, 0.4, 0, hud_green)
            directx.draw_text(0.71, 0.42, "ALT " .. tostring(math.ceil(altitude)), 4, 1.2, hud_green, false)
            -- gear 
            if VEHICLE.GET_LANDING_GEAR_STATE(player_vehicle) == 0 then
                directx.draw_text(0.50, 0.40, "GEAR", 5, 0.7, hud_green, false)
            end
            -- airspeed
            local knts = (ENTITY.GET_ENTITY_SPEED(player_vehicle) * 2.236936)*0.868976
            -- directional
            local ang = ENTITY.GET_ENTITY_ROTATION(player_vehicle, 0)
            directx.draw_text(0.71, 0.46, "PITCH " .. tostring(math.ceil(ang.x)), 4, 0.7, hud_green, false)
            directx.draw_text(0.71, 0.48, "ROLL " .. tostring(math.ceil(ang.Y)), 4, 0.7, hud_green, false)
            directx.draw_text(0.50, 0.80, "HDG " .. tostring(math.ceil(ang.y)), 5, 0.7, hud_green, false)
            -- mach
            directx.draw_text(0.250, 0.62, "MACH " .. tostring(math.ceil(knts * 0.00149984)), 4, 0.8, hud_green, false)
            directx.draw_texture(altimeter_outline, 0.020, 0.020, 0.0, 0.0, 0.3, 0.44, 0.5, hud_green)
            directx.draw_text(0.195, 0.42, tostring(math.ceil(knts)) .. " KMH", 4, 1.2, hud_green, false)
            wpn = get_weapon_hash(players.user_ped())
            if PAD.IS_CONTROL_JUST_RELEASED(37, 37) or mode == nil then
                if wpn == -821520672 then 
                    if lastwpn == -821520672 then
                        pluto_switch wpn do 
                            case -821520672: 
                                mode = 'GUN'
                                break 
                            default: 
                                mode = "NAV"
                        end
                    else
                        mode = "RKT (NH)"
                    end
                else
                    mode = "RKT"
                end
                lastwpn = wpn
            end
            if mode == "RKT" then 
                directx.draw_texture(circle, 0.1, 0.1, 0.5, 0.5, hud_pos.x, hud_pos.y, 0, hud_green)
                lockon_state = VEHICLE.GET_VEHICLE_HOMING_LOCKON_STATE(player_vehicle)
                -- i dont wanna usw switch here rly 
                local t_s_sc
                if lockon_state ~= 0 then 
                    local tgt = get_lockon_tgt(player_vehicle)
                    local t_c = ENTITY.GET_ENTITY_COORDS(tgt)
                    t_c_sc = world_to_screen_coords(t_c.x, t_c.y, t_c.z)
                end
                if lockon_state == 1 then 
                    if f_blink_this_frame then 
                        directx.draw_texture(circle, 0.01, 0.01, 0.5, 0.5, t_c_sc.x, t_c_sc.y, 0, hud_yellow)
                    end
                    directx.draw_text(0.61, 0.71, "LOCKING", 4, 0.8, hud_green, false)
                elseif lockon_state == 2 then
                    if blink_this_frame then
                        directx.draw_text(0.61, 0.71, "LOCKED", 4, 0.8, hud_red, false)
                    end
                    directx.draw_texture(circle, 0.01, 0.01, 0.5, 0.5, t_c_sc.x, t_c_sc.y, 0, hud_red)
                    directx.draw_line(t_c_sc.x, t_c_sc.y, 0.5, 0.5, hud_red, hud_red)
                end
            end
            directx.draw_text(0.195, 0.72, tostring(math.ceil((VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(player_vehicle)* 2.236936)*0.868976)) .. "\n" .. mode, 4, 0.8, hud_green, false)
            -- horizon line
            directx.draw_texture(line, 0.01, 0.001, 0.5, 0.0, 0.5, 0.5, (-ENTITY.GET_ENTITY_ROTATION(player_vehicle, 0).y)/360, hud_green)
            -- warnings
            if missile_nearby then 
                mst_warn = "MISSILE"
            elseif VEHICLE.GET_VEHICLE_ENGINE_HEALTH(player_vehicle) < 800 then
                mst_warn = "FIRE"
            elseif ENTITY.GET_ENTITY_HEALTH(player_vehicle)/ENTITY.GET_ENTITY_MAX_HEALTH(player_vehicle) < 0.5 then
                mst_warn = "MASTER WARN"
            elseif altitude < 50 and VEHICLE.GET_LANDING_GEAR_STATE(player_vehicle) ~= 0 and gpws then
                mst_warn = "TERRAIN"
            elseif sink_rate < -15 and gpws then
                mst_warn = "SINK RATE"
            end

            pluto_switch mst_warn do
                case "FIRE": 
                    if blink_this_frame then
                        directx.draw_text(0.5, 0.9, "FIRE", 5, 3, hud_red, false)
                    end
                    if play_sound_this_frame then
                        AUDIO.PLAY_SOUND_FRONTEND(-1, "Put_Away", "Phone_SoundSet_Michael", true)
                    end
                    break
                case "MASTER WARN":
                    directx.draw_text(0.5, 0.9, "MASTER WARN", 5, 3, hud_red, false)
                    if play_sound_this_frame then 
                        AUDIO.PLAY_SOUND_FRONTEND(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true)
                    end
                    break
                case "BOGEY LOCK-ON":
                    if f_blink_this_frame then 
                        directx.draw_text(0.5, 0.9, "BOGEY LOCK-ON", 5, 3, hud_red, false)
                    end
                    break
                case "TERRAIN":
                    if f_blink_this_frame then 
                        directx.draw_text(0.5, 0.9, "TERRAIN PULL UP", 5, 3, hud_red, false)

                    end
                    if play_sound_this_frame then 
                        PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
                    end
                    break
                case "SINK RATE":
                    directx.draw_text(0.5, 0.9, "SINK RATE", 5, 3, hud_yellow, false)
                    if play_sound_this_frame then 
                        AUDIO.PLAY_SOUND_FRONTEND(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", true)
                    end
                    break
                case "MISSILE": 
                    directx.draw_text(0.5, 0.9, "MISSILE", 5, 3, hud_red, false)
                    if play_sound_this_frame then 
                        PlaySound(sound_locationmissile, SND_FILENAME | SND_ASYNC)
                    end
            end
        end 
    end
    util.yield()
end
end)

util.keep_running() 